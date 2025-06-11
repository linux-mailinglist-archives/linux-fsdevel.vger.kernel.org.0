Return-Path: <linux-fsdevel+bounces-51328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8EEAD58CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 16:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E63168BAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 14:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20B327466;
	Wed, 11 Jun 2025 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OmzP+IMH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ltwZNhfH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED3F6FBF;
	Wed, 11 Jun 2025 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652292; cv=fail; b=NumXpYLW0mvdy9rAvDX1JvBkNCfklLmEdNbeWrv2ZSvG+yHC7w+kxPZNdlOl+Ku+3DjvtjkLwxp7dVfvOyAZq63G8IY6Xzd8E2M1jmFibDumNzmO8U/1ZX62XohUJVFUaX5yMIG1PrA1MOcS+BBY58uCqzPKNWu5H6ABeNC6pTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652292; c=relaxed/simple;
	bh=7qSMdE3B+lcUS1Bt+mAG49jplE8YnYFCVHwxh3nIl+o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fSDfHWGS9/yPDmDX3Hcto67ogvUIhM9LYy3JSzkod1lRcZ1669bd/UjFe+FXNemjytaZ9B3vB1Aecmis5s0ZSxH0T2jtl5gUfIt4y61PTz2luGzveUL1oESa0n9pHL8y/7W/5LWw101UTUtjZRXzAvvFh6MKx1Vx6oYPHDupnN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OmzP+IMH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ltwZNhfH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BE6LZt027976;
	Wed, 11 Jun 2025 14:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6SxlhwKzOu5i8n3YL8Qm5Urxr+xqSGfDzYdRGup9Lss=; b=
	OmzP+IMH/C0L8roYR6GQxFXTt7GgK6Tk6WOaoIPPUBInywi5Z2ublLUXxemD7wm0
	pEgyjGnw7EF/n1f+qHG0jdkQfK3MN2KLnC+N1lDhvB1J9ARbfVgZ3E2OnNPMdd0o
	o+Oq8O1nnnYt5gXdJjD/i8h6T1csVn5ypIcwig5Kruo+YTGQyYkolZPlwzeYGfNg
	DNSx/Praq4DvfMA4vyP///2Eds0OIy8DmEl73w+D9n2nlWlzIpZi1TfnHK3lJpLc
	VWEcPmeEBESJ0qjn+kQF3uBe1H8WUjI+V4ZfLDMK5p55Ouelx3HAR6aNpFQY0XNZ
	ElOqLB2OIuqi/nbcgFSBSg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474d1v7fgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 14:31:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55BDHVd6032031;
	Wed, 11 Jun 2025 14:31:25 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011021.outbound.protection.outlook.com [52.101.57.21])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bva8vnn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 14:31:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ub8FRq6bu3DSkcnu6hd9v+PwDXQeZr6G7K4TV7Bxhm80MsfumQpQL+gyotcT9C/5/Ek/OxvputGPZOxVtvH38+FvQyAH56TLLP+UgCSrcoKjjLqyLziKGpZYPGdSKSjWaOcmzLfTaqIF0/j5oumTM6WHl74ou914u9FDlAcZ04hOeqFYE/maC50cBz7hHs/gOYcYdmetWN1x8DB+y03qoqFgjJ8xQmAo2qSZnp3S7Yp6VCw7HgfAnF7t4ZNg5Wit2oZmE6L8IVroc8+H2GqCgaZorPPgZh7k8Zyw+WRh1FVPnMkDjX3R2eWsLSOLKUTMS3bylDkNn7GoPLcq4UKZKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SxlhwKzOu5i8n3YL8Qm5Urxr+xqSGfDzYdRGup9Lss=;
 b=CaA2F+qbAK+XshAsrXn2wz4jL86GccphtxvhAGaIy4fDWSaDPirBJRAp08QXvyT8M93Yh/OIn7mEMZxXz0Y6oZR5cvfa9oNZSFkC3eb03uFaitYn3RI2tFULyJ0tH9aRSfQ/VE80OOOhDAPXEFA9a2NwlHYQUOxLfZUosMo4dTwHxCCd+7NFNakHX8WfpB6dX+J7um09Mh8Trl7dPJnhjq/zieFhxaILB84qulb7pJqHO+JeasYrpGuhI0DlM2hQeybNb8OCpAlL3wQuUQ55GZiZAurSKRpJO+FPMgfDJK8t0EHxxWYFJORz3lB8xWMxPrFRAqzGy118d2k6nNNVHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SxlhwKzOu5i8n3YL8Qm5Urxr+xqSGfDzYdRGup9Lss=;
 b=ltwZNhfHkdI+KDL+LhTUdY0oG92oJ4UWP44RBz0Y2OVxaGZYJ7sZY31gmZUuTHcSL04zw8U9oBbyPk7z3pRO2eUClB20m2XdJsL8CbFytxBmwkO278hjfYZsSSguJ5fDzBRzFTOwBFp1V8VVhomaD5IutA02lAznwoqfwpRfLfI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH4PR10MB8148.namprd10.prod.outlook.com (2603:10b6:610:244::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Wed, 11 Jun
 2025 14:31:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 14:31:22 +0000
Message-ID: <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>
Date: Wed, 11 Jun 2025 10:31:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE
 for all IO
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-2-snitzer@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250610205737.63343-2-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR15CA0019.namprd15.prod.outlook.com
 (2603:10b6:610:51::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH4PR10MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d98ac10-705f-4d4b-68cd-08dda8f4a31f
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?azFVWkJsUEdtL201VFRRV1dIanNYTHQrWGE2WWpQWXpuK2V0OTNpTVg0Nnhw?=
 =?utf-8?B?YnIyK1hkbVFqQ0tpZFNrc3l3WHk5bERDYVpRbFV6SGQ3TU82VUVoMU81dFc1?=
 =?utf-8?B?aG84c1hDeWg3QUlQMG1TdDBYc3d6S05tVC9JY2FBRjRTU2FRMFJNY09tTFZq?=
 =?utf-8?B?cnVZWFZtN2V3eWl6eDRFcTduc1ZQa2ZhUDlGT09ib3VaWmZqSk5waE1CbC9F?=
 =?utf-8?B?NE9IdklpdUx6bllSNXlDc2ZNcmMxU0U5VlBvZVZjdExYQUlWa1dLUVdDUWlq?=
 =?utf-8?B?WTlvMmFSQ09qNldWS3RveUM0TXRYZ3FOQitLQzRveEtpSWJzb1VtSDNzZ2R0?=
 =?utf-8?B?NEFJMGhoOTE0eE9RcWdHWVB4SUJpT3hicmxVTzdKakwweXJVTDRrNG93UEFk?=
 =?utf-8?B?QjNLNHZKRmFUYWhWZVNZRG5wVkVFUDB5ZnRtT1VnTlBJYmF6ek5sODZyRWc4?=
 =?utf-8?B?Nk1STmhod3oraVBoZEhrUFJ4U2JZMEhOQkRjUXc4MjluN09zTXFkdGxCdHNF?=
 =?utf-8?B?VTNZMDRPU0tuYnRBakgyNG5GTWtMVS9paTZBSndJWDJodVcvSmdtbnNobkxQ?=
 =?utf-8?B?eFFRamhuUTV5ZkZJMTNrUTlIVi9aU2hBWGUycW91K095dVpGVFpuZC93dFNB?=
 =?utf-8?B?OHh0TGpqK2hMNDB2eTh4cUtvRWRPSlhGYkVIZUZxM1dWZ1RXY1ZTMnVnK1pk?=
 =?utf-8?B?ckVKZzlaVzZqZXFMWWxiV2N0SzBQMnpzK2huVTE3RTFMOHZPeG1tSVB5TUg2?=
 =?utf-8?B?dS9HRkdDVXh6QXRyM3hhRC9uM0dJZ2s3TlBwOUZIKzRnL1ZKMURQc015eWZh?=
 =?utf-8?B?WGtkNDVsTWJjRGtnM2JXNzVRMW1HOHN3SWt0aWhEdGVrb3BJV1RuQ1VvTUcx?=
 =?utf-8?B?eU5BYURFWUUxWUx0OWc2cEdwN3cwWGZnbVc5bXVIRXF5OEdIMlYrMmtCbjVq?=
 =?utf-8?B?L2M2ZHFaa0RGTmJSZHB4VnpyN3Z5U1Z0NVg5SmN5UmVlMlRvYlE0dmlVdU5X?=
 =?utf-8?B?UkcybWxhMEVtMTRZdjVNZVpVTWV4RmVHbks1UFo5TitUZURYNTBaQ3oxNGov?=
 =?utf-8?B?SVFQbnA5ait1VlpEZUVQTEM2RW5lL0JlT09ETzl5VVZNdTdHMVdZeEs0eDV2?=
 =?utf-8?B?Z1lyK3FFZVgrWjFUanRiZEV6bmRKanVGOTZ4RjZIQ1lWWktGK3R1YWtwbXFW?=
 =?utf-8?B?M2kzNHl3ZWptZkxqeTRiUWk1UzNJamErRzVGWDhkRmJjdGhZVXV2RTc5cVpS?=
 =?utf-8?B?NXk2QzhWRmU5cFp4UjBRY1NOc3U3WlJURnJlOE96Z1F0Y2h5cVFjcWVrcy9w?=
 =?utf-8?B?eDBDeEJ6Rk9jZTEvVnRobE9QcEVrelYrM01GdWRReWt6cG1ubmY2VFBiN1hP?=
 =?utf-8?B?SGRLTXdBM1VJYUVmQWh5TUh4VWdVY0h3djl2eTlRUDMxWWphdUlHbmppZ2lQ?=
 =?utf-8?B?c2NNV3dvbDBCeGlXNG5zOFdEanV3VnEvY3Y1eTlZWW9FYkxiTGVzdllkYktN?=
 =?utf-8?B?WkNPdlRUbTNGQ3VCZzNVekxzUk1yRkxEU3BGdEJYWWNxQXFwWDlkYXZQYWVn?=
 =?utf-8?B?L2hzN2xSV2JDNFh5RmJPSE5ibVJCMlJ6SFV1VmFJazN1NnVna3ZvbGYzZ05h?=
 =?utf-8?B?aTdiRDNYOFY4UFNiNDNaZFBxbHIzSkdOd0dVNWU3cEExK0Fnby9weUZjWHkz?=
 =?utf-8?B?ckJPSEdMc0F2a2JnZURHaWJoRHBWNEpPcWQ4dGZlUlVjQVBobzZEQ1c3ck5W?=
 =?utf-8?B?L0s1Tkk1OFAwY3cvT1VtaXNodkl0UDM0Y2tKWlVHcDBsZ1pCdkJvRnFBOGds?=
 =?utf-8?B?dHAwS1NYZnh0anBDQnVuMGhqMzNyRG1LQmhzbEsyd1BkZGxHYXJCYlVlRnJY?=
 =?utf-8?B?MFU5NkFnaGlvZTJIdWRKUmtlL1FHZ1JqZTJBSXdtK2tkOHdwRWkzRzNFbVQ1?=
 =?utf-8?Q?zwCdTm2Lpa8=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SnJLaGp3M1VxT1BldmlsZHFMTmRIRzQzNGlJWXd3YnFKRm82aDhXMk9yV1p3?=
 =?utf-8?B?bkd4bldMaTRzNXlkTkFvcHYzYXdHM1ZEVFAvOVd5c0FOdGN5U25qdGo2SU1h?=
 =?utf-8?B?bkJOYVFYZEFQekIrZVlDa0dWR3JBeW9IZUtEM2UyZlpyT3d5SGJuN0NkYmIv?=
 =?utf-8?B?VEpEbWlmenpRWlU4bDBpK3NGNXlNUXFaZ0g0UFZkNnZGZlprZHY4Q0ZrSEE2?=
 =?utf-8?B?NVh1YkYvWEpza1craWpNM3RxWDhiRitCbkV0dmZCNjRER3ZFanA2YldBdzZZ?=
 =?utf-8?B?eVRhVVB4Q1ZENk5QcTFuR2RzRW1DVjltbFJBWEFrTTZGVkYvTWdpSjFObi9t?=
 =?utf-8?B?TTJRUEN3SG5yd3RqRU1hNndVUjJpdkhKMDZTQks5Mm5md2pETmpha3cwSjg2?=
 =?utf-8?B?bjdVeXozNmxFaE4rVko2UWNsVlNVU0tPeWV2OVhFYTJ0WDQ3UENJbDIyOGFD?=
 =?utf-8?B?Tk5wQ0RPdXFFU2xvR0VrZDFEV2pLY2JQRmdIMFFnejZSM3Zia05FVFozUlZ5?=
 =?utf-8?B?NmxSSzdhRGd3c0c2R0xnSkNsL1hLd05XSVE0aFhpRllOdHphNkVyNXdEM3VY?=
 =?utf-8?B?SGR0YlhUWldSUGEwNDhqWjhMODBoS2p1NGdxWFFMRU1WMG9PSVNhdk0vWnFX?=
 =?utf-8?B?TEpRTktuWFQwWUMzQTY4WktQbERZOGJqdmZBRi94S1BqYjQ1Vm54blR6azNi?=
 =?utf-8?B?TGtuUG81N2JnQVNSZlByOGxDcjVxSXIwelArMG1zU1psWUVSUmx3Z0VKU3VY?=
 =?utf-8?B?bHM5cG93aGhHRGFCaUxPYVpzQjZIam5vOE9LK2lhRXNaN2hTdFVpSUQwbEty?=
 =?utf-8?B?WXkvR0VjdmhxMFFLUi84emNVSldRbTgrVDhRSzV5dUY0ZjlDeEIzWTFVcXRr?=
 =?utf-8?B?Mm1OczhPbS81dHJvYkNWR3A0T1hkR295SVZtaWRXYk1RTkxCWjVBejR4OUhE?=
 =?utf-8?B?UzFyU0ljZkVQMFV4dC85OXREM2U0d1NKVHNUZE5JdzNmN2lsNUNjNGRiV2pB?=
 =?utf-8?B?V0FGWVVmd0M0cDM2dkRaVFZBZ3FJcmxoYlB4K25adjBGajRrMU0vQVRtM3Bk?=
 =?utf-8?B?b3d6TldMTk9pWDcvNmtlUk43bE0wdTV1clZ0aWttMnQ4YTZzTVJGcVNJTndn?=
 =?utf-8?B?RHZiTy83a0paajVGdENScmlrVVZJRklwa3JLbUVGcmJ1Z0NYb2x6YUo4eERt?=
 =?utf-8?B?VDJrNWUrczYyWTJLQ1JEdmJ5WDk5OEJoTXY5U2Y1M0IxWnlsNGdINmhybGtw?=
 =?utf-8?B?cU9LNnNSSTBlOWxoT1VYbjlKQ2UraXRja2xMWCtueTNWc0N2Q0tvZG5xdFU0?=
 =?utf-8?B?cWlrQ3RSM0FRVTYxZEZISFdTVlFCdUo1a0h2ODQ4UFA1VTdQUFBVWlZUbk5Z?=
 =?utf-8?B?ZmUzOXZiSGhJOWE5QWNLRFlxSDI4ejZWQy9QWmNlUEhZayt6T2lFblNnSnZZ?=
 =?utf-8?B?TmVseDh3NHFFNkcrTEZnOWZNa01lQ0JvQlJCRWJtTFRDdVhNU3FkcE1RcmtX?=
 =?utf-8?B?SDJlTll1V1VUYndGT21yL2Nrcjc2MGxCRkZILzlJUHJ3d1FLby9jWG5EL0Vu?=
 =?utf-8?B?NFJtVW9aYVRDVVhscnRPdUx1bldJMDdJUk8rSEVPYUhHMjhLUTRVeFV5MjBp?=
 =?utf-8?B?VU5tbDVpRmcxSmZwK1hzU0hMenRSb1VoWHRXZDVPM3d3bk1hWUdkZ01KVUM1?=
 =?utf-8?B?MDgwQXU5dit1QTlMcHRKaWlrVnRUSEN1QUN3UTk1UGR0MWlxQklrYkIrZldn?=
 =?utf-8?B?Q001YzhuL1N2bTc1Yi9hdXJkOU03eklzbzBvQWdZdVNtNGhDTmt5RUhnZUhs?=
 =?utf-8?B?dWtHOHprRWk4VGJCeXFhc0xZaDloUlRHSTJvN2NXeDMwUkQ1clFDcS80Zksx?=
 =?utf-8?B?YXlZekFyTWp5VEZweFFKNTFGdmJYM0VWZU4xalpwbUlHRExzZTVRNXZmZDVz?=
 =?utf-8?B?cVlHTDVVWnN1NnNaUk1Fa0hhMTVDZytWcUdZQlB0dGxocnNNRm5aMXdLTVJi?=
 =?utf-8?B?T0hUSHZ1QnZxUVRHVmQ2WHc5T0hXN2JURnRnZHdmRWoyWGxzNVpST0FSa0xQ?=
 =?utf-8?B?aFh5ODFqSDN2bndGTy96eXMwMHhoSkFrTjhaV1FVYktHUjdDdTBVTHFhc0RW?=
 =?utf-8?Q?IcOqvVuw32L1GYQkL/h25jY2q?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Zp/+ARkixSIHbzHcGc1aB04ejWYvmaeVTNOIttM0kuS0mSRjBvvlsX12QHpLo9MWP6XXUCWz1nLEMgNXXq04382Pe8D4zVGsNYM4o9Bt/YaDA+DK561hK3occ/Smz/urlK6NHoW9ImX8pxsgB5yluHh8GghEgsf1kxYufZQ0ddIUwyMpzvwMoxujnCf9VrH5Fht3McQH1jttzKeE/wh4njNUO4eLXehieS+lqq4s9oomgkY9feu2d40hWJuy4YafUup1SQYQISOwIx0u8hgSRCOTC7Z0lhS5VaztWgPi6vzVjL/4uOTlhI4HEpzVk7foTFn7WWs6+1JLou75MlMuHSanQO0oxDpN49o2tAnQYSzQf+fzgn85SUH1/+NvH50z/EdjLCWTaQLkOM90K30HOr3gwnk0D6gL36oG3tA4wtVp0u6dDAot0eBzJeKm7Oet8X8z+5+7VvOjYwSaUDY2oCQPiKxQOHulpImwj7jqEU7rWT5cgw6BySQBs7KV2zsO0alVU8FGEfYlKvjfGFyQdYjA9eEQ8v4sKX73HEiBnf8++8+LHlD2GOfmmj4SnmaCKDS2I771Qbmjaik0jcT/HWrVZOSEQJF1IgwPN4Ux8fk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d98ac10-705f-4d4b-68cd-08dda8f4a31f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 14:31:22.0315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ul4gZKMDOAvYB9iTkvuMoEivLJSYZbVbTHdq8OW+fkE4wQ6iRXq6rZdHPjgbQdGGSpjzkXeOZc6ie/tBgSijfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506110121
X-Proofpoint-GUID: j2CNdzUh8pXHWKAqvwRmTSt_LrybTq63
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEyMSBTYWx0ZWRfXxt5di+h3NI/d rV4I0Xsc31E93tlx3YVMTAsQshujzFofXYdKKm1GClGN+TcbI0ZSvLbJfngGNucqGfkyUEhVulj mjW3FdTJ6ieMbPZxM33VrTPtf+QteROJc7sqtxdwOXYDmL7/JnHbGXr3k4aARxont6rnd+qJx5v
 DcG8Qd/N6adXoJro2kAsWk8AAk191d8IhpMUZCvl/QwryL2bwJ5k2VvpvuxhBjpx4/JwCV07odU qvO79vnmTGAaacck2zv6Ouhu7GBaTGDkjhnNQhktgn6wRlvavbycCWSMUZkS0oBrhj6kTF5J2em R2irpXbGJZJIiByIVfxlw4aidoqvKwNItQuwQN7uMEcL8r1VJLeasmWuE+B31nSamJsmLF9+yEF
 zW4ON8imgyD5YGOSS3cOFC4WuvYlkfrDGbbDGiSsJY9QSqFAsw5afWLQPcAQOuBM6V7Mg8/n
X-Proofpoint-ORIG-GUID: j2CNdzUh8pXHWKAqvwRmTSt_LrybTq63
X-Authority-Analysis: v=2.4 cv=d731yQjE c=1 sm=1 tr=0 ts=6849933e cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=TRtTYcYt5kwXhoch:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=lyn-4k0kedqPbjKrtdIA:9 a=QEXdDO2ut3YA:10

On 6/10/25 4:57 PM, Mike Snitzer wrote:
> Add 'enable-dontcache' to NFSD's debugfs interface so that: Any data
> read or written by NFSD will either not be cached (thanks to O_DIRECT)
> or will be removed from the page cache upon completion (DONTCACHE).

I thought we were going to do two switches: One for reads and one for
writes? I could be misremembering.

After all, you are describing two different facilities here: a form of
direct I/O for READs, and RWF_DONTCACHE for WRITEs (I think?).


> enable-dontcache is 0 by default.  It may be enabled with:
>   echo 1 > /sys/kernel/debug/nfsd/enable-dontcache
> 
> FOP_DONTCACHE must be advertised as supported by the underlying
> filesystem (e.g. XFS), otherwise if/when 'enable-dontcache' is 1
> all IO flagged with RWF_DONTCACHE will fail with -EOPNOTSUPP.



> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfsd/debugfs.c | 39 +++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/nfsd.h    |  1 +
>  fs/nfsd/vfs.c     | 12 +++++++++++-
>  3 files changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> index 84b0c8b559dc..8decdec60a8e 100644
> --- a/fs/nfsd/debugfs.c
> +++ b/fs/nfsd/debugfs.c
> @@ -32,6 +32,42 @@ static int nfsd_dsr_set(void *data, u64 val)
>  
>  DEFINE_DEBUGFS_ATTRIBUTE(nfsd_dsr_fops, nfsd_dsr_get, nfsd_dsr_set, "%llu\n");
>  
> +/*
> + * /sys/kernel/debug/nfsd/enable-dontcache
> + *
> + * Contents:
> + *   %0: NFS READ and WRITE are not allowed to use dontcache
> + *   %1: NFS READ and WRITE are allowed to use dontcache
> + *
> + * NFSD's dontcache support reserves the right to use O_DIRECT
> + * if it chooses (instead of dontcache's usual pagecache-based
> + * dropbehind semantics).
> + *
> + * The default value of this setting is zero (dontcache is
> + * disabled). This setting takes immediate effect for all NFS
> + * versions, all exports, and in all NFSD net namespaces.
> + */
> +
> +static int nfsd_dontcache_get(void *data, u64 *val)
> +{
> +	*val = nfsd_enable_dontcache ? 1 : 0;
> +	return 0;
> +}
> +
> +static int nfsd_dontcache_set(void *data, u64 val)
> +{
> +	if (val > 0) {
> +		/* Must first also disable-splice-read */
> +		nfsd_disable_splice_read = true;
> +		nfsd_enable_dontcache = true;
> +	} else
> +		nfsd_enable_dontcache = false;
> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(nfsd_dontcache_fops, nfsd_dontcache_get,
> +			 nfsd_dontcache_set, "%llu\n");
> +
>  void nfsd_debugfs_exit(void)
>  {
>  	debugfs_remove_recursive(nfsd_top_dir);
> @@ -44,4 +80,7 @@ void nfsd_debugfs_init(void)
>  
>  	debugfs_create_file("disable-splice-read", S_IWUSR | S_IRUGO,
>  			    nfsd_top_dir, NULL, &nfsd_dsr_fops);
> +
> +	debugfs_create_file("enable-dontcache", S_IWUSR | S_IRUGO,
> +			    nfsd_top_dir, NULL, &nfsd_dontcache_fops);
>  }
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 1bfd0b4e9af7..00546547eae6 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -155,6 +155,7 @@ static inline void nfsd_debugfs_exit(void) {}
>  #endif
>  
>  extern bool nfsd_disable_splice_read __read_mostly;
> +extern bool nfsd_enable_dontcache __read_mostly;
>  
>  extern int nfsd_max_blksize;
>  
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 7d94fae1dee8..bba3e6f4f56b 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -49,6 +49,7 @@
>  #define NFSDDBG_FACILITY		NFSDDBG_FILEOP
>  
>  bool nfsd_disable_splice_read __read_mostly;
> +bool nfsd_enable_dontcache __read_mostly;
>  
>  /**
>   * nfserrno - Map Linux errnos to NFS errnos
> @@ -1086,6 +1087,7 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	unsigned long v, total;
>  	struct iov_iter iter;
>  	loff_t ppos = offset;
> +	rwf_t flags = 0;
>  	ssize_t host_err;
>  	size_t len;
>  
> @@ -1103,7 +1105,11 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  
>  	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
>  	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
> -	host_err = vfs_iter_read(file, &iter, &ppos, 0);
> +
> +	if (nfsd_enable_dontcache)
> +		flags |= RWF_DONTCACHE;

Two things:

- Maybe NFSD should record whether the file system is DONTCACHE-enabled
in @fhp or in the export it is associated with, and then check that
setting here before asserting RWF_DONTCACHE

- I thought we were going with O_DIRECT for READs.


> +
> +	host_err = vfs_iter_read(file, &iter, &ppos, flags);
>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
>  }
>  
> @@ -1209,6 +1215,10 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  
>  	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
>  	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> +
> +	if (nfsd_enable_dontcache)
> +		flags |= RWF_DONTCACHE;
> +
>  	since = READ_ONCE(file->f_wb_err);
>  	if (verf)
>  		nfsd_copy_write_verifier(verf, nn);


-- 
Chuck Lever

