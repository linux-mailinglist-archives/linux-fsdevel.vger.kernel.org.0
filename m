Return-Path: <linux-fsdevel+bounces-537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED127CC7B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 17:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C641F2331D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 15:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD687450FC;
	Tue, 17 Oct 2023 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EewtEhMo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB17450E2;
	Tue, 17 Oct 2023 15:44:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59048B0;
	Tue, 17 Oct 2023 08:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697557482; x=1729093482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XgkULBRZsTb/2jKvTsppmPErophz+plcbU7s38fli/I=;
  b=EewtEhMo0EmpB8HrDUe2ayEOEW1ac3dk+p4ipKOXp3TM170DG65GZ3ri
   tpRTy59kZ0fUsz4lyBZD0UHyRq2ndU3wxHpG3qBfA7keKwZEnFk/bd9S5
   PVbnT10wPzBhu811a87avcRyyh8lpew93gWuexEfy/p+U3VPx05IE1Pjy
   1OA81MgpA5f2xpHLUILY0h5l+J89fab5kawUtiJ84OXd2IWZPsLZvc12p
   wB6v5H/+rD2bR4QkBEyeY78ChVgCUy2Pmz2H0E3v8CWAKK34w3GVoFF4c
   EBFXnS2IS9/+VTmWwwbWWCnO3tokmO10edN8BN/Gim+eEx3pgGjoSqhNN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="472035332"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="472035332"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 08:44:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="822023718"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="822023718"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 17 Oct 2023 08:44:39 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qsmFJ-0009l1-13;
	Tue, 17 Oct 2023 15:44:37 +0000
Date: Tue, 17 Oct 2023 23:44:27 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, keescook@chromium.org,
	brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com,
	sargun@sargun.me
Subject: Re: [PATCH v8 bpf-next 11/18] bpf,lsm: add BPF token LSM hooks
Message-ID: <202310172329.EQgtSkRh-lkp@intel.com>
References: <20231016180220.3866105-12-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016180220.3866105-12-andrii@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Andrii,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bpf-align-CAP_NET_ADMIN-checks-with-bpf_capable-approach/20231017-152928
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231016180220.3866105-12-andrii%40kernel.org
patch subject: [PATCH v8 bpf-next 11/18] bpf,lsm: add BPF token LSM hooks
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231017/202310172329.EQgtSkRh-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310172329.EQgtSkRh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310172329.EQgtSkRh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   security/security.c:5182: warning: Function parameter or member 'map' not described in 'security_bpf_map_create'
   security/security.c:5200: warning: Function parameter or member 'prog' not described in 'security_bpf_prog_load'
>> security/security.c:5217: warning: Function parameter or member 'token' not described in 'security_bpf_token_create'


vim +5217 security/security.c

  5168	
  5169	/**
  5170	 * security_bpf_map_create() - Check if BPF map creation is allowed
  5171	 * @map BPF map object
  5172	 * @attr: BPF syscall attributes used to create BPF map
  5173	 * @token: BPF token used to grant user access
  5174	 *
  5175	 * Do a check when the kernel creates a new BPF map. This is also the
  5176	 * point where LSM blob is allocated for LSMs that need them.
  5177	 *
  5178	 * Return: Returns 0 on success, error on failure.
  5179	 */
  5180	int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
  5181				    struct bpf_token *token)
> 5182	{
  5183		return call_int_hook(bpf_map_create, 0, map, attr, token);
  5184	}
  5185	
  5186	/**
  5187	 * security_bpf_prog_load() - Check if loading of BPF program is allowed
  5188	 * @prog BPF program object
  5189	 * @attr: BPF syscall attributes used to create BPF program
  5190	 * @token: BPF token used to grant user access to BPF subsystem
  5191	 *
  5192	 * Do a check when the kernel allocates BPF program object and is about to
  5193	 * pass it to BPF verifier for additional correctness checks. This is also the
  5194	 * point where LSM blob is allocated for LSMs that need them.
  5195	 *
  5196	 * Return: Returns 0 on success, error on failure.
  5197	 */
  5198	int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
  5199				   struct bpf_token *token)
  5200	{
  5201		return call_int_hook(bpf_prog_load, 0, prog, attr, token);
  5202	}
  5203	
  5204	/**
  5205	 * security_bpf_token_create() - Check if creating of BPF token is allowed
  5206	 * @token BPF token object
  5207	 * @attr: BPF syscall attributes used to create BPF token
  5208	 * @path: path pointing to BPF FS mount point from which BPF token is created
  5209	 *
  5210	 * Do a check when the kernel instantiates a new BPF token object from BPF FS
  5211	 * instance. This is also the point where LSM blob can be allocated for LSMs.
  5212	 *
  5213	 * Return: Returns 0 on success, error on failure.
  5214	 */
  5215	int security_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
  5216				      struct path *path)
> 5217	{
  5218		return call_int_hook(bpf_token_create, 0, token, attr, path);
  5219	}
  5220	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

