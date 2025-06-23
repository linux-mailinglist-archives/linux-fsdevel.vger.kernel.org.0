Return-Path: <linux-fsdevel+bounces-52608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1265AE4808
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 17:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7F316B06C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 15:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475BD275B0E;
	Mon, 23 Jun 2025 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A72MrMHl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jzSsQo0Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1660019D88F;
	Mon, 23 Jun 2025 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691380; cv=fail; b=lOEU0FuLNs2XgHlncQGmiL4erZtaAHE7521Y767ODzDLIfyGASrgffrLYCXl3gKEfu0WWaIs6awFRLNPS9firVJ9WWFqB+SG6hcMgo0G4psu398FvXQk2beqSZoJTeNgku7y0E1hcqK00qrfLxVxm6pdJYgHGh6XOWad9wAzM5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691380; c=relaxed/simple;
	bh=IAmHvTa8jIJknWvFN502v+n3Ejq3lYxG5MAY6Eg1EVE=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=b1eBuSYB7QvDeMh7qQPU/dFx/qbqSjeYaF6yDuMFxCfdd+19IPdzDeBzFjFf2mdcE5Uod7mLqcavONtbzAgpHTA8SR1PGrV5uAYS9WtUFrciUC7mQc/aojHrwvcA9Z/PItLD3inTwl/jSbsbrn1/yCuTmd3Nx67HEWi6G6JorGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A72MrMHl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jzSsQo0Z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NCif7Q000599;
	Mon, 23 Jun 2025 15:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Q+yBXUFzovhIu0jnXV
	mopIZi/MUBUBOKqhAnbRPXwe8=; b=A72MrMHlcbOmOV+nobTKCioH9LaI/fgDJv
	ELNT4uysD8iwv1GOrOsSymH1woau69h7HoEFK6qyDBNQhwhVtMesQomCeFJcNhCu
	pIAMjeBV5NyBMP+T4M4izbgGjxZ6jWxtHGhsNvU2olSmP25J8hjBfvPAUW5oGxhO
	M9w2YEA1+TEMnMHGrxY91SU7X6kT/iy/MVZe7olfFs9TZ2B/4nLbtoquFOMLRAuJ
	7z7tA4u95pGysAFO6y04av0Un1k3kYBnh25D9JUUHe2PZ4h3NydcMC3EnnA4oxIv
	DLxxWI1zStqVWAGZG6ga8kwn7KzpWDKP1CWv3ZYuTjVKeHcQvJ1A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds7utyau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 15:08:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55NE00Ul030458;
	Mon, 23 Jun 2025 15:08:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehpny769-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 15:08:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBPRCvAjUd0O5cCOuBpQzUVe6OZl7l4HUZ/+xAeM+USvx0R8RQEYJy77u9iXpHKgVR8dBX1XSK4Zdxl7qBo3xLV9cy+rsgRpzFmkAdU7Jpn943cRWyLCUpQSIaeqKXCkGMImtq+C27D0qHeIrbqCxYEr9AV1rZa7DHxTZeqX3IXNNNqpNckHRAGV8MuEPF4qPEvfmbegkjL4p7lzN2dfA6zDnyHjAGpia73q8Onhc9LqB9NZD8LC/ygEZTuqmCvT8FNhZNAz9+8xJBT0ctAyi78fLWqDgg7sOstA3YoZE9KQfyAw48DiiSorbne+CX4yF/AqxaQSwi7gu9Rh3RfaCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+yBXUFzovhIu0jnXVmopIZi/MUBUBOKqhAnbRPXwe8=;
 b=u/10pFSavymCpTWzLX/99+sdAxxLwuCWg3m23suCis7DA7kPcu6tCG/Fk+DfXAEvYmxFKUM1WJpFx252EO8787roYhALtA4zbV5bw+abf9KGuXjJrLYPRCohz/B1E1Rz7qwGyNmLHz8hnD90MuordglJwSkZTZQ5KVF/ETajyJhW2NwyxfiPy/9Lf0nD17xS9FvdE+DCeqClQc+iBx7KuqlN4pAWws3VhkMttlG8PqtLi725pUR0tW1RbnAYdIOX2JRhYi1iRgbGjhw+bnz/p6IUcZWi3xAQAkSJPymogsMGoOplt4h6Sc7xGt6KiKoe46x3vvceK7w3HjNJMZnsQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+yBXUFzovhIu0jnXVmopIZi/MUBUBOKqhAnbRPXwe8=;
 b=jzSsQo0ZtHjzL1XQOiFs6n1t+oseeVnjheGcbpDMYHZjIJdtTUuOcAWNGkS7QrFAEESmPjVGmtsmki71cpSsliwz/peeFvLGanaFFRDl7ZLDrIuAzpXSXlw+RZx8ndr1lqlDA14FlXjEjwRGkPAlxn44qrDHqthkw7CEyoIBebs=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by DS0PR10MB6127.namprd10.prod.outlook.com (2603:10b6:8:c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Mon, 23 Jun
 2025 15:08:44 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%7]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 15:08:44 +0000
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
        tytso@mit.edu, djwong@kernel.org, john.g.garry@oracle.com,
        bmarzins@redhat.com, chaitanyak@nvidia.com,
        shinichiro.kawasaki@wdc.com, brauner@kernel.org,
        martin.petersen@oracle.com, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 0/9] fallocate: introduce FALLOC_FL_WRITE_ZEROES flag
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250619111806.3546162-1-yi.zhang@huaweicloud.com> (Zhang Yi's
	message of "Thu, 19 Jun 2025 19:17:57 +0800")
