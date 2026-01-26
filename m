Return-Path: <linux-fsdevel+bounces-75503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHVYGwiod2lrjwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 18:44:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 108BF8B9AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 18:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 77A873004F3F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 17:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C33434D3BB;
	Mon, 26 Jan 2026 17:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oyr9aczc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WmllFOJg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89DB349B1F;
	Mon, 26 Jan 2026 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449477; cv=fail; b=p6LK4EYOQL/5spdkqb3bdBilQqEyCKLpIvZo9dAEwwjf+VGS/QrT9RFYabVTeegNZCQQWgxfAR+SpumXchbYCMskMRQ7Z0rZe6foTJnVAHBUPe44/iVOLknNpRqkFkTwQFzQ3CDseS03SRfYtsx6sL/qs1z8c7nGSUIDMAA9Blo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449477; c=relaxed/simple;
	bh=KmrAsBnQOVkljMtz/fg9VO/VnYoFw8ZM9yqywvLP3MY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PPcIjo7Zh31/ghfoTNueHbFfETbqmXzZEkVM3/EIl7oeAxzBSWc9iLA767VQZZjjN6VmWSyLVLV21cHjLndRftLTlfGYAxkL74hgn7GoTqW4a4+fGVX/wDWGwZuWYZgo+rs6ByLy06PuMFih4ZYjL4XhuCwNvmwaZbC8nlzTcSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oyr9aczc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WmllFOJg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60QHPHOY238781;
	Mon, 26 Jan 2026 17:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=CzTkaUQjrItk/QWtTgiKUO8+ESk1ahPenjiSvZksvS8=; b=
	oyr9aczc8C2zkGQeThY4UygvZFEWj4Qqc390qAlmbLBvHKFnXkw0iotybfyEb2XQ
	G6hY29OyG1l+wfdYdoiV/IxQ3wBa/6N6JBcEjeQZUKPywTY64LgC4CXamzace7PZ
	D1qtGCj0zS1AHShmzffs9eplhuXU2An6QFCom/J9WAIJy20iKo3UFBtAtrx01f/v
	1n/ubE2f+W9lOUheEo5kuLHWdWPYoDjA1//OLsw9gnogduqmoecQFdRAv4887gni
	jKa6gKaCXW4oAqqShvXJbYtw9u2rDROUkURTCeDEEAqDQeRzqj7xB34+rq3xu/sP
	KrSD0thLWEyab+TaZb1U2Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvpmrafdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 17:44:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60QGOcCq036183;
	Mon, 26 Jan 2026 17:44:19 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010046.outbound.protection.outlook.com [52.101.46.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhmgynk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 17:44:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4P+QRJ9sTLBTyr7ufyBTHPL3hz15olby5Otw490ftW6WvsAC3Jrktjzka57uVZWw8XSHyChbV0JU98ir5nrXvts2ht+R2HvTV9UwRBvsdaGx0d+xN000oHTx+jUTDlbgU881e2iMOq/ygYTGYzypErUUW5ud8KlbYeczfv5tfXmSla6zsoC+YxFNA7K3DW5K0Q5EXYJ82tSLHdQzIQkXUHYpCWpQ+7rTkFgZ81ZiDew+NxfXYVzQLVqjSYjZbWsoqAE10yWGu3LL8wkExSKLBxzxEuQMynHLYtXImwbncHFwFQldt2dvsxXaHs3jY0BUiPBxFo/1bSOaKFWjVkxLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzTkaUQjrItk/QWtTgiKUO8+ESk1ahPenjiSvZksvS8=;
 b=MedH8OuBkZ131/O4L5zpdNPKkcT0w9iPeZFjeZVsHUEOG21wjN7+CCPxgeaPun8FvJs08lpGCYRsNPe4O/sxkLSB08D5Y78+6sYLWiXPLxXb9onP5N8p09Cqc24WjGIGmtDfElxlTGAKOuSgBCd9o/SNoj1prfmAyicFnX6sbqz1c9qsvMU9vDXw++D8nQIN/gO8D/Mr3IlG9+14Wkzq1Sip3Ssr/bO5PSX1CyCqYSPF6Jko2CIwusDRQxfH666GTIqF4ug56UKKi59mTLQVRZUfz4G/y5NG3gKdmp9xhxHTWDlsr4d/aTLQ2z8zXLkVe5n5aL9l9fQaDcNU737Y9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzTkaUQjrItk/QWtTgiKUO8+ESk1ahPenjiSvZksvS8=;
 b=WmllFOJgbIKAJiv8SjIx6aolYsdEth5X4XLDjfX67E3TJNpAohCoG5UFVUOZj4n9UvyCgP9R5UAvIXfmp2VIGwPVy6yUStrfp/KKkhMvdDpNfoq8KEZr3/gtCdrzUzovet/aSiNpr+zhX3aXPlCFgEc163sFKGvoMAiK/s4duhw=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DM3PPF1A29160CF.namprd10.prod.outlook.com (2603:10b6:f:fc00::c0d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Mon, 26 Jan
 2026 17:44:14 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%6]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 17:44:08 +0000
Message-ID: <79e3e32f-05c1-4f43-9ced-3f6ba58adf95@oracle.com>
Date: Mon, 26 Jan 2026 09:44:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] NFSD: Enforce Timeout on Layout Recall and
 Integrate Lease Manager Fencing
