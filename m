Return-Path: <linux-fsdevel+bounces-46475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B207BA89DAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 14:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EECEC3BB86D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 12:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0532973CC;
	Tue, 15 Apr 2025 12:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CGR0sDay";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SwRxtEAC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8534B1C6FF5;
	Tue, 15 Apr 2025 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719426; cv=fail; b=eHhttLTa+uGkYKWy5iboIWCicqApcDOdUNB6QM0uWNzSck2eKZJpswmNA9TFHEiKDE/eeZCqj1uGAl8q92MbOi/6DmnE4Expft/DjYmiOPUNN5sD/d+jfddVKPvFVc0k0AUX55OVtBZT7Iu0Pi65xS+AAczyecWHWTo6EiguAvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719426; c=relaxed/simple;
	bh=lKy25y1FtnrX3rj/uj9DMcYTl9X4VoFxjVMfiILkRuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nw93B1tGr6KyykXVq8Y40MB7xXaA11n2Sp3pTn8FuOy8AGho284DThuBrCEa+B3ipRXhz0kdSbBXD1qwzkomfIxJ76uUPFc/YsMiCC0ScTPslEXmlBMDa53wPuJ6PNTVKFn+XRAdhpH2VELFyOVl7Pqyz+4c7Rh1WZ2NgiqP56c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CGR0sDay; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SwRxtEAC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F6g2Wi022165;
	Tue, 15 Apr 2025 12:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+IuTevoQxU2ikSIf4UJ+XPa/rufQNrDOLkN5FfxZY1A=; b=
	CGR0sDaymHrwQ3Xpkqgr1i/tP9PNHfWlwZPsbHyWgB5trMhoZmt86JTx/XOEuE/7
	NXTVILEtNA+UNte2GvnNrsvqExNSkRstluuZ1WjjCkU6dsVuFXpge+mzbID8qGax
	vNFcx0W4iODLIs07E8y1K0x3kd3g//0Jn15sf0UqfLvx8uGfYsjdCwSE/NPVaKQD
	K6q9CXCiWeUw747WVyLlUajWiBXSrMiG/E5NVIjr6eEgW3Warq0iij8KD4g5GIXa
	fvBzil0NdwhMTCXzDOopeKeq+bXASA8xoauuvhi2BQjZMwmzkV2yWaVit+qiwAJb
	E2DZd+/5ylGPQ4wgzSQKag==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46185msf8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:14:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53FAu9hh038859;
	Tue, 15 Apr 2025 12:14:53 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010000.outbound.protection.outlook.com [40.93.13.0])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460d4r76wk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:14:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csKHcNYFiLc6mKAELZ6oQxrhfYR57MzDTAnmyZuL8liu8dG/NxhKdy07X1eI2n4zJYyd6Am/22L34CyBtkMFdqqztx2OUVvbXg4nEIpjlODJajbZEdoeHQdi6L7obbL6/oEw5trCm7OYgCnNNvnFxZ+7aeWBQiQzQR1eajxKF0agaMjuXaXCHt0rl0EKR/NKjeYcpC3iTP42q1mE4zD1aC4b41BKqwfD/ySJCDzO/axaRHAH4xCzezVShZ1Z3kn8NyllWk8zAatk02mjQupBsjsPijry77Y/yJk3a52wQwlbuugNNReNciywdW9DEwoCq3+A+rSbQqhP+PdG+aruDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IuTevoQxU2ikSIf4UJ+XPa/rufQNrDOLkN5FfxZY1A=;
 b=opQwJMW2di6wx/FLml7Lgy8IbabWtKNbZa8lNMfg6/QrgVmB5mL8t0ArI/pgS7Jyf8dZhQ2XxNVwXqpZXVx7r6m2Ra5oae3dmJF8GFsU+5a/hiMeuY/HCEwJaT3DEPiIqmUQKTGi0JJe5l2yRvZxsjdFE9m+ExTr0b1ar0e4xXsc7n3NSczKca9wmfKJ2D+sa0Cw9eTrwm/dL/9N53iTW8kwduShCkjt+2/z4VzMKr94GO5y+uuR1v2UKwaBj/MpBMAbPtmAhQ5ScGEbyf7+nyMyBLKFpceaowr1qAKHzZpIt2JYLk/rnsBE8TY0R/9H6BGfYjIGgKzmDPpAtrY+hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IuTevoQxU2ikSIf4UJ+XPa/rufQNrDOLkN5FfxZY1A=;
 b=SwRxtEACcsApQTYXiiwmGPzWjHWnhy+Y2d/w5nrAV2mC1R0ERXe82Q3xJw8JNbbtzYOEY9ljulqHuW7/KeBJvOcppquWCTK6DULsxQ6fjcGiDl+vSW0RRhVpuOovODSH8Lafmsdo/TqMlGTMigtmlyARy6/iGp3hmYlhP9BMpPY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4991.namprd10.prod.outlook.com (2603:10b6:5:38e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 15 Apr
 2025 12:14:51 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 12:14:50 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v7 08/14] xfs: add xfs_atomic_write_cow_iomap_begin()
