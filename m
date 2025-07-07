Return-Path: <linux-fsdevel+bounces-54050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FAFAFAAF2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 07:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C29B189B9FC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 05:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E590272E54;
	Mon,  7 Jul 2025 05:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pbPgRVOW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L6iey9MC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700C2270EBD;
	Mon,  7 Jul 2025 05:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751866213; cv=fail; b=aC7dADpCvXRNIOM8YYdZE1r3HqDMfnXdIF8edKOyAMUP8TjcRJUyMN8iyQPjrAIiUNrucEOIT1CUb4U8PU2mcbcLFDKWToGJVAwQZQuDI9V/x59+8BLSDhrF/6x++OxMdq2gkQpvH3NNmSAe0lm97ynm7iYtpHmEDFJWMDSbCD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751866213; c=relaxed/simple;
	bh=p4rBH7+zbmjKOeJl1F14SbKU1NNBf4jyZngLhu8VWYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IanrCTjL82jyMuheiZMW+xTXKH5XdfpBW4iRWJ33SW6Rrnnr7ffWc8Gmvtt6lPKQg6HB/ulMy+SF7cVDVmILnhUccLuAdNB5k4OBV+Z/I1toUgxd6gpo27T81h2+GSbixyEwe/T/T5r9xbJX/+hvi34P++3ovgWV91KrtQQnY/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pbPgRVOW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L6iey9MC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 566Nse1h024569;
	Mon, 7 Jul 2025 05:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=I3UdtRi0fk56F8aWl6dlmLResypWNDKfT5TmPQSA3tQ=; b=
	pbPgRVOW68HG7boBjJSsTtM93sB/T3yATB0OJ9HJuMZrK26l/diZe95Bl3F/WcYq
	vMYDhs+JKHVtTwhUy1Vq8hNyc3Dk38K8u2r2Z/Cj51eX5aJG4pjLY0NvagxI8rw2
	iPAczTRh4xj9Urvn6I3y8yCVbPWtk/nE3ktsAwf/rJV84J/w1L6jMe2yV3OOsnSX
	EPubnj49hXSVWeL8DWvMtk+xmdT1Z81yVgZL4fsOyMj12Bt3Z6ovvCJeF/aQg1c1
	vseTvZOzfy1dx9ekH1c1ZA88MzyScQIrUYDB06nynttYw2agvAqx3rUvU9ek+E/O
	T+wXIaUeDRaT5SXYwzMFLQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ptn520e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 05:29:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5672PVBs024285;
	Mon, 7 Jul 2025 05:29:00 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg82hd8-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 05:28:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GX1jMeyenkGP8dWn6M4pBZJPJrHtAsSc4jHo2uhshY0IONAKksDbnrApUUUJ2wnmzRQXFWPm4elHJHjLgmPoi27dw6kU7xyt33aHeBKOm0EJ4mT6Bv3N6BfLdnj4olnKyEFRFZC1ik14Cd+ENaR3I5evWqPpL3be83IBdgJQs5u50i2qxgxrn2htah3dwiU7dTo21WfOYlMqTPy0w4tGAfaA5FyhLlUXR7xdTOBuc0ratQGPIqfmyA5jHph5UqrTl3uqvJfkcwhN0VaomeouTSxZBHJV1UiHMoJ4fhWpjzUwq6LnA5wyDVcjNPVdHsle+PgmxYizBAVlDEYyRZAzPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3UdtRi0fk56F8aWl6dlmLResypWNDKfT5TmPQSA3tQ=;
 b=eZPgg92il71Ocge8jaxKugxkxtg0IeKKIrJhVA+LcipTEwJCCWUWfuJCXsTmJeZNc98xIjkqO9MZyKECQigch1D+JD+YadRrI1vQrLUsVbDB1J0H68rrMpRitiSNaY1csTmADohs8V+vJ3XkkbyMPLhWjEmZHmiDqfhZVXyqxlhV1mIufuRWLaX7S3HHnYKxnSWZaFJ0ZUGwGktlZV4G+AQY1DimAcpD6EEJj/YZTJuUcGRQJkLBXgyYELHymifjitcsC0Wtwd1GQavPsbBMl5gk8F3bjXC6wj4FUHuJdtQp+L5QMzrvR7EG2jIBRdHnJdxXQ+73U/YWhbMhauuS3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3UdtRi0fk56F8aWl6dlmLResypWNDKfT5TmPQSA3tQ=;
 b=L6iey9MCmu32PjKoB0xKwLlJl5FeZiblXnBpUpKcpkD/Itc/NLD/q8R6SZofekGtBxqCH+91nBvO/3y4Fc7+cBR0buSex7ykshJNYlgNxLLkmpMJXOLw5/ffEfiYnbyzSN52j3tBDZRORbNXLKG+QIO3HEtCZoL+tGi6gRNWa5s=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF00080FB4B.namprd10.prod.outlook.com (2603:10b6:f:fc00::c04) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 05:28:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 05:28:48 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 07/10] mm/mremap: move remap_is_valid() into check_prep_vma()
