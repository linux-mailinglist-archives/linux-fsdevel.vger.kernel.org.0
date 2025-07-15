Return-Path: <linux-fsdevel+bounces-54926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1DCB05533
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 10:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4386D1C210A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 08:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D12273811;
	Tue, 15 Jul 2025 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JXeJFUMT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cfIVWalr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C796E275851;
	Tue, 15 Jul 2025 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568970; cv=fail; b=hQOedTwgMHajE48mh762JK+EVBey1SjMiblidKMLreTDyeHiAtrYyvPeH4pavs+Txl5Z7/+mp86lZ0qKUc26Ttg9QxcMaNfqqK5JLt9r0aWiWMfJd16Y5uns5ryHXIN5B9IxMYAwesFi5WtVhdJJwvjgmWgy/hc7vDii3p1q/Gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568970; c=relaxed/simple;
	bh=EPbaZCNFZX8fvLdfVYuHPUU5BBBIRsQ/yGMzKfmeY80=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FtbrQeNUIcSmTj0vqb2zl2Skc18GYSPvazIrwlSufs2ec6zCwbdB06KVAx6AI8F98xqU1whKWHClUQtGZsAV/4YHb0nGPzkQmJQZ2yaBrW5fOMwr1pBE0aLTSrGyw4k/2gn+9N0KD8Ftfacjb6mBYVns+OBt6mOJfYsBtDqzjO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JXeJFUMT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cfIVWalr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F1YqMX016917;
	Tue, 15 Jul 2025 08:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZQnXT78mhGtTPMpekPTlNVMQPiwf3ZZo0GF8+zvv684=; b=
	JXeJFUMTOWiihkviKt7chhy9FkAPyQDpZ1SyXDHqi+H4qKc7xdhKhmzbpaaDjI7B
	Qjb1j/PmmpBZWffs10gEy+jOgphfZKDHPvccQ4OQNlflUzPj9ibCkGO6gdTIpVcI
	JFdGzFccaJ6jrDhYGH+EaNOfLjOhkbsYRqFdZc6UCaJLAXnMACS91GQZ2FmF5Jx+
	d87mzDtDIWTG/nG86iHFl35J3YZbDW80L7gnCC2/xk9hxAu+byfuoLXWhRCr3e0s
	8RGbQ4nwZvEZq09CuPa0jCZlnrO5G4fRsxNpXumau8J84jNAhZ1Ca7Q/sqNblxmw
	m5UeKhOaeuXzRcjgsf9ciQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8fx7et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 08:42:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56F77fgB030340;
	Tue, 15 Jul 2025 08:42:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue59nrsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 08:42:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPjfrA4i+B7OACPdcqShetUadC20nGlI5u6gWXV2PmwdggXpSlvqxJzO9MO7yUCicT5kyZLwXkgWV+pojEuy5VmfZuSJzoAINVNjjvAGv41GpgLVwiT3LhRz6h8F5K7NxKyzhLxnkJUw9u7v3ZRyf4Z/ZZPPNFbud7Xnxe6QiWTbIcBrg/+JBY7r3dkLMAihaH2+XJieBm0We7vSg+beaarc9B+eKGVoyn4fVgNPNox6H83zHKEZDwLLEnkGdaf0VlUY58Ai6U8nJQfcpLDL0BDRxRCa6khe6ici+kbL+Lc1QnEPbI1cJcZ9xIhWxZdhgDRU/RcRtIP9umpgejgZrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQnXT78mhGtTPMpekPTlNVMQPiwf3ZZo0GF8+zvv684=;
 b=lACIbEa9BGd9PJK8spndJlc9j0iTDC/SFUSLgZhVkPZ6I25skeNubrXfSZ9qbn6HPD7HNHqaarHxgIZ3foPz53cd05JmWemxYw+AQy1ksQvmk+aRGB412BXenVJAl7Fh5cVXeWOP5CCaMoayUryTq38j7AVZH1NhuhNpopv/DhCk97nTM1+IInKlMJlMFQ2VIRW0yXDZH1WIMFrYhl3I9L1eOpsm1WC8C5MLnmhkhCXYHW9SY4VmUV4kluPo+YGEjjyYIccCpc51nRzU2UJZBI9BBWUnrO2qa6T4lIP0X4Dgsj6IzEKYGpVocF6wzZKtlU2/J61myvHkrVBME+QeYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQnXT78mhGtTPMpekPTlNVMQPiwf3ZZo0GF8+zvv684=;
 b=cfIVWalrze0jeEh1x07aflby6QNL5ddFbmjPiMDlJ6d5D6aV90jyd6Gw73fQfUH26IynN+hfjv5NV+rrnhi0e/8ZBbAn9QQpGZLNosnd/YpAbCrbS8OiOLBxJRFuoGE7fTGBi53W9E2LkN4HaOhaCRN5s3ro/Wn2CoAMbDS+OlI=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SA2PR10MB4636.namprd10.prod.outlook.com (2603:10b6:806:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 08:42:36 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%3]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 08:42:36 +0000
