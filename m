Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665D32F0690
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Jan 2021 12:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbhAJLMM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Jan 2021 06:12:12 -0500
Received: from m12-14.163.com ([220.181.12.14]:56505 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbhAJLMM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Jan 2021 06:12:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=K5bd1iSxuYjB1QAwRo
        5MXHF/8joiWC6BSPtbOExVNhM=; b=oFdka2Ci4Fge1pFWxBTCecZTUoMMVYgkE2
        5rQYUB/N4fM8p4j+bx1h9Iojti8D+KAlg4NOKCwVtIdU3VA4IkrlhDuJBheeCMcA
        jT+AlOPVGYtenzlHpVQXJ5/UXEF7Vi6B8d1Od/GEkJJVhN22HkuNUq8d+h/A5A3l
        Y0ZIyyqqs=
Received: from localhost.localdomain.localdomain (unknown [182.150.135.160])
        by smtp10 (Coremail) with SMTP id DsCowAC3r3g6vPpfVkx6fQ--.64249S2;
        Sun, 10 Jan 2021 16:35:06 +0800 (CST)
From:   winndows@163.com
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liao Pingfang <winndows@163.com>
Subject: [PATCH] fs: Remove the comment for argument "cred" of vfs_open()
Date:   Sun, 10 Jan 2021 16:23:15 +0800
Message-Id: <1610266995-5770-1-git-send-email-winndows@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DsCowAC3r3g6vPpfVkx6fQ--.64249S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrWrZw15ZFW7ZrWkAFWfuFg_yoWxtwbE9a
        y0yrWkW3yrJr1rGa48CFsaqFWIqr1fCr1rCayrXws7tFn5X3W5uFyqy34xtryUZr9rWF4D
        trn8XryDuFW0kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjfcTtUUUUU==
X-Originating-IP: [182.150.135.160]
X-CM-SenderInfo: hzlq0vxrzvqiywtou0bp/1tbiMBoWmVWBwsDEywAAs8
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Liao Pingfang <winndows@163.com>

Remove the comment for argument "cred" of vfs_open(), as
it was removed.

Fixes: ae2bb293a3e8 ("get rid of cred argument of vfs_open() and do_dentry_open()")
Signed-off-by: Liao Pingfang <winndows@163.com>
---
 fs/open.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index 1e06e44..6935570 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -923,7 +923,6 @@ char *file_path(struct file *filp, char *buf, int buflen)
  * vfs_open - open the file at the given path
  * @path: path to open
  * @file: newly allocated file with f_flag initialized
- * @cred: credentials to use
  */
 int vfs_open(const struct path *path, struct file *file)
 {
-- 
1.8.3.1


