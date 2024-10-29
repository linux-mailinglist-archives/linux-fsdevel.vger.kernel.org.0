Return-Path: <linux-fsdevel+bounces-33105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 564FA9B4503
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 09:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB08B1F2373B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 08:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C533204031;
	Tue, 29 Oct 2024 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sr2H5eHV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jd80iYQA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D317F2022DE;
	Tue, 29 Oct 2024 08:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730192169; cv=fail; b=SB8D8235wvexHMk06LR4xbQISo9gNqhfDzD5OOTjyaxcFh8zUtmldYxCGeOnsCztMf7l3ntakUbCp7Pk7atIf0El4V3O5HZQFPgZRREduF8BOyQ3jzZk0BnPQHDr4QZd4HjVvHSrkN+7lga8hzlfc7Qh741CDTCbk+U/xXuVa3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730192169; c=relaxed/simple;
	bh=D/QEOh+zss4XtGKCYblY/FeSNJfShi8P37+hYRJfR3Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cg8P73nEi7N3ADowCW8y3s7se+qYJnd7RS+OY1uqQS5fGZTWKXf7s7DdxviiS9jx33PvbXPWxsiitigiGpGvKyy7ebocoqnpPyR6qs4sbOZbCqNa4EWhRcK//QU85WF6porLIxUQDAnofiv7vTejroDRv6lbN1gjSicclGARMeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sr2H5eHV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jd80iYQA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T7tc7i021025;
	Tue, 29 Oct 2024 08:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=c3Vu9Wb73SQoCOtHs6uIz1KhvPrT9sqX1Bqd14GCNXo=; b=
	Sr2H5eHVqVmVk2CXBzBYu0HWbi0KOcavnqzo7G7td7ijgFDol0UnAwPyxLchPM+G
	HGo4+tGSaxyV/v2055tgk9N1jkueBYqbTqamQ/fy1694IYEV82ABnaNIZSktqXk3
	HUGI+3S+DDBsFMmnqffYw5qcONUvFHzvefCv2mpwXTKv5Vrh8Pn0Z7Y5Dgq+1ZY6
	PGnpP5wDuP4ltFUGVU94ouLSuoZU65fpKKAzV+Jw+edDs1e2oToJ3y2pabXCazyc
	LH9tmX6dUk1XvwQhMVU+b08Jr/Lfeh3FsAi3k4XratGOWMA4sTwjBkH7DZ1Du0z5
	QrhYhJ7pbXSp+46BjkultQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grys4v7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 08:55:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49T6tmuP011746;
	Tue, 29 Oct 2024 08:55:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnac7emy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 08:55:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2UyWShAkc+YbvdSPk4aE9FKzYTVcsEFIX6VW4bzDelW/HCmXHfs6Wg3koB8N6F4pYAUIfdA4u3oTlTIffj2kukOEgEeWB0b9Nk2dwh5XkjMSLtaPEpgf/rhM0QnlqtevSDBT9pN/UZ75Vub1ayvNGvXsB67i12A/XhC5H6ewY+jBVA8g/4kVZ9mfnTq0BAmwGA56eX4iZBBM2Gs/juswS7eX1OmJf/OvM3wBZ93mhnPx3+wu8XRvxA++zOQxDkv99JdaERprabDIRQvRrgyaTvoe04yJexgiKbhHt4xHNg853ZC0oNE4r03LZcvk0472mQ0V9MTbHB2j7wGrrR0GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3Vu9Wb73SQoCOtHs6uIz1KhvPrT9sqX1Bqd14GCNXo=;
 b=mPHc3JIWVHlL+jPP/qDqSeVYFyalRxxZM6ONRN9W5LJorjfrgmYJdbgny9DGY8catSIW5KW1qksUHM56ZUvHckXhWc/+3N/ATVdgs+Et0QIrLorV1jYWSjKucTxo3xiL7ZZYB9jfrQ1K1b14boZrWzmqSAuW0zkWqek8KvVGS/Oxs2/sXQR5ocOwxXJvFa7/8j30fzlzwUEse6Xb63l7Cd9/TbAbx6n/gSo24oSGd4XZErpVhkZv8uc4VReNIZMWdAilg2MJ/dRyg7fN1jXp3UvjPsHz0rrLoN9gi/bbBC+TyuYNLJnhMJk0w2tID5sJErvelntDQQ14ofjjWC/D/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3Vu9Wb73SQoCOtHs6uIz1KhvPrT9sqX1Bqd14GCNXo=;
 b=jd80iYQAJkMNPT3pxlmlScBaVKOxbid1Gn1z0lUfSM9qBwIT/HRxTkHzYwA8qpNNCVALdpE985EEYKYn47Vl3iT61Qeoio9kDW8zTJu170Nzz8613z0660eD74YKHsDYPAw2Eup/7PtUkkyxxviBB0XGERqqXDxvWckpbzJqQDQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB5918.namprd10.prod.outlook.com (2603:10b6:8:ab::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.25; Tue, 29 Oct 2024 08:55:47 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 08:55:47 +0000
Message-ID: <6b840fc6-50d4-4e8f-abc6-370ae23639b6@oracle.com>
Date: Tue, 29 Oct 2024 08:55:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] ext4: Check for atomic writes support in write
 iter
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig
 <hch@infradead.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1729944406.git.ritesh.list@gmail.com>
 <78ce051e4a7e9a453a46720da76771c21691b162.1729944406.git.ritesh.list@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <78ce051e4a7e9a453a46720da76771c21691b162.1729944406.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P189CA0001.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: d08e8ddb-7a5c-4327-bc68-08dcf7f77af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3lDV1JBa0h0TzZ3OTRUbmhicElHcjgwRHhZemkya1ZJbWJ6YWRydWplRU9F?=
 =?utf-8?B?aFFJeG5lWVJETGMzSklQWE03WkxQTWlqdmtBc3QyN2h0WHUvMHA2bEpOeXAz?=
 =?utf-8?B?SGEvZk83b3V1YnZSaThONE9URTdMbVhqYXFWVDRheTRUTzJpdlk2VUhmVFY5?=
 =?utf-8?B?V2hxYkg3VkhoOHdVcURMUStEYklZZXpjSmZPSENWMkgzWkN2Wk1pQlh4S05S?=
 =?utf-8?B?cnNIOU9ISFBrVDNRSEJlM3hpSkI1eHI0YWphWUdaTDdwZ3NiaDlkNnNZdDFi?=
 =?utf-8?B?OTFjQW5XZVhjZkVBWFh5OWtQU3J4aUVFMitpYTcvSkV1WUg4VHNlR1A4N2dF?=
 =?utf-8?B?TnFhRWFvcDZmRCs1eW1semVIdlE4S1ZtcFFmRzZpVnRvZzVZcEVKK1cwaGI0?=
 =?utf-8?B?ZHBRZzBFdXFLN2c2aDdJSjB2V1Z3R21JaG9UcVpiQjVjTVZGQzNFalZmT0Uv?=
 =?utf-8?B?czNlSm1paHFuUVhWRzZBejU3NENmZXdJL25va2tDVlBGb2I5OVJZc1dkVDls?=
 =?utf-8?B?UWt5eHhQNHo3RnVFVGZVV2ZlakMwRkZVMTNWSEhtdlpoR3dUUktuL0k1OVBI?=
 =?utf-8?B?Y242V0ovQ1NrdXdkV1FaWk5LcGdybW5rKzJJOEtNWjR0NDlTZXVNOHlsOFRk?=
 =?utf-8?B?S3ByZmZFRG12anpZQUJyemZJT2lLb0VGRDVSckdLSUdaY0Jxd3I5aEE2TlRW?=
 =?utf-8?B?Q1ZBK1VnUlA5dEVyTXlYNWpWMVhvd3hNc25mbGlESnlDWS9kdWloNWJpVk9Z?=
 =?utf-8?B?VXpjZXQyaUZ6ajdzRk16ZWl4OSszWkVOdlg5aUZ3djlHYUR4a0szelNxMW9p?=
 =?utf-8?B?S3g3WjAwWG5nL05sRnBKZUM1dkVnd0pLaFBzbElmUVpKU0hmMis5c1pDUElB?=
 =?utf-8?B?RU5KK2Jvdlk5Rld3ckRmZWQvMTBaRG5BYXQ0djZsZ00zaHl1VFExTkdKeGpw?=
 =?utf-8?B?Y3dwYkpydkl3SjNtWUE5U0JkNGpqTlFXcEhQMW15VS9DNE01N3dVYUllNHUz?=
 =?utf-8?B?TUtoRit5cDg4ZlhaRFZzQThNV1Z6Vk1KMlpnbW5wZkI2djh1UWlMUEh3bVVW?=
 =?utf-8?B?ZUgvRjI1TkxNaExQOWNEd09LUjhHeXgwVDljRkxoVUkwaGMyK01BbENkYmFH?=
 =?utf-8?B?Y2dMRitabGtIT290MUxSc1BiTHozeUgrdGJWTnc0dG04amlKSENseURrS0g5?=
 =?utf-8?B?TGVMcDVSL0UvcmtTY3ZnTks5c3hkL2NZQUlXZStxTmh5dFN3ZS84UGdGT2J3?=
 =?utf-8?B?dVpLclA4bTRHLzlTb1FVVnJNNHl4dHk0QWVJZDVTNVpBRkxOS1I5OG5DUWJ1?=
 =?utf-8?B?Tm5YMHcwcFl3VHhZMUhuVUJob1JGTEszQTZYaHNPRDJNVVBtaWxvUzFON2Zx?=
 =?utf-8?B?aWM5YU1qSDNmaUJENmk1dEw5VTFXZDBndW5HUGtUWU5nVU8vOEVHRDBVajRZ?=
 =?utf-8?B?ZmxJLzJ1Q21rUlM1TWdxcXRVNW9CL3hRU3N4WTk4R1VWakxqUGVZNkxFWjlk?=
 =?utf-8?B?VGc0bGtRNzF6aFVTcWRnWW85UWI2bVZnWDRVRE1NdS9pT1hTT0ZjSnYwMXJw?=
 =?utf-8?B?Y05LS05IT1FhUTRUM0UrZEtjdG9oc200THJJR3dEYU5vRFZReVVsTG9QeG5H?=
 =?utf-8?B?VGFxRVV1MkQvcisxNEpURm9IQ3ZlTHd5YUlReXViUjBGTUVxZGwxdWlVOWE5?=
 =?utf-8?B?ZjdvdmhNN2JoUnJEcVhxa21OZGJ3VUR6RE0zdGdvTi9qNE1Cc0t3ZGdRMFZ5?=
 =?utf-8?Q?nTPdQt260v0xsFpFcOciUmbkufhuL8xT7COSd9w?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2wydkhiQWJWdi9xdGVQQ0g0TG9KaGFtQVc1S2h1ZmZLTExLdHh6aVVlYkl0?=
 =?utf-8?B?VmhGcTVsUWhTWVg1TFpJZG9SVWJZWnpyMTZzMGsvY2NnTDJoWW9ZWkdOdm5m?=
 =?utf-8?B?Z1p6VG05MGhQZ0gwd2V4d1Frc3FNek8ydzFSOXBYUUdySzF2S3VSNEFPWVpS?=
 =?utf-8?B?empOenoxZWcrNEZ1ZGNZWWVPVmF4WXJOTjd1c2xITXB2YUpJMEtOVGJZR3ho?=
 =?utf-8?B?UUhCNGtFMHpUc2FsV2JLR0ovQmk5OGRFMmlRdklmNW94Zmd5cWVvN1FTU21P?=
 =?utf-8?B?T3Y3WUJURGZZdi9PbjBsOGZ1Y05hYlgwSlh3T29oK2FCMXZudklRUWoxNkl6?=
 =?utf-8?B?ZDRtVU8vVEc4UFFaQzV3M3FNUmN4M1hRVHNUZnZyb3VQam9USXpscHNyRXFO?=
 =?utf-8?B?Q0MxU2c2R0JMOUxiNVErSUJtY2dibGgwSWxPMnozS0JpSGl1ZUVZR24vU2pW?=
 =?utf-8?B?TDVkV0J6N3EwU2Z1SXF4ZFlYTjl2TUgxNW83YkhQZFk4ZGVBWmJhazRkRTEr?=
 =?utf-8?B?RFVaRjZsU2JwMkRtenAzTUdzek1CMzVnMmlLYnpMbHZNK1d6RHJ1NjErdCtX?=
 =?utf-8?B?azFBcnNrVmtKeWhvYW14MlpycmRZSHVCMGJlVld1VGVCOFk4UzNMbGJrd1F6?=
 =?utf-8?B?dk56N28wMCtrc1c0anQrZlJtdUJzUFJocXVjWGI2OGtLTUh0aHIwT25rcTRj?=
 =?utf-8?B?cFI3Z1lHelpxWSs4b2dXV2ZiZUdQM1R6RmkzWUN6aWpGMUV2a1Vaak1yQlE2?=
 =?utf-8?B?QUJROE9lT1hDcXFURUtTdUNQTUc3dWtOTHNFT254T0prUngwNFBtVTh0aFJz?=
 =?utf-8?B?RkY4TFBSVFp3S1VUeWptV01aZnlBbC80TGIrWmJ2dVhlRWtxNDBaeXNwVGZG?=
 =?utf-8?B?aW5kZ1kxTnI2dE8yY2gxaUNZeS9mNUpLQ2ZyTHFPL2xpS1lnSUdRRWhwTWl1?=
 =?utf-8?B?QlVydkdKbUxNYXZsYmxjUnVNTzFMYnhnOVQ1Z2FZT0dINjdFMW5BY3ZqUDgr?=
 =?utf-8?B?RnloSXVMZUpVcEV0bzVUeFdnNmVZVHprcURsNS9QY2VkQUl1Q3dLWGZEL00v?=
 =?utf-8?B?bCs1V3lLSytUaTJpRDhWNnJmODdUNTVjSU0wMUdyM05jUlIwWmpVN3BCSWFI?=
 =?utf-8?B?NDNZNjdLOVViRGJCQkZodTNVMkFUMERIY1NZS3IrSGZLQXlUZDNEbWFqNmpJ?=
 =?utf-8?B?dmhUN0piN2M0NXdhSWZZQXR3N1BkOEtFbGlndld4bGxNTmVGTmJMbmZ1eFhv?=
 =?utf-8?B?VFAyVzFMdWhML2k0aHRTNTAwUzJzS05XSzAwVGR3NEx6WGhidGRlcWtFZ0px?=
 =?utf-8?B?bEdLc2c4RDlGZFBqK0dMMEYzY0hmK0swY0MzQXJzUVpoZUthaG53UVhTTXo4?=
 =?utf-8?B?Mk41R3BBZ3FzRERxMDV2MkpYdXhrU3NpRWtta09DaE84ZVlPNHFtNjc1YVVa?=
 =?utf-8?B?azVOR3Z4ZHRMS3J6NkNkY1JoNXJMOUpaa0JHMlJsSzNKdUttYXdlNG9RZEFt?=
 =?utf-8?B?WnE2TUh1T2VEUmM3TDA4R2lVUGtUcEQ3SzVvZHFzc2RkbFlIemFXZk91TWtX?=
 =?utf-8?B?RUh3NHdiL2JIcG05TW1NM0h3YWQvZFRSMVVLeG5PU1E5cU1XMExQY0FJdkd4?=
 =?utf-8?B?T1B2NVlxVTJNT295K0lnL08yRDg4MzREY0M3Mnk5L1JiNFoxc0crbE9KblFE?=
 =?utf-8?B?K2UwMHpqQ2o5ajkzaVpWM1Jldy82YzI3QVNSRWwzZlRzTDNOMmRaM3lUdDJR?=
 =?utf-8?B?QW9iZVJERVovcXpsdFFLdy9nSytLbWNwcS9mbjludzR5bU1NYnpIYXRDQ2hQ?=
 =?utf-8?B?UzBjb2trTU4yVnoyVzdENVlteFhvMnR5bmMxSzVuQmhUTmpxT1VQM3QxRG5P?=
 =?utf-8?B?ay8xRXdrcmxqak56dm1uNjNpNSsvUi9OSVdTUzVnR1loTVUzdzBTTWNZTzJm?=
 =?utf-8?B?TlhaS3dBamZsakJPaHdKeWM5dkpRS0J2bHBkRnhHNjhLbC8rdHFJaEJEMnZ5?=
 =?utf-8?B?STBoOGRYdlZqQVBqZHppY0l6UUtyUEZsT2pML1RxQlpWYWMva2E3dmtJKytO?=
 =?utf-8?B?ZHJncktFQW15ZGlYZUFVRVhHWUZUdzR5bk1zeVIzNUJvZElkVUI2Z3ZFODRQ?=
 =?utf-8?B?MUo0WldNRFFnMGtpL3ErOWFXb1pIZUFmMHVTeHkvc0p0blZxc2tSR3NHWnhr?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V+XIq6QDdx6twCjSaznxZ9o7YP1uQ4fn9I2ryeziYng0xQq6cqsJR7lKfJNk5teRc5rR4juQPraL4kE7+k3y2Zjbnk9k9BhEpddz9TWwbTHG30crp9Li7S2yUUYyKWmwQN0EDqTzvve8BcXo5XHLnq5tB7t/74IyC5IylqZCsIsz/nZQ07eir0E9aSTeZLUMP2t/KvuAyy9DxurQyFCVX+nBaJ3POM6NWhS0h/t/wFSYh5kUuUOoemBPKnTFUubdUVjnU3OacF2b557Q8kWcNmsRoC+3iA4GaUxDxZupNCZrCvrg/AqzYZ0Gad1DUEAGwV9NAXleRRKBFpyoKChhOW3j831iI/6WhFp4hbBaSZDQlfq/cEly6bscANYakw5+lZocGC3ZUgTACSy2dBEEWXaeoiLVXi6cnihHPZqJFa9hKKc8e0xaHGIjusEOL0Zp6X+u6amsiF0eusqhzS7vBgPg33uCPZw3AQVFmFn/IgynhIApSppconDAeCBTYAbfYnbcECNe3esmnhN9HTxg8eNPSGd1SDB58GSUx0OIKmErehq7j/kYRdOw20mxU24F2nHG9ul6q6H+AfPlGvJNZglWgCeRjSKi7FUQ0AMn4Ac=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08e8ddb-7a5c-4327-bc68-08dcf7f77af5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 08:55:47.3855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TmXZLwAVhXTb+A/MW/8Vcp12tRLF9t2CXmgFW9mypgfmxrQmpjbDSSrdB47m4+di3lbYj6MgqkTvB0ZBUM1chw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5918
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_04,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290069
X-Proofpoint-ORIG-GUID: _wWT6hVsg8l9nlKPocjQxSwHmd06_i6A
X-Proofpoint-GUID: _wWT6hVsg8l9nlKPocjQxSwHmd06_i6A

On 27/10/2024 18:17, Ritesh Harjani (IBM) wrote:
> Let's validate the given constraints for atomic write request.
> Otherwise it will fail with -EINVAL. Currently atomic write is only
> supported on DIO, so for buffered-io it will return -EOPNOTSUPP.
> 
> Signed-off-by: Ritesh Harjani (IBM)<ritesh.list@gmail.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>

