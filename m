Return-Path: <linux-fsdevel+bounces-30360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6314598A3C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 14:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863A71C209DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 12:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AB918FC75;
	Mon, 30 Sep 2024 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IQvPc4BS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MecyCjAG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937AA18F2EF;
	Mon, 30 Sep 2024 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727700989; cv=fail; b=HRKFt6s6Le1KQgdaXnyg573MhL9cPVZamkiuB96jiGIR9wdJOzq5W+VHi/JaQrPMOpzfiHZVR+0qlkFAwQTUDxkElj046IFFbA7pbcKn9oCq1fycFrbPmZQ4ecpSvCYN6f3+vW8bm0OXMwSA3ZtYOZUP4DLqGkqXiWD1FF+cmuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727700989; c=relaxed/simple;
	bh=FHkVaPHUZqBl4IpCmhMM+Bp+V3PLQFqG7g969l6GUNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g/DZWbo/mQZ3cZj0rNkFf+TgxIq/PO3gDnQQzMaTnwumhbEW1095Iiih7nf+fv+86B0Xbm/us4Qkuh83QJ3kLUlhTgbKXTnNepyVQXm+Wig7UVKFEauazKREobGwl1HlM9ABIYVAnOaigrGZa4fjez8rxQm5cFCmyywlN3/Omr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IQvPc4BS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MecyCjAG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UCS4NO024759;
	Mon, 30 Sep 2024 12:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=iws4QJnNk7qazHfaWJ4rEIt4BmfzF9We8vbjjiddLNU=; b=
	IQvPc4BSD9MwEme67R0fIyofIzEavNtBa4R8ncM1owDCPyTbOPZmziJ9Jfqzk8tV
	oyPwsvUMfsL5L9c7G7QHfwQh/yTjQvhwL9WtKFlWK7S6XTPgpPvrXvuN8o4glBcl
	Ki1bIhyIrb/m9vq6WHftFxKnQsccYHfEfu+xciBUYeebaN1HAD/r78dPaPJvzEza
	vNO6p3f5Y/P1bcGkQDfOlKWOx0k1xW1GXKVGNED/G1jXA4FRfAb5C2eeTY93yecc
	Ww8rdhcyFE0iB4usJ80SkJJ8mUWoKqyexvq8CyGQordLrnAFsX4CcQexNSA6+apM
	l09sDqD5Hs0GvMwj0EEPfA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x87d37tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 12:54:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48UCFfhS012508;
	Mon, 30 Sep 2024 12:54:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x885r6sm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 12:54:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7kERpwEOZfJLf0OdLNAx7CBK29i5ckdhgEVLXrIpm+VvJrcz4LglK3ILD4EMvmx64tpbiJLUgLpGHFXbPZ0dHY6394o4OB2PEQCEXB/ud/ust2mGGpXVPXuBavuS0DPwtPpBrOnhQyKlMhof+lsYzIPh31lQ+PEXaw7nm7jlHDWl/MCyj3dqG8C6fWJEdit5qLZkX0+SXb2IFAlYk4hP6/2kyhcKNgY98t6JMWq1QQI9ZeAlPRoAyOHLrucqQiqjgAPi3n71ZBXEo+vgUOWiznGs6pigYLfVIPxWsuZ2wqlArzUXb8old3ThyVkQwCtr5jhyqo97DtdpYcTLZemzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iws4QJnNk7qazHfaWJ4rEIt4BmfzF9We8vbjjiddLNU=;
 b=tfOP6EzIYKQa8Jmz2ehOwgO+BElsrRB34NSckn7IzMWyzs6vHYvCq/IYQRVPgW2pk6vFrvnVZF9sWVH75ub/gc2QK2oo7ggrlRZ+cCPy5PGbtr5Q5JZe6oRsyvA8OCYwz//ncWGuivU90LdSwJNYC6/P/S6zLbCmV2132YKA301aKMcuwrk5qqoYoxsaufJCbhluc9vASQQiYo8R6FzG1lQ1UWvDRa3NE3s+bu6o8BtHEgnwGmqEAcQJjGglSm/a3EmN9fqHwq7N9q39cC8F/CwlxJqCsI72wK4eCjCDqdvyBp/9poV9PaqdXOD/idcD6I7AUIbMXgJXJbznZ1w4Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iws4QJnNk7qazHfaWJ4rEIt4BmfzF9We8vbjjiddLNU=;
 b=MecyCjAGVSyv5zZTSKbGYJhuGjZwqgk7g5aUKgMRns0xVlzQKLsmHY5E5lOFLLi9tiiSCpfXvAqmbvATIa5Pf84vQg3puKkIeszUggEH/Iw3K8yTPH9QCnNnGr9kThZYEMuuVKpeC2O+uQmQuXtzGTi9wNiKMOIZDX9hfQsuxi0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BL3PR10MB6116.namprd10.prod.outlook.com (2603:10b6:208:3bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Mon, 30 Sep
 2024 12:54:52 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8026.005; Mon, 30 Sep 2024
 12:54:52 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 1/7] block/fs: Pass an iocb to generic_atomic_write_valid()
