Return-Path: <linux-fsdevel+bounces-20659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D5A8D66EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 18:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6493A1C216C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 16:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7F2176242;
	Fri, 31 May 2024 16:33:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278C915D5B6;
	Fri, 31 May 2024 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717173214; cv=fail; b=NCfQF47I3x2bi6a+AvKhHg0KTutn3XBEvFg8Zr+BBC3gzIrX3QMsABHWDN9yBHENXtNYlCS0VXBcDHkFXF3hrVGZf/ZtYhV/OWun8I8dCkQhHPeHb+Ew4+pWORR+SpkYDtCtNWlH88l2c4GQ5UdIrKfHFMBobct4x3PMKURIlVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717173214; c=relaxed/simple;
	bh=VuueP+ZtLgsfFDTdX/zzHpbHSPSgkI1wr/i+2oHi6CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zu7Uf62dj4MdqClF0GQT1Y5R3jmI0uP5TLhiIHH0ZRntmakd9q3wy4Sw8TyJbuMOP9nk1aYoVMGyqXJGAZqM/ECRfGPkiz0xOI/XhERmWIImjYtpd45bGF6KDgM8eiUL7EKSMAIXdqJ2ohdGEOOWfPetcANbosvZArY2XQSioeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44V9TGCi025400;
	Fri, 31 May 2024 16:33:21 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DkcuZ6HWEjt3pdm7wXmr0/LqSv+K42t9RFLa8SzV94aQ=3D;_b?=
 =?UTF-8?Q?=3DbmpNQHRenD+MHzdp2CFYXf4gEIlvhPPfjcgoz+OOwrT5nCohZ34uIXvsg/uM?=
 =?UTF-8?Q?KK5jdKyp_c41Xa1LCCHefGC2nf4xWsgaAKRWzxPxkfSJCRsRDnnCJJ2v5tVXAV2?=
 =?UTF-8?Q?R5ZFrXNtsHy7GG_Opb7CCF/TUrEW5AFYAzsVXsfTXQNGPeZQDqDIAnm855lH8eM?=
 =?UTF-8?Q?ZMtONYxPLvb4nYbGZJee_V7mD+OTe1x0ns2mANOeikf1iUOuR+sR2wTc/epduPM?=
 =?UTF-8?Q?zDeEbktH4f/dPChbCImQ7N1qq2_Ldf18APCWEhcrukbnl7AtznPiLIPv6RUMyHQ?=
 =?UTF-8?Q?VDh+5ytxFKnJ98AO2MOAkYUAL+mmjyTr_Qg=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8j8besx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 16:33:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44VFaLYd006199;
	Fri, 31 May 2024 16:33:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yd7c8kmkf-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 16:33:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6s7FcKOaBR0Ibh5zs+yA4omCokneZHhZfUR18HMkr5Ax/ZgPTbYDZF2rG50AtOd1dwo//INjCgOgrKkuBW2mFrPBr1H6qbfBJnOGISaG2DS8/NuFMSA0DMQnto6b9QW0wHJN9jJkKdyuhfFOVJ8fHMawOlhh3tWj3p1pqaqgezXXE1AzTaU6zHZhntXjOhApRhAHB6SCieYiQbbRmMUih69nvUGMd52LS48fBEUiP3eOCfMohDEb0qdx4+GySPYPZ00AdDj1e8ZrLxCSwOOcMXnpxseYDtCnESbd2vPLOGDVJ8MK7GZpi/mZ8A4ngu653iKQndTAu/dUNvNMlac5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcuZ6HWEjt3pdm7wXmr0/LqSv+K42t9RFLa8SzV94aQ=;
 b=T8muiu4oDyR4k3SXEjgB1WsiY6x1XV21dxIpUrbJuH29CIz3G631nPLjdZC4wLEvcC6aIPtwG+Cvc/dvJwk6wpOTp6iS8Ea4dfLC3GggBX3GR6C4MmWDnUYsmyRcUr/eC33gwCy3kPNIIkKYG6gRiC7HphpoEYpispANn3sO/yXU9zM5TRZuFj+Bzd2/bugEM0LPQaIa4mrZgRDka2n8h58xDJ4//HS0MARke8uXrHNp1tg0FHkl3iw0fLlKCKhV0TAoamLPO806voi7YkFazSJEYZA79/EhqmLSejKrGZX0FmEUs2rrq4qU8BVHNURBBrDe7ACMSmBSe+qsTnOjVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcuZ6HWEjt3pdm7wXmr0/LqSv+K42t9RFLa8SzV94aQ=;
 b=WxvShYD2ZxQk0Zo9QZPFZM6V+7vN4BdZU/n7JYRCTZNS14cgOBuSDEiwIjBEbgGGzE4qSumqbXtw/TiLnk0MyygJ3xVYp3OTMpca4C6Hae8q/ErvI7bbxJ0UmmZFuyE/b1J4f4TxQvMnuQBx2mtUdit/cXt+ZW7/220fPAtCrx8=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA1PR10MB6318.namprd10.prod.outlook.com (2603:10b6:806:251::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 16:32:51 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 16:32:50 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, sidhartha.kumar@oracle.com,
        Matthew Wilcox <willy@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/5] mm/mmap: Change munmap to use vma_munmap_struct() for accounting and surrounding vmas
