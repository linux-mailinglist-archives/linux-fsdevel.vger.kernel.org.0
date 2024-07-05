Return-Path: <linux-fsdevel+bounces-23222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7085E928C49
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 18:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C391F22A61
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 16:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A6F1741D6;
	Fri,  5 Jul 2024 16:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K0IvMzvA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qedRWy5k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319CB17166B;
	Fri,  5 Jul 2024 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720196738; cv=fail; b=JF7xwalB9byHri4E1D86xlfBT8xOG6h980c/oWufKPOOfKhSO4ibTxN51IeH2JhgPGJhGhwvWCcRxkpJflWzU59+5e42wXNqBsqVFnUjhP2pOAJ0cRTHtn8W2X8OV6KO8cXPI3YaLiXWGOwVtAfryEwZKgVq403OBkGKxdmU5Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720196738; c=relaxed/simple;
	bh=qWZCtrfsE8kzzxmRxl96061I3Lw1vNw4TB2JFdVqduk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vh8AMIRZlIrzgfC3xfA+77/eEUItsbwPRAIIAqKMWSGwrTkoRVtvcivkWZsBRQI8ybnS4PvsCtZfAc71bs3uLOyxb9HiZvf7vMT5HPmHybnF8uVnYdl48Nk+6W6x2PLUki0YOSihrt9deodLRGNWm28PKnSkTaeANmztGS5cgMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K0IvMzvA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qedRWy5k; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GMepH013563;
	Fri, 5 Jul 2024 16:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=C/byW9R+e2foO5aTnvekCrGcAtn5e0FEqJ3geoLZPbQ=; b=
	K0IvMzvASOrmafHJlTXY2z6CnR5/PZWq2O1ZXX/gW+RCJnmeqQS5c+BsgtzWN1St
	WT5QCxICCOJAr0x/PpmGDG4ImmpEcmF7fq3Ob6uG8hZzRaulCxBwFlLeQZAYno4h
	WWVCsoIYsdGTphJk0+DDCFS7iAPsYoXW79rbb0/jJTgVVuzCx9ETz2NmLHLXeS7h
	SM+vlLO7HW1Fqpw4JogGWfyX8L42gqTfVFUHJO3+hA8D3/kscIvDHfPDv6XGkkV0
	MY2uPT4whvicwzCGR3x16RIGCPm8OuiOMmLpYyaBmWWY22vzxxOS/sCFhqzFrRB5
	nwP0QgSRDBtyEqX3XMn4Rg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40296b4969-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:25:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465Ef4V2023444;
	Fri, 5 Jul 2024 16:25:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n12gg44-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:25:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0yasN6oN+2/sKs0GTNvwlAJzzqYfUuA541WmFSqkhFZHbGmBtTrejH+j2J1uSb/KwRZfzPnTsoBoQfAsmkyh4nWwo666qy9m5DQDobiexb65UlgrPhXQ5VwOHybg1wJTXDar9Jc0Lt+Yi/d7+c2Y0khRU7vzPijcMK/Lb+quWG2c3+sOXEaknA1VJyLghuyYa679pCasC4pCKaIERJdJKUvimzHSUIVdvEY7BFmIuM8CpQ0KudsAVuo90pfzqev8+lKzaFo4T1GIBLFIXUtoiNzGVbiB0wWmQBbs/Oofvfn/rMZjm3iV/fkCn4J7bKNWgUkD8yeI58Zpa0psMY+rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/byW9R+e2foO5aTnvekCrGcAtn5e0FEqJ3geoLZPbQ=;
 b=VdGfvUS10EgJ8iEVf+ncXhmOB10qx/d56SfKJ+NnRkkSMGN0OVQE+O4r6Q+FVDQnl+38VirYZEr9HRK5/V41oX8LxYmm4SMCGw5L3FWV16mtShThSZj/xqsq9pHdmLmdWBA7fNseNnb9tn2+iEu9UMaON4QCY46/t2Y1T/5IVWsiGD3wUlMku1Xt1SwDE2HFGFSfgJoC+SzdbJIiGGVhn8IbPiboz0IiKr6FHEQ2NPr77XM1ANBOty1jZuKyaLSrdvBB7yJOmpIvU0BsIzpURdEQKsuG3Jtd8J5zEfa0QcWc5hCnOA1xP9DQkxuD8U8Q516QlfDHH6OrtxqqxFIl8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/byW9R+e2foO5aTnvekCrGcAtn5e0FEqJ3geoLZPbQ=;
 b=qedRWy5kZmforIxdu9FXNpsDmPxIAZJA7w5KNtq5ycZw0dXA32ZpLawl+yCn1CakcZbOGhnheYLNY09egaw0EMMy+nv7+amRZXv0ju+NN5iiy5NCTYTDYoqiSZ/5volZ8uX1t6/tnLdlwO8Q/4EYh6outnSUWAa6MoIYAlKT0zs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV3PR10MB8201.namprd10.prod.outlook.com (2603:10b6:408:281::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 16:25:23 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 16:25:23 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 11/13] xfs: Only free full extents for forcealign
