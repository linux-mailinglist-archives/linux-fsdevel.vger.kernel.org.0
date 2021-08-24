Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86993F69D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 21:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbhHXT1J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 15:27:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47214 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234106AbhHXT1I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 15:27:08 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17OGndCd001052;
        Tue, 24 Aug 2021 19:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2tnF8Wq95Nc0yyrbFkqzY4fVD+PiY2K+SvrJut/8g0k=;
 b=wTSaQ4HU1wOG1rKVTg6O7F46sOBGTl0+2yU2Y6WVp5FejjsIPy4y8ebmu64wozJkZX4F
 gNeo6NT1N6eFiTDWUuW7EsZrru+LtygW0l7wHfgTy+tRsWljOmM1kEvxs9wc8+mZNxiW
 pBBqs6TMi48DkCG+7If6v7ubcPVlhMuk/9bhFSafxrRvld1v4EqJ4VnSwuoEs1TU6DEg
 ELLmm8PrAOg0uzPDyHKX5P6STrY+7u0HeXGheHlBDtnV676W2PNSzqy0dAc9PlkRIt96
 azeGD354e8KoLW8xa1bZ8DN8QTxeupgKAMBig6/5LdWJsiLslzXpae56kyeUW7tT2nHc hQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=2tnF8Wq95Nc0yyrbFkqzY4fVD+PiY2K+SvrJut/8g0k=;
 b=ob2vy+BYvOrll/XzRkfRK8KjYDkH066/RCcjhIyRxbTQWJDvI8rvUAsj7CoeNpXCi/Yo
 XGfNRjlaLdJJJC+jAXtakHuRR1tSL3ZfithY8zzYp5c408ubyURRqk8wwcOOWcrSVL2q
 JWf3X0TlNQGxeIwwjYSPiLpsg8JNe9kRkNXRAVTNG9cMNDX5odhtyOhVhgqzHqW8+ovg
 kozLUfbzNGSonz7nigaQ4me2/OLyJyW0/zk3kcsfU028TQgloIuGC8v1sWYRMMhGNTx4
 WpelwYwNyJmpSUpBxKz/6ndhx2FbCSLXLU4R/7BCuRBTMGy72hZwvLnmCl4i19spf9ym CA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amvtvsrph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 19:25:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17OJBQew173552;
        Tue, 24 Aug 2021 19:25:52 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by userp3020.oracle.com with ESMTP id 3akb8vbnej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 19:25:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOQGKBX/1fK2Y34TVg29jPTIYKY2gRixSXqHfsEOTGb0xLunszofU2te1+oJ3ZGY6r7HlWAbi6vKIZ+/GrTYACtNs2HRm8ItVhWVPLngECm5xDpySyItdpCZuB6JMOEw/lXyaJzqTGhGWdUwDUhWIxfk/HPiNL9NRiPj5Wos8zFHjYKU2Mn8sMPirP2RAhGFf/0D8HjNdgJLx9pnfCiVsiKonlX39n25jkHVHQUGzYZhztrBUiOU+PYO5LANttXRLOtoFAntyAiQZwg0APs9GbTwTe2XBakW6Oqk5vWfpuMOv23Oj2b22cJmEkt42Ovw1icKlbgbCITlRjVVzvmQdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tnF8Wq95Nc0yyrbFkqzY4fVD+PiY2K+SvrJut/8g0k=;
 b=GmfJzkbnWjNi5yhbpCEolO816SuP2o1Gju0OEgViz8HuV5/cboies6ft6ugzt6NgxeyLFgWllaAa73j2h6J5Nd18zOZqOjUzb+ehzOpqvJvwC8WFjyighXDN34i8+81jET75Q4DQec3HhW/J4lGQO3KqVDdaj/b1n0GsDzIY0t/3zc0U/m9jKlu78GA83tlz7ADv5M89zpvFPKSLyIUnOqz2wGw5wKxna7DYBYJt+D2EngfOZdwYjCcA2szqyNRB3yASHhqfXuKRP+e/vLQxn4m+/vQqVhCZ8OUhca2yLfSC/pDcibIg1tCekkc74n3YL5PnK6BLfXgFFsJ8GdLMTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tnF8Wq95Nc0yyrbFkqzY4fVD+PiY2K+SvrJut/8g0k=;
 b=a9wzJ5aJcKuTUfcuvpfswai3kvp+ZqGpoFXhcUyTAXEb5eSIJoOZnOafk6VUeJGn/yvdtFKZgqoX5mRygpD4mOTfrRTjJGefTiEj1NiiqS14V2cj78H63al4bGPl+UfxgjpfIZFZVfL2CzRf5xUqVZjHKPEWsaYrv7lMeMkYwec=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB5488.namprd10.prod.outlook.com (2603:10b6:a03:37e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Tue, 24 Aug
 2021 19:25:49 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::bc10:efd4:f1f4:31c7]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::bc10:efd4:f1f4:31c7%6]) with mapi id 15.20.4436.022; Tue, 24 Aug 2021
 19:25:49 +0000
