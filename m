Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE8340C063
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 09:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbhIOHXo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 03:23:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:21996 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236490AbhIOHXm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:23:42 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18F2nSHg025999;
        Wed, 15 Sep 2021 07:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9lCwJHNL6radI1Foc//ZPzRh6AbFJF6Tqq7LDfwJf10=;
 b=Ebbh5Ooa2MwZNY9k9V7XQf6tF7ozl+qWioghn74RuqZ50+7Qw6oLUI0XwVE6EtBybkmM
 ga4hmQMYVWAd0x/W3X4kO6RTg2fkPvPOfsOjtNZpzZKu474mKY+iosVXocSHuYcmvRRL
 taYdZcP6YJS5uZK/LZUGV49RpHgE8xiVwms8VS3trs2dAFKQg0TVRv7jzsjZYJP9E11u
 z9kRzBGiCCsF8/ffi7QB7Jw+i3tVJxNoFBSYAlfiQUMzejC/aNNoOXL13gCmpBWQXa/X
 dJmlaYeE5lyCG6Sm6SX4kgge+8toM1Ue4eKeWURNS9nQDfgJ85+OodbTEtEF03hFAqOr TQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=9lCwJHNL6radI1Foc//ZPzRh6AbFJF6Tqq7LDfwJf10=;
 b=k2TjikIhvatBh79ibujowZug8g9tLEzaLRWFwDdBq9FJ2OXd/kVDpQb7ta6cjK0sFvTC
 SCywtd3gD6tc5Ni/AfvUjygbNJxjNPNp+k0tqhyTwE1cBlVf7dHcfejlidSdKnXyiSPn
 VGDxpJY5NA/utTfANU8VEo6dE31I9Nh6R2gVgjCaVisIVstvfn3gaI79dV/c5L6jxr8c
 1jQWKTKkdzo4nWR9sAsgSEMxWvSlUO9+OAnN9KOjoRVpG6OlH/Ul05Ui7nbH0dFNJuOK
 2VLP4K2MtKyLNaFfAZuBjBLIRLVmW+HAt2NfEUE2EUT0pXrv+pIuAPQc/H0ZK4PjYYMa EA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2j4sc97t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 07:22:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18F7AZoo041774;
        Wed, 15 Sep 2021 07:22:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3030.oracle.com with ESMTP id 3b0jge76a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 07:22:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Utiy5Tv9hDK5hvmEzJLNwYnSMxHfAmmjwd4aAQKjEtJHfaMGHbSTYTFl9p3Ad47ic1CPl+gD86VYcE5C2Qo8v0TpnzecA/prGSyrH5b9sk6RKYDbtkb8P1iGSUVJPYxgNmqYwuuGIi6AjJKziDgQw9d51zZenWRQTY9QIqdhw2oqOEfDHzUzjf/sLk5B+CoZamsF3LxzfPaa1atZAtC81XUlvs1BQOjcvN99R36drTa+msh2G0prFpx6tr9iCtAUQuNsEjfQSsve6Os5VhH+fC2nbMNqZhP91SouMcrelv4C1msDDwGi27A5r1aUhV06S7ZHuv+RDXe1OxooJrQ12A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9lCwJHNL6radI1Foc//ZPzRh6AbFJF6Tqq7LDfwJf10=;
 b=JZTBgXUHsvIBzI63WbhdQLMwy0KGtGkILVIeHCAidfno5KXZabXH7TGxiSDhToY6xmLvLYIV8T/BpcVLY9Kppq4eep0cFOAThl/Zdyg/mZRGKqjJ4sXS/L5j0THexxcqeKuwi3/i8ZpR7LYPfAfmZZza2v8XE8QF3QeN8KmFuvntaa+tF6GgbpYZ7ngfY2PFwpiW+6t7sZ+RN6W2Wb+ZuX7ukkEyC+/+1nhflvrkuYCr8b/s3GSpqwlj1cGYH0uk9/uiU93PSqk4QCypMitOQZqoPTZfs725z3tcBLRm9IiDvOS7NIjlEfRfPRDhlEZdTaJgIOW6k0VwUz+StQ1LWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lCwJHNL6radI1Foc//ZPzRh6AbFJF6Tqq7LDfwJf10=;
 b=HN4vMUuqELLz7kKff35bppU6V+2Y/oWh//+drvd7cpS0VsknWk+ziBqcV03SFjOuQE5kOXLoNqMZlLLCoCH206Gd7RULgLgep5umkhCPSXkZdRp1q08QIw1x4Kb+88I3kxavpbCtevDvbF1BT4gdsggnO1iUxcNUJm+0zbAx9ns=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB3047.namprd10.prod.outlook.com (2603:10b6:a03:83::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Wed, 15 Sep
 2021 07:22:12 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c%5]) with mapi id 15.20.4500.019; Wed, 15 Sep 2021
 07:22:12 +0000
