Return-Path: <linux-fsdevel+bounces-46840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D36A95558
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 19:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740AF1726AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 17:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6AF1E5718;
	Mon, 21 Apr 2025 17:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AhBtMure"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FC919CD1D
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745257073; cv=none; b=YuMAN50Gh1XsG/vgfUDEHE4lhqZEmlspM8Cyykd4RuoAbySZW0XLta7MBRs+Sgxbu1Linff3WMt9eoWxtMZp+m97Wzo4UprGyKwCkXRPZKFcnO+HkhIOe0yMtwHhJUL8QtxCjeOsBeMT4zBk4KdR+HLamFPSa5ePMBg/O2WZcCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745257073; c=relaxed/simple;
	bh=hooNiE6G7aVzSxlQfny0qh3eg6eQAhLJzoFCEHR1JR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vbzgwp88gUjhoqdcnHDbJyR5J9FEu0JTLIGMmDWVbRzboGunoaTrULkQcCnnzua4owbZeMMYricmf18UUUNkLGCw4bG7MB44CAPaxXT7og2hk66Zaf4+WaKUoSIBErtuAkxT0w5POSSO338m1A+Z85fSxtGGrqgeC7fxWB0g6iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AhBtMure; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745257072; x=1776793072;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hooNiE6G7aVzSxlQfny0qh3eg6eQAhLJzoFCEHR1JR4=;
  b=AhBtMureyYnaQp41mMZKQDVeEXKPgsLtujfVHUTtG335u6SH1XMXBn8d
   IQdAYeOtLnWQzh8YK+kjAFri3eELId3CUtEpwd7O7753JuadpFB6RdN4K
   Qe66GM9rTOEqPRuUXXKjP5QCgSsGjLjutn7IOrOC3Xyxd0q4FOpVEfZVS
   7fOkXbFX2W1nLCE1PgzeeMnVBIx0DbI4USureQZt6kpn/CZ9AE9naKOaV
   vGOGI9pvbrxPj5oCftebfmaxg6xUlo98GIWy7XiDqArwTjNvF6StCDiPe
   svOgCV2jstU4Ci0tlmgvJrR4wZdb3F9j1KT3bOMryxCbbAeSz+d6bQBW4
   w==;
X-CSE-ConnectionGUID: LpZzj4x/SPiqtY4HiWId0Q==
X-CSE-MsgGUID: FUqMmNToThKxInD/Cu0TmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="45917065"
X-IronPort-AV: E=Sophos;i="6.15,228,1739865600"; 
   d="scan'208";a="45917065"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 10:37:51 -0700
X-CSE-ConnectionGUID: vNevb/ajSuu3HXlb4a8tyg==
X-CSE-MsgGUID: cp6oC69sSYe/C/r9kCaF1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,228,1739865600"; 
   d="scan'208";a="136876064"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 21 Apr 2025 10:37:48 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u6v5W-0000HV-0d;
	Mon, 21 Apr 2025 17:37:46 +0000
Date: Tue, 22 Apr 2025 01:37:44 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Sandeen <sandeen@redhat.com>,
	linux-f2fs-devel@lists.sourceforge.net
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	jaegeuk@kernel.org, chao@kernel.org, lihongbo22@huawei.com,
	Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH 5/7] f2fs: separate the options parsing and options
 checking
Message-ID: <202504220139.19wajgtO-lkp@intel.com>
References: <20250420154647.1233033-6-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250420154647.1233033-6-sandeen@redhat.com>

