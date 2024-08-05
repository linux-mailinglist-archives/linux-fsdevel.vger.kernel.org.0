Return-Path: <linux-fsdevel+bounces-25004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4DF947A0F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 12:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A630FB212FA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 10:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A289E1547C6;
	Mon,  5 Aug 2024 10:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="mBMitNzZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A3C1311AC
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Aug 2024 10:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722854947; cv=fail; b=fXvQvGrWHI0ygUFdQATvtXxBkzlE9LxLs8HZ/Os27PJajuw5cT4XCC4NeBdrO1qwOqZteVW4tve+sg93o0CLFVWeelhtDToEECiVAWD4CCyadjGCDfT4zWxe0cmacOiED0+zkinrR+vs2TKQuIPTZX2S6IjqGMjiHB+yVCMN1RU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722854947; c=relaxed/simple;
	bh=OD6UZKaCwRrFfJJRRZWO6tmH7Q0WAYHjRZZkqSwtSoM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dKrHPU95ZI8qlMmWtCtUwAdLT3t0aXVJOeyrLvZoBK1Knw5HzNZjs9Q8ZrAmmenahxL1mNAdiKc4bTXDNspGFZOq1gnhlu+CLTdGLvMQ40MMHcq5HpyOR5LrL1W4gvxk39sugdE45rp+b0YyfGt0s6EAq3MN1SNqPr+LNId5vnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=mBMitNzZ; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 475AVqnj022436;
	Mon, 5 Aug 2024 10:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=bqJnNHbI6Rvhs1iL3tBU8E41+JYVH
	GEDkpwskQUgpjM=; b=mBMitNzZlHRR3pqIHLwogSFaqi0xYq3BdjcWn9CorXILE
	KdZSYIFtI0ljOBIoOoHNVZaZvVEhDHBsqaebahbIlr+xO+Uy8w7TrzPYHhulyqKm
	4IB2Qvz+9pLrokpZfSVq21XDKOxfxQKWAbCm67kGUt1gi82FFKBEorA9F/Fu1tPL
	GiaKBLqfqoX0FXTOuHtkwYHIwYEUlq1QnZmz8ujrJDnQWI6T7ztNrgwfzzHcsw9n
	e/98m7fderEbzCEVjNVmJi9ZEQ1uPbAk0WI+ayi7H2aV0JjnSSRsT6vs9FxJUaYE
	+35iRF9urO+YoDpnYEnQEtQVQNEdhwXLXXZ8eUHsg==
Received: from hk3pr03cu002.outbound.protection.outlook.com (mail-eastasiaazlp17011031.outbound.protection.outlook.com [40.93.128.31])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 40s9sxhpfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 10:48:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4kDCX45U0PjT5vWOS4TFz0Zz/Xq6acO8bmwbFHsjXQYyDry10ClrTrStbwDXL3yapibkDB8pkmbDgQNsDNz7h11jtIRqVl8lgf53A5PSbTPdu6ZRyMhuaJ2+HrcsG3b6aHQuIWJeVftzDrZ8+pWbBq8x/5qtsH7ORFh5TNafJtSgGJiDFjnLfUBmC7DA4BlrYyh7/FABL08YsR7f5IykYrNwo8gdkbAdtVEZzdHX7uputlRRAM9qPf4nDt8a91S/fTrDJCV2WhtIPydBgruZoatWfRkKqH2/XOSKTKda0k5aBl6M+N9l8Fb8zBCVVT8YANAIEyhUE1EJqOK9IVfzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqJnNHbI6Rvhs1iL3tBU8E41+JYVHGEDkpwskQUgpjM=;
 b=DWNoXfeE7MksMfcjBe9MLJrATXtl8Ncxar3OS0WNgsf+iNP3S9XAjFtISeCTd4mthX2rpqMMyhW9umBqqheOuHrTkdzNyZYsKxV6p8fTar0M2DeVhNpdO/0FhS7b3y/UkZdATOuAd/8DQ5+qMXItBaCR3bdBGTtGPc8VbCbsCuoMiNlgOYQ9jzcIryPn5iis0LSzZTr96XsGVUBmedr3d82nr3npw5GOVYVPYMbD2oae0boRAj8qDwplOK5b0XSpTJ4jUiKEkqClD5U2F5JN2jH1cohwJ2XJXzrMT1pkefr3e8sQgs++aauOtGsnTHXa9ezY3FZHt3DtogLR4BlvCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEYPR04MB5932.apcprd04.prod.outlook.com (2603:1096:101:8d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Mon, 5 Aug
 2024 10:48:34 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.7828.016; Mon, 5 Aug 2024
 10:48:33 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v3] exfat: move extend valid_size into ->page_mkwrite()
