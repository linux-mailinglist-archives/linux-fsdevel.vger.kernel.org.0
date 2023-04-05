Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5456D741F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 08:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbjDEGHg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 02:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbjDEGHd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 02:07:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D5B4209;
        Tue,  4 Apr 2023 23:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WiEEXVsKjLiv3ZX/pQLFZ2CoYEzAlqUcy1KZrDeOLf0=; b=AWrbQ2OVG6h+3Y4LAA7adja35H
        JEuG1iNUPs3dGYeVH8VH67/tQEy9pWYWZZLX9PIVvy5qUI0ShIBQA1c4wvC94Kfheyb/UH+lVO4Dz
        kLhIXIn3H+Y5BKFhBpwaVXFJ1/soVhoLopS5s4jLQB146Op0Svcn78fMI3RdNQFFeu3taY/eBbVcS
        znu6Qg+5j8U7L/LwM1NesLerUGkfi5eIVVDbfw154jY0Jr1CzHghmyADDZGKm7G3dHpbdig9BGPDj
        GmnJVZptofyDdWGTYeQ4nr/1jraYDFT7kJrwrOxdL36rb5N1SBZF6i215vvZgyqQlMprn8iiuSwg9
        dG1UefsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pjwIS-003SrV-1Q;
        Wed, 05 Apr 2023 06:07:04 +0000
Date:   Tue, 4 Apr 2023 23:07:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
        minchan@kernel.org, martin@omnibond.com, hubcap@omnibond.com,
        brauner@kernel.org, viro@zeniv.linux.org.uk,
        senozhatsky@chromium.org, willy@infradead.org, hch@lst.de,
        devel@lists.orangefs.org, mcgrof@kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] zram: always chain bio to the parent in
 read_from_bdev_async
Message-ID: <ZC0QCJM6Rl39jnGU@infradead.org>
References: <20230403132221.94921-1-p.raghav@samsung.com>
 <CGME20230403132223eucas1p2a27e8239b8bda4fc16b675a9473fd61f@eucas1p2.samsung.com>
 <20230403132221.94921-2-p.raghav@samsung.com>
 <ZCw9Dxdd0C95EUza@infradead.org>
 <20230404123131.6e8fca22b0a484c8c152492a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404123131.6e8fca22b0a484c8c152492a@linux-foundation.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 04, 2023 at 12:31:31PM -0700, Andrew Morton wrote:
> >  I've now sent a series to untangle
> > and fix up the zram I/O path, which should address the underlying
> > issue here.
> 
> I can't find that series.

https://lore.kernel.org/linux-block/20230404150536.2142108-1-hch@lst.de/T/#t
