Return-Path: <linux-fsdevel+bounces-51056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C28FAD2484
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 18:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4DA16A87A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 16:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0455821C186;
	Mon,  9 Jun 2025 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QO+sWEYk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LZExErLp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F89821B8F5;
	Mon,  9 Jun 2025 16:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749488299; cv=fail; b=k5FM9aBTgH7zt2kFanOqIOSZv4Vlwyh2EmWYIi19aRqUocbRdyjjAz6d2Du788BxtkUDH1XwrD6QdNs2tevJlu79VTRUfbGcJZw/UIbdQaR/awkupddUQsPV79WguyZTUqUwNlVSPzWrQ2yYW0dVcl7D0d9sfmXRTeiaIcrqOi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749488299; c=relaxed/simple;
	bh=/TfPSItdSCUoo1sYfiVny4hj/Zclswh/xZIhQuGP+Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tV5GPvyicoq+UZyesgf8iOhBpniqDCdwql8o5tjgt2jotQo5kTkKMEaFrrQ9pcs0KZRWII0Vo9CNV7YJ41KVk+uzomYZfbC4m+fIfSkbrE+VEawHQONuNNGapjji6wfr2JmpZsTe31UG8lHZSD6XOsM3U9N7VmgeafdxHidKbXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QO+sWEYk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LZExErLp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559FeME4005112;
	Mon, 9 Jun 2025 16:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=ZxxLlgsCrlt4XBLy
	uHZ1nVxpO8zjc8GYcrs2e+UKhfQ=; b=QO+sWEYkuupEL3x0YnvtR4voi1tLjQxI
	O7NAz4KpVayrXrygHVkzxOIL89Mm6QpdXOfcWj6ux41E9sT+dX4Yqx6yXJ1j08l6
	LCusnXiU0Qi3MBAw7JcwWwoEGsirzGAVxXmmd7EP0mnK0pkJgaN6Nd2YT7Wpl877
	tkkeCefENkbWR7lL/p5tonmcGdpJitgAsU2eGhiO8/12YnSWgNpV5L6QDM3Bd7w4
	dmLOMb2toG+ZAkVbCUpygNHl32s65NFo3JDdanOrjSVO8VbCwLzYWdZx+gcPLem8
	AaRmsVmLprJ/m8Q8jXUpv3xy+TEqSpD57hJIww0mWb54sSIm/X0Jlw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dywthrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 16:57:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 559Fjipx032159;
	Mon, 9 Jun 2025 16:57:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv7p2hd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 16:57:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPNjXDY5vBTEiVS1tGuAvptBM+5JMuUzvWVZTqTwW2rNm8L9sKe8OwVEWxYdPtN/FO5Hjd1Zs0XDETnP8gNKwwlUEFvMkXqoPOapreerHMoMaf1H6enyWy/jw88RLYUfsGuweF/5AO/eiaC60KWfZHxcoiHLq0cHdJiBeYTbTrAnFZXGw5AcTZpnIdVqfC4yXTibdZbB4aJKNQAelFtP6AwDCc/lQJybVAoCgfJf/laj4QadQE8vVjo82k4hnK6hu9Ss5YJ9MseypCNbkhiQsAQGk5YLvvh90cSpot2Ah4h5jGTJNz9rANiWo4fuOozt7LRnx38h1e4irJsmdlVcJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxxLlgsCrlt4XBLyuHZ1nVxpO8zjc8GYcrs2e+UKhfQ=;
 b=ErxxlDP2Jda14I5nIZUiFEGGLreD22rT2g3jQ2C7m2Z5eq7VyUtGptPEvOSGJ2ZhnDLuQtdOysy6rm3toBCoZ3Tv9maPU7zfPosT46uSjrUKybpLFyu7mnvCfOEDsQ0g0Yf9J4mRLw2BoEBrwQw0hu+5D4NSkV94wWKli0DBnbx2qfzJTf8P6mdT3FcuIqFTvek4L/mXQfQdhetLQEVXLIDCFFMKZJ1zuJ9iV5rHATal1h4NSL4JY29HwnNqJ+jdKKsY3Cg4HhoEtPeosJSag/2zR6AAVKNPQ08A+aYivILHWMUC+vz+CBaXNrN/i02xvL/eo0Bk84Y/lui+BQvInw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxxLlgsCrlt4XBLyuHZ1nVxpO8zjc8GYcrs2e+UKhfQ=;
 b=LZExErLphsek4OCBj1Wbk6fqTQ0Ngze4PIVz4hQLPg9DcUrwk+P4KcDr/a02Ai3fk6xyiWnrdT65nuHaeHJ1QvdNMN5R9q/wp7sm65Zr/XOdz40XTizgAFvE+d3LdGImBPHo2lhOZI/E6mOE2jgzUEGm2l+48gwcIB4FH7wkATI=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by LV8PR10MB7943.namprd10.prod.outlook.com (2603:10b6:408:1f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Mon, 9 Jun
 2025 16:57:54 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%4]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 16:57:54 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2] mm: add mmap_prepare() compatibility layer for nested file systems
