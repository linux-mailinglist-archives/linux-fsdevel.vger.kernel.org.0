Return-Path: <linux-fsdevel+bounces-2359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640A27E515F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 08:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCAA28140D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 07:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D938D51E;
	Wed,  8 Nov 2023 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f6u3LQRe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0BED50E;
	Wed,  8 Nov 2023 07:52:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC0F199;
	Tue,  7 Nov 2023 23:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7hRINSnpGbgVgf9ak4tbpnjMYCxj2LkWpPovfv+gAbw=; b=f6u3LQRe6Z5xU4gFuJJPUqWPwq
	6d5p6Cv9deBS+nHjga5f/Nnqh8/9E5Lww+dYZHzqfhw/tdto0YM/2gMn4DqqCJCfb6UGvqYdE1E2Y
	P9K+N5rQ8J5kbVBu76bDlgMLCmPAA0r+X9Z2h4m+vh5wXwjeUQZWqzsB3irt/RIHE2gEyog9sFVc7
	0ysQFwCveQNDV3lPlCeK533gRT8u3QvfW85Ho637LwPoIfEU8FHjNevrl5wKdpKR8FhuFwOAz1lIg
	OqB5t/Xn6u+5t+gRUnEtcpqWbIASv9oc/Sk9bC48Y+xEWA1cBm1tLXGnh37WNsCpag3BN1gtljBPB
	YgMa01Pg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0dMI-003DCN-2Z;
	Wed, 08 Nov 2023 07:52:18 +0000
Date: Tue, 7 Nov 2023 23:52:18 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@infradead.org>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZUs+MkCMkTPs4EtQ@infradead.org>
References: <20231102-schafsfell-denkzettel-08da41113e24@brauner>
 <ZUUDmu8fTB0hyCQR@infradead.org>
 <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
 <ZUibZgoQa9eNRsk4@infradead.org>
 <20231106-fragment-geweigert-1d80138523e5@brauner>
 <ZUjcI1SE+a2t8n1v@infradead.org>
 <20231106-unser-fiskus-9d1eba9fc64c@brauner>
 <ZUker5S8sZXnsvOl@infradead.org>
 <20231106224210.GA3812457@perftesting>
 <20231107-leiden-drinnen-913c37d86f37@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107-leiden-drinnen-913c37d86f37@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 07, 2023 at 10:06:18AM +0100, Christian Brauner wrote:
> > But it doesn't appear to me there's agreement on the way forward.  vfsmounts
> > aren't going to do anything from what I can tell, but I could very well be
> > missing some detail.  And Christian doesn't seem to want that as a solution.
> 
> No, I really don't.
> 
> I still think that it is fine to add a statx() flag indicating that a
> file is located on a subvolume. That allows interested userspace to
> bounce to an ioctl() where you can give it additional information in
> whatever form you like.

What is that flag going to buy us?


