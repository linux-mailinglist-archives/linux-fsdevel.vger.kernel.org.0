Return-Path: <linux-fsdevel+bounces-77879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDXuCJOgm2l63wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 01:34:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF146170F61
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 01:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 159D4302C36F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 00:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02D31E98EF;
	Mon, 23 Feb 2026 00:33:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3ED626ADC;
	Mon, 23 Feb 2026 00:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771806823; cv=none; b=MouFHGiR8wU4OwkYjBcYdextIjodswNe5/oc7kS7Lo6DHFIaoGSZgF5lqWCetde1dERstTxFIpSVLOG8YhqsebRFoqzbvURpa2NdI8yDAiBtM3gKCDd6W9tIrqSDmRURomPWpyePg8URvEQhey+8y8Ehwg70z6UUx0IqG6CWYoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771806823; c=relaxed/simple;
	bh=Empke4UdsPxxKAiOLj2ALTMJhcJk2XqsTNT04XmtesE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOIIM7tZIEohDCqt6ehbSZ6OzD3nE2rp4C5B8iPHcMMUzA8xqc6H6WaTAPIruSSdPEUbzHyAP3OLZjFzd8pXCuY6FzBHOMua2V6AhXIC/e8Y1BDSkzc3Yu4E840qlHWzy603GnGWL7Bng4QP6VAAMCkCWGbdARJl7uxi8HddCUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-4c-699ba05f2957
Date: Mon, 23 Feb 2026 09:33:30 +0900
From: Byungchul Park <byungchul@sk.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: kernel_team@skhynix.com, torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, will@kernel.org,
	tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
	sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
	johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
	willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
	gregkh@linuxfoundation.org, kernel-team@lge.com, linux-mm@kvack.org,
	akpm@linux-foundation.org, mhocko@kernel.org, minchan@kernel.org,
	hannes@cmpxchg.org, vdavydov.dev@gmail.com, sj@kernel.org,
	jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
	penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
	ngupta@vflare.org, linux-block@vger.kernel.org,
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	jlayton@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
	djwong@kernel.org, dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	hamohammed.sa@gmail.com, harry.yoo@oracle.com,
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com, boqun.feng@gmail.com,
	longman@redhat.com, yunseong.kim@ericsson.com, ysk@kzalloc.com,
	yeoreum.yun@arm.com, netdev@vger.kernel.org,
	matthew.brost@intel.com, her0gyugyu@gmail.com, corbet@lwn.net,
	catalin.marinas@arm.com, bp@alien8.de, x86@kernel.org,
	hpa@zytor.com, luto@kernel.org, sumit.semwal@linaro.org,
	gustavo@padovan.org, christian.koenig@amd.com,
	andi.shyti@kernel.org, arnd@arndb.de, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com,
	mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com,
	paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, josh@joshtriplett.org, urezki@gmail.com,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	chuck.lever@oracle.com, neil@brown.name, okorniev@redhat.com,
	Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org,
	anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, mark.rutland@arm.com, ada.coupriediaz@arm.com,
	kristina.martsenko@arm.com, wangkefeng.wang@huawei.com,
	broonie@kernel.org, kevin.brodsky@arm.com, dwmw@amazon.co.uk,
	shakeel.butt@linux.dev, ast@kernel.org, ziy@nvidia.com,
	yuzhao@google.com, baolin.wang@linux.alibaba.com,
	usamaarif642@gmail.com, joel.granados@kernel.org,
	richard.weiyang@gmail.com, geert+renesas@glider.be,
	tim.c.chen@linux.intel.com, linux@treblig.org,
	alexander.shishkin@linux.intel.com, lillian@star-ark.net,
	chenhuacai@kernel.org, francesco@valla.it,
	guoweikang.kernel@gmail.com, link@vivo.com, jpoimboe@kernel.org,
	masahiroy@kernel.org, brauner@kernel.org,
	thomas.weissschuh@linutronix.de, oleg@redhat.com, mjguzik@gmail.com,
	andrii@kernel.org, wangfushuai@baidu.com, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, linux-i2c@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	rcu@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, 2407018371@qq.com, dakr@kernel.org,
	miguel.ojeda.sandonis@gmail.com, neilb@ownmail.net,
	bagasdotme@gmail.com, wsa+renesas@sang-engineering.com,
	dave.hansen@intel.com, geert@linux-m68k.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v18 34/42] dept: add module support for struct
 dept_event_site and dept_event_site_dep
