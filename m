Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD085FEC85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 12:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiJNKYC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 06:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiJNKYA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 06:24:00 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2083.outbound.protection.outlook.com [40.107.247.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDCB1C97FB;
        Fri, 14 Oct 2022 03:23:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqPZ/OqUj4i7Ihll6zBM5WlMK9nMc40Zl8zNXr+Vzl+VSQeCdHtt4NWxMw62md/nrd6uKD3dSH1Y/MqtRyUfUOu5mpizf7Sh512GAuXsvjjEQo/Z+gC8wk/iKhCjaXb9rL3g9cOQMuUbxTmgOp6SNmTL/w3I+QvsxI8mBr+FqMCsRNDcwXJpplebRpjx1NBM8b1HjVMVJ88nOBH5cJoAOh3bUlZ3VqesfskhpAirt9GPabdHTA7mGi3+T31bAb4AU1nUjqs4XRrXhVdnBbhlVWPKtG/1AS68H5nCIbW3klXrTGlG21SH7jf4AQqlZZYGp+T4shq5TfaIqJg7BEBbkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/+8ehaHxmdDSCofL/H6xoWjoRkWOznk3kyJExmr43I=;
 b=C2zEsqkVv7cga6H0YCuPBvKCBuyPT13X1ikDIX2N3AmTizwqEdg1ORzVJUL2TxMLGSYd3GmtCi0a5B/Qq6bLSJ5V0u3QVs4jiwe8Ci5jc9N7NCM9c9B22LbvbgYlcBYghjoHWLEKNkxNL51l11f8BhAI9l6EzwkhW9qw463BbapPlYU/BDBcFJ7VGZlDNKnDEWANos11rg+9YGdKgQNQBEt/3YkBVfSG4NuUiWNe68mMRZtKriUKWQp0S6W/D04p9qU5/hpeDPEG9gyQLD2iaMQybbCAh8oq56F3bUqqtr4MzpEOF4XPFIYp/qztc0AjIKjw0T51i4uoYTIsWZZR6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/+8ehaHxmdDSCofL/H6xoWjoRkWOznk3kyJExmr43I=;
 b=JWw23yKSJVqfgTRYZ/pxC43FcMO/dzJfXMj+tq5wuD7D/tu6LV48Qq/sht3KFoaQFI9i6r+zsjRE56mC+Rv3DlBx6ApjUuH/Xedr3jif6zfIX2YhhmHdDicJ4gkTlQXChWZqDuS+NliElJ3xjEptmSd7AUk5xu0vLupY8XgjZmwI+/i+LaF+l3NnThVa9v88DXcRUb+eMGgIyBOrKEUi6SyeScYePM6aW5NA2qhbQe9eCgjDB+EuoziysixvJQsqYbR8A/belMfKLyNKaN7mSHf4EfmdLjj6fZxOnilflNXgZnSQ/Emizx2DyDn5R4YVZAeh8uQs0WQhJvS91mzaGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DB8PR04MB6780.eurprd04.prod.outlook.com (2603:10a6:10:f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.28; Fri, 14 Oct
 2022 10:23:54 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9%7]) with mapi id 15.20.5709.021; Fri, 14 Oct 2022
 10:23:54 +0000
Message-ID: <5bc906b3-ccb5-a385-fcb6-fc51c8fea3fd@suse.com>
Date:   Fri, 14 Oct 2022 18:23:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH RFC 3/7] fs/btrfs: support `DISABLE_FS_CSUM_VERIFICATION`
 config option
To:     Hrutvik Kanabar <hrkanabar@gmail.com>,
        Hrutvik Kanabar <hrutvik@google.com>
Cc:     Marco Elver <elver@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        kasan-dev@googlegroups.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
References: <20221014084837.1787196-1-hrkanabar@gmail.com>
 <20221014084837.1787196-4-hrkanabar@gmail.com>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20221014084837.1787196-4-hrkanabar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::17) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DB8PR04MB6780:EE_
