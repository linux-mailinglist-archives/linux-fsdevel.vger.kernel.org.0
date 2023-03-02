Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6336A8A77
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 21:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCBUd0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 15:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjCBUdN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:33:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D513B646;
        Thu,  2 Mar 2023 12:32:27 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322K6b1T024682;
        Thu, 2 Mar 2023 20:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ZAfKoXTDxdvDUqa4+nRBNpWV7iaDTnKznZbSxTTbNKU=;
 b=Pp+SE/wHRJKd6a+GOEaPXO6WQ9dM4RpIUYQBGIwIkdtUSYYu8cgRG9dCpSgg6nvmeaUP
 JBBEqTzULPzekn2fXXYj858F7x0YWGzOPyV64jBckxiZeQesmZbFjAr5FaN53Zqh/Zu0
 vHzjsKn3ktOmgI/v2TXAWDgF2bh5w0FakLWEwthN9/7WTd8RVmdJdkUESLSGY20iTn5V
 6vYa1XhSLEkHH35xCe0UzD/2ixzRI/zKfnXXEZ/sXG3I/O1LG3vai0MpL1zf7jN9NNS8
 pqXM1UBe0cswO8XQDxhwMhlW/7qenfNfW9j+IiJLKUZELibDvYmZVd7vT62h/lnQPQhL sg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nybb2my94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 20:32:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322IpTSk000595;
        Thu, 2 Mar 2023 20:32:11 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sajk9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 20:32:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMNNFRmK9R24fkfYdDzmFHSYBP+FMCGXlWGb7j9VIg2TuQ0huCRn6ihcOYT4nXJeG/d2Pfy4x//X3bbBOYP/7CnGdNq6m4A7+DOQcv6CXaiVHZm5Pdcg68lwdleDxip6TEmyoNhRz7LdXNEQXrE0rPqqQTmNIaId1aUeeWOwYK8vWR8WCtRHnu4tiayr2UT7MnAlKNOPxrv1AV8qw1eWXLBUypgwdRGovE2B61jKeVVIwf2Unw+dmnqSXwUbECJHGTmPCm+127+PGrqOwfE31D7xzpnoOPxhpbujhx4VqGnt5vUruaz00aIQsYUHCvPREwCuqOphaCdg8qI2ETbDEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAfKoXTDxdvDUqa4+nRBNpWV7iaDTnKznZbSxTTbNKU=;
 b=fkr8VRNtmBeyK9GXnqHmVV3mWV2x4suSe00X7CPVOlHgz5ANcmBKzKjxzOTalo7iAkYPJMgorIkWlkmxS8AqKSxvPqrF0XNZv3oVxoAc3dEUZnZOYfH8eslxsCOJNz+jlKNYoFgweexlq4Qc6eH/qkl5qNialf7EUY3ErlDolmrUnC7hVn2/mPj2BRboTsi3+8niJtdoqNaFaz/dSOw/OCZXkmXqjUe9aR7+G4iJ6fk3URfwiaXAiAwNVAYJW2SZ8taLcTmm09mKMjEgnImW7EJvzJjVSXP+6Nxo3nh7gQhR7YC+buX6CGbbfIBYwV8eLXCvcHz9iiveqIDY6m/w4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAfKoXTDxdvDUqa4+nRBNpWV7iaDTnKznZbSxTTbNKU=;
 b=R0Yy+K6Od4z7nekqHXEQVPQ49/YHrn9kjo9YpmuRYsX3eqIuWYus3VaKvj7Vr18WK2TK5rEO3xq6q7QI2EZfoxms4qwU/JPCiHTf8t5V+cdwBvdLmO9O8RPW8+9qj10KIc+6wlog9bjxZjbApcyNz2W9TkUcIawywMQoKvKWYtE=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by PH7PR10MB6484.namprd10.prod.outlook.com (2603:10b6:510:1ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 20:32:09 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::2726:d898:ad59:bced]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::2726:d898:ad59:bced%4]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 20:32:09 +0000