Thread-Topic: [PATCH v3] exfat: move extend valid_size into ->page_mkwrite()
Thread-Index: AQHa5yRRdo/FBEhmQUq8IBWuW2EmUw==
Date: Mon, 5 Aug 2024 10:48:33 +0000
Message-ID:
 <PUZPR04MB6316D45F18DD7DD43AC98F4581BE2@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEYPR04MB5932:EE_
x-ms-office365-filtering-correlation-id: 06cf8ae6-6589-445d-30d4-08dcb53c26f9
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?q3vARDJsxnkPgG60YAIoKEVaZZYtpZFSXG6QBZISbaSppljVzDf2SkHcU1?=
 =?iso-8859-1?Q?yvmflNL3KIWpPp0ZcEVs52rgcxSHzbBvf0I0iFE8j5NtBrWs6g0QI53AX1?=
 =?iso-8859-1?Q?Viyd6txtW9eZbSqKhWfx9gSoKdkQinranSdf0Tfyfa0o6BAbhrGlEeM2B3?=
 =?iso-8859-1?Q?qCsQzXXcHRgJ3tLLpWDotpR35aALDa6dtyKxALX1GgPS5MQLoFTq8GGFga?=
 =?iso-8859-1?Q?mq1NPGCpAp8+oG2gjGms6O1Yd/nfVLm0Sr6Vylo2mRSAJn8hqezFnd5zzU?=
 =?iso-8859-1?Q?dSivODGUJ5p6I47ksZ88pq+m2TDJSzeUdXmnXrHglUP0/UO3TDYvPyhYSW?=
 =?iso-8859-1?Q?CO54Qsg6N/Qe6e/bwYxaccNqaw3lT14F+gy3JfBjMOW82vWo5aYHKa2AUh?=
 =?iso-8859-1?Q?S3fAusRQVcWmUfjc9B4EcEZ8jcx1yfe2ho3iGRNPSZtHhEaCKt9kfAgLm9?=
 =?iso-8859-1?Q?dvG0x+vWxYWPEPCKKvJPVENleCB9yqPZuqdZwhoJNzvZBEZVhrj9vW5/sS?=
 =?iso-8859-1?Q?xhwgWrprHeSUsQTiT/71BSayEudm38O/pbx9tH5vydLEMvmpavU4Ju6jLF?=
 =?iso-8859-1?Q?0Z/P8QHFKLuGmWXtLwOzGI7DPaAXYoZfP/Y6dy9DYvM4a7E+Geg07Am+PF?=
 =?iso-8859-1?Q?Z2HaxPNyEldRa8hOb8AgCRR3my/8AgszVN+1RBf5BszAfjCrpTpz7MqRGs?=
 =?iso-8859-1?Q?Qp7GMjYXtS72DYwHxYMiPMR5YqZvjYBPYNMwnN+vJWTbkjHdme2ND/EMe1?=
 =?iso-8859-1?Q?6b4vwH28nHjkNTrcZv8eBSySBBaVKAkV2AF8PM8TO5A5UiGdjQ0dln9ZPR?=
 =?iso-8859-1?Q?NldNzXSqs2xP/SREQU+FAoLGZZn8RUT5UnFwBqIRZU/hI4PUWAMWlKDKZe?=
 =?iso-8859-1?Q?SnuWopPwanvnhf/Xp659GCbyNGnITVGqZn13Krp2HTsf4zzeyLMCbopt3F?=
 =?iso-8859-1?Q?2Bpe7WBenkD7DlKfAKD79BiJ0YcBU+D1iOO5LPi1KIygOlcEHeP/BFYJhg?=
 =?iso-8859-1?Q?GCFI8MhmxnYzllKZsd2FhTHCyx2fk+ibnYaQCosjVzxXl8FBR6TIwgaJia?=
 =?iso-8859-1?Q?T/IHk0HmFUt/FVh5qwIdgJjqpwVPSx5qS91SGHceR96s5/Ai1TbAK1y/+8?=
 =?iso-8859-1?Q?k3d3evqJt3zW/sWvvEA+mpEZiky+33+vtdpAaBv4IBzf4QLf0c1PiPAZLk?=
 =?iso-8859-1?Q?oStx+iZnpbmeY1BIukp4LVtKZNkTUUvaOnWCZpLkMWgX2ZvMtwGEikOEKs?=
 =?iso-8859-1?Q?EFHz9t7RiEbtaezQHA1VLNrybtLJg3hrk5kjHbf88d441Oq6fO1KIPyDsl?=
 =?iso-8859-1?Q?CVh8wXQUglZYnK5l+JpoV8htR1YL55tjwcx/Loxycboe9dC//hrAaYkwF/?=
 =?iso-8859-1?Q?bN7mRkHRzYShgu55CfnjeuiecDcEFi7YR88GAkfTdlBlxu1kn8uYP0e2MW?=
 =?iso-8859-1?Q?7fHQg+G6KnO75NR0U7i7g0sReBBffa0wRZQ27g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CpKF4W0go8kwgiGdGG4fxsU/BbFqwziRAXXjf5FDigxHa1GTDX6KlddhE1?=
 =?iso-8859-1?Q?uh3ZAitnOMFc9fv+l+fAEpIsn0DBCw+H8N098TAOdxxes0Rgrr3VS7C2p3?=
 =?iso-8859-1?Q?pMVI4QLX+2lgpeM35nrifi0vJuK0+OJNsNu0uQm3U5pSYXCfbKQKBYKbOD?=
 =?iso-8859-1?Q?StJXBxaYE89gqF5EId73yJtoMB1qwJpjTGMsBWxRKqJ4lsfeLbN7bcotrr?=
 =?iso-8859-1?Q?tLinFk9pbngkp/+Je5v4WvzybXJwZr2/oh8D3JtgUxbDX1Yg12QIVjMu1Q?=
 =?iso-8859-1?Q?813YwDxFK8LKmHJWCeHm2KWtYeZFn4NMcZ0qK16kvtD3LGevmwmQw5tupg?=
 =?iso-8859-1?Q?graFziU9odFhgN+q7xRjrRBIUirwe6nrxwwUDI0WZ4/HQhbSXe0mpUvo3I?=
 =?iso-8859-1?Q?6Kgz994d0AVh+sCdJSj+pl5BeWwESenRiNy81mGBhcVt+zFLblgolxU054?=
 =?iso-8859-1?Q?g5ZBtQIPa2/sAKPWGhi3oddZui9oI32mCUI8ghP5Wfq/TEUwAlWZSyGrhx?=
 =?iso-8859-1?Q?egmH86iCWrszRsDErzPNJITIirJybzGupXQpZHYujSRpV/Na6W50VxLcAJ?=
 =?iso-8859-1?Q?oSrU5qBmDaexeZpRiYZRmrupBC5H1K+3hDnLT1eOrRxv2GqDZCIeA/RnpO?=
 =?iso-8859-1?Q?95yKwkBTDxk21DCfS7Ppwqs1OeJjBO4FeoxBxdLsynMcGppS91QFItleft?=
 =?iso-8859-1?Q?QhYaY7wunGrGSW1oINj+xD2IBKUCJWAuJjFnAlsf75iqXAL+L8KDtJykuq?=
 =?iso-8859-1?Q?Qjao9oM74vfK3DHasYlw79QmgjUh3vc+Pd6beEX9obL5pMIkbXpPteQmwM?=
 =?iso-8859-1?Q?MixaYG620vCwtWnhkPcXnbv6lWpF8WRF/3jy4TycYp+kjw3OjQ16LVaSCV?=
 =?iso-8859-1?Q?1etnhpwgQS0od4/twDXhZmQFr1G+vMOGFvR76YIqfJijMsUWaKoOSavtpc?=
 =?iso-8859-1?Q?Zz+tg4H/Z+aWOQm7QS8ifUg6Xbdu+ArMPOErILOCyEW+fjPnK3Lh+Gc0W8?=
 =?iso-8859-1?Q?HBJ92/4m7Jxbb6ldWCB853OS8o3yylViE+ktMxYbX6pUCOtdhASEkBUgoy?=
 =?iso-8859-1?Q?YLQMJvUg/rOkcNu6oPGEkRvq2MYoaqTrDM/YxIWYkK6qjCNPYC7l2M/5Eh?=
 =?iso-8859-1?Q?GvsWmXOdjRz3bmvMRywoRZzSL0vvsTBdH0WD09+WhUV/vS7OAFBs8EkWla?=
 =?iso-8859-1?Q?4xE4nvFxzURsSbg5Cy9YcgRQyu18O0DKRk8YwurtJYSbDfMIF5y/81Sbx/?=
 =?iso-8859-1?Q?o/paD9aREFanEtUmGt3nxEpsIag5CPswDE3eXR9kWAAPyEKaSpGkiZQY7I?=
 =?iso-8859-1?Q?TGjcQwMkyPJd9WW2tRvxYdAuL3QNbT9g051Mmk1nSY10HoE4HnUYX0m93m?=
 =?iso-8859-1?Q?AziWX7S6RxPFUcTqDat3fLs8hlVeHSzOP+pebGj6NgAqpRXu0bPffSifu8?=
 =?iso-8859-1?Q?sMW6UdQBD/0tL9JcDE10ImBOq9L5IfNIAKEsaZjK4VQCCpATcWzOKpIL4l?=
 =?iso-8859-1?Q?ESt3tQwiK17n/Jg+pqjyfntYkmlL+RKP2aAaBrdxarvpAvOMDUQCulglTp?=
 =?iso-8859-1?Q?Zn1GuCdItfYQVcMTxR3LYJIKZpJxTtwiY1s6NjQbG8APIkGtuOx1cH2/dC?=
 =?iso-8859-1?Q?AhiAhc/HP7xkiUBnEUtJps/JQ5yjASo7RfxxQFxRASRKfDPBnbwiWVE7jS?=
 =?iso-8859-1?Q?/EuO26NpxhPnuw+NiVk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BdDqc1XW9DdiYH2Jkn3Yls42++NLjoaFcvGTAPS8wP4gdPFKyl0k4bE4yftmWegtCVS6qtvr/LCnujhbvXNKzrpZM9xj6mxHuaxjY5qExgTT7JqsfRaSJa9j8cjqhFAmj89jHdMyRlXUc4xKiZ4GUlwF075nBVELPrrNJ1pLN/a5zBwUOBLiZowv3fA3uVIsQCat7ujv/LekLHqJQAlVn4AgM7W5X3UeHXJhtvkXB7XHwk5rMcIbTtePEM6StEspTQjNjInewBIj10cvHr6bnvkp98YrqLl3u4AP6WtxnRWhvIEBf2GdUxioiOzprf5iwv/QpUsYLDOQG/V64FNw4T4NH1dsj+0xDcHS1ZrDIf05HLjPD3aAV9ZFQh9CMsQ9xF4PcGGnAaez1ooUuotGGXMiE3BPWgU4IJB//28V1Ep5oflZnKK7GwXB/YDaSGKyNF88EB93Ptss5SrmoZ/KSQvaWK9gdcuoR470Fdd2O9hexYH3MwkLlBZXz9pws6XCPlQ5lVK8Z2lE1C3bWaaBVQtWl5LJQCSuROhq62kOOP7o74L8sDym1MqIztc6egIvwR/4QhpretoukS+i48U+ypKT6pNiqidcAipkDX1SLyXzWYMM83ttksHa6gqY/OSy
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06cf8ae6-6589-445d-30d4-08dcb53c26f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 10:48:33.6169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N/dHhnRZtpv8mq/xxHnjLv6B2NofU5bXMXSdHhczC2Obl2zAggDeUYfMU6CQvO9qh+JEluAGDIOktq6vSyDEHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB5932
X-Proofpoint-GUID: Gtj_0gLe7LbTz_dmBfE12LP8d3puTeUY
X-Proofpoint-ORIG-GUID: Gtj_0gLe7LbTz_dmBfE12LP8d3puTeUY
X-Sony-Outbound-GUID: Gtj_0gLe7LbTz_dmBfE12LP8d3puTeUY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-04_14,2024-08-02_01,2024-05-17_01

