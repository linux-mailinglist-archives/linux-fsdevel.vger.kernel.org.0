Return-Path: <linux-fsdevel+bounces-25806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AAE950A6C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 18:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0332843CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 16:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5571A76D3;
	Tue, 13 Aug 2024 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gKXa6UL3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JJaiom+d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C3E1A2C02;
	Tue, 13 Aug 2024 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567073; cv=fail; b=uJGHGlL6jyEtj1oIkkkR3G/Pymgiy6lfmWexc/fjSJRTlHLXcA4lBbMH8A5OAeRVoA2tWft4yzFaHDJlFeMciDYkQWVPBqyMa42zMa3HdaA3K/tDlVavY/S1DYcbE/CanTTVRz25BadzrKYPzpmFnlBG7ZuxOlL8rSgWkMhIVLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567073; c=relaxed/simple;
	bh=J7nW7NGX1C3BFAJ/BjB6wyd39e6bDxHVba+UPYW4R/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P0txsJFboPA2ZA9fIG+63z9N67iB4im33i2y17HesJEeXS/DFELf4LhiP2n+Bi0e96jaA44EyMMXNH76qxWU/lFf3tD5zNeoCOIipAtN2LRQVby1eJB7G00jugSqKWqdVh5fJNSze/2kruD/GgRv9/rjg4brmeXHK7oai4PWd9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gKXa6UL3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JJaiom+d; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DGBSW9016458;
	Tue, 13 Aug 2024 16:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=x2Y9J1eaCYNgKkvbgENOkf+92iOUJ8DTF29UgVZMx9o=; b=
	gKXa6UL3ul5SwKK88ShK1lVU101IgW5kH36W5oKnRyJkxDRenjQiD81ir7F//5PJ
	S3QEmS0IhJhhNGchfs+shCGEPoPbB6Ir10Pqs/uNY/iY5G/htOVPgLzNeQCimn4p
	rBx+JM1MuoLGZh7ZwgBhg7xokXpW/duXB4X/grwIR1fB7o/CQj+Op6VvjAR+uxlA
	KFe0xGbc87TSKfXeJVBwO0IBOtUS+LsmvWFo7T7Iu14zVKqhCMg1wsrwbJGGWDTb
	KQ/arZH7K/YY6XcpoFwjBCPsIPni+Y+MkTz5U3dFdGrsrQUVhAg3K/CdiEm4EiU3
	ePed9DSR9zbiRqAXmqtZKw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4104gagymy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:37:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47DGH99H001485;
	Tue, 13 Aug 2024 16:37:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn8qkvm-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:37:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eN4aYk17IIsdPE+V4x6mzz1VbvOk33M5PMOFjqSLOv5bdZPXjbyz1HAxcz9ZbQFL5Z55dLxh1B5f1JnlCegzR8vrkuq/WvpAshrawPW3VKehT0IRH7SVJt1Y1Ya7i5S/+vsvG97PwFlRpwIxQYMARCc/GJggx1DFdz0uz/A81hNHfqCssMY/54RZ5wCO+v7VZIGwcNw3wkNY9fBJ6yTXOAms/vXrz0wXl9rcBj2z4CO5fVC0GT+5NBMRZ++3c6pGAjm0z9m6PnldAzd6sWs9BD8ifBbL5SqafY/4w3+X26A1afgekhzwvP1+B5qxr8lcHwZRJLCf3No7o0NIPSnh5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2Y9J1eaCYNgKkvbgENOkf+92iOUJ8DTF29UgVZMx9o=;
 b=yx1W5OGPSoffCD9Sb++JlGgXTMxXEjOH9gSk1TaKZne8PzHJLL8TYHPKBBYN+Q3LJrtAUXCE2eYNpAtkUA9IjDpzcyHs5TCm2vILKTrYq0WYRF7ZByp/9uD0Q1cSXd/O587LKRTViZ4Bk4zcP/aXGOEvnEy5IQwX3j1fr1izlnOw1WPRsz0GpfCoswW2AOhDiL/CsLDjhQHDrbWEIW6zREOntk2g4pdDAS2ymAkw3emEV+CQvD2CQpQ/jlNvx6fEI2PSbovNcehKjslr7jhfa0SMIJDVGzdMtYnC7SHkcbV+JXqkUFOgmtyYyamDG2bf0/rrnULSTzinG4aRa/9m+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2Y9J1eaCYNgKkvbgENOkf+92iOUJ8DTF29UgVZMx9o=;
 b=JJaiom+dc8l2OY8JP00HvTBxQD6U3ZaGWOQBNEXnvN7q/JYxI+ug326YOjbLRLl0l1y1Z6PMZzP86h7FEkM0lY5c5S8FGb1v8jeKSf96HxSXWm490kdfBFAKhLD11hykGtmwCd3zITd898O3/zuHNFZwhIqtbp28kYgWf5xcazw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5747.namprd10.prod.outlook.com (2603:10b6:510:127::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Tue, 13 Aug
 2024 16:37:30 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7875.015; Tue, 13 Aug 2024
 16:37:29 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 12/14] xfs: Unmap blocks according to forcealign
