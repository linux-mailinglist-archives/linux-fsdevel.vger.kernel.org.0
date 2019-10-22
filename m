Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 561DCDFFE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 10:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388645AbfJVIp0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 04:45:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:54614 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388490AbfJVIp0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:45:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 62417B170;
        Tue, 22 Oct 2019 08:45:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 411851E4862; Tue, 22 Oct 2019 09:50:35 +0200 (CEST)
Date:   Tue, 22 Oct 2019 09:50:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v5 08/12] ext4: update direct I/O read to do trylock in
 IOCB_NOWAIT cases
Message-ID: <20191022075035.GA2436@quack2.suse.cz>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <5ee370a435eb08fb14579c7c197b16e9fa0886f0.1571647179.git.mbobrowski@mbobrowski.org>
 <20191021134817.GG25184@quack2.suse.cz>
 <20191022020421.GE5092@athena.bobrowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022020421.GE5092@athena.bobrowski.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 22-10-19 13:04:21, Matthew Bobrowski wrote:
> On Mon, Oct 21, 2019 at 03:48:17PM +0200, Jan Kara wrote:
> > On Mon 21-10-19 20:18:46, Matthew Bobrowski wrote:
> > > This patch updates the lock pattern in ext4_dio_read_iter() to only
> > > perform the trylock in IOCB_NOWAIT cases.
> > 
> > The changelog is actually misleading. It should say something like "This
> > patch updates the lock pattern in ext4_dio_read_iter() to not block on
> > inode lock in case of IOCB_NOWAIT direct IO reads."
> > 
> > Also to ease backporting of easy fixes, we try to put patches like this
> > early in the series (fixing code in ext4_direct_IO_read(), and then the
> > fixed code would just carry over to ext4_dio_read_iter()).
> 
> OK, understood. Now I know this for next time. :)
> 
> Providing that I have this patch precede the ext4_dio_read_iter()
> patch and implement this lock pattern in ext4_direct_IO_read(), am I
> OK to add the 'Reviewed-by' tag?

Yes.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
