Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE9D37036B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 May 2021 00:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhD3WUz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 18:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhD3WUy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 18:20:54 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31B3C06138B
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 15:20:04 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id z23so33889lji.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 15:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LPHXuFLy5stLpGwQaeIuIJPobdMaEnCqfseYzg/gd2Y=;
        b=CocY4j7++UJ3Tc8jJmqROkOnzc8H9GEFjGGcDlbZNXrn4v38F9dgTWsMHGhZynPK76
         npc+QlQdePfy2Mzi3UYBTefVTgTCaLxr5YqshopI64WjF2MnPwTs9nH2p8i+0HCbUwBx
         2bVS4qj4KPhfsKsMVy+FfBkC1jGCVOP2yxCug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LPHXuFLy5stLpGwQaeIuIJPobdMaEnCqfseYzg/gd2Y=;
        b=Q0ISGkxjR7VnBJoM/+6WKrGyWOFTA4HH8G7NXkblrcWq8ZE4JNTgixZl+o1oVbPWHp
         o6nWfryA/6H+hwlZvkVmioJkHzoUPIeMfrGsiwXfOHrXEzyyhDieBY7D5Oiql2gPrA4G
         Kx4mRncyxlIlImxnb7HiL+Nz1fFDsHPDpN8LlAYwf9Ub2x1rE35tk53Doiy1T9kFZuPk
         uc7BHiz6D8IDZrw3PD9Py7LU/sU1u2y+NDh68LYomDRdzFVgFNIyjYU4DDA29N4pIZPE
         9WU/qKeXVexqyqtTmSkaDIkb1RzmPt2DI7tpqgiVitTAKBdlJ8wOYvE32mG6lf3DK+MT
         /0pA==
X-Gm-Message-State: AOAM532oMvfz25ySveZr2SVed8bGcQJfDpxQBKpGsbc0EJrP4MJtptCC
        FgtpPBq+TviVtpF9HAn6NxUd8HqZ+asncCM6
X-Google-Smtp-Source: ABdhPJxOX5e9sE142K+3Ilz4tYv17xGPSPwUAipjw40PNzapcDzfLjgbiPq4niIvCFcXirrX7D04vw==
X-Received: by 2002:a2e:8054:: with SMTP id p20mr5107641ljg.439.1619821203345;
        Fri, 30 Apr 2021 15:20:03 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id z36sm397890lfu.125.2021.04.30.15.20.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 15:20:02 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2so19624548lft.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 15:20:02 -0700 (PDT)
X-Received: by 2002:a19:c30b:: with SMTP id t11mr4728228lff.421.1619821202593;
 Fri, 30 Apr 2021 15:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <YIwYirYCIdcVUjk6@miu.piliscsaba.redhat.com>
In-Reply-To: <YIwYirYCIdcVUjk6@miu.piliscsaba.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Apr 2021 15:19:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+RrxDNLJJoANx02QEBYYBfJbHRjRV1FD+di6x+tTiNw@mail.gmail.com>
Message-ID: <CAHk-=wh+RrxDNLJJoANx02QEBYYBfJbHRjRV1FD+di6x+tTiNw@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs update for 5.13
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 30, 2021 at 7:47 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> - Miscallenous improvements and cleanups.

Life hack: everybody misspells 'miscellaneous', which is why we have
the very special kernel rule that we always shorten that word to
"misc".

Problem avoided ;)

              Linus
