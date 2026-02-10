Return-Path: <linux-fsdevel+bounces-76862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oM3+AVlui2lhUQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 18:43:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 260EE11E0B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 18:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3B5D303F7F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 17:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8702E38A705;
	Tue, 10 Feb 2026 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h91JlRMy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U6iEM0q9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634B913D638;
	Tue, 10 Feb 2026 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770745419; cv=fail; b=LBuhaLz/VjtFg0cXfSm6UDN1CCQIo94ziogmNo2YnkITjIsKmrcsrz097gL1mg6vYmf2BCRgb2+spzdN4c20A6GH4mXnT5oABDPb90cm18xK8+1pHMQMKAv6As9MZr0OPGb8HFimsx8mzNjpbRGyNiuPpG6BBOd27Agod5qMBQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770745419; c=relaxed/simple;
	bh=nV0T3OC13Di0TaIinpawW6BhXYu+VwssjcMj6bo7SJ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GGqPnFOrL2K/ygB0K+jsA7Brcn3/xcwcYMopTNnQY3A+IA/+ps78i5Qb7et8W91vL/FSWUskDaZpPqaIFkaPMVfWLSPin+g0wZ8U9rW2VoWUNm9pFF98eqQmJURuSkRHQ3KW+PljBhEojn3b7vSwcF7G7SeT7iyG1sKZ8RZA/aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h91JlRMy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U6iEM0q9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61AGjkCj3810107;
	Tue, 10 Feb 2026 17:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=++iCSTh5QD4rHmZU3FNAtk3uv8HG0wJmSMSX1T68szU=; b=
	h91JlRMyGTheuidVu6xD6QSMFEn4qRlK7Q23rAW8snWlgAK5Hjcnnzlbo8BDeCbd
	Vmy66FZRrRf6jQD7G5RH7RGrkN9JLtpNCd/Xoj1+NzZShyuM/et4oIvwO6nJ/jDs
	zbTLjHQ/FTU7cCHE/VupbM0zn0qxuO0rUfnu6no7SG13pfut5lUFurFWvq2dwfGj
	GYhH1E3X1axAjwk6Gm1zf0HTeMEyGs9fAvQGX+jg5zfM0nzzT82LA+zKwELh4dlL
	vBYVJYVmZCPqRchT0OmU3xR+ECBtHUyu8PCq6cnYbqu9wo/uenb2DregHE26x09r
	ZRa1Ow/EgLCVgguap/kIdg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c88fv03qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Feb 2026 17:43:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61AGS2pl033618;
	Tue, 10 Feb 2026 17:43:16 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c824536av-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Feb 2026 17:43:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDhL2NDS+JTli/y4nbphJHhKonI4MyvlnuIer7tnRh7OhHAR6eSr5IYbLn800jG9BBtB+baaHLczntzeJxwmUWfj5s/bwa2Xx+AeDJslmVRT4U2Ry4u2oFE8Hjd765ivlWvEOz+zDeTKfGOfOnuWgCuFPZzHV+iZ6SGqSLFaVvXJNm37iUvOKOVEJU0Y3pz6KiGS8Oo2RRHVAJTkX/xGs4nsmOFf26wV4xPWnVDkkzlaRMNAeIcmdiqkQrkQ6ZZLKhB1HGOnil2tV11vhdF2EbCWLFUz8iDPdWOR8AX/lk746HIToHbYR0cHTdkZG0mJ7FkFu+bZh2O5FyIJykS1IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++iCSTh5QD4rHmZU3FNAtk3uv8HG0wJmSMSX1T68szU=;
 b=UqLz2hoGYIyb5WEePQaDN4RIXpgTplqEzGsxU6KLeFoa2V2GYEhGFjgnY+p5AlwFDbFR2NNzIjuO6T9oGSyhK85sfpx94903tgr5eZddalz1Mx8Home5TSKZP9UoYPWixoq546AsH7NxfEKJtz/UHk5p4CcMkKUWSIysv6D6h3hMMxsbnWCTbXNMMo5lZDHL3D+E96iDhiCqJ0Z2NUGl5MgRC8zId1rZ0jWXybuPOQsNJnZ3+Xd++tKRCUBRB9oHRSfb7t7aGGli9Lkbx9hGlSKmIyFaD7I8F7+v8Z9m0sP9FIX4X5HKD5AR2ZOfYZhYJgOLhmTbjOJK+O9zhY8TRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++iCSTh5QD4rHmZU3FNAtk3uv8HG0wJmSMSX1T68szU=;
 b=U6iEM0q9tAu3PyuTJAz9d36bHoNgNzJs35rlfU0Rsok0CpN1N5ggeCDUvrJ9/XZZ9EbRLIcAH+pJjf/Sq8CY3+mdhlp1TXS7c/Rv9jGtAO72GnCEzIw6/IkOVQKtCsnyvvcQy8oNI02wh4hQw5dVneqGjNguhyOqVtjCX1mfzDE=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DM4PR10MB5942.namprd10.prod.outlook.com (2603:10b6:8:a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 17:43:11 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 17:43:11 +0000
Message-ID: <e817b590-3b41-4403-b17f-3114e04c0e96@oracle.com>
Date: Tue, 10 Feb 2026 09:43:09 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/1] NFSD: Enforce timeout on layout recall and
 integrate lease manager fencing
