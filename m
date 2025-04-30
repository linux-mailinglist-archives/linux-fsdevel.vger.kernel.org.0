Return-Path: <linux-fsdevel+bounces-47723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B91AA4CC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 15:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 308217B095C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 13:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5F02609F6;
	Wed, 30 Apr 2025 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sEDoJ8Nk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EyvkTN3M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAEC25D90F;
	Wed, 30 Apr 2025 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746018308; cv=none; b=d1ANE1GyaOaXai+mP1BojqQG2igTeChLInkuHG2wXboROhhTQhJarDGBBhHw73sGH1SMyM3f0DzbJCXhdVH+79OaenW0HPPr/sgm+3rrRHHQVZGjqE1JnD1lgRDHpBN7yEzvumRyPVRpNdAbVlXFZ8JVyO3cyIVuyZrrUigMTnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746018308; c=relaxed/simple;
	bh=tvPY3jJ2Bcs6Onm9C+b3qPcvfJJUb19PouEY7w69vxY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FVEqUWT8uhfR8YnpQ3C5cuyRgroKb7vQOaagKYWhKVfR9EABFOv0EeoHKwAwBZp37mVZf7KTHxgIp5okZK8BoaedFPryiZb/a395Jw5RomABOndlM812euxZmPp+/08OTnvFOpQbkLMJZtUa+yLPNHUkQ9EasS/IHNXBGw0cIIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sEDoJ8Nk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EyvkTN3M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Apr 2025 15:05:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746018304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=tvPY3jJ2Bcs6Onm9C+b3qPcvfJJUb19PouEY7w69vxY=;
	b=sEDoJ8NkvAuZVhxWQju7CGbPPuDLXcfcNtdiuFbRxLusfTbgs6GE9iqQwU/JD4BzdCwvpV
	dcngR2zEsKQ/bkhjMXPZ3aHbRFj1iPdgZ5j5H1HSOsM+RPwNiKlxL8QyMREMBdTS5i7yaN
	gU6bl9YmZ8dr8xSmbc5uqdglqNMJFhvWYkikd9TH6wCGnoAQgztU5t9WB0DHtEg+JUDTf9
	MUJsdXSOIyacSavtzvM3JjcAokoMpI26dRoe8ACLfppFSkwsP3JvSUXcSGR8Ps5XQFoCoI
	w8CBhQ8dR/rDCnJUKw7pij9FhMoocTq5xzHPKOUI6lXPWyPCBnPIB7tkBadzog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746018304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=tvPY3jJ2Bcs6Onm9C+b3qPcvfJJUb19PouEY7w69vxY=;
	b=EyvkTN3MGTPJjuL+5PSO8J+Rlq6xdhYVV3vJoFx4YONVdOBo02mh7V4vVVTeTJTutjOuXn
	EatN+pHEzjTM53BQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [QUESTION vfs] Namespaces from kernel code for user mode threads
Message-ID: <20250430144436-d3c2c91d-b32e-4967-96c9-3913579ce626@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everybody,

I am trying to set up mount namespaces on top of a 'struct vfsmount'
and run user mode threads inside that namespace. All of this from kernel code.
However there doesn't seem a way to run the equivalent of unshare(CLONE_NEWNS)
inside the kernel.
Is this something that should work and if so, how?
The goal is that these processes execute inside a nearly empty filesystem tree.

The full context is in this series:
https://lore.kernel.org/all/20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de/
Specifically "[PATCH 09/12] kunit: Introduce UAPI testing framework"
in kunit_uapi_mount_tmpfs() and related.


Thanks,
Thomas

