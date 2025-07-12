Return-Path: <linux-fsdevel+bounces-54736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECABB02832
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 02:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A614E4B1C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 00:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1514F2C9D;
	Sat, 12 Jul 2025 00:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FmGrkNSy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jOu9u/bv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BFD7E1;
	Sat, 12 Jul 2025 00:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752278978; cv=none; b=YDqQ7wPNAoLFrSS2QF8CvmcnClVxa23bUwVLeXDwXpCG9oKlAvvBFHJQ60HIo4PC3Nty30a7u1a4jU7/BOS/BrtnJkFIqlgO0pVAhuICXUqu+e+ioMxouWp7oDW2mpDPaoFxzzx4+E5ijhJneIBPDE2+sYfuqjUiamzcsI2ELKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752278978; c=relaxed/simple;
	bh=1zcWqARHBHhd9onhgWG62EpHRur3APNdJH6ch4VkW4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIVNDj8xHYn9UAR+gRucd2P0P30GMksbdNuV7eMmKVh2dBcHkC+2RRFgaOrG8ymQTSQKEKpGufhOzkQMhUS7xHDJ0X+HDd64VwLLp+f/aUOruHZNuZ0hAcmR6+k41fsHJ4tBnIeoCP6yZLc9zU5Auk4uu9yn8058NRQ9tYrixbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FmGrkNSy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jOu9u/bv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 12 Jul 2025 02:09:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752278975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1zcWqARHBHhd9onhgWG62EpHRur3APNdJH6ch4VkW4o=;
	b=FmGrkNSyOeA49n8gt1SASTxSx2faLlzWDeQjn1jqpeO0NgP1qLW/DE1MOZNPwAawJJUDgJ
	UP6qEYdWJtWvNUmRz6yZ3AcLFsWnYx+YMy+M1ROgEukziwjDON6p0ecGF8aqqAI5pSsmXH
	UY0BkHophkC75xu+hO6Opmuq36Uk7hho/Yg6dMBywHnnNlfm6rI/+RCW1A0p9MRvYc+NDv
	uc8URWywxZqZTgeoJToe+A2tpHY0imdkNfRh+WGKgJsgOveZNSKAjNQJRm671nWGgMlcC5
	/4Zcq0KQOoP9X075OA9nES8TMraz5a2nEQszlFcs25xsksGwwA60ZC+ugfk30g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752278975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1zcWqARHBHhd9onhgWG62EpHRur3APNdJH6ch4VkW4o=;
	b=jOu9u/bvDc9i268ZxwwgufRBrr1A4HzFOvSFa9hxWSwpBPj+llpXXKkGGDs52eDBYnVISt
	QGLyTdXtZEChkVBQ==
From: Nam Cao <namcao@linutronix.de>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Christian Brauner <brauner@kernel.org>,
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
Message-ID: <20250712000934.DwvOk7Hk@linutronix.de>
References: <20250710062127.QnaeZ8c7@linutronix.de>
 <d14bcceddd9f59a72ef54afced204815e9dd092e.camel@xry111.site>
 <20250710083236.V8WA6EFF@linutronix.de>
 <c720efb6a806e0ffa48e35d016e513943d15e7c0.camel@xry111.site>
 <20250711050217.OMtx7Cz6@linutronix.de>
 <20250711-ermangelung-darmentleerung-394cebde2708@brauner>
 <6856a981f0505233726af0301a1fb1331acdce1c.camel@xry111.site>
 <20250711095830.048P551B@linutronix.de>
 <7a50fd8af9d21aade901fe4d32e14e698378c82f.camel@xry111.site>
 <20250711122123.qXVK-EkF@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711122123.qXVK-EkF@linutronix.de>

On Fri, Jul 11, 2025 at 08:09:12PM +0800, Xi Ruoyao wrote:
> And I'm afraid this may be a bug in my userspace... Then I'd feel guilty
> if this is reverted because of an invalid bug report from I :(.

FYI I just got a separate bug report. So something is definitely wrong with
this patch.

Best regards,
Nam

