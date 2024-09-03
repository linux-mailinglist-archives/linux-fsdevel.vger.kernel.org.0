Return-Path: <linux-fsdevel+bounces-28444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A895D96A503
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 19:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DED90B257A5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 17:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7375418C921;
	Tue,  3 Sep 2024 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OLroUNyD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bdC0CqnT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1386118BC29;
	Tue,  3 Sep 2024 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725383252; cv=fail; b=sHNnd3sRumIY6Tm29b9GVpxw56JUXDKhHcUxAD0ocJqAxtcS/0qjGtmknaYy5gHd3s7P4JcIg1JLpTANYjwwEA1ZPJb5TNJoDlZlB7T++E6NaDd/fS6ZZFb4+pSJd+3WMj3gNU3O1nJM2rF5cOzvDzCyx7Ceznu74l80rjEhkOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725383252; c=relaxed/simple;
	bh=wFsKdRmrR1TMW2vbE7ZuxdYeq5JcgUCbnX12ijzxRmc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uSItAbreiEueUADVpmPzsJyfLd59P4tJjAeuEG+ZlG9OstjZykmillIWmjzY4bUPiiewtrIIe0JTOtxHv6vTgRCXXXK/Vv33LcdhsPG0SJJX4Rw5dBx1hcFF+X6XhKAA2IE424SCEPvFGem440YekX8mCcq1hNKZxR7a3OzOSfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OLroUNyD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bdC0CqnT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483Gu3rq005813;
	Tue, 3 Sep 2024 17:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=wFsKdRmrR1TMW2vbE7ZuxdYeq5JcgUCbnX12ijzxR
	mc=; b=OLroUNyDjIMYx63+KxmfCrhRVQXGPkaJgSbGGMIMcO2Dr/X59W/3nBtO8
	4bblCCiTtCC2ONEdp+ARZK48tb4UqXO0hCAA6YXVqIBD7MGjHlbF53Yh4w8wqMm+
	iA6tmAul5Z3dhR8GveauZDnvb5wOLM63tHktsME3TWtaCbqhJ0s2seihp7JBh0Ru
	BPsTCL7ZNn/3H+svBKnLEG0zXNp7bzNWK3RoU+pbVVFjdJVsqtL44A1qX5yhrpH3
	bDJ5M5DwTh+okEpTq00u/OM+IJpnjA3IdHJxZUhrr81pZrQh/s3aDxZC7LAZAFpG
	0yKlRgsBs3uK93MIDQ3KH/nDb1tDA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dwndhbek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 17:07:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 483FhAmt018435;
	Tue, 3 Sep 2024 17:07:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmf0h3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 17:07:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzwAS/0nd/OyKgzywW7SrVJBNtiiuA4JLrPbjPTskT24aGGegcRqeKbE6Do3+NXRS2ZBb7pHK2WkyxHnunBvsfnE0xYNYUtBdpK29+mOpbOTjCTgqmxbX1BVdN9ZssgW1myxfzQTIdeX8iz17AGzvc3yF2dNyjomQixPpwUlYZO/QNmvHsWfhv9jMrbSnly0U3bLwx5pPONY6toTJMDARO533g4wu6ShvR7LJXtVX9loNfPqxa1hj6TE8zrEnSIncsKB+nCS+LWhh7WM8DADVK/j81kEbuTKM3KMcUWYaWPv9YdGG/++UDiw0xvpntl0okjx0GCOkW5ZxXgbdUR9PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFsKdRmrR1TMW2vbE7ZuxdYeq5JcgUCbnX12ijzxRmc=;
 b=Vo+ZXBx1Xs9FO+JfM96t3hVZitXVEYuzW9Of3aBuR3yjZASdwAlXZPydXT+UZ19vtsQ+w7psn7McZXCtagtCPdkmQdFZo6m9DLQXNO8a7CjxGCGkONRaec0xqzF6Wrh2WVzFzK1XNex3TG7749g2e/if9+iN89nbeVnZeilhRhvtfLAlx0jBqfHM+6jzbcm5Nu3wNEKDaD9xIXu1iGe781FLwyZDZnc00vTHaEj2ledrWRka3t0BydFIRl7vnnzoBMyvGN+w2vi7KXn/4ZTwAJ1AQLE94p5DhYoPEdM/+K8lVRZKp3a5/3sX9mdnz3u4KrS76xl+RhewQJkBNAg1hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFsKdRmrR1TMW2vbE7ZuxdYeq5JcgUCbnX12ijzxRmc=;
 b=bdC0CqnT3lYYZIHfTpn5aBRxmIB61csugPIL/6GEJuyVDlGWmctrzp/+XzBSrSv0YaFUiN7323Ox3aae/CVCUiQdOtETrU1vjzWKRBw5Nsuv2ed0ZhsuQ2fGDv9tfXwjVfsva/DSMGlNTjq9+AzWlFRJrk6vo6+KcNgvBrmnB04=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6602.namprd10.prod.outlook.com (2603:10b6:510:206::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 17:07:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.007; Tue, 3 Sep 2024
 17:07:17 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
CC: Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond
 Myklebust <trondmy@hammerspace.com>, Neil Brown <neilb@suse.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v15 16/26] nfsd: add LOCALIO support
