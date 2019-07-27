Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA687781B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2019 12:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387419AbfG0KQM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Jul 2019 06:16:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41617 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728821AbfG0KQM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Jul 2019 06:16:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so53625553wrm.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jul 2019 03:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IXEjdnUn3VkhWBwJSQhECGFViuPtRLCo9vxT8tzVgl8=;
        b=a71xFW1NUEq3o8kaHcCrDOOxweDvWfxkp5iKwmVSBuzUXtmp2Bs/hmDEUtV3HkeQnQ
         JWMv9wk0XNKWjntQLlyVE8LDYrP7rri71bngMvGZW5+W2nL4nbe36sjnAUywcyUSnLxn
         ET/QGwikXysoTxta0lpPP7dpr1pLviGffAq1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IXEjdnUn3VkhWBwJSQhECGFViuPtRLCo9vxT8tzVgl8=;
        b=a7Mb96PyfEpBfzNvWBJ1wmnl7ny0824267bWbS8kEDGyibe8gsP4MUi1n5YejPtY6Z
         9Cxk/pIu6jpxIGUyKIHQRNQ2zB3ur5yScfuyB2izJl6r84H8JoE9fGoQ/yjUSEgad/NP
         qHqm0aDMSvLNOly3jj8eOhye7lMPg9gmll3vHnxI7oZ9vdJk2xMzp32FbuOf1bXusi5k
         2T3dZgXstiDT4ehahdRCku2O44Da7ZkIU4x67jDAvvijTlJ57CCUTDgiK1Q+ikQfoEJt
         F+cLanfadWzzn8Z1FSClORsnh1MJ8TIoJBGrIiVrQYSo7xta0llt/ir/yZZVlKic7TJo
         2+Cg==
X-Gm-Message-State: APjAAAVTAIfI/VQxuJpOOxw2Eys08ic/kg+tOn5Rcqe0BedcYlgaAfUQ
        2mrdH8ITZZYWRFFCshUMKc9iUA==
X-Google-Smtp-Source: APXvYqx/cGuS1gJ0Afm2ttVoWqm/3PaHRFGZ43BnTfOXHbEQEMJU5qWym22vdCCCuNXUHFEHPP+FUQ==
X-Received: by 2002:adf:e841:: with SMTP id d1mr28181928wrn.204.1564222569709;
        Sat, 27 Jul 2019 03:16:09 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:56e1:adff:fe3f:49ed])
        by smtp.gmail.com with ESMTPSA id f2sm49931061wrq.48.2019.07.27.03.16.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 03:16:09 -0700 (PDT)
Date:   Sat, 27 Jul 2019 11:16:08 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: mmotm 2019-07-24-21-39 uploaded (mm/memcontrol)
Message-ID: <20190727101608.GA1740@chrisdown.name>
References: <20190725044010.4tE0dhrji%akpm@linux-foundation.org>
 <4831a203-8853-27d7-1996-280d34ea824f@infradead.org>
 <20190725163959.3d759a7f37ba40bb7f75244e@linux-foundation.org>
 <20190727034205.GA10843@archlinux-threadripper>
 <20190726211952.757a63db5271d516faa7eaac@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190726211952.757a63db5271d516faa7eaac@linux-foundation.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

u64 division: truly the gift that keeps on giving. Thanks Andrew for following 
up on these.

Andrew Morton writes:
>Ah.
>
>It's rather unclear why that u64 cast is there anyway.  We're dealing
>with ulongs all over this code.  The below will suffice.

This place in particular uses u64 to make sure we don't overflow when left 
shifting, since the numbers can get pretty big (and that's somewhat needed due 
to the need for high precision when calculating the penalty jiffies). It's ok 
if the output after division is an unsigned long, just the intermediate steps 
need to have enough precision.

>Chris, please take a look?
>
>--- a/mm/memcontrol.c~mm-throttle-allocators-when-failing-reclaim-over-memoryhigh-fix-fix-fix
>+++ a/mm/memcontrol.c
>@@ -2415,7 +2415,7 @@ void mem_cgroup_handle_over_high(void)
> 	clamped_high = max(high, 1UL);
>
> 	overage = (u64)(usage - high) << MEMCG_DELAY_PRECISION_SHIFT;
>-	do_div(overage, clamped_high);
>+	overage /= clamped_high;

I think this isn't going to work because left shifting by 
MEMCG_DELAY_PRECISION_SHIFT can make the number bigger than ULONG_MAX, which 
may cause wraparound -- we need to retain the u64 until we divide.

Maybe div_u64 will satisfy both ARM and i386? ie.

diff --git mm/memcontrol.c mm/memcontrol.c
index 5c7b9facb0eb..e12a47e96154 100644
--- mm/memcontrol.c
+++ mm/memcontrol.c
@@ -2419,8 +2419,8 @@ void mem_cgroup_handle_over_high(void)
         */
        clamped_high = max(high, 1UL);
 
-       overage = (u64)(usage - high) << MEMCG_DELAY_PRECISION_SHIFT;
-       do_div(overage, clamped_high);
+       overage = div_u64((u64)(usage - high) << MEMCG_DELAY_PRECISION_SHIFT,
+                         clamped_high);
 
        penalty_jiffies = ((u64)overage * overage * HZ)
                >> (MEMCG_DELAY_PRECISION_SHIFT + MEMCG_DELAY_SCALING_SHIFT);
