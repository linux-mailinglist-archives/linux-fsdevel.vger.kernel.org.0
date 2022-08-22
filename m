Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA9A59CBCD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 00:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiHVWzP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 18:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiHVWzO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 18:55:14 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1874554CAD
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 15:55:13 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gi31so17631365ejc.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 15:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=jEXYX0FiZJYeI/EtMkIQRVVmJPezaLHR624TmfwVIqs=;
        b=fDre3QJ+ZgrjIzx3g+H7YNGLeIfQvkm6iSfO3xZSUkSwycGw6KsLHHPgTfT/cl/L5C
         p9xngQS9pCI3najOmqgZm/8Szp+fm8sLdmLZ1KCzo5/K/B54YdbcrcSSWOL8Es4Uce62
         wIRgxDts/9MqyBCxUZDUfaUFQ2gBDdHfeEBYhM4VDrJOPjcp6GZokwCZbXiZrkmDb2U+
         ato4XYqPxBfJWHgY7QD6bkld1FcPyz1LHV7rizgBmoJrv6p3QiFNj85V33u5PzcksrL3
         mm/bxNVg05AqVusAZs8orXzTIbJg1Bo05wpS1n5X3ilhZOLQXvIq62K5m1PweCuWa0+Y
         6oRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=jEXYX0FiZJYeI/EtMkIQRVVmJPezaLHR624TmfwVIqs=;
        b=hp70zKotz1cQ2hck6modr8xREZQakxYhyprzQSvxot0c7626JwvHMc69C9lFsKX4qn
         KoK+56g3N2OryXxYNpGxGFsPn+8odMrhywXDEHzWiiJOrTp6sgv+Lsr6hQhdJ+3IVgMJ
         CuYm7XKZYQIlgq5mysgA58/ZuCP9+JBQrA+j4Vbf6iDHDKNePfdx5Dzdq6pzrbAzIBKK
         4Yql6jEp5lE3K+K/sp9iQ8Y0bh9Nngk6vNRGxCuZ3jSbW9M9ZiaHrtS3LA53jfR6dGD0
         2WPCXYragDukoxmpyjRcRhJuu6n/EfTyPpLYe203kyvQPsOdGpdXz/ksD5Cj5CrlIeaY
         b4nw==
X-Gm-Message-State: ACgBeo2BlR8w7+vYfOAXOYciNQeQVsYUzrso8CJQfI9F5gdFx1Cl/EZ6
        urDyCpiO7+eFCaAJiC7e+86fBIW8svt51wXCy6joEF0WqkU9qA==
X-Google-Smtp-Source: AA6agR4a3w/F5Y4kOmOSP/qOuYOi6Gx/ThTjjGro4p48r7xD/zIS4wV7UAXaKOqB9FjhyP9NS+XEctd0lptuskrWTCE=
X-Received: by 2002:a17:906:6a1d:b0:73d:8bb4:94aa with SMTP id
 qw29-20020a1709066a1d00b0073d8bb494aamr2893381ejc.249.1661208911299; Mon, 22
 Aug 2022 15:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAAmZXruoj6vYi3AA2X3mnzOACniG_5ZrTmEFKYp7=fbr6aRHGQ@mail.gmail.com>
 <CAJfpegtf7QR1=-sV59jUsJKX4f1T3Mcov=HjoTZUdLf+XyA-3A@mail.gmail.com> <CAAmZXrtrb16hrfskZuWRhGFMy+WyS4Fg0PNL_yjiFauiLEOXbA@mail.gmail.com>
In-Reply-To: <CAAmZXrtrb16hrfskZuWRhGFMy+WyS4Fg0PNL_yjiFauiLEOXbA@mail.gmail.com>
From:   Frank Dinoff <fdinoff@google.com>
Date:   Mon, 22 Aug 2022 18:54:54 -0400
Message-ID: <CAAmZXruF1mSzWici4+PEuGqDvycOo6cJi4Jw8xxTrUjawe7f_A@mail.gmail.com>
Subject: Re: fuse: incorrect attribute caching with writeback cache disabled
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 12, 2022 at 6:58 PM Frank Dinoff <fdinoff@google.com> wrote:
>
> On Fri, Aug 12, 2022 at 5:33 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Thu, 11 Aug 2022 at 23:05, Frank Dinoff <fdinoff@google.com> wrote:
> > >
> > > I have a binary running on a fuse filesystem which is generating a zip file. I
> > > don't know what syscalls are involved since the binary segfaults when run with
> > > strace.
> >
> > You could strace the fuse filesystem.
>
> I'll try doing this later, I was unsuccessful in finding anything
> useful printing large amounts
> of debug logs.

I got strace working on the program. It looks like it doing something like

open(O_RDWR) = 9
multiple write(...) calls such that the lseek below is before end of file.
lseek(9, 2514944, SEEK_SET)             = 2514944
read(9, "", 8192)                       = 0 // Should have read 5770 bytes
lseek(9, 5770, SEEK_CUR)                = 2520714 // should be end.
write(...)
close(9)
open(O_RDWR) = 9
lseek(9, 2514944, SEEK_SET)             = 2514944
read(9, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
6042) = 6042
...

The first read doesn't return data and I'm not sure why. It is kinda
like the kernel page cache has gotten out of sync and thinks the whole
file should be zeros.

>
> >
> > > After doing a binary search,
> > > https://github.com/torvalds/linux/commit/fa5eee57e33e79b71b40e6950c29cc46f5cc5cb7
> > > is the commit that seems to have introduced the error. It still seems to
> > > failing with a much newer kernel.
> >
> > How is it failing?
>
> Oops sorry I thought I included that.  You can't unzip the file.
> unzip -t has "error:  invalid compressed data to inflate"
>
> > > Reverting the fuse_invalidate_attr_mask in fuse_perform_write to
> > > fuse_invalidate_attr makes every other run of the binary produce the correct
> > > output.
> >
> > What do you mean?  Is it succeeding half the time?
>
> Running the binary multiple times in a row about 50% produce the
> correct file and 50%
> produce a corrupt file.
>
> Running the test multiple times before fa5eee57 I'm seeing about 10%
> of runs producing
> a corrupt file. (I did not realize this had a chance of failure on the
> old kernel.)
> After fa5eee57 I have 100% of runs producing the corrupt file.
>
> >
> > >
> > > I found that enabling the writeback cache makes the binary always produce the
> > > right output. Running the fuse daemon in single threaded mode also works.
> > >
> > > Is there anything that sticks out to you that is wrong with the above commit?
> >
> > Could you try adding STATX_MODE to the invalidated mask?   Can't
> > imagine any other attribute being relevant.
>
> Adding STATX_MODE to FUSE_STATX_MODIFY does make the binary produce the
> correct file about 75% of the time. The last bit of flakiness may be
> some concurrency
> issue in the binary?
>
> >
> > Thanks,
> > Miklos
