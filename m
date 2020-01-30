Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE19214D8B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 11:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgA3KLx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 05:11:53 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54524 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3KLw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 05:11:52 -0500
Received: by mail-pj1-f65.google.com with SMTP id dw13so1115783pjb.4;
        Thu, 30 Jan 2020 02:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X6B408HVKqVgRddttBmZ/lvRWns0/HwPdIVXoXJfH4E=;
        b=c7Ivzmp3oKr9rXKl5OoQ+47r/bqWcTqeLMbGis525KSXrrwn5BJAXMMnvQO+EazbD3
         X5N2jpP6TPpE8o8Pt4eegtqRL8G+8OGJc2+VcTE/9JGHzn/CiJ0unLnKfyYp7MCG5FY8
         rwUNbQtWuxAeXcDjZSQKQqBdFGC49jLIYcBVf08jjdq8nQRuVBMtZaCGyu51ylbvZW4m
         QMQ3RAjCRwWUnI0KJtypR16+rL6mwc0xlHgSnTdTcYOHIBplOXXgWcDoGNNparelJ8Ez
         8Tek53F5EtaApt7IpJ3IXru3ktvF/2n3MduFNH38D3wpg+h5QMlvHvjTvUQWhdPxSgG1
         KY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X6B408HVKqVgRddttBmZ/lvRWns0/HwPdIVXoXJfH4E=;
        b=UGKm1x3Cgi9pYe3sQ0bvIpIrEfFHKOxq0vgKnWUoCtbAb0VhHsrBqry5kFiQQo0e2N
         yWg+W9/5DxwlEl3uQCy2SLQxWs/6IOMW3nxiBcjjR2bq49lZT51sMVPrGzJvViTCrpiV
         Dsena/UQwR5tijhG3rRGmXSfBGP699UN7ipn4rOpXvIq9XXCP39hJVoDg1Qm2RnZtldU
         FuRNgkrwK8F1mJBp/Fr7m3rnT6/1r7kwcU6aHbsRypGcA2BzL/xVxpPF/g/1XzozyvbO
         Hzl6gXznBCwUobXp8JZSaX9/OrOuZTFWk5hU/3r6hRzxGoRRTMHxYzF9J4UVmUSdK332
         KyGQ==
X-Gm-Message-State: APjAAAVbFJkJ1zikYx8VylrzZX9ZAwGEwp+25q5/25dsJkTaBt9xGuEG
        0X9qvaZgD11Yx71xv9rwq+Q=
X-Google-Smtp-Source: APXvYqyKkr61j+ElMfljiMs2BCzPRuQOnrAi43XYT2V9n8VWhg2yQWg72wstJF6J7ByCuUJYQ/ALuw==
X-Received: by 2002:a17:902:8a89:: with SMTP id p9mr3924542plo.286.1580379112493;
        Thu, 30 Jan 2020 02:11:52 -0800 (PST)
Received: from localhost.localdomain ([2405:204:848d:d4b5:49ce:a9e3:28b5:cf94])
        by smtp.gmail.com with ESMTPSA id k21sm6239683pfa.63.2020.01.30.02.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 02:11:51 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-fsdevel@vger.kernel.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 2/2] staging: exfat: Remove unused struct 'dev_info_t'
Date:   Thu, 30 Jan 2020 15:41:18 +0530
Message-Id: <20200130101118.15936-3-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200130101118.15936-1-pragat.pandya@gmail.com>
References: <20200130101118.15936-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove global declaration of unused struct "dev_info_t".
Structure "dev_info_t" is defined in exfat.h and not referenced in any
other file.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index b29e2f5154ee..1ae4ae4b3441 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -231,11 +231,6 @@ struct date_time_t {
 	u16      MilliSecond;
 };
 
-struct dev_info_t {
-	u32      SecSize;    /* sector size in bytes */
-	u32      DevSize;    /* block device size in sectors */
-};
-
 struct vol_info_t {
 	u32      FatType;
 	u32      ClusterSize;
-- 
2.17.1

