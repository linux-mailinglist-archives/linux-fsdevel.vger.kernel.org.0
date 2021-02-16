Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498F431D2AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 23:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhBPWbT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 17:31:19 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52444 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhBPWbQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 17:31:16 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11GMUJYt044563;
        Tue, 16 Feb 2021 22:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=O2+Iq7qRDRo/OdO19RFd6P0phe8cSlCdkICqrBfKDzM=;
 b=Ufn7wD3T/Z9XlfaGFCQaB3LOLChVk16mqdNT3YtjowfvH+9xti8MOUgq61wI4k0wuhCr
 qJB9ttiqw9+0uazodgVl9khEUlAdSM86IibBIP/MLaEdSqjDqubBOuabdw010hNsEvDJ
 HkQgn8UttP+0PQt9EHsN0MdpKIK6Ezut9njpLX6Y2bTaWaXeRmuvCnrsvH7p/ERvaSwM
 9pd6prqVTWFv+uvhSD5b+aOQoqWOPNrbK4bePpbODe/vmVgban+4FwUkKyXUYvPdFE/q
 sdzo+WKxeuPWMKqcrvonp7ikvpsTWkt0QfEUhJvQ7UbosQ86zWddMx2R+TjKISy4NmOb zQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36p49b8nqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 22:30:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11GMUAn2188120;
        Tue, 16 Feb 2021 22:30:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3020.oracle.com with ESMTP id 36prnygr0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 22:30:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmAx03nXJm5/MoZXyVsa19gt/6Tmi/JrnsM0+OVTTrcB67qLwioBg4zodwY8KFOFGDBi8AjV7yhSsuDqQ1LkJcX8i7pI1//J4f/dgySDU5+xDuPmuPUgNLAkMOB8DtDCu/TrKktgs7YPWLRPlQ8oTBCOH4/SgrVWQ7sNP4P32wR5f81gA/35QqDts+svnNYDl7l51nYCQLyZq8A565NQHD70NjVkVoYJxA31rqLXDBfwbHmMhvuhWZSgiNKLiIFWQh0h+V8bNIMEy18+/Effh9GlnM/VzGN3OvuQhemZ5TKt5XyP4hFcQxlFeQ4wM8q2QJZGTvis5r6AJX8c2lKbNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2+Iq7qRDRo/OdO19RFd6P0phe8cSlCdkICqrBfKDzM=;
 b=awE44t29AFTB0S6GFD/dyHh7SFy+/s0fuLchGRT1fQlh7f585F/opDE4hc72+nX5cazMOxXxSiNqvxNdZu9mak+8S+Yy5CgC5HbUenhl+fu/QNNAxAAcHU9cVBOQBTgwo0AqFv6QiVrf2PYwW3ZY7pIUMgB4x83I8HZyF0k+Arq0n7W5aFzR+C6g/fLkWG1JZJ1y4MdZbVRK3EWHaVcZaAZBlKqwIWaDIu6pMM9/aorehL06Qu0uLakQGmr1g8So5jMF20DlpY6CyNoo9/OmhZJGkRtNCsXBY32BpKsvQD/w/HsYwKaVxPKc4ZWpA+8HitDlKzgKtIZtN9U1G/jy8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2+Iq7qRDRo/OdO19RFd6P0phe8cSlCdkICqrBfKDzM=;
 b=CVsj5qxK7UhzXd8h14+DjlRokNC2AyF37xTkM78HMYT3QQyBTB1S6CSuuUxfuXGwKC+Cjgwvlp/SxB/bWCmGBYGLaSn287TTTCPBsvery7TlEUnauuEEuSxgiENARrNG2OusMBCR7/ZxjxanPhHTfs6GDxtn3azhcHu0JO6mMPc=
