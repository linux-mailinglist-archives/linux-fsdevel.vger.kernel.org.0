Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC76915B409
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 23:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgBLWmn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 17:42:43 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45746 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgBLWmn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 17:42:43 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CMgcfR069033;
        Wed, 12 Feb 2020 22:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Z0SHkkKVG+gs55qEd/RP/7rUFc+/POczqmO69ahQYMY=;
 b=CL1Yv2owQl9zfvWpMhq6lqqi6dahEQtOJMi31asm5l/BRhPx1v5kL8SByVCNfRMrIB3c
 dVW7iwbZ0be6mf1bItvb/VSm8c9mS3xht8S9kday3z7q2grPXsP1EObdmK3nYH695Qda
 SzU1egJK76ibHGNIh9FwI3UEDFzPhuuaqlQHe51L6bkIGcFxWdKZUrGJhrM/OKL+NN6N
 bawvWrfq8ywhfMPpuLsIRLwyyVZLCn60r+A9XuySfVLtwdvI8lzTNcStA+DWrFMRrhoB
 MQPAv2cxVJ1DlYOXwGsIafUNSNQg45weMBgpaHwaOeVb5/mAGF18eApzse3Cnghx5rSJ +Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2y2jx6ea8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Feb 2020 22:42:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CMXAV2073405;
        Wed, 12 Feb 2020 22:42:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2y4kah29bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Feb 2020 22:42:37 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01CMga0X003934;
        Wed, 12 Feb 2020 22:42:36 GMT
Received: from localhost (/10.159.151.237)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Feb 2020 14:42:35 -0800
Date:   Wed, 12 Feb 2020 14:42:34 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] FS Maintainers Don't Scale
Message-ID: <20200212224234.GV6870@magnolia>
References: <20200131052520.GC6869@magnolia>
 <CAOQ4uxh=4DrH_dL3TULcFa+pGk0YhS=TobuGk_+Z0oRWvw63rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh=4DrH_dL3TULcFa+pGk0YhS=TobuGk_+Z0oRWvw63rg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120155
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 31, 2020 at 09:30:02AM +0200, Amir Goldstein wrote:
> On Fri, Jan 31, 2020 at 7:25 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> >
> > Hi everyone,
> >
> > I would like to discuss how to improve the process of shepherding code
> > into the kernel to make it more enjoyable for maintainers, reviewers,
> > and code authors.  Here is a brief summary of how we got here:
> >
> > Years ago, XFS had one maintainer tending to all four key git repos
> > (kernel, userspace, documentation, testing).  Like most subsystems, the
> > maintainer did a lot of review and porting code between the kernel and
> > userspace, though with help from others.
> >
> > It turns out that this didn't scale very well, so we split the
> > responsibilities into three maintainers.  Like most subsystems, the
> > maintainers still did a lot of review and porting work, though with help
> > from others.
> >
> > It turns out that this system doesn't scale very well either.  Even with
> > three maintainers sharing access to the git trees and working together
> > to get reviews done, mailing list traffic has been trending upwards for
> > years, and we still can't keep up.  I fear that many maintainers are
> > burning out.  For XFS, the biggest pain point (AFAICT) is not assembly and
> > testing of the git trees, but keeping up with the mail and the reviews.
> >
> > So what do we do about this?  I think we (the XFS project, anyway)
> > should increase the amount of organizing in our review process.  For
> > large patchsets, I would like to improve informal communication about
> > who the author might like to have conduct a review, who might be
> > interested in conducting a review, estimates of how much time a reviewer
> > has to spend on a patchset, and of course, feedback about how it went.
> > This of course is to lay the groundwork for making a case to our bosses
> > for growing our community, allocating time for reviews and for growing
> > our skills as reviewers.
> >
> 
> Interesting.
> 
> Eryu usually posts a weekly status of xfstests review queue, often with
> a call for reviewers, sometimes with specific patch series mentioned.
> That helps me as a developer to monitor the status of my own work
> and it helps me as a reviewer to put the efforts where the maintainer
> needs me the most.

I wasn't aware of that, I'll ask him to put me on the list.

> For xfs kernel patches, I can represent the voice of "new blood".
> Getting new people to join the review effort is quite a hard barrier.
> I have taken a few stabs at doing review for xfs patch series over the
> year, but it mostly ends up feeling like it helped me (get to know xfs code
> better) more than it helped the maintainer, because the chances of a
> new reviewer to catch meaningful bugs are very low and if another reviewer
> is going to go over the same patch series, the chances of new reviewer to
> catch bugs that novice reviewer will not catch are extremely low.

Probably not, I miss small things too. :)

Especially if one has to twist through a bunch of different functions to
figure out if there's really a bug there.

> However, there are quite a few cleanup and refactoring patch series,
> especially on the xfs list, where a review from an "outsider" could still
> be of value to the xfs community. OTOH, for xfs maintainer, those are
> the easy patches to review, so is there a gain in offloading those reviews?

Yes, because there's still a ton of things I suck at -- running sparse
and smatch on the git trees, figuring out how a given patch will affect
xfsprogs, etc.

> Bottom line - a report of the subsystem review queue status, call for
> reviewers and highlighting specific areas in need of review is a good idea.
> Developers responding to that report publicly with availability for review,
> intention and expected time frame for taking on a review would be helpful
> for both maintainers and potential reviewers.

<nod>

--D

> Thanks,
> Amir.
> 
> > ---
> >
> > I want to spend the time between right now and whenever this discussion
> > happens to make a list of everything that works and that could be made
> > better about our development process.
> >
> > I want to spend five minutes at the start of the discussion to
> > acknowledge everyone's feelings around that list that we will have
> > compiled.
> >
> > Then I want to spend the rest of the session breaking up the problems
> > into small enough pieces to solve, discussing solutions to those
> > problems, and (ideally) pushing towards a consensus on what series of
> > small adjustments we can make to arrive at something that works better
> > for everyone.
> >
> > --D
> > _______________________________________________
> > Lsf-pc mailing list
> > Lsf-pc@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc
