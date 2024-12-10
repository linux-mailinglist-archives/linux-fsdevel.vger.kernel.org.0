Return-Path: <linux-fsdevel+bounces-36934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A74219EB16A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 13:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF500188117C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 12:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C164F1AA1E5;
	Tue, 10 Dec 2024 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ScJ9KeGm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jna6dMYh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824361A76BB;
	Tue, 10 Dec 2024 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835511; cv=fail; b=IwQ7jTs4zYk1FUD1h6G2qnQGo9CIV94U6RTlbRe1MPSTL6MqlZZREg6FGlgggL2OADL91ZAJ8UqKsAn2kNyRyzt8juiX/MwwG//x+aiEDMNJD+EE3QSeUmymbuCVN+7Xn3FMbR/n4SYUktJ921paBJG7epLBxNZOxiXbgqiH5CQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835511; c=relaxed/simple;
	bh=6zfnmFazEqBaBWIRgVqn2WJ9JeRsqdBhAwUf1JTLJOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cynlk8AkA9SpROh2kwaUUJ4UduJtvMFG9OS3OEBIK7Vtm0ywuN0y8UtMonesvjIxbcDlWLV+E4dMQtSgBIKdNVXQm/baIZxEwdml87xS2x/qStAGBI/6uCPnieXdkYQzL9UEkFWyjuML1vW5cF31DB7QMI+pGpOyZTsbmGpA6JI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ScJ9KeGm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jna6dMYh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAAGnl2010604;
	Tue, 10 Dec 2024 12:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=raWm6UgFAyHyqDYUwti3udy2SJevCJIf0CNPaRhdAsc=; b=
	ScJ9KeGmuGJeAZeS8Etx6OrPbLvtWwZkmGjifYe7NuDADP/mjpqs6CWuLnWDMso3
	CB0j8VV/eNLrY1KxjWfxTvk2x/uOw5ZcndggP7CymXfof8oi24HIa80oYAbxO94f
	eN/SG7czfFmEgkq9YpFo+xRVUVtYHOQT3ftJ+IERPx2HlVGDzpNKtz+9t4RWQwvf
	/nGKTGnhjWh3ZN9dUkgivQiOQJ7docITrp7aAKrpaBEwW67HLqgSPelgaOuOmh+C
	oL2yv7EHUNCFbNVXo5d0uA/p2eRxeuEzoWjJkQ7jTivMcn/b73vHL6UxwWCvXm36
	t4jwBivxGDpHb26dtgtYxA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ddr63tpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 12:58:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BACXpPK037949;
	Tue, 10 Dec 2024 12:58:19 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43ccteumy1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 12:58:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSumkScDlxZ92XMTILrELtOS5/WGYxiJkDdCYUVbW+ljWy0rFfiMOlw4pOAg3CGXrKNUZfAss7DHHnXXiJKmUwkbLwkd+CcisGLr3jePe7YO8fVurwo4KSLnfiri0/VslPsqbkJ/vDDtL4FZNtQFv1wVngMK5rMOFfr0r/C2fECVNicGYJT671LuJmenRILs6VTyLHbTH/vChrmER/wvbFskwv3yVbMNvCh5rfrSoxeJlc7+O0WF2IiMt5Ks19HswRfW7K5rk9boQ1qo2p/H5TxK4UCMFFVJRk36dzErbgnDM44IjzeXd0P5WazDmaGP9zR4SmBMRIzJOB1U4hr/cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raWm6UgFAyHyqDYUwti3udy2SJevCJIf0CNPaRhdAsc=;
 b=GKJ2AymPPz9wMKZ5I3Hr/D9RL2bnw8HoSV6Xjsg687U6UNUkm8sizGAb2JPKy7/VHiOYmeS8sgR7eL8fuYV3Pb9tYvKprD5zQwkvOMz9QhJhg2o5NYareMDzKBtDlksK/WWQ3wSnlCpHAT9Vr12wpooSCkyG5hyUugcmwwu8t2cugTgv+rP0nmC3pNG9nQBoV4Z/jh7iYtosFi6eoaFhv1CmgoQ6g38th5/ZW4fsPtsHVJRUJE5wHcKi795KJxJAAMbe1g1mLcXkWAkS5merfByAGj59iyLo60sHgB+C9OpySj/hADZ7k6b8VrtOV+b5nApWGapHxupyb+7pmMZt2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raWm6UgFAyHyqDYUwti3udy2SJevCJIf0CNPaRhdAsc=;
 b=jna6dMYh0QGym337SdGNoDNkpePp0CxAcjX9xU17klsG4rr6E1fWIgCGdDCgJidXQAiutc0wSbhMJuBt48qaHgV1z2CERbyUmWQtUgT+GidXTCUnSpeFX5dWS6YRVkBalZOVKvnp4qWGQKh284knJyEv7LmRGGjihEMxGpOZNQc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4669.namprd10.prod.outlook.com (2603:10b6:a03:2ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 12:57:56 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 12:57:56 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 2/7] iomap: Add zero unwritten mappings dio support
