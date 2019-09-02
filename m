Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5E3B13BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387680AbfILR3R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:29:17 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:44728 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387674AbfILR3Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568309355; x=1599845355;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=g/CRhjkDMfnehkMmWaT1SBtBLAOyR4ClP1RfGHlt7BE=;
  b=fnoIrMmXFOZZDRQf4I2tyoanm0zGcvgYL3jp7v9XkZD+tF7zJ5SPX4vK
   qnAIYkV81UtptZkt/aSAUyl7ZCfHlf5GpaTWqrKZEpo2GFNtWpU+sAwKM
   GaJoD5aCQNGu3ZpLjB5dLk91Tad8aqZYLJZRT7kVoc9zibJN9j0+E4PzU
   Q=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="750440831"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 12 Sep 2019 17:29:11 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id A003CA2617;
        Thu, 12 Sep 2019 17:29:10 +0000 (UTC)
Received: from EX13D12UEA003.ant.amazon.com (10.43.61.184) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D12UEA003.ant.amazon.com (10.43.61.184) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:52 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E77E2C0525; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <46d6a4ceafd045be525e669aade649bc81c5894b.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Mon, 2 Sep 2019 23:17:12 +0000
Subject: [RFC PATCH 35/35] nfsd: add NFSD_V4_XATTR config option
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With everything in place, add the NFSD_V4_XATTR config option to enable
user extended attribute support.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfsd/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index d25f6bbe7006..a42d7c8bdb03 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -145,6 +145,16 @@ config NFSD_V4_SECURITY_LABEL
 	If you do not wish to enable fine-grained security labels SELinux or
 	Smack policies on NFSv4 files, say N.
 
+config NFSD_V4_XATTR
+	bool "NFSv4.2 server extended attribute support (RFC8276)"
+	depends on NFSD_V4
+	help
+
+	This option enables extended attributed support, as defined
+	by RFC8726, for the kernel NFS server. This is not to be
+	confused with the "named attributers" extension. It supports
+	the xattr user namespace only, by design.
+
 config NFSD_FAULT_INJECTION
 	bool "NFS server manual fault injection"
 	depends on NFSD_V4 && DEBUG_KERNEL && DEBUG_FS
-- 
2.17.2

