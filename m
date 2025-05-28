Return-Path: <linux-fsdevel+bounces-49983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FD6AC6D3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 17:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 391E37ACF3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 15:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F8528C2C7;
	Wed, 28 May 2025 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rpp1gKMI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RmbeoExa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27B21CF96;
	Wed, 28 May 2025 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748447483; cv=fail; b=axqNkqHSBKndOhrYdgq98E9SS+TNDvpam03ogA6idR68JzA1sMhilLJBI/WeZTYkJXpWv9iw0eivc2Y9YwEqXwfIsqYqOEqfR87gTCoYsjKyrl/3xVi0B0tPuztWJTXfE+Fc52tbArJydjcW6z93stbby5OoaooBD0Fj/LB6EKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748447483; c=relaxed/simple;
	bh=xabMDPjG8Y08S6Ph/P3TC/CWKv7pjsjv+/sQylIeZSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pb8Azd464rArAOUHbQL0asfNirrsa4CKsRmtTn4TwUD9Usuqmrxr2Az2H4uIfzWn1AsrIritnW1CxXZJvb01gDrAcAeydDkjiF1DBwRiWWydjOIw11LSWL61HjbE+ZpPBkkD/vNGX1mxFI+VycjFXo/qS17EK0cfyc0OBJDbLzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rpp1gKMI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RmbeoExa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SFoC56024014;
	Wed, 28 May 2025 15:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=l97piMWMNHok4IXASz
	7nrzhbnl2ad5mUccfm+cEd330=; b=rpp1gKMI2Wl54WySLWYQaWqn61d4HXKN3q
	lmGBg5KaJyOReGAJuKPijcn/wtY46A5NfwDTnzPoHIlHG2bnBzUZQ2lpZLTGy7QP
	QvQvSk+Sg4JJqAAWTU5vMNKV50+fbnEYC4bWg8Nzk6G/k+yBILOZkw+hemsxFTkm
	t91e4LAE1EQqc/dHkRZN6ANQzCd/uOwVSPRVHFsWI0fyd1mmUqvM/icGQmdnuW28
	gCyyZPVR5xbrP99H/llm3JlRYaX+zgRSmIoZZIEBBY3kQS1pqe0UFIe04bfqIbM8
	6KMUGKKCWf2H7zegUxDhrxveVggfzKfRPaRG9z4kxZnOtilxWZjQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0ykxd3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 15:51:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54SFZ9H5021137;
	Wed, 28 May 2025 15:50:58 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013007.outbound.protection.outlook.com [40.93.201.7])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jh323c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 15:50:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueuCO4WjhY0/39iGolFnPdSOEgEZqSHaVWM4KTd2LFr4m0Hce1D6cTg7T1k/G5Pfp6Xwm/jI1JCxxeeauGwtYAbtIgkSOA4H5drRjs/l7pWoQ6FqHshS1kPGVBrxRfqT6FQmYtONcDvy0VLl5+BKeM1o6S4OFw5/Z7kZO95v5Yu+TQkTPZDzsqfHJ0cWgYMRyKjtmVhp83cmI1zCPbtBdQkyuCgjc2z8f2MtjcfgEDnxgeukqMyOAuSlV1rfSluhGvEtMsGGJGEcFkvsRJxkNcz4Za7/DL1B/zAvO3axsGJD5wkgAtT9HoFLqxyYIEtQy4xCP6f1lZYUWKM+OIF8Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l97piMWMNHok4IXASz7nrzhbnl2ad5mUccfm+cEd330=;
 b=xQdpPCPk3nyU7A/Koao/4i19vXKn974CP1SGP+f62mF1AUvHImlX0A2zD9SHbb6z178t/LemxCvQB5SxZNf6+iyXzAWYRO2BVrKisymPL5aN4ZgiQGpM7FnF3KJZzRD0wHB9oRjsLugV/rmgaj4/H34nlD/q2v21bXD9RIGXBVCYYbMc3Vja3cDZSBfSDnu75a9elz6DARfOATKoEWMH1oRAhWCax5KJEnRaromg3l3Ywa/VEsb+H92Nit8Z4Ur/WY48uSMK1/KxwyASDQFpXoKL/THFNCdkMv452j+7ksvi8sJt2DMv3UQ2EgCMtgsbN5xaPEddTscY1OnzmcgdeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l97piMWMNHok4IXASz7nrzhbnl2ad5mUccfm+cEd330=;
 b=RmbeoExah0lIIWKdvEC1mi3p8wIzcrJ1NVVyXNhqKc7YvB4tm8TxLUsYnM+a3R7WCEfmeqsi2kiY1+HM6peebam0OEK4H/5TzyF/hW54SBjANA012808m5w45KlsMnabqduGrq9E7FmlZNhvzJo0nTt1IOi8hj8yThGwgafBmws=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4719.namprd10.prod.outlook.com (2603:10b6:a03:2d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.35; Wed, 28 May
 2025 15:50:21 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Wed, 28 May 2025
 15:50:21 +0000
Date: Wed, 28 May 2025 16:50:18 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: xu.xin16@zte.com.cn
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, Liam.Howlett@oracle.com, vbabka@suse.cz,
        jannh@google.com, pfalcato@suse.de, david@redhat.com,
        chengming.zhou@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        shr@devkernel.io, wang.yaxin@zte.com.cn, yang.yang29@zte.com.cn
Subject: Re: [PATCH v2 3/4] mm: prevent KSM from completely breaking VMA
 merging
Message-ID: <2ed7c9c0-30fa-4ec8-bce4-d7ef9d63b4d5@lucifer.local>
References: <6057647abfceb672fa932ad7fb1b5b69bdab0fc7.1747844463.git.lorenzo.stoakes@oracle.com>
 <20250528233832445zSfRddcejioi-qwhWuUBJ@zte.com.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528233832445zSfRddcejioi-qwhWuUBJ@zte.com.cn>
X-ClientProxiedBy: GV3PEPF00007A91.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::60e) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4719:EE_
X-MS-Office365-Filtering-Correlation-Id: c680755b-4fe9-41ae-754f-08dd9dff5a2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RXid0uXUlE9gpSi1CJVpfFghEf6HS+KKMlsg8p/ZuM52tatJvVacES1tnfh9?=
 =?us-ascii?Q?IBChMj4W0y5E9bmT3R3UcrFTqZLXDm/+vD38FQGZQtz43mjp2j2vGbj/l7Cd?=
 =?us-ascii?Q?VhOKan86AkKAfTAtw/W/tIlLco8Rbe5cpFkB7Bt5j2S5TxEojcousXp3RbpN?=
 =?us-ascii?Q?UJNbJuRwkc3TrvCDlLFX81292mYHghffNRilwIYdqWCUf1pItm9pjCKctG+H?=
 =?us-ascii?Q?xU+agLQFj8bWCs+UJq0iYCvKO6FomqGzMqgJqNUve5BC7dIiM3tfQFtNF4B8?=
 =?us-ascii?Q?71sqpkOaYku7QC3DX93MoVArbk5y8BxUcfRlxh+uElbsQQ8aIHlJyUPP7r9x?=
 =?us-ascii?Q?lAbdqKkRs9yJ5YlAbLFYYsbReG3/lHrAWUB05yacxT4v2MUEuzhBvGw6/y7q?=
 =?us-ascii?Q?wVbFIxhPtMzwKAhwNUxuwqI/xy0ISILbQjwgId6CDONfoqF78rdQBtOgXTzt?=
 =?us-ascii?Q?PyOWTNA1Ng16Muke3v+nGBdLk/DR2+ZgW4hn7v2gNc8KsxR15daBs9SNR7LJ?=
 =?us-ascii?Q?Rc8XlrsJpZVLUnEDujd/S7zWOzqhQTsKUmh4pRjGs3viULdICMr/veLX3mfM?=
 =?us-ascii?Q?8u59ASOQZN4NFUWWo6A99zP88DKkDiylqPTtBtSiJIpjpZetN6YNqwf88KBo?=
 =?us-ascii?Q?9qHywh+v9uvdK/szbaASkPILnBuuajNAXpO/8mGqrWOPKUS7MOVA+d2ecZBl?=
 =?us-ascii?Q?PmYDmRqW/QDGn3xhufMb+UAtTw0Q64TUExZT1pljijKZ13nmHQbCjFZ9mpEi?=
 =?us-ascii?Q?AVNnJ07JFE6b2DzoS7a5cF0gqSzKwy66LF81erWvTwiZwF4Dgve4ofbRqIe+?=
 =?us-ascii?Q?rtPmF7vpH0FlInMEYNmRGygkIJ09lSHf13n5cBjB8kj8RZqdTPLcFzb46lqY?=
 =?us-ascii?Q?kkixKjBDfQWMr6B38GLKpY4ttNgcTwyIX0/GfBLHVbOxwuCbJNBCGsgbt7d1?=
 =?us-ascii?Q?Np3mkXEB5yA73JkPp0itQZqNLUrgVHJK7KJ9U0TapiN5LTTHpvTbPS37sn36?=
 =?us-ascii?Q?m7pH+ivj7AwSz51cMBn++dKo9FvI+e3xBbMgjTaWOYituXUy3SxBBHWxP8CQ?=
 =?us-ascii?Q?/8uQo2kcNYh0KywMh8eb81VjeL09ZE/tvxSVC9Dm6Dm/op+enhooyuDXI61N?=
 =?us-ascii?Q?lfOG2kS+Z4/vAMeG/AnMcR0UVjbZF/9uH+z4FDFEYSB/lM+wYICvZsEddZno?=
 =?us-ascii?Q?U24UDvY31qKJced4P37DbxyKV7u9oX4fQ0qEg/jYsIMp4uEQH1vmgrvjXRqV?=
 =?us-ascii?Q?JOiKSYH3Wf1G1zvUS90PTNfl2BNpHzX56dwlPQf+FBCRla3NanSqomEPq395?=
 =?us-ascii?Q?Dy8RzOgONHMMgWMuI/ZobyMOzXwTTF7fhjqx6loAhROm2UQunbnryYBFKi1c?=
 =?us-ascii?Q?09cKjJJYW0fLDk3opLu6bFX1amhby5EaNuffj3tf6ZGgjICmTSWfxXW9TwJ6?=
 =?us-ascii?Q?K9cSjnanyys=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A2Mo0jgFoMo5DnFVSOFllUZp9/LgvKvMtS18wtCneNLBHHSHUS9u6sZmCbCc?=
 =?us-ascii?Q?ConzfxTvoLcpfiwvOO6Qd23zwAZP3/G0oM1d9qR6afAlScJLj3zFviOM7ZGv?=
 =?us-ascii?Q?QKbjwLWtbgIoUbUoji5oBu/v29lGeDQEYpJOe59qWlsIh9zxUSsi7ftpqeHJ?=
 =?us-ascii?Q?/5JbijcJr3BZ7NsUtVbtL70XelvRAqBvxqo+BhUXPKIhY2kqVIhVUMxxbC9u?=
 =?us-ascii?Q?a6cU4oQU5y/vSzySOnicWqs6z8JlR1Jv2FXLUUnmFgEcygzr7LXlIsGgcbKk?=
 =?us-ascii?Q?IWlYV2rqCGJUkB9HvBND/Ou5257jYunuRh2qgVye5nfnB6nDpW9666lIOiI4?=
 =?us-ascii?Q?hL+x+4CnERILdNTsWj98RC1VNXK4MXlpCiJhUMXWVvH+JN9Jr3JdVnaX/GZ6?=
 =?us-ascii?Q?ABxcmcJPdWwCFzsnlsq40rc89A1DnrjpbBzyTk4MAsSOFNWVL+SiBphhIyWQ?=
 =?us-ascii?Q?pEwpc5p3sAs/iXF95oAKKrV7tAwDjx6CUyzOWZ4KOXU3+bAdNFJJAy2fqTrF?=
 =?us-ascii?Q?jPHbefVtUae4sz8s/HsQF9bb7vFW7qCQKDV38GBwYEcANF+iqh9M3Vh8xkw8?=
 =?us-ascii?Q?puIhePSkNWwqOpiCiKum5heDBjEQ2n2Q041RfSv01oTVP+bR3Ihu3xUuAiwA?=
 =?us-ascii?Q?BeokeLRruc5dgAoUTp+NcX4T8OWzBvSTKIgSs7B0HhfLO0vejgXZsbGBpRAa?=
 =?us-ascii?Q?uSzAwkMvgvYJS6FZQUX0MpEq8cdMvFf4c1Hj+WsCTYsv+yU9daB3mb8IpNS3?=
 =?us-ascii?Q?wHEfKiXujytNCDhFShsR0vNXCW9bPeLS8DwzXV1WTsf/YdEcNXhurRf21rNh?=
 =?us-ascii?Q?dlkcJGI6qbadLn5wLg8fg8wexdr8f0uD5VFrLHXREg4PqpbXlBz79tdLmOTp?=
 =?us-ascii?Q?ZxWI0+jp73B33+fgFE9s++1y0kIuD2XMa00GHX5EZoIFizNqShZ1+5DMrh7h?=
 =?us-ascii?Q?0oefp5aKborMtS3GRG3C+2JtiBwFQKHOkxaN/pCwjWqMaHuBlhIXHdKEdtrK?=
 =?us-ascii?Q?9eGPk1Kb+q4OC2XRmqBKcTlbUl63aC3h1NDjtCZt5lVQQvjUW5YAWJfFLfKM?=
 =?us-ascii?Q?7S+afHYGPgBO1lFQ/TtVZ5Ocq9xeSZQOuW3nZkcC7vD0SnX/mTMVvwhTiOOM?=
 =?us-ascii?Q?n+M165rxqHh0FVrMS0bdIC5QIGO1J3l7aNEXabJ4VFnZT/vPSDtuaGSEJHcX?=
 =?us-ascii?Q?UoZG8tdEieIu0odEi0u/pwQWbdjt1G5iTymi1iTtaga82HBxtdmZdpMEbYOe?=
 =?us-ascii?Q?6WXnqIvQyx5it/xkESOtzBTySqrUuDOXQknHKiuYRgdxx46x8yJB5n4KcR1i?=
 =?us-ascii?Q?O0XMnDwKzJE4Y8Mw0OqpE8xiKNGUOwGPPB1IMCLviOq++rTjXGpRnjKh9kDa?=
 =?us-ascii?Q?n0tbXubuSozaZq/bwEuxZde620JUu0ybEQQiF7IIjRcxTDi+Wcfhq/hjlEPw?=
 =?us-ascii?Q?bPg9zaz7nnLB2nCUE013tJUxTQv+Ydt1nZk1IYMyNFR1AP95MUQOW+tR3oB2?=
 =?us-ascii?Q?fa/zIdlwBjrZR9x96H6vobYali5XY4sL8Cyboi978i3tKHWhLUS6vXVMlmGM?=
 =?us-ascii?Q?Nqt1ojVOdhmS1lztKAHC5jAVW1NHd133VDideXRfB0GeqzOX3Wq+/yYNDkXR?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wvgukTehwtME0ZwUFhv5DvfLTFz5kdwI9ZmgXHhsATuS8svijerlJGcWqE9+tVRiJVLOBaPDtJ3bsDc+96CNWf7YHG6UKvpkRYAFRN8ERTG3+RdeBGfTtj8RbBKjLUL6O4LDZSr3T28q2e7P8zg1t1gfLmI8L5qSxx9/0LMn2IBArX/+CKGdRbIH/AfbbbVS4t2s0+oQYZKG33G2C2lNwaerjFmJrDeBmfhFVHnS1sjAR+MJ75p6Y0/skOI6wBCSHG6VgH5KOqkXDEhv6sElOMgwtmzI5FegMrU1eej9/GRnIczKYA327j21WRXJx3aVNqNYlY3yH029i+Ql+O/kU3zw0m9bM1+aG6D928j/DEBzOyCTGoMksYFojgXELoTmM80bZCW3CXokwaFfEds1Cxm8n9VsvQ4ortmm2PpvIRLNFVKqcb7t0Rjzu75VamfHfZVeWtkLww75Qg7v32hlcGfShZPFZ39T0F7bYWjL1lVVLQsZ2ZbZj7YFAUw03rH1n9ijuo/4omukc0zQLNfaNLw4us6b0zxglEC9y2MsYSF7QpzM88rg5dBUgSuhMPEjoxkMkRvsngDVpNUH2Re9JH1+8Yefm3tOVZceUdTUTaY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c680755b-4fe9-41ae-754f-08dd9dff5a2f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 15:50:21.2593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0a4zCADU/pWjVLny5QtbCLLCJEL+Nt9mHVB4i7+6kssfUbvLuVCKqGFRRyqnQKJWDL3ZKkrUzEnd89hycbWa8ltWPAdJmYcYTNFZZ1T8oeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_08,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=840 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280137
