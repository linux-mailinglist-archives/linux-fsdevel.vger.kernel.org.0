Return-Path: <linux-fsdevel+bounces-32868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 380EC9AFE94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 11:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD94A1F23363
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 09:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB55D1DD891;
	Fri, 25 Oct 2024 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EhBxFH+S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FVSG4Jqx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170F71D966F;
	Fri, 25 Oct 2024 09:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849328; cv=fail; b=rfVSuj79yhdGIpJwd+L9VkjjAxc22QrPptqAWNelloxQMb58gy0rObrmAn0LiV/0QwU7A/3zneEqIzxi2kdeOs6xmQ04p3Ffx1nNze28rGMXj8/KmYXk+SPa/mAVd89WCD4lbg49299fKtZu/CC/xGR7W1vbH0lwmgs1YTH96hU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849328; c=relaxed/simple;
	bh=fl6a8n66c++32hPMLgIngWUd+sltMLOk47519es960o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bxq9Zs0aS/DLqSj1c1TelpgtKCD2XOXq1GP32804qzED2RRk3GHm65i+oixk+3CoO39Oc8caAKjrrtsvDrdKJNCEdFgwREpbAvoDxjUm3MqZuWngV2B1qHDS2bovpb4CBjny7gMwCBfxmf2T7QRwdSbvI1MTGfAs1e2yxSxHcxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EhBxFH+S; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FVSG4Jqx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P8BZG7005832;
	Fri, 25 Oct 2024 09:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=heUeF+ssEqAdhewzVnzOuAsiVcVMB8rPTRN6bk0ufpM=; b=
	EhBxFH+SrKw2iDganFdqi9Pd7B8z7HF0IpeGARuCiMBmt/5DtsFOZcOZ20uxtfUZ
	uJqgv6ICBmABV21tOUls9D6lriISeu9xMrINKCEMfCfZo2GT+cIpA6G76W68A1W3
	CCECzPW61XQd608Hr+HGDJ5IPSKf4oXo6MfrIEBagnVBrxrTVqFVQOi9fEyySbL5
	pixny4+7n9qwztySksWCzTUg92k6zEpZ2lwx2YWNW/dVYPLiZH4ricMFUr96ExnX
	lQ0vyjpjX4Hhgvm72rLKsCoiO7xXyzL9n0o4rqLOGYq4Xg0V0FWPU4S0bpfQJ6bM
	hWqrEE6PGQZnnG93WcECPQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53uvk1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 09:41:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49P7IXsd036212;
	Fri, 25 Oct 2024 09:41:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh53wg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 09:41:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLzbZD7n4NrkTHwY1gB+tKe2JLibiOOjgbmqBTvkbWBOaR4PDXCveN9blIR9FFkrha8dX2W5qzr8K7/QFx8RK2Ww0D9/8AIND7f/yA0/t8gNGJAEiVAKEZmyu6+pABmLqJOCZaEOfRcYuzCszx1ZPuIuUmwP9DlgIqZ3BZmBGL58Z+fYZ1BQmJIxiAjNKmvwXm13yyqStCHzvd+M8KjIpOboseF2+X05OfLsIvgkBkjNIeolmfSgfslezVJNi+NGnWa2XOHB2KCZCQV6yRlhKNQJSJcPKQEuNvScbBbOAHVskaDAY993H6Ut3VrGt6hFUMN6JrDi4HvZN1ulXLH0Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heUeF+ssEqAdhewzVnzOuAsiVcVMB8rPTRN6bk0ufpM=;
 b=BB6Vf434hxXctEqsiuPB/u/cSx6bmeldY8CsJTYUUFD1mEno/d7gST8Ef9J1ZOTy+xI2LQ4YiLdmJFYBw5dAvFpPZdFTwiuefP2mPnwFwG3tUDmaeRnUrQlgkXQe9Av9WgSMiinkAZu7bT1ZA9zEP5hIQzufx+UpYhrBjIXScGohNVjJ5MtIDXbPDwSTfqo/ES8ifhOv0K3evloUqciOBMM0RB6Ok0Trkr3qReR+96AMxveG9cRFzdAMxmisFOJswcwiU8RJJ3cZjH38LFO+bwVTTap5TDCWj3tbYYCC/Ccu9bQAFSx+Ub6tPkbvsM+g4ghgzDvZObOYY1BCP97w5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heUeF+ssEqAdhewzVnzOuAsiVcVMB8rPTRN6bk0ufpM=;
 b=FVSG4JqxVmvDy7aa5kx6XRzLhgKQ6ix2BgeUYJ1o1lrtE5+tCFRHIYI00gfExR+kitRJB3wCt6RSL38BEqVVT4JPIPVXiKuSEzR5z6kCGM+fC+Ihwl8iH3ZBUoNr9pz5898gAu06veHyiuNZAxKD8giRl0WsQRCh89BQxmYL9tk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4742.namprd10.prod.outlook.com (2603:10b6:510:3f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.30; Fri, 25 Oct
 2024 09:41:45 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 09:41:44 +0000
Message-ID: <314835ec-98bf-472c-8be7-0b26e50cfc9b@oracle.com>
Date: Fri, 25 Oct 2024 10:41:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] ext4: Add statx support for atomic writes
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig
 <hch@infradead.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1729825985.git.ritesh.list@gmail.com>
 <e6af669b237690491ecff0717039e28e949208c8.1729825985.git.ritesh.list@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <e6af669b237690491ecff0717039e28e949208c8.1729825985.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0030.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4742:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f025327-86de-438d-313c-08dcf4d93cc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHFnWFJpMTdQWUlQQ1Voamo2L2l6ektDb282aGEvOVg3NzhwK0hHZWNoYlEz?=
 =?utf-8?B?bURlTHYvd2RUSXYrRldRRnVnOTNrOGlHZnJzVFNjbTBSbTRBRVF3N2dzOEY5?=
 =?utf-8?B?bEE4L29lemg3b050YkJ0R0h1MFlXMElVejdvV2dZaXdFR2p4c2tySmRTbXlL?=
 =?utf-8?B?clROMkhaVWlFeEowSDZMKzBkU1RITTVUOE4rVG93WExUb1dSVFdZQ0pGaVRp?=
 =?utf-8?B?SHV6SVQxSE9YWWdSMStEcDVTOHhZS1Q0blFKeGhPdFRxdU52M201bjRVbWRE?=
 =?utf-8?B?clVYTERTdUtnRFRoRFkwQlMwMmNVQjZqRG9NN1NiTEUzL1RBR2tLd0tUeXFE?=
 =?utf-8?B?ZUpteVc0VHJtV2pwLy9hVnhENytjMmdKcVRtc2x6R2tVS0ZzQnJmNGZHQzN3?=
 =?utf-8?B?WkVoTmtVcGRVY1I3Mmh4cFl2dWJJbTZ0NXFSYkEvcFNkMHFCL0FPT056bFhw?=
 =?utf-8?B?d2tBcGhjYllFd1RhSUJESGRUdTZIRWZoNGVIZXBna2JCd0cxcDM0enlVUXcz?=
 =?utf-8?B?OWpsSFBLNnQvTzl5dy9ZbmVFZjhKMDB3bk0wNWhvR3c5S3NtaXYvekh3a0ZL?=
 =?utf-8?B?RUpSZkFXYXJ1cjRtZmlBUlYxeSs0UEc1cDFmTURYMm9SNlE5QVc0QVQ2VktJ?=
 =?utf-8?B?d1JWTm5qaUJOYlR2b3NRNko0aC9vNURFcmFpQlh1RTZDY3o5SE1yZ0theUpB?=
 =?utf-8?B?V3NJL3Fhb2V2ckFRbUlUU1RKUmlkYWE4aE5jQzZxaEZDZlBkOG5BcmxOWS9F?=
 =?utf-8?B?Lys0Zm54ajRnWDE2V3J4RVoybGdoWmVlTW15ajc1V1Z2VGNrZitob1NCUXNn?=
 =?utf-8?B?Zm5nRlRVbDJZMThhcVhLWXpMS3ljUk9HbVlvRGQ5cTZSVDYzUEVLeUpyYVdx?=
 =?utf-8?B?WHlsUmdhejlJTTFXbDk1THBzOTJVWGFrbExBTi9wTW5VQlpmY0owZ29GUGs1?=
 =?utf-8?B?ZXZkd2dTY1FuUHBLRDdha2RpcVN3Qmp5WGFTaHVUR3ZDY2dLYkNHeFllQ0lk?=
 =?utf-8?B?RUYxNzc4dElsYWhTU0UrbDFjbVgwTnRoT3hORk5tSFhyMG84bTBYM29hYmty?=
 =?utf-8?B?SDV0azl2UVhHZHdMbWdCemhoMTFXbDM4VWxDUG5aWitFblBBaDA5NVR2YmpX?=
 =?utf-8?B?SUN0V1VpZCtSSnNSbFVyTjhvQlloQWpmcGxUVDVVUzZaa3A5Q25ZQkplZjRV?=
 =?utf-8?B?Z2VmT1VwdmZRYTV5QUpVOW9DZWp3ZlcxRG40R1JWVTB1eVRWdjJDZ1dHYS9z?=
 =?utf-8?B?MDRVU2tMUEJBaW0zUnczeWhoenQwNDhRRmdkNkJrU0RjdjE2RXhmZWQ5OXNX?=
 =?utf-8?B?S0RVR3NaQVdoa3l3TThDckhKVWI1N1gyRTdoZGc4UU9Ka2hUaWRGR3lsMXhU?=
 =?utf-8?B?UlNtVldOc1pXUjl1aHBKY00wUVBUTXlQR0JpaHJDNklmZk5xNUxCQTRjYmdR?=
 =?utf-8?B?dGk4SE54NFZKMTM2WEFoa3FUN29BdEJuWVRGUkxpbnhta25IeUZjaDhmK3px?=
 =?utf-8?B?RGNTanZoQ0NPdDg4Z2N4cTYyYlN6bXlaR1prQldNblpuQm4xdE9tMmFFVWJi?=
 =?utf-8?B?MmJDM1gveUNsZWlyQVJiT2g0QTBWME0zN3NWckxWdzB3ak43Z2ZyUTBNQ2tq?=
 =?utf-8?B?cWF5T2lkME90N0ozdDJadllEN0Z4eFNuY0ZJekk0SnlrZ2xXM05taEFkQUU0?=
 =?utf-8?B?S0ZWbzZhM1prTGVEKzhjYkxMUzNyWDBnT25ZcHpBZGhyblhDSHFIWXlaSjkw?=
 =?utf-8?Q?40NqS7ntkWclFOiKXCcFTacEi44uhRwJJSr4eD9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDVTVEtXS0RZT0NtUDFacW5nbTdSOCtpYThRUUJ6c3EvMEJObFRjMHY4SHNH?=
 =?utf-8?B?c3ZuSktjMHFHdVJDTXdiWmFxUXRlU1pISitqcFUvSUJ0OHNKK1ZRZ0FjVHY4?=
 =?utf-8?B?Ri9NMUxYL2ZWSm9JdEgxL1Boei9hMnpUTlNDakdoQS9FY1FNOFJkNHdkU1Mw?=
 =?utf-8?B?R3NDZk4xcUxKSFF3bmlNRzBjYTZEVnhjbXNoUkUySTdUZUhxcTQ4d0M3Y05B?=
 =?utf-8?B?MWR1cWRVRklTMXBJN056ZVRjREl1dWlFUG1jdHJMVmx5d0xJREx4cFJsVWdu?=
 =?utf-8?B?M2dxYTR2cGNBR29ubS9UNm1NdUZ2d2xZeDdhNHZNYTV6ZWJJeVh3NGdwclVF?=
 =?utf-8?B?WDFmTTFzZzdDMWE0OGc0azRhL3VYdXRvbmdJRXJwbGlITWNFVlpaTEhYdXZL?=
 =?utf-8?B?eTZyQ3Z4aklNcHdoRXNCMm9QTU9rSGoxcWpteWdTRFRETjJWRzh1RjF3T2Vl?=
 =?utf-8?B?dFE5QlBRZ1V5UThkZFdxcHdUMHY0dm10RWE1SXhUSzFQVG5sbDZCdzdQQjdu?=
 =?utf-8?B?aVNFY1lXaSsxZlhsVXNkVFEySUk3Vk5WUjA5ekwrSVRySVU3M1dYd1ordEgw?=
 =?utf-8?B?aGllbnE0eDdTVEV4dXF1djlLLzZqSG5aTmJ3OGRuUm9ZbW5WWlllMVV4bHUw?=
 =?utf-8?B?Z2dsdnhnK3p1R0FHNWF3b2MzTHZyOHJXK3R4QnU4SlY4VVJNNHRHTyt0b2kx?=
 =?utf-8?B?NFJWNnd3aTVoMVJuanBETTJYcGJDZXZ0UWY2d0t2NTZJdUpxMGVIejJxQmdy?=
 =?utf-8?B?ajRVYW1QbUNvWTEvTnMrUzI4eWtQZFJEblpGNDBHOWdJWUdBbzhiNkpGVjZ4?=
 =?utf-8?B?MlQwcmQ4dnIzVnlPNDRVTGVhbjZZS1YzMUhVbjc5NktNM0ExYlVoa2ZSRDlZ?=
 =?utf-8?B?WWd3d2k5bURCM242WVJwL2RLWEZVbUNnZUhtMHdBdE82TXZGWjFOOE1OZGhC?=
 =?utf-8?B?RzgvcnR4eXVHcFFBT2RRWjBKYXM1N05jWlh4NjE5MVl2akZwWXRUNFZPbHJT?=
 =?utf-8?B?NnEvSGNCWUc5T0U3UHp4QThOUS9RYzFqaUtxVUkzWnRSM0EwbXAwSlVZVE5y?=
 =?utf-8?B?MmdvUzlRZllYV2l1YndXalNyelJpMWlGRFJnOENBb01GcUN0OGxtUHFPeGE4?=
 =?utf-8?B?d0h4OXA1SG5HRVNUK2FEVE9ZVzI2Snd0NFZudG11aTJoVkNhczNFbjFCYks4?=
 =?utf-8?B?aDExa1NpQmt1UFRUVFkrYkJYWUtUVWNxMkcvTzhjK1llN2ZuZ0l1SnphRWdZ?=
 =?utf-8?B?WTNvWVlMeDQ0WEVHc0tUakg0S0JtWWhQQzJsTGFBeVVYeG1BdUxNcnhzU253?=
 =?utf-8?B?ajZQcWNTVzhUYVFXNklsQWpIbUFaaUFFZWZFdDAvQVlZTnlJdHlhYUVoSGFt?=
 =?utf-8?B?VER0Nk5ibFlWVEJmRzNjSTR2OFJubHNqNUJldjB6OGtDVGZmZnF1MXBtQ1Ry?=
 =?utf-8?B?SkcvUGtBK05SamV5MnhiclAreFAyME1TeTBNajVkYU9tcEJQWU1ZWFJPSEtP?=
 =?utf-8?B?bS9qOGR1UUxadWFkRHhIMmJJSTdjeHVYVnl3aWcrK25aQXVRdTRVVk14MnQy?=
 =?utf-8?B?dmJZUHVOR2xiV1FnVmV0anU3RTlSUHpvQ1pPcHlRdFo5VTQyQjFNMFhsclE4?=
 =?utf-8?B?VWRPQTNUMW9BY3c4RUJ0RkZYR2F1RnF1T2lrcVMyQUJkVHllclMvTjl2SVFL?=
 =?utf-8?B?K2VQOXJhL0Y3YnN2aWV1SHdMS1BBeWNRaU5qRFJTV3VkTUpIa2RPYlZCK0FP?=
 =?utf-8?B?aXBncEpzZG1ZeUNGUm9HRmZWZ0Njd2Z1TytJaWdoOWU0c1AweWx6ZlUyN1Jz?=
 =?utf-8?B?aFhkdWdSR2k2cXAzR3pMTDhVZEROVjdJQStxNFViTlNpVlMxOWFVenF2c091?=
 =?utf-8?B?alcrMWdqRkI1QXAybkJyU1pXUjZPMVNkazN4L0lvcVlNZWFGY2d6NktvMUk5?=
 =?utf-8?B?b0dYUzVWdndjV2d1ZWM1ZFgzcSt2NG14a09CMmIrVGhmQ3hQdWxLaTRWcVIy?=
 =?utf-8?B?WGNzRnhjM0dxN1p5Sk03bjdwMlFCSHZ4N1lXWEFIMjJKL3JxbDdYZmRacjF2?=
 =?utf-8?B?amo2cktOQW9YQnNPaytXMTdMaXgvMloyVkxOOXI1LzJvemFVMlVSaTB3M1lZ?=
 =?utf-8?B?Q2JnRGhjMWpDTVZRSTVNZ0dhZnJYb2hUVWhsWHp6aEtXVGUvUE5GL1ZUN21K?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5WWY70Sutct0W0tuu+3ZWtn1CXdaH5FhfkBb3ojkwac/p4dVhFDCds4I/1eQWdlfNBevgaFDfKF21JlcmRO+T4U77hmMWnDrnf4YP/Kq6jZg7laCwj2qDgRSgrmHwRqREW86MAfFxRomEJzW9ghJNzsX17lwon3Y+3gyaCv+J/GY3mvyUmpxGC6deIrWHObzu/YJ/Xbc105Pb0v3RbvnAB+psU+6AA3yWYezksXprDur1pv9DX59gsOXjGdgj6gUwn3N6DuDuBVqIitCPo7fmXC6464VNhSUeXOu9zn0Sf22C7h+EPrnQ05k1nkGoNMOlqlkbJmmHp6EXr2e+rNCfRq0+VGFQTcWayQvsC0eJeDCZ0xfgUhfA9a85TGmjHqAQKJil8nHrqF9o71X/oGGAHU7Cd/iOoPHovxHtduKAvLHCR9NU4twX8kf8/E1m8h05HvVEGM0bbF7pO3dwFmFAeVDhQRCXeffhnSXatnBmXO2aquIhP4RBdIxn4Y6KuHOp81V1biUHX54uFsrDSTYVw85ldqt6jUTx8T9baOntmONeFvfPS21WNiwvISTUhsfEGuOJwHQ3Yu67o8QWS/2HBHyZNiwt5TtXopFkhx47HY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f025327-86de-438d-313c-08dcf4d93cc4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 09:41:44.6893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7pc234XmP4c69ZMQbs14FZ1qfy2EaFEN1yieIDpXr5f1MdSubSIZt8gO67zojEATqXa1K8a/ouvvikmmpX3tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4742
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_06,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410250073
X-Proofpoint-GUID: Ep-jybW69tJmv4B2yH_1ypg39Zki2R6b
X-Proofpoint-ORIG-GUID: Ep-jybW69tJmv4B2yH_1ypg39Zki2R6b

