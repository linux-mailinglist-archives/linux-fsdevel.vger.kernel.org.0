Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566C66E23FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 15:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjDNNGx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 09:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjDNNGw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:06:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B6A269E;
        Fri, 14 Apr 2023 06:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a7uVri7lJkNYdLXa9nTsHNwRFKHH3fmlJle0oiZUJUc=; b=QOZk1zGQh/c8rQTFozR3dgbCES
        4H1pF/gCflNH8O5Xcq30nz0QZZ0O3g8IDItFc2bF24qc3HRJI21Eh+vYEjS1pB/rl8M6XrqPjtx9v
        6YY2yoNXcSdsrPUfqx8uBWjNNHzX9cGU/LK2mczlGV1wKE1JK9x9gF/jFrPbVbWEXDVCE3aJlxNS6
        QIV2rLiaLvSz6JVv63J2vhX58n+QcFbUw3gCVcs+616iWL+f5kdyooWwg6n9N8OwaWj/XMhamlUAj
        rXw6G2gtRnHbOQLKH69zJRfcFFe536SqCzTA8mn1Inm4xVFo0kFgXvUtFqZ4isy2SyT5x15E0p07K
        XAQLzLaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnJ8a-009dKj-39;
        Fri, 14 Apr 2023 13:06:48 +0000
Date:   Fri, 14 Apr 2023 06:06:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv3 10/10] iomap: Add trace points for DIO path
Message-ID: <ZDlP6EiwKDE35ZG7@infradead.org>
References: <ZDjs+/T/mf1nHUHI@infradead.org>
 <877cuezykp.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cuezykp.fsf@doe.com>
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

On Fri, Apr 14, 2023 at 01:26:38PM +0530, Ritesh Harjani wrote:
> How about this below change? Does this look good to you?
> It should cover all error types and both entry and exit.

I don't think it is very useful.  The complete tracepoint is the
end of the I/O.  Having a separate end one doesn't make sense.
That's why I suggested a queued one for the asynchronous case.
