Return-Path: <linux-fsdevel+bounces-75310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEcQE6DWc2kOzAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 21:14:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE007A88F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 21:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8D0D30193B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 20:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3F82D838E;
	Fri, 23 Jan 2026 20:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fQxA7wcx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E568E2D6E63;
	Fri, 23 Jan 2026 20:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769199240; cv=fail; b=VC7Mns6YgHbbjn+MtqEhVmEZQZAfz7K0UtBDte6uxvhjNelF1y1Y6y3n39sj5tiKTPwWdw/e/faZ0awrTb3z28JBi2QAitnguGzYF7F2hYl3Pyi06vLKE//6Y0h43yc06HLo2iobd58zXBIqwGXMlhkn1xI0SutHFVKMY+Zn41E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769199240; c=relaxed/simple;
	bh=TFwUec2HdzPiBx6M3iV6GIgWQItoOgJPBG6zCC9DvK8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=R8a+m1E3G/S847UaiTEuhTh+2Flv9tZXxc2lwMobCHwBsGM6HXmuH2aRL+KwU29UccAGRD9/b1OplP/tLmoD3wZcTl8P7Y4zNsnBlEqQmjyfREd33IrCCuVer67DQmQHYdQb43D4peUYZZEQy6n8LrhO6Wakc+FBXdwxdaZ+SKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fQxA7wcx; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60NHbRot007889;
	Fri, 23 Jan 2026 20:13:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=pp1; bh=TFwUec2HdzPiBx6M3
	iV6GIgWQItoOgJPBG6zCC9DvK8=; b=fQxA7wcxeNGP4dDvwF9mGQGdzHoC217A6
	6iT8rYxUV5CrqZ/0V7dR820IuFoUNA9q5r0XQ2cJ55a1xUKaFSbsXu7GtXRMHxz1
	FwQjCC4m42mI2LXLIbQoB8S0VdJjKo/QY5eiF5HnAVA6bMLveGZLTGP4oZfvY+uf
	PueqU/U6jEtvXYjDm6Lse+6hr2LlG2A1sZVgu4S8Nc85R+EfOOAGE47mSDwDpMW3
	A2CJFM+bXBOJQdfW+6DTWMeU833YIQ4z878PBBA8BDscz5BQBZGB0/L0frhH4mkO
	c89EfMwkFTFOU+JkBIQjFjvzVVWDuW7jORJKUE0dAUClAIqInWufg==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012009.outbound.protection.outlook.com [52.101.43.9])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bus1px798-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 20:13:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLe09HTs4msrcVmecDM3zG/43jD9dl3igSdqewNHAhzb4K+TEkIEo7XnE7h2Y2XYuYdbVQfPDycpa9vlUSctO4vr+rtWi4O9J8uhqpGUh5MdvECmPFHYCI27hF8XRUaAAUtDWT461Hjxfmu6hpuyjCiw2KZnHQsRAqwAsUAcSkzIOfKcrdkD3qfw8p9elhPWO4zkvjesiKyG2ejoyTZqcjJcCOXiTQY2hW1Wn69wz8E85aXsnfk8+Cd7CTKXizvIZU7EEUUdi0vl3q6ewcHj5uBJfCHaGsqh/h0HxOtVRMUuNYHe2Yb3H2BjaHkGcyaBKjvPsP670tZgi6yKveri6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFwUec2HdzPiBx6M3iV6GIgWQItoOgJPBG6zCC9DvK8=;
 b=Tg463zpMBeBW52iHQ8upOCN1An1Wb5NPEWX+phklrGK/wafOyWrntwHzh6caWGIC2Vdo8Eyzs6F2qnqpAHOknXx9enZ/cxk6TmGlcGa6MSYmH61qkMsyi/1Fzvy9hZLGvoNWVUFTaLm75DCCiF9LsBKjs91BHypRhaZTERq60YcOvLB7Fqaf2z4pLbaH/bIhQQkeWcMk2dyoeQPQMDI/NHsvBVYWNq9EnJuaLmq4zxLEM6czoIxjxQ2aYqb1RQJWlMUECCrJ+IVZgqzQ1NhA6UmBplU8fWOv9CoX/OSoaIeLRFQ9dzwqT6Dj2CPmwzlomyxTLpVfuYOKsKUTAd3gqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com (2603:10b6:a03:4e4::8)
 by CH4PR15MB6646.namprd15.prod.outlook.com (2603:10b6:610:22a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 20:13:49 +0000
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::7a72:f65e:b0be:f93f]) by SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::7a72:f65e:b0be:f93f%4]) with mapi id 15.20.9542.008; Fri, 23 Jan 2026
 20:13:49 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "qian01.li@samsung.com" <qian01.li@samsung.com>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
        "javier.gonz@samsung.com" <javier.gonz@samsung.com>
CC: Patrick Donnelly <pdonnell@ibm.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Pavan
 Rallabhandi <Pavan.Rallabhandi@ibm.com>
Subject: [LSF/MM/BPF TOPIC] Data placement policy for FDP SSD in Ceph and
 other distributed file systems
Thread-Topic: [LSF/MM/BPF TOPIC] Data placement policy for FDP SSD in Ceph and
 other distributed file systems
