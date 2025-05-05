Return-Path: <linux-fsdevel+bounces-48077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B955AAA9441
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 15:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E65023AC5C1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 13:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6742580E4;
	Mon,  5 May 2025 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqCQV8gu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79FB2561C2;
	Mon,  5 May 2025 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746451287; cv=none; b=RutKbkJd16ocAzP5mplcRT4M/mById3FrzxJBsKHBlSugbV+Cjbhupps+kMZJoNoZPS8s/xMJHVVUzGK5ZAtbLB1P6SrmfEEvRDlaGJ+5lEOMVNz6m9kaimBPQ/rYl7x/JeLCl9L+qFB2HqZf9/XM1ZxsYbgd6NoWipRtp05X+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746451287; c=relaxed/simple;
	bh=ldELQzfHK87PQQQfleRnUEJg/gMY/mZ4vI8tzWyzr8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wh6BLW+noAZArJnJXLT4FmV5Ozt+VraUqqfWUp7jGxEb/aIimcEaFbFgMOOH2P892Pab/nPO4NF0j5v5JaAiP0QgOpdSM59Ew5wQaatJ/CZ21ht2vJPuM91j58kYA5XGIUp88tuwRxOWiDvtENrNA0RSqb3R9UkFcG4StdJfPZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqCQV8gu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001CCC4CEE4;
	Mon,  5 May 2025 13:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746451287;
	bh=ldELQzfHK87PQQQfleRnUEJg/gMY/mZ4vI8tzWyzr8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cqCQV8gu4LRto+ZkjWGndNuymkJJsRRzkAl7dGtF8Jzh7NxOopKqmx+ajhdmjGKSo
	 zkCqlGMkNv8ApbDvTO00gn/RVLQiTdLPz90Lg/+bCgJ7r9vZzngmWa3UBZ1yxfRe5z
	 4ZeCPBaraj+hJgcpWd5J0uQKzcww8gyaZwP8I1vppEWwH8F807//ruhgFeHAYErFPt
	 4Bre1vcN0tPFEeyxVHwFY5KjtVPlS5vU06s7WaL/n0EdCZ9shWjktJU1sg+6CIybAg
	 tCK3gtky9HD6d/6PhHtE+bM/ZIOVnYxdsGTX92sOvOt6Do76DFtckjUFkF/8vrB+ba
	 ZSaud9Jqsfeew==
Date: Mon, 5 May 2025 15:21:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [QUESTION vfs] Namespaces from kernel code for user mode threads
Message-ID: <20250505-festplatten-befragen-0cb139d40b6d@brauner>
References: <20250430144436-d3c2c91d-b32e-4967-96c9-3913579ce626@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250430144436-d3c2c91d-b32e-4967-96c9-3913579ce626@linutronix.de>

On Wed, Apr 30, 2025 at 03:05:04PM +0200, Thomas Weißschuh wrote:
> Hi everybody,
> 
> I am trying to set up mount namespaces on top of a 'struct vfsmount'
> and run user mode threads inside that namespace. All of this from kernel code.

I have a hard time understanding what you want to do.

> However there doesn't seem a way to run the equivalent of unshare(CLONE_NEWNS)
> inside the kernel.

ksys_unshare(CLONE_NEWNS)?

> Is this something that should work and if so, how?
> The goal is that these processes execute inside a nearly empty filesystem tree.
> 
> The full context is in this series:
> https://lore.kernel.org/all/20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de/
> Specifically "[PATCH 09/12] kunit: Introduce UAPI testing framework"
> in kunit_uapi_mount_tmpfs() and related.

Shouldn't something like:

static int umh_kunit_uapi_mount_setup(struct subprocess_info *info, struct cred *new)
{
	return ksys_unshare(CLONE_NEWNS);
}

sub_info = call_usermodehelper_setup(something_prog,
				     something_argv,
				     NULL,
				     GFP_KERNEL,
				     umh_kunit_uapi_mount_set(),
				     NULL,
				     something_setup_data);

retval = call_usermodehelper_exec(sub_info, UMH_WAIT_EXEC);

do what you want?

