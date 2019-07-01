Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 611CD5C22D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 19:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfGARm5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 13:42:57 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48885 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727130AbfGARm4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:42:56 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x61HfUQA010853
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 1 Jul 2019 13:41:32 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0FB1D42002E; Mon,  1 Jul 2019 13:41:30 -0400 (EDT)
Date:   Mon, 1 Jul 2019 13:41:29 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 00/11] iomap: regroup code by functional area
Message-ID: <20190701174129.GA3315@mit.edu>
References: <156200051933.1790352.5147420943973755350.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156200051933.1790352.5147420943973755350.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 01, 2019 at 10:01:59AM -0700, Darrick J. Wong wrote:
> Note that this is not the final format of the patches, because I intend
> to pick a point towards the end of the merge window (after everyone
> else's merges have landed), rebase this series atop that, and push it
> back to Linus.

So normally Linus isn't psyched about pulling branches that were
rebased at the last minute.  I guess we could ask him ahead of time if
he's OK with this plan.  Or have you done that already?

Alternatively you could rebase this on top of v5.3-rc2, after the
merge window closes, and get agreement from the 4 file systems which
are currently iomap users: ext2, ext4, gfs2, and xfs to start their
development trees on top of that common branch for the 5.4 merge
window.  After all, it's just moving code around and there are no
substantive changes in this patch series, right?  So there's no rush
as I understand things for this to hit mainline.

Cheers,

						- Ted
