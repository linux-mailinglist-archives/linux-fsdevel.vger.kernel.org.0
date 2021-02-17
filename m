Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DA031DEE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 19:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbhBQSMz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 13:12:55 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33916 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbhBQSMv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 13:12:51 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11HI4Z8M001220;
        Wed, 17 Feb 2021 18:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2020-01-29;
 bh=jlM5wl0wxhmeGu++9Bg6LFkLfQD4uPVeibBhySVZ4Bs=;
 b=iKi79n5yUvk9PsxOeFkeZbyWTvTEfdh3AHLx5E1l68DhaoycPzsskFPmL/Dl7tglP3Gk
 WzUfyYTFXXfnsG2VM+QKlQ+FhaBZrVc5lYN6cpmvRyhn3ilTD+Z04S2nOOB76it7vcpB
 FGKpVR+6fM7rDYaHZ3QozRWBQkXmWMMX0k4qHToyV6r+yJe0wwtMbsT6kmuy9C0o/haL
 KJumGY5qWB+uftqNV6TrhkhnY/w385sqMFltVpbKVeWw2QIg4CDWXlICCrwXhHgY6xSb
 erUsE3Sxi/YBaGttTk1GiFIKbkJhFpW8itBywrS9IGshqc79BgXfGEYhawypRTQfxFdr OQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36p49bbh3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Feb 2021 18:11:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11HIABI3164530;
        Wed, 17 Feb 2021 18:11:35 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by aserp3020.oracle.com with ESMTP id 36prp0hpsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Feb 2021 18:11:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrTiwKKeqDb7Uy0EoktLTFaFbpwPWDKQjVBkp/V6WfsgUvs3Sfe6Dh9vDCwUVYM1eRdPkZi7NnkdKIBDPMBv3CVhSRyS8tLMZs5J+H6QDNVWx0AItvxpi/tOlVp2J7iYJSu/3qPtRYnekLzU/FK2k9vWi4MSABZJYGvcZnZtoGPQp5rkLDrhyJ0tUfWF6p4bBB9SvKFhSqwr6kKgaqhrqTf/oMTgZfHSiSiSj/ZxqSBIgfctOvvYzkuKXSw02b/KdpRBe5du+KkNmRcmveAOAvyUliQh/gOZ8CifbaHwsurhnf2w2E34zHi7MjnlWpE0UYABUbOb9NSM+b235D/crQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlM5wl0wxhmeGu++9Bg6LFkLfQD4uPVeibBhySVZ4Bs=;
 b=X4K2DTl4blQnrWtA9sZo/mo0XfIJZZzshCnqtp4rj1ikweHQ1cEt2Vixo9MLMzxwcMpG9maHpW1zALhlMuJlNEZ0HPOsP+SlU0mFuDKguicGwXKhu6rhemM5LZ6LQemTKWPP48jv6JPSUMMfLMh28JerXCWYf4Ja+Oc1HXrafYYP8+rOoBMsZiqr3w9wF5T48sPgb8H+YO3SzlUcAF5ljvOqVh1gfrDyVocb5oIs/vXLbnC3s+MGeVi/jqy4oP4gZsCYL6+/JT7FmX1itx1Dngos9nTlaMqMdHNaEy1EMJVA1wTxDN+AOeIecLaAj40LY/OrgCj4SY0d5P8uxpjbeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlM5wl0wxhmeGu++9Bg6LFkLfQD4uPVeibBhySVZ4Bs=;
 b=C1MjbXCZ5YYAOTpLuDd/lC4duwzfq7+ZbUN4udd5QVBtAVLK0EvSKULtvZ7wJWw2Tac4oXFHiJ/IctXLvT3CllRSK3PAt30SHAr4hJtG+8O53Tu7sqeDtF5ZYmTGE8MrRBfNiN+e1nUsFJM7DZdEmdBhXIHOgESi3LHL1siXlkc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2823.namprd10.prod.outlook.com (2603:10b6:a03:87::15)
 by SJ0PR10MB4512.namprd10.prod.outlook.com (2603:10b6:a03:2dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.41; Wed, 17 Feb
 2021 18:11:33 +0000
Received: from BYAPR10MB2823.namprd10.prod.outlook.com
 ([fe80::adef:30b8:ee4e:c772]) by BYAPR10MB2823.namprd10.prod.outlook.com
 ([fe80::adef:30b8:ee4e:c772%3]) with mapi id 15.20.3846.042; Wed, 17 Feb 2021
 18:11:33 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH RESEND v5] proc: Allow pid_revalidate() during LOOKUP_RCU
