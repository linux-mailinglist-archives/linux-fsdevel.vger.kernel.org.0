Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3152D9A24C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 23:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391575AbfHVVmS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 17:42:18 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42834 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390845AbfHVVmR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:42:17 -0400
Received: by mail-yw1-f67.google.com with SMTP id z63so3007559ywz.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2019 14:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3a8FQUWtnJl6Iq1aVRQEs3dAOt9/WevgkB8EWfGCUcE=;
        b=grizZo5oI+1N6WWP6+PJp924bXFGLnRU6WYtg/VskEj5bdsxPg2Cuv/vIK8llLGBBN
         e/dFzbrE5kcuz0gMted4Ly4AcihzI7l9gzQKrSMkrukJoDzLAEVSkyj8iRkYUzG+AFBi
         s/xHtZxRSDMgiDggFdBt+KTK0S74r52OLTNbIAYMdBwcRdRWnXVoWTf41FVM1gLbKAPj
         0J0vZtbozG7ulxZD8X8gcfkmi2pY7BVWAIIdT95KHmrw7Aitc2aWpm/h7XH9XRBA/QPT
         VaROpVzmvt91ubqSHQww93vy0jwuKMk2eXKBztsYODpAz+MTJxkWQ4umDoLSp4s/UB7O
         xWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3a8FQUWtnJl6Iq1aVRQEs3dAOt9/WevgkB8EWfGCUcE=;
        b=r2uAa06LnzSmfnWn7ZBw2ly6VHKbqh/QNUFxPnUYVAFYPA0R+IC43inRE9qZa3nnmQ
         CJo/b7/OoXTcgW8h2ZUXJhcxT96cX4uWbRNI87e7kCtSY4jO7klopel3XDaAMM7z8lZQ
         n1uIE3R9xSqaqpmEgYtNXQxSYU05HACF+kZJHnU1VwGIPgHMbsN1krKL3o9MBl2e9TSp
         /GGwUjNxxcbPkoSPtQzA+neikMVC9ZxUwEAY1UkOhcSKCxENvWGiWsVkOWPuGPHNjD0O
         cmevnWTBslinulNMLljO1YqM0ELA+eIXBENBQYK+qlNJPZpCTSohQ4M8WzUN+KYrpXqS
         mWKQ==
X-Gm-Message-State: APjAAAVQeaDWYP+sHg+tBrXjSobfTSeQbra+2iaDvZNcVQcItTkCPG+4
        /AaIUFhlZth7fOstJnftOn8aLhb4NX1nfPwlI+/0Ug==
X-Google-Smtp-Source: APXvYqzOWWP600qdObq6QCAm813NyIM4jRTnQcgARF2erYpjecwaSvWVA8y9igIls+9CLcT9GZwM6biJ96cxBiSCNIg=
X-Received: by 2002:a0d:cb42:: with SMTP id n63mr1180557ywd.205.1566510136417;
 Thu, 22 Aug 2019 14:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190822200030.141272-1-khazhy@google.com> <20190822200030.141272-2-khazhy@google.com>
