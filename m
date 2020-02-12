Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C37F315B2DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 22:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgBLVgN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 16:36:13 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46504 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbgBLVgN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 16:36:13 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CLVFT8128464;
        Wed, 12 Feb 2020 21:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=pjuoAQZkSwJYRBH/rmp8Y2zCjkQiurMGoRSq3rhJmIQ=;
 b=R1aZc3RgC/hSokvJ4svTNBMi4LXpZNxqRY9Ss0EyWjMoa7/IoDKBlOlUjPkmYE5G3NBf
 jJIuizl+WtCZhONvjz5IY+gUg7WNbgeBbULFpCeg3M1ZqayGSFX9nIb1uO04lPk3+f6Z
 QPX8s+HuirJDJYn0hqy25fTz50ti+3+oo03LnuPtJ0jY4UOUiZm/537hPciyKdV6ARfZ
 TxmBTirug+/m2n8rtzI/0SyDcUfaMKPY7lgLeF61uxt6F9SuBZk7/Yq04MC9xxEEHrVA
 6J1z/9cOftHTyVx+Z/L5Yv0W2AkNDAmLcxpxUyvuAc9FPRamLQ5XTPrYAiwJraJCAkdB Fw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2y2p3snkur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Feb 2020 21:36:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CLR80t117505;
        Wed, 12 Feb 2020 21:36:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2y4k32cdwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Feb 2020 21:36:04 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01CLa4VH020271;
        Wed, 12 Feb 2020 21:36:04 GMT
Received: from localhost (/10.159.151.237)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Feb 2020 13:36:03 -0800
Date:   Wed, 12 Feb 2020 13:36:01 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Allison Collins <allison.henderson@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] FS Maintainers Don't Scale
Message-ID: <20200212213601.GR6870@magnolia>
References: <20200131052520.GC6869@magnolia>
 <CAOQ4uxh=4DrH_dL3TULcFa+pGk0YhS=TobuGk_+Z0oRWvw63rg@mail.gmail.com>
 <8983ceaa-1fda-f9cc-73c9-8764d010d3e2@oracle.com>
 <20200202214620.GA20628@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200202214620.GA20628@dread.disaster.area>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=2 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=2 mlxlogscore=999 priorityscore=1501 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120147
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 03, 2020 at 08:46:20AM +1100, Dave Chinner wrote:
> On Fri, Jan 31, 2020 at 08:20:37PM -0700, Allison Collins wrote:
> > 
> > 
> > On 1/31/20 12:30 AM, Amir Goldstein wrote:
> > > On Fri, Jan 31, 2020 at 7:25 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > > > 
> > > > Hi everyone,
> > > > 
> > > > I would like to discuss how to improve the process of shepherding code
> > > > into the kernel to make it more enjoyable for maintainers, reviewers,
> > > > and code authors.  Here is a brief summary of how we got here:
> > > > 
> > > > Years ago, XFS had one maintainer tending to all four key git repos
> > > > (kernel, userspace, documentation, testing).  Like most subsystems, the
> > > > maintainer did a lot of review and porting code between the kernel and
> > > > userspace, though with help from others.
> > > > 
> > > > It turns out that this didn't scale very well, so we split the
> > > > responsibilities into three maintainers.  Like most subsystems, the
> > > > maintainers still did a lot of review and porting work, though with help
> > > > from others.
> > > > 
> > > > It turns out that this system doesn't scale very well either.  Even with
> > > > three maintainers sharing access to the git trees and working together
> > > > to get reviews done, mailing list traffic has been trending upwards for
> > > > years, and we still can't keep up.  I fear that many maintainers are
> > > > burning out.  For XFS, the biggest pain point (AFAICT) is not assembly and
> > > > testing of the git trees, but keeping up with the mail and the reviews.
> > > > 
> > > > So what do we do about this?  I think we (the XFS project, anyway)
> > > > should increase the amount of organizing in our review process.  For
> > > > large patchsets, I would like to improve informal communication about
> > > > who the author might like to have conduct a review, who might be
> > > > interested in conducting a review, estimates of how much time a reviewer
> > > > has to spend on a patchset, and of course, feedback about how it went.
> > > > This of course is to lay the groundwork for making a case to our bosses
> > > > for growing our community, allocating time for reviews and for growing
> > > > our skills as reviewers.
> > > > 
> > > 
> > > Interesting.
> > > 
> > > Eryu usually posts a weekly status of xfstests review queue, often with
> > > a call for reviewers, sometimes with specific patch series mentioned.
> > > That helps me as a developer to monitor the status of my own work
> > > and it helps me as a reviewer to put the efforts where the maintainer
> > > needs me the most.

