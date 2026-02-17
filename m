Return-Path: <linux-fsdevel+bounces-77325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMwbJsCyk2kt7wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 01:13:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E240A1483ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 01:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F20DD3007BAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 00:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3891F0991;
	Tue, 17 Feb 2026 00:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lcUVVmTC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9990E3EBF2F;
	Tue, 17 Feb 2026 00:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771287227; cv=fail; b=OvyaH/5HkpIwOYyBifFz1A+stmiS16HBs9mKfF49PB38iVFH0+T8jNOv8vvcHPd3Ceq1u6/hZQ/KgezMjUH7VU45ZAAcb9Y0osvtpng/MeTQo0u6Ox2aZFUduuEAId4+O72KOsc7+1aMik8HwlpKIBlheiNZDUN121hxKEutF2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771287227; c=relaxed/simple;
	bh=TJ8uta9FWtM1ycDoQ95qcQ82I4iUm2iDbBcJXCBr4BA=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=BiKZ260mhTeqsb+Kx/KystMoau6wOsqnhFKILxkOh5tPaVnfQ9VZ+RDhN1+XeLLxq3zQd3+RQT5W/MvvCjfgdvZqNG9YVeRN5WyzdPCULg0M5wu/SHYQCCQ1lbPrl0bMm9hLnd6cGhlh+QJWxkc0Wx+Y1WjRMExbOxavtrvDZ1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lcUVVmTC; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GFZ1m03723169;
	Tue, 17 Feb 2026 00:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=TJ8uta9FWtM1ycDoQ95qcQ82I4iUm2iDbBcJXCBr4BA=; b=lcUVVmTC
	x3X2UPZunNdESO8nRmIanDjEZQrJb16/CasrgBNMNk/8tB5I9atRxL/7ifATs6dZ
	my5WOmnjbqRFkZmogKTq3y4vdE/PHcBJ7kLO8I91Bc/EoeMkUHbqUNbqGaCE7Y66
	9qdvAhIrzURS8gbAfrfd5yO7iVZh4dywXRVo6PBc0DbXNmgWF28OGOLsr07ouNnR
	eNDP8dX+QDvLBo/70liVXmk/RCYtLHRMnbCQ/HzO2US4gsMuAsOCxvvfbsmUN1TM
	pX7JvyzXImhe67en57brzoR3TBjzmwHPSxCVj7TfqK1XRFPtGJyXnlLC7TdoKz6M
	zXorzJ1n3IToKg==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012071.outbound.protection.outlook.com [40.107.200.71])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6rsse6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 00:13:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZHS4/+FanBFbD5Usu2iG3Kjw4npPjrw/PmCt7uZ/6i+G62Whv+FicBDm4F45TOL6lY89TkPdizqn3cKYACYa/HpXp+4q5osREKukVUATovIP3ylKz1DFAJJrelcFWQT92XZnyhFSRLt7QhFyb52hWrW8n1qPyw7Ug5mBa2q+w2o6Twb4gYxsOD0ZDrtVyTmb96WhUrqyPEPvocMl90xIO6l0mUSYQhXto09CWihmsmIjK8jEGQRnU3TBFjdKlqJAFIl8yXaOcZU+vD3RCgT8vUlA8oL+4bVmyxPml5YtMvjybI4x2fR1cNmGx1a5vfvd3mH6Jy/8GAmR4ZsrbJ93A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJ8uta9FWtM1ycDoQ95qcQ82I4iUm2iDbBcJXCBr4BA=;
 b=Ngw6VXEk0ByXw8wwCGPngItpJSRF18FBZcxRs98jAwPbeAwiseeuvClHBLRpjO+g139JWdYZJJE2JmZr7UDNtRr2TY8nnE49FcJqeR3211A/0cfIjR5RLDohP3CsDoFrclXnPQDAbAFBUGO0diNQfs/SpO9iTie3EpdJ9eREGInTHTcv77rH+IvaqQNnTQNQvTuLyDA0A05AM7GMCVEZigACTBDdkBploqqgflMSLZnr4cuIlLYZgNQcCU689l+/2XFRx8Qk1XuZA/PdK68XOdXHxe4UOQDCZdsBUZOfkdjnlB+qj0L9LHGee+s5WkXPzhxv9lZh+FoOqCgKX1nYHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS4PPFB691D9211.namprd15.prod.outlook.com (2603:10b6:f:fc00::9b3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Tue, 17 Feb
 2026 00:13:33 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 00:13:33 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "charmitro@posteo.net" <charmitro@posteo.net>,
        "kartikey406@gmail.com"
	<kartikey406@gmail.com>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com"
	<syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v4] hfsplus: fix uninit-value by
 validating catalog record size
Thread-Index: AQHcnuoqiPJTz2CocUu+SlolCgp+qLWGBqsA
Date: Tue, 17 Feb 2026 00:13:33 +0000
Message-ID: <0f995add83013cd2f8dcaad7ca45225ca24a19fc.camel@ibm.com>
References: <20260214002100.436125-1-kartikey406@gmail.com>
	 <87seb1v3gc.fsf@posteo.net>
