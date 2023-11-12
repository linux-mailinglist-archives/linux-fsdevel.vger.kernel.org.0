Return-Path: <linux-fsdevel+bounces-2768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C1D7E8EF7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 08:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E871F20FBB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 07:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049E36D24;
	Sun, 12 Nov 2023 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RCCIBE+f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FA633E2;
	Sun, 12 Nov 2023 07:36:13 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F3D2D6B;
	Sat, 11 Nov 2023 23:36:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fm2E+Rgki1Uv/eoPDkG84/AG/sdxgZvxkzaXaHGPsWLszootLLj0el09rm7KTBGHjU2t2I3sfA5Zd1Z2fl+zg0XhrUpfMNkmy8NLOPXcFtUSHGtYJqGfXHqE0yniBMT2oPBg7fu1o6SlJaU/h2IG0KiT9mddCC2IjllEy7hvVm7WBcwmeC+pD+8WoaYFrb0LZ0P0bLFNFzJywf6ykPItoqERIMUhixA6RJ9sn/p+sJf1UPCHZO9KTS8iQpE7BG+cyr/X97ZwMN1NV+gLqatngLq5rbWQM1F/CxgVVwRuiJlBu2pgtM9kL9qJ7TvWe2LsBPtOkFpz1/86snCG3b3ngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QHIykut6Z9EXzoW56V+M8fwGoo9Q+smrOQKI/kLGPU=;
 b=UdiR0Dorh/U798iFGnThtDpwyCCvo3l0LSKEkk+UGXVUsmrof/pNWkVwuBm1T063jq9knI5FACCkTSD3/JJN2qMq/YNHbSlpEm3sthwbR7DluONQYOM/ViYYV76t4adkaSmB2m0lGh/eZwMR+sWjL4FTNpP0bwNXUYmNQ9SnxHD8/ZGUv5lfgMJa++UhRCu1Zg+4KDw276yzBlMHnIPSpe8SUqHWlStTwJVhg7S9jYANuzOTjpMlC/Unbq1IHcqdvnE3NOyjEr9Cwo88dDxXVWYhD0fQuAPpNklL5DEMJ87ZDlnNknET94Ecs2NrU7DGLC+19Sux6nxiuodQn/RrLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QHIykut6Z9EXzoW56V+M8fwGoo9Q+smrOQKI/kLGPU=;
 b=RCCIBE+fccabAXI8qXdEK/KAhW0fHkqSzmKYn0Ji3J4wXE76GOzt+pjwWFP3yC0RbMJ+66OmqPAltpb+lT6RIGqQgBBWJ9a5uh9mcYwrw0ho8GnYv5G/u1ugIdApWGiqwHceKfayGaqFWan3Hz/BOJzphwvppcj2jGimSebT3ieAFp6LXbt/K1Ccbi5zK4KacEEg1ZyzZTKwaxrbwi7jKNCGi3lutMvA6SitUg2VExVPyovHaCEnZg4DoHnBjgzQRc6VVLadit8NSv+cEVry4IeImzHTCMSBLQ+RAiKRppzSeyt4EkO+3h6yU4LGJFCgqvlCZqiES/mzb66R6mCldA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DB9PR04MB9648.eurprd04.prod.outlook.com (2603:10a6:10:30c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.14; Sun, 12 Nov
 2023 07:36:07 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::8d82:166c:1cf2:95b6]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::8d82:166c:1cf2:95b6%3]) with mapi id 15.20.7002.014; Sun, 12 Nov 2023
 07:36:07 +0000
