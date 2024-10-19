Return-Path: <linux-fsdevel+bounces-32420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 508169A4DF5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 14:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF5D8B248EE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 12:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B457DBE57;
	Sat, 19 Oct 2024 12:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MEATX+W+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y4kKtAKT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071157485;
	Sat, 19 Oct 2024 12:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729342369; cv=fail; b=dlLfmGk/2TSlXXLagVUQk7CHMLhfiEFiYDNvBNjwmyS2b0MObjUI+dSv3EfEvjzwrvn2y9aCw1uMtO6dFLAjXv+ywcS3Ri0GHfait8QPMqncfPVY1mx8iba6tj9VOPzwsMcD9+NJh8oeXLVCtnMm2X+4G+264dfuNewM2OJ9ObY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729342369; c=relaxed/simple;
	bh=3k8YlyWoedrDmcHXS8vYxXDkrXJWfaJ0K/l8qe3kGXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pgzud69NRGN5TtbBpFE2ncYDGT2ufFxSmcL9ayOdr+CMoFc7+SlXFMv0mb6Kqn6znr6I1XNx61563x9XffzjN9S4VyYTuR45ddPAkbvC8tJE3WKDorUCna+c/FooesG+fgUp2Mb9ZEq+KJiYPldSEbJp1GBgKA30OsbUk2Jbf2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MEATX+W+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y4kKtAKT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49JB9rF5022793;
	Sat, 19 Oct 2024 12:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=6TBUcSBMjRN+CVXfAOayVUIdEUhKXjFo9KkvWHdeKsw=; b=
	MEATX+W+XQEx+3kETN6C8vFm9K2qBb56hSgqPZD19TRKpqCJzIHfuSpveuowN1sA
	6AfmbYtZX0Y/hjJX79ASTh2gP7/r+2RM9dGLrg4MnmQZ4n8RUhAGOvtxCmzk0C5r
	GjE1b6lhYCQZ01ENmW0c4oJE/xtGvTT/nTwz/mhm3lHbHPjWMI7KOY0Vx2a0kAaY
	gN4TC7/PT/lYWaV9FcnEip2dUUJG0sKfoEXgtG7JxGAt/VOOiT/QXfcqaHzqqNap
	vjgvEo0jZILMBIbeUfgFRzNleNH6QkLUUWDNoOPvbdbX8vFBXjs+tVoRU+CrfH/m
	ZGtxMocjYpDgOQz2YmzC7Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5450a0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Oct 2024 12:51:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49JBO4PT019660;
	Sat, 19 Oct 2024 12:51:33 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c37atge4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Oct 2024 12:51:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTPNWAmYSvc4U9nCUBgJFSFVlEEF6qrRsRCGgRD27wd4hymIK2K7JwSUKUobEM/DuRVwVHiBF0Tl1iI7szd1OG2BOBskRVhX5oZV0v1RaBg+D0d1Guv2qmHHwSu86V6U+WNrcXaPBDNmruB80hQwHbaNDMz6h8Kj3fgyXAMwOrdZ7cHRERNyQHwdz8LT2pylgTLkHz0Wq6swFYdpzR1UlBVgOEsHVvwM4HgDm/wS5pqTx1ssQjlKy/kyAc+vmVW60hks3rbjH3plK5MWNpxU2Xjg3PHBvAfHv1jAqQkRU2U9ZIssg5mo5FF7zuiXZZK0xWHXV2EC8+kGQjJR1mB6+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TBUcSBMjRN+CVXfAOayVUIdEUhKXjFo9KkvWHdeKsw=;
 b=sQDohiNmMbn/28/dty80Eh952qfpfXPBDyUjs++Ib1rR+6snPjUYNVeP+L5RYNC3f7T/D/NdqURFBuVkCwznB84RP3nT7UXpI3oknaxMt4/6Kse5SY97qRPpxkwFxa4SQg7p6VmptkOYeygDrPVs2Zsug+I2VpOa7S7B0IZisjUVjOqG2jDGOjm1BQFcNZarNHxFVnvHGg7RNt8U6WHMuTtD5En+40nvH/TMxiaRgwDrlsg4bNKt+tQKi1431Aa5oAkdSQOyozfE52kRfExg3KBmoHJbXQmNhnzu/SiC6kYuQIdArVH8sSNqYC6K16c81CKyWFRCdB5cE2O//dTbZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TBUcSBMjRN+CVXfAOayVUIdEUhKXjFo9KkvWHdeKsw=;
 b=y4kKtAKTnvOsFxlp9kKZu82OjIRRTyEYB1WA36Zpqrn42hmhIe5gOGIxGMzwt6HO0vALgS2yoLx3XZbUMODJl6au9BcXhX5+x2xLRd/qmMHJjA3ayxUjodXxbVWFMIcD3kxtStnbPceJ0d+8ts672/q7kxBlzuZdAm1Lvfz6EyE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW5PR10MB5874.namprd10.prod.outlook.com (2603:10b6:303:19c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Sat, 19 Oct
 2024 12:51:31 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8069.020; Sat, 19 Oct 2024
 12:51:31 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v10 6/8] xfs: Support atomic write for statx
