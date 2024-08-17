Return-Path: <linux-fsdevel+bounces-26192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C14955705
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 11:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88BB42830CF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 09:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C773514A4FB;
	Sat, 17 Aug 2024 09:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nEqMfpP3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m/B9mY3E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991C314659D;
	Sat, 17 Aug 2024 09:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723888243; cv=fail; b=X2MEzHu2CjaN+XL6Ib876WceXPc/JvZ4JxjOPPxpo32Z52QlLTp1ZLMejzNAVilKVEy+s3vDi5fDff6aWrCyKQm3yOxYS/Z6pc4vr+EvGB0MP8A70RRLTlNh2wZ0hdS1JRQd7JJkXtdKx11btXJfuOyEOfE9Eizq8qPNjIZDJik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723888243; c=relaxed/simple;
	bh=/PmvLwg2gc5mEPSuPtBUXqggXavSC5VczM11cmaj3ek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YN3Z/nSJ7Lyu8E4iWlcu+gc4+aNdQOIDqWbXp2q5Pl7ua/TnP4tJMIdjpl9JDzfjmf6jqzBgZt0/p+Ubt1Mmlp8FW9VekMeZtPMxcIhFtuMs2K/8x23SSqaPx02r8hsUI2X/cHQv2VWzYJ3Kj18gHEZTVRgp6+xsDz418VBRcqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nEqMfpP3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m/B9mY3E; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47H8VcB8020383;
	Sat, 17 Aug 2024 09:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=my3x/GJey/9khfYN7B75qEa1wmhc9epLDfdvaLxnatw=; b=
	nEqMfpP3foAMwpqu1J2RnMIYA3ueO0zCZLM6uNHc2LIKKTqKs6jDBjbcoe18Cxkf
	H5OqB9qP+NkX3vy4CK5fRM1hmaA5hQzB9cyFeTwFg052dBYranGsVu6UQPUrAGh6
	sG+J1UEjUUoFmsuMu2uThWvhudSeyN2BBpgJOnvaTXHf2YmVCqmpEU0dUqZG5P1I
	07z5wEYGf003wZGd1rOaOYOQpIAGFpnf2trJ19I8t1xRpD66I5IKBtHGsa9g/G+u
	csWkESOOdxnIQqn1IsqmoXiMGPaZigHNZeXM0ZZ1sfZ69DLuzPZA2fSR59s4Kjz6
	i3CyALREDf1WsZZOBbs54Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m3hg7e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Aug 2024 09:48:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47H811UM031437;
	Sat, 17 Aug 2024 09:48:28 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 412ja5y121-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Aug 2024 09:48:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHtw3BLXImS789MYqzB7OR02DhqljHq5tuU3Vr39h6OKMucgmoL1mMq6+Cqca86hhdxqy+tXE8nm2c4WJkN4XZKJF81AJJQ1NbZxsgNh5JIdWPb2P3bbvDGmcUUmCvOVSOHnhoHBxWwvlOAhaAeIySFoOiFqEb5ny2YJrOsfdhWdA9iwa+7WZJ4672nkg38Tx9g9PwWltDjWSVlz4gVGlGqFWJtKJbAOaLjDCasFRhMroDA9ub36i1vguRu1gxBveaaur/5+fzxoUIpWd/3qN2PDZ1j/HLmaTDciMGOeia2nYyYTVex3kSTUlLredI1SspjruY3cL5hZBZXP999kFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=my3x/GJey/9khfYN7B75qEa1wmhc9epLDfdvaLxnatw=;
 b=ZnmoYUaWDZnU10GOVsrzo9eoITlTK+Djvl1Kn70DAdnR0G2Axb5JuTfYwtkRuy3fMLJu3xulLnjH/BzkjGETDel19n6DouNS9WlAYNG6Bi2oCt5yV17qMXLs5RgwLhzwuoGo663yMHxkQNpwXNQK3ONbfGBg6Aq5pl0k+UORHvjkkUuEJWCMnAfNShhxBGzUUTEg/nolgvBNyU1zYIlw8bxw3gwkJN11QbKuFq52V/IR9jngUAk4++jqSHwhtktN+bY2wFAp0+vCYX1qSc8z9OeQnsuAqO9CUfMM6yrVhmpEbyMT1oI1EBB2sQJrCjqpFsRwr5cuOyZs6tpTpX7sbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=my3x/GJey/9khfYN7B75qEa1wmhc9epLDfdvaLxnatw=;
 b=m/B9mY3Ei7nZj+/zeSyF7JO2tsu9Ou1CHx3q+IHmAmOJxnzUaeee4Ln5sKEK3m92736JWNQH5/tO44rujBysSoVXWyvfcKLvMBd8RMCJmmwMfrv4rNAwLfTj8eNxEePPkwTGzGBGv8SeNywfKbXCCT+C+ubOFRClwYIsaKXjasY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4758.namprd10.prod.outlook.com (2603:10b6:510:3c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Sat, 17 Aug
 2024 09:48:27 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7897.009; Sat, 17 Aug 2024
 09:48:27 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, chandan.babu@oracle.com,
        dchinner@redhat.com, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        kbusch@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 7/7] xfs: Support setting FMODE_CAN_ATOMIC_WRITE
