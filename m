Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A667A65ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 15:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjISN5H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 09:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjISN46 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:56:58 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58132E5B
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 06:56:17 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-493542a25dfso2241442e0c.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 06:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695131776; x=1695736576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MNQwxi6DJ3zZX3TBoZDjWkTpIQgjX+Dsg51D3yyuTJE=;
        b=KpD9IMzU/M6cstT/twrtXFEaY2F6KAv+DbBrZHxhVwkUIQqB5aNgr/bAWxVkEzQkJ2
         VBOPW6m21Yx/9AXsOlpBM677TwiGQut2ec6XA3eU9xoazo56t/tlNn5lPdQ9gg7bZuhO
         qRc2mqBzQgWSfmW7HkRWLT9MoE0o6/IzHYCuVUrpnwGnXsQXH0IQvA4RTGkkDzIVGO31
         DD2XPtCmL+VFvAu5HFU3pKjfBRz+UGAfIPLnAA9AbBL5vOxhzEUTWwwSvgpya9jHp1fk
         kxxlK/vcecfdnAViYkEPaeHUJap5SmFwcHeZzyqPV15uWkCuz5T0PgDSpvGnerj2JAWG
         M5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695131776; x=1695736576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MNQwxi6DJ3zZX3TBoZDjWkTpIQgjX+Dsg51D3yyuTJE=;
        b=oDEo4ICvHwI4RkA9Iyhn+hp85Mg4oeUpXYDLH3HHYHRV9sE2AAdB3s0zU2d4eKwm/L
         +7pmSoSNDRNMRap9pRe24oqN8r9GA9KrenV5ew4Xhp8CDQbICeIMmgpXA2wnh3PC5fdc
         q9qmUKAh0DQeo+HAmEGvrkRfObB3M+ZRmL8OshLPFE8P96PnxqhJnk4VNqGQnE6uv6ZH
         NT6OEWf6Xcu5RVkGF2JgKWd6GZ7mo2VuoIXmhvQNgG5AJbxKfyoXeuAFj9mNbDtKeKgY
         ee7IkdBpyRBIjeOYexlgzpnu4+VzY1gjiM0D2V9PRrEKw/twiP56KuzIqP87FgZsHs+n
         /9Pw==
X-Gm-Message-State: AOJu0YxHY0IvLeqUNnhKIdXpkZm68zM0ZPmyUzq9XC5BDMi6jv/v1FAl
        DeGOFtbCoMJb3wpfjb+K8RdeKyCc0okJfcKugmJYDRFM6mI=
X-Google-Smtp-Source: AGHT+IHH5juEDV7UmJmOY7JR0aFX+x/iK1aLNtpFf9FJTBVTegeMHoUekiVNClMs19sH9aSQl7HG4DpUZ3DRDkclFak=
X-Received: by 2002:a1f:62c1:0:b0:487:d56f:fc82 with SMTP id
 w184-20020a1f62c1000000b00487d56ffc82mr9444917vkb.6.1695131776340; Tue, 19
 Sep 2023 06:56:16 -0700 (PDT)
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
 <CAKPOu+8tCP+bRXFy0br3D7C8h5iHxBr+WoSfiMyBQnrYN8g7Uw@mail.gmail.com>
 <CAOQ4uxi0P+drqY2krEZ6tGzD1ZZfCcM_Eg6xjYF_vf39tPgbKg@mail.gmail.com> <CAKPOu+8_mQmhEp_ugPTTwqpXsvQ0Wyv9Ube9RoApPBiCGR0+-g@mail.gmail.com>
In-Reply-To: <CAKPOu+8_mQmhEp_ugPTTwqpXsvQ0Wyv9Ube9RoApPBiCGR0+-g@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 19 Sep 2023 16:56:05 +0300
Message-ID: <CAOQ4uxhchdC2UY0_Q=p=URiykDPdSijObXf+zj5dAVymc3nE4g@mail.gmail.com>
Subject: Re: inotify maintenance status
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Ivan Babrou <ivan@cloudflare.com>,
        Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > - there are many precedents of new system calls just to add dfd
> > > support (fchmodat, execveat, linkat, mkdirat, ....)
> > > - there are also a few new system calls that were added to make the
> > > life of a programmer easier even though the same was already possible
> > > with existing system calls (close_range, process_madvise, pidfd_getfd,
> > > mount_setattr, ...)
> >
> > All those new syscalls add new functionality/security/performance.
>
> So does inotify_add_watch_at().
>
> On the other hand, fanotify reduces performance by adding complexity
> and overhead - more system calls necessary, increased lookup overhead
> due to variable-length keys instead of 32-bit integers.
>

Technical arguments of performance need to be backed up by
performance numbers from real life workloads.
I am not inventing this stuff as I go.
This is how kernel development works.

> > If you think they were added to make the life of the programmer easier
> > you did not understand them.
>
> Oh please. Don't be so arrogant.

I will try. Please try as well to accept a different POV.

Thanks,
Amir.
