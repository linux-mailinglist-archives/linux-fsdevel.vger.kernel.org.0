Return-Path: <linux-fsdevel+bounces-23542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A59C392E0A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 09:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A307281B09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 07:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7E613B597;
	Thu, 11 Jul 2024 07:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dELr5kQa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wN6rCSVn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07116770E6;
	Thu, 11 Jul 2024 07:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720682269; cv=fail; b=tVha15lQhzixAnQVWzcsiNx76P5sISY96LYhx42z94r2awur7Y+rwpYq26pGeanZPixM5/ryAz8U4zBD6mBNUFqG/555Ik2o/pyLMXPlxhVX0e5DhdvQCJlUgwivi0mcAqZPdJqkydHnblDJKqY9CyYwv1dn1Az0jYuea5CWyzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720682269; c=relaxed/simple;
	bh=VXXHT+95fk++2pRGpaUAm6HXyxa3LdvD4xCkEVG3o6c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qondeFNkAL6SZZ7tjJlAUp4mCKVOptPwAtZU5mzdMV2QLYVc/8QloQfQeYecOlIz6FR4QwxKPxcpBa9MHbAunq+TFprS/3iirG4vlROa90dk9O5sxcM6LaX/2qjhFjX6Ln+kBrdSCJd5IG6YyDobFusLB9GMX/kqIOvFNODe3v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dELr5kQa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wN6rCSVn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B18lfA012654;
	Thu, 11 Jul 2024 07:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=2kasd6Lwz7lV6Fa/6e+cRoSxKY5fCrS+jkNogWLZsDs=; b=
	dELr5kQa7OvseX5PK4WG3wMu97hQ/+HzHxP7b2Dgx4VsxHTFMQCDC3/kU8rfytSf
	EA5l2OaIzV85HTu2zAI+ej2yepNu7qqk6bRTP1xG2iMA+m8sVsBmaFY+L4//da4U
	MDGfj+qiWxMhITU3Xcjcvzz7DMsTe+clp+kEcXnnfto566T9uXTmW6kGX/B/zRHA
	C8MAzPy3TWTX2Cj4o5Mqq5Phh4fH/kC8XKzcv3zkIov3j9J6XEafSzpYapMRmdI5
	/EYgVJ1KdcsSS/M1ht6/uXMoZhIObIFLogZ5ofETIhGuwMNF5tYvtgclykzq5sNq
	kCB9a8C/48U1I2PHiRMeSg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkcgvt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 07:17:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46B7ApQr022064;
	Thu, 11 Jul 2024 07:17:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv23kee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 07:17:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMV2ENEk6O2n2TuHswJIcjKGGJt6jI+w1pAZ2l7Kv7CAQDWYYcwpBmewUeeNki56WuK6YmLTw/hfjW3dPXkOVktzgACjju+dEwc70i18SSES9Pp80QPBdb32/8ezJRM3VyeTOZvasBjx7qHgYFeEVKVNrq84O6uk9lixX+dXdlaP5kLIFYi5ZCqWHXh/aFU6jEYu5pe0ccGe/vL9O1WNEcnn6fvVBJiGlp+x8Y/UiSB6n/9X0l91nNhKliXecDUJVg15SvRGFFmhgIpYTttgYhitZbaaDQSvN+Q0ctwzB9cWHLXhUSTuqS3smCkNh5l4XzJs9G80MnWssjfdL5+PZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kasd6Lwz7lV6Fa/6e+cRoSxKY5fCrS+jkNogWLZsDs=;
 b=ldC6xkpSGDreWBVANL+hsNuXXA6/iLbVzueOkSsn2HyPRbTRKVM+g1zWRarbsH3cQg37C5wHK3DybbCA6mXNYhmQDFHb/32IHH9MY1zWWRZnq76RyFTsVIJKQi3mgMOuR3Dl4WEgEzH+kKt8eerXphjvmyJBOwV2ndeLcXpe+XlWlLgFMuuz0YCUZgP6sPfKLK491FoAp5+WdznN4H1tRqm89dnPtgWnho8ugKCUDllcxIHozaWFSte4tSIBEKjhMJn8ExU4509tY2LinmnRJpUUscEX5I7nW3yZ5B3rPpIVZULp6uKobZsPMhbBxLBqffdEDMmUfbjcGUMPdZAZQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kasd6Lwz7lV6Fa/6e+cRoSxKY5fCrS+jkNogWLZsDs=;
 b=wN6rCSVn0li+0fg5J44mIwUfBzpXlpNvFfNIoA5CMRHK2pJrQ8O17jCz/9KEKGCpIqrv0EKHO8lwYMlOKPiy5MWtGQRwnI+c3sRx4I3w3T9QkBmw61yTsMBkhFBabpjH7hc+liNgywb+MuJ1XoZ+9XpPETicwvvBlgCShJbkpzQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4864.namprd10.prod.outlook.com (2603:10b6:5:3a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21; Thu, 11 Jul
 2024 07:17:31 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 07:17:31 +0000
Message-ID: <d4474c49-1000-4553-bd21-c0a9ad41bba4@oracle.com>
Date: Thu, 11 Jul 2024 08:17:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] xfs: Introduce FORCEALIGN inode flag
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
 <20240705162450.3481169-8-john.g.garry@oracle.com>
 <20240711025958.GJ612460@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240711025958.GJ612460@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0170.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4864:EE_
