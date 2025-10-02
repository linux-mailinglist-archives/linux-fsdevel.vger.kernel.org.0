Return-Path: <linux-fsdevel+bounces-63258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D0CBB32CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F2319E6393
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425AD31B10B;
	Thu,  2 Oct 2025 08:14:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7551B2DC79C;
	Thu,  2 Oct 2025 08:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392855; cv=none; b=TZktTbZW44KtqF8kEiPWE4WgneX6fauG8Va73Bggc66Yh7UvHN8nQACDiShtJM5Z8pJa3ASV05eCzKpCvLH8CVKK9k9K9KFNTBxzZVC5P7MLfK+vz4KG69jGPGvCuVH0lYlHnt7Zck2iyfFXzG+b/jydLI4lGiKOjg1qrACcf3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392855; c=relaxed/simple;
	bh=L0WtlCojLK6wupXqZkGVRPFE9pJaG7p+Z4/jZGhFssk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fj6QOLkACt3JDOHgR1xcoMTC5ShN/DiJrRXmgj0uFar3KxBZ6AuvZE/yU3XfwpLyGq9S3XNf0Fq9qMOoKlprPMJLnpMjJbMPVAJwklQr0Zv5+mQ8xflILP9NLwtaViHnY3PQDHF9/8VKALzefdRrdpggWD13FRn1mPVviNZ5LZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-f3-68de3419c66c
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com,
	torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org,
	tglx@linutronix.de,
	rostedt@goodmis.org,
	joel@joelfernandes.org,
	sashal@kernel.org,
	daniel.vetter@ffwll.ch,
	duyuyang@gmail.com,
	johannes.berg@intel.com,
	tj@kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	david@fromorbit.com,
	amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	kernel-team@lge.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	minchan@kernel.org,
	hannes@cmpxchg.org,
	vdavydov.dev@gmail.com,
	sj@kernel.org,
	jglisse@redhat.com,
	dennis@kernel.org,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	vbabka@suse.cz,
	ngupta@vflare.org,
	linux-block@vger.kernel.org,
	josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	dan.j.williams@intel.com,
	hch@infradead.org,
	djwong@kernel.org,
	dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	hamohammed.sa@gmail.com,
	harry.yoo@oracle.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	yunseong.kim@ericsson.com,
	ysk@kzalloc.com,
	yeoreum.yun@arm.com,
	netdev@vger.kernel.org,
	matthew.brost@intel.com,
	her0gyugyu@gmail.com,
	corbet@lwn.net,
	catalin.marinas@arm.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	luto@kernel.org,
	sumit.semwal@linaro.org,
	gustavo@padovan.org,
	christian.koenig@amd.com,
	andi.shyti@kernel.org,
	arnd@arndb.de,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	rppt@kernel.org,
	surenb@google.com,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	urezki@gmail.com,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	chuck.lever@oracle.com,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	kees@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	mark.rutland@arm.com,
	ada.coupriediaz@arm.com,
	kristina.martsenko@arm.com,
	wangkefeng.wang@huawei.com,
	broonie@kernel.org,
	kevin.brodsky@arm.com,
	dwmw@amazon.co.uk,
	shakeel.butt@linux.dev,
	ast@kernel.org,
	ziy@nvidia.com,
	yuzhao@google.com,
	baolin.wang@linux.alibaba.com,
	usamaarif642@gmail.com,
	joel.granados@kernel.org,
	richard.weiyang@gmail.com,
	geert+renesas@glider.be,
	tim.c.chen@linux.intel.com,
	linux@treblig.org,
	alexander.shishkin@linux.intel.com,
	lillian@star-ark.net,
	chenhuacai@kernel.org,
	francesco@valla.it,
	guoweikang.kernel@gmail.com,
	link@vivo.com,
	jpoimboe@kernel.org,
	masahiroy@kernel.org,
	brauner@kernel.org,
	thomas.weissschuh@linutronix.de,
	oleg@redhat.com,
	mjguzik@gmail.com,
	andrii@kernel.org,
	wangfushuai@baidu.com,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-i2c@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH v17 45/47] dept: track PG_writeback with dept
