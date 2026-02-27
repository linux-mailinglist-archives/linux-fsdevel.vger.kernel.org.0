Return-Path: <linux-fsdevel+bounces-78751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UO+qGnXJoWmqwQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 17:42:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EE61BAEEA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 17:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A56C83090098
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD39346E66;
	Fri, 27 Feb 2026 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="PTddOnLl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753B7348883
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772210497; cv=none; b=rImI4MIPKsw4sF685BBqCPV6G08gfr8sJXgrNtjyzvJpUSrpO9m6d+zPsvRaIPqGMYWeo1aKNJRTvrqHxo0v/jIJfQN+7s6qI58zN64umHdZFbAYio9ww9k8OkNgNsP5ET5r2gr66XTywH3LvLkhI9Oju+GWXOyQNbm34KtsPqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772210497; c=relaxed/simple;
	bh=RY/e80+/kZp0ndnWK8kJgTORmskriDz0+BRBasqpa+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EVD1GSipjVj3dp2jHMrbf8VrnHrISuTaHL9UzTZP19rHwscnBfezGga2/G/mL0U0vGutTRhvL2Ffqqe0VJEvS9HQ31U01NuC22omPl8xJB37E70f8A5sfXLUcPu2skWOS2Xae9f3QAaeSLMsMWpc5wINoXZiVwLg0oVWb5gx+30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=PTddOnLl; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RGNJ4K992151
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 11:41:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=kqO9
	qkRdVrAKYYgOAexi6ZPIdSHNelQDaN7QKT4AcXo=; b=PTddOnLlQSm+yYDiHtdN
	PTkRtJtY1GOXc7dzRBrSEut2qC0a5yoxWHLbFwBCXJNaXWQjRik3Q30/YoJAORs/
	tV8lysYFLlp1xdJdiQog0twPAOTDGBbUlCSYutNFCvkbYLj9+omnS2s47xac/ZPl
	XIUMao1s3jA2dOW9R0xlfNEVE0HSAJByDZZ/L5oHGO3KC69V0CGvYvveqjr6lcvA
	4uwVfEUMmU6zq2INQ6mjKFGjJJki+hAmHF6H6YzB1Ha9UXW9n0Mz4fbFHHg1LOWi
	bdKXXfabnIMKvxUYun8J0pi6dcYMwSKfMa7rBzNLgu5oGRom3FpR819asMlkhhyj
	Jw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4cjpmqtd8e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 11:41:28 -0500 (EST)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-506549eb4b7so232199081cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 08:41:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772210487; x=1772815287;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kqO9qkRdVrAKYYgOAexi6ZPIdSHNelQDaN7QKT4AcXo=;
        b=MJUw/X/vj3O8h2HjdEPy28HVAimQxvbEXQ72Qk7hB5rRROYAVeolk6e4JQbrQmA+nB
         Dfwqh3s7rD7AJ/kcV1CpTAkvaQUyYlwJ1Z2CMGbiiexBUSCFd8vqG5g1d/MiEUrVy49M
         g1sYJAkBbN/igsO4ceOG9lqrVHX9TB/9ZuiTreBKixU6AfLcdR0XEa1ZAJ5uCosIBQBz
         FQBKlyMnklFNn7veAn/Kh4a02TaJHLoXw/crvMrkL9V2P1SJA7iRwaEqZ3Wz80a0fW0W
         TxB+sr/h09sziiIjiEsf0ZwJ12GN9nAgdjbmI8k4xeuVGUBe4xO71CCt2ZRv5vKtXQL/
         FcGA==
X-Forwarded-Encrypted: i=1; AJvYcCVVGz/260f89qN/oJd431wxq7/ej0oai78UwGLd44YlAfOpQc1MX0A6sNIecNErtJM2XFnoEt1s56XL2A0L@vger.kernel.org
X-Gm-Message-State: AOJu0YwWD/9hvcz1ened8mvmgssGnYdCM90LxGPp/7EddmK/d3ew1YfE
	/wt/j8Y7J4ZbJni5JYHoztAu1qqqtjWlRHyguYe/q6mg5dfrTguW0WweXznlHZBNdZWdEzjUe41
	R+ehKY1JBp44TvkocgzkN+oZSBjKJZybD9lEiIexwKbQrlXDUmD0cKHRBXwL14sY=
