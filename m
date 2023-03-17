Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F046BE983
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 13:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjCQMlU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 08:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjCQMlS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:41:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E11995BF8;
        Fri, 17 Mar 2023 05:41:06 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HBohq2023920;
        Fri, 17 Mar 2023 12:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=7ML8qvCc7bsbgf0VRkbvrNELPBTFwwaHfEsnoYoxBho=;
 b=ZMLcCgggNP5gtpkWqB9KkDydI32aK7JKVEj9p8aBd4dMnS+QpVSe45mZMweMR9an4+jM
 FqnVp4ttkJqWXUdttCQqv+x4pzyZPkWL2mTqZU6ZQiqRSWjYxpV2zzVwtySFSX+VkkaH
 YmFVMbSh/Dd0tU3cEpC+d4OOQbfl599okpsuVEO9Dl3iZH29vMmAG8DDC/yCKeL9Xfv6
 96YSxX19G/yyGfB3tA/r4IZKn6bp5XETUQ9DVnHkfaR/fi2BV6gGlkvs4R1poawsmqzX
 DShDZocdyESLyniaSPN6wZr3vRpY1yJKnJHBLLsYau2iH/fE0ms7MxW/K+INpJx4cT8a Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pcqpkh9p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 12:41:01 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32HCIw6f023668;
        Fri, 17 Mar 2023 12:41:01 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pcqpkh9mp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 12:41:01 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32H6uCuq030602;
        Fri, 17 Mar 2023 12:40:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3pbskt25b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 12:40:58 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32HCeuJB66781560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 12:40:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E30D2004E;
        Fri, 17 Mar 2023 12:40:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FD4C20043;
        Fri, 17 Mar 2023 12:40:53 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.91.202])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 17 Mar 2023 12:40:53 +0000 (GMT)
Date:   Fri, 17 Mar 2023 18:10:50 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v3 7/8] ext4: Use rbtrees to manage PAs instead of inode
 i_prealloc_list
Message-ID: <ZBRf0i+hR2lDvi/P@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <Y8Z413XTPMr//bln@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230117110335.7dtlq4catefgjrm3@quack3>
 <Y8jizbGg6l2WxJPF@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230127144312.3m3hmcufcvxxp6f4@quack3>
 <Y9zHkMx7w4Io0TTv@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <Y+OGkVvzPN0RMv0O@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230209105418.ucowiqnnptbpwone@quack3>
 <Y+UzQJRIJEiAr4Z4@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230210143753.ofh6wouk7vi7ygcl@quack3>
 <542D3378-3214-4D0D-AA63-5A149E2B00EE@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <542D3378-3214-4D0D-AA63-5A149E2B00EE@dilger.ca>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SBkpyyo-RXdzCNY5E1a7Q2hPaD94ed66
X-Proofpoint-GUID: ITi_cxAx98Y05cHqO-SNxVVoatqpqM5d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_08,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 malwarescore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 16, 2023 at 10:07:39AM -0700, Andreas Dilger wrote:
> On Feb 10, 2023, at 7:37 AM, Jan Kara <jack@suse.cz> wrote:
> > So I belive mballoc tries to align everything (offsets & lengths)
> > to powers of two to reduce fragmentation and simplify the work for
> > the buddy allocator.  If ac->ac_b_ex.fe_len is a power-of-two, the
> > alignment makes sense. But once we had to resort to higher allocator
> > passes and just got some random-length extent, the alignment stops
> > making sense.
> 
> In addition to optimizing for the buddy allocator, the other reason that
> the allocations are aligned to power-of-two offsets is to better align
> with underlying RAID stripes.  Otherwise, unaligned writes will cause
> parity read-modify-write updates to multiple RAID stripes.  This alignment
> can also help (though to a lesser degree) with NAND flash erase blocks.
> 
> Cheers, Andreas
> 
Got it, thanks. So from my limited understanding of RAID, if the write
is stripe aligned and the (length % stripe == 0) then we won't need a 
RMW cycle for parity bits and thats one of the reasons to pay attention
to alignment and length in mballoc code. 

Then I think Jan's reasoning still holds that if ac_b_ex.fe_len is already
not of a proper size then we'll anyways be ending with a RMW write in
RAID so no point of paying attention to its alignment, right?

Regards,
ojaswin
