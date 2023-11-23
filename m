Return-Path: <linux-fsdevel+bounces-3508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA07B7F5959
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 08:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3BD928170B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 07:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15081179BF;
	Thu, 23 Nov 2023 07:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="15LX/Sm4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6569F
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 23:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=15LX/Sm4ZO7Jgdypa5I19gUBYH
	EmNDGqHAA2GRyvE0VxqLN+VZ7V05U/70M0B6LcT/1av8keOwg+h+ZUOAHKVci9Eb35waUx2grCeM/
	U/dD24DWBh3a5mjIE2bm7KZu86FckHk3bNBIvuNdFcrWsZcB3YHboT6vYHlErQN4iZuIP+wBH/h2E
	musaMkS3qQTcz+f+xYggfo3658gp2sVO5c7856S1wDihP62Y2QPP8Nq+6/qGKAVuvJnGyNNRR+IXJ
	gOE+kMB65FXfY9QRPExBZo4Jy5MlGBwiu2ydbdywxVA5tCwHkb1bXi2KRv0pj5Ck9V00qB6lwKzHi
	vLsxQH5A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r64G1-0043Fs-2g;
	Thu, 23 Nov 2023 07:36:17 +0000
Date: Wed, 22 Nov 2023 23:36:17 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 02/16] splice: remove permission hook from
 do_splice_direct()
Message-ID: <ZV8A8UnKr2VBWO/7@infradead.org>
References: <20231122122715.2561213-1-amir73il@gmail.com>
 <20231122122715.2561213-3-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122122715.2561213-3-amir73il@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

