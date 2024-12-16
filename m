Return-Path: <linux-fsdevel+bounces-37476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD4E9F2C78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 09:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB641161C3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 08:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9D2202C2E;
	Mon, 16 Dec 2024 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gZzPZ3Z7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kRj3FHQI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5A3200BB3;
	Mon, 16 Dec 2024 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734339412; cv=fail; b=nY/NamqWBtKR0wJjEPhNNeqIg5Q/MCouCfV0E0Z/zEV8B/uCdE7r96vr6Uj6b9kJSY+mStG56Xa60aJStdwGakB/T3BjvWdK6coloWB/dBHL66stXl50KxWXCOpvu6ULYvHtBGIxchaQlDUE3XeDyDBxGaQEWWQ8Nhzpa9sVTjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734339412; c=relaxed/simple;
	bh=givLYfF2XyTHz0qUFkxNMjv7783VYu6AK0C4jHY+py4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=av4FVvfjbMycbt1nh+PpwTezTNHCB5mXIEcYaH8BcT806pN+HCHocvs6AovipmTykydpZSG8LQbEtqwthqiZSS6+egs4tRVT6C7bCx6lFNdRrO4aR9Mvu5NoFagQhEpnPxaYXEWBkIBS+dlBGFUP55ygX+nn9tZEGeJbPU8y+Ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gZzPZ3Z7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kRj3FHQI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG6b2kC025026;
	Mon, 16 Dec 2024 08:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8wqfWtdU8YtD7NoaDR4Ys6aZxIkdRghOReJdFbR4qXY=; b=
	gZzPZ3Z7ns54OncsM8CkzzKkhw1cXIe2xoxfXe1vhYvblVkN0OPPoZONZo7xD2fQ
	ttHYVhuvBsrUnzmew+9kYzletaGsIxg1MkT96Esk13e1LoKV9rx5bFgh5A4mwLPE
	DAmtZA8/wuq8Nt7StsR2EG5lw+RwVTkMKiDYirstgwqFQTUyI+cbOIBLaKXrpIr+
	du2qt1kkI9mNVWx+aGxCNE98v0uNTSJ+i15tjUJCGCYVrYFVTu5HEOZH4MWlCjM5
	tX9g/gTmhnqcKPkcUA2xkVxmnieJEFKY5aqu+Yxag3M7fR0bpBS5Mjh0yaVXQQyX
	LA9QL64qZ2lEE3Kki9U3jg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h2jt2p79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 08:55:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG7sEKO010890;
	Mon, 16 Dec 2024 08:55:57 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f6r62u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 08:55:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYY6anueOj6xzpdF9t99nE5UxwKlwpiGG67QPmlICVPevfitf0Pilz8qwQkKJ963iyBO/B5hgNZbs0icG5OQCjD0VW2UIoyDKzxCyt1GVR+E7DthdZqmnJ9bjq5Mq5ML0tKUjcxm/hhyVJss+Bf3oIbZaVTBebv+Xj6g3AqWVl2ojNYIT3wNYYbQd0x5ElFbs/r1TIHHwkawxlLpwTeGIU1AV+ZlP4+A16zz9W1nt3U3gBp2DMgBraHHdn2GP9aULvZOZs+Xsu2292IiTM/VYfUbtPB+K5yR5yE84NktIDXoDtkh0+hiGj2OPLSoveefgDBycLenz7Z1fS8whzCPrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wqfWtdU8YtD7NoaDR4Ys6aZxIkdRghOReJdFbR4qXY=;
 b=js/dVrI/ydOK75AeJ/XP7i/dJbQ2tLMQqJRb37EQGfLt31wGI1jRvMmp9/9U9ET2kGl30bCqEAOMYK6L80f7++e/f4R9f+6cwPJu/xkrIvLUEeIuC31aHaZffaYyl6GIYL3icbyDl98TtVk7nUeYZQlky70CJyi8AGvxBSN4bmBaS9vQVh30gXBydSyjcUWwywkxjiE84OM7fQNCkiRpMjF9zj6ALw8wdZfeReNNK/sVoA9031EnlIY/3q6CRIVq54gBsw90Sr4beKT9JkX0fpU6YbSaaswND+jyuJyR8qlaK/GWWyO4luB6orcUPLt2BL4b27fAuJfuX4ctKjVLnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wqfWtdU8YtD7NoaDR4Ys6aZxIkdRghOReJdFbR4qXY=;
 b=kRj3FHQIrib5bxdQF9FDDCFN/+YxBlz/8UzFqoSjalagCTxlvMdNuDZfGQVMe/oFgoJeAs0hk/vZmZtuWq1ImQAPpnQrZ0QZPyeGaxAbHq6Hm1ngBs9ukHXY9x1ktplQWEiIcQBBHDPCThv1dhfJJRNWhxKNl9IxXmU+E1Rnsho=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB7618.namprd10.prod.outlook.com (2603:10b6:a03:548::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 08:55:55 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 08:55:55 +0000
Message-ID: <9fadee49-b545-440e-b0c9-e552bec1f079@oracle.com>
Date: Mon, 16 Dec 2024 08:55:52 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 09/11] block/bdev: lift block size restrictions and use
 common definition