Message-ID: <20260223003330.GB44876@system.software.com>
References: <20251205071855.72743-1-byungchul@sk.com>
 <20251205071855.72743-35-byungchul@sk.com>
 <7afb6666-43b6-4d17-b875-e585c7a5ac99@suse.com>
 <20260213055006.GA55430@system.software.com>
 <7765df86-b08a-4f70-900d-4b4d85c07d49@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7765df86-b08a-4f70-900d-4b4d85c07d49@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxbVRjHPffce3tpqLnWLR4h0a1ojOjQ6WKebI26D8b7ZZHMxWwzy9bJ
	zWhWXiwMh/GFkTE7XBBLKK4MZei6SkvGypi8j9EA1tEUSp1lg7UspbVhgHZjhLSAvRjjvjz5
	5X9++T/Ph8NhZQObxmnzi0V9vkanYuW0fC61acuhxnrtq1c6N8FkIMTAuUt2FgKLBgRL8XoM
	FZ1rNDxYvi0D05gRg3/0Gob7rasszDpjCOqiJ2hYsJxBEB18F+YC3QysTUUosIRWKVgxHYUf
	mtqSqukvFuJuD4a62lEEsWgQQa+1nIWZ6nYM46HHwVX7NQvzrSw0lvcy0FBvRNAZ7JLB2GyC
	gkmTkQKbYxcELGEablQ3UVDb0k3BsqVZBvXucQYS01vBdecmA7NhY/L44VMM/FIWlIFjYhDB
	A980BYauRRp6b70E50/9RENPr4uGoY67FIx3nWPhTGs7A3fsawx4baM0XIr4KXCZf6bhtvsb
	GXi6Whi48McYBdNBPwNt7hEMLfNNLNTMhxHMPrTgt3OEpYoqWqjwrrCC/Xs7Eiqqk8N5bwEL
	F27cY4Vv3VuETvOUTDjZd0smNDqOCW3WTOHHniglOJpPs4IjZpQJ5+N/YqFyzkdlZ+6Xq3NE
	nbZE1L/y5iF5brjqMi6ceON4x2R2GfruxUqUwhF+G/mqz05VIm6dR5ycFNP888TWV4UkZvkX
	iN+/jCVlA/8c8d7dWYnkHOZNzxBXm4GRnCd5HXHW/L1eo+CB2GMbpVjJLyLinnhPYgX/BHGd
	DdESYz6T+Fej6zrm08nFVU7CFF5N5gaflYyNfAbpvzpMSZsIH04hM2dj6N+DnybXrX66GvHm
	R1rNj7Sa/29tRLgZKbX5JXkarW5bVm5pvvZ41kcFeQ6U/LSWzxMfdqDY6PsDiOeQKlXRv2DW
	KhlNSVFp3gAiHFZtUMTjyUiRoyn9VNQXHNQf04lFAyido1VPKV57+EmOkj+iKRaPimKhqP/v
	leJS0spQzcXI6Z0a9UrDO+URT6jQMLX5A+Tbv08ZGPY4bTvSfAePBKeyjCM96ScHUq/byIli
	9b7X72//LD6z6ctd1w7Evyioae5+2fqYujbbuofvX0lEfmUMDsvu3Ycz9k7u3X7TGPmNqTJ4
	NzMRQ6Juj29HyONVfuxsX4rHhtIPDGW89buKLsrVbM3E+iLNP7WxGd+wAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUwbdRjHfe53vR6NZ86ubOeImnU2TsxejM48iXNxxrhzZnPinHFZ3Kq7
	SEMpWzvZGDECtVrREKhpGe3QilIXqG5rGY4tVUIdAweRDiegvGym1hFgnUBZoJTaMzHunyff
	53k+n+T542GJel6xkjWYDktmk96oZVS0asdT1rX7vB7Dhrn4/Wi3vYfDY1EF/lreTmNi1k7j
	iVN+BlOe75RoD9QpsGuggsa+b5sBxxJ2wNtJD0FbW5rGlKNTibPzvyvRWQ6YDnUCuiIOgoN9
	PxD0t5RTOHN6icGJ8DSg83qUwdrxchrjvk8A3TGPEscvbsWpsQsKTI/8ReHA3CSgL7pEYbT9
	Q8CUqwA/bwhmdNctBpO9PxOsdfYBfnF9hOD0+DXAls5RwNDJCgb/rD5LsD96D/6SiDPY7fyY
	wanICQpvnmbQWxFSYKRnArDe4wCM/Rai0PrlKQZd9QEa266dV2JkYpHCYZeDwubAdhzzxWi8
	XN1AZc7NUGdWoKfWSmXKDQqd31ygcN7XpHymEcTbtipabAq2UqLtSooR/Z/5QUwuOECcbbQS
	0VadacOTcSK+HzwiNl6eZMSFxFVGDM15afGnBkH86qMFSqzpXSu2uUeUO7fsUW06IBkNxZJ5
	/eb9qvxY1RlycOjJo+eGd5bB8UcqgWUF/gmhJ8xWQhZL8zqh+fsqkDPDPywMDs4TGdHwDwlX
	/thSCSqW8K4HhO6gXSEzy3ijEP70b0pmOB4F/3S2PFbzCRB6h16SM8ffK3TXRWk5Ez5XGFwa
	/xcnfI7w9RIrxyx+kzB18UGZyOZXC+2tl6hq4Nx3yO47ZPf/shdIE2gMpuJCvcG4cZ2lIL/E
	ZDi67q2iwgBkHtL37mLNOZjt39oBPAvau7lb93kMaoW+2FJS2AECS7QaLpl0G9TcAX3JMclc
	tM/8jlGydEAOS2tXcNtek/ar+bf1h6UCSToomf/bUmzWyjJ481i6LLZo1nj7D63GILf8lR6z
	LlTwslN/12R6d9zZ0jXQym6eXnboyO6hIrixUTHzqu+F0tIPXr/KWbcnt+19uk633vNjIO/x
	Ndl5nGn5s6N7F3TdeaZHzz9X6grtmtmVU3Pp+eNrVrV0rdqjC2t6TcWjG07mvng2MpBqrLe9
	kU7f1NKWfP1jucRs0f8DOc5IfIwDAAA=