FWIW, I wasn't aware that he did that.

> > > For xfs kernel patches, I can represent the voice of "new blood".
> > > Getting new people to join the review effort is quite a hard barrier.
> > > I have taken a few stabs at doing review for xfs patch series over the
> > > year, but it mostly ends up feeling like it helped me (get to know xfs code
> > > better) more than it helped the maintainer, because the chances of a
> > > new reviewer to catch meaningful bugs are very low and if another reviewer
> > > is going to go over the same patch series, the chances of new reviewer to
> > > catch bugs that novice reviewer will not catch are extremely low.
> > That sounds like a familiar experience.  Lots of times I'll start a review,
> > but then someone else will finish it before I do, and catch more things
> > along the way.  So I sort of feel like if it's not something I can get
> > through quickly, then it's not a very good distribution of work effort and I
> > should shift to something else. Most of the time, I'll study it until I feel
> > like I understand what the person is trying to do, and I might catch stuff
> > that appears like it may not align with that pursuit, but I don't
> > necessarily feel I can deem it void of all unforeseen bugs.
> 
> I think you are both underselling yourselves. Imposter syndrome and
> all that jazz.
> 
> The reality is that we don't need more people doing the sorts of
> "how does this work with the rest of XFS" reviews that people like
> Darricki or Christoph do.

I 90% agree with that, except for the complexity that is the logging
system and how the cil & ail interact with each other.  I /really/
appreciate Brian digging into those kinds of things. :)

> What we really need is more people looking
> at whether loops are correctly terminated, the right variable types
> are used, we don't have signed vs unsigned issues, 32 bit overflows,
> use the right 32/64 bit division functions, the error handling logic
> is correct, etc.

Yeah, someone running sparse/smatch regularly would also help.  Granted,
Dan Carpenter does a good job of staying on top of that, but still...

> It's those sorts of little details that lead to most bugs, and
> that's precisely the sort of thing that is typically missed by an
> experienced developer doing a "is this the best possible
> implemenation of this functionality" review.

I would also add (to state this explicitly) that it was easier for me
earlier in my xfs career to spot certain kinds of bugs because I had to
figure out what the code was doing on my own and did not have to
compensate for the mental shortcut of "fmeh, it worked last time I went
here".

> A recent personal example: look at the review of Matthew Wilcox's
> ->readahead() series that I recently did. I noticed problems in the
> core change and the erofs and btfrs implementations not because I
> knew anything about those filesystems, but because I was checking
> whether the new loops iterated the pages in the page cache
> correctly. i.e. all I was really looking at was variable counting
> and loop initialisation and termination conditions. Experience tells
> me this stuff is notoriously difficult to get right, so that's what
> I looked at....
> 
> IOWs, you don't need to know anything about the subsystem to
> perform such a useful review, and a lot of the time you won't find a
> problem.

The other thing that would be helpful is reviewing code submission
w.r.t. test cases.  Did the author submit a testcase to go with the
patch?  Does the code patch instead reference finding the bug by
studying failures of specific fstests?  (Or LTP, or blktests, or...)

> But it's still a very useful review to perform, and in
> doing so you've validated, to the best of your ability, that the
> change is sound. Put simply:
> 
> 	"I've checked <all these things> and it looks good to me.
> 
> 	Reviewed-by: Joe Bloggs <joe@blogg.com>"
> 
> This is a very useful, valid review, regardless of whether you find
> anything. It's also a method of review that you can use when you
> have limited time - rather than trying to check everything and
> spending hours on a pathset, pick one thing and get the entire
> review done in 15 minutes. Then do the same thing for the next patch
> set. You'll be surprised how many things you notice that aren't what
> you are looking for when you do this.

