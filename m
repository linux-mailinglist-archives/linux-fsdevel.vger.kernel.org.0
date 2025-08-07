Return-Path: <linux-fsdevel+bounces-56958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E3AB1D1BA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 06:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9141B7A7C3E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 04:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1FD1EFF8B;
	Thu,  7 Aug 2025 04:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BzwdemNQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF671DB546;
	Thu,  7 Aug 2025 04:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754542624; cv=none; b=q+lWrOp3uCiK/Gp5T/19ei8KaV67xnxhtNy5HxZUipZP1SeS9d4dOG5+0uK/tx1zzIiX8tEPqE+4TskccsH7SVVgwh3Lqcq68vlazBpBv9rNq6E5g5s6Jb9zkXhJocQataTQBeTnp9JK9bYCoiFO6RKZoanqKGGUCbqBTFhPsxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754542624; c=relaxed/simple;
	bh=nJOS05fwc/KaKhbWkyOpZffHljW0njRbD/2F3oqiCXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2NchxkENQaBZhK+1x8qULRIHy1P/oQj8b/RueIEW7njNlmyjNyzg2LrbqxM2Cu70ve/gBvoVFunuFO9a/2rxp6K+y6N+DhXQtY9cR7I8prnbuBufFvQi6wIybFxZN3pug/C8l7p3ihtCqLygAMKzSHH2FuBVReOt7zcdRXkdy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BzwdemNQ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754542623; x=1786078623;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nJOS05fwc/KaKhbWkyOpZffHljW0njRbD/2F3oqiCXY=;
  b=BzwdemNQD9HtMsmagE3LBrX1/W4QqkhNnmOW9OKmSti7YP3U82xRsyLs
   fHgyw8vl320TBUtLT47LlX0XotCxysEivm7vqq99C8LnPZLgnah05d+7H
   PIcaejwPm0KIkovBMJciSLvYQD4X54bwba7Vfs0+iPvPv2ZNVQs9pUrJf
   QQFvVGh5PYmm7Xth6tORl2OCpUQ6LPEFdtmJMnYxzDq98OWean2udiV1V
   yYBEDdJUfcQ3OtxHn1o2eC9MQBbwkmB8MZE79tg7aIUkpoKU+OKRqxoSL
   wbrnxRZhaOYgVHaDQpm/0zsSTaLB6mtbblR9eCxcsYb68G+fxIDoC6QP7
   w==;
X-CSE-ConnectionGUID: Tjgi1yAlRf2xkxQuifM27A==
X-CSE-MsgGUID: gKi2YOSfRemIqr3Tp/HnMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="60678774"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="60678774"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 21:57:02 -0700
X-CSE-ConnectionGUID: c5+BDNPRSWObru4pSJzB3A==
X-CSE-MsgGUID: QQUc238ZQSy85fHOm/65PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="170221740"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 06 Aug 2025 21:56:59 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujsgT-0002OA-09;
	Thu, 07 Aug 2025 04:56:57 +0000
Date: Thu, 7 Aug 2025 12:56:53 +0800
From: kernel test robot <lkp@intel.com>
To: Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: oe-kbuild-all@lists.linux.dev, David Howells <dhowells@redhat.com>,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH v2 2/2] vfs: output mount_too_revealing() errors to
 fscontext
Message-ID: <202508071236.2BTGpdZx-lkp@intel.com>
References: <20250806-errorfc-mount-too-revealing-v2-2-534b9b4d45bb@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806-errorfc-mount-too-revealing-v2-2-534b9b4d45bb@cyphar.com>

Hi Aleksa,

kernel test robot noticed the following build errors:

[auto build test ERROR on 66639db858112bf6b0f76677f7517643d586e575]