Date: Mon,  7 Jul 2025 06:27:50 +0100
Message-ID: <a45b7705469cfd139c4727e8898fc3a7c50cb087.1751865330.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
References: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0380.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::32) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF00080FB4B:EE_
X-MS-Office365-Filtering-Correlation-Id: fb0b144f-2801-469d-8874-08ddbd17265e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lxYgRDU2qxOdrl1nKbEd7GLa6shocezGmr0hcXGUv2je0SR8OwzD2eOBWk6c?=
 =?us-ascii?Q?1os1EnSjCseP0FSc4HDxAuGwFIS17DjSG/C6MXaMCQoiXpXreg10h8Z1nRoo?=
 =?us-ascii?Q?ph/tlc4olEZfqKsrbetDWd0lNuHzcrV6AjR6A2MYmYpWwD8P+W1k5/L+rULu?=
 =?us-ascii?Q?BDnsXfc9ry6uDsnG/s1gW84pD3u+DAz9EYiYkD+7MAv0wwkOqt9f0oasxWQJ?=
 =?us-ascii?Q?xXrGaQ+BtcbnQ4ZmHlN4wDB2+ZTSQI0yyilcL/LhdvhTZ/mvfnuX/PomDXIk?=
 =?us-ascii?Q?rDwAbaR0Sxj5Z1gqgpSBhmxJumtb0JqdmDUYtA47Fk4IyzlyBWoiCKgnGl5O?=
 =?us-ascii?Q?eXd6jRQ5YEzXHCb8sUccHYiD/aUJBgDqCDyehO8n/tSkjSW4W4mzQrNJSmdY?=
 =?us-ascii?Q?EMkSyNl9kATyPcrn9NPLbLGcjZ9nCbS+FPC3VJxJveF8IqYy7xByb4T0v0bl?=
 =?us-ascii?Q?IPDDrn6A26/4vTKMx6hadjtz6hj5F5ec8u0ImnDnowuTy1alBB4FHUCTD9mO?=
 =?us-ascii?Q?qRSZ4B0X33wKLawXUNbNehllA7mHKqpE9Hi6yh5ZYbQoTdFiAxct1Rsbivjm?=
 =?us-ascii?Q?tI6SnU089mJLJHbTNa06nlgZ0nvenMLMoiuRgjYdKvZlerevkAyJRDV0Js0i?=
 =?us-ascii?Q?yRjvsfsKPfPUl0MFFNHK0nOBk+/0QL7O/daoOEHL1jQsBfi7cdRCGjucDnA9?=
 =?us-ascii?Q?o7kFL9skfz1ZdJmIK67d7IUzltpKtUPTddYw/nxqNZsF53ab37kB8+4YlDar?=
 =?us-ascii?Q?XKPDUzYXJXNEI5BCmsKeiUWa9j86XVFV9CRgwt6Ijrm3Wo94rMTNuaUIOpfj?=
 =?us-ascii?Q?VewX0fcTf+3BKXZuow4hoWZGNnxdcBr5WCWbBTf0iRYCXQFBdmbu0J8vdvzf?=
 =?us-ascii?Q?vH1EXUTavCgwrkFpe2/EsuBcBQDQwVSw/JFUn4mYYd/OyPoFAYXgIB3RIhPC?=
 =?us-ascii?Q?biQDr98XVmaJGdEPSQT8+KMGS8lpnK2MFtA+hTSer6UgTWBpjLrg6NgTtFKk?=
 =?us-ascii?Q?TSi+05+XkJMnvWdCW4IFf5sxd94NNFzGFXo3dvGeU/6pvsa8Is84XJdQ3AYD?=
 =?us-ascii?Q?K2gndeAAIL4CFptqblF0HDMexIATxYjakhEEWuZxqaH8fjkvGdNtHiAEoylv?=
 =?us-ascii?Q?lnVLtrguEhIkq9I684R8nG/TwFnVVBZ9U/CY9dn4CTbVhMkRrpS1IInPVTa6?=
 =?us-ascii?Q?1g8YJ1I/RwV2+t8cHBPlu8fpSjMpWj4NmrG759kJVixRH5oXfZBOfCtFfR8o?=
 =?us-ascii?Q?lkrPgLz1pvBzx7D00tHl2PSdbYHb/dL8AN7uUC9nq+ZIzfDkalHGmq8ig6Ot?=
 =?us-ascii?Q?nJP4mCUWTnxUKfMv6r6qfCiqE+sc3yKn9PY7QNX0p+ipUXisJs0NwQcjS+d2?=
 =?us-ascii?Q?uNeOc5LS3M0q7RrbrWkTv6sJATAZf4oOiWq5NaCjZPxkaaFyI2FTtuxpf/Kw?=
 =?us-ascii?Q?/jIfKeJK/vE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MqjaH5/163UnxsPnVZC+EHZ5XLt5CqBxoQlaAAqV6zBNWM+oZ6BjG52VoXlh?=
 =?us-ascii?Q?w2vV9NXK0PnKagDFaZvyA4lYklsa0aJlWNxM6vSf9fUFZrcZVreyUnbepQ4f?=
 =?us-ascii?Q?3QZ2GzA575xt/4PwNZpwFcOJaqYt+YlMvv7yl1DlXqeUtQhVX0jFx8vtVva+?=
 =?us-ascii?Q?T1b4GAtlf2shxSMCllMwisBoMD8sTyK7+Vry+MpJkzJcnGbhOxNlbKQh5DNk?=
 =?us-ascii?Q?zYAN9IzyE9G0E0FKNoOlJ4tTIY/ezvkCTAb0rqvmn1HnMMoRzwkcfc/2st7l?=
 =?us-ascii?Q?U6xjR/xrrfPzadk0bnrRmb2IHBhoyPxmWG64pwuw7TCCFht9m4vTuHoEpxp/?=
 =?us-ascii?Q?KGbEcTdmAnmKAPrnBV6IBN6o/S7quKGdab8Ddbozc59+gQX5g5E0Ge60q59f?=
 =?us-ascii?Q?SBy0HOzR/7fWZ86FVICij/Clp9vJuC7fljR5N9bE+gx1Je46DrCL2Miuc2v8?=
 =?us-ascii?Q?4FyjYQS4xeuYHQXzw3f0lCIWJUzxuJrjHNjN7Y0ybit+PmmsQEaIINsB3tAF?=
 =?us-ascii?Q?CB3JDeOKLOsbmzaJPRR+/dCCZyK4Z22Yc/xJF11tdqrMJu7Jp6OopoJZ9DAX?=
 =?us-ascii?Q?iFThJNHo2L9FNkC9rcbiOwmdEfDVeVZWTBjFz3ogREVo5pQPm213MK15Kb0e?=
 =?us-ascii?Q?UuFLy83wRL0MXGLtSqckD50itVilibqnHokdQRXQyc/lL5W/R2V4UHgBrIOF?=
 =?us-ascii?Q?+A8KKKRZLondBxaBOoul8hdhsrKDLJfZSp2777oKYWkYpmibjlekBmVywWe+?=
 =?us-ascii?Q?0zgSovxNos5S7kmUtpFC86jluDWWVAbpfGfXH90NXVKackp8Pujh8pYS8/i7?=
 =?us-ascii?Q?VpRNWyvs2/drXa4yCIGGjp55rjUi90bkfRf4BXTMNBribqi5doHJwzdZea8B?=
 =?us-ascii?Q?WXE1tWbJgoHoyKb3cq0xlGYuUBouFsjMgZ4hXyGKzNRQ48Em8S8loE29ChAD?=
 =?us-ascii?Q?4IugeeL8x4fDAVz0UH8qUNajK9k1HXT5W3+UY3MXX+XEpNTGh7mWGZCjqdsk?=
 =?us-ascii?Q?qJPJWWitlxau/EYQM8+HoNPf+WgD39RYlfVce0YEzKTuv60uizM9nzTU75Fa?=
 =?us-ascii?Q?vFnbWaUrRR7AbQw5AmehLUDsWQ4nCk7TmfXHlwDlphxNWrZvCT7MmMtlOoL5?=
 =?us-ascii?Q?regUZy9cqaH/jFdOG00x7TzkoayjpFQz6Br/Eog85wvfYf3nMHoS2LrmNjWM?=
 =?us-ascii?Q?TSYSxJrpdMwjzca/xuFySnZqNF2/6MBlnfgBR0wmTt8FuIrcslvO72ZmXSJg?=
 =?us-ascii?Q?ruAVBzBYotEhqZub3Vllx4PC/EntE/ZTQG4W1MGzuk97fwHRFtO8mdI4ndDX?=
 =?us-ascii?Q?iK5RqkMAciX2++IdiFkYcpltqae6a9QkUYGhR+Xu+nbAOGHza1yRLchmKTJZ?=
 =?us-ascii?Q?JFdmresP+apV/wPa/zfQdHvLbZlNzFXm0xLT48qf5aEp4gV341nsQ9pcArG/?=
 =?us-ascii?Q?tuWqYUcJi+ddzM9TUF7VHHTxhNG6t3TEgYoT/BnfMHcJW2Ak7yhp6GrA7aMj?=
 =?us-ascii?Q?oXYwB0czo2NLdEtbF3bTxnOqS5rxwTd6Tnhfqzse1bfPMVay2++gbmU5pKiB?=
 =?us-ascii?Q?GrWz5MR1y4onWYBm8uvDUx6PPlV1UBM8pIQUOJ+rHbUBx7sokp0oNY6oA5FF?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mZUR6zoOAooai7zzi77+SHIGNEkc6bedu+OCgDXWzRK3sMrceo0VFCsD7GTcSWF979nQflXWk8nKsUo2d1fDb6IJCsXM8BLB+CjICNzO+a9cer5JEne2pKDeITPet3FMRx3X/9WNmfiQu5zmSIEvwHlWQIWke2PXs53Cw9G9rO4L+DZFmNsRQhw2Vl1jhUVoKAdoDEPRmg80yvL9c51fvQYwyrr66/kvdFiuoLEutVygJKRhE/a34NOJKP/OlANqRJyPsuZiZ290VuXOnZ7h/d06cnbCqIXkv7VRQKXA/oLK6D3tRWZfXf6bKWzPO3VhI4vo+mjn5JZWmFqUN+uyhuBex4VYa7LbkqFv3gY92FnU4VS0fTX81F/0hBt7D8Bxz8g88PzruyN3igQB8Nhv04SnW3/Kw3DkRQte97kPjhV8njfPgBca/RJNW9vePfjY420ywV+90U+QAYO2R6gkMpDT7oBs/uxhKV9G79ILrRWarJNHC1Xi75KgxeiNTvX34Hrz08yF8c0dSJpczyJF/BnPzFDgNvAj1cQ0nEkxd/+NptqBbF8t/ls1IRYkVALFclKzOBe3j1NxqcqqnDJAAiymjXLmaLM+R8crT2TYjf4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0b144f-2801-469d-8874-08ddbd17265e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 05:28:48.6731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CneNzv7Z88aS7zoV/smVbDLR6SeaVJmnSiJSNoIpHUZtLdz77MAAtsLgULoWSfcLLopmIHQx0/Rb9m67IruqtYFMK2FwktHLD0IMVOPG3Ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF00080FB4B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070030
