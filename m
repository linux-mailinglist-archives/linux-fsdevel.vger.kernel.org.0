Return-Path: <linux-fsdevel+bounces-40737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D890CA270D0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 13:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B6E57A3081
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 12:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52440211293;
	Tue,  4 Feb 2025 12:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OpbnIdK3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gFLGD87c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C217420DD68;
	Tue,  4 Feb 2025 12:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670535; cv=fail; b=h0jj8lkq6GHvoW+y9inGFLciI8cj+I9uES6DCXYYdezyQyi3rox4WRtrjKRnKrwWRRFBl4qMzevSuNyAJbr1ZNlC7fMAmWFmgmpj9QdBWOr5ghBjh0A8Nuw9rlDVc5TNPYDHl8vP22QLP7jbox01I1y5owhvK1YKqft7hRCJGRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670535; c=relaxed/simple;
	bh=5I+aaL03hgQmBUgDsvtjQuVA7M4kihj6AtBZWMuhEMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mggg7A4YH1QXuYn5jk/na+mbKh8lFYCK9bcdvPFZAeCFRblu8qYnVZVYHIprBIaj+Jcz9EiSMZmOcExYt+gdTnz9lUd2j7jKQC5TnIgLD2vj3zltgGMiluekrZNPJZ//P9WLyl226KXJNyqPrNjMACq5rqGAMkIlM+hXvJlbRKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OpbnIdK3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gFLGD87c; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514BfUeY026091;
	Tue, 4 Feb 2025 12:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2fGuV27Ovy7ztPf/Sh3UsP3aKqe5tw1m/30oW8XgfP4=; b=
	OpbnIdK3+yQUt4RjGwbFDDAAASvIYBtuhNE/9IDmyurH+wQfDE0OIbEksCoEfuPu
	kwWqDeWv3Io6A23vzLzRve6ajsS+5vGsRrgFpPwO3tx7coMY+iryJxWZGH3BmM8/
	jHEMSmLebn+7oeewFgYqoqksRqf4qhffw0+VTk9+c0hrX1jZNelMsrP6hR4Vp5/J
	jJdffD9cdqTNHsaN10bNQyBRl4xcrtdHJ8aek5TYyWrEw+8xJabQiV6/ua/zcuU9
	hQlS4tVDBHCq84XnFlCP3jWj90Emq/RezF3rlDs1IryGaX9TTr/H2/gUXrL+APwA
	CrKVPHD+BGbv/2XSKiuD7A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhjtvkvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 12:01:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 514B5OLt029398;
	Tue, 4 Feb 2025 12:01:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8dm5drp-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 12:01:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPNq/6IRkU0r2ovYJTjdROdCW2w8eRPPlJqjk+np9VaAJBZ9AIQ9vwO8ZOwNWBv+gQz5PW/ZJao5PvDRfNpmxSRvgPhXspl/V3L+wWHOsFzcEpTn1kTDNw5hziLG5Jy1yv3zsaQYeOGoXTh9hYCWTBottCimmN+ihHDqrAnRtOShqSvgcd86EbMBtfqpw5BrKJJJs8STK4XwTR5XEj/CMEjP/OmabD6KI5pDpv9VMI58FmbmnHriPIvcLASbD8gs7XnqJWQRRAcb/+OdR/hp9b7ne0YLMT2iXG6JtwCnFTDOMz+oVvzytbi4hSFFgR64/97AgeWOLs6nCxNB4+MOyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fGuV27Ovy7ztPf/Sh3UsP3aKqe5tw1m/30oW8XgfP4=;
 b=BGVYf/oRIklMz+sbXOJKmPsFdeKpEasT/ucDGzd9zm8LhFT+woN/fWbRIXsQhNeUw/21lvkgj+gJXhD6JEhPuZcciFZvAtHAMZt7NghB1ee25K1cMAxfTdyDR/N1q7ENHmSjfR8AdDsdc6k3hYzVxnHqFuWXcHsjGcqkn8QJ2r4T+L+yR8dNu5+RPlmdc115OAzohyvUXK5GnkHDo1ZXnuN4vqPaFQr6cGqgUTIghxNUir5xyhW1/fuFTq6dDR/Ii0FBjlSqqx5BHViZQH1iRmOUcnXQdSV3Ge+r4qV6JlUykzARqX4b0+vFYe4H/rf637dff26jze6TQ2PW+pTsTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fGuV27Ovy7ztPf/Sh3UsP3aKqe5tw1m/30oW8XgfP4=;
 b=gFLGD87cXzcqULj1fzhHDHlJt/EN2iNiR1LvH2oU69OhC4f3iFqhTXSPU8yDdubfQPYQQF4LP853vq0oXuNCR2noxefwQYTFyZJpYqHLJO++bHkmpkyFANJSRdfV0sYNREvkdrz/w/kOxFj0y1BK9YRpKRY48bkgQgHGkCVLhyI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7648.namprd10.prod.outlook.com (2603:10b6:610:179::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 12:01:45 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 12:01:45 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 02/10] xfs: Refactor xfs_reflink_end_cow_extent()
