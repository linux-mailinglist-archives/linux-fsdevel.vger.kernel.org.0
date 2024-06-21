Return-Path: <linux-fsdevel+bounces-22095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9EF91218C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 12:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7291C22639
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 10:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BDF17166E;
	Fri, 21 Jun 2024 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SFkmZ9Gh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mQ1/5ukf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EE7171062;
	Fri, 21 Jun 2024 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964381; cv=fail; b=Ec53cfGKMQ9yh+F+zHKla3Vcfq08BCCMgl/XOHtIHWqr84pMbEz5Ufhtrs9ZVh8RNpkbb6l2SCa8hXlBuy6XZTdOD1a8Cd0IdGr1Un8xCvbMy/i9GO0JOtYRYK4fzNNkIaaYg4Jf+MRhx//9jilSPuB4rmCNso86tR7Laudo4fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964381; c=relaxed/simple;
	bh=HngHPCaEepxjXAGlXFJEL4o5XWv16tVNk3NcIb0bW1U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ktnh06p/dy29De0/ByzaJ9KVg9R8nS2DcXIkOn2oroQg4nOSmJDHqtLZoCNBUlmL1hTXcdtwJC5D7Hgg0M60C60ZaJMkgyJnSffCohBR8JjZv6KXwalBhCBTO3+/JNRHL45YBRljY8rutC8Z2Xt5jE6o0deh8JFEB0GZ9uhpATw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SFkmZ9Gh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mQ1/5ukf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L7fQNi018887;
	Fri, 21 Jun 2024 10:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=PRQhDbayiJgP9y
	zhCFFENHgIHSKaDfPn3Gd+8TIju6k=; b=SFkmZ9Gh7CQOXS/QEvaAkiasF+27yx
	TPOSge4I1TKEYtszN8WzcDKgsqI9wNsPMNBpnRRAGwrwniaqq3rUXCNbnwTIFwj7
	IZIBznHPaE2bo2Hc+GyBZt9i4htF2vKFe1T4uyTJfXs82SkpsENPNKIuXwgWt59u
	V4gvBw7SZJvSBIOdMkQJLS7Hby9kb7r6AiHtrYGyXaTRqrG3u1az3SMdVt6ceWgP
	wUQ4YXsuWsvmlkPWswBFoAlLhdQjMRUBsXnyAr+nQmZoUAN4fpULGdfTmJ1T1NcQ
	i0Ok+U2dvK1EmuBCJu9ijZ/8JBEo9IJUlU1pzy4bH0SzQ4vCFizbQ59A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkfsee6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 10:06:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45L8nh5j025177;
	Fri, 21 Jun 2024 10:06:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn5wc8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 10:06:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgdCxcZvsmyo+L2ddtSH2vNYQt29FYoO83oa38y9LsXhIkG3vvqD339u4LAp9Ueege9+MSXtCMti7Qlfn3bPQ6g6EU3wuceqTcr4B930u3A+OoCPd8mkNX8oCGICjPmKhtvttqksgxPJx1p/vUBnatyNXrcFG+3HxNgn+UvrgOqna8FflsqzhFCCVGU21IFGaUZCGYCfAIKiKsNvBhOTlQmZGGpTLWBq/7p9dJ2fbhqHF1QB035TBDow4eNlc0jwvv4hnE8/3OHZCtXCJ4DW6z5zi7tNq/PX9HDbJ2JnO0xoH2tRGK4UuXtxUZ0SimB5VdOq3E7xlbXWxbu/gl05lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRQhDbayiJgP9yzhCFFENHgIHSKaDfPn3Gd+8TIju6k=;
 b=PzUY8l1YL20LUWSx3i3Gnf87qRlfkh7D8454EnqXY7Ohg1BruKDEh1Gohq3nON9Vm4NJvWkLah4A5xpqmKWmOjOQYNYfHIde7yE+Lcnmp1h57IbD6e0iiJcgGRHsm+ZhvGS4g2reRFqt5NqegQQ9SnpHtxaY7VoTs5Y9EWhTV/iiPXcamS4H59NudBG4sf+p2euSiPP08Baiik9l2ZXsUR0dOl394rMmWhZ8GNbTjW1jTOvYSRBcPRG8E21VHenXFMMqtdP7MGsz3wFp/bHaLI9iGyU3JeM9IV1je+8DUAAlmE44rUeQJ4uG9MlYswU/dwM0DTw0YwgeiTX0OxLSWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRQhDbayiJgP9yzhCFFENHgIHSKaDfPn3Gd+8TIju6k=;
 b=mQ1/5ukfCrkcoIkvtMGP8Caw+uL3VseIc/uah22tg1MHqX1nsXIgqEfsSt7gyqIrI5BV2Q0y7EakO4eWIHpFhbUMSF5Ck4OMtekTPA8XQWZMAvRDKUeOpfn0Ql6fr3Sn1EE/F3WBG2ttMCN0Od8LtBlC5NvLnorzsVELrW1GcUM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6884.namprd10.prod.outlook.com (2603:10b6:610:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 10:06:00 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 10:06:00 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 00/13] forcealign for xfs
