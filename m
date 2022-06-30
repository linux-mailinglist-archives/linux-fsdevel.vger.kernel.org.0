Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6FB56271E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 01:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbiF3Xch (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 19:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiF3Xcg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 19:32:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A52D5722C;
        Thu, 30 Jun 2022 16:32:32 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UM4Lcx003230;
        Thu, 30 Jun 2022 23:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=EVIqdMTTITTbOuuGrgx6VA3q2Jrf7yPdKS7sJYtj7hQ=;
 b=vzse98pe+01nZ+GxmlFN+ZCpCV5YsKxpZl4b6lGN6ugzt5diW38ooo4BU0urhsHYBErH
 1pedoe1sHhyKjRyimxSxdH30yahndCOPzSHMREBn5Gwwh1bYuFrhAcBiC+tBIYZu0mHD
 e+o4edDiHFtSRrBhXMvI5Xl3IbE68s2RZMDJma5FfP27vto6sWXGxtB5PYGse/IPXlDc
 jsqegW80WausN4SJG9FqpkbT9nELsSdqvPcxdcA7kv97E1vTm0pPVHx9Tli7e0Ql+zfQ
 +Da5Ubh3AHcocVAgpfBlac7J/dnJ6iA0qr5BWbEx4ju/j+PFY6Q4Umy9LqAx/77RXW47 3A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwrscng9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 23:30:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25UNLivo020549;
        Thu, 30 Jun 2022 23:30:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt45s7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 23:30:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TX1ufaQWK+Po466K9al4rTEsa/sau1n09mDz12s/jOUO+8W0tQ015lCMeY5idzNBPPLHekte5fx9D1cEBZrxrgiM2vb+em6ahWKNjVnDZf1v0XHX3+vGC6VJjs7eeNRw0IyqtJxgBt/AHOw5kafeqi6Z5YY92r15VvwSz9PxSeTDfCypt0Si4Yyubt915FOF2hbxq2k7S+CGITAwil7oLy65da2QnjGxIxoK2YCrNX2rkN4LOe47wJjKidL18Tomm/pp/CReuSKmzgVsJH/NYLbhxieJ62aWlj5feBeDTDj86gxcKNNknVNScZV1yxO/2OWeA8izN/WTiZwUSTV37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVIqdMTTITTbOuuGrgx6VA3q2Jrf7yPdKS7sJYtj7hQ=;
 b=lp5MueJdAbSCm+bvYDNdTW3OvW/NA2sxVJ7FmVXOwsoCUrfZjtMmvPiWRl0jrffzwbV6THDSp6ao+FQ/BrBjib36Hbn8XPDaSdz6eFZ+5c1+7B57R3fdpFb/ZC4Ge01LRd5XnwZ7hXqHkn0SxianWGPqEiguW4CzEpiu0SvK1VeBLZ6JwaeBHRZswFgG8Ml0I1rUa0zoGEtga8zzmfP1mZokJg4YrCYm9eF8syl8xJEsqLAYljKNqiqHxypyFJXe3kXmcguoefbzi8sX6rfAZDlCfe3bv5O0YYCrNDpSf1CV7yJh/X9C/AJx8uQgyiXvmC+3sVX710ABxL+nQVcxYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVIqdMTTITTbOuuGrgx6VA3q2Jrf7yPdKS7sJYtj7hQ=;
 b=UpLb4nUgnulBPLQbpNck6GUI9wuelhSBE/dFs2INXAZYY+jq5lYbK8WL1gevhcqWhNmy06I3+EM+RCZaXloSDPu5BIoQzf2qDtEfReWpfkq/BwUFXMVOqrd/nzcLuRGnQbc1vTKF3wfMMw14JV2PHjno+yqos17cAfHsg9DY6jc=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by SA2PR10MB4714.namprd10.prod.outlook.com (2603:10b6:806:111::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 23:30:38 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2%3]) with mapi id 15.20.5373.022; Thu, 30 Jun 2022
 23:30:38 +0000
