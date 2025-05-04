Return-Path: <linux-fsdevel+bounces-47991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D232BAA84FF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 11:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99267178733
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 09:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85FC19FA93;
	Sun,  4 May 2025 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OVSKCcHI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DyKWnE4B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A491862;
	Sun,  4 May 2025 09:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746349217; cv=fail; b=pz5QdSGQ0CFX8H+IA4OryDqO9zKSPtdsiy0WZzx8G2TMPJyJy+JP7s8m7EOU0avDmGlwjGdb2ZaD5li7mZHDVvw0jXBG8xAjGYdz/fbJqVASxlfEAFe9BfODXjXDMOiryDGdExiu0GSxbTYpEfh0Oft7vw+bG68ZSSmj2RMgqWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746349217; c=relaxed/simple;
	bh=xrWHo2sAodMThn6lg/+SsuaIsBN+sm1rVphqyMevH20=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OPmqrr0uYZ+Y+FPg8MakET7PUPX3MeoDMy5s+i3jZpTxomehe1R84TKN3Iwf+LUQ0arGhwQYrhhUt1dPLrIlS+0ZVYi8WRD0AnrPHBV3tsTZ8J9oDCpZ8juHX+/E2qmdQsHYMPg1mpnjQoP1E6XQY8PTapcHMgLEHtanNS3tI9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OVSKCcHI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DyKWnE4B; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5448qkfS010302;
	Sun, 4 May 2025 09:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=2eq4+usGrS9AET4m
	6jw0tFT0zDQSTDhGOFynOFz3hgA=; b=OVSKCcHI5O0qte0Glx95gTZFaUDVcpI3
	JopkzjVMhaETTL8Q6tBAo7Z+KK0Gau88aDp/B2JR2CPlMUftqwNk1YEnsY6RQEKB
	qL+Hdi4kvUCIl1hwYRVcam/ybuL3hJcxIjEL+vYVclrhYEJtUejfnBYhYNqzminp
	SfLemUiAtJDwwopNpJSPbp305FWeM6pcM3w2aUy9Rq0rO0hLLvJT9C5/7tTe4Wzq
	xOl8D5sDVcxSp3+ob33FPGfkCZw9ZvnfaRxq/xAloKnah4hZgodWtTnQcDj1yhy4
	CZqxcYlceGYjd9iMiRrNT7fLirudZBxAQu1Wn1AfSOPPrE03XB5Jtg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46e53p804a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5443UDQn036077;
	Sun, 4 May 2025 08:59:59 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012052.outbound.protection.outlook.com [40.93.20.52])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k7ghc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 08:59:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rn2jIiO6W3/FploIaWp8hjI2S6jczUUYEpUDq9TAFeLzXIdmY8Y/qdRLdS4R0HcyE4tcSYuGKbE4c9lvtZc1yrDBtgZoaCY5buBo2zBdclnq8Rx9wbWLHcIQZ0e/pvfFovCiIpnS14Eijs02Vec124aimARuwGPoRcgq4vX3GHGKS0ZqEdoNV6mZIy6VGKJabg8XkwZvNy6O/AVxyKmQY42VM9MdJc9Fko0w6mlmjnA0ZpK1T/Ve5xzfOqy+9qeR06g3SmwwoOVOCFYv2AvXC9vBj/oSPVMRUQ2HRLUjzl0gs0VC7QxgycFtcpW+XPh1on7YycvPc5R6/tgwDPoQiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eq4+usGrS9AET4m6jw0tFT0zDQSTDhGOFynOFz3hgA=;
 b=UM7X4tmnGxLeJ56yXDmlz4ZyGvuGOSfNLogpGtJdfTvnrdvhK6sX2LY4b2s8PHTqQXc5TrmweBhkQovpSsMlhftDZb0eN1ZI5VJSeB+5RYBsmWNUU7n/pqvN81lXi7EaqMiM3vzZTZdlsw0bY+RB8GWs5BaiyHHlMlBgeqv2p5D4UeZ2u4UdlwrPY/2IIiKjjUxpOUZMIg/UDKcpnZbStzfZ82VJBbtdfQREr0kFW4gso0tPyVrOimSxsYWhJO9fIE2H7cFjMVtWG70/YcKyeA1Zj1UI+1CzclgYex0y5ksOmlFLf9f5slrjuYvz04+a+btk5QWowiIXN2Hyoab86g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eq4+usGrS9AET4m6jw0tFT0zDQSTDhGOFynOFz3hgA=;
 b=DyKWnE4BFURlv3DQgm2NegD0R2c2da406x5is8/98yAOVYkOOr4wz++1zu5ME4wk2tkaZwoiu2lM+idfM0TAFS033XnwpWZIsEjF7JC89XZUkBjoRkN4ZoOInMztCi8r4ME4fJNF+dH//T6JgDlJcZhCfecgBFWQYIk6DAtDN7o=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7178.namprd10.prod.outlook.com (2603:10b6:8:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Sun, 4 May
 2025 08:59:56 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Sun, 4 May 2025
 08:59:56 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v11 00/16] large atomic writes for xfs
