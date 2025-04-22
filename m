Return-Path: <linux-fsdevel+bounces-46880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C498A95C96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 05:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC3473B7437
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 03:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92A11A23A1;
	Tue, 22 Apr 2025 03:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhvLaeMb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002A210957;
	Tue, 22 Apr 2025 03:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745292827; cv=none; b=GUXOApsq8pQQ3DJMYEOdcTkJBPxRBO6FVf3hW0KndAyXLxSi/MSzuZBGVvdfpe98QAkNFDO2Cys45EUKt6cC5IS05mTn6BQ/vKfv+CAbeuc4EbKTJ12/rdwSiP3lRZjiahULw/xpRqg95Y3xrgLmRcSvLvwKjkhzbKhoo/00ijU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745292827; c=relaxed/simple;
	bh=bsrxz8JQDJMQD7CDVTi/eo2Ike9KwkzdRA+AmcENwbw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oyKt24WEgStnq0pKhqh+14M6WlwW1pfmtWccLGWw+o3mtK9iwtoT4uNPkl8cuWPKrn0kgRRDttsRJox6ulvkUjTaBFxDkHT07NJwvrbymhxVyTwnat4eqHTFKsVjxpaaQNqhmEVEoYQhAXxr2Wm88V/Hs/SQ8RGu0uJ7mnX4AK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhvLaeMb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B463C4CEE4;
	Tue, 22 Apr 2025 03:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745292825;
	bh=bsrxz8JQDJMQD7CDVTi/eo2Ike9KwkzdRA+AmcENwbw=;
	h=Date:From:To:Cc:Subject:From;
	b=qhvLaeMbLP2V4snldKObQir+gkyan8dzRIaSxAaTozgorUH8wEtI9vodboTk/vY4y
	 ap28qkmrzYHKWY1exiL++gGMiCke2UlMddH+Hi1HuKYVQSF/Zwg6aRnZWV3K/hVDFf
	 SxmLW0kefxQHvgU7WqlC9PCa2TCD5QC6PVbUUDqylFUnVXDJtZlyQ+Q8AHrqSFxZTG
	 aFmTpInvh/MXvpr2xOI5MOzTud7rpq/IPbRA4ro/dLxS/bsjGIDRrYLHuhBtIAJafJ
	 a36mZAjQb6Si2EC9Nx/F/fo5VWdwFMEMOn5OxRUoYW7VnL2e65pUJM9owkD0JAUygv
	 uR8TfRP5jxrbQ==
Date: Mon, 21 Apr 2025 20:33:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-block@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	netdev@vger.kernel.org
Cc: Zach Brown <zab@zabbo.net>, Matthew Wilcox <willy@infradead.org>
Subject: Call for Proposals for fossy.us 2025
Message-ID: <20250422033344.GI25700@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi folks,

I'd like to (very belatedly) invite you all to the 2025 fossy.us
conference that's being put on by Software Freedom Conservancy:

https://2025.fossy.us/

This is their third year of operation, and this time they've added a
track for Linux kernel topics!  Originally the track was going to be run
by willy and I, but he had to drop out for various reasons.  zab has
stepped up to fill the gap.

We're looking for people to propose sessions for the track.  These can
be informal presentations, discussion sections, or even a panel.  In the
past two editions, the attendees have ranged from technical folks from
userspace projects to free software advocates who operate in the
political and legal spheres.  I think the most interesting topics would
involve the kernel <-> userspace barrier, or technical deep-dives into
how do the more complex parts of the kernel actually work, but I
obviously have kernel-tinted glasses and welcome any strong proposal.

Anyhow, the CfP deadline is April 28th, so please lob whatever proposals
you have soon.  The conference is in Portland, Oregon (USA) at the end
of July, which ... I know is going to be problematic for a lot of
people.  This is a tough year for conferences (both planning and
attending) so if you have questions, please feel free to ask them here
or privately.

--Darrick (and Zach)