Thread-Index: AQHcjKTJlfFaqwLMmEm7IooAgQHEoA==
Date: Fri, 23 Jan 2026 20:13:49 +0000
Message-ID: <b4bbba0993d4c1abd6566d8d508bbb47aacd7671.camel@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB5821:EE_|CH4PR15MB6646:EE_
x-ms-office365-filtering-correlation-id: e512e5ad-b0f8-4ea4-6ce9-08de5abbebb1
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eDBHcFdudjNyNC96amZwWVFkWHhzeXZNY0V4Y1dMMGZxNWU0d0wvTWxSeXB6?=
 =?utf-8?B?QTlTczdvcXU0eDcxK21JYXlVQ0d6djFYRzFQSk15d05ndElKT1ZWM3dBZlhv?=
 =?utf-8?B?MTJQcGVDdWEyQ2pnazIwcjR2dnVWVEVycUVmQWtUTUJUUGRoT2FhcjNJZGp3?=
 =?utf-8?B?SzlrZ3JPS2xSUFdzUytBUkVUb1hKNGJXNWJCeEhndGl4TjZrRDdIRXNnNVZX?=
 =?utf-8?B?MHVRZERjMlg4SXIzT2JpSVNrOWkxOXhPdGhyK3h2RTk1Yk9lclliVmVQREdt?=
 =?utf-8?B?V3kvRVBPZ3BvTEVwWGJVK3pmODZBeXQ2NDBiazBmZy9TbUpJYTdpejhRc2Jj?=
 =?utf-8?B?VUw5ZUszSTc5RHZrK1NsUTBKbEJ4NUhnTU16UTJYbE44SUVIZDRweGZ4dXo5?=
 =?utf-8?B?WFhFMjlhRWVURGpTWUVnN2l3amNRTitUbzRRazBtenNHWlN5Y1RDYUsySVFj?=
 =?utf-8?B?Q1cxdGJaa3lpc0g3Z1V6RkdnZ0V6TFNoenNRQWl5RE9OMzFWb2JWcFRsdDBE?=
 =?utf-8?B?SjIwcG85TUtaM3NNNDZPbWwzYVl1NHp1bFkweEh2N0YvMnAxdmRuNVo5MUlE?=
 =?utf-8?B?NEErZTMyUFNHVnQwQjJsV1NCejcrZnorUTYyTjIveGJaOE5FeXVDUHJzT243?=
 =?utf-8?B?VXZuMzc0Z2lLTmh5SGFEcG9yQklCb0krRS9MSjB0WW1GUnRnSnh0UWJNUGdr?=
 =?utf-8?B?RkI2QlBaQ2NaM015QThhOTN3OForTmMySkdteFF4S1RWeGp4VUxzZGZkRU5k?=
 =?utf-8?B?OTJiSzhmeFl3eVo1azFpR1FGZVo1VURmdTlFUFBmdDZLZ2plM0Q3c3F4Ukkw?=
 =?utf-8?B?Z3hwS0lGNlJUZW5VZUdGS1g5ayt2UDFiQ3J5eDAzY2dDSzRzNHNJRklWRWVh?=
 =?utf-8?B?RlZzNTkyRHFyK0gzWStQUXpnRDdmN3J6b1Q3MWZ2ak44bFl6WmpYc2FhdStF?=
 =?utf-8?B?TWVEdnp6Qm5ITkxhZjhsbDZ2T0Q5c0RXZHkrRkpUblBmUXJkbndGdWNvbXB6?=
 =?utf-8?B?ZCsxd25TVTdPWFdraE5kbHAzbnAxOUJta3hrYWJOT1phM0g3aHd2cjNRVGxr?=
 =?utf-8?B?WTBBa1F5eUQ5eEJLYndiSllUck1leVRCYkNFSW5LNHV1OTNZRStIWUtBWlRR?=
 =?utf-8?B?eXkzTnlhdkNLL2VqWno0YkxIbElXa09aQ0VmbWVGRUtYYzBZRHFTSHRPY2hP?=
 =?utf-8?B?WjNVV25ZR212Y1pNL1YvNmZqY0hieUt1WVNDWXY3STQzRGlUVnhIVnhvK3Bo?=
 =?utf-8?B?TDh4RmdUYUFWS1BFcXdMZnFQR2dSOHFmOXo1TTVBYjl5VXlFdWM0d3gyQU5p?=
 =?utf-8?B?UWlnNVYyUHd3dDlrWlgrVmgxRGtXNzJ6Zk9obVozOElHUnk1cmxMeVZhcmZI?=
 =?utf-8?B?MDNsWWxDTTZ1QzdMb2tRcTVtTUN4TklqbXFPMkdyU0NIa0lUWjlWU2IzZDhw?=
 =?utf-8?B?R3VqUVhwYWM0RFV2R1dxejZmQnJhQk50UlJIRnBQbkF4Tkxwd2ViM3hpUVE5?=
 =?utf-8?B?ZnU4SkVUK3R5Sm9SSWw1TXhZUVl0bWNKemZLWmNja3pxNjMxVmNMcTZKTmpV?=
 =?utf-8?B?SW9iVDZrODN6bTF4Zkc2K0JjR1JlODFJcDlicUZQemhORXF6bmR4WEdIekVC?=
 =?utf-8?B?NmwvU2tVQUIvMDJvYlhvSjBJSnpDbzY1QUZ6WTc3TTJVQlgrZGVkREE3YVlE?=
 =?utf-8?B?eHZTRkdVUWNUbG9yWEN6dENCRVIrUVZVQUxCUmphQXNVaS9TNnYvYWExQWhw?=
 =?utf-8?B?V2pERkJXTWdldGRwM3NKSmdURHRjZGJDVkRwcVlDQTJ6bWIrbGhtSW02OXNY?=
 =?utf-8?B?Nlg5eFhxQ01sdXBKajBORm1UTVRFU0JNWHdZUjd3bTF6LzAxVGFTRy9sTXh4?=
 =?utf-8?B?YWI0dGlHZjMxZzRkcUM1NnNrZlNqWE1FY1JVR292YUt4RWp0UXVGMmM4UnRJ?=
 =?utf-8?B?Mjk3RUVsZml4OUlyWFc1anQ0bnhmSC9uVGtPWVNWaUFPMlNoS0hTbUtKWVdO?=
 =?utf-8?B?TWdydUdnTnlPWUNjWEVmTC9YdEh5aFczUmowbGRTbnlqVm9PdHp5WThSSUVm?=
 =?utf-8?B?c0FyYzdtelBwcTQ2ak4yTjhNNHRDRDIwOU1DVjdYVDFNeTR3Yjc3RFpFamVP?=
 =?utf-8?B?R1EvWEZmcUwzTG1rc0YzM3Z1THdaZzJmcWVEWm9NSVBZQkJ2ODhZZ2JFcElt?=
 =?utf-8?Q?ggK7ifaecgGOhqRqK7Rxo094r38sNIaXzf0HwaS/3Nw3?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5821.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QkNFdzcyaUdlWVJTRk1nSUhWdzF2dXA0S0lVcDRaVWwvWGhGSk50NUU4dUJV?=
 =?utf-8?B?aEJWeUMxMVM1UGpNekx3YlF6aWErajIyQjNwY2tjak4vdlNiVmpLd3FQd3J5?=
 =?utf-8?B?QmZCOTdQWnRNNTVUcENWRVVzSkNVbkQvTWJoVzNxdkZXRFVjZVhwNE1WSXVC?=
 =?utf-8?B?ZEV4T3U1Um5HcEpDUlk4RVlSTTBxUXRORzVPOEtOTWs4OGF5UHVZS3g1aHhh?=
 =?utf-8?B?Z0l5MHRJWWpJbkJZeTdFWG92eWRPYTJlWUtTeXFNUEdySWM2NUl4SUJTRTI4?=
 =?utf-8?B?dzJYd3BVaHN3SnVWRExDdnBRTlVsY2s2UnBLUjBpRjlIa0Erak1ia3VpcG1p?=
 =?utf-8?B?QVY3RlhDMHFHaTRLT2l3VVJpaWdyOEJKMmlObHFmMGJaQWZjdEtVYjlMbVVR?=
 =?utf-8?B?ekVnV1F5bDJYck9DVng2NlFmb1NlcDRqMUJKTE5zUmNMMHpDSmgwTXhmb3Rh?=
 =?utf-8?B?V0VXb3didDJVemoybXpZMU92Nnh5dytPTlJDdTBvYndKRWhkYmpIdFNHMWgw?=
 =?utf-8?B?VjVlWUJjVkE5OGxXcXl2eWd0ck0zaDB2TkJ5UUpYR0tDbUV2SE5Wa3JlWWVP?=
 =?utf-8?B?cXVHY1NYc3dYV0VFcFFWVnoxWVpPeSs1V2p6Q0NobXVIMlFuVUY0NzYrRmZY?=
 =?utf-8?B?WE5BVUludUJQZTR3MUJvc1JSa0c5TU5RdXJQZ1J6andyRlBMaTFmL0M4WjFq?=
 =?utf-8?B?dHMzUXZZZHAzdElWNGtwU2J1NFRXclpnRytqbkZLL3pScDBUcVgxbDdGZ0dH?=
 =?utf-8?B?ZHpxejJkVGJaNTBvOVZKTjFlNGFoRmlqOVJaK1cvZ1BWWWFMRjFjWEE3WHp5?=
 =?utf-8?B?ZzVJYktsRElxQy9DSTJMZVF5QldMOXBiUkFiLzhIczR6SkExSDZxMTIwVEhS?=
 =?utf-8?B?Wm13a1BKMUhzdnJwUXhHMnFzL3gvL1Y1T3hoc202ZTVkL015S3ozQzZ0V3hR?=
 =?utf-8?B?cURyUnF0bTk0NkNmb0pueFRsWXJXN0dVaHh4UGVJQzJpZHdxdUNVMnJ3b2ti?=
 =?utf-8?B?bEpqL3psT0ZhRmhMaVJiZW5JazlLbm8reGVnSGZveXU3UEVHaTlkUm0vNzJl?=
 =?utf-8?B?MlBML2dPVFhkSUY3cDJmdUNSeUhYU3MzNkRuUUtBeEV6TGpCMG1DcEV3VlBE?=
 =?utf-8?B?S3NIYkR1Q0NXQ0wxZ2RkdlFIWU92eFpqRktEWXYxdU9WbFFpUGtKTUdJT1BD?=
 =?utf-8?B?bnh1c1RWY2ZaMnRMMklVWHNtUmQwZUlza2hrSlZJVi9CZ1NUOGRwYmF4ekRS?=
 =?utf-8?B?ajE5b1I3NDIyR0lTbmVMK284Q2hHYVBoUDlFc0ZCZWJsT1RqYnFzcDRWZUtF?=
 =?utf-8?B?ZFFONjBJaXpIT1NjbFdSUENyRHVaNmVHa1NSVnpSVkNSYVNYS3lCd1NNR1Fu?=
 =?utf-8?B?VGloVE9HbWJGTUkxU0pYMEJHZjExY0J2ZWdDUXZDNXpVTXpzeXVhVFZaWTYx?=
 =?utf-8?B?WHpabGdFMWJ0b2U2R0NXN2VYcEZGeUNSV0xweWROakgycUV2a1YwZWYxTEdV?=
 =?utf-8?B?ZmxlclBUMDVuM3ZuUHBJdCttTkd4UHl1U2VTSG5EN0N0RS9qcEZkdFZxblBY?=
 =?utf-8?B?OEJ3WjJxbk9GeFk4L2RJYTJzMzNDc08xcE5nN3RMenNwcXBkZW80VDlJekNE?=
 =?utf-8?B?TmhrdjEzM284VmlzcEphM0licHZxbjVQL2dpdG5JZHRHSmpFUWlSZEUyT0Ur?=
 =?utf-8?B?Z2xRenEzbCtxQlI0N25FZGRNUFFndjVOWitnUDJKOWY0Tmc3Qm40ekQ4SGRv?=
 =?utf-8?B?MlExV2Y3L1RSTFpHUnBjVmZaMnA1QlIxU2VGcHNPaVBMc3NPS3FmSTRPaUVM?=
 =?utf-8?B?SXlRdytCcFlBQkEwS3lZeDVDdjAxVjZhdTBoWG1MVmZOR0ZVaWJXaVA0VkJE?=
 =?utf-8?B?UXl2WitGbFU3OHJXb3k5akE4M0FUT3QrbHdSeE1MTEZsM0tyOEEwMjdXeVVs?=
 =?utf-8?B?WExqOW5uWENQWkVzSW1vVEViWm1nMC9lWUxlZ0NLaThTL3BxOWh4UlRlYjNt?=
 =?utf-8?B?WjZXTStEaENSOUpqa2Y5RStoTGdIcC9YWVJKbFlCRzdjTW81dTBvVjhQcTJ1?=
 =?utf-8?B?dCtYc1JCenJNZHZhcVVKZ3dSby9MSVFZV0lYMllaWkFSdzlIWGZEczAvOW9O?=
 =?utf-8?B?S2lwY09ZRXlZYXJDTllPTkt2YWR2TlV4VWpzRlhjb0dHRysxdDQyR0JXdk85?=
 =?utf-8?B?Ykp2dktkeEx5M042YnZnK0VJZE9kOG9nZ0NvNGg0WlR0c3R2c2lYY04rMjho?=
 =?utf-8?B?N3pOSWdEc3RudjM5R2FFaWFFRTU3dUw5bDFtS1RpN2pMN0tQRm4rank1UEJ2?=
 =?utf-8?B?c041cW1iMWNBYUYrUEg4YXErbExUR3pVRDRkVTFROGd6bVpUbWVIdmVHUjFM?=
 =?utf-8?Q?TBfceOZ6kKmhN9kRuXFvfOuUg/v/AiN6oixQ8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADA765D14FA7E9409347ED4FD54589CC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5821.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e512e5ad-b0f8-4ea4-6ce9-08de5abbebb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 20:13:49.2055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KdnmiGgpVPxGLNjXhV5dg5s02KpglZXp+w7YrQPKuHWnbl8IbLB9ru00oMT9Xa1GDBgQR1dc+HwTAYA0iL/+Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR15MB6646
