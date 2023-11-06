Return-Path: <linux-fsdevel+bounces-2046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 484CE7E1BCA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 09:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB917B20DA7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 08:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FD1FC03;
	Mon,  6 Nov 2023 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="1A/QG7O/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4B8E555
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 08:18:28 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2063.outbound.protection.outlook.com [40.107.6.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B785B0;
	Mon,  6 Nov 2023 00:18:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/jX2g9F7emWNwZUrbdKSHgPgPvX7wtHljEHWTgYMhNB/Ggew+vKCIquhwIhybCcLnZN/rWqcZuIJ7E8owrxjghe990KIkcFmug+NAj5HdQOif2TDWnNpaBKx9lS9LBds7ClFRJyuiI+SmQUMgGr8TABfakXUXYDXg2Rpi2/8qsKDeurLuJeoq357LU9EwwU+SK3P6UknYdScS1wE206+HVNwMIY1/P0GQvPfz+8nv7g3jqlYvrJXH/N+1XG396Dp+V33F+26v05CQSbn5myEQrxSQmdR3D9ip4zbdPSJExMGE575v7UhPrCV7MpUDLWLJuZOBLnv4Y5blTnMv4VLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygVBpqEFDcDHeWX8+cscGL7+kvIgEdtfJBC0JlYRAy8=;
 b=XbFsYwk6kBC1O6Lgikut54PWOY1ZX99ulzAsyip5NILMKthOedHA27p+DEL1bcPUXXAilAb6BAg3rMFexT7zFHE2TBz5TXg8FKlWCe97PrGRb3mSYe/dCS3m3AbjFmXMIZof80dkSyrEWHNfJQF/i6bvW7PobnxxItwO3R/a9EmI/2bOQ1qW+TVquvMsXROtRjaTIYBNBfdtUyoF8ikTFTcR3+YaxypjpVKDNu43uVaHPtxzCMDbl/TM+MSEcMlubxnmBUSibWDsCa715f4E6HX1txWPDNuDnKzbdKt88nKrJiqL+WOCGOoZpSl01wsWX3rB54KqZSMNpyqj2rVA9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygVBpqEFDcDHeWX8+cscGL7+kvIgEdtfJBC0JlYRAy8=;
 b=1A/QG7O/S87gDkdQOyE8pi+mFax8iJIpAfaEzpMhL64IxlPwo4DBPUz6poKPk46x26t+0uMGtPCqgvEQHkelJw4W4j+3z/8TOxangFrngkHJxwzu22nZSfy/wELFG6hQ50PPbN+AkJWkICSgrAqfgWDfyC0qJQPbcRhc7ikhIMHbHJ6kQZ0g0IPOqjABng6A82k/JMNxic7SL4sNOLnS5704LeIn1Iuv/QiY9nwlnkt/3Rra651cOFlQlFVY0Cr8N/A3ccg2fqrtB3qcjyNZ7Pgb3XvP/H2um7Rdi57V2RTwbq9eu5gyCMZ3oQ/Z9B7vJRdpVN+yJr18rgRKQPs9Bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PR3PR04MB7404.eurprd04.prod.outlook.com (2603:10a6:102:8f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16; Mon, 6 Nov
 2023 08:18:23 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::8d82:166c:1cf2:95b6]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::8d82:166c:1cf2:95b6%3]) with mapi id 15.20.6977.013; Mon, 6 Nov 2023
 08:18:23 +0000