X-Proofpoint-GUID: ialykXiGXSTyYTuf-alKgqes_p0AIh0V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDEzNyBTYWx0ZWRfX8UCJ3d/jqEtF bTWGuE/MD2JZAJUISyT3YRtu3OgGAPyQU9UPyDHu8fMlsCX9GlzHsUsJWQhxxH1E5XVwJsut0S3 sSd77ldFk1sWFrJ097Ebug8BaGniL/JZi6l1TaAAd9SNo+NpvZ7BogLKrdI66LT3gyLbe/4UNIV
 FHibqGS4u9Wsidyr44KFTaKNFQHgstMN7a4Si1Kaf9ncRdQW3i4S0ykoD2abRPkk66jWqVvomOe c1/Lxp/kKJzBHga8ZhruK3P2V/BA718Li/MngHnilcltncPCoqTdAtUNIQZ5BIjbH9ZUDNIFoNh EL6D/+3dhHNjFr8iQrxv9BDf/EBzO65Uyb1F78oBt2KhGSfK5stl7nnNJbKIUHy4cnziJu4HA1G
 2B9KWy0mmDF4as6LBhpgUSa9c2+p5p1gTNUCXpo4PGqf3z9dWFs3tzRSKMeF/jB86w0x7WAf
X-Proofpoint-ORIG-GUID: ialykXiGXSTyYTuf-alKgqes_p0AIh0V
X-Authority-Analysis: v=2.4 cv=N7MpF39B c=1 sm=1 tr=0 ts=683730e5 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=1RTuLK3dAAAA:8 a=Qss1jijty3bCHTHB3n4A:9 a=CjuIK1q_8ugA:10 a=kRpfLKi8w9umh8uBmg1i:22 cc=ntf awl=host:13207

