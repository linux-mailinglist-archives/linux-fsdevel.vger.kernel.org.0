Return-Path: <linux-fsdevel+bounces-60185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C741B42882
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 20:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3499C4866FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 18:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824AD362066;
	Wed,  3 Sep 2025 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ef04qDAg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="en2+Wqov"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F61E352062;
	Wed,  3 Sep 2025 18:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756922854; cv=fail; b=hQbBB+J19MjcuJX5dziYi8/FK2lGzJKZdZU72s6OIR5FochhTximeWGdKLxmUmModWWFFILoriY508zkAW5h3ZuBUjT8K1/FrEHCdMM9Dy2MUNvkNiRxPsHQIOAIQRdaFEPWc4eaC6tf34kxpqYdo5THaUgvo4leIYJcnlQpxHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756922854; c=relaxed/simple;
	bh=Qkp+ZpenYS8tsCsutWt1GNC3Ve532L2YHSuqR4PdvmY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JrGXLyxpZE1nufwyhwqw7fAg6uHOM4wsG6NwaZ4lrB0+DDNXd2w3ofI67ssCI7ESl0I0nsCQ1VDeoDeQpj87CvKnbksscMVkWv1CnfZG1B+53ImF6o+/n7w+f8k6JoaCncwq/krIlYWtzcyWLii/q49/EC9GNFMZ20yeqIZJGZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ef04qDAg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=en2+Wqov; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583HsdvQ021907;
	Wed, 3 Sep 2025 18:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=4fM0IOUTEZvi0P6I
	ZUWiooGYiaJY2q67jM6dQFX3D9I=; b=ef04qDAge3gpat14H7nHY9312lZfrkai
	2snBuSCeLGxPnR+ALbWTBCJV1Tvj5g7cirQjcCehjpGpZbwmHXCC+PryMeszGBdM
	7zMO+avLr/vybO42yhv7cQyyqPwhwyOOd58ie6xWpAa+EW93XCiGFzpXIWedLhwb
	JxAXk4qEZpg1PA1pA7mdfCoT2y+BvKja30EqpmqV1qWzZkQPQJS10wKhbNK6XtF5
	c7vLHc7M0euVtDguh5UXGIkwfxkHZPYTVjst8kvOQ+lWY74sOfudJ8U45/3o1/Dp
	VD1U5xDpebFHuP2A0uWtKg0ZOu2+1IKjTspUclPh7jSFx3Zy9C1UVw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48xtg30104-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 18:07:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 583Gwgc3036099;
	Wed, 3 Sep 2025 18:07:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqramubu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 18:07:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTnqyhENjWrR5de6XvLB6x/VY6pCl7zpWA0S8Ag7xI5SCSuHD+hXjfxnPkeRmd+nhPjV6aMD0cZ/wDMuD3y6UMkxLd1OtTy40jt/zFJtLHvfiMPANwN4emDl8ZkPM0HmcRccpO2aasXnOaZEpodam52OWIcMQfiLNG101X9ZxU2cRpR1MvkxtoMVsvh73NcuCXbfv0/aRARJ4JBbNEJsIZy/0YQDqIIAGNskn0A0RoaD4BsW+4VzMvxFrVlq3FghRARixuoBSmM6Fs8DBhmZ3bejGGTd/aq3yVCz7OXNu2MFeuppygOUDGXMnIghjduB2DVugbHVT7MCHo5xsXOtPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fM0IOUTEZvi0P6IZUWiooGYiaJY2q67jM6dQFX3D9I=;
 b=tTPrbUY8PqHfOr24u1TyNFDhJLuNEmwFbwAWFr3QXGhWyy8TWhStf/aFg+ogqSfo0PPT7nAHO4gUWQ6Df+6EqKuewnbptUIL3IdH9W4Ol89U0/CBPqlRVGkXoSMeZc18yvxYxHWV4/MYrQzn9q15hxW20W+oxyuDVHGncg+cn65E0C3VueT5NUYxjJgoT48c5QRTHOyQkAazPaM+x6sKfirOMftqwI4Y5HxNicdJv9ip4XeG7VWf6Cazk6LsKe15g2XIWWitXKcqiNY3dNKl42FIbxuCiF1UTlCEWb8DONQ+NmxmYNZknABMN5uGv3jiDItvuF4CcWjc7BMZGve6Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fM0IOUTEZvi0P6IZUWiooGYiaJY2q67jM6dQFX3D9I=;
 b=en2+WqovBfQJiBgZtqVoYZ/nsP+ax9NQjYLbPIaD9Zp5xtBGwpVwhH0bf73Vzdk+Ppkv94trJiH7c3tlATP+u4rfm/G7Lp8g/B3bbMp5sxLydahqTKE+1bnm0+zfRDKK7EvUiTaVBlCDUFffGDvhHACU33c+Z/SbWZfIq/cfnD8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB4846.namprd10.prod.outlook.com (2603:10b6:5:38c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 18:07:22 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 18:07:22 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, Jan Kara <jack@suse.com>,
        gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] gfs2, udf: update to use mmap_prepare
