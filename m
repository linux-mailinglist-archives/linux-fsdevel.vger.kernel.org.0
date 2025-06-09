Return-Path: <linux-fsdevel+bounces-51054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A8CAD2464
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 18:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD3E169432
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 16:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E5021A443;
	Mon,  9 Jun 2025 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TdXD+53I";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="saTCOoE4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D8A189513;
	Mon,  9 Jun 2025 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749487965; cv=fail; b=dUk2xIf8pyX7ap0vsEUlqNVsG4A3yvneHfHU3rBloG3q5G6j6U7RaDMifpUHZmIW/leWEx+sYaY1jpDXQr5JmbwuGI/tZyxM5LNcgvtr1rQpcSsBcLAboH1ML9UR/Ni4wPbIzepIZQ/scBtFimepfcz7nUOqiDPfcSXGc8EQ2OI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749487965; c=relaxed/simple;
	bh=QxMzGn5ZRGAQj3Xxla7cTR4f6sHFNq8BvICO9ggPz8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t3loALbw3a0jYTUh3t/WaJAOLJiBEdPoZDZZwt4EXCt/bWc3J/YPqHkAWkuoLmLl3M8KCMopizovY5gNZQ8oYFEGRNTWtIddOo805VmCy8ofRgwEnmqbF9vKSjpScYrFIrY0R39zv6R/mD293o7yTdPnb6WzeOPrlKU84rjSy+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TdXD+53I; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=saTCOoE4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559Famat006086;
	Mon, 9 Jun 2025 16:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=vVkP61TSTf6rLQ6GN/
	hhW3Lxj4RUx6x34SEo5GtVdkA=; b=TdXD+53IqE9Fe1CG0gO/pngUt2mpPPiZHs
	zQf3Ij4McuC16r+Hl6m1SVBk5YD0Cj1ui8sKRIL2gOKfLWgHumNDWREWRvihvsQN
	8Jif5k+8dymCY++hJ8wN8LxZUKdCWybXETlmovYPBXvU0Bbx92j9c2Vg99SEbvtS
	Bl2MbPqd3WJ50KceDyH+Zlk98K7cqrlVsVRA9/dkHEfYT+ScElewMcixcCCxTg89
	gAGV15tWNZlH8Sd6pmaqu8ddmBng85i0N3mCTZa3qU/b1+MNU+SrGSU+CX/bZ7AB
	WG/wjtTNsAH+t7Bv5zoKfDU7J+dESy+Ss6AMXl9JdAWecDgx0ZIQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4752xjswbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 16:52:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 559FoFQU031327;
	Mon, 9 Jun 2025 16:52:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv7nw82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 16:52:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQLtaqWQv/aoE/fydNDREJd3GPJowPrhzmp/oz1hNIUAfAlK/+xbEw0jOrGKeLvMWXB7zJBZiJARB8xNWEVLBoPjtFXj3hndw5jKNWHvO0aWWkAuBYmvGoMimkVl0sfXLT2AWQHrhcl4q4V0uocjDD5Sn14R/PduvgXQqfbKfJHgBNgUdpgAVwydEY4MU9wEIHz0FdVfk3mS1RWjERASRzN4zCoW0nRs5xi+3k0hf6Ouyqk5F5jQEh/r6zhthQr8uwRPJCu7pcCMfmgrXGuB3j55ctsvXBbBJRPxOpr6XxJb6sTgaMcl3FCYlATM4ayFxFqVAXe2qHsET726881GTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVkP61TSTf6rLQ6GN/hhW3Lxj4RUx6x34SEo5GtVdkA=;
 b=FUy9i8jAcmZM9DmsJvK5gfrr8RNEXHFE8iLnc1CzLuOP61rrfyEIMmyK/iu+jXz26ZBiS7Cm46+6Y8w2RnTHOeIgUaIq4HdHtd6eDg18euaYSCfRqpQeLrtcKIFMOc8HmXr91rD5+hF/xJuqLz2r08pJ6L9uD2RZuRq8CPD7Vfd2MrJXLedYPMNZTCMRDQe6AEljpNJxHQ7i6nuzqCsgKXWAJlgrfvIVdjeMPM5L1Sk2BI4UiD2x9I9NJoVzWSteCtfEEnBeUKIY5V/7lxBgGElSbbPFADF5kGVSUEmnuzzuWAFSj+tfIDZ/9jkejRPkrsyMfCyLWB8gH4v0EvT7rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVkP61TSTf6rLQ6GN/hhW3Lxj4RUx6x34SEo5GtVdkA=;
 b=saTCOoE4WyxOdvzJXqOJkhvQ/hBz7xBNdkRXclTMXkKebulsxORv62qk32HGXIbmoiJzQrP6HD3CnDforoHpKDPsuz3YtUTbl+Cu+B5mAW+EfgT8qC8TjRE9Whl2MjXCxgOVuUKsHW8fBU3k4tKFMvLI5WUe00Uu/0Wr2AH7Dk8=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DM4PR10MB6016.namprd10.prod.outlook.com (2603:10b6:8:ab::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.30; Mon, 9 Jun 2025 16:52:25 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%4]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 16:52:24 +0000
