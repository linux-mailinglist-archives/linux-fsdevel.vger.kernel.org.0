Return-Path: <linux-fsdevel+bounces-15313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4657888C107
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 12:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECDD82C7A01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 11:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6A46027D;
	Tue, 26 Mar 2024 11:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkSpmVMN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA525677D;
	Tue, 26 Mar 2024 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453414; cv=none; b=CtZLd9+dtcQaX5c0NIw5Oh4qXepVpm8Q6WRdUVDfFN1vI4j9frGaaaQcRllQMqueajXughwEFNnKrCbX67rPbnoHIF5FBTHoe6UKeLTr1JTFbU6hJxcaBt8xwYNdjqlv1UfYQGJ3DVgTqfOP281+3VajjdoQJltdCFk61RaBLbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453414; c=relaxed/simple;
	bh=yZ8PGm9pGHgURDAPAaNphQrONNLnTTecpSakMETCtBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVOBF93IocXI3Zvjt2JEgDrznrXQrFHtULbeDRxrMTdH7Q8ZNG8a0iUSjOIrJbe0FVBmW0uPvovVaLYsEjA3tms6euZF7PTfqdsSfZqWWlDrOakhxBU81+cl/vKo9RudLObL61U7dqRGv5aga6tr4oWbr8sFfT18wsrwfFMBkxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkSpmVMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81667C433F1;
	Tue, 26 Mar 2024 11:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711453413;
	bh=yZ8PGm9pGHgURDAPAaNphQrONNLnTTecpSakMETCtBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RkSpmVMN6OcFSmslNIo12zbQntLVSJQb8he4SpxtXUr0R+ZvxrTftivvDW6SpioFJ
	 UxmSnrvRHXilbhkWVYQoqFfaPyp7UVb74UHDE+UMYXFxR+u+AQCVbNRmsB/yKvfJEa
	 ZlEB+1bF78E6Bv+fQ7PRLPTBfJHForxfwTJVulDbUj714M7kH+muOzB+xEovo9FcG0
	 tF6ydwSsRLBUTP7c1Y1p3VFkUB1tSNfw8m+l8K0qLzzQKgef0w9+NEbcQPihqHxM14
	 3CXErA4nkMPy3TgQtk5MbVWJ1W5VyKPsCTC/336jyMlnqbtzURZxNqTZSXlVIQBZcd
	 Ft0KClht0pGRQ==
Date: Tue, 26 Mar 2024 12:43:27 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, 
	kernel test robot <oliver.sang@intel.com>, Taylor Jackson <taylor.a.jackson@me.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>, 
	linux-fsdevel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>, 
	fstests <fstests@vger.kernel.org>
Subject: Re: [linux-next:master] [fs/mnt_idmapping.c]  b4291c7fd9:
 xfstests.generic.645.fail
Message-ID: <20240326-dampf-angemacht-35d6993d67fa@brauner>
References: <202402191416.17ec9160-oliver.sang@intel.com>
 <20240220-fungieren-nutzen-311ef3e57e8a@brauner>
 <20240325165809.GA6375@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240325165809.GA6375@frogsfrogsfrogs>

On Mon, Mar 25, 2024 at 09:58:09AM -0700, Darrick J. Wong wrote:
> On Tue, Feb 20, 2024 at 09:57:30AM +0100, Christian Brauner wrote:
> > On Mon, Feb 19, 2024 at 02:55:42PM +0800, kernel test robot wrote:
> > > 
> > > 
> > > Hello,
> > > 
> > > kernel test robot noticed "xfstests.generic.645.fail" on:
> > > 
> > > commit: b4291c7fd9e550b91b10c3d7787b9bf5be38de67 ("fs/mnt_idmapping.c: Return -EINVAL when no map is written")
> > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > The test needs to be updated. We now explicitly fail when no map is
> > written.
> 
> Has there been any progress on updating generic/645?  6.9-rc1 is out,
> and Dave and I have both noticed this regressing.

Iirc, Taylor wanted to fix this but it seems that hasn't happened yet.
I'll ping again and if nothing's happened until tomorrow I'll send a
patch.

