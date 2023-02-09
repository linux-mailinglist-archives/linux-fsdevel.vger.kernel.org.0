Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE17690F9B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 18:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjBIRyr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 12:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjBIRyq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 12:54:46 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6D33403F;
        Thu,  9 Feb 2023 09:54:44 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319HjKUO009775;
        Thu, 9 Feb 2023 17:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=GHi8QWj9ahC4bQfIAbe6VaZe/sXAjqq1oU8gWykQFdw=;
 b=rQTF6SRezbhcQnCOx6ZU8VlRBgQfbQZ7Ay9qbomYhQlTFF5jAvG9TVWu3w/hmOSQjMw6
 nwNg2Wd7OreCLbt2T07TIwc3K7ulU0lIzYMx5m7CFGLpiUzrWkTCGW5oA/hr6yXrLh5J
 y06JHXZtmgsDE+bBsyId/qn1RjRRz+Mju3hI7QcwrzO40XaayHtc4oMJYfWG+sqvr42X
 wS1mLllkCZraRl6jzByeJc58JFrfPquS9QfHQB7KZG13lrb3YD4M+XpBEEMNy5qOrfPN
 prhPpedcNUtMW1Iyemdq/czXpSS7S+4CZWn4JbC1FqxAJLFRbhbcbCC6WzDmDCc+IRjW rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nn5gjg69q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 17:54:40 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 319HmJug020079;
        Thu, 9 Feb 2023 17:54:39 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nn5gjg699-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 17:54:39 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 319DWH6x002393;
        Thu, 9 Feb 2023 17:54:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3nhf06pgm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 17:54:37 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 319HsZre26346090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Feb 2023 17:54:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D69520040;
        Thu,  9 Feb 2023 17:54:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87DB120043;
        Thu,  9 Feb 2023 17:54:33 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.127.44])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu,  9 Feb 2023 17:54:33 +0000 (GMT)
Date:   Thu, 9 Feb 2023 23:24:31 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v3 7/8] ext4: Use rbtrees to manage PAs instead of inode
 i_prealloc_list
Message-ID: <Y+UzQJRIJEiAr4Z4@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230116080216.249195-1-ojaswin@linux.ibm.com>
 <20230116080216.249195-8-ojaswin@linux.ibm.com>
 <20230116122334.k2hlom22o2hlek3m@quack3>
 <Y8Z413XTPMr//bln@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230117110335.7dtlq4catefgjrm3@quack3>
 <Y8jizbGg6l2WxJPF@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230127144312.3m3hmcufcvxxp6f4@quack3>
 <Y9zHkMx7w4Io0TTv@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <Y+OGkVvzPN0RMv0O@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230209105418.ucowiqnnptbpwone@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209105418.ucowiqnnptbpwone@quack3>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -h7DcXIBGq33Pa_-mvye41isKl0WEAwK
