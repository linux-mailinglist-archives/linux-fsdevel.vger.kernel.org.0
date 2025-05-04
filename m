Return-Path: <linux-fsdevel+bounces-47992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE78BAA8505
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 11:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4931899972
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 09:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6161AA1E8;
	Sun,  4 May 2025 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pzu1uJIt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B44BTpZu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9761A00ED;
	Sun,  4 May 2025 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746349224; cv=fail; b=Phtr8Du2DHdyF8DuA+ELmtzmaUhYN5ekFgBYAmbgpjtD0usqHKBZ6BDH5nfRIsjxqf6tlIDXY1QoKnCSjqXCwwwmIM/S/zt7v1BYpr6ZCHygWrQA9MQrg1Fku2lTeMpY5AaGDvOHYgb9Qw9VJpL5KG1+I6wnho5Feh+GOvXNrj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746349224; c=relaxed/simple;
	bh=bao8ro5jB2y+yAP3hljkJAZmi18dQqmKw3XotU1xy8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QztBS4glGYrG3g20GCYdd/aaH+T5/kUghBghaDKqikzeks8aLMIpbeDrsYV0SBWZpj4LLcLgzWtAKo9Wj+2H0E87uOLaDXq4KdAVO/0dXcZ+XsN8jl1Qiol+B07XXqiJPYKU4grWlB8LiUa+CwBeeR+8RWziCslj++TkfC50nug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pzu1uJIt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B44BTpZu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54480wZj004059;
	Sun, 4 May 2025 09:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5QDj8Rz5l/t++iluDX5lk+BX2LQlZEDF6iZSgvNbB6E=; b=
	Pzu1uJIte1dXogHLgwUV9YJMamMCpbE/IceONgK2vjRb66toA0OHiCfmU2jpFanq
	41ftuHOYjHMucxII+Qt2H2DMKzbdJezCwAHsN5LqHGZdTjRz2dOYCTQQ3YYyRno3
	EWyuF1g2ISAl+jWMPYa6rY+ON38ly5obOa5Dg8/JZur96kaiicDmck/mfFZ2LO36
	rWMe3/5AI3UTJrypmcqmDwE5ck9Wwhfv68QvD/9TK6N+bu512PSamsDJN1+naMpU
	fYAwml7rCEAiZL9bvaSbjaxtLh5P9B+tXuFKy1068ueO4CIlC89fuZfJqJAlnqmI
	/gv86DEtoYcGrcd36FSw5g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46e3smg2sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54465cW0035553;
	Sun, 4 May 2025 09:00:08 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012053.outbound.protection.outlook.com [40.93.20.53])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kd0776-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpU53sDhS8OCLTeAySpLoXdWn6BmNY81pATIuUW5+1xG4jA5r/5g3bX1D7Jy/A5GpxwLcVTXQWVDjMns6vY5AVXf5HgzjcaBjpgECe+0Tpqcz3HquNUX2jJbuXpgOIwsth/aFYEYaboVLtupRATmWF6iLN9gcaAFXj8w4B9OMNmzT+iOewqhbb/ir1zKNTLY70WMKMOq7KUJJlah/6+YstQ+ezQ0oIxzdhl5K+tsONpScsOf878akmgkpdt8amh/0SHnEX6uoLQ8+McLkpM7dp0+bevNvxnDRijBIxxZFsvGFepQBvFFxVRmEZ+LKbafT6MAjK+fFnZDXWr5jo6V2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QDj8Rz5l/t++iluDX5lk+BX2LQlZEDF6iZSgvNbB6E=;
 b=sq60ce/btD58W0qtkdyD9QNjwZyMB4AkB79RB5K0aEORGpgyP9KX9sjuO0LBbjpZjnlhKcNZRP2csj5o8BVAnT4G845lUUvjLflYbuSm+o9jqniaDd4eQSFGayAgiXs4XBPOYJmbv5LszIalGKE7FhwI4SY/PhYJ1jSg/1LxvQALZLhoHAWvTu/g+gV/SC9gG1PxnLIloeMwFX7OYyBRkLx4gwuxQ0XAdcVSkvHnijYh7FSkGdisrvIqJJi6yOSG9oQyV0ZymXu8AEoKdVSV/AlmBPgyZ6SOiukyibABbu3NB/pLIiGNr9H+j7gzFm2D6zvDsCpOrB+uj1kAE0dkdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QDj8Rz5l/t++iluDX5lk+BX2LQlZEDF6iZSgvNbB6E=;
 b=B44BTpZuwGmURQLmgFXV7ZKUsCFlc0qbROqNb3fX8/uDDgDO8mgLoKr3Xa5Zl1DIMyqRrFFixBIm7tKVnwStnWu9+UnMmQjAJXrkiFisPPyHhpkTmdCN6V5Q+oj/Kop4x2iMmz7Dd6zkI/JudTr2xPM+JzSjHQDTrytP+zQcIFM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7178.namprd10.prod.outlook.com (2603:10b6:8:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Sun, 4 May
 2025 09:00:06 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Sun, 4 May 2025
 09:00:06 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v11 08/16] xfs: refactor xfs_reflink_end_cow_extent()