Date: Sun,  4 May 2025 08:59:07 +0000
Message-Id: <20250504085923.1895402-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:208:236::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d3ab51-9209-41e7-71eb-08dd8aea0a54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?98LmQjx5C9pxiMhzwP66yvn4BHPBIcUvKc5Nsw0wHmbwcxNjD0MhqblungH/?=
 =?us-ascii?Q?ePJx6awmr2QvX1+Wi+xgTOi8u7C6YAeV6F2EdYbgF/pe5MUAkvrC/NUqhFHS?=
 =?us-ascii?Q?ibD8RfTJbmV6rfhesc8BUMcvyO1kBblsA8atSguV0mlmOk9Sf89JQRfl+9LC?=
 =?us-ascii?Q?YJq9ipS9htiyOpSQQKohYAOZxT5hiy4NnNALCYHCX7Cr3pp3ZQmlXDUPL90P?=
 =?us-ascii?Q?x5nSoIa7fb+N4t3TFxFKbrGEFxUZAlt5xvGJgHDAMvY3gBPV8Gzg4yaZasTL?=
 =?us-ascii?Q?tSateWalGnbdBYLm3/KSX6PuPouv7x6VFZhQ1uf8/qDxCtYCZ1ujPPn6fdYn?=
 =?us-ascii?Q?l3I2MYSdw/mMOq1q0amQu7bwuVqqqBZ0Yu5G+U2S78fYeQjJio84LcSxfFjq?=
 =?us-ascii?Q?YVorjb2N0kMMfWEiFYwbdNaZwj8YpEX0EyVQB0kXmpuk9zjCamr7HXwTOsJt?=
 =?us-ascii?Q?V1SqsJ38yzBYhJixUe9nPMGX5KyWYADHzkkHjwj7ILIo+rwuqoIXbgBImekN?=
 =?us-ascii?Q?4Fp5m1sidPq3hv7FQ3sIm/pANSaaEZW3Wkwum4SaY/dAP8u/9OOXoY+ub2GE?=
 =?us-ascii?Q?5WuQoTm/DiBz7wsFhW2LNOLZEe2IphAYpKUPzRuBM3w4o7kxyJCS5NmTw0Md?=
 =?us-ascii?Q?lvygf3N+MLxTHvlus4sBmzR/4rA+96TRhGJD3TZCqkYKG3jWllb1uNIiE7av?=
 =?us-ascii?Q?EizMi1lB+UaQ2Epwrp8f4pbpY0/EV1wMInqpQq9YX+dZ0g5L3MFaRWdOhtMK?=
 =?us-ascii?Q?iiE7DIgQZHdE4bkPAXvvJM/tasJU54PhsX0nQ20PVw4DMZVuK78auWPvWHKA?=
 =?us-ascii?Q?9YszzO3Cm18HV+4QAnKGAQFE6rxvorfC7dn5oGtQvb4IoIk6IOS6xNl4eDJU?=
 =?us-ascii?Q?z+itX5w0vMfAhkTl9lEwBkWWhdPgHXacAne+KIfhg7HBVXWnS8SdrgSeK7tf?=
 =?us-ascii?Q?HBY+VDSkbqHxNsUJAnt7/WcuRxh6WWbVe6pFw3D5ny09cg1ZaqNUQgFllpzv?=
 =?us-ascii?Q?RXpZkguwc73PDrBqmf1aaTSjlq3rujef6np6Oa1wNTVnKUDbXf5ASamol65u?=
 =?us-ascii?Q?NSD+uz7/XaqL1hBmanMqkqQOjqm4o/nJVr4tTS7xCrtz7oQghz29f6wEuOQ2?=
 =?us-ascii?Q?952bXJb5wX3rKBobu+T5n9Yuh+1N3qNbJIDVnBFM6RTgxFYMol9P3Je3Nes7?=
 =?us-ascii?Q?kE9HmDKtIXUVpQmtlf9o1Rw/BDWf/IPbCJyrNnmKXotHlVNuOR2PSkYqAKoH?=
 =?us-ascii?Q?K4+1mKdD4scqC7Sp7405+rEyeNiTrohwuzKR3/kNKJGClITlB+vu35cQsngI?=
 =?us-ascii?Q?YU+qR+/N0m2Wxj2SaGO6LFTX7oxtpey+ro/A94CTa3TikdkFMVNMd9UaZGgz?=
 =?us-ascii?Q?mrGmw/eNepdo501koRdms8NCh9dbFBqX86LzS7iCq3CEY3G4arwe7N5i1TDC?=
 =?us-ascii?Q?7xkeBLOv0iI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TA+90uAb0YawHtF3MJV6OHzuZr1lytX+pE/we0JT0GBujztPGblpd6VEFRuo?=
 =?us-ascii?Q?ADNqMDsiScTdAomIM518RGCL8P+R2BwOCAI5oIges6kqDbNaLhha9gUib7sH?=
 =?us-ascii?Q?c9cE922EnRQYo8v88Ikfd84zp8dFok7U9HvBCJDAMVlON43Ez97Sx3+5rSQf?=
 =?us-ascii?Q?ORcwNXr3ds+D2Uorm7NejN+mFcbzg2gaANph0S4dBZ/ZeAqgm0yBjIEOqr5O?=
 =?us-ascii?Q?XBNXVMDxZ31ZdEq3zc/fBBj4Ke8gOk6vvx6dMBMkA4AoezYjUHYPn/+qE/1b?=
 =?us-ascii?Q?Y6+muRMwdj/Y13/hn8KcwLA8bTnrpQCOgz7yh9gTCFefZVdjxWSH1hMYKc+F?=
 =?us-ascii?Q?JIJYNKj1e2KPlSRFk6Asj2+Gf8aXYfUd1TjIeoGL51YQ5cuhhCUuAk43sJcM?=
 =?us-ascii?Q?yFRFxBMEP5kyjWU2V1Sc4t+0g2RNTD5ZLq3oq6Cl+3fY8g4EXkPZOIeTktfx?=
 =?us-ascii?Q?gKjJvAD1J3N1jZ1Bo3WnOzWflST8FqmH7NgoYLrr8EFV3vwdJn3+JbAzPoRn?=
 =?us-ascii?Q?CTHOozuJkEc5QcPgbsq/eujjT52ny7epYwC2vpnVgwj3wkwLCZdHnA7UtBjR?=
 =?us-ascii?Q?Lp1wncd++u/oxP7QV2z6Usrhp4nOE4GLbk9cLbjKPh5YJgQfd8nWwbJjADAN?=
 =?us-ascii?Q?TMyYDsChuaF5h1kjdy6ElKOkQKEoRsOlpDYMASrTqD9YqwFsUL8qQNLjn0+p?=
 =?us-ascii?Q?hiSEqI+cYE+sZ6Zf8udpIhLHe61rw05UupPi9XHcOmwsA3+DHxgUKI2PHoHm?=
 =?us-ascii?Q?jwV0AGUePIa375Qh7l3kmlJJyLg8csrF218AQszkVJ/etLxYsaapZAhKioD6?=
 =?us-ascii?Q?RDivKvtJkhEKPRdUsoc8hgScLmb7aT53AC1N3L3zAqjkuZsdyfd7rBhesPVU?=
 =?us-ascii?Q?L4GuBBcFivDmA9VZjFdi+TNC6yF/gyxayAT8fyeZot197K9hB3lxP68oDm1k?=
 =?us-ascii?Q?5R6hi9OMpUmKPUz9+gBEKjGFxezbNrdRwo3roYoLGgXfr+EkQg8XRvZ7guBC?=
 =?us-ascii?Q?Gy8OwYtyHJZVs4RuSrYTXvJNvlhAm6oo/cKuAcE0m684la9iBTVUyIrpYlMF?=
 =?us-ascii?Q?2RtON9+/P6Mi3Ua34fBt06QWraNkX0j1USqtHvqnjjsqRG18SNyS5u2U3Hr8?=
 =?us-ascii?Q?F5rxlWpyb1YSDt4KRY8fnjYJW1vRYLkVLAZL3mkd2Vdnrccbrtrz7TIsdoSO?=
 =?us-ascii?Q?Km3d5NrTZlapYbK2UkX1zMAdMhINknIFUyyLRhSsIdvQUf+yXsQldndjh5MS?=
 =?us-ascii?Q?g2PzquXWKiIfSzTc1ASsKBAqPMFckJcDtDUXjfDrfCTrJscyeaMjS3qAFp1+?=
 =?us-ascii?Q?a+D7CuLSZz919HUXLErxCBm/6NMFLuaXvjBc5GAHYVtp+vz4h25hL+R0CkFx?=
 =?us-ascii?Q?QLPpuFYWmU9UdEDlAynMN68whKoidyWh1O+/jQ8i+SCdATRDcroJct4i/tp7?=
 =?us-ascii?Q?Pd7EkDuOPWXF0iTPiXruPkOl2kn6H+qsOlFvrSOOz6zuo8lmZ/KpHElrzqII?=
 =?us-ascii?Q?AjFPyyr07QDcYor4QU9fmOV2B278PxrU/LOXRRrdZhHsEmdp+eoSnXBbRCek?=
 =?us-ascii?Q?knoKbUMCohwfEmb9Y5K1KSzzAnopZh+48kikoaa0K9pwGgAgGv8pn/SwsHCj?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xBgtmPTiCnl5UkDes5ofJ6R3Espmyom6D8eaHDmJJw6Fa81cJAVtOSnTPXK3sCvlfL/BBZ0tKpXcJ2IBgbA4Dz7ND+Ikiyi+++kSf/W4TguzhOIc6s9yc8V2tWytSHvzxusn/gqvXG+LvOmCCx29zsXyU8eHwe/1JOVg9leEg0YfoYVqeIGBIo1phAOiyrEos1ix7E8NLX63zTNfDKUekCz4G8QJrwjbxwK6rfmBZVaJ63dLWFnOqvwYHV0Ra7C9qOYPijjHVhTA/UJ7y/A2BJJfensVUR+gYZDT6a1k7mtNKMtrVv5N/nOaD4tj3C0dXsFzJTDuOtrT1BS1lhv6ngcHfc7bP+QY8YcjQYDBuO81EpT3p6vdCSL18IZ70+cbYH8ZivTnFZ68KOFv7TArZ3F2x9VXtcO3Cei7dh0l2UHx7cn2UHOefE5l2HzJ0heI5r12bKnpkOm8fiRzkTAu+MJmL/hL7SXwy8Fq7BnhK1JyAbJHkZBxIGZuSMqCUdyZZvJ4UM4Gfs2NDHrY2+W6Yv6/juI0aRxxsDi+cMlRrxhk4qkr6rdRG1EEHUEE1ygbntMNGxmuDXzhuwsJYyrv0uHE1cMoaJbCwUrminc+u/U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d3ab51-9209-41e7-71eb-08dd8aea0a54
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 08:59:55.8853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6SgZ1FIaxUQAYk+svy+uwiVRKbgIvDksCYlLEvCHZnnJsAtbCnHrTEPnLcqcYwenpj9T54qcio+vkLxtfzFNvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-04_03,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505040081
X-Proofpoint-GUID: 1AxKvGNEhloP-Fwo4cfajmAzhWUZaCxQ
X-Proofpoint-ORIG-GUID: 1AxKvGNEhloP-Fwo4cfajmAzhWUZaCxQ
X-Authority-Analysis: v=2.4 cv=eMcTjGp1 c=1 sm=1 tr=0 ts=68172c90 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=04d_y77oF55RfSPHe00A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA0MDA4MSBTYWx0ZWRfX2weHmN8WH+6S aeovu5CMxGMPLELy8LaxV5u4CReP1KZq7tJr3+n8i6cPw+PHYKR9UV2EaQw+cOc/4nGFNYsKBAJ dk5s4b1Jr4F0TAFVVZnhh1JrURumuadzGRndX2RvfsW8HLsDAqhdhjpI/RM+gAJgN40X5HC8N8R
 fEiPumiGpwhBQ7PdKYyx97y/LDspacNyXQSD1916s9ZlylkBGa9npJecsKtzzQWtpq98DgKbVZV kmafrG10Kt1LMiEOfaWaKWUjUqufI7kKwY0b9eoIVKBT20iFfhJOGWa49wUBmb+8a5sDvTkv3qP pZ0hJO1GZT8u3wEf+uUh36JuZtQtFnEDNjgTHaqI9BY7Z5Heq0nyCirzqVaFw60SiGhz7qE2Oat
 twDM8XBzEYG+K1Ew/85bxmItE++YaGAHvAM1tuftDdXryJ0yapXCD0dEN1oDwZinWuQrp2ek