X-Proofpoint-ORIG-GUID: XQe3Nl9qAy2uLvHgLt8sVYTPeWoBxQXl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_13,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1015
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302090166
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 09, 2023 at 11:54:18AM +0100, Jan Kara wrote:
> Hello Ojaswin!
> 
> On Wed 08-02-23 16:55:05, Ojaswin Mujoo wrote:
> > On Fri, Feb 03, 2023 at 02:06:56PM +0530, Ojaswin Mujoo wrote:
> > > On Fri, Jan 27, 2023 at 03:43:12PM +0100, Jan Kara wrote:
> > > > 
> > > > Well, I think cond_resched() + goto retry would be OK here. We could also
> > > > cycle the corresponding group lock which would wait for
> > > > ext4_mb_discard_group_preallocations() to finish but that is going to burn
> > > > the CPU even more than the cond_resched() + retry as we'll be just spinning
> > > > on the spinlock. Sleeping is IMHO not warranted as the whole
> > > > ext4_mb_discard_group_preallocations() is running under a spinlock anyway
> > > > so it should better be a very short sleep.
> > > > 
> > > > Or actually I have one more possible solution: What the adjusting function
> > > > is doing that it looks up PA before and after ac->ac_o_ex.fe_logical and
> > > > trims start & end to not overlap these PAs. So we could just lookup these
> > > > two PAs (ignoring the deleted state) and then just iterate from these with
> > > > rb_prev() & rb_next() until we find not-deleted ones. What do you think? 
> > > 
> > > Hey Jan, 
> > > 
> > > Just thought I'd update you, I'm trying this solution out, and it looks
> > > good but I'm hitting a few bugs in the implementation. Will update here
> > > once I have it working correctly.
> > 
> > Alright, so after spending some time on these bugs I'm hitting I'm
> > seeing some strange behavior. Basically, it seems like in scenarios
> > where we are not able to allocate as many block as the normalized goal
> > request, we can sometimes end up adding a PA that overlaps with existing
> > PAs in the inode PA list/tree. This behavior exists even before this
> > particular patchset. Due to presence of such overlapping PAs, the above
> > logic was failing in some cases.
> > 
> > From my understanding of the code, this seems to be a BUG. We should not
> > be adding overlapping PA ranges as that causes us to preallocate
> > multiple blocks for the same logical offset in a file, however I would
> > also like to know if my understanding is incorrect and if this is an
> > intended behavior.
> > 
> > ----- Analysis of the issue ------
> > 
> > Here's my analysis of the behavior, which I did by adding some BUG_ONs
> > and running generic/269 (4k bs). It happens pretty often, like once
> > every 5-10 runs. Testing was done without applying this patch series on
> > the Ted's dev branch.
> > 
> > 1. So taking an example of a real scenario I hit. After we find the best
> > len possible, we enter the ext4_mb_new_inode_pa() function with the
> > following values for start and end of the extents:
> > 
> > ## format: <start>/<end>(<len>)
> > orig_ex:503/510(7) goal_ex:0/512(512) best_ex:0/394(394)
> > 
> > 2. Since (best_ex len < goal_ex len) we enter the PA window adjustment
> > if condition here:
> > 
> > 	if (ac->ac_b_ex.fe_len < ac->ac_g_ex.fe_len)
> > 		...
> > 	}
> > 
> > 3. Here, we calc wins, winl and off and adjust logical start and end of
> > the best found extent. The idea is to make sure that the best extent
> > atleast covers the original request. In this example, the values are:
> > 
> > winl:503 wins:387 off:109
> > 
> > and win = min(winl, wins, off) = 109
> > 
> > 4. We then adjust the logical start of the best ex as:
> > 
> > 		ac->ac_b_ex.fe_logical = ac->ac_o_ex.fe_logical - EXT4_NUM_B2C(sbi, win);
> > 
> > which makes the new best extent as:
> > 
> > best_ex: 394/788(394)
> > 
> > As we can see, the best extent overflows outside the goal range, and
> > hence we don't have any guarentee anymore that it will not overlap with
> > another PA since we only check overlaps with the goal start and end.
> > We then initialze the new PA with the logical start and end of the best
> > extent and finaly add it to the inode PA list.
> > 
> > In my testing I was able to actually see overlapping PAs being added to
> > the inode list.
> > 
> > ----------- END ---------------
> > 
> > Again, I would like to know if this is a BUG or intended. If its a BUG,
> > is it okay for us to make sure the adjusted best extent length doesn't 
> > extend the goal length? 
> 
> Good spotting. So I guess your understanding of mballoc is better than mine
> by now :) but at least in my mental model I would also expect the resulting
> preallocation to stay withing the goal extent. What is causing here the
> issue is this code in ext4_mb_new_inode_pa():
> 
>                 offs = ac->ac_o_ex.fe_logical %
>                         EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
>                 if (offs && offs < win)
>                         win = offs;
> 
> so we apparently try to align the logical offset of the allocation to a
> multiple of the allocated size but that just does not make much sense when
Hi Jan!

Yep, it is indeed the offset calculation that is cauing issues in this
particular example. Any idea why this was originally added?

> we found some random leftover extent with shorter-than-goal size. So what
> I'd do in the shorter-than-goal preallocation case is:
> 
> 1) If we can place the allocation at the end of goal window and still cover
> the original allocation request, do that.
> 
> 2) Otherwise if we can place the allocation at the start of the goal
> window and still cover the original allocation request, do that.
> 
> 3) Otherwise place the allocation at the start of the original allocation
> request.
> 
> This would seem to reasonably reduce fragmentation of preallocated space
> and still keep things simple.
This looks like a good approach to me and it will take care of the issue
caused due to offset calculation.

However, after commenting out the offset calculation bit in PA window
adjustment logic, I noticed that there is one more way that such an
overflow can happen, which would need to be addressed before we can
implement the above approach. Basically, this happens when we end up
with a goal len greater than the original len.

See my comments at the end for more info.

> 
> > Also, another thing I noticed is that after ext4_mb_normalize_request(),
> > sometimes the original range can also exceed the normalized goal range,
> > which is again was a bit surprising to me since my understanding was
> > that normalized range would always encompass the orignal range.
> 
> Well, isn't that because (part of) the requested original range is already
> preallocated? Or what causes the goal range to be shortened?
> 
Yes I think that pre existing PAs could be one of the cases.

Other than that, I'm also seeing some cases of sparse writes which can cause
ext4_mb_normalize_request() to result in having an original range that
overflows out of the goal range. For example, I observed these values just
after the if else if else conditions in the function, before we check if range
overlaps pre existing PAs:

orig_ex:2045/2055(len:10) normalized_range:0/2048, orig_isize:8417280

Basically, since isize is large and we are doing a sparse write, we end
up in the following if condition:

	} else if (NRL_CHECK_SIZE(ac->ac_o_ex.fe_len,
								(8<<20)>>bsbits, max, 8 * 1024)) {
		start_off = ((loff_t)ac->ac_o_ex.fe_logical >> (23 - bsbits)) << 23;
		size = 8 * 1024 * 1024;
 }

Resulting in normalized range less than original range.

Now, in any case, once we get such an overflow, if we try to enter the PA
adjustment window in ext4_mb_new_inode_pa() function, we will again end up with
a best extent overflowing out of goal extent since we would try to cover the
original extent. 

So yeah, seems like there are 2 cases where we could result in overlapping PAs:

1. Due to off calculation in PA adjustment window, as we discussed.  2. Due to
original extent overflowing out of goal extent.

I think the 3 step solution you proposed works well to counter 1 but not 2, so
we probably need some more logic on top of your solution to take care of that.
I'll think some more on how to fix this but I think this will be as a separate
patch.

Regards,
Ojaswin 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