X-Gm-Gg: ATEYQzy4yjbBMFIrQa53UElGGn3rJhkOdlVHQVqjOgHE/VECBq/ntbq5MXd5yOxvwOw
	bMunYodFviTtjt3bi0ikh2zButFtdrtyVo5dX7K3cTtGgvUb/ZFFtnnJnX2kFWswihP08IBWYYB
	gG0Bam1u/gSyzgtsg57DKEI4QZxxAQv/nn/5Aq04mLthawUSGHuIrnOJ32B383Y7NnGpPmucVmM
	/yamzM0qNPMIbzQFJgIId0LYZOkBQfym0fM/KT0Wv1qEI8aR3qeqPjjFRmzqNealCdjU3w8pjjs
	frO/V7dGUpS3DgpxEbptuH8eWuSFPV0lQAuC19et51/0NVbUvp2YTZykLXZ6rpSV6iP9arK8Zm6
	yGT6eENKJPGGlPfeVAXO3lci1Aks3Lp0CX8g3F3T90edoij9mYyDIN4sTK4FIutKVu44=
X-Received: by 2002:ac8:584e:0:b0:506:1f48:9ffd with SMTP id d75a77b69052e-50752982c2cmr45010271cf.40.1772210487333;
        Fri, 27 Feb 2026 08:41:27 -0800 (PST)
X-Received: by 2002:ac8:584e:0:b0:506:1f48:9ffd with SMTP id d75a77b69052e-50752982c2cmr45009771cf.40.1772210486660;
        Fri, 27 Feb 2026 08:41:26 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c716caebsm46535886d6.15.2026.02.27.08.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 08:41:25 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 27 Feb 2026 11:41:07 -0500
