Return-Path: <linux-fsdevel+bounces-4512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A667FFE85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 23:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 180ACB20CCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 22:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB7C5810E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 22:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Km8JtMfx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54226C4
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 13:10:42 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-28657040cdcso56814a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 13:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701378642; x=1701983442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/sRx+Jqf97+NiQ/oo0AK9REAGsSB677imx6VDbBDBPw=;
        b=Km8JtMfxfwYvu/zeg3TFokOr+llQNUz+H/GxvxsWAjDYt6PU9iTzC3WZJB+Eg6vEIL
         c+cuwZ8N2sWDTlLFDZ0NxE5/6n5bblotEgAAIJnZCVlZgy9UvrLgdJZutICxmSYcfRZE
         /sjNFxIc6pe4opf/Gco5ASXmorfGBnTXgYIplE3q4/CD7H1bUdxHQwOfYi0BXuD6tDWa
         KJccNMN8sC6fF+xJn0nb2Ti9a7GFt4ZgEncVQsRNMu/eNWaYVZ+0OunZcoB+wP3r5ky3
         PmgxZVn4Df9AAEFh5pa/Uhs7QemtKkWTcOzbad4Bi+kjdU9Ntq18I+TqrbL3WYAAIi0v
         xBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701378642; x=1701983442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sRx+Jqf97+NiQ/oo0AK9REAGsSB677imx6VDbBDBPw=;
        b=GHXwMxrwCYqrCRbXtiHPkolj+FCYQXrEye3WXU2uTlFR0D/4q6Te0p6TiIfp3mZKZt
         8iKd7kZvrhOvefsAqOJuTQllnzRWgVRQrv1b0dHPVObyVGzMmjsSf+dM6GorXUBT2jKW
         V0OcEqt0RbkfEX+6TThrDDWjDGnj5bMw5wXwXIARJ6s2GJAr4gdKX2PmG8cKpbq4Dj+1
         iaoJqLIqnxQIWFlRTl7H4drGfRwuN0MP1I5FSDLbZK0qbIzZLBnvIm6PRLUR4x9ftcFW
         lQMC9dqPhgJ8lZmypYlgTfXkc9oQHigXRQe9V8k7FRXEQGh7xE0Xo3IcLEjej0o5oONM
         uQNA==
X-Gm-Message-State: AOJu0YzBdEWT9mWb9d+kd3vGjmyG3lBx4ABk19GCF/5SC07acURlILnn
	CG8F5Q0/V1Iqj6cFs+Y1qW7YNg==
X-Google-Smtp-Source: AGHT+IGvDV12X2Cf2tSiZBcr9G1HEkwxlH7M0D5faUl77dI7BTBzZ5FwmwUTmMZr0vZ2RffJE7o8oQ==
X-Received: by 2002:a17:90b:4b86:b0:286:3074:c632 with SMTP id lr6-20020a17090b4b8600b002863074c632mr4500797pjb.22.1701378641794;
        Thu, 30 Nov 2023 13:10:41 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id kh14-20020a17090b34ce00b002859a1d9fb7sm1768396pjb.2.2023.11.30.13.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:10:41 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1r8oIw-0027MJ-1v;
	Fri, 01 Dec 2023 08:10:38 +1100
Date: Fri, 1 Dec 2023 08:10:38 +1100
From: Dave Chinner <david@fromorbit.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>, dchinner@redhat.com
Subject: Re: [RFC 1/7] iomap: Don't fall back to buffered write if the write
 is atomic
Message-ID: <ZWj6Tt1zKUL4WPGr@dread.disaster.area>
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
 <09ec4c88b565c85dee91eccf6e894a0c047d9e69.1701339358.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09ec4c88b565c85dee91eccf6e894a0c047d9e69.1701339358.git.ojaswin@linux.ibm.com>

On Thu, Nov 30, 2023 at 07:23:09PM +0530, Ojaswin Mujoo wrote:
> Currently, iomap only supports atomic writes for direct IOs and there is
> no guarantees that a buffered IO will be atomic. Hence, if the user has
> explicitly requested the direct write to be atomic and there's a
> failure, return -EIO instead of falling back to buffered IO.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  fs/iomap/direct-io.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 6ef25e26f1a1..3e7cd9bc8f4d 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -662,7 +662,13 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  			if (ret != -EAGAIN) {
>  				trace_iomap_dio_invalidate_fail(inode, iomi.pos,
>  								iomi.len);
> -				ret = -ENOTBLK;
> +				/*
> +				 * if this write was supposed to be atomic,
> +				 * return the err rather than trying to fall
> +				 * back to buffered IO.
> +				 */
> +				if (!atomic_write)
> +					ret = -ENOTBLK;

This belongs in the caller when it receives an -ENOTBLK from
iomap_dio_rw(). The iomap code is saying "this IO cannot be done
with direct IO" by returning this value, and then the caller can
make the determination of whether to run a buffered IO or not.

For example, a filesystem might still be able to perform an atomic
IO via a COW-based buffered IO slow path. Sure, ext4 can't do this,
but the above patch would prevent filesystems that could from being
able to implement such a fallback....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

