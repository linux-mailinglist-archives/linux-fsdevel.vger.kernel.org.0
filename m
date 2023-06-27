Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE97173F44F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 08:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjF0GOs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 02:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjF0GOr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:14:47 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE3F1FD7;
        Mon, 26 Jun 2023 23:14:33 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-766fd5f9536so76220685a.3;
        Mon, 26 Jun 2023 23:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687846473; x=1690438473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGKfpXjOg1tRmeU1bzxCkZN0igEieCKHd+4ulvvFBzg=;
        b=pUkPvrqhV6xLpR8mQZ9DQ2t4UXEXPecGbPFIepdjEdAdE8kvtT452MN3VtKQvk1n9O
         HJismjo+zS1eFwhf3eOBkwJsqBPIMo0DkGDba6VScAZXU9pfPQxQZ64uHShtRtT6dn60
         8xYjIxNxW5TLxp5H8v7KS5UI7eRcF/WhF4yR4JrMEKTZNctAQYI92F/5k9tDNFSKSVC7
         /Hl4PqWVrskTEcAB7Gta6epp+LePkm/sndx19YP8QxnRiUbFXAydlJVo0Sd5BEKWRIhr
         x2TWWjj5S3El15n/UUA1aOQpPherXeN99k19VvyWgQuQsGX1zQhDLMIuphXQbSDWCHVI
         V7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687846473; x=1690438473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGKfpXjOg1tRmeU1bzxCkZN0igEieCKHd+4ulvvFBzg=;
        b=Ch7/NUYJGCeV1aRQRbjhUwLN1uYNPyjQJAMxpSsCg8DZ9vYbfwlexcpLJxCo8T9NsM
         468MfS9FAUhnCbtOhNndhWT8YxaYcVymiw8K57psSKEWCtNmw2j2ZOdcuuN8LxYs8HuP
         QIXoGYF/5sHyZ+5s71yhbXdekI5N1lRnIoOvGKOk0TBWoKhWLR5+xdM8No8mQSP1bdJi
         d2O2D1+T9/tSfFWSNPhDEq9kG9mAUjoi42DBUJmj+zOmI3PWSWzNLxUlePiJaJOY4P6F
         Nvf00nXALIFqdeEHJS0GWrXu4g7ZbfGiTkPlgMy6mh3I96mSvjDGhXTy/o10YPKpzuTc
         toEg==
X-Gm-Message-State: AC+VfDywPiLEUOGxHhGYGhdG+Z9msNW4Ft9CvCkUkpA0RP1WMzQYMZAi
        utJfKHUSNdWIy9Ndj5eW4INSo2VF+sbeL6lH9PoC8kQ4/Go=
X-Google-Smtp-Source: ACHHUZ4tPxAG2M/3+Wgt79gfG1OXKB1kV60hz6KxwcieZ9rVIKX3U44C0wA/7xmzJJFiRQ8gl0VVeIR2+VVKoTMQgdo=
X-Received: by 2002:a05:620a:b5d:b0:765:a99c:96f3 with SMTP id
 x29-20020a05620a0b5d00b00765a99c96f3mr3813534qkg.28.1687846472623; Mon, 26
 Jun 2023 23:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxj_DLm8_stRJPR7i8bp9aJ5VtjzWqHL2egCTKe3M-6KSw@mail.gmail.com>
 <pw3ljisf6ctpku2o44bdy3aaqdt4ofnedrdt4a4qylhasxsli6@wxhy3nsjcwn4>
In-Reply-To: <pw3ljisf6ctpku2o44bdy3aaqdt4ofnedrdt4a4qylhasxsli6@wxhy3nsjcwn4>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 27 Jun 2023 09:14:21 +0300
Message-ID: <CAOQ4uxh7i_s4R9pFJPENALdWGG5-dDhqPLEUXuJqSoHraktFiA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] fanotify accounting for fs/splice.c
To:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 2:08=E2=80=AFAM =D0=BD=D0=B0=D0=B1 <nabijaczleweli@=
nabijaczleweli.xyz> wrote:
>
> "people just forget to add inotify hooks to their I/O routines as a rule"=
?
> Guess what I did, fully knowing that some are missing in this file :)
>
> =3D=3D> te.c <=3D=3D
> #define _GNU_SOURCE
> #include <fcntl.h>
> #include <stdio.h>
> int main() {
>   ssize_t rd, acc =3D 0;
>   while ((rd =3D tee(0, 1, 128 * 1024 * 1024, 0)) > 0)
>     acc +=3D rd;
>   fprintf(stderr, "te=3D%zd: %m\n", acc);
> }
>
> =3D=3D> vm.c <=3D=3D
> #define _GNU_SOURCE
> #include <fcntl.h>
> #include <stdio.h>
> #include <string.h>
> static char sb[1024 * 1024];
> int main() {
>   memcpy(sb, "=C5=BCupan", sizeof("=C5=BCupan"));
>   ssize_t rd =3D
>       vmsplice(1, &(struct iovec){.iov_base =3D sb, .iov_len =3D sizeof(s=
b)}, 1,
>                SPLICE_F_GIFT);
>   fprintf(stderr, "vm=3D%zd: %m\n", rd);
> }
>
>
> echo zupa | ./te > fifo tees a few times and then blocks when the pipe
> fills, at which point we get into the broken state.
>
> Similarly, ./vm > fifo (with the default 64k F_GETPIPE_SZ) enters that
> same state instantly.
>
> With 2/3 and 3/3, they instead do
>   1: mask=3D2, cook=3D0, len=3D0, name=3D
>   rd=3D80
>   1: mask=3D2, cook=3D0, len=3D0, name=3D
>   rd=3D80
>   ...
> in a loop, as-expected, and
>   # ./vm > fifo
>   vm=3D65200: Success
>   1: mask=3D2, cook=3D0, len=3D0, name=3D
>   rd=3D65200
>
> I took the liberty of marking 2/3 and 3/3 as Fixes: of the original
> fanotify-in-splice commit as well, I think they fit the bill.
>

Thank you for doing this thorough research on all the variants!

It would be great if you could add test coverage for these syscalls.

Simplest would be to clone an LTP inotify test, e.g.
ltp/testcases/kernel/syscalls/inotify/inotify01

for the different splice syscall variants (sendfile as well).

LTP already has other tests for all those syscalls, so there are plenty
of examples of how to use the LTP helpers to test those syscalls.

You can either clone one inotify test per syscall, or clone one inotify
test that creates a fifo instead of a file that inotify watches
and use a test cases array for the different syscalls to test
(see example of test cases array in inotify10 test).

Thanks,
Amir.
