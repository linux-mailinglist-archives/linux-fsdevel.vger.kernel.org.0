Return-Path: <linux-fsdevel+bounces-32088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B31909A066D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 12:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD941F23572
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 10:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26065206947;
	Wed, 16 Oct 2024 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BfrKmlMC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GsnSD7GT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C0521E3A6;
	Wed, 16 Oct 2024 10:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729073042; cv=fail; b=bXsYWeTt3p2rgIAXQjc3cWrsbwSMpxYLmvZvsYh41yREzVwpaZ4gvt/rfBquR2C7Qi7JQ50BH4aILWoow9Rc96bMrRpycL2DE7qqt4C/PISEenJcLxiYRtnxX2+/4RnPYUy1uEGeBemJg5FtCcUFDDiCnfhBmpIK25U6sOLAL18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729073042; c=relaxed/simple;
	bh=FoAbFj6bc0LJ8bIxEU5MXZE/ty+MsPwg6PFiW6DdX38=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bUqoDYV1Ld2FNNlZKNiohc6efvQMcVDkOQktXCtfANqSOVcFNDzz5bTy1R6vpa4jteGFYvfQqU0cugaO9cyjDctmYVdkocI0kcyuHuQKTK3vUxioRX8c9tQ9R2D+HoJ9PgIJOcjo3f2nycQKfiINAbkOHqns8fIDmXhPGhtMTAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BfrKmlMC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GsnSD7GT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G9tiv8022230;
	Wed, 16 Oct 2024 10:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=gqX2s4vA/Lfa2G+u
	kLi6fz4mf/xkLcvp+pDeiWIm4oY=; b=BfrKmlMCWX4Q5lqrw/t9Wey5v0PMZlN1
	HRZoQO4NbWShYaGDP2QP0qek8igPUG1TRmyl3odVIAYZBI2NEyVW8WYu/6YmIYy0
	w5CBsgOI1xl30YneXHl5bNxuxRE6bCcQnseHeGtQTLO6RrQzfqXgCh69UXbojB8Y
	UFgI/RP9AI87+qCCDJRvNAxwvwbDXKaJXbtCd/Dk57TDQOFq4bUAR//eltpJPNAN
	AH4CKwc539rV9ZKVn+hyHq7qTn1fxGRvl5JCGGTSTC+NwkGZSBEB1iL0ZGK5yX8y
	518DohEbKg4Y9Yz2uXb9Ku8D6XQOw5f9UvA+mv9aFJxW+A0NXvFJow==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcjxyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 10:03:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49G93r4p011073;
	Wed, 16 Oct 2024 10:03:42 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjexbjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 10:03:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHSON8c3PxFj/HGmW/pivveokwcbJU1D8SIu2XcW7OndPeYgpHxJ6T+DGS4PNW+wltavMppYhgppEJYIN1LG8b1/+52KNFg06pZ5gcOKHSMlkVKS4K3G3r5YfZjdVdQOS5kialrVrJwgY+A1NtQ1J4JqtnThmYOSU7XuVk75YXYxh+Qua0UsJu0NWJxvwBylIx6tmZR1n5Wkf7BeT7P6iGSEqMXxIuQ4WZYSK+N71wfLL9o8/H0bcUmapohUiL7YKrp6b6F14WqFe3/n5OziWfwbK6WV8ufPd2PUu16+TpVg2p117DxEMRXRRjkOWb5qVBBOgwQ7fheDn7a5cDIclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqX2s4vA/Lfa2G+ukLi6fz4mf/xkLcvp+pDeiWIm4oY=;
 b=ZTdutNZijczMZS2OoOZKQsaNi6XtFQD8pB1pZH5/wzi0M7GrQR0hDvnu3utoogxaw//GQ3a8P1MJPJ6/ApTeUV7tms6IBopmEP3G04fDjZS4xZfmapc7ychcD0yhmRQoS3lKONJTJEQZ5xDo5axSifhTQg3it1wIS2RW6QtShGYgoxCpujlbIDDxmzg+6D7A+tVsXhO7va+7gdq0KdMFJFdHmHai4NuHH3ncejM3cEtv1NiM3ZxA3pynD1qVSmd6o2SE2Kp+ZZ58HmJrZpINklIA7XZODlIcOfZkM5nW611OIVcPi0RwYQGULxMyDIRS3AM9A/p+55KCZC+3SHoKQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqX2s4vA/Lfa2G+ukLi6fz4mf/xkLcvp+pDeiWIm4oY=;
 b=GsnSD7GTrA9buYLqHnTQ6zPq/1w3ryD/posU3zPlhepJ41uXo53tuRoxOUGJJ2i8bqvx1GhZMWzl8UOfIlEXQqwFVVPSIXeSkd8Uk6ACYUGR95Q/ijmOfywqzE9SDR2asKKsBNoT9Hg4xUAOuNU8FeZAmbOJ3EWNHM9hAY+9DD8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6634.namprd10.prod.outlook.com (2603:10b6:930:56::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 10:03:40 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 10:03:40 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v9 0/8] block atomic writes for xfs