Currently atomic write support for xfs is limited to writing a single
block as we have no way to guarantee alignment and that the write covers
a single extent.

This series introduces a method to issue atomic writes via a
software-based method.

The software-based method is used as a fallback for when attempting to
issue an atomic write over misaligned or multiple extents.

For xfs, this support is based on reflink CoW support.

The basic idea of this CoW method is to alloc a range in the CoW fork,
write the data, and atomically update the mapping.

Initial mysql performance testing has shown this method to perform ok.
However, there we are only using 16K atomic writes (and 4K block size),
so typically - and thankfully - this software fallback method won't be
used often.

For other FSes which want large atomics writes and don't support CoW, I
think that they can follow the example in [0].

Catherine is currently working on further xfstests for this feature,
which we hope to share soon.

About 16/16, maybe it can be omitted as there is no strong demand to have
it included.

Based on bfecc4091e07 (xfs/next-rc, xfs/for-next) xfs: allow ro mounts
if rtdev or logdev are read-only

[0] https://lore.kernel.org/linux-xfs/20250310183946.932054-1-john.g.garry@oracle.com/

Differences to v10:
- add "xfs: only call xfs_setsize_buftarg once ..." by Darrick
- symbol renames in "xfs: ignore HW which cannot..." by Darrick

Differences to v9:
- rework "ignore HW which cannot .." patch by Darrick
- Ensure power-of-2 max always for unit min/max when no HW support

