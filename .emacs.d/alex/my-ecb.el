(require 'ecb-autoloads)
;(ecb-show-sources-in-directories-buffer 1)
(setq ecb-tip-of-the-day nil)
(setq ecb-layout-name "left2")


(ede-cpp-root-project "susyntupla"
                :name "susyntupla"
                :file "~/Research/Code/susyntupla_my/Makefile_local"
                :include-path '("/"
                                "/include"
				)
                :system-include-path '("~/exp/include")
                :spp-table '(("isUnix" . "")
                             ("BOOST_TEST_DYN_LINK" . "")))