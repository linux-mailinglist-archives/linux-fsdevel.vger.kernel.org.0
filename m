Return-Path: <linux-fsdevel+bounces-63906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 766FCBD170D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 07:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 307E43B8D30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 05:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AF12C21D6;
	Mon, 13 Oct 2025 05:24:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB1817597;
	Mon, 13 Oct 2025 05:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760333047; cv=none; b=SToUgE8ulh7OgKtiPUBjbpAyMWD38Q+bPiH/uwx6asYF2p0vjCEwOfwRVAqpOqXfJplBMqJ0cQmbqg31nJ/HZ/t10NjvSzZYAPa6jU4qshrfDM7BPXL95h/iiFFsSaikTDecGgrQdD1yEOAe1btON7QSNBdI3k2DKxkxS5we66E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760333047; c=relaxed/simple;
	bh=6Qo/Wic5X1LYWt4OoazfZZbUqoh99G+h1XTb2LemI04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYKv2Xx0IzscXaWfFKfc47wOLzJj8ZdNOeyP/K885GKb1WdVCKRcapxSsdVUCiELif34zWlaLMe0yiX6RkeJ/fwpBKuvfBDzR0g7IMpRKaccFiDjhYUQgjrjnMpjO6QLQcCyiwJv0GMA8UtM89AmFNZLyyv1kClYMQEu4EfZLr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-69-68ec8cf09a1c
