Return-Path: <linux-fsdevel+bounces-47828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7ACAA5F89
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 15:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C64763A87C2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 13:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100EA1DE3D9;
	Thu,  1 May 2025 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qcwi/SRE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ncgPlPSJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4411DC994;
	Thu,  1 May 2025 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746107533; cv=fail; b=Lc5mGBAn3gTJd5BD/WVk+rvJp72rCdpqTyZhrl5S4/AiSSjeAtzXxF+0MDzphmwjkT6eDS1wXPziv91IXAYcaRNvyNGG9ilRbhr8Q3FbVgP35cl6MaWRqICA8OjwsRyLZBdsQW4mvmveTQAzF+8dXcEuFsGfzLE5X2Q4npE6mXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746107533; c=relaxed/simple;
	bh=LpZeZm0Qije+kK0bchCv19fHs2MKrEKmm21XV3lAX8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UWUARtHEUYMc4ENdW709MSrP84dOWU6HJ6No0YKQx9sGYL3SzMY4+pMHFBfulXSBb55knH/dgM/vpKOuO4B34miO0TP1L9oEvECEU96qfX+UMFnpEs441BNwaTGCxmPxwymncuPh6LzU2SntdYhHfRcZbUCGCcoWSMYvb5lHTg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qcwi/SRE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ncgPlPSJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5418fwWS001867;
	Thu, 1 May 2025 13:51:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=AtxJw/Ge1sEZQMkzHw
	CWsztwyv1vP0ZpPDwsIO8z5j8=; b=qcwi/SRE7AfP/3Gfa/kQf6XCjIpK3vRF8q
	YMJ0Ej8a/xLfHfradbpQNy0XMMBV/lJhDuOhPFrPLQNRiPCXYbu4aN7+cTL8zSWy
	5TDnytJfauKcn6AWcjRrqqW1tlfu9G23PfECCkk6L/aLCSgOu93MnalrYURtM3Ev
	agkRvfB9qpaBlIPVMa3vKCAxeYrIeNj4GTOj5sFp1iHYy077rY0avgovJzdTnKUJ
	vKRLrRYHEgVLW6XmQJVq8ynxDZFc0hsyZ2a4QFoX+OE0akCGoV6/Sz+Lx+bBnrCp
	A0fRAC2II+VSLSxTErPpcDtN+Ct1Y/PcRyRTb8uqBeMURzWwZ3WQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6utb27c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 13:51:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 541CZ37I023986;
	Thu, 1 May 2025 13:51:43 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011030.outbound.protection.outlook.com [40.93.12.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxjt4va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 13:51:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHNNb2gpYRAiQ9kZfLM+4+Wd7iZMI4ofZKqqq8PV+b1rpzWjTB/VwQLD1G6zjMxxHjgEtzRX0RhecSS5y3w7pQUiGQmG9oK87fvznCu9G6TyTm53HCSVOJvjbdL3Lo+Yba0nNQ4bpKZ3R2y0dHMTHn2nSBGFmz0hHrqZ3pA7VY8aLBvPdnshjRfJqXIFPJuNUhswCplN2xi4KG7tAfZMWHxG+hQgTb/aNcmws+GKmxAG1mcnyP0T/SmfqkvVQkyHRSAIhi3TxnmuDL05HR4Xmsoke8glMO3ZQaB2dcmlGlOBOV9S22zhRoMzX87NT++dhBcmYlj99+2dQZCYNsdRZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtxJw/Ge1sEZQMkzHwCWsztwyv1vP0ZpPDwsIO8z5j8=;
 b=Nvua4ebsQd69+YByDPYZCs4r5hz/JVBhi2iatkInp3SckHqifXcJokZMKNHEFyz7grkDhENw838LpBeAS4X7Od9JV97Xc//x1vvzk4VzJkHCk3Zc6/n23VaKmEPZXJJm7WcWT22y1QeKE+wvLyVq+WhGifLEdQ9V14DqLDhcLYxrcPpu69U3aCrumW4Nd2qzOBwNTRmyS7xPeHYMMwJ6RjzoTXiCC/bYnhRIoUq6DcwAF98/n6jSamZMlY0UtF0xJnYAlUF8Nap5oi7z6iRIPrIGj1PqZyMRQlhws+vMATRpvLHiYYUKVbhEQ01p0v1J7inNB7m0nc8Bq8a1bV7wiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtxJw/Ge1sEZQMkzHwCWsztwyv1vP0ZpPDwsIO8z5j8=;
 b=ncgPlPSJHqVy98uZGP9VxBNycKTbreK0KTzZDNlUP9OHAp0I07aYQf/qqzHBIvNCMM0JqGEcU3ClwLPfANe/QGcXOXjXW3a02wQwy/3ZUjOT9ja8sw+oI3YQMJ6IiZ8j0cvyjkhs8tP4/k1qLMFbU8KJjW/mJu8wlKpHz7FwH3c=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH0PR10MB5082.namprd10.prod.outlook.com (2603:10b6:610:c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Thu, 1 May
 2025 13:51:41 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8699.019; Thu, 1 May 2025
 13:51:40 +0000
Date: Thu, 1 May 2025 09:51:26 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC PATCH 1/3] mm: introduce new .mmap_proto() f_op callback
Message-ID: <gv6kqbd7p4a2qfccxyxusgcctfr2ny75d3yfltczlcbpcxa5bc@3bjc2jynvb5c>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>
References: <cover.1746040540.git.lorenzo.stoakes@oracle.com>
 <f1bf4b452cc10281ef831c5e38ce16f09923f8c5.1746040540.git.lorenzo.stoakes@oracle.com>
 <7ab1743b-8826-44e8-ac11-283731ef51e1@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ab1743b-8826-44e8-ac11-283731ef51e1@redhat.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YQZPR01CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::9) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH0PR10MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: aacff934-c1e1-4cf9-b0f7-08dd88b74ce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WuX5tru6MaqLwlpY04ZFpeKQaWqbMEvuEjY7oOxyurBxk93Jd0yxYtzw78pm?=
 =?us-ascii?Q?2WeycaSzRhkCuxSLisEMT2VbJzUDrfDqYrQWeJbk9QXrVGJtlUKBPON3XXu3?=
 =?us-ascii?Q?RLVPwAJMbHNfAgpU73h8cp+DoAarhku0pHih7CKs8uwhprCXe4v2JQBh+3eS?=
 =?us-ascii?Q?N6ZJnS/eYpsJH0TdlsJm/QLUn0eTlLo/Hmc47rOcNy22EEw3fl+d4ZJ+ljkh?=
 =?us-ascii?Q?CqkmNuv2st+63yk/i6mm/OqHggO3xQ6PIO95o73yPf2u5Pw8bnHoS4SUJ1EA?=
 =?us-ascii?Q?nQg0VvGUI7pXvd6exYuDknDauShMS9PQPNVckyu6DDBiI9OGCfx9ZfTCVp/f?=
 =?us-ascii?Q?1hVKAeg6nXcfEmCll11/84RzP6sbiwgDC8nGdFvfrAjzjGV06eCCu7kcRimQ?=
 =?us-ascii?Q?AACR0wsRh1gBrAbQRWTSITDF95ANQgm3l92rnIXO2bQhd9cHd89rJ3Z8Q9Ya?=
 =?us-ascii?Q?8XR+xFCSq+GMoMy/+BlqLX326evtWNdbqswn1W/gJc10oSJC1FbCM6CAbh8V?=
 =?us-ascii?Q?Ophq7/szE5dzM26vj0sU2bAQ9Vj1b8iu9rHKgvJjyju9tXNhhJuPp7ovAHEm?=
 =?us-ascii?Q?pXdL5czN9jMZR3Mj2/fTsqKrRx/G+EAx5T0PHdsO3VOZYGpeMIe+A8PUtQ8s?=
 =?us-ascii?Q?ZAOAN1YVAm2PMRJ3pcYI4yoO1kDBGNdFGw/O2eZefXGbRaKsCj+vTlvXYC++?=
 =?us-ascii?Q?JCPbwdgurUSqOzuqH7ECkWPQaGPIuwpDiKQfPTTnvXwXlulB/BJCTh7f3GmD?=
 =?us-ascii?Q?vpEMalpTwyrm1ad6NN+quofP8n90NIxloYawSlUzw2Ic5XVy2Bt1xcboP8uE?=
 =?us-ascii?Q?/gy8asgVvG4dasqWwOD06sRctCUXIX/sFcO3/eOAiTX1Xo1k+8GEJAtIC6si?=
 =?us-ascii?Q?abo8XxpbwDMYo4rQje9ACN+EsQqBkS6cMjKPRO5MmCJEH/yJtlUKFz0ZOCOy?=
 =?us-ascii?Q?E7m4Yfic/7mjgcBoDpjw/98wuVRNfrXrN+MznItqUzcobMjeNBJv0zqmEsHM?=
 =?us-ascii?Q?DDazdfI5d5dxg851oPg3erTrA825n64A7Ks/D2G5ZAaK1MorlJCuA/oUDUrW?=
 =?us-ascii?Q?ydpjAauDwaU0uay47V7BClZzkDHfUdrt2UsHkkmxmJeldQp2yNCRVGUEk4cb?=
 =?us-ascii?Q?r49YLuCLk9V14OEKajlCgiI1nb2izRxPTA+nJ0PYe9UmNfNkEHWh/hz805or?=
 =?us-ascii?Q?Lgqt7KAfdjaMnf1s65BWMw97jT8DKEqYxU790cBRicqYgEQ+470UfHaj08Jo?=
 =?us-ascii?Q?K9yO+iUzWdk2Ps/Ph0wvopVeeBg2V7QcQdM8Cn3dQTqoQNfar8Rt4hz5BRKi?=
 =?us-ascii?Q?gYJUz+x/kvBbiCuajNRUsFRAH9ARzFpJntXSLeOGdgE9XDW9DZFKlIZtxS1M?=
 =?us-ascii?Q?oHfKTEdCxApDR0HF7rfXTaZn/oFJy9pvO76I9hBSbiM11FtMn8icno/2LM8S?=
 =?us-ascii?Q?PvozRSsxakk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YBvvKEaZcsz8u/bTkgmseBiQCb/0TGPcOJJVLHjMvWCvu2x5O0vX27bEKDDe?=
 =?us-ascii?Q?UPH17/34idYS9VC2jL5tyMQgPikVeQJtuaTaoe02W0fSytbiZoLaT+Xx1WtR?=
 =?us-ascii?Q?r7Jsr+PPDinwy7pKPj+xwKdgvSoo7xcE/LjDE68YG18U4vQwvEbV7ktfaxw6?=
 =?us-ascii?Q?AMAQHuhLrudBIoka9lAqljzDXE5x+9HpnxV44C/q6YU/fOdKf7aTPFsjcYm4?=
 =?us-ascii?Q?7MUYF17dkPPN6laJVoDcfrt+WyJvXs7/Q2vMX6dwkqPYYQsMED2VXTndpKXo?=
 =?us-ascii?Q?fkRjal8aSTFB6+aK3E1sU7oVwHC9GCYgYBCWDT2vJ7vBXyHGDGhhT/+Ojcp2?=
 =?us-ascii?Q?RuO2kZ5bx7GtpCglXbYccCjpZmde9KLWRMY44aJXp64SR/Vc9Kbe0m818gHZ?=
 =?us-ascii?Q?J3niooGKF1vAEg57tIByo7cmGpuxpcMQ7J40SmnCHw8fw70y6JZqk6b64M+/?=
 =?us-ascii?Q?pAbavB83ReSe29V4AZy+OGL9ZAQcUKhb5A/8lG2q7jqR6mKmEwtQCyBXwuFM?=
 =?us-ascii?Q?mvltlhJCQOlOyhxJwaCLKKiwkRF05BEcI/kBW8x7DGFwRu9usmEsu+cR9U6O?=
 =?us-ascii?Q?YHtUwAD9ATffTlXyO93EUAOizcb2ZTg0fJG54Go+idBLVUd4oygDWsGs2L5N?=
 =?us-ascii?Q?UEzkNjARerOEqGaxIONWiB0qmHQ2/+pHwVt1n+3YQzb7KLA73q0O3H1rIGh0?=
 =?us-ascii?Q?6jVAzsUPisEZLnuz4R5Ma7yUMr8Hy68OFcvvuIQDmatQCsrpYqYUiwWn+TpB?=
 =?us-ascii?Q?H6Mqcu1v/0uWyEWlZFAtMKPe+HynqfLj45/UBY56XKHDjSAsoqbLNcOujz61?=
 =?us-ascii?Q?rXstbu1kvFwlKGRLz55ReTJlXvftUuW4wNiI/nopBhAi/R/UmYs83jFWaTsF?=
 =?us-ascii?Q?3yeDaDCjKJnsYjRLlTKqLA6UYFLGBqN5pLfVV7y3QWcFEkveOozGpdZBrdpc?=
 =?us-ascii?Q?zg4d8dF70WWArx7RF1rsm+M4ZGrcXFUtew3LFusihKgH1oKzZuS+0QZ4+6I4?=
 =?us-ascii?Q?rMS/TA+ca23+JRzmzfd4ZoPOQoUB8mNstXcll8AXvzwLlPWTRzSElNsN2NWt?=
 =?us-ascii?Q?FrLOqHjV0k0TEL5VvDQ/HkSudkLMLMUm+PkGYmg/r+aPsONDTftAk2hjaFRp?=
 =?us-ascii?Q?39SwVo12moxuO+Mf2VJua57cXIWheIENyjqLCU7nSMj1codDQ6lWUK8np8ID?=
 =?us-ascii?Q?qV+O+rNRtezG3K44eSOU83eicHJcERhroYsRSJVPQ0K1ZRxhSn8MHZO12P78?=
 =?us-ascii?Q?PsobnEwUwzT8Oz2kiEFaQBOO4NBX35PS832fKzYrNs3C3J3RqCLLg2w+qbzC?=
 =?us-ascii?Q?ALGEG9YtUuUHqvP7TJUPzxndDG6eXbGQ9bb3y63nAshVt+YlQNRBllv1x0oI?=
 =?us-ascii?Q?R+AWKPyRHR6r3da1fiy4ijHvf+XqRZLnqP5SBXakcIY4z+GgG6iCZnywHAmq?=
 =?us-ascii?Q?wiMIHWNBBDarAexxXrkowrxkF6jujgJ3SLwMSz+MxS38lIvs6gvntN/AYehx?=
 =?us-ascii?Q?KaVcahEnq4L31RVoxzs1s/50OcL/vD6bD0Qv8IsJstjxfx7LN1NSSjK4lQd6?=
 =?us-ascii?Q?w+Ztr+LqHfQtHcMTGm73UfZxiOJ1f5THo4Pvq1qx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ma8acBwUt0ARTrbl+5C+pLchsUM2bJ1fh94HaWZs9Fg11bmScWBYWmjh/hQqkzPyCbJU9R0zWs4DCINoytvne8CkMJMHSZqyDdknsdwVoev3qRkeTvYn2h/kABuU6btEoMNX3y5KOziqBdHXqbuVDmq2Q2pZluFzCubKUF0OUK0npAOF0jAIxEXYL5NyZys7z8egk23u+Oj/Wg8ylTWOxM2CD8BrvvnP/cU8eTYJZ6P1DqhJuIfpW0cBIRv1tmXTTR/ltxtww353zNskH5s07wzaBkqTaTmBKbJE53YPXG0RKqL3MrVDfQ3hZxrYwwz/eY1DDQJCib/ysheIvmrElwnO1io40XHzM+m26KS8jwxqHFr7CuqUW8IPyPwwuyORQ2tyX0vwUdB9brw2EVZnKBQ95/WZif5T8b+/xeRQqVghgXO3rY54lCmvJEBDgScovbdBMHVrJMKT7gHGOmm06lPgrN/J6en+I9BKNvkCDuf7J09VNaHPh4e+VE7ml/271OOyZr/8y4lCAtCySU3vW/a9cWLxxcfBGsFTmuAubTL9O8K/4SdjvnhBrktt1CTMEEzYnse23mZlprMXhk+isxGj8V/5gXfbCESFjQESW7Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacff934-c1e1-4cf9-b0f7-08dd88b74ce0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 13:51:40.8172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKrRS+Lw7xXMMG9Z9Tv/DNTbyDH1CPnB4rRMXkP7k66l/aM8YCQBqMSyPtJjJaSiik2Qc82Y2Q/O2Wm1I6kevw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5082
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505010104
X-Proofpoint-GUID: J8lBBgXTdWRWeAYZQO1ecWtNTqCna_ce
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDEwNSBTYWx0ZWRfX+x4VCnc3giGo 5dv4zGFb52BEEGO5zFIsAp0K5m68c4DyrmDkch1gBVLGth7VRQUaxe3cTfQIZWClmvDm1Mxlwjj umfiUAK7N2G02XEnytOBfS2ZyLOh0acUk5LzzNkGzT5CmfFfXzeJ+Pl8P6pbC6Gwk+aJ1xNukMy
 yMvMolZCuju5dyUmNIvPAeR51MPeXCnHVuhtLH60l7AxWYwhaO93NtT8OJYbF79PVMCF73rMBXd DN7AmX/fkBvPPLwMhfJMjM8hJpBAW4wqMCtNbqPL5LHds50ViNFy+k/GDMKp1yd0LVCaimXld5a dKyt1PVFNfFKGBw7F8WTsWjH6b6egyTvJgYu6qYMa5Gg0I5nmEYQU9h4vAB0RB8DZccCGgyigl1
 TnJJjvfx9CgVezZ8lX4rI1v+LL/RzAtcYqA1WizqNuX0QucPk2ls9xpiyrmqm2JiQjAAnP+M
