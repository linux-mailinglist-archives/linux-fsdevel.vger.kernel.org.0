Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBC0F8A3AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 18:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfHLQsR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 12:48:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37780 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfHLQsR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:48:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id z11so3230951wrt.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 09:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=11wkmFbdZNLFDObu7qa0h1XGmuhrhPDJ644YfTi0+UQ=;
        b=xDF/IncmZ2Amaq0nbwUoSFgg4c6Ouy7aGwc/bkszM3cI+YO8XcOPNueKb5i3c6MCU4
         O6JUysVjHe7Iusr/ZMope6yXg92dUR0zIv5EuTB9R3fbe/SkCHh5cg30ZcLeW/oQ8JHB
         YaTctn94gBA4T7AY/Zru8s8OpLXZTFPgWGqUZki/iZUcLcUuzUq7rAgHzildYfo0HTLx
         7Ym2zBaMLOugKKfx169bU09+819pqN/cNv53mqyC/JAxqCCWQttKfcm4j7tip7vlQaNw
         9uGdUB1Q3aMF6c10n5Dps0eSSx2+saNX/olhrI7PiAKFrNcqEBHc3CqgRhtiPLC10Si/
         Hiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=11wkmFbdZNLFDObu7qa0h1XGmuhrhPDJ644YfTi0+UQ=;
        b=U7JucZcNqLFMz/w0Bi3JqDnV2FeiH+Gs8QvEsUoY7JJuJaGUgSNZSbvaryIHTXC7uz
         LdlMBljiCOYPiKswWzpp2Sk7BU2MyNdDp9NtyxK2K/I6C3B2WIk7jAa4cwxIBaNcrBje
         tcOte//Tndc/9V8wYF+u6R2nY4W3PpkMTB47oKjWyd4TJkLl0YJVEc1AUxx0CkvW39LC
         kWCkBhD/aVCN+CREZRyhr6fccO+s2DcVyKtEySt5LETp5ZvFNA4nSvPg/L5huJJivI00
         bSitPUH1oO1W7BNGC2HJr7+Oib3sjP01MMrxPK9POEY9wSw572B8ySGqbswcsxakS3lz
         tFUg==
X-Gm-Message-State: APjAAAVdR0TVXHqCS1zKqv9DLZWHEm6mfmPq+H5nRwdzxY1Z/tougz/z
        nuYk6Ljxp6G6ctAw23wXNmXSU2qWpHk=
X-Google-Smtp-Source: APXvYqwY5r8/Zc3blBeQSS9EPEAs+QMtS8fXCFE5NpJuE9CuhJj2H94vMgAx9RLPdQ6nX+FryN6cdQ==
X-Received: by 2002:adf:b64e:: with SMTP id i14mr42452129wre.248.1565628494994;
        Mon, 12 Aug 2019 09:48:14 -0700 (PDT)
Received: from Bfire.plexistor.com ([217.70.211.18])
        by smtp.googlemail.com with ESMTPSA id o9sm11104494wrm.88.2019.08.12.09.48.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 09:48:14 -0700 (PDT)
From:   Boaz Harrosh <boaz@plexistor.com>
X-Google-Original-From: Boaz Harrosh <boazh@netapp.com>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Amit Golander <Amit.Golander@netapp.com>,
        Sagi Manole <sagim@netapp.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 02/16] MAINTAINERS: Add the ZUFS maintainership
Date:   Mon, 12 Aug 2019 19:47:52 +0300
Message-Id: <20190812164806.15852-3-boazh@netapp.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812164806.15852-1-boazh@netapp.com>
References: <20190812164806.15852-1-boazh@netapp.com>
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

