Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623C4307651
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 13:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbhA1Mpe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 07:45:34 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59886 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbhA1Mpc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 07:45:32 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SCYAiu192248;
        Thu, 28 Jan 2021 12:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=4s6f1Z4X6xFsF2Ee1gAGevBW8HhU6VhaeckNt9jWQHc=;
 b=kX6Rlr0au8sY4I6yUJwn2LXmhSeVCZE3jKgLuqO1QhpGfaIM4g2+Ig07nc+VWL7SzJVg
 Bj72iFAcU9Za8alm5F6IopQUt9S9FRLVjgKOzpkdupcC+hpfJjJHBLB/bmz88hbIhmKm
 R5V6ChjnvtAW/+gc2yOzLGfoJTVsrsbY+kr8JgLDbWqNF4+R6cbKMt3a3s7X48K4271x
 CDkPKyy97rdwx0sWjQDA2+7KudY+HrQldnAORaUtHWSSe5HKI9gYe3WuYasENMKo4H26
 YZHYf/IJQe1vowSGdXaismmdrzSvukfzxgZgsVxZUPtuzVPDomuh8lDLOEXGRn0omBFg Fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 368b7r3xs7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 12:43:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SCbobd047153;
        Thu, 28 Jan 2021 12:43:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3030.oracle.com with ESMTP id 368wcqmysx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 12:43:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKa1PHQx+4vPhBbaBxaJjVKGURsFjvvn2W6lC/iFdn9bkxeVzsvtftX1xuRA2u84IGmDemjkbsOwoFCwOvg9NKLHBcEzufwP4kH1tdGx+H9eQX62kkQICCwZp9KJr5vKd1yHCr3APlfB1zM2KLBJ03e+r9Vcf7FZypAoO/lXq1OSRCFA/4kvSijmF2tXHX7Zyj1YSIdRqMhnZEekXkq3qsHnU8jRHsFVM9RqQz2AjXAmdLnbA11IsEL7gMZs/9lPCj/aPVW20Y+pji7OPD41ujvylPOxbe1JX1m4boJpM9Qvhr0FETkYNwB3/eepMUZflx48FJ6UX1cwUPN+utuiTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4s6f1Z4X6xFsF2Ee1gAGevBW8HhU6VhaeckNt9jWQHc=;
 b=eye7cqB5+rQXahNo3YEXGO/r0wrAgfNmXyOfChG/HMWPvXF4nqWaeLetDNEHYAxEXke5tVmaQzJLisX8as5R65JK8SE0agPGBN38fiNX9bnfY0FmIsuTW7JnCvs4NLUHTz4zsQFevpAPO9l4+CZ0HZSS6wMOpxU8UU37D5536AznjCYNCpXpR7CRgQ7P1FTShRVo+ukLXm6LHKuKOsIFFW1d/9QiJEwOwwfMQKtjySz3EAOsroLmoDCYVZCrSOhEK0RKD57Il4yxnwNpBrArsGxShbQZIPXT4nuL6SUxgqHJRGqLZZqKXAigJ8degYRY8pPhfRMTK9tUQH5hPL9MkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4s6f1Z4X6xFsF2Ee1gAGevBW8HhU6VhaeckNt9jWQHc=;
 b=Mr0nOt0UdZbc4cbI+3mzml8n5Q2KLA4MNetq2+yWthAXAn2HGggfFVZFDPIA5a75lWpBuhsz6jb+7Hv4R+QLC6SnfehG7z67W5eJYq42XFUyMZ/Wqub2sQs6r+KdZ2HwpgSqYLe4paKq0Af/xnNbc+FBBI7IKZugdF6TcuEkdt4=
