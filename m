Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4471141839
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2020 16:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgARPFA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 10:05:00 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43878 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729076AbgARPFA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 10:05:00 -0500
Received: by mail-pl1-f196.google.com with SMTP id p27so11148503pli.10;
        Sat, 18 Jan 2020 07:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9xT3NLw33dTGxfqk1lPjrMVyj+IMIm4iAFAArnndWEk=;
        b=SFIUiKty7fjXuu+00OXVY/ZypuO24GTrJ7HfOPM2b8IGN0fKqEUUGMSRaUjuybLKob
         qho9JB9djgHWKJAuPWxw8sdewfy61mWB5Qj1GjWT5crO/gRhXoZ4rJN4q7hyP7Njve/W
         zsUVXaA9Y490MMxoz8qQrpS66rExHw98yYHINnzUxyWgTq0JTqbiLRUgXcmRXhxuElG+
         k/zxOeV05axwd0PDyOh3eoCkQwqdQSYkY+9YXHCm7BjeFQGJF8TDdGNsxmULAPqT6qgM
         zx2jokC+QkjOEW/otKTNX2i5mqiU52wBtKsiTHg3qbyeLvYYDq6JV01UbEGTpz3Uu0Wl
         Z1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9xT3NLw33dTGxfqk1lPjrMVyj+IMIm4iAFAArnndWEk=;
        b=N65NfoctAqvWX7/lZuCkpYu9tGl7aH5Q7CYgBySXYgRTuognq6lL3x8NgTLsuIZaRR
         m/0r0Z6Ru3PFXR0z9pEYHp94Py9Mk1Dzka39tl7kJZ67dz55k20PYoYsZEqZ4Qpkq3ry
         sfzt4IR8vikpOnOo9gY7RcM8l0o3k86+EIsLe1lX/QVOCcIIane+um4CU/9yJqHrfZSC
         CTO/c+kGvXpDDaYVqacZldwF7nlhdNFmlzcLxYXFt/IDf5O4e6pGe0U6a76kqNlM8BlS
         NUeS241o30BjEsvxEaJ3AIyIXMmNH1FObMam4ZgWmwiSHueMtW32X37IpKcbEfYk6bGG
         8xxg==
X-Gm-Message-State: APjAAAW2mUQr1paZSZvwvbL7dexcREFtmJ4HVuTgJDdJpQZuZIZolrNU
        N92i4rUgWJo5pJKx3cNS7QvHI6xm
X-Google-Smtp-Source: APXvYqwXn0DLalvHkn5zyk2/2PQfHrCe2sqbqaqsIoTRtYolTaxgPs5xjYb1b7Bc7Qb2od6ICDOwzA==
X-Received: by 2002:a17:902:7088:: with SMTP id z8mr5413023plk.6.1579359899232;
        Sat, 18 Jan 2020 07:04:59 -0800 (PST)
Received: from localhost.localdomain ([221.146.116.86])
        by smtp.gmail.com with ESMTPSA id v10sm32072078pgk.24.2020.01.18.07.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 07:04:58 -0800 (PST)
From:   Namjae Jeon <linkinjeon@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        namjae.jeon@samsung.com, Namjae Jeon <linkinjeon@gmail.com>
Subject: [PATCH v11 13/14] MAINTAINERS: add exfat filesystem
Date:   Sun, 19 Jan 2020 00:03:47 +0900
Message-Id: <20200118150348.9972-14-linkinjeon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200118150348.9972-1-linkinjeon@gmail.com>
References: <20200118150348.9972-1-linkinjeon@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Namjae Jeon <namjae.jeon@samsung.com>

Add myself and Sungjong Seo as exfat maintainer.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9aa438cb9836..67953b2baa33 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6294,6 +6294,13 @@ F:	include/trace/events/mdio.h
 F:	include/uapi/linux/mdio.h
 F:	include/uapi/linux/mii.h
 
+EXFAT FILE SYSTEM
+M:	Namjae Jeon <namjae.jeon@samsung.com>
+M:	Sungjong Seo <sj1557.seo@samsung.com>
+L:	linux-fsdevel@vger.kernel.org
+S:	Maintained
+F:	fs/exfat/
+
 EXFAT FILE SYSTEM
 M:	Valdis Kletnieks <valdis.kletnieks@vt.edu>
 L:	linux-fsdevel@vger.kernel.org
-- 
2.17.1

