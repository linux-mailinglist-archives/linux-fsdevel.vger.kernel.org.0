Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 585271893CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 02:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgCRBnP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 21:43:15 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33638 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbgCRBnP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 21:43:15 -0400
Received: by mail-qk1-f196.google.com with SMTP id q17so11539729qki.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2020 18:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e8mUgYv+VKT2lr8NVjxyrZkvepp6x+zOsg4I0gqSpQ8=;
        b=bK7HSU7nkxVi8N68R6DfHPbiWxaVW78DHfW/0t4Y0v+5qyL8eg51xPR3nZ0Wzg6Bt7
         Qhv7Ahge/U9gbih6y8vJA57rgTTXLEzfHKO2gxOZ7hl0RL6//bv80luVlUmheoYwj9JQ
         IgG7O9rlJvhbh+Rni//aek0qY84uUPEVJiNaWVbt2spo9UOr3ILhXYqBZPgHCMrE706f
         6QdqN74tZAqbnqTLQpHRwyL28Kf8xiqEwo/xXtIiVwBIQosDann+ji+kwB1FNGZH5uT1
         +Gi+Ruwakj7VqvwX1dxSpZXAJFQAvEoL/7mbZyYRdOKXTCA9HTEabCWLiFqRitq75pGD
         odMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e8mUgYv+VKT2lr8NVjxyrZkvepp6x+zOsg4I0gqSpQ8=;
        b=G5HbLFrBffZeCKGUWxyunO5WaTjxnDk289VgRoqCRvnuWYdUQL13yye7sBsabovlUH
         smcinjpV3cCgdh4LMQrCpiyAbCshs3/uHvmgBNV3EqwxsiHmEULruQT8CdEF4TpCPENl
         YkVNVL3ZKRHArM+Ganso3i+Ri373w9CatJkLp44MBqwVVG2+P5rzdzjFlEHFLc0m67JN
         ihu5qUEsPH/pYSMy2Lt4tH4s32NkCl0VLuBBLuBiyBegFYnj7s0u/TKeNmCTpGMnZqd+
         HPghUwb9egQol5+UVx4+jLXiq56JemkodNJZYwdPE4MqcgiL/ek9V8JGvGYVa0sn2ROZ
         x+LQ==
X-Gm-Message-State: ANhLgQ1ex+dZbHLV9LnHh8LUbFQd71S4ZzTsURepmPZodXv+FPPsuMo2
        jK8CXA+SkCngE4zIAvjdeE9QcQ==
X-Google-Smtp-Source: ADFU+vv33OmGqzWo180ijpGFSaQFry+2s8NTwr1853i6DLNMIoAIbKnqoq618kLR2Mp5a55kGPz7gQ==
X-Received: by 2002:a37:d285:: with SMTP id f127mr1829475qkj.107.1584495792610;
        Tue, 17 Mar 2020 18:43:12 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id m1sm3740883qtm.22.2020.03.17.18.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 18:43:10 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
Cc:     willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH 2/2] xarray: Add missing blank line after declaration
Date:   Tue, 17 Mar 2020 22:43:03 -0300
Message-Id: <7efa62f727eb176341fc0cdfcd47c890ff424451.1584494902.git.vitor@massaru.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1584494902.git.vitor@massaru.org>
References: <cover.1584494902.git.vitor@massaru.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: "WARNING: Missing a blank line after declarations"
in include/linux/xarray.h:1504

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
 include/linux/xarray.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index a7dec1ec0967..61f83aca2326 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1624,6 +1624,7 @@ static inline unsigned int xas_find_chunk(struct xa_state *xas, bool advance,
 	if (XA_CHUNK_SIZE == BITS_PER_LONG) {
 		if (offset < XA_CHUNK_SIZE) {
 			unsigned long data = *addr & (~0UL << offset);
+
 			if (data)
 				return __ffs(data);
 		}
-- 
2.21.1

