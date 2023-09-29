Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0B17B317F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 13:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjI2LfH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 07:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjI2LfF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 07:35:05 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820931B9
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 04:35:02 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-452951b27d0so6669571137.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 04:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695987301; x=1696592101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjJf24AsZP4x+fO4di+uC9yyykaFt3qr2jF70Fg1IiM=;
        b=UinSlrg/I0lcaTqyPQo8yw/qmeS+g/1uczYsacZ48x8XtEGnAvJs+JtS3PZJYHaH6b
         j5foXHvJ2QDaEqgzafbPJwL7r8Pl388Akhj7m+dSG5ENnEoQPbHVhszPMIHp6z1UV+gb
         yIiPEWeDQz1ivMNLnjoLsNVEIWQLFEwqcoUj3xBg8uppDX1OU98ebw8UD8Zkc7f+xBCi
         lVCsvR3dU4+OP3Ka4GC0wfPirqIeBcMaZBbLg6KhtOjhY5zGX9BoH8507UPSGOe56QUl
         gmNafLfX8h84xLIxHAR5vX/jyFjXL/9vCvX6na14yEtF2Y8UwLUsHt9uoWhHKn6Y/0Th
         BqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695987301; x=1696592101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjJf24AsZP4x+fO4di+uC9yyykaFt3qr2jF70Fg1IiM=;
        b=b116Pp9bfDcWV94PaYp6J9Vh/+F8rhT+fblmI7rMbpbZZHbKnKfpuznuMre2C4tXCv
         wFYWwkS6w+EbHB98Ve1mZMmRSaaipNbdZob71j5CyeM7kNQ+/pGcd7Loy6GyThjfTHlw
         Vqeo45qUjMOCfE4siMpa9OxP30PnXTAlbWyRloVWuSMbQu9tPk7u9Pem+zOx9EMPDv99
         JxIZTcRBoxlkMXHp9cgl3JyYLUbbiI93eFXyDU4CI9SGf6osFNGeqJHsdbm38f2UUwiZ
         ppbiNTpYLGcjdXO9027wXcyOQY4QRxNNm5CCHcev5s6F4e7EdGih6siVpJZL5cjcS72S
         B26A==
X-Gm-Message-State: AOJu0YzMAgW+EOQZInpIIYuOyZP1O4oUWQLPsOf4aS4HXPl1fYlVWRjr
        yX7s0YlNVAJwc4QxWJcU4M8gZxk6gn6E/d72BG0=
X-Google-Smtp-Source: AGHT+IFp9gnMx0ESISmqJlkPnwf0XLzOHXiU8VLgxWGFzFyRj0NNCD6RNC2GWP+7lRYcmCvjEBRi2uEv418bfKkMMEU=
X-Received: by 2002:a05:6102:39a:b0:44e:9e04:bfdf with SMTP id
 m26-20020a056102039a00b0044e9e04bfdfmr3725760vsq.10.1695987301434; Fri, 29
 Sep 2023 04:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230920173445.3943581-1-bschubert@ddn.com> <CAOQ4uxi+jk7rv7mtnpH4RXbZJx6N+cWecqd3UyJJHsW8yw_SXg@mail.gmail.com>
 <b22b8760-fca0-4251-b1a8-5989c26e1657@ddn.com> <CAOQ4uxgbSFDfgz1vFnDAaJo-36T6UPnUXZnk_y=bZMi0NqzvKQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgbSFDfgz1vFnDAaJo-36T6UPnUXZnk_y=bZMi0NqzvKQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 29 Sep 2023 14:34:50 +0300
Message-ID: <CAOQ4uxjZYknxbBOYsfoJQmRfNmioHom0hHCrm4G1iU0KKrgxrA@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] fuse: full atomic open and atomic-open-revalidate
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "bernd.schubert@fastmail.fm" <bernd.schubert@fastmail.fm>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        Dharmendra Singh <dsingh@ddn.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 21, 2023 at 5:24=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Thu, Sep 21, 2023 at 3:00=E2=80=AFPM Bernd Schubert <bschubert@ddn.com=
> wrote:
> >
> > On 9/21/23 11:33, Amir Goldstein wrote:
> > > On Thu, Sep 21, 2023 at 9:31=E2=80=AFAM Bernd Schubert <bschubert@ddn=
.com> wrote:
> > >>
> > >> In FUSE, as of now, uncached lookups are expensive over the wire.
> > >> E.g additional latencies and stressing (meta data) servers from
> > >> thousands of clients. With atomic-open lookup before open
> > >> can be avoided.
> > >>
> > >> Here is the link to performance numbers
> > >> https://lore.kernel.org/linux-fsdevel/20220322121212.5087-1-dharamha=
ns87@gmail.com/
> > >>
> > >> Here is the libfuse pull request
> > >> https://github.com/libfuse/libfuse/pull/813
> > >>
> > >> The patches are passing passthrough_hp xfstests (libfuse part applie=
d),
> > >> although we had to introduce umount retries into xfstests, as recent
> > >> kernels/xfstests fail umount in some tests with
> > >> EBUSY - independent of atomic open. (Although outstanding for v7)
> > >
> > > Hi Bernd!
> > >
> > > I was using xfstests to test passthrough_hp (for FUSE kernel passthro=
ugh).
> > > FYI, I have made some improvements to the mount helper
> > > in libfuse [1] to support remount, which helps pass a few tests.
> >
> > Thanks, just asked there to send it separate to upstream.

Now upstream. Thanks for your help!

> >
> > >
> > > So far, I have all the tests in group -g quick.rw pass with the basel=
ine
> > > passthrough_hp (over xfs).
> > >
> > > Do you have a baseline for the entire quick/auto group to share with =
me?
> >
> > Please find my results attached.
>
> Not too bad.
> 3 more tests can pass with my mount helper fix for remount ;)
>

FYI, here is a wdiff of my -g auto passthough_hp test run compared to yours=
:

[-unpatched-6.5-]{+upatched-6.6-rc3+}
Failures: generic/003 [-generic/020-] {+generic/099+} generic/184
generic/192 generic/263 [-generic/294 generic/306-] {+generic/317
generic/318 generic/319 generic/375+} generic/401 {+generic/423+}
generic/426 [-generic/427-] generic/434 [-generic/452-]
{+generic/444+} generic/467 [-generic/468-] generic/477
[-generic/478-] generic/617 {+generic/532+} generic/631 generic/633
generic/683 [-generic/688-]

Some of my {+NEW+} failures are because I have POSIX_ACL support enabled
in Kconfig, so the same tests are [not run] in your results.
I suspect that several permission related tests that PASS for you and FAIL
for me may also be because of enabled POSIX_ACL.
I was also running passthouhg_hp with -odefault_permissions, but AFAIK
this did not change the fstests results.

> >
> >
> > > Can you share the patch that you are using to avoid the EBUSY errors?
> >
> >
> > The simple version to avoid _most_ of EBUSY is this
> >

You know, I am testing passthrough_hp with kernel 6.6-rc3 and I did
not encounter any EBUST errors.

Maybe there is some relevant vfs fix in 6.6-rc3, because you were testing 6=
.5?
Or maybe it's because my test VM has only 2 cpus.

Thanks,
Amir.
