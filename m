Return-Path: <linux-fsdevel+bounces-76065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHTHDD/WgGmFBwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 17:52:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD2BCF2EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 17:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1315A301FBCA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 16:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2623816F2;
	Mon,  2 Feb 2026 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="J46ag3Lo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021082.outbound.protection.outlook.com [52.101.62.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE831400C;
	Mon,  2 Feb 2026 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051088; cv=fail; b=r/DVKIW3B5mt/9ffxxZcT/2VtO+CFB0FOP3W5t3pn0Batt4/1UHZhuDv/EqWr7TPK+e5GV+61uUu3S5b8c8ae5rexgBQEYp+ed0aNNu9Oa+q93NdIldblVV+RH0DMY+LZkE7ufevbyMfcYWTJsV5vPPldCzMpIumuFqwN57GO78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051088; c=relaxed/simple;
	bh=wiKqM4dtDMfv6nZxW0wfCbRnKoBOGl/cM+JFXt467DI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=seM1QnZJDW3O9tPIej5nQiV1iIYlii5IA/+RJyJbJih3uAWyNnFzPjtYCH058b90gR4d56nFvJ2Rdioaj19GnrRqs1ZlOpXNdU58q764cHm6gVCGBcNnCXn8QvV1xtifmLa/tviIiInFD6zOS32l/e4H/W6Z95+m1eHVkWXjISY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=J46ag3Lo; arc=fail smtp.client-ip=52.101.62.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8kMNpN7oNkxTO9XDVP+4b5vtHceP1AMiPcF2svgNvznNN0LfDn5agURs1Ql4LMQxsiJlYjMg88OOZXZIO/mrZFXGPXrB5ZAXsJc0/CW8jqJGy/254dokt4HAV3cfB5fX3NNemNlSZKfMLUKYbIAFiKLE08ZN9D5csmLR+wxc2/+xttsTRtbn6D7hjUnzlkoaXR9z2DzvmCBWMoRWKWMqKoShaonmZ1kpTA/g5UGANmEclxJ6naNgJ6MkwRg5nZQXIKxYKqhpe+J2DFPi55/b+AFfsfPw94ZoGati9BsdmZ40k2oDe1GsyrAVkwbvvd8VEmcAGWVHqK3y9KZ+SbkUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nm7cZ0jG0W2wPWbCOlJkxMATHvuyH1yyA8frGtX+X2U=;
 b=YY2/mwrbQs34DRyVkKdweGA+/XF3fm8TVh0Luq/4HobTwZW+wuWhCDrlSGVRbhBFYDLQVDQqhIVoedBkz7/nPteSQg8Wxi5qts4/VD2X69dUfIODrCyq7McCwaMhA4S2Kf0qZeJ9yqmpy2b/7dWVQD6oHkM25mt+vopWgU1niL360QYbvow45kG/Cue7SW/LqsgJ8744wHiNn9EzQ6Xt18Ikrxf1pXzgKLD0SOLhAQzjhLrMFyL5uPr8+PocIRVKsgHzFfzijWcu7CIDRFMyJFS/F5oNIQLIauMSsgoYsQpHKTPjw2BJku2Rryj0nbnAWsvIr4e/YUaWn7W1fG1z+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nm7cZ0jG0W2wPWbCOlJkxMATHvuyH1yyA8frGtX+X2U=;
 b=J46ag3LoeGPyY1p8AH7qtFVdYUEq4NOFlrS8r3lf0UN4Fx4UWZmJsBKRIs/zEKxqf+DgQLvelEhsSjBTPdAkoLF9tRI+JrZgL54r86A2Gk66aNWxoH8QRu2JNx6Rdysv2qeecKOHbJnqthS//W0GXzfMq18OM9E72T23HbVbX1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from BN0PR13MB5246.namprd13.prod.outlook.com (2603:10b6:408:159::12)
 by DS7PR13MB4686.namprd13.prod.outlook.com (2603:10b6:5:3a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 16:51:12 +0000
Received: from BN0PR13MB5246.namprd13.prod.outlook.com
 ([fe80::39d0:ce59:f47d:5577]) by BN0PR13MB5246.namprd13.prod.outlook.com
 ([fe80::39d0:ce59:f47d:5577%6]) with mapi id 15.20.9564.014; Mon, 2 Feb 2026
 16:51:11 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>,
 Benjamin Coddington <bcodding@hammerspace.com>,
 Eric Biggers <ebiggers@kernel.org>, Rick Macklem <rick.macklem@gmail.com>
Cc: <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] NFSD: Add a key for signing filehandles
Date: Mon, 02 Feb 2026 11:51:03 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <45956CAA-4AA1-4216-8B83-C4D3F2FFD67D@hammerspace.com>
In-Reply-To: <e3806f53c351c03725ecb12fb7ad100786df04f6.1770046529.git.bcodding@hammerspace.com>
References: <cover.1770046529.git.bcodding@hammerspace.com>
 <e3806f53c351c03725ecb12fb7ad100786df04f6.1770046529.git.bcodding@hammerspace.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH8P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::15) To BN0PR13MB5246.namprd13.prod.outlook.com
 (2603:10b6:408:159::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR13MB5246:EE_|DS7PR13MB4686:EE_
X-MS-Office365-Filtering-Correlation-Id: 249c5dc9-7734-45e2-0bd8-08de627b4554
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IPe4JqXPARJA8hsqj834DjfTOjfMIS/du8i7sPpvDCpcqZKjm2JO5vr+EHzP?=
 =?us-ascii?Q?Me2Wk7ac5ot5/NWk0JsCtFC4WqQldmpooMdiIbpDvXOM/EpEM81W0NEtUrps?=
 =?us-ascii?Q?y6lrAotrL3vjyTEsuLJaqWoCvaRhXlJCsgiQPW0wjWNJS85Xo2JBReeYNXPV?=
 =?us-ascii?Q?8AXrvOy8aIs3SuM0RdASGvrVkfTEzRQ09kaAGnrvILDF6n3q9klVpsV0/DtC?=
 =?us-ascii?Q?8jRjpQyoWrGDamS7NbXneQ2HRMhwjys0Ee17O59hAQVov5B0aJFjBB//Ccfj?=
 =?us-ascii?Q?p+Mfrznr8oOcPzaAtRtxhPiaVAaju1Wq2CpBSIQTbgB/Ddx3/YYihjDYb2w7?=
 =?us-ascii?Q?+V5nHW+0CONirtPTdFyG64lRjSKRk2+LGj5j8r9Yk0pB9vbzzEcfnVDOMa4X?=
 =?us-ascii?Q?ZUIDX7lGVXKvbR4RnoSA9HHJzr/+/1zg1KTuxkTKmJ+Cj9duK6orr7kwU2Qu?=
 =?us-ascii?Q?eESOKWDxRhaNT4GxeDhtAEnNAY0SvciJw/CqNwMzo+hQEiPuyFXHDMjfs3SJ?=
 =?us-ascii?Q?E8kAye8J4yOcFKCJIyjPdXMoN3p46+phALTl+A6aVR/6ylPiDI1eVPO3m/s4?=
 =?us-ascii?Q?fqTqrAdmM9PMwf9i4MAJr7VX0bpFoF2owluzgM0/NC5tnbiy2x5W2WczlXZY?=
 =?us-ascii?Q?+cvu6g2EwmvkwQvpHIM30vOummlDfBEnhQrjQfWaFPQ74pacRBw/OGCcRL+s?=
 =?us-ascii?Q?UM4WPkQ0bFYeTmMIQn9hCDThRh/Ds27cbA1GbSwy7W4OHcd9rrMAkFJZfbMf?=
 =?us-ascii?Q?07+tIIpCNalFJVoCo+JOatBSnFAQ3uBcX4RXVfCPwR22wFkmygsUJe4xt2ey?=
 =?us-ascii?Q?xdQHFDhAKGF5mpkTRGYZvVlyc3gAmyUsC8hEzlrl1KVZkjCHo2kjxfBYMxos?=
 =?us-ascii?Q?MKhO6RnzyY9MFnviIBCqSIk0McAyITb4TJI0daT1uD+wJPMkbax0nuRtqq+4?=
 =?us-ascii?Q?58jLFSDRoBma0xeIsGk1+YybNCvkzOUpInhfHZZizYeunT31c2ECgaYkiJIa?=
 =?us-ascii?Q?BIdCtTCanIBSokcW1Ez5ksOyb5UU+AM7Bo0G6NX7EX8j41K3qYPXlyRGi7jJ?=
 =?us-ascii?Q?FfLWUqAoW2RyeUKYhJ5rFUE6Uc7MtTE5logf4KpMaq/tNRLoC6KOdoIb28HL?=
 =?us-ascii?Q?/51QRKasbYp6A4nRlmyFSkUIC6J/m33+ykBNQ+9RNGXNSWR0s+PCQwPvphuz?=
 =?us-ascii?Q?ymwAAVdfXogFTbrsUgmjLQqUD6Infl9SyJf1Wvx/IOjySKO9beqN6r0hf+J5?=
 =?us-ascii?Q?Dz2PQ8V8vhOv/m+96OaYQdqu6lnpqGJdHODms9jeKn3SCSR6CmCw4SHN5OXX?=
 =?us-ascii?Q?+DUo5ELw9M0q2aM6F1m2xOyh1qBQDb6cBrhF6walik8zrMwWKyOAb6ka8ssv?=
 =?us-ascii?Q?u/+7NFe0Qy0qJR1zG+BOiv8/uO53gYsbXJBJHCqfzNlMbg0qVaEciWSyUDxb?=
 =?us-ascii?Q?s2OzUR8pLbIJGoxrnJW8eraQjtg3eacIkN0XlSIZBuUlhYrOHtarWjdQW+s/?=
 =?us-ascii?Q?dTSnvewICQFPW4uDgRdthmtMpRPoyfwkiTrKpcUzVgFgXtsx6KzciLmFjwWq?=
 =?us-ascii?Q?ZoY9OZBu7P8ug279o4I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR13MB5246.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UXTY0kWZnCIStUuzTaL426utG/W/O1q9RmFClhrBwgWSHYIqixodUL730D/m?=
 =?us-ascii?Q?s+efVLX/v37goDAknpScIOtrWqcvxWrvzjcxU0b6UJeRb62uvC5GT4mZ0DUR?=
 =?us-ascii?Q?ZE50bHLONKHkz80f5VHRzd2lREY0szR76khtBZApQRI1AOASyP1J5cRa4jpM?=
 =?us-ascii?Q?/3pMi/3CPfVvV+f9M0SkWjunWRz3b8E2oZMKcouua7QTqMxJapdalCDZFgEd?=
 =?us-ascii?Q?mhCKhlx9jLdYet3Q4I4rHoMW4KfSezdvQx98MXVZoBAnlQdjS8UnaFATEIFs?=
 =?us-ascii?Q?yG2/2cb/Y4micAYlbiQswb5iRipD2YinatLWNHUFCniRDi4o7Di+12x1RJcg?=
 =?us-ascii?Q?nFFRBNYL4YvOloXltuKlrMgRukzml+mhp3MpMISJdH3kti7DXozAFyKgQj16?=
 =?us-ascii?Q?n47HhkZOmPXfhEPr4B4N8B9T4HnSN+2u7qy+qPKlNHLx07L3CkIRII7LWuz1?=
 =?us-ascii?Q?2OfAPjv4M7wLCaksvZHAenxqbKkQhKwtHmksL3wJ/OCAGYWRfyr5nGJ1jSuz?=
 =?us-ascii?Q?iw8w3LGXAtMT1aTqsK+rYiMupy+yItXsBq43KONOueuekUA2jAu15ZhmwHoT?=
 =?us-ascii?Q?7dM4jhp9bf7HfLelhFQTI641OTcQIHY8D3ixOVN4ojmywCU7qSs14ReVphvW?=
 =?us-ascii?Q?bMEV9X+SHfEiPQ/VcCHFHV7eAwJ61kC1ZsfcepXl96X+N9ZZlPUxYM4+kMsk?=
 =?us-ascii?Q?y+AgwWFrup4yINmrcRXQscJ+QbR5Pzkg7pE9isn/soitRrWOaidhGFnww6hX?=
 =?us-ascii?Q?c/tcPeSC1YinIMrxNpNxZtpqc20bwSWsE4DdyaZ2Pl/bqiErpWPdLIMpz1bM?=
 =?us-ascii?Q?qqzgmLxWaT2BQ9FlgvRnoQEia5qR4sLb17mYsR2ema5nhvnggWB9RHdTbbv/?=
 =?us-ascii?Q?J3fYZm93SN7wWadqB3E7s6zJkLZBYX/EuG/9jZoJrYKxoStszsDuMmtjQQM5?=
 =?us-ascii?Q?o5U2Lpj5ZcUn/V0ZSx3zwZiw7kyPdAaLKlTuAwnOwJveCEhqGCGV+kL58ICe?=
 =?us-ascii?Q?czkOwO1McjIIY1K3MrJmwQUyDtccguCY4P4DT55kRSdQ31tuyGWdAOb1oLnO?=
 =?us-ascii?Q?j9A3DiGiij23Pbkcky93zh8tfFp+cmolkOJRY0krH5rj9YR9I014vJH2/nbz?=
 =?us-ascii?Q?6kmAamMHNsZBkhpo/1J1NadsR1GtbOpPO9cQZru54U+feF8ER2ebvvq20Ago?=
 =?us-ascii?Q?mJi+nCj/gAmTatL5HfgpgXX759nNqG4jHyko1wDFvdDWx7T6AzuUu04DEyln?=
 =?us-ascii?Q?WaIwYQixj0/cZw0PwWmdcN2ZDUyUFGlKKrJvALKbcnPsBebcpfmUwkJrPjBM?=
 =?us-ascii?Q?vKX5aidI2bCJr9kjniebRDjrj7+vynkNV4JRuVemFyYrxjbeHyPfG+Bz0yfL?=
 =?us-ascii?Q?KYolQQ7jWUjkW8QxSCEE4MFCqz0LM66vvNfw1aHRO9XeUwf3Pvb+ctQqqsyN?=
 =?us-ascii?Q?Km/xXSEOkilqtFm58IQReBVs+uyU4JfI5OiBGpSQzInfEGoyqC/Cr/NjC+GK?=
 =?us-ascii?Q?J7EZLNJ3VmNdQWLvQX6XgcNvwUBUggq8XfOSH+7zOz52gC7jK6+Fp1TQUdRS?=
 =?us-ascii?Q?35nzrHch75UqGQKXvTa/vG6J3gohyXMn+a5bj790VnZKPazE6Xv6oIQFyVuf?=
 =?us-ascii?Q?vzcsrE7c3tPijEP4pUD8b2CrBgn4mcrVCiRPvW7kcGHJ4SEYFI0MBzFwYFrS?=
 =?us-ascii?Q?+KM8wStqpd5cPymlu00gMqsjMrYzb2KWcMORPgg/8jLLjRbaqYqcLfvxp7fY?=
 =?us-ascii?Q?3TyHfth2kYYDqWfZ0INW8ANFMd7M8Ro=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249c5dc9-7734-45e2-0bd8-08de627b4554
X-MS-Exchange-CrossTenant-AuthSource: BN0PR13MB5246.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:51:11.8289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sd4IXtASjRupsLjOa5R27F/0w/BZuR7bEziRTpg99V1RfvxTG20P8nrwe93Beplmt5riGqmwqsLe6Xd9z8sURb6FPW5LYvxbC5c5UsNzkMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4686
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76065-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid]
X-Rspamd-Queue-Id: ADD2BCF2EA
X-Rspamd-Action: no action

