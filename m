Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8935BC18D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 04:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiISCwX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Sep 2022 22:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiISCwW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Sep 2022 22:52:22 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 245461015;
        Sun, 18 Sep 2022 19:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=P6b0s
        MOaHLyvaSYFu9NkNYGexGgxBeHW674D41BwmR8=; b=nvJBvgiajnsutlQ1lTHoo
        1azDoftmubSSslR3NQkWQfy4qJ8SxnonMNgjNRxPskRpPdHuGJBtFseUYpt+MBu2
        An0W/BaNaq3u1pV1CHHUc1S5n16waFfZx0TP/DEYc17+iqE9w2zxI4pg5n9TJii5
        XM0x7XpOesZ/0qu6y4jEf4=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp3 (Coremail) with SMTP id G9xpCgDHq2dH2Sdjyx55ew--.40217S2;
        Mon, 19 Sep 2022 10:51:53 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     viro@zeniv.linux.org.uk
Cc:     ebiederm@xmission.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH] fs/binfmt_flat.c: use __func__ instead of function name
Date:   Mon, 19 Sep 2022 10:51:39 +0800
Message-Id: <20220919025139.3623754-1-13667453960@163.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgDHq2dH2Sdjyx55ew--.40217S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JrWUXr1Dtw4UtF47GF17Jrb_yoWfGwc_Ca
        4I9rZrKFWDtrWrZF1v93yYgF1jgan29r4fWFnxXr1ak3yUJ398Za4kJr4xKry5X34jgr4k
        uFZFgasFywnIyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1xnY3UUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbivgCB+1ZceuzkxAABs5
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

It is better to use __func__ instead of function name.

Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 fs/binfmt_flat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index c26545d71d39..4104c824e7b1 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -184,7 +184,7 @@ static int decompress_exec(struct linux_binprm *bprm, loff_t fpos, char *dst,
 	z_stream strm;
 	int ret, retval;
 
-	pr_debug("decompress_exec(offset=%llx,buf=%p,len=%lx)\n", fpos, dst, len);
+	pr_debug("%s(offset=%llx,buf=%p,len=%lx)\n", __func__, fpos, dst, len);
 
 	memset(&strm, 0, sizeof(strm));
 	strm.workspace = kmalloc(zlib_inflate_workspacesize(), GFP_KERNEL);
-- 
2.27.0


No virus found
		Checked by Hillstone Network AntiVirus

