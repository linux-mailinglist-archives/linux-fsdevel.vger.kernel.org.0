Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA56B43B8DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 19:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238015AbhJZSCV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 14:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238001AbhJZSCU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 14:02:20 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5513AC061745;
        Tue, 26 Oct 2021 10:59:56 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 188so338793iou.12;
        Tue, 26 Oct 2021 10:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8DfdHsgRGfRYDFyOlx7BhB4eR5HyQPULbChWSwlujqM=;
        b=DQ2ClPENcpuSWhEkviDxhrir5Owrb+DaQYTA67p5MIxZfgZZ7ycqJ0g2CqeXeZlV/o
         bm+XkeGEpxX5dLvrTHcTLXEgLbWVOtj7OtfeofGcahgCNRAWKtuaVHEHJOvLaNpSYW+o
         Y27lmoYmNirPCFfHOR5XeXBsp/tZeJTpAMzrUUi5Fgw9r90KtrEAr0Xj0bxINpyh2Cfl
         yKxot7jueXi26V7siKtEgRUNKJOM8z16gHNeTKa6hfhdjaRNe9Dc19vAoO3IbqyeH5wz
         xdBxY0CNOwrrm7DqeZPuZsKm0rdA1OAJib+duimqtw0Q9G6puIk8v4EaUhpkh6op3iBw
         6LJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8DfdHsgRGfRYDFyOlx7BhB4eR5HyQPULbChWSwlujqM=;
        b=LzRnspCNtX4E40t99ONUT1pc5LuzazcsqJM+PZwTNcG2rl0J+0n9UH2BUjsna7S9qv
         BrOPIAy9tEYtsLnE/d0XRdRA+15JBkV7GW2SY20dWosulGFRCmk61YropLEIA55FQu7F
         iqvUoD7FyXu8nv5kFxPd7oWqA9nAyzRL2fYGKNKgHUcRtLowVdqAZKSgpUr8Eg4TQ11X
         H71hFZNtlJOtTBcAr+c/u89mO0TH4653f8zpua2s08UW9ZT8UWKL8pnN4T2oRqHDQUgj
         +vNzNUh2vUR67Ies0l/hAbjMmQtImJE9xCR4xz+PtlEpipZlh38tat6ouI5imkMmkhI7
         irHA==
X-Gm-Message-State: AOAM531yPowqefF+yBTKzKq8d7n4wG464HPpaO68aU0A5IeoeRry912U
        6WdGh9XoKfqNmjLnHj7meYt9gqUKcaYMWDrcTncrCTeD
X-Google-Smtp-Source: ABdhPJwZWs9j55QGdC+1bdT3TEDdOfMEPHkeNhan/KgmCdvcBSl6zG3reUmczmuBSCNARe6WOAD+Hb2aJCuItKKD558=
X-Received: by 2002:a02:270c:: with SMTP id g12mr16303054jaa.75.1635271195749;
 Tue, 26 Oct 2021 10:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211025204634.2517-1-iangelak@redhat.com> <CAOQ4uxieK3KpY7pf0YTKcrNHW7rnTATTDZdK9L4Mqy32cDwV8w@mail.gmail.com>
 <YXgqRb21hvYyI69D@redhat.com>
In-Reply-To: <YXgqRb21hvYyI69D@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 26 Oct 2021 20:59:44 +0300
Message-ID: <CAOQ4uxhpCKK2MYxSmRJYYMEWaHKy5ezyKgxaM+YAKtpjsZkD-g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Inotify support in FUSE and virtiofs
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Ioannis Angelakopoulos <iangelak@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 26, 2021 at 7:18 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, Oct 26, 2021 at 06:23:50PM +0300, Amir Goldstein wrote:
>
> [..]
> > > 3) The lifetime of the local watch in the guest kernel is very
> > > important. Specifically, there is a possibility that the guest does not
> > > receive remote events on time, if it removes its local watch on the
> > > target or deletes the inode (and thus the guest kernel removes the watch).
> > > In these cases the guest kernel removes the local watch before the
> > > remote events arrive from the host (virtiofsd) and as such the guest
> > > kernel drops all the remote events for the target inode (since the
> > > corresponding local watch does not exist anymore).
>
> So this is one of the issues which has been haunting us in virtiofs. If
> a file is removed, for local events, event is generated first and
> then watch is removed. But in case of remote filesystems, it is racy.
> It is possible that by the time event arrives, watch is already gone
> and application never sees the delete event.
>
> Not sure how to address this issue.

Can you take me through the scenario step by step.
I am not sure I understand the exact sequence of the race.
If it is local file removal that causes watch to be removed,
then don't drop local events and you are good to go.
Is it something else?

Thanks,
Amir.
