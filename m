Return-Path: <linux-fsdevel+bounces-1925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7CC7E049F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 15:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86064B21431
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 14:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591BB19BD9;
	Fri,  3 Nov 2023 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3JjsbooY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A6E19465
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 14:23:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0376B1BC;
	Fri,  3 Nov 2023 07:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bAkQU5uTG56T8s4ikHNxWHhDwijbHjGis6JbtOJnAMo=; b=3JjsbooYVQO/bzrQouq9h8eu8D
	7/iNZB6XPj9jq6uDHFWwUVAHeRrIAtFZ7bPzrn6BdOCIj40abM91dlQX1ML5+rH2JxOQLH/G7d1q9
	t4ICWH59T9F6UJvUaIPvfzKuBNz6xDpCwao/4MYvcAuBdrWuvoM4LdvFUMWID/eMKJ1TlIHeEAPvS
	1opE5y3t+dZqjWTPPajLAJ+KNOa1qIeOOnuS1vLTpTWijCrDK+lbD9pjoZGsN0AXhsucModA3Eakj
	zReI17dfC6kukb3G/t+Hf6g0yYBl3lzpvL82NSBtiESLwWmdIB1rEcDqeS2QzU2m6gLj+htdX/5K7
	KcSYiUOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qyv5H-00BZTK-0x;
	Fri, 03 Nov 2023 14:23:39 +0000
Date: Fri, 3 Nov 2023 07:23:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZUUCa/JdOlD7x+/C@infradead.org>
References: <20231025210654.GA2892534@perftesting>
 <ZTtOmWEx5neNKkez@infradead.org>
 <20231027131726.GA2915471@perftesting>
 <ZT+uxSEh+nTZ2DEY@infradead.org>
 <20231031-faktor-wahlparty-5daeaf122c5e@brauner>
 <ZUDxli5HTwDP6fqu@infradead.org>
 <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 01, 2023 at 07:11:53PM +1030, Qu Wenruo wrote:
> > mount -t btrfs /dev/sda /mnt
> > 
> > could be exploded into 1000 individual mounts. Which many users might not want.
> 
> Can we make it dynamic? AKA, the btrfs_insert_fs_root() is the perfect
> timing here.
> 
> That would greatly reduce the initial vfsmount explode, but I'm not sure
> if it's possible to add vfsmount halfway.

Yes, that's what I had in mind as well.


