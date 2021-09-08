Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94050403286
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 04:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346165AbhIHCPE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 22:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbhIHCPD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 22:15:03 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E658EC061575
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Sep 2021 19:13:56 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id i23so707933vsj.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Sep 2021 19:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mYGapVyDnk506xAffOvf1hKUDBjjZS0jc0pPzJOXHDQ=;
        b=Bza4HNDpEHulU3zNOJyfTmoQbm2j1SEoAVd7vxAxqijtrLVTt5R44qcT2ozuYbKmQo
         XwhTdZMPnKIjPQ7JxdgipL2X030bssuPqcyQxgotHlVa70D7dLBtZym0iWsi3259uGki
         oj4N1ckYIhAPLuy2s1JZOlS9d3NdLpye/C2h46o85Mkc40yKmUTZErHJOvT+6DnfgH/Z
         Dtz7bPap6yDh8jH1J2cAUMGegf09ioP9IRaRkxeaeK/MPYXJvsoRiMZUbBpnebEzplcl
         n8Hp7ByBg9wHkalgbhxY7O4XaLwSOZ2ZFb2uBYc7ALQ3HWOOIXSZIlzu5KUQ1d7FKjkK
         ph3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mYGapVyDnk506xAffOvf1hKUDBjjZS0jc0pPzJOXHDQ=;
        b=AGvel+bJuHuhSd79Kaifq2BMtM4BhGRwJJHx0VHRdAn+KdF3nrcbHOHWEne3ID1P2u
         oBJXD+LTtpdnC03td7Z7UYUO2+pia6z6rp+dZFfW9NTbxanSiRBSi+EVlgskJqhOJQAs
         hNdWxG6LpmRNOTizH4wsC/W46OLbv/OJWF9KPmkM9ZCfPjRfvhxJjgL9L5QUWTQnAOxu
         bQ++1FD0aZg7XO3NBVb3AQuvxcOB3VKsIwHoOqHz+X4+1sUUOkJAe3+UXgJjpLbR0U8F
         TQkv9jNxwx5zkQO3bb9JNERRd2pKiuKI/B/L3do1rLIVwoYU7L5y71xQep0LHQ8dEnpM
         icog==
X-Gm-Message-State: AOAM532abvSkhYiqbUJwWm2evQYTidinhjhQxI5sXX6hDZSG9Jsp/Brr
        SRZ5pt/nX0AQeTojiE3IBYPpjK+fqM8Htl1UwpUdjLahvquq0Q==
X-Google-Smtp-Source: ABdhPJx9Xehb9rEihsKc7gZZB3KuM3vUsqcPHgoR1GCrZxqaASgC6FPRzYdLTx/eAo3MR/9FezKSpmaRnDjoOv1Cnvs=
X-Received: by 2002:a67:7347:: with SMTP id o68mr758587vsc.17.1631067235647;
 Tue, 07 Sep 2021 19:13:55 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Peng <flyingpenghao@gmail.com>
Date:   Wed, 8 Sep 2021 10:13:28 +0800
Message-ID: <CAPm50aKijR9YHAWST0Vk_2+rHMaN+1Kr0bkhctVm0+K1rYGd-Q@mail.gmail.com>
Subject: [PATCH v2] fuse: Delete a slightly redundant code
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Peng Hao <flyingpeng@tencent.com>

'ia->io=io' has been set in fuse_io_alloc.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 fs/fuse/file.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 97f860cfc195..624371ee9263 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1447,7 +1447,6 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io,
struct iov_iter *iter,
        if (!ia)
                return -ENOMEM;

-       ia->io = io;
        if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
                if (!write)
                        inode_lock(inode);
--
2.27.0
