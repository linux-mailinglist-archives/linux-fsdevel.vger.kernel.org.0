Return-Path: <linux-fsdevel+bounces-47994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1F7AA8518
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 11:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7D03A51E4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 09:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF761B3929;
	Sun,  4 May 2025 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fKASTlf1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FL6SHQsA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B9918A6DF;
	Sun,  4 May 2025 09:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746349225; cv=fail; b=ZwL06d7EQOXVMD8xM3kuuFiMCtk3vaopIu/Ceg0hVKNWgLrUfGiQbOfDNaH1DY3cVO0vOi6x0p/DhH9GFpbsx85lg+/S/gF3h0m5zAsvyhpMtJ8h3VXYE9VB8JvOEZ8vp5yjlmKGw+iH8DeJTLXJC5l+eX5lgPCnnwTCWCfSthk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746349225; c=relaxed/simple;
	bh=Y+h0SeI/WhZZN7iLnPC7D4DvuhV4YxHgH5qJQhdZCUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gTUnNvoGwZArtI/4JH5CpBKNP3dFdwGPkWpTthAQt7XmzLbF8x8NMr17qRB2nPUtAHf97Kcw3yaIu98MWFUxnSuvCFtzMeYdU8clzmHGWP+KA3Qhsv/bkAVYlxtNHU3cGCTBrF9o77b83hljaiDRtI5QNJcEc6cmbOj/8SM2c70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fKASTlf1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FL6SHQsA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5448MANx029851;
	Sun, 4 May 2025 09:00:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Knrw86SB2+FjQtTS7zEUket55dWzKrgXBuOYNwpvZuU=; b=
	fKASTlf1bNsEYeblCBtLLZ1IAUSkK1zVO2XVwcbp/E5VEFh/CDOJdL3x2wxL6yCS
	PLx2e1rjZZrvoMoNgnC94qQjtBF8JUEt+NZ+9Zs6VVrPzUnLOYlqcgBe2qy6FhBw
	3fYWM7mrx7VJhvArpaHPL45K7LW9/Qs+iRb3cTbDLGGhz+O1jaNDzuPOPn0PxhRp
	GrgquQiM9VkiJ1DeVdGm8YdMJAaj1bcVmOUNXF1MesoDsF98ZnJFfmNQeUFY1JeL
	Qa2uclvxyQq2Hs5j0U4+lXnn2YQ3MfwO1bG/tEarJqwa08otUULt87u5uiKVw42t
	rn57lKeh0PcwnLFAIOjBaA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46e4nqr10q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5445tJYa038371;
	Sun, 4 May 2025 09:00:02 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012053.outbound.protection.outlook.com [40.93.20.53])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k6gf9e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OW23dTx8NjBXkhiGQNHWNzJlt/ohz1SoX7woqtDHFOECE0kGIISWiv/W1AJHH5nZZuSj98RcF6Yh0mjURYPdRV4l48AjRIeqmrkzrXbMHLvx2Ad8afSGVGq+KHTq4sw6HUui0GSmgQZowF7ITOVK5Wcj/M1flNoAymIw0a1bfJVT2JcP39kM92pd37EiH+phuP4Vjv6r+YmZ2WHoQ34EA/s9g9QbnOqG6RvrzjuyzE4zvtG/rkcAzlCedvb7HEbzys+ZtvVf2I3RwAMbH8sWAfLRSgmsNmaKkSPcTROd4B9jtfl7ZaxM+6YhsBQTWO4w6cw1LkCgWk5NHadXt3liaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Knrw86SB2+FjQtTS7zEUket55dWzKrgXBuOYNwpvZuU=;
 b=QX4h1sMYI5rJMYTzVvsVIvHhprhdHqFnHpfKmVadGXR2KTj8L5hvX6TsWVmeDBULdDPt01HairK/PzAJbIB0PDx+92LYfhrirmVutYdIPG6TbBairHh8jOb1Eb3alfzWBz4iQT1rql7AJxBLMNVj7OPYlvofUVQ0xK5gUjz7C9aiboQ5m/Dh+LGFjjsBR2TMfEcCxr5A6WENVnFNkGRjtEGwcmaxar+YhefA+i3UCXjpLVtmtop3XG9Aup5eI1uQOdwMGKDuBrhxxd286ZPQFJ3XhTxz/8qGTnAmZbUMsAduMiUv2OXOHpNYTIPHrLyuGBDAufYytDECvJeJw/yLcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Knrw86SB2+FjQtTS7zEUket55dWzKrgXBuOYNwpvZuU=;
 b=FL6SHQsAFxfqJuZB2+Pz+hTukKbPtWQWn8MMxo+aS4lhlFSZ1z85NnrmtLHPXIUTiPG2PxrCUzpmrqMpg/Bv4CpxDDbDh3jkevQkbq1iI30gW7Hr29kXhFadG1M9zLctOYXmzz79sF71GIpe+LsSfufLfXcj/lLMgRaQGW9aumk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7178.namprd10.prod.outlook.com (2603:10b6:8:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Sun, 4 May
 2025 09:00:00 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Sun, 4 May 2025
 09:00:00 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v11 04/16] xfs: add helpers to compute transaction reservation for finishing intent items
