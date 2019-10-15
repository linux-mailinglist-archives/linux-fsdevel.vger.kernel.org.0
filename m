Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2A12D6E11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 06:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbfJOEKl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 00:10:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42390 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725268AbfJOEKl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 00:10:41 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9F4AaMY044965
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2019 00:10:40 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vn5ja227f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2019 00:10:38 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 15 Oct 2019 05:07:36 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 15 Oct 2019 05:07:33 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9F47VIl39125208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 04:07:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA2FA4204C;
        Tue, 15 Oct 2019 04:07:31 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A84742047;
        Tue, 15 Oct 2019 04:07:30 +0000 (GMT)
Received: from [9.199.158.130] (unknown [9.199.158.130])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Oct 2019 04:07:30 +0000 (GMT)
Subject: Re: [PATCH RESEND 1/1] vfs: Really check for inode ptr in lookup_fast
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, wugyuan@cn.ibm.com,
        jlayton@kernel.org, hsiangkao@aol.com
References: <20190927044243.18856-1-riteshh@linux.ibm.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 15 Oct 2019 09:37:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190927044243.18856-1-riteshh@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19101504-4275-0000-0000-000003721EB3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101504-4276-0000-0000-000038852F18
Message-Id: <20191015040730.6A84742047@d06av24.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-15_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910150036
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping!!

On 9/27/19 10:12 AM, Ritesh Harjani wrote:
> d_is_negative can race with d_instantiate_new()
> -> __d_set_inode_and_type().
> For e.g. in use cases where Thread-1 is creating
> symlink (doing d_instantiate_new()) & Thread-2 is doing
> cat of that symlink while doing lookup_fast (via REF-walk-
> one such case is, when ->permission returns -ECHILD).
> 
> During this race if __d_set_and_inode_type() does out-of-order
> execution and set the dentry->d_flags before setting
> dentry->inode, then it can result into following kernel panic.
> 
> This change fixes the issue by directly checking for inode.
> 
> E.g. kernel panic, since inode was NULL.
> trailing_symlink() -> may_follow_link() -> inode->i_uid.
> Issue signature:-
>    [NIP  : trailing_symlink+80]
>    [LR   : trailing_symlink+1092]
>    #4 [c00000198069bb70] trailing_symlink at c0000000004bae60  (unreliable)
>    #5 [c00000198069bc00] path_openat at c0000000004bdd14
>    #6 [c00000198069bc90] do_filp_open at c0000000004c0274
>    #7 [c00000198069bdb0] do_sys_open at c00000000049b248
>    #8 [c00000198069be30] system_call at c00000000000b388
> 
> Sequence of events:-
> Thread-2(Comm: ln) 	       Thread-1(Comm: cat)
> 
> 	                dentry = __d_lookup() //nonRCU
> 
> __d_set_and_inode_type() (Out-of-order execution)
>      flags = READ_ONCE(dentry->d_flags);
>      flags &= ~(DCACHE_ENTRY_TYPE | DCACHE_FALLTHRU);
>      flags |= type_flags;
>      WRITE_ONCE(dentry->d_flags, flags);
> 
> 	                if (unlikely(d_is_negative()) // fails
> 	                       {}
> 	                // since d_flags is already updated in
> 	                // Thread-2 in parallel but inode
> 	                // not yet set.
> 	                // d_is_negative returns false
> 
> 	                *inode = d_backing_inode(path->dentry);
> 	                // means inode is still NULL
> 
>      dentry->d_inode = inode;
> 
> 	                trailing_symlink()
> 	                    may_follow_link()
> 	                        inode = nd->link_inode;
> 	                        // nd->link_inode = NULL
> 	                        //Then it crashes while
> 	                        //doing inode->i_uid
> 
> Reported-by: Guang Yuan Wu <wugyuan@cn.ibm.com>
> Tested-by: Guang Yuan Wu <wugyuan@cn.ibm.com>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>   fs/namei.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 671c3c1a3425..7c5337cddebd 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1617,7 +1617,21 @@ static int lookup_fast(struct nameidata *nd,
>   		dput(dentry);
>   		return status;
>   	}
> -	if (unlikely(d_is_negative(dentry))) {
> +
> +	/*
> +	 * Caution: d_is_negative() can race with
> +	 * __d_set_inode_and_type().
> +	 * For e.g. in use cases where Thread-1 is creating
> +	 * symlink (doing d_instantiate_new()) & Thread-2 is doing
> +	 * cat of that symlink and falling here (via Ref-walk) while
> +	 * doing lookup_fast (one such case is when ->permission
> +	 * returns -ECHILD).
> +	 * Now if __d_set_inode_and_type() does out-of-order execution
> +	 * i.e. it first sets the dentry->d_flags & then dentry->inode
> +	 * then it can result into inode being NULL, causing panic later.
> +	 * Hence directly check if inode is NULL here.
> +	 */
> +	if (unlikely(d_really_is_negative(dentry))) {
>   		dput(dentry);
>   		return -ENOENT;
>   	}
> 