Date: Mon,  9 Jun 2025 17:57:49 +0100
Message-ID: <20250609165749.344976-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0178.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::9) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|LV8PR10MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: 51775cb6-cf4c-4e5c-b35a-08dda776c710
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fM2S9qJsktRex7zKISeGcXUDKC/FGVXpJ2DODoQBXsGA2M+Y7p1NNwf6F4OZ?=
 =?us-ascii?Q?+s/R0Z+Adjn1E7/lCsZvXrngaRKduNX7Y+5/EQJXnrpIhX+TvI6QSQ9RLCIX?=
 =?us-ascii?Q?s7weHjBL0c1y3n0HB4BE+YAn4n8UoeVONU3PpEUL9WTp5pFUPMXSOC+gsboO?=
 =?us-ascii?Q?e6VYlWJw9VEUfa7a/Gu7VbsKzbnGuqLAqtUTRZyaqwIoT6r9wVxukqcx5Q/l?=
 =?us-ascii?Q?e4BEzeowchJ0xiNhxFKXiueg8Ob0wsHtMBYI0miKAkU8ty+8iRlbo+q7kOwM?=
 =?us-ascii?Q?mdOHDNHXA5ES+pH7X8Qi5BlfN0DC3lD1tA6AbakW1EFmzY5M9Q/M7KXvZIYp?=
 =?us-ascii?Q?iHfxa529otOGYXQ42xnTe0OIeo3gF6bbUWY+GxE8Av062SKarADLg9Jow+Wz?=
 =?us-ascii?Q?W6XoJc3uQCK+yPXjXIgjSv/vMhSr8kUUEfl3DWcmsLUxfbCbdAy5uqUK+ehM?=
 =?us-ascii?Q?pIGSbh08rFz5TWaezHMlGX0Dnqo6KnNZmqjTjuf8ul2fhvxIMbSzrAc/mVJl?=
 =?us-ascii?Q?N5nKs+RjZV0i9g/wDUGN4BBfFD2XQ9H1KXjJm5ijhSJZYAn1dFiD9wAzKoz3?=
 =?us-ascii?Q?LfnPegA4sZ4jYaKkclBK1G2DfyYNFF9ntJhwR5YittPkz7SPWhI+BYm4aKsb?=
 =?us-ascii?Q?S+v5ONNYhNx3iIupa08AjGe8qrJTm0XJRe7XueD0zDd2ItdI6i5Go+rZxUGO?=
 =?us-ascii?Q?0yDQHQFxQq0s4np2w6jomK7LqTkwiiRBqqkVJaGNTXwWruVVI7MYFXg0je8P?=
 =?us-ascii?Q?6dYC5gF35CI92Bm9QVQOFKgbuRYeA163UqtgoYemTXwyOlowYYyKepv6abgl?=
 =?us-ascii?Q?6p7O//ZSloWRJ51ON8ZFgPlfhFqLsVcULDHqLhQRqqqgh7+QHiyExSImDOj2?=
 =?us-ascii?Q?W1pcaY4yfxgS6Ldn7r7ckWqrCq7AhXppdWQazhy9fMVHgt+m5X/4ipK/PWpM?=
 =?us-ascii?Q?T+xRvikCPDL7wNzOeiopNtTErMAznf1cnCJKeVN5lSFnuP0v01DNS9o2Nne3?=
 =?us-ascii?Q?djGSakt7u5O9oENKYN7XTA6Fi6/Tohjr0VednPteLT6y8v48TtyjdVtp4ynZ?=
 =?us-ascii?Q?NRroV6HD1ULizHafbEyXYBMPuu7nVq8xWtsh4WqsJ44ETvnZaQaPJWJZAPlV?=
 =?us-ascii?Q?pldwPpuu8ri+uTp8gQ6sI4ORxyp79yRNmJ5OD+Ym0UPP1mUlRF9NBOSv38+H?=
 =?us-ascii?Q?+oJT9xmkNfrniF61nptOCDRP5tZs7+Pu92XITo5UffW3ekfoyit6Khmgy1Uf?=
 =?us-ascii?Q?8dAvZk/AL4q85wdsjAsu9KjHDTd5lbVpF+48UZwkfrtE3DZ+Wx11BDbafyfF?=
 =?us-ascii?Q?+Ccn4/9IqTcZIqG42F5McFt3e98lYzMcKRMTZ18EpHXWeXkmuUew8ShulHRg?=
 =?us-ascii?Q?zMNcsbqyKCAOA+T2D43QTOUBoLY1w8FOgwYeuknaVZDEOVJ+Yg9BaMxdQDAp?=
 =?us-ascii?Q?M6CnoFd7wVs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?anHqtL5UDeoUyQx0eKZwg0mkAGoQ3yA0UCL0/fRXoc0+Iyf9erh7PIfgLL2D?=
 =?us-ascii?Q?cX0xAy+DnJj3P4rjV34EboTgUDrEfuUQOr1V0XsQJnw+fUtuFZVoW0TuEq61?=
 =?us-ascii?Q?jjJmyFWfvZ8hM0PgogWlAqWq2UzdwyD9JpL8h7i+xorKJ4OG7LfWBE2TiS4P?=
 =?us-ascii?Q?NxNdghm0vPX1N/gY4QVngnV1c5jW7rjwyQj+HvLg4mJVdR1THwACdhZ8BTMI?=
 =?us-ascii?Q?EwdRso1R3IevIsyodlmFwRGSJAzAC6MK7Ry9jptT2z/bssXANvLBb2XMYKWj?=
 =?us-ascii?Q?YLUpAspL+vjBkklFC+QGNPAt85udkoEfL5IbkR1BPTPGkJ0o+2+Ef5/CHMkU?=
 =?us-ascii?Q?VFmU6LpAQuPDA6nQ4ZYlfLVx7yWbrApHSAK5LlG63o56D/cwe/hAlOCeUtAz?=
 =?us-ascii?Q?DMg6mGdmzH0CPvnvx5IDVccMzlEa/gyvv5y5hKO7MV3PdI+b1A4S5IGjpng5?=
 =?us-ascii?Q?QXV62rpzQehGa5x9uR5RUwUMsXF6CbNzYEBXm2gC1awBk04FL9Lw4TnEOYiP?=
 =?us-ascii?Q?llQIkhqwQGdO4TWRwJooyeGx8H+EKS/lQaPYUXXN4rqXNgayYtxqXGZrSq1P?=
 =?us-ascii?Q?c8wBDxr/xK3Lq9gCZstf8VZElUbLb8SGGcuxDDQpvDfZgq8yVmtYAL1rZ3rD?=
 =?us-ascii?Q?DBVm00erFQmBZG4kNjCZlgHV+COgcsNE1f/wBIct73a6QoSKFu/nGuLidtLt?=
 =?us-ascii?Q?4z1xB8wsCozPugLdwPtPRlVOC0kr4cm7DaOQYygMihN+63Mv32q+6DCY82qg?=
 =?us-ascii?Q?tbBvpUAxtmSah+PLAOyr5xC5bxN7X15PfZevTcs63P1aCGkHE8tNEiIT67GV?=
 =?us-ascii?Q?hPB4WPRWMZqaOAPQSMub5WkPfskT/6iosPG9ufz1Fm7qxG4mWU1rXCM03V9c?=
 =?us-ascii?Q?3/1kg0si0IcTCvewQcZ7IejbBSm5hmpzsXPzwIEFM3aywk+jg6Di6v6Th/LQ?=
 =?us-ascii?Q?RsrNXSziIYhmrcnaAUubn2ho9MDHCrZO6Wphe094/QRpdBkYLEDK/pUYV5jR?=
 =?us-ascii?Q?diT7zxXfa2hRyehbAQnyUF4xqmaJCUCJb4JkAx8R2Ol83eiP/pNXBBTsuhm3?=
 =?us-ascii?Q?lqhlbi0xylo9KWIV7D1WTSpfYR6pehIkZ6Dcg2zcsESC6sg25ko2y66bQZyb?=
 =?us-ascii?Q?/RfG0Yiced++9VQ6L3hQjoTLNRabmN50yOUSs/Hgn5JClHtXzyNK5Yx8zSs8?=
 =?us-ascii?Q?wb4gEFmUlvZp8kLdLgptLcNbabqPnw5S4GpJ1lEqVySe/iVlHi+2IICJdJtM?=
 =?us-ascii?Q?9ZFrRciVEOgAI2GRnEryNaYcNxJvyACqCJtgKCpNHnDdKkrNLXQsH7S7W0JK?=
 =?us-ascii?Q?krpw7jVmpeoMfrn5lIRuuVEr+dtyLb4SL9Bw2fpgQToSA+/lz9/8sqNgru/M?=
 =?us-ascii?Q?HaIrGseORnj1WRKCmHZNJwGbTGIgQE3UFobKvZ1C4QPjeH3BcOVVVUJHlwLF?=
 =?us-ascii?Q?9/BDQbm9QIM4utmgVwDs7qRuhrJn45NaKq2aNYz2+EqJjp7PrCbxPqCXlM44?=
 =?us-ascii?Q?ZnZVPkCaxBc8G4bLu2Y3LkOKQoqyd2CknTQ1whudCbhHFwJK5Aqys2DnbP3V?=
 =?us-ascii?Q?GYlUMAhP13zRfFMd0EwnWG6cdefx+htiWlMBKBhyKr7M3Esv9xDjjass1M3t?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZdEie18OJolqWQGSlrHFRD/PLHuNQU4FYRFwdSKTcb4JbQ1+AesAM4aHXBniAF5wxDHN+EMGOEUtVOUeZLh2Gvx6AVyjm9yodgYNNjB9ubP7CPXYo1BtXAtiQ9lF2fk5UyX4CJN2jle+sDcPXwLEUZeBui8/5k9Z7JyAxcGaGntqKZWfW6busDDvfCEtU2MSn4VkbjqSMq/lbI8hw/ruviTrwRmlIvAo7vfL7YamOJVa7/iMBMhhtUH1YHRiAklTL85YjUG7WwcxQWCa1iFJel6Ksjuijlpscm9/ncvWZo+hsmbLneHz0po8fYq6Yv3Tds2vHeMyvGqaoYaOSqub9ZSCW2cfmVaKqfTZC+APOvYVvPqOLgncd+42ZDwHepsUzY6WoZfnHqpxPcxLKIpzP36iweNduptviAaNPLegy57PCJZlWXUJ3EVWhZq7R+P6JZyF5a0bIb9S00Ru502DphGxJVyoczigbOxXTdLCnk6YBkTGOYKqO2XD+zW52d6Qs7226WvRg59gP97ZBiCmTpK85koekACgPSKKnkpzcDz/U6Mm0s63r2ThPftblR+s2h1sBk3JACxDcWr7yA1JOF2Q6FoPl07v/sfbhBZ4LKc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51775cb6-cf4c-4e5c-b35a-08dda776c710
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 16:57:54.5237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SoL5V74KTEV31fbntqWD92mDgK33HjyK3WnUYj2wkVYTc4RrzOQZNdZwRhQahVeu0InBSVA/G4G/b7OYK+AV0Nr1GSY6kRqzO50EmiI1nHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7943
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_06,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506090126
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=68471296 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=TwZLpH1JVN7UgDAN8YUA:9
X-Proofpoint-ORIG-GUID: AuG6FhUVeTzrGdwMG5rJGdH4ymC2Kzv7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDEyNiBTYWx0ZWRfX+Eq7yt+W+bTT k42WtoBH53Fvg8Kmkh1edP+uUV7G+hWgLyJFnk0usy5Te97Qlyx2A++m4NNVTXOabMS++iQ0dXV OePoytfIPS1pvuvXNV3pk6hap5DPE6mh8nILfSO/Kc+2xvkHBWamJWorsGDA3QXEfag5yKCfXfd
 tHkpVxRSeBrbOaggDkvjgNeqcXAhlJzEiosXnltmtOpne679JraDvVaoKN1Is3oBQoN61+rRlyz HvwqvPVAxre2PYYvxeCCcK5ikTRVSFFmOM4rvRbWV6hL3mp/55Aleo0yysez2GhBRb9Otxf8YCe kD1RiXQBh0QQWRW49eZkQAg8dMU8xxhBxEaXpTN35/hX53l7srIwLjLojH2Y9OuFgKCprjr64hL
 XW5eG+xFH+UDNPZ7VWKyxjqU8dXuUJQaGbiqAogBGkbnQVfho/RiT/+IUU3xMn7sXCG2n8Ot
