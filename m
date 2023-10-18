Return-Path: <linux-fsdevel+bounces-669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31D47CE195
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 17:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0CF281F2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 15:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E12537167;
	Wed, 18 Oct 2023 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SURgA7/c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3399E1A278
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 15:47:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CF9191
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 08:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=SURgA7/c885yq9e5Py/xxnzVEG
	eeBDkN1W9vHkWxkf2fMZwFRtw9veGpX8PxvDojgPvu5OyhUxYrB7QWW1e51rSpJOqBRk5JGEsjusN
	ymldnJh0AjAUCi9ehBoc9KtKCq9asrRzIwNqfqtghTGNOgBGex6lwHgo0TTqZUY625EWsZh4ZR89O
	qbOS48RNMxKtFmLLOTTEJFZz5qm6XNJXjVaTAau3hibhUMNteWE3nATveG2nKUnr8Xh5oabXM7Twn
	frKC0HHhvYYGpdO204Otv3w8D13kX84Hi2DsrrTapa2x0by/hDq/Znq8Y08rNtfCRHu9qmDB38Oph
	QKNQGhVg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qt8l6-00F5xe-2T;
	Wed, 18 Oct 2023 15:46:56 +0000
Date: Wed, 18 Oct 2023 08:46:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Avoid grabbing sb->s_umount under
 bdev->bd_holder_lock
Message-ID: <ZS/98JLV+CuoraE6@infradead.org>
References: <20231018152924.3858-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018152924.3858-1-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

