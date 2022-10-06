Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446C75F6143
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 08:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJFGzi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 02:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiJFGzc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 02:55:32 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422A14C620;
        Wed,  5 Oct 2022 23:55:28 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2966mJNR029984;
        Thu, 6 Oct 2022 06:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=LK4wddnx9ZBpFC32BkC9Gm2nZqLG6Abi1YuiNhae6Nw=;
 b=HRSQrEck+56L3f9JoSQuIs+QAhipxV5BQiP4uO0Jge21w11E7Fe2+B73eNsCLBrGTbJX
 uFVofnLwMOGJwA9XD0hx68gyqIL4oi9sJRi8ko/EEzBWZNnvTlCTvDoPTaZTCdeB3QHh
 ZMu2qE959Yh8YAUt4w595INiz+oBGOlo7I0q+2MF0jlp5kSJO0AeJWjL/xKEMITR3ZHA
 leTub1V8/S4PSgZxFkOquddAUD5zNn1md/D4Ev7SKiMX/527KritbcvUjeVM58bYCOaD
 GOPlbefNlLGVVnRDcWLfEnb+DDTwNyiZc2StDB+CkLJ1iuyH3q80CvtEJEpyt4/+z2Jx xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k1t2vg4ft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 06:55:21 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2966mnpF030975;
        Thu, 6 Oct 2022 06:55:21 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k1t2vg4ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 06:55:10 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2966oETV030576;
        Thu, 6 Oct 2022 06:55:08 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3jxd696k2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 06:55:08 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2966t6aZ59703742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Oct 2022 06:55:06 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 457694C044;
        Thu,  6 Oct 2022 06:55:06 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C861A4C040;
        Thu,  6 Oct 2022 06:55:03 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.110.181])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  6 Oct 2022 06:55:03 +0000 (GMT)
Date:   Thu, 6 Oct 2022 12:25:00 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC v3 8/8] ext4: Remove the logic to trim inode PAs
Message-ID: <Yz57xJSoksI5rHwL@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1664269665.git.ojaswin@linux.ibm.com>
 <a26fdd12f4f60cf506a42b6a95e8014e5f380b05.1664269665.git.ojaswin@linux.ibm.com>
 <20220929125311.bmkta7gp4a2hmcny@quack3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929125311.bmkta7gp4a2hmcny@quack3>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tSyBPJVk9wHcWcVc4GyPA8hL9UkB7Zs2
X-Proofpoint-ORIG-GUID: R9VrF9AND9D9F820vx1-Zxp9PAQEjzcG
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_05,2022-10-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=681 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210060038
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 02:53:11PM +0200, Jan Kara wrote:
> On Tue 27-09-22 14:46:48, Ojaswin Mujoo wrote:
> > Earlier, inode PAs were stored in a linked list. This caused a need to
> > periodically trim the list down inorder to avoid growing it to a very
> > large size, as this would severly affect performance during list
> > iteration.
> > 
> > Recent patches changed this list to an rbtree, and since the tree scales
> > up much better, we no longer need to have the trim functionality, hence
> > remove it.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> 
> I'm kind of wondering: Now there won't be performance issues with much
> more inode PAs but probably we don't want to let them grow completely out
> of control? E.g. I can imagine that if we'd have 1 billion of inode PAs
> attached to an inode, things would get wonky both in terms of memory
> consumption and also in terms of CPU time spent for the cases where we
> still do iterate all of the PAs... Is there anything which keeps inode PAs
> reasonably bounded?
> 
> 								Honza
> 
Hi Jan,

Sorry for the delay in response, I was on leave for the last few days.

So as per my understanding, after this patch, the only path where we
would need to traverse all the PAs is the ext4_discard_preallocations()
call where we discard all the PAs of an inode one by one (eg when
closing the file etc).  Such a discard is a colder path as we don't
usually expect to do it as often as say allocating blocks to an inode.

Originally, the limit was added in this patch [1] because of the time
lost in O(N) traversal in the allocation path (ext4_mb_use_preallocated
and ext4_mb_normalize_request). Since the rbtree addressed this
scalability issue we had decided to remove the trim logic in this
patchset.

[1]
https://lore.kernel.org/all/d7a98178-056b-6db5-6bce-4ead23f4a257@gmail.com/

That being said, I do agree that there should be some way to limit the
PAs from taking up an unreasonable amount of buddy space, memory and CPU
cycles in use cases like database files and disk files of long running
VMs. Previously the limit was 512 PAs per inode and trim was happening
in an LRU fashion, which is not very straightforward to implement in
trees. 

Another approach is rather than having a hard limit, we can throttle the
PAs based on some parameter like total active PAs in FS or FSUtil% of
the PAs but we might need to take care of fairness so one inode is not
holding all the PAs while others get throttled.

Anyways, I think the trimming part would need some brainstorming to get
right so just wondering if we could keep that as part of a separate
patchset and remove the trimming logic for now since rbtree has
addressed the scalability concerns in allocation path.

Do let me know your thoughts on this.

Regards,
Ojaswin
