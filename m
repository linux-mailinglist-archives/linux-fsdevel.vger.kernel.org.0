Return-Path: <linux-fsdevel+bounces-46630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA264A921AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 17:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4A51781FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 15:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07690253B78;
	Thu, 17 Apr 2025 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r7fnejSH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RhJ9nZiM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C132F24339D;
	Thu, 17 Apr 2025 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903891; cv=none; b=L7dnOpph1uJ3I7+wvZpkxqbV5U4rqqejpFj/45VuOnFaC9B9GoJLwKo8kEJUWsfHhOVWPGIamry27DiZMJjt2mOmOT7UNL6nvN0vRGr0lusH3mqK8hZjBiilvA/BlCnJ7c0MQe/6VWWO7vLxhJYL8q3jLsRAn3KvegT1mSLAYIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903891; c=relaxed/simple;
	bh=wH4xbnF0tJ+lpv6tI2RocL517peQVILv0bdOqBny/aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4BHXW1yceZsdboNkkQpgWO05bSt1DMQBwUh/wf7J7hNGbRQRddtvaoYrU12aGXGJkw/l3US5c6anBzgy+etDQfrVpPNvY/b3ZXiYHv4oxhPj/ZKPXq6ERBIahZ+FgaCVOVsDM2GQviR2iQ2batmFuF8LlZnmBMlDpzkzNXjmT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r7fnejSH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RhJ9nZiM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 17:31:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744903888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jPz1GvAsRDSeWCTqbiCwXpDsU6owFfdI+6h+yJOwEN8=;
	b=r7fnejSHrmuXZG3gkKO6oax4/vQkB0tYQslhdQS4NLgWa1Qg7ycLsssCP3Achi+GJeFvY8
	mAD+Vw4zPOSbHJvK8L5trOLqdaiASJhiAjpLesCPTAwbA/wjDeSr4waGGTXgmVaDB5jsXp
	jRxWplPFXqCFcWlwldZDA7wsDXWrEyNROGH0xgQJfdZj0vjQ+RYBgpLJpAbQVfJvYsg7lm
	zUuZxst0QJmcuxO3F91W3/Mh6cubMsrvp5XUOv6sWuSefQt0ECKxHGLzJD5V6wCR5aUpjF
	3MhWFRX+Zx4PIIBnsG1BG1iYhCKP4txp1uahOX39RtEzxo9S3ZlzAP+ehhXthg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744903888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jPz1GvAsRDSeWCTqbiCwXpDsU6owFfdI+6h+yJOwEN8=;
	b=RhJ9nZiMb5QGNDaj87nqAmzhO5W3mAIsyA/Z0DzqINI7yVN+20Qn/BOe6+bj3GyNENvfiJ
	YrSPRn/ltCnQImBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Ian Kent <raven@themaw.net>, Mark Brown <broonie@kernel.org>,
	Eric Chanudet <echanude@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Alexander Larsson <alexl@redhat.com>,
	Lucas Karpinski <lkarpins@redhat.com>, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <20250417153126.QrVXSjt-@linutronix.de>
References: <20250408210350.749901-12-echanude@redhat.com>
 <fbbafa84-f86c-4ea4-8f41-e5ebb51173ed@sirena.org.uk>
 <20250417-wolfsrudel-zubewegt-10514f07d837@brauner>
 <fb566638-a739-41dc-bafc-aa8c74496fa4@themaw.net>
 <20250417-abartig-abfuhr-40e558b85f97@brauner>
 <20250417-outen-dreihundert-7a772f78f685@brauner>
 <20250417-zappeln-angesagt-f172a71839d3@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250417-zappeln-angesagt-f172a71839d3@brauner>

On 2025-04-17 17:28:20 [+0200], Christian Brauner wrote:
> >     So if there's some userspace process with a broken NFS server and it
> >     does umount(MNT_DETACH) it will end up hanging every other
> >     umount(MNT_DETACH) on the system because the dealyed_mntput_work
> >     workqueue (to my understanding) cannot make progress.
> 
> Ok, "to my understanding" has been updated after going back and reading
> the delayed work code. Luckily it's not as bad as I thought it is
> because it's queued on system_wq which is multi-threaded so it's at
> least not causing everyone with MNT_DETACH to get stuck. I'm still
> skeptical how safe this all is. 

I would (again) throw system_unbound_wq into the game because the former
will remain on the CPU on which has been enqueued (if speaking about
multi threading).

Sebastian

