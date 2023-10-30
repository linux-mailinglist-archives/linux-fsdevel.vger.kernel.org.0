Return-Path: <linux-fsdevel+bounces-1528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F21A7DB523
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 09:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DA86B20D6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 08:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20DED296;
	Mon, 30 Oct 2023 08:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdvzEUQQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16078D26F
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 08:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FA1C433C7;
	Mon, 30 Oct 2023 08:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698654595;
	bh=iddVwOpjBeNoZqOUu3zqkxBTA3ogXICvytlUFVA9R28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VdvzEUQQw5mXkPiYTJRlRZByxvrlMzTqUbby84cLBjHlliKT4weKqcGAqfr9EamLu
	 cvAs+pA3QVHsLR2Mj+yjT1D2gSPluQQSEIuLaoMgGR6VGiZruuDjx3UbyBgiHDdInM
	 CCe0pcJ107lokyFeIzxUxjAd+AbzHOT3tly8YI7dMZiQ0972qv+T0ABLfvKpzn6yTY
	 ogRoTN+4PkNIzMP75hekUEm+YaZYkm2a9/FEisjbLCLt0JE6ahSW0J5e8sWmyG4Svh
	 4gJdhs2LtpUinokMMmX+WNyl14V3v3nsHp6wWwJWQa/2KuEl6c8HqgoApGeFPCmCsk
	 eL0Gwxa5vc1LA==
Date: Mon, 30 Oct 2023 09:29:51 +0100
From: Christian Brauner <brauner@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL for v6.7] vfs super updates
Message-ID: <20231030-anbelangt-droht-3f4947871874@brauner>
References: <20231027-vfs-super-aa4b9ecfd803@brauner>
 <20231030092009.0880e5f3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231030092009.0880e5f3@canb.auug.org.au>

On Mon, Oct 30, 2023 at 09:20:09AM +1100, Stephen Rothwell wrote:
> Hi Christian,
> 
> On Sat, 28 Oct 2023 16:02:33 +0200 Christian Brauner <brauner@kernel.org> wrote:
> >
> > The vfs.super tree originally contained a good chunk of the btrfs tree
> > as a merge - as mentioned elsewhere - since we had intended to depend on
> > work that Christoph did a few months ago. We had allowed btrfs to carry
> > the patches themselves.
> > 
> > But it since became clear that btrfs/for-next likely does not contain
> > any of the patches there's zero reason for the original merge. So the
> > merge is dropped. It's not great because it's a late change but it's
> > better than bringing in a completely pointless merge.
> 
> Can you please update what you are including in linux-next to match
> what you are asking Linus to merge.

I pushed it out right when I got up. Sorry for the slight delay. I hope
the reason for this late change are not unreasonable. Let me know in
case there's a better solution I didn't think of for such a change.

