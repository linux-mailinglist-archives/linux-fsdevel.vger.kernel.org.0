Return-Path: <linux-fsdevel+bounces-75351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJoeER3QdGl6+AAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 14:58:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD987DBF0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 14:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9DA83004D27
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 13:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1762F0C74;
	Sat, 24 Jan 2026 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="DG5sV7E8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021122.outbound.protection.outlook.com [40.107.208.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E29318B99;
	Sat, 24 Jan 2026 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769263124; cv=fail; b=fxvx/4430Nk/yvrsmUuUEqX1Au2Q5kMUjl9ehEZX7Z3d+vYl0sRoUMp2jKYCP4aBLmSYwAAd4eWjsYaaSgSU6WQ0EETk3lN44IUGcP0HEQl9zgg2St/ZZ2uGNmvP5viLTrY3GqEQebpOohWn09vm8XRyCJQOz4KtcWlQhH9xz9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769263124; c=relaxed/simple;
	bh=E8XlzrILn7lff1CgJxG8ifhpnIvSxC7+qdcWLJjUe5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HRUAuoydLeF9UuWEob1nNqzbhWiw0juOtNkDUjpdBB4J8YfR3LIeGGr8TjWGOjO5+siwHW57uS0Iotiertvcg3NuxSN2Wj3hRcuoFYhkHZV2Ef8GD6+ao+05uAVPATrFzQ7silSKuR0q4R7+R6bjuXrcxx3Co6u8wmyoMAojD4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=DG5sV7E8; arc=fail smtp.client-ip=40.107.208.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKCny7UxJJPKueh11CyHByMkencQr0S2PKyzHPraqCTbTRLjTfy/JK+CySx3Biy99ZPHPReS2UIcgX5plJguAQLiZp1HpLtobUNyGblf750RcV5ME9wyzktd//G/QjQUbcm+1wE+Lw7Qiu7G0hcd7VM7SE+xXy1K89FVgib/Qb7Ykp/ZEXfwzp1BaNq7VNYLFwhjIiqxYoF4585zBplRVxYqwjaTseZgEriXImC2rnu80aovJahNYP/MLXjfsOlcjT618H4aa/wiR5qT23MGS/UQgFahAUXjmnSma0HQiAA2tK844z7KfdK3x0RPXH9CigcSfcg76ppLJ08POpB+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yta6A5gt8H1GRhixjwYli/uPFE+RzkwosBf+Ds4QqXo=;
 b=nt4DKHJkeN7QlZnZfs+LOhxagq8wWyLhsxCWeVVJN8h9iu4s0HlPcgPpNQoKv+z6kcBEredvKDVDu1OVDc6jV68kvYzzQQcs9A6vi177+Je5v55Cv96DNAr7G43BsvrSE09bcnlum1kvmdSkn5R1QrQHaIchoxeXJyfav3RWpaYZLhv3s3Bs86fmBGMV7jrNtmodTehmGsLOXArBnuYLBfHRTVvjfN49ztVsGctWKG7QCr53GTiy5nL5MRuG4t6Fn/STwnD/wccFUTjqnf1t8LcCYpuIIoefwMfdFhNzf4Mw7+ZlN7k7pBkcI2j6Xi07V7sQ4kH5lcngUxNrf3+lGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yta6A5gt8H1GRhixjwYli/uPFE+RzkwosBf+Ds4QqXo=;
 b=DG5sV7E8VddLDoil7iWciGZFr4aewv97lHdFgMmXtpFgatdGEFtWf6LEYjTb83h21iVGJUWoey5I2Wh1kWLMTJPEzRmMH0ZPtKiprYSV+VEAIEPeKRX0E238lkFOXy2DyE+gm1+9Nb80patmrWAWKT1n/sc50KTyRUQxyXlNXno=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 DS7PR13MB4768.namprd13.prod.outlook.com (2603:10b6:5:3a6::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.11; Sat, 24 Jan 2026 13:58:35 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.011; Sat, 24 Jan 2026
 13:58:35 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: NeilBrown <neil@brown.name>, Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, Rick Macklem <rick.macklem@gmail.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 3/3] NFSD: Sign filehandles
