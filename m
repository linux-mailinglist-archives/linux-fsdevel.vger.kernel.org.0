Return-Path: <linux-fsdevel+bounces-3769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FBE7F7E3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 19:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73739B20F38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 18:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EB73A8E0;
	Fri, 24 Nov 2023 18:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="a3wgP4U1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4A21BF0
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 10:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FMVUxh6tSlFmggPGLX4oxXt/2qrB4iTnmvbcYFMb6jE=; b=a3wgP4U1An+Tbt8IilTQd0CYXS
	oWV+Wr9cAa58ObS1JgLBojqPm0f3nSx3F53S14ZyiyOWbgFs+36/LQ/wFoa2A4d8iieVb8o2hwVLP
	wTWVD+yFjWtcwN7iF+q8GJxycCqmWUK90f9VPMRLUUznC6oBJ1YuUyqEod2cA7W0+NEt22NccToAh
	D5MxxOUHyuAzJ4q3BfpsgQEespAQi/Un+yvFLAha40MwcrX2hCutqZER0t7wKu6JHVKGQ+/2BptQQ
	5UjpfhGMLdFKNAnWYdvVroLNIYvO7KHPTz8KVbxIVwsknLGhERqUb/b5rRjegdsnjo4wSDQvr9nDl
	xQtBP8ng==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6avq-002fOv-1u;
	Fri, 24 Nov 2023 18:29:38 +0000
Date: Fri, 24 Nov 2023 18:29:38 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [viro-vfs:work.csum-x86 4/18] net/core/datagram.c:745:55:
 sparse: sparse: incorrect type in argument 1 (different base types)
Message-ID: <20231124182938.GY38156@ZenIV>
References: <202311250023.ySjyjo9L-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202311250023.ySjyjo9L-lkp@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Nov 25, 2023 at 01:50:33AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.csum-x86
> head:   f6c1313680f1d2319d2061c63abeb76f820319b8
> commit: 90c2bfd06916ac7c05129b36683bfd3424d8e0e4 [4/18] Fix the csum_and_copy_..._user() idiocy
> config: x86_64-randconfig-123-20231124 (https://download.01.org/0day-ci/archive/20231125/202311250023.ySjyjo9L-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231125/202311250023.ySjyjo9L-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311250023.ySjyjo9L-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> net/core/datagram.c:745:55: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __wsum [usertype] v @@     got restricted __wsum_fault [usertype] next @@
>    net/core/datagram.c:745:55: sparse:     expected restricted __wsum [usertype] v
>    net/core/datagram.c:745:55: sparse:     got restricted __wsum_fault [usertype] next
> >> net/core/datagram.c:745:54: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __wsum [usertype] csum2 @@     got restricted __wsum_fault @@
>    net/core/datagram.c:745:54: sparse:     expected restricted __wsum [usertype] csum2
>    net/core/datagram.c:745:54: sparse:     got restricted __wsum_fault
>    net/core/datagram.c: note: in included file (through include/linux/skbuff.h, include/net/net_namespace.h, include/linux/inet.h):
>    include/net/checksum.h:36:17: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __wsum_fault @@     got restricted __wsum [usertype] @@
>    include/net/checksum.h:36:17: sparse:     expected restricted __wsum_fault
>    include/net/checksum.h:36:17: sparse:     got restricted __wsum [usertype]
> --
> >> net/core/skbuff.c:6971:55: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __wsum [usertype] v @@     got restricted __wsum_fault [usertype] next @@
>    net/core/skbuff.c:6971:55: sparse:     expected restricted __wsum [usertype] v
>    net/core/skbuff.c:6971:55: sparse:     got restricted __wsum_fault [usertype] next
> >> net/core/skbuff.c:6971:54: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __wsum [usertype] csum2 @@     got restricted __wsum_fault @@
>    net/core/skbuff.c:6971:54: sparse:     expected restricted __wsum [usertype] csum2
>    net/core/skbuff.c:6971:54: sparse:     got restricted __wsum_fault
>    net/core/skbuff.c: note: in included file (through include/net/net_namespace.h, include/linux/inet.h):
>    include/linux/skbuff.h:2703:28: sparse: sparse: self-comparison always evaluates to false
>    net/core/skbuff.c: note: in included file (through include/linux/skbuff.h, include/net/net_namespace.h, include/linux/inet.h):
>    include/net/checksum.h:36:17: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __wsum_fault @@     got restricted __wsum [usertype] @@
>    include/net/checksum.h:36:17: sparse:     expected restricted __wsum_fault
>    include/net/checksum.h:36:17: sparse:     got restricted __wsum [usertype]

Gyah... misannotated from_wsum_fault() - argument is __wsum_fault and
result is __wsum, not the other way round.  Fixed and force-pushed...

