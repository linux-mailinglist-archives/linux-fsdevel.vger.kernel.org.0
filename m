Return-Path: <linux-fsdevel+bounces-77073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANhqEjC8jmkWEQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 06:52:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A126213319E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 06:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38DE73028EE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 05:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CAC26056D;
	Fri, 13 Feb 2026 05:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ISUpU/Oo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855AA267B05;
	Fri, 13 Feb 2026 05:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770961939; cv=none; b=U40ivvwUOBuwJzvA7YNqvvypfbbVTj5L4fYCwDtmc+4t5uFnz7DT30eVJ133UtsiTwaLYjGpROsf4pH9a9hLQNba8KeOBQ6f9cAWpG/TlbeqzJPP5c/6zOay9XVRXIaEzH+Rr/kQaxo58iw9ll55yCNKpxSz6xhi1xlHPNJQvWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770961939; c=relaxed/simple;
	bh=MWzI6YSu+b3ttAZ95Yt6sR1JqTMjb7mRuDBXmEn+JwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elsB52S4LGGjVhAfW4Kjs6aVVH+tXnZRQzjDhVTvNSVXYTjOq6Wj9KrKWucX1uIkP5Ofvy+StchLVjX19fjMiaTxW8ZV/RecJ1JPuvQVMaPK0W24l0QZ8k3IlrmpD7FKOlxNH4NWnOiszhcZOUvDBzUAGmaRgZ2XpVbuHL0GFKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ISUpU/Oo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770961937; x=1802497937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MWzI6YSu+b3ttAZ95Yt6sR1JqTMjb7mRuDBXmEn+JwM=;
  b=ISUpU/Oo4Q63+MDsqRYHVXdtP+gXgTG/BOGelu/EoNykoB+4+qUF91qh
   YoQPtva5nQEWJQMipkVzxZsTRjO0+w3qZ2br8G9BpPLUOb161ukNKYSus
   BkosR/Jtq5OQ7V9IXYCi2F22n3lrp8VV94GYmMmsMK5AG2IOGfXIzZByz
   +lsT4jGDKcigPlSlJsMVpUYK5hjGEA8Shbsvy7SYwmzfteyONW98yENsG
   jmQ+P2hzOnnboFIuLQPkS2rqLztvkO10+EGojpE/B+Dbpz22ow6eBuR02
   YGOgIfy2iv7Gq4KBqAsR2y5GCmzHHw51WVqHF5QyYLKMmswLGqSGkHmM5
   w==;
X-CSE-ConnectionGUID: tqH0TrvfSouL5/CDV+6NOw==
X-CSE-MsgGUID: zdlTGEYVRyizQfR7GDHbGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="75990990"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="75990990"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 21:52:17 -0800
X-CSE-ConnectionGUID: JyWWuxsvTRCcUjwWPfafMg==
X-CSE-MsgGUID: UVCR0Cf5SuWUr1A0emYHHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="211744044"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 12 Feb 2026 21:52:16 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vqm69-00000000v8K-2sU8;
	Fri, 13 Feb 2026 05:52:13 +0000
Date: Fri, 13 Feb 2026 13:51:16 +0800
From: kernel test robot <lkp@intel.com>
To: Ethan Ferguson <ethan.ferguson@zetier.com>, luisbg@kernel.org,
	salah.triki@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: Re: [PATCH 1/2] befs: Add FS_IOC_GETFSLABEL ioctl
Message-ID: <202602131301.1CCwgtrL-lkp@intel.com>
References: <20260212231339.644714-2-ethan.ferguson@zetier.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212231339.644714-2-ethan.ferguson@zetier.com>
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
	TAGGED_FROM(0.00)[bounces-77073-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[zetier.com,kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A126213319E
X-Rspamd-Action: no action

Hi Ethan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 541c43310e85dbf35368b43b720c6724bc8ad8ec]

url:    https://github.com/intel-lab-lkp/linux/commits/Ethan-Ferguson/befs-Add-FS_IOC_GETFSLABEL-ioctl/20260213-071516
base:   541c43310e85dbf35368b43b720c6724bc8ad8ec
patch link:    https://lore.kernel.org/r/20260212231339.644714-2-ethan.ferguson%40zetier.com
patch subject: [PATCH 1/2] befs: Add FS_IOC_GETFSLABEL ioctl
config: sparc-randconfig-002-20260213 (https://download.01.org/0day-ci/archive/20260213/202602131301.1CCwgtrL-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260213/202602131301.1CCwgtrL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602131301.1CCwgtrL-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/befs/linuxvfs.c: In function 'befs_generic_compat_ioctl':
>> fs/befs/linuxvfs.c:985:61: error: implicit declaration of function 'compat_ptr' [-Werror=implicit-function-declaration]
     985 |         return befs_generic_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
         |                                                             ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/compat_ptr +985 fs/befs/linuxvfs.c

   979	
   980	#ifdef CONFIG_COMPAT
   981	static long befs_generic_compat_ioctl(struct file *filp, unsigned int cmd,
   982					      unsigned long arg)
   983	
   984	{
 > 985		return befs_generic_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
   986	}
   987	#endif
   988	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

