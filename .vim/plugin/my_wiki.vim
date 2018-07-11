" vimwiki_list configure
let main_dir = {}
let main_dir.path = '~/doc/'
let main_dir.path_html = '~/doc/html_output/'
let main_dir.diary_rel_path = '~/doc/diary/'

let TODO = {}
let TODO.path = '~/doc/todo'
let TODO.path_html = '~/doc/html_output/todo'
let TODO.diary_rel_path = '~/doc/diary/'

let Design = {}
let Design.path = '~/doc/design'
let Design.path_html = '~/doc/html_output/design'
let Design.diary_rel_path = '~/doc/diary/'

let g:vimwiki_list = [main_dir, TODO, Design]