To: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Christoph Hellwig <hch@lst.de>, Alexander Aring <alex.aring@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260209212618.366116-1-dai.ngo@oracle.com>
 <e957053b-53d2-4291-afaa-d5dc08f8c44b@app.fastmail.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <e957053b-53d2-4291-afaa-d5dc08f8c44b@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0092.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::33) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DM4PR10MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 9acc0239-7bc4-4d23-28cc-08de68cbdbfd
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YnFOdlpWYnNCVFFVSUF2ck13bHU2RDVsZWYvWTNxZHZHQllla0JSa0xOQVp4?=
 =?utf-8?B?dUorNTloVEdBcjRIV0ZlZHJ1QWNjOTdmcVNZd0JHS1VzMkt6T1cxSUVuS3JW?=
 =?utf-8?B?RTRvNVd3a29nL2RrYm9IV21mQmlZVy9LYmJTdTFLVG9pY2kvMzdHUDZjaFZO?=
 =?utf-8?B?bDhaUUtJaUlZWnNKdGo3dlFJdWFyZlJMb2xibXRjVTlnaWVZcWFSYmp3ampM?=
 =?utf-8?B?M21ieXh0SmExWU5iajB4SGZRdG93QWtMRGZvN2d1bSsveGNHdktSL0Rydjdj?=
 =?utf-8?B?YWVHSzlpdnlxRHhDc28za3gyeEUxQk5sTThaY3N6YlFMOE9iT0psZjhXZTJx?=
 =?utf-8?B?bFRVL3J1aWVwYU1Zayt0OWx4VEN1cHlCSEFhcHlzOXNZNmZHK2IweENpNXQx?=
 =?utf-8?B?OXRGc25yT3FZZnZmdHZFV0RodGdVZVBPRTZWVElGSHVLQ1BNVTlxcm9mUm9V?=
 =?utf-8?B?OG5rSm40R0VhNHZuNFFjbGRGUTkrZWJ2NklKeU1OSXM3ZStKY3Zmc1RnVDVj?=
 =?utf-8?B?S2lNd21mQ2xGSnMvZWlURGxmTGkzY1FOTHYzaUFUS2hpYnM4WGpFa0NxeHBl?=
 =?utf-8?B?ZnVRUE5Md1lVOEZjUGZvRGVkbmZzYU8zVDhFNWN0bHBBY1ZabzhNaTJ3VUtv?=
 =?utf-8?B?djcrZkRFd0N3SncwRGJkc2daMkdxOS9FMFBGL2ZqZkVja1JzTEZNeERWbSti?=
 =?utf-8?B?UGMwYkR0QzB2SExpRTM5S2Z4UW9kT1FsT3I2bEFGaDV4TmFsNENIV1lOUnBl?=
 =?utf-8?B?T1gyZkFRTFdEYmE1cTFuRmpscDZCTXZMSzJFb0VLanZWemJoWVRlTmpOTmhp?=
 =?utf-8?B?c2F0Wm41cDk1aTFqMk9KRXFnakdwQ3laSlJIbElxVWFYeG1ZcGRhZWNrV0xx?=
 =?utf-8?B?L3ZYUlF5dURtaVhsN2p1RnhvSDhhZk5OZGJ6WnNwSlFlQ0F3WWxzZmMxN3RS?=
 =?utf-8?B?WmhrYjVyajlzQ0tIdnlvRDEzSGlJcjhIcjd0OFJNVVY5cmVPZGdiYWNlQmd3?=
 =?utf-8?B?VEphTkJhMG5GcEEvcjF1Z2lldDhEdnplZmJxL0cwdjZCSWQxa0pJcXB3MnhN?=
 =?utf-8?B?dXRUdHBqRXlXV1FBMDB6STJkMkVuL05yaXJDSm5wTmpndTU1TzlyN3pQdmZy?=
 =?utf-8?B?ZnNQM3NTaU1DWmxTY0M2WlREb3FUVkFpL3BDbTVRS25wTVdaa3dHWUl2bDE0?=
 =?utf-8?B?bis2OWcrcjdObHVoOXBiaUJWMUtTOTF4V1BFYW9yVmJscld6RjZjNDhOSXdu?=
 =?utf-8?B?L1g5NmVTNG93dFBmNjU2TnRYOGFyTlhKMlBFakhGV3Nzc3NrN0xMU0JHSC9l?=
 =?utf-8?B?bmxDRnJLUU84RVZ3bU5FL25nelYvbnBXdDRxb0ZhK09QQjh3QWxRNlVpelBj?=
 =?utf-8?B?TW9JMlB0Q3JxNHRJSENBSFFlMTZ4dDRXQjNrQ3FHU3BvbCtISUNYWWVPRDE5?=
 =?utf-8?B?WjdodmJhVXpJQzYvcEl5eVMvZTlzbk15cnFMVDlVQlJuaXJTbE4xNUFwNU1N?=
 =?utf-8?B?NzR4bWFtQzNzVzU4QU9RNnVZdlJNLzJPUWcwOHRBQ0t1TFF1SDRaR2JaeEFG?=
 =?utf-8?B?eDJTdm1MQ055QTRJVjZKRkJiOTEzN21ld2E0RFduNkgrUW9Scm90MW5aNjEx?=
 =?utf-8?B?ODdNbEJkTXBzQmttOVpRUHhoYzZGenZkT3UvdFF5bUd5emp6SzN5Z1pTL0hu?=
 =?utf-8?B?eDhFM3pabGZUL3lwSEdBSzVCNnNqbWJhK3lyUlFoMFZUSjlQSlIzM0xHblBS?=
 =?utf-8?B?QlMvM2xoUnhFN09SV0JSek5sNnJNNEw5d0V4VEtWdTlkMGRXQVBKQ0ZKejcz?=
 =?utf-8?B?Z1lBSUp0V1B5RjMweHJhVUVIR2VaNTlCeFlRcHYxTFlFMFFYWUN5dE9wK1VL?=
 =?utf-8?B?RkIrYmlKemlwY1VGa1FKTjJwOTdGMUdsVEl4WUZtczhXckJzZVRRaFFaWkJy?=
 =?utf-8?B?OWNBdXV5UllSUEpuRlI4WmFjVVoyWDNqVHExR3ZMM081STU4clJkNWl1cSty?=
 =?utf-8?B?NDJ6a0lRT29BQUNreVBCZGpMSmRGMG5aV051WVdYNlV5cUwwNDdUQ0hScFBL?=
 =?utf-8?B?dm1mb0NJdGw5TmRXSVNVbHVZK010bmtZME1ydzFWWkxoelFIbHVvRUkwUGtY?=
 =?utf-8?B?OVUwbERralJocHZzV1FISWllbW5OSjRwWmZRTHVNTS93Q1QvdEIwNFJOcUVl?=
 =?utf-8?B?UVE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aWt4MXRPRW9oeWwwc25MUVNMcWk1OFVKOFFwaUZyM2l1T1lhV01TcHQ5clNP?=
 =?utf-8?B?VFc1VUNrZWJ6YVhtQWFnNzltaDErNk9PS3FQTEE3N2cxOFNEMk5VNzJkclN1?=
 =?utf-8?B?bmFBcm83cllJeTFLZjRnMC9SSzJNbDdjZnQ3L2t6emNFS1VPaGRoVDdrRllH?=
 =?utf-8?B?TmwzYzFMWUJORnEyMzRKSkJSaDJpRExHd3ZpclhRNWw3WjhKT0VzbGFEQmp3?=
 =?utf-8?B?VnRkYVVvNlBEWFhrSVlxNkxCSDRLR0tCZ1BKbUZESk9zam83RGlOV0NSYTI1?=
 =?utf-8?B?NkpzWWpmTFc1enZnZ01pZ2hGYmRSWW5yaFZCTFAyalBiTjYyMmdNSEViM3RT?=
 =?utf-8?B?MVRTdWVBZHVrbWFRMEdTNHZ4emJZMUFVOTBHbmZTcDNrS05GYmR6RjUvdEcr?=
 =?utf-8?B?YmE5aVhrbmFpcVFnSWFJbWtZN0VWbE1ucXMyVmJqamQyL0FFdmt2TXQ4VGN5?=
 =?utf-8?B?a1pQYUp4OHBZdVJxOVl6UVdVckRkVitqQzlyVUtTbS94SDA4ZDlBazVJQ1pK?=
 =?utf-8?B?UkJLcWsxR01GNnRrb3BZSktEVWJSVi82S3lpUi9VZ3FXZkdWSWRJNi9YZ0wy?=
 =?utf-8?B?Q0V6b2Z4bk9KaGFuN0RoZlB0Z1d6SXBoaDlkcFVoY2QvQkxUNEtLS2VNbkM0?=
 =?utf-8?B?b1dtNGFFRzlxeVZBeW95R2hHSG5BQWszUDZuVkpVQ0xKbkJBbUZpeDJibis2?=
 =?utf-8?B?cWs4YzV5dzEySTk0NVphbThMWHUrUU51T1R4NXZPbmpUZ3FkS25WNFc0akFk?=
 =?utf-8?B?dlQvV0d2YUp1Z0ZkTXpZbmNtaTJySzN5Mm9WUjA1YW5YTVJ1U0ZmUHJzUlBo?=
 =?utf-8?B?c1hTV2wwS3JTa3YzbUJodzFNZUl2ZnNFeHM1OCttMzc4aGdEN0RwdWdLK3VY?=
 =?utf-8?B?S1ZhRWZlWDRoSHpDRE1PQzBoamFmTVNmVHpxMERpUXF3Rm93dXFEcnR2dE5N?=
 =?utf-8?B?cmFCZGVFSHp5UXFMdEZKL3NKa2ZMODBVUE5wcFUwaHlmbFZ0WWNrNDYvMVRJ?=
 =?utf-8?B?UCtqSVJDZ3laeVVhUmE4WW5JWlNWelQzbW1UUFBDMk1KVzM5N3Azc1NFQWRI?=
 =?utf-8?B?SEtKVGdOWDRMUDBGMTdDMHZkeDh1eENKV3k4bmJ6dXE4Umh4N0JvS0FWdkxi?=
 =?utf-8?B?UEVwUGlVWFo3MisyTFNKRFlUSGhJMlFFVzVZWGg0blZEVCt4cGRTQnFSYVJR?=
 =?utf-8?B?NEtoQjJsUmxzWlVNUnIvMmY3VzdGdCtkN215WEZyWFNCelM2RGYycFVIVWJ1?=
 =?utf-8?B?cHE5alk1NXdlNjNjNE4reEY5T0JSOWVybkJFV0dmQk9NY014OVd4dnBSWjhy?=
 =?utf-8?B?akowdEI5NGdqTHB4aEoyM0p1dE5YelFQQWdUUlhTeGUxYklqOThGdHNmREdu?=
 =?utf-8?B?MWVYRnVCc3NLZW51dGVDUHhKaTdLOHFUYWM4MGtKb1lEUTV1ZVl2TkI1bEJz?=
 =?utf-8?B?M2pFN2c5KzNLTVA3YjYwZG1VTTZuenl6SW03TjNRcE5oR3A4VWllTy9rQ3NB?=
 =?utf-8?B?UlI0ZHEycnFqMlFudCt3U3k3a1BuT09XMjhYUzRpWW1rMVByTG90NkhwdHRI?=
 =?utf-8?B?aDF3WElsY2x3T0Rmd1JSdVNpOTNzUENjaVhjRmV1QXhsQW9qV1RMU2xKVGtQ?=
 =?utf-8?B?S3pBM25yVDZXK3Y3SWM4ZUQrR0YyeGdPZHd3ODViamJ1SEp0b2JTVG5mUmQ1?=
 =?utf-8?B?YVU5Y0p2M1dwN1FDMS9iZ0syRjh3Mlc1cU9DeW5wUFRKTmpzbVRkdVI2KzVy?=
 =?utf-8?B?b3FveXZrRWowdmJWYm5jaVAzR2JEM1YxYjU1Lyt6WkdjS2tzVXEzeXo3TEx3?=
 =?utf-8?B?YXBkajRzNXdGbzlnYUlJS1B5V0hVQm9oSXVrczdzZXVJQjhtRlA2eTJxUyts?=
 =?utf-8?B?UG5TSnlnUEJxa0gySlE5eUF3L3ZmK3BUM3FLQk11TWdidGovajNVVGg4RGlw?=
 =?utf-8?B?UnJPaTlwdjl6bng0L1NJeVY5aktMR20wT05zakJsZ00wd0RGdkw3aWdyME5H?=
 =?utf-8?B?Nm9mRGdRcmFlUStSK1NjTTRxZWg2dTdmL2ltMXhsbzF2QUovUjlKdGJ0d2Zl?=
 =?utf-8?B?NWp2eU9JOXdiUjhUQWNra0V1WHBybU5NdmxXVVl3OTRxR1VPTXo3TTBBN3dl?=
 =?utf-8?B?aG01Y1pQQk1TL0srdnBGYTRYL2ZpUTRodU5TM25CL2RRYWdtM0JjeXNpYUgr?=
 =?utf-8?B?eW5KU052ZEhzZHdOQXdLRk9GdW1hRmZ4WERBd0I3MmdXVkZFRk1PY3hLSmNN?=
 =?utf-8?B?azJBZU1SL2VBSExidk9pZzZPUjVKcG82SzNwMlFTZkN2N3MxVllFbG0zdmh0?=
 =?utf-8?B?Z2EzQWtCT2xZZStXYjlyTEg2RS9CNS9Cb3FKSDlkWE1zWXZTbERNQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fZAVmDSzXw2ANSgTwLzh70yttKhO8D1ViiPckZXCmASqEluZugP4SFQF6be0S6gZZ/dDbS7tgsTR2EQMP9DmphUYjjUaWpyTBqikR51PBhYOVKl4gZ+86rq0qLSPD4u6vcoHF0/pKDIC1z1yhlkUrgJpUjVt0YNTZq4/Yvww/M4YPI6/Dqted2tOgHMT9llP2OtyhS06vLbBXGt33ZTIVEIWo6keeOs/LN8qH+/zfuIFYjl0R6HUAnFG/U9qF1YJ627aaMftTFLC3Wfg5wVfqCxS9aAI7jXQMHt74LvhoTsy7/G+bbgbY5MRrE/q450VwN+DagUY0CNAoYgwiIG/iPrUefIsE0sklp65b0NRnqGT00fhu/LeShhsq9nl8jrBKQ1iFIg9sFjHYzlEjMTRFiAl9iUkBeYF2wNpmrdfrlVrt9tDthOJoh+m2oK5XEBqdNEAogGmkwU5lPD0QfGagQks298K3qwWU5EjIp7d6rnceahyrW14L3mjRp3mJXCIBzONSe7D98sE80zJBDrI8Mw846BqMN6kmzywHtfY1XBv0YHBK12JYfG46jEcACS+vdke9iVjNVWO+2bH2Do4jwgQSC8K2W0H+pNwPSHFGUQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9acc0239-7bc4-4d23-28cc-08de68cbdbfd
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 17:43:11.3546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t25tyWyF+gzEgpgoOsN2q3MworVCpXBztQkctJpJIb28jb4lSF4Ce/9Afe2yswZXx1Ap39C6YFcDeu2myK0VmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5942
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_02,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602100148
X-Proofpoint-ORIG-GUID: WWsdxK1RWCCRbwA2w04AhG_oglIN5XY9
X-Authority-Analysis: v=2.4 cv=Qchrf8bv c=1 sm=1 tr=0 ts=698b6e34 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=d9lTsMz1ApmBsC2hcl8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WWsdxK1RWCCRbwA2w04AhG_oglIN5XY9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE0NyBTYWx0ZWRfX40f4jG52GCGm
 +wpzbeqUVaWzih7T0UkhRGHwER0QZnlFqbJG2jtfAl15YB7TJ/AHQucdDHc3gGVfvkPGM6mPY2p
 AEgg20D+pW9MNTo5pIKtVNhR2r+XlZNcuu1M/xws2fX67vIGV0n/WYvEXNzVrssAr6trd7FsCYS
 NavUaMXOiEOT73JphDTeblowRRcGg+livhIuaERz+uSaBYJhCi5nUTBxSvoHyi+JoboxtHs7kIr
 yljNSSlvqIIVDurZ6aY11RhmKSPzLIG1YJxU6pqy0WGAGDpvR5P8ypTeQrVjVSRYwuQQPcky9he
 NlKJghXQHOKb3/aGdGwMWgGuFWV6vP5z7vi16oGaNaf/OesHTqD8l755gOy1e7lh0L3bnx6C71p
 qMovz4oCl2CkcbTmjl5JqIX3oeKErPla78CVjsOR7G06BwsePs79JY72FmPtJyagtzBZQ7SYTbk
 EdhP13N2PzVIcNwwOfA==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76862-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim,oracle.com:email];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 260EE11E0B6
