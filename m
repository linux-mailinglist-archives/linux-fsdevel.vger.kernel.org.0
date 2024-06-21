Return-Path: <linux-fsdevel+bounces-22102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5666E9121B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 12:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D201F270B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 10:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3594B176ADF;
	Fri, 21 Jun 2024 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fjrKxTgI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VFPAER7c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2DB171E6E;
	Fri, 21 Jun 2024 10:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964448; cv=fail; b=OJFGY84ZUBqZkPpP26WZMXdH9lxCrKE2TpdgGiEvi8AFD8VJB9hE0R8/tMsKLT3OHlhROwF9FjC5YkWpFvWMh+aXLoOI8aTH3fzmyHlCibZ+93LJQJnaT5XiT71p0JLiNSqrYlrgcpeIrW3J64fDh4Ha0T3KRIyoDjkvZqsq56M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964448; c=relaxed/simple;
	bh=GcbmBL1lV0+kZksOzg8pr+3iWYKQmTm9HLCWKD5ujT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WziNepIF/3BVIEieEjNRkKWCz4YD4GPE9m5XSjLDGjyKpWsv6D1wtuyVIehii2QaFY2OjL1QPbBKSS4mYD4vJtzbu1utMGgFhUqoYzL56gsFRKxfooa2Ko97E246ahn8XvVj3GxoX6jGzx0iGV+J7h8SGKmIUH7SBV/nr1igBFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fjrKxTgI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VFPAER7c; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L7fQc7018895;
	Fri, 21 Jun 2024 10:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=0I86EzYD0KpfXXo4D40BE0qaPH/b5Hb3h9qAs5b2Ubo=; b=
	fjrKxTgIbTQu/4Wxucs40CxGDEAkFFlTxQM6PjFsqCGkTxqcmjut0hAVpDWsXwmc
	h/ZHJvrsk9EX9xYvGHu2RcdJK8uozEnv9SMnsDpVF7zZA05ZScj7q4HO4cySkq86
	ua46HZo2dUvCRI4r61FRRcKdqI69oraLySv4YMqu9XjjZlrojOmtoZCWDpHlEDyY
	jfpT8Ry7miM1GUXSdA8+velcWj+br3q+dR+v1yvqVd1LQ/4zLnY1033Z9DppSrHT
	l78bjH7d8bXAAEEyse3KNUipuUqP4KX3NvZfKZqaNJ1hpsQC+gXeKBT9v3axRTbs
	x9YfjKd+qiMacWnHDP3LJQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkfseer-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 10:06:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45L8VaeB019711;
	Fri, 21 Jun 2024 10:06:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn3my06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 10:06:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkJlwBr0m+wm5jF24c2hMF66B2R5RfUUItSqUD5PY2X+js8DvIreLklHabPQe0dewtPgiAzpOi1nA8ZnVbggaYwNW6/ugVbktUFsYcq+auH0CRWTtKVEtx6Hbi9ZU3mYlO6mVttbAvzq42IsrHSbzpNqSV3yO8FF9PiwyvztFSinVZa1sc3aJuEyJj13uzxgqFk/pawC1WmrMYE4i0zPQT2+ZAbMxPtdRK8s8AOxR4iFe9Ah3EZ8eIUbqArKdwzoEFEvIoDnjl8WRKvFSkT3VSxLFfl/ukeSu9ghX5MKksH+GPCZDGD1OlT1+h0Io6AYRcCSJg0u4Iel5P/UZ48hZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0I86EzYD0KpfXXo4D40BE0qaPH/b5Hb3h9qAs5b2Ubo=;
 b=Y6UenTqvitANk7uf6ithdpT+/8TEgEpvMJDo3F/Xqd5dJ2bd53eOUxsBA4YNRmf4rNVm2vyB3Ej6ogMgYImy8ALVa7bKCLwjYKJ97PZfxjn1+oKQ7SVgHTUDeV8tvLvMlDGwpPC6rgFf6IFsIswNpIoMSmHJmEdFnlf8TyXViykpzFumS8eWqd02+SqY+JNDsX9DexqjufAxbMZORpNmlSDiuRXhdbosOw7BNzuOeY+1EGXS6e2+0owDT/bRbonzGTV6wCgDd6Gi9I4VTpiwo86rB/Dr+ZdFYHdqF+n70Pcx+unnnAl2IEHy9ee0UclqhMpOo0rDyh2IRuOnjbFugg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0I86EzYD0KpfXXo4D40BE0qaPH/b5Hb3h9qAs5b2Ubo=;
 b=VFPAER7c8vKsYNmQ9y7tyOpOrOAaXw6FtIPhPgr/hP6sscNqajj9Kj3YtustzrU/XQDZ1HFy62VSWf/6OX4QN2Kp8RIqsfVArj8YyA28krQf3hn8nAL8kBTnIfSqdowBkr+mMK/Lu3wIQthAmG5MXqrU4agg73iyxJFJpXKl/S4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6884.namprd10.prod.outlook.com (2603:10b6:610:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 10:06:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 10:06:16 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 10/13] xfs: Unmap blocks according to forcealign
