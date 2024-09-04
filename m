Return-Path: <linux-fsdevel+bounces-28553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5073B96BF06
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 15:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75AD51C22C24
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 13:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B5E1DA63C;
	Wed,  4 Sep 2024 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GahPRcrt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OfrheKpN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CB21DA310;
	Wed,  4 Sep 2024 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457655; cv=fail; b=VdSqwH+aay3pHy58XnLO6Lj9q9gQ0RKsujQFj8SwATttD3OzgdPfUEsJW4e0lD8fk3sSDpsT7gcZEanIeUIH2gmgDF6rVdkB7IgXF2vxPOuhBjLIjQzBjk3temT1jYBv/vN2zEcCQLPVZZQwY6UEAYZDT9VYdo916lgw/bS7PkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457655; c=relaxed/simple;
	bh=e/nRUXbIcLJ6YQveUp7sjkamOSjpFzmOmQVT6SRKosg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d9vkZhGZhJFP6AWfBHV1NdP5CUvIdB3OIm13L7Pq3fi3mZ0KRHWsutm2fweZH5VUG76OHKos3TW+oJMzqS7Qlu5axwue07C3ddQ8wwXcqGtcbNYKDYPJmz596JrM0Hvko6MMgylCYAbJNNRCiKO5k6s43Y4gcg6fiorP1LwNe1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GahPRcrt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OfrheKpN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484DXSgB013228;
	Wed, 4 Sep 2024 13:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=x7UbPFvOsScXo7+
	bJ7RvX6vgt0PtMwCDnQJvPxGlgH0=; b=GahPRcrtwWARXxWb6jZt/7E3F4Ik5WW
	5K2uLTHX1CTLyhOnJhoss39dSFo5FHo1sL4a6sHS7hTM8Sp9kJJMc/UFu0afmfkI
	0dPaM/kJZV9XwffGttFWxdQG4s0FZ2BwjFoGIhj3HwkQYKhXqeiQzWrEmjVDP6Fk
	ONhB+HYSWfmXbyuqvtWf+cJqogjJI7HliU8nkl5iHuMvaNN5eCjNKUSR8wi6OMyL
	qypgoHNnJXcd9FcX1jkeirGyTf9qoqxppjsNEEsm5fqdSPJEf2QRYihRwJswWLTh
	AXAzi9XyjdVwy4Vr3flK8T1gTuGaid2SMEt3hfUeJKA4hf0t5FAkZNw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dwndkdvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 13:47:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 484DOnDK039508;
	Wed, 4 Sep 2024 13:47:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsma54pr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 13:47:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8I9xGcdGcJi3J2PdpVYlZa3gBXhIXKhEnuFVUarpNID9hQM5cNqTv+lCjgxiGRUp3/rsG5EAWuHJDp7Zon8mZ9vjGigfXB3AhTyYwSOhYCpSPnPr9iVM33N2QDQA5fFQd4sB7X0occIJOmhpGaRdK1OBhelAJWnmfFpF1NvWK1lvhIqCNZw06jKlesMTSJ7S/m4Yh0jkM3pLTejf2zzfMTU8HBq9iOlua5ALfSIqGqRweES/XrMChW10adTCgEhpau7jk9rKL5cmpTtejOREnJQu0+oS6px3umnBgouLHLZ3m5WrGXej92i9/wzkOqh5Zsa6qepkEq+IS+mqSJO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7UbPFvOsScXo7+bJ7RvX6vgt0PtMwCDnQJvPxGlgH0=;
 b=J19iaph3HgvfhZ2j5A0QQML7B+vD8HRccNLeg8SH80w+bIJa8dYQ9KMb10gmhT0HmerS8jgTX3MV4jiwF0W8X4X94kFRCh+xOFNG54/QHCftSmFUAq68kv3IcPkfWOMC33A8lzlsZi7o7qqDx4xCLZo4zT2pTQENfto4hseGO65jMnCKj2420qQGPb6DB2Za/Y74vFaEBynKTqaHpIrs81UF2TVcwUrddC2IEr913HXEqjh0AKc+9ry6PEMeR4BGgjg9z6lGZfIzoABIKnKh5BFyMEzGGdQ5QGnhtISfQq4AHpOm7hkoZHguKW6XDdGFbeYB71RMo7Bm4QlIdDRRrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7UbPFvOsScXo7+bJ7RvX6vgt0PtMwCDnQJvPxGlgH0=;
 b=OfrheKpNTm57o/Oub2Z0sHwb+jTcAsmVU/4dn0CD/YMoMCwif0z+K8WF6PU2FxIP2fBsfr9wZNkixKih/Yryd2o4UTBO1cJK/kmXd9QsptEJ8r+7Qt+/GOjv0VZXcrYHOQhEF5sStgO5pHX2IOhW06P+dUfWXJ7wcOvgCogSVVs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4807.namprd10.prod.outlook.com (2603:10b6:510:3f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Wed, 4 Sep
 2024 13:47:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.010; Wed, 4 Sep 2024
 13:47:10 +0000
Date: Wed, 4 Sep 2024 09:47:07 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v15 16/26] nfsd: add LOCALIO support
Message-ID: <Zthk29iSYQs6J8NX@tissot.1015granger.net>
References: <>
 <67405117-1C08-4CA9-B0CE-743DFC7BCE3F@oracle.com>
 <172540270112.4433.6741926579586461095@noble.neil.brown.name>
 <172542610641.4433.9213915589635956986@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172542610641.4433.9213915589635956986@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR16CA0015.namprd16.prod.outlook.com
 (2603:10b6:610:50::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB4807:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f0607b1-c4f4-4a72-4f53-08dccce812c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i1qFdAVUJa7tMe4kTHNI4bdtOrmdmHeUet+ktRRaEEP5xhYE+RzTby46Rhol?=
 =?us-ascii?Q?g6LDqXNv5nq3wLNjGoKgPUzfiErpknlSNYe5hi9wzYq3Ds7yhLW7XBdldRdU?=
 =?us-ascii?Q?gBB4yZUZQCVXlCtMyL7vN1u5gzfEVjm2ha3hP9GLHu2jYS+BzGOkoshIEWlL?=
 =?us-ascii?Q?zixH61YXGv2Ydp5racEFh2SjkvDH7Dcdd1MdfMElhoAhKrWnFyWJDRmJYv0Q?=
 =?us-ascii?Q?CI5e4wq3oOQk9JXzEBo3G0sSt9CyMsnSkFxp8vDMmDjI7+4vA9YHtfA9Ggjf?=
 =?us-ascii?Q?u/nqvvvEE2jm3SLViAz4wIqN4b5GyeWoHgJqFzB9pnD9ZDzt/0yY/x0JdcDj?=
 =?us-ascii?Q?oILTn9sQqsnLaUPQ4y3xu3fxyPFZ9Rbb8wcub3rM8he15dFbGdG8Q/Q6fNZZ?=
 =?us-ascii?Q?pLIRxZrmcBl+ZV32O11YzNqKnMcwFwxtfUyCxyANKHqEC23GUR3jfnAo2uXf?=
 =?us-ascii?Q?8tESZzahxWPqkJpgQdjxCXvq8vi5I8Jyc5M4qkWgW9w9ZmybSE4EO5OdV2h0?=
 =?us-ascii?Q?duPR1aSNBnxgOr94fGoUTHYrreFU+iSqZR0Rp4Ybi4gOkR4Y1Cv7P4wwmsf9?=
 =?us-ascii?Q?dVDNlg0JRpTjHkZKDEDHmmxQRa0tJgf1azLkW2VW+vl1KlHBj6wCaIdSLEsU?=
 =?us-ascii?Q?lo+XE3zmSoQzU+2+QpndTxTwfSI2HDEFVJjvYYvZHCcdCxI8ZRJ7UBMyS+qL?=
 =?us-ascii?Q?SG87qrWIPaF+utuLq18mQ5LKiyiXceRS0PCp+cRRg/oqg1HHhSuAn61HyT2N?=
 =?us-ascii?Q?NMqMud5tl/Hn06euRGHwdp3VcijktgVCoXpVCezJFUcGlS60m85PBGayYKe7?=
 =?us-ascii?Q?940QiUDsgRSYjdv9kIKSD9J/h9UyhLmu7XS9Qo3z+1OArBETcBLnmDMLgcNa?=
 =?us-ascii?Q?dzUL5SUxLy6euwwdnFZxDW5WtSYXP49O+DhIjXeSC5uxGqHzXdzK8q6zXNch?=
 =?us-ascii?Q?9zoNysMlaOC7SBvLn2vP2nGMZpv+zsHY3OaeUxD/aJhKzUjfgrZInWIbTh29?=
 =?us-ascii?Q?Hc0Fao+Ck2wvlAxuJhqRbTTFmSxHMIyUFLMF59Czvr1WSetcoGaswBxh5WSP?=
 =?us-ascii?Q?PTPLeSYOXjkf/4i4nz1Pj4jCwG3btdDxZWSQNz2pbjae6JoKCrUzqHay5jRz?=
 =?us-ascii?Q?sPHy1RaEP9lNw9M3uE16N12fkaz5RpuFtoYg3FZlycwzq1yL68eK8RLeCFL5?=
 =?us-ascii?Q?TzWF+umLxMhuDER52tfdiZV6GeD4r3xd6kuBUy83WodwcCuJlpkYRwLfydvI?=
 =?us-ascii?Q?MKIaSqa01Av8w0xeP3fliN7izzKN9IiTPcObVRCXUO2SwwkTE5+i7/PQ0GhF?=
 =?us-ascii?Q?t0+ZKdifuOhYgkGDjkMbiN0BeH6ab9LHOJZnwzF42clEgw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q7+ILZxORGeUdFS7L6DB95RCaKW2bL5S36V6Nh82rz98wQrSRAcRm6wheAS7?=
 =?us-ascii?Q?av+i07+/qnEKRGMnlYxhw2Sp7y2hGoq5N9qgPLr9UR6ZKq73+J+ALTY1XuLQ?=
 =?us-ascii?Q?+NESN9u2CoWvcv/JXuZ5a5v0WCojpJEpwRQaYfiN2GfrG2lO7V6bu9FFo7jh?=
 =?us-ascii?Q?/LqgPka0ooy1T5TVN25Pujy3AtE10uKamOfgvDpAvTi3tUdQZ4bvHSNVYmmO?=
 =?us-ascii?Q?38hC5H5So4iaI7TzSeSSAqxfI9dimmnnfrY5LdOF1WbS4EwbvnWYV/M18WGA?=
 =?us-ascii?Q?45McjiynKkZ4eh5ZDaauTNW5f0vGvif//8RS+LOblLb/HAnlEstD6G2hVuYm?=
 =?us-ascii?Q?8DtfJRzX6XdZauee/1OC4ZODtCoh8uK9X/f/uUF5w4h1IRUbpD2fptgReyqS?=
 =?us-ascii?Q?ZcYMqhBY3evBqqSBBSp2rx09O5YqoCmNtvt52l22w5W8Fy+68rsXK9YXkwV/?=
 =?us-ascii?Q?shdkiPdzroNyAWMaxSQ3ziAkJdjldcRFAzhF910GAhORQFw2f+0eWzl/lbJN?=
 =?us-ascii?Q?gYeK+RLw7PhR7eLx/MD5CwxTvlcaYlRSQO4R9GqADHW9A3WkySh5a5vnRfG6?=
 =?us-ascii?Q?EL+go67u1paY0r7ecHdwI77Ow2NPVDYNls/6h+vcAqimSSK51n47ExpC+AXs?=
 =?us-ascii?Q?PdaWG6EaQgnAWfjIppDEWvcZXCBQtxgX4uZS2us0BF07YGeFduGD0rO9UDZD?=
 =?us-ascii?Q?Y7noNEWzEI6OdUJUqm7l7fFq02uB8HPb0KvxSoZx7yaA6AOf0+VsVJng2rTe?=
 =?us-ascii?Q?eQ24t0/VZtTNEnWTTU4VSXj3gI9MQu0GbU9JN2wE5okpjp11wyIeGVDGchKC?=
 =?us-ascii?Q?oV8zHIZwy2gcA7RgGS3zwcmg3id8D2Efmz7tGjfZQ6utYHNSz85AXCdBqpa7?=
 =?us-ascii?Q?k8Xeqw7PQ2xCycBJxLonBoeXrZ8myuBoj0rU3ckFoAACFr2oJo+Vt8bSIAw6?=
 =?us-ascii?Q?XH3KnlaVOj/o1ZUOR4Nx7o0tjzgzaH+Vhd/59YWOwEuXzg3WLRhz6uC7RL5D?=
 =?us-ascii?Q?12OtliYQnr9i7L4VzxQ48coxgyimapC8redzGHoMOsQTymZuQKcH0ljEJdjD?=
 =?us-ascii?Q?LK9wWtKWxovDMrqbL1jWZwLaQbb36BKW1csyHuxpDhy77n1TRZ2kDJ1Jkkdq?=
 =?us-ascii?Q?f3l4JskY/X94Y89YNUZpvSVT6opFAUakwN1WQuwZSA0471YKfU+0rDMfAlvK?=
 =?us-ascii?Q?/toCqaE1esoyF3OP4S6o6MZEuhuvQAzkTzIXF/DJxsfAoc7N5SBVyQiAabjE?=
 =?us-ascii?Q?YOLVsSAkmIreJVTCPSy+LBmuJBPy3ZHarDWqJWNcKCgQaXOkR0ctGiHqIdHf?=
 =?us-ascii?Q?FgcQM7LbAdn+lrGwiDKZfxOHBHCatjUxwveMm+Tnv8aIdKBglD7FPJGe5EwQ?=
 =?us-ascii?Q?6z941MHOg6q6SSN6FclT3invq6Jpl8mxAt70eNuTzqxd/a9c7ZQoqtV/VU+J?=
 =?us-ascii?Q?NVyA/hT/IxckDmS3dPgZNrdZRF+FRL8VN+E8iQ1MO8t3bgm0HVLa3uFfCUnm?=
 =?us-ascii?Q?tHexDm7MQcRyQrFFahAePFukxFR6Ri1x059vWJmYB2pjPOD3OKlAlAA0q5wN?=
 =?us-ascii?Q?bBd0J3xBEkDNMCecvYxRpyEp49Zu8avQ8q1Pss96?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6w2yh29dRFWhVF+ZL26LHrkpF8O4feIODBT6wj2Suep4WL0zYVQzs1FX/NhZkobIU89n43H2oOkGuHXOAsm2MSkBZgnDgQeNHxQ8jVwd4L/l5I4S9c/XTThjUgicWeEvcbaFeLdDpEuXZj3HfLZGxZi9+8LIZmM8cFvY9azinFPzJK1/qQSeJTZ/wkTESodUlDIjL6OiXwM3ig5kgaKTOUaWNO1M5EDprXrg7nI8E8Q8FksKpcvotFSg9XVCrzJmTHeI2ze1Ee9MXdsx+UHVBVUcqTweBdGZJywbQyDQK1DI8Flup+iDPnfAR6mVKzpb78cslexa8IEeXdCbh4Nlq+BruESKMS2uemGD6LIHYO+vCzkIwGrJsqiG4VXKBD7wuWirpcStg4xpkvHcprVXIPxf8wURgj45BOr2Z2yCJdQLSo7fEHcwMKuqC54WBSv3gEjragaG7BR3kwSoTY41dUBBGnDT/KwuVpJWfUKV2GSnTaxU5CT33+GTnxvkao9ojX1BSzM1CqWGK+EyWDoWhlF9yZhP3i87VYBJF0610tywCrrr0GQ4y+JYC8mwZfffPkxic8WpEOXkS25ZcTq7DvRg2m8fGQjMFXYvaAWEJRA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0607b1-c4f4-4a72-4f53-08dccce812c2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 13:47:10.3298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHv9Y7Xj+HDaEfc3JzmR/D3+Rvo8Cx4wtNKg/aD2u0704K85LnyEgmVQ4x7tzJxfq53Rm7ocY5uHW/2dvuBtrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4807
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_11,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409040104
X-Proofpoint-GUID: xaXoge9_4D4XFlkvHXc3_jaB91Cs0j2e
X-Proofpoint-ORIG-GUID: xaXoge9_4D4XFlkvHXc3_jaB91Cs0j2e

On Wed, Sep 04, 2024 at 03:01:46PM +1000, NeilBrown wrote:
> On Wed, 04 Sep 2024, NeilBrown wrote:
> > 
> > I agree that dropping and reclaiming a lock is an anti-pattern and in
> > best avoided in general.  I cannot see a better alternative in this
> > case.
> 
> It occurred to me what I should spell out the alternate that I DO see so
> you have the option of disagreeing with my assessment that it isn't
> "better".
> 
> We need RCU to call into nfsd, we need a per-cpu ref on the net (which
> we can only get inside nfsd) and NOT RCU to call
> nfsd_file_acquire_local().
> 
> The current code combines these (because they are only used together)
> and so the need to drop rcu. 
> 
> I thought briefly that it could simply drop rcu and leave it dropped
> (__releases(rcu)) but not only do I generally like that LESS than
> dropping and reclaiming, I think it would be buggy.  While in the nfsd
> module code we need to be holding either rcu or a ref on the server else
> the code could disappear out from under the CPU.  So if we exit without
> a ref on the server - which we do if nfsd_file_acquire_local() fails -
> then we need to reclaim RCU *before* dropping the ref.  So the current
> code is slightly buggy.
> 
> We could instead split the combined call into multiple nfs_to
> interfaces.
> 
> So nfs_open_local_fh() in nfs_common/nfslocalio.c would be something
> like:
> 
>  rcu_read_lock();
>  net = READ_ONCE(uuid->net);
>  if (!net || !nfs_to.get_net(net)) {
>        rcu_read_unlock();
>        return ERR_PTR(-ENXIO);
>  }
>  rcu_read_unlock();
>  localio = nfs_to.nfsd_open_local_fh(....);
>  if (IS_ERR(localio))
>        nfs_to.put_net(net);
>  return localio;
> 
> So we have 3 interfaces instead of 1, but no hidden unlock/lock.

Splitting up the function call occurred to me as well, but I didn't
come up with a specific bit of surgery. Thanks for the suggestion.

At this point, my concern is that we will lose your cogent
explanation of why the release/lock is done. Having it in email is
great, but email is more ephemeral than actually putting it in the
code.


> As I said, I don't think this is a net win, but reasonable people might
> disagree with me.

The "win" here is that it makes this code self-documenting and
somewhat less likely to be broken down the road by changes in and
around this area. Since I'm more forgetful these days I lean towards
the more obvious kinds of coding solutions. ;-)

Mike, how do you feel about the 3-interface suggestion?


-- 
Chuck Lever

