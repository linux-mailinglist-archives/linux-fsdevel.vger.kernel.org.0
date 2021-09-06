Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2AB5401B3C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Sep 2021 14:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241292AbhIFMdX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Sep 2021 08:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241352AbhIFMdW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Sep 2021 08:33:22 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6488C06175F
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Sep 2021 05:32:16 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id h13so2147680vkc.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Sep 2021 05:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=vmaLXCceUgYd7Eo66XLzeRY3nlF86NFNdkzCDTKGKoA=;
        b=cJHEGtJ/oKgYHgcHkT1m3pcx8X3cJvILajbXWXUnT+1Ryertqbfm1we7uqTLMXpcDT
         hWJq0hvag4LJIDsbywYIs7chtr0PJBwwOpSopOz0j8foCDW76IclGS719fBi/S4sZQsh
         eqaFu7bdQKEWu1DU4Ik5ljdjghc3KUSQyqukRY1v7iGfZwCPHiopYbF0g6CUtcX2jJ4k
         GNnvJ57C34ZGty4S1/ULVCBgCU2ImiD7Vj+kx8n1KPV/rhslU6IJzvD6iVLTrfrAw/jX
         NmNoOUrZB35qx+JwH93ndX1GsEygyBPMy0HDPwXJaO0M0J7Ep0QJ/ci+36Kfjx3WjNh3
         mXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vmaLXCceUgYd7Eo66XLzeRY3nlF86NFNdkzCDTKGKoA=;
        b=DpDl5NbEKJKfBerA/pnyrSdfEf/2+qhMcFK3nKW97HRDEkPJ2s7Sxlkgy25G7IaKne
         9nsUr7/h9z+ap4JktTyzT6BSbtXGoZBk5Psqvat23enKm/VrPDw7ahE6l59IveXacXRj
         7FeGDZHFkXMb8eNqghaE5buGcEdRJNKhUg1BJXSy5f6ma5a4u9x5Igerz4ecpPk9ZTdt
         A8tH2Mwzj2LaIc/0wKojFdzQwZEyrHsUK/HUqf45fUqOaIdBi8fxBc4nM5n4PVSrjACy
         Osl2vaZbv8x2hvEFUrRu/B66h8GTGx5kgy4asg9xp6YOXLJPuOZ1LAvuaTmptCuZgBVA
         mPdg==
X-Gm-Message-State: AOAM533Clw7r41UPX9ExWBnqudpCU02q3S7nDJX94/qdLkgF7U6jtwFj
        wbLJp/VeDd5wCnxb/krIXnUEuqdySlsP/tiCT9knkPnJZDL5Lg==
X-Google-Smtp-Source: ABdhPJyT5/okj2cAcG+LQkvU54jMsGTimmqASga/6f0Jo7dhYF0fgzQNOwND/P3DxYhPNMqJSCJBGNhy9CsVJw76Q+A=
X-Received: by 2002:a1f:2f87:: with SMTP id v129mr4837882vkv.4.1630931535749;
 Mon, 06 Sep 2021 05:32:15 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Peng <flyingpenghao@gmail.com>
Date:   Mon, 6 Sep 2021 20:31:48 +0800
Message-ID: <CAPm50aLQxAdrWz4PR=fVYJC-eT0pjEp4HEhHxALfaJJT1TH2eQ@mail.gmail.com>
Subject: fuse: Delete a slightly redundant code
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
