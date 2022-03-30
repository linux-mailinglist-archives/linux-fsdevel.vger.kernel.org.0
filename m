Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879EB4EC771
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 16:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347513AbiC3OyW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 10:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348039AbiC3Ox4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:53:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD64275E2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 07:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5/ricqbiDPwfrJS4t/rTmdvPSm2J1maLy6/RO0YRXfg=; b=JMLq/Ts9bIDwrXcyXzxDFvGgv+
        Io9ItUukU4OSNu8QvcTfeDjhyf35V/dspnw6ZISid2AiNvhjst8eTTiThG5Mp6jXctfiQDusZTYLk
        n5l3UJtTmeU5hGuvAdq5O9yV5bISmkpuuOp6hBUj4pOCNKSczNR/rkGjDadxhY8v/5e7IxNznEBSD
        9UJIhuBpgDfTDqW7xdQ6vzxDng5a6TyU2FBfFVcKyKPLtRGc2SjP45lw7HBLU02/RDudiX7AQIIsx
        mkWlBj5DjdDKncEzm8zh7TBZse/cZbiW+onE/Uh3ODwIEDBwqY4WPBzf+oz22OvzC7Qh33/ecb3ty
        Tm151QnQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZZgB-00GJMr-Dk; Wed, 30 Mar 2022 14:52:11 +0000
Date:   Wed, 30 Mar 2022 07:52:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/12] iomap: Simplify is_partially_uptodate a little
Message-ID: <YkRum3GLyIrYdSgX@infradead.org>
References: <20220330144930.315951-1-willy@infradead.org>
 <20220330144930.315951-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330144930.315951-4-willy@infradead.org>
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

On Wed, Mar 30, 2022 at 03:49:21PM +0100, Matthew Wilcox (Oracle) wrote:
> Remove the unnecessary variable 'len' and fix a comment to refer to
> the folio instead of the page.

I'd rather keep the len name instead of count, but either way this looks
ok:

Reviewed-by: Christoph Hellwig <hch@lst.de>
