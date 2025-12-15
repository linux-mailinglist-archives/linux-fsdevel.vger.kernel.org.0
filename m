Return-Path: <linux-fsdevel+bounces-71286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0E4CBC7AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 05:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 524053012BEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 04:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1568C31BC82;
	Mon, 15 Dec 2025 04:37:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07FA2561AA;
	Mon, 15 Dec 2025 04:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765773477; cv=none; b=ZDZMcinVL5mY5jJUvVqWh4XcOuFHVS1BVg/rNE98R6sWinEA4xLWarvQreraMzSSXO4tze4u63ryIy1Gz4mHNGXuUztX4udde95pmjc5+929nVHDEoKU4wLcOctRK05kSPkI+UGH1kPqFnydj4WKXMO3Ih7lJxAvoP0XtR4UaE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765773477; c=relaxed/simple;
	bh=qqxWqnXhe90QLloQ4PLY9BFWtNYjD+6g4eILkpOK6Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b34CdMjAJ8EUR1YcjnkTIChVA/VngzdMR2syXOxSWdQPfdnMMZKfSO+L3ttFU0AKlpzLbZ6ab5rVal4AXDwpUCqABieCO4LEkKJW89jZ3edawAaSh58UqJoUqXdgAML+7YmtldAEp3x2IP2Ty9fvYUkaf4oe2kQlMqKQ7zQq9W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-7d-693f8d13c060
Date: Mon, 15 Dec 2025 13:22:37 +0900
From: Byungchul Park <byungchul@sk.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
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
Message-ID: <20251215042237.GA49936@system.software.com>
References: <20251205071855.72743-1-byungchul@sk.com>
 <20251205071855.72743-26-byungchul@sk.com>
 <aTN38kJjBftxnjm9@archie.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTN38kJjBftxnjm9@archie.me>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTdxTG97/v1Ha5FBz/SbIs3cgm821Ek5OgsA/Ldr9t0ywhmmXrxp00
	vJmiCCQmlYl2BDJ6M2C21RWUWqGKUgV0NkF0xQ4bCiI2sbSKFUawMWNULLWwVmLml5NfnnOe
	J8+Hw5HKU8w6TlO2X9SWqUtUjIySheXtG9Ma8zVbLk+9D/5giAZzt52BuKmPhVv3ainwnu9C
	EIzoESzGTCTUXVmhIC65WFhxuhDM3ZhH8NTagGD2z88hHPyDBmtomYDQwDEE8ZZi+L3dwUDM
	M0JCa7MXwSVXAIHTVsvAndCbMB55ykB41EyApdZJw+jtOQQnTBKClhM9FIzOvSDA3yIRELRO
	UzDc1E5Ay8UMMLX+RCTG3wRErZ0sWHVZMGUzJgpZysHVNcOCOzBBw9y0xECf7gELC+MPCbA3
	TJOgvxqhoO3oaQqOn/QzcM3ppkAfX0Dg6p8ioOHCZRoC9hUadKZFGsa6vBR0z/gIcBvPUnDf
	8wsLI1fP0dBxb5SAhw98NDg8t0nwGhrpTwqFTkcvIdSNxRnBftKOhNiShIS6pgR1DD9hhKXI
	XUb4qx0Lp39eIgSDZ6NwxTjJCpaeA8KRm2FacNiyhVPXZgmhbT5Cf7l+t2x7oViiqRS1m/O+
	kxU1xZ/Q+37bWdXqNlM6ZM2tRykc5rdicyyKXnH9rRidZIrPwv/M1rFJZvgPsM8XJZOczn+I
	3Y7nCV3GkXzzOzju6nppTuNzscVnIJKs4AGf0Z9DySMlfxjhoRs2anWRit3HQy+Z5LOxb3k2
	YeASnInPLHNJOYVfjyf1q+dr+ffwQO8QkczB/FQKDtd72dWmb+PrNh/VhHjja7HG12KN/8da
	ENmJlJqyylK1pmTrpqLqMk3Vph/KS3tQ4nWth17s6Ufz3l2DiOeQSq7wXsrTKGl1ZUV16SDC
	HKlKV+h9CUlRqK6uEbXl32oPlIgVgyiTo1QZipxnBwuV/F71frFYFPeJ2ldbgktZp0NrMw5u
	u9s9vwF//+PEYmPW+fyz6QbP+J2gnWxeiP4r31yQ/Wzg05FtqUhnLmjNcU5u71/zxQW3vLeo
	uPvdmcdy41vN0qCkfJTac8xUMxC4mVmztyNKq3celnQFO9ZczPv6jZyPJr/xK/RtVTXWXYfY
	3MDY8K+SP+2rkcr8z4b6JgwqqqJI/XE2qa1Q/wdSUvmTtgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xTZxzG877n0kO15qxiPMHFJV2M4qLOqMlfcczb9OgicUqyxX0YjR6l
	4SJpBcXNS8HG6txSGttKCw6ZVMdNKQp22IggRawo9UYjYtVUZgXEC1W5tOxUs8wvb37v8zy/
	5P3wMoR8jIpjVJnbBXWmMl1BS0lpUkL+LPlvX6u+fPIsAfS6vXDfH6DgrraRhNCgnoSi05U0
	hG31EtA7Cim40plHQkd1BQJ/SI/g7YiNAJ1zjISw0S2BwaEuCZi0CMZcbgRmr5EAX8dFAirP
	ajG8PhOhobf5FQLTowANlqCWhAH7YQTWHpsEgi2roN/fQMFY9z8YOt/0IbAHIhgCjQcQhM1p
	8EdpraibX9Aw0n6DAIupA8HxR90EvAo+RHDW/QCB61QeDU8M5wi4FZgAt0MDNLSZfqWh31uE
	4fkZGkryXBR4r/UiKLYZEfTcc2HI//M0DeZiBwnOh39LwNs7iuG+2YihwrEW/PYeEjyGUiw+
	V1zVTAabJR+Lx1MMpqoGDEP2csmSMsS/1f1O8uW1dZjX3QzTfOWxSsSPDBsRP1iWT/A6g3ht
	7hsg+P21O/gyTx/ND4fu0LzrTQnJXy3l+BMHhzFf0D6Ld1q7JeuWbpQu3iykq3IE9ZzEFGmq
	IdxHZR1dv9PSVkTuQ/aEQyiG4dj53KErI1SUSXYa9zKok0SZZqdzPt8QEeVYdgbXVvtOzKUM
	wZqmcmF3BYoWE9kErsRXgKMsY4E7qa9C0ZGc1SKutfkU+aH4hGsrDLxngp3J+SJBUWBEnsKd
	jDDROIaN57r1H+aT2M+5xrpWbEAy60e29SPb+r9dgohyFKvKzMlQqtIXzNakpeZmqnbO3rQt
	w4HEb2nfPVpwHg3eWtWEWAYpxst8DYkqOaXM0eRmNCGOIRSxMr1PjGSblbm7BPW2n9TZ6YKm
	CU1hSMVk2ZrvhRQ5u1W5XUgThCxB/V+LmZi4fYia6pm0wuP/7PhWk/sH97fP93y6fLTKefhC
	/LrCc47vVlYvDNZ512/ItQh/eZ6uRslHq49Mr7+OS3f/3B65nDg8cW/9pWXZG7eoQj/Gxyz5
	oji5a03nwqSO+VkTmmrolMfSAnrl4q+SF81bPffIpdhN4dvxC/offzMw7pcW37QVfE2cS+lU
	kJpU5dyZhFqj/Bcf4v0VkgMAAA==
