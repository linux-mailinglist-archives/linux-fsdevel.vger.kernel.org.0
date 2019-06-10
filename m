Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16F923BCB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 21:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389141AbfFJTOa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 15:14:30 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:47081 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389113AbfFJTOa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 15:14:30 -0400
Received: by mail-ua1-f67.google.com with SMTP id o19so3523786uap.13;
        Mon, 10 Jun 2019 12:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IyGtykocY14Ccf/Pb7GMn65evkFypDyeXC43FQG/uJM=;
        b=iGxLfyd0GjLWmcUlOrC7eeHsJSAboo5VdeQkIsunxAg8Ms7kDdxkVCEEDY3kP4xYD1
         +21CeQ8hwl4zE/dufWp1gLf092ahOaIQdwza1RUot1CM49cZQTQNT9/dVLPVfcasOnw+
         +1adBiOJ3veiPoJjxEjpxjfbBUZcHi5QRQy6V9nZEuA/cyYXY15AICjtSBm9eK9E7dma
         1jTgJpw2/Y0uG2nFLGdtV4+tt/M+ODinHrM4f24ckfUknVGLFnjEvh0BCqNsNKc7U/WK
         NZjmf+Pe++kVmIGHHSyM4y3a6teR4axhv+uevtp6yuVPqIE3aJZHzbWVNvxLz9xXMAwO
         WtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IyGtykocY14Ccf/Pb7GMn65evkFypDyeXC43FQG/uJM=;
        b=DqRJh2ZFfal2DBE/mWzTHfkg9M87MzF7a2NwTayF8P6wa6JZitx0wUhynRSx1+IIvX
         5xj+42nS4/04HAfmBbheoffrqgD4pPefpypT3Ah6/9RdvCN0+ZmI1fx7aGjNt8Lj3DzV
         s/6hOQ/jW8pof75VnFcOMi3ju6O6qm/fjsTfpvT3vkyflpSX7FDGUmwPw0fAFmI8QMS7
         4rI9iErG6C+r5kGMhUulVjniUSsemyY5ys0oUY0FC14qIGom1764d1N09PtlZtYr800R
         I6ZCK2ej+3K+mfD4nUaHWkrI3XaC3vgyGi1WfNaxnifhx2eQ7graW8dA2lmjEmtVdgfQ
         bJ6A==
X-Gm-Message-State: APjAAAWjKFGtYeHeCIh6p5HD1N33oHMunboV1k0qa3wWUKUAN5L+Hw5d
        QPV5XFLKOufUZ6XFlHFNEK9ZuMdBtg==
X-Google-Smtp-Source: APXvYqxBa5o5NGvWvlKZInrXsNGxwCGTRbVoWbIZEbgmX9sm4XiN2RN5BsLVB1jzr15bbkRrJnnk3Q==
X-Received: by 2002:ab0:1388:: with SMTP id m8mr18502081uae.53.1560194068624;
        Mon, 10 Jun 2019 12:14:28 -0700 (PDT)
Received: from kmo-pixel.hsd1.vt.comcast.net (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id t20sm4834014vkd.53.2019.06.10.12.14.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 12:14:27 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcache@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 01/12] Compiler Attributes: add __flatten
Date:   Mon, 10 Jun 2019 15:14:09 -0400
Message-Id: <20190610191420.27007-2-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610191420.27007-1-kent.overstreet@gmail.com>
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 include/linux/compiler_attributes.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 6b318efd8a..48b2c6ae6f 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -253,4 +253,9 @@
  */
 #define __weak                          __attribute__((__weak__))
 
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-flatten-function-attribute
+ */
+#define __flatten __attribute__((flatten))
+
 #endif /* __LINUX_COMPILER_ATTRIBUTES_H */
-- 
2.20.1

