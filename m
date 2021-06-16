Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81EC13A9567
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 10:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhFPIzS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 04:55:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51338 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhFPIzO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:55:14 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3785121A24;
        Wed, 16 Jun 2021 08:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623833587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oxGdDHsozXNdxVBcMTnfRLsug90r69T25ARBDtbntyA=;
        b=LsIoyQo3y3jZK6iYT6qpOHtEBnsukk3Vi+/RWO+92uZkR0q03c6TBQ0B5CU8KM+QrgFTs3
        E8iil+lsQ0ADkqJyjlPsKpGDzT7V3B1ZwTbzwok6Utjw25vol8hEatNgGKqz0HDDDpVozi
        RBw73kTkulONM8nvb2UKyszzcHS4CwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623833587;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oxGdDHsozXNdxVBcMTnfRLsug90r69T25ARBDtbntyA=;
        b=Cd/rE56FeKGW7aufMXqVHJ9XF4xj24JOWYzVHMVZjsuoQRzk9nxMDxtS1jr5muCo1d29ir
        FblE0OV602i/3qDw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 687ABA3B9B;
        Wed, 16 Jun 2021 08:53:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D7E651F2C88; Wed, 16 Jun 2021 10:53:04 +0200 (CEST)
Date:   Wed, 16 Jun 2021 10:53:04 +0200
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
Message-ID: <20210616085304.GA28250@quack2.suse.cz>
References: <20210615090844.6045-1-jack@suse.cz>
 <20210615091814.28626-7-jack@suse.cz>
 <YMmOCK4wHc9lerEc@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMmOCK4wHc9lerEc@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 16-06-21 06:37:12, Christoph Hellwig wrote:
> On Tue, Jun 15, 2021 at 11:17:57AM +0200, Jan Kara wrote:
> > From: Pavel Reichl <preichl@redhat.com>
> > 
> > Refactor xfs_isilocked() to use newly introduced __xfs_rwsem_islocked().
> > __xfs_rwsem_islocked() is a helper function which encapsulates checking
> > state of rw_semaphores hold by inode.
> 
> __xfs_rwsem_islocked doesn't seem to actually existing in any tree I
> checked yet?

__xfs_rwsem_islocked is introduced by this patch so I'm not sure what are
you asking about... :)

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
