Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01050228507
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 18:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgGUQLr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 12:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgGUQLr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:11:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287A0C061794
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2020 09:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bH+cUPJPphAqEBb3zIzkTsxg+e1ZZ8w2WzrxoFYs20I=; b=mqQUMJQMRHPwZU9jGFD9yLwVXt
        gA+Qf3MYzpYR0W5hCTVtFyTjSaCmlXDII9p7F9VEPxsIzMeWudj0FjVbkR9EoC85OFo2cLOzNV8pS
        Af5hFb4xrHZr9g6gJZFwl5R/wOlfeENzRVt/uaez/CVc8dCVsYabhrxb/RifEmqDF8gUVyja8W4Mq
        NZqRdEeDEzza5HgJAKoNQT/cJDIKoEd9TIxT/xJLL0c+IY4rSoPZX2aQwsMEcJo3Qf4NQx3WTgnvl
        30G71smV6YsPIRqhnE7fgE/EHKp+7cs6kVHZt1yHneBP5M8kNqSOoF/Oc1T/NNbm9P9U/tvEBm8yv
        uv43wGvg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxurm-0006Vs-LR; Tue, 21 Jul 2020 16:11:42 +0000
Date:   Tue, 21 Jul 2020 17:11:42 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] zonefs: update documentation to reflect zone size
 vs capacity
Message-ID: <20200721161142.GB24880@infradead.org>
References: <20200721121027.23451-1-johannes.thumshirn@wdc.com>
 <20200721121027.23451-3-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721121027.23451-3-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 09:10:27PM +0900, Johannes Thumshirn wrote:
> Update the zonefs documentation to reflect the difference between a zone's
> size and it's capacity.
> 
> The maximum file size in zonefs is the zones capacity, for ZBC and ZAC
> based devices, which do not have a separate zone capacity, the zone
> capacity is equal to the zone size.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
