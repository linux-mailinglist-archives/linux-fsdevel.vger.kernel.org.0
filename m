Return-Path: <linux-fsdevel+bounces-42773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9A2A48765
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 19:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7023AC3F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 18:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C7426D5CF;
	Thu, 27 Feb 2025 18:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HeHAyYYK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qCzeBWmZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8C21F417F;
	Thu, 27 Feb 2025 18:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740679733; cv=fail; b=DM1/YNCSN1VxzzALGNzE/42ysuGHpBTS/yXJntCtOFaWjqkEAu+20lPlk1f+hH4CeBm5XyAfb05N2bkYHeqTNFYJ9XDtEETFG6ipmMBj2f+9745gS0v6oUF1c5u1OdL7U1ItUT2jOmL/Ngc1eoekHn3jgHedo6B57MCn6ATFwus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740679733; c=relaxed/simple;
	bh=u9qSvhBTFJNC8NAi2xtS6ZybO1LBv2KXmZqevjQ8JIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WUKLXyhnP3uHMsmY+zJMehoEGxaJr3Obqkn5Z2qIje+HNWF5f3wV4iR2yZCWA9FhE/Tl28tRgWO80ONJSOhKD1rejqP55OwR+lY5uEbrMr0x+r416k8/jfPzmSXCzmpkcpv7TOoxauOU2sqH0XhbSwoT00pK912FQ5ED81G5FOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HeHAyYYK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qCzeBWmZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RGfhCx022890;
	Thu, 27 Feb 2025 18:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=OWYwa/5i+Jj8/qJpWDTKU1Azcekr3UtxyL2aK4F39t8=; b=
	HeHAyYYKMhCoKzb3B8RjAvZYEvDMJ/2ApzLfaGpl/MRLqju8+8COOHCwO8XPb2Yp
	npYKDAVVQmsuMUZ0a7tup9Vl4MCoPsKu7dskjYfg5QeKV67DwMjjyPrYmuMBfTri
	0y/WOEKmpt1raSjA9PI5qBx9dOzo+FM+QqQDYcEuYSOQiFCwYSaZls4rYML1emtd
	GsYuTLx5H7NWGw/gJlgr3Dj6nc9pfU3qF2qfSLRLCSgKcy5X86yfiLVPUzTkbpJ4
	Pup3ptAl+dfE6Lsb9pbsvSCKm+64D6vq7M29+O6IOjTbckgbBKx7mMFa5iNUFUnv
	1QhS1TcOHY7j6WuwEybrGw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psfuyqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:08:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RHUwAL007531;
	Thu, 27 Feb 2025 18:08:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51jhqse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:08:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIwTDrCuiiTVQ/OV5kVmkttOs0ep8rpnf3L8xRKDi/9qHIvc/8SUtQcyX+VsNLi1h0PsZDgpI55qT9wZ79Hal4OhgD1CGEqAyF2UKSb3AKshaVzeksdg2A/tqiK7abU2drI0EplrxHPRzNYxs2s6QIZJAWWd/EUF54qifU0xIlIf+xtjvHy8/odcwyK7jS0snZCxVuQyaFy+S1TSN039aoZHH8nGjhrfGeTwq6qL20m5mIoet+zgUQImoXqKEpy/Az03iwFiVeeh3fOT1OaTb6Na4qZuw7zHqX0e/4zT4y43+JHnOUgrYatsDqHzlaPjIXSBE4HJDaSEpzCGWMRpjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWYwa/5i+Jj8/qJpWDTKU1Azcekr3UtxyL2aK4F39t8=;
 b=ELW5e0IZQWyqnfxQzGBtSY2AlCJU1zrBP8LtM5rSNzEkf76fct9MJuzmIbw89ENa6igKU1kTXAhYKJ63np/TOvkZA7uAvhdfLrrnB/504bi51G6hl2Js/nidRpH3Td+5TCHcNI/RaO6stGq/XxlbPzVv6TST+xH2iltfyzBWk9L56F1/8/g7RGhbHpiFy58MB0Bp4P1b1JLOni9ZplmVmFj4Se4Q3L+xj+kccTNszJ8tF3aB1KBftMD5Tc9FxJ7G0EaC6ogiRPEknAx8GAebq+0u5c7vKUA+WKKSApdWCREyxxJRuImPrXaeCl+qA+RQnJDp/lmSvl0xhiSJqjHwXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWYwa/5i+Jj8/qJpWDTKU1Azcekr3UtxyL2aK4F39t8=;
 b=qCzeBWmZ25qV6vjFYY/NV2k5IJdVbp/3cfZ2pg4+iBQU9EOqQ0IDVz2eJef1HVy+O92VO9v2QdUsufdex0aBN/UbMD6jmC9+KqoscfXhnBrTBy6ftsEchbfjrgm4CkHz7YKeIkDgZ7iYWFvtHp2V4pn/N46AXp8mjyTuKHmF3KU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB5031.namprd10.prod.outlook.com (2603:10b6:408:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 18:08:39 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 18:08:39 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 07/12] xfs: Reflink CoW-based atomic write support