Date: Thu,  2 Oct 2025 17:12:45 +0900
Message-Id: <20251002081247.51255-46-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0wTdxjG/d737npt7HIpJJ6wRNbFbDEiatC8bk5Fk3FZmFnCzIyaaGcv
	tgxaLcJEM4PSKjGMdDXgnAgFXK20/BCnUbBGUDsRlSKOVQZFEKusQhVoUX7uitl/n/d53+d5
	8yYvgxVdVAyj1e0XDDpVupKWkbKh+eXxCxN9muWe0/FQUuukoTeUj2B88gyGaYtbArMuN4Li
	dguG0boZGgK3RhAU9Q3QcGrwCAlBWwGCwTvJMNTbSMHf4VcIbAMzBAzcPI5g8kEbhlNFHgTl
	fT0YXtaJ2h9uHwKX/SgNz82XMXQMfACPQ0EarEddFORV1tJw7WmDBNoDUwR0F1sIcNR/Da3m
	CkLcR0PxxQVQVN1IwDtblQTuV3aTMGvVg9vxQgI1Q20UtPg6KQj4LeIZfx6jYOxxHwHOAj+G
	/IYQCfXPxG75sXMknC7tpuG6q4WE/OkxBO6r/QR0NJTQUFB3mQKfc5aCRw4PCbUvvAS0uu+S
	0NZQTUG4MBa85ucIqocraDg57EcQCNvwBjU/biokedOjaZp3ljoRPzlhQfzY73mYN5nF8tar
	IOYnQn/RvCtsJfl7FRx/7bceCW+80SXhrfVZvPH2EMVfsi/hK68PEt8kbJOtVQvp2mzBkLBu
	l0zT39hP762JOzBxL4/KRYWxJ5CU4dhE7h/zBXwCMXM8W5YakWn2E87rfYcjHM3GcZd+9lMR
	xmzrh1xn+9IIR7FfcE97S4kIk+xi7nXu2bkZObuaa3JMovfxizhH3c25HKmod/S1khFWsKs4
	U9AoemXizBkpZxoNke8NC7kmu5c0I7kVzatCCq0uO0OlTU9cpsnRaQ8s263PqEfix9l+mtp+
	FY14UpsRyyDlfLlncY9GQamyM3MymhHHYGW0fJe9W6OQq1U5BwWDfqchK13IbEaxDKlcIF8Z
	/lGtYPeo9gs/CMJewfB/l2CkMbnIdAj9K2PSXIdrjAq++fxXD5taykrSqCj1t/jty3UpyXeC
	T4wnN251bt7UFqVRPihNsfkTUvSfBWZC4X3SRUmhjjcKz696nf7+p58nsWnDB2v0nd+V4fUf
	NeYmx2wxvrHvADpa/fDK5i7jyNQ8y9qlzqxtvxxv+X7Nx2e1HvjSt1VJZmpUK5ZgQ6bqP1UP
	GjJtAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTcRTG+793R4u3ZfWaQTYQ6aLN0Dh0o2++SEUQ0VV05EtbOq2tLINq
	NkdmZdtoSk7LSw1zprZlZKJ4ISFNdJkW5byMZVqaUbPy1tqCvhx+5zwPD8+Hw+CSOnIVo0w7
	I6jT5KlSSkSI9m7TRYbEDCpkRgcJ/VnNBEx7cwgoqqmiIMd+h4SeahuCoekcBL/mLDjo630E
	LJjaafDOfKDB19iOIN9pwqHqSRYGP2r/UPCl7TsC84iHgoLxLAKmrDcQFI5aaBh/EQeTQw0k
	+FyfMHj7cwKB1fMHA0/zVQQL+Slwr8xBwVxXNw4F5h4EpSMuHMZq/eKT9kEEjRVXKPhoqMOh
	17ME3kxPUfDSfJ2CSWcRBl9rKSi50khCscWEQFdeQ0F+sZ2A+uHnNDi/zGMwkG/CwGbfA0PW
	UQI6DWWYv5/f9XglWAp0mH+MYWB+1IDBjLWShlflAwRYteFg6eolwV1RSMP8SDT4StKh3faJ
	BtctMwHVk93kLjPif+nzCL7S8RTj9a8XKL7qbhXi52ZNiPc+0OG83uBf2yamcD7bcY5/0DlB
	8bPTfRTf+LOE4DvKON7YFcnXF7poPrvpPb1v6xHR9mQhVZkhqDftTBIp3A1u6lR12PnZDh2p
	RXmhuYhhODaG893bn4uCGIqN4N69m8EDHMyGcY6bo2SAcbZzNdfv3BjgZewObnjoLhZggg3n
	vmmL/3nE7BauxTaHAsyxazhbbfO/nCD/vXekkwiwhI3l9FPZmAGJStCiShSsTMtQyZWpsVGa
	FEVmmvJ81PF0lR35n8l6cd74DHl741oRyyDpYrEz3KWQkPIMTaaqFXEMLg0WJ1UMKCTiZHnm
	BUGdnqg+mypoWlEoQ0hXiuMPCkkS9oT8jJAiCKcE9X8VY4JWaVGE0xM23p87fjw2frvJebTm
	5KVEo8ouG1xxbd3l+Cg8JLRUtnpDgipcveVVQ9OxQ7e9wxpJzIXTLQlbzUcPX+8parofZ6or
	8zwe+x0ilt9pdicYuq/Sss2K5Et5QSjlUMT+xHLf7AFZf9/y3Q/dkuf2z+u129KNSy/e3txy
	Y+17RZuU0Cjk0etxtUb+F1bYeZtIAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Makes dept able to track PG_writeback waits and events, which will be
