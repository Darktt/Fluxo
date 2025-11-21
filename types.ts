export interface FeatureItem {
  title: string;
  description: string;
  icon: React.ReactNode;
}

export interface LinkItem {
  label: string;
  href: string;
  external?: boolean;
}
