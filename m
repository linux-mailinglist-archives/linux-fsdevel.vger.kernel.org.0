Return-Path: <linux-fsdevel+bounces-18930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF488BE9E3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 18:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B8628942A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 16:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4B85380E;
	Tue,  7 May 2024 16:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="STQJDLXE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C2743687;
	Tue,  7 May 2024 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715101001; cv=none; b=gMgBqcZyNqqYzdbVFU2OxAP8/6hSO5qN6o5xTN2jnQtiBWscKT0LRsvB0hjZHLyc4TaEA3vT7e8FSKw+Y2/sfcpGmvwwtfEnAeKqbduT06vsl6sOxExfTUecXojf5joKc95LZOdZjU7+ruOTwQ4Km8hZOEB6TSI6ucwi3WAk7yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715101001; c=relaxed/simple;
	bh=WNR6B5n6ha6J0gkFZyAWNDYB51k7sc/lxX0wqZoPPL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6ls/HL+ZlfkjPGDagWPitDgT2MeBeN7gOcc5uAhRg5ZUbZ6RWNxgiYnSiGjP9CgaMoGmrpL0D5RmGYoFtn9st5d1bfEs8wWxgQ/sc8vCI7VXZp1iGqnNpRZOjC47B5Cca+oepXkSzsfFfav2NEgJFqQO2BqtuCNY2iwomU165w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=STQJDLXE; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715100999; x=1746636999;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WNR6B5n6ha6J0gkFZyAWNDYB51k7sc/lxX0wqZoPPL4=;
  b=STQJDLXEOFz/VnZ9cAOt9ljnjjJGWYbVjEtMTFMaX8EP2woZ7GkC49gt
   x6zvSJiHkChzA1c9NaWn1GDCTq1rxTaLA1AcQuBzwHHUh6s5hD7P+li4z
   IUaVe0v0LtrUJ6Dgia8r59ugv+I0mx4RlzYM+w8Xaf7OiWcNGIhQkfkd1
   BLR8cbsupafmvBq7t/AVetNnsZG3E2ZiBbKSNnaN6xuqio6UhEsjmk4eX
   VizVAIH6q/Fr36Ai6MsgcQ4H/NUzJi4BHir/W8NxB02Lc0IdaqgvO1rV+
   e1tykO87WqPgBsdeH04jJiXLiZi3zGUVPoCVwaUyLJufXZylxMQCk4pZ1
   A==;
X-CSE-ConnectionGUID: s2vvgnfESUyNlav/anpysA==
X-CSE-MsgGUID: PoTxNq/XTMW7oFkP9L7bVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="28389940"
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="28389940"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 09:56:39 -0700
X-CSE-ConnectionGUID: U+rezoHNRJOjxI0HG2dJLA==
X-CSE-MsgGUID: TLvsEUQuRkSN2hUeGtSpgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="33147705"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 07 May 2024 09:56:35 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4O7F-0002Mg-1N;
	Tue, 07 May 2024 16:56:33 +0000
Date: Wed, 8 May 2024 00:55:47 +0800
From: kernel test robot <lkp@intel.com>
To: Allen Pais <apais@linux.microsoft.com>, linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, ebiederm@xmission.com, keescook@chromium.org,
	mcgrof@kernel.org, j.granados@samsung.com, allen.lkml@gmail.com
Subject: Re: [PATCH v4] fs/coredump: Enable dynamic configuration of max file
 note size
Message-ID: <202405080045.cTS3F5Or-lkp@intel.com>
References: <20240506193700.7884-1-apais@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506193700.7884-1-apais@linux.microsoft.com>

Hi Allen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kees/for-next/execve]
[also build test WARNING on brauner-vfs/vfs.all linus/master v6.9-rc7 next-20240507]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Allen-Pais/fs-coredump-Enable-dynamic-configuration-of-max-file-note-size/20240507-033907
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
patch link:    https://lore.kernel.org/r/20240506193700.7884-1-apais%40linux.microsoft.com
patch subject: [PATCH v4] fs/coredump: Enable dynamic configuration of max file note size
config: arm64-randconfig-r054-20240507 (https://download.01.org/0day-ci/archive/20240508/202405080045.cTS3F5Or-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240508/202405080045.cTS3F5Or-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405080045.cTS3F5Or-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/coredump.c:67:27: warning: 'core_file_note_size_max' defined but not used [-Wunused-const-variable=]
      67 | static const unsigned int core_file_note_size_max = CORE_FILE_NOTE_SIZE_MAX;
         |                           ^~~~~~~~~~~~~~~~~~~~~~~


vim +/core_file_note_size_max +67 fs/coredump.c

    62	
    63	static int core_uses_pid;
    64	static unsigned int core_pipe_limit;
    65	static char core_pattern[CORENAME_MAX_SIZE] = "core";
    66	static int core_name_size = CORENAME_MAX_SIZE;
  > 67	static const unsigned int core_file_note_size_max = CORE_FILE_NOTE_SIZE_MAX;
    68	unsigned int core_file_note_size_min = CORE_FILE_NOTE_SIZE_DEFAULT;
    69	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

