Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2217A6572
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 15:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjISNlq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 09:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjISNlp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:41:45 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CE7EC
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 06:41:39 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c00e1d4c08so33194131fa.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 06:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695130898; x=1695735698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWdpOUGTxeyMpDOAV0S2tIp0WwfqtvZm+pXSUAKCTMk=;
        b=H9+v6ypQbcZNReleU932yu8LN/DMRhRyOb3A8MqLvznh7ci6Wh8LNzg8ZqLC4RyXE1
         cXG7ixPNGdvHA7pc3Ydl6heOnjf0lSFnxz54U6ObgHaBjlkgFKVtoWy3NJitgnc0IqQG
         Wkp0GvrQTL35lmbYgkNpLpjzgxdMLdehMrExhcwELDo0m9ibsjvaLKIyqQR7VINRyJd0
         i6+6JXYjJK0jWb7RgmlUYcKDPQnsOqq6GJWmSm26zUoWXUuK+UjtO/s+nbuCouzjuBad
         OY75kmZQe+u44YdKs5quGFa0yDiCMWPI+wcLuhQAq9Zyw2bropD71bmtA0Tto444BXbB
         LOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695130898; x=1695735698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWdpOUGTxeyMpDOAV0S2tIp0WwfqtvZm+pXSUAKCTMk=;
        b=D+2TLotG5vW1ZJJ6P292tAWYkP7JEI6tcgTFGThLXG01ta75gRYdfmUzmE+dlXqm11
         a9cSQONS9nA/+62ECGibxHEQr7XOj9nZVz3YMi2gZbMc76wsrCNPCaU6t64Io9GPqtfx
         qDad6voPrbM+a1KYX2FvCKy8qiGbd4fLMP9KMJGggxPJhG2Y80TPYrpnaJTCZALdjyZm
         EFC1JEG7kFWJLg5O+6WRaHf/ejPo3Vt2da4cFbg26Iz/P0xAJju6cioM3w4MqoFOEpzS
         Ln0+UrM7Tn2w/0R3Wx/ZTKtGjzDZ2ucFQi/6gHmbJ2do1JZ0qCYnoGGVb/aIo1orzIBd
         FZ6w==
X-Gm-Message-State: AOJu0YwZG+P1DM8iGuIJR7VHJ9DVyPrFJ4RifUd/Bf09dHNTi5VQuuDY
        UFeA01hFJ6QvIm268+cEBhTvPwnaTv4BR3TuBO5h5hvwBvqvW3S9uU/ecw==
X-Google-Smtp-Source: AGHT+IHo9j7Il++N4HAoBoHMj3L0AUWIFczxnxQEYj5cAjBLGsFihFjvO8ab0jKSxtxjeCaPoRXFo6RuQ7JnUELh0T8=
X-Received: by 2002:a05:651c:11:b0:2bb:97af:f37a with SMTP id
 n17-20020a05651c001100b002bb97aff37amr9710311lja.28.1695130898080; Tue, 19
 Sep 2023 06:41:38 -0700 (PDT)
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
 <CAOQ4uxgvh6TG3ZsjzzdD+VhMUss3NLTO8Hk7YWDZs=yZagc+oQ@mail.gmail.com>
 <CAKPOu+_y-rCsKXJ1A7YGqEXKeWyji1tF6_Nj2WWtrB36MTmpiQ@mail.gmail.com>
 <CAOQ4uxhtfyt8v3LwYLOY9FwA46RYrwcZpZv7J8znn5zW-1N5sA@mail.gmail.com>
 <CAKPOu+8tCP+bRXFy0br3D7C8h5iHxBr+WoSfiMyBQnrYN8g7Uw@mail.gmail.com> <CAOQ4uxi0P+drqY2krEZ6tGzD1ZZfCcM_Eg6xjYF_vf39tPgbKg@mail.gmail.com>
In-Reply-To: <CAOQ4uxi0P+drqY2krEZ6tGzD1ZZfCcM_Eg6xjYF_vf39tPgbKg@mail.gmail.com>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Tue, 19 Sep 2023 15:41:26 +0200
Message-ID: <CAKPOu+8_mQmhEp_ugPTTwqpXsvQ0Wyv9Ube9RoApPBiCGR0+-g@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 3:22=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
> Yes, I meant it is possible to get the very similar functionality in
> a race-free way using fanotify.

That's not the same. We already agreed that fanotify still misses
features that have been available in inotify since forever. Going
fanotify requires a rewrite of large chunks of code. Rejecting trivial
inotify improvements because people should be using fanotify doesn't
make real-world users happy.

> If fanotify does not meet your requirements please let us know
> in what way and perhaps fanotify could be improved.

- return a watch descriptor (like inotify) as a fixed-size lookup key
- add an option so returned events contain the watch descriptor and
path relative to it (like inotify), not just the directory entry name
- allow unprivileged processes to use this new option instead of FAN_REPORT=
_FID

Supporting this simplified API still makes fanotify harder to use than
inotify, but retains fanotify's full power while minimizing its API
churn for the 99% of users who were already happy with inotify's
feature set.

> > - there are many precedents of new system calls just to add dfd
> > support (fchmodat, execveat, linkat, mkdirat, ....)
> > - there are also a few new system calls that were added to make the
> > life of a programmer easier even though the same was already possible
> > with existing system calls (close_range, process_madvise, pidfd_getfd,
> > mount_setattr, ...)
>
> All those new syscalls add new functionality/security/performance.

So does inotify_add_watch_at().

On the other hand, fanotify reduces performance by adding complexity
and overhead - more system calls necessary, increased lookup overhead
due to variable-length keys instead of 32-bit integers.

> If you think they were added to make the life of the programmer easier
> you did not understand them.

Oh please. Don't be so arrogant.
