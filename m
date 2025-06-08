Return-Path: <linux-fsdevel+bounces-50947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0731BAD159A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 01:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0157169D6F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 23:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9606E25E44B;
	Sun,  8 Jun 2025 23:10:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2247F20D51A;
	Sun,  8 Jun 2025 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749424214; cv=none; b=o4uBTa++TdKB6wzUJYMoM4CLdhqSgO81liPzQ8tvyeJhSZTPHbQCg5eO5zGT/Cxvj7J0/gEEvjRoJFRlsgkVpU4cpo5oFFD0LrodAEwsAlvXbhaYGXqLaMjyNgGzuzIM6HnFbQPodGI991Qtpo7MFEBC6F6lPtqRaw6Yedp99dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749424214; c=relaxed/simple;
	bh=tDrDSkgyv7n05q8wyjyILqPPZkOWST8lnIMApMSdLYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0LxE62/yWFWnhvmYuaEVzsCt2FRaBrLt89Ey0UY+swMopcud1Ke4/gJvf4lqYF5ntniH6jA6So3d6GqaubBQutRRct4stccjHl3m8vXerZ0Ytc7s6ElndIzhSRW26HD/uiGNcaW+7ym8Ky+U0LjpE2ebyTRz2zEFQ6qdgpEICE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uOP9P-005ves-FB;
	Sun, 08 Jun 2025 23:10:03 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	David Howells <dhowells@redhat.com>,
	Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Carlos Maiolino <cem@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	coda@cs.cmu.edu,
	codalist@coda.cs.cmu.edu,
	linux-nfs@vger.kernel.org,
	netfs@lists.linux.dev,
	ecryptfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] VFS: Minor fixes for porting.rst
Date: Mon,  9 Jun 2025 09:09:34 +1000
Message-ID: <20250608230952.20539-3-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608230952.20539-1-neil@brown.name>
References: <20250608230952.20539-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This paragraph was relevant for an earlier version of the code which
passed the qstr as a struct instead of a point.  The version that landed
passed the pointer in all cases so this para is now pointless.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 3616d7161dab..e8c9f21582d1 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1224,9 +1224,6 @@ lookup_noperm_unlocked(), lookup_noperm_positive_unlocked().  They now
 take a qstr instead of separate name and length.  QSTR() can be used
 when strlen() is needed for the length.
 
-For try_lookup_noperm() a reference to the qstr is passed in case the
-hash might subsequently be needed.
-
 These function no longer do any permission checking - they previously
 checked that the caller has 'X' permission on the parent.  They must
 ONLY be used internally by a filesystem on itself when it knows that
-- 
2.49.0