Date: Mon, 30 Sep 2024 12:54:32 +0000
Message-Id: <20240930125438.2501050-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240930125438.2501050-1-john.g.garry@oracle.com>
References: <20240930125438.2501050-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:74::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BL3PR10MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: db4e2afe-67c2-4d19-20d2-08dce14f1385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tG/jYAKr+YUsm0J0a6fUifwpdGj1i+1YWO+SIhb83jjuXvMSUimL0k7r2Vfi?=
 =?us-ascii?Q?EPX9MEfaHyPcarNQV3lQdpECcBsIdSKevbjhpLBV/YIAe1iv6N7zZHEKYeDw?=
 =?us-ascii?Q?aiIJJD3KYTW/PrlKpHKTxqmCdgD2JUf6RBMt3zk2ADrokqdRvmNtKbLkSoTi?=
 =?us-ascii?Q?E+e5sAmpU7xOxNo1LL54SvTMcpSTHzRf6CYCd41lmMtSWlPgZ2Ul6WojzsiD?=
 =?us-ascii?Q?4C4eheYmKKRtDf8BKEekOlCX84myxUNr7lwvlKk3onyNJHonDWr4qlHwjb/J?=
 =?us-ascii?Q?IuXH/MbN9w/mPCGHxQVLbmMRO7vrM3e/srLoPFgRMVgD8u8PkunD65Gki782?=
 =?us-ascii?Q?JhRfNNYurp4v8YlPC2/8YzVBJTK5yc9ziNbzZszKFvfHdsFZVO9+Tez0psWS?=
 =?us-ascii?Q?t21BAuUOeQJWWRq8ITk80FZ9lS3mzeStjmumnYY05Ay9JeCG62jnyPr0zheD?=
 =?us-ascii?Q?mbwf2lRBqgd2n+XmvMKGYep0MzPq6n7u1HhT/ChAh/v8yAZSK7wmDetMxg8/?=
 =?us-ascii?Q?WAr1I48BSwhZEJnJUre5GR3miBL8q+A3GPOOe50KNR+l2+R719/ngn0k2Jjj?=
 =?us-ascii?Q?pHnybuq31R3iPmramllIBnu9JhTrA9jHL5IZBtY8wG05G7e3mFLfyxEoQUQo?=
 =?us-ascii?Q?nmCiMwT3lusFbpZs+/aJTfoZmkmXrHMuDnoCyI+aDKTwhWranxH2GJi7KkyO?=
 =?us-ascii?Q?ZDT8GwncKqrEJ/vpWcCM/6XUrTcXk1MO07NAnBCnByfMbj7/0+ujeiEBMsKi?=
 =?us-ascii?Q?xd2P5pOC2MmKobYOidiVZ5aAyWEelY0nidsRH7NcdCTq4T2IjetjyZUXbrtx?=
 =?us-ascii?Q?FnIFcEI9sCHdoJaO3veywcAO+1lxucfMdHcHG0wiWhcyGG8KhszU5wSoDVmx?=
 =?us-ascii?Q?LI5dIw2IbdVl29rpSKezDbvM+Tl2bJKUYlER3J9GjxCO+x2LoU1F3MzTp9Ju?=
 =?us-ascii?Q?J8UQJivfKWf4fuY7FFea5rnqc2g2M+mav/YeyMqfyoUoJwYS0yDyW5FUSB7N?=
 =?us-ascii?Q?uy8VdMlLahh+b4VX0wI0vIW1D3ME9ZU7aeoeok2Dnih2undWS4W1eg77NECV?=
 =?us-ascii?Q?WbRyzNB7NDpPh+kf+JvU1vEhaX8E2gt8FTBKI9hRfFyTVLvrrvYf5B4M4DqT?=
 =?us-ascii?Q?u8dKXXq4pKu7OzaZqo4JBUp20Qunt/aG68DuozoxpbdCohuudQ0O9y3ifE9F?=
 =?us-ascii?Q?6xqZ50mwdBUodJ5a3nW8cSYtYjPYwXyrsay+MJZwmIfXVc9BnCReEMMca2Rz?=
 =?us-ascii?Q?w2+fVZZu8lUFY1vr9eTaKUcFf325tSk0n3CNoaIS/vQ/SNl6tb2EoLs4hvDX?=
 =?us-ascii?Q?4Pw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5spyshRV3O2B7pfkwEa0UPVXSmMlWlL1DEu04YrwrEXSs4Qc2pKKRgdB4uXr?=
 =?us-ascii?Q?/UKpG1ShqFgjwaK3gWU7Tu/sNBo62S9ke4BmOjgbY/8A/MVFxjLgkTPtpcOR?=
 =?us-ascii?Q?dv+UYaw8/3F7dYjX2PAIj5NSyQw5gVvXJTdau7+M91F6JZfwPFCxtCe1HGNZ?=
 =?us-ascii?Q?MfOho3ziIPncQaC8HjttWntqZpBx3Ze2tg94QqqOyTv13YGapoU6TK0t7r88?=
 =?us-ascii?Q?hbyH3fxaSPbmZm/T/wov25UTGX95oU63pnHUdr31ATadEWQAaolbySM24Q4T?=
 =?us-ascii?Q?BROATiAKSlCFffjXerRO/k8m/zOVNqDaNtKTFXI8lrUfq8KjRLZoVv+PMgJs?=
 =?us-ascii?Q?qOTv+L69FI+LBRWUBoL2Nb4F1fP/Jj5ejQTSONDHOi/PgzkRUJ6WMHmFV64i?=
 =?us-ascii?Q?UQRxIif9xmfEsGdWrkAxIgoCG+aRGFNzOeRs7FP7zcHMVaW6OnyRoli2rXLa?=
 =?us-ascii?Q?qosf3Z1RWvwDOziOkCF7qPe3ZChmL725lC+cebNxmBmzD7mxXwdSHUuHYPhz?=
 =?us-ascii?Q?dtbIp98JT8Txxq1LpLt1vlm7a4Qd+SYjrD0q4FCyAiKDzrAoJq9mU5oX/GZE?=
 =?us-ascii?Q?lRYPknpXAqvOLcSNlbcPEK0kDh16MQcJjTDI1Py513/1erWbWV0azzpy0pxj?=
 =?us-ascii?Q?9DL8Ups9d1NVDOJLd1u5fAREYwpek0vO0sQ0DQORAcrM3HGB0SeV5QFVjBe1?=
 =?us-ascii?Q?Rc4cVQr35aXSCDosPaD2jVuVqPmjh+yXT1TxqgQwcxrmkoP+bq+yASz4dzd/?=
 =?us-ascii?Q?kZykQGsyKYYFNA2WD5iWkrUcz4uvlT0izag2VJSoALRpIpQkrmlwR/iLzBb1?=
 =?us-ascii?Q?nOTTzD/GvwwD7bDWC24jJv52qbZFNX2QWwwH/Nghh2JDLVOhEBboi1xq4esp?=
 =?us-ascii?Q?SaU+lgiutefI6bZ30z1/Iw1bt0TEnB0GY94HANjn03Le9SDmUcVHYqjDRCI6?=
 =?us-ascii?Q?+XjvGmnOZQENthpzeGeo9vrg1bmFderV88Z/kHRyFEdwEhh1KSld4gwRveO/?=
 =?us-ascii?Q?lRoPxkj1Jb0LZM68VVzrYGo7XFOaj3HghgyvoLjBbHOD5eItZtg0gxpuLI8f?=
 =?us-ascii?Q?lUJQN9Pz+LmcKiD6JPo6tSj/nZfr4CHqQ8yWn+7SRI7mBhaIyrQf4ZdMDrB+?=
 =?us-ascii?Q?xtp9bv7++5Md8twznUAIVFM64qC4zPG2cGq/POAUEFznlHp/2rh/LzZl4Kn3?=
 =?us-ascii?Q?RJE42jqGlgKIG41TpWfE6Z3kgyIA2yM2e0ovdgwU7dhxcVexHpyLi75n/HZn?=
 =?us-ascii?Q?KBmxZ2NxR3yQ2s+pkW/2zoDtwy4tvjXA5AQbSwbJ2DLalkelC3YkPau+TqfX?=
 =?us-ascii?Q?wmQknUjSQ/aImyDp80qqG2NiUSJI6bUap8sDcCgEIveJ0WYIU3qQFPfTxyMS?=
 =?us-ascii?Q?SPH4TboQOk36vVwbSV2U+3W1LUDQoBR4/ZLOLlw3w56K3WLIHsS0ltlV7/Z1?=
 =?us-ascii?Q?fGxQ58H+St3K8skD/zEKNo7W0can25AUbWIQ5DkUeff8RXH++o/0duewTcVx?=
 =?us-ascii?Q?gCoE2WnOADYF6KUqohOA1AKBjzsHEpcKzMcGQe/IbQE7Af+OPpZdzZcxGZGj?=
 =?us-ascii?Q?xq3TuYMXa3CoCBWaceHKQOYxJH4NgycB0YrHJV9rNtugGiJAIzF2QsjCOWAQ?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	39CLJVffwujQJnVJ/xd7exfyOnV/NOSMhp0eBV4jaVElnwwPuZ1g8/zb9qtpCcJCdl3opfujr6TtgNSVd3bhyPe32/FijIGrnXq2zgVpaYU7QA9QIazNKSiMY9sz0NANGQlD+ZV6UQEsCEhoZdwjM8h40z294D/PAQiNMhEQYIzN3nCcE2xQZBpKp9vM43nJBTdki+a3fZ0qyD/9rCEOOk7sRAfvE7ehx6QLLL0SIxLARhrIxa4sohXkB5is5/Ng8JaSLTZEuzKgG+bXHrchyOgvKjQ+Zs++55rQ0w3Bo5wLW6yIghcvY5nIx9m+LBgB9LLzxK0sJRWR8zvfUWp7YMskb4A0uQdMLqxqvq2RaRzkRFu3AxsuvJq8k9T+yK8oHmfBP19vGflacCipUEmubQj9YUv4duIpZRe7zGxDFr4CahthhR4bXGtAY4kRsrTRHhu3rVrv0it5TmFaom1LVN2y977b5M6N2Y8/xYglKBO5Hxs75pQs3SHCJfOUqfLZyJxvRhxsUYoRS3Tdv9TvC2aG5gGCPVPcw71dcT4TJvfq/uexR7JrOm9OfhLaZM9fGne2/lxRF3tCICYYhI3znbeXAodBqf/IGA4TB0iegOQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db4e2afe-67c2-4d19-20d2-08dce14f1385
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 12:54:52.7585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PiLDnWiZ9U5ajZbVK4eYjWKFsXsEw/0GEn+GlF/gsjfUCb+0I+SxiFh67xBV/ufmVedg2id3icQQGo6h5861fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_10,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409300093
X-Proofpoint-GUID: D74Y11sVSREoQhx5ber9N6MritbrWR7U
X-Proofpoint-ORIG-GUID: D74Y11sVSREoQhx5ber9N6MritbrWR7U

