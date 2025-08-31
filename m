Return-Path: <linux-fsdevel+bounces-59715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5395B3D05A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 02:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3F44450F8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 00:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858CA1519B9;
	Sun, 31 Aug 2025 00:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GTaofuBq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HNZXUVXe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF86F9EC;
	Sun, 31 Aug 2025 00:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756600894; cv=fail; b=HYqltkV9MynXxxI7kTgIIN8wgIeTXC9ESTMnVx/oysC8hL+OQsBXJrZGI9ITZrSFFdasrCdvAfZnRuYHZxUbkweRXt4PfnWrp/1qhyLUVfehiNM/iU64DTkWJwhZmmWPGk569wusdiBq5YZHE+DeqGKetZPBGnsGAjUKXxPLvgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756600894; c=relaxed/simple;
	bh=lzTC0wAn7Tlw5DUz82isx/Ob2nL4rpKBRZRXq5Mr3tg=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=RYRuo2KwTGHjZL843eCpfZU66UZ4S5/VlOUU2ez88QQAm4yP7fW4C00fdncBz8c+76bXDLcKakSxwtoKF4d+ubWcdJB20PZ2I9coE8WY325VmxGSZz3bh2oT54IqyWg5F6zolZz+0aaS3FKByqdTJkA41YGWxTWRTZZLYJPEGrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GTaofuBq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HNZXUVXe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57V0bEcb012691;
	Sun, 31 Aug 2025 00:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=q0fxaXoRqXMfa1DMhJ
	Iu1YctWhakyDVHXHssITkqazk=; b=GTaofuBq55MBIbvsg/oPe17F6KdZ2SWQlO
	uBnUjmBUYdBl8QQZy9OVHms5TpHRZTLCtILQcc9mXEQybBiBB+IjYpdGDGReYaS1
	dVzMOPW8dLBi4I+m+JkBhQYTquBScWAWfOlFtYr3wsP+MSqiHVEZVVd/pdO855S3
	KB9iqOHMopTWF9ly7RHb9e0ghkP0iWE562ZT/zRRtgiaMT/Q9KrxDO6hvQaaizK7
	x3n1D2lbFLZxnMLv6sP2B1iPt4uaELPZ+r3rq8ELbSduZXElIVtPj2wdTiUh5T0x
	2+i30XuWPCYKZLRFF6xyFIaNNLFry3ZpbhSb77rSfjvRCYSt5tUA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushgrk8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 Aug 2025 00:41:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57UJK9ZM004286;
	Sun, 31 Aug 2025 00:41:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr712s1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 Aug 2025 00:41:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpBvD2Nvhxnl4whij9yf7pk5lJaOJ/CVjfc2KVH5YMYdYr8IACH51tgTcZc2DmHNeCcfLJ5cGTkSlmQqlbe5bvsowM3cXHhAJ+N6FEyGn6BTAXoAOH6N/M/BE1nb0oQZEKenle/zaNITWht1iPzsyRsrzMbrt3fgq+cCiA0Q+mZfo4O9gPYup4J8oOcDFKpFt+vEWtrf3MOMGgnt+Wa5vT+Weq/z+QruNtv6nscYvfeNtJcplANrs27sQTTTSQySlx/IcqBJeHwj9kz7Ov0yvtP5Az/6zKr7ERqg1sFwPfGG3d3BleLBEltwmpAFfVouiNfuA/x0mgr8NMglwWCkqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0fxaXoRqXMfa1DMhJIu1YctWhakyDVHXHssITkqazk=;
 b=E32IMtBPQADCvw7hoIl5D85Em9GGk1BqguwuaNoR3rxEf2TUGJrQBEdKgrT7UvjPNFTp1mQJjPo6hvPyST1MAuH8/24AUV8rSJZPp6zhHiafX0K+/RsTi5XVp3JtqtTfwNNxX/NEwneckXN3YkKDY4wHsx1EfItKUasyylybeHkE7MqTP/ZWiyGmGOsAe+n+p10r2DVY60tzNRuv6xIgfKZ8sTB18aPvdPJAOu8P1LJo8CaQO/vbWB3HZ+RSDhJyyHeJ5cGKZjMuBSUmQzN3skJUk9Bf7Io3IuyNCe5sHigNovoJRpnAPlfWrmh2YvudXGaPPp82Y8tLlmy1sL+Ssg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0fxaXoRqXMfa1DMhJIu1YctWhakyDVHXHssITkqazk=;
 b=HNZXUVXecNFabDi34hpMEBkawoVq6RPwhNLPz0iGs85IVsOy2mX0ljfNpfhWG1hr07xJijc5yxuqZpxe589fioPmJV0mKUxVRXgNiB3b3BiogSgB5jkFQ0hP1CPAvlIJUaaJgwHxRHvPKlf1twiMZ4lEph6jLcLYTlSKyGqEaYg=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by MW4PR10MB6345.namprd10.prod.outlook.com (2603:10b6:303:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Sun, 31 Aug
 2025 00:41:23 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9073.021; Sun, 31 Aug 2025
 00:41:23 +0000
To: Keith Busch <kbusch@meta.com>
Cc: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <hch@lst.de>, <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 3/8] block: align the bio after building it
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250827141258.63501-4-kbusch@meta.com> (Keith Busch's message
	of "Wed, 27 Aug 2025 07:12:53 -0700")
