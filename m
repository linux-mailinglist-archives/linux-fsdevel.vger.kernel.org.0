Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5112037B552
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 07:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhELFGr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 01:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhELFGq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 01:06:46 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FFAC061574;
        Tue, 11 May 2021 22:05:38 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a2so10878613lfc.9;
        Tue, 11 May 2021 22:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pK3uO91nApx/1zLPS7zLQaMIrJTPe2LSIi5/lqX34mk=;
        b=gCRNfz0r1wwRV/wOqlyKNuvyCHEju3TWeFQ6ujJr0ilGE4BXgN/SCiKM9rw0DBvhRH
         /MhS/+V2yYNz2bwNZvLAEfD7OHa4hloswdOSRf95nglCYVzTVFJdMN+6FhhrCiFGeCb5
         vql5cpPqEt8mNgortbozwQS16brr5Px5JAGJcFT8J8KbjJS5bl0tVRbho3Gr3Yt3DPhX
         KVEhU1ZMPobj4M8mdywwJ3ZFJFPxGRLL2iVQMAR1wHslJrYrzTpdBBuUPMQPLOhuwe5l
         4I6B8XlVyPfNcXUZ9urLPKpMUTTIurCrtccVl7EDr/VKFw3yyhmKmNFeds34knrKAluL
         KOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pK3uO91nApx/1zLPS7zLQaMIrJTPe2LSIi5/lqX34mk=;
        b=fYHWwGqXkmX6Ef3XRczacUDfZUH4d/YD+R8nzwrX5Lm52ei4SOD9UHIAfEJoSuv8R/
         RbuK+XMh/aBNj2HmMHrUw3bgXyqe4g0CxoXb3HteELSHQxlBzhsrwqqE6gzNyxwmq+5v
         K/u/a4SiJegQBvaHqTdvSDTL9gIPDFcsvjLj+/Q8bTNvZ6J1rp2zW3RMCnZuVAUIZUgY
         yioJtBTMoHSQhVRLag5yu/FtpGAOFYnBCCj/4JzUysd7EzY9Sw9LRQaq+g9ccCZwwN/t
         mJLu7veewv6wAeP1nrSfROJtxcuCeS4ruqSJ0UgExArczBXHlebgFawoUDrV/lnOdzIu
         KO/g==
X-Gm-Message-State: AOAM532rsLebIzR4Yf5xaui6xxiO6zRYS1WHgaLXK3dmHhK0MHKEYEvu
        cj1wlp2/UszwhWdvQW4We0/5TJ/HKjBseDHidjA=
X-Google-Smtp-Source: ABdhPJzUn+A5w3VFWjHFzxn0t9GDncrmEricf20Su46X7NuzjrSq50ZiQcJNTOhDjI364BpdQY10+x8MbHvJ2KLWuqk=
X-Received: by 2002:a05:6512:142:: with SMTP id m2mr23979220lfo.313.1620795936825;
 Tue, 11 May 2021 22:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mt1Fy6hR+Rdig0sHsOS8fVQDsKf9HqZjvjORS3R-7=RFw@mail.gmail.com>
 <CAOQ4uxigOsEUrU5-QndJujVtP9KLdjEQTm3bHjGRCFWjZCAKBw@mail.gmail.com>
In-Reply-To: <CAOQ4uxigOsEUrU5-QndJujVtP9KLdjEQTm3bHjGRCFWjZCAKBw@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 12 May 2021 00:05:25 -0500
Message-ID: <CAH2r5mvjHcQVCj4g0mNeOHRRjc-xH88XZL-JFSAV+yw=idfMnA@mail.gmail.com>
Subject: Re: fanotify and network/cluster fs
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 10, 2021 at 11:34 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, May 11, 2021 at 2:36 AM Steve French <smfrench@gmail.com> wrote:
> >
> > With the recent changes to fanotify (e.g.
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7cea2a3c505e)
>
> Not sure how this is related to remote fs notifications.
>
> > has there been any additional discussion of what it would take to
> > allow fanotify to be supported for network/cluster fs (all major
>
> It would take someone to pick up this RFC that was already posted
> 2 years ago:
> https://lore.kernel.org/linux-fsdevel/20190507085707.GD30899@veci.piliscsaba.redhat.com/
> https://lore.kernel.org/linux-fsdevel/CAOQ4uxipauh1UXHSFt=WsiaDexqecjm4eDkVfnQXN8eYofdg2A@mail.gmail.com/
>
> > dialects supported by cifs.ko support sending notify requests to the
> > server - but there is no way for cifs.ko to be told which notify
> > requests to send as fanotify/inotify are local only in current Linux -
> > unlike other OS where notify is primarily for network fs and passed
> > down to the fs)
> >
>
> If you wait long enough, I'll get to implementing this for FUSE some day...
> But there is *really* nothing blocking cifs developers from implementing this
> and writing the specialized tests. I can help with guidance.

It's on my TODO list but I am dealing with some multichannel bugs at
the moment...
but would be great if someone had run into the same thing and fixed it.  If not
I will revisit the question of how to do this



-- 
Thanks,

Steve
