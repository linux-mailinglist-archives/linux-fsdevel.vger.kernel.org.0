Return-Path: <linux-fsdevel+bounces-29593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DAA97B2E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 18:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBAF283E82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 16:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527E817AE11;
	Tue, 17 Sep 2024 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jG6DhWt6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A532516087B;
	Tue, 17 Sep 2024 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726589980; cv=none; b=b7YMsKj7ADvaSNOfjd6LES7bWSKjIpmYYWTLsB26gggT+GUrn1JdpbTQXhHK0gN1NGQKwtIAI2UBP0CwldIxV/1Bt/lfCfcS01g/MSx97zFRa+z5SCVCbjv6LfJ5Q/pWpP0mmR6XwtlRYwteKqbnycJmikJjQoj6rCko/OiyhRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726589980; c=relaxed/simple;
	bh=NN9m8NfqK3If83ueuNG5dcHBTu5/SNVFoZo04xRw6b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QA4WMOX1yCm6dF73UHUmrQw7YPXXRepAKYaF4FtYxQepr40WnnYq54EYhMf3A9q7ZlTYpK5sFqhRHPM8Z6PXEcq9vQs4EWLFwfvajTOELmAnOTzDPe9K5A0k8lwpyumRUqEL1TT6E1kL0BKa7gbNkV9AuItJzd/ZAM9/hMJ/cKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jG6DhWt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262EBC4CEC5;
	Tue, 17 Sep 2024 16:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726589980;
	bh=NN9m8NfqK3If83ueuNG5dcHBTu5/SNVFoZo04xRw6b8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jG6DhWt6w0s07Ozk0gztKd3I50b9LzszgG8/smjqdA6BFBkj4JXa/9RPFKL96W+m3
	 I3BUTVGeANrKokdqRr7W0eotKeBCq4PekWuPvZBdLvMaAW3ZDBxZqD7OBYrCJyEMGn
	 hlrJ+O/E67EM/Pv0macAnpgIWLiC7BPnMQs5i7gs6xALOU0r2OzJH0itg0qe1+BnX2
	 1yiwTkAmlpeA3jbcz/Eqghi/Q3x+UmlEcUfLKQ/tD1635P/7O6liAkRIWa4H1S+jsP
	 NuFbCAv+1Xegi2lqlizO6lc+iXwRi3gme0gS1uwc/E6s8Tsi0aMYX7ZDCYYRivDnUV
	 idRfyUFn87nyA==
Date: Tue, 17 Sep 2024 09:19:38 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: iomap: fix a typo
Message-ID: <20240917161938.GE182218@frogsfrogsfrogs>
References: <20240820161329.1293718-1-kernel@pankajraghav.com>
 <20240912-frist-backfisch-a5badbdd5752@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912-frist-backfisch-a5badbdd5752@brauner>

On Thu, Sep 12, 2024 at 02:07:39PM +0200, Christian Brauner wrote:
> On Tue, 20 Aug 2024 18:13:29 +0200, Pankaj Raghav (Samsung) wrote:
> > Change voidw -> void.
> > 
> > 
> 
> Applied to the vfs.blocksize branch of the vfs/vfs.git tree.
> Patches in the vfs.blocksize branch should appear in linux-next soon.

Looks correct to me,
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
> [1/1] Documentation: iomap: fix a typo
>       https://git.kernel.org/vfs/vfs/c/71fdfcdd0dc8

