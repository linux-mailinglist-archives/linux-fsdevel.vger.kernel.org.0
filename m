Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F2556935F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 22:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbiGFUeM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 16:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbiGFUeE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:34:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2D363DF;
        Wed,  6 Jul 2022 13:34:02 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266IWeOv009665;
        Wed, 6 Jul 2022 20:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1Zsk6IQYJnXc3etZkAgP5C7zvqumVy27zhKwmhQ/H18=;
 b=c7bHg/IW12FsnjXK4VyZW9FW5mFcjVVY2E49MArhokUBUim4hLCmFRF0P282gO5gLeiB
 CujQYpsc6EuYuis1EV1m+I4/MwBy2yc9KLLuE2FMeedpKyKiiBcPLwpAqO98bdSqjCfN
 UaMHaSx7fm99oh9z9cqTtnEkNaYjpeiAZJyzHL7t7GbXzZhBDr1YLWQGgEgs8e/1yk3u
 Eq5NmVz0c175CH1W7xIt/KIY8+kSBwxgX68izcd7z6UtTK8FAzfO6cPnjqqutxw/fRuM
 cMZ/arT8Vw3BxkmHR3EBU0JacOeczxY5gPfVC6rhoByUjAfIfbubqpgt4FpQOIBiVviJ WA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubybak1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 20:33:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266KLS9S036116;
        Wed, 6 Jul 2022 20:33:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud8c68v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 20:33:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUl4JoeiTLukmpEMK41UuyPmUHfDCROd7iZKDUDyZQvhYthu/DZpu5BQMDRCBHWb/0E9LQfkATlzs/pw3AbjFA6KSw0vnNEJhp0JAemnjLHu4bMpy/GWN4TEd3memWMh+xOydd+XvoJDy1JOpRxxP1r6MGr7UOle4pdxvvjP5LsXuByDx+lValwopf/ubf6wmsrDehlhBdlCrxUQSCXII9xUu1u1ue8UxAD0X3GjEs7gkMFo3Oqz6lTT1o/9flxVGmMr6wz7tYV27RsiEDMLum0oMW+de/1i6ANvtt0Q23Tf8H6vHZK2fYoFDBzu1GCce9CabpeKV5S9FzpUe12Lyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Zsk6IQYJnXc3etZkAgP5C7zvqumVy27zhKwmhQ/H18=;
 b=lU99RLcLfGBgPMtfdqgVxNAg9IRsuccAMqs7lD+arjZqnWjm0o8n3aZmb9qA/XZIg9F1mWJIx/Fgl66VHW0PVd2OF/xE0j3lHBowuro3wujlz4KRcxxr5dqaqQO7soYnZU3ekqTdo0Y0J3KrSAxEu0dskJYBPfKYwXWtH0fomJoqX6Pul17G7rJjhWdmJNLew/JO51NnmLSJ9wRKRlmg/TDkzEBYr4DDlWIATkcxLsz/fLSFl2GUughGsF8+3LK3kLzA2gz0nh/DJyxuah9B7l2ZeqbPj30+pauaoPkEo3761MwmwPTXkhyFzllRG7zy6vhuCAdcK8oD3qHeWAdz2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Zsk6IQYJnXc3etZkAgP5C7zvqumVy27zhKwmhQ/H18=;
 b=pDQRjEoU5p01KT10rjMyyFCyz72caXm5u/k2b3YjGUIT765jyXQ5yH40Oqy8pa/7Ua9TpXOvaEyYueaxGjUQHJPfOsRqGrvSq/qfzqlqY/42E5qIEEYK3+my42TGl/7AA3XXS1LJS30xqfvPabDBAXUxGK2/xLZZeUSLDk5hplU=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by IA1PR10MB6123.namprd10.prod.outlook.com (2603:10b6:208:3a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 6 Jul
 2022 20:33:16 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::71ec:3c08:c336:cc55]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::71ec:3c08:c336:cc55%5]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 20:33:16 +0000
