Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9762117CA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 01:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfLJArj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 19:47:39 -0500
Received: from mga18.intel.com ([134.134.136.126]:16028 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbfLJArj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 19:47:39 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 16:47:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,297,1571727600"; 
   d="gz'50?scan'50,208,50";a="237942591"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 09 Dec 2019 16:47:28 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ieTgW-000IqK-4M; Tue, 10 Dec 2019 08:47:28 +0800
Date:   Tue, 10 Dec 2019 08:46:53 +0800
From:   kbuild test robot <lkp@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] fs/proc/page.c: allow inspection of last section
 and fix end detection
Message-ID: <201912100826.TgS3y0Qk%lkp@intel.com>
References: <20191209174836.11063-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mhjuqoca2d5wwu76"
Content-Disposition: inline
In-Reply-To: <20191209174836.11063-3-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--mhjuqoca2d5wwu76
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi David,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on linux/master v5.5-rc1 next-20191209]
[cannot apply to mmotm/master]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/David-Hildenbrand/mm-fix-max_pfn-not-falling-on-section-boundary/20191210-071011
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 6794862a16ef41f753abd75c03a152836e4c8028
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-7 (Debian 7.5.0-1) 7.5.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um SUBARCH=x86_64

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:19:0,
                    from ./arch/um/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from include/linux/memblock.h:13,
                    from fs/proc/page.c:2:
   fs/proc/page.c: In function 'kpagecount_read':
>> fs/proc/page.c:32:55: error: 'PAGES_PER_SECTION' undeclared (first use in this function); did you mean 'USEC_PER_SEC'?
     const unsigned long max_dump_pfn = round_up(max_pfn, PAGES_PER_SECTION);
                                                          ^
   include/linux/kernel.h:62:46: note: in definition of macro '__round_mask'
    #define __round_mask(x, y) ((__typeof__(x))((y)-1))
                                                 ^
>> fs/proc/page.c:32:37: note: in expansion of macro 'round_up'
     const unsigned long max_dump_pfn = round_up(max_pfn, PAGES_PER_SECTION);
                                        ^~~~~~~~
   fs/proc/page.c:32:55: note: each undeclared identifier is reported only once for each function it appears in
     const unsigned long max_dump_pfn = round_up(max_pfn, PAGES_PER_SECTION);
                                                          ^
   include/linux/kernel.h:62:46: note: in definition of macro '__round_mask'
    #define __round_mask(x, y) ((__typeof__(x))((y)-1))
                                                 ^
>> fs/proc/page.c:32:37: note: in expansion of macro 'round_up'
     const unsigned long max_dump_pfn = round_up(max_pfn, PAGES_PER_SECTION);
                                        ^~~~~~~~
   fs/proc/page.c: In function 'kpageflags_read':
   fs/proc/page.c:212:55: error: 'PAGES_PER_SECTION' undeclared (first use in this function); did you mean 'USEC_PER_SEC'?
     const unsigned long max_dump_pfn = round_up(max_pfn, PAGES_PER_SECTION);
                                                          ^
   include/linux/kernel.h:62:46: note: in definition of macro '__round_mask'
    #define __round_mask(x, y) ((__typeof__(x))((y)-1))
                                                 ^
   fs/proc/page.c:212:37: note: in expansion of macro 'round_up'
     const unsigned long max_dump_pfn = round_up(max_pfn, PAGES_PER_SECTION);
                                        ^~~~~~~~

