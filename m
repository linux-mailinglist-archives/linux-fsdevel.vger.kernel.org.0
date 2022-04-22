Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB1F50BB92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 17:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449404AbiDVPXU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 11:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449387AbiDVPXR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:23:17 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77184CD5B;
        Fri, 22 Apr 2022 08:20:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpFG/oSyhY+pqkKcermRcC7EvVqHzrhwJFGOc7DS7Pw+KmCE7wGE1DL6zWhNOfjUAoPD3Mp3qHb3IRV0uyVOy64bdwC0/3LnooOb+kwMBqrBv6PqB+VDEdsJXDVfkfeX+UXv4xUrWbLWASVSv6yOl2ytkdZRlY2T+U2JvI6nsD0LNGbza3OuP52CG3nPsDM3ThfEqcDKOHGTf8W0BHKFu1X37/UX9GRuyJtxp8/rzwpOS/XCr+U/BoFF3bNVZJJQGJWROdRC0RBbFN8UhGB/3iV4VUkS/Pw4+hmKaXVMvozO/YITgqxWVi0JVS0zdO3wsMIgheOCe50kzNwAuTWBlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxeIalK9cxJ7L4AnvYlH9fZrxTzgQEqp6yX862v33kM=;
 b=H9KePYxX1VlPLinCUKRcf+I3JytKiEUMK1BJwkSOkabUA/VZ5FfJOX0E+jVlW5YwFRc9h8w/zzXMerPOBmzWhhVkh3go6AbIhIgIVPdgoW0AX1ibBBu+JpdGg06b3Z56gQba/ys/yR/eZcgdGFlUmwxpDRBsA5m7n387HiHaV35w+vKRLBf/hRSJJXV3nC694po1Yg2N3L7rfAJaZKrsRAiXsz+ORyKbq8COu2HLvoWQjBuB2ZWPn/ezw8hDS+ZvThBE9FRScMv4vL0coM/6i2x8AoJnyxJI3P/dIh4O7wbS4s5LML3W5yWglK2Ywhp+oB7P2ZifluHwoSdopGRfXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxeIalK9cxJ7L4AnvYlH9fZrxTzgQEqp6yX862v33kM=;
 b=WcMcxyNIUWmhdQHsbZiXRmMg5r3D2MQg1ehMMzDqEhzGXhhnrpJzuUEFWPJLNYxgF9MS9gQoRst0N7qejva049/DG4nCejkG6/vq7JMzB4fdLnYgVG9ENcE4mV7lB9/DmJGMkfKV9o8sRG9SDaZnRqUMRE8Qc1nG09ZzQJrgh9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by PH7PR19MB5799.namprd19.prod.outlook.com (2603:10b6:510:1d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 15:20:17 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::8d40:b4b0:9023:2281]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::8d40:b4b0:9023:2281%4]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 15:20:17 +0000
Message-ID: <2c8e61de-54da-44da-3a7b-b95eabfb29f2@ddn.com>
Date:   Fri, 22 Apr 2022 17:20:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/1] FUSE: Allow parallel direct writes on the same file
Content-Language: en-US
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Dharmendra Hans <dharamhans87@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>
References: <20220408061809.12324-1-dharamhans87@gmail.com>
 <20220408061809.12324-2-dharamhans87@gmail.com>
 <CAJfpegvU+y+WRhWrgWfc_7O5BdVi=N+3RUuVdBFFoyYVr9MDeg@mail.gmail.com>
 <CACUYsyGiNgbyoxWWdXm0z73B7QfnPGU2gYanDNSQqmq5_rnrhw@mail.gmail.com>
 <CAJfpegsZF4D-sshMK0C=jSECskyQRAgA_1hKD9ytsHKvmXoBeA@mail.gmail.com>
