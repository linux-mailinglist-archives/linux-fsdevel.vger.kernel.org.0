Return-Path: <linux-fsdevel+bounces-47394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E4BA9CEE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 18:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E08699A5ECA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 16:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB52F209F49;
	Fri, 25 Apr 2025 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Grf8jZeR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HGmc761n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3681F460F;
	Fri, 25 Apr 2025 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599707; cv=fail; b=tw1D8d9VMJAmFQlLJecthxfl+q7xtS5FwzSa0imhfvuYYCaglehQAqaFduZU5ob+fAqOBub5UDFUKm9J0I41XvreNi25EM+Ude5VHdqcK/jEui2haPtH9145I7e6qFmTgWQEDcpzKaBKc6ST0/A6xE/lVzZ02ZYf99fZOxQ50Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599707; c=relaxed/simple;
	bh=JxtzGFiRhwdBr+dkq3HdAjTE9OpOdB/Sk9uP1itUjcY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JHO7L4nM7lZ+TGSFCiUnf/XGzSyisd3ONSrj9OXHq2Si4FZ5LkUP89LZWa4CagUy65XuPMmIJ/nVrmGDvDeKpWkPCOoEturzj9BeY/w5AvQaL3Li3YTpcyMK5zPUdFCgWbLprTiPR9G5RNiFS1ftUi+sdLqtJJAj3y3xbsJ3tac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Grf8jZeR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HGmc761n; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PFqWNt008437;
	Fri, 25 Apr 2025 16:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=zQXWYGPRwG7ARzno
	hUdBR5+X9tWFsGBXO8WB9D8sKq8=; b=Grf8jZeR2tOjc7hbVFa2kuqD0gQCznee
	Dg5rZkcDSmamP/dmBOKz2ArOhjW/6N7g3yPznHsLhIf6yBIScDEtxpEMF3yhjldD
	krN136Ba1Pc6/s83PLpYrWYdimB+LF6Py2abGwI1hJnpRqXaqUdKU1vNPN8V7Pme
	k5/B66PNuinlvTAT8kjDnQalBS9/zi7r3fpjTMhlNEgC6W6NyWfc7T37hbOYgBN8
	TyrCx4gMaGAebG8ZdsB8wyOnwpAtg6SM19KAgL4c9qv85oalUCZfA3xIRLY+2FZ8
	RleJcZvz9452xvbudaUYDCakoQihC5sDaAHZTGnP+zFET8nkcmXgPQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468d45r9ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:45:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PFsW4b024767;
	Fri, 25 Apr 2025 16:45:34 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013060.outbound.protection.outlook.com [40.93.20.60])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 467pud19p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:45:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjjN71J9DQhaQEYWCnbtDuizEegHwdRKboJnnutBWJAcHq9cJX8di6KZAu4MunfWoZXAIl0SsfsdwTfUp3+2OfwnW/ONpOS4aMEju4r73GXJy8Rw51CGCPAlBJEElkNZJE6+0MzqmrFk82ImClj9odpvioAroihhr7GhxA5n3iiGkuJ44+svK89LzeRiP7tDPpPKh71wkMR0YCLDORlimNA4b1ExjOxB7XZ7KvO84AVsfzDR0KbWBY/GzelSs1X4L32HRyxKkOM5GcnCRzoFMshtgPHv5wp0RfpInUTT3Hd7HjqdnA00sAxuYFDTS/1A5SNR8sAEYzQ+mRhZtHejaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQXWYGPRwG7ARznohUdBR5+X9tWFsGBXO8WB9D8sKq8=;
 b=Y0lxfBTIwp2Gp1dyWTsXpk2N1iH9RDNqGsdt7/bHknlRPDxJryYLwGugyeyieYix0oANYBOVdWr1+RBQzuYqwO2x4MhXRPvN+h2t4TkpLajqyWYGXm0z9U6LkdA6bT5wFjl4gMxA7ZQw9/LLqpNaQBqmVOy36hUDnkhy/STeI0RqnCpVLa6NUWGxY4fSO5RtNNdAQanc4QkCOLV45EMiaa9JAsHVI13CZ+qhXI3FnEwQFEwELa34ijZCbc8TpqPa5rPkhkJL9rSy+b3CN72mVZL06G4Gh/l3MheYVCTjxLuRvx0mdY5r4BQ9oNkWm7QtLbfICmhsYVdD7qGcdIlXig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQXWYGPRwG7ARznohUdBR5+X9tWFsGBXO8WB9D8sKq8=;
 b=HGmc761nvRB70mVSI1Ds0nlAWhbeMEOYAp6jbczbrNWLeseOD3e17SorUb80SRWPjrbB6u+sUzLAZFzix343SVTLvqHDjruf3FoNa6bMCrrcPkgTFSYP93PM5yMH5zFyZge+mOfdjs31sUXGtKDKPv4GPjM+be9aAB1z0AWReXk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6027.namprd10.prod.outlook.com (2603:10b6:208:389::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Fri, 25 Apr
 2025 16:45:29 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 16:45:28 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v9 00/15] large atomic writes for xfs
