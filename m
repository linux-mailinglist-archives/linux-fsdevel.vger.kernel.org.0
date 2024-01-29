Return-Path: <linux-fsdevel+bounces-9293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 258FB83FD30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 05:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B39BEB21EB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 04:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7EE22F0F;
	Mon, 29 Jan 2024 04:21:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8942314AAA;
	Mon, 29 Jan 2024 04:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706502074; cv=none; b=O21hvGkGh1AC0260mqyRrWj7y0+UFS2YTL1xAZ+lX/6BxJD5iJ2/QpApfQR29oOzC27ms7T9VHKCk2wjfD8tKvwEmKlNyRTBqcF8VkzfrAogX+KkipSqrJBhuJ3gCwjP6nKN0Bx5Sjf2jAsRgZ8s1HbWT4C5TNF0kdNz1vnfHpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706502074; c=relaxed/simple;
	bh=p9WW5tw9S4aGXrjQWbwDneSN3suFm+njtOg9nHFdRRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkFQriJ8vTZDCUn5pPIfGKeDFJpmi8iUvxnlPHKY+ptx0TblM4sek4qQyFo9kvw1Nwk/az7EQ2cGMp8RmmHvWYFooKLOwusi8gABeXiLMmD28UZ8AZw6TYPFzNnukMNE/JTy5HrFz19HpjHJdfaL2Sy/sZVjXIPrsXeuxnbFplE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-0b-65b727aa4de6
Date: Mon, 29 Jan 2024 13:20:52 +0900
From: Byungchul Park <byungchul@sk.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
	will@kernel.org, rostedt@goodmis.org, joel@joelfernandes.org,
	sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
	johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
	willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
	gregkh@linuxfoundation.org, kernel-team@lge.com, linux-mm@kvack.org,
	akpm@linux-foundation.org, mhocko@kernel.org, minchan@kernel.org,
	hannes@cmpxchg.org, vdavydov.dev@gmail.com, sj@kernel.org,
	jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
	penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
	ngupta@vflare.org, linux-block@vger.kernel.org,
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org,
	dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
	dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com, hamohammed.sa@gmail.com, 42.hyeyoo@gmail.com,
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com, boqun.feng@gmail.com,
	longman@redhat.com, hdanton@sina.com, her0gyugyu@gmail.com
Subject: Re: [PATCH v11 14/26] locking/lockdep, cpu/hotplus: Use a weaker
 annotation in AP thread