Date: Fri, 31 May 2024 12:32:16 -0400
Message-ID: <20240531163217.1584450-5-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531163217.1584450-1-Liam.Howlett@oracle.com>
References: <20240531163217.1584450-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0483.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::22) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA1PR10MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 117e2752-cbc9-43cc-cdce-08dc818f5057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qKk9okYMg3mNjACHrmH1egStdP6cgEdcvw4LoKf2aK3T7k2RXM0RMXIlsFY5?=
 =?us-ascii?Q?JchfXa1v6TyjWz+7VGHqrHm97PQOPwHsTr7JOjcz20SIwBDi/pg+Owr5+7Yk?=
 =?us-ascii?Q?BluYQr+rGNSr/bM9m/ZrvLtLhSP6gTtufRHYYNM1mRZcisfpzL0VECfZ8zX5?=
 =?us-ascii?Q?LkOZmfvY5qgzRSIC/Cxp818XbCWi/iCRzuhKIiQsusyY9AoBtBD3ihK5Tv//?=
 =?us-ascii?Q?MyVM82k/xavnDBfNX4IxaGoXP44dhbYTc+vUJygI7WXJsEGNdYCXfMzOKFB/?=
 =?us-ascii?Q?lyGRT4mv1lS1MD5eBUal8wWhrFMNrg5axrjAOGGSaWaiF2QXtmmjVM3d+1gd?=
 =?us-ascii?Q?xzYK95BRbXkt3D1eepBuygZuXsBoQhjTEwhNWEZ+ir81eYpIgt2yNw2WfDJK?=
 =?us-ascii?Q?RdZkoO6f4ASg7OR0pXVhvjr+J0Ih2is9vcfZ61FbFtOokqdPFUQpAk4c+WvU?=
 =?us-ascii?Q?cm+VMWLuSi77fpImyYeT+CWgQ2Zyto9BycUwK5B7KkgqX0IHDj/QJFaUjlmK?=
 =?us-ascii?Q?Vqdv6o2yI28wdF8NBwWyyQFkWylq8lJ/omR2vCFapWqlyR/M+hGPk+IH5WgB?=
 =?us-ascii?Q?4fR64m/a85xzbjF77UM0Jxz+41Hm8Hg+GTp687wn7GZDrsj03fZyOrDQpiXg?=
 =?us-ascii?Q?VW4f3kaxLmH8pIaANxz3ieVfNzcbjcnhzmFPW0HF7+ZhBVIwyLgHs9DN3vt5?=
 =?us-ascii?Q?3geNxbl9Mad7RBKRm/9lc5ZjRQZzfnD+pb+vlfrt/SD2yiTLkw5uUELeWZIf?=
 =?us-ascii?Q?A4GJrQ/IjMtjvqXIWjMFOUzIcRTU8IY6i1JyUcd8Cz0gN4CR5FUAXqQvNyZ5?=
 =?us-ascii?Q?qN2DdTpa//2/+w0+pYGkzCHL7Rd9mSNg8ZuhqVm0ZKoJWCXTI4SqmF2Aqt0E?=
 =?us-ascii?Q?jcDAXCbuj3QzxuX+gS01HYmX8JP5BuE30Wu8y1dfkGgLwe0hOkMPxqK7Lp4M?=
 =?us-ascii?Q?QK9WRg+Td+BnR7gRp9Glof7ERBy2u1pUD/EADapBuBwO3U6PDU63LZVYO4PK?=
 =?us-ascii?Q?bRDjemEMymOJa+gkrJ9hxhfpXXyX8TJZOeB3HAaDLja6eoTY6+RCX6FyjUTm?=
 =?us-ascii?Q?MkLlSmHMrR7ExbFWuQRjGTnZbvc5cWyEBJIdWwn5/19w2IxkItCwamtaAA3r?=
 =?us-ascii?Q?758JhkC33H6Mz3Pl1injkw2v+7VgdqHBmwyWU0I0jxYcWmAeHfDzfJg7WVMo?=
 =?us-ascii?Q?/Xent8CZ8LeELddDyr2Y7a8m81f48YWZCUZoRFqLLIiXqPIXij1yZ/ov4qSI?=
 =?us-ascii?Q?Ihx09SOya5oh5sdHQT2LTpbJYdQR42HbGPAejxbnkQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?C8OlPvGcUbbWVO180IsXqj2EiG6RDO41Kn6QsdUYFqUQyUCGYiJWCf+iVQmy?=
 =?us-ascii?Q?3GZEiI9VPsBk+8vEOxIR0i0gZyodpY0rHhUFlArPcRoQ3pvS0JvPyVhdCnZE?=
 =?us-ascii?Q?VIt2p4mKf6hZHYCMw/+tQZucjUZaIybnhPWB91oCog7WekU67qajJJ9znHeI?=
 =?us-ascii?Q?5HxiDVvc3XEAltMW7sWIv3zaEVINJgtVjJDI+LPmHdOxdoi6m1OIRPPuSnhL?=
 =?us-ascii?Q?BY5huTEC9nQyTVC14ERGtozaKdmZ9dgdh37wdyCOm1pNGCNhhhhhm0it5IBj?=
 =?us-ascii?Q?1W+IrqOPmukAUuGVGvBRs+zCcFdqH8iuLVPnT+IXXhKKS+4Rlk9g3CH92tKy?=
 =?us-ascii?Q?jtOEtZSpxHAOrqKMXeijkUYKmiBuVyFkTEua0ZyJkJM3z/km6AExGkYbemTf?=
 =?us-ascii?Q?0TCPksuLSa0oHml03/EphreclvoNRulZAMh4e23zXs1DUPzRQ/uqKgf99e1S?=
 =?us-ascii?Q?GKZTp9/nYEx4+yv8Vyq4bfYTz2dET6TAJ7pbOH7P3CCWlXfp/ZDtwFnySzal?=
 =?us-ascii?Q?0ZnDTpEttN4TkqGwVybmDX/1HVkbC9CYglJYdXHdqZdfM177nyonaZ3kVS8P?=
 =?us-ascii?Q?6xVGBBQuIz1aH4i/2ww/MjDGfvhzc4FsSHMoiCiLU6jybOjjxCDTIgUacECX?=
 =?us-ascii?Q?yC41PpF2Qm/WmZAA4p/rKlCYOySnYhwnk4TCwKDeVLGFVdaFT4+Afds1c16z?=
 =?us-ascii?Q?4lQXJ6ifqB6R2axkEIGsqvEdGfCVxMmXG6YYJ32COdjSFzrY6cyIkCKHUtHX?=
 =?us-ascii?Q?QS5vpobSYDC/5b77cadGBI4wNvA6MwpJa2oP64kpG2Lg+zdD63WhR+q6GAIQ?=
 =?us-ascii?Q?1lrQdC+OaHrOUU5QbgLJ+7wEO2xq7/w976ev9Uh+y9uLyfVPZDXOeefi1e2r?=
 =?us-ascii?Q?9PiiDwYTzXiSoAs8P5ApAdoUhVdDlmdEEQBSAiAYLtX72UBFRWTtLbp22hjH?=
 =?us-ascii?Q?/AMzwIs8k5WR3pPN85ItIjsxHpHIOwjIImJsOrBmBQopK4Y9DSIA6/8Vp8L+?=
 =?us-ascii?Q?xjrqQ5tsChal3bsN1ZUBHj0KSnrIyfwB+QcuDNVVvTXg2upjl0UOPHMB9L28?=
 =?us-ascii?Q?7VIi6ZOVDePE8IrsvAwUvBAwhdG0DpXVxUjNK/LdD4k51sdLKQTEpRV9WuK7?=
 =?us-ascii?Q?9XW+K0vWUht/jrB1qq+in7djI5I2V5yZpGtvCiISYVz/UyFHxP7wjsVnV79E?=
 =?us-ascii?Q?ZjIj4wDH7rx2YIKeJd9ElnBf0N5QLknJ6HVB7nrvcdxoXbV/c0DcfOLkX1vg?=
 =?us-ascii?Q?GpIvI/m1nf4QPdPsDwPhFhK84lCMvV96ZUOg+lPLfQxMO8pRWCC0LPwdT2rJ?=
 =?us-ascii?Q?+WCzntLG80yGHsx8iihUHf6JH6NNBroInEIc4DSJLwV85FmayZDgcqWBPbH6?=
 =?us-ascii?Q?eOAD6ZdYCLf5tK4kcDzfTQX/RYpvWhj/D1A6dPukDvySGE1d3ssAOTdXJn1h?=
 =?us-ascii?Q?ScdMZxmS3idsVP45DoverqVzGBHhfujFKrIlwrrmrb/osQZSPwL0c7oI8cA3?=
 =?us-ascii?Q?sFkQevqwC2lrOf58rzFqzoVf/vzxg22JAaE+B4UMDVYhStJE1q+oMuXsoN5/?=
 =?us-ascii?Q?otGs0G+tUnOSmpIDoKbbPbElf3Mcd2ucCLwbpaow?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zMh/hA9oBDZbHPgA+gmVhNQOODBHOp/NYu0QGxUPWJ36mtZweuVZm4NB0xjTLeeVm1DmB2ihNIwjvAhTMobZHsgRJlEnKqe9KLHCYYehUz7WiWvw6MQ+VNyldosmVi/50pykgGeab6ZA56bby0qgAIYy3rnMnkSBDNPLUdiMwNQNEx/mxYqi5N6CMheDa8/lTOOySstOs2azil0E/kyXPYyhWzjy59BEyi5RcysXZU/oVorwZjZWw1EF6Irl631b7jokSiPpaaQ9SyyUtVPM87KKX3wiCMVvIypqTtyMjBn3QeEs9AYHwgCQlok70VAfWzdovxoP1UcCjLo5fiMcSczAWaWarqkC09iAu/9qIjPb2PJo23k4JmJayavDw8pOV8TfKzoj11ys15325GqoFKnhE+Fg5cInfc0Pcq814tz3rAGpLrcXCSJ0Ijdm4NhAUd2iZooGvUKCm51PK7qNwFAogZLuYKf+GH4xo+uOv93d107aIvScRMYn8gNFZUbc2NxqVTD/PtAfxHrUwlyfn/g//hJDAQCRbp1vEQB2rp79NW7ZwZLtyoGheFbOo8e0rSSf+TSzRf6PI1j3XvCXoZM+hRzKbr3Mf8OOfYhFQ18=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 117e2752-cbc9-43cc-cdce-08dc818f5057
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:32:50.9091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vj49urUZk1GQ+Uvz8ZMe6fPKd1ABwlmUFjhw1Wl94xi8Y9kn4f5baepgZEkOMp9HDJ5DXjfNkAsObh58E4V6ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_12,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405310125
X-Proofpoint-ORIG-GUID: qBm1ZB_6H5b_O9ARpghh6vTZ0NV7a-Tz
X-Proofpoint-GUID: qBm1ZB_6H5b_O9ARpghh6vTZ0NV7a-Tz

