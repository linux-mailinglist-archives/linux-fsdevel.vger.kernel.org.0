Return-Path: <linux-fsdevel+bounces-71300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A0ECBD1FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 10:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5D893020489
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 09:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDA832B996;
	Mon, 15 Dec 2025 09:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbFVAkV+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821F832AADF
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765789597; cv=none; b=VdWdI43zbPQ3CIfJ7U8iAg936q1eDYKiEa+cC2D2wN/r2WG59SQNN7F+z0O7I80zBSGnyVK6ykJCLgyUErxiNe5+1w9Vq7rOcq1fjGGSAzuF9+Mj6VcFZ65vHE1yCye4cQNoGb/G659A0pGzh2te50YYizSoxKp9OakP8TKKRh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765789597; c=relaxed/simple;
	bh=S+I//71CAh3HG/ntXLeYl26reZdigPregIquYcMsXSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2b2cgWKsRmJbyUCIxuJhVuG5JXW/IRg5JthFyshEZCZB0vxGSYO9I2s+H25PwX2+iC74FSfpUVf3azR1plP2rV+2YZ8t0XW+WPI7bfWXt4RN/hXK5PYaWDGsZvRu+zzO39PHRwk08nG/0Z8uwjf2xXU0rgJB92gTk4d14ViWsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbFVAkV+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a1022dda33so4858295ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 01:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765789594; x=1766394394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8TFzbFLNA/s8ANuMZPs94U2cOEd+GIJ7ZeP4XFmQHWk=;
        b=DbFVAkV+9bTUaL3zUOZGSc0ehmkKrcH059r2y+rCYu7r+CHzao1iJXSCCC5cedExGk
         lUC2x3ndImTxfy2TzVNU7aYEMm8XfAAcAwI+/6JLFQ9jLRJvSbjYfnlhjcC5TrYW9VjU
         R+FFVb8CvOJyUo4cFcBrc9zCq4UNwbfkmt0RK4S/sFIrK8JRRDElD4P2xebPK4ZF+RDQ
         PN38jaHyahmmFKr8N+L8e7UCZhhKzUzX4GyVaFn1lHh1UyLS/UnZQqaJrNfKgZyKoiHn
         g2szT0mVHspGhIaaEeT5bxxsrxGNsX8UTGokIauxxAN1NuvFMl13TZFfSZYm5Hjzvf6n
         9OOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765789594; x=1766394394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TFzbFLNA/s8ANuMZPs94U2cOEd+GIJ7ZeP4XFmQHWk=;
        b=NIcQVAZ2rv+kdPGFH6mVlzA2bArjvGK4EEUKdhfClXBob3H1bzXi/e5gknHD7txc2r
         uSw4R2Z85uL9tQECJWx31zI3qKj8nxK5q0J7ExCOXNzS10qiyPPtvCKeB04UbH5IutP9
         MGqIsTwoQhMJQTMM5z9Ilqwbca9v8lTXTegoVeQYuLKHOu+oXpZzoipfW3j6x1R5cPPc
         2yrNYBY85VkGaznlBXBD+8wSeuu7+kWAg/7Zjt3kgtdAXM0gyVE1DErCFNrIcCJzhZBG
         uJFBLAANBnxhqaY2NisZqlNNcDTZ2DRz6gSWKpiJL7ztqT5Pap5h4fSB8G+g5NwkDXR1
         BTPA==
X-Forwarded-Encrypted: i=1; AJvYcCWfVHDWpA+113Tj0Gz8e/w824gc6a3/nkkG3wV4sOmriuS2EHZEHepj0L8+yLoYAdFkT0rMxzydMnA0at1b@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw/GnbWfkkycdM4+3vgEElzdwzqYHP+El69B3A4lGYHrSSVX+E
	if5kevWtpsM5mGKYVbMneBLB+uJm3mBmFutrg5ZEnD7hRw85hRjZxBY5
