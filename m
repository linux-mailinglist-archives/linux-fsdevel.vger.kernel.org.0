Return-Path: <linux-fsdevel+bounces-1296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1CF7D8E64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 08:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9DC1C20BE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 06:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A758C01;
	Fri, 27 Oct 2023 06:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EQ3HI0AN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D67479DC
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 06:02:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBEE1A7;
	Thu, 26 Oct 2023 23:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=EQ3HI0ANUA5mbLG+IMvaXWt3+N
	kl0SahL0nmvQVd/V519baxJsqKplh02cfFS0d2bGx2fTmPTP7nsyAZX6hxWz2rx1rfRjj2N7AT6Tv
	93BJ6FEXxxZBA8j0YPWCVJUIUcZA3GdeTy0W5qBIvSo+bbgoDNpisSG2NoGYXmPK5Nkey06E6XotI
	t88Of1qlc9+oVsHTdALkYxWfl/QFQrzmVQpIaVHLlM/qUmVbD40yMmWqoeqAqsFgzE0WGNcBaOFR2
	+QIiLgy1eWtxpn8kYnU2d9MkzXKZNwbYv0WuiPl7Avc4gBKmYp+L8z1re5P3YNNooAeAE7IiXYT0d
	grMuO9og==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qwFv5-00FeC6-1R;
	Fri, 27 Oct 2023 06:02:07 +0000
Date: Thu, 26 Oct 2023 23:02:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/4] exportfs: add helpers to check if filesystem can
 encode/decode file handles
Message-ID: <ZTtSX7A15Xsq8hVV@infradead.org>
References: <20231023180801.2953446-1-amir73il@gmail.com>
 <20231023180801.2953446-2-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023180801.2953446-2-amir73il@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

