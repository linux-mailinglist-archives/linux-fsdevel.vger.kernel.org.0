Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFD13EDC49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 19:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhHPRVF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 13:21:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:54402 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229699AbhHPRVE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 13:21:04 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GHHWjC027582;
        Mon, 16 Aug 2021 17:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=htlf8fgSsF8vrPzgN/wt+wMyAzm5ylBOLIPTw1R6HVY=;
 b=beA2aaeyjPB16aL2Y1/2Dw9Ml2OqO+NBl0GYdAimLdxUnVugwc320YMODY3IYU11ur8p
 boih1rT5r3F5W74cStW+z0+iIcvBmtrKvPU78B/7E7hIRTNwwOaRqWY9cP6qPD1fXYd7
 7P0p9PiutSj+RxJoSTW46ktJZxvpT3Hlf1SAe42U+ENIx/mMSEPiEgpol1a0/4rq8fz8
 FuiNsZqBunXrqXaVonOAL4cD66+cF/d961Dbt8Du2mt6K7DXi5ZDULU0HxZAMAeomPu9
 Xs3QfWHxMQt353z8Qm4HMdfz/SpgoNPK8L8mekSZS26QNpf6Ny85n8HmpbbJDzpQLA1x MA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=htlf8fgSsF8vrPzgN/wt+wMyAzm5ylBOLIPTw1R6HVY=;
 b=nzGF185ZPUHmOoUV7l5fZl87vkyRubsIYNCwmxASx7a+uNFJoPXtqlEVMKGw91oLOw2z
 BWuOPRj1a00A1DFnECF4XDJdtUyDlyawTxGMwVS2qWJHwlXuWSsSFAZLwIbKLnz0L5ob
 BLQaWd5fARkPhuiREG/z/PtPaZowgS1q4NjIxS4dhTZOTaGp9JnmSEvnfC8fK9SiB90E
 tmznTqP+1GPpFZIY93UjQFcp/OOISSVEsCdJm1NV/hsqJbGLtb1ZwduZIGgo0YfY5bfV
 mxrTdr3qEhB4cjaIJPb1/cKJAKz3rZ44YxxjE7pZZfyFnRREmiwAKTgmQFI8c4PJCK3E uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3af3kxtm16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 17:20:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17GHExv5077032;
        Mon, 16 Aug 2021 17:20:18 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by userp3020.oracle.com with ESMTP id 3aeqkshs7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 17:20:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWGcv7jKWD+xON8gEQa4/D26TNO2e/T5Vh8bO0cyYvRvYVR8grm/eLyCOm9fm7jEU/jW4id8dpffhYTF3VDPFGBn4P0Iwjq0yWuQmeS5tPoink9FyzAespd6y39QcHFwvQAh+RzS6HVdMkvJGsn8kzeVgPD4wazJiLmr2kWVTe3Y8iU8qnA0jYG/WRVmcpJTz6ER/O7mRwMT6KG8HPMqUgEno6ZoUTZITObwHahnwYNPgsrhP+ipkTRCSPS6VAJmgEuB9rzrQO0woz4hVh9C9onbmPsw7nQ6cm2o5nj9KVjTdRdnxClldrtWCDZiDuOjoRfUwVdfHe3kt71yp2idBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htlf8fgSsF8vrPzgN/wt+wMyAzm5ylBOLIPTw1R6HVY=;
 b=KleZtGH7rrjcn/gZYOHuLVfTBNy6o9z8Wk9eJAndZ029VPu0WH0iaXDVFWsfnAAQbHKVIlVawIfHYvU0loD+agexKoV5XKPYlpygLmPCEazydhsN19aJBFKqTjXfAqH/nzHNXRr/D3vI39IjkWf0JppYt8jfPWsn2FNxAhW2loSytV5HIYh6v1A1kdnPlkvcyP7xuyyFDiiHDsciiND3X/s5NKqH2L6E2OiYfVRbXarGm50qg+Tfjb0sZETMmfuiLQ6pQdR9wc1E3YCNIRMvOovj8r3MumLtmUmbOFQE6TtXoYiAK3wrATGTjO7+h0QoJ6bZAae8LOhVygIJ6h5TUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htlf8fgSsF8vrPzgN/wt+wMyAzm5ylBOLIPTw1R6HVY=;
 b=JAND62GxIbaxOECHTc9KMsUlH5ano6RceCIKumd6LoxUSqaE6cf1S/yDTnIrEF1PqgJ1PqKw9oL0NeZtdnN0Qg8RXLnZ7LFRjM3jm18mzVRI+ijFgZ6/UytZQ5LQGWrHMPVafSlPXBB/tc7Kwj7r/pd0bpXVWmfxBW4uhvMcuEc=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BY5PR10MB3779.namprd10.prod.outlook.com (2603:10b6:a03:1b6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Mon, 16 Aug
 2021 17:20:11 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::bc10:efd4:f1f4:31c7]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::bc10:efd4:f1f4:31c7%5]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 17:20:11 +0000
