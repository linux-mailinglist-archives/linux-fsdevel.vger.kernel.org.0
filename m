Return-Path: <linux-fsdevel+bounces-36352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0CD9E2024
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 15:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32F6816540C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 14:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF981F759C;
	Tue,  3 Dec 2024 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YbiWxR1S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JLl4iE/h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAE01F7548;
	Tue,  3 Dec 2024 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237665; cv=fail; b=nFGa5RFLUH/KbOLvYuZ/JETDswyS1Pk5LNEODu6PERyODq0yP9TfuhJB+ZNk1YfBToi0K2katLmAZ8b79LPs7FVjo4z4Vo0RUMUskFmushc4jrkrqlUT9oJmk6ZDPEKV/Clhnlx9izubD0Y1VYse6o38dtJmWCoBS5LZhOZI3jM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237665; c=relaxed/simple;
	bh=gIDuaWekEoRD0/MTdHcT9owBlvQhFg5aIDJ0eQ5ZbHc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WRJ7dLtXKyaUqucYbIj/6LBHZSMIGkTMSGVye0encN9leigSRWMpJVbvotiqyh5oZmYKf8/SYBvfbJTYe+S2NXBmOfYHBY6scrWFFqgQdIgapzEdtLZ9ayhVef+T4T+IhEnFyPFvurKSvfd09jrm3G/jQFLRjWI+logx4eGELE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YbiWxR1S; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JLl4iE/h; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B37XwwD009983;
	Tue, 3 Dec 2024 14:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=LT/9EKqpaC7jrWtg
	EjvcbrT0zkOOOVKgZ2YTGNRZMJs=; b=YbiWxR1SXqNXXM+5YMMMVh32YxDLCa8o
	boysE0nwD0EHhsWvmz25S0v6CqA8+BbEswzeeTvEWASV4k8N3oLV2tr1kWuKjbFQ
	yTpyUm6U433Wr9G2JstIFdb56+h6OG9HCm6QVDpmMYd5IcJ2vdgX7kOpqLy8l+kj
	7G3/iHJIaM6nNkL9lBZvXGG/XGTU2ByvUJViujbKSz97dNXvFIJkPg5uBwg/cARu
	WTpaZDbdASsjUuP5y2h8mlJ1iPHn2/BxZcTK0znzyLZ91dtleTRo1SS0b2VSUIEs
	ZIefuwCUQC9+EGIHS0dbOPO/u6QQ6HLZpqfZGrzV8gEPHy5ylcpqJQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437trbp9ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 14:54:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3E6SPU000974;
	Tue, 3 Dec 2024 14:54:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 437s582qwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 14:54:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zf9COgBy817beU+ZdfbTY5Bgoefnw0gQXgNdjd0lhDpnqlnU0jJEVuLJ8XZ36pVOUJs0rYlb6UXFkEajNnkju7kUGgCk5OAy/ezo1Uap+F4ncXtT5LfQ08+hI8ufbyM3/5poA82/OzcgMkn+MRtJmwNqvWJIWtl3bjk9pmjHyHS3bBnqW0wJt05rpYAMUC4H2QEnWkB/eckRhdDIChGY2TAWau++md+Dmlma12CRYQpcpi7OcjpMXfnABeZP8/f1U853OOu/kpcN930rc3kgSFZbosY12Go6zfYfj4mwNBlLHjFyz4KNyor+JJPvd8f5pojfxesQ6jw+SrI6msqgZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LT/9EKqpaC7jrWtgEjvcbrT0zkOOOVKgZ2YTGNRZMJs=;
 b=SV4N+jqnese7skGymJSjEQGN/h59cKnbh0L2DNgY0kBxZRavHJdwHUE+nLD9hqMsgOblu2FP0EP0FqVvBhNNeJOjByzg0vrsTQreSoCbPjMjh2suoTSs2UT3To+qpzZ7gEa1yw8FzMFuwAqZKQTYOQj0MEufO22YN/tuRKn79k0pKFhQJdX/ovxAAJ4yWOH+miHPldTcf/YNwTlhcukK+N5hEyeZwQOS0Kv64dfWn20xrhVPSo5F5z2xoYTQJtr1RSdwUDHHgaUHaia/sILaexi3RtG0E/ipATvHPpEzi/hdh4ePvwUuGs2mQsP5IQrTPC8YbMBiSnYVeZbs3IWl4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LT/9EKqpaC7jrWtgEjvcbrT0zkOOOVKgZ2YTGNRZMJs=;
 b=JLl4iE/hQrxcfKdtN99nNEvQUZdlf6bmsnmhkXd4VdeH7PA8O90PJ3Vv8icmkwRuobUxA9MwnvRnGWA2YiCmSngUjOucwSwYWJxVBwYH66LJYO3xMV/0Pylu/0p6W9MRDIksPzT1fy5LPvd1/70IMr67lypA9k6UiTdIkeK+ULg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO1PR10MB4530.namprd10.prod.outlook.com (2603:10b6:303:90::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Tue, 3 Dec
 2024 14:54:07 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 14:54:07 +0000
From: John Garry <john.g.garry@oracle.com>
To: alx@kernel.org
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        djwong@kernel.org, ritesh.list@gmail.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH] statx.2: Update STATX_WRITE_ATOMIC filesystem support
Date: Tue,  3 Dec 2024 14:53:59 +0000
Message-Id: <20241203145359.2691972-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO1PR10MB4530:EE_
X-MS-Office365-Filtering-Correlation-Id: b0939725-5c4d-4527-b57b-08dd13aa566e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8eHtOcTHeEPk0GoeGJ7UoRFhxh7BmNzqE2PXN1d7MKCmWr2zDQtGS3/V+lCD?=
 =?us-ascii?Q?1EFwYQtXEq5gbSxEoIrvfdVmkasypx3f/YjbIX7npQe6LhbxBAzZbh9CT7/H?=
 =?us-ascii?Q?Q5vYf/C2RP8xvsoRfIrSZyDrNgak5L/0mQH/OihTulgPhEeG75bF0VZn7YQJ?=
 =?us-ascii?Q?GtNMxxhSD3nKc+dmWiGWV5qYDqFJp5Kmz89ZXQykiw2eO5JcvEswHs/R8USJ?=
 =?us-ascii?Q?sqeiWK754+mzPmd7JTgnysQNhSEL9+/vd+4Lgi0kVh5cGQ61mtsWeFmwTUgh?=
 =?us-ascii?Q?oSFobRNmia3pu05emMUJTAWEpUDoTwS9yEu/4JGUNbHCMEKl+DjrLPkayd5C?=
 =?us-ascii?Q?uvGkzgNtnj9fucwrhiNXv+5r05mZbzsWkAY3GRdszgwJ9HAgbdIF5RoSDlrK?=
 =?us-ascii?Q?j6nx0HpJwXswJoga399ixzBcB3+eKcKvGFPRUzyrMRG7Bnc4Iq7wT06CyGQE?=
 =?us-ascii?Q?pkcdvY34QFpt5GWrBBGAMHybn+JmTg6d45WppKI7hgCi77ON3facXZaecIZw?=
 =?us-ascii?Q?ZlI2rQzplkXJv9VyCFBUxzUaQjri1a0hdI4E8z6D2RSeHKImXe3zJzK9gToX?=
 =?us-ascii?Q?b6DaMFAcNoocqqpcz3ziprgyR6JTtNXCgJ6vl5WNDsHxiZGXMTiAs3vgZUF3?=
 =?us-ascii?Q?1pXBEZ3XLjxH7Ej9DZ3iIh0on4Q9grZJpte2NlJt1ddEaRbR2hevBAHCAyrD?=
 =?us-ascii?Q?fRXLZKPjZ+p75FqKjE6Nz+1+bCfA/s8wJCu+WVO5u1nf0S/7ZARS+JQ+pkvZ?=
 =?us-ascii?Q?kPsQLYh4OHe13wTf5fpoDmN1Bv/G9Wfiy+y6EYuX+lhtd/gE9nptV9lUgBR2?=
 =?us-ascii?Q?pSbpk8NxgxJpH+R6EDIA5LHPA1HyU97nTcNmRTMT4hgu80jjhnup+Io6Gadw?=
 =?us-ascii?Q?aeB/OLqN0pCbe3VMpNbau1zzDcaA56qE5+5lJQbruCVLkQPXTfHX9ObXwBI4?=
 =?us-ascii?Q?Z/k+nqVXTRAmMJXRDZ13DQXyckOBrQXv1s0E3bBZf/byIbAPi8l+r7pc6SuT?=
 =?us-ascii?Q?vgwVvOmMxJLcRH9F5Le1ZzkRzTVywShJwaTiBSXDY3Djkr2U0KOgd2N+rK+0?=
 =?us-ascii?Q?7gTg/ka4YUgMyVUqQOawlRk9IGEQRkYIYdooBHyh2xnAB+y5bsD+fDCK2RYo?=
 =?us-ascii?Q?bdyYUusWz7ziOfqoHeQZOlPTdtxbebtqZq6hJEXIsQ+So2aesEnWXaN5wk3J?=
 =?us-ascii?Q?FXIozkdWsMV/e44EbJdRc5WUjR4Dnyxa1SYhSytWPeYDrxuOjm3T7clO+kzk?=
 =?us-ascii?Q?eVjTEh0rRW7npzpta0xkK4LdVNPv73nLM8FbtHcQifxii+8hACTLGGKQVroX?=
 =?us-ascii?Q?dDS46knhRMhVr1szJCwt+CUGiE7wVn0SpjXjh16YfMr+VA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U1lCvqMt/Vc7kJy6o0YxpmPH6V3mPXz64lBcZLuLBm6ggW4aa7vfUs9V9zdB?=
 =?us-ascii?Q?yFbhv+vZKVV7PCPUTV4riuIsbgcvBoThufv228AkxtN5t88kBURy0fNUut3Y?=
 =?us-ascii?Q?GzyzSr0YPir0FNu6m1Q2mgCS2aa+aPec1xNmVEsvyIXev3bfMcoMZADMZIsm?=
 =?us-ascii?Q?9wmgsZe98CUsOZfMr/jYBHFbkQxtMbBqYBKPsyQ4AwQmSdEQy0Y8WlDVmDk5?=
 =?us-ascii?Q?vVRzCsFNwMCbzCqm9gDly9KX04dH3G4zgaeM2KHiDwyx6OHWwqSS23zC7viX?=
 =?us-ascii?Q?6vcM3i0I16JB1OYb28pkntOFNAyvh/a8+DZRh8/mPHPhlECHx74XCOFhwhJV?=
 =?us-ascii?Q?SPEN9WzhjJfgMOypS97lHWNeOJbCuAOVyeg6NoccH+sjtcPOheIMlFIvelP5?=
 =?us-ascii?Q?lMBYmzkNfVaY4UaaqfVRX1bPazUVf1Qj/vHcHY3cEVY9fQxBhfdyguckAIhg?=
 =?us-ascii?Q?d/AzBFOfgw9q0suK7t/n4NMbYzbmDlgLi+baaN2ad620c9ZK2Jx03hZwBVak?=
 =?us-ascii?Q?QKDryvk+QfPSUth2hUZldFewwCsSu6R0XLEwZMyTLSpz7emhmN5njqWBs+dv?=
 =?us-ascii?Q?5T+aXPfFpjQVENHcBFSoltv0yvdBX+YXgVssRzUR/0xtQQVGBfrL5CmQz5+w?=
 =?us-ascii?Q?j7FkPBfsVwLUyI6sbf61sNt+lKgtceTkxq52oqbAesE5UjNUgrfzvgrt0R6J?=
 =?us-ascii?Q?M3q8NCwe0IxbBibDHcX+jGab9QZ4E4KcAAvHLnw6X7pDrpj91KnIJNa5baXy?=
 =?us-ascii?Q?zr6Q1LbGkXSPCL9XwO4ovapKgB6tm7VdF77twfhgqb+azK1emOG0IAANDw1G?=
 =?us-ascii?Q?9qnefH/BxkvTnlq0JklUBU2QFqfFKflnSbhmnDFD3xsfcVOHaJ7tewP2BbqB?=
 =?us-ascii?Q?dNlIRQ31j6yCfPomGH+8NsVwqgk4OZbDUdeX2eZs6od1cRQi9YWe4Gb9co+H?=
 =?us-ascii?Q?LainGZopHG9tSJlmW3wb6fENYZDNTXZfH8jFkiQLOpvPLOtgHY8ql7dC/Sdx?=
 =?us-ascii?Q?EJB5sY2XJguMsFKP46E98ljtd7sbDEORv7RstyrMXpr8fACYt53OduEHD+cK?=
 =?us-ascii?Q?nRj1bN6ryq0upIZZBDdpjpfxQtJehESi7OcvlkNWo5KZBRSo34AG+mHSeTb6?=
 =?us-ascii?Q?nzdrcKpCwAHmV8950KpyfMT5+ZxrWFIrakkprNH+IVVNtXamtVXOwe8YysV0?=
 =?us-ascii?Q?7nppca6aWlaWgtLyUJRqgyua80znzP7VCBJSi1N29fJNdy2eEFp6C4gis95x?=
 =?us-ascii?Q?iX6QFARGBozW311FL1O1kRYaiTJkosF3bkzqef8YQhFW22HwEarGuEBa24bF?=
 =?us-ascii?Q?xJNg/3dKhoBLvGtaW2bJrURLJtUSimQBdPzIQ/YAGys9n/dcPfW4uVfJ3ZsK?=
 =?us-ascii?Q?Q/h1YonN2SKIFNRe+OSZDVaUkR9z/+/udSnmXnb928drb1WxT9Byos3p4wrq?=
 =?us-ascii?Q?uLyrFnhG6iglDhXmk488CJFEi0OgnycbGdrP1pj9MIKjgV62rnH3yNz3udDf?=
 =?us-ascii?Q?xHX3ig8l5VgYoBIqKd56uhAakfsSfBhZcx3v9OESutiAsXhXMr3/IOVZHEvs?=
 =?us-ascii?Q?mQGpsyyg36XexNgcwyV7VK8vPbWxOaHpje9+Flx36AItg6Twz/Xt/aSQmtXu?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HHmwaEAUaXUWU3eDDSCF5f/miNW1o+bxCcoeWD5Fc6RNdPyl9JkkzPZV8ecbZhdbB/2iY1WHFG6I4dZFc1DhyR2sPHFQ1DxHpdFgeWt94t6mv2hN9FdwZwo/25ekDQmLggIZ1FocUgVngZ//tx7RWKg9DMM3/nvJ1hs8NRNFgasDhRqeFQS4kjZk54tN+vfigvhXKHjMZX3qyvs/r1c2cJsHDrSiBFAUJQy8lBY08PlEn55mx9XHMSjHuNDisEVv7/SJApP2lr+uMazup1YgSCYnMf6fhTFCmQ9zSR8ksmlvpiInP6YZ1zLW233DhP5Sqv5SeKRD7JyEcgj/1txjflq9LgssTlQEOmifCr6oxTMc+ZOZKaO744XhhsV9ZTKTpwom8XNJlVqKJtPyPgf8a6Ykq98jQGkHg4lAK6EykW2AJiDqtQ4OtuCH9HZA9kH/UTfn2zu8ixLGpIGVBXbhwFJdl3yg0nVghwDgkzB3cR3DO0BH6gWXjWJrtwLabcR4ow6XU6sqCpJZLst7jCQjOzMueuKKIXXt6F47drw4wOj2o5x30Xxa/m2UF09KVQ8W6mKG1IIA+Bx4Y9ccjA1GzGcKiEoefd9BNOF7rcxzBnM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0939725-5c4d-4527-b57b-08dd13aa566e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:54:07.3283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bP9yxpW4vER+Xt8MEEH/9GOTRNIMtTYLaV9PBze7dWAWkAQSTc8cQbDE9eancIYUD+09yiyvnxhw8d1o4/ubDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4530
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-03_04,2024-12-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412030127
X-Proofpoint-GUID: Qe8rzkLW17n1gL-MQmrRpoJ1TKTj2OMf
X-Proofpoint-ORIG-GUID: Qe8rzkLW17n1gL-MQmrRpoJ1TKTj2OMf

Linux v6.13 will include atomic write support for xfs and ext4, so update
STATX_WRITE_ATOMIC commentary to mention that.

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/man/man2/statx.2 b/man/man2/statx.2
index c5b5a28ec..2d33998c5 100644
--- a/man/man2/statx.2
+++ b/man/man2/statx.2
@@ -482,6 +482,15 @@ The minimum and maximum sizes (in bytes) supported for direct I/O
 .RB ( O_DIRECT )
 on the file to be written with torn-write protection.
 These values are each guaranteed to be a power-of-2.
+.IP
+.B STATX_WRITE_ATOMIC
+.RI ( stx_atomic_write_unit_min,
+.RI stx_atomic_write_unit_max,
+and
+.IR stx_atomic_write_segments_max )
+is supported on block devices since Linux 6.11.
+The support on regular files varies by filesystem;
+it is supported by xfs and ext4 since Linux 6.13.
 .TP
 .I stx_atomic_write_segments_max
 The maximum number of elements in an array of vectors
-- 
2.31.1


