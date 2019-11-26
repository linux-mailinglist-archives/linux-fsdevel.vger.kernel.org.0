Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 301C5109823
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 04:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfKZDnr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 22:43:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48996 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfKZDnr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 22:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=O9aSwAcar6p1taSqsuS96zzbuJGucnCb3oGHCfogu2k=; b=P4WSwdSua8Va4qsHSeQGtL0S/
        ISmXu9IZDvWuFF2hf74ZX7EYeDzfIttYbn+ucPOcobp2w3/sfzWAR+T2BpBkn2KMl/YlI+CR9SnbC
        6RdHBr8hdQiyl5zY+EjtcuAACAt2O+U9LGpwb87Eb6SQqj+aMi8sDnfIh2FKwVeCS12eboBNV+QQ6
        dey5kAxKElU71V6XYHdw9Dg/bwQOgtTTsi/1NKSdT/XEjMKZ8PDINW7vhUIJ8UMFdNQ+92f3nqT9a
        Eh3kKfzmcpDBX/3ODX/ct/VtlNypbDUJJyExNivVsoLWb22AijELYD72ifQZbxG4xkCw3hBpgDhLs
        XqJUjD8bg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iZRlR-000620-PX; Tue, 26 Nov 2019 03:43:45 +0000
Date:   Mon, 25 Nov 2019 19:43:45 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, darrick.wong@oracle.com, fdmanana@kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 1/5] fs: Export generic_file_buffered_read()
Message-ID: <20191126034345.GC20752@bombadil.infradead.org>
References: <20191126031456.12150-1-rgoldwyn@suse.de>
 <20191126031456.12150-2-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126031456.12150-2-rgoldwyn@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 25, 2019 at 09:14:52PM -0600, Goldwyn Rodrigues wrote:
> @@ -2003,11 +2003,11 @@ static void shrink_readahead_size_eio(struct file *filp,
>   * of the logic when it comes to error handling etc.
>   *
>   * Return:
> - * * total number of bytes copied, including those the were already @written
> + * * total number of bytes copied, including those the were @copied

"those that were"

