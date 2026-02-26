Return-Path: <linux-fsdevel+bounces-78662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MaDKc/coGmMngQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 00:52:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 270231B109D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 00:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 051A23068271
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 23:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF72A32ED45;
	Thu, 26 Feb 2026 23:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tmduOdf/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C382E3B15;
	Thu, 26 Feb 2026 23:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772149860; cv=fail; b=N6TWNCALqxrnDrbtqAnycJH2TiZTVTjYD7dQRLaN+PJ8ncCOGbQstQdo1hV8QlQC4+/iO6slwjT8rMPymYrgtX7eY9TM2rbYvSvQddgCl5AnI/4B6opXdQ4w3aFdKEUDVjt4BGHnuxNNf5XtMPdw5KUDsUwwerAE8YTaeqGAIYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772149860; c=relaxed/simple;
	bh=9FfG1TM7MyCp8r2XgqRey4+FNG+siX589KCXFv/sVUY=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=hzdnmkXgnaDySMYl5myHaKzyeeV4VAlMeBF1zsQp5xbw5CxXex37hA99G5BNJAHNKit1GnIKSvsinK4CHhanjEbmJhlGbssCtjbNoTbObCA8X2QIb/9gURCVEwncksOVzrN+ZmLFVq3C6AXqdyFWGM9JVGTEBALFCv8hFtd9hcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tmduOdf/; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QLVJNa3514000;
	Thu, 26 Feb 2026 23:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=9FfG1TM7MyCp8r2XgqRey4+FNG+siX589KCXFv/sVUY=; b=tmduOdf/
	Madi9ag5YQy63OPevgpsTAEqpDfD5J0g97KkjwyXfbPWtpa8e96UTEU9tRNDR/o8
	33ty7phMJKVOKiPgWpHDfeEMCAkafUM0/F+YLWPc/2D4hjhFIYMilvOfXusGF5JW
	aN2kDMbd/o4swFp4XWnrumxb2dNbSH4qHIZbfqUqYofAHS6hLtTTYGJxGdM4DV0j
	Eyse7pIfJLWhkHnRhQu2D71kHEutKwjwBuz8OOnK3Ua3bCny+JRGsC/lxw5s80ME
	QDg3a8sWnbr8Bv+VafSsebDQPgbc8yOMeoTXqe4AlCpoOjU1LDlOYgLR8YII4D8A
	iSB3bQdDLS+0lQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010053.outbound.protection.outlook.com [52.101.193.53])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4729tyf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 23:50:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRcnXL2tzjddUDl3V9IRo/r69KN5Goi6hrdMhCZzC7OxUDubcqtSCldl2DEk9fJNYTPaXFvgIHmNU2Ocm1Id30LwnLeh90AAek4qgt/3K+j6opUK/+SyXBQnBqEVdRr0bHxxWwRv8hfTUpAil1RrK0RnuEvwgTYBtJ0zyg9bUEYpvghyEvxlMG+Ykn7yXHgbFY6fmcp1ka3QsXJMQXzC/Kq/yVBluqv8AB9m0zcoh6HRYCi3DnFXbbp3ZDmdXLRuTyJFrHUO4GPz4HrD6FA1A3ySRimSUYxK+toGYHCsfc7B2Jku9bjYSzmGoBY6lSPhlvfBA/3rbuzWx3TcTb6gAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FfG1TM7MyCp8r2XgqRey4+FNG+siX589KCXFv/sVUY=;
 b=DNDdRWsIaEJfaOj1e5e5rTorjR8e/7zYUS+iSm52iv62G1HN3VXLlwDW+z8hinMyt0uJqPVSTNnUFYF849ODUYsNwp7J8gvGRgd3RssPlqspWQdDfH7svTZ32RR4Gz5NWB+LviQ4cQJcgHiyfHG22rUlxhfzCQweNB3xArJpFuCLlVCeOkJVgw2gVM5KSLAtcN5k+aAiR76rKO3d4etvDE9zvmMeNCeZNnvBK681OAAGb4qfCc0QQjNS60zwnzrDOuCFMTR54qjUlXtxXkEnWdASM+BYbUWvhHIgBD6sgypoQyQ/7umZNW2McoHbWALfmQrf+ll/A+9sEV9VUqUL+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA0PPFF079B74D4.namprd15.prod.outlook.com (2603:10b6:20f:fc04::b52) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 26 Feb
 2026 23:50:46 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 23:50:46 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "shardulsb08@gmail.com" <shardulsb08@gmail.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: "janak@mpiric.us" <janak@mpiric.us>,
        "janak@mpiricsoftware.com"
	<janak@mpiricsoftware.com>,
        "shardul.b@mpiricsoftware.com"
	<shardul.b@mpiricsoftware.com>
Thread-Topic: [EXTERNAL] [PATCH v4 1/2] hfsplus: refactor b-tree map page
 access and add node-type validation
Thread-Index: AQHcpwDJhMzL3kQ4IU2TK4Wx1mjKl7WVp3CA
Date: Thu, 26 Feb 2026 23:50:46 +0000
Message-ID: <66941e77b76d1930a759a843783f1c68bb3089a8.camel@ibm.com>
References: <20260226091235.927749-1-shardul.b@mpiricsoftware.com>
	 <20260226091235.927749-2-shardul.b@mpiricsoftware.com>
