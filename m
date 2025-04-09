Return-Path: <linux-fsdevel+bounces-46094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DEEA827B2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 16:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A90B8A4E20
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 14:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE41C26156D;
	Wed,  9 Apr 2025 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gflKF2jB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ATZqdJpO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DE118CBE1;
	Wed,  9 Apr 2025 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744208715; cv=none; b=FIU4dzsUhC3xoD2smiDLidvDlPLv0/XXtB5E3n6rYYWZTaRggiywUs9OvtPVzjHJ5J5mkycLoCDskbW4kjGhfNrNgWM4MW/pzEJNdIVzjvYK1mxcZNIN7DPHYmnoCxt73qdyQ31z9p176j6++4jYB3d6pHG1ZKYT91BHtGTCvQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744208715; c=relaxed/simple;
	bh=JyUyIJyU0ZXJDvodc8BAc4Ocyexf+D8OENVtq+NNldk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeOb84jCj5X06qbBUr/cV4h8xcUl1GxO8NR66K4BBVfiF+UD2iwzLWkr63BNP4qayo6OIJBFgAxChMXRBtzOtwOtRVer408slXI+2jW/3+0/H2nrK5UvBw9tAQV/yYDutzoNdiTR4NTm6jQsWl+wdSfKFTKe3JZvh9XF6vrUN+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gflKF2jB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ATZqdJpO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 9 Apr 2025 16:25:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744208711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JyUyIJyU0ZXJDvodc8BAc4Ocyexf+D8OENVtq+NNldk=;
	b=gflKF2jBzlcAlKkBnWx47eCRcUcpkuPgqz8EPS3Gx+6L7FsvB/l2JAdVKnqkRhZtTKwKU3
	RwLfCkFOKb5abgnb8nlEE3PzAnCBFrGkXR2FbdMdKPjwHV6bPuKs3sQkgxYOzbW03ABSYu
	IVbJD51EP6QlLwhRoXxBnitigy77tq+tgKhJXMsTeYDi32dYlnkUB0dbkKCm5YxGewEel1
	dhmQs2MeANbtRk3maTMtPHam98CJLsSwnUf/kLYRBBy96HnSKkIonEa9NAjVSWTivxOB9s
	74ZfFjeIxwX6NDNOx9JN76pf+imvnlmif4ziVymCZbHt/eVcFNgGcwVbK+7czQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744208711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JyUyIJyU0ZXJDvodc8BAc4Ocyexf+D8OENVtq+NNldk=;
	b=ATZqdJpOwjxEaol79yvNrNC75bpwmPUElyTSiV2H6wrHcB5e9gP3VLEHnND+B16lqYSldM
	b9RGWi28wfLEG2DA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Eric Chanudet <echanude@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Alexander Larsson <alexl@redhat.com>,
	Lucas Karpinski <lkarpins@redhat.com>
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <20250409142510.PIlMaZhX@linutronix.de>
References: <20250408210350.749901-12-echanude@redhat.com>
 <20250409-egalisieren-halbbitter-23bc252d3a38@brauner>
 <20250409131444.9K2lwziT@linutronix.de>
 <4qyflnhrml2gvnvtguj5ee7ewrz3ejhgdb2lfihifzjscc5orh@6ah6qxppgk5n>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4qyflnhrml2gvnvtguj5ee7ewrz3ejhgdb2lfihifzjscc5orh@6ah6qxppgk5n>

On 2025-04-09 16:02:29 [+0200], Mateusz Guzik wrote:
> On Wed, Apr 09, 2025 at 03:14:44PM +0200, Sebastian Andrzej Siewior wrote:
> > One question: Do we need this lazy/ MNT_DETACH case? Couldn't we handle
> > them all via queue_rcu_work()?
> > If so, couldn't we have make deferred_free_mounts global and have two
> > release_list, say release_list and release_list_next_gp? The first one
> > will be used if queue_rcu_work() returns true, otherwise the second.
> > Then once defer_free_mounts() is done and release_list_next_gp not
> > empty, it would move release_list_next_gp -> release_list and invoke
> > queue_rcu_work().
> > This would avoid the kmalloc, synchronize_rcu_expedited() and the
> > special-sauce.
> >=20
>=20
> To my understanding it was preferred for non-lazy unmount consumers to
> wait until the mntput before returning.
>=20
> That aside if I understood your approach it would de facto serialize all
> of these?
>=20
> As in with the posted patches you can have different worker threads
> progress in parallel as they all get a private list to iterate.
>=20
> With your proposal only one can do any work.
>=20
> One has to assume with sufficient mount/unmount traffic this can
> eventually get into trouble.

Right, it would serialize them within the same worker thread. With one
worker for each put you would schedule multiple worker from the RCU
callback. Given the system_wq you will schedule them all on the CPU
which invokes the RCU callback. This kind of serializes it, too.

The mntput() callback uses spinlock_t for locking and then it frees
resources. It does not look like it waits for something nor takes ages.
So it might not be needed to split each put into its own worker on a
different CPU=E2=80=A6 One busy bee might be enough ;)

Sebastian