Date: Tue, 15 Apr 2025 12:14:19 +0000
Message-Id: <20250415121425.4146847-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250415121425.4146847-1-john.g.garry@oracle.com>
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:408:94::35) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4991:EE_
X-MS-Office365-Filtering-Correlation-Id: c77aceb7-539c-44d0-ff39-08dd7c171f10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AvJhT3Xqho6v7eihrx6ncM5+ZB/3o8cO3llzpytX8AOBobtgIUHq1TaakCyJ?=
 =?us-ascii?Q?GiwXVs4PXEJPZ2nC2AfI5uzL89eGf3egTujjIM8FdK+ak92JqMszcZneNNtu?=
 =?us-ascii?Q?IsnhFi4IYS3ncW7Fuq5a/X880oOvqHmbFkaY25Lw3xHW+WZ50DPS1NHelZ9H?=
 =?us-ascii?Q?Jff7peKA5OEZYDugigsl/+fMxIPDhnlzSgijIh/1YWl8CxaFT1iQWPbLL2Gp?=
 =?us-ascii?Q?0jAkWvx6bi6udg0i/UmOWUcPM6MPml2xDDCQJ0BLRcJl8FeyfLbJwoD1Fn1M?=
 =?us-ascii?Q?ICH6PRY+dqBDChDZNqkkvqECU2HFW8adlcZac+mR8nKEX5t3Bkq9b3+/LO4X?=
 =?us-ascii?Q?lx62d9R5aSJ5TnJEkittHvaFeVZV+9K2y8wQd8hTOEnSbeRAB+mLToj3hd+f?=
 =?us-ascii?Q?ETEUMSSsBv6J3XSj0sWOvzz2s/8fD4UQRdbn44Gy77N1G6N123rS1N9pdah8?=
 =?us-ascii?Q?fsJndECbi8OFvKn00/v3HHBaOkfHOCb3PdOcG2UJoOuxXzspRHa2t93OSR1z?=
 =?us-ascii?Q?1P/2nCO0kP/s8cYAW7xhr2CXIMFsTkyR3oO+Xo2Nx5rTTWYOE521rjuCKMdC?=
 =?us-ascii?Q?2j9672TFgpV3O1ach0L7Otntt1VDbfo4v2aaRXqk6qI7EAogXDIwc09oENpB?=
 =?us-ascii?Q?54ubE32jjkdy5DgRwNW7zrgNbOd+JIYsKOysdnEwODoQgYhwAYIxdB39ekHY?=
 =?us-ascii?Q?lLWjHkEB2bqL5q/4kZNu67uOB64gYSsI/gyzxEZxbk3BmkT9tqbLaeIcgvI+?=
 =?us-ascii?Q?+bUvM8Gu85u0h7wZZQQoWGFzL0VAiHa6fVJbGBtBvmOe1z1HNSKz5aQgxlDq?=
 =?us-ascii?Q?FoH2BYYP/P5QmINKrVUExGGXheaSHwhvuIcGGiF/Djy3QfTu4woth2j8x8mg?=
 =?us-ascii?Q?Db/7Cf7EwXSyC1SvLNfylVCPk/W3rwvcKRr0lYbz2z9EQllf6nu3trSxVwLO?=
 =?us-ascii?Q?2jbbG60nTl7cEdmfLIck2zLZvK9NTTRKIi+Ng0/7sijfU33ianO95rgePIyB?=
 =?us-ascii?Q?nvh7n3sbRwPyyhVFuraVWtrk3yOakjwtybINx3epRoq+XBVKUZaZZ3NM9Pbg?=
 =?us-ascii?Q?Nesjb9l8k5Mf7K8AjbPs7BxMwNOD3qkP5hxpaMgQ0vT10iD4YFylGG8Yov63?=
 =?us-ascii?Q?mUYZ5P/q1g2t2kfUSIEUySxtitHZ/yaW/1RUdyW22/OKW1bYyQ5PYN4eNo/f?=
 =?us-ascii?Q?+AJ6ibFc4z0e2BzYogXCW3XdJMz03P6Rw3m/ehJP4RPPfhigT+fV4vbGh/tL?=
 =?us-ascii?Q?dwnGd98ymDY2KJlxis5HIo4oeXjEPkC/Yyr99i05Yq2NDGvckA1MqpV20hm1?=
 =?us-ascii?Q?ohNCo8HF8I4HmjzF/0BfIhLx0AV67lCL4ZTEwhs4E0SdoCQm5Ycr6q7yQf/9?=
 =?us-ascii?Q?e1xsd9TmTykt2PXGO2gdDy13zU6UlCOdlzL8Nf9/jJG+KWcnnXzqW1H3T3QJ?=
 =?us-ascii?Q?Mpcx0dFaFaI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kkdtIEThPlVjD5+oEIiYCra1oxRtyOL4JEFgiHX92Wz2A+TzlxjusGufzw4N?=
 =?us-ascii?Q?xCgPWXq/ad2OntvGsEyeQcswILGT7/7D+BpdNJT6T9mjNQcTR7Xzaz9xbL3g?=
 =?us-ascii?Q?gvwZ1MbUxiF5ar7kFGREyBxCICHqkw9+Q+rCcfKJMVEcwGE7RLXh4mW0Bayw?=
 =?us-ascii?Q?6RQS05RUBg5m5jdZdh8fwCMTDOmnTrH7Zj/FnfLGVhQ620IfE3jvVaEW7jUp?=
 =?us-ascii?Q?QS2698gxai1CCWItDZjzhWL6fop9JP+eAHenCFkQwGPhkKVrMkaxV+n7esrJ?=
 =?us-ascii?Q?TUc+q44e0e8q3y2r6ZEtWVMw4Lxp2Hmuv/M+5Bip6iGFJCbCiPiQjNNwNj8w?=
 =?us-ascii?Q?gUhwrCmqnGGbp6JZ4x2jtQ8kj7YqTpn+MX6agcCwqC+ChsPA6kP2JCfEm71K?=
 =?us-ascii?Q?F+zgx+bR0MLKLiNUo0jahSp6G/gcmJPfHXtLm4PPG3yStwcdYhe/IlpM9UnM?=
 =?us-ascii?Q?F521sTmZ74tB/T4aOo7AO8RNx0o04vyrNViDvvH4s6WwdtBjz9Ix0Y8HV4e6?=
 =?us-ascii?Q?WhOAJzL4nwK9tcbmyTc8YkwAF3SPipgDj6WjjGkOnSJnr20Qk8osThKOpiYN?=
 =?us-ascii?Q?3251Nf9iAlkqaWyf8TNVenToCwrlkb2swrV5IUggHU8wIbuwkofBgZYG8K3B?=
 =?us-ascii?Q?8DfqCnzPBWnuzvFhTCo4LnZcN+ZqMph01haeE6oi5XKz8usdDlPB66Fu2Bhd?=
 =?us-ascii?Q?mI5lsRe/Wo9CkHIqsFRgE8ZD2rhbkZh1Pcm2T1dlvqSzfRpXEGXRzyyAWNs5?=
 =?us-ascii?Q?g4tTcWf7Dou75jjjhgCvLmvh0fj+vf6zbNP7dRVlk2AzfF2r6vJkyvaVBmzk?=
 =?us-ascii?Q?+b+ng32F9M/0IK0Ha8kLq2GWJh4pGSs51eE2bUH2U/DcEDKdl1xYrQ556ptR?=
 =?us-ascii?Q?4mGMccoIr4pr7SZxo1077efRIQ2qtF+fd4v0C0IjLsXGz1D20cZ7UQoHb+gy?=
 =?us-ascii?Q?Hk7LxQi94PWyr+IsMEzBgXmnmUpQ896AvKz90viCPpnMYQVUHXIIUXV2gNgx?=
 =?us-ascii?Q?Fzgc5dsxFffDxUAA9PSAm2dzt9TN0DTtFgN6WJrNDIlEU6jUmZvHaayRe7xA?=
 =?us-ascii?Q?9eamMEIhZUUwTZxsPK2MNmpILZYPPkFvI6lNqqA3MaH8ANLAVmPJqhToD8JT?=
 =?us-ascii?Q?c9ttXl+oiu2PYr2DQeWQWX6VwA2B8KgsCfXbImwnhKiWJN4X+gZuoqMYA0Yt?=
 =?us-ascii?Q?0vCEh9pL4XzeUtTlMF7Z6LowRh/EV2kLcQzOGfZ1U1ZsPzb8HdZPa9TcvkLP?=
 =?us-ascii?Q?Jrb7Zahq5hTqqsKWlES+T9wgz3SBf5nJsvPa4j0Yi2zCXPsOfg8z8H4lSSTF?=
 =?us-ascii?Q?OJi54iHV7WKQz0BMQ3lhYWbBFyn5VtCN0f9wECkxO9cTcM7qgHMwgFj0Lk9m?=
 =?us-ascii?Q?VAroSihNhUNSB03NMNJ3kS1td+b1CML3KuN8zAMWI6siq4eV3tqJ5ewqmcHv?=
 =?us-ascii?Q?CvAa3q5fgClh5m3Yb49eJ9LeFemQ2PpfOx/Z/HDYRQdfM+7Gd1Q/jTQDHuLs?=
 =?us-ascii?Q?79K3HS+YVLKK1s5lsPsRBoVaimAkt+mOgD1IcNfL3CmXKM+fe7ZJBiBsByj/?=
 =?us-ascii?Q?QnMvqSwE6lMavcmf9/bnM/oGxFqu87mY3r3gTXJ2/RB8PY9fPFGZcLjjYYZM?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aKoE4h/58kpPCWWwatCmki/LEucEF/3xYG0h1pPtpqJyQ0+8pfQC8yZQQ0LzYoQB7oeCI8eSkqbaAHD2QwZ7g5bCe8njQZMQzfrcP77Tu9ssKbttnjx125KdMTNkuRKK73IQdVMUhtVqitxhp0rlnFEz/mHaRMKtUVumyklgVoMsar2ti5sWSz1p+Bs0qxbd3R48gaS5XYXr4UdaxDKne9JLFppSmGbw/Efwc7LJ+EVJWR5RplXYMgXsqXiDWp9rLs6WUPTPcAZJ0ICM/KbaecNd5tAbHgPxIy+ue6cUSLQ7zOEhINQuWRae/wqRIJ/6VbYUL/2Waqlo2cFxBPYC6lgzZk/rSXomgSADv6p8kugeN8DGY4qmIXO66lM2Qr4fbmMqDic6IACA7iYeYDb2hcJu3JiB6GyJeIWC8DFRW3KPKRi6eADGTklWr6JsTQi23jJq2nfoFZPxnunkLo+Uhm3F99IFzRtc5ubAEFOY/hsAPiM3p7MBfRl3PrlVa4YukvnxBQsb295/ZxJPkyBLs8lgDF3IMvWQbArUHptHVzkRsKLDHzHlttN89jkTKT8dHjXNg3A4lvXFfXSjVvKk6Jvbd/UeANoKqrrUPFOOPpQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c77aceb7-539c-44d0-ff39-08dd7c171f10
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:14:50.5204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4HNdG4IPCKB+uyD9twnNRJb1UO3G2IOyzUj2U90gHP+PXZMGYZEORIyhSM7u9oOAERvu5hCrrusPx8uvS7m+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504150086
X-Proofpoint-ORIG-GUID: JK0_Xs7GM79-VPGx0KwXHipouGLeXIbk
X-Proofpoint-GUID: JK0_Xs7GM79-VPGx0KwXHipouGLeXIbk

