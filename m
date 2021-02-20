Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2544A32071B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Feb 2021 21:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhBTUcn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Feb 2021 15:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhBTUcm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Feb 2021 15:32:42 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC77BC061574;
        Sat, 20 Feb 2021 12:32:01 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id c11so4129664pfp.10;
        Sat, 20 Feb 2021 12:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2lPQnSKSrFdOexh+uYv9Tnzq5Tv9KMipC5F/AsHVpd0=;
        b=qGqVwlcqnBfhRqAi3KkxtsW6vT/XdXVJXXILMQXUJLz0eTuZeof3OAdrWRPT44B6LO
         H+NirSV71/8p+EDkwXwmzs/tAx9JZSLAF734gMyiiCkGQx7Dr8wXrpTh58+hyVJtM4fD
         DKilUr9kKeXlOUctFAZ5x+LnVQY51434i+2A5wwqqm6EUGRKa4a2YZM1Uk3FhSVc/RnF
         E4MnZKfbW+GyRckbrJO72ZDYWHeZLbCyrmxKXFO/dFE673Kw3faqsuq3gKb47dvvRx3t
         E45eQ2LRZk7jM+OLMebxBiWhG5ALLii6x8IRCOVKsZWj5WySvvVtDLm4FoGxrpnMFwbM
         RMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2lPQnSKSrFdOexh+uYv9Tnzq5Tv9KMipC5F/AsHVpd0=;
        b=P1bT5ewgCHuqAk/rqtR5T5DEQaucjMIu7Y15uD3HLFD2nKpp9WrJbM5FcI0C0ZT2oX
         27BGDRm2SuH0dx+b7sXEOMhS/pxOUlo+RtbBevlkabJauHwBkr1z6hJZRj28BrKI9BiM
         bPqUKdzx7NX5oA5hgBcaNujUz0t+K04BT6TJivizCPCyPx09W9qwdfv4Rk6qtRz0cTUb
         eMj8aqrptjaVbpV46xGcy87gv5ipnEOUeN4gDu8RivOehuN7Ca35a8yBzVrytVyXlA+y
         KWc11MZbB37i10WI1dxX0H8MLoUpHTWl7+8UByUg0r6VYaw84d4ER8NI09b6F+YNPVui
         hwHQ==
X-Gm-Message-State: AOAM530MAsVB8Gxi+IGKzPMBlNtLZytLj/F3ZeaG1CqW2+v2P0ZIdAUG
        2JnlEaXxMqm2IMhyUjKZoPxKfJHIcI8JppLn5gU=
X-Google-Smtp-Source: ABdhPJw7sVxcT/57zLYqZC3wCnwCQ6aSIJpNrKRUsICCLrfzAfBS/uCLyEXPoY/Eme7+85vb9tzSAzC1olaIb/0Uoz0=
X-Received: by 2002:a63:eb14:: with SMTP id t20mr13572411pgh.336.1613853121265;
 Sat, 20 Feb 2021 12:32:01 -0800 (PST)
MIME-Version: 1.0
References: <CAOJe8K0MC-TCURE2Gpci1SLnLXCbUkE7q6SS0fznzBA+Pf-B8Q@mail.gmail.com>
 <20210129082524.GA2282796@infradead.org> <CAOJe8K0iG91tm8YBRmE_rdMMMbc4iRsMGYNxJk0p9vEedNHEkg@mail.gmail.com>
 <20210129131855.GA2346744@infradead.org> <YClpVIfHYyzd6EWu@zeniv-ca.linux.org.uk>
 <CAOJe8K00srtuD+VAJOFcFepOqgNUm0mC8C=hLq2=qhUFSfhpuw@mail.gmail.com>
 <YCwIQmsxWxuw+dnt@zeniv-ca.linux.org.uk> <YC86WeSTkYZqRlJY@zeniv-ca.linux.org.uk>
 <YC88acS6dN6cU1y0@zeniv-ca.linux.org.uk> <CAM_iQpVpJwRNKjKo3p1jFvCjYAXAY83ux09rd2Mt0hKmvx=RgQ@mail.gmail.com>
 <YDFj3OZ4DMQSqylH@zeniv-ca.linux.org.uk>
In-Reply-To: <YDFj3OZ4DMQSqylH@zeniv-ca.linux.org.uk>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Sat, 20 Feb 2021 12:31:49 -0800
Message-ID: <CAM_iQpXX7SBGgUkBUY6BEjCqJYbHAUW5Z3VtV2U=yhiw1YJr=w@mail.gmail.com>
Subject: Re: [PATCH 1/8] af_unix: take address assignment/hash insertion into
 a new helper
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Denis Kirjanov <kda@linux-powerpc.org>,
        Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 20, 2021 at 11:32 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, Feb 20, 2021 at 11:12:33AM -0800, Cong Wang wrote:
> > On Thu, Feb 18, 2021 at 8:22 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > Duplicated logics in all bind variants (autobind, bind-to-path,
> > > bind-to-abstract) gets taken into a common helper.
> > >
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > ---
> > >  net/unix/af_unix.c | 30 +++++++++++++++---------------
> > >  1 file changed, 15 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > > index 41c3303c3357..179b4fe837e6 100644
> > > --- a/net/unix/af_unix.c
> > > +++ b/net/unix/af_unix.c
> > > @@ -262,6 +262,16 @@ static void __unix_insert_socket(struct hlist_head *list, struct sock *sk)
> > >         sk_add_node(sk, list);
> > >  }
> > >
> > > +static void __unix_set_addr(struct sock *sk, struct unix_address *addr,
> > > +                           unsigned hash)
> > > +       __releases(&unix_table_lock)
> > > +{
> > > +       __unix_remove_socket(sk);
> > > +       smp_store_release(&unix_sk(sk)->addr, addr);
> > > +       __unix_insert_socket(&unix_socket_table[hash], sk);
> > > +       spin_unlock(&unix_table_lock);
> >
> > Please take the unlock out, it is clearly an anti-pattern.
>
> Why?  "Insert into locked and unlock" is fairly common...

Because it does not lock the lock, just compare:

lock();
__unix_set_addr();
unlock();

to:

lock();
__unix_set_addr();

Clearly the former is more readable and less error-prone. Even
if you really want to do unlock, pick a name which explicitly says
it, for example, __unix_set_addr_unlock().

Thanks.
