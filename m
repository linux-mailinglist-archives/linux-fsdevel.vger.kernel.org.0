Return-Path: <linux-fsdevel+bounces-46935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA191A969CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D8817E258
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 12:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5352857CE;
	Tue, 22 Apr 2025 12:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="czC9CWDG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QYFQdBqF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB99A27C842;
	Tue, 22 Apr 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324952; cv=fail; b=bIi5W7IF47veSw7nKsxoEf5J0wcfIKmSuwbVZNqr0L9hCYbE7H1ZCQRMLTKsnDfuwyz6n19kSCEZGVSOeKFInkOa1cMDwS8EDgDyQD5UYzlojZPOYqxghyFwo6mwvJMvBcqtqytlXc1mYQ0Gceg6UgsYULNb2nRAZeQDJ4kGowo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324952; c=relaxed/simple;
	bh=HJsYMi/pg/eHGM9Q+6hs0pzz+8TwQjaQ6L8H+AXQks8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YHSzArYBO02hnYO65ecbUhpWgbb3u326LyVB5MyLy8KsLYnAggqSPYGqQFFiwOcDjA1Rdbalyea0Uv6++sQdZEA8yJjtRnIkb19AJUFTpp0WYWshkPyNui4BfIkNJcxUDUpEm6qVxllzs6ubRWdE4oitbAZ9IfXVAO2pVKoNCVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=czC9CWDG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QYFQdBqF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MB39ns025696;
	Tue, 22 Apr 2025 12:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ppqIrLNngVB2L71ggEZBNWDOh6VuXPN2WFs4//pEtUk=; b=
	czC9CWDGuWc50HvFsaXOWZFFfhtVojxq8Vz7D62yVNGymW0DZdmDlLp+g7QIvdFl
	jh8my5lZ5hRAv8FEgjH9DbBzF59AtxG+elcIUeQ8rXqmebEcDHOYDqgxHJZd94Px
	JhRgdgvGGx2oIaVAynpS+BpH5gZ1onbPkOAvrYn5kXEAqQSy/PvQFISxgNWBdY/k
	Ly6BhfwdlygtCG0+FoYanGwglIrkfl775qKHB9GpYCv37JYZsALeMG9tidV56kk2
	i3VbEflSqW3w6+PslPPIsPwpl70humv21iL3dh+bNAMhNtBxcJ+YiMpfMa7dfmYQ
	M57BsyRhuSGDn9QI2S/j6g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4644csvbtn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53MBtH9U002293;
	Tue, 22 Apr 2025 12:28:57 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012013.outbound.protection.outlook.com [40.93.14.13])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4642999v45-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVMUp6p6Wf8zXMH8G2gKkiWj1owO7i0q4qHc6niZtn67J9SN/cSwYoY2lKUyQcvXnxZf5IP0p0/TpASZfaHDezW3OT6e65gyEJMa2kNN7rx/PHq7MDPC5OCbtYvYkNeC5uSMC7FD9mYNkQ8dttL5+RMVOyq7h3ap2JqqIk+/V6+jwa2FdALKbrzTEV7igwt44wGFGqNkTSpxlkxwescBtlQw1udHB4GYfcgCnoGHf/V3+yyQ/QdM61ExbMwKB8ZH7oNtQk/QfDLIQ6rEPguxl7k33x10qBEdLbDGjgieLF26mZf+97VhZnakT/jwvtpXuUTgU6r6hJiOch48MFEzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppqIrLNngVB2L71ggEZBNWDOh6VuXPN2WFs4//pEtUk=;
 b=RTTi2S+SJ+1tNaTyl2Ea+VihL74mx398Y+bnPbQZ2ry4fwwL1/BIgPDJovOiI/ZrQ+HpH7h81GUCxYeDBZClmZXYcPiRY7TIkFxxFt8CmfHoQV0EGP9EiI87ALw/Qeau4rK23gXQps8BzA0Seevgo2YywU7fu9aywX30ULZfE42O2OUgob3CuI8Hq/aLBr2oyOjLUu7BiC+4AWCwmH1VyMbrQFxG6IiwEh7POH4MY38Xx5iNvWrORfhTmCue9X9q4kGj0qEidvDSiM3yjtXxPtpSc6wkIg+6353buyoM6r0oMCYP44ChzS3hFG8SgolHRbD9mIlw5zty2Ox5wfhs4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppqIrLNngVB2L71ggEZBNWDOh6VuXPN2WFs4//pEtUk=;
 b=QYFQdBqFniHZHpsPoBQLnQOQ6+9jWyXaHs8pk12Gb7SgxvRNakfQz8PZIYlSyGvzTw28Kx2bwEavChDvowk47WHAIEOxkBmpwEE1LoDJVvqF7Rqsvg+72UroOiEZUk1cDageCfYW7rFnbaDiM9E1ett0yWI6AJ2cJ9Q3VCbKfMM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4895.namprd10.prod.outlook.com (2603:10b6:5:3a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Tue, 22 Apr
 2025 12:28:52 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 12:28:52 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v8 15/15] xfs: allow sysadmins to specify a maximum atomic write limit at mount time