Date: Wed,  3 Sep 2025 19:06:24 +0100
Message-ID: <20250903180624.218013-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0397.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB4846:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c44549-ccaa-4c9f-b7f5-08ddeb14bafb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yaj/PU5MpKoKggibkLMFFMOII1ek1WZM6hZHwoML+SMo356Mh0kkT/35FX9K?=
 =?us-ascii?Q?sFX32zzf7to7XUbTpF00s2IZYN/8+39dlHjAyr1sx/pKcE67cehD2fMXsHzg?=
 =?us-ascii?Q?+/MHrvlhgYy9+Lnxzon0ibzUbAKD4V0DNnNrJgsWDIDLnlW1rm0fUwgC/h/u?=
 =?us-ascii?Q?RenkYFCh4oz+cJjzLz4ej2wUG7BI07FtdZYTD0bgB70z0Ki80Lwm9fQhq+yu?=
 =?us-ascii?Q?ln3BW3BciJZNtzSTOYxyP1YlWAxMR6NvlZJAPU2ZRcPBYLeHINR/LBDdswtA?=
 =?us-ascii?Q?rbdgA1eqstirMBsD7KchD3fFTvBb7kIv51vH0n8QjePfQJPGN/N5S3B1+BCt?=
 =?us-ascii?Q?4e8bixA0t/xjZtvu4hyPlQYUHqK2+v5jBV7WgyAxKbhs90QyfPC35uK+TZh7?=
 =?us-ascii?Q?5CxGUuTkV3/P0VkswPn06aGSYYNFVVZexIzIGjACM1Ov2CjR1IHuo/8utXpX?=
 =?us-ascii?Q?5o4hIaheu2PTH8pvX4dmOw++2TrzbnxTObz3451wNWbXxloXOvME7IxWrixl?=
 =?us-ascii?Q?wITZUVtQaNHicd2/bACDkHuunHtkWFy/U2wXzUuoYHd70Pxrr8aB5f0q/f59?=
 =?us-ascii?Q?taz3/AFoDg/M9btZcWhUt089slipP1xHkEiAOHyDGGWRLPdnDvnmF3gyvMb3?=
 =?us-ascii?Q?xbinvwYp6ExeRXT7UOZeBt3q9WMqX1QgAc2Qq+ysxQkEPcWkEDGDAdUJSH69?=
 =?us-ascii?Q?7/VCu4Yg439EA57HckYSI+YBPb8KSz4fEgrbRnR0/rMYPh+nivYe7MvzF6ew?=
 =?us-ascii?Q?weQz6NTiS1Qe9JcUiUaodF68UwsJGYwGYxvoDxWm4d/oe1c1UU5Zfawz5z9e?=
 =?us-ascii?Q?r5kRJbZ0ceRffOpAbyBiD/SI17hgoAqiFBfSTcspBblJiPwSW6fZShtTP4Jq?=
 =?us-ascii?Q?PXgSr13WeYC2s8iNWC0hLQcc87SWlg6NqVnJGwHB8ww+WT+sfmgOrdsndZNl?=
 =?us-ascii?Q?HHXLPItFnSiGMXi6TmKG/dLcdl5VVGYKbg5kRBe8ScXwkaMcpULLkHKynZ3O?=
 =?us-ascii?Q?QakEYvxm30JXP9WvacavXet1XzhgAr1+8lXm6HJmqjSjLUu9tNGSAVjtYHHL?=
 =?us-ascii?Q?lCNmx08x9etArvr3OWq2oTPYRnlY3TLIzyGb35nFiPQTZLivTGJ0lSNfKzcM?=
 =?us-ascii?Q?P4U5pJcyPSNmYwN44Cvt2TDXH2bb27HHe9Y381ritClEu81HK1re8MYZ3FIw?=
 =?us-ascii?Q?GpVXIBaeYNMBdaT6/IxsG6l30gyKDQfJSSCAtR+rAL6Nipv44H+cS2yCb9yx?=
 =?us-ascii?Q?WX/1S8hiNWRjALaS9dutRlzHNeHdWV0FU3C/9b026BEbfNeMKSi35tkmXX/x?=
 =?us-ascii?Q?6hX/dc/sP60he4buxrlO58IB8bnjGfnY4ugV6O/PGp9o1/fUarpTX+oFFwR5?=
 =?us-ascii?Q?nQv8kzPVZ+Y9h6EGS4yr+V9+aESN/12K15MRVYcPLZgbHrwMKeat9AT7k9vQ?=
 =?us-ascii?Q?MRdddiALfEk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pUiC5qiqLF/s/bB5iH12jxihbHPQ391oBH1Ch1Y6HNcKoSZ2qyoqGyyqHK6P?=
 =?us-ascii?Q?DjpNMu+e0OXFrhfKCKWC/6aNQfbaUoCDeZWAuvgIHOfhYqt7iKYogJSljvBI?=
 =?us-ascii?Q?r6wrFxGAL6SxhujHVWWPYYujihGwhYB2mFey+nqSfqucFGv8MObLjT3Ppam+?=
 =?us-ascii?Q?PxZJKa0FVzVkAs3+mHo+YkiVtqTpxrjnQ8T+uircjXtuLupKeCDtmfid6bZC?=
 =?us-ascii?Q?SL2Tqgw7PYjJBRNUPDdCcvlBJd73fW132BL111mHqOaXgrZGl6Yr2ejkamN8?=
 =?us-ascii?Q?3JrEXmGdX7i9wJhsKmeVM+wxZsUf/QnEIKpIzCKqM2Qw+Cxilu8VFdkNpXli?=
 =?us-ascii?Q?fcaXANaL9dAwWxvSq2LfZSP0mHx4zYR5Brl0NyXqLBgegEgh2R3hIb1n8/7q?=
 =?us-ascii?Q?4516CYw9v47sQDtmZiV854uby+MaZXKvyFcyC+jPK4jFxokUF4kTUcNKWsqd?=
 =?us-ascii?Q?BRwVAwRVPXNuqGEwaRSL0T8gzYwAJmVEERTi15sYKvLcWMrBGm4ze1rVAS00?=
 =?us-ascii?Q?OkilxRkJMYtkcP44jOFLm+X5FYVpxIC4USHketq5pE1kYkZygO8OEOw2cmmJ?=
 =?us-ascii?Q?aYo9USwZZUHZtmnaH0A7eq2OTw7gpx8u3saHvgPCK6kUTJFzFFexJT6Cjgzo?=
 =?us-ascii?Q?CWM7VDb7rvvGBk1dTa09cJkSBqJkZCbJALZP26vB63gUOxT9TgHBiAOce//F?=
 =?us-ascii?Q?Ik33RI904NtFtSY2r1aJpiaFKZuh+sIg3zh/tq9VcCVCE77BaTfN6alprE3Y?=
 =?us-ascii?Q?KV6o4vtynbXd9LUpVjjAuR+xVsg38zxele88LghEQ99EWjuLJBPzbEabLHoy?=
 =?us-ascii?Q?av0if4eotStXgAAoKsuZm5s/LpbONv7xx0vWo9U30rnpllo1zFhwqUuLvMMk?=
 =?us-ascii?Q?Ach1hAr8+XIzbKxqbtiMlbgboeJt1TxUV29gDlchCo+C6811rquUMMl7bsJE?=
 =?us-ascii?Q?6sZGHlg39uOW9QZJmK37dp7M6oiS6zsN2Vu/YPCG/eCvqM8pFSIIlGTWmJrp?=
 =?us-ascii?Q?T1tlyiRIKtLrtl0nE/b1nAJYg5ZN7TuSvGjRHEnLTj6oONz8Lh3vovDBxFxM?=
 =?us-ascii?Q?7grGaZpMIT080oYhdOmv1pR9vrti8PqXhyn6s+356q6N2o32FTPOuUdSuQWC?=
 =?us-ascii?Q?zvbJz9Q7ZFeSu2g8O+4CWOD3n0fP7mi26DXXCY8HcfpWHUsm8s4DHGWfUJb7?=
 =?us-ascii?Q?D+cycb1xljcBpP4Glei3I07yglN2boKbKFbObJssKNbxmZeMkaiJ9bKppGHO?=
 =?us-ascii?Q?YDS2lWOQxdl/RbGM4uG/OqtHofmA5MgL0XNFKZTLPDh9UFcc1icUqnmeaQfL?=
 =?us-ascii?Q?XkfmI4mOYE9TpMOp4nGPHU6ODOWyMfJ999vxHEUdxkTN5tSc84arJKFSW/q7?=
 =?us-ascii?Q?s8Ooau10B11NTdQld6xRSenSthNrhueMOFC5FQOJ31nB8sA/Ywx4VkgqIyyA?=
 =?us-ascii?Q?+7f3eA7tGwcRQQQ/TJmoLfCuryf8cvhaOfhLls/IIligImtCZPJGG0PGOgzt?=
 =?us-ascii?Q?NbhFQYGJJIEIsswipmP9XFeJ74Jv8WFRuKAp2fBrkgSlMr2FztG7TAXd0oyN?=
 =?us-ascii?Q?sayqTqqzvRXz45PlWoU6knUyd709aZZTczqgrva5Tey6DD66n9nNMgSIvlwP?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X92rjkaFNRyDz3w8E8RCK8TuOrg018JhESCBi6MkMzxe41SaUcChZxMyIgBIxaecLjq2FrVJ4q3D+aRuVZkOPrC8cCjMr6ljBKAPL1KRXYEZZF0CmFWvMTNnweMlmXWebr9EMF/F02twlyeSSWEJfAaSRqw+zmtnG0EW1+K2rGhC9bYCHWKIdMNkmyKPtq7uesAr17S8jDagXkWzENxOZPs/RAY+BeAMYLj6p4JRoLyeFyph9wc3KYiHzpAXMaos9hFSJDZJExfSvyu3hd5hPq3SoiojH1I9YTX/slvZxb3cXsZ3sbl+SEkmIozBmtirZGQB1nqoFRZCYUricG+i9JN0jO51HLYpZFzXt0tEdZSjV7pL8YsNmvcv8eSjG1u9nVJ6GpxKA130gh4DRb2Gqsbs9BuUyUYoT4DbOTqP6PO21ua0Cy4YwfpXBoo32rUEih96TnCpbe2enaWOQhhMjbKbm6rbk/quKF79elBMCruE6+k57soZWTgc10s6ADjnXPZN3WAbh7rCoKlSeJBPwPkmTCXU3f21yiJQfUwNlXWrQ6swR5rXLDjqdrjJFse7naBxM/14/oWVtw6x53BACFcfFmRR2sxP3Pzl3y8gvVQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c44549-ccaa-4c9f-b7f5-08ddeb14bafb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 18:07:22.5936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hnSxFbJwGHP83VSYypIvwkt8VLeg7e7+B1UtVVa3kWFd3ZBauyXESHUIrE1z3D2oiCuQF0+NsZp7GMWfwT2FeLarJLO5fZqkwYRs8nQzPPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_09,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509030181
