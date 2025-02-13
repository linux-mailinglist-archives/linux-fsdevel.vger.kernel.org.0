Return-Path: <linux-fsdevel+bounces-41648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0184A34103
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 14:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9173ABB7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 13:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485F6242909;
	Thu, 13 Feb 2025 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FKbB/ow3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bsFq2tQV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23862222B2;
	Thu, 13 Feb 2025 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455040; cv=fail; b=AQ1dwveyMXqdDTVGK0/i0TYJhz9eCdZuZOOH6jTzC+/gJc/owxsOP9atHcM8rhYJH925LHfEGb7nvysNvJ1w5cTqj81C2n2NZ1IEFK2ffV5ZjPpQp3fOZLPLC7wqa60Kjx4cPpbR4sGOn/SkJa6gmAB5DHMer9gXFj06A33aMRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455040; c=relaxed/simple;
	bh=YAnqWcDqzG2kJt67+Pp+GjHnPmUZAzkCzojr1daDHvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rU84Gj8Z667NVoCTlL7+PD8WsmKeDJZl6vZzLB18LUUPfsppVAEmrWZO0QBRwKkcwhETyN4e1894iGmyOITVC0ahM7bAQkHUtn1A+ce78Oum8aq08dCJbNGgqrxyrU9oPfQaEhxkgwKsITZZP+6I0lWenNpGpm3x9OJZeNId+PQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FKbB/ow3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bsFq2tQV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8gF3L027363;
	Thu, 13 Feb 2025 13:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Opy9FI2ztnkx603tMTBOQppxYWeejjNdCg7Va4zdtKU=; b=
	FKbB/ow3syZbpCkjNzPcJo9sBjmEFqVDbC3VsM5IPziyHFF4/R7UXYuqOXdTg7pT
	ZuWhw4haID98w3hLFNQdXA3vBg75emrDlAGlowtYBHC0Ydovz9fnFSIF+XcoGrLP
	iqW9BfcF8hSl7AJ8pTgQ88CzQWvNNQoOSFUARDvQ0I3g5iX4VjcwEZDVLVjBaUVr
	0n2R9tWUpD67O7dYUdwq+YujW2n+VfrNqHu2U9niAa6mdSkfR6d1Ia9R8rwMrGOJ
	5vqNV9GRqCNt8677Q+b6jXjZQ6le2607ggPWecrLV1ByIDuaLx+Dy9wve9Ya/58j
	tyjaxSRGCEH2kgO2zHPgSw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tg9qhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 13:57:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DD0iV3009791;
	Thu, 13 Feb 2025 13:57:06 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqj1tuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 13:57:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+iM4W4AWok+XNT+hLUejvb/jg8F4R9tsorwh/NsnP9jWkmjlAyjDAlECllbLC9ok6+IU6GpLREKeP1RvWREkKz+iGDckOr5mnnAOtEoym0cDpkqp3bpmSquimOmR36GSDkegl43dFIfnMTOChURUEB8Fse4J37QiPYFe9S7yYLVUICfrdV7lPpMlzwxHEbBAFv6gN22o4vsp66we6JopOmhuUspKe5HaxPtxjA1ltki1ppI5DbcaL1c+8LvOOa9euUTPhBXBIqoNuT1C8FV/fLd7JzjXCox1LOPc0yiO8Wq5n+Kh7rGsknY2FlynclSIaLNP0EjMovcU11tm/BMOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Opy9FI2ztnkx603tMTBOQppxYWeejjNdCg7Va4zdtKU=;
 b=zJVjjdRKwmI8DWgPZ78BBH3SxcFM/NXswYK5Iae7F/77rcfkE1BZGLwYmsE1lm11PFnugKxYphsRKyNV1NDo3EuA/L1HivsZbitOS9xZsjMJZMO7Z97aHq6ZwP/PRVlzOz6KkD/9bV0N+joXYucr2MKN+OhJNEBiFAAXWiIJkHqwMCeI5hiImTjBCL29o8X8NU0f7+Kx1SF3ejLgrP28YCV+K5T77kGux2jkpPDrxnjzBqw9ZIwjzRANW7rfGaaC6EKROtpU20eU9UQu+aXBNsGRLPQ1ppy1ideKqCtlGm6vtxKbssW58X5h8VtoRppkEmcMyALhktNTAQKme1FrVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Opy9FI2ztnkx603tMTBOQppxYWeejjNdCg7Va4zdtKU=;
 b=bsFq2tQVR+AphWuZUz/V1nEUCiSEdlKcquHRYXY85aZmiNlIkS+Hya0Ov8rZRl7y4kljY4gVvVJSXBqR5ODZ5ym0FgcT91PfWYP8SwYPoKYIVulsjWNqFv3jJwqUlXLW5gaxwh+um91NZfX85a6mwXft1LSokXuJOlZJqzapnGk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7125.namprd10.prod.outlook.com (2603:10b6:8:f0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Thu, 13 Feb 2025 13:57:04 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 13:57:04 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 03/11] xfs: Refactor xfs_reflink_end_cow_extent()
