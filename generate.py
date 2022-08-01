import json
import re


def hex_to_percentage(value: str):
	percentage = int(value, 16) / 255
	return round(percentage, 6)


def hex_to_xcode_color(value: str):
	r, g, b = value[1:3], value[3:5], value[5:7]
	r, g, b = hex_to_percentage(r), hex_to_percentage(g), hex_to_percentage(b)
	return "{} {} {} 1".format(r, g, b)


def main():
	with open("colors.json", "r") as colors_file, open("template.xccolortheme", "r") as template_file:
		themes = json.load(colors_file)
		template_lines = template_file.readlines()
		for theme_name, colors in themes.items():
			with open("catppuccin-{}.xccolortheme".format(theme_name), "w") as theme_file:
				for line in template_lines:
					key = re.search("{.*}", line)
					if key is not None:
						key = key.group(0)[1:-1]
						color = hex_to_xcode_color(colors[key])
						line = re.sub("{.*}", color, line)
					theme_file.write(line)


if __name__ == "__main__":
	main()
