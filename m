Return-Path: <linux-fsdevel+bounces-75037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJxhKko6cmlMfAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 15:55:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC4E68301
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 15:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C8CFD762C90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 13:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BDD318BA9;
	Thu, 22 Jan 2026 13:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JKcA7luV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0552F39A3;
	Thu, 22 Jan 2026 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769089245; cv=none; b=BYsMuoYmhSQKSuUDdHlCqVWVVvu8+viF6awreJLp5bOZxYH7Cmn+hhksWocbwLX4/RuWu5zC/nJMygh/0AbECOMfz39B3VQCCViiIPXwPa3jC4hcBqfLGF6zZ9VOcZNPzN9pRnvvro92xIen/aYtwhJLQOagf7VF8V0bGOBwSes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769089245; c=relaxed/simple;
	bh=Yy88WumMQAcgbaUQHL0fvgadfLS+HaqFVLxycPPXXV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqTHGeUHV36Xj09oA0VEqLZ7I0dAP8hRPR7lL+4A2u2S5wq/mroSkDs3b50IUXYFOrZGwiBYVSUgClaSd1QW33Fsgj6koMtWGDW2mdceVlYQS4NbbNIt/hXsPYaFmvuezQk9DNXT9tlPwzz/Y97UAF1n1tQkvi8qmGiK0i2S/Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JKcA7luV; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769089243; x=1800625243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yy88WumMQAcgbaUQHL0fvgadfLS+HaqFVLxycPPXXV8=;
  b=JKcA7luVPGr4Ak6T8G+TWKUZuBm8Zojq2A8srXHNazB2vCR/YyuwSOHI
   vSbiSpft6Lup9S99b99VAjHRlmLFw9wC27TX3VVwHaiNpo22ZYX8d6HFg
   sBlSXZ5Wzgv6A41ZgpX5MEVZOz6WuPjuZ+GTFW9gCiocjqhA5U0qAg6vR
   MgsiQtg6wyVC1/zzRvZlcu9sU+sZmGB10WggFY5ISpZ5nMojSSJjSoQ1q
   PXReF0CTU2pULsymGU03YsFUp1umiJpnrb9DXAqn87Htm5sXHFAN1krWu
   NUsfAovlJB7k69C2L7TiARGy6Pn4q1n1noynz0ig0YjOkBW8J6tD05bZ9
   g==;
X-CSE-ConnectionGUID: XJwskSpoQaOB1wi1ptDaYA==
X-CSE-MsgGUID: dklZKz6XQLyMZxDAYUVIJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="69347965"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="69347965"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 05:40:42 -0800
X-CSE-ConnectionGUID: hGEU0bdURHi+hgCa+Mv4zg==
X-CSE-MsgGUID: hBI2IIdNR4SFhsa2xbjIzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="207171546"
Received: from igk-lkp-server01.igk.intel.com (HELO afc5bfd7f602) ([10.211.93.152])
  by fmviesa009.fm.intel.com with ESMTP; 22 Jan 2026 05:40:36 -0800
Received: from kbuild by afc5bfd7f602 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1viuvJ-000000000VB-0Mh6;
	Thu, 22 Jan 2026 13:40:33 +0000
Date: Thu, 22 Jan 2026 14:40:07 +0100
From: kernel test robot <lkp@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ard Biesheuvel <ardb@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Zhijian Li <lizhijian@fujitsu.com>
Subject: Re: [PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of
 Soft Reserved memory ranges
Message-ID: <202601221448.OYyjVxEC-lkp@intel.com>
References: <20260122045543.218194-7-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122045543.218194-7-Smita.KoralahalliChannabasappa@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75037-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 4DC4E68301
X-Rspamd-Action: no action

Hi Smita,

kernel test robot noticed the following build errors:

[auto build test ERROR on bc62f5b308cbdedf29132fe96e9d591e526527e1]

url:    https://github.com/intel-lab-lkp/linux/commits/Smita-Koralahalli/dax-hmem-Request-cxl_acpi-and-cxl_pci-before-walking-Soft-Reserved-ranges/20260122-130032
base:   bc62f5b308cbdedf29132fe96e9d591e526527e1
patch link:    https://lore.kernel.org/r/20260122045543.218194-7-Smita.KoralahalliChannabasappa%40amd.com
patch subject: [PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of Soft Reserved memory ranges
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260122/202601221448.OYyjVxEC-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260122/202601221448.OYyjVxEC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601221448.OYyjVxEC-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "cxl_bus_type" [drivers/dax/hmem/dax_hmem.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