Date: Fri, 21 Jun 2024 10:05:27 +0000
Message-Id: <20240621100540.2976618-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0024.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::37) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 81874d83-1bd6-4c95-d6fa-08dc91d9c098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?wJB2/vBNpcCjSmYf0B2V1q92BqvW6W49sdNpz2Eh3ebhb82c2Ly/mWtOtmSs?=
 =?us-ascii?Q?u/7Th6wY/XSVQ41W4ddEI5UeclogTodM90/DVL8FUPxuyxPDv7OzORM9gln5?=
 =?us-ascii?Q?WP4TKZAWT2b/oLExrZykInPWNJfMIe92Opns/WMXxjPrsIrCzKvTUqr3gzHb?=
 =?us-ascii?Q?0WdV6KqFiDmY0sTFN5QIvmZO2HhUhnw4MuYZIvYzMztLaoUEmsjfPGagbhVx?=
 =?us-ascii?Q?Rl21qQ2NgL7qdzRXxyiIFdyFZQmvvfsIbC2Kguf6g9vyKNvx/oGtuNmHbp4O?=
 =?us-ascii?Q?PY264vcn6zlpMK4wFbhh7UwhOaIzE8EqzDxjHnqib4di9J/3WZ85ttnTyIhh?=
 =?us-ascii?Q?VyGBiLGLqjdWfsw0fI2poO84fniFRVVeAh2i5F5MrXhpVsPJ+l852nrRfiSs?=
 =?us-ascii?Q?zFisi4AoKQaUDZ/BDEn1e6jB67GGJIGOVBVmWqqx74K9Bs7OiSSrnuw8346w?=
 =?us-ascii?Q?cAZaLhOFIVxAYlYdR+PMT4BhsZUlv5bHoY26RQkeWYjaRkHXLv93YDI80ipT?=
 =?us-ascii?Q?L/oZGmo6e/mnZ9BCf2kZ27ypC0L1dKs0UGljA39BRQg0Q4JFkGxwirPuJvY+?=
 =?us-ascii?Q?Ys3pE40aeWsLx0iVUucZ4mRMDuzuUig2C562YREsVRefOf0DC6yW/W8oYDyE?=
 =?us-ascii?Q?ZhHcfhQ+nuqRNBYr36IKnqXzpk1Kc+z6rgzV/Hxlmx4L3b8WMCjU25xCeLRi?=
 =?us-ascii?Q?4SZQQYalaBg7gwpC2uNUwrm4C+hjtSPx0x49U9aFrnwL1kjDSlvSbxpTk0/6?=
 =?us-ascii?Q?LYwBgDRLTvNSIRziaP9RdH3F0O/ahp+GxLiPkzUm30y6NC4DuzZDUck8JAXi?=
 =?us-ascii?Q?vBZIldg+bBmrzU7G4g+t8kEaGkMjiRU/I1Q8N5jX+GM/Gal+nDmhJ0DMzLZF?=
 =?us-ascii?Q?1uc1RZoX/z8w1B+SbtQs+H94LFymncBm9oaRq7Rv2t5cOwccyWO4q7l2jWIO?=
 =?us-ascii?Q?YfCkteXqDQFf+4o0u2MsOTeBp46bNJzSk2IdmA8iDYHAevTlQitslyZ9IWP/?=
 =?us-ascii?Q?QwHm8HvlLuvk/gOR0/t4VBiW7s6GlIFDlJWD9FjY0EetpMqdrx2Nj5PDGOEb?=
 =?us-ascii?Q?Lorx1Ibd21rqfTSEWzZuFy6vOSOccKnW0vsNQVZnDHTCBYkg+5MXjJH6i7Lp?=
 =?us-ascii?Q?ZvqhD6YZKHPJ4O7fAx5YZz3ffEib8nE/eM+Eur7be5hLAJ7bloX8pnMZJTGZ?=
 =?us-ascii?Q?HA1oDpLRyvy/0XftFPSz3//z4bdFpOM4tXiKW5JXnHr3/WPtmJ04edH1Ozud?=
 =?us-ascii?Q?7Ukfpwc0+PXHRPb/PMlwWayAKV5SnjqKX7t/FTNlsw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Up5QwjgF1ZO8zui2QNuvjMTFZNGAn5++q7uQLX5h7owa/vaH5eKjPGBjwZEQ?=
 =?us-ascii?Q?Ro9KeWHfOxCssbr2jsiENMVe9Hz7ZYwWfluGkbeDNbHlDSGmmy/bvgraTlUL?=
 =?us-ascii?Q?cIJNWtW0Xg7vZJZTosizQH/ECFbi3e4QddFJtfxcQzYKoLNIVEFw1lU/8tRl?=
 =?us-ascii?Q?lnAs2HAPcSfgIR4OXE7cb40qebUnm2k4L6Q8v88Aon9T5hp/mV+A9meD2FRZ?=
 =?us-ascii?Q?8zq9sUpcziNgk4MQ/NGgT501PRZ69WmzxBGJhEQ9cAGAC1SNcGLrP99WJ3KQ?=
 =?us-ascii?Q?KHviH0aNtuA4AB0EIzCQPFwySuGcD4HBO6lSBSoar8GrjEWK6vkGx9BkT0rt?=
 =?us-ascii?Q?GVp0pRnfoRLhtCVDCckdHC2zA17nwlNmO7Ipl1MblktHupok4bR+ieYO12+p?=
 =?us-ascii?Q?cWomoJ02azjL/3+8kjKf2hqK0SBNDauoHdnNsaZiIDDLCG/VU1/vxO6+zetH?=
 =?us-ascii?Q?XvmsfnY8ZbbGryK0awBA9f0oy+lu9qGTyjh7N1xhHyPgTm5QVByy5JzMfNCu?=
 =?us-ascii?Q?y+Jtr7gDR5SRzNUQ4+ypYaH2a1/TQqiK9ZY5KMfZeX+y+A65Yi9Hibirooa2?=
 =?us-ascii?Q?ENfkm3qaOlbvogpGK6ZV2Jptr1HzuqwZ3sFNNCT3Jpy7cOZCilFoLrNDSvO/?=
 =?us-ascii?Q?z7Eyj83RdzBr/2SQ60uPIUh7PIMWLAvvEBu+Q9+KojooIVJIpks+B+vweE3D?=
 =?us-ascii?Q?ALwRmNWRufCnMjCTFbGuQ24V1Kk9mTOjB+P9qx+6coq7E7tbnEXz+s53tVVo?=
 =?us-ascii?Q?SQvHHjohz+lmDUKh+/+Wz9Vy5djw+Yxuh2Foh02PQMkXjm/Extaom4G6IaHB?=
 =?us-ascii?Q?ccM8CPPiltcZiVwOxVfcsMebPOguTeOIbmydJtISpB1OEQr/9k+tzNtLNPaA?=
 =?us-ascii?Q?txup+6/7KdvbTVQZW+FwxhGFY0tP8+GtmCBuYpPIrdOamOQOsSjgCGg2hJTn?=
 =?us-ascii?Q?cd72nBVu6ezZv0FfJpq9VSO+VKeCmMOeecIwcZPkuTS8693HzCYEUdeYK6aU?=
 =?us-ascii?Q?u/U0gr3QnuorLMx3ZckowuXGus9qLlsXqVF5Wn1RyDqMhYqWyLsb0uNMjpnz?=
 =?us-ascii?Q?jgxcLLDcPSW8cVJgLkPAAaRL2GrxX1IqVx6BBR902loL03JWMVJce/aUb9JV?=
 =?us-ascii?Q?VZmvn5lL8tWXNPZ1c+CmBmjFYj2cqTYWg4Aec9iFgg8k/4dFbXxe/yJsnwlH?=
 =?us-ascii?Q?hNQIuwdnq3ohg8eh6Lx3OtKva6eOUHciqyRNcmS98u2XmGdpu61eLtPU4pzE?=
 =?us-ascii?Q?JQA/bbgvV2jedho1dN2qYcPEBiDQZUvlhotyJ33Re5+GjYNM2NH4kDqAmyzH?=
 =?us-ascii?Q?AnvpHRjg8/1SJMus93U/XQ6rzxpQAJxcjDHq9tOiuRjt9qQ+sgWlC+3ZnqcE?=
 =?us-ascii?Q?HEbKOJpMuGBP2T6JPdXXv3LYglBliXuPv4MOohALnTaZ9jUk3kJ9GZqBy0rR?=
 =?us-ascii?Q?QydRbwAP980jI0iZXzsiw1oP8Qd88P+J4eei/tQ5Aw2n4OIUv2/Gn5pLfzFH?=
 =?us-ascii?Q?0H2KDPa61NnYZ3fnXL8Z0fqg8yblzyPuIIMHnZtInyuNTIs7sQ97bkq4VNL+?=
 =?us-ascii?Q?Mk8qrlh+EuepCxCkoakMplO8+9LocYI+pyzBfe7npCkEOjaX/YZ2KKIlk7G/?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zaOD8VcMg6RFBe7beK28zgatJ/ygj65rNz81tddHd1uHhDTy9Y0Acxjd26WSZT593EG/TdJTDO5AJ5xCtEgzdjdB3wemp+GtpiofI5VwsbpPXjTCglNEZj5BgI1NkVMz/WjjvJWFIuGtL8yrJN8OF2ClN/bCrJdGHOZ24M6+EElbr7qXBGqxBj5StTfF/M7wENAXjaCv5HxK8YosElV5+LAqfxoJnJ/AV0sn0MQOL/xIZotZDyvHuMX7m8XpmI3PfpPHXitLe1E54MIv1OT7yoQ5ECxZzToaOI306+pyuc/7UmHnXMITG8t65GB/8N5hBGKvcH3wgyWYKM5YL41G3JkjNVbD5zvglERxCeKm4f22/v+0jBJq8KWpWqM10vaQGsFhXlYrDP3qxglGMDqiFtB501c9ZfoC9ZPZi9865cMWhSW8mSKv4u0VZ4iQklz3+xzM5GD7EyfzL2oFMlkXzTsr2/eSdh1EDB6LpkW69xuNYym6IVMCa8SpLnH5xtUpo+c5uuGMerM4dhU2p6OXMqDWTH/2T7Vx3lARjecafzmZbQZZ+XPKQ6zKvOkL+QNCIFbNkbNQNpk43kCVVOCx6D1xUgOxAs6Xv7lPXEuAtlM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81874d83-1bd6-4c95-d6fa-08dc91d9c098
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 10:06:00.5973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PW7qLP+1/4zeFa9ACs8N2ZgDiJuS7QR08CgQwrE0zsoMrnxJcNOL7XakWvdZ+ClQboIWqZn4zxYjQedYN7s/eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6884
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406210074
X-Proofpoint-GUID: 6LXZhQO_ht3Dal4qyE1wz4hidA6nYVwF
X-Proofpoint-ORIG-GUID: 6LXZhQO_ht3Dal4qyE1wz4hidA6nYVwF