Date: Sat, 24 Jan 2026 08:58:31 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <686CBEE5-D524-409D-8508-D3D48706CC02@hammerspace.com>
In-Reply-To: <176921979948.16766.5458950508894093690@noble.neil.brown.name>
References: <> <e545c35e-31fc-4069-8d83-1f9585e82532@app.fastmail.com>
 <176921979948.16766.5458950508894093690@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:510:23d::27) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|DS7PR13MB4768:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d19739-ad18-4326-d7a3-08de5b50aac4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L05FZUtYYkJta1hTYTZMSm1pZHdnMVM5YitRNkcwOWtFeldJQWljZnh6a1Jt?=
 =?utf-8?B?QXRZeU1tcER3eXI0QkhYeUlURW1KMjJld3F4VHJpV1Q1bXZQUXoyYUx5V0tv?=
 =?utf-8?B?QnltTnBwZkhPWElRODVTd2Y4Z3ZidEhoTUxlUWF4eHdiTG5XTHVDYUdWSy9H?=
 =?utf-8?B?byt0QlQvN3dsY2lWSWhZczRRQk1ZRnRMVy9KOWFKVWRMTzNYeVgvNEF3WjJt?=
 =?utf-8?B?a2FnNE12cTJESGtKMC9aZFY2SVhYYTVLYUVDazg5cVc3Vm9MVnlNUUhZNS9l?=
 =?utf-8?B?VjVMU3N4ODkvYmE3Z0Rpa21UL2lFRW5rc2ZzVHM1bmZnWlhxMWZBMHdpUWta?=
 =?utf-8?B?ZjJjcUhUZ28xRmVkUFNvZll0RXBQL0Qwb1VvYTNBaVJkdkFGa1htYkVFKzl5?=
 =?utf-8?B?cml6czN0VG9IRlRpVHp2ZTZ2UkU0bHFmdVVGTGdzR1dPY3VPMU9tN2VmbS9D?=
 =?utf-8?B?TXYwYWcyQTl1ODVNRUVJUVp4QXBvRmFHeDdLWEFBajVwOVdpMi9rU2xnbzAw?=
 =?utf-8?B?MGZESEliUGxHMEdJeEpnblNBMC9CNURqSE5PWnAxT3FYYlR0b0dObVlUbFps?=
 =?utf-8?B?am1wQUZTaGNRcTRQOW5TejNuR0FJd0pIK1JUeU9CZjhLbmxtNUwwZGpvMDVx?=
 =?utf-8?B?NGkrMElJbXI5M21SSzhtMzRqNm84anNHSDFxY3hHRHZEbzNVWUtnUXFkci8v?=
 =?utf-8?B?UGxOK294VHdHMTJHSWxmTjhNQ3NoMmxzd3VBOU9VTWxtSlN5dDl1VEJ1M1hC?=
 =?utf-8?B?UjMwZFRNdFZsVEJZSm56ZEpNNGc4dzJVZnY2SXloUjc0S1U3RmlrcDh6djBP?=
 =?utf-8?B?dWQzblFyd2FSemgxbWVvZ0NDOThuemM1eUJaMFFkNUpjZTF3ZlRIZm03eS9C?=
 =?utf-8?B?ZnVhakN0dld5M2IyYWUwWmFYelBOZDhiSTYxWCsrSmpSK2hYeE9COHc1RTBE?=
 =?utf-8?B?ajZwMXJ6REN1ZHNiQkpMNDMvMjNxc3UvOVZkWVJqS1JnbWREemwzRzRmMUMw?=
 =?utf-8?B?YVA5MEJ1Wkd2eTRuYkZqalE4dkFxTGJhME96SFJXUkdsYWhIc2tOWVd1UkVk?=
 =?utf-8?B?TVphdW1nNTkvRmtXRUFQZTZqeDFiWUNsc1dOUGpFWUxJMUFLQjFuczR5SytG?=
 =?utf-8?B?UTY3cm1DOE1XV2MrS2ppTW9CclorQXlJSHIxa3dhaDV5VTdWcGpOQ0tJMEhG?=
 =?utf-8?B?ekx2Yk1oOFlnejkrU3NwVHh0Nk5SQ1dPNXMxRC9TcytaUi85TGVhbzEwTVJ5?=
 =?utf-8?B?ejJldW9LZnVLc0MvMTJHdzlaOFB3bTkwSU1laUZYK1JvQnVMSDhmRW42cGdh?=
 =?utf-8?B?bzY5ZlNuTjcwYTlWZHFYZUZzQ1VrZkFIOEZvc2lLZk80U0Z6TUpzK2x5dGNX?=
 =?utf-8?B?ajd5K1lVWjBPMWJLeXQ1TE5tTnBOZ1QySU5IWmdKblhMUzdyQy9BWUhORVEr?=
 =?utf-8?B?M1p5ejIwOE5kVUpHWklQUjl2OFhxa0NudzNzc2JHVkFCREtHaU5PUDJGQWwv?=
 =?utf-8?B?NlAwY0s0cW1vMnhpZGthMHUvMmVqZDFJZ0hwV3NMOGc1SW9Qb25XUjFYcjJP?=
 =?utf-8?B?MmRyalRkdi9GMVpEanFrL1dzUjZCUGdMb1EwL1B0ZXhjVXFLL0RYUmhkTVVX?=
 =?utf-8?B?YXZDRzRLTWJMN1FPdU5uRFJzNVJrcGZCcHRzNXN0ZlFrRVBaN3pMVnBRVzdY?=
 =?utf-8?B?eG92Q0tjTkFyMnlQdW95K1JBNHl5V0dtc2hXSmRlY2NSVytSbWVxWDFOZXEx?=
 =?utf-8?B?L25wQ3FDUjBsY0JvaS81SFoveVl1SEtTYnRZWnovNnJTblkxY2NoaDFIa1JV?=
 =?utf-8?B?YXR1MmQrVFVoa1BKaFE1WDlRdzhidUlKK3Q5VXR4bm13TnF6M0JhNlVnanBr?=
 =?utf-8?B?UjFvM2tna1AzM3ZkNDJ3MEZ3bWt4aXhDNkpqaERZSDRmNlU2NFlaTnpRUnhu?=
 =?utf-8?B?TWJUT3gwb1dKcUhXNmVqamF4UkR1bW92WkJtTjlMQmpuMHhLa3E2VU12cjRl?=
 =?utf-8?B?Qk9Yc0dOaDJOb053WUZuYnBkTXB5K004NVVpcnd1V2FuUHNNL044NTdBUFg4?=
 =?utf-8?B?ZXdwZmo1WFFKQkJBVzNQYWw1SFZEbEZ6VHlvelE4Sk94T3NUaTlhcC9CLy94?=
 =?utf-8?Q?1PXY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1FyWXVrSGVQd0VCWHExb1I4VFFUWnFIZzl3STAxNlBKQTdUTE1BY0FYTEdD?=
 =?utf-8?B?c1dwQnZzOWNmUkVwQ1NxdXE5bzhOcE9yNmlHWVVpOHRvdlByQnpWaEx0K2Vl?=
 =?utf-8?B?ZWhwNmpwenEyYzQ3bzRXSkJ5ZmpvUFFwbjZ0Y3ljb0N1c0tCUFhYYUIyVVIv?=
 =?utf-8?B?TEdOTGNtZ0MyeHFrRzdlVy9rcGhXSGJiZXZXOUFyaEpqakhVTHV0K0ovU2s2?=
 =?utf-8?B?OVBsR3dSc0RjbnFWaHpKaERPU01oTnE3Mm5VWmdDL1pmOXpUVUpzRGQvcDE2?=
 =?utf-8?B?bzRPeXZHTWtydjNXTU1sVWpPbk1FeTBTbjZRNjUyT0dTWE5CYmNYUENWMVV4?=
 =?utf-8?B?Z2l2a1lVSyt5YmxBQTdPKzlURURwZ2s5dC9ydUx2S3FoWjRnT3pXa1FuWHI2?=
 =?utf-8?B?bzBSN1hIRUR0WkFKUnQ2TnRsQWpVQ0ZyVGp3TGJHTEVkUUxudzFZWFp1T2pW?=
 =?utf-8?B?akVaZ1hVWU9hT0s3OENxbGErcXNMcUZDMUVBdU14NDhxSVozUmk0S1AzWUFL?=
 =?utf-8?B?TklmUGV0Mnh2K2RJOVlWeWk0Y0FneHEzY0IxVmx2aWZTdGZobXA4RUN5ZUUr?=
 =?utf-8?B?SzluTXVza2FNbG5TSGFpTndwRU9Ka3BDTGNWTkdCbDE4MkJkZjE0b1JPWGhn?=
 =?utf-8?B?TXV1aVRqYm5vNTlmTk1sbG9uWUovc3VycDBqYmdWd05sRTMvVWxTTFNPVlhB?=
 =?utf-8?B?b1d5QlBUMllSNzFtVWFVS1Q0eGRzNTdDYjEybGdBRGhqaEd6Y1pkczZaVEYz?=
 =?utf-8?B?RjZQdkgzbGRhOU8rMGhmNUFTSFRPYWFTY21tVG1pVnlINzBpVk80VmoxQ1Nu?=
 =?utf-8?B?YkQ0S0ZNU25pVlgxNTNqK3BjQm1kTk5obmsvLzJEa3hsSG9DYXh5TUk0VmZl?=
 =?utf-8?B?UjlmeEtaWFEwc1lKYTBqUHBLNEduTFVOdVkvbmJVVitzMi9tTFlMV241VzRU?=
 =?utf-8?B?bVlhTWJ4TDBZaXNPbVorUXgwVFNTVXRSUU5tUVZJd00vOW1ZUjVJZEtYc05m?=
 =?utf-8?B?NnM3MFhISVZvN2lTYmd0eXZaODkramZWemtETUNmWktVVG11ckw4VTJiOVpq?=
 =?utf-8?B?OGNHK0dKT2grc3FWM01laDFEOHJXdklSSVJuaHNUdFlDTVdhN2xURTcza2Iz?=
 =?utf-8?B?NXZjSU5wSjlTVFJTY0Q3R0VMOEZQcEpNK3IvYzRvTVlPWU42YlNtOUpWdnYr?=
 =?utf-8?B?UWNmR2FvSFBWTHpqQWVqYTNIUVE1WXJON2NFTEFxbWJseDhsMERYK2QwcUVQ?=
 =?utf-8?B?UlJNL2huT3BzNDJ3YkVvb0s5RkRTallEKzQzWVNYbi9TWXJEWUJpS0N4djRW?=
 =?utf-8?B?eEZzU3A2RGRNWm9wUGk0QjB2MUtyWm01bHk3VzB1bTBjUGdPRThLVFN1Tm0z?=
 =?utf-8?B?T0ZIR1lueFh2dm9wYUlmTnhicDVBMWNTU1VDenJpYW83alp6OVhrUXgyQ0xs?=
 =?utf-8?B?NVNhS0RLTzlGTjBWYWlqcExiSjJSQW9NdG1sY3ZEV0tQcHhTZ04yUm11WEpI?=
 =?utf-8?B?bjRZT0Jra0loWXVnYllhYjBUc24rTDcrVlcwY3ZHdW1za2NFWXI4Nk8reXhv?=
 =?utf-8?B?UVgvMzhCVFpJSDhmQ2tBd2trQUc0bHZENDBCOTRPZTVzOHpBRWlNUmVkQmdD?=
 =?utf-8?B?dm91VnBjUzVyWHF3VEpmTzl2STg5YjFQbHpwLzU0bjVzTnNCeCtISTFCT0Ry?=
 =?utf-8?B?bW1iQnJTNU9hRE1UaWVVem5xU3hhelg4NWY5OENrTFVVVVRSTnlDc0EweVZC?=
 =?utf-8?B?N1pSMG1nUXFEOTZoTGo1RDNuTzhtSFZWNkpJa2pTeGhMbHZnQmtqOVNoSDN0?=
 =?utf-8?B?emZmWWFDSUYwenBOckp5NWxwb3Zjd3hYcEVQa3lxNW42cGttY0hobGxtcW1p?=
 =?utf-8?B?ZER0L0ZJT1NhNGI2RHpQQXFBZVBRVERnUElyUXdhc0xPbVlKS1daa3lodVdU?=
 =?utf-8?B?QVluUEhtcThuU0lJcHFaaU5FZ3dPZTdjeDBwY2phMHFFUW9jNitUTUk0VUxC?=
 =?utf-8?B?YmRPRDhqSEFHckhZSXJxdGJpZ2o1MXp2UE1aL1hWU3JERVZHZjRtcGlNUDc3?=
 =?utf-8?B?dXUrK0RKSDhNMWVkR0FIVEVDdGxWRjJvdEN0QzRBN2FhcU5vS1VydDhNNlJ1?=
 =?utf-8?B?S3Z2cXhLTXYzSm9VbzQ4ZWtKYVNNUGFzSGtNbEpFTlppeDNJZUVGajdyakxC?=
 =?utf-8?B?L2gySnpuaklxRm5DSlgyanN0TnUvZjFvSjA4YTZWcnEzVk5GZFpXaXhYSC9D?=
 =?utf-8?B?SGV4VEE5cVZIb3V4UHVmaWhUVnVmVkNZSGVRRVQvT2poSmVhemlhQW5VUURT?=
 =?utf-8?B?N0lWL1ptdTdIaWMwcmRTdkx2aHZDVlFCcnRzNjczam81dmpVMVd5MitCVTFB?=
 =?utf-8?Q?0MB8rUUXYR9i6FCk=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d19739-ad18-4326-d7a3-08de5b50aac4
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2026 13:58:35.6159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/sekW4W1++2eD9DTeZGdv1BhG2PZ5WBA5Odk6xIhxViXxiFPM6PDCzH/XFKNppATlyFfb6kHSoChj6zElYCUms6y3YCInzbU57g32j3rxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4768
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75351-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6DD987DBF0
X-Rspamd-Action: no action

