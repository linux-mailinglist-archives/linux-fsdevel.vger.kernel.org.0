Return-Path: <linux-fsdevel+bounces-78408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDVpFwV7n2lYcQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 23:43:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B306419E686
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 23:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 872C530D11C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 22:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9653624A8;
	Wed, 25 Feb 2026 22:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="dk9Jybov"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E6E35C1BF
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 22:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772059307; cv=none; b=B4KbykcY+LKHREz0zROp/E7z74tDHWU+wfiDK5vyyVbfA27JqUYEPsMvSIa4XlGf39EPSdTsbH92CQYioR1soLg/Zf2509is/+LN3tGoiK4H5XWB2oI8fWN8X0BUOBtA8AOvJdgASGEkRNhEKbDDbyTYn7ugzD3z9u/1oU0/Yv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772059307; c=relaxed/simple;
	bh=wvO7UclkDfOFQdfC1evvQhRGdmzqdeL+WI5Bp8USXg0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BI7pQGVlA3eyPJ1pi/4eu2tmQzvvuAqqFmRVLXgSdkDEUgml4qf20owgH2tPxybNbWlz06JyCBRtSw2CrqzfLoprdAF9ittAdGtV/lViPwqXb8ClPy06YhtNYEDrl5oO7OL38iv/LR5LdSGZzS8zSZhU/jhlRkLlB+M3Ef2wygQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=dk9Jybov; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PMBw5w3911780
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 17:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=B+x8
	HlKrObJCF5zGXiosgMuiJzbAlNo3I+yj4hi3OCU=; b=dk9Jybovs8IHdEvEGP9P
	/Q+tTmC5El4AZB2gHDz4eA8v6PeKwiNC27gSP64f3zuophROaYaLhYmmHZXiKwMJ
	NSRp7hKX/59LhbwItsKVPFd7Crde5MZ4zs3tGudNHcoxx4fALdYT98VxFmtL21u7
	fGfx2Y40whZsXWbmDY0qeSprynaAbzY7D4ttYLp1lNjUZRCarCpKgXdwbIuqQBKo
	dAh2ixL7cwqcSMAUrxeiWUHwrgu0D6JUMLqoY/Z34kR3anogYSc0Opb+0Pn0KWVM
	aWbq5vkVIyD/o2s7Co6n14E/UIIBlvbWXdW76yZm6WRRtPqcpoGOJFPXc2AOxDga
	cA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4chsqwxkkb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 17:41:39 -0500 (EST)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-506bfff75edso29152621cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 14:41:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772059299; x=1772664099;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B+x8HlKrObJCF5zGXiosgMuiJzbAlNo3I+yj4hi3OCU=;
        b=pSbUxU57MRsSU3O8+NCE+lr2D3WZl8y/j/DnvxKgDHhjXHwjaPaVHeOvbLA0p6q1D+
         0aE8SJbv7OweOngV2BNc1exlMLg5tniZLJ1HPb2Y7ectOjBAhRVjlYcBd4eVZUx4ROmR
         O6uVmaCOAtTyB/VKBqyWNf8xWbX7h71mbI8d0OOBtPqTPsgsv8nF8iulwOZJ5LaaB54R
         MPfw4RIW0c/T2/XT1vuh7Cxfphcyu/gQqbNMldl9j1X6O0zSck4v8fiRkYsu30gu5lME
         qRGbiwrEdPiPrjqMhaRS+1zYM3MwguSCIr3d0wrEA4lOHATw08ztILJspsEzXWXYLQVD
         bozw==
X-Forwarded-Encrypted: i=1; AJvYcCUfVoowWC3v509TeNioJvnB6k1TZ0oOXh1swr6kdAQ3ZzXRhJjVj3m58f3R/5UqwCofdBL/nQs1v9ymyKoQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzixCAS0Mi9mc3kr1owdPpbcr9Y5ZPbfGUtPq07Wkxla44MAWqX
	ZwV8sTqQE37Y5eZcfVDvmdJ0w/cgkTKKuhCqRV/K9PuHFL4dKtFoyPfrhc/yWSkfqm7Uypw2rhW
	aDHiPtNS7HElhho/rR6PZhZP05YG44HJl3QqBTbnBfTEv8hfhVjF4dkBQCkpHIO0=