Clean up the code by changing the munmap operation to use a structure
for the accounting and munmap variables.

Since remove_mt() is only called in one location and the contents will
be reduce to almost nothing.  The remains of the function can be added
to vms_complete_munmap_vmas().

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/internal.h |  6 ++++
 mm/mmap.c     | 85 +++++++++++++++++++++++++++------------------------
 2 files changed, 51 insertions(+), 40 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 6ebf77853d68..8c02ebf5736c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1435,12 +1435,18 @@ struct vma_munmap_struct {
 	struct vma_iterator *vmi;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;	/* The first vma to munmap */
+	struct vm_area_struct *next;	/* vma after the munmap area */
+	struct vm_area_struct *prev;    /* vma before the munmap area */
 	struct list_head *uf;		/* Userfaultfd list_head */
 	unsigned long start;		/* Aligned start addr */
 	unsigned long end;		/* Aligned end addr */
 	int vma_count;			/* Number of vmas that will be removed */
 	unsigned long nr_pages;		/* Number of pages being removed */
 	unsigned long locked_vm;	/* Number of locked pages */
+	unsigned long nr_accounted;	/* Number of VM_ACCOUNT pages */
+	unsigned long exec_vm;
+	unsigned long stack_vm;
+	unsigned long data_vm;
 	bool unlock;			/* Unlock after the munmap */
 };
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 57f2383245ea..3e0930c09213 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -482,7 +482,8 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->unlock = unlock;
 	vms->uf = uf;
 	vms->vma_count = 0;
