Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16741242B94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 16:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgHLOqe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 10:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgHLOqd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 10:46:33 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43234C061386
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 07:46:33 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o23so2578075ejr.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 07:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CevgO8y+bID+0RAL78i6xuCLe1DAtuhsuxp9oVmqPQU=;
        b=VAqCelzNyjnT6iNu6JL0OmE0MRSdkKZhVA4vV7FxA77mfestyhafmSBAI3sD50miSZ
         J5esPSbvoNSwivwgD7HrxmmozNQhTCw6laCyOnzMciZMuFOjZbZpT6M/JpF1foP9AZlE
         CTt6UyxNn0t4maELRb8vFmnciOaAi9XeCYAX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CevgO8y+bID+0RAL78i6xuCLe1DAtuhsuxp9oVmqPQU=;
        b=ncdZU3BQAM0XWn4oK5KUw31GhEkwrUHJrDDaLgZBLfm3HZoeYiGuQDQAg5GbOHPKpU
         waPgrZhVGxCT/a9C+Equ+MG6e24G6Q1rWZL5CReO9yk3cWq3wxSPgQIh1Zm4GUqSFf6/
         AEH8jHCONShgivcDqVi3W4dWVRcWVCZ/STqsRdBSHmsEPnK1EpaIXHqG9sxEzG1e1U48
         vfFZEq1xVTtuLZ9OT0BbQV5ux94mARR5fgOX7OGHpn1mk+EtmVYSscGNJorF/P1G/QLi
         OFL2PCz45c32efkTqlbFK86lQmAEIzEID+ehD98Vbn9NXd+JxRYLwQA5GqBuZPFsALmp
         i/8Q==
X-Gm-Message-State: AOAM532GydIC4mua86ZqY0ZmPTDVa0pmbcs4Big/evcsXIPBs6uUtnw+
        pvYXFSc7ngzvseMTnL/EsXq8PtAfhJP6KTkhgcpvzg==
X-Google-Smtp-Source: ABdhPJznRUZHYjzTK+AQg0Ekew5Jmkjqxgf9THY/0F2af+vjSso/3Yfi5HB6kL+u3+1mzuQyYpPhW+i0c+cYdCrgi/M=
X-Received: by 2002:a17:906:4aca:: with SMTP id u10mr138835ejt.320.1597243591705;
 Wed, 12 Aug 2020 07:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <5C8E0FA8-274E-4B56-9B5A-88E768D01F3A@amacapital.net> <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
 <CAJfpegvUBpb+C2Ab=CLAwWffOaeCedr-b7ZZKZnKvF4ph1nJrw@mail.gmail.com>
 <CAG48ez3Li+HjJ6-wJwN-A84WT2MFE131Dt+6YiU96s+7NO5wkQ@mail.gmail.com>
 <CAJfpeguh5VaDBdVkV3FJtRsMAvXHWUcBfEpQrYPEuX9wYzg9dA@mail.gmail.com>
 <CAHk-=whE42mFLi8CfNcdB6Jc40tXsG3sR+ThWAFihhBwfUbczA@mail.gmail.com>
 <CAJfpegtXtj2Q1wsR-3eUNA0S=_skzHF0CEmcK_Krd8dtKkWkGA@mail.gmail.com> <20200812143957.GQ1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200812143957.GQ1236603@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 Aug 2020 16:46:20 +0200
Message-ID: <CAJfpegvFBdp3v9VcCp-wNDjZnQF3q6cufb-8PJieaGDz14sbBg@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
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

On Wed, Aug 12, 2020 at 4:40 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Aug 12, 2020 at 09:23:23AM +0200, Miklos Szeredi wrote:
>
> > Anyway, starting with just introducing the alt namespace without
> > unification seems to be a good first step. If that turns out to be
> > workable, we can revisit unification later.
>
> Start with coming up with answers to the questions on semantics
> upthread.  To spare you the joy of digging through the branches
> of that thread, how's that for starters?
>
> "Can those suckers be passed to
> ...at() as starting points?

No.

>  Can they be bound in namespace?

No.

> Can something be bound *on* them?

No.

>  What do they have for inodes
> and what maintains their inumbers (and st_dev, while we are at
> it)?

Irrelevant.  Can be some anon dev + shared inode.

The only attribute of an attribute that I can think of that makes
sense would be st_size, but even that is probably unimportant.

>  Can _they_ have secondaries like that (sensu Swift)?

Reference?

> Is that a flat space, or can they be directories?"

Yes it has a directory tree.   But you can't mkdir, rename, link,
symlink, etc on anything in there.

Thanks,
Miklos
