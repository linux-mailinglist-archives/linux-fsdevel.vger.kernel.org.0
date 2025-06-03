Return-Path: <linux-fsdevel+bounces-50406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F35ACBEB7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 05:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7F01890F07
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 03:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6E717A318;
	Tue,  3 Jun 2025 03:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gwaA5IQ8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CpRAIRX7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BF12C3261;
	Tue,  3 Jun 2025 03:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748920395; cv=fail; b=gOGTwxQd3UTnyer+uYGcKbWFrnoZgnqmtQFFXswalyhyqNSnXn6pqCSyXJ8L4DDj6FeA3cRi8QlijC7D+me7nAj9qKlT+mAaivpgukYt9RUKGXwdWCccm6c9nFytnaabhrcRNp9oYt4bYh3fY4dcq0H1JIMlQD/4+6ABiW1TOmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748920395; c=relaxed/simple;
	bh=2qwzQJlyfX95zuLhM43qV6IBPS2Tw6BdPqF2PeR5AGo=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=KvjC105hD6br+Ojeis7hAAE+oOrwv8TTjqeG4KuN8Ax0sCT66Zl/Fi0Qk4Zx7ML59WxhVvUqOOdR4llbPtStCv95CCac84lkPI9L1wqxWlL4jUPkY2wmyhgXHDQpzXaKTmin/bdgHZ0T37zvS0ucavTAvaenrTbFut45seZcpjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gwaA5IQ8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CpRAIRX7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552LMxBQ009604;
	Tue, 3 Jun 2025 03:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=UCV+deR5UJuUZg44UD
	ehttznwM6nQZFgX57oo/Tx12o=; b=gwaA5IQ8yAdFi3wivc1DgWE7PT1jwK9sDI
	/UTGv0+2Fe3CuI/M8yhhK9+gyoBr5pM7j3YLWVjGM4yc4XkQJga4Osg7ur+xa3Fl
	/S7B43nj+Bk2qzS+LRj91MjYUFqf/J89E52z522R8L4XYEDWUdgr2VrRM68vK5Am
	TEjbiz6oh1v1NeYK31lY/To68qCWcKOgibArsbIvYu/0QgPJSkIFod3uK8XTYFfe
	SHCh7Id2gDJqH9CIO2/8T/KjSdovL2rree53+1JhYRg837sFFrmnfI5yESHFRMaX
	nTiAueJWhM1M6P0gJ5CveMGRZW5urVaMbA/SpUEQaRJWocGm3U1w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8g8ww3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Jun 2025 03:12:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5531g1gb038568;
	Tue, 3 Jun 2025 03:12:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46yr78s7n9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Jun 2025 03:12:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/uwUNAG7F16tEdYcaUVIN9YNqF0k8baC6upq3e3Y7cXZhvaogk0/OTrx5tm2y2LhzTEHJbko5aLg5qmtNpGbh/BdGBdSR8nl0V0prVfRxEBTI5tEJ6bVlcouNZbk/Kgh4nDF4mRzAn7TojDk0girsGywGUxJxWeBmRTdZ552DX2lxsOb1/hZqW+tiyRjNCWRL8sDfYfHglde4bJBjQ48d6oNrwrVcMIoW6xaBZ1oWkv21/lCE93UUCdPgA743VHAyZlNhjMtLBub/y3wmnxAfQ5NPhUPQV4bHPv+J9cu2/1vwI203/qnkvyTcFwaWM8WXu+3a9YU6s640XtbwDnuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCV+deR5UJuUZg44UDehttznwM6nQZFgX57oo/Tx12o=;
 b=YPHIHVMBykzzozEUmBQJBCZTuwXQ2T1gMId/WofKzZ6dZg0zqrg9z4tGVzpYkvwWxjGmyqfkte+b7r/Uav/fAEmgpAZu9ug8QSXcLUCH3dPlgeQvdTgIGxHx/onAhTE81tYVM6lQ0mRr1O4HnTw+l+gQNXc6a5w054x4lmNfz48kkaUVeEqoYbqyijgL5reiHYCuZwPwlj3yTTzjcdv5iX5CjoPvLHqpBfzOyZ+Ej0ksyR/d8zcj7goq2iCe6mj1nqcNzAfA+TzwUM75Xdc+3KuvohX6HkP5+MAyJufuCZEJSrmkK76VNo0KX+Pg6UTF18qRP0PY3nb8z4pAe59gBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCV+deR5UJuUZg44UDehttznwM6nQZFgX57oo/Tx12o=;
 b=CpRAIRX7sIRJdoTcsNIcVA14lVAI3PrwsqD/vfyTEsTBhPNad7vsMaFnmAd9RZQQwFsu6+hp0k3QiXpdeCDuvICADo5qgizFrBiFqtPLxkm3GI/yHg0E9dMj0bOAI0jc13XOL2FeJp/vFQyaOXFgtGWJSGVoW7pYO/2dbI2ctCo=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SN7PR10MB6593.namprd10.prod.outlook.com (2603:10b6:806:2a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Tue, 3 Jun
 2025 03:12:41 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%7]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 03:12:41 +0000
