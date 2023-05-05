Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243966F8C61
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 00:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbjEEWcM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 18:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbjEEWcL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 18:32:11 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2044.outbound.protection.outlook.com [40.107.8.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47823A8C;
        Fri,  5 May 2023 15:32:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbuBJPs8uuTukOduxb0RlzwSH5UbOr1SR3OErgs+mAocilm/PnVYB1m/KsDDajymr8fpkpK0cws3oD55OIFZWDsMZjqdYjhJaE2cSxjQjvy2N1gncLBx0g/2O/quF3yd/+FOkSwrC5S7lS808QgMAS94YY4NC3MxBq9q5I3ct7CZKzUDDei7iYByXzjwllW8SSNzGf9rhVaGgHWcyPGvn4iaZxhCzTn2Jd4MBS+Q9+aF2MlPvYzTeoF1nl+CsKgtz2L3cnRn+lGDUCd+vE6oBEI5R6TPjv2KapJfKzZ4Fbs05LLp1x6/fmvmPwPurhhVrNDxnjJQZJRk4kO0Yr8tIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWxNSXUECGuDW/XM68+GSHaciGkuohn7wrIcwhJ5Bsw=;
 b=glxFjmUCFjWMm2ZF03QMg1CRxTK20qngFlt83w1eaTqGDnyXOzfWBsRzue+5HE5dOYLH1axpAlDBbfXMdrSFbhTwhmMv7/uizhBthQoluXk+raETCRtYdk//+p5UhvpZ82ydBEx2aeu+bvhE/Oc228CHmpSVhkxUsgRi/tpZv5b687VluGhlXbtYYnRgDyibuRjKV5lwlx2VSVxsySS1rnv5RAmNEywBwCO6/12xcsUHyU4Pxu3qw6sy+lWdgdjyGMOY8CqgaGfxT3m7LgUsHD6KIeqghf5mDPzYDvHaOE8CQ4fyCQ2wOyaq7bsrjJmv5IJ0OGhjSK5b1nNqvj5xUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWxNSXUECGuDW/XM68+GSHaciGkuohn7wrIcwhJ5Bsw=;
 b=B1NGzaDC9qVwFlYvN4nKKYJ745qDCeVcMT/Iptfc+frt5ACL+rHdN3CG97ZS+r9ifZC3rfMoWbxGaN6MIxKKPaJvk4D8c6U3a+G+oBVIMJWbK4k8UvY78Y0YuVNb5hl1T3iwS55SkiJMPqKkp4292yXo7rCkf3d8jLrb9+uEc75GpXnRXSrCBI9Zz6Sdn2kia4VxyV2oTFNIUsGcnaWAnCvauZx+aGYqxvbz/D/qrxE3aZgBjcH3KDRup8/QYyFUixnrMUCvQ/qexYFYF24bZiYRAnP8hwXXjYPN4BCTix6ar8xMAtXat8oTVhQJwsV+1lICYUOC6/y9e1bv98xXiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS8PR04MB7894.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 22:32:05 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2%5]) with mapi id 15.20.6363.029; Fri, 5 May 2023
 22:32:04 +0000
Message-ID: <9e12da58-3c53-79a4-c3fc-733346578965@suse.com>
Date:   Sat, 6 May 2023 06:31:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     kreijack@inwind.it, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com,
        nborisov@suse.com
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <20230504170708.787361-2-gpiccoli@igalia.com>
 <2892ff0d-9225-07b7-03e4-a3c96d0bff59@gmx.com>
 <26e62159-8df9-862a-8c14-7871b2cba961@libero.it>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 1/2] btrfs: Introduce the virtual_fsid feature
