Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C12B4F91FA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 11:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbiDHJ0q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 05:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiDHJ0n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:26:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8566A19C814
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Apr 2022 02:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649409878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sg9LjEx0//PYzzxj1IqHd0bY2z1rKaQOVJuq5koLYkE=;
        b=G6lpRWjdWcmmYU0BJMHVUZnu/F0eijJLnU9g/xHam8/BglmOtMY1Pyueiil+uuUkq4Sr8m
        f1kd4BSwVLxsaFu5ErtItS1Dz/FtVrTTE4IStJLQ/zAr9lopoIuRsTwpZzKKnaaHk3k5N0
        oW4gsO3u23Thi/mFutqQzgZxDnY0v/w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-LmUZXseiPkKMZUvSxKGSzw-1; Fri, 08 Apr 2022 05:24:35 -0400
X-MC-Unique: LmUZXseiPkKMZUvSxKGSzw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58687811E76;
        Fri,  8 Apr 2022 09:24:34 +0000 (UTC)
Received: from localhost (ovpn-12-202.pek2.redhat.com [10.72.12.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 68CE9145BA41;
        Fri,  8 Apr 2022 09:24:33 +0000 (UTC)
Date:   Fri, 8 Apr 2022 17:24:28 +0800
From:   Baoquan He <bhe@redhat.com>
To:     akpm@linux-foundation.org, willy@infradead.org,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        hch@lst.de, yangtiezhu@loongson.cn, amit.kachhap@arm.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5 RESEND 0/3] Convert vmcore to use an iov_iter
Message-ID: <Yk//TCkucXiVD3s0@MiWiFi-R3L-srv>
References: <20220408090636.560886-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408090636.560886-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add Heiko to CC.

On 04/08/22 at 05:06pm, Baoquan He wrote:
> Copy the description of v3 cover letter from Willy:
> ===
> For some reason several people have been sending bad patches to fix
> compiler warnings in vmcore recently.  Here's how it should be done.
> Compile-tested only on x86.  As noted in the first patch, s390 should
> take this conversion a bit further, but I'm not inclined to do that
> work myself.

Forgot adding Heiko to CC again.

Hi Heiko,

Andrew worried you may miss the note, "As noted in the first patch,
s390 should take this conversion a bit further, but I'm not inclined
to do that work myself." written in cover letter from willy.

I told him you had already known this in v1 discussion. So add you in CC
list as Andrew required. Adding words to explain, just in case confusion.

> 
> V4:
> [PATCH v4 0/3] Convert vmcore to use an iov_iter
> https://lore.kernel.org/all/20220318093706.161534-1-bhe@redhat.com/T/#u
> 
> v3:
> [PATCH v3 0/3] Convert vmcore to use an iov_iter
> https://lore.kernel.org/all/20211213143927.3069508-1-willy@infradead.org/T/#u
> 
> 
> Changelog:
> ===
> v5 RESEND:
>  - Add my own Signed-off-by, no code or log change related in this round.
> 
> v5:
>  - Rebased on Linus's latest master branch.
>  - Merge the patch 4 of v4 into patch 2.
> v4:
>  - Append one patch to replace the open code with iov_iter_count().
>    This is suggested by Al.
>  - Fix a indentation error by replacing space with tab in
>    arch/sh/kernel/crash_dump.c of patch 1 reported by checkpatch. The
>    rest of patch 1~3 are untouched.
>  - Add Christopy's Reviewed-by and my Acked-by for patch 1~3.
> v3:
>  - Send the correct patches this time
> v2:
>  - Removed unnecessary kernel-doc
>  - Included uio.h to fix compilation problems
>  - Made read_from_oldmem_iter static to avoid compile warnings during the
>    conversion
>  - Use iov_iter_truncate() (Christoph)
> 
> 
> Matthew Wilcox (Oracle) (3):
>   vmcore: Convert copy_oldmem_page() to take an iov_iter
>   vmcore: Convert __read_vmcore to use an iov_iter
>   vmcore: Convert read_from_oldmem() to take an iov_iter
> 
>  arch/arm/kernel/crash_dump.c     |  27 +------
>  arch/arm64/kernel/crash_dump.c   |  29 +------
>  arch/ia64/kernel/crash_dump.c    |  32 +-------
>  arch/mips/kernel/crash_dump.c    |  27 +------
>  arch/powerpc/kernel/crash_dump.c |  35 ++-------
>  arch/riscv/kernel/crash_dump.c   |  26 +------
>  arch/s390/kernel/crash_dump.c    |  13 ++--
>  arch/sh/kernel/crash_dump.c      |  29 ++-----
>  arch/x86/kernel/crash_dump_32.c  |  29 +------
>  arch/x86/kernel/crash_dump_64.c  |  48 ++++--------
>  fs/proc/vmcore.c                 | 130 +++++++++++++------------------
>  include/linux/crash_dump.h       |  19 ++---
>  12 files changed, 123 insertions(+), 321 deletions(-)
> 
> -- 
> 2.34.1
> 

