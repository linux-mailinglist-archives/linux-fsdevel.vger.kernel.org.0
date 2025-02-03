Return-Path: <linux-fsdevel+bounces-40647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D53A2631C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 19:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4EBE3A5FFB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 18:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02707199236;
	Mon,  3 Feb 2025 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="qFyOKIor";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FOwF1pYl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EBA26ACC
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 18:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738608889; cv=none; b=cWKChmJoxN/yOWshNZlhhsSOVVkj/4OP/mDoYKxBeoc5rOWVPVmWq40kM6+XqHQ8Sy4dqhyl6jTC6oUgtfhWpDTwR99ESTR8IQnOQ3z7LRGBxbOGAewXnKA9ye80sLFunFTSHcYNi1gbr6UmnlF1TjaEJUnvApZEgtl7VbZLYUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738608889; c=relaxed/simple;
	bh=p/clqbBUEoA/fZVsae3TQCtgDvRyKObv1LvHMOnuDXk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dHsl81+NwXdMIf3JilUAcW3wEK4N5KqxvxfcmkE5D8X5wfdeJa322pFd6uKd+aEe6M0Q4xI3th/TNJgEfv00eJypUe4mHB5Txm39NdVQRmxgJk/R9OltA9kHEFuFDNUesb9OC9sbxTEf2l0ofEXchYdq+7azIMjoGWnikmLcBqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=qFyOKIor; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FOwF1pYl; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E97F4114014A;
	Mon,  3 Feb 2025 13:54:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 03 Feb 2025 13:54:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1738608884; x=1738695284; bh=Nm85lsmwej7D3LrCmB44a7897/n47Kv2
	gIrQoQT/5HE=; b=qFyOKIorlelYip0W/gsuXsJ+Z7vhfCB1BGl28ZRNY+GBp2wc
	eJvUvmjj39xas7/C+wBI09XkTI4aAPRkz7PVhmP3YPFT/eFp0zIM5776QD6XMTvU
	J7i+IWMT9uIF3ov4WyDlYZYZrx3rlhCn7lXE22MErZpvhQ5EdADmZKykNNJXNrJg
	dskVIUd+Xmiw+bZ2CSvOprrd/A4wyoPEJkMz8l7odPg9jpoiXs4+1lgK/dGfgOVi
	5CIsD3xAPzj54G2WOBnC2gNyLrCl5AY3b8FRuGNw802x38joO/8XbKxjqyNdgx5z
	PUyAYrK5UnRRx5f3fEm5mSiDvwcEXpnPGnFKlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738608884; x=
	1738695284; bh=Nm85lsmwej7D3LrCmB44a7897/n47Kv2gIrQoQT/5HE=; b=F
	OwF1pYlSSzVZP5nqxwdcYqeKkbhJ1hgTEEZ2aDVq7k6NXNHEOyvjly7Za06k8gmq
	SbhfdQVsgACE9C1bzVpnRSOn18ao1dxBbg9aOiyga+op+5enfMS1qMpuaeLelsa1
	WO6XijUruUUOkkNHsP+5bzU/C/XU7+OqN1Mu+vsQ6NI1OuHFGx2+KzgCpE/oT5FW
	OtDQyiGz+ufw6NFzpTZeLM6plst+WYJiznB26RS7q31hjxWabHbwVZmTDLsy9wzl
	xto8Tym8rT69zMvvfXGM3t6xL8n8YJlLwCeSIKQgcG5yZMm2Ev8bUq6huJmjiKhD
	TEHkgqQeFVlJ0uhujb9XA==
X-ME-Sender: <xms:9BChZ8iRtUh_cpYPuqdBYHoZX8oHqHvjus9buy1w3ZOcVvWcHzcJmA>
    <xme:9BChZ1DenjLfaiNPbFHK2j9CIXuA60gtaPX6e_7DG-bcbFeDQpFwJA9hvzUfLg97l
    ESPfMihkT0GGZ5sWws>
X-ME-Received: <xmr:9BChZ0HggJKNOOxqySN13qQP9Qe5xsivDmgxrbM51x7iQ5_3ISoFiWWaF01UWu1wh9noD1i6xSuMJ0qk8XfugVCSJLU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkgggtugesthdtredttddtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceo
    sghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekteefkedtfeeffefghf
    ehfffguddttdehveffffegvefgvdelgefhheeuheffgeenucffohhmrghinhepkhgvrhhn
    vghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehlshhfqdhptgeslhhishhtshdrlhhinhhugidqfhhouh
    hnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9BChZ9RNKYmjdt_iWjFYALJ3LRhtDlLWNybpFKoCyuG4jw1lYfphsQ>
    <xmx:9BChZ5xfNlZOj_WYEoR23G0Q6RTy8sJtNNiN5w8YukBMs0hsL6sG5g>
    <xmx:9BChZ755w3sZuG82tCpxhhSAKPWqHhC5V2UOS5Cce3va6rnUuVUp6Q>
    <xmx:9BChZ2wbYcMsAEI0OYsYupr0hOlzT_4Aow5NQLYlOfi0IDLU4yOVgQ>
    <xmx:9BChZ09Eu1SWtRccgD4d9NPpBhC6QEUDYX3v1M2C_f5mfy3L3MQNSE6_>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 13:54:44 -0500 (EST)
