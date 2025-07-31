Return-Path: <linux-fsdevel+bounces-56368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB295B16D0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 10:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E0B26208A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 08:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DB92BCF73;
	Thu, 31 Jul 2025 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdchgMST"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4BA29E0ED;
	Thu, 31 Jul 2025 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753948860; cv=none; b=JlmMK29kVeJgn4ekWGiioCXMP1D5H+A/py3/HYrPkk37j20PYff6GNdwHW6KdD04YHcmaJ8BILY57VyvpvLYq0Ko5NbFnzvOy0eVKzVUYSB1UrzGeLZMJtpbk78eD9nXFciskIxGFn0zjh6C2flsyNwpvZ1CPz1Ey8Rx9ZK313c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753948860; c=relaxed/simple;
	bh=imchy0Ts9SnNMJEOcEBHK5I1y7SMY3izMmb6HMsDv2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXRy0nv6oj+H4+C8+sBCI/bBYe4S+ctSl3dPqSQRfeQCcjpXxgFhKAlkW4ZDjuGGA2CfNArqTrFKG2WHCYk/rk+DNwdLayCaIysUZvbGpI/5ZaWMrfNvQoJrkX/kXRVGNcuCTUzC85Gubgnq8OMa/MAnngIgHKBLKwyaVK9W4Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdchgMST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B18C4CEEF;
	Thu, 31 Jul 2025 08:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753948859;
	bh=imchy0Ts9SnNMJEOcEBHK5I1y7SMY3izMmb6HMsDv2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BdchgMSTW07EtyIAB4HcS5LTrr/hHZrbKOthm4ylkGZ2R/42wXNs1XGp9i3fXI/X6
	 jmuwBPfMQdA9ELn//9CL0n7RXMofmQyrUg7qWu6bQqa5PU8hmohYDbCXhBwXA99IwQ
	 Pp00SL27OsaOkMAwtCkDUeDmyx2Mvkz97n+5oAHWlVOcL5BqcUA0WueUO90jR3tI3k
	 agEnUqpdYJUFqomcccHCmpQZoKm/cHJhiafMbTHeVKSUvOlwSU58ynwgR2fTt7n3re
	 BqRcagy+oyYKdINe4cHIoWSRvNxKfWkEgSGoIrUMarW/+f4Xbf0TUaxszNycuekcAk
	 AwqfEcfjiPmmg==
Date: Thu, 31 Jul 2025 10:00:55 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, Hugh Dickins <hughd@google.com>, 
	Klara Modin <klarasmodin@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Anuj Gupta <anuj20.g@samsung.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 11/14 for v6.17] vfs integrity
Message-ID: <20250731-einpacken-wachsen-e70f5ca7860c@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
 <20250725-vfs-integrity-d16cb92bb424@brauner>
 <0f40571c-11a2-50f0-1eba-78ab9d52e455@google.com>
 <CAHk-=wg2-ShOw7JO2XJ6_SKg5Q0AWYBtxkVzq6oPnodhF9w4=A@mail.gmail.com>
 <aIh9CSzK6Dl1mAfb@infradead.org>
 <CAHk-=wh2KaNHTs-gUa227ssG-pE8NMsaz3bg=asx--ntVJaqJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wh2KaNHTs-gUa227ssG-pE8NMsaz3bg=asx--ntVJaqJg@mail.gmail.com>

> Right. Which is why I put it in the default: branch.

Thanks for fixing that up!

