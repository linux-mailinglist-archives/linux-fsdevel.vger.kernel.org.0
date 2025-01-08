Return-Path: <linux-fsdevel+bounces-38671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F20A065C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 21:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36391888E1D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 20:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4E6202C43;
	Wed,  8 Jan 2025 20:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mjjFJewo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m4mZ6ROG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805691DF963;
	Wed,  8 Jan 2025 20:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736367173; cv=fail; b=JOtAeRMdDw9PtBI0JIC8TCLVot5dz0T19Tu6m1JaAT1e4iK458gOPs+oQYIRqd2G7JgCZ6XBa5NSI10/f4Mv7ccJ/JPdKBUAI1yasEuR4y10vyyd8nk6dewaexdh3O8TrX0Sx2ZWAv4w7uuVnU95/Zpx63iCp5xq2/uDjuH8liI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736367173; c=relaxed/simple;
	bh=KBvyHGzlBpWqt/SyCn442qTxfGHiKFNHKwPyyNyHVoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pYKjGIFjMbwfoAw+6P7m4SEY/1CvW90LeZoA3kFUPR+wcbpIOSPFXdPr0/avkCERfjLThSGnZVZBlvG5ibwE0bnyB4t9pXQYZUmUBxusYMy6ZqrpdXo7Wbrv2N1ufLbWbZ7IKssa53eVSD47K9gvZM5hDwQ7pjUmTXOp4wA7fxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mjjFJewo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m4mZ6ROG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508IMsQg015051;
	Wed, 8 Jan 2025 20:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=rugPLnqHHa0UqVKIBR
	RlWVU51lrvNzYTJ1s3LukgY3g=; b=mjjFJewoIFoTqbSxAN3nqQpvvHB7ZyVTC5
	7dpei7yfDAbX2sBtNLO2PltcqvEtLOYoXuMH76ZIrGCQW8W6ZckOLtxPENq7XDGw
	x6/ehM65sOcZQrvig19fWrFKM7ntrdTDXdYZY1nSDlvgVRqctbB9WIn1+z8MMaWw
	8m56Re53LwuFFDBuuOXBPVz2HEN1CLUJSei7Y2SnTk6AdWFltVj+sl+M03bY1Vy6
	QsFJSDXJHWpS5TK8eakHWnHMBJOjJ063wjtAzUJ8VwUfdyo589T4R71PPF0NgCtu
	If3wuxAxZ3mMORd1s9ZYJODnBfNBCVu0aiHwoSsD79y/Ftdbk8/Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xus2fq5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 20:12:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 508JkwJl027574;
	Wed, 8 Jan 2025 20:12:39 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xueafa6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 20:12:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0iA2fG5sWt9zMI6Ouoqex2DnrWq2sK6yHD8zEQRfqIkST4AP/33kHGtXnipI8ASXSWArmFbLarPZQ/gTMEs0ECnfk7x8SxonXUCxCzSeRZZ5EREUWoPa9dvyTPJXt6Vbg4SDNpEVfsm1zIW5F7Zu4FKWbf6x15VWF89SRgjQE8hJ3NcTf69dqyiIGFQADYTr3rX6QQaiEawX8/SDIU+bHfgiWCVGcdX8LUY5SIlolsAAKlNAtfZvlr9YOSt2gkkoTzz90jR702ePljmDP++Bwo146/gfrCEsG/VJf4N+5RyvxRkY6gRpIYj0mt1d155LIFcDbxX/QVOEEBR6GATjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rugPLnqHHa0UqVKIBRRlWVU51lrvNzYTJ1s3LukgY3g=;
 b=q7IwLiu14V8vpK9pPt8kSGtDh6bMSz6RUpSQbcNiNCM0HJ0fCk3+BxG+zkYB2QHKmxwVdOkMHuBYqTcxnxYP9PWqpfaOfJhwMgbGi/k53UdLlbylTCH/fh0u18NDYsxJYX/mCsGXnYOoX4W77ciJ3iR8yOakAO0isGleJuGLiboq1S37t3UsZFmPh0ly8yTfcfdVX++yW5X9Cvnhi+WTq3NvTgjkv8qkFPWZKavzngPdbT5dbBWFuxUTiUJg/0Pr4tLuTiHRO9mgFXyCrL7D4OlRCCfSHhWx8jjTwBGpufQhPuFC3LmfGz5GbwN/JVs5S7tE3RRhXEJ/34Y3ZbeH6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rugPLnqHHa0UqVKIBRRlWVU51lrvNzYTJ1s3LukgY3g=;
 b=m4mZ6ROGoJo39bg4Wa6Fyod1QxIeX6CwuPVFgbVZkpgURednJNcBD0gEW0wEJqyLMRGf3f99cuNWJ8MWmT37qVcyLb6H3QatGibzYBowAg7IAs0vCj3cqxaMvrAXHF7GCDxNc3gMBlW8o0Vbk7h/SK4z7uRhpqo6htXbMYE4m5U=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CYYPR10MB7569.namprd10.prod.outlook.com (2603:10b6:930:bb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 20:12:37 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 20:12:37 +0000
Date: Wed, 8 Jan 2025 20:12:34 +0000
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
Subject: Re: [RFC PATCH RESEND v2 0/2] Add file seal to prevent future exec
 mappings
Message-ID: <a09360dd-1929-49e5-8c62-54d5786c0e38@lucifer.local>
References: <20250102233255.1180524-1-isaacmanjarres@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102233255.1180524-1-isaacmanjarres@google.com>
X-ClientProxiedBy: LO4P265CA0083.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::20) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CYYPR10MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: e522ca71-a847-4836-92ec-08dd3020cb8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6t5vwJqWPBEALI+KUI42wMlKhMenvHPk5YX2mPOZ3YvT0xqCCLTeoVJmVv17?=
 =?us-ascii?Q?Olz8QhY5ftrHfw8vSov6mH/20HX45ypydZeFrXAPd7jkZKCyZq1PQq+Kp9mk?=
 =?us-ascii?Q?htkFGS9xM8vuoVFY9+Qt/sDm1vt98ruYZqHfkq65KRYJ30s0/qNQbLF7rorx?=
 =?us-ascii?Q?N3P/ceqJo8CjpzszJ7O/ZjAJOqh1o5T3MLFcSJcqvidOQXbD5i8cIE9IQ/F/?=
 =?us-ascii?Q?PdF6MpyH4rBd66jGEe3WP/qhBVMmUGNfEjFQEw3fky4u6NPrzK8Mw+oQD1AF?=
 =?us-ascii?Q?EPU7W+WJ8MgEJP1Y0MMYv88P3p5b/+w1IAo/rRbOd/fA4QvcRaj7cEatosqZ?=
 =?us-ascii?Q?F6ptQdxkGaoZ8pTqTEj8/3Eea0+GZ3l3bcEEmRQee5eObXeYZKz0+uabl0qr?=
 =?us-ascii?Q?uOWoombK2aMILuc2iPQC8GF3DiqnTz/d0ojiHYEuSC0/cG/fHgL61ica3jr6?=
 =?us-ascii?Q?PvnkEshyyGmBPRZL3CYyu7qD7E5mwVYqoC2f0RO+1TwLdJGIXqRqaQTw2T6T?=
 =?us-ascii?Q?kWUoQHHdYay2m57pl/xavRmlMWXLb3JWZJK/dGKzyUa3RDyye9nP3BIaUEAp?=
 =?us-ascii?Q?X/5QJhZxd7KkMpX5lYhJvb0zXz0tQhugW0w/G2nJ8wf7oi/ZJU57kjcuVJ98?=
 =?us-ascii?Q?7j3Px2C2NBBQTfoc03y/11zuXqS/FqgXLro983QNCW3aM9KteknRcIa4X4sB?=
 =?us-ascii?Q?r5cqB5jFu05mO2xCS23Q/r/TAyZtyfBYt4BZcwlgzD/SVWpV0yDH36SoSXTN?=
 =?us-ascii?Q?t1uOcSEsM6R8vUJv06bke8J2ud1FdWcyzDguDd5htBvAoOizOnGfSpv9yIc/?=
 =?us-ascii?Q?gsa0Ybtb714BNfEqo1IIGID6AhFc8UxsCNJZ1PeMPoU0F9OfhQxUbY26GQ7I?=
 =?us-ascii?Q?Q6pZt1+O8dqkBrR0EbhQyFrod+aw+e6uAUh+twXg1Jcda8X9mTpJE/REBv6l?=
 =?us-ascii?Q?wZye9pPMPlYxhZA49ixQhz3+cXRCGrgzsyuwT0DMnLA87/wDKhMIShTeo8kP?=
 =?us-ascii?Q?Poac1rWnKGW/2OImyxmYoSveWLhuTmM8njt3qYp9ylEmaMnW5dobhR8IN0CO?=
 =?us-ascii?Q?d537zgroOvf41XRE4Ap8oOVMZJuiQFwwZvaalXiw/en3Sh79jVfQIQ5oC+3x?=
 =?us-ascii?Q?rFK3xLBqG1Mh6tZ8XaU239qh/xvcX9qWaLzQan1M8+iHZvY6PCAiQZRK55Qx?=
 =?us-ascii?Q?JW+ilFNxqXvXHk6ZFNZumRMKFJBYCqSWb0NxDxw9xRtL/TDv6vuFjLbhV45c?=
 =?us-ascii?Q?Lo2EKBU1Zj5EWkJrpcC8LWfTZpcSYpBmne4uojqLn3A6vM+6lYOtWHfPgyHO?=
 =?us-ascii?Q?p31UdrweAVVAymAzJGQ1tmgSUcOYMc+WubCXE8TWiZhwjSIuRmUmMkt+AEnK?=
 =?us-ascii?Q?EqfejtIBWXAUmDYJKczHovcdRMmOAKdRh5fUuE6pidLM8Yamfw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VSHzIcWvuBkinVHQRpB5sw5ACK3Y9HJ4x+o06JCS4kndVutM7gs+IIXInHSi?=
 =?us-ascii?Q?Q/g2ry+Tf47hK0pj7FhAqabaFwgwLBP2BddWEO8ekjHZT5OPNe53PmkSbRep?=
 =?us-ascii?Q?BZgIyDhezc7a41t9MWvnOrQrFsOnDv9JNkIjK1Df4ZrTunCB5VUPYfewBWs5?=
 =?us-ascii?Q?Hf95YaF2UNzj9t03eCkTkIQbtL0XoiZxtnXdgWdOqVpYAYrsu8MterU6KPDN?=
 =?us-ascii?Q?Bf6PXDhrYBaG6dfuKSEVftUc2C5thkNjaFQtWNVTQ57ACT6ggFran8bVz5D3?=
 =?us-ascii?Q?rhQJ+dQQfhM8w1PuUaLOvVdgPchGYGu6rvJVU0Ou1pBVi5zu6OBKEsIDC9aJ?=
 =?us-ascii?Q?O3Lav7R62eTFDHTDdec5sOcUuyBPJH9k2DTRaBEDyL6Tx/0n0A+a9vEh4EmG?=
 =?us-ascii?Q?1INP6WW+1lxrzzdls05ppgJr7sXEPMNEzdSLJxv5T/QBve3J/KERE/RxNq47?=
 =?us-ascii?Q?a2pjXSDYvgDdOuKc9RdoZGCTFd7zByQtnGp8BSSH9qMFj1TKXbkvdSR6sj4u?=
 =?us-ascii?Q?0aifJ0WTdnqHghDxBQIXo4FiRLknuBWW5HbLAQ/jWX805fzrBtfO0RItDKRI?=
 =?us-ascii?Q?rKhS1EJtycNowx68vOlbsqpFgio/6US6g+V4JUWDi1NUneysLsM4CCu8fch3?=
 =?us-ascii?Q?Z9bfESvz/JQmTYjSZRFef25Ezet053kUk4GdfwP8RWUdEk25mhbBetmRGAGl?=
 =?us-ascii?Q?yxMm8rYw7EDw7Qh6Bzfa75Uyukw5/Z6h9zrRa/MCQTFn/BnftRrGaIwj0bsY?=
 =?us-ascii?Q?6h7B7M5XarUF+tNSVuRGWh8L4pEc29sQufe8XEe8GASThZ9tBtp8H2dQaUo8?=
 =?us-ascii?Q?jd8dZ4jCkBUXOChbGzzZusKhJOSSjcsTGYoIKvJCu2sej/jgQovilMtmV99c?=
 =?us-ascii?Q?yN7Wh+ui8BDWIwE94+RuwM+NEU6qdcDVQfZhTIr1xLQpMqOs7NPNvavHjpAa?=
 =?us-ascii?Q?lEVKtzTSAheJxk4iEmEY0LPRdIp53pboN7yEicJ/Dymx3K35P6W1nKlbuBGO?=
 =?us-ascii?Q?N8xQhKW/5/2D+6PPBfFt3aagZA3UUkBIxjt2broOX615PnJze315X43O/Nd2?=
 =?us-ascii?Q?EVVR1SM1nNAqt8+xc4i3EbOfkW+AMIqtUss2auw/YiZ8DoMs4UGlzQAQctG9?=
 =?us-ascii?Q?pHJvjMIOQdDfURJ4qTqxn6p4ukfGsNE7IxbW9uALOpO2zIeDStEdRF1n69PY?=
 =?us-ascii?Q?raQU23L4zt6mNOZTcmPQwqYyBGfZS2IKCElJnUPL9T1BuVCyye/sAWCdEvM4?=
 =?us-ascii?Q?so1+8Vj6m5ZXQ3aOZLrkvqbNvKjNVgt5GVJfLmqXAglQLLpkmBD8TUrHubwc?=
 =?us-ascii?Q?+hhzq5PnPIwx1AQ9f16bthZ8F7TPi5E0APycEfBsISN8V4JqyKy6VyEQIoqH?=
 =?us-ascii?Q?vLYXx/ONyJ5mcvphWEX/lh4d5Cs0EZS5V/Pb6tDX7wK3Bj2GRsCuq4zuk6Ae?=
 =?us-ascii?Q?6Rx6T7sKvhmUP0x8GcLBvB6wpUcMv8azkxMj57LjIk9RRzdHZqFZqb0iFIvF?=
 =?us-ascii?Q?B4oDSg8n6NsAT2HMlq+7GnH39OwEaQIZmAvA670XlHyFweAweu8UbN0kPUYF?=
 =?us-ascii?Q?dKd1ioHcOLn9UP0yb941xM2tXfpZet22IpeCnYil97JgDncn6k0JTkjvL+4k?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1xmUs0QDkqrnX6a0Xg+gpjNZEl8xmdn+IFHnhO401GzQbu7LzY7oeqj6VEPgGh8Q0eipPlBt8fUgBh8fx+JcLJrZ8RC9MhcVBadVlBaSmaJH5UjMuEJo4NOuyUqJiNqGTPn5Jjlvlw1DMLHD4vrortwMloEXgnbHFcrsPvW5z+4N++lhK0CzFCLXPKDqh46lD/eBTRJpk4rIAP6NqK6QtoHKHl1Osa3gpiYdLnjWyx09EWqi2wuBffHmI/28wX8WTTtaN/OiC8NpnCVEwFOzQQz3unu1ghxKdVzv7JYF2kBZaaJkSSQ0uJeIsIXIt5PVbaUSGQjybRJwp9cq/Tw3UQq3AIrnk4w3kll2Y4D6NcjFnB3pEQ4ogvSPcsJy4yFyd8gKPbEyw0STF3brRcuVAwriuA4Bqr5IhufxvciU1tMRDvhEtkKvwqWasNp3BydVYNbc4yyomZlOmdVZJrD0idxvZxpTXxEEc8BVTJDk//MzcSP+Pp9J0IH4nz1KHWlaXqVDAkH0DpRPQDXz95CzJEfF5mV1Oa9KTeZKiAXrpUvFDXs7JffHDy3KW3UXabEW4f1lN7M7tLzpmPMCUSXo2JpemNFfc0rpTci9QcvzUn4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e522ca71-a847-4836-92ec-08dd3020cb8d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 20:12:37.1331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rqcEPHRvVd5DHHAfqdhH35MXzUMpTDk6i8aLMQoYbKgi/lNPFGdCYBA9IygkUauZUFSKLVTg3Bis6+KapYaJuqszw7yj7L+AIB1E5rzTBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7569
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_05,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080164
X-Proofpoint-ORIG-GUID: UynBoyE9nX3EmolMZFGn9nMwQKIR7V_3
X-Proofpoint-GUID: UynBoyE9nX3EmolMZFGn9nMwQKIR7V_3

