Return-Path: <linux-fsdevel+bounces-76498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJA6N68ghWkU8wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 23:58:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D268F83FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 23:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83C633019901
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 22:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144A033B6E8;
	Thu,  5 Feb 2026 22:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RvdVvmFS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D0132ED54;
	Thu,  5 Feb 2026 22:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770332321; cv=none; b=XMXQ95VQSWv9qzRR+g9yd2sssrIrjTqiOvBMHsMmSudc4nR8G88IuJ17vaImx76BZdSEc45MmCpyGMSMHEImfADzbj2sgynjlCKG/fy/J7U/TZiK9nN5ypobNzRrdEGz69jL7yBOGtjWdI8UHE4YSuG1G/BzYpbscOXlxW4urNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770332321; c=relaxed/simple;
	bh=NnrruiY4bAYvw4eBNrWEypvNXHyiEDpgL5lhYvluB+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHRNQzHWyNsUt+WdpywzaJv8fg/cvN8iCJAUa6h7zITJkOE0z7lbb5JMBS9TRnze6OVbmRU4OFO5T/h9aoDcPfQhzh399z5vg5vL4cQKz9ly2EUVkmvHy6iZw54owYlFlHVLOdx1iRq8n+P/wxqsnbMLouNzsjfxj+oz2fsSA+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RvdVvmFS; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770332321; x=1801868321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NnrruiY4bAYvw4eBNrWEypvNXHyiEDpgL5lhYvluB+s=;
  b=RvdVvmFSYdJuRT052CWIwIv1amTs5P29Ii0xwf/0oUim7j5kV2vfLLF9
   RI4sFPZK+Q4ahcE7weM6RcM8UHWZuueSn1z/zN7TFcJfxn012iXDVlOtL
   yl5wVRC2ChqlP8w/PMpYC6qiMbOyblzRxRqzuaJQQnmhrCaPWSvZyF3fV
   AF9cU+3jcizBR06kBnSM/3+9AkY1TkOw8Mzi8sKs+IouJObFGNJ8bxQON
   s6i8p4+NvJc2/+3MXY87N9gskCwKo284ITTK5tbVLT6Aq2OOLgxJyYhHA
   LuOXCNyT4DdMcziN/o9Z9EwUcIGLW3nDUSEKEHLiyu8+EtSCcykMRB3np
   w==;
X-CSE-ConnectionGUID: CJVumvloRtu1gjmC6q601w==
X-CSE-MsgGUID: g/hnHpM8TG6yh2FlZJ5iUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="82174658"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="82174658"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 14:58:40 -0800
X-CSE-ConnectionGUID: VeimbmnkSwqK+8li+Ne/eQ==
X-CSE-MsgGUID: sjCpX7TsQ4+yyg2eHXM+mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="210491044"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 05 Feb 2026 14:58:36 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vo8Iy-00000000kGy-3XDp;
	Thu, 05 Feb 2026 22:58:32 +0000
Date: Fri, 6 Feb 2026 06:58:28 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>, ast@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>, bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH] bpf: use FS_USERNS_DELEGATABLE for bpffs
Message-ID: <202602060650.PATlrMmc-lkp@intel.com>
References: <20260205104541.171034-1-alexander@mihalicyn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205104541.171034-1-alexander@mihalicyn.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[lists.linux.dev,iogearbox.net,kernel.org,linux.dev,gmail.com,fomichev.me,google.com,vger.kernel.org,futurfusion.io];
	TAGGED_FROM(0.00)[bounces-76498-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D268F83FD
X-Rspamd-Action: no action

Hi Alexander,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/net]
[also build test ERROR on bpf-next/master bpf/master brauner-vfs/vfs.all linus/master v6.19-rc8 next-20260205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Mikhalitsyn/bpf-use-FS_USERNS_DELEGATABLE-for-bpffs/20260205-184845
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20260205104541.171034-1-alexander%40mihalicyn.com
patch subject: [PATCH] bpf: use FS_USERNS_DELEGATABLE for bpffs
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20260206/202602060650.PATlrMmc-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260206/202602060650.PATlrMmc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602060650.PATlrMmc-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/bpf/inode.c:1084:27: error: 'FS_USERNS_DELEGATABLE' undeclared here (not in a function); did you mean 'CFTYPE_NS_DELEGATABLE'?
    1084 |         .fs_flags       = FS_USERNS_DELEGATABLE,
         |                           ^~~~~~~~~~~~~~~~~~~~~
         |                           CFTYPE_NS_DELEGATABLE


vim +1084 kernel/bpf/inode.c

  1077	
  1078	static struct file_system_type bpf_fs_type = {
  1079		.owner		= THIS_MODULE,
  1080		.name		= "bpf",
  1081		.init_fs_context = bpf_init_fs_context,
  1082		.parameters	= bpf_fs_parameters,
  1083		.kill_sb	= bpf_kill_super,
> 1084		.fs_flags	= FS_USERNS_DELEGATABLE,
  1085	};
  1086	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

