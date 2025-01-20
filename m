Return-Path: <linux-fsdevel+bounces-39632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0106A16491
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 01:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8E91885251
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 00:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE98EC0;
	Mon, 20 Jan 2025 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxBDBkSI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FF4193;
	Mon, 20 Jan 2025 00:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737331859; cv=none; b=EjyVD4r8uars8qSYOB0d6PdwGu+2L51e7WoEnH7rM1T8tnwwUcVmLkt8WXgFhdskOzZ1NksAyIoc9AA4cCWMyS4MMa5xU8NJqw5w2NlUQ2g+5qYvpwyHDj2XhsaMQvVet8PIN7TrzALLVE08saWqiUuBVt2A1IdWoRqQwnbh4QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737331859; c=relaxed/simple;
	bh=oI3+ZqWvqIZ+S0h7RvwIJFYmsWR0eMOga1fCGFif37k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJXkjXgYk24e4v4kryQOgh+/ttD1CbOE/23tlkoPZkEGVzp/x/tMnp2fEntZU3kXXdykN5E3XEw9CfF3NkWI0o4suy8PbsTySnqrJL0uCxD36CSiYu/rKBl2XHL0fxKVAEDMAYy4M3yv2IpSnCty8Si8iswMmTFsKCqclcgYm4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxBDBkSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BC2C4CED6;
	Mon, 20 Jan 2025 00:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737331859;
	bh=oI3+ZqWvqIZ+S0h7RvwIJFYmsWR0eMOga1fCGFif37k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NxBDBkSIY3crEWgljUDZPwarGhQY4Bzx2FKfJlQZMlD9TM/dXQmM0cKUj7bOw24B0
	 PFscdqRvBhoMXlpL887f19QFv54Z6SAq4dsa0kEhW7qNB3kbHXjDhXAxHX9iXPz7ng
	 jPc9ELb5rreSHcz3jA7NHII8NwpkDp6FhVu49jbeJhJ+FEBHGar2GXrWV470GU9jOf
	 9Bf04j0vznUOKmLKk/9JJK1FqXg9IsTAD+07HGcTd5KjQen3IPZPIqy7Rrp9zibhAa
	 N5Wdx//RMRtOpcIOKYK/pVXKYGacXm0yPs6Xb1AleUd7qX7U64+nlMlzmNzeGOEFRT
	 Sw+B9ItC9THWA==
Date: Sun, 19 Jan 2025 19:10:57 -0500
From: Sasha Levin <sashal@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs mount
Message-ID: <Z42UkSXx0MS9qZ9w@lappy>
References: <20250118-vfs-mount-bc855e2c7463@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250118-vfs-mount-bc855e2c7463@brauner>

On Sat, Jan 18, 2025 at 02:06:58PM +0100, Christian Brauner wrote:
>      samples: add a mountinfo program to demonstrate statmount()/listmount()

Hi Jeff, Christian,

LKFT has caught a build error with the above commit:

/builds/linux/samples/vfs/mountinfo.c:235:18: error: 'SYS_pidfd_open' undeclared (first use in this function); did you mean 'SYS_mq_open'?
   pidfd = syscall(SYS_pidfd_open, pid, 0);
                   ^~~~~~~~~~~~~~
                   SYS_mq_open

The full log is here: https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.13-rc7-511-g109a8e0fa9d6/testrun/26809210/suite/build/test/gcc-8-allyesconfig/log

-- 
Thanks,
Sasha

