Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFDB4121C8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 20:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfEBSRB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 14:17:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52289 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfEBSRA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 14:17:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id j13so4182072wmh.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2019 11:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cWCo69133luBASwqa/1RXdxuYCSr1bgB2Hxe86cjhos=;
        b=Aq6L7d8SFUyNSZAfinh/FfJie0qFbBBoywO5dyD8SoCxAiLfkjLYgqWUIVKL7U/AaL
         dcci44SbmHhX7RhnIf/4OWTHDmlYGtDCHMpoCXhKGXwmD1EUmuirlL0zF2dcwdQafPd4
         sO4ctLI9A03ucsNeGX7509pNymPvOcRnKSAGWFtiU2w0/yTrfMddmY3ByGu3a+BIyQb6
         kzuhslUB952LdA8WQvwK7EzNQjLq6ynUQjVRArmQab3CuxJ4Ab8y6YgVJF9OtaAViq47
         CD6/uxAncbyQlMEEQsbiOxGaE+o/iPhxIevNSK7BHtR2Rtd9EoFUdyZIwZC3lt9ZhYJb
         Lijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cWCo69133luBASwqa/1RXdxuYCSr1bgB2Hxe86cjhos=;
        b=WQtfuQ/mPsH1I2q/Id1DZ/vIvmqJE3koFN1WKcOSOnO6Zz4aQjLTjguq8XSLFXWt2X
         ys/xdsvUXeiITcIW0FLdRTg4fL2GGKmKETn4Z4sXsxitimayWdsQtrVMacsmoGZKmnRo
         mITbrgPhW1l4gkM/8UuyX9XACNUyXE2H9aniM284VqYgQnUZo6eB18XK/dTokzqHOWdY
         yMvfp2Sx9u0hgN5+G0IXJdfjY+GzplIJENUyDxtxcH5iA3kqYiJlsw/wxN/XotWjVr75
         mDQsSYWEb7WqQAmOhpZC/YyAvIXhAIlBsOrMjzl9v+sNvxa1ms2KIlBN0BCPFb+JhN7t
         +yYA==
X-Gm-Message-State: APjAAAXZJ3lOuRinw1EzmRYhCDHnARCxCMF35EAMsd6jsx1s8tTy32O/
        bfeLEnqh5Hzkofa/wqltxX9RxDPYZZT6lCFe5KU=
X-Google-Smtp-Source: APXvYqzmZlpa5BteU8S97PXVz1pRkY4PIA06hfNR91/FlHSyhmZKnpiRu2VHkotzhBpZ3Z+UQfvljhROAIeq72Govss=
X-Received: by 2002:a7b:cd18:: with SMTP id f24mr3260045wmj.19.1556821019080;
 Thu, 02 May 2019 11:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190502040331.81196-1-ezemtsov@google.com> <CAOQ4uxhmDjYY5_UVWYAWXPtD1jFh3H5Bqn1qn6Fam0KZZjyprw@mail.gmail.com>
In-Reply-To: <CAOQ4uxhmDjYY5_UVWYAWXPtD1jFh3H5Bqn1qn6Fam0KZZjyprw@mail.gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Thu, 2 May 2019 20:16:48 +0200
Message-ID: <CAFLxGvyfeuwhX=9Fu2XAoT7mxgKmr7T=238y8Mf8yAZnNXnOhg@mail.gmail.com>
Subject: Re: Initial patches for Incremental FS
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     ezemtsov@google.com, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 2, 2019 at 1:21 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, May 2, 2019 at 12:04 AM <ezemtsov@google.com> wrote:
> >
> > Hi All,
> >
> > Please take a look at Incremental FS.
> >
> > Incremental FS is special-purpose Linux virtual file system that allows
> > execution of a program while its binary and resource files are still be=
ing
> > lazily downloaded over the network, USB etc. It is focused on increment=
al
> > delivery for a small number (under 100) of big files (more than 10 mega=
bytes each).
> > Incremental FS doesn=E2=80=99t allow direct writes into files and, once=
 loaded, file
> > content never changes. Incremental FS doesn=E2=80=99t use a block devic=
e, instead it
> > saves data into a backing file located on a regular file-system.
> >
> > What=E2=80=99s it for?
> >
> > It allows running big Android apps before their binaries and resources =
are
> > fully loaded to an Android device. If an app reads something not loaded=
 yet,
> > it needs to wait for the data block to be fetched, but in most cases ho=
t blocks
> > can be loaded in advance and apps can run smoothly and almost instantly=
.
>
> This sounds very useful.
>
> Why does it have to be a new special-purpose Linux virtual file?
> Why not FUSE, which is meant for this purpose?
> Those are things that you should explain when you are proposing a new
> filesystem,
> but I will answer for you - because FUSE page fault will incur high
> latency also after
> blocks are locally available in your backend store. Right?
>
> How about fscache support for FUSE then?
> You can even write your own fscache backend if the existing ones don't
> fit your needs for some reason.
>
> Do you know of the project https://vfsforgit.org/?
> Not exactly the same use case but very similar.
> There is ongoing work on a Linux port developed by GitHub.com:
> https://github.com/github/libprojfs
>
> Piling logic into the kernel is not the answer.
> Adding the missing interfaces to the kernel is the answer.

I wonder whether userfaultfd can but used for that use-case too?

--=20
Thanks,
//richard
