Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6752683C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2019 08:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbfGOG5s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 02:57:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:33772 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbfGOG5r (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 02:57:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 91AFBAFA5;
        Mon, 15 Jul 2019 06:57:46 +0000 (UTC)
Date:   Mon, 15 Jul 2019 08:57:45 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH RFC] fs: New zonefs file system
Message-ID: <20190715065745.GA4495@x250>
References: <20190712030017.14321-1-damien.lemoal@wdc.com>
 <20190715011935.GM7689@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190715011935.GM7689@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 15, 2019 at 11:19:35AM +1000, Dave Chinner wrote:
[...]
> > +/*
> > + * Open a file.
> > + */
> > +static int zonefs_file_open(struct inode *inode, struct file *file)
> > +{
> > +	/*
> > +	 * Note: here we can do an explicit open of the file zone,
> > +	 * on the first open of the inode. The explicit close can be
> > +	 * done on the last release (close) call for the inode.
> > +	 */
> > +
> > +	return generic_file_open(inode, file);
> > +}
> 
> Why is a wrapper needed for this?

AFAIR this is a left over from an older patch of me where an open of a
sequential only zone automagically appended O_APPEND, but this broke all kinds
of assumptions user-space did so Damien ripped it out again. So yes the
wrapper can go as well.

Byte,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
