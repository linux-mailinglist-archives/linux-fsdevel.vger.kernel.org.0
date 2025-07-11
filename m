Return-Path: <linux-fsdevel+bounces-54608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E962B018C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 11:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 467AF7B5D13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 09:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0A627EFEA;
	Fri, 11 Jul 2025 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K0O2EOHu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zXNl0BF8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251C427E075;
	Fri, 11 Jul 2025 09:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227413; cv=none; b=c/+q3ptxpmKTQprKLqHKmhHOgX4TQSmqkEOfz+fMZ4WvnGX4Q94sfJ7gwai1N4AEcodpSW8VCB+bBpxRiVGZoBHpiTgoeC41skwyLw1AtTpHM/jNv4O59vIINuPjq2QjLmySRS+ZXwEfFXyIOZzkJ55wr/1P80zZtfGh0m8/yik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227413; c=relaxed/simple;
	bh=fW1NnlF1yw7WFSGTMF/b4xSOPsEU5pODFRCx1PUeiqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZR81sKDdaosse/qnahkuZDT8m1TjZYggGetvzp4/SqRh8+qCoehjldQg0IPYi/aGtB63N+DSv8mJ4V/tu8N8jExDWbqrV6EFddzxSIrrj2EUhmI4A7VA5vyVaXvfIeNTTQcHQHcbICn9P0+WQducbTJvNkQYZV0nBlJdIS4JEis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K0O2EOHu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zXNl0BF8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 11:50:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752227410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fW1NnlF1yw7WFSGTMF/b4xSOPsEU5pODFRCx1PUeiqs=;
	b=K0O2EOHuzUPWhmP4zny1ofpcedMSdv09xdBGpVDp+2UC92dcsT/yy8jRi4D5aYgZ3EvW47
	yvmNsI//YfkM1yjSdHvXDHbHqrbU0S1PH3iofcOEmNqcQPqy4bHBCLIWfXe6J3n9NQoA6D
	B4mqWUKUJ6eBlkf8MUDbmLHtJ0DJAgLxOWCg/qpUp7Faa1/yz4ypRHGog/91fRpFaYrerV
	6uXmqi2FRTMSGPnq2uHDdPpHIe0XI7RSuty6CRG9V9svZTUJ8o5tKw3NFGHKJPwPH5RHli
	jeVaCBhpwjmaw9V5pRpmnTHsHunZWE55oha8RW/DS7tqkABSdrz143Ohf+mFjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752227410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fW1NnlF1yw7WFSGTMF/b4xSOPsEU5pODFRCx1PUeiqs=;
	b=zXNl0BF85i9QM+tSVf/L8Qg0ITyOSVteI6J79Cp/fXCOJAXs2c64Yz5vwd3mIfu5wYMgC2
	wc7ysHst148kgRAg==
From: Nam Cao <namcao@linutronix.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Xi Ruoyao <xry111@xry111.site>,
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
Message-ID: <20250711095008.lBxtWQh6@linutronix.de>
References: <cda3b07998b39b7d46f10394c232b01a778d07a9.camel@xry111.site>
 <20250710034805.4FtG7AHC@linutronix.de>
 <20250710040607.GdzUE7A0@linutronix.de>
 <6f99476daa23858dc0536ca182038c8e80be53a2.camel@xry111.site>
 <20250710062127.QnaeZ8c7@linutronix.de>
 <d14bcceddd9f59a72ef54afced204815e9dd092e.camel@xry111.site>
 <20250710083236.V8WA6EFF@linutronix.de>
 <c720efb6a806e0ffa48e35d016e513943d15e7c0.camel@xry111.site>
 <20250711050217.OMtx7Cz6@linutronix.de>
 <20250711-ermangelung-darmentleerung-394cebde2708@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711-ermangelung-darmentleerung-394cebde2708@brauner>

On Fri, Jul 11, 2025 at 11:44:28AM +0200, Christian Brauner wrote:
> I think we should revert the fix so we have time to fix it properly
> during v6.17+. This patch was a bit too adventurous for a fix in the
> first place tbh.

Agreed. I did feel a bit uneasy when I saw the patch being applied to
vfs.fixes.

Let me know if you want me to send a patch, otherwise I assume you will do
the revert yourself.

Nam

