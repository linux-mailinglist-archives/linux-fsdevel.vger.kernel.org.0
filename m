Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF78202585
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 19:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgFTRJ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 13:09:28 -0400
Received: from fieldses.org ([173.255.197.46]:33350 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgFTRJ1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 13:09:27 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 183C614D8; Sat, 20 Jun 2020 13:09:24 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 183C614D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1592672964;
        bh=e6zYVkezLT2ct6J3M7M86Qk+qpHHQC4dPy9/qoTz7aM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HDufi5g79j2EKmPO+eAznsnT5kJ1fwhER+27gkVIii9w36rFHpo1ceaAE6OqWuIIX
         a4dna+XFvu1kqQdSvo3FdTHmqtHwEBD26AFXn+NPJFhwObV+ohrW1NK2bua/0SkdRw
         aPlJri1ySFDlaFmf3Zjrx10wbdh7TorkAgcq5plc=
Date:   Sat, 20 Jun 2020 13:09:24 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Dave Chinner <david@fromorbit.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs <linux-xfs@vger.kernel.org>, jlayton@redhat.com
Subject: Re: [PATCH] fs: i_version mntopt gets visible through /proc/mounts
Message-ID: <20200620170924.GI1514@fieldses.org>
References: <20200618034535.h5ho7pd4eilpbj3f@gabell>
 <20200618223948.GI2005@dread.disaster.area>
 <20200619022005.GA25414@fieldses.org>
 <20200619024455.GN2005@dread.disaster.area>
 <20200619204033.GB1564@fieldses.org>
 <20200619221044.GO2005@dread.disaster.area>
 <20200619222843.GB2650@fieldses.org>
 <20200620014957.GQ2005@dread.disaster.area>
 <20200620015633.GA1516@fieldses.org>
 <d6f9cac3-eec0-a88e-4eab-7673728db52c@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6f9cac3-eec0-a88e-4eab-7673728db52c@sandeen.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 20, 2020 at 12:00:43PM -0500, Eric Sandeen wrote:
> On 6/19/20 8:56 PM, J. Bruce Fields wrote:
> > On Sat, Jun 20, 2020 at 11:49:57AM +1000, Dave Chinner wrote:
> 
> ...
> 
> >> However, other people have different opinions on this matter (and we
> >> know that from the people who considered XFS v4 -> v5 going slower
> >> because iversion a major regression), and so we must acknowledge
> >> those opinions even if we don't agree with them.
> > 
> > Do you have any of those reports handy?  Were there numbers?
> 
> I can't answer that but did a little digging.  MS_I_VERSION as an option
> appeared here:
> 
...
> so the optional enablement was there on day one, without any real explanation
> of why.

My memory is that they didn't have measurements at first, but worried
that there might be a performance issue.  Which later mesurements
confirmed.

But that Jeff Layton's work eliminated most of that.

I think ext4 was the focuse of the concern, but xfs might also have had
a (less serious) regression, and btrfs might have actually had it worst?

But I don't have references and my memory may be wrong.

--b.
