Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CAC7A63C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 14:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjISMvx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 08:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjISMvw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:51:52 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3B4B8
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 05:51:45 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bceb02fd2bso89870121fa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 05:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695127904; x=1695732704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5qkKlX4pMnY6imW6cG8/fQnG0P2wsOWlbfG+4VEhfI=;
        b=fdlJEHygFodpa6dc4QT4zs1f8UvtTbZVjVnNVb2JAotA/fzYOdKK0TnutMqa/Fui/N
         eOAULLX27IcomDC+RNLf+Vb7FkyzlmJd4erNigEacfa3joWwB/qXYkXrkoQMe8mv8WjR
         mx/bVXi3pPeecVqDi02JqVhBRP9T13qnVxLlKWENrl7AbiLOCXDLk/fCGa04690/96Vd
         45AIlZI1MSGeIQ3oVxJvJ07gbSft2yjZ8MJhmxp4iq1+MQqZfzAdiUFOVa4ZkN/sMpk9
         A3SjKMVzbT1/0WB/Zz3h1NcsK2vYxO5s1XahxtG75W9O0NJNNIDYQ639Z8Bap60JpA7y
         ovug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695127904; x=1695732704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5qkKlX4pMnY6imW6cG8/fQnG0P2wsOWlbfG+4VEhfI=;
        b=OfjcMEpbf0En8P3UvDoWXQOdDk+lVDS0d7rPawC8m1bf4hTlw8oTxcleuAxrW4f1cc
         KbO/6O35QStYO88QIOr7mDP1WHN8Xm/AtE6jvlAljUWOQQluIlfFbZV85Py7qzN2Hwzj
         aOBa0WIdsAZOMC7q2nBiygvFSkp/zDFPo/fwbCQhfxy7m3LRS5ezy0D9EZlhhPaltRh1
         U4/Z/orfEYJl351IoAO2NHXhR3iAApC8JoEE3vB9T/gGaodsOOBbU0U8zdq4ChO7PbAA
         8nXQP3lectvaTpH0rUHRErAk9dn7ook4Ccp55FXaV3Y8B6A5F2WUEz/octhRTLGdmDaw
         f48A==
X-Gm-Message-State: AOJu0Ywkmm8gCKr5kFyJLF67pXoHiL997om6QxV1+/JPCsXVPQ++LlZt
        38pfcqxMnaT5/CGXFQzd8I094RBwLaVL6wU+0bvhZ2Jj3I9qJXLwXmUFFg==
X-Google-Smtp-Source: AGHT+IFllTWqMOkdnE3QzGUVmqtjAdtHerz87UXcKnkDCbKIvs7IXw8Vq+ccJrvjltNnZmA0n+rSbngemFuVzEFAlGk=
X-Received: by 2002:a2e:950c:0:b0:2bf:ab17:d48b with SMTP id
 f12-20020a2e950c000000b002bfab17d48bmr9739583ljh.34.1695127904086; Tue, 19
 Sep 2023 05:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230918123217.932179-1-max.kellermann@ionos.com>
 <20230918123217.932179-3-max.kellermann@ionos.com> <20230918124050.hzbgpci42illkcec@quack3>
 <CAKPOu+-Nx_cvBZNox63R1ah76wQp6eH4RLah0O5mDaLo9h60ww@mail.gmail.com>
 <20230918142319.kvzc3lcpn5n2ty6g@quack3> <CAOQ4uxic7C5skHv4d+Gek_uokRL8sgUegTusiGkwAY4dSSADYQ@mail.gmail.com>
 <CAOQ4uxjzf6NeoCaTrx_X0yZ0nMEWcQC_gq3M-j3jS+CuUTskSA@mail.gmail.com>
 <CAOQ4uxjkL+QEM+rkSOLahLebwXV66TwyxQhRj9xksnim5F-HFw@mail.gmail.com>
 <CAKPOu+_s8O=kfS1xq-cYGDcOD48oqukbsSA3tJT60FxC2eNWDw@mail.gmail.com>
 <20230919100112.nlb2t4nm46wmugc2@quack3> <CAKPOu+-apWRekyqRyYfsFkdx13uocCPKMzYJqmTsVEc6a=9uuA@mail.gmail.com>
 <CAOQ4uxgG6ync6dSBJiGW98docJGnajALiV+9tuwGiRt8NE8F+w@mail.gmail.com>
 <CAKPOu+9ds-dbq2-idehU5XR2s3Xz2NL-=fB+skKoN_zCym_OtA@mail.gmail.com> <CAOQ4uxgvh6TG3ZsjzzdD+VhMUss3NLTO8Hk7YWDZs=yZagc+oQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgvh6TG3ZsjzzdD+VhMUss3NLTO8Hk7YWDZs=yZagc+oQ@mail.gmail.com>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Tue, 19 Sep 2023 14:51:32 +0200
Message-ID: <CAKPOu+_y-rCsKXJ1A7YGqEXKeWyji1tF6_Nj2WWtrB36MTmpiQ@mail.gmail.com>
Subject: Re: inotify maintenance status
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Ivan Babrou <ivan@cloudflare.com>,
        Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 2:21=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
> Regarding inotify improvements, as I wrote, they will each be judged
> technically, but the trend is towards phasing it out.

Then please reconsider merging inotify_add_watch_at(). It is a rather
trivial patch set, only exposing a user_path_at() parameter to use
space, like many other new system calls did with other old-style
system calls. Only the last patch, the one which adds the new system
call ot all arch-specific tables, is an ugly one, but that's not a
property of the new feature but a general property of how system calls
are wired in Linux.

My proposed system call adds real value to all those who are currently
using inotify, allowing them to use inotify with a modern and safe and
race-free syscall interface, eliminating the unsafe fchdir() dance to
emulate it in userspace.

The inotify interface is widely used and will be for a long time to
come, while it is hard to find code which already uses fanotify.
GitHub code search finds 438 occurences of fanotify_init() calls, 4.6k
inotify_init1() calls and 6.9k inotify_init() calls. Given the added
complexity of fanotify and the uselessness of most of fanotify's
feature for most software (except for dfd support), it is extremely
unlikely that a noticable fraction of those thousands of projects will
ever migrate to fanotify. Even if inotify is considered a legacy API,
it should be allowed to modernize it; and adding dfd support to system
calls is really important.

Max