In-Reply-To: <26e62159-8df9-862a-8c14-7871b2cba961@libero.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::7) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AS8PR04MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 7610bf55-f655-4fa2-d5c2-08db4db88d4c
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rY/C0nUdplrU1bW6H9oBL1Bs9a6fnkmVmypNDnYHTxSHYWkDw50R6XE/fY8HDDGDe/NPym2sarCiKdmAi8lSzIiXLccxmS6s3TBQpldzoBPERhK3HT8sWWE/lFExpPtBzzOswow/D1afBoigM3BI9yLXaUH1/P99FWs2IT6axxbVC8LzSbfpnmk3bJ7yHoHd5eaQdKU7sBFWdElQfr3Ycc/yQyAbTpsAEMjroSCpE3+Lk8BsOMSf9ytq9qV2wO46MezFBdxW/PksCr7a2uNoP+y+faU0pLyg9UFoGkiorfglJbzKn+h+R1cfCZsSVGCx8mdGNO8WIQchOQQEBdIjGuHZIuxqLcQKtppgnteckmRWDW3MGgrAYWgO+WdwYo/kIsjIzZAdon6fXaLfQsPMIZLOH/A0U0uTp0Qc8tuTUZ1Q3GAyQ/WmSUIVX/yPDx4bonMgbcTOgKM/aZFv4//jbqEQPXzjVKn1iZc9/Bvk8V6bvN5hIStmqJKADlqEwIoySquX1Qujw3S3ZqZOxtZsNzpmlIzkGGiJAcy4o65ZoFNYnswLna8eBxfknzY6ul57kjEKWTskLby6Jx8mRZtV8QhScxWHLgqIAoxXun34QL/VxvYrwUhg5ZCuIXkT2Myr6ZAx1Bc71e0uKSsEKfsMcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199021)(36756003)(86362001)(31696002)(110136005)(316002)(4326008)(66476007)(66556008)(66946007)(478600001)(6486002)(6666004)(8676002)(8936002)(5660300002)(41300700001)(7416002)(2906002)(38100700002)(186003)(107886003)(2616005)(53546011)(6506007)(6512007)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDA4dWFMdGcvZ29JOEswMXlYOWduclFYbnpMVlpUajR2bS9ZVXc2OXd4SFRF?=
 =?utf-8?B?cHRNeWRkVm83WVorTCs2SFIyb3ZPUE5EbENUa1VsUk51MlBCMU5UbnN4SEdk?=
 =?utf-8?B?NHRLUEdJR0d1a3JZNXJESHRpR2lsaHU3MzFVUWw3UTdxVytnSGVHZXFzTy94?=
 =?utf-8?B?NWhuUHEwMmcydm0zUzZQVWl4UEsxSWUxUUhyVUtaOTZhVmZFanZDcW9saksv?=
 =?utf-8?B?ei9pcTlnTjFHM3JZaWZXZXM2QVNMSUxDTmwxYmI4aGQySnNpVms0bWFtdTAr?=
 =?utf-8?B?bkZKaUU2emFqSFZHTkx6STFhU01MM3lEV2hnQWFpcE1WRGgvVTVIR044NnNX?=
 =?utf-8?B?L0lJWmxEcWx6QlBFWkw2OWxWVWZabGJZWERGVUcvVU9GMU9CRkxRWjNZY0tY?=
 =?utf-8?B?TWtmaml1dWwwOTdsWk5lbm5BNEVpKzhObDMwQ1ViOEVYNjY5bzRJaGc1MHhX?=
 =?utf-8?B?MHJxVFZXb0hnMmVnOWNVNnc5SkFWSVFnYXlWRjhzNXVMUzZIMVgrVzJ2SnhT?=
 =?utf-8?B?WVA2MXp6UWRMZEFWT01KTmxMRlYvNzd4Nmwra0lwZG9LYUx2eHZxVkZDZS82?=
 =?utf-8?B?L2JKWHZBSzBhaEFOeTJsMzJnZ1A2KzRiUUFSY2RaaUgweXZwdWgxcXc2dW8v?=
 =?utf-8?B?V1ZVV0pET2k2SVdtMnFlZWxHdDBMMW8zWmhrRmpoejFueGZ1THg2bklQc0x0?=
 =?utf-8?B?aklOeFkwa000YmQ4WEpFcjN3TytiQldFSGdJSXRkbEkwQlV2eGxrTzRXbEIz?=
 =?utf-8?B?S3Q5TzFUaURaeGdUR1RiR1E4KzdlQmNXUUJ3V3Ixanp1c3lxTTBqVHYrR2tI?=
 =?utf-8?B?SDJVYW1uSWRjMnZuZUNYWkFmOW8wdkZ2S0FVKyt4MmRjOFFGU2VkWFFJZ0dH?=
 =?utf-8?B?THFZd0VWaWtST2gwVmc5WjNNUUZzL0hjM1VSNTcybHNmZW1LR0FqbFlraHZJ?=
 =?utf-8?B?NElsK2d6enkyYUVVTWlUb0VnUUk1cnlKVFVVam0xaktTUG5rbk1uU1RnZUlv?=
 =?utf-8?B?Q3pWejNIYjlIT095OXpDYzZxb1U1Z1NmT2JHR2NMS2g2RVNVeWE0N24veGFW?=
 =?utf-8?B?MDhra0xVM1cxSENzSTRScVVZWW5xNUNXbzF6T1BmeW9TbnhjV0M3WWV1SVpS?=
 =?utf-8?B?VzR4TTcwVkxlQmU0Njd1N1MxcUpmR0RzaHdKV0N3SGwzZ0VEdk94a3VwSHVi?=
 =?utf-8?B?NmdQbHBrYlFtZVVza2NTaUROWkdMWW41RjdHU0JqRC83Ulp6WFczRlkzanBP?=
 =?utf-8?B?THJzU0JlQU1mR0dUNjdzeDdOQWZueDEwd3ZGVnVnYW9JV2d3aDl5SmlQNkZ2?=
 =?utf-8?B?c1JwQUlwSi9jVDBpdlo3bTBTaXhFRG5TeVFQb1ZHUFBhVmdEQ05Yd0J0ZW9l?=
 =?utf-8?B?MDVCT2tYY1lHOHNuYUZTNmpiV2g0c0VWVWk4MW1lU2Jad2pNT0hXaXBYZFNK?=
 =?utf-8?B?UGNsSGJCa3ZtMGNDSkVldWhCN1ZjbFQ3c0lhaEdwOHN2dXdrakxmZ0l0SG9X?=
 =?utf-8?B?Y1J0ZDNxTWxML1hrMWJaMVZWRDVwRk5SQzZOL21MT0RnWkhGcTRGOHA0MlpK?=
 =?utf-8?B?U2NiU0FBTGpHQ0d5eHE5bCtPTDgrakZKRlQxTTMvREQ0S3VGZmRNZC9Pbzda?=
 =?utf-8?B?b1Btd0lnM0VSTEZNbnRVRWIvYlVySTBjM1pzRXA1U0Q0aDhLTUtHcGl4UDUv?=
 =?utf-8?B?dmFWVFNST0h3QUs2NmpVdFgvQXhKZzNkK3l0T0NpVEV4SDA2QjNEZWFvVWtP?=
 =?utf-8?B?S2Y5d21BVDZRYmhhZStSZ3FiSEwxN1VvWnVJRDFvRDB4NHpUcmlzWVVSOSsw?=
 =?utf-8?B?V2JTMkF1K29oK0p4RGFVemVIemdQbUtNKytCbE96NVlYK0lqTzVUT3hLMDBQ?=
 =?utf-8?B?b2kvM0NoQnBGbUh3OWVkbklyaEpJWS9PcDlKVDlPTlM4UWsyTmJ2SE82SDE0?=
 =?utf-8?B?WnV0ZFZ4UENnZkpycVBYOW9Ka3dPN2Q5VzNvZmVuVjgxbjVxMkVUNjFRY0FT?=
 =?utf-8?B?UWxheVU2VUg5Z3pWc25HeE9xOEZCRW11cVpZZkxrT2Q0KzMyV01zQ3FuRTkr?=
 =?utf-8?B?TldXV1NudjVRa2ZONG52dm4wOEFlc2F1c2hNelVvK21TY1hUcGN5VUYzUk5Y?=
 =?utf-8?B?amJQcDRGcCtESVp2ZUZ4ZEk3N2VvaXBkUGxUY0lCUG1TOWZPeEtFV1dEUHBo?=
 =?utf-8?Q?hsDLlVh+W4YieFcJv11IuQA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7610bf55-f655-4fa2-d5c2-08db4db88d4c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 22:32:04.4479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nb8uoE8ww2qkFFtZwRpOvjRGoQA8WA2EUk7IcG6HvffMm/H+qFUS7dWC6sqQJg4D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7894
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/5/6 01:34, Goffredo Baroncelli wrote:
> On 05/05/2023 09.21, Qu Wenruo wrote:
>>
>> I would prefer a much simpler but more explicit method.
>>
>> Just introduce a new compat_ro feature, maybe call it SINGLE_DEV.
> 
> It is not clear to me if we need that.
> 
> I don't understand in what checking for SINGLE_DEV is different from
> btrfs_super_block.disks_num == 1.

