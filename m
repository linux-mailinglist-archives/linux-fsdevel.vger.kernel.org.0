Return-Path: <linux-fsdevel+bounces-63245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC85BBB31A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E363746341F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0D72DC79B;
	Thu,  2 Oct 2025 08:14:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8E830E85F;
	Thu,  2 Oct 2025 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392845; cv=none; b=NbYf0SZEV71k5+Ixytld0g8yZKf+e/CunfSTBdcMHmzrHxS36WNThzxDMeqT11vwDHhobS/SsWhPd9SwAYHpCosKbdfN4TGfqGQOR9nZ+jd5WgxB9UnouRt1Pat52kRQ6oCuzmAIk9lgwScdl7c54q+UuroeTCxQTcMKCySkRKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392845; c=relaxed/simple;
	bh=51wXDfJ/geJNTOX9kWjDa7gjFY+JiMiLA1OUeeWv4bs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Zn5ASmy5PvEXrsx9Vx3KX+M/3yhGAQ7z5lnRl9QC1fsBSSR6edBBK1X+x/Geu7s4eigxV3UW45Oz16kfK4SbyDm0DGckG/AkamjWmZizoTgqjzw7Y62ulaLTDIkwnBNcGLASn8hhkP3bNvQ93mbhOYebQH8+qzRYcE5y6NPywjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-29-68de3412f163
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
Subject: [PATCH v17 30/47] fs/jbd2: use a weaker annotation in journal handling
Date: Thu,  2 Oct 2025 17:12:30 +0900
Message-Id: <20251002081247.51255-31-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSe0xTVxwH8J1zz723rTS7KWa7oMmWZiiRoRtj5ud8bJnLdhcT2GL8Z49o
	N27WRijaKlqnCQpV5sQUnGAACbbQdVCEFDZ52KWy2Y2VzhYSZcirgJWGh8aAFV/drcZ/Tj7n
	/H7n9z1/HBmlukkny3T6faJBr8lVMwqimEuwpidmjmrfOj35BtS0OBkYWyxBEH1UTYG5M0Zg
	YekmCzG3F0FFsJwCZ/tRDGdDUwxURo4SiFz9BObGummIjdzGYJ96imHKcwLBI/81CirPBhBM
	t0rbdu8oArfjGAO3LL9SMBeswTDfysD56nIERbYWBirOuwh0jnexEJx5jGG4ohzDmD1MwGex
	YqiuLIov01J0czeGJXsjC322YQL2whSo9g/QMOGokp5Zlw/eptssjP11nIZLheMsuP67isB5
	KkyBa/I6De6hNLjs7iVQ8mQBgbdjAsNAVw0Do84YDQGPj4b+poAU6v2bQG/VLwQabgQxhMYH
	aWjz91EQKCuloXneysCZ+TAC++IdFvo9dfiDnUJj229YMPc/YQRnrRMJCw1FlGC2SGrwzTLC
	P1ZeKPOnC51VI6xQ/PsQK9S59gvFf87RQptjjWC7HMHChXuLtDA0s/mztC8Um3LEXF2BaFi3
	ZZdCe6rjR2bPg2UH/71rI4UoKj+J5DKey+SP+0PMC5eZT+K4GW41Pzi4RMW9nHudbysN03FT
	nG8lfz34ZtyJXDZ/bbqejZtwKbw10vFsjpJbzw9311LPZ77GN7V6nlkunQ+EfCRuFfcub75T
	LGUppB6bnHf2NOPnF5L4K45BYkHKOvRSI1Lp9AV5Gl1u5lqtSa87uPbb/DwXkr6c/cjjLzvQ
	vcD2HsTJkDpBGUgZ0apoTYHRlNeDeBmlXq7c5RjWqpQ5GtMh0ZC/07A/VzT2oBUyon5VmXH/
	QI6K+06zT9wtintEw4sqlsmTC9FPN0qVK6PZCTQWMz6e+dy5I201vjW+tevcy1nZk5f+uPiD
	23NoWxa9d2L7e5+u+3pVSK81nti9mLijtj68lKx+YE83bTyc9PBi8J1ssqASolkts8HNte0f
	3q8vSz2nICXH+qI/W17Zm6r96KvYhpJvckyR0tT3U65kzPaekTdPfZ+0Xk2MWs3bayiDUfM/
	mX7I3m4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSa0xTdxQAcP/3/vu/paN6c0W5Qea0k5ksImpQj6ib/cSNiY99mtEP0uiN
	rdCivcgsyQwFGomvQZeWjSoiaEOASaXqQEQZKolghVpFo1TEVB4BLFGQ8RJbjV9OfueRk/Ph
	yGnuuixGrjNkiEaDJk1FFFixfWNuPJf4UrvKfhxDp7kJw9hoPoazNdUE8mv/lkHH5SoE3WP5
	CManHDRY6mcxzFhbGBideMHAbGMLArvXSkP1VTMF710fCQzeeYfA1hMgUDRgxhB0nkJQ3Otg
	YOBeMgx3N8hg1t9HwdMPQwicgY8UBJqOI5ixp8L5MjeBKU87DUW2DgQXevw09LtCzastLxE0
	VuQQeFNwjQZfYC48HgsSuG87SWDYe5aCty4CpTmNMjjnsCLILa8hYD9Xi6H+1Q0GvIPTFHTZ
	rRRU1W6DbmcvhraCMip0X2jqSjQ4inKpUOinwPZPAwUTzkoGHpR3YXBmx4HD45PB64piBqZ7
	VsNsaTq0VPUx4P/DhuHycLtsiw0J45YzWKh0X6cEy6MZIlSXVCNhatKKhNFLubRgKQild4aC
	tJDn/k241DZEhMmxJ0Ro/FCKhdYyXij0xAv1xX5GyLv1nNmZtFuxab+YpssUjQk/pSi0p+pO
	kkP/f3P04Ug5zkbjESdQhJxnE/lCywkqbMIu5589m6DDjmKX8O7TvbKwabYtlu/0rgh7PruD
	b++/yISN2Ti+bKCOhK1k1/FdDSX0l53f8VWups+OCNV9PW04bI5dy1uCeVQBUpSiOZUoSmfI
	1Gt0aWtXSqlak0F3dOW+dH0tCn2T8/fpwjo06ktuRqwcqSKV3ji/lpNpMiWTvhnxcloVpUyp
	6NJyyv0aU5ZoTN9rPJImSs1okRyropVbfxVTOPaAJkNMFcVDovFrl5JHxGSjJJ/58MGSxUZ1
	xWLOpH6apfd0mmd2zb/3vfoH9cWRxEDrv4uIXTc4fT6HO3CsW/rv7pqdtGbiYcy3HfP2Jph6
	I2/fGLd6FLH+IL0vWbvZ8Ocv6qWujPV7FNGTN9/U1P2VP9L3c4JbSnqxIFbHxetb/VKkQa3e
	sEyK3JIV7U5ceESFJa1m9Y+0UdJ8AmP23a1JAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

