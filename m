Return-Path: <linux-fsdevel+bounces-54649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDBBB01E2A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 15:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77FC93A8154
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 13:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC83C2D8385;
	Fri, 11 Jul 2025 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MUoakGBn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZKku8bID"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D26129AAF5;
	Fri, 11 Jul 2025 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241605; cv=fail; b=Ex5REPohEkzOE3HVghRMC+1WkviSes2sjv3ncGDgtEUGG7J2iVtqJUP6ENu5EvmUnWY/J2XGGcT+549N7AbjHzsv2/5aUZJ6vbhMyYFMeFf5lP1Hndm9lmaU2BRgGh4yzY1ETT276vMHp7dSZyP6/DqGobhdXGFh/XJkxYkTBSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241605; c=relaxed/simple;
	bh=pTJPpyFa0UTePYgOG45/blDUInVk2FAKaE+wNxaWjH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SENCNT9+5saJY+/wDz585vfY9fc5/86Djna2YzrBfOy/X1Fw7x4sEa7nzXMa1MSn6JHl7ijufNUEdT5SNyGUvtNtDJImTktbPk5ycuhH9UT/jvfOwqx+YssRj0mMItwTaYrQIFW7WNGw7WIjWBnowYxATIIOQV4MM96jsev6GMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MUoakGBn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZKku8bID; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BDR9E9004552;
	Fri, 11 Jul 2025 13:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ndLSRQZvz3+L+TkUjA
	yX9cDjTFXXcUShMRGHzW329s8=; b=MUoakGBnKXqsLdF0AHSfq2XEuyNKdy2lrP
	/2n6MEgMONcEQ0dLUGC9tj8od007sfkZm2SGPatv4Ll8BbeG/CegtUlWZ6zV0Sgx
	7hMXCJYfls5fUcodubLdn5yXGBLu57QnVXgV529any/mTUooQHtIYydnlR0sBwLh
	fBf6pEeini2UZpSDMEnfBPAqbPrej2sV2fOCFtP3SxWidajEjjpEGGBnl8Y2lNgW
	Bs5Qsuaiyn+63sXGw3ibMzVoQ+25SELMb7GFcXiTUV79jxlh7OPMLPOGh3E0OGSQ
	980tFbHuiw0u4KOPRqDXz++FXKUTHEBipKeYL/dfzOBM9Jb8x7dw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u3gk814q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 13:46:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56BBhfJW014439;
	Fri, 11 Jul 2025 13:46:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgec1rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 13:46:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYa+eav60ZG/WLtgsm4WrYNEqtfBy4DaIVBrV+gDKb9XIqcmri3uJ7CFiN8A7mcC3ibAod5sIPq/qQtite6nyrH0BKh/xKqTtusJdiXr7jvYSnC16sQTZjuq6LXyb1v9IEuwmPzCJbiqjAbk/OGhwE3ZV5/SH47S5s/QXyfnniE7tHzx8WkKLHlGpeUWuTbA+NUIqYWDJpATT/a+ZMhy4x/7ZPVaOtJHhx8d9H8JS4w7oGRi9E89sGlfd4QsqUQi2UbCZAc+XkdpZ1UGggtRjUQoOfWKg1i/dxMyHf9aEDfg0nSlYVVAgQdMgblLzzcMJLRpgDoR0pcPEs6RVNvgtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndLSRQZvz3+L+TkUjAyX9cDjTFXXcUShMRGHzW329s8=;
 b=pRBHZR8IrLjrTJNKtLOXUqW3qM8lqc56UttbpMim/NEbWXNi4+HN24/W1Rd1YXXJ4fgUrS9O+mlHaDw7O7I8H00E33HRHXI9GBklAVNVom/7006TmDxuGWcAnd67u0Cj/GbEgkjoYWMBnJizmpTLH5TcTjevkwy3cNXk7CDF8vuT7f/0jRRWn7ev+h+cjCv2gkzRles8J9knirZ2Nnx44N5XSNM3DHiHa08Byniva4LP11G7E+ARPjc6yv0r/FUtrqC3kERGRHczWaJjGLhBRbPrnuG4hjw1ESLvd+9/9ya3PZHkUCXUAS36DuPWs1gcsxTfD1m1jl1f+Hp1WNEzJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndLSRQZvz3+L+TkUjAyX9cDjTFXXcUShMRGHzW329s8=;
 b=ZKku8bIDKXjeJi/p3evrd5/rw0/UF6v+Z7AYjsHYVsLEtOond3bkDNTf8+6fBxwtk0p+ATQ6VN79finmdTlKV5q1AdCSzYZeHFJYQMbstLpA6Rgqs6nRxC/Q6ug/Fyl04gTaZLRA8TxTc6hPyD9HMaP+tf9sGkmeBNwIIPNMbew=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7399.namprd10.prod.outlook.com (2603:10b6:8:11c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 13:46:00 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 13:46:00 +0000
Date: Fri, 11 Jul 2025 14:45:58 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v3 00/10] mm/mremap: permit mremap() move of multiple VMAs
Message-ID: <eceb2cce-07bf-4187-af50-acb34525f856@lucifer.local>
References: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0601.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f7f615-fef8-4516-1963-08ddc08145a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eLwGyUQfr4OszWJLUuDg4c2Ne3wrhbkuRU0Z+5G7K9mMIFFGRdUxOYS/H1qp?=
 =?us-ascii?Q?ga2972oo9n5DreSDaa9RFNBwhQ/A58lVK0XIdhRNyTAvMP7LX1Aw4XEsAJ6M?=
 =?us-ascii?Q?U9HPJ8AVLpDRXXouFU53v+IzJKYUbKR3qPrN7PzTEHBRzYeZN3LmLGTspJS3?=
 =?us-ascii?Q?leaxInuaigtQqSPs/OMYXOAr6e/dbdMxtd/fy2jCMABxfj7qeqMafBba5j6F?=
 =?us-ascii?Q?XP6RTr1f8TLV54TAxB1nfAATAnBFtxK2czOlKDj9g20/PrjpMgGXKzxIoOxF?=
 =?us-ascii?Q?GDdkiA7O2ZhpENqUqqNVwqyXvuCEpboe/SDrtkUB1gRsKNLIyII2mVdlpIS8?=
 =?us-ascii?Q?1rjO4hu32RIzkKoyFurRrdbweGkJo3c8FYVHUAEyPIucoNa2BcDBK1qCnpKd?=
 =?us-ascii?Q?yuzzbGp52dzAxjHEbWSdX7EZqk/foefaHobIGMTKQ/ugk95cs2YMjSDy5mQm?=
 =?us-ascii?Q?JcWa7xtbtA40SKve5ZL7Mpo0yl+6UrMFvOU3FwEh5UH1tF8Z/cnJfbFvaj3e?=
 =?us-ascii?Q?m2gCM7Dc4yLd/wWLRFECUSvr/G35glSSa6MMwJsOtYPqr4fVy+uE922ka8cT?=
 =?us-ascii?Q?umJmRIC+1zMOqukLhN5l8q5AUZvOt3dtgfHpzCKUE8p/8ZiCf4J6r7zFyJIM?=
 =?us-ascii?Q?Oh3X2jCjWfpsdP2acb8DABuKEKPp0l+OUxcqcDe/k4KTR/Wv7VNEig3hLIBw?=
 =?us-ascii?Q?qB4r/EADSUCZZ98WCK2NEyk3fjfBVYEqhmi58m9mBuFTxH74PoXH//LgZWVj?=
 =?us-ascii?Q?/CwpW2QwZSfVW4oLtn8610K9Tua88U1mesJs/N26kC7VvOpE9Z2sNfx31CUw?=
 =?us-ascii?Q?gfWdjr9B2T86NyvE6kE2vnxs3fxGeXPXHlJZsm2g8eB+H6qFC5AbEtvVmpV0?=
 =?us-ascii?Q?9JUKow1u6YoAAOZFsSQRj8mM65arMOMOSw9goDxHgw6fzUE12i0I2S5wc6WF?=
 =?us-ascii?Q?IC9onFANttJ3roT56AF3eo/+AE5A9WErVf7ExHgT1eSWP48AkdkjvU0BF7Bs?=
 =?us-ascii?Q?vtNQlvlGaue4hIoE2XTAI03AbIh6lMc6xY6NFMUeeTCsnJxIHrcLFoOS3oT5?=
 =?us-ascii?Q?OlNA+HSWTpInAAYGZmfzvh4yOwonmbpMPkcnwgIOxE/csdttLwhbDh7Nsg+Z?=
 =?us-ascii?Q?QBLwW+B9hiwz4uLpPD6lEiWWDa9f8NdXixk8u8HnoAZTUWW9/SzYqqLP9TIO?=
 =?us-ascii?Q?9WNvDm2NpefXDdUhzz5lgRc8hM+XoWP0QjV4j/5Iz+R498mc4akYntTG1elB?=
 =?us-ascii?Q?x7A84iltCZRTOoDYoD5uPx62IMaSV1y9Oj+hL9Mv+4OEriBQg1Wdo0/RK9NH?=
 =?us-ascii?Q?RYyH828L0jQNx2HpzR8Kr27S2sTKzOdPD9pjJoeTPTqZ5cHezOp63E9QecOS?=
 =?us-ascii?Q?yiXJ4Pi5FO7ew/LE8ChLKmYT+2GszGs9O3xOqXzilSdB3aeWVRsplUiJLhd0?=
 =?us-ascii?Q?QLvQVmtJ+wQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iQVRqLKYqeJmiJh1VFNcm60vi+7EaA+hI3tyQ/dm4D4ggZEMbEW7/2PYO3ql?=
 =?us-ascii?Q?bwACjckb6UrvE9fQcagAA0ukdgSj4/jL2y7ZWUgkmllJD5RmwbxI/yGEMq1H?=
 =?us-ascii?Q?wCspjl2juxv5oxqQ+Oj4qWlZQOqBi3I39C3md69buaOGvils6mrIheduRA4J?=
 =?us-ascii?Q?EI72bFNTaUspSiHrgOETXNiDPKlZ9fAjgLJ5gPtmFxewcPPpLpODUabQFF38?=
 =?us-ascii?Q?aJzLqls7KCu3DpQ5qdp4l8EbrR+z19AWv20My0UOVJiIdGFCRG32kpgWEof3?=
 =?us-ascii?Q?UbYz6wPRPrJkKElC/6lfP+/a/yMLrB3A/fzt58CCNMUAPlMVuQmsrVZMpooA?=
 =?us-ascii?Q?4cWu4e65Clp5PSIjR0gVAv1Kw9AvjxJ29Y7X+mt2b6wYnHTuJwXd6YAHmWc+?=
 =?us-ascii?Q?+xabxnhwwz9aP2iDgDxy4qJIlDtYsGqr+PAI+rU8IjfN/Qq+elIcybRqvkAF?=
 =?us-ascii?Q?UGLwOLC9s9704SSIWroebZNJKmKt5/gLBn8xrArAxPKdY5YXWoIKFj87uNgv?=
 =?us-ascii?Q?AXOOLCMQl2nGAyzre1uOmMQZHCCMjdGVJ9B+tUsaPT4+JDpnpzJQlXvWAYwM?=
 =?us-ascii?Q?g9G0UgXA/+wKPE4KVxiANv2P6YdO0YzILyIP5PkQR5nCnwIM6KM/Xc0ZPsFv?=
 =?us-ascii?Q?2FXf3eaPT++jGv/hcOc+yU2bxu363hT8UyFsNt8Zfj+rnQpgMILeIScm1fmm?=
 =?us-ascii?Q?ZLPr/CKIWSef92SO2wc9Drsg9/cjx6wwJn+NkcXh8SHiqUPntIMOjX9GKapK?=
 =?us-ascii?Q?uaW+CVe/4P6njFpZl3il+kjKVdaWNDns6Lc6JioVAb+OpgAYqTZxA6pxDYbo?=
 =?us-ascii?Q?B/qjiGIYYjcdgQSIqZZoz463w28VluHf1m7IRbnM0tJ4t9N5s17Pj/56am2V?=
 =?us-ascii?Q?c0HFxz4LUWNqptu76P2I2hRn012iIjIVHkXGme55KwtYZLQmTb2idHz3chpx?=
 =?us-ascii?Q?tghijOE1U6SmLKy520JYeoNgRu9NODDEEvLibrWUOTXwrBuPf2pwoCh40k5m?=
 =?us-ascii?Q?qZP57Dyw6Fu0WApBv2wnqGU50slfEzL1NMes2UYcfwc+59Gmyn8TD1YDp7V4?=
 =?us-ascii?Q?NnmhXczw/UqZXDOr8amgfE4MBbYTYsfNMSgz1uC3FAMY/NtuY0Q6ISWEQ/6X?=
 =?us-ascii?Q?abyJp0Gb+IkzRat0+Mao/X13BljggYcHUn2PSTRWtGnn3QWqMiX64Ucs6PuS?=
 =?us-ascii?Q?jTpyLh1qqQrycrqeirws/puu7cRDwmBNmJeKnrUosDArMF8lYhtuMUVDUXrx?=
 =?us-ascii?Q?M+uLFy7sl3rbr0zo9DTtsnvygTN489yGjfEMs7dOlOn9XF7mGKDGB8/kT64D?=
 =?us-ascii?Q?k88AevKEgLcORrTh3JDHqFds7tDH2776dwsA962yKBJtojGuoP+fFDe8obLu?=
 =?us-ascii?Q?oGkabWSY9E3Vlv9K0EFICtricDLz6RfkCHp+g4ymiUMbCtOl4OGi07J1uZ+J?=
 =?us-ascii?Q?prTLqGtlYzy/rrobHQVYD1J+SaPWs1X5ziV5GX1W5z+30zCdUyuGvcwQXJLG?=
 =?us-ascii?Q?aNsUc+UwIZZpNI2sM08wcCGl6NaptSYyoan2mVxODHZxzBkKv7K68Ikt4CMK?=
 =?us-ascii?Q?Iy5IrtHDu11PUaiWaKHuWTIZE6aw+m2TaVvQoVS/6xANd5qlPEMnEvzcj81g?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zQr16NpA9BSQwAycO+qFN0DVFpUeZth8Gfw1DcBxLhgsn5Mdp2+l5+TDlSoBvu0xSGboSTDe1XSAGHqeyaLKgEbPkifffna8Xu2cFACNZEruKF8LNpg7SvI+iPFiUEi1/VrRNTgcenq95Tgefhwf3oa2GYIwURc8ZUxRA2Gws6DtF07DMF4ZOmHo/h7DZa/30fG+lJefQTjLzNqiVyQvKWLqolVca3SaFniItrHRTrdEIsYRzM9MJ/6xjWyGgMP1qAuEayId+qVLDrQfJm49hYUJjZuzSdlkD5mkAops8tYCZfo4IR0PnnK4TYuMss5wZEUNqVkRtP/85a055tX289uZ0LuWOfagZIEeRjyIpUP2rOSm9Ub/Ty8x2gCZNbBvIRK7iSdP0w1D/c7mbzqew0LO8h7fNQVqtBWOXZfPfkG335UxB/L7UsLZd5r01vQHovpHP5R+Hxdsqho4bVSvu8e4Mmj6RxpDzk2dj78AMbj3eJTOLlxVVW9Hnyuie0JqhDc0YiZlkz5mElGoW+b6sw0+C0uhZaWAygmE6G9Zw7ndTfMq/NhdTmnlkfUuQ9QegTdFO47h7cOC3IwTMPIXcuAXC9TSsLJO/sckwYRSyr8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f7f615-fef8-4516-1963-08ddc08145a2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 13:46:00.8908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldMAeAE7Z+tPOifeoWoJSn620M+8jUx5TawoVCnC0tkd1/NfIeORq0s+yfMojIwNrrMTKnQXcmDJSUtkNoHvH2xFmzn9VB02rMDmujFDXog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7399
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110097
X-Proofpoint-ORIG-GUID: Y08li79oL_E03ffOSxRYC7onLdla8zDG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA5NyBTYWx0ZWRfX25VFszGT8muO /+MvzgjomUx5Ib/WsJaBTJrngE0M6FXrqbYxfN8Uwgt4vSJQ/AQixVIigWAyhb3WhnVQEFyLmly vSEDxNGPGyY6IZ4aN2R6JyXaDxa832NtMAFpZNTTZcbl3zsqkP4xZ/0QxLyMCMNrDz3mNl4FEJB
 gGpHK7hC4VASqNNFktDfBpYgd2YHH41842E9gukma4dgvLZiceKrpXivRParr0iT/nk5+ykyHqu /ahW2K5e6HzibtwYqH7TGEYBzKSXf9OglXjan2syznSXXYNvhLeIpu4pt1JuRgx9tOBLh0Jy+O9 I3ee5LpkY5X3nBnAo55Ow79I7SivOeLjr3euiGAwYt+ugP2gQO3vmVVGncsE821LbihBfz1MFqu
 U7S6UNWIWObk/riOCdMO30pPFfcK6eQsV5zt6jWftGi+ZKDtv0HIRxWpsQyV7t6drlp5f3Qq
