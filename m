Return-Path: <linux-fsdevel+bounces-74876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPL9AkkGcWmPcQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 18:00:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0C05A437
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 18:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E893776ED03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 15:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24BE2E11AA;
	Wed, 21 Jan 2026 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+SSvW6y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0DE3BBA1E
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769008967; cv=none; b=ewwLnrJPjn3DKvGFt6aHnHgzDEpIZH4sAZrjE9u71jPy/PKZpxF4GkjmWUCdbTxIuEka6C55O4aZUy53pXEBUVKp363MLTSsUZ0sC1ni2k6rUWKfLh5ySUn7yK1QcOzIF0Jvi/aQkvOe09GPVJWYZ8KPIoQo0r2uOZUavNa+ayY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769008967; c=relaxed/simple;
	bh=+m3wJD/632zFUoo0MClqfuzJLlQ31KltH6EMrtCC5EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2CAUaZ6PxqTgbsqEkSNVrNCwRzg7QlyXmfYgnkJ6I2DgF+bVn3zuWSKUxLm37X/NF+gL+VrM4zVLKgUtoD0ssNQEfSKVRUmcUEMreSLoQ4DL58rj25kgNJVBBXVMxQq26FmJUr+ctncy3kJdQx0U0utxF9IYKP44PtXIbGRBmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+SSvW6y; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769008965; x=1800544965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+m3wJD/632zFUoo0MClqfuzJLlQ31KltH6EMrtCC5EE=;
  b=l+SSvW6yX7cdzXBnnzT59xbfZ0iVGpDhBeu8oMIixkUIMx4BtCkz6uNT
   8wpJya7RPefmFvv1u6BpFTajgBl4owDhz7DdPpeHzKcB/v9TrJdwOn44R
   LvvRx5blfnuUR3uytlnbjnkRBcU+CrSrba3KsZsV5yr5SsVMReft4zT5d
   n/nOQ/C0YC8+9C/Sl2NTLPppza2k4KF9fPrnK4rddoR5Xp2rSabvF1ZxE
   7LoFim7nnR7uOF74E4sWMsVw+tBEk5j1JDeBO0MfIsMv29pWB+kdZCSk5
   d8jQtJ3kcArEJY2zmrdyKYsgeW0QATzxNOH3t+uquCtWAN4g33bqmjhC9
   g==;
X-CSE-ConnectionGUID: ChpqYVy0QHS/asb3R6T/xA==
X-CSE-MsgGUID: t2+/HV4BQKmbXbdFxtG//g==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="80957212"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="80957212"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 07:22:44 -0800
X-CSE-ConnectionGUID: y1xVM4ATTvmsGSiLVxYH0w==
X-CSE-MsgGUID: /MuELCEmT7imYbyiFg3BXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="210976893"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 21 Jan 2026 07:22:42 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1via2a-00000000RLB-0J0h;
	Wed, 21 Jan 2026 15:22:40 +0000
Date: Wed, 21 Jan 2026 23:22:25 +0800
From: kernel test robot <lkp@intel.com>
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: oe-kbuild-all@lists.linux.dev, jefflexu@linux.alibaba.com,
	luochunsheng@ustc.edu, djwong@kernel.org, horst@birthelmer.de,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] fuse: simplify logic in fuse_notify_store() and
 fuse_retrieve()
Message-ID: <202601212244.rmkLqQQc-lkp@intel.com>
References: <20260120224449.1847176-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120224449.1847176-3-joannelkoong@gmail.com>
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_FROM(0.00)[bounces-74876-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,szeredi.hu];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:email,intel.com:dkim,intel.com:mid,git-scm.com:url,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 6B0C05A437
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Joanne,

kernel test robot noticed the following build errors:

[auto build test ERROR on mszeredi-fuse/for-next]
[also build test ERROR on linus/master v6.19-rc6]
[cannot apply to next-20260120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joanne-Koong/fuse-validate-outarg-offset-and-size-in-notify-store-retrieve/20260121-074942
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next
patch link:    https://lore.kernel.org/r/20260120224449.1847176-3-joannelkoong%40gmail.com
patch subject: [PATCH v2 2/4] fuse: simplify logic in fuse_notify_store() and fuse_retrieve()
config: powerpc-randconfig-r073-20260121 (https://download.01.org/0day-ci/archive/20260121/202601212244.rmkLqQQc-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 8.5.0
smatch version: v0.5.0-8985-g2614ff1a
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260121/202601212244.rmkLqQQc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601212244.rmkLqQQc-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   In function 'fuse_notify_store',
       inlined from 'fuse_notify' at fs/fuse/dev.c:2107:10:
>> include/linux/compiler_types.h:631:38: error: call to '__compiletime_assert_495' declared with attribute error: min(outarg.size, ((loff_t)(~0UL) << 12) - pos) signedness error
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                         ^
   include/linux/compiler_types.h:612:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler_types.h:631:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:93:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__types_ok(ux, uy),  \
     ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:98:2: note: in expansion of macro '__careful_cmp_once'
     __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
     ^~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:105:19: note: in expansion of macro '__careful_cmp'
    #define min(x, y) __careful_cmp(min, x, y)
                      ^~~~~~~~~~~~~
   fs/fuse/dev.c:1788:8: note: in expansion of macro 'min'
     num = min(outarg.size, MAX_LFS_FILESIZE - pos);
           ^~~


vim +/__compiletime_assert_495 +631 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  617  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  618  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  619  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  620  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  621  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  622   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  623   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  624   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  625   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  626   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  627   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  628   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  629   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  630  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @631  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  632  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

