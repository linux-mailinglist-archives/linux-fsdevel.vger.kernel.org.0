Return-Path: <linux-fsdevel+bounces-7566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 468E882780E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 20:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA8D21F23915
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 19:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA2354FA1;
	Mon,  8 Jan 2024 19:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p4B3MJw4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1319954F89
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 19:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+21rCbf2B+bmfLm0bgB+vXlgL3MXfM+jAdCrOOVygNo=; b=p4B3MJw4n4gsBOqm89ddwDnDtp
	bEL475A0/s+jR6ISjn5KvVU7RPpco0e+iRI1dwBd2iiOtQZOgvEE8q9q5jznN4wxyk3u0/ZLt1K0h
	UbIHzpMbt7WnR+bJCnoSuhXV6RYygJXdCEfeARAc2MY49cANk3r8dRQpznL7tlA1OpkeKQyGgoTaj
	qMEM8DnPgmj75WbbomT+NrXu4uXWtc0ovZfwjkuN1x9M5LwFhMcy0QIhao7JCGV8y+Kt30jhQx720
	/FomZp0pJ4qi2YBe6HsSePEPDSyjKvxC+XMgRjyYrw8+b3Ypi1sMQpLoWLvSasb+FWoyqEptJf63h
	2m8fyNTw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rMus5-008E9L-U3; Mon, 08 Jan 2024 19:01:13 +0000
Date: Mon, 8 Jan 2024 19:01:13 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Wrong function name in comment
Message-ID: <ZZxGeZG9mTCJm7Y0@casper.infradead.org>
References: <20240108172040.178173-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108172040.178173-1-agruenba@redhat.com>

On Mon, Jan 08, 2024 at 06:20:40PM +0100, Andreas Gruenbacher wrote:
> This comment refers to function mark_buffer_inode_dirty(), but the
> function is actually called mark_buffer_dirty_inode(), so fix the
> comment.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Nobody noticed since 2002 (983b8a3c80b73 in mpe's fullhistory tree) ;-)

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

