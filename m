Return-Path: <linux-fsdevel+bounces-23278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C3A92A166
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 13:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898091F22104
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 11:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2998003A;
	Mon,  8 Jul 2024 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WpG0+eWb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WyEib+0u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341892E85E;
	Mon,  8 Jul 2024 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720438974; cv=fail; b=LF7g6JoXtkfksXUNSqGDSL0v1tHQAihH5qH13gGj7S+7wpfa6NVdccWNwMUptxU0sCFZFcAtBHEy0xbQ5TtnAxA8KwnIRrp42qDPSTAtXGkpkIIgrfL+gN/W/rBBZBciBTkP1eGXyQmxxGwfRxzfP+8T7mgTQxTfSddh1nDBktU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720438974; c=relaxed/simple;
	bh=eyZHP5mUb+/5XFU+iTnTIR95nEgjYlGJs2O6ZYqdplU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LGnpkhO3eLjKuMxQwsWiJ8KX7Iipq9BRNQA60ytRRvN1W0d1WNloRoLwTQT7AaWthgpwgQShXlWOYKtnGNRr5WF9xMXfcu76ecStU2knuiaI+DdMUvLoAvKb76bZqbf4btFATbJXjcB+ep6J/EyMekh2FpUdZ0G4Su2fyz54X4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WpG0+eWb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WyEib+0u; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fSHF017369;
	Mon, 8 Jul 2024 11:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=sCHF3MIVR5HjKIMbiEuRSfTCjMYovwBt0xTf6g7SMVs=; b=
	WpG0+eWbvxj4TYFeHt3vMPrffDkBufHlAu1u2sX6W7nQX1ijvShgNffvcBjM6JD+
	VMb+tlNDU3AIHVWg2fTtmgIV4oiekgoI14THE5jhFrmugyB73pMIJudzbfL37rA0
	e2Xp5uBabbBfLiEMZnDN9Ve9NZ1PRzTFqpHJO0fb4wKiSzzsPd7o6Bmo2KykaCZ7
	m1utEYjCXIgOk471QkAlt99YPB8SzfKZiPplYvXbLVPVxdPiNkCL6aLaCGt7JTXJ
	kptVnVEeblXkBkZ/KP8wrt1BgKvDEUHYQt/8D4UgMwkDO4yDDYqlRvZtiKvexHxL
	WjWcaCImytPkYymkXMPm/g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknjdpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 11:42:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 468BCMeG007502;
	Mon, 8 Jul 2024 11:42:44 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407tu1hccj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 11:42:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mj4hzZN2gaVOgRyRXUlPSIUYYS3qEyBWgvuX6JCYIn6lNCUwKW0f0ZdiEyIYuCvwFg4NT60VMUSEj5jgVYnTbQZRmjOM4MwswekhEcQSBysDudbW4neZiHSdQHhKhhVfhQyCL9jw1ggq3999k4ARxLAyVtQWBViFbcDG0Zh7oVtgH0IlLNyBXc24ywXAFPUXoFomdUnAMD859/AqraJ5mNotBoUGsiSWKAqyDhg8wj+HRR09HZjAWFqGGgLb+aiIcqpdKK/DUVbD3m5yFC0IR1eCNexfAL153JQvrnTMbwT3/8R0g4werRELlr5RP6JV5sNQCa015sxIzPTBUPxt0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCHF3MIVR5HjKIMbiEuRSfTCjMYovwBt0xTf6g7SMVs=;
 b=Z4zLPUzgxYxOPfJPA5Cd+dO9wYa6RT1sOUIvsDSWiF2kvyjoYgXxnQCS47iynLdNGrdvqDVhP+M3qQSOebtyT/j6iylYuTMj06kcW1IAE21kXrtmU/CxtCAroM912AYBg8tjV/F/DKk4VbMmPl6RIFtXMDpud4NIwSb5/Goi6X2BhFnqed157czhKzI72E0yy82yHmLH6xgbl0KUn5kWKwJ5cMJBgNYnriE7+PUCFKafdR+WV9egjvNfqYyedDvume1ysrp1Rj5FgXoTak3hrGIyW5q3PQuOxfT14me/WHX4N9Nm2GIXLW7bmAm6mmH6r8UEyFBgSFiV4WkBX7GO0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCHF3MIVR5HjKIMbiEuRSfTCjMYovwBt0xTf6g7SMVs=;
 b=WyEib+0uTWXpbZyKrywuh/A29oBWIazSJfgFlGEccHpMGGGcHen5FGLH45Xk1EAyjQ2lFemiFveVb42xylM/U/YWZsoNFKAiAeM3RW2Zn1+QPInnWI0GUJffksHmTZDih3MBVd5PsM4WLQnC4GhnLVH1i4eJOa82Tb2Qj559Tx0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4454.namprd10.prod.outlook.com (2603:10b6:510:3a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 11:42:43 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 11:42:43 +0000
From: John Garry <john.g.garry@oracle.com>
To: alx@kernel.org
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        hch@lst.de, djwong@kernel.org, dchinner@redhat.com,
        martin.petersen@oracle.com,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 1/3] statx.2: Document STATX_WRITE_ATOMIC
