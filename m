Return-Path: <linux-fsdevel+bounces-42982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECE5A4C9F6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 18:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14EC13BCA59
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959E42580CE;
	Mon,  3 Mar 2025 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XYxGjCci";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NG4WlG0q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FB425744F;
	Mon,  3 Mar 2025 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021934; cv=fail; b=V3an8ONLV2Vhu6A3lepw0FAy3jPeQOf1npaFYz75DLAbHd3mKEaFqWmflekQSof4annSaLVQRXx0xTVvwPuf5aAGv0LNtEMiCUcNZ7SmC55Gj7+9mf3WcMil/O/wlQz/wYL+d5rf1ztuL2YpY7+doI/NQ2+HAsPSvnZM5lAo2IM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021934; c=relaxed/simple;
	bh=+1zKr3umsMcfDxD1Uitu0Zl/lcyQB3aM5HZ4bV8D8mg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DyoXrxE6RUGHCz4VulWYFygSGuFBVqdINVYyNJqrsdmPhxz0Q0QaV94NxAaChTH8WbR1dcxwnb014B803xONwgi3Ttlrw2Kiiifendb/uR7fw9K7a7TIHYfWYz5UQ6iAEuq2X/bkaDdSGrYQNrgWsKu2hkjB0JsfKkAq+n6aOew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XYxGjCci; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NG4WlG0q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523GQgTH031279;
	Mon, 3 Mar 2025 17:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=4rSU11rP3N2rK+RW6+6KelYOsHrpwFWdB/8w+J+8czY=; b=
	XYxGjCciXPB2Oim2JBTw2bTozhInIkZzoAkYgWXE+HlrjmfY/VOfXDS5BdamNC3u
	8uCN+Y0CTUIM9LbqndyNd7bSmfTkF3cAHbFA8NW49FKbfbqI7yru/XKFfcSM3C2W
	rGBUhTAWZ8lMNi6KJbxNj59plIFfbI9ddFa+9Dh1G+Dquyfsda+Zi1l3i1XFR21p
	EaNg98J+CoACXlK5+6/kfAQY+aEFODKCqIrpIbd1kbKYPUnsr9P4zxVHc8x4DxBD
	B7hVGhfWKWqErI6zFNJpZaWlXVC94D8H1pPS6XFeQauC2oBjGXkJgNPXTpy7CSfP
	/sGkWwn2YmGzy73QOQAnHQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u81u5nd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:12:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523GSIkk022516;
	Mon, 3 Mar 2025 17:12:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rwtrcjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:12:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TiwGiIaNRNThDv+qsaWobYoBU20hy7tgFslxo2o++OljebMrQpFubHvUEcYAglhrnqYrfTXY6OvfSihIJUntfUc+Ao3fa/MNlFm1BA0h0r8mSGCZKqNvUMVYefIWDb/RT4hugFCvFtviNeZSGAOcZ70jzhEAkSaLXIDvanSbhMRLiR9mmtyM6r+oGW2uwUx2ehTJa4etl1K89lGhFyXHLWfFiujqVK/d616MdNPj3ShFVxQZlwEpFkwAItzQjhQYyHDN3edf2n+wPGtQMlm5kFbSPKGY/ZNjPB1I/EBVJ4fLhEZg7EwWe7OaiNCrYpunbkkLBOMjlUTorhz3SYTF5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rSU11rP3N2rK+RW6+6KelYOsHrpwFWdB/8w+J+8czY=;
 b=eolRt6k5u8ZIJaNMdwbB5J5A140UxJ+UtEOIrO/NruKb4TwoCqh91QqIgtoFQj3OmTGL+6lQxWIORKH8Obkrtd2CvOqrqE/TCOdTTljAUlusHsGe0izeBoZFCCNl9aIU8TVbHUj0Ecn7N8Lc6Ax/a1aAIO89rmhTtMmm+SuGj3Ihs2RQqleDxX01O2Oo/aZIHXJKSMY8I+woUmc+OaQNXTq3p45E9OXGFAyzFwKf/4Ib98bkEp521H1diUL0Rd/OQm5ucHJ53r9S/P9LfwAxgqmW5VUb/tXyVJJpi/DUwMRdw04gtoZLlYSkqE8ei1VyK2NMjDmx7ioTfJXVO8UgwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rSU11rP3N2rK+RW6+6KelYOsHrpwFWdB/8w+J+8czY=;
 b=NG4WlG0qWmtKIbq6aHelK8axiLx1aH+aFiND8V6P1upkoF54ZBhpUy7cVqTtpm+zmlX+dkB5Ux5pUpCP+EotgN68Vs9hdBc3+RVmW+TEnucu4z3fUchmEX4ZQG0vpy1nyffAxi0SLUThvZjrZzGpzzLKIiJ4MqheCj8P7UF8jv0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4696.namprd10.prod.outlook.com (2603:10b6:510:3d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 3 Mar
 2025 17:12:03 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8489.028; Mon, 3 Mar 2025
 17:12:02 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 09/12] xfs: Add xfs_file_dio_write_atomic()