On 25/10/2024 04:45, Ritesh Harjani (IBM) wrote:
> This patch adds base support for atomic writes via statx getattr.
> On bs < ps systems, we can create FS with say bs of 16k. That means
> both atomic write min and max unit can be set to 16k for supporting
> atomic writes.
> 
> Later patches adds support for bigalloc as well so that ext4 can also
> support doing atomic writes for bs = ps systems.
> 
> Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>   fs/ext4/ext4.h  |  7 ++++++-
>   fs/ext4/inode.c | 14 ++++++++++++++
>   fs/ext4/super.c | 32 ++++++++++++++++++++++++++++++++
>   3 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 44b0d418143c..a41e56c2c628 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1729,6 +1729,10 @@ struct ext4_sb_info {
>   	 */
>   	struct work_struct s_sb_upd_work;
>   
> +	/* Atomic write unit values */
> +	unsigned int fs_awu_min;
> +	unsigned int fs_awu_max;
> +
>   	/* Ext4 fast commit sub transaction ID */
>   	atomic_t s_fc_subtid;
>   
> @@ -1820,7 +1824,8 @@ static inline int ext4_valid_inum(struct super_block *sb, unsigned long ino)
>    */
>   enum {
>   	EXT4_MF_MNTDIR_SAMPLED,
> -	EXT4_MF_FC_INELIGIBLE	/* Fast commit ineligible */
> +	EXT4_MF_FC_INELIGIBLE,	/* Fast commit ineligible */
> +	EXT4_MF_ATOMIC_WRITE	/* Supports atomic write */

Does this flag really buy us much?

>   };
>   
>   static inline void ext4_set_mount_flag(struct super_block *sb, int bit)
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 54bdd4884fe6..897c028d5bc9 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5578,6 +5578,20 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
>   		}
>   	}
>   
> +	if (S_ISREG(inode->i_mode) && (request_mask & STATX_WRITE_ATOMIC)) {
> +		struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +		unsigned int awu_min, awu_max;
> +
> +		if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_ATOMIC_WRITE)) {

I'd use ext4_inode_can_atomicwrite() here, similar to what is done for xfs

> +			awu_min = sbi->fs_awu_min;
> +			awu_max = sbi->fs_awu_max;
> +		} else {
> +			awu_min = awu_max = 0;
> +		}
> +
> +		generic_fill_statx_atomic_writes(stat, awu_min, awu_max);
> +	}
> +
>   	flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
>   	if (flags & EXT4_APPEND_FL)
>   		stat->attributes |= STATX_ATTR_APPEND;
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 16a4ce704460..f5c075aff060 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4425,6 +4425,37 @@ static int ext4_handle_clustersize(struct super_block *sb)
>   	return 0;
>   }
>   
> +/*


