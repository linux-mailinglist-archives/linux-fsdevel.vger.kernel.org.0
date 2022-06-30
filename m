Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04184561F7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 17:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbiF3PkO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 11:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbiF3PkM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:40:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3341B2CE1A;
        Thu, 30 Jun 2022 08:40:10 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UEqHdq020594;
        Thu, 30 Jun 2022 15:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=J5nVcfXZKQHiWwrBv6H8gb5Ojidoh7tTS4qCyO2kcIw=;
 b=zTdvMZovJ/p4zQqhwRI8OTEnD3Trky5kiuLbOxBwqWtuZ4YASxnVOJI/MGVa4O9L5/Ev
 VirQ/83VEELUVAWVvOLGrRKm7ZgsD/fF+kkC7PTrHG6ecxjlndH4iWExTGVEIObQaujo
 akBAyDStFMaW9hx/OYPv6t0foTMyVN6R686xEtrI9R1itWIgKufunPCg9TO4q/GUSiq5
 gED+f6XXHefmNGoh8k0LERVcEMdTI7hOjKhA/0G5WRfl9ArTotEHblNaDTHn7C3FZDKz
 zkk6DzgaP+d6U4+lj5FzWLIqQ0ssH3p0aXPt2fJfGXLeIBj8boN9zdAhtKSkMiERVX/u fA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwsysmm0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 15:39:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25UFbBVS019191;
        Thu, 30 Jun 2022 15:39:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt4bc9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 15:39:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIN5uhzimJ7QejgGCDACyeKcaRqSCKPbTDBr40FjrcaqXVxrsFilfawq/2OfvKCmDM19X01RKvdhmmA0kxE+eKOEmrRgF5EylK7PCQXRpZKsAQXvZn8CxFELq+Eq3UTBr0WV9w0xCF838s2MtkwbGBsFwtTho1mUfIVI8oZSDZC4x4Vtkt868fLdvbHotTbCZRrMRawPlF3gnTqZeN0gNtRchu9fxsbrPxt8JdRJCYyBZ2nqM5nFaeD1SSbgiHT3faoBDtZxL0k+Qdo8jRFRgkkBXWqqvq1hOpFKhwgBQSmlBTGOU2LT2eZhcX53w3uOJQeeZpJhldwwJPmvUEUe9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5nVcfXZKQHiWwrBv6H8gb5Ojidoh7tTS4qCyO2kcIw=;
 b=P8N82PcJnNwXAcyp9PrYcpS6+e/QSEME7k+Ha1Uqw1J6HDWlZdewjdh43lYocSve25RKfCGs8kRaEhk9vh+U0aPrVwRkf7bLdIZKHGGNbLknwpXTMlnjxUdpjRjTq9pswV3FvvMdSC0864jwOjVcgR5/bqj24vQR5g0NkfQB46nGdv+osU+oCSbZbxWqoncqomDl2NSIn/t2FWJ/NxISuYzWXAFUWUrzCs9+L9ZTaFR1k1RMEbEakEaattobxovW/KQ8g+pOT6SPCzlvJ3I+BJMrdOHXh/e+30jYHF8j41IeLQfLJW32GBS06p1PZQ6VpSBY/c2TfCKbSYA3lV5Gpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5nVcfXZKQHiWwrBv6H8gb5Ojidoh7tTS4qCyO2kcIw=;
 b=Zy92QTxdBRX/0Py4ssk74RiGCWXG4D433F17cYBrTl45Lurg9oWR2yHJzSEC/O17u1hegw95V9+GCYyMRzlA4QEBTv19C4badDMR947Cebk1AiwC9jz7iVAi2yzJZzH92DV/3PjUCo7LvRkgATk1e8fatNtsYPKa/qsraGdBBGA=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by CO1PR10MB4737.namprd10.prod.outlook.com (2603:10b6:303:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 15:39:28 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2%3]) with mapi id 15.20.5373.022; Thu, 30 Jun 2022
 15:39:28 +0000
Message-ID: <2ddfad15-394c-241f-b120-5b297ed5356f@oracle.com>
Date:   Thu, 30 Jun 2022 09:39:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 0/9] Add support for shared PTEs across processes
Content-Language: en-US
To:     Mark Hemment <markhemm@googlemail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        aneesh.kumar@linux.ibm.com, arnd@arndb.de, 21cnbao@gmail.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        Kees Cook <keescook@chromium.org>, kirill@shutemov.name,
        kucharsk@gmail.com, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>, longpeng2@huawei.com,
        luto@kernel.org, pcc@google.com, rppt@kernel.org,
        sieberf@amazon.com, sjpark@amazon.de,
        Suren Baghdasaryan <surenb@google.com>, tst@schoebel-theuer.de,
        yzaikin@google.com
