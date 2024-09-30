Return-Path: <linux-fsdevel+bounces-30356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2297998A3AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 14:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B5A281C0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 12:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96435190074;
	Mon, 30 Sep 2024 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ENL9tMj3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QQ06HBaw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5767718FC65;
	Mon, 30 Sep 2024 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727700925; cv=fail; b=A198K/UM9AC94hBEtQpunTrYHRmO7EEprZGggz18FCshp0wIvX5txEeZqcO8pM5vJm3c9/2HmQQkKl5K3ma2nwDjebaKS6nCM7FluZ2YlQqleaCYys3FTK6ehrQv+JWpcSPrWf8n9lN91CZaU6N9tO9g4uq5pxGxNc5p9GvJeu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727700925; c=relaxed/simple;
	bh=JrkUTFihLijuQ3CKHKbD57k2b9ovKf9VhqjJzPfeEHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QZoy2z9IGIv+Fi2YK/oPMlXqSsr4fe5nvQwVmnxe561Upfd3eVm99WEW8rtr7wJ90sjYblqfjgB2MJdwdNZw+On/sAjYkWO9qd0Ody611+cQcVJmSLfZUCzguHcFRh2EFDeq+VM7QFVHXgderY//8mzFHaoLe7WW9Tv3x0/jIQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ENL9tMj3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QQ06HBaw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UCPRZD024034;
	Mon, 30 Sep 2024 12:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=ho8tJS4uySoQ3rH9pb50OVfoTp67KlBFYaTfNkGTf68=; b=
	ENL9tMj3o3xNch3tlmX9ODs1SgiQ2DQdsmQqCQgRlFj111teHvZ95fOskphSSu9c
	gwNxggQFsrSENQY9mvFAQZlhVYUzkiJ++6rfYX/77j6uX9n2GQqpSh7uKTlezsK0
	f7WtJQERBFkhcan3q7bY/2HxMXIGR7IzVax/rRoVTmdRBvC99BH4gOvLnCNqXSRq
	TaQ/FGJHipVAlKnXnv0D+Aac/1oNvJXnJOeQ1mBoaFOIxXeWgED79PkVCOHAvFhB
	+D/+ax1+Wi5Y4QQ+h6BGJXKNQUO53AnJVzgnjeRQfzQz/0uH1XBxf9uA4C1wu/I9
	SEIleK664tlevWD43/GOWg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9uck7hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 12:55:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48UC9IKE012510;
	Mon, 30 Sep 2024 12:55:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x885r6y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 12:55:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rodSZWv1nHH2CCnw7QZh3mqN21BR56+tyN+p++KceKf8NxRlmoWAp+aiasotN9Ub/PAdY3WRaazmkfok1JMWpicq5OPqfLjfVdUgxgIOdya6Mb0wkIuJAWzA14qsR6+LR4YdN4us4j/Hsk1O+rqxtwQpDUL8WKQZyjPDvfGeSu7oQog/3iZU0NPu4CPi8EBeqim6idN4VrisOEQwNNnjP+u+BSlv1KCxicMsaEDlqQMqjkVbSFVz8/0+sAkTd/hSKWB8uj5TwuzEwxLkJR5UJv1IzF1I2PXWcd0DJ29uurLDkvyE3zxY6hGm8naiZQ7VsPLrndai8G+D7izM/ze2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ho8tJS4uySoQ3rH9pb50OVfoTp67KlBFYaTfNkGTf68=;
 b=gIa/222BMCBxFnA7PkYFY2ht1qieqNMDjytgl920ZWXkNF/S9xQ0ub21tekfsf1fQt/Q/9gzOfLsxe5VXo+87fgbsVgxmI9LTz9kKpDW1frAItGyNOvmiCZlCueIxVxfAWx/62dFsMn3U+FyoTfXiMif5RZZtpjFZAjqr95WGYzhbmW5BFXNcvKzKPc3IjXENG+yNMR4wdXyPqOOpKx0n1x4eizl8NoIAnRQr/HAao2yP7YrTMz8hhZXhofvnxs+XoWI5too5mF1jl4TiBLSAujbDKkLegE8Arzv84kz4FDPVNHqc+8AA9sci8kBzEf3nK+7AHpe7havPQ9bymfESQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ho8tJS4uySoQ3rH9pb50OVfoTp67KlBFYaTfNkGTf68=;
 b=QQ06HBaweyl6zOvW7SkSwj0GFRitYrt0kae4cHnkMh8ik0ZhWbVLaL9dV7GaidbVWJtQAJROtVcJbWPbLdOvekDl1a6n7RhOxwVjylJpAZk4E3SORpBoLQpw+EGj1BLayRhF7d91NfezXlzpEW4XKyjefvBJDD5AxwiGMlUHLbo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BL3PR10MB6116.namprd10.prod.outlook.com (2603:10b6:208:3bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Mon, 30 Sep
 2024 12:55:01 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8026.005; Mon, 30 Sep 2024
 12:55:01 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 5/7] xfs: Support atomic write for statx