X-Proofpoint-GUID: AuG6FhUVeTzrGdwMG5rJGdH4ymC2Kzv7

Nested file systems, that is those which invoke call_mmap() within their
own f_op->mmap() handlers, may encounter underlying file systems which
provide the f_op->mmap_prepare() hook introduced by commit
c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback").

We have a chicken-and-egg scenario here - until all file systems are
converted to using .mmap_prepare(), we cannot convert these nested
handlers, as we can't call f_op->mmap from an .mmap_prepare() hook.

So we have to do it the other way round - invoke the .mmap_prepare() hook
from an .mmap() one.

in order to do so, we need to convert VMA state into a struct vm_area_desc
descriptor, invoking the underlying file system's f_op->mmap_prepare()
callback passing a pointer to this, and then setting VMA state accordingly
and safely.

This patch achieves this via the compat_vma_mmap_prepare() function, which
we invoke from call_mmap() if f_op->mmap_prepare() is specified in the
passed in file pointer.

We place the fundamental logic into mm/vma.h where VMA manipulation
belongs. We also update the VMA userland tests to accommodate the changes.

The compat_vma_mmap_prepare() function and its associated machinery is
temporary, and will be removed once the conversion of file systems is
complete.

We carefully place this code so it can be used with CONFIG_MMU and also
with cutting edge nommu silicon.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Jann Horn <jannh@google.com>
Closes: https://lore.kernel.org/linux-mm/CAG48ez04yOEVx1ekzOChARDDBZzAKwet8PEoPM4Ln3_rk91AzQ@mail.gmail.com/
Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback").
---

