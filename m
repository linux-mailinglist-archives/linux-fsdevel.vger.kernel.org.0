Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB90446BA18
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 12:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhLGLdl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 06:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbhLGLdl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 06:33:41 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A17C061574
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 03:30:10 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id y12so55415371eda.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Dec 2021 03:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5cPbhWFPwXaqq4htZJISVANKkHGi3pC0ganou1u6vI0=;
        b=UqgXXezgcknKmw/HX7teVWXl8sZnn1eAyOQ2IIIEfMQjAYPMe1hbZQeU+WQaNvS7Z7
         4z21vaszIj5i+2PRxcbEPw4biq+drbMZz1Rm43Za8duLAN/FToau8czGj5s2pxvPbKQE
         VIijrW2ma/W+bE1FeTNRfGpCzjUwXKXcJuxGIgtXobdJI3aPEnFc/Vf46YgoarZ+KWi8
         frLByfSQIR0RbJWDGTxHyyw75xaN4KgEpceNhU2pw2ITtRaGus4jg/K8wh+RA67IEeEa
         TMPMkCRczvEOaZb4GUjwKw5/aJ5WA+C2NBa21yQQDz375V4omxK93TaTFRhPIKkwD9mf
         cyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5cPbhWFPwXaqq4htZJISVANKkHGi3pC0ganou1u6vI0=;
        b=gRCrrkQzsjQ8MpqWfvRIsVi6MqC+aEIcP3Cs2tCXJvPQkGfUvtVigZwX98I2TdNVT0
         CLUqdQKvoZjN3+PabQwq42CaZACfSIpAtJuhT0weBzptdsI/11Ijb2CmoF94kxjlQNHD
         T2b6nh7QWSwGTWtv+qv+ywqy3a32/l6SR/Utn35YUu96QbL3SsV1P+3ALEyBXAtAcsHt
         VQhzBLFvOq6G+vIVHyAFkzfEEo4NgQVOWtofBqF0Z47YIrWivbkN6vs7lEZrBvlgE8r6
         0qGNcnJYaRJCS9R8Pf8SRUnAOdcBmoguM5dC2enX0W9LK0r9DUUT2p9IxeoSw3s+FKNx
         QcAA==
X-Gm-Message-State: AOAM532YxoR20QluzX+OSATyvWOW/wWKtFX4huAv09BX2WeC//zdzNvm
        KsowFOKclTI6FZHhp16OEVT+Uwmn7kTvxesTb+APtZeFcg==
X-Google-Smtp-Source: ABdhPJz6Lb8eTkKKRYp/oHVE2lMMN5Xkkj8RuCFVlmolV6o52jTNO9jYVjfc3YW+KchikGBJ5WNar1Fh3JT/776tAro=
X-Received: by 2002:a05:6402:90e:: with SMTP id g14mr8433179edz.49.1638876609521;
 Tue, 07 Dec 2021 03:30:09 -0800 (PST)
MIME-Version: 1.0
References: <20211122090531.91-1-xieyongji@bytedance.com>
In-Reply-To: <20211122090531.91-1-xieyongji@bytedance.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 7 Dec 2021 19:29:58 +0800
Message-ID: <CACycT3vHBUpSsDEseovmJHJm3o=pcKcOEee7J-1eumUomJO00w@mail.gmail.com>
Subject: Re: [PATCH] fuse: Pass correct lend value to filemap_write_and_wait_range()
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ping.

On Mon, Nov 22, 2021 at 5:07 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> The acceptable maximum value of lend parameter in
> filemap_write_and_wait_range() is LLONG_MAX rather
> than -1. And there is also some logic depending on
> LLONG_MAX check in write_cache_pages(). So let's
> pass LLONG_MAX to filemap_write_and_wait_range()
> in fuse_writeback_range() instead.
>
> Fixes: 59bda8ecee2f ("fuse: flush extending writes")
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  fs/fuse/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 9d6c5f6361f7..df81768c81a7 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -2910,7 +2910,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>
>  static int fuse_writeback_range(struct inode *inode, loff_t start, loff_t end)
>  {
> -       int err = filemap_write_and_wait_range(inode->i_mapping, start, -1);
> +       int err = filemap_write_and_wait_range(inode->i_mapping, start, LLONG_MAX);
>
>         if (!err)
>                 fuse_sync_writes(inode);
> --
> 2.11.0
>
