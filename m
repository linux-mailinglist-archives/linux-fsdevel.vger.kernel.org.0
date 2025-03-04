Return-Path: <linux-fsdevel+bounces-43158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1C3A4EC5B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 19:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF721889FB9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 18:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A948723643E;
	Tue,  4 Mar 2025 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sPUuh+IY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FA32E337C;
	Tue,  4 Mar 2025 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113725; cv=fail; b=ZR8Rw8Sy5wjFAn3kuSaOMlbKnbtWIYVNMZpArM5CLUQdDbZ4GuIEolz279B2sLgpzZlSmgTN3IMI/TXX+HiW2Ix8xSFRAD4GPgmN+MdxuRlMYDpO14DoutNNPsJGGC5YPKcLqPqk77Oq97RwXjyn4da6FyfJ8MTRzLNx5NJogtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113725; c=relaxed/simple;
	bh=0je7Nmr/5rUuDBOfjpPYbHNLtyIgRPJXYf+ABxtkZ1I=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Q4suIVInOmIKQ2iGmgwbUFDhxWSgIdGdmKkNHzvCOS/Eo23sMhbDPtqrhhZmqEvNLb+xD5NL9YLsyKxPuXSaFHxcYtBLAbbPvKpP3s5lKiQQ99H0Sv8BDmk7mLj9ta6KWdzSo1+cWVeiB8c31nf7Y1+1DkjfZJHKzRN0PZrAt+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sPUuh+IY; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524GkEJG022808;
	Tue, 4 Mar 2025 18:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=0je7Nmr/5rUuDBOfjpPYbHNLtyIgRPJXYf+ABxtkZ1I=; b=sPUuh+IY
	w+NyPgxNj2uNVRq1s9clqohUlYr/u6XdGNYpeW0gdbZVAVffy/EqjpEQg4tGQ68S
	VqXx6Rl4bJX1++XwMcvQEqV3jRPfHoZtAFvU1W+kxi59DGVcQNBC185e3fGaoC5n
	MFCAd90HIrRHAm2gxlPNemra169g53vMgVq25LhMjhS8uveJMPGE4hrjiVNm2iQy
	QSEJq+A5eg4gPIeb/57jVehKUADqyxyAMUr1vKae4yi9og0lrs1QimrgxBfLodqk
	b2lL00dTIsnZe/hx2jZrOjS+sfucEMhBilp/CsilGX2Zx+oiomyBuimJLYN57ofl
	WZW2+YacK8efnA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455ku55pds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 18:41:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j27TASxVMpUcZZvAuGYdxS/7vuTsnPMFKuVmtHaWvMXGoMjs3rQR5rDe3sVPiMWjB4zvdsA1LRBQydK4S7UjTTdwtmmVYQu7SoIftP0L3jt6SkpfIwgGnYkVwTe+o8wGbg5ON6tZgvNOfx9BYVE8VGORP/j6eShQhF1kO/RDMmoKP3B5ZWvVhlmB/O2afP18iq4qpk/ANIcI5a3gydkrONKiPkBxoUvizqyz41uIsz+kAIIXPmEXe2dm1/gZNOEhS7iY4nVuyUrgk/r/FESU29UOVGVROK2kgfBznDZfQNH2wUnZQSWEPvpsv1ByW4BL9Q9POrfBzlgp/LfMhWJh4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0je7Nmr/5rUuDBOfjpPYbHNLtyIgRPJXYf+ABxtkZ1I=;
 b=BRkPbvTM7BC/kLG+lBKv3Ge1Ouv8ERlCD8AJpITrbD4irDEw4NddltK9Qi2/92OwllN4PLH2Flf1KUZDUoI5LndxwpfdKPmuIw+K6b6Lam0mVRpKkSju97dz/Tkh3RqXqsTfuzVLdS/7KJNWcE287MUuRLT1YZ6nV2+RLQKGEAEfsit9PSSArOafJIBzwvfbkTsvPZiLsvgkH5f9slbHU38jCLkpRExunpViHTwfytro/xEsuzQ6weHnM6Nu8sSbJag0BVu+2eucc+z+YnP3JmLBO6ZHuCo5CqQWvWHWWiDRawut9l+aFuAZ4lMI886rxhmDX3NAh8NATGGCAeQ/Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB5818.namprd15.prod.outlook.com (2603:10b6:806:332::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 18:41:46 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%4]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 18:41:46 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "willy@infradead.org" <willy@infradead.org>,
        "brauner@kernel.org"
	<brauner@kernel.org>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>