To: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Christoph Hellwig <hch@lst.de>, Alexander Aring <alex.aring@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260125222129.3855915-1-dai.ngo@oracle.com>
 <f18c50fa-6f51-47fe-96de-ef2f0245a892@app.fastmail.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <f18c50fa-6f51-47fe-96de-ef2f0245a892@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::12) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DM3PPF1A29160CF:EE_
X-MS-Office365-Filtering-Correlation-Id: 385bf4fc-659c-4340-ffff-08de5d0281e8
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?S1ErVEM2Q3dTWEdKYlFCOUJQcE5EUzNjYllQd3V0bXpOVS85MXZ4cEdlODhM?=
 =?utf-8?B?NnhhMGlaczhLa1hlQy9VaXVKR09UbzdVamxmTHNmeWQ1UDdFZE5QS0dJdkhv?=
 =?utf-8?B?U2NUZHZzTmRJV0FESVIwQXV6azFzeVJDOUN4Y0xXWDJ1eDFFTlFJZHpnMzc4?=
 =?utf-8?B?cGVmR2pnbC80VWtuLzBRd1R4eFlKMXZNMW5NWVhiaVRSV3NYRVAzM1ZSbTJk?=
 =?utf-8?B?TlFLWEtKS25HTlROc0RoUHdXQUt0SWlFdXJaOE5ZblFxQVBWUG54N2l4bXdL?=
 =?utf-8?B?dDBqcVNUUGtOTjBHQ3dsUlRJTWszeDhCUzVibWFoZGd6ZEQ1SW5JZUFEVFdz?=
 =?utf-8?B?NVRvNVFKL2RLY0lDNkF1eDFXdGg4UVVubHRBS0NrbU1mZ01JczcrRFRMNHlG?=
 =?utf-8?B?YXVFZFpFc2hGUzZaNjdyRERWNFlVZVFJaFVzRWZDTFdmaHFHalAvdTRITVdM?=
 =?utf-8?B?WmxZRnRmNkd0ajJ3YnI3aWd3YVJGcU42YXYwdkZsa1BtWnNDb2Z4eWJJWGF3?=
 =?utf-8?B?OGJFU2QwWHdReHFxRnBiTkRrRHNoMkI1c1poa2ZxdnZmaE1ySzlsbGlGa004?=
 =?utf-8?B?R3NRaXpRNVFlU1FGV1V2c1dqcFhQUEVTWFlRZXhmRDV1Q0E0NWN6R2hJUm5C?=
 =?utf-8?B?TVFIZXd6U1JCR0laTmhKT1d3cHVhVE1Dc2x4QnR0YUlzdjZqRGFINzJGK1Fn?=
 =?utf-8?B?L3p2dldCVEF6MW01cnlwUitTbHp3d3pUOGYrOGJlVzR1RFBxSy9VZEFwSlAz?=
 =?utf-8?B?NFFRdHhhbDdsUlduaG4yR3NReGNSdHB4K0oxRWpmY2c5SS9XOS9yY1dveEFK?=
 =?utf-8?B?Zy81dzg5ckVrYmxzN0lxSUxHbjFmQ282a1dNWW5qQWozQTdJTnI5ZHlCS1B3?=
 =?utf-8?B?NjJ1R2dYV21CblRha2hJYi9Gb09OcmRHVlJSQXlQTXVXSHpEMG9yNC9sODc5?=
 =?utf-8?B?ekVIRVdLR3NsbFlqQlM3bUlZdktaMGlWWmZyQmprSWFIY0J5Y1paSFZHUHlQ?=
 =?utf-8?B?NDkwWVphcGNHMTNGam1XMmhRRzlXT3ZIWDAvZlA5QVgvNGR1ZWFqVDRLWXdJ?=
 =?utf-8?B?WHN4R1FDdjBKTSttVTBYcTBlNjRHRmtPOTlLbG85M1Nkc1JpR2FyVW44M1JT?=
 =?utf-8?B?TFMvZHJoNy92dkZFaWhBUWhmdDYyQlJUd09lbE5FSmJJMHE4ZlV6UEFVS0VP?=
 =?utf-8?B?MUhHY0Y2QWkzVFphY3NXQTNtbUFxWTQzMUVjY0o0dlA3T1dpSUpxVzMvRk5y?=
 =?utf-8?B?Qy9EWHpIbVg0M1lCWk40SmRPR01LZzc3b3MrbzVpcWNjdVMrTVVDcU44WEtQ?=
 =?utf-8?B?aDd0RTFtbDlvblFJanVKYVFjbEN6OHJ3b2hpZzNyL3cxZkpHSDRVYVQ5OW4z?=
 =?utf-8?B?U212QmtTaGN2R3pLSHQzWmpRbTkzWWdjREV4UERRL1IzbnpjMVNZWEZ6dGcr?=
 =?utf-8?B?MTVNMmZkNHhlK3JYNG1FeGp2UGxwR1VMU1JxMEI4WEYwTjdNWWFiU2Z4ZEtR?=
 =?utf-8?B?ejRlN3NUb2twNzlyb1NaY1VRcUJ0OWJ6NlNvQnRxWVc5K1E1b1ROTU1iODhp?=
 =?utf-8?B?eVMrTkFqaERNWWhBbXNKb2FJb1Bwb1REZkxtKy9qZE5nOWJnbldtOTNwSjlk?=
 =?utf-8?B?SUZNTW5mbnBTUHFBclpQUjlEVE5jME04K0NKdnROZ2MyNjlYMmpGUElaNVhx?=
 =?utf-8?B?MjNkUFkyQ1JQclpQM3ZKbUZZd05vYTJXVGJiSDZIclJGUHpWRDZDYkhHKzVN?=
 =?utf-8?B?YUR0UXVtaE1yWU1oNW8vWjlmN3dhelF3bEhHcHgrcnhrR2J6Q0hYWGYwTERi?=
 =?utf-8?B?cW9meE1JMWFoTXZNcFRScENvNldOSGRDUmJLQk9WdXRZZXdVY3hkMk1jNkpU?=
 =?utf-8?B?UDVrTHhvSjJGRVRYZUx6TC8zcndKajd1NWFsdnFNRjVTOGZmYXFqa3luTmpW?=
 =?utf-8?B?eno0R3N5TmNMRlFaTDVrU3pFQmNaUzdnNCsyN0N5U2ZUbFEvZmlSZHlvQWZr?=
 =?utf-8?B?TzNjQzBMRmo0M21uZlEzQlIvVDRET25MdE01cExCOVM1M1huSDMxbFVJS1RR?=
 =?utf-8?B?czdFWGhyckZSS3hMYzUxM0pQTnNUaS9QbjAyOGptVXJBdi9uVGZNTGJNZEdK?=
 =?utf-8?B?TTBoZ2pHem9VaUpzVHBVM3dsNjZ0QTV1S3RwMzcrcm9PYzNaelFVNFRWVDFC?=
 =?utf-8?B?SlE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cUxJbi9zTDFGVWhMYXBmSUthQXZqYkVPanZLb2RYMEFDazNkQlJJQTJqbXJD?=
 =?utf-8?B?d1V2WGtzSy9oRmVBWnVaNHNsR3lnYzZlZDlveVFmcnpsbWhndm9VblYvN3Jw?=
 =?utf-8?B?RDN2OTJzS3kwaGdMdURJVlpwSFl1blR2S202SGE3M0tzVHVmUkkxbFp1TXdz?=
 =?utf-8?B?RU80Qko3eUVVakpQVVZvNFFFbGRFdFczdzJqZGllTGQvbTZrckxjek0zYUpV?=
 =?utf-8?B?dGtIbkF4dWZqamhtejR1Rmx2VE1aVit3TWFIVUFzZHZ4d1IvN2o3VnNmNDhl?=
 =?utf-8?B?TFUrSU5XM1dBT25DNW9CUU9QdG42WHpGcmJRcTdxVDFKNklUZkwzN0ppcThr?=
 =?utf-8?B?dFVVVUVVTGpqdWtqS21wbmNiNWZiMHZxS2Nkb0w2RE9rUStJVk05ZldMZWhU?=
 =?utf-8?B?Vm1ucHN0NUhhL0p6b1hoWG54RE1Cd1FtditXOWV3MTJWK3E1alJkdldzNWZn?=
 =?utf-8?B?VWhZQzF1aFlQNlVNNTFXeEpCMmhwSDNHS08wa3dJWU1kRzYybWJnUmNqRXVW?=
 =?utf-8?B?RGZDMXovYXZlMFM1WDdtZkhYVFNsS0J1bFpLVExrK3RTMzBJcXNEUUIzSFVF?=
 =?utf-8?B?dzhsVnhDTk9FVWtUb2lXSVdRa3JvN0t0cE02ZjF2QmNNYUg5VldxbTJDS0Uw?=
 =?utf-8?B?aTR5RE92QWJzQVh1a1I3OGFQOXZzdlRHRGF0ZzdmK0FhT1V6cVVOL20zc0l1?=
 =?utf-8?B?eG9yRHRiS2ZhbWFUTWZCQlpTWmJhYWorcEV2MzAra1VpMnlsenlYOWdhS1lM?=
 =?utf-8?B?NFc4clVSSU53aS9Vd3FPTzhDeFgzNUJ1K2piNVBBVWFIK2VGS3ppQW9uVnh6?=
 =?utf-8?B?SFRrc0lpeXA2SlBPRHlEWnQ0dVNvTWk2RW5xREV4NnBrNDkwck8rWUNncVZo?=
 =?utf-8?B?ZTlKYXBKQWU5bFp2WWZVakpGVjExeWV6ajBsMjhBd0tQU2JKQVpEa3JEcGEv?=
 =?utf-8?B?RWF0REdnbVJkUmR6YUhobXNHQTJRN3VCcitJY01LcUZMdXpndGdTMjVNT1Jl?=
 =?utf-8?B?MHdoNlpZR1ZWdkZjK0x4N1Y3SGFBd2FCRndDRXVGSFZGWmgyckJLaW55MW9Q?=
 =?utf-8?B?TlA3Wm9GYksxSndPNUZDVS9ELzBrNFZESGxOSG9RV3k2TWhkVG1rNU5qL0oy?=
 =?utf-8?B?Kys1RG5IK05oSHJ2R01BbldLUXUxUUlzR3k2YUY5elNxYXE2YTNrVitXaTVr?=
 =?utf-8?B?MUtjRVRNa0tQWi85L0c4c09zSFJNM0hKTGhqMnIxYmhheTlwOWFEazVzbUhX?=
 =?utf-8?B?Q2IzOUN6Um1YbURtMUxxK0pKTnUvcVdIZExzOFZNbk0wNXlHT1hCVlFvc0o1?=
 =?utf-8?B?WGpaMUxTby8rTmFvOTdaSU05OGlLYldiTGlsdkx1REJjQmJBVytDT1dTVSsy?=
 =?utf-8?B?c292NjA2OVY4S1ZjR0ZaaUN4WHo2U2dPMy81anpHVTlHWFVrM3JSSTY2Zno3?=
 =?utf-8?B?a1h5YXlIUGpUN2h0Mjhld1I0bm1NTWtET1JXcnAweWFlSVFhZXBxZ1VPMkRV?=
 =?utf-8?B?bUlHZzU1cTl0NXZkYmlYVFpzc1JVU05lK1pRbXQ0WHc4bVBJb2pXSWVNWXZH?=
 =?utf-8?B?VGxRY29MYlNweU1zOXh4WkZPVitvZUVXV2Y4R0F4RWszbW9PcERIcDNZQUxh?=
 =?utf-8?B?UlBiQ0FjdGtKV3UwSk5wNUxlY3dkcmdFL0FYNExGMkh6aFE4WWF6YmxKVkdp?=
 =?utf-8?B?Zk1vakVOK29PakZmREt5TE1zZ1hKQTA0V0NGY1pzWHJCOWFqUHZiWjc1ejlx?=
 =?utf-8?B?SXVyVHU5VFB1Z0JrandTQ1R2bFNOR2FKK0E4cUtSTkpYQURPTk1Fb3dQZEdv?=
 =?utf-8?B?Q1VZK0hGY2tXT1g5U3BiNFJ3RlE4TS8xT1NodFhIYnN5Yzc3R1IvNGQzUVNh?=
 =?utf-8?B?TXZ3OHVXN0IxeWszbHFSalZMc0JNODROeFJTRTlNUjlOVEpxM2QxUnhsQlRq?=
 =?utf-8?B?U0UxRjVEZTR0MWg0NTExeFRkK2xCSC9OZGxXYzlsWi8rUUFNUG45aXVCZkxK?=
 =?utf-8?B?elNPcGIxME9DcG8wS1RkdGJkc1VBcXdYRlVjSjZzWTRnRWh0M0dZU1k4cEpM?=
 =?utf-8?B?WEloS3RxbGdlZjZIcVJhQ0QwTXpjNEhaK1cyOG5ESDk5WHdIdzBDTXRxem9m?=
 =?utf-8?B?T3VYZjhXM29xUmQ5WjZJMGczeVY4ZXBXRUUwSVIvMldMN2dVc2paZ0I2Qkkr?=
 =?utf-8?B?UDByQ0pNTGRjbjJwaFFBQnp1Z0Z6S09kUHZadkdBMXFhR3NVNjFCYWtDSldX?=
 =?utf-8?B?cW9yNWFqTXpvT05jbVBQY0kvQXNxZnR6eUhtNElvU0ZkaTZEcnUwdlJpQzRM?=
 =?utf-8?B?VkVDWkhlcmpVK0MzWjRJaWNqTjg5aHNuSEkvWFFJWFFQK0I4bHR0QT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	430WyO3+T+dW4lXU7wNYLuDYOVwrbGqtLrvZ/3DQAgWsnzDJ5ehSMR4Uv0/LC+/gdzrl6cTp/TcgbliSokqV+ZJ67v5U+1SP3N0EzSSLXjbKU+ewjIdOUV7prid5p4T9GUESXG1tJeK9AWN465vWYOI2EZNx1DY7tW/hfaNnscbz1KIqU8VVBRlO6/pFPDiKcxL6lwq6zkBEGvVBhSyt22C89vGOdHwMy2FunDxGi+EzuKMALttgvPpcZB0wSvMC0wccJe0oKNXEp3/n5tMDAz7euN9fXp4szcdlGf1eS2d6twoaKXEcKinWfOuivkaFEBchYcw4QflY+iRXX4rQjlxRdSzXSwc0UDtnf6x9QxRLfhgwzpdPxQj+ZW6Ipn6HwWndtzCXMwa0hefh6eilvK4ETdaxLU2bmC9CEnM+07nWlqpk6MOftkrrLels3AZcvOxawowUUHZatS/x2/qlhVqIDNE3D5tiQyde7wv2I0dOPWgFZGOfOJsmfGMqS/3wyiOf5K3UH61gGaZE/5fWL1onh0egePvPBu7pMsXuWO/xJEJunEQyxg5gUOydNaHl7V7wQPnXzNfNDLgDGdxYK9GilibjGfMvIXmgqJIX7eo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 385bf4fc-659c-4340-ffff-08de5d0281e8
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 17:44:08.5748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkJJs9HIqeXKn3+2iO5YjWraFuOZG4yTd6p4tf1t+vtbwvVN8L21Fny1h18trZ8luBApAs+aD9GOjHsB/cQ/Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1A29160CF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601260151
X-Authority-Analysis: v=2.4 cv=Q//fIo2a c=1 sm=1 tr=0 ts=6977a7f4 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=so7ucoBSU7JiNv0g8lcA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12104
X-Proofpoint-ORIG-GUID: bo-11Wz_Q_CfG0e8yLjU06PqbIDrSNMM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE1MSBTYWx0ZWRfX7ND6ct+q+FGO
 jizBl2molYOcnVr3o2PK8dWndJkKzLjIjmHS6C+J2CTKRPtOZ6enGA4G0YSR0BULuuPlVeYlL5P
 BJ/ybGdnuONo6ccFgxQfaKz5gV0WTcjzVEYUFxgEF2UAe6XCFR/wI8LVbJlxgP+IhubuqOtLJWd
 upklAfTjMIGsgADwfiEheKchKtv+14J+FuT99v5gA3evBEUkTcruw1QYLYwy/zP1hbAScg3Qvpl
 4mtuzc+56yBNQRTAu+tAMIAKK3i3UlCagwblVoipyzlSt3FndITwgz6CdkFoGKsRYQ3HMnTBQ2c
 Mwlhwbfns8/rt7XyxnRAgDDPl7jCLS5kJuPuKGbMBnowhheTTqWT0PC1Zc+GDm5WzUJ4G/KsLDm
 RfF7SDUr1NkChpDZ5SqmkmRiwrVNzc69gPrwKj2JHKzzBI3GpLj076Kj8uNnD+nL/GWHHTP/DAR
 E7Lu6eL50LUVP+/acyE9S65/8zFFX1FW/pnt31i8=
