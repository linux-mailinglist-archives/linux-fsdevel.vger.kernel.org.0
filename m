Return-Path: <linux-fsdevel+bounces-4077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3707FC583
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 21:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA9B1C20F4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 20:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7843D0CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 20:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q00ZnhzX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2069.outbound.protection.outlook.com [40.107.6.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC7B19AA;
	Tue, 28 Nov 2023 12:06:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHlc/POtUJK0uV+ZsLbAhKcPGHDSbJF7Cuvu2PgEEAxTMYJBe8ghkB2MT8Cmv2ilu1BZW9kJ50OS28x74NBxn1pJ3yfF0/uYPZhJ3yRFd8g41vj8DgalHL7XVGWL3wQJjnau+gMsrwK0dJnR+2v0owVjIkQclJtbchwYZ1Eas66gt041+WEfSGzYvkzS/lvThu8XIncF8OfQpie+FFBlZHTeKs8NQImoEcRTFw81es5SJqqfYA1LnZ2xTWsLz/L0D8X+e+cWf+7qnsMLn/nzAnTs1lziFGM3bjMH07l6FRbRWn+aHbfWyJ4mFBf1VPU/Hx/ohY81qD3adYayD/6Chg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9b7hcgutk1X8OO3EzaW6VAVNzexXu9C4wYEZVSV5wE=;
 b=SBQM/ZCNP6zWvfSjMLIIDjE61nVvBJ+crNwGJfuT63RQIPPxqehKMQuFtVrSI/Qd9hMlX3NXbqGCkzRiCUJR3/JteLgSaceFe3LO1xIYgf0ALP+QviyF79XYwJDEHYba5bPoXvkXTlfdc4MCw0IODYrR954CxzZfDBZfU17M2BC8ShjmyKfdSIe6QCZRCODARMhFa17lcOLc0eyvrwd54dNb/va7+R8EqbgnTEwCIt3CjFi94xU8gtPlsNbBgnbpxqlTIiVkfk54uSodPAYcJQbi9/s8Fa0QYMaSPJEkRVt17R/DEqGyzdKnHqVGtnPtPp5lhZaWqzkzxNIExhwJDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9b7hcgutk1X8OO3EzaW6VAVNzexXu9C4wYEZVSV5wE=;
 b=Q00ZnhzXCcJaqbEUc84YSBl37DaIejSt6pvgAC12oqnEQSSDYmRPBfOBxFFfZMck/vBZzkyEnUqxRPMvMm3qr4G3rEvSPpQ+8nVGbGz9AwEtuz0xazHmk4LHM0gOtZx8UmeJ1/7+VOe0mN1/NVkP9khJ/jNkvTOMxakLHyKYVVxbYIw4c6RFdkQZAUyNPUwQ2yNRFaZFtlcqTddrL7C6sFkq2y0ylfXkeN6KVQx1OAbUiGNUovMxzC1lbzsiOQQOfHQlDy4+O0CSkgOO9S7KNvX/ZsXWXjFCuChO+idCEK9B2bXZBrK/kzZNuSr6FNGT+2Tc8oeYszkkcMS0F3enFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by GV1PR04MB9200.eurprd04.prod.outlook.com (2603:10a6:150:2b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 20:06:54 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::62e8:6e:83e1:145b]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::62e8:6e:83e1:145b%6]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 20:06:54 +0000
Message-ID: <546fab58-974e-462c-ab20-5e31acb7285b@suse.com>
Date: Wed, 29 Nov 2023 06:36:45 +1030
User-Agent: Mozilla Thunderbird
Subject: Re: Should we still go __GFP_NOFAIL? (Was Re: [PATCH] btrfs: refactor
 alloc_extent_buffer() to allocate-then-attach method)
