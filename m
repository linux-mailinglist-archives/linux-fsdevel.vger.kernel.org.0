Return-Path: <linux-fsdevel+bounces-44188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4D7A6479C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 10:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8383A543B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 09:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC152248A5;
	Mon, 17 Mar 2025 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SjrwsNXs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qrvph4v9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F2721D5A2;
	Mon, 17 Mar 2025 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742204208; cv=fail; b=TEUkXNCZgRZFpkWeGgtA+YUR9lY7oi/3hRyndO4jpkqW50/SN7CD+WegRS3/TV6XjXVOsZ+gNnBM2LiWIeeChHFcR1KEhu5QDnxBU0pWjYT5EIF29LDatDq6F3HjrNDUitneYxTzG+Ojvo9lZAdin1Ce+quyZSvKIdYmF4+fbHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742204208; c=relaxed/simple;
	bh=yogRBYGAPhrDHAo2xgBeYZU06iesjGO888wkTE+/2Vo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z6L7Zk4pb+BgYLgOHDgnojCMFAEG2p2kasMmh+13yS0SfR2ZY+goBsn3k11feEWNhf6LunpW/YHZKyF1ICO/kvPmDscfoEpi8GMUmBiu7gidoZWnYnZaDWoR9FiUIhORKWzXm3gxtCwwcS8etUStWWaXt0w0EmcZ6vKdfyVsHwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SjrwsNXs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qrvph4v9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H7QraY018733;
	Mon, 17 Mar 2025 09:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Dj4U9z1dAzECBi5GgzeQNDuCzZR/zRkiSS8oHCGCx5U=; b=
	SjrwsNXsZd7xubStkr8GOO6zRrnmQAoErAGzJptsisGEmixdE+c8oCeP6hFWviXn
	VNYkbkRt93tVhiwdWi8Pl8nZNaU/Ejb7K3VLjze8JyQCVply4f/8JFx2bT8buixl
	Joahuukq2FjN8qzxCnjsDmUzcnvvB9FqekiDpNgMVd6skD7NiPVuQOeuWxmYAsYK
	lELYvQRSNFILy1hdHVzanxW09bKjihDmdo8WFaZQqaOeflA9bt1RQv8DWFp+57nV
	93MAYfK69kMfB5WGoMBweDsHTvosaDNuLKqs6/HtHgU193F/wntiZNGP5BN6g2SF
	bPTh7siX0XjxBM7viYrFqA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1m3jamr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 09:36:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52H8KtCL022470;
	Mon, 17 Mar 2025 09:36:21 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxedpq71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 09:36:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEF72c8DOUFSZi2y51a40yUCAUSuQo2iTEBaVTsPubA0NwrtN7pKIq9zUyHvmxSMNM6gTMDXUaeimALX/VhroRJS8jmFPbImjlyC4P6PiDUqYypTqi2jPr9856w0DGp97ftcchXhPMk08U56LKB5BcAoNCmXsqZD4MPlXpFg7zyKkPaZoR/XeaUfQzTH3Wy9WCxAqGmI9qgi5YnkqTXTgSETONpTJ+eSK1fvhlH5c5MBhu3xTcSLztoKSPr7+NEHCR0cZV8+fMNCNnCaBuJpZeDphWf/rq/vZkOd9CqDrqlevBlpOCA6YF1kcaNgVrKMsDp5+4+PwXDoweH4vY2TwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dj4U9z1dAzECBi5GgzeQNDuCzZR/zRkiSS8oHCGCx5U=;
 b=gKKOzduDxsbfPpVROHQu77eKzAK2zxjNO0YWkw4Bkc6g8ntpD1pK051+6EOpZUXYY3IJXubFGOI6I2sZA9aZGOQbAc+Rs10+QKQGPo+UqYG9mOEGhRvREgTKSHh2BORDNCgMDnWsD9i57yu6psLyjvCnojhWUY3rhl0IhfqL5FcgklQTadTSEDTGOhRj6S7wFpMD1Y4PD7QjfYoglsd2o6fEkoz2qsA2iWpJxF/3GwJuWRCPPpinytL9bFblbfuRWxHdNY83VT0sq1ZsOkCIZJDE74OnWr9YzqYTkPz7/O6anlViUToqW0JGcVbJfKEgQwe5t+Y96W6HfAp605Te2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dj4U9z1dAzECBi5GgzeQNDuCzZR/zRkiSS8oHCGCx5U=;
 b=Qrvph4v9dZMjW7iToQ73+Oud+O2BssUUWWyHf2X+BdkR8re/i684qW4B/KT29eJNND41ZT56V/QZ1vuq2ofa2+XWcXLESRG46TKyTEEHui+xYbVU/Ts3x7dWusaczoEQX2COKH4sB0psdhKOiXuWHZiN9V7ihHGxr1iF7m3wIoQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO1PR10MB4450.namprd10.prod.outlook.com (2603:10b6:303:93::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 17 Mar
 2025 09:36:18 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 09:36:18 +0000
Message-ID: <7d9585df-9a1c-42f7-99ca-084dd47ea3ae@oracle.com>
Date: Mon, 17 Mar 2025 09:36:13 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/13] xfs: add xfs_file_dio_write_atomic()
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
 <20250313171310.1886394-12-john.g.garry@oracle.com>
 <20250317064109.GA27621@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250317064109.GA27621@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0347.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO1PR10MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: de886bd3-77af-4e2c-b7b1-08dd65372b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2pDOXAzKyttWHR0NU9ydW83VCtvaDFNQmkvR2s5R0VLcU94RWhyWmJoVHhY?=
 =?utf-8?B?K251V0dhZUFWV2xlMHdjMm5OeW9aOHkxZ1RhSlNXdnNxVHRDRXRJU2pOb1ho?=
 =?utf-8?B?TUdIY2lQU1p3LzVQMExPS245T3dsZG53NHJtbjNZOFhic2MyRWM2aHBFbVQ0?=
 =?utf-8?B?R2hFeUVUN3g5dHlWbk0vcW0xZ0ZsQUpPVk8xdW9kRkFkYVNqNmthRi8xaWtq?=
 =?utf-8?B?NStBKzFxZU9wUjJ0eHNBelphZmNyblpDa1V4dlBjU2U1NW9lb2dBTzd3M2tV?=
 =?utf-8?B?YWJRQmdCemlTZm50QmFYVi8vYUY5UzE4cS94eGIreFhPTm1QSGVwZnROQlY0?=
 =?utf-8?B?WjlZZGtTYlZQM2xHVDhBWGtXK0RzT0N1aFRYTUlidG1oWjh1Q3JsVTZFd2ht?=
 =?utf-8?B?aXVSRTRzcCsycjNuREgwNGFWMlJXVG1pN3BnNktsMldycXpWak1FNEF1MVFu?=
 =?utf-8?B?a1pCNUhEbnN3ZmEwelNRYVAzK25jVm1tTCtBT1Q3OHRNSHhNbm5DVmlPak1r?=
 =?utf-8?B?bVF5bkZKbDdMcUE1SWsxZUxELy91U3NpVWh2TTE5a0J5cUxOZ29UNm9nN05i?=
 =?utf-8?B?c1hPR0NZTW5tTEhVcGRlUWdqVUkrM0RkNEtvd2szMTZPcXpMendKaHp1WDVl?=
 =?utf-8?B?NTRTaGllRWI3Q0JsY2FMTzdWcWxRVkc0MGVOMFNmS20weFVJNm5DN1VZY3dP?=
 =?utf-8?B?TTBMOE5aOEpPQ29FT1NrTDZjZ1NqejEwc0h3aXdqK3BmUjF2UHl4ZFNkMGwz?=
 =?utf-8?B?UkNQM2c1TUlQMEtkUmRLVGsralIzZmxUa09lOWhZZEZnWTJLRThhYmJObjBZ?=
 =?utf-8?B?R3ZpM0NRS2ZkVTdnQ0g1dS9TbjgrZ2pIMlh2MU5UdTlnNG1BTU5WcWY1MGpK?=
 =?utf-8?B?RjNTektKVzhacENpVXRoSFhWWFBvU2d1MTVGZjBBbU5Ram9VU2Q4MWR5cC9O?=
 =?utf-8?B?TU9JZVphc2JWRGoyMzduaXBDd3hxMkpWL1ZKVFpDd0xNT09xS2JTamozMHl3?=
 =?utf-8?B?Z1llUC8wT3hVSWU0M1FJaTZxNkFLZmVpQzcxc3RBR2p5cFVJV0huMFVYcTFG?=
 =?utf-8?B?VTJqL1cwOVc2ZWNmQU9YQ3dLVnJucW5Ka0lieXQ1YjJFbDRYTEVYSHkrbmVD?=
 =?utf-8?B?TE9OOWMrNXlLYytVVXdUaU15M3FZRFJOa3FaaDJJMUhlU1h3cXlzUXU3Ylh6?=
 =?utf-8?B?S3Rlb1BDdXd6U3MyTHY3MGt5d2VudGsxNTU0bktRbjRXZXNDcUFCSlFsbzF2?=
 =?utf-8?B?SC9ISnBtakpLMm5ZVGI2bmlFU3dEdzRiZ0hJWUhiZTd3aEdlK1hMQXk1T3Nw?=
 =?utf-8?B?cnlOYXo2YWNwWDBNQi9hcXZtazlxWDYvMzI5djh1WmlLbFdsSUxYZGNOeE1R?=
 =?utf-8?B?MHFCZ2lXL1JhMmkyQmJRL0hKUDJsZ2F2NTFxcUpTdi8xYkNkZ053M3ZIVUJz?=
 =?utf-8?B?alRiZFBXOXZzeVpEcHdrZnhsYnpsWUQzTTBVMXU4STc0VFhzazRJclA0UEN0?=
 =?utf-8?B?UDNxb0lYckhrMXVyOUo5L0lUWEowUHI3VUVBRFRyT2ZTUFhUNXBzMnhESzBD?=
 =?utf-8?B?SCtabkRUTWZ3SW1lZXQ3LzNDTXQ2alpjVVMveTVtbHNVYnlzSjZGenRKSTNu?=
 =?utf-8?B?U1Q3RUxvYkMwblJPZEwwTUt5MmdxcGF1R01xYzVWMW5DTEpUb1dqV3NPaDBM?=
 =?utf-8?B?WUpZWFN5YW5DYU8yUUdTNENiYWpXMWRPem1kMC9GL1FnK3l1VlluTjRxU09h?=
 =?utf-8?B?RTZONUJJWjJqejFWK29RM2ZSNFZ2R2tQMDlLTTY3ZldHNlQ5aDhWUjgxbGZx?=
 =?utf-8?B?d2crMFVnREhKc0l5ZHNWdTU2V3NDR0UvYXBORkEwbis4SncvSVl1ZGh3cWpE?=
 =?utf-8?Q?klzuEiDKHQ3VB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1NoS2VxTWRIaHM0cjF3OTNmd2NqaDdSU0luQzZQSjUyWkg3TmVYR1JteTg3?=
 =?utf-8?B?dVBTNnN3UmdSNll3ZFZpQ1ZFS1VoWEcwNzJDa1Z1bXFsVy8vYUpzV05rbGRo?=
 =?utf-8?B?SXQxVDRTSlpCcG9qTWlDZjJjSWkzMjgwbzI3NXNWTHU0L2ZoSVBtZ2NrUzk4?=
 =?utf-8?B?QmV4dnU1bUN6SW1paVZUb1RrYWxVSDdzT1k2R3liMW5Ob0xkN1phOHFOb3Mv?=
 =?utf-8?B?R0dDdklaTmwveEFESEZzaEVuZWpkL2FWaGtDcEo2a3MzRkxyNTBXWHNNb1pS?=
 =?utf-8?B?SkFaeDU0a1dQb1ltS3FDUWo0T0N4bjdUNUpGcW5WWHVvclAxTnFpSWJjSWQw?=
 =?utf-8?B?bVRvZ2RKSkRVQmxLSUJCbUdxemIyVWdIOVRRNnFhUWxwYTNpNjVCMVF4eEl6?=
 =?utf-8?B?enNmZzFrU1BNMFNuaXFLdkpNam5BUWJnb0NHSWg5RGVUeElDM0g2SUFUQ0dC?=
 =?utf-8?B?dkFHYlpPV3hWR1RJZmV4OVVnRjlabUJiSTJocmo1MXJpZEdUQXhvdmxrWE96?=
 =?utf-8?B?SzNWRng2TEZ4dEQzbXl4YTNSY2FSbmF0bnBZYmlPRXJMODhpbUh2dUl4YzdG?=
 =?utf-8?B?ajFSWXJzcUZ0TDZRWDFGMnVtREV2eUNnWENsc0JKUVd6dzJJR3VJUW02ajhl?=
 =?utf-8?B?WmZoWk1yNEdmMnRURUk5UGNIMWxXTWorVVpMdHNPdkhmQnBJRFpLRUFsb0M0?=
 =?utf-8?B?bE1UZENXdUhNWVhHbWZCRFNqWGFYSnpmSDd2elhWTm1QcTBGd0w2eHZuODhw?=
 =?utf-8?B?L2psUTNzWG1qYjhQK003SFRFNzVGVnlZdGpIbGJ5MlArbDJpT0NnOUpSYnM4?=
 =?utf-8?B?c1N6bFhBenhxS3B4WWVKejgzZWxhZlJvbXZEZy9TNmF4dDNFYkIrYXpBdEVq?=
 =?utf-8?B?aEJwcE05dDVOMFNBN0FhSUFla1RIMG5SenJNUUJxVXlVSncwb3QwaFlvTkll?=
 =?utf-8?B?NU5EZklOdmF6VENzVFdWWjZzUWdDeDZSbS93UnJMZkpab1pEUnE0a2NvQmxM?=
 =?utf-8?B?Mm13Z0NQWXFVRm1qSVhUc2phZWVQWVJIeXp6eHR6cWVIL3ZIN3RrQUZuWDBK?=
 =?utf-8?B?SFZVYTVxMGw3dXJkbDlsMHVaeWpYa3Nvckp5SUExcjFNOVJaNlNObUJxTDB3?=
 =?utf-8?B?aFZFL0plZi9KZ1Vlc3ViZmRuL3czUS9JZ01CUlZJVkJmM0NPQklCSk1MR1Ez?=
 =?utf-8?B?eTRuZkFNVXJEVElKU2dPVDZkR3JRTzA0M3BSUVFMaHB4akgzMXhmSXlJS01L?=
 =?utf-8?B?K1ZrRFgyd2RYSUFXemNlSUJaNExVMklQWXQzeTJ4eVovclF3Ri9XeHRLaFRI?=
 =?utf-8?B?bXVDb3ZoZ1IrL3RmL293K05tLzZ6QUlwT3JtYk9wMmFYK2ZZd2lJUExtL29B?=
 =?utf-8?B?em9LbkZDeGtrR1hDZ2ZoQ2JHNlkyT1c0SzVGdVkzQjgxMHhtQjJmTHdLMW5M?=
 =?utf-8?B?RGRua0NxbmdTQ2dLMVhsYUhDQWxXUTVjWnFuTjlobVhZMFdqVXh4SUNTTG5k?=
 =?utf-8?B?Qm9GUVFWUDhVL21GczVRbzBMQlZGOWJOVy9UKzFRbkxCNU5ycEVmYWVwOGN5?=
 =?utf-8?B?MnAwOW82RmpnUUk1cjUxVnVra3duTDRFVEFEK2RocnF4UGZGZXYvbzh4bjA4?=
 =?utf-8?B?UDY4Z1J4NkN2SU15cm1BcFYvaWNaeWI4YWtCNVB2RDVyR1hTOGV0TnZDM0Fy?=
 =?utf-8?B?LzdBcXRmei9Rb2hxcTZneUlJbFRLK2U2MFp3cHIxWVAzSzUxZUxXSjhYbGhs?=
 =?utf-8?B?RjNMTjR6TkZWSkxrdmZvTEpwNHhxR3ExTFV5cFFJOWxVaE56VVpDRWVMdUZl?=
 =?utf-8?B?TXFPV053NHdIY2VmTU5VMFJJZzFHV0lVSmg3YzVoTmduNjY1aUlBb0xESlJF?=
 =?utf-8?B?c0pVeENMYTVnclJrenJ5YURMcWUvd0MyVlBDbTdsR0Z2WE9YL3RqNytIMUls?=
 =?utf-8?B?MVU2ejNXWmg2elNBSWI1RGFpZG5JSzBzNjVTZXN1TjRjMXd6cytlbGJ2L1BZ?=
 =?utf-8?B?L2RVd1JkK2tRSEdzSXVRbEpHVS9tRmtYVnp3RVlmWUhJaG1vcEFvWXgydHl2?=
 =?utf-8?B?Ri9kNXhML0ZwM0RKWHlyM29iQVJ3cE5RdjhjZzBxaE94cnlyWTA3a3FIRFdG?=
 =?utf-8?B?WnJXendwY001cWRjdVpjQjlTVDU1WHNVMFVpY01vT3VDdzArdjhDSWQzc0VV?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qYywJTLli8J3UOhnOsySvxVGc3glWMN69LwAxPlTU2oPN0XvwZEu4FoPQwS6NxZSjT39k0xqwQS41/sp2VdzJgVaqz/5R0FS0+ZNDbU6hhvkcqax9enPN5QncUILDfEVp6on6Y5afcAxQWfUQK6IllQtFKueY16zu8r1yKN0Fm1ntlSyFphUhlClkE8MRZbabBT5lOPamH+cIqa/elEGS22lZTbrpg4P21l1+YsJm0mDRI8GepOQJm114wnSQfYg33RKnanRZTAUQOonJ/Q6RIrqrRhZYpOawW+5Y4OUsjrm1mFWJz6UuwXerwt34p0Ek8bqUTDG1u5s+v1bPb53JrKYLRkfmkLxJ6AecGuujYH/By6fpjC54v/OdElKuErVzspHMnfneroSzUbY1o8cPX+J83qb0CoBHkVernWxpxGqfoJJvWhYYH8COoA9THRqc2RoMmLS5s4r1c0opeqn7BOsZgR3DNyiFGRhkdYKokY6Q9ChiPeAIKp1+Zj86EhdNvgDCRimkFF10Sp3OOE6iyxCS3h0aUat5l8g5hQ30cxXPKx1gNhoyTbbvOrLrfyH+BzW9d4sROlSeSCWoQj2UXlikcjUViW0Wngb1no0rL4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de886bd3-77af-4e2c-b7b1-08dd65372b28
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 09:36:17.9378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RYc7jDGksVOkFfhFJSljG3y3e2y1GZOsfZirD+smW4HHnIgjagtwfbFBLoyUPc0bgVyXwyRkAr2YoFxo1/WkyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4450
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_03,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503170070
X-Proofpoint-ORIG-GUID: 11J7iAPX_lu4Sh_Cv6X_UKX5r8anZTEr
X-Proofpoint-GUID: 11J7iAPX_lu4Sh_Cv6X_UKX5r8anZTEr