Date: Tue,  4 Feb 2025 12:01:19 +0000
Message-Id: <20250204120127.2396727-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250204120127.2396727-1-john.g.garry@oracle.com>
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0431.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 17724e0c-8284-4af6-8fe6-08dd4513b1f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cg2K3ITbGzZFwUfm7RaIGqbHs3qnSMD8meZmgKaB4rgdu71f+ThOShyB6qZH?=
 =?us-ascii?Q?yKYvsQeDWCEhEARsuIih9a4emiFNP9DvIDMGts2AIG16oRQttFxT8oKRCkHQ?=
 =?us-ascii?Q?O3GXs5vkuwRMtvanmlxqftKxI9k2FxcdqkTEh69yhCeK0jbFCArJJ74Tck3g?=
 =?us-ascii?Q?yCdz/fetVb5ceTlckkYuRf6za0dJ0Dg8I0E1JfWOyCAmrVtMyUEDBJqWKYaW?=
 =?us-ascii?Q?4NuzmE22ICqBjW4YSe7FZ7Sg4yPKjBTwRvqYvAuTPJs33o17CuC/3V+7wkQL?=
 =?us-ascii?Q?H+XBNm4fp9j6ap/UCSRks+1iKcd3FpmVU8+equraH8i6FEFjzzgvdbn3Xv8+?=
 =?us-ascii?Q?bQijN8Clsn0YQJdVv9Mn+T0Ea54g0HKyJ5XMks7U7vwqYEtIUPkGAPDVP2N+?=
 =?us-ascii?Q?PdHrBoKYg95bP9OX0d4eKCE42ZaHrSEO+O2OBTuc0O7IV8Wnq/25wy+gE9PO?=
 =?us-ascii?Q?D6/dZeHg/+1pncpQkJGWf++vnV2FeoSD6OAS3rW75b5dVUTeqXLcSr9xaMbT?=
 =?us-ascii?Q?oMl8F0WMOg9ro6bwRXOle3iGVmYGCO6y5wWcXuyPaV6dpVrtVRV8xelUzqds?=
 =?us-ascii?Q?JacWejvVwNk+k7cKmZm8sRIPPyJSnsew1svU0SKYY84X0iCj2fTVpM8y6hGh?=
 =?us-ascii?Q?5nLUUVFXglxHVaA58k5e5bRfN+kjcH50atFcF97WcHqEIXScUvCKAvRKdNKc?=
 =?us-ascii?Q?Pl7A0S8/fYpp+DEk2g852g2rFH6RVBru2ay5nfpA60GOQIsHGS9afkccGwAX?=
 =?us-ascii?Q?uieq3h4Tl9C7owq5NaUGwPsTMz9+Dc8JVaFQ9bFa3N2gg+HgpUqb9Jyea9TD?=
 =?us-ascii?Q?pCK8KdFJRd/LZ0wDCKyW6fnZjVY/vS11zELD60n+Bc/KhjJQ9ojkS3+ZPLsO?=
 =?us-ascii?Q?uWXYOoGwRHijqh2qv3K8JAE2kZ3QFmnV+OSaY8yFJyn+1zYd2VG0q4Bpw/Ec?=
 =?us-ascii?Q?v5YI4OeX/rR5D7d3/men+25bb5mycgNQXs84aPgpbvmDP9M49Lr/mWGqT92H?=
 =?us-ascii?Q?1e+BjjWUXNvEwuIrWIE5g9grRLHvSNlimJaxrE6TueW1tlPFpLRw3kQ4eY8x?=
 =?us-ascii?Q?AJCKHMXEW1VrChX4xo/dY5YRxwGttxcRJi9HnhMfdsZqRW9EJcwVEooa72WC?=
 =?us-ascii?Q?94HRJphZnMiykzdW9/LhaKurypRojM4B81SGj98IJUyiHvHoja6z1i4Z7m/u?=
 =?us-ascii?Q?lxI7gvrQLtAdGZCaUdsERHzVmimCq2YGHZagJIUN1HswmKPP4O3Sa/gbDkLn?=
 =?us-ascii?Q?kKO+rgwuviLVNF5sf3Ziqvl314Hg6lTb3Tk+aCf1Nh6G7RlBULHZei9c4iWe?=
 =?us-ascii?Q?5EPZrwGKnJC2N36AJTTG055QmaVFYfJqpArPo9RXBQD8BMjLL0KN3YNL90nD?=
 =?us-ascii?Q?IIVuGGDrtz+PZGO3KbChZVecd3fh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bNZjrIjrNhYrz4zLlY9Sp2TqVg+yRy5yyyrDJIH4+/IHtqfKvfar3NRUL4Is?=
 =?us-ascii?Q?dVFAfnlra5ua00i/0Fz04NTEwoWlfTZua1MgiJmkmzLm5/mJ9FiHie989eG2?=
 =?us-ascii?Q?hUA7brP/y1pEPpwl1JNb51SyhooIL9iIjdTAH0CTs68YmB4UlgmFaa2WkceO?=
 =?us-ascii?Q?oJfhGYZtexphaV0GPv+3IqlysXdT/uSTFKxljSwLWKWaWwG0x5c/FbSVhn1N?=
 =?us-ascii?Q?LGycsGI4aaRlOEPtmize1YPwBQMAE1e0WOwPYWrYz8PpuY3C1RSFB+thyIhi?=
 =?us-ascii?Q?41bnncN9IdJ/r1jjVKMT2+rBKSmnjO1QcrwP+2jdcM4t03RWt5mC6hmVeFRL?=
 =?us-ascii?Q?yBJkKL2SuCAXs3GaSzy1rykECKCOa+WJV8COANC7ZKJKszS0DXzkS8sMGwEX?=
 =?us-ascii?Q?FT8CIej1Bu0jm3riMIj4dFFpwYecLkpwNZMGPIu1xa5Bx6zdyrSOsRz14Gxd?=
 =?us-ascii?Q?7YWdhU749vykzgOnLIu9h+RTdfS+4eIrlRsrL9BouNm4TqLJQI9y9SCtFq6W?=
 =?us-ascii?Q?VgtaT3a9QnjeahS+TklpeshWJmB4rw9dO+NFohMM2Pbpst6rVIeSNmyB4Cmb?=
 =?us-ascii?Q?I2SQUE3uiW3WOeCmPik8YyNNV2xaJBA3i83OnKHaHGa/XJPpdDhhO5TBYo5d?=
 =?us-ascii?Q?S3ffUars2TI8l7qwAeyqkdzBUNY7V351B6zfuR3DQf/akpBY7HVPPeXmcd7q?=
 =?us-ascii?Q?1vvxiZQrsuXbVWoxIfzygneWoazwsn0jnP1k0n33eJEH2pTHFTFh5KE8Ah5i?=
 =?us-ascii?Q?5IEvO3zOkdPLGEmQXUNwHhZN9G3Qgb4RKmok26ALnN1qEzxTZtLsEeyVFF86?=
 =?us-ascii?Q?xQL7yEguvkWSJdSNoExrKFE2taiU1K4UzfmJZ7kctjaGLLnpvaUP4CGO7SI3?=
 =?us-ascii?Q?2lz0wZwFVZDaxgY2i4845FMYg1qvlcOeXI1Ukv+3tWFHUsOcGUj8FQa61Obb?=
 =?us-ascii?Q?VU+r/7fEfbNewgpVw1lJQKdUhH1cJCUl6JORuwKTYs/Jpgubp0QxEmHoKp0l?=
 =?us-ascii?Q?rsC02cKeTGOgJ4I7wrU053mB6YeEzK5H5Vj776vOjdBhZTDrU8AmI1E3rrYM?=
 =?us-ascii?Q?hNoGQoRpwuSmYskqeakPSnqbAS+7ggPDTDD7dlX1awcT/ivbh4imTwaOKSU6?=
 =?us-ascii?Q?fJK4cDfc2so4c59/3VQkbFmB65yMlP9UTAByfRckBoBz3thq/2TtqReXb0gp?=
 =?us-ascii?Q?lz9usBwvTLFErZRXF04yZuJZxWByOE7ODGM/io30BaHEAP/mUql31JituJov?=
 =?us-ascii?Q?SbRJrRy3Fc89yFFbroS6B2FGNuO2C1IaiLRwWbyH5zZsAGLNTPFDepStMKY5?=
 =?us-ascii?Q?o099FZYJea3LcqjcGr5Fgeo/ocm6mjFNOoJhwAtRLPRUGx+f/4HgVQVbed/v?=
 =?us-ascii?Q?1w0YJEQzZ5c4kCnwE9/igK7Ird60tUXNcWIfHVqEf0Uj2VhGBXA1/3z5KEtS?=
 =?us-ascii?Q?WhKx+6beuRN3inZElHSmQCDeOGvWsi4jQOiO3nDs0U3fxV7hLUSTm1UlmEvM?=
 =?us-ascii?Q?SwJWaIpQtYUCL/wGniogzcQouTaVT73XaiO1KmzybfGK7h+jLdRTwRElFAwa?=
 =?us-ascii?Q?BJ/C+yj/djoAfXXkG02IBVEH6bnU97q3f8A6cLN7lxqvpANLrHzsiq/Cntxh?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7SPSGVyz7Q0OEuxDme0m4xBJckTDv2dBbMsMneZI4qdJTDo7e/AG5rQc9zqwwHscASBgc9gi81fmV4qF5hira20NGUIgqKBsIizaadZH1KYegVjYSKFNlfyJjFfKQOSe8htp+N5/INQETaT2iYbT1uIcJEEmPektFcYdISYK1kI+r5lB7zmGqWY5P0UIBf37xlQaMH+ORcJMi6UCxe9An4ngQCgA4VnL7QJtHBzorUJPVik34KBq1YwMW1GoiqeMO4jjUXeAPI5a5fcyd2bz3d3zkND6J3YExoxIm2adnwKejDqcF3VUwNnO3+b3JdeWtQ9YadclYr9tWjNa6i5ofJLVv4mqz3ajSMi7zxdmS2HchGTpe7iGuG1UYnncdZUN2FQjCCxhb1iEo/3fxkDAatbYLLMokhRgrYalyo2EsPj6VRjkyR4Z1heDN+sJpTQhgUgprMLVuMPJiGI2ZEP1QHxqlem5Y4+PcqVMiO/NGyiRc0cv/GIgvRDDefxpuTADutTlAEeIHi9RUMe6LlQXBTWyq6tJvzGPW1PPwHExyppjcvovxU+3ba6IXy62Q0NW+TkJ2CHFY+T+HOFtYY8rXqfCupiv3obfFb7NFpQn078=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17724e0c-8284-4af6-8fe6-08dd4513b1f5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 12:01:45.0091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ys+LKI9/DemqrjAP0m/gvZfdsccoJlZp795PMb7gkIBq4TYaAEKaDCNgv8i0cYtUyr2G8/Q9axCEp1oowzqU1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_05,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502040096