X-Gm-Gg: ATEYQzwXRdo/4HP5T1Pr2/7Wvh7nfi4G0EB+E2wYU0keVb306nlCfAIkqWfk32Pw8Xq
	NLamXSKjvX6O2m7i4peGv5HE1k77ME/l8QTHYHN0gjlXtWpVMgJI/zAbN37dYd55gbTv3zQfuvA
	FBGkq48tQZyCF83xMh2SY6FJRwo7myNHEYTjANUr9iRh/N7vFKLSpeBRz5zCp1SZ5pDqIaBC0nP
	Z/t/sNxG5GSJvA8WR8cPFJ+OVO5n3fnWbgYuKVtkQH3Jxd1qeKVDD8+ftVNIE77+uBvt5aMFzxW
	fsQwsN2GbzK2k+a0tofPYoMrMZtgVz7celat+pUcHoVhIQ460VEO5T0HsCNODpPKn21MAtMfOhE
	oRPbsqgAUo/s8yn8+NrIcWQdhfU3JR6YL
X-Received: by 2002:a05:622a:44:b0:4f3:59c1:768c with SMTP id d75a77b69052e-507460dc42emr758521cf.60.1772059298702;
        Wed, 25 Feb 2026 14:41:38 -0800 (PST)
X-Received: by 2002:a05:622a:44:b0:4f3:59c1:768c with SMTP id d75a77b69052e-507460dc42emr758291cf.60.1772059298273;
        Wed, 25 Feb 2026 14:41:38 -0800 (PST)