It is not a good way to extend valid_size to the end of the=0A=
mmap area by writing zeros in mmap. Because after calling mmap,=0A=
no data may be written, or only a small amount of data may be=0A=
written to the head of the mmap area.=0A=
=0A=
This commit moves extending valid_size to exfat_page_mkwrite().=0A=
In exfat_page_mkwrite() only extend valid_size to the starting=0A=
position of new data writing, which reduces unnecessary writing=0A=
of zeros.=0A=
=0A=
If the block is not mapped and is marked as new after being=0A=
mapped for writing, block_write_begin() will zero the page=0A=
cache corresponding to the block, so there is no need to call=0A=
zero_user_segment() in exfat_file_zeroed_range(). And after moving=0A=
extending valid_size to exfat_page_mkwrite(), the data written by=0A=
mmap will be copied to the page cache but the page cache may be=0A=
not mapped to the disk. Calling zero_user_segment() will cause=0A=
the data written by mmap to be cleared. So this commit removes=0A=
calling zero_user_segment() from exfat_file_zeroed_range() and=0A=
renames exfat_file_zeroed_range() to exfat_extend_valid_size().=0A=
=0A=
Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
---=0A=
=0A=
Changes for v2:=0A=
  - Remove a unnecessary check from exfat_file_mmap()=0A=
