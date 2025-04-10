Return-Path: <linux-fsdevel+bounces-46173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EB2A83D02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 10:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427013AD009
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 08:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D4B1F03F8;
	Thu, 10 Apr 2025 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="06gFpt6J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SntfhicX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF731EF372;
	Thu, 10 Apr 2025 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744273719; cv=none; b=N9fPsky8eJaiFZ7mQeFn8gEVc2sTO7fAYayV1D1uzuRFIlnPd6cpc41E+Ktrfzxog0569fHgImdrE6Gj9MKUfGzdpYYdQM5XEjboLjFEnK0OpFCgb3YtIyCRJkK322nQOcmy/wlNsdAPDwP/k8XQPKJ0uAV1P9sgNwGDqjyy2mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744273719; c=relaxed/simple;
	bh=1B79+g+n5OqnH6wJzQdfOTNChx1AjswGaK3LeiqvLQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j85mA2L+Hw7OKy9zO/JxIN4V4bTRG49E/dZVC14LCE7nXzAFaygAHnD8h7IXLmIWZxGH+rxL/4rMa5naV/bdOdcV5VIfRzbvD3ey0fvvf3JSbJ+V7eEsBFt963HzdNPHBS4x0uAx4rINhKFzPyEVbtEZLDK6gw/rRx6tlpDYUJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=06gFpt6J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SntfhicX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Apr 2025 10:28:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744273715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1B79+g+n5OqnH6wJzQdfOTNChx1AjswGaK3LeiqvLQY=;
	b=06gFpt6JCeNKBmmUCl3E8Vi7uP+z4KE/SgkIrNnaEJGAqZ7WbAqIA+j8rl723TTqLZmwgv
	66SzeeVCR5C6GThmCVfoZLATJRKioHujGsO75Qc9IlzH7V56c3ILVqFLVRpuyn9zvXDQxg
	yz8I2AVDuCN005eupBNfE0epuxa2yds0ALZs+3KNidlxxC5WVcsepLSugf3Hn077IjYnXY
	KAKJpeQT9jeU/1M7P0YeOzJNnqOquyPoFMUbPT6mQ3uF7HKlG5HwSeIEYk9Yg8TP+Yse2L
	wZ/ADNd2LvvDnt9/VJKcfD8YSJJ4NPMuOf955iOkm8jk2yM13bpxtNAKSnznng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744273715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1B79+g+n5OqnH6wJzQdfOTNChx1AjswGaK3LeiqvLQY=;
	b=SntfhicXKIt86nPTvIMP8OT+uRxE54zpv1Kc9YbR2LAn0uEqgXmCJQqQcsuBnxBNbMj2Ig
	TJVakXqxYWSskPDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Eric Chanudet <echanude@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Alexander Larsson <alexl@redhat.com>,
	Lucas Karpinski <lkarpins@redhat.com>
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <20250410082833.pjvaYuCM@linutronix.de>
References: <20250408210350.749901-12-echanude@redhat.com>
 <20250409-egalisieren-halbbitter-23bc252d3a38@brauner>
 <20250409131444.9K2lwziT@linutronix.de>
 <4qyflnhrml2gvnvtguj5ee7ewrz3ejhgdb2lfihifzjscc5orh@6ah6qxppgk5n>
 <20250409142510.PIlMaZhX@linutronix.de>
 <20250409-beulen-pumpwerk-43fd29a6801e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250409-beulen-pumpwerk-43fd29a6801e@brauner>

On 2025-04-09 18:04:21 [+0200], Christian Brauner wrote:
> On Wed, Apr 09, 2025 at 04:25:10PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2025-04-09 16:02:29 [+0200], Mateusz Guzik wrote:
> > > On Wed, Apr 09, 2025 at 03:14:44PM +0200, Sebastian Andrzej Siewior w=
rote:
> > > > One question: Do we need this lazy/ MNT_DETACH case? Couldn't we ha=
ndle
> > > > them all via queue_rcu_work()?
> > > > If so, couldn't we have make deferred_free_mounts global and have t=
wo
> > > > release_list, say release_list and release_list_next_gp? The first =
one
> > > > will be used if queue_rcu_work() returns true, otherwise the second.
> > > > Then once defer_free_mounts() is done and release_list_next_gp not
> > > > empty, it would move release_list_next_gp -> release_list and invoke
> > > > queue_rcu_work().
> > > > This would avoid the kmalloc, synchronize_rcu_expedited() and the
> > > > special-sauce.
> > > >=20
> > >=20
> > > To my understanding it was preferred for non-lazy unmount consumers to
> > > wait until the mntput before returning.
> > >=20
> > > That aside if I understood your approach it would de facto serialize =
all
> > > of these?
> > >=20
> > > As in with the posted patches you can have different worker threads
> > > progress in parallel as they all get a private list to iterate.
> > >=20
> > > With your proposal only one can do any work.
> > >=20
> > > One has to assume with sufficient mount/unmount traffic this can
> > > eventually get into trouble.
> >=20
> > Right, it would serialize them within the same worker thread. With one
> > worker for each put you would schedule multiple worker from the RCU
> > callback. Given the system_wq you will schedule them all on the CPU
> > which invokes the RCU callback. This kind of serializes it, too.
> >=20
> > The mntput() callback uses spinlock_t for locking and then it frees
> > resources. It does not look like it waits for something nor takes ages.
> > So it might not be needed to split each put into its own worker on a
> > different CPU=E2=80=A6 One busy bee might be enough ;)
>=20
> Unmounting can trigger very large number of mounts to be unmounted. If
> you're on a container heavy system or services that all propagate to
> each other in different mount namespaces mount propagation will generate
> a ton of umounts. So this cannot be underestimated.

So you want to have two of these unmounts in two worker so you can split
them on two CPUs in best case. As of today, in order to get through with
umounts asap you accelerate the grace period. And after the wake up may
utilize more than one CPU.

> If a mount tree is wasted without MNT_DETACH it will pass UMOUNT_SYNC to
> umount_tree(). That'll cause MNT_SYNC_UMOUNT to be raised on all mounts
> during the unmount.
>=20
> If a concurrent path lookup calls legitimize_mnt() on such a mount and
> sees that MNT_SYNC_UMOUNT is set it will discount as it know that the
> concurrent unmounter hold the last reference and it __legitimize_mnt()
> can thus simply drop the reference count. The final mntput() will be
> done by the umounter.
>=20
> The synchronize_rcu() call in namespace_unlock() takes care that the
> last mntput() doesn't happen until path walking has dropped out of RCU
> mode.
>=20
> Without it it's possible that a non-MNT_DETACH umounter gets a spurious
> EBUSY error because a concurrent lazy path walk will suddenly put the
> last reference via mntput().
>=20
> I'm unclear how that's handled in whatever it is you're proposing.

Okay. So we can't do this for UMOUNT_SYNC callers, thank you for the
explanation. We could avoid the memory allocation and have one worker to
take care of them all but you are afraid what this would mean to huge
container. Understandable. The s/system_wq/system_unbound_wq/ would make
sense.

Sebastian

