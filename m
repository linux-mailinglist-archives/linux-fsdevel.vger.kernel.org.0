Return-Path: <linux-fsdevel+bounces-41649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F776A340FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 14:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EDA8188E3B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 13:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39104242934;
	Thu, 13 Feb 2025 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lvQnaUOx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p+mKzvuD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8232222BB;
	Thu, 13 Feb 2025 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455041; cv=fail; b=svvPbFTqLsb9NB1jfD1ZPxTICctqKs4NiPTIDTXZHGyL5RqfRQ1ssjDJFqQpahCxJ9oZwVGqKp1F4qWS/jzRfd2bougFUBMzU4ecm+rs0dnZ/Ts4j8G1wm+Jm0+6wL/iuFdmiZE92FDMLqfR7YrdIeq8XoKukjndCVz9AcUElik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455041; c=relaxed/simple;
	bh=WP7/f3t9TwAih0x83rp6NsvXttTjrbkh3FXScWfpX14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qr3nCLFZ7ccv95Tmh0nKVHShQOcgk355RwUX3IkCHj2IJdwWFej2BpEPAzbROn/dZhJZJ3gUq+XXHR2yh2x1yJrTXVAtf+DTz/lZ+IjoGneM7HY1WoRlAZe4G6IrdESiwIFsRt2xo0vESe/2tljuNw9d4Mt8EI65J6WaEXjlJ8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lvQnaUOx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p+mKzvuD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8fVdv022161;
	Thu, 13 Feb 2025 13:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mI3SkHvrxsz1MDYjszzGkm5zZ7e3wl8ZkkvNg8JdNZQ=; b=
	lvQnaUOxb2WrYWxaBqXEooliuNe0w1ueYhHQQlgHHpUund2tM2YvZD0HmnLY4o8I
	j1BaKUcZH8CWiaH5G11j+2dULQdM20hh9jxZVRc6PHemjNyu9+sv5m9m2nhdkeZb
	a5gjTV+/ak5nPaCkkW/eBEQsHD3NzTp3vTGc6Ygh1fmKxzYv3TINwTmD8NqMK/QU
	9x6Bq+sqlLS1166kAWMjnrrU2H5w7LRd9/Nih3OZnjqzHOXlnGo8AmeD5+InTKPY
	yGfdxpxKYq7cTLNL2HkDLyuFTvybWa00KdkyZIrMuJ2uHLREAWCfG9iDDV6oaTuP
	EnYZZb3p9tVqKW0pGT7HGA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0sq9sk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 13:57:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DDY8Ap026949;
	Thu, 13 Feb 2025 13:57:08 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqbprav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 13:57:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVG6P58y7QlY9ScG/nlTDcVu/WHlWKTrEcIO5DR4hNVguFTiYfAfU1wa5mCeNoEx/ak+HBZANcdyJiTwTHM5Al9KYrsrjWkOqdNWBcyGXaZW1jVoM9qqxFi7b0Bp18CGvB4Ttqq0VI6R1J/g7cmaKzFOo8nEyxb6kJAR3rPl+caNmHoxL6cozgY3WdkcgK3RzJFqJT522vuQvjVhtg8HqsKhbrRP+c8TvCaTMG7YmopT8KOHSSVoDsOBM4TGxVvJliM0+QLkT3DqS1AeOVs3hEa3TwlC8wcijeWiAs6TOGe5jXlDTzrFkmjGkHEnHPJTR4LbAkf0zwXFGMkSyjV5mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mI3SkHvrxsz1MDYjszzGkm5zZ7e3wl8ZkkvNg8JdNZQ=;
 b=BvzCJqXSNK8yWa/g16uXBVwCcs3BroiyLLe9jOA3EY8Jc7MxK/JOkXQm3XXyA9cWc6K/qoCmPgs7yQKcdQbv3UMO74r+YsRF7+IQa9tyI4dmrEEObksmfbQszblHgPHYRveSbmj0SB69DZIqcIyPeMpP/gVPVETVLabgWRbB1hwVigb0yw+o3pGSJ3GEhMA8FwComm57U0Jj0Dlx8e0CfXjGU3Hcdngl005QIihK9+0ExBsTjzkvug6qffLHbrqpBEux4R2DgI3gJnBA+yhnU7Qy/uKa1TK2IRNjkCO8in8WNoYnRKzi3epuIzamfPnifeRUearKNBPzgTq08UUgZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mI3SkHvrxsz1MDYjszzGkm5zZ7e3wl8ZkkvNg8JdNZQ=;
 b=p+mKzvuDq3dppvBHCWHwqUxi3jAYtSbDGD1tjzigg4HQXLmGd0ZsNScHBePOEdTq7wfc2R2bIBVtz0vpHBknlK+wBqmwo4bB36Cgzz4mmxEEF5/4e2xW8mKJChFQ03pp8KuFzb+2ftSPfo4x/Y5EjEYUXHt6UbsOxeqYKvdZ2yA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7125.namprd10.prod.outlook.com (2603:10b6:8:f0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Thu, 13 Feb 2025 13:57:05 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 13:57:05 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 04/11] iomap: Support CoW-based atomic writes
