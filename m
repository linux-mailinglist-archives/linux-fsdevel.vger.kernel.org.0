Return-Path: <linux-fsdevel+bounces-24434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C786593F47F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 13:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CDAF1C20805
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 11:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246B51465A9;
	Mon, 29 Jul 2024 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DOlsYTYo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rQ5jPtsr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A0E143752;
	Mon, 29 Jul 2024 11:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253886; cv=fail; b=ZFpa41w7oCcaqDMTwuzEmWDQmxgKs8JlSwOWssi5gYjhtkz49nVC2SzFJYfhwe2lYqG82UU+GlXamE5xYe6ixOFMgC4Ws4wnZ8j8Bz5i8G0Bv8fnAv3SL+1iu5McSoA76MNQH8fyuIHHSg5zsKZ9cL9Zfdx/gK0ag//oTYgAnX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253886; c=relaxed/simple;
	bh=adwUdfz9nf1qGb8qIca8eDVccd4v4kTxiL6Q1aNEEXM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IvWToSLWauD3IPgERs9jY2O9pHlfANgzEcBU5uYobZdkJff/OsfRzvKNkg8baZZYOCTtEUQg0RlBkBZdY9Zi377bEEbJUguQHQrWdBAlQMChLk4UB1oRKWD/yC15OfreWBAnCq1XYdBqpEFqFFAehB1BYZR0B0fCpWfo3RcSibY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DOlsYTYo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rQ5jPtsr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46T8MWHx029158;
	Mon, 29 Jul 2024 11:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=Xbz3/jhL8ELTGY
	jPJB84tFdX/+HD6HssP4AOpfUbglw=; b=DOlsYTYo4KPwhfHrCRlvlz43e7EhjJ
	TGkCDsTHW4oVhKzJ55QsXjMsCJx4aC3mfJKEp0XKvEtiB0nLBnwfGbXq1WSOq5Oy
	HLKHpo4w/sLP6pGoiL64M2nZZMV0HR0JHxPbXUkb1+I7wwKnqdGZos3ecUA5efkw
	BjBtRiwExgihtp+dReWP439FrbBTIhZHcd26eomdi767Xou72ryCpAundo9HJghb
	BlQPOIARz4oz11zMOVohRlXkGR3bQqTO+006w9tkcjPKrwo2DQiklIS6OuRApYpc
	bEseYF6DHQFvVL7UhhXM6Sq02gDUsyQROChc+FIYYXeg9Wp9x7J/e86A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrxbtc31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 11:50:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46TBXkeL025722;
	Mon, 29 Jul 2024 11:50:57 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40npcegnam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 11:50:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hn+LOnGKwSPfeJPe2fwrIjqvp+lyhcx/1atH6G8jDrbT2kbsSKs4kNI1gICQLSlqzjrxcO/ksnrEaE6HbnWR4UJDeoMqJAHeurfiqBMBCpMpvhMop7N4V3InoHQCTjswNTp3pRH5qYaiZ0OfSFmSscOGzruS3IkyGaB/r0pPObhAcUwF0+kzcWDklE9DqPV6Tq8nwYCjrpMmAuortkxFSWaT7RCGbs6GxLZ8igXR25U0zChBmCiqc2UvodiYz23+PMQeQzmF8oZGRH9BibMY7VdCh/B4Hq7zLGfsYofiTN8ZYCi7wDRTwe+vitWK54/VGYsQF6+OGD5K3MeOx7LScA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xbz3/jhL8ELTGYjPJB84tFdX/+HD6HssP4AOpfUbglw=;
 b=jQTP5T9jxyz28mRdz+epmzOzourU2t8Z2PANjmkNElUI3MvXBqBsQCIgoEQ4i9clY/Llo7VVh3el9gZC4NgaFubb/z7nDrqVstqYLQWvnGcN6yK36nEfIaUianblRVk2suFNS9BLDpmnYdH27g1/W6pb9IBK2oQel87gV5pVm/NTxO+Lj2S0a0bihWDkLLxKQL6RH6ciMHkAaw7+I52AdCVGTG0VtEjVi19dkVSGPhJL8xpfYXdwsNeClLl+Mzm9/lQOifzeNIGBQwfFa0sYsAOgov6CB1DHJo2vUDrEXlTgDiPZ2bNvCqswN6++2aZXleVbDGEumG45nhjlTBoZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xbz3/jhL8ELTGYjPJB84tFdX/+HD6HssP4AOpfUbglw=;
 b=rQ5jPtsrIr7/zOQp167Y2MC142A/8S03OhwHPlQtN1Qb0koGd1i/QFbnk7kOMsM4h35JP9jiWBqFetBLTrXUXdSWDNjG2QAdOqlB1BFOALYr2zkKePDUCEKTqm7sZVDzXza9i0E3FPK3iBPCVrSwzf1hjV5vL7pNFvIRLVajgRw=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ0PR10MB4543.namprd10.prod.outlook.com (2603:10b6:a03:2d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 11:50:49 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 11:50:49 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: [PATCH v4 0/7] Make core VMA operations internal and testable
Date: Mon, 29 Jul 2024 12:50:34 +0100
Message-ID: <cover.1722251717.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::15) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ0PR10MB4543:EE_
X-MS-Office365-Filtering-Correlation-Id: 92bd00a2-ac17-4991-ac45-08dcafc4b05d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?98HBMV8V+5e3+0EGzD5t9Gxc3VgiSkhXqYzrLg0kL+o3/pK+T1kkoiaoz5pK?=
 =?us-ascii?Q?W8idrYbWXUbjBL7oNV3ETmgEZojBNOyx76UGJSdh7k0z25LUJB0wqHF7FSQL?=
 =?us-ascii?Q?TAptnn3v9S9dyDhHY/Pg4n4Ou9TyIVovKfEvmSc1vRSG0PCGey+hjieY3AoL?=
 =?us-ascii?Q?O+beKIhlXA4wdoORxItxZtwJuBEFCU4tQZuwnzhNPA4TXWu1y1iBfmNEl/s4?=
 =?us-ascii?Q?etrjqwFXauLd3pSqk+80OR3lONk+TwOpuXyK+3K12w24JpuRf4KmtGicM6Ba?=
 =?us-ascii?Q?J1yqb0fwYEFxviy/kgMaub6t4aOvTofVBS8ejRVUaJ9PK3RlBGYx4hGiPeYR?=
 =?us-ascii?Q?9vyoqqMNJ7wqAaroxYHINV/HHxkUz3nZD40k07IogM3bpatFPI8ci7tQ76Zt?=
 =?us-ascii?Q?gt1otOIrS3C7rIkTncVGlJHxr/skR3IffOvK1GeWGoHyJTyZ8WMxKowNnB3C?=
 =?us-ascii?Q?rUMMDKg+Mwfg0j6UkH1Ol1DtD051NgjtmC7OZMi49VdEuTd/bE0Lc58z6z3p?=
 =?us-ascii?Q?rZ2c41FsN4n5azQpID8rWXH4VouuEfTG6Hhjh4H0KL6JI6By1mI/DJ3ddgSA?=
 =?us-ascii?Q?/hNeuKy69YANmWMKWCh3Z7gk+dRQKRneRR+wKeoxVTdxS2YyT33w2sYF27/I?=
 =?us-ascii?Q?RkDpGc79llgyImbNJgxtbJMFiZZBPdSDWRCrLmQczWkUpNVttF2ppcLtTh4P?=
 =?us-ascii?Q?uY9jONkZhifdq7IK22IyYWDfod1+knh4eO0dCHK7QdMnzHa2Au3vFV2zKYZW?=
 =?us-ascii?Q?MTQVwPbjcqwq2M4sScB0CekM4LgHfTZQv1QllzTcJ2IoNRQL+XnKfg4geONg?=
 =?us-ascii?Q?lGDTiy6TWlF27GFOG+Ych+a0TpEj/ps39TKDzwb1Prww0kD8BmKFuxtgfTPz?=
 =?us-ascii?Q?DBppLKWYs2Yklchm3UDlnSbL18+d3ewT3iVAh5uRiRxjL9vs8NkpjSXZtcv9?=
 =?us-ascii?Q?mmRPUWPdPQnd4pFuVbKOG2Tk/P7upkvNdSjWeGv1VRuN8sWLg3MjrKLLzlEX?=
 =?us-ascii?Q?E7N5/K8ShhpiNpr00H1VSBZJUllkFki/Va9CbVoeTg19YjH73ZyG+IRN9FSC?=
 =?us-ascii?Q?WxPLKZnt+qKUIH1wzx/8dqTY3noRuZfUj6UcxWgpuwPwArmXy06SClT0Wi3x?=
 =?us-ascii?Q?NQM1XOWUy2dHgaeLYjIKKqfIu5k946ovcbPAc2PjrCnIVR5F/FpYKgK/u2KS?=
 =?us-ascii?Q?btpXU2wF0cq86Igg96HJjaYiTE+apVKqkUhtHpy99v290lUYXqOeANPVowWF?=
 =?us-ascii?Q?kBH1MAploDkNGGptJng5FGxjfOYV7W1lbx88sCXdwBUdnaptqxQ9I6WEoHOf?=
 =?us-ascii?Q?sDnQJgWd0GDyjIlo0cBsFGnr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n6PXSIQxmAzuR3NrZITsS6s/Cu/jU1KFpe2ERvFerijqMsf/9PgxgUo6wRQc?=
 =?us-ascii?Q?uEG2c00+Ewnz7fV8Wkj0xWSav3gNJBsLbZaGUjcbNVjsIdsY+0sqM8J5lSue?=
 =?us-ascii?Q?rqiCcrY0cZlvgNDM35Wm1r/EEG8buBxnwZbLaG6ihr30EwxV64SdbrmmB/iZ?=
 =?us-ascii?Q?08MlnKTyrVGQ8fi/6s9ClB8OcOkRBbwMjKjq9nQZtvq+dfE53Bxh2DfgEnvK?=
 =?us-ascii?Q?XHtY0Fb5zCYYy1SpGdMQDuZbXfPztRWEzvNcg1aw+giTd2/2O5iXGPI0M1EW?=
 =?us-ascii?Q?QZPBv0gwGz33CSCLCp3GkMlZkqCSCQ6+Ehe9hdipugvdPEYYSxSQTE/QhKr3?=
 =?us-ascii?Q?DNs/YwhzD2uNX1pTBrkgAPzX0lMN+gAXfjWyZzbwnDDHYaAT5+G8QohuFtqn?=
 =?us-ascii?Q?S23CPogW2KC1IVXouO6XVm7j0glH2k8JvInlHfK4L0uEr8pM4l1VOtNQHS+G?=
 =?us-ascii?Q?j9UDE3Gt8f7DnCVu5mOivEIYkB5O/DSW3azKSx9Yv+CIWUrNSkn+1VjnSn9w?=
 =?us-ascii?Q?hiDfB4OUH2fBLwvwxXldK5ARzA8T+B1qY0+1iL2aJq7qVhMeAJySA/i41FR4?=
 =?us-ascii?Q?Gbwn8QD9szaJ+ZfREKA1iaxyX1G+/n06XTij+xO6oNRYc/WJtWku6cO8REcq?=
 =?us-ascii?Q?bSMMFRfqMkTY7XQVhWwIdADo/M5Y6x8Iu5KNYxPj1L/5+ZjKydzQubsMr8yu?=
 =?us-ascii?Q?1SXK0mBGwvDlg8p/noFzM8D+19+tBaK09BolKWg/HFCv4i8osFDGsFXaDzPp?=
 =?us-ascii?Q?1QOOgZqI3CeOTthiRpwMQh4xpButWn8nvDk2IxcxUTOMzUA/a4yrJDIZwwzf?=
 =?us-ascii?Q?VkNMBL70g3LxTFor/wCF0nopuBDG7s6Z0NXy1Y7TByUkyyQMUjzil5/U0LiO?=
 =?us-ascii?Q?TxXf/SvczS46fZP8U28iLmlmmqVBII0woHD0KXzRpkFjI89NNjTSMGpVaNm1?=
 =?us-ascii?Q?0OJy9+FM2/V0Mw0lquQakjnzbzTLN7c/4F8qQMS3/W/g02RAOS6ffWTEz7cW?=
 =?us-ascii?Q?awamI3nX3iCoKdCvaFwHxyxtpEHWWmxc+Cy3Lwp+mK9ouO8CRhfdd1KryXqn?=
 =?us-ascii?Q?6q+NXFgNIg+H+2Z/DZ6hq3inJ9OMzXgVw96OTfsQt7PHSPWugYdRtcCrA9sr?=
 =?us-ascii?Q?XdKx8ygTc7N5NXT51cm5SOiLJZYWxOMo73GLW2jiic3PkegV1tXYX6xYKhm0?=
 =?us-ascii?Q?+mE+T7Y3bld48qM+Iiap2luxDAyQmmpZJctrpoF9IZEdb/n56aMzxeh9aTkq?=
 =?us-ascii?Q?F17xPHphh6PveUM54E6Tx8yQOECC0wKITLANPR3eGmPeMJdzpDKuLMIrc62/?=
 =?us-ascii?Q?ObvIHY3NTlR3SsWuv5BBXbH++6413MbFkJRh9kZqsMNFZ9q+F4PPO43mLS/p?=
 =?us-ascii?Q?z6wbUlLIzkp6aLSBxRPiHQ8piuYahFU0huNc03YRZwwwmUuvPlnpLkQ+0427?=
 =?us-ascii?Q?EqCqRhXUvNQUIJ2z7yF54eUcjRc34JhJ+nsB/PMPYqbf9SrdEQx85q5tyi6B?=
 =?us-ascii?Q?n3tvv8/S7elpudmMRjNES55gHMdmYcYFADM4UyNlJYK2f1G1miv5Z7V4XdfX?=
 =?us-ascii?Q?0agbwvj2zO6WAkvbJ7/TeLU3fMI2oKrT0L/nJ8OpO8u4fMq1idC1fXkGLsTE?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FraNgV/zRb9gdY28MCrfFoY3tUTIGD5DG/amxKKfbT7fG8rHXpIiT3tlW9c1w+cWtZPcBS326DznV5gbX3A5LSI6pv2IlM+sMskDUkRHAkii/5ENbBEBBENRC/1qdH9lk28WCPR/Srb1txqWawawwzYg02dDHRLQoJKiIKKx+PAkYnbEtX3BvIb6oHQPKsGsDQcrhrSAkPfNHII0rOv9Viot3kQIMzK3kNQWOwRn2n3TQgl3R5Z5b1CWJ4SgVxDJiAjJ3PpxWE6OqY8AfVE2AutQK77+ARxELtMq+EEa8q4+RKeSONNcDjSbZF8Jv5R7+51q/s+Mog9DYp3IHUCy+9X56lKrfZjBjA1r6zn9vmdoUCALcHnmlUx6IayXWqtCESaU/FXh12XVqVfZCn4iDOQcTic2GL8clVagcAKze8nm+tB1mX5hjSFL51tKkF4ybKSJErV70wlSv3PHlmyGoXCgY/GIjMgcIeDQEGpNs8mk2hOiTh05GILdpNpBrV5pilQ/+OFZrN7oI6mtXHjFNG+V3HQFnpYticwUiBTCxVeXk3fKkcMju6vTPDGP3Iuk5OT901sQrzWOdmcCcet28T6lA1CYicKpcBhs7rNMvLs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92bd00a2-ac17-4991-ac45-08dcafc4b05d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 11:50:48.9685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmvxbEDDxyiXPj195gIEuAY2vzm+NzTJxz2o9u8I3dD0BL2wGqXD21Arle7NyoQ9VHoGolpK7+jLPQgY4B9FaMZTA9g9n2cLAyW/sM0OF5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_10,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407290080