X-Gm-Gg: AY/fxX7WIZGRJ1snjigJOfDocMQC8aezEvvcmMkXCk68pnOenGrHQVZrYx5rcs+1dbc
	50IEFdxodyEZw4hcAX+zZ1NmyLtt+mufpIGCGdCq2CqLCaxzjwVUfqOz3UUkVWpbtfyNwwCK0q9
	U1w2NZqShXKZ3TQwVz8rp1eGihzXntV5jJiVchFNC6XRW9ur09U4K67odNyxfXCqEK/Tl9qf0Ne
	zkSGy9FsJMoFZtucXOaxyGknzjfn40c8EiauzkpTO97EKfuX30bSKrJs6uwLUEWREeulakUdgaL
	zAgL7Ihl34qk4i47u7464FW2nyqr4/IQDRLly8ZyZNTmqDs8jKsOX0a13OVKwPvEiImOUAqdL1v
	MRv7p/shNfjtfDT77thlzUWtETMbFByAjbVGadmT34m6vwAJyzaUQ0NuqREYG5kREQ64q57grcN
	DMnSDxBhysJ5wkPt9lkqIsHw==
X-Google-Smtp-Source: AGHT+IGzyDWmqhEU1Z8oAXr89HQnWirxmApn4cZ+UbhSq+NqKKmus5Ux4BVNBkt46IA1IaRTWuk54w==
X-Received: by 2002:a17:903:2f10:b0:295:570d:116e with SMTP id d9443c01a7336-29f243447f0mr103959285ad.41.1765789593648;
        Mon, 15 Dec 2025 01:06:33 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9d38ae7sm127996155ad.35.2025.12.15.01.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 01:06:32 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 271FE41902F7; Mon, 15 Dec 2025 16:06:28 +0700 (WIB)
Date: Mon, 15 Dec 2025 16:06:28 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Byungchul Park <byungchul@sk.com>
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
	catalin.marinas@arm.com, bp@alien8.de, x86@kernel.org,
	hpa@zytor.com, luto@kernel.org, sumit.semwal@linaro.org,
	gustavo@padovan.org, christian.koenig@amd.com,
	andi.shyti@kernel.org, arnd@arndb.de, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com,
	mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org,
	samitolvanen@google.com, paulmck@kernel.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	josh@joshtriplett.org, urezki@gmail.com,
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
	wsa+renesas@sang-engineering.com, dave.hansen@intel.com,
	geert@linux-m68k.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v18 25/42] dept: add documents for dept
Message-ID: <aT_PlFHyQB6HyZXG@archie.me>
References: <20251205071855.72743-1-byungchul@sk.com>
 <20251205071855.72743-26-byungchul@sk.com>
 <aTN38kJjBftxnjm9@archie.me>
 <20251215042237.GA49936@system.software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oXMU5jEQKY7U45cC"
Content-Disposition: inline
In-Reply-To: <20251215042237.GA49936@system.software.com>


