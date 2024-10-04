Return-Path: <linux-fsdevel+bounces-30947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C2298FFA2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 11:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1441F21036
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 09:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59F8153812;
	Fri,  4 Oct 2024 09:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mf3qQ6y6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E0ef7Hlc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561BF14B07A;
	Fri,  4 Oct 2024 09:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728033840; cv=fail; b=Rzgsa0h29XGCcfxW8nKoK5RS0IykUPL074TK5/J5Fy1BDVQ4YYDVyAnh6wyr6oxyu5XVdmQt+8tqqRrmuMKPKF0Q3E72f/VX4amLfEMxaAmv3GoHQ0dxWZB3W7NEFuMJXZFrOB/MPndQXX3TSOzY/YEhR9Uxp9Bt+kcjFOpiGWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728033840; c=relaxed/simple;
	bh=PRrDkoSeESCFQmalYb0tyyf6s2YdIZ8qgL2KjK4WWoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jLvblQbfzYMXarBQfByHRrfdzIb2mpNwaZ+aYi2YfqOUO2fGuwgku/87ftyyhDGIHvnIxfHQ+AekZcB6CYWAXLe1x1LSzirkufLGNoGIgQWWK1bhEHkt7nojgukA+Ve8UBzWoaoqAbCmvA3tLVY+gD1vvovt30+rT4EoiMPtaU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mf3qQ6y6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E0ef7Hlc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4947tgad020708;
	Fri, 4 Oct 2024 09:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=8MqU1/P/auBsdf7FWpVOBsuUx8R1RFiawgabOzGdm10=; b=
	Mf3qQ6y6nOeQUdONglK40rpX73JQqHz7yT0hWqKAN5mT3lPrJ86/qcAzDeQnndf5
	vIMoRGe6Nb9Rmj5tXBg7G1SJmd/gARiiXEVaNY40Yjc7gSnL6XFu94hDcfVFADSS
	ubO3g1idfuXXK4daqWeAeBNyPp08vknyr2JCVAVbwYq99W9SHaLcCdEvszBkdoJe
	O3d47+nb+PYQCKwDgP7BY9MFSiP0hWeYF8ltoONO59MRaegG00uUR6Z1XREazHW4
	NCC75wSJXyJjdjTdupgY0L5zEim+ByRF7eLqnQT3fyHX4MmtEVnZQ/j4shUwxFj/
	f5c5V/rg7T1xVI+On/LDNg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204996wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 09:23:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4948oNYY038396;
	Fri, 4 Oct 2024 09:23:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4220550xvv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 09:23:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+qLsZ/WPB9NaqQVJ3BtcwKLaZZ7eCplqmQNBzj23phXgtSKgvOrCYodry0AiyRQrbC/oZGhfLM1L1MMZvwAgKcti6vPYmgwezOkpFFlrH0PCAOLySXLXjWz1remAPKb1jEQ74dwkN1s9JOit6Lmns8clAmOrMAC/BJt0QAptmz9ldJYC25X4fXPxMV4Mv2naG/zVS/y3V2bGQ+Nw1fYNJyeMiEA8f8N9gtziRT2wQAnBe89gofkjcEKweMSgWwNuShITRtPZuysmkZRFuOMuHCBc0kg74fea1sdlR+sk+lE5UaBM9rxaWo+s/nA6upw8FTuyKzYMiKqCXgVLE6Pmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MqU1/P/auBsdf7FWpVOBsuUx8R1RFiawgabOzGdm10=;
 b=ijVBa4EvomS8qgh5WknizrMp2XjysA2G8XpUJnZd0nkQE8/8SV8tea+qK7ezg9iDADPqS4+xq8o+9XZhmo/qAigOjaIlbBKBnPjdh8VNZ/n9bj+bJzliYjDrzB1N11Az8yz2awPe6LKtJMQz4azNPuS4V0zjwtOO4iMakSARoeQQ/RZrZJWPJm7IKIt4VF43gnvDLIZqTTVArN1KRE8GiF40F1pKZT0lyTZkOL1drqoW/0YkPk1JmF5DSVFQjjLa1dx3OR12pzaXbN5HzJlrDPzMWAjdWxfLKmBMNWQWlhUJVSXTt9WebTi8B1Cun5Od+RoE/C6wuYUzrl0C0psL2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MqU1/P/auBsdf7FWpVOBsuUx8R1RFiawgabOzGdm10=;
 b=E0ef7HlcMki8yakuQUsywxMGCWDzjnETLz/G2j23/k5V/wuMG34cG7XjwjrPLmcXtIsFgz3Zg2pZ3+IcExeyicyC9djiAH2K5UWcZuB1i+pzIiM9sM935YpFMeRLPChWKzEDt3FqLXuIRZIMzViZbN/WPl56eOXT42hx/EYISRA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6900.namprd10.prod.outlook.com (2603:10b6:208:420::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 09:23:32 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 09:23:32 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v7 7/8] xfs: Validate atomic writes
