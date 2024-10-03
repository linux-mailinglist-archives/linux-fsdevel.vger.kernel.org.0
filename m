Return-Path: <linux-fsdevel+bounces-30883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D346E98F036
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 15:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3543CB21245
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 13:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBBF19C550;
	Thu,  3 Oct 2024 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UIi7SQvR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SaLzHgyq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A645119B3DD;
	Thu,  3 Oct 2024 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727961590; cv=fail; b=KYflNNIk+MKCaoy0+u2Kv6Oaem/DFYEKEq+DTILNtlQAbU611HFM4eyM4HVp450RcwkxnzmMuiIqei+yGClmfgeVBW7ywXn9GrKIND4vn+ojqyUSPQ0qwme4YqZ2d9k5wrtliEsXZhGNIrF7DUwzaThJ738AGPE4zMMaYbp2bRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727961590; c=relaxed/simple;
	bh=FmwEdkj4EE9iZm6RlBMWMg0hjEpZ62nhFx9BtQS+Cs8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GI2KqBF0npdM8INdPxqDyAWXCwoK4ImXoZ8OHXnYH352luJew7MwdESqkSmc7hlUr+NueOmo786HqtOTfzDGAkznBRWERorIJuk/MpORn+JCe8PFS2Xx6bWhMB+dEsP0h7dYn6eLQ7TcqptY33KhJPG5HfqCJBKgJvzqvkH8hHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UIi7SQvR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SaLzHgyq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493Ctjn5019386;
	Thu, 3 Oct 2024 13:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=ooqqsuXLRvQwPs995XGBHT2aIj92zU50p0Oa0fmtndg=; b=
	UIi7SQvRdjYNSrUG82dbOL13arN6tQlMVB3fB6qB8YOuqEBPZbOkYWXF4PQKI6p+
	DYbBfLgpaIjymh2JPtINTXFfNtAU41Tj0vkyXovJegTor1tVURYS/+Yu3yubbNc9
	gaWegb0nIhJCDRdcjZsJh576uCy2MaUPd9VazEu/f6U369sKjlM6j5PxT+S2i0dk
	DX7B+y0oMpUQpredtoiiUxI8lW3jGKsaO8D761VXJihKCKbq77xn5g2hDhUEnpKY
	gisJXtZUaeGQ27Wvr3en3fCmHhmtvOYe6JCJ/vqHhZ1JNWdyr9dsQhMjASv2hkjU
	qBFXCvN17Hew4JUlvIKBMQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8qbc2ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 13:19:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 493BSXcA039328;
	Thu, 3 Oct 2024 13:19:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x88a8exa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 13:19:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWuK3KoVwVgDAifjmeArdMQKu1sUu1gxl6wIl6EVZYFjv/URcFMrx0SXe2kVUyHrPhkvEki/Y1NWHvAyfLiONYiYwLERrDTCReo+4gu/5O4rQZfHT7wsryAVwon4MOinegKfgt0m1o7351WH5jjEk/D7qfbLrQOjHhqnOnYEPnmPoUCqIs0Gc9AarffhWPW0TqYOPtkFkBEMucjzNGOdb/ogENgo/nZ7+kenOkwEz2piPpw2Gr/oz99j13I50E0PdgxHpkGKvgNQvtisEH0RqcAIR7GiUL/u4PSwGLvWMPhLC0AGF52gzpwMeob9sih7UPARjuyBMJC9mZ/3hpGWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooqqsuXLRvQwPs995XGBHT2aIj92zU50p0Oa0fmtndg=;
 b=Ha5FnDsvPL8SJ5xXYXbsutK6s+I5rsjPJuhhRIvaWMS7hgST4QOnFTjPU2vQ1t/PxGJnuTo6F/CS1C/MzMlIYb/RvYpTl6CRy0hsN6lO/KovP+CeZKGOjRngKOaKJmAlW82MJb971YaWFmSLwa2xbrA9tQsOA0ifYorPZVX41jnSub1j3cJHQ948YJMKbtU4Ybv6BXUQ3nafRQU5wBXZXNtHhIeuL/ai6Vw52nF8n37Nrj95Wd0dCPo/UsVZKOgt1mFkID3aWmO+1t59lsUbIo0MQLo34/cyVhnbMAV0t/YYFb1k1T3CAOMa6KRRa103gGT9ptA1Y1TDIBB1hSuwIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooqqsuXLRvQwPs995XGBHT2aIj92zU50p0Oa0fmtndg=;
 b=SaLzHgyqPBy02UeNBccNoE6BQ6+q0oh5edLT6EbSDg8/vZBqc82cGFPrPyFo9US6xZHxbfp/FCET3jOLJbo8YqOB3jlNmH5dK9Cw33DlueZxzu826CYZ5N97bSYM9VuBELgcd9IiYFXUu/3JCVrK+0Jtz5z2m589+bM2YAbPlZI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4682.namprd10.prod.outlook.com (2603:10b6:806:110::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 13:19:13 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 13:19:13 +0000
Message-ID: <e934a4aa-0ad9-44ad-a233-2090d3f89805@oracle.com>
Date: Thu, 3 Oct 2024 14:19:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] xfs: Support FS_XFLAG_ATOMICWRITES
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com,
        cem@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com