Differences to v8:
- Darrick reworked patch for mount option
- Darrick reworked patch to ignore HW
- Minor changes and cleanups from Darrick
- Rework some commit messages (Christoph)
- Pick up RB tags from Christoph (thanks!)

Differences to v7:
- Add patch for mp hw awu max and min
- Fixed for awu max mount option (Darrick)


Darrick J. Wong (5):
  xfs: only call xfs_setsize_buftarg once per buffer target
  xfs: add helpers to compute log item overhead
  xfs: add helpers to compute transaction reservation for finishing
    intent items
  xfs: ignore HW which cannot atomic write a single block
  xfs: allow sysadmins to specify a maximum atomic write limit at mount
    time

John Garry (11):
  fs: add atomic write unit max opt to statx
  xfs: rename xfs_inode_can_atomicwrite() ->
    xfs_inode_can_hw_atomic_write()
  xfs: allow block allocator to take an alignment hint
  xfs: refactor xfs_reflink_end_cow_extent()
  xfs: refine atomic write size check in xfs_file_write_iter()
  xfs: add xfs_atomic_write_cow_iomap_begin()
  xfs: add large atomic writes checks in xfs_direct_write_iomap_begin()
  xfs: commit CoW-based atomic writes atomically
  xfs: add xfs_file_dio_write_atomic()
  xfs: add xfs_calc_atomic_write_unit_max()
  xfs: update atomic write limits

 Documentation/admin-guide/xfs.rst |  11 +
 block/bdev.c                      |   3 +-
 fs/ext4/inode.c                   |   2 +-
 fs/stat.c                         |   6 +-
 fs/xfs/libxfs/xfs_bmap.c          |   5 +
 fs/xfs/libxfs/xfs_bmap.h          |   6 +-
 fs/xfs/libxfs/xfs_log_rlimit.c    |   4 +
 fs/xfs/libxfs/xfs_trans_resv.c    | 343 +++++++++++++++++++++++++++---
 fs/xfs/libxfs/xfs_trans_resv.h    |  25 +++
 fs/xfs/xfs_bmap_item.c            |  10 +
 fs/xfs/xfs_bmap_item.h            |   3 +
 fs/xfs/xfs_buf.c                  |  58 +++--
 fs/xfs/xfs_buf.h                  |   9 +-
 fs/xfs/xfs_buf_item.c             |  19 ++
 fs/xfs/xfs_buf_item.h             |   3 +
 fs/xfs/xfs_extfree_item.c         |  10 +
 fs/xfs/xfs_extfree_item.h         |   3 +
 fs/xfs/xfs_file.c                 |  87 +++++++-
 fs/xfs/xfs_inode.h                |  14 +-
 fs/xfs/xfs_iomap.c                | 190 ++++++++++++++++-
 fs/xfs/xfs_iomap.h                |   1 +
 fs/xfs/xfs_iops.c                 |  76 ++++++-
 fs/xfs/xfs_iops.h                 |   3 +
 fs/xfs/xfs_log_cil.c              |   4 +-
 fs/xfs/xfs_log_priv.h             |  13 ++
 fs/xfs/xfs_mount.c                | 159 ++++++++++++++
 fs/xfs/xfs_mount.h                |  17 ++
 fs/xfs/xfs_refcount_item.c        |  10 +
 fs/xfs/xfs_refcount_item.h        |   3 +
 fs/xfs/xfs_reflink.c              | 146 ++++++++++---
 fs/xfs/xfs_reflink.h              |   6 +
 fs/xfs/xfs_rmap_item.c            |  10 +
 fs/xfs/xfs_rmap_item.h            |   3 +
 fs/xfs/xfs_super.c                |  97 ++++++++-
 fs/xfs/xfs_trace.h                | 115 ++++++++++
 include/linux/fs.h                |   3 +-
 include/linux/stat.h              |   1 +
 include/uapi/linux/stat.h         |   8 +-
 38 files changed, 1363 insertions(+), 123 deletions(-)

-- 
2.31.1