In-Reply-To: <20260226091235.927749-2-shardul.b@mpiricsoftware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA0PPFF079B74D4:EE_
x-ms-office365-filtering-correlation-id: cde71c05-884a-4bda-74aa-08de7591dc61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 JdjbfQl+GhKadWgWJd5bwDy6sl3oe3i+lFIs6hf0YhHxeth9EO6ej6M5gqmIxNNkvqgc8lXcbE0Zwac4U1RzD9diJsOEKLspPoAoMwHAWc0DUasVMaM7McJ+QGQUzGTU1UIVvlGxQclwqiRJPofwztbuOTvsmYmtm4vkzvW8k1PNtshuUXJsoa5aoDemrkzjqkEAUhf1EzJ0MpSUbITShP1QwIWXXo+Ir8qUzc0VxWIMu4z0/WQ0F9OG5D4KpwBK8ZDV+EHjAonxzcbP+mw8gBICLaIc74w1NVOt2JXBIIGYfEIG8xPvjaJGHGV/pFuAgdgmysBy9Fn2x5pb4LID2EVrZ7tBBgdLFreJruO7KxBMjs5Auo9HAXD4lMcGHnWObFiScFrcJiJ/xuPc7XXZ4oNIaN+jHEM+66JZGn1TURHnD2aZM09rx0p0HD3x4x/LZaSAOUQdQmdY1g+5s/e9/YR0MnKE1SjbV/SsJeLJzx6y4Ek7fU1xcdFr95J0whP/zKXHD5Yq1/AkU5y85qKhF+bLVemeWDCsVAbo5IU6fEeLgZ5zbpVH/1h1Zf7A94kdThopRBFnBzW4pvNPog7yeZZpWcjGNKcC17+F+m8/7hhMA195ATI4y6kMfPH6c5JAoAR0R0e2vb0d011eI1UJFiakWzrXn/CJW4RE6TZmDv/ZV17iOn8p41pfruIh6zyjeWBhhhdEsZSr0TfsSbobFRJaLMIQRh2oDA6MbQSDoEz0dRr2IdTq0GaFT49KuYC9FZtT/KKbIzNKY5NmObWUdTKoev8rMHanv/xyRbGuT+4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N0lnNnRPVitRcmtzanN1Nkh5empOUDBacXZxVXFlenpCTnJOcjRYTVV4blRa?=
 =?utf-8?B?WlNoUFFjUklvTDBQTllrWUNMaHNvak1BVlY2WWEvekY1R2NMWVF4VDN3WkdX?=
 =?utf-8?B?cjF5Ym1EV3k5UmpRWTUrYnN4RzhGdVo3cm1kbU5lYmtrUVZFbU8vdStVQkIv?=
 =?utf-8?B?WFFrRGl4aVVoaFU0RFZKcnFERTJ5SjgwV3lzS0tybU1xWFduSGg5UU5Yc0ox?=
 =?utf-8?B?eEFaYzhNekNiKzFZTTJKZEtCUVZRdWRGTUxxaGQ5YlAybUs3UGRDcWhHMXpV?=
 =?utf-8?B?Z2N1Ym1VbjY4M2tRakRwc2tmQmhVOWk1c2hZR0JRelIvNU0zTHFHNHV0WGlr?=
 =?utf-8?B?RW9oTXR2TUhXdFY3R3RTekZtSHplUDNGODhCeHZJOFRDcy8vb3JEc0dnRTFZ?=
 =?utf-8?B?OTFVOUo2RDQ5Z1hjZkNLZ3VyU0krQ0hTdlcyVEphNXZQSHc3aG1iMWVOWnNr?=
 =?utf-8?B?THhtTnY0YmZla0ZYMitmT3c2NnB0cEJwRGJmckd6Qm9Cc2JmYmJUYmFmMFY2?=
 =?utf-8?B?cnlpQ2syWEM5by9UbWp4SDBsK082Z3hEUE95NFVxR1pEUENwRnRTdDBROVFE?=
 =?utf-8?B?WUlPYmJaM3BwWnJlMmpvZmNWUEpjQ0tBOTV2T2ZyNVZlUkhodXoxMkU3REFm?=
 =?utf-8?B?YTBUWGg3NzhXWE4vWGpBR2hBWndXaUFFMFFnaVcvTU1xeURnc1p5NlROMlJo?=
 =?utf-8?B?aUxPbjZNMmhBd1NtZFh0ek0rVWt4bkVOL2FLQ29QYk1aYWM5SkkrajcvZHlY?=
 =?utf-8?B?MG9NRlhhVlVTUzdyR1Zua01mMjN3SGNIcld3U2dvTmVlenlhUHdzQTBnOWZJ?=
 =?utf-8?B?WFRzU0NMcXNscVZmWExYV0tMazUwRjlNMENUWjZwWGswRDFmcUt4RjhGQ2o3?=
 =?utf-8?B?SUMzaTczKzlmbjh6NHYzb0hPci95NUpoUHNxc000bDV5RFpCMittMGlkY3lX?=
 =?utf-8?B?aDUzNHpHNVo4RWlPZk02aTZPdmlUOXpGbjZIUzF5OEZPbWJCVjVwT2lYRlJa?=
 =?utf-8?B?UkZNOUdLTXNqR3gxTHN2aHErNzMxVlNTTnlWWHdJVGtmWmN4cUkyV2Fia09m?=
 =?utf-8?B?QVNtTXI2Y2hiWDdEVXVxcHpwVjRnb3ZRM1RmVXZtK0pva0YzR3N1NXNpeFN6?=
 =?utf-8?B?YnlSVm1zMTVTd2psc0tQKzdxa216bTlzWnBVblFoZ05NMHpMZU1VQ0FmRzdI?=
 =?utf-8?B?N2JqMzNhUXNUQ0FaM0xtN3d2azIyaGIzQnpEWnFTRnlrUjVjN0pYWUZ6WW9Q?=
 =?utf-8?B?LzhXcnRaZGFPbHRjQmxLWmJlOE81bnFzZU9zL29jU0NwZ1JZTExMeGluTlZm?=
 =?utf-8?B?ZEhjdGJ4SjhXUGhvUFhvY0R5ZEJqTktPcThxeFk4SXhiazZ1RmZSWUFPeGo4?=
 =?utf-8?B?Vnp6UUVvdkY2Q0NpSWZHZ1p5S0xReFJhc0hrMmc1emRFVldaaXJQUUFNeFZi?=
 =?utf-8?B?ckczbDNQLy9rcE0razVScVRwZ1prc2V6ZEVnUU41ZklQM240NjRXN2JQYmNV?=
 =?utf-8?B?dkh5UDBTSU82a29DL3hzQTFrQXpSYVBqT0czUCsyTEZLam43WGVTYlV3dytF?=
 =?utf-8?B?b29RK0htdkw5RFZ0MUV2WDNsZEIvSUs0UTNvbkVZREM3aE5Hc3IzaTRVVmdn?=
 =?utf-8?B?aHVuK2VoL2Q0bE5ON0VkUkYyc0F0ZllnTWV2WTcrS0dLVUY4VVlwL0U4Yy9H?=
 =?utf-8?B?L2s4UkRUNHRqUDNBQ2hVNENsWXV5VTJBSDMvZ09xQnI0VkZXblJXdDFETi9l?=
 =?utf-8?B?NTVBNjE1VGtCc09QZDJXQy9LRlF0YzBPUlBGT0V4dUViSXJudmoxUUc4elN1?=
 =?utf-8?B?bWh4dDhxV3dFemVMVXlNbU9DdVYxTmczU2ZzSFRDZW94czBBS0hmVEh6Vzgx?=
 =?utf-8?B?Mml4cDY2c2dSQjNjYWs5M3E3bGpudVE5aHRjMXZYVGpFdVlKaUNZbnNBK2wz?=
 =?utf-8?B?NDZ1ekpONmVzVTVRamZFUHhzWDZmN3M0bVMvMjlGZ1d4UXdoYXNMUEVTVmRB?=
 =?utf-8?B?WUc2Tklha3A4S0tSSC9pajRmbnNvZDU2VmkrWUg1cWw0VWl0RnozVzVlYTFB?=
 =?utf-8?B?b1pNNDRyWTRoTUNrY1VROFBqdU9VTVltVytLNWZjdWxWRm0rU016Qlk0cms1?=
 =?utf-8?B?dlVxK2UzblZMdXczU0NlY1I3eEprZlg0d1kxa3hMWnlMNklpanZJTDNOZXMz?=
 =?utf-8?B?RDJXa1E3cmhhOEFuYVlsWXlhcEJCb2RHTktwcHFQVTZUeDhxV2hXdmlmdWh2?=
 =?utf-8?B?SWRZakFiUGV6ZzJSVW5xaHd6NE0zVSthM2h5QUM2N21lZVljUXU0OUdlMUVD?=
 =?utf-8?B?RWhzKzJLKzRjMmZsTEI1Sm5IQm4yQWR1WnhkbUNpL1k1TDJRMittTVdiRGN2?=
 =?utf-8?Q?WrRf1TjbV1skdRQCwtM4jUfVPYnVbAGPlHLLy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE555D5D62D36B4BA5FC225385CAE914@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cde71c05-884a-4bda-74aa-08de7591dc61
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 23:50:46.0884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QWe2hwCQHqjXTiXEhnrHeVSiHrAkrKnR4+3jcqoP5JXryV/V7Gf2sDaTyfTb4VYnBbzzXq27yd/y3iht0+u5lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFF079B74D4
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: E8yQ_-siynkTRKBVXKoAP1YxLuPWcjBn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDIxNyBTYWx0ZWRfX89pPS8qIZBtq
 w37HmFN5w2eQipF2o9BbfDwssFOkqU8p50z3j1PAV0eylor8mhDG06ZRs1T5PYyE0ysdJzy7ZMm
 wPWGjCJkbsM3OPRkQN5cYkRWCK3GSx7y7jkKRGbdVXxcos6HwtfWr/qVJ4CUE2jp9gPtfakvQD0
 KyUnkrbvsPEcDz90DCvvabwHRVH7KWeKsOTEbQoFTc7o6yuS8Q30gsuXxJlcAsqvDGn+zipPQ+j
 82RJvHpjw4keiuLo9AlMep9vNBUZE16DC3wkjjS7lP80e8M+g874w3vRRzGawTPjHlsj1oDe/p6
 QLTtmIo7ZysVCR5qPo7Jd4ys3DzgN8HQVKhKgFG4hplYB5Gbs08KYKlBH15bAK7Qjp1CaAQQO/w
 KM9/O90amPxvFVMF5myw50fg820eFBmxBkJDYCylipodfpexoV5orzqRzaSEJ479TYjEXZAdZal
 0UR9vPbPhnDHoSKOQig==