Date: Tue, 10 Dec 2024 12:57:32 +0000
Message-Id: <20241210125737.786928-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241210125737.786928-1-john.g.garry@oracle.com>
References: <20241210125737.786928-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0255.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4669:EE_
X-MS-Office365-Filtering-Correlation-Id: ba7e0b99-aeb9-464b-04b6-08dd191a4412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IAGDfOkPENzl7hvWiRbRS+KtAk6afeUOfZbVDs682wOw/WQG6a+UUxrr+esI?=
 =?us-ascii?Q?LbFUX5TyYle9SL8fRoc1E0LuM1+lO9q1hgFjRfaD89crw7hOLCqXpE1YYTEX?=
 =?us-ascii?Q?zp7yLaZihtWaEOZfWapqu5aTlaXgo+ALEkz7X9hN9Zti3u32rBLu/IaI/4Ck?=
 =?us-ascii?Q?0tWHHAit5DWNQNV2QMlcKarGTguZagvQYpL3sLEl2nNk36hxvU+Aga5Spl6P?=
 =?us-ascii?Q?lrt7j3o+mGMgiECWGnueMwpg7ekW5tLz+qEISMqgDknarQIhyj7n4MPs1r7E?=
 =?us-ascii?Q?TJctF4QOaEwQDSyjJwFpZMSEgqBEpbky2YvaDfVZ5tNcKEiJhepyQxv15ks5?=
 =?us-ascii?Q?UBGcY/wlTSUZOBP8uOxGwoElUTC02Je8GWAZduEXNxzxbRNTsphMxX0jZxi/?=
 =?us-ascii?Q?ipEySt/rKwwXCjnd5/tEEDZljUJLwKNDBXh2nNjQQEEl6SSdOybh6ngfZEso?=
 =?us-ascii?Q?QtBBKykrxlfY1cjkFKvF/UjdeGSCppVFgKjtKMbb06Gumv8w46AMizmrA0CA?=
 =?us-ascii?Q?JpU5xFC2ctg+rNOE91UBuhdnvwPy6WsWTx4Fw8zuzwTi9UEDFFpsrEM+dM6Q?=
 =?us-ascii?Q?zFgaFD6nuViTgrHb4KvhB+hEt7FrONxsCJUTcP7NZCz1q6Fh/eG4ZQ2MoeHl?=
 =?us-ascii?Q?LqCZ7lOMw8yOB18iQsUZ9iwlhcJnOVD/WzJNjN1AquH0qCPp0CsQw8F7C/3M?=
 =?us-ascii?Q?pN5V0HVLtbZU97eVCWv48FGmsJs4dXEU8ITK8PSscSRDfp25NDTYZ84mRwOI?=
 =?us-ascii?Q?iLCSk2tx3ruz/IMP5b1LWjP2cAq86atx6EKkwPwzczr+nKVFNo+Ous/lzRUa?=
 =?us-ascii?Q?jNy9tWEPY42g9vfAa1sQPki2G2qvOVH/vK3JgfQj50ia/0sThlHGBU3HAKFS?=
 =?us-ascii?Q?HlPK7n0s5PNRb1fhq/PDpE++L7rsW9D4WWAOQZ8ur+wrspPv448KrDauNDqn?=
 =?us-ascii?Q?Nw1YAEMK1zoRBy5TL8yTpAW5QSknKetfsjQIORNNmgfEOc/u9+Ts657SzkOO?=
 =?us-ascii?Q?MeWfsrTpeoTkJuCP+Kwx7wtlOpRq/L0HILkt/pbCTSHDUGetW7Euc7JZZuru?=
 =?us-ascii?Q?Aqi/VCmlNLOQY21UNeWHr/oXiu1QD94iqL3eThuqBFFs8pFujhx8yzdZv9cw?=
 =?us-ascii?Q?1YgP87L97q3lkU+Ut2iGKVOjEeoctLuOWlvSPANNpe7gPQ1zI6PCixsb8QkZ?=
 =?us-ascii?Q?tr2T5m6kZkMapK/AcHVsmudVeLeUwxn5//CzdOvuNKc3wKfWUssTxJjVKQP7?=
 =?us-ascii?Q?1d2fpm1qtppuDKYJsoIgfvVcHQxCdPETLpZEnGahVV7XXArO206i7lWqJWGh?=
 =?us-ascii?Q?B9+V7Apa0OMi52qYzkboTGTB32sppygWNcTTHAdS0ja+lA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NzUz1b9ca+8IqQFAeYAEG2wJaIg59D9UlpUi1t22YM7w22Qv9/MFtnlk7E3r?=
 =?us-ascii?Q?zuE6ONmx/7OuKWzJqMP+rHk3WimstIHeqJjUkHAScr5JKkYeorP02LlMb3rj?=
 =?us-ascii?Q?gLtAYBlDXM+cQfIBrNBk6Re3qIWaWX0Vvtomz5nk+jJcPZ/kb7TBuwb/u/Es?=
 =?us-ascii?Q?U6Yi+6WhhTm0UnX7jLR6e6AIlFJ3e2EZ00+b+MJ1CLFLCiEmUuzh9HFlOVIS?=
 =?us-ascii?Q?LVt2+nK1vixdAaNszwTSLxoyMVwVFNTRj25aQ+zCQDVLbfuOc3aP8+UFasvz?=
 =?us-ascii?Q?fKl7AKbDG0Y1BihWwt6JXWb0nD79NJMcrHV29uRAxSnp51V4DKcJY7A/QbO1?=
 =?us-ascii?Q?R4IeCp1G17MxDH+N9ct2r8i1oqgnbElzZ4GkAQdVD/DygNUhJcXdqiER/X5f?=
 =?us-ascii?Q?k0V5z4GnzT1cyKnHYh+zoT4XQx/G/LgctDgErOhO+5Ruwwnd5LlTjUfRKQOi?=
 =?us-ascii?Q?nq2OucB2BPGe2YucytiTViMrGItqAEJfMFcbh8oVONXtnkcYdgc+f/tk42Uc?=
 =?us-ascii?Q?mgI3ccH1OH6IDWENMN7hDtN1Y62jXA6Zm5tr6VRCkWeMD8dXtW2xCqH4cGFg?=
 =?us-ascii?Q?T32p45eKgE8EDXb2YmoaVLV6+ynYMCIHAPSrL4XDkJjGVvA1XAkP9gbSH8Wo?=
 =?us-ascii?Q?LZMm+Y5OWlQxLPWnTS1Qcg2JEyYyNuL++Pp3yhDeLRnrsvU+3w/41CrUX4hk?=
 =?us-ascii?Q?vBnSt/mWh0XfKhHwBfSOdaTwJtqQtWYURnS3VqSuKj6HVcz4ieAACk9e5OP9?=
 =?us-ascii?Q?Ccb7v5KRWQbLtb0pGD3FLiAJAFDpA2O37Aj4pjBIdnKrOhxEMdVQRK9ZugE2?=
 =?us-ascii?Q?TmvPWI3hW4+4/1xOQdS1cYHUbqyDYdp9JCC5tKSO9qpoHhc6QLg0FKpAHQrV?=
 =?us-ascii?Q?9o5q+sOTceVJCeN/pbTYTNKdj3bcZ2vNkhW3TUWJc9QEiNDmMTfOmU9VAvhT?=
 =?us-ascii?Q?vdSL+PL5pNwoOZNYQOtjWtCSapsgiGgNer8fJzfntGYRD7uHtZJc3n0gCs2V?=
 =?us-ascii?Q?xsB/FeJxPXmB/fLHR+EaTEAyE88dw6TW3QGaUHf6wyqO+/PKvg7RXnVdU97S?=
 =?us-ascii?Q?4WOYBaO6HC9O8G9PIprKdZKHYLbDk3kpZMbtRZJzsyEUQ70QZ+CM3rR1fQvS?=
 =?us-ascii?Q?MO8HE5o6xQAznu4Nn6fD/Bl7e9Q/e4+aFYntdM2TiHsVPODcmlZ0tgCL4SrY?=
 =?us-ascii?Q?BoZqpFE0YlzVIg84Zuf8atGE1SeFiiLDU1EHgarkyiNONba7IHpMAi9SI9Pk?=
 =?us-ascii?Q?fUKKDsqUyt2RL8f59vsc4F4z+77L4CHwHpOuQS6i5yDEHWxTfDzJMgJKMtyM?=
 =?us-ascii?Q?JzKHHlEzSMtaEUXcAB6CrDa++nki3b4cgan4UBYxaSRL4YBbpJjs0l9W9sM6?=
 =?us-ascii?Q?rnvHdbByLRgbgFPiDuuH0zaL1KcXYH24d5eDUmB+oUfgXF3m2p9vMOPZd6ae?=
 =?us-ascii?Q?Qjld29WS23UNSFSPEiRF3PWS1nvWpY+/30jzp/uUMPgAkpDCp4aa1f5Hm/g7?=
 =?us-ascii?Q?ZURPCKamRfGBI/cdOH3Xf2KDYfzA3tqgOKaARcFsHBr2RDgR8JVCM9S4ZLsZ?=
 =?us-ascii?Q?i/BD0n/nFxoj1fWYmuP2z45//7AHNXSKCpjKTT1PP+Kt1hCiKSnHrSzW4+JJ?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	25CSgQ805U5DjpUUZMcCHQEXZlK7fALpej9DRuaH9Xod7Gwh1cYbMn9Pc3MSr1KdCOCym/kTUj35VmHoa8y8eDYcWH/m0CGLGukSj/wPADC+xIFa6HTqvMeMtbtcXXChfYToAIAeIxSNVT3wUBN5sMMH1mPMY1bnO8i9Go5OYC0J1aTvN88NaU0fRTIAya0ms0zzl+04UHzpPxPnDSW2G1wX1GQUMaspd3L8XG5BYBSp33AcLiWqOagH+kYDMpT6OXkrKMGbD7PyBP6du4AgFf5h7wzTF2wz/c3PXLB2tLaVpyCg7+UK1le7tkMkl1NQZ6/kATJx9w1eDEUXJolz/9nyC3yQyicoIV7M7vN4xG8Ijjpne8maxngccZxHzd7GqgW9MLVUqy3i9JtX3lq6Akvm3JY8ckX6gdOB1mPYCmSF1AmpoEQphO3SRsdyJoyqbmPJBTkwAeumi4htUEvayWPgMSL3sPlFc5eJ5S686dKTB8HKXvLKBUPjjacpmb1l5tpNKb3/U/5YCaXoSzSH4ksCWzzHbnOuzo0Wt77OhUyEgECtOl31Dil0wm/x8bWo7MVlk+OjfPlAv+jlk4A9Q94cW9p31na8/E/TlHlqScY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7e0b99-aeb9-464b-04b6-08dd191a4412
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 12:57:56.0225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+ER2kltHrvMF/tBiBgcBj3FnKQKPm53J9o5i7QK27vHaPjxZsOIyWar1ZDN0FZyvncoXhe6qnmahxpO7VHIqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4669
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_06,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412100097
X-Proofpoint-GUID: KiJh6xxcnetZbY0cfCHm6Yh_NQe0fgln
X-Proofpoint-ORIG-GUID: KiJh6xxcnetZbY0cfCHm6Yh_NQe0fgln

