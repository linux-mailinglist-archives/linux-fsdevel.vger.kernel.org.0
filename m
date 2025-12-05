Return-Path: <linux-fsdevel+bounces-70766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAF7CA73E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 11:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E821333F6C7A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 07:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E21303A1C;
	Fri,  5 Dec 2025 07:19:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FEA2FDC29;
	Fri,  5 Dec 2025 07:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919169; cv=none; b=TtGusZKd8R2Icc1U0edrhtxyIKP7dOKMXRg8muIbbCxOJrqGAHcEU174a1BghOgP4wrYzfWtb8dgrYaKVegiK3dft63s9SpNdfjvBXbYggXVcUyk33L9M1n/N1wSOK9+uILPcAqGPH6aUvYzuFnQTItKpJxWMxbmkfUFAjzNbE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919169; c=relaxed/simple;
	bh=OrmCL7AMrlriaPZyremlA931PaCPQXdxGExlE/vjDx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=r44rPMnojBwh/04wc6UfiBLOgqHpQS9Xxc5pFZha31B1d66pwZeE+AQSojJ8sCnr677L9fKFxe5NaM/IEga/4Fh0w2mEjAwtMxzYBAM3xOt0F/Jjmqw6MfAN46mj4x8g5SUTbXlVYfUuh2E2j8T6szyiehKCtF5qxzxZKKzpVYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-07-6932876c74aa
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
	linux-rt-devel@lists.linux.dev,
	2407018371@qq.com,
	dakr@kernel.org,
	miguel.ojeda.sandonis@gmail.com,
	neilb@ownmail.net,
	bagasdotme@gmail.com,
	wsa+renesas@sang-engineering.com,
	dave.hansen@intel.com,
	geert@linux-m68k.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v18 09/42] dept: record the latest one out of consecutive waits of the same class