Date: Mon, 30 Sep 2024 12:54:36 +0000
Message-Id: <20240930125438.2501050-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240930125438.2501050-1-john.g.garry@oracle.com>
References: <20240930125438.2501050-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0052.namprd07.prod.outlook.com
 (2603:10b6:a03:60::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BL3PR10MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: 03de3550-6633-4796-7e2b-08dce14f18ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QGhNAmRgdv+/GKXo45Xtf8340Q/VP+SaT9iVgbMgKk+kxCnNzA+5SIPvsh3T?=
 =?us-ascii?Q?r8BnBfVHokOzuj3ptb7bjFnzfLZp1MVP3VoHLq7AB7ZjCCZNFgIZV9grb7kv?=
 =?us-ascii?Q?4UsgeRvl2DDzmnzE18VbE9/bUF9NCEwUxkxofvH7i05xU23xJrQ4IrQ0BxLh?=
 =?us-ascii?Q?sBLAsENuVFm6TnPCuJa2/yzRrnVbiAecoYhB1JjNpv/zRKYV0qPYuszOkvVr?=
 =?us-ascii?Q?+YyG+zV+DtRfPOs+v0Uhfe3Uka9B34zc7I1/KlznJs3QjqpFzkdUiDRZ1k7+?=
 =?us-ascii?Q?jpX/CM9QxaKK09FhNsKUazQgdV94iIImjH6uY0SzkiwuPrNmz41Tdi48OsP3?=
 =?us-ascii?Q?inD184gQzEjTlTsKyDpgkllk2ckL5rKo0T/E3lHiJ3plgW8BqlQQ8xxbylmb?=
 =?us-ascii?Q?n09RDcY1z/gHbf2j1gA7m1x4ciNJFdrWLV0U+y5m2668Kwsd8wRWcWqsrRLA?=
 =?us-ascii?Q?9MuvL/6yo3hN+jcUOMBMN92h35eHV3KqGPzpBYt9dmOwnXno4/+TDCMvMs1m?=
 =?us-ascii?Q?PoDBO5PrulexaEQa1xFvMKEJeyJkBfJUI+m5uUrGQ4ow9a88tOZpKrPphY9K?=
 =?us-ascii?Q?4wC0G1rLZlx8FI8ZZ3ZCuEeJxgV890fmiqqgYVgsrnconjrQASFgdfjFw5b1?=
 =?us-ascii?Q?LYeAa6bf1x3twEyZba+OPsH5QkU1PhpDO/YnrzOsa9zjml+RrUbMgqUkQTW8?=
 =?us-ascii?Q?euqx/4gf0rHxZmkz2Wwl2vW2YafXiL/SdsTFDH6b4crYMkBMqVA6AwRFK59s?=
 =?us-ascii?Q?1oZ9qjdoekQMQgE+z00iJ+tYPQ/qTyWpm+2o2LWHBBo2b3iM0jTkObQJX8GL?=
 =?us-ascii?Q?lCilP/RyirN5rUiEOovMrSpwMLhUKaEwWvJB1/x4fdDePOHDKu+4/xihNayv?=
 =?us-ascii?Q?sprN/Jzk8oXUTPPzUyZM8cu94dtcOCOg+dk622Z/z0F/LNyKg8EmJ5XyU1cT?=
 =?us-ascii?Q?jiBVQ4Ix3vxDbHwmh7y+F661QknJ1P5OzzgPLSq0X90fU7kNfXrNf0pI3v4F?=
 =?us-ascii?Q?v0G7wZ7zaWGmz8L3nX6wLaBrJ60gtFjRlIy0RVCdl6S3EXrh1QBKDo+3wiYT?=
 =?us-ascii?Q?hsOdKbp+yjig7t7UZc58H0VvvqOTrSMVMmcLuUelkokM1nDYx6jUnw89Kn2Z?=
 =?us-ascii?Q?1MuMsT51gPaZRF2XlmgYUmK0R8oyA83aAHiZnSFCgDcTqjp5ojnsqx8YQaIs?=
 =?us-ascii?Q?/DYzZOxoQvl6CjZBcoYto03WPpzw079ssu0rnGwVKnPp/b9LCs2GIFu05uye?=
 =?us-ascii?Q?bnnAZT+6ClQpprmlhYLjSEP7Lx+2+dQIcq3OarmgXQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UJVFduhJqNzfmmG7glcC4NpNVbnRSn8QuucxM+NgD9e401eqyZQ2iHjpi2ej?=
 =?us-ascii?Q?YjduR06hBQwl8EwrfuHAxmeoxM79jw3waitvvKk42ZGUGtAn2mHkJu6OZY8G?=
 =?us-ascii?Q?QLY2gw1aeFqRhjEVK2ha2w7843bBXmWXE+cncT/Hlj3E5cngdz5f/4Z0zw/v?=
 =?us-ascii?Q?E9LpAh0i0xsoYd9la87oyW5EpwHf9Qoh6wcWpDX8IE6Ve0ZTDEyTnvMlIvwO?=
 =?us-ascii?Q?hriU8r9JTqlFcvIkwZR5urUDGrri/X5WO0ckVMoRhP7KaixIvqm/QIJKOXMi?=
 =?us-ascii?Q?AxczAr1TOAXh6Q6KgLCiYHV+n609hqKwWgMZJlzNllH9gi9+6ICz1JojiGES?=
 =?us-ascii?Q?QQXKHEI4CFtw9DhceUe9cRF61PSY4QPg2NWzlTRKBu1KMA5b/Z9tzPOjXKwv?=
 =?us-ascii?Q?dWJzmuyx408xKyr0YYe9UaS34xz5+e5GAjVzb79VbsrO25G69z1s8dzONR0h?=
 =?us-ascii?Q?ik4AkWgsRK6XTnr7zOa/rOlpeh8vIcrbcGdxng2gKhbAyQdxfKqXWZRXI+TY?=
 =?us-ascii?Q?M072Rtael6w+CZPbdX/Wx1PJjDXEHFjP05miEKTLWLIRl1v7uhEudZDU3sY2?=
 =?us-ascii?Q?qMydlyYAtvrDUq7M6Cq719SZ8/G5JXRcLcstY2PeNt5eFtv28vg08cvh+IXg?=
 =?us-ascii?Q?/z8sJ+We2Kri4+c4X38VpAYcyhw7KrrkOXlVHde9izfZADNehSXDqwX6iPiR?=
 =?us-ascii?Q?PDSh4Dp9qnWx3jTH41RVxRs8qlsUN3GxbNKLMCDmd8OlLEri8xtXNH8aty3p?=
 =?us-ascii?Q?/d0xlfW74uXRiiGp9rjCtcnrmTjxzHsi750t6pb7HvWAarU303oZmy8Pj9TM?=
 =?us-ascii?Q?ZO2VYnabXOHGe/OSsIZL/trTwr1CWlz9gUn//LFmJ8nbRyv1eNYpc3n2yELu?=
 =?us-ascii?Q?Cb6Us6r9Fb4ob9SD0u1p6FpizFPEAQTdwliW/sYbjwJZdls6zsN4FUEBZLdI?=
 =?us-ascii?Q?tXIqfhv/iTvbBiwzxmcbPVlmxiU6+QWOR2SyGMOSBeydiM33oEzvmuIQmIJs?=
 =?us-ascii?Q?5LfibLpci6MA1NXNfhFhkQ+vdPrv4aE+ZSnebaFpqxBGXP96HHwfczWIXmRQ?=
 =?us-ascii?Q?sR/vsR8iJRCp0/mlZ4FpDSFbdjwwuM07G/WMx710FBtD4dDQUiRN/eU4GOyZ?=
 =?us-ascii?Q?c//bW5yFVh5uhs8Rfo7You112GIehUTvbDmxk2gykr0VnPnfz+yFRNXCUP9L?=
 =?us-ascii?Q?dXBvBPgOXN3Y+yYDcL7b0Yltu7azYwt4ryIE/Q5pB2++doDDfip09aC0eNpF?=
 =?us-ascii?Q?YvyUlEoBkpoROXTfF3kHgKrCE3Q1mZnsOH1q5uQKAdAYPjgirdOSe/SbdHgM?=
 =?us-ascii?Q?HC8jAiUbFbHg/OHAcM3nchMtzmd9qRZ14ChIUksEsHVWG69jyxx/fn7PtgId?=
 =?us-ascii?Q?NszdHbmo9H/kbz+TU6USpjmiwRxBNcQiuCdAG0ToLBHB2/DFvOgzydwOeFyB?=
 =?us-ascii?Q?Dyt1ErYp8uBZNWIkRuKatTMh44dyjF65dKFpGsYjKYQnCfJTnYaA2z5M+Pww?=
 =?us-ascii?Q?xgciaVnOV94eDBArRTNasNNu7uJYyCZCFhDi5TDhm0tFnWqigbRaagK8nkQ+?=
 =?us-ascii?Q?3lM9s+CnH6bnQqTBx+hXMxVAG+jzgpEFKkWK7aD/xpbAYDLWZjQ8co+T+b+B?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	83cAuSZN59Ar2+9a3+T6GxEVqkENZ0HVvXxY0gPdLScANnsL33l5jmDmBYw8R4u2fRhTEue4uTpn4uC2YZth1h9O/OldoiPZW5badtQCoKJQQhpRxSLSfqkhKkAq6wcI4EjFrkRkP5MxgqsC5cDhfLRhQCayXNhIHD1Xbo9OZWWed1RlL5kGKM8v2jGT9ZydDDigCC6fdy467bAIlnwHgN72orSdaUySR+DhJil9hnbp5Tdiu53oiV4LDKltHCfKWRvUnacMGFvITONncSvA0lwQi0xAfMySha+WR/3NbUKmX+bZ6LJZLiypXjT9y3yMJC7FSU6Kr19PSeG/xqMNM0Ik2jyjQlDBrF3L+vLy7HKyuXxq4d09feHstACsE2wdibwztKYYNv/LezS3zuCEtRmp6r4RzHPT7xZ8ULX+1mh/rOuh3zNiz53wrGK8NChPTrYmQDJtdAvoqr/P+J8bqoLfDgrse7QslDy2kjQ2YN/l9mWtZ4E6gL9H9mlBGgEhVxssb1TsqwG/aUD4y887jnLwIY8Yl61hePs7J8d2754yUpd0gUsfK1YZrYqRTGiP6f6vtsrct0Yl9JsuVJ1jo+Lv+ok7XNGuPo72e94M2/c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03de3550-6633-4796-7e2b-08dce14f18ba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 12:55:01.4130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +n13HJFwbC18FBKKbsX/pBF45jQVcFJxKvaf+C/aWbZ4pGVgFZd1hTmXJW6Cdd4RX0wfCPyu/ZyERg1NecMR/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_10,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409300093
X-Proofpoint-GUID: w_G3q2kzEQRnWsaach4wna2AZcpKRVMY
X-Proofpoint-ORIG-GUID: w_G3q2kzEQRnWsaach4wna2AZcpKRVMY

Support providing info on atomic write unit min and max for an inode.

For simplicity, currently we limit the min at the FS block size. As for
max, we limit also at FS block size, as there is no current method to
guarantee extent alignment or granularity for regular files.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_inode.h | 17 +++++++++++++++++
 fs/xfs/xfs_iops.c  | 24 ++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 1c62ee294a5a..1ea73402d592 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -332,6 +332,23 @@ static inline bool xfs_inode_has_atomicwrites(struct xfs_inode *ip)
 	return ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES;
 }
 
