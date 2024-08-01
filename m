Return-Path: <linux-fsdevel+bounces-24819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F40219450C8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 18:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0B21F288DF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 16:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F341B9B4F;
	Thu,  1 Aug 2024 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VlmoDC7h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JMS7toY5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807DD1B9B3E;
	Thu,  1 Aug 2024 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529986; cv=fail; b=poexzoXv7pgQELwVyEQD6Fow85Z5+Bxp/xM+CNjIZHpMyGbbEYmyFRUzUY6Q8zjZhoRANFJXT30EpZUdyBz4vL1UETANZG9ZH2aNn95UNvVf2Y3Lb7AUy+pCQJhjUbvrcR2oFulnr8vcw2Nr91K0nx6D+fvwy7Un5bs+rfn7A3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529986; c=relaxed/simple;
	bh=xhsvC9cidv9VYbCIeNPD2NCLY42NJYVfpiENnXzylNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qa4U+ZkvlGkM9B94NAgQM3P8JI+lqKXgJ6fxBWOX0tZQ/hN7IafZFbroBG6o70WhasDozQu4+w5YgEhNjVT9XWUEC4Ijp7kyM/axhjK7aTNH6tJcM8UhbktVFl9EEn9zs6TKi6NBogadCsaYpiAjzTk96QViwtz7vOjHYZKIktQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VlmoDC7h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JMS7toY5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471FtV8m028570;
	Thu, 1 Aug 2024 16:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=kq5rdor8Yi9FDOU95CCsz7JWSI8FSkRGonKqONH+dS0=; b=
	VlmoDC7hcm/asKF5XG/0/g9HLEyC203EPcBf5twFTv14y1igd6ObU9nr84ULhIq9
	dB658sa6b13bxTFuxOQn6UPRbzgYMif+HeIjO1VaIqND1fOuFPOF62rtob1pOoic
	dpdXvEL+8L4D5a4jEcapJci8gBjta2ivyErNzDrInDgV1mC3bnu4zRq7X7X+4TkF
	LZ8tQZ9OXiMEqD6+jphvfzO1gFRVFxOnT0ZYMAdCzhiQXO6q42le66wyuZgmcicm
	3lAq30kEHQKGJQyyjslnI+sz0EVwAKzsmZz9umtGhjSRkq3N9T+vyqx0tAnsbRcj
	WCjyH5KOwNea5Sd+6tmDHQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqfyj77q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:31:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 471G2Pf5005795;
	Thu, 1 Aug 2024 16:31:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40p4c3404v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:31:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nlx9e4pgs3CiRg7o7WWYDolQAeb0R2GYRHAn5lGMRdVMJ/LUc7llRBTKb93rYSkb1p4JiBFLbXRwBgibovz37SQEGyv0RHs9LKZYSbmfsHlvBKgKEk9M6SsOjylBsHNLwzo3EPjEgg9ETLK++nrKoF8VAFsLyoA2muznzE3tLHP1uosd1o8QRrLC/afsJLp6qVyZ2a04ZzcfYi8UreSRv8Yk+lPeR/K8F9fDhsbbytm2ztq41FM3jauQWVadbMJaI1umxdvE1HR3C+RfYiY9zhM/YrNz/7vb1SD7bf3WD5+WQI0UHlni7B+iDX+dkpsQVFTZvLOL2J3BuX4+7u3okg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kq5rdor8Yi9FDOU95CCsz7JWSI8FSkRGonKqONH+dS0=;
 b=hJrHqzfEyV3iDsB5bmA27ARDiIhv2ubhXH1vJBpcRNl041UMKt6hOmi7JpotL/VxmCBKVUoWMqWy11CLCzeyZkn1x+8+VlddtkEexZAXn5quV81jjVirIwXMz8PU1JGVHnxaRh+68mUDFawgcTfIGXLP8zAliGMO9wgF0UBWLsNguOCPlgOcN5HTMo6UoH+QHYVVUR/mp04XBMX8JOpDaH1kmJZRFRGIvGsSVFSCMgolLcN4fs8zdF2nKueFZoesIWhgrUOwB+8vOEsf0losUbF03XpPsJ3xJwX3dyV+ETohJ770ToagfZBPWPeXAE11Mkltv2kOs9RmwfVZ9vKIzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kq5rdor8Yi9FDOU95CCsz7JWSI8FSkRGonKqONH+dS0=;
 b=JMS7toY5dSZC5pzqvQzEMMwKoRWB1KaXhPbYCxfGHQsx6O82I/iEYBL6dJSL/mwO+HISzdiuc3lPRuxp+bZlSDtzoX14t2uQXgjLIki1dXs8T7NLq94NZTS28gBekj2Btq1zu+a9NtQ2f99aoYU+zlH+NKoc6HAWQYu72d/xKws=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6081.namprd10.prod.outlook.com (2603:10b6:510:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 16:31:52 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 16:31:52 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 11/14] xfs: Only free full extents for forcealign
