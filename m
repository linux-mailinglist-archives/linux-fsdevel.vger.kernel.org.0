Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F911D0ECB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 12:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387627AbgEMKC1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 06:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387474AbgEMKCZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 06:02:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90383C061A0C
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 03:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=weCyC5NVRiTB+7U/XIDtQAW9O9u4KYE0XFWvw2zL4hs=; b=XEtOSFSk6pxQRRi5QLFsncsuH1
        dj/NH7VQAsyncYhoSuE3nLZRR8OaLYW2s06X/h+F1WjfcJsoJyn5lZgW/LwQILzd2csNiTaMdzs2e
        6tfnIR4PC2jfs4qtGgOnEcJLHUWCC89AFkp+dB6swjG9pI5rB8NlExdJwFKaYvq/Ksdupn9s0TIGE
        kLJOgvzk4vna/BbVN9PeZ5zBH6zRKtNxAdRtm5AK2KRlaXFzQWcisthtytJsv9FcEd8WiB8e81fqH
        cc9JPe7g38E9J6StvWK+e/hsflIW5RaP6gis8Ntlcjf2XdfWqNfD0f5dVu9EAR+9E0LTmiXZWVnyJ
        RpNZyKtg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYoDY-0002F3-5f; Wed, 13 May 2020 10:02:24 +0000
Date:   Wed, 13 May 2020 03:02:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/12] utimensat: AT_EMPTY_PATH support
Message-ID: <20200513100224.GB7720@infradead.org>
References: <20200505095915.11275-1-mszeredi@redhat.com>
 <20200505095915.11275-5-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505095915.11275-5-mszeredi@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 11:59:07AM +0200, Miklos Szeredi wrote:
> This makes it possible to use utimensat on an O_PATH file (including
> symlinks).
> 
> It supersedes the nonstandard utimensat(fd, NULL, ...) form.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

I think this needs a Cc to linux-api and linux-man.

Otherwise this looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
