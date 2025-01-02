Return-Path: <linux-fsdevel+bounces-38324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A919B9FFA1A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 15:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADD23A309C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 14:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508531B4C35;
	Thu,  2 Jan 2025 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ji+TTqwO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bhD9miDt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2C219F40B;
	Thu,  2 Jan 2025 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735826700; cv=fail; b=SKmQMI8GfBNczKB0GZpUEf/wfjwJymUYUaTnDeFKyjwAMO9H5XBC3uLS+ZT/6i/bWICg1qADJRdAfzI0Q6B1a6uoUnN/9JdwzVM7+nMFa2nAcDHu4KEVi++5NB4RepryJ+2UTiYfGJojR+6Qt87HVWGvreQa9YHIiiASolZFA6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735826700; c=relaxed/simple;
	bh=m1S1732lOVZz6DZKQChS7imby3DhgO8lHrA190ll1po=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AFumijGh7XpaChMQ6FZYEJJdqu90gI2nCYR0iXEB2WlDqLqygvITpKoebikqou3FEyThnXeqAIF9OvbXRJ8UskSIXAQcoLlqYK3Zq3/LolKobJTE+a43B1mTpPnwFWt5fIv0hhkyw6hjyAhaPN9K0ROvbuZaYfYJdRWdnpooeyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ji+TTqwO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bhD9miDt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502Dtr57018940;
	Thu, 2 Jan 2025 14:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=AbnVAj7zIP9hPrQ+PyTnlambmPbzIJJkODeP3dbjYN8=; b=
	Ji+TTqwO4nvbaxPbEeHuktGYNNGcTW4K0NI+7Pq4WCvbIGfLSEJPzXjgN+gMyY+8
	DkbcI6gIk4wb0he0lhGIFvpER0mOLVilC/cwgZuDIPiLBT3A9ORd9DMX1NNNzH7m
	J84Qyhh3qO2xvN2ntDbYcx8sO0hxEbRjC6bVFQfluxc2hQSpvzVmSuC8Lx6APlsR
	47eL4zFre/t5009jZR/dEa4+Bkpa4yGzaAeTbcipXjIWEB7TNwUo9PBhnquqFJZv
	tm9Co974GgVtqBZqhO+BoHGNi29JbCy7M2GKZLnivZsNzw5FEIMYA++fvuJoa5z4
	gbsPCtM6I5wI/oqSdztQbA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t88a5e3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 14:04:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 502CqmBN033469;
	Thu, 2 Jan 2025 14:04:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s8bg1h-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 14:04:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uP+5/W9xwHrCPgDAoG1jQuAWmeba3pBhXap66cvSe9TOB46HckuC4CDGtHtSyhLZqFiQ/R08HnoXSJDpf+Rfv7TFpLXzlsiFz+GZBL4QmVLo1W3AUZ9nd0I5zjWTFwXcJSTJWd/HJc9DD/TY8ezKMRCZa1BYA1zdEGwRv/V9m7rJdWZC33bxTVZiSR7QTwfPe7B/R6LfMQHkncFdcc2i8sGsIE3GH6ScpP3dretkS7EJSnnL3OPNm94fAaMp4xI7D62N4OCq8hN0cinjP6ZBJzgUEQVW0rAteTIJ0+vxSvSEeOGT9ek0AiaaTXrY9vUpfX4cvEs/60S19AQZYdItGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbnVAj7zIP9hPrQ+PyTnlambmPbzIJJkODeP3dbjYN8=;
 b=cfcg3oYVLlR4u9OTAXok4Ty8n9WQfzJGTaRSbG7Tl4twhvJldCQjMxSwIV1PMyHtWQNOgM63qxZot89L2ffKHErHGtHfj2qE0zcuea8qRf6zPCcMGiaf2Q2/cS3tsdtfjFZsV3c+90ewS6xJCFXapQecnFCoBuzpyNpo0S4F9AjX7YgM8ruqas/rX3iPmXRn/GUoGuABW8IcHvZvv/hWVE/ky471t0H7lx2fWv9u2LHmzTtI3Yyl5soerChuKfhZeYbroe7GfYveMmxbmYtV6KUqcops4Hu3e9W3vtaHcwuN1weOJGx7nwNuyKQKTMpgTnv25sFVwiJhkfvMA/tZ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbnVAj7zIP9hPrQ+PyTnlambmPbzIJJkODeP3dbjYN8=;
 b=bhD9miDtylR62vBtASfV0nokJX+s2kLh27jkQ71P7Falm+MxxfAuts0I7MNb1SFRSrD7H8DPSCRUTFxsFbLh1Km3ESYV/O+lg5X/RqCkidg6bJ2J8TnpCW04/BGgxm4hoypT/S1CsbaOw09Z1mbjvY9zfkJAMl/JApryX3Z5MhA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA3PR10MB8164.namprd10.prod.outlook.com (2603:10b6:208:514::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 2 Jan
 2025 14:04:40 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 14:04:40 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 4/7] xfs: Add extent zeroing support for atomic writes
