Return-Path: <linux-fsdevel+bounces-66804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BFFC2C804
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 15:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33B964ED549
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 14:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27B0334697;
	Mon,  3 Nov 2025 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePqVIqG4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D689333745;
	Mon,  3 Nov 2025 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181629; cv=none; b=iXAb7oHssuL1jAo4XkBmO7ccIEikdXMJiHFU+F4oBq/pxaLVV1btSHD7FBA357IZ+Mii7T9I4/XXN2ko2Ll4XCPYC9p2mN2WdmX10uvGXpW7NH8vRzt8C78tv6p52YKo8OvV6noL1dEs9CxUKCOYBrzG8KN5T8iMAfy0TwvvU0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181629; c=relaxed/simple;
	bh=Ri6OYBYHckwm0+mp0un6shuRJsNaNIpkth772AmzDvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rz39s2adcdGPJFFZcGW2+nbAuwBmUDCSvKYN7lov+ThYtthjUqWtgqdt6PxQkJkPJN+18T6J6hRtH0GoepShwxJ/cy8xhOYV/WmYxSIfKkjZNMqJJ9X5TCYeeJ2WItSltPHS4Ef67RSP9d129nMXRUWEhd3SLKVZFVr7eJqV83Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePqVIqG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10D9C4CEE7;
	Mon,  3 Nov 2025 14:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181626;
	bh=Ri6OYBYHckwm0+mp0un6shuRJsNaNIpkth772AmzDvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ePqVIqG4hgdozY8I2Dt8f9GBLcNVnwR0Jgb3e3j7tGtxsgJpAH8iLGHXZyk9mpAE2
	 jH8KR23qmbyXMGzJG1SLbp3KTRDsxctPEu6L3NIFpuAcPkWBTlBCHA44h963/Zp9MY
	 cVMe/ZnwEOW71v+qasSEqLSoboeasIJTn6N0ZNjv3h9e9Wq8wnThxxTQq7z5LVg7Yt
	 FNHNeOAuFOhl1xoFkYg33SiMz9z8Lxyu1iChCLxLP8a3Zsr2IkEjjO65wX+iamxuVV
	 c6iv3khLyHyPmgNaDWT5k4N3doojjX49b95YAjOQvyDZ7EJMDC5v3M1lyWS+apD6ql
	 hqi0UoeJnpgGQ==
Date: Mon, 3 Nov 2025 15:53:41 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-aio@kvack.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 00/16] credentials guards: the easy cases
Message-ID: <20251103-studien-anwalt-1991078e7e12@brauner>
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
 <CAOQ4uxgr33rf1tzjqdJex_tzNYDqj45=qLzi3BkMUaezgbJqoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgr33rf1tzjqdJex_tzNYDqj45=qLzi3BkMUaezgbJqoQ@mail.gmail.com>

On Mon, Nov 03, 2025 at 02:29:40PM +0100, Amir Goldstein wrote:
> On Mon, Nov 3, 2025 at 12:28 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > This converts all users of override_creds() to rely on credentials
> > guards. Leave all those that do the prepare_creds() + modify creds +
> > override_creds() dance alone for now. Some of them qualify for their own
> > variant.
> 
> Nice!
> 
> What about with_ovl_creator_cred()/scoped_with_ovl_creator_cred()?
> Is there any reason not to do it as well?

No, I don't think there is other than that the complexity of it warrants
a separate patch series.

When override_creds()/revert_creds() still was a reference count
bonanza, we struggled with two issues related to overlayfs:

(1) reference counting was sometimes very non-obvious
    (think:
    cred = get_cred(creator_cred);
    old_cred = override_cred(cred);
    put_cred(revert_creds(old_cred));
    put_cred(cred); or worse )

    and thus the credential override logic when creating files where you
    change the fsuid and you essentially override credentials _twice_
    lead to pretty twisted logic that wasn't necessarily clarified by
    the scope-based semantics.

    This problem is now resolved since my prior rework.

(2) The scope based cleanup did struggle in switch() statements that
    messed with the scope-based logic iirc. I don't have the details in
    my head right now anymore but basically this is why we originally
    punted on the original conversion so we wouldn't end up chasing bugs
    in two semantic changes done at the same time.

    I think we're ready to do (2) now.

What I tried in this series is to reduce the amount of scope switching
due to gotos and that's why I also moved some code around. It also helps
to visually clarify the guards when the scope is reduced by moving large
portions where work is done under a guard out to a helper. That's
especially true when the guard overrides credentials imho. That's
something I already aimed for during the first conversion.

> 
> I can try to clear some time for this cleanup.
> 
> For this series, feel free to add:
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> 
> Thanks,
> Amir.
> 
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> > Christian Brauner (16):
> >       cred: add {scoped_}with_creds() guards
> >       aio: use credential guards
> >       backing-file: use credential guards for reads
> >       backing-file: use credential guards for writes
> >       backing-file: use credential guards for splice read
> >       backing-file: use credential guards for splice write
> >       backing-file: use credential guards for mmap
> >       binfmt_misc: use credential guards
> >       erofs: use credential guards
> >       nfs: use credential guards in nfs_local_call_read()
> >       nfs: use credential guards in nfs_local_call_write()
> >       nfs: use credential guards in nfs_idmap_get_key()
> >       smb: use credential guards in cifs_get_spnego_key()
> >       act: use credential guards in acct_write_process()
> >       cgroup: use credential guards in cgroup_attach_permissions()
> >       net/dns_resolver: use credential guards in dns_query()
> >
> >  fs/aio.c                     |   6 +-
> >  fs/backing-file.c            | 147 ++++++++++++++++++++++---------------------
> >  fs/binfmt_misc.c             |   7 +--
> >  fs/erofs/fileio.c            |   6 +-
> >  fs/nfs/localio.c             |  59 +++++++++--------
> >  fs/nfs/nfs4idmap.c           |   7 +--
> >  fs/smb/client/cifs_spnego.c  |   6 +-
> >  include/linux/cred.h         |  12 ++--
> >  kernel/acct.c                |   6 +-
> >  kernel/cgroup/cgroup.c       |  10 ++-
> >  net/dns_resolver/dns_query.c |   6 +-
> >  11 files changed, 133 insertions(+), 139 deletions(-)
> > ---
> > base-commit: fea79c89ff947a69a55fed5ce86a70840e6d719c
> > change-id: 20251103-work-creds-guards-simple-619ef2200d22
> >
> >