To: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, jack@suse.cz,
        anuj1072538@gmail.com, axboe@kernel.dk, viro@zeniv.linux.org.uk,
        brauner@kernel.org, hch@infradead.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, joshi.k@samsung.com
Subject: Re: [RFC] fs: add ioctl to query protection info capabilities
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <fec86763-dd0e-4099-9347-e85aa4a22277@samsung.com> (Anuj Gupta's
	message of "Thu, 29 May 2025 12:42:45 +0530")
Organization: Oracle Corporation
Message-ID: <yq1sekheek9.fsf@ca-mkp.ca.oracle.com>
References: <CGME20250527105950epcas5p1b53753ab614bf6bde4ffbf5165c7d263@epcas5p1.samsung.com>
	<20250527104237.2928-1-anuj20.g@samsung.com>
	<yq1jz60gmyv.fsf@ca-mkp.ca.oracle.com>
	<fec86763-dd0e-4099-9347-e85aa4a22277@samsung.com>
Date: Mon, 02 Jun 2025 23:12:38 -0400
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0083.namprd05.prod.outlook.com
 (2603:10b6:a03:332::28) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SN7PR10MB6593:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c2a04af-7651-4b41-6214-08dda24c8050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dBcgIhIRc5QBI+Xxeb1ab+gIhi/NdjHcdowzNfPDXuvZmJ7jaJCQlvn9jorG?=
 =?us-ascii?Q?8AwRYIXp8UeGmD57wCyf5EldkM6UuIlfVYRiW2jbfMTgAYWCt2ugRoA/zsUC?=
 =?us-ascii?Q?tMcUOtJDQfe2iEOqsL6T95+sxYaZi9hfxphUn3XdARd1FMDsEhKsLr6lhr6A?=
 =?us-ascii?Q?cUbhybrv8Nz00M+9w3gVbzcxJv7doO8es92vb7KA0S73YgNWpGKD8K1YqNeE?=
 =?us-ascii?Q?6l+3Mvb5FIzT1ESvRyykMv2eZiF8wCJUqGvbpGdEUdNSfv1TbBQLOZAQD8ZQ?=
 =?us-ascii?Q?0ArBfqsgELMVo3Wt2oGqJxmiAAoh7/8J/B/b/l4kpwAGYRVjNLM+lkcGCPMr?=
 =?us-ascii?Q?3DZ9285On1GuaJtSHDqPcJXJdq9XT89LR+T6NGo/TYDjRao946z7R6iX0FzE?=
 =?us-ascii?Q?oFypLr3Hn6oKYAJAo6J1mq75U5n/jYgfQmhIereTxzoIbgQqQrT9wzXK9fOf?=
 =?us-ascii?Q?rMfEBxbwtM+nSVZl8t6eEoha/snTtqfhErhLbkZqYbCs34qOVEY0ZkAnOHZu?=
 =?us-ascii?Q?quu+l/cplDcxcy+jCSZqyjtpoKPX9xGpIkvFbsW5d0Q8IDcKZFmEJQRu48E9?=
 =?us-ascii?Q?t21QWePjFA4DJ5SSmiMLdNmpU+5FKJ0/uHBanCRpAw6WyHG7BNKAdnDg3cx8?=
 =?us-ascii?Q?gXZLZwFFxiOem64BEqH7ZCtW8wLagzy40GUgPj0xg/WQ0isVIUVgJtQV9cP4?=
 =?us-ascii?Q?qK8upQJq7/0eg3WHnQ2mzEHqKbax/UT6f8YNbhNXbtSzRpcZzAt6iNRSVrzz?=
 =?us-ascii?Q?pfiyT5QwC9Y69TAA9mvZwUwsZMsE/Ul+Pqv/BFULxwI22LepwFepgne/YkPk?=
 =?us-ascii?Q?Az9g/zfV7B/zq852+03qZ7tmF9oktqaOXo1Y3Tmg2g++S6SyhDFFdWi0qvmO?=
 =?us-ascii?Q?kOvPIWLUjS494GPguYcRUqMOKFHIq1i/E+lZC9Z21cQ3S3aOW2uvADE2HcBc?=
 =?us-ascii?Q?XOzCNgovdGExsjJbdaQkxS3iXSUJr6kDWmiUz/2Vi1RCf9XKovp9m2jGwFXc?=
 =?us-ascii?Q?cXfjYTb3U5XQSp5x1V3UAOZdIOtdgM+2XUT3Rn/WnM3bniCC1mwvBjCRQ5GZ?=
 =?us-ascii?Q?fpijEUN44lzIlFseb/CyXzlnve1cFOWmRN86r6n01gZtlX8AfdI2DB2s+RyK?=
 =?us-ascii?Q?CYJNvu3eTeR+j5Ih5sRNhhCyTdk9wsJ98ftoLftlJJLktbRjZ3ASitQ1a0uc?=
 =?us-ascii?Q?ISmJwwxJDmH5GLZZ5yiXy6NBfaO2IAuUVYv3gMdFB0k1iuc4J9wDHb3/FCVK?=
 =?us-ascii?Q?sAyQI8OqYlTPrunw1axOPSl35fcio1HIlnly1zneX+WHYk0qhXRkl7tGcMOU?=
 =?us-ascii?Q?2ouCZzl4Cnuubyk0MpTvRpof3iGAUqAsxWKJdPabhQX/E6Cka9W+uADuKNZk?=
 =?us-ascii?Q?HsKbteiafXaFi2yDacYHMTDZsYOoFEtCs51qI1EUOzFu4oDcENfRwcU5ZZZo?=
 =?us-ascii?Q?foRy72jjFWI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DoB9hb4LVPytFzp7iZGTTxl5EpiA041SthexTxTr9MYUFOlbt31lJv+MkdiY?=
 =?us-ascii?Q?1HaddokhorBqO/oetdlUZJaGF7pQIkV0Y1xrBvapOUACxzTKzhOlC4mxZxwd?=
 =?us-ascii?Q?9eCUw0sxbkgCvAjO8YHLF6gZrbf8NC4vCFGYdwqdZF5BfaL7zYWGrKLhfnMj?=
 =?us-ascii?Q?htwV91AxpjWmTdyB5iBxRgArMZpVxyYVNzSH4Yyn4jszoIx3sZRvMCYhhG2b?=
 =?us-ascii?Q?aCI1PrVApX2bWvdHFlzCI4KDjrHCsW1uuOIQLKpreNfWmhMDu+aG/XvI8Ryv?=
 =?us-ascii?Q?oc7MqjcnaI1BiDX6R4MQeo/+U3/p4HJf8oiGJJCAOUIdbAP4UmtAiNxZZ8kZ?=
 =?us-ascii?Q?I2ynDAdiLxv/Zz0on8mZ45jJkFa+NB5367VaIHNoZSArnoe7Ir/kw7Lr4xve?=
 =?us-ascii?Q?oLOaDBSh1sLdAXSnagcRQchRWsMuJM04UKVE3X0pFpTiyuO0mOSXAWSr/R3t?=
 =?us-ascii?Q?ah04CH2DjM8SDQTbT9VXuKoBerUVUBB4BvRJux/O9z1hi1bKnSWeyg7w4XKA?=
 =?us-ascii?Q?tM871KhZQCauoMphr9RreG4RJSHG3DvMrdke3L1crTTtIjZdiIScwxNxjf+G?=
 =?us-ascii?Q?IX3jXlQ8cceXN8Hf5ijEPdEiWwV14UTud9j5tuftaIAOfjTLbC2ZE57x657C?=
 =?us-ascii?Q?rhEr11M9l+OVzwHf94sZ6dd30j1CsqHtm533jUOGe4sCPQXCQL3m3iE1szh1?=
 =?us-ascii?Q?5dDBNYz4rYhOY7ldyyyxpTh+kHC328pMUk1rRdYFuE+2rd76CMd/PiVJNWjo?=
 =?us-ascii?Q?d/+wr4UBS0OZJkGIQO+JT1E/l7aUtU2s1WG9c+RtXMPkc1dFQikCVZETwlGa?=
 =?us-ascii?Q?ccn5cPnfPyzvZYbP50VZwD9WYO+HHfCH0G+g+srUaB3VPU/v/HLdgENsUsM8?=
 =?us-ascii?Q?h+VOZ1dsrcdVXpaLqvNbYBvNehhcA/vbMqph6S8Tyb+4DNSiFgra/caVrjzA?=
 =?us-ascii?Q?3mBMnlpUKa+9ADp+4TfyGJU7bAa1ufrs3IMDWKPPGSJnHzGr2S9rbe4Z3Lb1?=
 =?us-ascii?Q?1rvZ2CIGUcbdysaZiCbnxqNm4+Kj0dhBulrdKM6Qog8wn7kobWFmaoU2KZgd?=
 =?us-ascii?Q?917NOrMTkW5DaGNgmzNthz7uD9BpMORznOFKULOacCTJj9ukW5aofXYIe4O3?=
 =?us-ascii?Q?YR0adH/Of8OGH7JsVvuOOF5cytWah6BCnCG/Xy5B99q/5C4aUqvXUzuifI0b?=
 =?us-ascii?Q?/eWt1mCWX4zsjJZ85W5b248l06SuV+Zrz5d7PiPwBuNYMHHQIyEf2DbmMjlF?=
 =?us-ascii?Q?IEmVjdpvWxU2aoon5LD7JZ47wz4amQPevFa9OL4/126dQHwOHV6UwdDfbkEe?=
 =?us-ascii?Q?GmG3+XhohbcrK3iLiqhVIS3nYs6QEblLmgp4cqIDoeiMBvbUNECwHOn/W9D+?=
 =?us-ascii?Q?U6qTsfqm+Id6MT0Rh9anOyt7aXW3+J5j7tUIOthVvlUFpEMaTAywUT72I0JP?=
 =?us-ascii?Q?1rkBti9Uujd3FNLK9Axr69bsBjhlsyK3bVxZb44pjMTT+xI0Q4RoiWuAomqO?=
 =?us-ascii?Q?ssYCaxwqOxBoOEu/bV0cYaXCYxqMj4/P9PvVYceUce40T1BzOkOUgg2/5Xvz?=
 =?us-ascii?Q?RgV4jPfkqToyEvOtlbNeRtlNBEWxd2PKjbOOcD6fuTcvPTJ4yRgrOQfgB8QH?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f4ITwxA6WQo2NTeHcDGJDJJbqzIY7vBZvqkxWpMekFdkX63mkECnDqdiAczQfsEquSNJSi4ezLOHWw/dN0RU7dll4RiJbMIZclBOg5eVWnuEtep4Avf9ipVp3GhtSQ0iD8DZW2kd2sKfQ4UW4OF3L03hTD/Df0CqIeWfrDw4qW7Spy+SpVsScnDk131fCAZYpF/X9exhq/p/uw5QIskB5EtoWxY5AF8qMDR2alVlZypUFVZXp0Js8q17352nZNRwYKBi0KPJGQBYIh1Ga0lTUr/0kaMKvm//LlU/oId7nDt9H4CKnQXiNEvp5r8RyHB/uSPTYxtLvszlGgWnFVxg/pUwvHmEnQM0u6AixOWSpjTMq4zGop4cHHQXDxw55Dao8FGJPG+GKdZldmYqoKdJOXZgss9VI50CrpXq25tQoRY0vMPE6BLxPc9YezX2eOfWitEnTqfCoKjdQCzW8DooM4EOd1jBx7s6MVBE4Lsv23/cHD9MMQSnWSZIEXlQkj8sycf/B1p1eVOm+vGb6gWsvVw008cUZfheg8/Wm6PEkgq1dHK2RxcnxEV3e9HOfK+f5Zo+knImGof7gSqZrKzHn5GWUO7unI8SXVANxH4YAVk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2a04af-7651-4b41-6214-08dda24c8050
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 03:12:41.3202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VuJKT/P3KUjnBv9tSk0iOu2aVNolhahBQFCaEgel5TIVk0Gj11ThMqKuBjdHlX2Y1lIctJaDId3OvVlnU8z7+QxrAkyfDeYn8yKFMDQcksI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6593
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_08,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=922 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506030026
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDAyNyBTYWx0ZWRfX3duT64HoSnTg kh9I54j2iNwgQElFjg3ZnsQiIKWcQKFmqyhG/7saPMMkidlh2Hu5Wf/9vXzKwgVMGdMscNtsO1c bKdq1zIsMauD1dSCpQhEYlbdvJH45mzMYWOUFfHwor5jlgPrfFVUbOjx/QA697tqn+uvfApa6+X
 Y8lpOupYbzBGx2XJDuEiKHfO2Alj0YJjMZj32HRt5dvmOs+c4Zf92ZikVV2F2O5NYiKiUKHf4Pj XkPWa7c713HviQyxV67BZS2XQiuR6ciM0A8Tfb4vo4e/1f8gl+gk7oBLLJz/mauHL6p3+fzhgbG Gc29ye8UBAuWX2eoc1DPI2yG2dai8Gh/Tq+M/N+S6RirQ3YD0lCg0VOv6sU3VYVX2JYNey7+3l6
 XrCsYd+Hqa+MGy5V1mES/zjNNhjUkp2tMSz3eFJ/1IryT9gJctwAhdUpGx+wjyxYsSqpsmjl
X-Proofpoint-GUID: K2CkwMrMC5-2-828MYmxjF7Ix5N_hVIz
X-Proofpoint-ORIG-GUID: K2CkwMrMC5-2-828MYmxjF7Ix5N_hVIz
X-Authority-Analysis: v=2.4 cv=H5Tbw/Yi c=1 sm=1 tr=0 ts=683e683b cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=KYhhi86kfjRthw2UmWIA:9


Hi Anuj!

I've been mulling over this for a few days...

> The block layer currently infers this by looking at the csum_type
> (e.g., in blk_integrity_generate). I assumed userspace could do the
> same, so I didn't expose a separate pi_tuple_size field. Do you see
> this differently?

When the block layer data integrity code was originally designed, the
concept of non-PI metadata didn't exist.

Then NVMe came along and we added support for opaque metadata in
addition to the PI.

As a result, the block layer considers the opaque metadata part of the
PI but it technically isn't. It really should be the other way around:
The PI is a subset of the metadata.

It would require quite a bit of rototilling to metadata-ize the block
layer plumbing at this point. But for a new user API, I do think we
should try to align with the architecture outlined in the standards.

-- 
Martin K. Petersen

