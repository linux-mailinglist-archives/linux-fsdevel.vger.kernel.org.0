Return-Path: <linux-fsdevel+bounces-32064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4379A010D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 08:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD54286445
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 06:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEE818C926;
	Wed, 16 Oct 2024 06:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CZfS4syW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dagcd+1J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881B2156E4;
	Wed, 16 Oct 2024 06:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729058767; cv=fail; b=d3LvHJ8LM7UwLJ63cjKwZmJV9G1WdW4vMj3qEWv3ESPN9Ojpe84hP724HeuCtUEURMG/9J1CuCWD3h4lvNQGTrBhPrBZOqE2FW2wm2yQw6kLax1ehtanrIKhfCQCqltUMGkChRjjP8x76ILzyXur2oWHsllSziWlMHNMrhu/ePk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729058767; c=relaxed/simple;
	bh=1NCGB0dhosUeUQKcye8a7M8ybKaO+/eNPSkt6vYKziE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hpGYzRNi3yKlYPnVlzwf2egwwE4Mtj2EMZYYu7BmM2pleiGBHlwi+AWy1Qep0WdF+psSxEagTde+2+zCHv8i7mkibeHwqClSbdx/iNAjAZRndY/lzs47vvS5hpjJBS3nQzZQ256dOdRBX7j+lhYa7lbQLrsAzC2QwCPeiPQR7Tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CZfS4syW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dagcd+1J; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G2MaTO016575;
	Wed, 16 Oct 2024 06:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=9S2jnSCDYU8DjX7Hr1
	Rf105I1YynFah3DU6F/EIKGS0=; b=CZfS4syW6TwqcvSWTfO3sV+JKW2kZIeQYt
	u2iqz0vDwlebLVCTfJ2RCoy16LEUR/uGOfcRuUQbWki9LxPjFTTUW36BEZnyk/hn
	PF2rQdGd1WMOaSaWmHu1xW6yFVmjN8+qvjNkgltjnPcInBq1O6I6gDlpo91/g3SI
	Ydg+Tgu7kMDl2woDEtBa7NkN97jI4IhHfrGsP3A7W8S/JT3HnPOLCxbbkDvmJE31
	bSJOoXmeycujhu4entA4NMfp0PuNdScwxeeljB02YGc9P8aa48I68sAJbl7/uF6y
	s2BoOpFaYUeBf6lQJZePS7IW65wKl/SO8ms7FPQRt+rJxDOJIcnQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5ck871-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 06:05:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49G4hTeK011105;
	Wed, 16 Oct 2024 06:05:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjepng6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 06:05:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkiAIhOr+2SkWub0N3qL70mnAs47pi4p7EhL9TOpm0bjQupFAhqKW5TFlNWqGOgoIezM/0rPhgferd5JMsdyql5uAPRT6mQ78JR/fdAT2FmsbVb2dZYkkwf5pFHkNooX5CBn1XnBT6XqgRyNsxtv+gDULbtlb4YgkS4SrCKoNDMI0uhiv6mJstBCARDWwZ+c1OY8tGaqja4x5LuE0HpLwcibzIdTuvDa2PNk06xlaMiM6khT0Tw48n5FPBYjXVnATgW+eIsqPH8qOq8FKyzTVZjCw/VTOWE+fgF+pMUiixUzGTi32mGIAjprtQUsXFYrifLSroDOZM1OWHIzAhU6JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9S2jnSCDYU8DjX7Hr1Rf105I1YynFah3DU6F/EIKGS0=;
 b=bJd81TkURx9x2xEDoz192zh/ndYbGdcrddkpAKDvoe7SICXi5UUz/hRRZLJn/a9NyE+IjwpBUYpM48kVo/9KxPyHBrT4nU0S6cibN9s9cxr69qfpkfq+Ghu+E/sLNXu7hORobeTwghjTFSIV5lQMTuVMiZa73DjWDKROZt8r7SO5l7Q6WouGScNpXmebn9mN5zjXPKyL5I09K4ag7kW9XO/qc6FbrbRIT0JhZ7EWI0Ctqquvk9x74bK8UJR+0I7GACh/47dLpamf+04XUcIi6LOwrsZzvr2CdEVrYEOUJbxkJI7CKJ4E60RFYCwTYWjKR9NliaOrwsOW9CKtZpdJqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9S2jnSCDYU8DjX7Hr1Rf105I1YynFah3DU6F/EIKGS0=;
 b=dagcd+1J894MuwK4+0DFwZ9odNPdJoVIe7N1/YjSoOnKN/nG23kIgLqWGiZTKLpkajPptl9/hmvwXUMgQtHsEJ72P9uSaXztKs1Fagy6PGot9/ONsAnkW7MCsBs8IrL+DxGfvzmXzvC05vuOOdHutFfQtcBlRO9+uFx6LVUbY34=
