Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36033154290
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 12:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgBFLDw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 06:03:52 -0500
Received: from mga02.intel.com ([134.134.136.20]:46590 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbgBFLDw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 06:03:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 03:00:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,409,1574150400"; 
   d="gz'50?scan'50,208,50";a="220410471"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 06 Feb 2020 03:00:46 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1izetq-000Bt9-BG; Thu, 06 Feb 2020 19:00:46 +0800
Date:   Thu, 6 Feb 2020 19:00:31 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org
Subject: [vfs:merge.nfs-fs_parse.0 1/2] fs/nfs/fs_context.c:101:45: error:
 macro "__fsparam" requires 5 arguments, but only 4 given
Message-ID: <202002061921.85iCMZxM%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ee27up6z4k4n2c2k"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ee27up6z4k4n2c2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git merge.nfs-fs_parse.0
head:   c354ed1dd8f49d2308cd07ecd889962db8a7bdae
commit: 06d90a1a82614b2942e9421e646e78dfbc7d3fd2 [1/2] Merge branch 'work.fs_parse' into merge.nfs-fs_parse
config: nds32-defconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 9.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 06d90a1a82614b2942e9421e646e78dfbc7d3fd2
        # save the attached .config to linux build tree
        GCC_VERSION=9.2.0 make.cross ARCH=nds32 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

Note: the vfs/merge.nfs-fs_parse.0 HEAD c354ed1dd8f49d2308cd07ecd889962db8a7bdae builds fine.
      It only hurts bisectibility.

All error/warnings (new ones prefixed by >>):

>> fs/nfs/fs_context.c:101:45: error: macro "__fsparam" requires 5 arguments, but only 4 given
     101 |     fs_param_neg_with_no|fs_param_v_optional),
         |                                             ^
   In file included from fs/nfs/fs_context.c:16:
   include/linux/fs_parser.h:106: note: macro "__fsparam" defined here
     106 | #define __fsparam(TYPE, NAME, OPT, FLAGS, DATA) \
         | 
>> fs/nfs/fs_context.c:100:2: error: '__fsparam' undeclared here (not in a function); did you mean 'nfs_param'?
     100 |  __fsparam(fs_param_is_string, "fsc",  Opt_fscache,
         |  ^~~~~~~~~
         |  nfs_param
   fs/nfs/fs_context.c:104:45: error: macro "__fsparam" requires 5 arguments, but only 4 given
     104 |     fs_param_neg_with_no|fs_param_deprecated),
         |                                             ^
   In file included from fs/nfs/fs_context.c:16:
   include/linux/fs_parser.h:106: note: macro "__fsparam" defined here
     106 | #define __fsparam(TYPE, NAME, OPT, FLAGS, DATA) \
         | 
>> fs/nfs/fs_context.c:105:45: error: macro "fsparam_enum" requires 3 arguments, but only 2 given
     105 |  fsparam_enum  ("local_lock", Opt_local_lock),
         |                                             ^
   In file included from fs/nfs/fs_context.c:16:
   include/linux/fs_parser.h:126: note: macro "fsparam_enum" defined here
     126 | #define fsparam_enum(NAME, OPT, array) __fsparam(fs_param_is_enum, NAME, OPT, 0, array)
         | 
>> fs/nfs/fs_context.c:105:2: error: 'fsparam_enum' undeclared here (not in a function); did you mean 'fs_param_is_enum'?
     105 |  fsparam_enum  ("local_lock", Opt_local_lock),
         |  ^~~~~~~~~~~~
         |  fs_param_is_enum
   fs/nfs/fs_context.c:107:47: error: macro "fsparam_enum" requires 3 arguments, but only 2 given
     107 |  fsparam_enum  ("lookupcache", Opt_lookupcache),
         |                                               ^
   In file included from fs/nfs/fs_context.c:16:
   include/linux/fs_parser.h:126: note: macro "fsparam_enum" defined here
     126 | #define fsparam_enum(NAME, OPT, array) __fsparam(fs_param_is_enum, NAME, OPT, 0, array)
         | 
