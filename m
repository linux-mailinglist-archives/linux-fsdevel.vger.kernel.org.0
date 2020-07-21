Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C96A228506
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 18:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbgGUQLe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 12:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgGUQLd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:11:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0AFC061794
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2020 09:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RWiF3NwGBgrRKWnJoZttIvgTzM2rp7aYwA00ywyD1+U=; b=GSVzJ7U/2BXlo1+NyXjJAUNtfC
        qv9K1e5+oXyvrYIkp/hyr61zdXrwwyf89MD3WUbK6VXDnIqfDKGNSZDaGtxI22wutRHkFUZLLvCnQ
        XiU29kr+EANfh6FsRDIYzymc7hT6DcpQXTp+SWKYDyLkioICMrf6NO4w4bEf354VVIS5JIpz91FLR
        9tKC3L/TfXX/j+KbmgVLUDygXK7JPNLm4tYZjdJusGNdMjyVFaY6XOsovlKfquIVNJPsheGtKaua+
        IK8fbeLVIAC0291sVwjUTJw5eJz0PsZAhd6znAhtlypnomea01+ZnopoGrSpFYso5W+j0/rI0PmJt
        0exHGgtg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxurY-0006V3-Q8; Tue, 21 Jul 2020 16:11:28 +0000
Date:   Tue, 21 Jul 2020 17:11:28 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] zonefs: add zone-capacity support
Message-ID: <20200721161128.GA24880@infradead.org>
References: <20200721121027.23451-1-johannes.thumshirn@wdc.com>
 <20200721121027.23451-2-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721121027.23451-2-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 09:10:26PM +0900, Johannes Thumshirn wrote:
> In the zoned storage model, the sectors within a zone are typically all
> writeable. With the introduction of the Zoned Namespace (ZNS) Command
> Set in the NVM Express organization, the model was extended to have a
> specific writeable capacity.
> 
> This zone capacity can be less than the overall zone size for a NVMe ZNS
> device or null_blk in zoned-mode. For other ZBC/ZAC devices the zone
> capacity is always equal to the zone size.
> 
> Use the zone capacity field instead from blk_zone for determining the
> maximum inode size and inode blocks in zonefs.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