Date: Fri, 21 Jun 2024 10:05:37 +0000
Message-Id: <20240621100540.2976618-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240621100540.2976618-1-john.g.garry@oracle.com>
References: <20240621100540.2976618-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:208:160::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 43a3a573-5a24-4036-b56a-08dc91d9ca0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?new4WCIoR3mDH8bam8RpvX+ANSQHLs5tnnjx8WVPOr4WdLe7bEkOy3ir5BtY?=
 =?us-ascii?Q?5l+3n1clzV4QtnZad/2jvJt+MPZjj8dOOnv341Q6rCZQJvz2Ar6+dR3myBR/?=
 =?us-ascii?Q?zO8R8B8nJo5cgVKQnqwFDJ7TKABxBmv9xN8BCAHUv1l8JxQU1Im44BEY0TLU?=
 =?us-ascii?Q?qgNCnFQG7Vjk4JGg+MWWbOE3Av8U340/qbG8aKbPI6UwS55lRBuOCr0pS8to?=
 =?us-ascii?Q?yVSEOGqBlqx4jlxaUMuOmwOmtlK6+1uCCOC99ZgKxHHFoKHZtnuhIW3sYmFS?=
 =?us-ascii?Q?quXRRuz2EmHqBufHyxC7CyoE3RYI8LbQ8C7YjUr8ekJfzNpWTScqtfF5Di4i?=
 =?us-ascii?Q?rj/T7M8EEy0XwSppFQHSbC7syS6j9bKsa/8OOg16/6EmulReVKWJed2UgUM/?=
 =?us-ascii?Q?EAIr6cEe/Y8M4fhdbeD2cr1eyGzIU4IOTMCJia1ipyuImXehomcfhK521+ik?=
 =?us-ascii?Q?ydi2F3E/HH+aBk6XKeh+KpvtATN3wRd3z3+QzmUVlRZpz5/Q9tG4M4RXrcd/?=
 =?us-ascii?Q?11Od+WlxYknEp/wPIzxV2XsV9h7RBlpkNHIuJLBJHRcmNOeEApz9m8fFjqmt?=
 =?us-ascii?Q?Yun5XDBxBgYO34KCoFLyJAu1fAgA3foNIoSgKzGD/aAbFzhNh7MnKI/emWZB?=
 =?us-ascii?Q?MZNYi6W/wfPnrIq0d1Xn7dFGtQ7ntMOQTB5/9o0fk4TPzhZc1KOTzwh5MG74?=
 =?us-ascii?Q?+aXulDt7hYS1AChC79bdzwAFNr9daQ/r4biG848bc1l1/1BjhKoYVRxCULOo?=
 =?us-ascii?Q?xzchYwgymAE8a3038Ao6lqZVr/cPSJtlUwkCWfG5jzcO5etze9+DWvLJJIGv?=
 =?us-ascii?Q?BFmdw6M4xtZHzrzMZM7xRuXHMZzdPJLR7yC5hQAxUjg0eJuFZ9KHocDkbbPL?=
 =?us-ascii?Q?DdY38Ksq7m4KtHpaS6+YQn3C8EDpu/P/1rwPc+oFHir5gMlsAZV8JFclJty1?=
 =?us-ascii?Q?+jY7n9O9hT/xdAohaaVnUrwlZ4AaiGPEqTBt84d/au6Pdt0ynaxeK5HYt4od?=
 =?us-ascii?Q?jvVWVNQUc9CuGlfgF/L/i5ukDjSF9VEuz1LLd7TicVCJM+TpOx8li6l+4oww?=
 =?us-ascii?Q?O121zmf806BfGsLGSmzu0u61G09sAuZ3FXJHm+7461DRn7lMjivJCrz6im/Z?=
 =?us-ascii?Q?kNZa4grLHgJF+FgSzKU7VnGW8ZqTWpeIiMDAPCvP95oVwznCaVqvkCjbIw5g?=
 =?us-ascii?Q?M5JmzK5xN/U5/3MD4C6t+fRaM1cLye0rzQOOOGP6kqkz+rHI4wXOhgGEnIKz?=
 =?us-ascii?Q?DSWxRMVlslIAeibDZnt33PRosobmayD+L1/AaPgzbfN6CHA9CQqPZJXbkZqQ?=
 =?us-ascii?Q?mS8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uFTgokuwfodmT+SXzYkPQpZzUFa9QW0/w5+pwcSWmepo7GQRRcXUaQ4U8tvt?=
 =?us-ascii?Q?Bnr/hVJARh2wWtFJmtsdPBRheGiwbzDOPlBZz4o6Sj9dINNUYwX7XPen95LS?=
 =?us-ascii?Q?LQQCXlygyaaJSDiuw0BcpBzWafEWdgYQi5tlTvUqFCAvC0BoCjtrcszsFmOs?=
 =?us-ascii?Q?ijnE2fJPKNqpbTvFpn5T4ImPNu4qVXd9JM3xJtYBUTSiup0h4frxMV0WK5qf?=
 =?us-ascii?Q?aag2tY2oaDM/FJOVQ12Q6XJat9dfNyqzr1S3lQ8+iOlNmzQrJK23dh18tgjv?=
 =?us-ascii?Q?TeHSIyW3h7oXTKjtwssnnOIm7/cv2mvjtYX5geA8ya7zugme1UPWhunVkW2a?=
 =?us-ascii?Q?VB4GHQ8YOGkDc31UGW8am0ThX6uOjneBIR9gmQE8+ey/mmudEKn0lkWrOJyA?=
 =?us-ascii?Q?Pa5BuYgui6gOI/t39oQ/AjqlcsyMNi3amgUHF7SxMylwJZD20VurgZIV/s0r?=
 =?us-ascii?Q?OKvfjof2fbaye2D9bBLqMtL6zElcHgP1Z6ReKola4SBTr/XmD+BU+n86q5tN?=
 =?us-ascii?Q?PUnERGDaCIzHPioxtoDPqds9ssb1RAF4n5h/HQzc+NJiLwXphwdelJJqSHci?=
 =?us-ascii?Q?BTEuU2mIHxE2zN0m54HJFZvSsI7D8KvRQ+VR54BPAoyAOerjXXXKL7hothIH?=
 =?us-ascii?Q?5OPS2aj2rOAmgR6WMCGgNqRO8Q5RRsacuM2dOBZvKZJaurnKu5sno+Tf/In6?=
 =?us-ascii?Q?fylE8+zjC6DyVV6fZqPUUgKKooCWFFv5dSJd5/GAWeM3LC4Qtl1Y1wf5iv7v?=
 =?us-ascii?Q?lfiFT5hF3TX8kdXwGVQcOl/gKPM1Yafb0JIkUjhdlVJaUKglQuas8RWvLVD1?=
 =?us-ascii?Q?ZwTJ9MrijyHRIs6yMYfJ00dAv1wG3i1F0weiebgiiKTMkJAwj8VkgDg7HeVv?=
 =?us-ascii?Q?UtiI/KhBKI52Dc3bbL3XpVLRI3isxqsJS8ya+a/O2n8M53Ue6k4VMkyqluFX?=
 =?us-ascii?Q?eAnf1klwey+yh9dBEYq+bG4HuyyAGOPjc+muNF7uXhg/NEQT8SQf3Fc8VB0g?=
 =?us-ascii?Q?+PWG7x+l7rZ9Cgi65bzTSLqGM3OhSV3Haduvn8znNrAEcoU/gTLHqKbaKUsk?=
 =?us-ascii?Q?D5YywJK5E36A4fgTDAixLBCMlstBrLAo257IasGje/oTcB+BtuOyJBPISQ4y?=
 =?us-ascii?Q?jtSZu1rT7DPSCKyTOAZc/nU/+3KKCwLWrKRSDIMOjE4i284JzEud/WZSVzYs?=
 =?us-ascii?Q?2dEdgxVDWuqW1w2xLsdYZflFDXNGl1ITXCvI8h5/X3NQKYMDbX2aD2uNAHLE?=
 =?us-ascii?Q?qnmELD+fUkoq2BXFUhoZDQ481gKH9k73OSi7GF8vmRadyoP5pMWlFJ2dGkKc?=
 =?us-ascii?Q?AgmaJ5va+uCSjIwX1zSAjU0t6EuTxB683FUnk/kGtLIGHmaNXFP/5Hih/+zY?=
 =?us-ascii?Q?GUaYttyUG3ZdkO2dRCo9uVPwOIBTbU7LGvNrWJcvIYGAMdrhAk+KaS7DpTEQ?=
 =?us-ascii?Q?pR9jREU6wzu7cTkR6WEGjBysZ+uytSOhHl/eRaOhfMDmnarN/13viBirJLJY?=
 =?us-ascii?Q?euOuBgdl5xbI49wMxuUbIt+3fIoK5hIjpLo+S/Sy6FKnDfv7wJyUWM4Ry3WO?=
 =?us-ascii?Q?wjkf2+F5RlOhRtYiAoY4tUa1MRx3x/sfeKqwqTfUyQDoYTjLdBhPNs1YDw5T?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TTG14423k6Z9ZIZpCoReJqB705rDiqgnCTkEXBLjMepA37OURXRy9Y1HDrBnAOxgiOxiLG+YnM/5dIfbCyVI6tRt9sfwqU4tuLvUMH6LxOX8FDBsUSVxMgj1i97VEu6+GF4fsp5857AH3nIzaUOvQ/fOKKCk9qL01F0qFoqLRqR60gtYeO+RImyFqFVkkHGZn/4WuhghTg+DjM8WpokwyCjwFJNjAelWICXF6fDmKTK1sI/GFZj8VMMxZinK9w4DZQSz9uzZYQwdX+eQUQKiQt8752JVsmSl1LQwCO92gXkP9eycjMMkjNB2B1kZL21ILnbXP4wX1uJBtYPyBOrkmBvW98fEzyQdA6KaXYRtUe1afHkdbHgW7tywW/3wj9OONmx1aNFk7/XmzRjyzjJiAIazW/8qECliR13HZIxfmcvdFLSQpqzEdifzdKlDw8SD24cCbpZ8grSMBL2C/VBn5jAbAnkWUKa06sVsRtU++q5qNC8H3kKjpVl2MwoIsuVVkITwWayFV4khxreuim8UJBEMG+0fy9QG0r2sKV6+XtYFxv67QS7OqcwkSUkgUc6up7YNhXqdoObJlGK5+y5vvEwbEYR8PqZ/1ilsF+k5Wqs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a3a573-5a24-4036-b56a-08dc91d9ca0b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 10:06:16.4591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7yfMH0P7cwwHC83V94KFciS8xI2muDo4zHFooycBKeyg5cMi0fEY4zkApcPT5vG/yuM5CoogwEIoI6LpPqavzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6884
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406210074
X-Proofpoint-GUID: E6t1syJbuWpt71Aq8r1a2GRsjS6iKx9k
X-Proofpoint-ORIG-GUID: E6t1syJbuWpt71Aq8r1a2GRsjS6iKx9k

