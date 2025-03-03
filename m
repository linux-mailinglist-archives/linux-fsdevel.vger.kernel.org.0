Return-Path: <linux-fsdevel+bounces-42976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CE6A4C988
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 18:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624CB189D570
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81679253320;
	Mon,  3 Mar 2025 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aJXM19R4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YXTrzSpt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44889251796;
	Mon,  3 Mar 2025 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021912; cv=fail; b=gYni8Y+1m3FJ4hGe3Kjc5U80SsLVJFy4D2t0diAszmzOk8/8rv9spx6h7vJZCOv/8hQhXPTtEMDE4otajGanyBkRM7ybB/zgCYp5ZtSMzOd9UXdQkW/SGz4NBjqUxwjy2YKHceAUBJwZdUlNZaIgc4HB773IGnXr4Rad0aJx6oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021912; c=relaxed/simple;
	bh=VlUY4CDN4xufGk7vOQwqnk7dvkz9kIj8viZEtYNryBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i27GxMLZw1zKtyMWA8ACuAkt7t7Ec8EPdrhWMQ/6NktYDeGzwpdZSpalImnMV8vg+B+wdkHBhy0MTVsI02SVfAzBRpwB6ZF/naKQ98gnwgKzI/qcdvDX0bULGPlo0r83C6lK8SWllLQd9azk8sXE3A9byHOlATW1l7bNh1cjiEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aJXM19R4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YXTrzSpt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523GJAv8032523;
	Mon, 3 Mar 2025 17:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lfavFTHv6R7P1PF29aGilDIay1BfPpy3fsI5jMc6m2A=; b=
	aJXM19R4TvT+TD2+/Gm/i20sIRW1EIAkulDNf5YmLwzlKI1vQzE0e3aPoTha4Orn
	QAOyiVxRTfI+yx5VgrhqVFLKMQa/bJmXj/NyAc2ulca9KAehedABdenP8YAT/CFX
	AhE12T1cvYdFEG9Aj8l/EUnmfympNNPxLvLSRPPIQdW9hNkrWRprBIi451LNvqUr
	/d6IhAPgnZzF7F5W/18D2JTdt4S5fP6TnB3k2PG9cEQyv0RAHpAGTsfxkxSZGsIv
	g89s/3dxPIP/HJPu3OH0ObTUoxPICuqBoD3jidEKmnLBF9ZRr2OTTHWyjL8DU8bg
	PwS/Qksq097evND7IoeN0A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u81u5ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:11:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523FqXuj021934;
	Mon, 3 Mar 2025 17:11:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rwtrc29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:11:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwfE3z9rnvqwDZEvrLCD4v6V8waXMCP3USwWu4AzYr1sXujmf7rkJMMbMhrclrBvk8GXsWQHdF54Jc2wfVZCd6+JvxcCCuc3n6vGMATP1dT9SqaIdwjStVLMdpuVgi5ySDk1YBeymvpaSJzsXukLYL5u1bQZVUjTNPUdHi4CCBk+3W0qsugv9AM71thzU/z2mg+Jl2LzwmpvbFy0qOy9qZCMBT+6NgfLx6zMxCDmThPOomcOn/75NaoGf3jQw7jQntq9oTGT8uPQsYViqkAUgA6Y+i9cyDVX561pYMHAZqhQHer9m+tmFNo6jT7qLGXR9Q+6uMEtpRa3mRQ2mUJKOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfavFTHv6R7P1PF29aGilDIay1BfPpy3fsI5jMc6m2A=;
 b=RhQMoM5U5m39xzlEa3zskb7q43Yk7qNt9ZssatGMnd0iKe4MuSmFl2tEaRXJiirCrfi+Dm1Mf11JkRM8OuL8KxaJCmilFCZOF7PZToVwSYK2r2+F2d0VUotgpwibaiDXjkFkAlp06mG1/7llaLwWzGYEFi7Ioy9NTQuE9G2/ojgZNQ+gefj7ThrIntep97qSAAz/thu2sT/hQX10tv3uVfCM/8WEyteHmPHgPGa+iy/EPJdXSeJFjUJQzNahs5LAvtFiBNBF+T+TgAtVmMKRxDjpTEjgDKtF85VXH37c50sLC/oCB1VSRJDi3LPsdiBPbjrWK0xvjfX1lESCwikaiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfavFTHv6R7P1PF29aGilDIay1BfPpy3fsI5jMc6m2A=;
 b=YXTrzSptlLs2xVucxyAWDmMe28oTyecSkreFU29CwQ5wt0ZdujfF4t3vnc0AEQKZWLKyFRbZLGVy8xNNL1hR/PhMf5FmYaMZD3cqG6KOk5iX4ihvz01VGhU3uuzzynfW83e3H6IQpLpsYziRPKUOXThnHClKUQSFmXYbkdlVnQQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4696.namprd10.prod.outlook.com (2603:10b6:510:3d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 3 Mar
 2025 17:11:38 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8489.028; Mon, 3 Mar 2025
 17:11:38 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 03/12] xfs: Switch atomic write size check in xfs_file_write_iter()