Message-ID: <072b174d-8efe-49d6-a7e3-c23481fdb3fc@oracle.com>
Date: Tue, 15 Jul 2025 09:42:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
To: Christoph Hellwig <hch@lst.de>
Cc: Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20250714131713.GA8742@lst.de>
 <6c3e1c90-1d3d-4567-a392-85870226144f@oracle.com>
 <aHULEGt3d0niAz2e@infradead.org>
 <6babdebb-45d1-4f33-b8b5-6b1c4e381e35@oracle.com>
 <20250715060247.GC18349@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250715060247.GC18349@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0022.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::6) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SA2PR10MB4636:EE_
X-MS-Office365-Filtering-Correlation-Id: fa555253-ef36-462c-ff24-08ddc37b8c8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qmc2UlByaVNiSEFOTWVrc2VhSHcxVk5iUTVQOGJMYzlaYjdFWkhXUU1NV0xE?=
 =?utf-8?B?MHYvYkRmL3J6Q2RXOGh2WVFYRU5RcEk3SFROUXMzbnduNUIycHc1c0l0TG5o?=
 =?utf-8?B?TTkxaFdLNWhpRm9JVTNRYncrWHVmVVRVKzlqK1crcCthSGZ5TjUxc0wyN3hY?=
 =?utf-8?B?SE1ZZ01XTEI0QnNXMTlKd1RQQlh0TTdhT29HdDU5VGRnMDdyclRRNDV0YXp0?=
 =?utf-8?B?Qk5DQ3BGaFVVT3p4b09ORUd3TUx2R3ZBSWFXT1VhS21YdjhtSXpnVlU4cGpt?=
 =?utf-8?B?bUJVUXFhbHVkYmlIaWtEOWJ0ZWlNR29CMEhxMHVZd3NCTVRJWFNtVS9mc1Y2?=
 =?utf-8?B?WG0rN09UZjRxbks3eXVjeUFxV01nRWM5Q3lxVFVidnhyTEZtNUlra1BHcDVm?=
 =?utf-8?B?aWgwNlFaZG9nUFJNZGFZMGJVSUQ0MG9rV2hGbDhsMXF4bU1ybE9TQWpOb0VT?=
 =?utf-8?B?S1J5UGVrUzRlSEx3ZTh1L3c2dkpBaG5yM1Nnd0g2K0NpSHhJRndwOGhWNUo3?=
 =?utf-8?B?c0owYXV4bTFoZU9maHZnR3ZxRVM2TGdDVmpiRTVySVdGOUw1d2V6Z0xVZzk2?=
 =?utf-8?B?M1FmbnVjUEJ4elNPNzNaMWxqVHFBWUtyNFhJQm9TaUFkb3hzZlQ3NE1qU3Rm?=
 =?utf-8?B?a1pkZzF1bTQyK1lvNzEyQStzSlNISk9kVG5Rb1dJSEVhWnBIZVBZaXZKc1ln?=
 =?utf-8?B?SEUyRkNCNmFNRWhWejFSbFFGb2NtRy9YaVp2TkRyQWxxTlQrZkF4eDR4ck0r?=
 =?utf-8?B?dVlYbW91UDYvZEh2MU5tRGdjTUFjTndQVVZQOUd2VG1tK1I5TzJuYTdyZ2Ft?=
 =?utf-8?B?YjI2QzdJUDJ1bU9LOGhpOUgvclpZaEl6ejViczlNUW5OYjd1c0QvakRtSUN3?=
 =?utf-8?B?d1VycVNYMm5WdjI3M3pIODFqV0xyeTNLWjZ6dU1XWHZxdTY3ZUlyN3hYWmxh?=
 =?utf-8?B?OXE5ZUo1cXlJNVdrMEcyM1NjMEVhdXFvcXdXL2ZUTUY4SEZoVkMzaFZpa2pN?=
 =?utf-8?B?THAzSHQvNml2REJqSzg5T2I1RWFmM01iekxGQVdJR244N0NPKzBKODVUTmdx?=
 =?utf-8?B?WE5zZlRVbmJPTExOMzkvVDR2L09yM1JqSnQ5TDNFUUVOSm5VbTUveXpQSFhU?=
 =?utf-8?B?QldiMkR5dGgxL3NpT2JJWTFJY0thQWRYR1ozb3REcWdHclVVSTBNSFNmU0pj?=
 =?utf-8?B?ZDBSaVM2a1dSalhGY1RSQ1Q0ZzdPZEdycXJ3OHhwbTYrMzF6eFNrR0Zsd1lY?=
 =?utf-8?B?L2tJcHRqRmM1cEdyeVR3MjllR25iWXpvY1dlNDVFRmhoRmJEdk9rdkdYZ2J3?=
 =?utf-8?B?NU1sZEFDdWxYMWFyQUphcHdoSytDSUc1eGRUc0o0UjRpbEQ1RWltTHgrZlNO?=
 =?utf-8?B?K09JZG1WMHduTXJ1MGEwbmVwVFpxOTZkUnZuT0JCQmRacFg4U2p0MGZaWjFo?=
 =?utf-8?B?ZkhURXZyeWQvcDlYMWpHSm5XRlJ0TTdXYjdFbXl3SDlqZncybE5tcmt5OEJw?=
 =?utf-8?B?SkxxMkovOFErZmttMEtUaTcwUml3RDBGKzI0RklZZ0dNZE4vNldtZldoVklN?=
 =?utf-8?B?ZWUySkRtVXVsRk1wWnI5RlZrN2YzcWdFc2FpUnRuYzBSUW45ZUd2bmhlTGhN?=
 =?utf-8?B?OHlIb0kvZ293ZWgraE11Mjl1Z3ZtQUJnay9QN1NQU2RlL2IwSFRoZ2pQZXZU?=
 =?utf-8?B?YmREY29JZEpvYjNpWEVCVzJ5Znl0blZ0dFhxOGw0QjRxalJNdmVsZjNMbGR1?=
 =?utf-8?B?VkQvdFhQMWwvenBEUFZOM3FPQ1JCd0NVUVYzV3ZscmxaOFUyenlvT3JNUzVD?=
 =?utf-8?B?VkJFR1pKVFh2L0NuV1VYeWx1Wm16ZHpDTlRLZlFoVFVGSmxwcm5FZVgyVDk2?=
 =?utf-8?B?YkgrdXhzMmZNcnlQdU1jUDN2Y2JwRmxqaHcydXdBTW1lY2kvV2VBT1dPVFgr?=
 =?utf-8?Q?BndfKfq9D4o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TW43dDBmVUp2ME9hWjduNWZCdU1CZXJ5TFNSNUpzSis5aHJtNHoreFhFbWtJ?=
 =?utf-8?B?Ny9OU3NIZ1Vmb1BlR1FGMkQzZUtoRWVQeDc2SnpsZC91bTUvLzU1NkhtU0R0?=
 =?utf-8?B?SEduclhHS2ExcXVMSzlERGpQbzVMQ1Bhak1vOWFFZ2ZZUldIZUxqTHVLTm5H?=
 =?utf-8?B?YjQ0ajlIcnA2Y2tCbXpNbFB6THZ6aUZNc3VnK0NsNzFjNk95aUgvOWk2dTlo?=
 =?utf-8?B?OHM3cnJXV1BFRE5NRGZiUEtxTG01Z1VLUm5veXoyT1grY2tKOFFxREJuZmlH?=
 =?utf-8?B?MEdFTjZzWVh5ZEVsaXFtYTg0aUZVUERONXA2TFNIL091T1prR1FrNTJ1TGh4?=
 =?utf-8?B?Y2c1V25UanluaG9WYWxUTlhUWGk4aG13NW1rakd5Mkk1aGptVlN1SXNmdExC?=
 =?utf-8?B?QTRud2FDVktqcWpmbFpRQUdIUjJQYThnWE5ybHZBYWF0cFpjUXZVV2xGWXVm?=
 =?utf-8?B?bWJSREN3WWNVQ0cwQ2hwaG5ZQWFXWXd6d1NBZHRGZHFHN2VSaHA1NFBXVVVK?=
 =?utf-8?B?WDlkZlA0bWVpbnVTb2xvMnR5aGRyd3RScWU5UkIyRElTNk1uUXBjRTZ4M2p1?=
 =?utf-8?B?WkEyK1MxekNOY2pJaUpPTURNV3VsU1RZaWxBdEVrZXU1U0V5L09xVFZRNy9o?=
 =?utf-8?B?MTZJOWh0Sm5TZ0pQTTdYYWtCWmcrNkpITVA2WXpwS01FZjVZeU9zWE50N2Fu?=
 =?utf-8?B?VkdpZFUrRGlUM3B1YzBTT0RSYUJqMVNiR2R3MnA3U1JOd25KaU56RVFJcXhT?=
 =?utf-8?B?Yml4b3FPUE1DSXR2MFhlQ0F2UkJTbmU0d1dXNW9rbzV4Y2NxTGV2WUo5Qmxo?=
 =?utf-8?B?dkdRRDErRW5SOXhBTUNBWDlDSzYyTmp0aUFHN0Vjd25oT3Q3K0hndDBkM0k3?=
 =?utf-8?B?M3REemdBaVFKOE96WkY1azRMN3QvcnpBbjY4eXBIbVRuS2tFWVBzeEx6NHdH?=
 =?utf-8?B?UmhoZlRac0NQQmRuTXFXNmdzWHJFMDVaZnBaaEtubEljdHltdkZXM2lVZnVq?=
 =?utf-8?B?cC9nV2lRdmZESTR3ZDZFdU9jVEgwV0xCV1RIY2Fxd2JsOGtyc2ZoWi9BV2NT?=
 =?utf-8?B?c1U3Y202RFRzZXd6YUFhZVFjRnkxMkVIa1FsampreWNxemdUc0huZGNrL0RB?=
 =?utf-8?B?S2ExcTd0Q2lGeGthTzdkLzlMNm9KUUo3L3FraC9xL21SMmc5a2tZUXpjcVE4?=
 =?utf-8?B?cDBkTFFNT2RRT3BWYXRlVncwVWh3cTFyMjA4eE8xb1ppTnhaR0NwbFNNbzlK?=
 =?utf-8?B?Wm8xSURwNm10Vk9ERXp4a3hHUVVjWXBYN3VuY25QeVo0V0pobjUweksxK3I5?=
 =?utf-8?B?bXAzNnl0ajJGaEdnSmd4NFB5bVFHZ29ZRUZ4QkFFVXF5elpDVXh2OTdOSEN1?=
 =?utf-8?B?bWZ1MW5WRDJRUjl2MVpDOEg1YmJqdGtmOVgwRHN1L0tWck5OL1UyVTNyYlZy?=
 =?utf-8?B?Tmpoc2ZodWNYQ0F2WHFoRytETVV5K1Y1TUxXeUN5bWJWVVpaZG91bmduRGJy?=
 =?utf-8?B?TjYzeklmdHhJVFNuQmZEZ05iVjBSSytXVnpVZGdnYk5veExRNWs0dHYwaDNu?=
 =?utf-8?B?UlZsclhDSXZXWDV2YXRGNnBEQTlOZG1NdDVYSU1WTFdYY3hvRkI5UEIxYURV?=
 =?utf-8?B?T3VTRjZnUHBuWE1mN2dqSUF0VHkxN0xkcno3a2NONGpocTliTnJxNVJSbVAw?=
 =?utf-8?B?Y3k3a294TytJbUdwejJFWm01TkdMOHhOS1JGNGxSMGJrWitqQkVJOFlENDll?=
 =?utf-8?B?b0FFZVk0UExKOWUzc0piK3FjMU96T3NJVFRoaEVWL0tqclRveUhMWVNVSGE3?=
 =?utf-8?B?c2hQVXNCSC9xU2Raek9pZ2poU0NBTm9CSjN4cEdTWUdPZnVpVnlXNlVwN2lx?=
 =?utf-8?B?N053ZTRiMWJVZnNsdEF5NGEwUkluMlBDM2NNSjFaVkdzU2J0dC9KU3ptdVh5?=
 =?utf-8?B?aHZWV3RqeVBkZUkzU2JIQ01UcWNCeVNvZTluQlNxblFFM21NT3BoYVpkSXFU?=
 =?utf-8?B?blpybGxFWEFGdDE4WkV4a1pnRUYwT2JzdUE1Kzk3U3dlMHBNNjNSbVVZNmc3?=
 =?utf-8?B?aWNEY2gwOFhiSVRFcVdMSlFDbWZVaWM5NXNOc21zWTJkd3J5bmhkeU5JSWtV?=
 =?utf-8?Q?1EfvxHCDsBzBsoz6ZcGJ9INcz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xMhcJKBS/JMT3v9SuePIEMgfbLkBfvRiUz2ujMuoc9j4z5XF09VK5sZdtG38eB/1SrHgmuQiDdC9ByGIRwLL4mlbFBKBgu9T7a3uVHWPUzJx4EYPDTeWas6ABi8r8rCB8PwArhDAX5kp9y4rKF1HIBDkXCZdelQ1Q9GKvjrFUPbsddXY9h4XJWUGzq3tkxAwIuk5FCX7o4slKgLH6Dbvgrk+u9rTx/mraNbJ7FhHLtNN5CExJPC4yNdgjlX0QlepIpushMF4TV/yaESXY+17WvJ181sT/vac9LgOwUmkchm8UPjZiTXZs/8r8KZhnvmpOcEsFgNgzMMk4gFluIizZcM479tlds5rB1TMcSwt02Z72NG4TwGMSPUiEPQsvtWLT53b0cwPSO4SbMOh5LLLuEu04VqTd6abXxf7+nEvbQ932U/BU01p+i1fWZZTeDgBcneJjwPVjLQlmxkheekfRJZu1oMYVEU3G9aNae8CQxUwl5L//joiBVisnnxBvVbGIo613MvzLAiJ1dqLNp6bDqIlqSylQeMbNxNGBqOpQ19mCYnGrBddYr+FoLpjeq2r4RYufO9OhFpM7Nks9UpEVIQZLFSOfMiUsX/lLLsOBmI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa555253-ef36-462c-ff24-08ddc37b8c8a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 08:42:36.4875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Llf0eP+8PQRhzgR18u0JTS7/tuMxIdk8VsQ340iFf6qsOijYwpaMr3kF2+pmTEuw4Jgtq6rM1mnCN344tdlqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507150077
