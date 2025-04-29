Return-Path: <linux-fsdevel+bounces-47555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744B6AA025B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 08:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7AE5465067
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 06:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C392741B7;
	Tue, 29 Apr 2025 06:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qzur8Qsv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="woYOFl4C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AA1253335
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 06:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745906751; cv=fail; b=m4tE7riS3RsBbo3LzG710GgYI6RgsnbI47FcQW3t6LYSTZzycFquyPDZqeZrjminrrqMQeZs08+zwLmd0cyflSCXCCBme9vt1kWIuM3vzk7x2gc0zU1xKC3fbRZy+FaGakG9CXXvO24p7ewcUzW8NBcmYRO9ESyZ3k0tjwQYtTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745906751; c=relaxed/simple;
	bh=0cbPfM+xl68H93U8jlx/AarfUyY20kVeH/kTji7jx18=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cvLZxGKjvJjAWsMkbIcTXokZNSTsqk/v8r/+Bvuds+pkOCp53+51iFA+cp71df6oOQdfRY0uIYVtymwSjPEPSuCRPE06mAyiDShCO48+9+ulSP3FFa4UDLpHYkDEPJjShucxVf9KGPLnKwc76kpjE7kQ6l5Q4s2sKcGud7xNiLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qzur8Qsv; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=woYOFl4C; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745906749; x=1777442749;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0cbPfM+xl68H93U8jlx/AarfUyY20kVeH/kTji7jx18=;
  b=qzur8Qsv+0jy1bvn7b7f3mq/qjiVdO9JU+TvAgA1yYfDutOm4UCl3eDw
   UpHotehNXcqv/4o0byXsv+xxp0DKelI2Dq28mLIiTYQbUcxTxJBKiSng3
   eLSiK1ddy3y11TOMlSkrsXm1oOyPpmGAL1z0p/+h+0/HzKRTZjQxDDQtT
   T9oYQ9BscppjmuAH1LqPQrsoJUwYAFlp28AhKcvRgKksAleoZL0VDSafZ
   lndYO8MzlsQyTCSXIaeHtZTAY8LiOFVV7Qf6eQY3LFS22uI3gJJOq9DVU
   xEaYW33STkQntw8E++eYERFeGJndBAV1MeGKmkjh6xitMcqIectNKY+Af
   A==;
X-CSE-ConnectionGUID: 73e4TAmvRYCNZVglXsrc4g==
X-CSE-MsgGUID: 0JXelyF8T8GQlRIECUNQSw==
X-IronPort-AV: E=Sophos;i="6.15,248,1739808000"; 
   d="scan'208";a="76785587"
