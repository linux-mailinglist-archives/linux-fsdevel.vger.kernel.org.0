Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D836BE6B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 11:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjCQK15 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 06:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjCQK1t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 06:27:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B12E5015;
        Fri, 17 Mar 2023 03:27:07 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HABQ9K028404;
        Fri, 17 Mar 2023 10:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=yO8si3+qVNWSrYdd+uGWatDvhebZLLgBBHpS17CbCCk=;
 b=D2Mw0vVBeTibf/qL3DUCNMTXvMriHeHcOFmJMFOE3NmwvrGVNXZEXXMV7BbEYdCR1BE9
 7/rs9sNuZFWIcEYKiSUrjS8YHVqO5jw5g1RcU+Dj5qUZobL+wMq6TnpMXqObbUn1n/vG
 xjUpCVt46WkAJYFCui0gBNY0JXkhNNt90/6EQWmvxTHuVnIU51rnz8PhuTN39X77dii/
 Jw2YW1dVU8qQtW9l1GnQsydw79Z2Kcsz69+rS5huZCjnim6IaPbeDKu6CQ3ofV4xkBDc
 oZHF6VTvxILJzNgvA5tJRjrpUdwhx0tVXR3BW7w3Mt+b1l7Vi2WsIH1qV/yJczQaZogw Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pcnjx1d7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 10:26:56 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32HABVCf029337;
        Fri, 17 Mar 2023 10:26:55 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pcnjx1d74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 10:26:55 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32GIT4fj027512;
        Fri, 17 Mar 2023 10:26:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3pbsyxsmbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 10:26:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32HAQpuw62062884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 10:26:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 387352006A;
        Fri, 17 Mar 2023 10:26:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14B5B20063;
        Fri, 17 Mar 2023 10:26:49 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.91.202])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 17 Mar 2023 10:26:48 +0000 (GMT)
Date:   Fri, 17 Mar 2023 15:56:46 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC 04/11] ext4: Convert mballoc cr (criteria) to enum
Message-ID: <ZBRAZsvbcSBNJ+Pl@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
 <9670431b31aa62e83509fa2802aad364910ee52e.1674822311.git.ojaswin@linux.ibm.com>
 <20230309121122.vzfswandgqqm4yk5@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309121122.vzfswandgqqm4yk5@quack3>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1oTpBwgoKcrO-oSGQ7zgqkLbRV1bPfo5
X-Proofpoint-ORIG-GUID: wbmmz5BvAKShzth4OIPAAWvkqPugUlUa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_06,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 09, 2023 at 01:11:22PM +0100, Jan Kara wrote:
> On Fri 27-01-23 18:07:31, Ojaswin Mujoo wrote:
> > Convert criteria to be an enum so it easier to maintain. This change
> > also makes it easier to insert new criterias in the future.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> 
> Just two small comments below:
Hi Jan,

Thanks for the review. 
> 
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index b8b00457da8d..6037b8e0af86 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -126,6 +126,14 @@ enum SHIFT_DIRECTION {
> >  	SHIFT_RIGHT,
> >  };
> >  
> > +/*
> > + * Number of criterias defined. For each criteria, mballoc has slightly
> > + * different way of finding the required blocks nad usually, higher the
> 						   ^^^ and
> 
> > + * criteria the slower the allocation. We start at lower criterias and keep
> > + * falling back to higher ones if we are not able to find any blocks.
> > + */
> > +#define EXT4_MB_NUM_CRS 4
> > +
> 
> So defining this in a different header than the enum itself is fragile. I
> understand you need it in ext4_sb_info declaration so probably I'd move the
> enum declaration to ext4.h. Alternatively I suppose we could move a lot of
Got it, I'll try to keep them in the same file.

> mballoc stuff out of ext4_sb_info into a separate struct because there's a
> lot of it. But that would be much larger undertaking.
Right, we did notice that as well, but as you said, that's out of scope
of this patchset.
> 
> Also when going for symbolic allocator scan names maybe we could actually
> make names sensible instead of CR[0-4]? Perhaps like CR_ORDER2_ALIGNED,
> CR_BEST_LENGHT_FAST, CR_BEST_LENGTH_ALL, CR_ANY_FREE. And probably we could
> deal with ordered comparisons like in:
I like this idea, it should make the code a bit more easier to
understand. However just wondering if I should do it as a part of this
series or a separate patch since we'll be touching code all around and 
I don't want to confuse people with the noise :) 
> 
>                 if (cr < 2 &&
>                     (!sbi->s_log_groups_per_flex ||
>                      ((group & ((1 << sbi->s_log_groups_per_flex) - 1)) != 0)) &
>                     !(ext4_has_group_desc_csum(sb) &&
>                       (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))))
>                         return 0;
> 
> to declare CR_FAST_SCAN = 2, or something like that. What do you think?
About this, wont it be better to just use something like

cr < CR_BEST_LENGTH_ALL 

instead of defining a new CR_FAST_SCAN = 2.

The only concern is that if we add a new "fast" CR (say between
CR_BEST_LENGTH_FAST and CR_BEST_LENGTH_ALL) then we'll need to make
sure we also update CR_FAST_SCAN to 3 which is easy to miss.

Regards,
Ojaswin
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
