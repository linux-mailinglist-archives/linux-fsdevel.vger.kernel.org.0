Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3C223DE8B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Aug 2020 19:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgHFR1I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Aug 2020 13:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729685AbgHFRBx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:01:53 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B9AC0698CD;
        Thu,  6 Aug 2020 06:50:41 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id c2so29333088edx.8;
        Thu, 06 Aug 2020 06:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pYOAU4zyTtJPYkEQfnQ4aWaYGVh8/wQuqp7IpTtJ6do=;
        b=LvlvYpq9JUMWnC9/yFSS4wQkoMzm46piNKWyoQ5DuTwW/jjZl7ANZ4j592Uyj1yy3Y
         31H9pN3pbfyxBlVjBg64O+j4LwbZFScsNLIjvF/xJffyXB6z4b1w/YA+UINKPohJPaKM
         DhL8lwL+cYEe5vSJyl7gu1SCgZsX7iilU2sURy2UrTJgoEa0KrNbaU6eVmOsX1Dtp1Vs
         A040v/hmZTFY4JNauiwROduRvAeiJehMUPswUJA9yeARYk+30rTwtZkzc7LQhJPv/sEt
         kSF0maMNyYzQhF8UsZAf9VAKcQmDJRyt8GUPaEH5dTUt+t8xVfWwudrXhnv/OhxEJC80
         KuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=pYOAU4zyTtJPYkEQfnQ4aWaYGVh8/wQuqp7IpTtJ6do=;
        b=YR5fT+QSuZ/dBEwGSsK5mYJhzW5ArBsUUbmkhC2vO9ujgh28/V39u3+fYVINmBhtPa
         VzC3j7Pk5FyqHRdOTHGnlahNraAcGs+h/zjzwQwYmatyOSSUjy02EgrhDf3cxdSRmu84
         WyWmD8/v3U8oWvcw4Sapmd//IPbXaqZcVmuIpo2kBzMNbHMFK2SAmgAuh773KjV+Hytk
         0o2UlcGFts9eAQe/WnqPSLjeh/8+L5gGfdk2bfgzsPKckEliazNJ4Rey/jyu0h4K+Epr
         PN5gPZZRJWhORszPSQqsBulo3xw4+mHny527WiQ7OsfBMxQK205LVUKr/5nXt08GoRIm
         BxmA==
X-Gm-Message-State: AOAM5313a4W/raGmtwtZunkPZFZMPgMCw3CtdHFOILHjACLXUZfm19nC
        SaFhMSomLM8OaA6qV8euLvs=
X-Google-Smtp-Source: ABdhPJzYxh9mNb/BHUYWWWsOHgNjPXvNZwBtPKO84YZdhn5EUVlGhMh8pj2PSHlZ0cZ/+d3acTJDPQ==
X-Received: by 2002:a05:6402:13d9:: with SMTP id a25mr4192009edx.141.1596721839522;
        Thu, 06 Aug 2020 06:50:39 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id c7sm3614732edf.1.2020.08.06.06.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 06:50:38 -0700 (PDT)
Date:   Thu, 6 Aug 2020 15:50:36 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     x86@kernel.org, Jan Kara <jack@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: improve compat handling for the i386 u64 alignment quirk v2
Message-ID: <20200806135036.GA2077896@gmail.com>
References: <20200731122202.213333-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731122202.213333-1-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


* Christoph Hellwig <hch@lst.de> wrote:

> Hi all,
> 
> the i386 ABI is a little special in that it uses less than natural
> alignment for 64-bit integer types (u64 and s64), and a significant
> amount of our compat handlers deals with just that.  Unfortunately
> there is no good way to check for this specific quirk at runtime,
> similar how in_compat_syscall() checks for a compat syscall.  This
> series adds such a check, and then uses the quota code as an example
> of how this improves the compat handling.  I have a few other places
> in mind where this will also be useful going forward.
> 
> Changes since v1:
>  - use asm-generic/compat.h instead of linux/compat.h for
>    compat_u64 and compat_s64
>  - fix a typo
> 
> Diffstat:
>  b/arch/arm64/include/asm/compat.h        |    2 
>  b/arch/mips/include/asm/compat.h         |    2 
>  b/arch/parisc/include/asm/compat.h       |    2 
>  b/arch/powerpc/include/asm/compat.h      |    2 
>  b/arch/s390/include/asm/compat.h         |    2 
>  b/arch/sparc/include/asm/compat.h        |    3 
>  b/arch/x86/entry/syscalls/syscall_32.tbl |    2 
>  b/arch/x86/include/asm/compat.h          |    3 
>  b/fs/quota/Kconfig                       |    5 -
>  b/fs/quota/Makefile                      |    1 
>  b/fs/quota/compat.h                      |   34 ++++++++
>  b/fs/quota/quota.c                       |   73 +++++++++++++++---
>  b/include/asm-generic/compat.h           |    8 ++
>  b/include/linux/compat.h                 |    9 ++
>  b/include/linux/quotaops.h               |    3 
>  b/kernel/sys_ni.c                        |    1 
>  fs/quota/compat.c                        |  120 -------------------------------
>  17 files changed, 113 insertions(+), 159 deletions(-)

If nobody objects to this being done at runtime, and if it's 100% ABI 
compatible, then the x86 impact looks good to me:

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