Message-ID: <4e5ec572-9489-4c4e-a2c6-1ed497fe3491@suse.com>
Date: Sun, 12 Nov 2023 18:05:55 +1030
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] btrfs: fix warning in create_pending_snapshot
Content-Language: en-US
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com
Cc: boris@bur.io, clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000001959d30609bb5d94@google.com>
 <tencent_B9A7767566563D4D376C96BE36524B147409@qq.com>
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <tencent_B9A7767566563D4D376C96BE36524B147409@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEAPR01CA0098.ausprd01.prod.outlook.com
 (2603:10c6:220:60::14) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DB9PR04MB9648:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a50795b-c67d-4269-7951-08dbe3520849
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qW4pgCJWdyl931vgv6Fcr/HSmrgREh6JvJzdyCyrhlE7sfhjnijZFdvjcczA1AGFXV5XVbgv0t2D5wn3u0DAPnx5VhbTikeXWHM0hpgjVoBP7VQsIqL3IILZz4v6JzOso67acYopf+KkYntmNJNYCD0U9XjwDm+2ywYmv+x68mdoS586Qww5lv/bfxKMFPxWbyvzJLuejd+r/vNNcHZp4P8Zv+5ayzx4CXHZ3w3TTdWSJ7QHmzs8QS5lyvsStviCQuniNx6iSrIRLUCQ+Y+FthVbQdYp9RXreAC+qV3ew+9F+wNEztGQGKRb0gHWfvHIhIRtHUogal4KjEyfeILtRPsvfbjQnvffypURJBf1b+a3vlHSTZn6ceIm297wvYbQNyfay7dragYoOs0oEinfPOAq5K+6P65ba71zYi9Bz4QTCoz4/jXUTK19IlteSj3OpnZObs5lxiDHGH17FfsGDYxK/hDUnFWi8N4lHW8tDOlQSOOGdG9GLrj6VaFULNgRnWHPyTQplpmuMvwdwL8LZWu/2lbOE5d3b5aP70cKUrYA/l1Vqh3eBujh7IvDixV2KQhZLiczAiq5QoD7wUyYFu9MZP587yMg0BQArzKvnSWAwF32CiLmCkjfu0pLPioer7GhrM95J4Zk/iYeMfhVRb3BfzclxOODiUWEeLxWjVBubWAoKBMcltnCk3dft0TJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(39860400002)(396003)(230922051799003)(230173577357003)(230273577357003)(64100799003)(186009)(1800799009)(451199024)(2906002)(8936002)(8676002)(4326008)(5660300002)(83380400001)(41300700001)(31696002)(86362001)(966005)(6486002)(478600001)(45080400002)(6506007)(53546011)(6666004)(36756003)(26005)(31686004)(6512007)(2616005)(316002)(38100700002)(66946007)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QysxeU9ERTArWWdjN256NU5SMjRmdklZbFEvY25MWitPcW02cnhtcDhYUjFL?=
 =?utf-8?B?cnZqNGdpcjZwQ2RpQm9ZRUV4ZmpIZlFNekJ0cjNJOXBHNkZuVHZlRGdUK25i?=
 =?utf-8?B?b0ZYT2ZxUkNNekY1UjNqbFFyU2ljQzRleWZqdENvTUdzUWlSTDJWaHBXMWdH?=
 =?utf-8?B?MUg3aCs2RnpLNFlxYjdRZ2tUVnVnaVFseTBTcmJmQ0xzc1cyM3dRS1c3TnNS?=
 =?utf-8?B?TGdwcjFDMkw4RlhkNEp0L3lSczZtUisrdkJ4Y0U1L2ZUYld0Vk0vdTRtUzNB?=
 =?utf-8?B?ekdlRStSejVOQ3I5NkpBbGZjZ0JWeHk1ZmlEQ1FwYnh4MHh2eHd2S2FmeXND?=
 =?utf-8?B?bWljbFpNdm5hcVVGWEhOSUR1elVQb2hoWUM4ZGtHU1JlVG01WXAyWm4vQjUz?=
 =?utf-8?B?elFlY3hRVGUxYlFCcENWQlJsc2tsS1RFUjE0cjNhanFWV2RNaFBqV3FSbnp6?=
 =?utf-8?B?NkRnd3RDRFR2Ny9oekkvbklsV3pIcHczT200MkZTd1k5a3lZQWhJcnpKUWdz?=
 =?utf-8?B?ZWdKUzd0ekRhWHlZOWNFNENEbGZQK3hZL3pzRlRxTG85eWxMQ0hNUWxsVkI0?=
 =?utf-8?B?cVQybWZJREJiWUtoWXlKUm5Oa3V4MlJKR0Jkem44ZkQ3SHNLeEZlcSt1K3JG?=
 =?utf-8?B?NDRPQ1N4VXlycGsrMlR6OXpsNHdJQ0pnZG9PZEhyZTA1Qnh3TmUza21MRVhv?=
 =?utf-8?B?QXRiV0NwOVp6UDFRTGlsUlU5OUVFRmFmZjlvWkV5bFNTVk5WcjkyWnFacy82?=
 =?utf-8?B?VzJ0Y25zbmQ3Ky9WeGxvZWUxUzBxcDh3dkkrZGsvNjRvaGh1dDZaaExDZ1g2?=
 =?utf-8?B?RU1tQk5QOXR3MHlDMXJrK1JESU45OUhVT3hoQUxrZmI0SlF0cEx6b2lhOGpw?=
 =?utf-8?B?R2JGUlFyb3BIMDR5cXdrUFBDMGNjSDUzdndtSTRsM3E1QWZJUDhxckdqWUt3?=
 =?utf-8?B?YThxUExRd0l1Q09rWjl4YXlFbTBvNlFxbEdsQ3p6Z25hS3FySCtzbythb3hi?=
 =?utf-8?B?bnBtTVhySHI0Tk1LcGIyWjNXYjVnQkFOSE5Xb2FrQkU5UlE5anBvSjQ0UVE4?=
 =?utf-8?B?bkRjb0IwRUtXL3daOUtRbWNMMktPblFTYXdVY01sdENwcHV6Z1pMZS9TSWFH?=
 =?utf-8?B?SG8wTzM0SEQ3WnNrMmdJYXJGcDgyZC9Fa0RueDJSWWhGc0hrUFJLY2U4VERO?=
 =?utf-8?B?eHRVMTA3RWpaeW15RWRqamtiN29QOXR2NW8rZEw5VnJIcmpTV0g1U2tKeS94?=
 =?utf-8?B?NTY5UmVGYmVHZ0sxQWxqY1plY3QyajZFMFZpbFNQMnpQRXF1eVdLMlhPeGhC?=
 =?utf-8?B?d0N6bHpBSHprN1VlNERpZWhGME9pMWc4Nm9XMFZyRXd1Ryt3TElyTWNNd3B0?=
 =?utf-8?B?QTlBR2tLWlo4T0J4WExOMGUwY3FPRnVjcmxrN2F6cCs4ekF5MElBM0pQQ29H?=
 =?utf-8?B?ckZCUEM3QWlWdTgrWU80MDRFZzZFOHM5aUtTajg3bjMybmFQY1U4RGt5SUF0?=
 =?utf-8?B?czRsVWl4TmJnbGNWZFdWM0xndWZVWmJUYzE0elppdTB4SmtxdjBGeS9CekRk?=
 =?utf-8?B?d1d6U3RlQTZNbGQzWlRoNzhnWTUrcHNuUWFhd0U0YTY4Qld1b0NqUzJNY0lh?=
 =?utf-8?B?bGpJcWRNRG5lSzhjcThuZ0Vydld1bGN3NkprVXFTY2R2L1lnQmtzNXZHUXE2?=
 =?utf-8?B?K20xYXhGeWV5YlVJU2N5NWQ2cWkvM2FtSU8xK3YrSEtCZHQzZnNPYzhHaHBh?=
 =?utf-8?B?QTN0T2hBL0traTE5VVRhUncyZlZCVmVpaDJWcndma0cwUFFtNVl4VFRTbGE5?=
 =?utf-8?B?RG0ySE0yL3BjWml4bTNpMVFzSHpJMCtlZmpZYzBISGo5YWNNK0w2TFVQcWdJ?=
 =?utf-8?B?K1BDRlVnbTNEMzUwQlh6UnpTcHh3SDRQSkprcUdKOVY2UGNKODdUNmlDeDRq?=
 =?utf-8?B?c3JKWm9jQVBSVkltdzVBTVZ5WU9nUWlFc3FjdGV5OERpVjF6OE5JenpqNjZl?=
 =?utf-8?B?eTBYU0x0Vm9oRGFQdnAzQXVEOHlsV2diZlBJbFdmUnZDNlMwcUVrR3RvQlQ2?=
 =?utf-8?B?TTdveklDLzlMa3AydlRMV2tUUnBOVjNPY0hTY2UvSGdlekQwNG9wOXRNYVo5?=
 =?utf-8?Q?lNM4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a50795b-c67d-4269-7951-08dbe3520849
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2023 07:36:07.0428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3/J3OmP/Uu7RTBPok2Rt8/f7YZ9a/88IC5bYGkeX34B2QjajQzWJ0Ig8xbqwtnz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9648



