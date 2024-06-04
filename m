Return-Path: <linux-fsdevel+bounces-20905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAC78FAACE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 08:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C721C214C0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 06:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF1D1411DB;
	Tue,  4 Jun 2024 06:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkdsXLX/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2BA13E884;
	Tue,  4 Jun 2024 06:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717482600; cv=none; b=VenVkDzfTjMV8ujWwfp136XMsMMaTGXrgAtNHvdA1Wr4P45AQVVuiYvw2uEg6YSZ9Kapha6HVEeBAlmR/4ZJY5DgiTOf3SrnGKd3kBEGVzr6mPBqA4m6OIedsbxaqFMxDEBccVc93YdRNS5lBKhta7R8rsH0evfBrD2Cq4T1x4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717482600; c=relaxed/simple;
	bh=uQvKTedfeUJ5bmniBUr9CwYhnYEum8lzyXgoPJAiEIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NVS2b8/h7yH71IZL0AGqit5NITdNtvRvqZKu+ZWodneanEsFbmL6voDg74ZqlNFuvETdl92j0KeClhMXqlgxuwyYNkxT+DOGMTikoAF2pp0VRrj+uZCq+6h+c7qkuP2o7+zAqyecbEg7thSBbPUfADRu1iZazatZihZVBQuLjXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkdsXLX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D51BCC4AF12;
	Tue,  4 Jun 2024 06:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717482599;
	bh=uQvKTedfeUJ5bmniBUr9CwYhnYEum8lzyXgoPJAiEIM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RkdsXLX/rWNsSnP1w0vpeQO8ySbd33WZFy1o2u5e5N1MaiUcQP2TG2eJUTndxXt3q
	 6OxqXH4y8t+bk4SdJBB3SvyQOefglzILYK2uP527CPP9zD1yZnWraBkOBsm4sLCqvX
	 /iqL5IFdy0HEEVY+3Hvot+cQfBKhwaGAZLW2Nbh42ex6j3bVFoM2Kgz7lYTG5Ge4cI
	 NkKMcVXcV1cGMITbeti1Mx3rTuvfM1gBbZ8rdw4zC9O1kXyytocY5qr22xKPNCjSgi
	 OLoI75IpKFkEerVQqpHzGSKIPc+6ljn5j5vYU/Lr5hciFXi8M3TBJ8M6gjr5QnTVYt
	 UYTwzOiJ9VLAA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4ADC27C52;
	Tue,  4 Jun 2024 06:29:59 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Tue, 04 Jun 2024 08:29:24 +0200
Subject: [PATCH 6/8] sysctl: Remove "child" sysctl code comments
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-jag-sysctl_remset-v1-6-2df7ecdba0bd@samsung.com>
References: <20240604-jag-sysctl_remset-v1-0-2df7ecdba0bd@samsung.com>
In-Reply-To: <20240604-jag-sysctl_remset-v1-0-2df7ecdba0bd@samsung.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
 Kent Overstreet <kent.overstreet@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Joel Granados <j.granados@samsung.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2907;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=0XKCBtKXUsaQ3icltpQ/GcT4z/xTnWSxXkUvgvEAqjc=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGZetGSx+J2DsW2akHI1bXUBxwZLWJOp+r/vp
 Mjc/iI3BpjvEIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmXrRkAAoJELqXzVK3
 lkFP5qIL/1mam3EXhTaxS41hy26Dmq0UjeoUbnRZYhSzHmbvW3UT9tGd0CEzkRmrmeO5pdUckpq
 /Xdt4dyVI2zsF1mpS0/senLUoeACPSh46rmxp5ymGQQZ999WnsOewsF44Mjh/agSxFKYLIMWhTu
 HP0QK15UKiFYjQVS/IcARz0Rq96i8bWVETbMGfCvTSh9swmqxWj7VqNDY1mXl1MIHr+Mzh6tdB1
 AHaTV/HasD29w/8TIBI7J+II662XOod/LWhfuSYUKtkxKQgMCOw8wqIouOv1s9sdsnFR/6uaxEC
 GOHVm1t4sQ7GsSyaRwvEVP/aB5SnRGWn6408TrOz7E/Jn2sabbqUB9Ordb2H8FP0Ss88mW8kE2O
 GNFLoqO6pDYyWYSvXKLsugRX5f17Zhth9sYOdKExC+60DIQg2SFQoQRXHGGSVPBDFu/eLBCxlx9
 jOHJAUn2H18r9Amtf/jCtQG51NN+gJH/ndYTe9NkwKnQpjhiITpmpMdb6QjPMrDMs8MnrpY0xV6
 tI=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

From: Joel Granados <j.granados@samsung.com>

Erase the code comments mentioning "child" that were forgotten when the
child element was removed in commit 2f2665c13af48 ("sysctl: replace
child with an enumeration").

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 fs/proc/proc_sysctl.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 29d40f0ff3ff..2ef23d2c3496 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1298,28 +1298,23 @@ static struct ctl_dir *sysctl_mkdir_p(struct ctl_dir *dir, const char *path)
  * __register_sysctl_table - register a leaf sysctl table
  * @set: Sysctl tree to register on
  * @path: The path to the directory the sysctl table is in.
- * @table: the top-level table structure without any child. This table
- * 	 should not be free'd after registration. So it should not be
- * 	 used on stack. It can either be a global or dynamically allocated
- * 	 by the caller and free'd later after sysctl unregistration.
+ *
+ * @table: the top-level table structure. This table should not be free'd
+ *         after registration. So it should not be used on stack. It can either
+ *         be a global or dynamically allocated by the caller and free'd later
+ *         after sysctl unregistration.
  * @table_size : The number of elements in table
  *
  * Register a sysctl table hierarchy. @table should be a filled in ctl_table
  * array. A completely 0 filled entry terminates the table.
  *
  * The members of the &struct ctl_table structure are used as follows:
- *
  * procname - the name of the sysctl file under /proc/sys. Set to %NULL to not
  *            enter a sysctl file
- *
- * data - a pointer to data for use by proc_handler
- *
- * maxlen - the maximum size in bytes of the data
- *
- * mode - the file permissions for the /proc/sys file
- *
- * child - must be %NULL.
- *
+ * data     - a pointer to data for use by proc_handler
+ * maxlen   - the maximum size in bytes of the data
+ * mode     - the file permissions for the /proc/sys file
+ * type     - Defines the target type (described in struct definition)
  * proc_handler - the text handler routine (described below)
  *
  * extra1, extra2 - extra pointers usable by the proc handler routines
@@ -1327,8 +1322,7 @@ static struct ctl_dir *sysctl_mkdir_p(struct ctl_dir *dir, const char *path)
  * [0] https://lkml.kernel.org/87zgpte9o4.fsf@email.froward.int.ebiederm.org
  *
  * Leaf nodes in the sysctl tree will be represented by a single file
- * under /proc; non-leaf nodes (where child is not NULL) are not allowed,
- * sysctl_check_table() verifies this.
+ * under /proc; non-leaf nodes are not allowed.
  *
  * There must be a proc_handler routine for any terminal nodes.
  * Several default handlers are available to cover common cases -

-- 
2.43.0



