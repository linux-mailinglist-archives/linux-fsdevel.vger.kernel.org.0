Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B2F202253
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 09:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgFTHaE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 03:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgFTHaE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 03:30:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDE5C06174E;
        Sat, 20 Jun 2020 00:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UvKEmb6jS2MXMiO7x+uKUoicZmr4lYKrl16up/nky+E=; b=MPkZ5bk3glpMtqFAkpXCtVxgMV
        G+lYO/1IYVabLxVXHvMg72y7eREF5vC+9+9iuK66QPbysfYW6gbVmYEynvuXV7/qWtUTKcryCLMcO
        gPPwYk9nBtdYt/qRK4AbTTfNtQf1/mNbEzSum32D3t3L6XdYD5ZpZ0Ma9KYf3De4iwSiBwn1vFd7C
        3x1bmU7AOoFJ3plJYk85HRD/BuBFf7L/yygQtE+XpYUB3tJzLA1tSxpKPjvgneuBodpAUaSWfMLp/
        lplvi4zqdI2lM+aEEbYnBVLreZbcaeVjV2x6M9RgDCr4F3yDVUmRxmAofi1uXu9k5/TU4pD5iWGiA
        xXoOZB1Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmXw4-00017X-Tq; Sat, 20 Jun 2020 07:29:08 +0000
Date:   Sat, 20 Jun 2020 00:29:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v7 6/8] blktrace: fix debugfs use after free
Message-ID: <20200620072908.GA3904@infradead.org>
References: <20200619204730.26124-1-mcgrof@kernel.org>
 <20200619204730.26124-7-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619204730.26124-7-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Still not a fan of the wall of text in the commit log, but the changes
look good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
