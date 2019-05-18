Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2509D223C0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2019 17:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbfERPAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 May 2019 11:00:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40919 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbfERPAw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 May 2019 11:00:52 -0400
Received: by mail-io1-f68.google.com with SMTP id s20so7773198ioj.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 May 2019 08:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=16Dtq8us2STSS6t8l8g98mqEBDHkTUMHSYlu5UUkqGA=;
        b=vPSmOYQrmAX9/yD7Q1p7CtitRayTAJednKXbVhCTNNkyK775wgCxuCYUpdEv8a2jTT
         v+Z7Nz1e+Vej5rXTXmaclDp0KzdviLRDDzphCHDshYDCJNGB2zRh7hCYyoKHqb6+II1C
         c08LrUkd3u7mNRCYDxaIaZMzeAmli3wvHUkXIbQSrp4A7nDTP9cgHOtpwseo07dcVSA8
         4e0GS5KpZVOYscXWEqkplqxojekJciJexLYilxpDVB4sOG9SS3cDdcd7barFca94/7SH
         LiRE6Bq8mbBZfI6boVvCRiusEL4xQVQVGeyyrIsZD1iLfSo0lX05LaWBVCDX6bZd6DO/
         pH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=16Dtq8us2STSS6t8l8g98mqEBDHkTUMHSYlu5UUkqGA=;
        b=fXQmmFxwwlgW5Pj9UlAh7spGxZc7GRipN2FzyyS+GeIlmkdvEbVxTziosdfzkaZGaN
         tI2crfEEqOLckoB4/tWEHlev7u5/d0qg/sPAimM8wnnCP4ICY5lQV/XpCnHiEVlGFudo
         SxaBWgMtcjb7tvRj09emSR/GegEoMcheMJnI0CQj02cwVjnoKjBDkih45EnGzJzNrJ4J
         cvNrBZc1Rk2VE9UmbSHnooSf/Vj8hy5EhLaFIqwm6zkxAK0drzz6j+yrF6i04zfKmCgq
         zZdFDxgY4cc061loAWFS+MlL89DMqyGq+H6PYe0lyHVrGXYx+F+p075rPhfp5brvW5ie
         Jc2Q==
X-Gm-Message-State: APjAAAUEMDuXALqKWXnfOq8rqoas7I/GWwqmFIO8TS+Pq+RmN+0HNUEH
        eNd1r1EtiItnTqtNWopocVfLzGUlGWkzCesVXhBs5Q==
X-Google-Smtp-Source: APXvYqwBZop9VMj/p+pmsQBemWU77kyYN9I4FWk68o3OV1tLcSw3YE0pk1AYaf5N4PrQDKBZD7vspQbqbOvx05KXems=
X-Received: by 2002:a6b:6006:: with SMTP id r6mr3841823iog.231.1558191651264;
 Sat, 18 May 2019 08:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000014285d05765bf72a@google.com> <0000000000000eaf23058912af14@google.com>
 <20190517134850.GG17978@ZenIV.linux.org.uk> <CACT4Y+Z8760uYQP0jKgJmVC5sstqTv9pE6K6YjK_feeK6-Obfg@mail.gmail.com>
In-Reply-To: <CACT4Y+Z8760uYQP0jKgJmVC5sstqTv9pE6K6YjK_feeK6-Obfg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 18 May 2019 17:00:39 +0200
Message-ID: <CACT4Y+bQ+zW_9a3F4jY0xcAn_Hdk5yAwX2K3E38z9fttbF0SJA@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in do_mount
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+73c7fe4f77776505299b@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sabin.rapan@gmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 17, 2019 at 4:08 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, May 17, 2019 at 3:48 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Fri, May 17, 2019 at 03:17:02AM -0700, syzbot wrote:
> > > This bug is marked as fixed by commit:
> > > vfs: namespace: error pointer dereference in do_remount()
> > > But I can't find it in any tested tree for more than 90 days.
> > > Is it a correct commit? Please update it by replying:
> > > #syz fix: exact-commit-title
> > > Until then the bug is still considered open and
> > > new crashes with the same signature are ignored.
> >
> > Could somebody explain how the following situation is supposed to
> > be handled:
> >
> > 1) branch B1 with commits  C1, C2, C3, C4 is pushed out
> > 2) C2 turns out to have a bug, which gets caught and fixed
> > 3) fix is folded in and branch B2 with C1, C2', C3', C4' is
> > pushed out.  The bug is not in it anymore.
> > 4) B1 is left mouldering (or is entirely removed); B2 is
> > eventually merged into other trees.
> >
> > This is normal and it appears to be problematic for syzbot.
> > How to deal with that?  One thing I will *NOT* do in such
> > situations is giving up on folding the fixes in.  Bisection
> > hazards alone make that a bad idea.
>
> linux-next creates a bit of a havoc.
>
> The ideal way of handling this is including Tested-by: tag into C2'.
> Reported-by: would work too, but people suggested that Reported-by: is
> confusing in this situation because it suggests that the commit fixes
> a bug in some previous commit. Technically, syzbot now accepts any
> tag, so With-inputs-from:
> syzbot+73c7fe4f77776505299b@syzkaller.appspotmail.com would work too.
>
> At this point we obvious can't fix up C2'. For such cases syzbot
> accepts #syz fix command to associate bugs with fixes. So replying
> with "#syz fix: C2'-commit-title" should do.

What is that C2'?
