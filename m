Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682703BDCAC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jul 2021 20:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhGFSIQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jul 2021 14:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhGFSIQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jul 2021 14:08:16 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14928C061762
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jul 2021 11:05:37 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id p1so4112565lfr.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jul 2021 11:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Em9c4ZPKERgAPy8Qvk6GosFDZCvYA+8F/8hRBjAZ/yU=;
        b=S22eWRM9cqp1ZGHh3bFaL5OIJ3DNjFhPPb/oA3C49rhtA4loRgsaNFmFLXwps/16x3
         JbjIyir5e4U/KiVEOEai0YepGthbexe30ApJeKK6SnyodxfFFpXN8PbB1Q0kAc3Qc8G8
         TsRjiHmCcBRVMgn7VZfln7LDBRApU7IKC/01o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Em9c4ZPKERgAPy8Qvk6GosFDZCvYA+8F/8hRBjAZ/yU=;
        b=GkexOSssR9d/kAC3bEWdlt3EZXrpu/mrYHLbRyhi1Kyvn8qTkfwW+0dbSRE0/9fED9
         oDKSq1djvdZjJ5CtMpbl0nYFTB/Tq+G9Ba1T4MUwhvkEj3CIgVfJDTgI8s1qrz0fml3j
         A3luFtNMLbCS9u1W9ti7GrQktiOulrpdvfsj3Vh6w9sdnxMf7UTymOU538YZtH9OOtpK
         xdJ9+BTCCFXuUzbcEOTqhRWoqalwpnLC6YULSJkdbEtZbi04zKOrH9fJs7gso5Td2zFw
         QonTDTuKmRY2LiBE8likmw3g3LfapdKnV2JZqf5RFKS+T2FQqyuwcQgC8xY+XHXFvaYr
         yrYw==
X-Gm-Message-State: AOAM532/729UHFuxgNn1BP77S3gm02Iptb9ggncvC8qWW4gSNETuvkwh
        LTZJxikJRlhbksabeDdQyIlPdT/phb3YsjdC
X-Google-Smtp-Source: ABdhPJxigkh+rGnlq+pc7iDjVhJOYdvpYc/FoL+5z3T3NZBuPle6NePFKWFkKX/SRg9Ifjo1gKSo6A==
X-Received: by 2002:a05:6512:1303:: with SMTP id x3mr15466688lfu.276.1625594735081;
        Tue, 06 Jul 2021 11:05:35 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id n17sm1466829lft.74.2021.07.06.11.05.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 11:05:34 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id a6so30307342ljq.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jul 2021 11:05:34 -0700 (PDT)
X-Received: by 2002:a2e:50b:: with SMTP id 11mr16701446ljf.220.1625594734000;
 Tue, 06 Jul 2021 11:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210706124901.1360377-1-dkadashev@gmail.com> <20210706124901.1360377-8-dkadashev@gmail.com>
In-Reply-To: <20210706124901.1360377-8-dkadashev@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 6 Jul 2021 11:05:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whdhY-RT=8wky=MgxAo0C9gSODcimLg3brdNy9p6OzhxA@mail.gmail.com>
Message-ID: <CAHk-=whdhY-RT=8wky=MgxAo0C9gSODcimLg3brdNy9p6OzhxA@mail.gmail.com>
Subject: Re: [PATCH v7 07/10] fs: make do_linkat() take struct filename
To:     Dmitry Kadashev <dkadashev@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 6, 2021 at 5:49 AM Dmitry Kadashev <dkadashev@gmail.com> wrote:
>
> Pass in the struct filename pointers instead of the user string, for
> uniformity with do_renameat2, do_unlinkat, do_mknodat, etc.

This is the only one in the series that I still react fairly negatively at.

I still just don't like how filename_lookup() used to be nice and easy
to understand ("always eat the name"), and while those semantics
remain, the new __filename_lookup() has those odd semantics of only
eating it on failure.

And there is exactly _one_ caller of that new __filename_lookup(), and it does

        error = __filename_lookup(olddfd, old, how, &old_path, NULL);
        if (error)
                goto out_putnew;

and I don't even understand why you'd want to eat it on error, because
if if *didn't* eat it on error, it would just do

        error = __filename_lookup(olddfd, old, how, &old_path, NULL);
        if (error)
                goto out_putnames;

and it would be much easier to understand (and the "out_putnew" label
would go away entirely)

What am I missing? You had some reason for not eating the name
unconditionally, but I look at this patch and I just don't see it.

              Linus
