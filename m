Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5DC6D66DE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 17:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbjDDPKz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 11:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjDDPKy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:10:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319714493;
        Tue,  4 Apr 2023 08:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=R4Vlgy9rVnuYXhVEPOKc9LfOWP
        wkSHrPzTbqhHb0P0BtlUOI8ppy+JhTAhtSh/QTFTYmNkd0RkWd1dgaNaO7T39xUgCXod8P92mFGOE
        3q/XLmNAe+K5a7iG534bJ+avne9ZeWqpBPOhujPYnTyYLBe1Mz3ViJQ84/EnNXkuPoPX+8f18tQXn
        VJC10eKI4UX1snLU7q0mB9q0BvH6kwNE6Y0i+AvHAGQTBIk6O4eVViuOrLU6Xn3pBhUN4aW4Wr0Q+
        vf8F4s8XTNpMRlYPZtl6qOLSjArm63lM6xET1WLDIsDF4ul+hdzzzQq31PR7GTAUQIp2fLdC4dul/
        drToEewQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pjiJ3-001wT9-1q;
        Tue, 04 Apr 2023 15:10:45 +0000
Date:   Tue, 4 Apr 2023 08:10:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     axboe@kernel.dk, minchan@kernel.org, martin@omnibond.com,
        hubcap@omnibond.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        senozhatsky@chromium.org, akpm@linux-foundation.org,
        willy@infradead.org, hch@lst.de, devel@lists.orangefs.org,
        mcgrof@kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] filemap: remove page_endio()
Message-ID: <ZCw99c8xjitb8JT0@infradead.org>
References: <20230403132221.94921-1-p.raghav@samsung.com>
 <CGME20230403132226eucas1p182e09f5da7bc0bd284d6a8494cd40903@eucas1p1.samsung.com>
 <20230403132221.94921-6-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403132221.94921-6-p.raghav@samsung.com>
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
