Return-Path: <linux-fsdevel+bounces-77384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uZLKGoWvlGlKGgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 19:12:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB3F14EF58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 19:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79D7230379B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 18:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3F02BEFE7;
	Tue, 17 Feb 2026 18:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZCUSDi5U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6749C330656
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771351936; cv=fail; b=KeqxiOKo5XJrG0dSYegI9ensNX/3x25ScS0lBQqLDGgT09g7DPn3s2nxEVhK/gA0YVmDQMsSBhMbs4zYZj9d3gxDmcKl1LAK7jjyH6bI1Ow5LTQpM1INqrmIxfjGP7mb5laqTK948Xtr32JhCF91IVLT9rhvqJjd31ZwVKcp7M4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771351936; c=relaxed/simple;
	bh=TkE1OOOe8T0pvpxeuC6o/IsUwFXdNnDLA20qS+Dh2Ns=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=I17LUItLxrp8S+0WSPGw4X9Mai9U6aZfsFyZa6Equ9aizW5EyvNfgvAhv5sLCfIpLaMgmUBM4ymFKi1c4wtQXZxkUEY//LP2qUYoseklNf9Bj+9ytF0BPB/toPRfhRb9/WQvGgDS3XqhALZh+EdsrjlxwoqDVn7pDUHOVy/64FI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZCUSDi5U; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H9Pak23800571;
	Tue, 17 Feb 2026 18:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=TkE1OOOe8T0pvpxeuC6o/IsUwFXdNnDLA20qS+Dh2Ns=; b=ZCUSDi5U
	OfoBENhsm4ZXdpyCq3JZgV001ftVdBOtS25NRcMcfuG9+q/JRW7wHHBLA4m7pEv0
	2CKqOO1feJ8oYe1TZ6vZ8Ucokd6b0QmWvmZMjSdEMsFYr7qYP1ddeilNRdmxSzC0
	qmixYw/miG4qjxjaZ38lgcyi2MeOn7rfTNB3c1sF5p4QIBQDmIoyXa2fBz8t40HS
	TUAK2cZOuBcC4jsjYULLQOPUn/eEzRCnTeMSTv1hJWaNuEnffKqT8fSKLxZaBeKo
	Zynl9SHkyTm++URmTmGh/D4T03aSuVOMy/biLvJDiS2IZ/uF90uPwhdjm86lQZkN
	cFjerFGrlQ7eTg==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010017.outbound.protection.outlook.com [52.101.46.17])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcjcp6p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 18:12:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IsUXSAtYi96pEauHIBF1EKKL0h3FvK/c/bZWcOJm77uLg1CmoNuXdNqWRvt7nMKUzT41ZX9mEC6P7Z2lRBoQ4/RQSJgRDPvxGaBTppUhFmnkKr8T1vJK+WO0WLDx8lB7nMpHDIXYSD1YbimYmHT0EveaxTrrZAd8BfsCKzc5QtGR5m+GhI8SqoyaSrtBxp/1i+AUdHICtWBk5sA/S8IB1kNCSXYr5EB01V13jtWthHb6z6T5ALIM1oRTAh6faIWpyJpguIxS3ICRM9u9LUN2YomqaavHqs4kRJptXd7QYl1/u/lzbnye7m8yu8XTxAD7T3N3yy1l3llZGH1zg8mqjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkE1OOOe8T0pvpxeuC6o/IsUwFXdNnDLA20qS+Dh2Ns=;
 b=cRfa0mY3bwYgzfExkgRi1Us/AXLigWxNPScvgpMQg1klLGMNtlvPiye17ZOBkqcZWxb4FHYbWocIIMGppuUiTR22HeQzPgKgGhEPuwovWuQ/M2L9/36WgZSBw0spHLybP9PXR3eWWNd8tp0urf8on7qpZImlo+8sDKfYI55dIlZoQMq10FTEAeb6wqxvSuielnz1IYIFkIBQTy52TVksfmQmhGHtdx2yFatSeeRmD3sCFW6O0i3LYhhdAoQ2252y7zjVLLJyC1pHvxGj2hhxfaBmTWK0jdg4cECopwJ9i/pXzaSZbQ/Zw7UlwxrEG3ty3zh04T2FsTwZTdCXlsn1Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ4PPFADF8EA249.namprd15.prod.outlook.com (2603:10b6:a0f:fc02::8b8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Tue, 17 Feb
 2026 18:11:56 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 18:11:56 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "charmitro@posteo.net" <charmitro@posteo.net>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] hfs/hfsplus: fix timestamp wrapped issue
Thread-Index: AQHcn7avK7OIubRA4kGw9zI5SLiJRLWHMl0A
Date: Tue, 17 Feb 2026 18:11:55 +0000
Message-ID: <2b7b7a970926f56a3742cb76e394e9fb3d79b0eb.camel@ibm.com>
References: <20260216233556.4005400-1-slava@dubeyko.com>
	 <87a4x8f5zq.fsf@posteo.net>