On 2 Feb 2026, at 11:19, Benjamin Coddington wrote:

> A future patch will enable NFSD to sign filehandles by appending a Mess=
age
> Authentication Code(MAC).  To do this, NFSD requires a secret 128-bit k=
ey
> that can persist across reboots.  A persisted key allows the server to
> accept filehandles after a restart.  Enable NFSD to be configured with =
this
> key the netlink interface.
>
> Link: https://lore.kernel.org/linux-nfs/cover.1770046529.git.bcodding@h=
ammerspace.com
> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> ---
>  Documentation/netlink/specs/nfsd.yaml |  6 +++++
>  fs/nfsd/netlink.c                     |  5 ++--
>  fs/nfsd/netns.h                       |  2 ++
>  fs/nfsd/nfsctl.c                      | 37 ++++++++++++++++++++++++++-=

>  fs/nfsd/trace.h                       | 25 ++++++++++++++++++
>  include/uapi/linux/nfsd_netlink.h     |  1 +
>  6 files changed, 73 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netl=
ink/specs/nfsd.yaml
> index badb2fe57c98..d348648033d9 100644
> --- a/Documentation/netlink/specs/nfsd.yaml
> +++ b/Documentation/netlink/specs/nfsd.yaml
> @@ -81,6 +81,11 @@ attribute-sets:
>        -
>          name: min-threads
>          type: u32
> +      -
> +        name: fh-key
> +        type: binary
> +        checks:
> +            exact-len: 16
>    -
>      name: version
>      attributes:
> @@ -163,6 +168,7 @@ operations:
>              - leasetime
>              - scope
>              - min-threads
> +            - fh-key
>      -
>        name: threads-get
>        doc: get the number of running threads
> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> index 887525964451..4e08c1a6b394 100644
> --- a/fs/nfsd/netlink.c
> +++ b/fs/nfsd/netlink.c
> @@ -24,12 +24,13 @@ const struct nla_policy nfsd_version_nl_policy[NFSD=
_A_VERSION_ENABLED + 1] =3D {
>  };
>
>  /* NFSD_CMD_THREADS_SET - do */
> -static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVE=
R_MIN_THREADS + 1] =3D {
> +static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVE=
R_FH_KEY + 1] =3D {
>  	[NFSD_A_SERVER_THREADS] =3D { .type =3D NLA_U32, },
>  	[NFSD_A_SERVER_GRACETIME] =3D { .type =3D NLA_U32, },
>  	[NFSD_A_SERVER_LEASETIME] =3D { .type =3D NLA_U32, },
>  	[NFSD_A_SERVER_SCOPE] =3D { .type =3D NLA_NUL_STRING, },
>  	[NFSD_A_SERVER_MIN_THREADS] =3D { .type =3D NLA_U32, },
> +	[NFSD_A_SERVER_FH_KEY] =3D NLA_POLICY_EXACT_LEN(16),
>  };
>
>  /* NFSD_CMD_VERSION_SET - do */
> @@ -58,7 +59,7 @@ static const struct genl_split_ops nfsd_nl_ops[] =3D =
{
>  		.cmd		=3D NFSD_CMD_THREADS_SET,
>  		.doit		=3D nfsd_nl_threads_set_doit,
>  		.policy		=3D nfsd_threads_set_nl_policy,
> -		.maxattr	=3D NFSD_A_SERVER_MIN_THREADS,
> +		.maxattr	=3D NFSD_A_SERVER_MAX,
>  		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>  	},
>  	{
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 9fa600602658..c8ed733240a0 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -16,6 +16,7 @@
>  #include <linux/percpu-refcount.h>
>  #include <linux/siphash.h>
>  #include <linux/sunrpc/stats.h>
> +#include <linux/siphash.h>
>
>  /* Hash tables for nfs4_clientid state */
>  #define CLIENT_HASH_BITS                 4
> @@ -224,6 +225,7 @@ struct nfsd_net {
>  	spinlock_t              local_clients_lock;
>  	struct list_head	local_clients;
>  #endif
> +	siphash_key_t		*fh_key;
>  };
>
>  /* Simple check to find out if a given net was properly initialized */=

> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 4d8e3c1a7be3..590584952bf6 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1571,6 +1571,31 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff=
 *skb,
>  	return ret;
>  }
>
> +/**
> + * nfsd_nl_fh_key_set - helper to copy fh_key from userspace
> + * @attr: nlattr NFSD_A_SERVER_FH_KEY
> + * @nn: nfsd_net
> + *
> + * Callers should hold nfsd_mutex, returns 0 on success or negative er=
rno.
> + */
> +static int nfsd_nl_fh_key_set(const struct nlattr *attr, struct nfsd_n=
et *nn)
> +{
> +	siphash_key_t *fh_key;
> +
> +	if (nla_len(attr) !=3D sizeof(siphash_key_t))
> +		return -EINVAL;
> +
> +	if (!nn->fh_key) {
> +		fh_key =3D kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
> +		if (!fh_key)
> +			return -ENOMEM;
> +	}
> +
> +	memcpy(fh_key, nla_data(attr), sizeof(siphash_key_t));
> +	nn->fh_key =3D fh_key;
> +	return 0;
> +}
> +

Oof, I messed it up right here^^ this hunk needed to be folded in.. can s=
end another version on this one:

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 590584952bf6..9b94e1ed98e0 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1580,19 +1580,18 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff =
*skb,
  */
 static int nfsd_nl_fh_key_set(const struct nlattr *attr, struct nfsd_net=
 *nn)
 {
-       siphash_key_t *fh_key;
+       siphash_key_t *fh_key =3D nn->fh_key;

        if (nla_len(attr) !=3D sizeof(siphash_key_t))
                return -EINVAL;

-       if (!nn->fh_key) {
+       if (!fh_key) {
                fh_key =3D kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
                if (!fh_key)
                        return -ENOMEM;
+               nn->fh_key =3D fh_key;
        }
-
        memcpy(fh_key, nla_data(attr), sizeof(siphash_key_t));
-       nn->fh_key =3D fh_key;
        return 0;
 }


Ben

