Return-Path: <linux-fsdevel+bounces-64608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA7CBEDAD4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 21:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D8064EE0A6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 19:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5B5286D4B;
	Sat, 18 Oct 2025 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WxnFq66l";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XIhJABX8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8947525CC79;
	Sat, 18 Oct 2025 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760816309; cv=fail; b=Nq/tREKHQKhYqq6bN4x2DnoS4EHDxhgt6Vx6ja1ULg8FVaDbP0MxHNpGH8Md8weXNRSrsAt1NVecd12rxuZbypr7dDjgqnjhzFjpPKMPGD2C74w987uUSsvqofxpfH/hbhbSDwudoYq+7M9Q5g5h1P4qOKWjuuu4HhctjuIRRLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760816309; c=relaxed/simple;
	bh=UCbdBBad5Q47PEdlHItD0XY7x+JbJHtDrScJhKOwUeM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X+obaRo59icMi0CTGL3Y8Cdq0nanvIWQXgDzinNp0gHTpf1Z2aHr3acyoXv9DnPDio96sDbe88eV1krE+SIuMGSZTqL7kYS5/Xjx2w7HThl6g5JON2EtkctaX9Tn2ao7uXB6sTqRPeVjFNz4o6MZY13ImuDafoxEKbUeArc+av8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WxnFq66l; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XIhJABX8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59I9hLOe009666;
	Sat, 18 Oct 2025 19:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vnBO6rjin0e6jq5mBzGBLbSbTel+TUGng8y1b4c3Kd8=; b=
	WxnFq66lh5AUrgxa5IiAiaGb3WWPU2wJntxHgYwBmZDZNgzUnQ/C9gNX57h318/Z
	rbNkoEQ2G02B0wMMKqS7tWQxuyGBGbywI0aMU+QGepL6YJcZG2zhK5IFkjm/68px
	l/MtzHhrUvLBLbWnG3KQSBUBGiOM5zBe2I3ptyrlqup0VIHLAFjk0ny13YA5m55T
	gpDtIe17IVa2LSGn87I7f/ea53Ghh4KYsyPvWlDnsS/viLtJoj5OT7AcY1+aSaur
	jIu3EMldx/h+jLGZHk5fjsSFGBHGiyoluvUsxK9zvJdAC4Tv6FATKrwoTGf9/S3o
	h95NpoPH96BP5kuigvAgsQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2warfyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Oct 2025 19:37:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59IJa9TF032421;
	Sat, 18 Oct 2025 19:37:45 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010062.outbound.protection.outlook.com [40.93.198.62])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bafmb2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Oct 2025 19:37:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHPyEfCG7bPd9oRegfKf9SD4pBJl0yxPm8BLela8orVQykSDY06SEwi1jQtq8yzVd8LAjVTB6oe0Zj0Qfnv+blkoXz+rRox2LbP6Czt1o06Cg11l5SKf4u+yX3N+cICDfbvP97mgdK+DoIQjqBxcCep0LQ6kMSHX1K4Kcd74PW3ohmXs8UrCi9SCZeNBgslUQK1KUY5PS2+fDwU1+tE25fPgKFHQ12gDQa7Nzk5g3S4OpbGMqCOCmcOthIlW8JzkFHDvRbQ+CAhIP91xJlbdM1rgIAWQTOloWcFcYnOm8JR83JRpaRFihlZhILeJqEfCS0gjeRZqBBeMyMGXmCl0xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnBO6rjin0e6jq5mBzGBLbSbTel+TUGng8y1b4c3Kd8=;
 b=vnRdfCLHII60XkydvQGigkwO65YiHuUI8UzbhHz9MT5PscvFVjn3Ul9C6ecD2njS4vLAIPmsukuvwScQJN3dfBIXtvjSBYk/67pLNh6FQ7XkB1mCD9DaY0A9JsjGjHRgXezxBbNSQqivcL7yQCthSkIrR9atSuXYwflBav1uY/xU1ar8Sc9PQ/J7AZUu461L7mbT/dSimqvN8E5/LdCbcRl8TkZYgMzBXPoVVHyc77PthY5pPkpBXITWDTyb2kXBfbfNs3ilsV8CWViwKE3feKAyhxxivcBaM8p7R/Q4oOjxKTOE5bhGNt5F9JOAUiZz+xrEv4pqrxj4klO/hmGztQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnBO6rjin0e6jq5mBzGBLbSbTel+TUGng8y1b4c3Kd8=;
 b=XIhJABX8pgZ+ajfUFE1xbjrMtJGHlPGyHvegZyj6rUF+n4FFCcfnuuYmhRdxar96C0qVqHsMU9WfNW0EpDB8bzNKQbSUvEjAZ1E+hgLoEUvjtyTQTeN/i1HgDgnI+l6NCzvJwARYm+Tl7HZtr2gFD9+hUBkEB5w4b+qRbp9yJKw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM3PR10MB7925.namprd10.prod.outlook.com (2603:10b6:0:46::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.14; Sat, 18 Oct
 2025 19:37:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.012; Sat, 18 Oct 2025
 19:37:41 +0000
Message-ID: <ec15f97d-b9be-4bb0-b099-08d964f7f89a@oracle.com>
Date: Sat, 18 Oct 2025 15:37:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] nfsd: allow DELEGRETURN on directories
To: Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Alexander Aring <alex.aring@gmail.com>,
        Trond Myklebust
 <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.org>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
        Bharath SM <bharathsm@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>,
        NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Amir Goldstein <amir73il@gmail.com>,
        Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Carlos Maiolino <cem@kernel.org>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, netfs@lists.linux.dev,
        ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, netdev@vger.kernel.org