X-Proofpoint-GUID: Ab0fEGnq3aYDu-RGw1ZmMZUrHG1pJbxn
X-Proofpoint-ORIG-GUID: Ab0fEGnq3aYDu-RGw1ZmMZUrHG1pJbxn

Refactor xfs_reflink_end_cow_extent() into separate parts which process
the CoW range and commit the transaction.

This refactoring will be used in future for when it is required to commit
a range of extents as a single transaction, similar to how it was done
pre-commit d6f215f359637.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_reflink.c | 79 +++++++++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 31 deletions(-)

diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 59f7fc16eb80..580469668334 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -786,35 +786,20 @@ xfs_reflink_update_quota(
  * requirements as low as possible.
  */
 STATIC int
-xfs_reflink_end_cow_extent(
+xfs_reflink_end_cow_extent_locked(
 	struct xfs_inode	*ip,
 	xfs_fileoff_t		*offset_fsb,
-	xfs_fileoff_t		end_fsb)
+	xfs_fileoff_t		end_fsb,
+	struct xfs_trans	*tp,
+	bool			*commit)
 {
 	struct xfs_iext_cursor	icur;
 	struct xfs_bmbt_irec	got, del, data;
-	struct xfs_mount	*mp = ip->i_mount;
-	struct xfs_trans	*tp;
 	struct xfs_ifork	*ifp = xfs_ifork_ptr(ip, XFS_COW_FORK);
-	unsigned int		resblks;
 	int			nmaps;
 	bool			isrt = XFS_IS_REALTIME_INODE(ip);
 	int			error;
 
-	resblks = XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK);
-	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
-			XFS_TRANS_RESERVE, &tp);
-	if (error)
-		return error;
-
-	/*
-	 * Lock the inode.  We have to ijoin without automatic unlock because
-	 * the lead transaction is the refcountbt record deletion; the data
-	 * fork update follows as a deferred log item.
-	 */
-	xfs_ilock(ip, XFS_ILOCK_EXCL);
-	xfs_trans_ijoin(tp, ip, 0);
-
 	/*
 	 * In case of racing, overlapping AIO writes no COW extents might be
 	 * left by the time I/O completes for the loser of the race.  In that
@@ -823,7 +808,7 @@ xfs_reflink_end_cow_extent(
 	if (!xfs_iext_lookup_extent(ip, ifp, *offset_fsb, &icur, &got) ||
 	    got.br_startoff >= end_fsb) {
 		*offset_fsb = end_fsb;
-		goto out_cancel;
+		return 0;
 	}
 
 	/*
@@ -837,7 +822,7 @@ xfs_reflink_end_cow_extent(
 		if (!xfs_iext_next_extent(ifp, &icur, &got) ||
 		    got.br_startoff >= end_fsb) {
 			*offset_fsb = end_fsb;
-			goto out_cancel;
+			return 0;
 		}
 	}
 	del = got;
@@ -846,14 +831,14 @@ xfs_reflink_end_cow_extent(
 	error = xfs_iext_count_extend(tp, ip, XFS_DATA_FORK,
 			XFS_IEXT_REFLINK_END_COW_CNT);
 	if (error)
-		goto out_cancel;
+		return error;
 
 	/* Grab the corresponding mapping in the data fork. */
 	nmaps = 1;
 	error = xfs_bmapi_read(ip, del.br_startoff, del.br_blockcount, &data,
 			&nmaps, 0);
 	if (error)
