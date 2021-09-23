Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2965416586
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 20:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242815AbhIWS6c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 14:58:32 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13048 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242827AbhIWS63 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 14:58:29 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18NIlTLO003120;
        Thu, 23 Sep 2021 18:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ewY/IleVVbM7o3oj9Hl2wZ9E2GTR90TxU4+ZXHmOoOc=;
 b=xZECDwqalAISqpldb7leSw4ux5dkT6qbEP6UyGcMePGREoNQVAlaedLTrXiRHEpz2Bnd
 84Djc+U2Adr72vOD49r/cAnVgAXJ8gjcO5eQ555E273zoAAvPC7lCU+b6pn2ikQJpd7I
 6ePr4aNpikcibXTmz5w7SwrR92MsMBep56Vn34YxHgcd9+X6Tpn6xGSrWpQK3wVQnBfm
 hz5lfkLLPxpsfSngWSlN2BUvafah/MZK1JFyM0HVWJjbtDLgXeWu0SXIoojuZHVaioic
 SgaIJX55pjgAr4M1aOeV4z5X1yLZ5w7sLvbVrj6pv+A6oKMmmAdrulK5efF1Gs6g/ZRk 4Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b8qvukpu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 18:56:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18NIu8fX007233;
        Thu, 23 Sep 2021 18:56:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by userp3020.oracle.com with ESMTP id 3b7q5yac8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 18:56:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lwz5BWMyecBiccxMdp7tVCiSfDwKWZCdyYBSLHoYCbq9eYAJhZ515U4sfUMabIL958bw3XCVho4YAqnzOrVX4SWfgmC4w4t8Eg1PXzW2IErKUNm497BMnYeznfdL/NI5j38D4sPUCkioUhrSWyGb1ER5yMu3t4ma0FT7UdhfSWQfc8+SrgU2JAMbyoDsdTRLTfiCN4FzTppRo8o4OGex9SpUwQXs+FF5PHE90nKsiJRYmYXTuPRTAItAlcxS89SXLH1ULHaOHqydiUDNY+58f44ck8e//d10GYtYK2bhuEjDIP56WgUCpVz+XCHYX5J4RzgNzND1d8IIakMotKe2eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ewY/IleVVbM7o3oj9Hl2wZ9E2GTR90TxU4+ZXHmOoOc=;
 b=YI5BSXzrzagEwI7+ov70yQJ0xmNILULL7F7YXH+QqmSdsOy94pSjtViJ+NRPO7NbLHfrkY5wVd0OhB8r2YfAJYxSwyzydD8X1Wd1oOmFxIezJ1bkAjF3MZxwOyj+J96iqD8Dizr8D27MDaFOLnABtKBpNxwwtneoelQkxpA0ezof00j07lWStRQw/XNS3WHGMniMsUGqK2klcf5QZHOfu7lSlbs23mt9KuJn1274EHiW0cZ/zKruZ9poHTE4tPikcFU6QEjH1Ohu9e7ev38dj1rqp0JJ2UjQgN34yfxqFpGBigB0JnjpnY/9eA0hx+NTKBkucakutb+5MCWYucMIJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewY/IleVVbM7o3oj9Hl2wZ9E2GTR90TxU4+ZXHmOoOc=;
 b=wTkSKR/LzrHucWggAgYj3KNG0qDXIozjWIZ0VKyYRZdOn7G5/icIgHsUq1JhD2Rl7OZJpUOzVn0zf3YnpfxlBYdGY0OZibFyPRVI0kWOTtiIXGuo6ViOcJFGl5BQ9DocS0rsOq96zCMwXdH+UbHyQeOIhgunuaALlsFPtn2pWLY=
Authentication-Results: shutemov.name; dkim=none (message not signed)
 header.d=none;shutemov.name; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3398.namprd10.prod.outlook.com (2603:10b6:a03:15c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Thu, 23 Sep
 2021 18:56:29 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b%9]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 18:56:29 +0000
Subject: Re: Mapcount of subpages
To:     Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
References: <YUvWm6G16+ib+Wnb@moria.home.lan>
 <YUvzINep9m7G0ust@casper.infradead.org> <YUwNZFPGDj4Pkspx@moria.home.lan>
 <YUxnnq7uFBAtJ3rT@casper.infradead.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <470145d5-8bc4-19cc-66ea-8e8610b7529a@oracle.com>