Because disks_num == 1 doesn't exclude the ability to add new disks in 
the future.

Without that new SINGLE_DEV compat_ro, we should still do the regular 
device scan.

> 
> Let me to argument:
> 
> I see two scenarios:
> 1) mount two different fs with the same UUID NOT at the same time:
> This could be done now with small change in the kernel:
> - we need to NOT store the data of a filesystem when a disk is
>    scanned IF it is composed by only one disk
> - after the unmount we need to discard the data too (checking again
>    that the filesystem is composed by only one disk)
> 
> No limit is needed to add/replace a disk. Of course after a disk is
> added a filesystem with the same UUID cannot be mounted without a
> full cycle of --forget.

The problem is, what if:

- Both btrfs have single disk
- Both btrfs have the same fsid
- Both btrfs have been mounted
- Then one of btrfs is going to add a new disk

We either:

- Don't scan nor trace the device/fsid anyway
   Then after unmount, the new two disks btrfs can not be mounted
   and need extra scan/forgot/whatever to reassemble list.
   And that would also cause fsid conflicts if not properly handled
   between the single and multi disk btrfs.

- Scan and record the fsid/device at device add time
   This means we should reject the device add.
   This can sometimes cause confusion to the end user, just because they
   have mounted another fs, now they can not add a new device.

   And this is going to change device add code path quite hugely.
   We currently expects all device scan/trace thing done way before
   mount.
   Such huge change can lead to hidden bugs.