X-CFilter-Loop: Reflected

On Sat, Dec 06, 2025 at 07:25:22AM +0700, Bagas Sanjaya wrote:
> On Fri, Dec 05, 2025 at 04:18:38PM +0900, Byungchul Park wrote:
> > Add documents describing the concept and APIs of dept.
> > 
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  Documentation/dev-tools/dept.rst     | 778 +++++++++++++++++++++++++++
> >  Documentation/dev-tools/dept_api.rst | 125 +++++
> 
> You forget to add toctree entries:

I'm sorry for late reply.

Thanks a lot!

> ---- >8 ----
> diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
> index 4b8425e348abd1..02c858f5ed1fa2 100644
> --- a/Documentation/dev-tools/index.rst
> +++ b/Documentation/dev-tools/index.rst
> @@ -22,6 +22,8 @@ Documentation/process/debugging/index.rst
>     clang-format
>     coccinelle
>     sparse
> +   dept
> +   dept_api
>     kcov
>     gcov
>     kasan
> 
> > +Lockdep detects a deadlock by checking lock acquisition order.  For
> > +example, a graph to track acquisition order built by lockdep might look
> > +like:
> > +
> > +.. literal::
> > +
> > +   A -> B -
> > +           \
> > +            -> E
> > +           /
> > +   C -> D -
> > +
> > +   where 'A -> B' means that acquisition A is prior to acquisition B
> > +   with A still held.
> 
> Use code-block directive for literal code blocks:

I will.

