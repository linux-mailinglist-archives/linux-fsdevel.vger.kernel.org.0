Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DEF7254BD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 08:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238264AbjFGGus (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 02:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238139AbjFGGum (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:50:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665791993;
        Tue,  6 Jun 2023 23:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7YtpeeH2ZloCa7oviGBzuPhPGGblYtG+hPU7JYhy+So=; b=NGdjk4brJ7DkanZBSGHqcJuAiN
        CL/KGy109Xr62+3U3LStoZNm6rimXwyvjKEwkXphpE+1JZs90LteSB8wW+q+6QmUqLRxI0XBJAvhw
        +07I/KHFCYrMXl8/hjtN/XCUnGlvwAY8bAXbJXGzUJO9baQI96xZKY/2cBSj960CHU2kHmYiiK0YV
        QJJ0cFOrKodtYtrcDKO3sBqPz0tw5rXb43M5sCTQsYiv2ndNMR2H0+BAvpP4GO2l2iBpH/dO8nfZd
        m8MX1lpaUZEOEajvmH/azRMtf+1XUx9YLPMJ6mDmvWUa4axBBQosd9VWcXVHQuEN2JB0oet7BST0S
        xrnnULrA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q6n04-004cdZ-1g;
        Wed, 07 Jun 2023 06:50:32 +0000
Date:   Tue, 6 Jun 2023 23:50:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv8 2/5] iomap: Renames and refactor iomap_folio state
 bitmap handling
Message-ID: <ZIAouOHobxGXUk5j@infradead.org>
References: <cover.1686050333.git.ritesh.list@gmail.com>
 <54583c1f42a87f19bda5a015e641c8d08fa72071.1686050333.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54583c1f42a87f19bda5a015e641c8d08fa72071.1686050333.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 05:13:49PM +0530, Ritesh Harjani (IBM) wrote:
> Also refactors and adds iof->state handling functions for uptodate
> state.

What does this mean?  And please don't mix renames and other changes in
a single patch.
