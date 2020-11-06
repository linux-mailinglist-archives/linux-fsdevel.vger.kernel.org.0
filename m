Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9576A2AA174
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Nov 2020 00:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgKFXfo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 18:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbgKFXfo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 18:35:44 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715DAC0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2020 15:35:43 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id i6so4257239lfd.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2020 15:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eMoRYBx4DAMN87q/Qxn/vkeSV0JGOokfdGoi2qdQtlk=;
        b=VQ+L+ATYA/FZIZUCETHW1K7D8w79F/MTq60EL9Ec3V4gnL9IJk8F3eb9idwCVvlRrc
         8Ei7CiqYZhn9fJsh+UeL/UiWhSlZBoGexP7WNISG75CFbsrLzos5TPu5Mh5YQxnnOPjp
         G1doOAZS+cP9vHOV84ZoEALRhSaqHK+v2uXvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eMoRYBx4DAMN87q/Qxn/vkeSV0JGOokfdGoi2qdQtlk=;
        b=cFMPYl79DKd8ZAPu83m8k0ZK9CXyUTrMBHbr7Szfbxaekb+Od1BC5F5XJ5/TyqqY8z
         VKuqUFj6jfCS8pBkgtjcpdyzzc+shTgaMncmFomdXBu6exYbtQLIZE83ipmGYO8Fdodl
         LsoQptHxPvkk5FpxkSW1U+D6U393ex73OhjTOh2XKTdRZkaDlxKh4DSHjTp2GaWt4oMJ
         lqc2koJYGqNpGYULIfcmAkeMO/8t4LtHNsX1aJjE5yh/bAwMfK2V5ARCZqKdiKu/BxgD
         rluS8JJ6YHmLtzk481ikpG6ytVf6bu6ASA34nUgonD1ntbmRi7TXrIMzZAgHThrl1RG1
         W/BQ==
X-Gm-Message-State: AOAM530mZ+3175VR/mvXcfzOEJG0Tk2++umqlyKkq9DDOVbsnR2GLlb8
        hzOgIdA7Yffh9SiU3/BVIjWqvlTf012qbQ==
X-Google-Smtp-Source: ABdhPJwuwGiTYHTD3usHvytCWIsJ8MnThpRzM43uPDxsY0Edu5YpOUiAHTbmTQ6HKmlEmAH2XT/7Xg==
X-Received: by 2002:ac2:5f93:: with SMTP id r19mr388603lfe.166.1604705741437;
        Fri, 06 Nov 2020 15:35:41 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id q1sm313740lfj.306.2020.11.06.15.35.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 15:35:39 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id 74so4242871lfo.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2020 15:35:38 -0800 (PST)
X-Received: by 2002:a19:4815:: with SMTP id v21mr1885811lfa.603.1604705738619;
 Fri, 06 Nov 2020 15:35:38 -0800 (PST)
MIME-Version: 1.0
References: <20201106231635.3528496-1-soheil.kdev@gmail.com>
In-Reply-To: <20201106231635.3528496-1-soheil.kdev@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Nov 2020 15:35:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=whM-Cm52o1kBQD4eS3Wx=XWr_z7sq=H88pmyeK_9L0=VQ@mail.gmail.com>
Message-ID: <CAHk-=whM-Cm52o1kBQD4eS3Wx=XWr_z7sq=H88pmyeK_9L0=VQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] simplify ep_poll
To:     Soheil Hassas Yeganeh <soheil.kdev@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        Guantao Liu <guantaol@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 6, 2020 at 3:17 PM Soheil Hassas Yeganeh
<soheil.kdev@gmail.com> wrote:
>
> The first patch in the series is a fix for the epoll race in
> presence of timeouts, so that it can be cleanly backported to all
> affected stable kernels.
>
> The rest of the patch series simplify the ep_poll() implementation.
> Some of these simplifications result in minor performance enhancements
> as well.  We have kept these changes under self tests and internal
> benchmarks for a few days, and there are minor (1-2%) performance
> enhancements as a result.

From just looking at the patches (not the end result - I didn't
actually apply them), it looks sane to me.

             Linus
