Return-Path: <linux-fsdevel+bounces-52246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FC8AE0ACF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 17:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4729F3AE0EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 15:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB08E27F015;
	Thu, 19 Jun 2025 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hu47aACw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h6hTeSMz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9865227FB0D;
	Thu, 19 Jun 2025 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347914; cv=fail; b=jJi7hldJAiB0IbWm/wRqmfSjMabMWDAmI4qDftdD5mHQ07kyUY82Sg6v+OshkV4bH3NnXmqFWUXMjsC/7PoGbly8SN1DQ7NcsUvq3lh72pGyYs9s2qyzCi4knWP0RT6VsTWnHPuRvIRLltIVYlDLf6Zjd9jkt8DKgSPsWZyIKL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347914; c=relaxed/simple;
	bh=EP4+FlYJT2N1SXltGOb9EzCXNVYZhMAYfSyaTlfTM+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MExcIfzZZFAxV0TUaYLvado+XQnsoZ9eP9pWkH83Nh0wxDHdQz5pxW4L/NE8wnNPOqK9ptYhDUX6h748sl4k1rMRsTJ+sPAb7n8J2dk7wciKR4TduIt7GsV/3LZw1E2/XDoz4cSavn5kmy3nlgYqaSfdwjcRUNPi7sQLXRFxIQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hu47aACw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h6hTeSMz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JEMaco011374;
	Thu, 19 Jun 2025 15:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rvx6iagq0EOA5tl2k1rH9pDHh87lKk66T1Mn7vuLDYI=; b=
	hu47aACwu11MoiFdIvfTow2piyLBoD7JKebS8noyZ56kGBS/3S8+ySVN84+Mc3Vc
	Kb9LjWJZdRKS7sckTlg0pKFszu1qpmcQCgmv16BwSIrmFp139/KdRUSweCxF8GQY
	JQfDpszMCUL9ThLzrUzzO7DObHDCpxk1gS7HQkMclBHsa14fSdxj0+y+FMpPAfkM
	lOZaju8Tc0lWNJzxRV8uo+9Ik4WRMPCDTB69w3vKirKJOcKnifKgzETJDttPOfDa
	6j+zeSUSZelYgpKyCoo9YLTjdzBmUpDowz047hbesMshWV7q28ZZ+MZEbRkW9Tvr
	6DyHyYZkNfUk+6/uQ1l2Sg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47900f263p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Jun 2025 15:45:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55JFZX4A038297;
	Thu, 19 Jun 2025 15:45:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhc1bxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Jun 2025 15:45:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ux85eP6H/WmRgXgwbpbq1o/lpOWYxdQXgwrRCMKzD0U7Z0qNaVPybIPVhe58LgsmhFbsmK4eeRqVXcacEQB3EIF5acOfTBGykz8jUjTa4XnzgTKfAX7OostQuyhV2Dv35kqtnwB1DdZ63NYKIh+XFhFvmlVB0lF2qJ3yjxKkF7Z9oqAmD5AlXuQFDxIB/ZAa1a6Hmw+OEctxzLfYcsCWgWPgK4WiBDCwKoHS0T3r/dteaRmHzE9KN0EuCwST6ntEXknNGiB3JGScx5TFN2xH/SQg/IzkMc/a3niTQXwk8rhXFyV4/VVqzx0taK6Hr4sSkdcLEmE+Dw2EtsCebaACqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvx6iagq0EOA5tl2k1rH9pDHh87lKk66T1Mn7vuLDYI=;
 b=vPUXGdi9XObc1nrKs1PJNKjDEQIu+VN6wDT6ApnfwO4EjH7qdvoSLbWFdTvrWGV6ewxp5lWlZKVogPdZEHxow+ebYNlnZUa9Y93RzwkaNBhYQn/uY6Zai6U97yXmPQMQSCVZhLQ/MVf9HZvF+BGfdCp1moRKVng/WtDQCHHkwZ8IIrXBvYSfwvUYVpWqXQk9qDm05dIuPz6E2hQ0OfW5f66RRF+LK5oBgVbr830fEgHtuW85+i4kFTL3jnNdSEaVvY2WsQoq2JOnamw+kAbcYjC2sMbzjgypTJmdKwOSMaHgiJfBZJquswnIAHaXVsFRTm8vrF2swjL286MOl9fuPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvx6iagq0EOA5tl2k1rH9pDHh87lKk66T1Mn7vuLDYI=;
 b=h6hTeSMzpjPV1eUwqYvRZ8rJNeiBZ9+nBdEjpacqDVdhgE9Q4sNhk94Jp+Pg1mk1CdjYRUva3TI9Ga4d/yMRJ1hATVmR+hGMlSXmgOjznGDtC/+XCcXrq83K2BL0qHgM+b+az5XQegbqUFg4O4Nbm7HQWHyspmJbJfEcMrCpE0s=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CYYPR10MB7651.namprd10.prod.outlook.com (2603:10b6:930:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Thu, 19 Jun
 2025 15:45:01 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8857.019; Thu, 19 Jun 2025
 15:45:01 +0000
From: John Garry <john.g.garry@oracle.com>
To: alx@kernel.org
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
        djwong@kernel.org, linux-xfs@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 1/2] statx.2: properly align stx_dio_read_offset_align
