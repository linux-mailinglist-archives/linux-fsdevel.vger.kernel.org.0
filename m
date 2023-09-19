Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBD77A6434
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 15:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjISNBn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 09:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjISNBl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:01:41 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C85F3
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 06:01:35 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b9e478e122so3564639a34.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 06:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695128494; x=1695733294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzdGv4HvX/IAX/T1Yd2B1eAMs+DRTtHs4LlRUm81MdI=;
        b=kLtGPznt98bsfqfkc6O5ldPGKPZ+nh1qz3RrzusbDGIpZoEiaIj4ShLnNXVAtxOJm2
         lXbbRw5gl7mNlcgFU7zLJyfwbMJ9A2vraswfwtlA/u7UXw1HWq5hSgiKtmFur48Rl4rC
         uFjJjt2L0715pks7L5Z0oruuImP5VsfzMHheCtz8kFtGtbLv6djWPzlgJu4mb2rKD0ZP
         j7GOpKGaeG6xPErP4/2055INnxbESXHYgXNeH7DhKb7Ir0WOt1LUrgvm87I3agfQWtZj
         6Z8j7CdfTLN+jn08aO2tW5HIJf2Vts9E+Bj8smjAo2Z8l+ssrOc1f/7pZ2/uLZgy+X/G
         8uig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695128494; x=1695733294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzdGv4HvX/IAX/T1Yd2B1eAMs+DRTtHs4LlRUm81MdI=;
        b=MNxsS+Lz7R+g86pMv9khi7zZwqcobm+Wwc/grR9fET2kLxabUeKf2XoUcoyIUwqVtD
         NZUMxJEPWNIYcLP9wAtUVFgqB0RGAZPvsSsMbu0EsGrSa1OUrLxNxVkwzAw+sjYkB7/s
         Tcnot+ZajLHGhFiqSy4HI46RksvLrDVRY7yAOiE3sXlyj5CYescrH4cF99mNN+ZftrBy
         bEyv0/ymnESaCd4+QSCAAQtfegmRZ19kPH2jgkXva1879j+pGYxCJY619q9xJ7LSs/mk
         C/ob+S26TfNvQ1tAq57YfGpaH+krdDQE8TmRtBkpVjaKYsHAW7hMkdUPE7fa1u3dm2I6
         CRCA==
X-Gm-Message-State: AOJu0YwlspKnxNNOXP2kJR0v2Kb79ztfXg1+MmgaSzOwUBlZuPG6CRQq
        j30yZnuX3s/fSTEA6qywOX6/+GDPcpp+Yj8RUnk=
X-Google-Smtp-Source: AGHT+IGs+bG9Zy4LLT38snYI8cgjYKvj2dnoED83QZzBH09MiYazXQYaRNzajDlOO8ZnKJ8jGfbrE3lX4ws13WMoNS4=
X-Received: by 2002:a05:6358:1427:b0:143:623f:7dfc with SMTP id
 m39-20020a056358142700b00143623f7dfcmr447483rwi.26.1695128494124; Tue, 19 Sep
 2023 06:01:34 -0700 (PDT)
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
 <CAKPOu+9ds-dbq2-idehU5XR2s3Xz2NL-=fB+skKoN_zCym_OtA@mail.gmail.com>
 <CAOQ4uxgvh6TG3ZsjzzdD+VhMUss3NLTO8Hk7YWDZs=yZagc+oQ@mail.gmail.com> <CAKPOu+_y-rCsKXJ1A7YGqEXKeWyji1tF6_Nj2WWtrB36MTmpiQ@mail.gmail.com>
In-Reply-To: <CAKPOu+_y-rCsKXJ1A7YGqEXKeWyji1tF6_Nj2WWtrB36MTmpiQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 19 Sep 2023 16:01:22 +0300
Message-ID: <CAOQ4uxhtfyt8v3LwYLOY9FwA46RYrwcZpZv7J8znn5zW-1N5sA@mail.gmail.com>
Subject: Re: inotify maintenance status
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Ivan Babrou <ivan@cloudflare.com>,
        Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 3:51=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> On Tue, Sep 19, 2023 at 2:21=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> > Regarding inotify improvements, as I wrote, they will each be judged
> > technically, but the trend is towards phasing it out.
>
> Then please reconsider merging inotify_add_watch_at(). It is a rather
> trivial patch set, only exposing a user_path_at() parameter to use
> space, like many other new system calls did with other old-style
> system calls. Only the last patch, the one which adds the new system
> call ot all arch-specific tables, is an ugly one, but that's not a
> property of the new feature but a general property of how system calls
> are wired in Linux.
>
> My proposed system call adds real value to all those who are currently
> using inotify, allowing them to use inotify with a modern and safe and
> race-free syscall interface, eliminating the unsafe fchdir() dance to
> emulate it in userspace.
>
> The inotify interface is widely used and will be for a long time to
> come, while it is hard to find code which already uses fanotify.
> GitHub code search finds 438 occurences of fanotify_init() calls, 4.6k
> inotify_init1() calls and 6.9k inotify_init() calls. Given the added
> complexity of fanotify and the uselessness of most of fanotify's
> feature for most software (except for dfd support), it is extremely
> unlikely that a noticable fraction of those thousands of projects will
> ever migrate to fanotify. Even if inotify is considered a legacy API,
> it should be allowed to modernize it; and adding dfd support to system
> calls is really important.
>

Both Jan and I already gave an answer to this specific patch.
The answer was no.

We do not add new system calls for doing something that is already
possible with existing system calls to make the life of a programmer
easier - this has never been a valid argument for adding a new syscall.

Thanks,
Amir.
