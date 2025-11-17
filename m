Return-Path: <linux-fsdevel+bounces-68747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5D4C64F38
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 16:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09A9E4E60DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 15:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4745A292936;
	Mon, 17 Nov 2025 15:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cGSe19gu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uPSUMNcV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C758428D83D;
	Mon, 17 Nov 2025 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763394450; cv=fail; b=CyMSkUZBBYqYE3taGRvBUijNyWWz2B9lahaCwmrCsD1t0hSixq9mo6mvmrB7sWpmuSaKLz/5EqxdGXMAniYxgUe1HcWIUAPY2zZ98LqdunxCs23hABksQr0GCyifklg/qYs++wtNJDEceTPlQ8gU4YVOaViJLVKTQceG7k7Bj8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763394450; c=relaxed/simple;
	bh=uXCPFl6qJB+gQil3LYRGiGsrHJXQmikNtCsq9TyYZoE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jpSy1iI0e+aGw8JZxcJ0z3XtEJaGAMyrdWiSib/ICMtbWT/03miqKGnR3hVq3yjZrWpzJCA92Uq6g342sZwW+PRG7tgkqdkuz54H0OYSrzonJMoBpSdDV1An4goC0xOUymDOpvQMcIbMCFv8uujNZNgiBlNXcUTtSsZZxQOaY1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cGSe19gu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uPSUMNcV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHC9CWA019471;
	Mon, 17 Nov 2025 15:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QtbACVEGdKFq3AO3n9cd9fPoeAktWSPKDFF6swiHw8I=; b=
	cGSe19gu51UqMQnxTWEaYTwEeP875jvi9fL+E8d2KD8snmcYPgARB877Tdteomoe
	kOCvGZjT6sRQB+W/8aToagMFIf5FoLCncAFO/xNQROEsOPkBKi+pbDI0800qtKLA
	PsedtCr5tmiGlHHZiccnqv0JxlvHrwdSNuoEbZjIETfCtGNEY09AXKPCacT5iphh
	FYxfYMMgIsAnMFqC34VzU9fcMVv2mS6CKuOBLvl24HWRebeBwJPqK6oRef3pn6Fw
	qNnjXnH75cVUMTZCPiMdPRBYu+SxrRXc6Ve8vbJpjDEdwGAREiRFQfP6FIx0uQoB
	1c8rmETMlV5HyP/wd5WTMw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbptqb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 15:47:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHFDfFR039810;
	Mon, 17 Nov 2025 15:47:12 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013052.outbound.protection.outlook.com [40.93.201.52])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyj55dv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 15:47:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoOsAv16T0z3VL252B9SI1Cl2o3Zsa80M/m7+thh1eto48SqDAP/Q25heEwjKwGDgsA5+wzIwf7GeqMw/ELHBMtg7aeL99lnfisLMVGRCJcEtvA+TM4ZawXseypneL+oJxMefcfqRMO+pFS1ocV9ar64wRL2N5ygwOsxlqi9RqxVsglgZqd26UubObzTqzeugsdt4d1cmqNQZNDQr+anKOSXFDhOcJecHJPty8e107d7B79QQboLsUTJeKKk7uv5QziH+LiPFwEIHFh3A6wWL2wFjRQv70Z4dztu9Ad8sdqc8Oxf4FZherHrLf+KfmJcaRT3FzrFmmDoZhsgZ1ZmQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtbACVEGdKFq3AO3n9cd9fPoeAktWSPKDFF6swiHw8I=;
 b=Up0mOncCDNlRqu6TMj7zML4xWnWnzP06zOtQZqoCLgiFPiVgXgMgmtuzIrtua7YZYkXMFLWnG+E8Hthr0a5RFpHg8XXNVWoJqKpJ4Xzdj9P8Fc9UAMBi3br9BCeA6DB6qEIGHXvY+lYzfgD/fRaNpqFVBax5Auk2y+M3tlA19DAlPhLtZhW61Of1iZkscErutbnSlAHTnmb0AUnXVDv4bmQXlgxT+Jc3zpiN1FNHlblbj0mZExa/yWAS/OlA5ZgBeYhre8f3PMHhM3cKdEw4tIuMl6aelhJ1hcxokBB/Wk2WLmNdtyOZ8PlcCYFc+ro3eOadupQF7xnuO2l4NmAqzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtbACVEGdKFq3AO3n9cd9fPoeAktWSPKDFF6swiHw8I=;
 b=uPSUMNcV/qku1cybqqlJC9HjBL50Kn6/CnYFvRmuFZp5fdQbhDJxFY9/nCEgDzYlkjyFsT2/N/ekq9mQgtdG5yOn6ptJJBjVvGKiBGRLo8QBv232JRSUfFYFqo+RgK11O4qk1EoBaRksl+FViuxEFW90RRNaMewd+40QKOgHnCs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6125.namprd10.prod.outlook.com (2603:10b6:8:c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 15:47:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Mon, 17 Nov 2025
 15:47:08 +0000
Message-ID: <9cb3fc1f-af86-4a55-8345-09dc294bcd07@oracle.com>
Date: Mon, 17 Nov 2025 10:47:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] locks: Threads with layout conflict must wait
 until client was fenced.