Date: Sun,  4 May 2025 08:59:15 +0000
Message-Id: <20250504085923.1895402-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250504085923.1895402-1-john.g.garry@oracle.com>
References: <20250504085923.1895402-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0465.namprd03.prod.outlook.com
 (2603:10b6:408:139::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: 599157ed-554c-4119-4bd1-08dd8aea1068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IQiGYG+8p1AymN3MlMD3mDfwYP1b+UpKDqNnDsERD+zZBY2CJYruRHsgvrD+?=
 =?us-ascii?Q?vc9DXkXEVkBE+SMq8R7DEaslIl4MNg1nmd7jqhJyXdB5E6dnijisCOmn+RH8?=
 =?us-ascii?Q?PlRMN5oNCkcc1ma3o3KJRONeB/DIH3kcCYSQdTwa8J+4EEd8HhSxFeAj9yZ+?=
 =?us-ascii?Q?FTjZ5Vsa7vcm6OtySDHUxMr5FzJle9Cye+qcNJuKrmyieotG4A8zeOHMRIPl?=
 =?us-ascii?Q?XMuJbx09M4Ij2sth1hC/7snJkcRCjOweSS9Dk3A8O3S5GjHgkBEDMuvFhWx7?=
 =?us-ascii?Q?HL0lNrxJSihnPcUol7IgKuKWeehXNbszWFF90qy78khQJCp9CgQW2cLJ5ET1?=
 =?us-ascii?Q?WNz4IZPJs3W05IKqLQAOe/E16zy0wmNcUQ5PuQgtL2emGD7fcozM3VarQamM?=
 =?us-ascii?Q?m4kYHlaCUoQoaoxbkouWsvHybbdCImmoN2iDrFJZExA2iVCtcuCp0x+jwUbe?=
 =?us-ascii?Q?urLY7CPkPhoElIDAEDUJK0JNVpFOfkkWykDkW01GIdCayZQXThyX3/swbMmV?=
 =?us-ascii?Q?c9YAGrHBwtR5tfFMzLDRD9/h4qSWdHNH+q9/SxEin8vcMOY295eirEPj7SE2?=
 =?us-ascii?Q?a4e3G5E+6S3BXIAXpb+hWTL2fhgVp3o/AhI7Qipx3rHBlqhSA7EnjebQc1q3?=
 =?us-ascii?Q?UfPIU/JTvl6BRpx6Ca0WmrbU4jPtVHifXF6f9GznLgLALsSSnXY9tryxsvOB?=
 =?us-ascii?Q?Fch5gRIqhEv882xpN+wOnjj7UW5eTPHvuJ8PDBmNP3hEKfQznvy8jw7E8W/X?=
 =?us-ascii?Q?6MCrGvN3s5TosMSwbyoWOtinf1/DhgB29vAmBC0/0FW59XzlBQpCNpNU2OPP?=
 =?us-ascii?Q?+rJynDyein+aSm8eyfFjzkYhWR15ozDn8EgGCFBOcjlj90Wh7XXlQ4TWSWGN?=
 =?us-ascii?Q?hY/mpnuDd1lgxDKuz5uH/QFSPaErQI38b5RnUgOIpTC6DLeHL/AwaLBOXJY7?=
 =?us-ascii?Q?wtnm4F/g78h3hxoHEttpYvRNl6W25Xo1oOm5LV3u/Q2chlw9vCy9jjrnozEp?=
 =?us-ascii?Q?KQnwQqEjbJbphrrZIv2gFO+u4uM5oWOTGFtytQ23pylFRh5cgKHQX8uye51w?=
 =?us-ascii?Q?9G/uqvVJzfo6lavgILs2A4rUj4c46YcPLP6EFRF+R2qUPdnmlV/emuDACf3U?=
 =?us-ascii?Q?4e9mGyi/ZWsb262vBVWu/3RFRYj6o7Bka85sYUdiEL8BR9dM76ZeEoD1InnI?=
 =?us-ascii?Q?MlapvuN7P4FJBNIdTcG/iOCVsNrEAvlynTqASbnPrsbRp5bgxDnURhEv8gRV?=
 =?us-ascii?Q?hNVF2clw8lJWkQpo+tkt0mBUB9vcW6Xw1qjWXGneheUTutZG6GEycpNq87bv?=
 =?us-ascii?Q?raSHjTtJ+F0TTqdJ9oAcvPIYMgqf/BbdxVrSPSi7gIbvXFZ3XtW4DvXkXXnY?=
 =?us-ascii?Q?9gmhrtMLdDwVp1n4kc5OgwKCNmlME0e76d6g550yDeJ55iN0WPhky2PBRuzB?=
 =?us-ascii?Q?gDFv54GD1PI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pc3hHdrSm5RBi3oOt6H+g1xxB2TG9p2zyVV+jyU3heWT3I394GeohNIRGkeN?=
 =?us-ascii?Q?VTt14krzNyQW0EppK7GwhTqZBQrrO6KGwEqG48ZRw7ymN+b4nQmXgxjwnHKE?=
 =?us-ascii?Q?OJk73KXbAnxcv3gXGPGNDIzL5smuILGCYZkYItHpNb9fTchOBHx+2apOymro?=
 =?us-ascii?Q?7ku40EPBDeaPNTx7y7CFzUFlcOiuRD4y4ZdondrSeW65+T1me7/r8bKknHoz?=
 =?us-ascii?Q?zY/9u6O7F8WjzzFLD3i1tNwMzYe3GOvl6HK8tdhfcLqpUcH+WG/G3yB6UzAk?=
 =?us-ascii?Q?AaIYYp8m25vCcE7fNzI/7XJrN5LJjO35u4ltgWCCuZlqcC94jBGoYMLUQn08?=
 =?us-ascii?Q?ztZkfXxqjgspvluyo9fT13IyhawA+rxqlgOKjQ5txwjFheIMxVM2KN4Wv2Aa?=
 =?us-ascii?Q?TvcCEAQzdN3smfEWC8yoRB1Ks6ap5oH0SoDNBlqodfyGrbvwaM+/awSJAf3q?=
 =?us-ascii?Q?3kNc+CVv/HpV1ZBw4Db68p6cA2XMFseL65Hpqkg09BP2rSpf5aPl/wB65vBL?=
 =?us-ascii?Q?QP4lfu75JfGnOg0gcFUtFWWVI6Z6NhGiVhy89VBWlXtzPCWc5eutNtiiafc5?=
 =?us-ascii?Q?cjCmxeoyzlgDt6lnrqa/b9PS+jAM0R6/+wuKStNDMGeL2Xd7YMrZ92hlpB2H?=
 =?us-ascii?Q?xVAzwFWT8x5V73MyZl4QY3vWqhjnDuLCmdZPXzKYyfm3o/yNDSeGmxwr3Rbg?=
 =?us-ascii?Q?dtyKwJk45RbPtl7jGp3imihsBaSRJMi89FWHRQXWqu/Vy5CCQtVvCrTYtI0B?=
 =?us-ascii?Q?t7P8zHz+quztzqG081DzYyCXeStd6blY/wSqR7lNdQzK4JtxPNeKsySqfkLV?=
 =?us-ascii?Q?QSAr2IVzagdL+5huxzGdvALrGcgx0zCfumDPCCu0Ne65LoiUVt0nCPQ557UT?=
 =?us-ascii?Q?BzAPCQxmFnU6VCcLn9zndxSpBkDy9mv92MKeNtPLylw3IV6Xkv02oLRjwYKa?=
 =?us-ascii?Q?pUNSaXC6hFVGuRntF0sYs/PpxxUlyy969lj/fxg00dMdDo+BfMUoxOXyGPAa?=
 =?us-ascii?Q?q8FJPMgxGOda4CEvo/kNyBIKdndqM+EVVoCiSkxDgqUs/KTSAK//1heJKYU3?=
 =?us-ascii?Q?TV0/5jxJEqu+jU3ikYqXqQLt0RZKzY9gh5KfZBLsslcwYF36BXlkEKZEm/6K?=
 =?us-ascii?Q?MJxA1Bh01q52K2gsjJr+kUiXwwQuldib/LFOva9K4gMec77R7uCNk+1FIlx1?=
 =?us-ascii?Q?FQppaB8SFcvn7lDT5T7NxQUFh6M89CMG6tGmlYKKMJK/eSxG6vz2dyxIqu/q?=
 =?us-ascii?Q?oo4FGq1j7boMC30eDeiJsmRVWd+xUb2QMVI0Zy0pBvOVKK4Kig6AbJZbl8mJ?=
 =?us-ascii?Q?/wy1i1B49Wv6zkRVfiMjLyfFJYYR0OzrNts/5ImIVD+uNMr0K+/N0Q9c0OEm?=
 =?us-ascii?Q?FKnHHVBVgknh0s23Ls1XdnpuVr+iIePJ0eVdyQyv0X8T2BqLbl0QKIX+VgNF?=
 =?us-ascii?Q?HZwDPJnwiJRTEsV8h7fFMWL0R5/qN5+Pce7+nqx8dhF6HrLUOrwaFbu4phuc?=
 =?us-ascii?Q?4SEkR0R366tUeGV5LcxO9rCL3YkcBCjlcxLedfJyk4xJ4INFu+XdXmJ9Y6LA?=
 =?us-ascii?Q?3yLiUxCqXgWzZg4tDmOa8G/M6XkgSNy4TaJjnVwzOmA58Z1s3jC6kz0B+wJf?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZDQ4UPvAFNB1cKqwDWyvT6F2lifaWBAAtHRd5czkyLe6uY/CeiGX+UWc93X8j8RsZibiXJmhospOmtnp5rkrGYJyylabyIHnMdfnB1Xjuvzov82iRpWEXa5ebmoyECC2isgm1mi010JxZGOE9v8PEL0aTp5ZVnSuipxUqnT1ajRZoL+JrQWqESMz+c0DHYAdFxX+MLBifmKOM1GTL5DfFToGFL14m9Ji+FEwDADQxmejDbBueWYQk1uIDEeFhkVKTclUSNHFchgL72WXo4Buvk3g0nKJyae32S2OzPOn2YQY9Q9JXl5MbERfKq1BNRLIDi7l9x/TSDDCFSpL5tnUi+/NdkJg81tjGPiUEao79ZNfVFBlUWhC208sHpzuVU+/HC8nA5kJfIoKtpmkewIhYR3frAxNnqoFnNkbtU4uvYT7pFZhTN0oOArVIFLEW1xgMZ5EqmvzYGdcdlXzp6bue7Qdrkq3+H6enmlm/4fu00yhZEIcKVPJKSeIhxXZuusdLru9G5OFUSjijW91ERRZPWcdvzhXxUsNSIFGt8zjPrCdGGdCvYLx8WYvJ/Dwo6qqlNjFJnSSS+IccVP7VOmqsrGSUko0zy5FUhjGLXQ6FlQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599157ed-554c-4119-4bd1-08dd8aea1068
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 09:00:05.9818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cEpk4+xUWya5Gdg5q+2+sr+SM2gCsmpj30gY2bEvMqfVqnt/3YCcCjA8csSQhG+oTaC69kAGE5Byi0zXpPNVBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-04_03,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505040081
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA0MDA4MSBTYWx0ZWRfX9hafsmpO999G dsMy+BvHnygc+sp59dt+KQ4hFJqyVwqlPHvEE8ea6EtwNyuTCZ3nVbOpqYnHoRFf/cgjFSj+0Ym NqKBiNCRjrfCEK3uYvza0u7A48zlN9DylLxbm9yaBwlFfxfjUYSeSrA2NkE3fpyvDDZtorrcfIQ
 RhZYEHJZVrgm3T441sit0qxcLHbELpHC3w6zoQzdO27vo+o32AlqSrbTNuqg7xst8tLrU8qHv52 YdK6gUSxqcm7mh/pyblm/td6YG6BkZMezJbgP/ATrVv+qFO32275iVCv+ug71phr1+eX7Fq6O3+ Og+ylWBWO10or7sZK0N7qGF2UFBDIFEzN25D2lSRQO7V+XOhqqpwjs/I0676ld8+FMUT3qfTrO1
 Ff7a23hZyw7c1UaL01xigupZyL8zCEdpVZEbcnXlosbuPRR+iqKj3oB9GGxI7RtT3u2twU9G
X-Proofpoint-ORIG-GUID: nDJZud57FYkk9Hj6AbkLq2StrPa1IT0n
X-Proofpoint-GUID: nDJZud57FYkk9Hj6AbkLq2StrPa1IT0n
X-Authority-Analysis: v=2.4 cv=bNgWIO+Z c=1 sm=1 tr=0 ts=68172c9a b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=zPHwHgG4P_mrsmFPOIUA:9 cc=ntf awl=host:13130

Refactor xfs_reflink_end_cow_extent() into separate parts which process
the CoW range and commit the transaction.

This refactoring will be used in future for when it is required to commit
a range of extents as a single transaction, similar to how it was done
pre-commit d6f215f359637.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_reflink.c | 72 ++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index cc3b4df88110..bd711c5bb6bb 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -786,35 +786,19 @@ xfs_reflink_update_quota(
  * requirements as low as possible.
  */
 STATIC int
-xfs_reflink_end_cow_extent(
+xfs_reflink_end_cow_extent_locked(
+	struct xfs_trans	*tp,
 	struct xfs_inode	*ip,
 	xfs_fileoff_t		*offset_fsb,
 	xfs_fileoff_t		end_fsb)
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
@@ -823,7 +807,7 @@ xfs_reflink_end_cow_extent(
 	if (!xfs_iext_lookup_extent(ip, ifp, *offset_fsb, &icur, &got) ||
 	    got.br_startoff >= end_fsb) {
 		*offset_fsb = end_fsb;
-		goto out_cancel;
+		return 0;
 	}
 
 	/*
@@ -837,7 +821,7 @@ xfs_reflink_end_cow_extent(
 		if (!xfs_iext_next_extent(ifp, &icur, &got) ||
 		    got.br_startoff >= end_fsb) {
 			*offset_fsb = end_fsb;
-			goto out_cancel;
+			return 0;
 		}
 	}
 	del = got;
@@ -846,14 +830,14 @@ xfs_reflink_end_cow_extent(
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
@@ -882,7 +866,7 @@ xfs_reflink_end_cow_extent(
 		error = xfs_bunmapi(NULL, ip, data.br_startoff,
 				data.br_blockcount, 0, 1, &done);
 		if (error)
-			goto out_cancel;
+			return error;
 		ASSERT(done);
 	}
 
@@ -899,17 +883,45 @@ xfs_reflink_end_cow_extent(
 	/* Remove the mapping from the CoW fork. */
 	xfs_bmap_del_extent_cow(ip, &icur, &got, &del);
 
-	error = xfs_trans_commit(tp);
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
-	if (error)
-		return error;
-
 	/* Update the caller about how much progress we made. */
 	*offset_fsb = del.br_startoff + del.br_blockcount;
 	return 0;
+}
 
-out_cancel:
-	xfs_trans_cancel(tp);
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
+
+	resblks = XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK);
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
+			XFS_TRANS_RESERVE, &tp);
+	if (error)
+		return error;
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+	xfs_trans_ijoin(tp, ip, 0);
+
+	error = xfs_reflink_end_cow_extent_locked(tp, ip, offset_fsb, end_fsb);
+	if (error)
+		xfs_trans_cancel(tp);
+	else
+		error = xfs_trans_commit(tp);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	return error;
 }
-- 
2.31.1


