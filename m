Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF8E1F045F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 05:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgFFDOF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 23:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbgFFDOF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 23:14:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D143C08C5C2;
        Fri,  5 Jun 2020 20:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1BrkHY9S/k3MVQiB0H5PSL2SCm/KMOh5iXjQyg7vRA4=; b=kokRMdy9d9tCcLDjbKUnuPgFs9
        f84UqG95kS6fiykPUXnU4MK1TX0DI0t3Ljf8VirBwPwOhsW7LatC6TlCW0vBcCQE5jG1XmwS2NzPE
        +lmcUEq/gFxI8CvQQQg0lLERExA9mmdPAt2ZxLKrra2x503KxbHa9VVWaI1PZd4XErFy9IuT0N+qR
        A1LgIZ8Tsn3xNutC4AiwlwStT321O+wbN+BxZMa/+WDhAULF1CJnRVk/eMyA3l23h7b1ZrO48/PUG
        IbRwFiRgb2YxnPsGrHRJ0rFM1BZzCFUUMDJXOqj0vFMZOZmuuz2LiSuptFQc9oTnWMkaO+SSQf7qW
        qmlfPrbQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jhPHT-0004dr-Lv; Sat, 06 Jun 2020 03:13:59 +0000
Date:   Fri, 5 Jun 2020 20:13:59 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     darrick.wong@oracle.com, linux-btrfs@vger.kernel.org,
        fdmanana@gmail.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 1/3] iomap: dio Return zero in case of unsuccessful
 pagecache invalidation
Message-ID: <20200606031359.GL19604@bombadil.infradead.org>
References: <20200605204838.10765-1-rgoldwyn@suse.de>
 <20200605204838.10765-2-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605204838.10765-2-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 05, 2020 at 03:48:36PM -0500, Goldwyn Rodrigues wrote:
> Return zero in case a page cache invalidation is unsuccessful so
> filesystems can fallback to buffered I/O.

I don't think it's acceptable to change common code to fix a btrfs bug
at this point in the release cycle.  This change needs to be agreed to
before the -rc5 stage, not during the pre-rc1 window.

If you can't fix this in btrfs alone, then back out the btrfs changes
for now.
