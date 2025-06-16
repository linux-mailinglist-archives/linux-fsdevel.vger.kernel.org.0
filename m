Return-Path: <linux-fsdevel+bounces-51701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E31ADA671
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 04:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D94D63AF54F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 02:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D74F2882DE;
	Mon, 16 Jun 2025 02:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b="wNSL114L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-007b0c01.pphosted.com (mx0a-007b0c01.pphosted.com [205.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF31D23AD;
	Mon, 16 Jun 2025 02:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750042033; cv=fail; b=BQVvf/xmT5q009wYPzAnr3S/aRsTDuo5iw54JtiAr8TvbwVubJ19P1x2eZJ1q/3qUofauuXqOqQpwaH5LVX2VyjpzRy/zwQBNvhmJo5k8Jb5Uc3VE+2UTxLdSUWHN5VG3Zd44ROtAlW+PtZdlufVsHB7AkCSl9ccM75EJV8fCcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750042033; c=relaxed/simple;
	bh=6jOsXlhf8tnzTa/pzhZjwJSH8kH8wwaHur8t+4ZODaE=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type:MIME-Version; b=SXO0pRgrWwTKEr+LRcyC+QZIglj7PKUiY3qF2VWEGGhRc/4tk6azUnxh+nKTevxkOs98I6da2y6kjpY6xSxbFjrzGI3wflsJwIwo2mSwx29lu+hB2ruDANqWSTZnWdNb6r7cIDWa/cHnYgCqB3ZDs/BYXd8JSxIvF+cHPVAZ+MA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu; spf=pass smtp.mailfrom=cs.wisc.edu; dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b=wNSL114L; arc=fail smtp.client-ip=205.220.165.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.wisc.edu
Received: from pps.filterd (m0316038.ppops.net [127.0.0.1])
	by mx0a-007b0c01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G1pPIL027772;
	Sun, 15 Jun 2025 21:15:56 -0500
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013048.outbound.protection.outlook.com [40.107.201.48])
	by mx0a-007b0c01.pphosted.com (PPS) with ESMTPS id 479ukb2w69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Jun 2025 21:15:56 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRcBHO4fPijV5DrSDNYsM3C9W+WewhES12jiNR+FsLlRDfB/BHvgoVbOWZgvhEoL4KxDWE9avIZck2epx+XQSGWzXlap41AJrE7nJK5zXfP3Bmd3h5DjLE+7MFZ6uZtXaLfpikkK0/naHJlmT9tEmcn/xMdZ09w8fKZjO3fTMq1vor13Q4ejlZFIQ1xzdc5BWgOG1dihsvnFnrKC88vjeaXjW/akzi2JwhdqvEEcrWAAOGvYlwD1q4KjSIrSaI8uhvQg1kDuSBon6dGd/+IMtsFwp6n4c4NSsamGUEw1JaWg6Z8B0vp3D+jS2sjAeKFBALYCp0wz84lAJNu1gnUHeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fmmv32fHnnxtpfeoi7p0Nwqfpog2uBxUwawlhFfMmOY=;
 b=RXMQ8GoAlqw9TrQljTc7jbIoR/yhdWNEEdmSAqNwb4Kqz8T/aKKYdxPYzkmHgWrxhDrS2ig+hNk9eagSlwzVakGvL59xC/3eBEhdNTgQQJH3aAfwDvex6pvCQNjRu4NZ8KOSSWpLFTuo94GQkBXtSHgF9VJ6ISG9peGt4R1VvbFkDn2eQWPvXs/PPa2BaTPPAq2WVW//FHhG76NpfjLrXpdfGCeAjMA/b0YjDIiCSVBXYl0S17pY0x0Gry5O2w2KrEBcJsVtdBg2osDoqxULG7G5GXptWWv+mltPGb0YCAhYyckRaMNY9WLhWoeISlas9bolOUKEbPOw3VjnVS+I6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs.wisc.edu; dmarc=pass action=none header.from=cs.wisc.edu;
 dkim=pass header.d=cs.wisc.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.wisc.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fmmv32fHnnxtpfeoi7p0Nwqfpog2uBxUwawlhFfMmOY=;
 b=wNSL114LtNy2DXDwxXP6wI+8HuoX4TZXy0yLbimVjl+0NZEts4qY08x8RVCoHkU5VYhgRRmdm3VsN9oe+5kZm6ETcAg/H85ZTmbESjLjQp21tofZ+MXLTX7lw3S9y8Wb96azs1YCE4nDe221KSyyIJiGyUydoucZvU+qbYexfC+tmPXcPpkG/8O+62UwL9jsO5esOTbiqVPa/cGBIVCyJe2kHupzsTOlVBNz+SfqwOUZNKNa+G3ep/xOh4ZXJTQrVlZueJyuajSXD3wVImcsuN14SDlelfz8CFfa2KoEeB3Tcz+oFv7khMNglOKC7yPGmoxCr5GdAdC+HRsAb40ftg==
