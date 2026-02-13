Return-Path: <linux-fsdevel+bounces-77072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EDrNc27jmkWEQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 06:51:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4624D133120
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 06:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D793308E4AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 05:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56C627A47F;
	Fri, 13 Feb 2026 05:50:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125E823EAA0;
	Fri, 13 Feb 2026 05:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770961826; cv=none; b=JvBRnLgXgv2CB/yTu/pgUL+lTk33Fucu0cr0YvgywbFgsEE8BLfcwTtyNFOW8eYmm54wKxyqAJje9fZyOcP2kZzrwzDb+N1RfaAQ7aYiuySzAeCpU+AfltmTsvUVhMfu1YPf3Zk/T4iUOl8KNOUJmY/T0qaioaHrLK1Ixc7RyM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770961826; c=relaxed/simple;
	bh=Olv5FsQoJX1MZOZmz/89/ELafNm3/Vh+Aei35tGdPRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPKDTga5ty7qCYqpbYD78CuL1PYpACxTAaPqQEBkKaGIPQNt/ANJzZJeNi838LRLrVoO1NBKqSZwntOXSUh1K3tBgQNWbcm1/faEMiMQHI8w60hgOHI1RwiJx8U5Ojfmf5qcAD3UJd9hKqRp18xdieWeS0SavsmWgcAUVCzpQc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-ba-698ebb94cf6d
Date: Fri, 13 Feb 2026 14:50:06 +0900
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
Message-ID: <20260213055006.GA55430@system.software.com>
References: <20251205071855.72743-1-byungchul@sk.com>
 <20251205071855.72743-35-byungchul@sk.com>
 <7afb6666-43b6-4d17-b875-e585c7a5ac99@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7afb6666-43b6-4d17-b875-e585c7a5ac99@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SXUxTZxiA953znR8auhyri5/i2NZtGlmmbHPxvTDG3ejZBYvZLrZMk60Z
	zWgoRYsy2ZzSKVutExmjVcswYO0P2AEpOlEoIqWwVjD8bKwqHcUUNgJCpFLSTnAezDLvnuR9
	3ifvxcvTihp2Na/R7VPrdSqtkpVh2b3UmtcrWko1mReG0sFYchiGDO0Yfmpws2D0nGFgZM6I
	YKG8i4MHiTscmA0IHnm7EFj6y2lwXzRQEGtcZGHSN4vAPBplYcbxPYIJ/w64N9LCQLT9u8fr
	llw4Ze5DUDMapuFi158Ixsou0TAYfRamG1mo/sbLQH/PJIIjtgYWLFUeDP2TDykYtpRTcMGT
	BSOOcQw9tmEMlb2DDFwujnDgueVHYLw6h6HVG8AQsNZiuNN7koPRSIiBpt4eGkJlYwh+nj7H
	gmNuhgPDdRsG1/1TDNR6e1loPGrl4NK1EgSz5+MYvo0tMtB9op0C+4NpGn671YKgzRihoGHc
	R8Nf1ioKfHNTFATDMQ6S4WYGgskgBcbOOL1tmzhfUorFkoEFVnSfdSPxn2Q5En1TM7RovzHF
	it54NRaD54h4/liSEq9Yw5x4tO02Jza5MkRb6wQleuqOseLwUCsrTt+8ye186WPZlmy1VlOo
	1m/c+qksxzpwkttj1B7wjS/gYjSYZUI8T4RNpLuTmFDKErrrXbTEWHiVxJxOSmJWWEdCoQQt
	6SuEV8jA3XdMSMbTgiWdBJqMjOQsF7TE9+P9JV8uAInHzLQkKYQKRMzOevxksIwEzkSXmBYy
	SGhxgpKitJBGnIu8hCnCFlJqeVsynhNeJu2/dFNShgh3U4jTVIue3LmKXHeFcBkSrE9VrU9V
	rf9XqxFdhxQaXWGeSqPdtCGnSKc5sOGz/DwPevy4jq8f7mpGs30fdCCBR8pUeej3ExoFoyos
	KMrrQISnlSvkL6w/rlHIs1VFX6r1+Z/o92vVBR0ojcfKlfI3419kK4TPVfvUuWr1HrX+vynF
	p6wuRgcrD17JtNv/SE0L2sR+/41f7Vt34vc12dH9juV5iWtfnR3S7aiYJ6aN6Y+E7fmRIq2P
	aTOsGnux1i/P9G8+bUk0zB9qfu+tgEtPJX/4kNq967S7L7Nq72RXeudt6+EjH4W9K5+fqF/r
	33yobK/2mYhq+5p3L1cq6v5uy505nliT9ZoSF+So3sig9QWqfwGN3CeYtAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTZxTG877v/aKuy7ViuEGzZd2mToVtZiYnwW2SaLhZApmJyZKZqM16
	AzeUSlpEWGKksLoOhZViS2zVMbDFYEUFlTFsJHTD4UdGYc5mgsDSdWOgDKF1UAprXZb5z8lz
	zvN7Ts4fhyOqOJ3OyfoSyaDX6NSMglLkZVVl1HfXym+1jW0Bi/kIDI+GaPjZ1ENBZM5CwamL
	Xgbirk4WLO0nafjhfiUFA23nEYxGLAiexlwEzF3LFMRtfSzMzT9gwW5CsOzrQ+AI2AgEB24Q
	8F4xYZi9tMTApP8JAvt4iIGGCRMF057jCJxhFwsT3+fAo9FuGpZHfsdwPzqFwBNawhDq+RxB
	3FEIXzV1JOKOvxiI3f2RQIN9AMHX4yMEnkyMIbjS9xCB71wlA79ZrxIYCr0IP0WmGei3H2Pg
	UeAUhseXGGis9NEQuDOJ4LTLhiD8iw9DVfNFBhyn2ynoGvuWhcDkIoZhhw3D+fZcGPWEKbht
	bcKJcxPU5TRwNVThRPkDg/1CN4Z5Tyu73Y3Ep+ZaSmztuIZF82CcEb1nvEiMLdiQOOeuIqLZ
	mmj9U9NE/KzjkOi+PcWIC5F7jOiLNlLirSZBPPvFAhbr7maIXc4R9sPsjxXbtJJOLpUMb763
	X1HgHPySLbboyvzhOFWBhnKrUQon8O8I3rZzJKkp/nVhtqUFJzXDrxeCwfnEnONS+deEwV+z
	q5GCI7zjJaG/w0InmVW8TvDXzzzjlTwI0Vk7SUIq/gQS7C1t1L/GSqH/ZOiZJvxGIbg0gZNL
	Cb9GaFnikjKF3ybUOrYmidX8q0LPtZvYipTO58LO58LO/8ONiLSiVFlfWqSRdVszjYUF5Xq5
	LPOTA0XtKPGUnsOLdd+guaGcXsRzSP2CMnivRlbRmlJjeVEvEjiiTlW+/MYxWaXUaso/lQwH
	9hkO6iRjL1rDUeo05QcfSftVfL6mRCqUpGLJ8J+LuZT0CpS5eNnkbmQLIq6d70bC0Swmb0p7
	tXhxt2vFcB7dq8rPrb9Dsyd2h2M3A+6aPfqKo1hbe+i77e/f2qR9QFYdPxyJju+Y+XvD3tY/
	m5srX8k5W1ZXsnZz1uo9O3SxtJ35JQf3WWcGxtXFnmy5xt/5mM4YrEZHy3btur4OdeK16vQz
	aspYoHl7IzEYNf8AhlstipADAAA=