X-Proofpoint-ORIG-GUID: nEjnK_T9hcQc7BfgudtwlxaIxX3l10hE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDE1MSBTYWx0ZWRfX8LZb9yBLE1l+
 RnLk4+k6a543PuCMKe5g7H1ugzK1Ol0joCQff/mZlEWq4Ifg+RsYFxQe8erP1ruE7x71MmXFhlW
 380oCga+OM3OGZ2NCEEnybaexaaLKtPQWwmA1BEQWwG9QOpy8HXmAJrUoldvb0N0aW/9ETGbSvI
 kPnigmAasN22GOf8zrVP655T3qeMU37kdHCIeGFxajR8UuRBzlSn2ckNE238jbpVUJbU8dovO+r
 JyJ3q9+p91SPZlF49HSdpHR0WbLKvQpfFucQe1mxKFQx2wM3q7ErIDtLbczOK5aSgJjOThJ8wk5
 sNgRoDMz9LDW7xaBvGMAopz5YGX7hW853ODGX32pp4aaLby2wwfDKFQj0OVD+B8U9Vwm49Qfoa+
 6ugdoBoZ12K0jT6B9f9JeP2bSJGqIrOyoRQ6IvRLeue1nNYncPZ0N9dLzEujWH5uVchzf4Lx33A
 VaqdJ9Mxj1NGwQgYgMg==
