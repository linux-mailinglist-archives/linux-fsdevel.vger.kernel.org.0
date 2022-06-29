Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CCD56077E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 19:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiF2Rln (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 13:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiF2Rlg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:41:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B0F21814;
        Wed, 29 Jun 2022 10:41:35 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TFDxlo010301;
        Wed, 29 Jun 2022 17:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=hEdZzX0tiB6N/jKmCws/wXTu5JImd2exBhfhzhD/qdE=;
 b=LPM4XGNGe2Ym2Yk7OHJjUzEHKfDsJnG45sa5b0qHF8Pavxdm1DOUgzYB9YihybLUlQEk
 nlG3pUdAv0mgtWaIMV8si8QPKFUpEJQIOCO0p09APl3gJrtoclOMVn4ixnpHQS5B83Qm
 S12TDWjJ9b1j0tEdKUiVCBeSockbuItnTWs1nYrbJjgI0VN/sP6R/KJtBsfImwBPYagH
 pyH+F1FBQ0v5m4dryqtm3c1sXV8RBcPTEsQxx+IpaAJkqtaimeshduYNaK/i0InvCiIM
 nXtXRWpRNWxV52kERoFSpiJrkzOk5nvlrqE7kY5ilOpWhCWzkQe/rTSvj5mJwiU1zahu 9A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gws52hyuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 17:40:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25THUx2T039757;
        Wed, 29 Jun 2022 17:40:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt3qqgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 17:40:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aui5Io4D34nszi2//KgoqEPXfE6THTp5R/Ky4RAIVFHVhQkLM4hXHSU/IduU6l+daI/9TVik7Vabz8XGC9pNLbjAEFYY+4OitrGWMTrXNP+hYTTT6v7+waYCebVEZU+a4kSuIIhumY/LVkov+fKKnW9nHvj0wCChh+BgykknqzBV1xPTXokYXu5ttHkH6yD1R4LM+ga0aWxZ9tYM1MitWyUYQtJ5l0fXCWH4gfdeLODsBdDZ0jw6jQWItJx6AGY4LB+rqapnTCvBrAn7HC7VVF/UOZBJ0XBxASLfwxagMo5jHxZWYGj8vII14h+nBbm7EjFCFVosqT4jeyzoUsjwKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEdZzX0tiB6N/jKmCws/wXTu5JImd2exBhfhzhD/qdE=;
 b=O/jQwneUY5INVUawI6iPNyWM9ziogII8jVP2mWrZd69PjIvop3GnzUYWbukDLZCGO7jyvxogCp46UAYPfzBK5w7QWJ2O+J/3iCp7mWXZ6Bk5eBIMSeURc/8kA5AV9V6/AoqaOhkEH8CXlfxqpS8MlMswyw7DahwF4r479zuezjujPSJYEyeSjZsA0h0Fg9CJoflSgqms/RAlJFS5IDhKkLCYDEYG/JRxyVL11iF+nkO6i7BODMt+aS8TK/XcyBF6w1r2grzxezuHr//Ljd5gJa4wRVkejUCAsPJhBDzK767HdNZYg8EohU12gkQd76kVhJT7sStNADLwFujtMSyHug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEdZzX0tiB6N/jKmCws/wXTu5JImd2exBhfhzhD/qdE=;
 b=FT515GxrlSLwb0cyNEKVGtY+yxDYZOzO2B9747cOf8pz2XUVajqgDXin1zfXsBViZrZrW0QyMlcZg2IHqUH3CdejpkmSQOE+H60bVcycGO6whVjDUEoYqStdWziHpy0McUNp2/1ZWhv0bNcmi7Z96YvtOANBaL3CP9NQKIKmXis=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by BN6PR1001MB2180.namprd10.prod.outlook.com (2603:10b6:405:32::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Wed, 29 Jun
 2022 17:40:49 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2%3]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 17:40:49 +0000
Message-ID: <9d2a1850-c51d-c6ca-a3ba-8f62bd142949@oracle.com>
Date:   Wed, 29 Jun 2022 11:40:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 00/14] Add support for shared PTEs across processes
Content-Language: en-US
To:     Barry Song <21cnbao@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, ebiederm@xmission.com,
        hagen@jauu.net, jack@suse.cz, Kees Cook <keescook@chromium.org>,
        kirill@shutemov.name, kucharsk@gmail.com, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, longpeng2@huawei.com,
        Andy Lutomirski <luto@kernel.org>, markhemm@googlemail.com,
        pcc@google.com, Mike Rapoport <rppt@kernel.org>,
        sieberf@amazon.com, sjpark@amazon.de,
        Suren Baghdasaryan <surenb@google.com>, tst@schoebel-theuer.de,
        Iurii Zaikin <yzaikin@google.com>