In-Reply-To: <87seb1v3gc.fsf@posteo.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS4PPFB691D9211:EE_
x-ms-office365-filtering-correlation-id: 13cc0b3e-9627-42cb-85cd-08de6db96354
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dDg4RGFaZWJKN0VHRnJrN1pPeUJMQllpWGdZZDNCYU95Z01VaDBTZGpnWWxq?=
 =?utf-8?B?eGVQajVsZFhpYkJpWWtSZWtEUW9QeVdudGMrM0ltZ2s1bTlPQXpZeHBKdGVx?=
 =?utf-8?B?ampNTS9LSC8xM3NyOTM3MGxuSzltSExTZVlVeSswR0dxdVNjT1U1cEJmank1?=
 =?utf-8?B?RlNVTUNmUTFnQis5RGVkeG5yZXVzcHoxc0Rkc0pUTkVnZ2Z6aWs1Z3ppaEk3?=
 =?utf-8?B?b2tPbzhVTTljdWt6cnFCTEJ1OCszSWVKVTRrN0V2cnQ0RXNmRU9MV013cXZN?=
 =?utf-8?B?YUZVS3cwVS9QN3lKSjVvYXhoa0l3R3RSREFkdGdRYlpuWFhsRmtIQVlTOHlB?=
 =?utf-8?B?WnlzTDJvTDNkOTBhcWt0aUZZWjYwQ3hydDU4K2J0OUM0cm1aVExQelFkSEN1?=
 =?utf-8?B?eDdDbGNhMUlUZ281V3R6SnMvT0RBS3luc1JvaFlobmo2NXMwckVQQm1FOTdW?=
 =?utf-8?B?dDJIRklmRUNOYVNPTGJUZk5Tai9KeUhoUm90MUhQRTQxMWFYenRVS0VUeFJw?=
 =?utf-8?B?WVUvcXBTS0lyTGtPVElhaW8zL2dZWkwyd2krVlJ6QU00dFUwQm5LZVVNd1I2?=
 =?utf-8?B?dnQ0TUJHdTdaWkxWanp6MFBUZDRlZDJ3cVJnMURqVk5tYXBVREc3aUYxLzV6?=
 =?utf-8?B?ZGM0a0xtWGVRN0I4OVc3NnowbDNVbHh3NG9pT3JTbnBIM3k2Wjc0TkNxbVZn?=
 =?utf-8?B?bHZCM25RQjZueHNEMHMyaEYvRHFGU0RNNWw0R2JvVjN6Rlppczk0UWQ1SU5z?=
 =?utf-8?B?UU9jbWFncFhqQVQwYnVMR1pITzhZRWYva2dha1dmUXd6UGtWNExkaXB1Uktk?=
 =?utf-8?B?VFkydUdwS3plOG1HdVpVdFpKcERXTWJUNS9wMWlGbzgwUUovZERSV3VCZkRj?=
 =?utf-8?B?RXBIckpXUTkvWHZjQ2F1L2hTMWtOM2FTYXpGVXNlYTdtZHMyZHArKzlNT0hR?=
 =?utf-8?B?d2ZXL3hFN3BObTdsTmk4dytYOVJTeDlrM2JQekNwODNHWFJMQnpqclo2WHI4?=
 =?utf-8?B?UXRJT0UrRzJRbjNSeDNnSzBTRGpDSnE5ZkluTGhQUjlWU3R4UVRZYjQ0YkxL?=
 =?utf-8?B?VGxKbFF6Qzg3NUJhdDJ4c0FMNUdTa3RHbG5NNy9iQkVweHVsQ25LWEFFRnN6?=
 =?utf-8?B?Wi9FZ1lIWHcxR01QeDh1WGIxeW1nSW1EblFzVXFycjhiSXA0R3RRWm9IcVQv?=
 =?utf-8?B?aXN0VGdQRzFWUnZmZmpXQVdrRkZ5MkRleUQ4RlgwU3JxdmNQdUZPN3owUlFI?=
 =?utf-8?B?ejZ5RDFmcUJXb1JpcEppd1hTRVE1ZGpMbmVYeVpiaTNNVDJxS3g5VTNHTXlK?=
 =?utf-8?B?ZUs5emNSL3d1bWZSRHFZODRXaFBqdU5iMG1ybHdMTnd0Z1lwMFhCSFpkdWNV?=
 =?utf-8?B?NW43bFRTUWxNTXR6bzU0RVN6UTAzMmNkRjdVQkZJUGJUdHFHNTlFNVVhSjBQ?=
 =?utf-8?B?TzIvMWVYVkV0RTc4NjArL2c0eWNTMGx0aUFENWxhR1pmdEY1aFg1SmZTK1pX?=
 =?utf-8?B?MDBKNHhnM3I3bFB3ZFZwMUxqZHhZTXNQVGxIcXl1aFJvNzJuVXoyUkV5dXVU?=
 =?utf-8?B?S3BOQyt1djl0YjlKeW5aMnU3R1VxaGN4RExGUTZDckVEeUVvNVlBTU8wY2wy?=
 =?utf-8?B?NnlFU3dnTFZNcG13MEUvZURiTGF0WmdoeTI2ZlltbmtVTlRhTWhqMnNRUEFV?=
 =?utf-8?B?eFpoWng4NkVodDZEZ3BkNlFwMUtqdHU3QVJtOTBSTUpNenFlZmluMWphOGF3?=
 =?utf-8?B?UjFYeExzNGNZcVB5TkFLS09IMFZieGpBYktFZ1paY013Umx5a0lIWFg2WjlP?=
 =?utf-8?B?MUR1R0Q4NVdkbzYyR0xYYXRlV2hkdzBvY08weXZoeUhiaDhKcXdyNXROemtF?=
 =?utf-8?B?dXR0eUFPdTdSMHBheTkvQkNFSXNUSHFsWmc5c3dSWlNTQnY4MUZhdWpNM3RR?=
 =?utf-8?B?eVROZHVqT3VqMitVblVwMDBUSzBCdHFkbDNRb1JzcHFzWFpVUHdBSU1YOU9k?=
 =?utf-8?B?YXBtSGZ3QjZ0SXVVWFJoTDB6cUZVZkZsZG1kSHBHdG9lbXRzcXlBQjl6R0pR?=
 =?utf-8?B?SFFkc2I3SUlkQmtERTNnZjlwUVRublFraVl1ODdKekQrZGpxbmhwSW9pd3pI?=
 =?utf-8?Q?5XI10qNyGLMRanJ8VohwVLAo/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OTVldjdWelFBUzZTT042TWd3SFNreWwxQXRYZDJmTUVyTlhtanRMaGx1bVU1?=
 =?utf-8?B?ejdtcWNMTk9DdWs0TTc0SDhndUFKUGREb2tic0Iwekt1WlNZSWVMbGZsaEZG?=
 =?utf-8?B?dTl5UlVGcDBXNmtJcG1WTDQwOEp1djRFOWF0MG9wSE40MHRMSmdFYkVONGJS?=
 =?utf-8?B?YXVNMWZKbzIvcVkrdUpwd2FRK2oyWXh1am15T2tBWUNiNlQ2OGVYRHRTNGpv?=
 =?utf-8?B?UVBUVHIrZ2lBTWpGR25KVk1TOU5GNWkrYnVEMEtndzFxUnVQNWhNR3dqRU9t?=
 =?utf-8?B?dEtTMmMrNkpyMUUra3dMaVFxUDk2aFVCdi82NmMzWEd5WVNZdXFTNVpIMEw1?=
 =?utf-8?B?MHRRdFBqWkJtREJ5bEJNd0dOdWJXa21NYUZYamFDeUdGdHJQam9jUjU2cER0?=
 =?utf-8?B?Yk1ZZlEreXFLOGJ4TzRYbFdDZXFaOTdYQ3BrQjlSVzV0eGFwY1VCQ3VSUnFz?=
 =?utf-8?B?SThLRkRDVlFCZHJjRzBkbG45aVdPY0hHY3g1TUwwK2MxaVBMWkpIeHB1eDZw?=
 =?utf-8?B?TVhlSE5OWm1hZHhpNDdSMXhxcGx1R3VTK01JOThKSjhxMVc0QlAyckZDT2E0?=
 =?utf-8?B?anV0ZSswL0pRZkVMcnVLZ1BUM2NyWldacWFwN2ZKRkZJNlBFNWhrUWplSGor?=
 =?utf-8?B?UTUza2lleTduY1o0dEQwQlNNdE0wQUxqUGk2MjdvNER2L244RWQxdzRtNWVO?=
 =?utf-8?B?QmYvKzZNUTVLWDFGbDk5QjI4c2VQUHZFSEtxVGVCZHRLVE9uTlpIMmErcWts?=
 =?utf-8?B?OVoxTFpZbWVZZDNGS0Q0dUQvZVlVYm5kZnIwZU1CUmlzNUh2dkgxU0VCVXBR?=
 =?utf-8?B?RytNOFRmVk4zalhxTzBqK0cyRFVSMUdpRTJ3T1JoUzh1b0pCOXBTZ0JXUUNW?=
 =?utf-8?B?T3RtcUVGODBkanVyMmcrMkI1S3V4M1hjTmtmcmJ6cVo5SVBYMWNLcHFmdW1q?=
 =?utf-8?B?UmkyVnRXd2VGZ0lUL0VjNG1VUjkvdnp6eDdINHdYMzdEMGJlNTRPLzFLUzR1?=
 =?utf-8?B?SlhjY1hiU2V3VElrcW1GbGkzU0o1TFhIbFZzSnhiYnQ2amRNci8vZVlCNzRI?=
 =?utf-8?B?QlQ2c1Z3T01BbzNlNWIwS0tjbmt6ZFUwMzBxVFVTeXhYOWZXWXFHMWtDV3ln?=
 =?utf-8?B?WHBCSXFua3NtUS9BR3FFaTFpT3RVdW5lSUg4TjQ3TEpRZ2dvVXFhVTN0RU5l?=
 =?utf-8?B?TzdLMFVXd1RVaVhhekZXNHlzZGYyb05xTFF1cVVmcS85ZldnQTd3M2ZscStZ?=
 =?utf-8?B?UHNabzRxbXBLRmlGbnkzWWlKRUMrWUw5c1FFT0tSK0xmQkFFcTN0SFFIZkE2?=
 =?utf-8?B?ZU1DSjFaTVFGSTEwdlVhek9QV0NSMXo5VkFPK3JUNmk2SUF3T05ObGhYQ28z?=
 =?utf-8?B?YWErcUZmSSttdml4TXlPdVk4OEdnRld5cTNac21xa1d0SjQybjN6TXd6RFVR?=
 =?utf-8?B?VWNLTlFoKzRiaGd5aThFKzhDU0VkMjNCRld5bmhrRGwzVVE1MWcwcjZ0RUdF?=
 =?utf-8?B?Z1pFVG1vcGREeVU3UWdNRi9wdXorSDhzQlFDOXlFVlFuZEx0TERCU09paU9P?=
 =?utf-8?B?dG1kMzlpU3M0ZTRDdjd1TTR0bUUyRkJRZVVBcGVTNndpSnpJQkRLV3ZocThN?=
 =?utf-8?B?RjJlQkJyai8zTkNEcjFpQ1RGSnFvaVh0WHhrZVFzeXVaWUhOTndvb1dtZVlr?=
 =?utf-8?B?bUdVSTg0UFY4dU9jV1ZXaHo0QXQzOWd0bjNVTWhwcGhZSExZN3dtQ252eDNn?=
 =?utf-8?B?R3R6dyt6ZTNvZHlvNzJRSHczV3NiY2ZSUXlnV2dkNUhoU3QwcmpKTUoybjRV?=
 =?utf-8?B?TjY1WEhrVlVHQWdra3p4MFFwUnpxRGpFcEtTK1NxZnMwTnVxNlRtdmt5RTd5?=
 =?utf-8?B?OVJaRk91RjFBdEI5cTZQdEd0M2NlNUhubFhDeXdqTjJjd2ZyeUFKRU5XNUtO?=
 =?utf-8?B?U0JUZ1lNV0RDMmYvTkVvRDQ1RHdzSTZHK3pJMTdtbHh3dXorS0ZNbGlpNDJz?=
 =?utf-8?B?U3JYdXoyUEcyM3FSKythZTNFc1NPUWlZUC9tU2MwLy9tQzhFdmg0NVZWbGJi?=
 =?utf-8?B?TVdYT2JVTURyRTN2R3haVUtKbXhvRlJxRmdaZUpZZjUxKy95UFhXTmNZVHlF?=
 =?utf-8?B?OTNlNjlwOHFVelN1cmNPVWNEWWlrTG1uKzZFMXZvVVNQRDZDT0oxNDF0bkYy?=
 =?utf-8?B?V0dKQndDUVh1M2htT3lSVitEcDk2NHhSVTBENWpNb2RZSVhPanhmOEd0S0pr?=
 =?utf-8?B?NFptbDY4UzJ1bm9GNWZhTGhIVGtnUWlycm9Qd2MxLytiRGgvekFERU80S2NF?=
 =?utf-8?B?QythNjVXZFk3K056K01CSkFZS1d5K0lFRVdKL212V1lZREdFN0hqbDcweE9E?=
 =?utf-8?Q?FytnqTkLUv+ccmA13oOfMZOzBx86AY/vSDeRP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0B9C55183786541AC2629D27E86D80C@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 13cc0b3e-9627-42cb-85cd-08de6db96354
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2026 00:13:33.5768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FY1gzz/7a1EHHlOl6gf0BzqHnYIbc4la2sT4KfnFP7sZCygGztz1CZKLj8IOdn2OVdWt0S2Ea5uPP8rrlgTOng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFB691D9211
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=dvvWylg4 c=1 sm=1 tr=0 ts=6993b2b0 cx=c_pps
 a=il/B+BFNnLmOqkoxAJ/ciQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=hSkVLCK3AAAA:8 a=mod4Pvd8b_FNs0eWtrsA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-GUID: 2fVt5AQNHksqWsHt1A1zejGlECagVqsu
