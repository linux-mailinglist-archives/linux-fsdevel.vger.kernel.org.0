Return-Path: <linux-fsdevel+bounces-48346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC90AADCE0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 13:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F6C9864F1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 11:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563CE21A45D;
	Wed,  7 May 2025 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NQQFbPwM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QBbMSfGI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAB3215798;
	Wed,  7 May 2025 11:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746615883; cv=fail; b=B1o8iasXlRPvU/tnWfSJ0dx7MY3NRLebzTawBrbnefP/z9eAngq0kYke61FdFIR0JNc8gtdlvxtngWUwr93xI2y1OqvCAMVuktGlqOJ5tio/t5Nn/N3NiSDY97ygGruE7kpd6aLftys6Gt1E5DD+VP0X8cx9qTq8bS/trprtK2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746615883; c=relaxed/simple;
	bh=FBeV61wQTSG839UsRLSclI+6k2hbf8oY2OeARCr3zZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AL963n9R+WomCHH1urDw75TB5bKxZTipE8NUTK/7ltIUQKaaaFKRI+1f46lLdM1BC17dNrWrzAxbsCPysIkp0LqynLTcy4S8XTO3gVrtBAn4S+T4wMe43PoVT1JWC0kFPEMTCj0WE5HtQd9NfmXcapfz8w/jLXbRSAh5n/Pcr88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NQQFbPwM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QBbMSfGI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547AqjR8029934;
	Wed, 7 May 2025 11:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=j/xOL2PRdzuFZKl5
	i//TEdQk3m8y1roLZyPmZnfawL4=; b=NQQFbPwM20u5wC7JRIo6s+rNtrIBhSjQ
	GLBIeVhALKZkjXvP22zquc26pRA8isvZ7RUGhM4eb31cK0q8Klu0JLoJGRdZ1W/S
	YX3KufS4X4mwgEqOvIOh0hpppwHAGN7YIqVsRsl+O7KvxvbidNlHmCuvrl8oEbrW
	V6AHiiitnU+/FtutJYBkSjl3APzFdgs30XSkCnCgLdeR6hP5LyMNxa0NnoRcDTCF
	I+f/x32LONT1I8ruYycFd42YFie6LuHHZoS/9gw99+31xExbhRLRLmW7qD2xylVs
	ba4Pwoe6GPEJFNEKgDDFjuR6Ovyg+6kTBVeJStkkI9+Fzw+Op+3ttQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46g652r0rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 11:04:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 547AgY0e035437;
	Wed, 7 May 2025 11:04:04 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010006.outbound.protection.outlook.com [40.93.11.6])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9ka95kd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 11:04:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qk6ANHKzNl0mzwlLD68kyfi/aH1Z1btdD/4fgLRCX6UoyxdNbgR982DkGk8+20p09MGa4+xlMXnkw/4wJg351ncJ9mdFeBX8Ihq9WTU4Pe79ksyrwRem/QOtOURFL6Y5ljYXZtTXDOqjlUxa73TQtcvVyyq8QlpKPW4tl/T1wOVpa7ENsNtomhEurIsjomhekrEDqvDanGvdViCIH/9Cln9Wt8VO3MinlAhr81/8CHExR7AZ0ziZ9Uz/nKZSwv4baZ4PxRTSG0/Iu/uLW+rYHW+JVPoECXAoEu1r/hDTJT7WeczyKR8v0Ds+z9xSpbhV5k+hsvkMVTWJy8Qxw5FGhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/xOL2PRdzuFZKl5i//TEdQk3m8y1roLZyPmZnfawL4=;
 b=UGNVlfjfnH+xj00mBOIu5NcY2bMEXohwL+X8Bb0jfDGIJnYnWA9E1Q7qwhdM1H5+hyt8mzLOQzzhrP8Pz9TBLkn6Xceyr5wvwX2KGSRmQ7569G+fbVsnhxq7O2/yoM2KtNSnQzozjrC4lIRAu3SST0V6g49M08erYdH8LEdfx2Um4YHaERBButPJRhSJ7GkjauCjzKR/zjW1OQ1PoDMpXWGZB9CB7tfeRMhW5vRhl9VRhCOk4gAg5bYcbwotlRzJlrkcMD2JKTzOeHZwGh0jPvglnRE9PLIDDkAuSXxmJVpoVqJ3cLlba3VwrkUrKASODwaL28Cx242SQO9sy02X9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/xOL2PRdzuFZKl5i//TEdQk3m8y1roLZyPmZnfawL4=;
 b=QBbMSfGIDa1jv17n1csDUkuR9I1wH9da0H97sOtnVhi5A4dWzIAvqV/rtFtUJqk6NuG9WVK2YORw6g+yQLqQ0eHacpPhMOYmPnmGKK3urWYvF6TaaiqEwCN4/nmN8mmUr0lQP5YkqQGsYXOGBxL/0xoKMNnlSL6zLk2QguN898I=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB6251.namprd10.prod.outlook.com (2603:10b6:510:211::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 11:03:56 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 11:03:56 +0000
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
Subject: [PATCH 0/3] eliminate mmap() retry merge, add .mmap_prepare hook
Date: Wed,  7 May 2025 12:03:33 +0100
Message-ID: <cover.1746615512.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0287.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fad5881-6f21-4c76-98af-08dd8d56dcbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0DCdhZIpzbfvaK5NogAPLYa/EhBSgS63tr6r6CYcMGsYjVMzr2GEf121Qdq0?=
 =?us-ascii?Q?+Ero1/AAKhYtwY516EomTX8o6RaeIlUbnB9i4dJPby87Jx+b0kNqwvdxCK9e?=
 =?us-ascii?Q?xGbx3Mow02PCObjumlnlGPv/2fH88xBYJYPVMwyn5zZWkGmvzaRp9pbsQw4u?=
 =?us-ascii?Q?jHfL3chfJg/zb4XpA8UCA/Acr+ahujR2rbLnI4pKLNfv2BgdopYZ4+roKmaT?=
 =?us-ascii?Q?Hycbl29jdmRnKpDAxNzQQ0fzPCNibS5iFXaQakhW7rwz5rU11bnc4jck/IA8?=
 =?us-ascii?Q?fpe/XJCgokjCypZrxFK7nQkKB8yx29PaK647u5fLQJCcgpfyXwAuML2a3Y1/?=
 =?us-ascii?Q?SyOk8a0dXOEmeKF0K1tlNAfvFinMg6rFiA7JUZQl/IaGnZhDLO59FokbUiqb?=
 =?us-ascii?Q?qBNpUXzQ1uj2uSyV0vHeBCHICov1qnhh+QePLiBjA9gIuKs8cVa1vQ8phVJS?=
 =?us-ascii?Q?kKzNEUMOwLNw/Y0RQNViVLcJ++a7MEf5MTbaaG6kVTwW+x2z14o764Ifo1if?=
 =?us-ascii?Q?QZIUnRRdQ6+aUB4FZuPPzqWwYueOQrw0e07M209HTMs2uHPvwcoceKkaeYNl?=
 =?us-ascii?Q?OUfr4NJSwwIp+QqFse5JHWGQvnV+Kre4b0dKzJ1sv3Co69HHPcN5lWrltZAZ?=
 =?us-ascii?Q?5rFC5MFYMEyDWxk8PWipWdtmsdAjOn1nidiGa63YYHCDa0oMsBGVeHhlwT95?=
 =?us-ascii?Q?rVZkoc6lZitKR6Ggm700flP5EYlSR0q1KG1RuMsbOZpSyN0yd9brjBcvllJ8?=
 =?us-ascii?Q?g4wfHpsCkRSPWmMn5y+CACdqz2Y/9gdetu07eWI/QNA1+J7iXl7iHTieT7C8?=
 =?us-ascii?Q?QBZd8cua5VCnWzQD8vvx0CSfsXBNFH/85S8qwBfHmjueEoWbkfIAYfg8oqAc?=
 =?us-ascii?Q?bDYdxehV1EKhLIi/0Hn8zdOfDYlh3v+v+sIKXPcEUM4yRW0o8GPu3o7kdgc+?=
 =?us-ascii?Q?+ZGYdH0PyChrjDNuUZfxf1L/hrVHLdX5yLwzVXJdHYmIKJMXf5ySmtjab4Ya?=
 =?us-ascii?Q?BwAxxxGRWRgGFb0/X/URa82cBLYn6xtxb9O3zd9K0AJo2bzJCYQXNSEC/d9N?=
 =?us-ascii?Q?T+yF/fphr0R0iUAb4TuiIEOKLa1/MRza1Vs/ZdEQzxEgyal6uDcGRA3YqqYP?=
 =?us-ascii?Q?bYkLthuePhlhOfrXoSQui1zSTghA8MQdbWk6MNpPr8cpZ4x8yLz4kk4SFAaY?=
 =?us-ascii?Q?yc8aZK3RXm9EBadb9koDwcfCDQfJJ5DBVPlJUYE//xVwcIkLu63EUFYvzS23?=
 =?us-ascii?Q?rw4xLoQCi+G4a9g4e+OVnJtztTevWAXFShnpKjJorYWw4ZDEwSfO39WX67Gc?=
 =?us-ascii?Q?c21++TBoilqCMgzAeb0KhjJJ/TPOsfiq1DUblkn93jk65ErQFm0/xTOrp0xE?=
 =?us-ascii?Q?wL6z50FIzYCBJ7CTPH+1eQvFYLHuhcc/UeZWDh8NCn0oCypHDp3+6c+9y/yS?=
 =?us-ascii?Q?Q3sXlL5GpiQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?38nFNzhhhFqihcRt7imnUR0rt3unVCHXC5tgJUSuaUcbNqyCA2EkieexLmpc?=
 =?us-ascii?Q?6WNRuTdOLLGyPFOe9pQNdGnWDFamY9oxiYR3ZUh1w5reT1/yeVeRf8bkR1oC?=
 =?us-ascii?Q?pj0JFTjBLxCcYcbgCoRvCck42FIOysERUJHbfcVsYz+tAbuQEO0zyg+Qzal6?=
 =?us-ascii?Q?Yc8KinTboQWS7uhwlpJk/AZcyEezfPkkIAeAkTUAI/UJ3hgHnJfkvF5nQThT?=
 =?us-ascii?Q?UsVQq4/cb2ekIXVEgrecQJyziZd5Ga47rrueD3dHTj9Jjilr0QKNC86Hogoa?=
 =?us-ascii?Q?2rNTZYS5ceG41w3F4x9CjvycFHf5IZWUahVR0Hszzm6mHAdfPTJwR5ZQPETm?=
 =?us-ascii?Q?J6RfsRi6B6srWNJYHXMjO4j76rBfep7s9sbMTUFqeKf4ZW0CFdZT1uaZGpqD?=
 =?us-ascii?Q?jmikP5D+zRK52GHXGQ7Gro8+szddQabUcfi8EHe4Ey/UB1a9rv3LoqrrWhuv?=
 =?us-ascii?Q?H/c89VKHd0mDGhtowDV9Q18X/tqqevyNARl+rT8gx/ipnHNrCgn0yASUxm1c?=
 =?us-ascii?Q?TWghvBwSdzaLrOV1b14gk9etOn9LPjKLmmUkx48ZezBqUGl/7CmzAiiRDWSq?=
 =?us-ascii?Q?vc+AAeo4HWdjF7Qp/wSeEdJ1QCgJs99uV9cffnUN4tlA2I5v5vCJkcnAuPBu?=
 =?us-ascii?Q?n1h/dASZsgp/1iZ5Cb3c+BltDVi8ReGwnOzZS2zcIV93hkquy47CumifywfD?=
 =?us-ascii?Q?NOLJR7JVQOTu1NGlNk3rxqe6HLOGz3LRZFrCZn21RD3BWNm6hwpMBP/+cFEB?=
 =?us-ascii?Q?Cl798L87SVmA2cu1RjjtYnrgkiowkcfJflM9CPW4qf0b7FLvwJK6WM+acMpW?=
 =?us-ascii?Q?qTkIYyvpIxomtj4tVJAoClFw1C55FZR4+aOfRSm4jXBkojHHAU+uYAOcTixl?=
 =?us-ascii?Q?XPXrRuPkORPsg8xnYrAGiqAXnrevi242WdOpU5ItJCsKwPQik2ZwN5V2mTSh?=
 =?us-ascii?Q?GMUADoJpgRYfIozczyWl4+1BQp+txfyuvYSRnOjuaif34A+8TILsRuyy6t+C?=
 =?us-ascii?Q?qMk1zC121ZaOLLmYOfN0a8neSn7W013IuhdbeOtbobrozbMjnCJhwPMwu8us?=
 =?us-ascii?Q?8iHFW8VYXsltbLR7N3NY55BPlKAguv3gR/syiKO0iaBTGKahTkc2agYX6NkH?=
 =?us-ascii?Q?FYQJd/Ev9Isx5mkghJ4Zi3FToM4Z+iu8/LcTx7X0/NjUnMPucy8tQ5Y82qNw?=
 =?us-ascii?Q?bv2Ed7Vgf1gxpeDsIMjcYb8Ft7N7ppAkmdtbSWkmX3i7yKD7IS94wAmd672e?=
 =?us-ascii?Q?dmuzchCu5YhX6q0g+8+YdnsH6/36WEcz0F8QwV5vi+3rbxyN37K6Cmpxokbz?=
 =?us-ascii?Q?2EcuaIFM6ApbwtBoKhBxkxLz1S9rpObSyMbzsbLcRA0fsRnr4TrATm9KPSU/?=
 =?us-ascii?Q?qjvHfftFk345GKjHt6QzLPtTO81aJq5BBDyICZUSodCzROTzN6MNmWTG3kkQ?=
 =?us-ascii?Q?y52GZ6eYlcsONll1pY6FeyYZrqlgy2TEdeY3+mDVeCtiQrHk1eb94dFsyZpP?=
 =?us-ascii?Q?L6fI4YCqjqjJTgKdjdwoXR8DJiOjoH0iZ+cYHNzaGGrW3vxFlPsTRmRPLQZI?=
 =?us-ascii?Q?GuoMTVs8TnTaWZBqXC8VOjxhkKWsX4W28WwkFGksvNsrvRMH3ohgk8tTYIMT?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R+e0D8jF4kE3q4UEH+BxZ5G6OuAXSpYkTPuYqbRFqsfk1KEdNI8povJeSWCt1wcqUujbWC+D0DYK6uwjL3lS18lF2DICgIgBNn/kgLa03FsA80DNgT1sKBUQNQUxZGvZhsU+NKFgLUp0N5Od7MeDOmihbIMHxkHX3mM43biyZmF6hxnnkikywcP8VOjTCfFPM5qGU9lj/aV0KbAyypHk9f9Q1w15qzqpgyQYGdBxc4pfKliMkdhW4fC1/qzJD7KplRAikKZZjY5YeG7PRL8+ipaoeMG+96B/A49awFhUTD6/Qw4ttFhL6fuY32/OWZ30O0En6BPib+cqCeUnSn6BeZgUwqsKxGin7ULbBgWVBALJeDxd12ZIpDh8bY/mUMROU7C5XtC9oOYD6SWsnHGDMfLT1BEU8jBA2rMhmJCTF0i14Y3avS0m9UILN+OkyNU7zcM8o7tlCpmTqmFIwo0lgFtZo3BWpLlqEsRkYvD5xT//WwSutDH3M2WO7uBKWp7H5D6oQw0USgigeZMEchJ8sdmiAwUHAJ/buuYYJmsyeVXa1tn3DTf9758s6rvFvyViNtUu3BxXzgypG7QY99SSSrNuqMxZUH/GP7mP7Es35FQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fad5881-6f21-4c76-98af-08dd8d56dcbc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 11:03:56.7675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ylc1kHr7TptxvS3H9NUDqgJZ36eI6i8y8CnMa0zXwjeEC7pxZDCb1PzFLMUVx0funj0Bq1gElss693kbv/C7nF7Oole98MsFF9Yr+UqOYB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6251
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_03,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505070103
X-Authority-Analysis: v=2.4 cv=Va/3PEp9 c=1 sm=1 tr=0 ts=681b3e25 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=fYcPrh1RY6OB40ofYu8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDEwMyBTYWx0ZWRfX0JDcaZhuqpVc Jly+4lBoEOmfB8ze5hmqXcSqqjVwsUg0Ff/ivXYBEVNgm/P9OUIaVbHmF7j7dkj/5xegFab8pX+ 8SCvV7bmTsBiuYMu/6NKxYESR3LahCKRC3mxbEGzYs2GsvZGESopk2TBc+WG3G2ccQTIFs0YjZb
 4loYv7r2iQ8Ok897V9Ak9WbBb3GT7soV/9U9BNMconzuPKyrFb4ePHqjzrLxOlerY3SIwHW7WGl J9MGHIThnuKQsAABzp9uQazsM2rC75v3quvHCGjl1B8f4AWdYyWRsfmNemiqQ56nMlGT6AMzWsA /RQCztXXjZ3KxlrHqOJxILaNM4PEFZRNrJEeagz+eXmtFUHAe0bIUSjMh/e9438qwZfyG8Gh7in
 t1hyGxHlM1tMCvidxy6T0lz6DKYze6D+lJ6Drb9ZpnCNhok9gNfoRTzR9WTWa57A8XmSHh/j
X-Proofpoint-ORIG-GUID: QkuyDdL_YXeygzJi4bzrEFq5hdOHA7KT
X-Proofpoint-GUID: QkuyDdL_YXeygzJi4bzrEFq5hdOHA7KT

During the mmap() of a file-backed mapping, we invoke the underlying driver
file's mmap() callback in order to perform driver/file system
initialisation of the underlying VMA.

This has been a source of issues in the past, including a significant
security concern relating to unwinding of error state discovered by Jann
Horn, as fixed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
error path behaviour") which performed the recent, significant, rework of
mmap() as a whole.

However, we have had a fly in the ointment remain - drivers have a great
deal of freedom in the .mmap() hook to manipulate VMA state (as well as
page table state).

This can be problematic, as we can no longer reason sensibly about VMA
state once the call is complete (the ability to do - anything - here does
rather interfere with that).

In addition, callers may choose to do odd or unusual things which might
interfere with subsequent steps in the mmap() process, and it may do so and
then raise an error, requiring very careful unwinding of state about which
we can make no assumptions.

Rather than providing such an open-ended interface, this series provides an
alternative, far more restrictive one - we expose a whitelist of fields
which can be adjusted by the driver, along with immutable state upon which
the driver can make such decisions:

struct vm_area_desc {
	/* Immutable state. */
	struct mm_struct *mm;
	unsigned long start;
	unsigned long end;

	/* Mutable fields. Populated with initial state. */
	pgoff_t pgoff;
	struct file *file;
	vm_flags_t vm_flags;
	pgprot_t page_prot;

	/* Write-only fields. */
	const struct vm_operations_struct *vm_ops;
	void *private_data;
};

The mmap logic then updates the state used to either merge with a VMA or
establish a new VMA based upon this logic.

This is achieved via new file hook .mmap_prepare(), which is, importantly,
invoked very early on in the mmap() process.

If an error arises, we can very simply abort the operation with very little
unwinding of state required.

The existing logic contains another, related, peccadillo - since the
.mmap() callback might do anything, it may also cause a previously
unmergeable VMA to become mergeable with adjacent VMAs.

Right now the logic will retry a merge like this only if the driver changes
VMA flags, and changes them in such a way that a merge might succeed (that
is, the flags are not 'special', that is do not contain any of the flags
specified in VM_SPECIAL).

This has also been the source of a great deal of pain - it's hard to
reason about an .mmap() callback that might do - anything - but it's also
hard to reason about setting up a VMA and writing to the maple tree, only
to do it again utilising a great deal of shared state.

Since .mmap_prepare() sets fields before the first merge is even attempted,
the use of this callback obviates the need for this retry merge logic.

A driver may only specify .mmap_prepare() or the deprecated .mmap()
callback. In future we may add futher callbacks beyond .mmap_prepare() to
faciliate all use cass as we convert drivers.

In researching this change, I examined every .mmap() callback, and
discovered only a very few that set VMA state in such a way that a. the VMA
flags changed and b. this would be mergeable.

In the majority of cases, it turns out that drivers are mapping kernel
memory and thus ultimately set VM_PFNMAP, VM_MIXEDMAP, or other unmergeable
VM_SPECIAL flags.

Of those that remain I identified a number of cases which are only
applicable in DAX, setting the VM_HUGEPAGE flag:

* dax_mmap()
* erofs_file_mmap()
* ext4_file_mmap()
* xfs_file_mmap()

For this remerge to not occur and to impact users, each of these cases
would require a user to mmap() files using DAX, in parts, immediately
adjacent to one another.

This is a very unlikely usecase and so it does not appear to be worthwhile
to adjust this functionality accordingly.

We can, however, very quickly do so if needed by simply adding an
.mmap_prepare() callback to these as required.

There are two further non-DAX cases I idenitfied:

* orangefs_file_mmap() - Clears VM_RAND_READ if set, replacing with
  VM_SEQ_READ.
* usb_stream_hwdep_mmap() - Sets VM_DONTDUMP.

Both of these cases again seem very unlikely to be mmap()'d immediately
adjacent to one another in a fashion that would result in a merge.

Finally, we are left with a viable case:

* secretmem_mmap() - Set VM_LOCKED, VM_DONTDUMP.

This is viable enough that the mm selftests trigger the logic as a matter
of course. Therefore, this series replace the .secretmem_mmap() hook with
.secret_mmap_prepare().

v1:
* Seems generally supported, so un-RFC :)
* Propagated tag, thanks Mike!

