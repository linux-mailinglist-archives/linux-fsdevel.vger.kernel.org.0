Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008D5788C15
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 17:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343764AbjHYPDy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 11:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343887AbjHYPDt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:03:49 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C416C212A
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Aug 2023 08:03:46 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-583c49018c6so14681947b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Aug 2023 08:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692975826; x=1693580626;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkkmx6QZNTM7+yep5mezfNyD82wEsqTkXpsJxKaHy34=;
        b=YoL7C/UcRJIHcdxTmmcXcShHy11ZCuNj0QVQQ/77rIdkQaQspozAG+h6kRhX6FtzEm
         hWj+2zq8xE9J4UPbNHsHlEQMHYPw67q7pcZvl+i09ozowdnd/R3bKwqfd/4zKmotQ0BH
         QOatF5KbIdQxoNAXVtZZSyr/kNNPfoQoLOkLf4Ux1GZUCCoizcTN1i8Vov7YZs9/68k7
         kNQFQ9SQWIvs5H6HSYaCzwMAk7Ke/ARH1wiX+YV3LAh9biKoOyKLaYRoOm5oEPdo3fF+
         6AmjDk7MiNzZaIHJFtG25L4dUXyayTSXdw39iu3JAwwHrvX6qjZUhcCJe7FZeKFOGo8K
         9XzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692975826; x=1693580626;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zkkmx6QZNTM7+yep5mezfNyD82wEsqTkXpsJxKaHy34=;
        b=H7EO+ojvKseD8LrrVBrCN0oO4I2dkl6aI+8E9l7RBJubzIXNaRaA+xPIN8H0q1UyFz
         A8KEU89C/dmtTszfYJqm4j7bxVxJ6+CBeKJz5NtCUmTfOJvmvmJ9P423PGXcSUAg36NV
         ixxduvSzjPW2FkEIoiFeQOIdz+kSWipPNPPPtGFVVS7WCbOHM5I/hACd86UPmy6m5cWf
         /y+UqH6S/212O4ROakXndpG4GvfbasKmJfqKFGvNhj5c6/CFS8DDBPa8u0rDtaZisi7P
         Psov4780CrWI+5eZUCob0ioUHEYYsVbtu/Hgg+C4vbM4y3xx+3cRjE/59IIuP7G64LMt
         FkSQ==
X-Gm-Message-State: AOJu0YxgEn1vo6aWEhDYUuWHw009+ZNoMH3KlpdxC8j+4GKsmiO1w/fu
        6d9fzzeQ78d2IQg8d74WGnwIVk8X078=
X-Google-Smtp-Source: AGHT+IFoHERlYEjZQSoDcfNlp5mpVohN6wh6g4DZHpjh/MeqnVhzZKKN9cCIGv6dCp5Uc5Q1cXvCM/8uBA4=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:33b0:9e28:e79a:8e70])
 (user=gnoack job=sendgmr) by 2002:a25:ac82:0:b0:d77:e43d:6e80 with SMTP id
 x2-20020a25ac82000000b00d77e43d6e80mr279381ybi.6.1692975826056; Fri, 25 Aug
 2023 08:03:46 -0700 (PDT)
Date:   Fri, 25 Aug 2023 17:03:43 +0200
In-Reply-To: <20230818.iechoCh0eew0@digikod.net>
Message-Id: <ZOjCz5j4+tgptF53@google.com>
Mime-Version: 1.0
References: <20230814172816.3907299-1-gnoack@google.com> <20230818.iechoCh0eew0@digikod.net>
Subject: Re: [PATCH v3 0/5] Landlock: IOCTL support
From:   "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To:     "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

On Fri, Aug 18, 2023 at 03:39:19PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> On Mon, Aug 14, 2023 at 07:28:11PM +0200, G=C3=BCnther Noack wrote:
> > These patches add simple ioctl(2) support to Landlock.
>=20
> [...]
>=20
> > How we arrived at the list of always-permitted IOCTL commands
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >=20
> > To decide which IOCTL commands should be blanket-permitted I went throu=
gh the
> > list of IOCTL commands mentioned in fs/ioctl.c and looked at them indiv=
idually
> > to understand what they are about.  The following list is my conclusion=
 from
> > that.
> >=20
> > We should always allow the following IOCTL commands:
> >=20
> >  * FIOCLEX, FIONCLEX - these work on the file descriptor and manipulate=
 the
> >    close-on-exec flag
> >  * FIONBIO, FIOASYNC - these work on the struct file and enable nonbloc=
king-IO
> >    and async flags
> >  * FIONREAD - get the number of bytes available for reading (the implem=
entation
> >    is defined per file type)
>=20
> I think we should treat FIOQSIZE like FIONREAD, i.e. check for
> LANDLOCK_ACCESS_FS_READ_FILE as explain in my previous message.
> Tests should then rely on something else.

OK, I rewrote the tests to use FS_IOC_GETFLAGS.

Some thoughts on these two IOCTLs:

FIONREAD gives the number of bytes that are ready to read.  This IOCTL seem=
s
only useful when the file is open for reading.  However, do you think that =
we
should correlate this with (a) LANDLOCK_ACCESS_FS_READ_FILE, or with (b)
f->f_mode & FMODE_READ?  (The difference is that in case (a), FIONREAD will=
 work
if you open a file O_WRONLY and you also have the LANDLOCK_ACCESS_FS_READ_F=
ILE
right for that file.  In case (b), it would only work if you also opened th=
e
file for reading.)

FIOQSIZE seems like it would be useful for both reading *and* writing? -- T=
he
reading case is obvious, but for writers it's also useful if you want to se=
ek
around in the file, and make sure that the position that you seek to alread=
y
exists.  (I'm not sure whether that use case is relevant in practical
applications though.) -- Why would FIOQSIZE only be useful for readers?

(In fact, it seems to me almost like FIOQSIZE might rather be missing a sec=
urity
hook check for one of the "getting file attribute" hooks?)

So basically, the implementation that I currently ended up with is:

switch (cmd) {
  case FIOCLEX:
  case FIONCLEX:
  case FIONBIO:
  case FIOASYNC:
  case FIOQSIZE:
    return 0;
  case FIONREAD:
    if (file->f_mode & FMODE_READ)
      return 0;
}

(with some comments in the source code, of course...)

Does that look reasonable to you?

=E2=80=94G=C3=BCnther

--=20
Sent using Mutt =F0=9F=90=95 Woof Woof
