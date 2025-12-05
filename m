Return-Path: <linux-fsdevel+bounces-70782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ED3CA737E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 11:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D4063362627
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 07:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E7833A036;
	Fri,  5 Dec 2025 07:21:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCE62F9987;
	Fri,  5 Dec 2025 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919266; cv=none; b=FjFtEsjpJ5VWQt4yr+dbLkbLnup9KqfXwidy5xnhZpVwjq8tSORUX+JdbdyTOlSGblH1MPOy3p8Hp3621NAJFatYjMN2uJhEdOJPFkpyCPGRZCcfdcs/1JN4I3ytCdtZSzAkUj8iKZL0j9u27c7Yh/oduc3TvdjBZMBZ6i8yzlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919266; c=relaxed/simple;
	bh=tzFeTdG2Ba6bz+SRXotP8ADb9g/FKw6lfmu1yyFoE6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=idpkBeMF2VGHq/nUoopsF08UYuiPkw7DuZ2Q3SY8hynlRgkZ0JUy+CD9K0BCg48ieoW6HRV2jAplDYSnXtMdm68ReH+liRjCIbVO54ah7vhkjSJx2B/xIVAzm7aBo17TDAEQNDuwpsNSL/65VVAmzuNWQkfNGkfS2PNl+aiPfPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-b5-6932877018f3
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
Subject: [PATCH v18 23/42] dept: print staged wait's stacktrace on report
Date: Fri,  5 Dec 2025 16:18:36 +0900
Message-Id: <20251205071855.72743-24-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxiGfc95z9vTzi7HzoWjLsE0M27GDyR+PDGb+/jhDllMVGLitmSz
	GydytBTSVpAlW4AJVMYIFlsCBazKR2dLZC1kCm1WQKtEUYQFqqKoY0XG55DSgEMGNf67ct+5
	r+fPw9Kqe8xqVtIZRb1Oo1UTBVaMLT+/KS0/Xoqbur0D+gcGGejN9mMIT5swVFxyETC5yxi4
	0ZeDYSBsQhB5YaMh98oChnlzQAbTsw9kYMlGsOALIAh2/UGDqzGbgucNLwmMtE8hKB3OxjBR
	W4igPGSTwfC1z2BsoIWBhYdDFNQOvqRg0J+PYMQ6ScDnyCHwd3ETDX+GJwh0WH4mMN5A4O6t
	EQSVNjOC0H0fBdZKN4Z+q5kCp3vv4gEC1t9iwFb6jAJLfQsFts6eRb89FQLOIRkMXM9j4Pes
	xzJwFYZoMDWHMbj/6mXgXF41hrKqfgJeXwcG0/w0gsDlpxT0NFcQKGxoYuCRa4GBLFuEgW5n
	F4aO8l8x3GmuZ6Cm7y4FTx4HGfB03qI/ThIiuUVYyO2eJ4KryoWEF3NmJLSPTtDCSU+GUHNz
	lAjVp+Yo4XTnJuFK+UOZYHcfF05eHWMEj2ODcME7TAn3Rz4U3BdPkX3vfan4IEnUSumifsvu
	w4pkX15MWuvuE06/hWQhe3wBkrM8t42vuxlBr/n5eCleYsKt54PBWXqJV3Jrec8vIaYAKVia
	64nl82eLosVbXALfeGMwOsbcOv7RvxayxEpuB3+mYoh+JY3lnQ3+KMsXc0vfXJRV3Hb+bEEk
	KuW5C3K+bjIHvxqs4lsdQVyMlHa07CJSSbr0FI2k3bY5OVMnndj8XWqKGy0+XO0P/311GU11
	JbYhjkXq5Up/xlZJxWjSDZkpbYhnafVK5ag2TlIpkzSZ34v61G/0x7WioQ2tYbE6Rhk/k5Gk
	4o5ojOIxUUwT9a9bipWvzkKxYU/o8zWsNBmI6y6pRgmOPR99vaIxJnFnOLFzY02OA6Q3vpXp
	l3FFLdYD74+jhKqWH2fqwVj9af5PY1Waeu86b8nR9r39Rw6f/aIYG94d7S3TVa7dr55JPCNv
	m3pnzrux0FhnN5h3Nb2ZWfK2seSTg33nxMA+/KB1+z+N488OpamxIVmzdQOtN2j+B8d9IUps
	AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf1CLcRzHfZ/n2bMfzD03sQd/cHOOc6JCPnd+/4EnDv3jHOfY6DlNa7ot
	EefHmmlCt1bPwqJJ7boapeZH3Jik8yuasA61nImuKamk1g8r55/PvT6f9/vzvs8fHwEuucOb
	JlCqk1mNWqGSkSJCtHmZPjwpPUoZ4XMLwWg4AZ98fh6817kJ6O0xEpBX5iBhyHqHD8aKizx4
	6k0joP5GKQJfrxFBX9CKg6FqhIAhcy0fevo/8oHTIRhx1SKweMw4NNY/xMHh1GHQXT5MQvvj
	Xwi4z34Sctt0BHTazyG41GrlQ9uT9fDDd58HI03fMPD+DiCw+4cx8LvTEQxZEiC/oDK0bvlJ
	QrDuNQ65XD2Cq5+bcPjV1oLAWduMwFWcRsJX0y0cGvwT4W1vJwnPuLMk/PDkYdBRToItzcUD
	z8t2BJetZgStH1wY6K+VkWC5XEFAVcs9PnjaBzH4ZDFjUFqxCXz2VgJemAqw0Lkh100pWHP1
	WKh8x4C7fh+DfnsJf3URYvoMmQRTUnkbYwxvhkjGccWBmOCAGTE9RXqcMZhC7eNAJ86cqjzE
	FL0IkMxA7zuScf22EczzApopPDOAMVl14UzVpSZ+7JodouVxrEqZwmoWrpSL4l2npUmPVh4u
	dXPkSWSLykBCAU0tprs7colRJqk5dGNjPz7KYdRMuvJ8Ky8DiQQ41TCDTu/PHBMmUTG086kf
	jTJBzaabuzhylMVUNJ2T9w3/FzqDLi13j7EwNOe8A2MsoZbQ+Rl9PBMS2dC4EhSmVKckKpSq
	JQu0CfGpauXhBXsPJFag0DvZjw1m3UU9DeurESVAsgli96FIpYSnSNGmJlYjWoDLwsQBVYRS
	Io5TpB5hNQd2aw6qWG01mi4gZFLxhm2sXELtUySzCSybxGr+q5hAOO0kejV+RUTOwa49X99q
	1xmX6o4Hiu8Kt0zWPqheFbdoe+GxtTt3wZeP4c1qofNNTkdw/y155JTriUeyC2KsJrncW/a+
	5c/MWk9NzlRpiWor/7it7mfY+e62zOEtWaufD0qjLzhjbJzVm9eYrZ8/9/SuwaC0JvZoQ8Ss
	ruyE5I0Os3FitIzQxisi5+EareIvhK/pGkoDAAA=
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
 include/linux/sched.h             |  2 ++
 kernel/dependency/dept.c          | 59 ++++++++++++++++++++++++++-----
 kernel/dependency/dept_internal.h |  5 +++
 3 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 385c5b3c5b0b..5834555a3d09 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -871,6 +871,7 @@ struct dept_task {
 	const char			*stage_w_fn;
 	unsigned long			stage_ip;
 	bool				stage_timeout;
+	struct dept_stack		*stage_wait_stack;
 	arch_spinlock_t			stage_lock;
 
 	/*
@@ -912,6 +913,7 @@ struct dept_task {
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
diff --git a/kernel/dependency/dept_internal.h b/kernel/dependency/dept_internal.h
index aa1a588805b3..a51ffb6e59c0 100644
--- a/kernel/dependency/dept_internal.h
+++ b/kernel/dependency/dept_internal.h
@@ -194,6 +194,11 @@ struct dept_ecxt {
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
-- 
2.17.1


