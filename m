Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE4D3AAF20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 10:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhFQIzb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 04:55:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38750 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhFQIza (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 04:55:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D1E741FDBF;
        Thu, 17 Jun 2021 08:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623920001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AqMZ6VDXQs8fACSxjEoTa3jWnXqlOeaX0ILKp41Ujpg=;
        b=vt+nizqaqNppg74ojCy5P9EV49Hx8U+2xEiapBW704yiHrbUGgs/d6MGdqxK3PVg/GkS/e
        RmLG2VCA7qqBsKJQ7MGYHGTGsmziJNs06z1QldT/CEjXmHCCf36WDqS67BmefBDMgvjlUV
        srhgdjuc1NB9pzfw/X19pQ/TcfLcXeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623920001;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AqMZ6VDXQs8fACSxjEoTa3jWnXqlOeaX0ILKp41Ujpg=;
        b=wNcM/bzZp+S6rae1Cjx+blaWgX6JIc/huCvNunJbz5gnULci61sK6dgac/Q02qOuAkVL3e
        V86JObPs0j//SiDQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 17E65A3BB7;
        Thu, 17 Jun 2021 08:53:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E611F1F2C64; Thu, 17 Jun 2021 10:53:19 +0200 (CEST)
Date:   Thu, 17 Jun 2021 10:53:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>, ceph-devel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Reichl <preichl@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH 07/14] xfs: Refactor xfs_isilocked()
Message-ID: <20210617085319.GD32587@quack2.suse.cz>
References: <20210615090844.6045-1-jack@suse.cz>
 <20210615091814.28626-7-jack@suse.cz>
 <YMr/eA3Eq2u6yUNw@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMr/eA3Eq2u6yUNw@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 17-06-21 08:53:28, Christoph Hellwig wrote:
> On Tue, Jun 15, 2021 at 11:17:57AM +0200, Jan Kara wrote:
> > From: Pavel Reichl <preichl@redhat.com>
> > 
> > Refactor xfs_isilocked() to use newly introduced __xfs_rwsem_islocked().
> > __xfs_rwsem_islocked() is a helper function which encapsulates checking
> > state of rw_semaphores hold by inode.
> 
> Looks good with the updated commit log:
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I suppose you mean Reviewed-by, don't you?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