On 17/03/2025 06:41, Christoph Hellwig wrote:
> On Thu, Mar 13, 2025 at 05:13:08PM +0000, John Garry wrote:
>> + * REQ_ATOMIC-based is the preferred method, and is attempted first. If this
>> + * method fails due to REQ_ATOMIC-related constraints, then we retry with the
>> + * COW-based method. The REQ_ATOMIC-based method typically will fail if the
>> + * write spans multiple extents or the disk blocks are misaligned.
> 
> It is only preferred if actually supported by the underlying hardware.
> If it isn't it really shouldn't even be tried, as that is just a waste
> of cycles.

We should not even call this function if atomics are not supported by HW 
- please see IOCB_ATOMIC checks in xfs_file_write_iter(). So maybe I 
will mention that the caller must ensure atomics are supported for the 
write size.

> 
> Also a lot of comment should probably be near the code not on top
> of the function as that's where people would look for them.

sure, if you prefer

> 
>> +static noinline ssize_t
>> +xfs_file_dio_write_atomic(
>> +	struct xfs_inode	*ip,
>> +	struct kiocb		*iocb,
>> +	struct iov_iter		*from)
>> +{
>> +	unsigned int		iolock = XFS_IOLOCK_SHARED;
>> +	unsigned int		dio_flags = 0;
>> +	const struct iomap_ops	*dops = &xfs_direct_write_iomap_ops;
>> +	ssize_t			ret;
>> +
>> +retry:
>> +	ret = xfs_ilock_iocb_for_write(iocb, &iolock);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = xfs_file_write_checks(iocb, from, &iolock, NULL);
>> +	if (ret)
>> +		goto out_unlock;
>> +
>> +	if (dio_flags & IOMAP_DIO_FORCE_WAIT)
>> +		inode_dio_wait(VFS_I(ip));
>> +
>> +	trace_xfs_file_direct_write(iocb, from);
>> +	ret = iomap_dio_rw(iocb, from, dops, &xfs_dio_write_ops,
>> +			dio_flags, NULL, 0);
> 
> The normal direct I/O path downgrades the iolock to shared before
> doing the I/O here.  Why isn't that done here?

OK, I can do that. But we still require exclusive lock always for the 
CoW-based method.

> 
>> +	if (ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT) &&
>> +	    dops == &xfs_direct_write_iomap_ops) {
> 
> This should probably explain the unusual use of EGAIN.  Although I
> still feel that picking a different error code for the fallback would
> be much more maintainable.

I could try another error code - can you suggest one? Is it going to be 
something unrelated to storage stack, like EREMOTEIO?

> 
>> +		xfs_iunlock(ip, iolock);
>> +		dio_flags = IOMAP_DIO_FORCE_WAIT;
> 
> I notice the top of function comment mentions the IOMAP_DIO_FORCE_WAIT
> flag.  Maybe use the chance to write a full sentence here or where
> it is checked to explain the logic a bit better?

ok, fine

> 
>>    * Handle block unaligned direct I/O writes
>>    *
>> @@ -840,6 +909,10 @@ xfs_file_dio_write(
>>   		return xfs_file_dio_write_unaligned(ip, iocb, from);
>>   	if (xfs_is_zoned_inode(ip))
>>   		return xfs_file_dio_write_zoned(ip, iocb, from);
>> +
>> +	if (iocb->ki_flags & IOCB_ATOMIC)
>> +		return xfs_file_dio_write_atomic(ip, iocb, from);
>> +
> 
> Either keep space between all the conditional calls or none.  I doubt
> just stick to the existing style.

Sure

> 


