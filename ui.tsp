import "@typespec/json-schema";

using JsonSchema;

@jsonSchema
model UI is Memo {
  ui: string;
  systems: System[];
}

model Memo {
  description?: string;
  todo?: string;
}

model Action is Memo {
  execute: string;
  success?: ActionResult;
  error?: ActionResult;
}

model ActionResult is Memo {
  redirect?: string;
}

model System is Memo {
  @key
  id: string;

  title: string;
  pages: Page[];
}

model Page is Memo {
  @key
  id: string;

  type: PageType;
  title: string;
  events: PageEvent;
  elements: Array<
    | ButtonElement
    | TextElement
    | TextInputElement
    | TextAreaElement
    | PasswordInputElement
    | CheckboxElement
    | RadioElement
    | SelectElement
    | FileUploadElement
    | FileDownloadElement
    | DateInputElement
    | TimeInputElement
    | ImageElement
    | IconElement
    | LinkElement
    | PaginationElement
    | TableElement>;
}

enum PageType {
  screen,
  popup,
}

model PageEvent {
  load?: string;
  unload?: string;
}

@discriminator("type")
model Element is Memo {
  @key
  id: string;

  type: ElementType;
  name: string;
  display?: ElementDisplay;
  disable?: string;
  visible?: string;
  events?: ElementEvent;
}

enum ElementType {
  button,
  text,
  textfield,
  textarea,
  password,
  radio,
  checkbox,
  select,
  fileUpload,
  fileDownload,
  date,
  time,
  table,
  pagination,
  image,
  icon,
  link,
}

model TextElement extends Element {
  type: ElementType.text;
  size?: TextSize;
  color?: Color;
}

enum TextSize {
  small,
  medium,
  large,
  xlarge,
}

enum Color {
  black,
  red,
  green,
  gray,
}

model InputElement extends Element {
  placeholder?: string;
  validations?: Validation;
  value: string;
}

model ButtonElement extends InputElement {
  type: ElementType.button;
}

model TextInputElement extends InputElement {
  type: ElementType.textfield;
}

model TextAreaElement extends InputElement {
  type: ElementType.textarea;
  rows?: integer;
}

model PasswordInputElement extends InputElement {
  type: ElementType.password;
}

model CheckboxElement extends InputElement {
  type: ElementType.checkbox;
  checked?: boolean;
}

model RadioElement extends InputElement {
  type: ElementType.radio;
  checked?: boolean;
}

model SelectElement extends InputElement {
  type: ElementType.select;
  options: SelectOption[];
}

model SelectOption {
  label: string;
  value: string;
}

model FileUploadElement extends InputElement {
  type: ElementType.fileUpload;
  accept?: string[]; // e.g. ["image/*", ".pdf"]
}

model FileDownloadElement extends Element {
  type: ElementType.fileDownload;
}

model DateInputElement extends InputElement {
  type: ElementType.date;
  format?: string; // e.g. "YYYY-MM-DD"
}

model TimeInputElement extends InputElement {
  type: ElementType.time;
  format?: string; // e.g. "HH:mm:ss"
}

model TableElement extends Element {
  type: ElementType.table;
  columns: TableColumn[];
  selectable?: boolean;
  sortable?: boolean;
}

model TableColumn {
  @key
  id: string;

  title: string;
  sortable?: boolean;
  filterable?: boolean;
  format?: string;
  description?: string;
  todo?: string;
}

model PaginationElement extends Element {
  type: ElementType.pagination;
}

model ImageElement extends Element {
  type: ElementType.image;
  src: string;
}

model IconElement extends Element {
  type: ElementType.icon;
  name: string;
  size?: string;
}

model LinkElement extends Element {
  type: ElementType.link;
  href: string; // URL the link points to
  target?: string; // e.g., "_blank" for opening in a new tab
}

model Bind {
  source: string; // $API(get, /users/me).response.name
  target: string; // $Item(item).text
}

model ElementEvent {
  click?: string;
  change?: string;
  focus?: string;
  blur?: string;
}

enum ElementDisplay {
  inline,
  block,
}

model Validation {
  required?: boolean;
  minLength?: integer;
  maxLength?: integer;
  pattern?: string; // e.g. "^[a-zA-Z0-9]+$"
  number?: boolean; // for numeric inputs
  min?: integer; // for numeric inputs
  max?: integer; // for numeric inputs
  email?: boolean; // for email validation
  url?: boolean; // for URL validation
  phone?: boolean; // for phone number validation
}

model API {
  path: string;
  method: HttpMethod;
  request: Record<string>;
  response?: Record<string>;
  success: string;
  error?: string;
  description?: string;
  todo?: string;
}

enum HttpMethod {
  GET,
  POST,
  PUT,
  PATCH,
  DELETE,
}