X-Proofpoint-ORIG-GUID: g4tXK3MKEBzMFJVInWAnmHbG-facoDqi
X-Proofpoint-GUID: g4tXK3MKEBzMFJVInWAnmHbG-facoDqi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDAyOSBTYWx0ZWRfX6gShlgb1l7s3 Syah/zvGb2ReaLT3gMG6EGm4+ZbyD+hRXP+U8mOJ3W8hsUUduHsFdlCYClSvTMsuS1ygYA4PWKM D0zFWedEqI3y0klWp3/RPlUDSVxTTSPVOeolpoEtYxYb6CRAP8lUMyfvxKEao2J1MZ3J7DmecCM
 0LMEiTRzXoInZyw40IGB6CngyCk2ePxtwAWcv3hEQvv3n0IXp8iz5lMqS0w8pwipMa2cW+rLNn7 7LtZJLFKmLXkUiV6B0cGlAPXqah573rhZK4LIqNkwhIzeCUn+3mdhBupH8bsUBmTtOoKEPs4zEW 2XSQNNzis542j6b7LLix83mJhJB5ad/Ef19J/+9qw+0kQAwCJ1wkkP6ZhAW8DNFOEfoKN0g5W/M
 QDuhf/Q+K/dqGPBNmunqVD/+4Ly2pJBaShI3dIxDIJzJ+y7ogYTM4edmpWt40XlEREP/whbV
