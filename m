Return-Path: <linux-fsdevel+bounces-43708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2DAA5C14C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 13:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3A23A5AA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 12:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B224A254872;
	Tue, 11 Mar 2025 12:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZpoJGecG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cQCzCilT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283D41805A
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696452; cv=fail; b=GxxSO/rWTF3bSsoKFDsiUzcOSP+be7rsFVGVH+DvG/ErRFtkKMnK2hdL/XpvoySU4bl+ASjdImVKja6Ih2BprZyC8XWg17vRdAKHYMds5uwLV5Gynyk+kgX6IhCOe2UtakQlCPwEgBHb8uxp7MG2bTSiNbF1qBWcb1cjT+/TYik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696452; c=relaxed/simple;
	bh=dFIJGvuimnZXggMFXJae3b53uz3hDX8PsDxVaq3d6Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u0Zo0pQZmlcENZ1fJw7HOXZYjwbqcZ68NmBt7VrB7SIBiHhYjKJYafDZpSKEHbTJzBVvr0bxiEg22AG3jAy/+ZiT37iCNkQjUTdjvtHYqjncmxKuzteGTgTVMauK+s6HHnm1JSPMGb31/Lq0tA00/NVj1FvG2+Ywu3KPJ5uIzhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZpoJGecG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cQCzCilT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B1fqhP013381;
	Tue, 11 Mar 2025 12:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=1LgCCRv1hSfgDm5KtS
	xcr5fAAktDRau+hWp5CiZxSv8=; b=ZpoJGecGCwdXcEUD9BYdi3cEOU77oG0404
	TiaCe2uAf4Op+Z2ogcTPdkkcnTZ9uThtdNHVo5qLhBDQiaQFK30KpNByE9kRzW4O
	qR+NqFhHZx1lKbfE7zzxokD9hgvpNxvzZYYSDHxkMYleDEgmnz/laOdSKgTVafJL
	D6popxkGhF6SbQ6EZ9Un2hNKxJHRuk4yrSPxuObFwmcisWmrRSJvTsfrZjV2e/1+
	tCiU3tXNRLTWBiRxCrXGdq/jlpH+N1ql85bL1nss5XlO84ZBz+SQmUhZ1wFLGWf8
	GLNiP3eUNWLEw8vtGmAPPoU/VcaoHFBx/WA52x81H4IZ1gkQ5qng==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458dgt4n45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 12:34:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52BCTA0w020105;
	Tue, 11 Mar 2025 12:34:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458cb8xtn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 12:34:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqFqUVm4YZk2AAuhjTmZMxgEKe7kjleVY4z3YggIprDerr415rwIcYtlL6HUxx0Wmfqw3yI2lgg6kxvmrd/kvt2vlZ+Wo+bJcpkzVjHC2jpWVoDEOshy75BY9MUUOGEh2SZ5T5wOHZ+WZYCqHC8PZ/jZOVSzWNjT1dzJ474/PG37bv4XglTiYtoJempK53Lroj/W/qIJLtmJHYayDur1ceI4MbPSP1hal6gcywPju2pRcH/QmI354/JwwF7wlnfmiCP2lR4q56ELSChnit6VlZHkinCcKcf3IxWMRZuIL5EjcOVnnxWcK4N15liW5W85lstCcnpMoXrp/WBnv61Ipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LgCCRv1hSfgDm5KtSxcr5fAAktDRau+hWp5CiZxSv8=;
 b=tMrUUd+wN9WM9tl8iDWiOIjcLk/l3/7d425kEbgyrRetkRl8Lk7bQLgHw1eSceF1MzFLfwq4ltvO2j3DH5JGy8r+yohlHJojBUxWYbQ+87T3RKKVozdOL0aqwEu6FQqFJXRJ183vr0aIxGGO52rwqppEbykx/WFweBGtU0uQet39tZh50KjD22fQBpS8MPW4Jj3lKcHwgk0rbs62KJ1BJAa0DMNmYOrsUPSJio9RWk9xvcYA+KSCncbzQ28bsk7UxdrIA5VoaBKeIMG5zmZvfwaiMU/mI7/rT758fb54m63FV+/97qD3krRyfWgiOq+gkvQNM1CAlt7vqUrK13JNIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LgCCRv1hSfgDm5KtSxcr5fAAktDRau+hWp5CiZxSv8=;
 b=cQCzCilTTS/8HNt3wIk55rPoRwPymJdY0PkFjO4lBl5PuE9UeQ1Q1xBmtklrB8IvFbIO6F1q1rxCwR4zRyKjw/DlkUILynnEuor1LB4wUo3gzs5vYlfD1seYnLSimdkKXNo0pVy707pkGbzFW6dgiHtThBwmPvxdZTjyla+gs0A=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by LV3PR10MB8081.namprd10.prod.outlook.com (2603:10b6:408:286::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 12:34:00 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Tue, 11 Mar 2025
 12:34:00 +0000
Date: Tue, 11 Mar 2025 12:33:57 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
        Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fsnotify: add pre-content hooks on mmap()
Message-ID: <a4e89300-f2ba-429f-98e0-1b136189b7e6@lucifer.local>
References: <20250311114153.1763176-1-amir73il@gmail.com>
 <20250311114153.1763176-2-amir73il@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311114153.1763176-2-amir73il@gmail.com>
X-ClientProxiedBy: LO4P123CA0536.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::16) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|LV3PR10MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a2f60d-2f62-4bb9-33a8-08dd6099000c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vVR05ZHeV6FruOAnfbnrdmtUkdTLsuW+eJIP7clUlGRyGhxumMKpFLvYDT68?=
 =?us-ascii?Q?rOEsAuoApw008ek8LY+Rj0Q3yZ5lfmqWrU3kVm+7uZvqGQt6o4abS37tsJLJ?=
 =?us-ascii?Q?WZZ2O7mj4zM6YhmbDPN7yyLX1X8x/6rzhCa9rRO/A9TLL6CSzpWOmLkkNT8p?=
 =?us-ascii?Q?+fvMJcec429Gjkzew0ayMhJRDjhvWOmVaJkgumc1OYkli+FVt84SiwioL59i?=
 =?us-ascii?Q?VfNSAu8jlRa0aM83DglokhbKJoXHE/YztVcf0YSBlnVOmBY3kBux48Jqqz6n?=
 =?us-ascii?Q?XJ4dd2oZTBkxfnV8tZMgDFGnO6RaYZD89LUb0aBbR3k236n6fg9vJkkNRUBa?=
 =?us-ascii?Q?aFpFJIJmfjZqXHMQlv73hhRBGmFP9Z2OZkVDMbaVxIIRX97iZ4iFyKB4H2Uj?=
 =?us-ascii?Q?8iLdel7oEU0/c6KSie595zF17TI/z/lOfbvEUsPZJ+KEy+x4ohQAhrONhxLE?=
 =?us-ascii?Q?7YzMrdergHT6wTDnc8a8emM3VbEQUGrK+Iz0Wspc0PVuIWmveg3G2k8EnAx6?=
 =?us-ascii?Q?7/L/cJw7vABxg0uYR7fFUbpWnyHQZFH0iTfd/LwH/i4QsisBC42unChGTBiF?=
 =?us-ascii?Q?kiHVTDNFP0TUjxB2iu6X8NoF/WetQl3tEOSbJT2g0UJAdgHlZXTyJ7vSndDV?=
 =?us-ascii?Q?+63/NDt7LU2ggYyOlBWTvh1+ZwRgsh4OuZwJmTyIfFKyxcoMhOINMgXGpYf0?=
 =?us-ascii?Q?w562GfNZTfn6NZRS8HEwKsMebs2d2MvG4WVNk2s/SvoOBmcdEryxOu4S52s9?=
 =?us-ascii?Q?zmt/Sf0ZMP7rbfgRAAF5MaX1h7DL/rpFnG3UjTClMmS8B36Oo2e1o8ES80V2?=
 =?us-ascii?Q?xaI65GMWlfrxXZ55oV0nZsh4LQD4/wN36HssMXicAa+BDc4JutiaauyqhQcO?=
 =?us-ascii?Q?StgZHnNrm5gBk4kaOHrtCrqWpb5WRTRqrwh+n5fZGb+kpjeXDBzY64P3lJex?=
 =?us-ascii?Q?qSXwi0jBElthRh8UV+3Rds9BKtX5t0LB7+GrM8A4pbVS2CqbaRbOQJBc9Aqb?=
 =?us-ascii?Q?8jyPPakKozXo2Pj+UFusNPairUt1hzSVtS4NOOuCPP3lvfWyL+Dv1BzKkrsA?=
 =?us-ascii?Q?jlcib+qY2K796Cj34mIjV9ouNSEBHdv6p1cgQ4DzNirjnkt/RNasxEovayPq?=
 =?us-ascii?Q?ePM2zNJkGl7cvpQJou6YdqV9rKvkmux/uwkA2X3+SaoxnT+hjfbmxrRBXRUd?=
 =?us-ascii?Q?4XYPavbu9IJz03rOy9ksrGPuUW+3sjO2F2hhnfw9AkkLoBP4tU08j2o+/0ld?=
 =?us-ascii?Q?4ZFiIMV5SN4FHAd0utMpY33t8SVXdbzsfVN6uJ/26HDL3sROjOEeZbGZfxoj?=
 =?us-ascii?Q?ygNVPja/C4bLgZQ55k0CEYI6GHoPr5sTI5g8wl2pioW5j30KxpM0mI4hFy4C?=
 =?us-ascii?Q?sW6nf9HjaKaD2dZq1nCv1QFAkkoS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zgXOw0LgG5gqezz15DXhMtZ6r9+JZGn63YrzkTRkgpk0fLJZb1UEFxHnAs5F?=
 =?us-ascii?Q?xKVoN7aHVAAOHIKly/tkCbAVnhhlBGeigtbO57fGjSm4yA4G+U68AgxrjlVv?=
 =?us-ascii?Q?UIBSe9jra2Fbwby4tz9FbygYISIdvn4AkGS7n6JKR8x2QQwDFWYzoPyVWAet?=
 =?us-ascii?Q?lPEeCKgw9K8VJUlDC5JoxmSIXFs3q9VuZsMv3osLlIrx6RntWWPezMtaDEJ5?=
 =?us-ascii?Q?rkv4CchzEUdtWI2qt16WxMm7dKDyvdSIi6K3S2lLbdcbJLoXCI4BPC7St18a?=
 =?us-ascii?Q?STTa3Buu7wjgGcnIFbJaDuiIOvceMt8knhnJM+ZXgCCNQtH7nJvPu0IagjbL?=
 =?us-ascii?Q?sik9+Pt6c/mlOaGw6Ec5L/Z7yFT1hYx1FaVfHc7Yeu+DFaIvENI6/QTOLkrj?=
 =?us-ascii?Q?keTga3SXBilJm1EkqgOuomu5cxTXfiI+Nmavn+/hn3JlhGkDld1c3IO8YcyF?=
 =?us-ascii?Q?acUkUNcE+U/D83bsIN4aiGtwTR2JdQBrPBPKeKgJhGuy26Rc+B3nHIyoEJ4f?=
 =?us-ascii?Q?8rVVz9ST0WPfBJ0CnNYlaUvWKcZSutN6iJPQ+YPJuKZ8lV1INa1FjYwHFK9A?=
 =?us-ascii?Q?KdgnZC/+/FjgDKsx84GNL3Chd1CF0tWUfoKUeIuBJD91anQzsQ0YU6QPDBZ/?=
 =?us-ascii?Q?VfQRpUNBpbxV1mim5MXCTPaYIq0BVT/HpBAapeOezAyEveb7M9zpG+CzCD5Y?=
 =?us-ascii?Q?R9VdZlXyA4oZI54TyHC4u4ASZmTwZzYEy7pwWkwf2nCAAZn4/BrSNpeNImWk?=
 =?us-ascii?Q?IoaY8AiRvdJxxtYjzuMnBj860Xx54il0/Z372HKUAziHvYnAPKaUmjnMxGMQ?=
 =?us-ascii?Q?ixNZxRhvyowDvfLPUfEdafQxek6Z5sJf05QbK9p4sMMDjIz2gmk8XolZEZb7?=
 =?us-ascii?Q?4EIPusmA4vKHcxloZ67xzj53TOuADWgJAMEMqH8qljHqvcEEXk0lgYPmLJkY?=
 =?us-ascii?Q?r+bce5fOShupm0rUL3sHT+tPhf8DISixLNNVliUXIkMXXtVfmvq69VB0dOK9?=
 =?us-ascii?Q?feb4jRf1ayt93seKqPBVFKLcMBEScyw41Yq+Ib40rYPmlXraaEzhmfmh2pri?=
 =?us-ascii?Q?SDjqcQgP5cnWQBYzUYvJG12+C5drA/WQpfcHBBffX4f1Lbt7jUhrVtpA3fw5?=
 =?us-ascii?Q?JJyvGNmP0Bg5hhcFd13NSLblPW8f0ryBlx0ZLRIDoA84rd6jfIodhHYDWnXD?=
 =?us-ascii?Q?p/ybDbyMLdgKN8fopLd27u7VdSqwY1tmzMoFTYz80gIWD5b2C6VyxkKN/LEo?=
 =?us-ascii?Q?brXA0Txz8pYX9cf/Egshhnny5Rou8dqNMwNkTg2oeWDbvQxxlZabyJhzmrPn?=
 =?us-ascii?Q?llXCs/8W/OPCCjHSXhZUOuZo6DPhpV+8EbjOX9tv2gJeSv0aGigyV0bmStqU?=
 =?us-ascii?Q?bv7bR6XlPJTCtBv03q6bJDpcwYugfwMyMgKK/tG1X5vl7d4sRs/PLehyOyFw?=
 =?us-ascii?Q?mnJjeAreGRDbq/OI0HOFIRNA4fDNqlIAxls6iRbEdMAjtIMUiAMtDE+L9B/E?=
 =?us-ascii?Q?BbN1V1aRKjupwqplE5neES1dudYX8pIXOpPK72H3LN6dx9e6rCSTNSmhCSJY?=
 =?us-ascii?Q?OJ4H3IxSOld9E9MOHFLLz7vcAP6wYrwDf6S4xcqILriQkOTdUwYEElvqPMUz?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hoPsuw45+/A7KUKC5WMXazX6ROjyDzL56Gz9wOUMl8psbJ4rrK9h6eDVN1Utwd4r3aH9r56O/HNqcyzRzuk14hQCEUdiWid4kx5CZkQ0SUrqqbcKu5XZI0GRd4+3q2kJYIiXTVM+oil4e/SMr1IFPXHfkW9UvQVhId0zyBuBF9pZ5QAudhLJJ0qwNephmtk6/TFHuLF4EJ/YVMQhAPd3xJUNcVv8otl+0Juo6taRZ4GSErvSEJPAgyz0IGnIwPhk8kdSYdZ2AyoJlb5AJv/W7tEJoiNNd40UinPlazzbeVk1tTwuOlIv5uJcAEiP7WYwufwNUUxYstaNV9KZGzTQiGGLs/cjbm772+3ykB/r2k44w3vFEgU1SfS2udOobRYXNx+st+mNiB8rlbc+XN6e4l6Q45nSI0z8K+rscfpyZZDqsFH1QFkvQrJdDpI+yWQRggUV+rR67cF1O/2ZjKvwJ9J+wpk7jQL9/rIr0xGoQIv55/05ZSSE5jP7JxmQy92we833VDXF7SMqHXIix51sw9WCooYTKgPHrXs/AxlZhJTQj0iUzK1qwKMljM0ZzcGV5vVYaDhBqMZ5xC4DTwEGTcUGN+zwjRK4NEghTIMPXNE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a2f60d-2f62-4bb9-33a8-08dd6099000c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 12:34:00.4815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIX9N7Dol+83e6ocHpKnQStvKUWNoVtMM3/VNwAMJ6z888Wr8YTazHN0IyrR7N7xBLrqV7HJk1jTWzu4ujKznKthkwWtW2ahW2Ghme5wgto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_02,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503110081
