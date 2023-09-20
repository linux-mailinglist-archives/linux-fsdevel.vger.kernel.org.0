Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD567A8B6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 20:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjITSQZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 14:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjITSQY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:16:24 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCF6DD
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 11:16:17 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso1417001fa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 11:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695233776; x=1695838576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ci1g/cte9gSHj2DpuoI+OdLKMPegXGILkw8kLLbZLA=;
        b=FkxxD05eE4WOGcxPC3/nAL6LqsJwbId8Tr5qMAJHHA3i59ZrmkAy2O3POe/dgnE/3W
         HVo3jSUL+BkqFF+5NlJLmeYFtTz9BwtvE4yI3jTJTJvDmsJmBo2VPOkC+MoP+x9dfL3R
         YhaOWWpQM5BWK/f0N0MnoACqo2EZ8FmVg6eSqmUUFdiCqLmYJgsibFOpCO7e2X8UdFI+
         60b9aYo8mZVMbGHsKJ67vAV0R2Oi7Tn7AIyqNDJa6k42/OhBnxDENlfEOl9/agWN3j2h
         nRPBYdjh/3OCu+w3G1V7gLR6qdFCEbf/eTYAnXPG5CHZpYtAp2RXLFR6wRv/YvTfFmSN
         SY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695233776; x=1695838576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Ci1g/cte9gSHj2DpuoI+OdLKMPegXGILkw8kLLbZLA=;
        b=OqhYM6AJq7BZkZEBQzoQwmoX8Z/x6ZZeNLmUD3vMjXAk0c01tiF8mfpTmN7yc3x5BP
         3/nUZcVjVMPYIpCsMcF1gI+doWPv/64u1AGdH8U4os16sA7I+ShV4iuAPlGVaCNxEIzv
         UugJWABGpM/8R45jETU+FiazTck5AQaB57FD56Utw23CbLCqIgbHwQNU2G1wnO2gFqGQ
         UooT/zJC5IUN8bqyhBp3fzlCyA2dlKu3duBmJxOf+H0dtDSBhAlyKn5FJ9d2+4ZdsGXI
         8H+mHddVbuOqnWX5j3WV5WDwNj4ImvtEJkHSrQGX4nxEhuyaPhySDXWKIV90Yd7fjGvm
         F88w==
X-Gm-Message-State: AOJu0YxlT6tvrPRNmCjHr0Z+dWeU+U2ExjJ4I9rrAlSjyP/DrdBzVfFU
        t+zZ+BwVoxuiDjax/LeAxSWZ+H+tjCwrjtoXs8Q20Q==
X-Google-Smtp-Source: AGHT+IHz2PnMzW7vWJkkdnXsBQiY07AOTLgmA+maOP8XKNBKhDvTl7VB8xW+SOngJ7/3rhcI5CVz/Hhy6VrbKJd4iWI=
X-Received: by 2002:a2e:8908:0:b0:2bd:a85:899e with SMTP id
 d8-20020a2e8908000000b002bd0a85899emr2934293lji.3.1695233776070; Wed, 20 Sep
 2023 11:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230919081259.1094971-1-max.kellermann@ionos.com>
 <20230919-kommilitonen-hufen-d270d1568897@brauner> <f37c00c5-467a-4339-9e20-ca5a12905cd3@kernel.dk>
In-Reply-To: <f37c00c5-467a-4339-9e20-ca5a12905cd3@kernel.dk>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Wed, 20 Sep 2023 20:16:04 +0200
Message-ID: <CAKPOu+_fwVZFXhTuzcWneNcjHJ99n00j_oq+sF8P-zvsPCOdVQ@mail.gmail.com>
Subject: Re: [PATCH] fs/splice: don't block splice_direct_to_actor() after
 data was read
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 20, 2023 at 7:28=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
> I think adding the flag for this case makes sense, and also exposing it
> on the UAPI side.

OK. I suggest we get this patch merged first, and then I prepare a
patch for wiring this into uapi, changing SPLICE_F_NOWAIT to 0x10 (the
lowest free bit), add it to SPLICE_F_ALL and document it.

(If you prefer to have it all in this initial patch, I can amend and
resubmit it with the uapi feature.)

> My only concern is full coverage of it. We can't
> really have a SPLICE_F_NOWAIT flag that only applies to some cases.

The feature is already part of uapi - via RWF_NOWAIT, which maps to
IOCB_NOWAIT, just like my proposed SPLICE_F_NOWAIT flag. The semantics
(and the concerns) are the same, aren't they?

> That said, asking for a 2G splice, and getting a 2G splice no matter how
> slow it may be, is a bit of a "doctor it hurts when I..." scenario.

I understand this argument, but I disagree. Compare recv(socket) with
read(regular_file).
A read(regular_file) must block until the given buffer is filled
completely (or EOF is reached), which is good for some programs which
do not handle partial reads, but other programs might be happy with a
partial read and prefer lower latency. There is preadv2(RWF_NOWAIT),
but if it returns EAGAIN, userspace cannot know when data will be
available, can't epoll() regular files. There's no way that a read()
returns at least one byte, but doesn't wait for more (not even with
preadv2(), unfortunately).
recv(socket) (or reading on a pipe) behaves differently - it blocks
only until at least one byte arrives, and callers must be able to deal
with partial reads. That's good for latency - imagine recv() would
behave like read(); how much data do you ask the kernel to receive? If
it's too little, you need many system calls; if it's too much, your
process may block indefinitely.

read(regular_file) behaves that way for historical reasons and we
can't change it, only add new APIs like preadv2(); but splice() is a
modern API that we can optimize for how we want it to behave - and
that is: copy as much as the kernel already has, but don't block after
that (in order to avoid huge latencies).

My point is: splice(2G) is a very reasonable thing to do if userspace
wants the kernel to transfer as much as possible with a single system
call, because there's no way for userspace to know what the best
number is, so let's just pass the largest valid value.

Max