--oXMU5jEQKY7U45cC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 01:22:37PM +0900, Byungchul Park wrote:
> On Sat, Dec 06, 2025 at 07:25:22AM +0700, Bagas Sanjaya wrote:
> > On Fri, Dec 05, 2025 at 04:18:38PM +0900, Byungchul Park wrote:
> > > Add documents describing the concept and APIs of dept.
> > >=20
> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > ---
> > >  Documentation/dev-tools/dept.rst     | 778 +++++++++++++++++++++++++=
++
> > >  Documentation/dev-tools/dept_api.rst | 125 +++++
> >=20
> > You forget to add toctree entries:
>=20
> I'm sorry for late reply.
>=20
> Thanks a lot!
>=20
> > ---- >8 ----
> > diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tool=
s/index.rst
> > index 4b8425e348abd1..02c858f5ed1fa2 100644
> > --- a/Documentation/dev-tools/index.rst
> > +++ b/Documentation/dev-tools/index.rst
> > @@ -22,6 +22,8 @@ Documentation/process/debugging/index.rst
> >     clang-format
> >     coccinelle
> >     sparse
> > +   dept
> > +   dept_api
> >     kcov
> >     gcov
> >     kasan
> >=20
> > > +Lockdep detects a deadlock by checking lock acquisition order.  For
> > > +example, a graph to track acquisition order built by lockdep might l=
ook
> > > +like:
> > > +
> > > +.. literal::
> > > +
> > > +   A -> B -
> > > +           \
> > > +            -> E
> > > +           /
> > > +   C -> D -
> > > +
> > > +   where 'A -> B' means that acquisition A is prior to acquisition B
> > > +   with A still held.
> >=20
> > Use code-block directive for literal code blocks:
>=20
> I will.
>=20
> > ---- >8 ----
> > diff --git a/Documentation/dev-tools/dept.rst b/Documentation/dev-tools=
/dept.rst
> > index 333166464543d7..8394c4ea81bc2a 100644
> > --- a/Documentation/dev-tools/dept.rst
> > +++ b/Documentation/dev-tools/dept.rst
> > @@ -10,7 +10,7 @@ Lockdep detects a deadlock by checking lock acquisiti=
on order.  For
> >  example, a graph to track acquisition order built by lockdep might look
> >  like:
> > =20
> > -.. literal::
> > +.. code-block::
> > =20
> >     A -> B -
> >             \
> > @@ -25,7 +25,7 @@ Lockdep keeps adding each new acquisition order into =
the graph at
> >  runtime.  For example, 'E -> C' will be added when the two locks have
> >  been acquired in the order, E and then C.  The graph will look like:
> > =20
> > -.. literal::
> > +.. code-block::
> > =20
> >         A -> B -
> >                 \
> > @@ -41,7 +41,7 @@ been acquired in the order, E and then C.  The graph =
will look like:
> > =20
> >  This graph contains a subgraph that demonstrates a loop like:
> > =20
> > -.. literal::
> > +.. code-block::
> > =20
> >                  -> E -
> >                 /      \
> > @@ -76,7 +76,7 @@ e.g. irq context, normal process context, wq worker c=
ontext, or so on.
> > =20
> >  Can lockdep detect the following deadlock?
> > =20
> > -.. literal::
> > +.. code-block::
> > =20
> >     context X	   context Y	   context Z
> > =20
> > @@ -91,7 +91,7 @@ Can lockdep detect the following deadlock?
> > =20
> >  No.  What about the following?
> > =20
> > -.. literal::
> > +.. code-block::
> > =20
> >     context X		   context Y
> > =20
> > @@ -116,7 +116,7 @@ What leads a deadlock
> >  A deadlock occurs when one or multi contexts are waiting for events th=
at
> >  will never happen.  For example:
> > =20
> > -.. literal::
> > +.. code-block::
> > =20
> >     context X	   context Y	   context Z
> > =20
> > @@ -148,7 +148,7 @@ In terms of dependency:
> > =20
> >  Dependency graph reflecting this example will look like:
> > =20
> > -.. literal::
> > +.. code-block::
> > =20
> >      -> C -> A -> B -
> >     /                \
> > @@ -171,7 +171,7 @@ Introduce DEPT
> >  DEPT(DEPendency Tracker) tracks wait and event instead of lock
> >  acquisition order so as to recognize the following situation:
> > =20
> > -.. literal::
> > +.. code-block::
> > =20
> >     context X	   context Y	   context Z
> > =20
> > @@ -186,7 +186,7 @@ acquisition order so as to recognize the following =
situation:
> >  and builds up a dependency graph at runtime that is similar to lockdep.
> >  The graph might look like:
> > =20
> > -.. literal::
> > +.. code-block::
> > =20
> >      -> C -> A -> B -
> >     /                \
> > @@ -199,7 +199,7 @@ DEPT keeps adding each new dependency into the grap=
h at runtime.  For
> >  example, 'B -> D' will be added when event D occurrence is a
> >  prerequisite to reaching event B like:
> > =20
> > -.. literal::
> > +.. code-block::
> > =20
> >     context W
> > =20
> > @@ -211,7 +211,7 @@ prerequisite to reaching event B like:
> > =20
> >  After the addition, the graph will look like:
> > =20
> > -.. literal::
> > +.. code-block::
> > =20
> >                       -> D
> >                      /
> > @@ -236,7 +236,7 @@ How DEPT works
> >  Let's take a look how DEPT works with the 1st example in the section
> >  'Limitation of lockdep'.
> > =20
> > -.. literal::
> > +.. code-block::
> > =20
> >     context X	   context Y	   context Z
> > =20
> > @@ -256,7 +256,7 @@ event.
> > =20
> >  Adding comments to describe DEPT's view in detail:
> > =20
> > -.. literal::
> > +.. code-block::
> > =20
> >     context X	   context Y	   context Z
> > =20
> > @@ -293,7 +293,7 @@ Adding comments to describe DEPT's view in detail:
> > =20
> >  Let's build up dependency graph with this example.  Firstly, context X:
> > =20
> > -.. literal::
> > +.. code-block::
> > =20
> >     context X
> > =20
> > @@ -304,7 +304,7 @@ Let's build up dependency graph with this example. =
 Firstly, context X:
