Return-Path: <linux-fsdevel+bounces-48347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF87AADCE3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 13:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ABAE1BC59FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 11:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DD222B59A;
	Wed,  7 May 2025 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eVReqqBS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rgISjyjB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483B5216E01;
	Wed,  7 May 2025 11:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746615885; cv=fail; b=AA6xDhVZtogc2l4GVTCvM7iFgfznfmDNCRPziri421wo79gAMBGbt6v2YAyL3Pg/KAHVzY7uWUpz1HBp14EFA6Q1cyeIA78Lme0+dxRfdxIY4h2f7B2j70iH7rq8S29XlQh5si3KLiW2kAYX/D0imgK/jSoTKrLXXrarQsA8HvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746615885; c=relaxed/simple;
	bh=2QEalM6o3p+MPtqUkODSZK3kb6Hmy+Bqe7qGWeMgAJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dQNjFG4rnmgwF068NOFUpuRjZ2LqM81J3r/O8Y7cpsVK8fi40sa18+ABwli7P0+OESi2tetpvQPbSxewnB36OSmZVkhfAodmHEzPzod/p4g6TpWxPBanynxoYeQugP5yqyO4CVIphO0HI0dfDjFFg7KPOY61WnRGEZFYJM+sCJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eVReqqBS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rgISjyjB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547AqFla029461;
	Wed, 7 May 2025 11:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RXJ7F9E3y8PzZ/7Ddn5ynlP/IAsC935evhjurOFgMKI=; b=
	eVReqqBSBjJzKD5su5bFJLBgUX5/pE9GOQEz0mEPi7X91foD9F8M+oyxQTNG7EkP
	ajM8n+SOq6YYNli6IOM1fsUUEVEGA3p5L4kk8JR6wmrZ4mXHSu7OKWJgm8f9FkE7
	Azfd+nq6KGpyIvrK2dXO4Op8siXhV+w4Sip6eWES3McTAx8ZOwujsn0S5kJn4gSt
	QVrgdhN559GDXmaKTWPRTd1KfUo3UzzQpJi1VDHq1wP/neJUNQml0YHya9cgcrt7
	2/QD6+fIzQxs212PJmXlDZn/wCm0vTPHPhmaTGHvWg6brnUwnca4bYA/i1QA6ykH
	WlYNcrRmN1/E8nGRQ/NxKQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46g652r0sm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 11:04:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 547A2Bud036077;
	Wed, 7 May 2025 11:04:10 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013074.outbound.protection.outlook.com [40.93.1.74])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kb0mf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 11:04:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+lio8aA9baFqMkgMs7I95ubLoR+f/PQsCZvB6iMKb4I51NPhAdTVMzUfzvic+TAV+hCtFAhfYbcL+p04xPWV7XRaDH0NYOYTA3SpDEWLsfTcCFC7vVB6H+ggbhbuB7lgmYqXix5VX6TQcDJ7lNyi0QavuOWg5XWQ7i2zO7Ya1oVXsIEW466w+5EnLSmoWsI6rzBhuui2QULqV9DVNN5gD6T0wpaNch919IVlkX7GeJo/A0XyMiqUEQKX8EYQCfOwN0VEwFJv+2HI5y3Y1dvVZU+lXoXWuzj6EF1zttIw6bm+PN0nV3xyPjCM/D6VPff4TfT1Pn8Hm93DVsB8K5jLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXJ7F9E3y8PzZ/7Ddn5ynlP/IAsC935evhjurOFgMKI=;
 b=a8z6Ls9AYeT2jvKkwzZEh1prszhAoEia5ScgZo+9brRDibIuYrufPpPBMOkAKZgNhxZc6cYXyWvlleFiBUxha40WLEnjimGu9V4zPeedEtKRfzUtDS6C2ufaBoqJSA3c1QdS8BIz51gZqBMC3C3t/Nz0bzG3d2j0499KRpmZu/W02WnFWiqx9VD8ycy5s2U4QO+wceoK60Ze6YCiDVCDTxB/M3VZTJ++oLq03Z0OqJxFcOuCNZ5aE3CVmtxx6DQELn+ziI8/wm9FU9Q2mfl2bXfVwkR1EZix9hr6Lr36y6Vbcq1WoGrmS4IiiDWei/z80DzxM5C//RsixJY28118sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXJ7F9E3y8PzZ/7Ddn5ynlP/IAsC935evhjurOFgMKI=;
 b=rgISjyjBq9N9AMCCdortAX1Aik+IzhPIRWLW3G5hX91jtMKtRGMQlSNPpmnphUmdVKI6xliwGjn4PyxImnjP94wlwhoeQIXaH/C5mHf/MjpbK4p8LbMQmuqDrNvKpfqDa9j/OjGhnskitGN7lSCXgkGO2id2BcUFLCDu+GGiPFg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB6251.namprd10.prod.outlook.com (2603:10b6:510:211::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 11:04:01 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 11:04:01 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 2/3] mm: secretmem: convert to .mmap_prepare() hook
