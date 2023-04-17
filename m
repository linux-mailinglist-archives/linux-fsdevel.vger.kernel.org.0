Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0684C6E3D47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 03:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjDQB5a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 21:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDQB52 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 21:57:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E751732;
        Sun, 16 Apr 2023 18:57:26 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33GNUA2O001326;
        Mon, 17 Apr 2023 01:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=L9Wcv8rkKVN5YPndk6JYhl0L5ZbWkzhm+xluOAyJPHs=;
 b=lGqZ1ukiHNFWg/PALeJBikL6Cl8lCmFpUyRdRJgDDFdX66PkzF8DyqO+iy1XF6XR1BEF
 i127tW3IUKxyvNc4URbU//R5ADdFDRpqUMBnwzkNipwUm65n5aXNRxocl1EWsysCJvX1
 4ilABjuUGNeqtsWRYReXQv44JzLfSGyqmI+gDfSloV7+ZB+5VNuTzAaZdPrqUAr1iZ1z
 msmq1b7C6B+I/v0F9sZUSHVba1r6Pm9I5pVCvbYJsHBqJFu7jdxjt9qUhH8vHnJc+cTr
 rdhFATZnwkmwuM4o8gamlAvLk2P82G0tD5KjKNXwBlRmXWTVc2wJ+FKw1m4dP1WiESMv hA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q0deyu3kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 01:57:15 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33H1uKvw022701;
        Mon, 17 Apr 2023 01:57:15 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q0deyu3kc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 01:57:15 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33H1u8Wr001635;
        Mon, 17 Apr 2023 01:57:14 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3pykj72q5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 01:57:13 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33H1vCfU12059198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Apr 2023 01:57:12 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7EF9858054;
        Mon, 17 Apr 2023 01:57:12 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 384485803F;
        Mon, 17 Apr 2023 01:57:11 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 17 Apr 2023 01:57:11 +0000 (GMT)
Message-ID: <e2455c0e-5a17-7fc1-95e3-5f2aca2eb409@linux.ibm.com>
Date:   Sun, 16 Apr 2023 21:57:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM after
 writes
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
 <90a25725b4b3c96e84faefdb827b261901022606.camel@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <90a25725b4b3c96e84faefdb827b261901022606.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lzAmk8wQKKpT3TCd3DOaOW_gHklSx6J9
X-Proofpoint-GUID: hmd0gN8gzfOCF7eDU2NlxfKWEDSI_Btz
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-16_16,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170012
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/7/23 09:29, Jeff Layton wrote:
>>>>>
>>>>> I would ditch the original proposal in favor of this 2-line patch shown here:
>>>>>
>>>>> https://lore.kernel.org/linux-integrity/a95f62ed-8b8a-38e5-e468-ecbde3b221af@linux.ibm.com/T/#m3bd047c6e5c8200df1d273c0ad551c645dd43232
>>
>> We should cool it with the quick hacks to fix things. :)
>>
> 
> Yeah. It might fix this specific testcase, but I think the way it uses
> the i_version is "gameable" in other situations. Then again, I don't
> know a lot about IMA in this regard.
> 
> When is it expected to remeasure? If it's only expected to remeasure on
> a close(), then that's one thing. That would be a weird design though.

IMA should remeasure the file when it has visibly changed for another thread or process.


>>> -----------------------8<---------------------------
>>>
>>> [PATCH] IMA: use vfs_getattr_nosec to get the i_version
>>>
>>> IMA currently accesses the i_version out of the inode directly when it
>>> does a measurement. This is fine for most simple filesystems, but can be
>>> problematic with more complex setups (e.g. overlayfs).
>>>
>>> Make IMA instead call vfs_getattr_nosec to get this info. This allows
>>> the filesystem to determine whether and how to report the i_version, and
>>> should allow IMA to work properly with a broader class of filesystems in
>>> the future.
>>>
>>> Reported-by: Stefan Berger <stefanb@linux.ibm.com>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>
>> So, I think we want both; we want the ovl_copyattr() and the
>> vfs_getattr_nosec() change:
>>
>> (1) overlayfs should copy up the inode version in ovl_copyattr(). That
>>      is in line what we do with all other inode attributes. IOW, the
>>      overlayfs inode's i_version counter should aim to mirror the
>>      relevant layer's i_version counter. I wouldn't know why that
>>      shouldn't be the case. Asking the other way around there doesn't
>>      seem to be any use for overlayfs inodes to have an i_version that
>>      isn't just mirroring the relevant layer's i_version.
> 
> It's less than ideal to do this IMO, particularly with an IS_I_VERSION
> inode.
> 
> You can't just copy up the value from the upper. You'll need to call
> inode_query_iversion(upper_inode), which will flag the upper inode for a
> logged i_version update on the next write. IOW, this could create some
> (probably minor) metadata write amplification in the upper layer inode
> with IS_I_VERSION inodes.
> 
> 
>> (2) Jeff's changes for ima to make it rely on vfs_getattr_nosec().
>>      Currently, ima assumes that it will get the correct i_version from
>>      an inode but that just doesn't hold for stacking filesystem.
>>
>> While (1) would likely just fix the immediate bug (2) is correct and
>> _robust_. If we change how attributes are handled vfs_*() helpers will
>> get updated and ima with it. Poking at raw inodes without using
>> appropriate helpers is much more likely to get ima into trouble.
> 
> This will fix it the right way, I think (assuming it actually works),
> and should open the door for IMA to work properly with networked
> filesystems that support i_version as well.
> 
> Note that there Stephen is correct that calling getattr is probably
> going to be less efficient here since we're going to end up calling
> generic_fillattr unnecessarily, but I still think it's the right thing
> to do.

I was wondering whether to use the existing inode_eq_iversion() for all
other filesystems than overlayfs, nfs, and possibly other ones (which ones?)
where we would use the vfs_getattr_nosec() via a case on inode->i_sb->s_magic?
If so, would this function be generic enough to be a public function for libfs.c?

I'll hopefully be able to test the proposed patch tomorrow.

> 
> If it turns out to cause measurable performance regressions though,
> maybe we can look at adding a something that still calls ->getattr if it
> exists but only returns the change_cookie value.