Date: Mon, 9 Jun 2025 17:52:23 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: add mmap_prepare() compatibility layer for nested
 file systems
Message-ID: <46014c4e-9143-4d20-a2e7-6432ff237741@lucifer.local>
References: <20250609092413.45435-1-lorenzo.stoakes@oracle.com>
 <dddd402f-1705-41a2-8806-543d0bfff5bc@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dddd402f-1705-41a2-8806-543d0bfff5bc@lucifer.local>
X-ClientProxiedBy: LO4P123CA0568.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::18) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DM4PR10MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bbe4917-9238-4c03-7d70-08dda7760281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bdOi0afSd4+M8B6GZNJGL2DsO1/ZNhZxEc4kpqJeqGecrs/B5uKgcip7l4EE?=
 =?us-ascii?Q?WVirT7DoMPZoh31jW6RD44h+vKAyRazVwJJkRUX+yj2DmCGTfj4f3ceEIDOX?=
 =?us-ascii?Q?uRyRwWkJ4b1VVJSalkhgjTN+S/NTiXYddzFO6BT9skjtBEo2H5QPcpvL+90t?=
 =?us-ascii?Q?1UDi1ACg32mhLebMR8pfjwYLE6G8Xzkm1pqROoavxMhT8Ins1IraUVvf2b1f?=
 =?us-ascii?Q?x2bMd1qxBd1Fqj1v8hxEbWuB2ck2h6/AQZ0Z5piZNra3HvQNlHrTq8uFxT7A?=
 =?us-ascii?Q?EEWZq8jtKRk5il88KYu8Djv7ljaCM8nx11S3lDKHDfoPD0bQdXGHNdvxzjRE?=
 =?us-ascii?Q?G/o0uce99F27ARt8c+SwdAQcjrLZEvbI3sL8ecqA5UNT8dGWMKv1LzVPJxR9?=
 =?us-ascii?Q?zHkGdolNLVlgY5Uk+EjlOb1TQavJPO7erW/MzRxYjXFymiBr5M4cDQgzhu9b?=
 =?us-ascii?Q?0/b0uqzOKAugxROlYw3ds26PUdx9neqRWcDOUNIlEkyk5XK6YxiGGEGs+/ZO?=
 =?us-ascii?Q?MezfYh+EmBM3EYGVaHvIMHsJaieM2ySSV6sJycgu0FVihmHGSbBBpc5eEKP5?=
 =?us-ascii?Q?iLCxaT92D9PMhE4WQvpPkAnVBeaKGlWh8kM+M9KmIaza4CL7dELb6Hge7TXH?=
 =?us-ascii?Q?7DrYrfAnpVoQkDjEuX+5QfZPwktV4aBjPtrZINJ9kKZPZfsudkPGhfMbSwkr?=
 =?us-ascii?Q?m1LQOo0VUVjDQvhvY2uPyx+vZXbMxOrTGaDaKQMp74tD1JEK40CTn64K6aqO?=
 =?us-ascii?Q?v5WVVplXBfmuuNaLwDWlZOGmYHAG0Kfu2tpzRyRzux8B/gDYhiJfd350CPsE?=
 =?us-ascii?Q?uxQ7hl571bLPE6yaYqHbWLSYJxEATo6yBE6vZN+b8HHbP4spIQ3M1SP1DSoz?=
 =?us-ascii?Q?0pzcUWRebrpM36qJ3is/Vr5DzPEZffHUH7ut9EBOS7/6icN3qF3wD73ELCU7?=
 =?us-ascii?Q?AL5yeaJei70VO9Hs59Ru8bLfgAFtRLdDrw4u3YA5kDgTpex8+r/wbe39udB/?=
 =?us-ascii?Q?NiKopGaZo0IBW2h9uD1bRlnbP23TF5mKKYHGHNJbxpJ3C0QCF6Czkk/0synJ?=
 =?us-ascii?Q?ozi9kOQH8XdK0tJdK76OJfhNHou935nDrQYQZ/ikmdSNan9T34YIc+nANIMW?=
 =?us-ascii?Q?xXcD8Wq9yz98QPWI4OzhaKL3mYUxF0ybh86Xas+wOWgTf7EI0ZCJ9Dp3BmiE?=
 =?us-ascii?Q?BL/lkhs+ZKbR7KpMWVwnj8sd9AJCdG3Ly33BdQSLFqSKLS4hqiIgXu+YjZwf?=
 =?us-ascii?Q?QUlyvBjOFTfPb7MiEL73bOh0NRaUdT6YiUhTJs9K8LiO9xAkEdEsqVSpD8eg?=
 =?us-ascii?Q?jgssDnraeo7uAMFrrxvHkaJ1zVYmyzSC7CziGmjkoF3tVYs1L0PEbsed6iRN?=
 =?us-ascii?Q?nHp+uV1FJBeOOU0aJ1JUGbGtNuNb9PDSh/Gg2++LWLkNI9m5qrF0exKz7tS2?=
 =?us-ascii?Q?CdJFqhkURzI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VAEFam2kQJ58gotyQFtOmKSNvIuWn818QmuM5ytomYD7RO4uP4J0+9rFtiVe?=
 =?us-ascii?Q?LafSTBIoljDkv2Ip9B9sC0sCg6guo0w++nipBcpHZW7g8shUoGyKufrInHv6?=
 =?us-ascii?Q?jBY0Mfjroen5ihOY93g5wKQAKpH7Eap3BHivIveiqxZ7FrHEmv+hbVF/nQ3E?=
 =?us-ascii?Q?wMSW7QwpMwEIEaDqQ8x3coNhwsCsmweqzEl/PLq8u438+KbrSgxjVGvmtkbf?=
 =?us-ascii?Q?S0nFxwXuH/o4W5drERqdrpVYAOkBWhbSSNMUbjMaLxBTJ2SWRCyaS773gCKq?=
 =?us-ascii?Q?RJCSnt1tCB3CHpSS8TW+mIbIrpyP39JlyUbr0Fql8YtNarY70aQ4cbY6EyCz?=
 =?us-ascii?Q?GFQnvlP6LA3xo08Wwi6R51rUsUvHDGQwsHoUw9ku40ho7sgHKy6x8nykfZZE?=
 =?us-ascii?Q?W6OS+DMAMO/PhdzPpCakTbkLd0ETV1TAYvelxav/V6o2MVL3CKC5pTtBtZe9?=
 =?us-ascii?Q?1jolsyLeMNKzRdmG4mlGH15I2n+x+dM43u7eRCZnTx/bBPGcBjWl54sM8bAJ?=
 =?us-ascii?Q?xW33cTtjkffh+RhU4LV0VKEa1YXLjsZY5mlkbZ9VEcVLq+5GADWT1/idq+uE?=
 =?us-ascii?Q?X56EaYcyINNf3tgkoof3jmZ7eaMVXARJT4n/eU6XJ0F8Cqv3iS39qWqMOdfJ?=
 =?us-ascii?Q?52CCN3fX/J0fqbjCWCPttHSWs+Pqy6HbPKcWVUZ3mrxtbsmX4CORTNiDKq/T?=
 =?us-ascii?Q?LGHELPulkcxZ2fVem8qel+vbw3zhavQKafMbQz0tlhMc2SPIdEDXLjggkGVq?=
 =?us-ascii?Q?cLNlNYvLhv8k9Qkh9qX16wWpkFSy/4EN7VSThoir/fhFd2p6RmyJdgWBpIeA?=
 =?us-ascii?Q?V4K5/5pETuGYlaZ4pKmb34qKHhQRepI273/c/G6HyVWLoTWNzqme5wdPX7gU?=
 =?us-ascii?Q?cI9oTm9uM0H71K4aNoMBnmvKo569dCYP4z4tSREGSCNHIOPsUtPIRFA+ZpE6?=
 =?us-ascii?Q?wMpwqyM2Vh/oc8ceuJiVv9uO4GoQZrnXaOfsXKGqRNqKs83PM2LUZSGUxeTk?=
 =?us-ascii?Q?wNSnclOvxhhZAnZzaK1Fqv9ZoS55NjlXdM3rfMZ9uS/IuCYwnYUzouSny2Q7?=
 =?us-ascii?Q?1CcaN1xxkqxtr/VnTp3X80tLHeEsJ23JE9ZmbdpZ7ujG6G3xfSA9aljk9hPP?=
 =?us-ascii?Q?Pjkw21bxULbjBf3/sYopGNps3UZzi/hRaqWlmy7xfwIvaVRWfNG7WDOoRLI7?=
 =?us-ascii?Q?vnnErQv1eVyZCxDbm9czwLI4sbtLApE4zdTTJTPxX02txQFrVOKIxcr2KCTb?=
 =?us-ascii?Q?zF6iJzsG5HtCLAFuSnhrbYKcl/9QaS7d6zBCuM8GKsuyT3kObQIHXeKvlmWA?=
 =?us-ascii?Q?4bftkRnGBmutWJpupZOGTIn4dFOk1QoK/5dkCv0c/d0WCH7ni1d+ZDJ+gco3?=
 =?us-ascii?Q?MWVhjpa5RcNhNrioB/Ieh5T+JsrpWpldULBJm0vKN2DJnhRoWyHufpbeJl3Y?=
 =?us-ascii?Q?AOHhS4vAuY65dRVH7RAUGfXy+U70ngkXKOHMQKCy6pixokuNZFt8n/mU8/aQ?=
 =?us-ascii?Q?dc+KR5tcWXvP5GV/m9VQKHJk3VFdF9z6HN5j+G16O0O/pRAwHWkkib5Cq1WU?=
 =?us-ascii?Q?Zm5G1PDKK0n5p8AbivLh9HBEZ1RQtkLlnczK5zyDUPbenFJhT4truttl3NJ5?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HjMMDOMosBi+NZwmjtmaCc9qnvEflYZ9puXAY5gEuDohSP+5MH+cXMA620R2ZVwlEQ17z3Y7KVm42DfxbDx3dGocr4LDprYysk0rHUpR+PqLaK0+dnqZe1kJ/QqNrI4WssAmlepqM7WN1ZOSvGqjbmWxFj9n4XVMyHfbfCBMUj+zxLJ/aNrMlMREppJ9dB9JEcjwCV29/B4Y3ypS3S4JOTSlmEax8732FlQu1l4fGZ1OpS1tUBccZTKKFl2dyk7PP1Fmcz3SBXEcG5IA1fFQyGK1oYG1tfPLqDO10Pax61O8nng5cBCbkCW+Byr/uzJsuDUxikOAm/bWRWZr5SeGRRNUefzEnmDvu6P5iY6WjoZcwybEbEIkisdDYHWX0cQPiph2Nys3bGUpWlBTk3Kxt7kLOIN7j3YU6xQwZfaUEfgcpd7l76b7Yg2KZIVqdf8U7YkUSFr8xdb7HP6bFC09fJHuG2Q0QyRRNlwTdJonZEJ1NyTqaLhviQTCTSrr9Ssl0fsaKx0rRhXXu+V3KRlqsjVnjfLBg1/0Q8xCO2sBaJIwzVOnGi9QZ0hClHOqrfZkgeYlBaDL2nAETrrgJsXCrD0uiYHePP6cA0DtOA8hcbM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbe4917-9238-4c03-7d70-08dda7760281
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 16:52:24.7478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujR7Yka3cGCGYd0U+1Y4zqxmwnD+mDPy72kGm7IvrzWVMslg1cgJZ4IZOqXTkQdAxMie/3wGZ29AOJUT1Auiip8emYk6477B4lVIQhutgBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6016
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_06,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506090126
X-Authority-Analysis: v=2.4 cv=K4AiHzWI c=1 sm=1 tr=0 ts=6847114d cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=S5fHaK3CWPMPKg-Sy5gA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDEyNiBTYWx0ZWRfX1jxF9Xq5hKe6 T7Id7mE9vP1e0ZSXje9PTWfJsYtpFdyxrcofonAwoMI+swo0o3ouLPUq6Ke5zNWcCBVVxWQZaOE VzwmjLtEXNp5nmJoGzwB5RbHy2N+oOaYfmSSWsKI5Kz9G1VkS5kns+PAGm4vMUolZwxPSln7+T4
 bLlqMjY7MPucSunzFXIvxakSaabqXw5K2BDHgD2Q8VRsXS1IWZpDiB/nZUUj1L3sZ/x3o5W3bok h4yVzpsBlIgej9JrNvtdFZ/2W43aUr6YvbsQLvf1K51s0CXIUk/QZgwqhTpGzag8z/X0bmgLeL3 lLdOcv6Q4TJg09IMqRbdF/Jjb1H92uEVsv1Ff0mI8ZGt998lkT4ZGoeYPXdi2PL7kwCCyaFejwz
 hhW1JCjpd5ZFKXYzkxcUgjDLKFhha+9zGmLtxRJ8Q0sIthz7ayCnxz3+JqrRbFI7VQ0Xea7z
