Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A466B467D3F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 19:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382684AbhLCS3D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 13:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382681AbhLCS3C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 13:29:02 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F8EC061751
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Dec 2021 10:25:37 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id e3so15173868edu.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Dec 2021 10:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Or/JmgPTS79GqZIutDkpHnEjHVYD0LU+lzufkfg0YQw=;
        b=WTkKNkRE6R418ysyxmvF8zDurfo/zAOdLc0UOp7eCzeFJefSW8HET1IAYuo+Taimiy
         p4iweJpk9xplCCWJEpzAorhhQJWPSFavF78h6ld1rIUuOva5uei/OUOvEgUzYiVZm1wt
         QpKnqVIUdp4omi7wXkYSNGbpjyco2jCVtE1Lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Or/JmgPTS79GqZIutDkpHnEjHVYD0LU+lzufkfg0YQw=;
        b=ywB7lLHC0WTBlUe1Td0jYNzjEoZ0+2ylHtzAggFkYD/4YBJ3eFVOvzjx1RnALxqg/c
         I/mIDfBMFmoTpFvXeWTQ2p4F5AMqmLFGbUcU0C6jMPIuf75+spITgwmTeU4QMyURMlzy
         KdiXAm83FE54ruAT9DzrHfQajCk0+fLzLndUYwr2PlngzgLuHfE9aRfn3C40pb5W0nGp
         lLfkkpXE9qJm6qPnp3z1Ri3jfWTvSpDX2tPUsBlFtTLeVhdkg5oE654dbFTjfhzP1MkI
         XSoc4n+K0vrLfliZ1Blimx2J6delOZ2a7G3uKCTtMyXb5zYe40zckdPgPDDZ4uNGu2Yo
         /z7A==
X-Gm-Message-State: AOAM532R3KjlybLBb8vkUJwdbvh1DJlmDWBQfwSfNdjBJcnqNFqOZsut
        rRQyBCprz7zodYJlKpaBlfv1SazKMKAuE32A
X-Google-Smtp-Source: ABdhPJxDViv459+2ti6DqDSG7M2HB5eEC0sEvgXAYU6ldZOag7RUAj8zhPaOvgcE3C1RIBfdyTZI+g==
X-Received: by 2002:a17:906:229b:: with SMTP id p27mr25722308eja.264.1638555936005;
        Fri, 03 Dec 2021 10:25:36 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id t7sm2472755edi.90.2021.12.03.10.25.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 10:25:34 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id v11so7422875wrw.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Dec 2021 10:25:33 -0800 (PST)
X-Received: by 2002:adf:f8c3:: with SMTP id f3mr23456435wrq.495.1638555933321;
 Fri, 03 Dec 2021 10:25:33 -0800 (PST)
MIME-Version: 1.0
References: <20211201193750.2097885-1-catalin.marinas@arm.com>
 <CAHc6FU7gXfZk7=Xj+RjxCqkmsrcAhenfbeoqa4AmHd5+vgja7g@mail.gmail.com>
 <CAHk-=wiQAQTGdMNLCKwgnt4EiAXf7Bm6p7NQx5-31S9-qPD8jg@mail.gmail.com> <CAHc6FU6r-CsMHkWzxEm237mV2vZ2O9g_D7BbCPeaA2qX0dpi0g@mail.gmail.com>
In-Reply-To: <CAHc6FU6r-CsMHkWzxEm237mV2vZ2O9g_D7BbCPeaA2qX0dpi0g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Dec 2021 10:25:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi12AStfPrXLjki_SLc5qqDwYX21bJLp10mynNQj7u8FA@mail.gmail.com>
Message-ID: <CAHk-=wi12AStfPrXLjki_SLc5qqDwYX21bJLp10mynNQj7u8FA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Avoid live-lock in fault-in+uaccess loops with
 sub-page faults
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 3, 2021 at 10:12 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> It happens when you mmap a file and write the mmapped region to
> another file, for example.

Do you actually have such loads? Nobody should use mmap() for
single-access file copy purposes. It's slower than just doing the copy
exactly due to page fault overhead.

In other words, you seem to be worrying about the performance of a
load that is _explicitly_ badly written. You should be fixing the
application, not making the kernel do stupid things.

Also, it's worth noting that that situation should be caught by the
page-in code, which will map multiple pages in one go
(do_fault_around() - for when the pages are cached), and do the
readahead logic (filemap_fault() - for when the pages aren't in the
page cache).

Both of which are a lot more important than the "synchronously fault
in pages one at a time".

                Linus
