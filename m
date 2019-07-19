Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B24D6ECB8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jul 2019 01:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732748AbfGSX2e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jul 2019 19:28:34 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43979 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbfGSX2d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jul 2019 19:28:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so9334494pld.10;
        Fri, 19 Jul 2019 16:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W6t5FQEwMw0qpV9k7IMBbta6+NR+YMGgesuoH6YZmbk=;
        b=fqw8Cx6LDnkMZb/sTC93KEdKOB+WPhFvjjco+JZBr5baVhpo6dWjxo6iAB7wDCfAuO
         GLvJY7wmkuMXupBqiVFJ0++G0llqiNYClUQBbD0zOYURk75CVPwRBqJmIQ0I30bGSlSy
         14y0OEYWK7zWcSn12Ac09I0BlnV7PEoT2KZGb8pWqb9LS00tsVkt6fNx1V/mInlICSgX
         Px7dCtv3P9d2NjYaV//FzBFsO9ncc5OMQTJEcnBBGCtq/4stOu+gmVdAhJNwn8Qfzwju
         DyGwcyAf0XGBCsubwrvVsuhglaMSDarfR6fHnekAPzWN4wz7AOPX94k0ljdabqVdRCtX
         Kt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W6t5FQEwMw0qpV9k7IMBbta6+NR+YMGgesuoH6YZmbk=;
        b=IaKj81O9g2Jl5/PZWNVzugrxoL/pX3hMt/Ju7lTRrQeL2LRFphi5ojIglV3ZffLtpl
         x/FJMOiodddMb/KFeo94rh4q8jlsSHHPmGPq5cTwVk8Qa1w2eyMYbxqE1A/3fhxoKLFN
         B+JkBBE7QcTk5FZKeWIA/0KvT1x+osnUqjPoZK0MDGi0MTMsqeMTUUz8M29x8RCnhMTP
         sv+92Tm+BJBXY+rCzRn+8yuOmVXvzyQ4IlSwlV/glszB7zy0AgUE69cnL78FZkd0ol+F
         vWX+mHXjibMuOkfs8kd7H5QCjlBvO9XBnhFX5O3eWve0c9u0bOpXzyJa+6ukIqWk3RvU
         c3qQ==
X-Gm-Message-State: APjAAAW7y/4L4LVBUfrJqqseXxaBWZHa1PtUFVdzn3mwSODvL9z0K+JH
        gMgzKWbi4irxXxrrpqpEZoo=
X-Google-Smtp-Source: APXvYqznoe4QzmRafn0J1Oet0UpHQ+jjD+EgfsMMiOX93rDiAqeGrtEc9yiw6pRztZ/GLoPPRDfMYQ==
X-Received: by 2002:a17:902:aa03:: with SMTP id be3mr59392908plb.240.1563578913096;
        Fri, 19 Jul 2019 16:28:33 -0700 (PDT)
Received: from fyin-linux ([103.121.208.202])
        by smtp.gmail.com with ESMTPSA id 2sm56046698pgm.39.2019.07.19.16.28.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jul 2019 16:28:32 -0700 (PDT)
From:   YinFengwei <nh26223.lmm@gmail.com>
X-Google-Original-From: YinFengwei <fyin@fyin-linux>
Date:   Sat, 20 Jul 2019 07:28:19 +0800
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Yin Fengwei <nh26223.lmm@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [PATCH] fs: fs_parser: avoid NULL param->string to kstrtouint
Message-ID: <20190719232819.GA27852@fyin-linux>
References: <20190719124329.23207-1-nh26223.lmm@gmail.com>
 <CACT4Y+aVS5nn0Pv31tAOujcAPvCAOuK_iPZ1CCNbgAOL=JDvvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aVS5nn0Pv31tAOujcAPvCAOuK_iPZ1CCNbgAOL=JDvvg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 19, 2019 at 03:37:37PM +0200, Dmitry Vyukov wrote:
> On Fri, Jul 19, 2019 at 2:44 PM Yin Fengwei <nh26223.lmm@gmail.com> wrote:
> >
> > syzbot reported general protection fault in kstrtouint:
> > https://lkml.org/lkml/2019/7/18/328
> >
> > From the log, if the mount option is something like:
> >    fd,XXXXXXXXXXXXXXXXXXXX
> >
> > The default parameter (which has NULL param->string) will be
> > passed to vfs_parse_fs_param. Finally, this NULL param->string
> > is passed to kstrtouint and trigger NULL pointer access.
> >
> > Reported-by: syzbot+398343b7c1b1b989228d@syzkaller.appspotmail.com
> > Fixes: 71cbb7570a9a ("vfs: Move the subtype parameter into fuse")
> >
> > Signed-off-by: Yin Fengwei <nh26223.lmm@gmail.com>
> > ---
> >  fs/fs_parser.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> > index d13fe7d797c2..578e6880ac67 100644
> > --- a/fs/fs_parser.c
> > +++ b/fs/fs_parser.c
> > @@ -210,6 +210,10 @@ int fs_parse(struct fs_context *fc,
> >         case fs_param_is_fd: {
> >                 switch (param->type) {
> >                 case fs_value_is_string:
> > +                       if (result->has_value) {
> 
> !result->has_value ?
Yes. Should have ! in condition for NULL param->string. Will fix in v2.

Regards
Yin, Fengwei

> 
> > +                               goto bad_value;
> > +                       }
> > +
> >                         ret = kstrtouint(param->string, 0, &result->uint_32);
> >                         break;
> >                 case fs_value_is_file:
> > --
> > 2.17.1
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20190719124329.23207-1-nh26223.lmm%40gmail.com.
