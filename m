Return-Path: <linux-fsdevel+bounces-3512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CD47F5990
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 08:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10942817FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 07:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E7718652;
	Thu, 23 Nov 2023 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="09i1mfaG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E01BE7
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 23:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=09i1mfaGzn4g2RzmT5NH+yCxZy
	mnXNjmAIIbyaEW0XP+Vhkvwc2ZuDiTD5ZcIQfn8O5uXtbCky2aatDX0gKvE0p4uR1lVrihSqYXDZC
	yYVGG1e8HPmUWfmznjg2g5V1pw2IjA39gi9WtDe1Um7wYffZk3TLp6c/O5txZXSwqEw7lbZjn5xLp
	DEYZ2+g6mv+GHBlBVvnaT1T+gxPyM1FKxBFNss1nSGbCxWT5EfWVI9fi9Gq+ULMaVmIbUpSJZ6C/j
	mI3jwX5PWWIl8igxTUEU7VZ3YU+RmXSCi1Qc7Pq95KIHOmkJO20FMwOXsOp5LBdQVR44wtVUyMIJK
	xVgH6qQA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r64RF-0044ix-2c;
	Thu, 23 Nov 2023 07:47:53 +0000
Date: Wed, 22 Nov 2023 23:47:53 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 06/16] remap_range: move permission hooks out of
 do_clone_file_range()
Message-ID: <ZV8DqbnbgduTQtri@infradead.org>
References: <20231122122715.2561213-1-amir73il@gmail.com>
 <20231122122715.2561213-7-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122122715.2561213-7-amir73il@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

