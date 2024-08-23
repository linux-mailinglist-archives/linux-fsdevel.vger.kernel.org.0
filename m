Return-Path: <linux-fsdevel+bounces-26885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322FE95C83A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 10:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572691C22F9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 08:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AF81487CD;
	Fri, 23 Aug 2024 08:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cek+jk/w";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qeb9k1JG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933DF36AEC;
	Fri, 23 Aug 2024 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724402409; cv=fail; b=mZIUhJHb2LuO6wIMPgOMvKihZml4waBb4TdMC1AhauKaCbtcenCHOzjrlKb6buslNvwxMvZULlXQ9OWTnw+Ds075U5Hndjdz95JPQFu2geMS42SUz3AZxAqgtaVt8dgo+392nP9nMdDiiNap3KCGeWXvqGcqHTqVAsSAhwyWDa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724402409; c=relaxed/simple;
	bh=bSrn5swQmKB3RcPuy4/JKBoifY/qun4koJAWLcnifaY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sWqWn+LB/b22omrx+lu6HO4Lh0QGWp/nmre5PpELdwA6PlgFEXq3jDz3SHmcDTJq2SALB3zWmBSk5m4tjl4bU6CyZqbUGamvd4wy88CHCU8Gw0H0HRmPWdzJoJriPqaaMdBKQ1XiRKXmxCG75EvXcESZiHBhjaOIcAyzDznDAMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cek+jk/w; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qeb9k1JG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47N8BYaS017903;
	Fri, 23 Aug 2024 08:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=dwDCOJBMmYimX9I5v9Rc+E+b55v0DfWT+ICPKyCvPbk=; b=
	Cek+jk/wr6qvTilUYpuUeI7DTRl2DpDeBsooatYhEwtE+S2T/9uVN0YbKNSpsCIa
	l+Qdqr0/yeJgXmu0ac4H81oRBlwREecv6daGmfawswBNOvkrTiccM0fZOWrlud6b
	5B6GmdxZ/Cnj9IFC2/vs7+x9HKt2eb3jPxp2yq/SdC54fAM4z7GdT6aEiU976o31
	wWzGxjtD1d2vyLiAxL8VOngl33u6iNW26lh6i02nQEJXzTvKC2Qjw8RKD4f+pUGP
	e+8wGfQ7dolS8D6LUgdin1OgBx9dujyexWdoArab/iu2x6i3HlSM/KMo0pBvhROy
	rHHSO5zsRB4AHioiqLwYQg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m45kvtc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 08:39:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47N8K31C024223;
	Fri, 23 Aug 2024 08:39:51 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 416ptnrhau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 08:39:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ei2Akc40guzXGcpn+qNK1I5vvXvvGWfiBYBO+CPSoHkFGAWAcqPvxIdX8He7ceS7xDE8JdRH6/7mnJnDc4seyjlM4dqBqlt7zMR0yi4e9dTETqCdxSYqwRMaQfWb0m0n0ZihAxkfcD2IfZvCbOGTq6Kimp32r6DymsVRKj2Hru3SKQRouW7ZThFoWWbfyW/rv/SWenb2c6o+EZ6tH00Zllf7RTA2ZxyMqPEFEoYn1ZD6ZclNvDCjinS0WkGFVgRXxNstXvJnrl4lnuHyB+PYOxW9DRCGhgUAEXk9yON8E13PdsRhf/cSU8SrgZ0Vv2SS00xBS/JmygrZcCieDl4BoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwDCOJBMmYimX9I5v9Rc+E+b55v0DfWT+ICPKyCvPbk=;
 b=G9zKqGmb6I/7p6B0WPVNhfV/Or+/+nlWVYXcmD26hdhBL8uFHZ2UJvo7NlervhtKhKwQnPWIUzWz6ZD2vI/EdjtfQkgd1dLmO4efmJ08WBks7sBBP3/ZH9xV6Ih2bKa/PZPdUk/oDUAxEywfN9C9N7Fq39Mor3HQ6D/8LLUot/dm9p7hoi7tVAKZMG70Z+f5DbCKKQkZJFhAM7OAyicj790vJH4ulAWG8yXPWYllr3xlz9QnXlj2dmAlXXDV4qFIchgt2FyXgGMk+cXssXPrCQt7MvqS5T/mpUELSt1TjsT+Rdg9Uer5x0K6najTwp4rT20JbOthyYANwAScZsP+IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwDCOJBMmYimX9I5v9Rc+E+b55v0DfWT+ICPKyCvPbk=;
 b=Qeb9k1JGcUNcQDXgH+WaH78J8lRyyvgCO3AeuY43nYm/Dnid5HZKlRqPtCueT6AsZz8zHDGqSFdokQ0dxnsR+jbI6hvvBuIMkxxGW9HhfV7t7jeQUlZ1kE/3Hd7HninCjNyydn5crZ/D2Sh476RPJ6HnnxX2ecwTnhpyTz6PPz8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB7464.namprd10.prod.outlook.com (2603:10b6:610:191::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.12; Fri, 23 Aug
 2024 08:39:49 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.7918.006; Fri, 23 Aug 2024
 08:39:49 +0000
Message-ID: <d4e9baa3-d7d2-4e89-bc5d-91c85dbd4b8b@oracle.com>
Date: Fri, 23 Aug 2024 09:39:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] xfs: Support FS_XFLAG_ATOMICWRITES for forcealign
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        kbusch@kernel.org
References: <20240817094800.776408-1-john.g.garry@oracle.com>
 <20240817094800.776408-5-john.g.garry@oracle.com>
 <20240821170734.GJ865349@frogsfrogsfrogs>
 <a2a0ec49-37e5-4e0f-9916-d9d05cf5bb96@oracle.com>
 <20240822203842.GT865349@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240822203842.GT865349@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0389.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: 3114ae5a-8ec9-4c3b-9de4-08dcc34f261f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlVQOHVobTRHNWRXSGVmZDlqT2RRZ0U0V2lMV3BZWG4zbkV6c3dZWk42cVFo?=
 =?utf-8?B?Szg3MEpyQ2N6OFRVUUFJb3hTNEJVSk9Ya05PZmdFL2xsT1kwVVA1Z21yWFFH?=
 =?utf-8?B?eU9NOEFsTEF0SGx3eHV0di9PTjFacUZvcHFad0ZzaGVSTmVpaGhoc3R1Y0Zv?=
 =?utf-8?B?UDNLZHpwMzdnWVVIK09ESlp4K2cwU050YjF3YUp3d1luNmVGTFJKMVBwbHA2?=
 =?utf-8?B?amJQMXBOLzJxeGRxU0d6cHJ4VXF4dTdBUmYraGhFdDBQdDUvMlY1dENNNmFB?=
 =?utf-8?B?SjczSmVXR28vS0xmYWo2ek5QcHR0Yll0TndtMGkrZVVOR2czbmZiNGhtRUgx?=
 =?utf-8?B?a2Q3YlRiMXMxNVJLd2k3ZVdKSE5NQVFjTEd5bU1HUTBuWXRQUUdKVXg2WUJE?=
 =?utf-8?B?Nit2OVdEb3JuVVY2aGRpNUppZmFTbjRFbThrTUdQYVJJaEhjc1g0UmhlSXMv?=
 =?utf-8?B?cEVWZzEycXdxcVQ0UFd1WWxsL2RzVXNGMHJiTmRudXR1a1YxTUNyejFwcEQ5?=
 =?utf-8?B?MGJ4bUhDbnM5SVhmVlNyRGVLK1d3NDRpR1JvdCtIQ09IRG1MZDMrM0I1RlVv?=
 =?utf-8?B?UHU5ajJFOGFlbnI0M2doMlZIcG81ajVxT3VlT2djalhPNlBPck5saVltVnNr?=
 =?utf-8?B?VlFvdGgzemZjYjY2Yms3dGc0YS9vL2xWZUR3RXlOc21BSnp6WlNVSHpVZjl4?=
 =?utf-8?B?a0JjdDNLdWRUM0FOR1RuRWsweTFzY3VpNGRBY2tJUGJWUCttS0Zja1dpWWdP?=
 =?utf-8?B?RitmRzZsaDl4bklKNmUzRHZqVVZiT1hNeE5MQ0xjeUhWN3M3ak1sRDJwMkYy?=
 =?utf-8?B?MUtyRy9udVoyREh0UmI1dnU3TEM2Q0RqcGJHUGNOWFFQeC93R28ybGtYakJI?=
 =?utf-8?B?LzNrM0phbnhBY3ZtN0xxWXo5QTc2QXVWc3hGR0Frd1lrRUtRVGNGZmdtRVNF?=
 =?utf-8?B?ekw1YWcxZDl0LytuTWtuMVlDcnc0TjMyS1ZYcmI5VG5lK1R4Zk1WMFBxMjUr?=
 =?utf-8?B?RkZqcVZVUkFIT3dFNWQ5dUxlYXR2MDZsUEV1UGluVzBjTVBweWdiYlVhSzF0?=
 =?utf-8?B?bmVqMkVzbGpnWlVDbzgzRUJyNkJYemRib201SmYxbWl1WWovRmJqYmdzMlVC?=
 =?utf-8?B?S0V4SzY4VG4xakIvNzBiREdrbUVKZHJqMFZkM3hLVnpWQUNxZkxza3RjQUZ1?=
 =?utf-8?B?eS9vWHRTSVBwcnhuTFJYZkZzZUI3ZHpZOFJheUU4eFFibVZTUkpSWHZWTDVH?=
 =?utf-8?B?VWZuSmlHY3A4WWh6U0dxZmQ5ODBRN052NElJTE4xTkRaTUZkS3p6MzU4eTV3?=
 =?utf-8?B?c1JpaHAvdVR4cDZZOHgxSmhZYlkvV3g1QW5kR1R0YTlLYnJPQTJEZFJIR0tl?=
 =?utf-8?B?ckN1TEdFRitnc1Z3UUJhU1dGTTk5UEliL2Fpc3UxWXl2dUE0K1hVTzQ3bVF3?=
 =?utf-8?B?eElFb3kxVHltQTMvQ3Z2UzlIeHFTQ0FzeDdCYUsvN0FwdWR0NERyQXNzSkdK?=
 =?utf-8?B?Ymt0SHdDK29yU1ZJeWVzcEhzZDh5RmN5V3NBbkszMlRyWjdBbllwMkxYTUVH?=
 =?utf-8?B?eFl5VHVOSmZoZ3RLMGFBNW1BZlZnM2lVMTBDcmFCVElab28vUUZaUzRuMDB6?=
 =?utf-8?B?SWNyNkxPWmJNV2VHNzk5RFZ4WmtYVmZpdTlzRGFTUVhCd3NoWkdqVGwzcFVx?=
 =?utf-8?B?YnpMRTA0RW5CT2drdHhyak1YT2dXWWpFMmdYWXhQZ2JZaTF5bUVBNE9oM2t2?=
 =?utf-8?Q?xkQIcYp536ghxKTYuc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0pSVUZNMW51dmNQR1RoTTJNM1YvQU9KU3puTWZMNGxkeWZLOFJhb3ZHUUxK?=
 =?utf-8?B?ZFVlRzAvR3NDVXBjcmQ0M3VWZHprZDFUM2llYk5PazEvMnZqVURyVXJFQ2di?=
 =?utf-8?B?Qk1LMGJVZDJVQzdwZFNDZkIrTGhoTElheXFHQytSbHN5ME8rUFJaU2pkQndR?=
 =?utf-8?B?MUw5L284dmp4V0VWVmUvemxWbmRCUmNjdDIrM0xtU0YzbkNoRGg5OHdvMHRW?=
 =?utf-8?B?SzBhSlQwMFlVSXNZMmNQZm45WXBiVEUxRTRjQitUdXd4V2VoZFlCTHIzRnJR?=
 =?utf-8?B?Y2xjV3JhV1VoSjRma1F3MU5GclgzM3NSbFVqTk1vbFRhUzJyNUxsMUpnblBN?=
 =?utf-8?B?TGZQY1J0UWNxMjNSTnloNEhlM2VvMURKeU9xWlBYd245cmYrYzByd1BYelUz?=
 =?utf-8?B?VlIyTjNGYm5ERGtzbG41cTMwQWFwSlRQVjZsUTFESkt6OWx6ajZaUVdHa2ho?=
 =?utf-8?B?aHNrYzdnRnlqOWVyWkE1QWtWYXNjbk1CTGc3NUVobjV5czFlZ05mOThEdzRV?=
 =?utf-8?B?M3MrTThYak5sdGpWQzcvK2VUSEtwQm84SVFtcENkYlpNdUJRV0lnSU5iekt0?=
 =?utf-8?B?Z1ZwaDh1aVltOXhkVlZvOXkvamtGNm8zQldhd2NWcTdDcENrSFhMNGtzK0h6?=
 =?utf-8?B?RUVWR3Vsa0pTWlV3bFc3dC9NamV1QytXOW93ZllLRy9jVTAwUHZvRkw0WDVw?=
 =?utf-8?B?MDBRRnEyNCtYQ2pHWFVOMkxBSDNTUmlHZlR6WjRkZWFBdXpqeitTcmQ5OTdi?=
 =?utf-8?B?YnNtZDhHbUVWRzJIVy8vVS95NUIwTUh3bm9YemdLVWNMeUtTTndJZmIwRzI1?=
 =?utf-8?B?dW96S3NiL1VIYTBhblUraHNwc09TK1JZNzU1S29OVWJZclZkM0xrQXRpZFBD?=
 =?utf-8?B?MFNzKzdGVU1ibjZVQXRMbW5xNWZDNW9yOE1CUlJ3eTV6di9uZUR4QjNmMzc1?=
 =?utf-8?B?bEZvNzRDREM4aXpRZ3ZjVEFiM2xtdzBZMjhTNkhCcktFZ2hKWEtRSDBUbVBX?=
 =?utf-8?B?NHpBU0p6UkpBOFBkRnk1MGJzYnRWYnhJSXYwNFY4ZEloUEtPcC95b2NzWEJr?=
 =?utf-8?B?NlpjYUp1aVk1cFVacmVBLzIzVTdPcjNmUEpvL1V6SUNXUVE2MjFYZldLVnJi?=
 =?utf-8?B?eHp3YmorSXU2aTFZSm0vdCthN05EdW9kVVVUeTZaNlpjRkFhZlRDTWZtZkpE?=
 =?utf-8?B?YThnbkw3SGJGM0Y0c0k3Z1lyclV3U29UNVQvanFyM25FczFhcVFnMFpDS2tW?=
 =?utf-8?B?a1dkT1hyNW9wS01RNkhkdUNKUndFOXVRanltTEVZYkpJTHZjdUJkeklrY3Ri?=
 =?utf-8?B?Z3lpalM5QmtoVnZBMG14NVQwdEFYVW5TOG9VWDJhMktIc21nS0Naa1ZaZG9E?=
 =?utf-8?B?QzhGVXgvMXQ0aFJRbDFValBsdXN3Sk0xMXdnYXV4VWNDMVdGckNmakNaRExH?=
 =?utf-8?B?MFZXQkFiYm9hK2FmZEVmMmhiNEpRT3dvT0pwL24vTzJEcU44SDNzOHpRQTRr?=
 =?utf-8?B?MFpYZWRhQys0TkFrQVJuTDk3UDN5YVdhb2ZkcERjTG42M3QvcmlrbjFoWHMy?=
 =?utf-8?B?UzgzVVdIMW1DN0pRdFEzdU1ldlkvTmRPM01jcnQ1UHg0c1o4MGpwUjlIdUto?=
 =?utf-8?B?TVF2NGlDYmFacTV3V3hIMzZDcmR0VWNZU0NlTXkyZ1ltWklNMVgvdVhSWkVv?=
 =?utf-8?B?RC9pWVliM1pNdEd4NVVQeHJmeWJ4TkJLQmNuT2tuUWlZNmRTSzhrQkRyU241?=
 =?utf-8?B?WWc3ODR1dHc1dTVtSmp6S3RTdnpDZjJIRjJSd2pqNzhzTUppUGZ2MHV3MDlT?=
 =?utf-8?B?dkJNRTNSNVhyVDd3TUJSK1IvSHBlZUV1cUVUbzQ4S3JCYzdNQXFxSVUvelk1?=
 =?utf-8?B?RlphaXBYamRSd2N2Y1JVVVRIVjgzSG9FZE5oTDNhMXZNTnVtcFpidUdSY28w?=
 =?utf-8?B?RnZiMXV4d0c4cjJBbWFqaUhUUG5PajFYdmFjdTE3aXB1NWpRYXVBMWVSTWNt?=
 =?utf-8?B?UTlEYnEvUlNTYXhTdmlqWGpBQktwWFJsODA5NDI3YTZjZjhuYXRxSGRwOEdX?=
 =?utf-8?B?b0o1TnBqTU10MTloYjk4ZFNFTDFWMGp4UzFGckxVTUdKK3pDK0dHYytzaytT?=
 =?utf-8?Q?PPqiD6lDt3WdsDY9zlqUU8Yhj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IZQ7QM4cShgbK/gPf3yWyELs4XPTPrilcB2LFGz33aN3jgV/fRmWmkmLVpJDFOhdhUKRE/qp0RAGYsUKqDlb1hoVOFEMDQddcZqYBl/HPoE3pHe2dqoJB74UizoXWruiVM4USnueC3vjQK/HrKOFG/97PNiQqzySV7AHVCLOxs8VLNBnV9NPkTngtZ6BhnHGHZrvZFBfXy63nAzHR3EBAIDxbcEAqXe7mh7EUMRCwPKuLNjkE5InmBY+AktggE8JJLibjJb+g+YEhbFPIrhYSv+GQgOQnm2lthMF3fN4zqVqNNBfvWHV+SFcHQt4xx9od7rTTaa31E6E3e/i9N3rkltCjsA8EL6I3HWKCOw7SJCmXJx2HzI4g2lrn1sSO4Gr0G+rdokuG+hthr7WbCk8DpCOcIlNbZ8PwpVLlEaBNuNIv5D3oJZ/5yGMLn4CfG/D/evDzRfsxb2OZIOvxBPuulnL4DSm1GibURfYmXbR7nT8qv+o3GSiGIidbYPMSn7+he3B4S/zMF5SwCSRHFb5ErfUFIcXm7ygcTacDa+5WEkrxboSh9fur4YzpoqBTkla1wd2gJuQeShgXg1avKcC1596vz4rJkmMUwa8Nrz6geA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3114ae5a-8ec9-4c3b-9de4-08dcc34f261f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 08:39:49.1347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNTmg+QCZDgagGAwU/Qoykgx92cOnnhSV7a1UA6cf/y7lzuX7R9BcYVZo9gnsrTFOpGBVfnz4ze0ys/7SHxkeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7464
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_05,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408230062
X-Proofpoint-ORIG-GUID: P3vFkwKtO21vV6QNpubUr3pO8j0CiYaT
X-Proofpoint-GUID: P3vFkwKtO21vV6QNpubUr3pO8j0CiYaT

On 22/08/2024 21:38, Darrick J. Wong wrote:
>>> This (atomicwrites && !forcealign) ought to be checked in the superblock
>>> verifier.
>> You mean in xfs_fs_validate_params(), right?
> xfs_validate_sb_common, where we do all the other ondisk superblock
> validation.

I don't see any other xfs_has_XXX checks in xfs_validate_sb_common(), 
but this could be the first...

The only other place in which I see a pattern of similar SB feature flag 
checks is in xfs_finish_flags() for checking xfs_has_crc() && 
xfs_has_noattr2().

So if we go with xfs_validate_sb_common(), then should the check in 
xfs_fs_fill_super() for xfs_has_forcealign() && 
xfs_has_realtime()/reflink() be relocated to xfs_validate_sb_common() also:

https://lore.kernel.org/linux-xfs/20240813163638.3751939-8-john.g.garry@oracle.com/

Cheers,
John