X-Proofpoint-GUID: qHEmlNlZ1SlmYMfuXbTmUeATC8RY7C_4
X-Proofpoint-ORIG-GUID: qHEmlNlZ1SlmYMfuXbTmUeATC8RY7C_4

There are a number of "core" VMA manipulation functions implemented in
mm/mmap.c, notably those concerning VMA merging, splitting, modifying,
expanding and shrinking, which logically don't belong there.

More importantly this functionality represents an internal implementation
detail of memory management and should not be exposed outside of mm/
itself.

This patch series isolates core VMA manipulation functionality into its own
file, mm/vma.c, and provides an API to the rest of the mm code in mm/vma.h.

Importantly, it also carefully implements mm/vma_internal.h, which
specifies which headers need to be imported by vma.c, leading to the very
useful property that vma.c depends only on mm/vma.h and mm/vma_internal.h.

This means we can then re-implement vma_internal.h in userland, adding
shims for kernel mechanisms as required, allowing us to unit test internal
VMA functionality.

This testing is useful as opposed to an e.g. kunit implementation as this
way we can avoid all external kernel side-effects while testing, run tests
VERY quickly, and iterate on and debug problems quickly.

Excitingly this opens the door to, in the future, recreating precise
problems observed in production in userland and very quickly debugging
problems that might otherwise be very difficult to reproduce.