Authentication-Results: nutanix.com; dkim=none (message not signed)
 header.d=none;nutanix.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1696.namprd10.prod.outlook.com (2603:10b6:301:8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Tue, 16 Feb
 2021 22:30:16 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3846.035; Tue, 16 Feb 2021
 22:30:16 +0000
Subject: Re: [RFC PATCH] mm, oom: introduce vm.sacrifice_hugepage_on_oom
To:     Michal Hocko <mhocko@suse.com>,
        Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Cc:     corbet@lwn.net, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, akpm@linux-foundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        felipe.franciosi@nutanix.com
References: <20210216030713.79101-1-eiichi.tsukata@nutanix.com>
 <YCt+cVvWPbWvt2rG@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <bb3508e7-48d1-fa1b-f1a0-7f42be55ed9c@oracle.com>
Date:   Tue, 16 Feb 2021 14:30:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YCt+cVvWPbWvt2rG@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0337.namprd04.prod.outlook.com
 (2603:10b6:303:8a::12) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0337.namprd04.prod.outlook.com (2603:10b6:303:8a::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.28 via Frontend Transport; Tue, 16 Feb 2021 22:30:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abbb4af3-9e6b-4be7-5391-08d8d2ca6f0b
X-MS-TrafficTypeDiagnostic: MWHPR10MB1696:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1696449DA0AB31B6E01C66FFE2879@MWHPR10MB1696.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7wmophLAo8mEOkPrheUnTGCZN2LYymUwVUXUQUjUGkFQUPRmBs+YBmGanp5tfvp4OpRkW/ueCr9R1jLNvBv9ib4DWNlUHshbFA+fdXFzcWKuua4JZIhFTZ1YiSbx2NX9VKg2Z2Dd+DzWE5h7GZnCVyJdKW0YJ4soikZe4uFbmy3keWkq2pPxw79rzqsxyUsQYPLnKvcZV4vkl3AyTT4AKPoWo1eiYtGUT9WYwn6l4jR+Uvy95okWE/qJX34bScPUvQWObzSu5W2hUgesx3S8Y0JF313Ly6cXkHn23695MG9kqsjpvc2hK1gm5/ny7BigChBBPyECYf5FJxFiCXEllV6SXMJoyGZPtkHKGpiafWyaXhQ9Piqx+gMUFpLsnirLBtBth/R0nVOyJYvwHP5FOxrXNHVr3jRnXa9cGbfeFaRBzrUSz80u5z2GOcwSQdI2MA4OBAjzf58ycf6NXFWJU3KW1zSpgY7HdDaF3Kncv7L2xVeXbqh6MwFvW6RrmNwfbuIGyUu34n1ecZhhTJAEkQpCjROTHPnSVDhxOA8HhsUFM7SYj7ctfTzBVSKpGIzA1qhdoKwYkYyq9E9g17fVVsOH4PGlMZdjn1kcG86rvRA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(346002)(136003)(39860400002)(956004)(86362001)(66946007)(44832011)(8676002)(478600001)(296002)(2616005)(66556008)(110136005)(66476007)(6486002)(36756003)(16576012)(31696002)(4326008)(16526019)(52116002)(316002)(31686004)(83380400001)(2906002)(7416002)(5660300002)(53546011)(26005)(186003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eGlDZjBJN1NFK1hqa2pCQmRFeUhadmVlYk1BZjFKLzY5SXFRUmptbzVOb1lN?=
 =?utf-8?B?Q2YrM3hZYzhkMVJReFdBOXRwUTc5RlJJWmtTK1ZJMmU2MmlwV3crcnF0aGNm?=
 =?utf-8?B?VEtkTkRhUzhYTVdhYkljbE1iSHcwTkI0YWRKU0NVcnJQVUc1eG42MVpZSWlu?=
 =?utf-8?B?aTRkZXdlRE5UbE1qZDE5T09qRmNEMC9EQUQyTHJJcWdKdVBlUFM1L0NaOWll?=
 =?utf-8?B?ZWNWc05pQ3N6QjhyUlRQbGJmaTlzb3AxY1RXZ3NhUGNjN3lCNXBGa1ExUXYw?=
 =?utf-8?B?ZjFuTEpWRngvN2dOM1hWclNWdGZybjZCL2VlZzhrUGR6clFyekNXWXhudk4r?=
 =?utf-8?B?TjVrZFN2M0ZDWjc0aC9RN3NRdlhUZ3czWlF4YUkrZHBSVUQ1c0pkd1cvMHNm?=
 =?utf-8?B?MjNjYTJoZmpsUWtCTVR3ZkNtZ1Z0dWdjK1lkY2VZUjgyZUhhb3RnTFJ6THlt?=
 =?utf-8?B?QUtWLzlsbGRnYkFsM2c1S3JtWlNmcks3b1M4c1c2UzBybENiT1J4Y1ArK0RP?=
 =?utf-8?B?RFhsekVLWXNpM2c3RyszVWNDVitodVA2MytVRGRnQjd5TTJrcndFOUUwbndi?=
 =?utf-8?B?eTNXNGVGZUFKN1g2ME5GckRmbmo5cGpyYktpZEo4U2ZEZkU2ZEg5aHNqOW0v?=
 =?utf-8?B?bnYrVUo2Z2t5RFZWajRWbFdjWGlIK2pyb0U0MlFMT2RSZC8rU2lvYmpWdTdw?=
 =?utf-8?B?K1dGaWpUcFJPKytmaVpIOURQbS9PcUsvdGRFbzBVMDdkenZOd2pjb3d6Zm53?=
 =?utf-8?B?SkFtVzByVDVycHpucGk2RXJLVzBCeGRFNHczQzU5MEZSdldKWW9wZFNWRTZW?=
 =?utf-8?B?RTJSQzdoSXRaTXVyRytJZWFVWG9PdmtERi9hSCtXT0paSUF2c2EvQmtSd0F2?=
 =?utf-8?B?QWtpQ0ZXbVh0TDE4NWMzbURydVBVZldVUnkxRU5ENGRjZDJpb3hPZGhtcTd5?=
 =?utf-8?B?MXA5bTFVTk1iZFBQVjdVUndmTGRVbkY5QTNBbzg3MEUxR1NZY1ZMN3JrVDVu?=
 =?utf-8?B?NjNYY3dvR09KeExQZjZTbGJoRTQ3K3l4U0xHMHlCS1k5L1BuVVZwTXJPaVB1?=
 =?utf-8?B?SVJVZlcxTmpuVmpacjk1NVJ6eS8wOE52U2YrdnRIRXRMMWJCS3RvRHB5ZHcv?=
 =?utf-8?B?VmVkWjdhV2hjQjNXeE5abnNnTXRtNmZMOEo3ckZFVThVVDA1RjhHd0RvamJI?=
 =?utf-8?B?RHFZaWFBRWx3VW90OGE3NDZlV1hGcHJVeUptK1c0Ti9XeDRTTkM5WXVTM1Fy?=
 =?utf-8?B?MkRONVhyWnZad1ZmNkRLWDVqUGNKOTM3bHJla0duKzl0dGtJeGo4bjNxMmFC?=
 =?utf-8?B?SGlVbGxuYUhFa3NFVDMvbmp3ZHkrRGRnOWhidkovZnhvTUFUUkRMY3FDd0VG?=
 =?utf-8?B?L0pFTFZJeWlxUWFYTGVGZ1hFdTVqUXVRR3cvSmU1dEdTYlEzOEJteDdTM1Rs?=
 =?utf-8?B?QW1BNE5vSXRLYXVBSHJVYzV4MlZlS2dvdDgybmJlKzBvdlZZbDE1Y1h0RWlF?=
 =?utf-8?B?WFNpUUV4bXFHRllTYzFqZ2ZGK0xzY2NUS2dJUW9XYThCS2NwbytvRHZkWmhT?=
 =?utf-8?B?NzY1QXpBNDFhb1l5S0E2cWUyeUtiSnpyaTlna1dXbU1VTFB0amRpRml3Y0Fj?=
 =?utf-8?B?a0RucVVIcGgrLzFJRUFKTDVLZzlRTmFrTHB1NXA1dlQzU0xuTjFBNldVR3h0?=
 =?utf-8?B?bnllTFZEQ1NqeFozS3lQNzFyU1oxMXVQSHJSREFtTXpscmRzSWtyVjdGcTg3?=
 =?utf-8?Q?hcTrfwFb1MLtYylZ/aeVBvOYYbPIhoXvjFXAh8S?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abbb4af3-9e6b-4be7-5391-08d8d2ca6f0b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2021 22:30:16.3504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuK8k3bdXBiV4jyzWI2XGz4qCvscihbaV/WbP+lvgaiTSLKxHHHEPIseIF0gMCEL7NeniDzwkhZQZ3q8koIFkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1696
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9897 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=586
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102160180
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9897 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxlogscore=832
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1011 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102160180
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/16/21 12:12 AM, Michal Hocko wrote:
> On Tue 16-02-21 03:07:13, Eiichi Tsukata wrote:
>> Hugepages can be preallocated to avoid unpredictable allocation latency.
>> If we run into 4k page shortage, the kernel can trigger OOM even though
>> there were free hugepages. When OOM is triggered by user address page
>> fault handler, we can use oom notifier to free hugepages in user space
>> but if it's triggered by memory allocation for kernel, there is no way
>> to synchronously handle it in user space.
> 
> Can you expand some more on what kind of problem do you see?
> Hugetlb pages are, by definition, a preallocated, unreclaimable and
> admin controlled pool of pages. Under those conditions it is expected
> and required that the sizing would be done very carefully. Why is that a
> problem in your particular setup/scenario?
> 
> If the sizing is really done properly and then a random process can
> trigger OOM then this can lead to malfunctioning of those workloads
> which do depend on hugetlb pool, right? So isn't this a kinda DoS
> scenario?

I spent a bunch of time last year looking at OOMs or near OOMs onsystems
where there were a bunch of free hugetlb pages.  The number of hugetlb pages
was carefully chosen by the DB for it's expected needs.  Some other services
running on the system were actually driving/causing the OOM situations.
If a feature like this was in place, it could have caused a DOS scenario
as Michal sugested.

However, this is an 'opt in' feature.  So, I would not expect anyone who
carefully plans the size of their hugetlb pool to enable such a feature.
If there is a use case where hugetlb pages are used in a non-essential
application, this might be of use.
-- 
Mike Kravetz
