Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A6579F146
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 20:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjIMSmF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 14:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjIMSmE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:42:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5B1A3;
        Wed, 13 Sep 2023 11:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694630520; x=1726166520;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=efM8CDotFiLZ34XLPxPB/I5B9udJDpiuZFDvc+UHFlw=;
  b=m4kMbcoFqNEyH6RZXRlbFMZ/DBVo9FktmGZIdzjTurqcQd0IX5Ydf0vY
   p3lpGSTLYp6vxqfQ48LjVMq8xWJ3tLu3kbMbX3YGOcGuN1AHnQKqdP9xP
   WsXtYSxJ3U9qdqBlGeHuWBz9JP7VWD0nMESndTDoMyG7tSUZwc74oxJTA
   5g/JfzJMpxgOPzn2ml+lJXF3OOYKmDi8qwIloW0ZPO446ZcpIDpaB9CIV
   cPPyZiKobKNtNjiEKmMT8y/gVOpESTa3UIXorW2O19TZtqLTEOM2U30V4
   h5EEAf74sC9XUBe6VBQGjJ9siuBP8k4XsePrhU+djqDSfVDnvObDhvHYw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="377663154"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="377663154"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 11:41:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="991040388"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="991040388"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 13 Sep 2023 11:41:57 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgUoF-0000T7-0Y;
        Wed, 13 Sep 2023 18:41:55 +0000
Date:   Thu, 14 Sep 2023 02:41:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com,
        sargun@sargun.me
Subject: Re: [PATCH v4 bpf-next 06/12] bpf: take into account BPF token when
 fetching helper protos
Message-ID: <202309140202.lwVDn4bK-lkp@intel.com>
References: <20230912212906.3975866-7-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912212906.3975866-7-andrii@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andrii,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bpf-add-BPF-token-delegation-mount-options-to-BPF-FS/20230913-053240
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230912212906.3975866-7-andrii%40kernel.org
patch subject: [PATCH v4 bpf-next 06/12] bpf: take into account BPF token when fetching helper protos
config: i386-randconfig-r015-20230913 (https://download.01.org/0day-ci/archive/20230914/202309140202.lwVDn4bK-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309140202.lwVDn4bK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309140202.lwVDn4bK-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/core/filter.c:11721:7: error: call to undeclared function 'bpf_token_capable'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           if (!bpf_token_capable(prog->aux->token, CAP_PERFMON))
                ^
   1 error generated.


vim +/bpf_token_capable +11721 net/core/filter.c

 11687	
 11688	static const struct bpf_func_proto *
 11689	bpf_sk_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 11690	{
 11691		const struct bpf_func_proto *func;
 11692	
 11693		switch (func_id) {
 11694		case BPF_FUNC_skc_to_tcp6_sock:
 11695			func = &bpf_skc_to_tcp6_sock_proto;
 11696			break;
 11697		case BPF_FUNC_skc_to_tcp_sock:
 11698			func = &bpf_skc_to_tcp_sock_proto;
 11699			break;
 11700		case BPF_FUNC_skc_to_tcp_timewait_sock:
 11701			func = &bpf_skc_to_tcp_timewait_sock_proto;
 11702			break;
 11703		case BPF_FUNC_skc_to_tcp_request_sock:
 11704			func = &bpf_skc_to_tcp_request_sock_proto;
 11705			break;
 11706		case BPF_FUNC_skc_to_udp6_sock:
 11707			func = &bpf_skc_to_udp6_sock_proto;
 11708			break;
 11709		case BPF_FUNC_skc_to_unix_sock:
 11710			func = &bpf_skc_to_unix_sock_proto;
 11711			break;
 11712		case BPF_FUNC_skc_to_mptcp_sock:
 11713			func = &bpf_skc_to_mptcp_sock_proto;
 11714			break;
 11715		case BPF_FUNC_ktime_get_coarse_ns:
 11716			return &bpf_ktime_get_coarse_ns_proto;
 11717		default:
 11718			return bpf_base_func_proto(func_id, prog);
 11719		}
 11720	
 11721		if (!bpf_token_capable(prog->aux->token, CAP_PERFMON))
 11722			return NULL;
 11723	
 11724		return func;
 11725	}
 11726	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