X-Proofpoint-GUID: nEjnK_T9hcQc7BfgudtwlxaIxX3l10hE
X-Authority-Analysis: v=2.4 cv=GY8aXAXL c=1 sm=1 tr=0 ts=6973d681 cx=c_pps
 a=rl9QZQJB4f+cLtFzzj7oTw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=HCR7Wjq02aH-n3YxHSkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601230151
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75310-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CBE007A88F
X-Rspamd-Action: no action

SGkgUWlhbiwNCg0KSSBoYXZlIGNvbXBpbGVkIGFsbCBwb2ludHMgZnJvbSBvdXIgZGlzY3Vzc2lv
biBbM10uIEkgc3VnZ2VzdCB0byB5b3UgdG8gYmUgYQ0KZmlyc3Qgc3BlYWtlciBmb3IgdGhlIHRv
cGljIGFuZCBJIGNhbiBqb2luIGFzIGNvLXNwZWFrZXIgYW5kIHdlIGNhbiBtYWtlIHRoZQ0KaW50
ZXJhY3RpdmUgZGlzY3Vzc2lvbi4gV2lsbCBpdCB3b3JrIGZvciB5b3U/DQoNCkhpIEFkYW0sIEph
dmllciwNCg0KSSBiZWxpZXZlIHdlIGNhbm5vdCByZXVzZSB0aGUgbG9jYWwgZmlsZSBzeXN0ZW0g
YXBwcm9hY2ggZm9yIGRpc3RyaWJ1dGVkIGZpbGUNCnN5c3RlbXMgKGxpa2UgQ2VwaCwgZm9yIGV4
YW1wbGUpLiBXZSBuZWVkIHRvIG1ha2UgdGhlIGFjY3VyYXRlIGJlbmNobWFya2luZywNCmFuYWx5
emUgaG93IGl0IHdvcmtzIGluIENlcGggZW52aXJvbm1lbnQsIGZvciBleGFtcGxlLCBhbmQgZGlz
Y3VzcyBhIGdvb2QNCmFwcHJvYWNoIG9mIGVtcGxveWluZyB0aGUgRkRQIFNTRHMgaW4gZGlzdHJp
YnV0ZWQgZmlsZSBzeXN0ZW0gZW52aXJvbm1lbnQuIENvdWxkDQp5b3UgcGxlYXNlIHN1cHBvcnQg
UWlhbj8gSSBiZWxpZXZlIGl0IGNvdWxkIGJlIGdvb2QgZGlyZWN0aW9uIGZvciB0aGUgd2hvbGUN
CmZhbWlseSBvZiBkaXN0cmlidXRlZCBmaWxlIHN5c3RlbXMuDQoNCkhlbGxvIENvbW11bml0eSwN
Cg0KRmxleGlibGUgRGF0YSBQbGFjZW1lbnQoRkRQKSBpcyBhIG5ldyBkYXRhIHBsYWNlbWVudCB0
ZWNobm9sb2d5IGhhcyBiZWVuIG1lcmdlZA0KaW4gTlZNZSBzcGVjaWZpY2F0aW9uIHYyLjEuIEl0
IGFsbG93cyB0aGUgaG9zdCB0byBjb250cm9sIHdoZXJlIGRhdGEgaXMgd3JpdHRlbi4NCkZEUCBT
U0RzIHN1cHBvcnQgZGlyZWN0aXZlcyB0aGF0IGRpZmZlcmVudGlhdGUgZGF0YSBsaWZldGltZSBh
bmQgcGxhY2UgZGF0YSBpbnRvDQpzZXBhcmF0ZSBzdHJlYW1zIHRvIHJlZHVjZSB3cml0ZSBhbXBs
aWZpY2F0aW9uKFdBRikuIE1vcmUgYW5kIG1vcmUgdmVuZG9ycyBoYXZlDQpiZWVuIGludm9sdmVk
IGluIEZEUCBTU0RzIHNpbmNlIDIwMjQuDQoNClRoZSB0d28gbW9zdCBpbXBvcnRhbnQgY29uY2Vw
dHMgaW4gRkRQIGFyZSBSZWNsYWltIFVuaXQoUlUpIGFuZCBSZWNsYWltIFVuaXQNCkhhbmRsZShS
VUgpLiBBIGRldmljZSBjYW4gYmUgdmlld2VkIGFzIGEgY29sbGVjdGlvbiBvZiBSVXMuIEFuIFJV
IHByb3ZpZGVzIHRoZQ0KcGh5c2ljYWwgY2FwYWNpdHkgZm9yIHN0b3JpbmcgZGF0YSBhbmQgaXMg
YWxzbyB0aGUgc2luZ2xlIGVyYXNhYmxlIHVuaXQgdXNlZCBieQ0KdGhlIGNvbnRyb2xsZXIgZHVy
aW5nIEdhcmJhZ2UgQ29sbGVjdGlvbihHQykuIEFuIFJVSCBjYW4gYmUgdW5kZXJzdG9vZCBhcyBh
DQpyZWZlcmVuY2UgdG8gYW4gUlUuDQoNCkluIHN1bW1hcnksIHRoZSBiaWdnZXN0IGFkdmFudGFn
ZSBvZiBGRFAgY29tcGFyZWQgdG8gY29udmVudGlvbmFsIFNTRHMgbGllcyBpbg0KdGhlIGZsZXhp
YmlsaXR5IGl0IHByb3ZpZGVzIHRvIHRoZSBob3N0IGVuYWJsaW5nIHByZWNpc2UgY29udHJvbCBv
dmVyIGRhdGENCnBsYWNlbWVudCBpbnRvIGlzb2xhdGVkIFJVcyB2aWEgUlVIcy4gVGhpcyBmZWF0
dXJlIGFsbG93cyBkZXZlbG9wZXJzIHRvIHBsYWNlDQpkYXRhIHdpdGggc2ltaWxhciBsaWZldGlt
ZXMgaW50byB0aGUgc2FtZSBSVS4gQXMgYSByZXN1bHQsIGR1cmluZyBHQywgbW9zdCBkYXRhDQpp
biBhbiBSVSBiZWNvbWVzIGludmFsaWQgc2ltdWx0YW5lb3VzbHksIHNpZ25pZmljYW50bHkgcmVk
dWNpbmcgdGhlIGFtb3VudCBvZg0KdmFsaWQgZGF0YSB0aGF0IG5lZWRzIHRvIGJlIG1pZ3JhdGVk
LiBUaGlzIGdyZWF0bHkgbG93ZXJzIHdyaXRlIGFtcGxpZmljYXRpb24NCmFuZCBleHRlbmRzIGRl
dmljZSBsaWZlc3Bhbi4NCg0KU2luY2UgY29tbWl0IFsxXSwgYm90aCBmaWxlIHN5c3RlbXMgKGYy
ZnMsIGV4dDQsIGJ0cmZzKSBhbmQgdGhlIGJsb2NrIGxheWVyIGluDQp0aGUgTGludXgga2VybmVs
IGhhdmUgc3VwcG9ydGVkIGRhdGEgbGlmZXRpbWUgZmllbGRzLiBUaGUga2V5IGZpZWxkcyBpbnZv
bHZlZA0KYXJlIGlfd3JpdGVfaGludCBpbiBpbm9kZSBhbmQgYmlfd3JpdGVfaGludCBpbiBiaW8u
IEluIDIwMjUsIGNvbW1pdCBbMl0gZXh0ZW5kZWQNCnRoZSBrZXJuZWwgZHJpdmVyIGFuZCBpb191
cmluZyB0byBzdXBwb3J0IEZEUCBmZWF0dXJlLiBOb3RhYmx5LCBiaV93cml0ZV9zdHJlYW0NCmlz
IGVzc2VudGlhbGx5IHJlZHVuZGFudCB3aXRoIGJpX3dyaXRlX2hpbnQuDQoNClRoZSBhcHByb2Fj
aCBvZiBzaGFyaW5nICJ0ZW1wZXJhdHVyZSIgaGludHMgZm9yIGZpbGVzIGZyb20gYXBwbGljYXRp
b24gc2lkZQ0KbWFrZXMgY29tcGxldGUgc2Vuc2UgZm9yIHRoZSBjYXNlIG9mIGxvY2FsIGZpbGVz
eXN0ZW1zIChleHQ0LCBmMmZzLCBidHJmcywgZXRjKS4NCkJlY2F1c2UsIGFzIHVzZXIgZGF0YSBh
cyBtZXRhZGF0YSBsaXZlcyBpbiB0aGUgc2FtZSBsb2NhbCBwYXJ0aXRpb24gdGhhdCwgbW9zdA0K
cHJvYmFibHksIHNpdHMgaW5zaWRlIG9uZSBzdG9yYWdlIGRldmljZS4gQXMgYSByZXN1bHQsIGZp
bGUgY29udGVudCdzIGxvY2F0aW9ucw0KYXJlIGNvbXBsZXRlbHkgZGV0ZXJtaW5pc3RpYyBhbmQg
aXQgbWFrZXMgYmlnIHNlbnNlIHRvIHNoYXJlIGhpbnRzIHdpdGggRkRQIFNTRA0KdG8gZGVmaW5l
IGdvb2QgZGF0YSBwbGFjZW1lbnQgcG9saWN5Lg0KDQpCdXQgdGhpcyBhcHByb2FjaCAoc2hhcmlu
ZyBmaWxlJ3MgInRlbXBlcmF0dXJlIiBoaW50cykgY29tcGxldGVseSBkb2Vzbid0IG1ha2UNCnNl
bnNlIGZvciBkaXN0cmlidXRlZCBmaWxlIHN5c3RlbXMgbGlrZSBDZXBoLCBmb3IgZXhhbXBsZS4g
QmVjYXVzZSwgYXBwbGljYXRpb24NCmhhcyBubyBpZGVhIGFib3V0IENSVVNIIGFsZ29yaXRobSdz
IGRhdGEgZGlzdHJpYnV0aW9uIGxvZ2ljLCByZXBsaWNhdGlvbiBwb2xpY3ksDQpkYXRhIG1pZ3Jh
dGlvbiBwb2xpY3ksIGV0Yy4gU28sIGZpbGUncyAidGVtcGVyYXR1cmUiIGhpbnRzIGFyZSBjb21w
bGV0ZWx5DQp1c2VsZXNzIG9uIE9TRCBzaWRlLiBBcHBsaWNhdGlvbiBoYXMgbm8gaWRlYSBob3cg
dG8gImFkdmlzZSIgT1NEcyBvbiBnb29kIGRhdGENCnBsYWNlbWVudCBwb2xpY3kuIFBvdGVudGlh
bGx5LCBpdCBtYWtlcyBzZW5zZSBvZiBtYW5hZ2luZyBGRFAgU1NEIGNvbXBsZXRlbHkgb24NCk9T
RCBzaWRlIHdpdGhvdXQgYW55IGhpbnRzIGZyb20gY2xpZW50IHNpZGUuIEFuZCB0aGlzIGRhdGEg
cGxhY2VtZW50IHBvbGljeQ0KY291bGQgYmUgb2JqZWN0LWJhc2VkIG9uZS4NCg0KUmVnYXJkaW5n
IGRpc3RyaWJ1dGVkIGZpbGUgc3lzdGVtIG5hdHVyZSwgaXQgbmVlZHMgdG8gdGFrZSBpbnRvIGFj
Y291bnQ6ICgxKQ0KbXVsdGlwbGUgY2xpZW50cyBlbnZpcm9ubWVudCwgKDIpIGZpbGVzIGNhbiBi
ZSBkaWZmZXJlbnQgaW4gc2l6ZSBpbiB0aGUgc2FtZQ0KZmlsZSBzeXN0ZW0gaW5zdGFuY2UsICgz
KSBmaWxlcyBjYW4gYmUgY29sZCwgd2FybSwgaG90IGluIHRoZSBzYW1lIGZpbGUgc3lzdGVtDQpp
bnN0YW5jZSwgKDQpIGJpZyBmaWxlIGNhbiBiZSBob3QgaW4gb25lIHJlZ2lvbiBhbmQgY29sZCBp
biBvdGhlciBvbmVzLCAoNSkgT1NEDQpjYW4gZG8gZGF0YSByZXBsaWNhdGlvbiwgbWlncmF0aW9u
LCByZS1kaXN0cmlidXRpb24sIGV0Yy4NCg0KSW50ZXJlc3RpbmcgdXNlLWNhc2VzOg0KKDEpIEJp
ZyBjb2RlIGJhc2UgY29tcGlsYXRpb24gKGZvciBleGFtcGxlLCBMaW51eCBrZXJuZWwgY29tcGls
YXRpb24pDQooMikgRGF0YWJhc2UgdXNlLWNhc2UNCigzKSBWaXJ0dWFsIG1hY2hpbmVzDQooNCkg
TUwvQUkgdHJhaW5pbmcgcGhhc2UNCg0KVXNlLWNhc2UgMSAoYmlnIGNvZGUgYmFzZSBjb21waWxh
dGlvbikNClRoaXMgdXNlLWNhc2UgY29udGFpbnMgbXVsdGlwbGUgc21hbGwgZmlsZXMgKDEwIC0g
MTAwIEtCcyBpbiBzaXplIGVhY2gpLiBGaXJzdA0Kb2YgYWxsLCBmaWxlcyBhcmUgc21hbGwgaGVy
ZSBhbmQgb25lIENlcGggb2JqZWN0IHNob3VsZCBjb250YWluIG11bHRpcGxlIHNtYWxsDQpmaWxl
cy4gU28sIHBvdGVudGlhbGx5LCB3ZSBjb3VsZCB0cmVhdCB0aGUgbWFpbiBmaWxlcyBvZiByZXBv
c2l0b3J5IGxpa2Ugd2FybQ0Kb25lcy4gVGhlIGNvbXBpbGVkIGFydGlmYWN0cyBjYW4gYmUgdHJl
YXRlZCBsaWtlIHNob3J0IGxpZmV0aW1lIG9iamVjdHMuIEV2ZW4gaWYNCmFwcGxpY2F0aW9uIHNo
YXJlcyBmaWxlcycgInRlbXBlcmF0dXJlIiBoaW50cywgdGhlbiB0aGVzZSBoaW50cyB3aWxsIGJl
DQpjb21wbGV0ZWx5IHVzZWxlc3Mgb24gT1NEIHNpZGUuDQoNClVzZS1jYXNlIDIgKERhdGFiYXNl
IHVzZS1jYXNlKQ0KRGF0YWJhc2UgY2FzZSBjYW4gYmUgcmVwcmVzZW50ZWQgYnkgbXVsdGlwbGUg
YmlnL2h1Z2UgZmlsZXMgYW5kIGV2ZXJ5IGZpbGUgY2FuDQpiZSBhY2Nlc3NlZCBieSBtdWx0aXBs
ZSBDZXBoIGNsaWVudHMuIEJ1dCBldmVuIGlmIGJpZyBmaWxlIGlzIHVwZGF0ZWQsIHRoZW4gaXQN
CmRvZXNuJ3QgbWVhbiB0aGF0IHRoZSB3aG9sZSBmaWxlIGlzIHVwZGF0ZWQuIFNvbWUgcG9ydGlv
bnMgb2YgdGhlIGZpbGUgY291bGQgYmUNCmhvdCBidXQgYW5vdGhlciBvbmVzIGNvdWxkIGJlIGNv
bGQvd2FybS4gT2YgY291cnNlLCB3ZSBjYW4gZXN0aW1hdGUgdGhlIGF2ZXJhZ2UNCiJ0ZW1wZXJh
dHVyZSIgb2YgdGhlIGZpbGUuIEJ1dCwgQ2VwaCBzdG9yZSBkYXRhIGluIDRNQiBvYmplY3RzIGFu
ZCBpdCBtZWFucyB0aGF0DQpkaWZmZXJlbnQgcGFydHMgb2YgdGhlIGZpbGUgd2lsbCBiZSBzdG9y
ZWQgaW4gb2JqZWN0cyB0aGF0IHdpbGwgZ28gaW4gZGlmZmVyZW50DQpPU0RzLiBBcyBhIHJlc3Vs
dCwgT1NEcyB3aWxsIHJlY2VpdmUgY29tcGxldGVseSB3cm9uZyBoaW50cy4NCg0KVXNlLWNhc2Ug
MyAoVmlydHVhbCBtYWNoaW5lcykNClZpcnR1YWwgTWFjaGluZSBjYXNlIHJlbWluZHMgdGhlIGRh
dGFiYXNlIGNhc2UuIEJ1dCBpdCBjb3VsZCBiZSBtb3JlIGNvbGQgb25lLg0KQmVjYXVzZSwgVk0g
aW1hZ2UgaXMgaHVnZSBmaWxlIGFuZCBpdCB3aWxsIGJlIHNwbGl0IG9uIG11bHRpcGxlIENlcGgg
b2JqZWN0cw0KdGhhdCB3aWxsIGJlIHNlbnQgdG8gZGlmZmVyZW50IE9TRHMuIEFuZCB2YXJpb3Vz
IHBvcnRpb25zIG9mIFZNIGltYWdlIHdpbGwgYmUNCnVwZGF0ZWQgZGlmZmVyZW50bHkgZHVyaW5n
IFZNIGluc3RhbmNlIHJ1bm5pbmcuIFdlIGNhbiBtZWFzdXJlIHRoZSBhdmVyYWdlDQoidGVtcGVy
YXR1cmUiIG9mIHRoZSBmaWxlIGJ1dCB0aGlzIGhpbnQgY291bGQgYmUgY29tcGxldGVseSB1c2Vs
ZXNzIG9uIE9TRCBzaWRlLg0KDQpVc2UtY2FzZSA0IChNTC9BSSB0cmFpbmluZyBwaGFzZSkNClRo
aXMgY2FzZSBpcyBtb3N0bHkgcmVhZCBpbnRlbnNpdmUuIEhvd2V2ZXIsIE1MIG1vZGVsIHdlaWdo
dHMgY291bGQgYmUgYSBiaWcNCmZpbGUgdXBkYXRlZCBmcmVxdWVudGx5LiBUaGlzIGZpbGUgbmF0
dXJlIGNvdWxkIGxvb2sgc2ltaWxhciB0byBWTSBvciBkYXRhYmFzZQ0KY2FzZS4gQnV0IHJlYWQg
aW50ZW5zaXZlIG5hdHVyZSByZXByZXNlbnRzIE5BTkQgZmxhc2ggcmVhZCBkaXN0dXJiYW5jZS4g
QW5kDQpzaWduaWZpY2FudCBudW1iZXIgb2YgcmVhZCBvcGVyYXRpb25zIGRlZ3JhZGUgTkFORCBm
bGFzaCB0b28uIEZpbmFsbHksIFNTRCB3aWxsDQpuZWVkIHRvIG1vdmUgZGF0YSBpbnRlcm5hbGx5
IGZyb20gZGVncmFkZWQgZXJhc2UgYmxvY2tzIGludG8gY2xlYW4gb25lcy4gQW5kIHdlDQpzdGls
bCBoYXZlIHRoZSBzYW1lIGlzc3VlIGhlcmUuIENlcGggb3BlcmF0aW9ucyBhcmUgb2JqZWN0IGJh
c2VkIGFuZCBpdCBuZWVkcyB0bw0KZWxhYm9yYXRlIGEgZ29vZCBkYXRhIHBsYWNlbWVudCBwb2xp
Y3kgb24gb2JqZWN0IGJhc2lzLg0KDQpJIHRoaW5rIHdlIG5lZWQgdG8gZWxhYm9yYXRlIG11Y2gg
YmV0dGVyIGFwcHJvYWNoIGZvciBGRFAgU1NEcyBpbiB0aGUgY2FzZSBvZg0KZGlzdHJpYnV0ZWQg
ZmlsZSBzeXN0ZW1zLiBJIGJlbGlldmUgdGhhdCBpdCBuZWVkcyB0byBleGVjdXRlIGFjY3VyYXRl
DQpiZW5jaG1hcmtpbmcgb2YgYWJvdmUgbWVudGlvbmVkIHVzZS1jYXNlcyB3aXRoIGFuYWx5c2lz
IG9mIHBlY3VsaWFyaXRpZXMgb2YNCmRpc3RyaWJ1dGVkIGZpbGUgc3lzdGVtcyBjYXNlLiBGaW5h
bGx5LCB3ZSB3aWxsIGJlIGFibGUgdG8gYW5hbHl6ZSB0aGVzZSByZXN1bHRzDQphbmQgdG8gZWxh
Ym9yYXRlIGEgdmlzaW9uIG9mIHByb3BlciBzb2x1dGlvbiBmb3IgZGlzdHJpYnV0ZWQgZmlsZSBz
eXN0ZW0gY2FzZQ0KKGxpa2UgQ2VwaCwgZm9yIGV4YW1wbGUpLg0KDQpTbywgSSBzdWdnZXN0IHRv
IG1lZXQgYXQgTFNGL01NL0JQRiBhbmQgdG8gZGlzY3VzcyB0aGUgYmVuY2htYXJraW5nIHJlc3Vs
dHMgYW5kDQpwb3RlbnRpYWwgdmlzaW9uIG9mIHRoZSBzb2x1dGlvbi4NCg0KVGhhbmtzLA0KU2xh
dmEuDQoNClsxXSBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvY29tbWl0LzQ0OTgx
MzUxNWQzZQ0KWzJdIGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9jb21taXQvMzhl
ODM5N2RkZTYzDQpbM10NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2NlcGgtZGV2ZWwvOTA3Zjgx
NDU3OTFlMDM5OTZjMmM4MzljNWQ4Nzc4MzZmMmQ2Yjc3Yy5jYW1lbEBpYm0uY29tL1QvI3QNCg==