In-Reply-To: <20190822200030.141272-2-khazhy@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 22 Aug 2019 14:42:05 -0700
Message-ID: <CALvZod6DB5PfGuGcks2Xr7PTrDwdUFnkgwsfBvAxYds5EX2wRA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] fuse: pass gfp flags to fuse_request_alloc
To:     Khazhismel Kumykov <khazhy@google.com>
Cc:     miklos@szeredi.hu, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 22, 2019 at 1:00 PM Khazhismel Kumykov <khazhy@google.com> wrote:
>
> Instead of having a helper per flag
>
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  fs/fuse/dev.c    | 16 +++-------------
>  fs/fuse/file.c   |  6 +++---
>  fs/fuse/fuse_i.h |  4 +---
>  fs/fuse/inode.c  |  4 ++--
>  4 files changed, 9 insertions(+), 21 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index ea8237513dfa..c957620ce7ba 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -66,7 +66,7 @@ static struct page **fuse_req_pages_alloc(unsigned int npages, gfp_t flags,
>         return pages;
>  }
>
> -static struct fuse_req *__fuse_request_alloc(unsigned npages, gfp_t flags)
> +struct fuse_req *fuse_request_alloc(unsigned int npages, gfp_t flags)
>  {
>         struct fuse_req *req = kmem_cache_zalloc(fuse_req_cachep, flags);
>         if (req) {
> @@ -90,18 +90,8 @@ static struct fuse_req *__fuse_request_alloc(unsigned npages, gfp_t flags)
>         }
>         return req;
>  }
> -
> -struct fuse_req *fuse_request_alloc(unsigned npages)
> -{
> -       return __fuse_request_alloc(npages, GFP_KERNEL);
> -}
>  EXPORT_SYMBOL_GPL(fuse_request_alloc);
>
> -struct fuse_req *fuse_request_alloc_nofs(unsigned npages)
> -{
> -       return __fuse_request_alloc(npages, GFP_NOFS);
> -}
> -
>  static void fuse_req_pages_free(struct fuse_req *req)
>  {
>         if (req->pages != req->inline_pages)
> @@ -201,7 +191,7 @@ static struct fuse_req *__fuse_get_req(struct fuse_conn *fc, unsigned npages,
>         if (fc->conn_error)
>                 goto out;
>
> -       req = fuse_request_alloc(npages);
> +       req = fuse_request_alloc(npages, GFP_KERNEL);
>         err = -ENOMEM;
>         if (!req) {
>                 if (for_background)
> @@ -310,7 +300,7 @@ struct fuse_req *fuse_get_req_nofail_nopages(struct fuse_conn *fc,
>         wait_event(fc->blocked_waitq, fc->initialized);
>         /* Matches smp_wmb() in fuse_set_initialized() */
>         smp_rmb();
> -       req = fuse_request_alloc(0);
> +       req = fuse_request_alloc(0, GFP_KERNEL);
>         if (!req)
>                 req = get_reserved_req(fc, file);
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 5ae2828beb00..572d8347ebcb 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -50,7 +50,7 @@ struct fuse_file *fuse_file_alloc(struct fuse_conn *fc)
>                 return NULL;
>
>         ff->fc = fc;
> -       ff->reserved_req = fuse_request_alloc(0);
> +       ff->reserved_req = fuse_request_alloc(0, GFP_KERNEL);
>         if (unlikely(!ff->reserved_req)) {
>                 kfree(ff);
>                 return NULL;
> @@ -1703,7 +1703,7 @@ static int fuse_writepage_locked(struct page *page)
>
>         set_page_writeback(page);
>
> -       req = fuse_request_alloc_nofs(1);
> +       req = fuse_request_alloc(1, GFP_NOFS);
>         if (!req)
>                 goto err;
>
> @@ -1923,7 +1923,7 @@ static int fuse_writepages_fill(struct page *page,
>                 struct fuse_inode *fi = get_fuse_inode(inode);
>
>                 err = -ENOMEM;
> -               req = fuse_request_alloc_nofs(FUSE_REQ_INLINE_PAGES);
> +               req = fuse_request_alloc(FUSE_REQ_INLINE_PAGES, GFP_NOFS);
>                 if (!req) {
>                         __free_page(tmp_page);
>                         goto out_unlock;
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 24dbca777775..8080a51096e9 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -902,9 +902,7 @@ void __exit fuse_ctl_cleanup(void);
>  /**
>   * Allocate a request
>   */
> -struct fuse_req *fuse_request_alloc(unsigned npages);
> -
> -struct fuse_req *fuse_request_alloc_nofs(unsigned npages);
> +struct fuse_req *fuse_request_alloc(unsigned int npages, gfp_t flags);
>
>  bool fuse_req_realloc_pages(struct fuse_conn *fc, struct fuse_req *req,
>                             gfp_t flags);
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 4bb885b0f032..5afd1872b8b1 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1177,13 +1177,13 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
>         /* Root dentry doesn't have .d_revalidate */
>         sb->s_d_op = &fuse_dentry_operations;
>
> -       init_req = fuse_request_alloc(0);
> +       init_req = fuse_request_alloc(0, GFP_KERNEL);
>         if (!init_req)
>                 goto err_put_root;
>         __set_bit(FR_BACKGROUND, &init_req->flags);
>
>         if (is_bdev) {
> -               fc->destroy_req = fuse_request_alloc(0);
> +               fc->destroy_req = fuse_request_alloc(0, GFP_KERNEL);
>                 if (!fc->destroy_req)
>                         goto err_free_init_req;
>         }
> --
> 2.23.0.187.g17f5b7556c-goog
>
