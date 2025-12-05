Return-Path: <linux-fsdevel+bounces-70786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D68BCA6994
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 09:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 470003120255
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 07:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1E933D6DA;
	Fri,  5 Dec 2025 07:21:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B19B30FC1B;
	Fri,  5 Dec 2025 07:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919279; cv=none; b=Y/WBOtN1FvqkDHSxAiKEN1N/09tpVswI2C8D0Uc+FHsrJOk/29cvBFX4zDHyMzgqN37ACcFSFrrJ4KFZ7R+m7vGsBuLPhD9fsue8JoRsC7RxqODrnJ0D69oYViJwpZaB7aUiO67pyj15qY4ipPJ0v6d5iVSWFfFsXtIQXHvwRoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919279; c=relaxed/simple;
	bh=dXg8e2rzh2H4gF0Ka72kAtPI7B/nYlWBuWkbjIw85zc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KL8sfPLbDfy3xxOhPhIfSNR7pdleqMP23vVYM71myk3ST42W8zQ22MTyCeBIukaKRJPQNtg3V83H+jY2Xye+04RJYdwTEKuQ1xGJc6PGfWZPDM0wOodX4iCoPEzs15FBWcl1ZE7r1UfJJUVcPE8zRcftKcoOixzuB9eGMO/ce5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-8a-693287722131
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
Subject: [PATCH v18 30/42] dept: make dept stop from working on debug_locks_off()
Date: Fri,  5 Dec 2025 16:18:43 +0900
Message-Id: <20251205071855.72743-31-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0xTZxjG953znQvFLiedxk/U6GrQBDcHBsz7x+JIpvHIXzo10ZmMNXIm
	J5Zqyn3LsE4uBRW1SUGgIteGQI3aDgWEDdlEGaDFOujGpcVwkQgSkUIKOAYY/3nzy/O8z5s8
	ycvTKjcTxMu6BEmv02jVrAIrJlaVfa7P2imHXndsAWPGWfBNGzFYbtlYeFd0jwOjvYABj8+I
	IKN+EcM7UysH0/5eDsznELidv9Ng+/UcBW9v/8fCpPUigrGH+2Cxf5SCnplxBEPNWQjmO5/S
	kG92Iigd7KdhasyLoKnqFxZcQx/Dc98kC23mCyxMdFko6Op4haDe28BBX56JAo91BEP+GAt5
	d9ZCUf55amm8pMB88z4Ffms1Bx3lfRishmAo6nQx8KKqkIPWmlEO+i+bMbQNdDPwasTEgudR
	JgP3DN6lQg0+DE3/bofSzAoMBcV9LDQ2tWFwNVhYGLAtMmAommXgWY0Tw61RNwXtrY8x9HZe
	5qCyp4sCR2cHDc6rlxhwXxlGcPN1GRsZI85m5GKx2nGXEm3FNiTOz5mQmO5IFivbx1mxaaYE
	ixXZc5RYX9jPiSX2RDH9zwlGdFSFiOWNY5RYOuVjRHt1Nivap0zcgZBvFV/GSFo5SdJ/sft7
	RezcQi99ZlCZYjJlMwZ0PTAH8TwRwsm1woQPaLRtyEEBPCtsI263n17m1cJm4rg0wuQgBU8L
	rk0ky5+7YnwiHCS2xjq8nMVCMKl9wi3LSmEX+eeBi1lmImwiNbebV9YDlnRzz9wKq4QIciNn
	duUmEcoDyLC/hX0fWEceVLnxFaQsQR9VI5WsS4rTyNrwHbGpOjllx4nTcXa09G/WnxeO16Ep
	56EWJPBIvUrZnBwmqxhNUnxqXAsiPK1erRzXhsoqZYwm9UdJfzpan6iV4lvQeh6r1yp3ziTH
	qISTmgTplCSdkfQfXIoPCDKgw2ERiwsFu/enh/vpbzZ6hN8i6waihraG7j/UnndqT0V3ZNqa
	MndNRNigvThu9P6jY3Vv1qSu+zRLPWkIjD7y0/ATXffw3r/a1m9VKXJrn772HB8wBf0QGW3x
	Pvvs6LaStLQNg28Of3cHyu0nn0dF1XrJ3ZGNylj+qz0J/q9l+INY/lbj+FhNWAitj9f8D5qj
	NXtrAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH+93XrqvFZQreLDJGDwrUjB4njSyivARF9U8PAl12y+V8tJVl
	EPloOdeDeWOTWqZpjtBVplmajUzLUntsWWmPZdZaiZY9Ns3ptCn0z+Fzvg84fxwal94iQ2hF
	ygFelSJXyigxId4YnRO2P3eRYmHRieWg1RyD911OEl5nNRDgcWsJuHDdQoHPdFsE2qpzJDzu
	yCbAdq0CQZdHi2Bw2ISDpm6MAJ/QLAL30DsRGLIQjFmbERjtAg6dtns4WG5mYfCncpSC3qbf
	CAzdTgoKerII6DefQnDeZRJBz8NY+N5VT8KY4ysGHQN9CMzOUQycDbkIfMYkKCqp9teNPykY
	fvochwKDDcGlbgcOv3s+IrjZ/AGB9Uo2BV/0NTi0O6fCS08/BS2GkxR8t1/A4EclBcXZVhLs
	T3oRFJoEBK63VgxySq9TYCysIqDu4x0R2HtHMHhvFDCoqNoAXWYXAW36Esx/rj91IxhMBTmY
	f3zDwHC1HoMhc7loVRniBjVnCK68+hbGaV74KM5y0YK4Ya+AOHdZDs5p9P61qa8f545XH+LK
	2voozut5RXHWgWKCay1huct5XozLfxrG1Z13iDat3iFesZtXKtJ5VcTKeHGid+QdntYtOSwI
	eWQmKpysQzTNMotZrWWGDgXQFDOP7ewcwsc5iJnFVp92kTokpnGmPZTNHTozYQQym1nL3Vpi
	vEswc9iaZ6JxWcIsZd/cbyfHmWVC2YrKhol4gF83dHgnWMosYYt0g6QeiYvRpHIUpEhJT5Yr
	lEvC1UmJGSmKw+EJqclVyP9N5qMj+bXI3R7biBgayaZIGg5FKqSkPF2dkdyIWBqXBUn6lAsV
	UsluecYRXpUapzqo5NWNaDpNyIIl67fy8VJmr/wAn8Tzabzqv4vRASGZ6FOuRx+1LDg1L06Y
	Vhj76+ze0GjnhuiZMZFcRIJ0135HZtRz2zpX/WhZ3d/YmCO+uX/rY6Jaz32+lscHTgoocr/V
	F+swtDi1Bp3etpKcvjbOs2PngwH79tbA/HzDAluE8Ge7M7zUl/jAkdEy40NIz/zh1Vvmp+n3
	qOKa2H3q2WseyQh1ojxyAa5Sy/8BP5Wpp0kDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

