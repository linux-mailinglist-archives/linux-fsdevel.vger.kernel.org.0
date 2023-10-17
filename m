Return-Path: <linux-fsdevel+bounces-534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E179C7CC6E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 16:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 105881C20CFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 14:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04494447A;
	Tue, 17 Oct 2023 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hWVYzi5h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15B044460;
	Tue, 17 Oct 2023 14:59:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2454718D;
	Tue, 17 Oct 2023 07:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697554782; x=1729090782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EP/0UbPE7uEXrJMx6vOr/pEuBWUu4hYgHN1fJNowGWo=;
  b=hWVYzi5hb6yaGFaSG8CwzuFs2CtOEqMOYzrfqg7ONB+wMtGQmQ50p8IJ
   Pb+xgN0fKcHzQRse92L1NN5+JXfqf7/M9rL/hmC+ZzNnn+ua4KErYo3fN
   3/q7RyhgA7lTLVykbVRtskdZxT05W21BBtbfmiIRbrNokLOyaXrsbmHBC
   /CEJ4IImqfNEb6oc36MU0eCHGk25orM3bUI7yXO5QH3bxyfTuQvPoZ8BS
   m+XP4xuxBt7Goz6YIzG6EH0TB7fignQK4tRUFE+NJPAaSfMc+EvxAodmA
   xyh+6d9FiH+pejzMnbdAQEhHzw3z4w5famRC8qF+JP3I2DrPG4d155VqZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="383025026"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="383025026"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 07:59:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="756150986"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="756150986"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 17 Oct 2023 07:59:38 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qslXc-0009iJ-3A;
	Tue, 17 Oct 2023 14:59:31 +0000
Date: Tue, 17 Oct 2023 22:59:04 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, keescook@chromium.org,
	brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com,
	sargun@sargun.me
Subject: Re: [PATCH v8 bpf-next 10/18] bpf,lsm: refactor
 bpf_map_alloc/bpf_map_free LSM hooks
Message-ID: <202310172256.50cuKWYB-lkp@intel.com>
References: <20231016180220.3866105-11-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016180220.3866105-11-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Andrii,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bpf-align-CAP_NET_ADMIN-checks-with-bpf_capable-approach/20231017-152928
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231016180220.3866105-11-andrii%40kernel.org
patch subject: [PATCH v8 bpf-next 10/18] bpf,lsm: refactor bpf_map_alloc/bpf_map_free LSM hooks
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231017/202310172256.50cuKWYB-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310172256.50cuKWYB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310172256.50cuKWYB-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> security/security.c:5182: warning: Function parameter or member 'map' not described in 'security_bpf_map_create'
   security/security.c:5200: warning: Function parameter or member 'prog' not described in 'security_bpf_prog_load'


vim +5182 security/security.c

55e853201a9e038 Paul Moore      2023-02-16  5168  
55e853201a9e038 Paul Moore      2023-02-16  5169  /**
c44deabc68b203d Andrii Nakryiko 2023-10-16  5170   * security_bpf_map_create() - Check if BPF map creation is allowed
c44deabc68b203d Andrii Nakryiko 2023-10-16  5171   * @map BPF map object
c44deabc68b203d Andrii Nakryiko 2023-10-16  5172   * @attr: BPF syscall attributes used to create BPF map
c44deabc68b203d Andrii Nakryiko 2023-10-16  5173   * @token: BPF token used to grant user access
55e853201a9e038 Paul Moore      2023-02-16  5174   *
c44deabc68b203d Andrii Nakryiko 2023-10-16  5175   * Do a check when the kernel creates a new BPF map. This is also the
c44deabc68b203d Andrii Nakryiko 2023-10-16  5176   * point where LSM blob is allocated for LSMs that need them.
55e853201a9e038 Paul Moore      2023-02-16  5177   *
55e853201a9e038 Paul Moore      2023-02-16  5178   * Return: Returns 0 on success, error on failure.
55e853201a9e038 Paul Moore      2023-02-16  5179   */
c44deabc68b203d Andrii Nakryiko 2023-10-16  5180  int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
c44deabc68b203d Andrii Nakryiko 2023-10-16  5181  			    struct bpf_token *token)
afdb09c720b62b8 Chenbo Feng     2017-10-18 @5182  {
c44deabc68b203d Andrii Nakryiko 2023-10-16  5183  	return call_int_hook(bpf_map_create, 0, map, attr, token);
afdb09c720b62b8 Chenbo Feng     2017-10-18  5184  }
55e853201a9e038 Paul Moore      2023-02-16  5185  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