On Thu, Jan 02, 2025 at 03:32:49PM -0800, Isaac J. Manjarres wrote:
> * Resending because I accidentally forgot to include Lorenzo in the
>   "to" list.
>
> Android uses the ashmem driver [1] for creating shared memory regions
> between processes. The ashmem driver exposes an ioctl command for
> processes to restrict the permissions an ashmem buffer can be mapped
> with.
>
> Buffers are created with the ability to be mapped as readable, writable,
> and executable. Processes remove the ability to map some ashmem buffers
> as executable to ensure that those buffers cannot be used to inject
> malicious code for another process to run. Other buffers retain their
> ability to be mapped as executable, as these buffers can be used for
> just-in-time (JIT) compilation. So there is a need to be able to remove
> the ability to map a buffer as executable on a per-buffer basis.
>
> Android is currently trying to migrate towards replacing its ashmem
> driver usage with memfd. Part of the transition involved introducing a
> library that serves to abstract away how shared memory regions are
> allocated (i.e. ashmem vs memfd). This allows clients to use a single
> interface for restricting how a buffer can be mapped without having to
> worry about how it is handled for ashmem (through the ioctl
> command mentioned earlier) or memfd (through file seals).
>
> While memfd has support for preventing buffers from being mapped as
> writable beyond a certain point in time (thanks to
> F_SEAL_FUTURE_WRITE), it does not have a similar interface to prevent
> buffers from being mapped as executable beyond a certain point.
> However, that could be implemented as a file seal (F_SEAL_FUTURE_EXEC)
> which works similarly to F_SEAL_FUTURE_WRITE.
>
> F_SEAL_FUTURE_WRITE was chosen as a template for how this new seal
> should behave, instead of F_SEAL_WRITE, for the following reasons:
>
> 1. Having the new seal behave like F_SEAL_FUTURE_WRITE matches the
>    behavior that was present with ashmem. This aids in seamlessly
>    transitioning clients away from ashmem to memfd.

