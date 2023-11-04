Return-Path: <linux-fsdevel+bounces-1965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19CE7E0D13
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Nov 2023 02:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D090281FD7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Nov 2023 01:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F2D17CB;
	Sat,  4 Nov 2023 01:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WMJsg06/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D59915A0
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Nov 2023 01:51:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F83D49;
	Fri,  3 Nov 2023 18:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699062671; x=1730598671;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ziqVG6X6mCeCDu18zbH5MyazKyJ6S/ueq01Rl6fJZWQ=;
  b=WMJsg06/3ZJ2qw2SyVZ+JZU8Eq/oRTynk58KMzmilKkxFjChQFZTbbKi
   b5ligioG+x4jJ/tdLa96q2i4jA0p9R3yXrLen7X9yo3O+q1lG9QGqz4v/
   bBcR4Uot4D8y53CywbzL0kzd1kkxQ39I6+3dMy5xoOFWZzNWG3S2bwtCD
   OWwSH3ZOdYd/srSgJ4cvxKuzCEiMCjmu+vUulo2c0SuQX4o2nDTdwhNpo
   zj5GYD+1mCqFLrwTASdrIIPVR3AAe7jx4t3096aLn0xMPgr14JDFSHk6t
   uhRCcI6v/ZwNk6pShyW5JA+NGBP7hG9J+tHuT5aIJCVF3/5ETC+kFzYin
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="7684408"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="7684408"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 18:51:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="1008991369"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="1008991369"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 03 Nov 2023 18:51:06 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qz5oW-0003DO-1d;
	Sat, 04 Nov 2023 01:51:04 +0000
Date: Sat, 4 Nov 2023 09:50:28 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: oe-kbuild-all@lists.linux.dev, Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@chromium.org>,
	Allen Webb <allenwebb@google.com>,
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH v4 6/7] samples/landlock: Add support for
 LANDLOCK_ACCESS_FS_IOCTL
Message-ID: <202311040923.tlGduM5r-lkp@intel.com>
References: <20231103155717.78042-7-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231103155717.78042-7-gnoack@google.com>

Hi Günther,

kernel test robot noticed the following build errors:

[auto build test ERROR on f12f8f84509a084399444c4422661345a15cc713]