X-MS-Office365-Filtering-Correlation-Id: 176b1c33-14ad-4643-0290-08daadce3208
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8G/AvBE8D4R2OO7cF//po9hMc+zCsnUZQzZlJh27Ur7REAANrdlqOQviu0dOoU8OLuU7JferKUzMZgsFYuWus3+/n87wjdr7LxLU9SEUpeXd8PRrthRcAXfBbK5kpXX5mia/+2wCU8yJFTO1cWFD8iBg9VTAAo3PGvb7+ClmKco4B/TBsUJuX8lEvMj8LL1pNvCeqIVc4yfO/H7TxRrvuLPNHgZvuIenlIzi3u8tXAU7GCnlAOyOmH5ztaXP7dwvgPPE1bKIJhP5/thvs2swry67IVYXf/Wr/CIM8iNvwbd3fPypA7MBbTgkqXEQrPbwWJ4zMscyydP0blIIxoLF8V+ly8rCM+BBPEC5jyvKr7UBJjZcLZOcwBT2zUt+MecKBCDE9ts6tH5y4faaRAWeSGuLXBNT861DH6RvlWunlMP2N0WN+7h/RqrbONlMmgtaLePWI79G9i25qnj/mcgY5J677hi1o/+8Q1wH0h4Nqt4jHwUGWB5UDUMX+icF1sipboE4W+rD5eQlP0CtK0+OG/waa5TGUuq4aOd9/A+0Mi3LnfYvMMyD6GlbcNaflXhyJHlunIflJjCay+YPA0LsnNDeaPrZ8CJCzQDH+ybQBqkhC5i9abhxa930madR11giPyM4BqJK0wF7THhrhV/lT1liNChQo+BiUpn6bXXAOJ3G0TDp/eIyObXC9LIyuhdXRYGbRic+UQr3Q+CgMyxYNMBbJhYuVG9jSPtOKtl70DW3Co+fRCgm567ZmoioDXTsXvejHFsDQuv6i479rFTttvPjtfzY5NhS/GbKu1AGJH9e12u8nXt/w+eqcH+39dy4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199015)(6486002)(38100700002)(478600001)(31686004)(316002)(110136005)(54906003)(36756003)(6506007)(41300700001)(66556008)(6666004)(4326008)(66946007)(66476007)(8676002)(5660300002)(8936002)(7416002)(186003)(2906002)(53546011)(6512007)(2616005)(83380400001)(86362001)(31696002)(81973001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlEvQ29pREpucWdIRnlMM3hKUWNzTHBwUkVnbFd4RDREbUR5Sll4WDNpd3Ro?=
 =?utf-8?B?YkQ0TVk5RUJOU1FoN2JyYUNSVFRha2JKeXRSckRzdW5nSGVKbGpkL1k0dDJR?=
 =?utf-8?B?S2Qrais5aEp0eEZGY1JiYzd4SE9hd25MeUtxYzRRUWJzdjdpNWo0Wk1PMXBC?=
 =?utf-8?B?QmlDUGRWUUEzOW8va1dOUTdqLzNwa1E3S2x1RjZFUlBwZWdTQ3dmTTlpb0ZU?=
 =?utf-8?B?RzJRbGZVUUY1Q1pPSTM4UzdGT2lVdDJ3cTI5TVExaVFGTHJjZXM2R0lSYUpk?=
 =?utf-8?B?NkJ5d2c4clVHdndJTVQ1SVhUWnR6b1RUSEpaSzhpWlVpZ0N3OE9TaEh4cFVv?=
 =?utf-8?B?cktYcHJ5bEIxR0hmT1NjUkdXMmVYZlJXZytBSHkyeXBGcHd5RXVrU2o1OGRF?=
 =?utf-8?B?Y1d2UE5wS1BrQkxlSnp6SlNVNVM1R1Nib0grOENzM3V2Ky9ZRHRSaVlaa1lL?=
 =?utf-8?B?MFpadk4yV1ZDNEduRmpLRldUQW1vbS8vOU0wWVgrU0xkYzJqZFliZCtkZjdr?=
 =?utf-8?B?RndBbU5LejFTY3VmMjNUelZMSzZiS0dMQmg5enhRUVZtS1gwVHBwUHAzSnBm?=
 =?utf-8?B?MkpwWHBTTUpmTkl0aG5LRVJxQmR3WU1KZnNUSE9BaSs5L0hSMEF1MUZLK2lJ?=
 =?utf-8?B?R1hYdE8vc1lHbDlFTHBLaXlWMS8ybHlEQ2pQWEZwT1VxQ0pQRlBDaEFWcnRD?=
 =?utf-8?B?VUxRM2MrVWVhVG5telFZTVpKdk9GSlg0ZkZPaFA4VlB0YVAwZWllN1J5K0VK?=
 =?utf-8?B?WkMwYi9uV0ExRnk1bjIrNmFOQmxNRHJVMDJNUTFZMDc0SEJvWk1OV3BXcDUr?=
 =?utf-8?B?WnA3OFRMVVAvbHJyVkdUNHFzVTJPRmtKUzB2NnhpYmhzOWpVYlpFb1BKTDJr?=
 =?utf-8?B?Z3VqTitxMWZxVi9zbURUZmJ4bFVneFpIRldCaW4zYjBCZ1RaUXpLaVpaazBh?=
 =?utf-8?B?d2pJR2xXUGE5RXgyaXhkSGQ4TEFqRjI5VCttSDh0a1VBY2k3UDg0QSt5YkpX?=
 =?utf-8?B?QjRyUEJ3MnFvUmVwdVRPTzEwM1Qybm5XOFF6TlI4NlRyWkNhUlhWSHNjdUtt?=
 =?utf-8?B?TzRFSllXS2JWVlNUaGFxUFpBcjNLN0xFKzkvK1Q5SFVpVitlQ1l2UDF1WXRJ?=
 =?utf-8?B?cVNUM3R5ckVkVkpIOFRGNDVxdk1TL0pWbjhUUGxleHVNWkdrdW5aaVFIT3l1?=
 =?utf-8?B?eTk5OERDVFZHUEpOVE84dXh4Yi91Yllad1EwaG9CUEI2bTg2Z0VCa1JkWG1W?=
 =?utf-8?B?aHA0QmdQT1E2WjEwaUc1Sk9HTm1ha0Q5dTlEQlU4Uk5ZYSs5TGp3dWpOeXEz?=
 =?utf-8?B?NGZwU3VoT3lJZFE0YldYYlJwV3Q2V1JySWNGMkFsT1o3WDJuMVg5M1BFN0I3?=
 =?utf-8?B?YkZOTnpZeHRhdldKZnM1QnBFOTBNM2V1UXJwbnVsWEpVdGhjYm9PWGl3V0VT?=
 =?utf-8?B?R0JkRjJMUTNPWEdOT3p3KzlDOEliZlJIT0pVZlJucENncC96VU8yNFMvTW41?=
 =?utf-8?B?Z2ZGd2JkU25LU0ZYSHFaZUd2NFlDSUtBZjc0elJ1aXRXTitvOXBLWlJLTUJ2?=
 =?utf-8?B?VTBYTk5RU0M3dEIrWnFKbWUwM2FLdnNVQnZtb1Q2TXJOUmdsL05pcUJ1Rjhy?=
 =?utf-8?B?UVZJVHVtbzZaY2dieW9OM3k1dDRoWVRaVkZCWHdYVDVSRjZhNFllUktxNWVG?=
 =?utf-8?B?L1FxZ3dNTEdnS0pMemd4VTlJenppM2diRnZNNFhodU1aMEVwMlFuRHZrSFNz?=
 =?utf-8?B?WEg5K01yWURneGdqa1I4eTFOK2JPUkg0NWZlcTdnU053cmRNRzcwc3Z4UUlJ?=
 =?utf-8?B?UUJHSWhTT2NZQWFOS2ZUa1NqditLNVhXWTVQSE1nbDBkVi9qVGh0NExCRXhq?=
 =?utf-8?B?RWYyczVRNDN0ZkxRdk5YbEUya1V3bXVOVGx4eVZZdmYrcDVwSHU1RWxRMWt6?=
 =?utf-8?B?K3l3ZWQ3bDFPQ0lZbjdOeDRUUmU2ZjA5RXVyWnBXZUQyMWdzdVZES0VqTHQz?=
 =?utf-8?B?VWJUZ0wvYnRnNVlUZ1Yva0R2R0hrejB4bTZXb2NRYlordGlzUENwc0tMdWR5?=
 =?utf-8?B?NG9DSjZUc0VrOVNUZTF3TC9jRTgzK3JSRkl3T2JjQTFUdG13V2VIZitxdG93?=
 =?utf-8?B?N1YyYnJKMUlZdWxKeUx6N3UzZE5uRDlLZ1Z6RkhvWFl0bHVYZTFLcGY0K3N6?=
 =?utf-8?Q?uih5wr0HYPSJM1C5tJgRVnY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 176b1c33-14ad-4643-0290-08daadce3208
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 10:23:54.3100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuHQVFaTSZubINcndEJyXzj4cFfjeGG8XavGacXoVFsuw6fHPSalsRKNxn+WHtAs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6780
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/10/14 16:48, Hrutvik Kanabar wrote:
> From: Hrutvik Kanabar <hrutvik@google.com>
> 
> When `DISABLE_FS_CSUM_VERIFICATION` is enabled, bypass checksum
> verification.
> 
> Signed-off-by: Hrutvik Kanabar <hrutvik@google.com>

