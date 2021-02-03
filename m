Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE8A30DF1A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 17:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbhBCQEa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 11:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbhBCQEV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:04:21 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72579C061573
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Feb 2021 08:03:24 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id v19so17724930pgj.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 08:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0gWBL/eKNx2OZCYn91QXaSCmyWxGaTKIKa0SQUOL4Rc=;
        b=Y5qhogWEOYyCzqiRESQmo9Q3Ipm48K2LCotJy/xfds2wvGrnQkdRKBN9iI/eejSwSV
         KZoZL8wkgzoNklDUUs9M4GMfLypJ2BHPpocs4447qwjUSD19E+s9p8+CZYLsN8wkGR6d
         B9vxNJcTN2kto+15lSFEfioKxTTpAtQoxoqzW0NqCFZq1GU6eXtul4mI+LerA92QCvN+
         b6L19l+6mROViWz9PWHe3kH3I1BLmiE3tL+x40WWOEtozyQiJ8kYX3t2HO3ydEQeQIVs
         pGdTadpT6ILGFm/FZHvBhZb7IIIy7jlfckzB73sW2HNH3ed5AftaRqAL/p/6CGyLzkgR
         ywKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0gWBL/eKNx2OZCYn91QXaSCmyWxGaTKIKa0SQUOL4Rc=;
        b=bI0HNjmtOsVHltLvAYJAkGUHKQINZGQ8fBhM8I1jmHySzHu4qcAhWJ9KX2WCa+yXL4
         YFsNxWPPdbgCD/yJSWweaWhoTD59AQBMPfxjYrynW8ieSa7OZFaGl2ZNwoffIT0v3aUy
         dr6Pb9/p25tZd52vUgV0SqKMz4Qkn2DOyI77OPKe7TAqJ6KJqp7oySUWUKm3NLqeoXDW
         16wDN6hjXBQYRqAsdgvo5Cg/x5dvx3tS3stpO4iPXS/W4HBrGZeo/jDa2oXZsWq5vTF5
         Cq5e30bt5hKqJzDHjCYwjbPBQW6VA2mxMV0HLva2Ok953zDg0o5KztbMXl4QNCPwSkJv
         s9FQ==
X-Gm-Message-State: AOAM531H9DaYAsZCrDE5LGApO2qCVsWOgLJauYkAHQdCud9tOj/hJGMR
        euV+XxERaKvYEYxdJNWuYSc81A==
X-Google-Smtp-Source: ABdhPJyb1dkIJejo7I2tX9/WXWn6AAkQ+Fo3iGdanmapXAiFMejRbp30LA0FxNkd342pnC6IgB2Bbg==
X-Received: by 2002:a63:1863:: with SMTP id 35mr4418013pgy.191.1612368203947;
        Wed, 03 Feb 2021 08:03:23 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:1510])
        by smtp.gmail.com with ESMTPSA id 21sm2573808pfu.136.2021.02.03.08.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 08:03:22 -0800 (PST)
Date:   Wed, 3 Feb 2021 08:03:20 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v7 00/10] fs: interface for directly reading/writing
 compressed data
Message-ID: <YBrJSFURu8TUIzCU@relinquished.localdomain>
References: <cover.1611346706.git.osandov@fb.com>
 <7ce164cd-e849-80d8-3d9e-8a9987dc3ad9@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ce164cd-e849-80d8-3d9e-8a9987dc3ad9@toxicpanda.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 29, 2021 at 11:32:06AM -0500, Josef Bacik wrote:
> On 1/22/21 3:46 PM, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > This series adds an API for reading compressed data on a filesystem
> > without decompressing it as well as support for writing compressed data
> > directly to the filesystem. As with the previous submissions, I've
> > included a man page patch describing the API. I have test cases
> > (including fsstress support) and example programs which I'll send up
> > [1].
> > 
> > The main use-case is Btrfs send/receive: currently, when sending data
> > from one compressed filesystem to another, the sending side decompresses
> > the data and the receiving side recompresses it before writing it out.
> > This is wasteful and can be avoided if we can just send and write
> > compressed extents. The patches implementing the send/receive support
> > will be sent shortly.
> > 
> > Patches 1-3 add the VFS support and UAPI. Patch 4 is a fix that this
> > series depends on; it can be merged independently. Patches 5-8 are Btrfs
> > prep patches. Patch 9 adds Btrfs encoded read support and patch 10 adds
> > Btrfs encoded write support.
> > 
> > These patches are based on Dave Sterba's Btrfs misc-next branch [2],
> > which is in turn currently based on v5.11-rc4.
> > 
> 
> Is everybody OK with this?  Al?  I would like to go ahead and get this
> merged for the next merge window as long as everybody is OK with it, as it's
> blocking a fair bit of BTRFS work.  Thanks,

Ping. Al, Christoph, any thoughts?
