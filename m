Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F06F74CAE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 05:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjGJD4F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jul 2023 23:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGJD4E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jul 2023 23:56:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D415D2;
        Sun,  9 Jul 2023 20:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ycC1hTLjqeCMEzyLaczbSTgOiRkSdIfqs0kYgWXDjys=; b=QjzIjnbJLnMqwC4LcBjfYhZAHQ
        m7iluvCs9rBOOmb8Dd8VH4+u9NX6+wV8Qk16EWibF8vVEE1KeFSjJ2wTCvMpCDsY8X2uCknWd249w
        qLCnEITV53xoWbKR7lCeiVJssSzER6SWe33iEQh1jE7BEd7nYKRDMg8pvvNIaJ0+bPUSv1MDkKx+C
        Qf5crlFn24Dz6MzHq+FTuZPk+al5sQqUQxJFP6o6XEOFyoVMEGDySbVPlNS2U2Mg/UB7EuIsOT6Uo
        UHMn7IKXApNUliAvnJGDPZyLRcLdliT5wcpOBikUi5bXrsvVqL4c1E4l5GRkK4OBrKXca/P/FTtK4
        hjDPiBBg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIi0E-00EFlN-L7; Mon, 10 Jul 2023 03:55:58 +0000
Date:   Mon, 10 Jul 2023 04:55:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3 0/8] Create large folios in iomap buffered write path
Message-ID: <ZKuBTi/eXKKZxGez@casper.infradead.org>
References: <20230612203910.724378-1-willy@infradead.org>
 <20230621200305.23CB.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621200305.23CB.409509F4@e16-tech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 21, 2023 at 08:03:13PM +0800, Wang Yugui wrote:
> This v3 patches broken linux 6.4-rc7.
> 
> fstests(btrfs/007 and more) will fail with the v3 patches .
> but it works well without the v3 patches.

Sorry, I didn't see this email until just now when I was reviewing all
the comments I got on v3.

I think I found the problem, and it's in patch 1.  Please retest v4
when I send it in a few hours after it's completed a test run.

