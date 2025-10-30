Return-Path: <linux-fsdevel+bounces-66434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 481E0C1EF9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 09:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9C0BD34C46C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 08:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D343385A0;
	Thu, 30 Oct 2025 08:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SdJMdsFJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fplA8/wa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134C418A6DB;
	Thu, 30 Oct 2025 08:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761812771; cv=fail; b=JogW2cUPsiyVKN33vRQTJ3RwyYYn8ulmDvuYjMQhF8zdtfTII4wZGB7iLyjnGr5NoL2d/xvpt3GsANJwZH9xMo0CRr7L9n8mxf394L+Q2nw4iLsbos41PJCLFu6l5m3MKRfVLMziqy0qh+gDGMZ4R0UHOVio01B2QOLQ4TSVe60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761812771; c=relaxed/simple;
	bh=CZ7e5/s/9fcWznQ0QJ+9DfioYBtOeDKGTxjqzP4FryQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jgxk8yVSqf/ju0Cs+l/8IATx0KFXzTxYAHw2uWukAmV+rVjQBhbHZ+lczkfYb/F2XOGC1MpFHJq4M5Yo/oub0+hrL0gPN/CSWee/eUseTZI6e6FTKxTmcNrkXLF6MtDO9QNJc7KF6joLswJCXQktEfMKyXWsjyo9kg/HGznHrOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SdJMdsFJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fplA8/wa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59U8EL3S000499;
	Thu, 30 Oct 2025 08:25:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cqZorYxDkM5dT6Fhu3lBwxRdXY5wzUwMjhzJao/YOfQ=; b=
	SdJMdsFJ7XVC7jX1DupnL9N9dpkaEofn9Rz7yrhWG5CLov81k2SirHiVYJYLGn13
	gIpcJ1WUQvRnrVu/EQJ/6T4fpu27Bq+KzkK76cAhJD5ZUjTsaocxwwiK9S2egwUU
	pazKwobrAyI/NoAMqW9pEOrvSdzFBHw6dR90u3XayTkg7Sn7+Ix49Xg6RBNLiMeC
	Y+6d0zp7Qe+bnHjZENqMuLe28z6/FXiBk1utkLmnxouUnneSg6m69qcANu4PJ/O2
	3c0hTU1GgyAtaBvacRSxLX+IPRxO9x/1BUwzmK2dbD6ZVZX8LOQuqQxnhKD+STdZ
	lSOpOjlDo8sibwizTupclA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a44b5g0ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 08:25:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59U7b7qM021192;
	Thu, 30 Oct 2025 08:25:48 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011057.outbound.protection.outlook.com [40.93.194.57])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a359uymqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 08:25:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pewblRGKYJWVh+RDAteqoM9APXJu9QbrU8rbuz0KrL4/K+rXAwzhxKisgQV1Fli8pBLSATIfU+ob2vi/HYYgML5X0AbjUEjQwmotXyhBUr+z0SqUCNSnn4FXmX/a7yANZN55/dgV5J8rn2OTcPve+LWaxL5lG3h2ctXORBXlN4ozhMyWAa62z95HvtFLzaDcM+kgbCcVbr1g5OieOXzC2y+YVzfwcCfYAY+FZjKSXoYtVzMIpV+O1dly0ZnQElo5zsXSEC0xCSh7pjIeou0aAQlrnSvesIXJGT6GLJGztjIdA3GVTLCFgJBdVHYf9YHKsw///aRY9qsfTCNeIAAvRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqZorYxDkM5dT6Fhu3lBwxRdXY5wzUwMjhzJao/YOfQ=;
 b=yJltw32oZmeJK3dW0QCS7/9IOvCXWNvusp1ntnhkQ6//VJvrM/7JT9nslI81G9QMG16zDUpYCl71yP2lgYprg8Tm/OiFV9+kWMm+qicPNP6B/pTxVV9OFSnpbCp/N8aud1YJqcl7l+ZnHQbf8baiThYbWLmBUKfh6BL8SKnOv3Kec/+Ul1s2e4/iYBK/jGDxEXSeJvqhW9PyE6eXkOMPQ1Fu5uqQfw50CLCaWa75z2ZkB8WpbgybMvmPnSUTDOWvePuRF90zkSC8Vv/vXWmLAxHA1qfCxSJ/EP8Byaz5zvTGetjkv9camr5C4eloVksvfKEt7IUBYc7Q/Yis1J2XzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqZorYxDkM5dT6Fhu3lBwxRdXY5wzUwMjhzJao/YOfQ=;
 b=fplA8/waCwqbbyEv2q5kzNUVortA7azR8wIM+mRV0ulngZOaelf/4dtivhJFx8N6N6T/DEo6tiKeZbBwoyGZnrfD162FMhLn7WqXcVds5W3LVvN+wp/i0ZLWeRVoWGEx/lKmnu5CWHiSixQtaEIxS5t8wOSDIR1/6NFB1BXXA4I=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB5747.namprd10.prod.outlook.com (2603:10b6:510:127::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 08:25:45 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Thu, 30 Oct 2025
 08:25:45 +0000
Date: Thu, 30 Oct 2025 08:25:39 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH 2/3] mm: implement sticky, copy on fork VMA flags
Message-ID: <49f89731-ba74-49b6-bf08-7cb5d2a2376a@lucifer.local>
References: <cover.1761756437.git.lorenzo.stoakes@oracle.com>
 <ec71238fd1f735ca6e4970ccdc0abfbb60967596.1761756437.git.lorenzo.stoakes@oracle.com>
 <CAJuCfpEdFrPndQzF903zVQxFkyVdyXbFhxRT6YZd=j2MNgwUrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEdFrPndQzF903zVQxFkyVdyXbFhxRT6YZd=j2MNgwUrA@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0631.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: ee21d358-e44d-4a7a-2de0-08de178debd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1UreGxBc0p3dnVrVmdQeXd6VVZxZ1E0WGpDZXJNN0I2VTZhOXdtNGU1akZH?=
 =?utf-8?B?RGVBVW90T200c1JFMUdOSDREaVpDMFlDYzFaL0ozYXB2VzFJSXZOd1VZQlZx?=
 =?utf-8?B?OFNZeThjQVFiOFpxSk9xNGl0aWpUb0N0OWRaYngwVmZ5bUdXb29WTTIzeFVa?=
 =?utf-8?B?ZldZOWlTb0xCYXd1YUtnWmxWbGFtQUFBWjBIbVZDTEVqWTV4UEFhQXQ0bEli?=
 =?utf-8?B?QWk2dCtTS2loNXVhclpneWRFMHl4UzhBQjhJcTB4L0pZTG5MMm1WK1cyS090?=
 =?utf-8?B?VmIzcGhlMVBLdXBFRU0wM1h0OHBnRDJ1b0pNN1VIYjFRdExnczNlRjJkTkVO?=
 =?utf-8?B?ajVRTEdnMXFpS2xaVDIyRXNIb2RBU3dwZWNZTFpMRVJESlhUYkdtUVZjOVZm?=
 =?utf-8?B?ekM0RjRDZTdyemwxbC8yNThWTy9ZQjFITndIeXlmZDZDQlo1ZEdLc2svS3cz?=
 =?utf-8?B?d25XTThlSW04eW8wOXpCZkdVWXhxUTFHMW5qSHkwaEpVTmYweGwrcjkzYkQx?=
 =?utf-8?B?ZGM5bXUwMzc1NGFYclJOWkxPY1VQemNleElLSjZDZmJSUlU1V3I3Zk93VEFz?=
 =?utf-8?B?cUh5Y2d4ekRETmNSNlIvWVRJbzdIQVhJdGhPOS85UEdVK1lZM2dlakJCaWZW?=
 =?utf-8?B?OUdjdFJ6aWF6ZmhhOXp1UmJGNkxwOUV3dkVVejZ5dkNSbjBVd1p1aVNKWEJP?=
 =?utf-8?B?Q1JIN2NiK2lDN2d4R0Y4M0xmR2RnNWc2R2Z3bmNXdDNhZVNQbmROWHNhenQ5?=
 =?utf-8?B?cmJRdVlnT1lJVDRsUGlIckdDOVZVeXlrS29Ia1o0aG5TZ25SbmFsNlZNMTdW?=
 =?utf-8?B?bUJ1am4zc0cvRlhqc3pqL3hER0R0bk40UmhlaUQ2d0R2OWVrYkdaQkhYdVIr?=
 =?utf-8?B?Uk5qd2lyenhGaFJKTklnT09ZcXl6R0pOMFRnWm1YSmN2M2ZDNnJ4UkYxMS9W?=
 =?utf-8?B?SHczMFBnMGNBaWZ5L0g2NlpnYTZ6dnloSGpPRFBDOW96cG1qbWs1a1lLaXRW?=
 =?utf-8?B?QU96MjczSWFSMXdBMTJ6cDFkUHcrWmFuT3hXdXJkNXNUVnlCenI3MzJKVUQ2?=
 =?utf-8?B?aGFNSHhieVpZQm5jRjAwMEwwNk1CbnlZTThSVkR2NFlmc21Kd0JFV2hDd3h3?=
 =?utf-8?B?VkFnMFZaZ2dhZjVUaWhLQVFVR0VoSXVORitwdDVqN2wrQWlCWHBOeFpiWk43?=
 =?utf-8?B?VkpYNmdDV2YyalhqU3g4UnBuSzNaeGJWM2g2QmtEL1FTUStaMVNvT1g4a0VO?=
 =?utf-8?B?a3BWNmNtWHZodm9yS3pkS2lnbEw3WjF2UTd5RVhtczZPeFRpVjN6TGNuaVQ1?=
 =?utf-8?B?eVE0Z0ZPL3EveWIvRGhJKzFDUXZ4RmVKWGlqZmZCMXhwZytPcXl1dysyRGlJ?=
 =?utf-8?B?OWlCZFF5Y2xwQVZYZXprelI4SEFZRC9DZndXRmNuMkZ1dTZ0Y2lVbUlacndy?=
 =?utf-8?B?TlNaT09oZFA5a1VtV1hiM0lpV2p1V0RUVlFxMGtYamVOUVdRMi8rVjR4Nm5S?=
 =?utf-8?B?YW5UNVlRVUYvYVFUUHFNT1F0TmlYdDFqNU1sY0k2V29yK3hacXIyYkFXOUZt?=
 =?utf-8?B?emRHeVF0WDRuZkFRLzVkTHIyOUk2RnlMK1BiT1FHVE9zUDNUdFh5eUtRa3h0?=
 =?utf-8?B?LzFXYW1NWkFWS1ZqdzhNMGU4aTJIczlGemdYWkFUeStkZjRST1BOby92NFZz?=
 =?utf-8?B?cFpTT0wwK2lLdCtBdGM0cE1nQ2F5QUdiTTlraW5hWlFLSVp3V2RNRUt5SzJZ?=
 =?utf-8?B?U0t1YktXZXpuUGVRcEdDbXp0YTMxSHJjWmRvUS9FKzFMU2FVbGIyellQanRs?=
 =?utf-8?B?OVVYNXhxOWlGTUxhVi9yNzNobkhIQytUWFlTZ2k5SHhodHZVZkVEeTZQbFNj?=
 =?utf-8?B?a1NNaWorWVlYYi9UY1o3M2IrT2xGMjZ4L2JtTEdGVkwrWmFIQlNYQUJKQTAx?=
 =?utf-8?Q?/H9ePy2hApMSVKjgZTIBwrOBcUKPYt/G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akRpS0RXU2xWY0FSN0VVNTVrN3l0ZEFmYnJjMU5rSHdGZzVhVWdWbmZMWWVv?=
 =?utf-8?B?bERlcU1vVXBIQmp2c3RTMnltTzlJTE9OYzkvV1JSWWZ3aGFML28rUDJWdVUw?=
 =?utf-8?B?Z3F3OEtTZTZOd3FIQzB3NWlRQ3d5ellRRVhOelJFYjc4MTZ0VndiUnBMekNF?=
 =?utf-8?B?SHAwM3lQckRuK1RPMmtRNGZSdVlObnZPSDZvQWIxWFpnQnNqa3cxK0F6TVVG?=
 =?utf-8?B?d2lQbW5jOURrZnJTdlFESkdyMzdDY1BZcnQ0WVdpNzFtQ1FOMUV0MGRtWUd4?=
 =?utf-8?B?a2ZIYVpTY3Q2L3hSWlgzUlBHVkJsZjYrOUZIdU5RNGc1cFhHWXVQc0svaXZr?=
 =?utf-8?B?aE05R3VXYS9WVGJ6MVhKZmIxSHBoM3did2hETkgrT1FBZHhkeVNiQVdJWWZp?=
 =?utf-8?B?WFB3dFlZL0J6blB6em4wV0xvMHFiQXFqeXNlRTJldlhsQmkxT0F3d3Z6T3F5?=
 =?utf-8?B?K1RteW9ieFQzNXgwNHlqUWMva21iQmdPd0tRY1N3ZEliVUYvMzc5SndwaVli?=
 =?utf-8?B?YUkzeG9DUklFd0psajh5NFkzYkRZQ2p4WndsdVJRYU5HZnM5ZzBCVVVxUVVX?=
 =?utf-8?B?WWVWeHpHY2llOXo4cWIvMU9VRWJHTHBMUllRZWlqR2NIdEZNR0p4UUxZNnYx?=
 =?utf-8?B?Qm9YOEh1Uk5QTlR4SlgwK2k3NytsbXFpWVNnRGpnK2E5WUxISWZtMHVnM05u?=
 =?utf-8?B?cVo4T1ovOTRremZxQzcxRjk5blg1N2ptZnJ6NDBUYi83N0prNUN0KzFmaG81?=
 =?utf-8?B?RjZzZFRDQnlBc1lnVXJWZUtZRFVXSHRZVndKU3JTbC9rNThac1dvcWtCL0hn?=
 =?utf-8?B?QUtzMUxWUzVKdzNNb3NjV3Y0VW1FZzVMU3pKem1HM0tzeDAzMzBTeWVLeDhC?=
 =?utf-8?B?a01TTGo5eVN0VHNNTjE4ajF3TzNKM0ZNWjM2UFRXZysxenFhSWswSVVmdW9j?=
 =?utf-8?B?V1RieWlKL1E3aVNLRy80cnN3ci9JWHlpczIyaDIxYzNnbU44TThCL2lSYUtR?=
 =?utf-8?B?MFZYOWpCTUFES1g2RW9IUk5NWnl0YnNkai8yL0RjUjZYclZpVUhFZ0RwdDFp?=
 =?utf-8?B?WXByWlJvd2djelkyR2VhN3E5STVIZ1QvL0xWMUlJTXl1YUJwaStVNlFONkNG?=
 =?utf-8?B?NjVXeDg3cWRvbFFpckovWnhQTU04OWlqZmhTazJVMUxaSDNLd3d0QTNzVEVt?=
 =?utf-8?B?MVdqNW9OcE1sb2tVb1huNWNmait5ZDZhcVN6TUNwdktPbnBzcDVaZkFYQXhQ?=
 =?utf-8?B?V2YyYmk3WVdHSHRONmZ4NkNmWFpqcnR4TlJNdnl1dXNyOHJVb2JUVkFPSnJ5?=
 =?utf-8?B?WnR0NDBTc0hSUTBaek1WU0duOVdjUmtCR1BsWWdhWDM4N3dhcWY2YVB2VlR5?=
 =?utf-8?B?V2RkV2pJeXY1YmRUVmhGNEYzOTY2ZHRxYk9CVXVzazU0Zk50eG5ESGNFSTV6?=
 =?utf-8?B?OTJLeHlQS2ptaUdpbTZrckNudHNQMS9VTlhqVUh6VEk3bWxYTnpBY0VyaDZX?=
 =?utf-8?B?ay80RXd3SDZVc0QxeHB5TXhkMWtqc0xjOWsrbkg3QnF2OHF5UjhwVFp0Ti93?=
 =?utf-8?B?VWVlRTZjejdVbVlYQVNPZ0piT3gzVFpHUmlSbTU4OXJwUkJrcUhMKzlyQjJC?=
 =?utf-8?B?dUJURUJxZXVGWXViUzNzbkdaaktnOGh5SjRwUTRqalFiU2Q2MVY5VFVFU29R?=
 =?utf-8?B?YWFYVXhUOXBrR3hES1RrNXBRWFJicUg0M1VPMXhqTEVEVlhqM0cwTzlBRVBN?=
 =?utf-8?B?L0Y0NGtEMm9EL1JnbUhsL09SaVc2QXFMOG5WcmkycDVjTThZVHl2cjF5RFhJ?=
 =?utf-8?B?SkVNUVM2NWxxUzZYaTBPNEgzNm5ESFVJdkx1bVoycTd6WmVQbjJqMnBFaDBH?=
 =?utf-8?B?S1RvZ0svWUpXei9QTkxqeDV2M0hRWFBpZ3JvQWdSYStYWFg4Sk1UV0VQTzV5?=
 =?utf-8?B?c1pzT2oyYVN6cEpMMFBjMzBSY2wvRjZma1BzWkdxSS94c1BXckdyUE5rYmps?=
 =?utf-8?B?K3lIVUYvZmE4MWEvVFJiODZ3UHVkaUdONmdxVFRjV1RQL3NQK3pqRGJwK0xV?=
 =?utf-8?B?bjlsNndpTU8vK0ViSW5td2xRR1lvSVNMUGdmNWNyR1k0c0VJS1dNcG9TWXpH?=
 =?utf-8?B?US9EWExHbExyM2R0TmZCL005SEllNzhZeldDM1Evc1hKWmVoN1p6bnJYMGZr?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vL53EE2vqAG/0jjrWmBOshtNuYZRyeE6yvTvCnIRTTcXs9Q+YTEWLXnaFbBxDaJzDZ2O0npeJiZHrLzTZG5+6abQw0W40YX8tnsa0kYr5heFgUO9xcga9TiJr4shBXuu2scMRUVHtNMNwUYKGRcAcdE5vqCTRIV93E7M7do+YVdh/F3QdByDtNGVit2703qhu84iNaC/GQ1+BsT5+Yxk1egSq8xt2qn/cU8OlWafDsEOeazgFjLLb02Bu1dacisoysZVk5X2KJP0svnYJ2c3DzfLwd65UyCyiQfCqFLveY1NDyv7IWLL4HLsVqmP5ApFsvPKxgId1e8y7+UdSws0LiKXUWn9rv2fX2oH+ALPsuRGn4dHYZF83mBToPt5wRe5h8+ri4aJZN2bmtSmWauQ3use3l9eEUbDxgoVgr2sQWTy/3O04nJp7/riSwsPvg+koh+kBg6Id8jPwwCHU3lB0qXPaWwQmBk40mIcWSrSgEsTU6JmbO/rF+KX4bCgZ5vyYL5dECtv5gTNbh3DnRe1T6z6MAuPNF9zS/qMKbZo5U1z3oDkzTS6d9PWcLA8TIbNtmlxcM1L4cOpVYuL/KgT+POn9gH2aaPYcIpStypu9A4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee21d358-e44d-4a7a-2de0-08de178debd7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 08:25:44.9401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YETsXt901wKw6zJ65MpX/PmC2N6TrF3wVijmL6+vqmLBkOew4kx1vMS1bDlEFtNpE70UpqHfk3KFHxYUEQE01hCtswAemrfXISvkIe0kyFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5747
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2510300067
X-Authority-Analysis: v=2.4 cv=Z+Dh3XRA c=1 sm=1 tr=0 ts=6903210d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=1d0qWZqgJFmlNuTGKaMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12123
X-Proofpoint-ORIG-GUID: LthBzK1P6ZWxsl-N0tH69Xo6gDb7nubH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA2NiBTYWx0ZWRfX1ZSUzsHeqew2
 0hX7EVpphAVS57eTdb1m9LcLQQb0z+B6pYajr1zfGfIA+6RdT1erAti8w1NmqtdgkqWUaHyl7D6
 ulxXaDorlj2b/D1rcjNZpuZpWI0bgcTZ4Z2TVbMF08C+ppG9/YgY1Eei9a+2J/tR9lj5Df+/43Y
 ymyf2GYflsg6X6QEx0kaZYF7eshNHwP4LIlbNy7Qw2EFs0oYHHRj3A/bliFJotCgs+IJ3Jmd5Qj
 VqETQpDYvScpZui1R2EIapnlwhCk+MjZvJcqBVwpz3QDzj1Ku8TCxNWgdv30zI8ZyYpfemmNthm
 MaDL81RrkDCHBtQygpXCPZWWezSRfdx/9gs25YsrMnP7/SdDTw28Vu3FErfPqcyeIXZrjRKP61C
 INWYuFt4jEPJK0WED7gj36fHa16MHqTnNv65UdQm5pjEOi5Hzqw=