Message-ID: <1d08a205-b2c5-4276-b271-088facc142ea@suse.com>
Date: Mon, 6 Nov 2023 18:48:11 +1030
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>,
 Christian Brauner <brauner@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <ZUDxli5HTwDP6fqu@infradead.org>
 <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-schafsfell-denkzettel-08da41113e24@brauner>
 <ZUUDmu8fTB0hyCQR@infradead.org>
 <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
 <ZUibZgoQa9eNRsk4@infradead.org>
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
In-Reply-To: <ZUibZgoQa9eNRsk4@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEWP282CA0225.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1ec::9) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PR3PR04MB7404:EE_
X-MS-Office365-Filtering-Correlation-Id: 797e78a6-2d9e-4122-c584-08dbdea0f13f
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Bs/AfArMHmKHUsbryAv0LxBquo4XsaTfj6LY1URK1eculQCKwGZvFMNtclP7CqHbcO0Ji92eUGBWXJYLbzUkZAPJgvDVh7jqCoKQYo/lIRFRRPmniLL8hj/QLsf62Io1r3qztgdt6IuQxI7cCxzwip3YJl3lDA3/HM3bsOZB3hLHXpJ1avSTDiFLbOBa3oLNI/TZSDePyuilsM4qbqZ/DYfTTWm8tqs86UIc9jEuVYrEfwmnkTq4vsHAYz6qfUHegKPg7XXqSLUx9+8rlaJbwS0ZXWutTtkhBxJ9njtaScdMJnNBn5RtEG7hvi1tauSKAd2mH6vXn/0Syu+usTxGkmIoBP6Nsce/4kW9lL4KHI3GEmeMR7K5NNIpEYPDXVIi/NVbYB+NUxCQNpKyHP995aKZwAelkTx2c3mVjBhsQWQ5Lwdz+KHKnw/ckliCYzm5rBOjDY9qZ1gGMvzGT6TZHQ3NZo7Ad1Fvr8N0UxxHGBw8/09elWEoCI4cPtvEuga3yH8AzrNA9mXzqcF6WTKtaeapqD8xas/tQDUZHACTGC2DR6ZNcxlf5zDlDjWK4JgeDJA4wXU4tiXwkhbbqVWlLnhccP+zCu/Xyn1SjcRvavt8a88lmJLlrG1kbwdJpSYWNLYmElvylplbFlp2p3pnMNRmavDt7sM0rw+6FfmDfhSbL4Z+ysOnez4kAGMdG4UB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(230273577357003)(230922051799003)(230173577357003)(451199024)(186009)(64100799003)(1800799009)(6506007)(53546011)(6666004)(6486002)(478600001)(4326008)(8936002)(8676002)(6512007)(41300700001)(66556008)(54906003)(66476007)(66946007)(316002)(31686004)(5660300002)(110136005)(2616005)(26005)(2906002)(38100700002)(83380400001)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YURTV3VWaXJWMENRUG9ERURsTXBJcTRicEVkZGRKYTl2T0x6NlFyTi96Um10?=
 =?utf-8?B?dUxEWGZTdWE4ZDZuQmRVTnIwb0JKSG51Ly9qMzk3ZktleTBHR1NDS1RzUW9C?=
 =?utf-8?B?NmEzZlpWNjVEaXR1dnVqdHRGVm5zc3NaTmJrU2w0K3Q1Y3dJYUJCYk9zZ0hZ?=
 =?utf-8?B?cUJmSjd0L2h3cndCNVd4Vk8yYit6KysxV0ZhbTNlQkRtaWwwVmNhb0NnS0Ex?=
 =?utf-8?B?SldJQWpzaWg4aGtRYkp5WFpmczhWSlJibC9yejAyMzQ0VEorWWE2NFNwa3JQ?=
 =?utf-8?B?VGttVTk2aS83akozZGRMaE90MFFhbXNHNUFUMjN4Y3NWMG1xVTZuNGlLazRE?=
 =?utf-8?B?U21KdmdHYlJEWUtuSHRlaUNUeUhibnhtTTJTK0F0YjZVaWtmREtkNlNEeVlT?=
 =?utf-8?B?QldteDZjdTNhVTJveFpSZWJQOVVJNTBnQU52aTh2MWQ0REQzN3grMm9FeHRu?=
 =?utf-8?B?Y2R4dFdPVGZEdDVBeE9VUitGZ21rdm1Sd1RLWWZUQjE5bWsvZDY1SUt6UDNq?=
 =?utf-8?B?R0pXNjBpd1VvU3VEZlkvOTR4Q1hOT2VlOGJyLzV3T1BIOW1nRFlQQXcvbmdi?=
 =?utf-8?B?NExtdjZieitqRnpOdkhndmEzL2FGYXhtcy94NFVUSW5VTTVWU2c5ZEpqMWd3?=
 =?utf-8?B?VWRHclV6Nm9ua1h2czhMSXA3YVNEVWkxVzhVaFh6M3hXemgzd2dhSDRVd0x6?=
 =?utf-8?B?UkdhUVhrRDUzZWtuNVkxYVkrTWRoYndXTlR1SVFobTBFOUoxQndIZXBzVXZN?=
 =?utf-8?B?SHVPQXdDc1FhSitWT0dycGkyYzUvNm5LY0JCT2FYZUJZT00vQndHYndxd0wz?=
 =?utf-8?B?cG5jTDJkWGxwQnlna3hBZHVjdmVRTVpIU3h5OHVIbmNGZEtZcTVNUWRvK1kx?=
 =?utf-8?B?a3dYYzRyOHpXaHFjSzhLOERYY3VIaGN0U2h6V2Z5NkYyS3UxeHNzUGUyV2o1?=
 =?utf-8?B?Q3RLUlhhQVVrdWhMblk2d2FORVZCcXZiOVRvNFdiRVZoblVCKzBVZk9GUXBL?=
 =?utf-8?B?QlF4SVQwZmloUHNJT2pta29KZFEvUHNtdzhUNVpvSXJpRmg0QUk5eUx1L0pl?=
 =?utf-8?B?UHdIb21aSVJ3VlplZktwNGIzVmptR1J3eFg4aUtLUCsvelJrMytUMUVEaDc3?=
 =?utf-8?B?NnRqbTlhTlR5ajRianlpYVFqbVE1NndRb0o3QjdtY2gzbHFGc0p6Y2tTeGZO?=
 =?utf-8?B?QmJrdEdJdjRkdjJvY0xya0FQNzhzWkRVSHBRbVZLZi9lNHRyWWRCbStkUytX?=
 =?utf-8?B?QldUWEQxcUwrclNXOUZaTnZVRzVENWt3Q253cEVMSFphcElDNmE4WURwUm02?=
 =?utf-8?B?MTRyY09aRnVWZWZmVjM5ZTB1aU1wcGlhdThNc3pDMTRTb3RlRTNGZGxubkM4?=
 =?utf-8?B?YVR4QngvZnowd0l4RHNKL2VKdjI1QjdNc1ZzVG1ONnpvZGtXM3BaQThmRy9F?=
 =?utf-8?B?QXJmVUpzV2VVR040d0hlRDZ6ZWRRdUplOHo2WDNFd2ZuV2tDS2d3Z1BmY0dP?=
 =?utf-8?B?d0JqbE90QkxjRjltZWcwaFIyKzNwMVZnUEUraUo0VVJETDJHWHRvQzJRZHZZ?=
 =?utf-8?B?SnY0c2huTXJnRnFINVZMWGxnMU01bkx1R3RBQi9zWnNpUjAzMEtlbEpUWjA1?=
 =?utf-8?B?bTR3V216YzZyMVRSMy9mZitENmtvZ3F2MjFMZCtSemZOUDV5NnpUdXBocmVE?=
 =?utf-8?B?ekhtYkhidE9QZjFLeUNMNGFxcFBqYjBNeTdyQjB3K3dnZWJ2RmZjSVhaSlJw?=
 =?utf-8?B?M0ZHK28wRUhhOGVuVzlFNGdKWU1hb3htaGNSakxkcnh4VTVhSGVWWkNGNjZT?=
 =?utf-8?B?NGs4eDcvWndwS1lYMm9yK3UxSjY0eE5ETVc1aWFsYkh5elBaTDEzUlBtdFN0?=
 =?utf-8?B?NzR1dzhnWnVtaGx0YTRGUkhjMXVQRE15akpIZjNVV3Q2bFFQVmRZb3kvN0M0?=
 =?utf-8?B?S3BsUnRKemU5LzlxQklvWXNZWnZ6bDhWSWNBTDhJTHZvTGszN3JQdG9qUCti?=
 =?utf-8?B?RkwvQzFxSFRSQ01YTnptMThGSjh6d3hDdDQwWHRxZ2cxUjBoRVdXWFRzaXhi?=
 =?utf-8?B?djR6TDBha09tU1BqSXVKN2MrZkVhN2srdHJqbkpXZUZjVVFqalpYTnBUN0Vn?=
 =?utf-8?Q?iDjc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 797e78a6-2d9e-4122-c584-08dbdea0f13f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 08:18:23.1277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePbD6Sg6qIHf6EUoNgrrkEIcKHA44fmBmQ/aNjOedNIgsWIf7D9x/0w9OFaSn9vF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7404



