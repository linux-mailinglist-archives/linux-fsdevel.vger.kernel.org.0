Return-Path: <linux-fsdevel+bounces-58269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E638FB2BBED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 10:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 250667ABA2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 08:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5132E31197E;
	Tue, 19 Aug 2025 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7fLOiQZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF2921E0AF;
	Tue, 19 Aug 2025 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755592301; cv=none; b=IErlZTB8bkzTdCbInUkGv5TAZhD6zNotG4IG1CSt9mf74jHSg/TVun8wzS89atzGINjvJQ6Eg09S66zjRtE/nmIi+DWta7fTR1Wc4r1OcbhBjv4ah4rIFod83FEOJACQ+neYQ5Hr0q9sSej/TlqtYAnuJO84lSBun3Y8qhNAWT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755592301; c=relaxed/simple;
	bh=DxelWhy5hDQpc0aZeuCVaZ0ZCTV9nheucJbyLDE27Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+LP/5W/R+LpJpQEtjRLEquA0micDF8iPz5bprbLgPNIDlRHup2WenH+D2TjIZ5YpTHyZ50JkrWhCTWzR/wz6IrFGLdFv32AfH4+XXq9mE4MXYV6CBrMNDeK+/V2kx3Is6f1HqE26MB0xsnPkUwlNB6r3TmOnTfwjyDOhg4/4k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7fLOiQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B627C4CEF1;
	Tue, 19 Aug 2025 08:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755592301;
	bh=DxelWhy5hDQpc0aZeuCVaZ0ZCTV9nheucJbyLDE27Oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N7fLOiQZN4RryRTMzTZTa6VTkpIwICJfLFrnzqT/5qY+DWGF/q3Q+CNSngDsVCgzl
	 FliIrPo0z5ArDLLrTL20aM4aIzzH2AXCH1TEi7zEAzfbfBCF2VP8nFL/D8LHXLHHYs
	 6cupCP2EL5V2+1eLm7ndU1g6aIyok6zk8GxwSYr/qrMnNll7CZoaVOA+18wqugpsK3
	 oGfAmGYK51QnpN/6IiMBPTSXicvAfL+xiVMz//8/oLcBE3JbVRsTxOdutESOp5+WGc
	 tFrbvgkUgjSbNBLRnldg6ftaCwow9OGbDh2NU5mqPz2T8n5KmyDOpZHpStKBVpuggs
	 Wak4fMNkDD0LQ==
Date: Tue, 19 Aug 2025 10:31:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Askar Safin <safinaskar@zohomail.com>, alx@kernel.org, 
	dhowells@redhat.com, g.branden.robinson@gmail.com, jack@suse.cz, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-man@vger.kernel.org, mtk.manpages@gmail.com, viro@zeniv.linux.org.uk, 
	Ian Kent <raven@themaw.net>, autofs mailing list <autofs@vger.kernel.org>
Subject: Re: [PATCH v3 00/12] man2: document "new" mount API
Message-ID: <20250819-erhitzen-knacken-e4d52248ca3e@brauner>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
 <20250817075252.4137628-1-safinaskar@zohomail.com>
 <2025-08-17.1755446479-rotten-curled-charms-robe-vWOBH5@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025-08-17.1755446479-rotten-curled-charms-robe-vWOBH5@cyphar.com>

On Mon, Aug 18, 2025 at 02:16:04AM +1000, Aleksa Sarai wrote:
> On 2025-08-17, Askar Safin <safinaskar@zohomail.com> wrote:
> > I noticed that you changed docs for automounts. So I dig into
> > automounts implementation. And I found a bug in openat2. If
> > RESOLVE_NO_XDEV is specified, then name resolution doesn't cross
> > automount points (i. e. we get EXDEV), but automounts still happen! I
> > think this is a bug. Bug is reproduced in 6.17-rc1. In the end of this
> > mail you will find reproducer. And miniconfig.
> 
> Yes, this is a bug -- we check LOOKUP_NO_XDEV after traverse_mounts()
> because we want to error out if we actually jumped to a different mount.
> We should probably be erroring out in follow_automount() as well, and I
> missed this when I wrote openat2().
> 
> openat2() also really needs RESOLVE_NO_AUTOMOUNT (and probably
> RESOLVE_NO_DOTDOT as well as some other small features). I'll try to
> send something soon.
> 
> > Are automounts actually used? Is it possible to deprecate or
> > remove them? It seems for me automounts are rarely tested obscure
> > feature, which affects core namei code.
> 
> I use them for auto-mounting NFS shares on my laptop, and I'm sure there
> are plenty of other users. They are little bit funky but I highly doubt
> they are "unused". Howells probably disagrees in even stronger terms.
> Most distributions provide autofs as a supported package (I think it
> even comes pre-installed for some distros).
> 
> They are not tested by fstests AFAICS, but that's more of a flaw in
> fstests (automount requires you to have a running autofs daemon, which
> probably makes testing it in fstests or selftests impractical) not the
> feature itself.
> 
> > This reproducer is based on "tracing" automount, which
> > actually *IS* already deprecated. But automount mechanism
> > itself is not deprecated, as well as I know.
> 
> The automount behaviour of tracefs is different to the general automount
> mechanism which is managed by userspace with the autofs daemon. I don't
> know the history behind the deprecation, but I expect that it was
> deprecated in favour of configuring it with autofs (or just enabling it
> by default).
> 
> > Also, I did read namei code, and I think that
> > options AT_NO_AUTOMOUNT, FSPICK_NO_AUTOMOUNT, etc affect
> > last component only, not all of them. I didn't test this yet.
> > I plan to test this within next days.
> 
> No, LOOKUP_AUTOMOUNT affects all components. I double-checked this with
> Christian.

Hm? I was asking the question in the chat because I was unsure and not
in front of a computer you then said that it does affect all components. :)

> 
> You would think that it's only the last component (like O_DIRECTORY,
> O_NOFOLLOW, AT_SYMLINK_{,NO}FOLLOW) but follow_automount() is called for
> all components (i.e., as part of step_into()). It hooks into the regular
> lookup flow for mountpoints.
> 
> Yes, it is quite funky that AT_NO_AUTOMOUNT is the only AT_* flag that
> works this way -- hence why I went with a different RESOLVE_* namespace
> for openat2() (which _always_ act on _all_ components).
> 
> -- 
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> https://www.cyphar.com/