X-Proofpoint-GUID: LthBzK1P6ZWxsl-N0tH69Xo6gDb7nubH

On Wed, Oct 29, 2025 at 09:35:25PM -0700, Suren Baghdasaryan wrote:
> On Wed, Oct 29, 2025 at 9:51 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > It's useful to be able to force a VMA to be copied on fork outside of the
> > parameters specified by vma_needs_copy(), which otherwise only copies page
> > tables if:
> >
> > * The destination VMA has VM_UFFD_WP set
> > * The mapping is a PFN or mixed map
> > * The mapping is anonymous and forked in (i.e. vma->anon_vma is non-NULL)
> >
> > Setting this flag implies that the page tables mapping the VMA are such
> > that simply re-faulting the VMA will not re-establish them in identical
> > form.
> >
> > We introduce VM_COPY_ON_FORK to clearly identify which flags require this
> > behaviour, which currently is only VM_MAYBE_GUARD.
> >
> > Any VMA flags which require this behaviour are inherently 'sticky', that
> > is, should we merge two VMAs together, this implies that the newly merged
> > VMA maps a range that requires page table copying on fork.
> >
> > In order to implement this we must both introduce the concept of a 'sticky'
> > VMA flag and adjust the VMA merge logic accordingly, and also have VMA
> > merge still successfully succeed should one VMA have the flag set and
> > another not.
>
> "successfully succeed" sounds weird. Just "succeed"?

