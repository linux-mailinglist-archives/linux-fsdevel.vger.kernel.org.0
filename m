Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC574599334
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 04:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344712AbiHSCwF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 22:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243176AbiHSCwD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 22:52:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E986DCCE08;
        Thu, 18 Aug 2022 19:52:02 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27J1afod016939;
        Fri, 19 Aug 2022 02:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=pINNYAZf6PhaYQNEDducsSoDg5wM1azpBv4Kts2uVX0=;
 b=rZ481c83+zfgIzKCf/tb+WlmDJtaGI0ngJ3oetYpwSY2FfAzJqM37VhrAUtenBqPv5Yp
 w1u3t3JoEUeOLBAcKFdAX5Iu5QtcAZEEhFgPsKvdWRi3CxnCIoGHiqr9R65Hg5r6hULq
 Yq8lRv4piZwcaDNEenKBN1iU09htDgMJGRSW6HPiIFQF3rlhIxhegvidJN+9yEYFNox7
 d7WWTlIB4jmCJlrN3jFwNGYNjU7n8fqHlX8eVSV7U1lccc5tRBcNGd0Vb/np0GbeQ+FN
 6myPi6002bYQZudGpv7iGkWlvXNvf5DNb7Gl+UArNwiYg55wbkGV4z9cbtO3WSp5Bbtn sw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j210m82wv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 02:51:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27J1DMwh005991;
        Fri, 19 Aug 2022 02:51:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2db4q9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 02:51:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhQCiEd32httoEnqtz35dj20YiXIEF6SlUMjVY45J2FLXoXtqmBJ6qnemcsynjwD5eZC4NeVZ3Z2t0c+amXjVXn8F3dNfQcv9zOTV95gSPJWpsKbE1FecL9xvPNI+ybfw5dcoRZPshbMP98vlEnh6rH2qgzgPC9x9FFvMdAiwLq6cbuv3XhxLBqXJLKr3CVqR4BGgRSqFdNSu/5TmxtDdKdxW/wyD+Qq8QyUXafykVDP7RoZqxVSonJBVpXVL3LSnFpZ8zQ12a9f/J1FiD8wboPWCbO9gR4Zk2IfrHHXNojiKk10QVt+naOy+bXCJGSNG6EeUI1WkDFE4BfUBpCPzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pINNYAZf6PhaYQNEDducsSoDg5wM1azpBv4Kts2uVX0=;
 b=l0z/3ZrD/K29nbN1gAtUczWx+Byay0+hNQwW8ff2UJmYi3KJVC6XZ9UtxXjlSwggqwakvI4d5riKBp+aTshT5dQum60zFAxRh/mw3Q3ls2gzMH6yOs2LE8p8N9VjEb7kKpPrsS2JjplF0/feJ4eCS2ap0abZcGDkseF9LG+gmlq1F7D99i4ITYEvQ9Xnwpnw6KfWrYVpJZZx7hRnJHD7ZQs5mHMAfNWX1ufwOtqZsNLhhRBaA2cMQRpuP2I5bgT+Kh8SISeslmIB5cOwYAxp12isngvqGTJhVD4yQxurDSIsj+tRy/gi75G88ys79GtqEiinEHe31yAiE9xa9dNYiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pINNYAZf6PhaYQNEDducsSoDg5wM1azpBv4Kts2uVX0=;
 b=VMnbdwmPBO6ZTPy9E0bcE83tleF+oUjBBRyobeA8qTEGSoYlOL5FNQJT3tQpwznsH0bWiG8ia38iGO2/aqrCbWnJRXthRYRYalmHF6mZOjFjMHN1pTFqdsISHHPGGoIfzULKtLeSmEcf48sr4TW3aPUSzuMKIbR9Y3AS65DVtrg=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DS7PR10MB5950.namprd10.prod.outlook.com (2603:10b6:8:85::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 19 Aug
 2022 02:51:51 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd%5]) with mapi id 15.20.5546.018; Fri, 19 Aug 2022
 02:51:51 +0000
