Return-Path: <linux-fsdevel+bounces-44622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588F1A6AB9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 18:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D147917D922
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 17:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D086221572;
	Thu, 20 Mar 2025 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pLuy41SG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4900E42065
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742490048; cv=none; b=O9D9EF4mYyCcCYwNvBde/3nbj6tfA/017brYXRRXIFD117m/M45EiN4EuI6FuLUT9fcTBSG6bYbgpBes3gfn4OVPmvjMoJkAseHx8qR+oRpyl5iropc+DEJqGvK5xWuwNA0dcqrhGRTQEgjLzn5ktbB2xE2tcE6BXU3EpVgRCdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742490048; c=relaxed/simple;
	bh=ltG1T/4g5/I5mb9CAa4Lk/qtHKG2lhHZPAO0Uhz7H5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZCdaRPRXEH9gtg69nH9tBbO1b7Ert1fervCPzvxkzsJgrDrM0p1+Jim3VOlEqwSYlphzAAEu/jwwMU2l6JxRWgxL3YHrx3W/EGXx+LL3OqtHXcdl+Ush6qLy7HqV+3uOJzANCbP0bGo6zripdLV/h0aJMBv2EuU1KYDOHFiptE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pLuy41SG; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Mar 2025 13:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742490045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0xPTua4U2aXfY2uC6bIIPmQxXJXjAmg3/cbOyI54oT0=;
	b=pLuy41SG/I0mKvuQS5Fxm2CoMTR+wwsVawRyTwQq7UJjdadC1B10hHqzeM5itYsasyGKCw
	Zx2kiDPBVb6KN37HnQHMDjsRg8YSrx+d9WVOSg+cUT0LBJ9Xyf9o2eUhPALlcAdV795fci
	kNFKsKTc3BM2AtDB7UgOq+4IVvud8R0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem Suspend Resume
Message-ID: <mkiz5zxv3iorrzdf4g4rclsbjjcobnilke6tjga23qw3egk2pb@c57sk3lkdaep>
References: <0a76e074ef262ca857c61175dd3d0dc06b67ec42.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a76e074ef262ca857c61175dd3d0dc06b67ec42.camel@HansenPartnership.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 20, 2025 at 11:36:17AM -0400, James Bottomley wrote:
> [Note: this got scheduled because I suggested it as a topic on the
> application form.  I'm still not convinced it's that relevant and it
> could become a lightning talk instead if there's not much interest]
> 
> This came up as a problem because efivarfs needs a hibernate hook.  The
> specific efivarfs problem is that when the kernel is running, it owns
> the EFI runtime interface, so nothing can update variables without
> going through the kernel and so the cache of efivarfs (held in the
> variable dentries) reflects exactly the state of the underlying
> variables.  However, when the system is hibernated, other OSs could
> boot and alter EFI variables, so the exact cache correspondence
> guarantee is broken and efivarfs needs to resync the variable store on
> resume from hibernate.
> 
> Part of the thought here is that other filesystems might possibly want
> suspend resume hooks as well, although not for the reasons efivarfs
> does:  Hibernate is a particularly risky operation and resume may not
> work leading to a full reboot and filesystem inconsistencies.  In many
> ways, a failed resume is exactly like a system crash, for which
> filesystems already make specific guarantees.  However, it is a crash
> for which they could, if they had power management hooks, be forewarned
> and possibly make the filesystem cleaner for eventual full restore. 
> Things like guaranteeing that uncommitted data would be preserved even
> if a resume failed, which isn't something we guarantee across a crash
> today.
> 
> The other reason for discussing this is that adding power management
> hooks directly to efivarfs resulted in a lot of deadlock potential
> (discussion of which is already on linux-fsdevel), which could
> potentially be lessened by making it part of the VFS API.  If other
> filesystems think they might use it in future, we should discuss how
> this could work.

there's a hook in s_ops, although today it's only called from blk_holder
ops - presumably you'd just want to add a superblock flag to say "I need
freeze/suspend hooks to be called directly"?

