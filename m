Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD14B4B1691
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 20:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237591AbiBJTwh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 14:52:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbiBJTwg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:52:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0281B5F4D;
        Thu, 10 Feb 2022 11:52:35 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21AIfS8p013525;
        Thu, 10 Feb 2022 19:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RKrAtXQjXlfddriRgzuGCXdlKOWLRrCANG0iunTindM=;
 b=N/IfuQY2gIQjqFTdwEwUpdYwWD+4A7oJwQBnXV0SK7tDIe+mDMr4b36vMonCDKjMLSaB
 AbFvVHyAK2sPCdFNtKFsjifab5UINPaB56ft/GfwluCj1Jb2Lf6TFGoQHOWsVTCPBWoZ
 e+m1QrrQasEqWaY87oWnImI0MTAD2y2Hf7fDA+Zsw0QJ7B1GrVzj4EQesz1uIv67RKaQ
 yKI9rTDKU3aGV/TtSaQ4+qI78JW6XhjxTAszjiGNWU486FxQ3Ci5XFwp20qZ/SBltngy
 z8y+YYkWJpdNawYhn703mduSUK8u0UeaZG21hFQGFtZubjREN1hCJ9/T/31rPh7z/3HQ fg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e345su3bc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 19:52:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21AJfu8d130436;
        Thu, 10 Feb 2022 19:52:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3030.oracle.com with ESMTP id 3e1ec5q3jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 19:52:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTnIlwXX5Pilhyapq/msAtTPP2KUILU7EuSjZeBdUumHHYdR3GU37JWP2hcT3DMjcAXSy//6Pw4zDUyHcVUQUMsCzNdcEtHk7bdQpvN4X4pmydjjbv2ckB5BfvUwCwdwijfcF3IuZgOTF4QNVG9lCzbmoXn7d8ipyXE03bLNqhQls5xqH1ycJEr6Sl8NDEZia6dRo0UXprYadIfX1bv0/KmYkDqk2v+/hlNzHDlZKwj8adeM6+ZROhqyTUuPxmgJ8qtEnkqbtLZ8d/fVCQNTeZw08zaxkLfm3XUrJzv26k0VFYhI1K7xkH5+xLzLvJUbZ8XS5wPf1ZFCZLXwNQ9psA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKrAtXQjXlfddriRgzuGCXdlKOWLRrCANG0iunTindM=;
 b=oOHK/0XI13sWrkpZv1l8aBvLC76UUPwYoRTDExqNj3YoQSI43MX2vHuybDr3KpokWiAPb65gpGosdkn630g9YKdaORy0pSowRk1yJe3LAztMKJIbKAJykmEqecG17EVEV6HDjRB0+RXGXhGPk3394YzaIrbCseDboo+jBUdE2kad/3uRWAF1QKu1DAcNP/1GRFb7rVZds/mk4Nl0YrdCowqjZqdutJTd51LuW8kkQjUI71PC9pCNN+DzHRVmZE/nL/PTnVqEDt0YHmVrLkx9JyIRBKAaZoLruumUpbWEbYeO47h46dLaiZUQqYDSi3fm8+e/5PbAHde5WEwnkRGPBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKrAtXQjXlfddriRgzuGCXdlKOWLRrCANG0iunTindM=;
 b=fYLFr7FYAaSp/xLGArHngQiNrCsIX0cWb8ROpefb2eB+17m+drTkguRBMqUkBSXQ/Bw3gXnyLh7ivzrIgvTja7Q/r1SsBR5/PkjLtquVGNoEKXEY/eqDJRjk3ebuh4f+cscmw7sq70p6JkER6tVZrqs67P3ufIk14f/u8P3wnsM=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BLAPR10MB5234.namprd10.prod.outlook.com (2603:10b6:208:30c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Thu, 10 Feb
 2022 19:52:28 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::89db:be97:ee10:a192]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::89db:be97:ee10:a192%4]) with mapi id 15.20.4975.014; Thu, 10 Feb 2022
 19:52:28 +0000
Message-ID: <220b5b0e-f2f6-02c8-6e79-d0a1d819a25b@oracle.com>
Date:   Thu, 10 Feb 2022 11:52:24 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH RFC v12 3/3] nfsd: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1644468729-30383-1-git-send-email-dai.ngo@oracle.com>
 <1644468729-30383-4-git-send-email-dai.ngo@oracle.com>
 <20220210151759.GE21434@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220210151759.GE21434@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0167.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::22) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ae6527f-3a56-4eb0-f79b-08d9eccedded
