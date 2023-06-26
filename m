Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225B273DEF7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 14:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjFZMXp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 08:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjFZMXZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:23:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E362720;
        Mon, 26 Jun 2023 05:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QW8TEI4qH5XCRgSwvkSbDgPot3AE97HrQk+bQXZ3kvQ=; b=QitTNH+/N/BFpZARCix979ERxI
        b6Iptj9RWzhdn7qboGO3PfmG88sySWpFQ2qT7DxL6W+TgoK93OCGrZ1g/1d9gVnCI0B0voOq1+wi/
        2exEGgCCYkK+z0TLkLYcK9ItLpUdUx/rADWxvJaYAoEpjSfEcLR22gjwGgwzRaHgQh3DozSZc2YZX
        mvpwRPq8SaZz869b/ZAgYhCx1yZu/SJ4bQImIQCs/8vW+0RrxPmf6Q2fEN0soDXZnS+61zR0HGNzq
        bdIJIApXUsUtOEcKJOzovxhjVcHrowVDprRtfLJNJwgyGToLhiAPQoQw6eNi0FcTb2kRzeWvAstA1
        CZWkyyNg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qDlDp-001hfs-4K; Mon, 26 Jun 2023 12:21:33 +0000
Date:   Mon, 26 Jun 2023 13:21:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com, hch@infradead.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com
Subject: Re: [RESEND PATCH v3 2/2] fs: convert block_commit_write to return
 void
Message-ID: <ZJmCzUD3CYv/ZV06@casper.infradead.org>
References: <20230626055518.842392-1-beanhuo@iokpp.de>
 <20230626055518.842392-3-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626055518.842392-3-beanhuo@iokpp.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 07:55:18AM +0200, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> block_commit_write() always returns 0, this patch changes it to
> return void.
> 
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Acked-by: Theodore Ts'o <tytso@mit.edu>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