X-Authority-Analysis: v=2.4 cv=UpRjN/wB c=1 sm=1 tr=0 ts=686b5b1c b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=JNHyDlmCLAJVxX-Ft_0A:9

Group parameter check logic together, moving check_mremap_params() next to
it.

This puts all such checks into a single place, and invokes them early so we
can simply bail out as soon as we are aware that a condition is not met.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mremap.c | 273 +++++++++++++++++++++++++---------------------------
 1 file changed, 131 insertions(+), 142 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 20844fb91755..3678f21c2c36 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1306,64 +1306,6 @@ static unsigned long move_vma(struct vma_remap_struct *vrm)
 	return err ? (unsigned long)err : vrm->new_addr;
 }
 
-/*
- * remap_is_valid() - Ensure the VMA can be moved or resized to the new length,
- * at the given address.
- *
- * Return 0 on success, error otherwise.
- */
-static int remap_is_valid(struct vma_remap_struct *vrm)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma = vrm->vma;
-	unsigned long addr = vrm->addr;
-	unsigned long old_len = vrm->old_len;
-	unsigned long new_len = vrm->new_len;
-	unsigned long pgoff;
-
-	/*
-	 * !old_len is a special case where an attempt is made to 'duplicate'
-	 * a mapping.  This makes no sense for private mappings as it will
-	 * instead create a fresh/new mapping unrelated to the original.  This
-	 * is contrary to the basic idea of mremap which creates new mappings
-	 * based on the original.  There are no known use cases for this
-	 * behavior.  As a result, fail such attempts.
-	 */
-	if (!old_len && !(vma->vm_flags & (VM_SHARED | VM_MAYSHARE))) {
-		pr_warn_once("%s (%d): attempted to duplicate a private mapping with mremap.  This is not supported.\n",
-			     current->comm, current->pid);
-		return -EINVAL;
-	}
-
-	if ((vrm->flags & MREMAP_DONTUNMAP) &&
-			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
-		return -EINVAL;
-
-	/* We can't remap across vm area boundaries */
-	if (old_len > vma->vm_end - addr)
-		return -EFAULT;
-
-	if (new_len <= old_len)
-		return 0;
-
-	/* Need to be careful about a growing mapping */
-	pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
-	pgoff += vma->vm_pgoff;
-	if (pgoff + (new_len >> PAGE_SHIFT) < pgoff)
-		return -EINVAL;
-
-	if (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP))
-		return -EFAULT;
-
-	if (!mlock_future_ok(mm, vma->vm_flags, vrm->delta))
-		return -EAGAIN;
-
-	if (!may_expand_vm(mm, vma->vm_flags, vrm->delta >> PAGE_SHIFT))
-		return -ENOMEM;
-
-	return 0;
-}
-
 /*
  * The user has requested that the VMA be shrunk (i.e., old_len > new_len), so
  * execute this, optionally dropping the mmap lock when we do so.
@@ -1490,77 +1432,6 @@ static bool vrm_can_expand_in_place(struct vma_remap_struct *vrm)
 	return true;
 }
 
-/*
- * Are the parameters passed to mremap() valid? If so return 0, otherwise return
- * error.
- */
-static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
-
-{
-	unsigned long addr = vrm->addr;
-	unsigned long flags = vrm->flags;
-
-	/* Ensure no unexpected flag values. */
-	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
-		return -EINVAL;
-
-	/* Start address must be page-aligned. */
-	if (offset_in_page(addr))
-		return -EINVAL;
-
-	/*
-	 * We allow a zero old-len as a special case
-	 * for DOS-emu "duplicate shm area" thing. But
-	 * a zero new-len is nonsensical.
-	 */
-	if (!vrm->new_len)
-		return -EINVAL;
-
-	/* Is the new length or address silly? */
-	if (vrm->new_len > TASK_SIZE ||
-	    vrm->new_addr > TASK_SIZE - vrm->new_len)
-		return -EINVAL;
-
-	/* Remainder of checks are for cases with specific new_addr. */
-	if (!vrm_implies_new_addr(vrm))
-		return 0;
-
-	/* The new address must be page-aligned. */
-	if (offset_in_page(vrm->new_addr))
-		return -EINVAL;
-
-	/* A fixed address implies a move. */
-	if (!(flags & MREMAP_MAYMOVE))
-		return -EINVAL;
-
-	/* MREMAP_DONTUNMAP does not allow resizing in the process. */
-	if (flags & MREMAP_DONTUNMAP && vrm->old_len != vrm->new_len)
-		return -EINVAL;
-
-	/* Target VMA must not overlap source VMA. */
-	if (vrm_overlaps(vrm))
-		return -EINVAL;
-
-	/*
-	 * move_vma() need us to stay 4 maps below the threshold, otherwise
-	 * it will bail out at the very beginning.
-	 * That is a problem if we have already unmaped the regions here
-	 * (new_addr, and old_addr), because userspace will not know the
-	 * state of the vma's after it gets -ENOMEM.
-	 * So, to avoid such scenario we can pre-compute if the whole
-	 * operation has high chances to success map-wise.
-	 * Worst-scenario case is when both vma's (new_addr and old_addr) get
-	 * split in 3 before unmapping it.
-	 * That means 2 more maps (1 for each) to the ones we already hold.
-	 * Check whether current map count plus 2 still leads us to 4 maps below
-	 * the threshold, otherwise return -ENOMEM here to be more safe.
-	 */
-	if ((current->mm->map_count + 2) >= sysctl_max_map_count - 3)
-		return -ENOMEM;
-
-	return 0;
-}
-
 /*
  * We know we can expand the VMA in-place by delta pages, so do so.
  *
@@ -1712,9 +1583,26 @@ static bool vrm_will_map_new(struct vma_remap_struct *vrm)
 	return false;
 }
 
+static void notify_uffd(struct vma_remap_struct *vrm, bool failed)
+{
+	struct mm_struct *mm = current->mm;
+
+	/* Regardless of success/failure, we always notify of any unmaps. */
+	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
+	if (failed)
+		mremap_userfaultfd_fail(vrm->uf);
+	else
+		mremap_userfaultfd_complete(vrm->uf, vrm->addr,
+			vrm->new_addr, vrm->old_len);
+	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
+}
+
 static int check_prep_vma(struct vma_remap_struct *vrm)
 {
 	struct vm_area_struct *vma = vrm->vma;
+	struct mm_struct *mm = current->mm;
+	unsigned long addr = vrm->addr;
+	unsigned long old_len, new_len, pgoff;
 
 	if (!vma)
 		return -EFAULT;
@@ -1731,26 +1619,127 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 	vrm->remap_type = vrm_remap_type(vrm);
 	/* For convenience, we set new_addr even if VMA won't move. */
 	if (!vrm_implies_new_addr(vrm))
-		vrm->new_addr = vrm->addr;
+		vrm->new_addr = addr;
+
+	/* Below only meaningful if we expand or move a VMA. */
+	if (!vrm_will_map_new(vrm))
+		return 0;
 
-	if (vrm_will_map_new(vrm))
-		return remap_is_valid(vrm);
+	old_len = vrm->old_len;
+	new_len = vrm->new_len;
+
+	/*
+	 * !old_len is a special case where an attempt is made to 'duplicate'
+	 * a mapping.  This makes no sense for private mappings as it will
+	 * instead create a fresh/new mapping unrelated to the original.  This
+	 * is contrary to the basic idea of mremap which creates new mappings
+	 * based on the original.  There are no known use cases for this
+	 * behavior.  As a result, fail such attempts.
+	 */
+	if (!old_len && !(vma->vm_flags & (VM_SHARED | VM_MAYSHARE))) {
+		pr_warn_once("%s (%d): attempted to duplicate a private mapping with mremap.  This is not supported.\n",
+			     current->comm, current->pid);
+		return -EINVAL;
+	}
+
+	if ((vrm->flags & MREMAP_DONTUNMAP) &&
+			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
+		return -EINVAL;
+
+	/* We can't remap across vm area boundaries */
+	if (old_len > vma->vm_end - addr)
+		return -EFAULT;
+
+	if (new_len <= old_len)
+		return 0;
+
+	/* Need to be careful about a growing mapping */
+	pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
+	pgoff += vma->vm_pgoff;
+	if (pgoff + (new_len >> PAGE_SHIFT) < pgoff)
+		return -EINVAL;
+
+	if (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP))
+		return -EFAULT;
+
+	if (!mlock_future_ok(mm, vma->vm_flags, vrm->delta))
+		return -EAGAIN;
+
+	if (!may_expand_vm(mm, vma->vm_flags, vrm->delta >> PAGE_SHIFT))
+		return -ENOMEM;
 
 	return 0;
 }
 
