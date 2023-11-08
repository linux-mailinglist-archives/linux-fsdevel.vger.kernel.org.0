Return-Path: <linux-fsdevel+bounces-2389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9DA7E5856
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 15:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 789F22814E6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 14:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2799199C8;
	Wed,  8 Nov 2023 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YznPAv1w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E27199AE;
	Wed,  8 Nov 2023 14:07:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832151BF9;
	Wed,  8 Nov 2023 06:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IimMaOUsB14tLJS4rrX42jRRtjVBMc2RKLS/YqceDVs=; b=YznPAv1wCgV3XZEbwqo8ow1SCL
	vxhYm+MCnsuHIyb/sqmOcVd/CzmPk4vBXuFuw6pD6f3vXfy7WMZu9N9XqUejAucvN2CeRPJI5LHyj
	07STTWkju/bO1Mq3x8X0IQlMnMX5SFd2C5vEmjW8PEQJAJBdz+5RB9a0R1zUUEp/rBzgNmzN8oTkv
	2CUPeb/rErqVGUYpgdNBFUVYdFmwgxPE9sfExSefCEYChZkUM5DV76v8LlEP72LiAGiqd79N69rWQ
	f0WMtXiuO9ToGBgKNMjcBUfTcxuhifLD/Hrcd6oTaTREF7gz42AbBwjhRy2Ljb97XImRGFMZY81vM
	i3I87V2A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0jD4-003ykg-0M;
	Wed, 08 Nov 2023 14:07:10 +0000
Date: Wed, 8 Nov 2023 06:07:10 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZUuWDv1dQ+dlSd93@infradead.org>
References: <49454bf2-af6e-4dcf-b9a1-22acbfdc756d@gmx.com>
 <20231106-postfach-erhoffen-9a247559e10d@brauner>
 <ZUjcgU9ItPg/foNB@infradead.org>
 <20231106-datei-filzstift-c62abf899f8f@brauner>
 <ZUkeBM1sik1daE1N@infradead.org>
 <20231107-herde-konsens-7ee4644e8139@brauner>
 <ZUs/Ja35dwo5i2e1@infradead.org>
 <20231108-labil-holzplatten-bba8180011b4@brauner>
 <ZUtC9Bw70LBFcSO+@infradead.org>
 <20231108-regimekritisch-herstellen-bdd5e3a4d60a@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108-regimekritisch-herstellen-bdd5e3a4d60a@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 08, 2023 at 09:22:33AM +0100, Christian Brauner wrote:
> > 	/mnt/1/foo to /mnt/2/bar will get your dev 8 for /mnt/2/bar
> > 
> > So the device number changes at the mount point here, bind mount or not.
> 
> Yes, I know. But /mnt/2/ will have the device number of the
> superblock/filesystem it belongs to and so will /mnt/1. Creating a
> bind-mount won't suddenly change the device number and decoupling it
> from the superblock it is a bind-mount of.

It doesn't any more then just changing st_dev.  But at least it aligns
to the boundary that such a change always aligned to in not just Linux
but most (if not all?) Unix variants and thus where it is expected.

