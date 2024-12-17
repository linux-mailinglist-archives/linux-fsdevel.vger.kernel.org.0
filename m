Return-Path: <linux-fsdevel+bounces-37618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A10C59F460B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 09:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C43487A3CAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 08:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCCC1DB34C;
	Tue, 17 Dec 2024 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgPe59sd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416D51D63C4
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734424089; cv=none; b=sgl1VgHBQjVAR7SiSBM/6KW1PJe6ORJ0+o7YUXytb0sBA1E87b4v8FzbT0kCeStoGYOYURE5vp+WjBKbz3sW6KYIlFLHXhG5fgpd3YlR/Cg8La3fdZOjG9Av9KdEF0d88kdYkdwYCw9Zmolqy+X5c4HEqXcRKgT/S1oHsVmMGQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734424089; c=relaxed/simple;
	bh=SOlXUCnunM/Jd6MAAq1445iR8WTwgwPifL9RG7kdILk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ogpp54Dtb/E51DkjqezkViWmY8cmmdlFHn33PIW9K3DYJ26A5OapGNC8sdN9oaD5dTCueHQnHnLpNDw3eNByQ65773X6s+PyHxrq3MDsqjbnWEy1W9S4uUv59eAUEDLN2BQCM18SlnSzpPxcoC+BWNIopQYBeZcMqMIzQkBXWz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgPe59sd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2834C4CED3;
	Tue, 17 Dec 2024 08:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734424088;
	bh=SOlXUCnunM/Jd6MAAq1445iR8WTwgwPifL9RG7kdILk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dgPe59sdKG4j1KK8/f5jsdU7NjhgfpNql3btFMHFyDsmXyFixQIcHjgyam0aY1MJy
	 iTGflCficBWq1lj8h9afxO+X5jsnCDyf8T6VL3z5e0OUbq3koMeE6JVR6u30b2aG+N
	 pFEwAeL3tPb9Yc6FIFeLt+V2nijmBtmYL16R3cR1blYgk23tOI2WaiR2uqfU5bt5zS
	 +Jh0kF8mJjxODQoDohHDTRFOzmgPjVnriZqxHHUrBnVetzMMV9sg5w9W/0u0A8cFZX
	 3ZSM2ApcJtOWCWyGWqnx31u+VpazozrJgCu3EC5qpbdSnClrd2IEvZtSQ+KcD/bSz1
	 /EZFdw0PBfAiA==
Date: Tue, 17 Dec 2024 09:28:05 +0100
From: Christian Brauner <brauner@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>
Subject: Re: [REGRESSION] generic/{467,477} in linux-next
Message-ID: <20241217-specht-umgerechnet-d9725590bdb0@brauner>
References: <20241217060432.GA594052@mit.edu>
 <20241217-ansturm-hallt-2b62fa6739de@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241217-ansturm-hallt-2b62fa6739de@brauner>

On Tue, Dec 17, 2024 at 08:59:20AM +0100, Christian Brauner wrote:
> On Tue, Dec 17, 2024 at 01:04:32AM -0500, Theodore Ts'o wrote:
> > For at least the last two days, I've been noticing xfstest failures
> > for generic/467 and generic/477 for all file systems.  It can be
> > reproduced by "install-kconfig; kbuild ; kvm-xfstests -c
> > ext4/4k,xfs/4k generic/467 generic/477".
> > 
> > I tried doing a bisection, which fingered commit 3660c5fd9482
> > ("exportfs: add permission method").  When I tried reverting this
> > commit, and then fixing up a compile failure in fs/pidfs.c by the most
> > obvious way, the test stopped failing.
> > 
> > Christian, could you take a look?   Many thanks!!
> 
> On it!

Ok, pretty obvious bug. may_decode_fh() returned a bool instead of a
negative error code. This is now fixed and tested with both xfs and
ext4.