Date: Mon,  8 Jul 2024 11:42:25 +0000
Message-Id: <20240708114227.211195-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240708114227.211195-1-john.g.garry@oracle.com>
References: <20240708114227.211195-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:208:256::31) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: 77b33cf9-4252-43d8-44cb-08dc9f431435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?SSTxjSLSB3D83Am88Wl3xNc3Dm8i4f6IVFLWUtx758varlqQ6LvsqU2V6G6R?=
 =?us-ascii?Q?rlxXfnvv3/OIUpLzp/gteMMeBEza7k99btFTPc0p5KU+XzE+RhaMd4t1POj3?=
 =?us-ascii?Q?t+A2v8tHf+foY5X1Fnr09gZOMKb5JurTWX65ocEK2STTNiNLqKpYFHpAgpSy?=
 =?us-ascii?Q?aif8eVizf+CNEWqAc2gqr2X+F1nAUM4Jr98UNgDzwjigLSf4qATp6Qi9NW3V?=
 =?us-ascii?Q?184rCSa8ew21rZ3Mv/6vzZ0im+q6AZ4DwsDivmnKxZbhCe6naJf4EZiEvayh?=
 =?us-ascii?Q?8QjhloySul8j2Pz3l+nWVP8pJ2MJdN2gnx3RUmNWbnNcN98hWwZkgLsN5rx1?=
 =?us-ascii?Q?c7O/e9yhm0DOd0SnD58OglNXeF18LcOOBAARXBouLFPd4zVo/IYPBo2VmxZH?=
 =?us-ascii?Q?MMrNdudPzl/voROQ4uQOAMUdV9gnOeW18i+2co5t1sMP/jdHEejwrO9YxP5T?=
 =?us-ascii?Q?EAwCK2NLcdSLhtppXpHQmbLhB4Rez4tv0AnRKrIYbZZuWFmLNP84N/AMUgw8?=
 =?us-ascii?Q?/F4StlP8dBrtldM6UaR6FLmVRBWqzGN0sJQQqD5Y1GPqsf5CWui5B/we6xU1?=
 =?us-ascii?Q?vmnaUkJWzdrUxxRHA6ZN0FXM8XRFK1ShRGxDZeKNdnmHrAH3YT9hMiNQtta/?=
 =?us-ascii?Q?QMnd+QP3gSKxOLo6ODoQeoOz/czClWajWyPWmyMD6rjenl+VAnXbZNWsT03c?=
 =?us-ascii?Q?Knpy3Jspb8CJHUhhOn+0Ibbe//sY374XnK/MWeqBd8ydccuT7/McX57B4gC1?=
 =?us-ascii?Q?b6orOsCeJw7XcwaPAavuuEwyZMsdfz7OVXHkqkqJSiDoQ8rMhjxIrdn1cAfT?=
 =?us-ascii?Q?yNhDRWotWcbTiDUMkn/R09XqKg3DPd5O0J9QPzVrYqrgqW0yckHZOgZ9WaEQ?=
 =?us-ascii?Q?jz1ktTaWSdKVVuqlU4VD6LBli11hE0TsptyXh/Hc68Mc6f0YnDEewe5xEl9P?=
 =?us-ascii?Q?0M7N0odu1VDhYwwgkF2ES+TEHV61is0f0JZV6nflT1sckxpdSdY5kD4q/Y1o?=
 =?us-ascii?Q?D5YbeoCKF1tQAYDqhCc5+t3O1JKCxqGB42gjv0EBrGb1HGkB8GuUs8Epzuy3?=
 =?us-ascii?Q?W+WVFHOvgDFW1gDVgYT6wYFY0+4pLUfcwL+9a70wJs/k9A1jRdNOIkMEy0GC?=
 =?us-ascii?Q?vYqhDgnXNAjTVokppx0lVYsgFkMWkqySfOVMpcfehtTaD2AG9DeQbWYjlejp?=
 =?us-ascii?Q?CpA+O+D91LRSsyawBwfzAFhrJO8IqPL9Wwsmlki48zHb3KIAs69hJgjr0EZe?=
 =?us-ascii?Q?6HQSX+C/uU5ktYlry7ITV0aMkUnpMHj+/KCDU9z2zm9/Hx+1ZM1s8q41FFAn?=
 =?us-ascii?Q?4H4v2OWsqvbSeocqZQd1Y7prHAR1QQNiTkDwm/9qvxa67A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?H/8mbYcQFqXoXXz4JPXYYdw6J4diKmZS/AXl1hbca94dj3atp2UXqmuZ6h7G?=
 =?us-ascii?Q?EpYfob9I3NiUWOc1uqTvLBhJf9TsB5Q4+94Wk5UJ3fyT3dGLt2rS5WQ5l4m7?=
 =?us-ascii?Q?Ducy8Qq9Jm8ViXAhCixN2bgd0guoHvaidS3gNBE5n0yKxtE9vAxWO81RsTe6?=
 =?us-ascii?Q?jPAcUBr+2rYpIa7KAabvgodtlRCI5w+4/UmqCG9520k+eiPG0Mez9+yEgxLy?=
 =?us-ascii?Q?boVtOucupeyCQGSn+ANf86OQfC4HAq1l/0cI4uuNfgwHeeblEJLAVHZjB+i5?=
 =?us-ascii?Q?QKUVxhSP7TiaWkpqkdVhUkshHEgjr1mf6PlaTSwnkP+qBiG448FQ6yo9Wq7H?=
 =?us-ascii?Q?RznPZQHC5xftE8ggDxA1oGJC6vjeKUPD+C1SlBb5qTty6KQxQ+/dZ+YrJb6M?=
 =?us-ascii?Q?o/xIGv9XDzXs6cWMjdS9Eb3D3JHt730UJq5VQdctkOjYAMmXx+qZRLthKI9M?=
 =?us-ascii?Q?qZ49GN0ATTtzqlq0Upsrnfeva3HRs8KY5bvj8Yuq6qFGdJ7sCgwgUMzkFO59?=
 =?us-ascii?Q?AKnMhuYD679Yxn20TWlWxNBVG5L6y1rNv1O0T5XAcBlVWXD0BqoVuvT7ymst?=
 =?us-ascii?Q?1oMVEVO11z84K7AAeT1+O4fdCFgTxMGRnTxw3WrE365piw2/BzShuFdWM7/U?=
 =?us-ascii?Q?aDcq0KuBTdSqCxtkFUfa+sWDpEJePotsIJgiYDgdIEOnyPBIiDCDg2birBMb?=
 =?us-ascii?Q?q6iE8TOVksXruvF3+yUbenyEYhy54mdFSo9A3hzwYvt+WPaTsnpnDK16E74d?=
 =?us-ascii?Q?TGNahq1a9nR5g54ViFE1MZfqxaWUOR0GB1D6FYkvgnq2Ug657ij0A/u5IfOU?=
 =?us-ascii?Q?mNDy+WRQ41RZduBMUkte31Oz/URUIg28bJOUCodJ4W5GTvic1cuIAWHxqExU?=
 =?us-ascii?Q?2RAs34ku4SdZVQud9T6k3glZeNOj3/4jXfgEBvw+TMewFsjGxZnh7d/iXg3k?=
 =?us-ascii?Q?xGIpm9fJat6HwMcnoEirdc9hbG778ZOp06++fXjnhfidHow/sggG9boy7kiz?=
 =?us-ascii?Q?hrSzWHZTMcBv2a/fiAF4Bgwm8Lz6ubWFJfDLlfsC2Br8kwWt0nT/21RLYxHm?=
 =?us-ascii?Q?oXGI5VCqmAM0RAaGdjZiJBq4/TOLZblyRcRfZKftIpi1kMs9EG36Isct+q1w?=
 =?us-ascii?Q?14xu2NUSF7t8Lfg310pcKGUYbqF/9RQzPH3faEuBvgxJEaJQlUVEeLJqN+hp?=
 =?us-ascii?Q?S6MPvPZtAPu2KhEor0/037D6a3d6kkGGlfV0DNN95Etiqt+BfCHZZNDsVePc?=
 =?us-ascii?Q?6XuxK0UMLF5njbmwUNI8nH6s7LbMMkyi2S/EoyLlynHTylCq/+HmHf3/lpX1?=
 =?us-ascii?Q?f1AvE+Bn9GYOodK5Mvb6sZJFdS/SlM2y3JdRN3csVyob9KnC1IOz/I6BDgRu?=
 =?us-ascii?Q?c3/g930cAiEBd6DbMLNppMZWUhDX6VQvckmmQdRdkmH2gy5nZfJDQZEEH2eV?=
 =?us-ascii?Q?VZGTuSn8pqGhKjYw1ikyZ7triqHEqJtsZi5B9fpN948yga4gtQwiKznwGuQa?=
 =?us-ascii?Q?355vVryNxOyDnoDdDCcH/nVzplSWeIAGqmBloaXfjJwts/tM7M3AvuIel6WF?=
 =?us-ascii?Q?+RSW/Z4/A36gcL3ANwvhN6sC3AJnOfpWs02C+lSYR/Ao1ESVpCCM2w8EF02E?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wET4qFzjbFgnLjiTGoPW0xCD6zI9Eodi4Dus4w1tJsccv7yJqqhOhHj12MGxLFAXa2x5mLEH4pZrfn2NB1A2zGC4VshQbkIensyp7D8kmfT9ZOP/AVyGaTamisoyZJUE2aVPTfCi8k5To7UgOVI3kKdxDkF7OPIdV7a0YI9hw/Ffxo/oG2YixR64hAVsDCzVIQ8pl7Hecxxqml0heyUJlPp0wO1BEqqlQXPd/NfMU9+eUL2BJzuJKrcHu99lQG5DQw3rF5eKviAp9+PGSMOx15319dVWiqCGXTbY5x2KvMk42nDawaqAsLTOrAWKcQbzbSP8CjhDLy45/7NL4QpmLyyBY/NbLyKyDCDzi9J/ylti0hs85WCVSHqcyFJB+2YmOzUb+kBgBcBA5Ea17PLtXbFOJmgcV/w3TQCdqGfgQsOiRxBTJhyHDrtW/khqLOY9kqsTtosM5QmIvRUWGEzIO1fdXPHAIut0R4XAwbnyRWA4FTQqtmAh9zLrCF8F4V2Wu6jZiH9W4RFJTf3PEZENmnrWfqWAOhOUA998yhMCuqvLD+D49fecJE4QgA2xs1F2W+ulnoqPSXs0f2mtBnSwPM2W/rg7ec6IVWz1l+i6crA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b33cf9-4252-43d8-44cb-08dc9f431435
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 11:42:43.1278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r65Yt3z81yd3llZVz65MvBubGL9RPQxZedFlArb2acsoNU0LNy28XgeCDdr5NB8XGNxREIjm4CrFS+NfTtyxxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4454
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_06,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080089
X-Proofpoint-GUID: Xqwrcl2hpcXCXo9AJVZbrokeCrU1qynO
X-Proofpoint-ORIG-GUID: Xqwrcl2hpcXCXo9AJVZbrokeCrU1qynO