Date: Thu, 13 Feb 2025 13:56:11 +0000
Message-Id: <20250213135619.1148432-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250213135619.1148432-1-john.g.garry@oracle.com>
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:208:530::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b97ae0b-e1d1-498a-f7d5-08dd4c364be2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CblrAK/+lTkqmi2177btD75kbr/nYr0TqsS3seYDsoNPc78eJHJB1kZw5DYN?=
 =?us-ascii?Q?ZM+wjok+9sxfXeTlklE1nK60JAn07NIzThZPWho2DvhUb/PaNtx15zf0lA8T?=
 =?us-ascii?Q?8fAftL13PJvOGB/OtJfamPsoUefV+FYqFfyQxX5VdRNex/HcyO0fNTXtkQPu?=
 =?us-ascii?Q?Z8h28FX4pnthi8YO2RqiAScmq2zlrah4awlRwcvjLPDbi1PX+7OTsPgRB4TH?=
 =?us-ascii?Q?lWUIzsLt+XlG3Z3mHHLAtMzCY1pCjeq6naKg5W5iaJWUMOiimrpjC665q8I9?=
 =?us-ascii?Q?oM04vJaRXxuxKAWdt4+KePbIAXygKisviOgL86YFeA/Eux7S5PBZw7p9BDpd?=
 =?us-ascii?Q?eJGRVjqfYLkWTY7rEPWaJF9yfp4n76aXS/naSlgXBCFv1IZUQbNCIKvyoghV?=
 =?us-ascii?Q?HUaoATbeJAqHsFpQ1ylvdCp79NhHnuH9ZNxci1httGAweAaZWWO+AoQCWhSl?=
 =?us-ascii?Q?AYcMrDwUTgRVpJQYNMAjau+MkXW4uycgMDfsLuLVPsm+9PyWgb82k/Rasnp3?=
 =?us-ascii?Q?6cLPgU30X1FhvuiXJaQypvZ8pu9/IGlLxrUc2RckLAF9sXQ5nCArx4vMtTh7?=
 =?us-ascii?Q?EONaeChix4fFKo2TDzfMo5DKoqZulU6xw3rRQFtTEYYiRHpfJbWXo8+4HHTT?=
 =?us-ascii?Q?0WKdW52IvCKE7ANg8KUYEBpCxxGaZdswNsfeQQRz9oOuYyCZ6tgDJMA3uMN7?=
 =?us-ascii?Q?wqnnuH6YA/3EZa49v7ukZkc3CknAhJFP+9jI64FexdfY8StrPy023W1BBvdw?=
 =?us-ascii?Q?FywCVQjIObwzb2SvK1emu0cMCtsRySs2csayAVHE1CXG9LygzwNX90aoTc+r?=
 =?us-ascii?Q?ahTZGcG+dE90tzSoSFZTaQysjWTLV8MxTllyhp4K/VYdji9Hd/H4fdvfj5Qz?=
 =?us-ascii?Q?GlWvwCm/901exfsmdBgiImCnvKUe2I6/WBAZwdzdkFW0Isx4fwOVTRSm9vI9?=
 =?us-ascii?Q?BpdSpnQRe4R8794sAJzVHu9VyF7JY6ny+wjZ3SnjeLYlH+jTZV/cEsDg8UGt?=
 =?us-ascii?Q?Y5c7Knpl5m51/Vs99VDIm6AvuUCHwG+zASt5f+minso3pbEulX0CVw5dY2il?=
 =?us-ascii?Q?h2i6zLYrDwyZofMZzh9nKtCIgCWZDdtH8l5VoP1os90D0XuD67FABUhLQ83D?=
 =?us-ascii?Q?WJ+tSCoF3jakOEzp5SQ23I7jbco7UbofwYGZeTR352pqeNqIa5WGIyZqBUVp?=
 =?us-ascii?Q?2/lsNGzmwgQmU102Td8j+aZ2o8TmNZb8WiB5lwu2yzUfP2HCxZOcK3UgfHgy?=
 =?us-ascii?Q?c2Y/ovruHUldLOjXtc4b9RQjztRKRkJpAlTEYjxFbLFD47YNzVObwPvvG5QR?=
 =?us-ascii?Q?0gtcPvqqS1LXXE2psLOi7qMCVpV6MFFEybS4Et+rZ1Oy4lMU4kO3URZPB/PL?=
 =?us-ascii?Q?Ez/KdRC2kzaEj2x/B6PO/mEd6lDO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KmYJtNJ93Vgxu3+6Qb8w7Egau7Qt9Np+tXcqlguCDGZZJvmM2bxawv+zylXA?=
 =?us-ascii?Q?qfQ/Zu/ety1yFISYIf4g3mjpmbt9VndSDQPInPNyNA6jeWQtxKTGucSNfFXG?=
 =?us-ascii?Q?B7eQvyqN0UUENkZclBlQI+FBczI4s/RGvaVqL1R6/SqIwkQWCvlPa737wipt?=
 =?us-ascii?Q?fgoYvMhJcTygdSZ2PkqK9xMiD7Ub2/+SYz4aVObCImqOAqAhOVQhzO5oOy1E?=
 =?us-ascii?Q?wT8anav6J67BMlWZkNGtEHQNX9Ufo7V02JcL51eiKYR40gFPVcfkkwgE23oJ?=
 =?us-ascii?Q?rzNst9TGdrzIX5NG4dp7a0TmKUt39s7uGeF+8ppONCs4sFBb+qojL0++M8ZN?=
 =?us-ascii?Q?ISeiu24Q9zIk9eneP1+Ohy+ryP6Ud/d4CTXqcMEmYt2nU1HX4YGtijpqHZWo?=
 =?us-ascii?Q?zxROJj1t/+wFx2u1Lr2uPN2Qjp6Ovw7DPAQYJLSD4YbixqSp+Enwoy9RqsCV?=
 =?us-ascii?Q?gK+OsjlvzoGGUZkH5ltPaiT7QnZEU6sOlI8GnWNH7n3pqrfn7WP2iDqZ8kpm?=
 =?us-ascii?Q?a629m3N2AmLi+4VVsRTFP7la2tPiOXglXSZuS8PnUtxGMqvFEhpO7f5PVSd9?=
 =?us-ascii?Q?vRy+zJlFVre177vzfDZ9NdNA5XIJ3eu7d4Kg88eD2N9UUXlv7CDvuBYIUdik?=
 =?us-ascii?Q?h0p8JHZ0XTkcD7Bi6J/e7rcU6RwEfT4X6BIqwxNopILBij/GztT3SS1zU1Kn?=
 =?us-ascii?Q?48wfhut+fXbacfYMKNSXHspI3PGT6+Z2CD7Fzmu8PXZK5Dp/bibgEma6lByS?=
 =?us-ascii?Q?SLNw3ThBrb84bc3TzbdVM5ma+qv1LVq9xbGjEusMJc+QSfdH6AZs9AQl7CyF?=
 =?us-ascii?Q?yJ1rlQec/b2FuxtlYzEfawPpWF1NAkvFb1e/yhJN0O/BBGWhBQisX8NA1ySU?=
 =?us-ascii?Q?iDqEsidqCjy4XHQh63SvTMw6GmPR9ZfIkcTxOMLq+6dAFBs/qTIbMv0XwKuC?=
 =?us-ascii?Q?jaHrcLS5Rlm3drvW4ZaBUvAQsH1tCDXOWP6MOKw8UVjEQ8jzW2N4IUU2/HJa?=
 =?us-ascii?Q?1VVix47syucIS32jLqDWcBHrRv6SNSZzn6CH3u5g3a2o9NAozUCQ/YbrbiWX?=
 =?us-ascii?Q?DMKMWKRDWdCaQbUaCUEfoRYbRKUGspZc4I5X7a5bMSLA23O/347M+Nix8Eoi?=
 =?us-ascii?Q?dXQOkFNmyUVhwOdyNkJutnK0HnvFcjSTy9zmVnbgXTMA6067ocWoWMDmBKLI?=
 =?us-ascii?Q?Hkpti/9W/pXjRyvIW3DK/MQQt5gArxe0pqhUr2nm/TyZSCOVNOsO9gFJcOLT?=
 =?us-ascii?Q?zZzh3HBrL/bFgcH1PgaH9siSjr7isE+J0Pt0I/3mOA4UfvQHqkgwFq1X7PIU?=
 =?us-ascii?Q?1AA/7uXbByQE3TygE+NLDSMZcqqRLtOmtSF4+OERa6hZz/hB2WN5DwwMpwYb?=
 =?us-ascii?Q?rQwDYZDW7SG0FkVi4jP/VgvGyzpbOi+LdNyPET6BS6h6AmVDqQOH9qVRQ/gU?=
 =?us-ascii?Q?s83r7rUUakHcwuor6aJd9qMZfCT1qQkOG2P6ecIDzXzLtqfi7gAV1EhI6zpx?=
 =?us-ascii?Q?oBJV+WPx0fhAAYkKMMYZcSYgaLr6ThGAEzKcGF3LFRmD1WN7Nf3CMcSTs272?=
 =?us-ascii?Q?H6MkXHFu90QzTLz84dQkFhJCs5KwQoDzsREDNOeokDYoJsO94ttwGEcU/ucJ?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bF+ea0ZMH+jfGD5bSQXx2+UI2O+6S50IQNFJKe7dt6taexEy7OVpn0wrBuJYFLEyY66L9ooISKScAnOI61mJ71E1X0ogGGx5f+tvZ1rC/1eMWaGwHud5XMGTC3phtsjNvJ09Pc3qDdjk/fYf5qMemHXH2FTwg3ztP65barVmhJ+Ng5mT6wV95XDCg04247+eTp6B8Crt3wpZggfmTk0yo52oy0LKe73EBHaBReNWqiMvdpy4Bq5jBFlZZC4qIYrnmzMqAOgQu2MAcM0e4177KP0vxJymjP6RBg2kWiE/keKAl9RPzB1EoIQL7wLkeHowHpK/26MIUWhzQ0NIGpyrpCRjGkJUTZY3KE16m2KJVvRJupWX3SgV5nvNkkvHNwjut2Vz3CSrhiyUY9YGmrzGbtICvRYb4QlG5UrbkkVOphoH90L1eGnPKf6dI4T3+ZQGlb5MgsXh5qQYzygPe2RKluW5nIpjvifS6PqXlr6ce/antRptewLsyJUuKJ6GgZSK22de9Ae6xn9jTAk7XkEs4fLayOpOL9KNpHm+AX/07N6dcEedHBZXfORaRGHEtT50cwcZJ5HDIkpOZTRmYx8st2Gt2d8Grr4JQ7hrOF7YbkE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b97ae0b-e1d1-498a-f7d5-08dd4c364be2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 13:57:04.3215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8lXTPSFm7Sn0pS2zG9pPHLoVw4os8I7qx9RUk48iKPwNoEuHt+MQudFEA3LDR9P7cxqfx49SwPdiTUeejnwg6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130106
X-Proofpoint-GUID: vVW8JBCT_U4qAzfcctNW_YZcWvMZutuc
X-Proofpoint-ORIG-GUID: vVW8JBCT_U4qAzfcctNW_YZcWvMZutuc

Refactor xfs_reflink_end_cow_extent() into separate parts which process
the CoW range and commit the transaction.

This refactoring will be used in future for when it is required to commit
a range of extents as a single transaction, similar to how it was done
pre-commit d6f215f359637.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_reflink.c | 73 ++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 30 deletions(-)

diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 59f7fc16eb80..8428f7b26ee6 100644
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
 
@@ -899,17 +883,46 @@ xfs_reflink_end_cow_extent(
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
+
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


