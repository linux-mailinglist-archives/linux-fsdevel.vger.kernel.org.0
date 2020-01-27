Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D43314A1AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 11:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbgA0KPN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 05:15:13 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33091 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729579AbgA0KPN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:15:13 -0500
Received: by mail-pj1-f68.google.com with SMTP id m7so1923794pjs.0;
        Mon, 27 Jan 2020 02:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+sMuF5qnUnN9Y8onz/B4zeL75IEd/ON79HtlJ1XRPFg=;
        b=XvfG0jLHnDaERvZ+WHnA6vywBGhXrHvlvVwQUv0Fu1WZ7t0zp8NsGU5a79TLmuRaBB
         iwIoJ68Yt2jM7poch61FpjmrNMxATkPBXcCBJWwlSTWJB5UQZ88YVS1cfJlPVbQjAn8R
         5z5b22IOLyq0OoTJh7cLUWuTdskuujTeyua0KrDNwgInvmIErZbLq8sy/ID9fdY8dFgs
         pN3jPCzKBDX68gWQ+Fb7cmWaTeEZGx9h13gLS0aNc6ON2NFexL5S9d+0XLs9ridT6ybi
         zoZjwzyNSHdgGVwE4Z22cYIh3UtS5m+cAImSt0VSHhZbn3x/GKQsSVGTqxJVJeFwnEuM
         2TCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+sMuF5qnUnN9Y8onz/B4zeL75IEd/ON79HtlJ1XRPFg=;
        b=R/cz42Jx3VABAKxGwP8vbGHfRLUCpR9g1U3R8TUIAMVsyJ5BWZkQFFmyVNekoGJ7i8
         2l5aSbzon/fTHsp053A5W5Wf7w13Kd/wK3j6tE/9vH7Z/shww7fjJ2zRvPzNlNWquoZH
         H7tXChE6/T2bS0Xh1jQik3k+O4YjJoQKUL9xGmiqGbXiX1JxbGdeNuoumiywN0mfl3QR
         QpLDNVxKhWm6dysf/ar53WrbQUPzUsIg3nClktPlWXWv9OrPj41hATjDM73cFK3YeI6e
         EV2BE1YLW+Zo2xn696Ovua/xUXi6UlTfr9Uz1IdxQw8NnXOGqn0O5HW09CEX6CQjhLj0
         EPAA==
X-Gm-Message-State: APjAAAVttlLelEtQ1DKVg2POzwq7qG0ZMC+L8ImvR2hkuAMF0Be0vuAl
        2yw3rrhhLoqYruG8ssjDLoU=
X-Google-Smtp-Source: APXvYqwpspdRYPpxmAb+3sp5DfpMT0p35fOj7YL4PbTXIAGdRlX3cKuYysRJEfediyYGYOmDYq1j7w==
X-Received: by 2002:a17:90a:c983:: with SMTP id w3mr13584404pjt.121.1580120112342;
        Mon, 27 Jan 2020 02:15:12 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c902:a5e9:3956:8df2:aee5:9cf6])
        by smtp.gmail.com with ESMTPSA id s15sm15504138pgq.4.2020.01.27.02.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 02:15:11 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 10/22] staging: exfat: Rename variable "SecSize" to "sec_size"
Date:   Mon, 27 Jan 2020 15:43:31 +0530
Message-Id: <20200127101343.20415-11-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127101343.20415-1-pragat.pandya@gmail.com>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change all the occurrences of "SecSize" to "sec_size" in exfat.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index a228350acdb4..58292495bb57 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -237,7 +237,7 @@ struct part_info_t {
 };
 
 struct dev_info_t {
-	u32      SecSize;    /* sector size in bytes */
+	u32      sec_size;    /* sector size in bytes */
 	u32      DevSize;    /* block device size in sectors */
 };
 
-- 
2.17.1

