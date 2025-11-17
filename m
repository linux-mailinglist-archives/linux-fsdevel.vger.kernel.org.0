Return-Path: <linux-fsdevel+bounces-68749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 855C4C64FD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 16:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 9080C28A14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 15:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCC829BDBA;
	Mon, 17 Nov 2025 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H9MxHYmv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E/5NG7rq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442BD27511A;
	Mon, 17 Nov 2025 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763394946; cv=fail; b=Q3eaKFECFtskfzYfLnmRcht6N+SM5Le3IhnljoKXtXp5cjo7pwKRD9yvC99gvO5/15cGkuMUpVK1BJ+N3QVr/tKgvOF/lSFUGX2JNWZvHvxxM2JW6h1ltLU4I4hdNe1JbOn69EY4CoZaCde7O+MtxpwFKjPbMfaQCzFgvaFihts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763394946; c=relaxed/simple;
	bh=uckDxrlISIh1hI7MkHaVSUkvjyVsqDcU89Xklqtt3Hk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pw1egLoTaefaoUj0mQoH6wWFfoHC0B8VmdWR9m0JOLqmxQcReu5PZzucQ4iOP4eFVIUydS/QAnZpLUb2AVacCNj/eYmIcUNdhGhn8wkcLTj4h1/y2mQOvfTRu3tJmBi8Pn+TxBoRwtUQsErM/D0No2KhOq6+ce6ozDo4te2ZWfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H9MxHYmv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E/5NG7rq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHC8KVi024550;
	Mon, 17 Nov 2025 15:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NcbaAB+YrWf3ujOkjwGqJKXF6JZj8Gr+lNFjpEbUKUc=; b=
	H9MxHYmvX2GpBYowVueFDKjI4VxM471IRkJ6roFIW8Yx+tJDX9jR+KMutOU7uX3T
	tgwkISwORK3QD18uO4dIbdrIoImTKfLoktPaChHJjr2CfUZ8ZE9mKxAdkUVZPoEF
	8RirPg4PXeztrlnVJpN+FjnGGI2c85xZlnIRVwtFJSkZUyv+0LUu2qsRUkA91WDO
	X4wI56OEMm2hbshF4y3yAvV0ZAkLbF5knQeqv/6Lp37TrMlja8hGYgO6M/36ka+I
	P4MFgn3QrpywlXqEVV2dSaXJ5+OZ9PnnWSzpbStAKEr0VmH5QWWbE9qQzclsNpqj
	iVfYwVWwkskbjHQeANf3NQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbbatnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 15:55:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHFhHC0004483;
	Mon, 17 Nov 2025 15:55:32 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010024.outbound.protection.outlook.com [52.101.46.24])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefy7kshy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 15:55:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtMCPFofRiZp1EeFe0bv34Nm+h0//VR0+YlgFlbIk3s3cR/A2UOcqHCGAXQo+dH8AkXVEgOADVUuVUJobG+zFtxwCJdiHAivkN3iCZ7uqZgQCZYuBSy51R4/0Fyp7t84MYj1ibsw/N80Lzv3Srdu9W2BuSldLUZzrDNxsSRVv0bZYZ8xzerpPeuXBFtLzhCrv4F1Nw+//FhrJjzm1x2EPXqS4fx1aiG9qBTKqItA8P4ixm4UnpQlLKDq619erCVQo1vkusZCFmcI0UGZk0taH9lUdUS6plndu0sbTNUQVHothlKTr/rLY3d+6Wp+7lAgm2JRVpa3x2RyHdBHkBfXCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcbaAB+YrWf3ujOkjwGqJKXF6JZj8Gr+lNFjpEbUKUc=;
 b=cguulX6V/m+znH+FobY0MlUILvWpu9EsHbQQ+iOhG4usQsgIJkTW1tNY1UmpPDyDj7hZ3jPOyI7iceK7vQ4ty+kLg18lXoFe28CNJIcwPG9M2eqksNkzhVhW5OetpX6rsHNlo2X5zn5C729LJE29ZDc84OjrcXInI6SM51JJ+1GUoEfnrhlTshqe7btl/U1lPSuKAdkM2V/nkjutGYzBdW3ecbHBcouinyp45h7w/V82DdmugTytBJZCA5apZgaGQ2d8NCp61Ki6fnj3QHy4xmSyPS3DP9jCC8rtPaX1UcNXAGO8pxATeEm1BdY6yDcBWJODpYZDx/VSGJ4ab/CREA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcbaAB+YrWf3ujOkjwGqJKXF6JZj8Gr+lNFjpEbUKUc=;
 b=E/5NG7rqsVzcI4lk6/a4m82Hf6aJh/9uRnCubGhxcMWAHQ5h63Bz0lbNOYijhgjUZgC41834AF3MAGUf1ujeuW6Ssrq22Uwyh8WsXsosq6q6wn2TyVdZzUG49oiAk0E/idTrV9FEVxn1ZuDDWEpZZ6qgSH4sHCbqoBaZdyMC3NQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS4PR10MB997574.namprd10.prod.outlook.com (2603:10b6:8:31f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 15:55:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Mon, 17 Nov 2025
 15:55:29 +0000
Message-ID: <d7888dd6-c238-45e0-94c0-ac82fb90d6b6@oracle.com>
Date: Mon, 17 Nov 2025 10:55:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] FSD: Fix NFS server hang when there are multiple
 layout conflicts