On 2023/11/12 15:18, Edward Adam Davis wrote:
> [syz logs]
> 1.syz reported:
> open("./file0", O_RDONLY)               = 4
> ioctl(4, BTRFS_IOC_QUOTA_CTL, {cmd=BTRFS_QUOTA_CTL_ENABLE}) = 0
> openat(AT_FDCWD, "blkio.bfq.time_recursive", O_RDWR|O_CREAT|O_NOCTTY|O_TRUNC|O_APPEND|FASYNC|0x18, 000) = 5
> ioctl(5, BTRFS_IOC_QGROUP_CREATE, {create=1, qgroupid=256}) = 0
> openat(AT_FDCWD, ".", O_RDONLY)         = 6
> ------------[ cut here ]------------
> BTRFS: Transaction aborted (error -17)
> WARNING: CPU: 0 PID: 5057 at fs/btrfs/transaction.c:1778 create_pending_snapshot+0x25f4/0x2b70 fs/btrfs/transaction.c:1778
> Modules linked in:
> CPU: 0 PID: 5057 Comm: syz-executor225 Not tainted 6.6.0-syzkaller-15365-g305230142ae0 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
> RIP: 0010:create_pending_snapshot+0x25f4/0x2b70 fs/btrfs/transaction.c:1778
> Code: f8 fd 48 c7 c7 00 43 ab 8b 89 de e8 76 4b be fd 0f 0b e9 30 f3 ff ff e8 7a 8d f8 fd 48 c7 c7 00 43 ab 8b 89 de e8 5c 4b be fd <0f> 0b e9 f8 f6 ff ff e8 60 8d f8 fd 48 c7 c7 00 43 ab 8b 89 de e8
> RSP: 0018:ffffc90003abf580 EFLAGS: 00010246
> RAX: 10fb7cf24e10ea00 RBX: 00000000ffffffef RCX: ffff888023ea9dc0
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: ffffc90003abf870 R08: ffffffff81547c82 R09: 1ffff11017305172
> R10: dffffc0000000000 R11: ffffed1017305173 R12: ffff888078ae2878
> R13: 00000000ffffffef R14: 0000000000000000 R15: ffff888078ae2818
> FS:  000055555667d380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f6ff7bf2304 CR3: 0000000079f17000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   create_pending_snapshots+0x195/0x1d0 fs/btrfs/transaction.c:1967
>   btrfs_commit_transaction+0xf1c/0x3730 fs/btrfs/transaction.c:2440
>   create_snapshot+0x4a5/0x7e0 fs/btrfs/ioctl.c:845
>   btrfs_mksubvol+0x5d0/0x750 fs/btrfs/ioctl.c:995
>   btrfs_mksnapshot+0xb5/0xf0 fs/btrfs/ioctl.c:1041
>   __btrfs_ioctl_snap_create+0x344/0x460 fs/btrfs/ioctl.c:1294
>   btrfs_ioctl_snap_create+0x13c/0x190 fs/btrfs/ioctl.c:1321
>   btrfs_ioctl+0xbbf/0xd40
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:871 [inline]
>   __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
>   do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>   do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
>   entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> 2. syz repro:
> r0 = open(&(0x7f0000000080)='./file0\x00', 0x0, 0x0)
> ioctl$BTRFS_IOC_QUOTA_CTL(r0, 0xc0109428, &(0x7f0000000000)={0x1})
> r1 = openat$cgroup_ro(0xffffffffffffff9c, &(0x7f0000000100)='blkio.bfq.time_recursive\x00', 0x275a, 0x0)
> ioctl$BTRFS_IOC_QGROUP_CREATE(r1, 0x4010942a, &(0x7f0000000640)={0x1, 0x100})
> r2 = openat(0xffffffffffffff9c, &(0x7f0000000500)='.\x00', 0x0, 0x0)
> ioctl$BTRFS_IOC_SNAP_CREATE(r0, 0x50009401, &(0x7f0000000a80)={{r2},
> 
> [Analysis]
> 1. ioctl$BTRFS_IOC_QGROUP_CREATE(r1, 0x4010942a, &(0x7f0000000640)={0x1, 0x100})
> After executing create qgroup, a qgroup of "qgroupid=256" will be created,
> which corresponds to the file "blkio.bfq.time_recursive".
> 
> 2. ioctl$BTRFS_IOC_SNAP_CREATE(r0, 0x50009401, &(0x7f0000000a80)={{r2},
> Create snap is to create a subvolume for the file0.
> 
> Therefore, the qgroup created for the file 'blkio.bfq.time_recursive' cannot
> be used for file0.

What? That sentence makes no sense.

It seems you didn't even understand qgroup is for subvolume, not for 
'file0'.
Btrfs just uses that fd to locate a btrfs, not to do operation on that file.

Thus your analyze still makes no sense, even you have already reached 
the core problem, we have a qgroup created before a subvolume with the 
same id to be created.

> 
> [Fix]
> After added new qgroup to qgroup tree, we need to sync free_objectid use
> the qgroupid, avoiding subvolume creation failure.
> 
> Reported-and-tested-by: syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com
> Fixes: 6ed05643ddb1 ("btrfs: create qgroup earlier in snapshot creation")
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>   fs/btrfs/qgroup.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index edb84cc03237..9be5a836c9c0 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -218,6 +218,7 @@ static struct btrfs_qgroup *add_qgroup_rb(struct btrfs_fs_info *fs_info,
>   			p = &(*p)->rb_right;
>   		} else {
>   			kfree(prealloc);
> +			prealloc = NULL;
>   			return qgroup;
>   		}
>   	}
> @@ -1697,6 +1698,7 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
>   	struct btrfs_root *quota_root;
>   	struct btrfs_qgroup *qgroup;
>   	struct btrfs_qgroup *prealloc = NULL;
> +	u64 objid;
>   	int ret = 0;
>   
>   	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED)
> @@ -1727,6 +1729,8 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
>   	spin_lock(&fs_info->qgroup_lock);
>   	qgroup = add_qgroup_rb(fs_info, prealloc, qgroupid);
>   	spin_unlock(&fs_info->qgroup_lock);
> +	while (prealloc && !btrfs_get_free_objectid(fs_info->tree_root,
> +				&objid) && objid <= qgroupid);

I have replied several times on this, if you didn't receive it, then let 
me make it clear AGAIN:

   This is the wrong way to fix it.

When creating a qgroup, the qgroupid is either specified by the end user 
or by the subvolume to be created.

In that case, it's the create_pending_snapshot() trying to create a 
qgroup, which has the same id already created by previous ioctl:

   ioctl(5, BTRFS_IOC_QGROUP_CREATE, {create=1, qgroupid=256}) = 0

Now due to the new timing where try to create a new qgroup when creating 
a subvolume, we found there is an existing one, and return -EEXIST.

The new call site just treat this as an critical error, and abort the 
transaction.

The proper fix is to handle -EEXIST and continue, no need to abort 
transaction as it's not a critical error.

See the proper fix here:
https://lore.kernel.org/linux-btrfs/b305a5b0228b40fc62923b0133957c72468600de.1699649085.git.wqu@suse.com/T/#u

>   	prealloc = NULL;
>   
>   	ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);

