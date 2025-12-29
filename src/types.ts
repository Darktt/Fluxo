export interface FeatureItem {
  title: string;
  description: string;
  icon: string; // Raw SVG string
}

export interface LinkItem {
  label: string;
  href: string;
  external?: boolean;
}