> > =20
> >  There are no events to create dependency.  Next, context Y:
> > =20
> > -.. literal::
> > +.. code-block::
> > =20
> >     context Y
> > =20
> > @@ -332,7 +332,7 @@ event A cannot be triggered if wait B cannot be awa=
kened by event B.
> >  Therefore, we can say event A depends on event B, say, 'A -> B'.  The
> >  graph will look like after adding the dependency:
> > =20
> > -.. literal::
> > +.. code-block::
> > =20
> >     A -> B
> > =20
> > @@ -340,7 +340,7 @@ graph will look like after adding the dependency:
> > =20
> >  Lastly, context Z:
> > =20
> > -.. literal::
> > +.. code-block::
> > =20
> >     context Z
> > =20
> > @@ -362,7 +362,7 @@ triggered if wait A cannot be awakened by event A. =
 Therefore, we can
> >  say event B depends on event A, say, 'B -> A'.  The graph will look li=
ke
> >  after adding the dependency:
> > =20
> > -.. literal::
> > +.. code-block::
> > =20
> >      -> A -> B -
> >     /           \
> > @@ -386,7 +386,7 @@ Interpret DEPT report
> > =20
> >  The following is the same example in the section 'How DEPT works'.
> > =20
> > -.. literal::
> > +.. code-block::
> > =20
> >     context X	   context Y	   context Z
> > =20
> > @@ -425,7 +425,7 @@ We can simplify this by labeling each waiting point=
 with [W], each