Date:   Thu, 23 Sep 2021 11:56:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YUxnnq7uFBAtJ3rT@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0086.namprd04.prod.outlook.com
 (2603:10b6:303:6b::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW4PR04CA0086.namprd04.prod.outlook.com (2603:10b6:303:6b::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 18:56:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ce1a857-98d6-409a-66cd-08d97ec3da05
X-MS-TrafficTypeDiagnostic: BYAPR10MB3398:
X-Microsoft-Antispam-PRVS: <BYAPR10MB33981DD0615D400002B01023E2A39@BYAPR10MB3398.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pdqsOs359GTx1hOCfyVglzA5C4dcKJ5D70zNXipcOFFwQRoYZcgeShTvWle3ta0EAfoBC2gI6duPo5Sy6sFhhFF+PoAJ7swr3Q3a11e9hhRW0Y/w5m//tIjwConXCdqlb10cHHrZGOLQ+kWVJ8xEwu56Lr52VPqTsELPFkAxy4PnezmWvllfl1I+ELRyd5ErC0zMVCnFGae16r7883cg1YU5acUpyKT4p5179XIhY84rGeGMWOwC+5aibLMd24oC4iBPf8ZwXcORFdxr/efSwE/SKUTZPBgATwkZp3t7IUCgQKKGMTA3L2v/7xHVr/TPL1wltLvo/zHDrVoWuC6wkyiInszzgzWe2xz/TpKeQFCB0hwxqvJ7h5D3/OC0AwVqV+/RbJOBZjFLN4I4o9IwSNvqzM79zd/XtQ7LF/QnCDFhbZ81Yg75z8z7h0Eat5leUBeTYdzkiTOUvO6vCGE5Vj9OhaEJTT246mboh5Ff1N+ACiRnntJqVVXy/xIcVFoCoa1BKZnnp7JHfUxmVK6oBJK3m0eLdy/pBTinaOxRAreUhaYGw//jLB2gvoor4beZmD3aOdpCWFyax6eU4c4rwOfIWWOOtKSR3GTNOJC2Y81e0F/27J1PQbD8KlO4etW1Uhchh3T7v5NklAqTJCnXzmMiobo5yklFCN5q/jsW/AY49Dp9llWv57R49wVv/381r04fURdTxouj5uBVCoXyC4coa1qKGrHHQyMfUPvbKbj9jBS2hKM7ODyJ6fM47Xgv2YridCXpQtavnUv8BULCWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(956004)(2616005)(7416002)(7116003)(316002)(110136005)(54906003)(86362001)(52116002)(186003)(66556008)(38100700002)(2906002)(31696002)(38350700002)(6486002)(508600001)(53546011)(36756003)(66946007)(31686004)(26005)(66476007)(5660300002)(3480700007)(8936002)(16576012)(8676002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2NsUTRBLzNtS0hadzFWU2M2WDhPMXZTaEdlYUc0N1BJcUFldXhzaU9YRVln?=
 =?utf-8?B?cld0YlpCOWducVU3REk0SXhUWVg4VVBnb1U0TGcwQnQyNk1KbjNnUUhhSkll?=
 =?utf-8?B?ZGhiYVI1ZENIS2pIZXdnOWFwUXpkM1J3SC95V3N6YUVvT3JBdUJONzRCLzc1?=
 =?utf-8?B?TVJJNU9hU2tZdEJYa3RnSFBva1FIek55VUV3cDNQK3hOWGdXdVVlT0pMMFhR?=
 =?utf-8?B?NDU4Z3hCQ1lTS1VxT0Q1d1BrNkJzTGlYZTU2R2RSWm45NmgxVlRRZWhQQ0gy?=
 =?utf-8?B?anBqSER4VDR5bWVEdk5vYUZOekhQVEhncWYybTF0Q0ViNWo1LzVGZGVqNTN6?=
 =?utf-8?B?MFpPS21oaWxtaWF6WnJYSk1qV3pKdlIzanZBdUZKU200UG5iVllOL3JnQlJK?=
 =?utf-8?B?TWdJa0ROb0tUREd3QXNHSU41c3hBaGI4dDVTMmducjdRVlRVam5OemxOd3VJ?=
 =?utf-8?B?Nm9PQkFTWlZWQVZqb2xvdEQyZHZNSHliRHJsVzJOOFNBdUNpN3EwMkNGSFBX?=
 =?utf-8?B?bW9qcjFqbzFqbFVZSUIxT2h0VE9QbmhLYW9BM1YzMXQ1dVp6WDZpVEsrK08y?=
 =?utf-8?B?STNCTGkvUXZoU0wrbUVpb3RQTjJRMS9QME81Q3JubzBSNm4zZ0hSUHdoejhu?=
 =?utf-8?B?RmNHenBJeGNTUDlHbkhta1lSeVBjYWNFamtxdjJqREdQcExBdE04NmZ3Q04y?=
 =?utf-8?B?SW1ZY0ErSkYraERhUkczTmx2cjF5QUFBVlRBN294SWJoWFVRRkdTaUtWYm9R?=
 =?utf-8?B?QW9Na3NvQmp6RW1mZ1gyRWVDS2tDd2FwS1lsb1JySkNReHFTWEliNmZJKzJG?=
 =?utf-8?B?WGpIOG5ZeHJoWG5SK2htWUJPeFp6bzNqYmhYSDRINjZQZ2VjMkRLTmJXS0hz?=
 =?utf-8?B?aXY2cXV6YnRWOTJhSXhrM2JhZnBRUVVWQkVuOFJxRUtKVWJOcUdRK2FGYzFz?=
 =?utf-8?B?bk1iQlJJc1BnaWhNNHkyQlh2alJNNHhVTmM2R1JtT3BBMTZ3cndLTTdpSDdn?=
 =?utf-8?B?ZmQxMmNVZFFwRHZHMVZlbys2Z1BrRm1ybXZ0RXJsUTRoV3NZV1NKSVAxZ2Q5?=
 =?utf-8?B?TGkzOVBhaFFTUjlkNm83UHloU2tCMVFiRXlZRkVNaktCd0pMWXBkeExMSjRo?=
 =?utf-8?B?UmEweFVwazdoYk55ZVBIK1BRTDRFMWxpalJiank4VlZKdTYvbVBWMHRrclNl?=
 =?utf-8?B?RzRvdFprYmZYVklrNmpyTGxLU3NzcENNejFsMnUzeEF6K1BTZm1palg4MUZn?=
 =?utf-8?B?RjVIRDVJblp1TUFBcXN3UzBMeVNlTldjbXd6djcyL0RHMVJqMVFQdFdJQkdJ?=
 =?utf-8?B?T2NKYWxWckswUjIvSDdZaXJFaklQWk5PMkdzc3NwQy93U28zR2w2L2ZPUmRE?=
 =?utf-8?B?ckpadWo1QVo3Sy9STlZhRHMrcnBlQUZTYVlSZnNUOHhlM3BBQmM0VUxtdGc2?=
 =?utf-8?B?VnZCYm9YOEdVN1AxZXJwSThaN0xuNWdUb1g4R0ZLM0UxZXlQN2xjNmJDOEUv?=
 =?utf-8?B?Ti9TRkpJV3BUN00wSE9XWmg4S0RSbnNDZ1JiZlJhd1lBVWJ6Sk9uN3cxR0Jq?=
 =?utf-8?B?T3lhcXg5dDg0cWVsdFNyeStFeFE0ZkxqQURGY0Y1TTJKcEVBQmtaeCt3aXQ0?=
 =?utf-8?B?cUpPb2VQc1Uzd0tMVjF4WEFiOEl3b054dk9udDZLOVJCS01wMzFJd0VjS05G?=
 =?utf-8?B?aFIxYk5vU2sxTUUyZHdXdjlvc2wrVHVRN2x3bXVldTg5VG4rckNSMHdxVmRV?=
 =?utf-8?Q?LnzYHSApJ7KpFv/g79Tyq1tOHvldjlA7PfSgwuh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce1a857-98d6-409a-66cd-08d97ec3da05
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 18:56:29.2459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRvsHpq8B/lExTyCGU/2IXSh1dzN2ig7OjnSIc6GXnc4Ph3BQf8bP19+RjJ3TdXORZEFYAI/iFk26KP0kx677A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3398
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10116 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109200000
 definitions=main-2109230112
X-Proofpoint-ORIG-GUID: i5Vp28g-fwtX3Jhs11LbN2SEpOqXAHBG
X-Proofpoint-GUID: i5Vp28g-fwtX3Jhs11LbN2SEpOqXAHBG
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/23/21 4:40 AM, Matthew Wilcox wrote:
> On Thu, Sep 23, 2021 at 01:15:16AM -0400, Kent Overstreet wrote:
>> On Thu, Sep 23, 2021 at 04:23:12AM +0100, Matthew Wilcox wrote:
>>> (compiling that list reminds me that we'll need to sort out mapcount
>>> on subpages when it comes time to do this.  ask me if you don't know
>>> what i'm talking about here.)
>>
>> I am curious why we would ever need a mapcount for just part of a page, tell me
>> more.
> 
> I would say Kirill is the expert here.  My understanding:
> 
> We have three different approaches to allocating 2MB pages today;
> anon THP, shmem THP and hugetlbfs.  Hugetlbfs can only be mapped on a
> 2MB boundary, so it has no special handling of mapcount [1].  Anon THP
> always starts out as being mapped exclusively on a 2MB boundary, but
> then it can be split by, eg, munmap().  If it is, then the mapcount in
> the head page is distributed to the subpages.
> 
> Shmem THP is the tricky one.  You might have a 2MB page in the page cache,
> but then have processes which only ever map part of it.  Or you might
> have some processes mapping it with a 2MB entry and others mapping part
> or all of it with 4kB entries.  And then someone truncates the file to
> midway through this page; we split it, and now we need to figure out what
> the mapcount should be on each of the subpages.  We handle this by using
> ->mapcount on each subpage to record how many non-2MB mappings there are
> of that specific page and using ->compound_mapcount to record how many 2MB
> mappings there are of the entire 2MB page.  Then, when we split, we just
> need to distribute the compound_mapcount to each page to make it correct.
> We also have the PageDoubleMap flag to tell us whether anybody has this
> 2MB page mapped with 4kB entries, so we can skip all the summing of 4kB
> mapcounts if nobody has done that.
> 
> [1] Mike is looking to change this, but I'm not sure where he is with it.

Not just me, but several others also interested in 'double mapping'
hugetlb pages.  We are very early in the process and have not yet got
to this level of detail.  My initial thought is that this may not be an
issue.  Although we will allow different size mappings, we will never
split the underlying huge page.
-- 
Mike Kravetz