Date: Thu, 27 Feb 2025 18:08:08 +0000
Message-Id: <20250227180813.1553404-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250227180813.1553404-1-john.g.garry@oracle.com>
References: <20250227180813.1553404-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:a03:331::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: 99db2174-f642-4b43-9790-08dd5759c348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0N4sf03jQRphv/znNg6gxH+DTWGwfvqPEmSROndSZD4felNnVbNJCGa8uq3E?=
 =?us-ascii?Q?Pk34DFs6BT/2Upls9a+RVOZW2Y5kYl7QeBycoQ+jOXQckFAFAszE43gVKd2t?=
 =?us-ascii?Q?pdbYOXR6zq6BvkXFAvTujbmiHOtizxpaaaR28MMAFUzn5H8Peh5ECZHaPc7g?=
 =?us-ascii?Q?JxFMpxT/TzVdlWpPa7wRoN8yE+sACLXNegurnyliQ+5smwG/qIsMEnNGjMaV?=
 =?us-ascii?Q?oJ/hZjJ2FKTxz778UZ9EFRlKMK2jqFU3AYwMXSozk1g9g5Q/1PQAwfRE92F7?=
 =?us-ascii?Q?PVX3UDPrwIrOjpmuFv3UBEAqf+76v64xr/Rsqt7EUtX7awahH4hBvQHjBLQx?=
 =?us-ascii?Q?oY64e03Xr5bwl9Gi27j1UbCT1B5WtzNkXCyDIKgqqmPi6EfAeyA7kyJgneO8?=
 =?us-ascii?Q?HH/UWcSz0VXboTYdQvn0RG+ROTF8GfjOxgtc3Vosa3oJqGJWCm3h3UZvg8Kl?=
 =?us-ascii?Q?97ESXQRD4lkqBVrRJF5b7orJMpuHgNz/YFocYpLHy0sDqfNX2Ys6bpU+MXLs?=
 =?us-ascii?Q?+mmWXhdOQeG3CFsi/bEWDM5fwPy4EX8MTblgHjH0OJb8og6a1g/FZdpHHeus?=
 =?us-ascii?Q?+ok7TqE43SC9TZ8fH44g7qr9Af1bi+++K2rD6zBr2ryzvkCRvi93t4fCZaKi?=
 =?us-ascii?Q?K3/GUlr7LTqXV2X25HntB4IXx05nwrXxarxeDqr8ajuFUfhOQuJhxKCaz41w?=
 =?us-ascii?Q?KoGgpNPUMkVcfIkcnEcDVbJSe0Q+ZumFvxI1uiB12KnpiGIGIe01v605VHvm?=
 =?us-ascii?Q?U9GZ5hiq689ahOkUqSpKdan06wR3InKha3OwwF++KxwFdO6jPhz5lcMSL/Kh?=
 =?us-ascii?Q?Ealk7R2MFJpdS2oKuY8wL6EYSLE34h3vPIK0//rXtg6XJSJ6WON8A2TP565s?=
 =?us-ascii?Q?4y/yYfzR+ZyaRz6ivTW2NkqC3o72zDkEbr0W9TcAK5YWYJ/QwYQIKiXeCztJ?=
 =?us-ascii?Q?wrpUOSYpXMl4zqqPJdfhwWU3H0BH7lidrhpXmKGv6lGSgWqM33VjfCIx9+nY?=
 =?us-ascii?Q?Gtd0p82STFbtM9fNEmeh0ob8gKCyuqr26OYBBBqqALEnnWAZzCmaBU7d7/wz?=
 =?us-ascii?Q?Pf8fTwGv/tuCjPDR3Myb66CAFuMe222vIaQfW9M40fspfnbgZLZCnTPYLpgu?=
 =?us-ascii?Q?JjsFckK8uE18hQZAVB424RJTK7rL3qQIW4kchWShZo5ewkF7chjca8vMAUTD?=
 =?us-ascii?Q?Sjik3iSAsU2WiHCnuI8wWz5e8j3VP2sL8KO3836yfhFp8BpkJBoj4seR2R3Q?=
 =?us-ascii?Q?/02xXdbgMWmzDEgRu38jqQ3FHZJL90scr4H7rYYA6loPQQjo+gfJi+/404lV?=
 =?us-ascii?Q?oxDgoQcQfX6TSWTv93zIVR+XUEyiaOWzJHRtHn2TDXRuvimBE8X76LQczfeR?=
 =?us-ascii?Q?+p8VefIdM/aA6NLWWe1dPx3+owEE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MQ95peXh8hBLxzlplKoh6bqBLG/PUXcvP7t/AvzEIkxbm53EhNqt60fSZJXF?=
 =?us-ascii?Q?NcunkmXZ7EaZKjzAus4l/xzJ0KlbL+hkor78eGVKwOEINmcDrK/LjhxxsxG5?=
 =?us-ascii?Q?ACX9NnHvpVgoaSKoAYd+6ZGRknMpP8L7KCf+LU4xPS0YdBZ+g8hK54ZSxhvq?=
 =?us-ascii?Q?v7p+iF1OXWJQONvBpGMKqhdyN+uRK2tANcSqBYfxTKhfp7CAbEYpfWggKryH?=
 =?us-ascii?Q?UsFXRdkFmh0NhTnhKPh0jwrYCkxz4D/uGGvEUArbhxO8oZZZAg7lN8L7KgT+?=
 =?us-ascii?Q?WoOq6zw0T1zC8S/UCM04Xz4+05U4Idthk+aKlKxWPWL1AumADdnE85ErCK2N?=
 =?us-ascii?Q?JXyWPbaMJu2o5KwK2nwlocaqpvei7KVbTZdGc/KoWI9dwP4eAMshpAx4ToMV?=
 =?us-ascii?Q?45NqsVrwAlbp++3fP99D8i+w+6eYLdTJSK5wgQdnfs7wJsM2YK9KF+J97Qox?=
 =?us-ascii?Q?JoLvB9e10iFxLO+QkELEAylOrXY415qINSFeNFRqSoxovZ8sd8tij3HHj8EM?=
 =?us-ascii?Q?D/R8PfrQaH3NA+kzItdz+X9DQBk1sgf2J/dDDG3txSA+dfConOLF0MGU8Gsc?=
 =?us-ascii?Q?01dpfn8svB9pr1izLg6TL4kgK/5qeqA8ntxG+sabahuddtPBHwO7+XdAFPDd?=
 =?us-ascii?Q?5yCJc+/lnK8iW5D77a+PoRA5NTNCmLuvOMM3T3sr1MhClsrrBGv7njwbRKC8?=
 =?us-ascii?Q?0yOC7k7P/12ZDg52kB9W3GxB0jK7bfGVcRA+JTnJ5ujzr2LpfNGbHz4DPHJI?=
 =?us-ascii?Q?Sg5yUuAhKNY4lX2hPP5vpnDhaWyxMY/qGVO4lsgeOcBPM/g2HkHxQWZwKOPe?=
 =?us-ascii?Q?anVIeFc1+3jlbFtRlT/fZuAIc+Tq0loacilk6VvXOXBWXGSxIMYcfvhVAPtQ?=
 =?us-ascii?Q?iwOD/A8veSdTcXCY5xX/kJRm+RzcwcSzI2Pk/O7tun346KINrrEyxnmDJ3w3?=
 =?us-ascii?Q?QF7nwUqsRL4UDqWNMb6DqZjQKjmsOpQn3zdc84RYp81WOshlgKialj+SC1xe?=
 =?us-ascii?Q?O2wCQskkrxNcf2DxvZM+0Mp3qZ5ZfHVeBTy92OiXDzf0XbfwMfZd9nZMCwG5?=
 =?us-ascii?Q?DFz9r3mJEMBPFHN05hFl8pf5pOmC453oSfexY4GCzmshmAS3NUXmAgDFjzgY?=
 =?us-ascii?Q?u7ZvVoiaz3sPINHSrUEMr0+5pLDNXVv38qp3AALvvXfvQap/q1H2rKcQ9e93?=
 =?us-ascii?Q?eyRlc/Se5OjNGgH9pBYtoyIptCqfRHRUbfX/pSDpHTpjjOYzly4sKtgesgSX?=
 =?us-ascii?Q?YJUnDOwxW6SGA3vYu6KSDricng6SBc+rDrgWiqy11f18BeOsnAh1suRG01Cp?=
 =?us-ascii?Q?jyC6C8bNOLWiiG29zwMPDg8xqKKS1JWwXDwrKqnkgjqID8UySUzaLBxDHPz8?=
 =?us-ascii?Q?zjT1N7W3GhPaSmonrG4hcrWDIrVRz6L4sOtc24WZxrYTF5XLbE+c8vyXkGff?=
 =?us-ascii?Q?Do178jwQAsWg6iN3mYqZesuGROVnv50pUjVojv8awIUkUV2eoPwAgTdtbB0S?=
 =?us-ascii?Q?82bpi55uwoJQaMUETqsUte7gHPP64fFUSWMX8KjAMOS5za56cboN8bgv3euI?=
 =?us-ascii?Q?GFy68GZnrEGX1fp61aGig3sCGAEpRRM+yNk4KibdcvjFL1Sbw3CAewAWpXXF?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vbYsSphhKPCXyGFoyiUeaaNS8VQSa09INqKvYw2Yt3cT5s6RQf37TCsOBYSjdp3Aj1LLn8CgeuyKjqzzEW/QihS5TXAlOfDQBf8VovWuX5UeSlqIJjrKe9JIfYvGBDS2rNsCxIrM00c4GD1qtLGyQ+STPXjLcohnqgZnOjrNMFTynwsw4et5VT7hv87M6OMlqvJldKNNtERnsw5gLHK4ViNgjB6X0dtO3bC4NpFcxC/qvJqrlCQezMGNYYZ8sD8A+4vJm/3/rgouCdiQ8D/PiLrh/Td4G1HE6OWHiLVz6xHuKyrgNnk6+v/6Hl8wswUoaYw8EYPieg37l5RP/L/EwmY2U04bhCKENY8ysnA1kAlqaWLyfVyEB0Ti1WDrbmSdzzxxLQcIGsh5wy0hW2nDzSn/7y4qLYbwdgVZ1sNW2Wks6ojAQj9BB0rJo58uuBLMxGjiC1q3O8SCKr0vuUfk0xfTswSBNDn5IOWF/KXOc1EdHfuDKw4FhEHSpqsbYJ3wn7Rdu5LPTIxLd/KggDmh26sTM7+WvuhM0OIU1t0jA5a84yQDB1OKW71fgUFAm5JwhgpKFAeisMFTw8MSaz6wbt763113POpxnQ21ccVs3g8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99db2174-f642-4b43-9790-08dd5759c348
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 18:08:39.8049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Cy2Ru+S/UDHXx1W8WVIkQ/umhF3fu9MCv9fFcPh3/EczrdDnbJ1cQR8fMNETfjEiXdpfRpNzR25QZ1R6DkZrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502270134
X-Proofpoint-ORIG-GUID: C732yQfL-JLruiSzrBKQ-qfHPcEzhtWn
X-Proofpoint-GUID: C732yQfL-JLruiSzrBKQ-qfHPcEzhtWn

