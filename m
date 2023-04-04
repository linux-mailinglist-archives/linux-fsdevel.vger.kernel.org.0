Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED0E6D66CD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 17:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbjDDPHY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 11:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbjDDPHU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:07:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF0544BE;
        Tue,  4 Apr 2023 08:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=YgKkCKX0Do7zsrQOcRqBMSQwh0
        Bn/Kh+pIgdfFz8MaTHesmKZWuSDHjGo/tlMOhDY5HYdNh1uPEs2v+Fn0Vty/bizxUjDoi26mak1r0
        smXfM+MYZFDeJVWgEX1iyYOL7tOMg3i/eRrntYkkd3fyMiqYkcSILrfWSioVrTTJfYrZHtxs4RO5w
        ovkfw0hC8sQ4b5CD+XJTBuuY/Ewa3W1wyOQxvTrn6Ti9Mb6cDNBeTaxVNmtOr+MoY4pTC7h7J+7YO
        0kspt0KCDflG2B9SVZPs1rciT7ddqbbl2IPNf+fHPQDF05vzQ9E7TBa52cykBDI2V43YvQGUNHTdD
        FfGclo+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pjiFc-001vzT-2i;
        Tue, 04 Apr 2023 15:07:12 +0000
Date:   Tue, 4 Apr 2023 08:07:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     axboe@kernel.dk, minchan@kernel.org, martin@omnibond.com,
        hubcap@omnibond.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        senozhatsky@chromium.org, akpm@linux-foundation.org,
        willy@infradead.org, hch@lst.de, devel@lists.orangefs.org,
        mcgrof@kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] orangefs: use folios in orangefs_readahead
Message-ID: <ZCw9IDcyFcIT/9Hm@infradead.org>
References: <20230403132221.94921-1-p.raghav@samsung.com>
 <CGME20230403132224eucas1p28f82802bc40d4feb5a30bb59c6536ab3@eucas1p2.samsung.com>
 <20230403132221.94921-3-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403132221.94921-3-p.raghav@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