Authentication-Results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=oracle.com;
Received: from CH2PR10MB4118.namprd10.prod.outlook.com (2603:10b6:610:a4::8)
 by CH2PR10MB3941.namprd10.prod.outlook.com (2603:10b6:610:4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Thu, 28 Jan
 2021 12:43:11 +0000
Received: from CH2PR10MB4118.namprd10.prod.outlook.com
 ([fe80::2cd3:dc36:f8d4:ea2a]) by CH2PR10MB4118.namprd10.prod.outlook.com
 ([fe80::2cd3:dc36:f8d4:ea2a%8]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 12:43:11 +0000
Subject: Re: [RFC PATCH 19/34] fs/jfs/jfs_logmgr.c: use bio_new in lbmRead
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
        xen-devel@lists.xenproject.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, linux-pm@vger.kernel.org,
        linux-mm@kvack.org
Cc:     axboe@kernel.dk, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, konrad.wilk@oracle.com,
        roger.pau@citrix.com, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, agk@redhat.com,
        snitzer@redhat.com, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, viro@zeniv.linux.org.uk, tytso@mit.edu,
        jaegeuk@kernel.org, ebiggers@kernel.org, djwong@kernel.org,
        shaggy@kernel.org, konishi.ryusuke@gmail.com, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        damien.lemoal@wdc.com, naohiro.aota@wdc.com, jth@kernel.org,
        rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        akpm@linux-foundation.org, hare@suse.de, gustavoars@kernel.org,
        tiwai@suse.de, alex.shi@linux.alibaba.com, asml.silence@gmail.com,
        ming.lei@redhat.com, tj@kernel.org, osandov@fb.com,
        bvanassche@acm.org, jefflexu@linux.alibaba.com
References: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
 <20210128071133.60335-20-chaitanya.kulkarni@wdc.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Message-ID: <8d3f7e70-1c7a-567a-0e60-97bac846bf13@oracle.com>
Date:   Thu, 28 Jan 2021 06:43:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210128071133.60335-20-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [68.201.65.98]
X-ClientProxiedBy: SN4PR0501CA0077.namprd05.prod.outlook.com
 (2603:10b6:803:22::15) To CH2PR10MB4118.namprd10.prod.outlook.com
 (2603:10b6:610:a4::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.190] (68.201.65.98) by SN4PR0501CA0077.namprd05.prod.outlook.com (2603:10b6:803:22::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.8 via Frontend Transport; Thu, 28 Jan 2021 12:43:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e01d42d-3bc2-4bab-28da-08d8c38a4555
X-MS-TrafficTypeDiagnostic: CH2PR10MB3941:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB39411E0FD376FAA86E74219987BA9@CH2PR10MB3941.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:260;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pJ5ccHGdfMIuYnzx8aq0wBe7CGK5hELGkFwmW+UbSGKkOVpfgd4YBi0vrc+er51UtFKESCZAyt1Tp5H5X6cEG9b1EeQrBf4RSEyzl3baouUCAYXgXHVFR0/RrNoIj7y0HIIMRk7rAHMY0vw04eZ0KN1Rg0nSmRbIXxfIzHm/+llfg5vXr7mz+bpOE+7sfq/1lFfhHLxDCXXWejvvBjnCeOxXqgBDiOXdG5T5s0+D4oxdxJZFuttUOavuECY7bCePtreJrvjchJOPXhU1BoOiRU4gVcpEp8gkj+VeGWMkfFRlm0cCmZbfS3BfDuXDIT7v3vdL8Q9W39+CtghNyBZ4KaMGtxayQFhOQ6Po0F1ZVyaiiuZ85rlA4rjv24EJRBq6/z02CElTZrxJeLOHNl1EFko6t5wnFfQCXczxRrfrpdXumXasRKoJ/+16Gw0rrPZY85eRY7PEoxjxU7PLkD4+F17RBlIaAnKfg+aLMDxGkkoSN9BOBtMlkavxKTCf8ofiLHhjadTYZo2E3Uz0awpIg+XtnZwMJu+yQJg5YabAYiD3ogLMFP/9xSg9wyCqCxIWb2px3qKIgj4zJ8SqXI+ievvKAKlegmf0tVnNgoQvfibMDk1NTpx5Py49FzNeNngt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4118.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(39860400002)(366004)(376002)(7366002)(6486002)(36756003)(2616005)(66556008)(83380400001)(2906002)(921005)(16526019)(5660300002)(8676002)(66476007)(7406005)(478600001)(7416002)(86362001)(186003)(6666004)(316002)(16576012)(31696002)(66946007)(8936002)(53546011)(956004)(4326008)(26005)(31686004)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Vm4rTktBWm5uc09iM3FnVVBkdjNUVHBpdWs5Q0ZDTkk5R0E3ODRnYUZMMktU?=
 =?utf-8?B?RG56Y1hFZjFxaXJGM1N2TnlIN0ZCOFJCa2FKYmpJMEZDTGJIcU81MkkvWUN5?=
 =?utf-8?B?TFd0TUV5cERHM1RvKytObUVJd0NXSmpZa1NRZk5iRGhldTRMSlVvajhDTlhR?=
 =?utf-8?B?T0txelh4S3RUTDRrN20rSjFIZzBwdk1OOFRtMHBOUTdjMUhHby9mcWVJWFBm?=
 =?utf-8?B?bndkYzh1dWM1NVZXRk9pTEFmbG9Mcnl2N1h1YzhDVTVSdWdjczNKMFk1LzM5?=
 =?utf-8?B?STBkVWthUEIzamRkOTlvS0xNUHdFNFhkbVRxQXEvKzdEODZhdmlMSDRjbU9T?=
 =?utf-8?B?aENkbks2SEo1ZzNJanV3Z2pHVW1pUFF6eXdlRVkyTVBrRE42a2FjbWIwWkpl?=
 =?utf-8?B?TDdURFBoVFVSMnh4U0VLcjFTTUJrM2JXbXBSY3J3T3pQb3E0eHFTSWdZcXNX?=
 =?utf-8?B?cm9INjZLZG9QQ0dJR2JXZS9LNUtGeVZhTDlmTXV3SHVlczBrbldTWHFGdjhI?=
 =?utf-8?B?YlFTR2pCalVGQWo0aTUxblpoR1h3RjZKd3J3R2FCZDlNc0RVSUdtUFMyODht?=
 =?utf-8?B?Qi9pd1NrdlJoL243S2U1eUsyVEtJZ3FYckRmMFRmUllPcW1leFZnSnVEY2R3?=
 =?utf-8?B?Z2hDdUx4R3FyRjJqVEZ2WkRBWWJOdy9iY3JsUXFtSzhBYmhOZlp1MEZmMW1J?=
 =?utf-8?B?RU1udXJkREFRS0lFMUU0dlNRazZ4Vmw5UGlrTnExV3RKdzBodnZseFFKQTVz?=
 =?utf-8?B?Uy9FdkhyUjJtVU85aklWcXkzd0g4a0FMYllNR01TUFl5dkQ3ZkpJdUJDMksx?=
 =?utf-8?B?VjMvUWVUVnFpNzd0ZE1PZEtMaElncUlFYjYvNFBQZ3hVeXBrVDNVOXhORTA3?=
 =?utf-8?B?azNUa1FVUXZzTXZxQWIxeXUvdjlvbHRrR3ZTbEpwRUZpOVc5ZUZvWWVjWGFM?=
 =?utf-8?B?dGh5MTFxYVdobnA3dDZtckhsallCWHU1SXBwYkxXNHFNb2dLR3BMQ3BEWEFt?=
 =?utf-8?B?K2tRNnZ0eU9EZHF3TmVycGZzY0RSWHJibHlOcnYvamJCZEZmSzk0cnN1NXRR?=
 =?utf-8?B?RjBrd0I1eGVTSWlUb3RPbjNVUnhLMGxqeko1Vk41emRZMWxjRlZmNE5yRkxD?=
 =?utf-8?B?Ri9ITS8vQ3c4dDVYbnlHbU8zU0RqS09wK0NXaFRaWnkxd3JDL2thTSttS1lv?=
 =?utf-8?B?VnR3MlVIdjRlSy85QTdCS1FhekYvbnZyTjZlZTJtcU85NmtER3o5S0RDV3JL?=
 =?utf-8?B?cTJiTEFPUlJDWksyeS81NzVueSt5QmdieUYwVHd2bGRZZzdUYlB4QzhLNUtQ?=
 =?utf-8?B?Rjk0eGVMVGV0aFF4WS8zUG8xbGQ2NG9jUzZzbWNYTXBvRTZsUDVRSTV5ZXB6?=
 =?utf-8?B?VTRKOTgvaTZIb0dDR2pPQzNnM3V6Z3kvMUd3azhpYnRoTFdhbEg0N2hlb21t?=
 =?utf-8?Q?xgW5/je/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e01d42d-3bc2-4bab-28da-08d8c38a4555
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4118.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 12:43:11.2780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFBedDYhghl7XP3cZN2/McX0JwxYw4Cu7FZ5NDxZqDAklfqhu0dMXnszrFIG3H4zPpJnTe1yGk1iM6Mt6c63XUXi/NVyG5gbxkRVEUnPYnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3941
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280064
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 clxscore=1011 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280064
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

You probably don't need 4 patches to fs/jfs/. These can be combined into 
a single patch.

Dave

On 1/28/21 1:11 AM, Chaitanya Kulkarni wrote:
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>   fs/jfs/jfs_logmgr.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
> index 9330eff210e0..4481f3e33a3f 100644
> --- a/fs/jfs/jfs_logmgr.c
> +++ b/fs/jfs/jfs_logmgr.c
> @@ -1979,17 +1979,14 @@ static int lbmRead(struct jfs_log * log, int pn, struct lbuf ** bpp)
>   
>   	bp->l_flag |= lbmREAD;
>   
> -	bio = bio_alloc(GFP_NOFS, 1);
> -
> -	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
> -	bio_set_dev(bio, log->bdev);
> +	bio = bio_new(log->bdev, bp->l_blkno << (log->l2bsize - 9),
> +			REQ_OP_READ, 0, 1, GFP_NOFS);
>   
>   	bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
>   	BUG_ON(bio->bi_iter.bi_size != LOGPSIZE);
>   
>   	bio->bi_end_io = lbmIODone;
>   	bio->bi_private = bp;
> -	bio->bi_opf = REQ_OP_READ;
>   	/*check if journaling to disk has been disabled*/
>   	if (log->no_integrity) {
>   		bio->bi_iter.bi_size = 0;
> 
