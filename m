Return-Path: <linux-fsdevel+bounces-78958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG7PFjXtpWlLHwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 21:04:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEFB1DF19C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 21:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B94C300B8F6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 20:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA9E330B0B;
	Mon,  2 Mar 2026 20:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="W4XUPszU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D8747DD48
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 20:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481836; cv=fail; b=aYruyTMdBU36ANe3y9RRyo6rVHH1mq+L+T/xpSaVbuRPpwgfOAa118EcZQBxtLTQU/VuiDDrtXbrPepyVfJBi1KoR7qdb0cu3AT6eM4jo85T90R94Qdw1uKrBPbzR82PtTnOZhSfv34yIySMe6l0/pZkHJ0gWThvXm9W/CrIwQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481836; c=relaxed/simple;
	bh=RK6GR99qE6cAIpAKeACzR4JblO8cGnMAfMVEL6xHOIA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XZpVchTAGAGpE/UaHaz7XgkmotRTWiN1ziHvT8g2kNA+qCZCvr3edI48rjl4fMNUjJpQSu3CH5ehu6oIgzcIYD5aBHf3LLG3NEg58UcRiKzZ+wEmU/P6Frt9jyZZr08CRviteD0J1QGW5NM2ySck81YMjXcb9PfvaTwCXDIf2+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=W4XUPszU; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022109.outbound.protection.outlook.com [40.93.195.109]) by mx-outbound20-5.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 02 Mar 2026 20:03:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/8msG2YWv3Ugzk8iyW21dFn5hqteoNiJOfKkqqt93QfIYcPLZtanexdEuXbHrCnnyUXMiY9vXqu3Dr3328ptB+YruUexOWkaFsRHx+zSvQP1TY7yTipV9EGZlRZaJq4QFaBugLluXAFrcRoukcL88ZPoyqBhnaH3rdiRxe9HtOiuvCC78LtaNU03W6HNODA3y8fb+X+dKzxjB2g746ywb7ZovjQP9PwiHR1oXmaNaQHzebNIoRcfTWWD3ISYUMNuD3qcAjxWHMXnzRhQayiG6jIORWKoezkFPImeiVGZItUnSOBwWYA8MzTh2q7LyNtjAPBywhyoHKHE3MxqLxjAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPVipiWHECGSYzip1pVk/oGOdojdclToFBJzOFgZC6k=;
 b=u4boHLgxd+fmIsT4MAHKplYuqlKPuPVBWiRpUjtDkVuv9v5JgV1CPCuKlNKlUffDSWeKcEd81G76IA1QGDbEnOcX+aXhh3QI1A3w73fhULQmN22M+SjKFwS3Gt33iM0oQKIDDV8aRl7gVZYuFAChHxOvwh5tzPk6mFDoZ2DdrJmxEnXpH2Gsv6A6rcgMpdA3oENYkgYc/tUIFRcCY2mivNRiQxZwPzhfkOiaLkHce0DrOd5RwYqwM2q0D7ID6ebFf6cF6JceiOEk79bdX+4XP0Nw3BsLmp34QKBPu/ebJaX6BSeHEe6Isf/1ICDI5YE4xfEDgIQBJlLlmO71ehxf7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPVipiWHECGSYzip1pVk/oGOdojdclToFBJzOFgZC6k=;
 b=W4XUPszUoEAUBYflw2EXkXy1rdSgXVGKExBapFHNYhvjoE+ReeiZz6eZoE+d8xqrCKcLCylUz+9P9c7Jtz9Kj5JLzt4SeEJCmDpoKCmvdU/o4CbdOAMssQlmzcCUsTcf/VmUmfyXPWT6Oio6PAmPJNkxZmu6RhCPxzz10hG9/qw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by DM6PR19MB4310.namprd19.prod.outlook.com (2603:10b6:5:294::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 20:03:32 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704%6]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 20:03:30 +0000
Message-ID: <62edc506-2b0c-4470-8bdd-ee2d7fcc1cf1@ddn.com>
Date: Mon, 2 Mar 2026 21:03:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] fuse: add an implementation of open+getattr
To: Joanne Koong <joannelkoong@gmail.com>,
 Horst Birthelmer <horst@birthelmer.de>