For CoW-based atomic writes, reuse the infrastructure for reflink CoW fork
support.

Add ->iomap_begin() callback xfs_atomic_write_cow_iomap_begin() to create
staging mappings in the CoW fork for atomic write updates.

The general steps in the function are as follows:
- find extent mapping in the CoW fork for the FS block range being written
	- if part or full extent is found, proceed to process found extent
	- if no extent found, map in new blocks to the CoW fork
- convert unwritten blocks in extent if required
- update iomap extent mapping and return

The bulk of this function is quite similar to the processing in
xfs_reflink_allocate_cow(), where we try to find an extent mapping; if
none exists, then allocate a new extent in the CoW fork, convert unwritten
blocks, and return a mapping.

Performance testing has shown the XFS_ILOCK_EXCL locking to be quite
a bottleneck, so this is an area which could be optimised in future.

Christoph Hellwig contributed almost all of the code in
xfs_atomic_write_cow_iomap_begin().

Signed-off-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_iomap.c   | 126 +++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_iomap.h   |   1 +
 fs/xfs/xfs_reflink.c |   2 +-
 fs/xfs/xfs_reflink.h |   2 +
 fs/xfs/xfs_trace.h   |  22 ++++++++
 5 files changed, 152 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index cb23c8871f81..049655ebc3f7 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1022,6 +1022,132 @@ const struct iomap_ops xfs_zoned_direct_write_iomap_ops = {
 };
 #endif /* CONFIG_XFS_RT */
 