Apologies for the quick turn-around here, but I'm keen to address the silly
kernel-doc and nommu issues here.

v2:
* Propagated tags (thanks everyone!)
* Corrected nommu issue by carefully positioning code in mm/util.c and mm/vma.h.
* Fixed ';' typo in kernel-doc comment.

v1:
https://lore.kernel.org/all/20250609092413.45435-1-lorenzo.stoakes@oracle.com/

 include/linux/fs.h               |  6 ++--
 mm/util.c                        | 39 ++++++++++++++++++++++++
 mm/vma.c                         |  1 -
 mm/vma.h                         | 51 ++++++++++++++++++++++++++++++++
 tools/testing/vma/vma_internal.h | 16 ++++++++++
 5 files changed, 110 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 05abdabe9db7..8fe41a2b7527 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2274,10 +2274,12 @@ static inline bool file_has_valid_mmap_hooks(struct file *file)
 	return true;
 }
 
+int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma);
+
 static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	if (WARN_ON_ONCE(file->f_op->mmap_prepare))
-		return -EINVAL;
+	if (file->f_op->mmap_prepare)
+		return compat_vma_mmap_prepare(file, vma);
 
 	return file->f_op->mmap(file, vma);
 }
diff --git a/mm/util.c b/mm/util.c
index 448117da071f..23a9bc26ef68 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1131,3 +1131,42 @@ void flush_dcache_folio(struct folio *folio)
 }
 EXPORT_SYMBOL(flush_dcache_folio);
 #endif