From: Himanshu Madhani <himanshu.madhani@oracle.com>

Add the text to the statx man page.

Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 man/man2/statx.2 | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/man/man2/statx.2 b/man/man2/statx.2
index 3d47319c6..36ecc8360 100644
--- a/man/man2/statx.2
+++ b/man/man2/statx.2
@@ -70,6 +70,11 @@ struct statx {
     __u32 stx_dio_offset_align;
 \&
     __u64 stx_subvol;      /* Subvolume identifier */
+\&
+    /* Direct I/O atomic write limits */
+    __u32 stx_atomic_write_unit_min;
+    __u32 stx_atomic_write_unit_max;
+    __u32 stx_atomic_write_segments_max;
 };
 .EE
 .in
@@ -259,6 +264,9 @@ STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align
 STATX_MNT_ID_UNIQUE	Want unique stx_mnt_id (since Linux 6.8)
 STATX_SUBVOL	Want stx_subvol
 	(since Linux 6.10; support varies by filesystem)
+STATX_WRITE_ATOMIC	Want stx_atomic_write_unit_min, stx_atomic_write_unit_max,
+	and stx_atomic_write_segments_max.
+	(since Linux 6.11; support varies by filesystem)
 .TE
 .in
 .P
@@ -463,6 +471,24 @@ Subvolumes are fancy directories,
 i.e. they form a tree structure that may be walked recursively.
 Support varies by filesystem;
 it is supported by bcachefs and btrfs since Linux 6.10.
+.I stx_atomic_write_unit_min
+The minimum size (in bytes) supported for direct I/O
+.RB ( O_DIRECT )
+on the file to be written with torn-write protection. This value is guaranteed
+to be a power-of-2.
+.TP
+.I stx_atomic_write_unit_max
+The maximum size (in bytes) supported for direct I/O
+.RB ( O_DIRECT )
+on the file to be written with torn-write protection. This value is guaranteed
+to be a power-of-2.
+.TP
+.I stx_atomic_write_segments_max
+The maximum number of elements in an array of vectors for a write with
+torn-write protection enabled. See
+.BR RWF_ATOMIC
+flag for
+.BR pwritev2 (2).
 .P
 For further information on the above fields, see
 .BR inode (7).
@@ -516,6 +542,9 @@ It cannot be written to, and all reads from it will be verified
 against a cryptographic hash that covers the
 entire file (e.g., via a Merkle tree).
 .TP
+.BR STATX_ATTR_WRITE_ATOMIC " (since Linux 6.11)"
+The file supports torn-write protection.
+.TP
 .BR STATX_ATTR_DAX " (since Linux 5.8)"
 The file is in the DAX (cpu direct access) state.
 DAX state attempts to
-- 
2.31.1


