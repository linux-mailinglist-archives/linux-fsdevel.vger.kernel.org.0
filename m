Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E491156BB8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2020 18:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgBIRMM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Feb 2020 12:12:12 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:60930 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbgBIRMM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Feb 2020 12:12:12 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 019H5XNU034946;
        Sun, 9 Feb 2020 17:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=EOSRIN15HQ8tDw35UggpAS1ilSB9f1NWIE7FAK0Igns=;
 b=J7gfMD48+ICoFL3Qx9sXZzjGVcfOv/Mo2mDc7EziIY3dU7O97Z/3bDhKdwOeBi69EP0c
 sMnV4V33/RVxUEms3LMM3YixMv1vPXhaHgSYvim3EYwafrgbA6mtuWTWlQcLfozW/rks
 k+rzMRv6plIBFsVpZvUNAO1Z1LVcD+1RZN0OxQBuviUnI/w4DyzXLXjs2JzbFGqv35Pd
 qf8zihF70r4XOUcW+IgCRjqDICpAuKj10r/2aR+wVg8vC3cE8z+nqAsaIIcDPyvWQPo5
 zVp670CQtY8HoKpleqq8t8sOerplRIE5KhrXnU3r07x41fegPL/xKsohtNj+gLXoPrE3 FA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2y2jx5rbej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 09 Feb 2020 17:12:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 019H6pdW053226;
        Sun, 9 Feb 2020 17:12:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2y26fdg4xx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 09 Feb 2020 17:12:05 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 019HC4Hw019130;
        Sun, 9 Feb 2020 17:12:04 GMT
Received: from [192.168.1.223] (/67.1.3.112)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 09 Feb 2020 09:12:04 -0800
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] FS Maintainers Don't Scale
To:     Dave Chinner <david@fromorbit.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>,
        Eric Sandeen <sandeen@redhat.com>
References: <20200131052520.GC6869@magnolia>
 <CAOQ4uxh=4DrH_dL3TULcFa+pGk0YhS=TobuGk_+Z0oRWvw63rg@mail.gmail.com>
 <8983ceaa-1fda-f9cc-73c9-8764d010d3e2@oracle.com>
 <20200202214620.GA20628@dread.disaster.area>
From:   Allison Collins <allison.henderson@oracle.com>
Message-ID: <fc430471-54d2-bb44-d084-a37e7ff9ef50@oracle.com>
Date:   Sun, 9 Feb 2020 10:12:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200202214620.GA20628@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9525 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002090142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9525 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002090142
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/2/20 2:46 PM, Dave Chinner wrote:
> On Fri, Jan 31, 2020 at 08:20:37PM -0700, Allison Collins wrote:
>>
>>
>> On 1/31/20 12:30 AM, Amir Goldstein wrote:
>>> On Fri, Jan 31, 2020 at 7:25 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>>>>
>>>> Hi everyone,
>>>>
>>>> I would like to discuss how to improve the process of shepherding code
>>>> into the kernel to make it more enjoyable for maintainers, reviewers,
>>>> and code authors.  Here is a brief summary of how we got here:
>>>>
>>>> Years ago, XFS had one maintainer tending to all four key git repos
>>>> (kernel, userspace, documentation, testing).  Like most subsystems, the
>>>> maintainer did a lot of review and porting code between the kernel and
>>>> userspace, though with help from others.
>>>>
>>>> It turns out that this didn't scale very well, so we split the
>>>> responsibilities into three maintainers.  Like most subsystems, the
>>>> maintainers still did a lot of review and porting work, though with help
>>>> from others.
>>>>
>>>> It turns out that this system doesn't scale very well either.  Even with
>>>> three maintainers sharing access to the git trees and working together
>>>> to get reviews done, mailing list traffic has been trending upwards for
>>>> years, and we still can't keep up.  I fear that many maintainers are
>>>> burning out.  For XFS, the biggest pain point (AFAICT) is not assembly and
>>>> testing of the git trees, but keeping up with the mail and the reviews.
>>>>
>>>> So what do we do about this?  I think we (the XFS project, anyway)
>>>> should increase the amount of organizing in our review process.  For
>>>> large patchsets, I would like to improve informal communication about
>>>> who the author might like to have conduct a review, who might be
>>>> interested in conducting a review, estimates of how much time a reviewer
>>>> has to spend on a patchset, and of course, feedback about how it went.
>>>> This of course is to lay the groundwork for making a case to our bosses
>>>> for growing our community, allocating time for reviews and for growing
>>>> our skills as reviewers.
>>>>
>>>
>>> Interesting.
>>>
>>> Eryu usually posts a weekly status of xfstests review queue, often with
>>> a call for reviewers, sometimes with specific patch series mentioned.
>>> That helps me as a developer to monitor the status of my own work
>>> and it helps me as a reviewer to put the efforts where the maintainer
>>> needs me the most.
>>>
>>> For xfs kernel patches, I can represent the voice of "new blood".
>>> Getting new people to join the review effort is quite a hard barrier.
>>> I have taken a few stabs at doing review for xfs patch series over the
>>> year, but it mostly ends up feeling like it helped me (get to know xfs code
>>> better) more than it helped the maintainer, because the chances of a
>>> new reviewer to catch meaningful bugs are very low and if another reviewer
>>> is going to go over the same patch series, the chances of new reviewer to
>>> catch bugs that novice reviewer will not catch are extremely low.
>> That sounds like a familiar experience.  Lots of times I'll start a review,
>> but then someone else will finish it before I do, and catch more things
>> along the way.  So I sort of feel like if it's not something I can get
>> through quickly, then it's not a very good distribution of work effort and I
>> should shift to something else. Most of the time, I'll study it until I feel
>> like I understand what the person is trying to do, and I might catch stuff
>> that appears like it may not align with that pursuit, but I don't
>> necessarily feel I can deem it void of all unforeseen bugs.
> 
> I think you are both underselling yourselves. Imposter syndrome and
> all that jazz.
> 
> The reality is that we don't need more people doing the sorts of
> "how does this work with the rest of XFS" reviews that people like
> Darricki or Christoph do. What we really need is more people looking
> at whether loops are correctly terminated, the right variable types
> are used, we don't have signed vs unsigned issues, 32 bit overflows,
> use the right 32/64 bit division functions, the error handling logic
> is correct, etc.
> 
> It's those sorts of little details that lead to most bugs, and
> that's precisely the sort of thing that is typically missed by an
> experienced developer doing a "is this the best possible
> implemenation of this functionality" review.
> 
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
> problem. But it's still a very useful review to perform, and in
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
> 
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
> 
>>> However, there are quite a few cleanup and refactoring patch series,
>>> especially on the xfs list, where a review from an "outsider" could still
>>> be of value to the xfs community. OTOH, for xfs maintainer, those are
>>> the easy patches to review, so is there a gain in offloading those reviews?
>>>
>>> Bottom line - a report of the subsystem review queue status, call for
>>> reviewers and highlighting specific areas in need of review is a good idea.
>>> Developers responding to that report publicly with availability for review,
>>> intention and expected time frame for taking on a review would be helpful
>>> for both maintainers and potential reviewers.
>> I definitely think that would help delegate review efforts a little more.
>> That way it's clear what people are working on, and what still needs
>> attention.
> 
> It is not the maintainer's repsonsibility to gather reviewers. That
> is entirely the responsibility of the patch submitter. That is, if
> the code has gone unreviewed, it is up to the submitter to find
> people to review the code, not the maintainer. If you, as a
> developer, are unable to find people willing to review your code
> then it's a sign you haven't been reviewing enough code yourself.
> 
> Good reviewers are a valuable resource - as a developer I rely on
> reviewers to get my code merged, so if I don't review code and
> everyone else behaves the same way, how can I possibly get my code
> merged? IOWs, review is something every developer should be spending
> a significant chunk of their time on. IMO, if you are not spending
> *at least* a whole day a week reviewing code, you're not actually
> doing enough code review to allow other developers to be as
> productive as you are.
> 
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
> 
> Cheers,
> 
> Dave.
> 
Well, I can see the response is meant to be encouraging, and you are 
right that everyone needs to give to receive :-)