Hey Chuck and Neil - Sorry to be late responding here..

On 23 Jan 2026, at 20:56, NeilBrown wrote:

> On Sat, 24 Jan 2026, Chuck Lever wrote:
>>
>> On Fri, Jan 23, 2026, at 6:38 PM, NeilBrown wrote:
>>> On Sat, 24 Jan 2026, Chuck Lever wrote:
>>>> On 1/23/26 5:21 PM, NeilBrown wrote:
>>>>> On Sat, 24 Jan 2026, Chuck Lever wrote:
>>>>>>
>>>>>> On Wed, Jan 21, 2026, at 3:24 PM, Benjamin Coddington wrote:
...
>>>>>>>
>>>>>>> +#define FH_AT_NONE		0
>>>>>>> +#define FH_AT_MAC		1
>>>>>>
>>>>>> I'm pleased at how much this patch has shrunk since v1.

Me too, thanks for all the help refining it.

>>>>>>
>>>>>> This might not be an actionable review comment, but help me understand
>>>>>> this particular point. Why do you need both a sign_fh export option
>>>>>> and a new FH auth type? Shouldn't the server just look for and
>>>>>> validate FH signatures whenever the sign_fh export option is
>>>>>> present?

Its vestigial from the encrypted_fh version which required it because the
fsid might be encrypted, so NFSD couldn't look up the export to see if it
was set to encrypt until decrypting the fsid, and needed the auth type to
know if it was encrypted.

