Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696AC532C20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 16:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbiEXOWl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 10:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238036AbiEXOWj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 10:22:39 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5162606CF
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 May 2022 07:22:36 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id i40so23292890eda.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 May 2022 07:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dpp6s5Zi/XJNt6DJKKuRultWYl0hGR26KOE7MDNzls8=;
        b=q2PjA/mFw5U9/q0PkfQSizJWNDtWdEMi7NOpm376PeBzer03NUq9Ds3dpxh2DFqT4m
         cHThbPjm7gxF4WtvK08ERO48+BNoBoeWngyiWyqHrLLUAWpd0s2hLmxB75565Jjci9yo
         pV3BqYaioSKvYGF8aOaSu2nSUfI4OcWmNwDPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dpp6s5Zi/XJNt6DJKKuRultWYl0hGR26KOE7MDNzls8=;
        b=KBcwquLlFD4FGWdNHMlj+4gvjHOyLg8kAMaNux5VHho170JRaUuX1d/9G2eaI+RCBe
         k/8QJyfGYpYnVFqV/RiYdRhLipNcirvdiZpkY9OS/eAtL4//XIQiUwvp8f6x2tIC7hUg
         Oy/IQAiorh8qHmnhpbAC68zGQJX9/7UDOf5U7hxF+G8wUCyiZKx3aIg1vwNIuDquriSu
         euTs6WgrAc4Lp9XyZ7FiDcCH2VZbW/JKSzpELwu/7S75R1aIuLJoQmoQZbDfNpiZd2dU
         ZAWIaoYSiI5LHRINmzxqLswW4yX9oGKQ/tLxhsXuZMavKVgO9lpj+G52hEPOFqbXaGWm
         DKXQ==
X-Gm-Message-State: AOAM532NIOxz7iR84Obay5UT1DwwGkKadNO95k0gILk4n8Ax4fEoUeTq
        mcJ6QfCdEPwXDQr9yopebSOO1dsry3IhvRnN/MRlIg==
X-Google-Smtp-Source: ABdhPJzmdWWQRoST5Zc2QmtMYgiZBOR2l1Rgxy+KY0u/Hl4Ouf/YXrXvsQ+f/S6AA/W+ECg1YFMiih3ynm7WdjZmGcg=
X-Received: by 2002:aa7:cdd2:0:b0:42b:aeb2:bc99 with SMTP id
 h18-20020aa7cdd2000000b0042baeb2bc99mr526437edw.382.1653402155432; Tue, 24
 May 2022 07:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220511222910.635307-1-dlunev@chromium.org> <20220512082832.v2.2.I692165059274c30b59bed56940b54a573ccb46e4@changeid>
 <YoQfls6hFcP3kCaH@zeniv-ca.linux.org.uk> <YoQihi4OMjJj2Mj0@zeniv-ca.linux.org.uk>
 <CAJfpegtQUP045X5N8ib1rUTKzSj-giih0eL=jC5-MP7aVgyN_g@mail.gmail.com>
 <CAONX=-do9yvxW2gTak0WGbFVPiLbkM2xH5LReMZkvC-upOUVxg@mail.gmail.com> <CAONX=-ehh=uGYAi++oV_uS23mp2yZcrUC+7U5H0rRz8q0h6OeQ@mail.gmail.com>
In-Reply-To: <CAONX=-ehh=uGYAi++oV_uS23mp2yZcrUC+7U5H0rRz8q0h6OeQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 24 May 2022 16:22:24 +0200
Message-ID: <CAJfpegsPjFMCG-WHbvREZXzHPUd1R2Qa83maiTJbWSua9Kz=hg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] FUSE: Retire superblock on force unmount
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 23 May 2022 at 02:25, Daniil Lunev <dlunev@chromium.org> wrote:
>
> So, I tried this patchset with open bdi elements during force unmount
> and a random file open [1], and didn't see any major drama with
> force unmounting the node, after re-mounting, read on sysfs node
> returned "no such device", which is expected.
> With private bdi flag patch, unless bdi is unregister on force unmount
> in fuse, it will complain on name collision [2] (because the patch
> actually doesn't do much but unregisters the bdi on unmount, which
> seems to happen ok even if node is busy).

Calling bdi_unregister() might be okay, and that should fix this.  I'm
not familiar enough with that part to say for sure.

But freeing sb->s_bdi while the superblock is active looks problematic.

Thanks,
Miklos
