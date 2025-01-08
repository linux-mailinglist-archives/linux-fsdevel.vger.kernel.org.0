Return-Path: <linux-fsdevel+bounces-38677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A7AA066E9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 22:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1632616097E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 21:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBAE205AA0;
	Wed,  8 Jan 2025 21:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l71TuVsh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a9T/3kq8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810A82054ED;
	Wed,  8 Jan 2025 21:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736370398; cv=fail; b=XAIQ3Z3fiUsHB9EWuFx9Nq9+pKPxhbCQkM/IAt+qiBZLNGvc3Arhpi4U9VpWzb2gw/UPIBMCgdTOtoc9RGH95CnH4G3e619/35w6J75cghkXkRbdc3FFlPXIUs5kVrY+AMGqp3WpLK93gNn3xhhPz/AjUOOCI3EsKjJBq9M/0mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736370398; c=relaxed/simple;
	bh=G1yxpj2UGFxxdy9L51Knp0TUIvmV/LIQ3zEh9KB5Rq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OsLZlOfZmyprwERuPFTI9bcUIL6X/PLGaUQUZq9UKHHQuIaf69W4KpBP/RrdQbHfJncK4LpQS71pSKCibpz79ATgetXbU7TvrS/Nkrj7oXjLsYTkkKQokaWZ07BRusGXf7zCff9d32Vc07mvpiH+WKQOajGlbug9num0quud+1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l71TuVsh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a9T/3kq8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508INNho000842;
	Wed, 8 Jan 2025 21:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=isUn9Flj4mPLhVggwB
	WmNQc94RFRzlE9E1gy7VXbpfc=; b=l71TuVshadHYCddH2TJxGR1YBHhoOleAjp
	g85GBVFqLV5znccwnRik0LnO/eqC3vJx7gVOzHzf1+fFHcl8Sr3bElipoDOUdN9/
	Bye1yrurWLvNqQ3AOl0fYNBUPGEjpLf8mmTdGYqSL07VpFMAWaREdPcYPTLYTe8D
	/VkL8iOFXex8pQ4xz6sdxAO0jj1vPpPRW3g4fd+UNg3FcgR1uZBe47lxv2i8xdqd
	6bF5tQsxurO3BmqclAV3i9r3q90R8PgXxKF6ZL+e68jPO0K6zjTAoN8I+oqUandq
	mpBuEUms1A5JAAIbdDKrq6Tj8mAQshv4nuGNS3HQ0+GrW6QMCt6g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xvksyg5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 21:06:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 508KrDOv008568;
	Wed, 8 Jan 2025 21:06:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xuea3h44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 21:06:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7fgFah77Ps/rdo2NYsDSv2MMDBwkz50o7K4q3+JApITcg0VYMJk0y5+OX9eGhWa4L59uTaizA2/S6SRjZJzoHYrbuNP21UWyVA9TTLu2Sc4Hf//MDvuHOP/1Z2oWOmbJtATFOWqM87eoujcUP6wnXxk74vVYdRKsxBm7AenFC3DSGWzRPqB9xOuN/nZ1iwL23itBtyNSkQT5fGeu4zXdkBr8hlmmon9EExbwQ1iDfOnBM3dHHmkCEqljZN4RDazVx6PKhxVWZ6Cr/X35qywLg+8W5xsKm1bPj/wpYL/6GHAP0IDPeIVSKJAi0NetWATeITZVh5uiLYXUpt8cX8jSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isUn9Flj4mPLhVggwBWmNQc94RFRzlE9E1gy7VXbpfc=;
 b=Z1fz+oHWa6+rkDd5pEvkqx6ZjGwt5iYLuIghisE6H+TuP1ZL9pWDkMlo6kT9E73lcQXqibBPkwsfjJytRpCM0cNITiQRb/m9qGNZpLOz1V3N7dinH7T+LlhrK6APhsJr1nL6tfQcn41gLAM9s/6ivO5LLtaG93QXWnzQQSZwfXJpwYz/Exm98OcGwCYnebwQRgrF1x3yrwHdDgRI9J8+RoLZVTVEC+Ilb6bnOHVjZb6qQQ0a+LrunBehvx2XNbKITmegN9uZEB5MGxSytaQt1fPCnPcEKeuQuTWrHjkBhUgCtV6HSdHefyj1SkRBTgijrXXUB6+EhYIZyovKrZo94Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isUn9Flj4mPLhVggwBWmNQc94RFRzlE9E1gy7VXbpfc=;
 b=a9T/3kq8OMcEhFg2Z3hwefdbd2MD1FPOAobHbzMbFlyZBjsCXcAlVH4z7+ri/3r+KIiObQx9GUQvMpaqJ7FzCKjSxbPsOV5e+QcZkGGbYZtloggKiYOVJrGscZ6JI5/6e2C2Pi+5f/dhPV/HmmhVxHbDwH1fwYBzc3E+snPFpSA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB5552.namprd10.prod.outlook.com (2603:10b6:a03:3da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 21:06:13 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 21:06:13 +0000
Date: Wed, 8 Jan 2025 21:06:10 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, surenb@google.com,
        kaleshsingh@google.com, jstultz@google.com, aliceryhl@google.com,
        jeffxu@google.com, kees@kernel.org, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH RESEND v2 2/2] selftests/memfd: Add tests for
 F_SEAL_FUTURE_EXEC