-	vms->nr_pages = vms->locked_vm = 0;
+	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
+	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
 }
 
 /*
@@ -604,7 +605,6 @@ static inline void vma_complete(struct vma_prepare *vp,
 	}
 	if (vp->insert && vp->file)
 		uprobe_mmap(vp->insert);
-	validate_mm(mm);
 }
 
 /*
@@ -733,6 +733,7 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_clear(vmi);
 	vma_set_range(vma, start, end, pgoff);
 	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
 	return 0;
 }
 
@@ -2347,30 +2348,6 @@ struct vm_area_struct *expand_stack(struct mm_struct *mm, unsigned long addr)
 	return vma;
 }
 
-/*
- * Ok - we have the memory areas we should free on a maple tree so release them,
- * and do the vma updates.
- *
- * Called with the mm semaphore held.
- */
-static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
-{
-	unsigned long nr_accounted = 0;
-	struct vm_area_struct *vma;
-
-	/* Update high watermark before we lower total_vm */
-	update_hiwater_vm(mm);
-	mas_for_each(mas, vma, ULONG_MAX) {
-		long nrpages = vma_pages(vma);
-
-		if (vma->vm_flags & VM_ACCOUNT)
-			nr_accounted += nrpages;
-		vm_stat_account(mm, vma->vm_flags, -nrpages);
-		remove_vma(vma, false);
-	}
-	vm_unacct_memory(nr_accounted);
-}
-
 /*
  * Get rid of page table information in the indicated region.
  *
@@ -2625,13 +2602,14 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		if (error)
 			goto start_split_failed;
 	}
+	vms->prev = vma_prev(vms->vmi);
 
 	/*
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
 	 * it is always overwritten.
 	 */
