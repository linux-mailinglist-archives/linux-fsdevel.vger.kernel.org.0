Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D80700E0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 May 2023 19:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbjELRl2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 May 2023 13:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjELRl1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 May 2023 13:41:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F66D8A67;
        Fri, 12 May 2023 10:41:25 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4640032414;
        Fri, 12 May 2023 17:41:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=j0L7XojkoxHvXefZD1HNgl6VUAieNR7TcE3llzKOeDw=;
 b=3AXuddiJ5olDt0JTBo2DW3PYLwUJBlxQpwTZQJ9bomblX2Vw0m+0BKRQExz190/k391m
 hkjYhTVlFTWGMHuclhd8RnCAj/liMv1W6KRj1vaawt/jmw7YBwvvSDzk+K9zvg5kPsMW
 /42OQmpPWItT9Bn2UkDx9NBSdOBMDE9c874tcyCn/ZvEH6LxS8D7edExdG9X/xnKhSIk
 f/28IO/4gK93A+rlAkUjfZex336bUOYV5Clsb68OiSQ9/qsbEs4f5rSbozjW+k5U+SGh
 65IAh2zaeethvDXGX+yVxCnordwE+xwB/1xOYCbS9uilZdUTIqJS5h6GgMJT2vgoCt56 tg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf777bf87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 17:41:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CFtPCn004558;
        Fri, 12 May 2023 17:41:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf7pnrns3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 17:41:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVLCHEfhY+F9zDuwBKzEy5OE0czVsWf2Qv3FJD7Xn0M6xn6jJB6rfkKbHkiLkFKxdT9z+KWGoaTdbIokGJCAdocWlErEPHo61GqrQd4vHm9vINtbujpLp76O0AQLv/W8Zlgw1WRvI5KYtQP6rReM0seVqJZAnElYuUaS5iGU9Wp3j7SmRI+wkMzoS9gjHp7G5OMQP2KDjZg5BVwmTapcyvOLKgr7JHrpqLaV9KLhJLQ2sw5gnuEPe0MI085Uf1+0XUDfCnpjJVEGCdu+gSkCBBkzDbU/n1D8vkiowHxLs3tj8z4SK0Qgc6iH9FLfjObBCMKtR4PCOdcnTZYcqMHhAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0L7XojkoxHvXefZD1HNgl6VUAieNR7TcE3llzKOeDw=;
 b=KPSl735hBxHRYKv5oiBkw3m4e19SygIm8c1T2n+YexpTHPDxmiZMFXtcoNInB0zuKG7LHg12Tld1tcjUL1HXwMhvJ/33oyKPzFZ7zyLdt+/iA9TsMif84FKuX6b9SVCHaa9g8KPnDWh7yiigLlg7SG66gR0rYwaVbrxzmoLIFmq07u3lDSRJNPNXhb1NjO+48T9iq3Up3K7Wsoi4br6P9HUngepyld6tGoe9IOdus+KKar5rpjuyBLZjfN3ZPobO3wxkt8ytNhKjIdY2vIl05s11e9aTVXcev6IInks088jjgx1ag734nUB5qZIOnoL6im2yEBqgBtA20YzX7uLPTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0L7XojkoxHvXefZD1HNgl6VUAieNR7TcE3llzKOeDw=;
 b=Ug7Vbj+EyPAlbufBJ96CgSQD89e1y7XaKW1dwO2dm30oIIFxm3fcI0dBN8Xis8nuK+ELLngBz1ducLhr9KQrBEHQfyodIZfBdFaUP3R+Bzj/106rGThNLO8frcIDKBIRaN3/M0I4XvekfU4LsnYrKixKjw6Ddsn2zTd6d2SgCCw=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4751.namprd10.prod.outlook.com (2603:10b6:a03:2db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Fri, 12 May
 2023 17:41:17 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841%7]) with mapi id 15.20.6387.020; Fri, 12 May 2023
 17:41:17 +0000
