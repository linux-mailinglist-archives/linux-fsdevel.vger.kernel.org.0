Return-Path: <linux-fsdevel+bounces-73933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C182FD2573D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 16:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 578413013162
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 15:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2A83ACF1C;
	Thu, 15 Jan 2026 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVlJ3/rU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D8C399A76
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 15:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768491787; cv=none; b=V4JZLWPZV80p+/QAXje8XT4xC3IGOTmNsjd0ekVqh1QlXfZ+qQX6ast+7LMlaEmLyfVkR/Qosf/5+TBDfvZbtWadvCRrvjdyNtgH4S4Ix7khYoTmwnNzCjgAdECdNVP8NyRUzwIAO44xQLCHgcJ1l47Z087ezAZFRAW+fOZBftc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768491787; c=relaxed/simple;
	bh=0vKTsUqOaThK+m6hWl1cnCBP4ap6ZiOFtdIs3WfFwW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6CvtXLDLlRW/oLeCOnDy3lRmeceugbIsCLKay35xObENV0VK9GGnsuyWAX+sb2m/FQHdNAUAX55NsYDST2TfJShSwWKYPzxVhGqLuKLkcmtubXYWrDEmkobBcjFZdF1dWtfk14NxzakQBffcpEDD3BNKoDsmptbOT5lnP3pYTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVlJ3/rU; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-64d1ef53cf3so1649564a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 07:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768491783; x=1769096583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r3zXNTV1asu+2nK1dsZ2LdKYvZ1vcDLkY/oeQfy1v7E=;
        b=VVlJ3/rUUYheYBxSGpL2Wt40u84TB/G9q94hhi2ZFfaFSNxh27xU1Z7zPkjnChh3+j
         vUiNGJNxPUQpocLt7ztEI2A7ohhkcQ1EpvibrGao/GW6s26rV1MK3gowvVAV+wTkMoh3
         qT1ClQfrOGC1LLyMKBNY40hvRbrDQdvDJ0pTjj/A2hovzUFr9/itWbzWQcLoascUDE07
         pxe7aVYP0IBy0xDYI0WIKCogzCon8C93OcWTavwtDU7P4vLSAz4D0XFTQq1y73KrXZkE
         RdM1HTKnuUNJ8X9Cr/DWmV7hQq3R7S3UI56t048c67BuXyEq3PgWztcD8M+l2TVHWmgh
         wTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768491783; x=1769096583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3zXNTV1asu+2nK1dsZ2LdKYvZ1vcDLkY/oeQfy1v7E=;
        b=OcCayuZgmuYXUZtE7wVjMy12YwwLElfc7h5fPYL31btnrQOUYTJElu9t3Dw01g4soC
         LNSP6FCsNUa/u5fT38uxzMm1dD1Ee68qx/k1ayui36T+h94D4QfC/Jv53twtK9NcnelT
         YroCu4YmsVPUgGhnPKYWI7MkxbfGd5Ln/ZqaK1lmHA5FUBxyLA8APQ8KMrhwSU35N83L
         CFlyQieUpUqlSuIY0PSJS5Nkq+8NqucKY5BmyKWLiui5F0RlfoQhBW9I7xIiN5PYdtBs
         cWBxP2VUfToM1uBoZVRLJ6ItYAeZJASY0am+WrknAO9eKKASpvhcs2mbEAcgROzlOSks
         WP9w==
X-Forwarded-Encrypted: i=1; AJvYcCW2nr3gIaRr2a9kOvkHikWnf35xilHpycjkWK1cPKIff1CYpT4Bdijx2I4L+4sJyObIx9SWk9Ng7PQAhuxv@vger.kernel.org
X-Gm-Message-State: AOJu0YxY630A4GQtxZR9e81oyFPW0mT47FZE1Il85efJhreyAF6sVcoQ
	J+IO94Sjmol8/QmRaDGAHNBJwvWHZVcuAEKuo/k6NmZfenZU02UFTR2Z