In-Reply-To: <20210204171719.1021547-1-stephen.s.brennan@oracle.com>
References: <20210204171719.1021547-1-stephen.s.brennan@oracle.com>
Date:   Wed, 17 Feb 2021 10:11:30 -0800
Message-ID: <87eehe5zu5.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain
X-Originating-IP: [136.24.53.113]
X-ClientProxiedBy: SJ0PR13CA0228.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::23) To BYAPR10MB2823.namprd10.prod.outlook.com
 (2603:10b6:a03:87::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (136.24.53.113) by SJ0PR13CA0228.namprd13.prod.outlook.com (2603:10b6:a03:2c1::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.11 via Frontend Transport; Wed, 17 Feb 2021 18:11:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4599997e-e7b1-4687-eaa3-08d8d36f74c6
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4512:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB45124CFEC400EE9417334667DB869@SJ0PR10MB4512.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jlaEo4Ic2wh8WAr7NlWHWGl9Vcf99FFmeJh+TGaJXdScN2A67g5ysMw9dwO2T1yMcpEWfus2VBqYiSAIPsQhdz4W+UcDKlGBd4BPHRvnCnahyMlCfrBs2OBTFRg/D0ajokESmsMnWX9xPF7zOZfNk3wyo2EH/1uSXmFkxNsq8EOQoss1QBVpl9C5XFyEzKN0Gi4vVtnl8sYtWqZY/mU1MO0exwPr6MGkAP4hnuLVS4BZGCaystxJxdmGOfTNTXXYxk2stcMMGHpVA5Knewor/gSWJh4MlR3lIJ6jtPhr3+N0tq4V10b7f0vfVLq26SCsvm2c1ZAQ/3cZ6MT0QF/92sxJ5nIpUnmzrBKRpPXdsUxsRzwWRCv9KSWzk2WAIxvPG9SdvNX9Fi5DXLbN3LU59wsq9I/rVzW6W2URvLEsL9QusSsO+kN2Dfrx2PCXd6MBXOZXQNQ3vtRRXoSJmwvCguGQ2QP7dXdosnx1AJmnsvbpv1E0VNSjOVxwpbhKoJDyBIR7+dyPeg+cjNBnwLa+3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2823.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(396003)(346002)(136003)(39860400002)(478600001)(8936002)(186003)(6916009)(83380400001)(26005)(6496006)(316002)(52116002)(2906002)(8676002)(7416002)(4326008)(6486002)(5660300002)(956004)(16526019)(54906003)(86362001)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nkFjFJ2UGD4D4bkqOrK7/bwxrIWmEh0zL+XxuZpxihqhCBF0Ox86DMyMvd7L?=
 =?us-ascii?Q?akfuUqsXm+oclWFoK1ircHllWRNDCbZBLHJi+g9zmYjapSDYpSPBzvU2d+TO?=
 =?us-ascii?Q?qGwadj2cc8M+Xx2pw9iTGvtj0n9xwGUfsOXygwlaz3uIQKalFVGsz5RR3vO6?=
 =?us-ascii?Q?BMQhFvjrMu3lq5F74oS8XwSmZ7dbA+oKJvr2SlnBaSnJB0CJa3iaf2VuhtU5?=
 =?us-ascii?Q?T3b7NT7euV1cslSpWdmO9lZLE8yir8Z17ry3+Xu0yyyAkFB/apK8o482sGKb?=
 =?us-ascii?Q?k7+xL3YrCnwbpZwwWZSdotKDEGQoWJb684r70+h95K0CUxBx7MdUIZVSkWna?=
 =?us-ascii?Q?RYCt8XXrjOyxY3KAqOCwGHXaCrzffshYXlT+lFftN/mI2hidOz5wCeWtMx6T?=
 =?us-ascii?Q?7nJ1tpkQ8/y6kw0R0sdnpr1j1m+pqY3z4o1jf4SzJLtqVXsDs3ixBVcgeB52?=
 =?us-ascii?Q?f6sDT9gPjzjj/4VuSmMvqJqXQYEUhqv6mtHPBYppYkTFd6rms3JQisVqxvel?=
 =?us-ascii?Q?wwy5gVh8X+ykV1WJ/Sr6esavXqSIhwpfGDTnnHH5K2mPoZf6oOSnB++kMQcZ?=
 =?us-ascii?Q?V3Vm6Q55X1m81ezSsBcGbYrSvRwyQF71hgBsSgEnqbMa6RypwQpgHPRD3Fdj?=
 =?us-ascii?Q?6VvA+3H+goAOHzgV0V+4j6I8P5xOELpIJID6DvGyoer8XnP0XU7Mt6fATgkk?=
 =?us-ascii?Q?UgvwLYFpBj4x2o0XfUtBQOkSiiEmBbFq7L+K8uDPmDPiQPCgcoi3+ubi3T1w?=
 =?us-ascii?Q?ACkxaiZS78E/FIzdXbqvH6npB4ue8SsUXhZGmOS3tddLs+iSwuhZfvEYv3jg?=
 =?us-ascii?Q?NQZ6Q/Eb9+PClvdZ9Y/PuJlhvXig2ja/qzTc3un/0NVcVQoZIToAKTN1OBmp?=
 =?us-ascii?Q?xDOTFjTFVZf0XxeRIw1BB+qJY9BIVv2vbMniGSiHSwlpTRVeKuxd8K3wqMhI?=
 =?us-ascii?Q?1di4bZOiYqmmkogFura+ZKUWk3XQ2Cgkdm88dSdd6eUIkVTZOnH12Qk1p6tm?=
 =?us-ascii?Q?HA5q8B5uZvQ6ojh+f7cAzic728fSIdQvvBVO8c4qg6lNQp9MyK44AA0tDbkE?=
 =?us-ascii?Q?gUWBc9nO5YBKvUJysU5BTc831YVQd9iuqlAHVCiBcZm45KYAjC7llAxLZv0Y?=
 =?us-ascii?Q?F5LF8HedPHvki7srZ/QK/UfEq7nklJvdSxq8ERk4W29P+VEWIcjSJD7nPGUB?=
 =?us-ascii?Q?mCjzV/OWenF40lNp8+i8yKupfjykQN08KNF/mvkJ+eVyN0FE0NxMTe8mKJwA?=
 =?us-ascii?Q?fT6Q0E12G0XLOsFjUW/kGzsPxQaVLxOE9Ilu15saHdgFA9aVuICSV7Oh3P4i?=
 =?us-ascii?Q?7YsesfInW4CVV1uHFqHMLNur?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4599997e-e7b1-4687-eaa3-08d8d36f74c6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2823.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2021 18:11:33.0476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxmXgcknRPob0oABxJY2VcjEGHUjtE5+vbn0gbvlysv0A257wJmGu1Soa5+CvCieZL8qRdeOcp98+yzyVOzBS2kf/KEo++H91KA08oV839k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4512
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9898 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102170133
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9898 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1011 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102170132
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stephen Brennan <stephen.s.brennan@oracle.com> writes:

> The pid_revalidate() function drops from RCU into REF lookup mode. When
> many threads are resolving paths within /proc in parallel, this can
> result in heavy spinlock contention on d_lockref as each thread tries to
> grab a reference to the /proc dentry (and drop it shortly thereafter).
>
> Investigation indicates that it is not necessary to drop RCU in
> pid_revalidate(), as no RCU data is modified and the function never
> sleeps. So, remove the LOOKUP_RCU check.
>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---

Hello all,

I wanted to bring this patch to the surface again in case anyone has an
opportunity to review the changes.

Thank you,
Stephen

>
> When running running ~100 parallel instances of "TZ=/etc/localtime ps -fe
>>/dev/null" on a 100CPU machine, the %sys utilization reaches 90%, and perf
> shows the following code path as being responsible for heavy contention on
> the d_lockref spinlock:
>
>       walk_component()
>         lookup_fast()
>           d_revalidate()
>             pid_revalidate() // returns -ECHILD
>           unlazy_child()
>             lockref_get_not_dead(&nd->path.dentry->d_lockref) <-- contention
>
> By applying this patch, %sys utilization falls to around 60% under the same
> workload. Although this particular workload is a bit contrived, we have
> seen some monitoring scripts which produced similarly high %sys time due to
> this contention.
>
> As a result this patch, several procfs methods which were only called in
> ref-walk mode could now be called from RCU mode. To ensure that this patch
> is safe, I audited all the inode get_link and permission() implementations,
> as well as dentry d_revalidate() implementations, in fs/proc. These methods
> are called in the following ways:
>
> * get_link() receives a NULL dentry pointer when called in RCU mode.
> * permission() receives MAY_NOT_BLOCK in the mode parameter when called
>   from RCU.
> * d_revalidate() receives LOOKUP_RCU in flags.
>
> There were generally three groups I found. Group (1) are functions which
> contain a check at the top of the function and return -ECHILD, and so
> appear to be trivially RCU safe (although this is by dropping out of RCU
> completely). Group (2) are functions which have no explicit check, but
> on my audit, I was confident that there were no sleeping function calls,
> and thus were RCU safe as is. However, I would appreciate any additional
> review if possible. Group (3) are functions which might be be unsafe for some
> reason or another.
>
> Group (1):
>  proc_ns_get_link()
>  proc_pid_get_link()
>  map_files_d_revalidate()
>  proc_misc_d_revalidate()
>  tid_fd_revalidate()
>
> Group (2):
>  proc_get_link()
>  proc_self_get_link()
>  proc_thread_self_get_link()
>  proc_fd_permission()
>
> Group (3):
>  pid_revalidate()            -- addressed by my patch
>  proc_pid_permission()       -- addressed by commits by Al
>  proc_map_files_get_link()   -- calls capable() which could audit
>
> I believe proc_map_files_get_link() is safe despite calling into the audit
> framework, however I'm not confident and so I did not include it in Group 2.
> proc_pid_permission() calls into the audit code, and is not safe with
> LSM_AUDIT_DATA_DENTRY or LSM_AUDIT_DATA_INODE. Al's commits[1] address
> these issues. This patch is tested and stable on the workload described
> at the beginning of this cover letter, on a system with selinux enabled.
>
> [1]: 23d8f5b684fc ("make dump_common_audit_data() safe to be called from
>      RCU pathwalk") and 2 previous
>
> Changes in v5:
> - Al's commits are now in linux-next, resolving proc_pid_permission() issue.
> - Add NULL check after d_inode_rcu(dentry), because inode may become NULL if
>   we do not hold a reference.
> Changes in v4:
> - Simplify by unconditionally calling pid_update_inode() from pid_revalidate,
>   and removing the LOOKUP_RCU check.
> Changes in v3:
> - Rather than call pid_update_inode() with flags, create
>   proc_inode_needs_update() to determine whether the call can be skipped.
> - Restore the call to the security hook (see next patch).
> Changes in v2:
> - Remove get_pid_task_rcu_user() and get_proc_task_rcu(), since they were
>   unnecessary.
> - Remove the call to security_task_to_inode().
>
>  fs/proc/base.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index ebea9501afb8..3e105bd05801 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1830,19 +1830,21 @@ static int pid_revalidate(struct dentry *dentry, unsigned int flags)
>  {
>  	struct inode *inode;
>  	struct task_struct *task;
> +	int ret = 0;
>  
> -	if (flags & LOOKUP_RCU)
> -		return -ECHILD;
> -
> -	inode = d_inode(dentry);
> -	task = get_proc_task(inode);
> +	rcu_read_lock();
> +	inode = d_inode_rcu(dentry);
> +	if (!inode)
> +		goto out;
> +	task = pid_task(proc_pid(inode), PIDTYPE_PID);
>  
>  	if (task) {
>  		pid_update_inode(task, inode);
> -		put_task_struct(task);
> -		return 1;
> +		ret = 1;
>  	}
> -	return 0;
> +out:
> +	rcu_read_unlock();
> +	return ret;
>  }
>  
>  static inline bool proc_inode_is_dead(struct inode *inode)
> -- 
> 2.27.0
