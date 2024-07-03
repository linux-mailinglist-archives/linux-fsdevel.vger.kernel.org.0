Return-Path: <linux-fsdevel+bounces-23030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C491492625A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 15:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3A028198C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 13:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB203CF73;
	Wed,  3 Jul 2024 13:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="URxjFeDV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hYrgI6Mm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F06317A5B0;
	Wed,  3 Jul 2024 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014868; cv=fail; b=o8wVyb8G88lFtTnWIbtqxihPrjcAJ4CMDsXWCgxlinq0OtsoYaw2DvXMgEHwsJviNBW953CYa+PhoG3fB6it+wIdo2AaMf8oKlSIhJ85eUooTyZvafTzOyIyTPIJWaiLl87yj+3Cf2fmagG9yYCiHhVgIQIZrPlvUX/iavHQoDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014868; c=relaxed/simple;
	bh=ivg0Zp14Iz3O3LjAfBeX3cVZwdIXA6uIHjTsDF87+Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UUZaDYXfwyVufIPwCOhXWo0VrX5/d7KHvCkYdQdpBA5DT9lq7ylQzClFfl247691OdPUKx/J9a4iVkaOc4D2lWV2q7/WiN+3MDka9cIgJnmnLYl2WWW1AcJwKHWTNUMszaPYoqEif6y4J1gJ75XboizrFhyKsBIY11wBlEJCvjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=URxjFeDV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hYrgI6Mm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4638O8bW017823;
	Wed, 3 Jul 2024 13:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=GYL4CvpnEpRztVpUtqrWXikzMiU1lYoDJL8Y5iwtg7I=; b=
	URxjFeDVqh1QSyeR34LeyJX8yjpG28tIfT6C1oT/GATCLOVAXAgP8HotfJKLdkk8
	8RnnTcYVcjznjA3nSddkIK8L7gl3FTfVdKSstxAYvoivf7vvVFqOB6htejeN//Wy
	9VEsXhAs03+HM1BYpsN6n2tlrA18snYui8wj39tz2AbGbxahn9jcpJxgtXlYr4eO
	OW+VfMwM3nG0htgMma4CNmE//Sv0V31HUbqBCL7v0+hv+t4wESacHU669tjQsUgi
	m/adX7mAiIWJqssFah/pQXRJ3gxoRPapOraF9jm/Xm20liID/PWSUIWtdQNFGqFI
	a5WpbcsvSJTCT3t0ubA0+w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 404nxghs5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 13:54:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 463DSegl023615;
	Wed, 3 Jul 2024 13:54:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n1058mb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 13:54:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0SSRoTuvPrsBLOzczsqO23nK1WmO7W38eqLYMmqV0REJ5Oa7mqoAlHNDiXp51wY8KMJxdNlmNb83xmghDEy+o+WxGbXJrCWokBFZumDv/Li0UlcBE2WouCPoKfL8MzxTX/z0sxSCyO8yl377VR4p7vp1pjmkcrVDKb0Kf/EI5GtPeQfr7hmSIgXixUq9g5rCa4amCjbEjeYi/gAgva3HMecqQHgVw/rUWZwRY+iIofr/ukuLuzuY1GowdhIQub0TWNvE3KrP+S8MsukKh7Fr35uaVxS76N4MLg734+/KDmxPCcW2HXSPgfm4E3ZCNM3n8SnsaPRNbXG38/xq94a9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYL4CvpnEpRztVpUtqrWXikzMiU1lYoDJL8Y5iwtg7I=;
 b=nMBT+cHloC2WB9smrs6ZbzwgOz7xztlix89L9dvp/7nYsOemo/8d8mLMJul1XJAsbyhpAVYWhrIz0oeSOko0yHI5r0xH2Ge1kMRIPno4YcnSCCmqAc6mqfUaW1FkzQ2ypUeu0X9cwap24JrHg0SU7BTmAKdhkveAa8/sd0SKgLojogJmqg5/smuSXNDy0OrBu6kehEVkhx8FOquBuilWzmvPA87mwthdkUGVy1Iv6596btC0XtO8Z3hIP/ae1R/NaD94xlG2EMBqz6eS8OWTLt+8wiMd0Tk3zModbKSnW3f7FbLoJmz4WUFpBu1gexFiTmqlKGyCS9ZFrBrETxOIww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYL4CvpnEpRztVpUtqrWXikzMiU1lYoDJL8Y5iwtg7I=;
 b=hYrgI6Mm+o9369TuuaPk3SfAiDOxDRk2i9KHf5p8Lsu4pnvhgdSLBrEvy5PaXskLu+138Kfx5uZH0H9unfrpLJEWG5yS3cgCXN4qB405IS9Xq16gpQUnVwkkjwMX/rYafKAa1Lq+WtSHlClbm6YYlRggnhnzVAapf6m+6r+C3VA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4777.namprd10.prod.outlook.com (2603:10b6:806:116::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Wed, 3 Jul
 2024 13:53:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 13:53:59 +0000
Date: Wed, 3 Jul 2024 09:53:55 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Aring <alex.aring@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Light Hsieh =?utf-8?B?KOisneaYjueHiCk=?= <Light.Hsieh@mediatek.com>
Subject: Re: [PATCH] filelock: fix potential use-after-free in
 posix_lock_inode
Message-ID: <ZoVX87bMLcCVXPOS@tissot.1015granger.net>
References: <20240702-filelock-6-10-v1-1-96e766aadc98@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240702-filelock-6-10-v1-1-96e766aadc98@kernel.org>
X-ClientProxiedBy: CH0PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:610:b3::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4777:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f0bb0a-c15c-43f3-7436-08dc9b67969a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bDZxZUh4eW1zaFBrL3lGa0NRdklGbUV6OFVPY0VrU2J5TENIakgzWS8zTnVo?=
 =?utf-8?B?OUpoMVV1czd1Uzc2N1ZERXY1NlMwRW1abmR0NjI4YlN5TlhpejdpZ3VKRkJa?=
 =?utf-8?B?MjVlZXhiOXZOc3YwU0ZjblZyOEJ6SlYycHdMa1lTOFJiVi9xNCt6UlU2UU12?=
 =?utf-8?B?V2Ezbmd2QTRJbTRuRlNkYnlsekkrVS8wa1dzUFdDUm9ZcEt3M1NHVmYrTkhY?=
 =?utf-8?B?RGtXcTkxV0tDdlo1dXJTekptamoxZ3V0SUVhcnlObWp3TENPOHRUUlhtSFcr?=
 =?utf-8?B?QmMyOXN1ZVk0Q2huMGtRc0Jxd2c1WlRzVkRlSUhnU2RnYjNzbG40S1BxVFdK?=
 =?utf-8?B?R0Q1MTAwTm5yM3NzUU1aOFMrUlFIYlhaU3M1cGg2UmtkK1pNYk9XWlJwQVQv?=
 =?utf-8?B?Qk9RTFZ3NXMvazRVeGhaK2FyRkVWTWYrcWRqY1U2WTVLUkpLQnlaNmhUZmtn?=
 =?utf-8?B?OWd0MnFlRHBZUms1dmZ3c2tBcXUwOGltdWQ2UEhiT05kYitRaUFFdWdjMHlJ?=
 =?utf-8?B?VTVYM2xFTUlNMFdLdnd6WTE3UXRWWU9WZzZWR2Z2ejgva2NZK2NoSUxITUt5?=
 =?utf-8?B?S2hNU2UrdDVlUEk0ZGhUb0dCRC9lbks4TFBwVjJUdGpiVVVQbm85MytFY3lC?=
 =?utf-8?B?anRQbVRYL2xBS1cvbU8rQXYyYzArMWhWa0pQZzE5QXd6TXRVR3IrdnByWG9z?=
 =?utf-8?B?dEVYRDhXTE5MRWloODR3VS9jNEwzSW5IdThjV0FENExGU1JCemh0ZC9tekdy?=
 =?utf-8?B?RVcvTnFXeUFqQjJnZmQ4Ny82Mi9ibGp1Z2dlMnZvaUpub2hVZ2wwbnM2RDQx?=
 =?utf-8?B?VXBQbWQzeElIcXVtbjlQbHVIQlFqQVFQVDVwQ1lpL1l5TDZTRHJMZFJUcWNj?=
 =?utf-8?B?RmZhZ0s5UWl5NnZ3NWFRTCtjZ0lJU2J4VnBTZERzQjFXcXZNSnFpYm4zL2I4?=
 =?utf-8?B?VWo1eXl4YjNvMWtSRlY0NFVHUlJBUDYrVC9URVBQbERna0N6ZGRRMXlFNVp2?=
 =?utf-8?B?aHJtWGZJV0dXTmJVdE5STjU4YU9uOXg2NXFtV2h3WHpVTWpjWFdGVzNuMUN3?=
 =?utf-8?B?VWo3Y1U3Vmt4MytOOXppWW51RTJTWUlQRHo0Z1NDWS9rWTJJUnhCUGV6NTRx?=
 =?utf-8?B?WHd1NXM4YjFhc3BNaWJhTWVYM1dYNzd5VjJTREtMcmZjWTIrUTNsaUUybFBa?=
 =?utf-8?B?SWdZbHJGemNSZk9UbFkxQjE2UEFPSm9POGlGWDRtNXhrSVpJZHBvUVhzUHlF?=
 =?utf-8?B?SnFmZ1A1RTNrVXFhUUVYUThKMUZOWTFiZk1yZXdnVG1CYklhcGNPUEc3WjhC?=
 =?utf-8?B?STVBa3VKNEtJeFFnVElkcUlhQ1dRNDZaeUExQ2FERVdwTlNnTE1ubWUzUjFr?=
 =?utf-8?B?aWJQKzNpcWtvRWRuRE8rK3A2bU9JN0Jaek1jY3B5R0Y1MmlqOTQvMnY5VkE2?=
 =?utf-8?B?VndBMjRTWFZCYmF3c0FiRHpJV2h6bEZyanBhQzRvb3ZDVUlsSEZaSzFLa2pp?=
 =?utf-8?B?QjVxZU5NdW1iNlJ3TERvdVY0R3lNWGRDR2xBdU1ON2N1Y0pjWW9Oc2QxKytm?=
 =?utf-8?B?M25JbFJyMHYzNHB1VWlWTm9DT0N5aXVCTkM3bDR3TjEvZGE2cE9YSW9rVUFG?=
 =?utf-8?B?SllaNWFCUUVBd25id0VrOXlxOVQ0eUp2WUxYSkRiZWcxQmJnNFBxZTUwV2Uv?=
 =?utf-8?B?N2pHSVFPV1JlR1ZkTEp5NVcxUUZpTnoyV2pzSDVUZ3RwQU1FRDUzaWxZUzVn?=
 =?utf-8?Q?FHTfU4NtlHKulnu6dA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z3lSVWt2S2lrYlgveFRaUnkydWN1SjFIcEJodHEvWDdNblhBTHhkK1l1UkdU?=
 =?utf-8?B?T0RoUjFGWkFNbGJRcHZLRFM1MUJOVTZ5Tk4xWlpQWnlPeDREbjdFYlRCRnZE?=
 =?utf-8?B?cFBUU29Nc2V5RzFUSndNMWpYWHEyZmhYbytub2o3T0hpczNhWmMzaDVyb3VD?=
 =?utf-8?B?dnlaRm4wYmRGWkttR2F3RFk0d0srSnc3aDNENDEzNGFJVFRsTUt2RlQ5NkYx?=
 =?utf-8?B?TnVFS0FDTTYwbjlvQ2dSTkFBL1h6RGJ6T3dsa0VnQi9nd1A3aHA2VmpBY2Ra?=
 =?utf-8?B?b0VtK09UT0ZlTHhMc1RPYWxLaGhvQzNqelpOOXlaY2pqb01oY2l5ZzAzV3E5?=
 =?utf-8?B?b2FPeWxqQU9pbHNKWFMrS0pUeXJuL2MvSFpuWmV2NFdEUEZwQXJhc09Bc2Vk?=
 =?utf-8?B?UEZBTDRJNUY1MkJ2TmZEZXI3TEpQYS92bFhpWEd3VSt3Nm1FWk5UQmw3ZDJr?=
 =?utf-8?B?V0pLZU5IdHI5cVlVb1RYeFpjenIvM3YvNlc1bkxpZU9aQksvdCtjKzFFRHRP?=
 =?utf-8?B?cCtSeHZ5SHZnYmtJSnh2YWhtVVhLS0tzR3A4WGIvcE14N2FwbTlodmtkRS95?=
 =?utf-8?B?d0U4Mjk0M3Bsd3VIQkpHRlVIajJLQ3VITVpNWDR6OXNMcmhuTkFvcmRQS0hC?=
 =?utf-8?B?eEpQc3g3RGtvNVU2MTlGUXZOSjEvK2hTNGtER0NyS1JYaDV2RjdBZExHVEw3?=
 =?utf-8?B?WkFXckZCVU5rR2hjMlhXOXF5cU8vdDk0Rm9HdDBNd3NpNWN5N0IxaVR4alBF?=
 =?utf-8?B?eTdGVUF3bm0yM3ZTYXhPb3JzcXFTZFhNTG92bkk1ZGVwRmt4bDgwTEIyeXFB?=
 =?utf-8?B?QStVWSs0YWlvUzI4czhSbjhZYmo5b1p1MURrbEdYeXJoWVZpUnBPRGlNUFln?=
 =?utf-8?B?VjZCZlFZbnZkazVYdUVDUmFGVmRxU1JXRHRLTTduRGpjL2Nva1gwUkZ4b0tq?=
 =?utf-8?B?ZjAwM3NmaWJXMys2RFFjWmVIRkd5ZTJLSjBzV2RTTlB1YVM1Zk1SU1Q4djU5?=
 =?utf-8?B?SzNJZUlvQWZobklDK0dNMnpTZUxjb3NiL1ZFM0xSd3JUTStWRXZvZVZlNzIw?=
 =?utf-8?B?Z3FTTUdwUk55SHdLUy9xRDc4ZzY3bU5HeksyUkoybVlXblBvWHZPNUhJejUw?=
 =?utf-8?B?QmkvMnB3Sk84V2RrcnZZRkNRMVFMcFdLV2tOY29sK0FOaUp2QTAwVmtRb1Zx?=
 =?utf-8?B?eFNialoxTUtheU9lV0dGL2NWeFRIRWNubXkvSVE3MUtBOXlSWGlLSkhaNDlS?=
 =?utf-8?B?VDFQYTdrV2cvZE1NRE9kNVpFaVhJOTgySnd1NjVlbUdYQzFNWmhFa2NQVkto?=
 =?utf-8?B?TXhjOTArUG9CSDZHZnlvelVXNEZVZ3RtZjE0VG9zTFRlRktpcktoelR3L3Y1?=
 =?utf-8?B?czVDRVNzSm10SkFDanFuSTZFZHZSbXZLQ3RqWktzUDRVTlpFSTVLRTdjbUcy?=
 =?utf-8?B?ZkFwRXlXanhXYmQrNHk3MmxsOXN4OWlkcVl5a05BT3AzK05wVlkxcXNPb2dJ?=
 =?utf-8?B?VlJIMERLNU91NldkbDBadFNkQU0zbDhGVDZtdk5CbmFJZ0FweGFLMDFhRytT?=
 =?utf-8?B?RVl1NmkxRG84cHpvOEhXNGhja3ZuZGtqVTBVcm0zRmd3eGFNeXhMTjRkSEtS?=
 =?utf-8?B?VVBCbVZRbXpycEcrSUVzU2VTZzNLQkJQTmpkS3Zqd2l3cG43ZTMxR2ErM3Ju?=
 =?utf-8?B?TTlYb3Z4VWFmeVJOSEl1SGhwUUE1M0RPSFJFc1FaYkx6MGFKWVdHaWpGOURa?=
 =?utf-8?B?ampmL3d0eUliWGJDQTBlUVNXUEt3TGlCMXMzOVd2TjVYZFk5aTFKeWNRT21L?=
 =?utf-8?B?bWFiNEdnUUxmMmJJTis3TlhEV3g1UllNVWNkRUhMR29scEp6b1V2ZGd6YlBL?=
 =?utf-8?B?VEpJU2pQblZrTXlHcWEwTjZMdXVtWUNtRXRNSndJNlZCbWVjQjVjTTJqWWhU?=
 =?utf-8?B?SHh5RlI5ZEplbTJSM1hDMm5OLzdCZ1NvQVR0V08wcjFXNkxyN2J3N2tNR1dK?=
 =?utf-8?B?VCtOZFpkRWt1OHJSMWxKa1J4Yk93ZG9Qa1haVFA5M3NzYlk3eHlCNHplUlFp?=
 =?utf-8?B?ci8wVUQwTnFWRksyWjhzNGpCUjRCenlXTWdNbUhEdi92US9JcFd3T1lqVHRF?=
 =?utf-8?B?ZGc1VmtnVExTYjFaM1cyazFLS3ZPRFp1OFlrVVFmd25XL0g3TDlJM3JRRDBG?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	k6XZbRyZ+IQ8p0PG4iAqFqN3HiN2v+PVY7kIQBue/AUAC2k5aXZvMrspeGyfeLugXasT6r0XHTgmskT265yLx89Z8MwU8T/xi54SzODoWwToziEAfFlPTjhDfD1WD7C4Y7M4LbHpoXd6RvRMbQe+btSbL/2MPe3032u6OE7Llsm08ei8FoqyH8CZhyrSlxw9hmtwd2//mi22wNNJD9a0jBJ4I8OuSgtulvbd5NFX5+AjCAUgi2Un258Rhu7s6XRy2eJd5iIfzx1jyav2iLr2RNM5PeRIUzEymGm3dy648/Ygy5DMHbcp/oi6Ev4+JoJMfXa0gGGcgyhV+vPf4fd53WgI/1F/EG3klsOy+D/IZQ/9xhC5VxYiEdQQJiiH2/A77AFq4PlohbmzWMEYD03ie0YUYB8se3WlFpxrouPnq8oODl5nawGtPCiiEaG9wdWYXwwsQJlv5fVXy7hK5WOkSMpPhktVdf0FCyfqRISLOHw9yyHm33xaHlWfqbls2JSzMPcsTsrgFVrJrf0cbYt1lr2rTgJRP2OnlXl5rmyyHFl8itiCF5N49U00+hx1W81D02GoXO+vbc7BeoZ2hTHopjq5VApxQbTvxSnkNxisT/c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f0bb0a-c15c-43f3-7436-08dc9b67969a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 13:53:59.1284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+3qTKFAj8y4hJ1uGNPW9jSLQb//7v/lkqXBlvONzdl9oDaQjabmZDVfLYlgzMQZOHMhlkixdqqTbw8b6IpBVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4777
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_09,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407030102
X-Proofpoint-GUID: C5QZmvCujHCR0oAwqispE7FUAxfaUexC
X-Proofpoint-ORIG-GUID: C5QZmvCujHCR0oAwqispE7FUAxfaUexC

On Tue, Jul 02, 2024 at 06:44:48PM -0400, Jeff Layton wrote:
> Light Hsieh reported a KASAN UAF warning in trace_posix_lock_inode().
> The request pointer had been changed earlier to point to a lock entry
> that was added to the inode's list. However, before the tracepoint could
> fire, another task raced in and freed that lock.
> 
> Fix this by moving the tracepoint inside the spinlock, which should
> ensure that this doesn't happen.
> 
> Fixes: 74f6f5912693 ("locks: fix KASAN: use-after-free in trace_event_raw_event_filelock_lock")
> Link: https://lore.kernel.org/linux-fsdevel/724ffb0a2962e912ea62bb0515deadf39c325112.camel@kernel.org/
> Reported-by: Light Hsieh (謝明燈) <Light.Hsieh@mediatek.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/locks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index c360d1992d21..bdd94c32256f 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1367,9 +1367,9 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
>  		locks_wake_up_blocks(&left->c);
>  	}
>   out:
> +	trace_posix_lock_inode(inode, request, error);
>  	spin_unlock(&ctx->flc_lock);
>  	percpu_up_read(&file_rwsem);
> -	trace_posix_lock_inode(inode, request, error);
>  	/*
>  	 * Free any unused locks.
>  	 */
> 
> ---
> base-commit: e9d22f7a6655941fc8b2b942ed354ec780936b3e
> change-id: 20240702-filelock-6-10-3fa00ca4fe53
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

