Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBA3A2EA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 06:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbfH3Eop (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 00:44:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44704 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfH3Eop (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 00:44:45 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3Ym7-0000W4-4h; Fri, 30 Aug 2019 04:44:39 +0000
Date:   Fri, 30 Aug 2019 05:44:39 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Boaz Harrosh <boaz@plexistor.com>,
        Kai =?iso-8859-1?Q?M=E4kisara_=28Kolumbus=29?= 
        <kai.makisara@kolumbus.fi>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org,
        Octavian Purdila <octavian.purdila@intel.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi@vger.kernel.org
Subject: Re: [RFC] Re: broken userland ABI in configfs binary attributes
Message-ID: <20190830044439.GV1131@ZenIV.linux.org.uk>
References: <20190826024838.GN1131@ZenIV.linux.org.uk>
 <20190826162949.GA9980@ZenIV.linux.org.uk>
 <B35B5EA9-939C-49F5-BF65-491D70BCA8D4@kolumbus.fi>
 <20190826193210.GP1131@ZenIV.linux.org.uk>
 <b362af55-4f45-bf29-9bc4-dd64e6b04688@plexistor.com>
 <20190827172734.GS1131@ZenIV.linux.org.uk>
 <20190829222258.GA16625@ZenIV.linux.org.uk>
 <20190830041042.GB7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830041042.GB7777@dread.disaster.area>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 30, 2019 at 02:10:42PM +1000, Dave Chinner wrote:

> > reiserfs_file_release():
> > 	tries to return an error if it can't free preallocated blocks.
> > 
> > xfs_release():
> > 	similar to the previous case.
> 
> Not quite right. XFS only returns an error if there is data
> writeback failure or filesystem corruption or shutdown detected
> during whatever operation it is performing.
> 
> We don't really care what is done with the error that we return;
> we're just returning an error because that's what the function
> prototype indicates we should do...

I thought that xfs_release() and friends followed the prototypes
you had on IRIX, while xfs_file_release() et.al. were the
impedance-matching layer for Linux.  Oh, well...