Subject: Re: [PATCH 0/3] dax: clear poison on the fly along pwrite
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20210914233132.3680546-1-jane.chu@oracle.com>
 <CAPcyv4h3KpOKgy_Cwi5fNBZmR=n1hB33mVzA3fqOY7c3G+GrMA@mail.gmail.com>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <516ecedc-38b9-1ae3-a784-289a30e5f6df@oracle.com>
Date:   Wed, 15 Sep 2021 00:22:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAPcyv4h3KpOKgy_Cwi5fNBZmR=n1hB33mVzA3fqOY7c3G+GrMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0103.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::18) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
Received: from [10.39.222.41] (138.3.201.41) by BL1PR13CA0103.namprd13.prod.outlook.com (2603:10b6:208:2b9::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend Transport; Wed, 15 Sep 2021 07:22:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54148709-c59b-4512-1e0d-08d9781988fa
X-MS-TrafficTypeDiagnostic: BYAPR10MB3047:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3047F21A0382AE03312A8F87F3DB9@BYAPR10MB3047.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ydCTjp1fV4yHgU/WeMfiwLd5aTJ3TR2vmJui+3JBKGZJLOP1Lkz35oJnx1x0XdC1P3BAhcIzVfia5yz9j3X0d2YILGRhBCdEJScyi3QArz9LgjDCRW+St9PHo9Bi7GABz2wfDvhCn6lakBf6tqnrQt7r512/MZJng9fm38Pr49XxeOD2dxqV8akcPlyUXM6EzD1abNgvQwgIKVh90KnnytQMvHglouzRJcRuRB4hgregYbVNrqhivMouoc9W2RReqD9Axo1QHoA1T2I/c1oRneWcjTeuUP6DiV7kJm+PB9uiaXtsio8vWxU/x4JxBM6kjrETJjOpqflwN9Pmit+UmBr9Fc2j1TbkyE56BZbatDtP6gW6Eyn3YIuEswimqw7ybTuEI0S13iCRWeaoLpkx63QWzo7+BXWDn5uDPTBnYXY4FlxOrFY1R1I6XRV7R7YxTlA15OrlALrx38ZcBfTRIcEKEip4VTbNoALrQaQX9CpEdgLZRStzKIh+3NV58ANRyBRFcX948m3NvwcbADcyxsAIU5XzFiglrugDbynMQXViK+rqkGSKWd/bStd/6mUSv2gZzdWCCWKdtK5bwCXbsZx6VarN1fUp1FEc05tJOfg0S/nVc6utcnwKg8pi3SGQ04XK1IcNk5gLXhn3CjN4iGR7zlZQnwReDJXYhgTzM3gTCAda2lXn/Yw/eGzNwNKfSyBTwJRmZ5vlz0OIxH9gPBy+9d3DmcFE5E38qWYGVMk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(346002)(366004)(136003)(36916002)(53546011)(186003)(5660300002)(66556008)(8676002)(8936002)(6666004)(66946007)(31696002)(16576012)(26005)(316002)(54906003)(478600001)(4326008)(86362001)(44832011)(2906002)(83380400001)(6916009)(31686004)(36756003)(7416002)(6486002)(38100700002)(66476007)(2616005)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkNrZmhrZk5MeWduLzlkS2xaQm5rKzNIa0gveEtuU0ZLT0JDekdrdWpSaFI1?=
 =?utf-8?B?Nllrb0dJaEJwWFp0dThjSnF4QWxkRFhMRm1zYzJydHhaekNqcGZ2aU13K2pD?=
 =?utf-8?B?WXQ1MXRYYW1hNTZmSFczdngrNVlGOWlIUHlIWWlqb3FiQkRPNlQ2d0g3VURH?=
 =?utf-8?B?cmp3Zmt3SGV0YmtwbVV1NVJkRzRTRnpkNHFSQnJsVC9ITVBHZ2YzQ1k0Vkla?=
 =?utf-8?B?NDhwbHVlS1BneW1FZUdURGk3dU5ETjlBOU8rNlZhYWlTQldPVGNuSFYreDJP?=
 =?utf-8?B?R1R4c0ZXQWJERWNHMDdVd3JVR3BKQXhTanN5b3NMRGpOSFZUUm1OKzBxZVdI?=
 =?utf-8?B?Q0JSd3k1MGVBaXcrbnpLaytPOGRDSnVaWHZtajVBQjNsRUM0aldLb21IZjc5?=
 =?utf-8?B?SGR2QzRzWFNaOUpVdXM0RW5leFgvbmorSG1Vc1RvN2hLWjZHaVYraVBxM1Rw?=
 =?utf-8?B?NHhGR3REYUlzRCtkM0RXWTNNVldqRUNrbmRGY05pMzRUUm9EQW03UEloY3dG?=
 =?utf-8?B?OERwZWZRNFpCenNUbDNrRWJyYUZPbjVzbWZjSUpxOTFPNUpIZmhNbzBWWDMr?=
 =?utf-8?B?cUhNSGxNRVpiZXFnSlVOMVdTSWRoZUZtS0tMQWZPMWYwVGJiSVhEb2Nraldw?=
 =?utf-8?B?UGxGOGpSK1FyY1pUV1JQR2lWMmFmeW1jZE9OQk1tTUcydFYvSVFKK2VTcm1V?=
 =?utf-8?B?Y1BKZVRlVmkzZlcyMTlrREQ5aDBrcktva2ppb3VuNUJKOGg3M2lMWUhGb2tD?=
 =?utf-8?B?NDYvN1RidTFTdW9VZGJNeE04TGhURHE2d1Vxb2RxTDErZDUvRDVNdGdJQkV5?=
 =?utf-8?B?SU85VmJIcVlJdVdOM0dySmlOVzNEVS9MNW9OaXZPeVlZTUthR1lBYnp2bjlU?=
 =?utf-8?B?bUVORldIWWFDSitiRldRWXl6anNBT29xSThiamduNkpGVUlBanN1WjZwSWYy?=
 =?utf-8?B?Z3FDS1dBV1NaRzlVSDBidC9vazFHdmlwV3FGYlRJODJ0VWxITGdibGMyaThJ?=
 =?utf-8?B?RjViT2xSOTFGNGRpNkdjOEwweHpqd285U21RS1RidklGREpXc0RrSE5jKzFp?=
 =?utf-8?B?SS9FWVBtUnEvL3RwaUcwUUg2aEVJbnN2VjZqbUR6NGZ6aGlJQWIva0Fma2k0?=
 =?utf-8?B?N0ViMkZXT2plSVdXSkpsOXVZNVYxVlpoaHpNd3ZXLzBScHo2VnZFWlVBTVA4?=
 =?utf-8?B?MnlrTzNUSzZSNkI2N09raFpsellCNEJzbmxSS05GcTRpcmFGb1cxU01ZTEov?=
 =?utf-8?B?bkhPaFJJT2U4c0doWXZHVndRbnQ4NkduSXdrSVcxRGxQeDdPbGV0cjF1TUFZ?=
 =?utf-8?B?STRYYUhHWXpMMkNrMGpyZHZSN2xia3FNS3JWMm9JeElzdnI5RHB0QS9SU0ZT?=
 =?utf-8?B?dW01VG5XNTJQcTdLbWNITmYza2hOTkh3a2RQanMzZk1iTWJleElzR1o5ckor?=
 =?utf-8?B?RFVvWW1QMWFodDhNVWtvRzJkVUp6bkM2SG9jclhGZ0ROK2h1VFFWWGV2K21p?=
 =?utf-8?B?UTNaUjRrbU1GZjNDQkxkTDlDc29oNU0vZlUzUzNSV3RoRkRmenA1VWdqa29w?=
 =?utf-8?B?RkxTMFgzNlpXcVBJbER2QjhZNS9BYzZUZXVPYk5WQW14MjFIOURJeGI3ZzJj?=
 =?utf-8?B?c2pNR2hWQkpJQ2RjTnZrRmppQ01IT21NeTZIOEYvUW5DSEt5cGNlMVI4aFFL?=
 =?utf-8?B?ZEtVemovVFl6MFdLL3BsQlMxTjF6eno3eVc5U3EwcHh1WHZSZVNUZ1NPWk1l?=
 =?utf-8?Q?bO8yZDeQSnSFsVVUQcehSZPAkdjLEfFectDgagk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54148709-c59b-4512-1e0d-08d9781988fa
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 07:22:11.9345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phVzjHYwH5a/y8KFWLEgs3ITZI/f5ARiXxQrZzlmwHPxDHDe0anJiD3A8Lt4IqhKLPzflAj2ZCNXBB6MrF/ODw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3047
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109150045
X-Proofpoint-ORIG-GUID: v9M2_e7kDlhHUnUjblzfsG0MqTItIxaN
X-Proofpoint-GUID: v9M2_e7kDlhHUnUjblzfsG0MqTItIxaN
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Dan,

On 9/14/2021 9:44 PM, Dan Williams wrote:
> On Tue, Sep 14, 2021 at 4:32 PM Jane Chu <jane.chu@oracle.com> wrote:
>>
>> If pwrite(2) encounters poison in a pmem range, it fails with EIO.
>> This is unecessary if hardware is capable of clearing the poison.
>>
>> Though not all dax backend hardware has the capability of clearing
>> poison on the fly, but dax backed by Intel DCPMEM has such capability,
>> and it's desirable to, first, speed up repairing by means of it;
>> second, maintain backend continuity instead of fragmenting it in
>> search for clean blocks.
>>
>> Jane Chu (3):
>>    dax: introduce dax_operation dax_clear_poison
> 
> The problem with new dax operations is that they need to be plumbed
> not only through fsdax and pmem, but also through device-mapper.
> 
> In this case I think we're already covered by dax_zero_page_range().
> That will ultimately trigger pmem_clear_poison() and it is routed
> through device-mapper properly.
> 
> Can you clarify why the existing dax_zero_page_range() is not sufficient?

fallocate ZERO_RANGE is in itself a functionality that applied to dax
should lead to zero out the media range.  So one may argue it is part
of a block operations, and not something explicitly aimed at clearing
poison. I'm also thinking about the MOVEDIR64B instruction and how it
might be used to clear poison on the fly with a single 'store'.
Of course, that means we need to figure out how to narrow down the
error blast radius first.

With respect to plumbing through device-mapper, I thought about that,
and wasn't sure. I mean the clear-poison work will eventually fall on
the pmem driver, and thru the DM layers, how does that play out thru
DM?  BTW, our customer doesn't care about creating dax volume thru DM, so.

thanks!
-jane


> 
>>    dax: introduce dax_clear_poison to dax pwrite operation
>>    libnvdimm/pmem: Provide pmem_dax_clear_poison for dax operation
>>
>>   drivers/dax/super.c   | 13 +++++++++++++
>>   drivers/nvdimm/pmem.c | 17 +++++++++++++++++
>>   fs/dax.c              |  9 +++++++++
>>   include/linux/dax.h   |  6 ++++++
>>   4 files changed, 45 insertions(+)
>>
>> --
>> 2.18.4
>>