References: <cover.1649370874.git.khalid.aziz@oracle.com>
 <CAGsJ_4yXnmifuU7+BFOkZrz-7AkW4CDQF5cHqQS-oci-rJ=ZdA@mail.gmail.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <CAGsJ_4yXnmifuU7+BFOkZrz-7AkW4CDQF5cHqQS-oci-rJ=ZdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0171.namprd04.prod.outlook.com
 (2603:10b6:806:125::26) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 437e77da-7d37-4e5b-8d5d-08da59f68173
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2180:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zzscaZcLf0AspyQzIKOPDnNBBDTqQ7LcNiTsrnkfZERjWQ0/XzDws0WPly+zYU4VC0kMmS3Hefpi1pNHqEPrgBldgnLZyR7uGCdAUbYpYyYJ5djKjLJ2FWPCtKQaRejmfW3K07iXDg26vNm1Eq/l4D/4Ied4lMZUmamnCjY1COvW+4Uv/4zpDupJN+RLqYqvvLj5XI7GT+Qgg4iA8DYaikLGg11NzmV8AC/TdgzQ4uWSLKf7BkOY3G8n/EpccxmRBxiU5rxq45BFf1tKITnc3MzuQ4sdjzjDxngRdER0Vcw+c3kOUkeEMx5VF/FtVZD1/2+xfHb6PPACcoRPRUjMhQvA2iJhtOjvZFA5SLKQkBdp1goeE47SKH5llZYlNkM2MW7mVW4CL8XILbm3ZXSuvy6MP+1AmBfUN7VBdhxT6PAjx0RcQryrHKTrpqsd9DoHxsMLVDj+J7t4flh9FMqpI1zrDJdFTMfPybHuqhSC3ByO8B/yH+CYMdc1BFFt4g3QSGeSvgHOhhXHY6ILCLUT/0eKTtWcKldtyhpdq0Cl7R3Kaj1lqB4hOsSBCr6uV51nxTw/oY0Atqw1odauDsPrOak3cSaQKF4Ib63Rcv7hPj+xqQ//XCXT4t8u3BuqTI1ukA6PY+o3WynSpznjZbiIkZs/1+y41LXqz1CvJOR6AoN2DuqXr4e+YCLShXhknN//Y8KtROgvMiPjkJO34gbJfywvtxDDgxHVcvCM4jQBZFt2FQl5RgfzRPipdMeIsTldDiRx0yBFW5HFTsQWQ11TUDYpf+kmfew5JDWUQm1TlfDu8zB4csHDeSsfTMT+O4ZIAT0e32fVKrNzqaD/+Nzxug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(376002)(136003)(39860400002)(366004)(6512007)(316002)(53546011)(31686004)(66556008)(36756003)(8676002)(6506007)(8936002)(66946007)(2906002)(66476007)(2616005)(86362001)(31696002)(38100700002)(6916009)(4326008)(7416002)(54906003)(83380400001)(6666004)(6486002)(186003)(44832011)(41300700001)(5660300002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU42cnJIWUFIMFVOUFhnQ3ZZbTNWL2NmY2l6RnZJMTNQNUdHMlNGbUxJNGtq?=
 =?utf-8?B?dEJQOEtoeVZJYmZSbjBZSkpZRDRxTzdCaWxERFQ0RjdueThMR0Zsbk1yNGJV?=
 =?utf-8?B?am9ONkxZbFF2K3ZLTWlYR21wWll4eDFBK2lFSzcwamFhUEJUS0hqUUgwMEFs?=
 =?utf-8?B?MXFUS1pZWDEraG5OZU80MlJoU2Q5UmtKWlBzczNCZWNDQjVrcTYrKy9JeU80?=
 =?utf-8?B?cEhibnJoTTNuN3c5UENXMEUrVmhzQ1Y1c1g1Yk8xM085dXplT3lGU2lTRisv?=
 =?utf-8?B?VTNlaG1ja1VEVmpBdlRNd1lYdk1RNTJqbmRqSHM5Mm10dFViQXVyMldHMVNp?=
 =?utf-8?B?Z084L3V4M1A0Y0RFK2lqSTBTOFdwUUpIWllVV2FrUzVmZ1J5TmxKaXppSEtr?=
 =?utf-8?B?cWJMTjVaQnVrMzJlVEpCUHlmMGdLb2lLRkFWMmdGcGJWWFE5SUxybTE3MmdN?=
 =?utf-8?B?Q09wWXluYThsVHA1dnJEc00rbnZSSEl3VGErRTdrcm8rcXEzdDliOFc4TUFL?=
 =?utf-8?B?WGxYeE5pQlVvQVQrQWtMaUJPeFkrV2wwMkI0eWpzOVNpSVB4UDkxdXluM3JV?=
 =?utf-8?B?VjJmdlJjV1k0MmZXbzNzOUV6QUZXL0NhTGpDeGJCS0UzS1RWdlgyaFJWVmZy?=
 =?utf-8?B?VW1kY0hpM0RHeVUxOVpieEFkdjJSWFNHV3JrZm1pSEJHZXJiczhRdjFoUGh3?=
 =?utf-8?B?V1drRkQ0QWphTHJMRFpJRjJORkpCMGpqcTFyU0pwWlhaNWFPOEJUY0RpcUp4?=
 =?utf-8?B?MzdVSDErS1VsczFnbFpPWTFYVkpHTDhyUU1JNXZHQ1dSeWdmeFVGcHJVZ1J3?=
 =?utf-8?B?ZGxHeWRtMFh4SWFDMkx3VlJ2aElPTEw3R251ME5JWVExa25vdmtqYjhTV1lX?=
 =?utf-8?B?UmJWT2NKZU1GcHFYTXUvRHVOTkRyeVZxZXJETkdQa2RwUm1JT1B2TzhHMndS?=
 =?utf-8?B?OXpBcDY3b0RxVFRzZXpBUmFnOXA1TDc4cDR2ckZKYytqVG1WanZZbWJkRUJp?=
 =?utf-8?B?VmRpZnBBcmxxSzB2U1NKTExSZ00xbUhYNTRGY25pbllqUWJRcmRDSnBGNHhz?=
 =?utf-8?B?eVZERldROWoyaFRCcmpsTFVxZll4TllrOVU0bDh5Rk1mZ25aNUNPNGtZU2tP?=
 =?utf-8?B?VldNQXBiZUhhYTBGRnVxYnEvUHQ1bDUzNUhxbUxxaGxqZTB5ZGtvZXdBSkwy?=
 =?utf-8?B?MDlDbEVjNlhrQXYramtDR0tuK0d6UFg2Ykt0WWYrMVJvZUs4djBmZS83cURL?=
 =?utf-8?B?WUszUFQxMS8yQlM2dGZoVUdpRjFYYTJGY1VseHdYQzV5bGFZbnpqQU1CcmhH?=
 =?utf-8?B?WTZvYlVyS2xmRXBrOElsQ21yNkRpbkFrSW5OMG9lbWxhRXhidmZaSytxRnlx?=
 =?utf-8?B?QTdWTmxGempsM2lUWXV4UkRWVXVLYW1GWHh2Nklmc0szUVJ1VmdIOHJuTytF?=
 =?utf-8?B?clVUNDdiaFYrV2lVU1kyeW5VNkJoMmpPVG5Ha09zNHpVVXZTUVZ4WmtxT3Nz?=
 =?utf-8?B?V1NlNXRVWXNKWnhDUGtIVnV2NGxORlU1MU5RdThwVk4ybk8zYi9rWXIyMWho?=
 =?utf-8?B?L2FwU2dWeTdtendRcUJWWFBmTld4amhGbTBmWnZzdzV3L0lEK0o5RFBrTUwv?=
 =?utf-8?B?TnExdW90bmNaRHBYYUI2dFVzRjQ4Z1NQOVZIKzhqR0JPbWQ0SXBiNk14YnBG?=
 =?utf-8?B?LzhoNzg4WVVDVEhMWCtkMnFLK1VVeW9ZY0Q0SVF6ZGZSMkJ3V25NWkFZSm1k?=
 =?utf-8?B?MWpndXoyY1N5RlpVVGIzVzA5cm9vREh6ZEVML0trTHErQVZSNllBM3hWaU9J?=
 =?utf-8?B?Qkw2Sm9XcFVzR0duNUc0bmNkbXZOU3JIUkoxSW0xMjBjVXVzS09tVTZhbzcw?=
 =?utf-8?B?TS9CVWxNd3dZTExqMUN3amtNRVlIQW0yWVBnSUg2R2JWTjEzOEtwMzVNdUdD?=
 =?utf-8?B?aEdDZ0kzRlp3aU1NSmJvTlV2K2JNLzYxQVJDbTFCSk9sU0xwWkpYYjgyL2pj?=
 =?utf-8?B?VGlRVzdEL0NpMi9selUyMzAybDM3YVBLcmhhaEFwdTRJUE1HZFVsd2k5NUV3?=
 =?utf-8?B?UGw0cGVSeDNUUzE0UnR1YnF3b0xvbDBDOHF4NWxmTVJpMkx6aVZQc20wbkFz?=
 =?utf-8?B?aXpyejFUZFVZbStMYlJGUFZyeXlra2hwV3g5aXA4dUVjRzdlc2lRL1RQNmFn?=
 =?utf-8?Q?5U0XSfwLBrddzqH+By7G+RLf55aVI5s/u766GcZWjQ4t?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437e77da-7d37-4e5b-8d5d-08da59f68173
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 17:40:49.6881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yp5KHjUUmDSv2pWETyGV9QQnMO68G25ZAANQTat+KThckbdcHBnHmwJ+iGKrrJPBPCBJ/GJ/ISVvRCx2KJL4Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2180
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-29_18:2022-06-28,2022-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206290063
X-Proofpoint-ORIG-GUID: 4obNUud4tMim9wdvZY71nsdW0NZCVcPP
X-Proofpoint-GUID: 4obNUud4tMim9wdvZY71nsdW0NZCVcPP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/30/22 04:48, Barry Song wrote:
> On Tue, Apr 12, 2022 at 4:07 AM Khalid Aziz <khalid.aziz@oracle.com> wrote:
>>
>> Page tables in kernel consume some of the memory and as long as number
>> of mappings being maintained is small enough, this space consumed by
>> page tables is not objectionable. When very few memory pages are
>> shared between processes, the number of page table entries (PTEs) to
>> maintain is mostly constrained by the number of pages of memory on the
>> system. As the number of shared pages and the number of times pages
>> are shared goes up, amount of memory consumed by page tables starts to
>> become significant.
>>
>> Some of the field deployments commonly see memory pages shared across
>> 1000s of processes. On x86_64, each page requires a PTE that is only 8
>> bytes long which is very small compared to the 4K page size. When 2000
>> processes map the same page in their address space, each one of them
>> requires 8 bytes for its PTE and together that adds up to 8K of memory
>> just to hold the PTEs for one 4K page. On a database server with 300GB
>> SGA, a system carsh was seen with out-of-memory condition when 1500+
>> clients tried to share this SGA even though the system had 512GB of
>> memory. On this server, in the worst case scenario of all 1500
>> processes mapping every page from SGA would have required 878GB+ for
>> just the PTEs. If these PTEs could be shared, amount of memory saved
>> is very significant.
>>
>> This patch series implements a mechanism in kernel to allow userspace
>> processes to opt into sharing PTEs. It adds two new system calls - (1)
>> mshare(), which can be used by a process to create a region (we will
>> call it mshare'd region) which can be used by other processes to map
>> same pages using shared PTEs, (2) mshare_unlink() which is used to
>> detach from the mshare'd region. Once an mshare'd region is created,
>> other process(es), assuming they have the right permissions, can make
>> the mashare() system call to map the shared pages into their address
>> space using the shared PTEs.  When a process is done using this
>> mshare'd region, it makes a mshare_unlink() system call to end its
>> access. When the last process accessing mshare'd region calls
>> mshare_unlink(), the mshare'd region is torn down and memory used by
>> it is freed.
>>
>>
>> API
>> ===
>>
>> The mshare API consists of two system calls - mshare() and mshare_unlink()
>>
>> --
>> int mshare(char *name, void *addr, size_t length, int oflags, mode_t mode)
>>
>> mshare() creates and opens a new, or opens an existing mshare'd
>> region that will be shared at PTE level. "name" refers to shared object
>> name that exists under /sys/fs/mshare. "addr" is the starting address
>> of this shared memory area and length is the size of this area.
>> oflags can be one of:
>>
>> - O_RDONLY opens shared memory area for read only access by everyone
>> - O_RDWR opens shared memory area for read and write access
>> - O_CREAT creates the named shared memory area if it does not exist
>> - O_EXCL If O_CREAT was also specified, and a shared memory area
>>    exists with that name, return an error.
>>
>> mode represents the creation mode for the shared object under
>> /sys/fs/mshare.
>>
>> mshare() returns an error code if it fails, otherwise it returns 0.
>>
>> PTEs are shared at pgdir level and hence it imposes following
>> requirements on the address and size given to the mshare():
>>
>> - Starting address must be aligned to pgdir size (512GB on x86_64).
>>    This alignment value can be looked up in /proc/sys/vm//mshare_size
>> - Size must be a multiple of pgdir size
>> - Any mappings created in this address range at any time become
>>    shared automatically
>> - Shared address range can have unmapped addresses in it. Any access
>>    to unmapped address will result in SIGBUS
>>
>> Mappings within this address range behave as if they were shared
>> between threads, so a write to a MAP_PRIVATE mapping will create a
>> page which is shared between all the sharers. The first process that
>> declares an address range mshare'd can continue to map objects in
>> the shared area. All other processes that want mshare'd access to
>> this memory area can do so by calling mshare(). After this call, the
>> address range given by mshare becomes a shared range in its address
>> space. Anonymous mappings will be shared and not COWed.
>>
>> A file under /sys/fs/mshare can be opened and read from. A read from
>> this file returns two long values - (1) starting address, and (2)
>> size of the mshare'd region.
>>
>> --
>> int mshare_unlink(char *name)
>>
>> A shared address range created by mshare() can be destroyed using
>> mshare_unlink() which removes the  shared named object. Once all
>> processes have unmapped the shared object, the shared address range
>> references are de-allocated and destroyed.
>>
>> mshare_unlink() returns 0 on success or -1 on error.
>>
>>
>> Example Code
>> ============
>>
>> Snippet of the code that a donor process would run looks like below:
>>
>> -----------------
>>          addr = mmap((void *)TB(2), GB(512), PROT_READ | PROT_WRITE,
>>                          MAP_SHARED | MAP_ANONYMOUS, 0, 0);
>>          if (addr == MAP_FAILED)
>>                  perror("ERROR: mmap failed");
>>
>>          err = syscall(MSHARE_SYSCALL, "testregion", (void *)TB(2),
>>                          GB(512), O_CREAT|O_RDWR|O_EXCL, 600);
>>          if (err < 0) {
>>                  perror("mshare() syscall failed");
>>                  exit(1);
>>          }
>>
>>          strncpy(addr, "Some random shared text",
>>                          sizeof("Some random shared text"));
>> -----------------
>>
>> Snippet of code that a consumer process would execute looks like:
>>
>> -----------------
>>          struct mshare_info minfo;
>>
>>          fd = open("testregion", O_RDONLY);
>>          if (fd < 0) {
>>                  perror("open failed");
>>                  exit(1);
>>          }
>>
>>          if ((count = read(fd, &minfo, sizeof(struct mshare_info)) > 0))
>>                  printf("INFO: %ld bytes shared at addr 0x%lx \n",
>>                                  minfo.size, minfo.start);
>>          else
>>                  perror("read failed");
>>
>>          close(fd);
>>
>>          addr = (void *)minfo.start;
>>          err = syscall(MSHARE_SYSCALL, "testregion", addr, minfo.size,
>>                          O_RDWR, 600);
>>          if (err < 0) {
>>                  perror("mshare() syscall failed");
>>                  exit(1);
>>          }
>>
>>          printf("Guest mmap at %px:\n", addr);
>>          printf("%s\n", addr);
>>          printf("\nDone\n");
>>
>>          err = syscall(MSHARE_UNLINK_SYSCALL, "testregion");
>>          if (err < 0) {
>>                  perror("mshare_unlink() failed");
>>                  exit(1);
>>          }
>> -----------------
> 
> 
> Does  that mean those shared pages will get page_mapcount()=1 ?
> 
> A big pain for a memory limited system like a desktop/embedded system is
> that reverse mapping will take tons of cpu in memory reclamation path
> especially for those pages mapped by multiple processes. sometimes,
> 100% cpu utilization on LRU to scan and find out if a page is accessed
> by reading PTE young.
> 
> if we result in one PTE only by this patchset, it means we are getting
> significant
> performance improvement in kernel LRU particularly when free memory
> approaches the watermarks.
> 
> But I don't see how a new system call like mshare(),  can be used
> by those systems as they might need some more automatic PTEs sharing
> mechanism.
> 
> BTW, I suppose we are actually able to share PTEs as long as the address
> is 2MB aligned?
> 

The anonymous pages that are allocated to back the virtual pages in vmas maintained in mshare region get added to rmap 
once. mshare() system call is going away and has been replaced by fd based mmap instead in the next version of this patch.

Thanks,
Khalid