This patch series takes advantage of existing shim logic and full userland
maple tree support contained in tools/testing/radix-tree/ and
tools/include/linux/, separating out shared components of the radix tree
implementation to provide this testing.

Kernel functionality is stubbed and shimmed as needed in tools/testing/vma/
which contains a fully functional userland vma_internal.h file and which
imports mm/vma.c and mm/vma.h to be directly tested from userland.

A simple, skeleton testing implementation is provided in
tools/testing/vma/vma.c as a proof-of-concept, asserting that simple VMA
merge, modify (testing split), expand and shrink functionality work
correctly.

v4:
* Rebased on v6.11-rc1.
* Fixed radix-tree Makefile to build all targets.
* Cleaned up trivial issues with test make logic.
* Applied the 2 small fix patches from v3 - fix double header include and
  remove invalid asm/ header includes.

v3:
* Rebase on Linus's tree.
* Remove unnecessary use of extern keyword.
https://lore.kernel.org/all/cover.1721648367.git.lorenzo.stoakes@oracle.com/

v2:
* NOMMU fixup in mm/vma.h.
* Fixup minor incorrect header edits and remove accidentally included empty
  test file, and incorrect license header.
* Remove generated/autoconf.h file from tools/testing/vma/ and create
  directory if doesn't already exist.