Date: Thu,  1 Aug 2024 16:30:54 +0000
Message-Id: <20240801163057.3981192-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240801163057.3981192-1-john.g.garry@oracle.com>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:208:32b::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: dd58defd-9cb3-47cf-e255-08dcb2477306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GnQ+9w0PSCNaksz2ZpKw5RZn3pqjQ54a4EdT8EgNtKIxOkoK+2q2lGVkcyJS?=
 =?us-ascii?Q?qDdiHZWQKTPSy0laz5xHJaMTceci7ckaivA+OximRcxKEqEHxpH2MKDGYoHK?=
 =?us-ascii?Q?yfCgcJmRFc3xbC2S0huPi4PsflSIN7sfitchJoZqvHbtrouZA3rAOwDuIfaO?=
 =?us-ascii?Q?Eh9BUYB0wnZeTSdNfUX/RCBSi/tzwaHM21cpHfdy2L+aR2zTtSVRirMU7PPT?=
 =?us-ascii?Q?wF0RumkGw8n06OI/ZQOIP3zNYSwBUuVIg/fQdKtr3d7gUKEJvuLDcULKdIjE?=
 =?us-ascii?Q?psrMvE/iAhOP5J+gBo+W04LwY3n9omunK4qioebIIGImP8FehvSSSOzLEpjt?=
 =?us-ascii?Q?tRTURi0rWJtcP0AqZDkBPJRQ5rjK3gjApXttGbp9S+pIGvjKUqkIdXFF5y5w?=
 =?us-ascii?Q?a5bLsMYWbk4cFcqnus2S/kcuGUro1erEFyPs0jACAuxfxUYzunHOPfjuDdYC?=
 =?us-ascii?Q?lbQd2A2Vuf8gpO/UGl3IC5W9CBgHboYWL5Zmhdpakn85JlU6fM1sp7efTSvR?=
 =?us-ascii?Q?6vn2bHHj74Z3EmdE26MfcGIISsEkvbj8LB5ewme6PoYVckxGbUW+SXem2P/3?=
 =?us-ascii?Q?VM+1pdUUnFKV4Mipqylmn0PGxGoFjfuvXP783WQ2roblMWSkpyzwgAZGpVev?=
 =?us-ascii?Q?CpE/H0tnqT3VYTdNTdUa8o9wzLdKDSAkp+chRsvT09x6oBKt96ehnco9VQnL?=
 =?us-ascii?Q?uhGXdzvu6NUKU+W8w8uOcXmUUn3c8idg5HxByL1T5PWjxIF0zsIQjpGxGX4i?=
 =?us-ascii?Q?3ozc3YDhmEV0KuDj1V1KtducZJCOjsGnu1wB6mHeTPe8hBFrOcvp9rxF6Qxx?=
 =?us-ascii?Q?+MnY05CQoU/6C6KGXpzpXeLj0bCmzXhJxtPh9RHDiSDncu6ODauACaQQqO+1?=
 =?us-ascii?Q?oQvcP2I0yrzBpUB435EsuFi7ChyOh46K6UMgArf2rGufhME0f7r4+DoLJgB7?=
 =?us-ascii?Q?3Qhms0Ts37HT5FhykX9R/NQVqf8dghDmafhxmRL0VaDDgrGnVmgqwrSTCKUn?=
 =?us-ascii?Q?WXPKvDyVou9DA9Bjly8VCFzzSSjHNDfvA5Wd1qQoFkuy7rh255/O4R0bwToH?=
 =?us-ascii?Q?K25i1BmKrqu6olLCVFSzJquQZ8L4AhtRmVtMTU3kIUaS+09W0fCRzdrob+8V?=
 =?us-ascii?Q?ND9nWApU4RVvmqjrfzUDxJESDyQh7flc0bPfNkTclmlebnHlfKQphs1oj6Sn?=
 =?us-ascii?Q?6O4QAfISHrVHF/yj3vbsnCJD/iOBkWGWoWI8w0R7CQU2AZ5vCEwLvwzov709?=
 =?us-ascii?Q?Gty6lFdAifT4ubUEFc5ZbeCBLZkLo/cArgC0lhM6JEzLAL0SNV9Zxsi25GOp?=
 =?us-ascii?Q?tqNQPwfFcEBeb1ERVkw28Ie/E6RXfbr0ujbaLn/wIe51Tw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?myS035wHTs+U6DidAthEtgd3xLl7J9Hed25OsLKqETndAioSH8kZMD6UVUoY?=
 =?us-ascii?Q?0rmSxEJDgETXxKKxeq4nJCCcaRuPQbpxTQW1AToTmYXUyQL4te/XkRQfhyYL?=
 =?us-ascii?Q?iqWeCvqpnG3epv59/K2MmvQXaPtZbxiALcF9md4QSxtwMnA3c6RS0tTBB5dm?=
 =?us-ascii?Q?Jj60bCuqY6qxUgGkzWzfBEqLG3viFTY1bdIdy2YXKyfDP99H+q/wMlKoXPTn?=
 =?us-ascii?Q?g/tzrFN4lSZ+V0u72HlSPyfZnzkvPIGKU7zbI7JouszWclBybj3N/0jSWjzc?=
 =?us-ascii?Q?Bdo3TDuZcZPYTiP+lM2dNj8c0ZqILe1D8u1jIso1otoiL5dGL+ZoogSGzKUz?=
 =?us-ascii?Q?COLjakOgp9JmM6jTNUhdyJxH1rLix3hO7YDFtqHMXXeXYCR2fwusQL6fu7RC?=
 =?us-ascii?Q?Ie326Czg8Z1C9bHtBp/xcwKnGwLvpagtDQWgZ0kAGHZOYlTQKFZzbr7ig60G?=
 =?us-ascii?Q?KUmz+jU/6z4gkQgydCz6zB7pQxN2r/RDVpvIqG5gC30VlYarjddqHVfD/wnc?=
 =?us-ascii?Q?5fNVs/Wstmm4R47fd3Cl/Qi7KmA6MerO+1sFrpy+Kq+ae60YnSAtDZu+++cp?=
 =?us-ascii?Q?xgONpJ9g3DwpBuW0MAu9Ae0OvmB1SdpfyBUot58R8d55Zcagdy0aGAFeRCys?=
 =?us-ascii?Q?EgmwuCmURH6vWe3i3Z1iyKTpX3iZnZEDFzkHOstajjk6x9iw/MmgvXqD8CAu?=
 =?us-ascii?Q?pDxWMFn8RMmKLPAUlt0ubxbKuhw0TIqwu0h5UYybpU/MAFui522aANAzXr3g?=
 =?us-ascii?Q?nEfuvV/z3SWP0l+ZWk92op42FyTcVJAKoi4ip3zFNw0b5kqG54TdhpnGFJPf?=
 =?us-ascii?Q?1TBmj0Et+EmSTSStYU63ph//o9hmfiVMkHfCbGpG2lqlFbqlIdMTIbfK1hTZ?=
 =?us-ascii?Q?g4ZjkSpnd8dmDFMTYb9klCI18c9oDFIyTnTsYyv5VIYz82u42LwInt/qCENM?=
 =?us-ascii?Q?r+y6vpctHAp+4m4Mpo9aQF13APJVx3NTwv9JVgoJ5G6MicbtvCok+Iq+xfR0?=
 =?us-ascii?Q?3mLqCfE9aOSXRhDN10kwAGCnRJmnJF9UV9CU2wlyzMO+SRfNYSwVlnQr9b8w?=
 =?us-ascii?Q?0BGnZkkCoIEykgrxQelzTcnffS82ViJ2bmR9JKjSDbV4aVw/qdR6lxdma5NO?=
 =?us-ascii?Q?6SIWNbgcdbEF+nMwHcZuYIpw4LjIo876zkDV+U0t+6iG98LH5GVrA82+7kOq?=
 =?us-ascii?Q?nUWWPpdeMbGsoCqExAaK+GfzKQVQ+iTiBfTGH3kqxGk5SGkDhHedYcWiwjUg?=
 =?us-ascii?Q?dy9MFhTvqsFuM5fgUqKkL6ZtVSvq5uliI8aksbpAM68D3LbcBKj3U7Lbd5og?=
 =?us-ascii?Q?EjVzz6MAnnC2Y/k+4yKzPYADLsY+RoA+M7ls0h7o3cQ1qTAtgAG+fMk3CS3O?=
 =?us-ascii?Q?K2Ouhsct6PAl8JFUfoiNRg+g+imL6pBoML2Qpup2RjjVgiFaXpyqywfwAabZ?=
 =?us-ascii?Q?AwwcDNseVbYh6Z+m4womY4Bn7wJ4aOsW9P+lWxxh2nCGYrj69vi2ISdviYRN?=
 =?us-ascii?Q?/rryy87R7C8nkI5L4kSBNUrjjvzTPDPEVBpRLROeGXJ/ErApoWyce3xkdhWB?=
 =?us-ascii?Q?m2A1A3K0mpdX8kBsNi+L+tZyY6F3mgVTxJenTGUS7blUAcPe6t/OarATXqPW?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H395D56k/4ck6gzKx88Mp2sYs4B825OCyXpvROMSGM9c5cOd6fRG2yqiMOEmKBowgFia4qaso1OER1e+h2c4jWohraFbEvEPl88R82anBr3KRJSSaS/cj3LOLIiHU0K704q4Vt/SDQs1KcH+NAo5CD1Fdqp9zR3E1q9/1oPZNyzzHW3UbdutyRPfooheTcr4cDL0zdGU3Otn+lMXdYUOnTuBkggkR1LF6VsaPwy3aoEOb8Ox9BLmjZ9wzoFEzMxOE4oylZuLe5advo4X8mSUMrVX68xz7/x5K9QE/CQlNO9E+nMxCBWUj8OTV+RNe41JfGmafBCA+vV/TtzPc3R2z7K9ZgELRxdhCD6N+pIa0lJLJiFP0KWAyoDXxUwVel2w6Rhh+sc6kDhiTpuw1tjpUG7zBqBgB9iSrKfYq+gFbaNN+ZpHwmUvL8ZK5FB713pij+qLvuE842gK/PAcg746VkQhxVVkR+1aVYu/i4Njj/i4VRcjjkpLOXlcJLUJ4dFvGOu8Aqdiq+cEhgzz4opHyQF9qrVj0fuSB0u355Y93FCALLH+6pT0Yrg0voupS7Vs8et94pPojeKzRj0lw1Q6VutEepGsAb632GKtifG1GYI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd58defd-9cb3-47cf-e255-08dcb2477306
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 16:31:52.3610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03Xlq3jwc/72m7+/dlDGU7iMjuC5rW842t11Rc55tRywYkx99LmcIZxOSrVFnIm9N9jMNsAqo8T/5NDEyBtotQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_15,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408010108
X-Proofpoint-GUID: fnd7NPQpygYHB1Q4Xj812Zd7yJYO7zGc
X-Proofpoint-ORIG-GUID: fnd7NPQpygYHB1Q4Xj812Zd7yJYO7zGc

