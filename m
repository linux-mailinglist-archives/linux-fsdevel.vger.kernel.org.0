Return-Path: <linux-fsdevel+bounces-29967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 198DB984292
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 11:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D8131F21743
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 09:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608DE156C69;
	Tue, 24 Sep 2024 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mWnnht+m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J36VOpFG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4421335A5;
	Tue, 24 Sep 2024 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727171320; cv=fail; b=HqPE6gnoOAfcT7s4SmiyEnJsKJPoIbtMck+L0hE3euvdHNQwTbow8+B8r5B0CaA91yIywxTcgoGqSfos8D2USBPX0yIXBMZv7L26qSCOinQvvP4dY74bukd+PiyW7reT81swT+1YnwIw4RSllWgH2FqZA2YQQsf/Sk8uTrXlbSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727171320; c=relaxed/simple;
	bh=W9hNSWwIfFPAnmslVZVbYwrRO+jOnvA8WFu86EeFmOk=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s5AQn4jv7O5RHwVEpuwBaPmLk3v2XYLq09SBAAWPmYBiwWWmhjAPgyCL6XpCHqRnmkIlyQQk/FBqxgJyltCowcI5CYtFel3eY62Ut+C4oK0e5e66VQZhAfrG9BE1K1yxaQsTqb/ZRO3d7dg6R8SJntjDFW/F/s32qlKi0miAprg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mWnnht+m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J36VOpFG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O1MrfL029521;
	Tue, 24 Sep 2024 09:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:from:subject:to:cc:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=7j2ZDypIM/ZakafI7CGmaglFPrXHGqoGVY3uQxxAFd4=; b=
	mWnnht+m01jZ4bqNx1W9dgQMUxHu5ZsDE++uTsuObcUZCZpqO0Cx6mnRt1r75/zv
	od3qFBh2TYNHm2zQ0c7ySL4m6pJIc2Hs06VRylcXf8MPfsAty4sPaOawrpK2dPax
	pIgnP8h2kXaeZSwUi4XO8XAxWJGdEtmxt24JhFF6qNWyppZY+3Tzy51qMxHE+vEX
	K4+BQpd/tZ3QBMvTu5rX8hqMjNMX78jVffICrb03hQzXEEktNjlHtKCqUTZkuhfN
	0Zm/xkl/Y3ef9NaJAG3q7gKPjwq8gKFDACzOyZQxsADnB5bMLm3CZj79fD/muZ+V
	Lc3vCp0MdkuVoAi+poEZrQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sp1aex0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 09:48:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48O9Qo2R001125;
	Tue, 24 Sep 2024 09:48:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smk8q06w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 09:48:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMWHmUDqUV4ZZXw+kNs3Y59p0B9N63HJ5ShCCAqaB+SyU9tNs7nAycNZG6z3XpVyoHQQIGVlBpLnRfeNfkGyUod1sTUs0iQW9wenHr2YZhg8NnZ0LtRcl2XGgFvDJ9i1mGMTd8iVx8wrvt89+cT8hk2R4mA3WfMljxfFw4wcpO3p0aUdnrIV6/5tApBguqkmJ61mKmXRWomK/mWkN/GsnDxMuKPx1qfRMiCnVktqTBuFAJtFC9kca/io7UqHl4kmvtICX/58mqiZ3DpHoBAVY4a6DKJB8DsfvlxgxpbaWyWF/AQHaCee2pRFnOqU682iktXAxw+HR6l/YfgbuXWd5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7j2ZDypIM/ZakafI7CGmaglFPrXHGqoGVY3uQxxAFd4=;
 b=R/I1vna7kfn7wIp0AClEua/XIwH5N2cTv4mMQBUUbFgpvDlP3+oWm4yIIs56nYUsP85qQOzuGsK+xSHbItK4DHhrAZYHTHhqJfG1qVdeSvJb36D9ZIQytVxql6DM0tP+iscpBZbnUIpYSCMhecKNZhThJpvm+tI8aIoQYugrrnJ//jSItiwFCNbCht5aEoFjzgVJqFx2IKmNqEdWoNKGK1BqtN1ewodmtSa7yKfiwy9pIScraAjXDZMCgiMIrmFFfqR1OEb19qkiyJd6lniFFbCnt6BethczD0CPb3Jmo9Lc2CY7tPxsS4hAwmYqAP061Ag3LDXDlOGhLkbYFu3Ssg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7j2ZDypIM/ZakafI7CGmaglFPrXHGqoGVY3uQxxAFd4=;
 b=J36VOpFGZ2taoABOGFSl/NpUUDwLtGHQyYnYZPGlGEUgPGQGMdWJxQOb0+g2svDpTJHuFSfAMca+U2M2BFvWc2v/4EtEG+vu4ioHpd+O93Z0/5HbZCEOrgItov30YEWZxIx9XAplYPbL//ft194KvrbMcZ23o1wnLdCZBPtEWQo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV3PR10MB7982.namprd10.prod.outlook.com (2603:10b6:408:21a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.9; Tue, 24 Sep
 2024 09:48:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8005.010; Tue, 24 Sep 2024
 09:48:08 +0000