Date: Wed, 16 Oct 2024 10:03:17 +0000
Message-Id: <20241016100325.3534494-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0080.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dbb1383-8699-406a-9547-08dcedc9cf09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YgPw8iZYZPIgjNIhkhJA8ICtbSAPm9EL44iJKn7tX8/fOuNvXpkHC9eADNEK?=
 =?us-ascii?Q?wsm/pzD0/DqHGfq8ujCSKFg1YEddlEdS7KJVzBwCoAzQBwqlwNH0vyesNUky?=
 =?us-ascii?Q?zbAVwMHTyt1ZhuOCC7ZNPYJUkl86tR3U/2sA3OAP1BBMNc3UoYaRIoKhsini?=
 =?us-ascii?Q?J69hOcbcr5z9gp+TmzVsqbXnkFZQnIHEUPYQCspbL3BuT/g0SvIull2iTo0j?=
 =?us-ascii?Q?JIjhAgQ/PB9ocki5q0R8mhajJRDj4sq4tLpznzxFSzD2y0vXa0d1wYQF8/+f?=
 =?us-ascii?Q?4KaDMWk0krY8s8NPki0yee8Q5p9vQLxm3M1obhRnPDgdcYIPUB3/SrUZq97A?=
 =?us-ascii?Q?cC8glu+1GQxB1BYwvtfy1YzZynhV9tawHc2MTwNKc/EBkAKjx74AVJJKd60g?=
 =?us-ascii?Q?c3eMRqfLdZMGW8TohT2xaWVkBi9WtLzBp67E6P4UVueLcaaNOornjkvwPbDY?=
 =?us-ascii?Q?0042h5qyrIfiCHc1BhLwMfSEArQYZb7b9WOzOFXsU9wOCWBgVVnt3NDn4fEP?=
 =?us-ascii?Q?X4SI13zEAyrYzT57mXAUAmobDIkITXU7LbwxXJ77gRT+jjgFLEEhD1fVumMC?=
 =?us-ascii?Q?v4jkXfg4Cj4+q/crcLsEdL2+60VmnLDHcg5UTeEX0gacxr60SI03ZCyZ4TGT?=
 =?us-ascii?Q?O1OedRLDl1UvMQpxMb1+puBIN4Pmw7nqCPXQMMmxC+8X1OXh7CUoxOZyvKdH?=
 =?us-ascii?Q?7sl9wLjpIjccHm7nnaE63JORX+iy3Hfql5d/KaXsptiKDlNCQjKClCS0EZRJ?=
 =?us-ascii?Q?gtXTbPtMLcMmSp+9uSkWENfUlIVfo4r2CK6xqzswxqQqiBGRrG7k6mbveErZ?=
 =?us-ascii?Q?Wi0/WYUuWHr16UVAekvEK0JDNq750mhyf1QlPj/++PPM61FPpM2LzuJIC/dk?=
 =?us-ascii?Q?dta+h4JQ74+FfDVTe/LEoINeP7xcwR57R1A2dQArdzFhPPNKpBdOsFQIZ200?=
 =?us-ascii?Q?YxCK4565Hiz3zeC2Iu7tZ8ZZv43pb4lWAgeDqAYQ6SqxqmpXmdMWJdzbuZSA?=
 =?us-ascii?Q?+gqhBUbjSEVSH+nQt7zgdotA6cXDq0fkQn1AOdchCwUR/dTuaWgjtjE0Uwrj?=
 =?us-ascii?Q?rbFMvXoQWHDxklHzYUxyP+NTcKdIGlv4+hsNRAn2ZnemLOrjtGs/bXFy4hOD?=
 =?us-ascii?Q?GvoHDs+9fQ4XrDMjTfKVUAKaIAwv+k+++mVbC36+3+GySmLt124odqaGhJb8?=
 =?us-ascii?Q?MiWFaWs5WEEeWk3UqbJipj6VNlJaflUX/ytX+oS9+9j7T3d+OVf/vWta6RWv?=
 =?us-ascii?Q?Uam+JPaFt4AevBJot8cz2z88k1fFMcGGedek3FlMiw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GR7yyRVg2wgSvzbyTWRo5FqiVkSgEGJi5FzlScXG6O3bYCUmcwIfUHcBSoKM?=
 =?us-ascii?Q?ZPPWjFF5/uC+/REeGsjLlDTmGYkKn0iKSYxiJPjl5JR8sHWtuEtvOUlAlVpQ?=
 =?us-ascii?Q?JB2UwVuzmSlzK+W/0p2xRQQExTDwXVFl1srKyLcbzMEA2A2JqoCFGQXYb8E2?=
 =?us-ascii?Q?f0Hfb2M1ieTu2eHoax+FouTNvHcrhIPcdRGhxvM0eqozqu9O9A3jO0OMsZeP?=
 =?us-ascii?Q?lKBQ2h6AJaA+mxC8ksdRnhRHzPTlv7kDPcqwVd58WT1J540vsKFfRsazKvoy?=
 =?us-ascii?Q?dLk0C+M2DGfk2r8BCWgdfCOsIA4Pu87PtenWPXDm0EnqYJtjwnMw4exzLrVc?=
 =?us-ascii?Q?aOXM+SkuP5HCLuxVYKPz52GXmghMpulqS+rT3iEdwvm7ME6gqBU0r8DmGK9C?=
 =?us-ascii?Q?sd6OXaqvsmsNSLkPr0bwLpVss/Xhf0f3wLMTRrVh/rOrzLBixn+9cpAI88H/?=
 =?us-ascii?Q?z3MWfPkyrfEDu/COY/CtMTWRSEzhozdtOg4Hc1PunxJb4vyejWhYcRTXrEIP?=
 =?us-ascii?Q?FruNmPr4+lmGOy53Ml5gPaIo/bHFZS7pQlbBrNFHLw91DMAfhneP2T+x5FpU?=
 =?us-ascii?Q?Dl1Llve9UqLjxNwFlSQDzsOE7JMNoCh4jaiOAk8zNIySP9jpLQrO84qXmCrY?=
 =?us-ascii?Q?92rfQviEug1wE7G113qnyTiR2gz7q66scYk3YHJSzqvWR/uXXrYYpGs8q/LM?=
 =?us-ascii?Q?GjpiIKjctNAyEGmJieTd8ijZwUNfQkyTjpQ2oJqta5WuCUVHCE08bvvf2AaW?=
 =?us-ascii?Q?TT/sik2ia5ncdfTfB53JHAYMdn57ivkKCmAjJAVVmRr26yBx3zyPdw/jYQJf?=
 =?us-ascii?Q?8bYa5MZlnr7NiM/HIP2znvv3sZubkJDbHm5HkmZqdH8bzxR/i3heFmCnvJ3Z?=
 =?us-ascii?Q?Lqe6iYuKT/YQkQjdsLU5dTQ50ZEKXS6h0pkKb5rqIzF0S8cYrxWbUEph7V7G?=
 =?us-ascii?Q?ZVIxNR4lkq+GZWGA8nEdbSs+KnFdxmxxE1SfddEALh+9eyVYcSz6RAE/vwkR?=
 =?us-ascii?Q?r06MXYVYQS9sCvsdTAjvVEEOLOLLZQZQG4TAwiMSPsBskaz03LzgW8iNdR5k?=
 =?us-ascii?Q?dWjAJ91UhovJIyKM9i3btCR1dqp5GICdgPgCxXFu8+O3qv+cFLjI8h/xnc7W?=
 =?us-ascii?Q?R4v2w3YAGM4LzloBY0ps7GY8NwNpden+zQFj6g6GgQfbT/JlsAHAdtHaBUoS?=
 =?us-ascii?Q?GmsYPfZfJpNgZYgEA9mC1nCQMuAk6UX/K/T2a2wZN5iwYaSy6qzylt7BxdcG?=
 =?us-ascii?Q?Gi+OSjwkwtNBWb5zyI/n+GxhU58sA7wtWwRn6C8w2TlUsd+VfGxhVHBpVdmb?=
 =?us-ascii?Q?yrbUklIwX7oft/FTMCvXodq1DcorWjtlJkEPVDNz3/vFFa3c2N06y5u8RpO1?=
 =?us-ascii?Q?tkUo4UKZKSD8RS2fds1W8OlD9XJdfigJO5Dibz6w9TmTv2pgwvxJbDDeleT0?=
 =?us-ascii?Q?u7EZUoP0mHzGX5SyYRdRVps/lztUoMBeTsCF011F0D/BO1Ztr3EUFUOK7Gsj?=
 =?us-ascii?Q?rKdu3I8F+P9hH6v6AJZTVwZGlS8ztZhBv6KmkukgOGfCqKxCvVjsTPXGXosX?=
 =?us-ascii?Q?s5NB/v6j6ulz52thH+mce/jaKw/L50DAibJ44UwxVlDJUzsukAIlWi065zTm?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GmzDofum63R+0gFAkLojiqGwvaJs7ZOyVOskLiq4UEbjFcgB31O0SZVW49V/4kZnHF+7dekKX2XtK69H2KmdpV6xRq/F+VbAAsMtUC/F+HJUL773Wwb5gDd74H1qPSDQWsr32DC5u6Otih9jTJ2tbVN/4Wxwdus5xOYRcD/vBsvANEgH3OzSD9mvfsuvOmcOiMoW1WGfN6hTqkWN6f1B/3hhXclUa8MbQtUh7QM6TNtVZIoSwOadKw3HG8rf9xBlH+SBu2wJYgywRSjLhGZYNs0x0cDahOfzDYmWjfQSRHb+WcgIn59uLh9lRMfGjH5iOfUNhGtPaBZiRhaTMCOXBTBmWYUOymJ+1cK08HLTHXcYNuQG+DBx9MnHgKv/ggZk71SDLzLPmt2zIh1Mpy6FIKWArh/G8/ZWwD343CLiY83uQ6zcnnUp1tHkdPIbiNwQvNW3CZTnJgPeGd7waPNPUP08krONbPIG4OuGAahiBouekFv3lYJA/2k4RlOUVqMTMeobqpQ8rwOI9GDJY81FKAvM+q6Y3BJTlGWAu5rdHPwrlsi4sWtrqpgR1sPhUN6Du9wu3NCfEgVtzsc9nrTY9bbRdyXuCT/zp7XJqXOLOo4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbb1383-8699-406a-9547-08dcedc9cf09
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 10:03:39.9283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoVFxBu58zMyt/C8UBKV/IXS40sTUg5jI5azY5ZzCSuAr0SR3/6UOaiWJw3X5Fxh4DlLNIlSWbmdWFtPHYimwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6634
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_07,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410160062
X-Proofpoint-GUID: hSsBEsPMmpysqD6KszDtlTUcLFeGH0Bu
X-Proofpoint-ORIG-GUID: hSsBEsPMmpysqD6KszDtlTUcLFeGH0Bu