RFC v2:
* Renamed .mmap_proto() to .mmap_prepare() as per David.
* Made .mmap_prepare(), .mmap() mutually exclusive.
* Updated call_mmap() to bail out if .mmap_prepare() callback present as per Jann.
* Renamed vma_proto to vm_area_desc as per Mike.
* Added accidentally missing page_prot assignment/read from vm_area_desc.
* Renamed vm_area_desc->flags to vm_flags as per Liam.
* Added [__]call_mmap_prepare() for consistency with call_mmap().
* Added file_has_xxx_hook() helpers.
* Renamed file_has_valid_mmap() to file_has_valid_mmap_hooks() and check that
  the hook is mutually exclusive.
https://lore.kernel.org/all/cover.1746116777.git.lorenzo.stoakes@oracle.com/

RFC v1:
https://lore.kernel.org/all/cover.1746040540.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (3):
  mm: introduce new .mmap_prepare() file callback
  mm: secretmem: convert to .mmap_prepare() hook
  mm/vma: remove mmap() retry merge

 include/linux/fs.h               | 38 +++++++++++++++
 include/linux/mm_types.h         | 24 ++++++++++
 mm/memory.c                      |  3 +-
 mm/mmap.c                        |  2 +-
 mm/secretmem.c                   | 14 +++---
 mm/vma.c                         | 82 ++++++++++++++++++++++++++------
 tools/testing/vma/vma_internal.h | 79 ++++++++++++++++++++++++++++--
 7 files changed, 214 insertions(+), 28 deletions(-)

--
2.49.0