Message-ID: <a099f4fd-bde8-4a0c-b1d8-d302895374ff@oracle.com>
Date: Tue, 24 Sep 2024 10:48:02 +0100
User-Agent: Mozilla Thunderbird
From: John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v4 00/14] forcealign for xfs
To: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>,
        Ritesh Harjani
 <ritesh.list@gmail.com>, chandan.babu@oracle.com,
        djwong@kernel.org, dchinner@redhat.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        catherine.hoang@oracle.com, martin.petersen@oracle.com
References: <8734m7henr.fsf@gmail.com> <ZufYRolfyUqEOS1c@dread.disaster.area>
 <c8a9dba5-7d02-4aa2-a01f-dd7f53b24938@oracle.com>
 <Zun+yci6CeiuNS2o@dread.disaster.area>
 <8e13fa74-f8f7-49d3-b640-0daf50da5acb@oracle.com>
 <ZvDZHC1NJWlOR6Uf@dread.disaster.area> <20240923033305.GA30200@lst.de>
 <cfdbb625-90b8-45d1-838b-bf5b670f49f1@oracle.com>
 <20240923120715.GA13585@lst.de>
 <c702379b-3f37-448d-ac28-ec1e248a6c65@oracle.com>
 <20240924061719.GA11211@lst.de>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <20240924061719.GA11211@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0618.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV3PR10MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: ddd76d5e-8188-4b7c-e4f1-08dcdc7dfe69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGVjSjdWa2xVRTN6Q1UyeE1qUVhIZ0hrS21HTWNOT2xTNXJ6aU03aG1ra1Bn?=
 =?utf-8?B?enF3U2ROUFhkRTJWUFVjMHlHT1dLOUJ0ZUpuM054SEdvRkVPOXhITU9ib3JQ?=
 =?utf-8?B?Y2tBOHc2Uk54cE1UM0JZWHpJK0k2aDlkc1VZUEdlTVVHeWs3U0haUGJrVWth?=
 =?utf-8?B?R3hsb2prQk9uWUI1Y0E3bkI1VnRDcEx2MXlwRjZZbCtWVk9QM0lrdWIrQ3dp?=
 =?utf-8?B?aUoxWDJNZEd6bmZXWGxkNGN6MGJjL1RNTC9rOXFRSzdBTHhDSVhLdzM2d1ZT?=
 =?utf-8?B?SlF6UFl5K1BSSjJXdkE2RXc1TG9ncklJbjlNWFlXY3F0TlVMc0lvME13TkNR?=
 =?utf-8?B?QWtlTmRpVkVmWjFIY1ZzWXlNVzNzaHBBZ2tEUnl3Z0EwTjlDYTY3K0lPSVlk?=
 =?utf-8?B?cVY2UWtVanF1NE9BWUdXYzVhQlpXN01wQW93RjJNU3RnSFhJdks5N0FjR1Vq?=
 =?utf-8?B?dWo4MXhIRlUzRzJDRUFxck11eVdEcWFISFJybWI1Y1VMQTJ4cUZxSVZQRGF0?=
 =?utf-8?B?R0w1Wlk0QXVmWEpJeHpwNkZudFZ0Z1RGdkNXcUpJeWUzVmRVYllSQzZFbExL?=
 =?utf-8?B?MGhQaCtDTGxUcDJZYXVBZ1FGaEZMaStScERENXR0SnJvQ3NNd1NwUVc1c2hZ?=
 =?utf-8?B?bFdTc0preU1nZXpKekp0WDNVOUdQcTNYMWY0TnN0SU9qczQ2V1haWjB3OHN4?=
 =?utf-8?B?dHZNQ1NQZ0s0aERXNEZlc0R6RjZ3ZXVnWmczclFFcWt4amhEMXRoUXBwTnVk?=
 =?utf-8?B?ekEreWZmdlRuK296Mm95MjEwcGVwR1ByWFpMQlFKaXp5ZUVQTFZPNytzeXhM?=
 =?utf-8?B?WHlRMDF0V1ZHclN3YjNTMWFKTWVucFlka3lJbkZpWWRCUWVLc21KWmUvUE41?=
 =?utf-8?B?a2hHVDl2OEtyVGpibDNZellQVEJxeEVIUlFOaldmZjlCQmZxa01aTG4zQVdx?=
 =?utf-8?B?Zk1QbG11Ry9lamRMRW9zYzM5R20va0YvRExJbWdMRVAranNoTnluNXdweHI5?=
 =?utf-8?B?aEtpMFJjRGM0cjRxak9heDNVTzBaSVpBd203ZWZMdlBVajVZU1JOYlk1ZUxM?=
 =?utf-8?B?VnpPcUNZVU1aLzNUNzVWdXgwZ0t2cHo4dTU2bzl3QU1wZFRjM3pIVW5xNnBY?=
 =?utf-8?B?akNMT0czTW5BQTV4b25MclhnWi9hVVlFU3plWnB1dUVsa0wzYzVrQ0gzWktw?=
 =?utf-8?B?Ukx0Q3ZyZ0NSS2RHQVVBN2V0S21XUEpXT1VOSFczbXVwUzh0RWt6NUJELzNq?=
 =?utf-8?B?WWU2UDJPVElQVDVKSmpyWXhiNG4zQmdpMi9qVTFscU1XWTFNUnA5aWg3TlYr?=
 =?utf-8?B?RzRQaUV4TUtVWC9vMUpCbnpNWkNMMmJGKytSREh3Q2JFT0R0cHNiR1BIKzJy?=
 =?utf-8?B?bGROZEx2cXd6eHpadnhWYnk3bkZOWWNDRy8yQ05TVnEyaFBhT2MvYWhid2xm?=
 =?utf-8?B?VkZaVXJpcVQwSmJNR05kSG1jQ3VYNGlrOW1QUlBQTyszSkxxM0RlVXAwZG1o?=
 =?utf-8?B?YzBibE01WjdLUXVPZ3N5QnQxdmt1bjZtQWczeFlTWlNNUktCMFdodytKaWVH?=
 =?utf-8?B?U3orUTBTSFZkc0k2bkZTN1BxMGFQSXNleFRmZUtZMmpQT2hXc3lsY1ZqbTgr?=
 =?utf-8?B?RStUNDlqbG1ITWFIR0U0cnZndkJUcXJaaUNBYzVYS3lDWEphaGwyanhncXVN?=
 =?utf-8?B?UHoyam50d3hoRmRNUDJPdUhoT3dJVHd0blNQSEVxK0dKVjMzaGUrL0N3cW1n?=
 =?utf-8?B?OVhKSWJwRjkrR0ZwN1lXaThLajFnM2U3N0xBNXAvbFpmYzFraDRsZGk1UkpL?=
 =?utf-8?B?d0FoSFltWnJwTjV0RnlaQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0hhcUNCcDlCSXRJZXRPK2VkTFk5dE5uczBaaGZqM2JwVnVZSXNSMFo4bkZT?=
 =?utf-8?B?bXZDcUZhNDFSNTRUMVRjbEVCZDl6RjJCUHpOUVJoRVdZamVSbURQL0RZNkJx?=
 =?utf-8?B?TXRaNjFzYVE3YWdvcGtOVk91L2NrZXcxQ21naXM4MjlFd2MxWEd2Y0w0RUc3?=
 =?utf-8?B?TXMzM0c5aXdaY01FY3hyYkJMSmFLOFBqRzF4OUp0SnRZQmY1U29JTEJmSy9X?=
 =?utf-8?B?Wk1PcWsxUWU5Q0FJN2crOW42VnRXczgrK1hGcDlCLy9vVlp0bnpIL2pMM0c1?=
 =?utf-8?B?VFBRY1VnalBwME4xSTVzRFRhYUVUKzJqbEhKc1ZTRVkzYk9KOXRFTkpMak9T?=
 =?utf-8?B?WmhqY1dqalpzakdXVTg1V3JHR2QzV2tLVmc0MDBCaysrZXFuNkh1MkdWZjZp?=
 =?utf-8?B?Rys3OFVkb2dpRmlyUjBLc3dzbEx5dk0zRGdNMjB3SGRHSEJHL2Q4ME84MlZz?=
 =?utf-8?B?STNpWDVXejdnNlY3YjVORVFTL21JK3dEMTVCME1JRUhxU3RGWVJqTVBUMlR2?=
 =?utf-8?B?MDhkTXMzODRCVnNPSXQ0b3FIYi91emhLSnM2VnBDenZuRFNDd2k2WW9EME5p?=
 =?utf-8?B?eWdBZlB4L1hVRTBKM1FYV3dMaWV6R1B6Y01WMTNpZ1cwWmJVS0JHbjFDUHVP?=
 =?utf-8?B?QmxKMk9sUHpCREFBRnZNRzg0aGJxYWhlcS9HUXhNTTVpRzRvV3UxWFZvU2R6?=
 =?utf-8?B?dE5TanI4RlQwUkVIRkF6RXgxeHpUTjdPUnpseVc3M242ZUFNa25QbHYvM1Rz?=
 =?utf-8?B?ZXJYMGIyMWlYN1hCaHpDaU5NTW54WS82b09lUVFycmYyWUlYaHRFQmI0Snhy?=
 =?utf-8?B?aDY4OVFrUUdHL3lCRS9JenZQL3hHcnNBK2MrUzRhb3liSytsZGc0cUgxTGVw?=
 =?utf-8?B?NExIQmJiNUIwMER4SzZIc3BZK0FINFNYc3ZEMkhrbjdSc2c4Um1MaXFVdHVJ?=
 =?utf-8?B?ZC9oVURqN0tBc09SQk4za0toeXVPdUE1ZXcyUFdlTW82NHB1Wk4wMEFXWHZO?=
 =?utf-8?B?eUxZWlFuQ0Nid1V4eEQzb3g2Tnd5REVvM2dKMmd4cVJ1ZHJsa3RYSFMwcnV4?=
 =?utf-8?B?cG1iUDN6L3hXUEpqOFFERGlUMkI4SnIxUy8xSk1TOEZ1RndsVGh3bkZmTS9i?=
 =?utf-8?B?RkplY1RJd29KQ3JKeXpzNlpDcjUwRzBNVzhxbXEvOWRuam9UV3UzK1phVVU4?=
 =?utf-8?B?QkRQNHl2Q1hTdTVsWm9pNkJGTlpuUTdoay95ak1nd1JFVjkwOGZWTVpPVWhD?=
 =?utf-8?B?a3VvQWFMVk1jT29LU1hLOXljL1M1TllmYmFsWGFWUlcxTkVYQ2NDWnpvOFRH?=
 =?utf-8?B?Q2x6eWttbGtGNjhNMGgyYkR3M0JRa05lYXJHOFUvQk5QRFVzaXBXUUpmTEhs?=
 =?utf-8?B?RGRPSmpHTGlHRHRQdXpIU2Y3czRnTDVST0c5OElMR0xQRW1HSUh4aENVK3Ft?=
 =?utf-8?B?Q0JscGNnditWaWhKOXAzMnFINnJVdHQwd3hjelh3TGVzM1RtZnFFZVFhRXZL?=
 =?utf-8?B?SGhaZWtObVV5S0k4SVc4OEhYQ040UkEzZjFLTENqVFZaZnRicHhJVDE5Qm5K?=
 =?utf-8?B?dGVpTytxd0NJeXo4N2g5TnFZNzU2aWtENmdpZ3pZNGxLY2NIS2t1MEE0RTgv?=
 =?utf-8?B?cStLNDBSZWE4QkIvQWxQVU9pSkczWW1ydHM3YnJQUXpGVDQ4am9HLzl5SkpK?=
 =?utf-8?B?K0ZSdUY4alI1a3RscVBiNHRQbFpocEtIQUE3a05LM3I3Ukttdll1TDVmSjFQ?=
 =?utf-8?B?SHQxSFpzcFlNMTFCMTJOR2k4bktSWFJIQ1lBbVg3ajYzQW91RnNnelFvbjJt?=
 =?utf-8?B?TzFGMUVQQ3hBVnJCRGtmcDZ3b1VXR3VmUi9VMWFjYzhDa3BSQVY4YkgrcTBI?=
 =?utf-8?B?K1JrdXNpMWFwV3FNTXhhdDdZMkovcXh1NDdDcTVBY0QxZWpLNXB1VjZTOWVs?=
 =?utf-8?B?S1NYSUdlUmJBYUY4N0dabnhRaWkydWlNZld6VC9tOXd5dkExOEp3TkphM3lT?=
 =?utf-8?B?aFV5Mm9VZlhCMDA5ajMxK09aVUtqMHk0ZEZUdkRPQkdKME1NdER5SXVKM0NG?=
 =?utf-8?B?OUkrNHE3RXMrT2xjLzJ6NmpkdzBNMVVMcFFrOUpnV0pqa1JNcmdJd3p3WmYy?=
 =?utf-8?Q?vvCq5Pw0h12l/bhJeyPui34tM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N3v+yk/G7NCMTrf1nKYxRvrIWAkrYpcI8iD9PSxhGUwzuEW8a0fFdvUecDY68aneivHVETIipfeOpzFbhNQQrIf0l8ko5/Ie1aMqTDk8YcEjrpesRK++i75absYDzU6P1kHkVHNxlz8ljZHb5HiXJFQnbmHkqaRLwig7giQklqbXPG50Gu29cnehwdm5DYX2Y3gnzhgkal2yLa0bLVJotecQhFMI6FWxM0CZUaLEb70NKnCC1lTijEV4ueAa0PpaIXBWdfHPfQV8AJ5iYvRGKDGNo7LXe+Q0dYjiV4CfAuQ4/YE0wd8W5/5KITXbFl2Fhj4qoKcyHBcq1u/JJDR4wqE/o6K9Y80tXDbhwCiGOSRds5XfyPYNYoesvZVVexT9QYgfpqzgijJd6p3WOYFoq2IGRj2TKWiQoWiyJhqXH8Wa+nnTUsTUDkSUwFIFzmogkwG8r76jN0EKOrnoLwQJKLDNJXuOE9KBN86MM/j22A9M9CUO1+UVwv5jmS9eyVZ/GLNCS9uT2aZ2FNQ4P0cC1QpVsrlsrKaopArE5QO0IkJTnjQGBSBCQt7k91Id1Irf1FlI4nA9uDG/7+b5+bIDvbF4TvIThYzZfbhVwK3qGqs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd76d5e-8188-4b7c-e4f1-08dcdc7dfe69
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 09:48:07.9171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1WJ0gG038m/0DXuBmwZ4jGilsIegqslQZDmhZApXLiU1lh9jWF6cG7aK43fnSz1Ftz1FoAUVSmYI2e5iWoESw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409240068
X-Proofpoint-ORIG-GUID: JUGt_nHi0xcJMrnPAj7BZDRLGfEm791m
X-Proofpoint-GUID: JUGt_nHi0xcJMrnPAj7BZDRLGfEm791m

