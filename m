Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73262C52A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 12:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388716AbgKZLKW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 06:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388706AbgKZLKV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 06:10:21 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ADFC0613D4;
        Thu, 26 Nov 2020 03:10:21 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w187so1363689pfd.5;
        Thu, 26 Nov 2020 03:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ysDAMzeQzMrmseqw54pHHcgme62kOCrHB1LTNQfRYkQ=;
        b=Xr53pffB+0JmTjNdhXpjfVXnysRhdot/YQSjQUJlVWTn/ra/bYOUd4f50o4JZ0CL0A
         ioWAtUAU+RQByPSuQqokkjMgg232/OhoKQ8N4kpXItcBPzWsX7bIWIjB4v+/7xdZS7Dj
         iLKY7YoLqzT61mgxsIV84+OBt3qwCq9vM7Cvr3hMldHQU/kL+1cp2SlPSewjqTguauLE
         R0pjpvsizfkUFEsDRCHINR7RhPez5hJnh2rafYy11tElHz4+M2rQlqb5dilAsqjGZ6tS
         yyWcYo1xgCC0NtARWGWnjulKrfhRqWBf5xDBFDKbNYvab/BQo4ehaPAcablRXN7fsn33
         yp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ysDAMzeQzMrmseqw54pHHcgme62kOCrHB1LTNQfRYkQ=;
        b=cODHyCTbBra/XxCh02PpIyh+BtMH9Za8wVlnnrIVt5CYk2YnpQZWAchgP99s99fWbi
         2Ofs3B4QjGo+ljtYBquMnq7rCTpOcH/WRRi6w8mkvCTacCfrnuSrtYZzHBBPELk+VuqD
         ojTH7YwlY+mZ5ipROuMOUywRuFOCRWlepurhrbXzbGx4oIadlINc8OE2an7l7iyuhfHs
         J6BWCJMtvSi9Ly/XuoSt6HRpovP5gTZHK4TQX/Z79Qv9RLMfkCnX1J7VQ4EGLyxR5HCi
         SlQMfi2VUvtkrIqQJhuFmUtUEOWk+vXvngbgsctdg8pKlEpdHkwYzGv/xtcrhrJHFDF6
         4yGg==
X-Gm-Message-State: AOAM531UDt18BpRd5clpNJprUnrHwxO6e/pcNJWNAfCOIcvt4zoEb04H
        mN0pUsMS1V/pAWP1aQ7r3c8XO8CRiQU0uTGE5W4=
X-Google-Smtp-Source: ABdhPJxJD1NykgWeec15xFKr3NqfS1cXWilGx/PVFgSGw7gcEgeheK7b3dQCpTxeed6pibGoMSpYnv3Ex1gCrw5ZXOo=
X-Received: by 2002:a05:6a00:14cf:b029:18c:959d:929e with SMTP id
 w15-20020a056a0014cfb029018c959d929emr2306209pfu.53.1606389020793; Thu, 26
 Nov 2020 03:10:20 -0800 (PST)
MIME-Version: 1.0
References: <20201123063835.18981-1-miles.chen@mediatek.com>
In-Reply-To: <20201123063835.18981-1-miles.chen@mediatek.com>
From:   Catalin Marinas <catalin.marinas@arm.com>
Date:   Thu, 26 Nov 2020 11:10:09 +0000
Message-ID: <CAHkRjk7xGoU=KBeFE4gy=yxkLhvHqz2A1JyCBKF8dhjJNDD=zA@mail.gmail.com>
Subject: Re: [RESEND PATCH v1] proc: use untagged_addr() for pagemap_read addresses
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wsd_upstream@mediatek.com, andreyknvl@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Miles,

Could you please cc me and Andrey Konovalov on future versions of this
patch (if any)?

On Mon, 23 Nov 2020 at 08:47, Miles Chen <miles.chen@mediatek.com> wrote:
> When we try to visit the pagemap of a tagged userspace pointer, we find
> that the start_vaddr is not correct because of the tag.
> To fix it, we should untag the usespace pointers in pagemap_read().
>
> I tested with 5.10-rc4 and the issue remains.
>
> My test code is baed on [1]:
>
> A userspace pointer which has been tagged by 0xb4: 0xb400007662f541c8
>
> === userspace program ===
>
> uint64 OsLayer::VirtualToPhysical(void *vaddr) {
>         uint64 frame, paddr, pfnmask, pagemask;
>         int pagesize = sysconf(_SC_PAGESIZE);
>         off64_t off = ((uintptr_t)vaddr) / pagesize * 8; // off = 0xb400007662f541c8 / pagesize * 8 = 0x5a00003b317aa0

Arguably, that's a user-space bug since tagged file offsets were never
supported. In this case it's not even a tag at bit 56 as per the arm64
tagged address ABI but rather down to bit 47. You could say that the
problem is caused by the C library (malloc()) or whoever created the
tagged vaddr and passed it to this function. It's not a kernel
regression as we've never supported it.

Now, pagemap is a special case where the offset is usually not
generated as a classic file offset but rather derived by shifting a
user virtual address. I guess we can make a concession for pagemap
(only) and allow such offset with the tag at bit (56 - PAGE_SHIFT +
3).

Please fix the patch as per Eric's suggestion on avoiding the
overflow. You should also add a Cc: stable v5.4- as that's when we
enabled the tagged address ABI on arm64 and when it's more likely for
the C library/malloc() to start generating such pointers.

If the problem is only limited to this test, I'd rather fix the user
but I can't tell how widespread the /proc/pid/pagemap usage is.

Thanks.

-- 
Catalin
