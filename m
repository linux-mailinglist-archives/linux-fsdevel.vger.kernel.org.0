Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41145B5D66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 17:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiILPkJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 11:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiILPkE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 11:40:04 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0FCDFF9
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 08:40:02 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id c3so9430713vsc.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 08:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=XlzqLyLXUe6mHbWvc3FabcX1MIX0Mp4skHKCaRFezyI=;
        b=o7x4MiynjEH8Nc926x64yzZTJ03EIJ1KZxrqDwS5CMM8Js4EEYnWvDcmcPZ6azU3oL
         /wESVOFM57ROEYu6AP6Hyasx0T2H+qV4oi+1ggGVgQ9m1OlbNth/iS8GAWKBw5ZbRGYz
         zaaMR5GbYLZwbDuWVN+vUSKx4NBSiYv/leWhtXxyRMVq6QTP1jycYvWKHk7sKybvRpnG
         MP1Fmvbd6Mpqj2P9dq29R3ATjZClmQafyh14OUEqeUCrf66mwAS7BRYxj47ZrJei3zBP
         v0CTwc+S29zKP9BxmihFade9i2nEwywzdDRMpHTKVpRx/DbaXUm31NRvk5QQoFjSAJOQ
         IjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=XlzqLyLXUe6mHbWvc3FabcX1MIX0Mp4skHKCaRFezyI=;
        b=Dp8M6m7l2HKCqzzhpX+M5Y5BtWRbct0DiWMtBRq9f2dFuEZnCzorOPZ5UAUxWmrM6V
         ApkKfkNZx4+55kmweFM9alM3qfiYO4knKoqUOmJKhVYvduer3Iaqg7td+rK/+PiNwNz2
         NhLvIrHya+MfWkyGTbBvG3QpMhYG2QGmq16msDsi3gYsPZvIWyCfIcqyDR1KC5tdaZPf
         ijRM+Yxdnmu1bX7ObCkw5K+n7/HGy1RHxwFpH6QC5v5EsiIkcAl2Yiirc8wLE0tM457t
         v9P3t0uC1a3G3Jt+HtE8cajaPXCRA8kk5Uh/rQOf4KTMAJ1A8pCcgkvtFQWQCTg4ZvSB
         QWpg==
X-Gm-Message-State: ACgBeo1GANJHuPuKJE7DYwfF5GN1C3Kd8tuFzUqhejyuHg7JoPXJjpBC
        iErbF5Q7ZwLEvToadIwxrP5Af7E+cVxSj6g8vRc=
X-Google-Smtp-Source: AA6agR4Mnz3dzdmic3+LlJfP2mfUo7uApizZpKPf8ADtP2ktNbvD3IY7iuVtS6JG/Vlu2M9cooQat36cKoSH2L48G/8=
X-Received: by 2002:a67:a649:0:b0:390:88c5:6a91 with SMTP id
 r9-20020a67a649000000b0039088c56a91mr8995107vsh.3.1662997201802; Mon, 12 Sep
 2022 08:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-4-balsini@android.com>
 <CAJfpegs4=NYn9k4F4HvZK3mqLehhxCFKgVxctNGf1f2ed0gfqg@mail.gmail.com>
 <CA+a=Yy5=4SJJoDLOPCYDh-Egk8gTv0JgCU-w-AT+Hxhua3_B2w@mail.gmail.com>
 <CAJfpegtmXegm0FFxs-rs6UhJq4raktiyuzO483wRatj5HKZvYA@mail.gmail.com>
 <YD0evc676pdANlHQ@google.com> <CAOQ4uxjCT+gJVeMsnjyFZ9n6Z0+jZ6V4s_AtyPmHvBd52+zF7Q@mail.gmail.com>
 <CAJfpegsKJ38rmZT=VrOYPOZt4pRdQGjCFtM-TV+TRtcKS5WSDQ@mail.gmail.com>
 <CAOQ4uxg-r3Fy-pmFrA0L2iUbUVcPz6YZMGrAH2LO315aE-6DzA@mail.gmail.com>
 <CAJfpegvbMKadnsBZmEvZpCxeWaMEGDRiDBqEZqaBSXcWyPZnpA@mail.gmail.com>
 <CAOQ4uxgXhVOpF8NgAcJCeW67QMKBOytzMXwy-GjdmS=DGGZ0hA@mail.gmail.com>
 <CAJfpegtTHhjM5f3R4PVegCoyARA0B2VTdbwbwDva2GhBoX9NsA@mail.gmail.com>
 <CAOQ4uxh2OZ_AMp6XRcMy0ZtjkQnBfBZFhH0t-+Pd298uPuSEVw@mail.gmail.com> <CAJfpegt4N2nmCQGmLSBB--NzuSSsO6Z0sue27biQd4aiSwvNFw@mail.gmail.com>
In-Reply-To: <CAJfpegt4N2nmCQGmLSBB--NzuSSsO6Z0sue27biQd4aiSwvNFw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 12 Sep 2022 18:39:50 +0300
Message-ID: <CAOQ4uxjjPOtH9+r=oSV4iVAUvW6s3RBjA9qC73bQN1LhUqjRYQ@mail.gmail.com>
Subject: Re: [PATCH RESEND V12 3/8] fuse: Definitions and ioctl for passthrough
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Alessio Balsini <balsini@android.com>,
        Peng Tao <bergwolf@gmail.com>,
        Akilesh Kailash <akailash@google.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 12, 2022 at 5:22 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, 12 Sept 2022 at 15:26, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > FWIW duplicate page cache exists in passthough FUSE whether
> > passthrough is in kernel or in userspace, but going through yet another
> > "switch" fs would make things even worse.
>
> I imagine the "switch" layer for a HSM would be simple enough:
>
> a) if file exists on fastest layer (upper) then take that
> b) if not then fall back to fuse layer (lower) .
>
> It's almost like a read-only overlayfs (no copy up) except it would be
> read-write and copy-up/down would be performed by the server as
> needed. No page cache duplication for upper, and AFAICS no corner
> cases that overlayfs has, since all layers are consistent (the fuse
> layer would reference the upper if that is currently the up-to-date
> one).

On recent LSF/MM/BPF, BPF developers asked me about using overlayfs
for something that looks like the above - merging of non overlapping layers
without any copy-up/down, but with write to lower.

I gave them the same solution (overlayfs without copy-up)
but I said I didn't know what you would think about this overlayfs mode
and I also pointed them to the eBPF-FUSE developers as another
possible solution to their use case.

>
> readdir would go to the layer which has the complete directory (which
> I guess the lower one must always have, but the upper could also).
>
> I'm probably missing lots of details, though...
>

That's what I said too :)

Does that mean that you are open to seeing patches for
an overlayfs mode that does not copy-up on write to lower?
I can come up with some semantics for readdir that will
make sense.

Thanks,
Amir.