-static void notify_uffd(struct vma_remap_struct *vrm, bool failed)
+/*
+ * Are the parameters passed to mremap() valid? If so return 0, otherwise return
+ * error.
+ */
+static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
+
 {
-	struct mm_struct *mm = current->mm;
+	unsigned long addr = vrm->addr;
+	unsigned long flags = vrm->flags;
 
-	/* Regardless of success/failure, we always notify of any unmaps. */
-	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
-	if (failed)
-		mremap_userfaultfd_fail(vrm->uf);
-	else
-		mremap_userfaultfd_complete(vrm->uf, vrm->addr,
-			vrm->new_addr, vrm->old_len);
-	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
+	/* Ensure no unexpected flag values. */
+	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
+		return -EINVAL;
+
+	/* Start address must be page-aligned. */
+	if (offset_in_page(addr))
+		return -EINVAL;
+
+	/*
+	 * We allow a zero old-len as a special case
+	 * for DOS-emu "duplicate shm area" thing. But
+	 * a zero new-len is nonsensical.
+	 */
+	if (!vrm->new_len)
+		return -EINVAL;
+
+	/* Is the new length or address silly? */
+	if (vrm->new_len > TASK_SIZE ||
+	    vrm->new_addr > TASK_SIZE - vrm->new_len)
+		return -EINVAL;
+
+	/* Remainder of checks are for cases with specific new_addr. */
+	if (!vrm_implies_new_addr(vrm))
+		return 0;
+
+	/* The new address must be page-aligned. */
+	if (offset_in_page(vrm->new_addr))
+		return -EINVAL;
+
+	/* A fixed address implies a move. */
+	if (!(flags & MREMAP_MAYMOVE))
+		return -EINVAL;
+
+	/* MREMAP_DONTUNMAP does not allow resizing in the process. */
+	if (flags & MREMAP_DONTUNMAP && vrm->old_len != vrm->new_len)
+		return -EINVAL;
+
+	/* Target VMA must not overlap source VMA. */
+	if (vrm_overlaps(vrm))
+		return -EINVAL;
+
+	/*
+	 * move_vma() need us to stay 4 maps below the threshold, otherwise
+	 * it will bail out at the very beginning.
+	 * That is a problem if we have already unmaped the regions here
+	 * (new_addr, and old_addr), because userspace will not know the
+	 * state of the vma's after it gets -ENOMEM.
+	 * So, to avoid such scenario we can pre-compute if the whole
+	 * operation has high chances to success map-wise.
+	 * Worst-scenario case is when both vma's (new_addr and old_addr) get
+	 * split in 3 before unmapping it.
+	 * That means 2 more maps (1 for each) to the ones we already hold.
+	 * Check whether current map count plus 2 still leads us to 4 maps below
+	 * the threshold, otherwise return -ENOMEM here to be more safe.
+	 */
+	if ((current->mm->map_count + 2) >= sysctl_max_map_count - 3)
+		return -ENOMEM;
+
+	return 0;
 }
 
 static unsigned long do_mremap(struct vma_remap_struct *vrm)
-- 
2.50.0