Date: Fri,  5 Jul 2024 16:24:48 +0000
Message-Id: <20240705162450.3481169-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240705162450.3481169-1-john.g.garry@oracle.com>
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0057.namprd16.prod.outlook.com
 (2603:10b6:208:234::26) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV3PR10MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 67a1b834-9013-4505-ae20-08dc9d0f11d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gNhyfolMJVkwGi3InOD7gJthwElgNOwasFNnUjK+NPyvcrbnBYUh+3PiihPy?=
 =?us-ascii?Q?n+0GwKQOCIwWJAOIVbMC3OdS+VTayluztBvwjG64Pwz1FA/Bc/jzTAkr8Wz6?=
 =?us-ascii?Q?O+GeoI9nyrh3suGU7lMdYEI1r/3wyrGhp8XISOWZaik6AU1XQLLzpR62p/13?=
 =?us-ascii?Q?+ObftSigtithQlkFcK3J0ZI1IViTs19P2MhV9on6Ym/ldERQxa4873IpUuSM?=
 =?us-ascii?Q?rKYyVv3XMPaeYD98xDG0Qh+4Zlr2UHFdpn17BcrkCG1nBudtVuVjG5ckHnKv?=
 =?us-ascii?Q?2YYrXLnvHvnGDDJIBGI4Ds3Y+Wqh7tCfAdpS6SZZHwwqT/sNGkw5AsLniXMu?=
 =?us-ascii?Q?OByUA9ybVWxksRzv9t++7TtQUzEqhAVndIAiL9zGd2+31dHJJ6cBOC1wNuKf?=
 =?us-ascii?Q?EOyCG4lEGjAALVLo5hgW59m5laboaDSrDX0xVUd7mTSAfswXSNel9KItc8ik?=
 =?us-ascii?Q?E9WKahw7rBPMW4Y14OIcFM451LLyzqV93HQ+rtDyl8o1g6p7ZLivwUC7a/3p?=
 =?us-ascii?Q?pgbvrOLGRDWGbx+sKPfgTZnjT6N8tdirnVbjUWCKrNuXVsKdjpaiLb3dIkNC?=
 =?us-ascii?Q?cfOCD8XM8cfoeFM6nDwEHHF4uL/Nl/IZZ9Xuzvcz/Ze1Jal2wJFgmHzFDH1A?=
 =?us-ascii?Q?Ha2KJ2dK834KoGS9/n4pZIv/FDiCh6InewZ0E8C8XaeRgD8oG5eKhXCfvDkE?=
 =?us-ascii?Q?qm8Imz2mmTnvtmPWXvMZk+gJs2/2pHQ7L6bOCrgFPKgKAP3JamxZpPy+Ybl5?=
 =?us-ascii?Q?Y/fJJnGnNQHhLNQHISFGGUxX7WZFVBvWrkfg7i9KnrrZYfytHKUkNbW+ap2e?=
 =?us-ascii?Q?XsfjpjnaUHZIEikHiISpo8JwMq39UZ+OlFolDphnp8DBuOp98I1b3FJJ96AR?=
 =?us-ascii?Q?B0nEUZuxc4WNgljafaLnwgPgMuCRbDTbYr1bSED4npdIKJmji51ihuB7Ik2A?=
 =?us-ascii?Q?ccpvNiYMOE/5MQ6QLp9vmPSUoJ9eEiIN4QCV/d3L17Ww+4paeP1OAHJ9HIL1?=
 =?us-ascii?Q?/nPO60R/jFVZJ5tyyki+2ytJ2FPVWe6TX8bDm3Zw4VbFTzUlmfW29bhRUUKh?=
 =?us-ascii?Q?EYVRtHuqqHIfDhQ1LEwkzJASnmlDpSgA7yL5ooEEeyCkDNtoDMbTWVEC1f5C?=
 =?us-ascii?Q?JVs2cHN/BXiHyFXcBnYV94dIkHNZ+324jsZ6GHppDTCzFdr67teTt9/npLLo?=
 =?us-ascii?Q?Z51D3WVoS05dmJOtfL9iMlsyDYB+RyPRTUm4NTjdaVlOadekWmCV8N1currd?=
 =?us-ascii?Q?5ZC8p3m8ozpmL469XuV+0nQl+smU6F4d0Vxo1UjzHgCfw0Cv0V2ec8lpcGfX?=
 =?us-ascii?Q?riil/ietN0s/CgwcBZgg1W+lY11kXN8YdQqalPo2M0MjQQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2TiCxgiYctZL06/maOb8LX9pCY/N9z2N+wqXb/01FFYChOQD9KmSr8IMI2A3?=
 =?us-ascii?Q?qd6BRbp8HH8N6HDrVi/00souNylLXTqgk0qMCSlO+mhdD/upSaX8SFJieaid?=
 =?us-ascii?Q?hBeThXuTFkG+rCQaxVddKsbRVcA4aVQ9VKcNXrO7EtTVBICOydT13Tw1GHrB?=
 =?us-ascii?Q?nLYhPzdH9siL7mdX5RJMnFSdVNaa/hUwkHtkPtAAE3NMJNaocHjqtWHEJTRe?=
 =?us-ascii?Q?40bnDW+K2Asm8T9qnr88JdT8TXrWusDNSckjskXEKez3vf2oq3D7GJydGiK4?=
 =?us-ascii?Q?G/mzFP3o44xzHe8wqEsUhUysUeHHj5+LjgiMjDFTk8wwEh8GBIGDFGUf2ETH?=
 =?us-ascii?Q?9ESvvVduplTgFiZ+4BRqtrQGqK1J42ESjjSZ9cXSo4RI8m85s6taro//0Akl?=
 =?us-ascii?Q?BeM9hj1GWRTtALAfkyvYiK+p6QluZ2US1+X1ZMxHHTTQXs8tYv0ztPAfPAkc?=
 =?us-ascii?Q?X/iKHdw+vm+q8EpoWuiBGqSW3/+7Pq2owftIrv0q03xoC8liDZvO1WhrcdVY?=
 =?us-ascii?Q?ZprHNu5BPMAnRqSh4yugoQeSdrE1cpxC6Slrg7rTepAgXY9LbqbafUTP7KOG?=
 =?us-ascii?Q?gz5jiI0/8DHnFn/srjlRJ8BNOXuW+OPtWg6hocuj6f1INdCP3foiUy5diT2U?=
 =?us-ascii?Q?cABrVO1to8vb4IbHgJWkSg5++ZyKIvddX8zFMldAbaW9u48A4Y03be0VDN49?=
 =?us-ascii?Q?xCXQJKNESUfWMeRyhPQ69BZDMMkIV3cszSoLbZFltJSiwaXjRIXYOtSURkeW?=
 =?us-ascii?Q?Gp6d2PnghMmBrTBDxvsMJcD5IOARKCnVZcHVzmF5ewOYmr9TVYWTn0CU/h0O?=
 =?us-ascii?Q?rhE+OkQCJBlrsN2vLIUmBsBDFi/phfrUT8vicT/hxhXx3ieicu8sCkqsY8sE?=
 =?us-ascii?Q?YWyp5atiSOgv1+EJwPHNUQrx+VZS9sywnw2oxFX19BmBgVd+gvArEBQOXkql?=
 =?us-ascii?Q?3OG7Nmw0YFnTzHOFO0LqwLvzfbEXQ6xN8UwTMHiw09ONJMotlX8Y4zUkmHxN?=
 =?us-ascii?Q?LLcSWMuElGlwtATEMUIM8IP3WEeApdgvotkxBGriCTZXuvxRjtIctI9+9Sy7?=
 =?us-ascii?Q?7isL6ZJngWq7BqoOtlug18ujpUxPNKL4FBuv1NASzy1+HjPUk08RuTUzGwn4?=
 =?us-ascii?Q?i1IvLiy1ucDghrGsLEtz9uqYQwPOgXh/OOFMQYy0DeF+IZsCpdwQQM6ldQsW?=
 =?us-ascii?Q?u9JseQcYIua3Ui5VKNYeb88d/nCFxpk4++/3hx1wZOTi/cqOl/ZgB/L4FFhI?=
 =?us-ascii?Q?hsKQ5yyiW0TZZgQ1V6ufx3Byv8+ufB17SudZVA/9IJXtrS2HWT3w8P8qmKdb?=
 =?us-ascii?Q?WAMNuOFmRk3RVAk7Iwpt2TBM52xhD4orY5/6NpVJf5uyHcLSCCRMYn7lH6Cz?=
 =?us-ascii?Q?ICr1zBXu2tGXBVt04BmryDCqlIm0uGvg6L0IFU5mvvknlR1MdGsG2hrwq/Tb?=
 =?us-ascii?Q?Gd1p6SbWBNCTm79xwycog2MfuSPe5IXWLLWyMzos1eNnBRHO/sXgg+cRTC1n?=
 =?us-ascii?Q?0D8/aZq8oWGVJP8Dj3zKRTaKGW0E+6aH1jZaVOwj4/99UMAkOGaa7P5f15tb?=
 =?us-ascii?Q?xFQScqjav8EjN4WMqCb1sZH0XcvM8JdQO7K2/edbTMkjvr8URV321JkXAzXn?=
 =?us-ascii?Q?dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GwT7b4GGuEJyLkYWcqiNnV9WGTH6piYwz8sRfZsQV3PvOvd6bn7W1L0WCjSFo11YOyLIxTmB2XHmT/0TyoILc6VQLhzOmuy/Wju84QxdYiYPpikYVEO0QCv6CAV+PhiVwgCxFX0cHiYd5GJkonGBZeDbxKaef/rMvacefh9L357fZKBOonJFbocx2VLfZpZ2cnr0ov2R69lf6YEo+ZDgYEI3L9+ZDWc6vLYUWrKyhvFQWhymeqBDLvduHSIZ6kdrFELyFE/uYTEeRQ3eHEI98eYyNN+jZFnEElbk/R4Gst2gLX14BQSl5WlTL+JK6YgQPp4QNv+2GM/gXaRvO6HomFrB+4hvyUF5Dyo49ds+jGGUaUWO9JVD0x0brVW5Jtf5iXOXi1Pc3Xc8rGnw8Hh4b1nSO+bR5F0iIGspwmIPqAwA/NW4Uq+FHslWqkiW3DLiuo0mGs1LkvlzzbMS/+D6Q7/VhrUZP8xilkZS7xTKzedhF+V/hcvG/bLLiCarS+I3XmtzjG92Vq5/MGq6Cf0zdVhidgPXksQy/0Im9jt37Ot3JnIbp3YCbrET9jC/ZCeA3mRRPPD3+ZXFF+F3B9KnmQw19G0HKcSVFB9Im171OLA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a1b834-9013-4505-ae20-08dc9d0f11d9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 16:25:23.1073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RkSgmu882b0OrL7zmRhb8iC5lP/7aFTH9S1AioiHcpDUZRLkgl/u2Vos83QzxIARisBZBkt6cbd7Hr2/i4a6JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_12,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050119
