Return-Path: <linux-fsdevel+bounces-17730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4708B1E94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 11:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4984F1F21606
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 09:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8004A85261;
	Thu, 25 Apr 2024 09:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRSF8eRX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA7D84FD0
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714039040; cv=none; b=htxto6Nz/n6Qu/rxjQUuDpBrTGU3bO0DMQ2YUxt9A6urnd8CYGGFHMyeUBXzVJpAC4x8D0umfCXn6pjCffKJvJ/xfyJ/DWo1Z1kjWOPetr/PU80ET21xjQtS8kMH+bNVzZ0IO/nPs93TGcvQrTmhp6zstHPDUnRrXJhCGte8rAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714039040; c=relaxed/simple;
	bh=dEUdLTc7VN5/vdVfVti7fJ2BWWpcvxeXkPQ1nYNjFyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1dC+ZrH19dpwrBNbs+zSb/Ju1uI9ZnhhcZXMwj+mhaSxxsjfRipyJwgEP2FMG61EtSRzMJP6fBak2W/rCY7lyqHZMk+iOcEtYhtz3Ditn9Ra18V2cnX9ByaLVLdsiLikOl4y1vRHTpabnUUb9r3iBeLchJabDXS5NW31fCO3dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRSF8eRX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED84FC2BD11;
	Thu, 25 Apr 2024 09:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714039039;
	bh=dEUdLTc7VN5/vdVfVti7fJ2BWWpcvxeXkPQ1nYNjFyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qRSF8eRXrMgFgxonXkUgIybFjnvCH3Yro9lw/fbyv91sz8fXFW/2b1MbbEkharzGX
	 irsOs3rOjGxOA9twNl6FgdpoSBltJzjuaMVeyaTeTSVPH3t9IulwKft89EalYpb7cD
	 JByYn0XCyF1TeaGTF0kbJQoNuEiB9q0LOLb1CkT26t8iTmfH9H/kp6lAeUaQGTHrO+
	 qB9AnmIL9qV26DqHPSIMWJYLSdTnRM9IycT1mWCEH6MxBQpLIc732YjhyrcLH9zWxQ
	 +8fTb0XLk2cQrh5ibO04D7WqCHyDX2uultoEFDvXc+8UBq2uH5bTTGCSnztICxQTuo
	 s1aTVzGyv+7KQ==
Date: Thu, 25 Apr 2024 11:57:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: Dawid Osuchowski <linux@osuchow.ski>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz
Subject: Re: [PATCH] fs: Create anon_inode_getfile_fmode()
Message-ID: <20240425-wohltat-galant-16b3360118d0@brauner>
References: <20240424233859.7640-1-linux@osuchow.ski>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240424233859.7640-1-linux@osuchow.ski>

On Thu, Apr 25, 2024 at 01:38:59AM +0200, Dawid Osuchowski wrote:
> Creates an anon_inode_getfile_fmode() function that works similarly to
> anon_inode_getfile() with the addition of being able to set the fmode
> member.

And for what use-case exactly?

