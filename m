Return-Path: <linux-fsdevel+bounces-76972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMncI63njGnquwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 21:33:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E46E1276AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 21:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04F8730DEA2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 20:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BD7359F92;
	Wed, 11 Feb 2026 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KVSG8Rlw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCDF346AC0;
	Wed, 11 Feb 2026 20:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770841764; cv=fail; b=Bk6KD0hvhYY/yxKeL/brCPcf2ovQnICWv9plmz7NPnfNrwkk1sHpcUgEzau6CFD6z7QYVxSHEvIG8hRZH3F1DjWk0O9d27lT8Fqity0PkYGWO4lrfEQJHINwiS8raIei86QYroXG1VclCxvM1tqIbCO+6II20vVyyz22URszZb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770841764; c=relaxed/simple;
	bh=gQjFfFTA04P3KBaeK7u3UMjQvBwt1othUGLU01JJWD4=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=B0+Aoys/ktfiIx6iKdeRLVmMTQAuyHga7Jg3Uzuv5jjsG66IWPiQC5jhjXPior+V4JvqZAU6u7ZBH480WjDNAVDb+4ot3BXt3OSYxGJusfQ8CmnT8nGZaJehupPESu/lngNRDlYm8S0K2jqUs/AAek8+FLBt6ixrfutaDwoU2RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KVSG8Rlw; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61BGsGfv2890525;
	Wed, 11 Feb 2026 20:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=gQjFfFTA04P3KBaeK7u3UMjQvBwt1othUGLU01JJWD4=; b=KVSG8Rlw
	6by7cDqQHFNctoyNN1GxRSzzjovHRXa3pgvdz1Ynechcga5E55k48EiK5ZHyrP5K
	DiQ2vVTiiBgVOupo8xGZZERnU/ZS34FjC7oOOQLxoPsRpTWFgCXDKKWK3YApUDLJ
	RkgMUGzpcgt90Y+A4mr2ejYW5AX8pDhuXbps9xP7mT4SOa7+3/OLCtX8TO5YSEG5
	m4dqSmDT9Rk7WH06XZDNO2dFNqhD04ObnXTzrSyYt/EWezDjX/jSEvFgMk0DQ81E
	t7cyNZUczKprSpM0BCq2LzoB5f8SMReEKpkMtZdR8R1a7jE9PLSEKXzcSog4cyeg
	6KtQeJL0EjmZtQ==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010050.outbound.protection.outlook.com [52.101.46.50])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696x0j38-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 20:29:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZkIC0XfMbrFS0GyqzR/FFFufESdFijYSAWF0nb2crDIfHhrGJvdfJz1V/iWPGwLhYB7A/A2jEMf6LDHCfm6ijuFWdqF+WLdgMsStEQmWju+Hi2jdaBPzpgcd+w2yijpn+6Hx4sO0ra+p+1vbrncjiYPD3L+fvVvL7vlajw0y5Ia79F41ivMiPo+7hRhokjOPkLRZMgB5cWOIT2l8D9GdKo6CcjlnfAHEaKAXEqiaaWugzAdfTbVdgr+xh5wWS33htoMMGDFYf8kI9JroorYDZJptZMeTDXgXMxFG024y1D0OWtnyLe003XcKyby0AdoiyMI4bK63GyCbgqyycPSZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQjFfFTA04P3KBaeK7u3UMjQvBwt1othUGLU01JJWD4=;
 b=DqgvMMF604UKu5F33lka+XVx3a6BjktC0+hU/rbGUecuayodkeUfhpw3xcDAw3wscBf+89KOzbDazvZZTGZkMJr1Q150JQzc8Pt9LHREsq9w6xWdujJNO0cDL0AUw1ZyMeJGGNJSDk1z9iHi83OAY7QQLqoKq6+b0j0WF73YoEBJ0ee6ghSNh3UCPiRuJO/P2S1ig9F0oN7G76/oHf4rvKogb9w1ZpW+6tPbSvPpG07jp0hVrrG6tBHvYTM0rWo6fhTdm4FlFsEWEFniPjICgoj2Rq2pXfNjDBIEFWO0I9svZLKa46qF7o8mQfrEkhCL9lWOn3zAXOz5YC5jCSCuBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH7PR15MB5476.namprd15.prod.outlook.com (2603:10b6:510:1f4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 20:29:06 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 20:29:06 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "sj@kernel.org" <sj@kernel.org>
CC: "jack@suse.cz" <jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
        "chrisl@kernel.org" <chrisl@kernel.org>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>,
        Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>,
        "clm@meta.com" <clm@meta.com>
Thread-Topic: [EXTERNAL] RE: [Lsf-pc] [LSF/MM/BPF TOPIC] Machine Learning (ML)
 library in Linux kernel
Thread-Index: AQHcmpPXPV+chNeGskiA4zJOQ4d3LbV7+8WAgACKfgCAADCiAIABPhWA
Date: Wed, 11 Feb 2026 20:29:06 +0000
Message-ID: <a8a3b50620945dfa3ded3d6cd91c5ef9fadfd55e.camel@ibm.com>
References: <20260211013039.68143-1-sj@kernel.org>
In-Reply-To: <20260211013039.68143-1-sj@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH7PR15MB5476:EE_
x-ms-office365-filtering-correlation-id: c97e469d-1605-4c11-a368-08de69ac341e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?T3lNT3BpTTdaVm9iN3hnTjJ6SlRmZm93RXRYeWVJOFJqUjBZR1dDTkduTGVL?=
 =?utf-8?B?bVBMZXh6ci9PdU9RT1kzbWdBeVY1cHZLNFNVZ2M1SFlMc09rbnZINFV5T2Ru?=
 =?utf-8?B?MXU2YmRISTlRMVpLcWFyaE95ZUFTTTdJTmdRZDFsb1hOczI1RGRCV01zZGVN?=
 =?utf-8?B?YTljMFpuQmMzVURRdGZ4Q21pNW5FejRVTTlFOXpxd2ZXZmNoc1NqejNmRDQ4?=
 =?utf-8?B?MEFRanFtYUFQZGJpbURlN3JvMEp3WDRaYXB6aG9ra0lhWktnazkxN24rTUpk?=
 =?utf-8?B?NnhLdUVVUVlNVEtrRlNzKzFVTXdWbEhkUjJTYm5LcmUxcDBIdUpQVi8zNWFk?=
 =?utf-8?B?YmJBVTZtWU53d0d5T2lIQjkxdFhHNUpHLzllTklaWDJxaDJ0MjVuYzhnSlJL?=
 =?utf-8?B?aElLRU5jQ1ZSQUxqMmlPRlpPYVU0cngzSXRmN2I5dnNoTmFCNXpLVVY2cysv?=
 =?utf-8?B?MmtjTE5oZTVzR0l3eU8wb1RWMlFEVmw5MTU0YkFIOXZMNk84VDYzcTFaL3ZO?=
 =?utf-8?B?bUhRSjQ2Y2pTNjFGTnYrTU1OdUZLWkFHWHBuT0dydUJSMTd0aVhHR1BxUTZj?=
 =?utf-8?B?dkxDdVhIeThYcTk0SDVPMDhvY2tpTXN5SnViVFMyZTYwSmdxb2swVDRENXRT?=
 =?utf-8?B?d1F5L3I0QjYyVTgvajI4aDdSMEtXS2hvU0RLQk1PTTNGdW9STUQ3MWVLS0hT?=
 =?utf-8?B?TVlzVFdOYStIVzN1b1JheWRQb0RHMFdWZ3BveFV5TGgzc2FZU2NtbnZtZzFP?=
 =?utf-8?B?ZnJRQ3BWZm92RVVNNDlRTUZITnFCS0lhNUVlWEpIV1JLOWJUdUZoL2dUUGx0?=
 =?utf-8?B?RUpPcjNqUVMzZXRjaHNnOXpQZGE2VFNGVjFhZXFWUFRyQWN6UUl1ODF2NHdY?=
 =?utf-8?B?RHpkSFNaMUFIRFdDR3pwWGwrY3ovUWtkUW81dHZZVjRBc3U3bWEvN20zU1Zi?=
 =?utf-8?B?Y3k4aTY3OTd0YkRNWlVzRE5IamRoeld0aWt5ZzRwNk9xWm1FOENDTkt2Wmp5?=
 =?utf-8?B?bUtrY3Y2V0ZHMFMzYkdGaW5Qdyt5NFZXNGpmeDZFUXAvcDQ5KzZ5R2RqZWw5?=
 =?utf-8?B?NjRCdENaQUhGWFhxOXB3Z2krak5Zekw2dmtKTWdiMExTc0VVV0dRUi9vSTM5?=
 =?utf-8?B?VElkdXpwT3Q2VnBtU2lvZW5GOTBOeEEwLzNvcTh5cFR5cUlJT3hVdU1TMkM2?=
 =?utf-8?B?MWhJZEhVWmNhVTY1YWVFUE9PWTZyTUJqQzZlQ0FJR08vMmxMQTJDOCtXY0c4?=
 =?utf-8?B?THU1ZTRLOGtBcHdCRE5Rd3dWK3RxbUZoTlFuM1JCZVdVMXl3TDZWMy9JU21T?=
 =?utf-8?B?aGxyNHZvNllQMjVTaWgvYzA1QlJ2N0t3MTlzemlIaVIyWUQrTHMrbE5kQml0?=
 =?utf-8?B?WmludG16ZmQ5UlpyYnhXaDM2Ylk4bmxJcEZEK21LV3VlOFBDS0hEbWxLeTVK?=
 =?utf-8?B?eXluRSs2VTBWRjdBaVJQbFZyVnUyVDI1dXNQZjFSbldGcVkxOHM2eGJ2azRL?=
 =?utf-8?B?K2Y2TENKRXVXSTUrcEt5NVZsOW5Ha2hHMStVUmpOOHJ1dVBpSWQzOWlDYjUr?=
 =?utf-8?B?YUkvbVY4OHd6QTBuWkIwOU8waVVUYUFEL0JRNW9SQTB3Tjg5TDZxZzBTK0N2?=
 =?utf-8?B?eHhBdlFIK3FaTUtDM3B0dWpIUitzL3E0dk8zaVVka3RTTzBvalpkRTcwc0RL?=
 =?utf-8?B?UktIdjlTRnlQWm5rSDNOMmYvVUZLdGFEdWVIUjB0MzduRVVCdVZGK2lDdUdX?=
 =?utf-8?B?N2Nac2o0M2ZMUU9qSkMrSXJ0V3Y3SkZpQnpmNUdlK0dTbkVsZUQwb2E3UUIy?=
 =?utf-8?B?dXlSdkpmM2srQ2d4ZU8vYW4wUkRibU9KdytZb2tzUGxCSldBc0dRcHQ0UC9j?=
 =?utf-8?B?Qm14aUFDeVBQT1JvbFJZV3lzYzA3cEx6UWFIRzZiRm1idzZVSVF5RjlWNkNM?=
 =?utf-8?B?WGtveGxTckw1MUUyWFpLVUFFVTUxcXduK0JpUG1QWElhTXNoZktRc0kzQmw5?=
 =?utf-8?B?Ykk3UmhSbzhnM2cxaGFlZytEdTF6SjJEUkRGVzJUTHVPdVBZK04rU1I5eith?=
 =?utf-8?B?bUdjcDZodTFvRlVVQk9mbTFQSFBlK2hPam44aUNORkh4UXdtbUVUcWhRZjJo?=
 =?utf-8?B?L3o5Y1ovT3ljYmhHWWpmVjJFbGMwNUt1ZlAzc3U5S0RkdjFxS21xVDlsTVdD?=
 =?utf-8?Q?qUUlS1RbIpjF+k+ZvYFbrio=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWlxS3MwSXZrWkdPUktPSDZ1MnJmS3RLY04vMTFEdWVlc09SOWl0UHVoVmkx?=
 =?utf-8?B?WWNaNk83TVZmTFBLR0pDeUFEdVU3ZjJrQzhsWFhoc2hoQjN3K3E3TWFDSldI?=
 =?utf-8?B?NEJoREhFUm9ZRkFOVlJHRHpYZlJLcEdoVGdYUjIxdjY1UjBySzRzd2dUK0N4?=
 =?utf-8?B?Z1RGQ0I5encwME9yQXd2ei95U1czUS9CK1ZrTEMxeWtybm8vVUZQSXJyaDN4?=
 =?utf-8?B?RHYrbzVrbTZDM1RQNi9JNjVXUUxwa2J1QzJlbk5GR0R2NWxLRVJXak41ekp1?=
 =?utf-8?B?ZDVIOUx3VFNBRmxIZm41RlBjdVNCdU1DclByOVk0NjZRemR1b0pRYVZZQWx2?=
 =?utf-8?B?ZVVGZnBpMzVtcTYzMmFndGRvVXVyVE5CSlFEZ0VUOEtaL0V3Q2h0V2hoN1Rz?=
 =?utf-8?B?MmZWeEExZDdOaUREVVBwbENTck9pWlpTZGJaYzRZc2lzR3NYczdxcUgrWXZC?=
 =?utf-8?B?NTNDNDFIT1Y1MnMzSFpxWTk4K1B1KzJ1eklDUzE0Y2RwdFIyWUJyZFIvREdW?=
 =?utf-8?B?di9LTmhXR0tpNTlLcUs5cUpYaDJOVmR6WU8rSm1GUEtycSs0OVB5TzlaYjE4?=
 =?utf-8?B?OXIxVlczUkFNSkxaR0lSYVY1STQ0ekIrTVo3NkovQm9zTjJqdTdCYVdHNXdJ?=
 =?utf-8?B?Q1NNSFZQZ3gxMS9TcGE1TW9BQm1adHc0bEM2OTdyckJuclcxOW0zSk85R2hE?=
 =?utf-8?B?QkQ1amFBS2tGZTlqZnJjSHQ2Wm5ZU3lUUlUwZnlhNU5wSUo1M09mdFlQRGFE?=
 =?utf-8?B?VTRYdDhEaEtaRSt5NHI1Rmp2Q3FycTU2Q1pwem4xS1dzWEx2OHJVYlQ2c2x3?=
 =?utf-8?B?WEx0RHhzOUFmYmUzbWl4SmUrUnp0cDIvVm14NWIvR016MGVoUHBNUkMrVmxL?=
 =?utf-8?B?MzVSMmMwOFhmUVNsMGVjaHhzNVBydWorUWN0V2wyTGZzdHhkREZNcVAvcDFw?=
 =?utf-8?B?L0FQS0RJV1MzRUZ3OTNpNWp0M3htWFp4cElGejVJWlhnT2F4NkZtSU4zb2po?=
 =?utf-8?B?VlRvVTg3aEhRdzBQb3QxbTJRM3ZIdEF5bU5EK254QUR1YmppNDFOaVFMOGYz?=
 =?utf-8?B?TG1ScW5jSUducStsekJNeVlqZEtxbFlRZlk3VFdmdzJnU3lVOEVsWEhyeXBU?=
 =?utf-8?B?Rk1JTGlnNEdVWU9iaEptUmJKWjd2M0lNY0tvUk9BYkRFUXczenc3OFJ2RUxS?=
 =?utf-8?B?MWZoMjIwb0ZyZDRHVTR6Vm03UVlGS1dEYkhUMFYzY0o0eml4MWFkekdlb3Rq?=
 =?utf-8?B?ZkRHMFdFcS9obnNCVm43LzdtQnkzdGwwMmRnOU9ZU01PaWd2d3BXMFk3aXlr?=
 =?utf-8?B?QTJNVjJXYXB6NE90ZEVKaUlLU0hYZzg5cWFPbGFGZWdWSkNPWTNyRFZWeDNo?=
 =?utf-8?B?dDUrS3RGVGhrYWVsU01xTmxHanVJUTh2dm9rL2xzL0ZjZHZoejVLTjZkSzd4?=
 =?utf-8?B?U1l2RUNCWkZVcy9UbEVBU1UxdHhHSlIvU3VFaDgwbDBLWE80T3JBRWt4d1lW?=
 =?utf-8?B?UjkzWnFVNTdsT1NPSysrc0MzOEJ6SytHV2NHRHZGUlloLzQzdmdINWo5Q2Y5?=
 =?utf-8?B?a3FSVWRrZkxITERBMnRjVk0rRXg1V0t3YUdyaDNBNUpZZVl0WFJJNnQwNmJB?=
 =?utf-8?B?OWdEeVA2bHh5UzYrODdEYWJwQmZsL1JON0lac0ozcnJQMlc5Z2VBR2FVeS8x?=
 =?utf-8?B?TmZDRlhOWW9LenYrRTRqVFFLTXJoWjY1cEg4YUMzOE9LYTF5ZXlxMno0QkhT?=
 =?utf-8?B?bndVT3ByMkZ2VmluMHA2ZTNLSGwxVHdhMUwzbm9TakZ2VHNWc0dRTndJQUlC?=
 =?utf-8?B?RmpQVXloYjg3bGExR2c1TTZSQ0xvVzFhQTlJZnpnTlc2VDVVeVNIc2hEL2lx?=
 =?utf-8?B?SVEzU3BLcFIxYWxIU2NYSWlOcTEzSDFkN2dOWXFoL3hwZFZLL3ZhaFRyci9s?=
 =?utf-8?B?OWhFanlPeWxteURiSSs2WW1jVW15Qjh0RGcxV2hIcHRBUkpVM05GK2xORXpV?=
 =?utf-8?B?bUFKSi9jQnM2N0dNQU5zWUF0Zm5ZU0ErSTBObzErRC9WU2hLWU15dkQ0WEhM?=
 =?utf-8?B?bHlPdlFJUm1SV2ZTSjZGZjU5anp3QnQxU0NGTWl1dTV1UFlBR042QzdQNGx0?=
 =?utf-8?B?NEpwWktRTjFHNm9lYWViYWovQ3lIWm5OT0c5TUd6alZHQnV4NFMwK1Z5N0JS?=
 =?utf-8?B?SlozSm4rU24yZmVRYWplbllBRUFiVDBIb1pVbFpyZlZSSkh5c0M1K3R1UGFV?=
 =?utf-8?B?eWVhQ2wzQldPeTFTakluNm5nT3RnNW1rU0pqZG5jZVZ6dmMrNnJ5cWZPSENi?=
 =?utf-8?B?aG1udVhtVW1xOXdxTkVId0paMFZuc0dnU1c0OEpzU0NUeHV2Wk91TzZSMy9S?=
 =?utf-8?Q?f+QY5sWpfErTFaS7GDhWJYu20g1fXzNAcnepF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07993F6672033C43BCB29493C2FFB436@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c97e469d-1605-4c11-a368-08de69ac341e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 20:29:06.2154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ChBtsQj9Qoqp2mgEhDKpSi6ivB0jQWEn0QtHYvCmiyCo+4kTuUbl1o3YGK8qBNydJVeXtKAPR2L5oHLP0yEcFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5476
X-Authority-Analysis: v=2.4 cv=WZYBqkhX c=1 sm=1 tr=0 ts=698ce696 cx=c_pps
 a=MMVmnpyRbxvAcRc6a9dgEg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=xACqMCxL0gE2XpbJGaIA:9
 a=QEXdDO2ut3YA:10 a=0lgtpPvCYYIA:10
X-Proofpoint-GUID: ChX0-z9AB94aNATWjSTns6ZHmk0KmXA-
X-Proofpoint-ORIG-GUID: ChX0-z9AB94aNATWjSTns6ZHmk0KmXA-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDE1NiBTYWx0ZWRfX0AikS8KE4Yee
 JG2Toc6Vv0jP7yUhwH+5nWcRq8e7DZQwd7sp3uP7p3L7qRWj1J+NIRwJkENLs3qvMgbP0/folKs
 2YZzud2vOFsN9YvnXif/f8lXwU+on1Tf+3fWC7Ed0B2bl40TTxShGmN7fi9P2wPnoF1z/qn9sAL
 qKx80eydvK7q7opYu+BwRavsjtaIA1zeNcv6xDqElYzZemKazAxnnIcQ878ZqDAdq+zAEaDEfB0
 rKji7NO1qrcwjnLwGqNVdpia7l8wgmQZ0krlIlICItJjLih6MQiuRBZlRFd7Ysy+J8kkYK1wpn+
 KS7R7yw0qHB29Jj/RxEua5ywbPOr+K+AOWEjtzpxUbZWP0Nd/CkPlLgaFIK7x3V8M8jUECwHpML
 /9u5talPkTClK4TsK1UVKZX/q49NDP8b0HxRK4iKWHNr86F/UqY/LitkG40vWP8J2e2wzDDkLVG
 zmOXtL6g/DmRf+w45/w==
Subject: RE: [Lsf-pc] [LSF/MM/BPF TOPIC] Machine Learning (ML) library in
 Linux kernel
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_02,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110156
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76972-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0E46E1276AF
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTAyLTEwIGF0IDE3OjMwIC0wODAwLCBTZW9uZ0phZSBQYXJrIHdyb3RlOg0K
PiBPbiBUdWUsIDEwIEZlYiAyMDI2IDIyOjM2OjM1ICswMDAwIFZpYWNoZXNsYXYgRHViZXlrbyA8
U2xhdmEuRHViZXlrb0BpYm0uY29tPiB3cm90ZToNCj4gDQo+ID4gRXhhY3RseSwgTUwtYmFzZWQg
REFNT04gYXBwcm9hY2ggYnkgdXNpbmcgTUwgbGlicmFyeSBpcyBteSBuZXh0DQo+ID4gaW1wbGVt
ZW50YXRpb24vZXhwbG9yaW5nIHN0ZXAuDQo+IA0KPiBHbGFkIHRvIGhlYXIgdGhpcy4gIElmIHlv
dSBmaW5kIGFueSBxdWVzdGlvbiBvciBuZWVkIGhlbHAgZm9yIERBTU9OIHdoaWxlIGRvaW5nDQo+
IHRoaXMsIHBsZWFzZSBmZWVsIGZyZWUgdG8gcmVhY2ggb3V0LiAgSSB3aWxsIGJlIG1vcmUgdGhh
biBoYXBweSB0byBoZWxwIDopDQo+IA0KPiANCg0KU291bmRzIGdvb2QhIExldCBtZSBzdGFydCBt
eSBpbXBsZW1lbnRhdGlvbiBlZmZvcnRzIGFuZCBJJ2xsIHNoYXJlIG15IHF1ZXN0aW9ucy4NCjop
DQoNClRoYW5rcywNClNsYXZhLg0K

