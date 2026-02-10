Return-Path: <linux-fsdevel+bounces-76868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SO/XLM51i2nZUQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 19:15:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF6211E477
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 19:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D39183011BD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 18:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AFB38B7BE;
	Tue, 10 Feb 2026 18:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tPWVeXbg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF10132D0CC;
	Tue, 10 Feb 2026 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770747119; cv=fail; b=X4mAeEEeQ02vu6X9UFSOBaK5VxFUdOcHC05D1in0QhS/JC38GkUzmDv/76nBVOlBoJQfUc6y5JfaI+M67g1XBxNvNj80k60h1CinR6oW2bfDTrLOe40SVTXfxZKuJZHJHvLh9B4tfVDZcJnurkn3t6+w9ARUkGGEu2gLbiN/4Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770747119; c=relaxed/simple;
	bh=9kl5zh1lPHqZUcMlVtzVfxx9gYMq5zrzEL8vtaFcdYk=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=hFWMGGQdqZYDhR6js0PScHH4irFNfvCFI37hqBKS6lalAh2iFfK5ftmaONSdeJLkC0eOOXBuAgWkN3U6HJQ1fDrSwofwRJuTcmPIShts9PnuInlta3+EGhyfFl83ao3GJRkwD/Et6Y0+kROOGCR7ZYQR5BRRkFScBoUHprwOKWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tPWVeXbg; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61AHJqD23145172;
	Tue, 10 Feb 2026 18:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=9kl5zh1lPHqZUcMlVtzVfxx9gYMq5zrzEL8vtaFcdYk=; b=tPWVeXbg
	hkBOM4GO+c255CYSVOQCPXJnyAUKE4d/IpnCosFtTlKkScJ0KX5BxyGRKhmf/cHr
	fjPgo1FTM9oM4PUqJF4LyD9KzXUnJxApfiVLsh7RoHLWOBCiBPATwmuUBZGXheSz
	lDnaarGAMjkCGk25oKnavC2to5FS4SgjJnJs0l1756V3yIzBbkugHccF5mzGVGqm
	1Eeb3YZY9tHlC9IkEixqPNwGBKVYtIkHVDCqmQnPBsmi8QGh0WER/GCIwo7Z1H/H
	dk3CjHhBAVXXGmfM2eU8+diB3w6aO3a7JXdj6j6ofAmAgOwBkL+ylV0HLAPPe+x6
	CZx7YPjUsXCKwQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013015.outbound.protection.outlook.com [40.93.201.15])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696v3evj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 18:11:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mn1N1ZK8rfvOrpgI4d872DQKpQwoj/VQwjQ6saImKaJO+U1TFIvW/kIFuLPWjtUjSjUVEJZ5XBGdODwQ2LZr4IvgglQixfHIVTEy5ZmauZcdJ3hAh/9MIQvY8poqGRZRfOcKLOcnFk69Y80FbufIu6IERfT2JM2kV7+7TaRF3iTX+wSLvju7gWmDtF1ox1Ucczydg+Ff0sTf/cD3LU53jQbDYs8Hc4gUnPAraQ37qHFI9lbosEFbaprh4iOXPOyQs+AJMAAWWqAImbFoaOgumhQJrbtNAYBufJiZKgr4Td8e0KEeiKZSktx04tuuFLJ3Rxaf/sAt6c/4mDNIxvAOYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kl5zh1lPHqZUcMlVtzVfxx9gYMq5zrzEL8vtaFcdYk=;
 b=wQYsTyCIdufccSdQ1W1KSJNe8gmFxawpeWxvcN7gQSvHqnvoIw3zFXDsQg4NFGPwvvDvXPjzGCalT/2k7ik0Tun4udaEruEu/+duUing06RhubThTEleZk7ZHWJ9EzjAPHQm8JUIRAHxIp/0dn3DMSUXvDVUeGu+F+4DisUKj1ed3QLzyn9y5IeyQFcxkaqpx7AF/pUzAjVbEgveRs+/5qO9Dx2RhRx6SJZa+EHzo55Wzag9Eyg3F4srhoX4OuIYVWtdVpkySHehmiCeyG/zvjVgr/fkz91E9zHrLSHPLT5cW9yWYfgZCTCKp0NsflSONaV9kbOMKvguVv4uUUbRpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ2PR15MB5801.namprd15.prod.outlook.com (2603:10b6:a03:4f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 18:11:35 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 18:11:35 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "penguin-kernel@I-love.SAKURA.ne.jp" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "shardul.b@mpiricsoftware.com" <shardul.b@mpiricsoftware.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "jkoolstra@xs4all.nl" <jkoolstra@xs4all.nl>,
        "mehdi.benhadjkhelifa@gmail.com" <mehdi.benhadjkhelifa@gmail.com>
Thread-Topic: [EXTERNAL] Re: [GIT PULL] hfs/hfsplus changes for 7.0-rc1
Thread-Index: AQHcmn4yyKeELkwlp0KS6m3pEaBjvbV8PGOA
Date: Tue, 10 Feb 2026 18:11:35 +0000
Message-ID: <30889d31f1cda6371139533d71d1ea688b2d5b79.camel@ibm.com>
References: <9ee4d3b9c7e2131f274c5d1eb2bfcd009a92c765.camel@dubeyko.com>
	 <6a99ecc3-ba7c-4687-9252-b4ea91ce9dfa@I-love.SAKURA.ne.jp>
In-Reply-To: <6a99ecc3-ba7c-4687-9252-b4ea91ce9dfa@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ2PR15MB5801:EE_
x-ms-office365-filtering-correlation-id: f18cb7d1-7ecb-4d1b-3c20-08de68cfd3e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QVpSTnhUenB0TlM5blJ5aFZKU3lhNHM2TWlyMzJRU3dBcE9rTHhTbzhzdUxC?=
 =?utf-8?B?S1R1T2FNbjBGRlFxdFkzNzVNMk1jS1lxZDRoeE8vN2pxQ3gyR2VxZnlwcitW?=
 =?utf-8?B?VVp2TUlFeEVSYUg2QnJXMDBjY2NqdVZtMlU3UVhtOVp0K0lQWVhWTmpuTDZD?=
 =?utf-8?B?aDBrTDBEdXErZEZXMmUxczZidjVEWXJaaXNXMWVhd1F1bnMzSUZKRE5PbEg0?=
 =?utf-8?B?cDlWWE5wcVVSWm1GR2xEV1lOZEVqNytXUCtYalV4VDQyTFpFYTJFV1pHK25x?=
 =?utf-8?B?WHR0c05mdndFM3hrRDBpWVhsWlcxVWlCNnpwM1Jac056Z3ZyeitIbm1qYW0r?=
 =?utf-8?B?d0pLM1RuZStnQVpuYjRvU2xQMFRCaUFaaGZJbGM2UTg2V1ZXSXVOcmtwaFF1?=
 =?utf-8?B?eHFQZHc2OE9uMTdZNkkzODFzOWZIRWgwdXFpaFRqaEk1REI1ZlhqZU9DaWxU?=
 =?utf-8?B?NXZnZFJLTVBvWThURDVXOUdPMHc3M3ZrK3NsZVZUTUFyS0FMaGNWd0xyL2dU?=
 =?utf-8?B?aGQ0TE1Gd215ZndKYitEVTB5SUg3ZEt4dVQ2ZmlPK0IwWEtQc3NUQklmUDdN?=
 =?utf-8?B?NlRibk5abEVuOFh4Z3YreWNITXQwcVZhaGk5UEVUT29ieFJrMmZ1UkFLTXZY?=
 =?utf-8?B?RHJ0LzlzbnB3b2pwMTJXaXExZHVJbW1jU3RrNFdab3d4d3E1YW50KzZvOUtZ?=
 =?utf-8?B?bWxRSnhTSENWdnN0WTV4V2lvUURBY1RPUC9yZ2pPY2FjSVgxL3JBcG1PdW9h?=
 =?utf-8?B?cmlNRnl6N280MTZTc3JNcDFRZG10M09EMHUxL0NVa1ViSXE3REp2Y05TRWps?=
 =?utf-8?B?cjNqd1RRQnBDRXVHNUMzQVBrR2FyZ0tyT21TbGVlMDUzd1V5c2tncGF2bnE0?=
 =?utf-8?B?M2lZLzJvSHlGU0dTakVtV0l1NFFnZlk5ZDk1WGdKQVlPY2lTa0pDcy85UDNO?=
 =?utf-8?B?ZmlLZU5teFBUeldWSDVJRXNDNWNwTkl5RXpuazdTaFZyNCtnQ0JsQ1VCU0Uv?=
 =?utf-8?B?RmhzZThzbkcwVy9rQzFVS05oVjh2dFhaV1J1b0I3N2pUWjFFMVhqZ1VzZzB3?=
 =?utf-8?B?dWJhY3dKZU00bWNZTTlxOEp3aEx4bDNFRUVYNU5IcGdCNC9qMFY5UlVlQ2VE?=
 =?utf-8?B?VGNJVHphUXRYOXExUEhWbUcxM2JSWmQzeTZ3NHVMai81MjAvL2FuQlR1VW1F?=
 =?utf-8?B?QVRxYk9WWi9HR0NOS0xlZzZKWjFiMWdSMVhMWkZTK0J0Q3FndHEvSW1QZGp5?=
 =?utf-8?B?d1NoQTBVN3lrSGwvTzNPNTArRVNDOXZBcHNMQUR0RGRpK2Q0b2NUbVBiZE5U?=
 =?utf-8?B?a0c4Um5obTgyVG9XZlNKd1FzRUZFSlJnbStoT2xrUmttb1lqTGxCUTdEVkw4?=
 =?utf-8?B?bXZSRk9mTGhtZXBLQ2wvNVFzUTBLai9QTVE2czRHOFBKUTcyazVrOWQrN29L?=
 =?utf-8?B?UDRXYlBFazc2RlRoc1V5ZFVKcUM3N3ZYd2NrWTJLRXVPa3JYUXFmMjJVZWdx?=
 =?utf-8?B?UzZzUEs0WEowTGhobVdlZVdZUm5VSDd1UUJLblBCZkpzcC9ncUFaSDlkTUNZ?=
 =?utf-8?B?SWxFYjltTDlyZDQ3SXNML2k2SmlIU0x3bWdsd0FydDVvWXFqTENiOFdBTzFn?=
 =?utf-8?B?dHhLd0thR0U2VFRkTDA4VThLQnprcjhVVWZFOEdIOEtvOFl0anlJRTlWRUR0?=
 =?utf-8?B?eXEzS25mKytHTytBODhESFExTXhsZ2N3d3A4QXpPWCtOc1h6RytOVmxTaUhk?=
 =?utf-8?B?UkNHRHV4Z080N3E5QjlZSWd4N0pWUm8xbVdId05WUWJPTEJ2OVhTcFZFeFlj?=
 =?utf-8?B?a1k2U3gxaTAvbWFvTnlRWEhBbnY4Tm15SzJ1R0Q3c2ZHZkhxbjRDcFdWUmZp?=
 =?utf-8?B?a2d6Y2RnOHVxVmlGVTdnQ21yd0JBdU4xRlIzVFJDbklBcjNpRlltN1MzSlpz?=
 =?utf-8?B?eHIrd2tqSzB5UVVZWm1wWnloc0hrem9pNGc4K1U5VmtKVGpnWUY2cnl3QlY2?=
 =?utf-8?B?NXNDSVlVa3IreisyMXhDYmdTUFAzZjlJbzMzSTRXaUpKRnRZRENjQ3AvSG5G?=
 =?utf-8?B?cVNveWpGS2lvMGM1dGgwL2puOGVtUGhuOWJCREpTdnV5Qk1nNElQdlY4dkdS?=
 =?utf-8?Q?plxGUyQmced9gnyl/GFzzvoqO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VGNWYXZKbkkzbG5NbVhWc29tTFZWalBsaHh1TGw5cTVwbkQxTXdDdmJHUzhZ?=
 =?utf-8?B?aWdyYzlDTDJucGhmSmlvZnd1eWJWRVcySk5yNXRveEFMMzNwSVBGbTFyTUNI?=
 =?utf-8?B?L2V4YzJ5Zm5zalU5Y2pFdXdVQnhTa0JQbEZ4dFcxbzRsbmc0Vmp5NjQxNlp4?=
 =?utf-8?B?MHpkekwxS0F3Q1hGNW0rVXh0K3M2emFoaWI4UmM3T2QrM3ZQRUVYNGcwU1Bi?=
 =?utf-8?B?OTBrZnpWb2NFVEF4dWdQTSthK3JnZlBSSCt3ZUlDNG9RZzBuSnBrdk44QVI3?=
 =?utf-8?B?VVlwbUhWQVRHc0g1R1ZpZTlKUnpYZjRPRDRZcVVVcmk0Ti9VdW00L3lMVkNt?=
 =?utf-8?B?RlUzeDUyN2pFUHJzbTJ4QWlZZVpUNnNBUzNWYnlSZWhRZEgrMUxJaEsvdEh5?=
 =?utf-8?B?UFhVWVVwelpOWkdaZEVZdzF5RmNST1NnN2VHdzFBNGZ5L2QwWDFkbkp5dXRX?=
 =?utf-8?B?OFd5UGJMU3R0bzd2aEhqQWtKRGZ6dVBVL0Z3MHN5WEsvYVkxc3BzR3ZHTzNG?=
 =?utf-8?B?cURPRDBYaWFlOXdsdnM3UHpGckpuWnlpMlVySFRObzZRM0k3ZE5NZWhJRFZ2?=
 =?utf-8?B?bnVjRGxYT2c4U1N4am5XODc0TzZJL0VHWDNiZ2kyU0ZKVURkMlA1SUNhWjVI?=
 =?utf-8?B?MEVSNlBkZlFtemVSOVpvQS9XdEdZVStFVWFRRm5EZGNBbStOdFhRRVNnMEFx?=
 =?utf-8?B?aFpPN2tzT1oxRnF1TlpKTzhBTFNBdGdYMkthanFzWEloLzFMQzdnNkxtUndC?=
 =?utf-8?B?dGtXV0g0RWtScTdEZUw3d0IyQm1GRnVjZ3dsc2ZRcGRRRSszQTNiV1c4Z01l?=
 =?utf-8?B?dkVZZHJNc2JBL1VkdWR3ZzIvVW1kYTIzRTloaFdaQ0puUkhxajk1R2pkUFVi?=
 =?utf-8?B?bTZOZFFyenE3L2NmR0J5b3U3UEI3Vnl3RkRycVQrN0FJdHRuVjRxT2ZuVEN3?=
 =?utf-8?B?NllTWVpFMno3VExOcDM2dzh4cWtxaSs1QngxS2ZRd0NKZ0JDb2svU2l5V1oz?=
 =?utf-8?B?NWhBZnNSbmpLSnNvUXM2c3NCeXp6YWVjaUpPNkpIVmVHVHhpVHJsQVdYbFFD?=
 =?utf-8?B?a29iUE1iWnE4NFBmK2dQd0VqMWF1bnBITVU0cjBSSWg3M3gxTFhhK2h4MjhT?=
 =?utf-8?B?blY1VlVPWE5mYmxYeEwrakZwOE9HMUttRzUzdnNoUWF6eTE4Ymw5VmcxZDBv?=
 =?utf-8?B?RmYvZDBMUlVYZkRrWFBKNlRWMzIwdWphU1FJYUNkZzYwSEdGa2h6Wmgxbjdt?=
 =?utf-8?B?cDdGQzZLOVdIZUVKU0RwZktSSDdtZmM5MDdOR1phQnRoRUtmVEZHdSt4aE00?=
 =?utf-8?B?TnROdUpVTXUxZHQ5ZE9XWjJhVDVBNTM3dVZ2ME50ODFMUGpOUkxxN24vdVJN?=
 =?utf-8?B?R3ZNc2Erd0pTZU81MDJIWVhwbkFPdVk4c1l1dXpsa1lCalV1VE5zNTUzSVBJ?=
 =?utf-8?B?OUhDV3RjNUpTMHRiV3FTQ1BiSHl4MXpiQXNZTlN1MnZzbzVLSHBnQW9QNjg5?=
 =?utf-8?B?eDF2Z3prNXpsWVdlMmZRVlVTR1VIU2xQTS92MWI3MjZxYWx2azRFaGJ4dTAr?=
 =?utf-8?B?a29zWWpVV0o0OWlWSmRYRWNPMDNWVDRub296T3pyZnpuVXlVOEdJZlJzR2s3?=
 =?utf-8?B?SmdiNjJzdVU4RXFvWitTZ2UwdVNVZUVpM2FzM2FobERUSW01bExwNHdxNyt0?=
 =?utf-8?B?enM3aGxlcU1oTWVJb0k3ZVorN2t4by9mbngxci9Ud1phdjc3bDFkdlhjNWJ2?=
 =?utf-8?B?UmZ6V1JRaXhxNU44djZPN0xvNFllbFh5U05BQi81VkFmRXRpMFBaZ0RCcGV6?=
 =?utf-8?B?TXlDNHNaWndybEJPdVQ3Nk92TFZSdFFKUVdXUGk4bm8yQzAwSFBzRG5lYlFz?=
 =?utf-8?B?MjIzQzMreEhmWnRrdENiYnZtQ3U5Qzg1RjhXdTJvUmV0Q2R5anBQeGJBWlN3?=
 =?utf-8?B?N0I2Y2NuM0JTdGhzY3ZCZ2p3OUJQNU9WcDlxemFJZ2MzQ0J2VklKN1hndHg0?=
 =?utf-8?B?dUVPL1pWdkdMQVJGK3o2Vk9BZkhJRTg3N3ZRUVIwd1ZBR3VVK28wRnlqelg5?=
 =?utf-8?B?V2NoQ3FHVlVIY01FNGRIMWNVb0NOQUJRdk5uUTRlZWhvcnRVNTBLdE1WanFo?=
 =?utf-8?B?aDBsUG5FT043L0s0OCtacFdCcnZWWUVvTFJKV0xTaFY2ZjFoSWZ1b1NYeFB6?=
 =?utf-8?B?T04zREJCanBJL3ZzWEtPd3N0eFF5KzVSVnpsdGNlTUNRS2xiTWFrMXo3WnZo?=
 =?utf-8?B?YzRNSEpSNTg1TzJrb3oyR202QkhUZTFjWG00TWxmU1FlcSs3OTJYc0tuY0hO?=
 =?utf-8?B?SzZPYVhqY3NVbUtKcVVtKy9TQjd3TkRXQzhIZ1d0K2pwRlpQZVhOelZWQTlE?=
 =?utf-8?Q?uoxFgf4/LpXd7sFDlLkk1qQhogXtNBMuq0esX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <454251AF43415B4B975827B2AAF6C8B0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18cb7d1-7ecb-4d1b-3c20-08de68cfd3e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 18:11:35.5505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mz3fwcKtw2nIifLjcusAAXt56DItNH/GsKRwu0R1VQmbeMcj0p7EqD038+qIzMu4QUmf87rWRtDGNtIZIJ1i7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB5801
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ajcNOF_ftxt-t-DeYXtH4QTy5S7IaO3q
X-Proofpoint-ORIG-GUID: BYuV7KVO4JV8L1rGmeykaFay63wnU4zW
X-Authority-Analysis: v=2.4 cv=JdWxbEKV c=1 sm=1 tr=0 ts=698b74da cx=c_pps
 a=vvCUPcqovLgrcFR9lHNvxw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=edf1wS77AAAA:8 a=dbdXaiMWH88xWDAnGyYA:9
 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE0OCBTYWx0ZWRfX/RBrRselVdsp
 GyHxSOTpUMD9D+KliLoXv8Pn1DkX1BCh9txAtlWcyH4zjZ4WDGhHV67zf1v0f//JYI0nWLvSV04
 JUfYyRLmGhUhHccmaRO13Xr/RHaplSpHpmy/LKnRS3cijRpcyJ3zSlfZ5I04JantV1kdw+x7TFv
 6gv4W7DJw4LOBQf7lbWk9NO0Olwj5XxhEKzkX53/1dbPPMOvyl9on4QoWUehyIHdYFc0IZqZRcY
 HwD47GBETEDpaD1kCK+6tPyybQWUR0C/kGwglD/WBH8pQ33TWmbeZK0pcy2a3/MmsvsJ3UJjcKO
 4JIdyjkNA8ZgiI1idqnK7xMn5faSkEOKav68Spc7gOlb60nBykftgiRGnsDJSUzpmtujBBX+KhU
 Lc4k9xt+AHiZ+pHVDXc6aaM+VgB0b+N+8t3ybLht2puP+/6yWcERObXqVmbPgOsNDsJw873SfGh
 emCdtZHUOiiv68CBE0w==
Subject: RE: [GIT PULL] hfs/hfsplus changes for 7.0-rc1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_02,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100148
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-76868-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mpiricsoftware.com,physik.fu-berlin.de,vivo.com,vger.kernel.org,xs4all.nl,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[proofpoint.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3FF6211E477
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTAyLTEwIGF0IDIwOjEyICswOTAwLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IE9uIDIwMjYvMDIvMDcgOToyNiwgVmlhY2hlc2xhdiBEdWJleWtvIHdyb3RlOg0KPiA+IEpvcmkg
S29vbHN0cmEgaGFzIGZpeGVkIHRoZSBzeXpib3QgcmVwb3J0ZWQgaXNzdWUgb2YgdHJpZ2dlcmlu
Zw0KPiA+IEJVR19PTigpIGluIHRoZSBjYXNlIG9mIGNvcnJ1cHRlZCBzdXBlcmJsb2NrLiBUaGlz
IHBhdGNoIHJlcGxhY2VzDQo+ID4gdGhlIEJVR19PTigpIGluIG11bHRpcGxlIHBsYWNlcyB3aXRo
IHByb3BlciBlcnJvciBoYW5kbGluZyBhbmQNCj4gPiByZXNvbHZlcyB0aGUgc3l6Ym90IHJlcG9y
dGVkIGJ1Zy4NCj4gDQo+IEkgdGhpbmsgdGhhdCBjb21taXQgYjIyNjgwNDUzMmE4ICgiaGZzOiBS
ZXBsYWNlIEJVR19PTiB3aXRoIGVycm9yIGhhbmRsaW5nIGZvciBDTklEIGNvdW50IGNoZWNrcyIp
IGlzIGluY29tcGxldGUuDQo+IA0KPiBTaW5jZSBhdG9taWM2NF90IGlzIHNpZ25lZCA2NGJpdHMg
YW5kIFUzMl9NQVggaXMgdW5zaWduZWQgMzJiaXRzLCB0aGUgY29tcGFyaXNvbg0KPiAiaWYgKGF0
b21pYzY0X3JlYWQoJnNiaS0+bmV4dF9pZCkgPiBVMzJfTUFYKSIgYmVjb21lcyBmYWxzZSB3aGVu
IHNiaS0+bmV4dF9pZCA+PSAoKC0xVUxMKSAvIDIpICsgMS4NCj4gSSBndWVzcyB0aGF0IGEgY29y
cnVwdGVkIGZpbGVzeXN0ZW0gY2FuIGhhdmUgZS5nLiBzYmktPm5leHRfaWQgPT0gLTEsIGFuZA0K
PiAiaWYgKGF0b21pYzY0X3JlYWQoJnNiaS0+bmV4dF9pZCkgPj4gMzIpIiB3b3VsZCBjaGVjayB0
aGF0IHRoZSB1cHBlciAzMmJpdHMgYXJlIGFsbCAwLg0KPiANCj4gDQo+IA0KPiBBbHNvLCBJIGNv
bmZpcm1lZCB0aGF0IHRoaXMgcHVsbCByZXF1ZXN0IGRpZCBub3QgaW5jbHVkZSBhIGZpeCBmb3IN
Cj4gaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19z
eXprYWxsZXIuYXBwc3BvdC5jb21fYnVnLTNGaWQtM0RlZTU5NWJmOWUwOTlmZmYwNjEwODI4ZTM3
YmJiY2RiN2EyOTMzZjU4JmQ9RHdJQ2FRJmM9QlNEaWNxQlFCRGpESTlSa1Z5VGNIUSZyPXE1Yklt
NEFYTXpjOE5KdTFfUkdtblEyZk1XS3E0WTRSQWtFbHZVZ1NzMDAmbT1vU1lQcmp2cU9GSmNNMVFp
a2dOZGU1b1VoSWRHZE1wdW01VVFNTGF5aUpTMHlRckp0VC1yZlpYSko2cnFhQmRfJnM9enRYWS1M
M2FCYzJteFR3THVOazNkcmZVLWNhOEJPbklPU0xiZlVlc0EtbyZlPSAgLg0KPiBJJ20gd2FpdGlu
ZyBmb3IgbmV4dCB2ZXJzaW9uIG9mIHBhdGNoIGZvciB0aGlzIHByb2JsZW0uDQo+IA0KDQpJZiBz
b21ldGhpbmcgd2FzIG1pc3NlZCBpbiB0aGUgcGF0Y2gsIHRoZW4geW91IG9yIEpvcmkgYXJlIHdl
bGNvbWUgdG8gc2VuZCB0aGUNCmZpeC4NCg0KVGhhbmtzLA0KU2xhdmEuDQo=

