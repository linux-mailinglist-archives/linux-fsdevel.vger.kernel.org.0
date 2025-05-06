Return-Path: <linux-fsdevel+bounces-48192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D006AABE74
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5913B7C52
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C392A27605A;
	Tue,  6 May 2025 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nnbaC1eT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aRBoIbqF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05AE2701AC;
	Tue,  6 May 2025 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522336; cv=fail; b=XXe2X3p7Yy0lJmaLUwdQmSzrFTtavBgqTybK6WTrhdhlYPK1BkNyhF+mTOXKJ9geRHgp0/2TDfOoyS8pK/Ed3qg64omGnF8HOXccetHF4SIs5ixEznD4RY8h2kCKvMwuErzYI7QCSAAFQomdpQFSRjIjJ5g3fEd6Qv9pD8aGVls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522336; c=relaxed/simple;
	bh=Y+h0SeI/WhZZN7iLnPC7D4DvuhV4YxHgH5qJQhdZCUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VxPxkiiuxT63Xb0DOJ8alY+9I571fbmIUkFE0s9lcO/xmxuKlYH7184PwCxzBDAGfKsE9goeJwLEXkohbSAbm4dyrm5zuDmErI1ekTArr4AvkUYoyxJJL2DyryjZVES0kM5bPG0ZJvLn0J53a5GkIhRvzo5NYJ70R5t/azyWKZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nnbaC1eT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aRBoIbqF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5468bboL027336;
	Tue, 6 May 2025 09:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Knrw86SB2+FjQtTS7zEUket55dWzKrgXBuOYNwpvZuU=; b=
	nnbaC1eT6XjTLnoRoHroWPyEe6CdTPD5jo4zAM42/XfmmZxdRtTUWePII8U28grk
	klir7w6fjW6jF9EpGIzgQvOO2zHJhJL/FXay1LglP56YbadbhJRwNYWrq8q0IqX+
	dCAVSFCdIL7GVYynV8H1i4Yk8WNyw+sBJKimFnrdFGlnLx7Ff7t9nlHg+VB1qwb0
	OXQrs8cSd/fI4R3UBAal6vX0Btmv0sauOqRXMp4qa9OMXxcE+geEzsNV1/uVnuiO
	39L6rldIVAR076c5wjNyPisHGLd+emyi7OBhiAzJTRE40UQcnLieMtqtbLIXckWl
	ud3rcVSirwmwp4nB1uTI4A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ff2t02k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5467hOB6024461;
	Tue, 6 May 2025 09:05:21 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010004.outbound.protection.outlook.com [40.93.6.4])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kf062x-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qON02cns/233MbjACj1MBhW584hlOjZqh5N6Gp6nGY8boWSwJ7BH233Iihhy/i6581/idx/l70WDlanslc1SNpVF3tuM28Uj37MY/UKIuej2INo1RoJNZchtadqglRz6W8qP8iH3PuB/6cS4HkPzd/nolTOmfoTmo676eoRQNJ1K5SnDwyMRIaWl3fYvE7SqsnTt9Bf/Zw4SnVLkQC34CcDfdhjn0Fo0102rIQuSG3xUd9930GKOdlSUQ6wh81KG/WYmZU6lSLzPz9rkHeWY2A+vm5osUFPf1HyEmytHW9NcChOqZGMTix0iaSDMMC4tcu9xyDD35Md1vI+Wos3aUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Knrw86SB2+FjQtTS7zEUket55dWzKrgXBuOYNwpvZuU=;
 b=ljdtobG90JF+VaKwx4U6g0dX1WdHL4BXnz+ZQ7w8RIaU8V4ZQTThVGcvzbYDWvmpwKDbCvzEpIzKNgCNmzff+BvzPgUFeiZgsLvfULbHUwC1817B6yznojyjV3eXKhfIY1CMkNbr57WaOqUXCMRNq5mNn4yn16X+XWEbxbvUAIYtZ0mFqMALQMfSXjfiIEUP42oBTppm6ZkWNMepaYVnFiPW0qngsLhIcM9TeuG5nVSFTOfLIoRCRRBp3QTn/Xs8l43od/Gj/9bL+ki8b0lfKrjTH4/3Mgo1CGLs7/rf+wPgFeZZbb96nulAwJos3IIR+JNlzj5p+7/zxOrCePnAIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Knrw86SB2+FjQtTS7zEUket55dWzKrgXBuOYNwpvZuU=;
 b=aRBoIbqFuoXn+luyFEvTrF5L4VIZwMyGu0SpGFkHVEWHGU8iIZN64EdxOoigNl/Bgq2Ag808ASj1FVeDngZMPkUGfrfHaZJeu/QZ9eFDqyfUgTcIYqyB4d6NEIfUMWWqBs87wZL/BXEIyjwHbe5GrW7B/p03h6fyLtwouuIi7vU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6708.namprd10.prod.outlook.com (2603:10b6:930:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Tue, 6 May
 2025 09:05:14 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 09:05:14 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v12 06/17] xfs: add helpers to compute transaction reservation for finishing intent items
