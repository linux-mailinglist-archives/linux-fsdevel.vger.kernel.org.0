Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3847A6B78A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Mar 2023 14:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjCMNQa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Mar 2023 09:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCMNQ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:16:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A9E48E2D;
        Mon, 13 Mar 2023 06:16:21 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DCMBc8020399;
        Mon, 13 Mar 2023 13:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=QNtstb2+hN/959P/zIKmgULZ08GeCrSa7kKZDxyzbT0=;
 b=PpifbRplUaY4x1gWqDqStqAzyy8PpQTjvaaUKxASrcko6kzxqzrOQ5iXwSWLUlCUKHO+
 uXmBgHf/T6x/lF+8gl6oHnQJLbM8lSI1KDrzZFk50t3ocYNYyAIFYNNrF79IEf2TgUt0
 S8l9eP0RSQ4EO2Ser7aXo2rzbFYY7zKRZ5J5XgJLcrHkE79Nuy3MCk4Bqz9ES6xXAoSU
 tAEKXmt5dWl3vKut6QQCqVEdNECyoZ/5TAR+BVV2k/s3mTPQFnM3S89tx66t0b1VH2B5
 QCqfkBtE4GtFzuAsPBhS0l/AVWJbEVc1Xu2R1eE0pFg3d57G5KDkGkE61GXN9BhHmvLZ Ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pa3sbsh2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 13:16:12 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32DCNL4t024217;
        Mon, 13 Mar 2023 13:16:12 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pa3sbsh1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 13:16:11 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32D97poO005437;
        Mon, 13 Mar 2023 13:16:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3p8h96jmmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 13:16:10 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32DDG5wn53608718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 13:16:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FFAD2004B;
        Mon, 13 Mar 2023 13:16:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F9DB20040;
        Mon, 13 Mar 2023 13:16:04 +0000 (GMT)
Received: from localhost (unknown [9.171.94.54])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Mar 2023 13:16:04 +0000 (GMT)
Date:   Mon, 13 Mar 2023 14:16:03 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, sudipm.mukherjee@gmail.com,
        ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] s390: simplify sysctl registration
Message-ID: <your-ad-here.call-01678713363-ext-0026@work.hours>
References: <20230310234525.3986352-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230310234525.3986352-1-mcgrof@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PB3D0CYJhEnZXA1LJb5IZPi3J2e08O7s
X-Proofpoint-GUID: 1iKSK_DEV1qp-G_C1J0r5O6yt1vnxs-o
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_05,2023-03-13_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 mlxlogscore=985 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130106
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 10, 2023 at 03:45:19PM -0800, Luis Chamberlain wrote:
> s390 is the last architecture and one of the last users of
> register_sysctl_table(). It was last becuase it had one use case
> with dynamic memory allocation and it just required a bit more
> thought.
> 
> This is all being done to help reduce code and avoid usage of API
> calls for sysctl registration that can incur recusion. The recursion
> only happens when you have subdirectories with entries and s390 does
> not have any of that so either way recursion is avoided. Long term
> though we can do away with just removing register_sysctl_table()
> and then using ARRAY_SIZE() and save us tons of memory all over the
> place by not having to add an extra empty entry all over.
> 
> Hopefully that commit log suffices for the dynamic allocation
> conversion, but I would really like someone to test it as I haven't
> tested a single patch, I'm super guiltly to accept I've just waited for
> patches to finish compile testing and that's not over yet.
> 
> Anyway the changes other than the dynamic allocation one are pretty
> trivial. That one could use some good review.
> 
> With all this out of the way we have just one stupid last user of
> register_sysctl_table(): drivers/parport/procfs.c
> 
> That one is also dynamic. Hopefully the maintainer will be motivated
> to do that conversion with all the examples out there now and this
> having a complex one.
> 
> For more information refer to the new docs:
> 
> https://lore.kernel.org/all/20230310223947.3917711-1-mcgrof@kernel.org/T/#u     
>  
> Luis Chamberlain (6):
>   s390: simplify one-level sysctl registration for topology_ctl_table
>   s390: simplify one-level syctl registration for s390dbf_table
>   s390: simplify one-level sysctl registration for appldata_table
>   s390: simplify one level sysctl registration for cmm_table
>   s390: simplify one-level sysctl registration for page_table_sysctl
>   s390: simplify dynamic sysctl registration for appldata_register_ops
> 
>  arch/s390/appldata/appldata_base.c | 30 ++++++++----------------------
>  arch/s390/kernel/debug.c           | 12 +-----------
>  arch/s390/kernel/topology.c        | 12 +-----------
>  arch/s390/mm/cmm.c                 | 12 +-----------
>  arch/s390/mm/pgalloc.c             | 12 +-----------
>  5 files changed, 12 insertions(+), 66 deletions(-)

I've added my
Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
for the entire patch series.

And applied with the fixup for last change (see corresponding reply).
Thank you!
