Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B936E3AA2F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 20:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhFPSOv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 14:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhFPSOu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 14:14:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0CCC061574;
        Wed, 16 Jun 2021 11:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MuF3tqKRkX1vM/B/YO9X+mRTQgGglhhClGmmu8uhBFQ=; b=BgfrjOjiQwRA0qlZPBPoa5DO1F
        9HrsSL7GTN0OWdodr/djKu/aZbgOq9sva112QMNJZj/Y8VbaQ3aE4/1IRIz4z7ROSOyKYv8PTBY4u
        OmJYWINCZx08vANmfjZ/d2rG/yRaILDw0zqErwCIMeCOzS/0aU6Up1k5LXNMx5WmTj/z9Az37UWXV
        vibBg1WzFFRviAUw/EN83fni6J/f5fxZtxiX0ElzhTrilVPE8DIRXj/SxRoMytKSbU3IJWCd6tJie
        3sBfKbzUwEGea9Pv+pr5iAFRDtv7MpRa6cMbygbXLDqO1kqTy4EzLs/zi2+iBTZsBirZpA3r/gQF8
        /nXvMY3w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lta1P-008KlR-6U; Wed, 16 Jun 2021 18:12:17 +0000
Date:   Wed, 16 Jun 2021 19:12:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 5/6] fs: Remove noop_set_page_dirty()
Message-ID: <YMo+/8fHRPSBo13X@casper.infradead.org>
References: <20210615162342.1669332-6-willy@infradead.org>
 <202106170217.rhpTz5D0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202106170217.rhpTz5D0-lkp@intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 17, 2021 at 02:10:04AM +0800, kernel test robot wrote:
> >> ERROR: modpost: "__set_page_dirty_no_writeback" [fs/xfs/xfs.ko] undefined!

Thanks; Andrew already fixed this one.