X-Rspamd-Action: no action


On 2/9/26 4:04 PM, Chuck Lever wrote:
>
> On Mon, Feb 9, 2026, at 4:26 PM, Dai Ngo wrote:
>> When a layout conflict triggers a recall, enforcing a timeout is
>> necessary to prevent excessive nfsd threads from being blocked in
>> __break_lease ensuring the server continues servicing incoming
>> requests efficiently.
>>
>> This patch introduces a new function to lease_manager_operations:
>>
>> lm_breaker_timedout: Invoked when a lease recall times out and is
>> about to be disposed of. This function enables the lease manager
>> to inform the caller whether the file_lease should remain on the
>> flc_list or be disposed of.
>>
>> For the NFSD lease manager, this function now handles layout recall
>> timeouts. If the layout type supports fencing and the client has not
>> been fenced, a fence operation is triggered to prevent the client
>> from accessing the block device.
>>
>> While the fencing operation is in progress, the conflicting file_lease
>> remains on the flc_list until fencing is complete. This guarantees
>> that no other clients can access the file, and the client with
>> exclusive access is properly blocked before disposal.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   Documentation/filesystems/locking.rst |   2 +
>>   fs/locks.c                            |  16 +++-
>>   fs/nfsd/blocklayout.c                 |  41 +++++++--
>>   fs/nfsd/nfs4layouts.c                 | 127 +++++++++++++++++++++++++-
>>   fs/nfsd/nfs4state.c                   |   1 +
>>   fs/nfsd/pnfs.h                        |   2 +-
>>   fs/nfsd/state.h                       |   6 ++
>>   include/linux/filelock.h              |   1 +
>>   8 files changed, 182 insertions(+), 14 deletions(-)
>>
>> v2:
>>      . Update Subject line to include fencing operation.
>>      . Allow conflicting lease to remain on flc_list until fencing
>>        is complete.
>>      . Use system worker to perform fencing operation asynchronously.
>>      . Use nfs4_stid.sc_count to ensure layout stateid remains
>>        valid before starting the fencing operation, nfs4_stid.sc_count
>>        is released after fencing operation is complete.
>>      . Rework nfsd4_scsi_fence_client to:
>>           . wait until fencing to complete before exiting.
>>           . wait until fencing in progress to complete before
>>             checking the NFSD_MDS_PR_FENCED flag.
>>      . Remove lm_need_to_retry from lease_manager_operations.
>> v3:
>>      . correct locking requirement in locking.rst.
>>      . add max retry count to fencing operation.
>>      . add missing nfs4_put_stid in nfsd4_layout_fence_worker.
>>      . remove special-casing of FL_LAYOUT in lease_modify.
>>      . remove lease_want_dispose.
>>      . move lm_breaker_timedout call to time_out_leases.
>> v4:
>>      . only increment ls_fence_retry_cnt after successfully
>>        schedule new work in nfsd4_layout_lm_breaker_timedout.
>> v5:
>>      . take reference count on layout stateid before starting
>>        fence worker.
>>      . restore comments in nfsd4_scsi_fence_client and the
>>        code that check for specific errors.
>>      . cancel fence worker before freeing layout stateid.
>>      . increase fence retry from 5 to 20.
>>
>> NOTE:
>>      I experimented with having the fence worker handle lease
>>      disposal after fencing the client. However, this requires
>>      the lease code to export the lease_dispose_list function,
>>      and for the fence worker to acquire the flc_lock in order
>>      to perform the disposal. This approach adds unnecessary
>>      complexity and reduces code clarity, as it exposes internal
>>      lease code details to the nfsd worker, which should not
>>      be the case.
>>
>>      Instead, the lm_breaker_timedout operation should simply
>>      notify the lease code about how to handle a lease that
>>      times out during a lease break, rather than directly
>>      manipulating the lease list.
>> v6:
>>     . unlock the lease as soon as the fencing is done, so that
>>       tasks waiting on it can proceed.
>>
>> v7:
>>     . Change to retry fencing on error forever by default.
>>     . add module parameter option to allow the admim to specify
>>       the maximun number of retries before giving up.
>>
>> v8:
>>     . reinitialize 'remove' inside the loop.
>>     . remove knob to stop fence worker from retrying forever.
>>     . use exponential back off when retrying fence operation.
>>     . Fix nits.
>>
>> diff --git a/Documentation/filesystems/locking.rst
>> b/Documentation/filesystems/locking.rst
>> index 04c7691e50e0..79bee9ae8bc3 100644
>> --- a/Documentation/filesystems/locking.rst
>> +++ b/Documentation/filesystems/locking.rst
>> @@ -403,6 +403,7 @@ prototypes::
>>   	bool (*lm_breaker_owns_lease)(struct file_lock *);
>>           bool (*lm_lock_expirable)(struct file_lock *);
>>           void (*lm_expire_lock)(void);
>> +        bool (*lm_breaker_timedout)(struct file_lease *);
>>
>>   locking rules:
>>
>> @@ -417,6 +418,7 @@ lm_breaker_owns_lease:	yes     	no			no
>>   lm_lock_expirable	yes		no			no
>>   lm_expire_lock		no		no			yes
>>   lm_open_conflict	yes		no			no
>> +lm_breaker_timedout     yes             no                      no
>>   ======================	=============	=================	=========
>>
>>   buffer_head
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 46f229f740c8..9ec36c008edd 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -1524,6 +1524,7 @@ static void time_out_leases(struct inode *inode,
>> struct list_head *dispose)
>>   {
>>   	struct file_lock_context *ctx = inode->i_flctx;
>>   	struct file_lease *fl, *tmp;
>> +	bool remove;
>>
>>   	lockdep_assert_held(&ctx->flc_lock);
>>
>> @@ -1531,8 +1532,19 @@ static void time_out_leases(struct inode *inode,
>> struct list_head *dispose)
>>   		trace_time_out_leases(inode, fl);
>>   		if (past_time(fl->fl_downgrade_time))
>>   			lease_modify(fl, F_RDLCK, dispose);
>> -		if (past_time(fl->fl_break_time))
>> -			lease_modify(fl, F_UNLCK, dispose);
>> +
>> +		remove = true;
>> +		if (past_time(fl->fl_break_time)) {
>> +			/*
>> +			 * Consult the lease manager when a lease break times
>> +			 * out to determine whether the lease should be disposed
>> +			 * of.
>> +			 */
>> +			if (fl->fl_lmops && fl->fl_lmops->lm_breaker_timedout)
>> +				remove = fl->fl_lmops->lm_breaker_timedout(fl);
>> +			if (remove)
>> +				lease_modify(fl, F_UNLCK, dispose);
>> +		}
>>   	}
>>   }
>>
>> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
>> index 7ba9e2dd0875..b7030c91964c 100644
>> --- a/fs/nfsd/blocklayout.c
>> +++ b/fs/nfsd/blocklayout.c
>> @@ -443,15 +443,33 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode,
>> struct svc_rqst *rqstp,
>>   	return nfsd4_block_commit_blocks(inode, lcp, iomaps, nr_iomaps);
>>   }
>>
>> -static void
>> +/*
>> + * Perform the fence operation to prevent the client from accessing the
>> + * block device. If a fence operation is already in progress, wait for
>> + * it to complete before checking the NFSD_MDS_PR_FENCED flag. Once the
>> + * operation is complete, check the flag. If NFSD_MDS_PR_FENCED is set,
>> + * update the layout stateid by setting the ls_fenced flag to indicate
>> + * that the client has been fenced.
>> + *
>> + * The cl_fence_mutex ensures that the fence operation has been fully
>> + * completed, rather than just in progress, when returning from this
>> + * function.
>> + *
>> + * Return true if client was fenced otherwise return false.
>> + */
>> +static bool
>>   nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
>>   {
>>   	struct nfs4_client *clp = ls->ls_stid.sc_client;
>>   	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
>>   	int status;
>> +	bool ret;
>>
>> -	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev))
>> -		return;
>> +	mutex_lock(&clp->cl_fence_mutex);
>> +	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev)) {
>> +		mutex_unlock(&clp->cl_fence_mutex);
>> +		return true;
>> +	}
>>
>>   	status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev,
>> NFSD_MDS_PR_KEY,
>>   			nfsd4_scsi_pr_key(clp),
>> @@ -470,13 +488,22 @@ nfsd4_scsi_fence_client(struct
>> nfs4_layout_stateid *ls, struct nfsd_file *file)
>>   	 * PR_STS_RESERVATION_CONFLICT, which would cause an infinite
>>   	 * retry loop.
>>   	 */
>> -	if (status < 0 ||
>> -	    status == PR_STS_PATH_FAILED ||
>> -	    status == PR_STS_PATH_FAST_FAILED ||
>> -	    status == PR_STS_RETRY_PATH_FAILURE)
>> +	switch (status) {
>> +	case 0:
>> +	case PR_STS_IOERR:
>> +	case PR_STS_RESERVATION_CONFLICT:
>> +		ret = true;
>> +		break;
>> +	default:
>> +		/* retry-able and other errors */
>> +		ret = false;
>>   		nfsd4_scsi_fence_clear(clp, bdev->bd_dev);
>> +		break;
>> +	}
>> +	mutex_unlock(&clp->cl_fence_mutex);
>>
>>   	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
>> +	return ret;
>>   }
>>
>>   const struct nfsd4_layout_ops scsi_layout_ops = {
>> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
>> index ad7af8cfcf1f..3aceae6bf1af 100644
>> --- a/fs/nfsd/nfs4layouts.c
>> +++ b/fs/nfsd/nfs4layouts.c
>> @@ -177,6 +177,13 @@ nfsd4_free_layout_stateid(struct nfs4_stid *stid)
>>
>>   	trace_nfsd_layoutstate_free(&ls->ls_stid.sc_stateid);
>>
>> +	spin_lock(&ls->ls_lock);
>> +	if (ls->ls_fence_in_progress) {
>> +		spin_unlock(&ls->ls_lock);
>> +		cancel_delayed_work_sync(&ls->ls_fence_work);
>> +	} else
>> +		spin_unlock(&ls->ls_lock);
>> +
>>   	spin_lock(&clp->cl_lock);
>>   	list_del_init(&ls->ls_perclnt);
>>   	spin_unlock(&clp->cl_lock);
>> @@ -271,6 +278,9 @@ nfsd4_alloc_layout_stateid(struct
>> nfsd4_compound_state *cstate,
>>   	list_add(&ls->ls_perfile, &fp->fi_lo_states);
>>   	spin_unlock(&fp->fi_lock);
>>
>> +	ls->ls_fence_in_progress = false;
>> +	ls->ls_fenced = false;
>> +	ls->ls_fence_secs = 0;
>>   	trace_nfsd_layoutstate_alloc(&ls->ls_stid.sc_stateid);
>>   	return ls;
>>   }
>> @@ -747,11 +757,9 @@ static bool
>>   nfsd4_layout_lm_break(struct file_lease *fl)
>>   {
>>   	/*
>> -	 * We don't want the locks code to timeout the lease for us;
>> -	 * we'll remove it ourself if a layout isn't returned
>> -	 * in time:
>> +	 * Enforce break lease timeout to prevent NFSD
>> +	 * thread from hanging in __break_lease.
>>   	 */
>> -	fl->fl_break_time = 0;
>>   	nfsd4_recall_file_layout(fl->c.flc_owner);
>>   	return false;
>>   }
>> @@ -782,10 +790,121 @@ nfsd4_layout_lm_open_conflict(struct file *filp, int arg)
>>   	return 0;
>>   }
>>
>> +static void
>> +nfsd4_layout_fence_worker(struct work_struct *work)
>> +{
>> +	struct delayed_work *dwork = to_delayed_work(work);
>> +	struct nfs4_layout_stateid *ls = container_of(dwork,
>> +			struct nfs4_layout_stateid, ls_fence_work);
>> +	struct nfsd_file *nf;
>> +	struct block_device *bdev;
>> +	LIST_HEAD(dispose);
>> +
>> +	spin_lock(&ls->ls_lock);
>> +	if (list_empty(&ls->ls_layouts)) {
>> +		spin_unlock(&ls->ls_lock);
>> +dispose:
>> +		/* unlock the lease so that tasks waiting on it can proceed */
>> +		nfsd4_close_layout(ls);
>> +
>> +		ls->ls_fenced = true;
>> +		ls->ls_fence_in_progress = false;
>> +		nfs4_put_stid(&ls->ls_stid);
>> +		return;
>> +	}
>> +	spin_unlock(&ls->ls_lock);
>> +
>> +	rcu_read_lock();
>> +	nf = nfsd_file_get(ls->ls_file);
>> +	rcu_read_unlock();
>> +	if (!nf)
>> +		goto dispose;
>> +
>> +	if (nfsd4_layout_ops[ls->ls_layout_type]->fence_client(ls, nf)) {
>> +		/* fenced ok */
>> +		nfsd_file_put(nf);
>> +		goto dispose;
>> +	}
>> +	/* fence failed */
>> +	bdev = nf->nf_file->f_path.mnt->mnt_sb->s_bdev;
>> +	nfsd_file_put(nf);
>> +
>> +	pr_warn("%s: FENCE failed client[%pISpc] device[0x%x]\n",
>> +		__func__, (struct sockaddr *)&ls->ls_stid.sc_client->cl_addr,
>> +		bdev->bd_dev);
>> +	/*
>> +	 * The fence worker retries the fencing operation indefinitely to
>> +	 * prevent data corruption. The admin needs to take the following
>> +	 * actions to restore access to the file for other clients:
>> +	 *
>> +	 *  . shutdown or power off the client being fenced.
>> +	 *  . manually expire the client to release all its state on the server;
>> +	 *    echo 'expire' > proc/fs/nfsd/clients/clientid/ctl'.
>> +	 */
>> +	ls->ls_fence_secs <<= 1;
>> +	if ((!ls->ls_fence_secs) || (ls->ls_fence_secs > 3600))
>> +		ls->ls_fence_secs = 1;
> Instead of resetting to 1 second, just let it remain at the maximum.
>
> Assuming you meant 3600 seconds and not 3600 jiffies, is an hour
> between retries too long? Maybe the maximum should be capped at 3
> minutes or something? Opinions?
>
> Let's define a constant somewhere to document the maximum number of
> timeout seconds.

Fix in v9.

>
>
>> +
>> +	mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, ls->ls_fence_secs);
> Since mod_delayed_work() takes jiffies as its third argument,
> you need a "* HZ" here.