Base SW-based atomic writes on CoW.

For SW-based atomic write support, always allocate a cow hole in
xfs_reflink_allocate_cow() to write the new data.

The semantics is that if @atomic_sw is set, we will be passed a CoW fork
extent mapping for no error returned.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_reflink.c | 5 +++--
 fs/xfs/xfs_reflink.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 3b1b7a56af34..97dc38841063 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -444,6 +444,7 @@ xfs_reflink_fill_cow_hole(
 	int			nimaps;
 	int			error;
 	bool			found;
+	bool			atomic_sw = flags & XFS_REFLINK_ATOMIC_SW;
 
 	resaligned = xfs_aligned_fsb_count(imap->br_startoff,
 		imap->br_blockcount, xfs_get_cowextsz_hint(ip));
@@ -466,7 +467,7 @@ xfs_reflink_fill_cow_hole(
 	*lockmode = XFS_ILOCK_EXCL;
 
 	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
-	if (error || !*shared)
+	if (error || (!*shared && !atomic_sw))
 		goto out_trans_cancel;
 
 	if (found) {
@@ -580,7 +581,7 @@ xfs_reflink_allocate_cow(
 	}
 
 	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
-	if (error || !*shared)
+	if (error || (!*shared && !(flags & XFS_REFLINK_ATOMIC_SW)))
 		return error;
 
 	/* CoW fork has a real extent */
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index cdbd73d58822..dfd94e51e2b4 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -10,6 +10,7 @@
  * Flags for xfs_reflink_allocate_cow()
  */
 #define XFS_REFLINK_CONVERT	(1u << 0) /* convert unwritten extents now */
+#define XFS_REFLINK_ATOMIC_SW	(1u << 1) /* alloc for SW-based atomic write */
 
 /*
  * Check whether it is safe to free COW fork blocks from an inode. It is unsafe
-- 
2.31.1


