Return-Path: <linux-fsdevel+bounces-25758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A0394FC8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 06:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B38032834E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 04:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F471CD1F;
	Tue, 13 Aug 2024 04:07:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095071CAA6;
	Tue, 13 Aug 2024 04:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723522040; cv=none; b=E/Jhbw9ZYsyrBwSs7smuzYi4iUggxl6RRNib+mVIqFqqB4pNiJvEjb0FoxPg02dKZX9CUS1OysKla+U5BDZrkeYHYUTRvEsNMmE4W8pDtTxfeW3x9+nlFAC2MsHLQem9GG8/WdQw8AKXM9avvTJyVUbTiUJ5S34bcxvpBjOuByk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723522040; c=relaxed/simple;
	bh=wduxGjkaQBkHndHQ4+MxkGTh593eBdYKEJfri6mqeRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNVcrlxaQKgkurJXT3sZUAm/jnwYT1ZzK21k20lJ/h+hhNPQLxADcfTPKm88QarWR7TL3WjaVR84V0XTTRXg6ueEP6aW0G4PlIhz07qaZKrjTcRYBAThjEPin9Iq/Ja1Hyoqb7dKkgXD8rbVfKuKATD15QDP2l9h1376ocFOrr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d1d6369acso4072847b3a.0;
        Mon, 12 Aug 2024 21:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723522037; x=1724126837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZSIFrHXFl/CMttBH8Bjgfh4zzvoz4mEhSiua6DUcew=;
        b=WGdxYN77jOD5zaBPq1hI+ZowoUgSH66sOL7vIVH6qp+gCExfZ7DT3hz33BfadQyZBQ
         am/dvx+bLWwGgt4Lh8PrfKWXEAx2X8BjEAJdNu24bLUtuPTGYZFBr9S0glDDfacFd7Ps
         aM4ULiT3ENopHge0yxc17LSQEYl5oh1ROj2jOG+F6uJMmDQk7JIMfWvLQMx8ovroDwH2
         oODw0zb4BBtrGgd+w88cbSaJBarpU3w7SCr+YVevFwxHBQGaaRTO55IZ0b6wn+FpCHzO
         wPbh0B4N35nqJMq5rE5wI1DoAidyVKPUs0YdNr14m80mYHb5ncy+M6xNqUBfVdy/a4UF
         I5rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiUQ3uX8eiQMf/8ZTvEqib55PfOw54OKA3/ZNGoW2kZnTm1oYmhQ5rVAFnKmWsg8xbyGVKn/jNeF1SL+XOvrGoFgg44JmPsJPk2/DmmVnf0Sp9WxD0hQ/H1wyhS5WbMxkl+I/vAYGXp2TgXBgqQh3+s13mtzMdfXuOygJnE6cWGh0HutWucw==
X-Gm-Message-State: AOJu0YyBR9Gjqlw8PfXthc6tiCkACiU5mrvwPb+WgjtHDl8U2vPdWEkd
	QADAIRJ5YinHLfbbW2q7aS07E8Wr5HBlTP6o+tIT0PAhc2Gb8k8=
X-Google-Smtp-Source: AGHT+IFFflwlZ19WfFa+AEhg9VCTnQe30R9NKm0lHmyXm6lxFruzj38JW4Y7jOVZVGJM9f3hzAaGFg==
X-Received: by 2002:a17:902:db10:b0:1fb:4f57:6a65 with SMTP id d9443c01a7336-201cbc923eemr21957205ad.30.1723522037021;
        Mon, 12 Aug 2024 21:07:17 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1b82bfsm4218065ad.210.2024.08.12.21.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 21:07:16 -0700 (PDT)
Date: Mon, 12 Aug 2024 21:07:15 -0700
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
Message-ID: <Zrrb8xkdIbhS7F58@mini-arch>
References: <20240812125717.413108-1-jdamato@fastly.com>
 <ZrpuWMoXHxzPvvhL@mini-arch>
 <2bb121dd-3dcd-4142-ab87-02ccf4afd469@uwaterloo.ca>
 <ZrqU3kYgL4-OI-qj@mini-arch>
 <d53e8aa6-a5eb-41f4-9a4c-70d04a5ca748@uwaterloo.ca>
 <Zrq8zCy1-mfArXka@mini-arch>
 <5e52b556-fe49-4fe0-8bd3-543b3afd89fa@uwaterloo.ca>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e52b556-fe49-4fe0-8bd3-543b3afd89fa@uwaterloo.ca>

