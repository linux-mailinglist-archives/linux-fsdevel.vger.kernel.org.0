Return-Path: <linux-fsdevel+bounces-63242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FA7BB30F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463C44C46A2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E25A30F53F;
	Thu,  2 Oct 2025 08:14:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AC8309DDB;
	Thu,  2 Oct 2025 08:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392840; cv=none; b=gfmz260bZrj4apiluFxiiYnCzMCqOofrNdA6tVPo43RbUagsjaL3HSP2X7E0WZh2/e1xPEH/To7E2OhjmLNwX8gD25S/zaDe20L0QyHWmk48HQtIBrE7KdM3+MOhsEMWqB8lLC7Q3eRACZUm3+ut1FVhVs97DoPlg55ZXGHQ+Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392840; c=relaxed/simple;
	bh=bcQp5IhUS1q2m0mMxRS8TYYt9PpIlWI0k2NYBXs+czI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FfBD66zxfOSrHki86ymK03mZE9wCydWjfCldWhTh/LwUFJgud2HSTNgoS74UsE7pi5BRNM0falCoXPeG3yOA6RivfzhaHS2dvGkCLHWc1RrqF5orqz6NcaojfRyAcQyLC+hinP2E4+54iEEMCkQHHMsBDvw8C8poWSbpClvwIFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-94-68de3411c4f7
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
Subject: [PATCH v17 26/47] dept: print staged wait's stacktrace on report
Date: Thu,  2 Oct 2025 17:12:26 +0900
Message-Id: <20251002081247.51255-27-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSb0xTZxTG99773ts/0nmtJl51i6YJW6KiokjOh2mcmcm7aOIysy8SM5r1
	xlahkFZRSDQgqODcxqqgUlAKUitg0HYaIdQUMK2sNtChQpGCxSpDMGKlKLRb17rw5eSX55w8
	z/PhiGm5j1ku1mgPCTqtMkvBSrH0dZIpRZ42rN5gd8vgSZEDQ3VLMwul1ksMjIRLEbyPGGk4
	2RrDMD37VAQxuxNBpddAw0RXCEFFIMjChfEiDG/MZxHE/GMU9M9MIjAH/6Ug6DiN4EqdjYWI
	p4cGU8BPwx/OYQR2ywkWXpTfpqEv+Cl0V/zMwmtvNQU1RgOC4voWFiprrBhan7WJwDsRpWCo
	0kDFc+L6raVgvFBMxcffFMyaG0XwsH4Ig7kwGYyePgZGLVUiiAZSIVabA86mMRH4f6vAMPHS
	wMKI6xQD048CFJS2hTHYB9eA6dRVDO32bgzOu6MU9LVVs3D25m0GhptjDPQ63Az81dSLoWVs
	gAK38wGG7qrrGHrabjDQ0O+lwOZ5SG9TkUbbHYo0X25GZLqhmCYN7kmWzIUfs8Q+U4vJn3U8
	+d2TQlqr/CJScm9QRGqth4nNsprUt49TxBQKM2RwYguxNpax363ZK/1KJWRp8gTd+q2ZUnWV
	7xydG91y9J8uFypE46lnkETMc2n8jbIpep6v/nqdSjDLfckPDMx+1Jdwq3jbLy+ZBNOc+zP+
	iXdtghdz3/KlsyMowZhL5tvvXxYlWMal8+VFc+h/z5V8003HRx9JXO8LuHGC5dxm/uSbkniW
	NH5jlPCPI/MllvEdlgFcjmS16JNGJNdo87KVmqy0dep8reboup9ysq0o/nDmY9GMuyjUu6cT
	cWKkSJL1JvvVckaZp8/P7kS8mFYskWVahtRymUqZXyDocn7UHc4S9J1ohRgrlso2zhxRybn9
	ykPCQUHIFXTzW0osWV6IvlGdFr8q0O6sS9eO5Ar5J5xXIoUZkvMbUvLSe0rOb1qxONCQUTB5
	PLrS88G1/c6uismuUMelHcGLmi/eKfTtZZ8/9y3qyMw4cm3M8Mi19oAp/P37EtLverUwde++
	BzVJvu2BBaumHKHhWPfbg0zYh+b2/BCRT33N7772NFh8K6lrVIH1amXqalqnV/4H6AHiCWwD
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSa0xScRQA8P73Xu5FFu1GNu7KVaO51ju2srNetr54y2V9aGtrtWR6F0zU
	BmVZa6lIuR5GNHCKFflgJpQE1jKjmZQ9zIrsnUSUjyyRrTCHQga1vpz9zmNn58Ph46IbvBl8
	Rd4+TpUnU0pIASHIWK1ZPHX5R/kyf10CvC5uI2AkVEZAdZONhDJHJQ+eX7Ui8I2UIRgdN+Gg
	bZkgIKrvoCAU/kDBhKsDgdGjx8HWXIzBT/tvEr67fyAw+HtJqBgsJiBoOYWgqt9EweD9NAj4
	Wnkw4R3A4M2vIQSW3t8Y9LYdRxA15sDFGicJ413PcKgwPEdwye/F4as91mzu+IjA1VBCQp/u
	Og7dvVPg5UiQhEeGkyQEPNUYDNtJMJe4eHDepEegqW0iwXjeQUDLp1sUeL5HMOgx6jGwOjaD
	z9JPQKeuBovdF5u6JgZThQaLha8YGK60YhC2NFLwpLaHAEtRMpi6unnwuaGKgohfChPmfOiw
	DlDgPWMg4GrgGW+9AbGj2nKCbXTewFjtiyjJ2i7YEDs+pkdsqF6Ds1pdLHUPBXG21HmAre8c
	ItmxkVck6/plJtjHNQx7tmsx21LlpdjSO++prat2CNZkc0pFAadaui5TIK96dw7fG1l7MOp+
	gIrQoPQESuAz9HKmrvwyFjdJz2Pevg3jcSfScxjn6X5e3DjdmcS89iyKexq9kSkL+1DcBJ3M
	3L53gYpbSKcwuuIx9G/nbMZqb/u7JyFW7/Z3EnGL6BWMNliK6ZDAjCY1okRFXkGuTKFcsUSd
	Iy/MUxxckpWf60Cxb7IciZy9iULdae2I5iPJZKEn2SsX8WQF6sLcdsTwcUmiMLOhRy4SZssK
	D3Gq/N2q/UpO3Y5m8gmJWLhpO5cpovfI9nE5HLeXU/3vYvyEGUVItsed8TAyRdg6KTVt57fp
	7SXSe9t8FudccSg168SR4NSVGUdzsKVZL6VKc/3wrC/hdaG7UXv2Qk1Q3D/w9HpgtC8YcG03
	NS5TCeZItSn+yvQzuRsuZhxLtTrGq/VIJbYb53uT3H0pw4d8q9MrTrKH0xO3hLzbCncl2XpO
	3ybvSAi1XCZdgKvUsj8+is8qSQMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Currently, print nothing about what event wakes up in report.  However,