Message-ID: <20240129042052.GA64402@system.software.com>
References: <20240124115938.80132-1-byungchul@sk.com>
 <20240124115938.80132-15-byungchul@sk.com>
 <87il3ggfz9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87il3ggfz9.ffs@tglx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA03SX0xTVxzAcc+5f9vQ5a5DPZOXpcbgMPh/22/L5pa9eJOFzW08aTZt5EYa
	StWLouhcYFZT/k6IUK3oSjGlgW6OwhwT0QKBUv9Ah9UhAgo2bo1UMmabVbAbF7LMl5NPzvmd
	b87D4SntLLOMN5j2SbJJb9SxalodSapLb0z9WVrbMr4SKsvWQvSphYbaC24WAj80IXC3FmEI
	92yG32KTCGZuDlBgrQ4gqBsfpaC1dwxBh+sbFm6FXoJgdIoFf3UpC0frL7Dw6+NZDCM1VRia
	PBlw/YQDgzf+Ow3WMAtnrEfx3PIHhrizkQNn4QqYcNk4mB1fB/6xOwx0DK+C0+dGWLjc4aeh
	t20Cw61LtSyMuf9h4HpvHw2BynIGvn/iYOFxzEmBMzrFwaDXjuFH81zo+F8JBnzlXgzHzzdj
	CN5tR3DF8gCDx32Hhe7oJIYWTzUFzxp6EExURDg4Vhbn4ExRBYLSYzU0DDz3MWAeeQNm/q5l
	P3hH7J6cokRzywGxI2anxWsOIv5iG+VE85VhTrR79ostrjSx/nIYi3XTUUb0NBazome6ihNL
	IkEsPunv58S+UzO0GApa8ZaUrep3sySjIV+S12zaoc4ebTuF99QkHYzcDqFCdFVVgnieCBtJ
	xPlxCVLN09vvQoppYQUZae2cNyukkqGhOKU4WVhJmgeH500JfjUJOD5U/Iqwk9x92MkoSY0A
	xOrLVKgVDpHWksXKhEZ4mfhPh+iFm2lkKBHGygglpJCGBK9sqwQdqbKYWcWLheXEe9GHFx7W
	riIDz0wLfpV0uoboE0iwvVC1vVC1/V+1I6oRaQ2m/Fy9wbhxdXaByXBw9c7duR409yedR2a3
	taHpwOddSOCRLknDF12UtIw+P68gtwsRntIla+Kv/yRpNVn6gkOSvHu7vN8o5XWhFJ7WLdWs
	jx3I0gq79PukHEnaI8n/nWJetawQHb6d3rPtfqL+0aL0tyvvGbvf6jp5OHeD6VPHDcvZDHZ9
	7CvQrwrLDU1b5GtrzpJ7qVtd34W2lz088tqfJ89TXyY+SmTuHXMXZ/LqtD5fOZ/y9dPS9h0V
	S5ds+uwTO725UkwO5uieNz/a0GB5kOH9dtKUfen+8pzim4NfvBnf+7686L0+HZ2XrV+XRsl5
	+n8BEUqc/48DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0yTZxTH8zzvtQ0lrxXYo/ipTkG8YaLLibhF/aDv3OZGojFRozT6Co2A
	rkUUExIYlSCoERKoVsZqWQqpKFAK4gWsEKnVCAgMCgGErskkXOrUEisXpS6Lfjn55Zz/73z6
	85RyhFnKa1LTJG2qOlnFymn57rictdao21LsG4sMCi/Egv9tHg2l1VUsdN66gaDKno1h7NFO
	6JueQDDzrIMCQ3EnguujQxTY24YRNFX+xkK3NxR6/D4WXMUFLOSUV7PwfHwWw2BJEYYbtp/g
	6WUzBkfgHxoMYyxcM+TghfESQ8Bi5cCStQI8lUYOZkc3gGu4l4HW310MNA2shqtlgyzcb3LR
	0NbowdB9t5SF4aoPDDxte0xDZ+FFBm5OmVkYn7ZQYPH7OOhymDDU6Be+5b6ZZ8B50YEh989a
	DD399xA0541gsFX1stDqn8BQZyum4H3FIwSeS5McnLsQ4OBa9iUEBedKaOiYczKgH9wEM+9K
	2a1xYuuEjxL1dafFpmkTLT4xE/GOcYgT9c0DnGiynRLrKmPE8vtjWLz+2s+INut5VrS9LuLE
	/MkeLE61t3Pi4ysztOjtMeBflu2XbzkqJWvSJe367xLkSUONV/DJkpAzk395URZ6IMtHMp4I
	G4mjvRIFmRZWkEH7w0/MClHE7Q5QQQ4Toklt18AnpgSXnHSatwd5sXCE9P/9kMlHPK8QgBic
	e4KoFM4Se354MKEQFhHXVS/9nxlD3PNjOBihhEhSMc8H1zJBRYry9GyQw4XlxNHgxJeRwviF
	bfzCNn62TYiyojBNanqKWpO8aZ3ueFJGqubMuiMnUmxooXeWzNnCRvS2e2cLEnikClHw2Q2S
	klGn6zJSWhDhKVWYIrCqXlIqjqozzkraE4e1p5IlXQuK5GnVV4pd+6QEpZCoTpOOS9JJSfv/
	FfOypVloZKo36vupkPXfeGIjVptDk0aWGH/enrtSxTpNZfrMgh3NOS1r+m/nJe4vT9y1dWOM
	sa/NF+F17/3aExh99e2vpbM/krK4FxQ3PncgdN/40Olw/qD935cHK87X/LDZF71neeSh+giT
	fnrzIqPc3Vf3R/zetDlr5q2MgdoXo8fiNQnblqhoXZJ6Qwyl1ak/AnGPtF9zAwAA
X-CFilter-Loop: Reflected

On Fri, Jan 26, 2024 at 06:30:02PM +0100, Thomas Gleixner wrote:
> On Wed, Jan 24 2024 at 20:59, Byungchul Park wrote:
> 
> Why is lockdep in the subsystem prefix here? You are changing the CPU
> hotplug (not hotplus) code, right?

I will fix the typo ;( Thank you.

I referred to the commit cb92173d1f047. I will remove the prefix if the
way is more desirable.

> > cb92173d1f0 ("locking/lockdep, cpu/hotplug: Annotate AP thread") was
> > introduced to make lockdep_assert_cpus_held() work in AP thread.
> >
> > However, the annotation is too strong for that purpose. We don't have to
> > use more than try lock annotation for that.
> 
> This lacks a proper explanation why this is too strong.

rwsem_acquire() implies:

   1. might be a waiter on contention of the lock.
   2. enter to the critical section of the lock.

All we need in here is to act 2, not 1. That's why I suggested trylock
version of annotation for that purpose.

Now that dept partially replies on lockdep annotaions for the waiters
and events, dept is interpeting rwsem_acquire() as a potential waiter
and reports a deadlock by the wait.

Of course, the first priority should be not to change the current
behavior. I think the change from non-trylock to trylock for the
annotation won't. Or am I missing something?

	Byungchul

> > Furthermore, now that Dept was introduced, false positive alarms was
> > reported by that. Replaced it with try lock annotation.
> 
> I still have zero idea what this is about.
> 
> Thanks,
> 
>         tglx

