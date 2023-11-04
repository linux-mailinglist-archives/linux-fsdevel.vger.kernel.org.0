Return-Path: <linux-fsdevel+bounces-1964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A34217E0CBF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Nov 2023 01:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADA20B21502
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Nov 2023 00:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5415315A5;
	Sat,  4 Nov 2023 00:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gWuSeJ+8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10424622;
	Sat,  4 Nov 2023 00:38:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3E8D45;
	Fri,  3 Nov 2023 17:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699058295; x=1730594295;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z97UFq+QehJNlR4W7nQoGDS8MXrq9lbEH00mni21Llo=;
  b=gWuSeJ+81vAJvv8FQlY753+kp8oyz5nO10D2p4trvCOJ5s5eOZU4LRqB
   cK8tpoVZPkLOCPRAc7sr1fzj5p/Dd3T0lTZrfNcBL5iXqW+YEEvbmfSNW
   bl+VASWDAzTaVRoaeRF5vfLT+dHaZjsECfglI7wB+8Qq0nyvN1Lz/OUTC
   AJ44wea9Wa5nTgv0KR9RZ4awl36J9JyeAr7hh3K+wgQCtoMgcTL0kdBlP
   IslRmfz+mplrLz4o0t/v1SlJs63BlVrCMvV+4jscf3NFCTV0WucMA8LfR
   YSwYp6OZ0c0WxdaSwU3jiigL4pDyZ4ybRMyajJ6/GL5lhls+ZGpDrnxgz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="369252331"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="369252331"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 17:38:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="755313880"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="755313880"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 03 Nov 2023 17:38:11 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qz4fx-00038Q-1v;
	Sat, 04 Nov 2023 00:38:09 +0000
Date: Sat, 4 Nov 2023 08:36:59 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, paul@paul-moore.com, brauner@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, keescook@chromium.org,
	kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH v9 bpf-next 11/17] bpf,lsm: add BPF token LSM hooks
Message-ID: <202311040829.XrnpSV8z-lkp@intel.com>
References: <20231103190523.6353-12-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103190523.6353-12-andrii@kernel.org>

Hi Andrii,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bpf-align-CAP_NET_ADMIN-checks-with-bpf_capable-approach/20231104-031714
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231103190523.6353-12-andrii%40kernel.org
patch subject: [PATCH v9 bpf-next 11/17] bpf,lsm: add BPF token LSM hooks
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20231104/202311040829.XrnpSV8z-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311040829.XrnpSV8z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311040829.XrnpSV8z-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/net/scm.h:8,
                    from include/linux/netlink.h:9,
                    from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:45,
                    from include/net/sock.h:46,
                    from include/linux/tcp.h:19,
                    from include/linux/ipv6.h:95,
                    from include/net/ipv6.h:12,
                    from include/linux/sunrpc/addr.h:14,
                    from fs/nfsd/nfsd.h:22,
                    from fs/nfsd/state.h:42,
                    from fs/nfsd/xdr4.h:40,
                    from fs/nfsd/trace.h:17,
                    from fs/nfsd/trace.c:4:
>> include/linux/security.h:2084:92: error: parameter 2 ('cmd') has incomplete type
    2084 | static inline int security_bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd)
         |                                                                               ~~~~~~~~~~~~~^~~
>> include/linux/security.h:2084:19: error: function declaration isn't a prototype [-Werror=strict-prototypes]
    2084 | static inline int security_bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/net/scm.h:8,
                    from include/linux/netlink.h:9,
                    from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:45,
                    from include/net/sock.h:46,
                    from include/linux/tcp.h:19,
                    from include/linux/ipv6.h:95,
                    from include/net/ipv6.h:12,
                    from include/linux/sunrpc/addr.h:14,
                    from fs/nfsd/nfsd.h:22,
                    from fs/nfsd/export.c:21:
>> include/linux/security.h:2084:92: error: parameter 2 ('cmd') has incomplete type
    2084 | static inline int security_bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd)
         |                                                                               ~~~~~~~~~~~~~^~~
>> include/linux/security.h:2084:19: error: function declaration isn't a prototype [-Werror=strict-prototypes]
    2084 | static inline int security_bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/nfsd/export.c: In function 'exp_rootfh':
   fs/nfsd/export.c:1017:34: warning: variable 'inode' set but not used [-Wunused-but-set-variable]
    1017 |         struct inode            *inode;
         |                                  ^~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/net/scm.h:8,
                    from include/linux/netlink.h:9,
                    from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:45,
                    from include/net/sock.h:46,
                    from include/linux/tcp.h:19,
                    from include/linux/ipv6.h:95,
                    from include/net/ipv6.h:12,
                    from include/linux/sunrpc/addr.h:14,
                    from fs/nfsd/nfsd.h:22,
                    from fs/nfsd/state.h:42,
                    from fs/nfsd/xdr4.h:40,
                    from fs/nfsd/trace.h:17,
                    from fs/nfsd/trace.c:4:
>> include/linux/security.h:2084:92: error: parameter 2 ('cmd') has incomplete type
    2084 | static inline int security_bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd)
         |                                                                               ~~~~~~~~~~~~~^~~
>> include/linux/security.h:2084:19: error: function declaration isn't a prototype [-Werror=strict-prototypes]
    2084 | static inline int security_bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from fs/nfsd/trace.h:1958:
   include/trace/define_trace.h:95:42: fatal error: ./trace.h: No such file or directory
      95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
         |                                          ^
   cc1: some warnings being treated as errors
   compilation terminated.


vim +2084 include/linux/security.h

  2083	
> 2084	static inline int security_bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd)
  2085	{
  2086		return 0;
  2087	}
  2088	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

