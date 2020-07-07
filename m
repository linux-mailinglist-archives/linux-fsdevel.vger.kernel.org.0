Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A85921657A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 06:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgGGEmH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 00:42:07 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:13215 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgGGEmH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 00:42:07 -0400
Date:   Tue, 07 Jul 2020 04:42:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1594096924;
        bh=U/Ns4VBGNbxu/JuVEgnp523kGbpu1b/VJelFpdvqLlc=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=Yz8w+8Bwjbfs3mXz8sH0vt+W1vn+e/hbTeFpkm54K+DMtYq8gUCAuiZY8gxEUFZVD
         9NYnA3wU0Oe420NjwMAuSQ7bnOuKwooimnadaKQSo6oojQv1iysDBSAy7t6nv0YHFT
         LWDfl8mNNmrNwTA8q+n11evXKaidv8gJEoFJEiAc=
To:     viro@zeniv.linux.org.uk
From:   Colton Lewis <colton.w.lewis@protonmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Colton Lewis <colton.w.lewis@protonmail.com>
Reply-To: Colton Lewis <colton.w.lewis@protonmail.com>
Subject: [PATCH] fs: correct kernel-doc inconsistency
Message-ID: <20200707044148.235087-1-colton.w.lewis@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.protonmail.ch
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Silence documentation build warning by correcting kernel-doc comment
for file_sample_sub_err function.

./include/linux/fs.h:2839: warning: Function parameter or member 'file' not=
 described in 'file_sample_sb_err'
./include/linux/fs.h:2839: warning: Excess function parameter 'mapping' des=
cription in 'file_sample_sb_err'

Signed-off-by: Colton Lewis <colton.w.lewis@protonmail.com>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3f881a892ea7..15f430c800dc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2827,7 +2827,7 @@ static inline errseq_t filemap_sample_wb_err(struct a=
ddress_space *mapping)
=20
 /**
  * file_sample_sb_err - sample the current errseq_t to test for later erro=
rs
- * @mapping: mapping to be sampled
+ * @file: file to be sampled
  *
  * Grab the most current superblock-level errseq_t value for the given
  * struct file.
--=20
2.26.2


