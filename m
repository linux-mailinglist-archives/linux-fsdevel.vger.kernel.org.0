Return-Path: <linux-fsdevel+bounces-41319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AFCA2DF54
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 18:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E341641A3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 17:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8891E0B7D;
	Sun,  9 Feb 2025 17:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LTg/wK2P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6D8EAC6;
	Sun,  9 Feb 2025 17:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739121979; cv=none; b=Fjj0Ir+716edv6rgIPnx0eGkbq3lxsysDjoXvsjKmFWCTjyynhqHrrd8DpdvDJGNPVmEXzP6/ngPrULntTJOo/X4oQvi9pEoLFFugZWXYfp/nMOfGZ+L42cPVUytjZZXWvskQoWG2974q1Q249dQjDqEWmNaYQbBPbcVrDpYVrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739121979; c=relaxed/simple;
	bh=1+LNXsFOjhvHxlmKQUdFR2fSkH2jqnxwgGL7iflJX1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hceBHhcMuP+1E5w1KufCajgLPRYvh6oc2jS+4Bt/lGMiBl5a2b57yeOmDoEOK/NA+S+Bk7P3+KH1naO7p/n9uAyE51ias4Xku+rheJ/sxfkAyeI1l3pi5qN4x27dTs34fCbdNWqP5uvp4jp6hjBGuaUmg+55nXdtONJ7UhmdDJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LTg/wK2P; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739121978; x=1770657978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1+LNXsFOjhvHxlmKQUdFR2fSkH2jqnxwgGL7iflJX1w=;
  b=LTg/wK2PdTD/ve3aJ+p80vfrFoF/1dXYy9AU/uSlrBQRTuLIIIac+zSJ
   lz/rx2TrWiQyAh2yZeqrCI09BoIVOpcN8EWUxKDUwZwNMw3LBxh+bAsvr
   EhnZCcK2J8A/uuEfWpDWS6/sjRPzMOnPGtYwtqqGUpnA6in5etFUVuLTF
   u/TWuoRsk7SKOVhsUPFlpHrWpLzamOfVP40PQaDE306EB7Xxny/nyBVyJ
   Ouc1cSxJEpoGUy00HE37zyDs40+pC9TglyTr4NHGK+SVRxdIIOIG7xy17
   8//gueS0iZIU6llcXBKNF8LS9Z2RMh/R7Of/3rqvgddcAt5Om26+g4ax3
   Q==;
X-CSE-ConnectionGUID: NKvPYSheQ/6qX2nnu7bWcg==
X-CSE-MsgGUID: nZb5oYoMTi2CJVANTPaH+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="39572710"
X-IronPort-AV: E=Sophos;i="6.13,272,1732608000"; 
   d="scan'208";a="39572710"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 09:26:17 -0800
X-CSE-ConnectionGUID: CENKPEMsQ3q0DcqTYJb+Gw==
X-CSE-MsgGUID: bGEHtzYgQUCL+84ElruMjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,272,1732608000"; 
   d="scan'208";a="142848039"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 09 Feb 2025 09:26:16 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1thB4P-0011jL-1I;
	Sun, 09 Feb 2025 17:26:13 +0000
Date: Mon, 10 Feb 2025 01:25:58 +0800
From: kernel test robot <lkp@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH v3 3/3] vfs: use the new debug macros in
 inode_set_cached_link()
Message-ID: <202502100145.hCrPMGW4-lkp@intel.com>
References: <20250208162611.628145-4-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250208162611.628145-4-mjguzik@gmail.com>

Hi Mateusz,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on next-20250207]
[cannot apply to brauner-vfs/vfs.all viro-vfs/for-next akpm-mm/mm-nonmm-unstable v6.14-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mateusz-Guzik/vfs-add-initial-support-for-CONFIG_VFS_DEBUG/20250209-002857
base:   linus/master
patch link:    https://lore.kernel.org/r/20250208162611.628145-4-mjguzik%40gmail.com
patch subject: [PATCH v3 3/3] vfs: use the new debug macros in inode_set_cached_link()
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20250210/202502100145.hCrPMGW4-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250210/202502100145.hCrPMGW4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502100145.hCrPMGW4-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "dump_inode" [fs/ext4/ext4.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