Thread-Topic: [EXTERNAL] [PATCH] ceph: Fix error handling in
 fill_readdir_cache()
Thread-Index: AQHbjRzg20LzYdXmI0qqDoF49NeS8bNjT+8A
Date: Tue, 4 Mar 2025 18:41:46 +0000
Message-ID: <7f2e7a8938775916fd926f9e7ff073d42f89108b.camel@ibm.com>
References: <20250304154818.250757-1-willy@infradead.org>
In-Reply-To: <20250304154818.250757-1-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB5818:EE_
x-ms-office365-filtering-correlation-id: 7a311858-30fe-45ae-2325-08dd5b4c37a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RFFvZVpOL2hPSXVBUmFiTDN1emtaYmFPRkJ5K0E1Z0xLYWhXME9KcVZ5UXlL?=
 =?utf-8?B?MmZPQlJDdU1PRi95QWpycENCR2dMdWl1bXFFRTRwUVVYWlVMMlJzRGhKdDhE?=
 =?utf-8?B?ZTV1S2VxV1lBQXBxNDNyMGVWbkNRU1YrRWRaSkU2V05mUnUxNXNmK2ZtakNU?=
 =?utf-8?B?TE5CRmg4TFBBeEk4d0VqbEhnM2cwcThkQjRVZkFQaGNjUEFhWHNNRkZGMWVD?=
 =?utf-8?B?YVlQNjYvSVFkRmtWM2hlcDl3R0hmdG1sZWNMTDBhWG8xeUtCcjZ1UGVJcndQ?=
 =?utf-8?B?cnVCOTNacElMYldobkdVQlhvdTdQYW53QmZBVzhqZTUwTWd3OExndmVucUxI?=
 =?utf-8?B?eWhkWUY4VEdwTFNlK2Qxcmh4dkNIVlRLN0ZVcksrNUdsNWQzSjRWY1QzSlFR?=
 =?utf-8?B?ZGd3T1o4bEdVZlI3c1VoZ2ZhQWpPOHFRVUpVN3g4NGZkb3NTU2VQeERMZUhW?=
 =?utf-8?B?VjhXVnJnekNtZlkwRzZkUFg0UzROaHJrSWNlcnpoWEVnVzNGdGEraDlISE52?=
 =?utf-8?B?VGdCbjVpZis3VWRDQ1pvck5MbHY2UGV2QjgzTFhYOEs0dlA5enIzQm9ia3pH?=
 =?utf-8?B?LzE0dVI1VVZGN3ZBTjVPVjU5Z0drK05TQndKWThZU2JoMWNya3ZoaVVDL2FR?=
 =?utf-8?B?NmplTkZMZ3RNN1NJeGI0U2RKUmNCMDNTMWxVbmRTNURYeHloQlhoUDBEa0dV?=
 =?utf-8?B?SE1oMkVPUHNid0UrVWpuRHhZN0hNcCtIVjE1bExXc2tBRHdBL0VJQWM3TXY0?=
 =?utf-8?B?eHBLQVhHb2trcXJ5cjdKQzR1R1hVV29WWjBsWjlmRFF5N2JhNEpIV2dlSTU4?=
 =?utf-8?B?OFdJV0dRZE85dXVXZGNCYk1rY3VvRkVIOG12dURyckNuUm92Q3JUdXlBQW5v?=
 =?utf-8?B?SGdSVUtPYm0wYXlzKzQrY0duOGp3anlRNitLcjhjS1lKSTBvR2M3bXFUVE9k?=
 =?utf-8?B?M2dxWExYdDlDZGlpNEhoZ05IZi93UnpwTUxPVURtcHhCSzFQb1NSbTJRaVdj?=
 =?utf-8?B?cFlmUFcwYytpSVpSNElwN0hZdGt6QWc1d29mQ0pHaWJURGx6N2tZbFM5YkIx?=
 =?utf-8?B?eVI2RVVDcjdpc2RlOUJXVDVEYk1hbDMzeTJvOCt1MzNXdjgvNHRWeTNWVkVp?=
 =?utf-8?B?Q3N3bFRhVmI5U0poVUlZcUtVRFNQQXlGRS9HWkllallLaGZyVVVMU2Q4ZW55?=
 =?utf-8?B?SkVhTFphcmVQZ2FmUXhJa3lteUdCRm11YXlTTy9sZG8za3BVTUhvN0R3QW1y?=
 =?utf-8?B?cnQwYzRxSmc1QXZlMm9iNzZtNm1XdDlGSjExR0hHdUEzNGNma3lzVzlQR3Q3?=
 =?utf-8?B?YTFsVmdRQ1JURTRRUmZZYWl5QXFLRC82czJCNmpFS3pKbFZyZjgvWmwvbE91?=
 =?utf-8?B?bXJQYWNWaVdoZVpOVUFZK2VneVR6cUUxdVp5VHF6Ri9vVkxVN1VWeEs4eHgy?=
 =?utf-8?B?VG5oT0grMHd3eDcvaDVSQkdYbkVwdW1UVlJLbUZZdUU4ZzlnYlNXcmEwRE9h?=
 =?utf-8?B?TUF1OFp1Y3ByaTg5elFxR1grbHpvbjQvWE51ZVU0endKWGF3SlgrV1NJWkxX?=
 =?utf-8?B?azN5ZnJqbWJzNXlhYmdzcCt2V1VycktpTk1sWDhwc0prQnpMNU1nY0xKK085?=
 =?utf-8?B?Z0FGZXZ5ZXJma2FJa1F0Q2VLUzBrWHpYTWNhZ0EvN3hzbFdCRzZiVUk5Ry94?=
 =?utf-8?B?cy9maW0rczZsS0tvbXJHdUZoNXVuN1gzRDVNQ1N1RSt5cEh0Z3FIamYrdDVW?=
 =?utf-8?B?MGwwQlcrV24zaFgrOGZ3WE9UWDhFaTNSZWJaZjNaam1FTFM5dDdFbktTTDVq?=
 =?utf-8?B?Y2FmR0ppN0txWHVvY1ludWZxSm9LWjhpUnZ4eVd5SlB6cUJ6Zi81d0ZqTjk4?=
 =?utf-8?B?TXZxNWhQQkpHQXdzRnIzTkdTUExPbGIzT3F3ak9vZitqeWc1b2VPdXRBRnl0?=
 =?utf-8?Q?iTx4dF6ECZmBqeycfnuM85+1MRS4E6Rx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NHJqYjFaYm1oNjhodCtIVGRLWXczb2R2TFdvZG56V0J0ZENrR1kxV25JWGcx?=
 =?utf-8?B?TkxBVU1acUdnR1p2clFJN2xkUE9vbHV2UTJKUUMyY1MyT29ucktmTVp1MTBp?=
 =?utf-8?B?N0NOR3ozOHI0WUNPRk9SRFBQbjlpdmVOZVNoZTJQejhwY2JRL1R1YUU2WVNu?=
 =?utf-8?B?MFRnOVBqZFlDNTJvanF3ckJpUUt0RzFLcDFoNGxIREFGamRLdzlaK3V6RENR?=
 =?utf-8?B?STJmbWlFNmpzNmh4N1JteUJzRXV0dXF3Njd6WXNGdXFoaDNEb0ZlcWNZZzdE?=
 =?utf-8?B?WERsYndBQ2FHNE5nYk00V3FSbkErYWVWRjhkdU1ZVmd2eWJhRW0ycSszZGsy?=
 =?utf-8?B?TUwyNGltNC8rVVZjd29Kckg5MnlLS0x0OW9nanpMSGcwK2N5STkrajQvL2R5?=
 =?utf-8?B?Nks1d3lUcUZ6amtWOUo0YWpSZWE0NXY5MVMzNytsbWVNZVNOUVVnbHEvd3M5?=
 =?utf-8?B?V1RNUTJTRHM5NFNEczltQ0hZZTlpakRNaXhoUEhRY2ExVUhsUUU1L1kzWkRB?=
 =?utf-8?B?eTltakRBa2x4LzhGSmxUdVUvT0M5d2lQcnV3U21mVXVzdTZHdVVzQTVITHQ1?=
 =?utf-8?B?T1dLeEZvekhqUUVPdEg4MXdURWxRL0ZEMVdFSlduM3BtMjlXUU5UVUhXTm03?=
 =?utf-8?B?Lzl6QU52cDE4WnlreDl0UzZrTGRRRS9uNmRwcGxlZ3VPaDA4N2o4ZVh2MlhF?=
 =?utf-8?B?cVl0azhjWmRnQVZBYmhtYmlXUVluMU1lcjFrNWx1TTlIM1NIS3BkbXlYeU5K?=
 =?utf-8?B?MUpLVVkyVzhibmhTMVltSWM2NmZKNCs4SUhxck1oZ2cvMHNEZGs1TzdWcDgr?=
 =?utf-8?B?N1JSYS9CeFdNTFBoZitkRGJ4YmZ4dGtGUnFib2tvdENQa3BYWUh5VjRoWlF0?=
 =?utf-8?B?QTI0WjAyOXVLT0FmcmlqbS9rbDVMWGlOT3RoL0pQVExSY3pKNnhwYWJCR0gv?=
 =?utf-8?B?Z2ptRVErMUs1WDhqOEVxWllLYW9zclNueU9weFY3N29jMjBuZHh3WUlqbm8z?=
 =?utf-8?B?TVZGcE1QSjFXM3FDOCtQNnpESkJ3SGJxQlV1MmhPODlRRytSbWI5U1EzSlhM?=
 =?utf-8?B?YXZuUTJTSGdYTTdKZ1JNUDB4L2RDMHlwYjNYQittY1N6dnpYSTVaSlRxS3dS?=
 =?utf-8?B?bW1hcW9NOWcwNGQrOElCSDAxTXdJbG9mWGNpSE9JUDliaFlpYWVhRHRhME9V?=
 =?utf-8?B?emw1bnVPbCtYcHJUQUFabGZsQk5UTFdMcktodlo4S0lrSDRVcjdqVG1yd01h?=
 =?utf-8?B?d2EyNEZrdmF0OWUwY3gwanVPbXBhOHp6eThzNHBIejlMUkRVUkxLVnVuN05H?=
 =?utf-8?B?NmlyWGJNMy9Cc2xMWWI3WER5UTBrRThOOVZaVkJOUzZNUmZVTERJWnA5ejVM?=
 =?utf-8?B?b1V4ZzNUdFh4T2xOSjJtaFZSVDQzTlNXVnhFelVXazRRM3VFTitvY1dMVzUr?=
 =?utf-8?B?cXQ0Y1Bmc2dpVE1raDZnS25VRDZnY3ZpM0Q5OTNZSmUwcmttSExRWmxENEF4?=
 =?utf-8?B?Sjl0N1VvenNtOHMySS95KytrQzFVbFpxK0ZUMmh3a0tuWXYvcS9BU3gydkRn?=
 =?utf-8?B?QTRPZUdQRFphYTlzL0JyMlM4d21HZVJmSklXNXpUNTVYQWxCSEQ5bVhxYlJO?=
 =?utf-8?B?Sy92U0hmT0h4bHhZR3hRRUt5MytqWEZzam1VcVZsZ2x0MjJ2ZEdtVzMrSmhW?=
 =?utf-8?B?TlhWUDllT2lKeDZUYnlXSjhrMGlTdGUrS2F0RHlJNGdtbnhvTFhoVkk5c1FM?=
 =?utf-8?B?Z0c3b2o3bGhQMFNMVVhENStYVmxLMm54U2V2Z1RzbFNFbFl2dUJvdTBSdkdF?=
 =?utf-8?B?bE1LNXFFblMvQmNOcFloVGs5clNDOXBZaG1YWFNUZndLMVEwbHBxOWt3bkxN?=
 =?utf-8?B?MDVRWnd1UlZNZnhscGlIUlpVVkNHdFJ1VkE4Q2hNSC9wMXZCTHhEbHI0eUUr?=
 =?utf-8?B?U3RPM1EyYnhHQnlScHh0YTNGOENHNDdrWWo5MVFSVVkwUUJsSUt3L3ptTVda?=
 =?utf-8?B?MjhEVmZ1SExrT2ZiS3BNSkNJMEM3QzdJOXBSa3VnQ0t6dFB3bGc5bmtpVFVP?=
 =?utf-8?B?NkdHVkhJRFVNUzBEOFl4RVlaVkIxZzRLc0xXbldZZHFvdGhZTDBvcjZkMTFs?=
 =?utf-8?B?YTlRM2JNellMSFdyK1dRN3NHYnVzek1RUlYxNjMraDhHd2Jyenh2Z3ZSVTE2?=
 =?utf-8?Q?iWSDcFofgWz5cuMkeZPhFEk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B52D706B806E741AD97F584A626A7C4@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a311858-30fe-45ae-2325-08dd5b4c37a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 18:41:46.5291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aFHNwGlq3KW2WbmWPUiKAodofhl2KSqnpyXGvmwWX3q0kCqpy42RAGdgJhsv8zKah5Jztv532IcaApXHgeXzTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5818