On Wed, May 28, 2025 at 11:38:32PM +0800, xu.xin16@zte.com.cn wrote:
> > +static void update_ksm_flags(struct mmap_state *map)
> > +{
> > +	map->flags = ksm_vma_flags(map->mm, map->file, map->flags);
> > +}
> > +
> > +/*
> > + * Are we guaranteed no driver can change state such as to preclude KSM merging?
> > + * If so, let's set the KSM mergeable flag early so we don't break VMA merging.
> > + *
> > + * This is applicable when PR_SET_MEMORY_MERGE has been set on the mm_struct via
> > + * prctl() causing newly mapped VMAs to have the KSM mergeable VMA flag set.
> > + *
> > + * If this is not the case, then we set the flag after considering mergeability,
> > + * which will prevent mergeability as, when PR_SET_MEMORY_MERGE is set, a new
> > + * VMA will not have the KSM mergeability VMA flag set, but all other VMAs will,
> > + * preventing any merge.
> > + */
> > +static bool can_set_ksm_flags_early(struct mmap_state *map)
> > +{
> > +	struct file *file = map->file;
> > +
> > +	/* Anonymous mappings have no driver which can change them. */
> > +	if (!file)
> > +		return true;
> > +
> > +	/* shmem is safe. */
>
> Excuse me, why it's safe here? Does KSM support shmem?

Because shmem_mmap() doesn't do anything which would invalidate the KSM.

Yeah I think I misinterpreted actually - looks like shmem isn't supported
(otherwise VM_SHARED would be set rendering the VMA incompatible), _but_
as with all file-backed mappings, MAP_PRIVATE mappings _are_.

So this is still relevant :)

>
> > +	if (shmem_file(file))
> > +		return true;
> > +
> > +	/*
> > +	 * If .mmap_prepare() is specified, then the driver will have already
> > +	 * manipulated state prior to updating KSM flags.
> > +	 */
>
> Recommend expanding the comments here with slightly more verbose explanations to improve
> code comprehension. Consider adding the following note (even though your commit log is
> already sufficiently clear.   :)
> /*
> * If .mmap_prepare() is specified, then the driver will have already
> * manipulated state prior to updating KSM flags. So no need to worry
> * about mmap callbacks modifying vm_flags after the KSM flag has been
> * updated here, which could otherwise affect KSM eligibility.
> */

While this comment is really nice actually, I think we're probably ok with the
shorter version given the commit log goes into substantial detail.

>
>
> > +	if (file->f_op->mmap_prepare)
> > +		return true;
> > +
> > +	return false;
> > +}
> > +

