Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA1448A9CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 09:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348946AbiAKIsS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 03:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbiAKIsS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 03:48:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190C8C06173F;
        Tue, 11 Jan 2022 00:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oCC1C+R9OvJoDxLxYCdtZrEWYM54eVfNqXXADv0XQd8=; b=mxra0n0y2lEkyVogyTa7o0aYKl
        9WRP21xxQCcR/rzF4Bpqh/A+cLPOx7DjXovG3YDPqsG75h/N5M5Xw6kdWacnZ5VwOjI4NOoIyFJOe
        p6d2oCETCVa1jPmOF+7xD/x4aNCZUZvVzp5yYN31RauQMp20QP3V5af3/6IkYxVt07cx0aWY2pchY
        9UrM/C33srYJqhNIf7W8dx+cKbfZ16vS+6Krk0cGbZjp8qXyHNZ6lPn+re5/It/ta7uf5ks4oQmkS
        YlzHW+9TQrlhj5T/MEjEAuMwwjpibqFxUBk2Z0OKv+SIxmgCvN1IJXulnzVWOPImALVdrwndCWarS
        Sh7hij0Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7CpC-00FP8D-29; Tue, 11 Jan 2022 08:48:14 +0000
Date:   Tue, 11 Jan 2022 00:48:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     richard.sharpe@primarydata.com, linux-nfs@vger.kernel.org,
        lance.shelton@hammerspace.com, trond.myklebust@hammerspace.com,
        Anna.Schumaker@netapp.com, linux-fsdevel@vger.kernel.org
Subject: Re: [bug report] NFS: Support statx_get and statx_set ioctls
Message-ID: <Yd1ETmx/HCigOrzl@infradead.org>
References: <20220111074309.GA12918@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111074309.GA12918@kili>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 11, 2022 at 10:43:09AM +0300, Dan Carpenter wrote:
> Hello Richard Sharpe,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch bc66f6805766: "NFS: Support statx_get and statx_set ioctls" 
> from Dec 27, 2021, leads to the following Smatch complaint:

Yikes, how did that crap get merged?  Why the f**k does a remote file
system need to duplicate stat?  This kind of stuff needs a proper
discussion on linux-fsdevel.

And btw, the commit message is utter nonsense.