Message-ID: <d36c9b9f-443e-5c05-3217-d82d62fae62a@oracle.com>
Date:   Fri, 12 May 2023 10:41:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH 3/4] NFSD: add supports for CB_GETATTR callback
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1683841383-21372-1-git-send-email-dai.ngo@oracle.com>
 <1683841383-21372-4-git-send-email-dai.ngo@oracle.com>
 <DF034103-6AFC-4696-BFD7-20039F1A4222@oracle.com>
Content-Language: en-US
From:   dai.ngo@oracle.com
In-Reply-To: <DF034103-6AFC-4696-BFD7-20039F1A4222@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:806:f2::7) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|SJ0PR10MB4751:EE_
X-MS-Office365-Filtering-Correlation-Id: b4195c1a-fe04-4b75-60f3-08db53101735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Evv4E7ws8/YwrSS0DY1C0ZvjDMhV/57uAC1RM7mQs09dAcqe2FyLdVbp78YWymWCr7JjyAtoTK33MNOXJSp1HOUy3DXZpAyXGKNegDu/51O1UmwIXTNgnowcLo5ax4q4LayH1QuRHZXG4cUAGMnHZlnuyVi3UcH/sLGrMl7KcWfrPUCQYfdfeIgK1HvOShnyr7H/KyeWk12Vse+A5r+uX0FpsG5bSTImAcXiC4SUnmu0xgf1r/7krsNy8Ze6alE2nOtkfF9gLDC8pBAyIAV1RrEW4+qY86AZJQ5mjS86700TS31+I6NR0uOqm2cSuIykxyUvbXVzTr8X+yZH9VtheRiuUGwjESlljzgkS/xx6/DMJngKipVx8fP6eAcSQ3pxHgyit1w5M39nYa9UYnsQ0smDmey9VuMCn6cwpf1BnJcL5zaaSgUKIxl0frcnNuS9I3uEDsEY40p9gHUC+/8A6xZCCeOy4q8tC5COBZZMoA2Rhd4ybAD4Ywa1kOjEFVQlKBHqBVw06h7eC5cO/3x3YLv/CkBEaXVOUIla6+UU4p6IW+bCZmLPpSfSxe/DUrqjdisd/vq9PgDa2yEtHK8dOvMnV3aGBaaMlKkvqza5B6nYc+t45t4l7BR7rQE+3A7E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199021)(86362001)(31696002)(36756003)(54906003)(316002)(37006003)(66946007)(66556008)(66476007)(4326008)(6486002)(478600001)(41300700001)(6862004)(6666004)(8936002)(5660300002)(8676002)(2906002)(38100700002)(2616005)(186003)(26005)(53546011)(6506007)(6512007)(9686003)(83380400001)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEM0cnRlNldJZytSY2dLY1hNeXJpbHRRcWpNcWJkZnNJUWRURXFFeFlRaHFG?=
 =?utf-8?B?SFdDSlo5eW9jSUl2eHJxWDNENHBKV25aQ1JHRHdHTmphN3NhVmIxVmtGOTlh?=
 =?utf-8?B?akhyUXNPWkloWkZleGdmNFR6cmo4aWhQemtPUU1FdW9OMjUxbysvaEtQSVEz?=
 =?utf-8?B?SlhaWm9vWmZZMFJWR3lhNU55bTB2Q2p5d3hVNWxFSmMrajhicHh3MVQ3ajd6?=
 =?utf-8?B?YVFWczVxdzZuSzRIQ2NXM29rSTlPY0hoa3BCNVZLT0VKNld1czBsZzR6Nzl1?=
 =?utf-8?B?d0tZUVhNd3lKSlN3S3AxSUpxZEpXaFU2djNodHZtUnhPSG5kWVVuenl2VWRq?=
 =?utf-8?B?dExDQS95TzY1NUpwcTBKZmZCUnZUNGdvUlZ6RnJmTEdMNTdtNU9KM25VUVhO?=
 =?utf-8?B?Vk83YVJJalRmN29Ib08zYTNack4yVjVOdWwrS1ZhcWphUlpLT3BZNzF0M1g2?=
 =?utf-8?B?MW13OUJxMHZ4ampmNkVDU1ozNFdQOVJiV1pNOWdwK1RkWUpLdC9IbTFybGNM?=
 =?utf-8?B?a212YkQxT1ZBZUJtUXhQZUVtNmptYVB4YlUwTHhpUytFQ0p3eU8ybGRZazgy?=
 =?utf-8?B?emx1RXB6alJOaHVSeU9OdE1qcERLeHJqRkkvQmphOXRnbjNKSzZKQnhiNzZE?=
 =?utf-8?B?QmNvcTF3Q2V2eDQzSit6R0VHdSs0MURyTGF2VzE1QUgzSTd1S1Q1VUpiNzdk?=
 =?utf-8?B?OG92SmJocmVncGFiZVdkb3E4dEpMckFDQkpDcVhXeG5BeE1tcEQvT0x0TDNL?=
 =?utf-8?B?dGhRTXN5WWVUVmZSMzVYcVI0V0l4Z1hrTmZqRWYxbHdneXhMbjBwVUJ3M2ls?=
 =?utf-8?B?Q1BLbGtPR2JuOWp3aVdwQm9INlBFUFFXZmlXbTZjQVYvT0JvVEN1TlNza3Bl?=
 =?utf-8?B?YWRzSzJ6eEFFRXlJdG9sUGVTL3JKZzBVUlppWEw1czN0cHlmWGpudmhEbkJ3?=
 =?utf-8?B?WWRzNmdCRDlONFJEemZZYlZHMnhud20wNC8xVjdZSnhwZDlnSGNKRldDME5v?=
 =?utf-8?B?SVJSdmhQeWgvaDlmenphTGNXQXFQbnNJb3MzU1d4N290b3BPd0FSTUIxclZ1?=
 =?utf-8?B?dTVPR3NjbndTT3V2R2N0UFVhamcyUkdTalAwYXBpTGpwM3hMWEx5OVgzQ1VV?=
 =?utf-8?B?citsdlJPZXFSb3JEa01OUXNqRnoxZVgrZS83SHRHeWJpRzBuZ1ZRMkZ2ZXVB?=
 =?utf-8?B?YjZLVnd1Y0ZJb0lWTzlwMWF6Q1NRMHNLdDZMekYzcnloODdtWGliT3BKdVhZ?=
 =?utf-8?B?QzhiNGxuQm9mV3JUcW1uYllnZ2lRK0x0eDYwTkZKc0x1MjJITFY0VlhWeW1O?=
 =?utf-8?B?V1VObHhVb1RERlAza092dHlxUHE5Q0V6V0FmTS9Wcyttak1CQjhDZDNQdGFC?=
 =?utf-8?B?SHRQaTN2WHRsamtRUlFncDJTUHFJSHV5bDMrVzNWQ0U1NWZJWmJSWHdacHdK?=
 =?utf-8?B?cHdFZGo2SnFyYWFQc2lYYjVMbkZoU0QzdmZjZERPbjl3TEhWbXI1NVNua1RW?=
 =?utf-8?B?WGJpOGlObSsyVWtYN3FUbGNlTitpNjdLb0E1WVRVNjQxbW52OWw1MmJWNmo5?=
 =?utf-8?B?bXUyeGdzdCszMlhWMEpsQXJtMU1iZWkzRVlvL1JpbmNVUmVKbVI2ZWNuU0Vm?=
 =?utf-8?B?NUJiUENqS0s5L1RGUW9rZG5jcnpUT0NreENocTRWZisvc3NpdWNaY0I4UWpz?=
 =?utf-8?B?dWlPNUUyOXBwUit4VjVWT3pWSVk3VnhPTkR0dnlsTUdMdnRlT3FkQ2RJTlV5?=
 =?utf-8?B?dzlQUEhWdXczazVReUg0dnQzV1JoMzNJdFVZN3UzS29ZdmcvR2RZdzBQVW4r?=
 =?utf-8?B?ZUQwVmhMdGN3M3Ywd1o5Q2NmdUQrYmVhaDRiMTlmdEREZDVVczMxUXhHdFA1?=
 =?utf-8?B?akNia1dia3U2cjk5VTdXaERsei85OThZTXU3SzFkUml6cFVXQjRFeE85dzA4?=
 =?utf-8?B?bzVERFE1cG85LzF4djVWK1hReDdUK2FEd1dSd0pxWnlkaTNYTGhIcm5GR09l?=
 =?utf-8?B?dkR3c08xaDBja0JyRld2OVRUVVc1dy8xQVpqdndZQmE2VXFlRUxhcCs4bVFM?=
 =?utf-8?B?OFJaNFhDVnVoTHhMNU03dlh0N1luQmx2dHVqRFFBR09tbGk0bEFmd2RLSzJ0?=
 =?utf-8?Q?unIM/OvXu0qw1SFi/wLW4qgRP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FhCnJfRYySeQALmJbatSyxlB2fRdsgnteVmHzsfj3Xfk7K/zYVTTjONlwVVp3s+k2MfYdlbQTE5aDCsD6y5KISGoz05gc81DW//VvjgXt/dDrs64JsqJgDimz8YLTy3RUgLKUt36Fy4+c/f0VlDWtTMSDKDkeZoEf1+fusGtzOINlpIpkHO2ZSq8pUhMe7BvSKtvUGCo3uiFaPKu/R52JEZ4BW8igJXmZkeM83Px7tlR/NffB1P2IEfJ3cqVxiv+w4TfcHtQjozZhFcwUAyZtq8bwJJetdANTOIcydN44Kp32Sqs/TBW4wHqHKAP9SeI1rvb3pK3z8W/ilhMnuV0LzrAshBASSW+h8Dhm1IXLOLNxBQU2xTechKp7LArauFTB+AFFc5UGGLX4N+HWBKQZgGnFAdsLwZ4q+ze/llxN1Z4Ho6TG79CUMJZQL/yHrgcuUwm5IoscFv+cK/MPO3wCLOaqbMZxO/p4yMIJPUsQ/E5fqaGHRDGGZAdY3MuMYej+OKhCdTb+j5WoPOZ3rbKkxUuK7S8bDtz5ElT3RIhQNIS+MjWgIeL1POLYBeqT0vtJwtawQAaO3kbso5pxeDAQLlYhoTmDduHTg8K0Le/8ecLru9kVGoZteKtEXHqGuzuFkm/AyK+B8jPvktOusEWVfMSApQ+hZWkJ9dGBxRO67qYZvtQobWAUMSEjD1Q/ygrQIrfTwdPufNRfx4yzziinQLiZHQVUnFrNrFFOLcNQD3mmMwfJF+fMBNRBq0Nv1OBnEZSNvhmH69iql8Bu9XJOrCpWBcuXDghwWzSy+vriiU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4195c1a-fe04-4b75-60f3-08db53101735
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 17:41:17.9024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cOS11RsIB7DIIe1RIXPY7Ai2yIknJv72y0bwnWroD2IedimUemLU+0ZmN0DytVJWNjQfqpPs/lY2GQ3n4WOEmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4751
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120147
X-Proofpoint-GUID: uyxq183cdHK2N4NGelLRTdRr0nnLChE5
X-Proofpoint-ORIG-GUID: uyxq183cdHK2N4NGelLRTdRr0nnLChE5
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thank you Chuck for your review. I'll make the change in v2.

