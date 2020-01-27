Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD1CF14A1A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 11:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbgA0KPI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 05:15:08 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45626 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729665AbgA0KPH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:15:07 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so4678607pfg.12;
        Mon, 27 Jan 2020 02:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tfqT994o6hFKwC+NJH5VhBNOIvQ5NHGDSHAgoN5IQQg=;
        b=PYxFSJCOp4tSt1yqQ1Non9MhjGXhvzz0Q0c6Eo4PnLRd2QoSjU2mUZ0Tnf/q7M52U2
         EdBAxOQv+vy4khjwtzDYTucIWnVb09U3ZhooncfWRE1z9ZjPpNnOKjzIF3iB6zHcDGLj
         9aHheSTFbL6ikPdph8gkwdt6pC8nVe4KjRNMsAPXNVtg8KtMcxhdare/0u8JJgKMOlUM
         cwMCYNwU0WYnZ69l8tOmYSwQhr1dnRbQdnolfL2dxQXIXovbYJhBTxO5wRnIainm7gNc
         mnhy+XSfDs9MciGvm0VsKBo3KNB1/LBQRCyt/SYGrNrrUvGSefn/y1q8Mc+ZtxHYk3Fw
         Hi2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tfqT994o6hFKwC+NJH5VhBNOIvQ5NHGDSHAgoN5IQQg=;
        b=i97EENUeGjudnjKex4fwzAlFhnvVz8tkjS4KfEfgZ7z6g8HOri9P3S8iaAEIw8itVT
         gvYWgIb52o3rO6Gdp0XWhMkc72n/ljN3ZUtCZpksL/p/f9XQ/jvOyCNZWXhHoHmS2or0
         JZr/D9SPqL29f/BlGHxtsZQPQtQcx42//mF7Dsc3Q4aZZooLvrTMm4ZSTtKaVMDgtczJ
         OuOIciJGPCPuwpG5xLCpWvMSJPvJbZZeC8S5zumdMZZFNpSJsMkcg4DOwHO/2Jm0y+fO
         pgMd1EISWr1Fe0gkNufRaipb4bWeClDsso0g91TnNKOGD3xNZ9tDiMfhUyt1Rz2qoyVl
         D3qw==
X-Gm-Message-State: APjAAAXdaQIsieE91rjudDPEaYw1b8dHz6Cdy8/1geXcEZIkX0UNSAiv
        Ka7kVjNRvhTVHZ8d6EWRj4w=
X-Google-Smtp-Source: APXvYqwnlc/BTVD+zB2gkJ9TRRoZAjk4QyN2K+bRR20xZDRzGaJ5+E5yNuABM4OXiSgvvZwiMtkkaA==
X-Received: by 2002:a62:7696:: with SMTP id r144mr15571402pfc.177.1580120107229;
        Mon, 27 Jan 2020 02:15:07 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c902:a5e9:3956:8df2:aee5:9cf6])
        by smtp.gmail.com with ESMTPSA id s15sm15504138pgq.4.2020.01.27.02.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 02:15:06 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 09/22] staging: exfat: Rename variable "Size" to "size"
Date:   Mon, 27 Jan 2020 15:43:30 +0530
Message-Id: <20200127101343.20415-10-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127101343.20415-1-pragat.pandya@gmail.com>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change all the occurences of "Size" to "size" in exfat.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 52f314d50b91..a228350acdb4 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -233,7 +233,7 @@ struct date_time_t {
 
 struct part_info_t {
 	u32      offset;    /* start sector number of the partition */
-	u32      Size;      /* in sectors */
+	u32      size;      /* in sectors */
 };
 
 struct dev_info_t {
-- 
2.17.1

