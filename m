Return-Path: <linux-fsdevel+bounces-21210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDD09006E5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 16:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D632E289B26
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1FC198A27;
	Fri,  7 Jun 2024 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gRLsCFTo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zYUxkujx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC87519309E;
	Fri,  7 Jun 2024 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771238; cv=fail; b=uYi6X0PRbbwvIfJkgEFtLOTBhUvh7sOwYbulSNDl3OsCW/bGFWlNQhFFJJRgjMHZtNdcT80oY5+vEjL7+dujHC1sQ30TKiITHY5P5mYIuG8JV7BamRENpX9t+CmB07Z0TcIguWUN+lCiO61BwPPhxGzNyM1AiOR/4M4PQbcMumQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771238; c=relaxed/simple;
	bh=L9dF2xDJ6FmD5uB4WpUF55fw0shwrYmOjf1ia+iPP1o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tiuZmUKagSkkWfAlCfzu9hekQGJpAeD76k8O8pgvVSmFR6JecrYOfxDLcjTtsR+IQLTb8h/raObgDq1upvnWkWAdp4xghGWkg9v8GB1s1t+1Xdv+0Qw1HckARE579Saklk8iwYskxyr3Scsoh+FUyuahZEDhFkbaHbfA0Iy1cto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gRLsCFTo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zYUxkujx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457CublM015431;
	Fri, 7 Jun 2024 14:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=corp-2023-11-20;
 bh=CDgjNMLV2JAAJGgydZEWnatLy2EIo/Wv9fvbYe4nn7M=;
 b=gRLsCFToZlZg44uG55LiY/tIgkl6GOimBOkcHMXhJq5iPx4JNKFR7WZAWA07GxRs/v3T
 vbiRdTjOT1H2tPiKcMBfZ46HzGEkG3OJo9LH5PpA4xS3iUhQXM3kpJ6q6SnHJa9Oj4ia
 ZXH+owkkjXEb3bllzyO0ATFwkHg9S2vncrJpE4/Oyjr1oW/C0t4dsnrisWAXZECdnzzL
 J302HLZ/8nXshUeGy5IhBzW+AcbM/05IbQFt6aSQzgcTZIAE7FCpSr9/UnFCTYfRhgCE
 IvfMYVbcrMxc9MGgKX/zLrAUTMJWx7OkvbOGjmcEU2V/ZWBhlN6MntJmDrO0TGjH1xff Hg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjvwd3ted-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:40:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457DHEgB024059;
	Fri, 7 Jun 2024 14:40:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrr2abeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:40:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONmmBolru0dx9S8wDGMPj/Ky4p5HuALPweKMXhxKXfHMCmKwSgxSG+j7ipPB09jgtKkICEbp0tHvoJFCilpTC6yXIGWJp2QMCua6HS5wPN+1kmTIYjj8Aemvxddsy9UxnvigmoNf5I7Rv0kM1cXV9lXPpedI7tMch4LHfNwQGdjV8kJi6dwrBkmxWWKpnNakv7nR8Yfg+2EY9GAfTnrRFDNkBCUfDQzLk79Kj5SONVT7s81sWnaDWlXX6Sz7M4AofTXQtcuXfirgDd/yCv1hV5fCo3ggBqubwzaZVWFgTIEtgwS3at9NxAPVMTr+ATqzSAdzoWi3Prchrikl5G81Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDgjNMLV2JAAJGgydZEWnatLy2EIo/Wv9fvbYe4nn7M=;
 b=DpRLaWnJ3HWMQ0+qdvnEVRb0WKWOiJNd8LzzUfKx2HyQG3NHS+xeF4/vGoetE8pI/wxHO5raE3L5NX9VjKRKrIwEL1y5oDgJ0nKIfP7z5IrxXJ+UCd80Ehl9FhXNXiP+TCrSMfSMQVxOHWD4j+RXbm1Lk8v5r/LsOEQahI6jCXOOgMOZhRnWCpHvQVQ+BhBPkcGG7McqtJzcHp1k1QAB46JiS8aeixnzavxo8q8oOPdzkk+m0gig+EVUJ7MX6XVeC9SzPRv4CC3W5Bsbz9bIupKcJmi3ppM0BBU4N3dCsTXdXssssaiHrY51jPyd+SjbRMsrfvOUOyje4dywHm4LEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDgjNMLV2JAAJGgydZEWnatLy2EIo/Wv9fvbYe4nn7M=;
 b=zYUxkujxr7Tw0ZqtMWkn8zlWosR80LWrz7prpjaAskjey3Z07dYqVPvOSMAUWH6ElrgoBHb/SoNkR/i2XR26Lw8g2WmrNT8mHaxteWJtf/LUtxuoqjw08DELtc8DDfVQbK/P0/Yr7ynC15JO+/IpfBZ4gzqKZ64mWL93uRipKks=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BY5PR10MB4226.namprd10.prod.outlook.com (2603:10b6:a03:210::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 14:39:58 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 14:39:58 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, tytso@mit.edu, dchinner@redhat.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, djwong@kernel.org,
        jack@suse.com, chandan.babu@oracle.com, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-xfs@vger.kernel.org, catherine.hoang@oracle.com,
        ritesh.list@gmail.com, mcgrof@kernel.org,
        mikulas@artax.karlin.mff.cuni.cz, agruenba@redhat.com,
        miklos@szeredi.hu, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 00/22] block atomic writes for xfs
