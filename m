Return-Path: <linux-fsdevel+bounces-10291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2978499DC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A02F1C21243
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B770D1C283;
	Mon,  5 Feb 2024 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7Yej6P7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B591BF34;
	Mon,  5 Feb 2024 12:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707135034; cv=none; b=LA8Z9SBN5i64arE/jdv9A15emmTuhAnLx2oWRoM/KbVKvT+dyRByEcpxdAwOKNWOl/w+RMIUObYIxo2wDtLHGEDVqyGZZYcGuqAfq2ABS94HWMD5JIBK5dH0DUmZtRgcwYrrZQiGVCnaDWE4KTbsRkSkOXDhRcgzvcnRsJh0ivo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707135034; c=relaxed/simple;
	bh=FwnbpE9yWQQbfuStfMSdAVpms2unyg3Uv1emhgdfEDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3U49jfyoxisGrImEZMMCFs36TvnUlB6zWXPRxdlwSpyI9xa/6X9xidV6a2i7uGKPp4J32gVtNXQFAr6pu5Ke7FWSU11sP/QoG4voCwZdeDJnhxUaJBvBZ0VPnucSMbXho1vYzOb3EeQznhhyhudjUqTSSZ0Z7tiPTmYJjpRXOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7Yej6P7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5DBC433C7;
	Mon,  5 Feb 2024 12:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707135033;
	bh=FwnbpE9yWQQbfuStfMSdAVpms2unyg3Uv1emhgdfEDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T7Yej6P7z9Hsdya9am6dwVYvGXbWfkQywJJQHhgTZa6OuT8kifDflYil4X0kUJhEH
	 BcuIvFa4B/UFqjChzf9lyzsECV03t2Z31ORZV1BkgofZkogppoChCFEpzdVdR85PsC
	 sTMb/JM/GWvqvPTS16h9qOZpQ6Z8dJRcb4zY+uILLgVMjRWv4Cy08qM5zaFcQ1wM7e
	 +5SY1EDzzwhRS8fKEQyproWj0uY0iWbr7HjhwS2j9vXYtLa9+E3bSM9U6EhqaMhAPs
	 KLgGLlXNjEkOTBWgWgTUcpIIiAOTX6cll8wAAuw22//Rw+Qcvz7gXmHVaZM9yy43VE
	 OhAHfxwcI42OQ==
Date: Mon, 5 Feb 2024 13:10:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] filelock: add stubs for new functions when
 CONFIG_FILE_LOCKING=n
Message-ID: <20240205-prall-herde-c413a323b54c@brauner>
References: <20240204-flsplit3-v1-1-9820c7d9ce16@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240204-flsplit3-v1-1-9820c7d9ce16@kernel.org>

> Another thought too: "locks_" as a prefix is awfully generic. Might it be
> better to rename these new functions with a "filelock_" prefix instead?
> That would better distinguish to the casual reader that this is dealing
> with a file_lock object. I'm happy to respin the set if that's the
> consensus.

If it's just a rename then just point me to a branch I can pull. I don't
think it's worth resending just because you effectively did some variant
of s/lock_*/filelock_*/g

In any case, folded this one.

