Return-Path: <linux-fsdevel+bounces-78781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBORMBX9oWl4yAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 21:22:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2784E1BD916
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 21:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A42931FCFAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 20:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87676477E44;
	Fri, 27 Feb 2026 20:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fx4JJiZv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB417477E3D;
	Fri, 27 Feb 2026 20:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772223096; cv=fail; b=bFjOW7FRSnrVvYwHQwYKUpx/bk79VXb0X2q7i5SGSLj/b+JWMS4pDNvmaJk3dj2uirPkxA512iPw7cAHJhrp7F+MQRXwGpq3djuXf1ph7/qb5RB/5uj8aZGDEodvS+d7N+9Bri/XUYxRUghKVc5J3hW6r3xp4E+uH73mNZ68VVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772223096; c=relaxed/simple;
	bh=D4rDztIhGs3jv0DRZwrobBc3lwwYfGFFBSLC1W8ZaxI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=sdStAe4nmTrI5ItUxmK9gSFppZ7t7l26ijeaXhNET4WdbBai/DZcsGb14KbTVh02SSBiYk4uh2cFGrn+nJabeHe2Ah6h+W5fcuCvuDCOGvvn7NKgpeh4LB88ookMwG+af0U7Pn4iZxv2zRz9HvNB6G1AzDCP0RT7o1E/YRxD5z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fx4JJiZv; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RHMDPu1745446;
	Fri, 27 Feb 2026 20:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=D4rDztIhGs3jv0DRZwrobBc3lwwYfGFFBSLC1W8ZaxI=; b=Fx4JJiZv
	5a5qfDhtdFu/RH+fzD9Ww9Ry8YY10TAsBf0ETyvfHe4oZl5sfsYOmLkaOZqFLdh+
	YtANfFihdwI2fOlP+nPzkJMAtGIdiD0oh3tBbsVJ1tUq6p2/W5X8v7c4ekmlrJLy
	UC7to8D2wSeuqKO0QeOxGNBkEpWkL8TFXrRdnRjDylKl8ahDLhVgomvqjvJvmNAh
	pCCaU1apy9wxQS451OZ8ZPQs0yfvTuMvqt8bg9tb3XyK2Y1DKd/Jbamur3U+w3Gb
	zupwvdVNCkvYLMmYX8yC0yLNtCuQ03XG35xtm2TV/J6jDOiAn5I7zMB/EcvXaMqF
	VS8eHlQY/z3rDw==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4crecww-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 20:11:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7h1JWtM6XkO2oMOr0a/mV3mMSbJD6HnB5wq4RX4sORdc0GP/Ok0E0udUB+Yn5Lg5Uz1GUIku134sEA+83E+7CYmSKF7ZEIaQ379Ps+WpyqulFPtOeP5h60nke9rsJX13NNJHpLuV891MC7/J5xf7LyyaXZUGz4sas5XLw0WdIc49i+WyL5/Qpx7Td1jBEos53H305aKqZwjkir5uOLdKaPE+UXEE0y9gaLv5TkzXgft9Irkp5/l9TWPQswXjZAPMQ8OP1p37ZcP9Yw4o6L6ooQ/sL9YqlKqrEhmYBZJMsw4P9l5q8BTqhMFGg3bcqneXA8W0icm5La8lxaVvuLsPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4rDztIhGs3jv0DRZwrobBc3lwwYfGFFBSLC1W8ZaxI=;
 b=VNwo5zQvyaVGZPCWk741EDf5+MO2OOYchsqXkflAUjU8FDkt6r0plB0UhnWARqL1EzJPM0PCoDgEwFSN0YKVi3aEWWfWn6k0/i1vmCn77DTmvFIvSpAdj7nNMLoqtJ3/TQXtUBDLCQMoFfNNarV56b7hzwapT9hLondh7haiacy8imZGvlW2AhTNwhz8B6ju0dNz0yDf8Fjc2PWsispiQl8e6daWyLY5i4JlBRRWGpoXw6j6NDStT/bZ+XtKH2Mlco9AJUdIR5J6yVyNPfALOLltMoGyea36DKRcVUvTIayo2ZTgS8ghPA21ZXEgdAClmXQppNPtrbCIfSoTyNodzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS0PR15MB6784.namprd15.prod.outlook.com (2603:10b6:8:30e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 20:11:21 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 20:11:21 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "shardul.b@mpiricsoftware.com" <shardul.b@mpiricsoftware.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
CC: "janak@mpiric.us" <janak@mpiric.us>,
        "janak@mpiricsoftware.com"
	<janak@mpiricsoftware.com>,
        "shardulsb08@gmail.com" <shardulsb08@gmail.com>,
        "syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com"
	<syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] Re:  [PATCH v4 2/2] hfsplus: validate b-tree node 0
 bitmap at mount time