From:   Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <CAJfpegsZF4D-sshMK0C=jSECskyQRAgA_1hKD9ytsHKvmXoBeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::8) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5d415c1-6d5d-46b6-415c-08da24739b60
X-MS-TrafficTypeDiagnostic: PH7PR19MB5799:EE_
X-Microsoft-Antispam-PRVS: <PH7PR19MB5799CE68D560C05F58D016CEB5F79@PH7PR19MB5799.namprd19.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UIatDJl8QGPVxB3UJNIiyH42bdd2sYRxuTp2u6cqW8rOCArRcZbdE2MYrGS99vfbiVzBLlpfj+c7rUzkXQi69p6oRFvW8+XkmTQ4A1ugbcMbYO5CZDx699avG9WKeNrmpmb9sdxWqKWGmZX9o2kEy2N/LKeJrXheu3d7DjWgpDZvnC7FDXQieOjsdIqIG867z/DvqGk3P2Pz9M7KCK7j7oZDJ1gdwEckoMXFFHwlDhtggtEcs/K/VudMu1jb+0IjGitcV2hPmKdIPxln+5/2fGIIfzHS4IRahVZDwp/BNp/xHn83X0RP/unw0JE/Pk2e+tZgVcftpEf8oLX8sZrRXFVv5MynSTVio4kaX7p9XBw/YP1J8iAZlos9fPhJaVh7QwesDqm2MJBl5yCGL0HxVF5s6CYeOH7GNMtC5TDTBYHD0E4QMqy4NJ5IqNMd/EAzDSZ/GmAllmg4OCBIQObflX4v6S0DT1sFaebInHLpai61J/SHlTWF3ac4dS6BacnuhNM9XE4nLXD2SVyAagb2fGzk+88cooNZevUvT6sGC4LREsgXFB6zWwGPZ68XObjaIg40z8JfsgAIUzW5LiAE7ApJj6GKdtOp6Fk9ySQwvGXSFIOlhqo/GKM3hni8z737tUD4iaypsTdSt17d8Tzwqsdoyop3yqNtZ/+PtOVKUHIeQB6G9TwDgOxqckwnh6tMrUAeKtyCgkZx8UI3R5uUK6xYOIBD1VmtO5thGuv5rWHNoSbz6kaQ4b/I/msSJgBy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(8676002)(186003)(5660300002)(54906003)(4326008)(53546011)(6486002)(66556008)(66476007)(66946007)(31686004)(36756003)(2616005)(8936002)(86362001)(508600001)(26005)(38100700002)(2906002)(83380400001)(6506007)(6512007)(6666004)(316002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTNBMk1HMUJFUURjZDkvTWt1VkFIME1SRlFFZjB0a0pYSXZpaEdpUWUwbHpa?=
 =?utf-8?B?OVhkdW9BQXhXcVdnSzdUaGtGVDNsTFVHNEtuZTR2VXgxTXJPWjdUNzBVKzBl?=
 =?utf-8?B?dUd0RXFjL3Q5T1d5RG1tOVp4NExWeGtud1JhUkRKTUVhWDFPWmV4R2RzcUZS?=
 =?utf-8?B?cnYwMEwyaHlGQ1BvLzJLKzIxN1hvbnFwTlpyZzJHYkVPdVhoS1ltaEU0TUxq?=
 =?utf-8?B?b3lLQ3RmWVFUNHFteWRxMDcrYm80VW5nelh2S2xYR1VObmxoeC9VcEVlZmpC?=
 =?utf-8?B?UGQ0dXRNTjFTSHZqdXRFTDQwUTZHN2pkeGRhUFBiYSthczBhK1ltb3I0ck9G?=
 =?utf-8?B?ZEZ3U2pMbDFQbFlWVWsrZUJvVmRRTnpHRjdGVFhjU0dZM1Jpazk2dG5lcXBw?=
 =?utf-8?B?OWw2NWMxWUp2OWt2QWJxWnBnQ3UrWTE3UTExcnN1cUttVThFTy9hS01pTWxs?=
 =?utf-8?B?V0lSdFJuKy9sdFh3TVJ0aW9KZlkxTWtRT2dpMEhTdFlsZXh4akRydjdwQ2hD?=
 =?utf-8?B?VFZ0OUp0VXZFQWhlQlAvUXB5M2kzeW1mb3VDZnJKSk9hSWVKQTkyUmp3MzN5?=
 =?utf-8?B?R1FDRWNLSkRHY2pIS0c3dExWM1Rwa3QyWkVnTDN4UTdsbWhKOURSRnN4VGRH?=
 =?utf-8?B?N1dhRjNqN1F0WmZGNllQNFJSTzlqTFJMb04zNzh5VUxWWUxwcklDUVlBcmZL?=
 =?utf-8?B?QXRIKzcxa2thVldrNDVLc1VjcUlGcnU1U21lMVpUU3RLRUJkNWhjN2ZLMlVm?=
 =?utf-8?B?OEhQSTl4bEErU3RzYmRDZFZIblNtTmd0UElsZndkUklaSnVLVVJSOWdpUG1U?=
 =?utf-8?B?VXRxT0tEUVVaR0lXeWJLdmtFd0t6T0d2R2E2YWsxT0xBQWdHaGw3a1FFcmFz?=
 =?utf-8?B?cXd3OVNOdm5PNHJ1bkN4Z3c1RFZCRGdGWkxaQTdaVnJvK2x0cEJZcEhMK3lZ?=
 =?utf-8?B?TCtXdTd2OVdWY2pYVWQ1bHFZN2x2RzdwU3JEL042aTY0K2RqYlBoQTBES21W?=
 =?utf-8?B?N0VEOG9KTm91WXBNNzRHajNWMzJVbjBqdDNWelF4d1ltcUEvaElma3V2Ylor?=
 =?utf-8?B?QWpTVnZjVms0T1gvSExWRnRNZHJLWmxxL3Y3Y2llOTlKRDlNS0lKSzM1Yldp?=
 =?utf-8?B?Q2lBaDJxaHQrOWIwb0hlTWFiSXczTDNyZjJITndRcGprNTRHd3dDR1ROdTcz?=
 =?utf-8?B?bXlra0VSUkVUUzBCZ2l2TGRwYnVOYWNDM1dtRlhpTml4cDMyS1BrQnZ4azJp?=
 =?utf-8?B?c1l2T0U4anU0SUx6STVQYnBxcXVkWUhoSDhMVUFZVlBjU2VOSEFSK2lvYWNy?=
 =?utf-8?B?V0k3RmpBeGtRenIrSUZzbHNuWjJad1RmTjJsQncwczcrMWQyek0vMXd1TGNw?=
 =?utf-8?B?L1RWL3ArK09sZno3N251L3V1UDc0VFJwYnBKK3JqeGpmdTFSY0xWQm1uV1dn?=
 =?utf-8?B?UmNQK1dzM1U4QkRFOVo3VE5tQzlvZGZXb09DZTBKZDMrQ0Q4Y3Fjem00MTRV?=
 =?utf-8?B?TEdLc0tmcGhzQjdWMGxFME04SnNLYTJUWGlJTEhraGRFTUdYcS9lWnF1b1Zp?=
 =?utf-8?B?QlQ4T3FZSjNXa0J6NEI0YWhGcUc5UXB3S0hXSEpiS3FtVnpYZCswMXdoa2VO?=
 =?utf-8?B?blF0ck1qZWZiVnFuSGZ2N2FpdUJqdUtPbHZVendqRlpsbXlyWkZKdS9yL29L?=
 =?utf-8?B?dUt4N0FlOEUrTlNBaTB2amdLT3dOU3dCSGZXVDluV0QzRGZmc0l3bkwwMjg3?=
 =?utf-8?B?NVNLL3dUQVRucjlKT3I1V0ZpNUZ4NUlib0pDWFdJQ0lRckluTXFCMkFGMzkz?=
 =?utf-8?B?QUEzamxKQ0haZmdQR08wUWFOQlVuanRGb1h4WFlOVy94bExtZzNMdnNkODMy?=
 =?utf-8?B?RlZXazB4VjhPYjdyTHBQTWllVnpXUVBpTTZ4RlRtSEN1MXRQNWhyclJTMGVr?=
 =?utf-8?B?ZEN1MHJGTHl4a2pRWFRVVi90R1NtSXE5OS96OHZtQzN3MU0yR2Rta29hdmRs?=
 =?utf-8?B?Q1huSmV2ZHR2WDkreXRjUTFsZm05WFVybFhYaG5Dd1BZak53dnlCMDRXKzkx?=
 =?utf-8?B?VDEwdU1iNDkzZ0tzQjQxMWo1dUFMWUV6Ri9Ndkl4ZFRPM0o2OE8yNEl6NW5I?=
 =?utf-8?B?ZkNzUnMydUkzL1MxV0ZLWU93bjBxa0JhTGh2QnVPWWFuR2ZMTEFyTEcwbmdt?=
 =?utf-8?B?V2dvcEZsZS9WczVzSmFJY0k1RDNVeXpTQ2tWVkhBbXhMYmFCYlpWWHV4R3Zv?=
 =?utf-8?B?d2FWSnBYYlNaL1JjS0MvM2J3N0tla29NejhlSDlpbGY5NkxteTlzSlBxY2Vs?=
 =?utf-8?B?T0RkSlFZVGVYMmdvQUJ5TDFRc3paQlRFOUNELy9sM0hHMjZxYlZ2dz09?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d415c1-6d5d-46b6-415c-08da24739b60
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 15:20:17.7336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+lvrLdWJJyRKSaiHavLHuLecPFOF4cNmyp4FegKbfM7j5Wv5RLWbPfWhh+pq6cjsCQHcEhO2RVzPam+IUSn1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB5799
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/22/22 16:48, Miklos Szeredi wrote:
> On Fri, 22 Apr 2022 at 16:30, Dharmendra Hans <dharamhans87@gmail.com> wrote:
>>
>> On Thu, Apr 21, 2022 at 8:52 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>>
>>> On Fri, 8 Apr 2022 at 08:18, Dharmendra Singh <dharamhans87@gmail.com> wrote:
>>>>
> 
> That's true, but I still worry...  Does your workload include
> non-append extending writes?  Seems to me making those run in parallel
> is asking for trouble.

Our main use case is MPIIO for now and I don't think it first sets the 
file size and would then write to these sparse files. Fixing all the 
different MPI implementations including closed source stacks is probably 
out of question.
Given that MPIIO also supports direct calls into its stack we also do 
support that for some MPIs, but not all stacks. Direct calls bypassing 
the vfs also haas  it's own issues, including security. So it would be 
really great if we could find a way to avoid the inode lock.

Would you mind to share what you worry about in detail?


> 
>> If we agreed, I  would be sending the updated patch shortly.
>> (Also please take a look on other patches raised by me for atomic-open,  these
>>   patches are pending since couple of weeks)
> 
> I'm looking at that currently.

Thank you! There are two more optimizations in the same area, but these 
require VFS changes - let's first get the 'easy' things done...



Thanks,
Bernd