> Hence the fact that other people find (different) issues is
> irrelevant - they'll be looking at different things to you, and
> there may not even be any overlap in the focus/scope of the reviews
> that have been performed. You may find the same things, but that is
> also not a bad thing - I intentionally don't read other reviews
> before I review a patch series, so that I don't taint my view of the
> code before I look at it (e.g., darrick found a bug in this code, so
> I don't need to look at it...).
> 
> IOWs, if you are starting from the premise that "I don't know this
> code well enough to perform a useful review" then you are setting

TBH I've wondered if this goes hand in hand with "I fear/figure/guess
the maintainer will probably review this and prove better at spotting
the bugs than me" and "Oh gosh what if the maintainer pushes this into
for-next before anyone even realizes I was reading this"?

This is why I want to push for /slightly/ more explicit coordination of
authors and reviewers for patch sets.  Let's say that Pavel sends a
patchset to the list.  If (for example) Allison immediately emails a
reply to the cover letter saying that she'll look at test coverage and
Bill sends his own email saying that he'll check the error paths, then I
will know expect further discussion (or RVBs) between the three of them,
and will wait for the reviews to wrap up before pushing to -next.

Obviously if this is some nasty bug that needs fixing quickly then cc me
to get my attention and I'll flag myself as conducting the review.

> yourself up for failure right at the start. Read the series
> description, think about the change being made, use your experience
> to answer the question "what's a mistake I could make performing
> this change". Then go looking for that mistake through the
> patch(es). In the process of performing this review, more than
> likely, you'll notice bugs other than what you are actually looking
> for...
> 
> This does not require any deep subsystem specific knowledge, but in
> doing this sort of review you're going to notice things and learn
> about the code and slowly build your knowledge and experience about
> that subsystem.

(Agreed, most of my familiarity from xfs comes either from reading
patches coming in or examining previously submitted patchsets, even if
it's been a while since the last submission.)

> > > However, there are quite a few cleanup and refactoring patch series,
> > > especially on the xfs list, where a review from an "outsider" could still
> > > be of value to the xfs community. OTOH, for xfs maintainer, those are
> > > the easy patches to review, so is there a gain in offloading those reviews?
> > > 
> > > Bottom line - a report of the subsystem review queue status, call for
> > > reviewers and highlighting specific areas in need of review is a good idea.
> > > Developers responding to that report publicly with availability for review,
> > > intention and expected time frame for taking on a review would be helpful
> > > for both maintainers and potential reviewers.
> > I definitely think that would help delegate review efforts a little more.
> > That way it's clear what people are working on, and what still needs
> > attention.
> 
> It is not the maintainer's repsonsibility to gather reviewers. That

No, but I'm conflating the two here because I'm engaged in all three
modes. :)

> is entirely the responsibility of the patch submitter. That is, if
> the code has gone unreviewed, it is up to the submitter to find
> people to review the code, not the maintainer. If you, as a
> developer, are unable to find people willing to review your code
> then it's a sign you haven't been reviewing enough code yourself.

I don't entirely agree with this statement.  I have loads of patches
waiting for review, but I also don't feel like I'm not reviewing enough
code.  I swear I'm not trying to guilt trip anyone by that statement. :)

Recently I was talking to Eric and he pointed out that certain things
like the NYE mass patchbombings aren't so helpful because 400 patches is
a lot to absorb.  I dump those patchbombs (both to linux-xfs and to
kernel.org) to try to keep my own bus factor as high as possible.  I
think I should shift to pushing the git trees to kernel.org and /only/
sending the cover letters with links, at least when I'm in "distributed
backup mode".

For everything else, maybe I should be more explicit about identifying
that which I'd like to get reviewed for the next cycle, e.g. "I would
like to try to get the btree bulk load code pushed for 5.7."  I think
some of the kernel subprojects actually do something like that, but it
doesn't seem like this is universally acknowledged as a strategy.

> Good reviewers are a valuable resource - as a developer I rely on
> reviewers to get my code merged, so if I don't review code and
> everyone else behaves the same way, how can I possibly get my code
> merged? IOWs, review is something every developer should be spending
> a significant chunk of their time on. IMO, if you are not spending
> *at least* a whole day a week reviewing code, you're not actually
> doing enough code review to allow other developers to be as
> productive as you are.

This kinda gets to my next topic, which is how do we make the business
case for more people to jump in and review code?  AFAICT people who work
for the longtime Usual Suspects (RH, IBM, SUSE, Oracle, etc.) are /very/
fortunate that their free software offices have enough sway that they
don't need to push very hard for paid review time, but I have little
clue if that's true for the more recent players.  If you work for a
company that doesn't let you review time as part of your workday, I
would like to know that.

> The more you review other people's code, the more you learn about
> the code and the more likely other people will be to review your
> code because they know you'll review their code in turn.  It's a
> positive reinforcement cycle that benefits both the individual
> developers personally and the wider community.
> 
> But this positive reinforcemnt cycle just doesn't happen if people
> avoid reviewing code because they think "I don't know anything so my
> review is not going to be worth anything".  Constructive review, not
> matter whether it's performed at a simple or complex level, is
> always valuable.

Also sometimes /this/ reviewer is running in stupid/harried/burnout mode
and misses obvious things. :(

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
