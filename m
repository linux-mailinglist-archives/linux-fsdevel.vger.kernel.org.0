Return-Path: <linux-fsdevel+bounces-42144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A025DA3D153
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 07:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7262A177963
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 06:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C1D1632DF;
	Thu, 20 Feb 2025 06:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="VDccoL5S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C981E1DE4EF
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 06:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740032513; cv=fail; b=E60VZJ12+Mrnc9nirz3fAphrrQG7HlexKpH3hJMCFyDbitP4aMKKnsJjukEYIugj2EhXnHfI/aAodcDIT/L2px/y/XS7wHQ3JtHikbvYQcmcvCiRWeLs0CLExrKrhvgHHMGRlScfq5QiI/ceSvRddkLMcQwyKe7aYcOwiYlcY3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740032513; c=relaxed/simple;
	bh=ax0J5AxhbmGiFRa6ac4ODMJSHs0ZdHt/+TQvKLKFpNA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qj40wXafmzVMvTSQ1tRdyGEBSPtd11aGu+lc11fyNsOTMtkyf1IAWa0Dv1Gw/mgiOSRAz3QQ2aR/bCkxMznIMtc3CplV42x7/WM90Ze8QeGP1nUAkaUAShfl5Uvf3YTILrSpkBH/aWoRpUR871WF+PSrmfGpW47WzMuBnWhon+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=VDccoL5S; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K5a9t9003723;
	Thu, 20 Feb 2025 06:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=ax0J5AxhbmGiFRa6ac4ODMJSHs0Zd
	Ht/+TQvKLKFpNA=; b=VDccoL5Skfyfva0Z0BP8HJFGBale3INBJyFDvNLyJoXbF
	bdl0NrXvvbXfjawbP6h/sQBM81MlMj5jxyhx/HhA71ljRtMR7LtnD76mYuZOPfHY
	K6XqeGjX1oyeTpMfDYBGxrJ+2SmMW9u5o3T8HtVc+q/R11tr0g1kym62WYlq1iKe
	1ILjsYwCGl3VaBQsu1wYwonklSYAXoYkeKaJDA4jBKCJjh+lAmfYdfYFSqW6K7DV
	SazqgNgPh6e2lm3Ww0F/5Cg5P508qZRj3WCpPxSrAf5EmpqjWIFGd0CWliLfKqww
	91x6gC1Qg1lhdlsidkNZqPltkVC74CYUkHV3K0qQA==
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sg2apc01lp2104.outbound.protection.outlook.com [104.47.26.104])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 44vyyk1fkn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 06:21:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q20g2oYnKOMVwR/XgueYab+gckWGdbxJZqDfiFr4FQ9nUko1dFgVIE4B9OigdWYupqPw+DF7gw/89nMsn4m0/WYAHfvXGUSSvu3g7sNXU7Wkr5u0lRX2a4cW2ybK6VdZ0KWjSWuhbBKdbMyBkWzhF/znw+V37z7vPI2MRKCoJai3IFyKYDK0RlrwC5IC2KZVM0CQqnovRq6y34+Fweril7Je1iLX7jAQOS6ACgAcH49KBr7+UJeOSXdQkCCBOzASfDme7PokkSBKxIRMyRwxX9X9EIfhmRV6hM2/NwZigwZXDQeOp1B0JrlqWKh/yDJfxhvV/ENeOl4Dpua3ez2Jlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ax0J5AxhbmGiFRa6ac4ODMJSHs0ZdHt/+TQvKLKFpNA=;
 b=WozMHH7Wja127cvmcbYlbA1zJcXYbyoD0PCqfZ8pdAYKUeX3gof9jOYvgmiaT8xLkhzm3ew/DQDM5Gd2sNOs0K+JUGvTeTj7tFgsLFoOuGKO4d8E+qzbzQteJeBvMqNobjLf8KdjYbAPUKtUX2XQ4Ux2PFJgptu+7NCaKGO/yBEyBaVZCpIz6Ip0fj6cF7O+ih6i9FyHaogBmSpwfgSnRrSTtdWArWDws8Fq8ihpGPX1wrICSByeHDX4QAPvF4GDBJhsNQSvJgWBP90RXW63a/zXsAjC6omniQ0QLIB5FvIeu5IR1IkrYE8h0WCyqnPoNPvrCV7p24xS2xrXjyyt7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR04MB6782.apcprd04.prod.outlook.com (2603:1096:820:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 06:21:25 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 06:21:25 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v1] exfat: make flag mount options unsetable via negative
 param