X-Proofpoint-ORIG-GUID: _ECMekL1taOHE-Y2WYtLPTm7EY_tZR2p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDIwNyBTYWx0ZWRfX49oniSAcIhcp
 cuSHgDeL46fKaTN2Rqok+GrFQKjaXp2do68tbbZbfvSdr74WuVUrSWfDje9aiqrbRYlnGRhiDm9
 xVwRP6knt1yr4oX44RbeWhr1759RaUPQ0Kx3dbtiOghB7xRzBf8v4Taj57uh7a58n7eYxgA9tQh
 a0YHkjNG77RGAxOnP6l+uXRL8ardc2ZMnNykYksMDgdIRMbTtijI5Rks/0IXP5O26fl0rOBgHDz
 d/ucbPCnKCjhILj6O3gpZyw/TYOVmTi196QJ9MYsNGvwGd00NNJsN2ZcLbRApP0/gZT84x5Bxl1
 kpxciWEQ4sUr5pnpUPxjIirI8HmQRuAo2/EiQjfxhHeykwny27/roWLLkerjbtx4eHX29KSLS7D
 /NsWg+r2IAi4EycQC5w7scnRdsEH1BpspHpZJeBiBA6gmLCZp2tu03NISCezRB5+xsRO2a1lnrh
 1j6dOEvEFV7yjSOyPtA==
