Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B443D2EFEFF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jan 2021 11:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbhAIKo3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Jan 2021 05:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbhAIKo3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Jan 2021 05:44:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA36C061786
        for <linux-fsdevel@vger.kernel.org>; Sat,  9 Jan 2021 02:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=v6VNlgGujWfNpG+8/JqqgvRUX4
        PegDGmvO7TiYsxohtLfDDDGlt+ASwBWucJUIXr5UbvoUESt+OJqTP2Ulk9mjOTm6r6AzJEwhgjOxh
        vEYse1kyMChSPsGn/MDeEskP3AmJK9I900p8b4Gk9ciLYlh427c2z4eKCIyqF6Cr/1Xpe6wIbZa3O
        5IDGQLog6ppmz/8YQE85WoA9kIoqAewZdBgGMPB9sCyr3xTBhTDVxhTjEovDkgIN17OrvJhcKBZ36
        Ktq46hxce1Dh9Fz4+M8Bw71Q+tL2nLUUL7YgFpaeuG+2yQXBJi9jQoQapzrv1nspY7Yld9RrbxgPJ
        EA5AOSUQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kyBha-000Ssz-Rt; Sat, 09 Jan 2021 10:42:48 +0000
Date:   Sat, 9 Jan 2021 10:42:34 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, Maxim Levitsky <mlevitsk@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] bdev: Do not return EBUSY if bdev discard races with
 write
Message-ID: <20210109104234.GA109579@infradead.org>
References: <20210107154034.1490-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107154034.1490-1-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