X-Proofpoint-GUID: qqlunrQaOIGuNhhaiyVhbLZqbNVt0MwI
X-Proofpoint-ORIG-GUID: qqlunrQaOIGuNhhaiyVhbLZqbNVt0MwI

Like we already do for rtvol, only free full extents for forcealign in
xfs_free_file_space().

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_bmap_util.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index b9f8093ae78c..daef6085208d 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -856,8 +856,11 @@ xfs_free_file_space(
 	startoffset_fsb = XFS_B_TO_FSB(mp, offset);
 	endoffset_fsb = XFS_B_TO_FSBT(mp, offset + len);
 
-	/* We can only free complete realtime extents. */
-	if (xfs_inode_has_bigrtalloc(ip)) {
+	/* Free only complete extents. */
+	if (xfs_inode_has_forcealign(ip)) {
+		startoffset_fsb = roundup_64(startoffset_fsb, ip->i_extsize);
+		endoffset_fsb = rounddown_64(endoffset_fsb, ip->i_extsize);
+	} else if (xfs_inode_has_bigrtalloc(ip)) {
 		startoffset_fsb = xfs_rtb_roundup_rtx(mp, startoffset_fsb);
 		endoffset_fsb = xfs_rtb_rounddown_rtx(mp, endoffset_fsb);
 	}
-- 
2.31.1


