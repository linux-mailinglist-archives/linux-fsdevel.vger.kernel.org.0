Return-Path: <linux-fsdevel+bounces-20883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5F38FA8AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 05:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D461C2350C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 03:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838A713D636;
	Tue,  4 Jun 2024 03:10:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B87C22075;
	Tue,  4 Jun 2024 03:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717470657; cv=none; b=FetP8dXB5cKztP8bu2bfgJKL8ScGBM9JFImFCYRdPavSoYKbji54D/EHgfoadxAdAAabVGPuUrhmgFq9V3wl7hhQdrewZvAyu5L/50Z6xnciwY8d1Ws6B9C3lKDk6sIx8lSuzO6xVAKTZoNzf0BGMRteqnEE0eOPMqaCHCuzBm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717470657; c=relaxed/simple;
	bh=KWpt31Q4kyUR6ItyJoLWVr38gcMQarjmif+KZWfd1vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcI45u73wChOJLTE3Lt2OIiuUBGZJ0uLa0nYf7qMvVhWa/BfcTRPnH1iE9olTVCFhgN7UpS71s40jGxt/3+9CLLetYnPeAHoVRgHcWqiwiVVafmBXGcqwohqsqnhaCAqgo/m55HxcblqmYZuDlquD08p9Bc8fkJB2slS3qdEbWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-2d-665e85b718cd
Date: Tue, 4 Jun 2024 12:10:42 +0900
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
Message-ID: <20240604031042.GB20371@system.software.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA02SX0yTZxTGfd/vL501H53EdzCzpNvCAs6BkeS4mG3hZt/FFmdMZqJh2sGH
	NELVUlHMxlotBKsikiBQiZZKSgPMaiELDEqwRqD+7aDRFpGMDrMRinVo0Qrr1rKZeXPyy3Oe
	8+S5ODyliDGpvFqjk7QaVbGSldGyuZUtH/ZUflOY5W5MgTMnsyDyrJqGZkcnC95LHQg6uw0Y
	Zq5/DvcXQggWb9+loKHei6Bl6iEF3UOTCFz2oyyMTa8CXyTMgqf+BAvHLjpY+GV2CcPE2ToM
	Hc4v4WatFcNg9HcaGmZYONdwDMfHHxiitnYObPr3IWg3c7A0lQ2eyXsMuMYzoen8BAv9Lg8N
	Qz1BDGM/N7Mw2fk3AzeHRmjwnjnFwI+PrSzMLtgosEXCHIwOWjBcNsaDqp7GGBg+NYihqvUK
	Bl+gD8FA9a8YnJ33WLgWCWHoctZT8LLtOoJgzRwHlSejHJwz1CA4UXmWhrt/DTNgnMiBxRfN
	7Gcfi9dCYUo0dh0SXQsWWrxhJWKv+SEnGgfGOdHiPCh22TPEi/0zWGyZjzCis/04Kzrn6zjR
	NOfD4uM7dzhxpHGRFqd9DfirtB2yzQVSsbpM0n70yW5ZkW/uArffTB32PxjBejSETSiJJ8JG
	cqv2KHrFY6bAsk4L75GJQIxKMCukE78/usyrhQ/IldHxZaYEj4x4rbkJflPIJ4HfrjImxPNy
	Achw1doEKoQjpNuUknDIhWTiaZqm/73MIP7YDE5YKCGNtMX4hJwkKEldtZFNcIrwLhn8aThu
	kcWL9SURwxP3fy3fIlftfroWCebXYs2vxZr/j7Ugqh0p1JqyEpW6eOP6onKN+vD6/H0lThT/
	Stv3Szt70Lx3mxsJPFKulGdZ8woVjKqstLzEjQhPKVfLayp2FirkBaryI5J23y7twWKp1I3S
	eFq5Rr5h4VCBQtij0kl7JWm/pH21xXxSqh4deOe7KebRp8H0b083lc0aXoZw7/OKgdZw7htt
	VQ7dlnUdXwRdUQ2XB+r0SyvyTstz1f3bHMyjVv3moj8bjf7tOZlB84oWPRVa3L1KpwgbArqt
	X2dv75PdaL21peLt7uMGf/YP7r6uTXWxDGF27ajdkuJz9IZyktub7qfm2y+Aki4tUmVnUNpS
	1T9l0ZqOkQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUxTaRSG8313pbHMtYPxBp0YOxpNzbCoJMclbonx6ogaE0OCGw1epLKm
	FRQjClIQixJhgpWCUsFURBQpxHFksYJQiluVBikCAmIUBUnEMiLIDMUY/XPy5Jz3Ob9elpB1
	U96sKvqgqI5WRsppCSnZsiLlj79T94T5/dW3GLJO+4HrUzoJ+WWlNNhvXENQWpmMob9hAzwf
	GUAw9ugJAfocO4JLPZ0EVDZ2IagpPkFDS58nOFxDNNhyMmhIKSqj4en7cQwd57IxXDMHwoOz
	hRgso29I0PfTkKdPwZPjLYZRUwkDpqT50FtsYGC8xx9sXa0U1F+wUVDTvghyL3bQUF1jI6Hx
	di+Gljv5NHSV/kfBg8YmEuxZZyi4/qGQhvcjJgJMriEGnlmMGG5qJ7+lDU9QYD1jwZB2uRyD
	w1mFoDa9G4O5tJWGetcAhgpzDgFfrjQg6M0cZCD19CgDecmZCDJSz5Hw5KuVAm1HAIx9zqfX
	rBDqB4YIQVtxSKgZMZJCcyEv/GPoZARtbTsjGM1xQkWxQiiq7sfCpY8uSjCXnKIF88dsRtAN
	OrDw4fFjRmg6P0YKfQ493jY7WLJynxipihfVvqtCJOGOwQIm1kAcbnvRhJNQI9YhD5bnlvIt
	OucUk9w8vsM5QbiZ5hbwbW2jU+zFLeTLn7VPMcHZJLy9cJ2bf+VCeeere5QOsayUA96a9psb
	ZdwRvlI3w52QctN5W24f+c1U8G0T/dgdIbhZ/JUJ1r324OR8drqWdvMM7nfecsuKzyKp4Sfb
	8JNt+GEbEVGCvFTR8VFKVWSAjyYiPCFaddgnNCbKjCZ7Z0ocz7qNPrVsqEMci+TTpHB1d5iM
	UsZrEqLqEM8Sci9p5rGdYTLpPmXCEVEds1cdFylq6tAslpTPlG4KEkNk3H7lQTFCFGNF9fcr
	Zj28k1BPQPVYcmdEgfHPPb0NwbnDPuU+62/FrnL+8u/sd3SD1m/hgYD4uNXDx4+uTPRWeBc1
	Byp2naweWlL1pXXTfcvmh5538l5nzI0I3dicvywTlfmmpAZx99Vpqw3mu8VrF2T7zqmt6A7M
	Wr553Var4WVUcOL2oFi9p7/ej7GFVPlft++IkZOacKW/glBrlP8D/IAG+XMDAAA=
X-CFilter-Loop: Reflected

On Fri, Jan 26, 2024 at 06:30:02PM +0100, Thomas Gleixner wrote:
> > Furthermore, now that Dept was introduced, false positive alarms was
> > reported by that. Replaced it with try lock annotation.
> 
> I still have zero idea what this is about.

Lockdep is working on lock/unlock, while dept is working on wait/event.

Two are similar but strickly speaking, different in what to track.

	Byungchul