For when forcealign is enabled, blocks in an inode need to be unmapped
according to extent alignment, like what is already done for rtvol.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index c9cf138e13c4..ebeb2969b289 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -5380,6 +5380,25 @@ xfs_bmap_del_extent_real(
 	return 0;
 }
 
+static xfs_extlen_t
+xfs_bunmapi_align(
+	struct xfs_inode	*ip,
+	xfs_fsblock_t		bno)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	xfs_agblock_t		agbno;
+
+	if (xfs_inode_has_forcealign(ip)) {
+		if (is_power_of_2(ip->i_extsize))
+			return bno & (ip->i_extsize - 1);
+
+		agbno = XFS_FSB_TO_AGBNO(mp, bno);
+		return do_div(agbno, ip->i_extsize);
+	}
+	ASSERT(XFS_IS_REALTIME_INODE(ip));
+	return xfs_rtb_to_rtxoff(ip->i_mount, bno);
+}
+
 /*
  * Unmap (remove) blocks from a file.
  * If nexts is nonzero then the number of extents to remove is limited to
@@ -5402,6 +5421,7 @@ __xfs_bunmapi(
 	struct xfs_bmbt_irec	got;		/* current extent record */
 	struct xfs_ifork	*ifp;		/* inode fork pointer */
 	int			isrt;		/* freeing in rt area */