To: Dai Ngo <dai.ngo@oracle.com>, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251115191722.3739234-1-dai.ngo@oracle.com>
 <20251115191722.3739234-3-dai.ngo@oracle.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251115191722.3739234-3-dai.ngo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:610:76::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: 951c0fa9-a890-46be-ff5e-08de25f090fe
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?OWY5dnZvV2Y3KzhJeVA5NFFucUYxOEFUbEdjOEJyYTZVc2dvQ01GeDNQWXZT?=
 =?utf-8?B?WEpwbmdQQ1FDSGZYYlJ4eXQrdHVGeXlSNFl4TnlKZVh2Mm5ZMXV4eHU1ekV2?=
 =?utf-8?B?aFBLallQdjNHdTNNODJnOFJzN2tkenpsMDNzZFpzYUZFS1k4ek9keFc1ZzA1?=
 =?utf-8?B?VTVLdW9WS0FBYjRvcXRiMUhDeFdHUFkrWVdVby92bVhyYW5vd0h4R3Byb29J?=
 =?utf-8?B?Q1NaRjZhQUlaQjFZSGVMSExsYXBVYUJ3TURvQUlnLzNEVC9ZYjc1VGZYVUh0?=
 =?utf-8?B?bGpwZUVYNnU5eCt5ZTVML3BENjYwM2RpS0tKRFY5eFhTVUlEUVp4bGJXeXlJ?=
 =?utf-8?B?NkE2WEFlTDY2MlZVUFpWNEMya2crUHhqZkxDUkRIekpNTFJDYVFjV3pYYUl5?=
 =?utf-8?B?RjdvUm1ZMTJabG1EMmFoMVVRQ0hHUlY0ZloyZ2lyL0ZscC9ZWkxtSDQrYStP?=
 =?utf-8?B?TXJxNmZ1TEZRWStTcXB2cFN0SVhmK2V4cG90elEvNmhsb3FiUU81WnhSeUhj?=
 =?utf-8?B?TGllOWdvR1BCbEg3T2I4M3JnYlpxa3RvSk0wZmFmQzZ5ekx2YjdPbm8xZER2?=
 =?utf-8?B?dmxDQkJENGtYVzZsUXd3eUluWUVUTWJ2NTJUanQxdFpWWlltUGFiNlVhZFBE?=
 =?utf-8?B?MjV5MTZ5QkdwRWdvck9KTS9TUG5EZVJ6bUloTmtLeVovRGJmQ1dHNXpmSldu?=
 =?utf-8?B?VTZjY3FCNTh5NDN3SjZXcGp3QXhUYWZqZWhzc2JwcXhDWmJYSzluZWl0KytP?=
 =?utf-8?B?VjIxSGZXcHJsNkxoTTBpYXkzN0FtR3ZJK05iU0NDTTlUMFhlclVoZFh0cEhr?=
 =?utf-8?B?L1dORjFBMGJrS2JzeDRtM1EwOXgzcmxKc3hyTUR2RncvMHpjTC92cWVtNVZh?=
 =?utf-8?B?Um5LSVBDUmtxbFAyNlJncWdzRklBWGFkaFQ2U2tMK3E2em94UWRPd3JOREVQ?=
 =?utf-8?B?U0ptSkt3eGlJaWhZVG9UaVpzMDljbzcyeXE5WXByS2dsZUJxOUZWME9hREFi?=
 =?utf-8?B?WFhQT0tFK1NiV1ZTdytsR1dBZ0J5VmZLZ1htZlo3QnRpdmVqWEZSLytZQjZT?=
 =?utf-8?B?U3RPdzJjajMvOE43d3dnVU5KQitLck1EYTJkQWdmb2VaUlN4VEM0bXU1cU5p?=
 =?utf-8?B?Y0FQODQzc05kK09QeGI5cjlNaXZ2VStoS3g5dmxHR2haSzBqSnY1elBqRzYv?=
 =?utf-8?B?U3pqbDQ1eFc5NVA5NitZemgyREZHLzN5bkJ5RUJWcHduNGh0Qm9PRmhKTVJJ?=
 =?utf-8?B?N04rS1ptUy9hY3A1ZXdOL241K2t0OHdtWFRZMERXQlBBY0xSb0JjOXFGTi9R?=
 =?utf-8?B?Rmk5N29yN0hlam91VDdMSkxadUk2cVlacHNjeU44NkFqM3kwRnc2V2JEemt4?=
 =?utf-8?B?cTFBMHFTajdWUlhPM3FaUWRrSHQyNklHWnFqbncyTkhyUU5CYkRrcTJuQTJt?=
 =?utf-8?B?NXUwaXpFeGovbmJxU2xvQkJwNVUrMFl5LzlnangwTU5pWnRQa0RkclAvNzlI?=
 =?utf-8?B?WW5DMVJqZndIZXhvdkJYQ29NcmkxNEtvdlRTM3ZqaHBBWU02aVFzcGxsaml0?=
 =?utf-8?B?bDltSVNIWWI2N2R0V1lmQ2haNzBjRjRYSVhTdlRWUW9aWlVBWUtSbkpaZW5i?=
 =?utf-8?B?emhwNEZ0TTI2Vk02elRwcTE4dURCazNRcmlXU0p6NXl6MlBhQUx4MTFPRE50?=
 =?utf-8?B?Wlp5d2oxbTk1VFY4L3kwUGpqdkNSOVNRdzJwTXprUFdrQzJZVVpRSlplSDRN?=
 =?utf-8?B?bk5QRWhHb3VMdWdQNWM1NjY2d0pnenpNUldFZDc5RSt4bWFScjFHd2VRWXFT?=
 =?utf-8?B?M2pKRjd1S3dBdllYTElSekpZZW8xT1Q0amVkMjFOeWkwNzlWOTFvNHNGZ3Bk?=
 =?utf-8?B?SDBMYWVQSENRMUU4U1VQZWVTYkhpMXZoRWYyeVYrZEhraDJVK1ltSi9zT09y?=
 =?utf-8?B?YkU5UkJZbmJLWEJpUG1RejlTZEdaNWNBcXBSV2FnZU1nemVwWitnSTcwM0JZ?=
 =?utf-8?Q?6328JonMgtnfVUa6SnwUvJxn6YEnvI=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VURrMXNyYUhBUkI4dW5pUDJheG1Od3VSUUZtMXY3bW5rUFo1UTk2VUFuQWk4?=
 =?utf-8?B?enRuYWpDTFF1WldqbGJXSi91QzYrc3N4cHhIbC9TcWJubHJLZzF3YU45NXA1?=
 =?utf-8?B?L2kvT1FiSW9zYkp2SzhMMnlZclFDSnBJVVlPUUluUlFpSXUwSFZlREdaam9P?=
 =?utf-8?B?OSt4Y2dyR2lqUkp3em5FQmtMemdSRVdldHFiZVk5cXpuSVpmM0lqNlJ1d3dY?=
 =?utf-8?B?VzhmN3lLQWJrRUNqbElXU3JjYnJSOFA1cjhuUndIeGVVNVZqcUN3NXZFMEFi?=
 =?utf-8?B?ZHRNaWNYQWM3UG11N2w5aEFSdVJ2OHZjQWVyaFo1U3NxY2M5Uit5TFJjdGRy?=
 =?utf-8?B?OVhERU10NWNWeXMyREpCWlRFMFlOQ3VCZlEvY3RYZ2FhTy9LazI4RUdsWkl0?=
 =?utf-8?B?bEMwbGo0cFNhNllJZTdXcjZmb3Mrbm5vWVlxUVVrTXlhaW43c1pZNDFVeWxm?=
 =?utf-8?B?K2VwSDlNcnJjSXg4NmRVQkZxZDgxV3JFTDYyS2NiM2VkV2xTYVBsR3lxS1hl?=
 =?utf-8?B?V0VNd2ZyRDAxYUlCQzg3Wm9acHJ6ejJBeVdsZnNMamRvaSswRkN0UVBjZlBX?=
 =?utf-8?B?R3RzZXNUUEFhNU5qejZSTldFODFOaXpLd0lwZ2t4M1loQ1Y5WHd5RWxTbzBU?=
 =?utf-8?B?T29iL2lab1FGbEw0RW4yTVpLVldmSGpZQURGVUd2ZFFodElHUzRHOTFtYnM1?=
 =?utf-8?B?bUtwcXdJejRqdno4dkI5cWVJeFU0aFVGMjVHTHYrVC92UEk4cEV3clg1Wndt?=
 =?utf-8?B?OWpnay93Z3E3NlZPT3BHcy9pbi9uS0pxN296TlJ0Tk1yeDdZQUgzdDlYaUNB?=
 =?utf-8?B?OUFKUGNyNkwrUlIyYVlvalB2ZUhEV0UzVHlyS1J0d1pMdFd5MGVSZ3hHak5i?=
 =?utf-8?B?U0ZiVUtFRFI0Wm1FZGN4Rzh0QjhoZjU2M3l5R3ZOZm0rYncyRXk5dHFoRktC?=
 =?utf-8?B?SmZSMUNpTks4V2ttbFhKcHJ5S0ZHc0tGQTNjempKZ01kSGlCNFRLY2JOcmNv?=
 =?utf-8?B?bXR0bDR0M2F3RW5CU0xEQjVSYlRrNm44cVZwVnNIcDNteTlhc245MENBa2p5?=
 =?utf-8?B?ZlZYR09MOXJ1Y3N0T2g4K2p1dlZRU1EyU1g0clluaW0xeXpObUlwbHNpS21Q?=
 =?utf-8?B?a3dGQnd6RjZEeGc5UnBUR2trNjhHNzNPWTJwazE2cUhGMmhwcUJnSkJsSUMz?=
 =?utf-8?B?aEFoQm1VVWErcC9NY1l5VHRRNXFPbG82WHJoeFpTbWQyQUdTM0RGVUtidVg3?=
 =?utf-8?B?bGFVNHRyeFB2d1g0WGJObmlzR3AyZ3BVZDdOY3ZUTng2eTNsM2hZM0lMQnMx?=
 =?utf-8?B?dWIydTA1TnRYbWZjSzMxTFM1bVZadDc0aDhHOEozMHhkOTNvR1IzeDhEWTlk?=
 =?utf-8?B?alUvVzA4cUVZdzhxV1QzdVdPckFpZjhhaCtXaVJJZ0lBZzlaN2FSdWVRcHhw?=
 =?utf-8?B?KzNMUTg5Y3BsU29IM1pwNldHdERZZWVYazZsdklJM1pLS3B1M3YwSktWY1JZ?=
 =?utf-8?B?YUlOUVVST3JCcERidm54anRrQk0yRnhPdHdTNGtjVmpFbURsTVN3d0xuMk9y?=
 =?utf-8?B?S1hoYjd0Z3dpalZia2NqTnBDMzRUbi9iOGlNZVZXNisyN2RWdUFpZXRDci9F?=
 =?utf-8?B?eHN4VFRIRFBMbHNmVmQ2anVJOXkxRGJnck1RYXJpWlkyd3RHRnZDNFIvNndz?=
 =?utf-8?B?dG83NFc2b1IzWEloUXZuR2daY3MwdHlYRW9SZ3JZcG4rM0p3S3R6L05MSWJx?=
 =?utf-8?B?cklLTnEvblVQcjZyT2w1bE8yWmtHZ253Wmk1WlNvT1Z0OERUOFpOZllPWnFY?=
 =?utf-8?B?STZrYkU2bXo5NlZ3cHpwdVJnaHF1d3g2c0lCWmt6QzRzNnVMN1ZaQkNwYnBi?=
 =?utf-8?B?aUJLalV6cWo1OVJGSVN0ckdUQWx4RGU2bTlsZGNJM1NUQm14bERxamg2dUk0?=
 =?utf-8?B?UnUvV25zUXRINWtnZnNsOHNidEJIZzhTbDlENU9KRmNaeWdiMG81REd6WHds?=
 =?utf-8?B?Q1hyM3pvUmpxM2hDWGlJZEVTZkRTUUdlQzQ0TnJQRisvLzBsQXpTNkZ4cmVS?=
 =?utf-8?B?SUp1ZGt0SmY5M0kzeml1UUkwZ2trZngxT3JQUnM0R0c2SElyYjE0U21YVmFE?=
 =?utf-8?B?WkRtVnpaaXVPQkZ3cWdJZzBTMy94YnVnQkYxVkdnZmIyUWZXdHh2eDloQjRZ?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jP3/TJFQR4ZWjf1acQNQ7hre6n5QcsRIJmYMbMbQmi+NFL2c1XP09rA6rkzrIlh/NNfFrP98rLjJnZVg0wy0jkWYKDEVwcTm/Xybdkx8nUkTp0LG2qHq2a2Cxcq9O6DyXtPVFoasptO9uT8dx5JkCPl608cQR50Mr0leVvOo+/SWKJNqmsTK3A1AE/QsZvqv8W+wl1WfV5a5ra+0NEHLAJZKsY8Mj7FHsQZHEhSRATZmCWtt8FgkdV0gV3HYxpb87ryssejpQS6g/1KLrsAgJot1s25gdEKxTvutSwVNn5mES3qs68ljVBMuJQIA2pIYLb+xeOBrF2PgAlGZb695OmcooWxp2l8uiFWdS6bL3MvbGCVxKDLT+1ev8xOV4mhGHICm3EumoM2sAluDatjCI/WQoVxmmowozWRUM6/xANcWFVsbXcApYVPJb8GOnhGKeKyKPeeGdYXP7Nldlc7fPoHc/5ClGUETJ+kOhnqx06YNcOmjuedU0o+tOKHcT5ymbEEujQhZ0jRaOXVmIYWDaL4m+YgHYgid7dcHPANZ0tNyl7Ct+BVzLY5Oa9M6Qi9XsawOkM/DGqkZ4PHSjjkUrEw6i/oxSibUYL3zcDVQoBc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 951c0fa9-a890-46be-ff5e-08de25f090fe
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 15:47:08.9371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5sfRuzI5wJNC6cE0B0YU8jUITPl2R+x+t+qzvoF4uXKQqaG+kOrIaV/UdJlc68rIj5+8U0haJNC7Nse+BRMAdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511170133
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX3gHOBptx1sFz
 PiF0bgzY874M8wNz3G2ipgcMX6EiOt0mYV+HdLr9cGPFppb8UnvoF1BcMzcOZpucxr6zg2ZspTX
 nybRnBVx27HKyx9XHlmxy7eglYqyXl3YbudDy2VmFBfw7oyCdwFGbvZAXUUHCKhvVWHCOERr+K/
 mES9t/Pug4uhvWAEzVWtr0UqvNVDcLYa8zVHP7xDHhZ1aE7LoOdyv0hcWnAxrdM+zH/GWFAq1Mr
 ek/FxuP3rzQpkTPO4J/5Zotbl/lDDpWBP3ZChm8UiDOoPytrS2PmY9Cw0952A6KjIJ8nslimj/Y
 qSl0bsn5l+u+iyZZNADfVMjcAzpAuCBWODO+9IK4EGUXJ+nPS6hWh6JJjTeZGFDRmWCJxSa3QO5
 Z7TacHHKC70ln7ccbbecB8AlPXiBKqEmA36MprsPocJ4ckjzrO8=
