Return-Path: <linux-fsdevel+bounces-64091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481E2BD7970
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 08:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058B94063A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 06:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5CD2D12E7;
	Tue, 14 Oct 2025 06:38:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E101C2010EE;
	Tue, 14 Oct 2025 06:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760423932; cv=none; b=WNAlLULDCKWPSEza5dePnMCsNPcTxKwGcctrWh8yDaQtShjRNmEc512BFSJ6MCCiekxXDbISm6xBarMKUvI9S4Wd7JD6wzMqip8GISxoQBzpLk/vTzPJqXRHctld2woMVoNF/vFlD1RtsXm6b4j5P0k1leUPVO7mojT+YUwwkIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760423932; c=relaxed/simple;
	bh=WTdEIPVnTjVYFmBVT010VFa83HYwQgS+DTRMlHzMHzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6IU/dR+myfq1GsCZb73Jb2DO9UMNCaZnDFrTgZjF+aBdB0Qy8XsG3LPq9RY5Bd/tdO6IA0i5kTrnewLtndR0ZG2RdC2ZCq49XOKvya32vSM0gtKr8ewKJKRS1P1FMLshof5/KZ5oANr+IOdSk74hwhskM5bi7TXN4WQlYzT8j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-23-68edefefb741
Date: Tue, 14 Oct 2025 15:38:33 +0900
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
Message-ID: <20251014063833.GA58074@system.software.com>
References: <20251002081247.51255-1-byungchul@sk.com>
 <20251002081247.51255-29-byungchul@sk.com>
 <175947451487.247319.6809470356431942803@noble.neil.brown.name>
 <20251013052354.GA75512@system.software.com>
 <176042183810.1793333.13639772065939276568@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176042183810.1793333.13639772065939276568@noble.neil.brown.name>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxbVRjGPfee+9Fm1WvF7DiMJjVzygJuhmTvovuKRm9MbDDGLZkxs8rN
	2qwULIwNF5NuYxuyEbCmVMogZQzW0SKlsLlOapCPIim4goMVxnAQZCJ0TRDQAQVblsX993uf
	J+/zvCc5PK2sZDfwOkOOZDRo9CpWjuXhdVXJkUhYu2VoaTsMHm/FcL7BxUKBp4yBf5bKaTjl
	XcUQNfs5mHtwm4NVnx9BaZ+Zhun2WQSWsQkWrFPHMdgmyzmY6nwXbi3MIKidWKFgovUMgmjp
	IbBaggj+dMcmn+MEC3+UXKHh5nyEhW7LWRbCfecpuO9mwX7Cx0BFuRnByeoGFkorPBj6ppcp
	GCk1U+D0vA+BkgtUrC7mNa4HS/2PFPRUj2AYd9g4WB7bCqv2TPA773Fwp9iC4fvwDQa6RwcZ
	+L3rNAM/mO7GHnFzjALXuUkaCq7PY/ANb4aq0xcxlFWOsNDi68ZQEJ1D4L82TsE59xUGRl2r
	DARbAwz0O4MYGu6FKAj4f8Fw43o9A029PfTudLGu6SoluipdSFxaNCPxVEmM2mcitFgTmGHF
	xfkBVvymN1n02u5wYv5Pw5xo9xwW8zvCjNjkSBKrW6YocXh6h+ip+5pNS9ovfzNd0utyJeNr
	Oz+Vay8W27ksb/LR5vYOZEIVLxQiGU+EVNLRe5t7xN/5/qILEc9jYSPp9O6Oy6ywiYRCD+g4
	JwgvksbmIaoQyXlaqE0kIevCmvGMsIv8OuBCcVYIQPqdDWuZSsFKkTOBDx7qT5PusgkcZ1pI
	IqGVKSreRQuJ5NIKH5dlgprcGrWurT4rvERar3atdRFhXEYu50fRwzufIz87QrgECbbHYm2P
	xdr+j7Ujug4pdYbcDI1On5qizTPojqZ8npnhQbFfW/vV8sfX0GzwwzYk8Ei1ThFamdEqGU1u
	dl5GGyI8rUpQbDsWkxTpmrwvJWPmAeNhvZTdhhJ5rFqveH3hSLpSOKjJkQ5JUpZkfORSvGyD
	CRVtbNlv6mF2vH32iTTZy2amf7a303z35LcH/o1gx2JKkfrVQJBseWcPU+PO21vwpDg+d+HI
	TrXKmyDLMjz1yWb1exkfFadtP1b01vwrg5fIZM3BnC8GVPdrm02pVbs+G6kPLvu3DSwN/aZw
	vxFU12xy/v28vmOPpXGfPaeoa2+0T8pV4WytZmsSbczW/Adn3NiEsQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxTHfe7z9N5LQ8214riRRLMaozFBZZnbyTCIH6ZXjUSJk8TEaKN3
	tuHNtYKiMSkCgzCHpVlbaUUrjmpKFaQV7bCGgWVzDBWY2k2RQQqKgE2Ul/BWbF0W/XLyP7//
	+eecD4fF8hnJYladdUTUZCkzFLSUSFMSC+KDwRHVWl+DBB7nNxEYGy0hcK7WSUNJfYUEHl6r
	QdAzVoJgYtqKocgzR2DW0MrA6ORTBua8rQhMHQYMTnc+BW/rQjQMtbxBYOwN0GAezCcQtJ9G
	YBmwMjDo2wwjPY0SmOt+QcGT8WEE9kCIgkBTMYJZUzpcqHLRMN3+AIPZ+BDBxd5uDC/rwqa7
	9TkC75VTNPTrb2DoCsyHv8aCNNwz/kDDSMc5Cl7X0WA75ZVApdWAoOBSLQ2mynoCnn9/YaBj
	aIaCZyYDBTX126HHPkCgTV9Fhe8LT12PBau5gAqXlxQYrzZSMGl3MPDnpWcE7LrlYG3vkkDf
	FQsDM70JMGfLhtaaFwx0nzESuDbyQJJsRMJEURkRHK4GSijqnKUF53knEqanDEgYrS7AQpE+
	3LYMB7FQ6DoqVLcN08LU2CNa8I7biPBHFS+Ut8cLHks3IxTe+YfZ8dUe6fqDYoY6V9SsSdov
	Vf18xsYc9sQfc7fcRTpUuaQURbE89zl/1vsKlyKWJdxy3udJjmCaW8H7/ZM4omO4pfx1999U
	KZKymLPH8X7z+HtjIbeBv//IiSJaxgHfWVPLRLScM1N8cdvO//gC/l5FgEQ05lbx/tAgFdmF
	uTj+coiN4CguhX/y3Pw+uohbxjc1/EbpkczyUdryUdryIW1D2IFi1Fm5mUp1xrrV2nRVXpb6
	2OoD2Zn1KPyT9pMz5bfQaNfmZsSxSBEt84eGVXKJMlebl9mMeBYrYmRfnggj2UFl3nFRk71P
	k5MhaptRHEsUsbKtaeJ+OXdIeURMF8XDouZ/l2KjFutQ2cUV61y/uivcKYGeNbFJ3wf2vDLn
	7N7Y79uk/2kfKf4s9VP/tOO2+2uTvR2/1e9NNva5BjatNMlzEnVeotmSoPnE7LtZ2VDtOKna
	GN3YyS76duj+0vjTE0l76Xmvb32TFv208HHfiV3zE1MHf79bNlWecuDHAd0Xk9/1b9uWtrb/
	0FEF0aqUCauwRqt8B4xzrPqPAwAA
