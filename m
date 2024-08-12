Return-Path: <linux-fsdevel+bounces-25725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A26594FA20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 01:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FB1C28287F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 23:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AE519AD48;
	Mon, 12 Aug 2024 23:04:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D5F14D28F;
	Mon, 12 Aug 2024 23:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723503842; cv=none; b=dMbnKKC1Wa2co67bCqNU/GygTfh4zlljHvFApSTnHdkGd4otggKxZbGtz4scyJEPMoKX0LdLey+Rcgxb4fLaFF4LWgTWnv5MttbBt7nNJc3NQ1n5uMY8F7ZWQ6AL2LjjUVC5gL0h1YvxaIfkP1x14+jMfAE6zSdodCcDi76kPz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723503842; c=relaxed/simple;
	bh=ds6XhzAxTvpBuKXG5ylnye1N6tiRlGk42WCdUlS7Wyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrWJHVJUPs4pMaUxcaOVp8vI7AUfdbV2dP3SIeZeB6rF+zUdwhIPFGsyyvW3aAPiujti4+xf3CMNIO/EOLmSbfWvJfIo0RZYk0gt7q21FQQVg7kvgIjsPD+ZPRr7wvDIzGwX72IqhVCvEhgkP0s6wKuSBsbwxROLK0YHnsq8fZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d23caf8ddso4424147b3a.0;
        Mon, 12 Aug 2024 16:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723503840; x=1724108640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMPNmqSprQ9BGPKYJ0Av2N0L3vCPc9pHL4KvpAQBBLU=;
        b=IrGwL5MTUyhc6VIICFQzHuoBPBcJhIIADYwpxLTTbDP4LV8apyPDQMW76FcoOj/8ba
         YWX54xNWlQczLpaTphxE+zJp8mgEiDB9H5jo9toBlF3+sAhyZXM48rvSOquJT6UbmvJU
         rp9MDqbvJvx85Te6AJsdw1aw979mwxARoOTcT8tIwuBKcKXoCgricRQNswNgwhct0fri
         meUKIoRH2V6me0KRxY1PO/B1EWkmSPXAOkv70A/tfLWG4qMeHofSfE4mum6LEcZCwilP
         MefC+ZdgivjGMqSKLBXjRvnTUnR0izWiT3T1V5BprQhZGWh78W7h1Qh56KpL0mmqk4+l
         7jRw==
X-Forwarded-Encrypted: i=1; AJvYcCWZO0JdZImj0nOJkMZzHh/0RzCH67bb3mEB3Lw95p891sKI+zjVyHRrOVyGlPUTZRh5Js2AOP3aW1qJGoaLN1QmEoqZZv/d33O/1VLeALd3n9B+6vrBuRpS1g6ajevL2xpoMhDQ0yJW+nSXvhdla8xDGP3paoyfJ+QTNrdnAuiAHtGWWJ4IMg==
X-Gm-Message-State: AOJu0YwF4G2iznPhBtxEz9jhHFtuJQWLY1WONJwJUIb6ozkoQsBptXhf
	Bj3jxlunhrgIX4pWD0BwessoBz7DQP5RQbnkhxy62OwOq8m9kkc=
X-Google-Smtp-Source: AGHT+IGT7B592X3aZghDBftVvGia/mFsMB5B5+0hXM6/dxPfRUn5SPge6WimDhuUYM2WEBButJx9uQ==
X-Received: by 2002:a05:6a21:8cc4:b0:1c4:d0d9:50aa with SMTP id adf61e73a8af0-1c8d74916c7mr2334155637.20.1723503839504;
        Mon, 12 Aug 2024 16:03:59 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c697a549d8sm164253a12.67.2024.08.12.16.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 16:03:59 -0700 (PDT)
Date: Mon, 12 Aug 2024 16:03:58 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Martin Karsten <mkarsten@uwaterloo.ca>
Cc: netdev@vger.kernel.org, Joe Damato <jdamato@fastly.com>,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC net-next 0/5] Suspend IRQs during preferred busy poll
Message-ID: <ZrqU3kYgL4-OI-qj@mini-arch>
References: <20240812125717.413108-1-jdamato@fastly.com>
 <ZrpuWMoXHxzPvvhL@mini-arch>
 <2bb121dd-3dcd-4142-ab87-02ccf4afd469@uwaterloo.ca>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2bb121dd-3dcd-4142-ab87-02ccf4afd469@uwaterloo.ca>