Message-ID: <27bcb12e-453c-449e-e4f9-93ac7a3dcaa2@oracle.com>
Date:   Fri, 3 Mar 2023 07:32:00 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3] kernfs: Introduce separate rwsem to protect inode
 attributes.
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        joe.jin@oracle.com
References: <20230302043203.1695051-1-imran.f.khan@oracle.com>
 <20230302043203.1695051-2-imran.f.khan@oracle.com>
 <ZADLTO0NM1yb5ZLF@casper.infradead.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <ZADLTO0NM1yb5ZLF@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY4P282CA0016.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::26) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4468:EE_|PH7PR10MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: 3837a512-9f8f-4249-9670-08db1b5d31d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NhiHr2MM8FrySPCHfW0Li/dlltK7ApqmLzUqEgoVte4zmPut2xcXOI+6ym3YnWj/RXGXnn1NP3QOuqZCtuSg4izywkDSnskEYr403orCt/yY0c2mJ/M5F6AL7gBOplRa1juB8OsVmZrv5TN8GmJ0OnsIhLgMXJib2o/VbiLt5npZp63PbYwM6yxm16YccHg9qyD2Abodu8r1dLB/qzVPFhpyChvqvv4rn6cF3IeJWHudJsV3i8UiFTheTaRFyU4CkvxhNNwaKqNv19DTNrZdutGb4pUSJwecjAFUWTLNFUVTLQ9Rah4M4DKiZOfEbzzj4ld73i35+Eb+AwVOxo+dJPie44wjk+dgVGL4t6pfWRI7v/tnjl2iT/B5D4bp8v5cqZ0a+UT3leeviDyf4kRV7CVXpWtTg915eGAczoRHwLD6uZ+gIXfAZraotiYcToXFypEP7JhC3QG9Cv1CuZDALe5cEdxd699OsjMYEvQ4aFiEjRsxgMQpKzO5oSnjPmxCU13feRZvs4n5S1zGBbUWa6r7amGEYtOMFo+Nsr8JHcF5aw6f9aY7wudiAPDtCbal0qsbf+Fncp1/G2mTmruZ12l0HJF6V8Av+9nNJNkVgB2+lrG7ug3DVtmHqXPerSRc4MZAM4MDpR481qAJ10w3P/z9ueJ43AQmXpApJWcCQx/U9LAtI0Fty7PjcHLns4/VPkiifFT1ItqzujIPl2tBZ604fyLBXl1JU9xHECy5cKQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199018)(31686004)(36756003)(4326008)(8936002)(66476007)(66946007)(41300700001)(66556008)(8676002)(2906002)(4744005)(6916009)(5660300002)(86362001)(31696002)(38100700002)(6486002)(478600001)(107886003)(966005)(6666004)(316002)(2616005)(26005)(6512007)(83380400001)(186003)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTZ0enJZdk9jMEs0TTlua0JRYk1VbXJoS2dqR1c4M3ZCWWxyZzdPNHM2UkRq?=
 =?utf-8?B?ZDZLaWdsZVVyRFk5eWZRSTkwb3hjOUgxSHg1eW85YnVKU1FhNHJUQW5FNnhv?=
 =?utf-8?B?c2xVTWpVQVBYQTZCUGZVQ0J6STBvUEF6OU53UGZKZ2wxeGF0UTNCd1ZJbUNs?=
 =?utf-8?B?SHBKVmJSZVE2ZHpTeHJwYlhjcGM4YWpYM2VxVmZrRjMrb0xpclY4SEFPTGJm?=
 =?utf-8?B?aC8yQSs3VWdudzgzU3RzcE9uMlhmb05iUVlJZ05UaUJYSGJGZFc5TlhzQ2JC?=
 =?utf-8?B?KzMwVEtGeHkwN1JoWDNISUZLdEFjOVREQzVtZXlINzNJKzR2SmIrUXJNeURh?=
 =?utf-8?B?bm4wR2ZzVm4rd1UxMlpObDltbFVtWVRkVHRUcXBISjdxcSsvdnVDZHdJYTF1?=
 =?utf-8?B?bWtTMlJ6YmovUjRiTkkyNUpzcEVUV0EvZ2s2NGJyV3FBa1hSbm40V2E3bC92?=
 =?utf-8?B?WmxjcjZXcTVtVDFYOFdFME5EYkFXajhoeGw4WHUvUUFoK2o2WUY3TTZVWDlL?=
 =?utf-8?B?aElTRGxuWlhSK0xGNERrS0pEdnNRUjlxYmhxR1pBaFhwY0VEZFFKUUtaNUty?=
 =?utf-8?B?ekI0aWIvZ3JGMlhPbUg4cEZHT3RjS3FaUGRKL0FZc2o4UVUvZy9MS0lzNWNp?=
 =?utf-8?B?UEd6aVV3a1c1QnB6Yk1DSlNjK2FIUE91ZDE5dEo3Vm0wUCtJRHAxTzh1RzY2?=
 =?utf-8?B?ZjVyeDVFSWZmSm95NTBTR3dJUE1IeGhCUUYzQldPOExPVXZsdTNHeDRNLzVn?=
 =?utf-8?B?dXhzbVk4SkorWW94cUVuUk9DWVl6cWQ2Mm16cmM2alBnL3ByMW13dVgySmlQ?=
 =?utf-8?B?NXpHOWxUSDZPMTByMk5Ea05UOXM0V1ZBY2Q5ZThEUlg1ejFvbVVnR01TYU95?=
 =?utf-8?B?SXNsNzJjTUpxTDFRM0pxc0V2VS9FaGxaYkR6elRQU1NLQUMzcHFPWXRoemls?=
 =?utf-8?B?cFN3K3Z5bCtzMENUekZkWEhEUFYxNDVyZ1RYVDNnS1BuVExqWnViaWhkWTBo?=
 =?utf-8?B?aGx6bEZOdDA0Wm5PbW51aTRkNURHdnIwMDI2TWtRakVGcEdBOUtEUHF6aTQ3?=
 =?utf-8?B?VDJCaDR6dHYrdnYycVoyVWNoTG1LMGlrQms2MzBGazZxTnJmQ1A5cTNRZk1i?=
 =?utf-8?B?b3JPUElxTldYY2sxQThINTc1bVJhd3VKMWUrY3dSQXFzUElHdmN4Y0VpNjMr?=
 =?utf-8?B?N3U5allkRUlGUFNvblhqU3VrZTFLZ0liOUV5NVc0NWxnV0QzbGR1T091N2NM?=
 =?utf-8?B?d1FYVUNqN0trVzc4aGhlMk15MVZyQmRML2Q4Z1FvYkMvY3R0Sjh1aXhsN21X?=
 =?utf-8?B?WFhOR29JakZFZWxHUmhXM2p3RkFYZVRXM2lQcWZ4QXU5NTUvRm4xSG14N2tq?=
 =?utf-8?B?d05ka3NXSWNwU0NkeEdiMkNITjJmaTBpRDVYaVNsL0dScGRvUm0xMEhNK3cw?=
 =?utf-8?B?WGIwRzEvWjhlaWFmdHpHWi9BTnVWMXp2N3I1dlIzb2tvdndiS3hIajNQQ3p3?=
 =?utf-8?B?MmNUMENDOERhUDdzV2ZmdUhjdHhMNGlrbytUd0tNenhOV0w3ZENxM3JuaFFx?=
 =?utf-8?B?dHgzeWdGdFduRXFIdGhwTlhQTEFwMEYyWHBocWgyKzFYZDI2Y0lmb2NxZlZE?=
 =?utf-8?B?MWdlVnFvQytUSjFBV0lsL3IzY21MZ2YxbEsvOU9wbWd4YTNYQWsvaVlKN2Qv?=
 =?utf-8?B?RWQ4dzFzUzJwT0RSRWh2dEJYVjdKVXhyTEZWRVNzWFh2ZXhXaHZHNUFrQVJa?=
 =?utf-8?B?cTF2TjVtQlBWTDY3Qkg1UUd3RUNqeHpsVERYM3JMemwvS0wzaFpSU21pK3Rq?=
 =?utf-8?B?VFpxYUZ5c2dwaWhuYm9BenlJNHkxTFpwMld5ZDY0NTViZklLZXduN0o3UUNY?=
 =?utf-8?B?UnNlL2IzVXoxVFQvOCs2bC9RSFVjSG1FaTNJSFFudEhBcHgwMG5kOXZCV3Nl?=
 =?utf-8?B?ck5mNllIby9JdjQ2RlVoRWhBNko1b3BtV1pUZm5wMkdHWDFpc2U1UTJKdS9p?=
 =?utf-8?B?cE1MQ2lyWVNKanhKeHk0Mnh5Rkkwd2tXYzNYVkdlWno3dWFDZ2hlckVWTVZJ?=
 =?utf-8?B?SFZ0SEdNcWZIQ2NzNk53UmlrY3JQTUNnYUg4NkJlQXd3ZEhtK05iczlYNlQx?=
 =?utf-8?B?YUdYL1hCY0tLYm1oOS9iYUNiZGtzWEp1VWpIMjhYcnJQZUIxVG92TjN5Umkv?=
 =?utf-8?B?QkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jC2jt2g0MXjlQMytWfbjX0ktA0eXpu6MFHQSxgOMiBk2nstW/btYvg0jNv2Y9L45QZaFGVwN8+47AMzaDBwVeISh04kw+DxVzSg50vBGqtCqW1PFGGRUGmY7c1VWL7DU06OG7uASoNMpMc8+AMIT+9+qXRDhK7gqvPj62rUVY3v+9yUk/V7W+dVEJl8VWTaaOtcfRVx4wPpidX2mUtuaKniL/32WAHO6TwaDw8c2zQoF8oWpM7DOu3GLz7/3iTTXVq67nh5bj72QF6mGh6tU8F+sCyE2/qoGsO7y7zLiEmJbsXUnSsp6q29eLMBOuNRDdVPKeFUgrHG2NageJsQMumAciXTmcTPFgs2ME+q87ZgPu3NJV6blZjy5MTmqALD2ukd2Tp9VlT5Tqwec6g5VLyDoozfKY8T5jB7v3KNjYHAXNTsM5/ICVdNb1DnR8oLc/3vFXWLCZSxsyN51aBn3EIMpMwkBIMeNzrpgRinh8wekw+D7+PqiRmJOJxX/2/da3K9AjncX1NWi4A63dMsAGpcpE2M/jbxlBx5W5S+6y7elHZ7tF+x3a8yrTPDYFy23G1xhsi2/SC2VvTkEp2vJLhkkFnmdi33eVgWlDx8SUnQKS0BUJU3OT+c/3+lSI1wCaNv2Gz7/nq3Bi+BvDiKL7nqVOaVkFOFgMEMRKp304fT9ouqgUBjk6fxQptCQ11ETpCYS7qHM1Gur3GLjGVS88CuqgTWZTNs3OWRVb/IgbOrnhLFmmC6g8mXTtrXxUjVmGGJLWaEli2zNvO/enDuuKtJRDGKzyQsu9RaWRuvp05a7x3FOkbMg8PfzRXRi4u0xEsOqewN8/ls1x+4vYTEYbkJ+7P4/WQ0sp9RT2wdf7E0NlsrAjFDHfi844dAwKoePTAIGpuIbBzZCFs1jUgSCKc8U3cbIb0Y/g3PBjpESK2Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3837a512-9f8f-4249-9670-08db1b5d31d7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 20:32:08.9708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2LRH4BWhZl6O92vDVqDhoXxPAE7UrUNhh4euqTHPa7k9ya0z6r5xQ2eVWhAhJQwxdeGVdil5eznwlDJxN6xbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6484
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_13,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=792
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303020177
X-Proofpoint-GUID: qz8ir8SCR1xXP09e_pFGrUFp6uYriR-i
X-Proofpoint-ORIG-GUID: qz8ir8SCR1xXP09e_pFGrUFp6uYriR-i
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
Thanks for reviewing this,

On 3/3/2023 3:14 am, Matthew Wilcox wrote:
> On Thu, Mar 02, 2023 at 03:32:01PM +1100, Imran Khan wrote:
>> +++ b/fs/kernfs/kernfs-internal.h
>> @@ -47,6 +47,7 @@ struct kernfs_root {
>>  
>>  	wait_queue_head_t	deactivate_waitq;
>>  	struct rw_semaphore	kernfs_rwsem;
>> +	struct rw_semaphore	kernfs_iattr_rwsem;
>>  };
>>  
>>  /* +1 to avoid triggering overflow warning when negating it */
> 
> Can you explain why we want one iattr rwsem per kernfs_root instead of
> one rwsem per kernfs_node?

Having an iattr rwsem per kernfs_node would increase memory usage due to
kobjects. I had tried per kernfs_node approach for a couple of other global
locks earlier [1], but that approach was not encouraged because it would impact
ability to use sysfs on low memory (especially 32 bit) systems. This was the
reason for keeping iattr rwsem in kernfs_root.

Thanks,
Imran

[1]: https://lore.kernel.org/all/YdLH6qQNxa11YmRO@kroah.com/