Date: Sun,  4 May 2025 08:59:11 +0000
Message-Id: <20250504085923.1895402-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250504085923.1895402-1-john.g.garry@oracle.com>
References: <20250504085923.1895402-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:208:32e::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: 417b03c4-6526-4e8e-6de9-08dd8aea0d38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lf8GxdUsyBhff7P0shwfUsG/btKPoHqTW4Fn6dBX//T2FU/msXSn/jX7NFyk?=
 =?us-ascii?Q?A7Dm240ViTVd8R6fypKC41fPYjRoUylq3mqtzLBq247wkwBKSjPhPWjRLHuJ?=
 =?us-ascii?Q?5EFNmObFvNUnPEFqKAw0zqevTcivA0phMw9DBaFq55zqh9KSlqcwX9PuySHP?=
 =?us-ascii?Q?rUBJoXyZHbEDyHLzNQqbZK82IeMzUYKHGvIDieAiKPHr4XUHWSkKCrX+71fF?=
 =?us-ascii?Q?X4P30Q2bKJm4/e2GI7jhRfNqRx4PyfuLjIKC/og8oVt/Y80KXyMEP3RFjQEB?=
 =?us-ascii?Q?PIY73ILlGQN68T7rpWGjXDh3JAUT1B4V6LTDv/AKRlqLOu7fMqQHAAAkJBhY?=
 =?us-ascii?Q?D4sY9+Q2on4kD6abFdJgoEr6MwLuQjCauOf9wVJ0OgcO4KBZiTBd4p5Uh2+4?=
 =?us-ascii?Q?MOmPRrm8+9iCSQWMza+LIcretThcVtRjBcgm4I61EPvygDEhuW5raloopUGi?=
 =?us-ascii?Q?hjywLaTHH0mp/r4rtks9vtvMydVtcCKGRMWTYUd5LnH/bdIUK/I2iFWx5ZEl?=
 =?us-ascii?Q?yp9nQpV/Fip6zpRkO2xqXP9XuiIH64dMiQNO7UmhJjcRdS7e+Qn+qxNrMAls?=
 =?us-ascii?Q?u1zwWhUHj/Hnw84ujoIwq29384/XsCMIiqDE2sb/ku3k7ZGFqBRXAVbsV/Kr?=
 =?us-ascii?Q?af9CTkra6xFmJQSkIxTek15ZQjuEDjSS7lwlZ2R5ri30c5W9tMqxi+9MHHHP?=
 =?us-ascii?Q?hXi6EJSNpzTm5UQa/AQX4RJ7w4kuO9eIv4bRmbmuJp4lmlBorKUcYnbGURIb?=
 =?us-ascii?Q?otinmWyok7zP/BdWKXPeLxXCi/IOm3zzCaej/o9a9Kuj2NwMoCuJRYvt6gTB?=
 =?us-ascii?Q?rdvHylLX9+Ayr+yVWk0fx2Oj0G+rIs0RNzKLKLw1+b1SD4e2E5DDMRZ517r0?=
 =?us-ascii?Q?XMjSwF7OdpW2PfGHhI/g4RWQm84vj7XWsZDViFhOsbMMj4crnOAkjDJO2YSh?=
 =?us-ascii?Q?/3sf4j0XyV3b0f3rIc2GVCaPs+J9ITZeJVlir6NVh9BwbNhBgBNeIucsROzl?=
 =?us-ascii?Q?0gh6TXEGKxnG/+lPRQoP1Xw607PbXWBXcWKSKt5BkD2rt7OFyYAt8iReTf8y?=
 =?us-ascii?Q?WN+kT6QvWvDUHpbjlirgQDoSF5n7fOMAC2ZAsRUzmw3eawuy87qOfCyadlxy?=
 =?us-ascii?Q?p+ucZJFV4TOJqB/HA1q6VzhE6flBqU+gN4VvgiRb9hoLMMtzCISe9jxMfzEl?=
 =?us-ascii?Q?b25/0oWLxaOUeSHfH+VIoaZpfNZ0WAa9MAx9pb0v/LkjHVzY1Z9Zi+09CsRI?=
 =?us-ascii?Q?wWgTp8+UvBG8g66SVVwKFkCnEh36pjAB1WnY/u6xUxPpUmRyZWaQUhH2VSHj?=
 =?us-ascii?Q?9Hr0+IBnD2ktJVqvgoxoDwtFvkx0BRs/Ou3OXhRAfxa6hDKRpuq+2i8lATxo?=
 =?us-ascii?Q?eScsviEKK5ZKC9S2aYGNy3AAKkvVhgdsCCQGqvusSTbS7S7d1izfX5VMwNC6?=
 =?us-ascii?Q?mimc6EHpxRo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nPqMT9Q3VoammP3P9BFzf7qhM64pMkbjRHIyy9e5mjwtHu7aY38UdXkMtxAm?=
 =?us-ascii?Q?zHWnIsuu1CNAGkctpLToTmrCW7MU3zDsK6EuYIbLEIz4Gj3LqolfkfQiuAf2?=
 =?us-ascii?Q?CxlU7dQY6LA2NvDsPkm+RNoWd7WcggCJacrmjfS0qvp3iB077yD5kv3mKcZo?=
 =?us-ascii?Q?heTrw0vM2ZjYwl91KiYF2LEtXNYHX2ySQq+loe8Cfub1zID0FMwM7r/lEAGi?=
 =?us-ascii?Q?8EQPi1wEYNDBShhqJ/ZHOHAbBnM6jRfAoZdWZjp7zy+/eSGbjZTVNm1iE2Q9?=
 =?us-ascii?Q?FDxsXufM5YbIo+UxWWrFSUiNx0w22HW/T0mwD2kyrCYPkGqYX9Et6yXrGI7W?=
 =?us-ascii?Q?iSQVne4EidcQy6Ak8XfIxjdvuM6fnRGalJji2Lp3QbYEQFjGSgrrdiTwSa/E?=
 =?us-ascii?Q?sJXKdck/qu2M+6aV/culPyeNPuKFbfwsKN860ygKd8Nhy6yaQh47hgzuHHrM?=
 =?us-ascii?Q?/6rlJD7IlqyjYLh8Xte2XU2YV0fyGRjHH3pRp/Bn0jNawYcUQixoYRNunQAb?=
 =?us-ascii?Q?T2lHoK0HyEgwIy7/5C7vFS52Kgap3h416mm8SyC/eVogAmm0ZpkwGJVWeoEQ?=
 =?us-ascii?Q?NE8KiFCiVlv2lLFYI+g7rbgBqk10d6iiyAD/wkuItF+Dot4rkQGJ3TqPoSuJ?=
 =?us-ascii?Q?//cRqi5HBd3j21p80WKsPbak9BzJ1ue2UgKUxHBgFDh0CK7MOwdIVWqFRcDS?=
 =?us-ascii?Q?OEtMzFwuxARALkRaIhiShrFluHSaKkGCoy/TjsEC/8PvhqtZd1CRoOrH4pCw?=
 =?us-ascii?Q?ZLL+FjzdVx6GRfOP30Daths4RKH2tIsCZq1RIFxqm8bv+PRNi5AHMuALNtTs?=
 =?us-ascii?Q?PVXoe/9ClZHpETTs2b0+nxXTF/EUc946780QeYFNraNLNuX540uXxoXyD1zZ?=
 =?us-ascii?Q?bSB7ZCtn/RbRsVj0bV8SgfMP/EwTEBceSYPbQ3SO6x+tVE/fRVmarqu75fii?=
 =?us-ascii?Q?9u+n2+trtwazoBMQ9DwIUzHJWdQgWzeSgUtcAsXdrKcACo2z5ZE0PNsrqDQq?=
 =?us-ascii?Q?0meHuQM3fMPo3fxEdZKgE2AUgVnq6v5f4ms2FA2zUafDRUKr+Ip2+y/imklK?=
 =?us-ascii?Q?jcEv9TGIfg4cqxIEbrroiFoBaHMqIGzNkmaK8yEHcBePqdQAt3yGDPVtSfJX?=
 =?us-ascii?Q?ghov7nK18phTWfeBrHotRG2xhPGtnqdYrxZugTdluE7g9cX+N+tZb1vH0eG1?=
 =?us-ascii?Q?OC5Alpf1i+KDNPnFfmRGQ8SN44Mu5H2vjzExC96BvNbAaXs6ROHUsCANrDiq?=
 =?us-ascii?Q?OKdN9CR0z3+9cOu6nNr51DV5MpO7u+4QVWo7B1aWt7X51IXWLgthXPxh3PhV?=
 =?us-ascii?Q?mWG1dX0Q/UpM3j3kSYV931NktvfxTF/UonEPCEtjbABpkar3rnMAivWImgz3?=
 =?us-ascii?Q?aU24X1BAT24t5w2wcpN7wdpx/l9FBIq7sqKJ7eAEaoTvoculJqciF7FTzXtE?=
 =?us-ascii?Q?HkNDiUWvHEUqvct0MtInOoR82Z7+w4wKpiVfkHT1BzJ9CTfk4+uyUYjrTRlS?=
 =?us-ascii?Q?Viu/ElmOo1WszgLdKKMDWYCHuFYsFGnP4fBDfExbrUkSXG1TNV1ItLaECl0w?=
 =?us-ascii?Q?vbgvsuG7LrMiAwEkp6xebx3WYVisfjolHLNThxPg8sME8hgNmArem7Uo/HoT?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NqVJPGrg8crdZvhaUXN0KihmNm2k7UcGRb9vAoBSVBkq9Qs5Z6FZMm9NefqIH0n+7L74LhX0ICjRGgMztifXlkQT31kIZ6r+xPBsrVpEvcS71/YA20CRBKEjkejMk1lFqlDG3NIri64zZb8adbqNcyff1VJYGuc+XIe8jbuGI7uWbHlUjc7n8uv//on+UB2UkXxFC5aZqWcIufK6HaJZ8Tv3tk0YmUIG9S5oVTPh9NiJ1n63Xb0RIbcsayMJ9ztDTFPPHEJXvUg4mm3OxKvGb9RHyvpOtXqytfBkK7M1I+7ixMfe+n3EFrvk0Y8L4HxEP9e/8sK+HsmX7tZy3HXihL0zmCRFlpK9hjP8YHtfYjDJmdtJwAWYzaC9dvbjBAtodl+g9jyNlabEr9yb3KSP5tl/KavqP3gx6H1vTvIcsU7v+UPFw8fZC6Dh3FB7Cy4xOYsnyF9+4raj/OXkIfJ+N2jzk9AlXYVP35pLnRmIpLqAv9G3EIIt5Y1mCS583zze5zy9ghpqsITWmgeHgiCowgt6IXbOW+2ybn9lCSOpI7lpLDVoq48hxd59qderj5XTBH9ugCZpL6+R7/N6o5ECdd+D1jUHoQibh4FKCjGH0wk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 417b03c4-6526-4e8e-6de9-08dd8aea0d38
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 09:00:00.6310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCKoc3cDupQn+NDMzVr2XMtz497iGmY9toljFT+gnVimKwYFaDSTQ3AyFsEN02D2OdZL99sLxxQxZoEyTlOU6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-04_03,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505040081
X-Proofpoint-GUID: SBXEHcCzjQVcxX_mnVg5i1ElTD4EdXEy
X-Proofpoint-ORIG-GUID: SBXEHcCzjQVcxX_mnVg5i1ElTD4EdXEy
X-Authority-Analysis: v=2.4 cv=PouTbxM3 c=1 sm=1 tr=0 ts=68172c93 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=woQZa1pMVDXcXY9PtcEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA0MDA4MCBTYWx0ZWRfX8gt7AVwUyNIW EctNmiQmqvIBHe9/u0fc+0ar92NnXynivwSLInWQp+a05wuULm46g2wpAF3edgIabPlicZYkcjY lhMBGP4ysQXxg4/sAzJEY4C+GTiaGcp3tM5aoWlmai4D3lw4fAkBig3OUS42CQFtCQis5967mG7
 gWLUUU6O5NlqcXha5YkJiKijxlQtnYBS5HsM8mWY/E7tzs6ZwRjVcHhMZzTxMgcv+vPUG/SXufp 4cgk6CBkAl6+v5Ym4RV9HI5X1UlAXm9j4o1dv8JcBJov4jd8Zpjdy4ydhAmnrTiPL012NVZ4IYs 65RyXkGFXwNK1UbekqwydNaglXa1BNX6QgOm3qq6wGqkJb0KogSq4AE19aSNuk2jpiJSANLWFpV
 Vtz/2z/L9f2f9VZ91J6MgVwCWyL/UPkpca761y2KYWy1ywEjP2cTQmoaUqsnXowJQXBK7Hr8

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


