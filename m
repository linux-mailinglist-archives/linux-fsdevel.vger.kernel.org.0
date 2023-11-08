Return-Path: <linux-fsdevel+bounces-2367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A80777E51BA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 09:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542B4281543
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 08:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0297BDDA6;
	Wed,  8 Nov 2023 08:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zj8cw9NK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B8ED52C;
	Wed,  8 Nov 2023 08:12:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD681A6;
	Wed,  8 Nov 2023 00:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=auL+eLvjEEz68iLfl7+1Ji9WGyMxkGK9qrdnXKiYiWo=; b=Zj8cw9NKTfJ0VMhZCzwIw8fjfv
	pfFJBEDkL4QSbN59lDxSdsetB8F2dBgGYlcnb1I9DEb4+RMaahHgCP8aET2i9TSa6rs5eDPwaWqGu
	iLb6OLTW1dWhg9dTMGlLDKxCAMEdylaFqaQsoeDN3WkxKhAPgxFNTHD92l9t+NUIwTJkfW8e18ujn
	uN8VaknPHiPUiE9ODmMA/NpsGOayBXkr92hjIJNldCmsEpUh3TjUst51ZsUkNFLPbQdPtGQhjN5rK
	eujidyE64WO/4tebLvefIPTyl0+LsD3gYB3Y+ARj30lc91/hGBqCHyuhWOvPWNMxg+yOuYOeL8W+K
	npuS7FRA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0dfw-003FuI-1I;
	Wed, 08 Nov 2023 08:12:36 +0000
Date: Wed, 8 Nov 2023 00:12:36 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZUtC9Bw70LBFcSO+@infradead.org>
References: <ZUibZgoQa9eNRsk4@infradead.org>
 <20231106-fragment-geweigert-1d80138523e5@brauner>
 <49454bf2-af6e-4dcf-b9a1-22acbfdc756d@gmx.com>
 <20231106-postfach-erhoffen-9a247559e10d@brauner>
 <ZUjcgU9ItPg/foNB@infradead.org>
 <20231106-datei-filzstift-c62abf899f8f@brauner>
 <ZUkeBM1sik1daE1N@infradead.org>
 <20231107-herde-konsens-7ee4644e8139@brauner>
 <ZUs/Ja35dwo5i2e1@infradead.org>
 <20231108-labil-holzplatten-bba8180011b4@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108-labil-holzplatten-bba8180011b4@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 08, 2023 at 09:09:10AM +0100, Christian Brauner wrote:
> > a bind mount can of course change the dev_t - if it points to a
> > different super block at the moment.
> 
> No, a bind mount just takes an existing directory tree of an existing
> filesystem and makes it visible on some location in the filesystem
> hierarchy. It doesn't change the device number it will inherit it from
> the superblock it belongs.

That's what I'm trying to say.

So if you have:

	/mnt/1/ with dev 8
	/mnt/2/ with dev 23

then a bind mount of

	/mnt/1/foo to /mnt/2/bar will get your dev 8 for /mnt/2/bar

So the device number changes at the mount point here, bind mount or not.

