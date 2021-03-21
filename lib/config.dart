class Config {
  final String baseUrl;

  const Config({
    required this.baseUrl,
  });
}

Config desktopConfig = Config(baseUrl: "http://apod-data.s3.amazonaws.com/upload");
Config mobileConfig = Config(baseUrl: "http://apod-data.s3.amazonaws.com/upload");