-	next = vms->vma;
-	do {
+	for_each_vma_range(*(vms->vmi), next, vms->end) {
+		long nrpages;
 		/* Does it split the end? */
 		if (next->vm_end > vms->end) {
 			error = __split_vma(vms->vmi, next, vms->end, 0);
@@ -2640,8 +2618,21 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		}
 		vma_start_write(next);
 		mas_set(mas_detach, vms->vma_count++);
+		nrpages = vma_pages(next);
+
+		vms->nr_pages += nrpages;
 		if (next->vm_flags & VM_LOCKED)
-			vms->locked_vm += vma_pages(next);
+			vms->locked_vm += nrpages;
+
+		if (next->vm_flags & VM_ACCOUNT)
+			vms->nr_accounted += nrpages;
+
+		if (is_exec_mapping(next->vm_flags))
+			vms->exec_vm += nrpages;
+		else if (is_stack_mapping(next->vm_flags))
+			vms->stack_vm += nrpages;
+		else if (is_data_mapping(next->vm_flags))
+			vms->data_vm += nrpages;
 
 		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
 		if (error)
@@ -2667,7 +2658,9 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		BUG_ON(next->vm_start < vms->start);
 		BUG_ON(next->vm_start > vms->end);
 #endif
-	} for_each_vma_range(*(vms->vmi), next, vms->end);
+	}
+
+	vms->next = vma_next(vms->vmi);
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
@@ -2712,10 +2705,11 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
  * @mas_detach: The maple state of the detached vmas
  *
  */
