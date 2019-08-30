Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6438FB13A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387643AbfILR3D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:29:03 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:44567 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387594AbfILR2z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568309334; x=1599845334;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=LP93UruatuZkR059tKtl4aY+x6e5dRSo0DB+aVTiB7o=;
  b=aIWL3ytd1WaFe46m3qzYwE9Gn58OxysWNAaXtYEWZOuU32FmMMZyuy0q
   qYKqJeev+medTYOoSk2zw1/H3ea/6HqO/rucI2Qh4NgXSx7dr3UvAX8mi
   xzvMycwtvhNJLWbGhTPbJzeJilPuGeFPv8MnVAuy3htIKhMFJ85S8p/rl
   Q=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="750440664"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 12 Sep 2019 17:28:53 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (Postfix) with ESMTPS id 85C16A1E01;
        Thu, 12 Sep 2019 17:28:52 +0000 (UTC)
Received: from EX13d09UWC001.ant.amazon.com (10.43.162.60) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13d09UWC001.ant.amazon.com (10.43.162.60) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:52 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E61B0C0515; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <05f6405b6bf29fde6ed411d2a472d63f87868e0b.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Fri, 30 Aug 2019 23:59:56 +0000
Subject: [RFC PATCH 20/35] nfs: add the NFS_V4_XATTR config option
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the CONFIG_NFS_V4_XATTR option to enable client side user extended
attributes support for NFSv4.2

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 295a7a21b774..067689ea9e3f 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -152,6 +152,15 @@ config NFS_V4_1_MIGRATION
           The NFSv4.1 pieces of the Linux NFSv4 migration implementation are
           still experimental.  If you are not an NFSv4 developer, say N here.
 
+config NFS_V4_XATTR
+	bool "NFSv4.2 client support for extended attributes"
+	depends on NFS_V4_2
+	default n
+	help
+	  This option enables the optional NFSv4 client extended attributes
+	  support (https://tools.ietf.org/html/rfc8276). User namespace
+	  xattr support only, as specificed in the RFC.
+
 config NFS_V4_SECURITY_LABEL
 	bool
 	depends on NFS_V4_2 && SECURITY
-- 
2.17.2