Date: Tue, 22 Apr 2025 12:27:39 +0000
Message-Id: <20250422122739.2230121-16-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250422122739.2230121-1-john.g.garry@oracle.com>
References: <20250422122739.2230121-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:408:70::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c3fecd-a0b0-48e1-270f-08dd8199381f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0ak67SAxxd2wNd8KhlvCJtjzcIswKHt7eFi2Zxo4VBRHOmU0m9oA+qgXl7z5?=
 =?us-ascii?Q?3u0SfjO8knEVhq2WgH7Um8e2/NJmElU8FlQD7S/Y4SWA8eEEGL8fUy2Qak5+?=
 =?us-ascii?Q?9ZNJn9CnrPgChQH5a2/3vtKfL0222Q5jC9XXaMzqL+kPw34FNFfxnKTJh3Ca?=
 =?us-ascii?Q?yT+SiT1EuTU6+nJpEgKIjQblkaPilOwoNC2L4pXz3p6OgQqDz61eQugPglCC?=
 =?us-ascii?Q?kyQPr0mVoWsAXQVLcNRQyo1fgMPOvIF3ZJyPtjtf9m2+CVIwkZbQlFicvZ3G?=
 =?us-ascii?Q?z/+HuPH+AzLnrmkih0hAVf80w6n6ErG7abrok4hUJBpRvp+x1T+puLt97OUo?=
 =?us-ascii?Q?FOlUbbM+ksxVpIMRIxUrsvuAWUVIywBWEZuBfCVFj3uVdLTcw5GtC0H5CchS?=
 =?us-ascii?Q?1+TFLkp8i6YFbFzS2/hn7jcx2w0vbS1gzek4WC1NnEzvXxIZGKCZIk0rRgAl?=
 =?us-ascii?Q?oG3cRsNZRRZL3pNv+DaIkdfWpW+gV9cSfNJ9SYmC3DygcYkTMdRfIy4ARNXe?=
 =?us-ascii?Q?MrzbTsgabmBSMICNJVGDp0ucXzl7tcikg87qliPRjlQ+ktvbTpN+/InbIMQz?=
 =?us-ascii?Q?Z3B9jmi0JvaXQT7sj7bqAGIiIZm3pAuseb3iAc78SZoHQt0Rne+VMy5MpHEz?=
 =?us-ascii?Q?5y6ENj4FdqFXKvvEOgT5GBRyEb/eWn6pzxRCdhZaX/BvrhJBO4sUHsXjRlvL?=
 =?us-ascii?Q?TrRh/4Nkq8QMaK8Sj4h0ZEGIZOCQt5bMxu9qoJXk3FjCKbJPykO+9DgMn9+o?=
 =?us-ascii?Q?YRQnSqUb68EbfGr9EmVXgc0hFbNBXAHhU4i4yhGsLa+sKf6vdRtOaSjk8feY?=
 =?us-ascii?Q?vOD0QrhttzF1+swo0ZtSsEkw1RTCeReG2peM5esvi8szayBA9y+SIErXet1D?=
 =?us-ascii?Q?h5GF2iRCi19SGxajXZpxErgQbtGAkMyjsbQrkCKn3Y7L8AjAJNitVh3cLSwv?=
 =?us-ascii?Q?JLepTiGOrGJGNHPf3+AFk1u4dTac3lIGtjeSYFmM/tY6Q356Kd9FtxVmpYnN?=
 =?us-ascii?Q?1757epu9xB/l3fAG/XjSFVYX9dIEVqCwaF1Ai164eD90n6N3zJcSf8F8mThh?=
 =?us-ascii?Q?kpzjhtnz2s9xqxu216bx8fg/nidW1ABMubDKa7cJHuvVdIR0vcCDjTxLEeRf?=
 =?us-ascii?Q?SzpXYuJcM2Kt8DRvVO0aAjNTKJ2HsHY9faW+zb7w3likyfQAmiUOKL2cUlj9?=
 =?us-ascii?Q?Z/oOkkXRXj42uz2+U1xz3g0OEEVEaFAIMxiXb7HakN9IjKIjQ8Bc/ivppt7e?=
 =?us-ascii?Q?th1dVj/6HzoCx7raMZ4GSR6IQ2xPwIemYQpWj0wMkI0CW7PoPO6BNAsOJ4UL?=
 =?us-ascii?Q?WTiw+RCdVqB1F6tNBUdrKbC0heFoOOq16iTy8kRf3AM+ENk+LPGfYw2uBPTU?=
 =?us-ascii?Q?u2aLIQL7S9CW0iriRIJSp+YxUmg5ybHjrrIkVZawNV6C5rMdj05wCXJXR7mZ?=
 =?us-ascii?Q?5fKXQnIMNps=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9ErzWIo6fu76Q7uiGdbVXVTPKMlNuvcf1395hn/MRAKWZ4bV4yJF641/2sBr?=
 =?us-ascii?Q?4JCaAzXw6mc0aKLa+twP/BECWGqvk1g/JZHsRAowWCvRVzCUXKgKkHrmkGXM?=
 =?us-ascii?Q?QB5UjCdCrCIfKaTYcnDKRZf4B0ppwpx/AbfNkZO3v+svkW5HVOE22M1Me24a?=
 =?us-ascii?Q?ukWczJWDkPsNC2pN3mZR4wHXBEDtgDjU2NLeE5lHGMmCDsTEUb5j1rEcM0tq?=
 =?us-ascii?Q?Xd2K7gjGiaqszlvQudzzOLqGjH1cDtOd2xb9BgGYLHav7WW3dgEvhYY5+x8u?=
 =?us-ascii?Q?bHpvlNHxcxhe5TaabXfhj+aDedys/cUeR8/jdioBbB1tyqClj2q3oSUTn7PR?=
 =?us-ascii?Q?0syy6uL+rSijeSfNkDVN0R6RH69LDkOYQ8PRVHH80GgdPPZNXvOlPIEPmdLe?=
 =?us-ascii?Q?VuYGU+vTWM4qvQkIhXfAk18mON9v6fOH1h9e5DhfGPRWR3m2Fm9LFt06UD/z?=
 =?us-ascii?Q?Wya5pqHgMxagmwCYZ2yvAQyv3DLvHKaEGw+k5Fc/cANJRsaEC4VqGzx12YQu?=
 =?us-ascii?Q?5aPscGApHqDa6CGD878jYEe03y7kLTexlI9Evzg+erdpNZRdcT+lIk1sR6D/?=
 =?us-ascii?Q?sYTEUE7uW7ES3/lOpHU7iF/sVmhdXheLkM+ujdjAil+ve4isLCODbqHiZzCP?=
 =?us-ascii?Q?V052lcqcD/GkJnHQIAYNNEfxH+K6BhSRKv/tA8mYPVLdoLZk5qHHhr9WBgfO?=
 =?us-ascii?Q?z2HAew/tQL1JGZPfUcjnQveDirhmF7MhyFsDFZmcpObB2SJJbx4Qr0AqqB+G?=
 =?us-ascii?Q?sw08dE/HAhUOhhmf79NIrwFGhSRb9D3bZdjjbuq0j/B9pEynfKFs5O1CBvkh?=
 =?us-ascii?Q?lNL58F/ZB4csUz2poWFY96kgFDexIaAayrEZdj06lID0nFxkaeVV1hYbhral?=
 =?us-ascii?Q?bSjvT5IGgz4V4pXFS5YPrO8xD38+FGTUGIyg3cGAjgQadia95IY5ErbR9Htk?=
 =?us-ascii?Q?wfoe30gut6hUF7iFG5PWOFUJL4WDa9ZsOkL6rypsSa/LeS5PDPd+3/JEhoX5?=
 =?us-ascii?Q?oox/+tCCew1aXWvNqLH24yeQhXmww7ejp3Qt6LdsIerRevUJEdFhLS8IVwpz?=
 =?us-ascii?Q?zrXapXlBSAG6OZq2OyVUD6L4s5ccXT+THbb37SgU2SrbfywR6/Pj/zZHz2eT?=
 =?us-ascii?Q?6ernCrn1kRB2zWfHhgZPJp8J/dYrlHjtj1mpuKkfHS2KReofL875J9NCPEE8?=
 =?us-ascii?Q?IjHwaHQE9USYc/E01R0qnX5X2dwMSydV4ubLsZg6ArQsr2gxjYZPDuUQ4lGe?=
 =?us-ascii?Q?YNNUs8OL+XDfk3lc64Qu2ZsmdUPnG4PkJOH3D5DUjozrPYYzf08Zr39VhmvD?=
 =?us-ascii?Q?fVK5HPuVOFxwoBjEdg8rQ9lohlzRrtdWShkD2weGmZ2K4ns9Gg0ekKqjyPyb?=
 =?us-ascii?Q?RXdrqKiLCwAt9Qcekgt5UlcNlGNd0+W6WUeO8xwOKPmwtCpO2fsqOrjL2JZT?=
 =?us-ascii?Q?QhSGwNmfHe2u4cO6jfiCFxhzIKVM4qpajQMCQih2owbSwfQQRVTVu9dPeVz8?=
 =?us-ascii?Q?H/UjoUCs/36YlwyVVzuEnCwkxfn2DhCqKdgKCYoi78i6wQsSjkWu+RyPW6z8?=
 =?us-ascii?Q?DpHMijNdu24D5H3zQURxnk38NVdOi6dbHOYawJ/zLC+WO7Zj4YFsZBHedDfH?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NzFuxkt/aaCKpg3/kUfuPVHtPGpABGIdiF/lOqIvG2vqWg0Zsyz7RPRAQaPqj/LV28uPrKisGJ2DFo8i+erfX0p4DQMw4zOkKIwOM/DE0oSAgIvb+4a5QF8pxGAD2bBNFE/a75ov4BSq7KVN0cmX5owIQA4kZ8OiXkSUU+uceHAGBuWxFs2nhpCTjIVPoDkSJpNuVOd9dzaF/orORNlHIrUieFrhBSVNyZR870Aj8xn5Uwp65t0WTdtAlJgGYTG1WYRgZCmzQopVKDzhQss8bC9FxJknjgd503vc+96ooAryk2ct+7A2W4UyXx5LAKsIW+YeHO1/amzWuzAhlG0MS6DDJcpC8/6WWz00Py5U1R+40EqBqWFMaMfNkNuXBenWBR9/rJs/1h/t9FfmIJ9v+EUKtUeQQgR1bESgjRJmMZT7+DgWjlLSlqVoeEOp1h2XcxfqGGl+3Lw+XeQYPPgb5MmcDgXZBWeavsSdBCkF97wC0XmbSE7FKczANlFC5VYQp4opRCONpnQZ2fHJpObFse0tDYK2fCVH/WxeO6JcB1lqAvE1l9Of9oLbLETzAqZkXSKlvuVFyiEzBYHNPyM/OS/QWN7ZxdZwTyqQfta4SEk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c3fecd-a0b0-48e1-270f-08dd8199381f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 12:28:42.9363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DMA2nAM5/+XPy98GA7kkbjz+1v24BMq5R3vhYD/jNUYBm419QZUbEY9XTZ7V5+aBIutQzRyCb/19c483bL3+2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_06,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504220094