Date: Tue,  6 May 2025 09:04:16 +0000
Message-Id: <20250506090427.2549456-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250506090427.2549456-1-john.g.garry@oracle.com>
References: <20250506090427.2549456-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::26) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de180bf-c6ff-448d-fa4b-08dd8c7d1d16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?avqYrNWZMlWJrYNAlCyUuEb7BHoxrHmW2qlqGweucj/PzYVHiMGFqN00l8kq?=
 =?us-ascii?Q?JRzESW1lCln+vB9z9EKf/mS8654XZTXF3YhpYuMpa/Cc9fphh+okwR629n+X?=
 =?us-ascii?Q?gW4O1aTvOh6GhcaWtUYJzzk6LMaQ2deEtAGc8FzsZZGwimSdOssABEewGgO+?=
 =?us-ascii?Q?IdySgPX8rEUP6Maz9RMCdiZrsjfGdUewv/h6QoClB2TNJt1O2J5PRhst0TE6?=
 =?us-ascii?Q?IeQwStCw9qgjKU6ikxtaLi3P9MNbNfLDzop2LzB7qnL8pSisHqShHLIIBYJM?=
 =?us-ascii?Q?VygD5WtjfjGbT54uQnadRXjoIHOwQ3S+6hjEpLaZ+auWUdzC554NpGRl6rT2?=
 =?us-ascii?Q?HvS3jNr6vdKfQDYmfW1J4KQ/IgDBGjTVnZqVP9VQHKxYFh991IlZJACx4Knm?=
 =?us-ascii?Q?mOJgM+MGkGV0yh2vHFUE4AgmmZ+QQQb9xEjVcV711x5U3np4ZI5rYD5iSd7M?=
 =?us-ascii?Q?MschnaKDANBubIV34Ewd1Us3Lu2IGxxdwm5cIbOsjf+ZZww1vc8ccA5g2wqe?=
 =?us-ascii?Q?y4ZIfuEdLdWvbR5yuk8k02gwiFdp/uuvkWKFCGsCNqMIMjZ/2xK9jA0NUzf8?=
 =?us-ascii?Q?xn3chie18S22q73QXwKJJhTRwMMUYiNl8Ug/ELoCRQu6Ns6VLvjoYTkM65oE?=
 =?us-ascii?Q?gsAbuFLZCYjCru/b0baOPLQltt757CCxmtir2uT0+4LVoXdhOCSNdwkKHk88?=
 =?us-ascii?Q?mWT30qhD8DpuDiq+ZAw3LAGYSMeGHbccZZXykxcAOtOgDPoDbH6v5mlCNIKF?=
 =?us-ascii?Q?dZMjFCuiXp5kOoytX+ViC6sWTf1MCHBrTYHSJcho4TkZo2JQ524+p1z2ilH5?=
 =?us-ascii?Q?9g83Qfg23HECwNb6pLom6JqSd5BiM+pBsMCnEFO2ML7YEeuMe9vSrHTL1jd0?=
 =?us-ascii?Q?uOrT8ReM3qpDaxHbFwpNwILxRMw3FSHcQDq+g1Eqm8RLpYEPYgGc03uQ3j0O?=
 =?us-ascii?Q?TCZ8qZqVCRqh6zh0dUn1bg1cXshy65hLYY3MvlHeL0puAjDIoOapDrrxQNS6?=
 =?us-ascii?Q?Xz54qOMcZDXY07p9gmFAzQpSS1AMoOu37rWsRtHD9NimEMAQVBorSS0MIA/n?=
 =?us-ascii?Q?l8TQPVJ46SQ65YR3uDMdQRrn/wd/sVy85RA3w//KxDGkNsz3kj5IVzPdT+j4?=
 =?us-ascii?Q?IM+hz8XpPiEEMLeYFKxXWbapxhXmgHP1lUYeRC2Lfy2uV3OGUcWg0z70T/65?=
 =?us-ascii?Q?w1VhekP+UZg+cRMJXdwRjurRBPGs2nSfiZpOdYVYekH21vKdAjVED00bxWvv?=
 =?us-ascii?Q?P8cO7FwK0eXcj0WN+mKrvzsxGar6+Ms0vmsZUVKtOOISSFB8LVdcAiiM8jtv?=
 =?us-ascii?Q?6EK/S03rrpn/I8MLB9K5BMic3NXdv+g9xtbgfBk2T5a0ikcUP39u5DPH8NGx?=
 =?us-ascii?Q?u88gD5XoWpQyprccnscV7no0TnfRNCWH1szuSIaO1MsjwnLRyKuc+H2loPK5?=
 =?us-ascii?Q?Yuu8sZhqe3I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fxV+XpYnqAp/uSFDNsYwyQWi8xe8NlE2S2UQUKcOrQgXz2wCF6va6kEzmTjp?=
 =?us-ascii?Q?5ircoyl5NLKZrQkn50QJWc9kn94qJ2noSGDrol9dL99wTB3IvCpxP45dgkJj?=
 =?us-ascii?Q?GjflzMKt0Y39psvnM7xQDlSAQT4iLrZyS4p4S1CoJZO8yKBr7NCTDAVToFZ4?=
 =?us-ascii?Q?EFp/CJkeicfNRMZmKJMsBjunqWseeQ3Vkm21RrkMiobfQ51PRCl9wBy0N8sb?=
 =?us-ascii?Q?Jcy0soz2ZtPyIi8peZ7Lws6isnWE0lA2b5j81QUIZDLjCUGwFkWDmcSxD2nY?=
 =?us-ascii?Q?f5+DyYrPRJHZGtenwy2Ce6vUFcsBdGSHWuzSon3f0tNJ7BCaqRIRNyam/iPH?=
 =?us-ascii?Q?AXukBvUXAsDPxj97qRYTbihUH5ehBSAOoKPx7RcVJyTf78m05wUoupiG6sdr?=
 =?us-ascii?Q?5COCzmBcLiUE2DA4XGDQDxBgzIw3jkaa2lpWfqPCTVaoekRfe/ObdwGX3axT?=
 =?us-ascii?Q?VkRGzS9G3LoTcn0BR+aL3Ed4GCNivEzqHxBDtzftWqKMunvYRIG6XP+ag572?=
 =?us-ascii?Q?8BBUrSo1LkI+R+wOykvMeD4+WNVpkPR/wVBJwTm4/fYZxVMiG3+zU5thBKYU?=
 =?us-ascii?Q?gsjAUgQCiGi9sP4BATYyzyxvVXc5coMexGAm7aEG+hJ55qFaSjg91uQCJAjX?=
 =?us-ascii?Q?PIBKVN6quy6fSpJcK8z2JAtMhtLqLo6wryeGHzZ7fIaRXlHIt3VI9iCvCdZ5?=
 =?us-ascii?Q?hxsLGYi29TsdYVguawscCzPV0k3JaDeXO3gNilMHQ/thYeoemgH7lomCpfs3?=
 =?us-ascii?Q?r33qgjAQyPNsQE17LwfhregK53tiavIhc8YxGH753yHUh4rr/P9Saqck6zDG?=
 =?us-ascii?Q?XN/46mw8hogjaE5TOHZCd2JoSWGpJEDK3j7lOwjBsHfBte3+biLiTBcoiKGi?=
 =?us-ascii?Q?hnAX1LrkuNS1bMXZG5Y8HZBpgDA/PEDjTMyHvUW9A75bsc8+rjSbJJh6CHQ2?=
 =?us-ascii?Q?Pt0IHP57Lgr/1YfC0icBAV/5FV15rw7DG1QcgR1pKih+Q5Y4XVZIJh8VsiNW?=
 =?us-ascii?Q?7MOMC1IFrSw46w/bso6gH3U9twzj+sxP2OevxmDCBCn6qzjwCEJMy7lMG4Fz?=
 =?us-ascii?Q?9ypdvN4L4iXIFSNqtS9ohyEP9+MU/J/XpHI2ApfaGlB2RrU/cbt0TdM0BQKU?=
 =?us-ascii?Q?/LYpRvc/SDr+MHyBMc+bc6yIx64fohwPUW/bEM+JJoUNI81WyWhTFkRNgQK+?=
 =?us-ascii?Q?YvfTrBT+zFXYbY8YFTyE9MpHHvL252ujghN7Udjl2KLnxrpTKOIhJVzO8EGs?=
 =?us-ascii?Q?L6bC+Zw+knacMAL4F1oDXeH6tVw6kj38nWajt/nylgeQ1G15tR7IYF5GqU0G?=
 =?us-ascii?Q?ZmXAvQxA30kN9SirhEk/KMtm+94T+mNYL8m3ZZjN89WiHn4I+GZcyk8+KWC0?=
 =?us-ascii?Q?zL71pAPdILXPj31AfLPzYbIAuP3GN1PgFrlQtQbFw7MOiqYlZM81ccQ5TsRb?=
 =?us-ascii?Q?zUMQp76/5/xUU0JPwNwNpZM2sEx85dtsEEk98ltul9vzVdI36y+0bEhA1yf5?=
 =?us-ascii?Q?H4rFiWAo2BWcVFbzR/bPbiF9G9F4p3qAbaoKj4lQ3ocHt2YeFKu09AfZMpSX?=
 =?us-ascii?Q?9D9XceOrL5q12sq9XVhwehKUFS/+M9PzdxQhAoHUKUxX9A7dCgkeRTkVY3yY?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4uhjLcSG1klQgYGSvtPh/XP+Mxrgho1B2pAZT/OW7TX3qcJCNP2r90O88xNOezE1bzeeMkJIH+7oNx7A5l/WM/MPlLM6y32I8pxnNmf6Qbr0jiKMGE3/8P87cnH+I83ee7Fp+bY+5eR3O3SOD6J5kpVNvC+lf9vjxnrkkOzYJM8Enp4urYMz2tmu5sdNAYUM0Aebow6Brv3MXAWV+qWnIEHohEKNwBPknw5avMPSsxMoxPuwdsab//ByainCKa7grARfcLdbuMpBGGt/v9bdceBk7wuFROUD9MH0AHMXM9vx1HGdYMyfAontgQeNepJi0ZjWTR4N0CRJOHMuartWf6VNq6oHEgiiWIW7ViyZmNG9U87HDf4ULBfRSrD07bbutRTJCw+8QYgLZr2mlYQr1RVK4TVJG4pCbRYLC2aZIPnnfsAtiOWzN4r8Uhi77vQa1ayXsd/lEhRHslisGwnGNt3m/VOitqe0OMWY4KYlJeH9mYQKbLn4tIbNvNGFaFrA8xvhaOz+A+PqTu+/F6nOh8+zVl+bOvsjyOALKbuTm8Nng+x24jMGr/DURPH7SrieD4O7+ucqUlWg8Y0BONmAnmyMNHPF54JRReqQDJOr4U4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de180bf-c6ff-448d-fa4b-08dd8c7d1d16
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:05:14.5054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YwNBCm15N/8y08yEmsO4ckZkNTD6N7Ox62Bxn6PgAMAA0SWnyLfQhwbpSUGAhGfiJN0SJLfwm5NZVsEM/A22Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_04,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505060086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA4NiBTYWx0ZWRfX6aZPf7oAV4zk 3+nkOUOwRhVER2nh6kpzGLIhG7f7Lb9qzuLbr1vs+kyKe1noRNHDToFo+dOV3gGGO0sCVAqRwZW PVGOyUAypxuxZUW/RmAbCiZojNQdhqmOmEmH7Z+LU1Rm4/rPpZAXslBqWf3znPM7cwHtKc29erf
 p7e+36+tPnqMrQT+O1v0QzQzmh4UTshe912Wxz/yQF2d/bE/eUSwV77lhqhg70W/jGmnZfMj+6o CdKftuzZ4qP0Nuzcw8yg9Baesd9Q1jhwrULoyW4yPJM+7f89tLwNW9aiMFWqrQGRJK3nXr8QuNF vCxXLZGPBalmKi40pbnWtGn+sfRtEDHylutUGms1JeQFNxkaEumDSMbmZo3MCYeId2+MXF6Us0t
 2gvC6Tl8OQXJ9f6l0UWxLwSNMQeUFcp315+zCdzpvYZY9z3HzVxlOj+yuEt/em+dSmIqRKcO