Message-ID: <b7a77d4f-32de-af24-ed5c-8a3e49947c5a@oracle.com>
Date:   Thu, 18 Aug 2022 19:51:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [RFC] problems with alloc_file_pseudo() use in __nfs42_ssc_open()
Content-Language: en-US
To:     Olga Kornievskaia <aglo@umich.edu>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <Yv1jwsHVWI+lguAT@ZenIV>
 <CAN-5tyFvV7QOxyAQXu3UM5swQVB2roDpQ5CBRVc64Epp1gj9hg@mail.gmail.com>
 <Yv2BVKuzZdMDY2Td@ZenIV>
 <CAN-5tyF0ZMX8a6M6Qbbco3EmOzwVnnGZmqak8=t4Cvtzc45g7Q@mail.gmail.com>
 <CAOQ4uxgA8jD6KnbuHDevNLsjD-LbEs_y1W6uYMEY6EG_es0o+Q@mail.gmail.com>
 <Yv3Ti/niVd5ZVPP+@ZenIV>
 <CAN-5tyHpDHzmo-rSw1X+0oX0xbxR+x13eP57osB0qhFLKbXzVA@mail.gmail.com>
From:   dai.ngo@oracle.com
In-Reply-To: <CAN-5tyHpDHzmo-rSw1X+0oX0xbxR+x13eP57osB0qhFLKbXzVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0047.namprd06.prod.outlook.com
 (2603:10b6:5:54::24) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b864eae4-016e-45b1-13b4-08da818dc456
