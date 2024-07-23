Return-Path: <linux-fsdevel+bounces-24141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D92493A373
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 17:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35F928435E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 15:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890AD156C5E;
	Tue, 23 Jul 2024 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U/827CN5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h11U0U47"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577F013B599;
	Tue, 23 Jul 2024 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721747045; cv=fail; b=FCwZv604CaWPejirD3/UHlg8fMN+YVct3ysS5cE0og55jEiCzE33J2wtkV9z+jUbqHeNFYC4uAkzRZKx+wlyfOWal3X/cSNOAG9q6hefuPagNNDBDBYspjZZ0rasE/lsw4VTm70JcfVDOLTuSb+ueQejDyz3Kvdc+0e4NBYBsJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721747045; c=relaxed/simple;
	bh=/CAeZ7HWpb+U0x2eBWhJEJYSnGoHy+YUG6lPG6wwPGE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=COBeqDoiUhPIKUqXI/FtPZxFRJUiY4eQeN1R5H3igIDyXKs5nNJSMiuRzuLPLsXVoV+XmcgF4yz66N1VaqcQnAirU3FxLXG1aNvidYUdEcX2l8ouLnmNeh26xemnIUqLEfbPu1Ny3JqOk1OqdkFYkseycbaSfZREX2jBmpbkLDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U/827CN5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h11U0U47; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NEfY1X031981;
	Tue, 23 Jul 2024 15:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=e72xXS8IVV/y5Oqpdz58zGm+TJIXarlXbRGQA8ALBuE=; b=
	U/827CN5aBUIsjcE2GJEEp+h0iz5Fq+w98j7VLQuLrApEYtT9HQWoigvASTCj+MH
	MsrW2aylc9Q5EyjJd25p35Yo5hsbVqMuudqlNYKF28fh7CZ4a7NlfNUUWdUyxtAq
	HaR/3fbHtNJm5bGFbIuyWy89ncPm9h3oK3FdgOnLgwKvcFI2aLAwFzc1DX3Z88AP
	Eetv2Gs41hW9qNWNOhLBijseJZnIPKmxE3iD4luArl9NEwWfTvhqiZexPFuQgG5S
	vd6aRurRONHbe090qFLRUSpcAa2zjm5oGJOtjj+dsLx1o9Ljd7neM0OEsmEhCnMD
	WQWbgeTRSHBQ72JuvF5UmA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hft0etpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 15:01:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46NEitvg010972;
	Tue, 23 Jul 2024 15:01:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h29ra8u1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 15:01:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1RMHtz9DnyJ3BigJfYruVy32U3sZLY+SsCdnT5lEiAWFweiYYLZ2cK2SD8kZ4LpF4yO0bE4mo8MRCSUKzndvkjJHyac+TBfG0CMrkubWPECnOd9XrKsP6nXGn+tosnSFjzh8uwqVFnPLiDIZO6M7I8EceZqNvQC5sNmkQD25BfrW8NETrjEjI/bZLlBOeVYLChiwFjlgvXScUbtz5vvEL495Pk2AKkPrcuPpScc8UJmRXRDyTGS/dMmAGAjXnXrNtZ9be6GaKiCC17Y5BXIUUAGC5b+Xv3KfkdOOm5ScabeOweWduakfckVA2kCMapz56x2fwiKNSwKmp1RDCvClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e72xXS8IVV/y5Oqpdz58zGm+TJIXarlXbRGQA8ALBuE=;
 b=MVZMkW6LCU4QOvLlgkze1m/J0nTKW9D+djlshbSB5+B1zE+soK5H8mvIU9Bk/y9MZi9HDixKpT5ONapK/4JUkhsPt7zOkUI8GR0/5ZeR3olNp2RHjlHx19PLlWWZi31OVPhZsEUDdvn3k69zqVW4OkWhGfgET1pi4zp299fMZGRVuWwsGIwZgg6fp24zAtttpU8+2hc/ZNO7Hc8Q+uGWKjU+FN3deF3eQsdsCBuUrydkeHh4qJdiw5tIz0+Avwh6lg31GtM3jxUVD30jSuyVsdxNu4oeabapPpZw+vpdf6GDE9Wph9Q3FdVYmbR7jYTINsHTr0W/8r0d0XFrMqpFQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e72xXS8IVV/y5Oqpdz58zGm+TJIXarlXbRGQA8ALBuE=;
 b=h11U0U47dh6pvX8AXgE3WZ4KDCXphXS1yjAX2OogEDcBUCMuy8hmMhi0t3sSXA3wL559aKCDT3D0AwGZb4wA7qKX6M8ts8WgCu1e4kgI4vFJvhSYeJHYg9+/UkKHHO6+ZT04rZAHYB0LP6G30i78Ppfz6jNiNB+CfqXCuif/QR8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB7514.namprd10.prod.outlook.com (2603:10b6:208:44e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Tue, 23 Jul
 2024 15:01:46 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Tue, 23 Jul 2024
 15:01:46 +0000
Message-ID: <2fd991cc-8f29-47ce-a78a-c11c79d74e07@oracle.com>
Date: Tue, 23 Jul 2024 16:01:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] xfs: Introduce FORCEALIGN inode flag
To: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>, "Darrick J. Wong"
 <djwong@kernel.org>,
        chandan.babu@oracle.com, dchinner@redhat.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        catherine.hoang@oracle.com, martin.petersen@oracle.com
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
 <20240705162450.3481169-8-john.g.garry@oracle.com>
 <20240711025958.GJ612460@frogsfrogsfrogs>
 <ZpBouoiUpMgZtqMk@dread.disaster.area>
 <0c502dd9-7108-4d5f-9337-16b3c0952c04@oracle.com>
 <bdad6bae-3baf-41de-9359-39024dba3268@oracle.com>
 <20240723144159.GB20891@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240723144159.GB20891@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0276.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: b5363447-a619-4e11-46be-08dcab285f35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWVYSE1vWGNJSWh5SVk4RnZ2OXYrRzRUSnI4K3Q3T29nZ0dnakZlcmg1aFpi?=
 =?utf-8?B?ZzR0T1RTc2l0UXpnOS95OFBBd0ViYm1kT08vbHlLSDFBWGRHSUsyckcwRVFF?=
 =?utf-8?B?eVZZd3ovc2ZqbVAwSHUvc1UyK1hjcHExZVpTczd3Z2dyQUJHVVJvRTJ5RWx0?=
 =?utf-8?B?TkVoUDRBQmFSYzNJRlVSaUViSk9TdHNIY0NkbmdWMzRmMjZDVEhINTY4aHFP?=
 =?utf-8?B?SU9uRVVjY3BrK2JESHFVd1c2Z3ZxLzdxeHRXd0cvRHlPQi9rV3E4L3Z4N2tO?=
 =?utf-8?B?bDByM1pRZy9TVzRTQmgwL1VTdjdNK0J0YjliMGlFQkxLanFKeWx4OU1Gd1Jl?=
 =?utf-8?B?M05zQU91eUNmMmJBNTUwM08yLzJMay9DRkhDRjhpWHd6Y3lPSWwzeTFEd2t0?=
 =?utf-8?B?Mm13UW1ZTFZ4NjRuT084d29ySEFlempvZExJenMrWjhVK0ppTVN4SFV0NzlW?=
 =?utf-8?B?eHkrT05yV0ttRXVFZEVTMFg3bXNWYWNOMU5GWlIxQW5LS3VwTjllbUlIUVhv?=
 =?utf-8?B?d05RdnFRMy85OGlYTUt1S2RnM3p5SjI3RGRrdUtEWGtuK1NlNGFvQXRwSTFB?=
 =?utf-8?B?ZVREQzhmU2s3WmNTc1BkZEhuVVZrbVNsLzZEdi81T0dGeUMwckFOT25YcDUr?=
 =?utf-8?B?U0lmMzljdHlhTmhoeDJuRHZKMnEvYzBQWWY2R3VrTVFwbm5VOTlVRXVZOVFj?=
 =?utf-8?B?b2FwV2tXVjZ0ZFljeVkrTktiNzhQLzBvZVJFMm1BQ1JLeTE2Y1R2VkZiUW9Q?=
 =?utf-8?B?S1BQcWV0RjZZSmNvL0FVd3V0a3dSZldZMUpjdWJvS1pWbENrekZTLzRqUWdt?=
 =?utf-8?B?a2hkWlRCdUhlUE9KbUV6WnQ0K0tsMzVuYVdYMVBrb1B1b0NmSlE3ckVNQUF4?=
 =?utf-8?B?cWlDcjc2U29IZWxwVkZwQjlBY2g2WGhTamNaMXdWeEd3R0NSNWtqc3RzR2F1?=
 =?utf-8?B?RkVtV1FsZjY1N2xwZEhaYjhPYWxtWTgwbGgrNE45RlN0eTYvYTZYTHpnL0RX?=
 =?utf-8?B?dGRUYzhsV0VaYXByQU8rZWlXZC9UbWJkY1JhYytvaWFXMTlnVXdJbytqKzha?=
 =?utf-8?B?bGg3UGNoeXlXR1dsV2JLNkJabXFUS0ljMGxSK1ZkL2diZnlpNVJlOVNad3pW?=
 =?utf-8?B?WGIxZGZJNGtKQVg4R2RpNzVUeE9wT3dhQjBwNFJzUGhBTFRMZmpJQmxYKy8v?=
 =?utf-8?B?OHVINThvcmVKZEh2M1ZNQ0hGTjYrOUxVUGdxMTFzOXFidFN3NG82RkRsWjhU?=
 =?utf-8?B?T3loNEwya0pLR1VOK1BXdEZqL25qb0tXSjJCZTFxa3BuUXM4ek5yalBYN1lx?=
 =?utf-8?B?R3hCVk83b25naXg2SjZIUWhWbW93QjVpR1FLVk5vaUprUGdudFBPdGUxMERF?=
 =?utf-8?B?QTJzRUw3SGVvNTRabmEzeUVQSWxucHZYSk5hT29sS2o1Q0JJRUtzQi9ZTnhN?=
 =?utf-8?B?ZUwzV0QyZ0VLeGZoTkFweGw1TEJSaE9nNWhlRjRBYzlyMUJ2RFF5THlaS0k0?=
 =?utf-8?B?b2s1RkEwdE5lV2hmUjl5cDlTU0h6aUpNdHd5bzQrYUtVbFQycHpRQTFJdmFs?=
 =?utf-8?B?cEF1akpnMjBpVDZFN2MxcHVKbElFNWwrUlludElBdzBqUGQ0MFl3TXRnclBu?=
 =?utf-8?B?aXpybUpYd21aOXpHYittNjNKQkwyYjZvc3UxZk1SUHhUZzNuVmJhRWRZU1ZN?=
 =?utf-8?B?SE1RZmdwRWUrb2FEOHgxdnQydHh4MzNDU1k0UStIRFQzdEIrL2RaaGQzZ1Fh?=
 =?utf-8?B?dzlaTUgwVGtRaVI1R3ZDMUY4dG9hMUZJbCtBaEZCUHR1RkRWQ2V1a3lWbTVK?=
 =?utf-8?B?MktxYWVTVHpmcWd2TVl4QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WllWZ2ozUm1kMVgvN3g2alN5Tm9hVE5BNmFKank3YWtKb2I0d2Q3Y2tVTlNr?=
 =?utf-8?B?OFpwSkI1NDNud21aUkNHY0FaVXlpU0xpYXNEcjdPZHRNWkhqa042MmFzWmxN?=
 =?utf-8?B?NnprSW8yaHVhTjY2TWxYdjdUbk83LzVEc0o4Tm12TjE1RXdGZDMvY3hZVUVn?=
 =?utf-8?B?T1pLWlJ5bEZLSlh5dEpyS0hTZEs0L0lYWDRrZ0lwL3kzSVlXQXNCUEFRaERZ?=
 =?utf-8?B?NjgwMS9FMDN5VmtMOXFKYTRZd2Q1TUUyQjRrTnhSTjU1TlBGUURJZVRodU1j?=
 =?utf-8?B?djU2SDh4cTVuTEgydFV3QjF2eDNEQUorT3pxVHVSOVpDeXh3anpTdzJLU0tp?=
 =?utf-8?B?RWw1M2dXamIxNmVxb0N0cTNGWVZrbVd5cmluVXN4UDdXVzA0M244NWs0K2gz?=
 =?utf-8?B?MlBCR0VLQmVxdnZjVFpVQUpRc2hGWjVFMnYrK1phR2hQM1VHMlBucTloZlZl?=
 =?utf-8?B?cXlSTFNJb1VNUXRUK3prWW0vS0pCQ0xSNkJyZGttV3dxcldJRVdRLy9pR2NY?=
 =?utf-8?B?R09UTThaSFk2MVEybFFobC9oMHBjTlV2VFZib1BqeGVESDc1NHluNktYa3pY?=
 =?utf-8?B?VllBdStlTjd0ZmZZeGMvKzhxMTZTRkx4Y1MzeEFCMUNTK1FtTFAzQloramRZ?=
 =?utf-8?B?Zy9MeXNlWE9IaEtZTDRvLysvemk3TWRRUHQweVR4QjhUb01OVFdIQXRiVFpk?=
 =?utf-8?B?bHNsNGxCcVdkOUhqdlNrQmovV2JRN1N0Q3d5a0VOWC9MMDd1SWFJYWZHaFhW?=
 =?utf-8?B?YlNrcHg2d0V2VE5lVTROajVyd2NQVlNZdVQzT1htVCtYcmdVeFhOQ21meHBS?=
 =?utf-8?B?enhXN3c5RmdlUy9Rek1XeW9BOVgyME91bDlpaHBtRlVNNkRBNHRrL3Jna0Ft?=
 =?utf-8?B?K3hmRlF2Y0p4ejg2WjNmZTcwbVNldUQwUlk0MXdUTDZGQ3htVCtESDc3MDB6?=
 =?utf-8?B?NUxRZ0M4djRJL0MxM0RXQlVha0g0OEluMzdBeThZd05BTzRVVmJRaWcraGd6?=
 =?utf-8?B?UDk1dnM4c3pTbTNQQ1dKaHQvZ1Zxc2pCZlFFRlEwMUgrUk13ODZwSEVjMllq?=
 =?utf-8?B?dWR1TkZ1MGllaGIxVkZXRDZ6M0RxOERSdE1MTm9kbWZFTHc4ZlUwaXVkRnFm?=
 =?utf-8?B?dUhjVmxJUnhYblRYSTk0djk4MDNRWmJmc2RzamtoYndQK25rWkNockhjTlh4?=
 =?utf-8?B?Ylp4WXlobGttRUFnNm1wZ0FmdWJvSlY2ZDlGaEx2eHl4QkhnZnBOVTJ0TWFx?=
 =?utf-8?B?SHcwKzJwdmNzU01PV0pYYlU2UWxvNDBrUTFtcVRicnFqamttTytwMlN3S0pu?=
 =?utf-8?B?SjdVQ0RQSkxTMytEN3hsVXJCM09TVWN1OVYzcE9sTnNkVElHYmh6Qkc5b2Jt?=
 =?utf-8?B?QXpXSzhmSllOSU9xRzg2V3JRVzlOWG1vcmhMRkdDWVhwNTA5TVVMTFNnTE0x?=
 =?utf-8?B?VEQwZFVxaE4xUWtxclBXdWNRNzNlem9uVGQreTU4bVozV0YvQ0FlN3dSY01T?=
 =?utf-8?B?dGwrU3VzQXB6MksvNDg5ZkNvRndyeDFrVTJHeE55TjY3RFpIdE9RSWF4RUtu?=
 =?utf-8?B?a1NwbTdnczkzZGZrc0FGYkdEclB0SUs3ci9YMUJoS3ZnVk96OUlVdWJVcGVl?=
 =?utf-8?B?WkFzZ3RRb2xaK2JzUW53QmF5SGhRRHFKM2hMU1VXa1MwZXRXTVVUaUltdHJY?=
 =?utf-8?B?d1BKTWJremFoeTJmWEM1KzJBRjlWaStmOUxiWFRYRC9Cdk9qbmpmdVc4RkZX?=
 =?utf-8?B?OFV4TDRuMVJFcTd5aFlPdVFsZTFLNVp6KzQxeTkzckhuZ1VqWXRkb1Z2MWdQ?=
 =?utf-8?B?YTNxWTR0RUdNU252VEc4c0M0WFZZLy9IMkZLcUFhbEJIb0ZPbzg1c3REWFo0?=
 =?utf-8?B?aWx1WGJjRHhDdHFMaWtMTUUvaUZSY2dEZXVPa1BaV1h0VisyZ2dJMm0ybFJo?=
 =?utf-8?B?MjVpUDUyTUdqejBEWWRIZHBtYVBscEhqTW1qaExoTzVlOHVNSHBKNEhCekk3?=
 =?utf-8?B?bWJWbjU0QzUvTnkzWHpvZ3pJWWJXYnlUZlBoYmYvWWxvRzNXWFdnRnlmQXNQ?=
 =?utf-8?B?ZCtuZmxSTml1eGZMUitJZEJ4ZlBzZFAwMkQ3czhXMDJ4SjRwcUxZVkw2WURF?=
 =?utf-8?B?SVBJangwWXZSR3BjWFFtaDZCVlZldVFhSkZ1SzNKYTliV280N1pQdjV6elY0?=
 =?utf-8?B?Ymc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7spefX5PlnMiBJ+VjGMzxUSwRFbkuFjPag9v1fsbGSHJs1vJqELL3P3k4H8Xg7lqJKraGm8fPb6mr3gU/ySfaiLHHyKXuiLRPaQ9URF0wVbTcl8bjAD3pKkpXu6D+onEB6dCny2EToKPHZghrPkYFIeZzl5bUJ68EyRwOP2Dvvx1QxQpdfUd3Tvl3x7l22eNxKCAmtdqk8Pz/FoIJRTM5jdR0kywHCprJ3/ZFV4sETrj3JBYgjZF6ndQ/PR4V4XUMP9cVxjyFdYMh94/VMF0KGtVara2vfYUaykJR34prpk6CFIpxHH/YIxqQgnKvh3hxIvSRwCr6wNVSxMPo7guMumq6W/nil8mVIP1UhnMZpQSsJ73iwNfsemhUgXfDOfj+Ck9eAI2F4f7QNaEYuW0X9xdx3ilcGwm7yiOAlMOMiRsG3ycIG47KCE+xQX+N4hA/dCw9XzlFLaU3pdm3XM/DWHdMTIAmsFNtAfG/e4lggUK2XcWXRuw5TpE3Fnh4j/2jW+juRyTr8MNjK4zK90ZOOMHaYsokXci5eWMwP9pV8ep5U9xny3c5s91AL5oCshqQ0e6zxVjeQ7ikRLvjqNIjO9hz0f0o3VBnczq02j0nU0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5363447-a619-4e11-46be-08dcab285f35
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 15:01:46.6364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YiUbwELihSix8iJop/qYZG+Ng5ptfnBokp7D9QUfZKISvERnWw/5i18JapHS2hqMZ2z9qKKQW+H4aBaZD7Gnqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7514
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_04,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407230105
X-Proofpoint-GUID: BjqQkeMmrHknLa19Zp4WZ5Vg9WzI7Yut
X-Proofpoint-ORIG-GUID: BjqQkeMmrHknLa19Zp4WZ5Vg9WzI7Yut

On 23/07/2024 15:42, Christoph Hellwig wrote:
> On Tue, Jul 23, 2024 at 11:11:28AM +0100, John Garry wrote:
>> I am looking at something like this to implement read-only for those inodes:
> 
> Yikes.  Treating individual inodes in a file systems as read-only
> is about the most confusing and harmful behavior we could do.

That was the suggestion which I was given earlier in this thread.

> 
> Just treat it as any other rocompat feature please an mount the entire
> file system read-only if not supported.
> 
> Or even better let this wait a little, and work with Darrick to work
> on the rextsize > 1 reflіnk patches and just make the thing work.

I'll let Darrick comment on this.

> 
>>> So what about forcealign and RT?
>>
>> Any opinion on this?
> 
> What about forcealign and RT?

In this series version I was mounting the whole FS as RO if 
XFS_FEAT_FORCEALIGN and XFS_FEAT_REFLINK was found in the SB. And so 
very different to how I was going to individual treat inodes which 
happen to be forcealign and reflink, above.

So I was asking guidance when whether that approach (for RT and 
forcealign) is sound.



