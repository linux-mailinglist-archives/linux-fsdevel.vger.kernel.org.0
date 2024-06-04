Return-Path: <linux-fsdevel+bounces-20992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBD28FBE8E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 00:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6693C1F23BA7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 22:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1230114659A;
	Tue,  4 Jun 2024 22:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R5Hfnbdc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E71F1428E7;
	Tue,  4 Jun 2024 22:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539206; cv=none; b=Nrzfg6XgDXBl4zk5pn/Gr8qaoCJHVB8hLWUUMwC6+7UKcvAN7siz461m1z0ptijYVYH7urCsuYuvfe6YLPIm7vjIpacI5ryv4ZvKm8jMSc4NF8/+o9yNJBEDiWWl4FKADauW/2X3h+W/l1Vh9zZvV/KfjALW7kd9bmIiY6A1bGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539206; c=relaxed/simple;
	bh=r9YeMasUFXYcAKberShAPL7LEyJwvBlz2qjEeMGSwb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9xuv/OJYAlQoWRBN6xSCGc6v8vN5Rg6JbQu8+3KThOs07Ug5I4aNfiTBKuvwL7iR3FpXdtuBKZjjLzgjUTGuPGZ6l+SPLVf5O1Qo9oxKawo+86qr4vFw67diQ7KoxZkX0424BXL1EtjsSY5V+JVcWdBBjQKo/Skq45SdEo+9dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R5Hfnbdc; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717539205; x=1749075205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r9YeMasUFXYcAKberShAPL7LEyJwvBlz2qjEeMGSwb8=;
  b=R5HfnbdcTN3PZlmRUEqsxz0Jke9keY6F9VwrboHUafNXCesSIxHbrKsI
   hWMDIV4XTHYX1tCIqR3x+GBmYx4/QJDceuStqEdZ38IavB/gBXET2PiEH
   RQAifglLFkoVr5ZyA0AOig5iBIkmyGaWbvvdL3yq+8IJ3bhyB8Qs4OvNH
   6D/inpNahjlpo1btegwL3Ol5m5ijvh9L4e4ayynYd2UKMF0wbMe/t2Ip0
   dAnZRphvKHs1FE17VdCBir5p27ybuXhA62QsWr8t3nbJ6BCbO7TlVP7hF
   2pP8ExiqZTAsmsCE4z4XqOgH92q/RL4Sqd7MIgp4Yiloos7arjDyivmt7
   w==;
X-CSE-ConnectionGUID: foXejooUQ4C4SspqH+kWuA==
X-CSE-MsgGUID: Pqvv5ArvQ7qHS9yFXoW1+w==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="11907578"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="11907578"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 15:13:24 -0700
X-CSE-ConnectionGUID: 9v72H8L5Tau8SucnIdWnXA==
X-CSE-MsgGUID: BY8sRHYESTu2H63COZ8w/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="41802990"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 04 Jun 2024 15:13:20 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEcP8-0000bN-0e;
	Tue, 04 Jun 2024 22:13:18 +0000
Date: Wed, 5 Jun 2024 06:13:11 +0800
From: kernel test robot <lkp@intel.com>
To: "Isaac J. Manjarres" <isaacmanjarres@google.com>, tglx@linutronix.de,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: oe-kbuild-all@lists.linux.dev, saravanak@google.com,
	Manish Varma <varmam@google.com>,
	Kelly Rossmoyer <krossmo@google.com>,
	"Isaac J . Manjarres" <isaacmanjarres@google.com>,
	kernel-team@android.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] fs: Improve eventpoll logging to stop indicting
 timerfd
Message-ID: <202406050504.UvdlPAQ0-lkp@intel.com>
References: <20240604173606.998721-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604173606.998721-1-isaacmanjarres@google.com>

Hi Isaac,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.10-rc2 next-20240604]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Isaac-J-Manjarres/fs-Improve-eventpoll-logging-to-stop-indicting-timerfd/20240605-013918
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240604173606.998721-1-isaacmanjarres%40google.com
patch subject: [PATCH v4] fs: Improve eventpoll logging to stop indicting timerfd
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20240605/202406050504.UvdlPAQ0-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240605/202406050504.UvdlPAQ0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406050504.UvdlPAQ0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/base/power/wakeup.c: In function 'wakeup_source_register':
>> drivers/base/power/wakeup.c:223:9: warning: function 'wakeup_source_register' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     223 |         vsnprintf(name, sizeof(name), fmt, args);
         |         ^~~~~~~~~


vim +223 drivers/base/power/wakeup.c

   208	
   209	/**
   210	 * wakeup_source_register - Create wakeup source and add it to the list.
   211	 * @dev: Device this wakeup source is associated with (or NULL if virtual).
   212	 * @fmt: format string for the wakeup source name
   213	 */
   214	struct wakeup_source *wakeup_source_register(struct device *dev,
   215						     const char *fmt, ...)
   216	{
   217		struct wakeup_source *ws;
   218		int ret;
   219		char name[128];
   220		va_list args;
   221	
   222		va_start(args, fmt);
 > 223		vsnprintf(name, sizeof(name), fmt, args);
   224		va_end(args);
   225	
   226		ws = wakeup_source_create(name);
   227		if (ws) {
   228			if (!dev || device_is_registered(dev)) {
   229				ret = wakeup_source_sysfs_add(dev, ws);
   230				if (ret) {
   231					wakeup_source_free(ws);
   232					return NULL;
   233				}
   234			}
   235			wakeup_source_add(ws);
   236		}
   237		return ws;
   238	}
   239	EXPORT_SYMBOL_GPL(wakeup_source_register);
   240	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