To me, neither is good to the end users.

A SINGLE_DEV feature would reject the corner case in a way more 
user-friendly and clear way.

   With SINGLE_DEV feature, just no dev add/replace/delete no matter
   what.


> 
> I have to point out that this problem would be easily solved in
> userspace if we switch from the current model where the disks are
> scanned asynchronously (udev which call btrfs dev scan) to a model
> where the disk are scanned at mount time by a mount.btrfs helper.
> 
> A mount.btrfs helper, also could be a place to put some more clear error
> message like "we cannot mount this filesystem because one disk of a
> raid5 is missing, try passing -o degraded"
> or "we cannot mount this filesystem because we detect a brain split
> problem" ....
> 
> 2) mount two different fs with the same UUID at the SAME time:
> This is a bit more complicated; we need to store a virtual UUID
> somewhere.
> 
> However sometime we need to use the real fsid (during a write),
> and sometime we need to use the virtual_uuid (e.g. for 
> /sys/fs/btrfs/<uuid>)

Another thing is, we already have too many uuids.

Some are unavoidable like fsid and device uuid.

But I still prefer not to add a new layer of unnecessary uuids.

Thanks,
Qu

> 
> Both in 1) and 2) we need to/it is enough to have 
> btrfs_super_block.disks_num == 1
> In the case 2) using a virtual_uuid mount option will prevent
> to add a disk.