Date: Thu,  2 Jan 2025 14:04:08 +0000
Message-Id: <20250102140411.14617-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250102140411.14617-1-john.g.garry@oracle.com>
References: <20250102140411.14617-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA3PR10MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: 0607ffa0-6207-4980-1635-08dd2b36664f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wXKDHZpZon8MStx3OzIhXH8RDbu+pHYm11SW8REXVLrM4fiLo9p0MBv8xBYt?=
 =?us-ascii?Q?iu9GJORmuS2RLbrE9gKhwqPFIA7BHeb/5YyAE4RMHjQcSGwaWuY8COEgCH4K?=
 =?us-ascii?Q?XXeNO2dG4A/UMiq7d9y1amMjt/fUb8B1+JKnJWeXIXjfALC7SiSy9R1hg+Zy?=
 =?us-ascii?Q?/j7Vt3zLK8knuTAEtfailnL6+WGw2dBu0ueszUTb5EefMWjKxoMkJGfDqShR?=
 =?us-ascii?Q?JjxWGEFxFlEgZIkl5H81Lys2iRd9BGGnk1RwYAuBOx2tQIE1/mCfztOJheFd?=
 =?us-ascii?Q?tklc+up/KAPsVmESwDoQqRPV7D6Yb3NqaPJOuzV/BO0+dhyIHinmWICObcBi?=
 =?us-ascii?Q?rF03Oa+YIBH+ibJaognvobV2XDtMCyyRRCFy2U6M7me2gQUeVE0DCjfrNmvU?=
 =?us-ascii?Q?YE6EaC7o26HfuV91WHaF22du7yd7k5wVCEnzeAFqLFw+gt6I6yY7641ybDaE?=
 =?us-ascii?Q?XwzlhPDwN8LSmTBEM/K9nkizZ4quuW6Ihex8JXJFKgFnauX6jE9Er9R0h5PV?=
 =?us-ascii?Q?K283M7QAbDgZmWRR4ePvJdCgmgthCVU2SYglXj2zSS6dnzGGONFVwQGf0LFU?=
 =?us-ascii?Q?Pweef+TkzRALNQ6/Pcdk7OBvnNZBrFD5r0JyJbHL95+6YRHi84uoH9zoKraW?=
 =?us-ascii?Q?+n0x5hn5d+6mpOusa+REqGAxHm+dwaBdYgJfoWvYEXGcBWmHK/V5zvovgj9E?=
 =?us-ascii?Q?bvPloqgdJnX+9cBXsHWQ9aisilVDiQ0/Mwb65vqrvPhvu+pqlcF2btip6Tg/?=
 =?us-ascii?Q?LCYmsNfBRfoziwWELmgRUM2JfMk4rcCqEqqkMEOA9wYH8sazLbH4K+HEYC9h?=
 =?us-ascii?Q?SzLIwtpcOe/vv7Zcagul1xEGhdvQvBYXvNqtQ8bJuWE+Lnr80JxSqfSGq7gA?=
 =?us-ascii?Q?opk5L5LhUlja3udfWnl0PFpV9RIysKLL0dmw02BVQg9caF/8CEiForl8Y7N6?=
 =?us-ascii?Q?W/5La9zErRosX7FfwUqbOvf3PPnGq09t2eVAfd1fXjpAnqPVZyWjnGzTcVw0?=
 =?us-ascii?Q?OYdH0RZDqqKjHxlkY4xmjOcpaQPzdghn+72N7ySTUvLl+nBH4V2j5bWPk4m+?=
 =?us-ascii?Q?G8MLnLG671lBAcJUXfsrhjjMT1rxGRNlL+xP0UsJ4fGsH19qidLmDIlxs+r0?=
 =?us-ascii?Q?wVCImFaDStMeYNwAI7VclkXExGa5s1lwGWuUb2EYvLmEAPnwbXxito4N5rqD?=
 =?us-ascii?Q?igO3Tt8uNgui2apCbI8auJxKdCYU8PM3l7vlLpJM0Fo7lxW7P12JgjizEZ4t?=
 =?us-ascii?Q?boqX4k4LpdDg1TxXbQKzXsvSU4Ab2ofGZl4lPf8lmTjKLJl2pRNYB3/7Mdir?=
 =?us-ascii?Q?KPz59729zeZH9+PntnpDtrZ0gaTNlciIjpLXnAIoyJTwBeEYFCkDqJQiwXKD?=
 =?us-ascii?Q?TGz6PaNfHUay0Dau0FYR2jvVPkBp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wCF81YoCfd2kKOA2GgwxvjBopKb59Uh8jd8niz7TCUjAASN6XrqzYgjMbIVE?=
 =?us-ascii?Q?nkVfzsZlb0iZBHPWJSUx7pIfNoJjihf8SzK+2KxDKcKItqR8ZS2rgFMLwLyd?=
 =?us-ascii?Q?u7VfWxl812TXAjVrA6sqzbJz1ZS9wnQTcNkG0zPMs6d+rPOVzMu5T7J5S2NS?=
 =?us-ascii?Q?d/egxv5pSZTu/bYn+8ipFRFUNptEs5T/S2GuhzUI6SJdSdvCiJ+DWMloHmQD?=
 =?us-ascii?Q?tUOGSeiX6MKDTpzcbP6Bn0GtbessEw/fSMUop0NqYiMWs5uFwXbs1UObZ1J3?=
 =?us-ascii?Q?+4riqVqTzA6nmfkZ2LmNWzmjdMAgxSFgSDXJ4A8Gse6HjcqaSyBv8jl4p18K?=
 =?us-ascii?Q?SeFvB0QO6LvOWy2ty2Ol0HM++6lKJZRvEAXcMJD55GN3p16uZBJtxMWS4Zg9?=
 =?us-ascii?Q?oVGb9t/XAEzzIOuXfRl3yrqDOr3BPhE3Ht5IzmzSn5JQDD8HQMFVUt1kli+b?=
 =?us-ascii?Q?P1IUeCBgeliON4z5JvX0ip5xgpp1kku38oODEG2qwUgW2ClqXAGSxqdPc31j?=
 =?us-ascii?Q?J93SEKlz20sQS4/ar19WeN+GQQ44yw0YEvvIuXeDvenqn8VTjGcCfyPZEKq8?=
 =?us-ascii?Q?5v2uPK350eoiYmzovA0/H3yjeM88SAA/HgUShwuoKbAmnHTL+7Y1Tj5rQ49S?=
 =?us-ascii?Q?BS+uGrRCVsQDraxPlBEQN8SzELn1Q0qakYs278TLPAYmD87OTxKsVMj70aKC?=
 =?us-ascii?Q?hZF4q+SJIGyMySee9IIAWhaWbuPs8NVqLj24MMIZg4aY+mWhM19MaZfI/1VK?=
 =?us-ascii?Q?02AsqZ6WmpKXaTPU9qD7rUo89zjbPXgPVwe/C9IgEPjhQF4WgayKNBqoBgsN?=
 =?us-ascii?Q?6G5ucp600JzwYbRcP1pDn1xva9X/3L+fqmJIeUAcxq78M2weeb1AD+alysv1?=
 =?us-ascii?Q?Es4RE8biKMZI1U7ZOb229MuHPQkV2OJCuIH5COdszSrd73cawZO0pZhWtHts?=
 =?us-ascii?Q?u+lIxD/M+ABgRJkfHKSeepk0Sik3AYygy0DscH/TCzFXwUPLALeX4zQHzdBT?=
 =?us-ascii?Q?H/laXqwUbpe6wNm6LR0Nq0H548V48guGOHoUOyM7GMRzLDfGO/vfnpEfnXC3?=
 =?us-ascii?Q?ufJNAoq6A9PCejvimAtRYaWcGngr2Dz/Z5R2SqIZ842CjOaXnXXaAfOMmuFZ?=
 =?us-ascii?Q?+tvEExcSDR73tqQyli8BMqM8R5VgZ3lfjZRZoANvj59cHpVHtj7kCvkmbv4B?=
 =?us-ascii?Q?FRozl5wt5TgKxXp+5DLdio+VPa3YDLuUJGxaFwllGVLAtjd0oDG4pY0tLm04?=
 =?us-ascii?Q?WP9Lp3blyd4K9D5mrShCNhC8XxyGXy7HsgUBwx1fxh5OB0Bw44s7e95qcJJa?=
 =?us-ascii?Q?6pvGcX83XdoH7JOv6pnSM1e3nsOw1YxYzYKor+cgSmLiuo2eJB8+/Kc5DTHb?=
 =?us-ascii?Q?H8ZYnvn1inoscYf2DmqYh/0JcKlRiaeq1KF0GQS3fo3NWyqZbxSXpzD9Cg3k?=
 =?us-ascii?Q?YPN7Olr5UlDt8fXA9oOlJYaHCrR7k4pVNOmTPjJATpqu/YDezmsnuoGU7q7r?=
 =?us-ascii?Q?+DitUhPy8BHLwV1VSvfFKiI/wOHQaCc37VKDT3zUE7qe4zrkSQcf/v/h6E8O?=
 =?us-ascii?Q?VRi4OY73u2bQpOk4XT4bc+fdanyNgdktkPDriJpBKrOOKxg2kkcsCE5Imxy1?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wZf9/HShkNJvm0sADBzaeVwoDjQPtNMSiFbY4G8y9dW9gW+lr3ZByWDaKoQfiuXuoogxiEaG00/kOKtjlSxSEugGi7hhNeiXv5d5g+Yillf01JRJtD9RIhtidoMdR677kwXSwMxo/HNmprz+T3mWg6X3EPozPnRhaFMuFt0EkKw4+Nwy/6La6B7I1N7pi2t963KJgUqZ8qm9VL+TrbhIpz5YaS26k82PM2onvAyweywnc6chg2MGmQjsrHgCr4UupJR54JJAyPNRSR3hjrC1vcvKYSRchroXitvmXhgZOQ3MKJfLdvwQWWH7YNdGFVqf9tGHuU9QX++tyfaLB4jSTqvCwX62IfzCImAQLi45sksj95nrM1YqY+FlwvdmRKMd4/KC34Y4VUxSO7Yv4fwyOUpmCIBJaslsHS2KE16avaiApwnnwOsQbvHsliWrTny9dMXca6lYfxY2VJvomssGctz4PKV12iJJhSZUzxFxyKDLtdzf/xhuy6wzOwuIFI4/653fCYKMldz2cOsu5/7979ScljMw6gnx5np57RNhBoaSC9eO1+libbd63QxHHd2F5UaaFwDYuUlLO9uajXtNismnpdpWEusRKykVJckFkbE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0607ffa0-6207-4980-1635-08dd2b36664f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 14:04:40.2364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlcFCECXWaRGClC9UYnJpNvqvBeAOFImG12Zf42xmdkSib5BI+klH/+X97lLrp+DaMrXFmDUzQnGECNNKeDbOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020123
