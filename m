Return-Path: <linux-fsdevel+bounces-36375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91EB9E2A54
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 19:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640F32848E3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 18:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4815D1FCF41;
	Tue,  3 Dec 2024 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X3KZS1Yb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PM8X86Qp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02D11FC7E3;
	Tue,  3 Dec 2024 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249159; cv=fail; b=nnpwT9E+8rZJujSHNn8FYqzbjU9ZZIKUGf5YWcjgDsO9XCFb2pbZ1ofoNozAvaEP+gs/G19USp+P047/FbDP7d6JR2UiOJHxc+RZ8a7u1srPJuXpXSf9tdmn4Qz4NuVy1HuhwiUVe2PC9ulUEgdyGIqJelD5dXA2Y1z3TeW1ETQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249159; c=relaxed/simple;
	bh=iaclXEsnfKTcPzoSuZrfKW1NEh8nEnC1PiF9+8LHBtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZvqUChL3bO8CtloYaX+zLuGT+wkWoBNnooOiY1UfK7oCTa0/2FI8PQFKltyVrGWC7XtpLP4yyRN98/zm2sc8uhN+/2hCTaMxBurfmm4+aFSkfrfwwCNfHUckMoBJzF8WDpZW44UVUp5rOwqyfste0Lb0iAhV/ktJLoQpjws221w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X3KZS1Yb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PM8X86Qp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3HtaQP012433;
	Tue, 3 Dec 2024 18:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=h+C0HsktFzmPVDF+PnzGjib7ioZoAwoaSTtHI6BxIYI=; b=
	X3KZS1YbSPlN+2WPa1IQW4OGpkOMFmcNj/4gp0EHFLGVmTpCPtKezg3E9qFdKaNl
	dCB6A/SMefDnzytFF10iybdVgtB43UKY2XgVuRF+rQu1/6dU8wII1pL9U2OkpMHE
	mWUZHTxC12zucPDbyM5+cJPCW5edM7uKfTGk6VEYkELpedtwMz6ylHMyBlOiYSug
	j1lgnUScAE4KK/uXE8/D/BqIQgULqFnPVsEmzZOOjlgNboK4QAPY+Cin8lVVyOIB
	uYd5X35viTw7JCBqVQs3EDyWewZfTxA0OCmtRziWf1R1Wckw1IJTKRvlQwJMUl/7
	Sgbw9Lzi3a5fdqPr8CyAhA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s4c6nss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 18:05:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3HL0w1030979;
	Tue, 3 Dec 2024 18:05:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437wjcuq4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 18:05:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bn4EvTK9Y85bRMFRnQuqhHeoS8GaepPnz5wRlsPmTCRzTAeUXXwEqGFTXYG7nnbQBxqIv1q6GPOaFQsRJM8DTtjUFIxr0BKD5BuvBczfDnuVeoj1PZiFvwg1Iz5ZqKvnCu0eE5hOGUj33YrRZ96wTkygQyhLd5V0m+2EJsV2UFR9ex2Elt4MiNLDRKiC44Y4c7EZl6KyJP+gdBZt37AFDy4y2wWqbmIz2u5kvwqoTkSdB9R+dtxQVGbaRIfn74DiGJMxPfrk9I5IBKiCAGUhHQCGZRhwUYg7pA83aS1bnBOMjbmOTUH5KgmfPXRvXJUACgMIYKUj7VcbSSh7s6ShMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+C0HsktFzmPVDF+PnzGjib7ioZoAwoaSTtHI6BxIYI=;
 b=kPGoiR6MhqWostkoxqzBW0YyxeqD067PdRE85Rgeqqd6agrLR00eRdpIPCORaUUwM1JqZPIdSXdsZ4cSTfo1d6sMBqe9i2r80WanlCFL57pGbGvajgtlaNnt5ww3IOYXjGzrinEjrIls6ALFULZiv88ku+JrTDtuLaMWunZ6CQ7dNqAsoRHrkeHUXZJf/txh6G9MBEyC+5qVLXHEhYONdYEjGA0vT0PSPo58OV0X1fkQBiRyG+8OMmLRzkmrxS/2W9sw05Ky2XISQjHU2la+5psUaK/oKuvuWhQJVR+7VJVQhFg6H2ZS/EZUGbHt0AAv6D/MEQTf67hQHVfKVrWNAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+C0HsktFzmPVDF+PnzGjib7ioZoAwoaSTtHI6BxIYI=;
 b=PM8X86Qph/GITLYjFkuNQaWZCGHeRmvmIkcN7X9CXzYWgIeur/iAE7B1kS29PGb08+kdVDkKsTCyFSKfEm2QaovKaF79eYTbCudcusiPBSTX0z+Kxlqyrysq/akm6iiNqah4NHeZtPnexH/cmSsPmIEIJ0E4bdVLm74x/FaW2oo=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by LV3PR10MB8129.namprd10.prod.outlook.com (2603:10b6:408:285::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 18:05:42 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 18:05:42 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] mm/vma: move __vm_munmap() to mm/vma.c