-		goto out_cancel;
+		return error;
 
 	/* We can only remap the smaller of the two extent sizes. */
 	data.br_blockcount = min(data.br_blockcount, del.br_blockcount);
@@ -882,7 +867,7 @@ xfs_reflink_end_cow_extent(
 		error = xfs_bunmapi(NULL, ip, data.br_startoff,
 				data.br_blockcount, 0, 1, &done);
 		if (error)
-			goto out_cancel;
+			return error;
 		ASSERT(done);
 	}
 
@@ -899,17 +884,49 @@ xfs_reflink_end_cow_extent(
 	/* Remove the mapping from the CoW fork. */
 	xfs_bmap_del_extent_cow(ip, &icur, &got, &del);
 
-	error = xfs_trans_commit(tp);
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
-	if (error)
-		return error;
-
 	/* Update the caller about how much progress we made. */
 	*offset_fsb = del.br_startoff + del.br_blockcount;
+	*commit = true;
 	return 0;
+}
 
-out_cancel:
-	xfs_trans_cancel(tp);
+
+/*
+ * Remap part of the CoW fork into the data fork.
+ *
+ * We aim to remap the range starting at @offset_fsb and ending at @end_fsb
+ * into the data fork; this function will remap what it can (at the end of the
+ * range) and update @end_fsb appropriately.  Each remap gets its own
+ * transaction because we can end up merging and splitting bmbt blocks for
+ * every remap operation and we'd like to keep the block reservation
+ * requirements as low as possible.
+ */
+STATIC int
+xfs_reflink_end_cow_extent(
+	struct xfs_inode	*ip,
+	xfs_fileoff_t		*offset_fsb,
+	xfs_fileoff_t		end_fsb)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_trans	*tp;
+	unsigned int		resblks;
+	int			error;
+	bool			commit = false;
+
+	resblks = XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK);
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
+			XFS_TRANS_RESERVE, &tp);
+	if (error)
+		return error;
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+	xfs_trans_ijoin(tp, ip, 0);
+
+	error = xfs_reflink_end_cow_extent_locked(ip, offset_fsb,
+					end_fsb, tp, &commit);
+	if (commit)
+		error = xfs_trans_commit(tp);
+	else
+		xfs_trans_cancel(tp);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	return error;
 }
-- 
2.31.1


