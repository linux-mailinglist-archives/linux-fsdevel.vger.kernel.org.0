Return-Path: <linux-fsdevel+bounces-381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2B97CA131
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 10:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A045728164F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 08:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F46B18622;
	Mon, 16 Oct 2023 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4N2Fd5p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883C2A2D
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 08:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8631C433C7;
	Mon, 16 Oct 2023 08:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697443415;
	bh=HmynXz1SguSM2RHoFlCQRSe7GtTgywzXJd4ry0/TFRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V4N2Fd5pnVz5QBPvDOLXJ6yRC1aCsv1gKMAx04K5l/I+HZ9HjLIixnT95sKvHZl0g
	 U/vRjMEvV8ScwqxAepe1fN//7UVcflFdy5itvNlgASnMWfblLpRRZ4cpw9V0nV9dcm
	 OCYvx22cuEGqHN7NJ/sesadVyQsZ2pVvCMYdAi0HarH3YaVXet9faLt9O2ZSwc37Nx
	 aqIitsFsVKYoA6zTI+7Hlix3Glc9CenfyS7ewX1COAF553Z5ep1ICwP7s3v7AI/42b
	 Ovg8NJCIDIW7gcuU/ifpxm0/oxHiOo2P4rQhPKx0cL/dsks3vWAN70MK5fENiJsmJH
	 yBNViW7aDDUbQ==
Date: Mon, 16 Oct 2023 10:03:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ovl: temporarily disable appending lowedirs
Message-ID: <20231016-siehst-vorfreude-f4a681ed4efd@brauner>
References: <20231014195353.2103095-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231014195353.2103095-1-amir73il@gmail.com>

On Sat, Oct 14, 2023 at 10:53:53PM +0300, Amir Goldstein wrote:
> Kernel v6.5 converted overlayfs to new mount api.
> As an added bonus, it also added a feature to allow appending lowerdirs
> using lowerdir=:/lower2,lowerdir=::/data3 syntax.
> 
> This new syntax has raised some concerns regarding escaping of colons.
> We decided to try and disable this syntax, which hasn't been in the wild
> for so long and introduce it again in 6.7 using explicit mount options
> lowerdir+=/lower2,datadir+=/data3.
> 
> Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
> Link: https://lore.kernel.org/r/CAJfpegsr3A4YgF2YBevWa6n3=AcP7hNndG6EPMu3ncvV-AM71A@mail.gmail.com/
> Fixes: b36a5780cb44 ("ovl: modify layer parameter parsing")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Acked-by: Christian Brauner <brauner@kernel.org>