For many reasons, debug_locks_off() is called to stop lock debuging
feature e.g. on panic().  dept should also stop it in the conditions.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     | 2 ++
 kernel/dependency/dept.c | 6 ++++++
 lib/debug_locks.c        | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index bbcb48f6140a..8b41f7a65abb 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -142,6 +142,7 @@ struct dept_ext_wgen {
 	unsigned int wgen;
 };
 
+extern void dept_stop_emerg(void);
 extern void dept_on(void);
 extern void dept_off(void);
 extern void dept_init(void);
@@ -194,6 +195,7 @@ struct dept_ext_wgen { };
 
 #define DEPT_MAP_INITIALIZER(n, k) { }
 
+#define dept_stop_emerg()				do { } while (0)
 #define dept_on()					do { } while (0)
 #define dept_off()					do { } while (0)
 #define dept_init()					do { } while (0)
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index a0eb4b108de0..1de61306418b 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -187,6 +187,12 @@ static void dept_unlock(void)
 	arch_spin_unlock(&dept_spin);
 }
 
+void dept_stop_emerg(void)
+{
+	WRITE_ONCE(dept_stop, 1);
+}
+EXPORT_SYMBOL_GPL(dept_stop_emerg);
+
 enum bfs_ret {
 	BFS_CONTINUE,
 	BFS_DONE,
diff --git a/lib/debug_locks.c b/lib/debug_locks.c
index a75ee30b77cb..14a965914a8f 100644
--- a/lib/debug_locks.c
+++ b/lib/debug_locks.c
@@ -38,6 +38,8 @@ EXPORT_SYMBOL_GPL(debug_locks_silent);
  */
 int debug_locks_off(void)
 {
+	dept_stop_emerg();
+
 	if (debug_locks && __debug_locks_off()) {
 		if (!debug_locks_silent) {
 			console_verbose();
-- 
2.17.1


