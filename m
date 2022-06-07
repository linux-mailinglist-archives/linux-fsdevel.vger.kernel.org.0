Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34C9542578
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 08:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiFHBUC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 21:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiFGX2x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:28:53 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20617.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::617])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41782415885;
        Tue,  7 Jun 2022 14:43:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJ8XbV2NoElHs6QaUGnHQ+hHsY2q9tVfVCS2BkIcn5B+LNbM33kmIECtNBI0zzwYmVzmCc/xA5Z0ryEdSdQiS+UknQbFy/lQaf9SlIauUjlYU0RtSNPJVmEgFTX5YKzArlpROwJWaC9RCy6HY4C1hCkPJP12htEcu4ikS1k9TVikxGXJ7dAL+iJsW7wyH9oAd5gKchWJiL3OhIR30AtsP3+UfxUFuxbox2hyxcgVedM7cNmSRf8xpaxBJ7wMozduq+gJwzXR39sv8jSZ3Mnv+vM1ySUObzZvhJYodt0zywtM10od79ldXibb/FlgeM3XMEFQ/uWchtMGNOOPqCehVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvuMt/a/O7nMD00qr7gz7mXtDEKm2yWar3rpwl2dtAs=;
 b=cHaGxRAZPSa55J1gtqdAV41VBbXqcelG5hM0cLOPA53OtIGaxeSLT//mxGMqECibce3wASFb+Ii3yqI7rGKI4pmP3Uu1cHJJF8oWbSAERMqzEGP67Mj3qQNIujp0MqfRPjhpr8EQVmUz3qbWny2+TEa7IWJrYs2FcSeUuGtQYYMcOLmROUNRe6rgRG3S0pNIjWtrerBNPpq3etwDVUdu8a7y1Dmz/vVWO9T7102kaQIGNaYlEvBVJctmSWmFx8pZOe2U3RtNutj2jgXGFFZNqtrwmVYDNCiwQONWGWloyFyssJnUUXtts5CoGAmdCABeVLZrs8bhj5cpLlXw6xSZ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvuMt/a/O7nMD00qr7gz7mXtDEKm2yWar3rpwl2dtAs=;
 b=eqirRgDDB/Fw1hz0Wqs7QzVnZCU1l7N/PjKnMcsuoce2S5UrLtZ58QwIdvTD9B/PiFp3D+IA5K4csvbw44eCM98I0ztOuuaOAvs+DghUQmB1/mJt29lWKO7PqnoKTob2dLXDx7+KFHHk+TtLBEhNlW2uEXtboaRsRbtkePqXF+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by MN2PR19MB2973.namprd19.prod.outlook.com (2603:10b6:208:109::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 21:42:21 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::3994:ad08:1a41:d93a]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::3994:ad08:1a41:d93a%7]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 21:42:21 +0000
Message-ID: <34dd96b3-e253-de4e-d5d3-a49bc1990e6f@ddn.com>
Date:   Tue, 7 Jun 2022 23:42:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 1/1] Allow non-extending parallel direct writes on the
 same file.
Content-Language: en-US
To:     Vivek Goyal <vgoyal@redhat.com>,
        Dharmendra Singh <dharamhans87@gmail.com>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Dharmendra Singh <dsingh@ddn.com>
References: <20220605072201.9237-1-dharamhans87@gmail.com>
 <20220605072201.9237-2-dharamhans87@gmail.com> <Yp/CYjONZHoekSVA@redhat.com>