X-MS-Office365-Filtering-Correlation-Id: 50204919-3736-45e8-008e-08dca179874f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QVpxdVU0TzdUWlRkLzhNcHIxekRIQVFSK2E2a24veXlqbzR3OWp2UWRaNzNL?=
 =?utf-8?B?MjNEL21xVVNBV2dsLzMwSkNaR0NOTnVKaW85bFYxNUFNWXc2dlB5YURGWi9K?=
 =?utf-8?B?TGVYNUgyeGNydVFvaE5zWmFpVW5zN2VzNTVKQ2NNYUlvQzB5eWNOYndmUC83?=
 =?utf-8?B?MmFTbENOa0FEaEZNdzdLVlp1c1A2OXlOWkZxTVI1Qyt3OUZVYVNYemVGWXc1?=
 =?utf-8?B?dzJiZElMZk1DV3c5OTRQMTVVYzNUbGFQWkIwcHFlNm1KZXk2N1RhWWpnbnFI?=
 =?utf-8?B?WU9BSit6RmgwTUY0SEZsRVVsQzh6RmQzc2lNT25FakcrZzRCRTM2V2NOV3Nv?=
 =?utf-8?B?VStDa2hpdFNteVBXczF4clp0R1p1aUJxY01TYlV3OHRjOENDUGRseTBoMXdT?=
 =?utf-8?B?WjhtSmpLVGdFQlo4dGlUZEg0QnMwNXg1N2NpQzBkcDE1YkZHcG93Zk0zalFv?=
 =?utf-8?B?anBjeG5QZExnVjlRZHJrWm9EcWR3YXAwbFg5TVJSMHpPZkxPMG5MU2NNZnVZ?=
 =?utf-8?B?QVZSMUsxZEhwaytiZjIvekIzODJnR1RhS28rMVRDN3VYYVd4ek9GQ3c0KzRG?=
 =?utf-8?B?d0t0ZjVjM0RHNHBENVJHUmpMK2VrdEtUUEJwSjlIVjBMQ2hGbGN3Tkp6aGRX?=
 =?utf-8?B?MEU5WWkvaG41QjB2WXUvczJvdFFjQW9UUzdqQU1QM2xiSnVDeTJNdXl4Vngw?=
 =?utf-8?B?SjdsbkhGaExwc09oUFIzL201L0NHNVlZRU8zZFNMeHlQM2IwNGlmQlNrS3hC?=
 =?utf-8?B?dGJtVE9LckRKamtacDdPZXNoUVdUdU05MlRwZU54dEt3dUswKzROOXJ5UENi?=
 =?utf-8?B?QlhDZWVXMmNrUG9qUk5KK1I1enJrOU9CTDdHVmNkc1NFQ0huSUpFNlIvRGNQ?=
 =?utf-8?B?b0MvdjB3ZzJDc295MGpHRmY3d01wcnFCaUZLNzlhZEpEdEdFMCtJWHFxTjBs?=
 =?utf-8?B?S1R1Vlc0U2o4c256aThGWnQzLzJnbWpGMm8yRVlkbklaTkp5NmFjSCtLZjlC?=
 =?utf-8?B?MWU0cFEwc1JNKy9jaE9jUkwzWndCb1BPakJxSXhGZkF3dmRSSm5YREQ0V3RH?=
 =?utf-8?B?elN4WWt1QkJyYVB0akEzWWJ2RDB3VXYwTFpPc1p3NEpQVWU5MzhYRTdFZUho?=
 =?utf-8?B?VlNPMWszNTdnM3NyMWdraVdzQWRtWmU1SlJtaytPbmxxdlpucGwvTXFzaito?=
 =?utf-8?B?dTY0ZWg3M2pGNFV0c3FkaGhzbXhld0hvQmdDVlRrNUZKRWNzRm1sT1NqRFVl?=
 =?utf-8?B?ZExRVk9YRldiSmZjTlhrcVhaZ2xWaVpmYnZFQ0lpTGFzVk1QVTFTbW5qeVhq?=
 =?utf-8?B?cGpZZkh3cjQ0UE9mSmp1d2RQQmNJNWtobjN4djIrYUZ0dTZZcndyMDZEOGto?=
 =?utf-8?B?K3NwYmMrYWJONk9aaUEwOEpTUW1MZ0M5TUxaUG5IN1VRWTJYZEd2ZUZIV2wy?=
 =?utf-8?B?ekNFWXJpQ0hETXhJbmgrR2laNFVzdi9aRmtOUmp3RGxqRDhWV3FhUHdkT1Jl?=
 =?utf-8?B?RmZGYWpsYTdNclVKUWlGRE5mdk9DeDF6bkl4L05Bbzh5Y0Z3dmttZHlUMnVH?=
 =?utf-8?B?WGtqVWFGRE9zSkl6dThUMzJBaTAraUpIK0llRVBlL0lUVzIxOFprMFFhN2py?=
 =?utf-8?B?UGgzNXRjUWtMd2ZjTGtCY0grcjhpOGlJRk5mZXJPVzlMbHVERXlNSktNd01S?=
 =?utf-8?B?dXJPMy9lVy9ZeStzcjUrRGtCeDlyaWRidzFBT0lJSzV1cDltNEZxTGVJOS96?=
 =?utf-8?B?REJqY1diRWRQTnI2UkMwRHZyZlNYc28zcFVpQ1VJMUJoTUo4TEcwZFJtM0VJ?=
 =?utf-8?B?bVNwVGZkQlR2dkU0amZLQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bXFVM00xaUpOc1BOeFViN0QxZ1B5V1FCcDg5Ykd3ZUk0dkp6aE9HTE1RclNR?=
 =?utf-8?B?cG01RFppcitNdjZWVUdKWGZvdzhkcTU0VlA2S3dxZlNPR3FlQXRmUUpKU0Zn?=
 =?utf-8?B?Mk9oVnI1YWRuZjZrQXNYRGM3Rm5NbWVnVFN6dVZYS05uUXB4TG5FV0NxUU9M?=
 =?utf-8?B?Sis3aXJxNlJQZWpzc2RKSmFrazFiVVRrLzlZOVBONmsrU2d0WlgzYWJ5OC9H?=
 =?utf-8?B?RDVybE82bGt3L2dCMEN3MzBTVnYvL0lTWFprNmVaZ2V5S3hQc2tKSGJadVMx?=
 =?utf-8?B?cVdUTHl4WGgxdHNucFhFYkR3NmZGMTVSRHo4d2ZRaCtxT2IrRzV0Y1RTckx4?=
 =?utf-8?B?VkFwNThJcnBUeWdtOVQ5VkVvc1RTZFR6anJTNU0zUktnSkovRVp1QnRKQlJz?=
 =?utf-8?B?eUh0ZTA3VVZuV1YwUDN1MHBrNUNVUGQ3bmEzcFVLeEZVSzBmakt3bjUyRkxX?=
 =?utf-8?B?VGtMYWs2TTFqQyt1bjNKWTh5UDFmN1phYmVQSE43Ti8yWm9tdGE3VEFDZ3By?=
 =?utf-8?B?VGxkYWNPQk5tSytXK2dhVUduNzlQWWJuZ2FQa3NDZUJtVW1uSm9vMTM3SGNj?=
 =?utf-8?B?YTcvTU01cHpQRXo0aUpJUWFmZThHNlhoakhoZEluQkNUMXA4Uyt4RVJ3OUx3?=
 =?utf-8?B?UzNzK0FNWnk2Y00vVk92QzBmU3cvMFppampjd1g3dXJnL3BFUFFMMGFKanY0?=
 =?utf-8?B?SGJRL0VaNFNzcHF4QUo2VW96aFBkNitDbTI5czVpQzRta3dlUkZYMi95cnp3?=
 =?utf-8?B?dHJlbGhUczU4dWJRcGx4bjFodzl4bDB6MXkyT1VUcExQTmRpRE93U01jM2V4?=
 =?utf-8?B?ekhQUEVqWVh3Nm5ST1lDQmxaNWZRdHhQNUxaZlBMT2szSUZOYUZNaGdDbXdK?=
 =?utf-8?B?UktPOFQ0QkQvMGlpajRmcmMwd3FRemUwQ2JPcHB5SDhsRVdTRkxmQ3IvL0Zx?=
 =?utf-8?B?cS8wczNoNnFTaWhRcUdRWGZjcU1BSkp6aktCN2RKdVgyYWIyeWlpOENnaWI4?=
 =?utf-8?B?VXFORWFQZm1NOW1RM05iM3UweWR1MEIwUGFkcFJkYzNXbVptZzlxL3BaOTl0?=
 =?utf-8?B?SmhkT3g4SlBXRzIrQ2k5MnVlOU1kb05xbk53QjQvOTFHZGhrajhxeFJ0Rk1W?=
 =?utf-8?B?Z0NYdG1hR1pjRkZsN0VPTEtkVzZ6M3lobjVDOVRtSWFMSWFUT3FROEFGaUl4?=
 =?utf-8?B?dlUvd1FzN2xJNzE3bTcvT1l3WnE5ZG8rNlczMWxLRjlEcjJ6SmlxUHcwMW4v?=
 =?utf-8?B?ektLbDlTdkhTanNqYnBYTE1RZWFlSmxtVVBRcVNQdnRXSVNReUVuTzZEYnBX?=
 =?utf-8?B?UGVVaW5CZ3lZZVY4NFo5bzRKN2N5bGg3YUFmNEZHNnV5N2FwY21LeDdSOHlX?=
 =?utf-8?B?c2wzUXI0T0ZhemRXWm9XMGhqdnFXMkNwOGVJemovR1AwNzRiWUFTSi9taDhG?=
 =?utf-8?B?VHdkNjErSXZlaGtqTlUydkQ4UDJyM0VEdmZUcFl3Y2RDZVBFc0JuMXNiQkdE?=
 =?utf-8?B?d004OVZvYVRGMkVoWVJNdS84Z1NlV1FCRDBSUDAra3ZNWW4vTmJwMzhmeTZY?=
 =?utf-8?B?bEZwc1AxN2NOc2xqQTYvNW40c3M1VVpVNzM3NTdsd1pIanJWLzBIMjAyaDNL?=
 =?utf-8?B?Ym55OGNmVTREY2taWHlINDlrNjA3NXpvRjN2M21SVkhYUVBwS3lNUHp6bzB3?=
 =?utf-8?B?YzRGVGpSeUxNOXkyeWxlelVYYnZadVR4WEtTcTJhVTJCMmZNWjJyemxiZ0gr?=
 =?utf-8?B?QUhJU2EyOUU1dkFna241NVYvRzRjVzcvRmdCcVNGcGFFZHV2RzZrV3FNbnkv?=
 =?utf-8?B?eW5wMzZEakxpNllpaU5rRHRGQlk2RzRQR0MvUm9xbmdGdGxmMVUzZjFqUlRs?=
 =?utf-8?B?VXU5OTJMNzV6TGhTMTVhVHk4YWdRazlYWWE3QlNMVS9vRnVqQkNRRTloNDhX?=
 =?utf-8?B?VnpLSm5odTV4Y2dQdDJoSjZ3VVJvaVh5RWtBNE1xaWNTclM2SkVYcit6K08r?=
 =?utf-8?B?Zk5vTFAyUkhVM244dzAzTTY3anNRK1FITWVPSHNOSTBZRkx1SnhOQ2xxeDNQ?=
 =?utf-8?B?SkUvRno3UTVhZ2FsK1BwbjBsNHdnQ2hNMWdHNHJMNUVHRitSR0pSV0puVUsx?=
 =?utf-8?Q?lfFsJgHICA6jCxB6184swv+ye?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iafZ5Z1tbfvd66L1cM4quXKvJZemfSa0OKNgCFknKNi6mZ6jGlvcPXycoyGL8g7HIpJrKh0qfitxrax5xiVyzjC2ULoPWinGSGmO3X2nlzuHsjou6tu1TSa6EdlYF+6pglZX/6ylmdZVChnzEuU7sHAmUIu7ahQ/IK+JGJSNonVriABFIc5vSOX/UUolZrkdQozrf1qOPMnuW/5yDVRtxLsvPpUqNhrfMS3XzAzMB6mpEV+UWm7FsA/AmXzmqj6hLYcKaOZUciCzsJiD+b5XL37ski+yRaZExI85nddIrTLXGQzUHXQUnC9HRs3FvibT++tSMddLAvPyJOuVucnYpL4XnKb/xL43ZLCQ2kjPqkexYhHVSnYxrSW2w6MPiWUv9V54Ov2/fL5Fj+hLxRxkX+sxIgaXfK6bZanPr49oaTwwMqeLvDlNcP/8Opy2kKk8RulcM1Zg6Vklu8kuCsqk6s70W+qdt6Y+mZuSKcJEAfzpCKgAJNc8IAcwTy8cEz9yafETlQVnJVjuKRx5n7nCTYcshOKT+uJHyj3mfBYfjxplqgbau782tG/hq8iIvgjMnOnX5hHAyHjCAXp9O0urSz2DRHjb2YKk1GVMmkolEyE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50204919-3736-45e8-008e-08dca179874f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 07:17:31.4830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l45V2wKBW3nvQa48UOJwsVK+CB3Ks2vllydbILBrm7u68A5g9kvOgNfj+AXneMt8GetU+WNRv8G9qjSGZYrcIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4864
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_03,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110048
X-Proofpoint-ORIG-GUID: H4kC2jqt_EH8pqjwoSIp764ArzcxRE3c
X-Proofpoint-GUID: H4kC2jqt_EH8pqjwoSIp764ArzcxRE3c

