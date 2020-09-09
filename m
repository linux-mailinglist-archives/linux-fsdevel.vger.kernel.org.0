Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0812625EC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 05:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgIIDgb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 23:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgIIDg2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 23:36:28 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930B1C061573;
        Tue,  8 Sep 2020 20:36:27 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id v78so861532ybv.5;
        Tue, 08 Sep 2020 20:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X3uD9iTsb4n/SxPFUpHhLW1PU5XlJVEQOctSvYt+PUA=;
        b=MjWTMZKw7wFRWnAHnZLw9pw3hUnD6nflWH5N7AKEWVq9C/MgLJ0rvEzpbhbYifJ7g2
         j1+dkY9hA3e2LLShzfJhbubVGDER46F/ejHT2ENYXwLzDJ9CBgZHQeq1DFWCVh7iNdEe
         KYmFXQMX6vtePP/OSPIhE5XbICyrNK9RWK8Td4SstRF2XhHK3xaKT1nVfGcEp9VkWjm/
         /5BVke9GwcGV+hn6CBe7Zlpudrw1apWviBjsqlc8vNU2ZwC4dYQzZ699BKK9yHmJf5Z5
         n+K2nO7DyZDGTUxlHv+Lejkwn1m0Ghb0JgDN+uo4hLaDf3b4xc+z46fQQo6wLoefo9Zp
         7/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X3uD9iTsb4n/SxPFUpHhLW1PU5XlJVEQOctSvYt+PUA=;
        b=eAeMuWQkLrRz7dz/BjbyU2+dcePWTR05mTNafHGMMtMmgh6IhpbK6zSYzVCya6qn2O
         95PEP58Ew2NzreiaIvs3EGDn+WjxqihNnEGZ0jjBZi4hKtM9P2/yUHJM6qlhQMjQSgkP
         AnoRXBUFCpNwAjm6xxmkiryGzGS5sxcKfxxsw4NnMq2yRFdp/HAIcVIScwXM3bnGqKiK
         WGEJMk7B2/r7M+0OO/c022BdVIi4+xORKVim5Gwll4y8xg1TmPwJWNXQRS3Nm1UElnJM
         Y9USaXYGQADZWIkiJKimZfUPCAAa3iRipV1fh0D/NgeGhhB31CTR5F3J85OyPKHQCjhj
         /1Dw==
X-Gm-Message-State: AOAM533ELtv5SqKm+ZhZ4NhHDXde31ha9UeMi6Q1ni9rc2dkod90u2BU
        qjdTR8gtFmA7CYObYDxMyZzXGfZ/UnMavuGHHeCojevk4C0+Lg==
X-Google-Smtp-Source: ABdhPJypGQNApEm4nqJsRSyze+6XsGrF0vUUGz2wpF9K26/NWnd98fxE1Z41CF1Fi1l/r3qfzH0GNJHz/3g3R8b21AI=
X-Received: by 2002:a25:aba5:: with SMTP id v34mr2952978ybi.337.1599622586652;
 Tue, 08 Sep 2020 20:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <bfee107c7d1075cab6ec297afbd3ace68955b836.1599620898.git.riteshh@linux.ibm.com>
In-Reply-To: <bfee107c7d1075cab6ec297afbd3ace68955b836.1599620898.git.riteshh@linux.ibm.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 9 Sep 2020 11:36:15 +0800
Message-ID: <CACVXFVMPHhA9_Pk-KGROimwxJBM_5SHmjH+CKkkNLJWGk2gmFw@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/1] block: Set same_page to false in
 __bio_try_merge_page if ret is false
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Shivaprasad G Bhat <sbhat@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 9, 2020 at 11:16 AM Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>
> If we hit the UINT_MAX limit of bio->bi_iter.bi_size and so we are anyway
> not merging this page in this bio, then it make sense to make same_page
> also as false before returning.
>
> Without this patch, we hit below WARNING in iomap.
> This mostly happens with very large memory system and / or after tweaking
> vm dirty threshold params to delay writeback of dirty data.
>
> WARNING: CPU: 18 PID: 5130 at fs/iomap/buffered-io.c:74 iomap_page_release+0x120/0x150
>  CPU: 18 PID: 5130 Comm: fio Kdump: loaded Tainted: G        W         5.8.0-rc3 #6
>  Call Trace:
>   __remove_mapping+0x154/0x320 (unreliable)
>   iomap_releasepage+0x80/0x180
>   try_to_release_page+0x94/0xe0
>   invalidate_inode_page+0xc8/0x110
>   invalidate_mapping_pages+0x1dc/0x540
>   generic_fadvise+0x3c8/0x450
>   xfs_file_fadvise+0x2c/0xe0 [xfs]
>   vfs_fadvise+0x3c/0x60
>   ksys_fadvise64_64+0x68/0xe0
>   sys_fadvise64+0x28/0x40
>   system_call_exception+0xf8/0x1c0
>   system_call_common+0xf0/0x278
>
> Fixes: cc90bc68422 ("block: fix "check bi_size overflow before merge"")
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Reported-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
> RESEND: added "fixes" tag
>
>  block/bio.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/block/bio.c b/block/bio.c
> index a7366c02c9b5..675ecd81047b 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -877,8 +877,10 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
>                 struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
>
>                 if (page_is_mergeable(bv, page, len, off, same_page)) {
> -                       if (bio->bi_iter.bi_size > UINT_MAX - len)
> +                       if (bio->bi_iter.bi_size > UINT_MAX - len) {
> +                               *same_page = false;
>                                 return false;
> +                       }
>                         bv->bv_len += len;
>                         bio->bi_iter.bi_size += len;
>                         return true;

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming Lei