Date: Fri,  7 Jun 2024 14:38:57 +0000
Message-Id: <20240607143919.2622319-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:208:239::34) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BY5PR10MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: 76d7ed52-f2e2-4681-ccb0-08dc86ffb46b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?YbjtOl9LtLb79198k2b7FIk1eeHGXbCeUV/6duOy4+9ipddhDCrnALNLAXvN?=
 =?us-ascii?Q?WLx1M5ObkTlUGLOmBIUG1d4x9CvUzurP6vt1dsUK4GSFbQVax1oM6pq77dYl?=
 =?us-ascii?Q?PHC44U307r1qhq3iPsUTgbYEmU3a6vCNn5EZbf7u9zAd4bvxaIufEHD+GtGc?=
 =?us-ascii?Q?cJsMac1z95tWNy4/APR631kvDk9VMN+gMbFNkyQ9RTmHvUcD6xHlu0mn5CCO?=
 =?us-ascii?Q?WcbVBgREv1k6ojbBtFcWhdFVh2hemI0RSCbe9y/1S+MXZQd7SysxCjHC0opj?=
 =?us-ascii?Q?amveh0zHstfDsa6t9oCp4midRzIzR/QgvNFzq4Z0yuoNHK56XN49FgEYT7ef?=
 =?us-ascii?Q?3iJpzu9ejVN5EVx7tfMaxWA09nukI8iUGLMy8gfgPB2G5OicZURXAysySsTJ?=
 =?us-ascii?Q?SBay6PRV+Efx15KBVrnNDLVMRbY4HWnik+dyhZ4bHt/7HmJOglUEUg0zymtI?=
 =?us-ascii?Q?1L/FxkSvgzhmoaMfyjqLf/eFfC6R8j7b7H+tRV1o9vqTZbQMlv9Kdlb4UnqN?=
 =?us-ascii?Q?8W2cm49nLOZENwykNZg+BnXdxPwyvL0xkUvvhc/eU8z+M8QxLd1QrHr2xsjb?=
 =?us-ascii?Q?BRzLIlh8iY0P6zG9mK42apgH81qFczE7aV/+kD8/bAHAqW9/FuBbn9PVYyjd?=
 =?us-ascii?Q?rHk2esJXzBD9q94T8vZSeTzqMnO79p4LGFeV1AqSnaMP72rotFj2HDJiKYyT?=
 =?us-ascii?Q?2Zo/uQZaTfzZPXo3TRD72KYcUafYbupviHLkslb/nynf+PI010spYiYfZInw?=
 =?us-ascii?Q?XN/364BWkDRn2/eHhHyP69uESJHdkKPqlG3FO9mzIewZp3pGND3zsmjJ+MK/?=
 =?us-ascii?Q?J7uxZ3s0Qngb3/Q1Fneo7MdgP9WvzYBgLuDxIfCl6BI0sIo4ivxnU6/fRPXU?=
 =?us-ascii?Q?rFbXiTH8oV50MIBxgEIdfhpZDKL9NMjfd6V+M9n5MHUngV4NICd/QSjNfyJw?=
 =?us-ascii?Q?ZtXd049qdmyccJ3jh5Y9kod5WKNp+g2qqDhwN9GP+oGlyxZpTDyapkykb+Q9?=
 =?us-ascii?Q?ls+e4fIyoB6qXEwDbEsi2bLvKmQ9i96VEqvi3kPBGzmAMLDf1hI/B3q3bZGv?=
 =?us-ascii?Q?vWcspWo6zVfmv97bdID/fjCdOYMKj7h4JyQ7jr/7IzuMPw51A7uIBI3mzdVC?=
 =?us-ascii?Q?OJnxhuAw+VcznE9aDn44Hs1zwBdbnXj1FQKXDNMmh2Qird8/XSrj15vmKa7u?=
 =?us-ascii?Q?O7VzzSm9hHpai+MsJJAopPOv+aFPpJ2kc8xBP+0IHVR5ual0nUoMrjV5zY1w?=
 =?us-ascii?Q?taMEYEuIj0O8pLSwXdrvdLKt4Tc6s7RXR6nc8APJkA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?E46hFAxm47w+Y/4KJiz6jKDWHGDICHO0v9A7Iqqk9mGKBtZphxjewMXknTOB?=
 =?us-ascii?Q?ugEmIVcGb5nV1F04SlOyYT1V3nFkkQpTXIhvQhg5R82Ixs0iQUtv6GhIR5Zr?=
 =?us-ascii?Q?XmzYLzwkMMJrES436ipR7ysL7lBszo5rq6on4/lziXeUjlFBPpNRG3m0T4Mu?=
 =?us-ascii?Q?w2bO/dHe5ZgMX+kAwBL/GILY7TvtXWskz5oM1d4EnkFbg6GEnl/baoHSMsqc?=
 =?us-ascii?Q?ZgD8iiEwGnEYz2IddFm4NTVdOrBx8XO0Xs2799FjEVS2coIJT6iyPKAvz3sP?=
 =?us-ascii?Q?j/CIOqDGwffOlxVtry9EkLL3zhX0VmtJTPcbeHKTzsRoWsfZ+dWzJ1DyMUM7?=
 =?us-ascii?Q?ck6fey22RZHuPC2pFHgsfvPPzFGAD0v+IFzjdulMgItSO+XwB2xsAPuE26FZ?=
 =?us-ascii?Q?YSRdP+N5w4o6CNR184IuQoIPj41vNUAFb54P+RgaQ/k1AViuty+X5FV/ty0y?=
 =?us-ascii?Q?178GhG6vgUqJgscwRpd/ZFl8sil6QSqHV7q8Ggak2fwZtoSSMMzeMHdRyV+o?=
 =?us-ascii?Q?XF0rOyN70qTWZ5WFkrUzliEOy6uuvWzSEHiFBb1npFkmHCt2O5nAJRfyTJ+C?=
 =?us-ascii?Q?1nOQY4ttB1Uqv1tw+Gx3IbzUzj98IMMZzfIEmUNu3LHbD+4tUJHm1yMBMERr?=
 =?us-ascii?Q?wTbRvpf92t6ySxdYYV4/baPraL6fd9ephuw98trYJRkIm6umnc4N2QOYLGAg?=
 =?us-ascii?Q?jtnDRzl1lgoct6gDI3rDyk8XTfUclBMQNrv7zS0ZiQB8H1ntGv6pVGsxm8VN?=
 =?us-ascii?Q?ZotEmYqmOrp7HFvZhmOi+wK/iNhnzjPPOmrW4kXdbVOyoqVJPX4GZDbkFzQg?=
 =?us-ascii?Q?9Sk88lTPO1k7JAkiehEQcKfeoXx0cas1uPdZHKX4khQyQLzFzWSbYU7Oo1fu?=
 =?us-ascii?Q?5ZMoZFpLO1QkIr+4f9isD5Iz3KiOujGsSsASR3QGJ8A1RzTirUS8BjMUbl5n?=
 =?us-ascii?Q?qFcaMux2rDbjeuceQ8SeyWpkqhQe6n3lIxuoOY9+/ocLenTx/mPa4MaLEuRV?=
 =?us-ascii?Q?IuuIcY4ThbSiZgP0/sZuXm37hvDy8KlPeJDpOcfAsSnWycCL91tDGeOPdZhj?=
 =?us-ascii?Q?0GrP8SkHq4JwZGc9B8aJXa1MLPupzIQQRMlOgcbqOPqMsGVVzM7uGkwqU1N9?=
 =?us-ascii?Q?67dZBPshDEz9yfgD9LObYrec7QWpxhe/6smGDqzIljvzJOjoNn3dUKG6R28F?=
 =?us-ascii?Q?eyPokbPuq/sJg+knNx95oV9zRaYj6WkqM6TwTh83iJL92vhfN38/MJ2p6+24?=
 =?us-ascii?Q?C0Xv3kocawhw9DtBl4TZL1d6j0yEAQeulfhwE/iLjjPOR/dzW/flZvLB5KU6?=
 =?us-ascii?Q?/lg/6PNzkLtFgoWs6e78QncHJB5gLrPWEWhshWLT2FwVSe+XSDWNHdcC2+EC?=
 =?us-ascii?Q?4dU4zCr87GGsKCGOX9xV/l6Jv7NU7WZcK/qWsDn8MxFC0bSKFsX1iBc0aqLN?=
 =?us-ascii?Q?y7jyACpzJCIzn636VQY+lKl4GmEqqhsJH5S+XNIWyENagA3gZ74+HjTQ37lR?=
 =?us-ascii?Q?VKRzHWvZ2Q4rICn1tWNWnkDNgLBWOyO7UJfPOfmTBnzcLB4IKdZPQ4jdA9TX?=
 =?us-ascii?Q?dDO8+SQ9Ip548dnIT785AXhwUjv1d+0W+wcP+UEEOvbosaz8X60P/wGgEq8f?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	boxWpLx+YbhJyuNJavY7X2hYG/MzyPIRZFTsml4xm1dL6E8cm0lLUKThj+BD9bca7O4NiWbmwUT/VuqKlsQBsxw5WGt8NakDPm6Aidjspq53gc8he2zFpTmXuw8+ooBWxn99nU1B4+7AbDugtpnjLg5vb9CTtgpw6yJqM/w0Hn79xafWqjTYAiP8EBBwT2vVluiC1MaU3PZ+xqC8wrhwh5NmDZiSiBGIoQFkdlh42BA+V+yhAruKSLQ5aZI7CGcEcEPxJ+ENX2vcC/DntRz5Gl3FjvdyLI1HeL4/9a0RjC8e4O+8uwz3XHJ9rM4FFWuInE83qpa849lAEQtqwtpdxIMmPrc4sld/o4GXd2VkFRyOEw7QN+8aq/0WsAJFc6uNX5tGnfbwSgNXga+fFe8Pwbu3CFO/FkfjmJAafoClAE5lXSmRlHTbJvax9/2ecPS0S9o4rnBT/+E7u3Sl3UKWa2ATglrNd/OX4c1FAl7th1jhmFhMZ7itAmh98Q3B7uldoRkQVfzskS4ILcjslW9XSGqzYXsK6Eo9qAjJcOJsiVcUgrfVUfPDK+FMmQj7BF4Rvo/mUzyvfudVqWJUg9pTbwU4QKa+wF/W0L4eF4/bh80=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d7ed52-f2e2-4681-ccb0-08dc86ffb46b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 14:39:58.3658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFSmQ2Ja+3a/9+S8Yziz7Emib2yq242zrz+HfmecH7ADc2dtzXP8/LYcYtUsUDspqYQQr5V8CLbt8NMB8QSOzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4226
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_08,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070108
X-Proofpoint-ORIG-GUID: pWKg5bk5OVz7_rP0evL03ywWomXmMy5S
X-Proofpoint-GUID: pWKg5bk5OVz7_rP0evL03ywWomXmMy5S