Date: Fri,  4 Oct 2024 09:22:53 +0000
Message-Id: <20241004092254.3759210-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241004092254.3759210-1-john.g.garry@oracle.com>
References: <20241004092254.3759210-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0118.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: fd20a228-37be-49ac-a686-08dce45636f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NT3j1Uqz5U+anEb4BOcjqMQwj1fLsOnuQcJP7fdpdjLqhzo7XLuZddihPrXJ?=
 =?us-ascii?Q?+8wTkwaDxxZyu49zfwfG3815cHSz+54KSf9sSK+gW0kChcV3U7J8n8VUuzIu?=
 =?us-ascii?Q?Gm2XaLj69PwW4F6lw/qRGHQZXmOkM/RWs96AE+TDwJ/v4L9I2DugAeQekLpb?=
 =?us-ascii?Q?QSkP4igz2VIp+wd19XYOirWGmIMd6jXNNXaHKfFP27NQTBQnK3EtxlhLwl7K?=
 =?us-ascii?Q?4ku1OnnMKuvQJzVqr86xDIDI0682+Z9wk2po+IkKj3MYxjiwlfuVzzdJp5lj?=
 =?us-ascii?Q?m60Oo5F0xL9AgdhiM4IMxc/Pio6032JkEBezkt127cAPrqUfoze9DSM3Oc6n?=
 =?us-ascii?Q?wKARPhOvt6w/P2oaXai423He1GNRa9beP6bkjMfQ/RpcoRyQzeK8N9wExlhu?=
 =?us-ascii?Q?riVHrgZyCsqb1BBZHiHOQDWJfKvV2BEDSputmRVkDCwZshlmXtM0zybRJpjn?=
 =?us-ascii?Q?HcC0vi5jV7Z4yD7XXM8bl2zZjyA5eTx5iyZTvGO0HC1PJQDR6AcO5DhOJ26I?=
 =?us-ascii?Q?24G73fngBkjIGERk7fXDvkEZJXthIgGMhsxNxYy1LCFK7jzOwpbNBZvzpXlr?=
 =?us-ascii?Q?H3JKb43v2ynu4SMcpm0aakCKUjBeDNGY/xJiHujFWtsORgRcAQb6FPcZ1GP9?=
 =?us-ascii?Q?psFH7UXwgVMyOIbSo5Rf6PHnSbEP5wyHXr5xzpPB6FHLojAQ3sgMsag/+HEl?=
 =?us-ascii?Q?WrIJJ91lSTPGNgrBWybBZRDu+1ykn4HC8zkqvYMv809/ca1fKrTX5yFX2Oip?=
 =?us-ascii?Q?wBg5aA8VS+HosJ1eVMsWSQlkJlpbO9Gm+4n+oCcJgsAkNhJatSquxUaYUew2?=
 =?us-ascii?Q?SQGhMdOsRhPCKH02Qg5aflq50lWM3zca/XUXYXYBPJLT2udBOqJdFi0B7bgz?=
 =?us-ascii?Q?cFcDTcCoxOgSBSpY5uYtt3qwD5Ry9wu3e9ao0ZwUXRv0/jycAswTs9la5wkj?=
 =?us-ascii?Q?IwdsLxGnQ2TlhzvtjkZ17veoEs6xucZKJZHEQvxVhZ3ZLl0L3mAzH/RNjev8?=
 =?us-ascii?Q?3Qfqul1jCr6K2U5CNiFH7nyLpWgIKWC4Na/O2oWW1Z4tUNfTbhENntir81hu?=
 =?us-ascii?Q?s8HzyrEI8O+HkV/j7fJpRMur4cf6sngq/X2rO766W0s95loLwVYfY8iLkhKi?=
 =?us-ascii?Q?U7YrA/147zvZCcL0FFxWvQCnlCHvN4+mSgwf6tmiT5/H11YS1FICyswpqOir?=
 =?us-ascii?Q?QKSTTaf5iZDA+MJ62MiC7QgzF9J11Ao6wZv/TvXu3ACcp5m9eW7TdVQxTl3M?=
 =?us-ascii?Q?9LTjn3MyxQNvrEaQylYi2V2PAu6kA0VR8gmycD34rQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lJKCr/tjV5m1OzY4Czd4MKdgmBdkisfdhwBEMNR+bDBInzdoPC7vJdw4Jtdl?=
 =?us-ascii?Q?QcbDvtr7i4rWia3hMU4eIm6ARcXN5BaeAbAqhuESFaldRsvnc4EG3bvzlIMK?=
 =?us-ascii?Q?+5/LOsQZ8gDOa+Ad77nMnS32LKDZbxhAxeTdc1ZZf4D45ArNA/uhJKXZ2c+q?=
 =?us-ascii?Q?3CymNFuiOWV9de9XAcOHVMiLu8JPEeumNZvfCrZh21swSkc7J1lpbxxoYMMp?=
 =?us-ascii?Q?IFRwacRWqfGNfqkoG1eMIfMSMMZVyDYSaQxsk6vD6ha3IQHUNMSrFBHb6W4W?=
 =?us-ascii?Q?YqgR6I5/xr7LF/6qdkOXFCR2mQS06YO3RPJ4tCPc9ErXgBWpjkyp8q2qeP4y?=
 =?us-ascii?Q?xkvoR720KBzbUVrhzRzBN6e5Y5ho0+D6T9nfZFOMCQGL9E87ef5pZ92/lUKM?=
 =?us-ascii?Q?P3CH1/Q4/8PJaV8mffaCogpNMqS6y7vjVn8lZSO3vYL9/AsV94t86QEYg6mF?=
 =?us-ascii?Q?RvMkiOXTM23wnpBGUvVZO7zDM58UWM69leImbQSrD1BL4bhMlDFPqHd/uHop?=
 =?us-ascii?Q?b6Dc6JlmmRQi2FJljgwVayWkKHpnoV5xn+ZV2w4ZAzmB870AdA//DcNg40dG?=
 =?us-ascii?Q?wJa/QVqYJOWp9FTRy7k6iXqB4oZbkP/5OhI6tEl+zYLv2xGbBRRpsjbdY0CM?=
 =?us-ascii?Q?I4pzyvoJBLYrsYGtZuQwJOApRS5Og3zxmNZjE6rMlCuah8n/mTJW0TxUrylC?=
 =?us-ascii?Q?cdBtzNiLdhZz2tWKw4PPr8SctMRzlhFqxd2UXtEPI/RF/CFhexQa2Odp2wPc?=
 =?us-ascii?Q?L3e/Vx1ywybyJvvVxQ6Y1yjqaL+bMUnwmnfNoPc6pdq33OV7TYJhtsuSg80e?=
 =?us-ascii?Q?oZ7TXxzm9Tl/cwDi99ALV5a+7i8LiUK+V+8fQT+FaIRg/QeJer5HKHhg3Jeg?=
 =?us-ascii?Q?RKObSkgwB0bn9Btho3ABtRofPhSA88N95fuLgcDAzYHH4jTwItQGMVq1O3wB?=
 =?us-ascii?Q?eqeszT3kXhV2QSwR85ojYxiDT6ejugW2zCzb5zgJM2pSXI3RumsdsnyMBy4t?=
 =?us-ascii?Q?AyBAzuteW/yHeHChindSviWpN5McwSTTJolXFnaPLMjaNQ+C3BsxtDjX/A98?=
 =?us-ascii?Q?RjsqoTiz8UjtaVdzNxHgR2qW9frcWfu+cTRdE+WJRRx14alG7XBUt9IcjsYo?=
 =?us-ascii?Q?S/jF0mAhE9d9Mqs0+iB90vPBIlQboFT4NEm9ctSeIQC3OAHzfpmUc2A8L2Fw?=
 =?us-ascii?Q?IvVP31KSoq+eIbOqvXmrE/tAXgl+4xI9F4j+V18UdsMYaOykBA9iTM6g1QE9?=
 =?us-ascii?Q?GDkmIRxLcKSbu3kTmdiHrz67Ko1V1Je9jPS0U2e8uD8dhR0BeHxHQBiR5bR1?=
 =?us-ascii?Q?BnyK4+EughZNGlj04jcK82fimFW8IGO+AAwwoORWtZnIyR0lEE2ZPRTcthbx?=
 =?us-ascii?Q?Tm4Aw1H+zANIaBFfb1Rjw/wSVAmJ7EX5r6jJwatXlgLHYJpX0ICrLsvUGSB4?=
 =?us-ascii?Q?WYnd4PVlYSU1RAOI3BGZAeAfwCg6OiizZ0+F9awlyP3sw5HCKZ71x5hknuv4?=
 =?us-ascii?Q?jy32pkMXMaSsmTxh1xkle7NXIEx3HD7OEJPyWQ7touPwB1wr0wp6OP9gpGk7?=
 =?us-ascii?Q?gXvpYNuublawSXrQN8atkuiW8MZ2eyr55JBM8Uckds1RQArYZeL+Vsmr++IT?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b1hxcqLx8oxBJsYtvZTCw/YE52UpVPypVCZhCNdDFEYPI39d34oKR0cPpQ5MjiW0e0smZwpzOJmPv4z0gAms7Yx3qH5tYBeqtyacLjSMvghM3q+UuRNR445lvfjAGNsSHp1M1j0zDPtVJKcpZDfhxwvu7D73vGgSvwEnG+AqFv/i1SNuZFh9FsYqkwJ1VKZgMxO9Vt4cDh9GlTOOl3qHawRqEfEKQtLa65c/HmGBBx8YghPPEu27I4RmJfKpextfq76qtEWy/hvK8pY6Dp3HWfzJz2ftlH3sRv0BIV/0Alr8ExHuiu3XLLnFAAyix0BIxrz6uI4F5vt7YkV3ZmfglvjU+PVwRWNJI8oi4HSUWMdlBSCHoenJv0iLW2hDrmTLaEMxbqEeL5lxvOq2ab9TTAFlQBdDv4aGlWGfGLgf8BuJ30P3V48OujIrlBVKzWbN4mxPIrmjZvr+hfz1AwtZszfJir07GVeCOoiWkTEkP/Cfh/qTRSoqYVhN1xS/g7ReZDTJqpJpvZvAMoZiC7bZrA6kAFA9E//6DBwmn0lQKYLZHj9kbXQgigmetPWeBhFD+5RzH44CunGZLOdz9ZWiSN9FSfowyXNs8XGlaIlBlL8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd20a228-37be-49ac-a686-08dce45636f7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 09:23:32.1524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rp6+yxIOBHUgSKi98ijb77ubT9T9FLL9lsIzuNoY+F5qbONJVzBhZYLhHWMY8e011c9z2Ih4d7R2/hxv5LBhHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040068
X-Proofpoint-ORIG-GUID: KtWUYD8yP5xyxxnA3p4gpUUbSG-xKLo2
X-Proofpoint-GUID: KtWUYD8yP5xyxxnA3p4gpUUbSG-xKLo2

Validate that an atomic write adheres to length/offset rules. Currently
we can only write a single FS block.

For an IOCB with IOCB_ATOMIC set to get as far as xfs_file_write_iter(),
FMODE_CAN_ATOMIC_WRITE will need to be set for the file; for this,
ATOMICWRITES flags would also need to be set for the inode.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 412b1d71b52b..3a0a35e7826a 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -822,6 +822,14 @@ xfs_file_write_iter(
 	if (IS_DAX(inode))
 		return xfs_file_dax_write(iocb, from);
 
+	if (iocb->ki_flags & IOCB_ATOMIC) {
+		if (ocount != ip->i_mount->m_sb.sb_blocksize)
+			return -EINVAL;
+		ret = generic_atomic_write_valid(iocb, from);
+		if (ret)
+			return ret;
+	}
+
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		/*
 		 * Allow a directio write to fall back to a buffered
-- 
2.31.1