jbd2 journal handling code doesn't want jbd2_might_wait_for_commit()
to be placed between start_this_handle() and stop_this_handle().  So it
marks the region with rwsem_acquire_read() and rwsem_release().

However, the annotation is too strong for that purpose.  We don't have
to use more than try lock annotation for that.

rwsem_acquire_read() implies:

   1. might be a waiter on contention of the lock.
   2. enter to the critical section of the lock.

All we need in here is to act 2, not 1.  So trylock version of
annotation is sufficient for that purpose.  Now that dept partially
relies on lockdep annotaions, dept interpets rwsem_acquire_read() as a
potential wait and might report a deadlock by the wait.

Replace it with trylock version of annotation.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 fs/jbd2/transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index c7867139af69..b4e65f51bf5e 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -441,7 +441,7 @@ static int start_this_handle(journal_t *journal, handle_t *handle,
 	read_unlock(&journal->j_state_lock);
 	current->journal_info = handle;
 
-	rwsem_acquire_read(&journal->j_trans_commit_map, 0, 0, _THIS_IP_);
+	rwsem_acquire_read(&journal->j_trans_commit_map, 0, 1, _THIS_IP_);
 	jbd2_journal_free_transaction(new_transaction);
 	/*
 	 * Ensure that no allocations done while the transaction is open are
-- 
2.17.1


