Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BB53D1BD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 04:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhGVCCq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 22:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhGVCCq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 22:02:46 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A24C061575;
        Wed, 21 Jul 2021 19:43:21 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id t186so3350743ybf.2;
        Wed, 21 Jul 2021 19:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=trKjuJwdkgxFMVsYzcVcOjk9/UkqIG2o1SR/kaFE2iA=;
        b=qGCClV3YHUSpFeq9nUGnUFt283a/i9dlCjDOVFrmNDfR0zw4clt+4YwO8LBby8GfFC
         fkr1i+rWALu208yLBr97IbrRWFxpbMIulbCMWOM8UotkckqSCSE04DUI0XAf7et2AsEh
         Eh9BnScygaHRQtD9jokcYx2dzfC20ksS4ZMejNWFkQy7YijXOZwN2QekFyhTl3RfEyZ9
         W9Ff/iboR3VW64pnI3DTdU1ZHH9c3uZNAiIZWXql/sZouxgVit9hKWRvowqsdrWR0Fo+
         sG5wYeEYhPCFcYzfd/8tHwocP36LvCKvD4KUdOVXXOn7xCN69qGsFMHZwkpgaOkup6gu
         WSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=trKjuJwdkgxFMVsYzcVcOjk9/UkqIG2o1SR/kaFE2iA=;
        b=uiWUQIv7xd2nRmRYHleGawsIuG0PcspYkpot29CooE4onF/6aiQ0pf19Qhny+YLWaz
         iQdaQ6Kr8/iPmrJ6jMB6JM0AHWuvRaRhLZj7QRYMfJsgmsOpQzsuYRcAu8B2dqJbkH1K
         z9iKqx9SrRlvO3qXpuMLkvJ4TDycTumnIZCEBjLkJuXQSkZW5VthJjRzf9TKGZm6Y4Is
         M6WhG8Jc1aWTVMdEGebshwjPp7z7d8c/p/89WyQv9jhnTB+vmxDMdaNtAFinnBTsRq4P
         SfoAmQ8M4fZImuPSBimuYbnYkw/WTCbK0lVcKxPg2k6xe27G8YjRuro1SBNAkN9jAvxo
         /o8g==
X-Gm-Message-State: AOAM531nYJQ3CXy6E5eGwZ0ST8rf+qDCo/zBYyqnRNlaky2ECAmjWdfs
        fx/VK7TViB9idh6SDPb3gA91zdw1iLbOlhFWuCc=
X-Google-Smtp-Source: ABdhPJybgTe3DGeu182hxGZ8FD2u1TzaJAemoTgkpuGI7thUzkdpuM45VZvSre60TMxRX4k6VAol4+G+P0HNhXBjZ6A=
X-Received: by 2002:a25:b093:: with SMTP id f19mr50201166ybj.90.1626921800666;
 Wed, 21 Jul 2021 19:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAFcO6XOdMe-RgN8MCUT59cYEVBp+3VYTW-exzxhKdBk57q0GYw@mail.gmail.com>
 <YPhbU/umyUZLdxIw@casper.infradead.org>
In-Reply-To: <YPhbU/umyUZLdxIw@casper.infradead.org>
From:   butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date:   Thu, 22 Jul 2021 10:43:10 +0800
Message-ID: <CAFcO6XO0GR8GBVD7hT8VL5qey3cCYriMqvt0Dan72i5yVP6FxQ@mail.gmail.com>
Subject: Re: A shift-out-of-bounds in minix_statfs in fs/minix/inode.c
To:     Matthew Wilcox <willy@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        djwong@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 22, 2021 at 1:37 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Jul 22, 2021 at 01:14:06AM +0800, butt3rflyh4ck wrote:
> > ms = (struct minix_super_block *) bh->b_data; /// --------------> set
> > minix_super_block pointer
> > sbi->s_ms = ms;
> > sbi->s_sbh = bh;
> > sbi->s_mount_state = ms->s_state;
> > sbi->s_ninodes = ms->s_ninodes;
> > sbi->s_nzones = ms->s_nzones;
> > sbi->s_imap_blocks = ms->s_imap_blocks;
> > sbi->s_zmap_blocks = ms->s_zmap_blocks;
> > sbi->s_firstdatazone = ms->s_firstdatazone;
> > sbi->s_log_zone_size = ms->s_log_zone_size;  // ------------------>
> > set sbi->s_log_zone_size
>

> So what you're saying is that if you construct a malicious minix image,
> you can produce undefined behaviour?

Yes, the attachment is a reproduction. just compile it and run.

>That's not something we're
> traditionally interested in, unless the filesystem is one customarily
> used for data interchange (like FAT or iso9660).
>

These file systems are my fuzzing targets.


Regards,
 butt3rflyh4ck.


-- 
Active Defense Lab of Venustech
