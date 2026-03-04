Return-Path: <linux-fsdevel+bounces-79437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MxdH7WQqGkLvwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 21:06:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FF120766E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 21:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84CA63011044
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 20:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7211C381AF6;
	Wed,  4 Mar 2026 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FoSlnqaH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC83378D82;
	Wed,  4 Mar 2026 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772654742; cv=fail; b=iMlmNRqAdK/9Bs4TYCy3c/C77FDoGuOfksZYxazh0l+5X6VFruzhaRkgWY6/qTH/pgLInFhZi98Obe5cmAQom21/HHWzNQMwXCWUKsDt9WA3978SJu3i4Ov/ipuWSonrqoR+0mRIM5X+Z7Dwhf1x8FmEcoRir9r1+Y2qgtWANOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772654742; c=relaxed/simple;
	bh=MzzwIX7Sfx/FcGT94nHGIUo6Olqcw1T13KEq6pwFkU4=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=AD6AbdjW6gVBu6icCo6lkdgdddjdcuKz/igy0iBLnF4bljtvz6yprP5cWeqh9Ugsdoni/V6yXaUC5qGyOcoKxjnXaHMI0KkZBTz/jYGGmBJDquRMDpoejtrFiqYHUGcod1d5Nb4XjwHeGL2D3fWEosmFaRTKaVD57ljsknqCoCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FoSlnqaH; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6249Fj0A2339714;
	Wed, 4 Mar 2026 20:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=MzzwIX7Sfx/FcGT94nHGIUo6Olqcw1T13KEq6pwFkU4=; b=FoSlnqaH
	C3NB/D6wD94+MAe9R99mkKVLYkCIhHtgwqfdNN9UcjMWwTaOsjZcBxqPMxgJ3O3J
	Btk4bE4algPRFvyESYobAFyygU5FXeBkEHZHanrHyDjxq8qT8MBaeNrBDT/Efr6N
	8lPUGijnjpKvOgBShi8T5Hg2qbGUYYfDOmHo0GkahxXRDSePdkzKRaH596QAmR8k
	08roHe4mxDCJo7dpO+iRDdxMc0z/J8xi4KKhdtom7Aa284FXEnDgXszIk7zNRHD2
	Svxg4kRu7CpJXl+TSELl3Ct2aOvy+PEzYxp/NKes3TAJSrzqqqV4ZUHdz+jZua3v
	pb8CLa5GCK8fNw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012006.outbound.protection.outlook.com [40.93.195.6])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrj91yt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Mar 2026 20:04:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGVn5L2ENtiD0h+x4GYSp5UmRFInE+L6EjVvZ872231YrkSFSuIQvdnr6BeeLdCY9VXS94DItqVSCv5n/vuwq6qy6rZDtLTHnwf3LRIJGtV19rzkba0qBgeXvZTN2A9B508KQmtGcAYf/z5j/uo5GZVz5Z55Gs+NgbUrZLPmsqEM7w1VIu9Dm5n7SkMjSmkLGsVeWr1ABOK2iOYd61++tC4cP4BaX78+LyT4x+TltsTGckgb0TnGTpo4HV5dsRcuIXePJGgY5aFtZRtgWHV2pQnCqTgxFZGjYJkbSRF3/wl9oEzS6AoEOpBMTmuyzL2Qgu/481J8mmIuNESqixLqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzzwIX7Sfx/FcGT94nHGIUo6Olqcw1T13KEq6pwFkU4=;
 b=GMBioZYMqabeEvWXLW7p0BrvVI4FBf6/Dia3VsFIR9Gt76St3BMcnVquCl0jqinrENKveq5j2UMjfNEpOzWc3EKJVxWrEJETf3VG9xw1UHAiPg4x45j75yAxnZCnHh3aRYzUi11mhDEZaztyiDBxyh1VyCO/+pyutEGUMPJ4f3gxr3qnoDTUV1XP8sDVO/3sXpbna4kB0/Z8uEiWx0A9JGQhSNurDF0GSfSBzOD92OIHuu3b2M3RHfbqPNSUZLz8JmUO13aS8g3mDMGfWPqCcPYP5AqfOUCO6Af2M4YQAw/0gUs8O5OlzdbY+KPRYfmKTKaC8h87UvqcIaL6y29kiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW3PR15MB4057.namprd15.prod.outlook.com (2603:10b6:303:47::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 20:04:30 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Wed, 4 Mar 2026
 20:04:30 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "hyc.lee@gmail.com" <hyc.lee@gmail.com>,
        "hch@infradead.org"
	<hch@infradead.org>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "cheol.lee@lge.com" <cheol.lee@lge.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] hfsplus: limit sb_maxbytes to partition
 size
