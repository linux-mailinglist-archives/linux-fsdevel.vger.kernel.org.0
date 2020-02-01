Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C387A14F604
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2020 04:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgBADWr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 22:22:47 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51736 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgBADWr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 22:22:47 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0113DCso049408;
        Sat, 1 Feb 2020 03:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=kNjiR+/svteuV6LLaPuXGoy57CwZtVF1XBdaBK6QUNQ=;
 b=gC8pGKvbSw56X0gnkZXAOa7/xjShPeID2KmKg7gDDdzFbbVRROKmxa/A4QcaBRxMy9YC
 oMvf0eVC9BeT9FJHIsefMwXAfGMQxZTrXul26PiP1AM5HgYwsUL9tVJNBwnR43kAbfZR
 aP+o2LIQ0cRvOnn97OAKJo0VCHmhwki9MGcocFNa7y0wsF9FWiwNRvYue94AAvppVCCo
 yrETtbxagrrS610O/qrDEpqqfIDcEOI7HSbYQj6r3xCf8o4G350UyRwNTlilNW2EMrPT
 dXAa52OzY3DBNI2FHZe3idW3aiEHQ/XIuJUYrHUBzqvhl+J0+Hp6GFmkDVDQlMdR3J8a Bw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xrearxb9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Feb 2020 03:22:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0113Dfxp076674;
        Sat, 1 Feb 2020 03:20:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2xvxffhcpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Feb 2020 03:20:40 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0113Kc9W017179;
        Sat, 1 Feb 2020 03:20:39 GMT
Received: from [192.168.1.223] (/67.1.3.112)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 01 Feb 2020 03:20:38 +0000
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] FS Maintainers Don't Scale
To:     Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>,
        Eric Sandeen <sandeen@redhat.com>
References: <20200131052520.GC6869@magnolia>
 <CAOQ4uxh=4DrH_dL3TULcFa+pGk0YhS=TobuGk_+Z0oRWvw63rg@mail.gmail.com>
From:   Allison Collins <allison.henderson@oracle.com>
Message-ID: <8983ceaa-1fda-f9cc-73c9-8764d010d3e2@oracle.com>
Date:   Fri, 31 Jan 2020 20:20:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxh=4DrH_dL3TULcFa+pGk0YhS=TobuGk_+Z0oRWvw63rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9517 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002010019
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9517 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002010019
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1/31/20 12:30 AM, Amir Goldstein wrote:
> On Fri, Jan 31, 2020 at 7:25 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>>
>> Hi everyone,
>>
>> I would like to discuss how to improve the process of shepherding code
>> into the kernel to make it more enjoyable for maintainers, reviewers,
>> and code authors.  Here is a brief summary of how we got here:
>>
>> Years ago, XFS had one maintainer tending to all four key git repos
>> (kernel, userspace, documentation, testing).  Like most subsystems, the
>> maintainer did a lot of review and porting code between the kernel and
>> userspace, though with help from others.
>>
>> It turns out that this didn't scale very well, so we split the
>> responsibilities into three maintainers.  Like most subsystems, the
>> maintainers still did a lot of review and porting work, though with help
>> from others.
>>
>> It turns out that this system doesn't scale very well either.  Even with
>> three maintainers sharing access to the git trees and working together
>> to get reviews done, mailing list traffic has been trending upwards for
>> years, and we still can't keep up.  I fear that many maintainers are
>> burning out.  For XFS, the biggest pain point (AFAICT) is not assembly and
>> testing of the git trees, but keeping up with the mail and the reviews.
>>
>> So what do we do about this?  I think we (the XFS project, anyway)
>> should increase the amount of organizing in our review process.  For
>> large patchsets, I would like to improve informal communication about
>> who the author might like to have conduct a review, who might be
>> interested in conducting a review, estimates of how much time a reviewer
>> has to spend on a patchset, and of course, feedback about how it went.
>> This of course is to lay the groundwork for making a case to our bosses
>> for growing our community, allocating time for reviews and for growing
>> our skills as reviewers.
>>
> 
> Interesting.
> 
> Eryu usually posts a weekly status of xfstests review queue, often with
> a call for reviewers, sometimes with specific patch series mentioned.
> That helps me as a developer to monitor the status of my own work
> and it helps me as a reviewer to put the efforts where the maintainer
> needs me the most.
> 
> For xfs kernel patches, I can represent the voice of "new blood".
> Getting new people to join the review effort is quite a hard barrier.
> I have taken a few stabs at doing review for xfs patch series over the
> year, but it mostly ends up feeling like it helped me (get to know xfs code
> better) more than it helped the maintainer, because the chances of a
> new reviewer to catch meaningful bugs are very low and if another reviewer
> is going to go over the same patch series, the chances of new reviewer to
> catch bugs that novice reviewer will not catch are extremely low.
That sounds like a familiar experience.  Lots of times I'll start a 
review, but then someone else will finish it before I do, and catch more 
things along the way.  So I sort of feel like if it's not something I 
can get through quickly, then it's not a very good distribution of work 
effort and I should shift to something else. Most of the time, I'll 
study it until I feel like I understand what the person is trying to do, 
and I might catch stuff that appears like it may not align with that 
pursuit, but I don't necessarily feel I can deem it void of all 
unforeseen bugs.

> 
> However, there are quite a few cleanup and refactoring patch series,
> especially on the xfs list, where a review from an "outsider" could still
> be of value to the xfs community. OTOH, for xfs maintainer, those are
> the easy patches to review, so is there a gain in offloading those reviews?
> 
> Bottom line - a report of the subsystem review queue status, call for
> reviewers and highlighting specific areas in need of review is a good idea.
> Developers responding to that report publicly with availability for review,
> intention and expected time frame for taking on a review would be helpful
> for both maintainers and potential reviewers.
I definitely think that would help delegate review efforts a little 
more.  That way it's clear what people are working on, and what still 
needs attention.

Allison
> 
> Thanks,
> Amir.
> 
>> ---
>>
>> I want to spend the time between right now and whenever this discussion
>> happens to make a list of everything that works and that could be made
>> better about our development process.
>>
>> I want to spend five minutes at the start of the discussion to
>> acknowledge everyone's feelings around that list that we will have
>> compiled.
>>
>> Then I want to spend the rest of the session breaking up the problems
>> into small enough pieces to solve, discussing solutions to those
>> problems, and (ideally) pushing towards a consensus on what series of
>> small adjustments we can make to arrive at something that works better
>> for everyone.
>>
>> --D
>> _______________________________________________
>> Lsf-pc mailing list
>> Lsf-pc@lists.linux-foundation.org
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.linuxfoundation.org_mailman_listinfo_lsf-2Dpc&d=DwIBaQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=LHZQ8fHvy6wDKXGTWcm97burZH5sQKHRDMaY1UthQxc&m=Ql7vKruZTArpiIL8k0b6mdoZIYyOEUFrtFysmO8BZl4&s=Se3_uV_gEF1-YsGVAlu6NVh1KqcEzWExsEy5PCH4BAM&e=