Date: Thu, 19 Jun 2025 15:44:54 +0000
Message-Id: <20250619154455.321848-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250619154455.321848-1-john.g.garry@oracle.com>
References: <20250619154455.321848-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CYYPR10MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 5abaa703-168f-4a63-da89-08ddaf4840dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kvjto4lv3Vv2vFk3qRekANgMuLM557LVc8kD8V7+3Zb/mJd0c6LLoHqtSyzG?=
 =?us-ascii?Q?oiS9Psc6ZtU+1Gvq4YOMI6R+/S0WQMbEMZI8pYffE84bqN1nuYDkxHdJljl2?=
 =?us-ascii?Q?2jTXIikTr6j8z+V8MR6fNFre+GAT3tkcEgTriDTB8NoUBojYyHy5041aRADs?=
 =?us-ascii?Q?i5aSuiFylC34Es/ChzVhR2sQ2+AunU4OnbKx1bi2Oi+JoY4lratE/mRvrk3l?=
 =?us-ascii?Q?EvSdvnSJkOaGQS7fSjM4N3fpIjn4+5SmCkZlnLZ8rRBeYzhIkh0ShY63zc7W?=
 =?us-ascii?Q?MsK+1Jd2HLiv5VZGX9NYqc2pO/FR/ZWX7c34PLrm1Rz3ivccJZKcLHLrbhPP?=
 =?us-ascii?Q?mtFD/0QSZBQ8NrdRlKtOr5zsmj7YOk6H4z3DoGVwL75ejD1pOw7y7pQ+5zb0?=
 =?us-ascii?Q?TSIOMIrFRf0eG6nA0CO/534QwxZI9eCgbFUKmmRHPzqLbJXCkXTRQGfSHu7U?=
 =?us-ascii?Q?0b6AafchDv3zAiMqgCHgeyd8IYBBKi1TB9JPeViAeH6lO2yAzbiywEpsQ+f+?=
 =?us-ascii?Q?/D7vJBYD+WIhOf19bopnrghCHu7FcRaa2MoXgOlexHIxm0hzCIMkfajD1YqW?=
 =?us-ascii?Q?5m4MTtVuCRfVBCYE0cB67g+a6iN8MUCgFLK6rJ2MYJ0ayp27mz+RxfSlONE9?=
 =?us-ascii?Q?lzd0cbnte8cyILDcwfeNUmlYIHsdxBMjX97RQERV4m+Xd33OSPB9dzOQRXEP?=
 =?us-ascii?Q?zYfwWtY/Af2rPVN2J5zGRQ0AEkZaGL+Jmapm5tKmRmaoEBKiroX+6CWf4WVT?=
 =?us-ascii?Q?X38ridN5w3s7x41o8Rx6u9dEwviecoi3wia518mT6kONoEl5y9dYuC5+LMuM?=
 =?us-ascii?Q?5Vfi7b269/w7LudQEg/jxtmp2xOylRrTcmVrHjvj4An4fWFKHUVhrxNU5kfw?=
 =?us-ascii?Q?RnFZxBswwsGkFKgvzib241QwvsAXWin68apmKMl21VUJbwx+xL4XAv8xECYL?=
 =?us-ascii?Q?ZTrYxwqshyJeSP9uuv9NpPv2R+ntANnPF65ufbKqeLE0g69Hf/igKbrNT1Kv?=
 =?us-ascii?Q?7RSkBKWvXhDPRac7L1qHL6HWZtVJS3w3TvS6uQkRevrreAh37CMFfJMylQZC?=
 =?us-ascii?Q?WrfmLjP1oOz+wvipeq8BHGfYXK7CMguOb3caQiojr9Fa2CWs4Uuldrm9LAGy?=
 =?us-ascii?Q?lk+xBRt41+jAvZkUH+iZm/KmRYcmiyBaufLUBD+zMXb61Ndsv9mMt1o43D4d?=
 =?us-ascii?Q?SHMQhpyswxkMmQqml0d4SsKdmCtuRZrr21WgVBqdvG1hVeYBDPGVc/Neq05c?=
 =?us-ascii?Q?sbD7LeilOiJ3muga6afWvziKl9uCRB5S9k3WouH8h3654lp6ddRGqhzmMfXm?=
 =?us-ascii?Q?ISULo0647TJBNCKG1WFmDHA4M9g5Yi2xVqRGQSfO2bVNSNZ+6+881glRxtKP?=
 =?us-ascii?Q?OEzB+6D2J5SXRCY+ahrhTZE3wBMS14pcCJaNfBUi4O9AS8DQUN0CRwLioSTq?=
 =?us-ascii?Q?GimiWM4ktQA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2kroZBqrpgnEtFCSGNpXYBW8soK72La8+ItzUeG//edV0NhuTaPBD2oBazSx?=
 =?us-ascii?Q?RQRekXqx/qCCvHjxQ0mi2R+URVSRKqj3GIZndarpTMaJ2aFZ+u7hIDHc/hZz?=
 =?us-ascii?Q?HfOlKS9vXovdBo46gTjC8o+xpTmQvKA/jmewL5QOz5P2TC/T78kCe5GhkmDr?=
 =?us-ascii?Q?FLVgJkAvKKu5+lZkDqCMTgdVFoKbzybsCTcOEFwkpdz/n5qjHdDeTxObBo4h?=
 =?us-ascii?Q?kovsWyaGkZEl/XEMTfVGd/FK6uJKQfRQIRh8iEAWTU18+00Qi8cgfkieAHK8?=
 =?us-ascii?Q?gr5vcqhDgtdViLETCXjOL0IY1H6W05z/fqFnv7VWI1qM3ed2jTRvVlzgOwS9?=
 =?us-ascii?Q?FbKFeFNblpxAgsJLdoEIysh4RId1YvS+rvh7XagPYi8IMdtkI/K3LBInG/T5?=
 =?us-ascii?Q?ctXHbkkC/KoAtqQ3XcSVi26RBxWxQCR6CLkaJino+fTOz3OtM0qnzgmyBTAB?=
 =?us-ascii?Q?zZ5YWs6XuVNWk02vZ18SX8bocgZIMXS2Uft3uaSUMsCb42K8tCj8fJvX1arB?=
 =?us-ascii?Q?kh0JS64LzmzK6t+GSKLOpIxss4crZjJ8uqssOEF3eIsCp+dg/OuiaIrpaVT6?=
 =?us-ascii?Q?Tv2fXeOp//0aCzjFCKQBwKxCai9bRhbmIZPRxpDrVIELRL+nnxzDt1rh1G7b?=
 =?us-ascii?Q?b12voLs8gWCa5mBAhekYLnhq0dreqn/RhJ170R1MoloLRTeG7xSWb8GuI0J/?=
 =?us-ascii?Q?BsRmTTGRa1SBv8JRxfZZ4CVnO92EJqyrdFirwZxs7lwhkrDTvmA6EN1LIHMy?=
 =?us-ascii?Q?iCRMjcQs9tAXQylA3XZ9beeBn75vQk20kM0N04Szvmlv3rGv5bSE08acsuVn?=
 =?us-ascii?Q?WRVRj636dWKDtv4JgjegNa6C9e44QissnKoCDQJzWH/ptpYE/sH/1+QmMoXn?=
 =?us-ascii?Q?HsFOyQprsjcL8g9Qi7jybckXnrr2sUUtAWzakTbYBI5J6OOJbw2fc362w3Ov?=
 =?us-ascii?Q?8ANsVY6/Lb0W8Z+AO196bPOBDElqErLjcM7klelCeaJJF0gYg7kxwdD/G9OG?=
 =?us-ascii?Q?LmahOWAkBGRIwNeyQgMngKZz09uk5Sq77tVkWySb/sDyAqXdkP29O/tkOTpH?=
 =?us-ascii?Q?UJMUFpqsY0L/UGzO/5WFKrdd3WPMINIJiznwgJ8yQvuYhBuRa2UZpNiB/f96?=
 =?us-ascii?Q?Kfz2ifHPOUR1uwRKRMb3dfLiqFJQWprmfsvWny5jLhjFtkl50RG0KXDswoAL?=
 =?us-ascii?Q?0840Pk3n1OUoCO++tWcRTUaBodJUMlIgyLYP5uxFp8vr07Ix1N33slqh6JS6?=
 =?us-ascii?Q?bmcL3LttzhEpCzzItNdwuTqlPb9UHZT5z5BoRVcDO8u3IOdo1l2OSxFrGn49?=
 =?us-ascii?Q?nvP1HmoGd5//ujy7Yc9bEUPiw7lSAfu2p5k+Pk86zC4JEWtI1xLoe5Od1F2w?=
 =?us-ascii?Q?NNHuODCy44vvunXR3P0GtMHjbPsgteqK42lTVGZ5//K7dabKNBsnZN5VfLIS?=
 =?us-ascii?Q?k8g6gNL1t9exUuPNEizltpVPBfieT2l4xylU3nb7YjNVTuzsDmA9jVU6Nvug?=
 =?us-ascii?Q?cb56xOMJo3AA+QCqC2V30l9lZjoO7FtQk5iBm3ll72BpEfn9pBBL1Ba3eLEM?=
 =?us-ascii?Q?0ijIiqtydP9Qaa0aK9d4ASQVZfQfUiUVl/oXmWMQ3RKqYaSUHJbEhCw/ZS7H?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iZgVUYbmHQRTvljymFrxJi9/EWZCnSy2TcF6fghSRa51QUOZJIuP33JRlJ3ABKMDsFa5baW+euVnDvql6NsdGJosZcIVDqftpVp1HocnEJAlIFxC9+RbYlf1PPp7zY6pCo3gAkcXs0y1fsk7xXqyE27se+W0w6LXte6rOJ3xUdhs9T4pOqPOVL/BA1Bh3R4TZMvX4+RWbQKlBZNz8+5iNZLDd84KMmbcBqNtGNkgGUomCbP9rsYiUfV+Geoeuvvv6T7Bfv/8y4yQWGtwverNGwLrWrdJBAUwo8eQdDKOFVL+GfGYvJeP4EfT8u0mhSL0F5LOh0apCgk/pC5/XZhRcjD/Bdrw2+OU3+AZGBmagouW+RAnWpxXXWIU/vm3Wo06kDcK2c+KQhBg26COUUmQ0HyvIb8M1kZ6JFKuQQoPUidplKrDqqyoN1kbvMRvNyJJqSDXRwMW7RF5FC7oApc9Vf5VvW8CzvRdjLAf9R+tBWQ+YPLAXfu3TdZMobtauiiJJOLxPJVuQwMEyVhyzz4trCcnqmA1VvJ9vgYsMlgqqpe+iMlBcEFuN3WCzS//O6HOHFWK8QGXrIchIaD/wVGZseARthFNQqWdm5yCoKPJBfQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abaa703-168f-4a63-da89-08ddaf4840dc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 15:45:01.8257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oyuu6+/pYS2d/jZZjA82iVHDZvsoJOXidNYoDuTB4ZiWEg+O9+ZPYN6T7hJUT3IKIe5bu5BDY26rpTHqntQdQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_06,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506190130
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDEyOSBTYWx0ZWRfX4mI65DNbN89E gSblFKH7o0HyM/uTYmnRDJhTy/KR9iWKl5DxXC+5iFha6D1qHJ35eXPTLOrBvbFJ4YRNaIJ4wPh Jw+ofuzfKGMj6V1fMQK2yMbKmeaqj26rJwRBSg/qvK+Qf/U8Dhnk/6nHMDAXAaWlGjubLKHMFjG
 G922OS0SNaZdUqJIVI/XKxlU4zqcpyZv2dvqsTTss3FeUXBt/zjhsb0aWrdWTOxL9nBINxC5nRb qEwy0t2uH4XvN0I6N2cIIMo9tGr4u2LPKEqFvxIaJZH8iekkZeXSR4HPLE3YNYxeG/z0456kaAI yF2ervwvhCU77GqjAEYdMAQ0z5mbEbfvD2kmn+1Jl3Gp5n8qJjvieZulF7xcWdkv+ozr8+DArTX
 svQOsyr0zqLlEefSxB2HFGI8S5zwMRVJjZn4FjwdtkIOliM28Am2+kAuIJxSodOnY2q8HR/O
X-Proofpoint-ORIG-GUID: 9xZ8I6t3Z6kXY75EdfqBA4bTPOTRZRXI
X-Authority-Analysis: v=2.4 cv=X/5SKHTe c=1 sm=1 tr=0 ts=68543081 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=jpKtiElOx-G-5lYqOhAA:9 cc=ntf awl=host:13206
X-Proofpoint-GUID: 9xZ8I6t3Z6kXY75EdfqBA4bTPOTRZRXI

Align this member in struct statx with the members above it.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 man/man2/statx.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/man2/statx.2 b/man/man2/statx.2
index ef7dbbcf9..273d80711 100644
--- a/man/man2/statx.2
+++ b/man/man2/statx.2
@@ -73,7 +73,7 @@ struct statx {
     __u32 stx_atomic_write_segments_max;
 \&
     /* File offset alignment for direct I/O reads */
-    __u32   stx_dio_read_offset_align;
+    __u32 stx_dio_read_offset_align;
 };
 .EE
 .in
-- 
2.31.1


