Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893B72425FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 09:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgHLHXg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 03:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgHLHXg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 03:23:36 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1372BC06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 00:23:36 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id jp10so1163550ejb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 00:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lg7tpKojiLkoGCQU1MYzPSjyojMR+QIskvYi6fn1Dcc=;
        b=RxZhkT3nxyiQK9MroBnY+vSTlOURG9xdAu71zIWR1pg9vScRFKcIDuCBeQMUdFuU1A
         3wv0lvogAGNnDfaByrHt3tsVFN6Xhn5Pek99IKFvWIXr0Ps810awHCCXZ3Uuh8fzTK2b
         mPjF7t6mbAUVw21TFOvqFtyCMzyJ+j/Fzal8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lg7tpKojiLkoGCQU1MYzPSjyojMR+QIskvYi6fn1Dcc=;
        b=reqVImK2hgPRJXwMmRoe+zhwwmRREZFQt4sva59tJAJ3TdHH3EnCY0XCIGf0GDO+Jr
         PZb5j+fft/dfKRCzK4JkIisCOzylHd3el8SigKXb2/kdTpffMz5UvxqhJXNfLsBoQNUI
         HjbBnHfOOKevJxyKZUFbQxLJ5vG7O6Ihay+36iSkEZQEOfp9N3ijNHBmGdRTEPAlrcu9
         LSWpTGYecneVp22ou5DyICO5MKR2+WEDCOZV/ACwM5KW3dYW3nTK3Pvfq5jkP8miHr3X
         3Cvg8VbC2zo2YjuRw+XbLwFiUW2mgTHiHUoHWTEwpYskUlZgFdpyINkt6Uncu6WQnIEJ
         5cHw==
X-Gm-Message-State: AOAM532LIS1m7/R3nZLWycZewIKcek1IL/wsDhssYG61eq8XrRaKCj3U
        Nmb4fF2p+G8jSE1UPhLy1DQhjOqkC3hCrgZS0Y/kYg==
X-Google-Smtp-Source: ABdhPJzm3HjwfP0ZZ1hhOcqQBxQCDqsXLhfMgQR7eK8xNsCMCgTf6AQcSZCyHkjDNgbYeD4fRI36L4Kyom2doR32tA4=
X-Received: by 2002:a17:906:3c59:: with SMTP id i25mr29241264ejg.202.1597217014736;
 Wed, 12 Aug 2020 00:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <5C8E0FA8-274E-4B56-9B5A-88E768D01F3A@amacapital.net> <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
 <CAJfpegvUBpb+C2Ab=CLAwWffOaeCedr-b7ZZKZnKvF4ph1nJrw@mail.gmail.com>
 <CAG48ez3Li+HjJ6-wJwN-A84WT2MFE131Dt+6YiU96s+7NO5wkQ@mail.gmail.com>
 <CAJfpeguh5VaDBdVkV3FJtRsMAvXHWUcBfEpQrYPEuX9wYzg9dA@mail.gmail.com> <CAHk-=whE42mFLi8CfNcdB6Jc40tXsG3sR+ThWAFihhBwfUbczA@mail.gmail.com>
In-Reply-To: <CAHk-=whE42mFLi8CfNcdB6Jc40tXsG3sR+ThWAFihhBwfUbczA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 Aug 2020 09:23:23 +0200
Message-ID: <CAJfpegtXtj2Q1wsR-3eUNA0S=_skzHF0CEmcK_Krd8dtKkWkGA@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
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

On Tue, Aug 11, 2020 at 11:19 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Aug 11, 2020 at 1:56 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > So that's where O_ALT comes in.   If the application is consenting,
> > then that should prevent exploits.   Or?
>
> If the application is consenting AND GETS IT RIGHT it should prevent exploits.
>
> But that's a big deal.
>
> Why not just do it the way I suggested? Then you don't have any of these issues.

Will do.

I just want to understand the reasons why a unified namespace is
completely out of the question.   And I won't accept "it's just fugly"
or "it's the way it's always been done, so don't change it".  Those
are not good reasons.

Oh, I'm used to these "fights", had them all along.  In hindsight I
should have accepted others' advice in some of the cases, but in
others that big argument turned out to be a complete non-issue.   One
such being inode and dentry duplication in the overlayfs case vs.
in-built stacking in the union-mount case.  There were a lot of issues
with overlayfs, that's true, but dcache/icache size has NEVER actually
been reported as a problem.

While Al has a lot of experience, it's hard to accept all that
anecdotal evidence just because he says it.   Your worries are also
just those: worries.  They may turn out to be an issue or they may
not.

Anyway, starting with just introducing the alt namespace without
unification seems to be a good first step. If that turns out to be
workable, we can revisit unification later.

Thanks,
Miklos
