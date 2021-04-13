Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E87335DF0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 14:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238538AbhDMMjm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 08:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhDMMjm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 08:39:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCAAC061574;
        Tue, 13 Apr 2021 05:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y/ADFzMIM8pdreFqwSb6dgmwWS9W+B7TvZ6ngAxunpE=; b=kx3QSs6qxrP7KyLmkodjc3rVtG
        Vi1Rdzv3dRJ+rZgoyJNPGpDh+qcXevOQx/6K4BhqObM/bHbevztoyJuUfFf5qXE5MrpS5++ZAGWHb
        tpZ+xhxdnnBOLut5R0Nc4a8dFvJr4qVGTHEkWwENjHms9iC3duqyAszIMyMSWITqtMnGKh17zW/Y1
        sA6JcChi7AaRfLCg13ohAyhTSqdSXZF8cCqIwhKcO+N05F3GyNPag9Y713dIkt+yplPjE08jWrEnB
        OjwM+VzORhmOVz6D6K1dD2dyW9E734NyomUZdmJOnHFw57dJRCpArsfsNJNHIudcGVi9htFgy5ff9
        wUpQ5NMA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lWIIz-005jYU-9o; Tue, 13 Apr 2021 12:38:23 +0000
Date:   Tue, 13 Apr 2021 13:38:09 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/7] mm: Fix comments mentioning i_mutex
Message-ID: <20210413123809.GA1366579@infradead.org>
References: <20210413105205.3093-1-jack@suse.cz>
 <20210413112859.32249-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413112859.32249-1-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 13, 2021 at 01:28:45PM +0200, Jan Kara wrote:
> inode->i_mutex has been replaced with inode->i_rwsem long ago. Fix
> comments still mentioning i_mutex.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