Message-ID: <6f24a4ad-613f-46f4-ad33-31ca21c383c7@lucifer.local>
References: <20250102233255.1180524-1-isaacmanjarres@google.com>
 <20250102233255.1180524-3-isaacmanjarres@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102233255.1180524-3-isaacmanjarres@google.com>
X-ClientProxiedBy: LO4P123CA0074.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::7) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB5552:EE_
X-MS-Office365-Filtering-Correlation-Id: ed191238-d2c7-4571-5b10-08dd302848bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HftSKPWHTLb70ecPbzZdT1UV6GEHqL6pi6G4BlvI0HlHGhE1cIKhybTYb8k1?=
 =?us-ascii?Q?8CTAoxofHX5Spe08DaAXgg7o5EVD6D20QlmnveSg7aXcCK3o2PZdqiA/9pKZ?=
 =?us-ascii?Q?4RkWgJ5Jtg0wa5nvCRfhSRQ1n7ijtNsNOjrXcFxhlV5gGcep13oo67JnyjBD?=
 =?us-ascii?Q?Ap4fXajtqYFjGYJKdRaMHToN9US5i+UHpA1Ks/ydC9hTHmXm+lb/Ze8FeGzV?=
 =?us-ascii?Q?EPtHt0NWGg1MSwMcQzJamDPlCtQDcsUifbGzi94IK2J5lZ868mZofjpP23TC?=
 =?us-ascii?Q?kdjO1LxmQxnk3jt/LeChyhcakdeXEkEfXtbmFt6oXgdB6coo0V5wYBB5acDY?=
 =?us-ascii?Q?lhldJ1rxv/IXC4AKLlfyVp6j93nR6eGBmULN8d1trXRlmRj//nitv+l+lO5D?=
 =?us-ascii?Q?9uLd1Mi4jukGX3ZbeXtVQpcF8PklFHzg91++KjiEz4ECkvZL2ZV41jVLELfl?=
 =?us-ascii?Q?vL3REIaUN8epccTGuEIw/HIYGet67dWFkFX89vM+qDuosJOSMuQyMLrIaeDC?=
 =?us-ascii?Q?BciTg8ZsVZ1vVrJBgCTFcvb4FIDfGvGsz1w0XXBVFmx1wOyzeEJ1XAnylwdI?=
 =?us-ascii?Q?pwA7WcWCCirRnnW3Y9/NpKu00Og/zuV6HAIIVx3KzEDOhT9YRPtwOA8hIuax?=
 =?us-ascii?Q?5m28xZjy+obD77jfZrpklpUvFpyrJ0DULG0L3x7JOBkjo6/LBRoYqGZjOGcj?=
 =?us-ascii?Q?9DlHHCGC36TDN1h8xEtcdQyjeJDFqxzN06GepZKvPbrmhigKzVzOwV7H3GpJ?=
 =?us-ascii?Q?tXtxY10FKceJFeyWVA1Wli3a3IKEwIyrgyLyNQezsUuERs9Ex58Nqj4q1Q2G?=
 =?us-ascii?Q?tamXaNNX2UutcWmqFCWAlMTmU9Bj52z6tKYbCNMUZVHdpkhDxKWVtRg8X9y/?=
 =?us-ascii?Q?d1llFFqhGw1vg31tYVfy3fVUVAC4sLyalzPYrTu6TnnIK95srstS3TaGIhsu?=
 =?us-ascii?Q?h50M3KWhCIMRu4wTQD+02ygkBpE9gUtf/B/3zHSxhGr54wwy6kbL2adQwsm+?=
 =?us-ascii?Q?AJrrShxXlPP0AOi+yJr5wQzRERa8vrZDXd/cp6USuz7bUmqz3rN0DVf37/Pd?=
 =?us-ascii?Q?eZN0Yz7oL+z5JzHK2zAXggCtpsUlNISGIOXCQCe0heunePLFery+6+ArPZZj?=
 =?us-ascii?Q?1OMu5D22ayqFw34+twsqiwmAXPNul0w8bsSA3Wl0pT+DwdHTBlaCSTgDVZ6O?=
 =?us-ascii?Q?thqrb7IiVR3Ju3RKY82Ix1f+u+45RgVhV1ufsfS2OtmwMXT5+05VvSNrrKpP?=
 =?us-ascii?Q?AeT3opGktIb1HY2CA1Jmq93yaTyGuuB3y3fpmai+erI25zCTKF4CfbEy1PyO?=
 =?us-ascii?Q?iFnkF8Op66/31XHUvxMH2F8N5rSzbbc+q1zw32v8vIV/ATV358wpqSgToqX0?=
 =?us-ascii?Q?EK0R3+s9rGO05AUb6322nmML7Fu4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bb+J1aGuKCbCUTtHDKmX0zZG+DCiIdZ/vs+/hL2E0diLx9o5Y3fN2Qb6mGql?=
 =?us-ascii?Q?RgKndHbOwVCEM1nVBJYtLNoBd3MjDGYYSk/0S+cxJS2fXuMDTuZkGo36Prgm?=
 =?us-ascii?Q?QYlnXGhDGnnwEjA8UIFS5gy+9q+HD0GRI/ImuyoF0dvNqxXu/t8syRpOP/A6?=
 =?us-ascii?Q?pNiOSfImmlLRXXGL/Hs0FJxhfl3IxYJvMnmhjjag6Lg2oA4UlfmFm42+nzrd?=
 =?us-ascii?Q?0bMiaYz2uUxxnhSanED3M2LDwC/c9iCuLOtLKwdoTNKhmgTzBbuj5J75bjLk?=
 =?us-ascii?Q?GTKLIN6JjH80pxM8YwhGOPM+LWnnMev6UWMaCfiwymhmSTBLOqqs14zkF8b4?=
 =?us-ascii?Q?FaHTIJ1MzMZhPZ363xFzoh1dZTA02xIFlxrSIfdI8kb9+gqmSZEB7JgVn4B1?=
 =?us-ascii?Q?/NEMA+um0EMxVR5GNb2C0kCBHw0J7WHbxoimWHeF2jyQGRV7w7BeRIvI84ZT?=
 =?us-ascii?Q?zE30TTgCSHWiVcdTYj8iyV6xBSszhcJYFc3yFoc7vWhyCY7ES7TlBWcKD4/K?=
 =?us-ascii?Q?INTKosHrz5bmRK0urN2N8h8Lr63ItkVWq1zq44orAMQ4x5cTU965dWEiLwnS?=
 =?us-ascii?Q?5NmBXgKzJPOQd1h+CccnUPZVaISSEAUe5vDHAIM6021e7MfUw674jgVn5jbx?=
 =?us-ascii?Q?c+OTh/NdfipNlXpU+k8HsGiveZTKTnZVC3kG3KFevw7AEoLsX3Hc1rRcinKn?=
 =?us-ascii?Q?9W+PeSwLsNA1ClULvSlVUGO5aS3HLw0XTmhYvqrprAK2nJKGSFudBqx6adFV?=
 =?us-ascii?Q?6rXJ5GIiXQ8Za1+DDVpYWRSnwOpHr5SDnr63MsKWz45FaC39VuGQfF/FeCTy?=
 =?us-ascii?Q?UsF18KBpQjoH6wYEWkp4zDd+vD1g6395djQUcLwVqTtPbvyCw2PJ+ui+9eT1?=
 =?us-ascii?Q?qr0ve2Ihhn3XpvBKyMCXh4tQc9aR3lQJNKEtiBgRwTD2MRKNUP3ApsCTCcL/?=
 =?us-ascii?Q?Pmr6dHrU6TFTcVM4k/ACR9VnkqDBCygY1L6GZxdBtNc3R3Ivhohtf7F9wkvF?=
 =?us-ascii?Q?9kXTe9zYEil2Vqp9sFEskuEf9dJ61d0BjpfT1SlVAqo1Tqt59KWKEsLwXtUP?=
 =?us-ascii?Q?6p/JBQbC7AvvyAK0Q847g9kQVmGbRdyyq6P1uXbNE6Rk3ZOIxocjZDhcoTja?=
 =?us-ascii?Q?G4cTPB8fkNAMxI69hY2DRy8JgO01337oE8Q2pp3t05F+zQZNk+R/nYfnkhHj?=
 =?us-ascii?Q?CwI4zeTy2byqdL3ee1m3mqh6FeD2oy/ZBq3C6RZKhfZtHVxjOm/Y4EPcn+/F?=
 =?us-ascii?Q?Uda81dDh2kYVN+89VWLT1tlmaHIBJqXWGWRw0CmKZcJUtruTBlfnniwymNNm?=
 =?us-ascii?Q?n2nsXUI17xlSu7g7hfG4gXF8iUtdpmVKyHPDN3tOv7NwQl9N38CVRvEjby25?=
 =?us-ascii?Q?8pAyLqUxerSx/iElO0sUDw9FPnOvvhlDEJUw5qNpzFZb3G9s8uioYqDrWPoE?=
 =?us-ascii?Q?O6KqMOALlrDenzIpiZRfA0cjtGTpHkTHmVv0FJeDq7cxaf2Bme+JD7B1jYHZ?=
 =?us-ascii?Q?toR33AjsCkLvQ2Ub0MungXARkML5BIkvTuO+cPH+wI0e5EcMQg9TFcErU64i?=
 =?us-ascii?Q?DHQcD0kIQa6yCfTYj4XEyn93AFVH8DUHI5dWLvtS6/TCCqUvE14NozTYSWQ9?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pHcSmtYJR7fWolrpHhcm2Lf3qru3dpK5WwBokNnIHCa++NdeSTB9kAQeRy30O12EsaXNlMHicwK9oOBhnaSQyM7qtl+l/BeBWOanABvWqbnEwIceo9gmh/5JtC/vCH1BB0eDR0JA0SRDoV0ueA7ONa3vziRwcQVH474EbglOJHLzWm6beUa4NB/ox/3YaerxIsk+eWGt2mMsnxL7zu69P2MX0x+gM4UPkUXIqv9UHrhPJlWXXCzAYE0N79n0SfEnLTdmdKeQdvgasWxlQUlSUIPJptFdLGg8LsjONCdl91wqt4vWaluT9bGo+jUs0te1LYgIkz8AH1tGthZg0ZdxGPJPDdiqL3MAqZF9bl9wCMBkBPQP6RlkhPjCS/2USdQAKRpRBBZCOy0UyVB3sCFWxB+KPEKWIYLokc7HBBrg4fE0qlnSEMbR0AqUpwpq17Bz3OCxIn7MzWQolz+sn0J5blsD5kKXwV49sWbta87ruFHd1bGKEqgr8ZsvxKWOvpVOVTzopBCjojQiQk8+KKwhQcoF/u/vB25iXA2+BhflKIxJoxy+JAPLychrDceoYHwoEG+NdXynjzwwFXXF09qLlpePYTsiPPIp7l198bcV8Zc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed191238-d2c7-4571-5b10-08dd302848bf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 21:06:13.6592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZYKWS5vBoYXXJHML3LCXMH4rCuSKEUW8mNFMaUMfhszcvyuyPXNmNXPBqNcPQFhoeHbNMAcH/qrCekGIwV6d3kdfJIzMPzZYK3jCrNTQdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5552
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_05,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501080172
X-Proofpoint-GUID: F6GXYs2Ni494T0L5rsc7Z6zXO7F_2k0H
X-Proofpoint-ORIG-GUID: F6GXYs2Ni494T0L5rsc7Z6zXO7F_2k0H