Thread-Index: AQHcq9hDf3IahKMroEqX1R8/F3zmX7WezIeA
Date: Wed, 4 Mar 2026 20:04:30 +0000
Message-ID: <5c670210661f30038070616c65492fa2a96b028c.camel@ibm.com>
References: <20260303082807.750679-1-hyc.lee@gmail.com>
	 <aaguv09zaPCgdzWO@infradead.org>
In-Reply-To: <aaguv09zaPCgdzWO@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW3PR15MB4057:EE_
x-ms-office365-filtering-correlation-id: 997f7b47-2ee6-4b4f-6997-08de7a293ef3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 6JUD2BQI5mOg3uLp1erqRMUknWd6S10j4Mt57tSJmlz7/GsbtfmHBEMmMBCUSXvvz6DzryMceK274+xVBxEUEfaNNAukF1KZan2LcLouAi69iTLW/tdSaA+YTZj7Jlla2NZ6+JV2yl6vhdOtsxfifqI4K980K1V2l1NwndK60g8wFWOWSdyeVnK/Wjf47yDmI421xSw28hmTq0zTA/yrArkp/SnCatQmfRCNKLB+vxaAApfj9SGiIpuzW7gzERX+NiCKj3myuJ0qS601FWHJYsKYK6QLA4yuOduBtNHocHP05Cu0Trlxf3VstxohEskfVLIqc/q1Ucj3zKbY+yA9LAsa9EWV9pYgPyWjZICZ6SI7M/WUOz3Kwy//6IFrccmfAX2539+JYALAcvJqGxZ2D3XIQ74CD3p72dU9IB11VUk60zgo9aJWER04KVEK9OGPDzz/SS8jCLf6Zw736jnWJJw1Us5Uuqf6KL/+U8RHIMGswvkJ+zCIEKr42SJr5DSq1N1A0Y+90IBprXaQO3hiDCI94c1Kem8rtjCb6x87ujW2tc/xpN0WwBtdBoFwFevBjdCfvdLMB9L1PYSLGTCl10YrrriRcrcp45NSzxETXdvgGpmg7g1MxLCVdDTj3zegtNy9RUJXeNpKuIoeLcK+v5L7URJJu1Ik8awUdCHUGI7KrCVhldIy2JIar3OzLR+cPAC/19D8KP3ddFEaitl0hGJiE0OrLjrVz998vTweGzKPBSX6PbWz2eils2IkFU6OK/+CaDmPCE/1k/grZKG8KUvQFX6VcdhM7CVOWc278Uk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDZPVFNvWXgvZTZza1pkU1RUVTNMdm9rVFp5QkcrR3NxOUN2TmVXZ2dYSjBw?=
 =?utf-8?B?d2lmOW04SEFqV3Q0MkEyVEtwVWZiRXg2UkkrZSt2Y2xTTDVPME5taFlhMWRP?=
 =?utf-8?B?UFRiTWp5YWErMTBhRElUZXVXRWRQSTFtVmMvVTdpYy9QNHpKbnduSExIM0FL?=
 =?utf-8?B?ZTBreExZWjh6SWFGRkdEOU5UdTVPVTEvYWkzclh4UXdkdStLeDVWUjU5b09S?=
 =?utf-8?B?aDRsNFV3NGdwWnQyaDcwcDZUZmQ3UTk3MHNFWHlIWUt3Z05FL3BpK3UwQ3hW?=
 =?utf-8?B?MUo2MzUyaW5VZmhKQWxxc0RRd3lLTVhRUkdpK1pZbVFNOUtNNlRFWjhobjdM?=
 =?utf-8?B?Y2ZmUmxNQnF5NDhZQ2lOUTl2dVE1WGQ3K29FT1ZabnJKVkM4SW1UaWRjSHJx?=
 =?utf-8?B?T29FNVlEMk92Uys2eWVJMXQzY3lPK3NZRzY2TzNQWE1Ld2tlMmVrK3cwNWRv?=
 =?utf-8?B?akh0RUIyVEVrZ0VYYWg1Rmo1elhsZjZiMjBEZDNDUVJVTy8zNEZYbEY4OGhh?=
 =?utf-8?B?cTE5eUgxWlR3eFc0WUJPSEgybWw2M3pFY01jMVIrTHZLVld3bHJBQlZsS1dD?=
 =?utf-8?B?MWFYdWc4aUtKVlJPbUpNM0hDcExrTDRUVTBYVk1RaWE5YmFmODJoU01Ucnpv?=
 =?utf-8?B?V1RPd3hyRnpWTWY0Y05LbU02aThwdDMxLzVpK3lub0tMYW5leDBOUlFnTEw5?=
 =?utf-8?B?Zm85UWRkNDdFRkcvaG04YU5XOVdMWHRxSlFkbURBTTlTa0JZcnNUY0NVSDA3?=
 =?utf-8?B?SzJ3SnVENi9lOEs0Mnpka2RjdFpFMXprOEo5VVBoVGxUT21WWk9xa0REZ2I3?=
 =?utf-8?B?M0NXNTUyNGlGYUkwL0t5WmV1end4SGxJcnlEcWdtUldhdlhaRkdYOWV4YlRr?=
 =?utf-8?B?bGp3Rk9iL0lERFpZR3M4b3pLbkdFUFdNKzdxTk94M3V6UUVlcXFJOHU5S0lk?=
 =?utf-8?B?bjZQbVM5QkZHbmdWK2JVcHlzMm5Gak9STkhmemFFMjdyaFJPZkQrSG5qbnB6?=
 =?utf-8?B?cDBOblRDcVBHTHZKSW1FZ3pTSVJseXlGWFpsMElyWVNiaFZrWjlLOTlLTE00?=
 =?utf-8?B?aXJURVpYQmhJWjVZTmlOY0t3eENFcitJaWtWaUl1WWRBZTBKWTk3akVZOHA4?=
 =?utf-8?B?UUxPblRsc002WnU3dmRQVVk1MzdaTkVlaDFkenpkZ0hwMGV3NXErME53dzJL?=
 =?utf-8?B?cEhFZmtDbzM3ZStZN3psOHgvR1UrMDRNWG9LVE81MHk3U1lHaGpOQ3FVQzNZ?=
 =?utf-8?B?TXhOLzdTV0FPSm1FaTI4a2RsRExnMTRDWEdQWWUwWFRtQ1dtZ05Bd0dqeisz?=
 =?utf-8?B?Q2ZDM3JCanRvbzZ0R1k1ZWkxTzBXaEphU2RPT2EzdGhYRDdEQm1TMlNuTy8w?=
 =?utf-8?B?ZGZHeUlyVDRKT2l4akh6N0wxSlh5cHF2dnFpNG9IaHpzUmdrRXdCMFlqenQ4?=
 =?utf-8?B?S2djam9EL3ZtN284R3RSdGlHYjRzNjdoc0Z3L1NFb0NTMzNGcldOaWpWNkZH?=
 =?utf-8?B?NElGNDNRMUVpNG5EYVhqclVPUklDcVJBejBEWXpSZnI5WXlEMGdvTjA2SG1M?=
 =?utf-8?B?cFB1U1V0QUFVWFV0YjBXZVdPRFM5NmhpU2F6Z09JODRhMHBSci9iT2loQXFZ?=
 =?utf-8?B?R2hEZ2JBcmpXMXpJOEt2ZDJYN210V2F4alJ4K2FvKytqVzhVRmhmcUx2RU4z?=
 =?utf-8?B?V3NnelRQbGQ0U002TTRGKzhydnlndS9GOXlBT29FdUlYYkw2bWdwTit2MWt6?=
 =?utf-8?B?ZmZlSkJ4ZXBwaUJqbWZPTmhTRFlVSHFWM0hTRDR3ZEVtdGdWNldRSUNDbk5M?=
 =?utf-8?B?S2FUclNaZGFrMjF1VlZXemFTc2lKYlBveUVzdnUyYlpZS2FLOVRxWG5kK2gv?=
 =?utf-8?B?cWlBN3VhUFZHWUtRWXBOd1hKOGxzcW1IOXc2Uyt0M3djQ0lSVlVMeFU4S1dU?=
 =?utf-8?B?cSsvMjkrQ1hDQnNXRm5xbFZmODY4WkNJb2M4cHdxdHRJY1ZRejBZcjhXMUFF?=
 =?utf-8?B?UU8zb2R1Rlh2bXp4V29zOThoaTk4NkRHZWlTTXYxdWNyb1EwT2ZNV0JNTHVN?=
 =?utf-8?B?aVhadGVORlp5ZG5aOG9uN0twSmQ5OUpXZDVhV0s2MWFnaDBvL2gwVmYzUTFT?=
 =?utf-8?B?ZWRIRkg5bzdqbEdvZ1dTZmNGcjY5cklBTWRSeWxvT0ErQXVGVWJ5LzYwa2cv?=
 =?utf-8?B?WHJRb0MwVmlUdlZHekYyTEY3TDNFUTZlNTZEWDZuYml6T0I5S3kwUUk3WCtt?=
 =?utf-8?B?QU5lelhJQndtSVkvQWE4bzFWRkVQbjZkUG9xNklOT0V1YzVibmIra1VuME85?=
 =?utf-8?B?UUNYUHpTK2tMay9UeG10MGRuZUE3VnZ6a01QenFBcmxHSGc4UkI0cVJmelBz?=
 =?utf-8?Q?yQ9uDB3Uxn3YYC8D1SeweeyaIzZM17zGyfFUe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3643557AA3E8E459355509DC298A67E@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 997f7b47-2ee6-4b4f-6997-08de7a293ef3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 20:04:30.1497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FuCcoI9pyVsvg2p9vL2ABbindqPHXTXXq/nu321/ghqP0MhJa+sBmPeIwONS6z+bNbCnIOswiM+kqZSUOToNUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB4057
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69a89051 cx=c_pps
 a=NVT6GquIkcOJbfF4gP4t1A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=lTg7mvpYRg46tuq6upsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE2MSBTYWx0ZWRfX4uuozp1rTujf
 ROmY5IcnQBwJKpCqdV6SQOyZT3PvC44Z0yITAIioydtJTdqPucKzbymVWPl5J6xSHCOzNFYp+yx
 NqKuj6qJ+cxxkAxWU+OMjSOXNAD4PDsWRc5WG/MHgoF5ufnHUSUFQCHGfrw7aV8B2pQ6sMQIfTo
 Tt9PQVfsBbywt/ytZegL1ssFDozvuJKjJC/hpwm505LA1Y0m9lAn5+Unn63BSjhyV/eundlA+C/
 xkFI3w86fhVhcmPrv78qNtL2MOaCLXaLnBKRiYpsUG9m2ws0CxJU//P65nK8y0MA7LsrYMpTu3j
 QdZLSvJeOVy4G1VEraDyvmrEa6EG9tGnH8QdDvzRHTm9xPKT2pgJpm8Xsdv47M2C6UdX7+X/dMd
 deIFfMLKHgK4E8FrSpdqT9cZulxNHyCZdEjHOb+UlrycP8Z/Hm3TDq/b3M/yzsYMZRgvrPQLVxq
 Dc8qxu5eBPkIIYlC0Uw==
