Return-Path: <linux-fsdevel+bounces-20414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2168D310A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 10:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B331F27BD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 08:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964CA17DE27;
	Wed, 29 May 2024 08:18:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCB0179957;
	Wed, 29 May 2024 08:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716970694; cv=fail; b=OUnpYlwgeE8LhvaQeNrX/XPjV25zed+z/DDADUUl5J2Px0i1YIMsPMdKL++cWcj7ckzCnFskA2uXvEZcih1C7bVxxWuw+mpIFFfF+8UHn/8AVMrqLIIBFipiifDCwCxl7LTC8HudrZM829LDYGc6g3S2X8AeZ5lWMa9Fmnc8HWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716970694; c=relaxed/simple;
	bh=6vk/GWQ8LsjKaJM+ShPsWl9qXxCYAliTbF3kmJnnfCE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Acc4HN/a3S5gHjP4XMWPWk1uF+eMIH0CZaihifLRSpoX/g4QR8T051qsd0CFz607ZGZabkf+Aqfy6oOm1ZQgWJXUHze1zbI9z4YVOoicAGxhFDztgBqJ2qNZOzUtxqj7LO2EvAG9M6FL8Q/6JlNcPbx1HhDE+0surIhtUj/szuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44T6II5x019463;
	Wed, 29 May 2024 08:17:55 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:message-?=
 =?UTF-8?Q?id:mime-version:subject:to;_s=3Dcorp-2023-11-20;_bh=3DYM1BX7K1+?=
 =?UTF-8?Q?PsYEEPjAFDbAm+LTBv+i4h+u5vU3Jip4jQ=3D;_b=3DUPKvsJoJ4WF7NJoXyWoh?=
 =?UTF-8?Q?nP9jpw6uwN7vysrfDTmLGzWdiE+Pr6ywxn9hzykDSF4UAudv_RCofGpuoVTQaSi?=
 =?UTF-8?Q?BP6gB2JAI5i9JUrtIrU4lZIqM+xnysK8f9ESvAg70uy91lic45TsGt_NGbYVcKb?=
 =?UTF-8?Q?sasIv0FkkJ1ZuYrxfWwVUbFdby1zQBfayZHiYfGsFmgeTE2k+pdwmVJUsrPs_PU?=
 =?UTF-8?Q?oaZKd6gT8VIOt435j8JRFFICCiHV7tbNQkC0FjGjqEok/SCJXwPq73FEaNflf/x?=
 =?UTF-8?Q?Q/X_xSENveQbk+wssyEN6CYXEzCkxjdxSyFFex1wvtGApbnb6M0rR8jy+1d1r9n?=
 =?UTF-8?Q?5/rrH2dbi_Bg=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g464x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 May 2024 08:17:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44T7HYXN024004;
	Wed, 29 May 2024 08:17:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc52c6rqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 May 2024 08:17:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpSKHZ9VUjFLIUjVJQhe0VTAWfVe9zmDXd/lDtvlEm+rVdamCF0DRnshfxVoxdDRCi4WpWRK1+M78ObLB7v+iUVi+ltHbnVeMBiP5/feYsMpUNXqW/yuKckJE3mQjR/kIMF3VMdKMicqOgQhpCTAXNGgPwMYOPOeRnVVa3tNfhgvAZ2hR9YSjEN53y2s+7oBBm7MLYD5jFQ0621QvWQtk4HgWtyhsExgpY+s/XpVL0LtrpQnq6naGTtHFy/1E2sb7SaZbRLcRuVyKJ/vfIAFTegXlLDewuQI74jdd5Ce4Do0RNFjM3W8V7fpfylJb6lbchNkp0PzTwb2rG4dQHRmMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YM1BX7K1+PsYEEPjAFDbAm+LTBv+i4h+u5vU3Jip4jQ=;
 b=jMkuWutrjkflZksrEMpb2MCovhstx2ktB6lIngKSX5U+Lcir5B3CWlRe6Avo2fppAO0V91Bn7ppf82zxf5lYenucC93uWlNZXIMZ2qCboyxweJQwO0PhZBrrjX+63MHIHg3jc41VEtLHMQ5lbDx/2lEFu82MkaOZUnYfV4mJ8ZH1ReG9ws66NA0F2mbAHQ6u9f7WGKdwTpJKaOq4WaZmPXSVeGMP1acVr+4uipQYVu9bnA4riB2RRA6lgE0MocMD+VT9ZGWm8hFCUonotkQPa+MuTYpdkWmsiVtWHjrGc8qz19qBhx8ZgYybpPvPVwoNmqsUomj0Jwf30lGMvKFR9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YM1BX7K1+PsYEEPjAFDbAm+LTBv+i4h+u5vU3Jip4jQ=;
 b=rpNF374VFQDefsgc+QZdyx+GyUqvGVxcnIC5KUoz7+LVQoM1r9WmRW0io2od3CJlP7ut6ep4yLdiB1mXbtTnaPWelCTVVwS+dMP8TNM3zZre3Q8FdAZi/3+3qRghNGkrzVgXE1fwfpfjwdFrxVnlv6WttuWZelN8TXL534/Hn3I=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5815.namprd10.prod.outlook.com (2603:10b6:510:126::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 08:17:50 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 08:17:49 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz
Cc: kent.overstreet@linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, adilger@dilger.ca, ebiggers@kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH] statx: Update offset commentary for struct statx
Date: Wed, 29 May 2024 08:17:25 +0000
Message-Id: <20240529081725.3769290-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0102.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: d14a95e2-5845-42e7-64fe-08dc7fb7d454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?vxmvsxXlcxufKrwWmDv6sV2D2ZvL9usFpk+x/4w5qWMtebMxWR7NQUGorprf?=
 =?us-ascii?Q?UBT1M7VAFgeDBru7gQdn0P3hH6jDVvMFNXkYryPvsRyH+XtTfW2dtI8FRq2T?=
 =?us-ascii?Q?GqODfp7mAdfRReN7eNCRn2e9H98bjH6cDLT0gzcjKLFupwZt5xoTp7X6XXAD?=
 =?us-ascii?Q?IpDTTYozlJt3XOTdnpUPL8TywSWl7NnDHTO+mYG0deWdcfIHrMuBWPfF9sKz?=
 =?us-ascii?Q?NTkfHQ8jQbf7b7YCVIV9mS1VsY+ww4ZYi0+2YpFhIPImBcMM/+WU4P2h91Vm?=
 =?us-ascii?Q?aO8cwzO/1bn1Rkvv5wsJiZMHlk7N+ypMHqmbMuogq+G148/piS/KxgZgJbLV?=
 =?us-ascii?Q?K1nDAxB44rn9WGhLg4JN2Yu0WmDYGvqTP/L4pK43BC/7m/rhS1EiDqWtHTvv?=
 =?us-ascii?Q?GsocKA5PBD4Bh0D55zBkUs5dFqxbvKEqInqjkf9BR3XwUeCOGNUmjs1zQQkY?=
 =?us-ascii?Q?FiBzhhKwO+kV2TWd7qtFMOZFm8IytE6PdreFvcaplcfn0gGhSBahIFq2Mk6F?=
 =?us-ascii?Q?HrH4kwzQK56TW1tZ8xekKOHlU/Bmw/dnBdU1ZiqqKx6ygtNi2r+8mX5MTq80?=
 =?us-ascii?Q?Z8y8uibDRbBBjA6vOENos4HQSKlW6lQRVZ4F8ifq1RmSliyfWVHcmshTQjx8?=
 =?us-ascii?Q?Y6ZT9PC4e7O7UZyEP2+Y3qyds07An1jh+Btyd87qkR5Wir/RNaI21ZJ9FtLs?=
 =?us-ascii?Q?AYcQ7cZpNZB76MryRei7eD4M+4QGVBfCk8+ZaLNC9mmd2CRCf18mh4mUZ3FJ?=
 =?us-ascii?Q?MhbRA/V+mZsfakwAuVDUeugxEGkPbExndUZxlUnoAJe6BbgNhYEQODyDOxaV?=
 =?us-ascii?Q?Tc93FEB3N2U7cLv4Ds+OdzPHIsUQm3/ACymfMYa3oOaZHW3oA3wvy8c8NsRC?=
 =?us-ascii?Q?P0uNQjCYAmN6nykgIgAO4RUbMYqHBpyAZ7TDiR+s4R6pFSN9fv5x359DVitW?=
 =?us-ascii?Q?VjaXKzH6eR7IVqky2kfidc9yvJuJnjjSxiKVaclw6Vy9096tKPBuzaum/BzS?=
 =?us-ascii?Q?AKh/VO2eHD4yRYQO7Lx4uGWtovlJQuxERDzDEX5pj8KbGC4jdUSI7VLc2Fzu?=
 =?us-ascii?Q?Vq9WqnC69Lg0mjqdLZ/v7NUvUuw8+1Jt4WvKaWYi+O2WGjmM04jgZ231OArD?=
 =?us-ascii?Q?pNpzvh1PaDOoyixLzSw18TR/BLV5dGODZpHQ8vDuCJfVqpRjWWgnyXbt/EJM?=
 =?us-ascii?Q?ZbnjGjGQTGlcZEY2+p4VYC2YDbZciAvyspl2DI08RnmCfHAUJpNH1Z0g1Jfh?=
 =?us-ascii?Q?qRo48OE83UDlekWeqwDsea9DD+5WCr6vOpc9SICrWg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IitaEeW6fjplh9UzwTbcwSPwYujSL9KIldMriH9uAWdR+oSdnWNH8LgAJrOS?=
 =?us-ascii?Q?C7IBZ+QmJx3N9Mf/pt04b2d7/Z501x5xUpDrhpHBZh6xeqXLGBinKsDr0wTw?=
 =?us-ascii?Q?o8RjgORys5Q184fepRH86QE6weHBzWsIBwp9p85rcDZ+Gvphyk5yuYYPzzS8?=
 =?us-ascii?Q?P9QQ1zkiVgz6YCTAma+RAq6MzcGWpc7JMUxVLL6vUiqe6tBwSqQhT01eGWz/?=
 =?us-ascii?Q?FThRY2WWhy2tVdotXV1XgLtWyg0zb4fc6YhoX6ChsfSqhgJQ5lJ0gUjfLAep?=
 =?us-ascii?Q?RYDnnJ0Bn5X0j+WIM97uc/JYoP7Q/0PY8Vx6+bGyLKpIU8XcuF20EZgwsFOZ?=
 =?us-ascii?Q?3t5mkqRjnIad1PfPSuvIRBhapqTnl6MSuhR5n+BWyIsUWUHGQLRfAxAPwLSb?=
 =?us-ascii?Q?I1t7tkf4ZZ7PQrCsg8aCDpDy8oMWVJUzy4RKCLSy9PcnshzOjyLeWBr+eOuD?=
 =?us-ascii?Q?7bBQ+V1CwxkVaZ+Jaz+9ER1HpEgE7qOzB+7b9cd7tGBi05DEfH3ciGQZ8IqA?=
 =?us-ascii?Q?kvBr2no4RtQLghXXiUSRn4PwoBXMbxlMgcc9GGL/43fH7Dr3iHqxtK3N1sY6?=
 =?us-ascii?Q?nzQ5QhjlP+5WoiYYPf1wEm6eeIWU2gyB/VtIp1xx3BG0d7NY0hdI8dxtQuvC?=
 =?us-ascii?Q?nYJ5poR/arFsRdg6zwBcPBQ5libE6qSGD9cohKlPdF0aYcSX4uUt4ki49gUo?=
 =?us-ascii?Q?kZ/v/sTTSapJiS2BEKXz+Jg6vTS7rvzPppNsf+ZQZFOLJQ/GCqKAmiBthppf?=
 =?us-ascii?Q?etzXqlmN9qfWXVKfJir0+3jhoVAkSO9FY2zcfdX91GIKwCjPpyb3vxY6XimG?=
 =?us-ascii?Q?cFdOqaVUMCvuJ5tvjF8526inlxrxBHVHc2wq+xggvTRe8KdJmG7tqkZ4muxX?=
 =?us-ascii?Q?z6Gr8DmbkPSa70MtYJ3Or8a9qucTV82A7KFLXnvdIR6tWUErQ4hL+JY2jlZ4?=
 =?us-ascii?Q?T9ppjSH/llBZBojDLoAs4X8f3GDVDsln9scYBSJGNrzlJQy4jwtKROnIlAFF?=
 =?us-ascii?Q?Mr7AkW48vBs7VFlXXTQWUf99zSK+T5W4ntf5LuU4Y+uESdf7IvkNaKk3GcSf?=
 =?us-ascii?Q?f+wuwCAJ2yo0LXcUpyaAaSsxyqnRlCbSAQkw7hR5Jt/DScirHwasm93wauyB?=
 =?us-ascii?Q?mH1Us4LRyGh4jyX02h6ZNYXiMUMxulBJAfANsX69Hkmn0gPXisHqjuRvOPNj?=
 =?us-ascii?Q?HcxU0Hxx/7VxKYQgjgBu/BnHNigXu3L7OofjpCtN5mT9bG6g4Vwqd6OrWJmE?=
 =?us-ascii?Q?rZyyhkX3Y7WkN1BUXKeljKLube/Qoq6fyGTLonU26Odoue2zS3qcYtvH/Kxv?=
 =?us-ascii?Q?rJn+xVMFGK//bRJJW0y0C6cFjP+VCWrROYvkpAO3QrKbBpFOdzA2CuYYS2MN?=
 =?us-ascii?Q?AIngC8iQ51xpn08BoOXyOdH48FeVWSvo30s1RaLzhRT/t9XHu57+CYdzEogo?=
 =?us-ascii?Q?o8yW5CUPqdmzjK+HURfYL9+XYw1uaAqfUnKNPd1G2GNbxnYqTYH3JtJ9tbLI?=
 =?us-ascii?Q?VzSFiJudFsMZOjBScVTwXXMhQ1tf17PeUA+DWrXrkRlJvEX5hRL/8FjDYVuQ?=
 =?us-ascii?Q?f3zXeG568AqBSHpRlYk6PRsm/1vjj9/rcC0krrYcH6xm81KPg3LFtDGtMGqJ?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iVUzNRfWqm8fGlr6zKNp9U0Y02jQ7bRyofAOFCMdlxvIRhPuDWPVlVM6vJ1D+LeBwut2j9Ai54+cOyt9dh5gLrEHF/23UzCEyCzUhiaELMf4dR/JckVT6Wn569J3ZWfZG0kS6x6IoD6iFNMZDiPs9TCKf+c7poeJinEoXxVuBz4C6J6Xod90ALxhclFGqIA5U42Kx6rzS1uj/PYzkZc79hrxdCJ8jt1Jl/WOONcm78E0Uo0zh0omxfKxp09FqJ9XKoj1wWXT+U+eUmRq28KrV3TOgqyTjoEnI9VJGOCeqDpyHIgIhLnzzSH3NZ3K+nXccUtg0NByyb86pHZOWaWKvGsTafvLKyaxdfgVPu1o99fo+l1tEWotRCL6svLO2zCUyWCyHu6Am0p1kPk5JKbDj89b7JWY7/GyZdXKWq4j++52kV2zx9P10dN5sa5Nd1VatCHEPOFsx1ijcEYrY2pe7ZAmWRSSMFPTmRDFsE2nwcdQmGSn7ISAa9I46BYvVuINsytuwO1At6SGQuZhgAJGKZnw8/tXDXRsfZU058F+GDJAdtPONX/8wh6Xb1KmQkPjP6YvXn5JCV6XPGqgO50wwOeYm0qz9F1IVmUsmCiCy4Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d14a95e2-5845-42e7-64fe-08dc7fb7d454
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 08:17:49.8605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UC+uTY/7Aqh59H+4iXBA5LgChyf+Xdt3o6iUIDREU3/xL3k6ggiBwazT8VCwySlTx7pPwvTz7CTYJ8Z8ccE+/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5815
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405290052
X-Proofpoint-GUID: i3VZD2tNWf67WMOP20hvoGxUhjalIsek
X-Proofpoint-ORIG-GUID: i3VZD2tNWf67WMOP20hvoGxUhjalIsek

In commit 2a82bb02941f ("statx: stx_subvol"), a new member was added to
struct statx, but the offset comment was not correct. Update it.

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 67626d535316..95770941ee2c 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -126,8 +126,8 @@ struct statx {
 	__u64	stx_mnt_id;
 	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
 	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
-	__u64	stx_subvol;	/* Subvolume identifier */
 	/* 0xa0 */
+	__u64	stx_subvol;	/* Subvolume identifier */
 	__u64	__spare3[11];	/* Spare space for future expansion */
 	/* 0x100 */
 };
-- 
2.31.1


