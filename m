Return-Path: <linux-fsdevel+bounces-35881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 353739D93D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 10:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E989A28666E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 09:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F681B4F0F;
	Tue, 26 Nov 2024 09:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lZiUU+Ew";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w0woTkaM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247721AD9F9;
	Tue, 26 Nov 2024 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732612157; cv=fail; b=tiAtMgBAKSNnHw47fhu81cabLksENF2W8CYPg3SFgvZ9LrZ+Kg/y3Y6+h/x+N2FYCJ5bocV3ed6n7/BSTXqo08xh5KYKFDPJ75bATk4/p8nDo6BP37TZ826SdKq98qvkopH1CGi6HcKOo9yWG1zx2WnMTQqwpVSYoyrhvOSIgEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732612157; c=relaxed/simple;
	bh=r572ZvlX6Z0u3w/GlfTY9bAwrA+4a5LEm6mtesM+tg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V68C0+ukHOP5GHTJ71Kz2O1zUTM/z1pYnfdiQfuF/48EnwDMzgKvzyTllgdBzxQtS1sgBbQyOd8ZC1Qr+mUaNWPzubwR9tMn+jTNxbih6k2N2hzd1bBkdQ2jMMHLEyWTRyuCXuf6/yBdz4ZmMreaXHBf9NHfNtitQQWOAx2qwfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lZiUU+Ew; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w0woTkaM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ1MnDx010440;
	Tue, 26 Nov 2024 09:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=905BhTK2pBeF6ZOdtxbNl34s1QXclTWcZ/yEmx3MnZk=; b=
	lZiUU+Ewp5RxPnlZlD/oiJVr07aWxIph4iWoiFlucIK/hIxDPhsnxitVXd8U9cic
	317dnzsq00Dsh+dGednqSnnn6E3m6im+LK0qWztjBarQ0P+yq0UeclvE413/+CmC
	BjHw9nVR/9Ju66Rv+MToh1VZF279is3AovzgXEMa0GjtYWW8gQgH5iyF8McC0dDq
	tZdTTikVRPRisovbiFOjtf16zItS2h+lHB33UXpso8nSgLzjSdTRLXsPSK6NTYvB
	+8qG79JEngXcXMX6hCmdjCVXe8G2ah5ICwsM2ZcbPLEPec4T98kE743mLW1OxUm9
	C1fFayBkhedzMvNuPzCe9A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 433869w0q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 09:08:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ8mvBd027070;
	Tue, 26 Nov 2024 09:08:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4335gf3hyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 09:08:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nA+Sie02r1gcvr+tUOEgoPc14hXnFCyU+8tsF6YMM3kqRzQdHWYCewldtvlJL+AklMfjPPLDJz4DkgonwdhndlDW4Ykei7d1LoE+524rjHLkfRPUcbuIK2jI8nK3h/7HV6ooJVx7bR3wCMmB9XB5djYgnE/ASXXLhqIpwF8tV1QdMRMEYvOLERmz+3pr2CYoa/HQvy7caeH40+0yBNkJPIXEdrYEw3RPo2wD95a7iX4Ymqx3436nEpHfnl2GgGSP5+nK8a7dVqh1IiBE79L5dOx4qj38qwOgSwDC9vtJNClq4WPLSxWuOnTu87sDNPhAD53BOD0hOMuwADSWrbq8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=905BhTK2pBeF6ZOdtxbNl34s1QXclTWcZ/yEmx3MnZk=;
 b=p3JzGKpJ9ijiAp5gG+//KFwpfL4BpCv52TXzl8N7O9I1hW3MXeprKESN8ok9KqGVfeeLJOFwwa6uB4/T/jJlbVIxbvOoeo2qsuQAIWdSfux0rm1PRuotW/DYtBbmzmIalT1uAyoIj4xklezfQAQeD5+3wYPlMoFr+ZmPOW4xS7ucBaoxbUOfKnhkX05oNOHZLqwzIPBMP3KuW9NesX/ZtlS9adg8ydAsfKdRHlbYfKBzkmiy1aoLzOip6JqZiGiD7zTCFngr0cuIpKAzh/icF6N/DTqCz9DyseKZQtDduURUEvIdgbtZdYvE/iP1PO8eI/IA63n4Oaaid1BIF5elTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=905BhTK2pBeF6ZOdtxbNl34s1QXclTWcZ/yEmx3MnZk=;
 b=w0woTkaMzE19sfItm7XxPQWQAX/NTbK8F3EZwF0Ilfgcvy4nKGRn1HMY+lSPz8KhyljhhgMy8QBVETAz6Oo7+d/qkpyuS8FTDj2fQ2BP4nkFXOXRdWJZK5haeKJ5mYYVm68AOQnenhjmP1bxz61mZ7t4a07UabW73IoMROCrQsE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5086.namprd10.prod.outlook.com (2603:10b6:5:3a6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Tue, 26 Nov
 2024 09:08:54 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 09:08:54 +0000
From: John Garry <john.g.garry@oracle.com>
To: alx@kernel.org
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, dalias@libc.org,
        brauner@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 1/2] readv.2: Document RWF_NOAPPEND flag
