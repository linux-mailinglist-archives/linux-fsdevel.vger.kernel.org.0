Return-Path: <linux-fsdevel+bounces-21295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3669015CA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jun 2024 13:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB490281BDC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jun 2024 11:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6D729D0B;
	Sun,  9 Jun 2024 11:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="US3lWsjQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292AC13FF6;
	Sun,  9 Jun 2024 11:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717930836; cv=none; b=rlpxXo1IXuUq+O1VcanVzodN1DpR9t+RuTF0mPzSrPyPcvbLJjAkOfsbPwhGP9cBdXOkWiBiiSQw5PfTITzZtW148YqWNiRQq5fR+k4ojXN015aEmAcaDdTR/ZkdqQtM+7xdpyhI/E9YT4SPOQzbRHksoj2OZvxio1FXRRKhPbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717930836; c=relaxed/simple;
	bh=JQH94jUBxjL9arcWax+PX3yQ504i+nJ65WT/zchd8IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfSC9/Ea1K1O6CY4NEYygz6LvTApMCjxAiUTBfEWlz7HEdAhmHBSs9Z1BSb5r5qr5zPuLn8cJSOr06k5eBkiteUoWpMAWJFnEArJerpv7n9V0HjgX0dcoI6gHogh3D/b6B8dNKJLaNZftwO1jWavsPgfverTNJq2PLnRe0l4Y60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=US3lWsjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A192C4AF1C;
	Sun,  9 Jun 2024 11:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717930835;
	bh=JQH94jUBxjL9arcWax+PX3yQ504i+nJ65WT/zchd8IQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=US3lWsjQfrgTE3Agenr4vuv7soGrp2++kdjJ4LSjBD/9K10OFvtMAdD2mN+UGEBFO
	 lJef9t4Ufbaz3ruAV9q+7OEMAZ4ero0okdXTS66fnMwRF5QEYqQDW5HzmN4a4K23K6
	 /CIVVU7pECx3SmF75vEdSsUpNZKt5p1THMZkx2AI=
Date: Sun, 9 Jun 2024 13:00:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 6.6 439/744] splice: remove permission hook from
 iter_file_splice_write()
Message-ID: <2024060921-marina-agreement-c373@gregkh>
References: <20240606131732.440653204@linuxfoundation.org>
 <20240606131746.563882173@linuxfoundation.org>
 <CAOQ4uxhL59Sz4akfk-DGQXYTRwLu4B1gPUgKOy0J_RehdzkVTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhL59Sz4akfk-DGQXYTRwLu4B1gPUgKOy0J_RehdzkVTg@mail.gmail.com>

On Thu, Jun 06, 2024 at 05:33:17PM +0300, Amir Goldstein wrote:
> On Thu, Jun 6, 2024 at 5:18 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > 6.6-stable review patch.  If anyone has any objections, please let me know.
> 
> I have objections and I wrote them when Sasha posted the patch for review:
> 
> https://lore.kernel.org/stable/CAOQ4uxgx7Qe=+Nn7LhPWAzFK3n=qsFC8U++U5XBaLUiTA+EqLw@mail.gmail.com/
> 
> Where did this objection get lost?

Don't know, sorry.  Now dropped, thanks for letting me know.

greg k-h