* Have vma binary return an error code if any tests fail.
https://lore.kernel.org/all/cover.1720121068.git.lorenzo.stoakes@oracle.com/

v1:
* Fix test_simple_modify() to specify correct prev.
* Improve vma test Makefile so it picks up dependency changes correctly.
* Rename relocate_vma() to relocate_vma_down().
* Remove shift_arg_pages() and invoked relocate_vma_down() directly from
  setup_arg_pages().
* MAINTAINERS fixups.
https://lore.kernel.org/all/cover.1720006125.git.lorenzo.stoakes@oracle.com/

RFC v2:
* Reword commit messages.
* Replace vma_expand() / vma_shrink() wrappers with relocate_vma().
* Make move_page_tables() internal too.
* Have internal.h import vma.h.
* Use header guards to more cleanly implement userland testing code.
* Rename main.c to vma.c.
* Update mm/vma_internal.h to have fewer superfluous comments.
* Rework testing logic so we count test failures, and output test results.
* Correct some SPDX license prefixes.
* Make VM_xxx_ON() debug asserts forward to xxx_ON() macros.
* Update VMA tests to correctly free memory, and re-enable ASAN leak
  detection.
https://lore.kernel.org/all/cover.1719584707.git.lstoakes@gmail.com/

RFC v1:
https://lore.kernel.org/all/cover.1719481836.git.lstoakes@gmail.com/