This series expands atomic write support to filesystems, specifically
XFS. Extent alignment is based on new feature forcealign.

Flag FS_XFLAG_ATOMICWRITES is added as an enabling flag for atomic writes.

XFS can be formatted for atomic writes as follows:
mkfs.xfs -i forcealign=1 -d extsize=16384 -d atomic-writes=1  /dev/sda

atomic-writes=1 just enables atomic writes in the SB, but does not auto-
enable atomic writes for each file.

Support can be enabled through xfs_io command:
$xfs_io -c "lsattr -v" filename
[extsize, force-align]
$xfs_io -c "extsize" filename
[16384] filename
$xfs_io -c "chattr +W" filename
$xfs_io -c "lsattr -v" filename
[extsize, force-align, atomic-writes] filename
$xfs_io -c statx filename
...
stat.stx_atomic_write_unit_min = 4096
stat.stx_atomic_write_unit_max = 16384
stat.stx_atomic_write_segments_max = 1
...

A known issue - as reported in
https://urldefense.com/v3/__https://lore.kernel.org/linux-xfs/20240429174746.2132161-1-john.g.garry@oracle.com/T/*m7093bc85a8e0cbe13c111284768476d294aa077a__;Iw!!ACWV5N9M2RV99hQ!NbuQfXN8ZuUf_an3A6jHUXg3L1oCzefzyTYl0QWgJP1WbQCO8J_NPT9GHdGothSf36d0vxzJAjVUvcIB6IoU9nq3XExF$ 
-
is that forcealign is broken for !power-of-2 sizes. That needs fixing.