Like we already do for rtvol, only free full extents for forcealign in
xfs_free_file_space().

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org> #earlier version
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_bmap_util.c |  7 ++-----
 fs/xfs/xfs_inode.c     | 14 ++++++++++++++
 fs/xfs/xfs_inode.h     |  2 ++
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 60389ac8bd45..46eebecd7bba 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -854,11 +854,8 @@ xfs_free_file_space(
 	startoffset_fsb = XFS_B_TO_FSB(mp, offset);
 	endoffset_fsb = XFS_B_TO_FSBT(mp, offset + len);
 
-	/* We can only free complete realtime extents. */
-	if (xfs_inode_has_bigrtalloc(ip)) {
-		startoffset_fsb = xfs_rtb_roundup_rtx(mp, startoffset_fsb);
-		endoffset_fsb = xfs_rtb_rounddown_rtx(mp, endoffset_fsb);
-	}
+	/* Free only complete extents. */
+	xfs_roundin_to_alloc_fsbsize(ip, &startoffset_fsb, &endoffset_fsb);
 
 	/*
 	 * Need to zero the stuff we're not freeing, on disk.
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index d765dedebc15..e7fa155fcbde 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -3143,6 +3143,20 @@ xfs_roundout_to_alloc_fsbsize(
 	*end = roundup_64(*end, blocks);
 }
 
+void
+xfs_roundin_to_alloc_fsbsize(
+	struct xfs_inode	*ip,
+	xfs_fileoff_t		*start,
+	xfs_fileoff_t		*end)
+{
+	unsigned int		blocks = xfs_inode_alloc_fsbsize(ip);
+
+	if (blocks == 1)
+		return;
+	*start = roundup_64(*start, blocks);
+	*end = rounddown_64(*end, blocks);
+}
+
 /* Should we always be using copy on write for file writes? */
 bool
 xfs_is_always_cow_inode(
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 7f86c4781bd8..6dd8055c98b3 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -645,6 +645,8 @@ unsigned int xfs_inode_alloc_fsbsize(struct xfs_inode *ip);
 unsigned int xfs_inode_alloc_unitsize(struct xfs_inode *ip);
 void xfs_roundout_to_alloc_fsbsize(struct xfs_inode *ip,
 		xfs_fileoff_t *start, xfs_fileoff_t *end);
+void xfs_roundin_to_alloc_fsbsize(struct xfs_inode *ip,
+		xfs_fileoff_t *start, xfs_fileoff_t *end);
 
 int xfs_icreate_dqalloc(const struct xfs_icreate_args *args,
 		struct xfs_dquot **udqpp, struct xfs_dquot **gdqpp,
-- 
2.31.1


