Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5E839F6FB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 14:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhFHMnm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 08:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbhFHMnl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 08:43:41 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6F8C061574
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jun 2021 05:41:48 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ei4so11837005pjb.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jun 2021 05:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rOPQWTaHhiRiTm6V8Ze9+h+RzJFbwGqEOQkmAbwXFSk=;
        b=TSje/+v0witxJqeSYOGtvQuoafaRbMYPyf2aSe87MJt/QiUxIbxpXlfjxuKXxYkoMb
         M9/E0O+2PxPgg0Im5zbw/nV0x4W1mchjhVk2OO3vdRYYtUCZ7C880jSAEw2rTAp1S9jm
         ZuAoWefnCmWocRfj5MLLJmJp1fTug0VIWFARkcZsNFNrcaPJOgS1TGx1HthzDUWqB8ur
         vTW/yZFV6iwCubxpyKiU+VEtvZ6cb/9cqTWJ5tgpepVJj7+uDhaT2sJBKx11kFmU2oTi
         DdXih9Rkhk2TtNu57WUr0iy6vfdmnLn6W3qbKraHgZDxi3kPgN4j+QW/XaQW6APVjPtE
         Dwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rOPQWTaHhiRiTm6V8Ze9+h+RzJFbwGqEOQkmAbwXFSk=;
        b=BQNsedDaq6pdeuXpVcw0hwqMeDy42EFpah5WQAIGJhBNKt1qbz5bVhbktwg/xL3Fjs
         ePDtiNcXiIBEvVobHQUHm0NeWLOaJmLp7yM8UgBjy9PqDc4QE1LfbpWU5IH+jjRzI7dI
         8gDWp48DaTP2/OEpAmv3jnnYCcFyo3Wx8J2Immu8KlYRsZ6OXRQapbvysBUFusBWr1zr
         gM2xPXP+ezWGbEQwhvL8YjNH2JArumX1lyA21PSsQJWYl1pL03NKqq4rvbUOZPSmaw1y
         OLa0o1G62dJ5YjTHZZaaU70gXhzAP2oCJmWOEM5nzzSY2AR/sM5RdYNO0a/pCgtwNmmW
         CQ9g==
X-Gm-Message-State: AOAM5322myRQ5FL1qyQ6v+8D4qUJdqrkXw+6eDe9L7uJhf9MFD1fbgkA
        TplC/50JV0VOqqyMtpDDTia8mk75mvSOeTxVQbM=
X-Google-Smtp-Source: ABdhPJzZncxdEEXl5UZ6E54gJaLBop61B1jSoV2frCzXLXEWUIKA5dhG6yMH1TM46JM58qlDg7hhI2bUoy5M8owB5qA=
X-Received: by 2002:a17:90a:f3d0:: with SMTP id ha16mr26377749pjb.123.1623156107981;
 Tue, 08 Jun 2021 05:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <1622537906-54361-1-git-send-email-tao.peng@linux.alibaba.com>
 <YLeoucLiMOSPwn4U@google.com> <244309bf-4f2e-342e-dd98-755862c643b8@metux.net>
 <CA+a=Yy5moy0Bv=mhsrC9FrY+cEYt8+YJL8TvXQ=N7pNyktccRQ@mail.gmail.com> <429fc51b-ece0-b5cb-9540-2e7f5b472d73@metux.net>
In-Reply-To: <429fc51b-ece0-b5cb-9540-2e7f5b472d73@metux.net>
From:   Peng Tao <bergwolf@gmail.com>
Date:   Tue, 8 Jun 2021 20:41:36 +0800
Message-ID: <CA+a=Yy6k3k2iFb+tBMuBDMs8E8SsBKce9Q=3C2zXTrx3-B7Ztg@mail.gmail.com>
Subject: Re: [PATCH RFC] fuse: add generic file store
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Alessio Balsini <balsini@android.com>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 8, 2021 at 6:50 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> On 08.06.21 04:58, Peng Tao wrote:
>
> >> oh, this could be quite what I'm currently intending do implement
> >> (just considered 9p instead of fuse as it looks simpler to me):
> >>
> >> I'd like the server being able to directly send an already opened fd to
> >> the client (in response to it calling open()), quite like we can send
> >> fd's via unix sockets.
> >>
> >> The primary use case of that is sending already prepared fd's (eg. an
> >> active network connection, locked-down file fd, a device that the client
> >> can't open himself, etc).
> >>
> >> Is that what you're working on ?
> > If the server and client run on the same kernel, then yes, the current
> > RFC supports your use case as well, E.g.,
> > 1. the server opens a file, saves the FD to the kernel, and passes the
> > IDR to the client.
> > 2. the client retrieves the FD from the kernel
> >
> > Does it match your use case?
>
> Seems that's exactly what I'm looking for :)
>
> Could you perhaps give a little example code how it looks in userland ?
The initial RFC mail in the thread has a userspace example code. Does
it make sense to you?

Cheers,
Tao
-- 
Into Sth. Rich & Strange