X-MS-TrafficTypeDiagnostic: BLAPR10MB5234:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB52345B788CD7CA62EA08D731872F9@BLAPR10MB5234.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c0jnuBH8KUM2sf5ulXJuOj0+mFJCyznWcG2q/E/zVQqwNre0UDDBz1I05S125YTP8cTbvVfgLiyazmi6FyPxWyGyXT3B2P5QA5plohFpqpwk/tfrhBEQlxIFhpPu6xPqjOrmPx9DCcYP92ZZyJlB++17bPF+mH3ZRMnzzAmK1H1P2zM7ZRV8ntxnpteZQ6hZF+67CDi0DmhF0tCIfwjk+sBIu0tZ//7Vz+vv9S+6VSv/b4feVcP5faR0felrV0RGyIm7o4BNu6lR6q08MAW0amum/KajSvwXmeMPlGx8p3JCyzle5ANRLWJWAMFjhgQYbPHq5oG5R1TFu16m3dGRrCeXS0t4b2zXFHtrk6pU4/5JSIhNzmTY6T0jvP5TiWUbkoi6oQ2hkSb9eDfR9G1V7e+D2mSNS/zxbj7vvjKN1+i8rcPAxTe1394wK9ixs6q3RobcZA34fFsn5BK9uudaT62nRImRUYJ8JlZLZ1FM+qsb7mP4/wVv4qZBoy8Wl5QxAegZaYOG2+tDQ2zywISxFdN21nexC6wKKvn2H8p77Mu6G3T/GLv++vySOso11EOBbAbWXbmzyTJnJZ/oVRmMcO+xtm4HvQMu8VbtMl/2wZduyQ3tRDDzoXUBw8MI6He3fvlk2W54cVNJMCATm8NesEpiiaE4iB5dDvyV9rXu+OTUi+yNv4LqJaob5HP7duLzQ2sIJ/OnAr1Zd7u0yeILWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(83380400001)(508600001)(6486002)(5660300002)(30864003)(6666004)(36756003)(2906002)(6916009)(26005)(86362001)(66946007)(66476007)(4326008)(8676002)(316002)(66556008)(8936002)(9686003)(6512007)(2616005)(186003)(38100700002)(53546011)(31696002)(6506007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1kvdHZmYzRIMGYyakloUHFTTE1VSnhEY0FXSHF3Sis0M3U2K3Q0dG1valRO?=
 =?utf-8?B?dHdIYzQvMVdOeEEzeC9Gc2xnNHByL1JqVzhKckZPUUgwYWExQ3c5cVVYaDN2?=
 =?utf-8?B?M2kySnZiMWZOQWZLSW5VcWt0ZmdORFliRHdJdjdFNTRnR2RQQWJML2VsaUN3?=
 =?utf-8?B?bGhkNFVVYy96c3E3ZTN2azZJVmxJTjlFY3NFcTdaZDdMbklzbzNYOVFhUUwr?=
 =?utf-8?B?aWZQSFlTYko5Z2hraXoxVEdsRzV6TVAyYjhxdGszNnhqbWtRZmRJVm40amxk?=
 =?utf-8?B?ZWEvRDIwSjN6b29jYjdIdXBaMHNiSFVycXpnWk1HNmZodjZYMnVmQldXL1lN?=
 =?utf-8?B?Z0lnbUVHcUJwWmI1YnpOOXFKZmRsaGVzQVpmVVAxRk4ra1JoMFQrZ01peTIr?=
 =?utf-8?B?S1VpWlRBMnYxYlIvSWJSa2tsdkpURXJsWDNwcFEvV29YMEQraldYbS9sWGFF?=
 =?utf-8?B?ajJ4REIvclpEVTFLUkQ5TlluOVBJamVXM0FnejdtQW9DV1k2S2tDLyt6b1Bl?=
 =?utf-8?B?Si9mT3lqQnV2SUdnQ1JsNGs0TXZSWTRmTkJZL01BRUpxWWVNWUgzWWxwMlQ4?=
 =?utf-8?B?eXNaUDhaeUUzVGswaTBza1lGK0E3R1VITFY2RkJwUUFKOVFzVGt5SlNISnQ2?=
 =?utf-8?B?dTUxeE5uaVlJQjE5RHM5eTA0VDIvcFVVVHRJY1M0WnhGbnNkRkN6aVN0WFl6?=
 =?utf-8?B?dkRuZEFWVk1qNTdvUU9OUlIrOWJsQlVydEpoOEUvTTJmcE53RUlGTXR2K04z?=
 =?utf-8?B?U21CMUovNmlvaEdvL1hiS3VZYTVmbE53VG9LMUptWm5mbEYvS0xlTzZ5Zjkx?=
 =?utf-8?B?QVR0S0Z4U1JheDVBbDNzaFljMENZTkJRM2pCOHBTTEpod212cWp3MG82bVpo?=
 =?utf-8?B?SG5raXByTDdLdW5LdFI5dnZqWkJwa1RabXdJZjNCei9oZDE3WEFDQTVsVWNF?=
 =?utf-8?B?ZkNLa0twTjhQOTlsVFprMSszek1Na1JXc01ZbkF6L1FsaWtsclUwem1ITzJp?=
 =?utf-8?B?aGVZVGg4L0JsT0wvMEV3SU5WakJ4Q0xwNUxoMDFyN25HVHNjNFBMcllPeTZn?=
 =?utf-8?B?UXBGdWZWSHRrODM3TFNTZ3JmT051YVhZejF2V25UcCtycWxOSVY0REdVcENQ?=
 =?utf-8?B?M3FjK2dBQVlmckt6SmI0ck1hK2N4V0lyUm4xSXpCZ2x3aEFnNlI4cU5odEFs?=
 =?utf-8?B?aDNLbmJkUVI0QkFJL2UydU5wYnU4R0h4bTVybEpyM1VnL3Via2paRDNqbk56?=
 =?utf-8?B?Y2gyVlVwYjFoMWNnUmxiSzRIRWZKd3QyNjJKYnppeW1mcTJpQ1NPYmI4dnk0?=
 =?utf-8?B?NFZwQXJlMU1jWUhrd2ZGNUlFdlpWU0N2WTJkbUpEbENkeUo0REVHTUhLV29E?=
 =?utf-8?B?bDdoUVd0Nk43SWNudmYxZFdydE10WkQ3Qlk4QXNTOFhIRFNhRlUrL3BDajEw?=
 =?utf-8?B?TlY4YURZWnJWWlNIc3cxMjJOY0VwMDVqQXdPUGhndnMvVlAyUmJmK2ZhR09Q?=
 =?utf-8?B?L3hiS2ROM1Zrakw5ZG1xRTNHMkVZS0UvNkMvazlHdGxBQXlBNmVleVY3WVdj?=
 =?utf-8?B?VkU1RysxUGp2bVhxWUF0M2RLM1pPeFRWYUE3Rk8zeG96UlR0Wkl1Z1VQaWJ3?=
 =?utf-8?B?N1NROURXTDRwODJBMjF4TXBNT0Yrd3lKTjkwTVJNY2Z1RWZPaWRabTlFenpa?=
 =?utf-8?B?TjR6Uk9vaDRTY08vZDNwOEdyODBGRTRhTjR5VUtXRVVINFNoQU4yQnhmMFBy?=
 =?utf-8?B?UWhpRkptWWFWbEFocUw3MTc1REJOUEluWW4yQW5mVTlYZGlNLzg1SGhMTWJu?=
 =?utf-8?B?Mm9ZUDdhM3VuaS9wYXJ4cWZVZFo2WGpKY2VibkxqdkVnbkhqWDB3QjlobFM5?=
 =?utf-8?B?a3orRGdsV0NqU0JsOENqRXBiWFRiQWVzei9INW81dm9CL3lDOVhZVnZjeDU3?=
 =?utf-8?B?amxDQ1J3U25SY1JkWFF6a2RYS0JXTGdhZjZPbi92RW1iQ3BTQ256MFhzRHRB?=
 =?utf-8?B?T3JOM1NyOFRLRmZGU0FCaU9JaDBqNzZpRWw5Tkt4TFJRemZxd3dwTXQ5bmw3?=
 =?utf-8?B?MklPS0dQdkd4bHYrTVdWZE1kN0RJSkxXNTVKUStSZTVmSThPcXBTbmFRY3dL?=
 =?utf-8?B?dDBFOS9OamVqTWtkOWJTblpScitpVHNPWXZjb2hWUGMyWk55S0NwYk96WFlF?=
 =?utf-8?Q?Nib16FPurWE7NFskWCAYAZ8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae6527f-3a56-4eb0-f79b-08d9eccedded
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 19:52:28.4163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpkU5FIHCwEPf9REp+CA0JBE9QClJeUY+/JhwOY8ZKn5tZhOaBpy7SibztxVWQEtPMNCbi3NtFQkwGnbMjpX+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5234
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10254 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202100104
X-Proofpoint-GUID: IIWvlIRVfAvXiRlLbMeuun3iiaqfT3XB
X-Proofpoint-ORIG-GUID: IIWvlIRVfAvXiRlLbMeuun3iiaqfT3XB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2/10/22 7:17 AM, J. Bruce Fields wrote:
> Thanks for your persistence, this is a tricky project!:
>
> On Wed, Feb 09, 2022 at 08:52:09PM -0800, Dai Ngo wrote:
>> Currently an NFSv4 client must maintain its lease by using the at least
>> one of the state tokens or if nothing else, by issuing a RENEW (4.0), or
>> a singleton SEQUENCE (4.1) at least once during each lease period. If the
>> client fails to renew the lease, for any reason, the Linux server expunges
>> the state tokens immediately upon detection of the "failure to renew the
>> lease" condition and begins returning NFS4ERR_EXPIRED if the client should
>> reconnect and attempt to use the (now) expired state.
>>
>> The default lease period for the Linux server is 90 seconds.  The typical
>> client cuts that in half and will issue a lease renewing operation every
>> 45 seconds.
> CLients have a lot of leeway there, and that's a detail not important to
> this patch.  Just cut this sentence.