Date: Tue,  3 Dec 2024 18:05:12 +0000
Message-ID: <5e5e81807c54dfbe363edb2d431eb3d7a37fcdba.1733248985.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733248985.git.lorenzo.stoakes@oracle.com>
References: <cover.1733248985.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0336.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::36) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|LV3PR10MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e767d7c-4787-4440-64a5-08dd13c51a0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8YEm0AOYG1ZOkUJEdyMkJJFfA1h+pwppxEAMf+1NmbrpJbt3APGUYiV7PRZe?=
 =?us-ascii?Q?nc/c+1Sl0Qylu55Dz16Z2bAM+2yDaSpsBcHD4CNuDGp1ZATw4OKmUdz8FyM/?=
 =?us-ascii?Q?1E1U//btC4iTGB6kKw3oT6ujMUDARORl70IX41AY+UOQtC0yuk5XpeOrFNTA?=
 =?us-ascii?Q?w8iJPiF4jKCWqQF+V8vI8nQMmSe7uH/4xhmB6SLfUmPlYtDr2Bq9t19fnGPh?=
 =?us-ascii?Q?CB4FBNvyHHWwI0n/Pb6VQu3zkSUu55K3iz8/o/oFYu0ymQIoxTknwQG5aY1w?=
 =?us-ascii?Q?AzRm9JTMm8r3FzAogi13LnmeA9gKQ+pzpc58G+a69OIhH5hwy0rkt2zIp9PC?=
 =?us-ascii?Q?cMXH35nylgiFxIjSruSQI/9wYgN3kfGF6s3by0Iuj6Xspg4k8L93B1PGdFFG?=
 =?us-ascii?Q?U073x4M6U2QuA8o8kRZTFLlRqLTGzowGvPueNc6QN4l4cnt0/X0QoQb6l/qf?=
 =?us-ascii?Q?yVE2d4b4pD7FaWr+V03vIEZ5qly+LRQyrk1L8vruXHXN69WN0Vt5kNc6y2ha?=
 =?us-ascii?Q?WkUfvnYV4/0BRBxOQql4x1nOIw2gfAchWhOg1zI8su9kbnFLbch6YHXU1QDK?=
 =?us-ascii?Q?0Y2iQpI/JBJYrQvUMz+aoxgBbx3Mbc31ZJMxxnAPdHBlhD1udZtAncURgmrf?=
 =?us-ascii?Q?hoqQiBmu2//gmGlZGQ4WAdoBkngDgM9hqQGvU8esw0Q7WanCFvD6pefr+BQE?=
 =?us-ascii?Q?Q3MuPcvwn0eVFA9KYhkJTnawJ7qZMRm0lMyNiGDh0f1lJ4vE/hdTqLLt6WbY?=
 =?us-ascii?Q?pu56uNXFKEcEzH/GENyTeeX1nlDA+DEgfHhlL9pbLhZBJqon7rlblFaSQjDR?=
 =?us-ascii?Q?EmCyAFmOsFKPRhToU276aYzSZGg6Ycxbca/V2dCbLOdnTcbqvXwfq9QIOH0g?=
 =?us-ascii?Q?Q36JIde2jQG+7dv8zxZOUtGS/I0470hLPkbdpj41TwRGCSbhE0L9o1jOWEd/?=
 =?us-ascii?Q?rr9AhSKiOBvGHH4e76g2qwdeqw303CRM9cfFZ+hN10Fqo+DDvbqy2A0orZiM?=
 =?us-ascii?Q?JGlNODW6K3PqLWtHL/sKHt2M3VOMh1McndeA2Ol9+JfVmovnjicG8q1fL3jT?=
 =?us-ascii?Q?Hwm3mo1bJk8XOYNHnEX60r31KUkfJAr6ZbjfIHaRk7FFJ7TsBTCqyU0bXO4+?=
 =?us-ascii?Q?VND8mbR9EtlBriBJbTqPdTG7nYpgOdldhqG0tfNkZLg+K8YuUnt+HpvNU9Kx?=
 =?us-ascii?Q?++eW2SPSduoOhRKbsA8jT8FQxtRUopkAiEiYqh2loN/3Hhc9IWqzwMbCks9m?=
 =?us-ascii?Q?gyAAIG0GVTseLXNquUw3xEPAEGn4j8y7zeSSw1nDegVamYBVEVdhRNsqwK6Q?=
 =?us-ascii?Q?Rpvxv2AYmfhHObz/8RVhKsNs6RmbqDwINOdUqLmMTfvOvw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aWCvxsMGckTL+VvGmXxRiI+uK8u3iAhG+GOsABdIZQhWj4sPlYcwEDqLpK1h?=
 =?us-ascii?Q?hkx2btqMzj/x1l3dhiBZy/ENtZeogukvdNXbCf9+3OIkIHj6WxuIl+NPTPtt?=
 =?us-ascii?Q?DFnR00payfMUKok45bsOBdC1pcXvCwYMP5wwAFlPcgfMccuYhNPBJLV165MH?=
 =?us-ascii?Q?BFrj3u9naNh9vAwsuhgE8Mm+JCPNTj2EK/hVIlY8EzqyO7d7WC02kYq4bSKW?=
 =?us-ascii?Q?FCRWh8MKcypldRfp6Eu3FzjhwhIZNnTMIrQG0lI8PxSG08KIuPZFl+pKN+0n?=
 =?us-ascii?Q?mEo3dpeajD5++6j9wiBC6Tfde32HXuPU+Y5mM0ljdMTCEYmra5QBVvJpTC5r?=
 =?us-ascii?Q?eiFBXymdbhzjdG9Rp/M2YJS9uzQglEW64kR5HrcS3tptE9Ua1HCf5dbJgwwj?=
 =?us-ascii?Q?fM3qjvyyrHQByFUxxNz8pPNMA8hAU2t3+W75/KrLpUgLSN/k+FQX2iJLrtD7?=
 =?us-ascii?Q?4gT9IdSGqP9AhYyl9o+PoqzvB9QK8iA6Z3w/6/NAdbjpvZhSnFjzhUkX6Uq1?=
 =?us-ascii?Q?3RlcUllivuqV8xGX3BT2AgXTYN/fJHzNUmzwEtPqtaJLmswGjSotI1MDwsDG?=
 =?us-ascii?Q?j1rmbtZEllVlH7dMopuvv5vUR0xy/rCAWyWeEE5YG5YNY7vQ2HTPAJXSFpSQ?=
 =?us-ascii?Q?ROp4vAVEpM4ZcS+1YXhUmfV2720cYgrYDGdHRxPk2/wpP6flKMZ8b/db2AJe?=
 =?us-ascii?Q?JPXTI6LWgR2JArUEC2SJ7gLF6ti734WeaoEJ1mN8tsJ4o16wUDuI1X/ytsGu?=
 =?us-ascii?Q?nAsr7w6DycEMb1eaG81+aXII4b5PXc9S0umIonNDlAfGaJsxGZwtGedDPzcm?=
 =?us-ascii?Q?b0VwMI7kTL97oo3ofLwrmF9kCuvKr/62THBS/GB4rf6fnvErQVVTeZsL/aQ5?=
 =?us-ascii?Q?VptgwhBlKxfrLUBM1hglbu5vd2nxMmrx7+dvY7cs2uUK5muYcrWHHnpKa1sn?=
 =?us-ascii?Q?PWqxyxpcu9Eu8Qr7vmyH6JeqejXEdoxJs3Be6otXcHrkqsX5BMF/OivQ+eGy?=
 =?us-ascii?Q?dtNYATndt7hbrRMACK1X5QkvY0iun4cnRhfN24lQ8c1ctBKLwNC9LTKIDgBS?=
 =?us-ascii?Q?0i3qQx/UcdP2S3/KQ65203iFbSiWB3WXGEiXT8IG7VYCwkzS/n6YEpbqRyYQ?=
 =?us-ascii?Q?zmZb0Un5NjxB6EaRmzXZB9/24fqcuCOh3ujQ8N5uVc3snwOS9e+zMUwqmYlE?=
 =?us-ascii?Q?VbvUbESuCqR7uTyAdRXxFZUMgufNgkyvcF3qkiz45TJ8vs2V+2p5gVi+gum6?=
 =?us-ascii?Q?57CS8Z6MteZH5evCnCOE7hRt+3GjwvhXNo7rWvkNphUoYHPc2/oWZTh4SG5B?=
 =?us-ascii?Q?trT7NoHS9tjdZEQws7uPKpI6ilgGwaCqwxxsDUbDHrcuKKvWjBdcPraHIw5H?=
 =?us-ascii?Q?ssI/bXmIIFcIWbibZCkyf1WvAVJg7fMTLgYG2wK27Z7RlHH7pyoBB+cDNzrF?=
 =?us-ascii?Q?U7j2lKR78PbtXLyzEFcr9e7pseW5w1ij5MeGKjhL8+cdr1lsBqWwwYL7FyvK?=
 =?us-ascii?Q?LrZV/vCqA77KeTPNg1ZFiS5HrR8I1UD3KKys4erCiEsJI6Lvso6zkeo9WfAG?=
 =?us-ascii?Q?tONF6xALZ7oI5J/BZqofKHIo0F8CU1UUU9AnxbSr8Bh9ZVkRmlQrfy0IrZ6v?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8q3FlgUZQmjsIS8i6MIg4XGFDqGvjiVGj7DHcD5dFlZPbZkXkszXldisogVb5vpEigBNooIwWpC2FaOcXb/C3n2I3pfOMqMlc/Vj6eeReZjWE69i2BNCM96OpgJP9iIw4rbkOlpmp/x71wHsmhfSWXMS1/XSjkSZfMUJy1tdmqQ3Ri8hw715xuHW3f/0jZEKzaZwD9fyCHW2siWSsmX8oFVwhLN88N/TFX+gczwXBxZV4IHq7RvlgyJDUhofMLPTG20z1Pttwajs/pfTtTP6neRAtiEUYY8adIcqdPLOslJP+q4GGnLWSwpq7SIoI9CnSk6v/lME9KsY75BohuCWWMofw910AmB+D7avw85H8cDiOrpPrLMc6zBBAQhJBPSZQLdEFE8SbknETn03XZlnXGDgMvkQtfWTaYPGj26p3sxgcXRjgJvkkQWw2Tv/cyS8oi9Mr8ZG9ZHijG9wpJYVsQSkXZ0z1v6I3UqFHy01X5pyLhLGWwPnHBPQpyR75e7hOQklkfUTUP9AZ7IxmTxkmpZOjSpRbPVvTREj63tFBYZCVucWT7vUUbUfIjQiPZtTfS6QHQy3aSCxHjFhbV42tS0qyQD/RbmPSwnZvM3j1Wc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e767d7c-4787-4440-64a5-08dd13c51a0e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 18:05:42.5555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNPuZ7nJnXMrCVV8gaG/X1ZUwh37pLO1rU90z9OEx/Aw92sVxfxCvjiOyX3Ug3rZRQjA2GFX4mBMZCcQA/KVd/I4rJeF+zqDZn5Oxd19Du0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8129
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-03_06,2024-12-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412030151
X-Proofpoint-ORIG-GUID: x5YfrHLOjVs2IOJLTGqOk7u8lUkrr3Eh
X-Proofpoint-GUID: x5YfrHLOjVs2IOJLTGqOk7u8lUkrr3Eh