Date: Fri, 25 Apr 2025 16:44:49 +0000
Message-Id: <20250425164504.3263637-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: a063bb96-8169-4cc9-ef3c-08dd84189605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SZ7ViwgvsPZ0B1hJjyJnzjIsIULJyzH1EIqLq0jR4pnKVq14IGz7caumLBS2?=
 =?us-ascii?Q?htx/1sclVq3G+dDpWgVEPD7mBknds066VDqN6vfo+sMa+o0jhylpdOnDb+KM?=
 =?us-ascii?Q?Ezklj+xIKYCqusJln0ZLd+gCEyAC/UsYQbT8tpgXwo6MepiskngwBlzOY2q2?=
 =?us-ascii?Q?+dLCUDJhFBo3vPhFzLPfFhh7if+L8aSlJlvxq/bHMZkF3lhfh8WdSRP/eIAV?=
 =?us-ascii?Q?4dMWl7ozISyU83jaQRCG5M+JGcXpwqKKFZcsPseqNb/Bu6jhwEVxlGI9hK4+?=
 =?us-ascii?Q?scxbUiYiwsafsD8xuKBIfwmsuVDSclCy5afF6cTOP6zJhqPQ2cTp3WtN9s5G?=
 =?us-ascii?Q?8ptk+NnXzWfiOeyFu3jNcEo1hhZ6XzJN2ldy0KdoTaqMRMlH+zd1k2mmMaoU?=
 =?us-ascii?Q?TlprMWsljHqTArtUaRq/fK8YxPZhs2EkvPGQViTjeuKEodtA2m6p6i373tNK?=
 =?us-ascii?Q?ZTaA4xS/siEqiPZcootheMzSoQP3NSTwbPR0NxeF/qlWfew79xL486LgMKDS?=
 =?us-ascii?Q?9EY85X/2XvUfrY0tT6MLOn91hdKyrsoHIDKHrtuRE1FuU1psXmN3V/C+zcJ3?=
 =?us-ascii?Q?Jp1+6EzB2IBEKv9TG7HeomFeDAa2y2LvFNr4t3M0nzTxr4YI9MP+ak0x6bHG?=
 =?us-ascii?Q?3xzYgQrwfGrucfCS3sJcxNbr+NLBznyj5MWPwoCWohvlr6bHzTsjtfiJdaAM?=
 =?us-ascii?Q?Uzxx+EVTOlmu7fFvUbYLM89ft4SJy15/ZLO4dgQOueVL5GgwiBgA6YufHvN4?=
 =?us-ascii?Q?FSGlrOFZpIjvMKe3/rwezcnYNqVGYWkFhdZhLehhC1QgKuK/elIVgZIT6YL0?=
 =?us-ascii?Q?fCLZQ089rRaQ2TOgh1LR4bDRl2dEbdmkaRMeFxvwQQqoBXQau8R1GqDlcudV?=
 =?us-ascii?Q?CMoiqWD6lraNnB8aUTDwPhsEzxOCQDwQhA2BZ6xAi7TF/cZlT8mN5M/8rFp4?=
 =?us-ascii?Q?DP+dPB5wPegHU5Bi2aJv+cA08xLh1hXsSBZH/Cfo2K2GrgSCAF5jsu/5qDSD?=
 =?us-ascii?Q?NQdfHTt8h7YFdKyKFOYtnfGxInvnEZbtGYi3chilId8S3ZAq4MNNmpSBaZDa?=
 =?us-ascii?Q?xcAjhoX9qiIWwk11+i77GqIouAKiGhzEVzypuY3ANXJAm0w+7mMxr8S0TpAE?=
 =?us-ascii?Q?4p6QynZP5yxDjRgSipYVfJk+91QKjDBUX0wIAVc2Excv32QdeSfE4lcRzWyw?=
 =?us-ascii?Q?SvTtJsB7fndNlP5ntPGPznmRmZoz9uc49IHGGE+oz/+jKZeSpB18L+An7FGW?=
 =?us-ascii?Q?zzBgT3nHREsEBfQZ6LCRvRfkx7eRHPhqR5IXEvpAIkC/vIm4OUuGIjDPHitf?=
 =?us-ascii?Q?u0py1HT8m8tbzjOsNJYAWDYwL/23OjN/4w+3r3U9a0/ooCfSkvViX8goCV+5?=
 =?us-ascii?Q?bL5goFmxyygBtOSHtCpHVmWFuKSyTSXif53pUqwSgyxNg9VaWg1ZMr7FSiOr?=
 =?us-ascii?Q?h8LJ/BLa3tA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7aya9FiEEwOwUfIYq3XiIQp2oOuRekCdhhKLZ7ycbtpW31mVuRLDJncHQeix?=
 =?us-ascii?Q?MT8P8L1wR5Kx6XUawUDHDvxIw/6fF6xem45lb/8VI1rbwkmIBEH6oqC5pSPj?=
 =?us-ascii?Q?0bbZKCIig4gT538olGqwBO4SnYWRywyEWHHkFZ/XK0vre9Z5Thx/CqQeBo9x?=
 =?us-ascii?Q?pvJOAjDrjcGraxk8E41beJut7vV2sehKAh2TMm55FZpo8VCCjDJddWqFt+rf?=
 =?us-ascii?Q?tztWJctYGEH3daWchY5PBfKXZDFqtA9nvZJMHIP6AFJHrQVydqR18VXow7O8?=
 =?us-ascii?Q?OFEoXy+aK63E50SMHzoV4TcILWKnJoj9iKKkXmIsPWJeb0a3zvbCycsDFv+X?=
 =?us-ascii?Q?WyipwGYd/wFaXwcpu5h2FTR/rfW+UeTopncqlJ+pb6UCRgx/oxGQlN35QSbl?=
 =?us-ascii?Q?SbI5rRps+KqwTCKCbljobIan84s2TabHQMjXFUC9BeJgxb0YXME0P6SFsv65?=
 =?us-ascii?Q?0gei26uQsPVXc6uRWdDChwtE1C1paQRK5T6g/x0c0CtATuPL/UEBA9tjMOZO?=
 =?us-ascii?Q?eLndOveD13kqfcNOO8zVP1Q2cPUuwL9qdmQJmvfud8tGmVAYQWeO3Ibazy8K?=
 =?us-ascii?Q?JnhnXGOlC0O58/vmXooyayW9UUrenb2MGJUAVrxzcLuFsneHubnLw3ysCjF2?=
 =?us-ascii?Q?W8ehEUwEA8AeghB+dcxWxH+9xPUArHXckZEH5toQl99K/UqxKeWJsVDlEARK?=
 =?us-ascii?Q?YaIO375yvCNCXa04OehUgoH+iLBSawQE6IIi98Tip9cumTGbYyBgcDxpbU7p?=
 =?us-ascii?Q?dZqJsrPICr0mzNDRuR3Dj5SYEHBOv0yyrpuxHNIIrQn2fifrMM0GuGAqNmqW?=
 =?us-ascii?Q?vwe4Ku3FQSZMW27WUgMHJVuEZjPYa/p/9oe9WgKOn2NmzCmlP9guTBT0vSvC?=
 =?us-ascii?Q?aAkiYGIpzM/ANTHfRXAUFveCpIuKgmKHcFWESvixM18uBTeVwhnCCt0W+naJ?=
 =?us-ascii?Q?bITr9cLs3IKYQT4DfEpaxIOgO/+XK5Safr93QzDorwLKpMSD8Gb8VUH0ATrX?=
 =?us-ascii?Q?8VjMYUZkeIakmxRQlKWDzlhkDV+zkI+S2foimpsSG3+5nmsspO+Ivv8NAhcl?=
 =?us-ascii?Q?nNXJIDyvkpcjuK2hTsCnHZpwP1Xs4d/t1nL6d9zEsSMD4c3MLjwJBdePjvtL?=
 =?us-ascii?Q?Lnmrj0upeeFECE1mgXRi9H4YyTRn4mMfdSkjcePLidtYe5QSM+0HBeI3nD6z?=
 =?us-ascii?Q?ogNkI+Q0NvtxVO2XLuVYSlp4yg5XzWAWRMfqNwTSZkoMmlOrtZyo7ujAPZzr?=
 =?us-ascii?Q?9EwTYONbwknJUADeEebqN0iJxK9nmUJV4WPp7wb4omQv3mskkgUvUtGfqFAs?=
 =?us-ascii?Q?04Gp9OGZ6ZmLQUFWBWyC7VE5bSCUDE2PtvQR5NCSUG2TGFzeIDR5+3kKOzrD?=
 =?us-ascii?Q?1NcHLSF+X2i4QF/AWeET96HhdoPT1FoJtnBHvCcVODecX9ctWRJvSeuv2QKx?=
 =?us-ascii?Q?GHj4pF4apiAKbh2Gj+R/70kRMEOLP/kMe2J2zIGGgR4jStbbmJWDRs3IBM8j?=
 =?us-ascii?Q?F4TfWJv9Ef7Yr/IPmILJj0OAVENOrUlJDLPApIchppADBK4BTwpiy0cp2Re4?=
 =?us-ascii?Q?lxyCU0j5m1pQm5YjImvk2PNleJ7oxkKHHZouUHFfc7RC132SJoD+ZukaDe21?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2frlRXwMWOzgA8DN6Xh/5gn46bronMJMJHGoObD6m9xgrjI7+mUd9qGF4NYY537tAWvnIpqXbDfStvzJN3Dw66liQugQE+jLZBozIyn9PfUjJmlL41bLgP51evAGFOsTcVbngxf+9lE/f+pooS7TrDSWO+6G2UikEc50QhkOEG/rO5UzVhOdR2enRpaxNK5Afxy8LBCinbAASfVt7DqmevizwNY6S7f6vgA9Aj1y+aBBonjE8UOPjJC885xPgYwJVRJzeUYHQXQEcCgXkVPYqargm//+ThOC2IHbs3dWL1PFmawOM3U5F4bkoOVZyR0fij0zIXDuB/lnkYFwiMxq4eh25PQt6l3+tGLxO2zJLATRkuJUn5UnwjhomA+v7W328v5/YdbJXPZnDE2KOg2eVsyVUSnpMwzEhJbHEBKOllEUrE+cGdSinVwGIPVhqjPpYSdrDlH9iZULHsmvd3X7U//Uithb8IU59GgL45BUJ//TfawXOuv8P/yGj42dUbOdveCE4Notye7AD0xl6/zrHCuaUHkHPsWdp8Gru+4uMWNlxJKCAYYMor6zzdPeReaXCa4u374jf0UUs+5cVIgPp5yfo+I0+uOUoDQ8DcTB4hs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a063bb96-8169-4cc9-ef3c-08dd84189605
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 16:45:28.8674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Lw44CEX23u05FSkACPp7t1ZMLK9w8JjFdpwnYL7/tDw+shmcdEu8WOimZiklqoEHCn6n2r5lCHkHkDdlfpEFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6027
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250118
X-Proofpoint-GUID: ZF8L4b2wIc4FuT_D1ySQCeghQ7fYMqtB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDExOCBTYWx0ZWRfX+yGzc8aJImVW mG4RjzjwcX0IyYmw8TB+au7foA00ZPb9D3324Dl5FEOIWFyUIzkdkopQtVDsvJ6koZBfyLorrm5 zQnuxtHkH22w3EQmZvpGOChI+MGCVCAwBY9Pa84ATQWaYaC+Hum0R280Zid+5u043n2M/BiE25a
 HJK+OteYP7CiEhxgzEPlQL2ATD+TH+KscBDTvROM8ogr3aQeRhMrTkiRuSssbSXhFuWGuP80XGC zJaOENQNmluqDMw7no8YinAXDlKDfnev8aOHPJD0JYURsw5wJr35RP/X4cZQS3GqWhPjmsYV1+o AFLjAFzBLEyDXgApv5V70TQoavwW4wFMO5E4o0QEMKDdKmOgaGBgsCovAwbJbT9TLo9eHSgpbZr 63YMSZoC