In-Reply-To: <87a4x8f5zq.fsf@posteo.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ4PPFADF8EA249:EE_
x-ms-office365-filtering-correlation-id: be17ea6b-d3f5-4b47-d938-08de6e500907
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?U0xPQzV5YndnRVRIcUp5aW5idzZtTTRCbmVocFY2VmQ1cE9TcUdnTUpEVTZJ?=
 =?utf-8?B?VWZDUDJGM3JUaGhCc0NMTE5vQWtHS1FLVURibVlVVlZCTU5jSW8xR0RrZDFL?=
 =?utf-8?B?b2VnUEdiU1JxWWY4TFNBL3d1Y1ZpL2YxSTlRV09RS1dDaUdhbDJiVGhTbDZq?=
 =?utf-8?B?KzBLZExPQkxZR0tDMndqV3VzN1RHZXZrVVJyK0g1cnh6YkxyQW1JZzNIV2VZ?=
 =?utf-8?B?d1BuSm9TZkNjdTZhZ0htRlhyZExoSTJGVC91NHFSYUVBa1pHMTBHVmlLa1hn?=
 =?utf-8?B?NU05SnBFWHEvWDRpYUJDelpqd3c2MHpDR2NXdTlmSFcrWmpzTUY5MmR6VXdJ?=
 =?utf-8?B?ZThCaTU4b0E2R1RndDh4Uks3b2VJS3BUVElMOGVzbnVmSlRIUlJFZlpseEUr?=
 =?utf-8?B?alUxVXlxYjVaZmkrcGVMWVR5aWhwR3BhK0NtUzducmJMMmZBdStYZ055cHMy?=
 =?utf-8?B?VHR1R3V2TEE2YW1QK1pyWGkrdTlvRTlhc21sWjVDK01CbUZZWDdnVGFoYTB6?=
 =?utf-8?B?SXNhbWNBL2ppcGdhaytDSXNmaHQ4T2l6MzRXRmI5ZU9ySjRWbFQ2V1ptUG5r?=
 =?utf-8?B?MzJiNjluV2U1aEdrNDZuRmFwek9XODQ2M1RqU0VWcjdHSmxMdnd4VVN3OU1s?=
 =?utf-8?B?RVNmNVhCOXpZRGtqd0FZTThWWWEwcU9hdWlhVC8xY3NjTlRDNnRncFRCTld4?=
 =?utf-8?B?Vlc5a1lqc09mWkR1U2N2aTNDZmRvMlNKUkg1bHZQbkVpVVlPay9GREhTU1Zo?=
 =?utf-8?B?YnBzQ3R0Y0E4M28zSUltd0JEYUlTUUttNnJkRzk0UHNHREpNdmtOSlNSUXg3?=
 =?utf-8?B?MzVYZW5SQ2xYUGVqa2JSVnQ4d0ZPSmozWHZMSmh1THdCNnZubEdxQjltVTdr?=
 =?utf-8?B?WWVBSVExV3ZhZEVuTFo0cjc5ZTBaMmFvamhPeHo2SXl4VEVQbk1GS2lZOEk0?=
 =?utf-8?B?VlZRMGl4WHo5THJhM0dKSENrbERxenpYaVQ3dTVXQ09abU5WZit0VE1HNXdT?=
 =?utf-8?B?UW9vcDJGQ2dzbk0rN3phQlVOdjg4SVdKN3JjUFR5Wk1IaTArQllCeVpnblp5?=
 =?utf-8?B?V0M0QnNWR2dWTDU4dlc3MlJmaG92RTJBd2cxbDJRZ1JleUs3cGdHNmlQY0p5?=
 =?utf-8?B?elRodkFCVzJpbEZaU0gwblh6ZkhpQnlOcmpUcEVaQ0xMUWZtMXdJTWRMTk42?=
 =?utf-8?B?TzdpTVB2YXRGZXZpQTNlcFZXMXlXdHhtZXpQOUlocldrQWtrOHpDWDJjbkh6?=
 =?utf-8?B?N2pwOFBXQngzblpHVGNnL0ZqNFhFZTJpdFhpY1N4bjdJaW1rTHFLck9BV0Nm?=
 =?utf-8?B?QXRsQUp0c0ZDV3dWSGhFWDc4WVJjdGFkQzZoV2I2cHRweWVCNUhoY21velpB?=
 =?utf-8?B?QU5ZWW9MeEFJNmJOeVdRZzZVcXU1cEh2WXU0WVlTdytaL1hzNnI4ZVZncjBj?=
 =?utf-8?B?NTVCN2t5MFAyM1Z5TG1yYnp1UENzdUlHeG92WU5oUXpHNTJrZG5hTzNkTWFr?=
 =?utf-8?B?b0hvMFpBbEJDVVVpcnN2YWVJZmxVdUsxVlVRMWtwbmlHdTBoWHpHODg4VGgx?=
 =?utf-8?B?Sjk5bnFIODNlQlVJSFMwK3ZabTEyOEpDK1FpR2ExbkpCWnJQcFVpVkVJOEtM?=
 =?utf-8?B?eXhlVjhFdkJlMjMrQUlCWTJmWGRYVUtEK21jem5JcjdMbHFGNDNhYitQNGkz?=
 =?utf-8?B?ZnFEM2thZnJxYTFISkJiRmZJcU1STGpWY1QvZHhBU0xUQTc2N2sreXVINDg3?=
 =?utf-8?B?RmlvRGF3NWk1MC9sUUoraUZzUGxKeUluNFpJRSs4U3Z2N1BTWStOZzJjT2h1?=
 =?utf-8?B?TGYzSFczbk5CZFFrVlpkMjZ3SUtSVHF6aTBhaXluZUJYbTFmTkFTLzNmSU9J?=
 =?utf-8?B?ZFhJb2Q5UXlrMXV5cnhyR0c1bzZQMUZMQ0luRWFaVloyYUJDc0htd29CNTA5?=
 =?utf-8?B?SUpYS0pGOW9uWWU5eUFEaVVzclpmcXNSMlNMR2JxbEt3UlZFaU5OdGZvSExX?=
 =?utf-8?B?Wk1vL2VrcG94blFNTXhXTW1jQ1hLVmhJbXFsdElPYkFhT2R5QkxmQVZQZWRz?=
 =?utf-8?B?N2R3cXp2YjYvN2ZnM2Y3REVCS0lRNEtzM0w4Q2orbitNOTZ0dFI2aUpnKzRs?=
 =?utf-8?B?bm04Q0U1NGVBaEZCMlZlUjZxOE5JczR4clNZV0gvNVFINjlzT3lxWEl1d3BX?=
 =?utf-8?Q?dq+W8UN8hTftOhGGcZ+DbsA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L1FLb0YveTdBd0pUc1ZGYlFrb21vV2NKTXdEV2pIOFFxRmFhY0szSnhTQjgw?=
 =?utf-8?B?RW43b2FCWm5vdXVWN09DR3Fwbk9yYlFNNEZzMjdHSnBnQWxYOG15ZCttTWNj?=
 =?utf-8?B?aFYxUGpTVW5hcDZVNjlhUFZ1VDM5T2RBWjhXYzNZVHNsSUgxUTRud1VZN1JZ?=
 =?utf-8?B?YzZKaW5IT1Nocm5qUUxWeTR0VWZoQ0JZdU1jbVVoZTk4RmtwNUluUkRmaHlD?=
 =?utf-8?B?V2xtOUNUNktORnNrUVhwZzFyTG5DazVCbVVFZlY4QzBkelc1aCt4a25HV1N1?=
 =?utf-8?B?MlFSRitjaTBEWlMrTVNpRS9LVE96d1JFNHBIOHhRWW5teGtUemxGbmNEaDhp?=
 =?utf-8?B?K3lJdFNPSWNGZS9EZ1lhRThXQW9WWUMzZWhQR29MR3VaQUFjeUNmUDBFSm9N?=
 =?utf-8?B?d0Z2S3JOMTY1S05wbGFUR3JtZlFLRDhpTjBPcFhmeXhidXJaR2FlU0Z2NGYy?=
 =?utf-8?B?N2d6blhmTEpXN3pvTTFaRmRHdDJLY1JrclN6dUFLc2xzUStpMEZ1Skg3cTFa?=
 =?utf-8?B?UGUybGxFajlOV3RhSFgwd0o5Z3FjWFNvbTdzdjExWkV4ZEtMZHNadFBvQUJl?=
 =?utf-8?B?aWNiTUFLbjE3RUIrcmswbzUyTXFjZkQ5cm9JUm5yYlhxaEdrak5WaTVTZkYr?=
 =?utf-8?B?MmJ0TE1QdFZYZGVEQWI1SDU4RUVpUnJ3Sk8yYVdBWTNzd2d2Z0xGS3UrZUZr?=
 =?utf-8?B?Y0E2NVppWXRCcGl2alJVeml2S09rQUhFS1hSRGVIZ091SHFaYUovd1ZNTUpv?=
 =?utf-8?B?VTl4WmpIV1ZBM1BGejF4R2RNdEhGeldPa0FWVGs3dFdiSjFFNjJzeHE3SzQ0?=
 =?utf-8?B?MWdwVUdyNHo0S3BRaitRR1RXWW5JOHhSMWJ4WEtFT0p0ZU1yVEM2Y1hSeXFC?=
 =?utf-8?B?dXRkamorSWR4U09XbkhINjBMc0ZkdTlYSTRISm9mNndETDFqMjlrbVNkTDV3?=
 =?utf-8?B?cWl1WEwzQmVGWDhPSnpDSUwvQWZGbVd1VHZaMzdaUnBwalNUMG81MjhXdjdx?=
 =?utf-8?B?UTJkWm5ZTXpET0p0Sk1taTVXY085NDRMM2lCaW1DUmgrUTZKMTdWcGkrbWcx?=
 =?utf-8?B?dmFRWDVOYkMvQXpuc1pQTlI5ZmFNdnZ2YUZSVnovL0w1bVFmS1g1Z1pyQWd5?=
 =?utf-8?B?Y2ZORmtuc0tjTGR3NTNTTmQ1eXhvMjBMMmRwNExiL0xFbk4wL0pVRW0wMXNm?=
 =?utf-8?B?M0FzWSt5U1BDc1BCMm1rVjQ2VWo4L0R4Mkg0MjJob1QyNC9jZzFtR2hSaHNY?=
 =?utf-8?B?UytuNUNZbTdCclUxT1ZteUx1WVFQWCt4L3Y5QzVqOXNwc052U1BwT0lJeVg2?=
 =?utf-8?B?NGROLytWSG5udElwRStYRGF0dVJVVjErVXIxWFNZK1ZtSXc3enAwRjNDcXk1?=
 =?utf-8?B?NnV3V2c4dFYrZGo5Z0NyMEM4dGhxQUZtUS9CdDFxSStMMXd1cWhPMzdkTGkr?=
 =?utf-8?B?c1ZucDBOZ3ZMRys2RlpXbUZrdEducHlCN0EzZ2dLVlBsUktkaWlydGgzTUFu?=
 =?utf-8?B?Q0h6ZGxxTW1iUnRTNXhWUE1PekFXSHR6bzVCZlZZTGM4d3c2REJxQWU5SGdm?=
 =?utf-8?B?UzlSRjB0V2JzTE1rRUpuaXhmN0crMGpncDBpUUZsbHR6N2c0MExaWWhrd0J3?=
 =?utf-8?B?MU8zL2JnUU50M3M1dWtXamo2QlVkcm9UZ044clY0cVBMTDlDeHowVlZxcXps?=
 =?utf-8?B?NlhOdU02NTVYT25Nbkw5RlQ2LzE5Q1BNdENodTJXVXFxSVROMjhwWTdLMTRF?=
 =?utf-8?B?Tm5vUFk2ODZwNVRyczk4S2x6NTF1UVhVbTlaZ2VybzBXaVlDUm5yL3hmNFZi?=
 =?utf-8?B?K1J2OUJYRFNhZVh4czBRUUVDMElRa1d4b3drZW5Oa0NRS05EVHdsVVU4WUln?=
 =?utf-8?B?bHRwaWdGdUxycnVGQTlKQkE1VHZIZlpsYlhncm1JRTJOR1NhajVkT3J3WnJh?=
 =?utf-8?B?aWRWM2hEYXB4YzhmV2FKSXR6a2RndGFETlBrcWJLK2hPTHRFN09RNHZWd0di?=
 =?utf-8?B?L1ZDQmovTUx1MzlSbmx6cENUWnNYR2tZekxmRURLN0p5RFVjSWNobkJOb1h2?=
 =?utf-8?B?V0dMd2xaTUFFbVlGdHkyYWdsWENlNWtjOXFabFhQUDJjcUtBSUNiSDNFeGM5?=
 =?utf-8?B?VENsVk9GbFZWVjJaM3RtQSsyNnRsN0xhWW13OVEzbXZWMFdtMUFVTWtEaktm?=
 =?utf-8?B?U1hWV3FVYjNIam1JLzMxdnI5WlR2WTRORFRrUUxYV1hGR3RkRFZLWWExbEF2?=
 =?utf-8?B?SS9NUGt6RmcwNmNjNDkxQ3dIRmpuYkExdmFSNWhpbzV3a2NJUmtEUXZLQ3lL?=
 =?utf-8?B?WklGRDZDUkxPTFJ6TDRyMDdHMnJidXdxNFVRS0FFdmJEL0FXUW5ScklFM1V3?=
 =?utf-8?Q?8hyqwvvnS19EZWAU3VKu3Qd0kkTZUQ1zWBlLx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5346205B842B554A855673E55E90E711@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: be17ea6b-d3f5-4b47-d938-08de6e500907
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2026 18:11:56.1052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WJlhRbPAScALCgR8tO9NvY+YLf0uJ+Cck1ZOitF4nG+AdIKXyyLYjxwWIRsIgbDrZqEHCcxYmZro3RPlSq5aBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPFADF8EA249
X-Proofpoint-ORIG-GUID: v2w5LVO2pH_0u7FCdygra4ktkiJ-TK6o
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=6994af70 cx=c_pps
 a=y6Y39UqQ09MdvbCyrKLMTw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8 a=wCmvBT1CAAAA:8 a=1WtWmnkvAAAA:8
 a=VwQbUJbxAAAA:8 a=DnmWlWVPiUl2pKR9zXUA:9 a=QEXdDO2ut3YA:10
 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE0OCBTYWx0ZWRfX78fkTAH4bKx6
 5RSa5zmn837zFlByFIz0+PFkVd4J5fSG0yOUs5oVNgJk0EyuCCP8ofQOhJPhVBc2UCgPIbqulwT
 GqyRrbtDfOsf8dZZo6A4OmdzwAuoYFJMH3qnQiIbkGV27o5PD2iTbhK9CLHqb4+Vq8QfmIY20QK
 FgUw3u/6GV6p9xKewS6SV95IQkc58qbxAGv/58ZmjZboNv4fktUSw/yCcmmo9sPOEDRDAz0Ra3b
 +/MwHrj9E/FBPzyMw1yQDaRX4CGZPBzs8KKzTeKRMCZP8p2+rJiBFAOWrJvjuknuYBdYexeV8nq
 pRYD2ojAbdkC/jq5DjHuhk8QkGPP78P59HL9fQwxINdu+HkZN87A4kk7rs3d2l/lV/tmoYAQxzv
 l/YoidVsj2L/CMpm0IQ0DInVPc1wuRKR9BorRU63ncWk7Aaum0+Ms5MqQ/JJpKxNJG2gL37VppT
 uPh2epJruxsT0HGPEFQ==
