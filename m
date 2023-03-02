Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D116A8C26
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 23:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjCBWrI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 17:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCBWrH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:47:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF1118A9B;
        Thu,  2 Mar 2023 14:47:06 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322K4DOY000644;
        Thu, 2 Mar 2023 21:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=xEhWOMPvDMTZk1yfc3SKYFx2bFrUG7eoCnTLwk21k4w=;
 b=bHXJzTVfjtXrdD/Cuj0UvnT7SaEYTopMcsRNtau6J3RDA+/OTZm0ZKUtZv7k13qv0kT1
 mvAwxFGFjtjqHqs/qo0XT0gKuKQ2TScFlA4jiBrZVEyZIbgk4sbBdBRJYDY/XiX/7QmS
 4GSIaLapo9u29ZUxuBb3q+lW86AOf3M0LrdGO790RaoWhjhjlQHBy8f2JriUx+0Dcm8P
 GAkHGuX9pyTaPtQCAUL3HFbj+TZcfR5MPhmmPwuqHJ4Jk93ewj1nqHAeadZJq4QOtP4K
 j56+KVXD/faImDAUWm4m0l1QRFOrW5zq/m3rl674X7wynlYrUsTIm6PhmnLYAFknd/bv Tw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb72mtdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:28:50 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322KhLXT005178;
        Thu, 2 Mar 2023 21:28:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8say8vn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:28:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjmMBVgd6iT81O6/x5WPNb2v/DF3SY+VHc4n6CdOnEdYb8008AoOlsClG16KeZGucYfJ1LZfUbF33cwL5wn9EgV6o1sLzkV53edakdgjqjHKnQg5T8guRYV/enx80mIwZECwTM2xWasucEzz01FpC0mXYxk9Oku96bZytPwxq6jHRwEfqlG0G8z4ApBXUFQW4j20mO4UNzJibHfruodWoZRXQNve+DUV8FXpHmGQrVT4FS7zTKcyW9vNi2LXKYYkyetGxwSQ/O796eLxZMPHAlJXtiOy782SZ4VkTJCipX4S0Ig0bXMQs+FJnXrkxa1RlFXzvrQrMdm7oHbDasJfUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEhWOMPvDMTZk1yfc3SKYFx2bFrUG7eoCnTLwk21k4w=;
 b=epz8C34kMh8Ow60CItBeWhukmDSwymMbGMald15AEzjuqbkt3Z+VKEioIbVcpInPRPwtvrbNfB9V3b4/iZSie/8eeadAGkfydmPohtv8qCKNT1qnqmrXLKsCsF78m4n6lxdMX6rxB6oIuoimBVVg6m0aMxwsjDS6c86XuDdrYCurAm92suEyN7yFKats8MaIRoRICeZ6ocOLpJKy1P6JJHSsVnS2t7U1NzjoI5S6CGu20jIBLuuR+vWHACVH82OF3UaSyYIu8PFZjA58u8zjksNOA/JraVyIL1AdD7WlU3H/gg9n4AoLgm85+JuaoUPWkE126+mEuDS/SJ8QbGqf7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEhWOMPvDMTZk1yfc3SKYFx2bFrUG7eoCnTLwk21k4w=;
 b=WZmxyi4hupD4sL0ZBhHwzXMO97OQ/UzHE/7SLUdYraEW1LEL44HiXBC6DE3YoZRdRczuE6h62vtwF5i/2ysRZTZMEhisn2mNfdt6Ok9fDnn/hRNlzT6yWJ5BYWF8b0/fc9fCL+3tmzqmzoe0vWHHd1UtpmeklqNaWjBDLy9vj2A=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CH3PR10MB6788.namprd10.prod.outlook.com (2603:10b6:610:14b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 21:28:47 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::2726:d898:ad59:bced]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::2726:d898:ad59:bced%4]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 21:28:47 +0000
