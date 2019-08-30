Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 224DAA3795
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 15:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfH3NNy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 09:13:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36948 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbfH3NNx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 09:13:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id z11so6938562wrt.4;
        Fri, 30 Aug 2019 06:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JqpdhCNElm8Ik1HxewZXY9EY8Fd3DEXFwvJVx75KrYE=;
        b=n50sbYC+FgutUT7ECCoEMtCug2yBV6K89ro+gQqT6r1hIcdSjVf15jSwbB8hUCOvLP
         yZLK+P0vmE9jkvdq5ldZbdx4hSEPJCCytNdGmBacEpRTTw1qkYW//YwY7S6Q1UuB31a/
         dm6Ij3rD8rVxb1CxacJC8Ak2E0UCED4sB1R+Odygxmoh3SLjPHsV3sz57t/I/AkdnT4C
         cSrRgRFlzS/PIeUcokSHgOIxdoQzFd1MvL6OORmv8y685F4xHpFyarX8iieHU1PN2qel
         o98HwNeJ1U4ysDW4uIIAIQm6g8vWqxK4YzmC+uisxozec9BF0RdHTNDjzc1+g1wApTwF
         C3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=JqpdhCNElm8Ik1HxewZXY9EY8Fd3DEXFwvJVx75KrYE=;
        b=hGMJpa1ktkuvjdRKLYCBjd2sYLxpmTitSHejnCbrl3P0zqpVyw5F3xr52tYpNayWK3
         c68WlgGiDBpX/2Jf7K6GiL89gaj+jsWtQeHmIqCt8/yCz97oaCXKBSzWY6u1y70k4Mxl
         +a7q4aGO8KTfU8lrJNp8Zcn+aLFphe3yFhSQ2VKHjluA0z++Q1XfQNxiUD1+c5Ul3et+
         nFl3+e4f8GdiMrVU5RZgFxEettvHQZzqP21wiBKRvx93++qlhQZke2Vzk139lXBlFUZ2
         ODTj78mIYxO1VJwcNFVLsNpgui5sik9UtnkzYdGAC6eniTjzORwnKXLnnpcferHdb9NE
         T8aw==
X-Gm-Message-State: APjAAAXOTi6InGcZl8hHp4u5qoz2Eh1zLP48v1h3RPsGYWCZtKmuzCu/
        4G34WTFgRoP/r4rnQ76BMrhkQPl1z0A=
X-Google-Smtp-Source: APXvYqz6EC78MzgkBTxKRKjQA9m/g4eSPMCtfmGenxFJAPq755Flmn2cDtfuHwFVmUL3368buS/NAA==
X-Received: by 2002:adf:f304:: with SMTP id i4mr20016620wro.61.1567170831384;
        Fri, 30 Aug 2019 06:13:51 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id a141sm18323244wmd.0.2019.08.30.06.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 06:13:50 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] unicode: Move static keyword to the front of declarations
Date:   Fri, 30 Aug 2019 15:13:49 +0200
Message-Id: <20190830131349.14074-1-kw@linux.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the static keyword to the front of declarations of nfdi_test_data
and nfdicf_test_data, and resolve the following compiler warnings that
can be seen when building with warnings enabled (W=1):

fs/unicode/utf8-selftest.c:38:1: warning:
  ‘static’ is not at beginning of declaration [-Wold-style-declaration]

fs/unicode/utf8-selftest.c:92:1: warning:
  ‘static’ is not at beginning of declaration [-Wold-style-declaration]

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
Related: https://lore.kernel.org/r/20190827233017.GK9987@google.com

 fs/unicode/utf8-selftest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/utf8-selftest.c
index 6c1a36bbf6ad..6fe8af7edccb 100644
--- a/fs/unicode/utf8-selftest.c
+++ b/fs/unicode/utf8-selftest.c
@@ -35,7 +35,7 @@ unsigned int total_tests;
 #define test_f(cond, fmt, ...) _test(cond, __func__, __LINE__, fmt, ##__VA_ARGS__)
 #define test(cond) _test(cond, __func__, __LINE__, "")
 
-const static struct {
+static const struct {
 	/* UTF-8 strings in this vector _must_ be NULL-terminated. */
 	unsigned char str[10];
 	unsigned char dec[10];
@@ -89,7 +89,7 @@ const static struct {
 
 };
 
-const static struct {
+static const struct {
 	/* UTF-8 strings in this vector _must_ be NULL-terminated. */
 	unsigned char str[30];
 	unsigned char ncf[30];
-- 
2.22.1

