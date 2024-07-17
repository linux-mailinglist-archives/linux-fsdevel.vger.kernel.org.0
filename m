Return-Path: <linux-fsdevel+bounces-23808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7805D933A25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 11:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BAF31C2122B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 09:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D630E48CCD;
	Wed, 17 Jul 2024 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GTwTAikV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wEDg3PUp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA0A2E859;
	Wed, 17 Jul 2024 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721209138; cv=fail; b=bZMqs/QetbFIsJn8KMrr4oLfIYjLl7Hb9xtDEbKMZUMT6cSjM4js/zTljebE87zOi+coOxvTwshbO/KrO8UVbzgiLobUe2f/xKSIdfgp3T9n9K0SgsQiiiro6ZQ5LOQWisslkjNKer5xXAw5MI1HuGGQ8QSIgvMaippXcLizY18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721209138; c=relaxed/simple;
	bh=I5RLH+6ogEGhTeVpcnSpw/a8vx56/ayVy/AgJlJRhlw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XBp54WRcfV0rjDQGswyhk/Yvgg2ciUgFFrzN4BbibvMuALas9ShMiIDvz9BN5a29/vOaSjE6WpmbX6hVcLPkHgw7ztp2e9UuIa6+MvIq8jIYQLs/gAh2U23El3hc1f25aAqYuxlydmfpg6hSvFdjLxr0szR1pabRWI7Zl7bwG5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GTwTAikV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wEDg3PUp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46H9UCYC005431;
	Wed, 17 Jul 2024 09:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=v4uBPefaIdln78J6/abeiRjMBT/OAJxSh4AlcBsNh+o=; b=
	GTwTAikVmMfK/8uLc4npb1quYeF8DzIlAvC6wfA4WeXBYq3Req4wwqv6qmSweW6l
	FyK/tUyHXDNawfVHieBhkbocxtRI3seEzn5P9xJJrNCtYV/qTyJVG4fcd5Ce7wVm
	6tPSBqEPUp0uJoM8l5Gnk8lDK1e7GIM+HsqHvGbnvSQKZOMoCHJYvqtwPzn77kG6
	OHSP5JXHEqZ+Guq4l0BW8g1SQBCtFFsb2k1Cmqk0PzzHHDcZ8CRX4YX5Pfv8+OCO
	ZaPWPTBVH3uOASf4llxs98mlQBtgCHXQYVwUtXkEcYMLJb2IY2NHQG9NwPtBmMXz
	6rKKJD6nZMpJ57bLEzcrDQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40ebcp80e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 09:36:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46H7arce003727;
	Wed, 17 Jul 2024 09:36:44 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40dwexu1xh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 09:36:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUIikAbzlQZnATbB76Awr4mT6nAlavYhxM653GxN8xhSUawrs9ykhNs35yJNtFAPwjUqGkHT0E1fmVJAchJEpxQjOxBPLAmcw/cLy4y2vTWsW66z8QUhDlqG/5XHXjXjNk7gGbt+m++i/KfmU2NytiQAD9DuDMTEC2Pn+LPxoxig4KYfU0lAVcg4oRT72QZzUy0JkM8tvsQRJh7ltx2i+VQixZGMgLT3dW1SK2Sc/VoVvQPR9cTxXscO86qhYU4q+qiCSx0achCKgjN3nuKF8iE3l0i1t0lAw1c7avyuIAotM4tEo38wPzERkGwM2Z59HPmCX0LtQmxZZG03CRDb5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4uBPefaIdln78J6/abeiRjMBT/OAJxSh4AlcBsNh+o=;
 b=bMtMEIWc2qaQMQo6JaSCgQqXUng2IMG3HFjMSuQLBJ/p1EBomrcNDjaqwb8UtdaPAyA8bsQhGEXJYZjgwRQtUAtN44Aw2w4GD20lQENklqF3ubeaAMYkpbOD57MHrS1SZrycCHYf+9jbXCqAMjc8a34TDPezKhxYMSJH9AnXTNWS2s5EQOQo4FpfbR9sJPkYYFXmpzFBgdDaDZ8HGgRG3W517j7pgdUCshpKV1WXIzwp4SnJ1vRiw9XKCp2OyXGKUZNXk7w61GZm3dzJ0FGL+V77OdXE3pywiPxdJubUDQB/i70twU/LtNLnTyz3ZTKXLpqkjn7+N7nJqEhG4y5YZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4uBPefaIdln78J6/abeiRjMBT/OAJxSh4AlcBsNh+o=;
 b=wEDg3PUpDWBS0TUS4J8BC0I7DZSsSLiaCnSqOGoH0RYbqf+NLXDMz02DjVDOaSyWtkwIfBaZgDyRotHMMRWNh+z6IQ5JBZqkEaghCj6Rc0X3k7C+HkBC+gXUN7D32B4s6Sewi78V2/gJCJLCQSr+zY1To+kbie8k40ClO988nUM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4815.namprd10.prod.outlook.com (2603:10b6:a03:2da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 09:36:42 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 09:36:42 +0000
From: John Garry <john.g.garry@oracle.com>
To: alx@kernel.org
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        hch@lst.de, djwong@kernel.org, dchinner@redhat.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 3/3] io_submit.2: Document RWF_ATOMIC
Date: Wed, 17 Jul 2024 09:36:19 +0000
Message-Id: <20240717093619.3148729-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240717093619.3148729-1-john.g.garry@oracle.com>
References: <20240717093619.3148729-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0408.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4815:EE_
X-MS-Office365-Filtering-Correlation-Id: 9529baeb-beb6-4ec8-b4e9-08dca643f74d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?FRV07K6qXBZLGPZWNyp3Sen0IHlefQ7ncxX3s30vRLQrjDWLx89SRm8Ng0wx?=
 =?us-ascii?Q?Q9Q0DCn7fIw3i87oGdy3ARYuRWJH0ASTgBtYz5nGwTJKS+FouVoTBUjxsMEh?=
 =?us-ascii?Q?s6pROw2TVZ0YfEYqaOIu7k1/5sHVMPiMxKSnB4j8sNdolZJQ6zxDtKdts7Jj?=
 =?us-ascii?Q?gWgI7j8Oa/yQUZttwyk7DSJJm53GPlShBwXlRQogUS0+BaPSDbi6FoTFLFjK?=
 =?us-ascii?Q?DUpUAL6aU/4PZgRbeGF1MxrCgFNqZ6iKLM0SfS86Pg6UQ/K7TZnhq2WAsNlV?=
 =?us-ascii?Q?edX/L2uYjY3gjeowJk3ndzl43cS07uxp7dCPzO42ecgVHx8a9J0TlR2k4Y9X?=
 =?us-ascii?Q?MfLJxANg1LsSbtmeHfvLsZG8RsXAKn56cXOTyFUCxr9PBont0KNWq7DMjwX1?=
 =?us-ascii?Q?pNWHeUC4dyCLH4t4c/6cGiLKs67k1FXtjjgw0C/39Z9MwnxgqVG6ikje8VZ8?=
 =?us-ascii?Q?uvEQP6oOr3qLYenFYeSBm8ZyvXHSOYNCnaKfksnc6sBVc47+5Nt0umTk1lJr?=
 =?us-ascii?Q?/O3+9GUN8BMq5QmRrR28Ud9ypdx89bZp/DfE1/UqDovIHDzxqGPlqjj6+xtC?=
 =?us-ascii?Q?+8Ih2L6ZDWLg3Iq88QG9mNzMfXyi5AVkstGqryZTLM9vX1LmTCzuoddfSbxq?=
 =?us-ascii?Q?UcQJS+V0Z9/cvMYoNbZuLK/9LSy7RFcBnJFqdV/Yi8P00mJnn7L97wWpYOpE?=
 =?us-ascii?Q?/bFZPz1d7M8dZnskB3w56Uxun29Kn3h3CYFLVZ6T+Ct8D0CTve+wmhob434l?=
 =?us-ascii?Q?XpdjnBzsSDvPRSKzUs4tEMZuKwPJkKRVhDCUUxMAQquFtDqgZ8q9YGyidsyg?=
 =?us-ascii?Q?LusMGbAua0hJJowvS5Thj1x+8c+RhI+xPrdXDWk0csUtQxvLd93I58kLCZS2?=
 =?us-ascii?Q?Ec2nqP25e1iZehaUKNhtx3xv9xVS3WK47+Wt1F4Xpw2qD3RcqlOp/tRE5/Kb?=
 =?us-ascii?Q?SXbWmHyScuf+8LjZZbw2FwgLxzXSJpIgwcPk2B39en2OdYhylbWBPB0wjPcZ?=
 =?us-ascii?Q?dAooAw1Tnhe2MplmbbubRFk4JK0jef7BhRifawlhgZFfxFGW+wBuYv3SQDxN?=
 =?us-ascii?Q?N69yEZyhXdpmzoV7zqn5zJaLTKfhLk7pn2eGpgllCwOh66ogVJStY6fcFlRZ?=
 =?us-ascii?Q?THg1EjI7PzRYlhzGZLFR4T/h2HnOodHYzCV9tEvvvxT9tFP85ZClVh/WlpaQ?=
 =?us-ascii?Q?g0DTnE2us2Aqao11Pl+wvRwAdmFbMWKPMuc2ifpsxjW5HDKgweZxFCNT2xL0?=
 =?us-ascii?Q?mQWvyTejLPhjWPqfI57yzTM3a2EcGMzSsc/S47sLvsSEWk9/D55bsn/T0GyB?=
 =?us-ascii?Q?9PhHLtInWjsat51+hZQYEcpo6qV4rcXAc9nhrO6bEBOMJA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dtmzm2/ZH+tSe6Z9vHfwnkCuDJUmZFj+9Zzcn0zOFQEcYFhqM5gabzUwSd+e?=
 =?us-ascii?Q?TqApyEKn1/UE0sxo8XZFsDOwZQTf8yxN1XOZxLTIYdUDD+UBCzNLcLA6k84G?=
 =?us-ascii?Q?bzYH0a4DuRbm3Z78rIwogturu8gXsfZ+bJuIhNORbfZYWGqA7zvWrFb6wrCu?=
 =?us-ascii?Q?Kw6oi45mjAUgwArBvSzSUEjtmS/NhtY+G5NwSA9N3o0lW5MCh9cOb7h+0UIg?=
 =?us-ascii?Q?7HyBCO3md9mO+VdircAVE+yjxM+h8kodFatl5LIaemCbgUQSU42iRbPXpwIn?=
 =?us-ascii?Q?dt1aXeH0rgcXhnKfM7HPDTCuwB9r8FlZaKpuSOwaC1WtYiESaXoP92cLXUfe?=
 =?us-ascii?Q?/buZDx4Q1IFnML8kL2xgyrhCMVfj/1J5Pj2AlahGzUQTmsEUET1Mbz7FrXOu?=
 =?us-ascii?Q?VtHwoe0BaGma85LtWqEVBTCO35UasvLSHVNWucMySy6RmVOgcU166QMZ5nh5?=
 =?us-ascii?Q?ds46YrMYFGwFmQ+xb3nuQVISJaZnyu7BtqEVxDHyO2Rx3NHuCz90RPLYrV9u?=
 =?us-ascii?Q?LRpEeyn4Zdtm2F54co8+4aMVF80t8WC19PM1P7Qo/173GQcnpEWsgPT1h4xV?=
 =?us-ascii?Q?5tmfxEeJPsjlinVp4ZOPm+NAIVpR1/8Rc/HvtaKaasjNR0SOFkK68MepP3Nw?=
 =?us-ascii?Q?0ReHrMugZEUnJLKhARw86I0ZJbF9Iu2PewRdYJicsylWsH7vVnWzJSS1G07H?=
 =?us-ascii?Q?pJ8G7oF+WMBSz00MEBHhnfTZAykE7nccGJWmXecuV5yznOf9CFz5pLPerqiy?=
 =?us-ascii?Q?uxOk3QISAp5zWdG/LNPC7fU+ZugqOfFsgOoBC6Bwt6TPEQjVX7jK8qIqXuXS?=
 =?us-ascii?Q?Z/lkBEto8RY/kvlmAC5bvxj8W3bUV9bTREWbHFuV9MF1NVKsDO+V2i91IjB9?=
 =?us-ascii?Q?5uswDqlFdFkZrSedOhMlr9J7+ShwUlJjMcsa0/ptAeRA0y4PwHp9ru/o/DDF?=
 =?us-ascii?Q?0tw5AQ24TeXog1cm3Jsm5hTuPw2R/77AxNsOw/6YiWeG/6czQxie0a94hnQU?=
 =?us-ascii?Q?Bq2PRX/KRe2ghzfg/QduaAGryT27VkhD3QTKZ6nbMoWtVDtHFJQ4OyXqLz7E?=
 =?us-ascii?Q?LTv0s81rM18qGtmTCpenB1XVvevJM9ixhgVG/fX1aUAV8QEDc1btMFfYzT8W?=
 =?us-ascii?Q?mMcqDvcKNi+KKje4tL6k+iKcU814R7CTMHriGRvTk55TowOl5MgyKJerbaO9?=
 =?us-ascii?Q?4OqKdetCGcj5YwPjK7fQR1yKtPEOJ3hQCP0NqfyO6q5QNEorWc6cCtRCa3wN?=
 =?us-ascii?Q?l+dIt2bEGRa7yBNn1auh1/aBdVHB6x6xthssu2RIR/q6AeOrslmN4iWLkRVU?=
 =?us-ascii?Q?N5Nze7WHA9PpwcZrEH9QQMqr4x99IsDNjIhfB6a+XPs6Y3WZoShNL6D7y/Ch?=
 =?us-ascii?Q?WC92HHkXMdOzesLzHruWEUlxm/m1jUUWDK+gZ1khjpv+SM/0uA5mHJnQ17iR?=
 =?us-ascii?Q?2yWwVY+2Oa5NHyGPLC/tp5N8gTuFH6Tj5LPqYbLFBsg/nL2FCQDwGjoKQgeT?=
 =?us-ascii?Q?SJdTETYsaNSTcf4aBw/n7vbre6UpO8HcGbFdWasGWc1mpe4vK2Ug1I0aM7nY?=
 =?us-ascii?Q?2HAaYos631vU9fAbHA0Lfajh6QuMr0n3aXHoItXIg4SkjKt4oi4Y5TykKEWC?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pZmzec7FK8jkY0+O87FhGi7FSlPV3nHjVQ37IDt4cHP7o7GkJMfDdYOvLWcb6pOJa54CftsJ7XGsdiQxSwxPpV3Z+9BXZwWWL5y0sTP0/zfI84hORUda7gec7v9INfyKiWO68DZhYSjKfSac9KerlVbRvh1QRaIo6hYawNT3tM5TOJB/TTjHBCxINHGot/hI3n6tiihyltAtkwzjOlYkuF86h60U5qSoDKit/cO6ikzEgR2OTSbErczgI6+y9nrd2f1wt9yWHLPHSbzLlx3y052nGv4aaBBnouuKqDvNCR0hIInUDRTEOMeiw95TFFfUeFHcxNylyVn3n7OCLHg2zsreQXS+fMpL+7qwGRa9atd0GfDI/3riPyG0yOJCEyWZ4eCx5WYJKEQCPpZcvliFMnT5qdZBTPv67CEDyYMBOyZUsyMTjWGpLcu5z9Lw3I/QDVccyrV1L8tzNTN6Pz8CpIOhoUG356Y48moniy5tG09TshNkAxIov+OrhRFez2eoKZ+Pk2VMAYllOrN9yi6KskK+8BSRF+M5YsRnT5nfqfs169QqGyPyRQVsgZ6pwvzOMolfGggvHr+iSFswwnsWPPbITcq+KiJU8G2ncgvkaJo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9529baeb-beb6-4ec8-b4e9-08dca643f74d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 09:36:42.2884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVYgjmbFEb6E+YRKUfrnJrlHFYsKhBaHUyjZZfNDdpMFHUbZ7NkuR+9uEHHfYW7nXvP0UUDA3cfai04ljlRF1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4815
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_06,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170073
X-Proofpoint-GUID: Ky5ITISczNizZ9l4tmGla_H11ldwCIIV
X-Proofpoint-ORIG-GUID: Ky5ITISczNizZ9l4tmGla_H11ldwCIIV

Document RWF_ATOMIC for asynchronous I/O.

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