To: Dai Ngo <dai.ngo@oracle.com>, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251115191722.3739234-1-dai.ngo@oracle.com>
 <20251115191722.3739234-4-dai.ngo@oracle.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251115191722.3739234-4-dai.ngo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0013.namprd12.prod.outlook.com
 (2603:10b6:610:57::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS4PR10MB997574:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b0d05fc-4054-4771-afa6-08de25f1bb24
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Tno3eGJReldDQ3g5ZGNmM3lFUWtFY2VTbXlmRnVxTkVIVldCb2tDa0VKSHpa?=
 =?utf-8?B?Y1NJbjdXZlV3ZVdjTlRhWWdzVDBlVW94QmttcmRIRVZ4OHNseWx5dTJJRDVh?=
 =?utf-8?B?VE5OczR0Zkh5TmtQd2dIbW5JM3NleFdQTWJrdHVZUWZvclBneDUzbmxwWTI3?=
 =?utf-8?B?dzFKOGRQVHpsZll6OEc3VUJ5dWIxT2JlQ05wdWVpRXZkbUpXR1V3UEhiSER1?=
 =?utf-8?B?Tmt2N2o1UFUwTjNJanhvL1A1ZVNBSFprN1VzYWxjOGZBUWNDMkNqWktLVmFB?=
 =?utf-8?B?L1J0N0lxc2JYc2VGMENnS2RzRGl1clRSSXZ0bCt3TnhaOW0rMTZqUUQ0K1JM?=
 =?utf-8?B?NlozZ0p2Z1hBeEs1K2YxbXVCRkM1VkpxWmRoZlJYNHppU0lZWWpwV080TUM1?=
 =?utf-8?B?T1ZnMTlKcUhJWGZGUVN2RWdKeXY0SE1yMHBTV0JYU2paQll1M3NRSmpMaUVa?=
 =?utf-8?B?S1M0VlB5Nk52TjFnWlcrU2NXNVJSSlhCek5pUDZ5L0w5YmpnVy9URnJ6OGdC?=
 =?utf-8?B?dUF6ZGZLQ29xMFFYWUQ3Nng4cFR3Wkc4VDJiRGtuUTc2eVZ0YnBabk9iSTV5?=
 =?utf-8?B?aXl0VzBMU21kT3FYM253WHRPSWR6UW1mV285KzNoNEhhRW56MHFySk1PREJj?=
 =?utf-8?B?dVdqRUpWeWtoNHJHTXRGWjZHaDFvNHc0SVkzeXBzK3M0ZUVSSzh0VXp2QTV2?=
 =?utf-8?B?bXVNZHJJWVdydnRtQWIxaDVJN3R5UXMrV29WMVBEeS9DUGZ4RmkrQ0pGdVVG?=
 =?utf-8?B?amNxVkxBQ3ppdCs4RVBIaGlpVmZ1eHB4TjdwbHl6T1NTQVQ0eDM1bkVtbG5G?=
 =?utf-8?B?K1BpRGxSaGNGTDNnTlZkQVVBNVIxclFoOWZyYjUrd2dVdWw4Z3l4ZHBPb0Zt?=
 =?utf-8?B?aTRBWTBNajMxbnZ0SDgvaEV5dWg4VzFHVFMrSERnNnpQZlk5L3JXVVA4SkFo?=
 =?utf-8?B?WHhybFNRaFVoWnRlN1F4a1pJSmpsbHhDSXUvVEFCMDUvUjRPUWEzbkt4VnFr?=
 =?utf-8?B?SkxqUnNDb0llUTFwdVpnM1pYVXlrMHk3UEJUOHhzRDJoQXJjSkFIU3JDVW92?=
 =?utf-8?B?NjhCMktWM3J3RHRrYUR3bXd5MWZkMDdVS0RyRDhNMTJTYmNWSlJjbDdiR3N4?=
 =?utf-8?B?aUtWSnJVMzNnSXBEYzZITjExYzVRbHJ4NUlaR1BUeFBIUU5tRWxTNkk1eEhN?=
 =?utf-8?B?NmxQQ3ptRDFVY2RrcEFaWis5R3lXbWZCaDZJSHVuZHVHZ00yS0FOL1hHNlB6?=
 =?utf-8?B?MDMydVBIaStYQUZOMVl4aTUrdjNmUzBsRFNIUDV5L29kek1oWXUzL0ZybHAw?=
 =?utf-8?B?U1JXQmxTclJLaWk5L3pBcjg1M3VpdmtGWnduYWk3R0FGWlpwUTFPaWVUS25E?=
 =?utf-8?B?d05jckFJSXhTeXNuWStzNzBkcll4TWMrOEVkQTBZak8yWDEwSFBhaEg4S0FX?=
 =?utf-8?B?ekx5R2FvZG5UMXVQL3dtM2ZPQWVDcC9xYm12andPT3owZHQ0VlJZc1pUTXdI?=
 =?utf-8?B?UG8rNXc5aW9SYmx6U2VvZS9hVGcwcXVKcUtYUzdUQ1JWZVp1UWVsY01yMnlX?=
 =?utf-8?B?ZDFuMEJMam9oUVVSVFNzeEdoVkduRmMxSWszc3JqMnBHTGpaUzdFR0Vna01a?=
 =?utf-8?B?OFc3Qzg1VG96aXJJZTJmQlBvRkJIbjZTNVpEVmJLdEtoRHZIbUpKZml6c1J3?=
 =?utf-8?B?citrcXhYbFhmbzNxWDc5S0JWci9Vc1RjOFJJYjRIbDhib3grNHN1eDkzdjlX?=
 =?utf-8?B?RjZYS05IVXVkL2ovZWl3aGpqYVlva2pmVGZ1U0tmQmJVK0F5dDYwZWxiaCtG?=
 =?utf-8?B?dlhwMjQrR2F1QUU3SkpTZzMxOCt6MEV0QnJscVBiWEhTYWJXZU1ldTNDbzhv?=
 =?utf-8?B?VlBOTTVxcVlWTjZJeUFFRjd5WkowWEE1V1d4T0VLcWZtSTFKeG9ld2tNZVNz?=
 =?utf-8?B?NDJlNHdzTnZzZGorYUpIalpIQXFwSmZoQUhOVm5LQVVFSnpTUFhjR0FBY280?=
 =?utf-8?Q?mrv+99C6ICPhzeZGAzIB4NJNLCApn4=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WjNFaFB6U1FsRlQwMUZ1SXl6ZW1lNVI0TmdhU1F1OWVJWEQ0MXllbkwyZjJm?=
 =?utf-8?B?dlNubTkxVmxWNjZra1dsa0pTMWZJc1FCY3RhaWhUa3d4OHA2dnh4REx4RDIr?=
 =?utf-8?B?Wm5KcXRlN2lHczZ6L2J5Tm1MTm0xeHQvRlQ0c2NtN0VEcEdoOHhMZFVpYU1Y?=
 =?utf-8?B?M01GL0UwckhtYm4yUlVFNDB0UFJZeUhaakcwWDBHblpTRkxrK0ZyTW5IZGJt?=
 =?utf-8?B?VzVmOVpFaHgza1BDUzVCYVFKT05wQy9peDhNNGJ5Vm4xeTNoaWVqTTNROUJV?=
 =?utf-8?B?bXl2aHhGYkN1QitSaklzeWxJaXIrbkMxTDJkNnYvbjhDbkZFbVRXNkMyNUIv?=
 =?utf-8?B?eGlMT1RZaW1UTUUxQ2hINGFnZTRZRU9HOXgvais5SjIwczRvdkRkRktGanpa?=
 =?utf-8?B?Zk5DWHNYRjBydW9vNEFIL2tFUU9yREZPM1VnN2ZmSkJScUh5U0FmUVExbzI3?=
 =?utf-8?B?KzB2dVhjNFBLTFFCbW9RM21LVTdkSW9CMjUyWGNWVGNsdDdFWkc3Y1VjaVQv?=
 =?utf-8?B?eFg1c3lic3ZzeG9uQTV6YWJOWnROMWZOeWZrQ3V1U2MycEE1dnoxaEl0SXJq?=
 =?utf-8?B?K3dIdWQxM1JtZStFSWsvSjNDYlVuVGVYZkY3c29VSTg2SXo3d3ZQa0RtRFU0?=
 =?utf-8?B?ZkZYSXE0Tk5nM0tIWVJidHRpQ2FJUVp0YWVyT09kTUdRZzZzQ2xVVXZKeGhN?=
 =?utf-8?B?blBEZTZnNStrQUkxYU1CdlJOdnpETHJDcnNxck5ESDlwU3VVdExMbXhZbTZt?=
 =?utf-8?B?OU4wZi9rTGliNW9FSWRDOGhER3BneE5Mc01QbzNKL0NmcVF3ejFtOFBINCsz?=
 =?utf-8?B?aWV0TzdMNzc3SUtGT2ZtcWhTQnhEZHlaYTBMdDBYM3lxamVKa0ZUVC9RZGlY?=
 =?utf-8?B?S2RTUUI3dG1hMkdXbUdPK1Y2M0lzVDlLenlkeFgxNUZ5U255d2NJUC8wZGtt?=
 =?utf-8?B?UFFSZDdtQ1o0UTBPSGNqa1B5akllZlp4S204UG9GQVpPU3NJaER0eDh6N245?=
 =?utf-8?B?RnhjZUFFN3BJZDY0MHVlajZpUGZWUGp2Ly9zSUxXbXd4T3lFVjNiZGxZbTZr?=
 =?utf-8?B?dUdZQWExR1p3NGd0WTZaZHNJL290UVBUMzZ3SU9mR1FOcDJFdUF3MGpEakhx?=
 =?utf-8?B?NHJRTnBMeVFYc29Ed1hMOVJXOThvRXcwNk5ieW1NNExWaWRrLzR4WGdnRlZB?=
 =?utf-8?B?Y2JRYVdDWVNOdUtmaHFFU3Bvc2xpcm1UMG9DcmFxdjZKMHpBeWRQM3YzN3I4?=
 =?utf-8?B?VDBVNi9ML3FxMFhiaWJWYjRiTDh0WmlBYlBMcUJ3VWFUeVM1UmlQQ21pTHMy?=
 =?utf-8?B?MHUzR21mTkhyVnJXcEZmMzVscTRGdW5kdkZTeWd4dURjZldnbzhmRkM1dE1D?=
 =?utf-8?B?NEZHOUVheTVUM0xjNTV6VW9RR1hNeitWdkgyOHQyd2pOY0RsLzh5MFlMNE5a?=
 =?utf-8?B?SUduMCtRdE5kWmFOdnVDNGR1dkVNMEZhOGVTRjdlbVpGcEZpZ3Q5SGZvQVg3?=
 =?utf-8?B?R0p6TnNuK1FRV2ZLMGM3VjZVaHdBRGhyOWthdEhWT1hSUlZyUkgxZTlEZXZC?=
 =?utf-8?B?eGNGQ2FsWTZTM1gzdmxSWWNBWWJKY2JKNG1JU3dQK0dYV2FMZklWWFVwWUhN?=
 =?utf-8?B?MWZqWFFUaUV3MWRuNXByRXFqNXlULzZ1OXVUMS8yL1hRQUx0OGVPM2d3VHlR?=
 =?utf-8?B?clBCR3BwaUZaL2NIYy80azZXSGM0SHh5bG8xQ3FFNENXaFU3b2IydzdJdmFo?=
 =?utf-8?B?YzJpRjJsUDJNV1c5MVFHT3hYTzZUUFNGQ1FHK0pIME9FdUlsR3BYZTZNRFhF?=
 =?utf-8?B?RTRwdndwWFhVQkZUbTFHSjRVbmJUb1hFbDBDbmFTME10MlJrcXROWEJJOEdP?=
 =?utf-8?B?UUtMWStUaW0vU1huZHFlK0VvOTF5UlZZTlIvTGN0TDJPU0pSS1N4NmtzaCtE?=
 =?utf-8?B?SnpwRmVIdmpHdG9OWC9WVC9jZXdadTQrWmM4cnlXZGJCTjBLNFJ3cVZiTW8r?=
 =?utf-8?B?RUh5ZkRock1vQW1jbklQZnhuenlXbFlKdjZpUE5KUVQveDVndTdSbFBLWWsw?=
 =?utf-8?B?Q0pXV01oMEFmbC84MUtSOS9uSUI5UFIyYStHVEx1dWRvbEFLcmRIaEExTHlR?=
 =?utf-8?B?clEyekV0RW5VS0luSlN1L2g0RURicXZYZ3VLZC81WUJNbmZLM01na0tPNW5E?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vPma813TNf4pWl7r3YmA5U3ufUiK9H/zC8XZKpUllMIxZa3h9gDmQAGi3UGwjMQHqxE+vuTRZTPKZQ/7KPiyvZO9eHVIsOLUnpouL86+pGCXq41YDdCPonNHQ3uUQTvrJxenspiIgUR3uvNjZA6m4TmnpBEoNmrxuSkxUcpFH+50y76GEieeJ2/OQ/rlbl5B09IXTGRU1SW8y1AHV55QyEhfdTLlB64hScy2SlJqvEQnjKI/9Stk35fD22JB+p5YVR0i+ovPrxN+w3/HygK6Tp/fEivMhp1HAS/PkrsnDasnHXKqjOidstE7WdKF3I17zqwV1aouW46vHuIAZ59Ax1d209SjKpoC3e5dCAdd+piLecPmGMWMJMFyg4uTKlZgjmHwzdnFVWzV8vZKaKKxpDauRtNKNDf2hNv0+A8TqnKNmSEOiaVgXITXyS4UGN2CgnkAlyKZkh7554j/2+u0tnLPxAg01MZN+pRhbP2Pq1IrHzKuAkAG1RW7a143PORKhqWbLOvJq2r55YY65BPlNQDADP+IF0KYcBkc4rUoHYReegzzaJyEzte3c64yksy6bXRduOEIiw3qz3P4CcvBYRbbNc6ZWpNQ2my/x8QDcMU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0d05fc-4054-4771-afa6-08de25f1bb24
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 15:55:29.1935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJ2FTs1akgF0fkMV9MzK/1SbjJhwX3CvGFB7WXgN7eBPH3lSMRBHSfDjjHmZtvBRPN0filTpxfSe8D7kn0ddKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997574
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511170135
X-Authority-Analysis: v=2.4 cv=BoqQAIX5 c=1 sm=1 tr=0 ts=691b4575 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=r9cOgU2EYyfvrnwEppoA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: OD_lyy2H3iMXdXC3dQsUXSx_E7bSie70
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX4B+v3IoOY+n1
 ygocL4U7UFGtHfetl6pc4tYsZGHCA4xuwsrW02KDQCCV08+qOt7oxwVUb94E/bIsDWIGump1xpG
 gM4vFKryw+aFQY/bUAVWq8GJf6y3X5gXQgTADJcbW9JqDYaO4EB5iN4Yk+5vi2ANRbKlwNqvOXT
 CKh/GmmE2j2+jDjonoIvlBLaDXCEdoacjnCg3TNn78wpL6ufHsydPlVplKy02RT8Ml/rklF/lXe
 TxQGXa/Xhq4dGbjEQQhLw+YB3SBZVndW6NUxLbu2qsE/v/1X6FFpofHHAuCb24OqgP4IwFHcQJX
 7tIAfW3TBfvfiveU9nXflyIrIihsRChxUY+HEyPG0fVYfFlGV/TBSI/u+0j6SIfjBpNSRgxgyJW
 9NtgelWcOvq2llMZ2kQfWyj8ju/cHA==
X-Proofpoint-GUID: OD_lyy2H3iMXdXC3dQsUXSx_E7bSie70

On 11/15/25 2:16 PM, Dai Ngo wrote:
> When a layout conflict triggers a call to __break_lease, the function
> nfsd4_layout_lm_break clears the fl_break_time timeout before sending
> the CB_LAYOUTRECALL. As a result, __break_lease repeatedly restarts
> its loop, waiting indefinitely for the conflicting file lease to be
> released.
> 
> If the number of lease conflicts matches the number of NFSD threads
> (which defaults to 8), all available NFSD threads become occupied.
> Consequently, there are no threads left to handle incoming requests
> or callback replies, leading to a total hang of the NFSD server.
> 
> This issue is reliably reproducible by running the Git test suite
> on a configuration using the SCSI layout.
> 
> This patch addresses the problem by using the break lease timeout
> and ensures that the unresponsive client is fenced, preventing it
> from accessing the data server directly.

This text is a bit misleading. The client is responsive; it's the server
that has no threads to handle the client's LAYOUTRETURN.


> Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4layouts.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index 683bd1130afe..6321fc187825 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -747,11 +747,10 @@ static bool
>  nfsd4_layout_lm_break(struct file_lease *fl)
>  {
>  	/*
> -	 * We don't want the locks code to timeout the lease for us;
> -	 * we'll remove it ourself if a layout isn't returned
> -	 * in time:
> +	 * Enforce break lease timeout to prevent starvation of
> +	 * NFSD threads in __break_lease that causes server to
> +	 * hang.
>  	 */
> -	fl->fl_break_time = 0;
>  	nfsd4_recall_file_layout(fl->c.flc_owner);
>  	return false;
>  }
> @@ -764,9 +763,28 @@ nfsd4_layout_lm_change(struct file_lease *onlist, int arg,
>  	return lease_modify(onlist, arg, dispose);
>  }
>  
> +static void
> +nfsd_layout_breaker_timedout(struct file_lease *fl)
> +{
> +	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
> +	struct nfsd_file *nf;
> +
> +	rcu_read_lock();
> +	nf = nfsd_file_get(ls->ls_file);
> +	rcu_read_unlock();
> +	if (nf) {
> +		u32 type = ls->ls_layout_type;
> +
> +		if (nfsd4_layout_ops[type]->fence_client)
> +			nfsd4_layout_ops[type]->fence_client(ls, nf);

If a .fence_client callback is optional for a layout to provide,
timeouts for such layout types won't trigger any fencing action. I'm not
certain yet that's good behavior.


> +		nfsd_file_put(nf);
> +	}
> +}
> +
>  static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
>  	.lm_break	= nfsd4_layout_lm_break,
>  	.lm_change	= nfsd4_layout_lm_change,
> +	.lm_breaker_timedout	= nfsd_layout_breaker_timedout,
>  };
>  
>  int

Since this patch appears to be the first (and only) caller for
.lm_breaker_timedout, consider squashing patches 1/3 and 3/3
together.

I'm still not entirely convinced of this approach. It's subtle, and
therefore will tend to be brittle and hard to maintain. Perhaps it
just needs better internal documentation.


-- 
Chuck Lever

