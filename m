Return-Path: <linux-fsdevel+bounces-40658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A149A2640E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 20:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50803A6F5E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 19:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE42020A5E8;
	Mon,  3 Feb 2025 19:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W+HJXYWT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yjCUCyKN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591FA7081E;
	Mon,  3 Feb 2025 19:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738612329; cv=fail; b=XH69qxQZA2UEaZwUckW7iXLCWp31ZBXjvtGUXTv/JTHLFJ9exnh1LMmpPCUKzorq0YmZ/OBKKOBCD7ZwydxhuqFDJBM/4n9LvGFYf8dpJe8ZnpZ+BjZN3/3E9slYyvGXD2z9PT52WQA2V+JPZHxGRCYKK3+tFu3Bg7J0Puld6gQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738612329; c=relaxed/simple;
	bh=ohW5wmY7u07c4zhTZxKu71Pi8MNbhTcjYiowj7ejE70=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=o2r+JVYj5ywo4LUpl04otU3Sz1o1U/KlDAACyWVozM1hXOqg71V2jcHfZhBO4hfk+vfC04cQT/Rlw+9WmI7CIJMjPn0IFs6o008MtUE4z+VmlLsmgwnE3zODwaZ48ernkBgK3v4Epr4mc0nYpIHk1XWW4b2jnNO8p+6BF4rCMdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W+HJXYWT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yjCUCyKN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513JMrfC001552;
	Mon, 3 Feb 2025 19:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=njKI9zQ+qVdICn1+ON
	R+5ksVF9jvJZjNZKME1936aFs=; b=W+HJXYWT8OZgDELY74IJDZh5b6cy04w967
	CaEf6J+KvogZAhJNufjbRdc10iwa0NaMBDIrC28obgg/28qMkExCdNYKZHtfAx9N
	QRJSVrgRztF04FgPnszY8f3xgb/wRbGm3IfIP2b4pGFhM9P1UiBXjQ4yMeTQhH2a
	kIcpaO8UWktaHOGU6C4uODxVGZTCauPGG4ilUu1bXf0XrMs1cA5ym5vmLra7S7zl
	Gt57ut6Kk3UJv152+LwxManLqLDzQV4DNtH1caDJbRebmJXjvmcGFo/UPTa4GvUI
	OzcSOuqhbFHXRqMGTP7q6o9TFDSjQGO9turRRe7/CM8CnMvvvTHA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfcguke1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Feb 2025 19:51:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 513JXtSY039014;
	Mon, 3 Feb 2025 19:51:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8e6trqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Feb 2025 19:51:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMnR8ppy+7KOYPiAzBo6dKgcCJxcadjLYEVGbwP8V9og9nyDRZUnblsg7Q7sSRgI+DYwZFPDEEyhCm9AMPo2ma0SBnqn9xOlCxg8dy5JsMh4M3sawU6SOnFva4bBI92ctfLhKbcSYsLDvz0TKcY8eQkw+XsPyaOOk/fWgOWx00ZELs/Tb+K4SG95NDWhI5NzNxFM47qTqB0MYhi39cntlymEBP8p9iAR92QSqPOjJEHxqGNN9rOlj5lu2At0OtHmalFTacIRcgqJkAePBEs5Sga/+iFqJyQxL/RY06ecPHwwk9TasEaxARNiv+dlP0Y4Suq0Wro4wTK39T9H7rKWgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njKI9zQ+qVdICn1+ONR+5ksVF9jvJZjNZKME1936aFs=;
 b=YwxtlVvhSbuGpBYSBEokIaRft3UbjPdUnhYBVpSiRVi9hKqyEdSQLHsaDUdLw24FnDLx50OSypTc2Z6dWlEz2x2G0TCHixmqvY5Rh/L/g6K2ADd2a5RCqKTnrmtFeVz7/XDZZUw++JWkfOl13vrJQrOBeybhYHhc5Wz+wAtsWRyUY0LgOwqFf5FY/k9nzreo8h7UT6wG8wWbzt6S+23MJxwqUoiIm1/N2O5woH2ItZ0ZoIbbkGS2ZoQIVqyl5XwYxfdpUWPnDHga1SbXHZCGmP7yAvevLQECxBEzBW9yE4IHbrMMAonhEdkbFTEwvBgk8hyA9yxA4dcO3uiXdyoqzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njKI9zQ+qVdICn1+ONR+5ksVF9jvJZjNZKME1936aFs=;
 b=yjCUCyKNCF5VUm7I6nbwxPPv4SnuxthFMDFrDbAByikjkMfHNa8jA8XLR8Kf5zjWulF8HX6Ofv45kI3PTaLqhr8QDPxdVOc44BWKkOTcoKzvGv6XQdBZ2YVU+ROZTzACvT3kRL6no7uwKXyFGDgS2kYSM/1IuHPTvD3lCFfOn8o=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SJ0PR10MB5765.namprd10.prod.outlook.com (2603:10b6:a03:3ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 19:51:56 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%4]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 19:51:56 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
        "Martin K . Petersen"
 <martin.petersen@oracle.com>,
        Johannes Thumshirn
 <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Goldwyn
 Rodrigues <rgoldwyn@suse.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: PI and data checksumming for XFS
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250203094322.1809766-1-hch@lst.de> (Christoph Hellwig's
	message of "Mon, 3 Feb 2025 10:43:04 +0100")