Organization: Oracle Corporation
Message-ID: <yq1ecssgw60.fsf@ca-mkp.ca.oracle.com>
References: <20250827141258.63501-1-kbusch@meta.com>
	<20250827141258.63501-4-kbusch@meta.com>
Date: Sat, 30 Aug 2025 20:41:21 -0400
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::23) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|MW4PR10MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb06187-c23a-42e9-c54a-08dde8271c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bTPdkyX0eMqwbplmN/7DqUHuqpos0fkhUTuurveEUGUOAplXJW0t/x6xCPeh?=
 =?us-ascii?Q?rk+F2ZDlWCxj+1B+1A40hrWJwEk8qDCInV9kHxlOE9Vv3flR9Zt9RZCf8xgt?=
 =?us-ascii?Q?h4VqSsTXoVYOHkhB49ifh1kU8fCe/2O0fjr6c16gd27aWb6qLsOY3Fiz4fYu?=
 =?us-ascii?Q?6rRTEOy5wlit/5vqIWTLgmyoVOuEf1g5Qz5hlPrtscfGDMdvPHfqGt6AiilJ?=
 =?us-ascii?Q?639BLs3ZELkGY5Kb0x8A/KK6hhddDSOPRgFykfeEpfXC+jCOLgr9CgmxaAbp?=
 =?us-ascii?Q?QKRIWd1TmUJ/B+IwsBH4SvMaXA0nDuD3GuPWXpDottlKONtQd55LdGS9+nj1?=
 =?us-ascii?Q?0IwSNbJrlqwP3MzZOQqSGrawr0rAQ/IiRGlpMS/ZiHVDJcsyndEpar+Q/qf2?=
 =?us-ascii?Q?+XuKeeN/ct9Rh9OyzT4wSRvydmwoNFSVjWebyc5KmP16bTbXQHUA/SPB3TzC?=
 =?us-ascii?Q?GkeZpKdrxggkjpxz32QJyojvO3EG7Hez2Iwiy5RZAYkoqs5Bea7mhZ5sb2KL?=
 =?us-ascii?Q?/oEZl95OY22BWYgmKVDpR1syOID8F6W0ywg54Wb3lNAIyc9hDGGTTJKqBiop?=
 =?us-ascii?Q?Ge1yc2nUdq5J4T43evuUz7hZcb/fy2OiRZ0PGaQCNXwaq+AH1degpMk5ZpmU?=
 =?us-ascii?Q?9YLXuRcr/PEIZTRcvNUwF0hZAuIKaW8UF3FHUNsY5MvxZ05925pghEQfhBgZ?=
 =?us-ascii?Q?R1I5MmRBs4mpJuzo6MYdgDvsvhr06sKYV7UkVTajIJozGMLgNtMLmIuUYoFc?=
 =?us-ascii?Q?uaot+PKBeJaAx4x9pvh28PRVq+eX4avrxPZxQzMB2927rdJuHBjrNmz/sMtl?=
 =?us-ascii?Q?m3LQB+G4PJp2ru47wrIr5RyB1VbRwhcVZ0T5QLsbhwMQQroKvw/sNaDIkN0P?=
 =?us-ascii?Q?9K0ddyqr1poB6j6yD4kOrYlkc9TRyfgNIgLfgxElDRfGC7zFv6O0Qw4uQku6?=
 =?us-ascii?Q?esEjo/Lqb4kNiO9604ThAqhRw0WvsiDKGgQZcKQ/uI/uvzPhXkgrL3/RP7aZ?=
 =?us-ascii?Q?FkSOsgF0ruCaYKeceBRe7ylw7K3tGf3WQPHVLiNOOhZkYyvqKzMJ7Rpeyrp5?=
 =?us-ascii?Q?5rEP0OY42S13qwSiSbZ5kdAs6XEmJnY/OhwAFt7yEyH5J6OX5gN+iTmxQgaJ?=
 =?us-ascii?Q?RztE4BMpfzamFA1FUCRGee6QUEf4QWuSYt0KNianfY5QigwSfVTKowjGj0P9?=
 =?us-ascii?Q?2s0jZNZhWNqaEqk5+0Bovkha6pbxxL0VUfSryS6qiBWl4ySln+MP99ZDbjPa?=
 =?us-ascii?Q?fsW6ATWGjACAktX10eDkfcBSSfHbD7skPpbO/0/TeD4+j6nJiuia6d4AZr3u?=
 =?us-ascii?Q?muE7RJQCwxSzIZ7m+r4g009xRVSkhzjWeYXs7vDoAV4Nb+pCE05AoZtRszfi?=
 =?us-ascii?Q?ghX4t7ccAakNuIQdvamxdgdj0CD8aOcBfLfcpOOSPgtkwWHSQPft+ZeT/FqO?=
 =?us-ascii?Q?0+HFRtwAXh4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LCGaP6Do0vL5et+2kbu6y7DxzHKmEvxHuj0jkVupsoNWpbYjz0Je5wD1VHgI?=
 =?us-ascii?Q?P5L9BoMxVtNXiWM4wjSQ98wcvlcVytdFHx/09bucpFbf07+pGafriIhJzzpX?=
 =?us-ascii?Q?vfXMcjSdd+Rr1MlHMkB+4YNDbBTLWiT7sebnyrHjhk2bWK6iRDS8vcsAM3c4?=
 =?us-ascii?Q?eWn2n+tkgTbnKZTboVD+RhOB6Stxq06AuSJoEEqt/EsbYGkIoLlnvkpIiCEb?=
 =?us-ascii?Q?0GkFU0jINDpahQQ1zIgNw8AAK5ar6P9T/mhTGJnr8wA3TKvrt4brp+jOrsIT?=
 =?us-ascii?Q?fcVO9cxg5F2ctIJqdcX1jwjMxWK1HP/3vms4y0SGgvMTxzW7QFPZrurZWGF/?=
 =?us-ascii?Q?wy8OVT8H/LraPno8ii3/0Nbz6Zi5WGlzWoci3Cxat07y0lVYxqDIbGi42fjU?=
 =?us-ascii?Q?13XMkaeVYrVmD7Z7R5/ai1G6odF+STI9/dG3O5VZlNcFWsZT4yLB8uOV7tkx?=
 =?us-ascii?Q?Li7t+06eJaZr5o0QCib58mnVpYiGtpTXlsP8Hvd8xKTR3SS05V0NfSAGlHid?=
 =?us-ascii?Q?waqFC5Y3SSdLbCbOM3+mAlUiUxcm38EELGEHbOw06vQ3nVihVnfjGs2ezY2U?=
 =?us-ascii?Q?L+VPBEvDRUUE5jHa+uuw1nrJt9s/uKoO45eFANKW9IYqP9B/Fep6IXrFTg79?=
 =?us-ascii?Q?cMiVCjouuiesVfyuN7/ApSpEEzL7LkxdWbqB2m4x5QDoOCIkm7iWXDbtEHtU?=
 =?us-ascii?Q?5hsYbFUI75C9mhZm+wa60uk+3VFClVTkLAFgdfoPG4hFJU870Y3UXd/YqZKy?=
 =?us-ascii?Q?OJUlpTb1yduIBUgxjIuJ7563cUFuPfYMwJzd39hDJ/iYvc/r/+mBWox5+mR3?=
 =?us-ascii?Q?BBJu/huh4ybjhLcZe6khioSYm8LQO5stIxE7CWaNmGmJf9kPMcIPKaGJJrXL?=
 =?us-ascii?Q?2Vf+xm1INL/nNWFMwtCkq/sfHvFKCvNysEGjcPIwOKWisKx/D1VsYoBteGDA?=
 =?us-ascii?Q?my+8BNPXcmuPCB/5jcn8DGrMIfsjZ9IZ4jtyzVeI4jyC2GP9c7u+w9BZhTKB?=
 =?us-ascii?Q?JrIdHgh080lrsy3nYH7ak6oan4c6A3+FdNBY7TFPgZHtKUGaATRp2EG2K5Gt?=
 =?us-ascii?Q?VrefGMpbKvrMcA11KjH4pwa9pj6rNRajqh+0w5j6kZ0PLTIqFzTBHyo+3Pcv?=
 =?us-ascii?Q?xBV6AJmdfOYTJtXaQ7YbWVaj1ZLEZitcpzQSBnWOkiiucLC9AFiU+WImMqRy?=
 =?us-ascii?Q?djHujrhYi944RobjIbFmECDG4jJXQQFxcUdLFEAZMXa4gdQ+ScRK3mtskYKo?=
 =?us-ascii?Q?2jwJUImDl8ydYmsD+/r6FSkSqf6KWnp2FrDCT8gO+HdLZx7+rlnc/Dh0MwOu?=
 =?us-ascii?Q?kK7WZCPhFYFBD3eW7TjNTR98cjXW26nKyhhWcQ03lkpsBLhd7mx+C3xhFaub?=
 =?us-ascii?Q?5/iuPhEhCR4HQreuPdilEXQ4TOFjtP8nkNtZzWGvJjfIBDHZVRtjCw/G/Ka2?=
 =?us-ascii?Q?2b28G2r1S/pkmKptQmrh1tceUVr1V8JhItTdoqg+vdzPDDkijc6le8nEZQy/?=
 =?us-ascii?Q?6e7vNKuV4oIcJVl0lDQm91SaUCXvF/l96eQ/0rYBwgk98+CogIIn1F85Avji?=
 =?us-ascii?Q?D64TMCy7HEc9uZG4vEkHE+wvtNF6pbDNGRg23lwS/XGDEuZPhLCwXFQh1602?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qnEWT1QE1p0NmNgpEr/q7DtkQdg6LQBHqo5yqmjItdX6KR538EvQD+x+2qsIizfqnYpfkkulgUeKcrfPCDXl6h20ahiEqZRGPwrFX8QFGdKsa61FXsAJZHSiAaN6U6jnt3WUcdTkxr+M7gQR43wKjAdhzJsHaxIYAf+oCdHvs5Ez6ncqjNmUuKq8aw2fk20uCJuhMqYVRt5qePQsi9JR4e9bY3cPKCgwWyzNAabXbA6V6k1BYk6UCK68+6elxVuAOKOnTey2auxzhwMBLfj2qnuLwMNwwgwJkNIXj8bhQSOlUjTAPncOTeCPO5wVzX+WVQtu13qhDqghtIrbr6ZCjKdjrcd3sHnudC+QW9MDbOog+T6S5w5np0uxAEzcoNPw6G52Z4xBYvCKk+nkKNVgZVFh+Tw6Uv8E8+5IGEz6nI1V8/2Q6qx2cUrR9WQuqdcoJ/7manVovlMt9LCnpPbE96qr8INynpxY0NlsKOwjVsAOR0GHyIC3Voc9woQ9CqGBLhXIbphtAcBMbY/phfJDg3zwz+BthXekDLN0+t0qEJShl5QrPnA6a/i6G9H7GNri7Kdubg9J1vUIJ4dzsabmsLSzBGArllOPnfbowok4Owo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb06187-c23a-42e9-c54a-08dde8271c3d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 00:41:23.2926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFs6LkX/GiXwoREEsLN1LSji33ucrAit1oaF/PfBUDeQEJmA9uJKoqCOXzMg1jL7uHATF5UMiDO2sLICmkcCj8SGxZEQE8a3tFZswOIUjAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6345
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-30_10,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508310004
X-Proofpoint-ORIG-GUID: xQ4W47kqKZmwlKay3ar-2WXDmnlcdUNZ
X-Authority-Analysis: v=2.4 cv=YKifyQGx c=1 sm=1 tr=0 ts=68b39a37 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=pATWPwfc4T3Y6ry7u_0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX9tWAEXlB0QXF
 UM0uHlngz/z1vEmz3pwNgBubi4Cin2Y5C9Dc7DvosXZTrpPF/Z63FlzPR7WyIeFyzo+9Ruj3Sor
 7CSzMQL1kofeduDSNU4o9MTdjqBPIcpPErejTja7i+YPnYt4o+SkxnKA9c3RhT80JUzO4PvgCqy
 zUVRZbFMIBGsKRioZExYuROPwEY3lwSMdbmeHZGifuNFQXYhCy0VlWQC016/gw8G48Xadvynjxd
 IyC0LfEkmQ0vArkdw/GWY8fNvHHQ2Z1SSklPtQpQ5bn0UBLf0jJGXgM8iA+w0N+vcz/mPYuRxGE
 s5fAHpN7H7BfEtrd6BJnn9xerRmuTgSArttfSg4xEClvUEsa4GfBkbszgV4s6u316swvBPhg+1U
 ATq8ZyFi
X-Proofpoint-GUID: xQ4W47kqKZmwlKay3ar-2WXDmnlcdUNZ


Keith,

> Instead of ensuring each vector is block size aligned while
> constructing the bio, just ensure the entire size is aligned after
> it's built. This makes getting bio pages more flexible to accepting
> device valid io vectors that would otherwise get rejected by alignment
> checks.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

