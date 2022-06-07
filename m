Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665AA53F5D2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 08:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbiFGGCo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 02:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiFGGCn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 02:02:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EC0764D
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jun 2022 23:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=KP+BjgH4hA0iqoRNXSpVWMqCwC
        x4e4DH5czNBWxMeeHfzdrKbD5+49FolfGAn12+kWhESFks3QYIW+rkx06R66sZIs9hwHWNGa3H67U
        9U2g/sjcXF5r/4W0kmeHbucHRVZiQfzxcphlNDb1sv6HttjBsBg6WOomia1DV0t/iaU2arMsc/ddB
        r1SFdwkibqgcfVtWaOwnhS1BkoUKgHItme/FcO+iV9i8qpEAQ8M6Ne0wzI7WlpjdQcTSn/AKcQydC
        LvZcgBtwyF19++SSaCcPNgqlQdoDW8/omOfzHaC8PVbxpTTlERpZMBEB/JDDQ052/0elab+ljKcIi
        IwLpl1Aw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nySIc-004v1W-3O; Tue, 07 Jun 2022 06:02:42 +0000
Date:   Mon, 6 Jun 2022 23:02:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 2/3] zonefs: Do not ignore explicit_open with active zone
 limit
Message-ID: <Yp7qAoPAFPRZEybv@infradead.org>
References: <20220603114939.236783-1-damien.lemoal@opensource.wdc.com>
 <20220603114939.236783-3-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603114939.236783-3-damien.lemoal@opensource.wdc.com>
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
