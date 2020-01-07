Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC54F131CBA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 01:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgAGATY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jan 2020 19:19:24 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59009 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727268AbgAGATY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jan 2020 19:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578356362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P6DKJqEOe4vhsCWKNTqOKkUCkY52yGXVAFKOlUKBEWs=;
        b=B4LQddkf/6YhUODI9BvwUFDr0RqmUcgaAH+HX6x2uPqu1EDL/SK5wILumMRC5DbEZ4hpmV
        +xUR9xBEbOuUryL+fLMc6XC+hOo5uPd/GfZWgSGHnbLrEzhRtyJkJNVLTT+/1xw4h1XrBw
        AQvKOhW2XEAc1gVvYp5YNgs9E6Jur8M=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-U6Itwm9gPJS_n17dQFmjaw-1; Mon, 06 Jan 2020 19:19:19 -0500
X-MC-Unique: U6Itwm9gPJS_n17dQFmjaw-1
Received: by mail-qv1-f71.google.com with SMTP id n11so35571776qvp.15
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2020 16:19:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P6DKJqEOe4vhsCWKNTqOKkUCkY52yGXVAFKOlUKBEWs=;
        b=QCPVgJNKdvypYrVDvob+drz9Ket8/ll57CFqw0Y79zgNm32lKVv1gBF2ycfdwxhaOZ
         nd+greos6VNDQhubPPtpc33r7QBuubs8pKQ5P/AZdzL7yFhmpR5Qbjpa5jeCwdmbwLAv
         /w/fsipTttrd4GWszh0JhjQoE9BY0DUEt03lAxsF2Blx0wt1byfoxy8NfyAbA2ygmDL5
         QPR3j6Ci6Mz3EMA4U+rl7Bc0nnC2GDFsofYy4Wlfwv2+8pQlsIAukZpfQSyS4H+C4lgw
         xzBilIplkD5OJIWOsObTm8y2ru0UCEHmbpe6kK9mhlB1AUQVYTejVi4IEMh0tEgdMoAV
         sAPw==
X-Gm-Message-State: APjAAAW+GU7jP9oTVmLumO36dfwrH3uHL1fs7r1M4qsoR5hLbYwAY8wK
        DLBccq70gH2ypmSXYiUObkIRH8w6yI7EPQzKpkuKHdsDRGlHPoPHq5+Myn1POTrzvv6QRpe6xH1
        i1Gb49opn6Y08X1IChrw/UE6W8Dui0KCbVj6LiEhRKA==
X-Received: by 2002:a05:620a:78f:: with SMTP id 15mr10781732qka.295.1578356358789;
        Mon, 06 Jan 2020 16:19:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqwJKN93GGwNU9UovvnmTG1xqjy4nzbN2izviq9dtjrnRSJfQEtYKlj5BpLwckCuiU2VHx3CPvzGp0ntCgA4OY4=
X-Received: by 2002:a05:620a:78f:: with SMTP id 15mr10781716qka.295.1578356358552;
 Mon, 06 Jan 2020 16:19:18 -0800 (PST)
MIME-Version: 1.0
References: <20191223225558.19242-1-tasleson@redhat.com> <20191223225558.19242-10-tasleson@redhat.com>
 <20200104025620.GC23195@dread.disaster.area> <5ad7cf7b-e261-102c-afdc-fa34bed98921@redhat.com>
 <20200106220233.GK23195@dread.disaster.area>
In-Reply-To: <20200106220233.GK23195@dread.disaster.area>
From:   Sweet Tea Dorminy <sweettea@redhat.com>
Date:   Mon, 6 Jan 2020 19:19:07 -0500
Message-ID: <CAMeeMh-zr309TzbC3ayKUKRniat+rzurgzmeM5LJYMFVDj7bLA@mail.gmail.com>
Subject: Re: [RFC 9/9] __xfs_printk: Add durable name to output
To:     Dave Chinner <david@fromorbit.com>
Cc:     Tony Asleson <tasleson@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > >> +
> > >>    if (mp && mp->m_fsname) {
> > >
> > > mp->m_fsname is the name of the device we use everywhere for log
> > > messages, it's set up at mount time so we don't have to do runtime
> > > evaulation of the device name every time we need to emit the device
> > > name in a log message.
> > >
> > > So, if you have some sooper speshial new device naming scheme, it
> > > needs to be stored into the struct xfs_mount to replace mp->m_fsname.
> >
> > I don't think we want to replace mp->m_fsname with the vpd 0x83 device
> > identifier.  This proposed change is adding a key/value structured data
> > to the log message for non-ambiguous device identification over time,
> > not to place the ID in the human readable portion of the message.  The
> > existing name is useful too, especially when it involves a partition.
>
> Oh, if that's all you want to do, then why is this identifier needed
> in every log message? It does not change over the life of the
> filesystem, so it the persistent identifier only needs to be emitted
> to the log once at filesystem mount time. i.e.  instead of:
>
> [    2.716841] XFS (dm-0): Mounting V5 Filesystem
>
> It just needs to be:
>
> [    2.716841] XFS (dm-0): Mounting V5 Filesystem on device <persistent dev id>
>
> If you need to do any sort of special "is this the right device"
> checking, it needs to be done immediately at mount time so action
> can be taken to shutdown the filesystem and unmount the device
> immediately before further damage is done....
>
> i.e. once the filesystem is mounted, you've already got a unique and
> persistent identifier in the log for the life of the filesystem (the
> m_fsname string), so I'm struggling to understand exactly what
> problem you are trying to solve by adding redundant information
> to every log message.....
>

Log rotation loses that identifier though; there are plenty of setups
where a mount-time message has been rotated out of all logs by the
time something goes wrong after a month or two.