url:    https://github.com/intel-lab-lkp/linux/commits/Aleksa-Sarai/fscontext-add-custom-prefix-log-helpers/20250806-141024
base:   66639db858112bf6b0f76677f7517643d586e575
patch link:    https://lore.kernel.org/r/20250806-errorfc-mount-too-revealing-v2-2-534b9b4d45bb%40cyphar.com
patch subject: [PATCH v2 2/2] vfs: output mount_too_revealing() errors to fscontext
config: riscv-randconfig-002-20250807 (https://download.01.org/0day-ci/archive/20250807/202508071236.2BTGpdZx-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250807/202508071236.2BTGpdZx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508071236.2BTGpdZx-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: vmlinux: section mismatch in reference: prp_dup_discard_out_of_sequence+0x266 (section: .text.prp_dup_discard_out_of_sequence) -> ili9486_spi_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: prp_dup_discard_out_of_sequence+0x2ae (section: .text.prp_dup_discard_out_of_sequence) -> ili9486_spi_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: prp_dup_discard_out_of_sequence+0x2f2 (section: .text.prp_dup_discard_out_of_sequence) -> mi0283qt_spi_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: prp_dup_discard_out_of_sequence+0x33e (section: .text.prp_dup_discard_out_of_sequence) -> mi0283qt_spi_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: ida_free+0xa0 (section: .text.ida_free) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ida_free+0xba (section: .text.ida_free) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ida_free+0xdc (section: .text.ida_free) -> devices_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ida_alloc_range+0x4c (section: .text.ida_alloc_range) -> devices_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ida_alloc_range+0x9c (section: .text.ida_alloc_range) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ida_alloc_range+0x31a (section: .text.ida_alloc_range) -> devices_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: kobj_kset_leave+0x2 (section: .text.kobj_kset_leave) -> save_async_options (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __kobject_del+0x18 (section: .text.__kobject_del) -> .LVL39 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x2aa (section: .text.mas_empty_area_rev) -> classes_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x2ba (section: .text.mas_empty_area_rev) -> classes_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x2c0 (section: .text.mas_empty_area_rev) -> classes_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x2d0 (section: .text.mas_empty_area_rev) -> classes_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x2da (section: .text.mas_empty_area_rev) -> classes_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x2ec (section: .text.mas_empty_area_rev) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x2fe (section: .text.mas_empty_area_rev) -> __platform_driver_probe (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x314 (section: .text.mas_empty_area_rev) -> __platform_driver_probe (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x328 (section: .text.mas_empty_area_rev) -> __platform_driver_probe (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x34c (section: .text.mas_empty_area_rev) -> __platform_driver_probe (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x398 (section: .text.mas_empty_area_rev) -> __platform_driver_probe (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x39e (section: .text.mas_empty_area_rev) -> __platform_driver_probe (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x3d4 (section: .text.mas_empty_area_rev) -> classes_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x400 (section: .text.mas_empty_area_rev) -> classes_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x42a (section: .text.mas_empty_area_rev) -> classes_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_dump_node+0x230 (section: .text.mt_dump_node) -> classes_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_dump_node+0x24a (section: .text.mt_dump_node) -> __platform_driver_probe (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_dump+0x20 (section: .text.mt_dump) -> classes_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_dump+0x32 (section: .text.mt_dump) -> classes_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_dump+0x42 (section: .text.mt_dump) -> classes_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_dump+0x4c (section: .text.mt_dump) -> classes_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_dump+0x56 (section: .text.mt_dump) -> classes_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_dump+0x7c (section: .text.mt_dump) -> classes_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_dump+0xd4 (section: .text.mt_dump) -> __platform_driver_probe (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x43e (section: .text.mas_empty_area) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x454 (section: .text.mas_empty_area) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x466 (section: .text.mas_empty_area) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x4b2 (section: .text.mas_empty_area) -> platform_bus_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x4ba (section: .text.mas_empty_area) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x4d2 (section: .text.mas_empty_area) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x532 (section: .text.mas_empty_area) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x548 (section: .text.mas_empty_area) -> __platform_create_bundle (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x572 (section: .text.mas_empty_area) -> .L461 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x574 (section: .text.mas_empty_area) -> __platform_create_bundle (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x57a (section: .text.mas_empty_area) -> __platform_create_bundle (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x592 (section: .text.mas_empty_area) -> .L459 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x5de (section: .text.mas_empty_area) -> .L457 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x5e4 (section: .text.mas_empty_area) -> .L458 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x5f0 (section: .text.mas_empty_area) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_root_expand+0x84 (section: .text.mas_root_expand) -> .L495 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_root_expand+0x98 (section: .text.mas_root_expand) -> cpu_dev_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_prev_range+0x18 (section: .text.mas_prev_range) -> classes_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_prev+0x18 (section: .text.mas_prev) -> classes_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __rb_insert_augmented+0xc8 (section: .text.__rb_insert_augmented) -> auxiliary_bus_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __rb_insert_augmented+0xe8 (section: .text.__rb_insert_augmented) -> auxiliary_bus_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __rb_insert_augmented+0xf8 (section: .text.__rb_insert_augmented) -> auxiliary_bus_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __rb_insert_augmented+0x102 (section: .text.__rb_insert_augmented) -> auxiliary_bus_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __rb_insert_augmented+0x114 (section: .text.__rb_insert_augmented) -> mount_param (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: rb_first+0x8 (section: .text.rb_first) -> mount_param (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: rb_first+0xa (section: .text.rb_first) -> mount_param (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: rb_first+0x10 (section: .text.rb_first) -> mount_param (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: rb_last+0x8 (section: .text.rb_last) -> mount_param (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: rb_last+0xa (section: .text.rb_last) -> mount_param (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: rb_last+0x10 (section: .text.rb_last) -> mount_param (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __rb_erase_color+0xda (section: .text.__rb_erase_color) -> auxiliary_bus_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __rb_erase_color+0xf8 (section: .text.__rb_erase_color) -> mount_param (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __rb_erase_color+0x188 (section: .text.__rb_erase_color) -> auxiliary_bus_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: 0x15a8 (section: __ex_table) -> .LASF2568 (section: .debug_str)
ERROR: modpost: __ex_table+0x15a8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x15ac (section: __ex_table) -> .LASF2570 (section: .debug_str)
ERROR: modpost: __ex_table+0x15ac references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x15b4 (section: __ex_table) -> .LASF2572 (section: .debug_str)
ERROR: modpost: __ex_table+0x15b4 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x15b8 (section: __ex_table) -> .LASF2574 (section: .debug_str)
ERROR: modpost: __ex_table+0x15b8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x15c0 (section: __ex_table) -> .LASF2576 (section: .debug_str)
ERROR: modpost: __ex_table+0x15c0 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x15c4 (section: __ex_table) -> .LASF2578 (section: .debug_str)
ERROR: modpost: __ex_table+0x15c4 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x15cc (section: __ex_table) -> .LASF2580 (section: .debug_str)
ERROR: modpost: __ex_table+0x15cc references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x15d0 (section: __ex_table) -> .LASF2574 (section: .debug_str)
ERROR: modpost: __ex_table+0x15d0 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x15d8 (section: __ex_table) -> .LASF2583 (section: .debug_str)
ERROR: modpost: __ex_table+0x15d8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x15dc (section: __ex_table) -> .LASF2574 (section: .debug_str)
ERROR: modpost: __ex_table+0x15dc references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x15e4 (section: __ex_table) -> .LASF2586 (section: .debug_str)
ERROR: modpost: __ex_table+0x15e4 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x15e8 (section: __ex_table) -> .LASF2588 (section: .debug_str)
ERROR: modpost: __ex_table+0x15e8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x15f0 (section: __ex_table) -> .L0  (section: __ex_table)
ERROR: modpost: __ex_table+0x15f0 references non-executable section '__ex_table'
WARNING: modpost: vmlinux: section mismatch in reference: 0x15f4 (section: __ex_table) -> .L0  (section: __ex_table)
ERROR: modpost: __ex_table+0x15f4 references non-executable section '__ex_table'
WARNING: modpost: vmlinux: section mismatch in reference: 0x15fc (section: __ex_table) -> .L0  (section: __ex_table)
ERROR: modpost: __ex_table+0x15fc references non-executable section '__ex_table'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1600 (section: __ex_table) -> firsttime (section: .data.firsttime.60983)
>> ERROR: modpost: __ex_table+0x1600 references non-executable section '.data.firsttime.60983'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1614 (section: __ex_table) -> .LASF230 (section: .debug_str)
ERROR: modpost: __ex_table+0x1614 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1618 (section: __ex_table) -> .LASF232 (section: .debug_str)
ERROR: modpost: __ex_table+0x1618 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1620 (section: __ex_table) -> .LASF234 (section: .debug_str)
ERROR: modpost: __ex_table+0x1620 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1624 (section: __ex_table) -> .LASF232 (section: .debug_str)
ERROR: modpost: __ex_table+0x1624 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x162c (section: __ex_table) -> .LASF237 (section: .debug_str)
ERROR: modpost: __ex_table+0x162c references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1630 (section: __ex_table) -> .LASF232 (section: .debug_str)
ERROR: modpost: __ex_table+0x1630 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1638 (section: __ex_table) -> .LASF240 (section: .debug_str)
ERROR: modpost: __ex_table+0x1638 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x163c (section: __ex_table) -> .LASF232 (section: .debug_str)
ERROR: modpost: __ex_table+0x163c references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1644 (section: __ex_table) -> .LASF243 (section: .debug_str)
ERROR: modpost: __ex_table+0x1644 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1648 (section: __ex_table) -> .LASF232 (section: .debug_str)
ERROR: modpost: __ex_table+0x1648 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1650 (section: __ex_table) -> .LASF246 (section: .debug_str)
ERROR: modpost: __ex_table+0x1650 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1654 (section: __ex_table) -> .LASF232 (section: .debug_str)
ERROR: modpost: __ex_table+0x1654 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x165c (section: __ex_table) -> .LASF249 (section: .debug_str)
ERROR: modpost: __ex_table+0x165c references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1660 (section: __ex_table) -> .LASF251 (section: .debug_str)
ERROR: modpost: __ex_table+0x1660 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1668 (section: __ex_table) -> .LASF253 (section: .debug_str)
ERROR: modpost: __ex_table+0x1668 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x166c (section: __ex_table) -> .LASF255 (section: .debug_str)
ERROR: modpost: __ex_table+0x166c references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1674 (section: __ex_table) -> .LASF257 (section: .debug_str)
ERROR: modpost: __ex_table+0x1674 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1678 (section: __ex_table) -> .LASF259 (section: .debug_str)
ERROR: modpost: __ex_table+0x1678 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1680 (section: __ex_table) -> .LASF261 (section: .debug_str)
ERROR: modpost: __ex_table+0x1680 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1684 (section: __ex_table) -> .LASF263 (section: .debug_str)
ERROR: modpost: __ex_table+0x1684 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x168c (section: __ex_table) -> .LASF265 (section: .debug_str)
ERROR: modpost: __ex_table+0x168c references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1690 (section: __ex_table) -> .LASF267 (section: .debug_str)
ERROR: modpost: __ex_table+0x1690 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1698 (section: __ex_table) -> .LASF269 (section: .debug_str)
ERROR: modpost: __ex_table+0x1698 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x169c (section: __ex_table) -> .LASF271 (section: .debug_str)
ERROR: modpost: __ex_table+0x169c references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x16a4 (section: __ex_table) -> .LASF273 (section: .debug_str)
ERROR: modpost: __ex_table+0x16a4 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x16a8 (section: __ex_table) -> .LASF275 (section: .debug_str)
ERROR: modpost: __ex_table+0x16a8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x16b0 (section: __ex_table) -> .LASF277 (section: .debug_str)
ERROR: modpost: __ex_table+0x16b0 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x16b4 (section: __ex_table) -> .LASF279 (section: .debug_str)
ERROR: modpost: __ex_table+0x16b4 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x16bc (section: __ex_table) -> .LASF281 (section: .debug_str)
ERROR: modpost: __ex_table+0x16bc references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x16c0 (section: __ex_table) -> .LASF283 (section: .debug_str)
ERROR: modpost: __ex_table+0x16c0 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x16c8 (section: __ex_table) -> .LASF285 (section: .debug_str)
ERROR: modpost: __ex_table+0x16c8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x16cc (section: __ex_table) -> .LASF287 (section: .debug_str)
ERROR: modpost: __ex_table+0x16cc references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x16d4 (section: __ex_table) -> .LASF289 (section: .debug_str)
ERROR: modpost: __ex_table+0x16d4 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x16d8 (section: __ex_table) -> .LASF291 (section: .debug_str)
ERROR: modpost: __ex_table+0x16d8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x16e4 (section: __ex_table) -> .LASF4984 (section: .debug_str)
ERROR: modpost: __ex_table+0x16e4 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x16ec (section: __ex_table) -> .LASF4986 (section: .debug_str)
ERROR: modpost: __ex_table+0x16ec references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x16f0 (section: __ex_table) -> .LASF4984 (section: .debug_str)
ERROR: modpost: __ex_table+0x16f0 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x16fc (section: __ex_table) -> .LASF4984 (section: .debug_str)
ERROR: modpost: __ex_table+0x16fc references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1704 (section: __ex_table) -> .LLST20 (section: .debug_loc)
ERROR: modpost: __ex_table+0x1704 references non-executable section '.debug_loc'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1708 (section: __ex_table) -> .LLST22 (section: .debug_loc)
ERROR: modpost: __ex_table+0x1708 references non-executable section '.debug_loc'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1710 (section: __ex_table) -> .LLST23 (section: .debug_loc)
ERROR: modpost: __ex_table+0x1710 references non-executable section '.debug_loc'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1714 (section: __ex_table) -> .LASF4984 (section: .debug_str)
ERROR: modpost: __ex_table+0x1714 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x171c (section: __ex_table) -> .LASF270 (section: .debug_str)
ERROR: modpost: __ex_table+0x171c references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1720 (section: __ex_table) -> .LASF272 (section: .debug_str)
ERROR: modpost: __ex_table+0x1720 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x174c (section: __ex_table) -> .LASF1801 (section: .debug_str)
ERROR: modpost: __ex_table+0x174c references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1750 (section: __ex_table) -> .LASF1803 (section: .debug_str)
ERROR: modpost: __ex_table+0x1750 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1758 (section: __ex_table) -> .LASF1805 (section: .debug_str)
ERROR: modpost: __ex_table+0x1758 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x175c (section: __ex_table) -> .LASF1807 (section: .debug_str)
ERROR: modpost: __ex_table+0x175c references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1764 (section: __ex_table) -> .LASF1809 (section: .debug_str)
ERROR: modpost: __ex_table+0x1764 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1768 (section: __ex_table) -> .LASF1807 (section: .debug_str)
ERROR: modpost: __ex_table+0x1768 references non-executable section '.debug_str'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