X-Proofpoint-ORIG-GUID: dyL5maY07ot4DgmQxBIUt07jYkIQjXEV
X-Proofpoint-GUID: dyL5maY07ot4DgmQxBIUt07jYkIQjXEV
Subject: Re:  [PATCH] ceph: Fix error handling in fill_readdir_cache()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_08,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1011 mlxscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040148

T24gVHVlLCAyMDI1LTAzLTA0IGF0IDE1OjQ4ICswMDAwLCBNYXR0aGV3IFdpbGNveCAoT3JhY2xl
KSB3cm90ZToNCj4gX19maWxlbWFwX2dldF9mb2xpbygpIHJldHVybnMgYW4gRVJSX1BUUiwgbm90
IE5VTEwuICBUaGVyZSBhcmUgZXh0ZW5zaXZlDQo+IGFzc3VtcHRpb25zIHRoYXQgY3RsLT5mb2xp
byBpcyBOVUxMLCBub3QgYW4gZXJyb3IgcG9pbnRlciwgc28gaXQgc2VlbXMNCj4gYmV0dGVyIHRv
IGZpeCB0aGlzIG9uZSBwbGFjZSByYXRoZXIgdGhhbiBjaGFuZ2UgYWxsIHRoZSBwbGFjZXMgd2hp
Y2gNCj4gY2hlY2sgY3RsLT5mb2xpby4NCj4gDQo+IEZpeGVzOiBiYWZmOTc0MGJjOGYgKCJjZXBo
OiBDb252ZXJ0IGNlcGhfcmVhZGRpcl9jYWNoZV9jb250cm9sIHRvIHN0b3JlIGEgZm9saW8iKQ0K
PiBSZXBvcnRlZC1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPg0K
PiBTaWduZWQtb2ZmLWJ5OiBNYXR0aGV3IFdpbGNveCAoT3JhY2xlKSA8d2lsbHlAaW5mcmFkZWFk
Lm9yZz4NCj4gQ2M6IFZpYWNoZXNsYXYgRHViZXlrbyA8U2xhdmEuRHViZXlrb0BpYm0uY29tPg0K
PiAtLS0NCj4gIGZzL2NlcGgvaW5vZGUuYyB8IDcgKysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9j
ZXBoL2lub2RlLmMgYi9mcy9jZXBoL2lub2RlLmMNCj4gaW5kZXggYzE1OTcwZmEyNDBmLi42YWMy
YmQ1NTVlODYgMTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvaW5vZGUuYw0KPiArKysgYi9mcy9jZXBo
L2lub2RlLmMNCj4gQEAgLTE4NzAsOSArMTg3MCwxMiBAQCBzdGF0aWMgaW50IGZpbGxfcmVhZGRp
cl9jYWNoZShzdHJ1Y3QgaW5vZGUgKmRpciwgc3RydWN0IGRlbnRyeSAqZG4sDQo+ICANCj4gIAkJ
Y3RsLT5mb2xpbyA9IF9fZmlsZW1hcF9nZXRfZm9saW8oJmRpci0+aV9kYXRhLCBwZ29mZiwNCj4g
IAkJCQlmZ2YsIG1hcHBpbmdfZ2ZwX21hc2soJmRpci0+aV9kYXRhKSk7DQoNCkNvdWxkIHdlIGV4
cGVjdCB0byByZWNlaXZlIE5VTEwgaGVyZSBzb21laG93PyBJIGFzc3VtZSB3ZSBzaG91bGQgcmVj
ZWl2ZSB2YWxpZA0KcG9pbnRlciBvciBFUlJfUFRSIGFsd2F5cyBoZXJlLg0KDQo+IC0JCWlmICgh
Y3RsLT5mb2xpbykgew0KPiArCQlpZiAoSVNfRVJSKGN0bC0+Zm9saW8pKSB7DQo+ICsJCQlpbnQg
ZXJyID0gUFRSX0VSUihjdGwtPmZvbGlvKTsNCj4gKw0KPiArCQkJY3RsLT5mb2xpbyA9IE5VTEw7
DQo+ICAJCQljdGwtPmluZGV4ID0gLTE7DQo+IC0JCQlyZXR1cm4gaWR4ID09IDAgPyAtRU5PTUVN
IDogMDsNCj4gKwkJCXJldHVybiBpZHggPT0gMCA/IGVyciA6IDA7DQo+ICAJCX0NCj4gIAkJLyog
cmVhZGluZy9maWxsaW5nIHRoZSBjYWNoZSBhcmUgc2VyaWFsaXplZCBieQ0KPiAgCQkgKiBpX3J3
c2VtLCBubyBuZWVkIHRvIHVzZSBmb2xpbyBsb2NrICovDQoNCkJ1dCBJIHByZWZlciB0byBjaGVj
ayBvbiBOVUxMIGFueXdheSwgYmVjYXVzZSB3ZSB0cnkgdG8gdW5sb2NrIHRoZSBmb2xpbyBoZXJl
Og0KDQoJCS8qIHJlYWRpbmcvZmlsbGluZyB0aGUgY2FjaGUgYXJlIHNlcmlhbGl6ZWQgYnkNCgkJ
ICogaV9yd3NlbSwgbm8gbmVlZCB0byB1c2UgZm9saW8gbG9jayAqLw0KCQlmb2xpb191bmxvY2so
Y3RsLT5mb2xpbyk7DQoNCkFuZCBhYnNlbmNlIG9mIGNoZWNrIG9uIE5VTEwgbWFrZXMgbWUgc2xp
Z2h0bHkgbmVydm91cy4gOikNCg0KVGhhbmtzLA0KU2xhdmEuDQoNCg==