X-Proofpoint-ORIG-GUID: -A5VktWlUGsUPDt18YcGvwSlMZYzQWIx
X-Proofpoint-GUID: -A5VktWlUGsUPDt18YcGvwSlMZYzQWIx

From: "Darrick J. Wong" <djwong@kernel.org>

Introduce a mount option to allow sysadmins to specify the maximum size
of an atomic write.  If the filesystem can work with the supplied value,
that becomes the new guaranteed maximum.

The value mustn't be too big for the existing filesystem geometry (max
write size, max AG/rtgroup size).  We dynamically recompute the
tr_atomic_write transaction reservation based on the given block size,
check that the current log size isn't less than the new minimum log size
constraints, and set a new maximum.

The actual software atomic write max is still computed based off of
tr_atomic_ioend the same way it has for the past few commits.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 Documentation/admin-guide/xfs.rst | 11 +++++
 fs/xfs/libxfs/xfs_trans_resv.c    | 55 ++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_trans_resv.h    |  2 +
 fs/xfs/xfs_mount.c                | 69 ++++++++++++++++++++++++++++++-
 fs/xfs/xfs_mount.h                |  6 +++
 fs/xfs/xfs_super.c                | 58 +++++++++++++++++++++++++-
 fs/xfs/xfs_trace.h                | 33 +++++++++++++++
 7 files changed, 232 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/xfs.rst b/Documentation/admin-guide/xfs.rst