X-Proofpoint-GUID: _6j7UDFficM33KmuSiyEAPLOTX8plNgK
X-Proofpoint-ORIG-GUID: _6j7UDFficM33KmuSiyEAPLOTX8plNgK

An atomic write which spans mixed unwritten and mapped extents would be
rejected. This is one reason why atomic write unit min and max is
currently fixed at the block size.

To enable large atomic writes, any unwritten extents need to be zeroed
before issuing the atomic write. So call iomap_dio_zero_unwritten() for
this scenario and retry the atomic write.

It can be detected if there is any unwritten extents by passing
IOMAP_DIO_OVERWRITE_ONLY to the original iomap_dio_rw() call.

After iomap_dio_zero_unwritten() is called then iomap_dio_rw() is retried -
if that fails then there really is something wrong.

However keep the same behaviour for writing a single block, i.e. we don't
need to pre-zero.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 9a435b1ff264..2c810f75dbbd 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -578,10 +578,47 @@ xfs_dio_write_end_io(
 	return error;
 }
 
+static int
+xfs_dio_write_end_zero_unwritten(
+	struct kiocb		*iocb,
+	ssize_t			size,
+	int			error,
+	unsigned		flags)
+{
+	struct inode		*inode = file_inode(iocb->ki_filp);
+	struct xfs_inode	*ip = XFS_I(inode);
+	loff_t			offset = iocb->ki_pos;
+	unsigned int		nofs_flag;
+
+	trace_xfs_end_io_direct_write(ip, offset, size);
+
+	if (xfs_is_shutdown(ip->i_mount))
+		return -EIO;
+
+	if (error)
+		return error;
+	if (WARN_ON_ONCE(!size))
+		return 0;
+	if (!(flags & IOMAP_DIO_UNWRITTEN))
+		return 0;
+
+	/* Same as xfs_dio_write_end_io() ... */
+	nofs_flag = memalloc_nofs_save();
+
+	error = xfs_iomap_write_unwritten(ip, offset, size, true);
+
+	memalloc_nofs_restore(nofs_flag);
+	return error;
+}
+
 static const struct iomap_dio_ops xfs_dio_write_ops = {
 	.end_io		= xfs_dio_write_end_io,
 };
 