> ---- >8 ----
> diff --git a/Documentation/dev-tools/dept.rst b/Documentation/dev-tools/dept.rst
> index 333166464543d7..8394c4ea81bc2a 100644
> --- a/Documentation/dev-tools/dept.rst
> +++ b/Documentation/dev-tools/dept.rst
> @@ -10,7 +10,7 @@ Lockdep detects a deadlock by checking lock acquisition order.  For
>  example, a graph to track acquisition order built by lockdep might look
>  like:
>  
> -.. literal::
> +.. code-block::
>  
>     A -> B -
>             \
> @@ -25,7 +25,7 @@ Lockdep keeps adding each new acquisition order into the graph at
>  runtime.  For example, 'E -> C' will be added when the two locks have
>  been acquired in the order, E and then C.  The graph will look like:
>  
> -.. literal::
> +.. code-block::
>  
>         A -> B -
>                 \
> @@ -41,7 +41,7 @@ been acquired in the order, E and then C.  The graph will look like:
>  
>  This graph contains a subgraph that demonstrates a loop like:
>  
> -.. literal::
> +.. code-block::
>  
>                  -> E -
>                 /      \
> @@ -76,7 +76,7 @@ e.g. irq context, normal process context, wq worker context, or so on.
>  
>  Can lockdep detect the following deadlock?
>  
> -.. literal::
> +.. code-block::
>  
>     context X	   context Y	   context Z
>  
> @@ -91,7 +91,7 @@ Can lockdep detect the following deadlock?
>  
>  No.  What about the following?
>  
> -.. literal::
> +.. code-block::
>  
>     context X		   context Y
>  
> @@ -116,7 +116,7 @@ What leads a deadlock
>  A deadlock occurs when one or multi contexts are waiting for events that
>  will never happen.  For example:
>  
> -.. literal::
> +.. code-block::
>  
>     context X	   context Y	   context Z
>  
> @@ -148,7 +148,7 @@ In terms of dependency:
>  
>  Dependency graph reflecting this example will look like:
>  
> -.. literal::
> +.. code-block::
>  
>      -> C -> A -> B -
>     /                \
> @@ -171,7 +171,7 @@ Introduce DEPT
>  DEPT(DEPendency Tracker) tracks wait and event instead of lock
>  acquisition order so as to recognize the following situation:
>  
> -.. literal::
> +.. code-block::
>  
>     context X	   context Y	   context Z
>  
> @@ -186,7 +186,7 @@ acquisition order so as to recognize the following situation:
>  and builds up a dependency graph at runtime that is similar to lockdep.
>  The graph might look like:
>  
> -.. literal::
> +.. code-block::
>  
>      -> C -> A -> B -
>     /                \
> @@ -199,7 +199,7 @@ DEPT keeps adding each new dependency into the graph at runtime.  For
>  example, 'B -> D' will be added when event D occurrence is a
>  prerequisite to reaching event B like:
>  
> -.. literal::
> +.. code-block::
>  
>     context W
>  
> @@ -211,7 +211,7 @@ prerequisite to reaching event B like:
>  
>  After the addition, the graph will look like:
>  
> -.. literal::
> +.. code-block::
>  
>                       -> D
>                      /
> @@ -236,7 +236,7 @@ How DEPT works
>  Let's take a look how DEPT works with the 1st example in the section
>  'Limitation of lockdep'.
>  
> -.. literal::
> +.. code-block::
>  
>     context X	   context Y	   context Z
>  
> @@ -256,7 +256,7 @@ event.
>  
>  Adding comments to describe DEPT's view in detail:
>  
> -.. literal::
> +.. code-block::
>  
>     context X	   context Y	   context Z
>  
> @@ -293,7 +293,7 @@ Adding comments to describe DEPT's view in detail:
>  
>  Let's build up dependency graph with this example.  Firstly, context X:
>  
> -.. literal::
> +.. code-block::
>  
>     context X
>  
> @@ -304,7 +304,7 @@ Let's build up dependency graph with this example.  Firstly, context X:
>  
>  There are no events to create dependency.  Next, context Y:
>  
> -.. literal::
> +.. code-block::
>  
>     context Y
>  
> @@ -332,7 +332,7 @@ event A cannot be triggered if wait B cannot be awakened by event B.
>  Therefore, we can say event A depends on event B, say, 'A -> B'.  The
>  graph will look like after adding the dependency:
>  
> -.. literal::
> +.. code-block::
>  
>     A -> B
>  
> @@ -340,7 +340,7 @@ graph will look like after adding the dependency:
>  
>  Lastly, context Z:
>  
> -.. literal::
> +.. code-block::
>  
>     context Z
>  
> @@ -362,7 +362,7 @@ triggered if wait A cannot be awakened by event A.  Therefore, we can
>  say event B depends on event A, say, 'B -> A'.  The graph will look like
>  after adding the dependency:
>  
> -.. literal::
> +.. code-block::
>  
>      -> A -> B -
>     /           \
> @@ -386,7 +386,7 @@ Interpret DEPT report
>  
>  The following is the same example in the section 'How DEPT works'.
>  
> -.. literal::
> +.. code-block::
>  
>     context X	   context Y	   context Z
>  
> @@ -425,7 +425,7 @@ We can simplify this by labeling each waiting point with [W], each
>  point where its event's context starts with [S] and each event with [E].
>  This example will look like after the labeling:
>  
> -.. literal::
> +.. code-block::
>  
>     context X	   context Y	   context Z
>  
> @@ -443,7 +443,7 @@ DEPT uses the symbols [W], [S] and [E] in its report as described above.
>  The following is an example reported by DEPT for a real problem in
>  practice.
>  
> -.. literal::
> +.. code-block::
>  
>     Link: https://lore.kernel.org/lkml/6383cde5-cf4b-facf-6e07-1378a485657d@I-love.SAKURA.ne.jp/#t
>     Link: https://lore.kernel.org/lkml/1674268856-31807-1-git-send-email-byungchul.park@lge.com/
> @@ -646,7 +646,7 @@ practice.
>  
>  Let's take a look at the summary that is the most important part.
>  
> -.. literal::
> +.. code-block::
>  
>     ---------------------------------------------------
>     summary
> @@ -669,7 +669,7 @@ Let's take a look at the summary that is the most important part.
>  
>  The summary shows the following scenario:
>  
> -.. literal::
> +.. code-block::
>  
>     context A	   context B	   context ?(unknown)
>  
> @@ -684,7 +684,7 @@ The summary shows the following scenario:
>  
>  Adding comments to describe DEPT's view in detail:
>  
> -.. literal::
> +.. code-block::
>  
>     context A	   context B	   context ?(unknown)
>  
> @@ -711,7 +711,7 @@ Adding comments to describe DEPT's view in detail:
>  
>  Let's build up dependency graph with this report. Firstly, context A:
>  
> -.. literal::
> +.. code-block::
>  
>     context A
>  
> @@ -735,7 +735,7 @@ unlock(&ni->ni_lock:0) depends on folio_unlock(&f1), say,
>  
>  The graph will look like after adding the dependency:
>  
> -.. literal::
> +.. code-block::
>  
>     unlock(&ni->ni_lock:0) -> folio_unlock(&f1)
>  
> @@ -743,7 +743,7 @@ The graph will look like after adding the dependency:
>  
>  Secondly, context B:
>  
> -.. literal::
> +.. code-block::
>  
>     context B
>  
> @@ -762,7 +762,7 @@ folio_unlock(&f1) depends on unlock(&ni->ni_lock:0), say,
>  
>  The graph will look like after adding the dependency:
>  
> -.. literal::
> +.. code-block::
>  
>      -> unlock(&ni->ni_lock:0) -> folio_unlock(&f1) -
>     /                                                \
> 
> > +Limitation of lockdep
> > +---------------------
> > +
> > +Lockdep deals with a deadlock by typical lock e.g. spinlock and mutex,
> > +that are supposed to be released within the acquisition context.
> > +However, when it comes to a deadlock by folio lock that is not supposed
> > +to be released within the acquisition context or other general
> > +synchronization mechanisms, lockdep doesn't work.
> > +
> > +NOTE:  In this document, 'context' refers to any type of unique context
> > +e.g. irq context, normal process context, wq worker context, or so on.
> > +
> > +Can lockdep detect the following deadlock?
> > +
> > +.. literal::
> > +
> > +   context X	   context Y	   context Z
> > +
> > +		   mutex_lock A
> > +   folio_lock B
> > +		   folio_lock B <- DEADLOCK
> > +				   mutex_lock A <- DEADLOCK
> > +				   folio_unlock B
> > +		   folio_unlock B
> > +		   mutex_unlock A
> > +				   mutex_unlock A
> > +
> > +No.  What about the following?
> > +
> > +.. literal::
> > +
> > +   context X		   context Y
> > +
> > +			   mutex_lock A
> > +   mutex_lock A <- DEADLOCK
> > +			   wait_for_complete B <- DEADLOCK
> > +   complete B
> > +			   mutex_unlock A
> > +   mutex_unlock A
> > +
> > +No.
> 
> One unanswered question from my v17 review [1]: You explain in "How DEPT works"
> section how DEPT detects deadlock in the first example (the former with three
> contexts). Can you do the same on the second example (the latter with two
> contexts)?

Did you mean to update the document with it?  I misunderstood what you
meant but sure I will update it as [1].

[1] https://lore.kernel.org/linux-doc/20251013012855.GB52546@system.software.com/

Thanks.

	Byungchul

> Thanks.
> 
> [1]: https://lore.kernel.org/linux-doc/aN84jKyrE1BumpLj@archie.me/
> 
> -- 
> An old man doll... just what I always wanted! - Clara