Date: Tue, 26 Nov 2024 09:08:46 +0000
Message-Id: <20241126090847.297371-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241126090847.297371-1-john.g.garry@oracle.com>
References: <20241126090847.297371-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:a03:331::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: ea26a6dd-be26-4f23-079b-08dd0df9f3ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UTzJWXlafv1v2oNFpoTz5SmsVjV7+TM9OeOqXUEO7jrt4/f6UYLGMEnalYX9?=
 =?us-ascii?Q?icKtddBmxj4KJSemdEJOBpODY0gQTYmO+V+YaksBQOhAOJsrEy1dsKAtlA0v?=
 =?us-ascii?Q?ypS55VaCwh6/4bFS4MDvXJe4VImxHJt/aA0z+kt5mAKPz7crXgaGnCcYzvDH?=
 =?us-ascii?Q?Fsr3c5tj8oCRmyGHgNNMpnt4RkMHIgl37eQo4VhZy/GPeRqYAa5fl2m/7780?=
 =?us-ascii?Q?3bxThNtVPhludt10GzWEjd2xIWF2JMHPRd42qLMf6IEFVogTR93IjLMMz6Fl?=
 =?us-ascii?Q?Q4AmjL6ueUCOAkYMPn68kjCh0ckbZ843e81ZUr7ADqByL3lQ37EefEf6ekfp?=
 =?us-ascii?Q?odM+ZLihP268zrWWGJfviApa8lCXIQ1013nmyBhCIN7runG64GM1qVlJcUtN?=
 =?us-ascii?Q?1q35OMHXIWWfA1ZIj2YH67qckyAWi7bpPFNQHlViZ1p9WNgwlU51AZ6zUcln?=
 =?us-ascii?Q?5Tz6BnokuQm8nE372j9jUwCElLRKl+fHcExBwpl35xXlAn0QDPwNvGGUDmWk?=
 =?us-ascii?Q?cXMOYD3RVKbdK8aQbnLMDpcCyb7bYkzWZLoMO4fPiepx5L0UTe37fHjsE8i/?=
 =?us-ascii?Q?FhirkoKdwTBNtDkE9EiWJBG5LYjbqv30ZIrziyKEjORueWrYiRNKN4sFPEdO?=
 =?us-ascii?Q?2hrkIomi1BeG7Wx5z08NSm6XBLqb5PKzcwsp+W2Arx/igZIdsrNO6uBR1+iq?=
 =?us-ascii?Q?IX8LVM8QEor4Ta31Dv/P9aj0DflzzQNOtIVV1MEfRx9MWRJlm+rNCYxoQ1wS?=
 =?us-ascii?Q?l31ihQrrkD7sXAmOPsn2Zo6rTHV1g2vw7iRwJCwnmDqfxJPFFS53u4WgKKbt?=
 =?us-ascii?Q?XT/YPF/Ah0OvCBbp86T716FqLC0Npv73oNpifWqe9e28Lq4Z3ErbVpxiUMRO?=
 =?us-ascii?Q?k0ul/7tVYYjnZ69gTC0kyTb1Cskpyhc519lxHVP0eE6xGikohM5/Drtu+HKg?=
 =?us-ascii?Q?oTpYBUTPNUduGRNhEf+7ZSolDlLplOEqvq7tLW5eCYBcGdF1nAWlP+ayvulQ?=
 =?us-ascii?Q?1HJkYneCU+piEMMtdoQ/rWdeFZYj63xrubQUujqa49YUTzx+4gPcgR6PIeQ4?=
 =?us-ascii?Q?hX48A4/3nzyk9Stfhu9Sbt8wJCjYxI1Q3AZrq8+Li49MnUIiwc62a2xgOXLb?=
 =?us-ascii?Q?/1q4znmyQiOUCLlTyx8rSZ3fyEI8btvD7RA08jp7A3lbFhz1GMUoTTKkGkMB?=
 =?us-ascii?Q?ux8MZv7Jj701ZtOBiPzsm5bia87N/ila8G8jfpHyqW3zek9hVw3buGKeGGjS?=
 =?us-ascii?Q?ZMJ91jXoxLSY9bhGBUJ+HMtsnfzxN0VwonOsucCElpSMHo/nzOAU2e5/ni4l?=
 =?us-ascii?Q?It1bfE6WdAxrCIXUoI8Y7CbMn8SPyhtWwQw9VOWpe4+DpQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g8Z12iJ8VP+fYidaKA7UlxUH0KnmfYIdkFe4jEsMqd0lgHRxd+eBt/0QTxmQ?=
 =?us-ascii?Q?iAOTi1s+h8nRBD0XIlRUhwAAXk4EaS8Bxqg+03goSeFLUk3qdWuf06cw2AKf?=
 =?us-ascii?Q?9dptgGJ3KUGpKYNGquDJHN8/EsWut+qTh3bqhmwCzybEtmJitc2Te9BbBQZp?=
 =?us-ascii?Q?pC9lC7SP8La0DkCpQd4m+SmPAQQfzQfRqj5H1LZKzkPKVJJQ2LEmt+Z+k2GZ?=
 =?us-ascii?Q?M6x8CLNSjxXkG+Zb+CnvKNXADosqyaKoGaATIkQh1nvCJQmsbRnK7iElLuAp?=
 =?us-ascii?Q?BMAB1tjTPmAQhzIC/Dm2f3oeP5aVARsDJrsFa3SEmiTudUOXn0t5YgUzskPC?=
 =?us-ascii?Q?nX50q4OnvAx7EQNN3KIFvL36EbKFd+St/FslGbLg/h7vSxizwdIfHOZPYodE?=
 =?us-ascii?Q?P0F5sFoExBLSNUuTJmC/RAfjdb4Zk6VTynl7wWWBTaCPznYWWHi7PGkrbxbB?=
 =?us-ascii?Q?AeBRtpNg4R09Vd28yXl8RRdCV0M8FLVtqJyb/9IqVMjCBoD5qwQ746k8VsuL?=
 =?us-ascii?Q?krPRCmulLLqFlEtIgfQ64tRI/5wIdG2w6LU5IhE1D09tq2cJ+oKITHgEqEbR?=
 =?us-ascii?Q?qBhdPJ7PMWkqqsY0Z2B3GmnLLEGddfqYHIqfJOPapLkUJTDnrUTQp/X5lrk9?=
 =?us-ascii?Q?yykGV+pAWpNosi5rJnEptGjNOoRoH8lKUlBAuXcVm07HCWGRRQEnO6MwuU+g?=
 =?us-ascii?Q?XZeIZqiQxs3Q3vrAhxP9GjuDzhxR07TsLJCyfTR7vsmr15n7jLU1PsmPSaYe?=
 =?us-ascii?Q?zZcGAlrsKViipuaPFSE02tBCN/80EDJYzp2J94EzJgLqsHIm24MDBZxQQLZt?=
 =?us-ascii?Q?iFYkA9DBS7BDgWVchVUo7xK17QTDokjNYaqdmj85uyZe/mEImmBpnYkMCZdK?=
 =?us-ascii?Q?nZMarpTc0jIIyPzsu2SSXTgRetbU+7it01kJJfvt5pvyT4QgT1lMXY14p2nn?=
 =?us-ascii?Q?h+Llk0mOxyTOmVkvZeJWeDb7SzlLR8s36eldw62xzk9gmcTUbd/LUl2mUvtQ?=
 =?us-ascii?Q?PWLmTmzLp8uUdXVQy3gGd6wHEDTn93f4m70q6czoAcAxMSZyIMlS0nlJEbFj?=
 =?us-ascii?Q?lD3bl0NSslC4vEK8uEzvxarxUeFbhUyM9ZwCeCevgsYCFb2LvyL9kFBRB5dJ?=
 =?us-ascii?Q?8RgDFIJacXIetfN0/rqklVKsbwhLQlypNXYvnKf6JfgFAyR4ColnR3yMUxeK?=
 =?us-ascii?Q?a3eYH4o2TnzL0GfhzNv87xqC0VkNtkvRxm+KB6MnIEmugo4B7+uAi+NZwTcu?=
 =?us-ascii?Q?smOHMrxcbVnHRxwHMCrVuymi89KuaRD9aykT8LaOa0yD/L6kzjBxab48PvcP?=
 =?us-ascii?Q?jLBQ155GfkRPsspMRtWC39+qy6b2iJ1AkV2WYtmU7U2fS6WiTxG/utLG9pqQ?=
 =?us-ascii?Q?tiTtsUUAuisFnLbTCNE0xZuHpbJ+Nm9FgQcZXb9dad7Dx3Lz4LizucTdxETe?=
 =?us-ascii?Q?OW8tcdURzak4rKepK2bhJ2Bi166UnkpWFAT7laiiVruHF0vdl8frfVCd/eHW?=
 =?us-ascii?Q?EVP5RR/NBTcGyYqUrgK9X274uAGO2qVmz+xR4p1jJ2l7bkoHvReC+agPvv6Z?=
 =?us-ascii?Q?0RKukJy5fBtFM7ULzORXjipA9KyNPqWAoxAgaBTIMcLf2Wpq7mbgefg8/5cq?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sYgJ3/JsEZrue/fxvl8utyk8hNPgk6/cbXKzGnbZn9qjPnktk/5JDlJWc/us5vc4Acmv1pUsJmIBbFlYzpkvZvRVLqV1fnozF0KpBGnJxMRgchPOIidam4xzFpAgXmj7dNXib8SaeS+hI2hK093mNCxJnoCcT5H99Lyu3SHZKqRpOmJ6OjBDW6J6fItTRzO4WYaE1bLU9xKL8QSEhVdqTUUs0vtwHKfi7CRzpV9beC5WHPFIRLm2HqD3GZwXRQXD44uBWmRPwD9N2ahik07blsiFKl3A2DA2c07xmQy4t+sw18bBZafbgglirVGLuZpXsYSRCBQ7eDe+4GeJrg46wKNxDmIWR/vA9CMplgRm6zOx+VkjC8sBiYKwIBJAwtY/1qGXtq5cMZ4s4uNoNETOhmVkWGvMJ1363Z1YqLsWqv7/OVAsRus3TfIyTFsqklhRt9AeDDsp6gFZoh4EDtUMZC+8cKMFg0IBjlGU1wBTfI0gneTOeF4OFqG9fdclgWubtECzhW5etNiXE968UTeagxSGfw8QUg/pTOitCgQIKA0XNrzOnACd0mw3F+bQE0Empb/+JDGD/zEbF+XULxYv64+jbGxfjc/a5954uIyYfGk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea26a6dd-be26-4f23-079b-08dd0df9f3ff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 09:08:54.9008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLDjuq+eX83aM0bEHw7T0lFuzlqKZizstCxmvHEmI6Zj7caZqQiG8MC9dDQ1mt8/WQhHnvI6JXVMCB7o7J4UVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5086
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-26_07,2024-11-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411260071
X-Proofpoint-ORIG-GUID: 7dBXwBr_Zms8GQB7fxn3TNOp6VC3JDdV
X-Proofpoint-GUID: 7dBXwBr_Zms8GQB7fxn3TNOp6VC3JDdV

Document flag introduced in Linux v6.9

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 man/man2/readv.2 | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/man/man2/readv.2 b/man/man2/readv.2
index 78232c19f..836612bbe 100644
--- a/man/man2/readv.2
+++ b/man/man2/readv.2
@@ -238,6 +238,26 @@ However, if the
 .I offset
 argument is \-1, the current file offset is updated.
 .TP
+.BR RWF_NOAPPEND " (since Linux 6.9)"
+The
+.BR pwritev2 ()
+system call does not honor the
+.B O_APPEND
+.BR open (2)
+flag.
+Historically Linux honored
+.B O_APPEND
+flag if set and ignored the offset argument, which is a bug.
+For
+.BR pwritev2 (),
+the
+.I offset
+argument is honored as expected if
+.BR RWF_NOAPPEND
+flag is set, the same as if
+.B O_APPEND
+flag were not set.
+.TP
 .BR RWF_ATOMIC " (since Linux 6.11)"
 Requires that
 writes to regular files in block-based filesystems
-- 
2.31.1