This was arbitrary left in mmap.c it makes no sense being there, move it to
vma.c to render it testable.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c                        | 18 ------------------
 mm/vma.c                         | 18 ++++++++++++++++++
 mm/vma.h                         |  2 ++
 tools/testing/vma/vma_internal.h |  9 +++++++++
 4 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 55a8f2332b7c..1c6bdffa13dd 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1044,24 +1044,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	return ret;
 }
 
-static int __vm_munmap(unsigned long start, size_t len, bool unlock)
-{
-	int ret;
-	struct mm_struct *mm = current->mm;
-	LIST_HEAD(uf);
-	VMA_ITERATOR(vmi, mm, start);
-
-	if (mmap_write_lock_killable(mm))
-		return -EINTR;
-
-	ret = do_vmi_munmap(&vmi, mm, start, len, &uf, unlock);
-	if (ret || !unlock)
-		mmap_write_unlock(mm);
-
-	userfaultfd_unmap_complete(mm, &uf);
-	return ret;
-}
-
 int vm_munmap(unsigned long start, size_t len)
 {
 	return __vm_munmap(start, len, false);
diff --git a/mm/vma.c b/mm/vma.c
index 83c79bb42675..a06747845cac 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2874,3 +2874,21 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 	validate_mm(mm);
 	return error;
 }