X-CFilter-Loop: Reflected
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77879-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[skhynix.com,linux-foundation.org,opensource.wdc.com,vger.kernel.org,dilger.ca,redhat.com,infradead.org,kernel.org,linutronix.de,goodmis.org,joelfernandes.org,ffwll.ch,gmail.com,intel.com,mit.edu,fromorbit.com,linuxfoundation.org,lge.com,kvack.org,cmpxchg.org,linux.com,google.com,suse.cz,vflare.org,toxicpanda.com,lists.freedesktop.org,oracle.com,ericsson.com,kzalloc.com,arm.com,lwn.net,alien8.de,zytor.com,linaro.org,padovan.org,amd.com,arndb.de,nvidia.com,joshtriplett.org,efficios.com,linux.dev,suse.de,brown.name,talpey.com,huawei.com,amazon.co.uk,linux.alibaba.com,glider.be,linux.intel.com,treblig.org,star-ark.net,valla.it,vivo.com,baidu.com,lists.infradead.org,lists.linaro.org,lists.linux.dev,qq.com,ownmail.net,sang-engineering.com,linux-m68k.org,garyguo.net,protonmail.com,umich.edu];
	DMARC_NA(0.00)[sk.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[byungchul@sk.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_GT_50(0.00)[165];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	TAGGED_RCPT(0.00)[linux-fsdevel,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sk.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,system.software.com:mid]
X-Rspamd-Queue-Id: AF146170F61
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 04:08:19PM +0100, Petr Pavlu wrote:
> On 2/13/26 6:50 AM, Byungchul Park wrote:
> > On Wed, Jan 07, 2026 at 01:19:00PM +0100, Petr Pavlu wrote:
> >> On 12/5/25 8:18 AM, Byungchul Park wrote:
> >>> struct dept_event_site and struct dept_event_site_dep have been
> >>> introduced to track dependencies between multi event sites for a single
> >>> wait, that will be loaded to data segment.  Plus, a custom section,
> >>> '.dept.event_sites', also has been introduced to keep pointers to the
> >>> objects to make sure all the event sites defined exist in code.
> >>>
> >>> dept should work with the section and segment of module.  Add the
> >>> support to handle the section and segment properly whenever modules are
> >>> loaded and unloaded.
> >>>
> >>> Signed-off-by: Byungchul Park <byungchul@sk.com>
> >>
> >> Below are a few comments from the module loader perspective.
> >
> > Sorry about the late reply.  I've been going through some major life
> > changes lately. :(
> >
> > Thank you sooooo~ much for your helpful feedback.  I will leave my
> > opinion below.
> >
> [...]
> >>> diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
> >>> index b14400c4f83b..07d883579269 100644
> >>> --- a/kernel/dependency/dept.c
> >>> +++ b/kernel/dependency/dept.c
> >>> @@ -984,6 +984,9 @@ static void bfs(void *root, struct bfs_ops *ops, void *in, void **out)
> >>>   * event sites.
> >>>   */
> >>>
> >>> +static LIST_HEAD(dept_event_sites);
> >>> +static LIST_HEAD(dept_event_site_deps);
> >>> +
> >>>  /*
> >>>   * Print all events in the circle.
> >>>   */
> >>> @@ -2043,6 +2046,33 @@ static void del_dep_rcu(struct rcu_head *rh)
> >>>       preempt_enable();
> >>>  }
> >>>
> >>> +/*
> >>> + * NOTE: Must be called with dept_lock held.
> >>> + */
> >>> +static void disconnect_event_site_dep(struct dept_event_site_dep *esd)
> >>> +{
> >>> +     list_del_rcu(&esd->dep_node);
> >>> +     list_del_rcu(&esd->dep_rev_node);
> >>> +}
> >>> +
> >>> +/*
> >>> + * NOTE: Must be called with dept_lock held.
> >>> + */
> >>> +static void disconnect_event_site(struct dept_event_site *es)
> >>> +{
> >>> +     struct dept_event_site_dep *esd, *next_esd;
> >>> +
> >>> +     list_for_each_entry_safe(esd, next_esd, &es->dep_head, dep_node) {
> >>> +             list_del_rcu(&esd->dep_node);
> >>> +             list_del_rcu(&esd->dep_rev_node);
> >>> +     }
> >>> +
> >>> +     list_for_each_entry_safe(esd, next_esd, &es->dep_rev_head, dep_rev_node) {
> >>> +             list_del_rcu(&esd->dep_node);
> >>> +             list_del_rcu(&esd->dep_rev_node);
> >>> +     }
> >>> +}
> >>> +
> >>>  /*
> >>>   * NOTE: Must be called with dept_lock held.
> >>>   */
> >>> @@ -2384,6 +2414,8 @@ void dept_free_range(void *start, unsigned int sz)
> >>>  {
> >>>       struct dept_task *dt = dept_task();
> >>>       struct dept_class *c, *n;
> >>> +     struct dept_event_site_dep *esd, *next_esd;
> >>> +     struct dept_event_site *es, *next_es;
> >>>       unsigned long flags;
> >>>
> >>>       if (unlikely(!dept_working()))
> >>> @@ -2405,6 +2437,24 @@ void dept_free_range(void *start, unsigned int sz)
> >>>       while (unlikely(!dept_lock()))
> >>>               cpu_relax();
> >>>
> >>> +     list_for_each_entry_safe(esd, next_esd, &dept_event_site_deps, all_node) {
> >>> +             if (!within((void *)esd, start, sz))
> >>> +                     continue;
> >>> +
> >>> +             disconnect_event_site_dep(esd);
> >>> +             list_del(&esd->all_node);
> >>> +     }
> >>> +
> >>> +     list_for_each_entry_safe(es, next_es, &dept_event_sites, all_node) {
> >>> +             if (!within((void *)es, start, sz) &&
> >>> +                 !within(es->name, start, sz) &&
> >>> +                 !within(es->func_name, start, sz))
> >>> +                     continue;
> >>> +
> >>> +             disconnect_event_site(es);
> >>> +             list_del(&es->all_node);
> >>> +     }
> >>> +
> >>>       list_for_each_entry_safe(c, n, &dept_classes, all_node) {
> >>>               if (!within((void *)c->key, start, sz) &&
> >>>                   !within(c->name, start, sz))
> >>> @@ -3337,6 +3387,7 @@ void __dept_recover_event(struct dept_event_site_dep *esd,
> >>>
> >>>       list_add(&esd->dep_node, &es->dep_head);
> >>>       list_add(&esd->dep_rev_node, &rs->dep_rev_head);
> >>> +     list_add(&esd->all_node, &dept_event_site_deps);
> >>>       check_recover_dl_bfs(esd);
> >>>  unlock:
> >>>       dept_unlock();
> >>> @@ -3347,6 +3398,23 @@ EXPORT_SYMBOL_GPL(__dept_recover_event);
> >>>
> >>>  #define B2KB(B) ((B) / 1024)
> >>>
> >>> +void dept_mark_event_site_used(void *start, void *end)
> >>
> >> Nit: I suggest that dept_mark_event_site_used() take pointers to
> >> dept_event_site_init, which would catch the type mismatch with
> >
> > IMO, this is the easiest way to get all the pointers from start to the
> > end, or I can't get the number of the pointers.  It's similar to the
> > initcalls section for device drivers.
> 
> This was a minor suggestion.. The idea is to simply change the function
> signature to:
> 
> void dept_mark_event_site_used(struct dept_event_site_init **start,
>                                struct dept_event_site_init **end))

I got what you meant.  I will.  Thanks.

	Byungchul

> This way, the compiler can provide proper type checking to ensure that
> correct pointers are passed to dept_mark_event_site_used(). It would
> catch the type mismatch with module::dept_event_sites.
> 
> >
> >> module::dept_event_sites.
> >>
> >>> +{
> >>> +     struct dept_event_site_init **evtinitpp;
> >>> +
> >>> +     for (evtinitpp = (struct dept_event_site_init **)start;
> >>> +          evtinitpp < (struct dept_event_site_init **)end;
> >>> +          evtinitpp++) {
> >>> +             (*evtinitpp)->evt_site->used = true;
> >>> +             (*evtinitpp)->evt_site->func_name = (*evtinitpp)->func_name;
> >>> +             list_add(&(*evtinitpp)->evt_site->all_node, &dept_event_sites);
> >>> +
> >>> +             pr_info("dept_event_site %s@%s is initialized.\n",
> >>> +                             (*evtinitpp)->evt_site->name,
> >>> +                             (*evtinitpp)->evt_site->func_name);
> >>> +     }
> >>> +}
> >>> +
> >>>  extern char __dept_event_sites_start[], __dept_event_sites_end[];
> >>
> >> Related to the above, __dept_event_sites_start and
> >> __dept_event_sites_end can already be properly typed here.
> >
> > How can I get the number of the pointers?
> 
> Similarly here, changing the code to:
> 
> extern struct dept_event_site_init *__dept_event_sites_start[], *__dept_event_sites_end[];
> 
> It is the same for the initcalls you mentioned. The declarations of
> their start/end symbols are also already properly typed as
> initcall_entry_t[] in include/linux/init.h.
> 
> --
> Thanks,
> Petr

