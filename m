Return-Path: <linux-fsdevel+bounces-3510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A804A7F596B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 08:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619922817CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 07:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8AD1798B;
	Thu, 23 Nov 2023 07:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GICdIgQK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBC9E7
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 23:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=GICdIgQKLnxJSq5DlRiIjt4eex
	fiD6UjXurBBOGu/zZBXx/DCaghrnMYZ1mJHXdfem9YV18g5ESRTNfNYMtJgytnVFMafRLB3A8SkWC
	GU9qsvjv8i643t3QzhTtRdy3/UWUzfdhuFHmJzQCSP1z7HNT9aWZaIDUD8MKQIHizvLSaJr16M93o
	UduBn7Dfcg7daRDeV7KHyhdZFKXAmXp7txpX8NKj1uqJB+m03d/n/fnvLy+saqbXeIiBrFu/msVMV
	T+vmijZOvz0uMBsRFOkkDUIQvXiNj71Qu6f4I98LManIcM2nIbl5hLUovnUgqPxL9D5IVYk6imMES
	eUj8NiTA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r64IS-0043gl-3A;
	Thu, 23 Nov 2023 07:38:48 +0000
Date: Wed, 22 Nov 2023 23:38:48 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 04/16] splice: move permission hook out of
 splice_file_to_pipe()
Message-ID: <ZV8BiKhsAACrmVzx@infradead.org>
References: <20231122122715.2561213-1-amir73il@gmail.com>
 <20231122122715.2561213-5-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122122715.2561213-5-amir73il@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