url:    https://github.com/intel-lab-lkp/linux/commits/G-nther-Noack/landlock-Optimize-the-number-of-calls-to-get_access_mask-slightly/20231104-000659
base:   f12f8f84509a084399444c4422661345a15cc713
patch link:    https://lore.kernel.org/r/20231103155717.78042-7-gnoack%40google.com
patch subject: [PATCH v4 6/7] samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL
config: x86_64-randconfig-011-20231104 (https://download.01.org/0day-ci/archive/20231104/202311040923.tlGduM5r-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311040923.tlGduM5r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311040923.tlGduM5r-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   samples/landlock/sandboxer.c: In function 'main':
>> samples/landlock/sandboxer.c:332:2: error: duplicate case value
     332 |  case LANDLOCK_ABI_LAST:
         |  ^~~~
   samples/landlock/sandboxer.c:322:2: note: previously used here
     322 |  case 4:
         |  ^~~~
>> samples/landlock/sandboxer.c:331:3: warning: attribute 'fallthrough' not preceding a case label or default label
     331 |   __attribute__((fallthrough));
         |   ^~~~~~~~~~~~~


vim +332 samples/landlock/sandboxer.c

903cfe8a7aa889 Mickaël Salaün       2022-09-23  209  
ba84b0bf5a164f Mickaël Salaün       2021-04-22  210  int main(const int argc, char *const argv[], char *const *const envp)
ba84b0bf5a164f Mickaël Salaün       2021-04-22  211  {
ba84b0bf5a164f Mickaël Salaün       2021-04-22  212  	const char *cmd_path;
ba84b0bf5a164f Mickaël Salaün       2021-04-22  213  	char *const *cmd_argv;
76b902f874ff4d Mickaël Salaün       2022-05-06  214  	int ruleset_fd, abi;
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  215  	char *env_port_name;
76b902f874ff4d Mickaël Salaün       2022-05-06  216  	__u64 access_fs_ro = ACCESS_FS_ROUGHLY_READ,
76b902f874ff4d Mickaël Salaün       2022-05-06  217  	      access_fs_rw = ACCESS_FS_ROUGHLY_READ | ACCESS_FS_ROUGHLY_WRITE;
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  218  
ba84b0bf5a164f Mickaël Salaün       2021-04-22  219  	struct landlock_ruleset_attr ruleset_attr = {
76b902f874ff4d Mickaël Salaün       2022-05-06  220  		.handled_access_fs = access_fs_rw,
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  221  		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  222  				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
ba84b0bf5a164f Mickaël Salaün       2021-04-22  223  	};
ba84b0bf5a164f Mickaël Salaün       2021-04-22  224  
ba84b0bf5a164f Mickaël Salaün       2021-04-22  225  	if (argc < 2) {
81709f3dccacf4 Mickaël Salaün       2022-05-06  226  		fprintf(stderr,
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  227  			"usage: %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\"%s "
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  228  			"<cmd> [args]...\n\n",
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  229  			ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  230  			ENV_TCP_CONNECT_NAME, argv[0]);
81709f3dccacf4 Mickaël Salaün       2022-05-06  231  		fprintf(stderr,
81709f3dccacf4 Mickaël Salaün       2022-05-06  232  			"Launch a command in a restricted environment.\n\n");
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  233  		fprintf(stderr,
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  234  			"Environment variables containing paths and ports "
ba84b0bf5a164f Mickaël Salaün       2021-04-22  235  			"each separated by a colon:\n");
81709f3dccacf4 Mickaël Salaün       2022-05-06  236  		fprintf(stderr,
81709f3dccacf4 Mickaël Salaün       2022-05-06  237  			"* %s: list of paths allowed to be used in a read-only way.\n",
ba84b0bf5a164f Mickaël Salaün       2021-04-22  238  			ENV_FS_RO_NAME);
81709f3dccacf4 Mickaël Salaün       2022-05-06  239  		fprintf(stderr,
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  240  			"* %s: list of paths allowed to be used in a read-write way.\n\n",
ba84b0bf5a164f Mickaël Salaün       2021-04-22  241  			ENV_FS_RW_NAME);
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  242  		fprintf(stderr,
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  243  			"Environment variables containing ports are optional "
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  244  			"and could be skipped.\n");
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  245  		fprintf(stderr,
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  246  			"* %s: list of ports allowed to bind (server).\n",
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  247  			ENV_TCP_BIND_NAME);
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  248  		fprintf(stderr,
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  249  			"* %s: list of ports allowed to connect (client).\n",
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  250  			ENV_TCP_CONNECT_NAME);
81709f3dccacf4 Mickaël Salaün       2022-05-06  251  		fprintf(stderr,
81709f3dccacf4 Mickaël Salaün       2022-05-06  252  			"\nexample:\n"
ba84b0bf5a164f Mickaël Salaün       2021-04-22  253  			"%s=\"/bin:/lib:/usr:/proc:/etc:/dev/urandom\" "
ba84b0bf5a164f Mickaël Salaün       2021-04-22  254  			"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  255  			"%s=\"9418\" "
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  256  			"%s=\"80:443\" "
903cfe8a7aa889 Mickaël Salaün       2022-09-23  257  			"%s bash -i\n\n",
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  258  			ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  259  			ENV_TCP_CONNECT_NAME, argv[0]);
903cfe8a7aa889 Mickaël Salaün       2022-09-23  260  		fprintf(stderr,
903cfe8a7aa889 Mickaël Salaün       2022-09-23  261  			"This sandboxer can use Landlock features "
903cfe8a7aa889 Mickaël Salaün       2022-09-23  262  			"up to ABI version %d.\n",
903cfe8a7aa889 Mickaël Salaün       2022-09-23  263  			LANDLOCK_ABI_LAST);
ba84b0bf5a164f Mickaël Salaün       2021-04-22  264  		return 1;
ba84b0bf5a164f Mickaël Salaün       2021-04-22  265  	}
ba84b0bf5a164f Mickaël Salaün       2021-04-22  266  
76b902f874ff4d Mickaël Salaün       2022-05-06  267  	abi = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
76b902f874ff4d Mickaël Salaün       2022-05-06  268  	if (abi < 0) {
ba84b0bf5a164f Mickaël Salaün       2021-04-22  269  		const int err = errno;
ba84b0bf5a164f Mickaël Salaün       2021-04-22  270  
76b902f874ff4d Mickaël Salaün       2022-05-06  271  		perror("Failed to check Landlock compatibility");
ba84b0bf5a164f Mickaël Salaün       2021-04-22  272  		switch (err) {
ba84b0bf5a164f Mickaël Salaün       2021-04-22  273  		case ENOSYS:
81709f3dccacf4 Mickaël Salaün       2022-05-06  274  			fprintf(stderr,
81709f3dccacf4 Mickaël Salaün       2022-05-06  275  				"Hint: Landlock is not supported by the current kernel. "
ba84b0bf5a164f Mickaël Salaün       2021-04-22  276  				"To support it, build the kernel with "
ba84b0bf5a164f Mickaël Salaün       2021-04-22  277  				"CONFIG_SECURITY_LANDLOCK=y and prepend "
ba84b0bf5a164f Mickaël Salaün       2021-04-22  278  				"\"landlock,\" to the content of CONFIG_LSM.\n");
ba84b0bf5a164f Mickaël Salaün       2021-04-22  279  			break;
ba84b0bf5a164f Mickaël Salaün       2021-04-22  280  		case EOPNOTSUPP:
81709f3dccacf4 Mickaël Salaün       2022-05-06  281  			fprintf(stderr,
81709f3dccacf4 Mickaël Salaün       2022-05-06  282  				"Hint: Landlock is currently disabled. "
ba84b0bf5a164f Mickaël Salaün       2021-04-22  283  				"It can be enabled in the kernel configuration by "
ba84b0bf5a164f Mickaël Salaün       2021-04-22  284  				"prepending \"landlock,\" to the content of CONFIG_LSM, "
ba84b0bf5a164f Mickaël Salaün       2021-04-22  285  				"or at boot time by setting the same content to the "
ba84b0bf5a164f Mickaël Salaün       2021-04-22  286  				"\"lsm\" kernel parameter.\n");
ba84b0bf5a164f Mickaël Salaün       2021-04-22  287  			break;
ba84b0bf5a164f Mickaël Salaün       2021-04-22  288  		}
ba84b0bf5a164f Mickaël Salaün       2021-04-22  289  		return 1;
ba84b0bf5a164f Mickaël Salaün       2021-04-22  290  	}
903cfe8a7aa889 Mickaël Salaün       2022-09-23  291  
76b902f874ff4d Mickaël Salaün       2022-05-06  292  	/* Best-effort security. */
903cfe8a7aa889 Mickaël Salaün       2022-09-23  293  	switch (abi) {
903cfe8a7aa889 Mickaël Salaün       2022-09-23  294  	case 1:
f6e53fb2d7bd70 Günther Noack        2022-11-07  295  		/*
f6e53fb2d7bd70 Günther Noack        2022-11-07  296  		 * Removes LANDLOCK_ACCESS_FS_REFER for ABI < 2
f6e53fb2d7bd70 Günther Noack        2022-11-07  297  		 *
f6e53fb2d7bd70 Günther Noack        2022-11-07  298  		 * Note: The "refer" operations (file renaming and linking
f6e53fb2d7bd70 Günther Noack        2022-11-07  299  		 * across different directories) are always forbidden when using
f6e53fb2d7bd70 Günther Noack        2022-11-07  300  		 * Landlock with ABI 1.
f6e53fb2d7bd70 Günther Noack        2022-11-07  301  		 *
f6e53fb2d7bd70 Günther Noack        2022-11-07  302  		 * If only ABI 1 is available, this sandboxer knowingly forbids
f6e53fb2d7bd70 Günther Noack        2022-11-07  303  		 * refer operations.
f6e53fb2d7bd70 Günther Noack        2022-11-07  304  		 *
f6e53fb2d7bd70 Günther Noack        2022-11-07  305  		 * If a program *needs* to do refer operations after enabling
f6e53fb2d7bd70 Günther Noack        2022-11-07  306  		 * Landlock, it can not use Landlock at ABI level 1.  To be
f6e53fb2d7bd70 Günther Noack        2022-11-07  307  		 * compatible with different kernel versions, such programs
f6e53fb2d7bd70 Günther Noack        2022-11-07  308  		 * should then fall back to not restrict themselves at all if
f6e53fb2d7bd70 Günther Noack        2022-11-07  309  		 * the running kernel only supports ABI 1.
f6e53fb2d7bd70 Günther Noack        2022-11-07  310  		 */
903cfe8a7aa889 Mickaël Salaün       2022-09-23  311  		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
faeb9197669c23 Günther Noack        2022-10-18  312  		__attribute__((fallthrough));
faeb9197669c23 Günther Noack        2022-10-18  313  	case 2:
faeb9197669c23 Günther Noack        2022-10-18  314  		/* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
faeb9197669c23 Günther Noack        2022-10-18  315  		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  316  		__attribute__((fallthrough));
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  317  	case 3:
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  318  		/* Removes network support for ABI < 4 */
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  319  		ruleset_attr.handled_access_net &=
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  320  			~(LANDLOCK_ACCESS_NET_BIND_TCP |
5e990dcef12eeb Konstantin Meskhidze 2023-10-26  321  			  LANDLOCK_ACCESS_NET_CONNECT_TCP);
c5aa323f1f3126 Günther Noack        2023-11-03  322  	case 4:
c5aa323f1f3126 Günther Noack        2023-11-03  323  		/* Removes LANDLOCK_ACCESS_FS_IOCTL for ABI < 5 */
c5aa323f1f3126 Günther Noack        2023-11-03  324  		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_IOCTL;
c5aa323f1f3126 Günther Noack        2023-11-03  325  
903cfe8a7aa889 Mickaël Salaün       2022-09-23  326  		fprintf(stderr,
903cfe8a7aa889 Mickaël Salaün       2022-09-23  327  			"Hint: You should update the running kernel "
903cfe8a7aa889 Mickaël Salaün       2022-09-23  328  			"to leverage Landlock features "
903cfe8a7aa889 Mickaël Salaün       2022-09-23  329  			"provided by ABI version %d (instead of %d).\n",
903cfe8a7aa889 Mickaël Salaün       2022-09-23  330  			LANDLOCK_ABI_LAST, abi);
903cfe8a7aa889 Mickaël Salaün       2022-09-23 @331  		__attribute__((fallthrough));
903cfe8a7aa889 Mickaël Salaün       2022-09-23 @332  	case LANDLOCK_ABI_LAST:

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