Yeah... typo bonanza this series :) will fix.

>
> >
> > Note that we update the VMA expand logic to handle new VMA merging, as this
> > function is the one ultimately called by all instances of merging of new
> > VMAs.
> >
> > This patch implements this, establishing VM_STICKY to contain all such
> > flags and VM_IGNORE_MERGE for those flags which should be ignored when
> > comparing adjacent VMA's flags for the purposes of merging.
> >
> > As part of this change we place VM_SOFTDIRTY in VM_IGNORE_MERGE as it
> > already had this behaviour, alongside VM_STICKY as sticky flags by
> > implication must not disallow merge.
> >
> > We update the VMA userland tests to account for the changes and,
> > furthermore, in order to assert that the functionality is workingly
>
> s/workingly/working

Haha good lord. Will fix also!

>
> > correctly, update the new VMA and existing VMA merging logic to consider
> > every permutation of the flag being set/not set in all VMAs being
> > considered for merge.
> >
> > As a result of this change, VMAs with guard ranges will now not have their
> > merge behaviour impacted by doing so and can be freely merged with other
> > VMAs without VM_MAYBE_GUARD set.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  include/linux/mm.h               | 32 ++++++++++++
> >  mm/memory.c                      |  3 +-
> >  mm/vma.c                         | 22 ++++----
> >  tools/testing/vma/vma.c          | 89 ++++++++++++++++++++++++++++----
> >  tools/testing/vma/vma_internal.h | 32 ++++++++++++
> >  5 files changed, 156 insertions(+), 22 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index f963afa1b9de..a8811ba57150 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -522,6 +522,38 @@ extern unsigned int kobjsize(const void *objp);
> >  #endif
> >  #define VM_FLAGS_CLEAR (ARCH_VM_PKEY_FLAGS | VM_ARCH_CLEAR)
> >
> > +/* Flags which should result in page tables being copied on fork. */
> > +#define VM_COPY_ON_FORK VM_MAYBE_GUARD
> > +
> > +/*
> > + * Flags which should be 'sticky' on merge - that is, flags which, when one VMA
> > + * possesses it but the other does not, the merged VMA should nonetheless have
> > + * applied to it:
> > + *
> > + * VM_COPY_ON_FORK - These flags indicates that a VMA maps a range that contains
> > + *                   metadata which should be unconditionally propagated upon
> > + *                   fork. When merging two VMAs, we encapsulate this range in
> > + *                   the merged VMA, so the flag should be 'sticky' as a result.
>
> It's probably worth noting that after a split, we do not remove
> "sticky" flags even if the VMA acquired them as a result of a previous
> merge.

Hm I thought this was implied. Will update to be clear however!

>
> > + */
> > +#define VM_STICKY VM_COPY_ON_FORK
> > +
> > +/*
> > + * VMA flags we ignore for the purposes of merge, i.e. one VMA possessing one
> > + * of these flags and the other not does not preclude a merge.
> > + *
> > + * VM_SOFTDIRTY - Should not prevent from VMA merging, if we match the flags but
> > + *                dirty bit -- the caller should mark merged VMA as dirty. If
> > + *                dirty bit won't be excluded from comparison, we increase
> > + *                pressure on the memory system forcing the kernel to generate
> > + *                new VMAs when old one could be extended instead.
> > + *
> > + *    VM_STICKY - If one VMA has flags which most be 'sticky', that is ones
>
> s/most/must ?

I most learn to not typo so much :)

Yes you're right, will fix! :P

>
> > + *                which should propagate to all VMAs, but the other does not,
> > + *                the merge should still proceed with the merge logic applying
> > + *                sticky flags to the final VMA.
> > + */
> > +#define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
> > +
> >  /*
> >   * mapping from the currently active vm_flags protection bits (the
> >   * low four bits) to a page protection mask..
> > diff --git a/mm/memory.c b/mm/memory.c
> > index a2c79ee43d68..9528133e5147 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1478,8 +1478,7 @@ vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
> >         if (src_vma->anon_vma)
> >                 return true;
> >
> > -       /* Guard regions have momdified page tables that require copying. */
> > -       if (src_vma->vm_flags & VM_MAYBE_GUARD)
> > +       if (src_vma->vm_flags & VM_COPY_ON_FORK)
> >                 return true;
> >
> >         /*
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 919d1fc63a52..50a6909c4be3 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -89,15 +89,7 @@ static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_nex
> >
> >         if (!mpol_equal(vmg->policy, vma_policy(vma)))
> >                 return false;
> > -       /*
> > -        * VM_SOFTDIRTY should not prevent from VMA merging, if we
> > -        * match the flags but dirty bit -- the caller should mark
> > -        * merged VMA as dirty. If dirty bit won't be excluded from
> > -        * comparison, we increase pressure on the memory system forcing
> > -        * the kernel to generate new VMAs when old one could be
> > -        * extended instead.
> > -        */
> > -       if ((vma->vm_flags ^ vmg->vm_flags) & ~VM_SOFTDIRTY)
> > +       if ((vma->vm_flags ^ vmg->vm_flags) & ~VM_IGNORE_MERGE)
> >                 return false;
> >         if (vma->vm_file != vmg->file)
> >                 return false;
> > @@ -809,6 +801,7 @@ static bool can_merge_remove_vma(struct vm_area_struct *vma)
> >  static __must_check struct vm_area_struct *vma_merge_existing_range(
> >                 struct vma_merge_struct *vmg)
> >  {
> > +       vm_flags_t sticky_flags = vmg->vm_flags & VM_STICKY;
> >         struct vm_area_struct *middle = vmg->middle;
> >         struct vm_area_struct *prev = vmg->prev;
> >         struct vm_area_struct *next;
> > @@ -901,11 +894,13 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
> >         if (merge_right) {
> >                 vma_start_write(next);
> >                 vmg->target = next;
> > +               sticky_flags |= (next->vm_flags & VM_STICKY);
> >         }
> >
> >         if (merge_left) {
> >                 vma_start_write(prev);
> >                 vmg->target = prev;
> > +               sticky_flags |= (prev->vm_flags & VM_STICKY);
> >         }
> >
> >         if (merge_both) {
> > @@ -975,6 +970,7 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
> >         if (err || commit_merge(vmg))
> >                 goto abort;
> >
> > +       vm_flags_set(vmg->target, sticky_flags);
> >         khugepaged_enter_vma(vmg->target, vmg->vm_flags);
> >         vmg->state = VMA_MERGE_SUCCESS;
> >         return vmg->target;
> > @@ -1125,6 +1121,10 @@ int vma_expand(struct vma_merge_struct *vmg)
> >         bool remove_next = false;
> >         struct vm_area_struct *target = vmg->target;
> >         struct vm_area_struct *next = vmg->next;
> > +       vm_flags_t sticky_flags;
> > +
> > +       sticky_flags = vmg->vm_flags & VM_STICKY;
> > +       sticky_flags |= target->vm_flags & VM_STICKY;
> >
> >         VM_WARN_ON_VMG(!target, vmg);
> >
> > @@ -1134,6 +1134,7 @@ int vma_expand(struct vma_merge_struct *vmg)
> >         if (next && (target != next) && (vmg->end == next->vm_end)) {
> >                 int ret;
> >
> > +               sticky_flags |= next->vm_flags & VM_STICKY;
> >                 remove_next = true;
> >                 /* This should already have been checked by this point. */
> >                 VM_WARN_ON_VMG(!can_merge_remove_vma(next), vmg);
> > @@ -1160,6 +1161,7 @@ int vma_expand(struct vma_merge_struct *vmg)
> >         if (commit_merge(vmg))
> >                 goto nomem;
> >
> > +       vm_flags_set(target, sticky_flags);
> >         return 0;
> >
> >  nomem:
> > @@ -1903,7 +1905,7 @@ static int anon_vma_compatible(struct vm_area_struct *a, struct vm_area_struct *
> >         return a->vm_end == b->vm_start &&
> >                 mpol_equal(vma_policy(a), vma_policy(b)) &&
> >                 a->vm_file == b->vm_file &&
> > -               !((a->vm_flags ^ b->vm_flags) & ~(VM_ACCESS_FLAGS | VM_SOFTDIRTY)) &&
> > +               !((a->vm_flags ^ b->vm_flags) & ~(VM_ACCESS_FLAGS | VM_IGNORE_MERGE)) &&
> >                 b->vm_pgoff == a->vm_pgoff + ((b->vm_start - a->vm_start) >> PAGE_SHIFT);
> >  }
> >
> > diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
> > index 656e1c75b711..ee9d3547c421 100644
> > --- a/tools/testing/vma/vma.c
> > +++ b/tools/testing/vma/vma.c
>
> I prefer tests in a separate patch, but that might just be me. Feel
> free to ignore.

Yeah can split it out! I do tend to do that actually, not sure why I
deviated from that here.

>
> > @@ -48,6 +48,8 @@ static struct anon_vma dummy_anon_vma;
> >  #define ASSERT_EQ(_val1, _val2) ASSERT_TRUE((_val1) == (_val2))
> >  #define ASSERT_NE(_val1, _val2) ASSERT_TRUE((_val1) != (_val2))
> >
> > +#define IS_SET(_val, _flags) ((_val & _flags) == _flags)
> > +
> >  static struct task_struct __current;
> >
> >  struct task_struct *get_current(void)
> > @@ -441,7 +443,7 @@ static bool test_simple_shrink(void)
> >         return true;
> >  }
> >
> > -static bool test_merge_new(void)
> > +static bool __test_merge_new(bool is_sticky, bool a_is_sticky, bool b_is_sticky, bool c_is_sticky)
> >  {
> >         vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> >         struct mm_struct mm = {};
> > @@ -469,23 +471,32 @@ static bool test_merge_new(void)
> >         struct vm_area_struct *vma, *vma_a, *vma_b, *vma_c, *vma_d;
> >         bool merged;
> >
> > +       if (is_sticky)
> > +               vm_flags |= VM_STICKY;
> > +
> >         /*
> >          * 0123456789abc
> >          * AA B       CC
> >          */
> >         vma_a = alloc_and_link_vma(&mm, 0, 0x2000, 0, vm_flags);
> >         ASSERT_NE(vma_a, NULL);
> > +       if (a_is_sticky)
> > +               vm_flags_set(vma_a, VM_STICKY);
> >         /* We give each VMA a single avc so we can test anon_vma duplication. */
> >         INIT_LIST_HEAD(&vma_a->anon_vma_chain);
> >         list_add(&dummy_anon_vma_chain_a.same_vma, &vma_a->anon_vma_chain);
> >
> >         vma_b = alloc_and_link_vma(&mm, 0x3000, 0x4000, 3, vm_flags);
> >         ASSERT_NE(vma_b, NULL);
> > +       if (b_is_sticky)
> > +               vm_flags_set(vma_b, VM_STICKY);
> >         INIT_LIST_HEAD(&vma_b->anon_vma_chain);
> >         list_add(&dummy_anon_vma_chain_b.same_vma, &vma_b->anon_vma_chain);
> >
> >         vma_c = alloc_and_link_vma(&mm, 0xb000, 0xc000, 0xb, vm_flags);
> >         ASSERT_NE(vma_c, NULL);
> > +       if (c_is_sticky)
> > +               vm_flags_set(vma_c, VM_STICKY);
> >         INIT_LIST_HEAD(&vma_c->anon_vma_chain);
> >         list_add(&dummy_anon_vma_chain_c.same_vma, &vma_c->anon_vma_chain);
> >
> > @@ -520,6 +531,8 @@ static bool test_merge_new(void)
> >         ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
> >         ASSERT_TRUE(vma_write_started(vma));
> >         ASSERT_EQ(mm.map_count, 3);
> > +       if (is_sticky || a_is_sticky || b_is_sticky)
> > +               ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
> >
> >         /*
> >          * Merge to PREVIOUS VMA.
> > @@ -537,6 +550,8 @@ static bool test_merge_new(void)
> >         ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
> >         ASSERT_TRUE(vma_write_started(vma));
> >         ASSERT_EQ(mm.map_count, 3);
> > +       if (is_sticky || a_is_sticky)
> > +               ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
> >
> >         /*
> >          * Merge to NEXT VMA.
> > @@ -556,6 +571,8 @@ static bool test_merge_new(void)
> >         ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
> >         ASSERT_TRUE(vma_write_started(vma));
> >         ASSERT_EQ(mm.map_count, 3);
> > +       if (is_sticky) /* D uses is_sticky. */
> > +               ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
> >
> >         /*
> >          * Merge BOTH sides.
> > @@ -574,6 +591,8 @@ static bool test_merge_new(void)
> >         ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
> >         ASSERT_TRUE(vma_write_started(vma));
> >         ASSERT_EQ(mm.map_count, 2);
> > +       if (is_sticky || a_is_sticky)
> > +               ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
> >
> >         /*
> >          * Merge to NEXT VMA.
> > @@ -592,6 +611,8 @@ static bool test_merge_new(void)
> >         ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
> >         ASSERT_TRUE(vma_write_started(vma));
> >         ASSERT_EQ(mm.map_count, 2);
> > +       if (is_sticky || c_is_sticky)
> > +               ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
> >
> >         /*
> >          * Merge BOTH sides.
> > @@ -609,6 +630,8 @@ static bool test_merge_new(void)
> >         ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
> >         ASSERT_TRUE(vma_write_started(vma));
> >         ASSERT_EQ(mm.map_count, 1);
> > +       if (is_sticky || a_is_sticky || c_is_sticky)
> > +               ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
> >
> >         /*
> >          * Final state.
> > @@ -637,6 +660,20 @@ static bool test_merge_new(void)
> >         return true;
> >  }
> >
> > +static bool test_merge_new(void)
> > +{
> > +       int i, j, k, l;
> > +
> > +       /* Generate every possible permutation of sticky flags. */
> > +       for (i = 0; i < 2; i++)
> > +               for (j = 0; j < 2; j++)
> > +                       for (k = 0; k < 2; k++)
> > +                               for (l = 0; l < 2; l++)
> > +                                       ASSERT_TRUE(__test_merge_new(i, j, k, l));
> > +
> > +       return true;
> > +}
> > +
> >  static bool test_vma_merge_special_flags(void)
> >  {
> >         vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> > @@ -973,9 +1010,11 @@ static bool test_vma_merge_new_with_close(void)
> >         return true;
> >  }
> >
> > -static bool test_merge_existing(void)
> > +static bool __test_merge_existing(bool prev_is_sticky, bool middle_is_sticky, bool next_is_sticky)
> >  {
> >         vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> > +       vm_flags_t prev_flags = vm_flags;
> > +       vm_flags_t next_flags = vm_flags;
> >         struct mm_struct mm = {};
> >         VMA_ITERATOR(vmi, &mm, 0);
> >         struct vm_area_struct *vma, *vma_prev, *vma_next;
> > @@ -988,6 +1027,13 @@ static bool test_merge_existing(void)
> >         };
> >         struct anon_vma_chain avc = {};
> >
> > +       if (prev_is_sticky)
> > +               prev_flags |= VM_STICKY;
> > +       if (middle_is_sticky)
> > +               vm_flags |= VM_STICKY;
> > +       if (next_is_sticky)
> > +               next_flags |= VM_STICKY;
> > +
> >         /*
> >          * Merge right case - partial span.
> >          *
> > @@ -1000,7 +1046,7 @@ static bool test_merge_existing(void)
> >          */
> >         vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, vm_flags);
> >         vma->vm_ops = &vm_ops; /* This should have no impact. */
> > -       vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, vm_flags);
> > +       vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, next_flags);
> >         vma_next->vm_ops = &vm_ops; /* This should have no impact. */
> >         vmg_set_range_anon_vma(&vmg, 0x3000, 0x6000, 3, vm_flags, &dummy_anon_vma);
> >         vmg.middle = vma;
> > @@ -1018,6 +1064,8 @@ static bool test_merge_existing(void)
> >         ASSERT_TRUE(vma_write_started(vma));
> >         ASSERT_TRUE(vma_write_started(vma_next));
> >         ASSERT_EQ(mm.map_count, 2);
> > +       if (middle_is_sticky || next_is_sticky)
> > +               ASSERT_TRUE(IS_SET(vma_next->vm_flags, VM_STICKY));
> >
> >         /* Clear down and reset. */
> >         ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
> > @@ -1033,7 +1081,7 @@ static bool test_merge_existing(void)
> >          *   NNNNNNN
> >          */
> >         vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, vm_flags);
> > -       vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, vm_flags);
> > +       vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, next_flags);
> >         vma_next->vm_ops = &vm_ops; /* This should have no impact. */
> >         vmg_set_range_anon_vma(&vmg, 0x2000, 0x6000, 2, vm_flags, &dummy_anon_vma);
> >         vmg.middle = vma;
> > @@ -1046,6 +1094,8 @@ static bool test_merge_existing(void)
> >         ASSERT_EQ(vma_next->anon_vma, &dummy_anon_vma);
> >         ASSERT_TRUE(vma_write_started(vma_next));
> >         ASSERT_EQ(mm.map_count, 1);
> > +       if (middle_is_sticky || next_is_sticky)
> > +               ASSERT_TRUE(IS_SET(vma_next->vm_flags, VM_STICKY));
> >
> >         /* Clear down and reset. We should have deleted vma. */
> >         ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
> > @@ -1060,7 +1110,7 @@ static bool test_merge_existing(void)
> >          * 0123456789
> >          * PPPPPPV
> >          */
> > -       vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
> > +       vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, prev_flags);
> >         vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
> >         vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, vm_flags);
> >         vma->vm_ops = &vm_ops; /* This should have no impact. */
> > @@ -1080,6 +1130,8 @@ static bool test_merge_existing(void)
> >         ASSERT_TRUE(vma_write_started(vma_prev));
> >         ASSERT_TRUE(vma_write_started(vma));
> >         ASSERT_EQ(mm.map_count, 2);
> > +       if (prev_is_sticky || middle_is_sticky)
> > +               ASSERT_TRUE(IS_SET(vma_prev->vm_flags, VM_STICKY));
> >
> >         /* Clear down and reset. */
> >         ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
> > @@ -1094,7 +1146,7 @@ static bool test_merge_existing(void)
> >          * 0123456789
> >          * PPPPPPP
> >          */
> > -       vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
> > +       vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, prev_flags);
> >         vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
> >         vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, vm_flags);
> >         vmg_set_range_anon_vma(&vmg, 0x3000, 0x7000, 3, vm_flags, &dummy_anon_vma);
> > @@ -1109,6 +1161,8 @@ static bool test_merge_existing(void)
> >         ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
> >         ASSERT_TRUE(vma_write_started(vma_prev));
> >         ASSERT_EQ(mm.map_count, 1);
> > +       if (prev_is_sticky || middle_is_sticky)
> > +               ASSERT_TRUE(IS_SET(vma_prev->vm_flags, VM_STICKY));
> >
> >         /* Clear down and reset. We should have deleted vma. */
> >         ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
> > @@ -1123,10 +1177,10 @@ static bool test_merge_existing(void)
> >          * 0123456789
> >          * PPPPPPPPPP
> >          */
> > -       vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
> > +       vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, prev_flags);
> >         vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
> >         vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, vm_flags);
> > -       vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, vm_flags);
> > +       vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, next_flags);
> >         vmg_set_range_anon_vma(&vmg, 0x3000, 0x7000, 3, vm_flags, &dummy_anon_vma);
> >         vmg.prev = vma_prev;
> >         vmg.middle = vma;
> > @@ -1139,6 +1193,8 @@ static bool test_merge_existing(void)
> >         ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
> >         ASSERT_TRUE(vma_write_started(vma_prev));
> >         ASSERT_EQ(mm.map_count, 1);
> > +       if (prev_is_sticky || middle_is_sticky || next_is_sticky)
> > +               ASSERT_TRUE(IS_SET(vma_prev->vm_flags, VM_STICKY));
> >
> >         /* Clear down and reset. We should have deleted prev and next. */
> >         ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
> > @@ -1158,9 +1214,9 @@ static bool test_merge_existing(void)
> >          * PPPVVVVVNNN
> >          */
> >
> > -       vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
> > +       vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, prev_flags);
> >         vma = alloc_and_link_vma(&mm, 0x3000, 0x8000, 3, vm_flags);
> > -       vma_next = alloc_and_link_vma(&mm, 0x8000, 0xa000, 8, vm_flags);
> > +       vma_next = alloc_and_link_vma(&mm, 0x8000, 0xa000, 8, next_flags);
> >
> >         vmg_set_range(&vmg, 0x4000, 0x5000, 4, vm_flags);
> >         vmg.prev = vma;
> > @@ -1203,6 +1259,19 @@ static bool test_merge_existing(void)
> >         return true;
> >  }
> >
> > +static bool test_merge_existing(void)
> > +{
> > +       int i, j, k;
> > +
> > +       /* Generate every possible permutation of sticky flags. */
> > +       for (i = 0; i < 2; i++)
> > +               for (j = 0; j < 2; j++)
> > +                       for (k = 0; k < 2; k++)
> > +                               ASSERT_TRUE(__test_merge_existing(i, j, k));
> > +
> > +       return true;
> > +}
> > +
> >  static bool test_anon_vma_non_mergeable(void)
> >  {
> >         vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> > diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> > index e40c93edc5a7..3d9cb3a9411a 100644
> > --- a/tools/testing/vma/vma_internal.h
> > +++ b/tools/testing/vma/vma_internal.h
> > @@ -117,6 +117,38 @@ extern unsigned long dac_mmap_min_addr;
> >  #define VM_SEALED      VM_NONE
> >  #endif
> >
> > +/* Flags which should result in page tables being copied on fork. */
> > +#define VM_COPY_ON_FORK VM_MAYBE_GUARD
> > +
> > +/*
> > + * Flags which should be 'sticky' on merge - that is, flags which, when one VMA
> > + * possesses it but the other does not, the merged VMA should nonetheless have
> > + * applied to it:
> > + *
> > + * VM_COPY_ON_FORK - These flags indicates that a VMA maps a range that contains
> > + *                   metadata which should be unconditionally propagated upon
> > + *                   fork. When merging two VMAs, we encapsulate this range in
> > + *                   the merged VMA, so the flag should be 'sticky' as a result.
> > + */
> > +#define VM_STICKY VM_COPY_ON_FORK
> > +
> > +/*
> > + * VMA flags we ignore for the purposes of merge, i.e. one VMA possessing one
> > + * of these flags and the other not does not preclude a merge.
> > + *
> > + * VM_SOFTDIRTY - Should not prevent from VMA merging, if we match the flags but
> > + *                dirty bit -- the caller should mark merged VMA as dirty. If
> > + *                dirty bit won't be excluded from comparison, we increase
> > + *                pressure on the memory system forcing the kernel to generate
> > + *                new VMAs when old one could be extended instead.
> > + *
> > + *    VM_STICKY - If one VMA has flags which must be 'sticky', that is ones
> > + *                which should propagate to all VMAs, but the other does not,
> > + *                the merge should still proceed with the merge logic applying
> > + *                sticky flags to the final VMA.
> > + */
> > +#define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
> > +
> >  #define FIRST_USER_ADDRESS     0UL
> >  #define USER_PGTABLES_CEILING  0UL
> >
> > --
> > 2.51.0
> >

Thanks for review!