On 08/12, Martin Karsten wrote:
> On 2024-08-12 21:54, Stanislav Fomichev wrote:
> > On 08/12, Martin Karsten wrote:
> > > On 2024-08-12 19:03, Stanislav Fomichev wrote:
> > > > On 08/12, Martin Karsten wrote:
> > > > > On 2024-08-12 16:19, Stanislav Fomichev wrote:
> > > > > > On 08/12, Joe Damato wrote:
> > > > > > > Greetings:
> > > > > > > 
> > > > > > > Martin Karsten (CC'd) and I have been collaborating on some ideas about
> > > > > > > ways of reducing tail latency when using epoll-based busy poll and we'd
> > > > > > > love to get feedback from the list on the code in this series. This is
> > > > > > > the idea I mentioned at netdev conf, for those who were there. Barring
> > > > > > > any major issues, we hope to submit this officially shortly after RFC.
> > > > > > > 
> > > > > > > The basic idea for suspending IRQs in this manner was described in an
> > > > > > > earlier paper presented at Sigmetrics 2024 [1].
> > > > > > 
> > > > > > Let me explicitly call out the paper. Very nice analysis!
> > > > > 
> > > > > Thank you!
> > > > > 
> > > > > [snip]
> > > > > 
> > > > > > > Here's how it is intended to work:
> > > > > > >      - An administrator sets the existing sysfs parameters for
> > > > > > >        defer_hard_irqs and gro_flush_timeout to enable IRQ deferral.
> > > > > > > 
> > > > > > >      - An administrator sets the new sysfs parameter irq_suspend_timeout
> > > > > > >        to a larger value than gro-timeout to enable IRQ suspension.
> > > > > > 
> > > > > > Can you expand more on what's the problem with the existing gro_flush_timeout?
> > > > > > Is it defer_hard_irqs_count? Or you want a separate timeout only for the
> > > > > > perfer_busy_poll case(why?)? Because looking at the first two patches,
> > > > > > you essentially replace all usages of gro_flush_timeout with a new variable
> > > > > > and I don't see how it helps.
> > > > > 
> > > > > gro-flush-timeout (in combination with defer-hard-irqs) is the default irq
> > > > > deferral mechanism and as such, always active when configured. Its static
> > > > > periodic softirq processing leads to a situation where:
> > > > > 
> > > > > - A long gro-flush-timeout causes high latencies when load is sufficiently
> > > > > below capacity, or
> > > > > 
> > > > > - a short gro-flush-timeout causes overhead when softirq execution
> > > > > asynchronously competes with application processing at high load.
> > > > > 
> > > > > The shortcomings of this are documented (to some extent) by our experiments.
> > > > > See defer20 working well at low load, but having problems at high load,
> > > > > while defer200 having higher latency at low load.
> > > > > 
> > > > > irq-suspend-timeout is only active when an application uses
> > > > > prefer-busy-polling and in that case, produces a nice alternating pattern of
> > > > > application processing and networking processing (similar to what we
> > > > > describe in the paper). This then works well with both low and high load.
> > > > 
> > > > So you only want it for the prefer-busy-pollingc case, makes sense. I was
> > > > a bit confused by the difference between defer200 and suspend200,
> > > > but now I see that defer200 does not enable busypoll.
> > > > 
> > > > I'm assuming that if you enable busypool in defer200 case, the numbers
> > > > should be similar to suspend200 (ignoring potentially affecting
> > > > non-busypolling queues due to higher gro_flush_timeout).
> > > 
> > > defer200 + napi busy poll is essentially what we labelled "busy" and it does
> > > not perform as well, since it still suffers interference between application
> > > and softirq processing.
> > 
> > With all your patches applied? Why? Userspace not keeping up?
> 
> Note our "busy" case does not utilize our patches.

Great, thanks for confirming, that makes sense!

> As illustrated by our performance numbers, its performance is better than
> the base case, but at the cost of higher cpu utilization and it's still not
> as good as suspend20.
> 
> Explanation (conjecture):
> 
> It boils down to having to set a particular static value for
> gro-flush-timeout that is then always active.
> 
> If busy-poll + application processing takes longer than this timeout, the
> next softirq runs while the application is still active, which causes
> interference.
> 
> Once a softirq runs, the irq-loop (Loop 2) takes control. When the
> application thread comes back to epoll_wait, it already finds data, thus
> ep_poll does not run napi_busy_poll at all, thus the irq-loop stays in
> control.
> 
> This continues until by chance the application finds no readily available
> data when calling epoll_wait and ep_poll runs another napi_busy_poll. Then
> the system switches back to busy-polling mode.
> 
> So essentially the system non-deterministically alternates between
> busy-polling and irq deferral. irq deferral determines the high-order tail
> latencies, but there is still enough interference to make a difference. It's
> not as bad as in the base case, but not as good as properly controlled irq
> suspension.
> 
> > > > > > Maybe expand more on what code paths are we trying to improve? Existing
> > > > > > busy polling code is not super readable, so would be nice to simplify
> > > > > > it a bit in the process (if possible) instead of adding one more tunable.
> > > > > 
> > > > > There are essentially three possible loops for network processing:
> > > > > 
> > > > > 1) hardirq -> softirq -> napi poll; this is the baseline functionality
> > > > > 
> > > > > 2) timer -> softirq -> napi poll; this is deferred irq processing scheme
> > > > > with the shortcomings described above
> > > > > 
> > > > > 3) epoll -> busy-poll -> napi poll
> > > > > 
> > > > > If a system is configured for 1), not much can be done, as it is difficult
> > > > > to interject anything into this loop without adding state and side effects.
> > > > > This is what we tried for the paper, but it ended up being a hack.
> > > > > 
> > > > > If however the system is configured for irq deferral, Loops 2) and 3)
> > > > > "wrestle" with each other for control. Injecting the larger
> > > > > irq-suspend-timeout for 'timer' in Loop 2) essentially tilts this in favour
> > > > > of Loop 3) and creates the nice pattern describe above.
> > > > 
> > > > And you hit (2) when the epoll goes to sleep and/or when the userspace
> > > > isn't fast enough to keep up with the timer, presumably? I wonder
> > > > if need to use this opportunity and do proper API as Joe hints in the
> > > > cover letter. Something over netlink to say "I'm gonna busy-poll on
> > > > this queue / napi_id and with this timeout". And then we can essentially make
> > > > gro_flush_timeout per queue (and avoid
> > > > napi_resume_irqs/napi_suspend_irqs). Existing gro_flush_timeout feels
> > > > too hacky already :-(
> > > 
> > > If someone would implement the necessary changes to make these parameters
> > > per-napi, this would improve things further, but note that the current
> > > proposal gives strong performance across a range of workloads, which is
> > > otherwise difficult to impossible to achieve.
> > 
> > Let's see what other people have to say. But we tried to do a similar
> > setup at Google recently and getting all these parameters right
> > was not trivial. Joe's recent patch series to push some of these into
> > epoll context are a step in the right direction. It would be nice to
> > have more explicit interface to express busy poling preference for
> > the users vs chasing a bunch of global tunables and fighting against softirq
> > wakups.
> 
> One of the goals of this patch set is to reduce parameter tuning and make
> the parameter setting independent of workload dynamics, so it should make
> things easier. This is of course notwithstanding that per-napi settings
> would be even better.
> 
> If you are able to share more details of your previous experiments (here or
> off-list), I would be very interested.

We went through a similar exercise of trying to get the tail latencies down.
Starting with SO_BUSY_POLL, then switching to the per-epoll variant (except
we went with a hard-coded napi_id argument instead of tracking) and trying to
get a workable set of budget/timeout/gro_flush. We were fine with burning all
cpu capacity we had and no sleep at all, so we ended up having a bunch
of special cases in epoll loop to avoid the sleep.

But we were trying to make a different model work (the one you mention in the
paper as well) where the userspace busy-pollers are just running napi_poll
on one cpu and the actual work is consumed by the userspace on a different cpu.
(we had two epoll fds - one with napi_id=xxx and no sockets to drive napi_poll
and another epoll fd with actual sockets for signaling).

This mode has a different set of challenges with socket lock, socket rx
queue and the backlog processing :-(

> > > Note that napi_suspend_irqs/napi_resume_irqs is needed even for the sake of
> > > an individual queue or application to make sure that IRQ suspension is
> > > enabled/disabled right away when the state of the system changes from busy
> > > to idle and back.
> > 
> > Can we not handle everything in napi_busy_loop? If we can mark some napi
> > contexts as "explicitly polled by userspace with a larger defer timeout",
> > we should be able to do better compared to current NAPI_F_PREFER_BUSY_POLL
> > which is more like "this particular napi_poll call is user busy polling".
> 
> Then either the application needs to be polling all the time (wasting cpu
> cycles) or latencies will be determined by the timeout.
> 
> Only when switching back and forth between polling and interrupts is it
> possible to get low latencies across a large spectrum of offered loads
> without burning cpu cycles at 100%.

Ah, I see what you're saying, yes, you're right. In this case ignore my comment
about ep_suspend_napi_irqs/napi_resume_irqs.

Let's see how other people feel about per-dev irq_suspend_timeout. Properly
disabling napi during busy polling is super useful, but it would still
be nice to plumb irq_suspend_timeout via epoll context or have it set on
a per-napi basis imho.