Thread-Index: AQHcqAtELWTmExdlbUe6qP6CB129A7WW+mIA
Date: Fri, 27 Feb 2026 20:11:21 +0000
Message-ID: <9f6e83c657586caa86483db77df401a67f903361.camel@ibm.com>
References: <20260226091235.927749-1-shardul.b@mpiricsoftware.com>
		 <20260226091235.927749-3-shardul.b@mpiricsoftware.com>
		 <5deb0aa2971a6385091c121e65f0798de357befd.camel@ibm.com>
	 <7d3c9221cc49a47779606d8c67667544f27de2df.camel@mpiricsoftware.com>
In-Reply-To:
 <7d3c9221cc49a47779606d8c67667544f27de2df.camel@mpiricsoftware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS0PR15MB6784:EE_
x-ms-office365-filtering-correlation-id: 4dc775ef-360c-494d-4c2d-08de763c6029
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 brZ0jbd7wt6HHbHuARBiVqdairmgh92JMDgELijByoqrAx4aDMGBC+EY7IvkaqU3cD2tyxEN5lVgp+LhfhH4TLuQBG5uuf/UXvKCcA7U8ZMFwB+CUnikfz6C73kk4AHaAbmoEDyxPOzmXjHzSIhlXk7MqxSXGAowC8FtJ29w2H6RDukQ6RMEAHNLgEeXZ3JAlAzsDhFWwue2vf/xDX8wLuc17JGd5qknNyTQQdD/JSBrvhl1H8csCCv7n7fhW7A2FRJPKkrNIgIs+t/+F7z3mEkjdjo7mPn5uUq+X7YsWdGBqimHpxjkyzRuGK96EiL5WvT7r2wmSmrGaORoSPaAGD9y/W5OnOzcD+XNXqFI7w0DPDGR839MjTyJ+7kYoY+qveoT/NXesJV4ZvIux6dYWn/WyCAVOkRuXtJnk34F5BsuBZNV24NZUf/usVOm8lJy+a3NAGYGtBYJ21UuZhQo85onvkUB9X0CoA0wk/a/hlgTu39ljGzIn4kj2fU/3ayrNm9ZYfk/+ugjp6htxxnnjAh6KwWKSOQ0FR9KMBPhinHBHq9OH2uqlDKsQZK8a98Wfw3r/D8XESyKmNJk2bYF5bSbXuPn/8QmBpXrK5fG8TzxbOdS0IzRGLcHiAurn78duOKCM21OpZMqOT9kUgbW7AbaRCSp+KMXWx6QGVRwDmcPntVn8tmSBUn7hZTmvnIceTATk/RhkEWRLmmVknU+ii/QLzEyZJcNZvcikMjf/jQT/NtosZMckP9JQKH7ANnVQu/3wpdG3yVsODj8MHp4HBekcP9837DyDL7zc7m6tT4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWp5T2pKUzhQaVA3S2F4MDBqNk5MMU9mY2UzTzV1SnY5TnJGWjVWLzRWZTJ2?=
 =?utf-8?B?eFVyM3F6dTFSd1U1aldsQzRaZGl2NUJVZ2E2dGVjeUxIS0NCTVBpNzV0Sldr?=
 =?utf-8?B?V0hUWkh5L3g5YVBjSDFLejBHTnp1Y1I4N0ljcCtqblhrQmFKQzFLaWRLN081?=
 =?utf-8?B?b0VyZkQ2UG1VQUVvMzBsVU5POHFyYVpmNVZKTzQ1UzlmMUsrblRWTXFmVm5L?=
 =?utf-8?B?RUxNdW1peUJBMEd3blhZS1RSWkxNQUJqLzRabGlXMTVkcjlMS1dOaS8vekll?=
 =?utf-8?B?UGUyU1JRSVVTWDVBT1lHRmZvVzVOa3BrTkJ0b0gweVVCbnBkOWo5WEp0cEd1?=
 =?utf-8?B?WFFWUlJuSFlZaWdFRjFHWFNiSThRa1MzVUNPMFB3WkRETTEycks2alBjQ0Y5?=
 =?utf-8?B?NkxNT0MyRjF3VmlKaU1ZclBFZUpDU0VJMU1ZVTc0Y2ErdHJPQno2SCtqdnRq?=
 =?utf-8?B?TVNJQU50UFBKNTA1ZFh1TkNleE55SlBlODRnbzFsOVhVeitzWUM0SVF0cTZ1?=
 =?utf-8?B?QzVrYXFXWEEyVXhjRmx3dit2WjdVN2phM1lBckQrVFpYajk2ejlEc0xZbWNY?=
 =?utf-8?B?L0lZbXRIdVlMSnFJaURDdWliR1JlRGNuSEJ0Nk9RNDNhN1krVWVRYUcwcGlq?=
 =?utf-8?B?ZXhvQVo5WDZreEpTcnVNZXFrdS9NdE5kYlJjRHphY3RYbFNjV09QUmxYZHho?=
 =?utf-8?B?bU96UjlUOWNZdm9la3BsR1BISnMxU1BBNkNNRjlkT2NqWjJTYm5yamFlWWt4?=
 =?utf-8?B?andMaEN6UXMwOHdqbEwxRTJBSWpoU1lLaFg1Q2w1UWtvb2tManVKc1dEdzVq?=
 =?utf-8?B?NS9zaFh5WmM1WVVCWFFTNmNGVmVvMGpNK0hxeHpnaXBHMGJ0RU9Qa24xVWQ4?=
 =?utf-8?B?K29rS1pwZU9ZK1VzZzh6aCszVzdTWVlDVEFod1h4RWR6UHJSYkRidzdxKzZn?=
 =?utf-8?B?Qmc1akhUYzBCeUhWNXlHVzFUclVyTFdNSVNoeVRiRXNNa2FZK2lOZmlIdDVI?=
 =?utf-8?B?RTRlMHFZUHM3ZFJKT1d2d2RsWEMrTDQ2SUVJaWdSNVpQTHZHb1JqSUZvYXNt?=
 =?utf-8?B?T3J4YXNDbjQxNzVvcmd0Q3FkSVJwZDZpR3I1b1V5N01pZ1I1SElTb2tweGpD?=
 =?utf-8?B?VVVhS3hnYWd5a1NFTVMzcWFQUElya2t5eHFGaGk2cTlhY1RGeWJnWTZnOEJ0?=
 =?utf-8?B?OHJGdnQ1RmdROFZYc29haGdVVjUzb3JTa2lJbkhFakt4WkRNVUtVNEVrSlBQ?=
 =?utf-8?B?N2h2ank0bXpVcmVJUkYzQ0F0SUZTYVlQZGNkOFFXSllpWWY2Yjl5TnBHMlpo?=
 =?utf-8?B?czJTNzBpVURtOElBUHREeUdITnVqMzhFOHN5SWpmd0hZN2h3TjJ2U1RZSzhV?=
 =?utf-8?B?WjFDc3JDUDZ1T3BMRHZ0YmU2TlBWWnNTSGtqSzdvR3hXM1ZBK0JkOCs5Y1Jz?=
 =?utf-8?B?U3FVYWNMV2doOFVRRnB3dzF2WjQ0QWpvRldIU3BWUERUakpNRnFYdnpDbldY?=
 =?utf-8?B?Y2JjTkVvakRvOXNsYzc2bTF2SDFWVGlQQ2tBMythdm0xUGFPVjdXVDB5am9t?=
 =?utf-8?B?cjJtV2FpMllPbWZ6Y1MrSGRrdTFvVEtWaFNpSE5IZk85OHpHN3ZlU1I5OTAz?=
 =?utf-8?B?TVZ2bEJsOEJZdFdZbzhVSVA0djFJV2psQkgrZXBsSUJ6aGo4c0VyY1g1NkV2?=
 =?utf-8?B?dzNFRklieHFscmNnM2g0LzAyNU1DSmpDL1ZubFFiVkNKUU5YNEM0Y0d0QXNJ?=
 =?utf-8?B?R0ZsYU03TGZrcTNTTk41eEd3aVRXU3VYeXdXTEo4QWZpbGI0TkQvdnBlMmk4?=
 =?utf-8?B?S0tadGl1WWR1eHhCcEppOVNZOHZadmVsbUY0WHkwellSK1hCRTJ1K2J2T3I2?=
 =?utf-8?B?Zk51b2Irdnp5ZUNyNVRvcC9JTDBsYk1QVGZUR1AvbDI1dUMwbVowMnIzOTJG?=
 =?utf-8?B?aGkrVG5lNjRjZTdheFFoRDZyTXA1YXBXRm5pWUJmS2NpQlBpNkkxZmdwd3NS?=
 =?utf-8?B?OUJob3hDVE1LN0NkekczRHk3WE85ZHR1M1puWDJHOWtXUEliZE1vUUxzMnc5?=
 =?utf-8?B?V1RCL0k2U0MrVTFrc2gxQjV3RGZVVXZLWE9aS0wyd0svVGtQQndyNTZ6VkhS?=
 =?utf-8?B?cDd0bEJUTTlTRWsxWXcxUEhreEY0bHNTbjFuRnEyUkFiZkNvQWF4VXp1eHN1?=
 =?utf-8?B?WXA5SWdHeU8yQ0xFaEZLa0JEMU05OGY3eE9yaElWaUdQeDdDMjRMSFlYcWpT?=
 =?utf-8?B?Zjk1K3h3Ynlha0RNQTI1VExBQ3o0NEk3NmRGM0xGS0pUTTB4V0ZaS0JqOWpS?=
 =?utf-8?B?c0ppNXpocGhEQ3V6QnBacjlEM0JHWEh6UmVXSGFCOFMyOWE5clZXSjBVdVRl?=
 =?utf-8?Q?U7Fiqc4se87ZlznLzgMlzBqqMBTXdUqhBm9VE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C1F1A76119B5F44A990168CB767A89D@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc775ef-360c-494d-4c2d-08de763c6029
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 20:11:21.6409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 22c6K3JiAxZ+y54mFnPl0eyu81NM0sOmvsfFcuoCySvvpm+LTB1dX0PPeQrNjXZS0ukJwRym/yLTXE2C4qSA5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6784
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 1AOkYoNwIg7L5I6J5El6RrnXEaZ45Zul
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE3NyBTYWx0ZWRfX35L1ysgGXhIO
 xg7cxSumXhDu4hYuaB2hodRkic+QJMmkSTP/Zp2Ar9I29xk4w6WgEu0wc6mswCmG+N5u9wwMTcM
 1m1X3RdHaCZDC6yp4jnkLU2oGBRwh6m9C5p8KwZ3YKdHEQ9VR0P7T7lA1cskSMp483svNfbNAOv
 qgBAx8+yTsMSpwiKaODpgJfNyHF07cuz1vo8cS4o53fUih0PgstExikxH50HGnAOkM3i3AYE2iM
 DRoG2MVUmcgpk79P4KYuwXJGgGA2ni/J0N4Qz4ZW6+AKZwC02ih4mzJzpZaBGjLRiRGKiU3VDhb
 bkucIwmel0bNwxfKeV0AxIOiP5mfmYcsiAHLOWfN7uCamnBM/KW7jVJLI0LuBSHGz8Yp9Dsy8Oh
 JuR53P10QduI92bV7eOrJsQaceWZIrbNYi3Pc9tpS5XaFEJI8O7yd2IrOvGYDcZUndgygF56C7U
 jSlo7aeyMH+ubpzjzOQ==
