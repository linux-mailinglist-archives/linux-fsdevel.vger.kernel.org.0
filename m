Return-Path: <linux-fsdevel+bounces-48632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9ACAB1A13
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 18:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D431173565
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 16:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC16022F757;
	Fri,  9 May 2025 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="IYbqFhNL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5391318DF8D;
	Fri,  9 May 2025 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746807078; cv=none; b=eO0k0q0EN+imxHuxVwUz89VyCx2+e1oBQQF5TJuDdFP/nGKKhQJoDlJJqz25IodmskiiyAkIkmtMP4BXw3WIuwNW5IwfrusY3tt+VcT+2UVNdqHGRpDN8BBkjgez/jH3OFZKxqkjFVpwXN4h9bs8Bdy42OON3j7e5dMUeAGv//8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746807078; c=relaxed/simple;
	bh=DkVPEwXq5LEd8phpizlGw24qYJuQeTZBQGQZxBGSslk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cS3Y3D0Su6+wiohQQUQ9DtZp/V0oZUWR7FzgwyBVq31yqog5vrKkbxH9nthbZPPLei5+Vu7pK5kgb8hiTPgdXR6spoprKKaViiz45oBSVpbF1k9AirirvVaLWi0uPBGmdvKWrmJQ0RWIzMg13DeYLrzytMPVDsCgsyCLjjJF+ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=IYbqFhNL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ru3Psh63tMF04aB59rcC/KiAWCC4Jih9Q0TM6aAwHQk=; b=IYbqFhNLlzZpJDoUGW4j7XFGr3
	xYI3V6qewxfbX3/u4MmjmUmyzOJJSVza1ks8Ztd1EeYhHHY/F6VTl+OeM0ZfzY4TQN8+fZsa+fdYc
	IdXqdg3EEuoYURxD0jFITqcwTre1FwdnVq1GOochNthnq1eZbby8Jv+zhXxuCNIV/3wi/HNkyRvs2
	dJKaQCa/cKaZVqvS70ZzABIDsYJjVhDEpEFm/g2ocf++zV5KyNbefaygRDTr9Y/XNkqKtmikaQZ3H
	vA60S64LSDCvXYqjCIRVzZ1xpW8IgDX9gVF2MlxdPVH/xUv+v/0KejMQULYLXZsJ+eEwt9skN+6T1
	fGMjvmmg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDQJc-0000000ClvS-3a4Y;
	Fri, 09 May 2025 16:11:13 +0000
Date: Fri, 9 May 2025 17:11:12 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [viro-vfs:untested.securityfs 6/8]
 security/integrity/ima/ima_fs.c:524:27: error: 'ima_policy' undeclared; did
 you mean 'vma_policy'?
Message-ID: <20250509161112.GW2023217@ZenIV>
References: <202505092310.0UXOhVZP-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505092310.0UXOhVZP-lkp@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 09, 2025 at 11:47:36PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git untested.securityfs
> head:   b0b8e25f92ec20e266859de5f823b4e39b8e2f9d
> commit: 08433f2507554980bc891d8b17c1968c81cb144b [6/8] ima_fs: don't bother with removal of files in directory we'll be removing
> config: i386-buildonly-randconfig-006-20250509 (https://download.01.org/0day-ci/archive/20250509/202505092310.0UXOhVZP-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250509/202505092310.0UXOhVZP-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202505092310.0UXOhVZP-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    security/integrity/ima/ima_fs.c: In function 'ima_release_policy':
> >> security/integrity/ima/ima_fs.c:524:27: error: 'ima_policy' undeclared (first use in this function); did you mean 'vma_policy'?
>      524 |         securityfs_remove(ima_policy);
>          |                           ^~~~~~~~~~
>          |                           vma_policy
>    security/integrity/ima/ima_fs.c:524:27: note: each undeclared identifier is reported only once for each function it appears in

	Yeah, that line also needs to be removed - it's handled by
securityfs_remove(ima_dir); a few lines later.