Cc: Horst Birthelmer <horst@birthelmer.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Luis Henriques <luis@igalia.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Horst Birthelmer <hbirthelmer@ddn.com>
References: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com>
 <20260226-fuse-compounds-upstream-v6-3-8585c5fcd2fc@ddn.com>
 <CAJnrk1ZsvtZh9vZoN=ca_wrs5enTfAQeNBYppOzZH=c+ARaP3Q@mail.gmail.com>
 <aaFJEeeeDrdqSEX9@fedora.fritz.box>
 <CAJnrk1ZiKyi4jVN=mP2N-27nmcf929jsN7u6LhzdYePiEzJWaA@mail.gmail.com>
 <CAJnrk1ZQN6vGog2p_CsOh=C=O_jg6qHgXA0s4dKsgNbZycN2Cg@mail.gmail.com>
 <aaKiWhdfLqF0qI3w@fedora.fritz.box>
 <CAJnrk1bHSRxiKNefNH_SUq1E93Ysnyk-POjh5GWxy+=8BewKtA@mail.gmail.com>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1bHSRxiKNefNH_SUq1E93Ysnyk-POjh5GWxy+=8BewKtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0126.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36e::12) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|DM6PR19MB4310:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f7b63ba-b132-4f6d-2d63-08de7896c681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|10070799003|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	kitcOZyVN6wXwytk95ns1HrfYq0Sp3oRB6HScqfgu+JMCnmRb4vW4YYw3POS3Fyp0mkK7l8kEBdsU01wTiOTHCNl3gZNg2zGLtUv/W9ZxJGL+JtVYGpM3A5ma+vSSI7aqaAzMJpFgU6Jqhpd9kEdthnGAqj+Jn/HoL+he4BX86xyLxYN+6wRyZg7SkSdO90vXre8GEv+5cqXxocFtqLWvLWLCFrPdA1oSVoyN3bOdFvCIwpaICIUgSJXiVBfpL6JrehEe/wNO9bRunmQNZ9XUPVdX6C7r0OTixp45HfIaRHj7s4uiB0MVxkDDwScuybMSyOIuRBAIs2oeXVGyC5TltVayHwGpBn+nhn+k97eoGIr645tvnoPozDvjB4F/OP6lEgD8PrueVKyoNVzvXTuQs3w56KAZdA+mNdvXlTZbNR3fSH83D7N9nzoaGdfNzJNEGUoMbLRXgm86NQHw1nCd0w9hE165bpw3LeOnxxP8qIs8Aqo78CujWqwNG0lwD2mdJUoN96XLgMXIiKOGqZfxLdisg/PytRi1S3k+/6+jcc5wOrwaWoSPl/HpL0q9BBNtwNtJ2YunMOx9PbFJKoLXTiHikHBBKGztzg/EEVzlpJ688Nuwgmlw3/P3we9seHPXsXL7IrIp14Xg36oqjw8m+TqBxo+6lJF6ssemcATYjMTZwDlqvKqgojkTYEr9H54m+4Tr5mjO4wL8rHeRMfJ4jn7o5V654hhkqSECO8hFu4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(10070799003)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFR3b05CWmd2RVIwWEMwRmRMVW14NHp0SGYvdnR2ZEp5N0pJT0dzM0l1d3E5?=
 =?utf-8?B?bnBGakVEMXpSUDBtZDJ6UGk5aXcrQ0hHM0R2N2MzRml5UlBNeUJaQzZJWXlt?=
 =?utf-8?B?WkVSR3pJVmwvOFNsSk05cFlkQVZpaWNMc0dkUkhGV2tUNTY5V0NvNS93UURW?=
 =?utf-8?B?QUZISkcvbjV2MHRJWGcvN2NyQ0JqM01oMDBncGFGZWkya084bUR2c2FmS3hT?=
 =?utf-8?B?N1VvODE4Um5zWk1lRkpRRFhPSmN2RWMzVnFwRjE3TUdMc3NITWs2NEhpQjZY?=
 =?utf-8?B?QWk5NnQwd1FMUXFsL1U1U2dtaUtRRm9ONk9zcEwrZDEvWm44Z09SeHV1TWpn?=
 =?utf-8?B?eU1xeWsya0IrOUNXVkVTT2lhd3E3ZnhOdTZiQmpVODlGaElJQjRkUmh2bGRk?=
 =?utf-8?B?NjVLY0YyK3daeTNiMmtwVnVIelArTDlQMTN3UzEvYkJiMTBzdWZKbEl1MEt3?=
 =?utf-8?B?MWp5RmJZMU5pUWxlRU9vek9uNGprelBHZWhMVmg2SGdmVlc4eG5MazdvNzZR?=
 =?utf-8?B?ZlVNY0dKR1NEYUkzMGpyejgzdTlqV0tNRFdLckQ0STNhTmR3cjVsaHBVKzk0?=
 =?utf-8?B?Qk52Z3RKbTRkNnl4TzJNT1RQc3JZZDNhN3ZCUDJ6aElGWU00YmJuWU1Nd0Rh?=
 =?utf-8?B?bWhiVUpCQStGZC95Uk9IdWQ0anlOSVZJenJCbTB6KzR0eW9xUTc2cWgzdVI4?=
 =?utf-8?B?aXQrUEZ0YjltZGJmd2hWYlRHb0JNeThQM1ZZTTNzRTlDRlk5UGhrWjhRbTFI?=
 =?utf-8?B?NkpDZlEzS0dJd2FCMUZ1Skp0WjM3RnZXend5WU1MK05KaXJoSXFxUnluM3FX?=
 =?utf-8?B?R21qVmthYlBNcmdweVNRMllaVCtHU0FMYjVNbmJWRExxQ2ZpeXBzV1hsQ1JS?=
 =?utf-8?B?b1l5RXRQUDBNYzJPMEp3VGlJT0RvOEU0bVViU2tjUjVxVzZWa0sxcDdEM01u?=
 =?utf-8?B?dnI3NFI3USsxOVYxRGpaM1N2SVBwVXkzdkp1ZDM3eFEzSHdCSlZxOVdKZDdB?=
 =?utf-8?B?R2RxK1dUdXNSSTJNZTFkMzFLQWdQTE01SUxrbW9MOVRvVStBdEdxN1VjWGY0?=
 =?utf-8?B?RFV5QUppVE11NHNjSW5TS2RkanVreXVsWmNoUzNrcXQwWGNyNkVnczdhZmps?=
 =?utf-8?B?YkU5NXlrU0E2Z2VINExreHJSViswb3RYcXVlT3JqSjhCRDgzN3FncnBoSCtk?=
 =?utf-8?B?K1NjR2ZKb1JZRWwyWDNjNGJUZHJjMy9xa2EzUEhzUUFuUUJ3elR1SnZwb0Q3?=
 =?utf-8?B?UkM4L1pWdFVhU2JPZlM5ekIwWXBEUzd6L09KMlVZWnEwZExvWS9ieWJMZTBX?=
 =?utf-8?B?a0I5d2d6V1VlQjN2QVZiN2hYRXhpdUVqZXBzL1d5SzlBb3hhZnlIdGh3ekc4?=
 =?utf-8?B?Zml5eUN6MUVMZWFHUU10bndkV0tJT1FvVjBjYmlFWjFDOVFZeExnVnh6eG5I?=
 =?utf-8?B?bUw2VXFIaVpQVUhBNTNSdDhjSStBWWRkZGl3ZlkxbXhwSmt6ekxTSjd0Sk53?=
 =?utf-8?B?MFpDRGgzd3ZNbDIwVkZRTkpWREJMbGJ1UUx5RkdtYmg0THU2d3FVbnBIeDBE?=
 =?utf-8?B?NDlrYXVZRURYS0NBTGZ1S0FhdTBnM2NTYjc1WFR6TkZPbldYQkhOWnJ1RFIy?=
 =?utf-8?B?ZUordFJITzNiakJNT012MTNTNURuSUoyR1pRT2hWTjY4NmdqSXBFWjBLRktB?=
 =?utf-8?B?blUrdzBmalg5Y2NHeGhqbU1Ebi9zOXlEZ2lOVzhaeUxPaDRHcUVweFgxRUJz?=
 =?utf-8?B?YVNGdlorc0VIUlJKRENCSjJRK2tycTZDU0V2NGdudExKVEJtRXplZWRPR0VZ?=
 =?utf-8?B?ZnJpOG5SSGM2enNKL0srY2pLYU8xc0RuK05URGVieTIrNXNUcFBHM2FaVS9h?=
 =?utf-8?B?dWVhQnN2NjFNdVlnNTNIN0FCejhxOE5PeUhmMm1HTmpXNEx2eGhUNlkrcDQw?=
 =?utf-8?B?UDU3M0hwaUFmRno1c1BzVmduMS9xRzE1TGRTbSsxTWU1N3lZSVIwbWlBdlBS?=
 =?utf-8?B?Y3BDL1d0Qzh1Z0dSc3hnQ2pQV05uVGNnL2RmcU9GV0picFVrbk5LQ0VxbG82?=
 =?utf-8?B?MlBROW1hQVl5MGxPcVBMOVhOanVyZzBWZTBxaG1UeWJjTjZtK0hmT09xdVUx?=
 =?utf-8?B?QjRaOHFLQlZzSk1GK1pxTkx2R0dJMDRibFhFeFpJcW96S25EUUZGVSt3T1c3?=
 =?utf-8?B?b2NSMnhBc1NaZWVYcS9UZDJ3SVlxWjlOY3l3VXVsY2JQZmc3anlCMXlGQmM4?=
 =?utf-8?B?UzErNTVuUmlSRzBmVGF2OCs0R3RNNUt6SHBnL2FFRVU4TkhVVkh6OGpva2sx?=
 =?utf-8?B?dXUrby9XVjVQTUJBQzB3Tk9ZZDBha2Q1NUxMQXF5dGptVzA0a2JNbUxYM1Nu?=
 =?utf-8?Q?rUNJ4s9oe16AMsPTYdAgKvDmoNGPa7afcLu1486zz94Lw?=