X-Proofpoint-GUID: wmyOMyjtGVX8iG5zKVGVma-NdVpevG8L
X-Proofpoint-ORIG-GUID: wmyOMyjtGVX8iG5zKVGVma-NdVpevG8L

On Tue, Mar 11, 2025 at 12:41:52PM +0100, Amir Goldstein wrote:
> Pre-content hooks in page faults introduces potential deadlock of HSM
> handler in userspace with filesystem freezing.
>
> The requirement with pre-content event is that for every accessed file
> range an event covering at least this range will be generated at least
> once before the file data is accesses.
>
> In preparation to disabling pre-content event hooks on page faults,
> change those hooks to always use the mask MAY_ACCESS and add pre-content
> hooks at mmap() variants for the entire mmaped range, so HSM can fill
> content when user requests to map a portion of the file.
>
> Note that exec() variant also calls vm_mmap_pgoff() internally to map
> code sections, so pre-content hooks are also generated in this case.
>
> Link: https://lore.kernel.org/linux-fsdevel/7ehxrhbvehlrjwvrduoxsao5k3x4aw275patsb3krkwuq573yv@o2hskrfawbnc/
> Suggested-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  mm/filemap.c |  3 +--
>  mm/mmap.c    | 12 ++++++++++++
>  mm/util.c    |  7 +++++++
>  3 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 2974691fdfad2..f85d288209b44 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3350,7 +3350,6 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
>  vm_fault_t filemap_fsnotify_fault(struct vm_fault *vmf)
>  {
>  	struct file *fpin = NULL;
> -	int mask = (vmf->flags & FAULT_FLAG_WRITE) ? MAY_WRITE : MAY_ACCESS;
>  	loff_t pos = vmf->pgoff >> PAGE_SHIFT;
>  	size_t count = PAGE_SIZE;
>  	int err;
> @@ -3370,7 +3369,7 @@ vm_fault_t filemap_fsnotify_fault(struct vm_fault *vmf)
>  	if (!fpin)
>  		return VM_FAULT_SIGBUS;
>
> -	err = fsnotify_file_area_perm(fpin, mask, &pos, count);
> +	err = fsnotify_file_area_perm(fpin, MAY_ACCESS, &pos, count);
>  	fput(fpin);
>  	if (err)
>  		return VM_FAULT_SIGBUS;
> diff --git a/mm/mmap.c b/mm/mmap.c
> index cda01071c7b1f..70318936fd588 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -48,6 +48,7 @@
>  #include <linux/sched/mm.h>
>  #include <linux/ksm.h>
>  #include <linux/memfd.h>
> +#include <linux/fsnotify.h>
>
>  #include <linux/uaccess.h>
>  #include <asm/cacheflush.h>
> @@ -1151,6 +1152,17 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,

I kind of hate that we keep on extending this deprecate syscall. Is it
truly necessary here?

>  		return ret;
>  	}
>
> +	if (file && unlikely(FMODE_FSNOTIFY_HSM(file->f_mode))) {

Is there a circumstance where file == NULL here? I mean get_file()
literally dereferences a field then returns the pointer, so that'd be a
null pointer deref?

Also I'm pretty sure it's impossible possible for a VMA to be VM_SHARED and
!vma->vm_file, since we need to access the address_space etc.

> +		int mask = (prot & PROT_WRITE) ? MAY_WRITE : MAY_READ;
> +		loff_t pos = pgoff >> PAGE_SHIFT;
> +
> +		ret = fsnotify_file_area_perm(file, mask, &pos, size);

All other invocations of this in fs code, this further amplifies my belief
that this belongs in fs code.

> +		if (ret) {
> +			fput(file);
> +			return ret;
> +		}
> +	}
> +
>  	ret = -EINVAL;
>
>  	/* OK security check passed, take write lock + let it rip. */
> diff --git a/mm/util.c b/mm/util.c
> index b6b9684a14388..2dddeabac6098 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -23,6 +23,7 @@
>  #include <linux/processor.h>
>  #include <linux/sizes.h>
>  #include <linux/compat.h>
> +#include <linux/fsnotify.h>
>
>  #include <linux/uaccess.h>
>
> @@ -569,6 +570,12 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
>  	LIST_HEAD(uf);
>
>  	ret = security_mmap_file(file, prot, flag);
> +	if (!ret && file && unlikely(FMODE_FSNOTIFY_HSM(file->f_mode))) {
> +		int mask = (prot & PROT_WRITE) ? MAY_WRITE : MAY_READ;
> +		loff_t pos = pgoff >> PAGE_SHIFT;
> +
> +		ret = fsnotify_file_area_perm(file, mask, &pos, len);
> +	}
>  	if (!ret) {
>  		if (mmap_write_lock_killable(mm))
>  			return -EINTR;

You've duplicated this code in 2 places, can we please just have it in one
as a helper function?

Also I'm not a fan of having super-specific file system code relating to
HSM in general mapping code like this. Can't we have something like a hook
or something more generic?

I mean are we going to keep on expanding this for other super-specific
cases?

I would say refactor this whole thing into a check that's done in fs code
that we can call into.

If we need a new hook, then let's add one. If we can use existing hooks,
let's use them.

Also, is it valid to be accessing this file without doing a get_file()
here? It seems super inconsistent you increment ref count in one place but
not the other?

> --
> 2.34.1
>