=0A=
Changes for v3:=0A=
  - Fix the potential deadlock=0A=
  - Change to use ->valid_size to determine whether=0A=
    exfat_block_page_mkwrite() needs to be called=0A=
=0A=
 fs/exfat/exfat_fs.h |  1 +=0A=
 fs/exfat/file.c     | 92 ++++++++++++++++++++++++++++++++-------------=0A=
 fs/exfat/inode.c    |  5 +++=0A=
 3 files changed, 72 insertions(+), 26 deletions(-)=0A=
=0A=
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h=0A=
index ecc5db952deb..1d207eee3197 100644=0A=
--- a/fs/exfat/exfat_fs.h=0A=
+++ b/fs/exfat/exfat_fs.h=0A=
@@ -516,6 +516,7 @@ int __exfat_write_inode(struct inode *inode, int sync);=
=0A=
 int exfat_write_inode(struct inode *inode, struct writeback_control *wbc);=
=0A=
 void exfat_evict_inode(struct inode *inode);=0A=
 int exfat_block_truncate_page(struct inode *inode, loff_t from);=0A=
+int exfat_block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *=
vmf);=0A=
 =0A=
 /* exfat/nls.c */=0A=
 unsigned short exfat_toupper(struct super_block *sb, unsigned short a);=0A=