X-Proofpoint-ORIG-GUID: aiOqEx7Dk5FByZld0V_EgsFJOWPS3VbZ
X-Authority-Analysis: v=2.4 cv=SY33duRu c=1 sm=1 tr=0 ts=68b883de b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=-4aon9W6glDlnRVGX_UA:9
X-Proofpoint-GUID: aiOqEx7Dk5FByZld0V_EgsFJOWPS3VbZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDE4MCBTYWx0ZWRfX71jr9rQjIPif
 yU/h7agyqtHzPtaPqhKocOaWbHhtweeBLn0/neITtMzn0UYoIZLGHa1/7If5aMQR66rIkwoJKL8
 LbqCHgEa6RRWDiJ42xyPz009CTGV5d8GhUoqIYXjBKbemI8NyOg59ig8f965dTeFrCvmP7AHao1
 ZNjlo72cf7cQTGYX0ghRf503kdIoTOU1foeaYe4biSRnS7jvvzsqLH3hzXz57kqsgOnKG4SAwd9
 2mGS8AHR0+QtTOhOXKS0I4oHz8r4O/uJ7Vg4Plk9zlItMN26qtfcqaNA2TW6x02ocZp8z9toaH5
 1rdaLHEalyCVuVOd+yEjSXeuVJIFw2GJ3w5xFkjeOoJEPwylsBp8f4Al0ZPHDr2nXanBUavLFjE
 A2oZg2IE

