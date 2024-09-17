Return-Path: <linux-fsdevel+bounces-29592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7742A97B2E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 18:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6E21F22CEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 16:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652FA17AE11;
	Tue, 17 Sep 2024 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyCjwLCq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B632CEAD8;
	Tue, 17 Sep 2024 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726589870; cv=none; b=ht0onuyuC0/YyLY0y8ePywTIELm45GFb1qdmrp3qa9NhqO2xBozqc2/NIMUEFcRqrzzrAKDuah9ubYXwAcSoDD7VyYvMWKgzpkqq6QWeeOREGiChRs1I+bKOKDmB5d5K2eTbpjbVgxm6VHku7ep5rlrpwaFjq9wupfRflA/Aqmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726589870; c=relaxed/simple;
	bh=Fde4tQ60ARzFi5SdhVg3Yi37RsHI/jYiXHtBhnQ2RGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEiM+em6t9ZeajW1gi6X6oK8syqKiby36qp1vIo8DRX9Wg/TlrdvxbcXHtkK4nIlz73hVGatax6tmvCVcmzJEmL2jJFhBYq5VN5w5KqWhJxU04wyb9X7IBeAFUy0Urh1DJzrCk7Rw0U4629uEba5roYRZClHtVIq/0VJipfaX28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyCjwLCq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38094C4CEC5;
	Tue, 17 Sep 2024 16:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726589870;
	bh=Fde4tQ60ARzFi5SdhVg3Yi37RsHI/jYiXHtBhnQ2RGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LyCjwLCqqg7NyXv8mmG2nYZkLPi/p72KVZ9kD0OSFukcS44Amq103C/N+utE/VvG8
	 3yWsHTLSnoh2pLU6BFJWIeu5RX3iAsPOHr+iSraRBSYv46TbJmEf1UvQV3QFNgvmHo
	 11zhUmeRzyoVvVgPmWHNrDH1imfDpNnYtgb2d5R6ymOHGr0ZP0JgKVlCEllOBbd5Pm
	 LzdBW1jQSdWHHvtv4sS9h+OSztLhbz63CwGjXqkXxZDrM42rXfh5aMmt1RSZYIaWgT
	 2rm9bcbI2oGKLXCB42NFAcQOzGZAE4jM0C8Uyk4mZg2X7/z1jIZkjJS3m8KJ/kvqFd
	 5HuAzTs0DjKKA==
Date: Tue, 17 Sep 2024 09:17:49 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Dennis Lam <dennis.lamerice@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: Re: [PATCH] docs:filesystems: fix spelling and grammar mistakes in
 iomap design page
Message-ID: <20240917161749.GD182218@frogsfrogsfrogs>
References: <20240908172841.9616-2-dennis.lamerice@gmail.com>
 <20240909-frosch-klumpen-dbaee12c22d6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909-frosch-klumpen-dbaee12c22d6@brauner>

On Mon, Sep 09, 2024 at 09:53:28AM +0200, Christian Brauner wrote:
> On Sun, 08 Sep 2024 13:28:42 -0400, Dennis Lam wrote:
> > 
> 
> 
> Applied to the vfs.blocksize branch of the vfs/vfs.git tree.
> Patches in the vfs.blocksize branch should appear in linux-next soon.

I don't know if it's already too late, but if it isn't:
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.blocksize
> 
> [1/1] docs:filesystems: fix spelling and grammar mistakes in iomap design page
>       https://git.kernel.org/vfs/vfs/c/b1daf3f8475f

