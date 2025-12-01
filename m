Return-Path: <linux-fsdevel+bounces-70349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 063D2C98041
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 16:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E7323A4759
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 15:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A9C32824E;
	Mon,  1 Dec 2025 15:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qX21gwbV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BEE32570D
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764602364; cv=none; b=Is8xZQ/N+PtTL4Kr9l1QEx68bax8plsA2wMrT5ppfrvIZn4xctAdtoMDw0R/LXcnLqv4faV/2oFZGTARN00XFmElJ1CMLIEUsa76eKCA86nK+lcGifx78OV4QfLTiTWOGQhQhXNqiyBC8ZytQESSBGzlnHlkd8z80INqQbG2lc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764602364; c=relaxed/simple;
	bh=IwNxJSKSn4llXK5OISyWoMenIWAcYAGrDa9vSiun4fc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TSDY/NMyo7p/FDXBjrXv8/OPRYJ/YWHKKsiA1/lU8hxctVavjBgeTLDfTcEAyI54FNJivBFA1Vzfl/B9O28tB8pRMyT9/feAol+vWG/8jfTsdR+RjBqkExHrkQmDoHjJ1Sfj08so4//IrmZGl8JfEfaQOonqCNYqjsxwpbZO5oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qX21gwbV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B34DC19421;
	Mon,  1 Dec 2025 15:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764602362;
	bh=IwNxJSKSn4llXK5OISyWoMenIWAcYAGrDa9vSiun4fc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=qX21gwbVvAlJj7JqlgyQPtTUg2OZvYWMe56MUaZX0gmFdfsZ5Jmk/RPlePNbWtMgb
	 YEHj3Mobnkcnek6h8NOoCmo4G1vzoXR2uihHblJ3/u4MVJGVQfdUAxDMUetv1UkOqO
	 o+BxS0aY18W8mq+U+DSFax46+pDaVRez+JtW5zPcESs+j7/DXXyoaUbKHJs6vm2OwU
	 mGFExM/jKOLICqwazhvlYCPgrMsQvbKrcLkAUlDYobN1qqCI/5BUcJP04f7vN3ho+r
	 NrrHoHezGlu2BbbUYX3I+dHq3neNmTPdmH2jDcWFOH/4GebCCk5bdJqW52XMwYGtMX
	 BM8t7VtLl0BCA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2A200F40074;
	Mon,  1 Dec 2025 10:19:21 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 01 Dec 2025 10:19:21 -0500
X-ME-Sender: <xms:-LEtaWiRqJ86wxHZdFXc8DrGTYLtYVQpUdx023aRhRORs5Md-5EY6w>
    <xme:-LEtaR0t2IQJyl8KHspJJXazUfW6TsJ3c0UBOpJrClZQGidUPGSFbGG8nbfHkp5P9
    k4Liw41c0E3LbP1xlYJx2Wm8t0uKK-QSd-3_yOTwmom3-ZoKLpNOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheektdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtoheprghlvgigrdgrrh
    hinhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggr
    ugdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhrsggv
    theslhifnhdrnhgvthdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtghomh
    dprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphht
    thhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:-bEtaZg8iPosgqQYE-cNJr32xngGeKhpAMOK5r1pQjd1d2lVN8Cmdw>
    <xmx:-bEtaaUmFGxK5ryZXqrvt7D5vSGuQ9qazT1p7aJG6NB5mJnOTrcEpQ>
    <xmx:-bEtaatUXo_mR7q4-pmpkHRVKjjRSYTTkkSZLzh8vKb4kXcDsQEp0g>
    <xmx:-bEtabZtJGxQVPJ2ATo2IGVP8SI6K_3xxXOCf8gwqoJBJeekDmcOKA>
    <xmx:-bEtab7WvYDIfDcUQ19XYxnCBZkUwXPr3-T-knp-8Vv5xJD1bs7SclwU>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D6B63780054; Mon,  1 Dec 2025 10:19:20 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aw9RNCMXdYSN
Date: Mon, 01 Dec 2025 10:19:00 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Alexander Aring" <alex.aring@gmail.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Jonathan Corbet" <corbet@lwn.net>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org
Message-Id: <78e50574-56f3-42e6-a471-c2dba4c7f1ad@app.fastmail.com>
In-Reply-To: <20251201-dir-deleg-ro-v1-0-2e32cf2df9b7@kernel.org>
References: <20251201-dir-deleg-ro-v1-0-2e32cf2df9b7@kernel.org>
Subject: Re: [PATCH 0/2] filelock: fix conflict detection with userland file
 delegations
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Dec 1, 2025, at 10:08 AM, Jeff Layton wrote:
> This patchset fixes the way that conflicts are detected when userland
> requests file delegations. The problem is due to a hack that was added
> long ago which worked up until userland could request a file delegation.
>
> This fixes the bug and makes things a bit less hacky. Please consider
> for v6.19.

I would like a little more time to review this carefully, especially
in light of similar work Dai has already posted in this area. If by
"v6.19" you mean "not before v6.19-rcN where N > 3", then that WFM.


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Jeff Layton (2):
>       filelock: add lease_dispose_list() helper
>       filelock: allow lease_managers to dictate what qualifies as a conflict
>
>  Documentation/filesystems/locking.rst |   1 +
>  fs/locks.c                            | 119 +++++++++++++++++-----------------
>  fs/nfsd/nfs4layouts.c                 |  11 +++-
>  fs/nfsd/nfs4state.c                   |   7 ++
>  include/linux/filelock.h              |   1 +
>  5 files changed, 79 insertions(+), 60 deletions(-)
> ---
> base-commit: 76c63ff12e067e1ff77b19a83c24774899ed01fc
> change-id: 20251201-dir-deleg-ro-41a16bc22838
>
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>

-- 
Chuck Lever

