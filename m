Return-Path: <linux-fsdevel+bounces-39241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4567BA11DFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 634BF3A4C63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 09:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7CF1EEA45;
	Wed, 15 Jan 2025 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C95oZgrb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PkI8gO2j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8927A24818E;
	Wed, 15 Jan 2025 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933458; cv=fail; b=STyV7PidX1AI5n6htMxLyYTBD0RSTMlRuMH6h8IHKB3XvbGcN9i7xpt9TJNcaHLl0KRLL84x3hKmMe8CFtwS3ittBH0agGoZVaxNg1vv3wtIG0tko8dE4pJu7ufTX82V4A2tPpy8nEiHoOgapE80hbVHoMV5ENDyxEpb4937DD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933458; c=relaxed/simple;
	bh=fgI/WHlYpaaBLa9eU5Ht3O+cs0G1oduPilNDe4iM1O8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DQtPNsocEOUMnYQ+uCvKXRUJtbOmljR73znfev5rua/4kj0jCGC4KrEiRcAtEWnbYpXOvZ0r6/MwUNXngVY/Qy/6oCP7gDu27CjrrvEWLmf5arHOnLr2lQfD5xP3QC6KRFTeFex5VvfPoRDRkQKFfcU7RQns2jsRL1jHRoazfaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C95oZgrb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PkI8gO2j; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F8tp4J030183;
	Wed, 15 Jan 2025 09:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=aaJBv2zzG8Ipu0MnnMuKILP3CYImK+1i5+a6FSqcaWM=; b=
	C95oZgrb+QjajpwaSSpw1ye4slMhkA7+avZlet7PFhNq6keevkFKDnkxN3K+/Auc
	s1yr+yJaOuKvSC0+0fzCVZcxEU4gJACflwjtBoea0DKodLt+0SdNiKWwlsfgwgEw
	gWbazgZ0nCV3CmkiuVDheLgdH5GU20QADN5NMP3yg4LOy+qBRFajZ4u3qCmBiKpC
	zqfLlQy/w4cJdGcInsUfXFQTACba2REAyKuLJ333+/hwLY97rKAlwWTxkzlPEDg9
	sBpyFCssueauKkVyOqOAyI8yaZ0CtnwuAQaqdgGqpYn3e7Y/xCySRVxkAjABoRFh
	qn8fzYqwHRqU7Bj58acrXg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443gpcqryy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 09:30:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50F8UtI6034885;
	Wed, 15 Jan 2025 09:30:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f397tg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 09:30:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYuHok/HXGXEsFRUr3JTGZI05I7ukQbIahI3uiG8Hfd+swrr4gFHlP8EdhnM+A1r0PBbyujpYEN8DVNH+oNEcxFDZ6SnLMVL3JNOIox3lgqNhR6Y/m43KIQqs6tiJb7mqD9Lx88k3sie8p3ZtkZw3nyU16Kq13qVsxjB41d7GNXAS1NKbKytATa5NBrXAaFkpyjqUqbvr2ZKQCSB1wwO+7kr8qvyPLuQu5ooprCDOj60ld1z2ug763EYM5EFl0+vTygSAEBLPrEuu0tpWXrpMuVkt2Mvtwodu0IU8rivoXr84WPznT6+QQqOF46wY7eigs77AMOYyKJrpySml6eqSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaJBv2zzG8Ipu0MnnMuKILP3CYImK+1i5+a6FSqcaWM=;
 b=Vc0XikKpqVwCJ/M6N49j9+qtUXGh79rvTu/XcBJ/43ySa7nm+6uh4XkV71+tGdNafQuz5jf9ygQSVqrv7IRj0CYq2YlnjMfiYRCfXYkCpsWHgVtZeHO2Rfa5S063q913ilj0artEJBsShR9joZWhzEWeMfYMSUvBZrlVD/eOvsoO5HaXToYD8ioaMqx6WvbF2iE8JXyD1sgpFg0iwRoABPio6G5STsQROMCwWR+uYC7qAWCFGscuxfK4AWbfPdLUyIILPhgibbbCKXbNvWs7a2WEm11UaX4567wBlm8usOq1ZYDbXb7Fos41kfZnGR66oG/F38pGLS6UioYWOQndOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaJBv2zzG8Ipu0MnnMuKILP3CYImK+1i5+a6FSqcaWM=;
 b=PkI8gO2jDu2Rsk0FpnoiKJONBp5Ajn8OyDEKvp+BIz4pVPOD03hNUznYewoF/dc6uKpVl+lK3SNeVUs7YjVLPNxmb5T9ii3GRlrcDQJnQHAkC3E/GF1n/zUtQKrIsI9BOm99Ba+TRoa95Bkf5u31i6tpl/NNdlBdM6+2WeT0BcA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6180.namprd10.prod.outlook.com (2603:10b6:510:1f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 09:30:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 09:30:36 +0000
Message-ID: <e7e3e769-07fb-4b71-b4d4-8d50754bd3b1@oracle.com>
Date: Wed, 15 Jan 2025 09:30:33 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] iomap: Lift blocksize restriction on atomic writes
To: "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
        ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com