>>>>> ...and also generate valid signatures on outgoing file handles.
>>>>>
>>>>> What does the server do to "look for" an FH signature so that it can
>>>>> "validate" it?  Answer: it inspects the fh_auth_type to see if it is
>>>>> FT_AT_MAC.
>>>>
>>>> No, NFSD checks the sign_fh export option. At first glance the two
>>>> seem redundant, and I might hesitate to inspect or not inspect
>>>> depending on information content received from a remote system. The
>>>> security policy is defined precisely by the "sign_fh" export option I
>>>> would think?

Yes, now its a bit redundant - but it could be used to still accept
filehandles that are signed after removing a "sign_fh" from an export.  In
other words, it might be useful to be "be liberal in what you accept from
others".  It would be essential if future patches wanted to "drain" and
"fill" clients with signed/plain filehandles using more permissive policies.
*waves hands wildly*

>>> So maybe you are thinking that, when sign_fh, is in effect - nfsd
>>> could always strip off the last 8 bytes, hash the remainder, and check
>>> the result matches the stripped bytes.
>>
>> I’m wondering why there is both — the purpose of having these two
>> seemingly redundant signals is worth documenting. There was some
>> discussion a few days ago about whether the root FH could be signed
>> or not. I thought for a moment or two that maybe when sign_fh is
>> enabled, there will be one or more file handles on that export that
>> won’t have a signature, and FT_AT_NONE would set those apart
>> from the signed FHs. Again, I’d like to see that documented if that is
>> the case.

