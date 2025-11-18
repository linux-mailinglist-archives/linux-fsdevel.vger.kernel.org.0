Return-Path: <linux-fsdevel+bounces-68902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA358C67ED2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 08:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id A43EE2A251
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 07:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243F93043B7;
	Tue, 18 Nov 2025 07:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="24QE6ZMl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HemVkTlf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FC32FE063;
	Tue, 18 Nov 2025 07:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450695; cv=none; b=m6d7nErSryawtU4OMg61UuZ5dVBB4BqglwWDQ4aWtftze9QBSaC5OLU99549EKImMtKffHE39JHwhKDtQwN1aXR/+LrTpm17SHEC4yyR0WEPe72sAFFt+mVjFHpK05EsCqWA3E6rqxUPDH5QF0mg4RdbkXhJv6BFNFCW4qk33UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450695; c=relaxed/simple;
	bh=jrjinFXbeDbMX2dy8EHh/ldqeCkJ7jxk4YEibZJS9Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoH1G0nO4PkeQnDKqBZDFO7sglur6hklTh6YiCKWNo2w62HZr7mf24LA5uRQXZBMfjHcz9q1XVSrbPQfx0UdXh96kD/8kdajyV3rM0X9DRRGhJMXBOJxTUA8nvxARGQbTJbjxUZLTQh2hVO9jM44/zcEnd5WhdprF+DpU7996LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=24QE6ZMl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HemVkTlf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Nov 2025 08:24:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763450691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I9vA6V+bN9GTdLdJJnTr5BmlcMkR802o3dcmS/oJ4PA=;
	b=24QE6ZMlr+aPw0mCJ5+WZU96Ur1bJED22ECyuR3qc6mknaLzxVccN1eBwGOEHnhDPXViIi
	vYgzPxjYImC932JHg5SRA4a/U7iRiyXlufjgEKN4WCeGZs0vyBoTiY57FYZhIlaLZIjOYL
	+alp7QvobezEF44LShBi4xm5QwByUm+lr5oir3v42WJgDcsNA1jjMRsN3D7i9qQlM6SH/w
	Q7jKWbml/XlgMaWqRO6CbEuEcKtaMflllcFEPJbOfhRueQ9ruRBPn/TM+ku3PXkSxlYXiS
	tZlF7YYrv2qXgzM7t0CdOvC+IbV/y+85xI811fdS8iBRo5Im02eMP11MJthBmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763450691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I9vA6V+bN9GTdLdJJnTr5BmlcMkR802o3dcmS/oJ4PA=;
	b=HemVkTlfIKjmIexQaIi7tETka6Ixoo5dyRx/jz0Qu6Db6AH88jYgFE/IZlIzrJ2xfOoL2m
	0DLyByvQHHJXBSDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: pengdonglin <dolinux.peng@gmail.com>
Cc: tj@kernel.org, tony.luck@intel.com, jani.nikula@linux.intel.com,
	ap420073@gmail.com, jv@jvosburgh.net, freude@linux.ibm.com,
	bcrl@kvack.org, trondmy@kernel.org, longman@redhat.com,
	kees@kernel.org, hdanton@sina.com, paulmck@kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v3 00/14] Remove redundant rcu_read_lock/unlock() in
 spin_lock
Message-ID: <20251118072449.PFe_yjOF@linutronix.de>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>

On 2025-09-16 12:47:21 [+0800], pengdonglin wrote:
Hi,

> There is no need no explicitly start a RCU read section if one has already
> been started implicitly by spin_lock().
> 
> Simplify the code and remove the inner rcu_read_lock() invocation.

I'm not going argue if this is a good or not but: If you intend to get
this merged I suggest you rebase your series (or what is left since I
think a few patches got merged) on top of current tree and resend them
individually targeting the relevant tree/ list. Otherwise everyone might
think someone else is in charge of this big series.

Sebastian