References: <20241204154344.3034362-1-john.g.garry@oracle.com>
 <20241204154344.3034362-2-john.g.garry@oracle.com>
 <Z1C9IfLgB_jDCF18@dread.disaster.area>
 <3ab6000e-030d-435a-88c3-9026171ae9f1@oracle.com>
 <Z1IX2dFida3coOxe@dread.disaster.area>
 <20241212013433.GC6678@frogsfrogsfrogs>
 <Z4Xq6WuQpVOU7BmS@dread.disaster.area>
 <20250114235726.GA3566461@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250114235726.GA3566461@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0227.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: 9344c3fb-f749-4fde-6dfa-08dd35474488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXRtdG5yL25HeFNBOWhUalFZZlAwdUxmMFJZeXdjQVdWUVRLYkVGL0JVc0Fn?=
 =?utf-8?B?VkJIYUxtUmJXdDBseGxibFZjRGh0MXJuVysyelVkaUxranI2NSsvQlAyVVlI?=
 =?utf-8?B?OEJQRXNpNUM4a1BEaHRaUmE2Rzl5am5YeWtvKzhHQXpBMi9RY01CR2JmZGNE?=
 =?utf-8?B?ZFNVTWJVaXR6ZHJhMWVhU0p2d2lhYnZ6UFhoTE5GaHpmUS9hS3ZOWFpKU1c3?=
 =?utf-8?B?SlVLSTNxU3BGQjJ6dlhGYlY4cW05K2ZScmdHdVBDbWpHOVZUV0VlTE9obzNu?=
 =?utf-8?B?ZmRsbXh2RXdrL1F1UEpTNFJvSzJCWHQxV2ViZXBWcFFkUUtsRUdzQ2dmaUVR?=
 =?utf-8?B?YVMvNVhCdWZGUHNkNFEzNzh4R0tBYnNuQkpMZHUxUVRXQXhYWmc3YjFmQjIv?=
 =?utf-8?B?SlR6QWJEVVAwdjVHTXRyL0EvSzFCbGk3UXlDbG82YWo3bHR6T0h2anN4MVY3?=
 =?utf-8?B?Yll1OFZMT3o4UXFMb043RHQzU21ySlRYdzQwdnE4SldUUkdPVWlwSzJZMExZ?=
 =?utf-8?B?RmxOejNVTGFqTWZRUGZwR0ZVSytvZUc3UE5xUGNaQnBlUGtyUncxYU1JQ3k4?=
 =?utf-8?B?Sm8ySCswa1Ric1kybE5ZVEV6OW1WWmQ5cGtwYUh6Y0xCR3VxUmhMaDlHTVpL?=
 =?utf-8?B?cWVkYlFzQ2luN2owM1hZbXE4NEFJS0hpVnYrUTFva0VPYUhvdzFZaWh6RFky?=
 =?utf-8?B?aDNxR3ZyZzJyN1ZqZTR3cDVRbUkrMk1ZenN0SjBUTklNSnhydWIzVUlrVE4y?=
 =?utf-8?B?ajNlV2RGK1RWN2dHQ0ZWSWlEczdjV0NESzJBMFFWZE5WejRMUDhWdUNnNTlU?=
 =?utf-8?B?ZkdmQTFmajhWVVV2M05VZW9HRDJ0dVZLbVErbEVadXhnZ0llSS9IdjZDSVd0?=
 =?utf-8?B?NDNkZjcwcTN3djRvaUVuTE5ucHYrcTJ4bjhJWmRXcEY4RU5yLzNMZ29jcFdj?=
 =?utf-8?B?YWpWaldwN2EzdDB5OUhqaThIVlFTZTF5SWd4YXJPVVRXRWErWDI2Q00rbUFZ?=
 =?utf-8?B?YmxwL3RTYnU5RGU3Nm50Q3BSUFlLMlZ4dTNhVVN4M2ZidHpaWHBuNWQwbWRq?=
 =?utf-8?B?b2tZRVBNNGpzSlNWY1pGeFlIWFVtSHhFeFVYUVZ3NmlwZUFyUCtINUUvVFNT?=
 =?utf-8?B?ekU2ZE1KK2pzcy9FWTZaL0FyZkR6WnNjRkZVeDFPM3lBR3RnRlk4QjU1UG8w?=
 =?utf-8?B?eVRsREthQnY0b1RGNUlWcG51ZDJiMTliMW1CalgyNFJKRHZDdlAvYXlia1Ra?=
 =?utf-8?B?cnZRMGl5ZHpKVitlejBEeXMzcFpKZmlQcURwRnpjUjNCaGJxaVdhUUVrS1JO?=
 =?utf-8?B?c3dSNXNhWUNLVG9GM3lSZUJEWjdtamtCS1FGUHdHRGlxejluc0FpTkZUOFd3?=
 =?utf-8?B?ZC9aalVFQ0FRRm9OVFdhbDl5RTlqYTA4TGVUbk5QR0VXb2xlTFRtNi9CQnV6?=
 =?utf-8?B?RG1pZUxGUmdkeXJNRGtBYmU5S3BVeStZenR2cmtyWFNVNG9vd2VVbkQyUjBR?=
 =?utf-8?B?b3RZeHRTQVRTRm55ZEFoY1NyTERmSWlUY1JnYStkNkZlNENMR3pNa2lOck9q?=
 =?utf-8?B?WGxiUFBEUzBwa2hWL1J1S2JvSTdLemdhMFVKQnNmMURmMTlxUFlwL1hXRkM4?=
 =?utf-8?B?ckduellKczh0SDRkdFFndGFENkU2ZEptTFVCdVl2b3k4cEJuZHpqN0lPazlC?=
 =?utf-8?B?L1gwYkx2UW1XbkVhcG5WQTduS3BOTmJCeTdaNHdaYlJ1WGZpN1JMK09JMW1p?=
 =?utf-8?B?VnhTV0syWTcybS96OUlzRGViZ3c3K3Jod2cxTDZIQmhBYmVabGk2TkpjK1RG?=
 =?utf-8?B?eVBDYW9sVlZ4bW1IUzQrZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFU2Sk1uVUZRR3diRmZnSytwa2IxN2RJcFZ4Zy81aU1MYjNhVy9jbVl5b01j?=
 =?utf-8?B?L0w5b0I1TUhtaXlIb0VVWE1aSmxudndHZTlXZFcxRjcrbTZNUlBQSnFiRlhU?=
 =?utf-8?B?WXRHVTZHbXJzdUl3dW51VG9KNUs0YzM1NFo0aXNUelhNd09MRWpJajRvemUv?=
 =?utf-8?B?dXk5bEdXZEVORG1jVTNJZnV4cnl5aForczNrTHdyVzM3OEc0RUh1Zkk1UXNo?=
 =?utf-8?B?R21QMEpCcm96TE1wYklsTHIxZjZBTTNGMitacnJrRFNIRDdvQ1dHZGNVbHdW?=
 =?utf-8?B?R1diaERUQ3NJdk1PdU1PVE5ENWZlcmIzNlZSU29YaUFiQ0t4SHIwQXFremdq?=
 =?utf-8?B?ejRVYm8vUVlnbytYUE96QkFidE9YUk1SUlZvcXFPbzQrY0tRWHhmVFl0enpR?=
 =?utf-8?B?UkNQVkwzczhCWjB4VFhjMExna2lVaU9ZL01vOStacWlXZ2tFT0Z1RVFYM29B?=
 =?utf-8?B?UkNQeTV5N29UYTV0WDhzZXhZekcxYmNDQTAvbXFGbkgvaTJhd0NMN2hsTDVQ?=
 =?utf-8?B?TWhTdGNhVTIxc2FOVUFyaitJb1RXM0h5RUpWVE9QVlRxdzB3LzBpTmtDTitW?=
 =?utf-8?B?QWVwZFZVTjBqbU1vOXBPU3hvSEFLZHBBaFBialhjM0NpYVJrdmJvRmpZbE04?=
 =?utf-8?B?VjFHcEViR0xEeU9YVTdWZUYvTkV1dldkZDZPYkhMK2VRNFNTVkZvK1hMdGVG?=
 =?utf-8?B?ZWlmRXI2bFpTcGkxQTJnSVJNTWZvMTU1djlHdldMZ28yc2pJSEh6NGUzVHV5?=
 =?utf-8?B?ckg4WXVJak42M2VFMjBhRkhqYzJYaFNPQzB5ZTdLYlYyamxHSGdWQkdXb0RC?=
 =?utf-8?B?WkdCMHJiNG1iREFTdGlwemwzdkVPa014R2lUN3ZGSVQvendvdXJGelczd3Rs?=
 =?utf-8?B?SWUxMTNHcHNiMndYK3JWeVU2T2RrWGg2TnhiZlFvckFwbmREWHltY3g2ZSto?=
 =?utf-8?B?UDQ2ME9SMEw1NmUwbFYyd1NrNUdHMVNNb1QwRk45M3laR2xzYTZwSHBRRUlk?=
 =?utf-8?B?TTFnRVozZGxqdDZqYlBieDg3OHhmcnFaUzhvaExJa0hTcTBsMGNWSlUrb1dn?=
 =?utf-8?B?N2JIOGFsd0diUkN1Y0J4emRSeWlBeVNnUHlWU1QxS2luUHJFZUVJVllscmFL?=
 =?utf-8?B?MmRMNTcvdWpvdjhEanE2R1VMTm1XQk1UT2t1eHdVZkhiSzc2eXVYVWlFZ2k3?=
 =?utf-8?B?S1pVNGkvRkhVSDl5TE5XNjBaR05qdU85ZkVzZDRiZ2xvdTdTMzl6N3NEUTYr?=
 =?utf-8?B?aEREUFVoQ0UxQ0t3NXVrL3BrNDdmSTQwdEdpVVRSQlQzc0RSWTZ4dW5qR2sr?=
 =?utf-8?B?WU9UM3FxMzZ0Y012UzNrTDh1REgvZzFvNEQwOGxDODdlazBack5WTUtpOVJn?=
 =?utf-8?B?YkpxcDVCUmVsQ3JUS2R0TkhvYlVSYnpPUlhvUktjcllqd0lmQ1piU1NLRitG?=
 =?utf-8?B?RndVckY5NGxsWUJIZjBlbG4wOTdCRWx5ZmtJWkFWd0hIR0xZRXBDYkNYUGM5?=
 =?utf-8?B?cDMraGs3bk13KzZERlJuekk4QjBGVkxMa2NpM2pST2pFTDk4VkVHdUc3Qlhq?=
 =?utf-8?B?NGVDTWxvQzUwTEZNcjdDdXRHK1ZyMjJrS3RZRWRoS0xiQWlzcXpNaVc0RVZP?=
 =?utf-8?B?VndDVU1IaEJxNnBUQ25RUmM3NWdQU1loL1phVEx0a1BtU3U1Q2F4aGxvTFpr?=
 =?utf-8?B?NEVJd2NPdDJBWVA3alVqSFN2OWcycWgxWjBOYXBRb3dZL1VzUEdBNkVZL2NH?=
 =?utf-8?B?YmRwTlYvTitvbXY0bGwzaFZTdytRR0ZXbXhoc2VHV0l2QW54ZVp5ckorN1dw?=
 =?utf-8?B?MGdoNVBQb0hCMzZLTEIrNjRMSG1JL1JzdkdZVWI3cFVsVjc3aUI0ZXlVN01a?=
 =?utf-8?B?MWZ2R3FZb3VER1NtemIzSnRkU2x0YVE5a3dvU3BpRExNMThucXNMRkUxeTdu?=
 =?utf-8?B?VFdWSEpDZzdqd1lRVUtPOFhhbWVXTU41b0c1YVQrVldYeU9CT0w3RnpEdGhn?=
 =?utf-8?B?STFZM3RlWHV0SG1lM0hWelQwK3MwTHdMSWRNSFlqUnZ6a2FNc2VRS3RxbXRa?=
 =?utf-8?B?VEpDLzYvUDB3QW51MEJvZmdNeWptMnRrUUJjWkt1UVZQVDdCU2hLcGcxUm5C?=
 =?utf-8?Q?WBrK72N1EeKUSdFbDzOo680Id?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kjHe/AkqWfcTVFMtrd8eYPw2RoIwDPwBQqhcWLRTL4jBBHM5ACqGU6/eaCBvn/3XxP5ZUcMS1oxLoBHQcW15Is3FR0ifKMFLemnZD02CwENCJnQA2p3sodAhgoUL78qycy7X9dH+5LtreB2DPZ22orjoQayPt0z8oUUJmFfa1sz55uKFQbcS04xSpaCqkt/84lh0p0d+VLCNUWifbCBQfQ0XZuctrYv9+s7ZDrha6IDIuN46hbNmxez4MDIoI9HuIKCdg3ptwZHxCE0gJ+JY55iDXPO6/5LRuwcnDLJNL71U1aVHmI/TXH9YBFKbzs5GzpDcgeiMiG1wQonvivbABYRdvC8D6wdo2ujCJtkmPrvPhBAvlOniYvYeV1wpl/66cVj+bfXivjrALl+VeDlUqYcVBJvzjc/5fZ/hIRuaGO1xKwPW0nLG9CmzR34qZ/dAJPAb2P7b8EizLmlpgQghWBc0JPRr4IzSHOocShtguu4HGoenm6f/XKQNVaqK9cfFsbZi8jGx8VYJIth+BFsoY9nZkIeesG2orjpU4xfg3z/ySEI/PAJuUHsShtUDr5tn8p03pWUtYoL5MDRg4RX08e0SwNW5cdPm605Hv5/WJpc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9344c3fb-f749-4fde-6dfa-08dd35474488
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 09:30:36.7627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exiVIPN9g9b2unChS5I2Z9IiPjEeCwihS/ZUOcjLf0MecIrNDoydY8s5KXfcqI3XAO2a3uhO7WRRAwq06mCIvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_03,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501150071
X-Proofpoint-GUID: JceDwIkM2Oq7D4N7Ek8Ttxlh2Wa18RJS
X-Proofpoint-ORIG-GUID: JceDwIkM2Oq7D4N7Ek8Ttxlh2Wa18RJS