X-Proofpoint-GUID: bo-11Wz_Q_CfG0e8yLjU06PqbIDrSNMM
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75503-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,oracle.com:email,oracle.com:dkim,oracle.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 108BF8B9AE
X-Rspamd-Action: no action


On 1/26/26 8:11 AM, Chuck Lever wrote:
>
> On Sun, Jan 25, 2026, at 5:21 PM, Dai Ngo wrote:
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
>> Fencing operation is done asynchronously using a system worker. This
>> is to allow lease_modify to trigger the fencing opeation when layout
>> recall timed out.
>>
>> To ensure layout stateid remains valid while the fencing operation is
>> in progress, a reference count is added to layout stateid before
>> schedule the system worker to do the fencing operation. The reference
>> count is released after the fencing operation is complete.
>>
>> While the fencing operation is in progress, the conflicting file_lease
>> remains on the flc_list until fencing is complete. This guarantees
>> that no other clients can access the file, and the client with exclusive
>> access is properly blocked before disposal.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   Documentation/filesystems/locking.rst |  2 +
>>   fs/locks.c                            | 29 ++++++++++-
>>   fs/nfsd/blocklayout.c                 | 19 ++++++-
>>   fs/nfsd/nfs4layouts.c                 | 74 ++++++++++++++++++++++++---
>>   fs/nfsd/nfs4state.c                   |  1 +
>>   fs/nfsd/state.h                       |  3 ++
>>   include/linux/filelock.h              |  2 +
>>   7 files changed, 122 insertions(+), 8 deletions(-)
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
>>
>> diff --git a/Documentation/filesystems/locking.rst
>> b/Documentation/filesystems/locking.rst
>> index 04c7691e50e0..f7fe2c1ee32b 100644
>> --- a/Documentation/filesystems/locking.rst
>> +++ b/Documentation/filesystems/locking.rst
>> @@ -403,6 +403,7 @@ prototypes::
>>   	bool (*lm_breaker_owns_lease)(struct file_lock *);
>>           bool (*lm_lock_expirable)(struct file_lock *);
>>           void (*lm_expire_lock)(void);
>> +        void (*lm_breaker_timedout)(struct file_lease *);
>>
>>   locking rules:
>>
>> @@ -417,6 +418,7 @@ lm_breaker_owns_lease:	yes     	no			no
>>   lm_lock_expirable	yes		no			no
>>   lm_expire_lock		no		no			yes
>>   lm_open_conflict	yes		no			no
>> +lm_breaker_timedout     no              no                      yes
> This might not be consistent with other comments that state
> lm_breaker_timedout runs with no locks held and may block.
> But looks like the flc_lock spinlock IS held. Documentation
> should say flc_lock = yes, may block = no.