Content-Language: en-US
To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <ffeb6b667a9ff0cf161f7dcd82899114782c0834.1700609426.git.wqu@suse.com>
 <20231122143815.GD11264@twin.jikos.cz>
 <71d723c9-8f36-4fd1-bea7-7d962da465e2@gmx.com>
 <793cd840-49cb-4458-9137-30f899100870@gmx.com>
 <20231128162636.GK18929@twin.jikos.cz>
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
In-Reply-To: <20231128162636.GK18929@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ME3P282CA0046.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:5::15) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|GV1PR04MB9200:EE_
X-MS-Office365-Filtering-Correlation-Id: 510784ec-39df-467e-85c7-08dbf04d9117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9QNj5S00eKRCwHl792GsQmwZiKkVM11yfDj5u4IuD2cbBgvJ+ftFAeIGcGEkwE0J93aBfJOA7Cbk3bTBN0fnlEWWe82GsvLAggvwWf2+Cj3uhrzJcLLCG1ItzzYptB3qwxici4yD9aAQ4jITblbXxhVuf3p1U6EwZ2uCFBR+07hWKZQv+WDB+V+zp9VK/lURTU5Gez6I1XL/YHJYkiag1mFhlwPQ/Qh7AAHPwgtIpreKQ+8AZsyRdELtSMQ0TcivXUWtL8quGH7jcQf/fhmzcuDWCHsTtW8gnz3KHPZ5KPA01aTofvRyDyAcZP7oVfNNr29dV9NcyWAegQXEZSAo3mten5eS6bAfxY+knjuuUcTsZ8B8GU8xpPGMkO6o0oWFmA52SpjUWH/lfYJAEonPshF4WVafLpdnR1AqgQuXMwLs5T1X4YQAngoetmXDmaKeYMi5DXVfFwDVX/yeMdXU+ypROB4EHFuN5MLyr5WuD1BsQ5FAuJjzAQ7tYvu0bWk1FZeeeocOeXFmWuk0Uykjx0dO70ren9MhIw0DD1jBl/7d4QeK87vHzMw1CIqpaxRYo0KMN1/G5q5L/KtjMY94DU73df6yGIwR5b9q3lAAmpMG9+TpSqMRlk7ml1DbzmbDbd9qDhOHevS1eAaM7gqSyw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(39860400002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2616005)(6666004)(26005)(6512007)(83380400001)(53546011)(6506007)(2906002)(66946007)(5660300002)(41300700001)(66476007)(478600001)(966005)(6486002)(6916009)(4326008)(8676002)(8936002)(66556008)(316002)(31696002)(36756003)(86362001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVRwT2JtcXZ1RXk0eDVIL1NHTktpTW1JY1p0WXozYk12ZE1jNE5CMXZpemh0?=
 =?utf-8?B?c0tGM0E4WDgwRys3VEJOb041M3hnclZVdngxVFVHNm82S1pYYVFXaVdSMzNO?=
 =?utf-8?B?UlFqKzRxTUtPODFpUnhZWW5SS1Jna2dpMFpmQXBzcUJCaVhJRlVaN0hleUhM?=
 =?utf-8?B?UFBvQm90ZEJTQ3JjaGU4blB4LzZtWmptVWFJaTJ3am51R3lRUFhXRElOZFZS?=
 =?utf-8?B?K2xnbnAxZFprV293NFE4M2c5Y2p4bkFlcG1EZVh4ZmQxOVpTUXpoRHFHS0E5?=
 =?utf-8?B?TCt0N0dpT1VmUWxSNG55ZVB5Z1lLb1pvZU1nN2ltMzFXemJXTk1DelliYUhP?=
 =?utf-8?B?bzZuOWViTjQ2czhnZlFZSG93b0RjUFd6QUVKUzJCQThTMUo5b2liQ2RocUl3?=
 =?utf-8?B?ZnAzWjE1T3h2Yi9qT0lMQjNrWStlVk1taDh4VkNxY0tYUnJwNHFuYUY5V0Nw?=
 =?utf-8?B?Q0pRaTl2VnYwZ3Y1NlRFaVdxVVJzOVBRUitXZThlcGlpNThrbzRYZ3AxUkVu?=
 =?utf-8?B?bVJPbi9KZzhZRXdaUUVUUksyb0k2b01wbHpRczlnbDV5TVArVS9WczlIVXoz?=
 =?utf-8?B?eUM0RnRYLzE2K3VsWHcrL1NhWW95S0JDQ1o5MDBDQm9FWm1sT2Nla3NrQ0VR?=
 =?utf-8?B?SEhqbW1IdUJuTmdLd0FMZHB2RWJtZFZaVXZBSzY3V2xmblJBaUZId0RNWVZ3?=
 =?utf-8?B?cXk0cUdROXA4Z1NzUDFEN3FFQzRqZ1BYVnYrMG5lVktHWkhlNUJWczdtaGJT?=
 =?utf-8?B?RzhHUWNSNjgzUGY1dVJONlBvQ2lLMVhadE1CSEh0M2NWS3FxZlZvSjBCZi84?=
 =?utf-8?B?RHM3S2x6cTdxcXpNbWVvNVVBYSttbnpHTm5nMitzZDZFLzl2cDhDbFJWbGRJ?=
 =?utf-8?B?Tm94V2R0Rk1BR0d1YmpMa29rRUdBaG01RWQ5eGN6OWRyZDExdGVxT3d0TUJZ?=
 =?utf-8?B?cVhNNmhTSTRJb3hMTUJYcExieURNMlEwY2NWR3RWTWtCWEl1TFNqd01VUTR0?=
 =?utf-8?B?RG84a3E0eFQweE52NDh6azRWY0xvK3lUYnZkNi9RTjZWTkFZUjdzLzJYbzE1?=
 =?utf-8?B?clc4djdPdVNEWVVoVWdGOHl4ZHdFSXhaeUtLRXlxZm51eDJ3NWZNN1BTYnhU?=
 =?utf-8?B?elJ2K2hMM1lpS21MQjdpb3FEbEtrd2h2TWdIM3doS3d4Nk4yYWdIckJuNGkz?=
 =?utf-8?B?ZGUyT2YycUExSWxKaWZoeU9FYVErUjhMZGlPTUpmdFZiOWY5M1d5dlZUckxu?=
 =?utf-8?B?bU9CUWV0dTY3R25IejIxUTJ4QzFNZTlIQ3ZHN0tkKzc0ZjJJdm9ZTXJJWFJY?=
 =?utf-8?B?VlBBY3d4dTdTeHBWbXYrK3NhY0daS1VTMXYrdXRjd3JoMnB6QzVIL1RIbUF4?=
 =?utf-8?B?TDJKWjZNWnAyU2p4V3FibWtrdm5aSEpRc3g2VGJHblJkbk9CaE5ZcGh2QlUy?=
 =?utf-8?B?YWI4VUV0ZE91YVdzZFRBMkkvYkFXcXdIYVBOVzdvdWhWdGwyb3ZWOTBTcmJp?=
 =?utf-8?B?VXpKb003TWo2b294bTRyMnVINHFRMCtIK0RYN3VzOFl2YTRMcHpaWGNZcnBC?=
 =?utf-8?B?a0t3RjFMMjBUOHp3N1RYdHlhOUJRdDdodEJMdjN1NFJCWXNGVlZDUHdIbHZM?=
 =?utf-8?B?Q04yTm9WZUVCUVFPZE9GU3pCUTR5TmNQU0pHL3FNd3Byd2U5VXhXL1U0cFhk?=
 =?utf-8?B?Yy80dktpL25RNUx3U0toeXRzQWlEajQ2RmYzbWZaVG1abUpKYjRuTHAwQTRL?=
 =?utf-8?B?cUtmaWtUcXFYMk4zY2dGK1NSSEF6ejBHOUhiVkw0T2VwRzFZSHRtSjEyaDlr?=
 =?utf-8?B?am9nMHZkSGx6ZUtZMUpNV29mRWpiRnlFUys1VDk2NSs1Q2FCUTVYb3pyc3Jy?=
 =?utf-8?B?eUFJZDRQdGxGK2NhVTl6NkYzRzNKcERxV2FaREN3MVgvOWMrc3lHZHoxWU9J?=
 =?utf-8?B?TWtmUDNWOUMwY1hPVFl2OWFFL3BzVEZ2bXM2VGtIeUROMXBmazZrbTRQY1pz?=
 =?utf-8?B?MmMzYndwN0tkU3B2RHVINENSNkNqNkx1dTVoUGlSbG9yeHBNL1cxcWZJaXZ0?=
 =?utf-8?B?aHdoTWZwM3N1TDgxdTRYUlRYVmJoc2M1ek13V2xLekFWdzhOM3JuMVJyRXo4?=
 =?utf-8?Q?7dQ4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510784ec-39df-467e-85c7-08dbf04d9117
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 20:06:54.3741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gkncMoc8BzEnmRsT5RTtWtRYvfqaihgBNeSXB4rPmDg8eSSl+N8fh1rZPR1APqI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9200



On 2023/11/29 02:56, David Sterba wrote:
> On Mon, Nov 27, 2023 at 03:40:41PM +1030, Qu Wenruo wrote:
>> On 2023/11/23 06:33, Qu Wenruo wrote:
>> [...]
>>>> I wonder if we still can keep the __GFP_NOFAIL for the fallback
>>>> allocation, it's there right now and seems to work on sysmtems under
>>>> stress and does not cause random failures due to ENOMEM.
>>>>
>>> Oh, I forgot the __NOFAIL gfp flags, that's not hard to fix, just
>>> re-introduce the gfp flags to btrfs_alloc_page_array().
>>
>> BTW, I think it's a good time to start a new discussion on whether we
>> should go __GFP_NOFAIL.
>> (Although I have updated the patch to keep the GFP_NOFAIL behavior)
>>
>> I totally understand that we need some memory for tree block during
>> transaction commitment and other critical sections.
>>
>> And it's not that uncommon to see __GFP_NOFAIL usage in other mainstream
>> filesystems.
> 
> The use of NOFAIL is either carefuly evaluated or it's there for
> historical reasons. The comment for the flag says that,
> https://elixir.bootlin.com/linux/latest/source/include/linux/gfp_types.h#L198
> and I know MM people see the flag as problematic and that it should not
> be used if possible.
> 
>> But my concern is, we also have a lot of memory allocation which can
>> lead to a lot of problems either, like btrfs_csum_one_bio() or even
>> join_transaction().
> 
> While I agree that there are many places that can fail due to memory
> allocations, the extent buffer requires whole 4 pages, other structures
> could be taken from the generic slabs or our named caches. The latter
> has lower chance to fail.
> 
>> I doubt if btrfs (or any other filesystems) would be to blamed if we're
>> really running out of memory.
> 
> Well, people blame btrfs for everything.
> 
>> Should the memory hungry user space programs to be firstly killed far
>> before we failed to allocate memory?
> 
> That's up to the allocator and I think it does a good job of providing
> the memory to kernel rather than to user space programs.
> 
> We do the critical allocations as GFP_NOFS which so far provides the "do
> not fail" guarantees. It's a long going discussion,
> https://lwn.net/Articles/653573/ (2015). We can let many allocations
> fail with a fallback, but still a lot of them would lead to transaction
> abort. And as Josef said, there are some that can't fail because they're
> too deep or there's no clear exit path.

Yep, for those call sites (aka, extent io tree) we still need NOFAIL 
until we added error handling for all the call sites.

> 
>> Furthermore, at least for btrfs, I don't think we would hit a situation
>> where memory allocation failure for metadata would lead to any data
>> corruption.
>> The worst case is we hit transaction abort, and the fs flips RO.
> 
> Yeah, corruption can't happen as long as we have all the error handling
> in place and the transaction abort as the ultimate fallback.
> 
>> Thus I'm wondering if we really need __NOFAIL for btrfs?
> 
> It's hard to say if or when the NOFAIL semantics actually apply. Let's
> say there are applications doing metadata operations, the system is
> under load, memory is freed slowly by writing data etc. Application that
> waits inside the eb allocation will continue eventually. Without the
> NOFAIL it would exit early.
> 
> As a middle ground, we may want something like "try hard" that would not
> fail too soon but it could eventually. That's __GFP_RETRY_MAYFAIL .

This sounds good. Although I'd say the MM is already doing a too good 
job, thus I'm not sure if we even need the extra retry.

> 
> Right now there are several changes around the extent buffers, I'd like
> do the conversion first and then replace/drop the NOFAIL flag so we
> don't mix too many changes in one release. The extent buffers are
> critical so one step a time, with lots of testing.

This sounds very reasonable.

Thanks,
Qu

