Return-Path: <linux-fsdevel+bounces-48027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D27DFAA8E05
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 10:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 588D47A2D66
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 08:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E881E835A;
	Mon,  5 May 2025 08:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZZWTG4c0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qB/k7jSH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8B21B85CA;
	Mon,  5 May 2025 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746432794; cv=fail; b=UN/cV/OzrXe4qv+B6PAmLwdbdgfJuHPrDXcIIWmn3Zavp3Sx7Bv7/kY2ysAxN50IWfiWCMftgICG1MR9mi/b8ORbZxLk9XGmG9qFcHB7hlJrYNAGQ7vnX8kxZD/Qu48HxKqx6IhaNE+0pu67Vs+8HCuBwgy9pSdqZrTM55fSAkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746432794; c=relaxed/simple;
	bh=tSsEJIU0+ZCtpwP/nJpdo+r68CqW3izJIt+zEpJC394=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LQ7VE6AuE+ne5GOhjNBHlGH58JdvzNUd1AljR69+mD00jgwpmpq/OQ5uyj3re/i1X1tu/iv5XHWIJ5kXCiCBANWlDaM/ecXCQdzO+CqbaD0suqIQJA0it8XAOj4xSCMc5F/TtNlDX6GMPZkKVdJJeG4Me8DlV0Ii70o80TNgXpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZZWTG4c0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qB/k7jSH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5457bVPN013514;
	Mon, 5 May 2025 08:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tSsEJIU0+ZCtpwP/nJpdo+r68CqW3izJIt+zEpJC394=; b=
	ZZWTG4c0Txf6lIXEw5OnbBuyo2yQ4Y4JVALOisIlOpWUA2L+KbyfBW2uAVsqqChk
	fbyzJBeMUrKKiSeg0STStvk4frOQEUccVdTbfyKcwcfhGXibaeol8E1+gFnrz5y9
	YGRT7oKYG98uRJ+yFE6CDEjq8Zt4Ph0LzzTCU0v5MoDloFfRukXATBoeLE2y4kUk
	jU4ed87aRyhxOBpZN/Zz5JxIQDaeO6TgNxZARtrtb4Oy1o2TKcBqc2ZTP/So+iCe
	3QyTb/giC5zj/ASrlGpvp5uQmQGeR3AWwNz34tzWOikl6N6rYFeZ82Q8Wfrl5pbe
	QfCjtKTj8MX5L0gVef4XBQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46es3h81th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 08:13:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5456ZX4M011165;
	Mon, 5 May 2025 08:13:01 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011030.outbound.protection.outlook.com [40.93.6.30])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kdnars-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 08:13:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YN29icSttYl79QqBg2VDGDAzfmR6CT9s2Z+tlcdWDICtPCNDvbFspu1iglDUqDTnudGBUugutK1jsPRncxq4uvj+ILMNfRTdPV4h+4NlhvpLWM5Aob4NrLNaAIhG+3A+UrM8d3ONQeNCUlxhB+nSxH+bI79yfjeFF+iLh2HGXOdlzsBhQeNbhb1kpyJumaOLZf4WBW/2vntvXEDLDkCKJzZgWtbCa2zVmCEyni4V7JbF4OxcElawSrHZQovRMtqg6PSJTZdYQ7GrGTfZMBPlS/YLYN9Dwgw6uezxt1XpgpnbRveHwJ4nA41WHKHTjGYQ3ky/XcNtJPkV34/f+/mToQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSsEJIU0+ZCtpwP/nJpdo+r68CqW3izJIt+zEpJC394=;
 b=ZQ9aZORTs4dMC4Ylgn5wMEt9Ud6kX+jlcU5GfT8QWIqwCyrD5ihWd0tRF90oS0F/x/fVJ4uxXAK7zImIH/TTECtRPV6ZSUON4+jIuKwThEXnmqgK6KIV9EbI+gACURn3oQWzoW8vE0W6RUKUlgXs7tbpvMXU/eBjhqpd0tIdxTQiysg/ACRrAQVqmGblVpfbcuwaFbWjW5YjAaHiYgpG5zVclxr26AHRiM5Jzwv1WgP5F2HavwajsSy9HHIgUCRlG+63fJikHD49x1bqcl/d5lp9JtypkcYBy+oTb30OtFbv1f55wv7TZPk/ODJUcQ4unG3opjkic9V8FEmrk+Mg2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSsEJIU0+ZCtpwP/nJpdo+r68CqW3izJIt+zEpJC394=;
 b=qB/k7jSHAIpIgoWBlvuC0Hp38SMSdNAWtwOsoLIMNmqr/yeoR+Gn0jBxjW0aui/TPCZDA2qdfyQVR6NGzEuApX3hmdSxlwZNeT8JpR27ufHciPFrZbua/P4mQJMv/X6Mi8hM+TUEUK6wTMLuJLk0cg7DWoptfNfLhE2dmPvtfGw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB7328.namprd10.prod.outlook.com (2603:10b6:208:3dd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 08:12:59 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 08:12:58 +0000
Message-ID: <0b0d61e9-68e6-4eb0-a7bd-6e256e6d45f8@oracle.com>
Date: Mon, 5 May 2025 09:12:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 06/16] xfs: ignore HW which cannot atomic write a
 single block
