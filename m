Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FB543262F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 20:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhJRSS7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 14:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhJRSS7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 14:18:59 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF96AC061765
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Oct 2021 11:16:47 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id b14so2065204plg.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Oct 2021 11:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3eZXAINomO0TsR73UjlRKieVti/XvPo3IuFO3ZnaeEc=;
        b=kIRGqx1B8SY7vResN8umkp2/EQMjfW2CYO327hmznNZTyNt9LX2AhABnKi18Tt0P40
         dc4OhUxi2XbBecfp2gY4BTGsYCcCh6dUziZ2iezl+qwq1cs1bpvSvxuUwowo25gPW8QJ
         2jCJ2+TGzyACwW+xmE0/QGApZdbFMzmpCprds98KOptZw6wlZHK44uCmoYdssLqEwNRT
         +Fgioc3Jw3dmgpaDB5Jo5c/gBEFStDDPIDQNmEF0TmP66UJTdefe+jw+3CCtYTj/55ws
         jCupBM5GGLx6uiko3Ff6Gu19XSt4h72UK94M075M14yVb9CuTVY9VTcyE7p71sYJw2fK
         F2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3eZXAINomO0TsR73UjlRKieVti/XvPo3IuFO3ZnaeEc=;
        b=CS1Hw+JH8Fcg6yhcbz5G5WQ1fpsxZh1Y0I6oYky+Oxrz8KKGeIz5Zzz1afhfIpDH+l
         V3hWVLmKLMamYuk6e4W3CMpfdW/3k2pKW0Ph3Y9WXkoTvC3tdfz4afDy4OJXZDzRdQbg
         O0GvIotFnex+B7vpG99xBHimO/7E9lpaZi7rcGacOSrdtJ+eGsdykod+ha0LO8mkG/eg
         32SUxiDkU8PP/28A1gRj3Jz+p7BarGe6j0pWf40DIos3uXo/nY8WOrsb9UfCuYAjB0Hs
         sqTLOBNIXd8bEFy3Jk4sVMJD8W7y6Gu/O5OGV2fMQ9oEFgMYQe11+U7LlDJ79boc0yKe
         vx+A==
X-Gm-Message-State: AOAM530sPyYjHkf4s+O5DCF+WFmHaGxyvCaASnFwYjKUz8WUIWmEfhci
        KeNznVx8Efd+isYAS4E1ulWONw==
X-Google-Smtp-Source: ABdhPJzfkadXB5iv6H41tn7ZDy0gnByTGRiXdag5cOUtnMV4Nf/THZt0KsceWO5BWBA6/qKx4i5a1g==
X-Received: by 2002:a17:90a:5515:: with SMTP id b21mr486832pji.239.1634581006894;
        Mon, 18 Oct 2021 11:16:46 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:b911])
        by smtp.gmail.com with ESMTPSA id x7sm133221pjg.5.2021.10.18.11.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 11:16:46 -0700 (PDT)
Date:   Mon, 18 Oct 2021 11:16:44 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v11 07/14] btrfs: add definitions + documentation for
 encoded I/O ioctls
Message-ID: <YW26DKksOcmZLOsb@relinquished.localdomain>
References: <cover.1630514529.git.osandov@fb.com>
 <5d861feadc7b8e029e6006489179f62bc7594d4e.1630514529.git.osandov@fb.com>
 <62133e1e-bb29-7764-c5db-51d5bb0a1e63@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62133e1e-bb29-7764-c5db-51d5bb0a1e63@suse.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 15, 2021 at 12:42:37PM +0300, Nikolay Borisov wrote:
> 
> 
> On 1.09.21 г. 20:01, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > In order to allow sending and receiving compressed data without
> > decompressing it, we need an interface to write pre-compressed data
> > directly to the filesystem and the matching interface to read compressed
> > data without decompressing it. This adds the definitions for ioctls to
> > do that and detailed explanations of how to use them.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> 
> One minor nit below but otherwise LGTM:
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> 
> <snip>
> 
> > +struct btrfs_ioctl_encoded_io_args {
> > +	/* Input parameters for both reads and writes. */
> > +
> > +	/*
> > +	 * iovecs containing encoded data.
> > +	 *
> > +	 * For reads, if the size of the encoded data is larger than the sum of
> > +	 * iov[n].iov_len for 0 <= n < iovcnt, then the ioctl fails with
> > +	 * ENOBUFS.
> > +	 *
> > +	 * For writes, the size of the encoded data is the sum of iov[n].iov_len
> > +	 * for 0 <= n < iovcnt. This must be less than 128 KiB (this limit may
> > +	 * increase in the future). This must also be less than or equal to
> > +	 * unencoded_len.
> > +	 */
> > +	const struct iovec __user *iov;
> > +	/* Number of iovecs. */
> > +	unsigned long iovcnt;
> > +	/*
> > +	 * Offset in file.
> > +	 *
> > +	 * For writes, must be aligned to the sector size of the filesystem.
> > +	 */
> > +	__s64 offset;
> > +	/* Currently must be zero. */
> > +	__u64 flags;
> > +
> 
> nit: A comment stating that the output params begin here could be added.

There is a comment in this spot:

	/*   
	 * For reads, the following members are filled in with the metadata for
	 * the encoded data.
	 * For writes, the following members must be set to the metadata for the
	 * encoded data.
	 */

I'll clarify it to:

        /*
	 * For reads, the following members are output parameters that will
	 * contain the returned metadata for the encoded data.
         * For writes, the following members must be set to the metadata for the
         * encoded data.
         */
