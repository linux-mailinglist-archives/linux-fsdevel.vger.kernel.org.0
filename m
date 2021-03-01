Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B6C3281CA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 16:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbhCAPGV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 10:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236813AbhCAPGQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:06:16 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247DCC061788
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Mar 2021 07:05:30 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id h8so16779622qkk.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Mar 2021 07:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CnYSa5BpoNmsrlE5xuLACW1oc/Ie+y9KsDztjUsE9K0=;
        b=zSpdZQrxlPGJCI8Gx0TWuxstB6h0vdCjUxSTz6lWHlvuKkK1r1DJ4aHhUWwfkFZ2z5
         PJ2yuzB4Qw/1hpNMNEWeFohhU8LgsDzqCntVwMrbkAayFavrwT8fOe+CPgkQyu4kigLi
         8COIFFzucuUy9ltCCy8HeeEhAQPEhwN0V0g9VEh2I354dD2vhdn+fArtlamHkfq61fmP
         EhgY5WQ5eukza4LcEBZiZ9/ZGyBakP0cs+SKc1pUYuyXmbX0EeogigftbyLsMTCaQoXU
         4sQV5JQ+OwfEvJYJTUXx50RtuNBM7WmiOCojak6nUSKdHVEKfTiG0G0ibFwPgIVHGKky
         B1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CnYSa5BpoNmsrlE5xuLACW1oc/Ie+y9KsDztjUsE9K0=;
        b=iuIioFhRIiuIlWb5bkKeRU2alQkPj5powIXIO4FLCoed3YXeoc8jd4pZsj1vX9N2vi
         O4qTGycwjQTdUuRopeo4rQVkPibTRf41hMfNgsi/jmDgGyNfp6C7n3ctNDeOeuZjDi9F
         s2hXqqk49SpjJg2bZ/CDwJ7ewikW3o9z/Fw5HKa8Jv/rcn7y1DRw2HMntCE75CgHAsQU
         tw8Cryw5vDULATppkmVoXYtIwy65u7rg9L0YgHWWvyzYjgEiqAi/MJjm9Fb1sIyaBUU8
         JVvF+c+guWmxHe0NNukO2D6yJLurBAS9gd4EwcNrWhBco9k9pPwiSHDV2ayrxrMvK3L2
         AyBA==
X-Gm-Message-State: AOAM531mTh7ubCvAQ9bwC3efEahlp3kVDtZvv66+9yz7gQ4L03LG5VmK
        5QfOM593bngnu+DlEtz0D2R+Ag==
X-Google-Smtp-Source: ABdhPJxsJiupemUjQ9FRN0qgybbahgtfZjr5CfKUvA1bm5Lt4GrwygyIbbUsK1rVE8jEXbgH0HQBvw==
X-Received: by 2002:a37:c92:: with SMTP id 140mr15135839qkm.177.1614611129387;
        Mon, 01 Mar 2021 07:05:29 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:c0b0])
        by smtp.gmail.com with ESMTPSA id 38sm11246382qtb.21.2021.03.01.07.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 07:05:28 -0800 (PST)
Date:   Mon, 1 Mar 2021 10:05:27 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v8 PATCH 00/13] Make shrinker's nr_deferred memcg aware
Message-ID: <YD0Ct/tP4TSok0BI@cmpxchg.org>
References: <20210217001322.2226796-1-shy828301@gmail.com>
 <CAHbLzkrEfeoofwJjncFDepcOxEKzqiAo8T7mowX2jJVCz5ikEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkrEfeoofwJjncFDepcOxEKzqiAo8T7mowX2jJVCz5ikEA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Yang,

On Thu, Feb 25, 2021 at 09:00:16AM -0800, Yang Shi wrote:
> Hi Andrew,
> 
> Just checking in whether this series is on your radar. The patch 1/13
> ~ patch 12/13 have been reviewed and acked. Vlastimil had had some
> comments on patch 13/13, I'm not sure if he is going to continue
> reviewing that one. I hope the last patch could get into the -mm tree
> along with the others so that it can get a broader test. What do you
> think about it?

The merge window for 5.12 is/has been open, which is when maintainers
are busy getting everything from the previous development cycle ready
to send upstream. Usually, only fixes but no new features are picked
up during that time. If you don't hear back, try resending in a week.

That reminds me, I also have patches I need to resend :)