Date: Mon,  3 Mar 2025 17:11:17 +0000
Message-Id: <20250303171120.2837067-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250303171120.2837067-1-john.g.garry@oracle.com>
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0504.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4696:EE_
X-MS-Office365-Filtering-Correlation-Id: c6562c31-3e9d-4399-4de0-08dd5a768430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?phuE96J7zbErlGe/6/RVsRprR1kNzrT9lPklDtnzECXvgR62UpOh5sCno2mj?=
 =?us-ascii?Q?pM+b9qTcGiJNLYcCRU2sHEUd9DQRjiPoCWMR+HVqF0oQvrQpiAvzCiLBywhx?=
 =?us-ascii?Q?sGBji7C/joQnUkFGW3psNu6mERzKvnmP4c3Rv1nM4PEcRvjeZvGpUvCHIte+?=
 =?us-ascii?Q?KvAPrj3pSJVa+zDnadiJsC2nj/5VyFF8e/T3dU1fqZogy6x298NxZwE1jsqm?=
 =?us-ascii?Q?/S+prToi2DFceX0BpyK1dQ/kidX3dUBZv1h373FgUL22/thv4kb6GUf1Yhev?=
 =?us-ascii?Q?6yCkjkS7rrrVKwfcs/c15de2gtWznmVypd+lGrCAHuRIFjfqPINCFCaag6Jf?=
 =?us-ascii?Q?HSHazf3+cV/0wOIwXAqyL3At3tSTnv/OVWxpKvDgu5PYT5EJqXIyqMlHMDJw?=
 =?us-ascii?Q?fANc463YKYPj7m+irViG4uHrr8PKvayk1Pj6GpdZe+vYN7r7jR22XCL5bqHA?=
 =?us-ascii?Q?wnzxuj7K4R4Y9Q6bkvhiFS0vZyedljPp9s17ZMc04MOqFmitkt84irJW5J+g?=
 =?us-ascii?Q?IgBJNmea3uq+J2ph9D6zieW8NkmMmYfkARku7uXJh9otqgStIalOlYYbxpIr?=
 =?us-ascii?Q?VJ4Bqx6Vd4lufKYAYtQezV5kSM3wQiV1P/JCaYJ2PIW7B+tcI0cB+v8zdCRW?=
 =?us-ascii?Q?HuLn3jJ5slOh4TYI5dP6SjaYnBYG3ClmQXOiSKCCPIM9daCbw8P99kCjYjgH?=
 =?us-ascii?Q?CbSGxnAsDD9MByevmCpGp9g0PahubE/hzI7jQ1BWRFui1raIQG4tF+2toyyQ?=
 =?us-ascii?Q?NHsLn7GyhoP2kaVwJ/Cy8y+xhoSuoDLLf36gR+A8TnBWM6M96wjNipj9dNcm?=
 =?us-ascii?Q?e+XLuuvAPkQqAuk9ZeyrdXjrxIfP5n/cyUmOeWqsyOEuHQYYXToMTMnELnLh?=
 =?us-ascii?Q?uIt0L+xtbHdlIO1dZw6GLrCdJLU3l4Myz1RhT098LVMw4K0aMV0yixRTX8d/?=
 =?us-ascii?Q?HyQml7wHAKzeBTnEKRSoYYfiudmiY0KJbUyMTydrvbBtxKQs4dk8h5viHaYB?=
 =?us-ascii?Q?LXl3D9NoaXNf6pIxiQttQFmu4VMYAfyLvWQ6I5coGRjhIOdcoC11IV4hgKvY?=
 =?us-ascii?Q?Fwaw40kbqDKcrIqTn17dwG75RochaPG/tyVsAir3hwFTOZHOJ6uMyIF+u6Un?=
 =?us-ascii?Q?QjeqMv2yYX9RD8XZw1l3mLiWuyMDdI0qN8DUU4RRGtMBr6t5QmW+2mdNwqQo?=
 =?us-ascii?Q?PYYaM6g7sPmBAGjQF9HTcj7fuSaNN2VEB5kguoNa9xCql93G4EN1o3sA3hDz?=
 =?us-ascii?Q?RZbenE3RW/G17PCre/DOkPyTAVFp9sITFxH683whYWtGMyMueKW9lD1ghmC5?=
 =?us-ascii?Q?6r4HeFXjKl12NX5Ga8dGxFZa9yyw+XM/iRVuKchxH43gyLBmCEiFBu7eeinv?=
 =?us-ascii?Q?221xXhO79G4q6/Sc6XF5WlGRvRBW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ExvLHDHWIdTuJNArC9pBqCRNTSPssEeRQMaS3XeVM5Q/e1BLgkE4FJTktHvb?=
 =?us-ascii?Q?nytnSeu3uX4eotZS8+o0YYPaqnx6eJmo6Nt56dT0QNd5U5YuskvsoWwwWfkA?=
 =?us-ascii?Q?T0CVacK86+AnYZy/0ympToRKxwTEtRkmgPbmguc0B8WX/FJpJLLf7okhGs6N?=
 =?us-ascii?Q?eXJ+HFwIQY4aYOawpLf2U6W5vobe1/mnKQn/zgDPQXoiaieGKiUQWd6FnGLn?=
 =?us-ascii?Q?tMK4SdmCt9Kjhm7WvdxjH78VUR5a22DNf0wmWqVVGX0limyqX4OQvZN0TGCX?=
 =?us-ascii?Q?qJJlXTA053vKbWVcwhtJO1DFjLZviJFd/M5bSFX4AxqzUthIj8eCyEIH6/xv?=
 =?us-ascii?Q?Gae8JyaoA1Nue50w+g+1Feo+c6ZA1fSxS9bQfn9g6LUhhpOr5xDMtmN182lG?=
 =?us-ascii?Q?i0aMJcTF3p1AuXQbe8TlhzOlCw4zPCVWCdm4V2hL307vxqFvjkBoFbflQb2O?=
 =?us-ascii?Q?RapCSGbHhcqEgml5MjcJ3vPMZ5OaaPBMDOVUHUjdL7Ui2ZYXz7V2QCAewkFC?=
 =?us-ascii?Q?N18bR6xCg7ca1rxcrJUWyQqBdzZekirIPZst8Q9N75r7d2kmXZIj/jQiQtwh?=
 =?us-ascii?Q?kcJ1CjyXBQ0in4JoPjkn7OdkIEToXyUNZfDqHqwny//wsBnfcdmmkCCzpBlm?=
 =?us-ascii?Q?ESwVm+AmEcz9nvqfxIuKkIpOOUmF9hCQeQvm8cjuDQXIfTlEN62FX1J/dMjs?=
 =?us-ascii?Q?BCEg4fYCk0rtTwTWfn8IH5VFN/TChJCmceWVigirnlr5BFq66K1Q5HRPEA3k?=
 =?us-ascii?Q?SOfXWXcE87BmnqRERLPRA6O4RYECm+XBk4LoEUealUX+1YgcZOVR4ELwO4km?=
 =?us-ascii?Q?xjE6WafdE2vfiolDYM/qug09cQdinsv6y8lLzwaubbiwgY3H/KJ3lDtPYv2g?=
 =?us-ascii?Q?kAYlijCXcsDVessvkqsx56oXtYKD1pK+5beOnM1PjPYalDasXZ9hZrd3zqb3?=
 =?us-ascii?Q?T1mqbLBJlYXSgvHtGyg9n/bqvpAD1VCBp3uox3lKILHNp1qBfV5cd7KuPw0i?=
 =?us-ascii?Q?FLXDV4Q5HXLeVVcLiNZt90+CkuFsDM5wjIA/UuC8NguMmWRgR7SP9BYdtX3Y?=
 =?us-ascii?Q?f52CKCgez+KjPZuMGJDDyXitZz7zOoOhTPEIB6ngqyI2cX7OBOStTv25c8PV?=
 =?us-ascii?Q?fw1n4T4grdAvzw3ZnNKIJhNp4oAT8BEEpvJHWz46Naxj44UmBKd7miX+Db6L?=
 =?us-ascii?Q?N3TiUVNXQdf8opAD3Ets8pWUvQof79Wh3u4bWBHJpoEvv9E6XEs2x5EiR7s/?=
 =?us-ascii?Q?ohVCVJhXTExGbCuXyhWAZH/hx8soY+7Tcjjwm91Hb+/cLZiiVuerZHQ4qU1f?=
 =?us-ascii?Q?hjB9j/kT93oSkLJ672v57HMF5Ekn6LemzquB1dObQBxIDTi5qF3rzz7eMucJ?=
 =?us-ascii?Q?nj9t8KShhP5Ij7GCSbNCDPakJ2eqV5663BHdrjB3AA+IhZ5BjZDs10axTyGG?=
 =?us-ascii?Q?tXzJKjnf5ggZ6+3Imloi0zF1/W1zg2JT9JIEj1yXUjjGQvzZLBI6u86Qlpqe?=
 =?us-ascii?Q?Ei9cJ66DWfxstlve+ZNcKG90WIFJ0nkdVGEvTn5IhUc0FN/+rEHOo7+f8qsR?=
 =?us-ascii?Q?G668d6FzntioZrVOZfwiHf4DCEe+FR2/nLP/HbSgoPfTJz1No/0HZ6740NSp?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LFJ383rqqDINxFJHrDDhiaf3ifuQnyyCSbH3Ireg7rQXKfqef31sjRZ6d7tJ/p9AB/Rf9IBgxtALUJkP2pcrtuykeSJWMGOLK/i83nk91q/TNCfmDhivdGYiUnEEVs+1vMoRMcnMqyj89DvySRzci5PgjDBgcXAcQwiOmgs1A6cqA5yNWLPHlwA3E7pJZkiyvIWS3ic0nhuAXgpkvuwOPcxT9Q9dlfqg9nlVbbSpIAvDBDl+gbV+0/cFvb4Ce8WyO9X7wUfEYAZbUPvT5wYSWlETEoBTdxLyClNf8MVD5GxW9R2j6U/Gvrs3cdxLS2za9oT7xjOv1RoMcwXeTDfyuC4rXioqCmdbirNaQI/H1VyHkjaKwcXGe+fSKxyPGYSMhRjQDgaNxN6Ax6x4ad37rSQfB9tPsnXeWa+V4mcrDVm43AyJ5YjT0vwfbu2bdmWzexODL9zmEOc6BVtpDrQvTeC8zL3ddDuD5wGoyW9pDR496lvBYMEUQ4zHCsvbLofiWLCWJWNMGoZimh5WVqUQjY9SyFZqL//Sq0kR9S5CSG6YiQMQKuUCUaFEcFGqCOK86BWSeF5EDiP435m1ZrSNzXEHs6yscaukTeeLA+Qgp+0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6562c31-3e9d-4399-4de0-08dd5a768430
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:12:02.9108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTnHIGS+Qivy99jBoMahAag5c3JBGthIj/2BE9X+aW4XFIenIH1d7wulaj7jVcGXmFsquPwK0WimciqKVlvTyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_08,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503030131
X-Proofpoint-GUID: NO2_9ZSvFBCSM7dr9F8EYP9J2oU3rRqH
X-Proofpoint-ORIG-GUID: NO2_9ZSvFBCSM7dr9F8EYP9J2oU3rRqH