Date: Fri,  5 Dec 2025 16:18:22 +0900
Message-Id: <20251205071855.72743-10-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSXUxTdxjG+Z/vFjrPKotHvYA0IxoZHzJ07wUazZZ5YrIM9cKoF/NETqCh
	gCvIh4KWSEvtlCgEmlm3toBFik4tcygoQ4RtbG5p+RAG2mJkFSxfQVsCWhRqdvPkl+d5n+fq
	ZXD5ELmOUWbniepsQaWgpIR0KsIal1WepEx0lq0CvfYUBE0tNOgd35Pg/KkJwfxrEw7aO28J
	eLUwQkN1KYIaVyUOU542EgYDkwhsY0sYBGsywVzbTIGvZpYCY7UTgfXpExzmJkYR9PtnKJhy
	XcJg+gYFroc+BE2Or8Bj8xJgnKCg5uYaMBnHMXhY95gAmyYG3lpyoMf9iASft5ICz+86Elo0
	ozQ4ni17d+/1ENDXeokCjWmehL9++4OAnouNBAQq1sO16VoKbP4ZGno7LBiU3q8jwDugw6DR
	3IDg1q9aBLqXSySUj7dR8LfpHxIeV7wgQFd/E4P+f9sQtOtHMajqtVCw2NCNQHt2gYYmFwH6
	rgAOt7rnaSh96UFwLfgIganbTe/Ywdubf8F4bW+Q4q/+eBXx2vPL8mByBucX/QMUfy9gIfj6
	M4sYf+fiE5ovax+meYvjGF/WNUXydXcnMN465yf5Yd823mE/Q6VGH5SmpIkqZb6oTth+WJrR
	5vmBOPpfeKHbcoHWoC6JATEMxyZzrcMfGZAkhHVjfnyFKXYDNzS0EOJINpprPuclDUjK4Gxf
	FFe+UBEKVrMC1/d8nFphgo3hnNZZeoVl7Fauw/iGfD8axTXd6AjdS5b96sHFEMvZLZzZMB8a
	5ViThGv9eRZ/X1jL3b8yRJxHMgsKsyO5Mjs/S1CqkuMzirKVhfFHcrIcaPnfbCVvDt1Gc859
	nYhlkCJC1lGwWSknhfzcoqxOxDG4IlI2qUpUymVpQtFxUZ3zjfqYSsztROsZQrFGlhQoSJOz
	6UKemCmKR0X1/ynGSNZpUEZmXovqZAIbNbFz69OqiGcnNkYeMWem/rkppf3T8E9i+9jr2jFz
	lD1WJR0dvCyMfBkscFvcO4v368PW1pKG1s/iYi/sts7xX3/A7jWH37ZHL6kUe4pd0boPT632
	JqYPeDb6xr/7wndg18cP4j4/oTCmByZflVR/G9aQWtZQP6I/3awgcjOEzZtwda7wDonAyddr
	AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSWUwTcRDG/e/ZVqtrJWHFB7XRmBA8MB5jPIK+sGi8HoiJL7KRjayUI62C
	mKgcNiAqQk1bpaAIUhCKYIsHkMYGFW8FqtIgUDEFJaAoUgjlsmB8mfxmvm++zMNIcMUjMkgi
	xp8Q1PG8SknJCNm+rRmrVZnrxXVtZcsgS3sOOtweEj6lOQjwDmcRUFBtoWDS9JCGLOt1El60
	pRPQfLcSgdubhWB03ISDtm6agEldEw3DY59p0KchmLY3ITC06HBwNT/GwVKbhsGfmikK+p8M
	IdB3eygw9qURMGi+hCC/10RD37Nw+OFuIGG68xsGbSMDCMyeKQw8jkwEk4ZYuFls868bflEw
	/vY9DkZ9M4Jb3Z04DPV9QVDb1IXAXp5OQU/ufRycnvnwwTtIwUv9RQp+tBRg8LOGgqJ0Owkt
	b/oRFJp0CHrb7RhklFRTYCi0ElD3pZ6Glv4JDDoMOgwqrXvBbe4l4HVuMeY/1++6FwgmYwbm
	L98x0Fc1YDBmrqDDShE3qs0huArbA4zTtk5SnOWGBXHjPh3ihkszcE6b62+fDAzi3HlbMlf6
	eoDifN6PFGcfKSK4V8Usd/uCD+Py3q7m6vI76QM7D8u2RQsqMUlQr90RJYtpcBcSiT1zT3UV
	5dGp6Kk0G0klLLOBLfF48RmmmFWsyzU2ywHMMtZ2uZfMRjIJzjiXspljObPCIoZnnd++UzNM
	MCvZ5lu/6BmWM5tYh3GC/Be6lK2sccz6pf65vs03ywpmI3sze5TMRbIiNKcCBYjxSXG8qNq4
	RhMbkxIvnlpzNCHOivz/ZD4zkfcIDTvDGxEjQcp5ckdyqKgg+SRNSlwjYiW4MkA+oFonKuTR
	fMppQZ1wRH1SJWga0RIJoQyU7z4kRCmYY/wJIVYQEgX1fxWTSINS0ZboEGNVZoHrxfHlwtk9
	tWf2WqwJW3bB4nDzAsXBz+NL7jzX5mzYOTIYRosPtuObo1pbxa/dPeW7nCH7I9QKmeZaEKkP
	iJxfGBpxxZVfZtNPVya9T429WlP/2xCpaFcvxLj6uAP8045reSsi3kljfoeKo+0LDmvKki8G
	uxLDfPuUhCaGDw3G1Rr+L3xIHd1LAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The current code records all the waits for later use to track relation
between waits and events within each context.  However, since the same
class is handled the same way, it'd be okay to record only one on behalf
of the others if they all have the same class.

Even though it's the ideal to search the whole history buffer for that,
since it'd cost too high, alternatively, let's keep the latest one when
the same class'ed waits consecutively appear.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 kernel/dependency/dept.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 1b16a6095b3c..f4c08758f8db 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -1486,9 +1486,28 @@ static struct dept_wait_hist *new_hist(void)
 	return wh;
 }
 
+static struct dept_wait_hist *last_hist(void)
+{
+	int pos_n = hist_pos_next();
+	struct dept_wait_hist *wh_n = hist(pos_n);
+
+	/*
+	 * This is the first try.
+	 */
+	if (!pos_n && !wh_n->wait)
+		return NULL;
+
+	return hist(pos_n + DEPT_MAX_WAIT_HIST - 1);
+}
+
 static void add_hist(struct dept_wait *w, unsigned int wg, unsigned int ctxt_id)
 {
-	struct dept_wait_hist *wh = new_hist();
+	struct dept_wait_hist *wh;
+
+	wh = last_hist();
+
+	if (!wh || wh->wait->class != w->class || wh->ctxt_id != ctxt_id)
+		wh = new_hist();
 
 	if (likely(wh->wait))
 		put_wait(wh->wait);
-- 
2.17.1