This series expands atomic write support to filesystems, specifically
XFS.

Initially we will only support writing exactly 1x FS block atomically.

Since we can now have FS block size > PAGE_SIZE for XFS, we can write
atomically 4K+ blocks on x86.

No special per-inode flag is required for enabling writing 1x F block.
In future, to support writing more than one FS block atomically, a new FS
XFLAG flag may then introduced - like FS_XFLAG_BIG_ATOMICWRITES. This
would depend on a feature like forcealign.

So if we format the FS for 16K FS block size:
mkfs.xfs -b size=16384 /dev/sda

The statx reports atomic write unit min/max = FS block size:
$xfs_io -c statx filename
...
stat.stx_atomic_write_unit_min = 16384
stat.stx_atomic_write_unit_max = 16384
stat.stx_atomic_write_segments_max = 1
...

Baseline is 77bfe1b11ea0 (tag: xfs-6.12-fixes-3, xfs/xfs-6.12-fixesC,
xfs/for-next) xfs: fix a typo

Patches for this series can be found at:
https://github.com/johnpgarry/linux/tree/atomic-writes-v6.12-fs-v9

Changes since v8:
- Add bdev atomic write unit helpers (Christoph)
- Add comment on FS block size limit (Christoph)
- Stylistic improvements (Christoph)
- Add RB tags from Christoph (thanks!)