To: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org, hch@lst.de,
        hare@suse.de, dave@stgolabs.net, david@fromorbit.com,
        djwong@kernel.org
Cc: ritesh.list@gmail.com, kbusch@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
References: <20241214031050.1337920-1-mcgrof@kernel.org>
 <20241214031050.1337920-10-mcgrof@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241214031050.1337920-10-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0104.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: b6d2ddd2-3f18-44f6-63be-08dd1daf7369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGdRVy9JU2UyR2licGFWQTNzNFROSk82aXcvMC8rSDhEamdFUmpNMHprc0d5?=
 =?utf-8?B?OHZLOU5oV1VtbnhNWnpOYmhsdFM1UUhNK2M2TmpwWEZiNHM4amdMQ05adUN2?=
 =?utf-8?B?WTdjZDhqSVpJaTFFQkVoSXdJZDQ3dzFjWU9BdWFrS2JiUnNxMS82aXB1bm5i?=
 =?utf-8?B?dDJFRW82a0g3YVNDd3AzYkh6RGx0UUV2K1VvdHl3RndjMCs0OExpU1NyakRI?=
 =?utf-8?B?V3BPeEF5cStPeEpRQUcrT2p0ZEhBMFlNdUpaakNPSDNoZUN2UDBuZzFIS21n?=
 =?utf-8?B?YUtZeXFLOTd0WlVzYVVJVzJwa1Zqd09oSzc3MWoyajNWNXFNT2pxSkdnYnM3?=
 =?utf-8?B?NzAyaThRb29rQzFOek9jQ1ZBK21wcHpoQ2h1M1BBWUliTWV1TVdSeUFmSjU5?=
 =?utf-8?B?MjZCb2ZzVHlHVGVUV092dFRoY1JrQ1NJbWY1aE93elJxY1RsY3EwQmM2TTRC?=
 =?utf-8?B?TDVERDhQWERPZ3RPSmViditlTHZTRDFDL3JIdmhvWUMyTlpuRGJpbFR4US8v?=
 =?utf-8?B?ZkFvUjljZ2FWWEZtWi9uZ0NRZXpIdTBteDBPZWIvT2NER3lOckM3alY1aGV0?=
 =?utf-8?B?a2ROMXdtNllETHdSSHJwbURUOC82eGtpc3djZmp2UkRKdURtWDZ1ckJTRUNw?=
 =?utf-8?B?TkVSK2JIYTg0OC9tMHFkRi95Tjd2SjU0amtyNmdRS1p5a2xLZlJWT2pEUTZa?=
 =?utf-8?B?Skl1N3pFRTRBQklFbEN0Y3RJcGNxQXpleXkzQXQ4M1ByTjZmNFZSREZNWllE?=
 =?utf-8?B?am1PMjJEOXVJL04xZ2xNRU5EYlVQT1lxa3dCditVWXRhMkxEK0ZPMjlOSlJy?=
 =?utf-8?B?VEVXK1QyUGl6UEFCb3RtQkNUL0ZkZWFKQjhhNStMbDJxeG1nSzByMDU1cU11?=
 =?utf-8?B?S2tJOXpZTjJuZnp5eTJNWWJuLzVGd0ErMzFUclJDQmRndnZoYy9uODQ3aTIv?=
 =?utf-8?B?WjVYUFhIa0ZtUVNTVm0yOGRvckRZdFlIZTFYMTAvN2JCdTJ1am8vbHdKQWRP?=
 =?utf-8?B?RGVnWGgzY1gyWUp4SkUxa0E0TTczS3NoTkxKbExhMTZ5ZU1yQk4rQjVwdEFE?=
 =?utf-8?B?bnJXNWFCOWs1K3IvZTh3c0FHRGp6UjFEeUo0c01BZVpJYkxnTE8zWFZSQWxG?=
 =?utf-8?B?Z3pnT3hWZ1RPNzNUNFl3ZVpIUzd3Rm9FVk43RXBPeGdoVnJ3Ni9kS25FdWZk?=
 =?utf-8?B?REp1QlliYzRrUzI0OU91bW1DWU5WVkU3NC9ZVy9BNlljMytvSUQvL3ZFZWRG?=
 =?utf-8?B?czNybkV0dEpTeXRKYVlhV3NkMXdpa0YxelBJOEsrQ0EwcmFIb1U1RlR4TThB?=
 =?utf-8?B?QWRvQ0RXMW9seU9DTDl5ai8zQW9vVlQ2YU0wVWVxSlk0UGVRckZ0dHRzMmlH?=
 =?utf-8?B?a2U5L1dwRDlnQ1JEVnR2alZONWJadTkzS0tuQnp2RXpHSlRkZVVrREtmbVN4?=
 =?utf-8?B?YmpCcTh6NXFmY1FCZXVydWt1MDVyNjlIaWZLeDJMbldnT2wwMmlpWDFIM2Fo?=
 =?utf-8?B?NmVYSjRBb0JCemlSTXlVaFY5OE9xQk1ZcDZxSkZkLzA1U0dwV2Q2a2N2Nlkv?=
 =?utf-8?B?ZE1PSy84cE1HeXZiYW4wV2thZDVnay9reDhiK0NOcnVwSnhQcXpDUVhjTkhH?=
 =?utf-8?B?UE5QUVlUUkhjTUIvSmp1YUtZbkkxWjdJeFRXY3A1Y0dsaFlVSjRhMlE3U0M2?=
 =?utf-8?B?N0w0WGhwRHBiejBIc0Uvek1jMnhkUDd4ajlrc1RCMUJ3MEdJd1piaWd0NnhH?=
 =?utf-8?B?ZGROOUhXRGlXdXZGa2d2QnBNenlOcDFXK3hlN0NUT1N5aVdKNlBIRTJmSk0z?=
 =?utf-8?B?cndtejB5UnNha1VtYUVJbGl4azZKTlNPajRzVk1vNFNoQzVNa1lBQkdEVTNy?=
 =?utf-8?Q?wmrE300IF9auG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDN3RytRTGtoV2E0enZFNWZqQXl4QmZvNnZuVXZLeWpIRXZSQW5VTXcweG1t?=
 =?utf-8?B?aWF4ckx2VnhPaEhCcDRXTTdzUWFlMFVoMjl5SDJqMVZPZGw5WGZwb0dkWjJC?=
 =?utf-8?B?NDZsWGFtWndrOW9CejJjT0FrSFpYWTFCNnptZFRGbmFUV0FmT2hHWmh5OExM?=
 =?utf-8?B?aTMyUC9LZUNWUG5nVm9VSGVEZ29SMGN1UWQ1dS93WmVCSHoyN3hRMXl5Z093?=
 =?utf-8?B?L016YnlWVm10SE9ZMkNSSGxFT0RvNmdMU2ppUEpqWTJ3UGJiWDlmTzlTcnRD?=
 =?utf-8?B?elNwbGV2cUJkV1FUcXhnb0FnMzR0blhuZmdqYjJuTHR3bk1pQ3JkaHJRMFJx?=
 =?utf-8?B?S2d4ei9CbnEzeVVGUWQydjJndURzVjJyN2Z2WmE5L1UzbmxaOEwyQzZuNjQ5?=
 =?utf-8?B?aE9QbG4rVFlKdkUrU3hnakNlakk1WHF4MEZTRkxFamxoVkVOdXlDMHpvZGZL?=
 =?utf-8?B?MTFoRktpeU4yc3RoN3VlNnBieldmUmRpWldQUFd0WCtKMllOUWtuMDB0dTlF?=
 =?utf-8?B?Y0VHU0FoNktQb3J0S0NJUDFBTDZRL3RFZ3JUN3JPbGM2UTFLV1VSNGJrUk5u?=
 =?utf-8?B?ZUkvY0ZGZEFQVFE2UC9laGhZczM2TDJRdndEM0liNDYzWnY1d2RpTXBqdWNo?=
 =?utf-8?B?TmMxeDhkQjZvb0xhVEQ1TWdlNmZIKzhvMS9iWCs5SjRMWXV1TDIrdEtQRkYz?=
 =?utf-8?B?d0ZuYWMxRmpDV3kybFl2N3FxRCt2TGY1N2pTWUJCSExMZlU1eW9DdTRNQTQr?=
 =?utf-8?B?ck9TemE5dmE2OXUwVjFzbjRrcWtBWS8rRGRUVTZJd1Ztem5qS05WaWhBNm5N?=
 =?utf-8?B?QytlQktJRDRUNWJZRTNDR1JwVkx6cFBNRXZJdUtKMEhxaFBFaG9SYWJrVVJH?=
 =?utf-8?B?eitsZXVOQ1I5ZzYwTE9CbUxvK2pXZzVJaXNPQ0pMamNMR1Yxc2FtY3IzT0F5?=
 =?utf-8?B?TnppRlBZbWI5aDMxSm01M0l3bGExNFZrRXZ0OVZXV3I1YkRzdVkxaXpObDBo?=
 =?utf-8?B?RERiZjBJQjBMQTF1TXNsWWM3Zit5TS9ubEp1ZG81RWlGbEFna3F4ZEtjQ3JS?=
 =?utf-8?B?OHVRTzQreXVBK1g0U210bWdCQUI3bkZkWmpmUlBGQzcrcEFrWklEa3hKbHdI?=
 =?utf-8?B?RHRPSnI4dWVDSzNqd1k2MkRkVXpsbHB3RG0zNlRVbFArQ2NncUZSSHdpc3p3?=
 =?utf-8?B?TkVkNDZEVmd3WlVxVWJsSzFBRG8zUmRSb0Vabk1zeE9aT1B4c04vSWJ0NEFB?=
 =?utf-8?B?cTczZXF4QWJxSTQrbnNvaEkwa2ZRVkpNNWdpTXpJdTlJaUtuVHFBOE9ObE9k?=
 =?utf-8?B?YkpYTlBFK1VpMjFGOVoyQk03d0ZGbUllY1lHVEM2K0Y2WlJ6ZHoxYXN3RGRB?=
 =?utf-8?B?WEpYNDZZSlM3N2MrN0ZJTzdqNWpGTUpjaUdhbU1Hd2dWZGJHT1pwTmNtZ3hU?=
 =?utf-8?B?bHFnU3UrdzYyL1RmU3F5RDB5eXJmUDUwQXdaVmdET01LYU1LRC9WcldPWWk2?=
 =?utf-8?B?TXVwMVByWjdGbm9SemRDVE1xUkNYRlF6LzVFczZwRnUrUVI3Q0Q0amptWncr?=
 =?utf-8?B?MGFTRVVrN3pCSVhrV1BkRnhRcXljSklXdDNHeDZJSnp3VXBKUXJpbS9FM2tY?=
 =?utf-8?B?RmtmbjZWTGF2ZUZ1TW5Gc0kwZm9nRkZNOHQyYVZWYXBabVdiOEJMY0hxUkJY?=
 =?utf-8?B?c2IxT1QwQ1g3TGp2WXBFT09vRVFEenUvMk1wbEtRMlorSzA0bmtqaExia1lP?=
 =?utf-8?B?ZEhXRnY1NURXNEozdFhicHBuZnVFQXNwUmd3SklvTXc0elkyeVpINlpYUllx?=
 =?utf-8?B?Nk5lUlZVMkZuczZFVHRmZ2hpUXQ5bkg3Nmh2bEk3VmRiOHZoSnl1TVhYMGQz?=
 =?utf-8?B?ZVdCTWdZMlFUemRZaXhyTTI5VEFtU0dIS3RudlBrbWpBUWJaRndsUWhWZnh2?=
 =?utf-8?B?aVFQUWt4SFptTGdLSFRxZnI1YUVjT2UyeHRaVlc1aU1wM0JPSEVvRitTMjJp?=
 =?utf-8?B?d1FJSm9JNTRvQk5ZTmNEZnEvM0NrVlpTQXRRdnRrZGlwVWV6V3ZpeVN0a2h0?=
 =?utf-8?B?cllYcEJ6R3BDM0pJTGtrVWtkT1pXSnQvZ1J6UEtseUVKSnNoVnZPNEdhRE02?=
 =?utf-8?B?b1psdjM5VHZ3STljcUpxMUZaNCs5c2Q0VXNIcTJPdkxjWVhoaVg2dThxYlNi?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7TBeqOoBkkHz6LanB83xMAF3H0lH9vq5+gmQRZQDuSm31dwG64DHLWLul/j8luxb1YQPQaiSpf0S9nfgs2Zk8XR+WZr05MN7yh2wTVc/qRsUUfhhPaNn7b8pr1u0+TReRe8aTpcE/OgCwJJF9Fy/5YzbWdLjBA5108e8YWuyW8LuxRO247KPVO+aoTwYKMGvaSefRqpMs4MSBFuPFaDxvqduXNMaNBIiuAaGfI0iAmwdO7FXZ4LLxLmBvqNLj7sUWDKV+13zl5bAbB0ydA4zB0w3Ec+ivRPJrTmyb6+4jTPibbv+ywfWpUFC14T7jdfelzzhJ1aab4Yqnk5XXB5xveXnumGwK56ED+sbrMDCwVv+BXB2x4lMTUbpDeLkO3FKdcyyovKB+6PQ7M/djcxhVcLwP+L/kWr/JPx/lC5d/4vfnyzDGghsqRNbhqCkjEfeyLPA+AmBNFX42ttUtSn7z18n06DaPi3PwrUxfPrJM/qoCjOD98zUvmHRt7T1YAgawOPafwwfntaP2FmA3Ar3jVNeec41OrRMPxPvqyUavv0jMld+iNliN9cifkdn7Z9UcJ5gvqdXfXZkS95gb8GHAw85Lrg9PDjgVOlGdCRY968=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d2ddd2-3f18-44f6-63be-08dd1daf7369
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 08:55:55.1237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9v8fGUqmtiMvc8SP5MZU+EDlHBD6L/H1aL4NIP7xL9JVaJpbIaH4J626ErW5NE4bf1DEB53qcc667kDXholdPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7618
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_03,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160073
X-Proofpoint-GUID: 0Fu8lXJ8hYYkX2kFy35S1fRNbitNyo-T
X-Proofpoint-ORIG-GUID: 0Fu8lXJ8hYYkX2kFy35S1fRNbitNyo-T

On 14/12/2024 03:10, Luis Chamberlain wrote:
> index 167d82b46781..b57dc4bff81b 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -157,8 +157,7 @@ int set_blocksize(struct file *file, int size)
>   	struct inode *inode = file->f_mapping->host;
>   	struct block_device *bdev = I_BDEV(inode);
>   
> -	/* Size must be a power of two, and between 512 and PAGE_SIZE */
> -	if (size > PAGE_SIZE || size < 512 || !is_power_of_2(size))
> +	if (blk_validate_block_size(size))
>   		return -EINVAL;

I suppose that this can be sent as a separate patch to be merged now.