Subject: Re: [PATCH RESEND v6 1/9] pagemap: Introduce ->memory_failure()
From:   Jane Chu <jane.chu@oracle.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com
Cc:     djwong@kernel.org, dan.j.williams@intel.com, david@fromorbit.com,
        hch@lst.de, agk@redhat.com, snitzer@redhat.com
References: <20210730100158.3117319-1-ruansy.fnst@fujitsu.com>
 <20210730100158.3117319-2-ruansy.fnst@fujitsu.com>
 <1d286104-28f4-d442-efed-4344eb8fa5a1@oracle.com>
Organization: Oracle Corporation
Message-ID: <de19af2a-e9e6-0d43-8b14-c13b9ec38a9d@oracle.com>
Date:   Mon, 16 Aug 2021 10:20:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <1d286104-28f4-d442-efed-4344eb8fa5a1@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0191.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::16) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.39.192.148] (138.3.201.20) by SA0PR11CA0191.namprd11.prod.outlook.com (2603:10b6:806:1bc::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend Transport; Mon, 16 Aug 2021 17:20:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84382469-5d6e-4cbc-2bfd-08d960da1a72
X-MS-TrafficTypeDiagnostic: BY5PR10MB3779:
X-Microsoft-Antispam-PRVS: <BY5PR10MB3779F4F5595DAC9372E03371F3FD9@BY5PR10MB3779.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FbSO7Dlex8jaGX0jopAshHdlVuS0hL+d6XGJIydmVIWicI8bQRcBfPYs2neWgJdWeirkrCLhAY/B0U5VjCwbIbKwJi7cm50dmetYrNe1oRFXbEPaxvD3uSlOcFPHUlZ8s2u4RFZUVWpXledxMVAmfZsMMsWTOErFW1DDTpYZH77AR0l9oMK1JuxnNXA3JhH9+l6nL0zOhvsLk+ofvz/6jHbqSSt2foqHLlwZIthYorYbJyUnhd0bojg8YlX8DURO5OUBt66fcvb9oltLGF+a4fZLpEnxfCNtu9gWz3gjUR8ts7Do5ON6mcJyaNPAssvzQ0U3TlAuaItlLjGkzeNRzC9fgka/HMyT3DWt73So1wwvWKoPhKGr/I5s7Cdgkvev9gdO1gXYDjSqSLp3NGr3TCdTy7oiprSNB9SUg5qX8bMSM6QlZKWenKjeV5QcRL/WU4jw5HP5N28lDD5Gsu13a2pRTGQSLusFz89rKVfWpThs1QFPAYz1lb+wY5nb+dtNiXYCtakhEnJLFp8T89xC8d8QZAucMvL/2WCgut1zlQo1jAhKeZhsfo6XOSox65Og+oyHm65IVEHziTonWpKd54x5CfLXQgSa/WWTknIGRLFDpNQBHctYEwp1R1GFgM2V2rSmpHjhhtNy7bePnXOg8FDEElR09rWO5JoNlOODM+G5lO/5kKkIjYMUPDMcdSFtIHw2Kba7gqGygx91JDszz/PEhkr1IynbI1y6ocvOjK4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(186003)(16576012)(7416002)(26005)(2616005)(2906002)(5660300002)(83380400001)(316002)(4326008)(956004)(66946007)(36916002)(38100700002)(8676002)(31696002)(6486002)(6666004)(508600001)(66556008)(66476007)(44832011)(53546011)(8936002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXZPMERKeXQ1SkRwVnBIMStzRlJGNU5EVXlRUGlDaDZ1QWtsbmhwVWNtT090?=
 =?utf-8?B?dUxiK0t3QzVTTWxsNUlUeWpHY0I5YVZHTERYaDgwdE1zSExPaGVhOGVYNlFi?=
 =?utf-8?B?MmptNUJuNDZtZkVMUHR3Wlk1bStQalMzOFhSbGNFWFdtZ2M5U2dXb3VjTFhX?=
 =?utf-8?B?WSs1aGRuNW4wY2FSUUJjeTVDYSt3YW5xTjlCaDdPRy9OWmNoVzdaayt3bFNR?=
 =?utf-8?B?cVNZUWhPeFVhS3FENVVCN0t4RzFUaUJmVE0vWFBUZi8vSVZFOGxaeStQY0pr?=
 =?utf-8?B?dHQzc2RZeXhzeFJaMEkxZnZUZnptRllOaDdtMmkxZ3M0Mm16ZUlJSm5PbHVj?=
 =?utf-8?B?RVFDam81aVNwMi90Y0hJREpXSlQ2b2JrYVNLTzBIZ3hPL1p2ZFJIVlhYM2dX?=
 =?utf-8?B?MmN2NHlybHAvT0FDU0dQbThKTGI3OEdyVDhtMWJoQW1sWXd1S1RhcUx4N2lE?=
 =?utf-8?B?SDNPQ1YxTFRwVkF3VlFBaU1FUysyS3k4a0txUU1QOWxNaERWbUlNNWNLcVVw?=
 =?utf-8?B?VmdtMzlFVnJIS3VlQTExbmgwQjlvNUhCc3Y0YXZIVjI3UzVqWlRkdVFHcGN6?=
 =?utf-8?B?NXgzbkRWYVJhMnlwSmFIUkk5VHlMaEU5Rkp6djdDTDFETjF4aTlONlljZ1Zo?=
 =?utf-8?B?UmFQWG9STjZEMXJYRkFmSjhFZmY0S3A3RExHaGNERFZ4ZWxZYmpPYUR0VmdD?=
 =?utf-8?B?NXQ5b3FLeXA2dkd1VWlyVlhQT3VKa0hLR2F3djBjMDZBeDgyVnNqblVaSDJV?=
 =?utf-8?B?UXVGamxTZmo5WEJHS1BrcjlzVWJUSy9YTGZpaXIzNkhMTlZ1cmZZcXFQM3Js?=
 =?utf-8?B?UW40YXNXd2RBeXMwTmdUOVQ3NjR0Vm9mVlZXUm1wdE5LMHFaTi9kdVR1VVNo?=
 =?utf-8?B?b2RTcm0wbnZLNFpRUnZub1Z0NmhVcTZSOE1rVzNDVjRuM2srSjNYVExPQ2xN?=
 =?utf-8?B?QW1zemJTQzJrbUNiOWdJQ0NnaEo5Tk5FNFUxaVpObGF3cUN4U3JGamttNkdQ?=
 =?utf-8?B?SnhoQUI5ai9HTDA1RE1XNkxGZmJBUG9DbkRKRTJRRjIvdGREazRNM3VmYUNl?=
 =?utf-8?B?dWJwSiszd3FLSlVybWd0d1YrbXVBeTBhL0lYcUowTUFpa25XNEU4Y1RTeUcw?=
 =?utf-8?B?WTE3a2loajMzZG9abVRqeVRVMTRMOFlqQWtiN0tBL01JdEVFU0Z6VHM2cktB?=
 =?utf-8?B?RXpEU01iV3RRVHJwdktRTVZtNHB2VGZaYnZIRjBEbmVzTk1KQXhLOCtyVWJ3?=
 =?utf-8?B?R3M1MFp3VWdDQ3B3OE5zRWsxaEZ0cExzcFhqRHFxVWtQbWtNeXJwQzJ4M2hj?=
 =?utf-8?B?d2NVRW5pamdBZ1AxU1JjTWxOc0pkM21YRVFuaTBnNnlwa2RrZ1QyNE9UMVlW?=
 =?utf-8?B?eGZHYjVQNzh4bEhvSE1XY3MzaWNUQzJxZVI1VHh6aGl2ZGtFOVBpTDJhZUJw?=
 =?utf-8?B?ajhaeFJHYzV3QUFZL2lUSTZ1aUt6cnFDZk1nak8veVpEUDlFeDEyNTBKR0ww?=
 =?utf-8?B?NHVVcnpGM2ZBenVxYjNaOWNhUDFZZWZPR0pvUk1CM2dsYkI3UHlNRDQ0dDRN?=
 =?utf-8?B?L1AvVVhvSUR3R3VnK3VUSHdPaUpVeUErRjZjQmZRSWp1MWM1UCsxQTNESWxJ?=
 =?utf-8?B?Mk1YTUJaM3psREFtcXpNOExhd1BrbDNCNnc3THFLdTNCVnVrR1dUbFdNVmNu?=
 =?utf-8?B?TU5UVlcrSmIxU28xYjI1aG5DSlQ4MWFneXBZMTRoVEJBWHdGVkdIcUNpZDZT?=
 =?utf-8?Q?DVHj7EZ7F/1HZDGWSN53NMLoy2pU0Cql7Ie/2WA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84382469-5d6e-4cbc-2bfd-08d960da1a72
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 17:20:11.3906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BsjxFr0Veui/QrnMQRofwytg9X6H/yMcCOAPkh5GT3Z22dnnQdb1p+XUy3Qsov9C++CXVopUUmGQvwCYDbhhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3779
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10078 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108160110
X-Proofpoint-GUID: xeswe8pJorPdvPGXcJacbHFRIl1yadvs
X-Proofpoint-ORIG-GUID: xeswe8pJorPdvPGXcJacbHFRIl1yadvs
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, ShiYang,

So I applied the v6 patch series to my 5.14-rc3 as it's what you 
indicated is what v6 was based at, and injected a hardware poison.

I'm seeing the same problem that was reported a while ago after the
poison was consumed - in the SIGBUS payload, the si_addr is missing:

** SIGBUS(7): canjmp=1, whichstep=0, **
** si_addr(0x(nil)), si_lsb(0xC), si_code(0x4, BUS_MCEERR_AR) **

The si_addr ought to be 0x7f6568000000 - the vaddr of the first page
in this case.

Something is not right...

thanks,
-jane


On 8/5/2021 6:17 PM, Jane Chu wrote:
> The filesystem part of the pmem failure handling is at minimum built
> on PAGE_SIZE granularity - an inheritance from general memory_failure 
> handling.  However, with Intel's DCPMEM technology, the error blast
> radius is no more than 256bytes, and might get smaller with future
> hardware generation, also advanced atomic 64B write to clear the poison.
> But I don't see any of that could be incorporated in, given that the
> filesystem is notified a corruption with pfn, rather than an exact
> address.
> 
> So I guess this question is also for Dan: how to avoid unnecessarily
> repairing a PMD range for a 256B corrupt range going forward?
> 
> thanks,
> -jane
> 
> 
> On 7/30/2021 3:01 AM, Shiyang Ruan wrote:
>> When memory-failure occurs, we call this function which is implemented
>> by each kind of devices.  For the fsdax case, pmem device driver
>> implements it.  Pmem device driver will find out the filesystem in which
>> the corrupted page located in.  And finally call filesystem handler to
>> deal with this error.
>>
>> The filesystem will try to recover the corrupted data if necessary.
> 
