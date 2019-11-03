Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6EA7ED458
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2019 20:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfKCTVB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Nov 2019 14:21:01 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53295 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727343AbfKCTVB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Nov 2019 14:21:01 -0500
Received: from callcc.thunk.org (ip-12-2-52-196.nyc.us.northamericancoax.com [196.52.2.12])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xA3JKfhL016741
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 3 Nov 2019 14:20:41 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 748C9420311; Sun,  3 Nov 2019 14:20:40 -0500 (EST)
Date:   Sun, 3 Nov 2019 14:20:40 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     jack@suse.cz, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v6 00/11] ext4: port direct I/O to iomap infrastructure
Message-ID: <20191103192040.GA12985@mit.edu>
References: <cover.1572255424.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572255424.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew, could you do me a favor?  For the next (and hopefully
final :-) spin of this patch series, could you base it on the
ext4.git's master branch.  Then pull in Darrick's iomap-for-next
branch, and then apply your patches on top of that.

I attempted to do this with the v6 patch series --- see the tt/mb-dio
branch --- and I described on another e-mail thread, I appear to have
screwed up that patch conflicts, since it's causing a failure with
diroead-nolock using a 1k block size.  Since this wasn't something
that worked when you were first working on the patch set, this isn't
something I'm going to consider blocking, especially since a flay test
failure which happens 7% of the time, and using dioread_nolock with a
sub-page blocksize isn't something that is going to be all that common
(since it wasn't working at all up until now).

Still, I'm hoping that either Ritesh or you can figure out how my
simple-minded handling of the patch conflict between your and his
patch series can be addressed properly.

Thanks!!

						- Ted
