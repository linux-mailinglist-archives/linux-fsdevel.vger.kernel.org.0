Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3D24690EC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 08:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbhLFHvc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 02:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237150AbhLFHvb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 02:51:31 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5AAC0613F8;
        Sun,  5 Dec 2021 23:48:03 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id o14so6522113plg.5;
        Sun, 05 Dec 2021 23:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vIsldLhCmZH7wKYOXMosoXmaGOAAlbldleWN7ENAInA=;
        b=bAVZy+n2NWzFrRWUPTBkg4SvcY7CRtt/abHIsPeRPa5LOddWdWJO7/57Mvseg9APlk
         9Q+TebS7S7KW8Lu7P4RO47ow1QBwSB+EsxlUpXmWSiM3UgaJztTwtTpa8+2/obP6wTBL
         RVfyxAS4wFsWIOgzAOFg93tVU3Z46yv26gCEvBIUMPYMvGgRSaTBYkueBy4X/mggcjL3
         TRX7xoqMhtjdeSAQEylSKmM+deWTOgv/M7MXwZJDUSz2KjC7kN/NFZacxdKhl0C9O8sn
         ghjfaWfe6LzBkwmTSz9Vo+z7zimhvbpLBBEYruf00Dl1L51NUMt8G3ixXWtD2TxnPc03
         uOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vIsldLhCmZH7wKYOXMosoXmaGOAAlbldleWN7ENAInA=;
        b=c0BpBcXPVBvP4C+Zd+NdWY1VcV+Q/oL3hOQIA9bxRYQc9quOTXnlTUXVhDbsftiFyN
         b+7OZEHgVlKb2+UVwyQhNcFcgLlwQLS9aZW+OfgKZMSjUzHGujWI+bYd+iei97QrlEDI
         CSge1ABOC4TRibYcPT96EB/TeqUSrx+/v5ufnsvTMlSz9R4/fGiq49yVNUEzegPeIFWM
         QGiVHeRqRs62eL9vUmkUGJBObgLCx+NkB9QFCYwYir3pwGvJ5R52FyWAwXvr8R67tNqK
         OTHuo56ka4r4EeTFdkylsOIwQ7UyPuHTnGaU+j4ol16rQtecvxZemKf7WezoEn1SoASP
         fRUw==
X-Gm-Message-State: AOAM530wPfKrNa+84SwyY18092uQw+0w1aWJDMXzv9G9tDloewg7PaGA
        ivCPtbbZDtXfVRT+pF8k4GM=
X-Google-Smtp-Source: ABdhPJx9xsWWL4RWc/B/RSlpEWpCZDCrTafViiPUVdW0LXQpt6P0A72nQxwqnB2doM4/JR6vsz/3JA==
X-Received: by 2002:a17:90b:4c89:: with SMTP id my9mr35154223pjb.229.1638776882984;
        Sun, 05 Dec 2021 23:48:02 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u13sm9004627pgp.27.2021.12.05.23.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 23:48:02 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        chiminghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cm>
Subject: [PATCH] fs:remove redundant variable
Date:   Mon,  6 Dec 2021 07:47:54 +0000
Message-Id: <20211206074754.398117-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: chiminghao <chi.minghao@zte.com.cn>

return value form directly instead of
taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cm>
Signed-off-by: chiminghao <chi.minghao@zte.com.cn>
---
 fs/file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 8627dacfc424..97605ef3c390 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -265,8 +265,7 @@ static unsigned int count_open_files(struct fdtable *fdt)
 		if (fdt->open_fds[--i])
 			break;
 	}
-	i = (i + 1) * BITS_PER_LONG;
-	return i;
+	return (i + 1) * BITS_PER_LONG;
 }
 
 static unsigned int sane_fdtable_size(struct fdtable *fdt, unsigned int max_fds)
-- 
2.25.1

