Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0C4242AFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 16:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgHLOLJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 10:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgHLOLJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 10:11:09 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EB7C061383
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 07:11:08 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kq25so2429710ejb.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 07:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iAI5XSM3iLSzZtbpzf+lyAZodExx8Fv/UVCtkgNqIpw=;
        b=Ev5v2cO14QrSiyYcOC/Fz6swER260kegAoQqygVAc1l4xp7iWj9y1sNUklptY5fWyh
         UpTrThzpnTLffpSrHOf2H63dAcVssZmBeRiLgorfycUPPCMMTFGXSVEqYOgJikBrkCYO
         UVuT7X9u60ilNRyU6Ttwt5duD6hAUjAYWcjFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iAI5XSM3iLSzZtbpzf+lyAZodExx8Fv/UVCtkgNqIpw=;
        b=I1c6/MitJWezAe5vAvSE8uAI1e/zZeb9FjCFJSF7Z6VugTUKTtJ/4YyQOvespDB8dd
         CG7QvXc1tIvwrmQZHejv9lrD3S9EYtwZ7o1Au8v+9hXFvsnAauSaGi4IYdtxxmNHiqla
         2+3WdR2YGwusiSWjmW91DoGavVgWS1JzSG6zIWBTPvwM7R/TVV8kkTnl87rqIUC0K7CT
         c37goJ8dtaOMXwKtXY0qntfIaRm+VDrScIizQC4afy4n7orSJck50RyUI6HRMj39vE7S
         VfPIp0zaiCAqClv157j+R3WrbAxDNWNlr4WGpyEx3PsMookEX0H2KgrhGD+0ZKgjvdRv
         0lGQ==
X-Gm-Message-State: AOAM533Ph7VSHSXnwrmp6T90PVSAZm8IEdRFgULvTlFS322AHzZX4PLe
        txKBlyDIzRVzkr7U2nfwohcUHb+H055K3ELfe6cz+Q==
X-Google-Smtp-Source: ABdhPJx3PJ9aL5obqkNAu7vPQ/SqsQ9TATEfUryRI39r11CbP3IrD6FZDXg7ftvqa1wiyALQ92/dDqI6E8aZplVgzoI=
X-Received: by 2002:a17:906:4e4f:: with SMTP id g15mr16755594ejw.443.1597241467668;
 Wed, 12 Aug 2020 07:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <135551.1597240486@warthog.procyon.org.uk>
In-Reply-To: <135551.1597240486@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 Aug 2020 16:10:56 +0200
Message-ID: <CAJfpegvLaoQHZTm1-QKorzsL3ZDnTOcHpcAJn36yF=n-YymCow@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 12, 2020 at 3:54 PM David Howells <dhowells@redhat.com> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > IOW, if you do something more along the lines of
> >
> >        fd = open(""foo/bar", O_PATH);
> >        metadatafd = openat(fd, "metadataname", O_ALT);
> >
> > it might be workable.
>
> What is it going to walk through?  You need to end up with an inode and dentry
> from somewhere.
>
> It sounds like this would have to open up a procfs-like magic filesystem, and
> walk into it.  But how would that actually work?  Would you create a new
> superblock each time you do this, labelled with the starting object (say the
> dentry for "foo/bar" in this case), and then walk from the root?
>
> An alternative, maybe, could be to make a new dentry type, say, and include it
> in the superblock of the object being queried - and let the filesystems deal
> with it.  That would mean that non-dir dentries would then have virtual
> children.  You could then even use this to implement resource forks...
>
> Another alternative would be to note O_ALT and then skip pathwalk entirely,
> but just use the name as a key to the attribute, creating an anonfd to read
> it.  But then why use openat() at all?  You could instead do:
>
>         metadatafd = openmeta(fd, "metadataname");
>
> and save the page flag.  You could even merge the two opens and do:
>
>         metadatafd = openmeta("foo/bar", "metadataname");
>
> Why not even combine this with Miklos's readfile() idea:
>
>         readmeta(AT_FDCWD, "foo/bar", "metadataname", buf, sizeof(buf));

And writemeta() and createmeta() and readdirmeta() and ...

The point is that generic operations already exist and no need to add
new, specialized ones to access metadata.

Thanks,
Miklos
