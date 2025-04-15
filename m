Return-Path: <linux-fsdevel+bounces-46477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA06A89DAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 14:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256DC17A166
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 12:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A36229A3D9;
	Tue, 15 Apr 2025 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e5opsWmz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H6CFW1r7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2848297A43;
	Tue, 15 Apr 2025 12:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719429; cv=fail; b=IDxmw6p7JmDW6mLxmOazDkZ7SlosrA52KLKmR6VSQ8QuFdid6YCeCq8D7xNuldVbdML7Ex5c1GWSINLiMhXRfNlhCqBY4iVN587qSs95EG5tH3r6IyMWyusnVCf1hIMsEOdcWfl4ROf0WGWm2HYkh+dtgRbgaDyQV+bsgkw8XCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719429; c=relaxed/simple;
	bh=aXaR4tZ79do1Fy4OuLBPodUSkzCOuY+03cJewoNP5kI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l4J5XakkjAVMWgu409VCHMS31auPm+UB9nAsLUSc2YgIE1Wu1kkkLTTy9aw7dDdhQCC/f8Xfh98GwTY74CGAqayvSzF/HJs07JckuaVmnLXBRiosgBiAQ6bGqtzh/3LNjmepIrCF+cvSe7dOAJH3nobpDwSlBqzTljeeyTPzljQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e5opsWmz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H6CFW1r7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F6g0GH021298;
	Tue, 15 Apr 2025 12:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=JIURtKTTU8cVWjYG5kShsUH5v7SuxBX/D0/28SLHG68=; b=
	e5opsWmzJNy6YnLTF+cbFhE5e0R6TfKd9Sv/36Qb3p4x5c3XLahrB3HEJChB47ob
	aelrGepCJzX5abVZDtaN5adSQw4LCTvwcJXTuB+k2gtUIqzR+z5CioS6a8XewnjU
	HWJe1mSQDzn+rfYOF9Xf2UhhHlPi3F5hgqjicYTD/5cVnKwnLy/0chnCJiulre5m
	VXvessemT4FC0DRus5RIy2jmTYQsCa63nTo1A8FFGLkvSOOngaI5gZBuflDAZ1XS
	F4RBFF9QsmlH52GbgsquirxHCW1f/TVebvfsDYFRhRv+HoZ9s/nrIsznEIkxPAyv
	unDv5SweJKK+StzLDHr9FA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46185msf8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:14:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53FBpWCD005917;
	Tue, 15 Apr 2025 12:14:56 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010003.outbound.protection.outlook.com [40.93.13.3])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d5v5nwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:14:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2nP/xZJY79Abnpd7BC/CiPJOwtpuURcKRQH2aN56gGbNb3Pxa4Cbvx7r+UvmBCuz9wLdpBBICZbome4aHKMhIbnpV0+cuZ4QMHy7lGqyhfp0gDjCAwUqnzxRLPAbtD2yKDmGK6Zby4Pta+XQTs+CRJv+9e0WB0mrCa7l23QeVnCDYopkRaBVWsqXZNzSKBXqskyBqTs277EZBgSu1BY9C5ttQYuC/q0F9suqCVEkK77vLmADZiTS8Us8I06vcPgocSvIF4ogdYu3hG5vyoG/je5k69uHOXRlIWMiZ0L9iPogx+UYMrmUqnOdPJMK/SN7tbz8Sfb9UJZV+9w2d4RFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIURtKTTU8cVWjYG5kShsUH5v7SuxBX/D0/28SLHG68=;
 b=QVKYdoQ8UVxEHMO7pQdMi8arXxwV6dqjOX1Vs+1djcZsUig8FgffjPCQvfZzNvCRUowciLoymRC/hthvekHHamlm/reIuHpevg7+fHeH3gUduxlQcbdgBYypfn/Ho5m0dpkdB5L++MC59TPdK5Qsmu4EO1pa8mMuTtMwkq0yANunNFwp/RLGdDqnHpIxJ9qzhkJGi9O8YASZ6+uhfvGcbDFGY7vQT41iRr3nkSKqb4QLPIh3HItR9JapaNZyJ8hBbAq2xWsOhS7vbi/ateK005a8qDIeU2XEqWN2+NdOSaWc+dy6kecXiu3xn8JgzgTUrdROlOfkIU9FHg1iv/JC0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIURtKTTU8cVWjYG5kShsUH5v7SuxBX/D0/28SLHG68=;
 b=H6CFW1r7oGoKwrHKeCFAYXbxCzOPrP92U3GV6QvN3zdJcGZaeEU2MCE8KXWYTou2MUP2OEgEMSjOLwz4Gr4ompuCJwZUavHaKanM1u4eliaEzlBYLQgsbLA5sB8nNVpzSr6ecXpHiTSPhXIi1XYzsNZGWC6cKbGc1zEYQL+Oz1c=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4991.namprd10.prod.outlook.com (2603:10b6:5:38e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 15 Apr
 2025 12:14:53 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 12:14:53 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v7 10/14] xfs: commit CoW-based atomic writes atomically