useful in practice.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mm_types.h   |  1 +
 include/linux/page-flags.h |  7 +++++++
 mm/filemap.c               | 11 +++++++++++
 mm/mm_init.c               |  1 +
 4 files changed, 20 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8ccbb030500c..bed1a3bc81e1 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -226,6 +226,7 @@ struct page {
 #endif
 	struct dept_page_usage usage;
 	struct dept_ext_wgen pg_locked_wgen;
+	struct dept_ext_wgen pg_writeback_wgen;
 } _struct_page_alignment;
 
 /*
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 3fd3660ddc6f..b965b16c8cee 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -203,6 +203,7 @@ enum pageflags {
 #include <linux/dept.h>
 
 extern struct dept_map pg_locked_map;
+extern struct dept_map pg_writeback_map;
 
 static inline int dept_set_page_usage(struct page *p,
 		unsigned int new_type)
@@ -279,6 +280,8 @@ static inline void dept_page_set_bit(struct page *p, int bit_nr)
 	dept_update_page_usage(p);
 	if (bit_nr == PG_locked)
 		dept_request_event(&pg_locked_map, &p->pg_locked_wgen);
+	else if (bit_nr == PG_writeback)
+		dept_request_event(&pg_writeback_map, &p->pg_writeback_wgen);
 }
 
 static inline void dept_page_clear_bit(struct page *p, int bit_nr)
@@ -288,6 +291,8 @@ static inline void dept_page_clear_bit(struct page *p, int bit_nr)
 	evt_f = dept_event_flags(p, false);
 	if (bit_nr == PG_locked)
 		dept_event(&pg_locked_map, evt_f, _RET_IP_, __func__, &p->pg_locked_wgen);
+	else if (bit_nr == PG_writeback)
+		dept_event(&pg_writeback_map, evt_f, _RET_IP_, __func__, &p->pg_writeback_wgen);
 }
 
 static inline void dept_page_wait_on_bit(struct page *p, int bit_nr)
@@ -298,6 +303,8 @@ static inline void dept_page_wait_on_bit(struct page *p, int bit_nr)
 	evt_f = dept_event_flags(p, true);
 	if (bit_nr == PG_locked)
 		dept_wait(&pg_locked_map, evt_f, _RET_IP_, __func__, 0, -1L);
+	else if (bit_nr == PG_writeback)
+		dept_wait(&pg_writeback_map, evt_f, _RET_IP_, __func__, 0, -1L);
 }
 
 static inline void dept_folio_set_bit(struct folio *f, int bit_nr)
diff --git a/mm/filemap.c b/mm/filemap.c
index edb0710ddb3f..d8f1816dc6c2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1187,6 +1187,13 @@ static void folio_wake_bit(struct folio *folio, int bit_nr)
 	key.bit_nr = bit_nr;
 	key.page_match = 0;
 
+	/*
+	 * dept_page_clear_bit() being called multiple times is harmless.
+	 * The worst case is to miss some dependencies but it's okay.
+	 */
+	if (bit_nr == PG_locked || bit_nr == PG_writeback)
+		dept_page_clear_bit(&folio->page, bit_nr);
+
 	spin_lock_irqsave(&q->lock, flags);
 	__wake_up_locked_key(q, TASK_NORMAL, &key);
 
@@ -1241,6 +1248,9 @@ static inline bool folio_trylock_flag(struct folio *folio, int bit_nr,
 struct dept_map __maybe_unused pg_locked_map = DEPT_MAP_INITIALIZER(pg_locked_map, NULL);
 EXPORT_SYMBOL(pg_locked_map);
 
+struct dept_map __maybe_unused pg_writeback_map = DEPT_MAP_INITIALIZER(pg_writeback_map, NULL);
+EXPORT_SYMBOL(pg_writeback_map);
+
 static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 		int state, enum behavior behavior)
 {
@@ -1683,6 +1693,7 @@ void folio_end_writeback(struct folio *folio)
 	 * reused before the folio_wake_bit().
 	 */
 	folio_get(folio);
+	dept_page_clear_bit(&folio->page, PG_writeback);
 	if (__folio_end_writeback(folio))
 		folio_wake_bit(folio, PG_writeback);
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 09e4ac6a73c7..fd2bf6689afa 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -589,6 +589,7 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
 	page_cpupid_reset_last(page);
 	page_kasan_tag_reset(page);
 	dept_ext_wgen_init(&page->pg_locked_wgen);
+	dept_ext_wgen_init(&page->pg_writeback_wgen);
 
 	INIT_LIST_HEAD(&page->lru);
 #ifdef WANT_PAGE_VIRTUAL
-- 
2.17.1


