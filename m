Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B60A79E413
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 11:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbjIMJqb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 05:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjIMJq2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:46:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CCE199E;
        Wed, 13 Sep 2023 02:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694598384; x=1726134384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S0U1sJQmWgIOy7aN4TQkzxQY5zUz0O3HFLs3l1IT65o=;
  b=Z73vORS4r7aFus1jYIalJeAp2YdmpBZQOJcPSu6CWRNpGA3l706Ni7YL
   8E2hDTwKxKqzK8pEU6FBNoSvkKzgqhrtqAOVv0/Vh9cE9B+I0TiET7dDl
   k1a0SuKToc9eEnI4P8eDsoRqfT/mfcKaxNNlDKVYdbdUns0VK+hq1zQ8+
   oaOKGdm70hvvjP7lXPe92TXiHaqQPlT5QwgbvDyhPfay3HVtxu8YUWwAJ
   pkkJACc9iarQyhqPXG4ecvjdElbJ+cCSsayRYztVhrnn4fJ+E1bXxK+gk
   djU17aULKsI+f9KhYMrs5/BXPA7cmAP4Sfo2eBB1asExuM0LDbZ4v9w5e
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="382420818"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="382420818"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 02:46:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="814156788"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="814156788"
Received: from lkp-server02.sh.intel.com (HELO cf13c67269a2) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 13 Sep 2023 02:46:19 -0700
Received: from kbuild by cf13c67269a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgMRt-0000Lc-23;
        Wed, 13 Sep 2023 09:46:17 +0000
Date:   Wed, 13 Sep 2023 17:45:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com,
        sargun@sargun.me
Subject: Re: [PATCH v4 bpf-next 06/12] bpf: take into account BPF token when
 fetching helper protos
Message-ID: <202309131744.fLl0eeCO-lkp@intel.com>
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
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20230913/202309131744.fLl0eeCO-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309131744.fLl0eeCO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309131744.fLl0eeCO-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/core/filter.c:21:
   In file included from include/linux/bpf_verifier.h:7:
   In file included from include/linux/bpf.h:31:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from net/core/filter.c:21:
   In file included from include/linux/bpf_verifier.h:7:
   In file included from include/linux/bpf.h:31:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from net/core/filter.c:21:
   In file included from include/linux/bpf_verifier.h:7:
   In file included from include/linux/bpf.h:31:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> net/core/filter.c:11721:7: error: implicit declaration of function 'bpf_token_capable' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           if (!bpf_token_capable(prog->aux->token, CAP_PERFMON))
                ^
   12 warnings and 1 error generated.


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
