Return-Path: <linux-fsdevel+bounces-1294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E24777D8E4A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 07:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10681C2100F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 05:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B458C0B;
	Fri, 27 Oct 2023 05:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zNay1crF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FB18BEB
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 05:47:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB681A7;
	Thu, 26 Oct 2023 22:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ft+RBoJIY64vxL9oTa4cbHQ3NmFM9JUoNFCGpOHO5aM=; b=zNay1crFNjpn3ZQ1u5xp9H0xQc
	29HnioyZHVlpM0XXx62804lEO5nPP5b9RqmNwnpI+7OKSLNSvT70x7+gpaSeLsvl9Afouk0b4GFnH
	qW3eD78R4x9xUX4Krqr8Drj/duVcuB4x1DXjbSqteRr6lPglTAhjnjG0CGxCwEf3XgNglmEo/Odwy
	7buo3oD+ia6to5eRkBoWZsUk1Z4O1ETZL2P+LwTZbkgRj7hsy9HzTJ/ouxrGdYD2HLuPJKL7ycL+k
	keOQY0M8dt9FRks1uS15/rWfQIaV5BDUHIxn7qEIqeBfQcf4F/tGy7+K0P/mgUevf/obUdlytjOkc
	8DfkcODA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qwFgN-00FdK5-35;
	Fri, 27 Oct 2023 05:46:55 +0000
Date: Thu, 26 Oct 2023 22:46:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZTtOz8mr1ENl0i9q@infradead.org>
References: <20231026155224.129326-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026155224.129326-1-amir73il@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

As per the discussion in the last round:

Hard-NAKed-by: Christoph Hellwig <hch@lst.de>

We need to solve the whole btrfs subvolume st_dev thing out properly
and not leak these details in fanotify.


