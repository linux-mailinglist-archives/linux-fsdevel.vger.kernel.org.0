Return-Path: <linux-fsdevel+bounces-625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052CF7CDB51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 14:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B845B21299
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0279335CF;
	Wed, 18 Oct 2023 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7yCG907"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FE7335AC
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 12:09:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5A9C433C7;
	Wed, 18 Oct 2023 12:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697630977;
	bh=ECoYOChLpMH0wQ/4Cp6xSH3pqN205jSH5KJ4idgqFLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F7yCG907o4JmZqBBMGF6XzwrXWkNU9QDWw4rTcrvLHJnN3kUhv7VQhQWw8IN5f/OE
	 //773GmKndlnuvUiSbBUgT8V2XNU7kIFnteZcL5egJyBz1GqisjXgLe49q3BA47hVe
	 0o2/QCsKrC0x+f6qo96Mx4WGzWh4llFaLHoq76zx1P688ZBW06Qrb635YclnCPF4MB
	 70VOFoG09ZjULw7gmhLdUE4ROJGQjE5vPD5sQ4iCwMU4EpcXZWB2hjbBrY8f6xIrdM
	 l7x52D/ASmalqZYCEUjzx/uAEH8falEWi3k/0USLGMs70MGjYbdJMLuZNm+1tbnK9+
	 4uXmuaenZACvw==
Date: Wed, 18 Oct 2023 14:09:33 +0200
From: Christian Brauner <brauner@kernel.org>
To: Klara Modin <klarasmodin@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fat: fix mtime handing in __fat_write_inode
Message-ID: <20231018-wildfremd-vererben-77de947de51a@brauner>
References: <20231018-amtime-v1-1-e066bae97285@kernel.org>
 <CABq1_vhoWrKuDkdogeHufnPn68k9RLsRiZM6H8fp-zoTwnvd_Q@mail.gmail.com>
 <d727d2c860f28c5c1206b4ec2be058b87d787e4f.camel@kernel.org>
 <CABq1_vj4ewSP246V8-nEZMURgiNFtdChvwojRRPrp81e5P=J+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABq1_vj4ewSP246V8-nEZMURgiNFtdChvwojRRPrp81e5P=J+A@mail.gmail.com>

On Wed, Oct 18, 2023 at 02:03:11PM +0200, Klara Modin wrote:
> Den ons 18 okt. 2023 kl 13:55 skrev Jeff Layton <jlayton@kernel.org>:
> >
> > Many thanks for the bug report and testing! Do you mind if we add your
> > Tested-by: for this patch?
> >
> Not at all, please do.
> 
> Thanks,
> Tested-by: Klara Modin <klarasmodin@gmail.com>

Added, thanks!