X-CFilter-Loop: Reflected
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_THREE(0.00)[3];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,renesas];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[sk.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[system.software.com:mid,sk.com:email];
	RCPT_COUNT_GT_50(0.00)[165];
	FROM_NEQ_ENVFROM(0.00)[byungchul@sk.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[skhynix.com,linux-foundation.org,opensource.wdc.com,vger.kernel.org,dilger.ca,redhat.com,infradead.org,kernel.org,linutronix.de,goodmis.org,joelfernandes.org,ffwll.ch,gmail.com,intel.com,mit.edu,fromorbit.com,linuxfoundation.org,lge.com,kvack.org,cmpxchg.org,linux.com,google.com,suse.cz,vflare.org,toxicpanda.com,lists.freedesktop.org,oracle.com,ericsson.com,kzalloc.com,arm.com,lwn.net,alien8.de,zytor.com,linaro.org,padovan.org,amd.com,arndb.de,nvidia.com,joshtriplett.org,efficios.com,linux.dev,suse.de,brown.name,talpey.com,huawei.com,amazon.co.uk,linux.alibaba.com,glider.be,linux.intel.com,treblig.org,star-ark.net,valla.it,vivo.com,baidu.com,lists.infradead.org,lists.linaro.org,lists.linux.dev,qq.com,ownmail.net,sang-engineering.com,linux-m68k.org,garyguo.net,protonmail.com,umich.edu];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-77072-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 4624D133120
X-Rspamd-Action: no action

On Wed, Jan 07, 2026 at 01:19:00PM +0100, Petr Pavlu wrote:
> On 12/5/25 8:18 AM, Byungchul Park wrote:
> > struct dept_event_site and struct dept_event_site_dep have been
> > introduced to track dependencies between multi event sites for a single
> > wait, that will be loaded to data segment.  Plus, a custom section,
> > '.dept.event_sites', also has been introduced to keep pointers to the
> > objects to make sure all the event sites defined exist in code.
> >
> > dept should work with the section and segment of module.  Add the
> > support to handle the section and segment properly whenever modules are
> > loaded and unloaded.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> 
> Below are a few comments from the module loader perspective.

Sorry about the late reply.  I've been going through some major life
changes lately. :(

Thank you sooooo~ much for your helpful feedback.  I will leave my
opinion below.

> > ---
> >  include/linux/dept.h     | 14 +++++++
> >  include/linux/module.h   |  5 +++
> >  kernel/dependency/dept.c | 79 +++++++++++++++++++++++++++++++++++-----
> >  kernel/module/main.c     | 15 ++++++++
> >  4 files changed, 103 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/linux/dept.h b/include/linux/dept.h
> > index 44083e6651ab..c796cdceb04e 100644
> > --- a/include/linux/dept.h
> > +++ b/include/linux/dept.h
> > @@ -166,6 +166,11 @@ struct dept_event_site {
> >       struct dept_event_site          *bfs_parent;
> >       struct list_head                bfs_node;
> >
> > +     /*
> > +      * for linking all dept_event_site's
> > +      */
> > +     struct list_head                all_node;
> > +
> >       /*
> >        * flag indicating the event is not only declared but also
> >        * actually used in code
> > @@ -182,6 +187,11 @@ struct dept_event_site_dep {
> >        */
> >       struct list_head                dep_node;
> >       struct list_head                dep_rev_node;
> > +
> > +     /*
> > +      * for linking all dept_event_site_dep's
> > +      */
> > +     struct list_head                all_node;
> >  };
> >
> >  #define DEPT_EVENT_SITE_INITIALIZER(es)                                      \
> > @@ -193,6 +203,7 @@ struct dept_event_site_dep {
> >       .bfs_gen = 0,                                                   \
> >       .bfs_parent = NULL,                                             \
> >       .bfs_node = LIST_HEAD_INIT((es).bfs_node),                      \
> > +     .all_node = LIST_HEAD_INIT((es).all_node),                      \
> >       .used = false,                                                  \
> >  }
> >
> > @@ -202,6 +213,7 @@ struct dept_event_site_dep {
> >       .recover_site = NULL,                                           \
> >       .dep_node = LIST_HEAD_INIT((esd).dep_node),                     \
> >       .dep_rev_node = LIST_HEAD_INIT((esd).dep_rev_node),             \
> > +     .all_node = LIST_HEAD_INIT((esd).all_node),                     \
> >  }
> >
> >  struct dept_event_site_init {
> > @@ -225,6 +237,7 @@ extern void dept_init(void);
> >  extern void dept_task_init(struct task_struct *t);
> >  extern void dept_task_exit(struct task_struct *t);
> >  extern void dept_free_range(void *start, unsigned int sz);
> > +extern void dept_mark_event_site_used(void *start, void *end);
> 
> Nit: The coding style recommends not using the extern keyword with
> function declarations.

I will remove 'extern's.  Thanks.

> https://www.kernel.org/doc/html/v6.19-rc4/process/coding-style.html#function-prototypes
> 
> >
> >  extern void dept_map_init(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
> >  extern void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
> > @@ -288,6 +301,7 @@ struct dept_event_site { };
> >  #define dept_task_init(t)                            do { } while (0)
> >  #define dept_task_exit(t)                            do { } while (0)
> >  #define dept_free_range(s, sz)                               do { } while (0)
> > +#define dept_mark_event_site_used(s, e)                      do { } while (0)
> >
> >  #define dept_map_init(m, k, su, n)                   do { (void)(n); (void)(k); } while (0)
> >  #define dept_map_reinit(m, k, su, n)                 do { (void)(n); (void)(k); } while (0)
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index d80c3ea57472..29885ba91951 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -29,6 +29,7 @@
> >  #include <linux/srcu.h>
> >  #include <linux/static_call_types.h>
> >  #include <linux/dynamic_debug.h>
> > +#include <linux/dept.h>
> >
> >  #include <linux/percpu.h>
> >  #include <asm/module.h>
> > @@ -588,6 +589,10 @@ struct module {
> >  #ifdef CONFIG_DYNAMIC_DEBUG_CORE
> >       struct _ddebug_info dyndbg_info;
> >  #endif
> > +#ifdef CONFIG_DEPT
> > +     struct dept_event_site **dept_event_sites;
> > +     unsigned int num_dept_event_sites;
> > +#endif
> >  } ____cacheline_aligned __randomize_layout;
> >  #ifndef MODULE_ARCH_INIT
> >  #define MODULE_ARCH_INIT {}
> 
> My understanding is that entries in the .dept.event_sites section are
> added by the dept_event_site_used() macro and they are pointers to the
> dept_event_site_init struct, not dept_event_site.
> 
> > diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
> > index b14400c4f83b..07d883579269 100644
> > --- a/kernel/dependency/dept.c
> > +++ b/kernel/dependency/dept.c
> > @@ -984,6 +984,9 @@ static void bfs(void *root, struct bfs_ops *ops, void *in, void **out)
> >   * event sites.
> >   */
> >
> > +static LIST_HEAD(dept_event_sites);
> > +static LIST_HEAD(dept_event_site_deps);
> > +
> >  /*
> >   * Print all events in the circle.
> >   */
> > @@ -2043,6 +2046,33 @@ static void del_dep_rcu(struct rcu_head *rh)
> >       preempt_enable();
> >  }
> >
> > +/*
> > + * NOTE: Must be called with dept_lock held.
> > + */
> > +static void disconnect_event_site_dep(struct dept_event_site_dep *esd)
> > +{
> > +     list_del_rcu(&esd->dep_node);
> > +     list_del_rcu(&esd->dep_rev_node);
> > +}
> > +
> > +/*
> > + * NOTE: Must be called with dept_lock held.
> > + */
> > +static void disconnect_event_site(struct dept_event_site *es)
> > +{
> > +     struct dept_event_site_dep *esd, *next_esd;
> > +
> > +     list_for_each_entry_safe(esd, next_esd, &es->dep_head, dep_node) {
> > +             list_del_rcu(&esd->dep_node);
> > +             list_del_rcu(&esd->dep_rev_node);
> > +     }
> > +
> > +     list_for_each_entry_safe(esd, next_esd, &es->dep_rev_head, dep_rev_node) {
> > +             list_del_rcu(&esd->dep_node);
> > +             list_del_rcu(&esd->dep_rev_node);
> > +     }
> > +}
> > +
> >  /*
> >   * NOTE: Must be called with dept_lock held.
> >   */
> > @@ -2384,6 +2414,8 @@ void dept_free_range(void *start, unsigned int sz)
> >  {
> >       struct dept_task *dt = dept_task();
> >       struct dept_class *c, *n;
> > +     struct dept_event_site_dep *esd, *next_esd;
> > +     struct dept_event_site *es, *next_es;
> >       unsigned long flags;
> >
> >       if (unlikely(!dept_working()))
> > @@ -2405,6 +2437,24 @@ void dept_free_range(void *start, unsigned int sz)
> >       while (unlikely(!dept_lock()))
> >               cpu_relax();
> >
> > +     list_for_each_entry_safe(esd, next_esd, &dept_event_site_deps, all_node) {
> > +             if (!within((void *)esd, start, sz))
> > +                     continue;
> > +
> > +             disconnect_event_site_dep(esd);
> > +             list_del(&esd->all_node);
> > +     }
> > +
> > +     list_for_each_entry_safe(es, next_es, &dept_event_sites, all_node) {
> > +             if (!within((void *)es, start, sz) &&
> > +                 !within(es->name, start, sz) &&
> > +                 !within(es->func_name, start, sz))
> > +                     continue;
> > +
> > +             disconnect_event_site(es);
> > +             list_del(&es->all_node);
> > +     }
> > +
> >       list_for_each_entry_safe(c, n, &dept_classes, all_node) {
> >               if (!within((void *)c->key, start, sz) &&
> >                   !within(c->name, start, sz))
> > @@ -3337,6 +3387,7 @@ void __dept_recover_event(struct dept_event_site_dep *esd,
> >
> >       list_add(&esd->dep_node, &es->dep_head);
> >       list_add(&esd->dep_rev_node, &rs->dep_rev_head);
> > +     list_add(&esd->all_node, &dept_event_site_deps);
> >       check_recover_dl_bfs(esd);
> >  unlock:
> >       dept_unlock();
> > @@ -3347,6 +3398,23 @@ EXPORT_SYMBOL_GPL(__dept_recover_event);
> >
> >  #define B2KB(B) ((B) / 1024)
> >
> > +void dept_mark_event_site_used(void *start, void *end)
> 
> Nit: I suggest that dept_mark_event_site_used() take pointers to
> dept_event_site_init, which would catch the type mismatch with

IMO, this is the easiest way to get all the pointers from start to the
end, or I can't get the number of the pointers.  It's similar to the
initcalls section for device drivers.

> module::dept_event_sites.
> 
> > +{
> > +     struct dept_event_site_init **evtinitpp;
> > +
> > +     for (evtinitpp = (struct dept_event_site_init **)start;
> > +          evtinitpp < (struct dept_event_site_init **)end;
> > +          evtinitpp++) {
> > +             (*evtinitpp)->evt_site->used = true;
> > +             (*evtinitpp)->evt_site->func_name = (*evtinitpp)->func_name;
> > +             list_add(&(*evtinitpp)->evt_site->all_node, &dept_event_sites);
> > +
> > +             pr_info("dept_event_site %s@%s is initialized.\n",
> > +                             (*evtinitpp)->evt_site->name,
> > +                             (*evtinitpp)->evt_site->func_name);
> > +     }
> > +}
> > +
> >  extern char __dept_event_sites_start[], __dept_event_sites_end[];
> 
> Related to the above, __dept_event_sites_start and
> __dept_event_sites_end can already be properly typed here.

How can I get the number of the pointers?

> >
> >  /*
> > @@ -3356,20 +3424,11 @@ extern char __dept_event_sites_start[], __dept_event_sites_end[];
> >  void __init dept_init(void)
> >  {
> >       size_t mem_total = 0;
> > -     struct dept_event_site_init **evtinitpp;
> >
> >       /*
> >        * dept recover dependency tracking works from now on.
> >        */
> > -     for (evtinitpp = (struct dept_event_site_init **)__dept_event_sites_start;
> > -          evtinitpp < (struct dept_event_site_init **)__dept_event_sites_end;
> > -          evtinitpp++) {
> > -             (*evtinitpp)->evt_site->used = true;
> > -             (*evtinitpp)->evt_site->func_name = (*evtinitpp)->func_name;
> > -             pr_info("dept_event %s@%s is initialized.\n",
> > -                             (*evtinitpp)->evt_site->name,
> > -                             (*evtinitpp)->evt_site->func_name);
> > -     }
> > +     dept_mark_event_site_used(__dept_event_sites_start, __dept_event_sites_end);
> >       dept_recover_ready = true;
> >
> >       local_irq_disable();
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index 03ed63f2adf0..82448cdb8ed7 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -2720,6 +2720,11 @@ static int find_module_sections(struct module *mod, struct load_info *info)
> >                                               &mod->dyndbg_info.num_classes);
> >  #endif
> >
> > +#ifdef CONFIG_DEPT
> > +     mod->dept_event_sites = section_objs(info, ".dept.event_sites",
> > +                                     sizeof(*mod->dept_event_sites),
> > +                                     &mod->num_dept_event_sites);
> > +#endif
> >       return 0;
> >  }
> >
> > @@ -3346,6 +3351,14 @@ static int early_mod_check(struct load_info *info, int flags)
> >       return err;
> >  }
> >
> > +static void dept_mark_event_site_used_module(struct module *mod)
> > +{
> > +#ifdef CONFIG_DEPT
> > +     dept_mark_event_site_used(mod->dept_event_sites,
> > +                          mod->dept_event_sites + mod->num_dept_event_sites);
> > +#endif
> > +}
> > +
> 
> It seems to me that the .dept.event_sites section can be discarded after
> the module is initialized. In this case, the section should be prefixed
> by ".init" and its address can be obtained at the point of use in
> dept_mark_event_site_used_module(), without needing to store it inside
> the module struct.

Maybe yes.  I will try.  Thank you.

> Additionally, what is the reason that the dept_event_site_init data is
> not stored in the .dept.event_sites section directly and it requires
> a level of indirection?

Maybe yes.  I will try to store dept_event_site_init in the
.dept.event_sites section directly.

> In general, for my own understanding, I also wonder whether the check to
> determine that a dept_event_site is used needs to be done at runtime, or
> if it could be done at build time by objtool/modpost.

You are right.  I picked what I'm used to the most, among all the
candidate methods.  However, I will try to use a better way if you
suggest what you think it should be.

Thanks for the thorough review, Petr.

	Byungchul

> >  /*
> >   * Allocate and load the module: note that size of section 0 is always
> >   * zero, and we rely on this for optional sections.
> > @@ -3508,6 +3521,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
> >       /* Done! */
> >       trace_module_load(mod);
> >
> > +     dept_mark_event_site_used_module(mod);
> > +
> >       return do_init_module(mod);
> >
> >   sysfs_cleanup:
> 
> --
> Thanks,
> Petr