index 3e76276bd488..40b7789c8b34 100644
--- a/Documentation/admin-guide/xfs.rst
+++ b/Documentation/admin-guide/xfs.rst
@@ -151,6 +151,17 @@ When mounting an XFS filesystem, the following options are accepted.
 	optional, and the log section can be separate from the data
 	section or contained within it.
 
+  max_atomic_write=value
+	Set the maximum size of an atomic write.  The size may be
+	specified in bytes, in kilobytes with a "k" suffix, in megabytes
+	with a "m" suffix, or in gigabytes with a "g" suffix.  The size
+	cannot be larger than the maximum write size, larger than the
+	size of any allocation group, or larger than the size of a
+	remapping operation that the log can complete atomically.
+
+	The default value is to set the maximum I/O completion size
+	to allow each CPU to handle one at a time.
+
   max_open_zones=value
 	Specify the max number of zones to keep open for writing on a
 	zoned rt device. Many open zones aids file data separation
diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
index 708cfb4be661..86bc93b43dbd 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -1491,3 +1491,58 @@ xfs_calc_max_atomic_write_fsblocks(
 
 	return ret;
 }
+
+/*
+ * Compute the log reservation needed to complete an atomic write of a given
+ * number of blocks.  Worst case, each block requires separate handling.
+ */
+int
+xfs_calc_atomic_write_reservation(
+	struct xfs_mount	*mp,
+	xfs_extlen_t		blockcount)
+{
+	struct xfs_trans_res	*curr_res = &M_RES(mp)->tr_atomic_ioend;
+	unsigned int		per_intent, step_size;
+	unsigned int		logres;
+	uint			old_logres =
+		M_RES(mp)->tr_atomic_ioend.tr_logres;
+	int			min_logblocks;
+
+	xfs_calc_default_atomic_ioend_reservation(mp, M_RES(mp));
+
+	/*
+	 * If the caller doesn't ask for a specific atomic write size, then
+	 * use the defaults.
+	 */
+	if (blockcount == 0)
+		return 0;
+
+	/*
+	 * The caller asked for a specific size but we don't support out of
+	 * places writes, so this is a failure.
+	 */
+	if (curr_res->tr_logres == 0)
+		return -EINVAL;
+
+	per_intent = xfs_calc_atomic_write_ioend_geometry(mp, &step_size);
+
+	/* Check for overflows */
+	if (check_mul_overflow(blockcount, per_intent, &logres))
+		return -EINVAL;
+	if (check_add_overflow(logres, step_size, &logres))
+		return -EINVAL;
+
+	curr_res->tr_logres = logres;
+	min_logblocks = xfs_log_calc_minimum_size(mp);
+
+	trace_xfs_calc_max_atomic_write_reservation(mp, per_intent, step_size,
+			blockcount, min_logblocks, curr_res->tr_logres);
+
+	if (min_logblocks > mp->m_sb.sb_logblocks) {
+		/* Log too small, revert changes. */
+		curr_res->tr_logres = old_logres;
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
index a6d303b83688..16fd90b50ccd 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.h
+++ b/fs/xfs/libxfs/xfs_trans_resv.h
@@ -122,5 +122,7 @@ unsigned int xfs_calc_write_reservation_minlogsize(struct xfs_mount *mp);
 unsigned int xfs_calc_qm_dqalloc_reservation_minlogsize(struct xfs_mount *mp);
 
 xfs_extlen_t xfs_calc_max_atomic_write_fsblocks(struct xfs_mount *mp);
+int xfs_calc_atomic_write_reservation(struct xfs_mount *mp,
+		xfs_extlen_t blockcount);
 
 #endif	/* __XFS_TRANS_RESV_H__ */
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index eb5ed61b6f99..54fc06285131 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -740,6 +740,71 @@ xfs_calc_atomic_write_unit_max(
 			max_agsize, max_rgsize);
 }
 
+/*
+ * Try to set the atomic write maximum to a new value that we got from
+ * userspace via mount option.
+ */
+int
+xfs_set_max_atomic_write_opt(
+	struct xfs_mount	*mp,
+	unsigned long long	new_max_bytes)
+{
+	const xfs_filblks_t	new_max_fsbs = XFS_B_TO_FSBT(mp, new_max_bytes);
+	const xfs_extlen_t	max_write = xfs_calc_atomic_write_max(mp);
+	const xfs_extlen_t	max_group =
+		max(xfs_calc_perag_awu_max(mp), xfs_calc_rtgroup_awu_max(mp));
+	int			error;
+
+	if (new_max_bytes == 0)
+		goto set_limit;
+
+	ASSERT(max_write <= U32_MAX);
+
+	/* generic_atomic_write_valid enforces power of two length */
+	if (!is_power_of_2(new_max_bytes)) {
+		xfs_warn(mp,
+ "max atomic write size of %llu bytes is not a power of 2",
+				new_max_bytes);
+		return -EINVAL;
+	}
+
+	if (new_max_bytes & mp->m_blockmask) {
+		xfs_warn(mp,
+ "max atomic write size of %llu bytes not aligned with fsblock",
+				new_max_bytes);
+		return -EINVAL;
+	}
+
+	if (new_max_fsbs > max_write) {
+		xfs_warn(mp,
+ "max atomic write size of %lluk cannot be larger than max write size %lluk",
+				new_max_bytes >> 10,
+				XFS_FSB_TO_B(mp, max_write) >> 10);
+		return -EINVAL;
+	}
+
+	if (new_max_fsbs > max_group) {
+		xfs_warn(mp,
+ "max atomic write size of %lluk cannot be larger than allocation group size %lluk",
+				new_max_bytes >> 10,
+				XFS_FSB_TO_B(mp, max_group) >> 10);
+		return -EINVAL;
+	}
+
+set_limit:
+	error = xfs_calc_atomic_write_reservation(mp, new_max_fsbs);
+	if (error) {
+		xfs_warn(mp,
+ "cannot support completing atomic writes of %lluk",
+				new_max_bytes >> 10);
+		return error;
+	}
+
+	xfs_calc_atomic_write_unit_max(mp);
+	mp->m_awu_max_bytes = new_max_bytes;
+	return 0;
+}
+
 /* Compute maximum possible height for realtime btree types for this fs. */
 static inline void
 xfs_rtbtree_compute_maxlevels(
@@ -1175,7 +1240,9 @@ xfs_mountfs(
 	 * derived from transaction reservations, so we must do this after the
 	 * log is fully initialized.
 	 */
-	xfs_calc_atomic_write_unit_max(mp);
+	error = xfs_set_max_atomic_write_opt(mp, mp->m_awu_max_bytes);
+	if (error)
+		goto out_agresv;
 
 	return 0;
 
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index ba55fa1d9594..93e2bec24af9 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -241,6 +241,9 @@ typedef struct xfs_mount {
 	unsigned int		m_dd_awu_hw_max;
 	unsigned int		m_rt_awu_hw_max;
 
+	/* max_atomic_write mount option value */
+	unsigned long long	m_awu_max_bytes;
+
 	/*
 	 * Bitsets of per-fs metadata that have been checked and/or are sick.
 	 * Callers must hold m_sb_lock to access these two fields.
@@ -803,4 +806,7 @@ static inline void xfs_mod_sb_delalloc(struct xfs_mount *mp, int64_t delta)
 	percpu_counter_add(&mp->m_delalloc_blks, delta);
 }
 
+int xfs_set_max_atomic_write_opt(struct xfs_mount *mp,
+		unsigned long long new_max_bytes);
+
 #endif	/* __XFS_MOUNT_H__ */
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index b2dd0c0bf509..4cdb161a1bb8 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -111,7 +111,7 @@ enum {
 	Opt_prjquota, Opt_uquota, Opt_gquota, Opt_pquota,
 	Opt_uqnoenforce, Opt_gqnoenforce, Opt_pqnoenforce, Opt_qnoenforce,
 	Opt_discard, Opt_nodiscard, Opt_dax, Opt_dax_enum, Opt_max_open_zones,
-	Opt_lifetime, Opt_nolifetime,
+	Opt_lifetime, Opt_nolifetime, Opt_max_atomic_write,
 };
 
 static const struct fs_parameter_spec xfs_fs_parameters[] = {
@@ -159,6 +159,7 @@ static const struct fs_parameter_spec xfs_fs_parameters[] = {
 	fsparam_u32("max_open_zones",	Opt_max_open_zones),
 	fsparam_flag("lifetime",	Opt_lifetime),
 	fsparam_flag("nolifetime",	Opt_nolifetime),
+	fsparam_string("max_atomic_write",	Opt_max_atomic_write),
 	{}
 };
 
@@ -241,6 +242,9 @@ xfs_fs_show_options(
 
 	if (mp->m_max_open_zones)
 		seq_printf(m, ",max_open_zones=%u", mp->m_max_open_zones);
+	if (mp->m_awu_max_bytes)
+		seq_printf(m, ",max_atomic_write=%lluk",
+				mp->m_awu_max_bytes >> 10);
 
 	return 0;
 }
@@ -1334,6 +1338,42 @@ suffix_kstrtoint(
 	return ret;
 }
 
+static int
+suffix_kstrtoull(
+	const char		*s,
+	unsigned int		base,
+	unsigned long long	*res)
+{
+	int			last, shift_left_factor = 0;
+	unsigned long long	_res;
+	char			*value;
+	int			ret = 0;
+
+	value = kstrdup(s, GFP_KERNEL);
+	if (!value)
+		return -ENOMEM;
+
+	last = strlen(value) - 1;
+	if (value[last] == 'K' || value[last] == 'k') {
+		shift_left_factor = 10;
+		value[last] = '\0';
+	}
+	if (value[last] == 'M' || value[last] == 'm') {
+		shift_left_factor = 20;
+		value[last] = '\0';
+	}
+	if (value[last] == 'G' || value[last] == 'g') {
+		shift_left_factor = 30;
+		value[last] = '\0';
+	}
+
+	if (kstrtoull(value, base, &_res))
+		ret = -EINVAL;
+	kfree(value);
+	*res = _res << shift_left_factor;
+	return ret;
+}
+
 static inline void
 xfs_fs_warn_deprecated(
 	struct fs_context	*fc,
@@ -1518,6 +1558,14 @@ xfs_fs_parse_param(
 	case Opt_nolifetime:
 		parsing_mp->m_features |= XFS_FEAT_NOLIFETIME;
 		return 0;
+	case Opt_max_atomic_write:
+		if (suffix_kstrtoull(param->string, 10,
+				     &parsing_mp->m_awu_max_bytes)) {
+			xfs_warn(parsing_mp,
+ "max atomic write size must be positive integer");
+			return -EINVAL;
+		}
+		return 0;
 	default:
 		xfs_warn(parsing_mp, "unknown mount option [%s].", param->key);
 		return -EINVAL;
@@ -2114,6 +2162,14 @@ xfs_fs_reconfigure(
 	if (error)
 		return error;
 
+	/* Validate new max_atomic_write option before making other changes */
+	if (mp->m_awu_max_bytes != new_mp->m_awu_max_bytes) {
+		error = xfs_set_max_atomic_write_opt(mp,
+				new_mp->m_awu_max_bytes);
+		if (error)
+			return error;
+	}
+
 	/* inode32 -> inode64 */
 	if (xfs_has_small_inums(mp) && !xfs_has_small_inums(new_mp)) {
 		mp->m_features &= ~XFS_FEAT_SMALL_INUMS;
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index d5ae00f8e04c..01ef8b48a354 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -230,6 +230,39 @@ TRACE_EVENT(xfs_calc_max_atomic_write_fsblocks,
 		  __entry->blockcount)
 );
 
+TRACE_EVENT(xfs_calc_max_atomic_write_reservation,
+	TP_PROTO(struct xfs_mount *mp, unsigned int per_intent,
+		 unsigned int step_size, unsigned int blockcount,
+		 unsigned int min_logblocks, unsigned int logres),
+	TP_ARGS(mp, per_intent, step_size, blockcount, min_logblocks, logres),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned int, per_intent)
+		__field(unsigned int, step_size)
+		__field(unsigned int, blockcount)
+		__field(unsigned int, min_logblocks)
+		__field(unsigned int, cur_logblocks)
+		__field(unsigned int, logres)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_super->s_dev;
+		__entry->per_intent = per_intent;
+		__entry->step_size = step_size;
+		__entry->blockcount = blockcount;
+		__entry->min_logblocks = min_logblocks;
+		__entry->cur_logblocks = mp->m_sb.sb_logblocks;
+		__entry->logres = logres;
+	),
+	TP_printk("dev %d:%d per_intent %u step_size %u blockcount %u min_logblocks %u logblocks %u logres %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->per_intent,
+		  __entry->step_size,
+		  __entry->blockcount,
+		  __entry->min_logblocks,
+		  __entry->cur_logblocks,
+		  __entry->logres)
+);
+
 TRACE_EVENT(xlog_intent_recovery_failed,
 	TP_PROTO(struct xfs_mount *mp, const struct xfs_defer_op_type *ops,
 		 int error),
-- 
2.31.1


