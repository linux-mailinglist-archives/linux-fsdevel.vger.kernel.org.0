Return-Path: <linux-fsdevel+bounces-48729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35506AB33D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 11:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3854A3A4F73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 09:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA742571C1;
	Mon, 12 May 2025 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxgaierU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141C7433A0
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042537; cv=none; b=cwWeOT2U68Qi/iVCfFjeXaaeBhhiO3WAuEUxIROJQFfYA49Y63gurHvxdQT9YbYpBm2CUYcLqQVq4w1O9d4FR+x8lF52b/lp7b6NJPBEBZ2Z/3+YkfcQtNdh+RYppE4rJ1OO35xYmfEA6mysMsNUz2YL4tcoIV4F3s4xErOwsAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042537; c=relaxed/simple;
	bh=UiJh+LIaVumYaKFEt5IEwyYY3ihxb+K5ptfxStgET0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obD/PKdqMEXlNRHz1F7UKC1MXB7aqK9RZgifSuAe233rnUvPETvINpH3OkxRZxIfIhXK1tEtLR55KeWMdtaqpw9ZEDwZxfR3GWNXo3zF9jA30e83ZqXaQ02fw3d53vyOrG9iVLA14hXiFj2EeZybWnO7YPe7cDdurbg0LpRt1cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxgaierU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C15C4CEE9;
	Mon, 12 May 2025 09:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747042536;
	bh=UiJh+LIaVumYaKFEt5IEwyYY3ihxb+K5ptfxStgET0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pxgaierUJXYR/cVe8Wi12p5ZnSvdtUZZ4M3iMzwDB4RIuONL0GT9TAbSoGlOYewag
	 Du6zu+vuMqg2pryp2S5VDlO19udNmwmqZg09CTKpkxlHmqgjEBoGWcGz1qtRuSCBB/
	 FwbsxnoPSzPOsmom3lENPI4abKaF6M1OSm/ULw3ZKBHXBtmfnZ5f9z7ADR+4r6YET8
	 AKFEOSMHIgjyb0TcwHBOMBX+G3u+wFyWqfmQY3o+g8AJTyXsLp4GrSq4opd4US57Sa
	 kAiOhv5FmcOIR/qBVXDs7hTzeYZnzIXYiE4PVewoOhnYBFrnpwoNkVe3TLiDdxbKz2
	 spn8pmNTKsGxg==
Date: Mon, 12 May 2025 11:35:32 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] filesystems selftests cleanups and fanotify test
Message-ID: <20250512-wegdiskutieren-ausmerzen-c818d9018683@brauner>
References: <20250509133240.529330-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250509133240.529330-1-amir73il@gmail.com>

On Fri, May 09, 2025 at 03:32:32PM +0200, Amir Goldstein wrote:
> Christian,
> 
> This adds a test for fanotify mount ns notifications inside userns [1].
> 
> While working on the test I ended up making lots of cleanups to reduce
> build dependency on make headers_install.
> 
> These patches got rid of the dependency for my kvm setup for the
> affected filesystems tests.
> 
> Building with TOOLS_INCLUDES dir was recommended by John Hubbard [2].
> 
> NOTE #1: these patches are based on a merge of vfs-6.16.mount
> (changes wrappers.h) into v6.15-rc5 (changes mount-notify_test.c),
> so if this cleanup is acceptable, we should probably setup a selftests
> branch for 6.16, so that it can be used to test the fanotify patches.
> 
> NOTE #2: some of the defines in wrappers.h are left for overlayfs and
> mount_setattr tests, which were not converted to use TOOLS_INCLUDES.
> I did not want to mess with those tests.

So I added both wrappers.h and utils.{c,h} and I had always intended to
make them more widely available since quite a few things use them by now
and I'm probably the cuplrit here. :) So thanks for this work!

As a next step we should move all VFS/FS related tests from selftests/
into selftests/filesystems/. So if anyone has the time and energy for
this I will very very happily merge this.