Date: Thu, 13 Feb 2025 13:56:12 +0000
Message-Id: <20250213135619.1148432-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250213135619.1148432-1-john.g.garry@oracle.com>
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:408:141::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 5794d828-2e6a-49fb-7699-08dd4c364cce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tqOgPDzcHQlMW05tixITwOjLwyhcQvGLwuMF+fqertYqE9NzCq2kDh488L/x?=
 =?us-ascii?Q?r0tmiyjEHmU2bwrNfWWjEo7CyJnLHClzjOLc7Nly3z2nLrBY9by7URdLczy/?=
 =?us-ascii?Q?HrI6WBBfoMLYN+ow7wnmW/a3agDCA7IDfHqcJVg6mJnVp/518WCGg9yeiQ1E?=
 =?us-ascii?Q?jMNVHHiafRsqIvZSEIL6HbIf4x+q/JTcAuVVYoIEY5KIzeUvs4EUD8Wa440r?=
 =?us-ascii?Q?R9uH4u6skRl/TpDYvUMv+N6abSIVoK8N2z/hBYHLDtH2+PP7KmFBz0qWoakJ?=
 =?us-ascii?Q?AXD2412Oqzl7WgDYXERUSQwtIyu0Xt7HegBlksSlzOXryYY94s139tkDPvG2?=
 =?us-ascii?Q?sF9K4+sKxo+vDpCtdxwOI8iPE3w22mHsJOZPn4n3KPxxqWEnxcibfpnsdeOd?=
 =?us-ascii?Q?Ol5Fqc95FRs3SBttthjz23/yE3bR+Jk3U5ByS9JrZDhypiabw3p5+FtMte20?=
 =?us-ascii?Q?IntAYuzMIHKMX29Hn86rZVx2GpMrLv763VSNx2D0kmtC2Bcr92mcbXBkdcm7?=
 =?us-ascii?Q?At1EA3lAOWPbosIyLbsp5nL8KQDmROtHsx4AUxAY6zh8A+cwqfd75N6sfXIE?=
 =?us-ascii?Q?3DSDQHGEQFx9nVF93GijKevrbF4Gxi4fRzKDAm2mMdTZ7oTk7L92vHPg56L0?=
 =?us-ascii?Q?BVis/lBXnG3I62NCid/+yzlBrReE5gMP68S90Flhd+yP8vkzYAx57yq8wd4G?=
 =?us-ascii?Q?+6wK6Ymwh3NgLZ/d5DbjBdkQNoTiup3iTb1P5YwTXYEQh49xj4wKTEoKxwcC?=
 =?us-ascii?Q?5FB1ylSIE9oR/xJDAw89xbr433VKCLs0p4q5wcNXvlzslDWtr4m56WHj7bxq?=
 =?us-ascii?Q?YX5kD6GlbHoAQRrwVE4yTUSNyvcziAEFvvakcbauPOomj5foDmlhWo0rciJE?=
 =?us-ascii?Q?FwLS4aaUdGm/zztBtkIpc8ysElIaN3apD7i6zTbc3sWCgB6MROKoi/VNvPiN?=
 =?us-ascii?Q?1QgFlZJtxWm+zLPlbQsfKdKs3YxTByMQBYs4VFSMqMzQG6J8/0JoGI0fo8oa?=
 =?us-ascii?Q?OQs3ClWIzq0GqFwOVu6Es0LDswvfoUnbvpjUimMpbxZ5r4xlpSHhYwpve58w?=
 =?us-ascii?Q?MgVF9hCeSrypObFiTWG4YUEzlcD7FfZ/sR+PxUXlz4V6wOH6V7HSSS1YjR93?=
 =?us-ascii?Q?z798Ki5SZQugTL2f4IaxlAlOdf0mxVCApbv8ROvNiKkym0R77YrxUzcJ0ovk?=
 =?us-ascii?Q?jrgEMS/UX8Lo5xnQ8/i4UUaTaulj4knQfBv9rzqUOmovZz6aGms/Z6qut/HS?=
 =?us-ascii?Q?df8M0xnsXK00NrwUbbZCvcMWP42yMhJ4QZoMKjjtHytdx6KdkoA6bhpk3Lb0?=
 =?us-ascii?Q?Zkg3aIO5TiW5GxQQI/U84wpolH0+Fl33cY5bztGQTKu+VZBqj4tYkLnBpcTk?=
 =?us-ascii?Q?iB82lnesjcaiF00BYTAPHAYvkVDE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rSc6YuqFSTM7EH8VQ4KrrXBcBji99orF7h2QIQmCnT3cEsP7KbtrHzDKPEOI?=
 =?us-ascii?Q?SCR6YMSKe3LKHAJDZ9wekQjaC///QNBHtXkkho6KgEVph/yxieKMf5v2Iwso?=
 =?us-ascii?Q?YVUku+YNB9HnMfv44+HEKW8tCrATypJzwozQe5fKtV8JVA3MGJNVhcWPD2oi?=
 =?us-ascii?Q?mV+2w93e9ZNWUgtIg5ymE+FuuVQpTXXG1m3A0YSXSJps0t9XqM1J3MTnOPQ4?=
 =?us-ascii?Q?jjQ+gro1T5eHQfcnE8JO1OkW+RLwAv1U7pRFNdIkPxAQxhRjbmC5G3HGeeOf?=
 =?us-ascii?Q?7J1qcxnGfnvJuOvuUAWddu4RRRCPRB81gWyqAjqeF9CMA3r/qBpAon1rENxc?=
 =?us-ascii?Q?dvUf7/T37PlDnohGfQoA4QSpN1WucZAU1GH0RFP0sO+WjyeRumM0jN9YL7N4?=
 =?us-ascii?Q?2905sx6/IZobsQCKRxN0j/OsRlSL28RgAGoJoONV0OXPem70XhyaNDXBmqN4?=
 =?us-ascii?Q?WA5FECOW1hs1Tl3oZbc6B/Eu34ZxM5vCpBz21P0Gz+H3LyWguWjdj4h7pZak?=
 =?us-ascii?Q?CqndjmLN81lllq1mLN8yLVCt5tQi0456O0Nzecz8XXYUxQ/6GvBmMb2zoWKL?=
 =?us-ascii?Q?FVkb3DH5YAkbLAkWNJqCyRlNohUz3UC5Z8B3WUB0K/J8xhPOSDOH+ZGqtQJd?=
 =?us-ascii?Q?VM426kw9OUhkEsHFcmvlK/AtJmsGri142XXYaFxnQSustLtovuRfniyx/oNc?=
 =?us-ascii?Q?b0Tp7rRHqSlPbDytmf+h2VCkcCL82uU8cfuYQxTZL/9JoK0z8zJM8bRiTpOJ?=
 =?us-ascii?Q?BZZcx7WqCHTuPwW27ygtQ0W/8vTYZuJIBz89WYigtiF+dqce5qVLWzXwHPCx?=
 =?us-ascii?Q?9e2jxqVgdbL30TpbXA0AZcEkVSDiQCwX/c6nsxR4XOsxYxn2anfZj4LNWg+r?=
 =?us-ascii?Q?ZCdxXJC8etxerOoFHC9vrE2gbDylQnUGaBVzY6B8eKD4GluAJT9PbTs+nU0l?=
 =?us-ascii?Q?sMhzLXKpssrh1/tW5ETBa3Yeg8ZHQfu8bFWRC8tD3laZJ5tyZOSiC0UvPn7y?=
 =?us-ascii?Q?qKltorYUcIli/np5qDQ68NioZf0dj9HZGHOV2LubImpm4CPnkGdcMp7wHUTU?=
 =?us-ascii?Q?sLcCnsXmEJLRvJUQ8WdwUOg5chKUTmN1kc4QUCzOizGGuTfVt2lmanyGm0Kv?=
 =?us-ascii?Q?jNSRAMDlArq72BsaFr3YTOfKV7j5oFNlw8tQ1Lr4NjEzInYkmNUk0HDWaZ2F?=
 =?us-ascii?Q?ZnOayfAjv5lDLqmiMxYqsrdVPDaEgXNxF+EWwCXzPfbTeXN1wF3KPRVGtqbs?=
 =?us-ascii?Q?eYxYHItT93S9pkAA44nHgxUCo17UgcOAtK9qOaTgxIU4bLlg4C/cV63VlonE?=
 =?us-ascii?Q?6HiA5t7+p7FHEVdJgG71LG8Tyg1vjWQM6nTC0fSmuAJa+wjKVs34P3x43R0g?=
 =?us-ascii?Q?JXjJ/iwAviwFIhfrWtIvP5cM8KjzwpwTzqyaUXv43K21sO4qZQrAv3wNU0ri?=
 =?us-ascii?Q?xgngDY6oK0rfdnyMlJVfXqKfrYrol4++kMOTbj5X0WvZ2sAA/ytdiYqBrQff?=
 =?us-ascii?Q?4yQxgWQC5usBttNj4Mee9AwGizM26Fiv5X0WsM1PpbJp+zncMIVRvdhz1ujc?=
 =?us-ascii?Q?Z8dpbruDANnEKMG0bhlfWHMw/+qn++oW/W+vTmyGe5v4RR+0A4dHvLFBdc+X?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EIG5YieH9qn9R8w2Nm0UwxdtyQ0OqIW6TdZRrWlHYY2wVUN/QBpf3dkZrUAQnT2071VtS9ghd9QxyNxcdRhdhQ7DNCYgH4wx5SfoEuJrqBr8sFsjhtn6rEZlCaZ5QamRVUk1gXksl9gxAKEnFQVLaWDaMuNqGCs739F5Fu3io8bLtdkg+eX/mqWUXUusdBRbOez1FsUsl7R9qhMpM3Z5H4e27lKKSZjKoYcBMc08tkcrjz4Am+1UwVNZYg7flwYCBAfak0LhbNRGU+fCuVMUPQvBmdQeFexSj+PqphDX48PC4oi51uwBgsAp8yPT/lB/PNj48F+ra8Ex9Sdc9i7VrviBsNwMhOLjseuPuvBTiRG3U34uu58WMW8cOfX5UjBztYN7L8bQiMdeNNqDS+z10aywI+Fg6GZKV5iFlnwSACy384kkLJAyNUXQRnTPafxlJr88qN+eom1wVH2Y1rYZvY4LjRslmEI9eb8nfSuQtKJ1gG2mpC7dD79JLusRrhQysWE5X5dk0zmqF/qMNApjuzv+U16mDSqIgW3yNzlQjj5ZMr8OX0U0pYV1S0vR51gt8x8KnnAcBFRoAsn0WBluHRjk1582v7bC2NB0xNXQris=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5794d828-2e6a-49fb-7699-08dd4c364cce
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 13:57:05.8088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPszwseOkJ9T5+kMOoqIkjEXX3cr8Mvj3Avj7Hz5EwRmi8JbHDydw+J2QNA1MAY/fMqQjfRvrM7BQnSVWOi5WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130106
X-Proofpoint-ORIG-GUID: btAnqVpXNOfaYsEusZg8vmVehIPJrhks
X-Proofpoint-GUID: btAnqVpXNOfaYsEusZg8vmVehIPJrhks

