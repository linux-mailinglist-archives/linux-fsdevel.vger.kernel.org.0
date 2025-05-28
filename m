Return-Path: <linux-fsdevel+bounces-49947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 251A9AC61B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 08:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7BD4A3CCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 06:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1C6212B0C;
	Wed, 28 May 2025 06:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YB5LvelA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FW7/wTKj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76B2195FE8;
	Wed, 28 May 2025 06:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748412781; cv=none; b=NGyM4KnOb/AS9hxBGkUBW7RRrx9znlRR0/kw3oKMh8gqA4OzoirNaN76Qz9DK7XfXhHo2GL347gIaDN5oYP2Yq7kVWBeSIhoy0oaoi9WYJZ3oFDcL+aCBw47nHPhJhJ66eXb8uKQq72Uzx+XQ07Wmz305dP2v4MHKwjU7lpI2J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748412781; c=relaxed/simple;
	bh=rxFzwGyf3zCL39xFxcp2SmNxp4T6cx0JLgHayOZN5NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2HuWpzLxaVP2YG8C9us8rRpV7ON/NdrPiv7MNbPDdBsebgynINrsnvopSJH2yigwBHOLGE/+BYuUYN9aE97r3ymj9cXWIuhy9N3QpSoPPAaT5CHltfkyMJ1QbVEpn97ZTGo4oQ/XT3kgAVh/RN9rzgJ7SaN5SFooGNMf7+E1Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YB5LvelA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FW7/wTKj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 May 2025 08:12:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748412778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rxFzwGyf3zCL39xFxcp2SmNxp4T6cx0JLgHayOZN5NA=;
	b=YB5LvelAj30FQYO2KPZ4V8lgBUjptsHgU1eM41hOEsnaNCxUdxYRoRsHKgc5QoSpDEACra
	EVknvQu66nPBbmoxFJ9OljtKPLT3optsVo3xXiTqGYB7O2+24zAx2xt/ghWWpoq3QH36Lt
	oQRDbcCoW67/wEnMnEaaWBGGr6cnI77zIcj9/zV5bqe8leI3YkigugCdu7+XbO0ibX1qBo
	0TMQekejoSMClnp5oIWpSD7L3zJi59ZyBOBRiWJ/48MqkMpSkZaDdr1ySGYH6l18ntGg1A
	rbnKupKVQ/fPfj23slPAakEeQkfmBgvsml0eaCnz0K6gpTsqsQqLV4nTIjjjrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748412778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rxFzwGyf3zCL39xFxcp2SmNxp4T6cx0JLgHayOZN5NA=;
	b=FW7/wTKjR3KqSk2JP+WuWGgnn8tW5v3fMTN/0/O30mcxDaZMovykk3NmSDpnLOhLTt0v2d
	CZI9QzscaJE865CA==
From: Nam Cao <namcao@linutronix.de>
To: Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org, Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jens Axboe <axboe@kernel.dk>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v2] eventpoll: Fix priority inversion problem
Message-ID: <20250528061252.AeDA23yH@linutronix.de>
References: <20250523061104.3490066-1-namcao@linutronix.de>
 <3475f3f1-4109-b6ac-6ea6-dadcdec8db1f@applied-asynchrony.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3475f3f1-4109-b6ac-6ea6-dadcdec8db1f@applied-asynchrony.com>

On Wed, May 28, 2025 at 07:57:26AM +0200, Holger Hoffstätte wrote:
> I have been running with v2 on 6.15.0 without any issues so far, but just
> found this in my server's kern.log:

Thanks for testing!

> It seems the condition (!n) in __ep_remove is not always true and the WARN_ON triggers.
> This is the first and only time I've seen this. Currently rebuilding with v3.

Yeah this means __ep_remove() thinks the item is in epoll's rdllist and
attempt to remove it, but then couldn't actually find the item in the list.

__ep_remove() relies on the 'ready' flag, and this flags is quite
complicated. And as my colleague pointed out off-list, I got memory
ordering wrong for this flag. Therefore it is likely that you stepped on a
bug with this flag.

I got rid of this flag in v3, so hopefully the problem goes away.

Best regards,
Nam