Message-ID: <a8fce124-149f-ee46-6b23-a1805a32ebc1@oracle.com>
Date:   Wed, 6 Jul 2022 14:33:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 09/14] mm/mshare: Do not free PTEs for mshare'd PTEs
Content-Language: en-US
To:     Andy Lutomirski <luto@kernel.org>, Barry Song <21cnbao@gmail.com>
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
        markhemm@googlemail.com, Peter Collingbourne <pcc@google.com>,
        Mike Rapoport <rppt@kernel.org>, sieberf@amazon.com,
        sjpark@amazon.de, Suren Baghdasaryan <surenb@google.com>,
        tst@schoebel-theuer.de, Iurii Zaikin <yzaikin@google.com>
References: <cover.1649370874.git.khalid.aziz@oracle.com>
 <f96de8e7757aabc8e38af8aacbce4c144133d42d.1649370874.git.khalid.aziz@oracle.com>
 <CAGsJ_4xC0sB0x2orOcKgx4p0fa5Y0bR9qeviq1_Q7VmhMk2d6A@mail.gmail.com>
 <e5bebb34-5858-815c-9c2c-254a95b86b07@oracle.com>
 <48e40b61-f506-72a1-0839-08bc9db483cc@kernel.org>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <48e40b61-f506-72a1-0839-08bc9db483cc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0401CA0038.namprd04.prod.outlook.com
 (2603:10b6:803:2a::24) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3716395-7ddd-48ba-7629-08da5f8ec15b
