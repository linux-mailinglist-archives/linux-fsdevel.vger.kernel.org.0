Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AF028FE88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 08:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394396AbgJPGuh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 02:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730492AbgJPGug (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 02:50:36 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A553C061755;
        Thu, 15 Oct 2020 23:50:35 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id h10so1317606oie.5;
        Thu, 15 Oct 2020 23:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=yp9ezkkjfxFU72KviY2SkL912AddVp1dJs01IZSrZBg=;
        b=f7XD5Y6tkQqNxCb9E2piNE/vVBs2nIqq57a1OUPD+2wvy5Mlq3Tx1ZXcM9tHRRYK7x
         eqL4Cc2a6SA8D4e4qUReAf3gDYqvBmbUTIOMNByP1SMSo80g4jqQD95ytopbeGsoXpUq
         H+IFbMbZRNippsbYwMWl4lMLLOHZSeb6c/7ozB9qMwJTSOjTwrInneS7Y4vOfsc+xW8Z
         8gy5YZuzw+zYfV8ugPK4XDNjsd+2ntOuQBfB5qCJHuY0QcQESfzrx+A1B2cAmCGq5c9D
         m4J47Z1JuODqDzTcxzwAEHypWfNz/TiDZ9Eu3JtbykLszQWiVsPc2SXlWRsqi31mDfN5
         abpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=yp9ezkkjfxFU72KviY2SkL912AddVp1dJs01IZSrZBg=;
        b=FHuDFRpZyCfZoVwtegE5cd1P89DrQ5lLNdAMqHNYZuCSAdLE0JqdRbstgZl/dKYBjZ
         /XukWmawwFFNJFJHchJROM0uCigB7cSOTaKB3oOKgOl5rBCSLQ2YVXNfY5yMEelU3bey
         U0X6Z/FVZVXtxTsuOvkdCYUItBRsBB8qAnf8dFYTI9NWNJ9rgWao+0qXNh9i78KHI2w8
         6zmvYH9suxLF2LnbNRD6Xa2I4PjHxwkNQfJo+RdNGEoiUDplDbBShQj5ihrxae+1YyRs
         4wrmjOM13Y7jfOJPmX1+5t1sgfIUH3ow9ks0DBkHT4csl3BBZUurXyKcw5a+d9CxWOAR
         KqzA==
X-Gm-Message-State: AOAM531tVzCD5wfJpl5j/bu6+Tte3EKvkA6w6nNQMcaQzFbMoCkwt4j9
        rxWlYYw71Vo/CrVN3l3C5sbnSqu/Iru2JOMht35vxwi26pA=
X-Google-Smtp-Source: ABdhPJxxET8Z7gDhnMrab9PWw1QSWqPZi2aX8J9f+URrB7gyQFY/lMVbekd5YiqEg/0BXNj9zczVPsII0FL4f7AyZwM=
X-Received: by 2002:aca:bb41:: with SMTP id l62mr1469702oif.148.1602831034578;
 Thu, 15 Oct 2020 23:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <159827188271.306468.16962617119460123110.stgit@warthog.procyon.org.uk>
 <159827190508.306468.12755090833140558156.stgit@warthog.procyon.org.uk>
 <CAKgNAkho1WSOsxvCYQOs7vDxpfyeJ9JGdTL-Y0UEZtO3jVfmKw@mail.gmail.com>
 <667616.1599063270@warthog.procyon.org.uk> <CAKgNAkhjDB9bvQ0h5b13fkbhuP9tYrkBQe7w1cbeOH8gM--D0g@mail.gmail.com>
 <CAKgNAkh9h3aA1hiYownT2O=xg5JmZwmJUCvQ1Z4f85MTq-26Fw@mail.gmail.com>
In-Reply-To: <CAKgNAkh9h3aA1hiYownT2O=xg5JmZwmJUCvQ1Z4f85MTq-26Fw@mail.gmail.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Fri, 16 Oct 2020 08:50:23 +0200
Message-ID: <CAKgNAkju-65h1bKBUJQf-k=TCZeFmD9Nf4ZgZ9Mm_TQ1rQA6MA@mail.gmail.com>
Subject: Re: [PATCH 4/5] Add manpage for fsopen(2) and fsmount(2)
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

Another ping for these five patches please!

Cheers,

Michael

On Fri, 11 Sep 2020 at 14:44, Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> Hi David,
>
> A ping for these five patches please!
>
> Cheers,
>
> Michael
>
> On Wed, 2 Sep 2020 at 22:14, Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
> >
> > On Wed, 2 Sep 2020 at 18:14, David Howells <dhowells@redhat.com> wrote:
> > >
> > > Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:
> > >
> > > > The term "filesystem configuration context" is introduced, but never
> > > > really explained. I think it would be very helpful to have a sentence
> > > > or three that explains this concept at the start of the page.
> > >
> > > Does that need a .7 manpage?
> >
> > I was hoping a sentence or a paragraph in this page might suffice. Do
> > you think more is required?
> >
> > Cheers,
> >
> > Michael
> >
> > --
> > Michael Kerrisk
> > Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> > Linux/UNIX System Programming Training: http://man7.org/training/
>
>
>
> --
> Michael Kerrisk
> Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> Linux/UNIX System Programming Training: http://man7.org/training/



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