Date: Sat, 19 Oct 2024 12:51:11 +0000
Message-Id: <20241019125113.369994-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241019125113.369994-1-john.g.garry@oracle.com>
References: <20241019125113.369994-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0006.prod.exchangelabs.com (2603:10b6:208:10c::19)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW5PR10MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: b48876ab-7cb0-475b-b417-08dcf03cc141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ht3b4delUbc4ljRXZE83MkZE3SOE1VQautVK5ya4yM97H876wECcWQz42Mav?=
 =?us-ascii?Q?GxsDXJX7aKCaV5tWGkaXIkX7jAFjO1toEBby8TRFGkUgn8naTOfQZua2joDo?=
 =?us-ascii?Q?tvMVCzlenIBm648GZLfSkPFDOK8gN7EGoLd5CJNiQt5XyS9BsRhvEDVu0Pep?=
 =?us-ascii?Q?P7cPHjMhMRG6cmOjMC6NbZ7OeLNvAfqqIBQtkAQnAUV9ylrQ656sjVxZzKwD?=
 =?us-ascii?Q?6poxywHB2fdxmhya6NQ/+46yMa1t/hyb8udg0Re6EUp45hHVrGlThktlLhBr?=
 =?us-ascii?Q?W9h7T0wypT6UqvWDXsREciHEN4RRTZ9VEVIR53gtddNtfNl4nDRBLH27YoIf?=
 =?us-ascii?Q?x+PKuFRqLmhrFA8nzFOWgODakU4LaaU4WzL8aImjW2yzxvV6WDQPvbclC2xG?=
 =?us-ascii?Q?+RtEab6CIX5vpC5tIjnw3+pEwDY8WeH1W/jy7ocPaOmwe3/MAOT+La2nl2yr?=
 =?us-ascii?Q?1xwps7h1vpL7OtPqVMpD3zBTh8QAxJbM9/SW9B3o4plfJ6f3XxXbaerfqhXi?=
 =?us-ascii?Q?HkmBHAFw6pLoyQ/3lXQcDeyCaIZDP+41084uKe7GFvnx2gE5yrPd9+ZB9QDZ?=
 =?us-ascii?Q?w8QFBMohHzuIceI/LvXt825vSIqwaQY7K6N0C468NllVWMJltj91GrfBrZTZ?=
 =?us-ascii?Q?vMcpWgc6BnO9RmJbf58bEga0A9lKuirHnG5j4+0mYuJexpx9uw6pj32lwhqR?=
 =?us-ascii?Q?FlWuS5GMYPLeyaIqmQH0LzH9knFg6M9LhYFA04PCz9kmlRJ/vo9w9S2fBDIU?=
 =?us-ascii?Q?3MlNY2IyFbfpGMDltdvJakt4UdvcyTes6UrnMjV2MkRXpKJLEZdW/hkIFqbG?=
 =?us-ascii?Q?C9zk17UbzqtSB9j75mzaa2u3+OFpUIJVJtsgwyNRVHgi2fvbWXP3zEBteIVZ?=
 =?us-ascii?Q?hB8+PUQVcHw04lrmw4uOCKsNxkY057x2WjDf1f70FBREfoQ9NitT3hildCS8?=
 =?us-ascii?Q?sJabLosya1IlmvV+JN06m9BHLwMrI/HIHvw9Kc9mM5u06l2oH93bkPVmkHU/?=
 =?us-ascii?Q?3G+UDiW5szZiVU5ORtwpYZMzbdXEfkC3GAK5+RPyGMxEWlvmdbiTudnaOe3G?=
 =?us-ascii?Q?4jRCwtaqG+3fxCGloLtOCFe74oUWUe9Zzg4hiU1sQUc1Jso8mQ2FkwtIN+Y8?=
 =?us-ascii?Q?llUXhyStioDmue7WGJ13cFs4O/UzDIw79rLYIrC2UehJf4OVJcLSvlvqbrJ5?=
 =?us-ascii?Q?iETPk3w/XGfUKTIopcSY5yggNqg2CJiCACYfXCKKHeRIyd+Ox5oAspKc4Uho?=
 =?us-ascii?Q?RER5DnPgB8tQdnRp9bgMUj8BF7G60Wq4Z9pxiyhVwUBuU4bSBih2D2RF16md?=
 =?us-ascii?Q?O/9LDgxDEvqNcRQMzZLh4F8p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6CMb2h23+dIOf76LRROJKMvBmFsI0pvaxMyjtzD/aQA30yrUYVYA8W/QBk0R?=
 =?us-ascii?Q?XgLcoNdQ10sLOJyYwE3E+igid2i4I0ZqnhUWApSeHNURhqL2R2qu8jjeI8jb?=
 =?us-ascii?Q?epWvdWy7Qb45Ou1c14VyhbT5cdQ62m5ygAJh1049L6dZUyYLNrlKITP1Cpx4?=
 =?us-ascii?Q?HJ8QgBjh+75G0Dbk6bt07zJW10QV6VvREPKfVv230yiUrOjvVuNMhJ4x8Uy8?=
 =?us-ascii?Q?d6+u9DvLhy6T05J5ncURe/CGQp1D0XvVtce+qIbDKtGkdYpJeCl4jPFknqM+?=
 =?us-ascii?Q?5APJGdgdCeDubnfbkNnzUkO5H/ISydWhDa+u1JcWC3BN/9a9ULrAmX4vqbOc?=
 =?us-ascii?Q?mpL2zgdsqSrwrT6p/YXAMqbUCuNCZjdcNZSxlCaZ1ojZtpKVaxnoakvuVDdf?=
 =?us-ascii?Q?zHh9DAoa4sYEub1NoMhZ7DDrsAeCs6PH0dZ/3kvxFa21DSjQSShpeMa1GAlW?=
 =?us-ascii?Q?UzpjI9o8rqZQ+ZhxqCtQ6OTnQ3P4n/knp1myZlP3T/xC7n+546viDsnA3zS8?=
 =?us-ascii?Q?m68fPwsfSqTlLAUasiIh+TcUVKhO1WWAFxojr15vis74/+j1F60fyeiohvVI?=
 =?us-ascii?Q?VEzHI1kc9VVNmdi+j1PmCGbRty7kqccX9Dp+xfIFrv1o77rK+Ww5n3fePEo0?=
 =?us-ascii?Q?5C4vCS0cB1YMAas/27Y0fmH+B1js90qABnIVyOTWkCf7rcLpws3LITj0JHM4?=
 =?us-ascii?Q?88ANwB3lCO3LbLuX3U8EhJoIxPYp71WDKMEJm9aJUDUnihotrLZXkCc9+iqt?=
 =?us-ascii?Q?q5uQLjUDvLa+MBujZTdvE84cnZ0VYfke4U9I+cGRGUGLaoCCYZTEdYEcA2/a?=
 =?us-ascii?Q?lC9uOQR814kc5Q/upnXG3Avnqdc99SPMU07FlbjrT78Z3La7n2hkUYCsXrRX?=
 =?us-ascii?Q?ESetHVDsEFTIE+642ANDgyjXOpj3vPZLkInP4nEXlvZZcmoJ4/sAcRf46BAl?=
 =?us-ascii?Q?jjvHBCedIj9cmvg2EXsUw20wL1hV+/Xneet70iQmQjhHgfAKxnF0gv0kMBVA?=
 =?us-ascii?Q?i5lBcUnig6l2DN/yb0+8YGNJBZ7BrfN1wocyCoGK17rgGCU74Y7OPXEZewqV?=
 =?us-ascii?Q?7Q5QmLnW6zPv6SLz7oCD1TcKAj6NZXOobz5Je03/01qEQTuMXsOvwt+nrwJJ?=
 =?us-ascii?Q?KsNE/b+7wg+NwgAb+GsJqBx8d8X3cXmMjnmU/NSmI4DM95sRV+p9vrr5l5bp?=
 =?us-ascii?Q?dk1JnXcEa7cnR8DSjz49nF9i4A8RCiPDnirgidykk/ViIOwCAYNCaJRcJ4LI?=
 =?us-ascii?Q?3igGgDM/P8BCJ+GcvZzouaqjQX3FzgOWwlGYrRQv76AEUDD5Wq7Hh3ZBvNco?=
 =?us-ascii?Q?7iho5zhTWauCvbZlVEuKv6s8Qar/osZ8BaJuS6vTdN+6EbmaWs6uDjAFhY0y?=
 =?us-ascii?Q?2+eSR2tHfBRS+4c1JetAL8b41XLcyjgvm30wof+Ydfd87bHD3iOcstueOuYw?=
 =?us-ascii?Q?2PAQWI9IStgtLM67MxYjz12MsJCo8+stJ6PgvoE/+IONm4Ndl3aiQxlpMGV9?=
 =?us-ascii?Q?F/9h5vlxLNfkTjOEGbf7TS2O3N1ZdvRuXPOZ6fXoRq7AmN5OzlLGBtiHMaqQ?=
 =?us-ascii?Q?9Vd+cVHCg6h7rVw3DlR6rItVoJ7Z82JMiE4FdiHyaIdB4VB+QxDvjdJMxR99?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VHRyxXNjqqjrZ3jIP+YTq0SjAn4lDbKtDYzNFBGSCEPGEoELvWRqZy8DjkyVzQ987r1AMs/IlNowVAbIYzv5P+NIYcJCbbLbZlnPQPs/aO6ScQOCiCZH660+PLtPyVkDFksOFaqLFcdMRqR5uxhgkU3QAGzCTqcTJMlgqtiZXaSOCxENtZe646pfjZ5oGGUB3NIeoBm5HL3FPZ6DhgmUU1gImOyu4Yzp7dxy7kh7qY4SiH5hfa+VfJ7lL5exQZXvwfNXBXCb7roxfRW2W0akXr9VpEARFKV7qeC9dLw3w/oTozisl9IOSlaN2+cT+bUzUEOvXggidT2B4qaB+DrSj7fsb2i7q+OeHW1evd5iQ6l1nTwRTx7pHjsDVeqKulapt4MrMv81O6bcT8EkBlkz9g3zyM9RrJ2eXos+qn9ZEfNYR6r5tbfpt5X6k5yprkwm3QI0IZCtZKkOPZKj0+NI71oxgVHfbo0jFQb5KQahOWvUfoDR4A3pwx2+hR4wjik+qXWdsR3Xfdl2jgshiUbKZT056kKi0K7Kl0Ju3gi1dRlDi2PpLWDs9YZztSDE2P8oCtQQQrWlGHH0Tpg5j3PfPTuiOushR9Y/RAI0de3bL88=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48876ab-7cb0-475b-b417-08dcf03cc141
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2024 12:51:31.2023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a186CNtSbXOOoua0KbIAhiNsuE2qzcRbYHd425LnGirGVA0Swvj7YHX/28Ozgn5HG5gBquaZzN8gi1gKcAlXQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5874
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-19_10,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410190094
X-Proofpoint-ORIG-GUID: wq8f9O-z-A2-nEoG_wWz1pOV1Y6klZYm
X-Proofpoint-GUID: wq8f9O-z-A2-nEoG_wWz1pOV1Y6klZYm

