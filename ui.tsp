import "@typespec/json-schema";

using JsonSchema;

@jsonSchema
model UI is Note {
  @pattern("^[0-9]+\\.[0-9]+\\.[0-9]*$")
  ui: string;

  @pattern("^[0-9]+\\.[0-9]+\\.[0-9]*$")
  version?: string;

  title?: string;

  @minItems(1)
  pages: Array<Page>;
}

@pattern("^[a-zA-Z][a-zA-Z0-9_-]*$")
scalar IdString extends string;

model Binding {
  source: string;
  target: string;
}

model Parameter {
  name: string;
  required?: boolean;
  default?: string;
}

model Note {
  description?: Array<string>;
  todo?: Array<string>;
}

model Page is Note {
  @key
  id: IdString;

  type: PageType;
  title: string;
  tag?: string;
  path: string;
  pathParameters?: Array<Parameter>;
  queryParameters?: Array<Parameter>;
  events?: PageEvent;
  bindings?: Record<string>;

  @minItems(1)
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
  load?: EventHandler;
  unload?: EventHandler;
}

model EventHandler is Note {
  action: string;
  success: string;
  error?: string;
  api?: API;
}

@discriminator("type")
model Element is Note {
  @key
  id: IdString;

  type: ElementType;
  title: string;
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
  validations?: Validation;
  value?: string;
  readonly?: boolean;
}

model ButtonElement extends InputElement {
  type: ElementType.button;
}

model TextInputElement extends InputElement {
  type: ElementType.textfield;
  placeholder?: string;
}

model TextAreaElement extends InputElement {
  type: ElementType.textarea;
  rows?: integer;
  placeholder?: string;
}

model PasswordInputElement extends InputElement {
  type: ElementType.password;
  placeholder?: string;
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
  options: Array<SelectOption>;
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
  columns: Array<TableColumn>;
  selectable?: boolean;
  sortable?: boolean;
}

model TableColumn is Note {
  id: string;
  title: string;
  sortable?: boolean;
  filterable?: boolean;
  format?: string;
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
  src: string;
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
  click?: EventHandler;
  change?: EventHandler;
  focus?: EventHandler;
  blur?: EventHandler;
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

model API is Note {
  path: string;
  method: HttpMethod;
  request: Record<string>;
  response?: Record<string>;
}

enum HttpMethod {
  get,
  put,
  post,
  patch,
  delete,
}