I do appreciate the background and of course this is the motivation for the
change (and I appreciate the transparency), however it is important to note
that _any_ company's internal tooling is of absolutely no relevance to
upstream.

All justification has to be applied in general terms and be what's right
for the core kernel and all users.

Hopefully we can achieve a happy scenario where your aims internally align
nicely with what's right for (or at least not harmful to) upstream, but
obviously justification must be made in terms of the benefits of this
change _generally_.

>
> 2. Making the new seal behave like F_SEAL_WRITE would mean that no
>    mappings that could become executable in the future (i.e. via
>    mprotect()) can exist when the seal is applied. However, there are
>    known cases (e.g. CursorWindow [2]) where restrictions are applied
>    on how a buffer can be mapped after a mapping has already been made.
>    That mapping may have VM_MAYEXEC set, which would not allow the seal
>    to be applied successfully.

All mappings have VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC set unless
explicitly cleared.

I mean this fits in again with the whole problem with what you might call a
'raw' seal and what I addressed with my various patches around
write-sealing - that is, unless you explicitly provide some means of
clearing the relevant flag on a non-problematic mapping of a sealed memfd,
you will simply _not_ be able to mmap() the fd (but rather have to interact
with it some other way).

This feels honestly like a design flaw and really as if the future variants
should always have been how it functioned but I may be missing some
context.