Organization: Oracle Corporation
Message-ID: <yq1ed0eizah.fsf@ca-mkp.ca.oracle.com>
References: <20250203094322.1809766-1-hch@lst.de>
Date: Mon, 03 Feb 2025 14:51:52 -0500
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0466.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::22) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SJ0PR10MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: 0842bbc1-3378-4fb3-c94a-08dd448c368b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bmCNTdlfEGmA8EBM2kRBz+VgBnhxEwIh1BgCwhOIrdQczniQNlhnWIM6vMH0?=
 =?us-ascii?Q?slKDbJiHS/cnZ5RwfZjj5Q0hSW+rZUTFg+rWzKlfs3ZPa37oK++omcqeZApI?=
 =?us-ascii?Q?DITb9Yaes6KxyeUZOe4rVshYx7udGzM157kaPkHsaUSQOwQKXL0vNTYkyoPd?=
 =?us-ascii?Q?w0mX5pBgYpVN5MWcaiXdbjlqia1MG+yGcm7a0X4Lv5TECTx463mVaVj3YIEI?=
 =?us-ascii?Q?gFBfgLF2NFrySyL6H+kZkjXRq8qy+0eSMtqYV9b2i3Cqt+LSedRGgMepSY6l?=
 =?us-ascii?Q?K89iRYHWiKBurCWg5CEigu2dOBEjuqIkLYv+xlL74e16hogao34Mf52tOD1h?=
 =?us-ascii?Q?eSJEBW/C+QFbKab8fMQh+T8TjwofK12qefjW5yX7/YBvoWhgkWjn/ydvg5M9?=
 =?us-ascii?Q?p5s1FkOp+aw6BtBNl9JSjY6mr4CvSZ744JSAgtKYtiVqkqad2zUOVtABYAi6?=
 =?us-ascii?Q?8lAJqqRbX9Ht4PLqfpe40TCTjKs7s5wGeZy2yhWqCQ/FFuGrDE68NZezSY4e?=
 =?us-ascii?Q?ar9o0c+xxRkMmlScCVKPL16m5d5i7dvx1UdiQo3Ccm/2CCy91dVFToVU7yR1?=
 =?us-ascii?Q?J0udry8B1wEtkYKOs/2uFwHqvVJEMKVZiZrVOExssQFrT9ppKUjKoHA9l43A?=
 =?us-ascii?Q?fVC5IPI6NCM91qKpmJlI9hZoLN+jR9MAG5nn5bgBDvr4m/pNkUDhJtn42qLj?=
 =?us-ascii?Q?ACv7T0FqK48Kyu8nZ7b8v9CzHFiuxhw4oywTfN2+76vix2JWJgk+8kzZPG7a?=
 =?us-ascii?Q?hyKdZUITBH+zwHOZxY6fqwpbs2B8uqR/SkItUG5fgovk8govlVGgcS7h+3oG?=
 =?us-ascii?Q?Gj9roVF202A4hY+15wOxVHfCEKZ+aZQaNbGi5D9c9BWzgLwHVlolgkkepDSY?=
 =?us-ascii?Q?aMKUE60UzGpucG/AUewv6L3tPz+nu3peGijFpwoycWdQevXKpiMpH7PRX3z1?=
 =?us-ascii?Q?5mO4E9S1MKGaqt1SvozgliJZJLl1vujbEXFJLEWzMseHjt1WnP7mFGRnpaLT?=
 =?us-ascii?Q?MOUGuEcCvJQaI+sHbgoQ2kbFjNe/uEnP+ZTj6TzEtDPAAJ1oR8tm50ZnOxO3?=
 =?us-ascii?Q?21UyyF6rPz4VQvs13kSJb4/0AT/W23hYT87gmn5NlEEm5zulQJvKbs0EKzwF?=
 =?us-ascii?Q?eFVk7yt6mOlwFzVcwUPAvuDN9S8fNX0HYb1QjQdH2jw045j0jW07uHbcqbwj?=
 =?us-ascii?Q?YAsS9kBHVxRMaD/idxaUGWnii2fLZBPxvcauwNCcGs0bhCvYo+rwcRGf3HWu?=
 =?us-ascii?Q?ZLgAVdtaYFG6G9OFn2rvvh+Ctwpn4+648oz33xicTT5pH4IIDPYjhBLRMqZq?=
 =?us-ascii?Q?Z1ouOv47lEkv9eUlyIAayRgumbdUEaSTOEYYAWrH3PgM2MxMN3FU1xXL2mEG?=
 =?us-ascii?Q?g+NO92MuugbPCSZLR6V7VSGVVgiE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cFHqzu1vdB0buL04izerB9kI6WODGB+zKfjife2f+Y2AAF6xhQoet+9mQSaL?=
 =?us-ascii?Q?syYJ5SZ9+Y2aXHxjwDOlobAgPsANwzYwkfUvqQPA7Amow75lb4CJDMm1xadb?=
 =?us-ascii?Q?2C9rttrtkFYGK3T1pBdhPn4jgnncTrnYkc/O84n0DSbfJHgPKY+iPlwlD8fK?=
 =?us-ascii?Q?UL3+nsX1xTl26StSvm3eLzFqCtA5VfFdAvjI7lepGSWI3CYCbuQ2jBj96w74?=
 =?us-ascii?Q?0IZaE12taz7rh2zatQJWXvW6ndV1J015qYkJ0HFGKWvG06tBxAjJkEj6IVyC?=
 =?us-ascii?Q?VjFn4flLhyaJ8HzN+be41GIfKDdCM9ifNxj5jTsHaznvCjIh6Ts1GEbOf4r1?=
 =?us-ascii?Q?HdyMnr/Fp5/Y/s5qMcKFdu3EDCRb1OYeSsfQLUWak168Tb7/L8TX0JEe3be1?=
 =?us-ascii?Q?y3fwp1gFjBsAV+cJ5WVxstUO5bLxKbkdPbI4XfsmMqbIHpVccfxHPxnRsnXX?=
 =?us-ascii?Q?t9xtrRLbkqpA4PMc4sNTB2xiN1iMUODygQRgZyf1JtfT0bnjPXQq5wlWKQGT?=
 =?us-ascii?Q?nb8D5uSDg95UEzrcA47T9bjoctq5TcG3is/dOvrizyhTC15uPqRYy1NFeIvK?=
 =?us-ascii?Q?0KTBoVFSOwJxUHZkERNLJmpqZJ0wbTH+plX7zGc18j2LHewNlz+bC6xuvItM?=
 =?us-ascii?Q?khRcP/d/suqY3V035HG0wGmalS0o1ImkWRx+ct6p0nrui1pcVgVRWiAXN713?=
 =?us-ascii?Q?7SMYVb7lSpCm/KdQmQBAK+r1Q4bmwcSk9f8XnTRKmvIh3bO21c2GoBfH7VoH?=
 =?us-ascii?Q?G+6xgp9qVIDK8bLzYqbmdLuy9c/1ZcYHCnI71QaQHOuJKRG9moNji2iPD4kx?=
 =?us-ascii?Q?0t125HieG/OHrE9axkncjH11hStBfU7vvTWB/eGfy266izyeOPmgWuomhH1X?=
 =?us-ascii?Q?31hw/Gu8xN6atZHx4EOaTjseU4rin3DjN4h74SRAL+Gz5JUHbLXoTspfrpOh?=
 =?us-ascii?Q?xn3/W0M7Ko1QUBgNz4xYs4bjq8EJZHhcVrmZgJ4l7HQVKfJ1MA+CbCuZV66/?=
 =?us-ascii?Q?03rBlZKGd2binxcg2rqKPgOvbDlQRE89h0KlN9kCQnQLaLrqyTZ+tmaxRbmu?=
 =?us-ascii?Q?rLBlnrp4M/tr4mpxRZc+Cf3r6VYp74B1HOW72UvO8+in/euZDXm/g7q/sa8m?=
 =?us-ascii?Q?fl9yNqNlWmh7Ox1ROz9NAwBch59339DRcezY/L53/FQgAC8xvoQ0GtkK26Gw?=
 =?us-ascii?Q?NDPbfALFg9skkG+0Xw4diJrVT06VzDKK40roVte01nFS0/escjmoA91vdFdQ?=
 =?us-ascii?Q?JOjVGf1hckQ8uMTt6HVNvBFOJh47BZiOtePaK3bmzB03U+dEjDAyXEyQyKPO?=
 =?us-ascii?Q?pApTsEWRymMWCBCQJWNe9NDdRhIJN6NSg2L8cJSHuIRjMqSmvDBZkjc86mvI?=
 =?us-ascii?Q?gnPkzj+GI6AHn07xXPxQBjv//G6SsbNC8L0CE5kto25OBcti//aHJYM3+o0z?=
 =?us-ascii?Q?btuVzU0P6ViWelQ1xPW3et3GufHSpmdYKrzSOmNiKqoyTSrsZY09VN9uYHFI?=
 =?us-ascii?Q?kifobvQ7xCqhGGTm+ao82kbSMSI3WSqqnXLeFaUGp3UUQYcOIh8UDC1VmURI?=
 =?us-ascii?Q?FRZdcLXA0sfgT2B+76TRxhBQ6l6vg2sqBt8aA2VQ47L2ADDjC7jSyPS/7uYD?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aBC7PaC6PB4rhirZEmdvSBPBgIz1vrGhUREfmj4ZP1JTpTJos8FK4ZtyMocj6iDyFS1lsLhzaSrbEasTfQBHWlUTy2Gk0azH/TqVju9qc83xZndfFpPysMpUDxQpEFi4fnQjlq+YL3yr2QwdbU3EGaB6E7r/KzJTxoJhyB9oquV2i2N6dVogLKhKOIkIo5Y5Tc2HqZQQCJU91MYNYIMHfgjEOmlJeR9trg5ZvXDXhk+VmKntickgskHd9PW/igWoASH30l29oKU/iKqVm+pw1bk/M3StsL455/ppS2RFTP3icklt30YAn+AZbgY0F1zeOj4ZklCECiD47b+mVueMDlAP23Ag2rKTLx1H9J/vPRjzNr4oHkyqxndizgqgyy3YwuGg19fx1opT9BaHEAPVjZCEIT1IFDrENvSMDVV8un0n6Rg5lSw4MwnBy++NpTnxglu2P9kLKpZ3d8sHjIltb/WUYdtLFGAicIEe2kSQXq8r+BBeTNPM4oVI5vZNHyqbQT4aY1hAXry7Iapi4u6rQ9VZUD7wYhHIp2OSbYbPK4A+sjxBiCpz6eKCRotlZq18B92Q22x6gx9LX+iwy+bJso+IvhCVOxb7vxDYeHpIC4s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0842bbc1-3378-4fb3-c94a-08dd448c368b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 19:51:55.8919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WEdbAFlIEcKd3Mw3sytUr7bRJ7i8BKHQfrSotg9ry19ijVgqc1wKv3dpggB/hLutC3iIlotpV1Na8UcYF7D5Cnoz+Cvyaix1ppqkgWGDBZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5765
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_08,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=754
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502030143
X-Proofpoint-GUID: Vf21QrsGRmdz1DYVwLNXX1o-HXkv7a1X
X-Proofpoint-ORIG-GUID: Vf21QrsGRmdz1DYVwLNXX1o-HXkv7a1X


Christoph,

> with all the PI and checksumming discussions I decided to dust of my
> old XFS PI and data checksumming prototypes. This is pre-alpha code so
> handle it with care. I tried to document most issues and limitations
> in the patch, but I might have missed some. It survives an xfstests
> quick run with just three failures, one of which is a pre-existing
> failure on a PI disable device when creating dm-thin.

This is along the lines of how I was originally intending the integrity
infrastructure to be used by filesystems. So I'm happy to see some
momentum in that department!

-- 
Martin K. Petersen	Oracle Linux Engineering