On 11/07/2024 03:59, Darrick J. Wong wrote:
> On Fri, Jul 05, 2024 at 04:24:44PM +0000, John Garry wrote:
>> From: "Darrick J. Wong" <djwong@kernel.org>
>>
>> Add a new inode flag to require that all file data extent mappings must
>> be aligned (both the file offset range and the allocated space itself)
>> to the extent size hint.  Having a separate COW extent size hint is no
>> longer allowed.
>>
>> The goal here is to enable sysadmins and users to mandate that all space
>> mappings in a file must have a startoff/blockcount that are aligned to
>> (say) a 2MB alignment and that the startblock/blockcount will follow the
>> same alignment.
>>
>> Allocated space will be aligned to start of the AG, and not necessarily
>> aligned with disk blocks. The upcoming atomic writes feature will rely and
>> forcealign and will also require allocated space will also be aligned to
>> disk blocks.
>>
>> Currently RT is not be supported for forcealign, so reject a mount under
>> that condition. In future, it should be possible to support forcealign for
>> RT. In this case, the extent size hint will need to be aligned with
>> rtextsize, so add inode verification for that now.
>>
>> reflink link will not be supported for forcealign. This is because we have
>> the limitation of pageache writeback not knowing how to writeback an
>> entire allocation unut, so reject a mount with relink.
>>
>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
>> Co-developed-by: John Garry <john.g.garry@oracle.com>
>> [jpg: many changes from orig, including forcealign inode verification
>>   rework, disallow RT and forcealign mount, ioctl setattr rework,
>>   disallow reflink a forcealign inode]
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/libxfs/xfs_format.h    |  6 +++-
>>   fs/xfs/libxfs/xfs_inode_buf.c | 55 +++++++++++++++++++++++++++++++++++
>>   fs/xfs/libxfs/xfs_inode_buf.h |  3 ++
>>   fs/xfs/libxfs/xfs_sb.c        |  2 ++
>>   fs/xfs/xfs_inode.c            | 13 +++++++++
>>   fs/xfs/xfs_inode.h            | 20 ++++++++++++-
>>   fs/xfs/xfs_ioctl.c            | 51 ++++++++++++++++++++++++++++++--
>>   fs/xfs/xfs_mount.h            |  2 ++
>>   fs/xfs/xfs_reflink.c          |  5 ++--
>>   fs/xfs/xfs_reflink.h          | 10 -------
>>   fs/xfs/xfs_super.c            | 11 +++++++
>>   include/uapi/linux/fs.h       |  2 ++
>>   12 files changed, 164 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
>> index 61f51becff4f..b48cd75d34a6 100644
>> --- a/fs/xfs/libxfs/xfs_format.h
>> +++ b/fs/xfs/libxfs/xfs_format.h
>> @@ -353,6 +353,7 @@ xfs_sb_has_compat_feature(
>>   #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
>>   #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
>>   #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
>> +#define XFS_SB_FEAT_RO_COMPAT_FORCEALIGN (1 << 30)	/* aligned file data extents */
>>   #define XFS_SB_FEAT_RO_COMPAT_ALL \
>>   		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
>>   		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
>> @@ -1094,16 +1095,19 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
>>   #define XFS_DIFLAG2_COWEXTSIZE_BIT   2  /* copy on write extent size hint */
>>   #define XFS_DIFLAG2_BIGTIME_BIT	3	/* big timestamps */
>>   #define XFS_DIFLAG2_NREXT64_BIT 4	/* large extent counters */
>> +/* data extent mappings for regular files must be aligned to extent size hint */
>> +#define XFS_DIFLAG2_FORCEALIGN_BIT 5
>>   
>>   #define XFS_DIFLAG2_DAX		(1 << XFS_DIFLAG2_DAX_BIT)
>>   #define XFS_DIFLAG2_REFLINK     (1 << XFS_DIFLAG2_REFLINK_BIT)
>>   #define XFS_DIFLAG2_COWEXTSIZE  (1 << XFS_DIFLAG2_COWEXTSIZE_BIT)
>>   #define XFS_DIFLAG2_BIGTIME	(1 << XFS_DIFLAG2_BIGTIME_BIT)
>>   #define XFS_DIFLAG2_NREXT64	(1 << XFS_DIFLAG2_NREXT64_BIT)
>> +#define XFS_DIFLAG2_FORCEALIGN	(1 << XFS_DIFLAG2_FORCEALIGN_BIT)
>>   
>>   #define XFS_DIFLAG2_ANY \
>>   	(XFS_DIFLAG2_DAX | XFS_DIFLAG2_REFLINK | XFS_DIFLAG2_COWEXTSIZE | \
>> -	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64)
>> +	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_FORCEALIGN)
>>   
>>   static inline bool xfs_dinode_has_bigtime(const struct xfs_dinode *dip)
>>   {
>> diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
>> index 513b50da6215..5c61a1d1bb2b 100644
>> --- a/fs/xfs/libxfs/xfs_inode_buf.c
>> +++ b/fs/xfs/libxfs/xfs_inode_buf.c
>> @@ -657,6 +657,15 @@ xfs_dinode_verify(
>>   	    !xfs_has_bigtime(mp))
>>   		return __this_address;
>>   
>> +	if (flags2 & XFS_DIFLAG2_FORCEALIGN) {
>> +		fa = xfs_inode_validate_forcealign(mp,
>> +				be32_to_cpu(dip->di_extsize),
>> +				be32_to_cpu(dip->di_cowextsize),
>> +				mode, flags, flags2);
>> +		if (fa)
>> +			return fa;
>> +	}
>> +
>>   	return NULL;
>>   }
>>   
>> @@ -824,3 +833,49 @@ xfs_inode_validate_cowextsize(
>>   
>>   	return NULL;
>>   }
>> +
>> +/* Validate the forcealign inode flag */
>> +xfs_failaddr_t
>> +xfs_inode_validate_forcealign(
>> +	struct xfs_mount	*mp,
>> +	uint32_t		extsize,
>> +	uint32_t		cowextsize,
>> +	uint16_t		mode,
>> +	uint16_t		flags,
>> +	uint64_t		flags2)
>> +{
>> +	bool			rt =  flags & XFS_DIFLAG_REALTIME;
>> +
>> +	/* superblock rocompat feature flag */
>> +	if (!xfs_has_forcealign(mp))
>> +		return __this_address;
>> +
>> +	/* Only regular files and directories */
>> +	if (!S_ISDIR(mode) && !S_ISREG(mode))
>> +		return __this_address;
>> +
>> +	/* We require EXTSIZE or EXTSZINHERIT */
>> +	if (!(flags & (XFS_DIFLAG_EXTSIZE | XFS_DIFLAG_EXTSZINHERIT)))
>> +		return __this_address;
>> +
>> +	/* We require a non-zero extsize */
>> +	if (!extsize)
>> +		return __this_address;
>> +
>> +	/* Reflink'ed disallowed */
>> +	if (flags2 & XFS_DIFLAG2_REFLINK)
>> +		return __this_address;
> 
> Hmm.  If we don't support reflink + forcealign ATM, then shouldn't the
> superblock verifier or xfs_fs_fill_super fail the mount so that old
> kernels won't abruptly emit EFSCORRUPTED errors if a future kernel adds
> support for forcealign'd cow and starts writing out files with both
> iflags set?

Fine, I see that we do something similar now for rtdev.

However why even have the rt inode check, below, to disallow for reflink 
cp for rt inode (if we can't even mount with rt and reflink together)?


>>    * Mount features
>> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
>> index 265a2a418bc7..8da293e8bfa2 100644
>> --- a/fs/xfs/xfs_reflink.c
>> +++ b/fs/xfs/xfs_reflink.c
>> @@ -1467,8 +1467,9 @@ xfs_reflink_remap_prep(
>>   
>>   	/* Check file eligibility and prepare for block sharing. */
>>   	ret = -EINVAL;
>> -	/* Don't reflink realtime inodes */
>> -	if (XFS_IS_REALTIME_INODE(src) || XFS_IS_REALTIME_INODE(dest))
>> +	/* Don't reflink realtime or forcealign inodes */
>> +	if (XFS_IS_REALTIME_INODE(src) || XFS_IS_REALTIME_INODE(dest) ||
>> +	    xfs_inode_has_forcealign(src) || xfs_inode_has_forcealign(dest))
>>   		goto out_unlock;
>>   
>>   	/* Don't share DAX file data with non-DAX file. */
>> diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
>> index 65c5dfe17ecf..fb55e4ce49fa 100644
>> --- a/fs/xfs/xfs_reflink.h
>> +++ b/fs/xfs/xfs_reflink.h
>> @@ -6,16 +6,6 @@
>>   #ifndef __XFS_REFLINK_H
>>   #define __XFS_REFLINK_H 1
>>   