Fix in v13.

>
>> The 90 second lease period is very short considering the
>> potential for moderately long term network partitions.  A network partition
>> refers to any loss of network connectivity between the NFS client and the
>> NFS server, regardless of its root cause.  This includes NIC failures, NIC
>> driver bugs, network misconfigurations & administrative errors, routers &
>> switches crashing and/or having software updates applied, even down to
>> cables being physically pulled.  In most cases, these network failures are
>> transient, although the duration is unknown.
> This patch is heavy reading.  Let's not make it longer than necessary.
> I'd replace the above paragraphs by something short like:
>
> 	Problems such as hardware failures or administrative errors may
> 	cause network partitions longer than the NFSv4 lease period.
> 	Our server currently removes all client state as soon as a
> 	client fails to renew.

Fix in v13.

>
>> A server which does not immediately expunge the state on lease expiration
>> is known as a Courteous Server.  A Courteous Server continues to recognize
>> previously generated state tokens as valid until conflict arises between
>> the expired state and the requests from another client, or the server
>> reboots.
>>
>> The initial implementation of the Courteous Server will do the following:
>>
>> . When the laundromat thread detects an expired client and if that client
>> still has established state on the Linux server and there is no waiters
>> for the client's locks then deletes the client persistent record and marks
>> the client as NFSD4_CLIENT_COURTESY and skips destroying the client and
>> all of its state, otherwise destroys the client as usual.
>>
>> . Client persistent record is added to the client database when the
>> courtesy client reconnects and transits to normal client.
>>
>> . Lock/delegation/share reversation conflict with courtesy client is
>> resolved by marking the courtesy client as NFSD4_CLIENT_DESTROY_COURTESY,
>> effectively disable it, then allow the current request to proceed
>> immediately.
>>
>> . Courtesy client marked as NFSD4_CLIENT_DESTROY_COURTESY is not allowed to
>> reconnect to reuse itsstate. It is expired by the laundromat asynchronously
>> in the background.
> I haven't had a chance to read the code in detail yet.  Two things do
> jump out at me:
>
> 	- Why the two flags? (CLIENT_COURTESY and CLIENT_COURTESY_CLNT?)
> 	  Are you sure that's necessary?  If so, that could use some
> 	  documentation.
>
> 	- There is a lot of duplicated code.  For example, the code
> 	  added to find_in_sessionid_hashtable, find_clp_in_name_tree,
> 	  and find_client_in_id_table.  Any place you find yourself
> 	  repeating more than a line or two of code, please consider
> 	  factoring it out into a separate function.  That would make
> 	  this easier to read.

The CLIENT_COURTESY_CLNT flag is used to indicate the returned client
is a courtesy client so the callers can take approrpiate actions; set
it to DESTROY_COURTESY_CLIENT if it does not need it, or create the
client record if the client is to be used.

This flag was added because Chuck did not want to add another parameter,
courtesy_clnt, to find_clp_in_name_tree, find_in_sessionid_hashtbl and
find_clp_in_name_tree. Using courtesy_clnt parameter, callers of from
high-level functions; nfsd4_exchange_id, nfsd4_create_session,
nfsd4_setclientid and nfsd4_setclientid_confirm can indicate whether
it's interested in the courtesy client. This allow the low-level functions,
find_clp_in_name_tree, find_in_sessionid_hashtbl, find_clp_in_name_tree
to take appropriate action inside these functions eliminating the
duplicate code from each of the high-level functions.

I will add comment where the CLIENT_COURTESY_CLNT flag is set, if we
keep it.