On 08/12, Martin Karsten wrote:
> On 2024-08-12 16:19, Stanislav Fomichev wrote:
> > On 08/12, Joe Damato wrote:
> > > Greetings:
> > > 
> > > Martin Karsten (CC'd) and I have been collaborating on some ideas about
> > > ways of reducing tail latency when using epoll-based busy poll and we'd
> > > love to get feedback from the list on the code in this series. This is
> > > the idea I mentioned at netdev conf, for those who were there. Barring
> > > any major issues, we hope to submit this officially shortly after RFC.
> > > 
> > > The basic idea for suspending IRQs in this manner was described in an
> > > earlier paper presented at Sigmetrics 2024 [1].
> > 
> > Let me explicitly call out the paper. Very nice analysis!
> 
> Thank you!
> 
> [snip]
> 
> > > Here's how it is intended to work:
> > >    - An administrator sets the existing sysfs parameters for
> > >      defer_hard_irqs and gro_flush_timeout to enable IRQ deferral.
> > > 
> > >    - An administrator sets the new sysfs parameter irq_suspend_timeout
> > >      to a larger value than gro-timeout to enable IRQ suspension.
> > 
> > Can you expand more on what's the problem with the existing gro_flush_timeout?
> > Is it defer_hard_irqs_count? Or you want a separate timeout only for the
> > perfer_busy_poll case(why?)? Because looking at the first two patches,
> > you essentially replace all usages of gro_flush_timeout with a new variable
> > and I don't see how it helps.
> 
> gro-flush-timeout (in combination with defer-hard-irqs) is the default irq
> deferral mechanism and as such, always active when configured. Its static
> periodic softirq processing leads to a situation where:
> 
> - A long gro-flush-timeout causes high latencies when load is sufficiently
> below capacity, or
> 
> - a short gro-flush-timeout causes overhead when softirq execution
> asynchronously competes with application processing at high load.
> 
> The shortcomings of this are documented (to some extent) by our experiments.
> See defer20 working well at low load, but having problems at high load,
> while defer200 having higher latency at low load.
> 
> irq-suspend-timeout is only active when an application uses
> prefer-busy-polling and in that case, produces a nice alternating pattern of
> application processing and networking processing (similar to what we
> describe in the paper). This then works well with both low and high load.

So you only want it for the prefer-busy-pollingc case, makes sense. I was
a bit confused by the difference between defer200 and suspend200,
but now I see that defer200 does not enable busypoll.

I'm assuming that if you enable busypool in defer200 case, the numbers
should be similar to suspend200 (ignoring potentially affecting
non-busypolling queues due to higher gro_flush_timeout).

> > Maybe expand more on what code paths are we trying to improve? Existing
> > busy polling code is not super readable, so would be nice to simplify
> > it a bit in the process (if possible) instead of adding one more tunable.
> 
> There are essentially three possible loops for network processing:
> 
> 1) hardirq -> softirq -> napi poll; this is the baseline functionality
> 
> 2) timer -> softirq -> napi poll; this is deferred irq processing scheme
> with the shortcomings described above
> 
> 3) epoll -> busy-poll -> napi poll
> 
> If a system is configured for 1), not much can be done, as it is difficult
> to interject anything into this loop without adding state and side effects.
> This is what we tried for the paper, but it ended up being a hack.
> 
> If however the system is configured for irq deferral, Loops 2) and 3)
> "wrestle" with each other for control. Injecting the larger
> irq-suspend-timeout for 'timer' in Loop 2) essentially tilts this in favour
> of Loop 3) and creates the nice pattern describe above.

And you hit (2) when the epoll goes to sleep and/or when the userspace
isn't fast enough to keep up with the timer, presumably? I wonder
if need to use this opportunity and do proper API as Joe hints in the
cover letter. Something over netlink to say "I'm gonna busy-poll on
this queue / napi_id and with this timeout". And then we can essentially make
gro_flush_timeout per queue (and avoid
napi_resume_irqs/napi_suspend_irqs). Existing gro_flush_timeout feels
too hacky already :-(

> [snip]
> 
> > >    - suspendX:
> > >      - set defer_hard_irqs to 100
> > >      - set gro_flush_timeout to X,000
> > >      - set irq_suspend_timeout to 20,000,000
> > >      - enable busy poll via the existing ioctl (busy_poll_usecs = 0,
> > >        busy_poll_budget = 64, prefer_busy_poll = true)
> > 
> > What's the intention of `busy_poll_usecs = 0` here? Presumably we fallback
> > to busy_poll sysctl value?
> 
> Before this patch set, ep_poll only calls napi_busy_poll, if busy_poll
> (sysctl) or busy_poll_usecs is nonzero. However, this might lead to
> busy-polling even when the application does not actually need or want it.
> Only one iteration through the busy loop is needed to make the new scheme
> work. Additional napi busy polling over and above is optional.

Ack, thanks, was trying to understand why not stay with
busy_poll_usecs=64 for consistency. But I guess you were just
trying to show that patch 4/5 works.