Message-ID: <3173d8cd-108e-54b1-e72d-19f32e6adbb7@oracle.com>
Date:   Fri, 3 Mar 2023 08:28:38 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 2/3] kernfs: Use a per-fs rwsem to protect per-fs list of
 kernfs_super_info.
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        joe.jin@oracle.com
References: <20230302043203.1695051-1-imran.f.khan@oracle.com>
 <20230302043203.1695051-3-imran.f.khan@oracle.com>
 <ZADJ85K6KTb6XiR4@casper.infradead.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <ZADJ85K6KTb6XiR4@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYCPR01CA0011.ausprd01.prod.outlook.com
 (2603:10c6:10:31::23) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4468:EE_|CH3PR10MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: fb30fe71-86d7-4b31-d67d-08db1b651b86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wdzprmlyJBMq88QYGK419R8DtayMDXKoq3H297T8mCZaqk5bMXm2f/lcNfx1wV0xH+uvBWAGDDomo3eMtsJ8j2hkKiGj6QCrQjbC5DuFardvM0onpebFjGStwCBOl41hiWMP7BUzTOA4iPc8hZXsvNqJbj9ZcDerayrxW8i0xTSG4o0S32JDuehVVQsMBAPFyVPVXhk0LKLsRf9dVerdKnfO+cCukeDKlZoxVrrXERPFYHkC/inzad030O0r+j/FT317rPKHfG7Agn7EvCP2AZLud1xYFby4CH+GjLKtuWQ4qaTRG3rTmIqNn/se8sKomfSZAFW+XYP9iNsJYH7mhPQGSCTV1DENidVdKqp6LByBt90AfgdOuPTzL35wgbGAVLkF6d8FPTRCnJNsfIxMZ/NZbDHFTPdyQ3svCky74I0QHpL1Al+nLprt+rWJHyMnObD+YTOcwh3jVu+vvRuEz/aK7p+MjWJq5lhfuJ2M1t1adoAqnEz7s6erLTl/q+1TPQAi21qIsO/+icQeLQso7m1MywguNI6NtE8RBNykaci7nYCukoURSsMbIwfb/Wc8A0dZ4H9wNwDD5axZay5nseurKcpe/VLZ7YF8cAwWcolVzFBNHCwSB/gT7EWguIotbvYSgulQPPkJG8hIVcp2lTh16XCp1xJ1/5Q5tJe9AaWy9wX2Yg8E3zKR9PMipispk1vC5nN2D3/n9iBhINlJ5ygupAF+bg+ehPA7N/yYU1M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199018)(31696002)(38100700002)(86362001)(36756003)(4326008)(66556008)(6916009)(66946007)(66476007)(2906002)(31686004)(316002)(8676002)(6486002)(478600001)(26005)(6506007)(107886003)(2616005)(6666004)(53546011)(6512007)(186003)(5660300002)(83380400001)(41300700001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1N3R2tGaUMrUkdJbUk4Uno1WHJiMEcxQ21sVDNwNjUyWk9uWkFrT28rK0Er?=
 =?utf-8?B?b0Z3TC9LSHlZTHB4WEN4SXo4L3AwRjh3MklNMkhZK0lNOUFzKzNzM0ZYTWJu?=
 =?utf-8?B?c0tvc2MwZUtOZnJDaEx1K1pGRmFuTHNub0VLRHFoKzE1SWM0N3NSSWtsTVpM?=
 =?utf-8?B?eUhSUDBNdkhoTnJ0cis2NDhVN3RwRFBFTmU4dHdiSG5vVm5DZTlJMkxUNXp5?=
 =?utf-8?B?S2lERC9iODNVUHI0dnZHcHNKa1lDQnFiZWxHWFhrajZtWFF6cWJPVjFwZ1ZG?=
 =?utf-8?B?eTVuSHNqNHd1aUdEUFpYRHA4UWs3YU96OXBnczVDSWZ0dGQ0TmVnY3BZaEQx?=
 =?utf-8?B?OWR1RGpiaG5Cd3pDVjNxRW9MVDk0Rit2S1J4bHZYZ3FmVGhtc1JCcHNJQW1t?=
 =?utf-8?B?c3pLbTBqdnFXQVNvWUptUmp5MnQxUGpUSlJhV2F0UVVwL0J3dUpGREtmQjZD?=
 =?utf-8?B?WDAzYWszK1E0ZWhvZmtkVTFwajdtQWNBUUtrOCtyVVpOZU5rRE9HYVRPQmNp?=
 =?utf-8?B?K2c1NFYycW9CbWNESzRrUUtKY0tLVk0rcE5tSWlzRjZlS2FQSlJGM0hjbTJr?=
 =?utf-8?B?c2JPWStqTWRjbUsreEFpdW82SVdNeUd3dXo2RnQrcTdPcUNqRENjUjJWNWhY?=
 =?utf-8?B?RGh4b2lBSGEyT0wrWnRzVEdzWTBRK3I0czJmZFJPYVJrQUpTUnNhaHVmK3VP?=
 =?utf-8?B?OWM0b0ZvMTdtOFlpaHFqUFpndmZxcmxmbjBqY1ZQcHFyVUN6V3dLSnhtZTdF?=
 =?utf-8?B?UGIyS2xIUjVEUmVzUjNkRGorZjVQVzJGL2tDa0cvTFRLM3BxWGZGb1N6Qy9h?=
 =?utf-8?B?MWJ5dVQ0TnBHRitoUUVTYUUyWG01WmRlRTNBcGZVQkJwbWNGQ0E3UFNMRVhr?=
 =?utf-8?B?cHhETUJ0TGFoMDBhM2h1YnZoZ2FvcnZSZGNISTJSRnFTeUFQZWc3M2ZpajJ0?=
 =?utf-8?B?RHFIK01WV0xwR3NUUXBMQUlDckxKRVBkVHNQVWlzb0U1Z3JCT3RoSDRZV1Jx?=
 =?utf-8?B?SStwb0l0RWxSUUtNT1YwTWx2Zk56TjRQVnhucUg4WFYvVEVjTklvNm5jS01o?=
 =?utf-8?B?Vzl4cnV5bmVkZW8wZ0xJNk10bWc0YkdlMEhOaWFaRUJ5bnNLZmNGRFFmQ3dU?=
 =?utf-8?B?RytjZTFCVFVqbTVVRC9uTDJOakg1MndPL2JoUUswUURVTjd6ZlA2TitoaGlq?=
 =?utf-8?B?OFp3R2xRbTVTVi8rN3o0eFd6YUplcjFWdjdZNEMycXBkanc2M0FCSkVxZjUv?=
 =?utf-8?B?UlVOcWg3NnVpdm1nZ0JaeWI2bHMzM2kyM1ZrcXA1dGdXRzBWSjdLTnQxRXNk?=
 =?utf-8?B?K1lGQ0g4Zkd2V1IxSU52N05ZVEVNb0VZQzB3WC9GcGQ4TXVOMjJ6LytQSEda?=
 =?utf-8?B?Q2UySDNoekF1M0dUcmhmd0psaEhQZXJ1VUh4SWJ4OU9zL3ZEenFmUTYrd3Ja?=
 =?utf-8?B?ckZVNnh1eTZXcGpJMy9pbnRmWFV5Y3Bycko3bFE1NFZZYUtMbXVnSFFVdmU0?=
 =?utf-8?B?V3NSTlRaUk5UclYwTm9ONStuTFRmSkREYjM1eUp4MjRjTWxGSURPa3F1LzNs?=
 =?utf-8?B?c0k4WVIxZHExMVVTaC9YZFIvTEZYaGttUE01MVBUQWZPa09UdUdXM3R4anY5?=
 =?utf-8?B?N1I0QzNJdCt5NGVqeHJtRXJIRWZoYzl4cklwNGNaVkNPUHNsVFMyV1BTTlha?=
 =?utf-8?B?aUpVQ0d6WjJkMWVUblpFRGNxbHoweEIvcGwvMGw4Y2RNUUdkdndsYWo2QmE4?=
 =?utf-8?B?ak1OdDM5dUNOYzVKTTJzUUJMTDJiWkhkYUVjUFZXMnJFZWUyR2piZmlYWGhQ?=
 =?utf-8?B?Z2hnKzRIR3NqSFBWOThrOCtoVHgrZzFNcmFNWGFWLy9yVlRNNUZWT2xvcVUr?=
 =?utf-8?B?c1pZdWF3WUdnZXVLTWFTckVUdlRLZW11b0lxZFJJSjZYLzJjaVNyTHprZDE1?=
 =?utf-8?B?RGp2TmN3YTljdVR1T1g3clNNNXM1TUo1aExZMFdKV0R6V0JWb2tacHpTMzVv?=
 =?utf-8?B?RVUwbHRhZ2p1aUQ1SXZjSUZVdHJCZHE3QmViTlNJMjV2dnFDNDRVb3VTd0ly?=
 =?utf-8?B?TVk2NkhIYXN2WSthWVpoR0syWUxsMEk0YXdBZm1GbWt1RnlLT0F2SkNNNmlj?=
 =?utf-8?B?NUEyeUpoWnA4V1k3N0xBY3htMGtzZTNpWnhDQ3RHTnBGeGlxSVNBV01ZdXJT?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1LOsalwUmIGaJ9ug1yaMSvcHIctXXSh4kTJ2ZdBhHJRs4MbqjEDRImPKVlIcP+AIbCHvP41PPXvcFbWCpg9HYKjxdjK7Bubsuyi4qKF8oBbB5yVlG4S5xFyYZTcubbojR/TMIgffED2ojsqm/OmMFQIXJ6rix2nx2HoGQxwTkvpWNczUmt9IZh7+1z+LYMn0GGfuYeYi1Cq5EufdSTfs1XkyylKxFOTBtjWHU3DX8QdNNL0Gyn099x2jLX18MnA24LK6FIJuwfi39NTXXnEU0DP+R+g/eLJosHismmjwxCDFJz/PWtyAuZ01l7MJZVVA7deVpzhCKy8uMpEYVaOYWaPfxLS5YpkRW2UpPk9xVWmpx3l4as+dwIY2gTblJ6ddb13ra4acBcqsrMS1w1riEqxOG2KwDoHI3LkeYgZfKvnvxZHg99QVeGb7X4YwusNlqxxjuU6qb9jrTRImlRTJvdW9N/1CzmhufVcH8pmTXBQSlQTgbFAZwf5h+aPwCoDRv9V/ymwQ1TOwY7RE7p1hKyuIpj9sTpnQfz27Ldl6syaTa5FxHetvEYTo2ptcEnSlk7D6OFMazqK4wm0ViDSY5YUbBb+BXw3JrVBN6J+WxpIVVCPXZacFs0XxejzqT3uvsVTh7fPop1kU6vLOjmTpw6Rzg7AjJIwtpzwm4GQQoz9PVUw2YcbllmkqAl86D8OrBvsjHkoD75T9uRKx9z7iemYCC71gYwWDXVX6Al6I/KyVlJtck6qQ1XDk4KJbqaSN5hQQJc02jdl6BGT+iN99zlNEtejxIj0lOae7pMG7VbqnYtSvsp96PK+aXznt/yFy/7kCP1qssTblv1nAdfcJbsR9UV1uJocXEfNOOnvhq3pXEvWmKKhiKW0Z7u6KdRB8pAuUCu5xee/HXTx5sjDiURs6Wk6pGCJEHmwkJG8AIGE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb30fe71-86d7-4b31-d67d-08db1b651b86
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 21:28:47.3493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0aX0yxWwUhTb1mSWro73bMmOooD7+/UjTDfhHvKhv38P2mcMwXBKiUSS6PbiJTBdRqAf+QYEJcImmgZzoWiLWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020184
X-Proofpoint-ORIG-GUID: FPukBjisUWKkJvD7iIcXs3vf3kCPUGrC
X-Proofpoint-GUID: FPukBjisUWKkJvD7iIcXs3vf3kCPUGrC
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Matthew,
Thanks for reviewing this.

On 3/3/2023 3:08 am, Matthew Wilcox wrote:
> On Thu, Mar 02, 2023 at 03:32:02PM +1100, Imran Khan wrote:
>> Right now per-fs kernfs_rwsem protects list of kernfs_super_info instances
>> for a kernfs_root. Since kernfs_rwsem is used to synchronize several other
>> operations across kernfs and since most of these operations don't impact
>> kernfs_super_info, we can use a separate per-fs rwsem to synchronize access
>> to list of kernfs_super_info.
>> This helps in reducing contention around kernfs_rwsem and also allows
>> operations that change/access list of kernfs_super_info to proceed without
>> contending for kernfs_rwsem.
>>
>> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> 
> But you don't remove the acquisition of kernfs_rwsem in
> kernfs_notify_workfn(), so I don't see how this helps?
> 
Yes. kernfs_notify_workfn should no longer need kernfs_rwsem. I will fix it .
> Also, every use of this rwsem is as a writer, so it could/should be a
> plain mutex, no?  Or should you be acquiring it for read in
> kernfs_notify_workfn()?

Although currently kernfs_notify_workfn acquires kernfs_rwsem for writing, I
think even w/o this change acquiring kernfs_rwsem for reading would be enough
since we are not making any changes to kernfs_super_info list.
Based on this logic, I think taking iattr rwsem for reading is right approach.

Thanks,
Imran
