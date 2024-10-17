Return-Path: <linux-fsdevel+bounces-32173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3979A9A1CA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 10:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542601C26BEA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 08:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32331D5CDB;
	Thu, 17 Oct 2024 08:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WK43I11h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RUJALRD2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE131D1724;
	Thu, 17 Oct 2024 08:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152524; cv=fail; b=L/PQc+D6BDcWS/j5yZVTcMt6YKHhlqD60dlErSPcqXd6RoOIexoxaeHD3uXh3dbVH7EaKAOtBoFq+90XYJpVNkfnMpalYNo09K8wfzbBU9FY9HYxSAEl6CHcpf3WGhY4sUbt4PGtFjNvoKGx7qvDxJkLecK7+1qpR0wIqd2DGWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152524; c=relaxed/simple;
	bh=Jw8R6EdusD8bNL76rNmrXLbAgHhXoZjhHeh3phwGCVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KmjnG506gD6uf7MH/DpJABdO77zs9U25TpJ3k8AyAb3jsEFeP08n50jpqGnF/ppnm4hcHJ/d5NqDY4nU8FckUKOuK1OUDCZWX8jIkm/bdL3xrR/tm6F28WYfAnFECmKDoQYCY5ZfS84z1cCuqrw/v3UEY3vDJNVMtWXzPxqpPoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WK43I11h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RUJALRD2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H7fei3031840;
	Thu, 17 Oct 2024 08:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Y2vnmh5xn65IDkwHYClzsVfYysubKojclXI8egvId5A=; b=
	WK43I11h20k3nD1ZXTsnWj2JcfyU9ASeLfC4LjkEL8uOyybhAECNzexhO56hbK2L
	2P0EadjTclmIQoY9f7IO1GXdoDWzDpUvXVtL5cDxLyu0vV1/bXI1ycPH/IY43+fI
	C7083aT9tqu94rVw8zLaKXUjkaB+3ywE/X8gjnATPWidkB9ILfV4QnpRE9/11fQa
	fwZXLVbc1/8zAA3oWR9UV012N+41KcBVRMfHmD0YAZTdIirBSGzpTY/aYz9+66v7
	IUOfCtpev0Ie75ZqJ9VB1O+LnOe7SoNxAVL0asyXf+H0Ri75EbHsvTj1qtPP8TXL
	WwOAuim8zEulSNngvRFYzg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hntdq28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 08:08:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49H7iRIm014014;
	Thu, 17 Oct 2024 08:08:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj9vceq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 08:08:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2vHwnI5TOiHiNQoALpsBB1F4F3LDQks48R2VwlbIREbfEydvtM1RcgpmBWKBOFDYh6wEuWDIYk/bLr9+sAC5+Nez9kuqMaLiRvxoIMWs8o9hHHueMfUOzd2B00yXLFOIN7zeGf9R6ejMgwZcZDpJ/ctMmvfugYdv0d53jNa/IGotTuFP7zT7mDcAjOoYbsRUb1Nr5Cto2Woi0YVQCqLeAbyblkVDM6N0ay1dBn7YeimiBlAAvK5Uk5clMmHxg5PQAimC2lUn3N1aPQ291xDBd9nm8qX04U3oZT1AosndaCqXMAqW6iz6KTHn5CmWaGrhLVSMQeM09elLV2EFNQ60w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2vnmh5xn65IDkwHYClzsVfYysubKojclXI8egvId5A=;
 b=ltp2gq38kO13c0zimfI9m3SSYhBUmvPHWrXwS88Ee8nzWj9Uddiojeo/MNDE6IkOkreA1hvBOV8gISq2Kr1MLkGrnfEez+NLaI0sVtDlKfN2br8M4TCssJqFG9KfFYqL7yk9yfyCaSGSHqn7f/ntLs8qcUznXPPkyVj3Sax/mo4+jjrpGlfx0SbDKRbNtBRT9EqvJOv9mZyAO06QQhpOaR1Jr3SQw3lZjmfbJEmoB34Wymga7awRt9xOGW4kkqoPhl09JFqjG1aMt3CcKPtC0RovRbezY1vHtw08TItEg73tvZr+YsRbtCUIAPfv6aW1z+rbW/RoRr0nqW3T+IepZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2vnmh5xn65IDkwHYClzsVfYysubKojclXI8egvId5A=;
 b=RUJALRD2QaT4jHL9wmpQseLMdbH3GmdofVFpcOPaOwTYyFGLbog7e4zI8GjHLw8S+whobSOf4UmYZ3Q8Zj2LRF72fZnRJ5/a2IhM9lbuvb4pGi/fNeYNNj511wfR5g9vgd1IUjyWKR1i9QDNW/b3Bg3vXgTceeuF4Z3piKuc9Wo=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH0PR10MB7079.namprd10.prod.outlook.com (2603:10b6:510:28a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 08:08:22 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 08:08:22 +0000
Date: Thu, 17 Oct 2024 09:08:19 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>
Subject: Re: [PATCH v3 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
Message-ID: <6080fb15-9073-461c-a87d-80e6daa326e6@lucifer.local>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
 <a6133831-3fc3-49aa-83c6-f9aeef3713c9@lucifer.local>
 <84c0de17-899e-46fd-8b72-534d8a02c259@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84c0de17-899e-46fd-8b72-534d8a02c259@linuxfoundation.org>
X-ClientProxiedBy: LO4P123CA0450.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::23) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH0PR10MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a1bbc63-cb98-4a8e-7313-08dcee82de45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0Rtb1E3U3IyeE5pYSswM0dNd3phMktCT1J4S1JwVVpVVUQvaXN2Ymp1YW0y?=
 =?utf-8?B?K1YzdGJWWGNyVEpKdjI5Mk1CK3ZOc1A1RDhMS0FhQmlpK3F4RHRhdGVtcDhh?=
 =?utf-8?B?eU1ubjR4NXkwU1JXQXBmVWY0eERtUEdWMXJ6VGNzeGZwbFg5Y1FtR2dJRDJO?=
 =?utf-8?B?bmZGZkVGQzA1eit1Qm10eVYvYU1rVFlZWU9HV3JOVWJ2eGZqOXJjVUpVZjhm?=
 =?utf-8?B?T29uYUNNREFIbFQ3bjJ6SnFZZlFncE9mYllnQm9WRUdveUlNQWhmUUFOK2FQ?=
 =?utf-8?B?cWU3dVE1K3B0V1hPaFdPVlpJOVZJc0laL3JEYVhXOXBoWnltZVp1NDJ6Smpq?=
 =?utf-8?B?VlVMT01tbCsrN01PZkNjMXV6WExHLzhwT2pyVWw3UDVCZ04zUVBQcHNuRlpv?=
 =?utf-8?B?VXllMEMxdnV3OU9UY0oyTkJuVWw2VWRKTzNVWCszd29vNFJSSnh5ODlGSitM?=
 =?utf-8?B?SS95SmNsZTdDd0lkVnpZbGJJWVFjSUljOUs2cHpxUStOVkZicHVqdDhNOVhN?=
 =?utf-8?B?aTU1ZVp0OEVLblh3SGZSZEhUN3UwdXcyOUtPb3crWW9ERTkzYStoWVhXb3or?=
 =?utf-8?B?VWlnVFBTbVQ1ODRmZWd5UTFQSmF4a1J3Y1NsdVU1eHZpWEMvQVpjVzFFYUx5?=
 =?utf-8?B?S3RKSFNQY0FYQmRFRHkwZFMxUVJ5TkdxKy93WkYwZ1phRCs2R1lZWUNwS3RW?=
 =?utf-8?B?ck91U0FJM2QzT2EvVjYyRVpMOVA1Rkk2cnE0YjBsTzlnMVhTNVRXV08xTmox?=
 =?utf-8?B?TXJxdEMzdVp5VU9Yc2NDOVJBSnlzVm9nQmpXYk1saUdDanFLRUNzTEl5bmF5?=
 =?utf-8?B?M21acnZlUHU3MWNWMGxjcytHWEJ3VFJ6ZGxDV3VwMzdlSGRIVkwrUHlTZ1pD?=
 =?utf-8?B?NENQL2dTRHpCdmNaaGduSmNOUkxDRkdLRFdLODFVU0JocVBzUkRWS1BSQ1Q5?=
 =?utf-8?B?bE82OXhHVXpnTm5YY0ZHQ1hFb0F0aDVmMEhtRTQvT3hhaTNNSzk2WjUrVFN0?=
 =?utf-8?B?QXVMRzQ1Y0VPVjMyRFlvTHRDWXJlMWlBSGs5cGY0by9DZ2wraHRDM0RhRE5R?=
 =?utf-8?B?SDNHcFJwb1JmMFZkTWRTSGppYm50MnNibXE4Sk9IS0hUNm8rWlpoS0MvbDgr?=
 =?utf-8?B?UmpkYklhY3dDMmN4ek9nYlN0Y2FoRnBjWm96RFBzK1IwNk9mSjdSMm1OYUpw?=
 =?utf-8?B?Zk1HdDQ0dWVFTHBZYi9GZ2QySUVNQSs5ZTgvSE13aUV5bzR5UUZodjUrRlZZ?=
 =?utf-8?B?bnBhaG5BOS9XK0J1MGxFeE96V2VjS0RqTUFNZjF4alFoWXk2RHZsdXFWZXMw?=
 =?utf-8?B?dW9yUFl4OUU5bm1zK3JmdFcrZHl6NjM3WmNna3FjVnZweDZrNWx4Witrb25w?=
 =?utf-8?B?VDE4UDNYdVducVN6dGRMWngySXczbUVlRmhzK3B6ajBhbGFDazQwNkFFUGpU?=
 =?utf-8?B?cVdkTkxJaGFEMWNySDk2UXZQR3NNYTJxbnN0M2lSalRONTVQSU8rL3M2YStC?=
 =?utf-8?B?a282azFrOTczZzdtTTRJcmZzMmhpSmlRcktTNlhKS2RZNlRYbEw5UW5id2o5?=
 =?utf-8?B?YURnTHlmTXpQdURidWxPNWhHRTNYRUcrL2dOZTViSW0vYXpFNC9weHc2bXhh?=
 =?utf-8?B?UFhtU2tYeXBaL2RJYWNXTDRETjUwem83MVg0SFliaktNc3d4NFZxZzdsUFAr?=
 =?utf-8?B?Qzg0Mzc1WGROTnZyRFhCNy9WVHJqVDMydVFQSzNVVU1OV1ZNN1gxT2JnK0dJ?=
 =?utf-8?Q?TPqrpgrmxSwO+SFDH6K1lF/Kljv2AkgT218oJA1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjNFSGc3enVGQ2lRR2crTFF2OUFUdTd2SFRQc0tMRGdDYk1OLzIvYlZuQjFO?=
 =?utf-8?B?YWJmVkZKVEJEb2xEWmZrcTkzWXhpUHJSS1ZaNzJrcTdTVnpjYWxaTW1HK2U5?=
 =?utf-8?B?c1pRbUk0WFMxUUc4bzZ4VUx1ajdqaDRxT0IzWm5EK2lGOG5OOXA4bU40aUpk?=
 =?utf-8?B?WjJmMzkrSFhRd0dwSk1rR1h5S0NMMGxOTGFlNTBoUUdreHFIdFZnd01MRlFk?=
 =?utf-8?B?WDBOZWVML1ZlVzdlVU1Ubk9lNUNXb1lkTk1FTzMxN1FxVDVtcnRPYVVQbFFh?=
 =?utf-8?B?Zng3TmdkNlFzQTVJSkVsR3RQcjVRY0VEd2hkV3paUlF2U1FQeHkraFZXMmQ5?=
 =?utf-8?B?aE1raXlrRG9GeUo3WE1qQUhoZkhBTndpeWJsU3pyYktvTjM0a3ROK0NkYklT?=
 =?utf-8?B?aURPS2xyQTFGT1ZWUjhPVThRRWZ5TVl3N2h6bWdsVldlcVdzbEVZNTBsc295?=
 =?utf-8?B?TmhrUWVyM2NVbGxIRGhBUGNTNzRMa2w1U1JBVlp4aGwxbnZQWGYvSndyd3Jz?=
 =?utf-8?B?QnRBaU5oVmZtQ0dpUWFucTlsV0o5STVUV0dRZ1ZvdEJQTG95V1lFeWdjWnRR?=
 =?utf-8?B?OExUTGJMeFNPN0ZpdWRFajZ1MFhkMlJxcEVidFUxM2JNOElJVXRvcktvOThH?=
 =?utf-8?B?eG5QRGhNTkxRamJTZU5nQUZwTi93ZTU5T3FqWmFCMUdFd3pYZkVheHlvakR1?=
 =?utf-8?B?T1B4THJQeVQwTWl1R2VmaGVlNmZPRU1JTjZuckRHSlNXVTJBZGVORnFDVjZR?=
 =?utf-8?B?NmI1WHBxS1lzUjFDMGtyeWtrVkI3L3l6cU9DS01VNTVpRnlTWUkxL0RaY1hx?=
 =?utf-8?B?MDlQZjBpSHp6bU0rN3g4eTBIaFRWSi9VaDFKU0dBV2VMejRWWTdjZTRGcXJ2?=
 =?utf-8?B?b0gxYzZ1cGNEbEpMV0swYUZrRUVHK2ZXejdBeDhrRzhoYTd1VDNCNU9HOUh6?=
 =?utf-8?B?YnV0ZDdRbXY4ZC9QWTBGaXNOQVpXcndjS0Zjb05zTmVaVjJobGd1OU5FbVNs?=
 =?utf-8?B?RVJOYTBQRE5TOTQ1WVhaY2F3aE90S1ZiNWJSTkZRMkhhTjVXUThiMlV2Q2c2?=
 =?utf-8?B?eWJuRGZnT3hSN3pGc2tPNlNsK0c4U0YrTm90dVBLZWl5YzQ4VmRVbnNsTm1l?=
 =?utf-8?B?QjFSaE9reWM2TzFzN29oZ09JYldabHdJVE55em1CUERma0J6VmZRQUpDbEkv?=
 =?utf-8?B?OVJjT2taeUYyUFl2dGRRcmQ1ZC9PdmJDSVZleWpFVWk0dlFTbnJ0VHNQRDNl?=
 =?utf-8?B?TEQza2cyV0FoRys1K0c2UjlHQWJoMWR5dERKREZIV0tJYTVGLzVSaVZqbmdB?=
 =?utf-8?B?MHZJWUR3ZGRhd05RZ3NwRU1IOHhNSStwTURMcXNsNTY0T0V0M0RGcGlyMDAr?=
 =?utf-8?B?Ym0wZ2VHYk5renNPRmZ2TGxicUI2dWljOHZxQTM5eEdoTTJDbUZQbCtPMXIv?=
 =?utf-8?B?dUNRZXlEUlEzcHJqdGpMaGYyWXRHcUxRQjNGeWVzdXNDalpzMGdsdVF3SWJQ?=
 =?utf-8?B?Z3RWRnRhR3AyelpxNTcwTW0wWTg3aUE5QXRHcjFXUktxNnJKMVpKemtrZSsy?=
 =?utf-8?B?OWl5cTJkc2JSeVEydHI1UTRjazB6NG1jRzZGVkJSaGVCSUd1TW9xd0lTMVhJ?=
 =?utf-8?B?S2JxcW5NSzIvVzhYZ1N6RUxweXJRV3BKSDFyQXZCcnpjeVA2amxFRDVPejNV?=
 =?utf-8?B?cGlvQmFjM3dTamRwSU5Ed2hpQlFUSFExNXUvRnRrUzBtenVoZit6ekh0U1Mw?=
 =?utf-8?B?Um42ckxjRndSbGl5R3E1aWIrc0gxd2gvUnVIVWdBRjY4OXhiZS9YaXdjbHNN?=
 =?utf-8?B?WVdpaWZtVTd2Qnd0cGtjYVE3RXVyVXFPUUNtbVpsY2EyQzFFYUFmM05BWmxu?=
 =?utf-8?B?WGFrWlp5N3pqMHlpcEJrdEY3WUtGb1FuRjJzZ2JWcW84YmRwN0ppeVU2VE5z?=
 =?utf-8?B?cmY0RHFIT1MzZHdsUDNaMkJzaWlTQ2kyRVlBTXh0NHdxKzZ3M1JZd0tFMGFu?=
 =?utf-8?B?SGplQXdOV2RzSDVwLzAxR21Cc0NiWi9QeGVRRlI5ek5FamlKYWowUkpqTC90?=
 =?utf-8?B?akMxMmF0RlMyZGVUc1RhaGZwa04xWnMxYXRCNkQzTnNYYmNTVy9pK3R3QU5w?=
 =?utf-8?B?QTVPMWxZZEhpNU5jRW5uQSs1OGhJaFFtOTdPRkVETXRvcGYwN3hNcHVRcEJV?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Abrtjz3MNPrU2+mXCqYlzBe47zf3GIwS2qDcFKG/n6y79aa/yX4Z+9ERBzOgNrnVKc6z9sCZTFToLw8xAdvyTe5ZgWk9eSRr13GHQK7IKThz1IDaTbroES44ggv7DYyHchs/6VCPkNaobd9BqiCno+C/CE2E4pQVdB2E51FHNZRhFenrX45Ng43/TcGg6XBw/QzMicpwwjzx9e07z0MzoLJsecYJxzA6rYw9iDxc4BLrsCGn6UwrhBrRFepnDTwbYoGHdAlkyCN/1+9oiT13UtrdAqAHT4ndwccbNNzD98FUL45fwK/UlNkNT/YgvXE9MKDQxwP8pORcarvSNKRgLGGtVbEiHeS05ejMgVXMvw1DciyZhbqZ3spjg0TbdgP2FP/6RRr//nezrXoCzFsQUqUP3NAYrxo67AMZ+2L8jbBkCpDeIHlGuz+T8DKErpAc2otYjJJYpFgB+9hhWxKEaGifQ1qrT1fhCTkulfld8oPTO4dcT9+P0WkL5ZiRerrd8WnMFqDWGZgZaR4Xl4GZrrlwcetLJHD/f3bcuI2q5Sk2jvVvQvKUjRnuG5GXx3Q8lyfTqk6/SoYcLWB887txugHMf22bMX0ZKLGUqkogEVk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1bbc63-cb98-4a8e-7313-08dcee82de45
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 08:08:22.4195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ad6r4OI5dXeEBvDCLMsRobkm5b1+Q52sSVXk9yF6Eh0GPjMk7jMqt2g7bqYIs9vTxrHcC4PGOQ0wu4KYveytkLNvhHks9+4bTCBgRLh1L4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7079
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_06,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170053
X-Proofpoint-ORIG-GUID: YZg3TyyE0FGq1qlkMLg64eZ-eQhFyru8
X-Proofpoint-GUID: YZg3TyyE0FGq1qlkMLg64eZ-eQhFyru8

On Wed, Oct 16, 2024 at 04:38:50PM -0600, Shuah Khan wrote:
> On 10/16/24 16:06, Lorenzo Stoakes wrote:
> > On Wed, Oct 16, 2024 at 02:00:27PM -0600, Shuah Khan wrote:
> > > On 10/16/24 04:20, Lorenzo Stoakes wrote:
> > > > Add tests to assert that PIDFD_SELF_* correctly refers to the current
> > > > thread and process.
> > > >
> > > > This is only practically meaningful to pidfd_send_signal() and
> > > > pidfd_getfd(), but also explicitly test that we disallow this feature for
> > > > setns() where it would make no sense.
> > > >
> > > > We cannot reasonably wait on ourself using waitid(P_PIDFD, ...) so while in
> > > > theory PIDFD_SELF_* would work here, we'd be left blocked if we tried it.
> > > >
> > > > We defer testing of mm-specific functionality which uses pidfd, namely
> > > > process_madvise() and process_mrelease() to mm testing (though note the
> > > > latter can not be sensibly tested as it would require the testing process
> > > > to be dying).
> > > >
> > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > ---
> > > >    tools/testing/selftests/pidfd/pidfd.h         |   8 +
> > > >    .../selftests/pidfd/pidfd_getfd_test.c        | 141 ++++++++++++++++++
> > > >    .../selftests/pidfd/pidfd_setns_test.c        |  11 ++
> > > >    tools/testing/selftests/pidfd/pidfd_test.c    |  76 ++++++++--
> > > >    4 files changed, 224 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
> > > > index 88d6830ee004..1640b711889b 100644
> > > > --- a/tools/testing/selftests/pidfd/pidfd.h
> > > > +++ b/tools/testing/selftests/pidfd/pidfd.h
> > > > @@ -50,6 +50,14 @@
> > > >    #define PIDFD_NONBLOCK O_NONBLOCK
> > > >    #endif
> > > > +/* System header file may not have this available. */
> > > > +#ifndef PIDFD_SELF_THREAD
> > > > +#define PIDFD_SELF_THREAD -100
> > > > +#endif
> > > > +#ifndef PIDFD_SELF_THREAD_GROUP
> > > > +#define PIDFD_SELF_THREAD_GROUP -200
> > > > +#endif
> > > > +
> > >
> > > As mentioned in my response to v1 patch:
> > >
> > > kselftest has dependency on "make headers" and tests include
> > > headers from linux/ directory
> >
> > Right but that assumes you install the kernel headers on the build system,
> > which is quite a painful thing to have to do when you are quickly iterating
> > on a qemu setup.
>
> Yes that is exactly what we do. kselftest build depends on headers
> install. The way it works for qemu is either using vitme-ng or
> building tests and installing them in your vm.. This is what CIs do.
>
> >
> > This is a use case I use all the time so not at all theoretical.
>
> This is what CIs do. Yes - it works for them to build and install
> headers. You don't have to install them on the build system. You
> run "make headers" in your repo. You could use O= option for
> relocatable build.

Right but I'm talking about my local builds in order to test the kernel. See
John's response.

>
> >
> > Unfortunately this seems broken on my system anyway :( - see below.
> >
> > >
> > > These local make it difficult to maintain these tests in the
> > > longer term. Somebody has to go clean these up later.
> >
> > I don't agree, tests have to be maintained alongside the core code, and if
> > these values change (seems unlikely) then the tests will fail and can
> > easily be updated.
> >
> > This was the approach already taken in this file with other linux
> > header-defined values, so we'll also be breaking the precendence.
>
> Some of these defines were added a while back. Often these defines
> need cleaning up. I would rather not see new ones added unless it is
> absolutely necessary.

OK, but just to note that I am now not doing a PIDFD_SELF series, I'm doing a
'PIDFD_SELF and completely change how pidfd does testing' series.

To me the right thing to do would be to send 2 series and not block this one on
this issue.

>
> >
> > >
> > > The import will be fine and you can control that with -I flag in
> > > the makefile. Remove these and try to get including linux/pidfd.h
> > > working.
> >
> > I just tried this and it's not fine :) it immediately broke the build as
> > pidfd.h imports linux/fcntl.h which conflicts horribly with system headers
> > on my machine.
> >
> > For instance f_owner_ex gets redefined among others and fails the build e..g:
> >
> > /usr/include/asm-generic/fcntl.h:155:8: error: redefinition of ‘struct f_owner_ex’
> >    155 | struct f_owner_ex {
> >        |        ^~~~~~~~~~
> > In file included from /usr/include/bits/fcntl.h:61,
> >                   from /usr/include/fcntl.h:35,
> >                   from pidfd_test.c:6:
> > /usr/include/bits/fcntl-linux.h:274:8: note: originally defined here
> >    274 | struct f_owner_ex
> >        |        ^~~~~~~~~~
> >
> > It seems only one other test tries to do this as far as I can tell (I only
> > did a quick grep), so it's not at all standard it seems.
> >
> > This issue occurred even when I used make headers_install to create
> > sanitised user headers and added them to the include path.
> >
> > A quick google suggests linux/fcntl.h (imported by this pidfd.h uapi
> > header) and system fcntl.h is a known thing. Slightly bizarre...
> >
> > I tried removing the <fcntl.h> include and that resulted in <sys/mount.h>
> > conflicting:
> >
> > In file included from /usr/include/fcntl.h:35,
> >                   from /usr/include/sys/mount.h:24,
> >                   from pidfd.h:17,
> >                   from pidfd_test.c:22:
> > /usr/include/bits/fcntl.h:35:8: error: redefinition of ‘struct flock’
> >     35 | struct flock
> >        |        ^~~~~
> > In file included from /tmp/hdr/include/asm/fcntl.h:1,
> >                   from /tmp/hdr/include/linux/fcntl.h:5,
> >                   from /tmp/hdr/include/linux/pidfd.h:7,
> >                   from pidfd.h:6:
> > /usr/include/asm-generic/fcntl.h:195:8: note: originally defined here
> >    195 | struct flock {
> >        |        ^~~~~
> >
> > So I don't think I can actually work around this, at least on my system,
> > and I can't really sensibly submit a patch that I can't run on my own
> > machine :)
> >
> > I may be missing something here.
> >
> > >
> > > Please revise this patch to include the header file and remove
> > > these local defines.
> >
> > I'm a little stuck because of the above, but I _could_ do the following in
> > the test pidfd.h header.:
> >
> > #define _LINUX_FCNTL_H
> > #include "../../../../include/uapi/linux/pidfd.h"
> > #undef _LINUX_FCNTL_H
> >
>
> Does this test really need fcntl.h is another question.
> This is another problem with too many includes. The test
> built just fine on my system on 6.12-rc3 with
>
> +/* #include <fcntl.h> */

Like I said to you above (maybe I wasn't clear?) I tried this and doing this
doesn't work for me, as sys/mount.h implicitly includes this header, and we need
things from that, so we're just broken.

And I cannot submit a series that literally breaks on my machine obviously.

So simply including this header is a no-go here.

I've provided a workaround above. Also John has suggested using the tools/
directory as previously agreed upon. I could remove the linux/fcntl.h dependency
from that and place the header there which is probably the neatest solution.

>
> > Which prevents the problematic linux/fcntl.h header from being included and
> > includes the right header.
> >
> > But I'm not sure this is hugely better than what we already have
> > maintinability-wise? Either way if something changes to break it it'll
> > break the test build.
> >
>
> If these defines are in a header file - tests include them. Part
> of test development is figuring out these problems.

Right but part of a series introducing a new feature isn't to permanently break
tests from working.

And the includes are in that UAPI-exposed header file they're pretty much set in
stone or risk breaking userland.

>
> > Let me know if this is what you want me to do. Otherwise I'm not sure how
> > to proceed - this header just seems broken at least on my system (arch
> > linux at 6.11.1).
> >
> > An aside:
> >
> > The existing code already taken the approach I take (this is partly why I
> > did it), I think it'd be out of the scope of my series to change that, for
> > instance in pidfd.h:
> >
> > #ifndef PIDFD_NONBLOCK
> > #define PIDFD_NONBLOCK O_NONBLOCK
> > #endif
> >
> > Alongside a number of other defines. So those will have to stay at least
> > for now for being out of scope, but obviously if people would prefer to
> > move the whole thing that can be followed up later.
> >
> > >
>
> I would like us to explore before giving up and saying these will
> stay.

I'm not sure how I'm meant to explore 'this breaks the build on my system'. The
sys/mount.h is a deal-breaker, there are things in there we _need_.

>
> thanks,
> -- Shuah
>

In any case I think copying the header to the tools/ directory with this
linux/fcntl.h in some way stubbed out (we could even stub out fcntl.h
there?) is the sensible way forward.

A 'just include the header' is simply not an option as it breaks the tests.

