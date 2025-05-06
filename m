Return-Path: <linux-fsdevel+bounces-48175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01856AABC29
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBBB3A2CC7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 07:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD7123816E;
	Tue,  6 May 2025 06:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i4AA9Ko7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y/TldRbJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFE01A2643;
	Tue,  6 May 2025 06:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746514705; cv=fail; b=Srdyq8lxw8mFQXTaO2SCCqmsJF/45b4zQ1CHVlJvStvx3hGUF/2vSlgQW7V3Wwbq9sCNO0sSKUbBTBofPo5bmkDOt+pAWXXExJGSX5RjnP4VAygdqimd3s1FBwpzMeEikG1seOM8OP9E97IY6c11677n67hBM0ti7Zjpq1WOr0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746514705; c=relaxed/simple;
	bh=TK4iOgSv35G3SW3NC8zZxywC7qi8dl6dfvn3iBKAkU4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UgJ8DcrCacitUlqK3MCNHloQG0FoQ2pYNsKUQAd0xCugQQ45zPXeqw8bvQoe6mKqEK82on/OPmfTnxvpI0JTt4LDqZBmVRLwh4z1SAEvCywt5KUS2Q1cQqlRE1UywTrCvxye3QwDoR2gxyJAi+/euNGjiBo6YEdGGzkb0hfXYn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i4AA9Ko7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y/TldRbJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5466lD04001302;
	Tue, 6 May 2025 06:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wHEXwoAYdrKbPc2Cy2ukOSS4W0f8iI0QFDfJY2FpHpE=; b=
	i4AA9Ko7frrfhwTX2L9xNOwaKyJeImGkYGHp6PkNYAAxrm9N8Y9TVU3xgQFoPzxz
	7yFEtqBMXQG8dZY/luYNxVrRNBGUdCpUWctmNWNqnrE9WceDfR6N15mhkWH3NO1H
	EX4aeMHGnkVQ5nS0tUQ/R5uAl6YvPJwnlTSQDbh2zwRIIseXb0r83wAVTuCs0CvZ
	vZhoY75bWGfD5rp4WA+VqMiX2lU7bwCVDJZb+P0brkJ7nI8JCeNe0nTiwrjt1fVY
	KJFB0VKsxb02/gvXG9WwymsKORhKrvphMri4pTG+2IX3ZH9Po8BYJEDdpxpoP8tr
	rtZ2BgoLZsSL3VOcrOYWzw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46fdf580fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 06:58:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54667RZC036018;
	Tue, 6 May 2025 06:58:04 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azlp17010005.outbound.protection.outlook.com [40.93.10.5])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k8mknk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 06:58:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UImBBhZWRLXk/RsGnYTW658IU7hAZRnUEK3P+6IQ93kI8Q8uAPXEwHzX3f96DV37T5VyMVnzm4quir2bVemPEnaYnHEk5a9Mur7eZy4xwBGONukY6/bj6RXgb3IVCEDMMo1l28he9bKSIjXGHV9NNiFvEyvsXlj//ADPNQ7a5mdFJH7hOZxk0CsfzZPTCMl2ovJu5syWFUpQIwgbynQlTeUalZ55LXNIpiyUTj6yPsSFhl8Jky2uLgLNGQhkZrT+At0cKyM6ij8v1Dl8F4U8fyeB0tMbZcX0SGZVmjE5mmv5HAKL5BPvTWkRPJt+/kZp5bK/WzMVBsCt7yfMMX0tgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHEXwoAYdrKbPc2Cy2ukOSS4W0f8iI0QFDfJY2FpHpE=;
 b=pDOAyz8/t2L/C8115dDEiwC9TBYXGt8rLCmM97x87acPpiJAHcIulxCvoArjJP6wZ4QOStduQ2bRQ0VCM5tD7cLKeIDf5ruXtvajpp0bONJtaM6LUUIG3NSIRkX4fGbOhZk285i7WP23nAENdBPRd+D7k5AfYGKA0OU404Q61Z/w+3AhrkzWZtlWTZyCjF1m0aXqf29wpduYGI6jpLaBtZ4UwNgRbLvZS1hd8jfCMj189zKybvpYSFPNyJuFXrS1Y3CNjV5GE1U8YXIQmj9/GDcD+b/W/pL04gbjN0s2WxkPFsFujX7Z+K5mmeHm31pKa0w/x+8UoUso84RHVvE+rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHEXwoAYdrKbPc2Cy2ukOSS4W0f8iI0QFDfJY2FpHpE=;
 b=Y/TldRbJSP7JgJrT7GmJmmABydqVzbG1iW7PwGKTjYWMQ18P9nTpYUo3oV/IVZRTE6Q5FNd2pczDscicdvxG6sWfTl8Y4lNolU7WIsxh7S1lvA83KU6uvtf3u0eOny8Mo07ibYwOMYHZxMyqBaR7T0ziJUJBGiHgzb2Uv534dzg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM3PPF7961280CE.namprd10.prod.outlook.com (2603:10b6:f:fc00::c32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.28; Tue, 6 May
 2025 06:57:58 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 06:57:57 +0000
Message-ID: <85a09b43-bcc8-4f0d-b919-cfc7d412b856@oracle.com>
Date: Tue, 6 May 2025 07:57:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 02/16] xfs: only call xfs_setsize_buftarg once per
 buffer target
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
        linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org