Thread-Topic: [PATCH v1] exfat: make flag mount options unsetable via negative
 param
Thread-Index: AduDXqgd/Q/wXuhSS16cSAbgmlBVEg==
Date: Thu, 20 Feb 2025 06:21:25 +0000
Message-ID:
 <PUZPR04MB631620CA02014B98FD3A565681C42@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR04MB6782:EE_
x-ms-office365-filtering-correlation-id: 4e7784f3-2b40-4ea2-1a0d-08dd5176cddc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZUNDMHZGR0s1dCs4UWIwcDM5OVh2WU9UQklzT0ZadmJoamtzOGhXUEg5WFFn?=
 =?utf-8?B?SldGck0yVzhZRkNYUEFlbGV2cHY0KzkwSC9zOTVGOXEvVG9FTnZhSGlRZUJT?=
 =?utf-8?B?Mm8rc1l2UnQ2RjBlMGF6VDhOcGZpbG9HQkZmdkozSFNya0c0QTBRM3FDN1VU?=
 =?utf-8?B?dkM1SzNrcHhWTWhoR29uTGJMWGVvdXJtMHl3MUI4a2lYZUsraE9nZmtMNmph?=
 =?utf-8?B?VlBrSVR6dWt4Y2o3dXF2NElkbzVaUzAwOEVEOEErYmdQV1VueWF6MDVnbHRz?=
 =?utf-8?B?ekZsZGwwMWVVR2lHQmRSWWxCZnQyaktMb3FIS3A2T3g2Z2JDdG1WdFlvczZm?=
 =?utf-8?B?TmpkamxCZE8wdmVRdU9ubnh0QTE5bnhMN3pOMnAzY043SUZyYUloZ29NYWJG?=
 =?utf-8?B?eW9oa1RSeVpkcW1yNjMrLzlmSEJFR205WGdBZE1EUU9JR2pWOEMrZVFpSE5L?=
 =?utf-8?B?Y3NqU2NNTlF3VnM4QmdvdzlPMC9uaU4zbnpEOUlTOEwwR3ZVVEtMV3dOYUFi?=
 =?utf-8?B?OGNmM0RteS85VkVmcmdRS1NFY2hvQW0xRUZQQ1JjOFlQVVNUVGNSSmxQOGRU?=
 =?utf-8?B?Q0orUUNtTEVpZGpVeUxEUmI3ZEIraXIzMUgyY0pxM0owQ1NOcDQ4bHQyMkt2?=
 =?utf-8?B?d0hTN2pPMjJXTzBJa25UcWRlOXBDTkRJdkg1MUNjQTJaZENOQnFISjlsK0xE?=
 =?utf-8?B?dTIxVDAvYVZWSlRYNUhTQ1EveFRtRmhEcjNZU1VxUHpFQ04wbmRqeUFIcWlN?=
 =?utf-8?B?TUcvdENUWXYybWNDNmpET2dpaFRUUURPOXZLWkFpU1czZ3lvR2l1RHdsNWtF?=
 =?utf-8?B?ZmFCWmo5SURmVzByRm8vNTRhU2UvajlEeS9HckpPNDdqWE9MMGFNVUhYREJL?=
 =?utf-8?B?dEZ3N3lCWmk4OFFac1hHeHdiOTFmeFU1eFJ4bWRjS29HaDg2MURidlZURndl?=
 =?utf-8?B?dDlSRUwwL2Npb09KMTlzcHFFbHNTN3JISm5VWmFMY1hPaUNYMmRhbEdOSURq?=
 =?utf-8?B?U2pMWk5NYlQwUHZxaFMrSFVDbzh2ZzhiS3BNMUJCdDdvaTFZeHFIY3RKaTd0?=
 =?utf-8?B?cmRKNEhqWmlOUnVCLzgxM1ozQlg3WCtySTJVUE9tbEdUOE8vYWxEZEFoTXhT?=
 =?utf-8?B?SHA5UDYwaThqMUJrRm1qdlU0WTdDMzFwYXhPSFN5Q0ZnL3NWMzJmTkpLZHFr?=
 =?utf-8?B?eHJ2K1hVTkFQUDIxUnFpa3JlTjZiTFFBeUtsZWhvZVJuVkVERUhSMThkSDNE?=
 =?utf-8?B?b2dTL3pvLzRoQ0RBZ3J1Y3BuSUtSTEJ6RUlqMUttUk1MZ1ZaN1o3d0dQa2Vj?=
 =?utf-8?B?T0VHUE1BcGdYdmpVTEE4YkpRL0xCcXh1NVg2bEN2SXBLd2I0WDFGMjFVTGlO?=
 =?utf-8?B?cUdQOCtIU0FybW1SV1FCR1BobUw0R3hyNFFpRW9ISitpMHRnTGx0NlcyeHRl?=
 =?utf-8?B?SUt2cUNmUDFzUmE0LzJXcEd0NlZ2NDNnQzRjSTRWRlJmeGR0d2dyOTFYY0hP?=
 =?utf-8?B?Q3NkYmhnNjFrVmljNHpocGpFSUdqdEF2aFNlOTE4WVorOGllbFJSaDJadjdC?=
 =?utf-8?B?Q01INmFUN09XcWx5bFNQbmVLdURwc01UMG5SS0E0RGt6UkREbjQva1cvcWF2?=
 =?utf-8?B?UTZDQTFlNDZtS1VFNS9ydjlra0ZzeEhvQXpNZXpXWDJUWk9zcHcyYW1DcGNa?=
 =?utf-8?B?TVRWTW9kSnY0M1RwUmI2M0QzaGVaSWs1REhpS0ppRDNqbzJQak5qN2krWmJr?=
 =?utf-8?B?V2hpcXkwUUpmQ0s1ZEpNYkNoS203aXhPUFQ1NCsrZWNvbWI3ZmJpd0h3S01O?=
 =?utf-8?B?RkkxcVJJVFdFbXhETUVRaENQYVc4elFSbEN3Q1NqdnNhNStlc0s5WkQxak1h?=
 =?utf-8?B?V0FOcHNZTXBPS214T3ZiNkJuSDFzdUtCRHc5QzltK2N5amNiZkUxYlY5dGhP?=
 =?utf-8?Q?LQ8v/teSFlj7eq6HjA/G6RFNmo9xAHLL?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RVVWYlROSHlmUUNGZG5SdlB0RUdqREdRM092ak5KMUJMcXRhUFZCOUR6cXhx?=
 =?utf-8?B?RG1FQW5ZRU5yRENSNnZXZ1E3cTZETXIrcjR6WkNEUE5NenpZZVk3aS9RcG8r?=
 =?utf-8?B?UW1FUEl4aWJMcnV1dWhIbk9pM0MrTkRwL2hINTcrMXVFY1Z1TytxZkhuc2xE?=
 =?utf-8?B?NERQemNNaXRqQlBhSVI2RUVIY0l6eXk4YmI0dWxZUTRzWFlkdzZSSzdRVTg2?=
 =?utf-8?B?QjduUzQ1UitUN3Y4R01CTXErM3NjWTA2UWRGbUdIak5aVXA0UGgvTWU1NFBm?=
 =?utf-8?B?UGNHdk4xYm5qcVo4K20vdkcvaStRcFZjR2dBSnFnaUpzVHVTTmJXaEdEb2xn?=
 =?utf-8?B?ZkltQmlkZ1BaMmVrSkZWeEVOQWExY0dhVDU4aUlJeFlxcWZBejlpNUFVeTU5?=
 =?utf-8?B?MXl6dmJtRmJHcTVRbHBuVjF3M014YnljajlJOHR2L3BTK2M3OHlXVWh0RmZ2?=
 =?utf-8?B?cWJpS3ZBTVVtYU5KTmJudjNESU9UU3lWbnN4bGJTS2VZT2RmNkhJVEljNEZk?=
 =?utf-8?B?Skd4OHR4Uk1jS0M5Nm5zVkd2TmwwVlNkeGlGQng4dDZ3VEx2TUFIeWhnNTJF?=
 =?utf-8?B?QUVYQWsyRkZzYmhXZmJqaTJXSmdwM245emNPREpNUUZTNy9tdXFsQ2I4cVZE?=
 =?utf-8?B?WTlYUlpVU3pwaTYxeG9wNFlsdmVhUml4K2FkQVFLT2RiMHFoS0Z4SFNNZ3lK?=
 =?utf-8?B?YTVoRHk0ZytGR3o2QWhjalBzOG9IeGJPckZHVHMxS09lbjc1ZW1DOGhheDNp?=
 =?utf-8?B?VU5ULzZlbkhCZnM1ZVZqcGUwY1lwMnZsNjVzQi8zRUc3ZkppNkJjbGJoSnNl?=
 =?utf-8?B?TkdZREhab0dCc2VncEVrVVZjRTRPSXNPZStRTzdPUm5hcUlzTzdaRkxyUXB0?=
 =?utf-8?B?SDQ2UUY1c1VCMm1kcEUzMlZaWlpyQU1tUkIyZG5XNTN0Qkp4S2oraEdRVExk?=
 =?utf-8?B?N0R0dDdpTGJkdEp3anVjWXdMN0YyQ2pYUjdsZktrYVFvOTRsV3VOc1V5Rkpl?=
 =?utf-8?B?RHBEU08yWDdJQ3o0ODREa3pUQ0ZKVStBTjZVR1ZmaXByZEUrMno5VERyOGFl?=
 =?utf-8?B?Sit2K0xTTU9sY2swZUthRENPb0dCKzFnTndZU2YzMjl2VHBZOWc1S2JQYVhC?=
 =?utf-8?B?Nm5yV3ZrdVkwWEFFWXZKSFRZN0IrNGVSVGE3RHJYQjNHQ0ZmMUdSTnM4WkdB?=
 =?utf-8?B?NWlLRnFZVWdmUExCRnQrSXNsd21UMGI5RmRQWGI1cG5IZHpBZ1lLSERqSGw1?=
 =?utf-8?B?ZDg0dFpwU1ZMd256QlV5bGEvMDdvaXJWUXREdHlXM3NKalREWWJhWkpmNGpR?=
 =?utf-8?B?aExDZjVIdVFUTkdYNnVibWtTNVhCTHBUTkRBdThkMFBhaEtaVzVBR2dMRlNt?=
 =?utf-8?B?M25lZzRpSFlVOWR4SlBlMEw0T0lVVFN4b1hTNkdsTCt1ZG1DS0pudGdNLzB3?=
 =?utf-8?B?cDdOZVErWXJQNzk4VUtVaktTdXZSS0dUWkNVcUk2SHR1TTR1UlB1SlFqRFNv?=
 =?utf-8?B?L3BsUFowcVppd0QvTHhTWnp1T2h5L2I1c3FoNDRVd3F2K2JCQ0dzNWMyRHhu?=
 =?utf-8?B?NnlOTXljQllDOUhzT01wZmNrS3ZNenVXeTJMU2NFc0lkb1haeXVHeE1WbFVh?=
 =?utf-8?B?MHhkeEY0Yk9iUkhwOHRpNlpyQno5TzYvenMweVJhSWo5S1R1NnpZMkhrcWRh?=
 =?utf-8?B?VWZNYVJ1VXB2NGRvdlViU2RiTWhsWCttU3JaY29lZDQxRkJxcitSeThDLy94?=
 =?utf-8?B?NS9wdzVpMmpNZ1p0aHdUWmdLQk1mSWgrZWs3WDUrN0M0bGtzNFUxbGdUNnBk?=
 =?utf-8?B?blk3Wm80aE9EaFJZYkRYb3l2cFYwQzEwSTA4TUJnRTIvN3ptWmdOd082NFpL?=
 =?utf-8?B?bFhVcmlHeHVyNmN3QTFXQWNrUnIwYlJNaTN2UWQ0SjAyT3BrVHBUMDluT1pL?=
 =?utf-8?B?eHlRTzEyWGV0V3F3QkdxT3JUVmtCakJET2hpZGhNOFBFUlMwWHBoNVB6K21L?=
 =?utf-8?B?RitIZ2NKdjRyK1RxMWVQWlhsc3dYOFpHWFdwT3h6c3kxSlRwdVNzb3BEZmdJ?=
 =?utf-8?B?MTFvRnRJOG02emRWR2s0VnRlQVk5WDFVSjZzQ2R0RTdYdG1OZXBsVXQyRnkr?=
 =?utf-8?Q?YA1IM9e0KzHEqp/n6FrA2dd5g?=
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
	dDvU2XPZmqCjX4Toxb541rK3XXxzbc5UdBr7cKQSBMU4NcLi7FCbmY65UygzRCFcwXbiF4wQMkI5Qtl4JVK0VA/9KmNGjv2wYwl2PDudqJ19ShvKe9j1hIadoXRynxFz+YPJu/pzFY89fq7aEoKcxSfpeunD/kkiJVm4x0iqeCGUm575updaHBAw8FfWctQfcr2F1DzOa0akwmMpHvvE/eayh9yZ85fhMFZV+BNf8UkaXMV1a4UUGnp/4vBFFWuqsu2GKz3bknXSb9Zv6tzVBkr8OIZoyUpbDX3yIVIQiWaKZaQlWctmvM08Ch4xKLyZh4xPWkD93Pe3qAioffWTQ39xHEEK76tDRikhy4D63aCeiCb8lqubZIDKRHfPuQK6z1lHGgTK5A3QBdGd8P2PRRAYR4GxRKO0kiVQqvdSA77s2wDqaejUKlvE4wmQaEyKDUUadIKjuBNLX8SuUf7xGxkSABdMQiy6+jPhkgFQsXD/obT11+QBm/Bq2J3c3obDtWDpFuh31VjHVAPIvBnE1ltGPNTP6TzHwu3o15Izim4/LpdOb4t1OPXH+zevLlEbXag6T+7MKxD/J/7G4NXs8XsHsKBXPRYumstPTpIeY6kvorti3d6JKI5vgm1hFxm/
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7784f3-2b40-4ea2-1a0d-08dd5176cddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 06:21:25.7201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1njOKbHY1WlpMJWiKq6tayMFhn0AcB7kANMZs+TkAYStJB4MfWCwlcwY7P5f8no8yud1ErP/8xvLje0AgnAw4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB6782
X-Proofpoint-ORIG-GUID: qrxfDxCtevjsnY3rVCVOrIXv21fJVzaV
X-Proofpoint-GUID: qrxfDxCtevjsnY3rVCVOrIXv21fJVzaV
X-Sony-Outbound-GUID: qrxfDxCtevjsnY3rVCVOrIXv21fJVzaV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_02,2025-02-20_02,2024-11-22_01