Support providing info on atomic write unit min and max for an inode.

For simplicity, currently we limit the min at the FS block size. As for
max, we limit also at FS block size, as there is no current method to
guarantee extent alignment or granularity for regular files.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_buf.c   |  7 +++++++
 fs/xfs/xfs_buf.h   |  4 ++++
 fs/xfs/xfs_inode.h | 15 +++++++++++++++
 fs/xfs/xfs_iops.c  | 22 ++++++++++++++++++++++
 4 files changed, 48 insertions(+)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index aa4dbda7b536..e8196f5778e2 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -2115,6 +2115,13 @@ xfs_alloc_buftarg(
 	btp->bt_daxdev = fs_dax_get_by_bdev(btp->bt_bdev, &btp->bt_dax_part_off,
 					    mp, ops);
 
+	if (bdev_can_atomic_write(btp->bt_bdev)) {
+		btp->bt_bdev_awu_min = bdev_atomic_write_unit_min_bytes(
+						btp->bt_bdev);
+		btp->bt_bdev_awu_max = bdev_atomic_write_unit_max_bytes(
+						btp->bt_bdev);
+	}
+
 	/*
 	 * When allocating the buftargs we have not yet read the super block and
 	 * thus don't know the file system sector size yet.
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index 209a389f2abc..3d56bc7a35cc 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -124,6 +124,10 @@ struct xfs_buftarg {
 	struct percpu_counter	bt_io_count;
 	struct ratelimit_state	bt_ioerror_rl;
 
+	/* Atomic write unit values */
+	unsigned int		bt_bdev_awu_min;
+	unsigned int		bt_bdev_awu_max;
+
 	/* built-in cache, if we're not using the perag one */
 	struct xfs_buf_cache	bt_cache[];
 };
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 97ed912306fd..73009a25a119 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -327,6 +327,21 @@ static inline bool xfs_inode_has_bigrtalloc(struct xfs_inode *ip)
 	(XFS_IS_REALTIME_INODE(ip) ? \
 		(ip)->i_mount->m_rtdev_targp : (ip)->i_mount->m_ddev_targp)
 