X-Proofpoint-GUID: lEEW2337MhwKA6kxEm4lkkUH6van3ZW0
X-Proofpoint-ORIG-GUID: lEEW2337MhwKA6kxEm4lkkUH6van3ZW0
X-Authority-Analysis: v=2.4 cv=Xr36OUF9 c=1 sm=1 tr=0 ts=6819d0d2 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=woQZa1pMVDXcXY9PtcEA:9 cc=ntf awl=host:13129

From: "Darrick J. Wong" <djwong@kernel.org>

In the transaction reservation code, hoist the logic that computes the
reservation needed to finish one log intent item into separate helper
functions.  These will be used in subsequent patches to estimate the
number of blocks that an online repair can commit to reaping in the same
transaction as the change committing the new data structure.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_trans_resv.c | 165 ++++++++++++++++++++++++++-------
 fs/xfs/libxfs/xfs_trans_resv.h |  18 ++++
 2 files changed, 152 insertions(+), 31 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
index 13d00c7166e1..580d00ae2857 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -263,6 +263,42 @@ xfs_rtalloc_block_count(
  * register overflow from temporaries in the calculations.
  */
 
+/*
+ * Finishing a data device refcount updates (t1):
+ *    the agfs of the ags containing the blocks: nr_ops * sector size
+ *    the refcount btrees: nr_ops * 1 trees * (2 * max depth - 1) * block size
+ */
+inline unsigned int
+xfs_calc_finish_cui_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr_ops)
+{
+	if (!xfs_has_reflink(mp))
+		return 0;
+
+	return xfs_calc_buf_res(nr_ops, mp->m_sb.sb_sectsize) +
+	       xfs_calc_buf_res(xfs_refcountbt_block_count(mp, nr_ops),
+			       mp->m_sb.sb_blocksize);
+}
+
+/*
+ * Realtime refcount updates (t2);
+ *    the rt refcount inode
+ *    the rtrefcount btrees: nr_ops * 1 trees * (2 * max depth - 1) * block size
+ */
+inline unsigned int
+xfs_calc_finish_rt_cui_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr_ops)
+{
+	if (!xfs_has_rtreflink(mp))
+		return 0;
+
+	return xfs_calc_inode_res(mp, 1) +
+	       xfs_calc_buf_res(xfs_rtrefcountbt_block_count(mp, nr_ops),
+				     mp->m_sb.sb_blocksize);
+}
+
 /*
  * Compute the log reservation required to handle the refcount update
  * transaction.  Refcount updates are always done via deferred log items.
@@ -280,19 +316,10 @@ xfs_calc_refcountbt_reservation(
 	struct xfs_mount	*mp,
 	unsigned int		nr_ops)
 {
-	unsigned int		blksz = XFS_FSB_TO_B(mp, 1);
-	unsigned int		t1, t2 = 0;
+	unsigned int		t1, t2;
 
-	if (!xfs_has_reflink(mp))
-		return 0;
-
-	t1 = xfs_calc_buf_res(nr_ops, mp->m_sb.sb_sectsize) +
-	     xfs_calc_buf_res(xfs_refcountbt_block_count(mp, nr_ops), blksz);
-
-	if (xfs_has_realtime(mp))
-		t2 = xfs_calc_inode_res(mp, 1) +
-		     xfs_calc_buf_res(xfs_rtrefcountbt_block_count(mp, nr_ops),
-				     blksz);
+	t1 = xfs_calc_finish_cui_reservation(mp, nr_ops);
+	t2 = xfs_calc_finish_rt_cui_reservation(mp, nr_ops);
 
 	return max(t1, t2);
 }
@@ -379,6 +406,96 @@ xfs_calc_write_reservation_minlogsize(
 	return xfs_calc_write_reservation(mp, true);
 }
 
+/*
+ * Finishing an EFI can free the blocks and bmap blocks (t2):
+ *    the agf for each of the ags: nr * sector size
+ *    the agfl for each of the ags: nr * sector size
+ *    the super block to reflect the freed blocks: sector size
+ *    worst case split in allocation btrees per extent assuming nr extents:
+ *		nr exts * 2 trees * (2 * max depth - 1) * block size
+ */
+inline unsigned int
+xfs_calc_finish_efi_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr)
+{
+	return xfs_calc_buf_res((2 * nr) + 1, mp->m_sb.sb_sectsize) +
+	       xfs_calc_buf_res(xfs_allocfree_block_count(mp, nr),
+			       mp->m_sb.sb_blocksize);
+}
+
+/*
+ * Or, if it's a realtime file (t3):
+ *    the agf for each of the ags: 2 * sector size
+ *    the agfl for each of the ags: 2 * sector size
+ *    the super block to reflect the freed blocks: sector size
+ *    the realtime bitmap:
+ *		2 exts * ((XFS_BMBT_MAX_EXTLEN / rtextsize) / NBBY) bytes
+ *    the realtime summary: 2 exts * 1 block
+ *    worst case split in allocation btrees per extent assuming 2 extents:
+ *		2 exts * 2 trees * (2 * max depth - 1) * block size
+ */
+inline unsigned int
+xfs_calc_finish_rt_efi_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr)
+{
+	if (!xfs_has_realtime(mp))
+		return 0;
+
+	return xfs_calc_buf_res((2 * nr) + 1, mp->m_sb.sb_sectsize) +
+	       xfs_calc_buf_res(xfs_rtalloc_block_count(mp, nr),
+			       mp->m_sb.sb_blocksize) +
+	       xfs_calc_buf_res(xfs_allocfree_block_count(mp, nr),
+			       mp->m_sb.sb_blocksize);
+}
+
+/*
+ * Finishing an RUI is the same as an EFI.  We can split the rmap btree twice
+ * on each end of the record, and that can cause the AGFL to be refilled or
+ * emptied out.
+ */
+inline unsigned int
+xfs_calc_finish_rui_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr)
+{
+	if (!xfs_has_rmapbt(mp))
+		return 0;
+	return xfs_calc_finish_efi_reservation(mp, nr);
+}
+
+/*
+ * Finishing an RUI is the same as an EFI.  We can split the rmap btree twice
+ * on each end of the record, and that can cause the AGFL to be refilled or
+ * emptied out.
+ */
+inline unsigned int
+xfs_calc_finish_rt_rui_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr)
+{
+	if (!xfs_has_rtrmapbt(mp))
+		return 0;
+	return xfs_calc_finish_rt_efi_reservation(mp, nr);
+}
+
+/*
+ * In finishing a BUI, we can modify:
+ *    the inode being truncated: inode size
+ *    dquots
+ *    the inode's bmap btree: (max depth + 1) * block size
+ */
+inline unsigned int
+xfs_calc_finish_bui_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr)
+{
+	return xfs_calc_inode_res(mp, 1) + XFS_DQUOT_LOGRES +
+	       xfs_calc_buf_res(XFS_BM_MAXLEVELS(mp, XFS_DATA_FORK) + 1,
+			       mp->m_sb.sb_blocksize);
+}
+
 /*
  * In truncating a file we free up to two extents at once.  We can modify (t1):
  *    the inode being truncated: inode size
@@ -411,16 +528,8 @@ xfs_calc_itruncate_reservation(
 	t1 = xfs_calc_inode_res(mp, 1) +
 	     xfs_calc_buf_res(XFS_BM_MAXLEVELS(mp, XFS_DATA_FORK) + 1, blksz);
 
-	t2 = xfs_calc_buf_res(9, mp->m_sb.sb_sectsize) +
-	     xfs_calc_buf_res(xfs_allocfree_block_count(mp, 4), blksz);
-
-	if (xfs_has_realtime(mp)) {
-		t3 = xfs_calc_buf_res(5, mp->m_sb.sb_sectsize) +
-		     xfs_calc_buf_res(xfs_rtalloc_block_count(mp, 2), blksz) +
-		     xfs_calc_buf_res(xfs_allocfree_block_count(mp, 2), blksz);
-	} else {
-		t3 = 0;
-	}
+	t2 = xfs_calc_finish_efi_reservation(mp, 4);
+	t3 = xfs_calc_finish_rt_efi_reservation(mp, 2);
 
 	/*
 	 * In the early days of reflink, we included enough reservation to log
@@ -501,9 +610,7 @@ xfs_calc_rename_reservation(
 	     xfs_calc_buf_res(2 * XFS_DIROP_LOG_COUNT(mp),
 			XFS_FSB_TO_B(mp, 1));
 
-	t2 = xfs_calc_buf_res(7, mp->m_sb.sb_sectsize) +
-	     xfs_calc_buf_res(xfs_allocfree_block_count(mp, 3),
-			XFS_FSB_TO_B(mp, 1));
+	t2 = xfs_calc_finish_efi_reservation(mp, 3);
 
 	if (xfs_has_parent(mp)) {
 		unsigned int	rename_overhead, exchange_overhead;
@@ -611,9 +718,7 @@ xfs_calc_link_reservation(
 	overhead += xfs_calc_iunlink_remove_reservation(mp);
 	t1 = xfs_calc_inode_res(mp, 2) +
 	     xfs_calc_buf_res(XFS_DIROP_LOG_COUNT(mp), XFS_FSB_TO_B(mp, 1));
-	t2 = xfs_calc_buf_res(3, mp->m_sb.sb_sectsize) +
-	     xfs_calc_buf_res(xfs_allocfree_block_count(mp, 1),
-			      XFS_FSB_TO_B(mp, 1));
+	t2 = xfs_calc_finish_efi_reservation(mp, 1);
 
 	if (xfs_has_parent(mp)) {
 		t3 = resp->tr_attrsetm.tr_logres;
@@ -676,9 +781,7 @@ xfs_calc_remove_reservation(
 
 	t1 = xfs_calc_inode_res(mp, 2) +
 	     xfs_calc_buf_res(XFS_DIROP_LOG_COUNT(mp), XFS_FSB_TO_B(mp, 1));
-	t2 = xfs_calc_buf_res(4, mp->m_sb.sb_sectsize) +
-	     xfs_calc_buf_res(xfs_allocfree_block_count(mp, 2),
-			      XFS_FSB_TO_B(mp, 1));
+	t2 = xfs_calc_finish_efi_reservation(mp, 2);
 
 	if (xfs_has_parent(mp)) {
 		t3 = resp->tr_attrrm.tr_logres;
diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
index 0554b9d775d2..d9d0032cbbc5 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.h
+++ b/fs/xfs/libxfs/xfs_trans_resv.h
@@ -98,6 +98,24 @@ struct xfs_trans_resv {
 void xfs_trans_resv_calc(struct xfs_mount *mp, struct xfs_trans_resv *resp);
 uint xfs_allocfree_block_count(struct xfs_mount *mp, uint num_ops);
 
+unsigned int xfs_calc_finish_bui_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+
+unsigned int xfs_calc_finish_efi_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+unsigned int xfs_calc_finish_rt_efi_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+
+unsigned int xfs_calc_finish_rui_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+unsigned int xfs_calc_finish_rt_rui_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+
+unsigned int xfs_calc_finish_cui_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+unsigned int xfs_calc_finish_rt_cui_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+
 unsigned int xfs_calc_itruncate_reservation_minlogsize(struct xfs_mount *mp);
 unsigned int xfs_calc_write_reservation_minlogsize(struct xfs_mount *mp);
 unsigned int xfs_calc_qm_dqalloc_reservation_minlogsize(struct xfs_mount *mp);
-- 
2.31.1