Received: from mail-northcentralusazlp17010004.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.4])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2025 14:05:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dhi+slIn/dnCg/rlqxk2h6CYOTpGKu711/9tPTmSoTh+/v69bDkkJdur4SsU9TnG2e/m3yJXwFYl7Lqk/YE4B3A+bSsuAGh8l7+LdqyCPsEgajrZAAuTcnjYKc2Cw33p4NxbNsYI9cIKcK9CMSdqb17O3Nd4b2QoCJMDsK5300xfGyot/Ge0smfW1yCy7DJpMZJgfJ209OFiFrmiQ1OR/7drSrjsbTqw+01QCOynszig8iyOLYMcw4YsUAKN8cSeJ/DWYjkAY4C6v4Kb050TtUR0a/EpfhjQ+RbcoWOTQMo/fnVz6Gb7qmgg7ZaS+ZeuTcPKgdGXZ9tX01KxrmNoQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cbPfM+xl68H93U8jlx/AarfUyY20kVeH/kTji7jx18=;
 b=MyulSvt9HQCcsCMyMJ0e8sIeI9jnaR+9goS1NUjyVOLtpusQg+1t5N6lOx9CseQsYwKO0Nm3sLs89+Wa0CJtV6s6nBCSqrwawCqZ1w6DIVkCbJ3J5QQ4zdPrS/zHRGcGRNQVzhDuYUwtTgE6b4c5cs8WRSy1A6RBrHAbU0ACrCq0yavETGad2y7X/LN/iaJ4bCcpNZ8hI+smfPw8FgmaUlm3k90MD52iC+b6dnHjfOiIR1HsGhF87dG8pXP+uZaiQav5CCpxFa674G2gkF/uxRluBWIhwZEvTablkKNErLGnNjbu0LKT8AY+BnpBwZ3x7RqGxrsx5jfFg3YNAcicFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cbPfM+xl68H93U8jlx/AarfUyY20kVeH/kTji7jx18=;
 b=woYOFl4CYndmDdU1wwayJlpXWEBXWbo7OLkN8bHGjd47fw408F2tYCxUYoqMi232eyA6eTDuhqgXVJYtljXXvqDnyHV+DqYtOvS6CFX94tbZyIDJEl/qLyxBpF5NfW2dRkHPWQYzXtTZA+dm+XGyfjdqukyLNAYNfUJH20IA2JU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB8228.namprd04.prod.outlook.com (2603:10b6:510:109::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.35; Tue, 29 Apr
 2025 06:05:45 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8678.025; Tue, 29 Apr 2025
 06:05:45 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>, "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "frank.li@vivo.com" <frank.li@vivo.com>
CC: "Slava.Dubeyko@ibm.com" <Slava.Dubeyko@ibm.com>
Subject: Re: [PATCH] hfs: fix not erasing deleted b-tree node issue
Thread-Topic: [PATCH] hfs: fix not erasing deleted b-tree node issue
Thread-Index: AQHbuKRPFQ4KE6q1JUi+avNRcVOcRLO6KDMA
Date: Tue, 29 Apr 2025 06:05:44 +0000
Message-ID: <78d3899f-5e07-4a76-8135-81cfea3b0086@wdc.com>
References: <20250429011524.1542743-1-slava@dubeyko.com>
In-Reply-To: <20250429011524.1542743-1-slava@dubeyko.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB8228:EE_
x-ms-office365-filtering-correlation-id: 213f5547-f178-4588-5c18-08dd86e3e126
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V2piMGF2SytOVkthVklxTzU4VjJMQmxZUk53aDZKMEpTUHVRMi9kYkZudjVq?=
 =?utf-8?B?eVFJazUvMjA1dnBhMlpZZGowWFVFSk4wckdNeFdPUVBrOHVjdldVdmljRlZ4?=
 =?utf-8?B?ZWl5VHhKTTFyNnNQR0ZmVGd4RXZCdEtXWG1UcHpJQXcwcE4zWURkeG80VTcr?=
 =?utf-8?B?TkdPNU1HQk1nblVORXg4TEl2ejB6Z1VVellVcjJaZ0tYKzZQTW8xZXUyUGZn?=
 =?utf-8?B?NXBWdCtMMGs4a3pDMmgwckRpM0xXNlczcU1xWCt4OXM2RmlodTZCQVZjSmJv?=
 =?utf-8?B?UHQyTzkwd3dtTjRDeWw2OHlqV1I0cTNGYUN5K0dpdVpKVkxMMkdwbTV3ckQx?=
 =?utf-8?B?Qkp6RzVNRUV3SFdNWkxIbEltRVcrS2p3OE43WmhQaVhwWDBOK3FyaHF4U0NO?=
 =?utf-8?B?OTgyVnpCa0JiVkNQTGNtcGtQa1NjaWNVMUlnVlhmY1hmWHkrcFpWVFlzTThj?=
 =?utf-8?B?V2JUMXZodERMaHd3YXdlUUgxWGh0ZEVtSXVGM3RiUHlGSmluOFVCUURkRHJU?=
 =?utf-8?B?d25VQUd3cW9rU2Z0R3RCVCt4U2ZVVEprWjNldWdPaEdKWHpGQzZlS2lJamFH?=
 =?utf-8?B?SVFiZ1hCOG13OVlSVzB6UUo3Wkttd2R0S2RZZmxoU1JZQnV3dUs5YTFEVW82?=
 =?utf-8?B?cnV5cFM4SFY3MUFlOUZOdS8wdTBFQWd4S3gxeXZtMVlVa0F5eFRSZi9GRkhR?=
 =?utf-8?B?Y3ZYRnZoOWp0RDAwWjN2elNnSDJETmJDdEovQ2tSWGdVVENWUVcvdVBudDFE?=
 =?utf-8?B?NjRQVGNORE5aL04ySjRzMjVZS0huRVhqL2U5Y1hjckxJb0todmlWbHcwK0ht?=
 =?utf-8?B?Qm9KTjNBM201WGxOZ3ZGZlJxd1M2empucERoazJ3eEdZdUZXM3lldWFBVlBt?=
 =?utf-8?B?RnJla1RzSEJWbGNtT2JKaFBXeHFYdUV4S2pXeWZSbHNBZEoxaU9JSWpacWU2?=
 =?utf-8?B?aG5pRW0xZm1vTy92S3loMXBhSHArQStkMVB3ZnpLaEFVa3R4K1A4VlByOTBF?=
 =?utf-8?B?N3pNTkRNWTZ1UXNRUEhtUVNDYnBkdjVKOXFrNTdkclVWMVIrSi90NlFML2VT?=
 =?utf-8?B?MCtUSHMzVWdWSVRnV0NLQ0plTkNoV0o2RVJuM0FoUUVzVEJmcHVvSlBJSkpV?=
 =?utf-8?B?Ym1PM0dhL0NuaWhrNnF5VVllN25JQWNBV2xWNzMzYmFJRDhPRE9Ld0pxU3BQ?=
 =?utf-8?B?Q1VwM3dMZG53TkJkVGRHK1NLNERGSXBwbXNOb0xaZzhNak5YUUVNbUU3emhl?=
 =?utf-8?B?ejVveXhSc3RpS0tlcGlBaDF1U3l4M3o4UEk3RkRFcklJZ0NXb3k0OFdJanZl?=
 =?utf-8?B?dXVwb1R1ZEkydWo5TUdjQWltSEo5SUdZUDRWcjhFenBwbTg5cXROWTlYcUtl?=
 =?utf-8?B?Z2RwdU82VkRRSXZvTkhZYWgwempwRzB2TU5jN3A0UHF0a2I5a3pNRnVzSThv?=
 =?utf-8?B?bCtOdjRZam5CaHlIN3dyWlpaTytKRnFsc08xLytSTFB3ZEhvSm1kbjRCa3ND?=
 =?utf-8?B?eVV3NVU0bHJ4RUhKWDR3OXJRbkR5ZitIRmVyYVZDRlo0ek14ekZwV0Q0ZVhn?=
 =?utf-8?B?eHVhV280aXJjd2JTVE1OOFZQL0c1Vng2djhOVmp2dW90cEdhSjRvNEZIUjBw?=
 =?utf-8?B?T0YrbFFUQ2YyRWFpS1NRLyt1VngvbnZBc0RkdHhNZmNza0ZFT2NLVkczaTdU?=
 =?utf-8?B?RTFNcG9GbGhmY1pqdDhHbE1QcEhoL3FUMlI1eE81R3ZjNHRlaElVcGlKOEhx?=
 =?utf-8?B?U3FkK3pxT2JJT2x2SkhYV3pLWnZGckpJWnlGcEZMT1U2NkI2THFzSzNLQWxW?=
 =?utf-8?B?ZFVMSmlnWW9MWHdwSUc0ZHBuRjFCdEluM0V6K3F6emdhT2NLV25xRzRPRlJh?=
 =?utf-8?B?WW5NVG9yN1NhVUxRdGtUNkpOYk9VeDJuTjlGLzNZSjBBV1ZiU05NUXVuVHBq?=
 =?utf-8?B?dnlnaUFnY1N1ektLQjVYSmtkcnVKRHNBNnN4NlFGbFZiRDNlMWNSQWMwOVUr?=
 =?utf-8?Q?GEagQQN5C8dHbM2rUOEEUNQC5vSLYI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cXdaU0xNQm9GcFA0alJYenQ3VUttcDlhSjBYbDlvdkZWd2dGQi9JdTJ2QXZF?=
 =?utf-8?B?RmxKMGxBQUNjbXZKaFhueFJZaVloaDBrdFZ2WEVMbjU1L0xEd24rMzNMUlRO?=
 =?utf-8?B?NzNsRWN3Y2w2QlJCWFNsclVaQnZmTUEraTJ0TXFzcjdPcGVJa0hUei9FNWp3?=
 =?utf-8?B?VmhTekFHdVdVNXlXVHFJMDNsNFdWKzFremxOWTRrcWRvRVo5RXo4OW9sNEFq?=
 =?utf-8?B?VVV1VUlDK09yZ2VuZUlYK3FTWnJvcUJmUURNVVpjM2YzSkVMaXVzSEdKaDBS?=
 =?utf-8?B?QmhBVUY3N3RKM1NYckNvWXVJbHdjVWxjNjhHKy9BdzZZaUduYUk4Q3RhYlc5?=
 =?utf-8?B?WTV6aitwTWNrSXE3QjJMS3V6WlNuaW9TTUNkdFZkSkxGS0ViSFlRdCtJT01D?=
 =?utf-8?B?U1lDb2d4b0NGUHhiWVZkTmZROFpIRlQ3WkwrNDZCTzFNK3FDMjdPV0pzMHZR?=
 =?utf-8?B?NjZ1OVJnZ1RrYXozWnZ2enozOGd3Wm0yd3M3aXJTK0ZlUk5zTDMwVWhleDYr?=
 =?utf-8?B?dHphUmlORE5ZT0IxVGYzWWsraHdmNzZrdmhLdnlZMUFMNEN1U1Y5bGxuaTlq?=
 =?utf-8?B?MUxXR2VMZ2V0RUJjQ2ljbTNHb1FwNlBlYUEvK3kyTGh6VnZLVHhhekdIMG9Y?=
 =?utf-8?B?anhyaHhNOW5MTU5xUjFjZnJLTkNSN2dHMWUxSHd6T3JEd1FlN2Y3WUlnUkpH?=
 =?utf-8?B?Qnh5d2JxMmJlNDkwdmpxM3Vzc1RjRzZ5NW1PYTdjWWtWZ01YdktYSHQ0eE1o?=
 =?utf-8?B?WGZpNXQxeFZFaHI0MlNrUy9JcHhLT1RMdThJOW5KRjJOZzRLd28xQlNJUExm?=
 =?utf-8?B?c0JPTnlzN2Y3TGlNNkRBdzBBdUZzanp0WG84VUQwZjg0STExU1hvSFRpS0pP?=
 =?utf-8?B?MG5OaFlnMllKYnB5Y09RT1FETVpVZFl1dEw4aTRhbnI5WmMybjhiYkMwZTJh?=
 =?utf-8?B?c1BEeWRKV0tWbmlRL1Q2QmpaVmF3T2VEbkNPVHE2K0FYWDdxU05KTFNwWUZh?=
 =?utf-8?B?L0JoSUx0L1VRdWQxSFdBY0ZHMEdnN3hHZURpRGEydUV4Tnk5VjRTTFVyS2hk?=
 =?utf-8?B?b3ZSMk42Yy9EZjd5SlUvTktCWFdjSFl3SkpTaVFXcFlKWDBYT0FXdlo2SXV6?=
 =?utf-8?B?WnFMNTU0ZlQyT0JiRytMZFpyRUtiTWJoZ3dYRytBaDBCcEtqOEcrZTVTcWc5?=
 =?utf-8?B?NGVVcVB6eUtJQ3NkZWhJdGFlU0lSazdLYVA4SVA1cnpNT3Y4MmVSYnVyMTlD?=
 =?utf-8?B?RDhwcThRMGE2SXNRTm5Ob1I0ajZzQklRY0cyS2NnR3JXM2FEZnVTYURYQVhK?=
 =?utf-8?B?R2dNMWovOWF2N2pjcjNWSm5aamlXNHZPUmJPS1gwOUl5SzNHR2NkMUhNSXBw?=
 =?utf-8?B?b1VQeUdzOGF5YzR0Ry9peGJKY1dJNVU0OEZTUUNqNkhJd3RpcTNFV2RBOEhq?=
 =?utf-8?B?aEVpa052Q1hscnNvaHdGbHRHUzBMcCtaS3poVzZUNmJidU15bjE3Ri9JcnB4?=
 =?utf-8?B?VFNJM0pQWlVtTU1MVFZiR2ZtVHlueDNyRXFjYzhIMTZld1VoR1dvRkI4NWFx?=
 =?utf-8?B?ZnFQZmtvRUpjbXdHMFl2N2VCNUpJeE15VWI5UkZNQWZtUnAyS3E5bGFjVWpQ?=
 =?utf-8?B?bWM4VTErbytjaThDdjBVZEdiS2U1Y3V5enkwMnpiRUpQSzFkdlAzay9PVDU3?=
 =?utf-8?B?TEFNK2h5SWFGQ0RWQTE3WjhOS0NqZmZIWEZ1cjdRTDhsT3FRcERrdEFkcXBv?=
 =?utf-8?B?T212QmdDb3BXM3JhQnJiWUtabUozcDFIcUg0RXJYeTlzeXdnZFBML3ZrMkZT?=
 =?utf-8?B?dHZwVFNXSk1jMmppVlZWemcwak9pOTIxVm1aeHd2WUs1SDNIN3FGY3JQdlBH?=
 =?utf-8?B?ZjU4QTRUYm1pSzRqUHRjWG9qOW5IVU5zem1GVzNmQ2pNMGhLQ2ZhbUFTdGcw?=
 =?utf-8?B?VzdaaUEvdjEzUEtNaFpWN1gwZUlIbmlUcENUQnRSYmFSQlRSdWNPSXpZeXNM?=
 =?utf-8?B?OStIcDFPOUsvek5pZjU3NmhpVm5GRXJjak1jSW5rb2U2aHdjc1Fvejl4QVB1?=
 =?utf-8?B?c29xR1RyZjk5ckprYzJLeFhvNjhiZ2ZNcUpweWtmZU1IL0lSZ1AvUWdPZ2hh?=
 =?utf-8?B?WUtlSUFNNkRUWmoydkpLVEZQY3gyZnpuc3BtbjR5TlBLVXRycUNuOGRiSTlt?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <952D8417A058AC489E2C1C94CF6A6DAA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bIb7u3hiCNCSeYCdw1g6jiBoDY8i1KRgnz9nibyI3sdVy7gsximC68wM3Tzb6LM78tklARo31ZUJcYfIH5vIMIZXKUzPpBdQen27st10z5NG1Jp2XxEj2ktUVnOHLc8khDtifzANbnPIz7IFP8YwgzsZvnMvxL735gSeWFpNdnN0KXM4iWVdvByul5MJbroKS9dKtNQX9aJZLO8cVJxrpq82ClHNytR2s3l7B/YRtS6Sx40QX7o5/0LOs4QmbBNeb2EQBP11uXKSUmVTPHImLMwg0nyre0oQTM7Vdd8yXjikQeajKBdzFNtQ9NDOPy5Ex2JDDrPipPjeqsvVffS8R/Q+eBRC9zlWqCy0e33Yr6d6OYtzXwLrt/X1frgPG2ShEzF69oDnkRSPpP89Q70be4RAwMlZRvDYOpInBaVDNqJcILpdXUMSchBkiEhrsglsgw2Lz5vyDXAeEaDb3jK7h3IVoAknOvcvfqQJ9ZvJFtl2jWaFMS59Xd0c9SEbRaD/hXwz5QbzPwmwfF+aZrLsV18R9AiXKXgGFvPZLslFDi0NS25dbBPTVhJC+YyseyF/R14JeUjzGirzltVVcJmA5DLN5MIR+0e9lWCvqTUgfc2EWfZp9K7UtzUa9nUZBIcB
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213f5547-f178-4588-5c18-08dd86e3e126
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 06:05:44.9314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AlVwHlOtFPnZcgKX7jWyIYhtECDV9iLQw6GGxdndQGsllSV2UavS7U2PJbAv+lwHNKQOEh23uczdQD/ekI2hyaLvEEt5vw0fPJMSm5QUp9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8228

T24gMjkuMDQuMjUgMDM6MTYsIFZpYWNoZXNsYXYgRHViZXlrbyB3cm90ZToNCj4gU2lnbmVkLW9m
Zi1ieTogVmlhY2hlc2xhdiBEdWJleWtvIDxzbGF2YUBkdWJleWtvLmNvbT4NCj4gLS0tDQo+ICAg
ZnMvaGZzL2Jub2RlLmMgfCAyICsrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2hmcy9ibm9kZS5jIGIvZnMvaGZzL2Jub2RlLmMNCj4g
aW5kZXggY2I4MjNhOGE2YmE5Li5jNWVhZTdjNDE4YTEgMTAwNjQ0DQo+IC0tLSBhL2ZzL2hmcy9i
bm9kZS5jDQo+ICsrKyBiL2ZzL2hmcy9ibm9kZS5jDQo+IEBAIC0yMTksNiArMjE5LDggQEAgdm9p
ZCBoZnNfYm5vZGVfdW5saW5rKHN0cnVjdCBoZnNfYm5vZGUgKm5vZGUpDQo+ICAgCQl0cmVlLT5y
b290ID0gMDsNCj4gICAJCXRyZWUtPmRlcHRoID0gMDsNCj4gICAJfQ0KPiArDQo+ICsJaGZzX2Ju
b2RlX2NsZWFyKG5vZGUsIDAsIHRyZWUtPm5vZGVfc2l6ZSk7DQo+ICAgCXNldF9iaXQoSEZTX0JO
T0RFX0RFTEVURUQsICZub2RlLT5mbGFncyk7DQo+ICAgfQ0KPiAgIA0KDQpIaSBTbGF2YSwNCg0K
SSd2ZSBqdXN0IGNoZWNrZWQgSEZTKyBjb2RlIGFuZCBoZnNfYm5vZGVfdW5saW5rKCkgaW4gZnMv
aGZzcGx1cy9ibm9kZS5jIA0KaXMgYSBjb3B5IG9mIHRoZSBmcy9oZnMvYm5vZGUuYyBvbmUgKG1h
eWJlIG1vc3Qgb2YgdGhlIGZpbGUgaXMgc28gDQp0aGVyZSdzIHJvb20gZm9yIHVuaWZpY2F0aW9u
PykuIFNvIEkgdGhpbmsgdGhlIGZpeCBpcyBuZWVkZWQgdGhlcmUgYXMgd2VsbC4NCg0KQnl0ZSwN
CglKb2hhbm5lcw0K