X-Proofpoint-GUID: ezqYF8m67D5AQhedEVolwtkMpPL9-oz6
X-Proofpoint-ORIG-GUID: MStIbrQtC0NrK_a50cULB_wQgHUB416G
Subject: RE: [PATCH] hfsplus: limit sb_maxbytes to partition size
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_07,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1011 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040161
X-Rspamd-Queue-Id: 18FF120766E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-79437-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,infradead.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAzLTA0IGF0IDA1OjA4IC0wODAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gVHVlLCBNYXIgMDMsIDIwMjYgYXQgMDU6Mjg6MDdQTSArMDkwMCwgSHl1bmNodWwg
TGVlIHdyb3RlOg0KPiA+IHNfbWF4Ynl0ZXMgY3VycmVudGx5IGlzIHNldCB0byBNQVhfTEZTX0ZJ
TEVTSVpFLA0KPiA+IHdoaWNoIGFsbG93cyB3cml0ZXMgYmV5b25kIHRoZSBwYXJ0aXRpb24gc2l6
ZS4NCj4gDQo+IFRoZSAicGFydGl0aW9uIHNpemUiIGRvZXMgbm90IG1hdHRlciBoZXJlLiAgc19t
YXhieXRlcyBpcyB0aGUgbWF4aW11bQ0KPiBzaXplIHN1cHBvcnRlZCBieSB0aGUgZm9ybWF0IGFu
ZCBoYXMgbm90aGluZyB0byBkbyB3aXRoIHRoZSBhY3R1YWwgc3BhY2UNCj4gYWxsb2NhdGVkIHRv
IHRoZSBmaWxlIHN5c3RlbSAod2hpY2ggaW4gTGludXggdGVybWlub2xvZ3kgd291bGQgYmUgdGhl
DQo+IGJsb2NrIGRldmljZSBhbmQgbm90IHRoZSBwYXJ0aXRpb24gYW55d2F5KS4NCj4gDQo+ID4g
DQo+ID4gQXMgYSByZXN1bHQsDQo+ID4gbGFyZ2Utb2Zmc2V0IHdyaXRlcyBvbiBzbWFsbCBwYXJ0
aXRpb25zIGNhbiBmYWlsIGxhdGUNCj4gPiB3aXRoIEVOT1NQQy4NCj4gDQo+IFRoYXQgc291bmRz
IGxpa2Ugc29tZSBvdGhlciBjaGVjayBpcyBtaXNzaW5nIGluIGhmc3BsdXMsIGJ1dCBpdA0KPiBz
aG91bGQgYmUgYWJvdXQgdGhlIGF2YWlsYWJsZSBmcmVlIHNwYWNlLCBub3QgdGhlIGRldmljZSBz
aXplLg0KPiANCg0KSSBhZ3JlZSB3aXRoIENocmlzdG9waC4NCg0KQnV0LCBmcmFua2x5IHNwZWFr
aW5nLCBJIGRvbid0IHF1aXRlIGZvbGxvdyB3aGljaCBwYXJ0aWN1bGFyIGlzc3VlIGlzIHVuZGVy
IGZpeA0KaGVyZS4gSSBjYW4gc2VlIHRoYXQgZ2VuZXJpYy8yNjggZmFpbHVyZSBoYXMgYmVlbiBt
ZW50aW9uZWQuIEhvd2V2ZXIsIEkgY2FuIHNlZQ0KdGhpczoNCg0Kc3VkbyAuL2NoZWNrIGdlbmVy
aWMvMjY4IA0KRlNUWVAgICAgICAgICAtLSBoZnNwbHVzDQpQTEFURk9STSAgICAgIC0tIExpbnV4
L3g4Nl82NCBoZnNwbHVzLXRlc3RpbmctMDAwMSA2LjE5LjAtcmMxKyAjOTUgU01QDQpQUkVFTVBU
X0RZTkFNSUMgVGh1IEZlYiAxOSAxNToyOTo1NSBQU1QgMjAyNg0KTUtGU19PUFRJT05TICAtLSAv
ZGV2L2xvb3A1MQ0KTU9VTlRfT1BUSU9OUyAtLSAvZGV2L2xvb3A1MSAvbW50L3NjcmF0Y2gNCg0K
Z2VuZXJpYy8yNjggICAgICAgW25vdCBydW5dIFJlZmxpbmsgbm90IHN1cHBvcnRlZCBieSBzY3Jh
dGNoIGZpbGVzeXN0ZW0gdHlwZToNCmhmc3BsdXMNClJhbjogZ2VuZXJpYy8yNjgNCk5vdCBydW46
IGdlbmVyaWMvMjY4DQpQYXNzZWQgYWxsIDEgdGVzdHMNCg0KV2hpY2ggcGFydGljdWxhciBpc3N1
ZSBpcyB1bmRlciBmaXg/DQoNClRoYW5rcywNClNsYXZhLg0K