I always want more fuzz for btrfs, so overall this is pretty good.

But there are some comments related to free space cache part.

Despite the details, I'm wondering would it be possible for your fuzzing 
tool to do a better job at user space? Other than relying on loosen 
checks from kernel?

For example, implement a (mostly) read-only tool to do the following 
workload:

- Open the fs
   Including understand the checksum algo, how to re-generate the csum.

- Read out the used space bitmap
   In btrfs case, it's going to read the extent tree, process the
   backrefs items.

- Choose the victim sectors and corrupt them
   Obviously, vitims should be choosen from above used space bitmap.

- Re-calculate the checksum for above corrupted sectors
   For btrfs, if it's a corrupted metadata, re-calculate the checksum.

By this, we can avoid such change to kernel, and still get a much better 
coverage.

If you need some help on such user space tool, I'm pretty happy to 
provide help.

> ---
>   fs/btrfs/check-integrity.c  | 3 ++-
>   fs/btrfs/disk-io.c          | 6 ++++--
>   fs/btrfs/free-space-cache.c | 3 ++-
>   fs/btrfs/inode.c            | 3 ++-
>   fs/btrfs/scrub.c            | 9 ++++++---
>   5 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
> index 98c6e5feab19..eab82593a325 100644
> --- a/fs/btrfs/check-integrity.c
> +++ b/fs/btrfs/check-integrity.c
> @@ -1671,7 +1671,8 @@ static noinline_for_stack int btrfsic_test_for_metadata(
>   		crypto_shash_update(shash, data, sublen);
>   	}
>   	crypto_shash_final(shash, csum);
> -	if (memcmp(csum, h->csum, fs_info->csum_size))
> +	if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
> +	    memcmp(csum, h->csum, fs_info->csum_size))
>   		return 1;
>   
>   	return 0; /* is metadata */
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index a2da9313c694..7cd909d44b24 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -184,7 +184,8 @@ static int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
>   	crypto_shash_digest(shash, raw_disk_sb + BTRFS_CSUM_SIZE,
>   			    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE, result);
>   
> -	if (memcmp(disk_sb->csum, result, fs_info->csum_size))
> +	if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
> +	    memcmp(disk_sb->csum, result, fs_info->csum_size))
>   		return 1;
>   
>   	return 0;
> @@ -494,7 +495,8 @@ static int validate_extent_buffer(struct extent_buffer *eb)
>   	header_csum = page_address(eb->pages[0]) +
>   		get_eb_offset_in_page(eb, offsetof(struct btrfs_header, csum));
>   
> -	if (memcmp(result, header_csum, csum_size) != 0) {
> +	if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
> +	    memcmp(result, header_csum, csum_size) != 0) {

I believe this is the main thing fuzzing would take advantage of.

It would be much better if this is the only override...

>   		btrfs_warn_rl(fs_info,
>   "checksum verify failed on logical %llu mirror %u wanted " CSUM_FMT " found " CSUM_FMT " level %d",
>   			      eb->start, eb->read_mirror,
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index f4023651dd68..203c8a9076a6 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -574,7 +574,8 @@ static int io_ctl_check_crc(struct btrfs_io_ctl *io_ctl, int index)
>   	io_ctl_map_page(io_ctl, 0);
>   	crc = btrfs_crc32c(crc, io_ctl->orig + offset, PAGE_SIZE - offset);
>   	btrfs_crc32c_final(crc, (u8 *)&crc);
> -	if (val != crc) {
> +	if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
> +	    val != crc) {

I'm already seeing this to cause problems, especially for btrfs.

Btrfs has a very strong dependency on free space tracing, as all of our 
metadata (and data by default) relies on COW to keep the fs consistent.

I tried a lot of different methods in the past to make sure we won't 
write into previously used space, but it's causing a lot of performance 
impact.

Unlike tree-checker, we can not easily got a centerlized space to handle 
all the free space cross-check thing (thus it's only verified by things 
like btrfs-check).

Furthermore, even if you skip this override, with latest default 
free-space-tree feature, free space info is stored in regular btrfs 
metadata (tree blocks), with regular metadata checksum protection.

Thus I'm pretty sure we will have tons of reports on this, and 
unfortunately we can only go whac-a-mole way for it.

>   		btrfs_err_rl(io_ctl->fs_info,
>   			"csum mismatch on free space cache");
>   		io_ctl_unmap_page(io_ctl);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index b0807c59e321..1a49d897b5c1 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3434,7 +3434,8 @@ int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
>   	crypto_shash_digest(shash, kaddr, fs_info->sectorsize, csum);
>   	kunmap_local(kaddr);
>   
> -	if (memcmp(csum, csum_expected, fs_info->csum_size))
> +	if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
> +	    memcmp(csum, csum_expected, fs_info->csum_size))

This skips data csum check, I don't know how valueable it is, but this 
should be harmless mostly.

If we got reports related to this, it would be a nice surprise.

>   		return -EIO;
>   	return 0;
>   }
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index f260c53829e5..a7607b492f47 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1997,7 +1997,8 @@ static int scrub_checksum_data(struct scrub_block *sblock)
>   
>   	crypto_shash_digest(shash, kaddr, fs_info->sectorsize, csum);
>   
> -	if (memcmp(csum, sector->csum, fs_info->csum_size))
> +	if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
> +	    memcmp(csum, sector->csum, fs_info->csum_size))

Same as data csum verification overide.
Not necessary/useful but good to have.

>   		sblock->checksum_error = 1;
>   	return sblock->checksum_error;
>   }
> @@ -2062,7 +2063,8 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
>   	}
>   
>   	crypto_shash_final(shash, calculated_csum);
> -	if (memcmp(calculated_csum, on_disk_csum, sctx->fs_info->csum_size))
> +	if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
> +	    memcmp(calculated_csum, on_disk_csum, sctx->fs_info->csum_size))

This is much less valueable, since it's only affecting scrub, and scrub 
itself is already very little checking the content of metadata.

Thanks,
Qu

>   		sblock->checksum_error = 1;
>   
>   	return sblock->header_error || sblock->checksum_error;
> @@ -2099,7 +2101,8 @@ static int scrub_checksum_super(struct scrub_block *sblock)
>   	crypto_shash_digest(shash, kaddr + BTRFS_CSUM_SIZE,
>   			BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE, calculated_csum);
>   
> -	if (memcmp(calculated_csum, s->csum, sctx->fs_info->csum_size))
> +	if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
> +	    memcmp(calculated_csum, s->csum, sctx->fs_info->csum_size))
>   		++fail_cor;
>   
>   	return fail_cor + fail_gen;