Anyway this is a side-note and not really relevant to this series, per-se
(in fact it argues _for_ it :>)

>
> Therefore, the F_SEAL_FUTURE_EXEC seal was designed to have the same
> semantics as F_SEAL_FUTURE_WRITE.
>
> Note: this series depends on Lorenzo's work [3], [4], [5] from Andrew
> Morton's mm-unstable branch [6], which reworks memfd's file seal checks,
> allowing for newer file seals to be implemented in a cleaner fashion.

:>)

>
> Changes from v1 ==> v2:
>
> - Changed the return code to be -EPERM instead of -EACCES when
>   attempting to map an exec sealed file with PROT_EXEC to align
>   to mmap()'s man page. Thank you Kalesh Singh for spotting this!
>
> - Rebased on top of Lorenzo's work to cleanup memfd file seal checks in
>   mmap() ([3], [4], and [5]). Thank you for this Lorenzo!

:>))

>
> - Changed to deny PROT_EXEC mappings only if the mapping is shared,
>   instead of for both shared and private mappings, after discussing
>   this with Lorenzo.

Yeah I am happy to continue the discussion on this, I very well might be
missing something/just wrong here.

Security is not my area of expertise but I do need to understand the
details of the attack vector to be convinced here (we very well might need
an 'explain like I am 5 years old' deal here).

