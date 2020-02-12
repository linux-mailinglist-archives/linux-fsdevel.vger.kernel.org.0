Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E35B815B383
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 23:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgBLWVf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 17:21:35 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40704 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgBLWVf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 17:21:35 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CM8XXQ093061;
        Wed, 12 Feb 2020 22:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Qjes08ZkI689sZzFp/Y7l6yyOElmW2EZMZk+89fgWYc=;
 b=ohCL8mbWAwgyDg0VIsvTaw/iwTlM7HEaoI5eQ0ilAZPbluR5KInWznBr32NDF3Ccecyx
 cEuQGSrcagK1wsiE6hZz2cN5EUPqrJbL/JKdTJrkDLJ4SY5N3Xgz1C20I0DbyuYZee9O
 ylarw0T7wYs7HGmPLFO7zEGNSCy2zzJRq8NJ4VLWYhVAs7xrsGLEUSD+0AcBpjqa4Q8E
 5f7ig/mkMu7MIWBvNJdf8VhXy+vdSjm9LujTqtuwB9E1JJQzEG22sgeMlQXyBST+rUUq
 Ln3B3OmKKRWsga/6dh1rUsD9ltJI+fwCOizoVkX+YlepbpRcuQzbD0srmvcUdDq0dw+R vg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2y2jx6e7kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Feb 2020 22:21:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CM73gu003254;
        Wed, 12 Feb 2020 22:21:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2y4k32jd59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Feb 2020 22:21:22 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01CMLKGY002501;
        Wed, 12 Feb 2020 22:21:20 GMT
Received: from localhost (/10.159.151.237)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Feb 2020 14:21:20 -0800
Date:   Wed, 12 Feb 2020 14:21:18 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        xfs <linux-xfs@vger.kernel.org>,
        Eric Sandeen <sandeen@redhat.com>,
        Eryu Guan <guaneryu@gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] FS Maintainers Don't Scale
Message-ID: <20200212222118.GT6870@magnolia>
References: <20200131052520.GC6869@magnolia>
 <20200207220333.GI8731@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207220333.GI8731@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120152
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 07, 2020 at 02:03:33PM -0800, Matthew Wilcox wrote:
> On Thu, Jan 30, 2020 at 09:25:20PM -0800, Darrick J. Wong wrote:
> > It turns out that this system doesn't scale very well either.  Even with
> > three maintainers sharing access to the git trees and working together
> > to get reviews done, mailing list traffic has been trending upwards for
> > years, and we still can't keep up.  I fear that many maintainers are
> > burning out.  For XFS, the biggest pain point (AFAICT) is not assembly and
> > testing of the git trees, but keeping up with the mail and the reviews.
> 
> I think the LSFMMBPF conference is part of the problem.  With the best of
> intentions, we have set up a system which serves to keep all but the most
> dedicated from having a voice at the premier conference for filesystems,
> memory management, storage (and now networking).  It wasn't intended to
> be that way, but that's what has happened, and it isn't serving us well
> as a result.

Yeah... I gather that we now have BPF because it ties in with networking
and we added networking because it ties in with mm, but ... frankly I'd
like to be able to include a broader selection of people from each
community even if that rsults either in a larger event or splitting
things up again.

> Three anecdotes.  First, look at Jason's mail from earlier today:
> https://lore.kernel.org/linux-mm/20200207194620.GG8731@bombadil.infradead.org/T/#t
> 
> There are 11 people on that list, plus Jason, plus three more than I
> recommended.  That's 15, just for that one topic.  I think maybe half
> of those people will get an invite anyway, but adding on an extra 5-10
> people for (what I think is) a critically important topic at the very
> nexus of storage, filesystems, memory management, networking and graphics
> is almost certainly out of bounds for the scale of the current conference.
> 
> Second, I've had Outreachy students who have made meaningful contributions
> to the kernel.  Part of their bursary is a travel grant to go to a
> conference and they were excited to come to LSFMM.  I've had to tell
> them "this conference is invite-only for the top maintainers; you can't
> come".  They ended up going to an Open Source Summit conference instead.
> By excluding the people who are starting out, we are failing to grow
> our community.

Agree.

> I don't think it would have hurt for them to be in the room; they were
> unlikely to speak, and perhaps they would have gone on to make larger
> contributions.

Agree.  I've met all the Big Names, but I've never met most of the
people who are not full time contributors, and I've been attending LSFMM
for years.

> Third, I hear from people who work on a specific filesystem "Of the
> twenty or so slots for the FS part of the conference, there are about
> half a dozen generic filesystem people who'll get an invite, then maybe
> six filesystems who'll get two slots each, but what we really want to
> do is get everybody working on this filesystem in a room and go over
> our particular problem areas".

Yes!  One thousand times yes!  The best value I've gotten from LSF has
been the in-person interlocks with the XFS/ext4/btrfs developers, even
if the thing we discuss in the hallway BOFs have not really been
"cross-subsystem topics".

> This kills me because LSFMM has been such a critically important part of
> Linux development for over a decade, but I think at this point it is at
> least not serving us the way we want it to, and may even be doing more
> harm than good.

I don't think I'd go quite that far, but it's definitely underserving
the people who can't get in, the people who can't go, and the people who
are too far away but gosh it would be nice to pull them in even if it's
only for 30 minutes over a conference call.

> I think it needs to change, and more people need to
> be welcomed to the conference.  Maybe it needs to not be invite-only.
> Maybe it can stay invite-only, but be twice as large.  Maybe everybody
> who's coming needs to front $100 to put towards the costs of a larger
> meeting space with more rooms.
> 
> Not achievable for this year, I'm sure, but if we start talking now
> maybe we can have a better conference in 2021.

<nod>

--D