References: <cover.1656531090.git.khalid.aziz@oracle.com>
 <CANe_+Uj6RXw_X5Bv9_UkD_ngA_7haz3rqmbd2FAGzP1uHsxAfA@mail.gmail.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <CANe_+Uj6RXw_X5Bv9_UkD_ngA_7haz3rqmbd2FAGzP1uHsxAfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0023.namprd21.prod.outlook.com
 (2603:10b6:805:106::33) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e16e1c65-6fe2-4033-4a2d-08da5aaeb7fc
X-MS-TrafficTypeDiagnostic: CO1PR10MB4737:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y7mx9aklisAkUYellLfwvpmuKH1KYoNYp0dKURrN78qvrs+RADtFg18LDgRU3DWSq9vk1mhxiBXKFgizYe7cTYRgy3+k9Bxnc0R4cfCVCJ4tlMrDxbIASV40h0YzmRSeXp+tHQ4nMGIl7WxjxQg3NjZLedGh/WxUjdjAUQUvESViJugb4KBLlXR9FQ5m1+8BjZhLVMKHrJjQ0u1hI5VwiVAp92L98umdGvv5JftLXX6vE6sHo8UvfGGjX7JkE1hgjQlaVidpgpLTwGHrjUYkJoMdIcAm0oNPvsFN+/Yu93rvOwwCtdQZpyA5VxDEQGoV+WGVIn8GiASf/Q0ta8jvaZCUPEnAJ9YViVRZ+RG7+99B3TsKnPnpOSB+5InSRGtsKjhIs2ec55lOd9IMk05UM0ykL/6J6TqEyuB8olcNeSLyqayMZQeqwWjv0kXtjVy9V88EVjh/dnSG77X8PntPaBoZj8tPNd4FfxNj1DKD4ldKAgYp8ApJAFo6nV2KS5qSwjYR74Do+YUyraRVT+oimVzyKhNh6ZwvKX5ZQCLjLRQbA3IMc2JvUdcYbU2F/LjwBCTsv4X7zmeME/l1zyFRYGoRpIo2X+Q0OWCrxFct/Qp+417qHb9sWMYzKQ6HZOGDUUO/YUVU87q/iKQHrDXdqYC4z+22kfAX7kwYGY1IjXDh0F7rEaEeSK1glY4G+UQOLZ0QEU89lviWtRYH1jwFFN0pjRFgtD3WK8CGd4zuuvtgi1YHxzLJR4gQqqeACm91VtNccF18exitjrsXdPCBjAO59oAXOEnWmPgMYJgo0XRbmhvAtEoTx+6OfVPl1LaSquPrTM8L3byt0fkSEKnoQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(39860400002)(376002)(346002)(6512007)(41300700001)(7416002)(6666004)(31686004)(36756003)(478600001)(5660300002)(53546011)(38100700002)(2616005)(6506007)(186003)(6486002)(8676002)(31696002)(8936002)(44832011)(66476007)(66946007)(83380400001)(66556008)(4326008)(316002)(6916009)(2906002)(54906003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0E0NmVVSWV6ZS91U2hZbm54clJGNXBEZk5QNWJZVnFIMDRTQzExYm45WGVz?=
 =?utf-8?B?eHRyRWhKY3pFR3RiWDN6NXZHZkFTK3ZzMXhKRTc2VnNTR3pXTC9na05ENUQ4?=
 =?utf-8?B?cTIzMHVsekhDOFM2MThGRjhmQzgwZlFnUkIxaTRqNVlackNnR1lOb3VCbllL?=
 =?utf-8?B?QkZoT2lDQUtEQVRsVUUvNmJacEc3UEpabTNubURrNVQreGE1QnAzbHpVYS9m?=
 =?utf-8?B?ZjlxeGpxa2dCMWp1Vkw4WlBWRkU0Q21tVWp4WE93eHdjWEQ0VW9pRTB5STNy?=
 =?utf-8?B?ck9NeG1zRjVDelN4OHhqVG5WZXJUNVVpMlVSamRXa2xMbXdNRVZ5SGgwVzVj?=
 =?utf-8?B?anBuNElBc1RQcm1Nd2UrTlhTd0lwNWJxTlp2UlRsTDJWYmQrKzVLcmdYam92?=
 =?utf-8?B?dFRRcmdQZHJwVVh1WVNFZ0xiWUdDUEZaSVZuYTMzaHNQYmhUWndBV2pIQjEw?=
 =?utf-8?B?dlE3cmVCVU1DMmpmYkd3SFFWTHRyUnQrQkpudTNUSzgvTmpVUWZOZEh1TnN5?=
 =?utf-8?B?V2JKSVAxTDFnUDBVZndRbkVNMVFyYlE2WmNWUXNONzI1MHlvRDVXR1E4enRE?=
 =?utf-8?B?UkpqdThNSFNJY2huM2dZbkM4RFg1QzJSNGg3bGd2MWJ0VkhMakVCRncvOFlL?=
 =?utf-8?B?Yndyd2ZjVnFLTDVkWXl3d1phRzRlSFlRQWI1ZUF5Um9LYUFzWHdHTm5ML09Y?=
 =?utf-8?B?ZGRiNWVaa1lIUkp0TFE4MVU5MmNxSEJBTEpmS3NTNGZuTUdzN2FubDMyQmRY?=
 =?utf-8?B?YnB5TkxtOEgyY09FMFVhTkhEUDdaWHU5WUZtYUJOdDhzeDBzSTdCMUxRZ3gx?=
 =?utf-8?B?Unc3UEZoU0xHdlhUdnU0ejZEc2MySDl4TTFXWjY1TVdudWNwanEzd0QyUjRn?=
 =?utf-8?B?RHhiZEtMNWpLa2FRNThwZEVLZy9mS3poeG5HUGEreXV4U21iMnBxUkR0bGhZ?=
 =?utf-8?B?aWEyKzBUTTlWbUFQKzBDZUQxeW1zcFVjS2pVRVJMUGk3K095YkYzTUhnWmdr?=
 =?utf-8?B?T2RObzJSSW9XS2h6Zlo2cjUreDBYa0htaDBwejVpUit3SDQweXVFeGdoNVdK?=
 =?utf-8?B?V09TRi96SnJhZHNFaTVKMDloNWVKTWdDQnpLSk42czFyK3d2ZFpCT0hhS3dT?=
 =?utf-8?B?MlVaaE9wZVhQeTk0Z0s3UTBiS3ZxeTBIWldHM3BHVWpJcDF6aWk4QXE0bE1a?=
 =?utf-8?B?eGtxVGx0d0ovTVJnelhmVzg4emZ0ckpPVVpWSkFleVVhU0Y0QUx2Vk1TTWR1?=
 =?utf-8?B?dUd2aEZWK2RlNGpRWGZFbXkxZjFtaU1mbjJKNSsyZ1d5ZnRJRGFuY3BHWEZa?=
 =?utf-8?B?UVVpV1FheU93a2lUbTYrUHFBNCt4RlltR09vaWJwenAyRit6bHVBOHlLcWJW?=
 =?utf-8?B?R05mWlRMWlFYWEs0aHI0a0pwZktVRWNTcTdNTWFWeURyQVN5UThzYXNxWEtT?=
 =?utf-8?B?VXh6MUppVHY5alljdUlPdlozZnErWmwrNktkNnUxV05tc3ZlOWlsRVJGV1R1?=
 =?utf-8?B?WUYwWHRVa2VZZE1UTmF0Q2FsME1XbHFmTkdkYlNvcStIWHVhQWRMM2xKWUp2?=
 =?utf-8?B?SURWRDFMaktvaExROXNWRFhycFZIYlozN2dxZG82WXVWNENFU0JpeUwzb0VC?=
 =?utf-8?B?My82L3FXak54OG0vNmZ2eldvUGU1dUd1SmJMQzE0WlJrRE5neFdrb0h1Ymtj?=
 =?utf-8?B?T1pxcUpBRXB0bDNqVmtXY0JOWjdKcDl1QzlGRi82bzVjUVRObGZxWVlKNitl?=
 =?utf-8?B?UDk0VjRRNnA2di85VXdhcmU4THBwekJmZWdsYkttREcrY2d5eUxoQmpzUWNx?=
 =?utf-8?B?NFlsTTN3blpaVllSOGgvOTZ3eFNHOWhnLzlZNWVHWXVHUWdBMWJOYjlGRzQz?=
 =?utf-8?B?clNtNW45ZS9GdHZCWWFpQm9zanpNc2E2TDkxNVNoRllvWXNLaWJWekU4dUl4?=
 =?utf-8?B?cnR2WWliR2pjdW5pOUU1R2RETjRmbUw2eGo3SkcvaDJQdi9vUVhJTFhqSHFT?=
 =?utf-8?B?dEFkSWNGcndOalExOCtPQWhLN3BaWklkN2s3bCtjdWVTM3ZoemFiVU0zUHdO?=
 =?utf-8?B?NE0yVUlBamIwUGhHbnB2SElDbktnMm1VMGNRMFQ0amJKQzM1WHRacUh2Vm1I?=
 =?utf-8?B?L1c1dGpPVlFzbk05OCsyeWpVQkNSOE5GbFlXdkh3Q1JyWFptSmhSQUtFdlBr?=
 =?utf-8?B?VHE4LzQ1ZVFGZUZweEZwL0pNYy9ZWThaMUlWNXNYV1EyWS9qT3ZJL0JpV0Nr?=
 =?utf-8?B?RHBJb05nQmN5ZWNBYWVjdFRocWdRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16e1c65-6fe2-4033-4a2d-08da5aaeb7fc
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 15:39:28.6264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUNxmn5iH3+zxersqG21rWHoDjx3/SPnrdYB0PLjeyUaKVg84HrCsq0VSCd4X1EricvE81hc5PSGh/yTNZSPhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4737
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-30_11:2022-06-28,2022-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206300062
X-Proofpoint-ORIG-GUID: lRM3StzGVOq7XhVTcCdaJfsVlcq83fcC
X-Proofpoint-GUID: lRM3StzGVOq7XhVTcCdaJfsVlcq83fcC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/30/22 05:57, Mark Hemment wrote:
> Hi Khalid,
> 
> On Wed, 29 Jun 2022 at 23:54, Khalid Aziz <khalid.aziz@oracle.com> wrote:
>>
>>
>> Memory pages shared between processes require a page table entry
>> (PTE) for each process. Each of these PTE consumes consume some of
>> the memory and as long as number of mappings being maintained is
>> small enough, this space consumed by page tables is not
>> objectionable. When very few memory pages are shared between
>> processes, the number of page table entries (PTEs) to maintain is
>> mostly constrained by the number of pages of memory on the system.
>> As the number of shared pages and the number of times pages are
>> shared goes up, amount of memory consumed by page tables starts to
>> become significant. This issue does not apply to threads. Any number
>> of threads can share the same pages inside a process while sharing
>> the same PTEs. Extending this same model to sharing pages across
>> processes can eliminate this issue for sharing across processes as
>> well.
>>
>> Some of the field deployments commonly see memory pages shared
>> across 1000s of processes. On x86_64, each page requires a PTE that
>> is only 8 bytes long which is very small compared to the 4K page
>> size. When 2000 processes map the same page in their address space,
>> each one of them requires 8 bytes for its PTE and together that adds
>> up to 8K of memory just to hold the PTEs for one 4K page. On a
>> database server with 300GB SGA, a system crash was seen with
>> out-of-memory condition when 1500+ clients tried to share this SGA
>> even though the system had 512GB of memory. On this server, in the
>> worst case scenario of all 1500 processes mapping every page from
>> SGA would have required 878GB+ for just the PTEs. If these PTEs
>> could be shared, amount of memory saved is very significant.
>>
>> This patch series implements a mechanism in kernel to allow
>> userspace processes to opt into sharing PTEs. It adds a new
>> in-memory filesystem - msharefs. A file created on msharefs creates
>> a new shared region where all processes sharing that region will
>> share the PTEs as well. A process can create a new file on msharefs
>> and then mmap it which assigns a starting address and size to this
>> mshare'd region. Another process that has the right permission to
>> open the file on msharefs can then mmap this file in its address
>> space at same virtual address and size and share this region through
>> shared PTEs. An unlink() on the file marks the mshare'd region for
>> deletion once there are no more users of the region. When the mshare
>> region is deleted, all the pages used by the region are freed.
> 
>    Noting the flexibility of 'mshare' has been reduced from v1.  The
> earlier version allowed msharing of named mappings, while this patch
> is only for anonymous mappings.
>    Any plans to support named mappings?  If not, I guess *someone* will
> want it (eventually).  Minor, as the patch does not introduce new
> syscalls, but having an API which is flexible for both named and anon
> mappings would be good (this is a nit, not a strong suggestion).

I apologize for not clarifying this. The initial mmap() call looks like an anonymous mapping but one could easily call 
mremap later and map any other objects in the same address space which remains shared until the mshare region is torn 
down. It is my intent to support mapping any objects in mshare region.

> 
>    The cover letter details the problem being solved and the API, but
> gives no details of the implementation.  A paragraph on the use of a
> mm_struct per-msharefs file would be helpful.

Good point. I will do that next time.

> 
>    I've only quickly scanned the patchset; not in enough detail to
> comment on each patch, but a few observations.
> 
>    o I was expecting to see mprotect() against a mshared vma to either
> be disallowed or code to support the splitting of a mshared vma.  I
> didn't see either.msharefs_delmm

Since mshare region is intended to support multiple objects being mapped in the region and different protections on 
different parts of region, mprotect should be supported and should handle splitting the mshare'd vmas. Until basic code 
is solid, it would make sense to prevent splitting vmas and add that on later. I will add this code.

> 
>    o For the case where the mshare file has been closed/unmmap but not
> unlinked, a 'mshare_data' structure will leaked when the inode is
> evicted.

You are right. mshare_evict_inode() needs to call msharefs_delmm() to clean up.

> 
>    o The alignment requirement is PGDIR_SIZE, which is very large.
> Should/could this be PMD_SIZE?

Yes, PGDIR_SIZE is large. It works for the database folks who requested this feature but PMD might be more versatile. I 
have been thinking about switching to PMD since that will make it easier to move hugetlbfs page table sharing code over 
to this code.

> 
>    o mshare should be a conditional feature (CONFIG_MSHARE ?).

I can do that. I was reluctant to add yet another CONFIG option. Since this feature is activated explicitly by userspace 
code, is it necessary to make it a config option?

> 
> 
>    I might get a chance do a finer grain review later/tomorrow.
> 
>> API
>> ===
>>
>> mshare does not introduce a new API. It instead uses existing APIs
>> to implement page table sharing. The steps to use this feature are:
>>
>> 1. Mount msharefs on /sys/fs/mshare -
>>          mount -t msharefs msharefs /sys/fs/mshare
>>
>> 2. mshare regions have alignment and size requirements. Start
>>     address for the region must be aligned to an address boundary and
>>     be a multiple of fixed size. This alignment and size requirement
>>     can be obtained by reading the file /sys/fs/mshare/mshare_info
>>     which returns a number in text format. mshare regions must be
>>     aligned to this boundary and be a multiple of this size.
>>
>> 3. For the process creating mshare region:
>>          a. Create a file on /sys/fs/mshare, for example -
>>                  fd = open("/sys/fs/mshare/shareme",
>>                                  O_RDWR|O_CREAT|O_EXCL, 0600);
>>
>>          b. mmap this file to establish starting address and size -
>>                  mmap((void *)TB(2), BUF_SIZE, PROT_READ | PROT_WRITE,
>>                          MAP_SHARED, fd, 0);
>>
>>          c. Write and read to mshared region normally.
>>
>> 4. For processes attaching to mshare'd region:
>>          a. Open the file on msharefs, for example -
>>                  fd = open("/sys/fs/mshare/shareme", O_RDWR);
>>
>>          b. Get information about mshare'd region from the file:
>>                  struct mshare_info {
>>                          unsigned long start;
>>                          unsigned long size;
>>                  } m_info;
>>
>>                  read(fd, &m_info, sizeof(m_info));
>>
>>          c. mmap the mshare'd region -
>>                  mmap(m_info.start, m_info.size,
>>                          PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>>
>> 5. To delete the mshare region -
>>                  unlink("/sys/fs/mshare/shareme");
>>
>>
>>
>> Example Code
>> ============
>>
>> Snippet of the code that a donor process would run looks like below:
>>
>> -----------------
>>          fd = open("/sys/fs/mshare/mshare_info", O_RDONLY);
>>          read(fd, req, 128);
>>          alignsize = atoi(req);
>>          close(fd);
>>          fd = open("/sys/fs/mshare/shareme", O_RDWR|O_CREAT|O_EXCL, 0600);
>>          start = alignsize * 4;
>>          size = alignsize * 2;
>>          addr = mmap((void *)start, size, PROT_READ | PROT_WRITE,
>>                          MAP_SHARED | MAP_ANONYMOUS, 0, 0);
> 
> Typo, missing 'fd'; MAP_SHARED | MAP_ANONYMOUS, fd, 0)

Yes, you are right. I will fix that.

Thanks, Mark! I really appreciate your taking time to review this code.

--
Khalid