Hi Eric,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.15-rc3]
[also build test ERROR on linus/master]
[cannot apply to jaegeuk-f2fs/dev-test jaegeuk-f2fs/dev next-20250417]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Sandeen/f2fs-Add-fs-parameter-specifications-for-mount-options/20250421-220156
base:   v6.15-rc3
patch link:    https://lore.kernel.org/r/20250420154647.1233033-6-sandeen%40redhat.com
patch subject: [PATCH 5/7] f2fs: separate the options parsing and options checking
config: i386-buildonly-randconfig-005-20250421 (https://download.01.org/0day-ci/archive/20250422/202504220139.19wajgtO-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250422/202504220139.19wajgtO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504220139.19wajgtO-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/printk.h:7,
                    from include/linux/kernel.h:31,
                    from include/linux/cpumask.h:11,
                    from arch/x86/include/asm/cpumask.h:5,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/tsc.h:10,
                    from arch/x86/include/asm/timex.h:6,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from fs/f2fs/super.c:8:
   fs/f2fs/super.c: In function 'handle_mount_opt':
   include/linux/kern_levels.h:5:25: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'unsigned int' [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
         |                         ^~~~~~~~
   fs/f2fs/f2fs.h:1871:33: note: in expansion of macro 'KERN_ERR'
    1871 |         f2fs_printk(sbi, false, KERN_ERR fmt, ##__VA_ARGS__)
         |                                 ^~~~~~~~
   fs/f2fs/super.c:763:25: note: in expansion of macro 'f2fs_err'
     763 |                         f2fs_err(NULL, "inline xattr size is out of range: %lu ~ %lu",
         |                         ^~~~~~~~
   fs/f2fs/super.c: In function 'f2fs_check_quota_consistency':
>> fs/f2fs/super.c:1285:27: error: 'sbi' undeclared (first use in this function); did you mean 'sb'?
    1285 |         if (f2fs_readonly(sbi->sb))
         |                           ^~~
         |                           sb
   fs/f2fs/super.c:1285:27: note: each undeclared identifier is reported only once for each function it appears in


vim +1285 fs/f2fs/super.c

  1182	
  1183	/*
  1184	 * Check quota settings consistency.
  1185	 */
  1186	static int f2fs_check_quota_consistency(struct fs_context *fc,
  1187						struct super_block *sb)
  1188	{
  1189	 #ifdef CONFIG_QUOTA
  1190		struct f2fs_fs_context *ctx = fc->fs_private;
  1191		struct f2fs_sb_info *sbi = F2FS_SB(sb);
  1192		bool quota_feature = f2fs_sb_has_quota_ino(sbi);
  1193		bool quota_turnon = sb_any_quota_loaded(sb);
  1194		char *old_qname, *new_qname;
  1195		bool usr_qf_name, grp_qf_name, prj_qf_name, usrquota, grpquota, prjquota;
  1196		int i;
  1197	
  1198		/*
  1199		 * We do the test below only for project quotas. 'usrquota' and
  1200		 * 'grpquota' mount options are allowed even without quota feature
  1201		 * to support legacy quotas in quota files.
  1202		 */
  1203		if (ctx_test_opt(ctx, F2FS_MOUNT_PRJQUOTA) &&
  1204				!f2fs_sb_has_project_quota(sbi)) {
  1205			f2fs_err(sbi, "Project quota feature not enabled. Cannot enable project quota enforcement.");
  1206			return -EINVAL;
  1207		}
  1208	
  1209		if (ctx->qname_mask) {
  1210			for (i = 0; i < MAXQUOTAS; i++) {
  1211				if (!(ctx->qname_mask & (1 << i)))
  1212					continue;
  1213	
  1214				old_qname = F2FS_OPTION(sbi).s_qf_names[i];
  1215				new_qname = F2FS_CTX_INFO(ctx).s_qf_names[i];
  1216				if (quota_turnon &&
  1217					!!old_qname != !!new_qname)
  1218					goto err_jquota_change;
  1219	
  1220				if (old_qname) {
  1221					if (strcmp(old_qname, new_qname) == 0) {
  1222						ctx->qname_mask &= ~(1 << i);
  1223						continue;
  1224					}
  1225					goto err_jquota_specified;
  1226				}
  1227	
  1228				if (quota_feature) {
  1229					f2fs_info(sbi, "QUOTA feature is enabled, so ignore qf_name");
  1230					ctx->qname_mask &= ~(1 << i);
  1231					kfree(F2FS_CTX_INFO(ctx).s_qf_names[i]);
  1232					F2FS_CTX_INFO(ctx).s_qf_names[i] = NULL;
  1233				}
  1234			}
  1235		}
  1236	
  1237		/* Make sure we don't mix old and new quota format */
  1238		usr_qf_name = F2FS_OPTION(sbi).s_qf_names[USRQUOTA] ||
  1239				F2FS_CTX_INFO(ctx).s_qf_names[USRQUOTA];
  1240		grp_qf_name = F2FS_OPTION(sbi).s_qf_names[GRPQUOTA] ||
  1241				F2FS_CTX_INFO(ctx).s_qf_names[GRPQUOTA];
  1242		prj_qf_name = F2FS_OPTION(sbi).s_qf_names[PRJQUOTA] ||
  1243				F2FS_CTX_INFO(ctx).s_qf_names[PRJQUOTA];
  1244		usrquota = test_opt(sbi, USRQUOTA) ||
  1245				ctx_test_opt(ctx, F2FS_MOUNT_USRQUOTA);
  1246		grpquota = test_opt(sbi, GRPQUOTA) ||
  1247				ctx_test_opt(ctx, F2FS_MOUNT_GRPQUOTA);
  1248		prjquota = test_opt(sbi, PRJQUOTA) ||
  1249				ctx_test_opt(ctx, F2FS_MOUNT_PRJQUOTA);
  1250	
  1251		if (usr_qf_name) {
  1252			ctx_clear_opt(ctx, F2FS_MOUNT_USRQUOTA);
  1253			usrquota = false;
  1254		}
  1255		if (grp_qf_name) {
  1256			ctx_clear_opt(ctx, F2FS_MOUNT_GRPQUOTA);
  1257			grpquota = false;
  1258		}
  1259		if (prj_qf_name) {
  1260			ctx_clear_opt(ctx, F2FS_MOUNT_PRJQUOTA);
  1261			prjquota = false;
  1262		}
  1263		if (usr_qf_name || grp_qf_name || prj_qf_name) {
  1264			if (grpquota || usrquota || prjquota) {
  1265				f2fs_err(sbi, "old and new quota format mixing");
  1266				return -EINVAL;
  1267			}
  1268			if (!(ctx->spec_mask & F2FS_SPEC_jqfmt ||
  1269					F2FS_OPTION(sbi).s_jquota_fmt)) {
  1270				f2fs_err(sbi, "journaled quota format not specified");
  1271				return -EINVAL;
  1272			}
  1273		}
  1274		return 0;
  1275	
  1276	err_jquota_change:
  1277		f2fs_err(sbi, "Cannot change journaled quota options when quota turned on");
  1278		return -EINVAL;
  1279	err_jquota_specified:
  1280		f2fs_err(sbi, "%s quota file already specified",
  1281			 QTYPE2NAME(i));
  1282		return -EINVAL;
  1283	
  1284	#else
> 1285		if (f2fs_readonly(sbi->sb))
  1286			return 0;
  1287		if (f2fs_sb_has_quota_ino(sbi)) {
  1288			f2fs_info(sbi, "Filesystem with quota feature cannot be mounted RDWR without CONFIG_QUOTA");
  1289			return -EINVAL;
  1290		}
  1291		if (f2fs_sb_has_project_quota(sbi)) {
  1292			f2fs_err(sbi, "Filesystem with project quota feature cannot be mounted RDWR without CONFIG_QUOTA");
  1293			return -EINVAL;
  1294		}
  1295	
  1296		return 0;
  1297	#endif
  1298	}
  1299	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