X-Authority-Analysis: v=2.4 cv=ZuHtK87G c=1 sm=1 tr=0 ts=68137c70 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=tm4WygJ581TJhmiSlr0A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13130
X-Proofpoint-ORIG-GUID: J8lBBgXTdWRWeAYZQO1ecWtNTqCna_ce

* David Hildenbrand <david@redhat.com> [250430 17:58]:
> On 30.04.25 21:54, Lorenzo Stoakes wrote:
> > Provide a means by which drivers can specify which fields of those
> > permitted to be changed should be altered to prior to mmap()'ing a
> > range (which may either result from a merge or from mapping an entirely new
> > VMA).
> > 
> > Doing so is substantially safer than the existing .mmap() calback which
> > provides unrestricted access to the part-constructed VMA and permits
> > drivers and file systems to do 'creative' things which makes it hard to
> > reason about the state of the VMA after the function returns.
> > 
> > The existing .mmap() callback's freedom has caused a great deal of issues,
> > especially in error handling, as unwinding the mmap() state has proven to
> > be non-trivial and caused significant issues in the past, for instance
> > those addressed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
> > error path behaviour").
> > 
> > It also necessitates a second attempt at merge once the .mmap() callback
> > has completed, which has caused issues in the past, is awkward, adds
> > overhead and is difficult to reason about.
> > 
> > The .mmap_proto() callback eliminates this requirement, as we can update
> > fields prior to even attempting the first merge. It is safer, as we heavily
> > restrict what can actually be modified, and being invoked very early in the
> > mmap() process, error handling can be performed safely with very little
> > unwinding of state required.
> > 
> > Update vma userland test stubs to account for changes.
> > 
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> 
> I really don't like the "proto" terminology. :)
> 
> [yes, David and his naming :P ]
> 
> No, the problem is that it is fairly unintuitive what is happening here.
> 
> Coming from a different direction, the callback is trigger after
> __mmap_prepare() ... could we call it "->mmap_prepare" or something like
> that? (mmap_setup, whatever)
> 
> Maybe mmap_setup and vma_setup_param? Just a thought ...

Although I don't really mind what we call this, I don't like the flags
name.  Can we qualify it with vm_flags?  It looks dumb most of the time
but we have had variables named "flags" set to the wrong flag type make
it through code review and into the kernel.

That is, we may see people set a struct vma_proto proto later do
proto.flags = map_flags.  It sounds stupid here, but we have had cases
of exactly this making it through to a kernel release.

I bring this up here because it may influence the prefix of the setup
call, or vice versa... and not _just_ to derail another renaming.

> 
> 
> In general (although it's late in Germany), it does sound like an
> interesting approach.
> 
> How feasiable is it to remove ->mmap in the long run, and would we maybe
> need other callbacks to make that possible?
> 
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

