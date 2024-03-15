Return-Path: <linux-fsdevel+bounces-14483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6FF87D0CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 16:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F0A9B22DF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 15:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D4540BE7;
	Fri, 15 Mar 2024 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ceZTRWDN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD893D572;
	Fri, 15 Mar 2024 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710518227; cv=none; b=VDkkpnkpdaYLvgB3P0BBt88vZwuZWYxm7Py1zxalrDG7jL5Wj2AKus+Ya6X87ceTl4pYd1O00E1+DGxNQJxUEQrAQbzV0GWpzu/2isyzfYB7N4uuxUmZ2stnjOuUI+VHNeQ7diScfOwdY32xD15w4nq3LPDKZ9xYixga7yFC57c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710518227; c=relaxed/simple;
	bh=grogreiidhzKqAV6xg9uMv/owUhYnmKI3PkZ8cq+HNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqGhMIE6Vh/UOnEFGyAhspvPr+/oofFYDLgVQzizxdYFz6Q3X+zQUkUNcgElIfuya8+dXKVKKpv7Gkkp1g1Ek3nnVE7GlWUjhIm/W2JuA43O5pDI/fjqRGFp8EUCTP10kHTz8c89yEc0kiffrsgW++EJ6nLu2qW2RYy5x1yMOB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ceZTRWDN; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1710518215;
	bh=grogreiidhzKqAV6xg9uMv/owUhYnmKI3PkZ8cq+HNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ceZTRWDNRvuzxzGijbjZJg3nr9DGsQkjB92AO84nlvcUzm7IvHOfh27MxrgzFvvx9
	 qOM02fuXEziQhOpP07FWkzvec3WLJBuW8kNYukuK8owgbnYDo0Jy49oEVAU7hfT0Ot
	 P20FWjVcteGLnN1Vvg9j0wWrpyoXRZG0nMLl40yI=
Date: Fri, 15 Mar 2024 16:56:54 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Joel Granados <j.granados@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Kees Cook <keescook@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] sysctl: drop unused argument set_ownership()::table
Message-ID: <838812fc-d1ee-4088-a704-8b8f15caab13@t-8ch.de>
References: <CGME20240223155011eucas1p245e00a3dfd23f72997dac4952ebaeebf@eucas1p2.samsung.com>
 <20240223-sysctl-const-ownership-v2-1-f9ba1795aaf2@weissschuh.net>
 <20240315154134.5qfq6wucxid5kfmc@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240315154134.5qfq6wucxid5kfmc@joelS2.panther.com>

On 2024-03-15 16:41:34+0100, Joel Granados wrote:
> Hey Thomas
> 
> Did you forget to compile? I'm seeing the following error when I
> compile:

Welp...

>   ...
>   ../fs/proc/proc_sysctl.c: In function ‘proc_sys_make_inode’:
>   ../fs/proc/proc_sysctl.c:483:43: error: passing argument 2 of ‘root->set_ownership’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>     483 |                 root->set_ownership(head, table, &inode->i_uid, &inode->i_gid);
>         |                                           ^~~~~
>         |                                           |
>         |                                           struct ctl_table *
>   ../fs/proc/proc_sysctl.c:483:43: note: expected ‘kuid_t *’ but argument is of type ‘struct ctl_table *’
>   ../fs/proc/proc_sysctl.c:483:50: error: passing argument 3 of ‘root->set_ownership’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>     483 |                 root->set_ownership(head, table, &inode->i_uid, &inode->i_gid);
>         |                                                  ^~~~~~~~~~~~~
>         |                                                  |
>         |                                                  kuid_t *
>   ../fs/proc/proc_sysctl.c:483:50: note: expected ‘kgid_t *’ but argument is of type ‘kuid_t *’
>   ../fs/proc/proc_sysctl.c:483:17: error: too many arguments to function ‘root->set_ownership’
>     483 |                 root->set_ownership(head, table, &inode->i_uid, &inode->i_gid);
>         |                 ^~~~
>   cc1: some warnings being treated as errors
>   make[5]: *** [../scripts/Makefile.build:243: fs/proc/proc_sysctl.o] Error 1
>     CC      fs/xfs/libxfs/xfs_dir2_node.o
>   make[5]: *** Waiting for unfinished jobs....
>   ...
> 
> I'm guessing its just a matter of removing the table arg from
> proc_sys_make_inode?

Yes, for this error it's correct.

There are also new implementors of the set_ownership callback in ipc/
which need to be adapted.

I'll send a new revision.

Thomas