On Thu, Jan 02, 2025 at 03:32:51PM -0800, Isaac J. Manjarres wrote:
> Add tests to ensure that F_SEAL_FUTURE_EXEC behaves as expected.
>
> Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>

This looks reasonable,

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  tools/testing/selftests/memfd/memfd_test.c | 79 ++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>
> diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
> index c0c53451a16d..abc213a5ce99 100644
> --- a/tools/testing/selftests/memfd/memfd_test.c
> +++ b/tools/testing/selftests/memfd/memfd_test.c
> @@ -31,6 +31,7 @@
>  #define STACK_SIZE 65536
>
>  #define F_SEAL_EXEC	0x0020
> +#define F_SEAL_FUTURE_EXEC	0x0040
>
>  #define F_WX_SEALS (F_SEAL_SHRINK | \
>  		    F_SEAL_GROW | \
> @@ -318,6 +319,37 @@ static void *mfd_assert_mmap_private(int fd)
>  	return p;
>  }
>
> +static void *mfd_fail_mmap_exec(int fd)
> +{
> +	void *p;
> +
> +	p = mmap(NULL,
> +		 mfd_def_size,
> +		 PROT_EXEC,
> +		 MAP_SHARED,
> +		 fd,
> +		 0);
> +	if (p != MAP_FAILED) {
> +		printf("mmap() didn't fail as expected\n");
> +		abort();
> +	}
> +
> +	return p;
> +}
> +
> +static void mfd_fail_mprotect_exec(void *p)
> +{
> +	int ret;
> +
> +	ret = mprotect(p,
> +		       mfd_def_size,
> +		       PROT_EXEC);
> +	if (!ret) {
> +		printf("mprotect didn't fail as expected\n");
> +		abort();
> +	}
> +}
> +
>  static int mfd_assert_open(int fd, int flags, mode_t mode)
>  {
>  	char buf[512];
> @@ -998,6 +1030,52 @@ static void test_seal_future_write(void)
>  	close(fd);
>  }
>
> +/*
> + * Test SEAL_FUTURE_EXEC_MAPPING
> + * Test whether SEAL_FUTURE_EXEC_MAPPING actually prevents executable mappings.
> + */
> +static void test_seal_future_exec_mapping(void)
> +{
> +	int fd;
> +	void *p;
> +
> +
> +	printf("%s SEAL-FUTURE-EXEC-MAPPING\n", memfd_str);
> +
> +	fd = mfd_assert_new("kern_memfd_seal_future_exec_mapping",
> +			    mfd_def_size,
> +			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
> +
> +	/*
> +	 * PROT_READ | PROT_WRITE mappings create VMAs with VM_MAYEXEC set.
> +	 * However, F_SEAL_FUTURE_EXEC applies to subsequent mappings,
> +	 * so it should still succeed even if this mapping is active when the
> +	 * seal is applied.
> +	 */
> +	p = mfd_assert_mmap_shared(fd);
> +
> +	mfd_assert_has_seals(fd, 0);
> +
> +	mfd_assert_add_seals(fd, F_SEAL_FUTURE_EXEC);
> +	mfd_assert_has_seals(fd, F_SEAL_FUTURE_EXEC);
> +
> +	mfd_fail_mmap_exec(fd);
> +
> +	munmap(p, mfd_def_size);
> +
> +	/* Ensure that new mappings without PROT_EXEC work. */
> +	p = mfd_assert_mmap_shared(fd);
> +
> +	/*
> +	 * Ensure that mappings created after the seal was applied cannot be
> +	 * made executable via mprotect().
> +	 */
> +	mfd_fail_mprotect_exec(p);
> +
> +	munmap(p, mfd_def_size);
> +	close(fd);
> +}
> +
>  static void test_seal_write_map_read_shared(void)
>  {
>  	int fd;
> @@ -1639,6 +1717,7 @@ int main(int argc, char **argv)
>  	test_seal_shrink();
>  	test_seal_grow();
>  	test_seal_resize();
> +	test_seal_future_exec_mapping();
>
>  	if (pid_ns_supported()) {
>  		test_sysctl_simple();
> --
> 2.47.1.613.gc27f4b7a9f-goog
>

