Return-Path: <linux-fsdevel+bounces-77535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEKQMkthlWn9PwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:50:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCE3153854
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DCAE23021942
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 06:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D9830CDA4;
	Wed, 18 Feb 2026 06:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FxAvp+G3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3152F90C5;
	Wed, 18 Feb 2026 06:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771397442; cv=none; b=Kx1QPpvO40GRc6cLf0zas+v4gj2ECjHYvp88a+UKfshXFhg2o9Imt2fe1En3rg7pvs1SodVnB1hgxqWj4VEQW8rc/+XOvFfRuoSC4cW+vwb5Duz5s+G2mUt2vR3KS+hHWqTsMXthf1OGjd9LoGaHqwKWumsH/sxyv+i/RmilhoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771397442; c=relaxed/simple;
	bh=8RTbb90Fpva7XOPRMhenLpv2atQux2rN84/PoyXSi54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNZVsLveSRdo7S4kw6duoAA3z9hvRkRewlPhP/Oz9KJMHsxrg/Ywem9vL0WXg8ta0741tSZugosKe7KV1P07nVIYLjGLcntK/kp0sipLttgJPBr/Kbbv8FUefYTfV2Chd/xW6Dkua/YpKPi4qxBBZEcFQyDhGitHWdBKrAn2o0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FxAvp+G3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771397440; x=1802933440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8RTbb90Fpva7XOPRMhenLpv2atQux2rN84/PoyXSi54=;
  b=FxAvp+G3lC6VCAyXSC4MPjI+tVxt/bUDcQ/Somtzwv5l1v7T2hC1PfJK
   mLcJ08xmxaMjC90SOcKK1ZfZwzDvBxOup1pw+DnZjZFBHVVXGmd+pNTIT
   dOxcxf9TdzHnYY4TvpOLxcWJCQWLlAFQ9Nuhr0okYDZou6GeCBOhcHG2u
   hg9+ZkhLB+EX6FZ5dTp5+VldA9TICB7EXe8tWBjN3olgYAiPIaTVyQ70m
   7elNVYdVy8jVop4l0QlPZjx3btb0bBvXVmKKi0or/gFsaGhvf8VEQ83sd
   qI57gkSGjxPA2URlP7UZDXxvAYPe4WfIqYaqZ/XqKavp4klcAkgkk3shg
   g==;
X-CSE-ConnectionGUID: 05tOKzTZRw++mo+Ro7oMFg==
X-CSE-MsgGUID: iVsNzb50Qoaf3XCuaHP4JQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="72381377"
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="72381377"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 22:50:39 -0800
X-CSE-ConnectionGUID: uQHDN+R9S6+CU233+J+SfA==
X-CSE-MsgGUID: fkpKKOcpSTKiU2aromQcxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="212928560"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 17 Feb 2026 22:50:37 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vsbOO-00000001288-0qcc;
	Wed, 18 Feb 2026 06:50:36 +0000
Date: Wed, 18 Feb 2026 14:50:21 +0800
From: kernel test robot <lkp@intel.com>
To: Ethan Ferguson <ethan.ferguson@zetier.com>, hirofumi@mail.parknet.co.jp
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: Re: [PATCH v2 2/2] fat: Add FS_IOC_SETFSLABEL ioctl
Message-ID: <202602181429.zMfoW0eg-lkp@intel.com>
References: <20260217230628.719475-3-ethan.ferguson@zetier.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217230628.719475-3-ethan.ferguson@zetier.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77535-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email,01.org:url]
X-Rspamd-Queue-Id: 5CCE3153854
X-Rspamd-Action: no action

Hi Ethan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 9f2693489ef8558240d9e80bfad103650daed0af]

url:    https://github.com/intel-lab-lkp/linux/commits/Ethan-Ferguson/fat-Add-FS_IOC_GETFSLABEL-ioctl/20260218-071019
base:   9f2693489ef8558240d9e80bfad103650daed0af
patch link:    https://lore.kernel.org/r/20260217230628.719475-3-ethan.ferguson%40zetier.com
patch subject: [PATCH v2 2/2] fat: Add FS_IOC_SETFSLABEL ioctl
config: arm-vexpress_defconfig (https://download.01.org/0day-ci/archive/20260218/202602181429.zMfoW0eg-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260218/202602181429.zMfoW0eg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602181429.zMfoW0eg-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: fs/fat/file.o: in function `fat_convert_volume_label_str':
   fs/fat/file.c:184:(.text+0x14c): undefined reference to `msdos_format_name'
>> arm-linux-gnueabi-ld: fs/fat/file.c:193:(.text+0x168): undefined reference to `msdos_format_name'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