-Dai

On 5/12/23 8:30 AM, Chuck Lever III wrote:
> Hey Dai-
>
> Jeff's a little better with the state-related code, so let
> me start with a review of the new CB_GETATTR implementation.
>
>
>> On May 11, 2023, at 2:43 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Includes:
>>    . CB_GETATTR proc for nfs4_cb_procedures[]
>>
>>    . XDR encoding and decoding function for CB_GETATTR request/reply
>>
>>    . add nfs4_cb_fattr to nfs4_delegation for sending CB_GETATTR
>>      and store file attributes from client's reply.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/nfs4callback.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++++
>> fs/nfsd/state.h        |  17 +++++++
>> fs/nfsd/xdr4cb.h       |  19 ++++++++
>> 3 files changed, 153 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>> index 4039ffcf90ba..ca3d72ef5fbc 100644
>> --- a/fs/nfsd/nfs4callback.c
>> +++ b/fs/nfsd/nfs4callback.c
>> @@ -87,6 +87,43 @@ static void encode_bitmap4(struct xdr_stream *xdr, const __u32 *bitmap,
>> WARN_ON_ONCE(xdr_stream_encode_uint32_array(xdr, bitmap, len) < 0);
>> }
>>
>> +static void decode_bitmap4(struct xdr_stream *xdr, __u32 *bitmap,
>> +   size_t len)
>> +{
>> + WARN_ON_ONCE(xdr_stream_decode_uint32_array(xdr, bitmap, len) < 0);
>> +}
> encode_bitmap4() hides the WARN_ON_ONCE.
>
> However, for decoding, we actually want to get the result
> of the decode, so let's get rid of decode_bitmap4() and
> simply call xdr_stream_decode_uint32_array() directly from
> nfs4_xdr_dec_cb_getattr() (and, of course, check it's return
> code properly, no WARN_ON).
>
>
>> +
>> +static int decode_attr_length(struct xdr_stream *xdr, uint32_t *attrlen)
>> +{
>> + __be32 *p;
>> +
>> + p = xdr_inline_decode(xdr, 4);
>> + if (unlikely(!p))
>> + return -EIO;
>> + *attrlen = be32_to_cpup(p);
>> + return 0;
>> +}
>> +
>> +static int decode_cb_getattr(struct xdr_stream *xdr, uint32_t *bitmap,
>> + struct nfs4_cb_fattr *fattr)
>> +{
>> + __be32 *ptr;
>> +
>> + if (likely(bitmap[0] & FATTR4_WORD0_CHANGE)) {
>> + ptr = xdr_inline_decode(xdr, 8);
>> + if (unlikely(!ptr))
>> + return -EIO;
>> + xdr_decode_hyper(ptr, &fattr->ncf_cb_cinfo);
>> + }
>> + if (likely(bitmap[0] & FATTR4_WORD0_SIZE)) {
>> + ptr = xdr_inline_decode(xdr, 8);
>> + if (unlikely(!ptr))
>> + return -EIO;
>> + xdr_decode_hyper(ptr, &fattr->ncf_cb_fsize);
>> + }
> Let's use xdr_stream_decode_u64() for these.
>
> Also, I don't think the likely() is necessary -- this
> isn't performance-sensitive code.
>
>
>> + return 0;
>> +}
>> +
>> /*
>>   * nfs_cb_opnum4
>>   *
>> @@ -358,6 +395,26 @@ encode_cb_recallany4args(struct xdr_stream *xdr,
>> }
>>
>> /*
>> + * CB_GETATTR4args
>> + * struct CB_GETATTR4args {
>> + *   nfs_fh4 fh;
>> + *   bitmap4 attr_request;
>> + * };
>> + *
>> + * The size and change attributes are the only one
>> + * guaranteed to be serviced by the client.
>> + */
>> +static void
>> +encode_cb_getattr4args(struct xdr_stream *xdr, struct nfs4_cb_compound_hdr *hdr,
>> + struct knfsd_fh *fh, struct nfs4_cb_fattr *fattr)
> Nit: Can this take just a "struct nfs4_cb_fattr *" parameter
> instead of the filehandle and fattr?
>
>
>> +{
>> + encode_nfs_cb_opnum4(xdr, OP_CB_GETATTR);
>> + encode_nfs_fh4(xdr, fh);
>> + encode_bitmap4(xdr, fattr->ncf_cb_bmap, ARRAY_SIZE(fattr->ncf_cb_bmap));
>> + hdr->nops++;
>> +}
>> +
>> +/*
>>   * CB_SEQUENCE4args
>>   *
>>   * struct CB_SEQUENCE4args {
>> @@ -493,6 +550,29 @@ static void nfs4_xdr_enc_cb_null(struct rpc_rqst *req, struct xdr_stream *xdr,
>> }
>>
>> /*
>> + * 20.1.  Operation 3: CB_GETATTR - Get Attributes
>> + */
>> +static void nfs4_xdr_enc_cb_getattr(struct rpc_rqst *req,
>> + struct xdr_stream *xdr, const void *data)
>> +{
>> + const struct nfsd4_callback *cb = data;
>> + struct nfs4_cb_fattr *ncf =
>> + container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
>> + struct nfs4_delegation *dp =
>> + container_of(ncf, struct nfs4_delegation, dl_cb_fattr);
>> + struct nfs4_cb_compound_hdr hdr = {
>> + .ident = cb->cb_clp->cl_cb_ident,
>> + .minorversion = cb->cb_clp->cl_minorversion,
>> + };
>> +
>> + encode_cb_compound4args(xdr, &hdr);
>> + encode_cb_sequence4args(xdr, cb, &hdr);
>> + encode_cb_getattr4args(xdr, &hdr,
>> + &dp->dl_stid.sc_file->fi_fhandle, &dp->dl_cb_fattr);
>> + encode_cb_nops(&hdr);
>> +}
>> +
>> +/*
>>   * 20.2. Operation 4: CB_RECALL - Recall a Delegation
>>   */
>> static void nfs4_xdr_enc_cb_recall(struct rpc_rqst *req, struct xdr_stream *xdr,
>> @@ -548,6 +628,42 @@ static int nfs4_xdr_dec_cb_null(struct rpc_rqst *req, struct xdr_stream *xdr,
>> }
>>
>> /*
>> + * 20.1.  Operation 3: CB_GETATTR - Get Attributes
>> + */
>> +static int nfs4_xdr_dec_cb_getattr(struct rpc_rqst *rqstp,
>> +  struct xdr_stream *xdr,
>> +  void *data)
>> +{
>> + struct nfsd4_callback *cb = data;
>> + struct nfs4_cb_compound_hdr hdr;
>> + int status;
>> + u32 bitmap[3] = {0};
>> + u32 attrlen;
>> + struct nfs4_cb_fattr *ncf =
>> + container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
>> +
>> + status = decode_cb_compound4res(xdr, &hdr);
>> + if (unlikely(status))
>> + return status;
>> +
>> + status = decode_cb_sequence4res(xdr, cb);
>> + if (unlikely(status || cb->cb_seq_status))
>> + return status;
>> +
>> + status = decode_cb_op_status(xdr, OP_CB_GETATTR, &cb->cb_status);
>> + if (status)
>> + return status;
>> + decode_bitmap4(xdr, bitmap, 3);
>> + status = decode_attr_length(xdr, &attrlen);
>> + if (status)
>> + return status;
> Let's use xdr_stream_decode_u32 directly here, and
> check that attrlen is a reasonable value. Say, not
> larger than the full expected array length?
>
>
>> + ncf->ncf_cb_cinfo = 0;
>> + ncf->ncf_cb_fsize = 0;
>> + status = decode_cb_getattr(xdr, bitmap, ncf);
>> + return status;
> You're actually decoding a fattr4 here, not the whole
> CB_GETATTR result. Can we call the function
> decode_cb_fattr4() ?
>
> Nit: Let's fold the initialization of cb_cinfo and
> cb_fsize into decode_cb_fattr4().
>
>
>
>> +}
>> +
>> +/*
>>   * 20.2. Operation 4: CB_RECALL - Recall a Delegation
>>   */
>> static int nfs4_xdr_dec_cb_recall(struct rpc_rqst *rqstp,
>> @@ -855,6 +971,7 @@ static const struct rpc_procinfo nfs4_cb_procedures[] = {
>> PROC(CB_NOTIFY_LOCK, COMPOUND, cb_notify_lock, cb_notify_lock),
>> PROC(CB_OFFLOAD, COMPOUND, cb_offload, cb_offload),
>> PROC(CB_RECALL_ANY, COMPOUND, cb_recall_any, cb_recall_any),
>> + PROC(CB_GETATTR, COMPOUND, cb_getattr, cb_getattr),
>> };
>>
>> static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_procedures)];
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index d49d3060ed4f..92349375053a 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -117,6 +117,19 @@ struct nfs4_cpntf_state {
>> time64_t cpntf_time; /* last time stateid used */
>> };
>>
>> +struct nfs4_cb_fattr {
>> + struct nfsd4_callback ncf_getattr;
>> + u32 ncf_cb_status;
>> + u32 ncf_cb_bmap[1];
>> +
>> + /* from CB_GETATTR reply */
>> + u64 ncf_cb_cinfo;
> In fs/nfsd/nfs4xdr.c, we use "cinfo" to mean change info:
> that's a boolean, and a pair of 64-bit change attribute values.
> IIUC, I don't think that's what this is; it's just a single
> change attribute value.
>
> To avoid overloading the name "cinfo" can you call this field
> something like ncf_cb_change ?
>
>
>> + u64 ncf_cb_fsize;
>> +};
>> +
>> +/* bits for ncf_cb_flags */
>> +#define CB_GETATTR_BUSY 0
>> +
>> /*
>>   * Represents a delegation stateid. The nfs4_client holds references to these
>>   * and they are put when it is being destroyed or when the delegation is
>> @@ -150,6 +163,9 @@ struct nfs4_delegation {
>> int dl_retries;
>> struct nfsd4_callback dl_recall;
>> bool dl_recalled;
>> +
>> + /* for CB_GETATTR */
>> + struct nfs4_cb_fattr    dl_cb_fattr;
>> };
>>
>> #define cb_to_delegation(cb) \
>> @@ -642,6 +658,7 @@ enum nfsd4_cb_op {
>> NFSPROC4_CLNT_CB_SEQUENCE,
>> NFSPROC4_CLNT_CB_NOTIFY_LOCK,
>> NFSPROC4_CLNT_CB_RECALL_ANY,
>> + NFSPROC4_CLNT_CB_GETATTR,
>> };
>>
>> /* Returns true iff a is later than b: */
>> diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
>> index 0d39af1b00a0..3a31bb0a3ded 100644
>> --- a/fs/nfsd/xdr4cb.h
>> +++ b/fs/nfsd/xdr4cb.h
>> @@ -54,3 +54,22 @@
>> #define NFS4_dec_cb_recall_any_sz (cb_compound_dec_hdr_sz  +      \
>> cb_sequence_dec_sz +            \
>> op_dec_sz)
>> +
>> +/*
>> + * 1: CB_GETATTR opcode (32-bit)
>> + * N: file_handle
>> + * 1: number of entry in attribute array (32-bit)
>> + * 1: entry 0 in attribute array (32-bit)
>> + */
>> +#define NFS4_enc_cb_getattr_sz (cb_compound_enc_hdr_sz +       \
>> + cb_sequence_enc_sz +            \
>> + 1 + enc_nfs4_fh_sz + 1 + 1)
>> +/*
>> + * 1: attr mask (32-bit bmap)
>> + * 2: length of attribute array (64-bit)
> Isn't the array length field 32 bits?
>
>
>> + * 2: change attr (64-bit)
>> + * 2: size (64-bit)
>> + */
>> +#define NFS4_dec_cb_getattr_sz (cb_compound_dec_hdr_sz  +      \
>> + cb_sequence_dec_sz + 7 + \
> Generally we list the length of each item separately
> to document the individual values, so:
>
> 1 + 1 + 2 + 2
>
> is preferred over a single integer.
>
>
>> + op_dec_sz)
>> -- 
>> 2.9.5
>>
> --
> Chuck Lever
>
>