it makes hard to interpret dept's report.

Make it print wait's stacktrace that the event wakes up.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     |  5 ++++
 include/linux/sched.h    |  2 ++
 kernel/dependency/dept.c | 59 ++++++++++++++++++++++++++++++++++------
 3 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index 236e4f06e5c8..b6dc4ff19537 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -227,6 +227,11 @@ struct dept_ecxt {
 			 */
 			unsigned long	event_ip;
 			struct dept_stack *event_stack;
+
+			/*
+			 * wait that this event ttwu
+			 */
+			struct dept_stack *ewait_stack;
 		};
 	};
 };
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 95b1450f22fa..a01c10f28dfd 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -868,6 +868,7 @@ struct dept_task {
 	const char			*stage_w_fn;
 	unsigned long			stage_ip;
 	bool				stage_timeout;
+	struct dept_stack		*stage_wait_stack;
 	arch_spinlock_t			stage_lock;
 
 	/*
@@ -909,6 +910,7 @@ struct dept_task {
 	.stage_w_fn = NULL,					\
 	.stage_ip = 0UL,					\
 	.stage_timeout = false,					\
+	.stage_wait_stack = NULL,				\
 	.stage_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED,\
 	.missing_ecxt = 0,					\
 	.hardirqs_enabled = false,				\
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index f928c12111fe..1c6eb0a6d0a6 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -523,6 +523,7 @@ static void initialize_ecxt(struct dept_ecxt *e)
 	e->enirqf = 0UL;
 	e->event_ip = 0UL;
 	e->event_stack = NULL;
+	e->ewait_stack = NULL;
 }
 SET_CONSTRUCTOR(ecxt, initialize_ecxt);
 
@@ -578,6 +579,8 @@ static void destroy_ecxt(struct dept_ecxt *e)
 		put_stack(e->ecxt_stack);
 	if (e->event_stack)
 		put_stack(e->event_stack);
+	if (e->ewait_stack)
+		put_stack(e->ewait_stack);
 }
 SET_DESTRUCTOR(ecxt, destroy_ecxt);
 
@@ -794,6 +797,11 @@ static void print_dep(struct dept_dep *d)
 
 		pr_warn("[E] %s(%s:%d):\n", e_fn, fc_n, fc->sub_id);
 		print_ip_stack(e->event_ip, e->event_stack);
+
+		if (valid_stack(e->ewait_stack)) {
+			pr_warn("(wait to wake up)\n");
+			print_ip_stack(0, e->ewait_stack);
+		}
 	}
 
 	if (!irqf) {
@@ -807,6 +815,11 @@ static void print_dep(struct dept_dep *d)
 
 		pr_warn("[E] %s(%s:%d):\n", e_fn, fc_n, fc->sub_id);
 		print_ip_stack(e->event_ip, e->event_stack);
+
+		if (valid_stack(e->ewait_stack)) {
+			pr_warn("(wait to wake up)\n");
+			print_ip_stack(0, e->ewait_stack);
+		}
 	}
 }
 
@@ -1657,7 +1670,8 @@ static void add_wait(struct dept_class *c, unsigned long ip,
 
 static struct dept_ecxt_held *add_ecxt(struct dept_map *m,
 		struct dept_class *c, unsigned long ip, const char *c_fn,
-		const char *e_fn, int sub_l)
+		const char *e_fn, int sub_l,
+		struct dept_stack *ewait_stack)
 {
 	struct dept_task *dt = dept_task();
 	struct dept_ecxt_held *eh;
@@ -1691,6 +1705,7 @@ static struct dept_ecxt_held *add_ecxt(struct dept_map *m,
 	e->class = get_class(c);
 	e->ecxt_ip = ip;
 	e->ecxt_stack = ip ? get_current_stack() : NULL;
+	e->ewait_stack = ewait_stack ? get_stack(ewait_stack) : NULL;
 	e->event_fn = e_fn;
 	e->ecxt_fn = c_fn;
 
@@ -1797,7 +1812,7 @@ static int find_hist_pos(unsigned int wg)
 
 static void do_event(struct dept_map *m, struct dept_map *real_m,
 		struct dept_class *c, unsigned int wg, unsigned long ip,
-		const char *e_fn)
+		const char *e_fn, struct dept_stack *ewait_stack)
 {
 	struct dept_task *dt = dept_task();
 	struct dept_wait_hist *wh;
@@ -1825,7 +1840,7 @@ static void do_event(struct dept_map *m, struct dept_map *real_m,
 	 */
 	if (find_ecxt_pos(real_m, c, false) != -1)
 		return;
-	eh = add_ecxt(m, c, 0UL, NULL, e_fn, 0);
+	eh = add_ecxt(m, c, 0UL, NULL, e_fn, 0, ewait_stack);
 
 	if (!eh)
 		return;
@@ -2360,7 +2375,8 @@ static void __dept_wait(struct dept_map *m, unsigned long w_f,
  */
 static void __dept_event(struct dept_map *m, struct dept_map *real_m,
 		unsigned long e_f, unsigned long ip, const char *e_fn,
-		bool sched_map, unsigned int wg)
+		bool sched_map, unsigned int wg,
+		struct dept_stack *ewait_stack)
 {
 	struct dept_class *c;
 	struct dept_key *k;
@@ -2382,7 +2398,7 @@ static void __dept_event(struct dept_map *m, struct dept_map *real_m,
 	c = check_new_class(&m->map_key, k, sub_id(m, e), m->name, sched_map);
 
 	if (c)
-		do_event(m, real_m, c, wg, ip, e_fn);
+		do_event(m, real_m, c, wg, ip, e_fn, ewait_stack);
 }
 
 void dept_wait(struct dept_map *m, unsigned long w_f,
@@ -2498,6 +2514,9 @@ static void __dept_clean_stage(struct dept_task *dt)
 	dt->stage_w_fn = NULL;
 	dt->stage_ip = 0UL;
 	dt->stage_timeout = false;
+	if (dt->stage_wait_stack)
+		put_stack(dt->stage_wait_stack);
+	dt->stage_wait_stack = NULL;
 }
 
 void dept_clean_stage(void)
@@ -2561,6 +2580,14 @@ void dept_request_event_wait_commit(void)
 
 	wg = next_wgen();
 	WRITE_ONCE(dt->stage_m.wgen, wg);
+
+	/*
+	 * __schedule() can be hit multiple times between
+	 * dept_stage_wait() and dept_clean_stage().  In that case,
+	 * keep the first stacktrace only.  That's enough.
+	 */
+	if (!dt->stage_wait_stack)
+		dt->stage_wait_stack = get_current_stack();
 	arch_spin_unlock(&dt->stage_lock);
 
 	__dept_wait(&dt->stage_m, 1UL, ip, w_fn, 0, true, sched_map, timeout);
@@ -2579,6 +2606,7 @@ void dept_ttwu_stage_wait(struct task_struct *requestor, unsigned long ip)
 	struct dept_map m;
 	struct dept_map *real_m;
 	bool sched_map;
+	struct dept_stack *ewait_stack;
 
 	if (unlikely(!dept_working()))
 		return;
@@ -2597,6 +2625,10 @@ void dept_ttwu_stage_wait(struct task_struct *requestor, unsigned long ip)
 	m = dt_req->stage_m;
 	sched_map = dt_req->stage_sched_map;
 	real_m = dt_req->stage_real_m;
+	ewait_stack = dt_req->stage_wait_stack;
+	if (ewait_stack)
+		get_stack(ewait_stack);
+
 	__dept_clean_stage(dt_req);
 	arch_spin_unlock(&dt_req->stage_lock);
 
@@ -2607,8 +2639,12 @@ void dept_ttwu_stage_wait(struct task_struct *requestor, unsigned long ip)
 	if (!m.keys)
 		goto exit;
 
-	__dept_event(&m, real_m, 1UL, ip, "try_to_wake_up", sched_map, m.wgen);
+	__dept_event(&m, real_m, 1UL, ip, "try_to_wake_up", sched_map,
+			m.wgen, ewait_stack);
 exit:
+	if (ewait_stack)
+		put_stack(ewait_stack);
+
 	dept_exit(flags);
 }
 
@@ -2688,7 +2724,7 @@ void dept_map_ecxt_modify(struct dept_map *m, unsigned long e_f,
 	k = m->keys ?: &m->map_key;
 	c = check_new_class(&m->map_key, k, sub_id(m, new_e), m->name, false);
 
-	if (c && add_ecxt(m, c, new_ip, new_c_fn, new_e_fn, new_sub_l))
+	if (c && add_ecxt(m, c, new_ip, new_c_fn, new_e_fn, new_sub_l, NULL))
 		goto exit;
 
 	/*
@@ -2740,7 +2776,7 @@ void dept_ecxt_enter(struct dept_map *m, unsigned long e_f, unsigned long ip,
 	k = m->keys ?: &m->map_key;
 	c = check_new_class(&m->map_key, k, sub_id(m, e), m->name, false);
 
-	if (c && add_ecxt(m, c, ip, c_fn, e_fn, sub_l))
+	if (c && add_ecxt(m, c, ip, c_fn, e_fn, sub_l, NULL))
 		goto exit;
 missing_ecxt:
 	dt->missing_ecxt++;
@@ -2840,7 +2876,7 @@ void dept_event(struct dept_map *m, unsigned long e_f,
 
 	flags = dept_enter();
 
-	__dept_event(m, m, e_f, ip, e_fn, false, READ_ONCE(*wg_p));
+	__dept_event(m, m, e_f, ip, e_fn, false, READ_ONCE(*wg_p), NULL);
 
 	/*
 	 * Keep the map diabled until the next sleep.
@@ -2912,6 +2948,11 @@ void dept_task_exit(struct task_struct *t)
 		dt->stack = NULL;
 	}
 
+	if (dt->stage_wait_stack) {
+		put_stack(dt->stage_wait_stack);
+		dt->stage_wait_stack = NULL;
+	}
+
 	for (i = 0; i < dt->ecxt_held_pos; i++) {
 		if (dt->ecxt_held[i].class) {
 			put_class(dt->ecxt_held[i].class);
-- 
2.17.1