On 14/01/2025 23:57, Darrick J. Wong wrote:
> On Tue, Jan 14, 2025 at 03:41:13PM +1100, Dave Chinner wrote:
>> On Wed, Dec 11, 2024 at 05:34:33PM -0800, Darrick J. Wong wrote:
>>> On Fri, Dec 06, 2024 at 08:15:05AM +1100, Dave Chinner wrote:
>>>> On Thu, Dec 05, 2024 at 10:52:50AM +0000, John Garry wrote:
>>>> e.g. look at MySQL's use of fallocate(hole punch) for transparent
>>>> data compression - nobody had forseen that hole punching would be
>>>> used like this, but it's a massive win for the applications which
>>>> store bulk compressible data in the database even though it does bad
>>>> things to the filesystem.
>>>>
>>>> Spend some time looking outside the proprietary database application
>>>> box and think a little harder about the implications of atomic write
>>>> functionality.  i.e. what happens when we have ubiquitous support
>>>> for guaranteeing only the old or the new data will be seen after
>>>> a crash *without the need for using fsync*.
>>>
>>> IOWs, the program either wants an old version or a new version of the
>>> files that it wrote, and the commit boundary is syncfs() after updating
>>> all the files?
>>
>> Yes, though there isn't a need for syncfs() to guarantee old-or-new.
>> That's the sort of thing an application can choose to do at the end
>> of it's update set...
> 
> Well yes, there has to be a caches flush somewhere -- last I checked,
> RWF_ATOMIC doesn't require that the written data be persisted after the
> call completes.