Date: Tue, 15 Apr 2025 12:14:21 +0000
Message-Id: <20250415121425.4146847-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250415121425.4146847-1-john.g.garry@oracle.com>
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0160.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4991:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d94d16-4bf9-43ba-6e87-08dd7c1720be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+ZqoFp0z4BurAWLc1D4i7O1NjyC4XozflLS7QyTrZ3nJGQE5+iwtbYSfL9ig?=
 =?us-ascii?Q?Bt4c+vbDGOih0dx0JYTs0QkZ8LSUf/Z1cHxTTSPQR7MFjX/sgBIT46k9ZQCg?=
 =?us-ascii?Q?G58weE0wcv0wiL41hDz4ESMtypWrEqXJ5ihGlXmaPMyMTgeOyrG/AoAxZHMR?=
 =?us-ascii?Q?k/NwVuQ2ZJnlyUnSP9ZP9pZEau+OzIulRW/bGavs/qgHXOJjBx6D/Frrpi8H?=
 =?us-ascii?Q?ZnvfUWt1Pv9A7YaV45tz5jo5XiTMRnX2+jlnvTCmt2PA9+5/ihjAn66NASyS?=
 =?us-ascii?Q?xHvwD/qhUqgIhhoyFR5cndWfEwHb+oqtrzN8dCrJC+g7P/A9snuFqrFk+hlE?=
 =?us-ascii?Q?jdKwpCASaZ/EqZJ2QotPehDkNw/Q4cFVJs6kjn1nPlmIcqTr7YpkXmQtP1jL?=
 =?us-ascii?Q?xgVDWVphB4FVSxwvOOh0Is+29rKCIe5nB0jcfIPTPbbzXP2jSfRwmsD5lKoi?=
 =?us-ascii?Q?VWBoFNCvR37XDKVw+uN+iLRcTZ4R7p+1Pu2NkDdPEbAmraCXyB/3iUdaUVKw?=
 =?us-ascii?Q?IcUQorf/E1Zt7oYJG+hvcER24vUFEYfchA1rktDeyUCeFC6ivlMqEFxoj7GM?=
 =?us-ascii?Q?8mV6MeujagbVvszEYYyIPiy8wrxKICRpYa22B4lmfVFh6x6nmrxF7xTH/0uZ?=
 =?us-ascii?Q?DtrNaMmXkkI3fNRfY/gTDjmNE64n9EySNYc8Syv8gto35HRNeyd2DoXZyQ07?=
 =?us-ascii?Q?qfpDLw+UpFHTUFvxiivxdGx0Jg8xHBZtphGKTL09ZBqi26lTWyqyFq66U32b?=
 =?us-ascii?Q?0hIPHi6/c8/KPYLBp7pF6hL45dFdMPGkjkrrAlbQ8ZipgJTF9HQjlCXsQZs6?=
 =?us-ascii?Q?A6U2QYjjY9Op/U3zkniN/GTov2m2CAnmK3Ux5its3eIYahX1Wr3ehTTuB8mK?=
 =?us-ascii?Q?djUh8VXo2ZK8ccWoT2gJvAzTJnQImtta1kwBYdqtbeSsGrS4UiWF07dUiAmX?=
 =?us-ascii?Q?04okL37NhlFgx1VpqdC+ABxlGzJ0kwW2EEggp7inW6Vfh+lCyLc3cPO5q2O9?=
 =?us-ascii?Q?MOk2dgDy56ipBZ2yfqFfgdL69kSprutkWU2b94hDf6kItKHIed3xR3K0gK7K?=
 =?us-ascii?Q?AKYQBrv7f+fohiQL4fB2nJekpwf7lZcVaOi2DCCcmzZXT4yjcNrTcPO5FzXZ?=
 =?us-ascii?Q?TIbsdmU3n/hvorL7AMEMAkq6+/SA3UGOO6am0IppoNOqH5IDF5bZxbUOKGMz?=
 =?us-ascii?Q?ZRPvMrz1zmyp+tP9vbLZf/SswBa7M7HS7G7jMB06VsHX4i0EwD7NN0mb4MwW?=
 =?us-ascii?Q?+a9oN5DCF4VpEO6fUYFjUf1/CbEPYvTUd9wjkWlWU3nvM9gNl49x7ns3chAt?=
 =?us-ascii?Q?OtfBlPmtesttgQ3nSSEaOmO0OXIqdGR1taQTaEF890eE52/Rx4+SecYmSFW1?=
 =?us-ascii?Q?RQ4XN0mLis17NeIN4EOQIcqiWPMMIqbj+vF1y8jtLdPV4i48a+cboCpSDJY8?=
 =?us-ascii?Q?uxjSx1GSNOs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4CUt8Nw0BiB0qB16THAFG6D3Mob2ifkWy44Rx37p7sE1bWiukaK1UerbslCy?=
 =?us-ascii?Q?r167JciO9L/JpxYkMjpx/2oLg/0gpfVfoMIQbO6sMNh0halzZtHsr1cH4Zhi?=
 =?us-ascii?Q?fxBkF1EOC3X8ZqaOcAWTixzcG1bk/3QpeF/YLZEziFb+r8x3C0UiIW5Kgpuh?=
 =?us-ascii?Q?hJ1qOUSytpITAf7EXIlzLTBJiGkvdxY2ztGdtImP0F8zVSNe+oexhQc9FhdL?=
 =?us-ascii?Q?Czf8/xhv+KKATOS77Xl9akSdE1NftwLOP0bRo57dv3Gtc5Pki5sMEX5KJKM9?=
 =?us-ascii?Q?fQr6dVxy2SIRVukhtxAlnho5s5klHhTWv/j88dxNKGFxR90OMlSqkEy8SlPl?=
 =?us-ascii?Q?xaWIIk0dOPKffnc+3R20w/MlqHzKkt7Adja5zxnRtMdirFxpCq8CRyH3us17?=
 =?us-ascii?Q?0osJ+gVpLDxO7eMFhykR9CcX27XefnifyZP8LcmfCBQ3KfEWOg0FbiIzx+Nq?=
 =?us-ascii?Q?DBd5hKfIdKpy7rKiEVXV2UbafpcQX9IgjdNxIOLsuHUUTobwJt/quWJMMtKt?=
 =?us-ascii?Q?Bai5lQX4Vi+ajE6UtNHNG1DBPvRQYGbd8QqLW8cwq7K8knAsw/5vb6bnv2Hq?=
 =?us-ascii?Q?SulyA6uf/8GWjvUP2+dI1BLcRLzqPOz17LBMLGK6mnRnjvrPhWjYkcrH5Xgh?=
 =?us-ascii?Q?ht5xpIY5iSqbbeUvxYto0X/h7MJgAovDFJP8Ml45kVTwEK9/IFQHsJp5kuj/?=
 =?us-ascii?Q?+c/Bzkc2DM9KoAmzGeMEOIHaO+dwIwrdHMXjkcTqstXRTgmDjJCTM5JJMAwJ?=
 =?us-ascii?Q?s6xtk/MZIydqJZ5ymHWkRcylq2lo8fzhQSWaYOeukhbrAWPIdezezp2ErEqD?=
 =?us-ascii?Q?wiSYujYcbdkx0FGBUBO30vlGoc7sTI6hH/2FD3f+M3JxZb/UvOXCgisSOSZx?=
 =?us-ascii?Q?VoS3/nPDBRsywpFtEFmlLGEQtSvs4u0YgdAfHYeEpYxe2vq76VyEfyqFyE4W?=
 =?us-ascii?Q?VaGtSv8F/mnUrJPXuMVdr3QftJQJpYex0EtrEP+xXlRfquD47er2hHCN9mvo?=
 =?us-ascii?Q?R8AkCQISzr27jPxTdFUeQgpP11oF9Jeoy3azIMaa69LTw68gb1TyKKb4/CFR?=
 =?us-ascii?Q?8DI0U8LpVvZlg5uu/ysrwG4U23CUWGWkqaalmCDO7n1oeetBQbbz8WgpqtD2?=
 =?us-ascii?Q?mQTocRXRhdcjQsXjrUvOGjGVZbzYfD4LcAEeERG6px+msM0cQD1w8ANGU87e?=
 =?us-ascii?Q?xCaZx+fXZx3d7+kemfRwVArh5aBgJ+2b+ewLacUoW7+DqH7xIO0rcbIHX4ha?=
 =?us-ascii?Q?5RvIV5vRaDr+FMecokaMN4iv+hu+bxvF8aM3tN7pWFX2PK4x3WUsnScUPVd/?=
 =?us-ascii?Q?uzrUaPu7wMRkMDeyNPbMCtcQtIUHda/23iKwAONh9x+GfCbfPdtp8XvLbRnQ?=
 =?us-ascii?Q?IFS8iDAcrydGYoSxiZjsrNbxAntqn/ly+4F4rQpOVnxHQiyd9oCou6AAZTRF?=
 =?us-ascii?Q?qMbTbvK8WJCrqUUDxo+2eoJL9t/QBsVSgB9Z5b2Go9LVk9uG/5fCJzSonWcj?=
 =?us-ascii?Q?CyTsPOHZX/Hqou1N81qHaQhy453md+4kH6O1/o4LgJwq30ujh/hR7/+AsjZ7?=
 =?us-ascii?Q?duaAO3y8+xpf2TDbPJJk5+9VvcshaD8KjPdWWoNgUY2cx6flU+0AWRO/bSSg?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aVHYy1/kA/CZxShMhaU6iNGoLPFiYiIn31Gabk+45lrlw4dVLEz0klnQir6KOe3/5Wn2k+P0ulPkgzB/heG60Du3MCN5SnZ7WzcXsz8BKPZxStjomrtNgTl4n8La9IBOlBgCuCFGyydMmTYGihksb9BFZlzIqcY88PCAv02XXvhDGJ9RE66QSaQ/aRUsPZ7D+FkVnnpXg7Rsz5498xOaUmbEHYL/crfP1sIy0clWZO/DRFx2akMsijd0rzrx6vmGS0231LwZA3V+RNU5/pt41uZIdr/WldIeILt4W/JUrQpk0j1ZkUshQ6UpPd4UYVvFRx5Jhjx12vVpjqN7MLM9+7NrzVQLeLEBdXqiCtBvDBJQF/3Vx9DaTdnCVf3fkclhHNMmmDUyc0jDz04rwUfJs1EkzkfDCCwfCE+JPNfp0yydDFIP3Rx59M3NbRNLR7+fUiLGQmetLZx9bBVYLusFBxZ2obKnVBN2MtvpYH3ONNULH5nYxbXLhfWUOtAbv8XjF2w6zixKWewCxdt7ywd7Hx35MLgpbke9u+AzRV3BV7jyIUFRpLBtpKlUMHZx3o+xPtN8fmNA3Xpm/9agzPCoqWlxDM0HfEuzL4j1pxulS7I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d94d16-4bf9-43ba-6e87-08dd7c1720be
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:14:53.3692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wV2BMlTo6i+4RWGoXsOCLGoqzBLJHQhhgyQ0h0KRvFAxqNOujAzX4hJ58OyNSS17UOdmpbC9uMXLd+7tF5OKBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504150086
X-Proofpoint-ORIG-GUID: aPB0ltmz8QRMWIyzD4hGSDpMQmG3Ay4R
X-Proofpoint-GUID: aPB0ltmz8QRMWIyzD4hGSDpMQmG3Ay4R

