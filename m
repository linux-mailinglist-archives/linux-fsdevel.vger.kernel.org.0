Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE78375CD5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 23:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhEFV2w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 May 2021 17:28:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57532 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhEFV2w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 May 2021 17:28:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 146LFQ8f132085;
        Thu, 6 May 2021 21:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=QKPUXqRmz/kH3sIr7LnMG8Tnfe4rEfk4I8EFvyouqeo=;
 b=HUFPct/xuhesy3xPf+vtFBq8D0vDoS9aj7EMucAh1Pa3midRc7GgE4ljfjsLoV6zhZHj
 owYpvhRUPS0O8d3cPG1uu+HO9vI4mg+hRGPMfZcjEHoM9x/s4vDbmvUxFj1RcakyAtIy
 wiRu+tf/vwwC+VkQuSQn4nC0VeQlW7MipY99yh6u2fxhg+BDcFV86zApKh9Ejp4wJWKP
 rcrL15KnpQKgMuuDwwe0e1uyCK4tfCcyaj8KGIfk0J9bU09l8euYTiXmxylye9d09idD
 lb4qZRUqt9oHiIJ/7wtx7csJ7f5LoqRsO96I9Y2BqIAKcofUr7RrjDfVIRzo246EJXiB wA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 38bebc6ch4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 May 2021 21:27:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 146LBKxr121155;
        Thu, 6 May 2021 21:27:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by userp3030.oracle.com with ESMTP id 38bebvy5q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 May 2021 21:27:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8g+r2zufUaGTakhCbj6D14IzrI8b/GBYkYpgTGuY/YaTP48r9RvDzeEN17A8fiy8F22O86ITdxTyz57i+HEk6CCWWSKWz8l2Qp1iYinlZelPtyGI0zQ/JOUJOYRlxCb8LPF1+GFWvANJw8ahJxGW4Tvhkt6jLOvhuHi/BYxxBUigmATpABWwJumUPkOuRJXk1dk0qz1vC0F9rrPCuFHqRQm1mb+Wh44qrcTO1IELSLxpAhVx8ROr/kyhHKLXUROuk1x/AlrVlRytSEZLjm0n8jtKHA5IiPmaKPjFSWbVsIPV8nGlIMD2xKV5X5GAgMG1egusFep2IFeD4Ub3pUgwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKPUXqRmz/kH3sIr7LnMG8Tnfe4rEfk4I8EFvyouqeo=;
 b=hRZkOSuBxF1eqTZZko5yrpYqL+dfKKpZ/kyv3Yai8FnIP99+Z1yDMHWfKN7/0JRQ9QfYdgNNuytRfCN7y/7z3qL8aoCmsE8y0lIicQejWzwJ00lpkjVA/zGVMJV1nHEMCeET7DVLOdSC6+54+QGM4pqZK+JBynbRxjOeR/wgp38OJrpiaiEPAxvRAFp0D57gRZeS/y4Hu+2XJPH50eM8zIouC5gIcCcVYNn0ZgYgoY/0JcZwzA8go7G4k4D+K2keVQZfjzeKfl64IgAeWD566tb6R3K1+gH1ksmK6DkJNyoCNChGBWlkZVyjs450/pL9bOdfq6ZxPK2pq4bnOB30qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKPUXqRmz/kH3sIr7LnMG8Tnfe4rEfk4I8EFvyouqeo=;
 b=ffD35JJDOy7MUMWiXf6OPPx2LCiNKjmJIHehKUDwE2OZxh2sqRSVeXemNfVdbYh2roVUDW0TlmlC+8IrBV42yDC1H5GPu6S3SpyuRzf4pjMcbUV1Ew3/ajeuoBgZSnfHoP3CyGfprxEmgFSxywSiPRAq6uPoG/uwRnghx+QWgxI=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by BN6PR10MB1905.namprd10.prod.outlook.com (2603:10b6:404:ff::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Thu, 6 May
 2021 21:27:26 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::ac47:290b:59d6:f20e]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::ac47:290b:59d6:f20e%4]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 21:27:26 +0000
Subject: Re: [PATCH v3] mm/compaction:let proactive compaction order
 configurable
To:     David Rientjes <rientjes@google.com>,
        chukaiping <chukaiping@baidu.com>