Correct, RWF_ATOMIC | RWF_SYNC is required for guarantee of persistence

> 
>>>> Think about the implications of that for a minute - for any full
>>>> file overwrite up to the hardware atomic limits, we won't need fsync
>>>> to guarantee the integrity of overwritten data anymore. We only need
>>>> a mechanism to flush the journal and device caches once all the data
>>>> has been written (e.g. syncfs)...
>>>
>>> "up to the hardware atomic limits" -- that's a big limitation.  What if
>>> I need to write 256K but the device only supports up to 64k?  RWF_ATOMIC
>>> won't work.  Or what if the file range I want to dirty isn't aligned
>>> with the atomic write alignment?  What if the awu geometry changes
>>> online due to a device change, how do programs detect that?
>>
>> If awu geometry changes dynamically in an incompatible way, then
>> filesystem RWF_ATOMIC alignment guarantees are fundamentally broken.
>> This is not a problem the filesystem can solve.
>>
>> IMO, RAID device hotplug should reject new device replacement that
>> has incompatible atomic write support with the existing device set.
>> With that constraint, the whole mess of "awu can randomly change"
>> problems go away.
> 
> Assuming device mapper is subject to that too, I agree.

If a device is added to a md raid array which does not support atomic 
writes, then atomic writes are disabled (for the block device). I need 
to verify that hotplug behaves like this.