Add xfs_file_dio_write_atomic() for dedicated handling of atomic writes.

In case of -EAGAIN being returned from iomap_dio_rw(), reissue the write
in CoW-based atomic write mode.

For CoW-based mode, ensure that we have no outstanding IOs which we
may trample on.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 51b4a43d15f3..70eb6928cf63 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -619,6 +619,46 @@ xfs_file_dio_write_aligned(
 	return ret;
 }
 
+static noinline ssize_t
+xfs_file_dio_write_atomic(
+	struct xfs_inode	*ip,
+	struct kiocb		*iocb,
+	struct iov_iter		*from)
+{
+	unsigned int		iolock = XFS_IOLOCK_SHARED;
+	unsigned int		dio_flags = 0;
+	ssize_t			ret;
+
+retry:
+	ret = xfs_ilock_iocb_for_write(iocb, &iolock);
+	if (ret)
+		return ret;
+
+	ret = xfs_file_write_checks(iocb, from, &iolock);
+	if (ret)
+		goto out_unlock;
+
+	if (dio_flags & IOMAP_DIO_FORCE_WAIT)
+		inode_dio_wait(VFS_I(ip));
+
+	trace_xfs_file_direct_write(iocb, from);
+	ret = iomap_dio_rw(iocb, from, &xfs_atomic_write_iomap_ops,
+			&xfs_dio_write_ops, dio_flags, NULL, 0);
+
+	if (ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT) &&
+	    !(dio_flags & IOMAP_DIO_ATOMIC_SW)) {
+		xfs_iunlock(ip, iolock);
+		dio_flags = IOMAP_DIO_ATOMIC_SW | IOMAP_DIO_FORCE_WAIT;
+		iolock = XFS_IOLOCK_EXCL;
+		goto retry;
+	}
+
+out_unlock:
+	if (iolock)
+		xfs_iunlock(ip, iolock);
+	return ret;
+}
+
 /*
  * Handle block unaligned direct I/O writes
  *
@@ -723,6 +763,8 @@ xfs_file_dio_write(
 		return -EINVAL;
 	if ((iocb->ki_pos | count) & ip->i_mount->m_blockmask)
 		return xfs_file_dio_write_unaligned(ip, iocb, from);
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		return xfs_file_dio_write_atomic(ip, iocb, from);
 	return xfs_file_dio_write_aligned(ip, iocb, from);
 }
 
-- 
2.31.1


