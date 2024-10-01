Return-Path: <linux-fsdevel+bounces-30492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FE098BBC6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 14:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F762845DB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 12:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422E41BFE0A;
	Tue,  1 Oct 2024 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W2PqVQSN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MsdAyC7Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B379C3209;
	Tue,  1 Oct 2024 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727784368; cv=fail; b=Bd0RQ8IVTj4ZwEeSnfxMsYknn6mzYzPi0ynb11e7piHg+7KVR42oS1G63bm/m/iF0e1YGfvxEKEZN1Caaoo4mOJ5gOO9gNZFJeUgX9IUOVPSKE8kwWM+6aoXCV/wTnpztWNfwyY2BlyEf6i/zMdVMzZYiSDhkTPUiu0I+KJvgD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727784368; c=relaxed/simple;
	bh=J8sl+2Xvs2TuXR2yk5Q8Gw7wuWna5hBwaAX18rYfoOY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lc5YjkwbTCBZti/bdptEiVFNJoCQD91CVWUZ2TVXGUEFdQkynoobFhl0pXVZibmPjkOQa98B8WUXIMXejhIT7uD8iA6TQXeviSOA2OdxM/tk/wHI33Pjub46ikgqGSO+3meeGwt9xgJvq3kzGGeT79mUdlpX/2oA2eH3qXIFRH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W2PqVQSN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MsdAyC7Y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4911tjrq029451;
	Tue, 1 Oct 2024 12:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=ypM0x55udi49iFtzI0oit4QZ9ndjYcTfwf8PyMXv6Rw=; b=
	W2PqVQSNUcqFoflTIR+WOJC6DXZQBMkh4HtEvdk7bUr/eRlqZDXFNOY6N8Ej1jFj
	xujINGsmLpZwmXEwztIiGGpPJ8nqxO4H/WqsAIclDYzRJd8eeAloK7kfByCWCfkz
	yBQwLN9YsXaJumc7RrEgWja5WppxRt4KC8Ykf3xIuEACOrRAsjQEpG83eVDRkCj+
	7ecuvRL4KI6WTNc8L39vWNHQYzlcRWUWH80lczStZijobqUf0eWxvbe//trelZF+
	HrwF18tUFKSl5P2f7PGZto2x1GobANcA8jbc3GcQ+7t5c4hEcmErBVZRgsHjAfaQ
	0Y2mKCjjFisGo9p9JvW5WA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41xabtp06e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 12:05:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 491AUDcZ038599;
	Tue, 1 Oct 2024 12:05:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x887euy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 12:05:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrYCTEpFwX0nIwfehw+tai3Yn7r2fENltqPRBt8jE/va9EuzZ5W/izSnihFVqYB1miRTK7wwoxWXKXf6PbUQRfqaKujU/2zaN1wvNh/iC5SbwIVkodY9JU1PhJW8RwRT4D2pL4i3Fyeso8GW36RpUGTpUlbcRDKLBIvU4Id4rCMSv6ccLjfhDcH1lMzEmKLmOKOLZzaDZwxk4W/3IJzmbohZnQSbibwtJn9D0EWcySEYzkHX/O05glQ7GLOMzmt5x6aOO67MGVzkqhnRXLUWUmKvpXLiLhpizTrtni9PAvcJcs0X5JU6kqFE840/uGTKMp1mnnoeJuODiqWnr1No+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypM0x55udi49iFtzI0oit4QZ9ndjYcTfwf8PyMXv6Rw=;
 b=t1U3A/6MMJNHSlz8FTuhwkZMWbekk7xFiBvIzvyEvppwabL85Ckspd0sXs7dXvlRlbBSD74aIwXyW2aZ8zMKRG1PSHF2EVudy+Dps/doLJ3ZIUXADQyjo0HpDN7QgNYz2ddCyBB8URsUghYPgAzkdPyBhH3tz1ZQ6bWOYm9yOPWbReeRglmQVSgILKHG5BT9g9nEWm1ucziMAwHBbl2RN4rjXk8Gein1iYgHM7MAn2Lq/txjEJvilKmKv07qtGsjcggRABamphhSMzErHcyJORRRo6Cb8AtrLi29WrKcD4QyOayz78BMy/VvSMkOaWIFMzo93h4JeoAWN/kEjvCfeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypM0x55udi49iFtzI0oit4QZ9ndjYcTfwf8PyMXv6Rw=;
 b=MsdAyC7YwuxfROSOTXXq1WWJ48L86Cd8lS/fs4SQ0vCRezykdR3W6b9nrc0fJhtNj0A7sac+3sWGBcekQdl1Bm2Xrx+RP5nPoNkZRIy0wJdnQOtgeNMkB39w0N5tn1aomYLnd00x+kz9qnUC75sCBG8kymXb3YRs4budxqyAHH0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7222.namprd10.prod.outlook.com (2603:10b6:8:f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 12:05:46 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8026.005; Tue, 1 Oct 2024
 12:05:46 +0000
Message-ID: <ad90a029-31d7-4644-a44c-31b58a67cbfc@oracle.com>
Date: Tue, 1 Oct 2024 13:05:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] xfs: Support FS_XFLAG_ATOMICWRITES
To: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        dchinner@redhat.com, cem@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com
References: <20240930125438.2501050-1-john.g.garry@oracle.com>
 <20240930125438.2501050-5-john.g.garry@oracle.com>
 <20240930160349.GN21853@frogsfrogsfrogs> <20241001084102.GB20648@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241001084102.GB20648@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR07CA0029.eurprd07.prod.outlook.com
 (2603:10a6:205:1::42) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: a01e87d4-d51e-4c4e-b6db-08dce21161c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkhtRU1tRTdoY202cnh0Ni9XN1JBemh6YUU0YndwMVkzaTdmcDI2clNBU2Fk?=
 =?utf-8?B?bFloazdQenM2OFRIbmk5aXlCR0UzRWNJSW8rcXJyM05kWmxoYWlGNkRGZ2w5?=
 =?utf-8?B?WTg5Mk9OZ2wyc0s3MU80NlZoUmlJam9mNW0wUkp5OWJ5TU9paWcxZm1Ld1NN?=
 =?utf-8?B?UDRpaDIrTEdlMnFnOUF3RkJ3QjVYRWFsU3lxdmVMWVNXT3UyaWhwUUpRWEVT?=
 =?utf-8?B?eE1lNnlKWnpyeHBZcHZKNDF1NUJ4em10Z1daUUVUOHg1THNjNzlmVnZPaHc3?=
 =?utf-8?B?WUM5NndSdHQ4ejRJOUFRRnBuOXhjb3ZzOWxLc0RSQVF3QmRKZFZ1U0hKS1Vi?=
 =?utf-8?B?RkpIMDFiQWFvTXV1SmlzY2djWTd6czNhMW1JSGlidW9EN1p4VUhUdk5BQTRU?=
 =?utf-8?B?WUNjM0RPaExEMGRJaDB2VmZGSGpiZG1lUDhTT2VsdXJacFBGeDQvSmVneVND?=
 =?utf-8?B?cXlieEQydnorYk0vM21HQjYvUnlXWmVCWHFNN0pIQUhNR3I2Z0dIdHEzdkNJ?=
 =?utf-8?B?SkJsenFKRDJmU3RzaE9hT3NjQTUrRENDR3E0N2t1R1dxQm9aVk9ENWx4SkN5?=
 =?utf-8?B?OWlYaFhuNVpqVE5QRmNYUnZxK1ZBY2N0OVpDeCs1YndhY083VVIxZnUrUW9T?=
 =?utf-8?B?VU92Z0VOYTFBU0xXN3puRm9HdWdOeVpQSjE2MHJsSG9BY05uM0JiNXZ1bnc4?=
 =?utf-8?B?ZFoxRnFBSUtydDdKWm9wV1ZZZ20rU1lNWHBlZHhJbTgrN2NBVXpKZUNSNWpu?=
 =?utf-8?B?QmU3QUhjV0R4dGpUcmh5NUFpUFlHZ2hkYlU5NFNNNjNNTGVjcGlHS3BZa3dx?=
 =?utf-8?B?ZDRpU3lCazdlOHJHTTluUXFqWnhtbGVWNGFuSEF4bk96UXJGYUh1YmtsT0Ra?=
 =?utf-8?B?NGxFTFp3ZmpwWS9Eblo0VmJLb0YvUTBmdnJ0SGp1akVza3JKdVpPYmlxRlhn?=
 =?utf-8?B?WmE4eFk2Z0p6bFJJeTI2cVZlRnBvYURabkhpTUtTUE1pMGdXMDc2ZDl0Tkth?=
 =?utf-8?B?RHYvYVNXeGlxdUs2dGZtc3luZmxTK0lZYW1EQzdOVVlzeU01NVc4dXBtNys3?=
 =?utf-8?B?MWlsaUpYN1dHZ1RLSDVsZkVka0xyT0tjVnNMSDNnR2t6R0t5VldYSElMQ0d2?=
 =?utf-8?B?a2p5cEZWNEtDT012cTZiZ09PdUpKQ3VGQ3RaaktZbzYrTkt2ODA5WjFMTUNE?=
 =?utf-8?B?dnFHVzBScGdMRnBMRG4wUzBuQXd5N2JhakIwOS92dzVsaHkyVkc2aU1HUWRk?=
 =?utf-8?B?eGxZQ0FjdE5HQlNrMm5TT084RmtuWTlXbzhhSkFSU3pkcHNITHZWdXlGdU1J?=
 =?utf-8?B?eWl2SUdlaUF1RFl4V05ZZVdhRi9mQXQ0anRiQytJdjNsVGVMWFB3ang4bHNE?=
 =?utf-8?B?NUMvWTNYcnNOVkRqbkhtZUJSbjZqM2JuckI4bitoS3BvcFF0YkJ5Q1dacExs?=
 =?utf-8?B?ZldBSzU4MW5VdHhHcnIzTzdlWTFsOUlzQW1GdU5jank4YlZHQUY5bDc5anoz?=
 =?utf-8?B?Ny95eE5KV0IxM3YyS2EvT0l4Wlh2OFZkMHhWYnZ2cmhpVVVWK0ZxT041bkpO?=
 =?utf-8?B?YzFBb2FXbS9hRVpnWmYyN2V6LytrVUNnaUU0QlYwa2Z0djZZTTEvNjdpVWVx?=
 =?utf-8?B?d2xhaUlsNVo4TWhKSjR6QTIzOE8wTzJuQ3U1L0IzaUdqeEVqR0pSUHkxSEJj?=
 =?utf-8?B?WjFnbThuMzd4VDR3MWlxL2dJMXhjWmxEUzZsSjhqQlJFcm41T0F2MmZ2VlR0?=
 =?utf-8?B?MWkzOXlBNmQ5dm5jcDk4Vmo4UjJTL2lZU0hBVkdDcXJIZUU1Rm5iS0xRdGQ0?=
 =?utf-8?B?SDdGbU5pcGVRMEVxMUR1QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzhXcUpxakRTR3pvblZIMElSM1pkd3pNamFrRndQbkYzcTY2VGk5aG9JeHVq?=
 =?utf-8?B?TUpaNVYwVENZRnBiekJVdlRhczZqYVdkL2JhNng1aTZVc2dHWHF5WFNRWG9K?=
 =?utf-8?B?YUg4L1B0eGZvY01TQjBxcEdVc1NPUEVHQkloalJyLzJtbGhtcTN5b2JqWkNJ?=
 =?utf-8?B?S3VMZk5PNnc4ZWFhVVZ4V1ducm5EQkpLdlBTWGx0QUx1K1UrNUpyMmluMFpO?=
 =?utf-8?B?dis1NHVpSUdsd2JwcVp2b3hwaGpOTVY1SjRMY04rR0xaNzRtMnVPbmZ0MTlQ?=
 =?utf-8?B?RGtINzFsNitEMXFuMXJ4L3cxRCs1eFo1THJHRDd0LzNpUEZxRWZRd281UHM3?=
 =?utf-8?B?UmpQSkNTbXBzZVB6VndGRHphVklwNGcxUTJrQllhUis0aGthRkcrcDgxbyty?=
 =?utf-8?B?bGYvMllVMi9haC9va1E2aUJ5RmlNUkJjOWtFYURsZnRCeEhGUkwvZ1lwU1Zh?=
 =?utf-8?B?cndFNmM5bk5zUVpMUFBHZTFSelErVnVjaTU2M01tYitPSTEzYmFvNlM3MDIz?=
 =?utf-8?B?VnN2cG5Bc1RXbk0vajQ0UHVlbEZ6dmNwNnRhdUZmNFlrc3JNbXBvaUtGNHNv?=
 =?utf-8?B?ZkpRb3o5WDBGb3MxNlI0K0dJQVRuTlF2QnZ0WFViMmdYRXdkYlJJWGYxZTNp?=
 =?utf-8?B?aUo0ZkwvUzRuU0tVYkNMYW9xN290YmtmMHBGZFRnd3VLRVVWM3JqeGJKMVNW?=
 =?utf-8?B?UGp0akl4UVAvMGVhbXEwMnl4RFVhaFNIN25UeEEwUVdidWlCeFM5UDNudW1R?=
 =?utf-8?B?RnlxajFuZzJJTkJjb3N4c3E5MFNpNHA5a1RyYndVYnpTUXJRVStYcnFTdUEz?=
 =?utf-8?B?MXEwNWxid2labnNkMVNqRnRuRGwxS2h5cW1SNmJsUDlQdVZ5SmNwZ05URHZy?=
 =?utf-8?B?VnR3U2JnV2dLR2hPSUF2NmhLVTdtenliWE9wOGZrdytpT0JucmFFRlZZOHVk?=
 =?utf-8?B?UFl0M2tCRXhXZFNMeCtHc3pnQ3F2WmNtK3k0WmkwaVd5QmVkVjRKUndKY003?=
 =?utf-8?B?OHc0Vzg1c3V1ZjBjRmxhTFE0dlJrZTF2cjBLVHIrMDhlNWNGVzBuYnpSN1po?=
 =?utf-8?B?Z3JFNzREQnVEWHNzckYwNmJwT2xGbTBkMlpWUTIxUDdhaTlTRkdkRDE0Zkt1?=
 =?utf-8?B?TGVxbEkwQ3dCVGE4VEFOdzVHY2dhVVFDc3VEdGkyN0IrSGxRYUMxUTBiNzRD?=
 =?utf-8?B?VUtRZkxiWkRSeitjakNQYjZDejcwY1RJVkZlUm1oZDk0cG82N1owSFhTRGZV?=
 =?utf-8?B?ZXNKN0RqcHVvY2NRWkg1Z0t6Y0tnNmJmUE92WjgrbFlwWFNTakt5WHIwZ1VD?=
 =?utf-8?B?UFljczJqM3RlcThHUjdTR1ZDUUhUSHhaeDZaRWpKd0RvTWFMOHN4M001WGdQ?=
 =?utf-8?B?d2FlTy9TdlVKVE5sbjU3eTljbUZYMGltZXhxV1ZvR2dxMXFsV3JoMFZVTkxW?=
 =?utf-8?B?VncvYUpoTklPZndDdS9scFo0NWtiNUhRTG5SNDY2blMxbkZ3ekNHa0tiV3hN?=
 =?utf-8?B?S0pBWlU3amVTTE9wdStEZnBHc2xscHVtL3YvNElOREw0L2N3Zmk0cHhtSTRZ?=
 =?utf-8?B?dWNvV0RpaWJzY0xSWDRQWm1tL3RGc3M2V3BLemg4dWlZaGhnK2xWQm5nUWpF?=
 =?utf-8?B?N3FSRWpxdHB3UTYyRzI1OFJIVEF5b3NYcGpwc3RXTWVoNGpTcDRlbkFxWG9w?=
 =?utf-8?B?ZG41eWpjSGwzYjI0ODZJMGh0a0pXUEpNTURIeXJ4bm4xdlRhblgyTktjcDY5?=
 =?utf-8?B?Y3l4b0ZHcUpOTDNGNjhZYzVaR0l6UjBsbWFESlZtdCtSKzcxbmFxTStaOXBv?=
 =?utf-8?B?Q2sxMzd1WktwOGUrOXE2dmZETmFudit3cXVaSXB6eU9OV09Ua01uMjV5Ritx?=
 =?utf-8?B?Z1B5YkdLODNlV0dTVHNPc3kzTkZrTHc0KzBWbzAwZVJxMThXVDVlRElLZGNX?=
 =?utf-8?B?allPeTJ6MlduYkl4emtVdVBoN1JBcWRMMEJIMmptMHFvMVQ2NEowMXk1THBx?=
 =?utf-8?B?aXA0SnpqSXZYWFNVWlFlUzNlVjk4UjhOVHZYSDVTdmhhajJyZC9OVkJXUmt3?=
 =?utf-8?B?VkhUOVYweTVETXBkdG1UOWtiS01RUUVscTJqWElrc3NNQWxmWkoveVErcm95?=
 =?utf-8?Q?ul7X7xabe2QL9LAU5nOwPu+wJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H7xsO9Un1dHv+kk+m34AT/BoIEZPj+FL3t+t9/rgOpKha5daDKyYnjSMHaXluXurWZdXrirsRXIm2grXswHV5Kk94+m2mmPfQlYmDOqZr+0xIho1KKMIHfR40v8Dq+EaDOan9m3q7aHJ5dnAlMQFui9QvDXcUHUXDCSvlk0KMIDPG0o5L71mtANyZmkZ8BnvqdTWYvYhhL1yKPkChqmw4tQbgj0CTITBo2HfkWQOzGgWO2Ir9b25UMm5IHxXdb8Ey4eIpupIWgl/nnJumHYMnF2Zj+njuG241NoN/Y3IwdcWl6nDwM4CTgSv06vwGlHCeHCYaj93uJrNPWJloMW/yV3QD7o4GT3QbuI/JWNwkw44pMWp241034B/SiGsz18oVdEp31M78FmA3+E3FnG7QKqios2UIR1tecZy65WyKFecBGsNEPE/jWIVKPWop55VLbt4SHLXUPWedv7EozKbKoLlcp3E70qdJTk1pcCho3QwbQO9U0yvuy5zK9K3Vm2boimooW35rHLAqHVwd/5YnOwa7/vNc6diFTDQPYXPu3OsDOQJnS9Fjoymho/eqiB6lM60BDHvfzmo8xKpaDkkkvWHQViXIi4eHdo0vV0FLJ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a01e87d4-d51e-4c4e-b6db-08dce21161c9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 12:05:46.5775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVETaCvrM0mlHA2Eovza+njMFj0elepW74nBkfffEyXqarD2Tz4TbvQW6pFktJl9c7Smn2kIIqsgbxNtadH+/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7222
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_07,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410010078
X-Proofpoint-ORIG-GUID: qCRlvEhM8-LOR6BxWcFhv5JcUJ8oljUN
X-Proofpoint-GUID: qCRlvEhM8-LOR6BxWcFhv5JcUJ8oljUN

On 01/10/2024 09:41, Christoph Hellwig wrote:
> On Mon, Sep 30, 2024 at 09:03:49AM -0700, Darrick J. Wong wrote:
>> If we're only allowing atomic writes that are 1 fsblock or less, then
>> copy on write will work correctly because CoWs are always done with
>> fsblock granularity.  The ioend remap is also committed atomically.
>>
>> IOWs, it's forcealign that isn't compatible with reflink and you can
>> drop this incompatibility.
> That was my thought as well when reading through this patch.

ok, fine. I just thought that we don't want to mix reflinked files and 
atomic writes at all. I do understand that there was also an 
incompatibility between forcealign and reflink.

Cheers,
John

