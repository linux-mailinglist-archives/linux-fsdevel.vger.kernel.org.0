Return-Path: <linux-fsdevel+bounces-44813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D77A6CD4C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 00:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C027C7AD2BC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 23:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E921EEA34;
	Sat, 22 Mar 2025 23:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IGbs2Tlk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CF31EA7FD;
	Sat, 22 Mar 2025 23:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742686637; cv=none; b=lYe5cIwPdzCJJm9iua+kpI6IHtOx99dcXFStX724Bap3C/4l04IblSbeKVoIlgCJAbBt5csome0VuuDEnhFCUxkYOoOttvO0/U2BQvnzIkmoK1YMKk/WewrZk91qlynXoGtvCQwieqjVoygYRWtGykzcz/oEaw7Z+GT1MhJRmP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742686637; c=relaxed/simple;
	bh=/fL38PohfZNzoYeO4e3wD60/qTiXOlKjNyMjNKu+IRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxdRS89zfkXO068vvT/Q7Ssmzo4RHUPcRIqNqhZK1S3smpV5iaIW6oZrSp7PdUOYZX2KekyOyI1MXx/Mwly/5s5NqPXm+llvZ0/amj1mIzlxBnYWqZoonW/vEdX51UBRVvuT9QgSfnPbvAYCNTsdOjIc/1xEJyoYF8dQYuZpCFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IGbs2Tlk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742686636; x=1774222636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/fL38PohfZNzoYeO4e3wD60/qTiXOlKjNyMjNKu+IRc=;
  b=IGbs2Tlk3Y5kngOGHK+DRtMRydCzJ7gAAQDRbgI4KBdifMEgXIF4IiZM
   vJ+X9fvlUgMvUXKGoY/vO/4quD2+ByDwglS/zsZZM+z+egSg3bZNiY1uJ
   lWsFD/VVltjHc4/VjXOrJZzUzt1A7tQz7XON1Ltqo4JknZEjRHg51BquP
   fo1iKwkqp/3gWufL9Aoc+qHVea6IOVebbCmtKQ/eng+diQ7pYZ6AmyjTu
   zmBfgcOPuhMWTHqhYb3S5C5tYfvl2Rj/oLD2NcjHudTeoaiyUvCaBOV3I
   RSqyj3QbuWgXypMn/fp0fcs5dRHSnpGFcnU4AOP4stDZ75G+Z0wgVcYh1
   Q==;
X-CSE-ConnectionGUID: bNr/et0oRNGtPtIFRUmxhw==
X-CSE-MsgGUID: gh8ePYCvRAukqLDkObn42g==
X-IronPort-AV: E=McAfee;i="6700,10204,11381"; a="54553323"
X-IronPort-AV: E=Sophos;i="6.14,268,1736841600"; 
   d="scan'208";a="54553323"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2025 16:37:11 -0700
X-CSE-ConnectionGUID: Q4gcij9bRf6YlCYCu1aUrA==
X-CSE-MsgGUID: T10ovpUaTTKIen4JafwWaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,268,1736841600"; 
   d="scan'208";a="128530006"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 22 Mar 2025 16:37:08 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tw8On-0002SR-1u;
	Sat, 22 Mar 2025 23:37:05 +0000
Date: Sun, 23 Mar 2025 07:36:57 +0800
From: kernel test robot <lkp@intel.com>
To: Julian Stecklina via B4 Relay <devnull+julian.stecklina.cyberus-technology.de@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Gao Xiang <xiang@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>
Subject: Re: [PATCH v2 8/9] fs: ext2, ext4: register an initrd fs detector
Message-ID: <202503230718.5DYAbNZO-lkp@intel.com>
References: <20250322-initrd-erofs-v2-8-d66ee4a2c756@cyberus-technology.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322-initrd-erofs-v2-8-d66ee4a2c756@cyberus-technology.de>

Hi Julian,

kernel test robot noticed the following build errors:

[auto build test ERROR on 88d324e69ea9f3ae1c1905ea75d717c08bdb8e15]

url:    https://github.com/intel-lab-lkp/linux/commits/Julian-Stecklina-via-B4-Relay/initrd-remove-ASCII-spinner/20250323-043649
base:   88d324e69ea9f3ae1c1905ea75d717c08bdb8e15
patch link:    https://lore.kernel.org/r/20250322-initrd-erofs-v2-8-d66ee4a2c756%40cyberus-technology.de
patch subject: [PATCH v2 8/9] fs: ext2, ext4: register an initrd fs detector
config: i386-buildonly-randconfig-001-20250323 (https://download.01.org/0day-ci/archive/20250323/202503230718.5DYAbNZO-lkp@intel.com/config)
compiler: clang version 20.1.1 (https://github.com/llvm/llvm-project 424c2d9b7e4de40d0804dd374721e6411c27d1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250323/202503230718.5DYAbNZO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503230718.5DYAbNZO-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/ext2/initrd.c:27:33: error: too many arguments provided to function-like macro invocation
      27 | initrd_fs_detect(detect_ext2fs, BLOCK_SIZE);
         |                                 ^
   include/linux/initrd.h:63:9: note: macro 'initrd_fs_detect' defined here
      63 | #define initrd_fs_detect(detectfn)
         |         ^
>> fs/ext2/initrd.c:27:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
      27 | initrd_fs_detect(detect_ext2fs, BLOCK_SIZE);
         | ^
         | int
   2 errors generated.


vim +27 fs/ext2/initrd.c

    26	
  > 27	initrd_fs_detect(detect_ext2fs, BLOCK_SIZE);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

