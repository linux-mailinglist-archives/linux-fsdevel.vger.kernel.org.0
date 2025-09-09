Return-Path: <linux-fsdevel+bounces-60711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F2AB503A3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 19:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0E26188CC6F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 17:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AC036CE11;
	Tue,  9 Sep 2025 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PP8ilOBM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB9B35FC2B
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437048; cv=none; b=F/pM7xtbasnF4stBjM0ISjyhcOMhft9CuhakB0DaSs6fDM8VJJ7jGUBokXr+jJ85/nCjkvhmoyJjfme983S7R2jEkXuhKnzJ4H4oXXJkUzstbGCAb8AQu0olxZ1IpwNBehcLyncopGTaAh2B3yrPR/vu6cWTvSv6da/d6ji095Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437048; c=relaxed/simple;
	bh=r9MOjY1VV0AeazN9a29KRc0JTmL+jj79JtJseSsg1Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuA8Gxvn6u9HvNyuvfIAjzIiDg4LOlSGC0k7cmDuEHQ52sLA5ADt+vNsdw7oKom2EmDOWiLxlWrnQEd4BSTxQdrvNA9Fxp3tHQ/7wa5nFk0m2VUXREBQEYyPkqK+ErsWZXigO9jgTrza5uFVOhmBAvBr+uSsErGUyuIuYUfcXFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PP8ilOBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1415C4CEF4;
	Tue,  9 Sep 2025 16:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757437048;
	bh=r9MOjY1VV0AeazN9a29KRc0JTmL+jj79JtJseSsg1Z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PP8ilOBMHJ4hLfWIW5Bz/4UdZD4FZThYkZxP1e7ld5QUt026clkm7eVgNbP00ur77
	 2f3J4wh55MqG+rIbB7SgjX3AguXdMZFdjZwqRuR5wA7oFZmO5ra3YbOF9gByiirBwP
	 ah3ZiV1Uj38/l8JtdWPzmxnxP4u1d0c0nmRtz+iQLrk77lHEahZOUlcZ2+y1NSQ/li
	 VG+GWGbnsjmLpv4kPK89gkW1jFh5XLpDqvAwiDzj69qE5LoMMDPty1ZhjS5zl+Egb9
	 vu1tS9Qol9/hEjGAYV9bW1+ivPCNNC2TQufesL72V9DEVPEsc7FQ23sdO7x/aGbeUo
	 ydCqbYe6/9kPA==
Date: Tue, 9 Sep 2025 06:57:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/4] writeback: Add tracepoint to track pending inode
 switches
Message-ID: <aMBcdxukjywbwiRA@slm.duckdns.org>
References: <20250909143734.30801-1-jack@suse.cz>
 <20250909144400.2901-8-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909144400.2901-8-jack@suse.cz>

On Tue, Sep 09, 2025 at 04:44:05PM +0200, Jan Kara wrote:
> Add trace_inode_switch_wbs_queue tracepoint to allow insight into how
> many inodes are queued to switch their bdi_writeback structure.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