X-Authority-Analysis: v=2.4 cv=R7wO2NRX c=1 sm=1 tr=0 ts=69a0dc59 cx=c_pps
 a=XYxO6LlR7Df2C67LKP0s0A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=szKgq9aCAAAA:8 a=kTgdSG9xROiSUXijPtwA:9
 a=QEXdDO2ut3YA:10 a=R_ZFHMB_yizOUweVQPrY:22
X-Proofpoint-GUID: ercak3zvN56XVri5P_XLMlsZ1j7Sp_uM
Subject: Re:  [PATCH v4 1/2] hfsplus: refactor b-tree map page access and add
 node-type validation
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_03,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602260217
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-78662-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mpiricsoftware.com:email];
	FREEMAIL_TO(0.00)[physik.fu-berlin.de,gmail.com,dubeyko.com,vivo.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 270231B109D
X-Rspamd-Action: no action

T24gVGh1LCAyMDI2LTAyLTI2IGF0IDE0OjQyICswNTMwLCBTaGFyZHVsIEJhbmthciB3cm90ZToN
Cj4gSW4gSEZTKyBiLXRyZWVzLCB0aGUgbm9kZSBhbGxvY2F0aW9uIGJpdG1hcCBpcyBzdG9yZWQg
YWNyb3NzIG11bHRpcGxlDQo+IHJlY29yZHMuIFRoZSBmaXJzdCBjaHVuayByZXNpZGVzIGluIHRo
ZSBiLXRyZWUgSGVhZGVyIE5vZGUgYXQgcmVjb3JkDQo+IGluZGV4IDIsIHdoaWxlIGFsbCBzdWJz
ZXF1ZW50IGNodW5rcyBhcmUgc3RvcmVkIGluIGRlZGljYXRlZCBNYXAgTm9kZXMNCj4gYXQgcmVj
b3JkIGluZGV4IDAuDQo+IA0KPiBUaGlzIHN0cnVjdHVyYWwgcXVpcmsgZm9yY2VzIGNhbGxlcnMg
bGlrZSBoZnNfYm1hcF9hbGxvYygpIHRvIGR1cGxpY2F0ZQ0KPiBib2lsZXJwbGF0ZSBjb2RlIHRv
IHZhbGlkYXRlIG9mZnNldHMsIGNvcnJlY3QgbGVuZ3RocywgYW5kIG1hcCB0aGUNCj4gdW5kZXJs
eWluZyBwYWdlcyB2aWEga21hcF9sb2NhbF9wYWdlKCkgZm9yIGJvdGggdGhlIGluaXRpYWwgaGVh
ZGVyIG5vZGUNCj4gYW5kIHRoZSBzdWJzZXF1ZW50IG1hcCBub2RlcyBpbiB0aGUgY2hhaW4uDQo+
IA0KPiBJbnRyb2R1Y2UgYSBnZW5lcmljIGhlbHBlciwgaGZzX2JtYXBfZ2V0X21hcF9wYWdlKCks
IHRvIGVuY2Fwc3VsYXRlDQo+IHRoZSBtYXAgcmVjb3JkIGFjY2Vzcy4gVGhpcyBoZWxwZXI6DQo+
IDEuIEF1dG9tYXRpY2FsbHkgdmFsaWRhdGVzIHRoZSBub2RlLT50eXBlIGFnYWluc3QgSEZTX05P
REVfSEVBREVSIGFuZA0KPiAgICBIRlNfTk9ERV9NQVAgdG8gcHJldmVudCBtaXNpbnRlcnByZXRp
bmcgY29ycnVwdGVkIG5vZGVzLg0KPiAyLiBJbmZlcnMgdGhlIGNvcnJlY3QgcmVjb3JkIGluZGV4
ICgyIG9yIDApIGJhc2VkIG9uIHRoZSBub2RlIHR5cGUuDQo+IDMuIEhhbmRsZXMgdGhlIG9mZnNl
dCBjYWxjdWxhdGlvbiwgbGVuZ3RoIHZhbGlkYXRpb24sIGFuZCBwYWdlIG1hcHBpbmcuDQo+IA0K
PiBSZWZhY3RvciBoZnNfYm1hcF9hbGxvYygpIHRvIHV0aWxpemUgdGhpcyBoZWxwZXIsIHN0cmlw
cGluZyBvdXQgdGhlDQo+IHJlZHVuZGFudCBzZXR1cCBibG9ja3MuIEFzIHBhcnQgb2YgdGhpcyBj
bGVhbnVwLCB0aGUgZG91YmxlIHBvaW50ZXINCj4gaXRlcmF0b3IgKHN0cnVjdCBwYWdlICoqcGFn
ZXApIGlzIHJlcGxhY2VkIHdpdGggYSBzaW1wbGVyIHVuc2lnbmVkIGludA0KPiBpbmRleCAocGFn
ZV9pZHgpIGZvciBjbGVhbmVyIHBhZ2UgYm91bmRhcnkgY3Jvc3NpbmcuDQo+IA0KPiBUaGlzIGRl
ZHVwbGljYXRlcyB0aGUgYWxsb2NhdG9yIGxvZ2ljLCBoYXJkZW5zIHRoZSBtYXAgdHJhdmVyc2Fs
IGFnYWluc3QNCj4gZnV6emVkL2NvcnJ1cHRlZCBpbWFnZXMsIGFuZCBwcm92aWRlcyBhIGdlbmVy
aWMgbWFwLWFjY2VzcyBhYnN0cmFjdGlvbg0KPiB0aGF0IHdpbGwgYmUgdXRpbGl6ZWQgYnkgdXBj
b21pbmcgbW91bnQtdGltZSB2YWxpZGF0aW9uIGNoZWNrcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IFNoYXJkdWwgQmFua2FyIDxzaGFyZHVsLmJAbXBpcmljc29mdHdhcmUuY29tPg0KPiAtLS0NCj4g
IGZzL2hmc3BsdXMvYnRyZWUuYyAgICAgICAgIHwgNzggKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0NCj4gIGluY2x1ZGUvbGludXgvaGZzX2NvbW1vbi5oIHwgIDMgKysNCj4g
IDIgZmlsZXMgY2hhbmdlZCwgNTkgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZnMvaGZzcGx1cy9idHJlZS5jIGIvZnMvaGZzcGx1cy9idHJlZS5jDQo+
IGluZGV4IDEyMjBhMmYyMjczNy4uMjJlZmQ2NTE3ZWY0IDEwMDY0NA0KPiAtLS0gYS9mcy9oZnNw
bHVzL2J0cmVlLmMNCj4gKysrIGIvZnMvaGZzcGx1cy9idHJlZS5jDQo+IEBAIC0xMjksNiArMTI5
LDQ3IEBAIHUzMiBoZnNwbHVzX2NhbGNfYnRyZWVfY2x1bXBfc2l6ZSh1MzIgYmxvY2tfc2l6ZSwg
dTMyIG5vZGVfc2l6ZSwNCj4gIAlyZXR1cm4gY2x1bXBfc2l6ZTsNCj4gIH0NCj4gIA0KPiArLyoN
Cj4gKyAqIE1hcHMgdGhlIHBhZ2UgY29udGFpbmluZyB0aGUgYi10cmVlIG1hcCByZWNvcmQgYW5k
IGNhbGN1bGF0ZXMgb2Zmc2V0cy4NCj4gKyAqIEF1dG9tYXRpY2FsbHkgaGFuZGxlcyB0aGUgZGlm
ZmVyZW5jZSBiZXR3ZWVuIGhlYWRlciBhbmQgbWFwIG5vZGVzLg0KPiArICogUmV0dXJucyB0aGUg
bWFwcGVkIGRhdGEgcG9pbnRlciwgb3IgYW4gRVJSX1BUUiBvbiBmYWlsdXJlLg0KPiArICogTm90
ZTogVGhlIGNhbGxlciBpcyByZXNwb25zaWJsZSBmb3IgY2FsbGluZyBrdW5tYXBfbG9jYWwoZGF0
YSkuDQo+ICsgKi8NCj4gK3N0YXRpYyB1OCAqaGZzX2JtYXBfZ2V0X21hcF9wYWdlKHN0cnVjdCBo
ZnNfYm5vZGUgKm5vZGUsIHUxNiAqb2ZmLCB1MTYgKmxlbiwNCj4gKwkJCQl1bnNpZ25lZCBpbnQg
KnBhZ2VfaWR4KQ0KDQpJIHRoaW5rIHdlIGRvbid0IG5lZWQgaW4gb2ZmLCBsZW4sIHBhZ2VfaWR4
IGFyZ3VtZW50cyBoZXJlLiBJIHN1Z2dlc3Qgc2xpZ2h0bHkNCmRpZmZlcmVudCBpbnRlcmZhY2U6
DQoNCnU4IGhmc19ibWFwX2dldF9tYXBfYnl0ZShzdHJ1Y3QgaGZzX2Jub2RlICpub2RlLCB1MzIg
Yml0X2luZGV4KTsNCmludCBoZnNfYm1hcF9zZXRfbWFwX2J5dGUoc3RydWN0IGhmc19ibm9kZSAq
bm9kZSwgdTMyIGJpdF9pbmRleCwgdTggYnl0ZSk7DQoNCkluIHRoaXMgY2FzZSBtZW1vcnkgb3Bl
cmF0aW9ucyB3aWxsIGJlIGF0b21pYyBvbmVzIGFuZCBhbGwNCmttYXBfbG9jYWwoKS9rdW5tYXBf
bG9jYWwoKSB3aWxsIGJlIGhpZGRlbiBpbnNpZGUgdGhlc2UgbWV0aG9kcy4gSG93ZXZlciwgSSBh
bQ0Kc2xpZ2h0bHkgd29ycmllZCB0aGF0IEkgZG9uJ3Qgc2VlIGFueSBsb2NraW5nIG1lY2hhbmlz
bXMgaW4gaGZzX2JtYXBfYWxsb2MoKS4gQXQNCm1pbmltdW0sIEkgYmVsaWV2ZSB3ZSBjYW4gdXNl
IGxvY2tfcGFnZSgpL3VubG9ja19wYWdlKCkgaGVyZS4gSG93ZXZlciwgaXQgd2lsbA0KYmUgbm90
IGVub3VnaC4gSXQgaXMgZ29vZCBmb3IgYWNjZXNzaW5nIG9ubHkgb25lIHBhZ2UuIEJ1dCB3ZSBu
ZWVkIHNvbWUgbG9jayBmb3INCnRoZSB3aG9sZSBiaXRtYXAuIE1heWJlLCBJIGFtIG1pc3Npbmcg
c29tZXRoaW5nLiBCdXQgaWYgSSBhbSBub3QsIHRoZW4gd2UgaGF2ZSBhDQpodWdlIHJvb20gZm9y
IHJhY2UgY29uZGl0aW9ucyBpbiBiLXRyZWUgb3BlcmF0aW9ucy4NCg0KUHJvYmFibHksIHlvdSBj
b3VsZCBuZWVkIHNvbWV0aGluZyBsaWtlIGhmc19ibWFwX2dldF9tYXBfcGFnZSgpLiBCdXQgeW91
IGRvbid0DQpuZWVkIGFsbCBvZiB0aGVzZSBhcmd1bWVudHMgKG9mZiwgbGVuLCBwYWdlX2lkeCkg
d2l0aCBzdWdnZXN0ZWQgaW50ZXJmYWNlLg0KQmVjYXVzZSwgYml0X2luZGV4IHNob3VsZCBiZSBl
bm91Z2ggdG8gaWRlbnRpZnkgdGhlIHByb3BlciBtZW1vcnkgcGFnZS9mb2xpbyBhbmQNCmdldC9z
ZXQgYnl0ZXMgdGhlcmUuDQoNCj4gK3sNCj4gKwl1MTYgcmVjX2lkeCwgb2ZmMTY7DQo+ICsNCj4g
KwlpZiAobm9kZS0+dGhpcyA9PSBIRlNQTFVTX1RSRUVfSEVBRCkgew0KPiArCQlpZiAobm9kZS0+
dHlwZSAhPSBIRlNfTk9ERV9IRUFERVIpIHsNCj4gKwkJCXByX2VycigiaGZzcGx1czogaW52YWxp
ZCBidHJlZSBoZWFkZXIgbm9kZVxuIik7DQo+ICsJCQlyZXR1cm4gRVJSX1BUUigtRUlPKTsNCj4g
KwkJfQ0KPiArCQlyZWNfaWR4ID0gSEZTUExVU19CVFJFRV9IRFJfTUFQX1JFQ19JTkRFWDsNCj4g
Kwl9IGVsc2Ugew0KPiArCQlpZiAobm9kZS0+dHlwZSAhPSBIRlNfTk9ERV9NQVApIHsNCj4gKwkJ
CXByX2VycigiaGZzcGx1czogaW52YWxpZCBidHJlZSBtYXAgbm9kZVxuIik7DQo+ICsJCQlyZXR1
cm4gRVJSX1BUUigtRUlPKTsNCj4gKwkJfQ0KPiArCQlyZWNfaWR4ID0gSEZTUExVU19CVFJFRV9N
QVBfTk9ERV9SRUNfSU5ERVg7DQo+ICsJfQ0KPiArDQo+ICsJKmxlbiA9IGhmc19icmVjX2xlbm9m
Zihub2RlLCByZWNfaWR4LCAmb2ZmMTYpOw0KPiArCWlmICghKmxlbikNCj4gKwkJcmV0dXJuIEVS
Ul9QVFIoLUVOT0VOVCk7DQo+ICsNCj4gKwlpZiAoIWlzX2Jub2RlX29mZnNldF92YWxpZChub2Rl
LCBvZmYxNikpDQo+ICsJCXJldHVybiBFUlJfUFRSKC1FSU8pOw0KPiArDQo+ICsJKmxlbiA9IGNo
ZWNrX2FuZF9jb3JyZWN0X3JlcXVlc3RlZF9sZW5ndGgobm9kZSwgb2ZmMTYsICpsZW4pOw0KPiAr
DQo+ICsJb2ZmMTYgKz0gbm9kZS0+cGFnZV9vZmZzZXQ7DQo+ICsJKnBhZ2VfaWR4ID0gb2ZmMTYg
Pj4gUEFHRV9TSElGVDsNCj4gKwkqb2ZmID0gb2ZmMTYgJiB+UEFHRV9NQVNLOw0KPiArDQo+ICsJ
cmV0dXJuIGttYXBfbG9jYWxfcGFnZShub2RlLT5wYWdlWypwYWdlX2lkeF0pOw0KPiArfQ0KPiAr
DQo+ICAvKiBHZXQgYSByZWZlcmVuY2UgdG8gYSBCKlRyZWUgYW5kIGRvIHNvbWUgaW5pdGlhbCBj
aGVja3MgKi8NCj4gIHN0cnVjdCBoZnNfYnRyZWUgKmhmc19idHJlZV9vcGVuKHN0cnVjdCBzdXBl
cl9ibG9jayAqc2IsIHUzMiBpZCkNCj4gIHsNCj4gQEAgLTM3NCwxMCArNDE1LDkgQEAgaW50IGhm
c19ibWFwX3Jlc2VydmUoc3RydWN0IGhmc19idHJlZSAqdHJlZSwgdTMyIHJzdmRfbm9kZXMpDQo+
ICBzdHJ1Y3QgaGZzX2Jub2RlICpoZnNfYm1hcF9hbGxvYyhzdHJ1Y3QgaGZzX2J0cmVlICp0cmVl
KQ0KPiAgew0KPiAgCXN0cnVjdCBoZnNfYm5vZGUgKm5vZGUsICpuZXh0X25vZGU7DQo+IC0Jc3Ry
dWN0IHBhZ2UgKipwYWdlcDsNCj4gKwl1bnNpZ25lZCBpbnQgcGFnZV9pZHg7DQo+ICAJdTMyIG5p
ZHgsIGlkeDsNCj4gLQl1bnNpZ25lZCBvZmY7DQo+IC0JdTE2IG9mZjE2Ow0KPiArCXUxNiBvZmY7
DQo+ICAJdTE2IGxlbjsNCj4gIAl1OCAqZGF0YSwgYnl0ZSwgbTsNCj4gIAlpbnQgaSwgcmVzOw0K
PiBAQCAtMzkwLDMwICs0MzAsMjQgQEAgc3RydWN0IGhmc19ibm9kZSAqaGZzX2JtYXBfYWxsb2Mo
c3RydWN0IGhmc19idHJlZSAqdHJlZSkNCj4gIAlub2RlID0gaGZzX2Jub2RlX2ZpbmQodHJlZSwg
bmlkeCk7DQo+ICAJaWYgKElTX0VSUihub2RlKSkNCj4gIAkJcmV0dXJuIG5vZGU7DQo+IC0JbGVu
ID0gaGZzX2JyZWNfbGVub2ZmKG5vZGUsIDIsICZvZmYxNik7DQo+IC0Jb2ZmID0gb2ZmMTY7DQo+
IC0NCj4gLQlpZiAoIWlzX2Jub2RlX29mZnNldF92YWxpZChub2RlLCBvZmYpKSB7DQo+ICsJZGF0
YSA9IGhmc19ibWFwX2dldF9tYXBfcGFnZShub2RlLCAmb2ZmLCAmbGVuLCAmcGFnZV9pZHgpOw0K
PiArCWlmIChJU19FUlIoZGF0YSkpIHsNCj4gKwkJcmVzID0gUFRSX0VSUihkYXRhKTsNCj4gIAkJ
aGZzX2Jub2RlX3B1dChub2RlKTsNCj4gLQkJcmV0dXJuIEVSUl9QVFIoLUVJTyk7DQo+ICsJCXJl
dHVybiBFUlJfUFRSKHJlcyk7DQo+ICAJfQ0KPiAtCWxlbiA9IGNoZWNrX2FuZF9jb3JyZWN0X3Jl
cXVlc3RlZF9sZW5ndGgobm9kZSwgb2ZmLCBsZW4pOw0KPiAgDQo+IC0Jb2ZmICs9IG5vZGUtPnBh
Z2Vfb2Zmc2V0Ow0KPiAtCXBhZ2VwID0gbm9kZS0+cGFnZSArIChvZmYgPj4gUEFHRV9TSElGVCk7
DQo+IC0JZGF0YSA9IGttYXBfbG9jYWxfcGFnZSgqcGFnZXApOw0KPiAtCW9mZiAmPSB+UEFHRV9N
QVNLOw0KPiAgCWlkeCA9IDA7DQo+ICANCj4gIAlmb3IgKDs7KSB7DQo+ICAJCXdoaWxlIChsZW4p
IHsNCj4gIAkJCWJ5dGUgPSBkYXRhW29mZl07DQo+ICAJCQlpZiAoYnl0ZSAhPSAweGZmKSB7DQo+
IC0JCQkJZm9yIChtID0gMHg4MCwgaSA9IDA7IGkgPCA4OyBtID4+PSAxLCBpKyspIHsNCj4gKwkJ
CQlmb3IgKG0gPSBIRlNQTFVTX0JUUkVFX05PREUwX0JJVCwgaSA9IDA7IGkgPCA4OyBtID4+PSAx
LCBpKyspIHsNCg0KWW91IGFyZSBub3QgcmlnaHQgaGVyZS4gVGhlIDB4ODAgaXMgc2ltcGx5IHBh
dHRlcm4gYW5kIGl0J3Mgbm90DQpIRlNQTFVTX0JUUkVFX05PREUwX0JJVC4gQmVjYXVzZSwgaXQg
Y291bGQgYmUgYW55IGJ5dGUgb2YgdGhlIG1hcC4NCg0KVGhhbmtzLA0KU2xhdmEuDQoNCj4gIAkJ
CQkJaWYgKCEoYnl0ZSAmIG0pKSB7DQo+ICAJCQkJCQlpZHggKz0gaTsNCj4gIAkJCQkJCWRhdGFb
b2ZmXSB8PSBtOw0KPiAtCQkJCQkJc2V0X3BhZ2VfZGlydHkoKnBhZ2VwKTsNCj4gKwkJCQkJCXNl
dF9wYWdlX2RpcnR5KG5vZGUtPnBhZ2VbcGFnZV9pZHhdKTsNCj4gIAkJCQkJCWt1bm1hcF9sb2Nh
bChkYXRhKTsNCj4gIAkJCQkJCXRyZWUtPmZyZWVfbm9kZXMtLTsNCj4gIAkJCQkJCW1hcmtfaW5v
ZGVfZGlydHkodHJlZS0+aW5vZGUpOw0KPiBAQCAtNDI1LDcgKzQ1OSw3IEBAIHN0cnVjdCBoZnNf
Ym5vZGUgKmhmc19ibWFwX2FsbG9jKHN0cnVjdCBoZnNfYnRyZWUgKnRyZWUpDQo+ICAJCQl9DQo+
ICAJCQlpZiAoKytvZmYgPj0gUEFHRV9TSVpFKSB7DQo+ICAJCQkJa3VubWFwX2xvY2FsKGRhdGEp
Ow0KPiAtCQkJCWRhdGEgPSBrbWFwX2xvY2FsX3BhZ2UoKisrcGFnZXApOw0KPiArCQkJCWRhdGEg
PSBrbWFwX2xvY2FsX3BhZ2Uobm9kZS0+cGFnZVsrK3BhZ2VfaWR4XSk7DQo+ICAJCQkJb2ZmID0g
MDsNCj4gIAkJCX0NCj4gIAkJCWlkeCArPSA4Ow0KPiBAQCAtNDQzLDEyICs0NzcsMTIgQEAgc3Ry
dWN0IGhmc19ibm9kZSAqaGZzX2JtYXBfYWxsb2Moc3RydWN0IGhmc19idHJlZSAqdHJlZSkNCj4g
IAkJCXJldHVybiBuZXh0X25vZGU7DQo+ICAJCW5vZGUgPSBuZXh0X25vZGU7DQo+ICANCj4gLQkJ
bGVuID0gaGZzX2JyZWNfbGVub2ZmKG5vZGUsIDAsICZvZmYxNik7DQo+IC0JCW9mZiA9IG9mZjE2
Ow0KPiAtCQlvZmYgKz0gbm9kZS0+cGFnZV9vZmZzZXQ7DQo+IC0JCXBhZ2VwID0gbm9kZS0+cGFn
ZSArIChvZmYgPj4gUEFHRV9TSElGVCk7DQo+IC0JCWRhdGEgPSBrbWFwX2xvY2FsX3BhZ2UoKnBh
Z2VwKTsNCj4gLQkJb2ZmICY9IH5QQUdFX01BU0s7DQo+ICsJCWRhdGEgPSBoZnNfYm1hcF9nZXRf
bWFwX3BhZ2Uobm9kZSwgJm9mZiwgJmxlbiwgJnBhZ2VfaWR4KTsNCj4gKwkJaWYgKElTX0VSUihk
YXRhKSkgew0KPiArCQkJcmVzID0gUFRSX0VSUihkYXRhKTsNCj4gKwkJCWhmc19ibm9kZV9wdXQo
bm9kZSk7DQo+ICsJCQlyZXR1cm4gRVJSX1BUUihyZXMpOw0KPiArCQl9DQo+ICAJfQ0KPiAgfQ0K
PiAgDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2hmc19jb21tb24uaCBiL2luY2x1ZGUv
bGludXgvaGZzX2NvbW1vbi5oDQo+IGluZGV4IGRhZGI1ZTBhYThhMy4uODIzOGY1NWRkMWQzIDEw
MDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2hmc19jb21tb24uaA0KPiArKysgYi9pbmNsdWRl
L2xpbnV4L2hmc19jb21tb24uaA0KPiBAQCAtNTEwLDcgKzUxMCwxMCBAQCBzdHJ1Y3QgaGZzX2J0
cmVlX2hlYWRlcl9yZWMgew0KPiAgI2RlZmluZSBIRlNQTFVTX05PREVfTVhTWgkJCTMyNzY4DQo+
ICAjZGVmaW5lIEhGU1BMVVNfQVRUUl9UUkVFX05PREVfU0laRQkJODE5Mg0KPiAgI2RlZmluZSBI
RlNQTFVTX0JUUkVFX0hEUl9OT0RFX1JFQ1NfQ09VTlQJMw0KPiArI2RlZmluZSBIRlNQTFVTX0JU
UkVFX0hEUl9NQVBfUkVDX0lOREVYCQkyCS8qIE1hcCAoYml0bWFwKSByZWNvcmQgaW4gSGVhZGVy
IG5vZGUgKi8NCj4gKyNkZWZpbmUgSEZTUExVU19CVFJFRV9NQVBfTk9ERV9SRUNfSU5ERVgJMAkv
KiBNYXAgcmVjb3JkIGluIE1hcCBOb2RlICovDQo+ICAjZGVmaW5lIEhGU1BMVVNfQlRSRUVfSERS
X1VTRVJfQllURVMJCTEyOA0KPiArI2RlZmluZSBIRlNQTFVTX0JUUkVFX05PREUwX0JJVAkJCSgx
IDw8IDcpDQo+ICANCj4gIC8qIGJ0cmVlIGtleSB0eXBlICovDQo+ICAjZGVmaW5lIEhGU1BMVVNf
S0VZX0NBU0VGT0xESU5HCQkweENGCS8qIGNhc2UtaW5zZW5zaXRpdmUgKi8NCg==