Date: Mon, 13 Oct 2025 14:23:54 +0900
From: Byungchul Park <byungchul@sk.com>
To: NeilBrown <neil@brown.name>
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
	will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
	joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
	duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
	tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
	amir73il@gmail.com, gregkh@linuxfoundation.org, kernel-team@lge.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
	minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
	sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
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
	catalin.marinas@arm.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, luto@kernel.org,
	sumit.semwal@linaro.org, gustavo@padovan.org,
	christian.koenig@amd.com, andi.shyti@kernel.org, arnd@arndb.de,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	rppt@kernel.org, surenb@google.com, mcgrof@kernel.org,
	petr.pavlu@suse.com, da.gomez@kernel.org, samitolvanen@google.com,
	paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, josh@joshtriplett.org, urezki@gmail.com,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	chuck.lever@oracle.com, okorniev@redhat.com, Dai.Ngo@oracle.com,
	tom@talpey.com, trondmy@kernel.org, anna@kernel.org,
	kees@kernel.org, bigeasy@linutronix.de, clrkwllms@kernel.org,
	mark.rutland@arm.com, ada.coupriediaz@arm.com,
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
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v17 28/47] dept: add documentation for dept
Message-ID: <20251013052354.GA75512@system.software.com>
References: <20251002081247.51255-1-byungchul@sk.com>
 <20251002081247.51255-29-byungchul@sk.com>
 <175947451487.247319.6809470356431942803@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175947451487.247319.6809470356431942803@noble.neil.brown.name>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxjGc+49t/e2ocmxunEQsyVVXEIyp4sfb5ybLsuS84cmGhM1M1Ma
	e7NWS9HyoWgWa4QJKIagttqiFssKVgyjDCabIIMoMxkVFKVoVegYggWcja1R+XDFGP3vl+d5
	87zPH4/EazqF2ZLRnCVbzDqTVqHCqtGE8k//OzJiWPjSvwiizwowlNVUKyC/cQrDsxf3RLB1
	lfIQbosgsA8fwOAYdIrQExtBMGHbAa86bvBQ3n+fh39L6nkY7Srj4KC7RgG22kRw2oc4+Nsd
	xOCxpoCz45YAoSqHCFOuDHjY/pMAv1n7RPD1XkVQ8HsUw+Wm6xiuXQpxcOSXegGszucCXBw7
	pwBP9IkIN1tcHFxzfQilgxER6q/kI2gvbuGgw+kXIHj0MYbmgj4OHjlOc3DspksBkdOTAlzo
	wnA434YhL7gELk7cQeC8+kBctZB56xo4Vn2mGrG8ut3sZfS2gjXFXJg1Ou6LLK/5rshcvmxW
	V5XK3JeHOVYeiQrsbvhL5vMWKtiY3y+yv06+wmyg286tTfpOtUIvm4w5suWzr9JUhgPeJ/zO
	3q/3dE4kWVFxahGSJEoW0xPFS4uQchofOOr4OGOSQrsHG8U4K8gnNBB4Ma3PIh/T2l97uSKk
	knjiSaYBe2zamElWUv/tahRnNQF6pexnFD/SkApEz54oEN8YM+j1UwM4zjxJpYHJYS5egifJ
	tHJSistKspr2eIa4OH9A5tKWhvbpZ5SElLS7r4Z70zSJ/lkVwCWION6LdbwX63gX60K8F2mM
	5px0ndG0eIEh12zcs2BbRroP/b8zz4/jmy+hSOf6VkQkpE1QG/4IGzSCLiczN70VUYnXzlIv
	2zdi0Kj1uty9siVjqyXbJGe2omQJaxPVn8d26zXkB12WvEOWd8qWty4nKWdbUeWcXav1S+fp
	0/IiZVPNz7/YoDteeC6/wrlpNFgxr2n/Pru5oWdusOr72vlzxpaFNna0VRaO+2Y0+vuzko6m
	bSb9Kcu97OmQpzg7d2/OFrbdmWBb587+Rmjbvsb1j3JoLfEOnEm88FFv6dT42CryrSocSgnH
	tpWMHOo2nX/qlucf1OJMg25RKm/J1L0Gg++vf2MDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUwTdxjH/d1d747OMyeDeEiisdOZkKgz0/hEjUOj8XyZGrPMl0RHI+fa
	8JrWVdBsoQKhOtDSpG1oURHkhqUKAjOiKWtwdnPCyosMdEKHqbxIuy4bxSAUvGrM/OfJ5/l+
	n++T54+HxmMjsoW0OvOEoMlUpitIOSHfsyF/xT/FAdUn4XIW/tC7CQiPGwgor3OSYGgok0HH
	jVoEvrABwcspOw6FzbMEREweCsYn/6Rg1uVBYOk04eBs0mPwX/0MCWP3/kVgHvSTYB3VExAS
	ixHYhuwUjN7fDkHfXRnM9g9j0DsRQCD6ZzDwu4sQRCxpcLmykYSpdi8OVnMHgiuD/TiM1Etm
	k2cAgavmDAnPjT/i0O2fB4/CIRIemL8nIdhZjsHf9SRUnHHJ4KLdhCC/qo4Ey8UGApr/ukNB
	59g0Bk8tJgxqGz4HnzhEwENjJSbdJ03dXAB2az4mlREMzNfvYjApOihoq3pKgJi3DOzt3TJ4
	VmOjYHpwNcxWZIGndpiC/gtmAm4EvbJkM+JfFp4neEfjLYwv7IqQvPOSE/FTr0yIH6/Ox/lC
	o9TeC4RwvqDxJF/9MEDyr8I9JO+aqCD43yo5vrR9Bd9s66f4gpYn1L71h+UbU4V0tU7QrNqU
	IlfpHSE8+/HmnI5IQh4qSTqHYmiOXcMN2BrxKBPsMu7RUDMVZZJdzvX1Tb7R49jF3M2mx9g5
	JKdxVkzk+qwTb4wP2c+433ucKMoMC9xP5dUoOhTLXkXcZbOBemvM5x6U+Yko42wS1zczKm2i
	JU7kfpiho3IMu5vrFUewKMezH3HuW79gRsTY3kvb3kvb/k9XINyB4tSZugylOn3tSm2aKjdT
	nbPyWFZGA5KeUvx2uvQ2Gu/e3opYGinmMvuKAqpYmVKnzc1oRRyNK+KYdacliUlV5p4SNFlf
	ab5JF7StKJEmFAuYnQeElFj2a+UJIU0QsgXNOxejYxbmod1HJuJ9V7K7wLNkOMJ81xPzZcr5
	bccSci9s3FG85VoIPt1r3ZNzVCRdXkNCywdOmRf74vrBtqJDJR+ftPTqurKPl+x6saHEvfbJ
	+mTSn7ouVLejR++t31/jphYlz41T0B2+4ICSdpTN2aprK2ihz6qYMeOan4Pxvx69s2VpKVOl
	ILQq5eokXKNVvgZzqHjckAMAAA==