+static inline bool
+xfs_inode_can_atomicwrite(
+	struct xfs_inode	*ip)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+
+	if (!xfs_inode_has_atomicwrites(ip))
+		return false;
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
index ee79cf161312..915d057db9bb 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -570,6 +570,23 @@ xfs_stat_blksize(
 	return max_t(uint32_t, PAGE_SIZE, mp->m_sb.sb_blocksize);
 }
 
+static void
+xfs_get_atomic_write_attr(
+	struct xfs_inode	*ip,
+	unsigned int		*unit_min,
+	unsigned int		*unit_max)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_sb		*sbp = &mp->m_sb;
+
+	if (!xfs_inode_can_atomicwrite(ip)) {
+		*unit_min = *unit_max = 0;
+		return;
+	}
+
+	*unit_min = *unit_max = sbp->sb_blocksize;
+}
+
 STATIC int
 xfs_vn_getattr(
 	struct mnt_idmap	*idmap,
@@ -643,6 +660,13 @@ xfs_vn_getattr(
 			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
 			stat->dio_offset_align = bdev_logical_block_size(bdev);
 		}
+		if (request_mask & STATX_WRITE_ATOMIC) {
+			unsigned int unit_min, unit_max;
+
+			xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
+			generic_fill_statx_atomic_writes(stat,
+				unit_min, unit_max);
+		}
 		fallthrough;
 	default:
 		stat->blksize = xfs_stat_blksize(ip);
-- 
2.31.1