Currently atomic write support requires dedicated HW support. This imposes
a restriction on the filesystem that disk blocks need to be aligned and
contiguously mapped to FS blocks to issue atomic writes.

XFS has no method to guarantee FS block alignment for regular non-RT files.
As such, atomic writes are currently limited to 1x FS block there.

To allow deal with the scenario that we are issuing an atomic write over
misaligned or discontiguous data blocks larger atomic writes - and raise
the atomic write limit - support a CoW-based software emulated atomic
write mode.

For this special mode, the FS will reserve blocks for that data to be
written and then atomically map that data in once the data has been
committed to disk.

It is the responsibility of the FS to detect discontiguous atomic writes
and switch to IOMAP_DIO_ATOMIC_COW mode and retry the write.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 Documentation/filesystems/iomap/operations.rst | 15 +++++++++++++--
 fs/iomap/direct-io.c                           |  4 +++-
 include/linux/iomap.h                          |  6 ++++++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index 82bfe0e8c08e..d30dddc94ef7 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -525,8 +525,19 @@ IOMAP_WRITE`` with any combination of the following enhancements:
    conversion or copy on write), all updates for the entire file range
    must be committed atomically as well.
    Only one space mapping is allowed per untorn write.
-   Untorn writes must be aligned to, and must not be longer than, a
-   single file block.
+   Untorn writes may be longer than a single file block. In all cases,
+   the mapping start disk block must have at least the same alignment as
+   the write offset.
+
+ * ``IOMAP_ATOMIC_COW``: This write is being issued with torn-write
+   protection based on CoW support.
+   All the length, alignment, and single bio restrictions which apply
+   to IOMAP_ATOMIC_HW do not apply here.
+   CoW-based atomic writes are intended as a fallback for when
+   HW-based atomic writes may not be issued, e.g. the range covered in
+   the atomic write covers multiple extents.
+   All filesystem metadata updates for the entire file range must be
+   committed atomically as well.
 
 Callers commonly hold ``i_rwsem`` in shared or exclusive mode before
 calling this function.
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index f87c4277e738..076338397daa 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -644,7 +644,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			iomi.flags |= IOMAP_OVERWRITE_ONLY;
 		}
 
-		if (iocb->ki_flags & IOCB_ATOMIC)
+		if (dio_flags & IOMAP_DIO_ATOMIC_COW)
+			iomi.flags |= IOMAP_ATOMIC_COW;
+		else if (iocb->ki_flags & IOCB_ATOMIC)
 			iomi.flags |= IOMAP_ATOMIC_HW;
 
 		/* for data sync or sync, we need sync completion processing */
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index e7aa05503763..1b961895678a 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -183,6 +183,7 @@ struct iomap_folio_ops {
 #define IOMAP_DAX		0
 #endif /* CONFIG_FS_DAX */
 #define IOMAP_ATOMIC_HW		(1 << 9) /* HW-based torn-write protection */
+#define IOMAP_ATOMIC_COW	(1 << 10)/* CoW-based torn-write protection */
 
 struct iomap_ops {
 	/*
@@ -434,6 +435,11 @@ struct iomap_dio_ops {
  */
 #define IOMAP_DIO_PARTIAL		(1 << 2)
 
+/*
+ * Use CoW-based software emulated torn-write protection.
+ */
+#define IOMAP_DIO_ATOMIC_COW		(1 << 3)
+
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, void *private, size_t done_before);
-- 
2.31.1


