Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC324E608F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Mar 2022 09:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348978AbiCXIq0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Mar 2022 04:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344104AbiCXIqZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:46:25 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F64A9BBBD
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Mar 2022 01:44:51 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a8so7653019ejc.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Mar 2022 01:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=++pYMAFi8siFITGTtI8OJ/ZLZmlTf/qSvmoDsoiudic=;
        b=bLvvkukA8BB7oL86pGuChsm+aSNaBbNixr+1oNjsVP/ANz9qs22bL+0co9+LxeTzLr
         p3/WfqNXLKRw5+YHpINrfHfutnGeCd8YeacpkAp7M5/e+ZXmlEcFJraf7HOoRtUvvuzU
         pRsj5BGCkDl5Z0LzlawnSEndD3gSIn0EoXRDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++pYMAFi8siFITGTtI8OJ/ZLZmlTf/qSvmoDsoiudic=;
        b=5FII6zSdhR0BHstgyTARZoFtIswEz3Oue1jkgDxIMxPi6ykesXbPEcrWvlPwO0xjO7
         ttubpV8Qp+raj5HeT3ICft2xoKMlJoTk8oDWqnVRWkVIK7oX+cfuOJ13uKWTA5EAQyAu
         4d6Jmf0CFbuKUTUqqSGjRPAYBuz6sfOg5p9EcnoC9MW4+NINepn/7NsRr8O7sa9CVpTq
         FYkb3eigvDbXkiq7UwQS2ijIEn4dgNkThlsYPAPl6TWCB6az1eIeo+B4HhlI9vbI7upk
         UwR+A4rEtTma7ZkFw2i0e4XTa0Y/ZxZQF5qVAX/OcnxxSg6HZv5bAIF4rB5zEJBFw8FM
         4UTw==
X-Gm-Message-State: AOAM533dFUo76Eormxl/yRLktHYN22r/BTcMl8RdRQiF6zodsWhOQI2Q
        vjbHrlzf0YhlDaVeCfN/0IMBb+n4a+NXCJiAuFcM0w==
X-Google-Smtp-Source: ABdhPJySkj3ocM+OfhTMngFbezUNAcO5OUVM0gUJl6sz5vW4FyHPd7j4grGLKSZMO+nJda8YLjoLclQNUxq16JpPat4=
X-Received: by 2002:a17:906:2991:b0:6cf:6b24:e92f with SMTP id
 x17-20020a170906299100b006cf6b24e92fmr4461589eje.748.1648111489773; Thu, 24
 Mar 2022 01:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220322192712.709170-1-mszeredi@redhat.com> <20220323114215.pfrxy2b6vsvqig6a@wittgenstein>
 <CAJfpegsCKEx41KA1S2QJ9gX9BEBG4_d8igA0DT66GFH2ZanspA@mail.gmail.com> <YjudB7XARLlRtBiR@mit.edu>
In-Reply-To: <YjudB7XARLlRtBiR@mit.edu>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 24 Mar 2022 09:44:38 +0100
Message-ID: <CAJfpegtiRx6jRFUuPeXDxwJpBhYn0ekKkwYbGowUehGZkqVmAw@mail.gmail.com>
Subject: Re: [RFC PATCH] getvalues(2) prototype
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 23 Mar 2022 at 23:20, Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Wed, Mar 23, 2022 at 02:24:40PM +0100, Miklos Szeredi wrote:
> > The reason I stated thinking about this is that Amir wanted a per-sb
> > iostat interface and dumped it into /proc/PID/mountstats.  And that is
> > definitely not the right way to go about this.
> >
> > So we could add a statfsx() and start filling in new stuff, and that's
> > what Linus suggested.  But then we might need to add stuff that is not
> > representable in a flat structure (like for example the stuff that
> > nfs_show_stats does) and that again needs new infrastructure.
> >
> > Another example is task info in /proc.  Utilities are doing a crazy
> > number of syscalls to get trivial information.  Why don't we have a
> > procx(2) syscall?  I guess because lots of that is difficult to
> > represent in a flat structure.  Just take the lsof example: tt's doing
> > hundreds of thousands of syscalls on a desktop computer with just a
> > few hundred processes.
>
> I'm still a bit puzzled about the reason for getvalues(2) beyond,
> "reduce the number of system calls".  Is this a performance argument?

One argument that can't be worked around without batchingis atomicity.
Not sure how important that is, but IIRC it was one of the
requirements relating to the proposed fsinfo syscall, which this API
is meant to supersede.   Performance was also oft repeated regarding
the fsinfo API, but I'm less bought into that.

> If so, have you benchmarked lsof using this new interface?

Not yet.  Looked yesterday at both lsof and procps source code, and
both are pretty complex and not easy to plug in a new interface.   But
I've not yet given up...

> I did a quickie run on my laptop, which currently had 444 process.
> "lsof /home/tytso > /tmp/foo" didn't take long:
>
> % time lsof /home/tytso >& /tmp/foo
> real    0m0.144s
> user    0m0.039s
> sys     0m0.087s
>
> And an strace of that same lsof command indicated had 67,889 lines.
> So yeah, lots of system calls.  But is this new system call really
> going to speed up things by all that much?

$ ps uax | wc -l
335
$ time lsof > /dev/null

real 0m3.011s
user 0m1.257s
sys 0m1.249s
$ strace -o /tmp/strace lsof > /dev/null
$ wc -l /tmp/strace
638523 /tmp/strace

That's an order of magnitude higher than in your case; don't know what
could cause this.

Thanks,
Millos
