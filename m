Return-Path: <linux-fsdevel+bounces-1301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 297497D8E76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 08:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D663C2821A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 06:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADE88C16;
	Fri, 27 Oct 2023 06:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oMkSPEHQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3978BFB
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 06:09:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF1B9D;
	Thu, 26 Oct 2023 23:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9BtbDR3n54FvA+75JkgaZTEYqfXfxJPeXWsx0MsF3sk=; b=oMkSPEHQHa2n/JzmZo8lLDQg4e
	5FtnsmIdMbM6VfM3OSSAtvKAnk+hmFapfymQnYBJVU9P4ZMO13TZcHOGvUP+K8Olp3qWzHzP5UVXX
	ef7mHFQbGN14pQKhIL+fSSG1FzRLLksc549xsYPjPGmAfK/I9Ve5NYVR/lmmkwd3OFnyoMlAr64Wq
	JI/eBy25n/HqcOgP07r33VKtk2miK5NOzTI6zgEzk7hvJ0apuwgY7zNYn0HMU/aK1v/SdMtHPJ4T6
	GFCpFDMr0GelgjHD6H4qVA0J7sREaiDUuTc81DowQKEVzZSGRfNl/p9WWGmARoTzSZoVl809zLuzB
	SM1CVotQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qwG1j-00FefK-1A;
	Fri, 27 Oct 2023 06:08:59 +0000
Date: Thu, 26 Oct 2023 23:08:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: create an entry for exportfs
Message-ID: <ZTtT+8Hudc7HTSQt@infradead.org>
References: <20231026205553.143556-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026205553.143556-1-amir73il@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 26, 2023 at 11:55:53PM +0300, Amir Goldstein wrote:
> Split the exportfs entry from the nfsd entry and add myself as reviewer.

I think exportfs is by now very much VFS code.


