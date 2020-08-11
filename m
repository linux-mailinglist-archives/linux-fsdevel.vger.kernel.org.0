Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79871241D0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 17:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgHKPUq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 11:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbgHKPUq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:20:46 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B768C061788
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 08:20:45 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id v15so6857633lfg.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 08:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bx6crtxCZeThOx4D4bD3ehsUEC/VPmmXSGnr3LbBSBM=;
        b=fuVOZ6VXbzk9u1owlS5IWY/26dqpjDl8Zn92+ZwUfu1Iht5ylUjVdvAnr4KRzCh7VV
         901ieKbmeI/uj2OiDMkFTEr6IDlawY4EVR5ym128Z6kvWcI5hAIhMBgVCcgpeT57dS6W
         FJmGAlO9FQumMVHcvcBKzUuxybYBj4tt5eXdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bx6crtxCZeThOx4D4bD3ehsUEC/VPmmXSGnr3LbBSBM=;
        b=KjKIMnC59U36SolUEev/ZV1tOvwYGZO/Q80VEFQs078aYetMswtC0mVYJOl2QznLWi
         kWj9b0W+M6ocQQ7jozBgEaJCtI86QxuaF+QuZoJmc8ACygdjhr5lGa3Y16iBJUtxxuX/
         /HyvqGh2IhDbdpMC0wU2Kph+V3UfHLBqbzAHMGJ5CkBdd6laLcQuXm/qn+o3LeG2WN8K
         ppL6HHVw6TcntjA8sGFwDGvi3XTrDiSzykENHFa76QeAJWAaXY2wXEhM/y4nnwQ62nSr
         opQfQ9/O0UE49A0KwXvpGZtxfTs29ZEWKIAAif0CdZjfe1+tvsLPB9c25lxRm68ainL8
         a0bw==
X-Gm-Message-State: AOAM531SEkcFVpAYywHN35YhBx2YoKMO7UAroYgVTCvvNMWUdyC5lyDY
        AvEAyUnb42gZBLDdQtlPba7zZZjqfVM=
X-Google-Smtp-Source: ABdhPJzhI9OezhOkaNuIJVGmFz9wnJb/yVc3QRfuPprJGkAZrQrCvVIPm2YgZQzqDag/mMbK2l+Dow==
X-Received: by 2002:a19:8095:: with SMTP id b143mr3470220lfd.175.1597159242549;
        Tue, 11 Aug 2020 08:20:42 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id x13sm11719199lfr.95.2020.08.11.08.20.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 08:20:41 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id h19so13935077ljg.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 08:20:40 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr3363842ljf.285.1597159240486;
 Tue, 11 Aug 2020 08:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com> <20200811135419.GA1263716@miu.piliscsaba.redhat.com>
In-Reply-To: <20200811135419.GA1263716@miu.piliscsaba.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Aug 2020 08:20:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
Message-ID: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Miklos Szeredi <miklos@szeredi.hu>
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

[ I missed the beginning of this discussion, so maybe this was already
suggested ]

On Tue, Aug 11, 2020 at 6:54 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> >
> > E.g.
> >   openat(AT_FDCWD, "foo/bar//mnt/info", O_RDONLY | O_ALT);
>
> Proof of concept patch and test program below.

I don't think this works for the reasons Al says, but a slight
modification might.

IOW, if you do something more along the lines of

       fd = open(""foo/bar", O_PATH);
       metadatafd = openat(fd, "metadataname", O_ALT);

it might be workable.

So you couldn't do it with _one_ pathname, because that is always
fundamentally going to hit pathname lookup rules.

But if you start a new path lookup with new rules, that's fine.

This is what I think xattrs should always have done, because they are
broken garbage.

In fact, if we do it right, I think we could have "getxattr()" be 100%
equivalent to (modulo all the error handling that this doesn't do, of
course):

  ssize_t getxattr(const char *path, const char *name,
                        void *value, size_t size)
  {
     int fd, attrfd;

     fd = open(path, O_PATH);
     attrfd = openat(fd, name, O_ALT);
     close(fd);
     read(attrfd, value, size);
     close(attrfd);
  }

and you'd still use getxattr() and friends as a shorthand (and for
POSIX compatibility), but internally in the kernel we'd have a
interface around that "xattrs are just file handles" model.

               Linus