+static inline bool
+xfs_inode_can_atomicwrite(
+	struct xfs_inode	*ip)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+
+	if (mp->m_sb.sb_blocksize < target->bt_bdev_awu_min)
+		return false;
+	if (mp->m_sb.sb_blocksize > target->bt_bdev_awu_max)
+		return false;
+
+	return true;
+}
+
 /*
  * In-core inode flags.
  */
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index ee79cf161312..5cd804812efd 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -570,6 +570,20 @@ xfs_stat_blksize(
 	return max_t(uint32_t, PAGE_SIZE, mp->m_sb.sb_blocksize);
 }
 
+static void
+xfs_get_atomic_write_attr(
+	struct xfs_inode	*ip,
+	unsigned int		*unit_min,
+	unsigned int		*unit_max)
+{
+	if (!xfs_inode_can_atomicwrite(ip)) {
+		*unit_min = *unit_max = 0;
+		return;
+	}
+
+	*unit_min = *unit_max = ip->i_mount->m_sb.sb_blocksize;
+}
+
 STATIC int
 xfs_vn_getattr(
 	struct mnt_idmap	*idmap,
@@ -643,6 +657,14 @@ xfs_vn_getattr(
 			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
 			stat->dio_offset_align = bdev_logical_block_size(bdev);
 		}
+		if (request_mask & STATX_WRITE_ATOMIC) {
+			unsigned int	unit_min, unit_max;
+
+			xfs_get_atomic_write_attr(ip, &unit_min,
+					&unit_max);
+			generic_fill_statx_atomic_writes(stat,
+					unit_min, unit_max);
+		}
 		fallthrough;
 	default:
 		stat->blksize = xfs_stat_blksize(ip);
-- 
2.31.1


