Return-Path: <linux-fsdevel+bounces-528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060BE7CC547
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 15:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63DD281AF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 13:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1289E43A88;
	Tue, 17 Oct 2023 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hFZSV9Ss"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20064369C;
	Tue, 17 Oct 2023 13:56:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1ECF5;
	Tue, 17 Oct 2023 06:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697550982; x=1729086982;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WcBUtEAJe/ah7+TklnC7EIaNuN0jruDSdP3tyvkNCd0=;
  b=hFZSV9SsgvWuu6FW9vOiGlPkONXLPKIhnDYWJ16OltQBlWdaC0TjPQ5g
   OC9b7RRJvRR4x/G0s8+9kzFU9o9rSUGsidKHh1xGmlJK8s5E1QyBayyil
   XByW6KGFEqVizcy1W8kPqfgMEb1SjBK+XTYILlxjvD4sE6GoKk76utYcm
   4B2wG3qmC83AxBjLgvgrgwnrLHHu8Eem6YohAfXj6W0WVlyxiVp3u6Mmf
   VOBtgMvIdM+85LkAfmlAe/6teLR1RgRqEt5EBgT47G/5olTCiC1t8Eh34
   zyLqP6xg0q7NEZy8EPR1yMcP7qoy3FNWKnOkVQzSOiXxZuFfRTVJ4EmX7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="388645428"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="388645428"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 06:56:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="826453794"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="826453794"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 17 Oct 2023 06:56:18 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qskYS-0009eV-1J;
	Tue, 17 Oct 2023 13:56:16 +0000
Date: Tue, 17 Oct 2023 21:56:01 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, keescook@chromium.org,
	brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com,
	sargun@sargun.me
Subject: Re: [PATCH v8 bpf-next 09/18] bpf,lsm: refactor
 bpf_prog_alloc/bpf_prog_free LSM hooks
Message-ID: <202310172156.zcehiHbq-lkp@intel.com>
References: <20231016180220.3866105-10-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016180220.3866105-10-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Andrii,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bpf-align-CAP_NET_ADMIN-checks-with-bpf_capable-approach/20231017-152928
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231016180220.3866105-10-andrii%40kernel.org
patch subject: [PATCH v8 bpf-next 09/18] bpf,lsm: refactor bpf_prog_alloc/bpf_prog_free LSM hooks
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231017/202310172156.zcehiHbq-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310172156.zcehiHbq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310172156.zcehiHbq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> security/security.c:5196: warning: Function parameter or member 'prog' not described in 'security_bpf_prog_load'


vim +5196 security/security.c

55e853201a9e03 Paul Moore      2023-02-16  5181  
55e853201a9e03 Paul Moore      2023-02-16  5182  /**
82c20ee03a7a4e Andrii Nakryiko 2023-10-16  5183   * security_bpf_prog_load() - Check if loading of BPF program is allowed
82c20ee03a7a4e Andrii Nakryiko 2023-10-16  5184   * @prog BPF program object
82c20ee03a7a4e Andrii Nakryiko 2023-10-16  5185   * @attr: BPF syscall attributes used to create BPF program
82c20ee03a7a4e Andrii Nakryiko 2023-10-16  5186   * @token: BPF token used to grant user access to BPF subsystem
55e853201a9e03 Paul Moore      2023-02-16  5187   *
82c20ee03a7a4e Andrii Nakryiko 2023-10-16  5188   * Do a check when the kernel allocates BPF program object and is about to
82c20ee03a7a4e Andrii Nakryiko 2023-10-16  5189   * pass it to BPF verifier for additional correctness checks. This is also the
82c20ee03a7a4e Andrii Nakryiko 2023-10-16  5190   * point where LSM blob is allocated for LSMs that need them.
55e853201a9e03 Paul Moore      2023-02-16  5191   *
55e853201a9e03 Paul Moore      2023-02-16  5192   * Return: Returns 0 on success, error on failure.
55e853201a9e03 Paul Moore      2023-02-16  5193   */
82c20ee03a7a4e Andrii Nakryiko 2023-10-16  5194  int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
82c20ee03a7a4e Andrii Nakryiko 2023-10-16  5195  			   struct bpf_token *token)
afdb09c720b62b Chenbo Feng     2017-10-18 @5196  {
82c20ee03a7a4e Andrii Nakryiko 2023-10-16  5197  	return call_int_hook(bpf_prog_load, 0, prog, attr, token);
afdb09c720b62b Chenbo Feng     2017-10-18  5198  }
55e853201a9e03 Paul Moore      2023-02-16  5199  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

