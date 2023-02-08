Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF2068EDE2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 12:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjBHLZX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 06:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjBHLZW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:25:22 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880EA1BD8;
        Wed,  8 Feb 2023 03:25:20 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318ATgwH020179;
        Wed, 8 Feb 2023 11:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=L+6Lr5mei1+6jAImNdi0HSc1OK4i6MHX0/U+3dqaMBk=;
 b=JVyNO6e4Km8Yvs/Tik6RqKl+1Vhq/ANOyJ5mRqhsXRS4UmXFlpiVQg2vBo3G9ep7PQ6z
 70N0qYNVSKnbdBgFgNmZKjOZ67n03rtK8A2n//W1/i+7fsi/ahwJcA5i63ogSrKK0/Xc
 tiokr8m4+clh23u1dB644m3I0FwB25WdBjDrFwvym0UKxLvzo1UDr651EZuAiZTDYGGS
 DZKQocoDKnp1UzIseWmHSwLlCXDo7N+Fvsjj/leOzU31zthk4DbmIpxHgQnAcSd0GwkI
 nh4iSJ8X6nJNB0qFlmwEdSR9D2rWzjqPRalGp4JiXy5Oj3pNDSuQIrq6ZTLguKhlxpVC eA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nma1ksmev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 11:25:15 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 318AUFXS021155;
        Wed, 8 Feb 2023 11:25:15 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nma1ksmec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 11:25:14 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3185ageT024247;
        Wed, 8 Feb 2023 11:25:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3nhf06vu3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 11:25:13 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 318BPADT47579456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Feb 2023 11:25:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6F1220043;
        Wed,  8 Feb 2023 11:25:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 821EE20040;
        Wed,  8 Feb 2023 11:25:08 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.169])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  8 Feb 2023 11:25:08 +0000 (GMT)
Date:   Wed, 8 Feb 2023 16:55:05 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v3 7/8] ext4: Use rbtrees to manage PAs instead of inode
 i_prealloc_list
Message-ID: <Y+OGkVvzPN0RMv0O@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230116080216.249195-1-ojaswin@linux.ibm.com>
 <20230116080216.249195-8-ojaswin@linux.ibm.com>
 <20230116122334.k2hlom22o2hlek3m@quack3>
 <Y8Z413XTPMr//bln@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230117110335.7dtlq4catefgjrm3@quack3>
 <Y8jizbGg6l2WxJPF@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230127144312.3m3hmcufcvxxp6f4@quack3>
 <Y9zHkMx7w4Io0TTv@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9zHkMx7w4Io0TTv@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3ZbE-ERl6XHQopFhVehSSI88lNRJdVWK
X-Proofpoint-ORIG-GUID: Y_lDQoHEuzwHFWxNA9VqSV2YqT6fbFH6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_03,2023-02-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 clxscore=1015 phishscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302080100
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 03, 2023 at 02:06:56PM +0530, Ojaswin Mujoo wrote:
> On Fri, Jan 27, 2023 at 03:43:12PM +0100, Jan Kara wrote:
> > 
> > Well, I think cond_resched() + goto retry would be OK here. We could also
> > cycle the corresponding group lock which would wait for
> > ext4_mb_discard_group_preallocations() to finish but that is going to burn
> > the CPU even more than the cond_resched() + retry as we'll be just spinning
> > on the spinlock. Sleeping is IMHO not warranted as the whole
> > ext4_mb_discard_group_preallocations() is running under a spinlock anyway
> > so it should better be a very short sleep.
> > 
> > Or actually I have one more possible solution: What the adjusting function
> > is doing that it looks up PA before and after ac->ac_o_ex.fe_logical and
> > trims start & end to not overlap these PAs. So we could just lookup these
> > two PAs (ignoring the deleted state) and then just iterate from these with
> > rb_prev() & rb_next() until we find not-deleted ones. What do you think? 
> 
> Hey Jan, 
> 
> Just thought I'd update you, I'm trying this solution out, and it looks
> good but I'm hitting a few bugs in the implementation. Will update here
> once I have it working correctly.

Alright, so after spending some time on these bugs I'm hitting I'm
seeing some strange behavior. Basically, it seems like in scenarios
where we are not able to allocate as many block as the normalized goal
request, we can sometimes end up adding a PA that overlaps with existing
PAs in the inode PA list/tree. This behavior exists even before this
particular patchset. Due to presence of such overlapping PAs, the above
logic was failing in some cases.

From my understanding of the code, this seems to be a BUG. We should not
be adding overlapping PA ranges as that causes us to preallocate
multiple blocks for the same logical offset in a file, however I would
also like to know if my understanding is incorrect and if this is an
intended behavior.

----- Analysis of the issue ------

Here's my analysis of the behavior, which I did by adding some BUG_ONs
and running generic/269 (4k bs). It happens pretty often, like once
every 5-10 runs. Testing was done without applying this patch series on
the Ted's dev branch.

1. So taking an example of a real scenario I hit. After we find the best
len possible, we enter the ext4_mb_new_inode_pa() function with the
following values for start and end of the extents:

## format: <start>/<end>(<len>)
orig_ex:503/510(7) goal_ex:0/512(512) best_ex:0/394(394)

2. Since (best_ex len < goal_ex len) we enter the PA window adjustment
if condition here:

	if (ac->ac_b_ex.fe_len < ac->ac_g_ex.fe_len)
		...
	}

3. Here, we calc wins, winl and off and adjust logical start and end of
the best found extent. The idea is to make sure that the best extent
atleast covers the original request. In this example, the values are:

winl:503 wins:387 off:109

and win = min(winl, wins, off) = 109

4. We then adjust the logical start of the best ex as:

		ac->ac_b_ex.fe_logical = ac->ac_o_ex.fe_logical - EXT4_NUM_B2C(sbi, win);

which makes the new best extent as:

best_ex: 394/788(394)

As we can see, the best extent overflows outside the goal range, and
hence we don't have any guarentee anymore that it will not overlap with
another PA since we only check overlaps with the goal start and end.
We then initialze the new PA with the logical start and end of the best
extent and finaly add it to the inode PA list.

In my testing I was able to actually see overlapping PAs being added to
the inode list.

----------- END ---------------

Again, I would like to know if this is a BUG or intended. If its a BUG,
is it okay for us to make sure the adjusted best extent length doesn't 
extend the goal length? 

Also, another thing I noticed is that after ext4_mb_normalize_request(),
sometimes the original range can also exceed the normalized goal range,
which is again was a bit surprising to me since my understanding was
that normalized range would always encompass the orignal range.

Hoping to get some insights into the above points.

Regards,
ojaswin