Date: Tue, 13 Aug 2024 16:36:36 +0000
Message-Id: <20240813163638.3751939-13-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240813163638.3751939-1-john.g.garry@oracle.com>
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::28) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: c307448e-939c-4d25-710b-08dcbbb6392e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LGPfUNMGJqyd6CinO3yUppsrtlXrZUBzw9w5fVgmBi2MgbSRBFff9FKDNvIS?=
 =?us-ascii?Q?01WaN+q8QtwPGwnb6LJHj1LQYR4sQrMqaU91xaU01K4KerZy52hp1j2xh/oP?=
 =?us-ascii?Q?wlRJioCnI0dk6sEsvQ1/lZIhuwNwxWxoMZIptQElhyTASIDsY753b86Y/EuN?=
 =?us-ascii?Q?wCBfuaHbkoxgzH6BzgPjteWE1smg3JnZH1Hl5KZBOTI/pNHmpGfRRr8z5Irp?=
 =?us-ascii?Q?9BM3v/h9WvBL7Kn/QKkCMWggpsMSKP9REr2SOZIiRKIyKrg6vLP2NRtKwmEV?=
 =?us-ascii?Q?OJDwtaYdPFNl7Lct1uXt7AsWDqW0i62y2to3aau9xy2vZsFrQxESXzfEjKnD?=
 =?us-ascii?Q?yN/9/CBQ5j+lfn5l+uEc7YZAugHx1ALqsBO4jmI+7qmGRfYOx+Ub979K2nJz?=
 =?us-ascii?Q?6sQU88dkXWclu2r1Zu1S0GcxcgYSHCB3sBgMOmscwq8MeLcuNCw+ig02fAOl?=
 =?us-ascii?Q?wa3vjCtRlgD8KqshCM+ZR4w7JdksLvgFz5XQaw4yBad+vJH1d90EJfELnPMt?=
 =?us-ascii?Q?KaeYe4ZVbzHxsXhvK01MqqC52etKtlQC9M8hj3ZygdU9ug+1KUtm8HBjzjnE?=
 =?us-ascii?Q?4gM3j7quji4BslyD294xCDmFo07SsfToEwvPC9kpL5BjS2prbd8fFWb3+FF0?=
 =?us-ascii?Q?gmyqU26tNYjkEu+UkZ15gxgqQze7yQy8S8xtTxiqimE3A5yn2j8IZOmWfluM?=
 =?us-ascii?Q?Nksi0JNAhUcMTUYcop0sGG1nj6ElVh+T3ecUyQyaJdAWGnC18qYhU5MLDnMX?=
 =?us-ascii?Q?+wYUGSVmRCpx10//CukpH5LWYEfJdJOOkxM450GXUO2Bp5BN9Tq7ZJgx+dYa?=
 =?us-ascii?Q?dp56kYEQPvKh4N4f/kXC3CNZ+BqD6K6P9gU3p5NHOsQ34Lf2+XOt0sovnmWV?=
 =?us-ascii?Q?TiR+tjmrzDYVeJ0AQhTni5Sx6u0J19MkksbjOBRDlA/2LsK8Ie8auQ+kmmlQ?=
 =?us-ascii?Q?pxLfNOn4Y4UT3ryAs3fYU8yjqzKe4nPWzs/c3bOt1yOxJdjpZtfbg+llzQve?=
 =?us-ascii?Q?Oad+yQJVXyVMKrztLm+3vOgqngi0vnIYQm+bBEiNopQlHTO34kyFDbvgDIk0?=
 =?us-ascii?Q?tai2AXdcT3oGQ4OwdTBeGrbCoL7esMTWjtFajzhEKkg2YIzJg9lnKqoDo+4S?=
 =?us-ascii?Q?CcnJjJR3Zf4B42qD97+Z8E+WKv6mdBw0JjiPjEBKgoJP+35zRTpkb9XUC2uH?=
 =?us-ascii?Q?PJFCRl4lHk8ulcKRvtsWCOZfBTX5Kj7BGMM6hjNDjAWcC5PeP0s7pVwr7GW4?=
 =?us-ascii?Q?4mR0mWtbUZ+dPvOdf2bIMagUEwE8jPfrOc1olKth7zy4VqJ/6+d/ejoQ048A?=
 =?us-ascii?Q?4G3PCbm9biyCG3/qv+PSaRMLK0K7TMa3/eRLnJsVY371ug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C1Wu+xqBQr7Oj9xK8idjCSNcxRgzDs8kcBufIhFwoaVLlPk2fdkYuy/rOXm5?=
 =?us-ascii?Q?aSzuUz9zjF3VVdXJFEI9MLgUAE/ABdKoOLbug/frArln1wVXyIUexAunt9d2?=
 =?us-ascii?Q?gy2hObKHAlYP2+LMcrLm9XV8weUv/xdFbSWG54yMljKUBF9Vg4rNDcrJ0Z1T?=
 =?us-ascii?Q?Jx6KyeZ+f/AEF/6C9qnCuxA0Ajz01tqi0W/LHawCnIVHXk+E6l9OgK7P4af2?=
 =?us-ascii?Q?948JM81xO6eK+E0h0CVQWMpcuBReMOOt1F660Ix+fvsQc4mXWeVVhY6CMTVl?=
 =?us-ascii?Q?d8/UzgxdUjOJKOBL9YBPuNTdMcxFFycOHUJErAQY1s/q8iKN14yAk78NI5h9?=
 =?us-ascii?Q?t4WzK1pdPWNFwO0mq7qp8nV807ALFDLldMi8VCjpzGa3ABseDNvep/pVfCd+?=
 =?us-ascii?Q?vabO77HCRDu+T+C2KKw2CzVT8dacMmPuMLzTd+jVvhXdbChbvsQcdjjC7nX9?=
 =?us-ascii?Q?db+A7rhss8nuwnW/5w23VjWE1ehZKHKS10aGU7hKLs1L4GGrOf01/qv5sPyD?=
 =?us-ascii?Q?bTJF8FIJ3Pq/Scm/jzXUAt2zbqERgQM1Daod/EbiFcyMqWorCvU25tq96Rc+?=
 =?us-ascii?Q?kCAsNFJ2wQco1BcgAc+li7ARdzGxN9YZxskv5b2Zo3uQY5HFd/NTuxDQLiM/?=
 =?us-ascii?Q?tCjZ5Sy0Wj1hc1lPxDsZqhEutZHAUTNwxwwCYuEuRPxAcO5eEr758lVtwcbB?=
 =?us-ascii?Q?/WtqE3C4gtZN8KH4GETDMIHsBuKmRhWd8NaDRlSBE8c1g8ipArdFDdaDREKM?=
 =?us-ascii?Q?WUs3DaOtA69dZT82N1MxLZEV2fNgmFf/S7REyxKkNX6exPALEo2jIdGF1YrV?=
 =?us-ascii?Q?O1CmqzylHd02mpUHoz21QtRd5HoWKNXuMkOmpgE5dsSzV5e5RmmQ1L7NyKi3?=
 =?us-ascii?Q?cxrk2CY6S/8NPRAEXiuOszGV+pDjbgwmw4C4vMwAasqGA7ZBnnsyRYaLWTRp?=
 =?us-ascii?Q?RNaSKn0FTSvhoRz4RkUSCm2ApaNaL4x838xOL6A6hwQIVLSHav3EJpK6qoW1?=
 =?us-ascii?Q?yfCF0mepJYPHMUX84mUuIS2kjeaZL3PU00NwJXXE0MvowsFA3MzWjYprhR0h?=
 =?us-ascii?Q?MqmhFvhziuDuw25hLiWKW7gcRaBgFY1yY8xqZpRdWaMyjeebOf5PtReQODaX?=
 =?us-ascii?Q?1iq0MaQXQJv3KENRBAIN3mZXQrj29D5/FhjgBBFYVof3QmO0VGHED7wniblN?=
 =?us-ascii?Q?wcZ2GaaYA8bVu37gCP3MTf5/3BDABe3iByxvIji1DeH0Drwc40RJeJAhBDG/?=
 =?us-ascii?Q?ppDkk70bAFvJsQfEQ0GDXBtUuEIhYjVUMaYlkxucajCtiBZIvM9PwClQxGRF?=
 =?us-ascii?Q?d1IRubVV/uhjN4Y1UXermMKRwLUkCeypW+AANJZzhpVibC5rVYN4hCBSHb1s?=
 =?us-ascii?Q?ZrabxO65xNfRBqAK8wencYkzKeutF2KjIkBzg/VHCIOkiXNOZVigo/AU0bA8?=
 =?us-ascii?Q?BT9VYoUDivVXzVRFOez21B983CUr545xR7g78e+4ct86utw+hq2uCYDVeuxi?=
 =?us-ascii?Q?qGrGobTR7YXQV6gC2CYO8UWpAAmPBVJVh335RRlljuwXSIGdUDREjh+j1lSu?=
 =?us-ascii?Q?MYbxMTIz+qRBgV7L+m+13/s1+gy0Bo6khMm/c0VfufhgleXIN3h7Poh7e4yL?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I7VnBZhIYPqA/qXRgYe+boP1f+5d0fjVC+OnOydB2Z+/jpPXgqCql+L1mdrqwsXscqBJAS9+zmkQdJIwP7z3mx2uJIFQi3f4ZDm6dibruTOawIpQCADwuljMjO7vTqRa1YgnzLuV37AXDotdm41dzbfPU8YB5LB0aMMbKuTsn3z+VwAniaQuLcFWWyDDcDk3gJUwazHULOWgQA7VS5gaCHbolTngdo4pRPtRy+h19/VpltH0mf4mH0gQJGWeFkb/BBKnYEsX7zrxb8avNCyi9xEen6uOnIt+Px+cf/KmQBvBxhGANIbS8DdOBep9LkaDVAPtwND9Mim9wzu/j+ubPse01QeiAAS43x72HFuks2D+EySexiNIEluIjo0zOMzCHzKS2CYgne80t9hX/WTPzZzLJFdWXckxcdGhehycGcqbUWK7LdRDbE26xpBCNOO6xaSUEhDaOJF87BpjIFRJm3bClL0HbjYeHbcX8PeXwH76oBWGszL7euK+HoDoC6Ay6PYZ+XwLd82bvgf+DPOKJQYma8JGtsfMk+3Odv5Fo080UBtuk2AgpNgUzea1+njX5J/3aLU7tq8fkJdv9LvW194hAQXNX1GiX8TGEjb2aZE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c307448e-939c-4d25-710b-08dcbbb6392e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 16:37:29.8925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z5acMMlF/JTE2tdiRxZSOvVCwONQdQQ5krqzCC99OJXAGJEIEASEDpSTW5y0hA/Dr6WKuKjfS+A4ziJTMIHsTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5747
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408130120
X-Proofpoint-GUID: 8Wb-OMpPiOVjq91gEWtLKRukE9jkF77e
X-Proofpoint-ORIG-GUID: 8Wb-OMpPiOVjq91gEWtLKRukE9jkF77e