Right now no, not that I know of - the root filehandle is the only one, and
its easy to detect.

> I would document it as:
>
>  sign_fh is needs to configure server policy
>  FT_AT_MAC, while technically redundant with sign_fh, is valuable
>   whehn interpreting NFS packet captures.

Yes, it would allow a network dissector to locate and parse the MAC.

>> In addition, I’ve always been told that what comes off the network
>> is completely untrusted. So, I want some assurance that using the
>> incoming FH’s auth type as part of the decision to check the signature
>> conforms with known best practices.
>>
>>> Another reason is that it helps people who are looking at network
>>> packets captures to try to work out what is going wrong.
>>> Seeing a flag to say "there is a signature" could help.
>>
>> Sure. But unconditionally trusting that flag is another question.
>
> By the time the code has reached this point it has already
> unconditionally trusted the RPC header, the NFS opcode, the '1' in
> fh_version, the fh_fsid_type and the fsid itself.
>
> Going further to trust fh_auth_type to the extent that we reject the
> request if it is 0, and check the MAC if it is 1 - is not significant.

Not a great argument, I know, but I think its nice to keep the standard that
filehandles are independently self-describing.

We're building server systems that pass around filehandles generated by NFSD
and it can be a useful signal to those 3rd-party systems that there's a
signature.  Trond might know more about whether its essential - I'll ask him
to weigh in here.

All said - please let me know if the next version should keep it.

Ben