Message-ID: <75aaa2fc-f044-2096-bf6b-740b0075467e@oracle.com>
Date:   Thu, 30 Jun 2022 17:30:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 6/9] mm/mshare: Add mmap operation
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        aneesh.kumar@linux.ibm.com, arnd@arndb.de, 21cnbao@gmail.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
References: <cover.1656531090.git.khalid.aziz@oracle.com>
 <d7ae3b880dc3a26129486d5680db672289d2695c.1656531090.git.khalid.aziz@oracle.com>
 <Yr4ZKd2J8ucA/npV@magnolia>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <Yr4ZKd2J8ucA/npV@magnolia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:805:66::24) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5832987d-9d75-4fb7-625c-08da5af08a18
X-MS-TrafficTypeDiagnostic: SA2PR10MB4714:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2s/rDunawsapUtlg/Dtmz6qKNWR9XJjhZ/7kts4rtooyctHo1ODFziWYBFw1WA41gfDetLNACqQwZN5fgTmfSLBDOk1VLtbhRUsr6t6GapQYadBNTAHPE82rTJ3qFmfw99Gb/KXAb4LMn2dE0oyu0XBQZKPa2nK0mMml7V597ZJFkKmI9S1PDSSwaUuYe1Onnr0c8HoglKvMN9F2FoANjjT6eQi+vHverKHaSR/xvigO/8qJQcEhqJrv2GoAji5ce0+NvThUhwSVIhMOZVOEwgtBwnhhQRDLMotNF1Aybl4TXc8SKS3MgCKt4kbCFUjUgfj6OVpOMJfk5DOqqNAYLS/jfYUOk1z56EhId8HCXHVk41teK3/16OR+EnUr54d5Gen19XZCGj/I/p3V1PymUq1HOB1fl6KgMlOOb78k7niiByx8HYVEzPVNLTL1ExT90Li/uCBCIH2hwbXLJ5mILahDz/0cW3S4zyv2M8Fw1J58gXz0XLc29bWkWITSm3TvTj+HVjn2pAajX8qdD9mrHfzxSEqKYzVr9DfoyiMAIeMu9Q5FBBCKRl6FK7zfDJ2DPhXNYPsr3en/ESkSe/BHEr4qS6s+tMY5UKpMaEkyfMgDuPVylOGZcoeEu5dJBSb19Zrxr4HkZhgJRD0mwNiyftzzrExJ7ftY8rlXuiCcBt8sWtBZy7XOeyMRSzjQwijX4v9XJdNvrJ7hTsVzg6cFqhMEWqEB+PtWASHlUGoJKrUjFUBJPHqPiYwzY3YT3bxx93AQizGVQmHi0zu/K801eLIjEapBhXaPUjJVQOdVLawX76NNrne0ZdKsADOomJ3U3klQvSvhb1Z2c6Me0KsAdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(376002)(396003)(366004)(136003)(66946007)(316002)(38100700002)(8676002)(4326008)(66476007)(66556008)(36756003)(6512007)(186003)(53546011)(6486002)(41300700001)(6666004)(6506007)(478600001)(2616005)(44832011)(6916009)(83380400001)(31686004)(86362001)(31696002)(5660300002)(2906002)(7416002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzJiR3JnUU9IbVBNRkJNVjJ5QythdGF2UDhUNUZoMHA1d0kvams1L1ByTHBC?=
 =?utf-8?B?WW5SajFBUjNZZkxYdnNlZVlTTXpGaE1BZnNmQ0VRaE5VZkhDT1hoYXZWOWFx?=
 =?utf-8?B?WmhmbkdMaXE1cUlXNXhDcVdXcHZNRCtwdHhvcmloOXBpeFZ0cjFuU0Y3UENP?=
 =?utf-8?B?RVNpb2F1QXp2WUFqUy93SDBPRGRUWVhJNHF0WkloRmdnTldtRjZJWXRPejFJ?=
 =?utf-8?B?cEZrNFU1cEQxWlVjeWdxY0VOSGhBWXB1THkwVlJGTHIwTnJDMmVldGZWTTVq?=
 =?utf-8?B?VUVPVnU5QXBpRU50VHJTTXdNdTR0M2lDUjBYQjN6dU9VMHAzY2pFRG1EWHlX?=
 =?utf-8?B?OEt0MTkrQTZHYUFTVGluanBqOFdRSFd4b2JYU0VoQzhIWFR3emFIdm5jMm91?=
 =?utf-8?B?Mlpsb2hSUU9QVE9qUzVKa3dKV2ZtZFBqUEdoeHZBZVlDbUw2SFJaLzJWU3Zq?=
 =?utf-8?B?NFdhN2dZOGVBNjN1K2RiWi8wQ1lTU2cvMzNUbklOVUl5Wm9OMU1tdVhtaVZj?=
 =?utf-8?B?SkRJRGg5ZXM5ZHFybkhidWVEOXFhNFlnR0cyc3VQL2JQN1ZnNzNlZTFPK0FM?=
 =?utf-8?B?Q214YlZwUWZNQWhuWFBSL3VUM0QydHpXNGhqazlEdlExR2V0VVpJSzB3dVFl?=
 =?utf-8?B?c25HK2N6R0xVYjUyVkRVSzFNQ0hIYWgxU0VTNmxmbHdzNXJpV1BwSU13c0li?=
 =?utf-8?B?aDBiK1VWcEpZemtwMzNIS0d2SUY1dG10MlJ1SjFPclBzM1QycGQvdExQaVdS?=
 =?utf-8?B?S3REeVVkZzVUc2VSM3FtLzdxaW80ZHNZNTkybkhvdXRtZFFKdDFlNzhwcndv?=
 =?utf-8?B?QVp4eW5qSzJmVWl4YVlITnBBL1hiV0lLT0l0K2hqNy9UZ2tBQVNGOTR6V1gv?=
 =?utf-8?B?MGM0NnRPNGNES3ZtcU1NVlk0cUdDWEozZ1Rhd1FKSHJqeUNQaGQ2djRUMmJl?=
 =?utf-8?B?TnZrbnZrWmR5SlZJZWMwdktPOXFmWXl3SnA2aWhsNzdtajZ4YXlNSnNaZTUz?=
 =?utf-8?B?K0VsekpNTC96RnY0NHFFQktiMmExNzVyVHJGQ3QybUxaTUtlYytvSHNWclo0?=
 =?utf-8?B?MTZjZGtheHFqU04vR2taa2pPTndPajVTYzQ1Q1NQYzZiRTBCWVBwQ21PdVhn?=
 =?utf-8?B?b1pjME04QXRoNVl6cmhsWjJLenVVWjM3Ump3WWFKYjdtQytSUHY3ZDhTVXhx?=
 =?utf-8?B?QzNlTWM0RVVvbUF3dmNFRkRhZVNJMFpIWUtycDdCV2RWMzdKdXNudk9CVnE1?=
 =?utf-8?B?NzVocXBkN090TFJFYzFuZjFHczRZV0hOMkZOYXBlTko2TEswTHRvSFowM3BL?=
 =?utf-8?B?YUNnVVFHYVVzTkxINmxSUTFwTDBIeUwwSEc3SDBoWmw1czNIWVpkV3B5VVZk?=
 =?utf-8?B?dHpsVEEwNmJmWHJMRCtML2JzL0NCWnFab0YrWUxBVGJxQTRZVVZTNFJWMUgv?=
 =?utf-8?B?OVJQbDg2c3dNM0tKeFF3OTZWS1VCaVJNa0pwUDdCY01nQ3RlYklSa1hrU3Fj?=
 =?utf-8?B?Qm1FSlRtRlZNSDBGcXpKUnh6T0F5dGRJUC8vSlZJa2NxVmoyV1NhZXEvSVBn?=
 =?utf-8?B?bzJERVVVVHlpVWxVZUEwNSt2TFI1cGVDQUJrVmNhUWo1N2tIWldFdlFOOWpk?=
 =?utf-8?B?VUhHMFBtZzZJK0VCNDVRb1plVDhvWFloV0dGVWJRNFVFajl1UGF6cHlDeS9Y?=
 =?utf-8?B?V3NuYllGb2NDYzJLZW5aQXJuQ3g3aFkrenhZZllFeVN0bHNGOW1yLysxek1S?=
 =?utf-8?B?aHdvRGFNeFV6S09OQVQ3NS93cElTU3krRnNZR2xMN2RCZmxCZHl1MDdTOEZv?=
 =?utf-8?B?cHZFNERKVUJOZklrSk9vOXNFVnVVN1BZemU3NTJjYkVmMEl0aUlnWUlTc1Fa?=
 =?utf-8?B?NnU1dXJjb05sRXdLZTRFQjZqdi8rSXRZUW1weXdsSk9XYUdkdnZQUnpiNC9X?=
 =?utf-8?B?SC9GZk9ZaHpLdEdONnhEeUtRMjY5VnNBOEtqbUNoa2lGRFhaYnZ4T0FQd1Nq?=
 =?utf-8?B?eDIxQlVRd2huMzMxQmd4T2UxWW1LZU5xeGpHMWdOLzRrbm16VVhaVUY3SFNp?=
 =?utf-8?B?NHdKVGlQT2dvdkVROUE1M3pMWGtpbzhFdkFyUGdSZENaMHJFbVhKeFpMNUhE?=
 =?utf-8?B?aE14aWJkMHhzSExLUW84RVRSZzVuektVejdFSHJxcW5yOWNHMHh5bGFhMmlR?=
 =?utf-8?B?UndrcWtTSndSaHV0bjQ5SUFwZXoramgxTVNzb0MzVWxUMU5rK2laeVBaMzhF?=
 =?utf-8?B?YVEwVEpBZ3RhYmFLWnZzYXJ2VkJBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5832987d-9d75-4fb7-625c-08da5af08a18
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 23:30:38.3413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fnWVZV9h/8dx9daT02LWvJj95saHO73yOeGqMUAEPe/Re2yJXRilROlBJN0MI0fYaxq5EI5V1ce4bdwZoe/2Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4714
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-30_16:2022-06-28,2022-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206300090
X-Proofpoint-ORIG-GUID: 4MiW_7AlOzxpHzVbBDFR5DIVBzjaBhaM
X-Proofpoint-GUID: 4MiW_7AlOzxpHzVbBDFR5DIVBzjaBhaM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/30/22 15:44, Darrick J. Wong wrote:
> On Wed, Jun 29, 2022 at 04:53:57PM -0600, Khalid Aziz wrote:
>> mmap is used to establish address range for mshare region and map the
>> region into process's address space. Add basic mmap operation that
>> supports setting address range. Also fix code to not allocate new
>> mm_struct for files in msharefs that exist for information and not
>> for defining a new mshare region.
>>
>> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> ---
>>   mm/mshare.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 41 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/mshare.c b/mm/mshare.c
>> index d238b68b0576..088a6cab1e93 100644
>> --- a/mm/mshare.c
>> +++ b/mm/mshare.c
>> @@ -9,7 +9,8 @@
>>    *
>>    *
>>    * Copyright (C) 2022 Oracle Corp. All rights reserved.
>> - * Author:	Khalid Aziz <khalid.aziz@oracle.com>
>> + * Authors:	Khalid Aziz <khalid.aziz@oracle.com>
>> + *		Matthew Wilcox <willy@infradead.org>
>>    *
>>    */
>>   
>> @@ -60,9 +61,36 @@ msharefs_read(struct kiocb *iocb, struct iov_iter *iov)
>>   	return ret;
>>   }
>>   
>> +static int
>> +msharefs_mmap(struct file *file, struct vm_area_struct *vma)
>> +{
>> +	struct mshare_data *info = file->private_data;
>> +	struct mm_struct *mm = info->mm;
>> +
>> +	/*
>> +	 * If this mshare region has been set up once already, bail out
>> +	 */
>> +	if (mm->mmap_base != 0)
>> +		return -EINVAL;
>> +
>> +	if ((vma->vm_start | vma->vm_end) & (PGDIR_SIZE - 1))
>> +		return -EINVAL;
>> +
>> +	mm->mmap_base = vma->vm_start;
>> +	mm->task_size = vma->vm_end - vma->vm_start;
>> +	if (!mm->task_size)
>> +		mm->task_size--;
>> +	info->minfo->start = mm->mmap_base;
>> +	info->minfo->size = mm->task_size;
> 
> So, uh, if the second mmap() caller decides to ignore the mshare_info,
> should they get an -EINVAL here since the memory mappings won't be at
> the same process virtual address?

Yes, that is in patch 9. A second mmap will result in EINVAL until patch 9 irrespective of address and size passed to mmap.

> 
>> +	vma->vm_flags |= VM_SHARED_PT;
>> +	vma->vm_private_data = info;
>> +	return 0;
>> +}
>> +
>>   static const struct file_operations msharefs_file_operations = {
>>   	.open		= msharefs_open,
>>   	.read_iter	= msharefs_read,
>> +	.mmap		= msharefs_mmap,
>>   	.llseek		= no_llseek,
>>   };
>>   
>> @@ -119,7 +147,12 @@ msharefs_fill_mm(struct inode *inode)
>>   		goto err_free;
>>   	}
>>   	info->mm = mm;
>> -	info->minfo = NULL;
>> +	info->minfo = kzalloc(sizeof(struct mshare_info), GFP_KERNEL);
>> +	if (info->minfo == NULL) {
>> +		retval = -ENOMEM;
>> +		goto err_free;
>> +	}
>> +
>>   	refcount_set(&info->refcnt, 1);
>>   	inode->i_private = info;
>>   
>> @@ -128,13 +161,14 @@ msharefs_fill_mm(struct inode *inode)
>>   err_free:
>>   	if (mm)
>>   		mmput(mm);
>> +	kfree(info->minfo);
>>   	kfree(info);
>>   	return retval;
>>   }
>>   
>>   static struct inode
>>   *msharefs_get_inode(struct super_block *sb, const struct inode *dir,
>> -			umode_t mode)
>> +			umode_t mode, bool newmm)
>>   {
>>   	struct inode *inode = new_inode(sb);
>>   	if (inode) {
>> @@ -147,7 +181,7 @@ static struct inode
>>   		case S_IFREG:
>>   			inode->i_op = &msharefs_file_inode_ops;
>>   			inode->i_fop = &msharefs_file_operations;
>> -			if (msharefs_fill_mm(inode) != 0) {
>> +			if (newmm && msharefs_fill_mm(inode) != 0) {
>>   				discard_new_inode(inode);
>>   				inode = ERR_PTR(-ENOMEM);
>>   			}
>> @@ -177,7 +211,7 @@ msharefs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
>>   	struct inode *inode;
>>   	int err = 0;
>>   
>> -	inode = msharefs_get_inode(dir->i_sb, dir, mode);
>> +	inode = msharefs_get_inode(dir->i_sb, dir, mode, true);
>>   	if (IS_ERR(inode))
>>   		return PTR_ERR(inode);
>>   
>> @@ -267,7 +301,7 @@ prepopulate_files(struct super_block *s, struct inode *dir,
>>   		if (!dentry)
>>   			return -ENOMEM;
>>   
>> -		inode = msharefs_get_inode(s, dir, S_IFREG | files->mode);
>> +		inode = msharefs_get_inode(s, dir, S_IFREG | files->mode, false);
> 
> I was wondering why the information files were getting their own
> mshare_data.
> 
> TBH I'm not really sure what the difference is between mshare_data and
> mshare_info, since those names are not especially distinct.

mshare_data is superset and internal while mshare_info is what is sent back to userspace when it reads a file 
representing an mshare region.

> 
>>   		if (!inode) {
>>   			dput(dentry);
>>   			return -ENOMEM;
>> @@ -301,7 +335,7 @@ msharefs_fill_super(struct super_block *sb, struct fs_context *fc)
>>   	sb->s_d_op		= &msharefs_d_ops;
>>   	sb->s_time_gran		= 1;
>>   
>> -	inode = msharefs_get_inode(sb, NULL, S_IFDIR | 0777);
>> +	inode = msharefs_get_inode(sb, NULL, S_IFDIR | 0777, false);
> 
> Is it wise to default to world-writable?  Surely whatever userspace
> software wraps an msharefs can relax permissions as needed.
> 

Since this is for the root inode, the default is so any process can create mshare region in msharefs which I think is 
most flexible. Individual userspace app can create mshare regions with any permissions they deem fit using open(). Does 
that make sense?

Thanks,
Khalid
