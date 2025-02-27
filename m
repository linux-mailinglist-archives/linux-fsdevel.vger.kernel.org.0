Return-Path: <linux-fsdevel+bounces-42769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B85A48756
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 19:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99FD8188EFEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 18:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF25621ABA1;
	Thu, 27 Feb 2025 18:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W7E+sXUv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bcpY4USo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEBB1F583A;
	Thu, 27 Feb 2025 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740679725; cv=fail; b=IevVy5heQ1O3UdbMZNQruFY2ZixltIQyxyH76rWwjq10tH+f+RpOkRjZ/OeWZRUotA7OIqDzPTInhhgi5R6D42wdxwGjtng1HmwUuCLuW1DMENyczbZCJzKNNYJw7sKr+eQiPO+kFhV1JUCXTwFiEy6KmGDBoJFK14HQQdAcyXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740679725; c=relaxed/simple;
	bh=2DlwL6QNU9F5+FaDxFAFlcQw6Xg63e5E4SkkJ/K7ZYk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=r/ccfHq69rQ8vrXGKEdL/vuAzQslAyE/MJXzv9aIdhYEv/NqoCPCHGMBq4fN9e7qxqF/qQUwVfpNId6NASi9XUcgG8/aUKVas9zkh3AC0V9CgF1RCTjeM3TTpaGPSp1OBzBpoiQRZpBTZWmP9hq0z2tQoeWfHv4kgq9/nNtDBwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W7E+sXUv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bcpY4USo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RGfi5Q027223;
	Thu, 27 Feb 2025 18:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=oVvDV1aXBL4uxQsL
	6XFdzO/DATZ3LeC6Bn1QSC0mFm8=; b=W7E+sXUv+VN9cXo3Iu3IgCMpnMzYnq09
	qEOc1Vwo6LxpeRoMbPU0pQBt5drNe0kZ2h81pyzXQEAOkL79dc3kgXkgB0daNkcC
	CvRdfyl98oHnenICVWhIS5/Y/QzX3CAWrRDFSsdZzGtEc7KUgXQvWoeLZc7p2Czd
	zjy7tYycASRVhM6yQ8Ou8GBSAGYAZMiwz+DIu5l0IgC4s7PQVhva/ZJ3mgm4PY5w
	E4EcDojacn9eRNyG2KrffNledMpNAD/ufFODCtIcflqkjqQZ3e1wAwwZll3mpJfK
	97IyHJHblSHvwHIPi33+aiVAMa7VBOU18mtBrpWFHaAhVsCDe+vemA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psdkyk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:08:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RH1aEW012660;
	Thu, 27 Feb 2025 18:08:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51dqkar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:08:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjeRzikcc172pxYZvVqm9zAYmqD3WwIl+UkebttKC/vcQf+Im4A4JaYGOgfjfUtgeMi7JscEsT0PJ+dxYNO1kcTqX62fMP5NJaKED+85dsWnQ6RtdpiSvGMuiRn2kdNCD2eJNiWjm0zL/uzc2+N7/p39PP01XEdjPAdxmviGZaFPuXuTu8GPCDL/DIBhmlu6OMPEug0MR9E7AfLo46VUUFWuvGuE47eVLiQyeMsCxCLQQ+th4z86zZ/pcdGET/ZAxSUVjGYsgxareOt8sO7EMwYbEL2RPQvK1urkLu956NksA9bXvdDB1nwFkEnViUXEjGd0/Po/VZdurNuokQ8HTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVvDV1aXBL4uxQsL6XFdzO/DATZ3LeC6Bn1QSC0mFm8=;
 b=L+GUH+cUsOMhwOAEst5JWdKXrv0L2DcigsRRKMhDtoptjccJiddymeyQ9k1Cqf2OcAntx5yQ0+zUTN0cuMdy+bP0/c9xXbBb8bfSfvn1nljqGSZZ8LkjSt7NGga+tutkMhJP28JFQlBwMGPrw5rnWD6xIPB0FJswa15h5gFMK0PJqAOHDw5h3f3oZiEUUMjP/rnlLiYlODecDvlJoYcYAMkXznC+Mq+k3oiDYEHr5f5RAAl08dnZdJm+5kvm9EpApWXSvXopIc1m8Hm5l5uhPX/9JSTF1n5dtKgnYWD9R0hX+yTOTeyEv2L1F5OQZCwLCxmCTm4lqrjWw6fffdxziA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVvDV1aXBL4uxQsL6XFdzO/DATZ3LeC6Bn1QSC0mFm8=;
 b=bcpY4USouxG1bOBkLHEEadMziYjkLh4cnXWYPDO5ghttwUi/RXcW+Oq/QkwAh2+ARxj2sYJhwWnm+xMNJo/RrlfE6YOxh3C1SaE15GZMvXx7iBGtkbB52dt2QILkBP20ZVBbUcMkKjmgpgldauEBEoHdvpI2GBw82S5gZ8ak8n4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB5031.namprd10.prod.outlook.com (2603:10b6:408:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 18:08:29 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 18:08:29 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 00/12] large atomic writes for xfs with CoW 