+
+/**
+ * compat_vma_mmap_prepare() - Apply the file's .mmap_prepare() hook to an
+ * existing VMA
+ * @file: The file which possesss an f_op->mmap_prepare() hook
+ * @vma: The VMA to apply the .mmap_prepare() hook to.
+ *
+ * Ordinarily, .mmap_prepare() is invoked directly upon mmap(). However, certain
+ * 'wrapper' file systems invoke a nested mmap hook of an underlying file.
+ *
+ * Until all filesystems are converted to use .mmap_prepare(), we must be
+ * conservative and continue to invoke these 'wrapper' filesystems using the
+ * deprecated .mmap() hook.
+ *
+ * However we have a problem if the underlying file system possesses an
+ * .mmap_prepare() hook, as we are in a different context when we invoke the
+ * .mmap() hook, already having a VMA to deal with.
+ *
+ * compat_vma_mmap_prepare() is a compatibility function that takes VMA state,
+ * establishes a struct vm_area_desc descriptor, passes to the underlying
+ * .mmap_prepare() hook and applies any changes performed by it.
+ *
+ * Once the conversion of filesystems is complete this function will no longer
+ * be required and will be removed.
+ *
+ * Returns: 0 on success or error.
+ */
+int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma)
+{
+	struct vm_area_desc desc;
+	int err;
+
+	err = file->f_op->mmap_prepare(vma_to_desc(vma, &desc));
+	if (err)
+		return err;
+	set_vma_from_desc(vma, &desc);
+
+	return 0;
+}
diff --git a/mm/vma.c b/mm/vma.c
index 01b1d26d87b4..3cdd0aaa10aa 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -3153,7 +3153,6 @@ int __vm_munmap(unsigned long start, size_t len, bool unlock)
 	return ret;
 }
 
