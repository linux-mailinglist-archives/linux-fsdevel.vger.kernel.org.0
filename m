Return-Path: <linux-fsdevel+bounces-2361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5907E5173
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 08:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94207B21045
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 07:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A2ED51D;
	Wed,  8 Nov 2023 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BSfJlJQ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8644BD313;
	Wed,  8 Nov 2023 07:56:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F13170A;
	Tue,  7 Nov 2023 23:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=vBOxS8CukZHDurA482Su8cBx8gX29bNB2eubg/7PT7U=; b=BSfJlJQ/mxsMKNWuRXiNAVm8o4
	tGjAE57/0lmQeXY4k+OdYDzHzXCZTj1KpSHiUI7qyZZbL0CCDkbAX3QGog/jUG7qn/s2QYwMfxgJo
	KM5bnWKyYi+dg8YVZkwjC/EhXFADL3J4mk4LUmRgzEq5ExzQ2r6EQC6vlCEkOgrpEOGOvLzr8IPcy
	grw1ybattQbjzaRjv65eKOfWlfgMscYOdzslNBL99E0CP6/TwfsK/emHJbFdKzfRzj+91/SAUsgZq
	C+lfEv79Nk7utSnakpmm7fZSNatXrdwqmvIMtAao+NP7UAk39MdW2lfM+Rb9A87FOD28vBynL9Ja7
	hLOZR9uQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0dQD-003DYx-2M;
	Wed, 08 Nov 2023 07:56:21 +0000
Date: Tue, 7 Nov 2023 23:56:21 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZUs/Ja35dwo5i2e1@infradead.org>
References: <ZUUDmu8fTB0hyCQR@infradead.org>
 <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
 <ZUibZgoQa9eNRsk4@infradead.org>
 <20231106-fragment-geweigert-1d80138523e5@brauner>
 <49454bf2-af6e-4dcf-b9a1-22acbfdc756d@gmx.com>
 <20231106-postfach-erhoffen-9a247559e10d@brauner>
 <ZUjcgU9ItPg/foNB@infradead.org>
 <20231106-datei-filzstift-c62abf899f8f@brauner>
 <ZUkeBM1sik1daE1N@infradead.org>
 <20231107-herde-konsens-7ee4644e8139@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231107-herde-konsens-7ee4644e8139@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 07, 2023 at 09:58:48AM +0100, Christian Brauner wrote:
> > Maybe you're just taking it to personal?  A place where systemd, lxc,
> 
> Of course I'm taking that personal. It's a personal comment that
> unnecessarily accompanies the message that you think I discount software
> that isn't all that modern. Which is a fair point. It doesn't have to
> come with garnish about me living in a bubble.

І'm not sure why you're trying to overload words with meanings that
weren't said.  If you list software that is both by it's place in the
food chain and by its developer community very up to date to low-level
Linux quirks (sometimes too much, btw - we really should accomodate
them better), it shows a somewhat limited view, which is the definition
of a bubble.  There is absolutely no implication that this is intentional
or even malicious.

> > definition of a mount point, and that one used on basically every
> > other unix system.  It might not work as-is for software that actually
> > particularly knows how to manage btrfs subvolumes, but those are, by
> > defintion, not the problem anyway.
> 
> On current systems and since forever bind-mounts do not change device
> numbers unless they are a new filesystem mount. Making subvolumes
> vfsmounts breaks that. That'll mean a uapi change for
> /proc/<pid>/mountinfo for a start.

a bind mount can of course change the dev_t - if it points to a
different super block at the moment.