X-MS-Exchange-AntiSpam-MessageData-1: y+gXVkT1dwf35g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ou4k5WEyP2RsqoI9YAJfXEUMf8DqPMZ96s8LOJKGEDqbuxIyhsNMB0x/IGaPmnnqQTCh3iL+/wRnPVrmhu1QbuXjhJ2zE5HFZHxb+wTC+YQjmrEE/P5Usgvryb0OKrTGiOFchtUfrQSuHsyZ/tK6IpYrj8yz7ZgTpDJq46EXiYU2lyJWM88c/Uyl1/tsgS6ila/1zQXTyxMejDhtYLpHzqNJaKB2EnRgBATl8gJHUnIhjtlUajmQVmxFPH21FENbsFGF7YyJCxcSa5B41tKsR/judn2JEmYT3PM71x06LGiFnygyd/chpOekwPVI1Ezg+Seg8fjn+AWoN/3azmzsxAhyswkbS9IEFaO6ALuf7H2Wt/XD3ti0lOUdibjDHk07opKOXYpJQuTHAzZx9L0tvehL6aC6inAjLKven6H258ED+EIrtm31LsVKBeo5X5LGZ9ej6OgD9jU70SRJAzAxkIvjtYjbgotwKj7Fa7SvwXZZWyoNKxaezPTBLVwAo479vgamcf3MxcBCAX8AAKO9MSYk1+Gr7W54ts1e0C4BGdSTPzy0XXgUu71Z2fkjUsPh1fNiuUgl/XTcUt9T1jUqlpRHgXj7DVIfa9CvW/ZVboxcQNtvYvG/WJwEwyyxWZCL8RrQ9lz1c6um9QWwPjz3HQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7b63ba-b132-4f6d-2d63-08de7896c681
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 20:03:30.5506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tboWaOe7E178kSe3njn3f/JX4zu7urbXdqfYOjc8W5ZSWZHgeH6IBjLamWQpnwxI9IJp7NuVWX+AWpgGuDv/CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4310
X-BESS-ID: 1772481815-105125-7700-1364-1
X-BESS-VER: 2019.1_20260224.2149
X-BESS-Apparent-Source-IP: 40.93.195.109
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsaWRhZAVgZQ0NQ41dIsOS3FwN
	jCJNEg2STFNNnE3NLU0jg11cjIIClNqTYWALvXHZZBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.271522 [from 
	cloudscan9-154.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1
X-Rspamd-Queue-Id: 5FEFB1DF19C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ddn.com,reject];
	R_DKIM_ALLOW(-0.20)[ddn.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78958-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,birthelmer.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ddn.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bschubert@ddn.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ddn.com:dkim,ddn.com:email,ddn.com:mid,birthelmer.de:email]
