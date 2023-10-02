Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEC97B4F89
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 11:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbjJBJwN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 05:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjJBJwL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:52:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B284983;
        Mon,  2 Oct 2023 02:52:08 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3928XSHf006444;
        Mon, 2 Oct 2023 09:51:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=6umPiMACbWstwB0R3nxuB9n5O3TqnVVUkqaOzxmeX1s=;
 b=UecrV1l3QCw9HKEToQUIHm0kvj43Ovtj/JkRVn7a7PYpwp6nl+kcE96p/G+tlx9Wc7Fz
 QA2YMEDizvl4BJm5EQxwotsbOANbpql2lRDZk71h0MuqATwbqysDe3RaXok6bgOD4lLB
 Y8cbTbktYnDV6eqTB8KUezMvMrjAfKLpx9X4L+S0zBY5xuq5M09/0ok50CL0dL/Yz2mr
 954BsUyJ4+DGBLcsZnb9K41llAyZvui9Ov2ALQlU36bFu1soz1mqBI+ZwLoQYsa3GFVv
 dTauCeB/Hjyu8BxAlamT+ZTUfnjHyxiYSMC8SJ537cKh7Gzyh+P5AjHdgv7zeSeedEv2 Sw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebqdt5he-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Oct 2023 09:51:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3929XZIL032873;
        Mon, 2 Oct 2023 09:51:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea44bh13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Oct 2023 09:51:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQa7Ji7E5QehjKLgo5KFWlOWswvDbmIHzV9TIhIya/zqIMjRJz7uvdguUI5DdkIiZ7rgPIAE50N++0DumogiXa7CDgFnM0NWtiQ3fLsodNy/H2xBpL6u7NX/N1VgSSe3sxfceaq9/EW0SKOVG3xlksgA088qoXD+KHnqPkcYjnpSmRIgSOYurywvLAh9WIR/6Q9vmiiK6DWXDyfYLK9/FqNJNRaEhZYlG/AJiG1mPBicTfR1xc3c9KTO3xdCS4go2i3fR/kH0tn7Rrged2FOENfcZSCKmMQJhewZ39k4KW076HFJmwAQdoxj8botjm8ChxLcrX9Kp23pWvGI7AVSzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6umPiMACbWstwB0R3nxuB9n5O3TqnVVUkqaOzxmeX1s=;
 b=gIOeDxKK1EDnYd+u6Gq10IDWkbSWWOLrK9teIQkPuHs5a5hSE6ALbzK8jvPtqTJODAZbzAGeIn4ZtrMEvoxoUkcVoz9nmcgnOnT49bF6OyGmOETR0y+C/k6RkWOKeu0qb5+sASQ11BizTMtlTfWEEoLKuzssffF6yZjS816Pk2g0KRtGkR1bSsx57+dLU5TiHukGLgJeip6l/UqkgU+2odlEOr/Y1zeYDlDWhVtY87YiSokCcXHsxzhCSS8hFxVrdmug1Eo76JdYh/EdIMGLXMLMaWIAd615IdRUjVfQMCffXgZufqH6N6zne9BBdLtta5XP8JVh/ffofDxKkYxcDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6umPiMACbWstwB0R3nxuB9n5O3TqnVVUkqaOzxmeX1s=;
 b=XwhYgPpLGu7BV7UvReJCzeZSIQnURguaU1f+ctlimddTlUP30wmNKweY3ZVzBJo75ZLpaZpyQACPlhav6YsXfjq5Mgrskg9I70/IWwa92aH7rAB0wEkZZjCt0JWKvFncYpQcdCX3kwFvAYGnAcFC284Og10YZ8N+dRYdlSeeZq8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6855.namprd10.prod.outlook.com (2603:10b6:208:424::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Mon, 2 Oct
 2023 09:51:42 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6838.030; Mon, 2 Oct 2023
 09:51:42 +0000
Message-ID: <d3a8b9b0-b24c-a002-e77d-56380ee785a5@oracle.com>
Date:   Mon, 2 Oct 2023 10:51:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 03/21] fs/bdev: Add atomic write support info to statx
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org,
        Prasad Singamsetty <prasad.singamsetty@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-4-john.g.garry@oracle.com>
 <20230929224922.GB11839@google.com>
 <b9c266d2-d5d6-4294-9a95-764641e295b4@acm.org>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <b9c266d2-d5d6-4294-9a95-764641e295b4@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0047.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cc33479-68a5-49f3-ccaf-08dbc32d2e6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: scAtgw77mEOv/IEPfNFh/YVMrinCyzXh6k/Rxr38ZwvYhEd81hLILSES4w92YJ2tIvX67Y5ul7m8h4/DahulNle6YIK1JXZTYRNV2kfhLf1IaJg0b+xV26SMb0m/f86o2g13PxSOiQql4EpPBw1CVShAesZOrYaX32WkKx2bUSAigmzVi5I9S1cZFcq2RFcOmwajuy1NFR//qufdly5sEF6btJebD0fefIQWd4rPrMnSMZ+d/tiyD0ZKnhwQ4c2q+/etouINFR9P3kTi4AfqOvaHNijCqeOdVaIjP+kCFwzzq6i/WJYCy7yCe49orQ9mrzFvkx1rpA/K2teNydhQvE4OygWWXAibfpbyw4g00TYf0R7ZTbcQNA/UiSXogMyOMuClvx7ZhJA5UgmDSLKziHKkNMsyJWeKFGuW/A8BgKDP9op7yWT4Iyj9ikf2TgLyjbPrsJ4t8XGITg0pipLrXjBmK6d+s2v+fwW9QyaCjogjRDT1QZGwzvNhSiaOdNK3AOPJp4g8BymYwQ6C7QhI+BlBuAGMsndHKpcTBxLouNldvvSdQCJ+Q0UNTger+G7KDd6COJmj7beZJwEr1xbAmKa/7v2ApSFBPMmi7/jQADkuGG0HMbn+yj3pE721TFyyKZgyzf89VJozAsHvLT9GIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(31686004)(66946007)(66476007)(41300700001)(5660300002)(66556008)(7416002)(8676002)(4326008)(8936002)(316002)(110136005)(2616005)(83380400001)(38100700002)(2906002)(478600001)(6486002)(107886003)(6506007)(6512007)(53546011)(31696002)(86362001)(36916002)(6666004)(26005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVluRG1WclJyMFpKc0VTZ2kySHBZVk4zcnVpUDQrWDdCeGVjVHhuR3Vvem9Z?=
 =?utf-8?B?TGE4djZhOVdVNHNSOVBjYXpnSmFDbjFrcWg2eCt0Z3VyQXV0QzErOGhCeWJM?=
 =?utf-8?B?Qnhrd0FTaTRWT2Y0MklTUnZzeWlMcGFJTHJsVUg5UW4rVDJFS0tRMlNoTDg0?=
 =?utf-8?B?VDJhckFHLzVRT3ArUzVBamFKY01uUFN1SWwrbDM3MVIvcHFPOE5DZ1lSWk55?=
 =?utf-8?B?SHBiT3hrR29ialEySTFDUm5SM3hQaGZ6VmttNnRaZkZGaDhzdDNQeXlwejdr?=
 =?utf-8?B?SXhQYzVoTzQ2YnFrTHJwM3RRWUxuSXRsd2xBa00ydG9GdHBXeHQ1Sm1KMGdD?=
 =?utf-8?B?UWRmOFhHYmJpTFByRHR4c013NGZkeFpuclkrSEx1clp6L2lJNUcwb0VzUGZo?=
 =?utf-8?B?eWdaZDhKMk83cjVQTDFDS2NvZHpKY3VRTUZpUVBsOGVKdTdUV01SK0lKNjY4?=
 =?utf-8?B?THpXSUtlRnhUUllSTEEwWlQ1RkpxcVU5Q05DYktnK0lBOUdpakxVbWttQXBC?=
 =?utf-8?B?ZzZaVEFCMVJCZVM1NTZGVm9GWWh0MDBKS2MwNVlDWU5TbGdGZ3pGZ2s2elZJ?=
 =?utf-8?B?VTdOUTczRFgzMllTOUw4YVJjVWdONnJFMDdFREdRbmJ6QzFYbThzNVNweE1T?=
 =?utf-8?B?RU1uWW14Nnd6bDBPZ3c0V2tIOThlbURyRHNVaTlNcmRwUC8weDFxNGUvNjZy?=
 =?utf-8?B?VzA0MDdxSzhzNkZqV2ZITU12SzRyKzRjL2NxSExKaWNzWXhueWZLQ0lEN0Jt?=
 =?utf-8?B?NnQ3NFVVdzFtOGNZUDFOZ0Q3WTVOSUZmRmFqZW5pTkI3OGg4dncwU1RRdWVk?=
 =?utf-8?B?UE9jRytKNTFQaXdOaGRDbXE3MTAySk1MSXZldlRpbXhTc05FZEhUVDNndTQz?=
 =?utf-8?B?ZUh5UjBlV1dNNy9tWlBUSWRSajZ2MEVJZmZSSWRxYjJEMUlGcVBPRVJjcTNn?=
 =?utf-8?B?Sml4TFBjQXBZcVZuc0xlMm1rK1pVajczR0ZaY0lNVUY2aGtjaGVXMUNsOUZy?=
 =?utf-8?B?WjdiK29EZXBFMlZzTVN2NEJENXg2T3A3QW0rbjBLUkgxVUIyQWp3YTg3aGJS?=
 =?utf-8?B?cUYxM0Q0akFyTGszNXlpbUt2d1ZOODAyZ1FpbXZZRTVEeDd1TUFZWHpvRU9S?=
 =?utf-8?B?WlZCR3llSkMwUDZzcW1kVFJrMUFkOXlrT1hoM1o2NWhMbm91OTh4OEJNeFBk?=
 =?utf-8?B?MDd6Tm1DQ3RtNmpTT1dMQzJqSGVUcDBZbGI3VGRGWUtlekQ3NUw3VkFhKzhw?=
 =?utf-8?B?M2VvcW5CRW16WDF3UVNyVVZvcDE4VmswaHJLZmNkOFFEbS9rVFkxS2tSN2pR?=
 =?utf-8?B?MjR3OVFqVUtJSzNnTFR5Z3Y1dTIrVVRwWlFpUWlmaWNVbWFoT1ZRcG9oTmRy?=
 =?utf-8?B?RVE4Z3A5UU9JWVl6RHhhdGptRjZTandDZGgvZG1jaWg3TkRIL1dvUitkWWpO?=
 =?utf-8?B?K0JHTnNkck5TcmZ0TnZmaDlSOWdnZTVYWnVXMjU4NEZqd2ZYWFliaTFTUzBL?=
 =?utf-8?B?enZVZFpYbDhwL1pZMk1XK05SZ1pweTBUNURuU05UVStNdDdwckF5L1hkbzUr?=
 =?utf-8?B?QjA3TkJ2TGVWai9ULy9KZEFKYnpJQXlBQjRhRW9SOHltcGs2SjhWaXZvUkRo?=
 =?utf-8?B?R1NWNHZITzNWaXEzUDJhcnh1eWM0NTVqZWorY3BWYi9MMlVWK1lWWWhaK0cy?=
 =?utf-8?B?SUZHKzBZRXZQUnBDQkF2MzYrUFNBS0cyWUNqVTE0enhXb1FtSHRqQmZYTWZq?=
 =?utf-8?B?Mmg3QWtJdS93U2xoMXFKbzU1Z1FrSmgzbWwweXhXamFGUWxiNlZyVkVMU0Nx?=
 =?utf-8?B?TThiNmQ1ZUFMdmNnSk9zMnd5SEtqZFY2SWRjMDZiVHB1bVhEOXJRaUYzMWxQ?=
 =?utf-8?B?Y25xS2ZLMkoxMUZYRnJIUE5aZHBKdkNSR3RlMW5wUVBvZEJjUkl1SGV0dFdZ?=
 =?utf-8?B?T0dFZENnREpzb3VPSDFhSkluWDJhdXZvcGRQTjlTVHN6QzZYWWIyUmM0eDRr?=
 =?utf-8?B?Znk0NWNkbUNUNFBnZUhjMTRlcDhDSXNZR1doTXpUeGY0TFo4T2MzSkVWeklS?=
 =?utf-8?B?Nzd2aXZpUmkydFEwRTQrUU9zYSt3Q1MrZ1AzM2ErMW42c29tR3pUSTlwL2FM?=
 =?utf-8?Q?9ZR2XeTn3knHr5RRFDs4svvpI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bE15dXdMVzVoU3c1eGpCQzhpeE1YZktUdElZUWZmYUJqNWRieHkzWTFPZ2xq?=
 =?utf-8?B?enFETm5ML1FwVjkwMWtFa2xvSWZpbVhoVXNrTmtKbXlPTWMrT1N5emVFVS9O?=
 =?utf-8?B?YWZkSjJCQUFBOU94bm9rMFQ5TGRUbDNyYkdnbEEwY1l3dHZKaUNkelQ2ZUNh?=
 =?utf-8?B?MGZlUFgzakVJdGg2V1YwZFdMeXJRV0l4bHR0dnQ4M2pjNlFVL3kxVUdKeVhk?=
 =?utf-8?B?MjRiem5NNnRHNktMTTN1OGdWK0NoZG15dk9mdGprdlpub2xZM1dla0RtK0kv?=
 =?utf-8?B?WDlTSytyRFN0Wjg4UEVsZFRlTWFmVGt2Z295a1NWZStRMERxM3k2bHhLYnly?=
 =?utf-8?B?WG92VzVzS2prQkNMOUFVcE1CaVc2RktLN2duaCs4YlRWZGlzWElSQk53VDBQ?=
 =?utf-8?B?cHptR244U001bmZIZVgwMEZjVW1QZkVnUEF2MG13NnM4WUFZTDVpSmV1QkR5?=
 =?utf-8?B?S3BPdktsa1RJTzluSUUrTFIrNXJyY3liYVB4d3ZGNTdYRVFTR2xGdWNHSkpn?=
 =?utf-8?B?aGhYTnNKQUozOWhUTHc1UEpxdVExRDhSb1Y0Q0lSNWhjMW43Q2N6Q0hSR1Vu?=
 =?utf-8?B?bW5rY2t6eXI3S2dyWnJsOTFYeEwxeXpWZTk0TmNuMDRjMXZBem9yNlNRaHpJ?=
 =?utf-8?B?dm12ZUdoYVJxTFlYOGg5ZzFnOU5JWDdDTHlra0FOdisvRE53N1BJSGxXRGJl?=
 =?utf-8?B?aVRaY1N0SVRpSndYRUY3NE56TGhDNDdSWE02RDliZGkyZkxpa3k1dEF4ZWJj?=
 =?utf-8?B?ZGNibEZiYjZFeHh5VjhFTytwa2ppUlVRa3g3SlhQcktwME10S2V3WDdESmo0?=
 =?utf-8?B?RjdhRGJ4WWg2RVBQcGRaR3RCZ1F6ZUgxMDVZSW0vVDZCVW8yd01XUE82MTgy?=
 =?utf-8?B?T3dyeHJSb1E1WkJ1T3JPQU5nT3R1SHVXVUlWVnEwbnpxS0VVL2NaYVR0YTVE?=
 =?utf-8?B?SmFXMUJlZXFENGJYdllKcXVEM2NlMGRlN2ZmZFhIc1l0dHN6N0ZzOVNBWE9D?=
 =?utf-8?B?dlBCZ1M5QnpNcTVwZHNjSVB3V290RTBMNHJCVjJIRmZBbFA3ZFAxNEdHTHF3?=
 =?utf-8?B?dm9majZEMmllWCt2aEtmRDVqZnFtTmFYWk5zUXRFdmVISzlHSEh6M0dxeTMy?=
 =?utf-8?B?TFFma3FndTk5VjFXSjhyZnpURmp6YzhMYXZKTWFsK0QybVFiU0FwZVQxYkdX?=
 =?utf-8?B?VnVhZWc0ayt6OXVxcW1jRFZrN0xvcE41ejR5dW9QeUgrcXNzVmVtTVJwbVNB?=
 =?utf-8?B?eW93YzNCbUV5OGhJcEdQL0I2Zm80dERXdFR5STNSN2YxYUFURnRUcGo3aWZR?=
 =?utf-8?B?SEw1ek5jN25LQ1BGYnRnWnZndk92QkpDK3htVy9MN3JJanJWZ1NqdWVOY0FN?=
 =?utf-8?B?dWk3TlB6R3lNTFVweFNWTlNBd25mdXdQU0xzOWtWWVdPTGtSZkc1WFlMUkI4?=
 =?utf-8?B?Q2ZUelZIQ0tPSHRWSzYvNGZrdHlDODdraVYycEhUaEhHZVltQnp0T1h1bGEr?=
 =?utf-8?Q?VP/KFA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc33479-68a5-49f3-ccaf-08dbc32d2e6e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 09:51:42.5804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9yLnI5HdSQ1Q+X5rp5aMBSm0/dHLgYWGnYegHETYerQdxK0y1RTcSxMKj+rgboMQuJDPZkhPIlrpjstGhHrEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6855
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_03,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310020072
X-Proofpoint-GUID: gobsr6150qKNK-asCfwGgfnMvqbRxr0f
X-Proofpoint-ORIG-GUID: gobsr6150qKNK-asCfwGgfnMvqbRxr0f
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/10/2023 14:23, Bart Van Assche wrote:
> On 9/29/23 15:49, Eric Biggers wrote:
>> On Fri, Sep 29, 2023 at 10:27:08AM +0000, John Garry wrote:
>>> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
>>> index 7cab2c65d3d7..c99d7cac2aa6 100644
>>> --- a/include/uapi/linux/stat.h
>>> +++ b/include/uapi/linux/stat.h
>>> @@ -127,7 +127,10 @@ struct statx {
>>>       __u32    stx_dio_mem_align;    /* Memory buffer alignment for 
>>> direct I/O */
>>>       __u32    stx_dio_offset_align;    /* File offset alignment for 
>>> direct I/O */
>>>       /* 0xa0 */
>>> -    __u64    __spare3[12];    /* Spare space for future expansion */
>>> +    __u32    stx_atomic_write_unit_max;
>>> +    __u32    stx_atomic_write_unit_min;
>>
>> Maybe min first and then max?  That seems a bit more natural, and a 
>> lot of the
>> code you've written handle them in that order.

ok, I think it's fine to reorder

>>
>>> +#define STATX_ATTR_WRITE_ATOMIC        0x00400000 /* File supports 
>>> atomic write operations */
>>
>> How would this differ from stx_atomic_write_unit_min != 0?

Yeah, I suppose that we can just not set this for the case of 
stx_atomic_write_unit_min == 0.

> 
> Is it even possible that stx_atomic_write_unit_min == 0? My understanding
> is that all Linux filesystems rely on the assumption that writing a single
> logical block either succeeds or does not happen, even if a power failure
> occurs between writing and reading a logical block.
> 

Maybe they do rely on this, but is it particularly interesting?

BTW, I would not like to provide assurances that every storage media 
produced writes logical blocks atomically.

Thanks,
John