Date: Thu, 27 Feb 2025 18:08:01 +0000
Message-Id: <20250227180813.1553404-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0117.namprd02.prod.outlook.com
 (2603:10b6:208:35::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: 50af594e-3feb-457e-7832-08dd5759bcf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TThCxzkY5e7+icHh17I9HQhUptgNO7ZJ/Iul5Se4E36eRe1f9i8DnLPCL28y?=
 =?us-ascii?Q?+4a03/j2/4O+19kAYJt5uBNEtGH63hUrstWwOxzp+TPpsaeoXw/u9fHzasbX?=
 =?us-ascii?Q?QW+rBR2XsrLcopr01Q/qX7PG1iYVfnaJQf5lCHAH4D53m0O0prdLDrKpkekA?=
 =?us-ascii?Q?sD6IqDtpriaoZs35eem4jlhL7MwBYkCbLpaFhaWkF2qUCZ5H18DazAD3C4kw?=
 =?us-ascii?Q?rPRO22DU0VavDj3RO7O+Ff5KSBMkiBkHW4Btpta7Ru9FbdaJD9dGnBr92/vC?=
 =?us-ascii?Q?rgWkRrcmcAYOcUvZ6RGtqc42JrsF8s/0xV/vj1+EiOdirMn3B9aZVZfgx9KJ?=
 =?us-ascii?Q?X2T36TjcS9pY+i0mN4G8Yclq/HjJd4SqERX2NSGZ/Irg1PMITHfDnOWnq+zB?=
 =?us-ascii?Q?Ttw7pcsKRaKkN6i8Bo+2VT6/fqCpPoRQphRdo8y9iUw6BfDV1idwBb0JK9RH?=
 =?us-ascii?Q?QkjbqZgc+3GTuf9hqFORH4s3SoJmPunO1WsfipmSn3uOUtwNUF+YgM+BXYtF?=
 =?us-ascii?Q?4e3wxEnoNNg77dxxyvvGvcyHP+GY+LPM34WO24Z4YUSJU3oFSWQFHIkCdf8o?=
 =?us-ascii?Q?s0kX49GsGqrInjFH9dXjr6UwMyh6k5fYQbj6StKXRDgdTVYp0JKbHxu7K+ye?=
 =?us-ascii?Q?Dij1uIDmjxB3ErJB8fqzK5PMfPH790Y1u7U79Eb8pO/GxDeIRMu5USlpbRiF?=
 =?us-ascii?Q?ontDQLo4Ofy0/A0pZJQz3kORMgoJuGSG0g7Y9cFMkyxz8GqChP6G65a8ph9Y?=
 =?us-ascii?Q?iukC9s+CXYPLYlmUu1CLd6L0D9WHpMToGCZ8ORCwTOHCOEuM4+yX/rrMIRBP?=
 =?us-ascii?Q?WdnTMJjgpnP0fGrnX3Y+kXUOBJ/7jpTCwMlmlLLjiPeXF6p/X2+klSk6pnIy?=
 =?us-ascii?Q?xWuIrueKNThg5TlncEx0uWnqrwfHbqvFQ75MB1W6tcIL2/6FMKKi2ExKtV2M?=
 =?us-ascii?Q?PYOm1G8Nh4AGwfl60DHNqfrHfRvjVgMFiAZWdk1MIp4zPGEJEXpCWKv2jQmD?=
 =?us-ascii?Q?hltNEnct1DqwHrDJz4KBvFY3zuKtxYJ35GqObWgPJ3Wq2t7GC4P8nKRRuAnF?=
 =?us-ascii?Q?X12A5QnmATRy1F2+B3R/szLLvmBgzITWUo71fe6d2fxB5qSVEzP9X5liEun7?=
 =?us-ascii?Q?mt2oucKDlowvNS3kQ4i6Kgq59+bB3usSVd3ScFwzZ3pgZf0iFIStoBGNKkj7?=
 =?us-ascii?Q?gOjdx+BAIwj2Ga9gT+a18wRhJqDPtOQ9LikQZBO8JL7/YZXIg8wa7fTj2V+l?=
 =?us-ascii?Q?wCQMk+L3nR/OG57m0doOoVtqOLSP/IagDazPp2S6vZGnnyQ55mTizULNPQs8?=
 =?us-ascii?Q?11kcVXnlA5pk0bc0B0Oq2RtWXrWsDqks5y+f9YGK5xXlj6Atu+upiXyvQafp?=
 =?us-ascii?Q?YrTij2ZiRmYdOcarrWFL11j1+/AV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U0TEp86s4+7HEZuhJtXcKyEtFkvjGEACGLMYVRLvRNEjfYH0iCvob08Qy9Fi?=
 =?us-ascii?Q?cf+4U5dAUWpErnDf+2MqqhHBYbTbFi+F4pNmcuo7ZEl88pfJsHuFi5EPuU+6?=
 =?us-ascii?Q?BadxtzVL50zRzwKBuzZIHtGfxFt8Sed0wXW+MV5Rsi9ZqoFn2psukVlkpw8S?=
 =?us-ascii?Q?R35W/iRKjhQQSkkoI5ok6qOecWwcw7hxBeuG/VLIk4gqvB3d4qBiEx3/WWMQ?=
 =?us-ascii?Q?UNyKAnP6V4hYVubkVOdj8OcKskc6lT2py4iSlrWTegxSDys9cNkIWbk/EhzY?=
 =?us-ascii?Q?vUJIYpt0MTxKlNneG6d4F+plYYl4yGNA8qlzshsab4R0j7azfWZznp8m++AY?=
 =?us-ascii?Q?HowbqCTjiekJEBblJjnkB3t5VXq0g6tU5mOwQaPuz8PY07VLN1RRVpraw4c4?=
 =?us-ascii?Q?YHAU6wbQVN8v4/VNFqku1wGihH24xf9glFjX2NxRyT/i/f4dnGduytWyzTrA?=
 =?us-ascii?Q?ToJU7TFjT+ATdlc7pdWQ5v9qQEAc92AdlC7VTgwmf64Da8xCPTKG63QOhshF?=
 =?us-ascii?Q?j/PV4bKPXp/cDeGOyKUg7cgRxKowfv2S8hsZm+v+hL3SCR5CjyiZcX5XOpHC?=
 =?us-ascii?Q?JmMNXdcA4Bk9+Txhq8LDF5xZuldy8/nNZO1t/QVBVkkIaY7RFKu9K6Ii+Vdt?=
 =?us-ascii?Q?qAAo19/QscxEMejQmo8ENVSrFucXiee45t9uridcNbVbUaXcgDUbYG7+SozG?=
 =?us-ascii?Q?KQj2PetpehS3UgiiRfxMiFxp/5AcF0aVN/SRvUVFtsFUT7SbNd0vYxuZQw48?=
 =?us-ascii?Q?p+uKSZm2+F8Ff9M1eMfC6vMpKbGxD++rKxztv7/GhldOmtozrKtDxumrC9hJ?=
 =?us-ascii?Q?HwW91voJl9OYFdCUw4bWqDJx8QowwrgaYnIsDh1rNO+aWG8omp/Bz5u2fMjn?=
 =?us-ascii?Q?vSfs2nJC2saHKdssgW8Pb4ctwW7qWGPkOVm61brTFumHds3cB/YXOeT+zDBD?=
 =?us-ascii?Q?MfY9U6kN83rK0zVGCJnOeoYbL4iYSXQLU2/254xC4xF2ugV1AuG51dzV0D01?=
 =?us-ascii?Q?uzGpYCvvv5V7Ww7lkYqDTbEk9BRaILPnsczErI36U72WYeH9NV3xwdofFk1y?=
 =?us-ascii?Q?H4OhHYg2ygG1GJeBqm7DP9mDqJO88UiXkeGSKZ1ly+26NBbRBzTdfcHElk9Q?=
 =?us-ascii?Q?hqPLRoMgxAjjCivtsgxot/jwQHyRIJ48q4TjWMU3sWB5vW+pwM+2hI9a5aov?=
 =?us-ascii?Q?WWolilQxsduXXYvkbx/m57FwhMd3S4LRsl3PdRaZpfAk1YML1n8/e4PuJXjG?=
 =?us-ascii?Q?dVnPG/p9kxikq2GtZMNevFA/eG8/2tSCtx5wXqdYdyX4gb/9jYyYJZJdyuup?=
 =?us-ascii?Q?5YkPkFhjFy4CE1E1qsHEQ6heSuEdMLs28OiI9qXJJjFFQjTdrZ86g9jMbzP6?=
 =?us-ascii?Q?UwMUHQAWeAowQ/LgsXC5oAZh7/4QX+YtrfpPdnbz71UjGCN2Tdnv/eAWUeXi?=
 =?us-ascii?Q?do11K16BzKI4SD2+dzlpyPL/KTEXrH+HGrVaU8LihhOs0qXEh1ymIw4GK5Vz?=
 =?us-ascii?Q?FfbhevbGkJnRo4d/91i6s5m2ighJAWa/sLTv+2tQmJNhhJyhbDSL3mP9DWqk?=
 =?us-ascii?Q?UAmGaAtpnRfSKqZk8vDfRDNVZSDzDfP7nwb73qH5A8KyOO5KtiPr6YZSzpDB?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xmGFpGxgUkfD7avKN4nSWNknSF5ZJ5ayaEhFAD4n54bUe0aZTHbds2ul6bv/shIJDQ+BXyG3Qv1yMtXgftXUGcDUulEGoUVWU9B7JIeQLmGl4NlCI+lqVLqwvdfUIhh+Zo+Jic/bWJ7pzSAXkFBhfpvuM8aDmoKXVArlxiPXhaMnrVNzGdBT8Sm0zeVVh59o0+fm4OWD8CcgOxZv3aGGKfEUM6ntSs+MoY7gsiuwfHYZRYkBHqHSZYpoffZ/1KnZjMkbzH3o12YtnBOlb8p3LKo5ixiehFSEFmxYyMZA7ZBt0GYuRkKMOiQGD6ocwYwM1V+mdSDfzd0QODIw7R8GsvNdVUbjxE9zzmllEbvpaZMLNVKH+xRSmxHpkcvAbjrHC15nijlkjpBHMjWhE9confXcvxMxxJqToIcg68NTbLdlW/oY4KbyFN5R3jFZUaUZsbTqCVqLWcYalbEP5RyODykd6uD7p2bo/ikRKaeT36I9VeXcgaeQvaAw8PrQ0F9VqVc4zOJL1GFbSBBNlzGWjsiDJHd0i4R45CeqP530lYuSibmkXPeurfhL/8VwquclKHXCHTAaUcoy3TR01mP2eM7ta/wcupKJbCV6YjHgFSA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50af594e-3feb-457e-7832-08dd5759bcf1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 18:08:29.2298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZvNMWz97TAlCaOAs+03FaiUq9ys+raXLvUiqyprB1dY6h1roFYeJXN/O2CEC8ja+ZrWIHNoYoVCoSN3LVYVW5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502270134
X-Proofpoint-GUID: 9xfI1Ql1FJIn1ymsn2PoN36MTvv3mG4l
X-Proofpoint-ORIG-GUID: 9xfI1Ql1FJIn1ymsn2PoN36MTvv3mG4l

Currently atomic write support for xfs is limited to writing a single
block as we have no way to guarantee alignment and that the write covers
a single extent.

This series introduces a method to issue atomic writes via a software
emulated method.

The software emulated method is used as a fallback for when attempting to
issue an atomic write over misaligned or multiple extents.

For XFS, this support is based on CoW.

The basic idea of this CoW method is to alloc a range in the CoW fork,
write the data, and atomically update the mapping.

Initial mysql performance testing has shown this method to perform ok.
However, there we are only using 16K atomic writes (and 4K block size),
so typically - and thankfully - this software fallback method won't be
used often.

For other FSes which want large atomics writes and don't support CoW, I
think that they can follow the example in [0].

Based on 2d873efd174b (tag: xfs-fixes-6.14-rc4) xfs: flush inodegc before swapon

[0] https://lore.kernel.org/linux-xfs/20250102140411.14617-1-john.g.garry@oracle.com/

Differences to v2:
(all from Darrick)
- Add dedicated function for xfs iomap sw-based atomic write
- Don't ignore xfs_reflink_end_atomic_cow() -> xfs_trans_commit() return
  value
- Pass flags for reflink alloc functions
- Rename IOMAP_ATOMIC_COW -> IOMAP_ATOMIC_SW
- Coding style corrections and comment improvements
- Add RB tags (thanks!)

Differences to RFC:
- Rework CoW alloc method
- Rename IOMAP_ATOMIC -> IOMAP_ATOMIC_HW
- Rework transaction commit func args
- Chaneg resblks size for transaction commit
- Rename BMAPI extszhint align flag

John Garry (11):
  xfs: Pass flags to xfs_reflink_allocate_cow()
  iomap: Rename IOMAP_ATOMIC -> IOMAP_ATOMIC_HW
  xfs: Switch atomic write size check in xfs_file_write_iter()
  xfs: Refactor xfs_reflink_end_cow_extent()
  iomap: Support SW-based atomic writes
  xfs: Reflink CoW-based atomic write support
  xfs: Iomap SW-based atomic write support
  xfs: Add xfs_file_dio_write_atomic()
  xfs: Commit CoW-based atomic writes atomically
  xfs: Update atomic write max size
  xfs: Allow block allocator to take an alignment hint

Ritesh Harjani (IBM) (1):
  iomap: Lift blocksize restriction on atomic writes

 .../filesystems/iomap/operations.rst          |  20 ++-
 fs/ext4/inode.c                               |   2 +-
 fs/iomap/direct-io.c                          |  20 +--
 fs/iomap/trace.h                              |   2 +-
 fs/xfs/libxfs/xfs_bmap.c                      |   7 +-
 fs/xfs/libxfs/xfs_bmap.h                      |   6 +-
 fs/xfs/xfs_file.c                             |  59 ++++++-
 fs/xfs/xfs_iomap.c                            | 150 +++++++++++++++++-
 fs/xfs/xfs_iomap.h                            |   1 +
 fs/xfs/xfs_iops.c                             |  31 +++-
 fs/xfs/xfs_iops.h                             |   2 +
 fs/xfs/xfs_mount.c                            |  28 ++++
 fs/xfs/xfs_mount.h                            |   1 +
 fs/xfs/xfs_reflink.c                          | 145 ++++++++++++-----
 fs/xfs/xfs_reflink.h                          |  11 +-
 include/linux/iomap.h                         |   8 +-
 16 files changed, 421 insertions(+), 72 deletions(-)

-- 
2.31.1