X-Proofpoint-GUID: NAZpGvNHin3dJjIkblj64kflXw60d8ry
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=69a1fa6b cx=c_pps
 a=7HTsEC4o+G4Ts3XEwqQVug==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=c0KwBOyHeJe94Rc6h3YA:9 a=QEXdDO2ut3YA:10
Subject: RE:  [PATCH v4 2/2] hfsplus: validate b-tree node 0 bitmap at mount
 time
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602270177
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[mpiric.us,mpiricsoftware.com,gmail.com,syzkaller.appspotmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78781-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,1c8ff72d0cd8a50dfeaa];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2784E1BD916
X-Rspamd-Action: no action

T24gRnJpLCAyMDI2LTAyLTI3IGF0IDIyOjM0ICswNTMwLCBTaGFyZHVsIEJhbmthciB3cm90ZToN
Cj4gT24gVGh1LCAyMDI2LTAyLTI2IGF0IDIzOjI5ICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28g
d3JvdGU6DQo+ID4gT24gVGh1LCAyMDI2LTAyLTI2IGF0IDE0OjQyICswNTMwLCBTaGFyZHVsIEJh
bmthciB3cm90ZToNCj4gPiA+ICsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoHN3aXRjaCAoaWQpIHsN
Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoGNhc2UgSEZTUExVU19FWFRfQ05JRDoNCj4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0cmVlX25hbWUgPSAiRXh0ZW50cyI7DQo+ID4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7DQo+ID4gPiArwqDCoMKgwqDCoMKg
wqBjYXNlIEhGU1BMVVNfQ0FUX0NOSUQ6DQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgdHJlZV9uYW1lID0gIkNhdGFsb2ciOw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGJyZWFrOw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgY2FzZSBIRlNQTFVTX0FUVFJf
Q05JRDoNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0cmVlX25hbWUgPSAi
QXR0cmlidXRlcyI7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7
DQo+ID4gPiArwqDCoMKgwqDCoMKgwqBkZWZhdWx0Og0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHRyZWVfbmFtZSA9ICJVbmtub3duIjsNCj4gPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBicmVhazsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoH0NCj4gPiANCj4g
PiBGcmFua2x5IHNwZWFraW5nLCBpdCBjb3VsZCBiZSBlbm91Z2ggdG8gc2hhcmUgb25seSBjbmlk
LiBCdXQgaWYgeW91DQo+ID4gd291bGQgbGlrZQ0KPiA+IHRvIGJlIHJlYWxseSBuaWNlIGFuZCB0
byBzaGFyZSB0aGUgdHJlZSdzIG5hbWUsIHRoZW4gSSBwcmVmZXIgdG8gc2VlDQo+ID4gYW4gYXJy
YXkgb2YNCj4gPiBjb25zdGFudCBzdHJpbmdzIHdoZXJlIHlvdSBjYW4gdXNlIGNuaWQgYXMgYW4g
aW5kZXguIEFuZCBtYWNybyBvcg0KPiA+IHN0YXRpYyBpbmxpbmUNCj4gPiBtZXRob2QgdGhhdCBj
YW4gY2hlY2sgY25pZCBhcyBhIGlucHV0IGFyZ3VtZW50LiBBdCBtaW5pbXVtLCBzaW1wbHkNCj4g
PiBtb3ZlIHRoaXMNCj4gPiBjb2RlIGludG8gdGhlIHN0YXRpYyBpbmxpbmUgbWV0aG9kLiBCdXQs
IGFycmF5IG9mIGNvbnN0YW50IHN0cmluZ3MNCj4gPiBjb3VsZCBiZSBtdWNoDQo+ID4gY29tcGFj
dCBhbmQgZWxlZ2FudCBzb2x1dGlvbiBmb3IgbXkgdGFzdGUuIEJlY2F1c2UsIGFydCBvZg0KPiA+
IHByb2dyYW1taW5nIGlzIHRvDQo+ID4gcmVwcmVzZW50IGV2ZXJ5dGhpbmcgYXMgYXJyYXlzIG9m
IHNvbWV0aGluZyBhbmQgdG8gYXBwbHkgdGhlDQo+ID4gZ2VuZXJhbGl6ZWQgbG9vcHMuDQo+ID4g
OikNCj4gPiANCj4gDQo+IEhpIFNsYXZhLA0KPiANCj4gU291bmRzIGdvb2QuIDopIEkgd2lsbCBp
bXBsZW1lbnQgYW4gYXJyYXkgb2YgY29uc3RhbnQgc3RyaW5ncyBpbmRleGVkDQo+IGJ5IGNuaWQg
aW4gdjUuDQo+IA0KPiA+IEkgcHJlZmVyIG5vdCB0byBoYXZlIHRoZSBvYmxpZ2F0aW9uIG9mIHVz
aW5nIHRoaXMgYXN5bmNocm9ub3VzDQo+ID4gcGFyYWRpZ20gb2YNCj4gPiBrbWFwX2xvY2FsKCkv
a3VubWFwX2xvY2FsKCkuIEl0IHdpbGwgYmUgZ3JlYXQgdG8ga2VlcCB0aGlzIGluc2lkZSBvZg0K
PiA+IGhmc19ibWFwX2dldF9tYXBfPHNvbWV0aGluZz4oKSBtZXRob2QuDQo+ID4gDQo+ID4gSSBw
cmVmZXIgbm90IHRvIGtlZXAgdGhlIHdob2xlIHBhZ2UvZm9saW8gZm9yIGNvbXBsZXRlIG9wZXJh
dGlvbg0KPiA+IGxvY2tlZC4gQW5kLA0KPiA+IGZyYW5rbHkgc3BlYWtpbmcsIHlvdSBkb24ndCBu
ZWVkIGluIHRoZSB3aG9sZSBwYWdlIGJlY2F1c2UgeW91IG5lZWQgYQ0KPiA+IGJ5dGUgb3INCj4g
PiB1bnNpZ25lZCBsb25nIHBvcnRpb24gb2YgYml0bWFwLiBTbywgd2UgY2FuIGNvbnNpZGVyIGxp
a2V3aXNlDQo+ID4gaW50ZXJmYWNlOg0KPiA+IA0KPiA+IHU4IGhmc19ibWFwX2dldF9tYXBfYnl0
ZShzdHJ1Y3QgaGZzX2Jub2RlICpub2RlLCB1MzIgYml0X2luZGV4KTsNCj4gPiANCj4gPiBIZXJl
LCB5b3Ugc2ltcGx5IG5lZWQgdG8gY2hlY2sgdGhlIHN0YXRlIG9mIGJpdCBpbiBieXRlIChSRUFE
LU9OTFkNCj4gPiBvcGVyYXRpb24pLg0KPiA+IFNvLCB5b3UgY2FuIGF0b21pY2FsbHkgY29weSB0
aGUgc3RhdGUgb2YgdGhlIGJ5dGUgaW4gbG9jYWwgdmFyaWFibGUNCj4gPiBhbmQgdG8gY2hlY2sN
Cj4gPiB0aGUgYml0IHN0YXRlIGluIGxvY2FsIHZhcmlhYmxlLg0KPiA+IA0KPiANCj4gV2hpbGUg
dGhpcyBieXRlLWxldmVsIGludGVyZmFjZSBpcyBwZXJmZWN0IGZvciB0aGUgbW91bnQtdGltZQ0K
PiB2YWxpZGF0aW9uIGluIGhmc19idHJlZV9vcGVuKCkgd2hlcmUgd2Ugb25seSBuZWVkIHRvIGNo
ZWNrIGEgc2luZ2xlDQo+IGJpdCwgdXNpbmcgaXQgaW5zaWRlIGhmc19ibWFwX2FsbG9jKCkgaW50
cm9kdWNlcyBhIHNpZ25pZmljYW50DQo+IHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb24uDQo+IA0KPiBC
ZWNhdXNlIGhmc19ibWFwX2FsbG9jKCkgcGVyZm9ybXMgYSBsaW5lYXIgc2NhbiB0byBmaW5kIGEg
ZnJlZSBub2RlLA0KPiB1c2luZyBoZnNfYm1hcF9nZXRfbWFwX2J5dGUoKSBpbnNpZGUgdGhlIHdo
aWxlIChsZW4pIGxvb3Agd291bGQgZm9yY2UNCj4gdGhlIGtlcm5lbCB0byBleGVjdXRlIGttYXBf
bG9jYWxfcGFnZSgpIGFuZCBrdW5tYXBfbG9jYWwoKSBmb3IgZXZlcnkNCj4gc2luZ2xlIGJ5dGUg
ZXZhbHVhdGVkIChwb3RlbnRpYWxseSB0aG91c2FuZHMgb2YgdGltZXMgcGVyIHBhZ2UpLiBUaGUN
Cj4gY3VycmVudCBsb2dpYyBtYXBzIHRoZSBwYWdlIG9uY2UsIHNjYW5zIG1lbW9yeSBsaW5lYXJs
eSwgYW5kIG9ubHkNCj4gdW5tYXBzIHdoZW4gY3Jvc3NpbmcgYSBQQUdFX1NJWkUgYm91bmRhcnku
DQo+IA0KPiBUbyBhZGRyZXNzIHlvdXIgcmVxdWVzdCBmb3IgYSBnZW5lcmFsaXplZCBtYXAgYWNj
ZXNzIG1ldGhvZCB3aXRob3V0DQo+IHNhY3JpZmljaW5nIHRoZSBhbGxvY2F0b3IncyBPKE4pIHNj
YW5uaW5nIHBlcmZvcm1hbmNlLCBob3cgYWJvdXQgdGhpcw0KPiBmb3IgdjU/DQo+IA0KPiAgICAg
LVdlIGludHJvZHVjZSB0aGUgaGZzX2JtYXBfZ2V0X21hcF9ieXRlKCkgc3BlY2lmaWNhbGx5IGZv
ciBzaW5nbGUtDQo+IGJpdCByZWFkcyAobGlrZSB0aGUgbW91bnQtdGltZSBjaGVjaykuIFRoaXMg
Y2FuIGludGVybmFsbHkgY2FsbA0KPiBoZnNfYm1hcF9nZXRfbWFwX3BhZ2UoKSBmcm9tIFBhdGNo
IDEvMiB0byBhdm9pZCBkdXBsaWNhdGluZyB0aGUgb2Zmc2V0DQo+IG1hdGguDQo+IA0KPiAgICAg
LVdlIHJldGFpbiB0aGUgcGFnZS1sZXZlbCBoZWxwZXIgKGhmc19ibWFwX2dldF9tYXBfcGFnZSkg
Zm9yDQo+IGhmc19ibWFwX2FsbG9jKCkgdG8gcHJlc2VydmUgaXRzIGZhc3QgbGluZWFyIHNjYW5u
aW5nLg0KPiANCj4gTGV0IG1lIGtub3cgaWYgdGhpcyBkdWFsLWhlbHBlciBhcHByb2FjaCBzb3Vu
ZHMgYWNjZXB0YWJsZSwgYW5kIEkgd2lsbA0KPiBwcmVwYXJlIHY1Lg0KPiANCj4gDQoNCkkgdGhp
bmsgeW91ciBwb2ludCBtYWtlcyBzZW5zZS4gSSBtaXNzZWQgdGhpcy4gSG93ZXZlciwgd2UgbmVl
ZCB0byBrZWVwIHRoZQ0KbWV0aG9kcyBzaW1wbGUgYW5kIHVuZGVyc3RhbmRhYmxlLiBGaXJzdCBv
ZiBhbGwsIGlmIHdlIG5lZWQgdG8gcmV0dXJuIG11bHRpcGxlDQppdGVtcyBmcm9tIHRoZSBtZXRo
b2QsIHRoZW4gd2UgZGVmaW5pdGVseSBuZWVkIHNvbWUgc3RydWN0dXJlIGRlY2xhcmF0aW9ucyB0
aGF0DQpjYW4gYmUgdXNlZC4NCg0KQXMgZmFyIGFzIEkgY2FuIHNlZSwgd2UgbmV2ZXIgaGFkIG1l
dGhvZCBmb3IgYml0IHN0YXRlIGNoZWNrIGluIHRoZSBiLXRyZWUgbWFwDQpiZWZvcmUuIEhvd2V2
ZXIsIHdlIGhhdmUgaGZzX2JtYXBfZnJlZSgpIG1ldGhvZCB0aGF0IGlzIG9uZSBiaXQgY2hhbmdl
DQpvcGVyYXRpb24uIFNvLCB3ZSBjb3VsZCBoYXZlIG9uZSBiaXQgY2hlY2sgKGhmc19ibWFwX3Rl
c3RfYml0KCkpIGFuZCBvbmUgYml0DQpjaGFuZ2UgKGhmc19ibWFwX3NldF9iaXQoKSkgcGFpciBv
ZiBtZXRob2RzIHRoYXQgY291bGQgaGlkZSBhbGwgb2YgdGhlc2UgbWVtb3J5DQpwYWdlcyBvcGVy
YXRpb25zLg0KDQpIb3dldmVyLCBoZnNfYm1hcF9hbGxvYygpIGlzIHNsaWdodGx5IHNwZWNpYWwg
b25lLiBQcm9iYWJseSwgd2UgY291bGQgbm90IG1ha2UNCnNpZ25pZmljYW50IGNoYW5nZXMgaW4g
Y29yZSBsb2dpYyBvZiB0aGlzIG1ldGhvZC4gSG93ZXZlciwgeW91ciB2aXNpb24gb2YNCmF1eGls
aWFyeSBtZXRob2QgY2FuIGJlIHVzZWZ1bCBoZXJlLiBZZXMsIHdlIG5lZWQgdG8gZXhlY3V0ZSBr
bWFwX2xvY2FsX3BhZ2UoKQ0KZm9yIHRoZSBwYWdlLCB0aGVuIGRvIHRoZSBzZWFyY2gvYWxsb2Nh
dGlvbiwgYW5kIGV4ZWN1dGUga3VubWFwX2xvY2FsKCkuIFlvdSBhcmUNCnJpZ2h0IGhlcmUuIEJ1
dCwgZm9yIG15IHRhc3RlLCB0aGUgd2hvbGUgbG9naWMgb2YgbGluZWFyIHNlYXJjaCBsb29rcyBs
aWtlIG5vdA0KdmVyeSBlZmZpY2llbnQuIERvIHlvdSBzZWUgYW55IHdheXMgb2Ygb3B0aW1pemF0
aW9ucyBoZXJlPyBDb3VsZCB3ZSBlbXBsb3kgdHJlZS0NCj5ub2RlX2NvdW50PyBPciwgbWF5YmUs
IGludHJvZHVjZSBzb21lIGluLWNvcmUgdmFyaWFibGUocykgdGhhdCB3aWxsIGtlZXANCmtub3ds
ZWRnZSBhYm91dCBsYXN0IGFsbG9jYXRpb24vZnJlZT8gQW5kIHdlIGNhbiB1c2UgdGhpcyBrbm93
bGVkZ2UgdG8gc3RhcnQNCmZyb20gdGhlIG1vc3QgYmVuZWZpY2lhbCByZWdpb24gb2Ygc2VhcmNo
Pw0KDQpUaGFua3MsDQpTbGF2YS4NCg==