Thread-Topic: [PATCH v15 16/26] nfsd: add LOCALIO support
Thread-Index:
 AQHa+/Z8NjJpiHCGJkyIBxPv6nO2sLJGJLQAgAABzwCAAAV7gIAABX6AgAACqoCAAAhmAIAAAuSAgAAQCwA=
Date: Tue, 3 Sep 2024 17:07:17 +0000
Message-ID: <E38F2D04-50A4-441E-8410-283F42B5C315@oracle.com>
References: <20240831223755.8569-1-snitzer@kernel.org>
 <20240831223755.8569-17-snitzer@kernel.org>
 <ZtceWJE5mJ9ayf2y@tissot.1015granger.net>
 <cd02bbdc0059afaff52d0aab1da0ecf91d101a0a.camel@kernel.org>
 <ZtckdSIT6a3N-VTU@kernel.org>
 <981320f318d23fe02ed7597a56d13227f7cea31e.camel@kernel.org>
 <ZtcrTYLq90xIt4UK@kernel.org>
 <67405117-1C08-4CA9-B0CE-743DFC7BCE3F@oracle.com>
 <Ztc0xZIrAtZszJNf@kernel.org>
In-Reply-To: <Ztc0xZIrAtZszJNf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB6602:EE_
x-ms-office365-filtering-correlation-id: 330fd987-d753-4edf-ae2b-08dccc3addae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SW9xRkpWYzlSTkFEbmxCZXc2QW1aenVHbXhNVW9WYVVoNktwWlJZdTVOcXZQ?=
 =?utf-8?B?VUVRZTFlbVhyb1F2M1o5R3RVVFRNeFBLcDhCd2xIemJ2M2ZUM2k1dnFVMk9z?=
 =?utf-8?B?YUk4NXcyWmZpWkw2dk9KOUV0SklTQlQ4ekFXZ082MUxnUk1FVDM2UGY0VVI0?=
 =?utf-8?B?ZFdmMjNDSTZ1MEV0TVVyazFhUW9qb1c3QnVtWnU0empYM2ptd1hxTkFBeG9L?=
 =?utf-8?B?eWN2ZC81MWgyMms3ODBkaFp0ZjhDVCtETW1QUzFvalVqdFVDK0t6QWtaaTE4?=
 =?utf-8?B?Y1JEZjI2R3NjN1gzVWZqTlNUSkRwNTR3dDlNbzZKcmlIWkQ0bUVvZ2RBOGRP?=
 =?utf-8?B?VTV2aUxQNUdQVUszRklMdER2bm1xY1pZZFdKZEFQUXpuSWFEOWNRR1pKSVRl?=
 =?utf-8?B?WUQ4U1dFVlFUM0NQTjEweFNVZ25FckxZQzI3ZExFVUFDN0ZHYW45UVVXY2pa?=
 =?utf-8?B?SFRkTGttMTllTjJQb0NvWGpqY0xQWEg3VTArL095djdTZXRTY2gvSnFtZFp2?=
 =?utf-8?B?T2tuUDEzYTREK2dHM1JlUytaWURuaUduMnRmVHRGZGhKR0o1dzV2Rm5PY2x1?=
 =?utf-8?B?ZFlUU21qSXhtTEwxdDRKeE1hYlJRK2lIQm9CUlFvZXM5WG1zUmFjQWU0K0Iy?=
 =?utf-8?B?VVdEY00rMDB5eFVMaHVqM3FQUnp3VFdFT09WdERDc1ZVS0ZxU1N4NWo2bnl6?=
 =?utf-8?B?b295d0ptUWNEbUQvVTZESEhPbW41WnBya3BqYU45VmhScnNVMWVxVTVHTlZs?=
 =?utf-8?B?eFh1L20zanJJZkMvOFNMc0NqV0phOVYvbTZaTURQSGtQdlFaYVQ3dG9LcEM5?=
 =?utf-8?B?NWs3VmZjVGYrdU1wc25ubnVjeDU3a1RTSjdQQk9ncEIzbk9zMlJQUFZYdjFa?=
 =?utf-8?B?QVgraW93M2VFNkFJOFJCSXRnNEJtb3Zlb1U0aGR0NFJLUjFhZWNxZVZCSDBT?=
 =?utf-8?B?VXN5S1ROcVl5TXUyZUpvS0JTb2o2MEx4RDNIQ0J1YlNENW9HcHp2ak5qdms0?=
 =?utf-8?B?NkNZSW9yeHgxS0NUUmZaYk53SEVqOXRhMjlVZy81WUwrSUxSZ1BONXp2V1hs?=
 =?utf-8?B?ellvem5FSWE3MXFRLzYyREFaTGpzam16MGg0Q0xUSjg3MGpIL2JWUU41anpu?=
 =?utf-8?B?dlllQmYyUnljbm1HTHpjb1FkOFhVVmFwRjBjSTdBMGlrWGpHYkpKWGlmc3J2?=
 =?utf-8?B?MnNIcFphQmdRTTBxVkFxcVJYL3ZTNnZOTUt4MGFsalhSWndUMEV4OWVlbEQ1?=
 =?utf-8?B?aGsyQTBNbUdwaEZRM2Zpc0svWERseURNMkRvb29ueW5pNUo4a1pEVVlwS21N?=
 =?utf-8?B?U0Q3K2NHdERMS2hjZVIrRkVwdUZ2ZVpHT2UrTzZDUGV6V2N0VDJzTUE2V0hw?=
 =?utf-8?B?VjkyWTJZbGZtZVFuTHpCc1pyeCtHT2dEUFM2MW9MTHJoWEdzWFc1eDlmdFh1?=
 =?utf-8?B?V3Z4ZkQrSkN4MmFmN3F3SDM0STBiS0R1NEk1RW4zVDFDZU1sYkxBcnhtc1ly?=
 =?utf-8?B?c2NldThZcGYzN0lsRVdCblpxWUZPY3djWW0yMWZuMzZlellrNkdUSmtlL0do?=
 =?utf-8?B?MGJvcTVhUXQ3WGZXdUFTZzFaRHk4YVQxL3RsQVA3cnRobFBLTDAyLzhQZTZh?=
 =?utf-8?B?Y0ZoeS83OHFsdk4vWTdNZDNUSnJwU3V3ektoL1ZtRHdpbUphQ3ZWSTNpcEZ6?=
 =?utf-8?B?SlM1MDlHSGpUMDVQQjh1VHNjU0JQeUxmaTYvdnpCQ2pxZlpFd0tZQ1ZpTmRO?=
 =?utf-8?B?QjI2SWV2U3hpbW05MHp3MGNlMFQwTVEyeVpyRDQ3d051SFp3KzJCdEdDRXg2?=
 =?utf-8?B?OGZ2WmhISnVCRGltUkI4bGlYVHNGUUlRdUkvdlZtOHJJZnhDRm1sVmNWWG5U?=
 =?utf-8?B?aEZZN2RIMWMrbmcxUFZnMVlzcENzcGVaU2h2cnBkQ2llWkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YnBMamp4TnQrYlZLTXhHWEIyczVLeFZCa3FnaTZaQzl2akFycWVvOVZab2V0?=
 =?utf-8?B?bGZxcU5PbkpXa0x0K1RQR3ZQZFJkaGRSSzdWQUIwbWxlR283TE12MUlTUFN4?=
 =?utf-8?B?Nzlvc2x1bEpUc29kcW4weUQ3ZFBzWTBXVDhNa1lUVU1td0Fqd0ZoWU1TREl5?=
 =?utf-8?B?S21FcEJraG93TG51Y1RqdTE3c3U0SERUUXNKWGVlTFhRa3lrQjkxZTZlMlh1?=
 =?utf-8?B?Ky9NU0dnNUVVTHhDUUwycjhVYk9VOHlyL2JxRElMZXI3MlBTbGJpM0Y0Wi9m?=
 =?utf-8?B?Uk9yVnlXMDJqS2VzYWZXS08rVEZ0aG9KbElYRzQ0N0JtUjYrUjJUWDk1aFN4?=
 =?utf-8?B?YkJKWHQzY3ZlVTA2eWFHQ2E2M04raFFCNFU0MGFPVXA5TzJXUFBKdUpqeEZF?=
 =?utf-8?B?UEZHenJUUFN2WlJ3aHRmQlVJYXNDS2IrNUxaN0pibnFJTEhOS1U2SlVyRVU5?=
 =?utf-8?B?Kyt5dEFLL1BMRzdLbmhVb1pCQ0JWTlJibStYRVUwQXJyVm5kRXRlcy9ld1BK?=
 =?utf-8?B?R1g1MUZzQ295a1lEOGFwVXpXbjFpc3RjR2N4TjZJQmF0MFZFSlorQ0t1TTRH?=
 =?utf-8?B?M1dHRVpUY0p4d3JrQkp6N051MmlxWHFDaFVXcDY3YUkrSzdIdUVaMGhpYkRP?=
 =?utf-8?B?T1RySmJtZjhuMFZaNmdhT2tpc1FTblVOazU1dnBXU29CdkFETHpKY1hjMWNN?=
 =?utf-8?B?K0VIVkVNRDV1QmVqeWhZd0RSRnF1TEtZTGJZczNvVmQ1T0gzUStQWTVQcGZI?=
 =?utf-8?B?RUQzbi9IdGpGV0V1OXZYdStnSExzY1BadWNkWkpIS01DY1YycXBka1ZGaElu?=
 =?utf-8?B?U3k0RTJwc2lNV3dqTm5DeVRpbHZuVlhwcUNyeFJRWmxWQTFaKytBellTdE01?=
 =?utf-8?B?UDFIdzFsOU9CSmpFNW5kMjROYTBMVVBidGcwUXRMWDYvanhEWUNBRnkvUGY2?=
 =?utf-8?B?ZCtUeDIzanRnRkhnREdoY1U1VUYvLzl3NXdQQ1B4WDA2ZThzc3ZqR1FEZjNq?=
 =?utf-8?B?MVJuQ1ZPNkUxRXg4bTdsaWx4dnB1a0c2azc3N0hwanN4bEk1RkhUMmRja2V0?=
 =?utf-8?B?WmZFVlJjUlhMS2FuWWNvdWRZYXhBSUFISG43M2VtNERTaWFnbmxtREdYMG0r?=
 =?utf-8?B?L1pHRXdNYnZsM0tRQ1pvcEF4MnQvTVVVSWhuVUoxVGxPeXNFdTgvMTNGaXNa?=
 =?utf-8?B?RWg3dnlZMCtzSGJuYlFiZi94TS9OMHVmSmVTZlF3cUMrbUlPWHozQnRzQVlo?=
 =?utf-8?B?OWpQYUNmWFhjTEtvNlVxMkRObE1mVVlmaDJFNW1Qczc0WkVSWXJXVUFtSkYy?=
 =?utf-8?B?L3RZckZ1cU0weWNTUmU5WE1jVTNhL1UxS2lDcldaeXVMY1dSOVh6U1N6R0pw?=
 =?utf-8?B?OHNWQTFRbm1TQndOU0tWVjRDQnBkdFZXeTFwV1pWMENvRGdDNVZXaitEOSt4?=
 =?utf-8?B?S1FNTzZjUHVkTHAvMHFuTGhuK2h5V0ROTElMK0Q1NDhuTUFuNGhNSmNLS2pU?=
 =?utf-8?B?biswZXJxMUxFakwxNmljNEZOV3puWnR4NitxNUFLT1hZN0lQWkJHWXpCRnpL?=
 =?utf-8?B?M1V1K3NVaDV5YjluWVlLQkdhc0ZMdE9PdzFtZDhjd29XVHE1UFQ2ckwydjlQ?=
 =?utf-8?B?N25UL20xQVVEcVF1WUh2b2x2MkYrdkErTTRmcnlPUTdRaytDdVJ3b0tqbUJK?=
 =?utf-8?B?dUVDT3dKbjdsa3hOazdxVG1qbko4ZFNtWFR2N0hzeW9RTHNQdWM2UkFuMXNS?=
 =?utf-8?B?Q0NnRTFBblhrTjh2YlI4YVJpK0pDbzhXdnQ3L1hwK3dwZXFGOHQyc2M0MmJU?=
 =?utf-8?B?M1ZGb3hEcEcyZEJlV2pUbllZMUM3ZHh6VlNFY29icFIrWnpJd3VCQ2d3VHhq?=
 =?utf-8?B?c3YydmQwbW5JY1F1cTFjRytibDJnN0EvYlUxcHl3Mi9yeWVhcTVrY0VHRVVo?=
 =?utf-8?B?dnZTNUVWYWF2N1lwMC9GTlVnTXhTOUdxOVJnVUdDblBKeDJwMUtRYkR0cEVD?=
 =?utf-8?B?MGo4SjA4ejU5VmV3bm1Pc0t5NTJPb2JCaytIWm9nRlg5RjM5Z2JjNWdIdU5S?=
 =?utf-8?B?RDl3Yjk1amI1ckNGSnVRUmVJOHFiMWxXQUtkSk1hT3ptTmVYZTI4KzVJdDFt?=
 =?utf-8?B?eGl6U0dRVzJoTnZtZHZ4cDUwdnhQNUwyY0VSY1pocU5yejVEYWo5ckM0dWRx?=
 =?utf-8?B?MFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <460AEB5BBE1BDE40BA6240434AF4E322@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aKkwOeUpHoGjtgFMeiU3mvkc1o9zNY9oUu5Gj3KnPt7wVNw9/86q29bfbzqQXrHcYgikhGyHRGHmo9dxUCgzHxEqgyfnSxmso4iXRr2jFDd9vof/AZJJPsFiJ/550qA1UyFGrIDjMcQJb6g9bJtSzYlp0iLwXxMXuQ0V78+Gfx4CgBWkLskvtTEH8bFXK592Jkfk4CtCRtNcl84Z/yX/OhuBLbO6dbS01vkei7EPwfe7BQydaB0/Fv25JOCJQiNKtBtYyySkLJrmi8iGCrRH6WWAXwia+kruiCltYQiLaE/k/R6sujrWuTRqDBZ1hUslzZUSZzFEY3UO5VQNMWAOgoC5vmp80FiOEj4YVfofAvH4qB8Nw9nN5cdLAxL+DVajKAMbBGj0kOULkPqJnvvtVHnuucHDvsQEQDD6VAWS7Q2x3imeE8mMGFtmOrV+tIEGgFeaiK/Ce5f2SY4tdi9dzxXdt0mB5DgqZTRQqz0R6n3tTUznq2uesP1WY/nWDyPb3KNMsuH5xV6Gk0MokblHL8VlDRnLV0T7ES3kEg+qVACyBiGAs6//MZ37kyFBRYaWvEfVaSpr9DSWTOcUzB7Y2pENZcUR4tAvzS7/1fBF8RE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 330fd987-d753-4edf-ae2b-08dccc3addae
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 17:07:17.8525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nKh1GtBZl2m5yWQO3nIh/S1ffhIB0bEUb35I5vkZyCAknWCv4jbXmDn0VoQ/y7w8h9dnZVPjYS5wmSl6JWL5ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6602
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_04,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2409030137
X-Proofpoint-GUID: bKLFqcEqdbFfHPp9BegeUC54Z2ZvdCRh
X-Proofpoint-ORIG-GUID: bKLFqcEqdbFfHPp9BegeUC54Z2ZvdCRh