X-CFilter-Loop: Reflected

On Tue, Oct 14, 2025 at 05:03:58PM +1100, NeilBrown wrote:
> On Mon, 13 Oct 2025, Byungchul Park wrote:
> > On Fri, Oct 03, 2025 at 04:55:14PM +1000, NeilBrown wrote:
> > > On Thu, 02 Oct 2025, Byungchul Park wrote:
> > > > This document describes the concept and APIs of dept.
> > > >
> > >
> > > Thanks for the documentation.  I've been trying to understand it.
> >
> > You're welcome.  Feel free to ask me if you have any questions.
> >
> > > > +How DEPT works
> > > > +--------------
> > > > +
> > > > +Let's take a look how DEPT works with the 1st example in the section
> > > > +'Limitation of lockdep'.
> > > > +
> > > > +   context X    context Y       context Z
> > > > +
> > > > +                mutex_lock A
> > > > +   folio_lock B
> > > > +                folio_lock B <- DEADLOCK
> > > > +                                mutex_lock A <- DEADLOCK
> > > > +                                folio_unlock B
> > > > +                folio_unlock B
> > > > +                mutex_unlock A
> > > > +                                mutex_unlock A
> > > > +
> > > > +Adding comments to describe DEPT's view in terms of wait and event:
> > > > +
> > > > +   context X    context Y       context Z
> > > > +
> > > > +                mutex_lock A
> > > > +                /* wait for A */
> > > > +   folio_lock B
> > > > +   /* wait for A */
> > > > +   /* start event A context */
> > > > +
> > > > +                folio_lock B
> > > > +                /* wait for B */ <- DEADLOCK
> > > > +                /* start event B context */
> > > > +
> > > > +                                mutex_lock A
> > > > +                                /* wait for A */ <- DEADLOCK
> > > > +                                /* start event A context */
> > > > +
> > > > +                                folio_unlock B
> > > > +                                /* event B */
> > > > +                folio_unlock B
> > > > +                /* event B */
> > > > +
> > > > +                mutex_unlock A
> > > > +                /* event A */
> > > > +                                mutex_unlock A
> > > > +                                /* event A */
> > > > +
> > >
> > > I can't see the value of the above section.
> > > The first section with no comments is useful as it is easy to see the
> > > deadlock being investigate.  The section below is useful as it add
> > > comments to explain how DEPT sees the situation.  But the above section,
> > > with some but not all of the comments, does seem (to me) to add anything
> > > useful.
> >
> > I just wanted to convert 'locking terms' to 'wait and event terms' by
> > one step.  However, I can remove the section you pointed out that you
> > thought was useless.
> 
> But it seems you did it in two steps???
> 
> If you think the middle section with some but not all of the comments
> adds value (And maybe it does - maybe I just haven't seen it yet), the
> please explain what value is being added at each step.
> 
> It is currently documented as:
> 
>  +Adding comments to describe DEPT's view in terms of wait and event:
> 
> then
> 
>  +Adding more supplementary comments to describe DEPT's view in detail:
> 
> Maybe if you said more DEPT's view so at this point so that when we see
> the supplementary comments, we can understand how they relate to DEPT's
> view.

As you pointed out, I'd better remove the middle part so as to simplify
it.  It doesn't give much information I also think.

> > > > +
> > > > +   context X    context Y       context Z
> > > > +
> > > > +                mutex_lock A
> > > > +                /* might wait for A */
> > > > +                /* start to take into account event A's context */
> > >
> > > What do you mean precisely by "context".
> >
> > That means one of task context, irq context, wq worker context (even
> > though it can also be considered as task context), or something.
> 
> OK, that makes sense.  If you provide this definition for "context"
> before you use the term, I think that will help the reader.

Thank you.  I will add it.

> > > If the examples that follow It seems that the "context" for event A
> > > starts at "mutex lock A" when it (possibly) waits for a mutex and ends
> > > at "mutex unlock A" - which are both in the same process.  Clearly
> > > various other events that happen between these two points in the same
> > > process could be seen as the "context" for event A.
> > >
> > > However event B starts in "context X" with "folio_lock B" and ends in
> > > "context Z" or "context Y" with "folio_unlock B".  Is that right?
> >
> > Right.
> >
> > > My question then is: how do you decide which, of all the event in all
> > > the processes in all the system, between the start[S] and the end[E] are
> > > considered to be part of the "context" of event A.
> >
> > DEPT can identify the "context" of event A only *once* the event A is
> > actually executed, and builds dependencies between the event and the
> > recorded waits in the "context" of event A since [S].
> 
> So a dependency is an ordered set of pairs of "context" and "wait" or

I don't get what you were trying to tell here.  FWIW, DEPT focuses on
*event* contexts and, within each event context, it tracks pairs of
waits that appears since [S] and the interesting event that identifies
the event context.

> "context" and "event".  "wait"s and "event"s are linked by some abstract
> identifier for the event (like lockdep's lock classes).

Yeah, kind of.

> How are the contexts abstracted. Is it just "same" or "different"

I don't get this.  Can you explain in more detail?

	Byungchul

> I'll try reading the document again and see how much further I get.
> 
> Thanks,
> NeilBrown

