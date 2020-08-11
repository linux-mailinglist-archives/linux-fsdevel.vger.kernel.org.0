Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50811241D29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 17:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbgHKPat (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 11:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728903AbgHKPaq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:30:46 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF7DC06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 08:30:44 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a26so13576255ejc.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 08:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2+Iq2qCHUHVaNAKHuF0ZSvBIxw9aZEr5eRrwEH0pyDM=;
        b=UHuiqJr7X2atxIGSHLT+svSK5gdNsubwckkEdoLhXVa0P5T2fMneByo6aZKzG8LldX
         T1q+WwMY0FUEt+jhdI91DgqUpJ4E3NQyPft4lnwP2z3OP679ywggUOEnwc9ZpPQSZeqm
         UJZcOolg7KSv4Nk5wS9SsRafbH+gx/jq+8o2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2+Iq2qCHUHVaNAKHuF0ZSvBIxw9aZEr5eRrwEH0pyDM=;
        b=GUryDvMWu2B0pBKmrKchYfZoi7Nj3ayb5CS0JgY3BaqmUtsjgCkzkXozMZ64Rrsiws
         LoMi2V0Hp8q2KlBq4b9fyzwWT3QYMXGHMcQX8Jq9HIUubfyfmWJRsRDW6M0PpJoSJIzp
         iqH75lMu58ReHpIUukGtVZNpIanSBDqZyB0yEzqtSD4KTa+f3nI03KfAOuRJhWymw8FQ
         bRKQlQ68dms6GQ1MDmOKS3Ss5XZ73aYLkZ9kvLwK9lGsyA+0phFuwYbRsSSiT//xnByW
         pl2EBMNcbOqhh/Wk99WyL2mk6WxYGsFJ6fxXLJjj2MIZMuaOPmKvJT/hS43cYjCHPh+5
         27LQ==
X-Gm-Message-State: AOAM532E5BrwOJTlx3YAULXly7Oj24SYxJ+iGZW/IFcSrD90qmR8q+py
        6bTW0IivdIMaaqyLi2vcJKNqEdsg+AW/YlH5ihgJIw==
X-Google-Smtp-Source: ABdhPJzBzum8mnm+vTGkWQzIaTCUoEszBkoemTUzdbDb+99lWLtwfHPa77uVvxYBE8u6HRWpehJ7Yt8BQd5fvoZKDLs=
X-Received: by 2002:a17:907:94ca:: with SMTP id dn10mr26676759ejc.110.1597159843363;
 Tue, 11 Aug 2020 08:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
In-Reply-To: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 11 Aug 2020 17:30:32 +0200
Message-ID: <CAJfpegtWai+5Tzxi1_G+R2wEZz0q66uaOFndNE0YEQSDjq0f_A@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
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

On Tue, Aug 11, 2020 at 5:20 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> [ I missed the beginning of this discussion, so maybe this was already
> suggested ]
>
> On Tue, Aug 11, 2020 at 6:54 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > >
> > > E.g.
> > >   openat(AT_FDCWD, "foo/bar//mnt/info", O_RDONLY | O_ALT);
> >
> > Proof of concept patch and test program below.
>
> I don't think this works for the reasons Al says, but a slight
> modification might.
>
> IOW, if you do something more along the lines of
>
>        fd = open(""foo/bar", O_PATH);
>        metadatafd = openat(fd, "metadataname", O_ALT);
>
> it might be workable.

That would have been my backup suggestion, in case the unified
namespace doesn't work out.

I wouldn't think the normal lookup rules really get in the way if we
explicitly enable alternative path lookup with a flag.  The rules just
need to be documented.

What's the disadvantage of doing it with a single lookup WITH an enabling flag?

It's definitely not going to break anything, so no backward
compatibility issues whatsoever.

Thanks,
Miklos
