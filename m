Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F15695BE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 09:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjBNIEF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 03:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjBNIDr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:03:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D46E04D;
        Tue, 14 Feb 2023 00:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JkJCxc00zaXXuFpWUNL3qe3F+eHR08FRzGSnwwW48cc=; b=KrFUKCujPaf0pN7hKXrIItCxVf
        RXb0+e+n4SMtNWCa7cxBLuUo+jhAAvhKZBuvyhH+WEaLxLNb2fWdn8Oaxlb6zLJKVZnlfBcDat1GW
        chpaGkUlaJTTAKA0qkdiYiqxMYv8otyK6SIU69H6KysiZhy85DuZh/Fo+DqyTniAnC8KhjKWN2gzT
        aDclgk804UgLc0Rl2D3FRzxC4JKZCZNDQ+ycXtBUCsq7XSulP5RB3/4j5mgkhPYlfm7lzxK/7+rCq
        MousrBLV/guUFXe+PWawTEAnLqnEq7th1uOrz7rmsDuREfNWNeE63AXjvHY7Mzol/2CmC1fUzVymm
        g5Iy+HwQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRqHW-000Qmw-AH; Tue, 14 Feb 2023 08:03:19 +0000
Date:   Tue, 14 Feb 2023 00:03:18 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] xfs: report block map corruption errors to the
 health tracking system
Message-ID: <Y+tARjFLhxzK6Vt0@infradead.org>
References: <20230214055114.4141947-1-david@fromorbit.com>
 <20230214055114.4141947-2-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214055114.4141947-2-david@fromorbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 14, 2023 at 04:51:12PM +1100, Dave Chinner wrote:
> From: "Darrick J. Wong" <djwong@kernel.org>
> 
> Whenever we encounter a corrupt block mapping, we should report that to
> the health monitoring system for later reporting.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> [dgc: open coded xfs_metadata_is_sick() macro]
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Just curious:  this is probably from a bigger series, which one is
that?

