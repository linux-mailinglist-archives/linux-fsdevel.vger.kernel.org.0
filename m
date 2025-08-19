Return-Path: <linux-fsdevel+bounces-58326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F0AB2CA53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 19:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B72B1BC7F42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 17:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB302FCC16;
	Tue, 19 Aug 2025 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aQj96f4B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418AC1FBCB2;
	Tue, 19 Aug 2025 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755623737; cv=none; b=QENjHEe6ztxbCQBPE0pYEYoHvtEk96Rwx3KaStS4vJfkBgjWDDAcdMGE3nSTTSWPxOJnRLLdffcw3Aw1pGzNpQR/3fcgKbQnz4L8HJk4eCqWBYBhRVcHyxfD4oqmdGom+ft3rExFg0paH38akJMHMPE8iwt6XZhb2uJY/hpsONo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755623737; c=relaxed/simple;
	bh=FrVxlvysfaGpfpuIjwk4vChk8v/bln7nN9IBkS9f5e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCRd6Yt6USEfZaOqSetJzVjJU2ywrHMPvb+kZnw2BEgwrIKhdsYPj2Som9VwTEpdZMyxS73lKu7LoqP5+iZnFIvLt7A0/Ada6duurs9T9XTvj73pZm73jdHLi6Y9bTFfVeYy5mMrT8CV/FnloT7zEqaKScjSQ5uiI2l8UiOu+co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aQj96f4B; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FrVxlvysfaGpfpuIjwk4vChk8v/bln7nN9IBkS9f5e8=; b=aQj96f4Bu12+dNYl6Jkujd8Al0
	s7k5w0UxLmPsVDjU7/0FhYEphkgXD77VmiQW31qWQ7uayAM8wICMfnwDhlIFTAJzcdNzTCC2AoJ5S
	Bo5ko3laoNb9gErYt4dKFYp+DWQbIvKxbmmY1mTQbH4dMZCNSaSXs0KB7YQ8/I0x4HEkyIwfHey+s
	nmQeUCu8Dxvc/QntJN7Iu1Unlm3ljuBOaCnalDkbwl8goTw44oe3tQVBRc/5LU0N0rQYldxZAf8MR
	rXKL/7fev2Pl90jOef2xLVT8b5ZsyOOSjrWB1vG8UKyo5OxioECJK/0qeOuu8zVOxqZ6gy9/7krDE
	7oqVmR3Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoPvo-00000000ccU-2CxA;
	Tue, 19 Aug 2025 17:15:32 +0000
Date: Tue, 19 Aug 2025 18:15:32 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Add missing parameter docs for name_contains_dotdot()
Message-ID: <20250819171532.GJ222315@ZenIV>
References: <20250819164822.15518-1-adelodunolaoluwa.ref@yahoo.com>
 <20250819164822.15518-1-adelodunolaoluwa@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819164822.15518-1-adelodunolaoluwa@yahoo.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 19, 2025 at 05:48:22PM +0100, Sunday Adelodun wrote:
> Fix kernel-doc warning by adding missing @name
> parameter description for the name_contains_dotdot()
> function.

See https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=fs-next&id=4e021920812d164bb02c30cc40e08a3681b1c755