>> fs/nfs/fs_context.c:161:39: error: array type has incomplete element type 'struct fs_parameter_enum'
     161 | static const struct fs_parameter_enum nfs_param_enums[] = {
         |                                       ^~~~~~~~~~~~~~~
>> fs/nfs/fs_context.c:173:21: error: variable 'nfs_fs_parameters' has initializer but incomplete type
     173 | static const struct fs_parameter_description nfs_fs_parameters = {
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~
   fs/nfs/fs_context.c:174:3: error: 'const struct fs_parameter_description' has no member named 'name'
     174 |  .name  = "nfs",
         |   ^~~~
>> fs/nfs/fs_context.c:174:11: warning: excess elements in struct initializer
     174 |  .name  = "nfs",
         |           ^~~~~
   fs/nfs/fs_context.c:174:11: note: (near initialization for 'nfs_fs_parameters')
>> fs/nfs/fs_context.c:175:3: error: 'const struct fs_parameter_description' has no member named 'specs'
     175 |  .specs  = nfs_param_specs,
         |   ^~~~~
   fs/nfs/fs_context.c:175:12: warning: excess elements in struct initializer
     175 |  .specs  = nfs_param_specs,
         |            ^~~~~~~~~~~~~~~
   fs/nfs/fs_context.c:175:12: note: (near initialization for 'nfs_fs_parameters')
>> fs/nfs/fs_context.c:176:3: error: 'const struct fs_parameter_description' has no member named 'enums'
     176 |  .enums  = nfs_param_enums,
         |   ^~~~~
   fs/nfs/fs_context.c:176:12: warning: excess elements in struct initializer
     176 |  .enums  = nfs_param_enums,
         |            ^~~~~~~~~~~~~~~
   fs/nfs/fs_context.c:176:12: note: (near initialization for 'nfs_fs_parameters')
   fs/nfs/fs_context.c: In function 'nfs_fs_context_parse_param':
>> fs/nfs/fs_context.c:445:21: error: passing argument 2 of 'fs_parse' from incompatible pointer type [-Werror=incompatible-pointer-types]
     445 |  opt = fs_parse(fc, &nfs_fs_parameters, param, &result);
         |                     ^~~~~~~~~~~~~~~~~~
         |                     |
         |                     const struct fs_parameter_description *
   In file included from fs/nfs/fs_context.c:16:
   include/linux/fs_parser.h:69:39: note: expected 'const struct fs_parameter_spec *' but argument is of type 'const struct fs_parameter_description *'
      69 |       const struct fs_parameter_spec *desc,
         |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
   fs/nfs/fs_context.c: At top level:
>> fs/nfs/fs_context.c:1418:17: error: initialization of 'const struct fs_parameter_spec *' from incompatible pointer type 'const struct fs_parameter_description *' [-Werror=incompatible-pointer-types]
    1418 |  .parameters  = &nfs_fs_parameters,
         |                 ^
   fs/nfs/fs_context.c:1418:17: note: (near initialization for 'nfs_fs_type.parameters')
   fs/nfs/fs_context.c:1430:17: error: initialization of 'const struct fs_parameter_spec *' from incompatible pointer type 'const struct fs_parameter_description *' [-Werror=incompatible-pointer-types]
    1430 |  .parameters  = &nfs_fs_parameters,
         |                 ^
   fs/nfs/fs_context.c:1430:17: note: (near initialization for 'nfs4_fs_type.parameters')
>> fs/nfs/fs_context.c:173:46: error: storage size of 'nfs_fs_parameters' isn't known
     173 | static const struct fs_parameter_description nfs_fs_parameters = {
         |                                              ^~~~~~~~~~~~~~~~~
   fs/nfs/fs_context.c:161:39: warning: 'nfs_param_enums' defined but not used [-Wunused-variable]
     161 | static const struct fs_parameter_enum nfs_param_enums[] = {
         |                                       ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/__fsparam +101 fs/nfs/fs_context.c

9954bf92c0cddd5 David Howells   2019-12-10   85  
e38bb238ed8ce28 Scott Mayhew    2019-12-10   86  static const struct fs_parameter_spec nfs_param_specs[] = {
e38bb238ed8ce28 Scott Mayhew    2019-12-10   87  	fsparam_flag_no("ac",		Opt_ac),
e38bb238ed8ce28 Scott Mayhew    2019-12-10   88  	fsparam_u32   ("acdirmax",	Opt_acdirmax),
e38bb238ed8ce28 Scott Mayhew    2019-12-10   89  	fsparam_u32   ("acdirmin",	Opt_acdirmin),
e38bb238ed8ce28 Scott Mayhew    2019-12-10   90  	fsparam_flag_no("acl",		Opt_acl),
e38bb238ed8ce28 Scott Mayhew    2019-12-10   91  	fsparam_u32   ("acregmax",	Opt_acregmax),
e38bb238ed8ce28 Scott Mayhew    2019-12-10   92  	fsparam_u32   ("acregmin",	Opt_acregmin),
e38bb238ed8ce28 Scott Mayhew    2019-12-10   93  	fsparam_u32   ("actimeo",	Opt_actimeo),
e38bb238ed8ce28 Scott Mayhew    2019-12-10   94  	fsparam_string("addr",		Opt_addr),
e38bb238ed8ce28 Scott Mayhew    2019-12-10   95  	fsparam_flag  ("bg",		Opt_bg),
e38bb238ed8ce28 Scott Mayhew    2019-12-10   96  	fsparam_u32   ("bsize",		Opt_bsize),
e38bb238ed8ce28 Scott Mayhew    2019-12-10   97  	fsparam_string("clientaddr",	Opt_clientaddr),
e38bb238ed8ce28 Scott Mayhew    2019-12-10   98  	fsparam_flag_no("cto",		Opt_cto),
e38bb238ed8ce28 Scott Mayhew    2019-12-10   99  	fsparam_flag  ("fg",		Opt_fg),
e38bb238ed8ce28 Scott Mayhew    2019-12-10 @100  	__fsparam(fs_param_is_string, "fsc",		Opt_fscache,
e38bb238ed8ce28 Scott Mayhew    2019-12-10 @101  		  fs_param_neg_with_no|fs_param_v_optional),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  102  	fsparam_flag  ("hard",		Opt_hard),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  103  	__fsparam(fs_param_is_flag, "intr",		Opt_intr,
e38bb238ed8ce28 Scott Mayhew    2019-12-10  104  		  fs_param_neg_with_no|fs_param_deprecated),
e38bb238ed8ce28 Scott Mayhew    2019-12-10 @105  	fsparam_enum  ("local_lock",	Opt_local_lock),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  106  	fsparam_flag_no("lock",		Opt_lock),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  107  	fsparam_enum  ("lookupcache",	Opt_lookupcache),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  108  	fsparam_flag_no("migration",	Opt_migration),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  109  	fsparam_u32   ("minorversion",	Opt_minorversion),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  110  	fsparam_string("mountaddr",	Opt_mountaddr),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  111  	fsparam_string("mounthost",	Opt_mounthost),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  112  	fsparam_u32   ("mountport",	Opt_mountport),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  113  	fsparam_string("mountproto",	Opt_mountproto),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  114  	fsparam_u32   ("mountvers",	Opt_mountvers),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  115  	fsparam_u32   ("namlen",	Opt_namelen),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  116  	fsparam_u32   ("nconnect",	Opt_nconnect),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  117  	fsparam_string("nfsvers",	Opt_vers),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  118  	fsparam_u32   ("port",		Opt_port),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  119  	fsparam_flag_no("posix",	Opt_posix),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  120  	fsparam_string("proto",		Opt_proto),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  121  	fsparam_flag_no("rdirplus",	Opt_rdirplus),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  122  	fsparam_flag  ("rdma",		Opt_rdma),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  123  	fsparam_flag_no("resvport",	Opt_resvport),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  124  	fsparam_u32   ("retrans",	Opt_retrans),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  125  	fsparam_string("retry",		Opt_retry),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  126  	fsparam_u32   ("rsize",		Opt_rsize),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  127  	fsparam_string("sec",		Opt_sec),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  128  	fsparam_flag_no("sharecache",	Opt_sharecache),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  129  	fsparam_flag  ("sloppy",	Opt_sloppy),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  130  	fsparam_flag  ("soft",		Opt_soft),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  131  	fsparam_flag  ("softerr",	Opt_softerr),
c74dfe97c104bda Trond Myklebust 2020-01-06  132  	fsparam_flag  ("softreval",	Opt_softreval),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  133  	fsparam_string("source",	Opt_source),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  134  	fsparam_flag  ("tcp",		Opt_tcp),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  135  	fsparam_u32   ("timeo",		Opt_timeo),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  136  	fsparam_flag  ("udp",		Opt_udp),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  137  	fsparam_flag  ("v2",		Opt_v),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  138  	fsparam_flag  ("v3",		Opt_v),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  139  	fsparam_flag  ("v4",		Opt_v),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  140  	fsparam_flag  ("v4.0",		Opt_v),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  141  	fsparam_flag  ("v4.1",		Opt_v),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  142  	fsparam_flag  ("v4.2",		Opt_v),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  143  	fsparam_string("vers",		Opt_vers),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  144  	fsparam_u32   ("wsize",		Opt_wsize),
e38bb238ed8ce28 Scott Mayhew    2019-12-10  145  	{}
9954bf92c0cddd5 David Howells   2019-12-10  146  };
9954bf92c0cddd5 David Howells   2019-12-10  147  
9954bf92c0cddd5 David Howells   2019-12-10  148  enum {
e38bb238ed8ce28 Scott Mayhew    2019-12-10  149  	Opt_local_lock_all,
e38bb238ed8ce28 Scott Mayhew    2019-12-10  150  	Opt_local_lock_flock,
e38bb238ed8ce28 Scott Mayhew    2019-12-10  151  	Opt_local_lock_none,
e38bb238ed8ce28 Scott Mayhew    2019-12-10  152  	Opt_local_lock_posix,
9954bf92c0cddd5 David Howells   2019-12-10  153  };
9954bf92c0cddd5 David Howells   2019-12-10  154  
9954bf92c0cddd5 David Howells   2019-12-10  155  enum {
e38bb238ed8ce28 Scott Mayhew    2019-12-10  156  	Opt_lookupcache_all,
e38bb238ed8ce28 Scott Mayhew    2019-12-10  157  	Opt_lookupcache_none,
e38bb238ed8ce28 Scott Mayhew    2019-12-10  158  	Opt_lookupcache_positive,
9954bf92c0cddd5 David Howells   2019-12-10  159  };
9954bf92c0cddd5 David Howells   2019-12-10  160  
e38bb238ed8ce28 Scott Mayhew    2019-12-10 @161  static const struct fs_parameter_enum nfs_param_enums[] = {
e38bb238ed8ce28 Scott Mayhew    2019-12-10  162  	{ Opt_local_lock,	"all",		Opt_local_lock_all },
e38bb238ed8ce28 Scott Mayhew    2019-12-10  163  	{ Opt_local_lock,	"flock",	Opt_local_lock_flock },
e38bb238ed8ce28 Scott Mayhew    2019-12-10  164  	{ Opt_local_lock,	"none",		Opt_local_lock_none },
e38bb238ed8ce28 Scott Mayhew    2019-12-10  165  	{ Opt_local_lock,	"posix",	Opt_local_lock_posix },
e38bb238ed8ce28 Scott Mayhew    2019-12-10  166  	{ Opt_lookupcache,	"all",		Opt_lookupcache_all },
e38bb238ed8ce28 Scott Mayhew    2019-12-10  167  	{ Opt_lookupcache,	"none",		Opt_lookupcache_none },
e38bb238ed8ce28 Scott Mayhew    2019-12-10  168  	{ Opt_lookupcache,	"pos",		Opt_lookupcache_positive },
e38bb238ed8ce28 Scott Mayhew    2019-12-10  169  	{ Opt_lookupcache,	"positive",	Opt_lookupcache_positive },
e38bb238ed8ce28 Scott Mayhew    2019-12-10  170  	{}
e38bb238ed8ce28 Scott Mayhew    2019-12-10  171  };
9954bf92c0cddd5 David Howells   2019-12-10  172  
e38bb238ed8ce28 Scott Mayhew    2019-12-10 @173  static const struct fs_parameter_description nfs_fs_parameters = {
e38bb238ed8ce28 Scott Mayhew    2019-12-10 @174  	.name		= "nfs",
e38bb238ed8ce28 Scott Mayhew    2019-12-10 @175  	.specs		= nfs_param_specs,
e38bb238ed8ce28 Scott Mayhew    2019-12-10 @176  	.enums		= nfs_param_enums,
9954bf92c0cddd5 David Howells   2019-12-10  177  };
9954bf92c0cddd5 David Howells   2019-12-10  178  

:::::: The code at line 101 was first introduced by commit
:::::: e38bb238ed8ce280a217629294ba51dc217c5a2c NFS: Convert mount option parsing to use functionality from fs_parser.h

:::::: TO: Scott Mayhew <smayhew@redhat.com>
:::::: CC: Anna Schumaker <Anna.Schumaker@Netapp.com>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--ee27up6z4k4n2c2k
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ee27up6z4k4n2c2k--