On 2023/11/6 18:23, Christoph Hellwig wrote:
> On Fri, Nov 03, 2023 at 04:47:02PM +0100, Christian Brauner wrote:
>> I think the idea of using vfsmounts for this makes some sense if the
>> goal is to retroactively justify and accommodate the idea that a
>> subvolume is to be treated as equivalent to a separate device.
> 
> st_dev has only been very historically about treating something as
> a device.  For userspae the most important part is that it designates
> a separate domain for inode numbers.  And that's something that's simply
> broken in btrfs.

In fact, I'm not sure if the "treating something as a device" thing is 
even correct long before btrfs.

For example, for an EXT4 fs with external log device. Thankfully it's 
still more or less obvious we would use the device number of the main 
fs, not the log device, but we already had such examples.


Another thing is, the st_dev situation has to be kept, as there are too 
many legacy programs that relies on this to distinguish btrfs subvolume 
boundaries, this would never be changed unfortunately, even if we had 
some better solution (like the proposed extra subvolid through statx).

> 
>> I question that premise though. I think marking them with separate
>> device numbers is bringing us nothing but pain at this point and this
>> solution is basically bending the vfs to make that work somehow.
> 
> Well, the only other theoretical option would be to use a simple
> inode number space across subvolumes in btrfs, but I don't really
> see how that could be retrofitted in any sensible way.
> 
>> I would feel much more comfortable if the two filesystems that expose
>> these objects give us something like STATX_SUBVOLUME that userspace can
>> raise in the request mask of statx().
> 
> Except that this doesn't fix any existing code.

To me, the biggest btrfs specific problem is the number of btrfs 
subvolumes vs the very limited amount of anonymous device number pool.

As long as we don't expand the st_dev width, nor change the behavior of 
per-subvolume st_dev number, the only thing I can came up with is 
allowing manually "unmounting" a subvolume to reclaim the anonymous 
device number.

Which I believe the per-subvolume-vfsmount and the automount behavior 
for subvolume can help a lot.

> 
>> If userspace requests STATX_SUBVOLUME in the request mask, the two
>> filesystems raise STATX_SUBVOLUME in the statx result mask and then also
>> return the _real_ device number of the superblock and stop exposing that
>> made up device number.

Btrfs goes the anonymous device number pool because we don't have any 
better way to return a "real" device number.

There may be 1 or whatever number of devices, verse way more number of 
subvolumes.

Thus we go the "nature" idea to go anonymous device number pool, but as 
we can all see already, the pool is not large enough for subvolumes.

> 
> What is a "real" device number?

I'm more interested in if we can allocate st_dev from other pools.

IIRC logical volumes (LV from LVM) are not allocating from anonymous dev 
number pool, thus this may sound a stupid question, but what's 
preventing us from using the device number pool of LVM?
Device number conflicts or something else?

Thanks,
Qu