+	int			isforcealign;	/* freeing for inode with forcealign */
 	int			logflags;	/* transaction logging flags */
 	xfs_extlen_t		mod;		/* rt extent offset */
 	struct xfs_mount	*mp = ip->i_mount;
@@ -5439,6 +5459,8 @@ __xfs_bunmapi(
 	}
 	XFS_STATS_INC(mp, xs_blk_unmap);
 	isrt = xfs_ifork_is_realtime(ip, whichfork);
+	isforcealign = (whichfork != XFS_ATTR_FORK) &&
+			xfs_inode_has_forcealign(ip);
 	end = start + len;
 
 	if (!xfs_iext_lookup_extent_before(ip, ifp, &end, &icur, &got)) {
@@ -5490,11 +5512,10 @@ __xfs_bunmapi(
 		if (del.br_startoff + del.br_blockcount > end + 1)
 			del.br_blockcount = end + 1 - del.br_startoff;
 
-		if (!isrt || (flags & XFS_BMAPI_REMAP))
+		if ((!isrt && !isforcealign) || (flags & XFS_BMAPI_REMAP))
 			goto delete;
 
-		mod = xfs_rtb_to_rtxoff(mp,
-				del.br_startblock + del.br_blockcount);
+		mod = xfs_bunmapi_align(ip, del.br_startblock + del.br_blockcount);
 		if (mod) {
 			/*
 			 * Realtime extent not lined up at the end.
@@ -5542,9 +5563,16 @@ __xfs_bunmapi(
 			goto nodelete;
 		}
 
-		mod = xfs_rtb_to_rtxoff(mp, del.br_startblock);
+		mod = xfs_bunmapi_align(ip, del.br_startblock);
 		if (mod) {
-			xfs_extlen_t off = mp->m_sb.sb_rextsize - mod;
+			xfs_extlen_t off;
+
+			if (isforcealign) {
+				off = ip->i_extsize - mod;
+			} else {
+				ASSERT(isrt);
+				off = mp->m_sb.sb_rextsize - mod;
+			}
 
 			/*
 			 * Realtime extent is lined up at the end but not
-- 
2.31.1