X-Gm-Gg: AY/fxX6QVLBlqgyl381c+o5mza4vUvPt2pRbksZCRExpPdvU/0EVnZbs3KQBshJ1EDo
	hxOhvLURlVtZLY5gf6e17wQlkCqxx0CJBLrwK9BGbPuuFsaiUWtqWbW+eSiMkhlGN8yRddQGnNj
	dl3qGVfFiH76jpi8tFlMtPHjCEeAe753MvMimKNYipg2CEwXouy8k+wNMSXllnmqEPFAM9Yyfvz
	t46rrLLV5Wlh2IWYiWBfqYm28eWufpGF5ltmA9eoQGwcVp5DHe3LAh7tnn1o504TRsW5ENqoURu
	YNWspFkfn6l04ZIazbEUeR1jrUKqEgGsua1FJfvGx5lGzM/P1IQfsj+CnzMshIEwuYvFz2g0JlJ
	YWLRblDFEJAWhVpGpg9Zra6ajxeW64NDQ1bcvxUKgXwArHi6ptvAH0QGbOkl8rEV7edvMr0C1Sg
	Qxs9v4kScnwJ4KxO/0tvZl82Pd1vKenpXMoE980uwGOKp4SHD3KI6n2PWMpzRjUEYsgRsn/9TQl
	rtx/hlr1/Nnizd0Y96cKFD6vkw=
X-Received: by 2002:a05:6402:44c7:b0:64b:4540:6edb with SMTP id 4fb4d7f45d1cf-653ee1a7c7cmr3799746a12.22.1768491782605;
        Thu, 15 Jan 2026 07:43:02 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-7a88-ab31-60c0-33c9.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:7a88:ab31:60c0:33c9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65412084048sm2860511a12.26.2026.01.15.07.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 07:43:01 -0800 (PST)
Date: Thu, 15 Jan 2026 16:43:01 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Chunsheng Luo <luochunsheng@ustc.edu>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/2] fuse/passthrough: simplify daemon crash recovery
Message-ID: <aWkLBXv4AO5QMmPf@amir-ThinkPad-T480>
References: <20260115072032.402-1-luochunsheng@ustc.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115072032.402-1-luochunsheng@ustc.edu>

On Thu, Jan 15, 2026 at 03:20:29PM +0800, Chunsheng Luo wrote:
> To simplify FUSE daemon crash recovery and reduce performance overhead,
> passthrough backing_id information is not persisted. However, this
> approach introduces two challenges after daemon restart:
> 
> 1. Non-persistent backing_ids prevent proper resource cleanup, leading
>    to resource leaks.
> 2. New backing_ids allocated for the same FUSE file cause -EIO errors
>    due to strict fuse_backing validation in
>    fuse_inode_uncached_io_start(), even when accessing the same
>    backing file. This persists until all previously opened files are
>    closed.
> 
> There are common scenarios where reusing the cached fuse_inode->fb is
> safe:
> 
> Scenario 1: The same backing file (with identical inode) is
>             re-registered after recovery.
> Scenario 2: In a read-only FUSE filesystem, the backing file may be
>             cleaned up and re-downloaded (resulting in a different
>             inode, but identical content).

That is just not acceptable by design, regardless of server restart.

fuse passthrough may be configured per individual file open, but
all fd referring to the same fuse inode need to passthrough to the
same backing inode.

If your server want to serve different fd of same fuse inode from
different backing files (no matter if they claim to have the same content),
server needs to do that with FOPEN_DIRECT_IO, it cannot do that with
FOPEN_PASSTHROUGH.

Thanks,
Amir.

> 
> Proposed Solution:
> 
> 1. Enhance fuse_dev_ioctl_backing_close() to support closing all
>    backing_ids at once, enabling comprehensive resource cleanup after
>    restart.
> 
> 2. Introduce the FOPEN_PASSTHROUGH_INODE_CACHE flag. When set during
>    fuse_open(), the kernel prioritizes reusing the existing
>    fuse_backing cached in fuse_inode, falling back to the
>    backing_id-associated fb only if the cache is empty.
> 
> I'd appreciate any feedback on whether there are better approaches or
> potential improvements to this solution.
> 
> Thanks.
> ---
> Chunsheng Luo (2):
>   fuse: add close all in passthrough backing close for crash recovery
>   fuse: Add new flag to reuse the backing file of fuse_inode
> 
>  fs/fuse/backing.c         | 14 ++++++++++++++
>  fs/fuse/dev.c             |  5 +++++
>  fs/fuse/fuse_i.h          |  1 +
>  fs/fuse/iomode.c          |  2 +-
>  fs/fuse/passthrough.c     | 11 +++++++++++
>  include/uapi/linux/fuse.h |  2 ++
>  6 files changed, 34 insertions(+), 1 deletion(-)
> 
> -- 
> 2.43.0
> 

