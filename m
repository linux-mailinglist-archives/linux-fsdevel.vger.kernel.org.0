Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6286844B443
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 21:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244755AbhKIUuB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 15:50:01 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:33722 "EHLO
        fanzine.igalia.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S244708AbhKIUt6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 15:49:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; s=20170329;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=V5TlNNHK5TXkLJH4wGpBTMm1ncH3nHL5Lp6qWJm/BCI=;
        b=OfM5quAqtYbzRy/Sf16X+ND9GskkR3A7ApwZXs1PooXj+kP7lYXBOSLmOxcpU3o8egdVgNVe0Ys9Q4SHjsedgQO5XTQoV7SG0qqmboxRGIHMfnCD66cfGVPBAbo55AIXWqjLJg+JXVWjSE13M5CfFwn6mmaxz44j7Igp22MQmncECgMPuwE/L+c5pN0lJhm1HDXfmghBXWFUKTZovYY3bCU02v9oUyl0qM1ftSApVRqYCK5yV1AdXajwp2b55S+YRZsUNRVYkq3a8Z8GPaPh0KhKCtUQFgpmrmU1wzG+e1UtqO0DxK5s6wFwyUv2xzVRFslqm7FcTLiGc8m+Ws72zQ==;
Received: from 201-95-14-182.dsl.telesp.net.br ([201.95.14.182] helo=localhost)
        by fanzine.igalia.com with esmtpsa 
        (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
        id 1mkXl0-0000Ky-4o; Tue, 09 Nov 2021 21:30:14 +0100
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, feng.tang@intel.com,
        siglesias@igalia.com, kernel@gpiccoli.net, gpiccoli@igalia.com
Subject: [PATCH 1/3] docs: sysctl/kernel: Add missing bit to panic_print
Date:   Tue,  9 Nov 2021 17:28:46 -0300
Message-Id: <20211109202848.610874-2-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211109202848.610874-1-gpiccoli@igalia.com>
References: <20211109202848.610874-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit de6da1e8bcf0 ("panic: add an option to replay all the printk message in buffer")
added a new bit to the sysctl/kernel parameter "panic_print", but the
documentation was added only in kernel-parameters.txt, not in the sysctl guide.

Fix it here by adding bit 5 to sysctl admin-guide documentation.

Cc: Feng Tang <feng.tang@intel.com>
Fixes: de6da1e8bcf0 ("panic: add an option to replay all the printk message in buffer")
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 426162009ce9..70b7df9b081a 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -795,6 +795,7 @@ bit 1  print system memory info
 bit 2  print timer info
 bit 3  print locks info if ``CONFIG_LOCKDEP`` is on
 bit 4  print ftrace buffer
+bit 5: print all printk messages in buffer
 =====  ============================================
 
 So for example to print tasks and memory info on panic, user can::
-- 
2.33.1