For when forcealign is enabled, blocks in an inode need to be unmapped
according to extent alignment, like what is already done for rtvol.

Generalize the code by replacing variable isrt with a value to hold the
FSB alloc size for the inode, which works for forcealign.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 46 ++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 0c3df8c71c6d..3ab2cecf09d2 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -5409,6 +5409,25 @@ xfs_bmap_del_extent_real(
 	return 0;
 }
 
+static xfs_extlen_t
+xfs_bmap_alloc_unit_offset(
+	struct xfs_inode	*ip,
+	unsigned int		alloc_fsb,
+	xfs_fsblock_t		fsbno)
+{
+	xfs_agblock_t		agbno;
+
+	if (XFS_IS_REALTIME_INODE(ip))
+		return do_div(fsbno, alloc_fsb);
+	/*
+	 * The agbno for the fsbno is aligned to extsize, but the fsbno itself
+	 * is not necessarily aligned (to extsize), so use agbno to determine
+	 * mod to the alloc unit boundary.
+	 */
+	agbno = XFS_FSB_TO_AGBNO(ip->i_mount, fsbno);
+	return agbno % alloc_fsb;
+}
+
 /*
  * Unmap (remove) blocks from a file.
  * If nexts is nonzero then the number of extents to remove is limited to
@@ -5430,7 +5449,6 @@ __xfs_bunmapi(
 	xfs_extnum_t		extno;		/* extent number in list */
 	struct xfs_bmbt_irec	got;		/* current extent record */
 	struct xfs_ifork	*ifp;		/* inode fork pointer */
