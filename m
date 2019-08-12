Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0458A392
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 18:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfHLQmx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 12:42:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36270 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfHLQmw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:42:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id g67so171425wme.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 09:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=11wkmFbdZNLFDObu7qa0h1XGmuhrhPDJ644YfTi0+UQ=;
        b=uPQHPLm3uYmg4AOYlCZdKgpxeUj7bc3nRZ1YPNkNnkbxl5+1nelI/IPT3RdSkAjzKb
         0RtEFZ2FJskReG2ZTTHwt7Mi8nSom8PZk2dYcQYcEs6UFhxKVbWon+LfOoQyItc7oq58
         OWqWd6UoRnWyqU8US9VuLakQn5apH77t+d40Bn0aRxt0hJJzYn6gbEDeEOreJm3fIEjU
         19WTl2JeNskjW7Nupn/H28IpM+KTinMqRW40OFb0QqzP7MfGJP2meOXyFhdrMS1p/RXr
         bVkR6QXADmOaON8nCYgoHZvwDJOcOfXqoLcZf6C/Pu0g5N35Pdf3xI0Q0AWH78wYGg9A
         O9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=11wkmFbdZNLFDObu7qa0h1XGmuhrhPDJ644YfTi0+UQ=;
        b=J8RET02zMtdscYQfRH5kHQz2Tt/ljCwmvi+3Hvobvfhc9fcqSVvj05IQLToIEOxZ5/
         C/GdycekOIKsiZpRhsByh4PEPVLLL+5wQ8HfVKJHUe7zyNVcRkzHzJygUb4oEvDadzsm
         idV22nf/G4UJW6V1lP3UVgFl8vhEEevb6wGy/KKShKYos69lLrAzS+HBYIJ1XmmD8heo
         TeMZlXOL8Kjnx2OasJ8ZUOAeqkNE6D2PM1iD2Spr4hN5HhmJ3Dmmz+2VDkCMlh6iKtxA
         d2BBkoxhENP7M8RSVLuUqckg8Lt6Mvf9HxlFh+QmQ0LlHyxUM5XKOegWWtrXKHrMbCF8
         SQ4Q==
X-Gm-Message-State: APjAAAU93H4/1NOyUTqiNKig1jwqEmwRz/rdvQLJ0K6PwcZq407I2a+i
        BZs5z36mDZ8E8oEHO2x1S2ZE7g==
X-Google-Smtp-Source: APXvYqwDWlV6O7xdDlDHZdtN/P48AbFYlpTE1+pqJ6dQhJMPKV5RlW5G4HadDw0cxhF8WLjlVgrowQ==
X-Received: by 2002:a1c:3587:: with SMTP id c129mr233473wma.90.1565628171401;
        Mon, 12 Aug 2019 09:42:51 -0700 (PDT)
Received: from Bfire.plexistor.com ([217.70.211.18])
        by smtp.googlemail.com with ESMTPSA id e13sm59884wmh.44.2019.08.12.09.42.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 09:42:50 -0700 (PDT)
From:   Boaz Harrosh <boaz@plexistor.com>
X-Google-Original-From: Boaz Harrosh <boazh@netapp.com>
To:     Boaz Harrosh <boaz@plexistor.com>,
        Boaz Harrosh <ooo@electrozaur.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Boaz Harrosh <boazh@netapp.com>
Subject: [PATCH 02/16] MAINTAINERS: Add the ZUFS maintainership
Date:   Mon, 12 Aug 2019 19:42:30 +0300
Message-Id: <20190812164244.15580-3-boazh@netapp.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812164244.15580-1-boazh@netapp.com>
References: <20190812164244.15580-1-boazh@netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ZUFS sitting in the fs/zuf/ directory is maintained
by Netapp. (I added my email)

I keep this as separate patch as this file might be
a source of conflicts

Signed-off-by: Boaz Harrosh <boazh@netapp.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 677ef41cb012..5ecd89ea256f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17542,6 +17542,12 @@ L:	linux-mm@kvack.org
 S:	Maintained
 F:	mm/zswap.c
 
+ZUFS ZERO COPY USER-MODE FILESYSTEM
+M:	Boaz Harrosh <boazh@netapp.com>
+L:	linux-fsdevel@vger.kernel.org
+S:	Maintained
+F:	fs/zuf/
+
 THE REST
 M:	Linus Torvalds <torvalds@linux-foundation.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.20.1

