Return-Path: <linux-fsdevel+bounces-34195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6B19C38D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 08:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401241F214BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 07:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB161581F2;
	Mon, 11 Nov 2024 07:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="it7096cX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F131713957C
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 07:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731308663; cv=fail; b=LKqjdN9EIUE539E8d6qPMAZBAAl786/UfIhpkxnLGtGbjehaw1L87cNhWguhXoGl1PFIIIuKMSx1XC9sPECVtXY+Ci1eM5d99nLA2dkpteq9P7fPpyzpAVSx4CRiaEnB63pi81h/+buqmjqNAinlBBv6Pvpri0av4IOcHHj92yA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731308663; c=relaxed/simple;
	bh=bO5VlqTrbMlRXyjf019z5gy6BXjCOrI5A9nWGXo7QaE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Zb0sOuOyy6o720QDi5yEspL0nV5aRwZrgt8tYl6Xq9np3ZtOoyVOUka8Nq2iFrLvfCUUnMDQISNoJ6njdNLr9VmEGnRIzUVXJR+KaZCp5CEBa8zwpA9q7izIq3+FX+7sL+LWKrxvK122V+5nMd8WPv775lCMVDdMxlGAwsZ0+hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=it7096cX; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB3haIl018734;
	Mon, 11 Nov 2024 06:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=bO5VlqTrbMlRXyjf019z5gy6BXjCO
	rI5A9nWGXo7QaE=; b=it7096cXPkzCFV11ymSRUwyK2m9ugPNR7p1cwwpUSXylo
	kDUtlLrnpVD9Fx2q7CMpLN5JYd9SCX6WmqBQdJViERJkzLEdnbt62MIG0SefYz9H
	/gPDga3HdQTFnLTsoGGjo03ClOdZN4Ck5MevmrFh130FhDoBlZw+fLWeFiUqo7Ey
	t71NWGottfoNrewAUCJ9uJmMTeI4XZqw8CZ+yKwnIcZzPmqcRfZGClWAOOjsRin4
	Qgc6a9brDACFAHizMwBb4IkTrtq8Cd0kN+WLSGH32DoXxOCJvkipriyeSwuscG81
	yMqYEiQ9ohbKZ1DT6kYgeVblQrshgQgjWMf1Mkbdg==
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2049.outbound.protection.outlook.com [104.47.26.49])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42t0gm9e20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 06:44:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFOnLyK17pss7c4xxsEvcHKP9dF+TuiMuASTiiNyqfy9/xvquQniOUngVceP9Pme9Td5vRRhn9g0h9SWoykAe1pWOloTx4Fq6h/LuMonUhb+OoIIc8saTzVmd5cIoVL7nCvuoqHksccVjVGqUoCeUpBthVFql675bXZdhc1zLVdTOcfHvOWpz9dw2AtqSJ82TUeaAGo3u1JLFfpKRW7LCCW+7fVQS1jKLLcbo/2vngBK65Lcruzp7CGQL+AJ77h+ijQKBgrV7vWcEpQ6QhrJH9qx5/O4UMxLA5l47/Ym6CNea/PTBwatRJtFOo7M4nj4CcFC4aVxfNBUxuJthxvPBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bO5VlqTrbMlRXyjf019z5gy6BXjCOrI5A9nWGXo7QaE=;
 b=guWMNEarMIvfnW/QiuALOV7pskTZpNdkc5jz+aMUokgrbG9P+WKy5rpLKMGaKodcl8OY5sfjrWR5H+v9gkK3fITxnOFaHs2yAKhrAcuOUFLTVNyvyCbpPPda89l88UTk7x0EgkwSF2IRzoF9bKAjjIRT3HmhR9H87ZvS6WNIypc2TuCwE5HAAh1ffEZb9p454nbJoBu8o59N5/17U8pnfZAdtv85vJJG70fsYc39HHXYsA6QwviOwcVjazt/A+TtP96N1XaPw0mzbN2SbiXdz75+mVu7OChMNB2VJxdxo2vDTamJ64Ol8XOCFeyIAwMX774yXbJAybWrMIMe9ryTLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB6982.apcprd04.prod.outlook.com (2603:1096:400:33c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Mon, 11 Nov
 2024 06:43:58 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8137.022; Mon, 11 Nov 2024
 06:43:58 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v2 6/6] exfat: reduce FAT chain traversal