VGhlICdmc3BhcmFtX2ZsYWcnIHR5cGUgbW91bnQgb3B0aW9ucyBjYW4gbm90IHVuc2V0IHdoZW4g
cmVtb3VudGluZy4NCkZvciBleGFtcGxlLCBpZiBhIHVzZXIgbW91bnRzIGEgZGV2aWNlIHdpdGgg
dGhlICdkaXNjYXJkJyBvcHRpb24sIHRoZQ0KdXNlciBjYW5ub3QgdW5zZXQgaXQgdmlhIHJlbW91
bnQsIGJ1dCBjYW4gb25seSB1bm1vdW50IHRoZSBkZXZpY2UgYW5kDQp0aGVuIG1vdW50IGl0IGFn
YWluLiBUaGlzIGlzIGluY29udmVuaWVudCBmb3IgdXNlcnMuDQoNClRoaXMgY29tbWl0IGNoYW5n
ZXMgdGhlIHR5cGUgb2YgdGhlIDQgbW91bnQgb3B0aW9ucyhrZWVwX2xhc3RfZG90cywNCmRpc2Nh
cmQsIHN5c190eiBhbmQgemVyb19zaXplX2RpcikgdG8gJ2ZzcGFyYW1fZmxhZ19ubycsIG1ha2Vz
IHRoZW0NCnVuc2V0YWJsZSB2aWEgbmVnYXRpdmUgcGFyYW0gd2hlbiByZW1vdW50aW5nLg0KDQpT
aWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+DQotLS0NCiBm
cy9leGZhdC9zdXBlci5jIHwgMTYgKysrKysrKystLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA4
IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9mcy9leGZhdC9z
dXBlci5jIGIvZnMvZXhmYXQvc3VwZXIuYw0KaW5kZXggNmEyMzUyM2IxMjc2Li5mMDkwZjZmZDhm
ZTIgMTAwNjQ0DQotLS0gYS9mcy9leGZhdC9zdXBlci5jDQorKysgYi9mcy9leGZhdC9zdXBlci5j
DQpAQCAtMjYzLDExICsyNjMsMTEgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBmc19wYXJhbWV0ZXJf
c3BlYyBleGZhdF9wYXJhbWV0ZXJzW10gPSB7DQogCWZzcGFyYW1fdTMyb2N0KCJhbGxvd191dGlt
ZSIsCQlPcHRfYWxsb3dfdXRpbWUpLA0KIAlmc3BhcmFtX3N0cmluZygiaW9jaGFyc2V0IiwJCU9w
dF9jaGFyc2V0KSwNCiAJZnNwYXJhbV9lbnVtKCJlcnJvcnMiLAkJCU9wdF9lcnJvcnMsIGV4ZmF0
X3BhcmFtX2VudW1zKSwNCi0JZnNwYXJhbV9mbGFnKCJkaXNjYXJkIiwJCQlPcHRfZGlzY2FyZCks
DQotCWZzcGFyYW1fZmxhZygia2VlcF9sYXN0X2RvdHMiLAkJT3B0X2tlZXBfbGFzdF9kb3RzKSwN
Ci0JZnNwYXJhbV9mbGFnKCJzeXNfdHoiLAkJCU9wdF9zeXNfdHopLA0KKwlmc3BhcmFtX2ZsYWdf
bm8oImRpc2NhcmQiLAkJT3B0X2Rpc2NhcmQpLA0KKwlmc3BhcmFtX2ZsYWdfbm8oImtlZXBfbGFz
dF9kb3RzIiwJT3B0X2tlZXBfbGFzdF9kb3RzKSwNCisJZnNwYXJhbV9mbGFnX25vKCJzeXNfdHoi
LAkJT3B0X3N5c190eiksDQogCWZzcGFyYW1fczMyKCJ0aW1lX29mZnNldCIsCQlPcHRfdGltZV9v
ZmZzZXQpLA0KLQlmc3BhcmFtX2ZsYWcoInplcm9fc2l6ZV9kaXIiLAkJT3B0X3plcm9fc2l6ZV9k
aXIpLA0KKwlmc3BhcmFtX2ZsYWdfbm8oInplcm9fc2l6ZV9kaXIiLAlPcHRfemVyb19zaXplX2Rp
ciksDQogCV9fZnNwYXJhbShOVUxMLCAidXRmOCIsCQkJT3B0X3V0ZjgsIGZzX3BhcmFtX2RlcHJl
Y2F0ZWQsDQogCQkgIE5VTEwpLA0KIAlfX2ZzcGFyYW0oTlVMTCwgImRlYnVnIiwJCU9wdF9kZWJ1
ZywgZnNfcGFyYW1fZGVwcmVjYXRlZCwNCkBAIC0zMTksMTMgKzMxOSwxMyBAQCBzdGF0aWMgaW50
IGV4ZmF0X3BhcnNlX3BhcmFtKHN0cnVjdCBmc19jb250ZXh0ICpmYywgc3RydWN0IGZzX3BhcmFt
ZXRlciAqcGFyYW0pDQogCQlvcHRzLT5lcnJvcnMgPSByZXN1bHQudWludF8zMjsNCiAJCWJyZWFr
Ow0KIAljYXNlIE9wdF9kaXNjYXJkOg0KLQkJb3B0cy0+ZGlzY2FyZCA9IDE7DQorCQlvcHRzLT5k
aXNjYXJkID0gIXJlc3VsdC5uZWdhdGVkOw0KIAkJYnJlYWs7DQogCWNhc2UgT3B0X2tlZXBfbGFz
dF9kb3RzOg0KLQkJb3B0cy0+a2VlcF9sYXN0X2RvdHMgPSAxOw0KKwkJb3B0cy0+a2VlcF9sYXN0
X2RvdHMgPSAhcmVzdWx0Lm5lZ2F0ZWQ7DQogCQlicmVhazsNCiAJY2FzZSBPcHRfc3lzX3R6Og0K
LQkJb3B0cy0+c3lzX3R6ID0gMTsNCisJCW9wdHMtPnN5c190eiA9ICFyZXN1bHQubmVnYXRlZDsN
CiAJCWJyZWFrOw0KIAljYXNlIE9wdF90aW1lX29mZnNldDoNCiAJCS8qDQpAQCAtMzM3LDcgKzMz
Nyw3IEBAIHN0YXRpYyBpbnQgZXhmYXRfcGFyc2VfcGFyYW0oc3RydWN0IGZzX2NvbnRleHQgKmZj
LCBzdHJ1Y3QgZnNfcGFyYW1ldGVyICpwYXJhbSkNCiAJCW9wdHMtPnRpbWVfb2Zmc2V0ID0gcmVz
dWx0LmludF8zMjsNCiAJCWJyZWFrOw0KIAljYXNlIE9wdF96ZXJvX3NpemVfZGlyOg0KLQkJb3B0
cy0+emVyb19zaXplX2RpciA9IHRydWU7DQorCQlvcHRzLT56ZXJvX3NpemVfZGlyID0gIXJlc3Vs
dC5uZWdhdGVkOw0KIAkJYnJlYWs7DQogCWNhc2UgT3B0X3V0Zjg6DQogCWNhc2UgT3B0X2RlYnVn
Og0KLS0gDQoyLjQzLjANCg0K