X-Proofpoint-ORIG-GUID: ruuxkQPIXkqTcyGPmp8XGu1tJJCuW2oX
X-Proofpoint-GUID: ruuxkQPIXkqTcyGPmp8XGu1tJJCuW2oX
X-Authority-Analysis: v=2.4 cv=a+o9NESF c=1 sm=1 tr=0 ts=691b4382 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=h_zTkUYG8F-YaEpWUlIA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12099

On 11/15/25 2:16 PM, Dai Ngo wrote:
> If multiple threads are waiting for a layout conflict on the same
> file in __break_lease, these threads must wait until one of the
> waiting threads completes the fencing operation before proceeding.
> This ensures that I/O operations from these threads can only occurs
> after the client was fenced.
> 
> Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/locks.c               | 24 ++++++++++++++++++++++++
>  include/linux/filelock.h |  5 +++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index 1f254e0cd398..b6fd6aa2498c 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -191,6 +191,7 @@ locks_get_lock_context(struct inode *inode, int type)
>  	INIT_LIST_HEAD(&ctx->flc_flock);
>  	INIT_LIST_HEAD(&ctx->flc_posix);
>  	INIT_LIST_HEAD(&ctx->flc_lease);
> +	init_waitqueue_head(&ctx->flc_dispose_wait);
>  
>  	/*
>  	 * Assign the pointer if it's not already assigned. If it is, then
> @@ -1609,6 +1610,10 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
>  		error = -EWOULDBLOCK;
>  		goto out;
>  	}
> +	if (type == FL_LAYOUT && !ctx->flc_conflict) {

The file_lock_context structure is allocated via kmem_cache_alloc() from
flctx_cache, and it has a NULL constructor. This means newly allocated
structures contain garbage/stale data.

How are you certain that ctx->flc_conflict has been initialized (ie,
does not contain a garbage/unknown value) ?


> +		ctx->flc_conflict = true;
> +		ctx->flc_wait_for_dispose = false;
> +	}
>  
>  restart:
>  	fl = list_first_entry(&ctx->flc_lease, struct file_lease, c.flc_list);
> @@ -1640,12 +1645,31 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
>  			time_out_leases(inode, &dispose);
>  		if (any_leases_conflict(inode, new_fl))
>  			goto restart;
> +		if (type == FL_LAYOUT && ctx->flc_wait_for_dispose) {
> +			/*
> +			 * wait for flc_wait_for_dispose to ensure
> +			 * the offending client has been fenced.
> +			 */
> +			spin_unlock(&ctx->flc_lock);
> +			wait_event_interruptible(ctx->flc_dispose_wait,
> +				ctx->flc_wait_for_dispose == false);

