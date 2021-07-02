Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FF23BA099
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 14:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhGBMlP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 08:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbhGBMlP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 08:41:15 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E61BC061762
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jul 2021 05:38:43 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id v20so15864748eji.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Jul 2021 05:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TejoEZ6PvhDR6/vKnlCgTBQKFLG9ws1K525Cz+uqRss=;
        b=q+VryZfZlPZSEnfM22oyE1OsMkDXFLAqmpiBkUk4KIQVMvhqdnRnPfoMzd08w9/GVw
         WVBztUsXpOFNtS3JeBQ1ey6GxnWnP2/aR/T2KZiJ6Ja3GW+DkKj+8b1OybetowjhzO0J
         uKFnX1Up/FLl4aaCtxd1XCytVJrI0fxUgWirqajKIN8kaYtQ+S067CIN15z/RoBhT+ha
         gZ2GS1vV/v57wrM2KVO+i6Xmcbe7cZSlY6/Bw4V0zGY8EYHRGroYx5xYGtK+ML7aKzAa
         1sG6DEOCx9j+YIe257IAp8sKsZbIdeEnZQcPG3vy6uWursqKg9xKxON/EXCg6VkePNqv
         QRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TejoEZ6PvhDR6/vKnlCgTBQKFLG9ws1K525Cz+uqRss=;
        b=i3nb20XFBhifowp7OBzXkVT+iZNLre5Bn1avECkvs7K0TBzUOm1nhE0EbAP7HMFdid
         AyKfJU0WcO6o28eB3T09mKF0e/VeUpB1kXhjzj/1as6Eh9Dr5CP9/5afpzl/jMXtbjXP
         ehL34TQ9XmLBRbMDsEXuOSKfXoAW5HESL0ntUggEFXODnNmuVsqqV2Rdm8uo5KgFKREc
         6F5elP5/Y/eOEYRbKCZOP7Ltl0TmK67ZXDMKhpAqdfyLRJOjryY+lk3xRSx8OXwn+LeH
         Rs2ya/vc+HSj5AyuqxHBaM2LkAgQFVzaQiqh+Ume5rqfPPNgFfus/IbUYunbNBqzwCQr
         yTmQ==
X-Gm-Message-State: AOAM532rJ6tYSO6jcgOessVSznx/uLYkLMbMFk9u3QsuNOQpbgzdLeVE
        tT6TDOmVe4d/LOiG6mR5RbMuvwf+VLAIBw8engMKYA==
X-Google-Smtp-Source: ABdhPJy2T5F8l8QmzzJ7o24iwSWZG5I9WgE9TfFMy/4Nq1nG7PIA5FfoGfDfCtgp1rNasiTAHaL+DPKH9xoGnEFyIB0=
X-Received: by 2002:a17:906:25db:: with SMTP id n27mr4989541ejb.170.1625229521558;
 Fri, 02 Jul 2021 05:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuBvh-H8Vqp58j-coXUD8p1A6h2it_aZdRiYcN2soGNdg@mail.gmail.com>
In-Reply-To: <CA+G9fYuBvh-H8Vqp58j-coXUD8p1A6h2it_aZdRiYcN2soGNdg@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 2 Jul 2021 18:08:29 +0530
Message-ID: <CA+G9fYszTVESKbiORBj=bvZX3qco474yYhWDV3ccveScqt41YA@mail.gmail.com>
Subject: Re: [mainline] [arm64] Internal error: Oops - percpu_counter_add_batch
To:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Theodore Tso <tytso@mit.edu>, lkft-triage@lists.linaro.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jens Axboe <axboe@kernel.dk>, Zhang Yi <yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2 Jul 2021 at 13:54, Naresh Kamboju <naresh.kamboju@linaro.org> wro=
te:
>
> Results from Linaro=E2=80=99s test farm.
> Regression found on arm64 on Linux mainline tree.

Regression found on arm64, arm and i386 on Linux mainline tree.
But x86_64 tests PASS.

>
> The following kernel crash was noticed while running LTP fs_fill test cas=
e on
> arm64 devices Linus ' mainline tree (this is not yet tagged / released).
>
> This regression  / crash is easy to reproduce.
>
> fs_fill.c:53: TINFO: Unlinking mntpoint/thread6/file2
> fs_fill.c:87: TPASS: Got 6 ENOSPC runtime 3847ms
> [ 1140.055715] Unable to handle kernel paging request at virtual
> address ffff76a8a6b59000

ref;
https://lore.kernel.org/regressions/CA+G9fYuBvh-H8Vqp58j-coXUD8p1A6h2it_aZd=
RiYcN2soGNdg@mail.gmail.com/T/#u

- Naresh