Received: from PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16)
 by SA2PR10MB4588.namprd10.prod.outlook.com (2603:10b6:806:f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 06:05:48 +0000
Received: from PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2]) by PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2%7]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 06:05:48 +0000
Date: Wed, 16 Oct 2024 07:05:44 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] pidfd: extend pidfd_get_pid() and de-duplicate
 pid lookup
Message-ID: <8c75620d-8920-4c19-8ebc-0f2b056d49fa@lucifer.local>
References: <cover.1728643714.git.lorenzo.stoakes@oracle.com>
 <8e7edaf2f648fb01a71def749f17f76c0502dee1.1728643714.git.lorenzo.stoakes@oracle.com>
 <CAJuCfpHLGyrBWZ9JyJ5FdJQtGO1-tuUqHawjKX_mtwnAhSY6Ow@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHLGyrBWZ9JyJ5FdJQtGO1-tuUqHawjKX_mtwnAhSY6Ow@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0090.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::11) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5611:EE_|SA2PR10MB4588:EE_
X-MS-Office365-Filtering-Correlation-Id: b2db9210-cbca-4a4d-d142-08dceda893ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/owrRS/esZ2mLZTvUrNWSiILxoiEUykaSguxzMzWFfhgJoPtQKFXIhK1hxjg?=
 =?us-ascii?Q?lg4z7cTE5qdQLbQdWP6Qe2Ru6Kz3PrJILK8sYYoi9rk3bHqko7Yh18NupNZ/?=
 =?us-ascii?Q?/lx9n7tqJNP4tF6Pan5GAiCWSwYFKEn7yj65HaLDujWrLmea1TvCsmBUNFn3?=
 =?us-ascii?Q?8VOna+NYQ6rOLYrpUEMVhLQ1truVL5jwhsL+DarqUtl/AA0nP2MWWa6urW1y?=
 =?us-ascii?Q?oFEsnDLVH0zObGdiKmtHvFZjujQmmtSZLY2gpg/035ZtK08htFYAGc3e9ofh?=
 =?us-ascii?Q?FwkC06onDpRIYCS5T3OECZNC3WnEA2YKJwhr0eQbpVoR/q2+XFvK0a4Jvq0a?=
 =?us-ascii?Q?AGXE9x5A3R7Y39pZ5d5z/lXjZAEbkjCNk9mgD/iA5v6bf9DV15IB6iuUOEoU?=
 =?us-ascii?Q?6mxtOp+7G/tGVVLCLvvRlSJp1mxrdT9dyUF+kORiEMhJx/gWB2SdaWHiLYGg?=
 =?us-ascii?Q?BT3yxbx0RAp2cpY6vl+E4R2hBmE6OixIEJb1HwhGaVt1ogEfVg3HcJk79V7V?=
 =?us-ascii?Q?ycHdlXuLm+cfwsuCh4Irrf+VpGdGF1I+BF6x5Hq2ExzoslMjc0s7ibXe7jiC?=
 =?us-ascii?Q?7HrXKY7Y0kRCiKrGbanT4HLhG+1nrmBDCMf3ST6KnUu4CvQwkDy59TcPgrMS?=
 =?us-ascii?Q?RDsBTH5iJFcl8IReDa+UupjXWCzH0ZSVnJeJVtpVG8bYsSAqfLtsjor2ydQk?=
 =?us-ascii?Q?RV4cG6zRF/PLQaLQmmkDt8V5RcFLEa3HLptwD7wRyU/b+94dvbP80CmXlZyn?=
 =?us-ascii?Q?gU9D17RWaLaT9Y2PJPL09n9oClmo9PCAp52JV0sC7cykv8HXLQZc+qPMopCP?=
 =?us-ascii?Q?gEjS6UVWOR8TRnVbHgYmJj2IiTGhoyMNm14KwooiaA5fsGc6Mf+PFafggTcB?=
 =?us-ascii?Q?qW0CJ3JTBD1jz5g831aEVWrYbdikxilE7BNar08ZPKQQ8acv1Lfvh8FkZGW0?=
 =?us-ascii?Q?n8ZlbVNqI61GNZBOdJUOJMIVN4bd8EKQmORGHmS49JsaiCDIim7UzS15VbKw?=
 =?us-ascii?Q?P7RqhrVcl1uKwbb4+BSozuhGxmLM8TbP572FLiauzSIFT4zc2S50PyKsL7/8?=
 =?us-ascii?Q?XOuChsiEVpjq2WPAaSWb6IQx8CqSMrkmFKwH+pbl0QYbTvlp7PhsqcXbNOmj?=
 =?us-ascii?Q?vxf/mzvlrK0f37UJKuuVKfftQZfRfQTetOjo7FCES8he7YDllA/gEs8/gIPH?=
 =?us-ascii?Q?GNFR+nR6fjZqY7L4bq5IRwTKTPGGgdiaO+EiwW4dWxKlVYoyoG6MSgHRtQZr?=
 =?us-ascii?Q?4w4tllLtU2LoIL29WTFTrQKdaskqLxGADC8am4yPrQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5611.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JQnWi7lsWre58FTvfN483xT86TUhHpygSC9/o1719tqBSL9diSGU1Fc8Pd3b?=
 =?us-ascii?Q?Gbtgg9Vjo3WcAxyM12x6Ar70bmf7xzeSRUN/bzbnRYihp0cJon2yJnmkylX0?=
 =?us-ascii?Q?3nTXWrj5IEQgpr4ZfPxDQRQPLlCdiGX2hz84orkAV2jdoMxnsieBvogBJCsA?=
 =?us-ascii?Q?vJzIjQb6onESlZnpjnFGU6NMg9gvUuXV5f7o1ac1hcb3SC6Ve3Fus/NjdowK?=
 =?us-ascii?Q?fb/dpBu19lyl+QWUadORyyLTEIkGbYQ2/9LlScUW4k4zOlIrhPXc5nDXfetD?=
 =?us-ascii?Q?AeSY5FyjuJOkw9j7SJc7LLPBp+P8uqe6m0cyu1BEanhwf7uyQqQfvzESoP5m?=
 =?us-ascii?Q?EmwsConNt0F4+6Nv21AkeCF2kCzFX7AWb0gDK4uuEATN8jtnWqWRzfnPYBxO?=
 =?us-ascii?Q?TjmZukXIpBds3JHxRxDxSAvuWUrwZNWKqXL/MzpYwAnLeU4pfCEFl4I5d0gh?=
 =?us-ascii?Q?7Z3OdTJEx2EZw2Ag+vXifsDRc12Rl+prVwLjS4CyAKjx/xb9SMBGdsE1KszI?=
 =?us-ascii?Q?xWDpnfZ+g+UPJZKuQH5e8zegj6MUeLqlpupr8CDo6XHB0edsGXw1mXpA1rSi?=
 =?us-ascii?Q?th3PHMz+LAPXFVvaybPaeM6mn0YTxd6vJkisfIVzYTFu32N/FlRPcMX2H0n0?=
 =?us-ascii?Q?E6ShhRG7vLpcT2G6LNatcPxgJsZlSCqTjLpRpL4UiFVnJCFEJyiyMfBKxIuY?=
 =?us-ascii?Q?7+HxsbqFqN8dxJraHW2VtcPlBRQjCkAAhg3frUkxvvdN99S6zBKerhNQ0VAh?=
 =?us-ascii?Q?NhLqUmrXkz13iZ1PcEeSekTRmdzHbIDiXdgXfrTLh0AnyE+xGR84VVPQuynV?=
 =?us-ascii?Q?w7XEiGhubF4EEOsxnK2gMgjUyWFONq5vS+x6Ceo16h7GBH3W4X45QAlRHosp?=
 =?us-ascii?Q?RfdfyV83gTFBdPJXmeOmyRGzXnHWlELh1H1L5FpqsYasLUm73TpuNbMCI2Xb?=
 =?us-ascii?Q?mg7lWSE4pVKfI/oPHMhOlMiQc4Amq6huy2LeIbLlerIKiJJ+zgwCTnDBo4e1?=
 =?us-ascii?Q?iJfKzkVLJD1MXSdSFJMQ7ubKje0wihRaFpHHUaZgjXL+cYwcoSqRBLLP97Ac?=
 =?us-ascii?Q?laPvbJpRQu4Far3nJUqphVVa2DSsMVg+e8GRiXCclsZfewZik+qxVBbKb2Om?=
 =?us-ascii?Q?r5DGJXX1Xvm+EjfhF0yd5aOZas7JoDkPZP5udgQxdmyhWwtV9qRLMh4CVRcf?=
 =?us-ascii?Q?26sRXO62tGOfc+DT12nyMcFcBhmnmGb3WH5TQfjaO4f11bWpawlnlpUrgB7u?=
 =?us-ascii?Q?279viVVbyQsHSLcg7o+zeViFz8dOJ+/PuICOaP9RtZY8Rp+/SG+G+lkx/KYF?=
 =?us-ascii?Q?HZHt8TEnAew8yjXM/xVrB11Gnwki3Wce8mdgljETGXSpjQNhDNWiH3yTtGUm?=
 =?us-ascii?Q?HaOwZ4BvUuxlJ9sfalKyFVPW9NIK1VGgdl4TDcv7g+v2Q0sJJOuDiK3zF80K?=
 =?us-ascii?Q?yt6MOJSN1y9uQuriqchiT3H24I7CGHnFgrH0dd1iBUHfphm9h5QlKWnRgKhj?=
 =?us-ascii?Q?vhgwqwNQaVjAg3RZ8qU78vIerJMo2/GN5haLUJIKFKMHCSgGdRvHD7WQW+fw?=
 =?us-ascii?Q?O5Tr7hed1z1x0aAyVCTL3QTFVfPSHfwSiOYYSms9w1uoLPNrzYkmkvAH7An/?=
 =?us-ascii?Q?YJrITakdJfWtG11k1boqgJB+H27nF48vN7YxAk0Nxy6NvtCEbt7Im3zGWsAD?=
 =?us-ascii?Q?QyJihQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SfZz6KCA64IAev3cJmwg0pjq/p8L1nCBnhpY6mD9BXDDnSatjWvExxq0SFPXsQhKH/O8j6kquqazRUtMQ0Tsa1DqRXM84M4KWPUgRxMHRyEf+eRfWabqPAmHu2jTdJA8jqq6UBxiuWCyhvjzXcbKvYa/UtigRokOzKkI9zM0VgVY8zfW/E1wwfx9sXKghPaCkYqN8s8sa8QnhieX3Ufqm6+LvpNS+0WaW/zgztqgHgvHmPQFvyMTLWMRpdAqeEIXh6qphjc2jDfmnqSv6E9o9/ygdBCHhc+1+T33CzVPRtj2YWLRUE1LfpGu0DsGWEejvxB30s6yC8XlcmMdmubRRMNQTaMVHyrmJGbLPLBKeEosyEWYob7t1/LDnZZAzID7v4+HVgYmsiUIHXykP86Lh2j869BW8p29pEkIIIYdnX6i36ysQRIVszlCduzLTR4lVRfkwXzUw7W0y3leLNgOmI5Mxi8O0gZCWCIFVrEVy1BFug0G8vuHetlq97Md8xCn0N+2y0K19gYTA45W2nRe4pDJGUMy7z1GhScEz0DM6KZJxF7PpT7EINcUgpl9PN6P4JiQlK0xBEsO3SsoIX/d+VDJOhBW2IF4txXW3PhLP8E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2db9210-cbca-4a4d-d142-08dceda893ee
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 06:05:48.3831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egTuXffwry+sxTZJJYhoC6e17wWNCB2DDWLB1K3tft2K7WORzCtbHJaB6WZ9gNtXYpKHTb9g5miSvjD5H6QJMA+YMD40utXe9XCi55UpIOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4588
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_03,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=800 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410160038
X-Proofpoint-ORIG-GUID: sT3wqG_32_G25Vst2_FeP9Bfp3KTit4E
X-Proofpoint-GUID: sT3wqG_32_G25Vst2_FeP9Bfp3KTit4E