vim +32 fs/proc/page.c

   > 2	#include <linux/memblock.h>
     3	#include <linux/compiler.h>
     4	#include <linux/fs.h>
     5	#include <linux/init.h>
     6	#include <linux/ksm.h>
     7	#include <linux/mm.h>
     8	#include <linux/mmzone.h>
     9	#include <linux/huge_mm.h>
    10	#include <linux/proc_fs.h>
    11	#include <linux/seq_file.h>
    12	#include <linux/hugetlb.h>
    13	#include <linux/memcontrol.h>
    14	#include <linux/mmu_notifier.h>
    15	#include <linux/page_idle.h>
    16	#include <linux/kernel-page-flags.h>
    17	#include <linux/uaccess.h>
    18	#include "internal.h"
    19	
    20	#define KPMSIZE sizeof(u64)
    21	#define KPMMASK (KPMSIZE - 1)
    22	#define KPMBITS (KPMSIZE * BITS_PER_BYTE)
    23	
    24	/* /proc/kpagecount - an array exposing page counts
    25	 *
    26	 * Each entry is a u64 representing the corresponding
    27	 * physical page count.
    28	 */
    29	static ssize_t kpagecount_read(struct file *file, char __user *buf,
    30				     size_t count, loff_t *ppos)
    31	{
  > 32		const unsigned long max_dump_pfn = round_up(max_pfn, PAGES_PER_SECTION);
    33		u64 __user *out = (u64 __user *)buf;
    34		struct page *ppage;
    35		unsigned long src = *ppos;
    36		unsigned long pfn;
    37		ssize_t ret = 0;
    38		u64 pcount;
    39	
    40		pfn = src / KPMSIZE;
    41		if (src & KPMMASK || count & KPMMASK)
    42			return -EINVAL;
    43		if (src >= max_dump_pfn * KPMSIZE)
    44			return 0;
    45		count = min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
    46	
    47		while (count > 0) {
    48			/*
    49			 * TODO: ZONE_DEVICE support requires to identify
    50			 * memmaps that were actually initialized.
    51			 */
    52			ppage = pfn_to_online_page(pfn);
    53	
    54			if (!ppage || PageSlab(ppage) || page_has_type(ppage))
    55				pcount = 0;
    56			else
    57				pcount = page_mapcount(ppage);
    58	
    59			if (put_user(pcount, out)) {
    60				ret = -EFAULT;
    61				break;
    62			}
    63	
    64			pfn++;
    65			out++;
    66			count -= KPMSIZE;
    67	
    68			cond_resched();
    69		}
    70	
    71		*ppos += (char __user *)out - buf;
    72		if (!ret)
    73			ret = (char __user *)out - buf;
    74		return ret;
    75	}
    76	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--mhjuqoca2d5wwu76
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICBLk7l0AAy5jb25maWcAnDxrc9u2st/Pr+CkM3faOTeN4yRucu74AwSCEiqSoAFSD3/h
KBKTaGpbvpLcNv/+LsAXQC6Uzp1pI2t38d43FvrpXz8F5OV8eNyc99vNw8P34Gv1VB0352oX
fNk/VP8ThCJIRR6wkOe/AnG8f3r5+83LY/Dh1w+/Xr0+bt8G8+r4VD0E9PD0Zf/1BdruD0//
+ulf8N9PAHx8hm6O/wm+brevfwt+DqvP+81T8Jtp/faX+g8gpSKN+LSktOSqnFJ6+70FwZdy
waTiIr397erD1VVHG5N02qGurC4oScuYp/O+EwDOiCqJSsqpyAWK4Cm0YSPUksi0TMh6wsoi
5SnPOYn5PQsdwpArMonZPyDm8q5cCqnnZnZoavb7IThV55fnfiMmUsxZWoq0VElmtYYuS5Yu
SiKnsMSE57dvrz+22FhQErcb8uoVBi5JYS9/UvA4LBWJc4s+ZBEp4rycCZWnJGG3r35+OjxV
v3QEakmsOam1WvCMjgD6k+ZxD8+E4qsyuStYwXDoqAmVQqkyYYmQ65LkOaEzQAJf1ehCsZhP
gv0peDqc9Rb2KFIAx9qYBj4jCwa7R2c1hR6QxHF7GnA6wenl8+n76Vw99qcxZSmTnJrDUzOx
NHOonnbB4cugybAFhc2fswVLc9WOke8fq+MJGybndA5HzmCIvN+DVJSz+5KKJIFTtRYPwAzG
ECGnyDrrVjyM2aCn/uuMT2elZArGTYA77EWN5tidlmQsyXLoyohKLeRZ8SbfnP4IztAq2EAP
p/PmfAo22+3h5em8f/o6WCI0KAmlokhznk4tblQhDCAogzMHfG6vdogrF+/Qc8+Jmquc5ArF
Zoq78Ga9/2AJZqmSFoHCDi5dl4CzJwxfS7aCE8K4UNXEdnPVtm+m5A7VKYB5/YelEubd0Qhq
T4DPZ4yEcLDI+LHQsh8BM/MIVMj7/nh5ms9BIURsSPOu3gG1/VbtXkClB1+qzfnlWJ0MuJk0
gh2oU+gfNJYl4VMpikzZEwdxp1Nk0pN43pAPm5eKzmwlGxEuSxfT9U4jVU5IGi55mM9QJpG5
3RYlaYbNeIjzWYOXYUKQhTTYCGTpnsnRYkK24JSNwMCjQ6HoGkwKbMO08lYZAZnpOytyVabW
d62oUzVQqhJAuPzwcIBqh2L5oBvYOzrPBJy31jG5kAzt0eyxsUpmLZisrBUcWchA9VCSu4c5
xJWLa/xIWUzWKEYzFWy4sazSc9i0FBnoSDDkZSSk1rrwkZCUMuxwB9QK/nBso2PgjDkqePj2
xlKDWWSv0atEBs0SsNlcH54zGmxPb+Na8ZgB/8cjG9yZAUcZ2M6CpXZYHIFNklYnE6JgxYUz
UJGz1eAr8NBg+TWYJtmKzuwRMmH3pfg0JXFkSbmZrw0wdtYGqBnokv4r4Zbrw0VZSMf8kHDB
FWu3y9oI6GRCpOT21s41yTpxWL6FlfCJnFeHNjulWTLnC+YYuSxqh0c5UZ+u8c0inFNhniwM
XZ1l1HPjo2fV8cvh+Lh52lYB+7N6AgtHQHFTbePA3tua/B+2aNe2SOrdL41Vd9gIPJeM5ODR
WqykYjJx5DguJpjoAxnsvpyy1il1GwFWK9GYK1AywNMiwXXMrIgi8M4zAh3B3oI/DPoIV3BS
RBzigCnqJrjOutmuIolfn56r7f7LfhscnnXwc+odA8BabJRYNh98MS4c7swlaGrtYkYxmYLU
FlkmpOUHak8SNN0YAe4OndetR7jOD4U4ZCJBRcJGgiq0JPD+9m0fU6VSmxl1+7Ze3OxwOgfP
x8O2Op0Ox+D8/bl2jhzT365u/hHd0SRTFEdo9YGr6wTOJ0H4oVtNZu3k6uON9iqYTEXIYKFg
UBqf5cYmid/6cbmibn+NMrp5PwSLhQtJwG4kRWJc2ogkPF7f3nTelAbCiZjZ2UFNAyZJOAbO
1lPj5g/AFGSLFHKMuJ8RseKp7Tn+8NQs7tSL6Du9eT/hubtAewtM2ASC2LigrzbH7bc3L49v
tib0P73529CXu+pLDekCxndlDNohLrNprsNkNebP2ZJBNOKKN3jxgNGBPObBQthKJYdQJFxb
+6Vj1shW3fCphG3rEjLlJjaVd5Y2B+6B+RlJKoUEr/n22mLHhGRgg/EoC1w8y2TWC6yXq27f
dSLKqFaDjpsFm68tmJZ7vTeN6KJ6B1UyrfoJ6LfNcbMFdRyE1Z/7bWXpH5XDUkCmh5uglMWP
KdhscNeItY16JkNQvh5A8hFkBVKYDGDwUYKXK2rwqy+7/1z9N/zz9pVNUOOez6dX1gwRqN40
BRYmvH3sCJGvpc4auN6JZgwd8QsgtfcV2b1uY9Pq/Nfh+Md4W/U0wOO1vOoaULJ8Br6anR1p
MTmYRQyuYo5AQ8IG0X6LWTDqs10dSYj5pS02oUTlWM8ZJZj7bU1UZraawXao73XBZa5drCQe
OSOtFdXqY3+utlopvd5Vz9AvOBhjI0olUbPhcZo0jkrKRIRNaksNsVpbNYJXglHPHc/YA2+i
VKMIwBfIzW632Q67d72+QSJDKzNLz4iwAFWnfTbjLGt/z4mParfo3TWoXKMIkL03SwAd02Rd
upwhFYvXnzenahf8UbtpoO2/7B/qTEvvrVwg66Q6LqY8NdJB6e2rr//+9ytnmTr7WtPYStsB
NlOiwfPDy9f9k+MU9JQleLvaP4T/pcjwWMyi1t6cymVBcYXoDDf0zn7AV+0q4PwSHXnY5sh4
5irR0dLV4CCdDIUB6fCO6jwJCZGza2iKVOO9jWs07gT1nO3D636UpF1u1xM2tJR8egmtGRIi
9YuDaed5CU6PUprfu/xCyRNtMfCmRQoiANZ6nUxEjJPkkict3VyHSGj2B/xfJ1hqIveJwpdl
4X1J4j74z9lU8vxyiuAetAB+VC1FPgOVkY/DB4uMJqG+ZoBYRCqG63FNtpzk/i7qrA8XRqSo
f9IdIQXx9lLpTRcZGevpbHM877XMBDm4kI5cw+xznhueCxc6EYJKgAqF6kmtOD3iDriT4OGI
dU5e9GlFyyokd7CwOnsUMhK6dzcWcr6eGAXf50UbxCS6Q3WLO16XLjC3Q6XKQDlpoQU/kdse
ZIOXMJUGfwmHtl0CBzJfYxvptu7TiGa72N/V9uW8+fxQmRu8wITvZ2vjJjyNklzbJCeb49pX
/a0MiyTrboO0DWsSypa+rPuqPfERGPQE7T0z3aXu0T5w32TNSpLq8XD8HiSbp83X6hF1DSBU
zp0gWgNKEwgCGHx9+54qi8HSZrnZQRPlvh9YY6r5EWHkbLZWwOihLPMuROqTPgqLVNtd06GD
DhJN89v3V5+6uDNlwIMQVRgnYp44rkHMQKZ0sIoKbSRFmus7ODxb6aacO/h9JgRuHu4nBa7W
7o0lFHj4rq+W6oyKTj3MfToPVmhCVe+VzBQ01ATU2Cwhco4KpJ8PrOxzy/6NRwo+zphb4ITn
zDm8GlKGnGD58yLlVvZSfwNOd07KwIate7PmMXerCKKkwqf+tbM9Z2tkPjx1Z8+zOumrPXr8
jLJOP5dgCnLPiECWpTg36cnwjF9CTrWmYEmxwnNva4juhJhzhu9F3cci515sJAp81hpJ8Csc
gwPfxI/kmRZ5zyabI7VVsA7gaNaC3Z6KMPOzgKGQZPkDCo2FTQSPV+DmXI8Of04v2duOhhYT
biW0Wl3U4m9fbV8+77ev3N6T8IPPQYTzufEdj65l0NHUWHoHNKBETZgDmiDJfNoCiOuIDPdW
sgtIYOKQUs+J67u8HMdJzxVeDhyCVxbkeJY5vvaMMJE8nGLhnYmwzPErJzRsQGhni5ik5cer
67d3KDpkFFrj84spnm0lOYnxs1tdf8C7IhnuUGcz4RueM8b0vD+890q6/741pB4HHg6DGCcU
RYuMpQu15DnF1cRC6eoMj2GCGenco19yk8yj3+vLUHzImfJr/XqmEEh4KeJ34NMoEIHyElVK
h2UOrW9QBwQm2yPBz/0BDY0JBHqYqjFabVVOCrUu3Wu6yV08MMXBuTqd29SE1T6b51OWunNo
LP6o5QBhW3dra0kiSehbFklxDsK5lUSwPunTAFE5p5jXt+SSxRBCu/UGU832b0fhVYd4qqrd
KTgfgs8VrFM7wzvtCAcJoYbAinkaiHandJ5qBpBVfcN81Y+45ADFdV00554cgT6RTx6PkvAI
R7BsVvpi6zTCNy9ToP9j3LM1hjnCcfEyL9KU4bOPCI/FwrUMZpPrxGQQHvd/1tFjn4Hcbxtw
IDpHsXfs6tvMGYvxxD+IX55k9k1DCykTnQ50bufSkMROBjGTdfcRl8mSgP9k6vBauYn2x8e/
NscqeDhsdtXRinaWJtlk5yvZCrzvrh9dxNfvSUtdV3SMl4JQ4jmgRviG8+qylCYppPMfTojX
7cukgH8lX3hGbwjYQnpcxJogB8+h6QYi6QROGzfbmoyA10lb4kyKCWZ9rcvEpuTGKYHz8Ig5
ocnLKdh1lwJdExtsh5bAtt6k/TT1Zdxy3BSKCFlLk4DC0mPmdmcSY3doLUkxCbGWANbuO1Zd
2JJQOPiuMnGAi4XI+ujfhpqA2GTNbz+Oh6VyneVC013MtYVyglmmbtmT0Nz0DMCS4M4b+ECl
ViD6BufisINRa0O3SFigXp6fD8ezzQ8OvE5p7E9bh3NaFi+SZK3TOujYEB3HQhWgJ0CQDaPi
6vh6eIFYJ4QYSEASnKz5tf0aTPnpHV3doBI/aFqXr1Z/b04Bfzqdjy+PpiDk9A2Uwi44HzdP
J00XPOyfqmAHS90/6z/tLfl/tDbNycO5Om6CKJuS4Eurh3aHv560LgoeDzpbF/x8rP73ZX+s
YIBr+kur7PnTuXoIEk6D/wqO1YOpbUc2YwF8Cf4MnhK80IW1nXQm0ObOqddVlNpDqyHWXFqL
AUidcLdlUhIe6gJoiR+9Gnl8bUEmMpClY3AVkxM51e7foGavN9K9urQMd5NA7CVGpOEgzrO5
3ZZOdleYOnm/a5wzj+CCS6RDIl/c6kMtVj6MNgse2zL1BHgwB4iAfXOn9eU7FrAXqb0L8LVc
mJ00Ve8eH2nh01BpnLjZy9oB2oOo7T+/aJZVf+3P228Bse7Hgl3nGXU880+bdD6IvvR2rsPr
i+o0FBKcA0J16toU7iPohNzbxsNGAVOkOSc4UlIcXkgh8SaULHiR4CjQmzzFm7F7OrOv6C3U
VIipU1/fo2YFWTKOovjH6w+rFY5yC4UsTELkgsUeHAeG8U7SYBVL8MmkJPfjWC5FKhJ8hSne
6OO7T1coAkJxpUv0UKSWf+1HOCovGaQSxs0kyKoiCu1S6tBeoiiIQFRhV37aOBETGcVE4qtW
gnJw5Vc4s4O3JDK1xie08LDyStcbruyV15CSrHjJQLfgOgcC3cZt9WRi1oPIrEVkma104Kt+
WzFMhjr4kOlrFc84WVtE4UUnWeZvaxLYwxovm0L425Khd+pgTQyQ51gi3RTd9CVD8YzaW6Kx
XSTkSUgZGgVSiacPDDrR11D6r5uRVtYleq9P+10VFGrSGmZDVVW7JvzXmDYRQnabZ12iNPIV
lrFda6W/dZowTHI29+By5xkVfPW+IXCbJbZ6slETCQEk7BmOpVxRgaMGKm+IkorH9lRNGReW
trcbjpSlg2QhJ96dkcR9OOjgGIn9DRXHESrH4bmH/n4d2hrNRhmDyFJjqGrX3mSLguVeJ3x+
HifHftFZpVNVBedvLZVt79shPJ6QuXxBEisteuGoa/haZoM4sx6lK7DbDevoQDrd+7VPH3Wd
obX8mE0JXXuBTRT5zirWTMupwl3FpkTap2tMoIzrizgEBjaPVJpintaRZYv69tnKVSzmAMKV
ApOcxHVNyjDQaNl7idSxt/uTxA3SDQyWaHKlfdg22ny7qe4MtqVQOXjrIq+TQKMDhGAKC5g0
GA2WLHKL+h2uqVWW4LnqmSeHnWVqNMMMHPPtw2H7BzZPQJZvP3z8WL/FHIfHtQw19lLXSXtv
rCxh2ux2plBl81APfPrV9qDH87Gmw1OaSzyNOc248OVTM7FkoIIXnodZBgsGy3P7UuN1jXHs
uWAEHz4h+LSWRF9LCPwWRLJpEQ/fU9RZ1uPm+dt+e3IOpc2uDXGdMXbqd3WmlMaEW3YFzGIp
ZpSXMc/zmJWgGjlxSmVB/pR+Z+pRakvQH547P0L1+1I+AYfE1QN1KJWQSRFZZQU9E2tXA7wg
hgrEoJ01XLECxZL5nqYVnqsMU3payzxWKNdU3iYsLVo7key3x8Pp8OUczL4/V8fXi+DrS3U6
YwfzI1KLWSVb+/QYiMzUd8c7W+oiKlQWqZEZdXg5btHIFMXbcTiPJ2KF7AmH2KKwXsc4twAG
GWSbr1VdiYRk8n5EWj8Orh4P50o/vMDmjmDrVs+Pp69oAwdRp40EDX5W5kVwIJ5Aue+ffwm6
hwGDSw7y+HD4CmB1oFj3GLpuBx3qyN/TbIytU+LHw2a3PTz62qH4Onu6yt5Ex6o6bTewo3eH
I7/zdfIjUkO7/zVZ+ToY4Qzy7mXzAFPzzh3FW8wuIM7gI2Ze6Urrv319YtguafePjtlS7ol2
KiLJPOnjlc5B4VGk+WUFPHnm0T7ZMhl7CPIu2MIsMYUywtmmQ5m8oS4Jj2PE8wAL7Dy3d5J0
+u5GE2Aq1204MIPUUzknydizIE+742G/s8cGr0kKHqLjtuSWQ+i5itV3A+ONnC11InyrXXjE
k1HDypP2wde4Vd/IpMxRHc2Fp2Qr5olPsZuYjNY3WvglRP3+EzeE7mVsc9kJklyfk2NSFxCI
hfq9YqSQWul2bUprduLcNwK3XwPCJwnvBrge8760r3MNQL/d0G+4dZ+DMd6biZl304TiblNL
pRgtvMXlhsgXfP8+CZ1x9Xcvsb56npiq0X4VknH9ZFjVS7MErwGbR/oet64h0T8rAcce4drA
GqBc6fsJlOp3Q4CiVn7UNFLek5zk0t8w5fGFptG1v6X+MQGCORBspT0HdxdbWP00oRQZxlja
KzRPd52n5omuCcj1j9oM8PZMWGquQrlHdwMFeIAcDVgjlYqcR1Z0HQ4BvAaUzS8G9N2SGoH0
eleI3ClUM4CuUMrohoigv4pgfkugodc/kjRYbY0YcXaP1+Xki7cXcNe++To/t6BD+EgZSX90
YTWo3wUj+jiT6HwI+OwDdK28Nttv7s1upJBC7tadralr8vC1FMmbcBEaldhrxPa4lPh0c3Pl
zPx3CBbdiuB7IPPMugij0YLaeeBj10GPUG8ikr9J88G8eh/CPPPwjLqAtl4xzRFBbE0FPmzt
FZyql93BPBgYbZPRVpHzIxYAmLuPGwxs9OtUGmjq2RORcpBNp05cI+mMx6Fk2AsB/X7YHtX8
8Eb/tS0V6qNtUyl02XzUNCOl2ntuUVhSycBGOuVm5sO/scjmdV3qJJfWRzD7nLk/bSEkSafM
rzhJeAEX+XGzi6gsLrzoyYXZTPyoC62oJIkHpe4KomY+Hr9gw/TvA6y8iiS5sPrMj7tLV+8v
Ym/8WHlp0OzC7/Ss1cLXrLiw3VKMkF0mpk6zeTguvWDf/6+ya+ltHEfC9/0VRp92gXQjdt6H
PtAybastSw4lxUkuhtvRJkYnduDH7GR//bKKpJ4sygvMIDOqzxRZfJeqvhrGBFMPOCRSvetT
gmjA6KFLVb7MDyP/J+cn+bbeb29vr+6+d0uueACQr+G4vFxe3NhbVQbdnAS6sbtnV0C3V+en
gOyu4TXQSa87oeK316fU6dq+39dAp1T82s4VVwMRjulV0CkquCaiJaqgu3bQ3cUJJd2d0sF3
Fyfo6e7yhDrd3tB6kqcPGPsLOxNMpZhu75RqSxQ9CFjs+UTYUKku9O8NgtaMQdDDxyDadUIP
HIOg+9og6KllEHQH5vpob0y3vTVdujmTyL9dEJ5cRmyP6ALxlHmwR1GfJDXC4xD21gKR15FU
2K+tOUhELPHbXvYk/CBoed2I8VaI4Jz4KKERvmyXvBm6MWHq200vFfW1NSpJxcQnYlQAkyZD
+yxOQx+mp2VP9KPF/L7sQl2x7SgDdrY67taHL9tHlAl/Ig5f2n6yGEx5jFbDRPiE+clpazFC
646OwVhjJgY85AO8FXvR7KmgC6t4IdRh9tcpAiPAgCuII5ZAxecV7WQl57Ygnv78Bt89wNv1
7Gv5sTwDn9fP9eZsv/x3JstZv5ytN4fsFRT7rcL39rbcvWSbaixsObR6vVkf1sv39X8NaXNu
G/ATTYakqU8Ko0zB0aH4OQLOJnQwqx3efxLcHlLiwJP0FlhbRX8hb2lGm4TVxIAhap7EVgOP
61qqUeRZlJwb8uvD3ShY+bibD1He7uvzsO2struss9113rL3z3LYhwLL5o1YmTux8rjXeA7h
QdaHFYuifi4XDLnd2rtQQ8gu1nJwn3DJ8Q9xbNctSZMxJxy6NASiOxpGl9nx9/t69f1P9tVZ
oSZf4ePyV3lt0T8XRFClFg/sy6GWcq9NLqigTaOCVDzw3tVV967RBnY8vGUbIGEHr1u+wYYA
EcZ/1oe3Dtvvt6s1igbLw9LSMs+z+5xo8cgt9sZM/tM7n0XBU/fi3L63m17iIz/u9uybg8bE
/N63hyfmuhozORMfGnro4xfej+1L1Ypm6tl3jg5vaHedMGLCOp2LKbOArrKz8EDMXeLIXbVZ
S8se3XWTW+dcUHwQutvASyJJncMAfB+aXTJe7t/oHqH8U82C0yJ/bGn4Q+332qf9NdsfGguk
J7yLnmdZ3VDgrMUjLIwuRD9gE95z9qGCOPtJViTpng+ocEo9V9vqcsosnQ7sZ/hc7P61L+cn
D+CvCyamg5aFABDEXb9A9K7sN58CcdFzlhGPmf2WV8hb3iERV13nEJEI+8XJyKducSLPG33C
hcpsbiPRvXNWYj6r1VLNyPXnW82lM1+rncORIfe/ExGmfd9dhvCcI60fRPMhddEw04JNubxg
ufdOFifOMQsAZx8P3MoY4l/nKjtmzwRXm+llFsTMPVbNVuvePinaeSMXM3m7dQ9HZ68k3Kns
ZB619ZmGaI7Y5pjcfnzusv1eXSuaXUEHFJj99JmI41fi20vnRAmenc2X4rFzZXuOk2aYp1hu
XrYfnfD48TvbabbBg72BLIz9hTcThAucUYPoj9BPzwX65ScJFy7axNIBfSGvAou2/SMHxhPP
n43bj/0IbmlLjmOcNVWnbzjv69+7pbxR7bbHw3pjPVAEfv+UnRRgaiq1oqyH7ibO7Krgyf/M
K9xgTdBpVbMfqGsHpLnlwAIu4mwaRMBUPHpsMvN52e4AvmDyRrDHWJH9+nWD5M6d1Vu2+lMj
Aj0FjvjA0T+zJsmXlvT9BPgMRFz6xGoctJAgKfEDC+Xz0A8HwFwAzudVSjUvErWkNiUFefKu
I6eEVaMe5kOogJ3nLW/hJ+mCKOuidlGWD+TKGwzrd9AqIPA93n+6tfxUSah1CSFMzOllERB9
wvQnpcTnC4/enz27OVmOX3WSpn5mP/GpaAJCRznq8RkoiizqU9ziU0by7KFMri+U+9Pgvhwd
GcBn8wpVl7hHphrLL2P5ppoTGVgYwxHRFD2rGpOlankzsxCffu7Wm8MfjC54+cj2rzb7p869
U6cCrsshOYTVjOipOGPI26PY1s0nyRsScZ+C/8hl4VMQx/DVpVFCaTGEOBFTlUE9q4rRHlK9
yinOhcAEYqWAGaDykP/K5aIfxbxsLSZ1lB8o1u/Zd0zQhKvWHqErnWHOplH1trrvmhbyEJna
pxD8gm5wRS2HQlYa3ZR+ds97l9VhMUPa6TpJbTEN5PaHBTMrL2SeGgZpPWteUKq+MUceSnDH
mLIac5WpRw2i8s5FYfBUbwQm4Kk6eKm3KPrhOVhXNQmldZCfrPaKR72eBIPs9/H1FSyjJcKH
MptRzsRfsIxir/w8/7trQ6kIKktjCL+Efsxs3jr4fMECfxTK01diY31xtqA6mlXugPoYR+7T
r4q1PS+suq3KCccfEx7GlKOfKhCANBsnFhPNQyoMF8RyLMRRSIVlqLdE/V+cMoTp4RkwW1gx
fj7RCpnyKZjtm/1kJK7i8atDCuuQFaW4exWKywME7cGqynuws7NiF6m0gvBFoGQoVwTwEwZD
RB9VCql6jG//2f1H/UNB0cGNVo1r3C6anEriO9H2c3/WCbarP8dPNbnGy81r7ewVyjkgJ3xk
dzKtyMF1OuUFf7kSwrYSpUmZJyyOhkiGixnEEpqiSAkX4zRU6fWsoPk9ESaW+3672qo+DubJ
48ozpdLvqM3KRg2PLeSyjXx0dN+AZiac1zkp1YEYrNHFIvDP/ed6g+F+Z52P4yH7O5P/kR1W
P378+FdRVfQGxrJHeIjIo45KW3n0kHv92g9hUAa0yzG0CwJ713yyxFrVIO2FzOcKJCd/NJ8x
goBE12oec2JvVABsGr2SFSBQHl5T9SnMXigWJ4duAvxI5LmzaIHzSPd/dHc+MPPsS+Uexg1Z
NnKRhmDNAf5dOj+VXhzV2uteWytHp9IiohM8vCwPyw5sVKtGfiatV59QkN5kWuQE1b4Sot+4
zwmKItxdwsUAmLbkBU+kFs/2ylpBNKn+Vk9I9QJPTJWMU1lsvNS+60JyTkjjRw8YQLSOKgQJ
RlBwYAbQ+9jm1l7K8UkvTHJJVac0YTmfVQ/UOAnkKQJZCO3TROUKSCIbeQK0obpUmUNkY2Dr
VCRwnVJpba1vk2K5uwyVcuy7ilrQHYDxHLjcHQB9gs/pjRFJJZgA2SIO2QyS69qMGHJ+yoO0
yv/GG24P5jkL5SjHTJPqB8SymcOBe88FzDNQRI6BhBKVSpNgSm92Dt7N6JE7SUPKi0jPYri8
IQnHL97gxc/BSvMEpu4mUTI06WeJ4nfFg4C3/SvbLV+zYh9FkwAexrxy2jWTokdqNXrQpA6z
ymc/wFu6WECanqmazjDadYR0oWagjsRcgnEjEVcZQkr7RR4+yJZALxt9+BrkkENqAHlTj6Zy
wSRReLGTZ72FuzBNwE/KIdWe711fuu022PAxfwR2T4dmlNlEeToRM1HjYo+wZiNgIhEJEZ6I
ALRA2M16KFcmHadcDvKA4L8DRJrWYzzL0kcmBBG2j3KIERrKwxKNEGCmx2xxDoVTlnyU+gO7
8VuN4wlBggLCB0deB9X4GMlgXV3Un7nUH8ipMI5wdbY7gqD1F1JfuVc0LM3Q2zoGFAbzONrT
MFXVByS66pEuiGpQTiPHiICs1XK/cs4ONKET664phARIGTk9Fady8wB0/LDdpTgTwVOR3jdf
qavo2vptXav/B+w3YbRAggAA

--mhjuqoca2d5wwu76--