The f_op->mmap() callback is deprecated, and we are in the process of
slowly converting users to f_op->mmap_prepare().

While some filesystems require additional work to be done before they can
be converted, the gfs2 and udf filesystems (like most) are simple and can
simply be replaced right away.

This patch does so.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
v2:
* Fix typo in referenceing gfs2_mmap_prepare.
* Fix gfs2_mmap_prepare() kerneldoc.
* Very minor fixup in commit message.

v1:
https://lore.kernel.org/all/20250902115341.292100-1-lorenzo.stoakes@oracle.com/

 fs/gfs2/file.c | 15 +++++++--------
 fs/udf/file.c  |  8 +++++---
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index bc67fa058c84..b1c3482c65e3 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -577,9 +577,8 @@ static const struct vm_operations_struct gfs2_vm_ops = {
 };

 /**
- * gfs2_mmap
- * @file: The file to map
- * @vma: The VMA which described the mapping
+ * gfs2_mmap_prepare
+ * @desc: A description of the VMA being mapped
  *
  * There is no need to get a lock here unless we should be updating
  * atime. We ignore any locking errors since the only consequence is
@@ -588,8 +587,9 @@ static const struct vm_operations_struct gfs2_vm_ops = {
  * Returns: 0
  */

-static int gfs2_mmap(struct file *file, struct vm_area_struct *vma)
+static int gfs2_mmap_prepare(struct vm_area_desc *desc)
 {
+	struct file *file = desc->file;
 	struct gfs2_inode *ip = GFS2_I(file->f_mapping->host);

 	if (!(file->f_flags & O_NOATIME) &&
@@ -605,7 +605,7 @@ static int gfs2_mmap(struct file *file, struct vm_area_struct *vma)
 		gfs2_glock_dq_uninit(&i_gh);
 		file_accessed(file);
 	}
-	vma->vm_ops = &gfs2_vm_ops;
+	desc->vm_ops = &gfs2_vm_ops;

 	return 0;
 }
