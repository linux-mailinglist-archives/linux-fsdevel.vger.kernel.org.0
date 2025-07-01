Return-Path: <linux-fsdevel+bounces-53489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1F1AEF886
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 14:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0459217B200
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 12:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67182273D62;
	Tue,  1 Jul 2025 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/5syfPQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC37D26E173;
	Tue,  1 Jul 2025 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372987; cv=none; b=FXV4EE0NIwI16M/oLUluUKvt9BAr1QL0CBsC2iAecgENPyPsDuoYc5NubRcMTN7j20UL23tH8XYBrs9KK8ythmgKgqQcHKvOFMKU+A0lObKIqHUZ2hQJLxnXfY/e3JZPcUFxpLemqXXJV/+bz4fBpm+X8Wb4Ek30inkt5LjrheY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372987; c=relaxed/simple;
	bh=j9I8HOGBGHBbRN4p6Ae04QWoztYWFTPWSDJVpPf/55s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghmfu2Qur3opBfywF8cv/eJkvS9mXb7c7XyDdbldwJrqxS30rrSYFkdhyrKoJ5OwXAuiBbFcKdG9puSJ0mh3zrW1Ekuj3EymYF8cJlGGARf1LIgHU+tKm+c6jBF2ObZv/7IIvo8dqAf1ea8+ra/7SUwH5YZqEn1rsqihSlEPP8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/5syfPQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B50C4CEEB;
	Tue,  1 Jul 2025 12:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751372987;
	bh=j9I8HOGBGHBbRN4p6Ae04QWoztYWFTPWSDJVpPf/55s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z/5syfPQTlf+ZWQy7hY4VLoPj10mA+0NQtMwsDg8CG0nF7pvpHDnWOLMhZV8w9zHa
	 vZRKggAozrfcYtz+O0k4N6E+bFTWUrxoZTt4XujZ81HYPGhziY6Hy5hh3+1f72pkO6
	 I6cWXqzvdaT0VRJuUfNuN6hbv7B6oVIREhkr3ViJWMCGKBOL/2CnsSsHLpeafANQJw
	 77MTXUluiFLuvrinrdz/t5N+y6z8vpzvbxfRdgwvAuSGTWsyfH7R3095ugkC5gkV5p
	 3spjUZmH3V1LzxJhEbMox7ZSJYJBySZMDeh1rHjA3H/u7ou5k+Qs+1UIiPdo5v7IeT
	 vBW4VLwsvxMMA==
Date: Tue, 1 Jul 2025 14:29:42 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Jan Kara <jack@suse.cz>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v6 0/6] fs: introduce file_getattr and file_setattr
 syscalls
Message-ID: <20250701-quittung-garnieren-ceaf58dcb762@brauner>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>

On Mon, Jun 30, 2025 at 06:20:10PM +0200, Andrey Albershteyn wrote:
> This patchset introduced two new syscalls file_getattr() and
> file_setattr(). These syscalls are similar to FS_IOC_FSSETXATTR ioctl()
> except they use *at() semantics. Therefore, there's no need to open the
> file to get a fd.
> 
> These syscalls allow userspace to set filesystem inode attributes on
> special files. One of the usage examples is XFS quota projects.
> 
> XFS has project quotas which could be attached to a directory. All
> new inodes in these directories inherit project ID set on parent
> directory.
> 
> The project is created from userspace by opening and calling
> FS_IOC_FSSETXATTR on each inode. This is not possible for special
> files such as FIFO, SOCK, BLK etc. Therefore, some inodes are left
> with empty project ID. Those inodes then are not shown in the quota
> accounting but still exist in the directory. This is not critical but in
> the case when special files are created in the directory with already
> existing project quota, these new inodes inherit extended attributes.
> This creates a mix of special files with and without attributes.
> Moreover, special files with attributes don't have a possibility to
> become clear or change the attributes. This, in turn, prevents userspace
> from re-creating quota project on these existing files.

Only small nits I'm going to comment on that I can fix myself.
Otherwise looks great.