-	int			isrt;		/* freeing in rt area */
 	int			logflags;	/* transaction logging flags */
 	xfs_extlen_t		mod;		/* rt extent offset */
 	struct xfs_mount	*mp = ip->i_mount;
@@ -5441,6 +5459,7 @@ __xfs_bunmapi(
 	xfs_fileoff_t		end;
 	struct xfs_iext_cursor	icur;
 	bool			done = false;
+	unsigned int		alloc_fsb = xfs_inode_alloc_fsbsize(ip);
 
 	trace_xfs_bunmap(ip, start, len, flags, _RET_IP_);
 
@@ -5467,7 +5486,6 @@ __xfs_bunmapi(
 		return 0;
 	}
 	XFS_STATS_INC(mp, xs_blk_unmap);
-	isrt = xfs_ifork_is_realtime(ip, whichfork);
 	end = start + len;
 
 	if (!xfs_iext_lookup_extent_before(ip, ifp, &end, &icur, &got)) {
@@ -5519,18 +5537,18 @@ __xfs_bunmapi(
 		if (del.br_startoff + del.br_blockcount > end + 1)
 			del.br_blockcount = end + 1 - del.br_startoff;
 
-		if (!isrt || (flags & XFS_BMAPI_REMAP))
+		if (alloc_fsb == 1 || (flags & XFS_BMAPI_REMAP))
 			goto delete;
 
-		mod = xfs_rtb_to_rtxoff(mp,
+		mod = xfs_bmap_alloc_unit_offset(ip, alloc_fsb,
 				del.br_startblock + del.br_blockcount);
 		if (mod) {
 			/*
-			 * Realtime extent not lined up at the end.
+			 * Not aligned to allocation unit on the end.
 			 * The extent could have been split into written
 			 * and unwritten pieces, or we could just be
 			 * unmapping part of it.  But we can't really
-			 * get rid of part of a realtime extent.
+			 * get rid of part of an extent.
 			 */
 			if (del.br_state == XFS_EXT_UNWRITTEN) {
 				/*
@@ -5554,8 +5572,8 @@ __xfs_bunmapi(
 			ASSERT(del.br_state == XFS_EXT_NORM);
 			ASSERT(tp->t_blk_res > 0);
 			/*
-			 * If this spans a realtime extent boundary,
-			 * chop it back to the start of the one we end at.
+			 * If this spans an extent boundary, chop it back to
+			 * the start of the one we end at.
 			 */
 			if (del.br_blockcount > mod) {
 				del.br_startoff += del.br_blockcount - mod;
@@ -5571,14 +5589,14 @@ __xfs_bunmapi(
 			goto nodelete;
 		}
 
-		mod = xfs_rtb_to_rtxoff(mp, del.br_startblock);
+		mod = xfs_bmap_alloc_unit_offset(ip, alloc_fsb,
+					del.br_startblock);
 		if (mod) {
-			xfs_extlen_t off = mp->m_sb.sb_rextsize - mod;
-
+			xfs_extlen_t off = alloc_fsb - mod;
 			/*
-			 * Realtime extent is lined up at the end but not
-			 * at the front.  We'll get rid of full extents if
-			 * we can.
+			 * Extent is lined up to the allocation unit at the
+			 * end but not at the front.  We'll get rid of full
+			 * extents if we can.
 			 */
 			if (del.br_blockcount > off) {
 				del.br_blockcount -= off;
-- 
2.31.1


