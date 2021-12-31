Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09644825E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Dec 2021 22:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhLaVSb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Dec 2021 16:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhLaVSb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Dec 2021 16:18:31 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB799C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Dec 2021 13:18:30 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id f5so112221791edq.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Dec 2021 13:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DyekG4kFjnr+PJmkJt2my9Q9IwijxrDikfprPRjgUB0=;
        b=I5RBhHI6Fk4znjKVzEGRQq7L/KIfGQBjt1zOGbjgwZJCRL/LGtR6UgIe0z3Fc9FipS
         fcId7ZLwJ++9KoZ7D84Kj1l7M5k/OMtDUiz1hpNTc+6N9jrL4yxMpBk7Ib4WUdM/mtMD
         jVoOLnqLDEyPuenZk2xfAkKtwiZz0SHDpR7Eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DyekG4kFjnr+PJmkJt2my9Q9IwijxrDikfprPRjgUB0=;
        b=6C8fuCwqDreRvmFCE/4nCin3WIX6jo4K2FiEeaUby/gawHyAnNz5iz2Wtu6fZ4O0ML
         KEObIS0KCysQ8EAtzS4UoUwfRpJjbLcfXafr0GPVlyU0K7ovs31KRWLyxmtGBtdKUy4Q
         cuSDNOJGBoE5U8C1BDv7FpryOoyNLhCwHLzOSayIVMDS9wLbZ3sx/uXndO1M9TgaEkPu
         NoqWElRyuByP/M4w+lh3LYMu4EdcGCtpFb7JdNzFF+HNNpMKZSf6M8byKVGX7gXPjUmK
         ZcUs69LgAxZTVPtM6mwJLJJdDTJ6oJ7bmwHIq+GWashqQJEXNTfD61UTLg8K2/8JcpM7
         bHRg==
X-Gm-Message-State: AOAM533Rg8gGGvv/D4uTkojLMmubZRnMWzb6pc5BIibatcKC1QAMqKcY
        KO9LGu2LPjbEIkzzraYg34ta75tjvR/WkAM1qQo=
X-Google-Smtp-Source: ABdhPJwq4k149qx5iJ67/55IcL1uXr1RQgiH8k2su7XEUjqv9oiA6K4W1cwGONw7j/BxeRo0K2TOTw==
X-Received: by 2002:a50:ff10:: with SMTP id a16mr35470923edu.275.1640985509251;
        Fri, 31 Dec 2021 13:18:29 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id n14sm2248773edx.62.2021.12.31.13.18.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Dec 2021 13:18:28 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id v11so57747531wrw.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Dec 2021 13:18:28 -0800 (PST)
X-Received: by 2002:adf:f54e:: with SMTP id j14mr29913691wrp.442.1640985507933;
 Fri, 31 Dec 2021 13:18:27 -0800 (PST)
MIME-Version: 1.0
References: <20211202150614.22440-1-mgorman@techsingularity.net>
 <caf247ab-f6fe-a3b9-c4b5-7ce17d1d5e43@leemhuis.info> <20211229154553.09dd5bb657bc19d45c3de8dd@linux-foundation.org>
 <5c9d7c6b-05cd-4d17-b941-a93d90197cd3@leemhuis.info> <CAHk-=wi3z_aFJ7kkJb+GDLzUMAzxYMRpVzuMRh5QFaFJnhGydA@mail.gmail.com>
 <CAHk-=whj9ZWJ2Fmv2vY-NAB_nR-KgpzpRx6Oxs=ayyTEN7E8zw@mail.gmail.com> <20211231130427.2239793015906a1c1ede44a4@linux-foundation.org>
In-Reply-To: <20211231130427.2239793015906a1c1ede44a4@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 31 Dec 2021 13:18:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjvmT-Gx875NvvZfZau+7Vx5h9VhBwdoLnw_Et_HyKfWg@mail.gmail.com>
Message-ID: <CAHk-=wjvmT-Gx875NvvZfZau+7Vx5h9VhBwdoLnw_Et_HyKfWg@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mark Brown <broonie@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Avramov <hakavlad@inbox.lv>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Darrick Wong <djwong@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 31, 2021 at 1:04 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> Needs this fixup, which I shall tweak a bit then send formally
> in a few minutes.

Thanks, applied.

           Linus