Date: Mon, 3 Feb 2025 10:55:19 -0800
From: Boris Burkov <boris@bur.io>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Long Duration Stress Testing Filesystems
Message-ID: <20250203185519.GA2888598@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

At Meta, we currently primarily rely on fstests 'auto' runs for
validating Btrfs as a general purpose filesystem for all of our root
drives. While this has obviously proven to be a very useful test suite
with rich collaboration across teams and filesystems, we have observed a
recent trend in our production filesystem issues that makes us question
if it is sufficient.

Over the last few years, we have had a number of issues (primarily in
Btrfs, but at least one notable one in Xfs) that have been detected in
production, then reproduced with an unreliable non-specific stressor
that takes hours or even days to trigger the issue.
Examples:
- Btrfs relocation bugs
https://lore.kernel.org/linux-btrfs/68766e66ed15ca2e7550585ed09434249db912a2.1727212293.git.josef@toxicpanda.com/
https://lore.kernel.org/linux-btrfs/fc61fb63e534111f5837c204ec341c876637af69.1731513908.git.josef@toxicpanda.com/
- Btrfs extent map merging corruption
https://lore.kernel.org/linux-btrfs/9b98ba80e2cf32f6fb3b15dae9ee92507a9d59c7.1729537596.git.boris@bur.io/
- Btrfs dio data corruptions from bio splitting
(mostly our internal errors trying to make minimal backports of
https://lore.kernel.org/linux-btrfs/cover.1679512207.git.boris@bur.io/
and Christoph's related series)
- Xfs large folios 
https://lore.kernel.org/linux-fsdevel/effc0ec7-cf9d-44dc-aee5-563942242522@meta.com/

In my view, the common threads between these are that:
- we used fstests to validate these systems, in some cases even with
  specific regression tests for highly related bugs, but still missed
  the bugs until they hit us during our production release process. In
  all cases, we had passing 'fstests -g auto' runs.
- were able to reproduce the bugs with a predictable concoction of "run
  a workload and some known nasty btrfs operations in parallel". The most
  common form of this was running 'fsstress' and 'btrfs balance', but it
  wasn't quite universal. Sometimes we needed reflink threads, or
  drop_caches, or memory pressure, etc. to trigger a bug.
- The relatively generic stressing reproducers took hours or days to
  produce an issue then the investigating engineer could try to tweak and
  tune it by trial and error to bring that time down for a particular bug.

This leads me to the conclusion that there is some room for improvement in
stress testing filesystems (at least Btrfs).

I attempted to study the prior art on this and so far have found:
- fsstress/fsx and the attendant tests in fstests/. There are ~150-200
  tests using fsstress and fsx in fstests/. Most of them are xfs and
  btrfs tests following the aforementioned pattern of racing fsstress
  with some scary operations. Most of them tend to run for 30s, though
  some are longer (and of course subject to TIME_FACTOR configuration)
- Similar duration error injection tests in fstests (e.g. generic/475)
- The NFSv4 Test Project
  https://www.kernel.org/doc/ols/2006/ols2006v2-pages-275-294.pdf 
  A choice quote regarding stress testing:
  "One year after we started using FSSTRESS (in April 2005) Linux NFSv4
  was able to sustain the concurrent load of 10 processes during 24
  hours, without any problem. Three months later, NFSv4 reached 72 hours
  of stress under FSSTRESS, without any bugs. From this date, NFSv4
  filesystem tree manipulation is considered to be stable."


I would like to discuss:
- Am I missing other strategies people are employing? Apologies if there
  are obvious ones, but I tried to hunt around for a few days :)
- What is the universe of interesting stressors (e.g., reflink, scrub,
  online repair, balance, etc.)
- What is the universe of interesting validation conditions (e.g.,
  kernel panic, read only fs, fsck failure, data integrity error, etc.)
- Is there any interest in automating longer running fsstress runs? Are
  people already doing this with varying TIME_FACTOR configurations in
  fstests?
- There is relatively less testing with fsx than fsstress in fstests.
  I believe this creates gaps for data corruption bugs rather than
  "feature logic" issues that the fsstress feature set tends to hit.
- Can we standardize on some modular "stressors" and stress durations
  to run to validate file systems?

In the short term, I have been working on these ideas in a separate
barebones stress testing framework which I am happy to share, but isn't
particularly interesting in and of itself. It is basically just a
skeleton for concurrently running some concurrent "stressors" and then
validating the fs with some generic "validators". I plan to run it
internally just to see if I can get some useful results on our next few
major kernel releases.

And of course, I would love to discuss anything else of interest to
people who like stress testing filesystems!

Thanks,
Boris

