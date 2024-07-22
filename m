Return-Path: <linux-fsdevel+bounces-24058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D15A938CEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 12:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1F1AB24B68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 10:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED2816C87A;
	Mon, 22 Jul 2024 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BSXw/TFT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bIUOlDMW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E18716C841;
	Mon, 22 Jul 2024 09:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721642339; cv=fail; b=WO/gxgsxnjz8XbFVxadywaGroblcy59D3I4Wld3n/liykASDGhfLgkk8Z4H7C++yD7OyK4c7S0ajWa1kDCQyg9ZBb0qsllimWaUUqt17UiByzEA0RSyGANMKAgI50O7j466qaiw1X51Ap0gR1XolABgXzEqDDg8yQpo76sEttHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721642339; c=relaxed/simple;
	bh=EZLnzSaHtauUFq/jfIZ6wCZyLbg6lz8UW4dp6IqGDgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BhrN8OxvnYsvLt8yQzgj4xn7zVh8ecmzfQc7FKZ4eWqChMIYUXlZm7Fua2KJZ1tHTveIt128RPS44PkMYpvrQW7yPb0bzLhwvbedjrLax+RYxuEd+bTPnhkP2WswL5bn4USuAUAdRABGQPyugB3/vL5XtTRJu8KHNQ1/bGE7ObQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BSXw/TFT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bIUOlDMW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46M7cu30031930;
	Mon, 22 Jul 2024 09:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=FaQe4E8VXUUnm+VGCUfgguoOs6y/mov8H9ltDweTpeE=; b=
	BSXw/TFT+X/C2e088taMnckyHsBXKn+dae1fJet/en3Cu63xfgtANPJDGPhzmN1G
	o5Q5O8fq/dWBR6b/aQ/9EeUBLmFnfXKJbNF/QtriKUJ+uMzvd98rZ+Y3CViqxNOi
	e/4Yjw7N0VwKmpUJDTL3gQrPDNcMb0i8jQ2VAjlUs4HMZ7X+C9I5Q1wqbh0/H0TW
	FAv44+FbTWlhKv0013N24be+GPBz6XNcBmbNPC/WnzuqgZHkAfzkDxga1VInDWcC
	p30xx7UE79Ex1UUjHw7YEXGaZfvcsnhDyuvR5oxPCi1s40UsyQpCXXlFVHhK9BIW
	TbaOKABCfNM/dxt+dmdWcA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hfxp961t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 09:57:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46M91iDq028580;
	Mon, 22 Jul 2024 09:57:50 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40h267q6w0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 09:57:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwVEW1qs4bob3KddfWPcULhxWrVsSKXDC6MJt/tXBbAZiGqF7dczPNh3YVaMnJoCHQjt7v7jeFFCgDYOATme0JqM3OO8+XVS5tBgmdwib0j2I2e3CLs05q8cVtiYKEYYN6Bjsozyo6Q5N0FAR1LrIz2/YataYUexHvKzyuYt2TIvaj4MuyYEVgnsERu1wSQnUKiXxhMCQexJD4/+kDBPziw4RRedBSi9G3CCXuf+W7STp32SiQqmB/+3vcyPvWJmQJil7oP5flEDnbUE7AwFtAELC86V7A6d0tJtoZJ52e5igEF+jwEgf1H+mSUd2SUzdl24B1IWSJEYz8qrL1hKtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaQe4E8VXUUnm+VGCUfgguoOs6y/mov8H9ltDweTpeE=;
 b=eIT+zd/jwat6JIKtloQUX9tWtXOH27fCeQmDzDqoopxboyHeU1oZxBwuP350+UtVDxvMLtgWpDYh0Zvr330hB2TnyX7kSbHN0i7SlClXFs0Fdzl5CLyxHSJwpKEPXA5Hhxi3il9FCYIt3+cv/daoEczNZ0dgtGMdMRb8s94Dt8e3y5bhej+gQcoTldCrLfd03TCNzPf0BLsQxwoZ3b+is2ZNHLTPs0krGZVHLnZBVYGnFYjwvj2SysFLqkLkbudgf8zGNHO2cngGt6bh4nU3wbam+mTrqBBGkaKU4wQBLrthy+SuiCPJ8YeKp02dKMfDz4jLAbTiKdE4dh1rWo4IEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaQe4E8VXUUnm+VGCUfgguoOs6y/mov8H9ltDweTpeE=;
 b=bIUOlDMWPGgo4O0Zkq8uFpcPhZ1YDV3EfS3IBgKH4EYXUmJu5P2zZLGvdkR2cyeEAZcQNxC/Zj9ieluwm25NS6WLEKGK5XrYBHrGMlLf3h9PpbEKb/maPywoA+PgrGmk5v6m+6pwMkn6GCqHzmlMgk/6MwFmAcLrjx6lTI6YbAw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB5595.namprd10.prod.outlook.com (2603:10b6:510:f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Mon, 22 Jul
 2024 09:57:47 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Mon, 22 Jul 2024
 09:57:47 +0000
From: John Garry <john.g.garry@oracle.com>
To: alx@kernel.org
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        hch@lst.de, djwong@kernel.org, dchinner@redhat.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 3/3] io_submit.2: Document RWF_ATOMIC
Date: Mon, 22 Jul 2024 09:57:23 +0000
Message-Id: <20240722095723.597846-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240722095723.597846-1-john.g.garry@oracle.com>
References: <20240722095723.597846-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0204.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba062ad-1e46-4d00-fd55-08dcaa34bda9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?msiBNNoJ+pdlN2kDQInqOELdyuu7OVuXChP9mH1hCMqbII+RRX0158LYR44N?=
 =?us-ascii?Q?HOcWXa9ajD2wScJP277MVwKbs4iMlU879nTXmgr3lH2ZKVmsn3yLWUbGqL/a?=
 =?us-ascii?Q?+DiQJ/EwlPVkRWLhdu1ILinvuhVDuhvElH/qqjlFLEIID9bjgw5Q+7osrs6v?=
 =?us-ascii?Q?090/uDlJ/sYmfvpsvNSZYh25nnCY+wTi1YVARmHqK+9pDaCwkMbamOhhWwJi?=
 =?us-ascii?Q?h3UNFwEyRt+IqT0p7FLufxJivILy49VgNBHBSxcnUlLaeCGy2oqLkWM/V0JB?=
 =?us-ascii?Q?HppVMJLRiopmdgs7DxGL+9Sd+JFOngxBGROnygEcuobmiDzVqX0GTigH37cm?=
 =?us-ascii?Q?yTv76OUhF1R1ZlL74mt9s4z0KRX8Nyj7RpKIWGzuZ1MlmhPZ1nv+vkM5ewYI?=
 =?us-ascii?Q?1FiQohSiAdCa+UcQI12vkGI7r+gbvssAoOtrGUfoG+apayvSSsVxHsc7LoNe?=
 =?us-ascii?Q?0dm3sp5SIQV6CjPOAcgMA5qS0MHw+YDX694XbZJOrOSeNTeHpxhGsgWh8L9O?=
 =?us-ascii?Q?T0vuf8JGtEb1fAuIJQh7PVSXy/FZ6wmfWIiX6OVOkz3dNnf//ZcxjmA/VYME?=
 =?us-ascii?Q?vcXRmbc1proCu8aQaho1ZtPh2HkVwB8kXmoxgZewGF2FpqyJMAUoSfRg+M5p?=
 =?us-ascii?Q?dM4Se2urqhb8Q20Fv6vTji/5ESO536xECX/P5F9027+fJhedz9JVzBpdxAbq?=
 =?us-ascii?Q?cwl9EREG/3VUQWcGzG1EX9kDzy0KgyXf7cGVn74BJ/HERWxNnOFPBFbTWrw+?=
 =?us-ascii?Q?oibaaVLita2/AsRcwYMMyPnFjVJVO02wLF7B+6txs611GtaIs/y0AHikwsLZ?=
 =?us-ascii?Q?+Snu4Q5MvWzaYZtxZOZfdKouQpfDUkkl2FOob2K7eN50pTIAnTCZnWRZxsz9?=
 =?us-ascii?Q?tTJkSdakh4GKWdD2Nw7ZNByt9EoKb5utmXEhpWkTwbZ4iCErEUgb3T4N42Rk?=
 =?us-ascii?Q?nnkSshqRyIKJXVlcZcEy4crKy7CjRTE0ZAPTBT/39DJlY5SYu20hvD/iSOA+?=
 =?us-ascii?Q?YAHg1JNVjskxSBMdRUgNWgGs8yZXfPbgdorCIBEvtdFASfR1EARqc2exlCQS?=
 =?us-ascii?Q?3wwYXzHIR47HV25VOaGQUow97aOoumUBCmH6e5T374tY9xhVgJ1p6sKwCCef?=
 =?us-ascii?Q?QbtBmJotauO4GyZg1PSi16BDLNuAUW92vIJmcnyqr9OmK5dsTfUK5pa9jCXR?=
 =?us-ascii?Q?xV3UN/TBQybMqLYNrE2VYTKZv+f8bZbEdVno5mHEapzvNZ/beQlU409aTTWC?=
 =?us-ascii?Q?cecmt7qyVVHZtYlDB4cWYvar3jSwdhujZs8o05YcP1LdKxzObPegtaKZn1In?=
 =?us-ascii?Q?0c2u8EYGlC7RQmNSyw+wf69VlH2DhZTbKyYBHcJXzbWslA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mh0Eg0IJgls0sAk36xkiYDiHUB4Y5M+fjqO/YZYqDv2jQdwCR4vfx82CuYcj?=
 =?us-ascii?Q?dFkkNTCocJlWZJO2t7XmpW0ek7wCU4inMTUj3q6ceis2aWEm7VxXQiP49tmd?=
 =?us-ascii?Q?kN82jppblUji5h7oJwc5xh6cWsikp9YvTs8d+VaBZGZHbHMCMijfDrWa1bbx?=
 =?us-ascii?Q?HLA94gNx1j1YCi6ClGonaZudqCGvzjOx0nzYWmAxg+gvGBpP20dFoGGgfbEP?=
 =?us-ascii?Q?rF3lD7wOUm5ms5p0m35SzFRWp2+RjtdSfhdlip56S9MSgQU8/OnKmXBL6RVM?=
 =?us-ascii?Q?N/rLK7HnBNxfLlk8wQGi0HudAeEoMpDiBItS4XqPnzG/58rQCktSzBBiKIUO?=
 =?us-ascii?Q?G/YxbTCKYxMYC5LTIjrc7nO1+vNTO4T0OPM1Lcl6OZKqvZlg6SUqn5VGeRtk?=
 =?us-ascii?Q?e9AGIerRS7cMhsYN4Q4Tdk8BuTXFN9swHwOrJclPV/SsZvJqwLz4oYJ4YrCA?=
 =?us-ascii?Q?L/WrsxiaDLG+mTEoiwfcY7NTZ+WS4pMDROlOr+uga1pi0CluXjbnVcgdJwLR?=
 =?us-ascii?Q?DPU10Qx85lpLoWWdUr45luhqghjU08YgEd/Xq/wVsxLCXtFfTgfOuAeP2tRy?=
 =?us-ascii?Q?1Pd+dxTT+E3xWkNY09hZ5wqHdXQKuo8hS42dQbEjWBKyZXa4IKdlf+PvmrU8?=
 =?us-ascii?Q?Czb688vCYgLKjb9neqTPgCyxfau69kolkMfLvNvYCLXPcNw6pLMeW9bv0TCd?=
 =?us-ascii?Q?uevqv2+cC0gj8I4amYxOMZWbN6jaGdM4v/KETLE8lwqRe0bqTOeZtyAEoRer?=
 =?us-ascii?Q?G2fis6ifBje+JV/KejEQ7TDFLBYt3FR44hrsFBHLxmqZWBj9TpF1Sr/ZRiLE?=
 =?us-ascii?Q?8/r2UKIodCZR64B6tmQslxwrz97K+bHEMLJoDflEXiQy8Zk5o0oIabMZhASk?=
 =?us-ascii?Q?NLxeUYLgv3DirdH2F3O53shduGDRIPF7VfaUf2gkcfl9gystr/hf26FI8ASL?=
 =?us-ascii?Q?aQ83yDeCVzh6Drk/Gs5V76cKZsmbar3ryJTabWM0PKPCDRVzUSprvwQ3rxet?=
 =?us-ascii?Q?XM5aJ0/7oIoYF3aj9UEMz1MyySaDDVGkz+iF4Iw5hNfuVBh8Xw0lIGpqJMjl?=
 =?us-ascii?Q?U80SMziMM27qdPByZIttpUk1nbWnsGDIj7UkaNcSTDhOoCzPB1S0lsuZpLGD?=
 =?us-ascii?Q?V59RJfn/apUXxtzpG4OLQ+zh3a+fr6EOZXe1mbVrxfsML4UsF2PVA0a0vj14?=
 =?us-ascii?Q?wh+0QT9iMYnbSmcaHVITovCCS7UeGUbvzEvk62Mu6D48RgwcsPWzkLlsG99n?=
 =?us-ascii?Q?wT02wKteTVqZAmWQCWWuuW2eklUEMTnfKl9o5XYUTQqE8r7Wtr7B/CxhQM3C?=
 =?us-ascii?Q?8m7CMZj6WLRVbNTxgrJfAd1OVsO35KFwKE0yXIMQCAlZu5k1/5qpGH5bbxir?=
 =?us-ascii?Q?fisds1XkXvip0qzP3fdqHIu4b9w8AGbt+rQwIxAXC652fyfX0Vt48cOOYiuN?=
 =?us-ascii?Q?EzrLc5MVk/FYmILtxBDc2lhhmAjOTG0we9MPJJkuAAf+nlXLyeyE+OJmxFZb?=
 =?us-ascii?Q?zM4JEtG2XdAsL8iMl3PdyIXsjcXNzP/ZcNiB4RThtGDG7TQ384ooK6P3zNcw?=
 =?us-ascii?Q?4dOl304NmvGTEpOVaRNFp3SIoU+l/XapMnnjJ21SPr58tzUE24/KR6nkGnwb?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jU/Ic0eD6zRA4EfTHnkziwSqsPwtDWi7PYLM+PzMO512uevmaTUJDA3LsJVSBYc5HhCSFL5FP4wYugIrNiNr1cJ8rMW0tjMEQREzf8gRDgX3rf82ELFufAKdEFg9c5fvREHPjxTOF7jfd+5ORPHdqdRo+obZojtKfsZ+romnTNj6qlDH+TQcMrZdFeZB8qvpf/m7kmpCglXreQaCQFxldF3rxt53UHG6VeDvA7e13vnoth3gtgh1XRgDXunI3F0k9CD+Z1lWgbe5A7xM5rbM8ySd/mgdrzgEJk1ySc4wnoLIrlOtKxoVclxRUyLYjup5GWZ4LaPF2OAwR/41lxAQVnNg9o+QwRG2dkmXL4lqmWcDrnnI/ibbRrve1LFzIlnwU29v/OkYsftNXOv3YVgW7CUdODvqBJM1PctlVrd+7xS/bvel8T5LP/k6jTFbGXIfKZ/RtDS2+PkzGqc5+nDBQ9tsd5g46ePyDiwZwzeLTzhT7Ly7vbjk7JsAmGbKCCpQa9UPAe6UzbSi3qOaLTP19hUhEH4Qt+xXBKVpFfn176eRp4syVQOthSI6L7nwaxlnB38of6AQEOw5YLykWxzz5JJai3IS2IEMMXpZr56DKIM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba062ad-1e46-4d00-fd55-08dcaa34bda9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 09:57:47.7642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSp4IotYc50JmFD6mkEtMmzzra2u+GJYNhkrmCEALqADWsmjrSiCELFKCa/NwuwkUCrt5KhYGhsHjsU+CHvk3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220076
X-Proofpoint-GUID: XsY6W9O1m5UBbL_H7QxyxON_9Jxg7rEh
X-Proofpoint-ORIG-GUID: XsY6W9O1m5UBbL_H7QxyxON_9Jxg7rEh

Document RWF_ATOMIC for asynchronous I/O.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 man/man2/io_submit.2 | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/man/man2/io_submit.2 b/man/man2/io_submit.2
index c53ae9aaf..12b4a72d7 100644
--- a/man/man2/io_submit.2
+++ b/man/man2/io_submit.2
@@ -140,6 +140,25 @@ as well the description of
 .B O_SYNC
 in
 .BR open (2).
+.TP
+.BR RWF_ATOMIC " (since Linux 6.11)"
+Write a block of data such that a write will never be torn from power fail or
+similar.
+See the description of
+.B RWF_ATOMIC
+in
+.BR pwritev2 (2).
+For usage with
+.BR IOCB_CMD_PWRITEV,
+the upper vector limit is in
+.I stx_atomic_write_segments_max.
+See
+.B STATX_WRITE_ATOMIC
+and
+.I stx_atomic_write_segments_max
+description
+in
+.BR statx (2).
 .RE
 .TP
 .I aio_lio_opcode
-- 
2.31.1


