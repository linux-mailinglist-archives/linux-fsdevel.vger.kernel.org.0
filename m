Return-Path: <linux-fsdevel+bounces-55929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3353CB10303
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 10:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443BF1886022
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 08:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CEF274B31;
	Thu, 24 Jul 2025 08:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZL0NlmCv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F5wHu3zE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221C027467D;
	Thu, 24 Jul 2025 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344776; cv=fail; b=WbrZJuoNGiNjM5jZFUDS7X/G0wwXoBRlCVegXnsk53lJaluMOg+VlxfxCANhzuTx9ooaJ88uGhrDBYTXj8J1mFzn8cH8oGRBzp/Ikqr0I9BxDHYzSt4YTmYACQemB/OKqYNsJAO8TMkknRcLirOSYSa/tUgv8VVKeGaQiiE7cnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344776; c=relaxed/simple;
	bh=6dN+xg0DqleQ8FWCrwGfdfmH58gzBB/k28QO9aE1/a4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AXJfi3waltO8MffrTIrAN4diI41e1X8Rnx9Sv5NqSShwiwQwkA5qWm8L8rFRjDeB/lsMVkmRN/i6PS6+EPoZgQUzIDZoBcV/pNvkPKsp/xJIw8WJZ4yXona2Q1+EeSaMog8voeoMx5+vg6+gVWYgM5ycpx7bJObD6gqK6/QgjRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZL0NlmCv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F5wHu3zE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O6v7Yl004771;
	Thu, 24 Jul 2025 08:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=dLrMoflUnVNiMJf9
	iLMcRutki6a0XxjzRZ4ZvMJ2Ymg=; b=ZL0NlmCvPf6Hznj3mCHK8dEmwFOe/nok
	c/7+NSZak+OpmC4CFVWOSndO7BfsY32njUnMyNVqlZKbQXNdidqCe5yA47C2nf2g
	cfViNYJPOJ78A1PlLGCLQa4SpEvdEmoTUmefLrzDjsFFT+NPGlNjMUC+yf3OA6lr
	97bxC58jbKrqZuctCLleCPjMONMrv3V6E7dadwUR4o9xiCzSBSSnHPxMD9uYdglO
	6EF1L0A/cVgoCevbIiHVyGQRe87rFWflsR28YnEBTzP9oxQjMNnVBET1dlV/CxsO
	HbWYjhvAfXVYtpBqxacc5A5debU5ixcycJLfcpGg8l/PBqKYbzvlyQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48057r17vb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 08:12:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56O7NVFW038566;
	Thu, 24 Jul 2025 08:12:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tbkyhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 08:12:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lmd89dYUi2s8+8DtGZNctMYr9DhwJejr/8k4EWyOMsVXMn23FIjPkZWU2HuNyj393YcyX+h2Pn9ZTZcBJMwvB9ZESjsHoQa80aV/ei+5wUt87to3ByedY5UeNu6nMPkP9QJ8Obc/+UpSf97cZ8EYiso49SX60mrA/+ZycUCGPsx/HQXp6Zt6JkEvhCDP0XZ7xkpsCCikH2ftgOjPsoniHXx41u8KkL8mTycYxjY/iOuqz9mPfV1unCI2JKVsh/4SAms2umeaWf4Oq5p0AERPviwPn9gTecErZ/948ON6+4ijRFCa68eYd91SYq8rkVxBRIuoCAy+8Im2qIwYCVjv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLrMoflUnVNiMJf9iLMcRutki6a0XxjzRZ4ZvMJ2Ymg=;
 b=zJnV8EyjnprrOBkBLdernuLIQKiGPWqDwvlK5XXt1fOKiFm+0MWKtDzElg5DgfXdWaqdS0uyQibXRRmOZjln1tcBdmx1rtQCk67vK6tLY/X/jqfx78JMlV3drlAhWSI0i7DAVBcK5OWkkkfEa2Ik/YPGlhDlRCS5nFxlqyyX5FY1A56piLygBq7LwXLwZ0B8kk+5xOZGNilBk2U9nDk28kgK7V3yl1ZytFKkQ9zEZeV0Uhkn4QBSYa278Q1hCFyqWRdnBzqNGSKKH8U1xaxuiobu12XSnXJo1C9B1E8bfh0oAhVJL+guobcAZNqJm8oHxsvqwz1BpQQqxjUgWnhtsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLrMoflUnVNiMJf9iLMcRutki6a0XxjzRZ4ZvMJ2Ymg=;
 b=F5wHu3zEaiGx+elpqezh1hUCAmR687ieG4m7MksS8QfUDtMamMGJrM21AdzqfVdt33i3YEho5fvvh9+1RLsIwCkp1mQ+K0nfuxa4tCXwVnht+iZDnfO32XD1rQp6YB/IVtvyn5e8mDMjUeRdwynoiP4CbEgmyP5DQuGsoK9ysv4=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SJ0PR10MB4815.namprd10.prod.outlook.com (2603:10b6:a03:2da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 08:12:33 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 08:12:33 +0000
From: John Garry <john.g.garry@oracle.com>
To: djwong@kernel.org, hch@lst.de, cem@kernel.org, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, brauner@kernel.org,
        viro@zeniv.linux.org.uk
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 0/3] xfs and DAX atomic writes changes
Date: Thu, 24 Jul 2025 08:12:12 +0000
Message-ID: <20250724081215.3943871-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::9) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SJ0PR10MB4815:EE_
X-MS-Office365-Filtering-Correlation-Id: c68e673e-3f2b-412e-2fcc-08ddca89d77a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3XCMWx20QTHv+A9AcwvaMtD/Q+acCF5IFTF9WUuZogRPVAn5OSosEH3/aM6i?=
 =?us-ascii?Q?lmx2pzDzycZTTERQKMo7PhXPGLu8Hi1aAdlXXNCLbznWZU/RKaGp2b5NNMAj?=
 =?us-ascii?Q?2AGcY9eLedDUEEUS477khz6clSvbYkgoqNyPl3HSZp18gOYogXirlf7bUmKY?=
 =?us-ascii?Q?GR5RcKhzwYkC7cuI/12UbwZBdMO+vIZOaG6IAuTVsoNC2lRyG03Tfwr1Yfvd?=
 =?us-ascii?Q?TRxJ1u1+JJ88NSFZmUi/slERO+fPNHHzuLnq30f+VdVqbGmI5idmD3JC/Xlr?=
 =?us-ascii?Q?0nXb+YPCDrlptk804+52iYUAK12kv9VhEmF4dVno3qdMm8m9flxQ6bPMSi/N?=
 =?us-ascii?Q?bz6aK/bB7wTCorCB5IS0a8fmBZx6VnH87frUtkS3WPQF4hG91NHuAg0a4b4I?=
 =?us-ascii?Q?dCw6XGKN/vdQq7kf8Itr5W1oFh4GxCevyV8B1mZhsh8YNuoNoCwz0jtCrXdE?=
 =?us-ascii?Q?6+HPUhdXfoXtuhHq4M6KUgMzfuZ7p2tS1i45w1uyVSTQcYZuvOBGIa0POHbv?=
 =?us-ascii?Q?hisIjDQV3gZAWiLf2HWMEZzLL7xMurI+awt1Jb6Gv2NO82P3mOPRj3OeljXW?=
 =?us-ascii?Q?eL7r/K6kuY0f84ajYZAmSkJcMASVuBTULHDEOr4A7Ohw1UAkfYYMWAdvnOmy?=
 =?us-ascii?Q?FOqsyoC4lLKd6VDdGnTs6A7EQHZqU6fdZc9sebG7zW4i/6y0UzOTxyIYzha/?=
 =?us-ascii?Q?R6AavbRBtXsn6y4VBNIbq5my2yWOT0YffIxLvC0XrW25nThaAS28GQJZFOKo?=
 =?us-ascii?Q?OjOvEprkal8OgLPwnCpIkZ7hsTNUiRJF9xdeelXq6mEWwKJ7N9nV/IS7lBPz?=
 =?us-ascii?Q?URpOuwgj0zA6PrjY4mQ/KkaEND50439874T+bAUroSFmEBqiGJTL0IP6+DTn?=
 =?us-ascii?Q?LFyvN/CO4n5PD551uugyk39mlWlCOrk9m1gP0Cbop26UoCG+iGTQ9Mgw6TtZ?=
 =?us-ascii?Q?5frnITpG7XCifdHxBHTRV+6jyaaD/xzeflxIhNnulz+hGh0V8UlATRVysHey?=
 =?us-ascii?Q?G38jFg+xTL+n1sSFOtDmVHrUYiQRvgtXUHGcjeaaCaiNdGcLw8QtQOGeaDlV?=
 =?us-ascii?Q?e53fW+LysGHusKSCNZQZK4Mpf51QSL6Zp4CY33y0GB31kiFLqbe2WCQz9n8t?=
 =?us-ascii?Q?6EjMdCl1DVnHGGD+N3tY0sC6FjPw/ub9VbQ4fiWPP3GMVvIU9Qz/ywjrPUO6?=
 =?us-ascii?Q?xP0eowaznSHT8/4eqLQi0H6/5ctPynkZC1jMYj2Ias+GVZ7wbVwr0HbhvAtr?=
 =?us-ascii?Q?AMMrHxYhR75yC+p/8IT9EdmaAMhZCLuKIYQSBsay6XH/M9Ab8O9Prikwc8oO?=
 =?us-ascii?Q?8VKVbKivdV68+K+4MGz0EG2hEdtOzfkFDEmi2UOfJ8eAadTP7/8x42DTi27+?=
 =?us-ascii?Q?8p1drJnig+pCFEVVbf+rsckn7i77WxaoUaAc1HTyNgdZc0u/pmT1vRQC15zV?=
 =?us-ascii?Q?7MPpLTzP7HA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TYBeR5zjuNRhOyuiA2ubcOSSqcPxEvpazY73s/+1WoVP2q+J5P7PQ7WD+R0f?=
 =?us-ascii?Q?k2lCngidjjiRN4IfkyqddP/nkHcYOtDcL4db4R/Sr7TsAerdLBzxCKQ7XK3t?=
 =?us-ascii?Q?ClrynJGtxEnUazVBjJNYgz+tn4M+NUNj9iuYpxiS4OujpIhGzGW7smJIBmF/?=
 =?us-ascii?Q?Lb2vlHQ5cYmOXPwOJx+THOStrHwZOwoMb0A8gdlaxXtXA5nBWGBMYYZIKpKk?=
 =?us-ascii?Q?9DB0GlFq/JvqNFZ+G4OGPrGkyi2GzckO52KUZ8jDuPNt7H3Wghs+qg3Tx8P+?=
 =?us-ascii?Q?z/BRnneFGAYV72sj10ecqfCmWIKIK8CX1MlU/e2cVl64fMkZxpDG1dE63/P9?=
 =?us-ascii?Q?1Zrh2bt4rpuFkhHNf6/2IKfbXqJH7PBtlms6vTrhiFCeNfHwAXURH1zklHoR?=
 =?us-ascii?Q?MUvojLwxvatXtE3P/qb1wdxzIJrzG218zin8nDI0Y5mQnROaErZnro8SbzsJ?=
 =?us-ascii?Q?DwLnnmY+IGpgbyYT8bK1MxDolDZ5N1SFUQOeuAus3uxjymxoHRYWliGXfwKL?=
 =?us-ascii?Q?c+e2DHUng6xSW7+ASdqxWmcXqD5vosZMqo/ZX0eelRgy/idcs5Wr2YLyVy3Q?=
 =?us-ascii?Q?WTH9Ptd+WiUVviwZ3Wq1UlQUtr0WVm8/UJAMfMRmNOL6GhhTr0hvvoRX8MrX?=
 =?us-ascii?Q?RD0cen/Y9dA+6KMlNrkIp3YR2ilw5e8wONQx/KJRDNQ8+Xk3gxPiR0pFzw7n?=
 =?us-ascii?Q?haJ7JLuGjkqto3QjIp0VX5Ykb5ZGg70+tayfG87Hfv4zG8nqyvjAF9475eSY?=
 =?us-ascii?Q?8cHPMMIyJuHkGeNuGXBSXboGjzNrWFzNoGOMeSBOrw/X2EcvoXPv+Rh4l6KD?=
 =?us-ascii?Q?sTuW7jlxIqHZW0HB6iSwp8oCbfkgYotgdHQgzqTa2AeeEMCcqjy0hlqT0hCu?=
 =?us-ascii?Q?fUKVk0Dbxzh16air1/he1HJVNHNntKeZ0FN/CaRmByiawXM8t9zTGxIC2MV1?=
 =?us-ascii?Q?8qFk/78Mun7xcG7SZOAEcDg+8w/VM1aGsHoMhVBsPMkJpRJkW45aflaBQV30?=
 =?us-ascii?Q?cFbez4OmqYU48lvCEaxyfokOYhWiuL9htx9i5v4YjX7ytvTOWwz/iKcj48c8?=
 =?us-ascii?Q?3dx/bbYqEZwm43NA+ljSdcgzNJwWwr56ePtBoUOlitt6VBiOnHJjk0O6HYtA?=
 =?us-ascii?Q?3hCJMgIKY220/32EqjgyQWlCtb+JutQY9FaHRakEhwyavJGIoK+Y9B25UaXs?=
 =?us-ascii?Q?BlnjrAoxcz3lcRpF8h/UK0rWoTO5gz70NNELkiQpKCYnDs6alq+jxEl64Pzv?=
 =?us-ascii?Q?oEc5gwWHHSsGRM7nEjbAoSgcS+hKSNtYq4cbdG2fIXoCudboKvF0GdrjtB6K?=
 =?us-ascii?Q?MNOEs4zeAusceYQIY1d2kUrvFxtli3qiNfVpbN73qoufCn9+WHMrrW3FwYur?=
 =?us-ascii?Q?QoVY6061YyZ+xgYW9DrUWCAmz0XAk4G2B5QFTCYd5Y3dbmbwjUrQE4/MWUry?=
 =?us-ascii?Q?zpzR0Rk+wnsrVExi7pAxLf2siaz++03wly66hoZkeFyoWZEhRRI2epOzDPX3?=
 =?us-ascii?Q?cwR0zqAJYWfoIDzks9z294iAHcCiQ/sVTc8HnIoUrh6r4GRSgSVg4Sorj6Zw?=
 =?us-ascii?Q?r9b5vMfm55Do+2Vp6FMpPUKuhEaf6cTi5Q7IyXPMgxvKnFzl4Oc5O9oH6hk6?=
 =?us-ascii?Q?0g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jaZ7u8D9joPxzos0NArXwDsceWfvAyQD1YjB8FXskVG9omBMBMpTLbMXyN3kDhTM7y5tNxhX4hyifye9e6vUh91pGTxXGR3AvsDR/4aX3fCwrec2m2cu6RClRT5NJUW9EVVC2jB9Yt+eFlbzApg8kaIGJ0KjtnlaAGkeQEVkF0pwFtIBqwUHKe/0j0hhDtq1zCSyXUxrphR/44aDZpJTNBUDpTc60txv+nw5imp7JZ1R59hFL7XGR5NGEnmpQzAkVdWo8dHzTL2zQPyvc5lmICcj6PEpFQDHuLjHSbhQwTrzjePSww5tgek+MBl/cn23VdJqcJS7RGw+yJdaHYySDBX+pCd9m8Sx6WhX9l9yTumkl/4RyZfXpOHsP1YJGbBQK7Lgglv2MYInA0yIEgoiP+nNo8Xv04+BW/RuwvKEWqV6LykKuJcE8D1N69By9h9lbpaAHjALLYeIBBjg6dgjG8R/1oEctZ2CEUZ2CXWXjTSuDMPge61E5QCXh2/kFTk4oRNr/DitW2IQZMa1jRwEUd1POyT0abmhbdzKd0NU8osvmfczAe5WzKr+mXPkg3mQeCNTOGwAlDlxvZKaOxSL4Kj9a+Hoikhwpqzwpq47HTw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c68e673e-3f2b-412e-2fcc-08ddca89d77a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 08:12:33.1940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzBPhKZr+Cb+Vo3gBHOcDnxveTeEWDvVWgAxIBqWkvAbsENeYWUYdoKcYJf+VoZwHDLiNJ0Qb2/FdinembEEZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4815
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507240058
X-Authority-Analysis: v=2.4 cv=MNRgmNZl c=1 sm=1 tr=0 ts=6881eaf4 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=qYlOk1K2zE_LbmFmADUA:9 cc=ntf awl=host:12062
X-Proofpoint-ORIG-GUID: O0D83-7GNTHMnZgd_wafdR64oXKvMtAt
X-Proofpoint-GUID: O0D83-7GNTHMnZgd_wafdR64oXKvMtAt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA1OCBTYWx0ZWRfX/vhQ+F4gvfNb
 dxXtc2Mk5458uzv+8k/T+HaY1gI2AMvP9pExsCbsHZ2sLO1EWnKnzoHuvn7Z/xA4bTbjj3H/BTU
 QdWqY6h9jnRXD2gjd/yIRp1ysTTFCP2f8Pq2Ipur6YGojCJIVqHRLO1gyfF4h/i9B34u/1aZ115
 lVaoSliOfCBYR3KatyL9Uh/Qq2fPxM4Vei+ywodUYuczLT3zPnW0I1OsSJlQftoYXhW0SJPG5KP
 vbZNySxU/SxhrTDXmKpYgj6wVOxbnXWO44Y1697QCXYZ7QYFMhcZT9puoVYgo6qXM3mirtqcB0H
 dQyikIRejijX2wGxeFYZ9RpYCZp3IzTCvbzOV3wAvtMb5273kaQaQ5XQekEoIuoiMPINEHadNZj
 NNi8fGyp9A+Udx02L6gJ7Fce1qj19e8nUiiG9UE+zxtNGc0RtPHx0yezxdvEj2Rr6e08Am9W

This series contains an atomic writes fix for DAX support on xfs and
an improvement to WARN against using IOCB_ATOMIC on the DAX write path.

Also included is an xfs atomic writes mount option fix.

Based on xfs -next at ("b0494366bd5b Merge branch 'xfs-6.17-merge' into
for-next")

John Garry (3):
  fs/dax: Reject IOCB_ATOMIC in dax_iomap_rw()
  xfs: disallow atomic writes on DAX
  xfs: reject max_atomic_write mount option for no reflink

 fs/dax.c           |  3 +++
 fs/xfs/xfs_file.c  |  6 +++---
 fs/xfs/xfs_inode.h | 11 +++++++++++
 fs/xfs/xfs_iops.c  |  5 +++--
 fs/xfs/xfs_mount.c | 19 +++++++++++++++++++
 5 files changed, 39 insertions(+), 5 deletions(-)

-- 
2.43.5