Darrick and Hannes both thought it better that generic_atomic_write_valid()
should be passed a struct iocb, and not just the member of that struct
which is referenced; see [0] and [1].

I think that makes a more generic and clean API, so make that change.

[0] https://lore.kernel.org/linux-block/680ce641-729b-4150-b875-531a98657682@suse.de/
[1] https://lore.kernel.org/linux-xfs/20240620212401.GA3058325@frogsfrogsfrogs/

Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
Suggested-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/fops.c       | 8 ++++----
 fs/read_write.c    | 4 ++--
 include/linux/fs.h | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index e696ae53bf1e..968b47b615c4 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -35,13 +35,13 @@ static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
 	return opf;
 }
 
-static bool blkdev_dio_invalid(struct block_device *bdev, loff_t pos,
+static bool blkdev_dio_invalid(struct block_device *bdev, struct kiocb *iocb,
 				struct iov_iter *iter, bool is_atomic)
 {
-	if (is_atomic && !generic_atomic_write_valid(iter, pos))
+	if (is_atomic && !generic_atomic_write_valid(iocb, iter))
 		return true;
 
-	return pos & (bdev_logical_block_size(bdev) - 1) ||
+	return iocb->ki_pos & (bdev_logical_block_size(bdev) - 1) ||
 		!bdev_iter_is_aligned(bdev, iter);
 }
 
@@ -374,7 +374,7 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	if (!iov_iter_count(iter))
 		return 0;
 
-	if (blkdev_dio_invalid(bdev, iocb->ki_pos, iter, is_atomic))
+	if (blkdev_dio_invalid(bdev, iocb, iter, is_atomic))
 		return -EINVAL;
 
 	nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
diff --git a/fs/read_write.c b/fs/read_write.c
index 64dc24afdb3a..2c3263530828 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1830,7 +1830,7 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
 	return 0;
 }
 
-bool generic_atomic_write_valid(struct iov_iter *iter, loff_t pos)
+bool generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
 {
 	size_t len = iov_iter_count(iter);
 
@@ -1840,7 +1840,7 @@ bool generic_atomic_write_valid(struct iov_iter *iter, loff_t pos)
 	if (!is_power_of_2(len))
 		return false;
 
-	if (!IS_ALIGNED(pos, len))
+	if (!IS_ALIGNED(iocb->ki_pos, len))
 		return false;
 
 	return true;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e3c603d01337..fbfa032d1d90 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3721,6 +3721,6 @@ static inline bool vfs_empty_path(int dfd, const char __user *path)
 	return !c;
 }
 
-bool generic_atomic_write_valid(struct iov_iter *iter, loff_t pos);
+bool generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter);
 
 #endif /* _LINUX_FS_H */
-- 
2.31.1