-
 /* Insert vm structure into process list sorted by address
  * and into the inode's i_mmap tree.  If vm_file is non-NULL
  * then i_mmap_rwsem is taken here.
diff --git a/mm/vma.h b/mm/vma.h
index 0db066e7a45d..d92e6c906c96 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -222,6 +222,53 @@ static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
 	return 0;
 }
 
+
+/*
+ * Temporary helper functions for file systems which wrap an invocation of
+ * f_op->mmap() but which might have an underlying file system which implements
+ * f_op->mmap_prepare().
+ */
+
+static inline struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
+		struct vm_area_desc *desc)
+{
+	desc->mm = vma->vm_mm;
+	desc->start = vma->vm_start;
+	desc->end = vma->vm_end;
+
+	desc->pgoff = vma->vm_pgoff;
+	desc->file = vma->vm_file;
+	desc->vm_flags = vma->vm_flags;
+	desc->page_prot = vma->vm_page_prot;
+
+	desc->vm_ops = NULL;
+	desc->private_data = NULL;
+
+	return desc;
+}
+
+static inline void set_vma_from_desc(struct vm_area_struct *vma,
+		struct vm_area_desc *desc)
+{
+	/*
+	 * Since we're invoking .mmap_prepare() despite having a partially
+	 * established VMA, we must take care to handle setting fields
+	 * correctly.
+	 */
+
+	/* Mutable fields. Populated with initial state. */
+	vma->vm_pgoff = desc->pgoff;
+	if (vma->vm_file != desc->file)
+		vma_set_file(vma, desc->file);
+	if (vma->vm_flags != desc->vm_flags)
+		vm_flags_set(vma, desc->vm_flags);
+	vma->vm_page_prot = desc->page_prot;
+
+	/* User-defined fields. */
+	vma->vm_ops = desc->vm_ops;
+	vma->vm_private_data = desc->private_data;
+}
+
 int
 do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
@@ -570,4 +617,8 @@ int create_init_stack_vma(struct mm_struct *mm, struct vm_area_struct **vmap,
 int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
 #endif
 
+struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
+		struct vm_area_desc *desc);
+void set_vma_from_desc(struct vm_area_struct *vma, struct vm_area_desc *desc);
+
 #endif	/* __MM_VMA_H */
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 77b2949d874a..675a55216607 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -159,6 +159,14 @@ typedef __bitwise unsigned int vm_fault_t;
 
 #define ASSERT_EXCLUSIVE_WRITER(x)
 
+/**
+ * swap - swap values of @a and @b
+ * @a: first value
+ * @b: second value
+ */
+#define swap(a, b) \
+	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
+
 struct kref {
 	refcount_t refcount;
 };
@@ -1479,4 +1487,12 @@ static inline vm_flags_t ksm_vma_flags(const struct mm_struct *, const struct fi
 	return vm_flags;
 }
 
+static inline void vma_set_file(struct vm_area_struct *vma, struct file *file)
+{
+	/* Changing an anonymous vma with this is illegal */
+	get_file(file);
+	swap(vma->vm_file, file);
+	fput(file);
+}
+
 #endif	/* __MM_VMA_INTERNAL_H */
-- 
2.49.0