Thread-Topic: [PATCH v2 6/6] exfat: reduce FAT chain traversal
Thread-Index: AdsE8b4RfJK5gfSvTPOO1A+ob2WK5wvEsVPA
Date: Mon, 11 Nov 2024 06:43:57 +0000
Message-ID:
 <PUZPR04MB631676B56463E4F9CE145BAC81582@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB6982:EE_
x-ms-office365-filtering-correlation-id: 9aabe35a-2d09-4955-8775-08dd021c381e
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aVVmczZHeDFRVTV3UDhNWGMySnRpMEp6bWE3MHdtcmhzUzQxN2o4RUxHbXIx?=
 =?utf-8?B?clJ5TWp5TWtJMnFnWWFJeUpXWW13TFluOGpidlowdXZwWmNtUFg2RnQxSW13?=
 =?utf-8?B?aE50Q1g1cWtEdzZqN2tkRGlCVXNOTHpZVnczOXVzYmwyWVFZaE8yNFZpbzBI?=
 =?utf-8?B?Z1FpRVBLUVR5QjFPbnUxU3F5dDFpZ1FGblp2VmQ5T3lkQkY5R1FSandxeHdK?=
 =?utf-8?B?d3FzWWdZeTM0OUVGbFdSM0VmMWlhNStYYytUR2V3OHRoRFpRQlZHbUVwS3Qr?=
 =?utf-8?B?V3JyR05GTktab2g2Nm16bGxtdmt4dlBSRU1DeEhiU2VVRTZqQ0ducldvaTNF?=
 =?utf-8?B?Nm9zSjJTR3pYclRha0FkbnVxdUNZZTdwS3pOMVFIV3QyMTFCZDFlQlBvNzFk?=
 =?utf-8?B?S0JvZGxxL2U1R0lqcGpnbUozSmFEYmZldWZHaFlWU3VncHdQak0xcUpjcE5u?=
 =?utf-8?B?SnNJOXNoSGNPRW9adGpJclYzSkNLblRkRkNhcHlvU1hkT1R3eHBlV1pRWEZt?=
 =?utf-8?B?bmJiU3JTUVZtYXAvTktWekxFOGVvUWd0UHY2S2xpOEtxYlJSNUJOTC8xVGRm?=
 =?utf-8?B?TnhjMGxCeFZHdzQzS2N1Tko4cWhabmI2aUV4SisybXN2MFNvTk8wQml1Yi9r?=
 =?utf-8?B?bVlkVnhmTHdWR0NZYVNLbnYxakxORGtQVnNTS1pMYjdhbWg3MHAveVhGMFB3?=
 =?utf-8?B?bThDNmdTSlNPaHlzZnVGZWlIVWxzUTBIeTR2c2Jva0FNcjJVNG82Z25Ib1ht?=
 =?utf-8?B?dmYxekROTFdNeDFCV1UyWFNxK28yUjRUUi9VUnhrRC8zUkNTT2E4aDlSNHlZ?=
 =?utf-8?B?MTJzWmhNZlBtamhqZWdHRU5PZWhFNzdBeDk0cTZoMDRyZnRyV2tFZ1lzc1F1?=
 =?utf-8?B?THh3RnlobFBvNXVULzNDakNVeEtmRG40VVZwSER0RzlXdFZvUXFwZnJkek42?=
 =?utf-8?B?Q3VhUUd1MUVJakFobU15VThQSklOTzJCQW5qRVluZ01KbGhFa1F3SngwNkdW?=
 =?utf-8?B?dk5qUVlsdzZkcHhnaWRzajI4eW15M3lTMVFWNnhTRzJ4cklDcnpLdUhsOThn?=
 =?utf-8?B?L3JuNmxqOXpOQ3IxN25Qam4zVkNNY3g1ckFGUkRwa3J4WEduK1dIZzFRVlUy?=
 =?utf-8?B?QVNnU3Jua2ZhWHB2eVpCWGp0U2gxVkphNC9kd2dhbTN1R3hma1pudDhZS2U1?=
 =?utf-8?B?RDIzSkhZTWVydjNkeTF3MnpiT3NLV2FqSUZuTXNPYzhwVVZUWHBYQXJvZkdO?=
 =?utf-8?B?T0hWNm1jekE1QmJYVzlCVzBvQTJqQkpwbGZHZEZzdytlMlE3ekpzTVhyYnJa?=
 =?utf-8?B?QkpkcWk5dk53WkhmWGhWUFZvd2RnMDI2dlZjTkZPa1VkV1VJQk55UDRPYnFS?=
 =?utf-8?B?Ryt6a1VaUjc4RnJ6VDlJbFd0RDV5QkhWR1lreHhod1M4WUFLNkJuRDhERE1G?=
 =?utf-8?B?eGkxV1Z3S0dIOGQ5UnZXa3JjdTdJS0Z2aW5hT0ZlZVptcDNpOTN2YTg1YzNI?=
 =?utf-8?B?SHIvczhTL1BSVXlBQUtQQ3VtaysxTG93Y2FlL2hXMldNbHNiUDFnRkZvREI2?=
 =?utf-8?B?QlIzb0FJdHAwS1dSeHdocVcvN1VjUWt1YUN3ZDhDZVNMUWV4RjFUWXJMUkk5?=
 =?utf-8?B?b2VIOEJhR3FMQU1nNk9lS1g3VUNpZU9UcnUxbExueTBaencwWVRRUGxOdERI?=
 =?utf-8?B?UHErbWNvd05pQjBIZ3hBU1RWakw1NmVOT0hZTHRaZ3dFRGgyV1o0K080YlUv?=
 =?utf-8?B?L2lYSVVuNFNSeHNEQURNT2dKamVKVHA2S1czbmhaSVJLdXRYYU9QSGRmWXhv?=
 =?utf-8?Q?uYJwQTfmxiS+4mTzH+KqC1RUleTh7/Ef/IdLI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VXJXU0hRazBrWlpjdStGQlc1T3lsNlREbmltL3Ftc0ZVQ1BZclBKbWZVc241?=
 =?utf-8?B?T3lDdVJXZUlxbWJnYXhFWkJTN05ISGExZFowVUx0ckRJK0dvMzlvaldOU1pp?=
 =?utf-8?B?WXZEU1lWWFZmdGlPNzFvNUYrdGIvbzl0UjBJQUswWlNGNm1obDBnSmZ5QVlM?=
 =?utf-8?B?TkVNdk41U0ZHNGRtbzRTTTJFOWpnS0xuUjF5alc2N0gzaGx4czNYcFVrMlQx?=
 =?utf-8?B?RWZSRXBHMjlkdmtHaEZ2QzIwNzhTcVd3RmVJQ1ZodVEzSEc1cCtvbjd5OFJE?=
 =?utf-8?B?ZW1FUHFGUkVPNFlKWVZYV3BMd0FTUFNrajBqam5RR1ZPUGc1ZWJvRzlXajNP?=
 =?utf-8?B?SHFHR0JrbWRtUUUwVFIxVlQ5NFZ0c2RhSzRseEFTTFhZTXNDZUdGblc1OXN2?=
 =?utf-8?B?clBiSndxcmlvcWVxdHlNRHA4Uk1XT00xZGlHSE5BSVpLZjd4TnRQMVBVenhw?=
 =?utf-8?B?RFdNZ0lUMXFDL2s4dXhvbXZsSDRmLy9vajFHS2hsRWpzbU8wME5tZThkRlNW?=
 =?utf-8?B?SnNwQ0FHOWFFamU5NkhJeHgzNU04V2xuV3BFZ1p4aVpGSDdlMDY5OUZLK3JS?=
 =?utf-8?B?MkM4VFROejlSY3BSTk91QUtKTzBldkt4VmFsa3JNQllXTlFHMFN0SllqbnFG?=
 =?utf-8?B?Q3ViRld5REZrbXVXQms0YnBQeVFSNExBM3FxcmZmaHFLZVdSK3diUmI1WUs0?=
 =?utf-8?B?N2s0MzdhWU04RnlDS2ZpQktYUktRVTdoSHJHOVdnVUVaQTh6U1R3QjlGQTNS?=
 =?utf-8?B?TTZWeThLV1prNzNMOWFURVBEWWNhWlZUcC9jQVZicm9CRC9IUGhzNnBJbVRZ?=
 =?utf-8?B?akFQeVdodFpwUHJ6TlA4Vk9sOHh1eUpId2ZqMlV1T09oRUx2Y0tjWW9kR0E2?=
 =?utf-8?B?bWp6MXdFYldWRFUxVHVjQTUzZlU4cXhCRWdweEtwZUtjUm5qdWRHYkhoZS9R?=
 =?utf-8?B?Qkp1aCtJUUZuM2hCaFhIQm5mS09ncU45SUdvNUVtdi9HU3pmRGp6cW04UHVJ?=
 =?utf-8?B?RmZQSDhkT2JKRXU5OFVGeXZFUXFvajc5ZFIrNm1taFk1UnhnNzJyWjIyTHdQ?=
 =?utf-8?B?TThDMW5OcTFyTE9kV2REc21GMjl6REE4Ylp3azJ1ZnFmbEJieVB3eDY5aS9J?=
 =?utf-8?B?R3hZQllnS29TY3F0bTdkZC9iK3RFZGI4eGF1ZzNCc3poZUtGSjFIVkJybCt2?=
 =?utf-8?B?NXkvd0M2b3BiZU1zSE5qUFZKK3N4M0k4aUFZVVlXTUNHSVd3L2o5Q05lSC91?=
 =?utf-8?B?N1ZwZWhVNVpGOHdtRjBvZ0gvalBKS2VxbW53UHRINUozemRWS1M1WTJtbTJK?=
 =?utf-8?B?ZC9kMjZjRUNVeGlYRDZPR3ZqaGFONDBjcEgrbHkrTkdqdnZrRU9rRXpEclRh?=
 =?utf-8?B?bTJiZWlCdlZ3SjdFSWdzWEtKVmdyL0dXQW1oV3M2a2FzUERhWTBybGUyNVNS?=
 =?utf-8?B?UjRDMjNoTGpCZVo3cDVsTWlET0FrdVNvRGVCUUhmMlFKYStySXdZL3ZxaHBt?=
 =?utf-8?B?bTZIL0U1WHVFSzdhN0tVVjNGUUdvekZoT0hlVXpBTVVlbGNVTW03WC9OSm5a?=
 =?utf-8?B?ODN4YnlNUUpaMHdrTEJIeno4bHhqdzVCYnE0TndtbFNvc2tDWEpRWHpnVFhp?=
 =?utf-8?B?YWplbThjcUg1OG1pM1NPL1ZoeUlRamhneFdRMWxrc2RiUDZsTFBsT2lnOWVa?=
 =?utf-8?B?V2Z1LzdRazFJZlRCUkpZQnpER1RmUDFSck1UTG9OcWptMDBjYUw0c21ON0FS?=
 =?utf-8?B?SnI0SDVPWk9Ma2M1TTVsa0pjZCtQWEQzTjYxV3pjN280dUdCTkpMRVJsMlNr?=
 =?utf-8?B?SjJJR1E5Nkd0aHNNRTYrQlV2cCtQTDVqcEQva2VnT2lPQ0h0bGRrQTFqVGR3?=
 =?utf-8?B?S0I5a3gvaUdLWDJSbGRnVGhaaVBEaGdWMEI1b211QUc0UlJVTkVHc2x1ZzUv?=
 =?utf-8?B?blg0TzJhR3Z2cG5kS0JFQ3dod2dUVTAwejV0SzVXc3V4NlAyNG54cmNZMW42?=
 =?utf-8?B?ZVBzSEFXWjE4Rm1zcTYzeGkrVDZaMHp6M20rSU90c1JiY3BzVGZCS3J2OHRa?=
 =?utf-8?B?OERQTHY0VHJhK3dzRWI4SFBFU1FJcDQyaUs3bENZU05FZzJQcHcrOXhCVm9k?=
 =?utf-8?Q?JmbUmtA6WpVfb+itSKq8pyxt+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s2Fcaf6F2JcpLf9lGLhi5j5TUXW3Fr0M/hrxo8xz9xAcFyRb5sIZwcik3dnNCvuBdHCdUgUmyZv/gYij8DDHbsYMRtJpVwJGHmOOTlOqgRuzOoah4hgtJXlRp4NPMkHtmZCprzjyZN4C6J+glckZ64zqOn5OyCpeMrDhHlVPIqNfbx2ivLA6Bq6EL3NOUaQpLcZSNIp7dZhzJrZ+pWiXTjfi3eOzokx8jVAUHlBsnhYpT5GszIl+/D/ds4wmsfPdLG6tT8V6VIHafku77d6oAZ06aauxxeSXbEOD7Ydlp3InsPRWWg5cWEZUK6ixB7zPDkCSNFYpNFzrlycbFoCwU9F/HKy/uZTdIDkooYXOP3JpgIAddj7t8lXjqjJqIYjhz24QTTIWkWkWjNGUp1uIRDb5ctuhhUXRvDayi02Ix7NX1cmCHieQEwMTu3oprPM/M1hmnkEyhMkfv/oeNOl3h8Yf7aTFOWqSV+6RaZlaYN9qQDVj4PJAhHw6PQU3z3dXQ4yp3BxxM2gtJ89ctQt/dMrkrqJgf5ysT5xUeWQ2ciz6pJiNVkqZjY/hOQ9IoX95hth0xJrWCZ2mxlO4qnLg5ORFInMDMZ46kyFf1PpeZc3+jcmQWbgl7OtdK3BrHl1E
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aabe35a-2d09-4955-8775-08dd021c381e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 06:43:57.9872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YxBmVZnrGCGNxqicnEiWYSZ2n2QmRCPCYgk8Q57W1O75LP5UcsDR+rZq3ZC5M36bOmkTnv/w99AbeFFyI+Mjpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6982
X-Proofpoint-GUID: A0c2HQatp6gYjx2sIVxr3lVlqGYRa_4h
X-Proofpoint-ORIG-GUID: A0c2HQatp6gYjx2sIVxr3lVlqGYRa_4h
X-Sony-Outbound-GUID: A0c2HQatp6gYjx2sIVxr3lVlqGYRa_4h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-11_06,2024-11-08_01,2024-09-30_01