+static inline void vms_vm_stat_account(struct vma_munmap_struct *vms);
 static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach)
 {
-	struct vm_area_struct *prev, *next;
+	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 
 	mm = vms->mm;
@@ -2724,21 +2718,21 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	if (vms->unlock)
 		mmap_write_downgrade(mm);
 
-	prev = vma_iter_prev_range(vms->vmi);
-	next = vma_next(vms->vmi);
-	if (next)
-		vma_iter_prev_range(vms->vmi);
-
 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
 	 */
 	mas_set(mas_detach, 1);
-	unmap_region(mm, mas_detach, vms->vma, prev, next, vms->start, vms->end,
-		     vms->vma_count, !vms->unlock);
-	/* Statistics and freeing VMAs */
+	unmap_region(mm, mas_detach, vms->vma, vms->prev, vms->next,
+		     vms->start, vms->end, vms->vma_count, !vms->unlock);
+	/* Update high watermark before we lower total_vm */
+	update_hiwater_vm(mm);
+	vms_vm_stat_account(vms);
 	mas_set(mas_detach, 0);
-	remove_mt(mm, mas_detach);
+	mas_for_each(mas_detach, vma, ULONG_MAX)
+		remove_vma(vma, false);
+
+	vm_unacct_memory(vms->nr_accounted);
 	validate_mm(mm);
 	if (vms->unlock)
 		mmap_read_unlock(mm);
@@ -3631,6 +3625,17 @@ void vm_stat_account(struct mm_struct *mm, vm_flags_t flags, long npages)
 		mm->data_vm += npages;
 }
 
+/* Accounting for munmap */
+static inline void vms_vm_stat_account(struct vma_munmap_struct *vms)
+{
+	struct mm_struct *mm = vms->mm;
+
+	WRITE_ONCE(mm->total_vm, READ_ONCE(mm->total_vm) - vms->nr_pages);
+	mm->exec_vm -= vms->exec_vm;
+	mm->stack_vm -= vms->stack_vm;
+	mm->data_vm -= vms->data_vm;
+}
+
 static vm_fault_t special_mapping_fault(struct vm_fault *vmf);
 
 /*
-- 
2.43.0


