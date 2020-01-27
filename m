Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4667114A1A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 11:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbgA0KPE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 05:15:04 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:50435 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729665AbgA0KPD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:15:03 -0500
Received: by mail-pj1-f68.google.com with SMTP id r67so2777622pjb.0;
        Mon, 27 Jan 2020 02:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AitQYCHf6tUjsn7NRhdLF1drVubm/tGD+X9MQ1jiBMc=;
        b=VKG4rCKKhwl0kRIVgfh9P0bQ9spE8pIbngs0nVkLbHI6tOuriZ6ezeeVMcY+nDyxR1
         VyiaEGc7hQucLoIj0pjvsmZZrPBXpT5fQr3ogIooOIchunKMpdIVlzPMRoCG+7EipP8y
         KUi4vnCYuWrX4LXv1HD/u/UjHwSyNn3/AWEnSrqw5US81SfwULZ1A+b3XfFZcd8suopm
         PRTkfETjN+x2T/l1Y6BgT4qjgvoXL3cYwev9m4sCWXRj8Cu+h1bM5Wug98sAKGp5Pz2S
         NCnUxQEI7rWKVhyjN9aWUTZDZ2nlxnHUlqgkjGW2wC5zM+vHgFlmNPdYdJh91H8ZV5zD
         0P8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AitQYCHf6tUjsn7NRhdLF1drVubm/tGD+X9MQ1jiBMc=;
        b=LDF9WWZbwVAqsGpwyUkjjm/GuE0v4loc5Kwc+b6KYxM00TOlZbsaAbEhgW6VNz80CN
         vrIO1EXXDl5XtQIdrTNSU+43IFoZRBx9icmQT9ZLmEMWjAAda9r4FWgbj342MVGTaYS8
         WEWir+UYs2c3kAz1KzSN6ZOfGyrPDeGiSaD23eI5EzOE1XmXam3omG8XAf/3F+NB4Pxl
         fD6DFEBFT7c2JiHhnYgwS0v4lkSTI49OaojIy4ZYekIlga9iE0mLJ+Nc4OUex3fDTRKn
         8r57KISd5MULoNFmDZ4wUkNIl3kKXGjQdZSlUgGBzpG+XtGJiikIvl1DGOp7GTVyBJKE
         yxgw==
X-Gm-Message-State: APjAAAUwg/T/0Bjr3LjMN5d6X1gltcxdF8QYoyyG++vxxGdtHx/nTKAx
        P7BlxEs77xKVswZ2t2VD918=
X-Google-Smtp-Source: APXvYqw/i5njE6bo4f9KyNLe9qSTRXFypn1z24HWyZ8LaW3Mk1dEvv655DAiNneAsdT/C9RnYjAhOA==
X-Received: by 2002:a17:90a:ff02:: with SMTP id ce2mr1162916pjb.98.1580120102329;
        Mon, 27 Jan 2020 02:15:02 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c902:a5e9:3956:8df2:aee5:9cf6])
        by smtp.gmail.com with ESMTPSA id s15sm15504138pgq.4.2020.01.27.02.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 02:15:01 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 08/22] staging: exfat: Rename variable "Offset" to "offset"
Date:   Mon, 27 Jan 2020 15:43:29 +0530
Message-Id: <20200127101343.20415-9-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127101343.20415-1-pragat.pandya@gmail.com>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change all the occurrences of "Offset" to "offset" in exfat.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 5c207d715f44..52f314d50b91 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -232,7 +232,7 @@ struct date_time_t {
 };
 
 struct part_info_t {
-	u32      Offset;    /* start sector number of the partition */
+	u32      offset;    /* start sector number of the partition */
 	u32      Size;      /* in sectors */
 };
 
-- 
2.17.1