Fix in v9.

>
>
>> +}
>> +
>> +/**
>> + * nfsd4_layout_lm_breaker_timedout - The layout recall has timed out.
>> + * @fl: file to check
>> + *
>> + * If the layout type supports a fence operation, schedule a worker to
>> + * fence the client from accessing the block device.
>> + *
>> + * This function runs under the protection of the spin_lock flc_lock.
>> + * At this time, the file_lease associated with the layout stateid is
>> + * on the flc_list. A reference count is incremented on the layout
>> + * stateid to prevent it from being freed while the fence worker is
>> + * executing. Once the fence worker finishes its operation, it releases
>> + * this reference.
>> + *
>> + * The fence worker continues to run until either the client has been
>> + * fenced or the layout becomes invalid. The layout can become invalid
>> + * as a result of a LAYOUTRETURN or when the CB_LAYOUT recall callback
>> + * has completed.
>> + *
>> + * Return true if the file_lease should be disposed of by the caller;
>> + * otherwise, return false.
>> + */
>> +static bool
>> +nfsd4_layout_lm_breaker_timedout(struct file_lease *fl)
>> +{
>> +	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
>> +
>> +	if ((!nfsd4_layout_ops[ls->ls_layout_type]->fence_client) ||
>> +			ls->ls_fenced)
>> +		return true;
>> +	if (ls->ls_fence_in_progress)
>> +		return false;
>> +
>> +	INIT_DELAYED_WORK(&ls->ls_fence_work, nfsd4_layout_fence_worker);
> Can this INIT_DELAYED_WORK be moved to nfsd4_alloc_layout_stateid() ?
> INIT at allocation time is more conventional and safer.

Fix in v9.

>
>
>> +
>> +	/*
>> +	 * Make sure layout has not been returned yet before
>> +	 * taking a reference count on the layout stateid.
>> +	 */
>> +	spin_lock(&ls->ls_lock);
>> +	if (list_empty(&ls->ls_layouts)) {
>> +		spin_unlock(&ls->ls_lock);
>> +		return true;
>> +	}
>> +	refcount_inc(&ls->ls_stid.sc_count);
>> +	ls->ls_fence_in_progress = true;
>> +	spin_unlock(&ls->ls_lock);
>> +
>> +	mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, 0);
>> +	return false;
>> +}
>> +
>>   static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
>>   	.lm_break		= nfsd4_layout_lm_break,
>>   	.lm_change		= nfsd4_layout_lm_change,
>>   	.lm_open_conflict	= nfsd4_layout_lm_open_conflict,
>> +	.lm_breaker_timedout	= nfsd4_layout_lm_breaker_timedout,
>>   };
>>
>>   int
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 98da72fc6067..bad91d1bfef3 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2387,6 +2387,7 @@ static struct nfs4_client *alloc_client(struct
>> xdr_netobj name,
>>   #endif
>>   #ifdef CONFIG_NFSD_SCSILAYOUT
>>   	xa_init(&clp->cl_dev_fences);
>> +	mutex_init(&clp->cl_fence_mutex);
>>   #endif
>>   	INIT_LIST_HEAD(&clp->async_copies);
>>   	spin_lock_init(&clp->async_lock);
>> diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
>> index db9af780438b..3a2f9e240e85 100644
>> --- a/fs/nfsd/pnfs.h
>> +++ b/fs/nfsd/pnfs.h
>> @@ -38,7 +38,7 @@ struct nfsd4_layout_ops {
>>   			struct svc_rqst *rqstp,
>>   			struct nfsd4_layoutcommit *lcp);
>>
>> -	void (*fence_client)(struct nfs4_layout_stateid *ls,
>> +	bool (*fence_client)(struct nfs4_layout_stateid *ls,
>>   			     struct nfsd_file *file);
>>   };
>>
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index 713f55ef6554..69beaffd6c78 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -529,6 +529,7 @@ struct nfs4_client {
>>   	time64_t		cl_ra_time;
>>   #ifdef CONFIG_NFSD_SCSILAYOUT
>>   	struct xarray		cl_dev_fences;
>> +	struct mutex		cl_fence_mutex;
>>   #endif
>>   };
>>
>> @@ -738,6 +739,11 @@ struct nfs4_layout_stateid {
>>   	stateid_t			ls_recall_sid;
>>   	bool				ls_recalled;
>>   	struct mutex			ls_mutex;
>> +
>> +	struct delayed_work		ls_fence_work;
>> +	unsigned int			ls_fence_secs;
>> +	bool				ls_fence_in_progress;
> Seems like there are two sources of truth about whether a fence is
> in progress here. Would it make sense to replace ls_fence_in_progress
> with a call to delayed_work_pending() ?

Yes, let just use delayed_work_pending(). Fix in v9.

Thanks,
-Dai

>   
>
>
>> +	bool				ls_fenced;
>>   };
>>
>>   static inline struct nfs4_layout_stateid *layoutstateid(struct nfs4_stid *s)
>> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
>> index 2f5e5588ee07..13b9c9f04589 100644
>> --- a/include/linux/filelock.h
>> +++ b/include/linux/filelock.h
>> @@ -50,6 +50,7 @@ struct lease_manager_operations {
>>   	void (*lm_setup)(struct file_lease *, void **);
>>   	bool (*lm_breaker_owns_lease)(struct file_lease *);
>>   	int (*lm_open_conflict)(struct file *, int);
>> +	bool (*lm_breaker_timedout)(struct file_lease *fl);
>>   };
>>
>>   struct lock_manager {
>> -- 
>> 2.47.3

