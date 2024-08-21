Return-Path: <linux-fsdevel+bounces-26451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EC195957E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 09:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9AC71C21640
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 07:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B38166F29;
	Wed, 21 Aug 2024 07:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="kBxW1OsG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912CE1A2868;
	Wed, 21 Aug 2024 07:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224566; cv=none; b=o4mk6rsnGVUVzZXYR1xN8ZoPy52EGvxZfHrfswEvMMAENmRWBR75cB6tLsDBV7L5Zv6yEBHcOROmt99mSKu0tY9Zc+8UkBs8lrvBSnL3RQLnDlXScKDxCdk+98LId10mYqFNLL6gM21fV2s//LhSp15CbxkEafJWglnmmtdsY8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224566; c=relaxed/simple;
	bh=gGa8aDchR6P35xmEhYkIohAWzHWpKhSYViKdBUb5fSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHYqrKI4rPA6o0HU+dR+Hj1aZmisI0Ja61oWWlt6oKnkewY4iU5cF6POUbr6IbyicEdCrARpsZsmktGCCyDrXCb72JhxSOqzrOjV1T9IfzZePqTG7pTJhyiwvpyVBdDQfs8DklURI6xNB2EtSMIixz+94dBnENUKioCfp43Ooj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=kBxW1OsG; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Wpd0S5Lg5z9t63;
	Wed, 21 Aug 2024 09:15:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1724224552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rYduLHKa0UHntXi/4itA9oNRT2pbqE6hHxbM6/MwnOA=;
	b=kBxW1OsGM38Idead3+WnZ9Z5SBYYwxcEKeB6IXQ+T2Po00kcJxg2GozC7yxon/8hEC3Hqf
	HwwfF3xGe7m8KuAne9mcpU/rUiOtNnZXh5ZEVRVVggUipkOPl3O6X4BGOlg/VwqB8P7tKS
	ZW5yvXOMqrfzIvZBwZ76sbYKig8uYddGLTpWTBSEiHKChB7zk9M/0M0pog3AXBaXenU0SN
	vUHgB0lZCu0SYeiklp49XQ+eGj6dVaqPxNMAhS5wrCZCDa0X5oYAkS9BoqteNARNVWCYG2
	+oRPW2jnmZfb8LYdg7FaLjv5CgHR1OSEm+tiOzxKErnqhqIaYWiRJulpcknyFA==
Date: Wed, 21 Aug 2024 07:15:46 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: David Sterba <dsterba@suse.cz>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] Documentation: iomap: fix a typo
Message-ID: <20240821071546.isbpc2smmjhooetj@quentin>
References: <20240820161329.1293718-1-kernel@pankajraghav.com>
 <20240821000525.GM25962@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821000525.GM25962@twin.jikos.cz>
X-Rspamd-Queue-Id: 4Wpd0S5Lg5z9t63

On Wed, Aug 21, 2024 at 02:05:25AM +0200, David Sterba wrote:
> On Tue, Aug 20, 2024 at 06:13:29PM +0200, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > Change voidw -> void.
> 
> Tips for more typo fixes in the same file: fileystem, constaints,
> specifc

These are already fixed in fs-next:
9ba1824cc875 ("Fix spelling and gramatical errors")

-- 
Pankaj Raghav

