Return-Path: <linux-fsdevel+bounces-3514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CA47F5993
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 08:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43091C20B83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 07:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCA318647;
	Thu, 23 Nov 2023 07:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oD55oHBg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CBFE7
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 23:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=oD55oHBggo8AMHOdrJNmQ+0VrA
	yoLAoro8HxyEQpUAYr0wJj9LY+lqsFzlrcWD5z3crgDJcSVEd9Q/6dF6JPMo5mgdLHLzYUH+YE1Po
	BMfPlhA7X/MmscVuFEJrJnZP8dLTdLToUxOm4JieY4AtMe3nxU1yK75qEiru+PudDtH6B2wz5uMWw
	fUBQHM/7Iiqtxq7wBL5kNTs2Nu3SoJjKWm0Bn2cZjHSFbYNjJBU7yGWMXCZn017EW4PttqvvQb0EE
	cNqx+8AyDo38fdGTNjXfi+kMg9va2q9Yymq35/VTQ+5g/gyaTpAq13D6QdrPE1qAV3rfiB6x55k3v
	WjlvE+Pg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r64Ru-0044nk-1g;
	Thu, 23 Nov 2023 07:48:34 +0000
Date: Wed, 22 Nov 2023 23:48:34 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 08/16] btrfs: move file_start_write() to after
 permission hook
Message-ID: <ZV8D0kxhK5F4xp0D@infradead.org>
References: <20231122122715.2561213-1-amir73il@gmail.com>
 <20231122122715.2561213-9-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122122715.2561213-9-amir73il@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

