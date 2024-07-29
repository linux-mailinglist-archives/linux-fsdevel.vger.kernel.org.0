Return-Path: <linux-fsdevel+bounces-24517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8A193FFBE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 22:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F5328280A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 20:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9AD16B73E;
	Mon, 29 Jul 2024 20:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mDISQsJZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE9383A19;
	Mon, 29 Jul 2024 20:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722285926; cv=none; b=hl4PpcqhpCGJy70gpZyZM9kV9g0qns3hyOMuNvsyj/oBRxvz1vCLdxILtnxPFjQvJRFfmxkxl2KxEvntjsHs9GK8K0uIvcuZefKGSBjSYqgPirHKS+Dk7KJxxao0gm9jShFZJPidNrpoONSsz9lxCEiwaS+BreeXn0Pkvpy9XpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722285926; c=relaxed/simple;
	bh=zjWW2z0WrqLlJ9jGj/w46cxPCs4ZeXg1VlAUV/oJkqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxvOxscDOjEJz4f6YJblFm7jRH1J++UFOizEp6Fg0xM9xnoeupQGOjCBTmhh+uyDS3xoBdBqalZ1O0bpr9jvF6yieG8+MExANjaF0LdSJbdSCMHBRUiwFfUEZXyrQZe2ikZIuWYvpdsSmUCg6/n8J2rN+riaz6KeyW099nrOqwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mDISQsJZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QXiFNqR95rRgxhRhivrlSIdOIFsMFrNKmKSms7R9eDM=; b=mDISQsJZXZfbT2EoaB5BhB58b6
	vtrrduX/iEw6fBVyPg23XEjUGLId+YPrqUzS4r4Kv744VBMYZrxocYaKsZKUae9QIl+KBobRgN50G
	F2EDf6MvQ1GghmH1cExCOqcm5mcgw1v/eak6NpcZRC60S/1dH0plxYZXTdXjMCiaYGKAtAJD+Kfbj
	EtICxSliQfLt6EDAu2dDh6ZN39t21nUozB/padTw1sogsPpuVnDDNyBh6KBpSRAwlxFe6YFDAaSI3
	CddeIhe/21MgZjyP8Kpuf8yEU7mNI/8ssIH0315pks06qR0UWZIINqvhMjC/qrSzDHVLdztGviL0b
	meZjrGlA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sYXFA-0000000046g-3nCm;
	Mon, 29 Jul 2024 20:45:20 +0000
Date: Mon, 29 Jul 2024 21:45:20 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [viro-vfs:work.fd 28/39] include/linux/cleanup.h:111:21: error:
 function declaration isn't a prototype
Message-ID: <20240729204520.GB5334@ZenIV>
References: <202407292309.QXlzRsZS-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202407292309.QXlzRsZS-lkp@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jul 29, 2024 at 11:07:02PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.fd
> head:   154eb19a802fdf8629273d414dbeb31eccb61587
> commit: a5027b86a79716e98fe0b8e1247743dfb5a5c080 [28/39] switch spufs_calls_{get,put}() to CLASS() use
> config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20240729/202407292309.QXlzRsZS-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240729/202407292309.QXlzRsZS-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407292309.QXlzRsZS-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/file.h:14,
>                     from arch/powerpc/platforms/cell/spu_syscalls.c:10:
> >> include/linux/cleanup.h:111:21: error: function declaration isn't a prototype [-Werror=strict-prototypes]
>      111 | static inline _type class_##_name##_constructor(_init_args)             \
>          |                     ^~~~~~
>    arch/powerpc/platforms/cell/spu_syscalls.c:59:1: note: in expansion of macro 'DEFINE_CLASS'
>       59 | DEFINE_CLASS(spufs_calls, struct spufs_calls *, spufs_calls_put(_T), spufs_calls_get())
>          | ^~~~~~~~~~~~
>    cc1: some warnings being treated as errors

Bollocks galore:

1) gcc does not catch e.g.
	if (foo)
		goto l;
	void *p __free(kfree) = NULL;
	...
l:
	...
and quietly passes an uninitialized value to kfree().  clang catches that.

2) clang, OTOH, does not feel obliged to object against DEFINE_CLASS with
4 arguments and constructor that takes no arguments at all.  gcc produces
the splat above...

Joy...