This series is being spun off the block atomic writes for xfs series at
[0].

That series has got too big and also has a dependency on the core block
atomic writes support at [1].

The actual forcealign patches are the same in this series, modulo an
attempt for a fix in xfs_bunmapi_align()

Why forcealign?
In some scenarios to may be required to guarantee extent alignment and
granularity.

For example, for atomic writes, the maximum atomic write unit size would
be limited at the extent alignment and granularity, guaranteeing that an
atomic write would not span data present in multiple extents.

forcealign may be useful as a performance tuning optimization in other
scenarios.

Early development xfsprogs support is at:
https://github.com/johnpgarry/xfsprogs-dev/tree/forcealign_and_atomicwrites_for_v4_xfs_block_atomic_writes

Catherine has been working on a formal version of this support, which
I need to update to.

Baseline:
xfs/for-next @ 348a1983cf4c ("xfs: fix unlink vs cluster buffer
instantiation race")
+ https://lore.kernel.org/linux-xfs/20240528171510.3562654-1-john.g.garry@oracle.com/

[0] https://lore.kernel.org/linux-xfs/20240607143919.2622319-1-john.g.garry@oracle.com/
[1] https://lore.kernel.org/linux-nvme/20240620125359.2684798-1-john.g.garry@oracle.com/T/#m4ab84ddd627d95e6e957b62c29bbf815ca6e44e2

Darrick J. Wong (2):
  xfs: Introduce FORCEALIGN inode flag
  xfs: Enable file data forcealign feature

Dave Chinner (6):
  xfs: only allow minlen allocations when near ENOSPC
  xfs: always tail align maxlen allocations
  xfs: simplify extent allocation alignment
  xfs: make EOF allocation simpler
  xfs: introduce forced allocation alignment
  xfs: align args->minlen for forced allocation alignment

John Garry (5):
  xfs: Do not free EOF blocks for forcealign
  xfs: Update xfs_inode_alloc_unitsize_fsb() for forcealign
  xfs: Unmap blocks according to forcealign
  xfs: Only free full extents for forcealign
  xfs: Don't revert allocated offset for forcealign

 fs/xfs/libxfs/xfs_alloc.c     |  33 ++--
 fs/xfs/libxfs/xfs_alloc.h     |   3 +-
 fs/xfs/libxfs/xfs_bmap.c      | 313 +++++++++++++++++++---------------
 fs/xfs/libxfs/xfs_format.h    |   9 +-
 fs/xfs/libxfs/xfs_ialloc.c    |  12 +-
 fs/xfs/libxfs/xfs_inode_buf.c |  53 ++++++
 fs/xfs/libxfs/xfs_inode_buf.h |   3 +
 fs/xfs/libxfs/xfs_sb.c        |   2 +
 fs/xfs/xfs_bmap_util.c        |  14 +-
 fs/xfs/xfs_inode.c            |  15 ++
 fs/xfs/xfs_inode.h            |  23 +++
 fs/xfs/xfs_ioctl.c            |  47 ++++-
 fs/xfs/xfs_mount.h            |   2 +
 fs/xfs/xfs_reflink.h          |  10 --
 fs/xfs/xfs_super.c            |   4 +
 fs/xfs/xfs_trace.h            |   8 +-
 include/uapi/linux/fs.h       |   2 +
 17 files changed, 371 insertions(+), 182 deletions(-)

-- 
2.31.1