diff --git a/fs/exfat/file.c b/fs/exfat/file.c=0A=
index 64c31867bc76..781b4d4dbda1 100644=0A=
--- a/fs/exfat/file.c=0A=
+++ b/fs/exfat/file.c=0A=
@@ -526,32 +526,32 @@ int exfat_file_fsync(struct file *filp, loff_t start,=
 loff_t end, int datasync)=0A=
 	return blkdev_issue_flush(inode->i_sb->s_bdev);=0A=
 }=0A=
 =0A=
-static int exfat_file_zeroed_range(struct file *file, loff_t start, loff_t=
 end)=0A=
+static int exfat_extend_valid_size(struct file *file, loff_t new_valid_siz=
e)=0A=
 {=0A=
 	int err;=0A=
+	loff_t pos;=0A=
 	struct inode *inode =3D file_inode(file);=0A=
+	struct exfat_inode_info *ei =3D EXFAT_I(inode);=0A=
 	struct address_space *mapping =3D inode->i_mapping;=0A=
 	const struct address_space_operations *ops =3D mapping->a_ops;=0A=
 =0A=
-	while (start < end) {=0A=
-		u32 zerofrom, len;=0A=
+	pos =3D ei->valid_size;=0A=
+	while (pos < new_valid_size) {=0A=
+		u32 len;=0A=
 		struct page *page =3D NULL;=0A=
 =0A=
-		zerofrom =3D start & (PAGE_SIZE - 1);=0A=
-		len =3D PAGE_SIZE - zerofrom;=0A=
-		if (start + len > end)=0A=
-			len =3D end - start;=0A=
+		len =3D PAGE_SIZE - (pos & (PAGE_SIZE - 1));=0A=
+		if (pos + len > new_valid_size)=0A=
+			len =3D new_valid_size - pos;=0A=
 =0A=
-		err =3D ops->write_begin(file, mapping, start, len, &page, NULL);=0A=
+		err =3D ops->write_begin(file, mapping, pos, len, &page, NULL);=0A=
 		if (err)=0A=
 			goto out;=0A=
 =0A=
-		zero_user_segment(page, zerofrom, zerofrom + len);=0A=
-=0A=
-		err =3D ops->write_end(file, mapping, start, len, len, page, NULL);=0A=
+		err =3D ops->write_end(file, mapping, pos, len, len, page, NULL);=0A=
 		if (err < 0)=0A=
 			goto out;=0A=
-		start +=3D len;=0A=
+		pos +=3D len;=0A=
 =0A=
 		balance_dirty_pages_ratelimited(mapping);=0A=
 		cond_resched();=0A=
@@ -579,7 +579,7 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb=
, struct iov_iter *iter)=0A=
 		goto unlock;=0A=
 =0A=
 	if (pos > valid_size) {=0A=
-		ret =3D exfat_file_zeroed_range(file, valid_size, pos);=0A=
+		ret =3D exfat_extend_valid_size(file, pos);=0A=
 		if (ret < 0 && ret !=3D -ENOSPC) {=0A=
 			exfat_err(inode->i_sb,=0A=
 				"write: fail to zero from %llu to %llu(%zd)",=0A=
@@ -613,26 +613,66 @@ static ssize_t exfat_file_write_iter(struct kiocb *io=
cb, struct iov_iter *iter)=0A=
 	return ret;=0A=
 }=0A=
 =0A=
-static int exfat_file_mmap(struct file *file, struct vm_area_struct *vma)=
=0A=
+static vm_fault_t exfat_page_mkwrite(struct vm_fault *vmf)=0A=
 {=0A=
-	int ret;=0A=
+	int err;=0A=
+	struct vm_area_struct *vma =3D vmf->vma;=0A=
+	struct file *file =3D vma->vm_file;=0A=
 	struct inode *inode =3D file_inode(file);=0A=
 	struct exfat_inode_info *ei =3D EXFAT_I(inode);=0A=
-	loff_t start =3D ((loff_t)vma->vm_pgoff << PAGE_SHIFT);=0A=
-	loff_t end =3D min_t(loff_t, i_size_read(inode),=0A=
-			start + vma->vm_end - vma->vm_start);=0A=
+	struct folio *folio =3D page_folio(vmf->page);=0A=
+	vm_fault_t ret =3D VM_FAULT_LOCKED;=0A=
 =0A=
-	if ((vma->vm_flags & VM_WRITE) && ei->valid_size < end) {=0A=
-		ret =3D exfat_file_zeroed_range(file, ei->valid_size, end);=0A=
-		if (ret < 0) {=0A=
-			exfat_err(inode->i_sb,=0A=
-				  "mmap: fail to zero from %llu to %llu(%d)",=0A=
-				  start, end, ret);=0A=
-			return ret;=0A=
+	sb_start_pagefault(inode->i_sb);=0A=
+	file_update_time(file);=0A=
+=0A=
+	if (ei->valid_size < folio_pos(folio) + folio_size(folio)) {=0A=
+		if (!inode_trylock(inode)) {=0A=
+			ret =3D VM_FAULT_RETRY;=0A=
+			goto out;=0A=
 		}=0A=
+=0A=
+		if (ei->valid_size < folio_pos(folio)) {=0A=
+			err =3D exfat_extend_valid_size(file, folio_pos(folio));=0A=
+			if (err < 0) {=0A=
+				ret =3D vmf_fs_error(err);=0A=
+				inode_unlock(inode);=0A=
+				goto out;=0A=
+			}=0A=
+		}=0A=
+=0A=
+		err =3D exfat_block_page_mkwrite(vma, vmf);=0A=
+		inode_unlock(inode);=0A=
+		if (err)=0A=
+			ret =3D vmf_fs_error(err);=0A=
+	} else {=0A=
+		folio_lock(folio);=0A=
+		if (folio->mapping !=3D file->f_mapping) {=0A=
+			folio_unlock(folio);=0A=
+			ret =3D VM_FAULT_NOPAGE;=0A=
+			goto out;=0A=
+		}=0A=
+=0A=
+		folio_mark_dirty(folio);=0A=
+		folio_wait_stable(folio);=0A=
 	}=0A=
 =0A=
-	return generic_file_mmap(file, vma);=0A=
+out:=0A=
+	sb_end_pagefault(inode->i_sb);=0A=
+	return ret;=0A=
+}=0A=
+=0A=
+static const struct vm_operations_struct exfat_file_vm_ops =3D {=0A=
+	.fault		=3D filemap_fault,=0A=
+	.map_pages	=3D filemap_map_pages,=0A=
+	.page_mkwrite	=3D exfat_page_mkwrite,=0A=
+};=0A=
+=0A=
+static int exfat_file_mmap(struct file *file, struct vm_area_struct *vma)=
=0A=
+{=0A=
+	file_accessed(file);=0A=
+	vma->vm_ops =3D &exfat_file_vm_ops;=0A=
+	return 0;=0A=
 }=0A=
 =0A=
 const struct file_operations exfat_file_operations =3D {=0A=
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c=0A=
index dd894e558c91..804de7496a7f 100644=0A=
--- a/fs/exfat/inode.c=0A=
+++ b/fs/exfat/inode.c=0A=
@@ -564,6 +564,11 @@ int exfat_block_truncate_page(struct inode *inode, lof=
f_t from)=0A=
 	return block_truncate_page(inode->i_mapping, from, exfat_get_block);=0A=
 }=0A=
 =0A=
+int exfat_block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *=
vmf)=0A=
+{=0A=
+	return block_page_mkwrite(vma, vmf, exfat_get_block);=0A=
+}=0A=
+=0A=
 static const struct address_space_operations exfat_aops =3D {=0A=
 	.dirty_folio	=3D block_dirty_folio,=0A=
 	.invalidate_folio =3D block_invalidate_folio,=0A=
-- =0A=
2.34.1=0A=