References: <20251017-dir-deleg-ro-v2-0-8c8f6dd23c8b@kernel.org>
 <20251017-dir-deleg-ro-v2-10-8c8f6dd23c8b@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251017-dir-deleg-ro-v2-10-8c8f6dd23c8b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM3PR10MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e73e2b9-d84e-486e-cc58-08de0e7dcd56
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Q1B2dGlnSzJKemZXSXNrQ1gvazg3ajBZd1k2OTQ3NS85TDdsRUxKQkI2ekRH?=
 =?utf-8?B?ek1WTENndmFWNUE3NEh0VXRDbzEzeEVDV3VObndlb3F4dnhsM2tpWGdPRFBE?=
 =?utf-8?B?eW4vdDVWVlAyL0hjR1FCZlhNYkd3dm9ycUJHcFJIV010SEgxL3MrSTdUR0dD?=
 =?utf-8?B?TnA3V09YdHVLeTU5Q1JyTTVrLzNXbmFIVThuVkFQR2NqcG51ejVjUGdJaXMx?=
 =?utf-8?B?NnlFWHZ4cUVzVCs1clJtbW9OamI4VW9RMTJBZWhmL1dKQ3NUc1BacjVhNTZO?=
 =?utf-8?B?bjZMVUppMUg1cUc5YzN1Y0Voc1I0d1phVmpsZk1FeU5sdDdKWVhEdGJMTTJv?=
 =?utf-8?B?Mk1SRW4vazVHWGtxc2p6K24rc3R2QllwTlZrSk9kcW5EVGMvRU5TZGh5Qlpu?=
 =?utf-8?B?c2dMYnF1S2phZG5MUEwwdGJVdXFueVZQcXpTVmpOL3NWak0xMGRXZU1xUHNt?=
 =?utf-8?B?QlBCY0Z0Z2VhQncvbUVBamhXZXljVlNSODg5dVlmNTBHdHA3RVFvSmVIY2Q0?=
 =?utf-8?B?eC96NXZST3RGRmxaU1N3cFZCSmZHc2g1ZjFmZ3VOMWVZQWJPVmFqSHN6M0hV?=
 =?utf-8?B?QWR1WmI4bEVJdGkwdHNsOEw3azJ5ZmZubUhzNG5MaHhtR1p1bHMxMk1NUHZO?=
 =?utf-8?B?ZmVocVBISUNVVFU5blp3RndJbi80V2dUb3c1d1BiTjdlTG42YWhqSG5MQlJ5?=
 =?utf-8?B?RTRlK0VPSUE2bUt3Q0tZTmNsZjg0SXUybWVvOHRtNmdpVEpyNmlPTGxzRkg4?=
 =?utf-8?B?TUN0aFFWbDFPenJ5clNWK0VKMzl6RXVOOFVFMnBmd3V1SlA4WFpaWkZtWFQ5?=
 =?utf-8?B?M2VLRHYyTW1KZFpNaTdHMUZxV0ZvZXBrY3JuMHVJbGsxN253Qzd4bjhnakpi?=
 =?utf-8?B?cC9UYVJJK2VjN0FJRHE4NnMrNjdwbXhQOStOcHBVZkJUb1huamRYOUxURXhF?=
 =?utf-8?B?MjZnVmo5dzZqOFBKaXIyTUYrQjhkK1duM1Y2N1VMcGJ4UGIrTjNQdWR4UVRh?=
 =?utf-8?B?Mk5YR2VFRGhlNVZXdnpUZmdLejhFMXdUaFRyV3hsWlczeFVjQ2xLdXlacVNI?=
 =?utf-8?B?cHRGbVFacklzNkdWL3pTY1k1VDJpZDFqd1hJN1NmZ2NJUUozQ2p0NS9PS3JI?=
 =?utf-8?B?YzYyNFlMSkRUdk54RDZpZTk5R2xmY2cxMXpCbE0wbkJZNEkvQUZEaThMbVVX?=
 =?utf-8?B?dDZwUkxDVE5rckluR1dJWG5zOTVXWlU5U0RlSXVmTmpUakZORS95YnVOTU9N?=
 =?utf-8?B?di85OFhTdEgweG5UUmJBeU5oTUZSSmhMWXpBZVpmZEg3d3RNUUphaGVCeU5S?=
 =?utf-8?B?UExCcjNCaVRJdG04VDQya0gwSGNKRVFxclNKeE9mcWtYYU1qTFRaRjF4S0lk?=
 =?utf-8?B?STJwcTZmODJVaXFhUmZINEYxV0x0MFZ4dkg1dFNWNDdoNERUQ1Bma0RFeDlq?=
 =?utf-8?B?TEVYUDEzcUZxbE8rVENvYmhMaE1TTHE1L2ttK01vc0NhNllSZEd1Z1BVYnRz?=
 =?utf-8?B?SjFZWk9YRldlVkJ3RjNxbG1LelQ2UUI1bmlzYm9USHhkN0FxMXhoYmhXeHBD?=
 =?utf-8?B?MTErVXFZaXhXNnEvU09SbkNhMThsU3VwZ0k5WSszVi9mVDY1MXkyMHVwSDdr?=
 =?utf-8?B?Mkg3NjJYU0I1dzE5YlM5bCtwZnY4ZEwyT1ZGaDFVMUFZUjdqNkZNMDhqZ2Vr?=
 =?utf-8?B?aDAxU2tmR0ZvWEthZjZHRDIyb21oSWVIRk1UT0RqYWVuTkJBaUZZcWdROVpD?=
 =?utf-8?B?YmNCUWdlajl1TTNmVExITEw5RVZxV05ncE43VFR1ZjBOczgxc2FKdFRwNWwz?=
 =?utf-8?B?aU5ZS1pObXFLRVV0dFJVYWJZZzh1dCs0NDk3eXo1Z1FxM2d4RVN5ckE3Y2Ez?=
 =?utf-8?B?TjR2Z2cvSW55YmVhTVZHcUEwai9XSFhON1RrMmVONVRpYWlMRDV5Q2R5ZExs?=
 =?utf-8?B?eCtPTU9rOFQvczZjZmFldU53THlYU3Z4eXNvSlhWU3RPTGJlRVgzWXE5Y20r?=
 =?utf-8?Q?XI+HEBqw+CaX3iGONLL1eBA4uXN0uU=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?R2xUV1VaOHdYeU9PVDRaR3VoY2FIZkdFaEtOM1c5YnJOYk5XRWl0QkJjaWsv?=
 =?utf-8?B?bndQQzF5QWRNcUc5SlEvaDZjbHVlczVNVHI1V1J3QW9KbGo2dGJRQzA5dDdl?=
 =?utf-8?B?b05ZTW51WHlCMjVaWUNjN2ZUQ08rcyt2WUdXelpreEFtOEhSaHpEKzZrZ1FI?=
 =?utf-8?B?M1JzM2ZnT0pxVGpqWWlSbTRtM3g2RlFlV09OYzY1empLSnVua0lKdmJYTitj?=
 =?utf-8?B?dVNmWlY3aVd3eWtYbzNXZ1NJK2VDcWpFeEtaeEttSEY5cW1HSytRZVhEM25X?=
 =?utf-8?B?b2dwQlV2dU96MTcxWmRGd1Vockp1Vk1YckJRSEwwZEVtY1hpRmg4TTIzbDlu?=
 =?utf-8?B?TldBcElteVcrZ20rSmRqU0NjQk05cE52UFFLbnpObUZxUFJNOEdYL2lac0tC?=
 =?utf-8?B?emNXdHBrbGZBU29UcXkrNXZLbDhDT3hCN25jWE1NN3FqNU9lZ2FCd2Nrd0tX?=
 =?utf-8?B?RThqZlNJUEZENHliakxWREhyZTRsMUtrNGJhU1ZvNWcrMkRnQXpWMk5qaUdw?=
 =?utf-8?B?SkZUeUNtakJnWnJzZ3FyY3ZYVkQzVzR5ejJvN0plZCtiV09DZTNSSXJRdHJQ?=
 =?utf-8?B?UnNiNFU0bG5tQXA3YWh5MVlla0txY3RZc292SXoxelN1L0Y2dkVOUWJFT3Vr?=
 =?utf-8?B?VnpCY1ZIUnJxUXprUUtGdlYwQkRNUmhkdGpDOWN6cXB2VFJVMktkK204SWk3?=
 =?utf-8?B?TVdHTHNrNGpUelVpRW1yeDl3ZGdCWjU0Y0ovQm1MQzVhckhEVnBtZkFiNEFC?=
 =?utf-8?B?RFBrV1hMb2pIOWRoVkNlWGhrODVqMitmbTUvQnBiWjhYbHRIZlR4TkJLYlpm?=
 =?utf-8?B?SDFuSkNSVklhdDlHL1VqSTRhYlVKcmdzVHYwSm5RaFJqcjZCVFNCc1l3akNy?=
 =?utf-8?B?VkJEZFhTZE1CU0p2LzFRdlBYOUErOTVTMXpRUTFnYTFQUXZLUVZMdTNLbXFj?=
 =?utf-8?B?eDBXb1ArRlk3b1c2cTJZSUpJVkgxVllTbWhhMDBuUU9ISGJrV2RUZWpYVi9o?=
 =?utf-8?B?bjZjZW52KzhUZ1pMSlpXbitWWnNLYjNHRCs5bnR2dC9qaHdXVnowMVF4bW1a?=
 =?utf-8?B?dGJsM05lTzlBR2ZKelJLcjdhdWFrQnZCamNPdTZaTkJqTmlhRGpDcmJWbm5s?=
 =?utf-8?B?N1pvck5rNDNUbnNEdFJOWEYrclRYUFhnemY4ODUxeGhJVmZCR0F3OE8yYTNL?=
 =?utf-8?B?ZnBGMmhjaWJ2MUJXTExITFhIZm1iNHhqMy9rcEdHYWpmOWwvWm1UUStKTXhY?=
 =?utf-8?B?aXpmVVl5MmZsWnlTc1hQaUJDVS82anpXN3h1UG5kU2l2dHBBWHE2M0RYN0lC?=
 =?utf-8?B?eGNBQUdwOU5jdFRFQVp5N3BkNmZNMnZWMzRhOCtMampSaDUwVkVCd1BJOXBQ?=
 =?utf-8?B?cEN6SnNFV2ptbU4zVDNWaEluUUhCRyt4WlRaZGxQdDJBMFB3WS81eFg2dWEy?=
 =?utf-8?B?clpMTmQxSFhoU2hPUkR1VkxHa1JUNnZTTHUyVW9BT1VXZW1sUE5pVjNqQVJu?=
 =?utf-8?B?VFNqUTlOWlI5QjJjVCtPaDJ2OVFSejh4bWNNTHdNcWQyL2tzQjdkMG5RMVlF?=
 =?utf-8?B?b2MyYk9Vc0ErV3Bsd3FxMDk5SjRKYW84cy9BY1R6bmJNSEUrR1NtcXRaQ3lY?=
 =?utf-8?B?K1IyRkFZbmRDUndPQmRvOXRQak1MQnJlZld4M2VNWXhzK2xGWlFhT1l5a1VT?=
 =?utf-8?B?YjBDbms2YVM0V1pNc3Uxcnk5eFgweEYxdEdRNG82Z1lGVlJvSTJRTVhVNXQ4?=
 =?utf-8?B?QzdKbHhxcllMVG8rT0xGVTlzei8veDJQdzFyaWxTYjhzWEhhUzhRNERGYXRQ?=
 =?utf-8?B?WmZDK2lLWkJjVFJTY3AySFA2TTFuUk5hUFlRNnlQVmVPVk1XdXBFL1ZlNVZI?=
 =?utf-8?B?cVBEUWVZQVRwTmFmYSsrWVBIWS9STGxsbmd2dGtOSXRtbEM5dTZYZFhWaysr?=
 =?utf-8?B?d1QwaTBHYTJmNWNLeEloaGpxVjVFc0V1cXBlaDQxMDczN05uc2hKTm9GNmFH?=
 =?utf-8?B?bFBvOVplNVhQTFFCcCsxZ0hhdnpINmVLWmdpSDBNMk56TWd2a2w1SGdNbys2?=
 =?utf-8?B?T2RTVlhsNkJKUXZ1NW1mbUdIbzBuZ0Fzcyt6MjFjUGVIVGpUc3ZqRWhURlVt?=
 =?utf-8?B?aDZ2dVFFVWhlUjRHeDFsNmIrNHhwajB1SVVpNTcxL2tvLzA5T0ZjTFBra2R6?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TOKvK16ZQwleVjKz9jl+XwMaykW+BiIqwv8s2eUkG8aL/3I7Q7WjLf51lLtTP7TG8PqSp0TVK6mShak6oMa28LBfuxc5oxTsHP+cuJuEHk0+gg6gnL4UX6A/p9oZUj1m3QyXjivC6F+QTdgEGEoz6uBejcC40PJqWJGRCgL4gGrCos7Bk1dzEidm0tFPaypGdMq9DhsdpVdSS8F+MhLFfMTSq0ZtRNeJchwTf/WqsLB8drUAa+vvXvheyWqmwHG4omSsxMTMw1WuzWU1/YjkWFyViRYTZAlCfnFkVAtPuqEEkubgxLMM7jDF5jVzi8/qmgXyJkOZOwPvLX3Pd20NbZ0GyOWi+2WVcCNynz5vdCkeIBqmcuBlat3Hm62cwcdra4EKSUjzobYgszjh7Uliw2NEnnonp7FIC376rLwpsEc/EFG0XGzZR6DrCtFcpcs3lWAGoPpjLpIL1RpE7HspocRuu6YzJbolySH+EcQcjCh6ePHtBm0s+ICWSVCZirqpUqSQPy3+opMOd1tFb5JzYPfB+9m3DD/xO8GfboV+lAAKeeHES8l4MWz+MuC6Zuz0LUB4uaynxjN4bqiU99er15RrE1t6bwdMowrVHQtobhg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e73e2b9-d84e-486e-cc58-08de0e7dcd56
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2025 19:37:41.3291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8O7lzjPWnoxNpPGKbmN9Gsp0fHr/PxCGylIyrOxdgRNTJedfigdrGvQYvt7qyBqKstfR/ZmLw+TiaVXhLD0Ffw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7925
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510180142
X-Proofpoint-ORIG-GUID: xnOPAnGGEgxCYp9mbWvZXsQFSN4vvT3b
X-Authority-Analysis: v=2.4 cv=Pf3yRyhd c=1 sm=1 tr=0 ts=68f3ec89 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=upNgeOG4mRUQ-0lpxMsA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13624
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXzaskUFAnBNQ5
 PAdBa+iy6BJfWHuoAq+NTDurnNDjofdYsnI1jZnquaQ/T7sdwJMWiSDDPXTRW7/9vcG1Axq8uy0
 xlOkVqTV9hnZFUxB6cRuf5C0nlp9wqBNzrzdBgR9KRJWpuLHp58hHCCdnPLr6cETGZqZEbiW0yH
 JmraHbp+Wkq7cEc4yHDZJ61D2lmam4Fa6HDLODjQIJgf7Ybl8Qo63nrNXGCjPTbJnKypzJQFbwa
 EHOSz0E7bOgtqf/edUZMVhHE5gDNUtp4H0dqaD77JZUN+pQt+wG5awGiHI6XlGwq9EsFZpGtJl9
 auafoe1Sw2KB5kejTjO2CAcspwLXE7jbW0OV5c6KlA9W/Ywr/WVpeiMj+iVHBWK/rhSOQns6beT
 hvJhVMrNPkN5Q0sH4odJ6DTuNZHgq9lBCm8AeO1KLRALBiuFU2Y=
X-Proofpoint-GUID: xnOPAnGGEgxCYp9mbWvZXsQFSN4vvT3b

On 10/17/25 7:32 AM, Jeff Layton wrote:
> As Trond pointed out: "...provided that the presented stateid is
> actually valid, it is also sufficient to uniquely identify the file to
> which it is associated (see RFC8881 Section 8.2.4), so the filehandle
> should be considered mostly irrelevant for operations like DELEGRETURN."
> 
> Don't ask fh_verify to filter on file type.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4state.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c9053ef4d79f074f49ecaf0c7a3db78ec147136e..b06591f154aa372db710e071c69260f4639956d7 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7824,7 +7824,8 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	__be32 status;
>  	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>  
> -	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
> +	status = fh_verify(rqstp, &cstate->current_fh, 0, 0);
> +	if (status)
>  		return status;
>  
>  	status = nfsd4_lookup_stateid(cstate, stateid, SC_TYPE_DELEG, SC_STATUS_REVOKED, &s, nn);
> 

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

