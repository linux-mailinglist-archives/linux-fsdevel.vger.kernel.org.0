Return-Path: <linux-fsdevel+bounces-22354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA05A916908
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B9C81F28B75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 13:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF71715FA8A;
	Tue, 25 Jun 2024 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bi3S/THY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1B8158A03
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322521; cv=none; b=Llql/+Faehk5AT3KmHNKfRV9j+pgHrvQCRJUARCqDVL3d5FqIftdbMDZbw7wa/QP5Mg9M0Eacef6J8NIK6VbPH4gQt3CGwc2pHFC5lPgogHWZK8o0oGTU6T96RN5DFFB6dNqtk0tjsBXeoI798rAMRo28VcqbCDn5pRr6st2+SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322521; c=relaxed/simple;
	bh=KMdy91uKputWU2twb5nzi2YXMNDuIeLpAJpKLxCGtek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1woTOxFyMsr4HBFAPBfJFx+aate7USdSMyZBD+HoYXedfCH2h4VjQRmSzgWQTWLKgTdkZSNj6uNA0R9MI4qjoJknpBs9v74Sda0TGDZABt45MTAttKUbWrccPk5dRABuM4r0pIc2V84Y9Q4PT9bmI4DiWoR3NoVoa+KC2OTBOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bi3S/THY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F573C32786;
	Tue, 25 Jun 2024 13:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719322520;
	bh=KMdy91uKputWU2twb5nzi2YXMNDuIeLpAJpKLxCGtek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bi3S/THYzceW/Cje4nA6lReRcOaQYOISdjpCX/Ba0dL34rCH8OqI78dNx6VOUODyP
	 IWYQKlKgVJYWEjeKamfk0M0e80AKyA9ix1CDuS0G9OV5sM2VZ12dF3UR0ZnbZzy4ff
	 W0e6aWR6V+lSSq9LXjorGq+TvMuLhKpcExCG+rVVMUYS1l2u7Pl4Zztp0uvDvmtnxx
	 LNbAq/eyNwe7XUxPjWjhthCZ+KDmro4YKdQpkTP2R2PKeiZVE3kbgWIxuymb1/mPlz
	 9Sl72dZiqWTdZ0myKckFCtatsLzdh2P7CgnNmD37eHaQATYhph9p3owINUc3SEIxg4
	 HpdUUV9Jz/s/Q==
Date: Tue, 25 Jun 2024 15:35:17 +0200
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	kernel-team@fb.com
Subject: Re: [PATCH 0/4] Add the ability to query mount options in statmount
Message-ID: <20240625-beackern-bahnstation-290299dade30@brauner>
References: <cover.1719257716.git.josef@toxicpanda.com>
 <20240625-tragbar-sitzgelegenheit-48f310320058@brauner>
 <20240625130008.GA2945924@perftesting>
 <CAJfpeguAarrLmXq+54Tj3Bf3+5uhq4kXOfVytEAOmh8RpUDE6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpeguAarrLmXq+54Tj3Bf3+5uhq4kXOfVytEAOmh8RpUDE6w@mail.gmail.com>

On Tue, Jun 25, 2024 at 03:04:40PM GMT, Miklos Szeredi wrote:
> On Tue, 25 Jun 2024 at 15:00, Josef Bacik <josef@toxicpanda.com> wrote:
> 
> > We could go this way I suppose, but again this is a lot of work, and honestly I
> > just want to log mount options into some database so I can go looking for people
> > doing weird shit on my giant fleet of machines/containers.  Would the iter thing
> > make the overlayfs thing better?  Yeah for sure.  Do we care?  I don't think so,
> > we just want all the options, and we can all strsep/strtok with a comma.
> 
> I think we can live with the monolithic option block.  However I'd
> prefer the separator to be a null character, thus the options could be
> sent unescaped.  That way the iterator will be a lot simpler to
> implement.

For libmount it means writing a new parser and Karel prefers the ","
format so I would like to keep the current format.