+static const struct iomap_dio_ops xfs_dio_zero_ops = {
+	.end_io		= xfs_dio_write_end_zero_unwritten,
+};
+
 /*
  * Handle block aligned direct I/O writes
  */
@@ -619,6 +656,63 @@ xfs_file_dio_write_aligned(
 	return ret;
 }
 
+static noinline ssize_t
+xfs_file_dio_write_atomic(
+	struct xfs_inode	*ip,
+	struct kiocb		*iocb,
+	struct iov_iter		*from)
+{
+	unsigned int		iolock = XFS_IOLOCK_SHARED;
+	bool			do_zero = false;
+	unsigned int		dio_flags;
+	ssize_t			ret;
+
+	/*
+	 * Zero unwritten only for writing multiple blocks. Leverage
+	 * IOMAP_DIO_OVERWRITE_ONLY detecting when zeroing is required, as
+	 * it ensures that a single written mapping is provided.
+	 */
+	if (iov_iter_count(from) > ip->i_mount->m_sb.sb_blocksize)
+		dio_flags = IOMAP_DIO_OVERWRITE_ONLY;
+	else
+		dio_flags = 0;
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
+	if (do_zero) {
+		ret = iomap_dio_zero_unwritten(iocb, from,
+				&xfs_direct_write_iomap_ops,
+				&xfs_dio_zero_ops);
+		if (ret)
+			goto out_unlock;
+	}
+
+	trace_xfs_file_direct_write(iocb, from);
+	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
+			&xfs_dio_write_ops, dio_flags, NULL, 0);
+
+	if (do_zero && ret < 0)
+		goto out_unlock;
+
+	if (ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT)) {
+		xfs_iunlock(ip, iolock);
+		do_zero = true;
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
@@ -723,6 +817,8 @@ xfs_file_dio_write(
 		return -EINVAL;
 	if ((iocb->ki_pos | count) & ip->i_mount->m_blockmask)
 		return xfs_file_dio_write_unaligned(ip, iocb, from);
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		return xfs_file_dio_write_atomic(ip, iocb, from);
 	return xfs_file_dio_write_aligned(ip, iocb, from);
 }
 
-- 
2.31.1