Lorenzo Stoakes (7):
  userfaultfd: move core VMA manipulation logic to mm/userfaultfd.c
  mm: move vma_modify() and helpers to internal header
  mm: move vma_shrink(), vma_expand() to internal header
  mm: move internal core VMA manipulation functions to own file
  MAINTAINERS: Add entry for new VMA files
  tools: separate out shared radix-tree components
  tools: add skeleton code for userland testing of VMA logic

 MAINTAINERS                                   |   14 +
 fs/exec.c                                     |   81 +-
 fs/userfaultfd.c                              |  160 +-
 include/linux/mm.h                            |  112 +-
 include/linux/userfaultfd_k.h                 |   19 +
 mm/Makefile                                   |    2 +-
 mm/internal.h                                 |  167 +-
 mm/mmap.c                                     | 2069 ++---------------
 mm/mmu_notifier.c                             |    2 +
 mm/userfaultfd.c                              |  168 ++
 mm/vma.c                                      | 1766 ++++++++++++++
 mm/vma.h                                      |  364 +++
 mm/vma_internal.h                             |   50 +
 tools/testing/radix-tree/.gitignore           |    1 +
 tools/testing/radix-tree/Makefile             |   72 +-
 tools/testing/radix-tree/xarray.c             |   10 +-
 .../generated => shared}/autoconf.h           |    0
 tools/testing/{radix-tree => shared}/linux.c  |    0
 .../{radix-tree => shared}/linux/bug.h        |    0
 .../{radix-tree => shared}/linux/cpu.h        |    0
 .../{radix-tree => shared}/linux/idr.h        |    0
 .../{radix-tree => shared}/linux/init.h       |    0
 .../{radix-tree => shared}/linux/kconfig.h    |    0
 .../{radix-tree => shared}/linux/kernel.h     |    0
 .../{radix-tree => shared}/linux/kmemleak.h   |    0
 .../{radix-tree => shared}/linux/local_lock.h |    0
 .../{radix-tree => shared}/linux/lockdep.h    |    0
 .../{radix-tree => shared}/linux/maple_tree.h |    0
 .../{radix-tree => shared}/linux/percpu.h     |    0
 .../{radix-tree => shared}/linux/preempt.h    |    0
 .../{radix-tree => shared}/linux/radix-tree.h |    0
 .../{radix-tree => shared}/linux/rcupdate.h   |    0
 .../{radix-tree => shared}/linux/xarray.h     |    0
 tools/testing/shared/maple-shared.h           |    9 +
 tools/testing/shared/maple-shim.c             |    7 +
 tools/testing/shared/shared.h                 |   33 +
 tools/testing/shared/shared.mk                |   72 +
 .../trace/events/maple_tree.h                 |    0
 tools/testing/shared/xarray-shared.c          |    5 +
 tools/testing/shared/xarray-shared.h          |    4 +
 tools/testing/vma/.gitignore                  |    7 +
 tools/testing/vma/Makefile                    |   16 +
 tools/testing/vma/linux/atomic.h              |   12 +
 tools/testing/vma/linux/mmzone.h              |   38 +
 tools/testing/vma/vma.c                       |  207 ++
 tools/testing/vma/vma_internal.h              |  882 +++++++
 46 files changed, 3907 insertions(+), 2442 deletions(-)
 create mode 100644 mm/vma.c
 create mode 100644 mm/vma.h
 create mode 100644 mm/vma_internal.h
 rename tools/testing/{radix-tree/generated => shared}/autoconf.h (100%)
 rename tools/testing/{radix-tree => shared}/linux.c (100%)
 rename tools/testing/{radix-tree => shared}/linux/bug.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/cpu.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/idr.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/init.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/kconfig.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/kernel.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/kmemleak.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/local_lock.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/lockdep.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/maple_tree.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/percpu.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/preempt.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/radix-tree.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/rcupdate.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/xarray.h (100%)
 create mode 100644 tools/testing/shared/maple-shared.h
 create mode 100644 tools/testing/shared/maple-shim.c
 create mode 100644 tools/testing/shared/shared.h
 create mode 100644 tools/testing/shared/shared.mk
 rename tools/testing/{radix-tree => shared}/trace/events/maple_tree.h (100%)
 create mode 100644 tools/testing/shared/xarray-shared.c
 create mode 100644 tools/testing/shared/xarray-shared.h
 create mode 100644 tools/testing/vma/.gitignore
 create mode 100644 tools/testing/vma/Makefile
 create mode 100644 tools/testing/vma/linux/atomic.h
 create mode 100644 tools/testing/vma/linux/mmzone.h
 create mode 100644 tools/testing/vma/vma.c
 create mode 100644 tools/testing/vma/vma_internal.h

--
2.45.2

