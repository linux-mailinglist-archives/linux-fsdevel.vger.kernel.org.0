Return-Path: <linux-fsdevel+bounces-31995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 694D899EE40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 15:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12F29B21519
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 13:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B39170A3A;
	Tue, 15 Oct 2024 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlCWvCuP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D2E1FC7D1;
	Tue, 15 Oct 2024 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000520; cv=none; b=r/wgRg6GHpOtQXh8y4afBf8OcWKeE4p+2xTfjksIoZOzeSO1ZaaNxasZ734tSMq/zIlvMci0Ze6vwERT/EEsLcXcJwKyd9K/hvmuAPhvqXn0R+L+RTW4qxNpXMULnoJgTJj4UFWYVOVkPsFsdag/BX5fn+SbvJAAesskEnwDXmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000520; c=relaxed/simple;
	bh=E4FPpLgjFwsYfCi9LlTWwHuWNpi+DGCMZLApZtrVeXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lr3vkHME1MGWR85xQW6iOX+LA1qFj5xLNXJwkv96PfVTmHUc8oxsIP8VnIkhsIM6fRG5pDcWyjpFqFUVLANYren/2h445OYuMSQLsu4jCUKr5P20Ou2QpeL7HjgadH1atGXYkLgl1koFZsjNtV/ri/0I/yXsZOiJXBfQjraKnJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlCWvCuP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5105FC4CEC6;
	Tue, 15 Oct 2024 13:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729000520;
	bh=E4FPpLgjFwsYfCi9LlTWwHuWNpi+DGCMZLApZtrVeXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DlCWvCuPBtuscz5EGcb6N12yPsVhqmTbHjCHJE6Dui+zjwVs/auicPZrt9gR0R5U1
	 MeDe4TU8UXtpYSCtfIHjv8Ukisgkhjp73fcSXN6y2NRhGM0drllHVAJRoUWeb4ZfEI
	 JOezb8/y1YZh9r0KpXC++Pdyqk7QFN+ylkbwcL5p3k25MTNqVC1ef8tIUUl2kd1gNH
	 BZkRFesmi9txoIn2BeLMRYfbldGlBUzFEBBxRofe5kbsp9S2aqoPDjTAxRF3hOP9Ql
	 6pAtEZxdEJWaLU59uhZZVnWFYnQ8Dn+tOjb2/RUD01ShX5E9539aeWbiSO62Nh/D/h
	 bXh4ZELOJvLHQ==
Date: Tue, 15 Oct 2024 15:55:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH] selftests: add test for specifying 500 lower layers
Message-ID: <20241015-altstadt-kaffee-fc665c40c46e@brauner>
References: <20241015-leiht-filmabend-a86eed4ff304@brauner>
 <CAOQ4uxi8=BKjBt04OQi8weFUDoXYA5+cWq51EMTocyjTf2Fx5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxi8=BKjBt04OQi8weFUDoXYA5+cWq51EMTocyjTf2Fx5A@mail.gmail.com>

On Tue, Oct 15, 2024 at 01:35:31PM +0200, Amir Goldstein wrote:
> On Tue, Oct 15, 2024 at 1:15 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > Verify that we can actually specify 500 lower layers and fail at the
> > 501st one.
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> > Just noticed that we didn't have that and we'd already regressed that
> > once and now that I've done new selftests already just add a selftest
> > for this on top.
> 
> Thanks!
> 
> I guess this is going to be added to your vfs.ovl branch, so
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Yes, thanks!

