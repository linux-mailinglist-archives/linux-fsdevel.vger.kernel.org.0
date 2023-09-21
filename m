Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D867AA089
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 22:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjIUUkU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 16:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjIUUj1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:39:27 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486F978BF5
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 10:34:12 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401da71b85eso13369995e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 10:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1695317650; x=1695922450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qQQapFoNr4JxAL86fFxZDahpXVJh96z3AbFFmy4/9SU=;
        b=Rqj+dIikb/lA1cJ4qTPsMqMLIjvVMRIYJRLaPh1djO1F70URyh1gjeOvgi61j+J7Tr
         EwYlmmb37iDYGz4bNx/LszKxjhxoA4lxXGwilkeT8//d1l4i3bvZel8778cQUtDQhxn/
         NCYQQKk0o784xMKIPjdwD+jEsvrTeu62CUjH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317650; x=1695922450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQQapFoNr4JxAL86fFxZDahpXVJh96z3AbFFmy4/9SU=;
        b=EBb0j9zpw64g2t26OrpfPA7WwBb6TOhjgrYJx5/mf/U8EC63QcvNPiOZHYbM0B73DJ
         Pce7hUgD+rWw2VcM4v8PpbBLwmxXB1MPrFqL43SbxNFCzfXr7t5k/mb7Fek3Z7NJ0EXN
         sDtGLbf1tACAPopc7XgcVAYQRRUeJCr4hLGXXuHsx4JjqAIVvQW6AfA08Y15qNx5MQhL
         6ucYN8ZXUxb1dmW/XjPKOD3UNQ415HbqBpB73y4BW0aXOtZg3a+pg14HbZ3hX4coSaBm
         6qpLbyeUdN2Ol6Q5IEIe3JaV30hO7BhLDUdhQ3jDpejf1IyLqtHY8W6xzGSmUJaNWQDs
         Zp+w==
X-Gm-Message-State: AOJu0Yypsvf5Dd+GYh3N5ofJeq5vvGcxgQEDpruFWdvc9pa1glYfUb/z
        IZLEObYQLpXTE7qovqkYN6fuxgyX01p4ThxVVCYCgeF9qZwSeebwWzI=
X-Google-Smtp-Source: AGHT+IHTwwB6Pv81ZSilcG/iM0cFX7+qvuikUnVIu100I8jFlzJmiCY285KN37eLW1zRAp2u8Os76A1TxNfLnz4E69c=
X-Received: by 2002:a2e:95c9:0:b0:2b6:a08d:e142 with SMTP id
 y9-20020a2e95c9000000b002b6a08de142mr4064260ljh.7.1695297046501; Thu, 21 Sep
 2023 04:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <CAOQ4uxibuwUwaLaJNKSifLHBm9G-Tgn67k_TKWKcN1+A4Rw-zg@mail.gmail.com>
 <CAJfpegucD6S=yUTzpQGsR6C3E64ve+bgG_4TGP7Y+0NicqyQ_g@mail.gmail.com>
 <CAOQ4uxjGWHnwd5fcp8VwHk59q=BftAhw0uYbdR-KmJCq3fpnDg@mail.gmail.com>
 <CAJfpegu2+aMaEmUCjem7em0om8ZWr0ENfvihxXMkSsoV-vLKrw@mail.gmail.com>
 <CAOQ4uxgySnycfgqgNkZ83h5U4k-m4GF2bPvqgfFuWzerf2gHRQ@mail.gmail.com>
 <CAOQ4uxi_Kv+KLbDyT3GXbaPHySbyu6fqMaWGvmwqUbXDSQbOPA@mail.gmail.com>
 <CAJfpegvRBj8tRQnnQ-1doKctqM796xTv+S4C7Z-tcCSpibMAGw@mail.gmail.com>
 <CAOQ4uxjBA81pU_4H3t24zsC1uFCTx6SaGSWvcC5LOetmWNQ8yA@mail.gmail.com>
 <CAJfpegs1DB5qwobtTky2mtyCiFdhO_Au0cJVbkHQ4cjk_+B9=A@mail.gmail.com>
 <CAOQ4uxgpLvATavet1pYAV7e1DfaqEXnO4pfgqx37FY4-j0+Zzg@mail.gmail.com>
 <CAJfpegvS_KPprPCDCQ-HyWfaVoM7M2ioJivrKYNqy0P0GbZ1ww@mail.gmail.com> <CAOQ4uxhkcZ8Qf+n1Jr0R8_iGoi2Wj1-ZTQ4SNooryXzxxV_naw@mail.gmail.com>
In-Reply-To: <CAOQ4uxhkcZ8Qf+n1Jr0R8_iGoi2Wj1-ZTQ4SNooryXzxxV_naw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 21 Sep 2023 13:50:34 +0200
Message-ID: <CAJfpegstwnUSCX1vf2VsRqE_UqHuBegDnYmqt5LmXdR5CNLAVg@mail.gmail.com>
Subject: Re: [PATCH v13 00/10] fuse: Add support for passthrough read/write
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 21 Sept 2023 at 12:31, Amir Goldstein <amir73il@gmail.com> wrote:

> Ok. Two follow up design questions.
>
> I used this in/out struct for both open/close ioctls,
> because I needed the flags for different modes:
>
> struct fuse_backing_map {
>        int32_t         fd;
>        uint32_t        flags;
>        uint32_t        backing_id;
>        uint32_t        padding;
> };
>
> I prefer to leave it like that (with flags=0) for future extensions
> over the ioctl that inputs fd and outputs backing_id.
> I hope you are ok with this.

I'd prefer if backing_id was just a return value for open.  Taking a
struct as input is okay, and possibly it should have some amount of
reserved space for future extensions.

As for close, I don't see why we'd need anything else than the backing ID...

>
> The second thing is mmap passthrough.
>
> I noticed that the current mmap passthough patch
> uses the backing file as is, which is fine for io and does
> pass the tests, but the path of that file is not a "fake path".
>
> So either FUSE mmap passthrough needs to allocate
> a backing file with "fake path"

Drat.

> OR if it is not important, than maybe it is not important for
> overlayfs either?

We took great pains to make sure that /proc/self/maps, etc display the
correct overlayfs path.  I don't see why FUSE should be different.

Thanks,
Miklos