Date: Sat, 17 Aug 2024 09:48:00 +0000
Message-Id: <20240817094800.776408-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240817094800.776408-1-john.g.garry@oracle.com>
References: <20240817094800.776408-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:208:fc::42) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4758:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a46481-f53d-4c08-913d-08dcbea1be1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8s/RvbBrNDBlYTx0X+XznPBuaKtRwk+4EneG7rmcgkBbf8XWOg8pIM27/fHj?=
 =?us-ascii?Q?ijLM1AnEmP5NIi8e/1TO97jOZHS+50vsMdA0pbVcxngf/rhzGsLahkJa+Jrg?=
 =?us-ascii?Q?a0RKk8uEpvRrflG2dgAG0hG5QwZdaj05BDu8cZoBW8Cwy/yStFRDKSYrZBF5?=
 =?us-ascii?Q?SmyLb4hh9e2OKj7xB3PJcMpfoBU+kQj/mS7VjJguzeFRO11hfAhITXVpich1?=
 =?us-ascii?Q?7MZRLvByv+w9dOWHg3Two6MEy7fjxfN3rR3s9FQtEVqrkFFlPFexLD6vogjm?=
 =?us-ascii?Q?uHnCq5Amqt9znl5ZnEtyr+9s42flkjq2I9OocgJ3Lcr3D0S8uH+NPPJy2bHt?=
 =?us-ascii?Q?hXnrv3AtR3XKN29Lc4SQAjKaiz8BeZUXP8NQhLH01i18vmqup08ONJyYCmV0?=
 =?us-ascii?Q?9Z4PSZpJ/PQgGATHd7Y/auubQc6ZNybPc1wDppUCzX/uInoQP4H+CqXP5dPB?=
 =?us-ascii?Q?h9p34rSHvEP8GAWNEtB/2kc8pF44LNcQl9hhaYO3BWZ27kSC17sumJOUcvHi?=
 =?us-ascii?Q?iHhuZx+rd6P6pCH0OioPB48fsdXPPdT7gg0TEthsUpXBpNjkyqpN3YQx92N7?=
 =?us-ascii?Q?AohsH0+898SJ7VqROcIb09Xj9R4G1mR1KccYR0/0g/25LJs5ZHxD0CeS+719?=
 =?us-ascii?Q?CvpeaPKtH6iZMrAKGcEeyIotbaRLWphiZJenrev7HbwajOaeU2W4YNZ+j5OY?=
 =?us-ascii?Q?l6FUtqfSXNfySrX01l/9JGL25Cbq2app1OU8TwdRgJMq5GdRGG918x25TZmt?=
 =?us-ascii?Q?KYw99TswMSqLM0bL8vfXfYlwnasfAnW4sR1RKNlrfkLqkWYLOVHnArcdAJq6?=
 =?us-ascii?Q?zE8nxjSZC6NJr9n1Y9wPdS6WiIwf56iqljtQq1Vdkhg2PksTA3puYkgn1hu2?=
 =?us-ascii?Q?twiqzAuYG+e+BKHBHyqOvw7wJqgnsbyjY51HwLAdzb3jwih7pvlAezNqRoqY?=
 =?us-ascii?Q?FEvjUKDzWAHzKMbYwkmgBENcI7bpz4nTN9qvl+K1ZKE4di7QhucTVVWb1dV8?=
 =?us-ascii?Q?tmEi3DKBIwJ3Y0e40R2e6ZIRSnz/s9d6A1bwxtH8B+b8b8vdoBSxNChzsuhP?=
 =?us-ascii?Q?W43qWVS/neQHDGEpmu4iVvTUPREqjIAXUcCGtjYzfK6IoX7hzMQ3/oSeHnXM?=
 =?us-ascii?Q?bNSSO2MkQDzge1o499K7pS8JqrDxfxEdSWjdL6pK4XlslnLtkj7B3kmdcQF1?=
 =?us-ascii?Q?PIRp+4h/ZICHFOdHB+Y7cCxGSPYP3tEyM0kO5PPvm6qeOcMje+Wo4lF/snZG?=
 =?us-ascii?Q?Wd6N4ETy2zKKvI9GloIjiBo8A6A1HG3x+mxHfw7/ea0wsFHPkD5pVGwOLSl7?=
 =?us-ascii?Q?qRy4KGWkN/ZThviTLyGgUM2ZAz4EmlULERZ2o3Y5F1I3Pg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y4+7kNX0+BH9GwLmjvrOm4FK/b+6vClrS7ViPEpxeUduNbbz+hwAVfi/69wO?=
 =?us-ascii?Q?dCSkToINptZhEZq5ZYhn9LSahkDlp4UD0B9lL8ildG7Tqy32VQL9/PiknXMj?=
 =?us-ascii?Q?h0teaHOOdGleHOIguuvA6/Sq+dPnh6T1W768341CrR4z9xJJ8EkdMVkEa34x?=
 =?us-ascii?Q?SBEQ/UQyfBUDXClvauW689/LmEZxryiFxfZq1YonMUboxaR5oZmSau0TeEFI?=
 =?us-ascii?Q?/znsf8nMe3RhCDkDX0I9cWgWgYnPeVJtitjMR3L2st4TlASCAyT/80TzR8XV?=
 =?us-ascii?Q?alzPUQhyAIn4/OgZrN6twHEXoimkA+oIAIDRV+x1qoDF9VCvKR6SqBxG3rMd?=
 =?us-ascii?Q?gq0auVTFKPe9J5NNPFfn1hW5qYOpDoT8BtqiVWXSh3OI/JRSrU8SKbO7sbBi?=
 =?us-ascii?Q?douhpCf17Vhp64SO9XbL0/YTUa75w2gxfarNexgJsPShjFjNpz1aoYDmrZyP?=
 =?us-ascii?Q?D2diMu1F+fuitc3YbHA6btt2IeyLBMloPVBSfABtGqitIu4BJ1LF/MQ0XahA?=
 =?us-ascii?Q?iAv4siN19ZM63UmCVRJ7yrUD8EMIsWXaLaLR4WRoLipw8+8niz4MrkIAsPVH?=
 =?us-ascii?Q?gZiZ7C0/96Rer5crbjEwp8I5DfTP6Rh+JLrdALVA3uQao1h6EoHbbCQniwlu?=
 =?us-ascii?Q?mQXQc5yABwRSdfGuJCFm3WYIqEpz6bKy/FaRP7wNP9U1jhK0V4JcoSykXaNV?=
 =?us-ascii?Q?V7O8flfkhyRLGA92lUlGWFlexLToVSvrMkSZ/I5Llkwu4FLvE/1FR8OEu+K1?=
 =?us-ascii?Q?PYgOcKmVx9IBjT/Efm5Yl35MfjlBh2mlWgcYBV+p3Lp9rtZ7j8oBCPPR9dj+?=
 =?us-ascii?Q?uSBaGxFl0ozrxQM98AcUwx1X2Xts2WDqQlTID+XJM2Km1gxm9ByjNAB2Wb0V?=
 =?us-ascii?Q?FxGJAL7DNfe0Ft4PQVF5XZXftkLWVfCLTG6PSADrsn5VYGztm0zU2ZVHQS6B?=
 =?us-ascii?Q?J6M9F7yKbQhKO2UiU3nhs1ISJMp2pnLk+eZiWZqCou73YLJvsjQ0eVsO+quZ?=
 =?us-ascii?Q?4jicCLzK9F4XR/0VGBeK7nstjoOZLEcNirenCtl6VUWIi1UpeEmXaXaQ+ba1?=
 =?us-ascii?Q?MxZo7+pGDJYcpgKQwiSOEh0pARIgKKE+QT7D1wALfMzP62mjwFX0Fue22TMS?=
 =?us-ascii?Q?dTzC1zF3Jwm+V/U/99UGaE3S6pw4JvhTTw8ZmOYPczl96RJGEu5SE5Gy2miK?=
 =?us-ascii?Q?4zbT7nApIR+XyyeAsc+OS5fx3vi6Fy34x3AL2pOdsoqbjPvr3zzl7egAHGj6?=
 =?us-ascii?Q?yRc/YLtMhLjR9RbkghAMAPhFrvzBa8VK7emKCeoClZ+UZrZ+3lFkG2JPTqXC?=
 =?us-ascii?Q?yseYkhFina0sKpUviP+IKLezbBXAGasg6XdRNVHFrmbBKdy/WcnMBHNE3Q/F?=
 =?us-ascii?Q?d7WW2sGa8zC7RfNRuOSNb4LVCNPTS+P56xPSmgm39b0x3NHmnotjMrzkhziF?=
 =?us-ascii?Q?OC1jYUyAQgv7hfHnLOl6HPw5Df5h/l320FCzHyffge2NxwG/pTQdbn94AtYR?=
 =?us-ascii?Q?SlHcK2+h5VBE+q15CSDr/jzEWGIl1BhAaX/KM0ZxkhkqVwFqt4g5qI6CJv5I?=
 =?us-ascii?Q?zDCtWv51B4lOE0M5Z1IjiDhVMgoPAKFvE+RRyHR/CPxyzTMTgE8EAYyUkvOX?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8fBm9KbERiE9RP+4mR01ff/1zc1cjanTKsstE7I9XZrMFf1Hk4oB61xq5Zq0mdmD/0fuJBwBdhBfbyvg0o2HwPscQcsEur9doFap1i2zUPg118hb58pomUiiYBKfJjhZdYNAJU0t3TCBLTbAyUyIYoSM0Hj2fYaQ+ZLwVgt1RQ8mW/3V7n0z4INgWtCtUm76jCE325NUbRc7zSpQrekE8nHQE3OzQqs7txbEDV0n6y3cPBC4S4B2fNQCxSFx8GUsuKhzoRQ7NP9go+qTkkbMlQXLipM8mw3BLCeDzaJfytiEnu4jrOxDk7qPWMcAPbCJhZNw13c9cbb1FDHqRp9Ro6EjG2DABRqjMAZcYKmDpE5SLx0JzbHOWgpUzWqoXjpqhZ9aBIrhKyzHKK1iyXliGw6PqhA3O6GHOOXZ4aMLj9TIHOTDKazB8GZ9rUc85dSt/YygFB6VHMePtiRVJzzjofRcoh3XOpOFnhKwpVQwm4alYpNDd4H4fFmHb/d7Lc8YQZIUjGRD0u39IR4mvhAWdMR8iuayIvlcnIxIKSYWcWPBCj7677lc67MGA28wPPEu5HT8R9nfQwkSmQ+i9vgLb2ZBwOXAekqH67fJavFLsZ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a46481-f53d-4c08-913d-08dcbea1be1d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2024 09:48:27.0230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUVpcjWu0PCnAXKeL/2Qf2qMFA6C7tS0SvqFhR3HHTpr0kbPb0GRjEcJHnRobDghu7bukYyvGXoG71uw1rFk/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-17_04,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408170068
X-Proofpoint-ORIG-GUID: E2AKdCACKgMYEiU_nzgf8lqTgA7IpjbG
X-Proofpoint-GUID: E2AKdCACKgMYEiU_nzgf8lqTgA7IpjbG

For when an inode is enabled for atomic writes, set FMODE_CAN_ATOMIC_WRITE
flag. Only direct IO is currently supported, so check for that also.

We rely on the block layer to reject atomic writes which exceed the bdev
request_queue limits, so don't bother checking any such thing here.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 9b6530a4eb4a..3489d478809e 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1149,6 +1149,18 @@ xfs_file_remap_range(
 	return remapped > 0 ? remapped : ret;
 }
 
+static bool xfs_file_open_can_atomicwrite(
+	struct inode		*inode,
+	struct file		*file)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+
+	if (!(file->f_flags & O_DIRECT))
+		return false;
+
+	return xfs_inode_has_atomicwrites(ip);
+}
+
 STATIC int
 xfs_file_open(
 	struct inode	*inode,
@@ -1157,6 +1169,8 @@ xfs_file_open(
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
+	if (xfs_file_open_can_atomicwrite(inode, file))
+		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 	return generic_file_open(inode, file);
 }
 
-- 
2.31.1


