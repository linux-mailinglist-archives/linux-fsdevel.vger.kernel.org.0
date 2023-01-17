Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA22366DB37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 11:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbjAQKda (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 05:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236445AbjAQKbx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 05:31:53 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE11B30EA9;
        Tue, 17 Jan 2023 02:31:04 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HACKxu035724;
        Tue, 17 Jan 2023 10:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=mPmk4a9QtXEJdomBqRRs6B9QnhAOUPg1gDW2orJ9t4I=;
 b=QfWhvQ4MkCuULhMbJbQfmzYJ2HBS92FCyTvlaQBGQ3PNWJ6Ue4EVWJ8r4AdbfSzYbB3c
 aFyE8Au5ZoHBdoB7zWmEscmXWIV7EOo/lqdD3swnRCt8muFdv7NA2aZXjp7m+RC07JCz
 XzZkpoE1zpzIEXEr3FcGUe/dynav7HLijI7oBTKCsT43+WUCDaWhSUcoKwgmLllUjv7Z
 u0ZE8aFjfH074uCwVWZz9eLUap76gHhWHMzQ0FzHfrOUOCKAEzIDLqta+k0/Avzw/Hal
 ZfVxdn6sxgHihPKoTxpa4H5rpUet1WFJywL3RzqhruGKYxZ/2uxmYqVWlvKag2TUo7d/ zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n5qb5uv3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 10:31:00 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30H9udwh029920;
        Tue, 17 Jan 2023 10:30:59 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n5qb5uv2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 10:30:59 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30HA9q7Z029613;
        Tue, 17 Jan 2023 10:30:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3n3knfap9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 10:30:57 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30HAUsCv53281114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 10:30:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C32D20040;
        Tue, 17 Jan 2023 10:30:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98A8A2004B;
        Tue, 17 Jan 2023 10:30:52 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.169])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 17 Jan 2023 10:30:52 +0000 (GMT)
Date:   Tue, 17 Jan 2023 16:00:47 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v3 7/8] ext4: Use rbtrees to manage PAs instead of inode
 i_prealloc_list
Message-ID: <Y8Z413XTPMr//bln@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230116080216.249195-1-ojaswin@linux.ibm.com>
 <20230116080216.249195-8-ojaswin@linux.ibm.com>
 <20230116122334.k2hlom22o2hlek3m@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116122334.k2hlom22o2hlek3m@quack3>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0kvfCPCYxiUWpKO6pr2fcr23STiYv8nd
X-Proofpoint-ORIG-GUID: 1Nk91KAQ_1ezjU7GE_0SGQKxxo20zVAM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_04,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 bulkscore=0 malwarescore=0 mlxlogscore=778
 suspectscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301170089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 01:23:34PM +0100, Jan Kara wrote:
> > Since this covers the special case we discussed above, we will always
> > un-delete the PA when we encounter the special case and we can then
> > adjust for overlap and traverse the PA rbtree without any issues.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Hi Jan,
Thanks for the review, sharing some of my thoughts below.

> 
> So I find this putting back of already deleted inode PA very fragile. For
> example in current code I suspect you've missed a case in ext4_mb_put_pa()
> which can mark inode PA (so it can then be spotted by
> ext4_mb_pa_adjust_overlap() and marked as in use again) but
> ext4_mb_put_pa() still goes on and destroys the PA.

The 2 code paths that clash here are:

ext4_mb_new_blocks() -> ext4_mb_release_context() -> ext4_mb_new_blocks()
ext4_mb_new_blocks() -> ext4_mb_normalize_request() -> ext4_mb_pa_adjust_overlap()

Since these are the only code paths from which these 2 functions are
called, for a given inode, access will always be serialized by the upper
level ei->i_data_sem, which is always taken when writing data blocks
using ext4_mb_new_block(). 

From my understanding of the code, I feel only
ext4_mb_discard_group_preallocations() can race against other functions
that are modifying the PA rbtree since it does not take any inode locks.

That being said, I do understand your concerns regarding the solution,
however I'm willing to work with the community to ensure our
implementation of this undelete feature is as robust as possible. Along
with fixing the bug reported here [1], I believe that it is also a good
optimization to have especially when the disk is near full and we are
seeing a lot of group discards going on. 

Also, in case the deleted PA completely lies inside our new range, it is
much better to just undelete and use it rather than deleting the
existing PA and reallocating the range again. I think the advantage
would be even bigger in ext4_mb_use_preallocated() function where we can
just undelete and use the PA and skip the entire allocation, incase original
range lies in a deleted PA.

> 
> So I'd really love to stay with the invariant that once PA is marked as
> deleted, it can never go alive again. Since finding such deleted PA that is
> overlapping our new range should be really rare, cannot we just make
> ext4_mb_pa_adjust_overlap() rb_erase() this deleted PA and restart the
> adjustment search? Since rb_erase() is not safe to be called twice, we'd
> have to record somewhere in the PA that the erasure has already happened
> (probably we could have two flags in 'deleted' field - deleted from group
> list, deleted from object (lg_list/inode_node)) but that is still much more
> robust...
Right, this is an apporach we did consider but we felt it would be a
better to take this opportunity to make the above optimization. Would
love to hear your thoughts on this.

Thanks,
Ojaswin

> 
> 								Honza
> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
