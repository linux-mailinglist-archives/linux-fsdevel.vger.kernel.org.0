Return-Path: <linux-fsdevel+bounces-2715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E687E7AEB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 10:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D201F20D6F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 09:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC70E12B90;
	Fri, 10 Nov 2023 09:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m01BEl3f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0E412B6B;
	Fri, 10 Nov 2023 09:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41751C433C8;
	Fri, 10 Nov 2023 09:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699608803;
	bh=pjfFx8zs64l4D3McKQ0nXmumvWIFuK52QlL0zpOWeNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m01BEl3f/5e/t3DVR6cEG7ExR6BLY+0eXvHvzqz98Gfg+mSeoUMupM8pET2Rpk2f7
	 DQ/yNGCILzEQ8MSWWLC72zSPbn4bFTDphgXxi9trq08yissyy9ESdCnHagRV/Ux0kr
	 NH92rljUWTM/q1/RoEo8Ir9iXy24XKb4giU+ZL372vRVQCtsjNl9sLmAWAG3HzEfkg
	 D0z5SasfNQbd64li/Mqg/eUDCSofQmuA+SA6bKaZATtfz5oxlncLI3gA206zQpTTCm
	 x5sT9V40R6du9iRQ26u8ulq7Im/t17qLuuZ7+uo7o5EiuePoqPmZInYJUAjwBSRFcr
	 cIqecnKRFGyAQ==
Date: Fri, 10 Nov 2023 10:33:17 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231110-vorleben-unvorbereitet-fe3b302c5079@brauner>
References: <20231106224210.GA3812457@perftesting>
 <20231107-leiden-drinnen-913c37d86f37@brauner>
 <ZUs+MkCMkTPs4EtQ@infradead.org>
 <20231108-zertreten-disqualifikation-bd170f2e8afb@brauner>
 <ZUuWSVgRT3k/hanT@infradead.org>
 <20231108-atemwege-polterabend-694ca7612cf8@brauner>
 <20231108-herleiten-bezwangen-ffb2821f539e@brauner>
 <ZUyCeCW+BdkiaTLW@infradead.org>
 <20231109-umher-entwachsen-78938c126820@brauner>
 <ZUzvkQfqEYbjXCMd@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUzvkQfqEYbjXCMd@infradead.org>

> you hit a mount point or another (nested) subvolume.  Can't comment
> on overlayfs.  But if it keeps mixing things forth and back what would

Overlayfs shows that this st_dev switching happens on things other than
btrfs. It has nothing to do with subvolumes.