Date: Mon,  3 Mar 2025 17:11:11 +0000
Message-Id: <20250303171120.2837067-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250303171120.2837067-1-john.g.garry@oracle.com>
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0310.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::34) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4696:EE_
X-MS-Office365-Filtering-Correlation-Id: 37e166db-03fa-49af-8ffa-08dd5a7675b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Prd87NasFw7Uvo08zvRxQlkLKJOKkIF+qtSiqL5uif/xME5UOvtHL+L9wwQK?=
 =?us-ascii?Q?egO9+c2dJVMf15QCJisQGfewz9NXTAg+8GX8POZta4CQlsG+ZGpDW4O+BeL2?=
 =?us-ascii?Q?9P5QXaNU95fJQo8GN1QQN3qEKp4E8dbYf4bEEKQfapcmBF93gS+HGTrOjN35?=
 =?us-ascii?Q?hhEL/53aoai5hE5khVUkE5d9js0Wb9tgSDSljDXIxcCdEPtTFD8d44+cYwZr?=
 =?us-ascii?Q?4cm/t/IDiyYZYPAXR+YP29gxB8tm5eFJAO1e8NSdeOV3HG0kxPS4ZgMNprXa?=
 =?us-ascii?Q?SKX9NqA2ayuNlN2oHv6EGUsPhDNBSfcagHKP2hrqfPZaN36vc2FefXNTK2uy?=
 =?us-ascii?Q?wKbrtC+GftYUHs2qY5VEyzEimdZov5SOgKqtESKOggg6vyVAGgLK/iQv0oNd?=
 =?us-ascii?Q?xiOyzEWCxv/5UvbjLyErKXuPZ2eZoWIQiIC2q19PNJ6loGgwWUT0SRtOUD33?=
 =?us-ascii?Q?v6CCiakcsmVnLp7DLmQ1dgnKMz+YsVENYFog8sTA+TUll/i7KMGgvqc31cbG?=
 =?us-ascii?Q?t452Xk+yEGzFzhiHMt7+b1KtmLyY7WLm/K9oSEacU56hzWnqX6RxS6RZk4z6?=
 =?us-ascii?Q?b4flqmvOvY9o0R+XYCriZEP5yv43F8iQbkmhHUm9qZM2a+h6pUh9f0XFligQ?=
 =?us-ascii?Q?KFKUzGyteGkuPSfNa8YgkYjNVLrQnvHTi3T0rRfSR1Y//YkJHjQt00DXphqQ?=
 =?us-ascii?Q?f+ElfOGngjuF9VfTF+jUdVOJVRrRilteRRQlr6fr8VtGNKCNWeAyWNjrWSJT?=
 =?us-ascii?Q?0qcyhS3zNhAddApSstnXqiFr5ebomrXchovCIWElX41wWXP0nM+zst4Nvn67?=
 =?us-ascii?Q?F4aHf5VKc20AylPrsFDyEvOHTAM827aekBJkv0fZWit5/D78KSFAk1HIVXl3?=
 =?us-ascii?Q?n8BLsHWnPcfOza/q+s+tMheLf9uqyr2IyH1zCGs/OB1BdwLcQ535Aiu7+oI7?=
 =?us-ascii?Q?72eoaPDlKozsI6nSzus7psZBouesMOf6L0TNOSl92BfzoRbOGtqSo7cn72FH?=
 =?us-ascii?Q?IJ3qEspT0ajHa7EnQcus2avbxPLjLBk1neDmkDCgGffdAk+XUKn7ivQ0oUdH?=
 =?us-ascii?Q?WYHHdE7JwkjRFSwDtBTK1DDNL5vGSO7R94GwAvuMGnI5urJYMXhmmq0k3Wuo?=
 =?us-ascii?Q?eE3MG0aB4LWshwA+VfEoIcqB0po/e8jWbnzrurdYYMSzBsckHfdkeHLVj7GB?=
 =?us-ascii?Q?wlaAtAIknyh6DMTzSaYyMsLC8eL7s1e+L76I4szIRuzo4kM18TILdV9PanJ8?=
 =?us-ascii?Q?KgMwAG65aIVHKcaoi6a/WPyPyr2OtULreLpvdvCiDkd3I13e6RGQPsrOeyga?=
 =?us-ascii?Q?9K1q4RMej+SHFa2FfERD/FwkcSbeM5Uot0zrR278P6yv+1JhlTw6HWA22EtQ?=
 =?us-ascii?Q?7VZcuI9jI4r+Pmf6S+Il2/34f8cJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HvX8wCwJ4uuBiOaLZrrsiA+ZLVlzwNqPUkQFCbMlQR8NQ7e10oBEnnY12e2G?=
 =?us-ascii?Q?IhFy8DM8AAxZVR3miGjfNtwZb20pCuSUTgvUyTbeDUcLpn3KQG/VWBdHA1qe?=
 =?us-ascii?Q?sMuERbFQj4fu92QIfUgL2URyeSTaaFZj74QmMnn9iW+nLov7ZW3yTtxrhZBa?=
 =?us-ascii?Q?Y4rF1/hQEEvUqAhpBiNT/ap9sz4xBGdVl8qQjNUARdL5qu+b0LhrwHu0wD3x?=
 =?us-ascii?Q?xzgG+yXoxV6BorHbev2rQxq1IhQ2X6BYW/+o1qtIdLxV+rk7eVQ0x0I6PQrK?=
 =?us-ascii?Q?olHjH6kN9eeuHJfcpQk5iG3lBR81iKHMeIxnZ+lICkrYDCKi3IvscmihpMtJ?=
 =?us-ascii?Q?DwfMzn++hj6NyVKuLhVsGXP1MeXYd/2vUPq/wfI2x5UhigJ7KY2Xv32ZHiOn?=
 =?us-ascii?Q?/hzhhcXW5S4eRI7DJNhYRj99YBfqRoP27pPqCmUJRaCFcDwybMdQf+6ytFI5?=
 =?us-ascii?Q?sXvE4fv/8Gg3h5nBI6Dhkp67Zk1cVfFCeYz37+PIWbtz9tKjSP4VcgXIg+a/?=
 =?us-ascii?Q?ugynjW1xV73p91DYAjhfZKbPKcqqDfQ7mYvJQIqv5ZKQ5wwfktO0b4w38byN?=
 =?us-ascii?Q?31PJ5kWc+QUSubjxlXNH89mf3rxML0NlkqjHQReXLr3mlmffEQwwAL4paBpR?=
 =?us-ascii?Q?RyVxk/0HM0rfcSUw6FqPxfpSmza2czTLbT2uz7tdMcO15NaXnkCil839R5U0?=
 =?us-ascii?Q?YbmNYYEg0pR1PQpc9RBGawFl8L4FqrbtNZEbtr1pjAArSVX43PFsm27N7dNE?=
 =?us-ascii?Q?Mdc56lxDwPr0MzcBUji/l5alerSEa4i9Gi3Tkn6qg81gDewcpJc3mQiFzoHL?=
 =?us-ascii?Q?Z8cFdi2MMibc9Dp4lAeiXcf0fnpaqbYt4zqbb+d76iNDDWmUZICke1qbrDOh?=
 =?us-ascii?Q?Y87TAqhl9bXJ3OVdU2ZcNiLiU9U/dxsJRgWoiQfdUFmYXuCMdnRdVYkvb0Yt?=
 =?us-ascii?Q?b3b4plpUceQb2gbf6TuKmLiP5KOrFVA8rNuEwsP+LIRgBPW+nPcLTTPC1/YU?=
 =?us-ascii?Q?VcwWxVYgw8tbmuvif9LzN48SJ/zHXtfx+4tu2uFbqcNm6jxGUl41J9I65BpK?=
 =?us-ascii?Q?ErKxDfRdeDfjojKwFAK7trpOQe4J+mhUSFlF6IBWA0SdLbgFzyavmti43Mlk?=
 =?us-ascii?Q?N24qq1DXFxYgUDqdLRm3kCJ2ACAHIEy9u8GLxCJ6AbZImlHUKa1DnYAms2mL?=
 =?us-ascii?Q?q1XexNLnr3i6/IC9ANprTUyleW86A3igADhH8nMuPwp8tcCdBvWUKENCwBC7?=
 =?us-ascii?Q?DBTEZ7fKL/733P4X8D3zcLrTxQSD0nNHlH253j45FWrEF5ojr/Q7eP5+hxsD?=
 =?us-ascii?Q?QoARGArCMaXYcd0QZTMGi5wImFcZwiPsJpvI3UuJ26ADpjZYkD5IHCNxapqh?=
 =?us-ascii?Q?OIX6rXuWJtaRb8bgiuwwF2dpnde4HukFgHq845cvb12fo6qAXyykRPQzmOcf?=
 =?us-ascii?Q?8tuXZapOrRQjtHVACloIM1VY2eNB7K80pJu+AkNz+KARTO4PC0oB+G8VaM7v?=
 =?us-ascii?Q?SzBs8u7jPyMuQ5EGcfjFi1xv4JYfKP3FZee2qHgCZzLoNH2WcZsgLZykE1s9?=
 =?us-ascii?Q?LAUdHGBUCOd9UDYyMxg43PmX6tG0SvYpzN+1BCKPyxOe2/bEQE6nFqry1HKl?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V8aluTMw4BIem4ATHzP1wzg6xT5teFEBgHHR650OITxAihUYm/G6qzgq5i3Ig7WIf5G2kz0+NOTX4JMqdvRBb7quRDVW6Lg00d4bEuCL65CkZOx+0ODaTqMDZAK/GUCQSSuFpHNWNgW0SQE+zclOkKlHnf/1oauJzn8lgZNuQseNs/MAuOLgYkp/4IQG+b+8Q794NR8lMPOt/QnDL1TgDzjct8BHD7FsaYWeae1xXQhoRrHf3dkVC/zNFRsitCIF8mpMsColecEb7v3xtGMbw7/+Dst0CIB87jJqqfrXUdk0hq5Bj+Pmeiq2rTARHsL+OP6N8GYfDgwCNBO1XdzeUEw3ywBTM0ygymhKE6WZE5/iphSvhQGL1ndc9rMiyPRMz4OsSktSX1c7bzzJHqNtQ0CgVmwAL7GWCP1KHcvBTy2hrhntCI0ztb67onXYM5A2qCZitVFBeBLOPsY9JlWOsIzDeLICkC0KBmSucBHM8v9kzS4drTWL1GnCWkMkRAbEQO8XIB/asUE7nWSLR867sx2z9nasqzCfJFsVpxvu3mf+TEMGJ03hxfc8Q5tHgD1dJN0B8aRxktnjdFJszkvvM9uYKZZl3f8G+kJltWea2RQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e166db-03fa-49af-8ffa-08dd5a7675b8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:11:38.6102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSA5tsPWlOq6RX3wVfg8YLt8ykNWfqwBvRfc0EZvHuFRGFeKIGoz9aMb2zotnhGWYt+3PoDFcy5EDazT+A49Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_08,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503030131
