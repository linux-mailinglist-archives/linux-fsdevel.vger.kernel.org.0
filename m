Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E0929E939
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 11:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgJ2KnC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 06:43:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgJ2KnC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:43:02 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 295B020790;
        Thu, 29 Oct 2020 10:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603967490;
        bh=HXET6Sjd/XhqjxEpMrKxSbdUD6eZQJtbK12yr1iNZ5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vP/4bRzrpqSbGbir43yhZvg8ndvIjvXsFAd05VV5h5Sxqt8lffbOJdQlvRNeR3eH6
         SfTnvxilCRrkvg6NkW81J4+74tJqKGNAjsrA/T7Ac1gTB1cY/1XZfNFrVS68HmKIo4
         c4b85t5336OjbZZ55sJ41HfJngWKIIKAs+t8Fqd0=
Date:   Thu, 29 Oct 2020 11:32:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] seq_file: add seq_read_iter
Message-ID: <20201029103220.GB3764182@kroah.com>
References: <20201029100950.46668-1-hch@lst.de>
 <20201029100950.46668-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029100950.46668-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 29, 2020 at 11:09:48AM +0100, Christoph Hellwig wrote:
> iov_iter based variant for reading a seq_file.  seq_read is
> reimplemented on top of the iter variant.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/seq_file.c            | 45 ++++++++++++++++++++++++++++------------
>  include/linux/seq_file.h |  1 +
>  2 files changed, 33 insertions(+), 13 deletions(-)

Tested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