I have thought a lot about this, and I do have some opinions about it 
how the process is described to work vs how it ends up working though. 
There has quite been a few times I get conflicting reviews from multiple 
reviewers. I suspect either because reviewers are not seeing each others 
reviews, or because it is difficult for people to recall or even find 
discussions on prior revisions.  And so at times, I find myself puzzling 
a bit trying to extrapolate what the community as a whole really wants.

For example: a reviewer may propose a minor change, perhaps a style 
change, and as long as it's not terrible I assume this is just how 
people are used to seeing things implemented.  So I amend it, and in the 
next revision someone expresses that they dislike it and makes a 
different proposition.  Generally I'll mention that this change was 
requested, but if anyone feels particularly strongly about it, to please 
chime in.  Most of the time I don't hear anything, I suspect because 
either the first reviewer isn't around, or they don't have time to 
revisit it?  Maybe they weren't strongly opinionated about it to begin 
with?  It could have been they were feeling pressure to generate 
reviews, or maybe an employer is measuring their engagement?  In any 
case, if it goes around a third time, I'll usually start including links 
to prior reviews to try and get people on the same page, but most of the 
time I've found the result is that it just falls silent.

At this point though it feels unclear to me if everyone is happy?  Did 
we have a constructive review?  Maybe it's not a very big deal and I 
should just move on.  And in many scenarios like the one above, the 
exact outcome appears to be of little concern to people in the greater 
scheme of things.  But this pattern does not always scale well in all 
cases.  Complex issues that persist over time generally do so because no 
one yet has a clear idea of what a correct solution even looks like, or 
perhaps cannot agree on one.  In my experience, getting people to come 
together on a common goal requires a sort of exploratory coding effort. 
Like a prototype that people can look at, learn from, share ideas, and 
then adapt the model from there.  But for that to work, they need to 
have been engaged with the history of it.  They need the common 
experience of seeing what has worked and what hasn't.  It helps people 
to let go of theories that have not performed well in practice, and 
shift to alternate approaches that have.  In a way, reviewers that have 
been historically more involved with a particular effort start to become 
a little integral to it as its reviewers.  Which I *think* is what 
Darrick may be eluding to in his initial proposition.  People request 
for certain reviewers, or perhaps the reviewers can volunteer to be sort 
of assigned to it in an effort to provide more constructive reviews.  In 
this way, reviewers allocate their efforts where they are most 
effective, and in doing so better distribute the work load as well.  Did 
I get that about right?  Thoughts?

Allison
