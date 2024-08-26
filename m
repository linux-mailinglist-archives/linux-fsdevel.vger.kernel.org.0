Return-Path: <linux-fsdevel+bounces-27196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D5B95F653
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 18:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4EA1F2270C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 16:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DC4194AF3;
	Mon, 26 Aug 2024 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a7nWTtgk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z02KfaEi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DFC194A40;
	Mon, 26 Aug 2024 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689253; cv=fail; b=L5t9/5f1oV56jg+abTWrO1rYqlAIVR/1qx8twvLuwF2qC8Uz12br1axEWt9HQyyeqHhrCcihLYGPpMQA4ANDoNAzHAcHGtI1L0D88V4ofTwJaWaPR1V2LHrg8cHdKK8r2el19SwHmEQ33IqDUYJclSZX6P8f+4hlgs7vr691VzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689253; c=relaxed/simple;
	bh=pHYqMkwb3QWl4qeB+nOLSCX+bMrrzVep6uDNH91hFn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ERkK/911Aq6w+kg2CH9oQDEJfzv+pUQYIbeX/rBBX1UU9Zxys9Rw6NJIs08THIDAShqknLgCP91jU+DDE0t9AiPqt/rnA0mNlH3yHqBOciOQz2lxfVkavhhpWnEzDtlyqM6EWxA3nTYDbuFDMswrrwt9QfituX5c+EAaZWDE23I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a7nWTtgk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z02KfaEi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QEfVYB001827;
	Mon, 26 Aug 2024 16:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=FsQ3HEJfNI4MXbk
	P6qZDdvi8lfYh9aBj6yUde7PtDSk=; b=a7nWTtgkXH4NBg01B7xEjHkAa6OyxYM
	1zwlqJZ1YZFAWvtoQOc3sUqNLQXM12DXH9HOaNOQTfo6uW7/0Wz92pHRZO5GtjwH
	8H/Fp5TXFZsuLSiAIT4wbkxtCGle6IEdcl8+p5kZl01HtSylnFyrFQCKs65QOvhH
	GcENoxMoJiIUpnXci58YM2bAL4HLWeMuLfKIGETyxdE0NcVqajlRdDQdFblGPqUZ
	jYZ4mX8Ei1nOKSKVlMN2+RsZyo80XIUGI+NaltdDJFufvZo6X47p3fWMH0d3jVt/
	vMjgw4lt+IJNVY/tXckZdfxT++k9GHPo3Flz70m8ifxB2dPWceiCvuA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177ksufre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 16:20:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47QFtxqS034714;
	Mon, 26 Aug 2024 16:20:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4189srt82j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 16:20:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AuiBUYVXz3wSxVzOfl+zbIosOs3EGcvkT3+dmgJHGrrzgcbhJ9yWFQ9OWl6W/PZGIXpKlmOlSX9FnZHzRDKrTBgvkZLoMGuwdcw5rOlCeZjBZgruael7xAEZs1mysEll4JpVdxDx+hU+XJ1d/3wQ76KIV38WExVuJBJ6QbG57/TsqXeqlXAgAf3q156kTaHE5G50bckLQHm+C8FVwTiIXbIAbxhAiVPuaVGFEieDhuCA8RnmuGakRTI/EyVp0ad1e4Ufb8KdZHl+Fi8l5igIWyZnfWw7FPR4sQH21c2saa+h+kZvXYNmVKzM3gbeXAeyAXviupk//5zsZv0V9F91PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsQ3HEJfNI4MXbkP6qZDdvi8lfYh9aBj6yUde7PtDSk=;
 b=DZaahkoCxxJ9F7YeJ+T4Ee2MpeWHE8xxVwDSo+dpcU8EIlUejosIzM9d9NZjiUjB2PRx1c6NuU94sS+/JOywEEwL4gvVNSH1VWWUUNVusTaQ6vtYVJ/S2/OSANyvOucrOV4OD349DzOdB/uCbjPDi17XsP3/DxW5N/QZ+v5J/YEnnMeCP6otgCeWWch8u3m0UCC4Dp5R8+CBKMxNoDvq3qzCGEU5dYeMu9iy+815ulXSAzPP0avnTANGpdSjhs4/V2VT4OyJJPSvVeWiH9QSPFw8LhirEuBj2KQTYo/2WfkohoCrGsqpbTNOPKalu2dXLeOgzxp52E+f70/fsWOrKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsQ3HEJfNI4MXbkP6qZDdvi8lfYh9aBj6yUde7PtDSk=;
 b=Z02KfaEiStZ7EaWa2Z8KZKyI6h3B2wO85BIB5xuuL8OUAB4OC0fTrJ/TNxljdsI4lB4Np+gmpNhkwHOtRCleozjnde7IvuxzTzClJ5VbbP8EXX6/Sk2GT3ap6hTe9wbtntOZTQsRio55digFMHWjVxpFZMt07QSgw2+RzLq55UI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4848.namprd10.prod.outlook.com (2603:10b6:5:3a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Mon, 26 Aug
 2024 16:20:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.012; Mon, 26 Aug 2024
 16:20:34 +0000
Date: Mon, 26 Aug 2024 12:20:30 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, okorniev@redhat.com,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs/nfsd: fix update of inode attrs in CB_GETATTR
Message-ID: <ZsyrTolz0Ywyt2K/@tissot.1015granger.net>
References: <20240826-nfsd-fixes-v2-1-709d68447f03@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826-nfsd-fixes-v2-1-709d68447f03@kernel.org>
X-ClientProxiedBy: CH0PR03CA0220.namprd03.prod.outlook.com
 (2603:10b6:610:e7::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB4848:EE_
X-MS-Office365-Filtering-Correlation-Id: 73c2adb6-3143-43b0-2755-08dcc5eb0318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4/F0KZfyM8vw4e8NUmMpyqhBuSzM//05pHHmx55KzDweWMHwwhNQemxoz+Gn?=
 =?us-ascii?Q?QS7X+dqhV4J3BBO2vBfaLClHz69MUTLtTrCoAy8TKMnnF+HrZHAesuSTjBVz?=
 =?us-ascii?Q?o7lvZdqOzZaVg3DOz0WVusDxij/cI09mbP4vSrorL11D0cRwMBbjJiY6nTka?=
 =?us-ascii?Q?SnAHhB8TFB0YcVH72dOuWERnX/tpimgjvog1FSAu25VCkQpq3i0Ipgcqa5qa?=
 =?us-ascii?Q?oSyPyUrT0KT4rzpRybGyzIBw9m1CsljOjg8wNwkC7kBlSnUARfbyUnFGm7Vy?=
 =?us-ascii?Q?MOtttiPljOob47hQn1KZ7MKGUahVn4ZB81dHdMtcq/RhgbCf9EbpMVRsVDgn?=
 =?us-ascii?Q?qkCdmsJhqxukXBEvzUr4ZvaPi5NJo4TAV0bGKje/ReVLF9lGz4Nl0i8AprRc?=
 =?us-ascii?Q?RW6TXYAZSf+NG3SGKElUKrOPU5DcWSFn36X4StXHwi7Ug5oa8/okWMayvsVt?=
 =?us-ascii?Q?rFENeffHt0QaXUVLQm2NRI5+66C+QqJbf2k9XbE4zJ4WUpGcpwGGZlY1oGRz?=
 =?us-ascii?Q?86PPuGtF7KOgbGmADcU/II0XdxucW7bKUilA4ZKE6LuZUv11/nyonAzh66jV?=
 =?us-ascii?Q?KQXL6y2o4akreixPa7wPpmFAgWLBe4XSVSxSw6YIc5UwsSELGnydr8zKEg/N?=
 =?us-ascii?Q?1X2YiSEoo0JVXbddJDCKOY5uOK9ZdocMkLnXfX2c6oZoDzNNB5HmmKvTooFv?=
 =?us-ascii?Q?x5CueZ17cSEEBUA3qe6wBBTSvul0UF5OW2DrgXCQAGxO5yX24F+tr/g3xrAU?=
 =?us-ascii?Q?LRLA7c4LztTzxCmZn0AM1nP0Dfo9PbZvYay9/K2cssL3VXfAvh3jXufkuAS9?=
 =?us-ascii?Q?Bb+DoQhRUIsJqX1I9Ux89B/6+mqFKdD+53UCzWUTXsi6VvjkOvOdqsSYSCQ4?=
 =?us-ascii?Q?nGq8M24OOZAbuYaPVrz4bicC8cktyfzwxl0olqiVloxQU1cgLQlNwta/57z8?=
 =?us-ascii?Q?RyPWyMXja7ooeHeu2nOM6m276cTmh3UquIfQ4MdRX/Lg3kD4bMVw4ulqcPor?=
 =?us-ascii?Q?mtTc5hXIRIP1t/G6Y/nYKZ0LqLYRTwK9aRfSDsXfp57pt5fV8rfnrvranqvY?=
 =?us-ascii?Q?CNfBO+zfSm7mI13MTYtM6KRuE1QhRns63mVaRYswYt//xza8kLfgIutql4sm?=
 =?us-ascii?Q?uCzjHNYWGv8/1NW/bn8B9ShKM0VRty3CAlpT7t9cMTZ1DeH3grcsTF/3Xa8U?=
 =?us-ascii?Q?ovzT84CoN27Wjxhgn6MfknlY7MEaSwvcJGY/xCdl3Kf/viwzIpd72Tvq7523?=
 =?us-ascii?Q?4oOtv1oCDY7nSpfuhAkynip7zu7SFoOjgu1glbPTnGQPw1oRRNrnylShhEcu?=
 =?us-ascii?Q?/sjrzXO598jy/UeyqeLZRDMlMbTfYC7icdbwmFutUz0A7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8K+Lbm7GkDwrSq+iBYRPyS0L9i0V/z+GI4ZFmliWVKFJk7gLSVLEhPO9oXe9?=
 =?us-ascii?Q?UT9h/hSZRyh26pnLLCjHRQDND5JXuA/JhQFeYvBzUKhSLCd8Vi7Hecq4rXtj?=
 =?us-ascii?Q?LwOO4psMKtjmfUK+fdGCFpZolH6DCYkGjx7f6JTB/nP6zbU4a7EgqpCSOSVc?=
 =?us-ascii?Q?7SOvcpfaC4xMWAKTLjgZkFliZ1dOrsiYf5RL26i1uDfZQNW/wYiCwAmSfY59?=
 =?us-ascii?Q?K0j9KMm6nbpgQNfUA2EpSEn2nUd7FqvHjD7gtv9JMc430y+IqtSsl2lvF9VG?=
 =?us-ascii?Q?vsiZIOXxl5cT+C4/VJ/oDrL7m8tezDf3j8DvEAnyKmeL3K9B5pbfgJKgHP+r?=
 =?us-ascii?Q?/4qb+vjr962b+EmtifEjL5TxqDcXztxOBKe/ah/63oo1Qy/TdoIGVyy2TO7U?=
 =?us-ascii?Q?g0Rpc0KBLIBbHLx7vMz2ZGav1tXwO0tsWZn4esPLPiPIhmy5ubU+AnOiCp3v?=
 =?us-ascii?Q?X/6643zyssUaIgi8ExhIuqskf/5Gyeqbl2C1+96PLbDYmbpW2ql/dbtbP6oM?=
 =?us-ascii?Q?HYPqOiNMLl7sIf5y6cKusFqVNht5nsgCLxeP4TugVwurNnlwey4vFXzvss7Y?=
 =?us-ascii?Q?BGel2SYvYvV02fU9tZ9apn3HACVkSi8K5/R/Mi/Ip660/70fQpc5T7/zPxt/?=
 =?us-ascii?Q?Q65J1IRhubTdpr9zgW3nV/RvdOrxFL5iNGgsAgsG11gfasZJv7LiFclSnVLd?=
 =?us-ascii?Q?bYRhfvhqE0P149JGkIGRGAypNX6QXNkVSEh/uJdhdZTam/3c8et6OO7n4ds0?=
 =?us-ascii?Q?iaMjbNBfQYDIkXK05KD/nZA6YbkihsgxyVrvsZfRNG/0aGgaZFS2E/eIZwcL?=
 =?us-ascii?Q?n/ye1ZMJ3UQgOi5ku/+wSLGbxmpduoivCKB5DMtRsad500MuRfIF/rixZUB9?=
 =?us-ascii?Q?Od93EbsSfY98WxkC2ghjHYrO6syb3R9N4s8rSwpyQCmBk6/wN15Xc26VC+52?=
 =?us-ascii?Q?J7sSxvKy8Jk6KNfwliQ/yWwa2FSbIKEakFCd8yGhYdc/4z7ZwuomzzZEaWHE?=
 =?us-ascii?Q?6Z0P607qjSowiPzJIMN9vzStx1emIGsWFnJqmvUY8tGmR/x/7JxQfPwAQJ13?=
 =?us-ascii?Q?uO3ZwQ7eJiHJPV1HCsExHwErP/p8Rjheh3UwzvKusE095bZyb9ZDbbLFVwZd?=
 =?us-ascii?Q?aPUVcJ/N0iZtBAr9bX3ypY1b9XdM6TWKF5yn/PdTymKCpgVlEnEZJTDmausl?=
 =?us-ascii?Q?XxZKD8kA7MSiFv49c4kqU/2evNuDhFwvfNx88gkhncW91UGhktYMg4nvSVcW?=
 =?us-ascii?Q?DWRalYKRWGMGl03fzHDUpBevXmyJM5wAgIMENH2KT3ipuyh9lmrVJkYF4sHk?=
 =?us-ascii?Q?gTMRqiBqYCDDroiTUb9eCBISogylcpYL1hcSdroF4fYGwbJdJsCeYTBV9vzY?=
 =?us-ascii?Q?ujKAepxV3UYC9WKqjRiAlGRFiCbbXJrHPh4uQUcFjxHIfYwgz2DS26KcVCzg?=
 =?us-ascii?Q?gTUkUNi0Aq9eCMzLMCaCV4EG6IACqQA5p9YuO2a/o0QY3Tf7MBMJUVTlG1El?=
 =?us-ascii?Q?6pt6yE5biecMFQYvv5ivKjIwWVC2u+Pd+X8N+DmIsB84fIb6dVyL4E5zAQGv?=
 =?us-ascii?Q?HbLF04RfOI2xixj61iOOdureQZdGROpDptdSavA1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gEsiwoLAt4SlC5fAkaZLZvm5eDZgv6iOaBnJzC8vZPor6hs2e9pvOHOVHhVqH0LeyEIn5Ze+mJdu/41MgQWsf/eandkJHM04pN519jDVP2r83OlLfsbulWF3ErBKYRD9VwIeC3CU+z/TLkJPeRF7qHaxepuyVUDoYudnxCQQlE9BJUMpuPl+UrgfxC39jkcueL3fQcCGCy/GkDczvB4nR3OmT5wRcax/T2lB7tTLc4jHzXBTiYwGqBfRphw4+mGl6TVbkjtWRaQoksHdd9hGBdkley3Iq0Y0Nqv3eKwIKwpqqtKxYtDx5xivBRMniTPMHWh1/2Yhfi9yxWwwWlR6eRpzj8Bo88SZlSMKFlpASSa5gF2jUmDkmNQiatAlz02qja2H0U3vteu/cSJzSKrtNTZfJqDYrfiN3wAvrC9z/lbvJ6dQpAFXGkJW+c7k7/uI5f35nzRbGosRVM4xwLZOU3FDuILZ9Z4cVOvUjyo9zq77I5f1ZBoQ5kCbw1V8w4sXyUciMvboxdmrwY5EBQgmeL4x8UVxyocPo3veHHRzG/ncw0fxCvN9DDlGGV8luT5mBlrdt+fME0l39RNLNbhAzjlQF8mjR8dL/YyeVJ3vguQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c2adb6-3143-43b0-2755-08dcc5eb0318
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 16:20:34.1138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GAot2nQA1gREY8PxWekNRwnabeLSp8R21BIRW+F+zY8YPuzrIhqWB1TYAvROzWs5OsmG2NTloYDHspRu+WC9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_12,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=763 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408260125
X-Proofpoint-ORIG-GUID: ftr_8BlchKjFuLp90Z0rZpADeajoPbqZ
X-Proofpoint-GUID: ftr_8BlchKjFuLp90Z0rZpADeajoPbqZ

On Mon, 26 Aug 2024 10:32:34 -0400, Jeff Layton wrote:
> Currently, we copy the mtime and ctime to the in-core inode and then
> mark the inode dirty. This is fine for certain types of filesystems, but
> not all. Some require a real setattr to properly change these values
> (e.g. ceph or reexported NFS).
> 
> Fix this code to call notify_change() instead, which is the proper way
> to effect a setattr. There is one problem though:
> 
> [...]

Applied to nfsd-fixes for v6.11-rc, thanks!

[1/1] fs/nfsd: fix update of inode attrs in CB_GETATTR
      commit: 2378b0fe77ac627a6ed0bddaef3d1455d98cb216

-- 
Chuck Lever

