Return-Path: <linux-fsdevel+bounces-3546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD107F633E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 16:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D26AB21272
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 15:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB963C6BB;
	Thu, 23 Nov 2023 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HlKMj40K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC437101
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 07:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iFT8VCKuABm8bgfmIp95VUJ5HS5h1w1HBBOMZ5zvrLQ=; b=HlKMj40KXWqUzj4u2KaRj/DckD
	E7CdUZZfuAx3ZyYNYG9FVpTJEKRFC7UnPT+rzqowMW8fci+GnTxT7FX+lKh+f52VkWcJNn8hEmgQr
	OgA+XCsd+oImkVs3Uc0jUK2J+doiandcvRCA2wSe5hkIdRhBPZTye19CKF8U9SKu9UfI3GhfN+/LX
	Wbqnd3/kr0ArQMVe4BUgG6rolhuilgSeKS084ANGuyODPgz7aEKYTDMsinlHAgiTNG+cD6h72HfkS
	82kJ3QKLtCDi2w4rOAP5J1J/kSlEvtilYrgTbzEvggLEsxbzoYoEn03TPgSdxmhvuQRuwQXOcsPRq
	RYxEeJ8Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6Btq-005D1w-37;
	Thu, 23 Nov 2023 15:45:54 +0000
Date: Thu, 23 Nov 2023 07:45:54 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 05/16] splice: remove permission hook from
 iter_file_splice_write()
Message-ID: <ZV9zspcB2yHjFpUO@infradead.org>
References: <20231122122715.2561213-1-amir73il@gmail.com>
 <20231122122715.2561213-6-amir73il@gmail.com>
 <ZV8Dk7UOLejEhzQN@infradead.org>
 <CAOQ4uxhxG_G6pjVTikakuUpru1XfaJoKWs4+HwNxCE5PxGTq_Q@mail.gmail.com>
 <ZV9sTfUfM9PU1IFw@infradead.org>
 <CAOQ4uxiDbGCn3vB4VwQyzdE9k8JjCeMGOqsVN=J5=-KCkvuQ2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiDbGCn3vB4VwQyzdE9k8JjCeMGOqsVN=J5=-KCkvuQ2g@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> Are we open coding call_write_iter() now?
> Is that a trend that I am not aware of?

I thought we finally agreed on killing the damn thing.  I was about to
get ready to send a series to kill after wading through the read/write
helpers again..


