Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A05243006
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 22:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgHLUYa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 16:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgHLUY3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 16:24:29 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B70C061383;
        Wed, 12 Aug 2020 13:24:28 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id d27so2585185qtg.4;
        Wed, 12 Aug 2020 13:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0JwWTfgMUWwOG2VdFhmTHy70OqTVhWrEaTFFUPlZs44=;
        b=n0hmcigv9AKqbYE9d8oRnL6p+38s8wXErBjMvc7vQCCJBe0VpT63Gr69kEk1wj3ME0
         yOLvVHPCf2J/EXKXQf27oneydYsig124HqHtDulBSQ3+9KbNxXJnISSupJZUzu5ipGTz
         Jnamunb7x2te6cWrDnOuw4sYtQ/YHYliT7mbida19VNs+QhkdUpLc8lPl3/ovy4AEYZ+
         GPMqn5623Xp6d229Y9HVwiYkDjkHZqfJd2Egs8/WlWKnZ1qD22FTrBFTc3eVsEZUYgdp
         li4oC3tz6AFGDf5YVoeDmCzoJZbr4KtogcOQL7d7vncFD9WmwUYs8jgx/eGt5JHb8XEr
         +BNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0JwWTfgMUWwOG2VdFhmTHy70OqTVhWrEaTFFUPlZs44=;
        b=FMKu4j4xEEgWgACQi671eXJdMhBA7EP/hKVN7d+porQ/Mukie0r0uj0m+PvK8ScdsV
         5uAMFcIomqICnqBKt3xMpuND+PCVUYP78/b5aCk2F26sBr4d8K/QT4CVXdIGIrScVMBC
         VKSg86UD31MmrLNjbO4gaSXaljueeTQEjh5vH+ne4NQt+sZnHLBMT+7kk6IbMVZsaVIu
         gNG2HFxIpm5a6jcU6qerjGIB3Igs0ffzSfMJk8yZb7iDlwtgmPIfayElQlkduQXZONTy
         Zooe2qMrtRK7bXm6NCzd87wM4uWlR1xhz3g7X98iqaIjQ+rjQ4bpAMLzq0wORD0FLjpN
         moPA==
X-Gm-Message-State: AOAM533JKG6L2gMQVCuqCx/Eli44YShEMeQfMBa4WCBIY5vBL1Kr2mxF
        wevNMYDjp5lWDK3k79smMMg=
X-Google-Smtp-Source: ABdhPJxJeb9hHRLR88ZwXWiK4lyhVLzEuiWoV1JjpAi3EfuC1RgnZ8DUMsG4RsxsCQcL7hfoXHpeJg==
X-Received: by 2002:ac8:7606:: with SMTP id t6mr1585661qtq.348.1597263867572;
        Wed, 12 Aug 2020 13:24:27 -0700 (PDT)
Received: from eaf ([190.19.79.86])
        by smtp.gmail.com with ESMTPSA id g136sm3324516qke.82.2020.08.12.13.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 13:24:26 -0700 (PDT)
Date:   Wed, 12 Aug 2020 17:24:20 -0300
From:   Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH] hfs, hfsplus: Fix NULL pointer
 dereference in hfs_find_init()
Message-ID: <20200812202420.GA5873@eaf>
References: <20200812065556.869508-1-yepeilin.cs@gmail.com>
 <20200812070827.GA1304640@kroah.com>
 <20200812071306.GA869606@PWN>
 <20200812085904.GA16441@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812085904.GA16441@kadam>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Wed, Aug 12, 2020 at 11:59:04AM +0300, Dan Carpenter wrote:
> Yeah, the patch doesn't work at all.  I looked at one call tree and it
> is:
> 
> hfs_mdb_get() tries to allocate HFS_SB(sb)->ext_tree.
> 
> 	HFS_SB(sb)->ext_tree = hfs_btree_open(sb, HFS_EXT_CNID, hfs_ext_keycmp);
>                     ^^^^^^^^
> 
> hfs_btree_open() calls page = read_mapping_page(mapping, 0, NULL);
> read_mapping_page() calls mapping->a_ops->readpage() which leads to
> hfs_readpage() which leads to hfs_ext_read_extent() which calls
> res = hfs_find_init(HFS_SB(inode->i_sb)->ext_tree, &fd);
>                                          ^^^^^^^^
> 
> So we need ->ext_tree to be non-NULL before we can set ->ext_tree to be
> non-NULL...  :/

For HFS+, the first 8 extents for a file are kept inside its own fork data
structure, not in the extent tree. So, in normal operation, you don't need
to search the extent tree to find the first page of the extent tree itself.
The HFS layout is different, but it should work the same way.

Of course this sort of thing can still be triggered by crafted filesystems.
If that's what the reproducer is about, I think just returning an error is
reasonable. But these modules will never be safe against attacks such as
this.

> I wonder how long this has been broken and if we should just delete the
> AFS file system.
> 
> regards,
> dan carpenter