X-Proofpoint-GUID: v2w5LVO2pH_0u7FCdygra4ktkiJ-TK6o
Subject: RE: [PATCH] hfs/hfsplus: fix timestamp wrapped issue
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170148
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77384-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BAB3F14EF58
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTAyLTE3IGF0IDAyOjM5ICswMDAwLCBDaGFyYWxhbXBvcyBNaXRyb2RpbWFz
IHdyb3RlOg0KPiBWaWFjaGVzbGF2IER1YmV5a28gPHNsYXZhQGR1YmV5a28uY29tPiB3cml0ZXM6
DQo+IA0KPiA+IFRoZSB4ZnN0ZXN0cycgdGVzdC1jYXNlIGdlbmVyaWMvMjU4IGZhaWxzIHRvIGV4
ZWN1dGUNCj4gPiBjb3JyZWN0bHk6DQo+ID4gDQo+ID4gRlNUWVAgLS0gaGZzcGx1cw0KPiA+IFBM
QVRGT1JNIC0tIExpbnV4L3g4Nl82NCBoZnNwbHVzLXRlc3RpbmctMDAwMSA2LjE1LjAtcmM0KyAj
OCBTTVAgUFJFRU1QVF9EWU5BTUlDIFRodSBNYXkgMSAxNjo0MzoyMiBQRFQgMjAyNQ0KPiA+IE1L
RlNfT1BUSU9OUyAtLSAvZGV2L2xvb3A1MQ0KPiA+IE1PVU5UX09QVElPTlMgLS0gL2Rldi9sb29w
NTEgL21udC9zY3JhdGNoDQo+ID4gDQo+ID4gZ2VuZXJpYy8yNTggW2ZhaWxlZCwgZXhpdCBzdGF0
dXMgMV0tIG91dHB1dCBtaXNtYXRjaCAoc2VlIHhmc3Rlc3RzLWRldi9yZXN1bHRzLy9nZW5lcmlj
LzI1OC5vdXQuYmFkKQ0KPiA+IA0KPiA+IFRoZSBtYWluIHJlYXNvbiBvZiB0aGUgaXNzdWUgaXMg
dGhlIGxvZ2ljOg0KPiA+IA0KPiA+IGNwdV90b19iZTMyKGxvd2VyXzMyX2JpdHModXQpICsgSEZT
UExVU19VVENfT0ZGU0VUKQ0KPiA+IA0KPiA+IEF0IGZpcnN0LCB3ZSB0YWtlIHRoZSBsb3dlciAz
MiBiaXRzIG9mIHRoZSB2YWx1ZSBhbmQsIHRoZW4NCj4gPiB3ZSBhZGQgdGhlIHRpbWUgb2Zmc2V0
LiBIb3dldmVyLCBpZiB3ZSBoYXZlIG5lZ2F0aXZlIHZhbHVlDQo+ID4gdGhlbiB3ZSBtYWtlIGNv
bXBsZXRlbHkgd3JvbmcgY2FsY3VsYXRpb24uDQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBjb3JyZWN0
cyB0aGUgbG9naWMgb2YgX19oZnNwX210MnV0KCkgYW5kDQo+ID4gX19oZnNwX3V0Mm10IChIRlMr
IGNhc2UpLCBfX2hmc19tX3RvX3V0aW1lKCkgYW5kDQo+ID4gX19oZnNfdV90b19tdGltZSAoSEZT
IGNhc2UpLiBUaGUgSEZTX01JTl9USU1FU1RBTVBfU0VDUyBhbmQNCj4gPiBIRlNfTUFYX1RJTUVT
VEFNUF9TRUNTIGhhdmUgYmVlbiBpbnRyb2R1Y2VkIGluDQo+ID4gaW5jbHVkZS9saW51eC9oZnNf
Y29tbW9uLmguIEFsc28sIEhGU19VVENfT0ZGU0VUIGNvbnN0YW50DQo+ID4gaGFzIGJlZW4gbW92
ZWQgdG8gaW5jbHVkZS9saW51eC9oZnNfY29tbW9uLmguIFRoZSBoZnNfZmlsbF9zdXBlcigpDQo+
ID4gYW5kIGhmc3BsdXNfZmlsbF9zdXBlcigpIGxvZ2ljIGRlZmluZXMgc2ItPnNfdGltZV9taW4s
DQo+ID4gc2ItPnNfdGltZV9tYXgsIGFuZCBzYi0+c190aW1lX2dyYW4uDQo+ID4gDQo+ID4gc3Vk
byAuL2NoZWNrIGdlbmVyaWMvMjU4DQo+ID4gRlNUWVAgICAgICAgICAtLSBoZnNwbHVzDQo+ID4g
UExBVEZPUk0gICAgICAtLSBMaW51eC94ODZfNjQgaGZzcGx1cy10ZXN0aW5nLTAwMDEgNi4xOS4w
LXJjMSsgIzg3IFNNUCBQUkVFTVBUX0RZTkFNSUMgTW9uIEZlYiAxNiAxNDo0ODo1NyBQU1QgMjAy
Ng0KPiA+IE1LRlNfT1BUSU9OUyAgLS0gL2Rldi9sb29wNTENCj4gPiBNT1VOVF9PUFRJT05TIC0t
IC9kZXYvbG9vcDUxIC9tbnQvc2NyYXRjaA0KPiA+IA0KPiA+IGdlbmVyaWMvMjU4IDI5cyAuLi4g
IDM5cw0KPiA+IFJhbjogZ2VuZXJpYy8yNTgNCj4gPiBQYXNzZWQgYWxsIDEgdGVzdHMNCj4gPiAN
Cj4gPiBbMV0gaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBz
LTNBX19naXRodWIuY29tX2hmcy0yRGxpbnV4LTJEa2VybmVsX2hmcy0yRGxpbnV4LTJEa2VybmVs
X2lzc3Vlc18xMzMmZD1Ed0lCQWcmYz1CU0RpY3FCUUJEakRJOVJrVnlUY0hRJnI9cTViSW00QVhN
emM4Tkp1MV9SR21uUTJmTVdLcTRZNFJBa0VsdlVnU3MwMCZtPTBmVC11TDU2T1BuZGlTM3ZpTzB0
YklvZkRoY2U3bF9EdnFYMklnNWUxMUU5c1JHU1pIZXNMdmdwR3ZhRUdwdmomcz01MnJDM1RYTEtX
ejhhck5LWk15U0R4LXZ3bXM1ei1NZDBibnZQNnRHa0VNJmU9IA0KPiA+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFZpYWNoZXNsYXYgRHViZXlrbyA8c2xhdmFAZHViZXlrby5jb20+DQo+ID4gY2M6IEpv
aG4gUGF1bCBBZHJpYW4gR2xhdWJpdHogPGdsYXViaXR6QHBoeXNpay5mdS1iZXJsaW4uZGU+DQo+
ID4gY2M6IFlhbmd0YW8gTGkgPGZyYW5rLmxpQHZpdm8uY29tPg0KPiA+IGNjOiBsaW51eC1mc2Rl
dmVsQHZnZXIua2VybmVsLm9yZw0KPiA+IC0tLQ0KPiA+ICBmcy9oZnMvaGZzX2ZzLmggICAgICAg
ICAgICB8IDE3ICsrKystLS0tLS0tLS0tLS0tDQo+ID4gIGZzL2hmcy9zdXBlci5jICAgICAgICAg
ICAgIHwgIDQgKysrKw0KPiA+ICBmcy9oZnNwbHVzL2hmc3BsdXNfZnMuaCAgICB8IDEzICsrKyst
LS0tLS0tLS0NCj4gPiAgZnMvaGZzcGx1cy9zdXBlci5jICAgICAgICAgfCAgNCArKysrDQo+ID4g
IGluY2x1ZGUvbGludXgvaGZzX2NvbW1vbi5oIHwgMTggKysrKysrKysrKysrKysrKysrDQo+ID4g
IDUgZmlsZXMgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pDQo+ID4g
DQo+ID4gZGlmZiAtLWdpdCBhL2ZzL2hmcy9oZnNfZnMuaCBiL2ZzL2hmcy9oZnNfZnMuaA0KPiA+
IGluZGV4IGFjMGU4M2Y3N2EwZi4uN2Q1MjllNjc4OWI4IDEwMDY0NA0KPiA+IC0tLSBhL2ZzL2hm
cy9oZnNfZnMuaA0KPiA+ICsrKyBiL2ZzL2hmcy9oZnNfZnMuaA0KPiA+IEBAIC0yMjksMjEgKzIy
OSwxMSBAQCBleHRlcm4gaW50IGhmc19tYWMyYXNjKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsDQo+
ID4gIGV4dGVybiB2b2lkIGhmc19tYXJrX21kYl9kaXJ0eShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNi
KTsNCj4gPiAgDQo+ID4gIC8qDQo+ID4gLSAqIFRoZXJlIGFyZSB0d28gdGltZSBzeXN0ZW1zLiAg
Qm90aCBhcmUgYmFzZWQgb24gc2Vjb25kcyBzaW5jZQ0KPiA+IC0gKiBhIHBhcnRpY3VsYXIgdGlt
ZS9kYXRlLg0KPiA+IC0gKglVbml4OglzaWduZWQgbGl0dGxlLWVuZGlhbiBzaW5jZSAwMDowMCBH
TVQsIEphbi4gMSwgMTk3MA0KPiA+IC0gKgltYWM6CXVuc2lnbmVkIGJpZy1lbmRpYW4gc2luY2Ug
MDA6MDAgR01ULCBKYW4uIDEsIDE5MDQNCj4gPiAtICoNCj4gPiAtICogSEZTIGltcGxlbWVudGF0
aW9ucyBhcmUgaGlnaGx5IGluY29uc2lzdGVudCwgdGhpcyBvbmUgbWF0Y2hlcyB0aGUNCj4gPiAt
ICogdHJhZGl0aW9uYWwgYmVoYXZpb3Igb2YgNjQtYml0IExpbnV4LCBnaXZpbmcgdGhlIG1vc3Qg
dXNlZnVsDQo+ID4gLSAqIHRpbWUgcmFuZ2UgYmV0d2VlbiAxOTcwIGFuZCAyMTA2LCBieSB0cmVh
dGluZyBhbnkgb24tZGlzayB0aW1lc3RhbXANCj4gPiAtICogdW5kZXIgSEZTX1VUQ19PRkZTRVQg
KEphbiAxIDE5NzApIGFzIGEgdGltZSBiZXR3ZWVuIDIwNDAgYW5kIDIxMDYuDQo+ID4gKyAqIHRp
bWUgaGVscGVyczogY29udmVydCBiZXR3ZWVuIDE5MDQtYmFzZSBhbmQgMTk3MC1iYXNlIHRpbWVz
dGFtcHMNCj4gPiAgICovDQo+ID4gLSNkZWZpbmUgSEZTX1VUQ19PRkZTRVQgMjA4Mjg0NDgwMFUN
Cj4gPiAtDQo+ID4gIHN0YXRpYyBpbmxpbmUgdGltZTY0X3QgX19oZnNfbV90b191dGltZShfX2Jl
MzIgbXQpDQo+ID4gIHsNCj4gPiAtCXRpbWU2NF90IHV0ID0gKHUzMikoYmUzMl90b19jcHUobXQp
IC0gSEZTX1VUQ19PRkZTRVQpOw0KPiA+ICsJdGltZTY0X3QgdXQgPSAodGltZTY0X3QpYmUzMl90
b19jcHUobXQpIC0gSEZTX1VUQ19PRkZTRVQ7DQo+ID4gIA0KPiA+ICAJcmV0dXJuIHV0ICsgc3lz
X3R6LnR6X21pbnV0ZXN3ZXN0ICogNjA7DQo+ID4gIH0NCj4gPiBAQCAtMjUxLDggKzI0MSw5IEBA
IHN0YXRpYyBpbmxpbmUgdGltZTY0X3QgX19oZnNfbV90b191dGltZShfX2JlMzIgbXQpDQo+ID4g
IHN0YXRpYyBpbmxpbmUgX19iZTMyIF9faGZzX3VfdG9fbXRpbWUodGltZTY0X3QgdXQpDQo+ID4g
IHsNCj4gPiAgCXV0IC09IHN5c190ei50el9taW51dGVzd2VzdCAqIDYwOw0KPiA+ICsJdXQgKz0g
SEZTX1VUQ19PRkZTRVQ7DQo+ID4gIA0KPiA+IC0JcmV0dXJuIGNwdV90b19iZTMyKGxvd2VyXzMy
X2JpdHModXQpICsgSEZTX1VUQ19PRkZTRVQpOw0KPiA+ICsJcmV0dXJuIGNwdV90b19iZTMyKGxv
d2VyXzMyX2JpdHModXQpKTsNCj4gPiAgfQ0KPiA+ICAjZGVmaW5lIEhGU19JKGlub2RlKQkoY29u
dGFpbmVyX29mKGlub2RlLCBzdHJ1Y3QgaGZzX2lub2RlX2luZm8sIHZmc19pbm9kZSkpDQo+ID4g
ICNkZWZpbmUgSEZTX1NCKHNiKQkoKHN0cnVjdCBoZnNfc2JfaW5mbyAqKShzYiktPnNfZnNfaW5m
bykNCj4gPiBkaWZmIC0tZ2l0IGEvZnMvaGZzL3N1cGVyLmMgYi9mcy9oZnMvc3VwZXIuYw0KPiA+
IGluZGV4IDk3NTQ2ZDZiNDFmNC4uNmI2YzEzODgxMmI3IDEwMDY0NA0KPiA+IC0tLSBhL2ZzL2hm
cy9zdXBlci5jDQo+ID4gKysrIGIvZnMvaGZzL3N1cGVyLmMNCj4gPiBAQCAtMzQxLDYgKzM0MSwx
MCBAQCBzdGF0aWMgaW50IGhmc19maWxsX3N1cGVyKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0
cnVjdCBmc19jb250ZXh0ICpmYykNCj4gPiAgCXNiLT5zX2ZsYWdzIHw9IFNCX05PRElSQVRJTUU7
DQo+ID4gIAltdXRleF9pbml0KCZzYmktPmJpdG1hcF9sb2NrKTsNCj4gPiAgDQo+ID4gKwlzYi0+
c190aW1lX2dyYW4gPSBOU0VDX1BFUl9TRUM7DQo+ID4gKwlzYi0+c190aW1lX21pbiA9IEhGU19N
SU5fVElNRVNUQU1QX1NFQ1M7DQo+ID4gKwlzYi0+c190aW1lX21heCA9IEhGU19NQVhfVElNRVNU
QU1QX1NFQ1M7DQo+ID4gKw0KPiA+ICAJcmVzID0gaGZzX21kYl9nZXQoc2IpOw0KPiA+ICAJaWYg
KHJlcykgew0KPiA+ICAJCWlmICghc2lsZW50KQ0KPiA+IGRpZmYgLS1naXQgYS9mcy9oZnNwbHVz
L2hmc3BsdXNfZnMuaCBiL2ZzL2hmc3BsdXMvaGZzcGx1c19mcy5oDQo+ID4gaW5kZXggNWY4OTFi
NzNhNjQ2Li4zNTU0ZmFmODRjMTUgMTAwNjQ0DQo+ID4gLS0tIGEvZnMvaGZzcGx1cy9oZnNwbHVz
X2ZzLmgNCj4gPiArKysgYi9mcy9oZnNwbHVzL2hmc3BsdXNfZnMuaA0KPiA+IEBAIC01MTEsMjQg
KzUxMSwxOSBAQCBpbnQgaGZzcGx1c19yZWFkX3dyYXBwZXIoc3RydWN0IHN1cGVyX2Jsb2NrICpz
Yik7DQo+ID4gIA0KPiA+ICAvKg0KPiA+ICAgKiB0aW1lIGhlbHBlcnM6IGNvbnZlcnQgYmV0d2Vl
biAxOTA0LWJhc2UgYW5kIDE5NzAtYmFzZSB0aW1lc3RhbXBzDQo+ID4gLSAqDQo+ID4gLSAqIEhG
UysgaW1wbGVtZW50YXRpb25zIGFyZSBoaWdobHkgaW5jb25zaXN0ZW50LCB0aGlzIG9uZSBtYXRj
aGVzIHRoZQ0KPiA+IC0gKiB0cmFkaXRpb25hbCBiZWhhdmlvciBvZiA2NC1iaXQgTGludXgsIGdp
dmluZyB0aGUgbW9zdCB1c2VmdWwNCj4gPiAtICogdGltZSByYW5nZSBiZXR3ZWVuIDE5NzAgYW5k
IDIxMDYsIGJ5IHRyZWF0aW5nIGFueSBvbi1kaXNrIHRpbWVzdGFtcA0KPiA+IC0gKiB1bmRlciBI
RlNQTFVTX1VUQ19PRkZTRVQgKEphbiAxIDE5NzApIGFzIGEgdGltZSBiZXR3ZWVuIDIwNDAgYW5k
IDIxMDYuDQo+ID4gICAqLw0KPiA+IC0jZGVmaW5lIEhGU1BMVVNfVVRDX09GRlNFVCAyMDgyODQ0
ODAwVQ0KPiA+IC0NCj4gPiAgc3RhdGljIGlubGluZSB0aW1lNjRfdCBfX2hmc3BfbXQydXQoX19i
ZTMyIG10KQ0KPiA+ICB7DQo+ID4gLQl0aW1lNjRfdCB1dCA9ICh1MzIpKGJlMzJfdG9fY3B1KG10
KSAtIEhGU1BMVVNfVVRDX09GRlNFVCk7DQo+ID4gKwl0aW1lNjRfdCB1dCA9ICh0aW1lNjRfdCli
ZTMyX3RvX2NwdShtdCkgLSBIRlNfVVRDX09GRlNFVDsNCj4gPiAgDQo+ID4gIAlyZXR1cm4gdXQ7
DQo+ID4gIH0NCj4gPiAgDQo+ID4gIHN0YXRpYyBpbmxpbmUgX19iZTMyIF9faGZzcF91dDJtdCh0
aW1lNjRfdCB1dCkNCj4gPiAgew0KPiA+IC0JcmV0dXJuIGNwdV90b19iZTMyKGxvd2VyXzMyX2Jp
dHModXQpICsgSEZTUExVU19VVENfT0ZGU0VUKTsNCj4gPiArCXV0ICs9IEhGU19VVENfT0ZGU0VU
Ow0KPiA+ICsNCj4gPiArCXJldHVybiBjcHVfdG9fYmUzMihsb3dlcl8zMl9iaXRzKHV0KSk7DQo+
ID4gIH0NCj4gPiAgDQo+ID4gIHN0YXRpYyBpbmxpbmUgZW51bSBoZnNwbHVzX2J0cmVlX211dGV4
X2NsYXNzZXMNCj4gPiBkaWZmIC0tZ2l0IGEvZnMvaGZzcGx1cy9zdXBlci5jIGIvZnMvaGZzcGx1
cy9zdXBlci5jDQo+ID4gaW5kZXggNTkyZDhmYmI3NDhjLi5kY2Q2MTg2OGQxOTkgMTAwNjQ0DQo+
ID4gLS0tIGEvZnMvaGZzcGx1cy9zdXBlci5jDQo+ID4gKysrIGIvZnMvaGZzcGx1cy9zdXBlci5j
DQo+ID4gQEAgLTQ4Nyw2ICs0ODcsMTAgQEAgc3RhdGljIGludCBoZnNwbHVzX2ZpbGxfc3VwZXIo
c3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0IGZzX2NvbnRleHQgKmZjKQ0KPiA+ICAJaWYg
KCFzYmktPnJzcmNfY2x1bXBfYmxvY2tzKQ0KPiA+ICAJCXNiaS0+cnNyY19jbHVtcF9ibG9ja3Mg
PSAxOw0KPiA+ICANCj4gPiArCXNiLT5zX3RpbWVfZ3JhbiA9IE5TRUNfUEVSX1NFQzsNCj4gPiAr
CXNiLT5zX3RpbWVfbWluID0gSEZTX01JTl9USU1FU1RBTVBfU0VDUzsNCj4gPiArCXNiLT5zX3Rp
bWVfbWF4ID0gSEZTX01BWF9USU1FU1RBTVBfU0VDUzsNCj4gPiArDQo+ID4gIAllcnIgPSAtRUZC
SUc7DQo+ID4gIAlsYXN0X2ZzX2Jsb2NrID0gc2JpLT50b3RhbF9ibG9ja3MgLSAxOw0KPiA+ICAJ
bGFzdF9mc19wYWdlID0gKGxhc3RfZnNfYmxvY2sgPDwgc2JpLT5hbGxvY19ibGtzel9zaGlmdCkg
Pj4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9oZnNfY29tbW9uLmggYi9pbmNsdWRl
L2xpbnV4L2hmc19jb21tb24uaA0KPiA+IGluZGV4IGRhZGI1ZTBhYThhMy4uODE2YWMyZjA5OTZk
IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvaGZzX2NvbW1vbi5oDQo+ID4gKysrIGIv
aW5jbHVkZS9saW51eC9oZnNfY29tbW9uLmgNCj4gPiBAQCAtNjUwLDQgKzY1MCwyMiBAQCB0eXBl
ZGVmIHVuaW9uIHsNCj4gPiAgCXN0cnVjdCBoZnNwbHVzX2F0dHJfa2V5IGF0dHI7DQo+ID4gIH0g
X19wYWNrZWQgaGZzcGx1c19idHJlZV9rZXk7DQo+ID4gIA0KPiA+ICsvKg0KPiA+ICsgKiBUaGVy
ZSBhcmUgdHdvIHRpbWUgc3lzdGVtcy4gIEJvdGggYXJlIGJhc2VkIG9uIHNlY29uZHMgc2luY2UN
Cj4gPiArICogYSBwYXJ0aWN1bGFyIHRpbWUvZGF0ZS4NCj4gPiArICoJVW5peDoJc2lnbmVkIGxp
dHRsZS1lbmRpYW4gc2luY2UgMDA6MDAgR01ULCBKYW4uIDEsIDE5NzANCj4gPiArICoJbWFjOgl1
bnNpZ25lZCBiaWctZW5kaWFuIHNpbmNlIDAwOjAwIEdNVCwgSmFuLiAxLCAxOTA0DQo+ID4gKyAq
DQo+ID4gKyAqIEhGUy9IRlMrIGltcGxlbWVudGF0aW9ucyBhcmUgaGlnaGx5IGluY29uc2lzdGVu
dCwgdGhpcyBvbmUgbWF0Y2hlcyB0aGUNCj4gPiArICogdHJhZGl0aW9uYWwgYmVoYXZpb3Igb2Yg
NjQtYml0IExpbnV4LCBnaXZpbmcgdGhlIG1vc3QgdXNlZnVsDQo+ID4gKyAqIHRpbWUgcmFuZ2Ug
YmV0d2VlbiAxOTcwIGFuZCAyMTA2LCBieSB0cmVhdGluZyBhbnkgb24tZGlzayB0aW1lc3RhbXAN
Cj4gPiArICogdW5kZXIgSEZTX1VUQ19PRkZTRVQgKEphbiAxIDE5NzApIGFzIGEgdGltZSBiZXR3
ZWVuIDIwNDAgYW5kIDIxMDYuDQo+ID4gKyAqLw0KPiANCj4gU2luY2UgdGhpcyBpcyByZXBsYWNp
bmcgdGhlIHdyYXBwaW5nIGJlaGF2aW9yIHdpdGggYSBsaW5lYXIgMTkwNC0yMDQwDQo+IG1hcHBp
bmcsIHNob3VsZCB3ZSB1cGRhdGUgdGhpcyBjb21tZW50IHRvIG1hdGNoPyBJdCBzdGlsbCBkZXNj
cmliZXMgdGhlDQo+IG9sZCAiMjA0MCB0byAyMTA2IiB3cmFwcGluZyBzZW1hbnRpY3MuDQo+IA0K
DQpGcmFua2x5IHNwZWFraW5nLCBJIGRvbid0IHF1aXRlIGZvbGxvdyB3aGF0IGRvIHlvdSBtZWFu
IGhlcmUuIFRoaXMgcGF0Y2ggZG9lc24ndA0KY2hhbmdlIHRoZSBhcHByb2FjaC4gSXQgc2ltcGx5
IGZpeGVzIHRoZSBpbmNvcnJlY3QgY2FsY3VsYXRpb24gbG9naWMuIERvIHlvdQ0KbWVhbiB0aGF0
IHRoaXMgd3JhcHBpbmcgaXNzdWUgd2FzIHRoZSBtYWluIGFwcHJvYWNoPyBDdXJyZW50bHksIEkg
ZG9uJ3Qgc2VlIHdoYXQNCm5lZWRzIHRvIGJlIHVwZGF0ZWQgaW4gdGhlIGNvbW1lbnQuDQoNClRo
YW5rcywNClNsYXZhLg0KDQo+IENoZWVycywNCj4gQy4gTWl0cm9kaW1hcw0KPiANCj4gPiArI2Rl
ZmluZSBIRlNfVVRDX09GRlNFVCAyMDgyODQ0ODAwVQ0KPiA+ICsNCj4gPiArLyogSmFudWFyeSAx
LCAxOTA0LCAwMDowMDowMCBVVEMgKi8NCj4gPiArI2RlZmluZSBIRlNfTUlOX1RJTUVTVEFNUF9T
RUNTCQktMjA4Mjg0NDgwMExMDQo+ID4gKy8qIEZlYnJ1YXJ5IDYsIDIwNDAsIDA2OjI4OjE1IFVU
QyAqLw0KPiA+ICsjZGVmaW5lIEhGU19NQVhfVElNRVNUQU1QX1NFQ1MJCTIyMTIxMjI0OTVMTA0K
PiA+ICsNCj4gPiAgI2VuZGlmIC8qIF9IRlNfQ09NTU9OX0hfICovDQo=

