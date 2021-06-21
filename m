Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F49C3AE4F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 10:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhFUIfQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 04:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhFUIfJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:35:09 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD30C061756
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 01:32:54 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id v17so6030464uar.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 01:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AyR5BeTCOPiEzhLXOoP4zgcKDESexLdcdJu4pl65SiY=;
        b=Ts+cw78rGUGx1mzVOd0XZDx4w2BACVKVIHtmARCSf+GwfAQYzOr67ryufCc/Wx3cTt
         +FIa+a6iv+cUndApmhERphBKGwytNCLYq9lnfxZxOXH6ah55qdzGVO+70isk8YZhVMoA
         tNuHswn3UnHCUuKROkp8QWeCmBojXCkhgrb8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AyR5BeTCOPiEzhLXOoP4zgcKDESexLdcdJu4pl65SiY=;
        b=YqC0HbeSXS8EGKtjPYy7iY/PKY/y0BxNqbKEqD+TJb+TCq7lTCrEovrwg6YudwAkKO
         BkRClT7LSXgZEIIQ4DRayE9qhftlrXPbLm3kvTYwlh5QWrUDFM1DFCdlt0aCHflfbiNu
         snhW2OlUMTgJPpE1VYu3Xxf2x8Rw3ImuZCvZOEIUQ2C+qjrosBHByRk6pQ4Uitt72MKx
         gEOM4mfQzXN6tSzQuguaazlbYa0dpkqc6Q5Zscco15YnS5msw4sss89QgKWporo1w0JX
         zir4hHSq2Fjsn8K4O5GIK9EYIEVHIksqmVgKygJ1mcIvlvc/5weH3FaeuMHZ/5aCrg8Z
         vJVA==
X-Gm-Message-State: AOAM5325vTz5fUQFY3R8OAA2JBTolb4Pm2t5H1OaMtydtELxM/vyVSxk
        PpYDQw18fDczG4eksDEYipDWBMaVys8VTcF2Fpx/lmvRqR4axQ==
X-Google-Smtp-Source: ABdhPJyUn9WwHIOZk5yzmppXQ1vDz67GiVGVK8+LZL/EAAcUso75naYtNYNXQIxJbyU4gawA34Q+mmSYUHrwMXsACnA=
X-Received: by 2002:ab0:6998:: with SMTP id t24mr21315544uaq.72.1624264373720;
 Mon, 21 Jun 2021 01:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <1621928447-456653-1-git-send-email-wubo40@huawei.com>
In-Reply-To: <1621928447-456653-1-git-send-email-wubo40@huawei.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 21 Jun 2021 10:32:43 +0200
Message-ID: <CAJfpegtyxmjD9gobfwD6aYwg718MM6dz2JpFtu20aNRU-ChHjA@mail.gmail.com>
Subject: Re: [PATCH] fuse: use DIV_ROUND_UP helper macro for calculations
To:     Wu Bo <wubo40@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linfeilong <linfeilong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 25 May 2021 at 09:15, Wu Bo <wubo40@huawei.com> wrote:
>
> From: Wu Bo <wubo40@huawei.com>
>
> Replace open coded divisor calculations with the DIV_ROUND_UP kernel
> macro for better readability.

Applied, thanks.

Miklos