DQoNCj4gT24gU2VwIDMsIDIwMjQsIGF0IDEyOjA54oCvUE0sIE1pa2UgU25pdHplciA8c25pdHpl
ckBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgU2VwIDAzLCAyMDI0IGF0IDAzOjU5
OjMxUE0gKzAwMDAsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gU2Vw
IDMsIDIwMjQsIGF0IDExOjI54oCvQU0sIE1pa2UgU25pdHplciA8c25pdHplckBrZXJuZWwub3Jn
PiB3cm90ZToNCj4+PiANCj4+PiBJIGhhZCB0byBkb3VibGUgY2hlY2sgYnV0IEkgZGlkIGFkZCBh
IGNvbW1lbnQgdGhhdCBzcGVha3MgZGlyZWN0bHkgdG8NCj4+PiB0aGlzICJudWFuY2UiIGFib3Zl
IHRoZSBjb2RlIHlvdSBxdW90ZWQ6DQo+Pj4gDQo+Pj4gICAgICAgLyoNCj4+PiAgICAgICAgKiB1
dWlkLT5uZXQgbXVzdCBub3QgYmUgTlVMTCwgb3RoZXJ3aXNlIE5GUyBtYXkgbm90IGhhdmUgcmVm
DQo+Pj4gICAgICAgICogb24gTkZTRCBhbmQgdGhlcmVmb3JlIGNhbm5vdCBzYWZlbHkgbWFrZSAn
bmZzX3RvJyBjYWxscy4NCj4+PiAgICAgICAgKi8NCj4+PiANCj4+PiBTbyB5ZWFoLCB0aGlzIGNv
ZGUgbmVlZHMgdG8gc3RheSBsaWtlIHRoaXMuICBUaGUgX19tdXN0X2hvbGQocmN1KSBqdXN0DQo+
Pj4gZW5zdXJlcyB0aGUgUkNVIGlzIGhlbGQgb24gZW50cnkgYW5kIGV4aXQuLiB0aGUgYm91bmNp
bmcgb2YgUkNVDQo+Pj4gKGRyb3BwaW5nIGFuZCByZXRha2luZykgaXNuJ3Qgb2YgaW1tZWRpYXRl
IGNvbmNlcm4gaXMgaXQ/ICBXaGlsZSBJDQo+Pj4gYWdyZWUgaXQgaXNuJ3QgaWRlYWwsIGl0IGlz
IHdoYXQgaXQgaXMgZ2l2ZW46DQo+Pj4gMSkgTkZTIGNhbGxlciBvZiBORlNEIHN5bWJvbCBpcyBv
bmx5IHNhZmUgaWYgaXQgaGFzIFJDVSBhbWQgdmVyaWZpZWQNCj4+PiAgdXVpZC0+bmV0IHZhbGlk
DQo+Pj4gMikgbmZzZF9maWxlX2RvX2FjcXVpcmUoKSBjYW4gYWxsb2NhdGUuDQo+PiANCj4+IE9L
LCB1bmRlcnN0b29kLCBidXQgdGhlIGFubm90YXRpb24gaXMgc3RpbGwgd3JvbmcuIFRoZSBsb2Nr
DQo+PiBpcyBkcm9wcGVkIGhlcmUgc28gSSB0aGluayB5b3UgbmVlZCBfX3JlbGVhc2VzIGFuZCBf
X2FjcXVpcmVzDQo+PiBpbiB0aGF0IGNhc2UuIEhvd2V2ZXIuLi4NCj4gDQo+IFN1cmUsIHRoYXQg
c2VlbXMgbGlrZSBtb3JlIHByZWNpc2UgY29udGV4dCB3aXRoIHdoaWNoIHRvIHRyYWluDQo+IGxv
Y2tkZXAuDQo+IA0KPj4gTGV0J3Mgd2FpdCBmb3IgTmVpbCdzIGNvbW1lbnRzLCBidXQgSSB0aGlu
ayB0aGlzIG5lZWRzIHRvIGJlDQo+PiBwcm9wZXJseSBhZGRyZXNzZWQgYmVmb3JlIG1lcmdpbmcu
IFRoZSBjb21tZW50cyBhcmUgbm90IGdvaW5nDQo+PiB0byBiZSBlbm91Z2ggSU1PLg0KPiANCj4g
SSBvYnZpb3VzbHkgaGF2ZSBubyBpc3N1ZXMgd2l0aCBOZWlsIGNvbmZpcm1pbmcvZXhwYW5kaW5n
IHdoYXQgSQ0KPiBzaGFyZWQgYWJvdXQgdGhlIG5lZWQgZm9yIGNoZWNraW5nIHV1aWQtPm5ldCB3
aXRoIFJDVSBoZWxkIHRvIGVuc3VyZQ0KPiBpdCBzYWZlIHRvIGNhbGwgdGhpcyBuZnNfdG8gbWV0
aG9kLiAgV2l0aG91dCBpdCB3ZSBjYW5ub3QgbWFrZSB0aGUNCj4gY2FsbCwgd2hpY2ggaGFwcGVu
cyB0byB0aGVuIHRha2Ugb3RoZXIgcmVmZXJlbmNlcyAobmZzZF9zZXJ2IGFuZA0KPiBuZnNkX2Zp
bGUpIHRoYXQgd2UgY2FuIHRoZW4gbGVhbiBvbiBmb3IgdGhlIGR1cmF0aW9uIG9mIHRoZSBORlMg
Y2xpZW50DQo+IGlzc3VpbmcgSU8gYW5kIHRoZW4gZHJvcHBpbmcgdGhlIHJlZmVyZW5jZXMvaW50
ZXJsb2NrIHdoZW4gY29tcGxldGluZw0KPiB0aGUgSU8uDQo+IA0KPiBUaGUgTkZTIGNsaWVudCBt
YWludGFpbmVycyBuZWVkIHRvIGdpdmUgYSBnb29kIHJldmlldyBhbnl3YXksIHNvDQo+IHBsZW50
eSBvZiB0aW1lIGZvciBOZWlsIHRvIHdlaWdoIGluLg0KDQpJIGZvcmdvdCB0byBtZW50aW9uIGJl
Zm9yZTogSSBkb24ndCBzZWUgYW55IG90aGVyIGlzc3Vlcw0KYXQgdGhpcyBwb2ludC4NCg0KQWNr
ZWQtYnk6IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tIDxtYWlsdG86Y2h1Y2su
bGV2ZXJAb3JhY2xlLmNvbT4+DQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

