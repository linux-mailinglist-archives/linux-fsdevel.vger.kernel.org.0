Return-Path: <linux-fsdevel+bounces-3513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E824C7F5992
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 08:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87992B20E53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 07:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F85718655;
	Thu, 23 Nov 2023 07:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cvicX0G+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4431A4
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 23:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=cvicX0G+lhqViXFSVoWb1W0GBy
	h4dCmlzHu4ExJEAU0hohQ3w5KA/CYnHKTcqGHl+ZQeIRK8zLumz1j0yGYKvvzKBDNg0lk7fXyAmq/
	eNb62uc54+Rr4leEE1CDX2utArcbt+t3uZrKBTRdMIYa1w1RhBTP+fX8SBrklbOIbzeeV2xQySP6p
	+ARL7nkxcrRuW6+kK/cWSAjmv6SWkPGEL+g+QmQTHMZPMPeTW6ZZZwTo4PE7YnH5fJaQjxVHjNler
	ESy/lUmajBsF6WfUCTkS3MiSB9xLUvqZER8FOFa+/jhYObgdx7UxumZ3Jmx90zX1J6+uX8mdOiZrz
	MLz4esfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r64Rd-0044lk-2Q;
	Thu, 23 Nov 2023 07:48:17 +0000
Date: Wed, 22 Nov 2023 23:48:17 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 07/16] remap_range: move file_start_write() to after
 permission hook
Message-ID: <ZV8DwdT5sDi0br6L@infradead.org>
References: <20231122122715.2561213-1-amir73il@gmail.com>
 <20231122122715.2561213-8-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122122715.2561213-8-amir73il@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

