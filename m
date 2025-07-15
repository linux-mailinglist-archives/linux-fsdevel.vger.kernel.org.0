Return-Path: <linux-fsdevel+bounces-54935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED01B05780
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 12:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1677F3B49CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 10:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1672D5C7C;
	Tue, 15 Jul 2025 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4V41a3UW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WqnNyQgu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5293533991;
	Tue, 15 Jul 2025 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752574135; cv=none; b=RJ/Eqk7QMG1a7vq448R9NzC4xaIHEyE3kBWPiHUNz7NJCX6ph/bJquuG0sfwcYXe8r8ncMOnSocZhs4mKmow2GV/JwZwek1lQjgGOXyAx7/nW8IDzdLnttayrljRXhtxoWdPJfqGizcfPY7ZTuDrHhIFuedQkiR132vQpSga5GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752574135; c=relaxed/simple;
	bh=unJmDb30/LD9dW1o8da23Qz4dPUYs/rGWQdLTKvDN1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVpkMf8Ajr5Y+wMOGJwRyn5vCMUfvW8MCSgZrtvgBPsf7td9stXJbttzdbIxbFVGkoj44HWDaRLwhPw6zVN5XVnfrn4LzDZDARAqouDi7noLE1IiFlhkyNwjxLGhsuiiy3G7aCnHdPRTlZna+YA1+iaoBv4W2SLJF9d/EZfJMgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4V41a3UW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WqnNyQgu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Jul 2025 12:08:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752574132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3hBU31yPJvG3c+IQkxaHgrBFpzyM59h6NsiogdejvA4=;
	b=4V41a3UW4omcQC7kOCv7CGLyh6SPBklutqAAKBwHgbr3ZEmtH4kPktExAqFQ7EIcGcU9fe
	Jx9nLu3Z2Tw2/LYg20gP0oa8wNneF08g33veHs3srEWJ7270TTHq6k5Gt+mqCcgnJf1ykC
	1p2ArKcmOyMhpwlGykynC1q5Be7yCIeNteL6IMTV28t6cDGPcTK1M3Rm7DEAPLxlBpQyy8
	EMmKRkh/Vq62QFZgv6/qZMLJS5PLZY8L3OqNKQ/2BTOfLUDf7K88g7VymEPhPo7UdkYGfg
	AoDtyQOG8vwhwziq+3cLPTJLAYgT2RfHe2VsdFOrqW93JUEV6dVdv/msA1bklQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752574132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3hBU31yPJvG3c+IQkxaHgrBFpzyM59h6NsiogdejvA4=;
	b=WqnNyQgumi0TbH6koK6WLUnkuN304pkslcy1J1ipvV27S27YSEfox/S2qi8M9MNcry51as
	rwTDhMIYoxzf7EAg==
From: Nam Cao <namcao@linutronix.de>
To: Yann Ylavic <ylavic.dev@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Xi Ruoyao <xry111@xry111.site>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org, Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3] eventpoll: Fix priority inversion problem
Message-ID: <20250715100850.BkoElq8C@linutronix.de>
References: <20250710062127.QnaeZ8c7@linutronix.de>
 <d14bcceddd9f59a72ef54afced204815e9dd092e.camel@xry111.site>
 <20250710083236.V8WA6EFF@linutronix.de>
 <c720efb6a806e0ffa48e35d016e513943d15e7c0.camel@xry111.site>
 <20250711050217.OMtx7Cz6@linutronix.de>
 <20250711-ermangelung-darmentleerung-394cebde2708@brauner>
 <20250711095008.lBxtWQh6@linutronix.de>
 <20250714-leumund-sinnen-44309048c53d@brauner>
 <20250714101410.Su0CwBrb@linutronix.de>
 <CAKQ1sVOYCFS6PD0u1yssDj3=8mDmi1K1Sfy930qYWeCfRuF_ZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKQ1sVOYCFS6PD0u1yssDj3=8mDmi1K1Sfy930qYWeCfRuF_ZA@mail.gmail.com>

On Tue, Jul 15, 2025 at 11:37:05AM +0200, Yann Ylavic wrote:
> On Mon, Jul 14, 2025 at 9:48 PM Nam Cao <namcao@linutronix.de> wrote:
> >
> > And my lesson is that lockless is hard. I still have no clue what is the
> > bug in this patch.
> 
> Maybe this is related:
> https://lore.kernel.org/all/20250704180804.3598503-1-shakeel.butt@linux.dev/
> ?

Maybe, you would need to ask Xi to validate it, because I cannot reproduce
the issue.

But I have abandoned this patch, even if we figure out the problem, sorry.
The patch was a mistake, it makes the code much more complicated. Even
myself got confused when I looked at it again after a few weeks.

The performance numbers were surely impressive, but it is probably not that
important. I don't think the benchmark reflects real workload anyway.

I'm going to simply switch the rwlock to spinlock instead. The numbers are
not as nice as before, but the code is simpler. The new patch is obvious to
look at.

I'm running tests right now. If no issue appears then I'm going to post it.

Best regards,
Nam

