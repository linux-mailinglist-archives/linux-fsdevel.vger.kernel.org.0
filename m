Return-Path: <linux-fsdevel+bounces-3770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F41927F7E75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 19:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86170B2181F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 18:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE522D626;
	Fri, 24 Nov 2023 18:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jaWjMZ7u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E46519AF
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 10:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WM5jYGVE1qQKCvhlw2uts5rwFaZkRSnVDRMzHEeiAhY=; b=jaWjMZ7ubKMq30eUadv8Ked0Vl
	b2iyoHerjeJTWHXXKDGYK/Ag72XDXoiwpGrgQ17dtn3vksvOCd77X8CiMYEVjz+lFKM5dDmkW8M6B
	BvA9AYC7UsuVxgulBy1kHbUuQlTxWM70Ybqmbtdfn9CvIDYHd+RkNz8NR7a7QVTH0oDIFtGQvFYga
	0f5ukjvN47QzTKat+YocPw/8P/yXe4ssPnfhbPEcmOufYv/XFjYfvpQxxatNtD6V2torsSkzp+POa
	EUldDrfQNs/lksgjC31KIxjlFbqZibooFOMZLumq+lJIgT6/xjmNs9yQnGQXKkuXS5JtomoPvGdG9
	Oo9E/f6Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6axL-002fQt-27;
	Fri, 24 Nov 2023 18:31:11 +0000
Date: Fri, 24 Nov 2023 18:31:11 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [viro-vfs:work.csum-x86 4/18]
 arch/x86/include/asm/checksum_32.h:41:57: sparse: sparse: incorrect type in
 argument 1 (different base types)
Message-ID: <20231124183111.GZ38156@ZenIV>
References: <202311250010.dikaDI0D-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202311250010.dikaDI0D-lkp@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Nov 25, 2023 at 01:50:29AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.csum-x86
> head:   f6c1313680f1d2319d2061c63abeb76f820319b8
> commit: 90c2bfd06916ac7c05129b36683bfd3424d8e0e4 [4/18] Fix the csum_and_copy_..._user() idiocy
> config: i386-randconfig-061-20231124 (https://download.01.org/0day-ci/archive/20231125/202311250010.dikaDI0D-lkp@intel.com/config)
> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231125/202311250010.dikaDI0D-lkp@intel.com/reproduce)

Same as the previous one; should be fixed in force-pushed branch, head
at 6b5df59ad78f.