+
+int __vm_munmap(unsigned long start, size_t len, bool unlock)
+{
+	int ret;
+	struct mm_struct *mm = current->mm;
+	LIST_HEAD(uf);
+	VMA_ITERATOR(vmi, mm, start);
+
+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
+
+	ret = do_vmi_munmap(&vmi, mm, start, len, &uf, unlock);
+	if (ret || !unlock)
+		mmap_write_unlock(mm);
+
+	userfaultfd_unmap_complete(mm, &uf);
+	return ret;
+}
diff --git a/mm/vma.h b/mm/vma.h
index 6c460a120f82..295d44ea54db 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -478,4 +478,6 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address);
 
 int expand_downwards(struct vm_area_struct *vma, unsigned long address);
 
+int __vm_munmap(unsigned long start, size_t len, bool unlock);
+
 #endif	/* __MM_VMA_H */
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index fab3f3bdf2f0..a7de59a0d694 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -906,6 +906,11 @@ static inline void mmap_write_unlock(struct mm_struct *)
 {
 }
 
+static inline int mmap_write_lock_killable(struct mm_struct *)
+{
+	return 0;
+}
+
 static inline bool can_modify_mm(struct mm_struct *mm,
 				 unsigned long start,
 				 unsigned long end)
@@ -1175,5 +1180,9 @@ static inline int anon_vma_prepare(struct vm_area_struct *vma)
 	return __anon_vma_prepare(vma);
 }
 
+static inline void userfaultfd_unmap_complete(struct mm_struct *mm,
+					      struct list_head *uf)
+{
+}
 
 #endif	/* __MM_VMA_INTERNAL_H */
-- 
2.47.1