References: <20250504085923.1895402-1-john.g.garry@oracle.com>
 <20250504085923.1895402-3-john.g.garry@oracle.com>
 <20250505054031.GA20925@lst.de>
 <8ea91e81-9b96-458e-bd4e-64eada31e184@oracle.com>
 <20250505104901.GA10128@lst.de>
 <bb8efa28-19e6-42f5-9a26-cdc0bc48926e@oracle.com>
 <20250505142234.GG1035866@frogsfrogsfrogs>
 <40def355-38db-4424-b9f0-b82bba62462b@oracle.com>
 <200d855d-550d-4207-9118-6a0c10d14f8a@oracle.com>
 <20250506042242.GA26378@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250506042242.GA26378@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0164.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::32) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM3PPF7961280CE:EE_
X-MS-Office365-Filtering-Correlation-Id: 62d1ca28-c119-4e13-08c6-08dd8c6b5535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmtJZkVOQ0p4ZkJhRHJtTm9TRzAzajhoVFR4R0FqZUJoVTd2dDFTaUJKK0xv?=
 =?utf-8?B?SnJ2VHF6bWtpMmszOVRjVzNsQ1pac2tRZ2tOV1ozRmUzcVc0ditUb0p6bnRw?=
 =?utf-8?B?RkxENVErbFVXaC80YVJYdmozTU9GRm5zeXE1d3lUOEorWTdubm9LZmNZbGpO?=
 =?utf-8?B?WVdMc1JHaUl6eENTSmFnOVFPUjVSNWFHeCtiOVVwTDhRZHV2SDlnWEluQWhu?=
 =?utf-8?B?ZEU5Y01wOWRMa1JDQ0o0Q3ZBelFiRjJGVmV6a053b0pNV0hPWm9rQldvMDBu?=
 =?utf-8?B?ZWpzUW5nUmtONDMzdUJFT2Y2QlVyQlNWSEJCc2s2L2NNZ2wvT29oYVdydHNp?=
 =?utf-8?B?SC9Ha1VibzdiUjJkUFFmR0JxM2tsUFI4TTdFK2dSZEpKcmQzREh0R1BKS2Z0?=
 =?utf-8?B?UEMwd3prUjFkbXJyQSs0M1VoQWJ6MzArbUZDVitNWjRzRElKZUdCVTdFK2Vw?=
 =?utf-8?B?MzdQdHg2a1hhVkZrTnBtNlFaeFJGQ2NzdUtEaHp3N3RPWE4vYitkdDZPazla?=
 =?utf-8?B?Q0U3SGdNTHd0clprQS9JL2JwelpCakVnelFQUjZQclFVUkNXSXNNRVh4N29K?=
 =?utf-8?B?dm9TdTUyQktzOThKaHVHcXJyNTRHanF0QXNUbHRMT1IxSTVSVnYvUUJnR3Jo?=
 =?utf-8?B?dGd4aDdCMmM2VU1DWTgrVzJHSUZpZ3VLd2EvelFiWWVsbmRFMk50aVMyQzFG?=
 =?utf-8?B?N2d3cm5zWFVSK1FobVpUOG1pUDdxemtlMUVFQ29PRXAwNWNLWnE5UGEyNk5C?=
 =?utf-8?B?ZzU5KzVQT1I2dzhkTkxpSVUwZ2gweFpmZVc5L2xFdzdUVS9LTWhrd05NUERs?=
 =?utf-8?B?blM5ZDRMY3JreE9NMTFHR2NENzh6NVBwZXBSUDJ3WFdPTmg2R2lUUTBhck9D?=
 =?utf-8?B?ZHU1SEZRdjAwVUpnaXFhejd4NFIzVzJBVGNLVFJNNGRGWURGdWkyRDQ5U3lz?=
 =?utf-8?B?MWhwci80YVZOYm92T3NIM25aclVGWjN5UUJyR1cybkZyUnBBdTZkZW5iVXlN?=
 =?utf-8?B?TUdUaDlHLzVFZjQ0ZXRxTk9xSktOSWpMa0ozNDhwa2hmS2NFTUhRV1RkeWxN?=
 =?utf-8?B?SHQvWFRFKytaNkw4Q0Nad3pmakhhSys5WTg0NEtrVWhGdkI1T1lSRUdGZjlY?=
 =?utf-8?B?SktBVFJHSUVEV2ZLbkdMRlRtc2FYSmxONFpvWS9xcWJKZWszNUE3SFZKQTZD?=
 =?utf-8?B?ZHAwSzZmK0JkM2RrRUl5NnB1bnpqaWZ3WnVBSkNzbnEyRE0zM1BSSnhJK0Z3?=
 =?utf-8?B?alVpaUk0SHpQTWNMWFV1UVZHMittVC96Z0lLVkFtNkxocUEzVUV2TnNrYXM0?=
 =?utf-8?B?T0hqZXltemdPd2piOWQ2L1NwZGp2d2R0eU9IdjZBR1Q3Z2lRQWUyOG41Vmlq?=
 =?utf-8?B?anFrcGtCRS93WFh5aVNkQ0hhMzFVZmh0WFBWMVUyWE9MR0FieGVOdm0zNE9I?=
 =?utf-8?B?T0V5NGFwMmNPV0xpMDJBa29LNGMrcFhBbUliNDg4WU9yUlFyZm5jRzdRUHBF?=
 =?utf-8?B?MnVWaERVd21nb0tvR3hkYjRwV3VFVlorYnBxWkFBRnFyTk1UWlJDRGc3ajMw?=
 =?utf-8?B?aUZ2UkVkNHFJVGFmYytkRXFGRkxVU214U01RWmk4S3VyZVBERVh6WkZtRWhJ?=
 =?utf-8?B?VSt2MXJNOXhMU3dtS29yYWNxZ2NRclpCZGtWR01RYk1nRGZHajVBeWdva0lI?=
 =?utf-8?B?cy9xbXRNUEJQT1VtUVlRVE1nWmdWd1JaaHoxWVp6Tmd5NXZkMmdESUY0OTBE?=
 =?utf-8?B?OVNiZkYzVE9Lemc5cDQwU1FVU1dKaE43eTVwREU0RWVuWEVvOWZBaHl0Rk1a?=
 =?utf-8?B?dWE0cUhDaVlIM0p1eG5BVkVLRU5KY0VWRlMrMm4zaDFTM1hmWU9lb290N3BI?=
 =?utf-8?B?cUYzMGNTbjByRjF5TmRvQVF5RDlTdVJkQU1aY3I2N1NWbGtwOUZSM3JiQXAw?=
 =?utf-8?Q?lu+QC4ET0Tw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHd1QVdEU2ZmNVkzM1RCQmhoQlAzbGxhZnRqMHBXNmxQQllxaDRqRlA0QUxO?=
 =?utf-8?B?VHNjRTVzVUJXeTNmT0lKQ3VISnROdmRVWitLd1RjZmNWNXEvMVBwR2ZuWE9Y?=
 =?utf-8?B?U2dKU01IVWZrd2RaT3lGNVpYZTNLM0xFYmMxQlJFLzdsOXhtZy9JbFdUUjYx?=
 =?utf-8?B?NFI4WS9oaE9KV05TK0ZNczIwUU9DbHNtZTlMY2pZdDdtSXU5NzVsWWVsSHRM?=
 =?utf-8?B?eEpaZEhBYXVlc2VvcmFjcDFpNEp4QThEelFNVG5FRlNtc2ZRM04wOCt6SllF?=
 =?utf-8?B?aGRpZHVLdWlqUUQ0VUhZc1ZqU2c5SjRyL3VyTGtMSFBpdzVYZWZlTUsrWkpz?=
 =?utf-8?B?WmQ4WllBTlhRNTFFN0xYZmJOOEFYdGtzVEFMNC9xbkk1MFI2djNBYUZud3Uy?=
 =?utf-8?B?Nk9YWlJqeG9tVEdXUjRiVFNnaHl3TXp2Rmlpdm41VlBYUm5oRURvVW5kU0Vk?=
 =?utf-8?B?TlozRFVZUit0d0FxNTd4VHhPL0xLbnptTVVjbzZYcVBVTElkbFhuNDNtcXl3?=
 =?utf-8?B?a3RoZlpkRC9FVlIxaElDS055VEwzaVlZaXgzWDE3VGplQkd1MmdJUE9ub1E0?=
 =?utf-8?B?a3JDSWxUbWlJL1M3T3NMeXhmdDVZU2NhbmowWWdzYkxieGNrWHNmbDJzYWNl?=
 =?utf-8?B?cHlOc1FkOWtjeEpBWXloRlY2Ui9GOUJwcHM4THFCNDFJY0FtRXo0R2dhQStU?=
 =?utf-8?B?cWFrNlJRaXFIanNBY0o5ckVVTnlvYlo5d01PaFU0dXAvdnhGMC9aU3o5YXVo?=
 =?utf-8?B?UGQwQmFwYW5zWUNOQVU2Y3dtamhWZ0dRSE1QRmFJQ3FOVUs5RTNibmpaamxi?=
 =?utf-8?B?UitkQU9heDNYY01peklkdEhKa25MSEIwY21oUTdSckYySXFoOHByMUZKRHI2?=
 =?utf-8?B?MW1pZ1VWcmk0VEFRMzUzSXRMOTdldkNsVFZHYmFvWU04dUR4aGNYbjdOczIz?=
 =?utf-8?B?SjJzUTBpVmRaVXk3RVlnQ2IvMGtGSXo5VXNIWm1qRFozVGdHeEFpcVJrMUN0?=
 =?utf-8?B?Z2NSZmlYdXRtdWQzcVlKWG5pdnJpazhFTEo4dTR1ajUvZUJPZDYwa0E0ZllX?=
 =?utf-8?B?YkhQVnJ0RVdISkIyQkxlMjNkSmRrWHFQN0o2amRqbjg0RVNraUxzTmxjRVNJ?=
 =?utf-8?B?SVAvYVVIZlZnT1Yyb0JSTXkzaTZ1YU9PWlplZDV2K1RHYlN2OEpST1RDc3JY?=
 =?utf-8?B?RzdZSEpmUGl2SUMyWmhrU2tJaTQ2UTM4UUdidjlSVmFqMFdiQmVNOGFMOHNX?=
 =?utf-8?B?SUMzekgzWG9zem1Mbk51b1RxTnZUN1N2MlpZQUppRVZkcXdnWnZZaGI5S01C?=
 =?utf-8?B?RjNxRS9kVXJSbkdibDJWdkR2azlucUhxLzA5WTZLaXc0a3RBQncyblNiYmJ0?=
 =?utf-8?B?RVFSRXVkVEhSenU4Q0NlZjc4WlpjelhaN2tTNFMvY1pRRG5xdERFdUtyS2tu?=
 =?utf-8?B?WDd1M01nb0FRZXFqUk1HWWxwL2RsUjlOdzFnRWdGQW5mQitnNC9BN3YyVGxl?=
 =?utf-8?B?OGozN21qbFN4Vkk2eHNLM0Q4UnJRclQ1Yld0cC83QjMwejQ2Wk0veS9XZ1RH?=
 =?utf-8?B?bGZsZHNaR1N6OWt2Q0cydGtPUDJrMXVrS2dicE5QV3RMZkxDVzNsM0V2L2tT?=
 =?utf-8?B?bENkVlh6dmkwNUE2dUJCN3VLRDJ4c093a2hNTThMMTZMMExjL2JDT2pqUnBF?=
 =?utf-8?B?UHlTNEowRVkwb00vV3d3d2JuWGpsbjk3VDEwNlVVZnJvTWJFRlpNSkIwTzZS?=
 =?utf-8?B?MDJzRjgxOUlCMG9zb1poMi91MVRNNjVQRUZIWE5sandiMHRsMWhjWFpoM1M5?=
 =?utf-8?B?Sy96a0wvdHhUcHloZnEyd1hLcmNicmIyZkkvdGRNdFFvUk5VelE4cTFGZnVa?=
 =?utf-8?B?cVQwZmY5dnFxQmdjVEZpM01vK0xpNkxNam1FaURWY3J4a2RTUnM3bjVwcHAz?=
 =?utf-8?B?enhTdTJoSVB5YnVSZHc3N28zSlRZd0FZbEtLVGVVWUNwdUdLTlNoT242K3ZW?=
 =?utf-8?B?bXVPcWtQRU5aQkpGSmJldVNycldTaUQ4N09RY1ByV2d2YytLRndsYnRtWTE4?=
 =?utf-8?B?VzgxakpQa1VaYm4xZE9lNDBnbXdJREhLS05UQ0dPMkZpTGdBRElrWTFGeU5O?=
 =?utf-8?B?RkNOeDRPU3pJQWJDNXd2T0VkWDFzZmJ6aFJxV2dxNW43MllmbkNVNzhoUmtB?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v6+fpjWekyugH2sR9Gxnb6u969+Iqi0UCgIJYGUbyUFW/PKjpkiQzbi5HXN8+p6Z7Kt20qFkTLaMCqEAq6sOZLj+9BLNziWxm5aOX56d/o90oH7GSvqDpCI0X+XmXsenLeAi/jNqdcBvrilsNpVRJJk0rGvT/5KCPr8zu7DqB0Pe3rau+FB8fPr8bvgmYKaub+fYrHZt4E3EqjzECMRfufLy78qDvmSj4lqJimAT9oJE7DtVMOdL1w4iMoNilfOnK8q8hDgL9CF0Q/qLfvtfVQYIrHUzzOezRxE6Fv+tOOJOoYs+fW5ollGE/dF3W+FxpcnwKAihCTa6eMIGh+jly58FBATiRq3RG5rDhVWF90X7Vo8AcEAEcuBTtq1NOX72xrM+GO3VnHjNM5rhLxZTZjoGSSLKcqirqZTiwh8PTHiPma3QFfuvLYq8LTje+CgEEaq3lR1vtqlFRaWzkuOW5myboJDjg+u2WChIEe1zX3Qjv8XKYIvrffVMfl4zTI12FwFvsxMo2koHO3vzQbwtQZcUKs7EMODS5cy0PVaYH2Mc2Bu+phug3VRZdHeji8TQwzXMACXQ7qkZGQHqNyO5rjEmFO8swSBI0unNKP2y/TQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d1ca28-c119-4e13-08c6-08dd8c6b5535
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 06:57:57.7795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: loUpVOnrqnprCgvMknKP1HSO5u94hbWvL8KGm/Xdho+Cd+zlLA4bK2qvF9JbVntislpoW8UIoYN+DvZvX2dEmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF7961280CE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_03,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505060064
X-Proofpoint-ORIG-GUID: haITPSp1o95Mxn1Hg3egPdmJX27_paRO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA2NCBTYWx0ZWRfX/luNjN9uzFwO e7CfeQuGeDhfTeMxPOXkO58ZkCB0o84UAGrVW+SNTNDcQ5OiLx9kCkJ06EoxlfiieIl+l3iLUsD kI7xyz8fa3bw2Ce885OP6Tb7DOMAbn97it0dGvGSxbWBGl219hyEPq0TE2X9DOffU3VWxrvfCIm
 g8WXYZA3USzfV2HoFU/JOovgE5fXFWbMBNzLAtFMvnCpaaknd6w1/4nFWo3Akm3zl+w/VHaaDcV tYaoCdXYQqvwJAVxNG/zHm3ZrQFFI95PT4T12s4kH+d9IBs99wO6kNhjyzBTiByN6TUyICjPdqt C/Sx3IHwVQQC03WbFj27TH5EkzFlVTpiHtWcMbuoV0qbhg7/UN0oEgn/OU4mtyMnGX6aap8tzpm
 WcuqTTvZr0FWlrRp1hfAPKDOBYo3W6N24XbTmErowAKkaNB/9ZFag+KR845bcUgeWg0dfUyc
X-Authority-Analysis: v=2.4 cv=IPkCChvG c=1 sm=1 tr=0 ts=6819b2fd b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=SxrHSVSKy1W9ltl2nF4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: haITPSp1o95Mxn1Hg3egPdmJX27_paRO

On 06/05/2025 05:22, Christoph Hellwig wrote:
>>> It seems simpler to just have the individual sync_blockdev() calls from
>>> xfs_alloc_buftarg(), rather than adding ERR_PTR() et al handling in both
>>> xfs_alloc_buftarg() and xfs_open_devices().
>> Which of the following is better:
> To me version 2 looks much better.  I had initial reservations as
> ERR_PTR doesn't play well with userspace, but none of this code is
> in libxfs, so that should be fine.

cool, that is what we/I had gone with in prep'ing v12