Nit: scripts/checkpatch.pl might prefer "!ctx->flc_wait_for_dispose"
instead. Also, it wants the continuation line to align with the open
parenthesis. Ie:

	wait_event_interruptible(ctx->flc_dispose_wait,
				 !ctx->flc_wait_for_dispose);

Notice that if ctx->flc_conflict has a garbage true value above, that
leaves flc_wait_for_dispose unintialized as well, and this wait could
become indefinite.


> +			spin_lock(&ctx->flc_lock);
> +		}
>  		error = 0;
> +		if (type == FL_LAYOUT)
> +			ctx->flc_wait_for_dispose = true;
>  	}
>  out:
>  	spin_unlock(&ctx->flc_lock);
>  	percpu_up_read(&file_rwsem);
>  	locks_dispose_list(&dispose);
> +	if (type == FL_LAYOUT) {
> +		spin_lock(&ctx->flc_lock);
> +		ctx->flc_wait_for_dispose = false;
> +		ctx->flc_conflict = false;
> +		wake_up(&ctx->flc_dispose_wait);
> +		spin_unlock(&ctx->flc_lock);
> +	}
>  free_lock:
>  	locks_free_lease(new_fl);
>  	return error;
> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> index 06ccd6b66012..5c5353aabbc8 100644
> --- a/include/linux/filelock.h
> +++ b/include/linux/filelock.h
> @@ -146,6 +146,11 @@ struct file_lock_context {
>  	struct list_head	flc_flock;
>  	struct list_head	flc_posix;
>  	struct list_head	flc_lease;
> +
> +	/* for FL_LAYOUT */
> +	bool			flc_conflict;
> +	bool			flc_wait_for_dispose;
> +	wait_queue_head_t	flc_dispose_wait;
>  };
>  
>  #ifdef CONFIG_FILE_LOCKING


-- 
Chuck Lever