X-Proofpoint-ORIG-GUID: 0q2FnpbU85ak1nl5DPEyFlgWv7cBrsVn
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=6876147f cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=kLWA3gBXtu5QbDPQ:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=63FnPaHG_3DZsO5HsgwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0q2FnpbU85ak1nl5DPEyFlgWv7cBrsVn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA3OCBTYWx0ZWRfX6h25ISBQwGiK bHo+CvMNieD2cbAEkzeSi8A5wRVz51epNc9kTjEG0Q+A0aD27GR5Lciy4Mf8lUUZ4lk4wxG0DxN quCk9NssWvLr7p5FIlMPTf8AIsGphnvvnhBQV/w7ik8autcOAGemnRRcE5Twr6h28m5wYOMVJ71
 ul2nslI2QNrQ6KgLweRC617hx6vTcP3FW3nx7qH3l0oXBbIUun/rWFzJGXXJyixa2Z9mA17xPqS nBUmdMDjuAAqRmgKWOT8Wi9d+80Qth4pnOSp7dn+6TzjXVgYqzwOOyV6TViaUvCZaAOOrjU2WGn aqGp7O6rXESdSGGnIGu1tWEE8QGZ6ZCMlC9TQuXILc9K+Xh8UhGkQfddO4/NLsoLGQDZ2bmnbVb
 Sd1YXuGplWowM9YH/84BLy9kkO0+jy3Xze6OahuSfRO501WAaQ1BHzP5WrcwdlpHSH3TZav+

On 15/07/2025 07:02, Christoph Hellwig wrote:
> On Mon, Jul 14, 2025 at 04:53:49PM +0100, John Garry wrote:
>> I see. I figure that something like a FS_XFLAG could be used for that. But
>> we should still protect bdev fops users as well.
> 
> I'm not sure a XFLAG is all that useful.  It's not really a per-file
> persistent thing.  It's more of a mount option, or better persistent
> mount-option attr like we did for autofsck.

For all these options, the admin must know that the atomic behaviour of 
their disk is as advertised - I am not sure how realistic it is.

Apart from this, it would be nice to have an idea of how to handle the 
NVMe. About this:

" III.	 don't allow atomics on controllers that only report AWUPF and
  	 limit support to controllers that support that more sanely
	 defined NAWUPF"

Would it be possible to also have a driver opt-in for those controllers 
which don't support NAWUPF?

Thanks,
John

