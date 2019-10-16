Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3B4D8C97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 11:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391998AbfJPJfh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 05:35:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:60880 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391829AbfJPJfh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:35:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2935DABB1;
        Wed, 16 Oct 2019 09:35:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7907F1E3BDE; Wed, 16 Oct 2019 11:35:34 +0200 (CEST)
Date:   Wed, 16 Oct 2019 11:35:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jan Kara <jack@suse.cz>, mbobrowski@mbobrowski.org
Subject: Re: [ANNOUNCE] xfs-linux: iomap-5.5-merge updated to c9acd3aee077
Message-ID: <20191016093534.GD30337@quack2.suse.cz>
References: <20191015164901.GF13108@magnolia>
 <20191015165554.GA10728@infradead.org>
 <20191015173616.GM13108@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015173616.GM13108@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 15-10-19 10:36:16, Darrick J. Wong wrote:
> On Tue, Oct 15, 2019 at 09:55:54AM -0700, Christoph Hellwig wrote:
> > On Tue, Oct 15, 2019 at 09:49:01AM -0700, Darrick J. Wong wrote:
> > > 
> > > Jan Kara (2):
> > >       [13ef954445df] iomap: Allow forcing of waiting for running DIO in iomap_dio_rw()
> > >       [c9acd3aee077] xfs: Use iomap_dio_rw_wait()
> > 
> > The second commit seems to be mis-titled as there is no function
> > called iomap_dio_rw_wait in that tree.
> 
> Yeah.  Jan, can I fix that and repush?

Sure, that was left from previous versions of the series and I didn't
notice... Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