Organization: Oracle Corporation
Message-ID: <yq11praqywi.fsf@ca-mkp.ca.oracle.com>
References: <20250619111806.3546162-1-yi.zhang@huaweicloud.com>
Date: Mon, 23 Jun 2025 11:08:39 -0400
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0395.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::23) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|DS0PR10MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: 386f83b5-ba01-48b6-95fb-08ddb267d83b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z/U1wxC2Sa5EcASl9gAwH0R/2O6y1NztjfNlmMmGTs+/nKnk4Ggkh/BM5IAT?=
 =?us-ascii?Q?Y4Cyyk1Lq7xwAKhqeR1lI0ThcjP0SJnyaF5hxsEPUnpCv38xVMwypIuwkMtl?=
 =?us-ascii?Q?NZ914wn7XUGhN57rLgZGm05QCps0XrAHmuEKwOrIXobjNdCnTXyZ5Sv1Ia9i?=
 =?us-ascii?Q?lVaIfLnM6V8fhk0wNVRU3luR75eI3kz+EirBeF2tia4/CEYL9F8mlxCqM3oA?=
 =?us-ascii?Q?q3x22HkYv5FwyoewUcN9gffdQ+cYXAZsPA22n9Z0Ytx2M/X+CzCPNzm35KKq?=
 =?us-ascii?Q?hLH7wyUHBYRGG0oCTKbJREXiX9Dd0plVDfxjBzepA5eZhmbMOeOJRxilJPis?=
 =?us-ascii?Q?SBAaRGeF4/reZJPs6tYkWMJQe77D2FgLobuTavh2cHhJFxzIC/x0YHBtfTsK?=
 =?us-ascii?Q?8Sx9AFWeEHznjkbdT/dZjfvtUPsg3DWwIYdGl5JwY2gWhcQYKsFcpe9UUooM?=
 =?us-ascii?Q?lmituIZM7TVLphkoQw35mPzt1XN/E5gGXKMFicioOf2YoIZ2QDudL3GSW524?=
 =?us-ascii?Q?f8bAFWgu+2Fq6yXrBL7UgKOvLuLTfOv+Hbpl4KvmYaxpo7VIqa1RNsc2qeIG?=
 =?us-ascii?Q?fH6+MIG5MWrpY+aeRLeS3VjhnCZNZLdyzu+NaW4h1sGlWHCmhUVng4FyOPFN?=
 =?us-ascii?Q?GkzFrrcu22XpS4K0U6ojloOywWKOTy0lniFyoHHz8fMUn12KHsO2gf1qbBcb?=
 =?us-ascii?Q?JrMQxOj9ZDHA79016DEpwnAlELddavTKyr+j2v/4W7xk0UWh+F8Ad10CHGvm?=
 =?us-ascii?Q?8X7M8xpcKwe0WihD0HKdRyJdN4Lx/+1YYeGC6pJZNbuPG27/WUtEQIwLtwIb?=
 =?us-ascii?Q?I6qkynARKNONrBVR6yqewr78FHxTlXf6Myy40WNao3sv9QyF9truZpVgXhnD?=
 =?us-ascii?Q?1HHKuSKKM4oMQyAj1frpxaoddGvF/hRq+9VplkKKfTNVJLFYoGNNKzuXwRaX?=
 =?us-ascii?Q?EeXXJxgm0KhMzZfjgzVW/Co+MDgbdPTPinheFd7lktr4XAuvU1seWdZhXb21?=
 =?us-ascii?Q?aGI2eWoAAiF2oy3KfGvk2gkn+pOs95QYAB/L7gvbvzMWFJODG4p8N/pvF1Ou?=
 =?us-ascii?Q?LbR2z0Z45cN/0jVlC4WX03nQ88zL7GcFcF0sj7MxficlZ0eZ35h+IjrZqSk2?=
 =?us-ascii?Q?Fdl5Ri/4/TH+nBAIJay3688GA/WqFnlI6OUqoEbOOq/qe1l+TKuh9c2SN5G7?=
 =?us-ascii?Q?C1fr5dhUe5kDzUFyL8OU0c7+HSnNxROUhFYxjaoekxZf4L4l9bJzshDvkdPi?=
 =?us-ascii?Q?Sh0XbjIEsjEEnFLi4bi35xW6NChoA3zhlP7cqrAAH408ZpAGzhmrcz+G6cwm?=
 =?us-ascii?Q?aA1mNMFOYRKUn/L91fFRbp14+iYNHfi9w9oivVAlU9uAPNjYy8R2Yidp33GQ?=
 =?us-ascii?Q?Dcs0xfYc/6eKu9Df5g7kVgx8ktQSGjSl+Vuqf3g+HRGWM0ipgqHl/bKz2Z2F?=
 =?us-ascii?Q?cuXAdwQvq2A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H1xMPqRgbuQP/YT6+eWR7+GquPQ+F+2PSMRO3RLL7NBsS6L2hkePD/SiQM29?=
 =?us-ascii?Q?U7TWkZbYxWmH628D0K45koaILIRmNkpjetTAGfBNA5LvVA2C5n1hU7mvwuIT?=
 =?us-ascii?Q?imNpaXmfseVRVuxWOMnZwEjkdDhc8ER8CLhP81uN7dPPWR0cdhZMXwxYnCVa?=
 =?us-ascii?Q?qetjaxwEvZUe08A+Q4s2u6R99WlIPaPXVjinPolfyEWspu4yPfC/723x0Nyz?=
 =?us-ascii?Q?rFjUSAxQmk9igdL1O29vaNI73ydUnstAml5+WEU+Ag5D8CbPEjoXCwFVkWEM?=
 =?us-ascii?Q?AKQWM2qWaxzic1PfJeFMKMSNjWPPykNmcarJPDR7XJwAOOfm3GvzjmYUFM5d?=
 =?us-ascii?Q?Uvbl4KEA6o1CoXT1v1cMI92Q2atblgunxv892atLKj/hTkdqqwuPJmYNEmFl?=
 =?us-ascii?Q?XF716bDTrI2UqZrGvrxOHFKNd0NU4PKnZ1mlyAoB+UcMF+4x4Bez9YgHEZlc?=
 =?us-ascii?Q?/LTCp7P61e+ZrHRt7I7gPJo34ru8Nn4Oo21E2J2mnx2zIqVK+siwjwmzaMlV?=
 =?us-ascii?Q?r0Q5KoXvoaHq1/Phxvq86B1BPhBmVZ6w1jQsmOSl9xfPoL9Dw+wgdkFWDsIp?=
 =?us-ascii?Q?RuXyBIQ8m8is8gvFauWKHLSjgk7OhBoyyVbX/YjgmRFsbZSwmLEsSvUBCvU8?=
 =?us-ascii?Q?lDG67LsNU1FqeTer1JZ1ylKhH9u0TS0En396IWzbQgOjtmsUeOkkQa9rGjmk?=
 =?us-ascii?Q?Q2rK5IM4Lm3cpuYVCyKvx26ybHkdPIKnlTJkNIyr269JRGLqAw1Ii4AolGDF?=
 =?us-ascii?Q?vgKmcK08pIIEarMkbKbZgOQ6FrGnYa5fRvIDqxsGU5zjR0RRpWHOq4wrLk+y?=
 =?us-ascii?Q?T/bPHhiM6IlSt3ToKD6hb7GkRFQv0BgJsmsc5a+dAp1MdKz/arLpss1PS93a?=
 =?us-ascii?Q?Xl6Is9ekfcgJT2MozXYvYe2GPvbbzKoHy1ey8CU0c7cxj+25Kt208jmzhxMS?=
 =?us-ascii?Q?g3+ARIeLaVG3ovY1V/lhuVPRHBrnr38QlUq9u6JdZZonmP3XN25AAfO5OtN2?=
 =?us-ascii?Q?h4kvnNEwkzd29rsR30D/z0vTyUytJaYvkOrqCLkFvuNSSH9hJ8C4NT+Of1T1?=
 =?us-ascii?Q?8Ufzft9TdO9ebOptUnuXjL2PgxpgJQhvMWAmlhE1kJEKvfexWiuyjrdbwKEQ?=
 =?us-ascii?Q?ggFsni1BS6R6aKJjxQYQQiTo1aE/Nlr2JREHF79QRG3Is6R3+jyTFpE3v5rC?=
 =?us-ascii?Q?Rlnof5pFahwNyDFxXgBSsO4mfrKJGbufaW0QdJr+A/zEV4b90dwMF99NkLsP?=
 =?us-ascii?Q?sDSRYder1eom6uplOuVzEutB08m2Y4n9lCDVXqaAQzAPiZ0TDjrn0zFnBH5p?=
 =?us-ascii?Q?qps2sW8IIkaW1ZqcrEOxTJilSZORzXKk8w8j/0SThgrgy+97W2uRQoi3vMHJ?=
 =?us-ascii?Q?5W+vAW5R4iPoDxnb22CwMW0CX8AKVmK2yBgwMRh9VZvAIyWtm6XA8sB6/1Z7?=
 =?us-ascii?Q?US4+O8IlpbdkRjYOG4c/HPsa7GByrUar2n1vp/YxNXhdFE/cAl5zyXOyBbD7?=
 =?us-ascii?Q?GTtrILEC8iTIT+cCRB5WNm9kIKR4vv4/r35+oy8Q8v3HSzlEXiaTXMZCHSJr?=
 =?us-ascii?Q?dn3DAtftwUp4b1G4FCeLJONSwgX3wlL826SySSEooOvQnCTNInpVvuSDOhh2?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bOaaySy81pQfxnvM3BHWsty7GSMBg+YbDDENn2pTaUpLjAAUxCuEDGgqwmkXc/wbpxbtRY52RLG8WobG9LU9v0pm1PGVgANlD82iRPx8V5deGKOZSnAC9dHp+bx2TOjoTcAajVmFMxHvUpAHJGUAB727rBrzjk1ojAexiNzFdG7GJcT9JKvsMudhVpr0/JbKg7OYHI2crclQL2jk1mg9XSn9+AGgs8XLlPIwhtPWPLdobmbUWWe8cZhvqart3SKiYfXHVuWd8qvO4SMyV1mi8/wBZguLEnJmyiXKD6IyZB6O8uEY2ueVNH4GV01bcIVhtcC7cYgamQ1oa9fA8m6VcQZ0xUi3mkERCCOg73AfElha/NxvQOw2Cd45VmEASN/1a7SJlDXY94YQtyowbKYiMgLh6oY/lwGiTRs3zZTXcl9JX9Q3hqBeHrQokBO6+ibk5BAF5DOWu/vXvaJCbdSzXi/8bL1bRMMAxs7Ga+XUq/780YgT2imir0SUzDjW9JZttBEcn6pOM976/g7vY5BC4jtvN6gQGQf31vp0IWKSZ6L+Pm8o+DsZ4mqvkVEZDmRd7OXjTpsjPBg0qUtTY9thZe2/UK7eRypogrK5YnCPDWw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 386f83b5-ba01-48b6-95fb-08ddb267d83b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 15:08:43.9913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +4zM5hBGKH1NefqFr2ATHD+ee+V21eaGVJbHQt0pGFyHgYYfsopmYoHBJXx5lqU80Fpv7HcIHHGGWege2wNW1lN0zuu/Jys1XT8A2A9vczM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6127
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_06,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506230091
X-Proofpoint-GUID: iyZadHnYZxb-3VctwkP4GMMPOBstXJxO
X-Authority-Analysis: v=2.4 cv=CeII5Krl c=1 sm=1 tr=0 ts=68596e0b cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=E6iHuNZNvKiyW3IvHZQA:9
X-Proofpoint-ORIG-GUID: iyZadHnYZxb-3VctwkP4GMMPOBstXJxO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA5MSBTYWx0ZWRfX1WxCikt0K/3p nPTfUTyPmI+k0Wc5DHomYiLwT1BgHAL/Utw++uJJYB6HgCFF78CGgveS+QFVGuJDCN1iVummUWO YNNgxCqjSuK99TIVmKl4L6Qni4kDr7LRCWkvWlCKXUxz8+Er21Kvd9yhlWI4tzdOvjmVJ1Og6kL
 MdMlPBbfRRIlACKINvJQDwFiAxOP7XEK2v+WriUBc50XNRHpph36dMSym29/Tzi2hYTtXQREwX3 hwbYsMsJl9Cvj3SM2GJD2HynTlBN8qh+k3OADls0o38SF67VM5E8O93wyHYCsBopnnXNITY3jfn PSHF+wp8rgzdzen5NDJ1FKwr+XUMsqxNYCKAro/4TYLwe5T3QVoiJaLAevEcOn3p5owzKa9dPOO
 3o7RKN6wG0RYYT9cXBOhJlGslUnQrH2gbWOeqO7gbEnrHEXTuQsYT3PLhax4IDfqfTVf12Gx


Zhang,

> This series implements the BLK_FEAT_WRITE_ZEROES_UNMAP feature and
> BLK_FLAG_WRITE_ZEROES_UNMAP_DISABLED flag for SCSI, NVMe and
> device-mapper drivers, and add the FALLOC_FL_WRITE_ZEROES and
> STATX_ATTR_WRITE_ZEROES_UNMAP support for ext4 and raw bdev devices.
> Any comments are welcome.

This looks OK to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