For atomic writes support, it is required to only ever submit a single bio
(for an atomic write).

Furthermore, currently the atomic write unit min and max limit is fixed at
the FS block size.

For lifting the atomic write unit max limit, it may occur that an atomic
write spans mixed unwritten and mapped extents. For this case, due to the
iterative nature of iomap, multiple bios would be produced, which is
intolerable.

Add a function to zero unwritten extents in a certain range, which may be
used to ensure that unwritten extents are zeroed prior to issuing of an
atomic write.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/iomap/direct-io.c  | 76 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/iomap.h |  3 ++
 2 files changed, 79 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 23fdad16e6a8..18c888f0c11f 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -805,6 +805,82 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 }
 EXPORT_SYMBOL_GPL(iomap_dio_rw);
 
+static loff_t
+iomap_dio_zero_unwritten_iter(struct iomap_iter *iter, struct iomap_dio *dio)
+{
+	const struct iomap *iomap = &iter->iomap;
+	loff_t length = iomap_length(iter);
+	loff_t pos = iter->pos;
+
+	if (iomap->type == IOMAP_UNWRITTEN) {
+		int ret;
+
+		dio->flags |= IOMAP_DIO_UNWRITTEN;
+		ret = iomap_dio_zero(iter, dio, pos, length);
+		if (ret)
+			return ret;
+	}
+
+	dio->size += length;
+
+	return length;
+}
+
+ssize_t
+iomap_dio_zero_unwritten(struct kiocb *iocb, struct iov_iter *iter,
+		const struct iomap_ops *ops, const struct iomap_dio_ops *dops)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct iomap_dio *dio;
+	ssize_t ret;
+	struct iomap_iter iomi = {
+		.inode		= inode,
+		.pos		= iocb->ki_pos,
+		.len		= iov_iter_count(iter),
+		.flags		= IOMAP_WRITE,
+	};
+
+	dio = kzalloc(sizeof(*dio), GFP_KERNEL);
+	if (!dio)
+		return -ENOMEM;
+
+	dio->iocb = iocb;
+	atomic_set(&dio->ref, 1);
+	dio->i_size = i_size_read(inode);
+	dio->dops = dops;
+	dio->submit.waiter = current;
+	dio->wait_for_completion = true;
+
+	inode_dio_begin(inode);
+
+	while ((ret = iomap_iter(&iomi, ops)) > 0)
+		iomi.processed = iomap_dio_zero_unwritten_iter(&iomi, dio);
+
+	if (ret < 0)
+		iomap_dio_set_error(dio, ret);
+
+	if (!atomic_dec_and_test(&dio->ref)) {
+		for (;;) {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			if (!READ_ONCE(dio->submit.waiter))
+				break;
+
+			blk_io_schedule();
+		}
+		__set_current_state(TASK_RUNNING);
+	}
+
+	if (dops && dops->end_io)
+		ret = dops->end_io(iocb, dio->size, ret, dio->flags);
+
+	kfree(dio);
+
+	inode_dio_end(file_inode(iocb->ki_filp));
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iomap_dio_zero_unwritten);
+
 static int __init iomap_dio_init(void)
 {
 	zero_page = alloc_pages(GFP_KERNEL | __GFP_ZERO,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 5675af6b740c..c2d44b9e446d 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -440,6 +440,9 @@ ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 struct iomap_dio *__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, void *private, size_t done_before);
+ssize_t iomap_dio_zero_unwritten(struct kiocb *iocb, struct iov_iter *iter,
+		const struct iomap_ops *ops, const struct iomap_dio_ops *dops);
+
 ssize_t iomap_dio_complete(struct iomap_dio *dio);
 void iomap_dio_bio_end_io(struct bio *bio);
 
-- 
2.31.1


