Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8F4615CDA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 08:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiKBHS2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 03:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiKBHS1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:18:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD874C5C;
        Wed,  2 Nov 2022 00:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=M18BszLNrlBywvLrgE18hKdQTI
        eWfVIhnkM9JFtD4HAPHRamTS/tyHqzvxnYvxTDL2+UidhjrH5bQUGAes2TSKChrSdMUTJnpkLKPen
        Xp/GdmKg8/Df3cPakkMuX4RDac/R3UvJH6XlK++MVxbmDBIW6+kI2TNqmMeVnEGGJw+gqKOOWtXDK
        6aQ1Nb+CcGX2zq2m55a37xwxwLl4touowkNe/rhkQTBNkPHS8iSUObVYVng6HBwo9oQOhatq2t5j1
        mNhJChS1eO1a7ANVqd79U01Smwe2zhr3nt/gF8K9+iABSrtyPrGGJFsxG/PvkQeanNgT7onQvY+9q
        G8pL4Kzw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oq814-008bcL-Bt; Wed, 02 Nov 2022 07:18:26 +0000
Date:   Wed, 2 Nov 2022 00:18:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/7] xfs: punching delalloc extents on write failure is
 racy
Message-ID: <Y2IZwr5a3FYAptVS@infradead.org>
References: <20221101003412.3842572-1-david@fromorbit.com>
 <20221101003412.3842572-3-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101003412.3842572-3-david@fromorbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
