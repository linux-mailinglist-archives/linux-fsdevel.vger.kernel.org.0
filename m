Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6BC3CF992
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 14:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237878AbhGTLrl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 07:47:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:34012 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237804AbhGTLqh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 07:46:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="296786965"
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="gz'50?scan'50,208,50";a="296786965"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 05:27:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="gz'50?scan'50,208,50";a="661495379"
Received: from lkp-server02.sh.intel.com (HELO 1b5a72ed9419) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 20 Jul 2021 05:27:13 -0700
Received: from kbuild by 1b5a72ed9419 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m5oq9-0000Cd-1k; Tue, 20 Jul 2021 12:27:13 +0000
Date:   Tue, 20 Jul 2021 20:26:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v15 02/17] block: Add bio_for_each_folio_all()
Message-ID: <202107202022.Blri0ODW-lkp@intel.com>
References: <20210719184001.1750630-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-3-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi "Matthew,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.14-rc2 next-20210720]
[cannot apply to xfs-linux/for-next block/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Matthew-Wilcox-Oracle/Folio-support-in-block-iomap-layers/20210720-152323
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2734d6c1b1a089fb593ef6a23d4b70903526fe0c
config: i386-tinyconfig (attached as .config)
compiler: gcc-10 (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/d611eec3f37483e1acbcc299bf47e929766afc8d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Matthew-Wilcox-Oracle/Folio-support-in-block-iomap-layers/20210720-152323
        git checkout d611eec3f37483e1acbcc299bf47e929766afc8d
        # save the attached .config to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/blkdev.h:18,
                    from include/linux/blk-cgroup.h:23,
                    from include/linux/writeback.h:14,
                    from include/linux/memcontrol.h:22,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/x86/kernel/asm-offsets.c:13:
   include/linux/bio.h: In function 'bio_first_folio':
>> include/linux/bio.h:338:14: error: implicit declaration of function 'page_folio' [-Werror=implicit-function-declaration]
     338 |  fi->folio = page_folio(bvec->bv_page);
         |              ^~~~~~~~~~
>> include/linux/bio.h:338:12: warning: assignment to 'struct folio *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     338 |  fi->folio = page_folio(bvec->bv_page);
         |            ^
>> include/linux/bio.h:340:43: error: invalid use of undefined type 'struct folio'
     340 |    PAGE_SIZE * (bvec->bv_page - &fi->folio->page);
         |                                           ^~
   In file included from include/linux/kernel.h:16,
                    from include/linux/crypto.h:16,
                    from arch/x86/kernel/asm-offsets.c:9:
>> include/linux/bio.h:342:19: error: implicit declaration of function 'folio_size' [-Werror=implicit-function-declaration]
     342 |  fi->length = min(folio_size(fi->folio) - fi->offset, fi->_seg_count);
         |                   ^~~~~~~~~~
   include/linux/minmax.h:20:21: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                     ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bio.h:342:15: note: in expansion of macro 'min'
     342 |  fi->length = min(folio_size(fi->folio) - fi->offset, fi->_seg_count);
         |               ^~~
   In file included from include/linux/blkdev.h:18,
                    from include/linux/blk-cgroup.h:23,
                    from include/linux/writeback.h:14,
                    from include/linux/memcontrol.h:22,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/x86/kernel/asm-offsets.c:13:
   include/linux/bio.h: In function 'bio_next_folio':
>> include/linux/bio.h:350:15: error: implicit declaration of function 'folio_next' [-Werror=implicit-function-declaration]
     350 |   fi->folio = folio_next(fi->folio);
         |               ^~~~~~~~~~
   include/linux/bio.h:350:13: warning: assignment to 'struct folio *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     350 |   fi->folio = folio_next(fi->folio);
         |             ^
   In file included from include/linux/kernel.h:16,
                    from include/linux/crypto.h:16,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/minmax.h:20:28: warning: comparison of distinct pointer types lacks a cast
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                            ^~
   include/linux/minmax.h:26:4: note: in expansion of macro '__typecheck'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |    ^~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bio.h:352:16: note: in expansion of macro 'min'
     352 |   fi->length = min(folio_size(fi->folio), fi->_seg_count);
         |                ^~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/blkdev.h:18,
                    from include/linux/blk-cgroup.h:23,
                    from include/linux/writeback.h:14,
                    from include/linux/memcontrol.h:22,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/x86/kernel/asm-offsets.c:13:
   include/linux/bio.h: In function 'bio_first_folio':
>> include/linux/bio.h:338:14: error: implicit declaration of function 'page_folio' [-Werror=implicit-function-declaration]
     338 |  fi->folio = page_folio(bvec->bv_page);
         |              ^~~~~~~~~~
>> include/linux/bio.h:338:12: warning: assignment to 'struct folio *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     338 |  fi->folio = page_folio(bvec->bv_page);
         |            ^
>> include/linux/bio.h:340:43: error: invalid use of undefined type 'struct folio'
     340 |    PAGE_SIZE * (bvec->bv_page - &fi->folio->page);
         |                                           ^~
   In file included from include/linux/kernel.h:16,
                    from include/linux/crypto.h:16,
                    from arch/x86/kernel/asm-offsets.c:9:
>> include/linux/bio.h:342:19: error: implicit declaration of function 'folio_size' [-Werror=implicit-function-declaration]
     342 |  fi->length = min(folio_size(fi->folio) - fi->offset, fi->_seg_count);
         |                   ^~~~~~~~~~
   include/linux/minmax.h:20:21: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                     ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bio.h:342:15: note: in expansion of macro 'min'
     342 |  fi->length = min(folio_size(fi->folio) - fi->offset, fi->_seg_count);
         |               ^~~
   In file included from include/linux/blkdev.h:18,
                    from include/linux/blk-cgroup.h:23,
                    from include/linux/writeback.h:14,
                    from include/linux/memcontrol.h:22,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/x86/kernel/asm-offsets.c:13:
   include/linux/bio.h: In function 'bio_next_folio':
>> include/linux/bio.h:350:15: error: implicit declaration of function 'folio_next' [-Werror=implicit-function-declaration]
     350 |   fi->folio = folio_next(fi->folio);
         |               ^~~~~~~~~~
   include/linux/bio.h:350:13: warning: assignment to 'struct folio *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     350 |   fi->folio = folio_next(fi->folio);
         |             ^
   In file included from include/linux/kernel.h:16,
                    from include/linux/crypto.h:16,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/minmax.h:20:28: warning: comparison of distinct pointer types lacks a cast
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                            ^~
   include/linux/minmax.h:26:4: note: in expansion of macro '__typecheck'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |    ^~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bio.h:352:16: note: in expansion of macro 'min'
     352 |   fi->length = min(folio_size(fi->folio), fi->_seg_count);
         |                ^~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:117: arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1213: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:220: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/page_folio +338 include/linux/bio.h

   332	
   333	static inline
   334	void bio_first_folio(struct folio_iter *fi, struct bio *bio, int i)
   335	{
   336		struct bio_vec *bvec = bio_first_bvec_all(bio) + i;
   337	
 > 338		fi->folio = page_folio(bvec->bv_page);
   339		fi->offset = bvec->bv_offset +
 > 340				PAGE_SIZE * (bvec->bv_page - &fi->folio->page);
   341		fi->_seg_count = bvec->bv_len;
 > 342		fi->length = min(folio_size(fi->folio) - fi->offset, fi->_seg_count);
   343		fi->_i = i;
   344	}
   345	
   346	static inline void bio_next_folio(struct folio_iter *fi, struct bio *bio)
   347	{
   348		fi->_seg_count -= fi->length;
   349		if (fi->_seg_count) {
 > 350			fi->folio = folio_next(fi->folio);
   351			fi->offset = 0;
   352			fi->length = min(folio_size(fi->folio), fi->_seg_count);
   353		} else if (fi->_i + 1 < bio->bi_vcnt) {
   354			bio_first_folio(fi, bio, fi->_i + 1);
   355		} else {
   356			fi->folio = NULL;
   357		}
   358	}
   359	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--4Ckj6UjgE2iN1+kY
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICBO79mAAAy5jb25maWcAlDzbktu2ku/5ClZStZU82Jmb5zi1NQ8QCEqIeDNB6jIvLEXD
sVWZkWZ1SeyX/fbtBkgRJBuy91Sd2EY3gAbQ927ql59+8djpuHtdHTfr1cvLN+9zta32q2P1
5D1vXqr/9vzEi5PcE77M3wNyuNmevv6+uf147314f333/urdfn3jTav9tnrx+G77vPl8gumb
3fanX37iSRzIccl5OROZkklc5mKRP/z8eb1+d33l/Vr8ddoeT9711ftbWOj6pP95/b83V++v
7n6rh3+2VpGqHHP+8K0ZGrcrP1xfXd1eXZ2RQxaPz7DzMFN6jbho14ChBu3m9sPVTTMe+og6
CvwWFYZoVAtwZZHLWVyGMp62K1iDpcpZLnkHNgFimIrKcZInJEDGMFUMQHFSplkSyFCUQVyy
PM9aFJl9KudJZhExKmTo5zISZc5GMEUlWd5C80kmGJw9DhL4D6AonAqP+Ys31qzx4h2q4+mt
fd5RlkxFXMLrqii1No5lXop4VrIMrkhGMn+4vYFVGtKTKEWCc6Fyb3PwtrsjLny+04SzsLnU
n39u59mAkhV5QkzWJywVC3OcWg9O2EyUU5HFIizHj9Ki1IaMAHJDg8LHiNGQxaNrRuIC3NGA
R5Ujw51Pa9Frn7MP11RfQkDaiYuy6R9OSS6veHcJjAchNvRFwIow18xhvU0zPElUHrNIPPz8
63a3rX6z3l0t1UymnNxzznI+KT8VohAknGeJUmUkoiRbongwPiHxCiVCOSLI1k/EMtiEFaAI
gRZgwrCRCxAx73D66/DtcKxeW7kYi1hkkmsJBPEcWXJrg9QkmdvMkPkwqko1LzOhROzTsxCW
zUCDgBREiS+6Ah8kGRd+LcsyHrdQlbJMCUTST15tn7zdc+8ErRJN+FQlBaxlrthPrJX0ddgo
+k2/UZNnLJQ+y0UZMpWXfMlD4i60Rpq1V9sD6/XETMS5uggsI9BazP+zUDmBFyWqLFKkpSd/
aaLkouRpoenIlFZ8jeLUr5xvXqv9gXroyWOZwvKJr9X5mZtAKwNE+iHNlBpMQiZyPMEHrknp
4tQvNqCmcxoxSoPyT/0cmnb4Z4fw81aIV185uU13YrNHmgkRpTkcQRuj82rN+CwJizhn2ZI8
Xo1lwwxJafF7vjr87R3hbN4KCDgcV8eDt1qvd+AYbLaf2ysHyznVr8U4T2Avw+PnLVAGND+1
YJoUJclj/wApmuSMF54aMgTstywBZpME/yzFAviEsnbKINvTVTO/Jqm7lXXUqfmLS2sVsarN
PJ+AStCS0rCFWn+pnk4v1d57rlbH07466OF6RwLakf05i/NyhHoB1i3iiKVlHo7KICzUxD45
H2dJkSpaM08En6aJhJWA4fMko2XF0I7WXq9F4mQiZDTDjcIpWJiZVlCZT6MkCSimwUW2dPIy
SYGj5KNA5YryDn9ELOaCuPg+toK/dNzIJEsn4AfOWRb39FAh/et7S12DbOYhMA4Xqdb1ecb4
QHdxlU6BppDlSFQLNfxmv0UEVlaCmcvoax6LPEK9R6qElqRAXcQI4GwurWf0LKXYztoBmGFK
P1LhkOLu+em5DKxeULgoLiAwISEiTVz3IMcxCwOan/QBHTBtpxwwNQEvhYQwSbtjMimLzKXf
mD+TcO76segLhw1HLMukgyemOHEZ0XORk7TnFlDOntYSGJ+0WwApMZhhkPOOx8kjh0wr8YlY
GJYTvi/8vhwAMeXZRbDY4/qq46tqJVeHrGm1f97tX1fbdeWJf6otKHkG6o+jmgcD2+p0x+K+
AK40QLiMchbBdSU9L7XWpz+4Y7v2LDIbltqGuQQGAykGijijhUaFbOQAFJSrq8JkZB8Q58MD
ZmPReOkOxi2CAKxMygBR3wEDbe6QcAxVByxb31I3yGyoWny8L2+tuAz+bUeaKs8KrvWjLzh4
w1b8mxR5WuSl1tYQclQvz7c37zB/cQ4+0CL6Ii1VkaadUBgMJ59qhTuERZGdQ0BGj9AAZrFf
jqTxQh8+XoKzxcP1PY3QvOh31umgdZY7BwqKlb4dtJoF2LKxG2Xgc8JLBnd9lKG/7qNN7U1H
gUbPC+3tgoDB2wKvlukY3jnvSagSeZGitBjfDaKTFiEWYOIbkJZwWCrDeGFS2DmUDp5mNxLN
0CNHEI6aKAksj5IjO/LQKKpQKURZLrB2cvTFsLCcFGAgw9FgBc0bGFhglGeFJwGYOsGycMkx
ShOWZU7HxikLQcBD9XBOJdUJHcViYdgPL1FwEKXGZ0v3u3V1OOz23vHbm/FNO85bw7sOjYqC
FAiWF5koMdKmdco4Cf1AKjpKzkQORlHGtIHHDQx7gOeS0aYTccQih2vHp7xkto3cgz8vaUKN
Y5hEEiQ8g+OU2pd0mLLJEtgGDCJ4ZOOil3ZqzeHdx3tF+wIIogEfLgByRSctEBZFC0IFR/da
u7WYwKDgtUVS0gudwZfh9A03UDqbE00dB5v+xzH+kR7nWaESmmMiEQSSiySmoXMZ84lMuYOQ
GnxL+1MRKCnHumMBhmK8uL4ALUMHI/BlJhfO+55Jxm9LOh+ngY67Q7fIMQuMqVtAar1NcBJC
tTzEeBrOQFrAUssgf/hgo4TXbhh6NSloIROqqSLqGOESuLs7AK7cgk/G93f94WTWHQHLJqMi
0soiYJEMlw/3Nlx7VhD8RMrOZjPQBqi/SoB0Uw8JFwpFW4kQFCYVlcFGoKv1hVgJpmZYv2nH
yWggLPKHg5PlOImJVUCaWJENAeBHxCoSOSO3KCJOjj9OWLKQsX3SSSpyE1+QDOFHkjh7rM2l
KoEIMJgjMYY1r2kgphwHoNr1GwBgoMOKeFuppBWefvRuvGwsmuUQv+62m+Nub3I97eO2vjc+
Bij5ef/0tffoWKtLRCjGjC/BvXZobS01SRrif4TDMOUJyMqIkTD5kXbFcd1MYKoBHANXRiSS
HFgZxNV9h4p++drySioUixNMKhoXpJNnhKE7Onasofd3VGppFqk0BKN720m7taOY/yBXbVBu
6E1b8HdXuKbo0v5gEgTgaD5cfeVX5n/dO0oZlbPRrlwAvgicGWSAEZ6iTp27wVrvNFUGzMlb
SkaGyHRh455gRrwQDz3CtIYFfz5RGCFnhc740EySZzQPaEpAjv0L5kJBAOEEghuRXjAkISj8
hT4c3rL99hQGTTyB2a/jtUz4WF5fXVG5zcfy5sNVh5sfy9suam8VepkHWMbKRIiFoAxpOlkq
CXEROuUZstZ1n7MgHMKYFxnj0nwIrcYxzL/pTa+DuZmv6IvgkY8uNyYqaZ8a7lEGyzL084sJ
/UvhQzdKnKTIyxhsmuAFufrM+EZx7/6t9h4o29Xn6rXaHvVqjKfS271hB0A3IDFxFp0RiFwC
eY6tcFn7tfU2RAXBC/bV/5yq7fqbd1ivXnqGRPsaWTenZCf9idnnheXTS9Vfa1jcsdYyE84X
/93LMpWa06EZ8H5NufSq4/r9b/a+GNSPCkXcWB3uowXuFEMUbaYURy4kQUnoqLQC+9IucSzy
Dx+uaGdaK52lCkbkVTlObG5js13tv3ni9fSyajiqKzDaaWrXGuB3K7jgRWNaJAGubpg42Oxf
/13tK8/fb/4xGb82U+vT/BrILJoziKCNgDhC6GQcijPqgFfz6vN+5T03uz/p3e3yiwOhAQ/o
7rYTzDqWfiazvIC3e2R9k9K8K0jYbPHh2nJBMQ0xYddlLPtjNx/u+6N5yiBQ6DeKrPbrL5tj
tUb18u6pegPSkfNb7dDcVZ14AgcvW9p0/1lEaRmykXCk4HULDearQjS/gaOXxJREMciUmE0t
Yq2EsaDEMWbo2XEMeLCBJJdxOVJz1m8UkRCloVYk0lvTfgLIjGLChAKAh0NPMKOodwOq3hMU
sUl2iiyDgEfGfwr97x5aHMneiD6fXnGSJNMeEDUH/DuX4yIpiBq7gqdAfVd3FVCZP9DUaINM
1Z9AAK+stiQOoC8z7UMNLt1QblqTTLK3nE8k+BDSLvOfM3YQsCxjhrKuy/hmBokXJyZ93APe
3ozAxQQXp+y/MbZhga2tO5D6T5eJMUhS7JvkXc1gtULu4CnxyfWq2C/lnDiZlyO4BVMz7cEi
uQCmbsFKk9MvMCpwP4EjiyyGw8N7STtb3q+jEEyEHSqYModQzxcmN6lnUIsQ+zelkqy+Ir+I
yMduRf8yVOehczkb8psRgVKxQDRZid5S9ajpKXPA/KRwZIVlykvTTdP0qRGEKsHRUl0A1Qnz
Ts3FQFyqzMzG2wvhqfsp9n7W2NaWFuS7HleYJ6aN0pXuPiOAYErr8Dhed4YMqJ5LxK2fXmds
+/xBtG702TxBNir61T8zHPWHG50XY/iG6h+T+BgmUk+KMFwDrVzWPwBIfRMICg5yYyW+AFSE
oLHRdoAdQp7sP0sS5Hg0kO9kXl8AoQT1ZB2+dVoG2pN0qkg9BLEAnUVq5+6scz2JhwmGFEAK
uCi+tVyC7ZNyXPvstwMAa+xNP34xehPf7yLzno9YTg0r1CG73S9Do1BFyIElycFe5U0nYja3
qlQXQP3p5k27OO0JUnji25sm6utaArvuDT4Nz5bpoBDWei59/Vj3UNUGjOJSVwNJVzzryjRw
ui7HDpIZmEMBU6MTtcZr48ns3V+rQ/Xk/W1K1W/73fPmpdN4dT4bYp+7js0x2hruhZU6h8UG
7jQsxjJWnfk/5j82S+neDoWVdzsdWcskVV+ppTWHqwbdn4ApszlvhNaNCq908zXcHCiwIkak
uo2yC9c+ioFfgpFz5xn4NK7JNrA7uxcqmygH4g7Cs9VNsr4+hG7QdKNkcwrBtJuDEgObF7IU
lsEuEz9DbwU0LO32NT0f5UgE+Aea/27TqoWrcxdwWFhcnKue4mu1Ph1Xf71U+rMETyd5j51g
bSTjIMpRg9INQAaseCYdicUaI5KOgh2eAL0VMop1EagpjKrXHYSlURv8D0Kgi9nDJi0Zsbhg
nbJHm5M0MIJt68mWDjzP6X+CYPxQ7NEdF6k9AXVFmmvG01n/u57i585MpU7IZgI5s9fxYYWm
JXgMo6LTVzNVVE6o6RPX9sw0+vrZw93VH/dWZp6w9VRG3G4jmHaiZQ5uVawLYo5UHJ1PeUxd
ublHNWwL6oe+2CbQxJaEXJj6nFFAHdfgjPGIthyDuJ4hbcbp5xGZLjUBI6hBimKMZSsMqbdV
9XTwjjvvy+qfyjOGJVDA+sjvT4RxSHNhvCTbrZ7iozWu9llw3LLRSS4NiPOrfzZrO2vT8YSk
YvYdiF4OrGNweSdbhhko8qY4Z93m0TbVsVnXdHjJMPFZmB6uiQhTV8lOzPIoDRwdDjk4Qgwd
NUczlVn+nJLS374MyDxni152q6c6z9Tohzk8CvMdBbX+RDsVGCZz3VdLK8bz4ZBb/AwiNNfp
NYKYZY5mFIOAjFgvA/oEnf0L0qS7i4o8cXx2geBZEWJTz0iCbpNi6H4M3/Scn33SrNd55Ggi
+0nZToKzmWLlB2PlKADmdNIxCYgDG+9ejif5uaULVF/dqmYpYT004Ip4Bn66Or297fZHO/XY
GTcWbHNYU+eGZ4+W6IyQJIPvGyYKW43wYxXJHQ+sIA6kE8fYJrgolR8Ih0m+Ic8lBDx85B2s
kzUUaUj5xy1f3JOP1Ztap2q/rg6e3B6O+9Orbtg8fAGRePKO+9X2gHgeuLaV9wSXtHnDv3bz
uP/v2Xo6ezmCE+wF6ZhZWeDdv1uURO91h6353q9Yr9jsK9jghnfKBIJP6EpSOktZLOkW1c4z
m08EuJL1iHWfzcMBEH0VW3ioCRZzMy5jrJ3Xojw0OnL7djoOd2yrGXFaDF98sto/6QuSvyce
TunWnvDrnB+THo1qy86YRaLPZOfDUtuev6miDmKogvdfreF1KYnKc/ojBiSMhVrfDhRNczVp
JEvTe+9ogJtfqg2n/ON/bu+/luPU0WoeK+4GAmGu1vV45hJwIHZsqt7uhpacw/9TRxeGCHk/
WmtrcINr7mcXwFcswKpgR8bQBBpuvOEkE97Q8mOjW9i3tPZSKe1qqDSiAZP+50rNy6VDOUrz
1Fu/7NZ/W/Qb5ai9Ni+dLPFbR6xCgnuFH7phkVq/A7gcEQZ26PEdqso7fqm81dPTBs0gROV6
1cN7W8cNN7OIk7GzERS5qffF5Rk2p4uJuvdHf/5IR3EGjsFwSAvSZB45YpV8AmEpoyltvn8k
tIhSI7t7uH1GRfXXjyB8INFHvbjC2N3Ty3HzfNqu8e4bZfI0rFRGgQ+6FTiYdvMnOfoFSvJb
2uWA2VMRpaGjiRIXz+9v/3D0LQJYRa7ir4ZCUO/qZAFwLksW3d5+WGA3IfMd7bKI+Cla9Hu2
Gst16aIsuRfjInR+mRAJX7KSC94kUy5gERgmINiv3r5s1gdKbfjdZjJj5mHMNgP1eexh48Hv
V6+V99fp+RkUmj+0G47qOjnNeLKr9d8vm89fjt5/eSH3L5hcgGKiX2FOEb04OnuC5QhtSt2o
jUP8nZ3Pfnj/Ki3ZSoqY6nMrQBaTCZcQKed5qJsZJeskqhHj4utGDv4TkcKvTh3dDxBECZ82
y6aWJ3WksSRoFj7jTdJO8aywvi/QoMG3JxlIM2jN7kDEr+/uP15/rCEtx+fcvAhttVFpDDxz
E2BHbFQEZCsP5vMw7+taEuaZcowuMNJquEbTwd0lhIlg/U7Jmj16BFoXXix8qVLX56CFw4OZ
BS4ApqgIf7WDIBNgkbig4fi7BgNwHVit97vD7vnoTb69Vft3M+/zqTocO2J4ds4vo1phUYI6
ypVOGLu+FtTNkfXXGCXBFu36E4iRxBnX9V1hGLI4WVz+wANIBXMMHEoL1mTeZKoHN8e1v6F2
p33HJJ5zeFOV8VJ+vPlgla9gVMxyYnSEP/dSj7YOJLWDHcvIcJTQ7VASjlU4bURWve6O1dt+
t6ZsOWY3cgxDaR+TmGwWfXs9fCbXSyPV8Ci9YmemCftg81+V/tbcS7bgSm/efvMOb9V683xO
jBwaj5K9vuw+w7Da8c7+jSkjwMYC7SGSXe9eXRNJuElcLNLfg31VYZNe5X3a7eUn1yLfQ9W4
m/fRwrXAAGZ70eHmWBno6LR5eQIbe74kYqkfn6RnfTqtXuD4zvsh4baNxB/VGDDfAutwX11r
UtBzaP9DTGG54lqLDPstG+O2yJ1eoS6D0JLlUNLpfOhbYV5qDVRS2nQAs+NorDe7omwdeuhO
qSwJQyJmhDCq86MQbbRTpx8RgTwCxF/481C6gsGFM2MKkUI5TWKGvszNxdXSBStvPsYRRo60
W9PBwvWcWKZlOxxHpRj4SE0Y2Dl5LybjjkbJiI+GVzj8jIN6w0todqw/dG7Y9mm/2zzZr8Ni
P0ukTx6sQbe8E+bog+1nQUx6ao7ZvvVm+5nyr1VO28a6SX5CkkQsaQUDmDSkEyaOH9iQDkOm
Qhk58034KQP8Pe59b2UZ92L4MWbjvXXrN3WVArSj4R7LlPum9jVPMqtjs/Wtmt8WCpTpxqJl
RizQEgOOru6XiePrG93NgBguHwlWqDs6XBXPQP+gnHSk8fwLLrE0sNL5+xwBuzD7U5Hk9KNj
JSRQd6WjwmTALmiALQEOmGkCWPbAhrVX6y+9AFURJdXG0zLYRvYP1elpp6voLSu0qgTcIhc5
GsYnMvQzQb+N/u0S2tE0n3Y7oOYP4pIaRTSk2VJwUplwCXbPhcNbjh2/zlHE8v8qu5rmtm0g
eu+v8OTUg9qxE4+bSw4URckc8UMmSDPuRUNLiqpxLGskuZPk1xe7AEEA3KXdg2NHWIIkPhYL
7HtPfTKYyc1Z00WFbZvV63F3/knt2ubRA5N+icIKxqvccUUC1zcEQA3acoPFQQBzGxBAPrUQ
kH5atJ0oOtXfPV1gIRUSkX758L3ZryFEH8E/kBkZ/WyemxHkRw67/ejUfNvICnfr0W5/3myh
XUaPh28fHP2Pf5rjerMHL9o1mY3Z2MlVZdd83/3yNC1R3VAB03wVLCwCHC+k/M17MN6iNZ4C
FomzdVPl/iN5+iLEG5kAzh8e1ggHl5b3pnGyezwCo+L48nre7d0JDVESjekwkPGyyMKF9A+Q
c4MeJ1Dl0iSJMqZ0GmetCsQ4dlKaoVwNuJCmAPhoVqVjb7/uh2FhbKggXpH3cYdwB2wMaigt
Egc3bcBT4iGVkYR00wYUaDWx9E5hXDJrZRFe0XRUuK68upzENLAJiuOyWrLVfqJjOllyQ5P+
ZQlbQB8BJ/EYb8RkaYuQVgVQWZhPH0nyRncs8TeouhAdCT0ie8rGNqmPYKn3SQTCVUJB+I/A
U6alHH+z0pEs0yyqgdMpFHX0pKHMvQDZqEcSEPr640uuNZBoyacTW17FvsZhgzsFCI7uwU3R
FdVBMncR36AMxbSu9gm9Ge56x9WTgn/ip4ej9KRPmDNaP29O2z6MTf4SOYZQM5Q2McTxv1iL
uyqOyi/XBpwp4zvAjPVquLaX8XScJ4CaKgoQMSFfjH1Y5cNeng9y+fwDBf5k8LF6OqHpSn1+
pFZQBUQBZVyi15X8CAJyry4/XrudsEDaCCujBbBQlIMJBJMnjSC3I5CqEpCDTj2bUEQgCDlS
SFhZGD6vBJ9ULjSJw7fS0C5QD7X4KMCWWt5c02m6+zSJs+rrkuPB2VXWUTBvMXd0HPjeXnGw
V3qwTjaPr9stLHwW2MJJkgUzWHEeBANXMcA2Zk7jRJvPJs75OvyfuMAsGdVYyC29/IlLALO3
SOk2vINSsine9XJu7ytUe78/fUSrHd+Yet2VHXQgQKBHcLscD11OL8RIxq8zZjeDxYs8FnnG
7bbUXYpcbvACTinatLQyRri+V0FNqeyYMKDUFCTvonwMtDp2MOgml6uPJuF4l7clA++lwsdK
eADVznOguJGyAokqREq83QL3aSsv1X+qe9q/+Be+4yaKUUrcQRUM3EZjnCHyHbDq0KLcwxjA
e2eq/Yxa+tkKO6vhzsWWhz3uNEGJZqr72mKiJq3lNQ/AAejRZiUdVCkAL2CNzvLORSg4PcU6
mU+jLIwI+Gw3jXtPeeuh8zR6Vtpf5C+H0+gikbun14NytLfNfusF+XIDiqwl78iEKjeyFk4h
RjpVaatdABvK4xDS616fa8gMGSiUm3ggowWCnnT1HYnisE6khtrkN1cw1/WbPcVcvj+gNeZR
tPBcntptQb6p8/S/n+Q2FsE2o4vn1/Pmx0b+Aez4P1ERoI294TwL655hsGeyxfa5yP3wqRbW
ATvzIW9FJOL8mQ0yqoMo3rpWRiAzWS8C/2zTdfu14E5LlAE+Nb/8KKM2sZ7INn+jLuSyyKi/
jZfpe+Nd5UBECT1209K96NDWRoTTgaraCP1/jIpesFrcTZNgxkLLtb4l/QoQIQIXp8qE3C0B
JYgHD2ofqxZNxt1oLti6OTcXEMOseqqFui9iprl00PFGuRiKJVrKM90iuO5nSww3OAkex1sw
r+TfNSxk+2VlHCT9k1IQ9iajMFAMBzLUwCgDkzeHIhgV0fRddbGDAeXL7wS1I7YEynm3V+sv
JVgWvei/DYUNJ5yRXHVZ8mjkM9dN6awIFre0TasMQEoruIVIV6ZI7JSZ1i5AoWX/sZRZivkQ
WR8cXvmEUM17Q0vF3vcJ6fpCVUtXCFcwjn/K96cI0gXNjrQCPchlwbfgINUD5ZZxfP74fOOM
WOtBIuNx+v3nlSM3v//MAEKRMdU4Fyh2VDJq74ovNSAWrlfbZIx69Fygl6Zx7g8351G0nvCQ
vEicK53c5eXXz44ilVUQ0chKY1FNWPV6Y5NxHKBwEQzhqLAhUFqFPl5rtRaXU39X3s7MrI4z
aARWYtU3BHlVh1LjDhn7iKncnOD7FDDSCl/+3RybrSOzNK+4fULryn0ZFCZ1pr52hrBxA3IZ
hgOzWQ2KhfOFHgXIEaTKhcKM8wFd9gSCs2A5e8DUrkJ/RDrQwQbpHfKrg7n/APSGdZ7AawAA

--4Ckj6UjgE2iN1+kY--