X-CFilter-Loop: Reflected

On Fri, Oct 03, 2025 at 04:55:14PM +1000, NeilBrown wrote:
> On Thu, 02 Oct 2025, Byungchul Park wrote:
> > This document describes the concept and APIs of dept.
> >
> 
> Thanks for the documentation.  I've been trying to understand it.

You're welcome.  Feel free to ask me if you have any questions.

> > +How DEPT works
> > +--------------
> > +
> > +Let's take a look how DEPT works with the 1st example in the section
> > +'Limitation of lockdep'.
> > +
> > +   context X    context Y       context Z
> > +
> > +                mutex_lock A
> > +   folio_lock B
> > +                folio_lock B <- DEADLOCK
> > +                                mutex_lock A <- DEADLOCK
> > +                                folio_unlock B
> > +                folio_unlock B
> > +                mutex_unlock A
> > +                                mutex_unlock A
> > +
> > +Adding comments to describe DEPT's view in terms of wait and event:
> > +
> > +   context X    context Y       context Z
> > +
> > +                mutex_lock A
> > +                /* wait for A */
> > +   folio_lock B
> > +   /* wait for A */
> > +   /* start event A context */
> > +
> > +                folio_lock B
> > +                /* wait for B */ <- DEADLOCK
> > +                /* start event B context */
> > +
> > +                                mutex_lock A
> > +                                /* wait for A */ <- DEADLOCK
> > +                                /* start event A context */
> > +
> > +                                folio_unlock B
> > +                                /* event B */
> > +                folio_unlock B
> > +                /* event B */
> > +
> > +                mutex_unlock A
> > +                /* event A */
> > +                                mutex_unlock A
> > +                                /* event A */
> > +
> 
> I can't see the value of the above section.
> The first section with no comments is useful as it is easy to see the
> deadlock being investigate.  The section below is useful as it add
> comments to explain how DEPT sees the situation.  But the above section,
> with some but not all of the comments, does seem (to me) to add anything
> useful.

I just wanted to convert 'locking terms' to 'wait and event terms' by
one step.  However, I can remove the section you pointed out that you
thought was useless.

> > +Adding more supplementary comments to describe DEPT's view in detail:
> > +
> > +   context X    context Y       context Z
> > +
> > +                mutex_lock A
> > +                /* might wait for A */
> > +                /* start to take into account event A's context */
> 
> What do you mean precisely by "context".

That means one of task context, irq context, wq worker context (even
though it can also be considered as task context), or something.

Of course, in the example above, it must be task context since it showed
a case involving only sleepible ones.  However, I wanted to use general
terms in the document to cover all the types of context e.g. irq, task,
and so on.

> You use the word in the heading "context X  context Y  context Z"
> so it seems like "context" means "task" or "process".  But then as I
> read on, I think - maybe it means something else.  If it does, then you
> should use different words.  Maybe "task X ..." in the heading.

It should cover all the types of context.  What word would you recommend
for that purpose?

> If the examples that follow It seems that the "context" for event A
> starts at "mutex lock A" when it (possibly) waits for a mutex and ends
> at "mutex unlock A" - which are both in the same process.  Clearly
> various other events that happen between these two points in the same
> process could be seen as the "context" for event A.
> 
> However event B starts in "context X" with "folio_lock B" and ends in
> "context Z" or "context Y" with "folio_unlock B".  Is that right?

Right.