X-MS-TrafficTypeDiagnostic: IA1PR10MB6123:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ty1NSxFYuK/vvTNOGh4epoPwohSwxf5HoB6kA4uLqoHnhaHNvY1kUqyq5i804/rB+jhbk7pKsbCPilIfDeTSStAaTrB1KkAWK+OlHZe6hCQWbbA5Au7oh3192kqToIzbglxPHjccNI9yCME+pOEyd+CfkSQ3wNoAa/gPoM4sf9kzIGdahhlTEfK5IqCUo3pr8jhkSbvlBF1Q44KlbG/kVC5BM69fvQKVGdhumwRmARlronrcQzFBrbE9kPFukpTmn8d3KvS507eEz9gpL05hFu3ttuiqnjpaAnsMhqxRa1keZyfzSx0wjgyVU8ibSvDdUANAMjJXL4xT7D9K+0fynR0cT7mUKwUTdYmlLdmaOywQG1SxVypkNaQqVfykcuqn5hNIKKTLY052ko55Je28dgJCIObFQ4EOjeDRdEtFnaVjfVuQltrDXRV3dasdkAv63yKsbalniGVa94hL754uMo9SUcbQbXkhpzQx8y75K1bHdNutmOydcLK1PqQBRdJe6AXtk4rHCKmQc/07ab1bP8uZcfkOqi5CsanZ/Wxj3XzN9vycdV0hVpQJe3BH/kH10T5JfoC4NrpQdRct0BgCJ8LVlKTEHqr7gm/NwMuNv0MSFBD3f5ED0vKtctoqgpjyxcVFx7NLRCEz117UWCTsFNElggYZwnlNViwzF6NOh2sYyAxCFC6CUfjXKcBDnd3jEuWlhBjqSQHIrc1xRMtJFy/rHh6nuK16eCuI144Zf82EJBJKyXh5n0z2tzW+9/dhIOvR1BuugE1j2khr3vtwnKVcO7GXfgGwSYfaRVhal9DTW81Cjkxvf+8Vz/7FHzJid+3OFlL2kbwutQB6UhWNVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(39860400002)(396003)(136003)(376002)(31686004)(2616005)(66556008)(110136005)(26005)(6512007)(8676002)(54906003)(66476007)(4326008)(83380400001)(186003)(6486002)(53546011)(66946007)(38100700002)(6666004)(478600001)(7416002)(2906002)(44832011)(36756003)(5660300002)(31696002)(8936002)(316002)(86362001)(41300700001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0RGQVBEN2NFOUFra3NyME5ndVR0QUFZeXZTdmcwYjBkZzRiRTYwK3BUb3lq?=
 =?utf-8?B?WkVrSG1LR1Q0ejI4WG85OE1ubHp5aVQ3QUZEbHFaakNjeklrQTdQN3RKNSt4?=
 =?utf-8?B?Y2EvLzJ1dW9peXRGb2ZpYjlaelU0cDVEcC9qcS9EbSs4dzRJQ2F2ckZHSmha?=
 =?utf-8?B?WnlpV2dpTTlqM2s2b3QrRmV2MGgzZmMyWHlwMFN4Wnp3Umk1ZEowc2FUNWRM?=
 =?utf-8?B?cnBTZWQwVlZucGQrM1cyMVgwTGJEYnlaWUpRK1MrYVE2eWhzVlZmeVZ5MjA3?=
 =?utf-8?B?N1ZWVWd5YTZHQktlSDdTVXRFVUVMQU05dFY0UmZOTy8yeHJkTzFscFpSWitK?=
 =?utf-8?B?WmJBTjBzRlNib05KaVFlN3dSdWZRdVkvR0hRdU84T1NXNjhjV0RxOGxsanNK?=
 =?utf-8?B?VjhUUFVoRjVGbFAzODlEZzNlQUJvR3pQSkt2bExyNGZhOUZZNUFtaG9RaDFr?=
 =?utf-8?B?UmpZL2ppM1BnYVhkeEQ0MU54eE8zbURRWmtxd00vclBQZDJwdnhsb2c1R2tN?=
 =?utf-8?B?MjFROUFXZGE3VW1TMVgwckxPMVJpU1ZRWEtqWko3dHBIRHBVNkx4ODhycWw0?=
 =?utf-8?B?RStJT3NzWkhFTGM5c2xkdmhyQVpueXV3NnF2ZlRKTHdoZFROVXQzS2ZKNTkw?=
 =?utf-8?B?VHNPV1JJLzkxb240aTBrSTM4THhROEcxMTh5UkpOT1Z0MUlYRkl0U25FQXBN?=
 =?utf-8?B?YUVuVUpXc3RwQjVXMlVOZjdOMmcyb2xmYWN4SXN2RDNwY3RiSkZzOUptbWZC?=
 =?utf-8?B?Y2k1ZXhId09xaGEweUsyZHJibTBQVUozenRJallWclVuUmFrb1ZWUGZtaWU5?=
 =?utf-8?B?czZpZjcwb2tiRSt0RlVxQlVqOW5qWkR1Zzl0QTZXQnU3Y1VGSElHcktERmFC?=
 =?utf-8?B?MDRVRVpHVEJGemV6elZDTExwMCtXclozZmlXS0Q1L2hHMW5TQjc5VWdVZEF3?=
 =?utf-8?B?RDBaaGdBM1huczVvOUVJVEFZUzFTRHZ3VndDcGNKZTdKSFdTbmxqZ3I5VHhK?=
 =?utf-8?B?YmFGZ2pkNGE0Ynp3RDdsN0RTSnFpWjMrSUtRRkFTNzFtTDVTOWJ3Yk1MbzVk?=
 =?utf-8?B?ekRtWkdDODBhNW50Z0VzOTFPZ1kyUUtsR2g1eVlIRkE0Z0wwNDRkeC9LdlhY?=
 =?utf-8?B?WU1tUjdZdFk4K1VBTzFGMVN3SmE4WUNwSm5Ddmt2QXlDc25ObWZXUDFBUzJE?=
 =?utf-8?B?djd1dkF6SWJqOXdyY2cydzhvSHd1SXBjTlBLd1lkVXY5dkZLKzArMWQ0VXBn?=
 =?utf-8?B?UmxCNC9mSCtoc2lTZWtnZWdkUUxNdWI1Y1YvcGluSjc1THMwYmUxMWhPQUkr?=
 =?utf-8?B?ZUxGMW9uMUVVZk40cUc2RlFwRFVBNld0Qms5SDVQcGdlZFltMjRHWHJqQWov?=
 =?utf-8?B?T2c1eHpPTGtxZklVY3ZzVGYvUFZsdWVnd2VlUnpObWJvYUdPR3dBZ2ZhZ1RP?=
 =?utf-8?B?SVkyb2p3dHN0YzAzN3BRalUyVzNPWmJQQkxyU1NkQUF5VnEwVUVpV2FXbisy?=
 =?utf-8?B?UElYSWZJeXBmSWRUTXBXWC82MVFqbS9md0pqaFYrMmRBRDBtek9UaXFDMmVi?=
 =?utf-8?B?c2psUXhJeUpHN01wVm00VUVGK0p3YzhpY0JDT3JDNVk1M2xiNmpWZUo2WWtK?=
 =?utf-8?B?RkZzUHVDbGswR0N4Y24yaWw4NG8xa0VDaXJ4TWM2YVZQeUcyclhDN3k3WUVO?=
 =?utf-8?B?NStxbFJkSkQrVmU0RCt2aDBDWCtkY0M3RDVjR24wSCsrSGtRa29PVXZpcWpy?=
 =?utf-8?B?SkFJdVM4dVVGZHEzR0FScDI0V1M1TWkxaEQ4TjI5ditmSGpBODZYeE9jOXEv?=
 =?utf-8?B?cHNIdElnbjlhUTR1em1nYVBnQnRLeWt6dWRBWGMrS0tNcFZxM1NhSnlpQ3lV?=
 =?utf-8?B?N2NwbW1yMWFySk1QSnZ0czFEODRURTA2bVFyS2wwejNHTDRxcjYwTWE3aG5C?=
 =?utf-8?B?S3dxSDZadkUrdVhyajJrcmpUM1NlTWJwUUFlbWNMUndjNm1SNVh5QzRJVnJD?=
 =?utf-8?B?UytRcEpnNEJyc05wRDBGUTU1RW9GeCtmanJGNG05amtlb3JPZURwZ201L1Bu?=
 =?utf-8?B?MkEyeXFjRkF4c0NKeXJaaVJoWXVlSWNNZ2RvYUlkMFpGNzlVTk4reldBY2Qz?=
 =?utf-8?Q?0PFr7BOC+boSgvZx0D6TYWhjY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3716395-7ddd-48ba-7629-08da5f8ec15b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 20:33:16.2369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HAMDS6Gy9h4VgAqYh8XrlEkqPBHU20rny4OlweixByL1UPEIE/u3mE68k/xj1Jom95NcQ2gG1LXjuhTjPvXoCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6123
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_12:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060078
X-Proofpoint-ORIG-GUID: QQeX6UGIw9DYecu7gdM_-qkOFuroQnKp
X-Proofpoint-GUID: QQeX6UGIw9DYecu7gdM_-qkOFuroQnKp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/3/22 14:54, Andy Lutomirski wrote:
> On 6/29/22 10:38, Khalid Aziz wrote:
>> On 5/30/22 22:24, Barry Song wrote:
>>> On Tue, Apr 12, 2022 at 4:07 AM Khalid Aziz <khalid.aziz@oracle.com> wrote:
>>>>
>>>> mshare'd PTEs should not be removed when a task exits. These PTEs
>>>> are removed when the last task sharing the PTEs exits. Add a check
>>>> for shared PTEs and skip them.
>>>>
>>>> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
>>>> ---
>>>>   mm/memory.c | 22 +++++++++++++++++++---
>>>>   1 file changed, 19 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index c77c0d643ea8..e7c5bc6f8836 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -419,16 +419,25 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>>>                  } else {
>>>>                          /*
>>>>                           * Optimization: gather nearby vmas into one call down
>>>> +                        * as long as they all belong to the same mm (that
>>>> +                        * may not be the case if a vma is part of mshare'd
>>>> +                        * range
>>>>                           */
>>>>                          while (next && next->vm_start <= vma->vm_end + PMD_SIZE
>>>> -                              && !is_vm_hugetlb_page(next)) {
>>>> +                              && !is_vm_hugetlb_page(next)
>>>> +                              && vma->vm_mm == tlb->mm) {
>>>>                                  vma = next;
>>>>                                  next = vma->vm_next;
>>>>                                  unlink_anon_vmas(vma);
>>>>                                  unlink_file_vma(vma);
>>>>                          }
>>>> -                       free_pgd_range(tlb, addr, vma->vm_end,
>>>> -                               floor, next ? next->vm_start : ceiling);
>>>> +                       /*
>>>> +                        * Free pgd only if pgd is not allocated for an
>>>> +                        * mshare'd range
>>>> +                        */
>>>> +                       if (vma->vm_mm == tlb->mm)
>>>> +                               free_pgd_range(tlb, addr, vma->vm_end,
>>>> +                                       floor, next ? next->vm_start : ceiling);
>>>>                  }
>>>>                  vma = next;
>>>>          }
>>>> @@ -1551,6 +1560,13 @@ void unmap_page_range(struct mmu_gather *tlb,
>>>>          pgd_t *pgd;
>>>>          unsigned long next;
>>>>
>>>> +       /*
>>>> +        * If this is an mshare'd page, do not unmap it since it might
>>>> +        * still be in use.
>>>> +        */
>>>> +       if (vma->vm_mm != tlb->mm)
>>>> +               return;
>>>> +
>>>
>>> expect unmap, have you ever tested reverse mapping in vmscan, especially
>>> folio_referenced()? are all vmas in those processes sharing page table still
>>> in the rmap of the shared page?
>>> without shared PTE, if 1000 processes share one page, we are reading 1000
>>> PTEs, with it, are we reading just one? or are we reading the same PTE
>>> 1000 times? Have you tested it?
>>>
>>
>> We are treating mshared region same as threads sharing address space. There is one PTE that is being used by all 
>> processes and the VMA maintained in the separate mshare mm struct that also holds the shared PTE is the one that gets 
>> added to rmap. This is a different model with mshare in that it adds an mm struct that is separate from the mm structs 
>> of the processes that refer to the vma and pte in mshare mm struct. Do you see issues with rmap in this model?
> 
> I think this patch is actually the most interesting bit of the series by far.  Most of the rest is defining an API 
> (which is important!) and figuring out semantics.  This patch changes something rather fundamental about how user 
> address spaces work: what vmas live in them.  So let's figure out its effects.
> 
> I admit I'm rather puzzled about what vm_mm is for in the first place. In current kernels (without your patch), I think 
> it's a pretty hard requirement for vm_mm to equal the mm for all vmas in an mm.  After a quick and incomplete survey, 
> vm_mm seems to be mostly used as a somewhat lazy way to find the mm.  Let's see:
> 
> file_operations->mmap doesn't receive an mm_struct.  Instead it infers the mm from vm_mm.  (Why?  I don't know.)
> 
> Some walk_page_range users seem to dig the mm out of vm_mm instead of mm_walk.
> 
> Some manual address space walkers start with an mm, don't bother passing it around, and dig it back out of of vm_mm.  
> For example, unuse_vma() and all its helpers.
> 
> The only real exception I've found so far is rmap: AFAICS (on quick inspection -- I could be wrong), rmap can map from a 
> folio to a bunch of vmas, and the vmas' mms are not stored separately but instead determined by vm_mm.
> 
> 
> 
> Your patch makes me quite nervous.  You're potentially breaking any kernel code path that assumes that mms only contain 
> vmas that have vm_mm == mm.  And you're potentially causing rmap to be quite confused.  I think that if you're going to 
> take this approach, you need to clearly define the new semantics of vm_mm and audit or clean up every user of vm_mm in 
> the tree.  This may be nontrivial (especially rmap), although a cleanup of everything else to stop using vm_mm might be 
> valuable.
> 
> But I'm wondering if it would be better to attack this from a different direction.  Right now, there's a hardcoded 
> assumption that an mm owns every page table it references.  That's really the thing you're changing.  To me, it seems 
> that a magical vma that shares page tables should still be a vma that belongs to its mm_struct -- munmap() and 
> potentialy other m***() operations should all work on it, existing find_vma() users should work, etc.
> 
> So maybe instead there should be new behavior (by a VM_ flag or otherwise) that indicates that a vma owns its PTEs.  It 
> could even be a vm_operation, although if anyone ever wants regular file mappings to share PTEs, then a vm_operation 
> doesn't really make sense.
> 

Hi Andy,

You are absolutely right. Dragons lie on the path to changing the sense of vm_mm. Dave H pointed out potential issues 
with rb_tree as well. As I have looked at more code, it seems breaking the assumption that vm_mm always points to 
containing mm struct opens up the possibility of code breaking in strange ways in odd places. As a result, I have 
changed the code in v2 patches to not break this assumption about vm_mm and instead I rewrote the code to use the vm 
flag VM_SHARED_PT and vm_private_data everywhere it needed to find the mshare mm struct. All the vmas belonging to the 
new mm struct for mshare region also have their vm_mm pointing to the mshare mm_struct and that keeps all vma operations 
working normally.

Thanks,
Khalid
