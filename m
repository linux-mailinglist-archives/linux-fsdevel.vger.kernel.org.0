Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3188927BF32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Sep 2020 10:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgI2IVd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Sep 2020 04:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbgI2IVc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:21:32 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D7FC0613D0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2020 01:21:32 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id w12so3521278qki.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2020 01:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zAP7X0rOOI0UosoUeZ02aH7o5X/Sy/ck1ClnD+nPOqw=;
        b=vjyUmTsNigRYAOAkrRcatzKXAQ4HEfJEr1N6XiQQGfEC2Wxn1nOhBeVW61CE2td+TK
         7eZxO5rMLFbFsRSh/noMIh+A0CF/fuK4JmNsjw6JQJ/JaYIOKp51GPqPM2/uHZa/xd0g
         ock53CGkWCav48kj/BCGiVzBXeyZsM252R49ltw99QcZhKTlZXLRd8hKclmsm5mgtdpB
         F/al85WXWC25T/BHAanRjZUy3I2miQfbvK9QWg3g1XxNz2Zi5pByjjhtPMSPyWUEtbu0
         s1qT5MtdPhzxGWv9nyBW/gkOXLT3sgvJtEHdorquUb9Ub2IuoRi9byj4VfUsD1rMZhHT
         uB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zAP7X0rOOI0UosoUeZ02aH7o5X/Sy/ck1ClnD+nPOqw=;
        b=SoKjMehptIxa8ksIUz8pOPvSZ1gYmiKQcRod9JX4Kjrtkcal8XPqn6bQRi/WiPe2Hu
         PgfodaMEvVANoMJN5yZIPjLD+JBybRo6LTEfyZdDwqE2AO7QR6Y6KfpmTXhssrtIp/e+
         3+uiQnKMwQwJ5lgm7MUgnLnot+3Ofr9W3+MJORm/ZDjD6rgvToKPhg+GRc0UqSgCrWg/
         8cmUC1iNQluHPThLkQIps3GgT0LCGmqboMCgwVRYkD4NcaWpCv+bQhzVNKxxgGiKV6ou
         kTNbo2p0sJx8oXIMCocJ0Q03lUd9fZvsu8qQyfDwXUzTXfOGkpp0iFm1kw2Tvp7zzU7E
         RDlA==
X-Gm-Message-State: AOAM533JUutY2F4jwrvZt0yimnm9767rf+FYTooumeI5mehFDavcocrv
        5onMNdrRrK5nMvPaZvGQSex7nmed0MbKGmhM4S7wCg==
X-Google-Smtp-Source: ABdhPJwdrAydprXheE4Jt57uzdpA/B8B2ZJpOg9sZoVkGJnseneACkcfeLMNQ9XV87QqY3OmR8PBrqySDl3N6zWgCPM=
X-Received: by 2002:a37:a4c5:: with SMTP id n188mr3349446qke.8.1601367690935;
 Tue, 29 Sep 2020 01:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000da992305b02e9a51@google.com> <3b3de066852d4e30bd9d85bd28023100@AcuMS.aculab.com>
 <642ed0b4810d44ab97a7832ccb8b3e44@AcuMS.aculab.com> <20200928221441.GF1340@sol.localdomain>
 <20200929063815.GB1839@lst.de> <20200929064648.GA238449@sol.localdomain>
 <20200929065601.GA2095@lst.de> <e81e2721e8ce4612b0fc6098d311d378@AcuMS.aculab.com>
In-Reply-To: <e81e2721e8ce4612b0fc6098d311d378@AcuMS.aculab.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 29 Sep 2020 10:21:19 +0200
Message-ID: <CACT4Y+ax5YN5r=zL1NaxB_9S_7e6aUiL3tmBc6-8UMwuJpnn_Q@mail.gmail.com>
Subject: Re: WARNING in __kernel_read (2)
To:     David Laight <David.Laight@aculab.com>
Cc:     Christoph Hellwig <hch@lst.de>, Eric Biggers <ebiggers@kernel.org>,
        "syzbot+51177e4144d764827c45@syzkaller.appspotmail.com" 
        <syzbot+51177e4144d764827c45@syzkaller.appspotmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 29, 2020 at 10:06 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Christoph Hellwig
> > Sent: 29 September 2020 07:56
> >
> > On Mon, Sep 28, 2020 at 11:46:48PM -0700, Eric Biggers wrote:
> > > > Linus asked for it.  What is the call chain that we hit it with?
> > >
> > > Call Trace:
> > >  kernel_read+0x52/0x70 fs/read_write.c:471
> > >  kernel_read_file fs/exec.c:989 [inline]
> > >  kernel_read_file+0x2e5/0x620 fs/exec.c:952
> > >  kernel_read_file_from_fd+0x56/0xa0 fs/exec.c:1076
> > >  __do_sys_finit_module+0xe6/0x190 kernel/module.c:4066
> > >  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> > >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > >
> > > See the email from syzbot for the full details:
> > > https://lkml.kernel.org/linux-fsdevel/000000000000da992305b02e9a51@google.com
> >
> > Passing a fs without read permissions definitively looks bogus for
> > the finit_module syscall.  So I think all we need is an extra check
> > to validate the fd.
>
> The sysbot test looked like it didn't even have a regular file.
> I thought I saw a test for that - but it might be in a different path.
>
> You do need to ensure that 'exec' doesn't need read access.

The test tried to load a module from /dev/input/mouse

r2 = syz_open_dev$mouse(&(0x7f0000000000)='/dev/input/mouse#\x00',
0x101, 0x109887)
finit_module(r2, 0x0, 0x0)

because... why not? Everything is a file! :)
