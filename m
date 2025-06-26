Return-Path: <linux-fsdevel+bounces-53092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8913AE9F68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 15:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 349AB18950B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 13:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50A82E762B;
	Thu, 26 Jun 2025 13:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bp7xTjiF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hzxfWqvZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FAF28DEE0;
	Thu, 26 Jun 2025 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750945878; cv=none; b=ChAzHov07o/WOvDa7Dgiv3T/p1nc6momaIqDKZKkye5PDrXU3TBzTaAe8NKGJ+JWtiKIKbNhDGVCRS6AzqYeyCh9G6CJQjPWqtvDJs/U2SWOi51U9kO7njxvBWbqZsMDTh57WbLAv60hMuSZ6BCx3WEsx1BeqHbAlC5PJhapYwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750945878; c=relaxed/simple;
	bh=k1CAUGAJRYPQoAtPAgzLX5jSVsTFw/26Ie8qsMvtFIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ38yTbHLSTZE5avgIf9OwV5+ikKozhWU1buKIlstZW6gpedxSDsBx3sat9jeWfYv0TGItodNqtewBkjiGOy7y1IPwP8ktWBdPdsE7x9CTRrAuK7oUX5c/nGK/r464BLYbzygU1MCmaAm2Vx5tw+Mc11BPaazLyZeDjX5la0WCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bp7xTjiF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hzxfWqvZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 26 Jun 2025 15:51:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750945875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k1CAUGAJRYPQoAtPAgzLX5jSVsTFw/26Ie8qsMvtFIk=;
	b=Bp7xTjiFrtbNw1/8IZ/K2PLBhs74bt313pxIqHXUE6oT7WTslZtbtnrWApca0Jaxt1mcEd
	tlfYfcjmPOZUfypf024gHDcAgU2YUOEsAXO1YRvi6zxYtVBo3VltmWGJ2LZIsCwZqzkxm4
	ZQZbAyQTphu4beI7BHrhu6ZZT6Nqvx/WDyVq22+0e0Sj8YPqWNytnlwu78oXE6VbFgrF0P
	MZMLQrv1eBJiJ8rMCuRkl8MBcxrceQZvmQXGAYXBpSaHT2rgiGH8F6ivlsVvGuw0hS9rWn
	ultssWiJBQMcz1YAckyT1RGuEw018Z3j5welF4DC3Y/Z4Sx2XdarFKAcY6orJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750945875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k1CAUGAJRYPQoAtPAgzLX5jSVsTFw/26Ie8qsMvtFIk=;
	b=hzxfWqvZsI+WDzaylsTp9W28//VuJ9qjXFBZRsKAeMPjBrOd0A1mJY7khFi6L5uUvpz4Oc
	MqxE4Z78lSnn+YBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Nam Cao <namcao@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	John Ogness <john.ogness@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org, Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jens Axboe <axboe@kernel.dk>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v3] eventpoll: Fix priority inversion problem
Message-ID: <20250626135113.yjfRdLV-@linutronix.de>
References: <20250527090836.1290532-1-namcao@linutronix.de>
 <20250530-definieren-minze-7be7a10b4354@brauner>
 <20250625153519.4QpnajiI@linutronix.de>
 <aF1MszYwYhUt0Mjy@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aF1MszYwYhUt0Mjy@localhost.localdomain>

On 2025-06-26 15:35:47 [+0200], Frederic Weisbecker wrote:
> I can't review the guts and details but it looks like a sane
> approach to me. Also the numbers are nice:

Thank you.

Sebastian