Date: Wed,  7 May 2025 12:03:35 +0100
Message-ID: <a196a08a52039ee159c8333d0c6547e78112acb7.1746615512.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746615512.git.lorenzo.stoakes@oracle.com>
References: <cover.1746615512.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0001.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: 99dad052-6e74-481e-80c2-08dd8d56dfba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pXpc23pdAV3duBANeRHPHvj82LudGwj0LLPUJeaUFLryuDAh9Ddf3nHFA945?=
 =?us-ascii?Q?cyuArpv+CBrj7aCcheqqFk0HODkLeeOF2aTwWIEACARHgooKtfZ8YOqBqQHw?=
 =?us-ascii?Q?q1Guab8nzjcJloFOaMqPpXex3KG75nRz4tUQ8HaMsAwZlkSNz4DVnsulKUE7?=
 =?us-ascii?Q?Ci9peJJJ/Hxuw01Wjj0XmkRaGZy0Btsqs1MuW7pEad6tnfEh6BalHyKRdoVy?=
 =?us-ascii?Q?DXIoeBHKSSSC52XyKX+txjRCHZmb18lXJkqLAURM3NxFIcqKUPy/V3TLZyBP?=
 =?us-ascii?Q?YIfxrJkGrt7TU2ohog2zB2a6Go2tk5ZKLhtWhShrQasmS+eIfa1oFr3DzXvS?=
 =?us-ascii?Q?vxqu2ESyFciSpIERYV58vXYpL5KUNG6yaFN5d4V/EyxQo0Hn8LAaN4h8GqZY?=
 =?us-ascii?Q?ZRuvMtuXs9aX7bvUqtr2aDLsPb06ZIwjiLslvpaMJCM/Cjbzp5CpcX/+ITPj?=
 =?us-ascii?Q?6lHHBjsHnrq03xtzM3xvzOnFO2LBVfeEbMIqsw6mYebYJMGFbQKDubgFSWsj?=
 =?us-ascii?Q?st04TIpsdmGMv+PdMieSIuuziorToCCQy0EuWrv8gH5Y48a78a3pEgcj0TF/?=
 =?us-ascii?Q?EhR8t7rqatrE76AWdKPrS0GqW3IubtNKCMMTU3mt8DZf0KWyoWvwFdxXGoIj?=
 =?us-ascii?Q?T/6tQ5L0YNG+2gJGb/zy2wbONqSPkIUyMk5M3l3Z+nHqMsV23TXx5vts1AmX?=
 =?us-ascii?Q?g1G1nYU8V2P6Fplmm5doZ2yF1n7Eu8ZmB7kK2IQZkgItPZedDWif+sjLrWHd?=
 =?us-ascii?Q?pMiEUDYOFl5xCADxuPG7i2A11+YjPn3rJJ8unvfRnbjKJbVqrWXB5xLSTxgX?=
 =?us-ascii?Q?3ODZh17J0Mz+9lUJjmPDI3UrFCLFBQeHTQj4X7u9Y7kUTYvmyGJI8Dvilonb?=
 =?us-ascii?Q?Pon+7NtfNFSzCmSmT/iUpC9LSxxoTHg+URtAcPPM27GZ5/EvsRczVm6QwlEp?=
 =?us-ascii?Q?ciTYN1cBHqL268RPBbBa6LgNhx41fZApWYhtZ6JocVbtbe2HLsvWknfI3K37?=
 =?us-ascii?Q?61VPPME7GACqc81glYJ4MWqKjb6w9Nb1vcMsoxZ6P2NWS9cnT6IwQVtMu5TQ?=
 =?us-ascii?Q?bOs6wVqZ8s8XuVy76P8Jr0BoMWVaA4/es+fdbPUgmq27gie8XfOSqTWxV+1m?=
 =?us-ascii?Q?cyYFgga3F4AOGv8h0UeWVqAUQ+RcME3/3Ma46jMhlGgRqPzmUdKlPx6Mpq/o?=
 =?us-ascii?Q?sedEqAv0+A1mqH/uXitOKa9jc9eQZ0EjNzQX+amV7wwZMxPzy/rIqP9gVsqy?=
 =?us-ascii?Q?yqcPW2fwy8SUOUpqBH459Y0G2W52OjUBIhkieFfpVeeUIlGS56MlkPSgWh/Q?=
 =?us-ascii?Q?RZ21hANSyqzA1CtF2dQ1kDuSzgVzM1R6cuhhI7kfPOKxC1TG6n6ipvmbx/MD?=
 =?us-ascii?Q?cvuJoyxBvgO8BYe8LdT/UvixCYPHwqwUMxhT9WzBofAVq35a0NFTLa5q8cf8?=
 =?us-ascii?Q?jlWUp4879gg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ChbYEFU4iqVRycQeX7O/dREVo25vM1ZRrQ+m3Z029vSGzDbk1VPnUYAaXAaY?=
 =?us-ascii?Q?OXsc7a6URaMIU695F/N57ukHhHV/k7uo4ATE8bPeRKya9jAzInND3+mABS06?=
 =?us-ascii?Q?vFkLRtoZxuhnycak7T5ZPRpOFkqGulCmhw6gGVHu1wCQsYkIdN8xXG6KbQac?=
 =?us-ascii?Q?dFsH7dNUF9KyQ9K+N1DibaasmYDLYiKXkjnx/YQ2qWvtofVoTu0PMzuRzSeb?=
 =?us-ascii?Q?iuk4fm266ALeYKxHElfz/RxoxQmwqfj5aSMVJmuXf0Hx40S0RlFfBERNyPDi?=
 =?us-ascii?Q?FBaxx+pF3San4kSb+hjalKdRSnztw/QWn94Jnj8hb0t52isn5ZhhuoD/NAbr?=
 =?us-ascii?Q?6hYsqwz2+QYln5Hc56xYrXsNhM3GJ7aqYzSKW8CJ5mDkWhptXeoTzt6Oyyq8?=
 =?us-ascii?Q?kdQy5TJqwjWUYDrUF3jaqtJkOLw4J3ksF5g7yXOSEXsnSCH6DTqPYae0q00c?=
 =?us-ascii?Q?5Suxb1eZ7TH1DnSPHb/VxWod/uOPGdroK1DXD7osQGPZh7ZQlqZJc/IUxOZG?=
 =?us-ascii?Q?lzU+X7WYmAHu6Gio7/umCPWu15gFSmxnBcY/GpBATeriDxk/hk6YtvXVCyGK?=
 =?us-ascii?Q?Tq/+2FbWxw8EiiKmyAmTn2bvP+E9c64/TAdbepstFUnFCRbOtT8IlL3RncWg?=
 =?us-ascii?Q?23AKFZhXrtEDUC1V07n0wsPGUIA2ANYIECNMX5VdT/Ko3oif409+Pp4SmujB?=
 =?us-ascii?Q?8kxgP40Bi9+dnIQXY7ijanG5Mz3Mylq5gTeD4NzoTbey//rZDxSiz0/9a9lO?=
 =?us-ascii?Q?MlnMyUkg+YXYatdF5sQSxZvp+424+gXoB4U9mjoNstybHtXz+qo7EDbbT7hn?=
 =?us-ascii?Q?Xl6hDjwSsS6VrrzWIiP5Zfk8l9ZMKQrBpiUqq7L5HgG9a7hFgYdMOGqVc6ry?=
 =?us-ascii?Q?yH+3jqlhzmnN0onb57Zn7HCIUslTIQ/2SHti7cW4a7EKI57fmb6UDv99DCJY?=
 =?us-ascii?Q?1taLWa/kpyLS4XsMQv4S1pt5dPAJrP18Cg7aA8/reoFxreAqGAODgdF0QHZ/?=
 =?us-ascii?Q?1yXlBe1NFAhLb0Iha2ejHr+wu8svml5g0KQbOVrH2V7jObnB1HaEBqdquF2D?=
 =?us-ascii?Q?2v/rQR1thWVktueyoisO8EnAv7s/e61RjMop4pAkG0IVkdi6ZdLJBhfKY+Vt?=
 =?us-ascii?Q?H0zPGaxH7saKODKzZL3b9w4VvwtApceCDPtliKiz8F76/7wYslU6VFYPeFNp?=
 =?us-ascii?Q?4qPia34EWEi0lYBps9Ts407IRUdWMAZhpFZRq/jOr75utjwXMGKHjSXxzz0T?=
 =?us-ascii?Q?CvIGjd30FJnuVkLAuNpP5fY7uYL2YIYiWLVabCWby6NZOPQzuIehApd7x8Iv?=
 =?us-ascii?Q?8wra2aRqTbV07BGBzHsqrU3pSidLQAc+IqAwVDvm8nwhPRNemM5derNDZclm?=
 =?us-ascii?Q?Euln77vlDIv/bY2vfzGSunKPVMIX+ZJrTNb5KkQzthRn4IpxxtYb6TS+daQR?=
 =?us-ascii?Q?TaPn8jw0OzO91gjuNhxQUUANj5Ej87+FmMYoKEny9Rjwth2KibVVWE8YbZP9?=
 =?us-ascii?Q?TPNP7HMZ0WUksTwZ3jd3UNMPs/ZCk1fKezBfDwmJj8tt/un5UYAksYcBl9UW?=
 =?us-ascii?Q?GEa8bXv0SPzBB8FaS76MILlMXT7J7d9gAxDshyEXouHumqGhP9RC319HO6ap?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ViACS8ZRt8/FxR2edzoXmgWfblqpqG549EIdk/4N+i7e0WvpE/TJlZM3TT52RsqeBvoLkODoRYmvxJQ95tiFWjj9XTZN2C196PWrUKdQ80xTXba1q2miQkk31+PDnxeyr7qBis21koE7ZISuxz7ax0wOr7hne9tprPVTKO1iE+sz14y5hebH6CQAAWB1FAJ2Dy2eCcIyx696XqG6OwaJZJoDfQfmFBvOiGSKVX5WK2EBAznudfDVboMzhsPnZnEBSbKHWqRLMxMUBTqRLSPPdxf3QD/fIHGXFv2oOo5iHsAeFo4wEPqqAnTwNLROiEyxrI0QY3dCIBRGEsBBD1KAUXMo4ZKwZgh60oCrjeQzigK4ZL0ZjKxjJpOSKNb9u4JGXEeKH6h308O8GNznfbP2WnSk4ADq2UPq4EJadXwXFsOehNgLiEoquzt1h3NC7FQdbqWISwFrfr5uaA5Bx9umGQjmeYFDHIMxS9iksK+i5AFS96O3Gb3GV7qlbOUNwPpfo0jxxyf9gUDHk9nrkhVJ37HWcMM6Z7+egGUAmoto7OPUjp7XsfNX0JQLUC9M8ETaXPHRXk7uQ1NxnLHS7s6/SoHxc7s39EoEVOyxqccKiSU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99dad052-6e74-481e-80c2-08dd8d56dfba
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 11:04:01.7410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MASUfLiqEKXpsQheR4nH+P1X6yJdTPtPHsBI/+tDa7xgcL+IuQycskLFOr1YYU54WHh7JDQ+uvNHK9zzhHDABSGGWKAiUuTI796yae1E7Qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6251
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_03,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505070103
X-Authority-Analysis: v=2.4 cv=Va/3PEp9 c=1 sm=1 tr=0 ts=681b3e2b cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=Kl9-pRb9PRCpSRKwHLEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDEwMyBTYWx0ZWRfX3Reab0OARgVA ddWCEZhTLectSbva+Mt2dDz9SaY8LblJto/d8Ul1gmyiYQ+t65QgUVzIXNF9GAfXhINojvN6qZd QSkiNvRQYr8jxvMzg2ap6VInWUWAw2uTXuYELrzm2fH8wFUE/AHX9VCso+bJVUvpGLTLm21RbZB
 6JWuFRoh6b5s6jquLsUDpX27hvwz4/QccQ7r0/GFBvDh/fkde5Q6SHyqweBmZwVAurpas/oSlDx Xq+pPlGmBz8+DoHCx/Zx1ZpjXzSxoanI6z5Okj/MdmALp+kjDYLq815K+jQGDDTgmYgYsxWQzv6 X7p7DrsY6SDq8u5bcXGLbK6Jo6O5uBVChcTtDrY3KNc/s/w51oD27HJGV0/Liu+2yf/Uj05nyEJ
 qX8/Swzk0BmjBmLfE1o490CVvSQpkq9QGyM6KDA1Okc/1TBThaV9qjgXkksW6fG5QNkjRqAn
