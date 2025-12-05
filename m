Return-Path: <linux-fsdevel+bounces-70777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0042FCA68C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 08:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A308032013C5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 07:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781AF321445;
	Fri,  5 Dec 2025 07:20:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC4C30F812;
	Fri,  5 Dec 2025 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919235; cv=none; b=kz7FiyP2hZ6KaGN2x/rBIQN7ahIKRsGs2OJDVZFdtJcfRpBb5Fa6im26Wpv5D83PRsiV4+OPHmKDOW9PDyBYWn/L1NUdZG541EdYb7ZI6dlqJr2eoTZP52PaWoCiM+wHrQCBHTa4Vqrljn/httVSk/EzNvGGsD3JZ0qINbhBSF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919235; c=relaxed/simple;
	bh=sXq6ZG2FCPgGrD/93i05yDVFGWV/kuOXrwRc2Zt22go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WQEoXHj1br6hhOkIMu4oJWAecNAViuex8E+hFyIaYcsqDCq3arz3ryKPz998HfLROHPTS9HO72NM++BYWLOs/Fc01oI3KL+8zEfMY23RsDH4Va3OgDCaetK91wlS4QP37kGRUaJCUj/orNg0quuvwYQQBSurTdr+DAbVLMl11sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-3d-6932876f6900
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
Subject: [PATCH v18 19/42] dept: apply timeout consideration to hashed-waitqueue wait
Date: Fri,  5 Dec 2025 16:18:32 +0900
Message-Id: <20251205071855.72743-20-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUwTdxjH97vf3fUldrl0JNz0D7cas8UERw3bHg0xxmTJxY1sybJkcSxa
	7UUutlSLgpgYKZWXKWBxa5tRwaPIhWlBpGPZpmBBF0XoaAG1TCqiWKNtARkvA3RYa/zvk+f7
	8jx/PHKsHqZWyoXcA7w5V2fQ0EpSGV/hTjOVbRDSR5wZUF5yFEZGxym4bfGRcPqCh4Ybd4pJ
	GJ0tRzC/5MIws3BXBnYLAkfwFIZQ4AoGz68WAqJXpxE4n1hImJQqEMRHL1GwHH5MgDT+PwEv
	HHvhjNtLQ9QxRcOSvx+D0x5AUD8WxjD95D6CjqZiGh7Z2jEMjr8NPfYTNMSDpwkQizsoCPZF
	EdS6TiGwNlygIRh9TsD5tizotbmJxFIaHBdTweW0EmBvvkRAX8MICVLRWnD5BxNXiCYIn7ST
	0BLvp2BmaIwAT0UEQ33pWRIud/SQUNHaTsE9zzIFAV8vBT01v5DQ/2czBV5/H4ZAdSUFzRNu
	Gn6ciCCIzkkYBnwiAZauBhIit0qJLXrunPc3gisZeEFznjoP4mYarZgrsSXoamwSc429MZpb
	nL1Fcx1zIsmd/WGR4Kr9adwfNWEZd6zzHxknth3kjl2LU5y3ad1XaduVmXreIOTz5o8271Tm
	zJ/I2lclO/SotZoqQmPUcaSQs0wG21gp4Tds7S6VvWKa+YANhRaS8xTmPdZbGUn4lXLMDK5m
	yxaqksI7zDdsuOV2MkAya9nI8sNkqYr5hJ16+rfsdelq9nyrL+lXJOb2O4tJVjMfs2eOzydL
	WcalYB84/yJeB95lu5pCpA2pRPTWOaQWcvONOsGQsT6nMFc4tH63ydiGEg8nHXn+3e9oOvB1
	N2LkSLNC5SvQCmpKl59XaOxGrBxrUlQxQ7qgVul1hYd5s2mH+aCBz+tGq+SkJlW1Ya5Ar2b2
	6A7we3l+H29+oxJyxcoi9H7mmq3azLquYVPt/qFPyWuKz/1NN2FL+vWJSZ9Vqsrh87/Vbixv
	OYJ2iGLl3LO6zpSjY75NoaltwZ/wfx+2L+ml70tatYdrHL7tWZ6+1Ow9ZZc7Jwfs/9YPuXtj
	ZSdrpxVCQcywa/hLyXalMVyU/fMaetvsF+JnlodZxvZsY52GzMvRaddhc57uJQZqz6ZsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzVSe0hTcRTud59zuLotyZsh6iCKIjPLOPSiIOgSJBVEEEGOvORyztjy1YPU
	tVwrTUeb1LJM54ppaZqW1cqU7GGWNlPRTM25Mi3LtDEfrbXon8N3zvfg++MIcPFdMkggUxzh
	lQqpXEIJCWH0OvXyxKxIWYRd6wdazUl43+sgoT2jjoCJcS0Bl8vLKJgx3aVBW3mRhOcdmQS0
	3CpF0DuhReCaMuGgqfUQMKNvpGHc3U2DIQOBx9aIwNiqx6Gz5TEOZXcyMPhZ8ZuC4YYxBIZ+
	BwX5QxkEjFrOIbjkNNEw9HQrfO19QIKn5xMGHb9GEFgcvzFw1GUhmDHGw9WiKq/d+J2CqeY3
	OOQbWhBc6+/BYWyoD8Gdxg8IbDcyKRjMrcbB7pgNbROjFLwwnKXga+tlDL5VUFCYaSOh9dUw
	ggKTHoGzy4aBuricAmNBJQG1ffdpaB2exuC9UY9BaeV26LU4CWjKLcK8db2q24Fgyldj3vEZ
	A8PNBxi4LVZ6UwniXJocgrNW1WCc5u0MxZVdKUPc1KQeceMlapzT5HrXhpFRnDtVlcKVNI1Q
	3OTEO4qz/SokuJdFLGc+M4lxec3LudpLPfSOzXuF62N5uSyZV67YGCOMc53dfjiHTh2syCPT
	UT+pQ34CllnNqutP038xxSxmOzvd+F8cwISyVdlOr0YowBl7CJvlzvER85jdbM+tdp+BYBax
	Ts+AL0jErGG/f3lN/wsNYUsr6nx6P+/d0DHpw2Imir2qc5G5SFiIZllRgEyRnCCVyaPCVfFx
	aQpZaviBxIRK5H0ny4npvHto3L61HjECJPEX1aWslIlJabIqLaEesQJcEiAakUfIxKJYadpR
	Xpm4X5kk51X1aKGAkASKtu3hY8TMQekRPp7nD/PK/ywm8AtKR7rjaz/o+sLz3UHdGz4+UgYL
	2y5ee/4ERUQ/655rX7Bsen4aCi5+bTXr1jTfW+Qgm5amUtl75pz66b/50M6+z+dnl2b/cK2q
	jhxy7DBzC6NDrwyYG8sD9lkfJh079mVLrIfxxCwJjAiqafKI+PgL5kBF6ECxBYkbiq4/juwK
	C8vbJSFUcdKVS3GlSvoHOHKecEoDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to hashed-waitqueue wait, assuming an input 'ret' in
___wait_var_event() macro is used as a timeout value.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/wait_bit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 179a616ad245..9885ac4e1ded 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -258,7 +258,7 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
 	struct wait_bit_queue_entry __wbq_entry;			\
 	long __ret = ret; /* explicit shadow */				\
 									\
-	sdt_might_sleep_start(NULL);					\
+	sdt_might_sleep_start_timeout(NULL, __ret);			\
 	init_wait_var_entry(&__wbq_entry, var,				\
 			    exclusive ? WQ_FLAG_EXCLUSIVE : 0);		\
 	for (;;) {							\
-- 
2.17.1