> >  point where its event's context starts with [S] and each event with [E=
].
> >  This example will look like after the labeling:
> > =20
> > -.. literal::
> > +.. code-block::
> > =20
> >     context X	   context Y	   context Z
> > =20
> > @@ -443,7 +443,7 @@ DEPT uses the symbols [W], [S] and [E] in its repor=
t as described above.
> >  The following is an example reported by DEPT for a real problem in
> >  practice.
> > =20
> > -.. literal::
> > +.. code-block::
> > =20
> >     Link: https://lore.kernel.org/lkml/6383cde5-cf4b-facf-6e07-1378a485=
657d@I-love.SAKURA.ne.jp/#t
> >     Link: https://lore.kernel.org/lkml/1674268856-31807-1-git-send-emai=
l-byungchul.park@lge.com/
> > @@ -646,7 +646,7 @@ practice.
> > =20
> >  Let's take a look at the summary that is the most important part.
> > =20
> > -.. literal::
> > +.. code-block::
> > =20
> >     ---------------------------------------------------
> >     summary
> > @@ -669,7 +669,7 @@ Let's take a look at the summary that is the most i=
mportant part.
> > =20
> >  The summary shows the following scenario:
> > =20
> > -.. literal::
> > +.. code-block::
> > =20
> >     context A	   context B	   context ?(unknown)
> > =20
> > @@ -684,7 +684,7 @@ The summary shows the following scenario:
> > =20
> >  Adding comments to describe DEPT's view in detail:
> > =20
> > -.. literal::
> > +.. code-block::
> > =20
> >     context A	   context B	   context ?(unknown)
> > =20
> > @@ -711,7 +711,7 @@ Adding comments to describe DEPT's view in detail:
> > =20
> >  Let's build up dependency graph with this report. Firstly, context A:
> > =20
> > -.. literal::
> > +.. code-block::
> > =20
> >     context A
> > =20
> > @@ -735,7 +735,7 @@ unlock(&ni->ni_lock:0) depends on folio_unlock(&f1)=
, say,
> > =20
> >  The graph will look like after adding the dependency:
> > =20
> > -.. literal::
> > +.. code-block::
> > =20
> >     unlock(&ni->ni_lock:0) -> folio_unlock(&f1)
> > =20
> > @@ -743,7 +743,7 @@ The graph will look like after adding the dependenc=
y:
> > =20
> >  Secondly, context B:
> > =20
> > -.. literal::
> > +.. code-block::
> > =20
> >     context B
> > =20
> > @@ -762,7 +762,7 @@ folio_unlock(&f1) depends on unlock(&ni->ni_lock:0)=
, say,
> > =20
> >  The graph will look like after adding the dependency:
> > =20
> > -.. literal::
> > +.. code-block::
> > =20
> >      -> unlock(&ni->ni_lock:0) -> folio_unlock(&f1) -
> >     /                                                \
> >=20
> > > +Limitation of lockdep
> > > +---------------------
> > > +
> > > +Lockdep deals with a deadlock by typical lock e.g. spinlock and mute=
x,
> > > +that are supposed to be released within the acquisition context.
> > > +However, when it comes to a deadlock by folio lock that is not suppo=
sed
> > > +to be released within the acquisition context or other general
> > > +synchronization mechanisms, lockdep doesn't work.
> > > +
> > > +NOTE:  In this document, 'context' refers to any type of unique cont=
ext
> > > +e.g. irq context, normal process context, wq worker context, or so o=
n.
> > > +
> > > +Can lockdep detect the following deadlock?
> > > +
> > > +.. literal::
> > > +
> > > +   context X	   context Y	   context Z
> > > +
> > > +		   mutex_lock A
> > > +   folio_lock B
> > > +		   folio_lock B <- DEADLOCK
> > > +				   mutex_lock A <- DEADLOCK
> > > +				   folio_unlock B
> > > +		   folio_unlock B
> > > +		   mutex_unlock A
> > > +				   mutex_unlock A
> > > +
> > > +No.  What about the following?
> > > +
> > > +.. literal::
> > > +
> > > +   context X		   context Y
> > > +
> > > +			   mutex_lock A
> > > +   mutex_lock A <- DEADLOCK
> > > +			   wait_for_complete B <- DEADLOCK
> > > +   complete B
> > > +			   mutex_unlock A
> > > +   mutex_unlock A
> > > +
> > > +No.
> >=20
> > One unanswered question from my v17 review [1]: You explain in "How DEP=
T works"
> > section how DEPT detects deadlock in the first example (the former with=
 three
> > contexts). Can you do the same on the second example (the latter with t=
wo
> > contexts)?
>=20
> Did you mean to update the document with it?  I misunderstood what you
> meant but sure I will update it as [1].

Of course!

--=20
An old man doll... just what I always wanted! - Clara

--oXMU5jEQKY7U45cC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaT/PiwAKCRD2uYlJVVFO
o2U6AQDUdKZUTdPI5wclaV+upvJdG2B4MNuJFQ3Ausve1JhRAgD9FqcmmRDdNgTg
fQNwIxnV8dOThdPBY4c1vylRfqTVTQg=
=1ic4
-----END PGP SIGNATURE-----

--oXMU5jEQKY7U45cC--