From: John Garry <john.g.garry@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org, linux-fsdevel@vger.kernel.org,
        dchinner@redhat.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
        catherine.hoang@oracle.com, linux-api@vger.kernel.org
References: <20250504085923.1895402-1-john.g.garry@oracle.com>
 <20250504085923.1895402-7-john.g.garry@oracle.com>
 <20250505054310.GB20925@lst.de>
 <1d0e85d5-5e5c-4a8c-ae97-d90092c2c296@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <1d0e85d5-5e5c-4a8c-ae97-d90092c2c296@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0339.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: f36e4f85-3408-4c30-cb23-08dd8baca5ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXl4V1BkelMwVnZuRlFRZjJ6Q2w0d1UrcFdKekxXQWF4Zmt0aEs1TEdWRXla?=
 =?utf-8?B?aWZjNW81RVpUa0dRaVF5Z0IreUVMNGRtY0dVMWdVRlZnTk9waU1Pc2tmZ1Rl?=
 =?utf-8?B?TGx1V2RIYXdaRVAzMm1OdFd0OHc2cG5TUzU3dnVnY0RKbW83c3hMcVFLNllm?=
 =?utf-8?B?ZGJQUTlRaXU2eGZHaEJpeDFRcTFnT1EzakdsY24ySGoxTWdPTmljK3FsL0t3?=
 =?utf-8?B?aWY1ZzJ1VFdGZXEzTTJFc0QydGNhMW4wc2Z2bk5RR3ZCbUpFc0ZyaHBpNjBI?=
 =?utf-8?B?dlZTK2pCYnhJSVpBcW1oaFRsc3A0WUtzZmhkVExZamY2dGpFQ0N3a0I5alI4?=
 =?utf-8?B?SGlRcENCcHA0WE9tbDFvZisxRHlZVzl2SEVIbXdQNDljWUFaSzRlZXBpM2JY?=
 =?utf-8?B?QUJpZ0RURG1IU1gwTENOWXVIMFZoSG5QOXVjOVZXQnlORzIxZmhyWG9ncnd5?=
 =?utf-8?B?UVIzMzZGZ203VjlkaHJHQW9JUlRuVlRYOUdWWE5TMWU5a2xxdzFqamhJcXJL?=
 =?utf-8?B?ekdVa1JxMnR6T1hRMml1NmNhNkFSOFJGRUFYR0lFcnFDeUFNQVNaL0tLTlQ0?=
 =?utf-8?B?eEtTaDliWm1lMDhXc2IvM3hORExZYm1vWmpTeDJ4Z2QzYVJPUU5oaG9WZXh4?=
 =?utf-8?B?V2F5R1pJZ3JBaXRCTHVud3EwblJhOWNkaFlBbkJrVXhWaU55eWVPd2VGVHE2?=
 =?utf-8?B?bTRnNG1ucFRFM3BGUVdSbEI4MzN5NDZNc2phU1U3cTFDNjhjTXUzYUFjdDBr?=
 =?utf-8?B?NTRWbzV1VGp5KzlWUE0raEh1NGFGZ29pWHplZUloODQzbGxpTHhOT1YvdUN1?=
 =?utf-8?B?WWNnMlZIa09JSVEzc0tkcFhMWHE2ZUZ3cmdFZE1iemtHRDhuVnQzZC90Nm9a?=
 =?utf-8?B?TzhyOTh1RjBzVUFGY2RTU09wRW1iclAzajhlaHFhd3g5elBuR3VQb0pSOFNQ?=
 =?utf-8?B?K0IzVVRRMFdibVQ5Zm5UVThzUkhTV29FOG9PNmlrSTJnclNqZ0V2eTBTd0Fk?=
 =?utf-8?B?WWo2aVZkVE1HUUk0MmREK01DMzB5ZDF5SDIvQmJNN3BkdkFCYytlV0d5aHd5?=
 =?utf-8?B?QmtKUTEwdlRsU1VEc1duQ2plck9GNnU2b2dkTjlTT25yS0h5Vk16V1hOckVE?=
 =?utf-8?B?U3pZeklIRUtmN2JXSWU1NGpzS0pJby9ORC96bXVsTUVjeUVrTWpFS2FKZXh4?=
 =?utf-8?B?Q2w1Uko4blR5QWJhTnR1VWVvaTAxUE43ZHpnQjA0Y2M4VkJ5QmZlZ3g4bHp1?=
 =?utf-8?B?L1BtSC9IcEorbmpYSVI1NDNET2w4WWdqU1dBcWl4VWt2Y1hGeDg4R01lT1BR?=
 =?utf-8?B?NkZQME5YMWRzTFJwNG9PK0g4ajZBQjlXZWRXVXdRajBaZGxnTG1sLzVSQW0r?=
 =?utf-8?B?cWtQZEw4aUljbm4yTWRYZDBRVWNNS1d5a0FyU0g3aWovYXg2dTRBR2lYNXc2?=
 =?utf-8?B?eW0vVmdERm1hdWtPb096NDVqelI3YXJuWEJCS1JuaFR5MGRLMDVaZ3FMZFVK?=
 =?utf-8?B?WXVubnd1UGY4aStsb3pWaHRaNmhGM2hLQXlHK0xhN2RRcFNOdlRVcXplZTla?=
 =?utf-8?B?cEd6Qnp3MnpqUnBSWFFyVDlvZFZRN0hvNjIyOVpPUVdyL0RsQVBQd3dNMyt2?=
 =?utf-8?B?RzJtSHpGSUlRTDRuU2pNZDV5UXFjWTVta3dvemJWamZCeVhiTGp1N2JIS08r?=
 =?utf-8?B?aTFWQ0k1UndkdGt0Y0ozT0ZZcEduR08zNEVjYUpZNzVOTUVCbUUxODBrMk82?=
 =?utf-8?B?OFZGQjJzWmVqY284S0c5OWtTWVV1OURuR2c0eUpIOTJKWmx5OXFCZkV4djVL?=
 =?utf-8?B?VzlqcktMMTQ3NHRUUHR2Y24wS0FHbzJTenBoK01JM2FyaXdOQmJkTzZVVTBF?=
 =?utf-8?B?b3Bna2g3R3VkOEJUR0p0SlFLcFhFVkRKYnlGbXo1T1JoYStPbzZYV0NveEg4?=
 =?utf-8?Q?GYEaqR49S+g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEZiRGlDZzd4V1p0OWpLOGxzSEpSRHRvaUFiVVZWRkZKc1JocFpqOFJINE9s?=
 =?utf-8?B?cWx2aWtVUTh2bkJMLy9qTkpjUTJiR2ZHRDdSVnZweWpFMDJXam5HTDBYVlox?=
 =?utf-8?B?WFgzRjVpaTkrTzZkTW8rWXJScEgzNDZWcTlEYXdRbTdGYnU0NGFOeTFKTkN5?=
 =?utf-8?B?VWtUQ1VhZzRrd1dKeEtzdXUwQ3JvUkkvck1xanRGMndUczlpdUFhZm1ZSWRy?=
 =?utf-8?B?MVdOT292anZwZzJna2JyeUhCbFhNN0IzM1dXbkNQblJBbWNVRG5SQWIyM2Fh?=
 =?utf-8?B?ZlJDZzBKTTNiZzNWU0JqWE1CbktYUFpLYTJiWjJiL3U5enVYYzVSeGJVNU5K?=
 =?utf-8?B?SEtxbU5WaFVXY0dZV1VQWm10SitFMm1QMEhVTnhQdW1WZUx2U3RuU3NXRnpZ?=
 =?utf-8?B?VVcrMHo3LzNMMDBhSU95RWdEWER5RmdRY3RQSkNUeGJ4M1Vnb2loWjI0dGg4?=
 =?utf-8?B?TWgwek1sbDVxYWtTUzdrKzlNN1BpVzZXd2VHSGMyYjBWc0gwN1dxRDhSSVFp?=
 =?utf-8?B?d3UvQlJ5V2V3Z3c0a1FteDV5SEpGeExlSjNFQzFPWFFjRDVOa2I5UUw2TjV3?=
 =?utf-8?B?c1BhVmxqaWtnVjJOKzA4OEtacXZNeTVuVTJrMzE5K2RKSWpFREQxZ3NpR3N5?=
 =?utf-8?B?U2V0RUlPb0YrQUNnOXdYd2pyZ0MvQ1J2YzV5M01BbVVDT2ZYQ1NTRWdrdlpn?=
 =?utf-8?B?cnFVaE5RSnV4eXQxNkg5QW9aVzhyMTFZMy8raEpBNmZ0MjRacmVNV251K2Jq?=
 =?utf-8?B?QTdGbXV6RzZ5M3g2dlJETW04UjZNK25tbDVzVDdsM1N2QU9KRndPYkFCNGcv?=
 =?utf-8?B?ekdYVmQ4QjdLTmIxaWVjcnRwT3E5QllkcWswanJ3Yk01RnoxdTFZR1hvaW50?=
 =?utf-8?B?cmx2MDBGRXIvZEcvK2Fwc1ZBbDdxMXdxNk5hQUdhMlpTUFhLRHA2L2dHNSs5?=
 =?utf-8?B?RW13STViZGhQL3phN2NkYUFva1RZR0pIeHFtZEVhVThxd1cwNWg1YWdoaEVT?=
 =?utf-8?B?NzdRb2RxaCtKcWpLeks0UUV0WWJuNFRiUUszWWVpVHBBRElucTI2UmJpY2tR?=
 =?utf-8?B?T3FyODRtZjJPSlVqVzBKcit4ZzlGcGJvUjVJY09XWk5wSDNLZmt2VHV6aGZJ?=
 =?utf-8?B?OTl0ZnhjYTgyeVB6WGNJQlo0cHllTWcrQ3N5eXIwN0xGN2hjdUJWVjZUY1dF?=
 =?utf-8?B?cGw4bUpvTHhBZjFMT0p6VHcxdFROeTVBMWVFSStBa0NKRFBTYWNsOUlvTUx0?=
 =?utf-8?B?RmdSOXhOMVRJbjh1SHkvLzl0ajVVZVhJMGR4MFdRUWpETkRBM2o0Q1FQcVBz?=
 =?utf-8?B?Z1o1MlhWQWtZS3BzdHlUNXJmVVZQbUExZ0hJbXFGbFJuL2xwK0NPOFJ5cXlw?=
 =?utf-8?B?WVA5NkxZWWNkNXNVNVRIZDRmSktRcjRKLzl3TUdRdkFaNUJLbTlueSsrdU1m?=
 =?utf-8?B?VlBQMWhEcWZZTEV2bFZLUDMxem12Z0YwU2xwWnVUZWtBLzRjRWRsRW1sWXdH?=
 =?utf-8?B?aTgxaGMxenFwNDFtYTJZWkVqSk9aSzZpYVliT2x5Z0VtaGxCdE5hMWp3QVNx?=
 =?utf-8?B?dGExRUR0N3BmQWlwT28xYUl4YVlFWlZRSlhNb093NWdIRGJhR2RnTE5jSVdX?=
 =?utf-8?B?RTErTi81N3R5NS95cTdzZ2k2SjhTb3RFKzRlb0JrUGFaNnYxd3B3dmdOMHlV?=
 =?utf-8?B?cUlBV0JZd0N0Q1hibStaQmFrZDNJeXJKQmZlb29LaHozWGxnSjlLbzJ4eWI1?=
 =?utf-8?B?Zko4UDk4akF1cU1LVlcvZktDZll0cDlHWldDczE4V2pRdS80WExGWXJITjds?=
 =?utf-8?B?d2RSa2o5elAvdXQ2Wnk3VzUwNU9rRTg4U3B2Z1l5YkhuSGRIaGtUMWpBOWdS?=
 =?utf-8?B?RGF0VElBQ1pJYldEbnIvRTYyOEQxbTNSY3ZuOEFKeGpJYUVSalh4a08zTERE?=
 =?utf-8?B?MGdDZVBqYm5rQmhhbi9aRXZVWUlvSHNrckhvZFRidkwydWJxVVgzMzJBYm0r?=
 =?utf-8?B?NFBVbTZjbUxPMlJ2L1kvNHFSY2JVMmszWWVJMFh1UWczUXNsM2REUFB4TFlt?=
 =?utf-8?B?QUEzQlU2NlloY2t2WmtFN0dIM2NScFNXUVY3TnpEaGFVWDllZnRvMzF3ZEZF?=
 =?utf-8?B?M3ZaN3dqRTdNeVZ2ekliTlRpNW9GbWdTaW8zRzB0Q2RkbUV2MG1zb3EvVG9v?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4T15685UYJBrb1+tcuPd20UzPCwfTCoy9A46Frn1WEyiUpJJ/DDu+T+YpjbiJBQnuAR4Ptbb6kzUSDw/h7HnDYyxPdcWFtOAZE/1ruItmnbaPKDelfDUi+/SfF5ufCGGV6ozXfx6rXLb58ioMVvNFan64TjZzpLsp5bwbsWhrwY8RB5UYDz/KEyM+uTVwpctyIR2Xcdtcec2kORuc0AWPvhh51pnn14z9RaFOyL2GlwB7mPT5y3T05B8FMDVnrViN/KCIZRBOIfJMcPy4Y2F5Ierqz+R6dE5cbJnC7WfJFbxOyZtix1PNx6u4S+TYFXGSUE6+F1NU30TtCThBmnq+RM8SDUBMovWgApnsjyIBu1dNxOzTLAsTStZRV+XV8KDpj+fHlsVC0zAmdiKGHUtu8C5daiWHlYO3GMGUlh4LqYbHhy7vc2tSiaRwgxUPOlVsD2BC/ed/z1okm9JRb6FvJbtiTqhMe7ECg37Vk3el5AeUR0VJDgu1uMR4D6kWRjo8Uf3m7QkxsFb8eXI//aE65fTcCQcymFfNhsNv9xxvrsS/a4p93uZU7uhg+gZYo7vYRBSak+W1ObSYyZZpugmNTTo0JAbg1gHnqUgnvDm7J4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f36e4f85-3408-4c30-cb23-08dd8baca5ad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 08:12:58.8822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+GEvjw1nAeG4yTTXnZUUaSdmN7ZzDofQlry/qCm4Y+gw16GuyjIoqQSvGougIUEWje8sOSWX9SXTHrYC3p1dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7328
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_04,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505050076
X-Proofpoint-GUID: eXlrfzlif122FRpwRN40DaVlxnibw5oS
X-Proofpoint-ORIG-GUID: eXlrfzlif122FRpwRN40DaVlxnibw5oS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDA3NyBTYWx0ZWRfXyVVly0NPXTkp o8NjVKwrra7vLpVJC4TRpe5QFUEpOyb9rKLgIiBSrv3xTH6dGHEnyhkf4/nN8AdJsB6EzCVZPvM RfhmpJYYODjxqqo6S8PHJZBwMOdEKLUd2/jvNzUspxIntaGUkldo8OAxbCI9JJn25Zj937eWw1N
 SLIPJc4lN1nXVDSEPTtoHGyHQaw1b1oaDUIfDeOBvPTsPlDmFLQ29bbRJezDGHXRoU3a38FpvO8 Hbu6PNZrf35/OsKUoCylb+trUWISPt3GYGM5t9e2i7W/DlpBuFvF/1873GYTcKg1a6DucIWY/3U rlS6h9auaeOwRifmYzRtXl8SOZsSL6MHcMjaxw4JCJUEY+UyzBKZpujcvbdCMabBxrbt1kMBYGk
 8xRDe7thukvSMEkvrbmzmvkDT3DY7gfh8h4Vb+zqsrYXS2xScjslUX3d/HFj2uEG4yAv4gCd
X-Authority-Analysis: v=2.4 cv=f8FIBPyM c=1 sm=1 tr=0 ts=6818730e b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=dhTCADodvPYwrVu0Ti4A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14638

On 05/05/2025 06:45, John Garry wrote:
> On 05/05/2025 06:43, Christoph Hellwig wrote:
>> I think this subject line here is left from an earlier version and
>> doesn't quite seem to summarize what this patch is doing now?

How about we just split this patch into 2 patches:
part 1 re-org with new helper xfs_configure_buftarg_atomic_writes()
part 2 ignore HW which cannot atomic write a single FS block

