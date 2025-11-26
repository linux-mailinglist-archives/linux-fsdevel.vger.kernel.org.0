Return-Path: <linux-fsdevel+bounces-69883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CD3C899BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 12:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0DA43B5407
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 11:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF73232572E;
	Wed, 26 Nov 2025 11:55:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gnu.wildebeest.org (gnu.wildebeest.org [45.83.234.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CF23246EA;
	Wed, 26 Nov 2025 11:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.83.234.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764158130; cv=none; b=RSz3LWXIpsp3Sqd9/hFSSai9Pat8HmJAgiOuSYORvG9BN1BeCv4njRw/2eKeVUq0EfUaz6O6wb6XVQH2oQ2hbXEn5jqzN1oPyaxFkfKjysiUuTkXuAVANT/Rf4AgwcKRNIMn+pzCwlnZQrQ7KjTmUUrt5DmNPk40h5vN/ozTblI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764158130; c=relaxed/simple;
	bh=mAzzMf4sOW+uxqfTrdpo0kgUwsdMto751Gn6hAWJ4A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAf2k3u00NA55UntB1jaUS69H8rzSAifa/YfZ6JpKjDlLHxHX2ENgtJP7sxxNQurBMcNgyPr2/zP2OVojoEKjB5OBciVQqCWTeazDhPpjs/1sl3wKSjq7oSjBNmj8COHIa9cSXH0G5Q1NJQ7VMDWHyGIIsfBHRNBVWmfing3+kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klomp.org; spf=pass smtp.mailfrom=klomp.org; arc=none smtp.client-ip=45.83.234.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klomp.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=klomp.org
Received: by gnu.wildebeest.org (Postfix, from userid 1000)
	id 7A09F3141369; Wed, 26 Nov 2025 12:47:23 +0100 (CET)
Date: Wed, 26 Nov 2025 12:47:23 +0100
From: Mark Wielaard <mark@klomp.org>
To: strace development discussions <strace-devel@lists.strace.io>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	netdev@vger.kernel.org, libc-alpha@sourceware.org,
	"Dmitry V. Levin" <ldv@strace.io>,
	address-sanitizer <address-sanitizer@googlegroups.com>
Subject: Re: Stability of ioctl constants in the UAPI (Re: [PATCH 01/32]
 pidfs: validate extensible ioctls)
Message-ID: <20251126114723.GL11602@gnu.wildebeest.org>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-1-4dd56e7359d8@kernel.org>
 <lhu7bvd6u03.fsf_-_@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lhu7bvd6u03.fsf_-_@oldenburg.str.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi,

On Wed, Nov 26, 2025 at 10:08:44AM +0100, Florian Weimer wrote:
> Is this really the right direction?  This implies that the ioctl
> constants change as the structs get extended.  At present, this impacts
> struct pidfd_info and PIDFD_GET_INFO.
> 
> I think this is a deparature from the previous design, where (low-level)
> userspace did not have not worry about the internal structure of ioctl
> commands and could treat them as opaque bit patterns.  With the new
> approach, we have to dissect some of the commands in the same way
> extensible_ioctl_valid does it above.
> 
> So far, this impacts glibc ABI tests.  Looking at the strace sources, it
> doesn't look to me as if the ioctl handler is prepared to deal with this
> situation, either, because it uses the full ioctl command for lookups.
> 
> The sanitizers could implement generic ioctl checking with the embedded
> size information in the ioctl command, but the current code structure is
> not set up to handle this because it's indexed by the full ioctl
> command, not the type.  I think in some cases, the size is required to
> disambiguate ioctl commands because the type field is not unique across
> devices.  In some cases, the sanitizers would have to know the exact
> command (not just the size), to validate points embedded in the struct
> passed to the ioctl.  So I don't think changing ioctl constants when
> extensible structs change is obviously beneficial to the sanitizers,
> either.

Same for valgrind memcheck handling of ioctls.

> I would prefer if the ioctl commands could be frozen and decoupled from
> the structs.  As far as I understand it, there is no requirement that
> the embedded size matches what the kernel deals with.

Yes please.

Thanks,

Mark

