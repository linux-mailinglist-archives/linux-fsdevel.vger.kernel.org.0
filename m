Return-Path: <linux-fsdevel+bounces-1378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922607D9CD4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 17:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B207B2135F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 15:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F717374F0;
	Fri, 27 Oct 2023 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="kL0UE10/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650C5374DA
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 15:22:36 +0000 (UTC)
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Oct 2023 08:22:34 PDT
Received: from aer-iport-1.cisco.com (aer-iport-1.cisco.com [173.38.203.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E6291
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 08:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=821; q=dns/txt; s=iport;
  t=1698420154; x=1699629754;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2j3j62roU9BtvsHaA8xSl04W6vi8cIw8T+FS/GCLhVw=;
  b=kL0UE10/oxlVAtu5ApEhPOurIOx9BRS3bg42vX8P2s6wp3o3z4g9TNEq
   ywQ1jM0X9SZ56Bwdmx391yfktZupKIBk1xYi+1znhrHyIP+AxPV0HYlUx
   xV9gm+zlKdUxfALlsJoEabn6mWkG9przY8QCZvZxMZiH3gnhuEEP/9qUM
   c=;
X-CSE-ConnectionGUID: 2TzUq/avRwKiuVzBIcQMqw==
X-CSE-MsgGUID: L4B7OTcHQeKYsy7kGiEcbw==
X-IronPort-AV: E=Sophos;i="6.03,256,1694736000"; 
   d="scan'208";a="9433787"
Received: from aer-iport-nat.cisco.com (HELO aer-core-1.cisco.com) ([173.38.203.22])
  by aer-iport-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 15:21:29 +0000
Received: from localhost ([10.61.193.113])
	(authenticated bits=0)
	by aer-core-1.cisco.com (8.15.2/8.15.2) with ESMTPSA id 39RFLS5W001224
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 27 Oct 2023 15:21:28 GMT
From: Ariel Miculas <amiculas@cisco.com>
To: linux-doc@vger.kernel.org
Cc: serge@hallyn.com, Ariel Miculas <amiculas@cisco.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: vfs: fix typo in struct xattr_handlers
Date: Fri, 27 Oct 2023 18:21:01 +0300
Message-ID: <20231027152101.226296-1-amiculas@cisco.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: amiculas@cisco.com
X-Outbound-SMTP-Client: 10.61.193.113, [10.61.193.113]
X-Outbound-Node: aer-core-1.cisco.com

The structure is called struct xattr_handler, singular, not plural.
Fixing the typo also makes it greppable with the whole word matching
flag.

Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 Documentation/filesystems/vfs.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 99acc2e98673..276a219ff8d9 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -437,7 +437,7 @@ field.  This is a pointer to a "struct inode_operations" which describes
 the methods that can be performed on individual inodes.
 
 
-struct xattr_handlers
+struct xattr_handler
 ---------------------
 
 On filesystems that support extended attributes (xattrs), the s_xattr
-- 
2.42.0