X-Proofpoint-ORIG-GUID: ZF8L4b2wIc4FuT_D1ySQCeghQ7fYMqtB

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

Based on f0447f80aec8 (xfs/next-rc, xfs/for-next) xfs: remove
duplicate Zoned Filesystems sections in admin-guide

[0] https://lore.kernel.org/linux-xfs/20250310183946.932054-1-john.g.garry@oracle.com/

Differences to v8:
- Darrick reworked patch for mount option
- Darrick reworked patch to ignore HW
- Minor changes and cleanups from Darrick
- Rework some commit messages (Christoph)
- Pick up RB tags from Christoph (thanks!)

Differences to v7:
- Add patch for mp hw awu max and min
- Fixed for awu max mount option (Darrick)

Differences to v6:
- log item sizes updates (Darrick)
- rtvol support (Darrick)
- mount option for atomic writes (Darrick)
- Add RB tags from Darrick and Christoph (Thanks!)

Darrick J. Wong (4):
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
  xfs: add xfs_compute_atomic_write_unit_max()
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
 fs/xfs/xfs_buf.c                  |  41 +++-
 fs/xfs/xfs_buf.h                  |   3 +-
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
 fs/xfs/xfs_mount.c                | 166 +++++++++++++++
 fs/xfs/xfs_mount.h                |  17 ++
 fs/xfs/xfs_refcount_item.c        |  10 +
 fs/xfs/xfs_refcount_item.h        |   3 +
 fs/xfs/xfs_reflink.c              | 146 ++++++++++---
 fs/xfs/xfs_reflink.h              |   6 +
 fs/xfs/xfs_rmap_item.c            |  10 +
 fs/xfs/xfs_rmap_item.h            |   3 +
 fs/xfs/xfs_super.c                |  58 ++++-
 fs/xfs/xfs_trace.h                | 115 ++++++++++
 include/linux/fs.h                |   3 +-
 include/linux/stat.h              |   1 +
 include/uapi/linux/stat.h         |   8 +-
 38 files changed, 1322 insertions(+), 109 deletions(-)

-- 
2.31.1


