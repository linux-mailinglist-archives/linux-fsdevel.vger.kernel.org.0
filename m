Return-Path: <linux-fsdevel+bounces-4924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC42580663E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 05:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C911F21738
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 04:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2A210788
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 04:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DhclSoRF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FB11B5
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 18:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=CnKW35/cxCOpHUXEtFirhv8MDlKsZ0CPCTXswK4g0Es=; b=DhclSoRFkReBXS5LktVeJ+u+/t
	+zwhWgl0JtT9DktPR4zJzE6vPH3HDbi4n0+pgTFV2yJ1MqWMP1ee2rID84JSGeRXUcw//2jYLLw53
	76tXJLNwKGsEe6g0YRvHBflEqgqgHkfCEHE1r3fuYa2rbwsNMaLv5fH9G0AvtugU9AFPdLCiB5aZj
	RJasoim6A5ZSpriY51CPQmVgjhH7b93yaEp9ePsB7aCpMty+TtxfQUu+xeqNIfvmpwSBX5L4s7dGy
	yub9fo7yPcg0uoMBKLIZSklwaywzC37NUXUa19c3C99tvuwmfggEoMWb1PQwL5pKMJo5VKTrVlpWG
	7vH+NiJQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rAhm9-008tqm-0P;
	Wed, 06 Dec 2023 02:36:37 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev
Subject: [PATCH] gfs2: rgrp: fix kernel-doc warnings
Date: Tue,  5 Dec 2023 18:36:36 -0800
Message-ID: <20231206023636.30460-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kernel-doc warnings found when using "W=1".

rgrp.c:162: warning: missing initial short description on line:
 * gfs2_bit_search
rgrp.c:1200: warning: Function parameter or member 'gl' not described in 'gfs2_rgrp_go_instantiate'
rgrp.c:1200: warning: Excess function parameter 'gh' description in 'gfs2_rgrp_go_instantiate'
rgrp.c:1970: warning: missing initial short description on line:
 * gfs2_rgrp_used_recently

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev
---
 fs/gfs2/rgrp.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff -- a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -159,13 +159,13 @@ static inline u8 gfs2_testbit(const stru
 }
 
 /**
- * gfs2_bit_search
+ * gfs2_bit_search - search bitmap for a state
  * @ptr: Pointer to bitmap data
  * @mask: Mask to use (normally 0x55555.... but adjusted for search start)
  * @state: The state we are searching for
  *
- * We xor the bitmap data with a patter which is the bitwise opposite
- * of what we are looking for, this gives rise to a pattern of ones
+ * We xor the bitmap data with a pattern which is the bitwise opposite
+ * of what we are looking for. This gives rise to a pattern of ones
  * wherever there is a match. Since we have two bits per entry, we
  * take this pattern, shift it down by one place and then and it with
  * the original. All the even bit positions (0,2,4, etc) then represent
@@ -1188,7 +1188,7 @@ static void rgrp_set_bitmap_flags(struct
 
 /**
  * gfs2_rgrp_go_instantiate - Read in a RG's header and bitmaps
- * @gh: the glock holder representing the rgrpd to read in
+ * @gl: the glock holder representing the rgrpd to read in
  *
  * Read in all of a Resource Group's header and bitmap blocks.
  * Caller must eventually call gfs2_rgrp_brelse() to free the bitmaps.
@@ -1967,7 +1967,7 @@ static bool gfs2_rgrp_congested(const st
 }
 
 /**
- * gfs2_rgrp_used_recently
+ * gfs2_rgrp_used_recently - test if an rgrp has been used recently
  * @rs: The block reservation with the rgrp to test
  * @msecs: The time limit in milliseconds
  *

