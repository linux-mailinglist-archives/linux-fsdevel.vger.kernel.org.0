Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFE53577E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 00:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhDGWmJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 18:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhDGWmH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 18:42:07 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95864C061760
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Apr 2021 15:41:55 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 12so612318lfq.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Apr 2021 15:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UlW0Ewz0TJE6dHdQktAkyDdaQS9xqmk5R6tFIsrvbdY=;
        b=gMOvyRvSBdLpabOdz47dwXyDCQ31XoDE396g9e9aL0J9UTDdnWIijnPIJAGJU5tENC
         +M2piM6MXnXRE4IDeq+Azj2ImaUAS0jjAG+VvnJhD5aGm0oHozbHgb/A+DIjd80qJ4jo
         tKMB3w9XTcDjT0qyRm127hleWX61wE3jOvRPWYNgFYp5tlWbaOnrbxhAS73xNKtGbGNG
         W0Yja9jm+h8QaSz6R+fIOqwkPWGWTF5xyDLvfMeUk5zJoz3xvkFRryyXZmpjBBzi0y+L
         xRKqNI+bqCWBCo6WpRTycwdCdA2y2rXczgvxQWL5WknvKUo9oqSQFlla+KevDjb5iYbG
         Cptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UlW0Ewz0TJE6dHdQktAkyDdaQS9xqmk5R6tFIsrvbdY=;
        b=helnAH35WNkOXV0vo/qDRYGVJBElJm43lff3tCwKAaSRenk7m/DnLLUe5i+biXwb4K
         Lfp3u2tipNSOqQpKMId7MnqF4jKoujeLDL31PGSRiaEb+pMV99fGsNomobThw9YF4MVp
         tGr7Du0xfjBz7NEPI2QmWL21plXJD7xQOB5r/VNrXknFVA3U0h4jc+3VO1971lW8MGFY
         iQ9oBqBuFUgD8wEaZW5w+uGi7zUS2ERBgbm1sjui7Fx/ji2rJZHd0XLtQTd6W/SS1jY/
         LvNXJZzXE3qtINXFANAXeMxJ+M3YCLmRlk04a8JjD2RpI48MY+UmwSmfbeT0GJEKyXxQ
         +Ijg==
X-Gm-Message-State: AOAM530YCr0zX3M3gkieZHdo+yiXzrKlOD5oIqi+1fKHEoavntYnTm7X
        9b/QbFUjU8DP9YVwrLszVLPUpiJrVw+QpB3qOre2Rj0Wg5q71A==
X-Google-Smtp-Source: ABdhPJwyJehdxHhU1JqMYu/+AzWCxxU1DRmmxIyA/FStI2zhvfIh/yzuAfz6N+LvVZATklcauZYTfK1r9Ob13HgwCds=
X-Received: by 2002:ac2:58d8:: with SMTP id u24mr3940661lfo.67.1617835314116;
 Wed, 07 Apr 2021 15:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210407150255.GE2531743@casper.infradead.org>
In-Reply-To: <20210407150255.GE2531743@casper.infradead.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Thu, 8 Apr 2021 07:41:42 +0900
Message-ID: <CACOAw_wLgGyD0nLguoi2LGzWwTO-oT5W=hibaXGQK4aHYSm9VA@mail.gmail.com>
Subject: Re: [f2fs-dev] Why use page_cache_ra_unbounded?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Daeho Jeong <daehojeong@google.com>, linux-fsdevel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2021=EB=85=84 4=EC=9B=94 8=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 12:05, M=
atthew Wilcox <willy@infradead.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
>
> commit 5fdb322ff2c2b4ad519f490dcb7ebb96c5439af7
> Author: Daeho Jeong <daehojeong@google.com>
> Date:   Thu Dec 3 15:56:15 2020 +0900
>
>     f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE
>
> +       page_cache_ra_unbounded(&ractl, len, 0);
>
> /**
>  * page_cache_ra_unbounded - Start unchecked readahead.
>  * @ractl: Readahead control.
>  * @nr_to_read: The number of pages to read.
>  * @lookahead_size: Where to start the next readahead.
>  *
>  * This function is for filesystems to call when they want to start
>  * readahead beyond a file's stated i_size.  This is almost certainly
>  * not the function you want to call.  Use page_cache_async_readahead()
>  * or page_cache_sync_readahead() instead.
>  *
>  * Context: File is referenced by caller.  Mutexes may be held by caller.
>  * May sleep, but will not reenter filesystem to reclaim memory.
>  */
>
> Why?
>

Hi Matthew,

What I wanted here is like do_page_cache_ra(), but do_page_cache_ra()
is defined in mm/internal.h only for internal use.
So, I used it, because we already checked the i_size boundary on our own.
Actually, I wanted to detour the internal readahead mechanism using
page_cache_ra_unbounded() to generate cluster size aligned read requests.
Plus, page_cache_sync_readahead() is not good for our situation,
it might end up with cluster misaligned reads which trigger internal
duplicated cluster reads.

>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
