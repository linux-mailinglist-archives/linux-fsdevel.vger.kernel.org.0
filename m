Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A12388F60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 15:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353744AbhESNoa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 May 2021 09:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhESNo1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 May 2021 09:44:27 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C63C06175F;
        Wed, 19 May 2021 06:43:07 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4FlYwS5pxlzQk2f;
        Wed, 19 May 2021 15:43:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :subject:subject:message-id:from:from:date:date:received; s=
        mail20150812; t=1621431781; bh=ttyp6Kk2R+cQvSwEK9gUMWNVesKTXEtq6
        3Ecj0gG628=; b=jNMbvS5zlIqNhiW7xX59wDM5+pEDaSy3vkRNXVJSnOj+/kekc
        E7E8h07sptnZ7NZPIUu6i7bh77dQUkOIsLWfn1ZzMo2MSyXEcT4iBGj8W6yT4BaG
        ceGn6Q0h9qWEPIHsm484xkTe5acPGPqgYeeh7PV7xeH7V60Qky2je/tMtZryCDcU
        fZHEHKSlyL0iqd5nHjuNIgcusT//JZ/gd/IqmmoUPVExivS7dKSd5J8fjoebw0O3
        nHNczq3hQPi0XxpaxvcXbTldZCTIic58ko6f5v98ZEIrmXwqNkTTpUF4gmjmxYb9
        4t6EFuT7//o3IqOiXNRAWgg2omgYG8ssMZKvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1621431782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mI0z5gEoJ9LMp+eu981apD+8Gp8qyGV4NzJEqk+besc=;
        b=TjVwTDPL5dDMJ5wC+6YRth3e8Z2VMI78iHIqTIpVwc37kYfAn1XNjlV0flUBs149tuZVBg
        BsZhUcH7XjqdMDnUxGmTp3tAUYyZJH/o+VSBdTmgfBKhxXalTAvzpaTLfbOtnmQO0qCeiq
        Tsv5986777QOorS/PPiyTcMl993+lX+pYe6BWpVGPImpV9M4uv0ai4hSJMCCXftiKF/rvu
        mU92HivnLQAXnIuCQIgMS2eFkdXNDU8385zg3TMFLqwJxMhswDtqPhRk+hRl4BK/1sA3vk
        PJS6lsuZAXFpFFrcY5pmZe6+397wswo8HobouB2fEPR5c09LbWLsxHkznlBDjg==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id CL_zuBgb40is; Wed, 19 May 2021 15:43:01 +0200 (CEST)
Date:   Wed, 19 May 2021 15:43:01 +0200 (CEST)
From:   torvic9@mailbox.org
To:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "almaz.alexandrovich@paragon-software.com" 
        <almaz.alexandrovich@paragon-software.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Message-ID: <212218590.13874.1621431781547@office.mailbox.org>
Subject: [PATCH] fs/ntfs3: make ntfs3 compile with clang-12
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -0.58 / 15.00 / 15.00
X-Rspamd-Queue-Id: CD0EB1822
X-Rspamd-UID: aeddd9
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some of the ccflags in the fs/ntfs3 Makefile are for gcc only.
Replace them with clang alternatives if necessary.

Signed-off-by: Tor Vic <torvic9@mailbox.org>
---
 fs/ntfs3/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletions(-)

diff --git a/fs/ntfs3/Makefile b/fs/ntfs3/Makefile
index b06a06cc0..dae144033 100644
--- a/fs/ntfs3/Makefile
+++ b/fs/ntfs3/Makefile
@@ -4,7 +4,9 @@
 #
 
 # to check robot warnings
-ccflags-y += -Wunused-but-set-variable -Wold-style-declaration -Wint-to-pointer-cast
+ccflags-y += -Wint-to-pointer-cast \
+	$(call cc-option,-Wunused-but-set-variable,-Wunused-const-variable) \
+	$(call cc-option,-Wold-style-declaration,-Wout-of-line-declaration)
 
 obj-$(CONFIG_NTFS3_FS) += ntfs3.o
 
-- 
2.31.1
