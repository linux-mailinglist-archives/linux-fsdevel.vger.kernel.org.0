Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD67A470785
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 18:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240070AbhLJRmz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 12:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhLJRmz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:42:55 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2C9C061746
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Dec 2021 09:39:19 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id l7so14825088lja.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Dec 2021 09:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3QIa6rww9jro5nDJeWJFjVScPd67gpaO9LJRBQi9fOg=;
        b=M3iMr1TySf2JhF71PNm9vqUmHaN3ndNQHG/JvqEwurXQFVAc3WLPhhZJWkmxcv/iii
         e3cwFXBPK/cCe5z8o6p2trgcoV9h7Txs5HiF7R/U4M4BIEHcWNhyWg+ifoYKoycIB0+H
         5wF+CXd7RhgARAEG0l0SAd8Fi9xRrg4j8P6mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3QIa6rww9jro5nDJeWJFjVScPd67gpaO9LJRBQi9fOg=;
        b=ugRJLECtttOnwlLmumzIWtef9/TxJqaz03yQkWc1ATLAQdvqkpSgxuBjcHBRKFJVkc
         cUuUZq3PWv4KPuIHYdccxtXvXdcA6Q+IPwNd1fHDApj+bsv8hGv67/M8u42fgcmhEZKU
         LMAw9iUxceybz/qEn0jQ/n/Qh/uPid/J4XAmu4Xul/hvmNlhOqmoDf6e39caQmF5YhLc
         JGPF46uPxxPgjVymW7wSX7sBTkwzdtdsgjfrGPxfhDiRql1e16jOM4csnSoLFfbgwuCg
         UExPAAqlpM0YDGbSS5Y8Dwz4oDEs2uyc/Mw9N3A896tHclmS7Lq7oKYKiufVJYsdSPyp
         0HVg==
X-Gm-Message-State: AOAM530XBcGix5nw1s3dhppOIFzJ+2rY2g9eiRTrXYAQJoft1x98Fdbg
        bBYPhKMwiA7lPh1FLogVzPbYmuw6PUBwPAsUrTY=
X-Google-Smtp-Source: ABdhPJxJyQzrDZAJ8k8a24FkYCGRYtrjlugL7LWDGD4eAFqDsTQv5kcFNTGAXjHvY1VihDI6XS5ziQ==
X-Received: by 2002:a05:651c:550:: with SMTP id q16mr14242794ljp.371.1639157957748;
        Fri, 10 Dec 2021 09:39:17 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id o15sm370461lfk.175.2021.12.10.09.39.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 09:39:17 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id l7so14824985lja.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Dec 2021 09:39:17 -0800 (PST)
X-Received: by 2002:a5d:54c5:: with SMTP id x5mr15464416wrv.442.1639157651522;
 Fri, 10 Dec 2021 09:34:11 -0800 (PST)
MIME-Version: 1.0
References: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
 <163906888735.143852.10944614318596881429.stgit@warthog.procyon.org.uk>
 <CAHk-=wiTquFUu-b5ME=rbGEF8r2Vh1TXGfaZZuXyOutVrgRzfw@mail.gmail.com>
 <159180.1639087053@warthog.procyon.org.uk> <CAHk-=whtkzB446+hX0zdLsdcUJsJ=8_-0S1mE_R+YurThfUbLA@mail.gmail.com>
 <288398.1639147280@warthog.procyon.org.uk>
In-Reply-To: <288398.1639147280@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Dec 2021 09:33:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiHm-rNkeLXcOt4oV_BMzC5DeZ5FYt+yjbA_GjN2wcd5w@mail.gmail.com>
Message-ID: <CAHk-=wiHm-rNkeLXcOt4oV_BMzC5DeZ5FYt+yjbA_GjN2wcd5w@mail.gmail.com>
Subject: Re: [PATCH v2 07/67] fscache: Implement a hash function
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        linux-afs@lists.infradead.org,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 10, 2021 at 6:41 AM David Howells <dhowells@redhat.com> wrote:
>
> However, since the comparator functions are only used to see if they're the
> same or different, the attached change makes them return bool instead, no
> cast or subtraction required.

Ok, thanks, that resolves my worries.

Which is not to say it all works - I obviously only scanned the
patches rather than testing anything.

                Linus
