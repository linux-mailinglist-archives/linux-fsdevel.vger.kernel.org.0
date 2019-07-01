Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9C85C26C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 19:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfGAR7R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 13:59:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53402 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730024AbfGAR7O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:59:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61Hwq4p054054;
        Mon, 1 Jul 2019 17:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=+0kMwPGWIa2Bzpth59cXNYi+urJc09aZ5jS7p6tGVJc=;
 b=dOiGC7bND1wE/SGHFrZs5oAjnlxjj5QZJ+HW8mhBZAELWxtHXUthEw7peQ2ez3wbVloa
 SdU/237UiqOzzrkJexGN7+XEdjSz69akgiryxavetR93jfP3M7yh9SYkFskaBcrru9TV
 HA1grH8/rWc6S1PUpYKK4BmO3oRvR95jvRbFQCpq/7RINNvrvE2I3B5WQOvsYbSNW480
 u9fUxJTuDVWjgZTVHU3lqVOSzWh2h0SsMt9tHDH5fV2vsAx6rnVZu/MtEn/5gGrGxjHz
 H7zdxNEh0CcMmY/BDgYHZsgz6RvbYzHEZ/z9/HJ8VgeeX49MQJVgUz8M8TZAeytvDYbg dg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2te61pq41q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 17:59:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61HvTq6004993;
        Mon, 1 Jul 2019 17:59:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tebbjas6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 17:59:07 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x61Hx6uM002380;
        Mon, 1 Jul 2019 17:59:06 GMT
Received: from localhost (/10.159.235.119)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 10:59:06 -0700
Date:   Mon, 1 Jul 2019 10:59:05 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 00/11] iomap: regroup code by functional area
Message-ID: <20190701175905.GC1654093@magnolia>
References: <156200051933.1790352.5147420943973755350.stgit@magnolia>
 <20190701174129.GA3315@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701174129.GA3315@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907010212
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907010212
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 01, 2019 at 01:41:29PM -0400, Theodore Ts'o wrote:
> On Mon, Jul 01, 2019 at 10:01:59AM -0700, Darrick J. Wong wrote:
> > Note that this is not the final format of the patches, because I intend
> > to pick a point towards the end of the merge window (after everyone
> > else's merges have landed), rebase this series atop that, and push it
> > back to Linus.
> 
> So normally Linus isn't psyched about pulling branches that were
> rebased at the last minute.  I guess we could ask him ahead of time if
> he's OK with this plan.  Or have you done that already?

I've not done so yet, since this is the first time this cleanup has been
posted.  Assuming I don't hear any loud complaining from anyone, I was
going to send the existing iomap 5.3 patches (all three of them) to
Linus at the start of the merge window and let him know that I'd like
to do the quick cleanup during the second week.  I've done tree cleanups
this way before without hearing any complaints, though they've never
gone outside the xfs tree.

> Alternatively you could rebase this on top of v5.3-rc2, after the
> merge window closes, and get agreement from the 4 file systems which
> are currently iomap users: ext2, ext4, gfs2, and xfs to start their
> development trees on top of that common branch for the 5.4 merge
> window.  After all, it's just moving code around and there are no
> substantive changes in this patch series, right?  So there's no rush
> as I understand things for this to hit mainline.

<shrug> I prefer to get this done quickly at the end of the 5.3 merge
window to reduce the risk that I'll have to reconcile the cleanup with
whatever iomap fixes land during -rc1 to -rc7.

I don't know if you've been following the "lift xfs writeback to iomap"
thread lately but I've also been thinking about putting out a work
branch for 5.4 with the sample writeback code in fs/iomap/writeback.c
to see if anyone bites, so we're likely to get such a tree anyway.

--D

> Cheers,
> 
> 						- Ted