X-Rspamd-Action: no action



On 3/2/26 19:56, Joanne Koong wrote:
> On Sat, Feb 28, 2026 at 12:14 AM Horst Birthelmer <horst@birthelmer.de> wrote:
>>
>> On Fri, Feb 27, 2026 at 10:07:20AM -0800, Joanne Koong wrote:
>>> On Fri, Feb 27, 2026 at 9:51 AM Joanne Koong <joannelkoong@gmail.com> wrote:
>>>>
>>>> On Thu, Feb 26, 2026 at 11:48 PM Horst Birthelmer <horst@birthelmer.de> wrote:
>>>>>
>>>>> On Thu, Feb 26, 2026 at 11:12:00AM -0800, Joanne Koong wrote:
>>>>>> On Thu, Feb 26, 2026 at 8:43 AM Horst Birthelmer <horst@birthelmer.com> wrote:
>>>>>>>
>>>>>>> From: Horst Birthelmer <hbirthelmer@ddn.com>
>>>>>>>
>>>>>>> The discussion about compound commands in fuse was
>>>>>>> started over an argument to add a new operation that
>>>>>>> will open a file and return its attributes in the same operation.
>>>>>>>
>>>>>>> Here is a demonstration of that use case with compound commands.
>>>>>>>
>>>>>>> Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
>>>>>>> ---
>>>>>>>  fs/fuse/file.c   | 111 +++++++++++++++++++++++++++++++++++++++++++++++--------
>>>>>>>  fs/fuse/fuse_i.h |   4 +-
>>>>>>>  fs/fuse/ioctl.c  |   2 +-
>>>>>>>  3 files changed, 99 insertions(+), 18 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>>>>>>> index a408a9668abbb361e2c1e386ebab9dfcb0a7a573..daa95a640c311fc393241bdf727e00a2bc714f35 100644
>>>>>>> --- a/fs/fuse/file.c
>>>>>>> +++ b/fs/fuse/file.c
>>>>>>>  struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
>>>>>>> -                                unsigned int open_flags, bool isdir)
>>>>>>> +                               struct inode *inode,
>>>>>>
>>>>>> As I understand it, now every open() is a opengetattr() (except for
>>>>>> the ioctl path) but is this the desired behavior? for example if there
>>>>>> was a previous FUSE_LOOKUP that was just done, doesn't this mean
>>>>>> there's no getattr that's needed since the lookup refreshed the attrs?
>>>>>> or if the server has reasonable entry_valid and attr_valid timeouts,
>>>>>> multiple opens() of the same file would only need to send FUSE_OPEN
>>>>>> and not the FUSE_GETATTR, no?
>>>>>
>>>>> So your concern is, that we send too many requests?
>>>>> If the fuse server implwments the compound that is not the case.
>>>>>
>>>>
>>>> My concern is that we're adding unnecessary overhead for every open
>>>> when in most cases, the attributes are already uptodate. I don't think
>>>> we can assume that the server always has attributes locally cached, so
>>>> imo the extra getattr is nontrivial (eg might require having to
>>>> stat()).
>>>
>>> Looking at where the attribute valid time gets set... it looks like
>>> this gets stored in fi->i_time (as per
>>> fuse_change_attributes_common()), so maybe it's better to only send
>>> the compound open+getattr if time_before64(fi->i_time,
>>> get_jiffies_64()) is true, otherwise only the open is needed. This
>>> doesn't solve the O_APPEND data corruption bug seen in [1] but imo
>>> this would be a more preferable way of doing it.
>>>
>> Don't take this as an objection. I'm looking for arguments, since my defense
>> was always the line I used above (if the fuse server implements the compound,
>> it's one call).
> 
> The overhead for the server to fetch the attributes may be nontrivial
> (eg may require stat()). I really don't think we can assume the data
> is locally cached somewhere. Why always compound the getattr to the
> open instead of only compounding the getattr when the attributes are
> actually invalid?
> 
> But maybe I'm wrong here and this is the preferable way of doing it.
> Miklos, could you provide your input on this?

Personally I would see it as change of behavior if out of the sudden
open is followed by getattr. In my opinion fuse server needs to make a
decision that it wants that. Let's take my favorite sshfs example with a
1s latency - it be very noticeable if open would get slowed down by
factor 2.

Thanks,
Bernd



