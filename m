Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6940259C30D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 17:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbiHVPlE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 11:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbiHVPlD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:41:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3E71CB12;
        Mon, 22 Aug 2022 08:41:01 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MFLBL8020163;
        Mon, 22 Aug 2022 15:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=lddkyQHtWAfy+8kCR5xXy2/UWZSf+wIC546gE9xT5jo=;
 b=cwWnKnfoClt3sgXZBbYK/p6r/k7vxvI6KoHJ3ma9UMShwYUoHmWXfm+PymNvxd2eGcn4
 yIG+zkRQjzSV8aQpHEjxzYjmh7/b02KSYVt8Hy1Fg2Dgf7IN3dFHnou25prl5CfRL/dU
 QVVj9skO4eXYQXogoJOIXUj4fSNck7a0vAcgvSUgY6VKjQUG7NiWrqBDcJZtsWvG1giV
 KfEl2/V4T9e2DQ7VXPDtnP7DskoZ/TCJMVNw43v1qaqsH4YMsUC3Kv/p6bNqNB+nrEUC
 Os6S+fvzP7M0cr56i1mGyjxK+WDXHaUPQFiFNcudNvc07ueL23tjaaHq9I+LJNDxDFhS Sw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j4cc80gs1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 15:40:48 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27MFa3SU004850;
        Mon, 22 Aug 2022 15:40:46 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 3j2q899w85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 15:40:46 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27MFehtG32702762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:40:43 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7015BA405C;
        Mon, 22 Aug 2022 15:40:43 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F16AAA4054;
        Mon, 22 Aug 2022 15:40:40 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.163.20.129])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 22 Aug 2022 15:40:40 +0000 (GMT)
Message-ID: <ceb8f09a4cb2de67f40604d03ee0c475feb3130a.camel@linux.ibm.com>
Subject: Re: [PATCH] iversion: update comments with info about atime updates
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, NeilBrown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Dave Chinner <david@fromorbit.com>
Date:   Mon, 22 Aug 2022 11:40:39 -0400
In-Reply-To: <20220822133309.86005-1-jlayton@kernel.org>
References: <20220822133309.86005-1-jlayton@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p0ILes2ft5G78Rkn64Y3bsWGXPf2Mefm
X-Proofpoint-ORIG-GUID: p0ILes2ft5G78Rkn64Y3bsWGXPf2Mefm
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_10,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 clxscore=1011 mlxscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-08-22 at 09:33 -0400, Jeff Layton wrote:
> Add an explicit paragraph codifying that atime updates due to reads
> should not be counted against the i_version counter. None of the
> existing subsystems that use the i_version want those counted, and
> there is an easy workaround for those that do.
> 
> Cc: NeilBrown <neilb@suse.de>
> Cc: Trond Myklebust <trondmy@hammerspace.com>
> Cc: Dave Chinner <david@fromorbit.com>
> Link: https://lore.kernel.org/linux-xfs/166086932784.5425.17134712694961326033@noble.neil.brown.name/#t
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  include/linux/iversion.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/iversion.h b/include/linux/iversion.h
> index 3bfebde5a1a6..da6cc1cc520a 100644
> --- a/include/linux/iversion.h
> +++ b/include/linux/iversion.h
> @@ -9,8 +9,8 @@
>   * ---------------------------
>   * The change attribute (i_version) is mandated by NFSv4 and is mostly for
>   * knfsd, but is also used for other purposes (e.g. IMA). The i_version must
> - * appear different to observers if there was a change to the inode's data or
> - * metadata since it was last queried.
> + * appear different to observers if there was an explicit change to the inode's
> + * data or metadata since it was last queried.
>   *
>   * Observers see the i_version as a 64-bit number that never decreases. If it
>   * remains the same since it was last checked, then nothing has changed in the
> @@ -18,6 +18,12 @@
>   * anything about the nature or magnitude of the changes from the value, only
>   * that the inode has changed in some fashion.
>   *
> + * Note that atime updates due to reads or similar activity do _not_ represent
> + * an explicit change to the inode. If the only change is to the atime and it

Thanks, Jeff.  The ext4 patch increments i_version on file metadata
changes.  Could the wording here be more explicit to reflect changes
based on either inode data or metadata changes?

thanks,

Mimi

> + * wasn't set via utimes() or a similar mechanism, then i_version should not be
> + * incremented. If an observer cares about atime updates, it should plan to
> + * fetch and store them in conjunction with the i_version.
> + *
>   * Not all filesystems properly implement the i_version counter. Subsystems that
>   * want to use i_version field on an inode should first check whether the
>   * filesystem sets the SB_I_VERSION flag (usually via the IS_I_VERSION macro).


