Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67532B68A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 16:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgKQPYp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 10:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728606AbgKQPYp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:24:45 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95207C0613CF;
        Tue, 17 Nov 2020 07:24:45 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id r12so21526675iot.4;
        Tue, 17 Nov 2020 07:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J5hhP1Qz4OqnuXkQImzekUc7rxgR4/7wJfcySJ5XKyk=;
        b=opCZJVOjmHtEDKDRq5CMDJEdEMjCvJ9PBBDeF8LhyLJA9/IaUdQVy8awoZUvg0sd5M
         BhpA50tQYfHT1K1hTwEthRtxFgmr3trj00ecZUwVvIAD9B/LYzk4VbAa+qbORBacIv21
         la12NqT/z3RQIS5XFdpBkuCU4nUani2zeXAC8Rkz8gUUWWtvZS9OuCEGZFf4rghz+WZV
         RUgcRZlullgcDqwIJmZAzxocNEewmTtsv8bihfZcp7E65BAV47HGW52UTLWSKNmwzDDg
         yPHAvHfhfOGjo8vJIjmyB5QN2Zswzz66VuiFJtm9CGCwkDP29Ae7CNdKSA5D7lTkKhRB
         9UTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J5hhP1Qz4OqnuXkQImzekUc7rxgR4/7wJfcySJ5XKyk=;
        b=SfM5iVL0f8E4xB6vUIPF+c96OtpSkjqj6azaMsBs+vIb6J35rf8i6tbfIHJS0CyadQ
         n5U9j8zv/PLIVeBynkeCV+6wXnbDkx71PI1ckCSjJJO/QyFKBL1kyr7jbOtEUkJfmKet
         SjWkuHuDTVZ6eaJCcpp3eA0IZ8OoVEF3qbwdC513nvlxy0LeuTa69QkS7X3G6rgZdyi4
         woNIOcZ7JBtBvwrhrn1yrQGrTGhXabjT+4IYIofcsjtBtEyQ0TqwvXTMKSJ7TV0qVTdK
         4u2NGDSyw1G2MCc1SrChammaGjDGzLrYYytdThRdUH/gZT1ik6mAQ2S+bE0p6uUiy4YN
         8VeQ==
X-Gm-Message-State: AOAM533gYbcVERdyhCqmjOZF9wYWWLyBau/YsTydtaLl3IrX9fieXhVf
        p+B4mO+kgNgKpB6qW8t2p8PyHTTXYyYc/mcLXok=
X-Google-Smtp-Source: ABdhPJyBD4DSKNz3tDbg1HK7GJz+jBiIBdB5wj8jkHQVzl7Cqha5MUfRLAA4mEIhDqaW+tGdtHC1OhY1FCYJMtpvgEI=
X-Received: by 2002:a6b:5809:: with SMTP id m9mr11850583iob.186.1605626684997;
 Tue, 17 Nov 2020 07:24:44 -0800 (PST)
MIME-Version: 1.0
References: <20201116045758.21774-1-sargun@sargun.me> <20201116045758.21774-4-sargun@sargun.me>
 <20201116144240.GA9190@redhat.com> <CAOQ4uxgMmxhT1fef9OtivDjxx7FYNpm7Y=o_C-zx5F+Do3kQSA@mail.gmail.com>
 <20201116163615.GA17680@redhat.com> <CAOQ4uxgTXHR3J6HueS_TO5La890bCfsWUeMXKgGnvUth26h29Q@mail.gmail.com>
 <20201116210950.GD9190@redhat.com> <CAOQ4uxhkRauEM46nbhZuGdJmP8UGQpe+fw_FtXy+S4eaR4uxTA@mail.gmail.com>
 <20201117144857.GA78221@redhat.com>
In-Reply-To: <20201117144857.GA78221@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 17 Nov 2020 17:24:33 +0200
Message-ID: <CAOQ4uxg1ZNSid58LLsGC2tJLk_fpJfu13oOzCz5ScEi6y_4Nnw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] overlay: Add the ability to remount volatile
 directories when safe
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chengguang Xu <cgxu519@mykernel.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > I guess if we change fsync and syncfs to do nothing but return
> > error if any writeback error happened since mount we will be ok?
>
> I guess that will not be sufficient. Because overlay fsync/syncfs can
> only retrun any error which has happened so far. It is still possible
> that error happens right after this fsync call and application still
> reads back old/corrupted data.
>
> So this proposal reduces the race window but does not completely
> eliminate it.
>

That's true.

> We probably will have to sync upper/ and if there are no errors reported,
> then it should be ok to consume data back.
>
> This leads back to same issue of doing fsync/sync which we are trying
> to avoid with volatile containers. So we have two options.
>
> A. Build volatile containers should sync upper and then pack upper/ into
>   an image. if final sync returns error, throw away the container and
>   rebuild image. This will avoid intermediate fsync calls but does not
>   eliminate final syncfs requirement on upper. Now one can either choose
>   to do syncfs on upper/ or implement a more optimized syncfs through
>   overlay so that selctives dirty inodes are synced instead.
>
> B. Alternatively, live dangerously and know that it is possible that
>   writeback error happens and you read back corrupted data.
>

C. "shutdown" the filesystem if writeback errors happened and return
     EIO from any read, like some blockdev filesystems will do in face
     of metadata write errors

I happen to have a branch ready for that ;-)
https://github.com/amir73il/linux/commits/ovl-shutdown

Thanks,
Amir.
