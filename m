Return-Path: <linux-fsdevel+bounces-74909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNUuH+49cWnKfQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 21:58:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3626E5DB4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 21:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5EDDC7C8A0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 19:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33D43B95E1;
	Wed, 21 Jan 2026 19:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NpsExNBu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9632C08AB;
	Wed, 21 Jan 2026 19:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769024621; cv=none; b=MArAIdV3IqH2x55hGd6oKl8KotUvKF10VuuDN/CsQNPnWMkQiB1aWRxqakhVgdHFs5iWeuL9KXmvOeiBrb8RVznC7Yuj+BMy/qPu+6h7YiM+Mj8k88TKoVOI8/x9sj+VnUfLiEJquWkJ6sI21OMiM6ql+MrsQ6DBgiW3ffcROWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769024621; c=relaxed/simple;
	bh=WNtkf6/W+a8tRyxaDZhIX9sWX7TczseGjxUye2O8yOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqEitUdhJ2YBxBJ5Sn9yexF98AKUS56GDWVhgEpOjzRLANrlLC5PFY9auDtqThu6pxm+2qjVBepMsCIpMlVHrKkvxV5mhnW1xPT3mzvQNBkHfdwn/rCjjGfkCauHCrUJANNqGZkEWk1t0mGnCAm/kttH0DQ1Ndkvu1kjGErc4co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NpsExNBu; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HMG8k455f7tE91ouMSuYF+NGd0zzTpmcJ48fETxJSJI=; b=NpsExNBulsnwMrThqHDHUx0czG
	YlhBvEj0qncI88W+pJ4aQIhb1DN5Os5we1y6Mc1L7JMnL2qAAvnxJ5FuPYOSMvwSuggBVNn8A59WJ
	Bd4OycZSIYdHUWqlJ9ZhAtcssffMs8qto++axD0tsBDEw0AE0CXYAevsOicaOFZax3CzpsSQT4MfC
	O+6Tmu4N6IP1U+u7s/oZJktzE5UlF27XqMxejl2iqzTzbhZNiEnhHgF2NcZS2yjfsDvjOqv5xikjl
	mjqEocw/8tZk/ZHrq8w1en9o8OQJwQl79lcnIEO/eSj8hN1MZSOqNvBFBjd2QNUE5wVYH1Gt+P+Cy
	xCcQd71Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vie74-0000000GiYM-43HW;
	Wed, 21 Jan 2026 19:43:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 05694300328; Wed, 21 Jan 2026 20:43:34 +0100 (CET)
Date: Wed, 21 Jan 2026 20:43:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Remi Pommarel <repk@triplefau.lt>
Cc: Ingo Molnar <mingo@redhat.com>, v9fs@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] wait: Introduce io_wait_event_killable()
Message-ID: <20260121194333.GO166857@noisy.programming.kicks-ass.net>
References: <cover.1769009696.git.repk@triplefau.lt>
 <1b2870001ecd34fe6c05be2ddfefb3c798b11701.1769009696.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b2870001ecd34fe6c05be2ddfefb3c798b11701.1769009696.git.repk@triplefau.lt>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[infradead.org,none];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74909-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noisy.programming.kicks-ass.net:mid,triplefau.lt:email,infradead.org:email,infradead.org:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 3626E5DB4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 08:21:58PM +0100, Remi Pommarel wrote:
> Add io_wait_event_killable(), a variant of wait_event_killable() that
> uses io_schedule() instead of schedule(). This is to be used in
> situation where waiting time is to be accounted as IO wait time.
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  include/linux/wait.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index f648044466d5..dce055e6add3 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -937,6 +937,21 @@ extern int do_wait_intr_irq(wait_queue_head_t *, wait_queue_entry_t *);
>  	__ret;									\
>  })
>  
> +#define __io_wait_event_killable(wq, condition)					\
> +	___wait_event(wq, condition, TASK_KILLABLE, 0, 0, io_schedule())
> +
> +/*
> + * wait_event_killable() - link wait_event_killable but with io_schedule()
> + */
> +#define io_wait_event_killable(wq_head, condition)				\
> +({										\
> +	int __ret = 0;								\
> +	might_sleep();								\
> +	if (!(condition))							\
> +		__ret = __io_wait_event_killable(wq_head, condition);		\
> +	__ret;									\
> +})
> +
>  #define __wait_event_state(wq, condition, state)				\
>  	___wait_event(wq, condition, state, 0, 0, schedule())
>  
> -- 
> 2.50.1
> 

