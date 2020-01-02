Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85C9C12E616
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 13:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgABM3R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 07:29:17 -0500
Received: from mgw-01.mpynet.fi ([82.197.21.90]:48660 "EHLO mgw-01.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728260AbgABM3R (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 07:29:17 -0500
Received: from pps.filterd (mgw-01.mpynet.fi [127.0.0.1])
        by mgw-01.mpynet.fi (8.16.0.27/8.16.0.27) with SMTP id 002Bxqvj066005;
        Thu, 2 Jan 2020 14:02:58 +0200
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-01.mpynet.fi with ESMTP id 2x9egur3pg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 02 Jan 2020 14:02:58 +0200
Received: from localhost (194.100.106.190) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Jan
 2020 14:02:57 +0200
From:   Vladimir Zapolskiy <vladimir@tuxera.com>
To:     Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
CC:     Anton Altaparmakov <anton@tuxera.com>,
        <linux-erofs@lists.ozlabs.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] erofs: correct indentation of an assigned structure inside a function
Date:   Thu, 2 Jan 2020 14:02:32 +0200
Message-ID: <20200102120232.15074-1-vladimir@tuxera.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [194.100.106.190]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-01-02_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=942
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001020108
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Trivial change, the expected indentation ruled by the coding style
hasn't been met.

Signed-off-by: Vladimir Zapolskiy <vladimir@tuxera.com>
---
 fs/erofs/xattr.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
index 3585b84d2f20..50966f1c676e 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -46,18 +46,19 @@ extern const struct xattr_handler erofs_xattr_security_handler;
 
 static inline const struct xattr_handler *erofs_xattr_handler(unsigned int idx)
 {
-static const struct xattr_handler *xattr_handler_map[] = {
-	[EROFS_XATTR_INDEX_USER] = &erofs_xattr_user_handler,
+	static const struct xattr_handler *xattr_handler_map[] = {
+		[EROFS_XATTR_INDEX_USER] = &erofs_xattr_user_handler,
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
-	[EROFS_XATTR_INDEX_POSIX_ACL_ACCESS] = &posix_acl_access_xattr_handler,
-	[EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT] =
-		&posix_acl_default_xattr_handler,
+		[EROFS_XATTR_INDEX_POSIX_ACL_ACCESS] =
+			&posix_acl_access_xattr_handler,
+		[EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT] =
+			&posix_acl_default_xattr_handler,
 #endif
-	[EROFS_XATTR_INDEX_TRUSTED] = &erofs_xattr_trusted_handler,
+		[EROFS_XATTR_INDEX_TRUSTED] = &erofs_xattr_trusted_handler,
 #ifdef CONFIG_EROFS_FS_SECURITY
-	[EROFS_XATTR_INDEX_SECURITY] = &erofs_xattr_security_handler,
+		[EROFS_XATTR_INDEX_SECURITY] = &erofs_xattr_security_handler,
 #endif
-};
+	};
 
 	return idx && idx < ARRAY_SIZE(xattr_handler_map) ?
 		xattr_handler_map[idx] : NULL;
-- 
2.20.1