> My question then is: how do you decide which, of all the event in all
> the processes in all the system, between the start[S] and the end[E] are
> considered to be part of the "context" of event A.

DEPT can identify the "context" of event A only *once* the event A is
actually executed, and builds dependencies between the event and the
recorded waits in the "context" of event A since [S].

> I think it would help me if you defined what a "context" is earlier.

Sorry if my description was not clear enough.

	Byungchul

> What sorts of things appear in a context?
> 
> Thanks,
> NeilBrown
> 
> 
> > +                /* 1 */
> > +   folio_lock B
> > +   /* might wait for B */
> > +   /* start to take into account event B's context */
> > +   /* 2 */
> > +
> > +                folio_lock B
> > +                /* might wait for B */ <- DEADLOCK
> > +                /* start to take into account event B's context */
> > +                /* 3 */
> > +
> > +                                mutex_lock A
> > +                                /* might wait for A */ <- DEADLOCK
> > +                                /* start to take into account
> > +                                   event A's context */
> > +                                /* 4 */
> > +
> > +                                folio_unlock B
> > +                                /* event B that's been valid since 2 */
> > +                folio_unlock B
> > +                /* event B that's been valid since 3 */
> > +
> > +                mutex_unlock A
> > +                /* event A that's been valid since 1 */
> > +
> > +                                mutex_unlock A
> > +                                /* event A that's been valid since 4 */
> > +
> > +Let's build up dependency graph with this example. Firstly, context X:
> > +
> > +   context X
> > +
> > +   folio_lock B
> > +   /* might wait for B */
> > +   /* start to take into account event B's context */
> > +   /* 2 */
> > +
> > +There are no events to create dependency. Next, context Y:
> > +
> > +   context Y
> > +
> > +   mutex_lock A
> > +   /* might wait for A */
> > +   /* start to take into account event A's context */
> > +   /* 1 */
> > +
> > +   folio_lock B
> > +   /* might wait for B */
> > +   /* start to take into account event B's context */
> > +   /* 3 */
> > +
> > +   folio_unlock B
> > +   /* event B that's been valid since 3 */
> > +
> > +   mutex_unlock A
> > +   /* event A that's been valid since 1 */
> > +
> > +There are two events. For event B, folio_unlock B, since there are no
> > +waits between 3 and the event, event B does not create dependency. For
> > +event A, there is a wait, folio_lock B, between 1 and the event. Which
> > +means event A cannot be triggered if event B does not wake up the wait.
> > +Therefore, we can say event A depends on event B, say, 'A -> B'. The
> > +graph will look like after adding the dependency:
> > +
> > +   A -> B
> > +
> > +   where 'A -> B' means that event A depends on event B.
> > +
> > +Lastly, context Z:
> > +
> > +   context Z
> > +
> > +   mutex_lock A
> > +   /* might wait for A */
> > +   /* start to take into account event A's context */
> > +   /* 4 */
> > +
> > +   folio_unlock B
> > +   /* event B that's been valid since 2 */
> > +
> > +   mutex_unlock A
> > +   /* event A that's been valid since 4 */
> > +
> > +There are also two events. For event B, folio_unlock B, there is a
> > +wait, mutex_lock A, between 2 and the event - remind 2 is at a very
> > +start and before the wait in timeline. Which means event B cannot be
> > +triggered if event A does not wake up the wait. Therefore, we can say
> > +event B depends on event A, say, 'B -> A'. The graph will look like
> > +after adding the dependency:
> > +
> > +    -> A -> B -
> > +   /           \
> > +   \           /
> > +    -----------
> > +
> > +   where 'A -> B' means that event A depends on event B.
> > +
> > +A new loop has been created. So DEPT can report it as a deadlock. For
> > +event A, mutex_unlock A, since there are no waits between 4 and the
> > +event, event A does not create dependency. That's it.
> > +
> > +CONCLUSION
> > +
> > +DEPT works well with any general synchronization mechanisms by focusing
> > +on wait, event and its context.
> > +