Subject: [PATCH RFC v3 1/2] filemap: defer dropbehind invalidation from IRQ
 context
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-blk-dontcache-v3-1-cd309ccd5868@columbia.edu>
References: <20260227-blk-dontcache-v3-0-cd309ccd5868@columbia.edu>
In-Reply-To: <20260227-blk-dontcache-v3-0-cd309ccd5868@columbia.edu>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772210483; l=7573;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=RY/e80+/kZp0ndnWK8kJgTORmskriDz0+BRBasqpa+s=;
 b=5GcYGdmdWtXfKAIurXREVpzuab/QFgffaUCQqEN5lF8DAh34Uoemq2/kit/VagezIlDEV6Sb9
 UKFtKpmhpV5CPnT03p8sgafLGn7XkDEwTt1k4s69nfd83MAmaDzml1x
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: EsiSpcx9kKob4KeEaZfgGNY0QyMQL-Gv
X-Proofpoint-ORIG-GUID: EsiSpcx9kKob4KeEaZfgGNY0QyMQL-Gv
X-Authority-Analysis: v=2.4 cv=VYb6/Vp9 c=1 sm=1 tr=0 ts=69a1c938 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=-hUk4XeFNW921M1lpgYA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE0OCBTYWx0ZWRfXz57SLmB/hI2/
 fC1xLqazJTfn3CM9bHu7IKG2iN0WjcVW7sWjYLJOzD+n5EGPuEQHaiURWckk5Mr8x7YpBw+np7X
 ozKwP+ufLrBAKOSQhce3JCI06fE2ILPNNuGo9DZW7kaNwE/URShfecvnVqR0PlP06hBThOA/31/
 YJefAd/i4QW+jTQNxA9LMpv+vzhbBpuIXgUDL2s6cOm/LXDDX1nThY8h4LayoYLVg5N9kv1R2kz
 rkD6uKD+QMMkxQlYl6cM6wen7uJM6t1QK+kz5WfHPjtElsKB7yoLdkBrQ0+YJTsAOh3NRkF+UYN
 qx7eXHMJlRJCscqYNteUCKKTwJNneGneLAD2JCqKfXHyBYN2Mx3Z217hSmOwde8hN4/Xkz+FyK1
 N6UbymBUDNCT3G6cVUr2fj26+/ZUXFeUjWVno7UDXKLIMMK/HTAy/A2r3j1ANOsqcWMNpTiKA3Q
 ypxpKyIebx3+0jeHHkw==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11714
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=10 lowpriorityscore=10 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270148
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[columbia.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[columbia.edu:s=pps01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-78751-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[columbia.edu:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,columbia.edu:mid,columbia.edu:dkim,columbia.edu:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tz2294@columbia.edu,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C4EE61BAEEA
X-Rspamd-Action: no action

folio_end_dropbehind() is called from folio_end_writeback(), which can
run in IRQ context through buffer_head completion.

Previously, when folio_end_dropbehind() detected !in_task(), it skipped
the invalidation entirely. This meant that folios marked for dropbehind
via RWF_DONTCACHE would remain in the page cache after writeback when
completed from IRQ context, defeating the purpose of using it.

Fix this by adding folio_end_dropbehind_irq() which defers the
invalidation to a workqueue. The folio is added to a per-cpu folio_batch
protected by a local_lock, and a work item pinned to that CPU drains the
batch. folio_end_writeback() dispatches between the task and IRQ paths
based on in_task().

A CPU hotplug dead callback drains any remaining folios from the
departing CPU's batch to avoid leaking folio references.

This unblocks enabling RWF_DONTCACHE for block devices and other
buffer_head-based I/O.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/linux/pagemap.h |   1 +
 mm/filemap.c            | 130 ++++++++++++++++++++++++++++++++++++++++++++----
 mm/page_alloc.c         |   1 +
 3 files changed, 123 insertions(+), 9 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index ec442af3f886..ae0632cfdedd 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1260,6 +1260,7 @@ void end_page_writeback(struct page *page);
 void folio_end_writeback(struct folio *folio);
 void folio_end_writeback_no_dropbehind(struct folio *folio);
 void folio_end_dropbehind(struct folio *folio);
+void dropbehind_drain_cpu(int cpu);
 void folio_wait_stable(struct folio *folio);
 void __folio_mark_dirty(struct folio *folio, struct address_space *, int warn);
 void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb);
diff --git a/mm/filemap.c b/mm/filemap.c
index ebd75684cb0a..b223dca708df 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -49,6 +49,7 @@
 #include <linux/sched/mm.h>
 #include <linux/sysctl.h>
 #include <linux/pgalloc.h>
+#include <linux/local_lock.h>
 
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -1085,6 +1086,8 @@ static const struct ctl_table filemap_sysctl_table[] = {
 	}
 };
 
+static void __init dropbehind_init(void);
+
 void __init pagecache_init(void)
 {
 	int i;
@@ -1092,6 +1095,7 @@ void __init pagecache_init(void)
 	for (i = 0; i < PAGE_WAIT_TABLE_SIZE; i++)
 		init_waitqueue_head(&folio_wait_table[i]);
 
+	dropbehind_init();
 	page_writeback_init();
 	register_sysctl_init("vm", filemap_sysctl_table);
 }
@@ -1613,26 +1617,131 @@ static void filemap_end_dropbehind(struct folio *folio)
  * If folio was marked as dropbehind, then pages should be dropped when writeback
  * completes. Do that now. If we fail, it's likely because of a big folio -
  * just reset dropbehind for that case and latter completions should invalidate.
+ *
+ * When called from IRQ context (e.g. buffer_head completion), we cannot lock
+ * the folio and invalidate. Defer to a workqueue so that callers like
+ * end_buffer_async_write() that complete in IRQ context still get their folios
+ * pruned.
+ */
+struct dropbehind_batch {
+	local_lock_t lock_irq;
+	struct folio_batch fbatch;
+	struct work_struct work;
+};
+
+static DEFINE_PER_CPU(struct dropbehind_batch, dropbehind_batch) = {
+	.lock_irq = INIT_LOCAL_LOCK(lock_irq),
+};
+
+static void dropbehind_work_fn(struct work_struct *w)
+{
+	struct dropbehind_batch *db_batch;
+	struct folio_batch fbatch;
+
+again:
+	local_lock_irq(&dropbehind_batch.lock_irq);
+	db_batch = this_cpu_ptr(&dropbehind_batch);
+	fbatch = db_batch->fbatch;
+	folio_batch_reinit(&db_batch->fbatch);
+	local_unlock_irq(&dropbehind_batch.lock_irq);
+
+	for (int i = 0; i < folio_batch_count(&fbatch); i++) {
+		struct folio *folio = fbatch.folios[i];
+
+		if (folio_trylock(folio)) {
+			filemap_end_dropbehind(folio);
+			folio_unlock(folio);
+		}
+		folio_put(folio);
+	}
+
+	/* Drain folios that were added while we were processing. */
+	local_lock_irq(&dropbehind_batch.lock_irq);
+	if (folio_batch_count(&db_batch->fbatch)) {
+		local_unlock_irq(&dropbehind_batch.lock_irq);
+		goto again;
+	}
+	local_unlock_irq(&dropbehind_batch.lock_irq);
+}
+
+/*
+ * Drain a dead CPU's dropbehind batch. The CPU is already dead so no
+ * locking is needed.
+ */
+void dropbehind_drain_cpu(int cpu)
+{
+	struct dropbehind_batch *db_batch = per_cpu_ptr(&dropbehind_batch, cpu);
+	struct folio_batch *fbatch = &db_batch->fbatch;
+
+	for (int i = 0; i < folio_batch_count(fbatch); i++) {
+		struct folio *folio = fbatch->folios[i];
+
+		if (folio_trylock(folio)) {
+			filemap_end_dropbehind(folio);
+			folio_unlock(folio);
+		}
+		folio_put(folio);
+	}
+	folio_batch_reinit(fbatch);
+}
+
+static void __init dropbehind_init(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct dropbehind_batch *db_batch = per_cpu_ptr(&dropbehind_batch, cpu);
+
+		folio_batch_init(&db_batch->fbatch);
+		INIT_WORK(&db_batch->work, dropbehind_work_fn);
+	}
+}
+
+/*
+ * Must be called from task context. Use folio_end_dropbehind_irq() for
+ * IRQ context (e.g. buffer_head completion).
  */
 void folio_end_dropbehind(struct folio *folio)
 {
 	if (!folio_test_dropbehind(folio))
 		return;
 
-	/*
-	 * Hitting !in_task() should not happen off RWF_DONTCACHE writeback,
-	 * but can happen if normal writeback just happens to find dirty folios
-	 * that were created as part of uncached writeback, and that writeback
-	 * would otherwise not need non-IRQ handling. Just skip the
-	 * invalidation in that case.
-	 */
-	if (in_task() && folio_trylock(folio)) {
+	if (folio_trylock(folio)) {
 		filemap_end_dropbehind(folio);
 		folio_unlock(folio);
 	}
 }
 EXPORT_SYMBOL_GPL(folio_end_dropbehind);
 
+/*
+ * In IRQ context we cannot lock the folio or call into the invalidation
+ * path. Defer to a workqueue. This happens for buffer_head-based writeback
+ * which runs from bio IRQ context.
+ */
+static void folio_end_dropbehind_irq(struct folio *folio)
+{
+	struct dropbehind_batch *db_batch;
+	unsigned long flags;
+
+	if (!folio_test_dropbehind(folio))
+		return;
+
+	local_lock_irqsave(&dropbehind_batch.lock_irq, flags);
+	db_batch = this_cpu_ptr(&dropbehind_batch);
+
+	/* If there is no space in the folio_batch, skip the invalidation. */
+	if (!folio_batch_space(&db_batch->fbatch)) {
+		local_unlock_irqrestore(&dropbehind_batch.lock_irq, flags);
+		return;
+	}
+
+	folio_get(folio);
+	folio_batch_add(&db_batch->fbatch, folio);
+	local_unlock_irqrestore(&dropbehind_batch.lock_irq, flags);
+
+	schedule_work_on(smp_processor_id(), &db_batch->work);
+}
+
 /**
  * folio_end_writeback_no_dropbehind - End writeback against a folio.
  * @folio: The folio.
@@ -1685,7 +1794,10 @@ void folio_end_writeback(struct folio *folio)
 	 */
 	folio_get(folio);
 	folio_end_writeback_no_dropbehind(folio);
-	folio_end_dropbehind(folio);
+	if (in_task())
+		folio_end_dropbehind(folio);
+	else
+		folio_end_dropbehind_irq(folio);
 	folio_put(folio);
 }
 EXPORT_SYMBOL(folio_end_writeback);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cbf758e27aa2..8208223fd764 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6277,6 +6277,7 @@ static int page_alloc_cpu_dead(unsigned int cpu)
 	struct zone *zone;
 
 	lru_add_drain_cpu(cpu);
+	dropbehind_drain_cpu(cpu);
 	mlock_drain_remote(cpu);
 	drain_pages(cpu);
 

-- 
2.39.5