X-Proofpoint-ORIG-GUID: RETah_3L1phnkk4PKQjzOmDB1UHdNfrk
X-Proofpoint-GUID: RETah_3L1phnkk4PKQjzOmDB1UHdNfrk

Secretmem has a simple .mmap() hook which is easily converted to the new
.mmap_prepare() callback.

Importantly, it's a rare instance of an driver that manipulates a VMA which
is mergeable (that is, not a VM_SPECIAL mapping) while also adjusting VMA
flags which may adjust mergeability, meaning the retry merge logic might
impact whether or not the VMA is merged.

By using .mmap_prepare() there's no longer any need to retry the merge
later as we can simply set the correct flags from the start.

This change therefore allows us to remove the retry merge logic in a
subsequent commit.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/secretmem.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 1b0a214ee558..f98cf3654974 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -120,18 +120,18 @@ static int secretmem_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static int secretmem_mmap(struct file *file, struct vm_area_struct *vma)
+static int secretmem_mmap_prepare(struct vm_area_desc *desc)
 {
-	unsigned long len = vma->vm_end - vma->vm_start;
+	unsigned long len = desc->end - desc->start;
 
-	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
+	if ((desc->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
 		return -EINVAL;
 
-	if (!mlock_future_ok(vma->vm_mm, vma->vm_flags | VM_LOCKED, len))
+	if (!mlock_future_ok(desc->mm, desc->vm_flags | VM_LOCKED, len))
 		return -EAGAIN;
 
-	vm_flags_set(vma, VM_LOCKED | VM_DONTDUMP);
-	vma->vm_ops = &secretmem_vm_ops;
+	desc->vm_flags |= VM_LOCKED | VM_DONTDUMP;
+	desc->vm_ops = &secretmem_vm_ops;
 
 	return 0;
 }
@@ -143,7 +143,7 @@ bool vma_is_secretmem(struct vm_area_struct *vma)
 
 static const struct file_operations secretmem_fops = {
 	.release	= secretmem_release,
-	.mmap		= secretmem_mmap,
+	.mmap_prepare	= secretmem_mmap_prepare,
 };
 
 static int secretmem_migrate_folio(struct address_space *mapping,
-- 
2.49.0