-Dai

>
> --b.
>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 446 +++++++++++++++++++++++++++++++++++++++++++++++++---
>>   fs/nfsd/nfsd.h      |   1 +
>>   fs/nfsd/state.h     |   6 +
>>   3 files changed, 430 insertions(+), 23 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 1956d377d1a6..a50a670e2088 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -1917,10 +1917,27 @@ find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *net,
>>   {
>>   	struct nfsd4_session *session;
>>   	__be32 status = nfserr_badsession;
>> +	struct nfs4_client *clp;
>>   
>>   	session = __find_in_sessionid_hashtbl(sessionid, net);
>>   	if (!session)
>>   		goto out;
>> +	clp = session->se_client;
>> +	if (clp) {
>> +		clear_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
>> +		/* need to sync with thread resolving lock/deleg conflict */
>> +		spin_lock(&clp->cl_cs_lock);
>> +		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags)) {
>> +			spin_unlock(&clp->cl_cs_lock);
>> +			session = NULL;
>> +			goto out;
>> +		}
>> +		if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
>> +			clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
>> +			set_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
>> +		}
>> +		spin_unlock(&clp->cl_cs_lock);
>> +	}
>>   	status = nfsd4_get_session_locked(session);
>>   	if (status)
>>   		session = NULL;
>> @@ -1990,6 +2007,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
>>   	INIT_LIST_HEAD(&clp->cl_openowners);
>>   	INIT_LIST_HEAD(&clp->cl_delegations);
>>   	INIT_LIST_HEAD(&clp->cl_lru);
>> +	INIT_LIST_HEAD(&clp->cl_cs_list);
>>   	INIT_LIST_HEAD(&clp->cl_revoked);
>>   #ifdef CONFIG_NFSD_PNFS
>>   	INIT_LIST_HEAD(&clp->cl_lo_states);
>> @@ -1997,6 +2015,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
>>   	INIT_LIST_HEAD(&clp->async_copies);
>>   	spin_lock_init(&clp->async_lock);
>>   	spin_lock_init(&clp->cl_lock);
>> +	spin_lock_init(&clp->cl_cs_lock);
>>   	rpc_init_wait_queue(&clp->cl_cb_waitq, "Backchannel slot table");
>>   	return clp;
>>   err_no_hashtbl:
>> @@ -2394,6 +2413,10 @@ static int client_info_show(struct seq_file *m, void *v)
>>   		seq_puts(m, "status: confirmed\n");
>>   	else
>>   		seq_puts(m, "status: unconfirmed\n");
>> +	seq_printf(m, "courtesy client: %s\n",
>> +		test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags) ? "yes" : "no");
>> +	seq_printf(m, "seconds from last renew: %lld\n",
>> +		ktime_get_boottime_seconds() - clp->cl_time);
>>   	seq_printf(m, "name: ");
>>   	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
>>   	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
>> @@ -2814,8 +2837,22 @@ find_clp_in_name_tree(struct xdr_netobj *name, struct rb_root *root)
>>   			node = node->rb_left;
>>   		else if (cmp < 0)
>>   			node = node->rb_right;
>> -		else
>> +		else {
>> +			clear_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
>> +			/* sync with thread resolving lock/deleg conflict */
>> +			spin_lock(&clp->cl_cs_lock);
>> +			if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY,
>> +					&clp->cl_flags)) {
>> +				spin_unlock(&clp->cl_cs_lock);
>> +				return NULL;
>> +			}
>> +			if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
>> +				clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
>> +				set_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
>> +			}
>> +			spin_unlock(&clp->cl_cs_lock);
>>   			return clp;
>> +		}
>>   	}
>>   	return NULL;
>>   }
>> @@ -2861,6 +2898,20 @@ find_client_in_id_table(struct list_head *tbl, clientid_t *clid, bool sessions)
>>   		if (same_clid(&clp->cl_clientid, clid)) {
>>   			if ((bool)clp->cl_minorversion != sessions)
>>   				return NULL;
>> +
>> +			/* need to sync with thread resolving lock/deleg conflict */
>> +			clear_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
>> +			spin_lock(&clp->cl_cs_lock);
>> +			if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY,
>> +					&clp->cl_flags)) {
>> +				spin_unlock(&clp->cl_cs_lock);
>> +				continue;
>> +			}
>> +			if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
>> +				clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
>> +				set_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
>> +			}
>> +			spin_unlock(&clp->cl_cs_lock);
>>   			renew_client_locked(clp);
>>   			return clp;
>>   		}
>> @@ -3177,6 +3228,12 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   	/* Cases below refer to rfc 5661 section 18.35.4: */
>>   	spin_lock(&nn->client_lock);
>>   	conf = find_confirmed_client_by_name(&exid->clname, nn);
>> +	if (conf && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &conf->cl_flags)) {
>> +		spin_lock(&conf->cl_cs_lock);
>> +		set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &conf->cl_flags);
>> +		spin_unlock(&conf->cl_cs_lock);
>> +		conf = NULL;
>> +	}
>>   	if (conf) {
>>   		bool creds_match = same_creds(&conf->cl_cred, &rqstp->rq_cred);
>>   		bool verfs_match = same_verf(&verf, &conf->cl_verifier);
>> @@ -3444,6 +3501,12 @@ nfsd4_create_session(struct svc_rqst *rqstp,
>>   	spin_lock(&nn->client_lock);
>>   	unconf = find_unconfirmed_client(&cr_ses->clientid, true, nn);
>>   	conf = find_confirmed_client(&cr_ses->clientid, true, nn);
>> +	if (conf && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &conf->cl_flags)) {
>> +		spin_lock(&conf->cl_cs_lock);
>> +		set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &conf->cl_flags);
>> +		spin_unlock(&conf->cl_cs_lock);
>> +		conf = NULL;
>> +	}
>>   	WARN_ON_ONCE(conf && unconf);
>>   
>>   	if (conf) {
>> @@ -3475,6 +3538,12 @@ nfsd4_create_session(struct svc_rqst *rqstp,
>>   			goto out_free_conn;
>>   		}
>>   		old = find_confirmed_client_by_name(&unconf->cl_name, nn);
>> +		if (old && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &old->cl_flags)) {
>> +			spin_lock(&old->cl_cs_lock);
>> +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &old->cl_flags);
>> +			spin_unlock(&old->cl_cs_lock);
>> +			old = NULL;
>> +		}
>>   		if (old) {
>>   			status = mark_client_expired_locked(old);
>>   			if (status) {
>> @@ -3613,6 +3682,7 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *rqstp,
>>   	struct nfsd4_session *session;
>>   	struct net *net = SVC_NET(rqstp);
>>   	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>> +	struct nfs4_client *clp;
>>   
>>   	if (!nfsd4_last_compound_op(rqstp))
>>   		return nfserr_not_only_op;
>> @@ -3645,6 +3715,16 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *rqstp,
>>   	nfsd4_init_conn(rqstp, conn, session);
>>   	status = nfs_ok;
>>   out:
>> +	clp = session->se_client;
>> +	if (test_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags)) {
>> +		if (status == nfs_ok)
>> +			nfsd4_client_record_create(clp);
>> +		else {
>> +			spin_lock(&clp->cl_cs_lock);
>> +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
>> +			spin_unlock(&clp->cl_cs_lock);
>> +		}
>> +	}
>>   	nfsd4_put_session(session);
>>   out_no_session:
>>   	return status;
>> @@ -3667,6 +3747,7 @@ nfsd4_destroy_session(struct svc_rqst *r, struct nfsd4_compound_state *cstate,
>>   	int ref_held_by_me = 0;
>>   	struct net *net = SVC_NET(r);
>>   	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>> +	struct nfs4_client *clp;
>>   
>>   	status = nfserr_not_only_op;
>>   	if (nfsd4_compound_in_session(cstate, sessionid)) {
>> @@ -3679,6 +3760,15 @@ nfsd4_destroy_session(struct svc_rqst *r, struct nfsd4_compound_state *cstate,
>>   	ses = find_in_sessionid_hashtbl(sessionid, net, &status);
>>   	if (!ses)
>>   		goto out_client_lock;
>> +	clp = ses->se_client;
>> +	if (test_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags)) {
>> +		status = nfserr_badsession;
>> +		spin_lock(&clp->cl_cs_lock);
>> +		set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
>> +		spin_unlock(&clp->cl_cs_lock);
>> +		goto out_put_session;
>> +	}
>> +
>>   	status = nfserr_wrong_cred;
>>   	if (!nfsd4_mach_creds_match(ses->se_client, r))
>>   		goto out_put_session;
>> @@ -3783,7 +3873,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   	struct nfsd4_compoundres *resp = rqstp->rq_resp;
>>   	struct xdr_stream *xdr = resp->xdr;
>>   	struct nfsd4_session *session;
>> -	struct nfs4_client *clp;
>> +	struct nfs4_client *clp = NULL;
>>   	struct nfsd4_slot *slot;
>>   	struct nfsd4_conn *conn;
>>   	__be32 status;
>> @@ -3893,6 +3983,15 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   	if (conn)
>>   		free_conn(conn);
>>   	spin_unlock(&nn->client_lock);
>> +	if (clp && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags)) {
>> +		if (status == nfs_ok)
>> +			nfsd4_client_record_create(clp);
>> +		else {
>> +			spin_lock(&clp->cl_cs_lock);
>> +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
>> +			spin_unlock(&clp->cl_cs_lock);
>> +		}
>> +	}
>>   	return status;
>>   out_put_session:
>>   	nfsd4_put_session_locked(session);
>> @@ -3929,6 +4028,12 @@ nfsd4_destroy_clientid(struct svc_rqst *rqstp,
>>   	spin_lock(&nn->client_lock);
>>   	unconf = find_unconfirmed_client(&dc->clientid, true, nn);
>>   	conf = find_confirmed_client(&dc->clientid, true, nn);
>> +	if (conf && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &conf->cl_flags)) {
>> +		spin_lock(&conf->cl_cs_lock);
>> +		set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &conf->cl_flags);
>> +		spin_unlock(&conf->cl_cs_lock);
>> +		conf = NULL;
>> +	}
>>   	WARN_ON_ONCE(conf && unconf);
>>   
>>   	if (conf) {
>> @@ -4012,12 +4117,17 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   	struct nfs4_client	*unconf = NULL;
>>   	__be32 			status;
>>   	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>> +	struct nfs4_client *cclient = NULL;
>>   
>>   	new = create_client(clname, rqstp, &clverifier);
>>   	if (new == NULL)
>>   		return nfserr_jukebox;
>>   	spin_lock(&nn->client_lock);
>>   	conf = find_confirmed_client_by_name(&clname, nn);
>> +	if (conf && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &conf->cl_flags)) {
>> +		cclient = conf;
>> +		conf = NULL;
>> +	}
>>   	if (conf && client_has_state(conf)) {
>>   		status = nfserr_clid_inuse;
>>   		if (clp_used_exchangeid(conf))
>> @@ -4048,7 +4158,11 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   	new = NULL;
>>   	status = nfs_ok;
>>   out:
>> +	if (cclient)
>> +		unhash_client_locked(cclient);
>>   	spin_unlock(&nn->client_lock);
>> +	if (cclient)
>> +		expire_client(cclient);
>>   	if (new)
>>   		free_client(new);
>>   	if (unconf) {
>> @@ -4078,6 +4192,12 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
>>   	spin_lock(&nn->client_lock);
>>   	conf = find_confirmed_client(clid, false, nn);
>>   	unconf = find_unconfirmed_client(clid, false, nn);
>> +	if (conf && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &conf->cl_flags)) {
>> +		spin_lock(&conf->cl_cs_lock);
>> +		set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &conf->cl_flags);
>> +		spin_unlock(&conf->cl_cs_lock);
>> +		conf = NULL;
>> +	}
>>   	/*
>>   	 * We try hard to give out unique clientid's, so if we get an
>>   	 * attempt to confirm the same clientid with a different cred,
>> @@ -4108,6 +4228,13 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
>>   		nfsd4_change_callback(conf, &unconf->cl_cb_conn);
>>   	} else {
>>   		old = find_confirmed_client_by_name(&unconf->cl_name, nn);
>> +		if (old && test_bit(NFSD4_CLIENT_COURTESY_CLNT,
>> +						&old->cl_flags)) {
>> +			spin_lock(&old->cl_cs_lock);
>> +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &old->cl_flags);
>> +			spin_unlock(&old->cl_cs_lock);
>> +			old = NULL;
>> +		}
>>   		if (old) {
>>   			status = nfserr_clid_inuse;
>>   			if (client_has_state(old)
>> @@ -4691,18 +4818,41 @@ nfsd_break_deleg_cb(struct file_lock *fl)
>>   	return ret;
>>   }
>>   
>> +/*
>> + * Function returns true if lease conflict was resolved
>> + * else returns false.
>> + */
>>   static bool nfsd_breaker_owns_lease(struct file_lock *fl)
>>   {
>>   	struct nfs4_delegation *dl = fl->fl_owner;
>>   	struct svc_rqst *rqst;
>>   	struct nfs4_client *clp;
>>   
>> +	clp = dl->dl_stid.sc_client;
>> +
>> +	/*
>> +	 * need to sync with courtesy client trying to reconnect using
>> +	 * the cl_cs_lock, nn->client_lock can not be used since this
>> +	 * function is called with the fl_lck held.
>> +	 */
>> +	spin_lock(&clp->cl_cs_lock);
>> +	if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags)) {
>> +		spin_unlock(&clp->cl_cs_lock);
>> +		return true;
>> +	}
>> +	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
>> +		set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
>> +		spin_unlock(&clp->cl_cs_lock);
>> +		return true;
>> +	}
>> +	spin_unlock(&clp->cl_cs_lock);
>> +
>>   	if (!i_am_nfsd())
>> -		return NULL;
>> +		return false;
>>   	rqst = kthread_data(current);
>>   	/* Note rq_prog == NFS_ACL_PROGRAM is also possible: */
>>   	if (rqst->rq_prog != NFS_PROGRAM || rqst->rq_vers < 4)
>> -		return NULL;
>> +		return false;
>>   	clp = *(rqst->rq_lease_breaker);
>>   	return dl->dl_stid.sc_client == clp;
>>   }
>> @@ -4735,7 +4885,7 @@ static __be32 nfsd4_check_seqid(struct nfsd4_compound_state *cstate, struct nfs4
>>   }
>>   
>>   static struct nfs4_client *lookup_clientid(clientid_t *clid, bool sessions,
>> -						struct nfsd_net *nn)
>> +			struct nfsd_net *nn)
>>   {
>>   	struct nfs4_client *found;
>>   
>> @@ -4765,6 +4915,9 @@ static __be32 set_client(clientid_t *clid,
>>   	cstate->clp = lookup_clientid(clid, false, nn);
>>   	if (!cstate->clp)
>>   		return nfserr_expired;
>> +
>> +	if (test_bit(NFSD4_CLIENT_COURTESY_CLNT, &cstate->clp->cl_flags))
>> +		nfsd4_client_record_create(cstate->clp);
>>   	return nfs_ok;
>>   }
>>   
>> @@ -4917,9 +5070,89 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
>>   	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
>>   }
>>   
>> -static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>> +static bool
>> +nfs4_check_access_deny_bmap(struct nfs4_ol_stateid *stp, u32 access,
>> +			bool share_access)
>> +{
>> +	if (share_access) {
>> +		if (!stp->st_deny_bmap)
>> +			return false;
>> +
>> +		if ((stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_BOTH)) ||
>> +			(access & NFS4_SHARE_ACCESS_READ &&
>> +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_READ)) ||
>> +			(access & NFS4_SHARE_ACCESS_WRITE &&
>> +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_WRITE))) {
>> +			return true;
>> +		}
>> +		return false;
>> +	}
>> +	if ((access & NFS4_SHARE_DENY_BOTH) ||
>> +		(access & NFS4_SHARE_DENY_READ &&
>> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_READ)) ||
>> +		(access & NFS4_SHARE_DENY_WRITE &&
>> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_WRITE))) {
>> +		return true;
>> +	}
>> +	return false;
>> +}
>> +
>> +/*
>> + * This function is called to check whether nfserr_share_denied should
>> + * be returning to client.
>> + *
>> + * access:  is op_share_access if share_access is true.
>> + *	    Check if access mode, op_share_access, would conflict with
>> + *	    the current deny mode of the file 'fp'.
>> + * access:  is op_share_deny if share_access is false.
>> + *	    Check if the deny mode, op_share_deny, would conflict with
>> + *	    current access of the file 'fp'.
>> + * stp:     skip checking this entry.
>> + * new_stp: normal open, not open upgrade.
>> + *
>> + * Function returns:
>> + *	true   - access/deny mode conflict with normal client.
>> + *	false  - no conflict or conflict with courtesy client(s) is resolved.
>> + */
>> +static bool
>> +nfs4_conflict_clients(struct nfs4_file *fp, bool new_stp,
>> +		struct nfs4_ol_stateid *stp, u32 access, bool share_access)
>> +{
>> +	struct nfs4_ol_stateid *st;
>> +	struct nfs4_client *cl;
>> +	bool conflict = false;
>> +
>> +	lockdep_assert_held(&fp->fi_lock);
>> +	list_for_each_entry(st, &fp->fi_stateids, st_perfile) {
>> +		if (st->st_openstp || (st == stp && new_stp) ||
>> +			(!nfs4_check_access_deny_bmap(st,
>> +					access, share_access)))
>> +			continue;
>> +
>> +		/* need to sync with courtesy client trying to reconnect */
>> +		cl = st->st_stid.sc_client;
>> +		spin_lock(&cl->cl_cs_lock);
>> +		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &cl->cl_flags)) {
>> +			spin_unlock(&cl->cl_cs_lock);
>> +			continue;
>> +		}
>> +		if (test_bit(NFSD4_CLIENT_COURTESY, &cl->cl_flags)) {
>> +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &cl->cl_flags);
>> +			spin_unlock(&cl->cl_cs_lock);
>> +			continue;
>> +		}
>> +		/* conflict not caused by courtesy client */
>> +		spin_unlock(&cl->cl_cs_lock);
>> +		conflict = true;
>> +		break;
>> +	}
>> +	return conflict;
>> +}
>> +
>> +static __be32
>> +nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>>   		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
>> -		struct nfsd4_open *open)
>> +		struct nfsd4_open *open, bool new_stp)
>>   {
>>   	struct nfsd_file *nf = NULL;
>>   	__be32 status;
>> @@ -4935,15 +5168,29 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>>   	 */
>>   	status = nfs4_file_check_deny(fp, open->op_share_deny);
>>   	if (status != nfs_ok) {
>> -		spin_unlock(&fp->fi_lock);
>> -		goto out;
>> +		if (status != nfserr_share_denied) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>> +		if (nfs4_conflict_clients(fp, new_stp, stp,
>> +				open->op_share_deny, false)) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>>   	}
>>   
>>   	/* set access to the file */
>>   	status = nfs4_file_get_access(fp, open->op_share_access);
>>   	if (status != nfs_ok) {
>> -		spin_unlock(&fp->fi_lock);
>> -		goto out;
>> +		if (status != nfserr_share_denied) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>> +		if (nfs4_conflict_clients(fp, new_stp, stp,
>> +				open->op_share_access, true)) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>>   	}
>>   
>>   	/* Set access bits in stateid */
>> @@ -4994,7 +5241,7 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp, struct svc_fh *c
>>   	unsigned char old_deny_bmap = stp->st_deny_bmap;
>>   
>>   	if (!test_access(open->op_share_access, stp))
>> -		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open);
>> +		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open, false);
>>   
>>   	/* test and set deny mode */
>>   	spin_lock(&fp->fi_lock);
>> @@ -5343,7 +5590,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>>   			goto out;
>>   		}
>>   	} else {
>> -		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
>> +		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
>>   		if (status) {
>>   			stp->st_stid.sc_type = NFS4_CLOSED_STID;
>>   			release_open_stateid(stp);
>> @@ -5577,6 +5824,121 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
>>   }
>>   #endif
>>   
>> +static bool
>> +nfs4_anylock_blocker(struct nfs4_client *clp)
>> +{
>> +	int i;
>> +	struct nfs4_stateowner *so, *tmp;
>> +	struct nfs4_lockowner *lo;
>> +	struct nfs4_ol_stateid *stp;
>> +	struct nfs4_file *nf;
>> +	struct inode *ino;
>> +	struct file_lock_context *ctx;
>> +	struct file_lock *fl;
>> +
>> +	spin_lock(&clp->cl_lock);
>> +	for (i = 0; i < OWNER_HASH_SIZE; i++) {
>> +		/* scan each lock owner */
>> +		list_for_each_entry_safe(so, tmp, &clp->cl_ownerstr_hashtbl[i],
>> +				so_strhash) {
>> +			if (so->so_is_open_owner)
>> +				continue;
>> +
>> +			/* scan lock states of this lock owner */
>> +			lo = lockowner(so);
>> +			list_for_each_entry(stp, &lo->lo_owner.so_stateids,
>> +					st_perstateowner) {
>> +				nf = stp->st_stid.sc_file;
>> +				ino = nf->fi_inode;
>> +				ctx = ino->i_flctx;
>> +				if (!ctx)
>> +					continue;
>> +				/* check each lock belongs to this lock state */
>> +				list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
>> +					if (fl->fl_owner != lo)
>> +						continue;
>> +					if (!list_empty(&fl->fl_blocked_requests)) {
>> +						spin_unlock(&clp->cl_lock);
>> +						return true;
>> +					}
>> +				}
>> +			}
>> +		}
>> +	}
>> +	spin_unlock(&clp->cl_lock);
>> +	return false;
>> +}
>> +
>> +static void
>> +nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
>> +				struct laundry_time *lt)
>> +{
>> +	struct list_head *pos, *next;
>> +	struct nfs4_client *clp;
>> +	bool cour;
>> +	struct list_head cslist;
>> +
>> +	INIT_LIST_HEAD(reaplist);
>> +	INIT_LIST_HEAD(&cslist);
>> +	spin_lock(&nn->client_lock);
>> +	list_for_each_safe(pos, next, &nn->client_lru) {
>> +		clp = list_entry(pos, struct nfs4_client, cl_lru);
>> +		if (!state_expired(lt, clp->cl_time))
>> +			break;
>> +
>> +		/* client expired */
>> +		if (!client_has_state(clp)) {
>> +			if (mark_client_expired_locked(clp))
>> +				continue;
>> +			list_add(&clp->cl_lru, reaplist);
>> +			continue;
>> +		}
>> +
>> +		/* expired client has state */
>> +		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags))
>> +			goto exp_client;
>> +
>> +		cour = test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
>> +		if (cour &&
>> +			ktime_get_boottime_seconds() >= clp->courtesy_client_expiry)
>> +			goto exp_client;
>> +
>> +		if (nfs4_anylock_blocker(clp)) {
>> +			/* expired client has state and has blocker. */
>> +exp_client:
>> +			if (mark_client_expired_locked(clp))
>> +				continue;
>> +			list_add(&clp->cl_lru, reaplist);
>> +			continue;
>> +		}
>> +		/*
>> +		 * Client expired and has state and has no blockers.
>> +		 * If there is race condition with blockers, next time
>> +		 * the laundromat runs it will catch it and expires
>> +		 * the client.
>> +		 */
>> +		if (!cour) {
>> +			set_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
>> +			clp->courtesy_client_expiry = ktime_get_boottime_seconds() +
>> +					NFSD_COURTESY_CLIENT_TIMEOUT;
>> +			list_add(&clp->cl_cs_list, &cslist);
>> +		}
>> +	}
>> +	spin_unlock(&nn->client_lock);
>> +
>> +	list_for_each_entry(clp, &cslist, cl_cs_list) {
>> +		spin_lock(&clp->cl_cs_lock);
>> +		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags) ||
>> +			!test_bit(NFSD4_CLIENT_COURTESY,
>> +					&clp->cl_flags)) {
>> +			spin_unlock(&clp->cl_cs_lock);
>> +			continue;
>> +		}
>> +		spin_unlock(&clp->cl_cs_lock);
>> +		nfsd4_client_record_remove(clp);
>> +	}
>> +}
>> +
>>   static time64_t
>>   nfs4_laundromat(struct nfsd_net *nn)
>>   {
>> @@ -5610,16 +5972,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>>   	}
>>   	spin_unlock(&nn->s2s_cp_lock);
>>   
>> -	spin_lock(&nn->client_lock);
>> -	list_for_each_safe(pos, next, &nn->client_lru) {
>> -		clp = list_entry(pos, struct nfs4_client, cl_lru);
>> -		if (!state_expired(&lt, clp->cl_time))
>> -			break;
>> -		if (mark_client_expired_locked(clp))
>> -			continue;
>> -		list_add(&clp->cl_lru, &reaplist);
>> -	}
>> -	spin_unlock(&nn->client_lock);
>> +	nfs4_get_client_reaplist(nn, &reaplist, &lt);
>>   	list_for_each_safe(pos, next, &reaplist) {
>>   		clp = list_entry(pos, struct nfs4_client, cl_lru);
>>   		trace_nfsd_clid_purged(&clp->cl_clientid);
>> @@ -6001,6 +6354,15 @@ static __be32 find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
>>   	found = lookup_clientid(&cps->cp_p_clid, true, nn);
>>   	if (!found)
>>   		goto out;
>> +	if (test_bit(NFSD4_CLIENT_COURTESY_CLNT, &found->cl_flags)) {
>> +		spin_lock(&found->cl_cs_lock);
>> +		set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &found->cl_flags);
>> +		spin_unlock(&found->cl_cs_lock);
>> +		if (atomic_dec_and_lock(&found->cl_rpc_users,
>> +					&nn->client_lock))
>> +			spin_unlock(&nn->client_lock);
>> +		goto out;
>> +	}
>>   
>>   	*stid = find_stateid_by_type(found, &cps->cp_p_stateid,
>>   			NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID);
>> @@ -6501,6 +6863,43 @@ nfs4_transform_lock_offset(struct file_lock *lock)
>>   		lock->fl_end = OFFSET_MAX;
>>   }
>>   
>> +/**
>> + * nfsd4_fl_lock_conflict - check if lock conflict can be resolved.
>> + *
>> + * @fl: pointer to file_lock with a potential conflict
>> + * Return values:
>> + *   %true: real conflict, lock conflict can not be resolved.
>> + *   %false: no conflict, lock conflict was resolved.
>> + *
>> + * Note that this function is called while the flc_lock is held.
>> + */
>> +static bool
>> +nfsd4_fl_lock_conflict(struct file_lock *fl)
>> +{
>> +	struct nfs4_lockowner *lo;
>> +	struct nfs4_client *clp;
>> +	bool rc = true;
>> +
>> +	if (!fl)
>> +		return true;
>> +	lo = (struct nfs4_lockowner *)fl->fl_owner;
>> +	clp = lo->lo_owner.so_client;
>> +
>> +	/* need to sync with courtesy client trying to reconnect */
>> +	spin_lock(&clp->cl_cs_lock);
>> +	if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags))
>> +		rc = false;
>> +	else {
>> +		if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
>> +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
>> +			rc =  false;
>> +		} else
>> +			rc =  true;
>> +	}
>> +	spin_unlock(&clp->cl_cs_lock);
>> +	return rc;
>> +}
>> +
>>   static fl_owner_t
>>   nfsd4_fl_get_owner(fl_owner_t owner)
>>   {
>> @@ -6548,6 +6947,7 @@ static const struct lock_manager_operations nfsd_posix_mng_ops  = {
>>   	.lm_notify = nfsd4_lm_notify,
>>   	.lm_get_owner = nfsd4_fl_get_owner,
>>   	.lm_put_owner = nfsd4_fl_put_owner,
>> +	.lm_lock_conflict = nfsd4_fl_lock_conflict,
>>   };
>>   
>>   static inline void
>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>> index 498e5a489826..5e3e699c8e76 100644
>> --- a/fs/nfsd/nfsd.h
>> +++ b/fs/nfsd/nfsd.h
>> @@ -336,6 +336,7 @@ void		nfsd_lockd_shutdown(void);
>>   #define COMPOUND_ERR_SLACK_SPACE	16     /* OP_SETATTR */
>>   
>>   #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
>> +#define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
>>   
>>   /*
>>    * The following attributes are currently not supported by the NFSv4 server:
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index e73bdbb1634a..c3c65421d422 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -345,6 +345,9 @@ struct nfs4_client {
>>   #define NFSD4_CLIENT_UPCALL_LOCK	(5)	/* upcall serialization */
>>   #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
>>   					 1 << NFSD4_CLIENT_CB_KILL)
>> +#define NFSD4_CLIENT_COURTESY		(6)	/* be nice to expired client */
>> +#define NFSD4_CLIENT_DESTROY_COURTESY	(7)
>> +#define NFSD4_CLIENT_COURTESY_CLNT	(8)
>>   	unsigned long		cl_flags;
>>   	const struct cred	*cl_cb_cred;
>>   	struct rpc_clnt		*cl_cb_client;
>> @@ -385,6 +388,9 @@ struct nfs4_client {
>>   	struct list_head	async_copies;	/* list of async copies */
>>   	spinlock_t		async_lock;	/* lock for async copies */
>>   	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
>> +	int			courtesy_client_expiry;
>> +	spinlock_t		cl_cs_lock;
>> +	struct list_head	cl_cs_list;
>>   };
>>   
>>   /* struct nfs4_client_reset
>> -- 
>> 2.9.5