New in this series is a re-work of the iomap extent granularity zeroing
code. In the earlier series, iomap would consider a larger block zeroing
size when a member is set in struct iomap. Now each fs is responsible for
setting this size, which is i_blocksize(inode) when we just want regular
sub-fs block zeroing. All relevant FSes which use iomap are fixing up for
this.

Baseline is following series (which is based on Jens' block-6.10 branch):
https://lore.kernel.org/linux-nvme/96cb2069-a8e2-4723-802c-3ad4ba3e3d42@oracle.com/T/#mb980c084be402472601831c47fb2b66d0bfa8f0e

Basic xfsprogs support at:
https://github.com/johnpgarry/xfsprogs-dev/tree/forcealign_and_atomicwrites_for_v4_xfs_block_atomic_writes

Patches for this series can be found at:
https://github.com/johnpgarry/linux/commits/atomic-writes-v6.10-v7-fs-v4/

Changes since v3:
https://lore.kernel.org/linux-xfs/20240429174746.2132161-1-john.g.garry@oracle.com/T/#m9424b3cd1ccfde795d04474fdb4456520b6b4242
- Only enforce forcealign extsize is power-of-2 for atomic writes
- Re-org some validation code
- Fix xfs_bmap_process_allocated_extent() for forcealign
- Support iomap->io_block_size and make each fs support it
- Add !power-of-2 iomap support for io_block_size
- Make iomap dio iter handle atomic write failure properly by zeroing the
  remaining io_block_size

Changes since v2:
https://lore.kernel.org/linux-xfs/20240304130428.13026-1-john.g.garry@oracle.com/
- Incorporate forcealign patches from
  https://lore.kernel.org/linux-xfs/20240402233006.1210262-1-david@fromorbit.com/
- Put bdev awu min and max in buftarg
- Extra forcealign patches to deal with truncate and fallocate punch,
  insert, collapse
- Add generic_atomic_write_valid_size()
- Change iomap.extent_shift -> .extent_size

Darrick J. Wong (2):
  xfs: Introduce FORCEALIGN inode flag
  xfs: Enable file data forcealign feature

Dave Chinner (6):
  xfs: only allow minlen allocations when near ENOSPC
  xfs: always tail align maxlen allocations
  xfs: simplify extent allocation alignment
  xfs: make EOF allocation simpler
  xfs: introduce forced allocation alignment
  xfs: align args->minlen for forced allocation alignment

John Garry (14):
  fs: Add generic_atomic_write_valid_size()
  iomap: Allow filesystems set IO block zeroing size
  xfs: Use extent size granularity for iomap->io_block_size
  xfs: Do not free EOF blocks for forcealign
  xfs: Update xfs_inode_alloc_unitsize_fsb() for forcealign
  xfs: Unmap blocks according to forcealign
  xfs: Only free full extents for forcealign
  xfs: Don't revert allocated offset for forcealign
  fs: Add FS_XFLAG_ATOMICWRITES flag
  iomap: Atomic write support
  xfs: Support FS_XFLAG_ATOMICWRITES for forcealign
  xfs: Support atomic write for statx
  xfs: Validate atomic writes
  xfs: Support setting FMODE_CAN_ATOMIC_WRITE

 block/fops.c                  |   1 +
 fs/btrfs/inode.c              |   1 +
 fs/erofs/data.c               |   1 +
 fs/erofs/zmap.c               |   1 +
 fs/ext2/inode.c               |   1 +
 fs/ext4/extents.c             |   1 +
 fs/ext4/inode.c               |   1 +
 fs/f2fs/data.c                |   1 +
 fs/fuse/dax.c                 |   1 +
 fs/gfs2/bmap.c                |   1 +
 fs/hpfs/file.c                |   1 +
 fs/iomap/direct-io.c          |  41 ++++-
 fs/xfs/libxfs/xfs_alloc.c     |  33 ++--
 fs/xfs/libxfs/xfs_alloc.h     |   3 +-
 fs/xfs/libxfs/xfs_bmap.c      | 308 ++++++++++++++++++----------------
 fs/xfs/libxfs/xfs_format.h    |  16 +-
 fs/xfs/libxfs/xfs_ialloc.c    |  12 +-
 fs/xfs/libxfs/xfs_inode_buf.c | 105 ++++++++++++
 fs/xfs/libxfs/xfs_inode_buf.h |   5 +
 fs/xfs/libxfs/xfs_sb.c        |   4 +
 fs/xfs/xfs_bmap_util.c        |  14 +-
 fs/xfs/xfs_buf.c              |  15 +-
 fs/xfs/xfs_buf.h              |   4 +-
 fs/xfs/xfs_buf_mem.c          |   2 +-
 fs/xfs/xfs_file.c             |  49 +++++-
 fs/xfs/xfs_inode.c            |  41 ++++-
 fs/xfs/xfs_inode.h            |  29 ++++
 fs/xfs/xfs_ioctl.c            |  83 ++++++++-
 fs/xfs/xfs_iomap.c            |   7 +
 fs/xfs/xfs_iops.c             |  28 ++++
 fs/xfs/xfs_mount.h            |   4 +
 fs/xfs/xfs_reflink.h          |  10 --
 fs/xfs/xfs_super.c            |   8 +
 fs/xfs/xfs_trace.h            |   8 +-
 fs/zonefs/file.c              |   2 +
 include/linux/fs.h            |  12 ++
 include/linux/iomap.h         |   2 +
 include/uapi/linux/fs.h       |   3 +
 38 files changed, 656 insertions(+), 203 deletions(-)

-- 
2.31.1