X-Proofpoint-GUID: k5Y9e3COGPFt3TG_zYckCUWUVNOc_cCw
X-Proofpoint-ORIG-GUID: k5Y9e3COGPFt3TG_zYckCUWUVNOc_cCw

Currently the size of atomic write allowed is fixed at the blocksize.

To start to lift this restriction, refactor xfs_get_atomic_write_attr()
to into a helper - xfs_report_atomic_write() - and use that helper to
find the per-inode atomic write limits and check according to that.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 12 +++++-------
 fs/xfs/xfs_iops.c | 20 +++++++++++++++++---
 fs/xfs/xfs_iops.h |  2 ++
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index a81c3e943f20..51b4a43d15f3 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -853,14 +853,12 @@ xfs_file_write_iter(
 		return xfs_file_dax_write(iocb, from);
 
 	if (iocb->ki_flags & IOCB_ATOMIC) {
-		/*
-		 * Currently only atomic writing of a single FS block is
-		 * supported. It would be possible to atomic write smaller than
-		 * a FS block, but there is no requirement to support this.
-		 * Note that iomap also does not support this yet.
-		 */
-		if (ocount != ip->i_mount->m_sb.sb_blocksize)
+		unsigned int	unit_min, unit_max;
+
+		xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
+		if (ocount < unit_min || ocount > unit_max)
 			return -EINVAL;
+
 		ret = generic_atomic_write_valid(iocb, from);
 		if (ret)
 			return ret;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 40289fe6f5b2..ea79fb246e33 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -600,15 +600,29 @@ xfs_report_dioalign(
 		stat->dio_offset_align = stat->dio_read_offset_align;
 }
 
+void
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
 static void
 xfs_report_atomic_write(
 	struct xfs_inode	*ip,
 	struct kstat		*stat)
 {
-	unsigned int		unit_min = 0, unit_max = 0;
+	unsigned int		unit_min, unit_max;
+
+	xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
 
-	if (xfs_inode_can_atomicwrite(ip))
-		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
 	generic_fill_statx_atomic_writes(stat, unit_min, unit_max);
 }
 
diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
index 3c1a2605ffd2..d95a543f3ab0 100644
--- a/fs/xfs/xfs_iops.h
+++ b/fs/xfs/xfs_iops.h
@@ -19,5 +19,7 @@ int xfs_inode_init_security(struct inode *inode, struct inode *dir,
 extern void xfs_setup_inode(struct xfs_inode *ip);
 extern void xfs_setup_iops(struct xfs_inode *ip);
 extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
+void xfs_get_atomic_write_attr(struct xfs_inode *ip,
+		unsigned int *unit_min, unsigned int *unit_max);
 
 #endif /* __XFS_IOPS_H__ */
-- 
2.31.1