X-MS-TrafficTypeDiagnostic: DS7PR10MB5950:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VFufDssjnEKBam2gVY7EbPDg2QcT247sQydJGPBbzc9UTOTRVsjAcl0lv07DYM4UDbxh2xIBauqZyQlLNG6UQs1Qi14dN3XaIDh8ms8hbmSukvlcu8uLrRaJnVTVG6Mcr5qtuVg76VuWXAt8bqWQEb9WvXSUlKHMdwNN+EA548uQtWCDg7sDuAzATgVLfZtxCJWf+k69Rbg814tqeSddE1XIzZW6QnR2VVoDRljG+ArGpSjEa01fXbnPwff3NSa9YnXmJJYNJ38o134HMUM2XfxmqvGR2jb+4CJP579f9MDOc169yWjLXOFhjlwK118YhNwQ8uO3cx4ctk0mF2MQaoJRJRTUPu6xX/9cmeJW7rKvrF6upuSDXweQHUqfMH9S4Rgj+CugVVbsEl+ffKuwbGtxXf2zzj7ljamWFY+FSraMOlf8kYnHaP8zh3vxkBotT77yDLSCrW2W4JnKomuKA0P/aRoL0GYKy+5Yrx7YC2i0A8ZjMbIlWgBe4d53TTbhAN/veL9T6KLokE6GEIuaOCnTr71xlj4jMqyCkxORKHhlafV4gF5liYcnzfd6CrnAOIAlnooyt8nEtiqN06IvgA/MuikgyAJFcEGuFAy8PVThefet+nWzbXXuwInLVlG1Ob/+i6op3DVjw3zObk30OtPyrQoLSizDUB/nbQ+2f2iVdznPrczQJjbaqwVGQuPy1qvzzo9M/hOeqHFxPplSb6TpU01HfAc9q9kDbRxZT0v6KNKTmO9jBIwba+vFFTBp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39860400002)(136003)(366004)(396003)(186003)(83380400001)(316002)(66476007)(8676002)(38100700002)(66946007)(8936002)(5660300002)(66556008)(6506007)(6512007)(6666004)(2616005)(4326008)(53546011)(9686003)(26005)(31696002)(2906002)(41300700001)(36756003)(54906003)(478600001)(110136005)(86362001)(31686004)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVoyMWxlT1VpSEgrdk96WVp1cFFzOTl1a2N6L3JFTHdsS2U0bU0vbkliL3hB?=
 =?utf-8?B?WlZyTFF5YlhEdDN3YlVtd2l5T2E4K3B6bWgxS0o0YStWRERHRmRZeHpaYSto?=
 =?utf-8?B?NWZCaG9lSmxtemQ2TG9maGxnSEFYbXN0dnNvUC81ai9jNUFtN0pvSVZhS08x?=
 =?utf-8?B?eEtxZU5xK2U0M0pSdjNuamxoREVaQ3ZLZGZ2dEozc00ybnIza2FsUnNYN0Vw?=
 =?utf-8?B?cjRCTW9kZUVmb1ZrQWJITC96ay9RVUIrWGRTNlA1ekphalRIMUc2TWp0SWUv?=
 =?utf-8?B?enUwemlUcFZLMDg0bTVTMC84bjFBRlU1YSswRjZDUXEwS0xuSUxmaFFRaS92?=
 =?utf-8?B?VEk4NGt6MFJuclBEMldPMEU0SWpUZW1NQk52cys2TUVXa0FDeFA0eDVxWlZt?=
 =?utf-8?B?bTVEV2ZqeDJwS0UxVXpmY0ZtWSt5QkkvZktjbE0xK1d1Q1YzTmJRSzU1VGc0?=
 =?utf-8?B?bitPQ2pmSUxINzBFUWNLUmlPMDZoK3hXK1c5c3JVanRVM1BUenVJdEUyM3lH?=
 =?utf-8?B?dGtXLzM5cHNvYi9OQnZhd0NKSUs4S3pYazk0Wk5IWFRqbUdIQ3lRYUVYM0NH?=
 =?utf-8?B?cnlKSXRuYkprcUJHZGJVd2l5VE1IL05PUnVWelhVUElIUzZ2NFRzYlc4a0w1?=
 =?utf-8?B?U25hNElNVlJBZzdWcDM4cG4xYk1KS1VkWXkyRStDMmpEc2lQclBhbDlvVFl6?=
 =?utf-8?B?RWZSV1BpK3RRV3VrV052L1c0dnZlWHNTM1ZiLzdkMGc4WDNYUjg3V2d2ZTcy?=
 =?utf-8?B?UHN4K0VnZlRoZHZNVXMxb1E5OW1UTDNVQ0lyYlh4dnNXQkpZbDAwRHQrVVd6?=
 =?utf-8?B?ZFlZZWI3RWVUS0FRYjZJNzlXTTB0SjJtSEpZelFBNS95UUZmMVIxdzkwY1pL?=
 =?utf-8?B?YnNCRzlmYkNTTFhISHFnNUdPanFTUzh4cW9zcU5yRjBjWXNEVWswY1BRRjEx?=
 =?utf-8?B?Rk00Y2dHbERyOTRnMXQzdjJhT3BkTnh6QlBncW9GMTQzTHZCYzdiZDhHUmxJ?=
 =?utf-8?B?U013UlprM1pRS0hCcUdmSG5obG1hbVIyS2NEcmduMGR3VEIwQ1NEVDc5d29T?=
 =?utf-8?B?RlBTa2l0OUVOOE0xK3dlUGpBejVpdVJabExRSDRUU25PYjM4dURQMStyNXhy?=
 =?utf-8?B?S1Y4RkgvR1pybmpNNmRWR0oxbjlLUnRkbklDeWdTdm9nYmhxekQwVHhQc09B?=
 =?utf-8?B?d1RkM2xBWUowVjNFb014SG1LbGl5ZDdIQ0VzTWhwU3VERkVvM2ZEVC9IOUU3?=
 =?utf-8?B?VlcvTktQcGJuNXRhQStpL3IzMkpUVWp1R0trVVBnQ0pwbmFKUnNZOUxiaDNS?=
 =?utf-8?B?OXcwcm51ODJEUmJBdnJnSDlkaE8vMmYzQ3pvT0RiQldhVzk2Um51S2FxRjhQ?=
 =?utf-8?B?c213ak4wcjlDS1J0WXZ4djhUamFpZXp3TmtmYWpKbEM2S0g4aVNmQ0hscERm?=
 =?utf-8?B?dzB6NWUzRU1JUXgwMXdNWWZkbG0ydDAxcExFdHBsRUF1eG5PUHRFWkExYi8x?=
 =?utf-8?B?dmVpdDdhS3k2dzB4cFhBRmZqQThXd0h2Q2puTTNobE5neTlRS0NieXdXakJ4?=
 =?utf-8?B?bnpDejdYV21kUEJVMUpTWGxDd0tFZXlVU2ppQzVBSkpydE8vRnV0bVFpNDNs?=
 =?utf-8?B?b1dMTUN4cW53dXJZblMzN1RFYzBOeUdzNUozUjhmWlllc1prMDNIMlFUMEFG?=
 =?utf-8?B?ckh5dk9Ic2ppa1E0WndmWlUrL1p2cVdDRGFFNkQxSkNnVjBMV2p1M3Fvck9Y?=
 =?utf-8?B?aTNFb2pybkRrQ2ZtMUZ6R2xDYndyZ3lFTnlENk95TEs1UkczcFhKNldxMmM4?=
 =?utf-8?B?UzZYVHBIY0tZaU9ueEpkR2dNUklEelhGVWUwcy9jMkN0ekpPdTVvVGlSMlM3?=
 =?utf-8?B?UTVCamIxMnRoNkpUWm92MEZvSkwxUGc0dEY0UHRNOS92ZU5TNTdxeWhoUFZJ?=
 =?utf-8?B?RTExaE0yUFVTS0VraHh5MkJQOEJUQnQ3Y0t0MjR0Z0tFcmkzZmRZbisxQU4v?=
 =?utf-8?B?VzFuOU5CdXVkem1adVBMb1BnNFJlVkExaXRKQ2c5N09KMSs2YmcyVWZ6S3M2?=
 =?utf-8?B?enp2b21oNWRkcEdtR25PaHVLNUtPS0hTWXMyN2ZMSjJKcUxQYzFKdXY2NHky?=
 =?utf-8?Q?IsII3H6thNgaKpxgVGBToYuO8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RG50elI2V1czbTFMQytzTE13V2htVWlJZXJIVWNFa2VUK1pRbFY4YUNsL05k?=
 =?utf-8?B?QzZZKzlYcGxPSm5oTkFyYzlXYUxqNG8vYS9WU3RKWXJFcGovVGRSV2tnRGFX?=
 =?utf-8?B?cDE3ZHRvMm96OHc0aWw1WUpjYlNXSEpqV01oUTBhcnp2WUp6ZXZqcnFUWk83?=
 =?utf-8?B?UDRRSU5VS09DVk03RGtpMkZKRk9BeHQ0T0wrOVE0TURuYnNubU5tU3BhUVE5?=
 =?utf-8?B?S1ExOHZwZStSTWQvWWp0OFl4YVRrNG5VVThLTUNvVDlGNGJnc1FFOWRWRHh5?=
 =?utf-8?B?SkF5ZHFmZlcrK2NSaUZPTXVJN2JhVVY2VlV2MjNIVmF2M3k4eFpqeEM3cTNH?=
 =?utf-8?B?ZytWWGF3L0t3R1p2OXh5VzRWMzYvejFzV0YwYTh4MlhsTFQvQmRIYXJVM0R3?=
 =?utf-8?B?THFoeHVUak9uWlpCc1NTNmRzWEx3RWY0NWZQWkJrL1hvZEkvQmV6MTZIaXpH?=
 =?utf-8?B?eEowT1pBYVRqQVhBUGJ4dWczNE1CSVJmSFRSMG9lVFBNZVRtRHRwRm0zODZh?=
 =?utf-8?B?L1FvaUlRWGl3WW82M0tRcU5BNExMV3VwcDB4c0wyWlcySUdHUW5MTnE2bHN3?=
 =?utf-8?B?L0tUeFMzOVI3RENXQ1FWWDIwbVRnSHBYQnpqUUUwNXgvS1M0TjNRaU51c1M4?=
 =?utf-8?B?ZmhhdURlOTNVS29nQlA0WlZlRkljQnRYSVhxT2dwaXh5UDJWaDB0Y2d1elht?=
 =?utf-8?B?dmhXK3M2QVRyV3Z5VWJpVmFTVkNNU0pUbGNsbnRqcGtVd3lSVmFzTVZZdm9T?=
 =?utf-8?B?TXlLK2FUQnpZQ0FMR21MSXRsZHAzamIyZlBXcythN0dGUm5ObW5vYjlmVEtC?=
 =?utf-8?B?V09Tcnk5TEo1ODVCS2VhSFZ5aUIrK0lIVkllYWRrOXVTcjk5TU9lazNBeEsy?=
 =?utf-8?B?dlRHaHc1b1FMbCtUR2hSVCtFWkNxdU54MGdDcUx1K1dTblNPV1Z5am1JdlhK?=
 =?utf-8?B?OHAyWUtHQ1RkY0RhQkhieWd0RmxWUHJoL3NyaHRYbzJWZzk0bEZXWFVqUGQ0?=
 =?utf-8?B?T1hhTlU3RE1hYzQ2YU0yK3gyWFR3TjUybzQveGE2VUZUM3gxQWlQL0JQbk85?=
 =?utf-8?B?Y0pZZ2tNRkNYZ3FOZ3ZDRzErUTg2S2NhUWFJYTBqbDVmUGFvSjN6QktaM0JX?=
 =?utf-8?B?RGJURktFRWhHam5CaWpCUGsrRXluR0RXV0QrMTZNTXQrakVycnFkY1RCcEFs?=
 =?utf-8?B?amtZWnc1V3A3R3FWY0ZTcWo2elQ5Nm44eURnUEZrK0t2Z05wZTg2cWJkSWVH?=
 =?utf-8?B?SmdZc0kzTkQwZEFrNG40TlhSZW5GYlJ4a0JkaE1mSkRMNC81dDRzOGtYcWdp?=
 =?utf-8?Q?Om1lr6Y+JLlUGfxoe+7tKEOyqVFV8B63jm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b864eae4-016e-45b1-13b4-08da818dc456
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 02:51:51.2568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GiVts5o42tjQcYvpo7A8+UZSrFEc9djLzxUV+moHH/uPnr+FUqlTEp4P9dU7BXiOpVLy/496m+6oORm65yOoWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5950
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_18,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190010
X-Proofpoint-GUID: l0hHRCRWfGSjzyI5wJukQDvc5OFMh4Xy
X-Proofpoint-ORIG-GUID: l0hHRCRWfGSjzyI5wJukQDvc5OFMh4Xy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/18/22 6:13 AM, Olga Kornievskaia wrote:
> On Thu, Aug 18, 2022 at 1:52 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>> On Thu, Aug 18, 2022 at 08:19:54AM +0300, Amir Goldstein wrote:
>>
>>> NFS spec does not guarantee the safety of the server.
>>> It's like saying that the Law makes Crime impossible.
>>> The law needs to be enforced, so if server gets a request
>>> to COPY from/to an fhandle that resolves as a non-regular file
>>> (from a rogue or buggy NFS client) the server should return an
>>> error and not continue to alloc_file_pseudo().
>> FWIW, my preference would be to have alloc_file_pseudo() reject
>> directory inodes if it ever gets such.
>>
>> I'm still not sure that my (and yours, apparently) interpretation
>> of what Olga said is correct, though.
> Would it be appropriate to do the following then:
>
> diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> index e88f6b18445e..112134b6438d 100644
> --- a/fs/nfs/nfs4file.c
> +++ b/fs/nfs/nfs4file.c
> @@ -340,6 +340,11 @@ static struct file *__nfs42_ssc_open(struct
> vfsmount *ss_mnt,
>                  goto out;
>          }
>
> +       if (S_ISDIR(fattr->mode)) {
> +               res = ERR_PTR(-EBADF);
> +               goto out;
> +       }
> +

Can we also enhance nfsd4_do_async_copy to check for
-EBADF and returns nfserr_wrong_type? perhaps adding
an error mapping function to handle other errors also.

-Dai

>          res = ERR_PTR(-ENOMEM);
>          len = strlen(SSC_READ_NAME_BODY) + 16;
>          read_name = kzalloc(len, GFP_KERNEL);
> @@ -357,6 +362,7 @@ static struct file *__nfs42_ssc_open(struct
> vfsmount *ss_mnt,
>                                       r_ino->i_fop);
>          if (IS_ERR(filep)) {
>                  res = ERR_CAST(filep);
> +               iput(r_ino);
>                  goto out_free_name;
>          }