Subject: Re: [PATCHSET 0/2] dax: fix broken pmem poison narrative
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org, tytso@mit.edu,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        sandeen@sandeen.net, Jane Chu <jane.chu@oracle.com>
References: <162914791879.197065.12619905059952917229.stgit@magnolia>
 <YRtnlPERHfMZ23Tr@infradead.org>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <b18de2ca-bc58-4094-dfb9-581f9002362b@oracle.com>
Date:   Tue, 24 Aug 2021 12:25:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <YRtnlPERHfMZ23Tr@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0035.prod.exchangelabs.com
 (2603:10b6:207:18::48) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.39.238.187] (138.3.201.59) by BL0PR0102CA0035.prod.exchangelabs.com (2603:10b6:207:18::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 19:25:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17555bed-f611-4064-d66f-08d96734faec
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5488:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB548851670B95257B16ED6106F3C59@SJ0PR10MB5488.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PgDlQpH5AdpHNqOpGR7VSIHj5Zumw7Sh4HMi8cMXqCHkOObNaDhc8/D0MKryuzcTJqE46dHZw2L9qN9gYfSXSr3rfj927kYWxJU1YwkjUlet90eqPL/vVaeUkzOtW0meXoGwukqsPklsxzO1LVw3DyxKZbUStYGRHfeAZURo2Fstmv67swSbqcrQupH2rwh4a38Xy3Dd4NgGzgQJ8fMUrPbnTZ3hKxkmILJwuT1jHJKHZJPAY55laDJN9UaTx6toSzvjnzbQzDf15AY4DiKlWuC/l/8I/LlROZqd3sPX9Iw69uOlbE0rwW+pULzE8kMq9WvhKusCMYWriEgUmJBJUdpXfRjlz3ypnbjbI1PrA6RRYuv/d0LRSjpdqb12UTpUVKDt3NmLdCCV855hvT984stuyBJqDMe2zNgp+tPd9fqyICL4c78M6G1zf85JCOHTX9NA65z/Ug1V21KjC49ZXoI9Ve5MqNF2wq1LpBvD2cGFt1Wx26V0g7AkuDtX1waYIwCFj1QtJxId8g66NNWIRW1qceYk6O0Ph34ThShyXvXrrwrHscak1yxQwOKZQD2zqpgf+iE2tyopKqA6Ixx3+IhYUfvo6EvlZX+D8togYo9W/n9Y5ol29eXlorby6EgBgQmnuguzjtXgLua9gpf4oT+hm1u2RQJPFuJ8a2ilfpUrhTD0dxnQPOHbgMw1XUx/b+sXhRgOMHkhyTmu1GO+Ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(53546011)(5660300002)(4326008)(86362001)(6666004)(36916002)(6486002)(26005)(186003)(316002)(16576012)(8676002)(8936002)(110136005)(66946007)(956004)(44832011)(66556008)(66476007)(2616005)(2906002)(83380400001)(107886003)(508600001)(38100700002)(31686004)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG1tUmpTSWZlb0R0WFN4THVYR05nN0hqcld4UWh6NWRZcDh5Mnhud3drYjJr?=
 =?utf-8?B?Z0YycGVubGJoRDd5Q3VXZXRqaE5CTUFFZ0FkTjkwSkxrNSs2dnF0WHo0QWFC?=
 =?utf-8?B?Z05PZUJSMVp1UHdiRWVwMlNPVXA4K0xLVEZNWTcvTlltWjlCRjhBOWFndFRC?=
 =?utf-8?B?d2l3WHVvNzNqaTBSQnlaSU5IMnBSc2ZZYWh0WDc5RkNLOEFCcjVBMk5GUzhG?=
 =?utf-8?B?eHdLdFFiYVFGemRqRFFhVlhRb1pBd0szZ2pHOTE5MGt2aHZyS2tjbHUrbnNn?=
 =?utf-8?B?NTFNbVB4dml1dUpnc096eWdVZXdkSzZ4SkF2OThoTE5jdmNNUjZ2KzZvYnh2?=
 =?utf-8?B?ZUs5TzlzSGxJNHdyVC9LSEpMMmZ6aHZYUGlMa0Y0NWpYd1lqRUhyeitpWnA3?=
 =?utf-8?B?NFhhMVFRR3NscERiaXA0dWpncDQ1LzlLdlA5OWZIclFWanNKUU1WZklKM09E?=
 =?utf-8?B?Q3RlNHp3SnlEQ1lZVVhBdUlXREE5WjJSR0NwcjdscG03WEh0cEV1T2NSOEtu?=
 =?utf-8?B?ZFZmMnB1V1ZYTWxzRGY1U08wY3hMazM1RXVGVW9vOFRKSmdLOG82N1Y5Umo2?=
 =?utf-8?B?Y1N2cnJJWW9wUTFEM0tXQmZocXZCVEtDcnBkc1VkT09BZjhoazVDbXVWdHZJ?=
 =?utf-8?B?YVJNMzl1SFFFR0YvMEwraytOMW9hRmphWTdzZjJWdGhNejh6dGZ0dDlQalY3?=
 =?utf-8?B?NkZKcnVERlN3UWpiVmxSZWpDUExJZFN2SVA3MkozNWVYR2tkSjNvZUhCNUR6?=
 =?utf-8?B?U0hZdmcrMzJvWElGNDhlQlUxbGllaklGVDE1SFN5NHNZUkQyOGhNVlg3NjJa?=
 =?utf-8?B?TEthcW1YK1RkNWtYaEtDeHFGbHRUTG11TWdGVHk5NnhQUFc4Sjk0ajVVaXVT?=
 =?utf-8?B?Q0NxUGkxcyt4S2Y3M2xXZmcyTlNXQmUxM2t2UGdyYUpwRldQTUswdE5BeXoz?=
 =?utf-8?B?dVJMMUhBcnZuMmxYM1VUNFd4VlUya3JFbTRoQUtFbitkd2hQTFlOdXNlR1pa?=
 =?utf-8?B?T0ZCWWxZZFAzcWNkVnM5ZjBweDQzYlowODZqVEw3Rm1XMnpoY1ZWMmtTOVNs?=
 =?utf-8?B?dG5IdlZEemMyaGl1ck94ZFpRdGNNVnRpQldVZVdGa1I4Q3ovVUUxMWtMcGxx?=
 =?utf-8?B?VFVIb2JXSDV4V3hGVUtHR3hleW1jSU5aWWpWWHI5cXdmTzVDdG53cmFadlF2?=
 =?utf-8?B?TXQ3ZXoxTkNYb2ZScWxJckZubXg3MXJYc01PbGx5b2R4Yit4dWprRW5Ma2pm?=
 =?utf-8?B?Qk05UytxS1E4QnFPNTJoZmYwVTBSZXdIdjk1M0xjRmkwRjVBVk9MRTJjSWhC?=
 =?utf-8?B?UTdHa3ZhN2RpQ3AxU3dCQ0VEb0RjaGlGQ3I5TmVmekNUVEJsSGNocXdiSXJI?=
 =?utf-8?B?N2g4OFh5Q3VDd1BYaExiRzlnamFCVVBsclpXZHJYT1c1R3diUzYrcUlEc2tM?=
 =?utf-8?B?b2lrbXN3RkZ5T1BWbDN5UVBFdkEwaFphUkd0WnRYa3NhMVVZMENMRkI2S0hy?=
 =?utf-8?B?Z1VrSkRiUVJ1NHJycExUY2pkam5OdUxFNmN0cmpDS3E1bGhIM2N6RDVKbVJi?=
 =?utf-8?B?SlJXQXhqdzhYZXJjakVwMXcyVGpLRkc0WnVQQlJwdXA1SHo1WGpPWnBMMmd2?=
 =?utf-8?B?aERKSE1GU0NpWktXMWZ5SGtNYlhJdTdFQTJKWlJxd01XaFdzTmhTL21YaFpj?=
 =?utf-8?B?TERLbzJzcUdqZ3dEYTNPLzRNR2JKMkFWNTQ3SzBFRWFaQmwrUTEyOHJOZUVE?=
 =?utf-8?Q?LtXXYbehT7KKa3cSTgiWM5nok3wQ5RA/3f4Gvan?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17555bed-f611-4064-d66f-08d96734faec
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 19:25:49.7462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fi9ZZlIjFXac29LVI05E3K50Ry6CxszMsqNaoyta48lT25YGvxSZif5KKD5dnouSZ/LQzMJxnvT/W2DC3NY1hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5488
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10086 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108240122
X-Proofpoint-ORIG-GUID: 32KMP5SOqzWdKroZq6tlvTBof-I1mBZ5
X-Proofpoint-GUID: 32KMP5SOqzWdKroZq6tlvTBof-I1mBZ5
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/17/2021 12:39 AM, Christoph Hellwig wrote:
> On Mon, Aug 16, 2021 at 02:05:18PM -0700, Darrick J. Wong wrote:
>> AFAICT, the only reason why the "punch and write" dance works at all is
>> that the XFS and ext4 currently call blkdev_issue_zeroout when
>> allocating pmem as part of a pwrite call.  A pwrite without the punch
>> won't clear the poison, because pwrite on a DAX file calls
>> dax_direct_access to access the memory directly, and dax_direct_access
>> is only smart enough to bail out on poisoned pmem.  It does not know how
>> to clear it.  Userspace could solve the problem by calling FIEMAP and
>> issuing a BLKZEROOUT, but that requires rawio capabilities.
>>
>> The whole pmem poison recovery story is is wrong and needs to be
>> corrected ASAP before everyone else starts doing this.  Therefore,
>> create a dax_zeroinit_range function that filesystems can call to reset
>> the contents of the pmem to a known value and clear any state associated
>> with the media error.  Then, connect FALLOC_FL_ZERO_RANGE to this new
>> function (for DAX files) so that unprivileged userspace has a safe way
>> to reset the pmem and clear media errors.
> 
> I agree with the problem statement, but I don't think the fix is
> significantly better than what we have, as it still magically overloads

This fix guarantees contiguous pmem backend, versus the existing 
holepunch+pwrite ends up allocating an unused(by the filesystem)
pmem range from the pmem device, and the poison block stay poisoned,
not cleared by the existing method. This brings 3 problem: 1. the
backend become fragmented which negatively impacts the RDMA behavior,
2. what if the pmem device run out of extra clean blocks?  3. the user
interface that clears poison when device is unmounted is risky in
that it could damage filesystem metadata.

That said, another angle to view this patch is that, FALLOC_FL_ZERO_RANGE
is supposed to zero-range, for non-direct access block device, it's
okay to not actually write zeros to the media, but pmem device is
what-you-see-is-what-you-get, it seems making sense to actually writes
zero.

thanks,
-jane


> other behavior.  I'd rather have an explicit operation to clear the
> poison both at the syscall level (maybe another falloc mode), and the
> internal kernel API level (new method in dax_operations).
> 
> Also for the next iteration please split the iomap changes from the
> usage in xfs.
> 