And dm does behave like this also, i.e. atomic writes are disabled for 
the dm block device.

> 
>>> Programs that aren't 100% block-based should use exchange-range.  There
>>> are no alignment restrictions, no limits on the size you can exchange,
>>> no file mapping state requiments to trip over, and you can update
>>> arbitrary sparse ranges.  As long as you don't tell exchange-range to
>>> flush the log itself, programs can use syncfs to amortize the log and
>>> cache flush across a bunch of file content exchanges.
>>
>> Right - that's kinda my point - I was assuming that we'd be using
>> something like xchg-range as the "unaligned slow path" for
>> RWF_ATOMIC.
>>
>> i.e. RWF_ATOMIC as implemented by a COW capable filesystem should
>> always be able to succeed regardless of IO alignment. In these
>> situations, the REQ_ATOMIC block layer offload to the hardware is a
>> fast path that is enabled when the user IO and filesystem extent
>> alignment matches the constraints needed to do a hardware atomic
>> write.
>>
>> In all other cases, we implement RWF_ATOMIC something like
>> always-cow or prealloc-beyond-eof-then-xchg-range-on-io-completion
>> for anything that doesn't correctly align to hardware REQ_ATOMIC.
>>
>> That said, there is nothing that prevents us from first implementing
>> RWF_ATOMIC constraints as "must match hardware requirements exactly"
>> and then relaxing them to be less stringent as filesystems
>> implementations improve. We've relaxed the direct IO hardware
>> alignment constraints multiple times over the years, so there's
>> nothing that really prevents us from doing so with RWF_ATOMIC,
>> either. Especially as we have statx to tell the application exactly
>> what alignment will get fast hardware offloads...
> 
> Ok, let's do that then.  Just to be clear -- for any RWF_ATOMIC direct
> write that's correctly aligned and targets a single mapping in the
> correct state, we can build the untorn bio and submit it.  For
> everything else, prealloc some post EOF blocks, write them there, and
> exchange-range them.
> 

That makes my life easier ... today, anyway.

For RWF_ATOMIC, our targeted users will want guaranteed performance, so 
would really need to know about anything which is doing software-based 
atomic writes behind the scenes.

JFYI, I did rework the zeroing code to leverage what we already have in 
iomap, and it looks better to me:

https://github.com/johnpgarry/linux/commits/atomic-write-large-atomics-v6.13-v4/

There is a problem with atomic writes over EOF, but that same be solved.

> Tricky questions: How do we avoid collisions between overlapping writes?
> I guess we find a free file range at the top of the file that is long
> enough to stage the write, and put it there?  And purge it later?
> 
> Also, does this imply that the maximum file size is less than the usual
> 8EB?
> 
> (There's also the question about how to do this with buffered writes,
> but I guess we could skip that for now.)
> 
>>> Even better, if you still wanted to use untorn block writes to persist
>>> the temporary file's dirty data to disk, you don't even need forcealign
>>> because the exchange-range will take care of restarting the operation
>>> during log recovery.  I don't know that there's much point in doing that
>>> but the idea is there.
>>
>> *nod*

