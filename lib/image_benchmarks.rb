require "image_benchmarks/version"
require "fileutils"
require "RMagick"
require "mini_magick"
require "image_science"

module ImageBenchmarks
  class RMagickResizer
    def resize(file, sizes)
      name = File.basename(file)
      img = Magick::Image.read(file).first
      resized_imgs = sizes.each do |w, h|
        new_img = img.resize_to_fill(w, h)
        output_dir = File.join("target", "rmagick", "#{w}x#{h}")
        FileUtils.mkdir_p(output_dir)
        output = File.join(output_dir, name)
        new_img.write(output)
      end
    end
  end

  class MinimagickResizer
    def resize(file, sizes)
      name = File.basename(file)
      sizes.each do |w, h|
        img = MiniMagick::Image.open(file)

        img.resize("#{w}x#{h}^")

        output_dir = File.join("target", "minimagick", "#{w}x#{h}")
        FileUtils.mkdir_p(output_dir)
        output = File.join(output_dir, name)
        img.write(output)
      end
    end
  end

  class ImageScienceResizer
    def resize(file, sizes)
      name = File.basename(file)
      sizes.each do |w, h|
        output_dir = File.join("target", "image_science", "#{w}x#{h}")
        FileUtils.mkdir_p(output_dir)
        big, small = w > h ? [w, h] : [h, w]
        l = ((big - w).to_f / 2).round
        r = w + ((big - w).to_f / 2).round
        t = ((big - h).to_f / 2).round
        b = h + ((big - h).to_f / 2).round

        ImageScience.with_image(file) do |img|
          output = File.join(output_dir, name)
          img.thumbnail(big) do |img2|
            img2.with_crop(l, t, r, b) do |img3|
              img3.save output
            end
          end
        end
      end
    end
  end
end
