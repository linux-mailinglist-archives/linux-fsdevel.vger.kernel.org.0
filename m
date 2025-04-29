Return-Path: <linux-fsdevel+bounces-47574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED8EAA086F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 12:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D16C0842AEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 10:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941642BE7D2;
	Tue, 29 Apr 2025 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HjWRfFTw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bHOgM4/C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA522BE7B2;
	Tue, 29 Apr 2025 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745922228; cv=fail; b=EKgxCy9VGUIha7zeVxXJhiYQJIUUuuJQmvIiCTYWd6q5G1EBHWzPnlJXBlio+8ilomvcgpEP7EwWCqnMHptwHGDoV0YN1Kt9ysS28ac29juMeEVMLPvSibbltBGCZWt1jZH+uzQJwfvciA2CpBpI3tpL04v6C70gnYvMGZexr6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745922228; c=relaxed/simple;
	bh=Cl5SznILWpyIcQQq/WX6U3OTi2eyoX8HhZKCNdPD6fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eNGNfPErB6XVfQwzJlu/xQ791Z0RTY6S0fY9XcI/lurcD9XWsqXxI136s2KiZL8g5QnFRLvwPHBXR2VwCfTHjYnhUquqT3NjP9y9JHIV6o+mAzCO4BZWzYXa86IGcxR+3HRMiMtY3bKmCj/BU4pROmCxSJlb6cNftoGEJmoTAFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HjWRfFTw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bHOgM4/C; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T9b7HG006195;
	Tue, 29 Apr 2025 10:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Cl5SznILWpyIcQQq/W
	X6U3OTi2eyoX8HhZKCNdPD6fo=; b=HjWRfFTw7+25oUkO8Nfp7rpLec8OfddyDb
	H+x6Zd2yOINsUqxCDVE46n0RYnU1OFG1sQ8rXzEK9EQCGQaaAB2rkn46Ji0A9JMj
	3khTseRS9Es+K9LUrKLW7cuPjMBUeid7V5OFczzg6YiagC9NutfbLdhLcPHsiRDq
	ExBvI97mhcA6PQZS/mGQAHW8LCetzrhEhSCF0qCXUZ3dIo7bT8LchCAhk1M9qME/
	mEr2MRwDyfTFIWt/uLpvVHPnUgl2wDpxpzhUbZ5cqYmW3+vS1Q7wEsUpxAqC3vKG
	RhTf54EbIu2hbQGp51JkQ99oykIc7VVCYS26YfHwZGImRn915img==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46av9t82rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 10:23:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53T8VcNf035394;
	Tue, 29 Apr 2025 10:23:32 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010001.outbound.protection.outlook.com [40.93.6.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nx9d1g6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 10:23:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gidECGrlQzx4m/AscHKYw9mq/c65W9dXJNttu6W6ByWcHZd8s+6kR33Li5YqPSv4MSG8Gealgb5Y3tmvyuChVs0AxUTcohtipacD+hc6+wLm1Ufkqo5KYuDtuML4c8az0vjFxZSdMs4U50z8BLmMeTTgcHgGXWt7Dto+3qBeYwSULr+a8Bcru9WFwgXEdNGlRIGQdHlypcYfo/a5Bx/pK+eH0Wk1eTPPP8NXnGS8LWb5D1VKp1KXt2HtM/HpGTYOC9/fJbdW84wD2Q2JBdBgIm6iVYgGzLoyA4kpRM+f2oL4RXNGrTRuzMLvfAIaMxKL6H6MWoiSbt/g1A/yYW8sjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cl5SznILWpyIcQQq/WX6U3OTi2eyoX8HhZKCNdPD6fo=;
 b=w6SWtdjHpboiGsbXMUDuOm5tkuvx8PP6xzmwD/gL44rN/BHHlUf2XNQgz+88unuNrnGiUm/BqWGrn0PMFK+AZOFIjgFCwkMXSNG+V4eYKlfpXbtsue2LBHa/iW5tF7AltVkP2tJ77ToXX8qF94kxVygrMQZHnS1eeB7c7OOntbkq22VaW4450lVaDIDXwceP9BqVc+00oRALgkdTm2VzrZMg7Vw1B/P0W+IhId5d/2QF4Qh9aOnlU5jkV4qdU029dQRwl37jHpQeSD/RFfBeLGj0xGT7gWSwT1OpaGviqN9fq98ronvHgsSOpdDy4nRAXa5A64hzR82x48/4FIubtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cl5SznILWpyIcQQq/WX6U3OTi2eyoX8HhZKCNdPD6fo=;
 b=bHOgM4/CzJjbE+smwbYuf7U2/HgyJGQeTT970ewCsZe5VwlsBElz04W/GMfxrOqEiPmvYBwDFOV6onw4fFD7upizkzHg4dkLqB4X5W9JDHHIcxqf+371jpiea1m4LQcnmEDMWzR2S4lnnyiiV0YDZhbziLX+tpPMAu3CM2kL7vc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CO1PR10MB4436.namprd10.prod.outlook.com (2603:10b6:303:95::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Tue, 29 Apr
 2025 10:23:28 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 10:23:28 +0000
Date: Tue, 29 Apr 2025 11:23:25 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] move all VMA allocation, freeing and duplication
 logic to mm
Message-ID: <e5564971-b632-4619-829e-342cdad02e25@lucifer.local>
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
 <044b4684-4b88-4228-9bf6-31491b7738ba@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <044b4684-4b88-4228-9bf6-31491b7738ba@suse.cz>
X-ClientProxiedBy: LO2P265CA0193.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CO1PR10MB4436:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf4e3ff-f4d0-4400-3703-08dd8707e1d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mFHn4+1jnAd4aQC1EaPhYchbPz53mwP1eqOz5ZE8JgI+LO3oL8NsqOe25UFk?=
 =?us-ascii?Q?WZxjpAI3zJ4LtsCyw0gxW49KSnSQZOIZHrxPekoMtwI4dti2l6kyJjHtk5L1?=
 =?us-ascii?Q?RYQelzc25uNOW7wJkrDpW7JmXH/pIUNreElfljamBMMecx3m0QVtuhqNHuIj?=
 =?us-ascii?Q?pc9HGdgkFyRwY2kCXhPFjHUVXtuw+cd0dNCHT4ZqiZU5F3+vxp5ITFKVlBbH?=
 =?us-ascii?Q?0EVfYSrrNTr0eueWst7PcX720zTkrnNpv50rJF4i/dRpuSBYKOb0Usk8Bwcp?=
 =?us-ascii?Q?SW7lBbRwIiyqNjhpunr74ZRicsVFH/4990OBWNFL0UnMzunHyXqYnuBzS7gc?=
 =?us-ascii?Q?i/Wlgw8rd3AvQF+q1VFOQ3yVtfslVrrOSYcMFYhrjsSoOQx07bK94C40qpQ6?=
 =?us-ascii?Q?XTMP5Rq4VwNbUsG0dZR64FdzrklMf6A2aWOwqwTVeewa0Fs/c+jZFmbkap6B?=
 =?us-ascii?Q?T7wdbtlvCe8n7U69SvbjyjrBPoexxkJr4RK5QV0kAVeefPrVA7094Yp+9aNZ?=
 =?us-ascii?Q?lTU2QuCoVPgQWo+W1kEOiGbg3UzjL7Dknsa/jrHGiih7VuKNVxEEx4XbBuPP?=
 =?us-ascii?Q?ORfGTWkjOixSQmKN0dp9I2naEBueRp5pDj0DJ3ECM/5+aCUCF3iiaa1eCY3A?=
 =?us-ascii?Q?8d7tnDjfZeY/A0Gh17vcLSWud38jof0RO9PUPdOdgIkauSfY1pQPTLLVkC8c?=
 =?us-ascii?Q?EiDjef8yhnKCEPHjFUfGUQg7EIWVn3tcaTXZDS5XUEAoYLkWPMOHmM9QLxtz?=
 =?us-ascii?Q?GVldWBu/35z6oNtaZ3MekXptPgakwa1umly+JUPLZ+IXP3Fa7MzhhFrQsTkD?=
 =?us-ascii?Q?j7xvgz0F9F7zMOjrMaadMkC8A4xajf1uTuoXS27/SAe/txgKztC3U7HmzemC?=
 =?us-ascii?Q?ENxZHS7KIa045jMSPsRJgtx8KR1qgMTYUBPcuTC7IXAX+S4BKW7e3yRdwa+N?=
 =?us-ascii?Q?LgIK5Wi8A4wY118FkqY3wtSvb/ciT4wCK/UIa3CA0U+ULfXy2qJDIXZSZ/6S?=
 =?us-ascii?Q?rSTzp7nJTL5XWTKzu6IbZY6lCYw5jqzs5GLL1kb3EXin7CX11OjcnGBj73zG?=
 =?us-ascii?Q?RsQ3mao8Va7u/3/ndDyuNgeFEuXtWx6o0doyAA27Mok13kUASl/IvchkyIt3?=
 =?us-ascii?Q?kjKYM/V/4NF02hK1mp/AT3vDP03ML3XPwVfgBinEkfKasvlflyt7Dm89178s?=
 =?us-ascii?Q?CcVuTjIdb1c5ueW426wLCB5iofWyoCcPyVWIRv9E4aEbKDU70M9XXpYraWfN?=
 =?us-ascii?Q?h3Vtscjo7jt+2Cnt7FG/s8aMfUaTCLnVn4XZvNO1qCCsXsKeXPbFKoUHR3qf?=
 =?us-ascii?Q?HN5wf/Apmmb7FBb7S2RADPD2/DKgJdvwAABKZOh6egFjb7aCQd8SA3ZvqY7y?=
 =?us-ascii?Q?OLDeBtgphfhfHgv4j65Sba2FhmWBL3uzvZwWFPyvzTQS9PYZwsWMRnUQqZBN?=
 =?us-ascii?Q?ykHAqIyCiM8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/mNv9tSnv32K+9qDRtcTIq6o8M+XqLQVLrTWjgsyAfw/mHYB3Xemn1X2XZFJ?=
 =?us-ascii?Q?zE+Wj4UQdsOvDJVsqZJmcXpEWlz+7eiJfghxrM1MwLghiUSBPe+sxg041foL?=
 =?us-ascii?Q?sPhBO26BCijKzXeniHgboX/GMOB3/rKMHPVzL1B4Jdb/WjI3LQzUSQdnGtef?=
 =?us-ascii?Q?nKUoWEmIIdYvKO4FSF2VkImY0JaKBJK5doktYhKMiMCbAA3EwqOTZ3kWE6sI?=
 =?us-ascii?Q?E7dhUOYVIFhqKhSxfu9wleO3eE23AvcAByyV83+gxmWBiiuXtJh8wo/cfE8o?=
 =?us-ascii?Q?I29ZvBecegoAEydhXtwHDz1OhxN9Df+zIRo15Sls4qeIkQZ4eqNTnZ4X58Ud?=
 =?us-ascii?Q?xThYhBvBzmOfhvgvCQRslAV333Y5Om6CvhfkbLsazugbl9y7n/2CdPSH/pQA?=
 =?us-ascii?Q?G7bju+7N1ACWK2jlbL1dsVks97Z4qwQVr/tWdtxS6/YXTW560YIq3LJWs8Yp?=
 =?us-ascii?Q?IMA5Eidc7JuW8aAi3TjnwmxUopm2uS5NZ60O4fEc9nKNGB/sWXdmyvTHyrDc?=
 =?us-ascii?Q?n1VT2EkeeuS8Q8s8Qzl4s7k30ydfQBMli/qnLoaHrM4NSF6KKKyzwMuiTCsV?=
 =?us-ascii?Q?ld3T4QXlMCd6zRoDjsvtlQ5NUHKUHGQzZL00HbfLoRpoVa3YwUbMOICnvgpx?=
 =?us-ascii?Q?mXg0ntzQsQiz0/kKd5TrW9xuV4PmX1+fBv7QxCuInKFy4tHiCKIZouLlzwY8?=
 =?us-ascii?Q?LV5Vs3pwgPK9BJ5CZ3F4mYxZVST32sz06kw8RFEoNBwF79Z1kD7h6OQ6DAa8?=
 =?us-ascii?Q?2xSjI3uu8R9lBfHLiXFFud1wZWochC9jFiTZ44aqklfWobps045loKnXzdpq?=
 =?us-ascii?Q?rO+TlSx1cvRpCoZUAl6aYc0mAC/nP8FiBwNVNOpkrZTmI84SPgX3WoSHyBi7?=
 =?us-ascii?Q?S+oAoVnVpUalx8lvL4R2ia75d37M+mbf7SlQvDR1E7x6JvCBLDmsDTVyjGaO?=
 =?us-ascii?Q?i7GGL7q7MYMdMgSZMGJGKdPbICeBu/MZQK8DxvgDG0OcY/URdCgvIFxMx5So?=
 =?us-ascii?Q?TlwAViBoLwxnnYPBBqzPlMlSxP1jcdEIb3Ukj6fUUT06oRuxf9PeokZxo+4O?=
 =?us-ascii?Q?gQ5hh/qONGFf81kneUQMbOHAE1kuZsl/cWgbRpSCoQIwrakQLtrbnltZMtjr?=
 =?us-ascii?Q?PC1LTD8OV8bcI9vYuJivYbjx5RXeQophvCdN36eFco7iMJI0puJNqLFkgNuA?=
 =?us-ascii?Q?TUNdXjXNOt/zYQX9xWFNTjmeobQwoNDVhLiLsvWJNu4M+01spYjrDygZR0Cw?=
 =?us-ascii?Q?a7Pa6OZ8XsRcYUSn4Pz0/fApKQeCjHZn6GC91q74dOWA7fXg4BExkN/sFr6l?=
 =?us-ascii?Q?YMvzlDmzTT3BKWF15GvZimaKCj8dHEu4IkvOr94yiDII+kmoq1WwMkc9kfXc?=
 =?us-ascii?Q?9Nvk8bPTDhFjg4TVtaRLECFzve/8syZ16R8QdKqY9HNTpPRck8RiVdlfMdac?=
 =?us-ascii?Q?4GZ1m3yGuUD2keSUchoZBBrZasCTuV00mx9WosexdvmH8jZGhj2ALdavae68?=
 =?us-ascii?Q?RSJsupL+QXdquuGGbCD10yGhqfZcOmQilCBpr6j6Jb6kmr2GMIhE8j0geUwd?=
 =?us-ascii?Q?eZOcwfyJeh/OnV1oDXAcJMB2KMAxPO5/OgDE/L3WfjfHKuGm1Kf6tV7Tftsx?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8ItNJfQqxdvR24jCWyQs0TgF93SGIwoklK11p+76058T6OI7Eoi4SkOzN96qVEqzEYLVAc+Jc3YM2Bim+kBRcnW38z6iq7w9ZHyWGd81EAGD6sOrrls+VcMFNkXvq3sn29dq1OuqxdOm3Yp1owuNQqfBln/IGXwQoFmOivjJSE5JAO9tG8gL3Z3IIRwp3G5FQy2lX563ACerJTVQE+Lxbhv7GOiH6L8Kkti3Q3wOUcM2ywDCHszMgn2SVx7xe5v2Aqz6gYVuWxVwgqOnU4jATpAhDTUZK4ARmxeLpvJ0UtXjEeVMlAPI3nWpK3KnI6kwYJR03mC8mPkhsn8IwfG035YZrFhIYGTaAYMjd7Xq40U5BGoFJdEXtcI3ISutQCUhB7afc+cK6HGFnifdCMm8PBo8w0Cl4SPNW0ufiZaSoYNHcKCQ6FEX30t6feVOw+AyFj+yU6OZ3DhoaAGsn4Fr371aioPcGe45pzIyRL15P20ScVM9a14cByLtmCK1uxYXl2bAH+J0sal/Xl8WCfpCz1r0QEgGLeK8m0hz7Wjw92HtdZMvOh7R+a3P19EpUeovMBkI5Ps83yj8Kzvq3poB1GxkJKO9REkeL6UstmXnR88=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf4e3ff-f4d0-4400-3703-08dd8707e1d7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 10:23:28.0680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utMPbkp+RyYPQ9zoO+ZNUb3v84XRYXcCulz5JMAFrcpP0tV9rW0FQi3UQIz49eYqUxYn0/WkwltPMxPCAwMbSFE00Iyi6bIOn/o00BYzyGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4436
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504290077
X-Proofpoint-GUID: w7HK_1FcuKQP3tOaV57g1wy0mO2oHgTe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDA3NiBTYWx0ZWRfX4gq/fR4C7aRS XREsZG+jvw3VWzPxmabNAqg4VOeFXCgixFpPavdLDDjFigw9tNbyOAfDWcOHUu2XmNHF2I6bofN W6JzShdO7ZVaQRqVFbSOU59kZjZPO9u1BI3SejU5OEJ6OrlepvYdAs5Y/GY6PfUGAsJJwsDqEHT
 CkmCp+4zgSxoMlX5ybl0xvpxYYzv5Z/NoClI0XprOVDYT8gSH6AI7+YKb4wRNkhPQ1/lNwoiOhj GulQtnFR0tv9jc1263yeD6Uhgb5F/rPp87mHM8ax0AVOdNq9H5aiidjE0IAq1UGq6lAcfu7P9Zd vCjJxo0J2HbBHlFuUGK1sjV7ckNAarY9VjKkLrNUpGhup0pRwWw1VZEjmk3h8uW0Sh5X1oh2tbk gNXkocLW
X-Proofpoint-ORIG-GUID: w7HK_1FcuKQP3tOaV57g1wy0mO2oHgTe
X-Authority-Analysis: v=2.4 cv=C/zpyRP+ c=1 sm=1 tr=0 ts=6810a8a4 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=1PpqRIFuUACU2eqaCkgA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14638

On Tue, Apr 29, 2025 at 09:28:05AM +0200, Vlastimil Babka wrote:
> On 4/28/25 17:28, Lorenzo Stoakes wrote:
> > Currently VMA allocation, freeing and duplication exist in kernel/fork.c,
> > which is a violation of separation of concerns, and leaves these functions
> > exposed to the rest of the kernel when they are in fact internal
> > implementation details.
> >
> > Resolve this by moving this logic to mm, and making it internal to vma.c,
> > vma.h.
> >
> > This also allows us, in future, to provide userland testing around this
> > functionality.
> >
> > We additionally abstract dup_mmap() to mm, being careful to ensure
> > kernel/fork.c acceses this via the mm internal header so it is not exposed
> > elsewhere in the kernel.
> >
> > As part of this change, also abstract initial stack allocation performed in
> > __bprm_mm_init() out of fs code into mm via the create_init_stack_vma(), as
> > this code uses vm_area_alloc() and vm_area_free().
> >
> > In order to do so sensibly, we introduce a new mm/vma_exec.c file, which
> > contains the code that is shared by mm and exec. This file is added to both
> > memory mapping and exec sections in MAINTAINERS so both sets of maintainers
> > can maintain oversight.
>
> Note that kernel/fork.c itself belongs to no section. Maybe we could put it
> somewhere too, maybe also multiple subsystems? I'm thinking something
> between MM, SCHEDULER, EXEC, perhaps PIDFD?

Thanks, indeed I was wondering about where this should be, and the fact we can
put stuff in multiple places is actually pretty powerful!

This is on my todo, will take a look at this.

