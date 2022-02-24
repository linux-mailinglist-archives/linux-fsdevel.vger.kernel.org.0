Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D584C21BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 03:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiBXC3F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 21:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiBXC3E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 21:29:04 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8092325E1;
        Wed, 23 Feb 2022 18:28:35 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id j2so1172240ybu.0;
        Wed, 23 Feb 2022 18:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1jzhpJXBre7yHc86UG5PVCm8y9Mu8t3447N2sB9WANg=;
        b=ToY+jX97i0xupoPH8/daC/7m7PKOfD7autEAGocAXYDPM0bowwaZuAcX1jfdiRN1Jk
         7SOVKzALkgM1o3MjVfCdnA/ZpJ24YjoRtDjF8YPby0lNutBs1TKdzHMuVGCFHt4dc3g4
         z9vRm4HUB6S+mbBTYroDFU+9bfUDI4XOCOBWB2ZSp7UJQZks3l1uFOpDkQ+IiVHZPPOd
         KQd/VB8LR4iu4t8rk5izmBc5tH38ZPzGn0oxNYUcC9pccMjFeufJMZtx8TW6NTEU8s8v
         D92MWEcvLT65xq+kDvZGM0CvzAOE6cGki6kTGKrX/pZwEjr/9Nb0j+iqOr2whpUO4WOx
         1vSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1jzhpJXBre7yHc86UG5PVCm8y9Mu8t3447N2sB9WANg=;
        b=LL9oKRvpvSGJ+5FFT+OXacSKVJaJnOyG9aMpXhX7+cqTPSIspTemZuhADW+kPIov4z
         seVgZrmlpQGP700Lj3WN8R9zxmcZObP3Hrlg5BlZ6Rhb44CJvdAKvw8di+Nku/cRHFlr
         faOw5QRaxFG3oAgnePLZvyupNsI63xbzGsGAcbMJj2TlygdUgNK4x/sBeak5KOlKYQGw
         QkrE5ttm1Msomhm1xGJH5wRW84SA8Wvc2uKNCsuR+1N7YRK6LDu1QZ/MkhAavwAfsz9o
         VDZcdLr7KDp1c/A4CxSWsjxL8teH14ZsH8W0BTso1WxhNSEQjkJNcSmYjTwwUnhfB0WQ
         WCsA==
X-Gm-Message-State: AOAM5305hYGZg9qft/dRuym6MO3f4IcLJLNZdiSxMjfjKXJQSk86hCDa
        PhV3O8rrWlXRrAOVfvkWixPGTSJIrRUfQ9KMias=
X-Google-Smtp-Source: ABdhPJzlU+jtgY+MLg4AYm9dcUHUaxWzNeLoHMwMdFO/neEQ85ZmSiOndCm64y9U5VxFqdzfkdRsxg2ajagao4bgh0U=
X-Received: by 2002:a25:b5c4:0:b0:623:a42e:476b with SMTP id
 d4-20020a25b5c4000000b00623a42e476bmr587997ybg.245.1645669714940; Wed, 23 Feb
 2022 18:28:34 -0800 (PST)
MIME-Version: 1.0
References: <20220223231752.52241-1-ppbuk5246@gmail.com> <YhbCGDzlTWp2OJzI@zeniv-ca.linux.org.uk>
 <CAM7-yPTM6FNuT4vs2EuKAKitTWMTHw_XzKVggxQJzn5hqbBHpw@mail.gmail.com>
 <CAM7-yPSk35UoGmRY_rCo2=RryBvwbQEjeWfL2tz1ADUosCXNjw@mail.gmail.com>
 <878ru1umcu.fsf@email.froward.int.ebiederm.org> <CAM7-yPTPZXPxhtwvvH6KqpRng2idxZiNCLsJHXbWM4ge1wqsBQ@mail.gmail.com>
 <87h78pknm1.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87h78pknm1.fsf@email.froward.int.ebiederm.org>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Thu, 24 Feb 2022 11:28:24 +0900
Message-ID: <CAM7-yPSmmfgAAGiK+oQq8JD0Xu9S-Ys-WaBPgM8XU5Jgdm-NjA@mail.gmail.com>
Subject: Re: [PATCH] fs/exec.c: Avoid a race in formats
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 24, 2022 at 11:25 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
> I took a quick look and unregistering in the module exit routine looks
> safe, as set_binfmt takes a module reference, and so prevents the module
> from being unloaded.
>
> If you can find a bug with existing in-kernel code that would be
> interesting.  Otherwise you are making up assumptions that don't current
> match the code and saying the code is bugging with respect to
> assumptions that do not hold.
>
> The code in the kernel is practical not an implementation of some
> abstract that is robust for every possible use case.
>
> Eric

Thanks and sorry for making a noise.