Changes since v7:
- Drop FS_XFLAG_ATOMICWRITES
- Reorder block/fs patches and add fixes tags (Christoph)
- Add RB tag from Christoph (Thanks!)
- Rebase

Changes since v6:
- Add iomap documentation update (Darrick)
- Drop reflink restriction (Darrick, Christoph)
- Catch XFS buffered IO fallback (Darrick)
- Check IOCB_DIRECT in generic_atomic_write_valid()
- Tweaks to coding style (Darrick)
- Add RB tags from Darrick and Christoph (thanks!)

John Garry (8):
  block/fs: Pass an iocb to generic_atomic_write_valid()
  fs/block: Check for IOCB_DIRECT in generic_atomic_write_valid()
  block: Add bdev atomic write limits helpers
  fs: Export generic_atomic_write_valid()
  fs: iomap: Atomic write support
  xfs: Support atomic write for statx
  xfs: Validate atomic writes
  xfs: Support setting FMODE_CAN_ATOMIC_WRITE

 .../filesystems/iomap/operations.rst          | 11 ++++++
 block/fops.c                                  | 22 ++++++-----
 fs/iomap/direct-io.c                          | 38 +++++++++++++++++--
 fs/iomap/trace.h                              |  3 +-
 fs/read_write.c                               | 16 +++++---
 fs/xfs/xfs_buf.c                              |  7 ++++
 fs/xfs/xfs_buf.h                              |  4 ++
 fs/xfs/xfs_file.c                             | 16 ++++++++
 fs/xfs/xfs_inode.h                            | 15 ++++++++
 fs/xfs/xfs_iops.c                             | 22 +++++++++++
 include/linux/blkdev.h                        | 16 ++++++++
 include/linux/fs.h                            |  2 +-
 include/linux/iomap.h                         |  1 +
 13 files changed, 151 insertions(+), 22 deletions(-)

-- 
2.31.1