Cc:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, vbabka@suse.cz, nigupta@nvidia.com,
        bhe@redhat.com, iamjoonsoo.kim@lge.com, mateusznosek0@gmail.com,
        sh_def@163.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <1619313662-30356-1-git-send-email-chukaiping@baidu.com>
 <f941268c-b91-594b-5de3-05fc418fbd0@google.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Message-ID: <2f21dec9-065f-e234-f531-c6643965c0cb@oracle.com>
Date:   Thu, 6 May 2021 17:27:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <f941268c-b91-594b-5de3-05fc418fbd0@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [138.3.200.47]
X-ClientProxiedBy: BY5PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::22) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.154.183.111] (138.3.200.47) by BY5PR03CA0012.namprd03.prod.outlook.com (2603:10b6:a03:1e0::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 6 May 2021 21:27:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08145e2c-c9ce-4f44-8f6f-08d910d5beb4
X-MS-TrafficTypeDiagnostic: BN6PR10MB1905:
X-Microsoft-Antispam-PRVS: <BN6PR10MB1905F973E5DC678ABA864CDF86589@BN6PR10MB1905.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LeHX5tq13JmwJVg+NniT6o6S+gAiNagwR1/OhSC2ULpEpNSAPYyS5xMNLuPd3EfIK0Gmv1d+hquQNkTgWxlswDIYE23ks2PkNsRQR7QBa9GNSj6paEc4C0IzmLe8MZ3rgnMYJV0dY+QBvF4nzKAVZNMtgvAzGGFfLeyNC+uBufDdn2XW5I7FR+if+UiBAyjSiXF9LLz+GHsnm4KxCH56Kwxm2+2hScIxPOWEZST9zKWUGNiOvV9gw3uIdWxgAk5jZjBl7QXr/ze3VVjWLLtv1kJ8ZpVYBSGwP+0TkjLDd5zxagk4trypDJ+Wrq6YlTuIP/UNXA//7EHJTcBxZyb2gQJTJ3pePoRUeEx1swcbAL+c4VLn9qGOXWX/XhiqzQTRpcy8uNxs7hmk5FeY+s55ARXalQJzGo93/hJEJu3FNXmS3p4pw5AqPAps8IPpQWsEz+mdP1CvDFYih3CKM+FT7eXBBLFdLhf3lg6OHGIAdOlKfODKc3fwAbK4A73Xg7LtA+GKE9ckX8Sfbqh/gIosbWEKX00KWMeNu64g3/SBmnpROs7dVbk99sYMhH65AgqDMKqhvRf+9KYCqnkNok8DOgkXDsECtnnvJreDBb984zaP0EYXt/Dj+w8wAEP8vf4BtIs5PNdxBjev4vMCYpftNLsTVcYGKbWaMXHJlTxhwbkm22NQSNGZs52IXbrMdge+O/X5noGnUFifaYCKfuO/eefnBBWeQR1jgyFjE5+ret1BCXdUg5qfK7jcn2AR0LWPqYqNThMOvsgW2qwhYVXI6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39860400002)(396003)(376002)(366004)(478600001)(83380400001)(186003)(16526019)(31696002)(7416002)(110136005)(38100700002)(16576012)(66556008)(6486002)(8936002)(86362001)(316002)(31686004)(4326008)(53546011)(2616005)(956004)(44832011)(26005)(36756003)(2906002)(5660300002)(66476007)(66946007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ft4gZH18tOCSjrBslLRm9Xpqg1v5iOlhmvseGL2sqWqw0s8iflrrgJaU7aI6uIubJppV8Khc4gLmByRB2TVVsfBKbCfYZ5t/wpFpQcm2b7DbGJufQnqSFacAwfM8+Q2LkGBxVxWmLlYepCaGO/5NL1/I4BXAMjbQuT77q26DzZ8azIz8Rc+2HmVVbidmbi55Bk3VwpWOCL6Iz3D1WA4oTXLF1t8OmFx+Uq4OLwTKlHUOB/bzngQoHmBT/1FECOkrxaV/rlyrA3DPxuUQCzfPVugfW0pfzUe9hLVjOXmoZ9XcWn3aGGF/EMMv652EBZDlSj6sZ3XEwJSANirIu7eeVTP8CIrA6JR9XI8bFOrTqQmW0A2jcjxNdpXUpELnbBHNgz03HBk4x1CzVDwFtP+RreIwDbCQRD/fDtiFm8kx8+yJ2LZXTpBRuPCaGSttwrCUX6aWn8dNjTR+6GncZktSuPIfUyddHEiemJphFr+8UlrXc2RR+qT4j7lec56fjs6D3dK2iaj8n/Lw65HQWhedWAm3vPzohOJWEuh0pgWwaiD3W4MJN9da+eCVg9xqdQBiYHnUpdaHv/tyFc4EOhpsnWZbwoHB1R++oil7KOWFOaKs0SZpgWAeIqobJ/13RmllfGOD6eBCIMoQWLJE+yj/PIPFme7ewyi+9DNe/E1DSTQ0jsPEbJYAZRtRxU1oRRarRrw3Yj+/YlKe88ER9O6kphswZo1FUuYmjnJc7Qs3OjpdQxPoI8i3OzRGOA12Rs9w
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08145e2c-c9ce-4f44-8f6f-08d910d5beb4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 21:27:26.6356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lceKgZC8PnPtKTYBcXNcbUUpUDMAA6mhI2sZi8kjsFT5e2/JZIzguwxiypMtlNctyFwSDULJhII5Oj5K8x8LLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1905
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9976 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060149
X-Proofpoint-ORIG-GUID: Xgy7kZxDcj-y0qoUYcS8zyEhbQMtgqMM
X-Proofpoint-GUID: Xgy7kZxDcj-y0qoUYcS8zyEhbQMtgqMM
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9976 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1011 mlxscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105060149
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/25/21 9:15 PM, David Rientjes wrote:
> On Sun, 25 Apr 2021, chukaiping wrote:
> 
>> Currently the proactive compaction order is fixed to
>> COMPACTION_HPAGE_ORDER(9), it's OK in most machines with lots of
>> normal 4KB memory, but it's too high for the machines with small
>> normal memory, for example the machines with most memory configured
>> as 1GB hugetlbfs huge pages. In these machines the max order of
>> free pages is often below 9, and it's always below 9 even with hard
>> compaction. This will lead to proactive compaction be triggered very
>> frequently. In these machines we only care about order of 3 or 4.
>> This patch export the oder to proc and let it configurable
>> by user, and the default value is still COMPACTION_HPAGE_ORDER.
>>
> 
> As asked in the review of the v1 of the patch, why is this not a userspace
> policy decision?  If you are interested in order-3 or order-4
> fragmentation, for whatever reason, you could periodically check
> /proc/buddyinfo and manually invoke compaction on the system.
> 
> In other words, why does this need to live in the kernel?
> 

I have struggled with this question. Fragmentation and allocation stalls are significant issues on large database 
systems which also happen to use memory in similar ways (90+% of memory is allocated as hugepages) leaving just enough 
memory to run rest of the userspace processes. I had originally proposed a kernel patch to monitor, do a trend analysis 
of memory usage and take proactive action - 
<https://lore.kernel.org/lkml/20190813014012.30232-1-khalid.aziz@oracle.com/>. Based upon feedback, I moved the 
implementation to userspace - <https://github.com/oracle/memoptimizer>. Test results across multiple workloads have been 
very good. Results from one of the workloads are in this blog - 
<https://blogs.oracle.com/linux/anticipating-your-memory-needs>. It works well from userspace but it has limited ways to 
influence reclamation and compaction. It uses watermark_scale_factor to boost watermarks and cause reclamation to kick 
in earlier and run longer. It uses /sys/devices/system/node/node%d/compact to force compaction on the node expected to 
reach high level of fragmentation soon. Neither of these is very efficient from userspace even though they get the job 
done. Scaling watermark has longer lasting impact than raising scanning priority in balance_pgdat() temporarily. I plan 
to experiment with watermark_boost_factor to see if I can use it in place of /sys/devices/system/node/node%d/compact and 
get the same results. Doing all of this in the kernel can be more efficient and lessen potential negative impact on the 
system. On the other hand, it is easier to fix and update such policies in userspace although at the cost of having a 
performance critical component live outside the kernel and thus not be active on the system by default.

--
Khalid