Received: from DS7PR06MB6808.namprd06.prod.outlook.com (2603:10b6:5:2d2::10)
 by PH0PR06MB7952.namprd06.prod.outlook.com (2603:10b6:510:c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Mon, 16 Jun
 2025 02:15:51 +0000
Received: from DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c]) by DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c%7]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 02:15:51 +0000
Message-ID: <666eabb6-6607-47f4-985a-0d25c764b172@cs.wisc.edu>
Date: Sun, 15 Jun 2025 21:15:49 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Junxuan Liao <ljx@cs.wisc.edu>
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Autocrypt: addr=ljx@cs.wisc.edu; keydata=
 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
 1LHI6us+ZjzkMldzphVeBsBvT0hcR7u3cA==
Subject: [PATCH 0/1] docs/vfs: update references to i_mutex to i_rwsem
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::21) To DS7PR06MB6808.namprd06.prod.outlook.com
 (2603:10b6:5:2d2::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR06MB6808:EE_|PH0PR06MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: c74f2474-760d-4db3-8b54-08ddac7bb756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|41320700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QW52ZUVRejU1dWduTjMrOWNUVUdzV1FxYmpvSm9CcnhTK2UzRmVDelVNL2hH?=
 =?utf-8?B?b3dnSXFkYjljamJhQ2VxREV3UnJ4bEtpK2l1a3N0cWRNOTVGM1NHQ0tCU21I?=
 =?utf-8?B?bnM4K3YyWUZSUFlCaDRwUVM5MlpJZXA4VDYvSjBQNkpyL2E5UHZIcVZzY1Fj?=
 =?utf-8?B?UTNaM01lek5aMzZvVmlMci9RZTdlcGthWWpNVEtpeTJ4YXJnbmxqTm9LOUs0?=
 =?utf-8?B?Y0ViTnhwSlBIbUhEdXlFYjRsamEwQjBvWndiMnRsM0pnZ0lkbEhFT2lwQyta?=
 =?utf-8?B?T3NZTjhmVjRmaEFiWm4yMnZ6aTZ4bXJ2eWJtc0NWRjJiSFl5emlQWklYMVBw?=
 =?utf-8?B?MWlwbjJxcWF2bGx0bnkrUFM3UWVSVkdQNWkwVS8ybUFUVG0xVWpRVnAvY0NK?=
 =?utf-8?B?Nlp6YjdFc2hlVUFLSVpGZm56L05XcWFPUFllcVo4QjdjSjJSSGNPUzUvMG9o?=
 =?utf-8?B?SGZzRzNpLzR4c3lLSGVJdm8wNGdjSVFZV0dJbFdBSFU0QnJpNFF0anBaL1kw?=
 =?utf-8?B?ZXFwdzY0N0h4WEJ6UmxncFVUTXdWTmQ2UUc0K3ZJdFl3RXkvanVIZ0lrQm80?=
 =?utf-8?B?YmJFaXlka0t0WDB4dE8vc2RUMHZoWk9NZm5UTi9TRUdjUmdVYTVBWDcxRzdY?=
 =?utf-8?B?M2xnSE1Rd3dUdGZVeE1sc0N4RFh6WEtObnlVOHN5Vk85YjNyN2FYWkFteHlL?=
 =?utf-8?B?MWZKZndoZWtDVVl2clRZdURReXZTeHZySFVHVFJnSm50ejB2aDdmbGh2eU1C?=
 =?utf-8?B?WHpuTzV4YXVZcDFhZHF5RmxyTXZEOGpQYXRjcjJsVnVid3haYVd1b2tTVmls?=
 =?utf-8?B?WjhUcXhGOFlwclRJcm5ManYrSGJDNXdwUGxDV1JqQm4zcUd4RGsyemI0VXd0?=
 =?utf-8?B?RE4xM0FvQ3Uzc3BMTWlsdEN5dWZlOHhGQlc4V0h0Q0t5OUxxNDk5TlR5dGk2?=
 =?utf-8?B?QTIxT2tWRlk5alJ1c2JIS3JXUG9UdUlHVGhEa0VRWU94bGhDNnloaUhVNWdw?=
 =?utf-8?B?WnI1VHhQZVFveUd2WHZjOGtUa2VvckdvelhxVm9ZcWtidTBzcm1ncDlDMTBS?=
 =?utf-8?B?VlpES0FmWmdhdEw4bGhsbzN0M2pSTFROam5xNENsbHhjK3dLOWxhNTZ5eU5m?=
 =?utf-8?B?VkVkU1JHQ2MvTlUveFlDYWcvN3UwaUg4M2dWWCt0and3L29PaHFNMzRFTmhz?=
 =?utf-8?B?aWFRRmNkbXB5T3ZCU3VBazhBUjhNRit3aXBrclp4ZXJFcXRFdHgxeGdFZkRJ?=
 =?utf-8?B?MElkWGo4N1hhSUdnZldJZ3pvYWVrWXB3VFAvQnAwaG1TWHpyUzhsYmZGWWFO?=
 =?utf-8?B?VVlZY0ljR3E1dHUxWXNBSHQxWFloOGJ1S0orTkUwRm5wN1Z4ckcwNVFHRHhJ?=
 =?utf-8?B?OURpOWRoVjJXQitHSnlUM01HV1FHd1BDV1BjZ3dhdnJ3TW5neUNjOHkzcks0?=
 =?utf-8?B?bVB1M3lRUSs3eHVZQWhiYW9LWHVUMm12ZnhhT3Q2S0MzSHA1MldqOUhMa0Nt?=
 =?utf-8?B?aTlKdFNwRHBsNGNhakJ4TEM2dVNjWlFqQlphcWFudmY3MFkycko2ZFdUbFFK?=
 =?utf-8?B?QWlCSUtETHRvYWtlRDF4MlUrMnZRQjRFeHRHNm1pNDdFWVpwT0ZpSXZjNFp2?=
 =?utf-8?B?NDlMY0wzTWNNMFZ4eC94MzJLZkNUMEk1Sko5MENEdXlhalh5UjlsV2VxZzBC?=
 =?utf-8?B?RjJqUHdNbHpnZnZPWkZrb0s1VmZrY1Q3MlBaUUZadlcrS245aVJKcW5NaS9v?=
 =?utf-8?B?YkozaHI1SzVpSk9wQlQrYjZ6b1lVais2L1RKOExNak1jU3pjNUVZNC84ekJL?=
 =?utf-8?B?Ly9YODh1N2xMb0Mrd2szZ0NFS0F1eHBMLytobWpEMVF1KzhpR09nRmEySklW?=
 =?utf-8?B?Rk1EUkpEajUyUHgzckl4UENhWkI2RHdEUU1tWC93M05FK1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR06MB6808.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(41320700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bStZbXRtUVJIaDY2dmRkVitNaUdWOHRKSmkzRm9DRW1pVVhQS01NV0tpNCtW?=
 =?utf-8?B?OSs1NnorTlZ3UGhpWVhrYW80b1doc1ZWYjJ0M2plVGNSamNTUk03enB2eGNi?=
 =?utf-8?B?Z1E4K2g5NzlMRHFMRUkyK1NLT2NPN1oxT1VWMzc2WFA2ZS9zMmc5TmZiN3Bv?=
 =?utf-8?B?a2VrOHJQdURvemhEdlRDYzhZeFNsb25rQXMzYXBZZ3VIVlk2VkZuc1p2YTFn?=
 =?utf-8?B?QnVMcjhsM2F6a0t6ekpNeWVMZ2ZDQzlxNS84Vm1QQy95UjVkSHp4MlE3MWJx?=
 =?utf-8?B?OFl0SVJCQkhtQ1RMcGZ6eWUrdE1oOXhKZzVNeGZ5WTN0UklYc1FGV0luWnJz?=
 =?utf-8?B?dmhLVGFlNVZiYUtMbkF3RXhvQXNLSnlnNDI4SGtUMVhCQVJKYVd5TXhGKzhJ?=
 =?utf-8?B?TmVjdWdSbjQxb09DUHJjU29TdEIrREhwYk13YkVvQWplQno4YTJaMDY2aFNH?=
 =?utf-8?B?dDJodDBIZmprMVVNZWtweTZTRWk4SDlLdDU1THhYUmtJZjJqTkVVNjNGbG83?=
 =?utf-8?B?Yy9Odmk2VEZjeXBJRjZwSkVhZnZBTTl5bE9yUzNyNmlPRnF4blBzSnFkYlRv?=
 =?utf-8?B?NmV5U1FrVXpMWlJOK0Q2cmpnNzNoU1F4ZGN3Um5lbktybXlnZ2I5aytjN3Nz?=
 =?utf-8?B?U2pXaFcyeXJhVkJzSmJ5aUM1Y0s4a2Q4TTJ4Q0FmTmVLVmdEck5ISWszUkl3?=
 =?utf-8?B?cXYvTVNhcXg3MitJemxMMWVOM3NHaEViSGZWMi9hNTlGemRIUnZhSHJPdksr?=
 =?utf-8?B?T0dFN0hBazNHVU5SS09KczBuNGJJL0ExQVVrLzNUREh0L1FYb0ZPLzZVNHA0?=
 =?utf-8?B?MEhHU3NHbTBFQitGUStXbVpjVWVKdGQ0TGZYaVRaZXpCTDBIaFNlWUh2Q29O?=
 =?utf-8?B?Y0FXbURqNHA0MEJpbldWZ3pzTTRadDNuNDFTbGFzeGlPUHIrSTl5VVNHOGtl?=
 =?utf-8?B?aFU2MXdhUXEvZ2N1M1J6cnFKK2FMeFV5b0FsYTAyL1J5dk9vUmpXWG50YVBt?=
 =?utf-8?B?Qmd6WW1ZTnFSSFVvRnNuQndUUWlFU2YwZTBSZFRVMWVGTVYvK043YU9DeldF?=
 =?utf-8?B?bVNhM3NOSUMyYm1sRTBUQWRBd1RpTS9RNmhyZkpXcVpiTlM2cnJxRkZQN2ds?=
 =?utf-8?B?U3V6YWRaNUdqbUNUbmh6aktybitBN3ZxSnZ0V1N1bE9RZkZhTkVyY1IyemlW?=
 =?utf-8?B?RG5BTnRTWUQ3Y293Q1B5M0lLSkNKclRTdSt0dmZSZDd1eWExc2Q2WGtnUWxS?=
 =?utf-8?B?TG1mL1hxRmhmL3pUa01ZOTgzaFhDVnA5dFlRenBSMnZkUDRreHV1UVV1TWhy?=
 =?utf-8?B?Z3lkRnVsc2F0OHVubUZiWG11Q2V0RUNhSEtzbUd2MUFFN2pxZDlUNlI4QkVa?=
 =?utf-8?B?VkVrem5FUDBkZVhnRUZ0cUNyeFhFMnhMbHl6dlZMMWtrR1ljbjB3NnZqbjl6?=
 =?utf-8?B?b0xILzk3SjVJK1JmVHFncEJZOEdCakc2OHBvaHRGK2lnV2RXa2NSUG9aSkcw?=
 =?utf-8?B?eGdzTG1LZnE0UU9BSnNZaUxtSmVLcC9URnQzcjBzK3pZOGNJVWZJOU0zNTN2?=
 =?utf-8?B?VUxzSDcxK1JySFZGU3MyWTFlRm5KbmxLVmpxQnFSNS90YzRQcGVrK0VXVmhL?=
 =?utf-8?B?SzZYbS9vZ2pHYkdSWWhBTFpLVk1oRGs4MHdvbjhqRWd0T0w0ZENaWXRldjYz?=
 =?utf-8?B?eE9hUTIyQjJaakhSTE8rcVROSDN2WEx5bXJSYUIwT1Q4Mzd4bFdJajh2NWxh?=
 =?utf-8?B?dnIrMDluUHIwRkJjc2dXUXFCTXJiRU83bWhtOEcyQmF1ZkxDVHpucVQ2dTl5?=
 =?utf-8?B?Zmd6bDlEWjdlSmZHdi9pN0ZkNmpBL2tYZ1VHdGM1c1cvUlBZa1Fobm1lV2Uz?=
 =?utf-8?B?akdaZ3AxZ0pjSGZQY0xsZHY2bUUySWpUWGNhVU5UQ0hzdHR3UG8zVjVtQWdu?=
 =?utf-8?B?YTM4aTB3OUwrM0QzNlRySWNXdEhJTS9odWtCZ0UrVGZ3cUEvVHJMYWFtNlRH?=
 =?utf-8?B?NytWUGk2QlpuZWg3STdtZmsrdlRUOHM2U0VZZXN2bngwcGNjeXIvUCswYUVo?=
 =?utf-8?B?ZHZna3FlQk5WU0UxaW1mekNScCt6Mk41L244L3A0WW9ybHB4ZkZIZHlJUHBR?=
 =?utf-8?B?UUs3THdpUzdsN3p6WDliVXhka1dxZDJTcmtQdDJqbVRQdDBVd25uNjBqUEtX?=
 =?utf-8?Q?ztnVeCWeHz5sRtIbxChxIv2Fjw0lq44EqLvc7bln0rkb?=
X-OriginatorOrg: cs.wisc.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c74f2474-760d-4db3-8b54-08ddac7bb756
X-MS-Exchange-CrossTenant-AuthSource: DS7PR06MB6808.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 02:15:51.4437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2ca68321-0eda-4908-88b2-424a8cb4b0f9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +efJ+scuniILaZZXEitETSwLaWD0bHvqbC1G+/DTYq39OwXf6wYgqSkv8vU0wK1I1HAwr10vtzoE4QbO7l35hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR06MB7952
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDAxNCBTYWx0ZWRfX/BI+OlmmMlXI qWmYBUX26RaioJjoXE6KiJbTPxE2gpboqZHdBAFw/IA3C6QPSTAt9qgZzsMMuGWqbnFHt9V6xed /wUWYLZR6BZVW8xIoO6G7r6VuB36j0imNeX3YSwnuS2/E4ZEKfg9K9ALVhaD8J399yZV3BhLIsD
 oJjUVCqwyf6tBDNmzHSsKLrdBfLkvgj+kn3UlcB6l8FJFXYF20387GsHntfJmmr5vEFmp+QXLS2 883jF2eUevtlXVRfOWwY1PMjX0TkdKVPP2WlYjJO8hveFd8SMWyRzJSK2QHiFxWdW1TVJFLkMRy BQy7V+7pQTsLl/VxCaNKHlHbcUooNEnoJvChPGi9Rt0H9zCUkzWLA2taU5xnxuxd8Cnlq+pqAIX
 hL749Il44NXpEWy5nE3tF+iaPtc0wJjeUqUwrOk0+YJJSgRjOWYv6W7WNK/7lh32P0JVoaUa
X-Proofpoint-GUID: a-gQq43_LpSLBdwTdfiXB2r1yFsY1etH
X-Proofpoint-ORIG-GUID: a-gQq43_LpSLBdwTdfiXB2r1yFsY1etH
X-Authority-Analysis: v=2.4 cv=P9A6hjAu c=1 sm=1 tr=0 ts=684f7e5c cx=c_pps a=LawZwnZ+dX5EiMlPDlYRuw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=3-xYBkHg-QkA:10 a=F9RgU50oYH1i7xWnSjAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-15_10,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 suspectscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506160014

Hi!

I'm trying to update the VFS documentation and docstrings about the
non-existent i_mutex. Not sure if the distinction between shared and exclusive
usage of i_rwsem is clear and correct across all the changes though.

For instance, does __d_move expect the two i_rwsem to be held exclusively? It
seems to me __d_unalias only uses inode_trylock_shared on the first argument to
__d_move.

Thanks,
Junxuan

Junxuan Liao (1):
  docs/vfs: update references to i_mutex to i_rwsem

 Documentation/filesystems/vfs.rst |  2 +-
 fs/attr.c                         | 10 +++++-----
 fs/buffer.c                       |  2 +-
 fs/dcache.c                       |  4 ++--
 fs/direct-io.c                    |  8 ++++----
 fs/inode.c                        |  9 ++++-----
 fs/libfs.c                        |  5 +++--
 fs/locks.c                        |  2 +-
 fs/namei.c                        | 22 +++++++++++-----------
 fs/namespace.c                    |  2 +-
 fs/stack.c                        |  4 ++--
 fs/xattr.c                        |  2 +-
 include/linux/exportfs.h          |  4 ++--
 include/linux/fs.h                |  6 +++---
 include/linux/fs_stack.h          |  2 +-
 include/linux/quotaops.h          |  2 +-
 16 files changed, 43 insertions(+), 43 deletions(-)


base-commit: 381011d6ae29857c35cbcd8a4ec6594484ecfc84
-- 
2.49.0