+static int
+xfs_atomic_write_cow_iomap_begin(
+	struct inode		*inode,
+	loff_t			offset,
+	loff_t			length,
+	unsigned		flags,
+	struct iomap		*iomap,
+	struct iomap		*srcmap)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_mount	*mp = ip->i_mount;
+	const xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
+	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
+	xfs_filblks_t		count_fsb = end_fsb - offset_fsb;
+	int			nmaps = 1;
+	xfs_filblks_t		resaligned;
+	struct xfs_bmbt_irec	cmap;
+	struct xfs_iext_cursor	icur;
+	struct xfs_trans	*tp;
+	unsigned int		dblocks = 0, rblocks = 0;
+	int			error;
+	u64			seq;
+
+	ASSERT(flags & IOMAP_WRITE);
+	ASSERT(flags & IOMAP_DIRECT);
+
+	if (xfs_is_shutdown(mp))
+		return -EIO;
+
+	if (WARN_ON_ONCE(!xfs_has_reflink(mp)))
+		return -EINVAL;
+
+	/* blocks are always allocated in this path */
+	if (flags & IOMAP_NOWAIT)
+		return -EAGAIN;
+
+	trace_xfs_iomap_atomic_write_cow(ip, offset, length);
+
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+
+	if (!ip->i_cowfp) {
+		ASSERT(!xfs_is_reflink_inode(ip));
+		xfs_ifork_init_cow(ip);
+	}
+
+	if (!xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &cmap))
+		cmap.br_startoff = end_fsb;
+	if (cmap.br_startoff <= offset_fsb) {
+		xfs_trim_extent(&cmap, offset_fsb, count_fsb);
+		goto found;
+	}
+
+	end_fsb = cmap.br_startoff;
+	count_fsb = end_fsb - offset_fsb;
+
+	resaligned = xfs_aligned_fsb_count(offset_fsb, count_fsb,
+			xfs_get_cowextsz_hint(ip));
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+
+	if (XFS_IS_REALTIME_INODE(ip)) {
+		dblocks = XFS_DIOSTRAT_SPACE_RES(mp, 0);
+		rblocks = resaligned;
+	} else {
+		dblocks = XFS_DIOSTRAT_SPACE_RES(mp, resaligned);
+		rblocks = 0;
+	}
+
+	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_write, dblocks,
+			rblocks, false, &tp);
+	if (error)
+		return error;
+
+	/* extent layout could have changed since the unlock, so check again */
+	if (!xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &cmap))
+		cmap.br_startoff = end_fsb;
+	if (cmap.br_startoff <= offset_fsb) {
+		xfs_trim_extent(&cmap, offset_fsb, count_fsb);
+		xfs_trans_cancel(tp);
+		goto found;
+	}
+
+	/*
+	 * Allocate the entire reservation as unwritten blocks.
+	 *
+	 * Use XFS_BMAPI_EXTSZALIGN to hint at aligning new extents according to
+	 * extszhint, such that there will be a greater chance that future
+	 * atomic writes to that same range will be aligned (and don't require
+	 * this COW-based method).
+	 */
+	error = xfs_bmapi_write(tp, ip, offset_fsb, count_fsb,
+			XFS_BMAPI_COWFORK | XFS_BMAPI_PREALLOC |
+			XFS_BMAPI_EXTSZALIGN, 0, &cmap, &nmaps);
+	if (error) {
+		xfs_trans_cancel(tp);
+		goto out_unlock;
+	}
+
+	xfs_inode_set_cowblocks_tag(ip);
+	error = xfs_trans_commit(tp);
+	if (error)
+		goto out_unlock;
+
+found:
+	if (cmap.br_state != XFS_EXT_NORM) {
+		error = xfs_reflink_convert_cow_locked(ip, offset_fsb,
+				count_fsb);
+		if (error)
+			goto out_unlock;
+		cmap.br_state = XFS_EXT_NORM;
+	}
+
+	length = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
+	trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
+	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED, seq);
+
+out_unlock:
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+}
+
+const struct iomap_ops xfs_atomic_write_cow_iomap_ops = {
+	.iomap_begin		= xfs_atomic_write_cow_iomap_begin,
+};
+
 static int
 xfs_dax_write_iomap_end(
 	struct inode		*inode,
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index d330c4a581b1..674f8ac1b9bd 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -56,5 +56,6 @@ extern const struct iomap_ops xfs_read_iomap_ops;
 extern const struct iomap_ops xfs_seek_iomap_ops;
 extern const struct iomap_ops xfs_xattr_iomap_ops;
 extern const struct iomap_ops xfs_dax_write_iomap_ops;
+extern const struct iomap_ops xfs_atomic_write_cow_iomap_ops;
 
 #endif /* __XFS_IOMAP_H__*/
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index bd711c5bb6bb..f5d338916098 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -293,7 +293,7 @@ xfs_bmap_trim_cow(
 	return xfs_reflink_trim_around_shared(ip, imap, shared);
 }
 
-static int
+int
 xfs_reflink_convert_cow_locked(
 	struct xfs_inode	*ip,
 	xfs_fileoff_t		offset_fsb,
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index cc4e92278279..379619f24247 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -35,6 +35,8 @@ int xfs_reflink_allocate_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
 		bool convert_now);
 extern int xfs_reflink_convert_cow(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count);
+int xfs_reflink_convert_cow_locked(struct xfs_inode *ip,
+		xfs_fileoff_t offset_fsb, xfs_filblks_t count_fsb);
 
 extern int xfs_reflink_cancel_cow_blocks(struct xfs_inode *ip,
 		struct xfs_trans **tpp, xfs_fileoff_t offset_fsb,
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index e56ba1963160..9554578c6da4 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1657,6 +1657,28 @@ DEFINE_RW_EVENT(xfs_file_direct_write);
 DEFINE_RW_EVENT(xfs_file_dax_write);
 DEFINE_RW_EVENT(xfs_reflink_bounce_dio_write);
 
+TRACE_EVENT(xfs_iomap_atomic_write_cow,
+	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, ssize_t count),
+	TP_ARGS(ip, offset, count),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_ino_t, ino)
+		__field(xfs_off_t, offset)
+		__field(ssize_t, count)
+	),
+	TP_fast_assign(
+		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->ino = ip->i_ino;
+		__entry->offset = offset;
+		__entry->count = count;
+	),
+	TP_printk("dev %d:%d ino 0x%llx pos 0x%llx bytecount 0x%zx",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino,
+		  __entry->offset,
+		  __entry->count)
+)
+
 DECLARE_EVENT_CLASS(xfs_imap_class,
 	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, ssize_t count,
 		 int whichfork, struct xfs_bmbt_irec *irec),
-- 
2.31.1


