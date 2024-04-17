Return-Path: <linux-fsdevel+bounces-17202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E888A8BC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 21:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99CBE281B45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 19:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FDF28DD5;
	Wed, 17 Apr 2024 18:59:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2130.outbound.protection.outlook.com [40.107.243.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0D21DFF3;
	Wed, 17 Apr 2024 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713380398; cv=fail; b=DnAL94tlN42U6zOeU7WsRYSbP3MY82ZLrE+XwAK97i+O0ZKsS8me8G33em9MXlv6nWUKPXhKuN+VVjR/0BniwxenYEXT6zFANLSkCdTmUiDIKRwUnJKvIsk+NWEXwTN44TD/UARXrjAKGqj3VEqXD1F5W+t73Hsb3qkmPESZuPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713380398; c=relaxed/simple;
	bh=6efT8j3Ol15qRg0PJRIGIDgZtNQIeTGQIoOfx5nsxvA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ijX5fSMSnwC16+4Y73BBnwyYkZp8CtFagfYMy9QNJHJSt/KZ1P07Mkj4vpGAsNsvfrd7VTD1r2Mo79mFKPICF1DZl46MofkN/uqbAleX0xXmT0P4nx6oX17HNsLttUoREqD1mUgi6bqjY+q9g6oYMaKYEn8P5B+svBfniEVvtDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.107.243.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQuF01Hj1riem9C+zCGKA+ALywO5S1gqEbOzag7JmESBlqPQuKlIQczwdQfJcsYnLpHU29nFWGqMpqqegl5s0t9fHyzl6P6fLj8bvl/x6JhM+mv4dDIyxWq4Joew9dhp9FtR3H+hI3aJ3v8y+OX0Vm1EWXmfzro5D+5PS5Bzg1iEAxnWHNnohITUsMsKw1xZHg9lh3EjoNSZxXqz2PprLxDemgbSDgrNkRdYbfnEG4xT1S/TPHdEx7LzTxuIKIMPNhiSZ8j5nqS31D9YLbINpY/9DjuKXdjyHouff45GjAulEkpM5kcLBoHA84WpbgLkD0XfYTds/v/6JQ8ULm9/fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpDebR9NtUL5YhX00pDTxW061235RMhGzzgqwL/hkps=;
 b=ZL7kSuF3q5Xsva0Cf/bGu97XoqGVAyFyz+qhnPHjCY562RhEbZlnoFtWka7ReATTOV61+OhYbSpMQ/rLb4ZGZ17xq2QRbyycR2CHKhMIxDlgkhiSZjNXxjihKDaJhwXun5uhhQNg2dy7zB0VXCgMXZ3yjf3SR6SfoVkyYAleryawn32AWkytjjOvqNM2047fIK6Z1TZvEqlfAc1TBdLyULPAPdSobLxUJigoNqEI7/U+iM/GsIxeimAN9UrckRvYvQ1+tSjv0hfE77FY56GRxodKckIPliM44ryP8qio/NWTLEixCXGoFkxlMxyZdZTRHPAw+8IIVKvGjEaBnyYvYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from CH0PR01MB7170.prod.exchangelabs.com (2603:10b6:610:f8::12) by
 MW6PR01MB8368.prod.exchangelabs.com (2603:10b6:303:246::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Wed, 17 Apr 2024 18:59:53 +0000
Received: from CH0PR01MB7170.prod.exchangelabs.com
 ([fe80::260f:c1b2:616a:af0]) by CH0PR01MB7170.prod.exchangelabs.com
 ([fe80::260f:c1b2:616a:af0%6]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 18:59:53 +0000
Message-ID: <e33d0b65-fc0b-49ab-ba48-7a13327d88aa@talpey.com>
Date: Wed, 17 Apr 2024 14:59:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cifs: Fix reacquisition of volume cookie on still-live
 connection
To: David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.com>
Cc: Steve French <sfrench@samba.org>, Shyam Prasad N <sprasad@microsoft.com>,
 linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1a94a15e6863d3844f0bcb58b7b1e17a@manguebit.com>
 <14e66691a65e3d05d3d8d50e74dfb366@manguebit.com>
 <3756406.1712244064@warthog.procyon.org.uk>
 <2713340.1713286722@warthog.procyon.org.uk>
 <277920.1713364693@warthog.procyon.org.uk>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <277920.1713364693@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0298.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::33) To CH0PR01MB7170.prod.exchangelabs.com
 (2603:10b6:610:f8::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB7170:EE_|MW6PR01MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c8ab250-5da6-4f93-7b28-08dc5f1090b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JwoEO7pEKlmxog3CLp+2y4eBvBMz1mOgJ8YC/maCVSO6XkodF/m3SZncwIZF/vc0eScP/U6VBjSg7q0yBGm8ZGG+kE94Q14Pkh9roz14W50xDsfiLhsxqMVM/JE+e79Y246hmtEChwgy5S7VpwICCruqVv/FvMoxXXcXptB6kynYLOP9lich/aNuWVYjminc+co4HnWMTA4IIIRlp+B7WnLX4Ag2CslvnIN+fua5J7GSPo5yvxAIVafPp8qSZw5l3/VyGR6AuxSehZqoNwVRScU9wq2pMi4hWheto5eqk9fTwqp26JtLNK6yTJpJPYO45WdBaZBvAMGbgwncNcZ8eD0bpQmT8CdEUH93KKd78+unvFkZv6fXePFjr3mZKYRCjoUENTFao9eSD3brqbsSOSFiKz7yjAbQUuiNDEqxmhGQcfVTF7zeeeLLgTv6VVeqVrPJqwXj7EhywEWihzpRLMHe/yTBtd1E46MU6z/gNl9COaiSz3ySTc3HnvyT6zuwXeh9K4ZRyLyG/YU73nO5Gt6pqqlJ2YatqhADnJlOvF8pGtY7XoXhqd+7/Z/NaEK0fYMKvzbFDRGPH5zw3kNxU30d/h/FB55oJCtWSSUJzRrZe3jT9FEwqcOz/HLAjQtj+lyWxVdxeycc2bJlWq7Iq0L1YY4SlrzPhkRh0f0CGjg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7170.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2tmR3NrRUJyZ09XR0lwcXpST0pERGU0ZHNZK1VWcnpkNzVoaGdqV0IyNXBq?=
 =?utf-8?B?cXVrTHYvQmdVWWNUNEZoV2Jick95UlZJZDNZaFFkSitWc1VHRjBnVFpBWkt6?=
 =?utf-8?B?d0hOaFJmNC9Eemx6eGgzT1pkUWJiSmIwOG5XUzMwaGpFWFFkUTdEVEF2aktJ?=
 =?utf-8?B?cXdWaWFBTUZObTROWnFvTmZ5UUwwZmxVTWZpYXV2SmhKakE5TitONDVWTEV1?=
 =?utf-8?B?aVkxM3puMFRqdmVWU2d1NmlwWU84Si92UVFEcDByYkNJM1dvMW9uSWltSEVj?=
 =?utf-8?B?VDEyMzc1T21GbFF3eFJVSjJ3OHlrenZmOUFGa2NyS29xaDY5TDZXQTVVbHU0?=
 =?utf-8?B?bFh3TGw3NUJnUzlVb0NpTFhOT29hQkY4VzNnMjVnbFZxQTN4YW82ZTBtcW1n?=
 =?utf-8?B?YkhSSjNIaDhNZm5uN3I0TEh5TjJHVVVONk8yWlV3N3B0NlFkSEs0Ull2WVhq?=
 =?utf-8?B?bCs2aWpTM21aNThZVTFPbEVSWXJQUjVuWlBpVjdCWjI4RzJ0bFpIWjNaN2lU?=
 =?utf-8?B?dGMwMGRrRGlCQXdvOUpNNGxoczZGa29KeG9LUkxKRWdnVFVDWERkNVBic1lK?=
 =?utf-8?B?dm54QWNLQ09MeXNnWldvNzRIeVNmaDY0WlhuNkkrSkZFT0hML3FYVUJaSk0w?=
 =?utf-8?B?bjlGVkxqTDFleWhRYzFPUGhFNFhEL3pCYWdqaHhkL0xMRHpqRDFaa3hkQ1Zr?=
 =?utf-8?B?RG9TdUxzbnJvL2lITUNLeEdjcWtSZ2pkQVlVNnNlclBUL1JkT0MrSlNpdEVW?=
 =?utf-8?B?Y2ZFcnNGVm56TDRsSFFrWGpuUDFkRVp1Y3M0ZGpiNWlPeHJBdUhrNlBuTGRj?=
 =?utf-8?B?clZhYjRxVkczNnc4QWh4YW5OZGVVZXE2WWRrZFhaVnJaWk9oZXRTc3ZMNXZR?=
 =?utf-8?B?eVFOY2xJek1nanBuQXYvby9kemxMckFaSEZXVzdtZkFXTW92ZjAvSXkwSm04?=
 =?utf-8?B?UEI2NWsyWjc0YXkwVVltUk9ueEs3V1dkUytkQzNpcXI3cHczWHRNZTY1Qmtq?=
 =?utf-8?B?OEJKWTNUZHRXbDVvbVFsUHp6ck9semlHQThhVnlDYis5ZTRQemRjUlRHaVlJ?=
 =?utf-8?B?RmU4U0hpenNjbkpWekNXZnFpVUE3dFZSaXVUTVdiV3hPWXRaQkY4RGZCWjNT?=
 =?utf-8?B?c29pdVExdUx4WDRvQ0Fmc1ZLSWQzNU0zVmIrOE4zUTVvcmE3YStiYk1mTGhr?=
 =?utf-8?B?U0JLbERVRXVxejV4TGFtazlDQW0wQkZXRnJ4VHo2RERRUmJza09rOTNBVmtJ?=
 =?utf-8?B?bnNld29oL1FDOXZ4VDIrMzYwYnAvOGpoaW1SNW95YjVpMmNGaGJJTHp3WGFv?=
 =?utf-8?B?RytKK0xOcGdXNlE4VUhXMktvcVlNeG9PUjk0UEJ4bUFUVWkrdDRBYmVaM1NH?=
 =?utf-8?B?STU3c0Evb3RISVN2a0J3eldmWEZkaWZENkZXQjVCa3NlRVJHQjlKRlBRVlFx?=
 =?utf-8?B?STZHV2hBRDd0T0tjWkR0dHY4ZVVNTXozbFRMQmZNRjJMRFJNUzJrM2JvQVJ2?=
 =?utf-8?B?RDc1azZkNmorU1NyQWNmK0RoNWFaaW0vTnhNamM4THFrc0svVGE4Yk1ROCtY?=
 =?utf-8?B?Mi9QRFhRMG1tMkpqbDFWTlF6VEtGN1BETHdFOGtNR3pldzdLMjU3dFNaRFhY?=
 =?utf-8?B?SG1kVFhEWWxYU3NzWHQwWXBHM3pUc3BxNFM5azg0ZHlZZHpOQ211V1VBbXBQ?=
 =?utf-8?B?TnY0anAveEhJVm12bXdoa3RxUzU0Zmw5KzcyREtzdG1yR3p4T3lNM2J3MkJ6?=
 =?utf-8?B?cXhmYXV3ekV0QWVZWjdnZzJSR2xtTDkyVUkrMk95TUdsL29BWHZRbGZ2M3Ay?=
 =?utf-8?B?ZFlzd1ZRdCtZV2N3L0VOa3hLZUQxNy9na2docjhRQTlOU29qOVlxU2M4NHkv?=
 =?utf-8?B?YzBOT2R1MkZrRUcxRjJKdnhkQXZKNlBVL1V0blBYVmZxeDcwbEFsZHJWZnY2?=
 =?utf-8?B?SGFvZm5ZbzRUYXpvL2RhQmU1ckl2YnZDdWhISG5nRjN4d2Z2d0lKNmtsL28r?=
 =?utf-8?B?cVhQMlVRM3N3OGppSERvNDZoajhGcVhtZG04STNkZUJmNjNZbnBRdis5UEp0?=
 =?utf-8?B?ZkpNUzNKUjZVUWExdjVnOFV6azhvTWEzdU1TWDFPK1huWkthejZQbGNZb05Q?=
 =?utf-8?Q?0JuacblR4bqk2RBp3C5uYDAgs?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8ab250-5da6-4f93-7b28-08dc5f1090b4
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7170.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 18:59:53.2800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYPI4yhb2OplAO/E3r6sNX8IR+9OAaIewlCZjNuj83jsNOJw+MS0B8vLGwZaiBA2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8368

On 4/17/2024 10:38 AM, David Howells wrote:
> Paulo Alcantara <pc@manguebit.com> wrote:
> 
>> Consider the following example where a tcon is reused from different
>> CIFS superblocks:
>>
>>    mount.cifs //srv/share /mnt/1 -o ${opts} # new super, new tcon
>>    mount.cifs //srv/share/dir /mnt/2 -o ${opts} # new super, reused tcon
>>
>> So, /mnt/1/dir/foo and /mnt/2/foo will lead to different inodes.
>>
>> The two mounts are accessing the same tcon (\\srv\share) but the new
>> superblock was created because the prefix path "\dir" didn't match in
>> cifs_match_super().  Trust me, that's a very common scenario.
> 
> Why does it need to lead to a different superblock, assuming ${opts} is the

The tcon is a property of the SMB3 session, it's not shared nor is
it necessarily created at mount time.

Tom.

> same in both cases?  Can we not do as NFS does and share the superblock,
> walking during the mount process through the directory prefix to the root
> object?
> 
> In other words, why does:
> 
>      mount.cifs //srv/share /mnt/1 -o ${opts}
>      mount.cifs //srv/share/dir /mnt/2 -o ${opts}
> 
> give you a different result to:
> 
>      mount.cifs //srv/share /mnt/1 -o ${opts}
>      mount --bind /mnt/1/dir /mnt/2
> 
> David
> 
> 
> 

