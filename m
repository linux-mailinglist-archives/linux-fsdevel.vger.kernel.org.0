Return-Path: <linux-fsdevel+bounces-2390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B3E7E5859
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 15:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D3B1C2091B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 14:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB519199C7;
	Wed,  8 Nov 2023 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B+c7qWQ5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D11D199B9;
	Wed,  8 Nov 2023 14:08:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148E81BF9;
	Wed,  8 Nov 2023 06:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cni7R8OPkiRoYk/PUViNLx5iIxOAVyeN3OkCgMuCrSc=; b=B+c7qWQ5uE/zmDMwnALmkgwo9+
	Y64gvVHhLUUS5koCTM3gsYSRR26cDA0dUSoe/yuDi4DNaHZEnz/o/HTIjt4RNWlj3bRMpsAZli5zL
	S9We6oYa4avS/SOZffQhnWY+cnTnioTD+me3X1ExH5n028SICeL2Q14hSurQGRgJdqkKg6vj62xo6
	g74zZcrrTP2NYeSfJdG8VMPyD+HEQx9wGWhLrIEtGW9JhdyfzlcnSvQXvZRT1HC2K254rllZ4K60Y
	3ZFCeJktO1GiCXf5yHRp3G22z/R+xmltvg5oGLZqKTtkxjJJxAYTtdd1+ZGI/EBsUyw22+zxachPP
	RmmW2sTg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0jE1-003yrI-21;
	Wed, 08 Nov 2023 14:08:09 +0000
Date: Wed, 8 Nov 2023 06:08:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZUuWSVgRT3k/hanT@infradead.org>
References: <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
 <ZUibZgoQa9eNRsk4@infradead.org>
 <20231106-fragment-geweigert-1d80138523e5@brauner>
 <ZUjcI1SE+a2t8n1v@infradead.org>
 <20231106-unser-fiskus-9d1eba9fc64c@brauner>
 <ZUker5S8sZXnsvOl@infradead.org>
 <20231106224210.GA3812457@perftesting>
 <20231107-leiden-drinnen-913c37d86f37@brauner>
 <ZUs+MkCMkTPs4EtQ@infradead.org>
 <20231108-zertreten-disqualifikation-bd170f2e8afb@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108-zertreten-disqualifikation-bd170f2e8afb@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 08, 2023 at 09:27:44AM +0100, Christian Brauner wrote:
> > What is that flag going to buy us?
> 
> The initial list that Josef provided in
> https://lore.kernel.org/linux-btrfs/20231025210654.GA2892534@perftesting
> asks to give users a way to figure out whether a file is located on a
> subvolume. Which I think is reasonable and there's a good chunk of
> software out there that could really benefit from this. Now all of the
> additional info that is requested doesn't need to live in statx(). But
> that flag can serve as an indicator for userspace that they are on a
> subvolume and that they can go to btrfs specific ioctls if they want to
> figure out more details.

Well, if we want to legitimize the historic btrfs behavior the way to
find out is if st_dev changes without that being a mount point, so
an extra flag would be redundant.

