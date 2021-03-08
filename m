Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281D7330871
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 07:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbhCHGvW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 01:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbhCHGvC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 01:51:02 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7F5C06175F
        for <linux-fsdevel@vger.kernel.org>; Sun,  7 Mar 2021 22:51:01 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id v9so19337542lfa.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Mar 2021 22:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XEEJ+NdSVotCeqOa+J0COpT2uyZAFkgzUKOtpl6kuio=;
        b=F9c7bLbzgQ+8AYmdfA1AkrCB6L1QzKFDLjf4b4vHcDr+ssS3aVm2cBRN1LdkV1krdv
         HS2O7dX5fB34ToDTGIj39/XCOMDOXlk6btG2pnerTcMVHyTWtZR5ixl/blfarcignyS3
         +IlHiOU/PU4bFXiLZXFyge51AKxcP1UjpQ7uxb70O94dI/3A0+n/A/7aNc64odxP7f6Q
         sjCoNRS6EhXCYajVkUbSghZ8Vjq4YMCIJlSyC5F7TFz665iqs/hK33VqhutDMGkeeogF
         UaKhDcLS4+IWuAY7A/HQcvese9vOC3jZUBru0WKHjyCleFsBRZlfZrgyqSmDN+xKlH6C
         54VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XEEJ+NdSVotCeqOa+J0COpT2uyZAFkgzUKOtpl6kuio=;
        b=T+zxe0qXKyfiSNAizqWrC/rSjIb71bQsrc2J86Wv84tXjuGYfS72KmrEqwGEfc0Zah
         vb6S7eF8cg/y+xWgFm6NwO6GC5j/1B5oztg9Af0ceTmVjbY9gu2oV2/HX+SVG8nJjwMm
         mTvko3I6uyH0AALB9Yvr5Fo8M/KY6Yr9OQQ+7x5IYsRWvNBFtyTy2A3H6l42Jaom8KuA
         PZXPLCuWoFglU9kyl4zEodtDBrWeLI3JOn68g/8JpWKeQV7ItwJw2oVIGHxbautxY5NH
         nzDpXWOISSKfm3+WnnUG5q/BWRvxv/R8l8NO7yQZ6zUmEkx6xjw9RY7twz1Xx2v8VqRu
         pYdA==
X-Gm-Message-State: AOAM533lpq/5NvQmf1WuK/msWuGLCYbl6HN0NyqeZuiuLr0mmnPukyN5
        sQpb+uUEGnapTrxArEnOPCvAZCboH8Kpv7yUuPmYfQ==
X-Google-Smtp-Source: ABdhPJzf6blD5ezRDhly1I/2fKBsQ+75DEo7x3d66Mo8vY3YgWSuuREy3y5AvMLnQkVnWNakublLDD8up0FeOqQLjus=
X-Received: by 2002:a05:6512:39c9:: with SMTP id k9mr13229164lfu.432.1615186260215;
 Sun, 07 Mar 2021 22:51:00 -0800 (PST)
MIME-Version: 1.0
References: <20210217001322.2226796-1-shy828301@gmail.com> <20210217001322.2226796-7-shy828301@gmail.com>
In-Reply-To: <20210217001322.2226796-7-shy828301@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 7 Mar 2021 22:50:46 -0800
Message-ID: <CALvZod6KH7f5FaEcDg4NvhSdeuPjVQK1HHwHppV+vbcittLi2Q@mail.gmail.com>
Subject: Re: [v8 PATCH 06/13] mm: memcontrol: rename shrinker_map to shrinker_info
To:     Yang Shi <shy828301@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 16, 2021 at 4:13 PM Yang Shi <shy828301@gmail.com> wrote:
>
> The following patch is going to add nr_deferred into shrinker_map, the change will
> make shrinker_map not only include map anymore, so rename it to "memcg_shrinker_info".
> And this should make the patch adding nr_deferred cleaner and readable and make
> review easier.  Also remove the "memcg_" prefix.
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Acked-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