On Tue, Oct 15, 2024 at 12:40:41PM -0700, Suren Baghdasaryan wrote:
[snip]
> > -struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
> > +struct pid *__pidfd_get_pid(unsigned int pidfd, bool pin_pid,
> > +                           bool allow_proc, unsigned int *flags,
> > +                           struct fd *fd)
> >  {
> > -       struct fd f;
> > +       struct file *file;
> >         struct pid *pid;
> > +       struct fd f = fdget(pidfd);
> >
> > -       f = fdget(fd);
> > -       if (!fd_file(f))
> > +       file = fd_file(f);
> > +       if (!file)
> >                 return ERR_PTR(-EBADF);
> >
> > -       pid = pidfd_pid(fd_file(f));
> > -       if (!IS_ERR(pid)) {
> > -               get_pid(pid);
> > -               *flags = fd_file(f)->f_flags;
> > +       pid = pidfd_pid(file);
> > +       /* If we allow opening a pidfd via /proc/<pid>, do so. */
> > +       if (IS_ERR(pid) && allow_proc)
> > +               pid = tgid_pidfd_to_pid(file);
> > +
> > +       if (IS_ERR(pid)) {
> > +               fdput(f);
> > +               return pid;
> >         }
> >
> > -       fdput(f);
> > +       if (pin_pid)
> > +               get_pid(pid);
> > +       else
> > +               WARN_ON_ONCE(!fd); /* Nothing to keep pid/pidfd around? */
> > +
> > +       if (flags)
> > +               *flags = file->f_flags;
> > +
> > +       /*
> > +        * If the user provides an fd output then it will handle decrementing
> > +        * its reference counter.
> > +        */
> > +       if (fd)
> > +               *fd = f;
> > +       else
> > +               /* Otherwise we release it. */
> > +               fdput(f);
> > +
> >         return pid;
> >  }
>
> There is an EXPORT_SYMBOL_GPL(pidfd_get_pid) right after this line. It
> should also be changed to EXPORT_SYMBOL_GPL(__pidfd_get_pid),
> otherwise __pidfd_get_pid() will not be exported. A module calling
> pidfd_get_pid() now inlined in the header file will try to call
> __pidfd_get_pid() and will have trouble resolving this symbol.

Hmm hang on not there isn't? I don't see that anywhere?

[snip]

