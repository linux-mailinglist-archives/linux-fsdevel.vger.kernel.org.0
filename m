Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1B9280BEA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Oct 2020 03:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387484AbgJBBX0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 21:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgJBBX0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 21:23:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A4FC0613D0;
        Thu,  1 Oct 2020 18:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=x7/ItltEQOQ7BIFa5bsIwt2tPDfdSHRTJLgJ/0nJlFQ=; b=gkSyLctsfD6q3LOEcxXLgL1+Oy
        pBng/ERGjdC3+DUSjaIJkXrH2kSxYfP6cndouKOsdZeZBUo8L3kJIf9iZ8N5P1DQ++bGFMjmyi6c3
        N4kp8yN7XGDV2nCGL/+S8aFCmbmiceP7vIe/FQkK1ldA2bDT7Ct6KwoA1eKO5cbOFEmeNEH0tIJoZ
        tNnsGPtsM5mAshMgz/GrgWwws+Y+0o0ekZ4m/5uQeeS1tjXU/8NxlxuF+24gtHDg/Juu1Z/dp1RdJ
        lu1HdFCA0xtgqowjFzdxeApInE7KgVqc+BGfR65a+WqOu6JvgrBvgsraV05De15qPsHnnr0DQKdbl
        FQTWdQcA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kO9nA-00075A-8I; Fri, 02 Oct 2020 01:23:24 +0000
Date:   Fri, 2 Oct 2020 02:23:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: VM_HUGEPAGE support for XFS
Message-ID: <20201002012324.GX20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Today I decided to implement VM_HUGEPAGE support for XFS.  It turned out
to be a rather simpler implementation than I was expecting because I
could reuse the readahead implementation.

Feel free to try it for yourself:
http://git.infradead.org/users/willy/pagecache.git

The patches up to "fs: Do not update nr_thps for mappings which support... "
are in linux-next for 5.10.  I hope to get the rest into 5.11.