Received: from [127.0.1.1] ([216.158.158.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507449be47dsm4196231cf.15.2026.02.25.14.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 14:41:37 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 25 Feb 2026 17:40:56 -0500
Subject: [PATCH RFC v2 1/2] filemap: defer dropbehind invalidation from IRQ
 context
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-blk-dontcache-v2-1-70e7ac4f7108@columbia.edu>
References: <20260225-blk-dontcache-v2-0-70e7ac4f7108@columbia.edu>
In-Reply-To: <20260225-blk-dontcache-v2-0-70e7ac4f7108@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Yuezhang Mo <yuezhang.mo@sony.com>, Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Bob Copeland <me@bobcopeland.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-karma-devel@lists.sourceforge.net,
        linux-mm@kvack.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772059296; l=4861;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=wvO7UclkDfOFQdfC1evvQhRGdmzqdeL+WI5Bp8USXg0=;
 b=h4bisF4GoCaCSoqd37/ZfJNSaUymW/3u+9LXcqmZG0KnRoDbGHtk/4qRW+EsLRX8yAk3THDOa
 S2MblO1dCLPBna+BzWEdZKkpfva3GYEHQU94DPCiujOK2l2fhb+tpu1
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: fCNijhs4jm_jAGF6J2L-ETni7g82yejM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDIxNyBTYWx0ZWRfX9rJ1hyL1Cwcp
 raG5yMrum+8MdqZbfzBDgvyKJXGD2JAMtstDwGI0QkKE5K3WhLN4USm6nYNg1EB+Dv33WjDQ5Qq
 OAXQQnDpGucJKY/P+kG7oYZ1cyTnf8gExM+5b5gPWHUXF1HOkuJ9zu40A4Zm0+ZwGhOrtcOxHWR
 PDSftAG7Fgkvf21FIWKXQXJtA7WshrrGtBtYtZ9/8MrXkoOBRFL293X0IV16ZyFbC3Erm70q60H
 JguqImLE2rU+ywpfdGdYx5aP6L8uWBcNq2G75f2RllcMlBqaEYcrFDi2t6FySt7idIf+oU3GE6l
 QItM2QaNZB6p5xNO4UBW24GD2J9nOvCvSwP5RJZNmvHwGCdHitP3BrV9VwHEb+pXRsOnUtPeJKn
 YFsVoiWhpevKndvkATLlWIxEISEm4pddTtmmuffuA9Reg3UvcVOPBMR9i7JpWb9q6OxMtP3bQyS
 Y7f3D0TKEZxdXsAxRWA==
X-Authority-Analysis: v=2.4 cv=Y8b1cxeN c=1 sm=1 tr=0 ts=699f7aa3 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=mD05b5UW6KhLIDvowZ5dSQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=wj6egcThClJy_xBgiekA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: fCNijhs4jm_jAGF6J2L-ETni7g82yejM
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11712
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 clxscore=1015 priorityscore=1501 bulkscore=10 adultscore=0
 lowpriorityscore=10 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250217
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[columbia.edu,none];
	R_DKIM_ALLOW(-0.20)[columbia.edu:s=pps01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78408-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[columbia.edu:mid,columbia.edu:dkim,columbia.edu:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[kernel.dk,gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,samsung.com,sony.com,dubeyko.com,paragon-software.com,bobcopeland.com,infradead.org,linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[columbia.edu:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tz2294@columbia.edu,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B306419E686
X-Rspamd-Action: no action

folio_end_dropbehind() is called from folio_end_writeback(), which can
run in IRQ context through buffer_head completion.

Previously, when folio_end_dropbehind() detected !in_task(), it skipped
the invalidation entirely. This meant that folios marked for dropbehind
via RWF_DONTCACHE would remain in the page cache after writeback when
completed from IRQ context, defeating the purpose of using it.

Fix this by deferring the dropbehind invalidation to a work item.  When
folio_end_dropbehind() is called from IRQ context, the folio is added to
a global folio_batch and the work item is scheduled. The worker drains
the batch, locking each folio and calling filemap_end_dropbehind(), and
re-drains if new folios arrived while processing.

This unblocks enabling RWF_UNCACHED for block devices and other
buffer_head-based I/O.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 mm/filemap.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 79 insertions(+), 5 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index ebd75684cb0a..6263f35c5d13 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1085,6 +1085,8 @@ static const struct ctl_table filemap_sysctl_table[] = {
 	}
 };
 
+static void __init dropbehind_init(void);
+
 void __init pagecache_init(void)
 {
 	int i;
@@ -1092,6 +1094,7 @@ void __init pagecache_init(void)
 	for (i = 0; i < PAGE_WAIT_TABLE_SIZE; i++)
 		init_waitqueue_head(&folio_wait_table[i]);
 
+	dropbehind_init();
 	page_writeback_init();
 	register_sysctl_init("vm", filemap_sysctl_table);
 }
@@ -1613,23 +1616,94 @@ static void filemap_end_dropbehind(struct folio *folio)
  * If folio was marked as dropbehind, then pages should be dropped when writeback
  * completes. Do that now. If we fail, it's likely because of a big folio -
  * just reset dropbehind for that case and latter completions should invalidate.
+ *
+ * When called from IRQ context (e.g. buffer_head completion), we cannot lock
+ * the folio and invalidate. Defer to a workqueue so that callers like
+ * end_buffer_async_write() that complete in IRQ context still get their folios
+ * pruned.
  */
+static DEFINE_SPINLOCK(dropbehind_lock);
+static struct folio_batch dropbehind_fbatch;
+static struct work_struct dropbehind_work;
+
+static void dropbehind_work_fn(struct work_struct *w)
+{
+	struct folio_batch fbatch;
+
+again:
+	spin_lock_irq(&dropbehind_lock);
+	fbatch = dropbehind_fbatch;
+	folio_batch_reinit(&dropbehind_fbatch);
+	spin_unlock_irq(&dropbehind_lock);
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
+	spin_lock_irq(&dropbehind_lock);
+	if (folio_batch_count(&dropbehind_fbatch)) {
+		spin_unlock_irq(&dropbehind_lock);
+		goto again;
+	}
+	spin_unlock_irq(&dropbehind_lock);
+}
+
+static void __init dropbehind_init(void)
+{
+	folio_batch_init(&dropbehind_fbatch);
+	INIT_WORK(&dropbehind_work, dropbehind_work_fn);
+}
+
+static void folio_end_dropbehind_irq(struct folio *folio)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dropbehind_lock, flags);
+
+	/* If there is no space in the folio_batch, skip the invalidation. */
+	if (!folio_batch_space(&dropbehind_fbatch)) {
+		spin_unlock_irqrestore(&dropbehind_lock, flags);
+		return;
+	}
+
+	folio_get(folio);
+	folio_batch_add(&dropbehind_fbatch, folio);
+	spin_unlock_irqrestore(&dropbehind_lock, flags);
+
+	schedule_work(&dropbehind_work);
+}
+
 void folio_end_dropbehind(struct folio *folio)
 {
 	if (!folio_test_dropbehind(folio))
 		return;
 
 	/*
-	 * Hitting !in_task() should not happen off RWF_DONTCACHE writeback,
-	 * but can happen if normal writeback just happens to find dirty folios
-	 * that were created as part of uncached writeback, and that writeback
-	 * would otherwise not need non-IRQ handling. Just skip the
-	 * invalidation in that case.
+	 * Hitting !in_task() can happen for IO completed from IRQ contexts or
+	 * if normal writeback just happens to find dirty folios that were
+	 * created as part of uncached writeback, and that writeback would
+	 * otherwise not need non-IRQ handling.
 	 */
 	if (in_task() && folio_trylock(folio)) {
 		filemap_end_dropbehind(folio);
 		folio_unlock(folio);
+		return;
 	}
+
+	/*
+	 * In IRQ context we cannot lock the folio or call into the
+	 * invalidation path. Defer to a workqueue. This happens for
+	 * buffer_head-based writeback which runs from bio IRQ context.
+	 */
+	if (!in_task())
+		folio_end_dropbehind_irq(folio);
 }
 EXPORT_SYMBOL_GPL(folio_end_dropbehind);
 

-- 
2.39.5


