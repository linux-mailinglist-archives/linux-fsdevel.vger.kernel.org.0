Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2F02C1191
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 18:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390287AbgKWRGu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 12:06:50 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47840 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390244AbgKWRGr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 12:06:47 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0ANGvxIH003137;
        Mon, 23 Nov 2020 09:06:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=mPb6ocPIFcQwDgYKsPKvOx7kfpecyfn1LYwhryy0KV0=;
 b=Dx2MePtDNOd6ttjCrk/8EvkLzrYysp86lUHOMQYNssOlgfjMo59zk1DBfzWrqbIpx7Bu
 fQmrS7SZo+J9kcqn3nJ2E4UVHqr34tLvgiEvfSCTqpkfG6jsc9hpEwa3OLnTyo0F6T7v
 4nu8DP9tb5yydRIC8dfEBAHgTMjdrslVhCg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 34yx1susyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 23 Nov 2020 09:06:11 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 23 Nov 2020 09:06:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fcc+9kZntS9pIFXzPY1ibni2DKQi5wKIwt1+lJXz5JT2RqgG5ImAEYuFyl729Dbzz4iJm/f03tgWsRevBeJF5mLsX43MqgloKiArJeetfC6F7DPPLCIeMxhvPLJMCdAm3+qgy0mNQJH9wMignt+gw7VFvjDSkqbVZ1SFWQxT6M5g6o1PDapEvCMnMnfwiv9rIzrXw9SprD35sfvmRxt2uv8rbduc4UCAfEk2JThJu3Ql8mZO9ARw6w7N3x5I/2k/amtYXUK9qo8DtVHnH2CB/VGBY+MI+5IfzDqrhokfbMfbtpHypAMJiRqFGiEg/r3AbIO4tqpvpbnFk7LeJgfjFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPb6ocPIFcQwDgYKsPKvOx7kfpecyfn1LYwhryy0KV0=;
 b=k2cJCNJzhV3hcjXBedORd739GOWlaECvnXhffAO8pa6C+cBFnEfJ5MdFh4umCUILauGHLlsj4Uw2PHWFOHa151jvckZrRMO+R6+0J8gMd4xr8++lWeEeCerO21eGb10RPC4n53Awjc/sicnZDCHmgsf5amL8RWEH6gxHZtawJHKZG0/nvbHWGfsMXQgJLlmUVi3fTxCgNEoUPzjq2cG9DdhTY0SxpTsoTJabrc1hVewNVZluQtK8KTXuwuAZ+WCQJ79IjR/fcqcjdnPdy0wgk2HJPSNU6cnmFbcTRV9Inh/f3EJw9MAI3JXZEriLqv8Bf6RoW4D0n5NHK41RTSX3Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPb6ocPIFcQwDgYKsPKvOx7kfpecyfn1LYwhryy0KV0=;
 b=R1adnmswtKKh2O1SGaUtu1hGqZ3IhgNJMqdGfnNb5bokW8XQpGprJ5oIvOhnbAIXmVMKeGTz2Ch4gfcFQfTyP0C70dzX1xnF7U/aRUl1tVFWXYaWoUSmKsQCAJ7syk4zhQF+rzT5h+Vc4HXw1op45wstHJvXCeqFJiR0K98uhTc=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3413.namprd15.prod.outlook.com (2603:10b6:a03:10b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Mon, 23 Nov
 2020 17:06:08 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3589.029; Mon, 23 Nov 2020
 17:06:08 +0000
Subject: Re: [PATCH v2 16/24] bpf/task_iter: In task_file_seq_get_next use
 task_lookup_next_fd_rcu
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <criu@openvz.org>,
        <bpf@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
 <20201120231441.29911-16-ebiederm@xmission.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <56b3900d-652b-64d8-b2a4-8cd862c17b8f@fb.com>
Date:   Mon, 23 Nov 2020 09:06:03 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
In-Reply-To: <20201120231441.29911-16-ebiederm@xmission.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:fc96]
X-ClientProxiedBy: MWHPR22CA0051.namprd22.prod.outlook.com
 (2603:10b6:300:12a::13) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::1039] (2620:10d:c090:400::5:fc96) by MWHPR22CA0051.namprd22.prod.outlook.com (2603:10b6:300:12a::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Mon, 23 Nov 2020 17:06:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d54d76c7-9609-4049-a2f1-08d88fd211b9
X-MS-TrafficTypeDiagnostic: BYAPR15MB3413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB34133A5B16867068395F8D65D3FC0@BYAPR15MB3413.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 70rGF8XsyZ5gglrpZnTe3WPNKHG+LtfYQCf0kUlTDlAZxuBaGf0yGQ3NIjymOEgsCV8dOceiOsMP2AGUJOkUOKXeupmxo6/fcrFblCblKlXqvr2GA0oa/uIS2UsliiwzR52hvEuYeBxd1enXt7JVDkzQe8FccUxYdC7gtCmiuqsRT36jHdRG4sVb6jg2hg0EySzK987pmG5a8c7gb2kqIbVnE0SVtljcY+gXknJPPTcpZ13uK9faPEPksIIFrQPi1I0mb4vit6m33mdNdusUz4S9x8X1HyQATQPcIcuC8VMcV5UsN+Ao+59fDlRsk40dZAK3LZG/Xea4rMDpHEFSIiz+OBEb74BuUaQM5nA631MfIvr3rm+oDiZyIgJYMjq0n/lIK6A4yCRflDVhqPxU5PqphW6NHdW6ukXHoxbxD12dkWtLefnY1yR/t1lvUeI3vv0C9FVHMNVt4Mv/uqXy5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(136003)(396003)(366004)(478600001)(52116002)(31686004)(31696002)(83380400001)(316002)(8936002)(966005)(4326008)(54906003)(8676002)(5660300002)(86362001)(186003)(2616005)(2906002)(7416002)(16526019)(36756003)(6666004)(66946007)(53546011)(6486002)(66476007)(66556008)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: NV56nBWEbMJrbYcq17jRrTSBKMIH3LgETq5FYKn2myGSsVmT/dlMZKp0SfH3HYhLi7yo+afyxLWdoc4fcHB8j0aVraumOIM2BEiqWvqOgTsBJ/tuEPg7NejDtXl/12Rj/2pYZPfLY8RsAFWRQcXhJ2WPodxE2zi9sTL1o8c2+BkV629OZqOli8lIZ/9veHfgtz7sqI6MdPGZePqSmqgeauVx0eZ/CDzemHTyYWoQ9GPqUrRTb7bsW0dOe2qYmQGS16v0TIRFBGbM88P307/z2qMS2fgzspjGcQRyiCjzHjg2+pjXD2BKRARiMS0aTuqVqVh5Viw+I0jQbLerqxxlormmClO2NkozwccjA/0U+7S9cqTN/ZP085ea79cfZq1PaHCDPjH8a+ogNv05DZerOKWRoWNeoVTfTdLw7Pht1SjiqNqIq2vVAh6EO3K8mi+N2S1VQB05i7CvjMY3yVfE32ciTaahHnqGUAPt1ZvNzPbfEdR26fYipgeY2FTKVhvjr1ml1CqKfwx64TG1P0Aif/kYEfr0/XCXOU5rCEH4b56ci/H10MaVjF1iuhHAcGwt3SlQkrFD+9HVanEXv61d696yHZYoZoE1PFSybkDHz9891zFDLWXBie0KTgiWw358TxLBSQPnrdG+RZYjWpVlcd18nOj0RN4l2/FR5N92cLm+kr0vrJLVTT87R2svoYpvRouC5HlUiK/WHwpmUDSVAe/vfa3d5dCI61IJIKrZiP1ueKu3U3QrlSBgP1lW+BgZ2YAonKqKoIbyQMmH1gwOoz/TfFIMs6vmTNKpiP+IPLlOktd3PPgQkyoDMZX/SK58QGunAKPnOX39nqHWwyhZMaOw/LlNSYpbIYkJ7vab1VXSb+5mz8pHv08akkBz+DLPW4ZF+xQU14gb1rvkBCTG8czBaE6BAb1rsDEGPiaajbQ=
X-MS-Exchange-CrossTenant-Network-Message-Id: d54d76c7-9609-4049-a2f1-08d88fd211b9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2020 17:06:07.9625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYsHXB2s5TdgyVGYS0oY8TG89cOn9IdD2wsyysWixtv5oxKqi+cWLC7Jo7Z/6RrP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3413
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-23_14:2020-11-23,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011230114
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 11/20/20 3:14 PM, Eric W. Biederman wrote:
> When discussing[1] exec and posix file locks it was realized that none
> of the callers of get_files_struct fundamentally needed to call
> get_files_struct, and that by switching them to helper functions
> instead it will both simplify their code and remove unnecessary
> increments of files_struct.count.  Those unnecessary increments can
> result in exec unnecessarily unsharing files_struct which breaking
> posix locks, and it can result in fget_light having to fallback to
> fget reducing system performance.
> 
> Using task_lookup_next_fd_rcu simplifies task_file_seq_get_next, by
> moving the checking for the maximum file descritor into the generic
> code, and by remvoing the need for capturing and releasing a reference
> on files_struct.  As the reference count of files_struct no longer
> needs to be maintained bpf_iter_seq_task_file_info can have it's files
> member removed and task_file_seq_get_next no longer needs it's fstruct
> argument.
> 
> The curr_fd local variable does need to become unsigned to be used
> with fnext_task.  As curr_fd is assigned from and assigned a u32
> making curr_fd an unsigned int won't cause problems and might prevent
> them.
> 
> [1] https://lkml.kernel.org/r/20180915160423.GA31461@redhat.com
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> v1: https://lkml.kernel.org/r/20200817220425.9389-11-ebiederm@xmission.com
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>   kernel/bpf/task_iter.c | 44 ++++++++++--------------------------------
>   1 file changed, 10 insertions(+), 34 deletions(-)


Just a heads-up. The following patch
   bpf-next: 91b2db27d3ff ("bpf: Simplify task_file_seq_get_next()")
 
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=91b2db27d3ff9ad29e8b3108dfbf1e2f49fe9bd3
has been merged in bpf-next tree.

It will have merge conflicts with this patch. The above patch
is a refactoring for simplification with no functionality change.

> 
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 5ab2ccfb96cb..4ec63170c741 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -130,45 +130,33 @@ struct bpf_iter_seq_task_file_info {
>   	 */
>   	struct bpf_iter_seq_task_common common;
>   	struct task_struct *task;
> -	struct files_struct *files;
>   	u32 tid;
>   	u32 fd;
>   };
>   
>   static struct file *
>   task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info,
> -		       struct task_struct **task, struct files_struct **fstruct)
> +		       struct task_struct **task)
>   {
>   	struct pid_namespace *ns = info->common.ns;
> -	u32 curr_tid = info->tid, max_fds;
> -	struct files_struct *curr_files;
> +	u32 curr_tid = info->tid;
>   	struct task_struct *curr_task;
> -	int curr_fd = info->fd;
> +	unsigned int curr_fd = info->fd;
>   
>   	/* If this function returns a non-NULL file object,
> -	 * it held a reference to the task/files_struct/file.
> +	 * it held a reference to the task/file.
>   	 * Otherwise, it does not hold any reference.
>   	 */
>   again:
>   	if (*task) {
>   		curr_task = *task;
> -		curr_files = *fstruct;
>   		curr_fd = info->fd;
>   	} else {
>   		curr_task = task_seq_get_next(ns, &curr_tid, true);
>   		if (!curr_task)
>   			return NULL;
>   
> -		curr_files = get_files_struct(curr_task);
> -		if (!curr_files) {
> -			put_task_struct(curr_task);
> -			curr_tid = ++(info->tid);
> -			info->fd = 0;
> -			goto again;
> -		}
> -
> -		/* set *fstruct, *task and info->tid */
> -		*fstruct = curr_files;
> +		/* set *task and info->tid */
>   		*task = curr_task;
>   		if (curr_tid == info->tid) {
>   			curr_fd = info->fd;
> @@ -179,13 +167,11 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info,
>   	}
>   
>   	rcu_read_lock();
> -	max_fds = files_fdtable(curr_files)->max_fds;
> -	for (; curr_fd < max_fds; curr_fd++) {
> +	for (;; curr_fd++) {
>   		struct file *f;
> -
> -		f = files_lookup_fd_rcu(curr_files, curr_fd);
> +		f = task_lookup_next_fd_rcu(curr_task, &curr_fd);
>   		if (!f)
> -			continue;
> +			break;
>   		if (!get_file_rcu(f))
>   			continue;
>   
> @@ -197,10 +183,8 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info,
>   
>   	/* the current task is done, go to the next task */
>   	rcu_read_unlock();
> -	put_files_struct(curr_files);
>   	put_task_struct(curr_task);
>   	*task = NULL;
> -	*fstruct = NULL;
>   	info->fd = 0;
>   	curr_tid = ++(info->tid);
>   	goto again;
> @@ -209,13 +193,11 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info,
>   static void *task_file_seq_start(struct seq_file *seq, loff_t *pos)
>   {
>   	struct bpf_iter_seq_task_file_info *info = seq->private;
> -	struct files_struct *files = NULL;
>   	struct task_struct *task = NULL;
>   	struct file *file;
>   
> -	file = task_file_seq_get_next(info, &task, &files);
> +	file = task_file_seq_get_next(info, &task);
>   	if (!file) {
> -		info->files = NULL;
>   		info->task = NULL;
>   		return NULL;
>   	}
> @@ -223,7 +205,6 @@ static void *task_file_seq_start(struct seq_file *seq, loff_t *pos)
>   	if (*pos == 0)
>   		++*pos;
>   	info->task = task;
> -	info->files = files;
>   
>   	return file;
>   }
> @@ -231,22 +212,19 @@ static void *task_file_seq_start(struct seq_file *seq, loff_t *pos)
>   static void *task_file_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>   {
>   	struct bpf_iter_seq_task_file_info *info = seq->private;
> -	struct files_struct *files = info->files;
>   	struct task_struct *task = info->task;
>   	struct file *file;
>   
>   	++*pos;
>   	++info->fd;
>   	fput((struct file *)v);
> -	file = task_file_seq_get_next(info, &task, &files);
> +	file = task_file_seq_get_next(info, &task);
>   	if (!file) {
> -		info->files = NULL;
>   		info->task = NULL;
>   		return NULL;
>   	}
>   
>   	info->task = task;
> -	info->files = files;
>   
>   	return file;
>   }
> @@ -295,9 +273,7 @@ static void task_file_seq_stop(struct seq_file *seq, void *v)
>   		(void)__task_file_seq_show(seq, v, true);
>   	} else {
>   		fput((struct file *)v);
> -		put_files_struct(info->files);
>   		put_task_struct(info->task);
> -		info->files = NULL;
>   		info->task = NULL;
>   	}
>   }
> 