@@ -1585,7 +1585,7 @@ const struct file_operations gfs2_file_fops = {
 	.iopoll		= iocb_bio_iopoll,
 	.unlocked_ioctl	= gfs2_ioctl,
 	.compat_ioctl	= gfs2_compat_ioctl,
-	.mmap		= gfs2_mmap,
+	.mmap_prepare	= gfs2_mmap_prepare,
 	.open		= gfs2_open,
 	.release	= gfs2_release,
 	.fsync		= gfs2_fsync,
@@ -1620,7 +1620,7 @@ const struct file_operations gfs2_file_fops_nolock = {
 	.iopoll		= iocb_bio_iopoll,
 	.unlocked_ioctl	= gfs2_ioctl,
 	.compat_ioctl	= gfs2_compat_ioctl,
-	.mmap		= gfs2_mmap,
+	.mmap_prepare	= gfs2_mmap_prepare,
 	.open		= gfs2_open,
 	.release	= gfs2_release,
 	.fsync		= gfs2_fsync,
@@ -1639,4 +1639,3 @@ const struct file_operations gfs2_dir_fops_nolock = {
 	.fsync		= gfs2_fsync,
 	.llseek		= default_llseek,
 };
-
diff --git a/fs/udf/file.c b/fs/udf/file.c
index 0d76c4f37b3e..fbb2d6ba8ca2 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -189,10 +189,12 @@ static int udf_release_file(struct inode *inode, struct file *filp)
 	return 0;
 }

-static int udf_file_mmap(struct file *file, struct vm_area_struct *vma)
+static int udf_file_mmap_prepare(struct vm_area_desc *desc)
 {
+	struct file *file = desc->file;
+
 	file_accessed(file);
-	vma->vm_ops = &udf_file_vm_ops;
+	desc->vm_ops = &udf_file_vm_ops;

 	return 0;
 }
@@ -201,7 +203,7 @@ const struct file_operations udf_file_operations = {
 	.read_iter		= generic_file_read_iter,
 	.unlocked_ioctl		= udf_ioctl,
 	.open			= generic_file_open,
-	.mmap			= udf_file_mmap,
+	.mmap_prepare		= udf_file_mmap_prepare,
 	.write_iter		= udf_file_write_iter,
 	.release		= udf_release_file,
 	.fsync			= generic_file_fsync,
--
2.50.1

