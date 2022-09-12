Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026C65B5C22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 16:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiILOWv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 10:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiILOWu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:22:50 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E198326F6
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 07:22:49 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 29so13033613edv.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 07:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ZBY/o0YcpTx04NBKo0QawbSu7Ty2gtwY7h0KFr/g/xo=;
        b=bSlyuqgM53SPxchHlQvQYfBCKBeGkNRd6GZOxBh77fJDGcTsvPhFRgXi8m5ykcLSEs
         dVorz1M8siDPDuoz8SeGsRIP3OcSmkFjQ9wnKNt/Rhp/WgmxxJkQ8Wlu4uqfNH/JQBCj
         +NQlh2Tr2JSofOj7FLfDYU2E8/KKPDg2WgbbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ZBY/o0YcpTx04NBKo0QawbSu7Ty2gtwY7h0KFr/g/xo=;
        b=X+jXPK4YSl2BGAsYFcbJ9WzxCm1IKGU90j9WMCqBwrVkVBF6fdJs4dyZklWLKDs5YU
         IYmgWchtiBHp0L7OGQo803Bmg4sPHaE7KtJTAaDSGgEdPUK/MxNIXm/xOm6bnnkdo0hD
         HhtGFBCoXZQFo7frQuI7onbZJ6R6YAA7pbYS+Fit/T6cM7OZX/m+2xbjbST32+b8G34I
         JmA6yiFVcwWojuE9VVHXGuPJ3Ys8T0Ib2aifX+uIdWK2CJ0F5uNn8uEW2zDviNb3brJj
         cSbbLWG80tZGpdLDK1IKCwDQnMwZksN0tL67oSUllcVLazNS2Lis0sM4SS+x/WVUkHsv
         32Bg==
X-Gm-Message-State: ACgBeo2Tcc3uHhwpWrIQCDqyQD2HaZIheM51rMg9WdZj1o63pxvNcQlf
        y/FXX40zBSaoWuAz7cvBVLHyAtNdSKguVpT/CizXWv1geLFp7A==
X-Google-Smtp-Source: AA6agR6xOt32m/158PrGZY5BOXWuyxBZvHImrb95Q8W9FhS4FvmPvRw+ds+CfEkP9hf3xv98sQpwH2zvKkTlmZdE290=
X-Received: by 2002:a05:6402:2289:b0:44e:f490:319a with SMTP id
 cw9-20020a056402228900b0044ef490319amr22699795edb.28.1662992567810; Mon, 12
 Sep 2022 07:22:47 -0700 (PDT)
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
 <CAJfpegtTHhjM5f3R4PVegCoyARA0B2VTdbwbwDva2GhBoX9NsA@mail.gmail.com> <CAOQ4uxh2OZ_AMp6XRcMy0ZtjkQnBfBZFhH0t-+Pd298uPuSEVw@mail.gmail.com>
In-Reply-To: <CAOQ4uxh2OZ_AMp6XRcMy0ZtjkQnBfBZFhH0t-+Pd298uPuSEVw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 12 Sep 2022 16:22:36 +0200
Message-ID: <CAJfpegt4N2nmCQGmLSBB--NzuSSsO6Z0sue27biQd4aiSwvNFw@mail.gmail.com>
Subject: Re: [PATCH RESEND V12 3/8] fuse: Definitions and ioctl for passthrough
To:     Amir Goldstein <amir73il@gmail.com>
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
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 12 Sept 2022 at 15:26, Amir Goldstein <amir73il@gmail.com> wrote:

> FWIW duplicate page cache exists in passthough FUSE whether
> passthrough is in kernel or in userspace, but going through yet another
> "switch" fs would make things even worse.

I imagine the "switch" layer for a HSM would be simple enough:

a) if file exists on fastest layer (upper) then take that
b) if not then fall back to fuse layer (lower) .

It's almost like a read-only overlayfs (no copy up) except it would be
read-write and copy-up/down would be performed by the server as
needed. No page cache duplication for upper, and AFAICS no corner
cases that overlayfs has, since all layers are consistent (the fuse
layer would reference the upper if that is currently the up-to-date
one).

readdir would go to the layer which has the complete directory (which
I guess the lower one must always have, but the upper could also).

I'm probably missing lots of details, though...

Thanks,
Miklos
