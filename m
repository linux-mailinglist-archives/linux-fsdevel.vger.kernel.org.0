Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3A253F5D0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 08:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbiFGGBG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 02:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbiFGGBC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 02:01:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104C6D7714
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jun 2022 23:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=x1ROi6B9tChFUx8PsMmy2KTTeu
        taMLqq1NKjiSKLcTsbyh9+89c20bsaRf0aufL4bYJQXDVmtZtM12nL3QgC283GGuFX82lkVjAB8Pu
        wFaQuhFfZJk0ZpnpeIWurN9W9nmUMFpRIi/QNXLCIZbw+xl88ewmnf1k68SjWel1ZwhULdZR3vjAt
        oIrN8Rkid52O4BNOTQASRD2Iw8w+2kjbJGwHWw7XqTXg0steovh24KXDPxoPe4H/BDIzSmhPkLduG
        pcyc67C7hPgk078B/wxnBeFDcwcsYTcE6g/ePJG3TeOO8fQ8RAC6jJNCBbA9ztVosfMqDzywWV42Y
        fvOa9gOQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nySGy-004ugI-LC; Tue, 07 Jun 2022 06:01:00 +0000
Date:   Mon, 6 Jun 2022 23:01:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 1/3] zonefs: fix handling of explicit_open option on mount
Message-ID: <Yp7pnOoIg39SZjoB@infradead.org>
References: <20220603114939.236783-1-damien.lemoal@opensource.wdc.com>
 <20220603114939.236783-2-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603114939.236783-2-damien.lemoal@opensource.wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