QmVmb3JlIHRoaXMgY29tbWl0LCAtPmRpciBhbmQgLT5lbnRyeSBvZiBleGZhdF9pbm9kZV9pbmZv
IHJlY29yZCB0aGUNCmZpcnN0IGNsdXN0ZXIgb2YgdGhlIHBhcmVudCBkaXJlY3RvcnkgYW5kIHRo
ZSBkaXJlY3RvcnkgZW50cnkgaW5kZXgNCnN0YXJ0aW5nIGZyb20gdGhpcyBjbHVzdGVyLg0KDQpU
aGUgZGlyZWN0b3J5IGVudHJ5IHNldCB3aWxsIGJlIGdvdHRlbiBkdXJpbmcgd3JpdGUtYmFjay1p
bm9kZS9ybWRpci8NCnVubGluay9yZW5hbWUuIElmIHRoZSBjbHVzdGVycyBvZiB0aGUgcGFyZW50
IGRpcmVjdG9yeSBhcmUgbm90DQpjb250aW51b3VzLCB0aGUgRkFUIGNoYWluIHdpbGwgYmUgdHJh
dmVyc2VkIGZyb20gdGhlIGZpcnN0IGNsdXN0ZXIgb2YNCnRoZSBwYXJlbnQgZGlyZWN0b3J5IHRv
IGZpbmQgdGhlIGNsdXN0ZXIgd2hlcmUgLT5lbnRyeSBpcyBsb2NhdGVkLg0KDQpBZnRlciB0aGlz
IGNvbW1pdCwgLT5kaXIgcmVjb3JkcyB0aGUgY2x1c3RlciB3aGVyZSB0aGUgZmlyc3QgZGlyZWN0
b3J5DQplbnRyeSBpbiB0aGUgZGlyZWN0b3J5IGVudHJ5IHNldCBpcyBsb2NhdGVkLCBhbmQgLT5l
bnRyeSByZWNvcmRzIHRoZQ0KZGlyZWN0b3J5IGVudHJ5IGluZGV4IGluIHRoZSBjbHVzdGVyLCBz
byB0aGF0IHRoZXJlIGlzIGFsbW9zdCBubyBuZWVkDQp0byBhY2Nlc3MgdGhlIEZBVCB3aGVuIGdl
dHRpbmcgdGhlIGRpcmVjdG9yeSBlbnRyeSBzZXQuDQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5n
IE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NClJldmlld2VkLWJ5OiBBb3lhbWEgV2F0YXJ1IDx3
YXRhcnUuYW95YW1hQHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IERhbmllbCBQYWxtZXIgPGRhbmll
bC5wYWxtZXJAc29ueS5jb20+DQotLS0NCiBmcy9leGZhdC9kaXIuYyAgICAgIHwgIDUgKysrLS0N
CiBmcy9leGZhdC9leGZhdF9mcy5oIHwgIDQgKysrKw0KIGZzL2V4ZmF0L25hbWVpLmMgICAgfCAz
MiArKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KIDMgZmlsZXMgY2hhbmdlZCwgMzIg
aW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2Rp
ci5jIGIvZnMvZXhmYXQvZGlyLmMNCmluZGV4IGUyZDNhMDZmYjVlMy4uZDFjYzU4YWFiYmUwIDEw
MDY0NA0KLS0tIGEvZnMvZXhmYXQvZGlyLmMNCisrKyBiL2ZzL2V4ZmF0L2Rpci5jDQpAQCAtMTQ4
LDcgKzE0OCw4IEBAIHN0YXRpYyBpbnQgZXhmYXRfcmVhZGRpcihzdHJ1Y3QgaW5vZGUgKmlub2Rl
LCBsb2ZmX3QgKmNwb3MsIHN0cnVjdCBleGZhdF9kaXJfZW50DQogCQkJZXAgPSBleGZhdF9nZXRf
ZGVudHJ5KHNiLCAmY2x1LCBpICsgMSwgJmJoKTsNCiAJCQlpZiAoIWVwKQ0KIAkJCQlyZXR1cm4g
LUVJTzsNCi0JCQlkaXJfZW50cnktPmVudHJ5ID0gZGVudHJ5Ow0KKwkJCWRpcl9lbnRyeS0+ZW50
cnkgPSBpOw0KKwkJCWRpcl9lbnRyeS0+ZGlyID0gY2x1Ow0KIAkJCWJyZWxzZShiaCk7DQogDQog
CQkJZWktPmhpbnRfYm1hcC5vZmYgPSBFWEZBVF9ERU5fVE9fQ0xVKGRlbnRyeSwgc2JpKTsNCkBA
IC0yNTYsNyArMjU3LDcgQEAgc3RhdGljIGludCBleGZhdF9pdGVyYXRlKHN0cnVjdCBmaWxlICpm
aWxlLCBzdHJ1Y3QgZGlyX2NvbnRleHQgKmN0eCkNCiAJaWYgKCFuYi0+bGZuWzBdKQ0KIAkJZ290
byBlbmRfb2ZfZGlyOw0KIA0KLQlpX3BvcyA9ICgobG9mZl90KWVpLT5zdGFydF9jbHUgPDwgMzIp
IHwJKGRlLmVudHJ5ICYgMHhmZmZmZmZmZik7DQorCWlfcG9zID0gKChsb2ZmX3QpZGUuZGlyLmRp
ciA8PCAzMikgfCAoZGUuZW50cnkgJiAweGZmZmZmZmZmKTsNCiAJdG1wID0gZXhmYXRfaWdldChz
YiwgaV9wb3MpOw0KIAlpZiAodG1wKSB7DQogCQlpbnVtID0gdG1wLT5pX2lubzsNCmRpZmYgLS1n
aXQgYS9mcy9leGZhdC9leGZhdF9mcy5oIGIvZnMvZXhmYXQvZXhmYXRfZnMuaA0KaW5kZXggN2I1
Zjk2MmYwNzRkLi40MDc5ODA5YTU5OTcgMTAwNjQ0DQotLS0gYS9mcy9leGZhdC9leGZhdF9mcy5o
DQorKysgYi9mcy9leGZhdC9leGZhdF9mcy5oDQpAQCAtMjA0LDcgKzIwNCw5IEBAIHN0cnVjdCBl
eGZhdF9lbnRyeV9zZXRfY2FjaGUgew0KICNkZWZpbmUgSVNfRFlOQU1JQ19FUyhlcykJKChlcykt
Pl9fYmggIT0gKGVzKS0+YmgpDQogDQogc3RydWN0IGV4ZmF0X2Rpcl9lbnRyeSB7DQorCS8qIHRo
ZSBjbHVzdGVyIHdoZXJlIGZpbGUgZGVudHJ5IGlzIGxvY2F0ZWQgKi8NCiAJc3RydWN0IGV4ZmF0
X2NoYWluIGRpcjsNCisJLyogdGhlIGluZGV4IG9mIGZpbGUgZGVudHJ5IGluIC0+ZGlyICovDQog
CWludCBlbnRyeTsNCiAJdW5zaWduZWQgaW50IHR5cGU7DQogCXVuc2lnbmVkIGludCBzdGFydF9j
bHU7DQpAQCAtMjkwLDcgKzI5Miw5IEBAIHN0cnVjdCBleGZhdF9zYl9pbmZvIHsNCiAgKiBFWEZB
VCBmaWxlIHN5c3RlbSBpbm9kZSBpbi1tZW1vcnkgZGF0YQ0KICAqLw0KIHN0cnVjdCBleGZhdF9p
bm9kZV9pbmZvIHsNCisJLyogdGhlIGNsdXN0ZXIgd2hlcmUgZmlsZSBkZW50cnkgaXMgbG9jYXRl
ZCAqLw0KIAlzdHJ1Y3QgZXhmYXRfY2hhaW4gZGlyOw0KKwkvKiB0aGUgaW5kZXggb2YgZmlsZSBk
ZW50cnkgaW4gLT5kaXIgKi8NCiAJaW50IGVudHJ5Ow0KIAl1bnNpZ25lZCBpbnQgdHlwZTsNCiAJ
dW5zaWduZWQgc2hvcnQgYXR0cjsNCmRpZmYgLS1naXQgYS9mcy9leGZhdC9uYW1laS5jIGIvZnMv
ZXhmYXQvbmFtZWkuYw0KaW5kZXggMzkyOTdkNDQ5ZGQzLi41ZjViYmJkZGUxOTQgMTAwNjQ0DQot
LS0gYS9mcy9leGZhdC9uYW1laS5jDQorKysgYi9mcy9leGZhdC9uYW1laS5jDQpAQCAtMjg4LDgg
KzI4OCwyMiBAQCBzdGF0aWMgaW50IGV4ZmF0X2NoZWNrX21heF9kZW50cmllcyhzdHJ1Y3QgaW5v
ZGUgKmlub2RlKQ0KIAlyZXR1cm4gMDsNCiB9DQogDQotLyogZmluZCBlbXB0eSBkaXJlY3Rvcnkg
ZW50cnkuDQotICogaWYgdGhlcmUgaXNuJ3QgYW55IGVtcHR5IHNsb3QsIGV4cGFuZCBjbHVzdGVy
IGNoYWluLg0KKy8qDQorICogRmluZCBhbiBlbXB0eSBkaXJlY3RvcnkgZW50cnkgc2V0Lg0KKyAq
DQorICogSWYgdGhlcmUgaXNuJ3QgYW55IGVtcHR5IHNsb3QsIGV4cGFuZCBjbHVzdGVyIGNoYWlu
Lg0KKyAqDQorICogaW46DQorICogICBpbm9kZTogaW5vZGUgb2YgdGhlIHBhcmVudCBkaXJlY3Rv
cnkNCisgKiAgIG51bV9lbnRyaWVzOiBzcGVjaWZpZXMgaG93IG1hbnkgZGVudHJpZXMgaW4gdGhl
IGVtcHR5IGRpcmVjdG9yeSBlbnRyeSBzZXQNCisgKg0KKyAqIG91dDoNCisgKiAgIHBfZGlyOiB0
aGUgY2x1c3RlciB3aGVyZSB0aGUgZW1wdHkgZGlyZWN0b3J5IGVudHJ5IHNldCBpcyBsb2NhdGVk
DQorICogICBlczogVGhlIGZvdW5kIGVtcHR5IGRpcmVjdG9yeSBlbnRyeSBzZXQNCisgKg0KKyAq
IHJldHVybjoNCisgKiAgIHRoZSBkaXJlY3RvcnkgZW50cnkgaW5kZXggaW4gcF9kaXIgaXMgcmV0
dXJuZWQgb24gc3VjY2VlZHMNCisgKiAgIC1lcnJvciBjb2RlIGlzIHJldHVybmVkIG9uIGZhaWx1
cmUNCiAgKi8NCiBzdGF0aWMgaW50IGV4ZmF0X2ZpbmRfZW1wdHlfZW50cnkoc3RydWN0IGlub2Rl
ICppbm9kZSwNCiAJCXN0cnVjdCBleGZhdF9jaGFpbiAqcF9kaXIsIGludCBudW1fZW50cmllcywN
CkBAIC0zODAsNyArMzk0LDEwIEBAIHN0YXRpYyBpbnQgZXhmYXRfZmluZF9lbXB0eV9lbnRyeShz
dHJ1Y3QgaW5vZGUgKmlub2RlLA0KIAkJaW5vZGUtPmlfYmxvY2tzICs9IHNiaS0+Y2x1c3Rlcl9z
aXplID4+IDk7DQogCX0NCiANCi0JcmV0dXJuIGRlbnRyeTsNCisJcF9kaXItPmRpciA9IGV4ZmF0
X3NlY3Rvcl90b19jbHVzdGVyKHNiaSwgZXMtPmJoWzBdLT5iX2Jsb2NrbnIpOw0KKwlwX2Rpci0+
c2l6ZSAtPSBkZW50cnkgLyBzYmktPmRlbnRyaWVzX3Blcl9jbHU7DQorDQorCXJldHVybiBkZW50
cnkgJiAoc2JpLT5kZW50cmllc19wZXJfY2x1IC0gMSk7DQogfQ0KIA0KIC8qDQpAQCAtNjEyLDE1
ICs2MjksMTYgQEAgc3RhdGljIGludCBleGZhdF9maW5kKHN0cnVjdCBpbm9kZSAqZGlyLCBzdHJ1
Y3QgcXN0ciAqcW5hbWUsDQogCWlmIChkZW50cnkgPCAwKQ0KIAkJcmV0dXJuIGRlbnRyeTsgLyog
LWVycm9yIHZhbHVlICovDQogDQotCWluZm8tPmRpciA9IGNkaXI7DQotCWluZm8tPmVudHJ5ID0g
ZGVudHJ5Ow0KLQlpbmZvLT5udW1fc3ViZGlycyA9IDA7DQotDQogCS8qIGFkanVzdCBjZGlyIHRv
IHRoZSBvcHRpbWl6ZWQgdmFsdWUgKi8NCiAJY2Rpci5kaXIgPSBoaW50X29wdC5jbHU7DQogCWlm
IChjZGlyLmZsYWdzICYgQUxMT0NfTk9fRkFUX0NIQUlOKQ0KIAkJY2Rpci5zaXplIC09IGRlbnRy
eSAvIHNiaS0+ZGVudHJpZXNfcGVyX2NsdTsNCiAJZGVudHJ5ID0gaGludF9vcHQuZWlkeDsNCisN
CisJaW5mby0+ZGlyID0gY2RpcjsNCisJaW5mby0+ZW50cnkgPSBkZW50cnk7DQorCWluZm8tPm51
bV9zdWJkaXJzID0gMDsNCisNCiAJaWYgKGV4ZmF0X2dldF9kZW50cnlfc2V0KCZlcywgc2IsICZj
ZGlyLCBkZW50cnksIEVTXzJfRU5UUklFUykpDQogCQlyZXR1cm4gLUVJTzsNCiAJZXAgPSBleGZh
dF9nZXRfZGVudHJ5X2NhY2hlZCgmZXMsIEVTX0lEWF9GSUxFKTsNCi0tIA0KMi40My4wDQoNCg==

