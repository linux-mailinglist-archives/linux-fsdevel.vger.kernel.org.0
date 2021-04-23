Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5956369D98
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Apr 2021 01:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237154AbhDWXxH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 19:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbhDWXxD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 19:53:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81A8C061574;
        Fri, 23 Apr 2021 16:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0RWHCLM3/c6H7Z+k5OkW53M3PGgAByaiGpKPD3i08lU=; b=hp8p+Z8DNn1ZurqXmgj2wcS+eL
        rJTz5xXktIyXySN7NXjYlkC3CaxpMHTDnvl0WySOWRASZ/2hQwb3FSRFd+IC7CdooqCKKIQanortM
        M03aHr+F8Y2h/0tKuCSOOisyBXTJ8RJbnT2LTw3CO2+q8wng0SGU1SbYtPMN6dfVL90vHtFcYOTnN
        r39G7yPrxoFM82lg9bY1SzQXwf26JkjX78Y6tOCl739/tP7daK4bgbvDKnWwWwGSJ7VaVSSKajec/
        wSQyinWy5Nir/Utxh+PzZtksMDvn5wT3zIYm3ihveI6NJ9RK1v6Nm5o0Ash0JG/rUQlI5NoZQi+bJ
        F18mbw0A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1la5aP-002WUO-SQ; Fri, 23 Apr 2021 23:51:55 +0000
Date:   Sat, 24 Apr 2021 00:51:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>, Ted Tso <tytso@mit.edu>,
        ceph-devel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>
Subject: Re: [PATCH 0/12 v4] fs: Hole punch vs page cache filling races
Message-ID: <20210423235149.GE235567@casper.infradead.org>
References: <20210423171010.12-1-jack@suse.cz>
 <20210423220751.GB63242@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423220751.GB63242@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 24, 2021 at 08:07:51AM +1000, Dave Chinner wrote:
> I've got to spend time now reconstructing the patchset into a single
> series because the delivery has been spread across three different
> mailing lists and so hit 3 different procmail filters.  I'll comment
> on the patches once I've reconstructed the series and read through
> it as a whole...

$ b4 mbox 20210423171010.12-1-jack@suse.cz
Looking up https://lore.kernel.org/r/20210423171010.12-1-jack%40suse.cz
Grabbing thread from lore.kernel.org/ceph-devel
6 messages in the thread
Saved ./20210423171010.12-1-jack@suse.cz.mbx