>
> Opens:
>
> - Lorenzo brought up that this patch may negatively impact the usage of
>   MFD_NOEXEC_SCOPE_NOEXEC_ENFORCED [7]. However, it is not clear to me
>   why that is the case. At the moment, my intent is for the executable
>   permissions of the file to be disjoint from the ability to create
>   executable mappings.

Sorry for not getting back to you on this, holidays intervened...

If the vm.memfd_noexec sysctl is set to 2, you are simply not permitted to allow
executable mappings _at all_.

see check_sysctl_memfd_noexec():

	if (!(*flags & MFD_NOEXEC_SEAL) && sysctl >= MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED) {
		pr_err_ratelimited(
			"%s[%d]: memfd_create() requires MFD_NOEXEC_SEAL with vm.memfd_noexec=%d\n",
			current->comm, task_pid_nr(current), sysctl);
		return -EACCES;
	}

MFD_NOEXEC_SEAL naturally conflicts with a future noexec flag.

I suppose you could say in this instance, that any system that sets this is not
compatible with your flag. But you do need to address this.

>
> Links:
>
> [1] https://cs.android.com/android/kernel/superproject/+/common-android-mainline:common/drivers/staging/android/ashmem.c
> [2] https://developer.android.com/reference/android/database/CursorWindow
> [3] https://lore.kernel.org/all/cover.1732804776.git.lorenzo.stoakes@oracle.com/
> [4] https://lkml.kernel.org/r/20241206212846.210835-1-lorenzo.stoakes@oracle.com
> [5] https://lkml.kernel.org/r/7dee6c5d-480b-4c24-b98e-6fa47dbd8a23@lucifer.local
> [6] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree/?h=mm-unstable
> [7] https://lore.kernel.org/all/3a53b154-1e46-45fb-a559-65afa7a8a788@lucifer.local/
>
> Links to previous versions:
>
> v1: https://lore.kernel.org/all/20241206010930.3871336-1-isaacmanjarres@google.com/
>
> Isaac J. Manjarres (2):
>   mm/memfd: Add support for F_SEAL_FUTURE_EXEC to memfd
>   selftests/memfd: Add tests for F_SEAL_FUTURE_EXEC
>
>  include/uapi/linux/fcntl.h                 |  1 +
>  mm/memfd.c                                 | 39 ++++++++++-
>  tools/testing/selftests/memfd/memfd_test.c | 79 ++++++++++++++++++++++

I'd like to see some documentation changes too.

You need to update userspace-api/mfd_noexec.rst for a start to reference the
issue raised above.

But it'd be good to actually document this.

It'd be good to send a follow up patch to the man pages too should this
series end up landing, but we can come to that later... :)

>  3 files changed, 118 insertions(+), 1 deletion(-)
>
> --
> 2.47.1.613.gc27f4b7a9f-goog
>

Thanks for chasing up with a v2, appreciate your hard work, and sorry for
not getting back sooner, have had something of a backlog... (and it seems,
this shall continue, indefinitely ;)