X-Proofpoint-ORIG-GUID: vR43r84IrPdgX6W_XKGffuL3ly1U4Jyn
X-Proofpoint-GUID: vR43r84IrPdgX6W_XKGffuL3ly1U4Jyn

On Mon, Jun 09, 2025 at 04:44:15PM +0100, Lorenzo Stoakes wrote:
> Andrew - I typo'd a ';' when there should be a ':' below, could you fix
> that up or would you want a fix-patch for that?
> 
> I highlight where the issue is below.
> 
> Thanks!

On second thoughts, given the silly nommu issue, will do a quick respin.

Sorry for the noise.

> 
> On Mon, Jun 09, 2025 at 10:24:13AM +0100, Lorenzo Stoakes wrote:
> > Nested file systems, that is those which invoke call_mmap() within their
> > own f_op->mmap() handlers, may encounter underlying file systems which
> > provide the f_op->mmap_prepare() hook introduced by commit
> > c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback").
> >
> > We have a chicken-and-egg scenario here - until all file systems are
> > converted to using .mmap_prepare(), we cannot convert these nested
> > handlers, as we can't call f_op->mmap from an .mmap_prepare() hook.
> >
> > So we have to do it the other way round - invoke the .mmap_prepare() hook
> > from an .mmap() one.
> >
> > in order to do so, we need to convert VMA state into a struct vm_area_desc
> > descriptor, invoking the underlying file system's f_op->mmap_prepare()
> > callback passing a pointer to this, and then setting VMA state accordingly
> > and safely.
> >
> > This patch achieves this via the compat_vma_mmap_prepare() function, which
> > we invoke from call_mmap() if f_op->mmap_prepare() is specified in the
> > passed in file pointer.
> >
> > We place the fundamental logic into mm/vma.c where VMA manipulation
> > belongs. We also update the VMA userland tests to accommodate the changes.
> >
> > The compat_vma_mmap_prepare() function and its associated machinery is
> > temporary, and will be removed once the conversion of file systems is
> > complete.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Reported-by: Jann Horn <jannh@google.com>
> > Closes: https://lore.kernel.org/linux-mm/CAG48ez04yOEVx1ekzOChARDDBZzAKwet8PEoPM4Ln3_rk91AzQ@mail.gmail.com/
> > Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback").
> > ---
> >  include/linux/fs.h               |  6 +++--
> >  mm/mmap.c                        | 39 +++++++++++++++++++++++++++
> >  mm/vma.c                         | 46 +++++++++++++++++++++++++++++++-
> >  mm/vma.h                         |  4 +++
> >  tools/testing/vma/vma_internal.h | 16 +++++++++++
> >  5 files changed, 108 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 05abdabe9db7..8fe41a2b7527 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2274,10 +2274,12 @@ static inline bool file_has_valid_mmap_hooks(struct file *file)
> >  	return true;
> >  }
> >
> > +int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma);
> > +
> >  static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
> >  {
> > -	if (WARN_ON_ONCE(file->f_op->mmap_prepare))
> > -		return -EINVAL;
> > +	if (file->f_op->mmap_prepare)
> > +		return compat_vma_mmap_prepare(file, vma);
> >
> >  	return file->f_op->mmap(file, vma);
> >  }
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 09c563c95112..0755cb5d89d1 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1891,3 +1891,42 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
> >  	vm_unacct_memory(charge);
> >  	goto loop_out;
> >  }
> > +
> > +/**
> > + * compat_vma_mmap_prepare() - Apply the file's .mmap_prepare() hook to an
> > + * existing VMA
> > + * @file: The file which possesss an f_op->mmap_prepare() hook
> > + * @vma; The VMA to apply the .mmap_prepare() hook to.
>           ^
>           |---- should be a :
> 
> :)
> 
> > + *
> > + * Ordinarily, .mmap_prepare() is invoked directly upon mmap(). However, certain
> > + * 'wrapper' file systems invoke a nested mmap hook of an underlying file.
> > + *
> > + * Until all filesystems are converted to use .mmap_prepare(), we must be
> > + * conservative and continue to invoke these 'wrapper' filesystems using the
> > + * deprecated .mmap() hook.
> > + *
> > + * However we have a problem if the underlying file system possesses an
> > + * .mmap_prepare() hook, as we are in a different context when we invoke the
> > + * .mmap() hook, already having a VMA to deal with.
> > + *
> > + * compat_vma_mmap_prepare() is a compatibility function that takes VMA state,
> > + * establishes a struct vm_area_desc descriptor, passes to the underlying
> > + * .mmap_prepare() hook and applies any changes performed by it.
> > + *
> > + * Once the conversion of filesystems is complete this function will no longer
> > + * be required and will be removed.
> > + *
> > + * Returns: 0 on success or error.
> > + */
> > +int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma)
> > +{
> > +	struct vm_area_desc desc;
> > +	int err;
> > +
> > +	err = file->f_op->mmap_prepare(vma_to_desc(vma, &desc));
> > +	if (err)
> > +		return err;
> > +	set_vma_from_desc(vma, &desc);
> > +
> > +	return 0;
> > +}
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 01b1d26d87b4..d771750f8f76 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -3153,7 +3153,6 @@ int __vm_munmap(unsigned long start, size_t len, bool unlock)
> >  	return ret;
> >  }
> >
> > -
> >  /* Insert vm structure into process list sorted by address
> >   * and into the inode's i_mmap tree.  If vm_file is non-NULL
> >   * then i_mmap_rwsem is taken here.
> > @@ -3195,3 +3194,48 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
> >
> >  	return 0;
> >  }
> > +
> > +/*
> > + * Temporary helper functions for file systems which wrap an invocation of
> > + * f_op->mmap() but which might have an underlying file system which implements
> > + * f_op->mmap_prepare().
> > + */
> > +
> > +struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
> > +		struct vm_area_desc *desc)
> > +{
> > +	desc->mm = vma->vm_mm;
> > +	desc->start = vma->vm_start;
> > +	desc->end = vma->vm_end;
> > +
> > +	desc->pgoff = vma->vm_pgoff;
> > +	desc->file = vma->vm_file;
> > +	desc->vm_flags = vma->vm_flags;
> > +	desc->page_prot = vma->vm_page_prot;
> > +
> > +	desc->vm_ops = NULL;
> > +	desc->private_data = NULL;
> > +
> > +	return desc;
> > +}
> > +
> > +void set_vma_from_desc(struct vm_area_struct *vma, struct vm_area_desc *desc)
> > +{
> > +	/*
> > +	 * Since we're invoking .mmap_prepare() despite having a partially
> > +	 * established VMA, we must take care to handle setting fields
> > +	 * correctly.
> > +	 */
> > +
> > +	/* Mutable fields. Populated with initial state. */
> > +	vma->vm_pgoff = desc->pgoff;
> > +	if (vma->vm_file != desc->file)
> > +		vma_set_file(vma, desc->file);
> > +	if (vma->vm_flags != desc->vm_flags)
> > +		vm_flags_set(vma, desc->vm_flags);
> > +	vma->vm_page_prot = desc->page_prot;
> > +
> > +	/* User-defined fields. */
> > +	vma->vm_ops = desc->vm_ops;
> > +	vma->vm_private_data = desc->private_data;
> > +}
> > diff --git a/mm/vma.h b/mm/vma.h
> > index 0db066e7a45d..afd6cc026658 100644
> > --- a/mm/vma.h
> > +++ b/mm/vma.h
> > @@ -570,4 +570,8 @@ int create_init_stack_vma(struct mm_struct *mm, struct vm_area_struct **vmap,
> >  int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
> >  #endif
> >
> > +struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
> > +		struct vm_area_desc *desc);
> > +void set_vma_from_desc(struct vm_area_struct *vma, struct vm_area_desc *desc);
> > +
> >  #endif	/* __MM_VMA_H */
> > diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> > index 77b2949d874a..675a55216607 100644
> > --- a/tools/testing/vma/vma_internal.h
> > +++ b/tools/testing/vma/vma_internal.h
> > @@ -159,6 +159,14 @@ typedef __bitwise unsigned int vm_fault_t;
> >
> >  #define ASSERT_EXCLUSIVE_WRITER(x)
> >
> > +/**
> > + * swap - swap values of @a and @b
> > + * @a: first value
> > + * @b: second value
> > + */
> > +#define swap(a, b) \
> > +	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
> > +
> >  struct kref {
> >  	refcount_t refcount;
> >  };
> > @@ -1479,4 +1487,12 @@ static inline vm_flags_t ksm_vma_flags(const struct mm_struct *, const struct fi
> >  	return vm_flags;
> >  }
> >
> > +static inline void vma_set_file(struct vm_area_struct *vma, struct file *file)
> > +{
> > +	/* Changing an anonymous vma with this is illegal */
> > +	get_file(file);
> > +	swap(vma->vm_file, file);
> > +	fput(file);
> > +}
> > +
> >  #endif	/* __MM_VMA_INTERNAL_H */
> > --
> > 2.49.0
> >

