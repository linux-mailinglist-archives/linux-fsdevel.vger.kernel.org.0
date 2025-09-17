Return-Path: <linux-fsdevel+bounces-61935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F86B7F88F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4945C3BCF12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 13:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71833333AA7;
	Wed, 17 Sep 2025 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cXn5m+wJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MIdBY3Z1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C890D33594B;
	Wed, 17 Sep 2025 13:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116518; cv=none; b=M+RpSGFCSTZ7h0v7CLAgP80o6HumG37YOk9frTtmcGId7HnLRCZqBHbaHlzRISMwKElpI+2QF3eswPDYkcqYGkUvNrJOKM3KHhoLXMQs95UKQJZ6y7Y45Q+J+Zn7PlabhAHEGCRaNS5FV6R35Xp3T2DPb/MLRe+28DcMxC83Y/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116518; c=relaxed/simple;
	bh=eAM7emcnF0+KyTwHDruGIDalO4MkhIrArjiMVGnxXd8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C9RH/ShvZuhZtrRz21Bih5LVKI7pcOPjO7EhI5HtlpTwY4LNxKDtCi9edrolfgJEEKHI8nVFaSgyA2ZyCT1VroHhqwpkaetuqRIbG/pCki+weLH12/mw6p9pWFtqUEoIm8mICLo1kdarvayTYWRt44SaJ567ykX53u+dIuWJ9Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cXn5m+wJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MIdBY3Z1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758116513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eAM7emcnF0+KyTwHDruGIDalO4MkhIrArjiMVGnxXd8=;
	b=cXn5m+wJdSnDJcufV3fK/n5bCG13Z0iLUJXoStYyxkW9w1euLJ6/Xr6DlWUpMOH11+WXWo
	tTVxGBkkef4Nf9gcjecTrrU+427mz6qL/iGJ56qjJkJScNSOSOtq+iLzf/GefzsXuGq5se
	CZE0TaoHSTcK1lIq4tGJGoh/0flh6neP1TQq6nCdZkd5gK2v8RggwHP8b7OqEHiiZ6oay5
	ovUFq7F60GNjkSAWl0pi//aJ7yqxGrSlwgXuVxuTXjqvLEBxBGYmG7xlVS0wuicWVuhW7S
	XmAJXYQNaMPz8iuaphUpZrhrMfdYkF4e2dUM+cb7lTCz09k54u7EpB6eAF4+oQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758116513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eAM7emcnF0+KyTwHDruGIDalO4MkhIrArjiMVGnxXd8=;
	b=MIdBY3Z1wIvhd4Xt2SRaWEpUMvEK+HhdABZClqhIvz548Y1F9LEFAA9AjvjNwdfDYvSP8f
	+9OanZ/JfH/rlbDQ==
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan
 <shuah@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Soheil Hassas
 Yeganeh <soheil@google.com>, Khazhismel Kumykov <khazhy@google.com>,
 Willem de Bruijn <willemb@google.com>, Eric Dumazet <edumazet@google.com>,
 Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
In-Reply-To: <aflo53gea7i6cyy22avn7mqxb3xboakgjwnmj4bqmjp6oafejj@owgv35lly7zq>
References: <cover.1752824628.git.namcao@linutronix.de>
 <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
 <aflo53gea7i6cyy22avn7mqxb3xboakgjwnmj4bqmjp6oafejj@owgv35lly7zq>
Date: Wed, 17 Sep 2025 15:41:52 +0200
Message-ID: <87zfat19i7.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mateusz Guzik <mjguzik@gmail.com> writes:
> I'll say upfront I'm not an epoll person, just looked here out of
> curiosity.

Feedbacks always welcomed.

> I can agree there is a bug. The event is generated before any of the
> threads even exist and they only poll for it, none of them consume it.
>
> However, the commit message fails to explain why the change fixes
> anything and I think your patch de facto reverts e59d3c64cba6 ("epoll:
> eliminate unnecessary lock for zero timeout"). Looking at that diff
> the point was to avoid the expensive lock trip if timeout == 0 and there
> are no events.
>
> As for the bug is, from my reading the ep_start_scan()/ep_done_scan()
> pair transiently disturbs the state checked by ep_events_available(),
> resulting in false-negatives. Then the locked check works because by the
> time you acquire it, the damage is undone.

Exactly so. I can add this into the description.

> Given the commits referenced in Fixes:, I suspect the real fix would be
> to stop destroying that state of course.
>
> But if that's not feasible, I would check if a sequence counter around
> this would do the trick -- then the racy ep_events_available(ep) upfront
> would become safe with smaller overhead than with your proposal for the
> no-event case, but with higher overhead when there is something.
>
> My proposal is trivial to implement, I have no idea if it will get a
> buy-in though.

My question is whether the performance of epoll_wait() with zero
timeout is really that important that we have to complicate
things. If epoll_wait() with zero timeout is called repeatedly in a loop
but there is no event, I'm sure there will be measurabled performance
drop. But sane user would just use timeout in that case.

epoll's data is protected by a lock. Therefore I think the most
straightforward solution is just taking the lock before reading the
data.

Lockless is hard to get right and may cause hard-to-debug problems. So
unless this performance drop somehow bothers someone, I would prefer
"keep it simple, stupid".

Best regards,
Nam