Yes, I forgot to update this doc. Fix in v3.

>
>
>>   ======================	=============	=================	=========
>>
>>   buffer_head
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 46f229f740c8..28e63aa87f74 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -1487,6 +1487,25 @@ static void lease_clear_pending(struct
>> file_lease *fl, int arg)
>>   	}
>>   }
>>
>> +/*
>> + * A layout lease is about to be disposed. If the disposal is
>> + * due to a layout recall timeout, consult the lease manager
>> + * to see whether the operation should continue.
>> + *
>> + * Return true if the lease should be disposed else return
>> + * false.
>> + */
>> +static bool lease_want_dispose(struct file_lease *fl)
>> +{
>> +	if (!(fl->c.flc_flags & FL_BREAKER_TIMEDOUT))
>> +		return true;
>> +
>> +	if (fl->fl_lmops && fl->fl_lmops->lm_breaker_timedout &&
>> +		(!fl->fl_lmops->lm_breaker_timedout(fl)))
>> +		return false;
>> +	return true;
>> +}
>> +
>>   /* We already had a lease on this file; just change its type */
>>   int lease_modify(struct file_lease *fl, int arg, struct list_head
>> *dispose)
>>   {
>> @@ -1494,6 +1513,11 @@ int lease_modify(struct file_lease *fl, int arg,
>> struct list_head *dispose)
>>
>>   	if (error)
>>   		return error;
>> +
>> +	if ((fl->c.flc_flags & FL_LAYOUT) && (arg == F_UNLCK) &&
>> +			(!lease_want_dispose(fl)))
>> +		return 0;
>> +
>>   	lease_clear_pending(fl, arg);
>>   	locks_wake_up_blocks(&fl->c);
>>   	if (arg == F_UNLCK) {
>> @@ -1531,8 +1555,11 @@ static void time_out_leases(struct inode *inode,
>> struct list_head *dispose)
>>   		trace_time_out_leases(inode, fl);
>>   		if (past_time(fl->fl_downgrade_time))
>>   			lease_modify(fl, F_RDLCK, dispose);
>> -		if (past_time(fl->fl_break_time))
>> +
>> +		if (past_time(fl->fl_break_time)) {
>> +			fl->c.flc_flags |= FL_BREAKER_TIMEDOUT;
>>   			lease_modify(fl, F_UNLCK, dispose);
>> +		}
>>   	}
>>   }
>>
>> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
>> index 7ba9e2dd0875..05ddff5a4005 100644
>> --- a/fs/nfsd/blocklayout.c
>> +++ b/fs/nfsd/blocklayout.c
>> @@ -443,6 +443,14 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode,
>> struct svc_rqst *rqstp,
>>   	return nfsd4_block_commit_blocks(inode, lcp, iomaps, nr_iomaps);
>>   }
>>
>> +/*
>> + * Perform the fence operation to prevent the client from accessing the
>> + * block device. If a fence operation is already in progress, wait for
>> + * it to complete before checking the NFSD_MDS_PR_FENCED flag. Once the
>> + * operation is complete, check the flag. If NFSD_MDS_PR_FENCED is set,
>> + * update the layout stateid by setting the ls_fenced flag to indicate
>> + * that the client has been fenced.
>> + */
>>   static void
>>   nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct
>> nfsd_file *file)
>>   {
>> @@ -450,8 +458,13 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid
>> *ls, struct nfsd_file *file)
>>   	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
>>   	int status;
>>
>> -	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev))
>> +	mutex_lock(&clp->cl_fence_mutex);
>> +	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev)) {
>> +		ls->ls_fenced = true;
>> +		mutex_unlock(&clp->cl_fence_mutex);
>> +		nfs4_put_stid(&ls->ls_stid);
>>   		return;
>> +	}
>>
>>   	status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev,
>> NFSD_MDS_PR_KEY,
>>   			nfsd4_scsi_pr_key(clp),
>> @@ -475,6 +488,10 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid
>> *ls, struct nfsd_file *file)
>>   	    status == PR_STS_PATH_FAST_FAILED ||
>>   	    status == PR_STS_RETRY_PATH_FAILURE)
>>   		nfsd4_scsi_fence_clear(clp, bdev->bd_dev);
>> +	else
>> +		ls->ls_fenced = true;
>> +	mutex_unlock(&clp->cl_fence_mutex);
>> +	nfs4_put_stid(&ls->ls_stid);
>>
>>   	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
>>   }
>> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
>> index ad7af8cfcf1f..4a11ccd5b0a5 100644
>> --- a/fs/nfsd/nfs4layouts.c
>> +++ b/fs/nfsd/nfs4layouts.c
>> @@ -222,6 +222,27 @@ nfsd4_layout_setlease(struct nfs4_layout_stateid *ls)
>>   	return 0;
>>   }
>>
>> +static void
>> +nfsd4_layout_fence_worker(struct work_struct *work)
>> +{
>> +	struct nfsd_file *nf;
>> +	struct delayed_work *dwork = to_delayed_work(work);
>> +	struct nfs4_layout_stateid *ls = container_of(dwork,
>> +			struct nfs4_layout_stateid, ls_fence_work);
>> +	u32 type;
>> +
>> +	rcu_read_lock();
>> +	nf = nfsd_file_get(ls->ls_file);
>> +	rcu_read_unlock();
>> +	if (!nf)
>> +		return;
> The refcount was incremented when scheduling the work but is never
> released for this early return. Do you need:
>
> if (!nf) {
>        nfs4_put_stid(&ls->ls_stid);
>        return;
> }
>
> here?

yes, we do. Fix in v3.

>
>
>> +
>> +	type = ls->ls_layout_type;
>> +	if (nfsd4_layout_ops[type]->fence_client)
>> +		nfsd4_layout_ops[type]->fence_client(ls, nf);
>> +	nfsd_file_put(nf);
>> +}
>> +
>>   static struct nfs4_layout_stateid *
>>   nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
>>   		struct nfs4_stid *parent, u32 layout_type)
>> @@ -271,6 +292,9 @@ nfsd4_alloc_layout_stateid(struct
>> nfsd4_compound_state *cstate,
>>   	list_add(&ls->ls_perfile, &fp->fi_lo_states);
>>   	spin_unlock(&fp->fi_lock);
>>
>> +	INIT_DELAYED_WORK(&ls->ls_fence_work, nfsd4_layout_fence_worker);
>> +	ls->ls_fenced = false;
>> +
>>   	trace_nfsd_layoutstate_alloc(&ls->ls_stid.sc_stateid);
>>   	return ls;
>>   }
>> @@ -708,9 +732,10 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb,
>> struct rpc_task *task)
>>   		rcu_read_unlock();
>>   		if (fl) {
>>   			ops = nfsd4_layout_ops[ls->ls_layout_type];
>> -			if (ops->fence_client)
>> +			if (ops->fence_client) {
>> +				refcount_inc(&ls->ls_stid.sc_count);
>>   				ops->fence_client(ls, fl);
>> -			else
>> +			} else
>>   				nfsd4_cb_layout_fail(ls, fl);
>>   			nfsd_file_put(fl);
>>   		}
>> @@ -747,11 +772,9 @@ static bool
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
>> @@ -782,10 +805,49 @@ nfsd4_layout_lm_open_conflict(struct file *filp,
>> int arg)
>>   	return 0;
>>   }
>>
>> +/**
>> + * nfsd4_layout_lm_breaker_timedout - The layout recall has timed out.
>> + * If the layout type supports a fence operation, schedule a worker to
>> + * fence the client from accessing the block device.
>> + *
>> + * @fl: file to check
>> + *
>> + * Return true if the file lease should be disposed of by the caller;
>> + * otherwise, return false.
>> + */
>> +static bool
>> +nfsd4_layout_lm_breaker_timedout(struct file_lease *fl)
>> +{
>> +	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
>> +	bool ret;
>> +
>> +	if (!nfsd4_layout_ops[ls->ls_layout_type]->fence_client)
>> +		return true;
>> +	if (ls->ls_fenced)
>> +		return true;
> Between this check and mod_delayed_work(), another thread could
> complete fencing. This can cause duplicate worker scheduling and
> reference count leaks.

This could cause another worker to be scheduled while fencing already
completed. But the new worker will detect that the device has been
fenced and do nothing. Each worker increment and decrement the reference
count separately so I don't see how it can leak?

>   Should you hold cl_fence_mutex while
> checking ls_fenced?

We can't hold the cl_fence_mutex here since this function runs under
the spin_lock flc_lock.

>
>
>> +
>> +	if (work_busy(&ls->ls_fence_work.work))
>> +		return false;
>> +	/* Schedule work to do the fence operation */
>> +	ret = mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, 0);
>> +	if (!ret) {
>> +		/*
>> +		 * If there is no pending work, mod_delayed_work queues
>> +		 * new task. While fencing is in progress, a reference
>> +		 * count is added to the layout stateid to ensure its
>> +		 * validity. This reference count is released once fencing
>> +		 * has been completed.
>> +		 */
>> +		refcount_inc(&ls->ls_stid.sc_count);
>> +	}
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
>> index 583c13b5aaf3..a57fa3318362 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2385,6 +2385,7 @@ static struct nfs4_client *alloc_client(struct
>> xdr_netobj name,
>>   #endif
>>   #ifdef CONFIG_NFSD_SCSILAYOUT
>>   	xa_init(&clp->cl_dev_fences);
>> +	mutex_init(&clp->cl_fence_mutex);
>>   #endif
>>   	INIT_LIST_HEAD(&clp->async_copies);
>>   	spin_lock_init(&clp->async_lock);
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index 713f55ef6554..d9a3c966a35f 100644
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
>> @@ -738,6 +739,8 @@ struct nfs4_layout_stateid {
>>   	stateid_t			ls_recall_sid;
>>   	bool				ls_recalled;
>>   	struct mutex			ls_mutex;
>> +	struct delayed_work		ls_fence_work;
> nfsd4_free_layout_stateid() needs to cancel ls_fence_work
> explicitly before freeing stateid memory. Otherwise if the
> fence worker runs after the stateid is freed, it will
> access the freed stateid memory.

The layout stateid cannot be freed by nfs4_put_stid once the
fence worker has been scheduled, because the layout stateid's
reference count is incremented at that point.

>
>
>> +	bool				ls_fenced;
>>   };
>>
>>   static inline struct nfs4_layout_stateid *layoutstateid(struct nfs4_stid *s)
>> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
>> index 2f5e5588ee07..6939952f2088 100644
>> --- a/include/linux/filelock.h
>> +++ b/include/linux/filelock.h
>> @@ -17,6 +17,7 @@
>>   #define FL_OFDLCK	1024	/* lock is "owned" by struct file */
>>   #define FL_LAYOUT	2048	/* outstanding pNFS layout */
>>   #define FL_RECLAIM	4096	/* reclaiming from a reboot server */
>> +#define	FL_BREAKER_TIMEDOUT	8192	/* lease breaker timed out */
>>
>>   #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
>>
>> @@ -50,6 +51,7 @@ struct lease_manager_operations {
>>   	void (*lm_setup)(struct file_lease *, void **);
>>   	bool (*lm_breaker_owns_lease)(struct file_lease *);
>>   	int (*lm_open_conflict)(struct file *, int);
>> +	bool (*lm_breaker_timedout)(struct file_lease *fl);
>>   };
>>
>>   struct lock_manager {
>> -- 
>> 2.47.3
> In nfsd4_scsi_fence_client(), when a device error occurs (e.g.,
> PR_STS_IOERR), ls->ls_fenced is set even though the client may
> still have storage access.

I will revert this check back to (status != 0) as error condition
instead of checking for selected error codes as it does now.
Fix in v3.

>
> Also, if fencing consistently fails with retryable errors,
> fencing is continually retried with no maximum retry limit. Is
> this new lease breaker timeout designed to take care of that
> cleanly, or is it something that needs some explicit logic?
> I don't immediately spot a mechanism to force lease disposal
> if fencing never completes.

Currently there is no mechanism that prevents the fencing operation
from retrying on errors forever. Would it sufficient to add a max
count for retries, like 5 times?

Thanks,
-Dai

>

