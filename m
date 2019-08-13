Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B30B8AFB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 08:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfHMGNm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 02:13:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39430 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfHMGNm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 02:13:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id i63so363000wmg.4;
        Mon, 12 Aug 2019 23:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=00vbfjyR4LBvInSpln0cJ4tDTiOJl8WBixHWOmW0Ge4=;
        b=ApJWRPSXlHHpCQXyNT/OQs8RosSDdRIt5TDv/25F526qt37NUgy4SVRch4nQ/txxLI
         4eDPmw8vUb0aW8TZf1QH4Gve1R3LKqaCd/Fe+/XSCzG+pfTfafbFmAglbIlwU3dH/bvY
         bqDbcgfctigWXlwzJ9JO5gqgA/hX/BW0g9b52GtDZedOVaniUHB4bRatUMeQZ/JjZkbI
         tNDZHxpr6wACalOLQi6Er+gypvfvBWcg86Q1ARcbSc7ksWgjvw6uo5djdv6ijzWHC5p/
         hnZU624yjnhKZ84kp6xfEzD+c/o4HssA/2IcRDR3LJuRk320+Nv8xSvGMWFvweQxBX25
         SV0A==
X-Gm-Message-State: APjAAAVdpL3NN8g4BjGswhCAmz6AernMBhnGweom1NGg/0zcQKdZonUe
        k6Lwlk1Ttg0TRZ/k3SdmbIcaYqjpI+Y=
X-Google-Smtp-Source: APXvYqw4nFONZ7tK/+1qYlrU9shh3MmLLSK9it45vHTg1MXl3QLevFvrgDfuXGOlwbMp+kxt+XxBAg==
X-Received: by 2002:a1c:b189:: with SMTP id a131mr1116499wmf.7.1565676820239;
        Mon, 12 Aug 2019 23:13:40 -0700 (PDT)
Received: from black.home (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id e11sm19197494wrc.4.2019.08.12.23.13.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 23:13:39 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-kernel@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, joe@perches.com,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: iomap: Remove fs/iomap.c record
Date:   Tue, 13 Aug 2019 09:13:25 +0300
Message-Id: <20190813061325.16904-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update MAINTAINERS to reflect that fs/iomap.c file
was splitted into separate files in fs/iomap/

Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org
Fixes: cb7181ff4b1c ("iomap: move the main iteration code into a separate file")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3ec8154e4630..29514fc19b01 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8415,7 +8415,6 @@ L:	linux-xfs@vger.kernel.org
 L:	linux-fsdevel@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 S:	Supported
-F:	fs/iomap.c
 F:	fs/iomap/
 F:	include/linux/iomap.h
 
-- 
2.21.0

