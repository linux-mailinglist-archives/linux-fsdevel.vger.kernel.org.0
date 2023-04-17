Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E356C6E3E80
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 06:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjDQEhD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 00:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDQEhA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 00:37:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E365B1BF0;
        Sun, 16 Apr 2023 21:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kTatpZ/JPuCt7HmNeuwY2c8uE3lVP+FDUVqlA7PFKuc=; b=lpFB6KGEzdz3RUdOPxayUJwKy/
        Ovzcrm5olKw/5wcOmrm5hGDTItHKc41vLuDXecJsjJVmK8vsjquSQiL+XvdLQenrvpQdREj3P2n5h
        juKyIhuvTeUpT7qRGRavVb7sjzeOCbim6HRnMCFmHeN7rsTeOeHQzgMnaWfB0wazBUm6hK4XWAWpl
        QQWtVHvJZsSxnG3vhH52yS6HXTiRDP0RlNxaxjMMeHzvNCTpYpXdp70YcvtPXk8IHjqCGgYAUUKec
        r93nSmunTOKrHEFGR8JQyarE8uu/egU0SUugcYgG3rTrKoSxjqOn060LMZQMji/QRHi0z4ADzdMN1
        R2Ad/QOg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1poGbo-00EqE9-0C;
        Mon, 17 Apr 2023 04:36:56 +0000
Date:   Sun, 16 Apr 2023 21:36:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Pankaj Raghav <p.raghav@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org
Subject: Re: [PATCH] mm/filemap: allocate folios according to the blocksize
Message-ID: <ZDzM6A0w4seEumVo@infradead.org>
References: <20230414134908.103932-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414134908.103932-1-hare@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 03:49:08PM +0200, Hannes Reinecke wrote:
> If the blocksize is larger than the pagesize allocate folios
> with the correct order.

And how is that supposed to actually happen?