References: <20240930125438.2501050-1-john.g.garry@oracle.com>
 <20240930125438.2501050-5-john.g.garry@oracle.com>
 <06344e9f-a625-4f6e-8b23-329ee8ebf67f@oracle.com>
 <20241003130258.GA18099@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241003130258.GA18099@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0037.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4682:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd6cd20-253a-4fb2-da19-08dce3adf966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFFVdWY4clNWZW1jUEQ0Ykw1WGZYL1M2d2Y0NVBBNlZDN3o1RDZrcXZ5ZG9r?=
 =?utf-8?B?M05udHJPR0ZoK08ybjhURVRUa2o2Y05TTWczY0tuK0s0Wi9RTENSMU5LMndy?=
 =?utf-8?B?Qk9peFRYYzd0bUoraVg2NjJucnZhSGVDY3hZczh0M3hUUXJxamNoSmFpN21v?=
 =?utf-8?B?bC91QXdhbkx6Qy9DZVc3U2E0SUQvMEN6UUxhY3doWXNGbWI1VGdBMzg3WVcw?=
 =?utf-8?B?M2FQSEw4WHRBVFA3V012WDNYZjZ4bmVnTmFkZUlBQXFWaXd6dVI1dTFuY2pM?=
 =?utf-8?B?clllTGt1YTNlZEFFd1IxaTlzU2MvNk05SlpSb1BORm5uUFJMK0JPeDQ2V2dm?=
 =?utf-8?B?cjZmU1dFTVRsbHpYSkFHSEdDN20wWURmZG5ZN01wM1FPTWZEOUJFVys3NGJZ?=
 =?utf-8?B?NURkLzJwY0RSaVQrdzVlYmx3L2trTHU1MWU1ZkM4b1IybGtaUmVZaURSQ1Vw?=
 =?utf-8?B?Mjl1YTVONXF2QVRVY1NXdHVpeUwyKzk1d1NxOUU0UERQQldlbHJnWURnR2gv?=
 =?utf-8?B?dk0vRlIzNFl6d1pYc2JXVlVGWHNXVXFHYmRGMTBoV29DdmFYUGFJbVV2ZDVk?=
 =?utf-8?B?RXFBemhyWi84SUJ1Zm04WWg1ZGpSTGk0L2c5UzlPdDdyWk85ZmlnMElJRDNa?=
 =?utf-8?B?TWFhMitGdHdvUFE2UVpLZkRPVkZ2NVg1ZC9CRSt1T1RHdzFYVUNNby82M1hE?=
 =?utf-8?B?SGpDbGt4NEczNXFNUjBZWVdjc2FlK2lRZkdONWVBMFFUMlEwLzQ1K3MyT3px?=
 =?utf-8?B?NEJpT3d3MHdpbEpvQ25LVDhtY0FibVpjOVJrU3cwTkNEbFJCSVBYSFU5OTlX?=
 =?utf-8?B?NnJodDVFajNpSjlwRDlnRk4xVVBibkEzcTNMUzVTcmVSUkxLMVRCNlhuNG5p?=
 =?utf-8?B?cVVEaG0rUHA5aVQ4cDhra2gwRUF3MEFDNnFvazZCMzNSZ1owZTNtaU96QXRL?=
 =?utf-8?B?d3k5TFBzeC80L1JqQ3NFRDkxMk51N3dkbFBFNnpUQ2JSakZ1ekJtV09iTEVu?=
 =?utf-8?B?cEdVMGNZTXdDRXJwdW1lMmFGZUVHVTJoR21pS0daaWVNejNxZ3NUL0xXcWRM?=
 =?utf-8?B?bG1CNTVOSWE0Tkx1d0F5NGpJRlRtdFlNTXI2eHd5SDhMeFNYOGphT3FhWDlo?=
 =?utf-8?B?dEpXY3F2c1dOZk5EaW9mRmNGaENJWnhBTGJCNHk5eDhRczQzandENWhKbHFu?=
 =?utf-8?B?UWw3SHFyUHc2YzlPSlpITENhdEc5c2loY0srdk9iZVVZUlQveXNHck5LbENq?=
 =?utf-8?B?RFJ3dVVYYlY2d1VVbXZUTitBb1Q0aDBMZ0N5R2xVYnZYeHk4eThkR1lvZm5q?=
 =?utf-8?B?VHpqdXpsK3JzL2k4Qkl0OGh6Rzlob2xrS2NEV2ZUK1BjOHBWYXFSamZvTkV3?=
 =?utf-8?B?WVVzYUpQQytmaGdUT2pWVGdYakk4eFNoZXRRUDZ5RjlKZm5ieDl3WVRjU2wz?=
 =?utf-8?B?OVh1c0VPZjNLaXpyREx5cEQvWmJzekdnM3hxMXVsa1BLby9kVFE0a3BHaGp1?=
 =?utf-8?B?REQ3TUpjbnNjdnpoZjlXMEQrWG5aTWRQdzg5NXFsUHZ3QjV4aUNkRExIYjJR?=
 =?utf-8?B?ZnZVQmpPQ3Q1cGx2cFRHS1J0YmlrTnFUaU1VSkZlSi81SUJySEhCbHVvc0Fh?=
 =?utf-8?B?elZTNGpsUEJzRkV0UkVRL2RhNHZTZ0s3VlJEdC9lbFdxY0JFeVZqLzhqVS8v?=
 =?utf-8?B?K0JVZ21PZEg1b1lTODZsQTJzZ252TmlIc1pYZng3WWdFYk1MaHk4dVFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWVTenJPRHEwTTk4N1ZjWDVJMmxrZFdoUjhUTXlNQUw3cjJYRm1UY09oT0Jj?=
 =?utf-8?B?MFArODJPcmNUMTVtdHI1bU5NdStZTFk4WWZiRllHTmxnZmJyR01YRjdLSGx4?=
 =?utf-8?B?bGtSeTMvcWV2MkFYSEl4dDhQMm9wbTBDSWpFbEVORTAzM3BnQW9KVUttTkVP?=
 =?utf-8?B?cDNOY1JUMDBuVTV5NnkyUkhoalpEdnhHd2JTTHRIVGRSSW1JdnJrRmUvVStS?=
 =?utf-8?B?Z1UxQ1lTR0Q1WmVJMEhQR3k4ZVZoY3BOSlJ1cnRtbEtkSXFnMEpJbzR6Zmlo?=
 =?utf-8?B?aGVwZ1hTaG81bXpKczk3TjlWakkxbmNNQzUwb0ZFRnFmeTJpdmI0dXNpM1ZD?=
 =?utf-8?B?L3Qyd2pMemN2YWhsV3FhTGRzc2VFVnFDY2RLdFp2bGJuY0s2bnNOdVpWZmcx?=
 =?utf-8?B?N3NoTFBBNmM5OFZDM2ZIZnRzdms5UEV2ay9QT01pNE1hd0ZBazFIZk1oRlAr?=
 =?utf-8?B?RVNEcEI1NVNpYUJlZXVmc25rNzRoRkRqWWpLYmNUK2hsUGZPQkt6WFFuZStC?=
 =?utf-8?B?QUx5dDl4KzF6ckNpakRjUkVUQksrTWNQOU52bFY4TUtyd1dleHZOcFNDRDQ2?=
 =?utf-8?B?Umx5NjVUTjVkaXoxWkhITGNjbkZZMFE4WmtiRnc0S3J1dy9HclZuem5DVGFn?=
 =?utf-8?B?LzllVzg5TGJ5eXh0RXJsT2xsVHdaUzVkYXBMdTJJMnhYSytDMWIvTmprU2tm?=
 =?utf-8?B?N3MycGkycWVTRnF4VE9RaHlpK01NZCsyM1QwbDZhcndjSmdiaWovTCthRWhm?=
 =?utf-8?B?ZktyVFlwRVpYM0ROWGRoMklKYmlON1ZMVFN2Ujd2R2xIWHJUMTFhdE41LzVH?=
 =?utf-8?B?dzZsRDJPZklFWUxTSXBoa3FRKzVrTnA4d2h4Z0UyS3BIY1BBdDd2Tm1nQ0Ry?=
 =?utf-8?B?alN0ZStQRlo3TnJGbXA2RWppV3Jhck15ZkZSUkhLa01LdWhnQU1INW5YbXdI?=
 =?utf-8?B?bTYrRGhEMlJPQ0dhUDJmRXFWNXp5UzhwZGRDMzNKaUZXaFVDSFlSTXJYTVEy?=
 =?utf-8?B?clFvem1WaUt5MEE1M2JCK215MksvVmUvS1NaSkFmZVhxNlp4cEFlVFNDa2p6?=
 =?utf-8?B?T3VKQmVCZUxvNE1JdTBYWm1oeVYyVXVJYXN3bzYwTFhwMkJwY1ZFbHZFb1Z3?=
 =?utf-8?B?NG9uRmU4QS92Y2E0UW9JbDBaSnIyTDhsM2RkYjlaRkdNbE1CamlrekVaNnFG?=
 =?utf-8?B?U2gwaE5PdW1pL3p2ZzJnUHFoaVRSMStpUkgrN2NBMjZGcGloY2tGdWFYbFRP?=
 =?utf-8?B?SHpSSUxQLzJsQllheFNQYlF0K1lVcmcwTlpadHR0dVdMK3ZoL0ZzOUExbFNr?=
 =?utf-8?B?bkg4MXdXOGtNcUR0S3RNTVlHRmc3NXdhSllmNHpUSC9kTHh2aW1hTXNFRnJG?=
 =?utf-8?B?TVg5SlJkTmlPOTFOeEd0SERuekZ0d0pvRndRRW9kVVlmMmFPRjFPNWNOUlcx?=
 =?utf-8?B?UG50Z01aY0JwSjFZS0Y0RTVscWswUnJJQ2Y5VHF3cGxxY1NaT3B3bCtzeHdk?=
 =?utf-8?B?QlRrcHZUanpzeEVHa0pHeGxSVFdJYzVveGR6QnhuTHVIUzhOTGxpOWE1bFJ2?=
 =?utf-8?B?ZVgyZ0N3ekpCWU1pSkxCNHJkZmRJejQvejZ5OFkwTWxFUmlaeE5kVjZ6R3I0?=
 =?utf-8?B?Mi9acDVETGMwQ240czFzWFdUNEtTcG1Oa2pwY1dQSDhjbzlCRzRrL2VIWGh5?=
 =?utf-8?B?OXEvV3RGWHlCZDA4N25objBvb3NUNk90bDlFVVZtSXJyNHAzWmRnU08yYS9v?=
 =?utf-8?B?L0ZQZ1A4TVg4c2xQM0pSZkNiVG1pVmptT0crdjB1REVFT285dnUwdTIybS9O?=
 =?utf-8?B?RkNoOHZJNlczTHNjT3Zwa2xQSkhlOU9DSGgrS2dmZXFBc3B0WEQxMUo5Tlhh?=
 =?utf-8?B?ZmJibTZEeDRNcWpub2l1dGtwb0ZhWk9hSC9GNmxWWi90SzlreXBKaXMwVGVp?=
 =?utf-8?B?NTkydGhKd2pzVy9wcXBpN25oZkMya1pnNHEwaTNpbXdwZHJrOUxKNERleS9u?=
 =?utf-8?B?d3R5TVUzRHAxdzNhL09BL1ljVVBIM1ZtMVQxam9PWFp2SWgxK2VybCtpczh4?=
 =?utf-8?B?MUlrMGg5TGpRSWhXcEtsdHA5Qyt0SWwzOENMcXI3ZTFSUzVmOTh4UkZVeWVY?=
 =?utf-8?Q?xCxir4/qEB3TjOxXbMHNk9tYv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lL9SvX8ws+TwQ4jrLSqdn48nyCx7eXpe93MGFQrQcssw4qlWnlqbLRJthDFMasBvgZ/boSCfWJLs6P3+lzvyLWE+cRgHbQNLG4U/dCH236lSC9YhGMWHf9AfPuRzHRtF9oUtDUEvGub5rE7/FZtRjLPrtPiQ46zXZYNAXxhSbS+N52A/io4ijJygsubalnvmzgA+GIUCZo+2f2ujHiGuUO6om+qcvPrHEpuB8/eZleJRzX2/cESQKkrr7MPOLY7sSSqyzNc1nTUGDKoco796VYN/MOA8rmmFYjOOY8UFLezOxAzRRZCTUq9CgUyAeWn/R8Wn+ONA+nuMya0TWDkPB/eANTEfEsBXunWWsrxBevwPZuweUwk6J2hL5uUP7wkavzBPnUvFaoEg+MBTg+VvAjc8fvJsAFE46kk5jPmr9fZvfVHDnMP6ixlzXpC0S65yTuEzM+GMmTgJ4UaAL8CEwYSiaZZH/k67ZrxMXBLYfHIFfNIWjvLGC+hYlQQjzXxcmEuxsWZfg9iLVEPyl4AXIWOM/1ekhAIYu0Vb84faYVBg8uoK5JcwIQhK+c6V+CVQmGb9F0KBds/s4HA6S3hGnlaYDMeUkBx3LvZLV3SiDB0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd6cd20-253a-4fb2-da19-08dce3adf966
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 13:19:13.5050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D94BN5+hKAA0HtztRfZxIMR/w6+wrFtOCPOCaaXlheQjU4hg1fUxkT8e4Ki7LFglN/khwI5/iR8wTrFglqHseQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4682
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410030097
X-Proofpoint-GUID: NG4vAMf6LwhhYv4mchT53hin4DjCFpJU
X-Proofpoint-ORIG-GUID: NG4vAMf6LwhhYv4mchT53hin4DjCFpJU

On 03/10/2024 14:02, Christoph Hellwig wrote:
> On Thu, Oct 03, 2024 at 01:48:41PM +0100, John Garry wrote:
>> On 30/09/2024 13:54, John Garry wrote:
>>> @@ -352,11 +352,15 @@ xfs_sb_has_compat_feature(
>>>    #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
>>>    #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
>>>    #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
>>> +#define XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES (1 << 31)	/* atomicwrites enabled */
>>> +
>> BTW, Darrick, as you questioned previously, this does make xfs/270 fail...
>> until the change to a not use the top bit.
> With the large block size based atomic writes we shoudn't even need
> a feature flag, or am I missing something?

It really does not add much ATM.

It originated back with you mentioned that we need a generic common way 
to enable atomic writes.

And then we had forcealign, which was tightly-coupled to enabling atomic 
writes, e.g. enforce forcealign enabled and power-of-2 extsize.

But, apart from leveraging larger FS block size for atomic writes, I 
still think that we will want forcealign or similar.

I don't have full tests results yet, but we already know that we see 
performance degradation in some scenarios when going to a 4K -> 16K FS 
block size. We're testing MySQL, and Redo Log performance/efficiency 
significantly degrades with 16K FS block size.

Thanks,
John