From:   Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <Yp/CYjONZHoekSVA@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0023.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::28) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 772aaf9c-dd70-4e97-d5c4-08da48ce9a2f
X-MS-TrafficTypeDiagnostic: MN2PR19MB2973:EE_
X-Microsoft-Antispam-PRVS: <MN2PR19MB2973E5DE03F984351A606D74B5A59@MN2PR19MB2973.namprd19.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GwNhypU74DSXdd60ivjZJOFtRiN/InyIuTN3f9pMBS6AgNl9A3kLXeVXWoXYRPFNRNMAkkMfSZb7tmIHX/KaGairEp6R1zbombHU0Pxq/BmofDyGmTHQtHujDlylPNrXnMVFONi7YA4GHAWiQ3LiT9J/sLir93ILn+LFAIUCHM0RlTRUgFSpOyrz9DyucxQLvnIclsGdAZrjH67asE3HAZC7L8au933qWhRae9i0NASLqyVwAEOSRrVUI6VLRVacngLo+nWeiBmiJ3b3ncz2tToeoyOdrmoWTlfsCpXvjp6y1za4bKfXJWH3G78B5JwVan3gCjZxQU6nFfghy1rU0tvf1t2TQ8gXhHkq6EkZtnurXJJSJKURPxpLINovt4dgsoEqECm9dkTHwXqC3HUmQ0H8CRy6CVNXdacYe7GP0btkcaz4JpwuYZNV/4fwEYxjJ65/GZT4wDGT8Shi2nqvX205nfYQJpR/ZwOND0J/kBrJqy1Z+VPck8fDaLKMVm8dp/RsQ6RDUu2Vm9MW6JcdBUQRLauYP87W8VwJeMJQU+eP/haI7mVGLf4r3xzNCsAbG/pZzw0Wh7nhzBmx7S8SPcm3HuNdkr/qSf7oxohd6Ore+ypeaEPVGNYHX3hzn8qJ2WtF89gxEeIomrQ3WoWrv/om/V2kngLWD9cMmAJNjdzvsehhBMQXfdx17kyF4532ForP1BNgq8oqv2KqaSEjt10W9Nv9ZxPCY/BhvVmtJV4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(66476007)(31696002)(53546011)(6506007)(38100700002)(2906002)(36756003)(6666004)(6486002)(86362001)(4326008)(8936002)(66556008)(186003)(66946007)(2616005)(508600001)(6512007)(110136005)(31686004)(83380400001)(316002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVF6TEkrb2hqeEFlaFdhWVhlOHZzWUt0SCtBd011VWhyenNLVE1xUWNpelBl?=
 =?utf-8?B?MlhQY0sxMGQ1VUVaZURNNG5QUHpab0JXRFdoY3JKWkFkWURPNGpnSEp5anA4?=
 =?utf-8?B?dUJzOG15MWdOQnV1T00rR0k5UC9BOTRVWTdkQldRWHhKWkVoNGNSMVFEcjJk?=
 =?utf-8?B?NGRqMkF4VXhzSUFLQTBFYUV0Q05Gd0g0Y3BNUEtDSWd6aGhsb2lLdVZ2SHVE?=
 =?utf-8?B?b2U0Tmo5QktkWHRNd1dLM0NCYWI0dFA3dFIyUkNxd2M0SnZlb2JtUzI1TmdQ?=
 =?utf-8?B?L3ZYSmZFdVNUaGxXTUlpWDB0a1ZPSE9ZM0xFYjBPNU1TTWo4bEoxbjd6WEhW?=
 =?utf-8?B?WDl6V3hVYXRMWnVCYTBpVG9pZkJVRmRKUnJQME1pQmRhWHkvMjRSYkF4Yk9p?=
 =?utf-8?B?RlB2T0oxTnYrbm1tNWVTK0I0NlVqUC90bzdGcFNHdWhlek5tbFByVTY2Q2hk?=
 =?utf-8?B?NWpGa0dmT2hoWUg1dmF2V1ltTWZwZmIxNldXWjQrYUo1NzFMZTZFOUMyQTRN?=
 =?utf-8?B?a3c1UXRFMFp2aHhkWmdNOXlvcTJkUlRSN0p3L3h2K3NuWjFKOC9hQlhqbEx1?=
 =?utf-8?B?cnFNUzVWNFBZWlExYWRmTmxFdkVKbFBxWm9iVGllM0pHdGNwZW9vNjU1emZq?=
 =?utf-8?B?MFlPRWhRbTRBaXhLWDdBMllsK2Q0MDRJQW54WmZ1dkUrcmk5dGlrTGpQMXc2?=
 =?utf-8?B?dXlWTmRIRlBUMnBWMWxmM3A1UWY2TUZsdllwNjY2NEVEL0h6RUl4R2k4TTRE?=
 =?utf-8?B?S0IvazVyK0VyL0lmZVptZ3RwajFVSFM5SGhBWnJYZmJ0VlVFY3BUUmtwT1JE?=
 =?utf-8?B?REZtbFdHeUpBVU1MRFc4dHVWZiswMTloVEF5bW04ZEU4SVVmcU1TUjFzQWJX?=
 =?utf-8?B?aEUwZUx5b1VaZUgzWStLVlR0VU1jSXhpbVYyWU5peFZwbFBtbHZqMnNWYjR3?=
 =?utf-8?B?TGE1QXk5ZEN2bDEwRGhGR1FPTkVleFNUeVdxeEJ2WDBrT0VGVmVNMXNnd2JE?=
 =?utf-8?B?QldBSEQ1ZnR6cVNxYlc5S0FvanhMd0krTlZuWmFxaGZDQ3d0U0dwYlhaUTZV?=
 =?utf-8?B?d0ZqV2NEb1JsdDlFVDRRa0kzbHZiclVhRFpORXFSNDNwVlpnM29qenRycWti?=
 =?utf-8?B?VlVBdmE1UGxuKzVJaUxnUitxR211VnIwRHBXc3R6dE5LZk8xVlFrS0tnZFJK?=
 =?utf-8?B?U3l3WkRsRXp6cTZsd3hZUENkOVdGeE5raWNTZG1TTnVEcHJ2UGxzbld2WGNn?=
 =?utf-8?B?UkhIbjluSXhNaC9CU1JiRENFQ2pEbVFJNUJKZTBrZngwQ3gwY3R0L0JRRDJj?=
 =?utf-8?B?alZ1dDhGQ3FhdmdrSzRMbXNERGx2aGp1ZmtNaFVaV2l5SzBwOGdEZmZ2QXdq?=
 =?utf-8?B?clRNNEo1R0RNUHMrdTZ5dTZ2M1duejIwUGM1RW94T3VzTHAzYXRRaVVrVmw2?=
 =?utf-8?B?MmpPUzVWV0cxUGFaSUwwSEZIdmF0NGZHV0NKVElTQ3pHSHJjVnpUbHZlNURo?=
 =?utf-8?B?bVpwc3pjKzBwMk04VENTdTFDOEZSYmFSRWw5VlBDS1Mzem82UUtzYzZLRlpr?=
 =?utf-8?B?SjVINEpoM1NtdWE3eEQ2c2V5Y2tSL0ZqMWw3OHkrWDlKWnZicFh5OU5SOVZy?=
 =?utf-8?B?cGdRVVJ5azNUVFBiZWwrMHczOW1yZjBJakZaMXVxSjhnWG1JOHZ0bC8ybldO?=
 =?utf-8?B?a0lvM3gvTWlNUjdFamFaM3JGdFRLaDZxbzlIZGxybkRuSzREWGlaeGtrTno4?=
 =?utf-8?B?TngwQVp0Y3lsTnRoRG9NbkYxODlJSm1UNHl2TjZNdUQyeTZReEcxczlUREpJ?=
 =?utf-8?B?VXd0OEFHRnBVS3FjWndEeTkyUVdLS0d5WkI0bmtrZlRyT2JmOEUyVnNnckU2?=
 =?utf-8?B?VGZSN1FTbEg2WGM1Q2tJOXpkWnpkZ0Y4U2F0cTB0dUF0TDdLK055bUtOelFR?=
 =?utf-8?B?M2UxNUl2a2JiZllCTFVwS2o5b0NIbHNTNE5KeGNjYXUwa3hnV2swRzZMbFI2?=
 =?utf-8?B?Yjl6a3NmMUZSUmhpU0lvRC9sa2o3VGE4UEZabjJqNktZZG1odUhkV0gxcC8r?=
 =?utf-8?B?dlhBNERWbWNqQkpuNGZZcGlzbUlLNU90REloaFc4TTZMQUR1azNrUk04S3FG?=
 =?utf-8?B?ZWhjTzBCSjUxbnBFVDlibXFqaTBhU0cvMXIrMmhFVW5IUEw2QmVCdkdnTnlm?=
 =?utf-8?B?WThuZlA5ekwwc3p6WU9DY0lEdHV6cjdpbDBJQTVPMy95L3JNT0o1NXc3SmlU?=
 =?utf-8?B?UUZvWkxuMGZRTGR3ZnpXd3BYY3JqK2oxL2VVU0xGWmczY2h4ZDdacXlYcHN0?=
 =?utf-8?B?MjNrV0xXVTV1R21aZmdTOUVCUTRnY1hEeGZadzE3dWNQZ1VuTUJhZzRpZjNY?=
 =?utf-8?Q?DhzhLwWO65dlPVHvxYGaDsXHp20lGnxLSVgYeVkaapBj4?=
X-MS-Exchange-AntiSpam-MessageData-1: +kz+iFVuQLdZNA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 772aaf9c-dd70-4e97-d5c4-08da48ce9a2f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 21:42:21.5354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /OqHWoT8FNMDma+j9r1MAZxW7sjY+dwNZnSuZuEjcmHIcIeaxg8aLZrc50VM0qYdgGhERNQa5UdB6eFmZ+54SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB2973
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/7/22 23:25, Vivek Goyal wrote:
> On Sun, Jun 05, 2022 at 12:52:00PM +0530, Dharmendra Singh wrote:
>> From: Dharmendra Singh <dsingh@ddn.com>
>>
>> In general, as of now, in FUSE, direct writes on the same file are
>> serialized over inode lock i.e we hold inode lock for the full duration
>> of the write request. I could not found in fuse code a comment which
>> clearly explains why this exclusive lock is taken for direct writes.
>>
>> Following might be the reasons for acquiring exclusive lock but not
>> limited to
>> 1) Our guess is some USER space fuse implementations might be relying
>>     on this lock for seralization.
> 
> Hi Dharmendra,
> 
> I will just try to be devil's advocate. So if this is server side
> limitation, then it is possible that fuse client's isize data in
> cache is stale. For example, filesystem is shared between two
> clients.
> 
> - File size is 4G as seen by client A.
> - Client B truncates the file to 2G.
> - Two processes in client A, try to do parallel direct writes and will
>    be able to proceed and server will get two parallel writes both
>    extending file size.
> 
> I can see that this can happen with virtiofs with cache=auto policy.
> 
> IOW, if this is a fuse server side limitation, then how do you ensure
> that fuse kernel's i_size definition is not stale.

Hi Vivek,

I'm sorry, to be sure, can you explain where exactly a client is located 
for you? For us these are multiple daemons linked to libufse - which you 
seem to call 'server' Typically these clients are on different machines. 
And servers are for us on the other side of the network - like an NFS 
server.

So now while I'm not sure what you mean with 'client', I'm wondering 
about two generic questions

a) I need to double check, but we were under the assumption the code in 
question is a direct-io code path. I assume cache=auto would use the 
page cache and should not be effected?

b) How would the current lock help for distributed clients? Or multiple 
fuse daemons (what you seem to call server) per local machine?

For a single vfs mount point served by fuse, truncate should take the 
exclusive lock and parallel writes the shared lock - I don't see a 
problem here either.


Thanks,
Bernd




