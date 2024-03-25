Return-Path: <linux-fsdevel+bounces-15200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B9688A412
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 15:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E811C3B285
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 14:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E7617A92C;
	Mon, 25 Mar 2024 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8lw9t2Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30791A0B16;
	Mon, 25 Mar 2024 10:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361514; cv=none; b=b4/To0+kqYniNBfUSPaJzy5tguQxof9rIBbLEF2K1Qmp6ehiqLE5AgRU4SQj1rPWgerMiG2ehKDhjZmZqko57i4ITIgDYJfORYurtpESMIzvM/QJibeh524Q0+LKpZspjndRtSxJRgVt/88vke/ugW/eVQzlLpAN9FPjuv0rWyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361514; c=relaxed/simple;
	bh=5DDCimfIF8GmFUhKkYwvklJYIym6PIG80Lg75iNgWmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQkYFUe0ICSjVbihcqBUbybdrakfyMtP48V3cAJyZA+lfOxwk2dt45Bb6kKnRQM+I9niuLfoCYz9Pw65mljAsYz9q6IQiDGy4lhWrjNRkgXFeOmwF2upity7pdEYdiI3fxz+KYKaB3e5z3Fl0Tt3pQa1sbz8lh+tL5QKpfdylrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8lw9t2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67773C433F1;
	Mon, 25 Mar 2024 10:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711361513;
	bh=5DDCimfIF8GmFUhKkYwvklJYIym6PIG80Lg75iNgWmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n8lw9t2QOlSwrp5YkyozPnMMAgWttY3Xo+7rfrZDAYVx21qZ+YcFFR8wpvLPrFNHX
	 tKOfte4vqXKXO1cu5shgs4niBN0+dJs+OcgsCagESxftMRBxwQ29GLd/RXRF68sT0J
	 qzq8yyaMjraJbv4x3LeZll6/j3wyG4aTW7eTH3wG8rvlfKgj98ew1wjFNJdIP1l8Kw
	 rLd7NsHPXYz5A1uxofGkDX+kZK9aURB6+UJcNu/VSjU3+kAR5JI6/rWbtV0mcaDp7n
	 AvVtVbUKY7o9AAgq2hHDonKuIJ85NMOcSke5kqEeSJrBCMvmi9a7eR1f0YDBAJ/Ext
	 z89v4QRE5xJ+Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rohJA-000000000zv-1IrP;
	Mon, 25 Mar 2024 11:12:00 +0100
Date: Mon, 25 Mar 2024 11:12:00 +0100
From: Johan Hovold <johan@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Anton Altaparmakov <anton@tuxera.com>,
	Namjae Jeon <linkinjeon@kernel.org>, ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
	regressions@lists.linux.dev
Subject: Re: [PATCH 2/2] ntfs3: remove warning
Message-ID: <ZgFN8LMYPZzp6vLy@hovoldconsulting.com>
References: <Zf2zPf5TO5oYt3I3@hovoldconsulting.com>
 <20240325-faucht-kiesel-82c6c35504b3@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325-faucht-kiesel-82c6c35504b3@brauner>

On Mon, Mar 25, 2024 at 09:34:38AM +0100, Christian Brauner wrote:
> This causes visible changes for users that rely on ntfs3 to serve as an
> alternative for the legacy ntfs driver. Print statements such as this
> should probably be made conditional on a debug config option or similar.
> 
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Johan Hovold <johan@kernel.org>
> Link: https://lore.kernel.org/r/Zf2zPf5TO5oYt3I3@hovoldconsulting.com
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Tested-by: Johan Hovold <johan+linaro@kernel.org>

I also see a

	ntfs3: Max link count 4000

message on mount which wasn't there with NTFS legacy. Is that benign
and should be suppressed too perhaps?

Johan