X-Authority-Analysis: v=2.4 cv=eK0TjGp1 c=1 sm=1 tr=0 ts=6871159d b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=KDkriMuAvPMAm80rOkcA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600
X-Proofpoint-GUID: Y08li79oL_E03ffOSxRYC7onLdla8zDG

Apologies, I've done it again... :) Friday eh?

+cc linux-api - FYI guys.

I will update manpage to reflect this change of course also.

On Fri, Jul 11, 2025 at 12:38:14PM +0100, Lorenzo Stoakes wrote:
> Historically we've made it a uAPI requirement that mremap() may only
> operate on a single VMA at a time.
>
> For instances where VMAs need to be resized, this makes sense, as it
> becomes very difficult to determine what a user actually wants should they
> indicate a desire to expand or shrink the size of multiple VMAs (truncate?
> Adjust sizes individually? Some other strategy?).
>
> However, in instances where a user is moving VMAs, it is restrictive to
> disallow this.
>
> This is especially the case when anonymous mapping remap may or may not be
> mergeable depending on whether VMAs have or have not been faulted due to
> anon_vma assignment and folio index alignment with vma->vm_pgoff.
>
> Often this can result in surprising impact where a moved region is faulted,
> then moved back and a user fails to observe a merge from otherwise
> compatible, adjacent VMAs.
>
> This change allows such cases to work without the user having to be
> cognizant of whether a prior mremap() move or other VMA operations has
> resulted in VMA fragmentation.
>
> In order to do this, this series performs a large amount of refactoring,
> most pertinently - grouping sanity checks together, separately those that
> check input parameters and those relating to VMAs.
>
> we also simplify the post-mmap lock drop processing for uffd and mlock()'d
> VMAs.
>
> With this done, we can then fairly straightforwardly implement this
> functionality.
>
> This works exclusively for mremap() invocations which specify
> MREMAP_FIXED. It is not compatible with VMAs which use userfaultfd, as the
> notification of the userland fault handler would require us to drop the
> mmap lock.
>
> It is also not compatible with file-backed mappings with customised
> get_unmapped_area() handlers as these may not honour MREMAP_FIXED.
>
> The input and output addresses ranges must not overlap. We carefully
> account for moves which would result in VMA iterator invalidation.
>
> While there can be gaps between VMAs in the input range, there can be no
> gap before the first VMA in the range.
>
>
> v3:
> * Disallowed move operation except for MREMAP_FIXED.
> * Disallow gap at start of aggregate range to avoid confusion.
> * Disallow any file-baked VMAs with custom get_unmapped_area.
> * Renamed multi_vma to seen_vma to be clearer. Stop reusing new_addr, use
>   separate target_addr var to track next target address.
> * Check if first VMA fails multi VMA check, if so we'll allow one VMA but
>   not multiple.
> * Updated the commit message for patch 9 to be clearer about gap behaviour.
> * Removed accidentally included debug goto statement in test (doh!). Test
>   was and is passing regardless.
> * Unmap target range in test, previously we ended up moving additional VMAs
>   unintentionally. This still all passed :) but was not what was intended.
> * Removed self-merge check - there is absolutely no way this can happen
>   across multiple VMAs, as there is no means of moving VMAs such that a VMA
>   merges with itself.
>
> v2:
> * Squashed uffd stub fix into series.
> * Propagated tags, thanks!
> * Fixed param naming in patch 4 as per Vlastimil.
> * Renamed vma_reset to vmi_needs_reset + dropped reset on unmap as per
>   Liam.
> * Correctly return -EFAULT if no VMAs in input range.
> * Account for get_unmapped_area() disregarding MAP_FIXED and returning an
>   altered address.
> * Added additional explanatatory comment to the remap_move() function.
> https://lore.kernel.org/all/cover.1751865330.git.lorenzo.stoakes@oracle.com/
>
> v1:
> https://lore.kernel.org/all/cover.1751865330.git.lorenzo.stoakes@oracle.com/
>
>
> Lorenzo Stoakes (10):
>   mm/mremap: perform some simple cleanups
>   mm/mremap: refactor initial parameter sanity checks
>   mm/mremap: put VMA check and prep logic into helper function
>   mm/mremap: cleanup post-processing stage of mremap
>   mm/mremap: use an explicit uffd failure path for mremap
>   mm/mremap: check remap conditions earlier
>   mm/mremap: move remap_is_valid() into check_prep_vma()
>   mm/mremap: clean up mlock populate behaviour
>   mm/mremap: permit mremap() move of multiple VMAs
>   tools/testing/selftests: extend mremap_test to test multi-VMA mremap
>
>  fs/userfaultfd.c                         |  15 +-
>  include/linux/userfaultfd_k.h            |   5 +
>  mm/mremap.c                              | 553 +++++++++++++++--------
>  tools/testing/selftests/mm/mremap_test.c | 146 +++++-
>  4 files changed, 518 insertions(+), 201 deletions(-)
>
> --
> 2.50.0