When completing a CoW-based write, each extent range mapping update is
covered by a separate transaction.

For a CoW-based atomic write, all mappings must be changed at once, so
change to use a single transaction.

Note that there is a limit on the amount of log intent items which can be
fit into a single transaction, but this is being ignored for now since
the count of items for a typical atomic write would be much less than is
typically supported. A typical atomic write would be expected to be 64KB
or less, which means only 16 possible extents unmaps, which is quite
small.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: add tr_atomic_ioend]
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_trans_resv.c |  6 ++++
 fs/xfs/libxfs/xfs_trans_resv.h |  1 +
 fs/xfs/xfs_file.c              |  5 ++-
 fs/xfs/xfs_reflink.c           | 56 ++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_reflink.h           |  2 ++
 5 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
index 580d00ae2857..797eb6a41e9b 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -1378,4 +1378,10 @@ xfs_trans_resv_calc(
 	resp->tr_itruncate.tr_logcount += logcount_adj;
 	resp->tr_write.tr_logcount += logcount_adj;
 	resp->tr_qm_dqalloc.tr_logcount += logcount_adj;
+
+	/*
+	 * Now that we've finished computing tr_itruncate, use it as the
+	 * default for atomic write ioends.
+	 */
+	resp->tr_atomic_ioend = resp->tr_itruncate;
 }
diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
index d9d0032cbbc5..670045d417a6 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.h
+++ b/fs/xfs/libxfs/xfs_trans_resv.h
@@ -48,6 +48,7 @@ struct xfs_trans_resv {
 	struct xfs_trans_res	tr_qm_dqalloc;	/* allocate quota on disk */
 	struct xfs_trans_res	tr_sb;		/* modify superblock */
 	struct xfs_trans_res	tr_fsyncts;	/* update timestamps on fsync */
+	struct xfs_trans_res	tr_atomic_ioend; /* untorn write completion */
 };
 
 /* shorthand way of accessing reservation structure */
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 1302783a7157..ba4b02abc6e4 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -576,7 +576,10 @@ xfs_dio_write_end_io(
 	nofs_flag = memalloc_nofs_save();
 
 	if (flags & IOMAP_DIO_COW) {
-		error = xfs_reflink_end_cow(ip, offset, size);
+		if (iocb->ki_flags & IOCB_ATOMIC)
+			error = xfs_reflink_end_atomic_cow(ip, offset, size);
+		else
+			error = xfs_reflink_end_cow(ip, offset, size);
 		if (error)
 			goto out;
 	}
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index f5d338916098..218dee76768b 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -984,6 +984,62 @@ xfs_reflink_end_cow(
 	return error;
 }
 
+/*
+ * Fully remap all of the file's data fork at once, which is the critical part
+ * in achieving atomic behaviour.
+ * The regular CoW end path does not use function as to keep the block
+ * reservation per transaction as low as possible.
+ */
+int
+xfs_reflink_end_atomic_cow(
+	struct xfs_inode		*ip,
+	xfs_off_t			offset,
+	xfs_off_t			count)
+{
+	xfs_fileoff_t			offset_fsb;
+	xfs_fileoff_t			end_fsb;
+	int				error = 0;
+	struct xfs_mount		*mp = ip->i_mount;
+	struct xfs_trans		*tp;
+	unsigned int			resblks;
+
+	trace_xfs_reflink_end_cow(ip, offset, count);
+
+	offset_fsb = XFS_B_TO_FSBT(mp, offset);
+	end_fsb = XFS_B_TO_FSB(mp, offset + count);
+
+	/*
+	 * Each remapping operation could cause a btree split, so in the worst
+	 * case that's one for each block.
+	 */
+	resblks = (end_fsb - offset_fsb) *
+			XFS_NEXTENTADD_SPACE_RES(mp, 1, XFS_DATA_FORK);
+
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_atomic_ioend, resblks, 0,
+			XFS_TRANS_RESERVE, &tp);
+	if (error)
+		return error;
+
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+	xfs_trans_ijoin(tp, ip, 0);
+
+	while (end_fsb > offset_fsb && !error) {
+		error = xfs_reflink_end_cow_extent_locked(tp, ip, &offset_fsb,
+				end_fsb);
+	}
+	if (error) {
+		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
+		goto out_cancel;
+	}
+	error = xfs_trans_commit(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+out_cancel:
+	xfs_trans_cancel(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+}
+
 /*
  * Free all CoW staging blocks that are still referenced by the ondisk refcount
  * metadata.  The ondisk metadata does not track which inode created the
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index 379619f24247..412e9b6f2082 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -45,6 +45,8 @@ extern int xfs_reflink_cancel_cow_range(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count, bool cancel_real);
 extern int xfs_reflink_end_cow(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count);
+int xfs_reflink_end_atomic_cow(struct xfs_inode *ip, xfs_off_t offset,
+		xfs_off_t count);
 extern int xfs_reflink_recover_cow(struct xfs_mount *mp);
 extern loff_t xfs_reflink_remap_range(struct file *file_in, loff_t pos_in,
 		struct file *file_out, loff_t pos_out, loff_t len,
-- 
2.31.1