On 24/09/2024 07:17, Christoph Hellwig wrote:
> On Mon, Sep 23, 2024 at 01:33:12PM +0100, John Garry wrote:
>>> As a first step by not making it worse, and that not only means not
>>> spreading the rtextent stuff further,
>>
>> I assume that refactoring rtextent into "big alloc unit" is spreading
>> (rtextent stuff), right? If so, what other solution? CoW?
> 
> Well, if you look at the force align series you'd agree that it
> spreads the thing out into the btree allocator.  Or do I misread it?

Yes, there are more changes than just refactoring "big alloc unit" 
stuff. There are btree allocator changes.

About those btree allocator changes, strictly speaking there are just a 
couple of changes to provide forcealign support - the rest are prep 
patches. And those forcealign changes build on pre-existing allocator 
features, like extent alignment and length specifiers.

> 
>>
>>> but more importantly not introducing
>>> additional complexities by requiring to be able to write over the
>>> written/unwritten boundaries created by either rtextentsize > 1 or
>>> the forcealign stuff if you actually want atomic writes.
>>
>> The very original solution required a single mapping and in written state
>> for atomic writes. Reverting to that would save a lot of hassle in the
>> kernel. It just means that the user needs to manually pre-zero.
> 
> What atomic I/O sizes do your users require?  Would they fit into
> a large sector size now supported by XFS (i.e. 32k for now).
> 

It could be used, but then we have 16KB filesystem block size, which 
some just may not want. And we just don't want 16KB sector size, but I 
don't think that we require that if we use RWF_ATOMIC.

