Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD113760040
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 22:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjGXUHT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 16:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGXUHS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 16:07:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13C110D8;
        Mon, 24 Jul 2023 13:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J5wWW1EtFpBIR05IfxoMHzoYojyakUH8TdbRyvGIOTM=; b=dqbo8CdnSUk9Z9Q0jUU79AqTgR
        TcWOjjUyjkkqeo5PB4ZrIkdlieYkyVRlJz4+DZ/8w3Q7GyAlVp0Mi+OmD03aJA63T+0mpGefhi553
        M7GK397iMH4Jhak7mEis7MKfTe9ZvaxGo6zqwniAQry17ceBmQCT0NU8ciNTW1scF3v+rcsdI9Dk7
        5Ld6dKPI0RWwdnUZ1uIFHQuVG3oRbrHUQIZm9ftpPcY1zxbFCFV8P3xuJIVU+VeGEU/VSPgWZzfdn
        AW4QYe+T0gskK/0hgNMWahfGIYEN4zUYPn7qZtk/EGuCBdWA0AauEY9/uwE13etR5+a8M4icYNLzl
        RVDEpyAg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qO1pp-005MNS-2u;
        Mon, 24 Jul 2023 20:07:13 +0000
Date:   Mon, 24 Jul 2023 13:07:13 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] block: stop setting ->direct_IO
Message-ID: <ZL7Z8UAI9HdT+qgA@bombadil.infradead.org>
References: <20230720140452.63817-1-hch@lst.de>
 <20230720140452.63817-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720140452.63817-5-hch@lst.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 20, 2023 at 04:04:50PM +0200, Christoph Hellwig wrote:
> Direct I/O on block devices now nevers goes through aops->direct_IO.
> Stop setting it and set the FMODE_CAN_ODIRECT in ->open instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
