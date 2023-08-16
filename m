Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E8D77D908
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 05:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241559AbjHPD2b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 23:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241551AbjHPD2K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 23:28:10 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8040A199D;
        Tue, 15 Aug 2023 20:28:06 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RQYVl0n64z4f3l2m;
        Wed, 16 Aug 2023 11:27:59 +0800 (CST)
Received: from ubuntu20.huawei.com (unknown [10.67.174.33])
        by APP4 (Coremail) with SMTP id gCh0CgDnwqU7QtxktkBHAw--.44168S2;
        Wed, 16 Aug 2023 11:28:02 +0800 (CST)
From:   "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
To:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wang Lei <wanglei249@huawei.com>,
        gongruiqi1@huawei.com
Subject: [PATCH] doc: idmappings: fix an error and rephrase a paragraph
Date:   Wed, 16 Aug 2023 11:32:10 +0800
Message-Id: <20230816033210.914262-1-gongruiqi@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnwqU7QtxktkBHAw--.44168S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFy7AF43Zr1Utw1UuF17KFg_yoW8Ar48p3
        yrtFsrKa1Yva4j9w1xArWIgFyjvas5uw4UAFyDJw1rZr1DGF9Fyr4IkF10qFyrZ3ySkFWa
        vFW29rWj9r13twUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJV
        Cq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
        daVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: pjrqw2pxltxq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "GONG, Ruiqi" <gongruiqi1@huawei.com>

If the modified paragraph is referring to the idmapping mentioned in the
previous paragraph (i.e. `u0:k10000:r10000`), then it is `u0` that the
upper idmapset starts with, not `u1000`.

Fix this error and rephrase this paragraph a bit to make this reference
more explicit.

Reported-by: Wang Lei <wanglei249@huawei.com>
Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
---
 Documentation/filesystems/idmappings.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/idmappings.rst b/Documentation/filesystems/idmappings.rst
index f3d168c9f0b9..d095c5838f94 100644
--- a/Documentation/filesystems/idmappings.rst
+++ b/Documentation/filesystems/idmappings.rst
@@ -146,9 +146,10 @@ For the rest of this document we will prefix all userspace ids with ``u`` and
 all kernel ids with ``k``. Ranges of idmappings will be prefixed with ``r``. So
 an idmapping will be written as ``u0:k10000:r10000``.
 
-For example, the id ``u1000`` is an id in the upper idmapset or "userspace
-idmapset" starting with ``u1000``. And it is mapped to ``k11000`` which is a
-kernel id in the lower idmapset or "kernel idmapset" starting with ``k10000``.
+For example, within this idmapping, the id ``u1000`` is an id in the upper
+idmapset or "userspace idmapset" starting with ``u0``. And it is mapped to
+``k11000`` which is a kernel id in the lower idmapset or "kernel idmapset"
+starting with ``k10000``.
 
 A kernel id is always created by an idmapping. Such idmappings are associated
 with user namespaces. Since we mainly care about how idmappings work we're not
-- 
2.25.1

