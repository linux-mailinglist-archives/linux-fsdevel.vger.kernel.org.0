Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAC672B815
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 08:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbjFLGbx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 02:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjFLGbv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 02:31:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A32CC0;
        Sun, 11 Jun 2023 23:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=AeO5fskl6N35duZJ4s956Gqtqv
        ouLgzRr3JnX1HotiygvhJGwBnT0fe921mjT/CMdSfjGAmUD4EXzdBZdMtHYKH7VpJA3jyIyfJDL5E
        vnpMFROyM6rCyIdKtGsBvxR3K+POo5Ur5vxjKjFWlQV6FiNIRSHrL7Rp4s08sEiKDm433eWL4TUvx
        Pqy56FnQoWpy88pArdu6YvddUfrBgSJzVKq8jzSpLR6fCcbzvy5XlanKra1fFi0qe7Ohh7a7IY31i
        vAxlDEUzYw72gGhArZnkKQeDwxRY70G7W0rDHDVQKOMakvy6J5/ro2GF8UdYPJWmIrjK8yGM1idQT
        PJ4MP7aQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q8ayO-002kxw-0u;
        Mon, 12 Jun 2023 06:24:16 +0000
Date:   Sun, 11 Jun 2023 23:24:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv9 2/6] iomap: Drop ifs argument from
 iomap_set_range_uptodate()
Message-ID: <ZIa6EGjfllj7vMI6@infradead.org>
References: <cover.1686395560.git.ritesh.list@gmail.com>
 <183fa9098b3506d945fed8a71cadeff82e03c059.1686395560.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <183fa9098b3506d945fed8a71cadeff82e03c059.1686395560.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