Subject: RE: [PATCH v4] hfsplus: fix uninit-value by validating catalog record
 size
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602160207
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-77325-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[posteo.net,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,proofpoint.com:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	TAGGED_RCPT(0.00)[linux-fsdevel,d80abb5b890d39261e72];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E240A1483ED
X-Rspamd-Action: no action

T24gTW9uLCAyMDI2LTAyLTE2IGF0IDAyOjE1ICswMDAwLCBDaGFyYWxhbXBvcyBNaXRyb2RpbWFz
IHdyb3RlOg0KPiBEZWVwYW5zaHUgS2FydGlrZXkgPGthcnRpa2V5NDA2QGdtYWlsLmNvbT4gd3Jp
dGVzOg0KPiANCj4gPiBTeXpib3QgcmVwb3J0ZWQgYSBLTVNBTiB1bmluaXQtdmFsdWUgaXNzdWUg
aW4gaGZzcGx1c19zdHJjYXNlY21wKCkuIFRoZQ0KPiA+IHJvb3QgY2F1c2UgaXMgdGhhdCBoZnNf
YnJlY19yZWFkKCkgZG9lc24ndCB2YWxpZGF0ZSB0aGF0IHRoZSBvbi1kaXNrDQo+ID4gcmVjb3Jk
IHNpemUgbWF0Y2hlcyB0aGUgZXhwZWN0ZWQgc2l6ZSBmb3IgdGhlIHJlY29yZCB0eXBlIGJlaW5n
IHJlYWQuDQo+ID4gDQo+ID4gV2hlbiBtb3VudGluZyBhIGNvcnJ1cHRlZCBmaWxlc3lzdGVtLCBo
ZnNfYnJlY19yZWFkKCkgbWF5IHJlYWQgbGVzcyBkYXRhDQo+ID4gdGhhbiBleHBlY3RlZC4gRm9y
IGV4YW1wbGUsIHdoZW4gcmVhZGluZyBhIGNhdGFsb2cgdGhyZWFkIHJlY29yZCwgdGhlDQo+ID4g
ZGVidWcgb3V0cHV0IHNob3dlZDoNCj4gPiANCj4gPiAgIEhGU1BMVVNfQlJFQ19SRUFEOiByZWNf
bGVuPTUyMCwgZmQtPmVudHJ5bGVuZ3RoPTI2DQo+ID4gICBIRlNQTFVTX0JSRUNfUkVBRDogV0FS
TklORyAtIGVudHJ5bGVuZ3RoICgyNikgPCByZWNfbGVuICg1MjApIC0gUEFSVElBTCBSRUFEIQ0K
PiA+IA0KPiA+IGhmc19icmVjX3JlYWQoKSBvbmx5IHZhbGlkYXRlcyB0aGF0IGVudHJ5bGVuZ3Ro
IGlzIG5vdCBncmVhdGVyIHRoYW4gdGhlDQo+ID4gYnVmZmVyIHNpemUsIGJ1dCBkb2Vzbid0IGNo
ZWNrIGlmIGl0J3MgbGVzcyB0aGFuIGV4cGVjdGVkLiBJdCBzdWNjZXNzZnVsbHkNCj4gPiByZWFk
cyAyNiBieXRlcyBpbnRvIGEgNTIwLWJ5dGUgc3RydWN0dXJlIGFuZCByZXR1cm5zIHN1Y2Nlc3Ms
IGxlYXZpbmcgNDk0DQo+ID4gYnl0ZXMgdW5pbml0aWFsaXplZC4NCj4gPiANCj4gPiBUaGlzIHVu
aW5pdGlhbGl6ZWQgZGF0YSBpbiB0bXAudGhyZWFkLm5vZGVOYW1lIHRoZW4gZ2V0cyBjb3BpZWQg
YnkNCj4gPiBoZnNwbHVzX2NhdF9idWlsZF9rZXlfdW5pKCkgYW5kIHVzZWQgYnkgaGZzcGx1c19z
dHJjYXNlY21wKCksIHRyaWdnZXJpbmcNCj4gPiB0aGUgS01TQU4gd2FybmluZyB3aGVuIHRoZSB1
bmluaXRpYWxpemVkIGJ5dGVzIGFyZSB1c2VkIGFzIGFycmF5IGluZGljZXMNCj4gPiBpbiBjYXNl
X2ZvbGQoKS4NCj4gPiANCj4gPiBGaXggYnkgaW50cm9kdWNpbmcgaGZzcGx1c19icmVjX3JlYWRf
Y2F0KCkgd3JhcHBlciB0aGF0Og0KPiA+IDEuIENhbGxzIGhmc19icmVjX3JlYWQoKSB0byByZWFk
IHRoZSBkYXRhDQo+ID4gMi4gVmFsaWRhdGVzIHRoZSByZWNvcmQgc2l6ZSBiYXNlZCBvbiB0aGUg
dHlwZSBmaWVsZDoNCj4gPiAgICAtIEZpeGVkIHNpemUgZm9yIGZvbGRlciBhbmQgZmlsZSByZWNv
cmRzDQo+ID4gICAgLSBWYXJpYWJsZSBzaXplIGZvciB0aHJlYWQgcmVjb3JkcyAoZGVwZW5kcyBv
biBzdHJpbmcgbGVuZ3RoKQ0KPiA+IDMuIFJldHVybnMgLUVJTyBpZiBzaXplIGRvZXNuJ3QgbWF0
Y2ggZXhwZWN0ZWQNCj4gPiANCj4gPiBBbHNvIGluaXRpYWxpemUgdGhlIHRtcCB2YXJpYWJsZSBp
biBoZnNwbHVzX2ZpbmRfY2F0KCkgYXMgZGVmZW5zaXZlDQo+ID4gcHJvZ3JhbW1pbmcgdG8gZW5z
dXJlIG5vIHVuaW5pdGlhbGl6ZWQgZGF0YSBldmVuIGlmIHZhbGlkYXRpb24gaXMNCj4gPiBieXBh
c3NlZC4NCj4gPiANCj4gPiBSZXBvcnRlZC1ieTogc3l6Ym90K2Q4MGFiYjViODkwZDM5MjYxZTcy
QHN5emthbGxlci5hcHBzcG90bWFpbC5jb20NCj4gPiBDbG9zZXM6IGh0dHBzOi8vdXJsZGVmZW5z
ZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fc3l6a2FsbGVyLmFwcHNwb3QuY29t
X2J1Zy0zRmV4dGlkLTNEZDgwYWJiNWI4OTBkMzkyNjFlNzImZD1Ed0lCQWcmYz1CU0RpY3FCUUJE
akRJOVJrVnlUY0hRJnI9cTViSW00QVhNemM4Tkp1MV9SR21uUTJmTVdLcTRZNFJBa0VsdlVnU3Mw
MCZtPW5DMEhmZGh0eGxBUkxTM19DWjFobXpCSGM2akZOSy01Y1VHYnJVanVEYkxQRGNnUnZFRlcy
d2dqWk1JVHViZmsmcz1MSnk0c3NIVmtBaEoxTzZpd3ZJSG5ZNFhXbFJDLUVpVWRUQ3dDQ1MxOGow
JmU9IA0KPiA+IEZpeGVzOiAxZGExNzdlNGMzZjQgKCJMaW51eC0yLjYuMTItcmMyIikNCj4gPiBU
ZXN0ZWQtYnk6IHN5emJvdCtkODBhYmI1Yjg5MGQzOTI2MWU3MkBzeXprYWxsZXIuYXBwc3BvdG1h
aWwuY29tDQo+ID4gTGluazogaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3Vy
bD91PWh0dHBzLTNBX19sb3JlLmtlcm5lbC5vcmdfYWxsXzIwMjYwMTIwMDUxMTE0LjEyODEyODUt
MkQxLTJEa2FydGlrZXk0MDYtNDBnbWFpbC5jb21fJmQ9RHdJQkFnJmM9QlNEaWNxQlFCRGpESTlS
a1Z5VGNIUSZyPXE1YkltNEFYTXpjOE5KdTFfUkdtblEyZk1XS3E0WTRSQWtFbHZVZ1NzMDAmbT1u
QzBIZmRodHhsQVJMUzNfQ1oxaG16QkhjNmpGTkstNWNVR2JyVWp1RGJMUERjZ1J2RUZXMndnalpN
SVR1YmZrJnM9VllmXzZ2TjZfSW1kLWhhZllKYkJqNjJXd25sUE5kYWN4NzNXREx1c3NXbyZlPSAg
W3YxXQ0KPiA+IExpbms6IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/
dT1odHRwcy0zQV9fbG9yZS5rZXJuZWwub3JnX2FsbF8yMDI2MDEyMTA2MzEwOS4xODMwMjYzLTJE
MS0yRGthcnRpa2V5NDA2LTQwZ21haWwuY29tXyZkPUR3SUJBZyZjPUJTRGljcUJRQkRqREk5UmtW
eVRjSFEmcj1xNWJJbTRBWE16YzhOSnUxX1JHbW5RMmZNV0txNFk0UkFrRWx2VWdTczAwJm09bkMw
SGZkaHR4bEFSTFMzX0NaMWhtekJIYzZqRk5LLTVjVUdiclVqdURiTFBEY2dSdkVGVzJ3Z2paTUlU
dWJmayZzPXFqQXQ4R3hZeHdkUW5kTkVXaWlCeTJOUmhMQ3ZEY2FYZHZBRnY3eXhBajgmZT0gIFt2
Ml0NCj4gPiBMaW5rOiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9
aHR0cHMtM0FfX2xvcmUua2VybmVsLm9yZ19hbGxfMjAyNjAyMTIwMTQyMzMuMjQyMjA0Ni0yRDEt
MkRrYXJ0aWtleTQwNi00MGdtYWlsLmNvbV8mZD1Ed0lCQWcmYz1CU0RpY3FCUUJEakRJOVJrVnlU
Y0hRJnI9cTViSW00QVhNemM4Tkp1MV9SR21uUTJmTVdLcTRZNFJBa0VsdlVnU3MwMCZtPW5DMEhm
ZGh0eGxBUkxTM19DWjFobXpCSGM2akZOSy01Y1VHYnJVanVEYkxQRGNnUnZFRlcyd2dqWk1JVHVi
Zmsmcz16ZHlQZ3ctTDVNUzJ2WU9oclZHeEhmT2ZBdGpKa2pNN256R3c2SkpDMUdRJmU9ICBbdjNd
DQo+ID4gU2lnbmVkLW9mZi1ieTogRGVlcGFuc2h1IEthcnRpa2V5IDxrYXJ0aWtleTQwNkBnbWFp
bC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBpbiB2NDoNCj4gPiAtIE1vdmUgaGZzcGx1c19j
YXRfdGhyZWFkX3NpemUoKSBhcyBzdGF0aWMgaW5saW5lIHRvIGhlYWRlciBmaWxlIGFzDQo+ID4g
ICBzdWdnZXN0ZWQgYnkgVmlhY2hlc2xhdiBEdWJleWtvDQo+ID4gDQo+ID4gQ2hhbmdlcyBpbiB2
MzoNCj4gPiAtIEludHJvZHVjZWQgaGZzcGx1c19icmVjX3JlYWRfY2F0KCkgd3JhcHBlciBmdW5j
dGlvbiBmb3IgY2F0YWxvZy1zcGVjaWZpYw0KPiA+ICAgdmFsaWRhdGlvbiBpbnN0ZWFkIG9mIG1v
ZGlmeWluZyBnZW5lcmljIGhmc19icmVjX3JlYWQoKQ0KPiA+IC0gQWRkZWQgaGZzcGx1c19jYXRf
dGhyZWFkX3NpemUoKSBoZWxwZXIgdG8gY2FsY3VsYXRlIHZhcmlhYmxlLXNpemUgdGhyZWFkDQo+
ID4gICByZWNvcmQgc2l6ZXMNCj4gPiAtIFVzZSBleGFjdCBzaXplIG1hdGNoICghPSkgaW5zdGVh
ZCBvZiBtaW5pbXVtIHNpemUgY2hlY2sgKDwpDQo+ID4gLSBVc2Ugc2l6ZW9mKGhmc3BsdXNfdW5p
Y2hyKSBpbnN0ZWFkIG9mIGhhcmRjb2RlZCB2YWx1ZSAyDQo+ID4gLSBVcGRhdGVkIGFsbCBjYXRh
bG9nIHJlY29yZCByZWFkIHNpdGVzIHRvIHVzZSBuZXcgd3JhcHBlciBmdW5jdGlvbg0KPiA+IC0g
QWRkcmVzc2VkIHJldmlldyBmZWVkYmFjayBmcm9tIFZpYWNoZXNsYXYgRHViZXlrbw0KPiA+IA0K
PiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gLSBVc2Ugc3RydWN0dXJlIGluaXRpYWxpemF0aW9uICg9
IHswfSkgaW5zdGVhZCBvZiBtZW1zZXQoKQ0KPiA+IC0gSW1wcm92ZWQgY29tbWl0IG1lc3NhZ2Ug
dG8gY2xhcmlmeSBob3cgdW5pbml0aWFsaXplZCBkYXRhIGlzIHVzZWQNCj4gPiAtLS0NCj4gPiAg
ZnMvaGZzcGx1cy9iZmluZC5jICAgICAgfCA0NiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPiA+ICBmcy9oZnNwbHVzL2NhdGFsb2cuYyAgICB8ICA0ICsrLS0NCj4g
PiAgZnMvaGZzcGx1cy9kaXIuYyAgICAgICAgfCAgMiArLQ0KPiA+ICBmcy9oZnNwbHVzL2hmc3Bs
dXNfZnMuaCB8ICA5ICsrKysrKysrDQo+ID4gIGZzL2hmc3BsdXMvc3VwZXIuYyAgICAgIHwgIDIg
Ky0NCj4gPiAgNSBmaWxlcyBjaGFuZ2VkLCA1OSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9mcy9oZnNwbHVzL2JmaW5kLmMgYi9mcy9oZnNwbHVz
L2JmaW5kLmMNCj4gPiBpbmRleCA5Yjg5ZGNlMDBlZTkuLjRjNWZkMjE1ODVlZiAxMDA2NDQNCj4g
PiAtLS0gYS9mcy9oZnNwbHVzL2JmaW5kLmMNCj4gPiArKysgYi9mcy9oZnNwbHVzL2JmaW5kLmMN
Cj4gPiBAQCAtMjk3LDMgKzI5Nyw0OSBAQCBpbnQgaGZzX2JyZWNfZ290byhzdHJ1Y3QgaGZzX2Zp
bmRfZGF0YSAqZmQsIGludCBjbnQpDQo+ID4gIAlmZC0+Ym5vZGUgPSBibm9kZTsNCj4gPiAgCXJl
dHVybiByZXM7DQo+ID4gIH0NCj4gPiArDQo+ID4gKy8qKg0KPiA+ICsgKiBoZnNwbHVzX2JyZWNf
cmVhZF9jYXQgLSByZWFkIGFuZCB2YWxpZGF0ZSBhIGNhdGFsb2cgcmVjb3JkDQo+ID4gKyAqIEBm
ZDogZmluZCBkYXRhIHN0cnVjdHVyZQ0KPiA+ICsgKiBAZW50cnk6IHBvaW50ZXIgdG8gY2F0YWxv
ZyBlbnRyeSB0byByZWFkIGludG8NCj4gPiArICoNCj4gPiArICogUmVhZHMgYSBjYXRhbG9nIHJl
Y29yZCBhbmQgdmFsaWRhdGVzIGl0cyBzaXplIG1hdGNoZXMgdGhlIGV4cGVjdGVkDQo+ID4gKyAq
IHNpemUgYmFzZWQgb24gdGhlIHJlY29yZCB0eXBlLg0KPiA+ICsgKg0KPiA+ICsgKiBSZXR1cm5z
IDAgb24gc3VjY2Vzcywgb3IgbmVnYXRpdmUgZXJyb3IgY29kZSBvbiBmYWlsdXJlLg0KPiA+ICsg
Ki8NCj4gPiAraW50IGhmc3BsdXNfYnJlY19yZWFkX2NhdChzdHJ1Y3QgaGZzX2ZpbmRfZGF0YSAq
ZmQsIGhmc3BsdXNfY2F0X2VudHJ5ICplbnRyeSkNCj4gPiArew0KPiA+ICsJaW50IHJlczsNCj4g
PiArCXUzMiBleHBlY3RlZF9zaXplOw0KPiA+ICsNCj4gPiArCXJlcyA9IGhmc19icmVjX3JlYWQo
ZmQsIGVudHJ5LCBzaXplb2YoaGZzcGx1c19jYXRfZW50cnkpKTsNCj4gPiArCWlmIChyZXMpDQo+
ID4gKwkJcmV0dXJuIHJlczsNCj4gPiArDQo+ID4gKwkvKiBWYWxpZGF0ZSBjYXRhbG9nIHJlY29y
ZCBzaXplIGJhc2VkIG9uIHR5cGUgKi8NCj4gPiArCXN3aXRjaCAoYmUxNl90b19jcHUoZW50cnkt
PnR5cGUpKSB7DQo+ID4gKwljYXNlIEhGU1BMVVNfRk9MREVSOg0KPiA+ICsJCWV4cGVjdGVkX3Np
emUgPSBzaXplb2Yoc3RydWN0IGhmc3BsdXNfY2F0X2ZvbGRlcik7DQo+ID4gKwkJYnJlYWs7DQo+
ID4gKwljYXNlIEhGU1BMVVNfRklMRToNCj4gPiArCQlleHBlY3RlZF9zaXplID0gc2l6ZW9mKHN0
cnVjdCBoZnNwbHVzX2NhdF9maWxlKTsNCj4gPiArCQlicmVhazsNCj4gPiArCWNhc2UgSEZTUExV
U19GT0xERVJfVEhSRUFEOg0KPiA+ICsJY2FzZSBIRlNQTFVTX0ZJTEVfVEhSRUFEOg0KPiA+ICsJ
CWV4cGVjdGVkX3NpemUgPSBoZnNwbHVzX2NhdF90aHJlYWRfc2l6ZSgmZW50cnktPnRocmVhZCk7
DQo+IA0KPiBTaG91bGQgd2UgY2hlY2sgZmQtPmVudHJ5bGVuZ3RoIDwgSEZTUExVU19NSU5fVEhS
RUFEX1NaIGhlcmUgYmVmb3JlDQo+IGNhbGxpbmcgaGZzcGx1c19jYXRfdGhyZWFkX3NpemUoKSwg
c28gd2UgZG9uJ3QgcmVhZCB1bmluaXRpYWxpemVkDQo+IG5vZGVOYW1lLmxlbmd0aCBhdCBjYWxs
IHNpdGVzIHRoYXQgZG9uJ3QgemVyby1pbml0aWFsaXplIGVudHJ5Pw0KPiBoZnNwbHVzX3JlYWRk
aXIoKSBhbHJlYWR5IGRvZXMgdGhpcyBjaGVjayBmb3IgdGhyZWFkIHJlY29yZHMuDQo+IA0KDQpJ
IHRoaW5rIHRoYXQgaXQgbWFrZXMgc2Vuc2UuIEl0IHNvdW5kcyBsaWtlIGEgZ29vZCBzdWdnZXN0
aW9uLg0KDQpUaGFua3MsDQpTbGF2YS4NCg==

