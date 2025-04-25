Return-Path: <linux-fsdevel+bounces-47338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081D9A9C4CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 12:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289384C58CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 10:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23B123236D;
	Fri, 25 Apr 2025 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Dxqwuw+T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xx51enwr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8512621A436;
	Fri, 25 Apr 2025 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745575823; cv=fail; b=rqORkIAXkw/D7J7QY4NBNq7tYhxGCsevKzUK2hTtLRT/iC9/dNO0W4GkwX6ZLTj32d5SbDkfzkA8X+IXzcnfppdyQGCK0vRqLd+S8RvJpZaRRaoSue2araSjAyInChRA5izB67Ww17XzOgrq/IEVTfZHKTl7EQiWZokbLnOrBAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745575823; c=relaxed/simple;
	bh=J8cPzgPHcVA7oLpJLADuZ7aSViaFoRmPtj/F5eaPYc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hujxZD8ithA87xK6EXF7GWGg0Vik8avYMbSQ79Dmy3PNla/sSRAnwbtFb5NWMSGq41RDeJ6KNJlUKYHaTbDDrrsbZ/F6sRrFG/r02jPq30tbzhg3xRDgCIz4DxRgnZwnFpzV7A2BEmw0CmOcUqol5iUuUHdH1qD3UmbmMkFOvIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Dxqwuw+T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xx51enwr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P8iJTN018116;
	Fri, 25 Apr 2025 10:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=3HgZa3UA/91WR9rMqDFokwHZpO/gO6LC4nUBR3u0JGI=; b=
	Dxqwuw+TCF/MCwuQBxCNECNZ1K60+FYE6Jy+b3o243aFUc9zEDgVQLCIKIb2FCIz
	hOg8PmqGxBEbwdKR/XetMMp/Mxdjf/ztnreByJtcI4fLnbhFL12g4khXc9LBT+Y4
	RSZ5PbzBve2PHvlVxSKjh2GsF6IJz0JS90SHjvyavl0uN+fUfD0HSvQ4u9PWgz8+
	2D5BdQ7uiM1BqXPzFSOxGeRJZ4QsoAj9NqTdon9pVEU4f/ZNW1aJT8AW44keBJE1
	5knOJBnZr+5kPoCQWAQUBiK0XTExrPXg+HfpNGlix9P3tNvEvG7w0Bd4sHrnm8RW
	Lm9sC7MHZdC+zIuPji+PhQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4686ev86tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:10:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53P9jEH0013829;
	Fri, 25 Apr 2025 10:10:05 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013061.outbound.protection.outlook.com [40.93.20.61])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jxre4p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:10:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQRBvj0gTa4UfNck1yBfCb4rqxeWQHzx2/E8BryGriY6MwP6nvuMCxbLQyVm1TkpHO9J2ayyiB4WlSdqLiqOjzgEP12eoatfhSJRceyxG3LXnCgaCbr9wDRdAY/gTKpB2fpyCaRv28HOmC66S+MwyRfRcN/nDB/IbVCc/CrbJI7SKncZrP5ev0nsjdlOtA3r6FS81ndznAOiNPTTApG3wNrhTE76etlUN26ERz/Ed2nF5gDeAoX6I03sQ4HmcveYKEyOsWXHniHPbmwxTxUdmAqGfzBJfnbIqB6GuLelAnmTwAf03A2XF82x2rRermIpuliDqXR5L1AA6jM7XQy0pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HgZa3UA/91WR9rMqDFokwHZpO/gO6LC4nUBR3u0JGI=;
 b=VrFlNbqGLuiSwTqFKjG6ayWVi1MM7dIDMkhqfjQHjZo/iRZ7Rd1DmA6792w7vDyK+Bwo4sG0IFVpNpsaCLtguiGTE5osFxBT097IrYcxu2nfhjIf5AZLD67Z6qDddkmAixqFv0Ezgds/TQTbzG6dEHBAtn24gDL1e8oJ0rIby1GjHjZcv1j1eKTk2h7Y7wUjdGOhspEOI3gfhk4+PakWFBw8bL+WIXbQe5bc0jfaPXAuZFqRPV+YBgPF2wzUHp0PerIj4q/0h6/7njNjf1hMNY6dzgFjOW1P7prAlD+yxe7d2/jqHAiwQzeG1hx4PlqHgMdHlY7K5BaBBUlMInUljA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HgZa3UA/91WR9rMqDFokwHZpO/gO6LC4nUBR3u0JGI=;
 b=Xx51enwrdL7dz9Q/jTEXaXRyqULG8q9FSE8ccRHg8X8DYsLKDV45aLRtsErYHttd01GNEqmBL8leYjzek653AWdskSok2lwbMTobaTzwqxS6nPPFhWgYl4BiN2vSQKY6GYY2/HnBd+x2OuHCoYLKK+spSzQlkmOEUR8gOYhBRWU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB7046.namprd10.prod.outlook.com (2603:10b6:806:346::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 10:10:03 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 10:10:03 +0000
Date: Fri, 25 Apr 2025 11:10:00 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: perform VMA allocation, freeing, duplication in
 mm
Message-ID: <365487db-b829-47ee-8f5f-6cba873daae8@lucifer.local>
References: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
 <0f848d59f3eea3dd0c0cdc3920644222c40cffe6.1745528282.git.lorenzo.stoakes@oracle.com>
 <8ff17bd8-5cdd-49cd-ba71-b60abc1c99f6@redhat.com>
 <CAJuCfpG84+795wzWuEi6t18srt436=9ea0dGrYgg-KT8+82Sgw@mail.gmail.com>
 <CAJuCfpHxWwEiZdX-xrxe7J+Q20otPTPs4NR-oJBSnL7HNt-f2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHxWwEiZdX-xrxe7J+Q20otPTPs4NR-oJBSnL7HNt-f2A@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0435.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB7046:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c43563d-6acd-4ba7-cfb3-08dd83e158a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGVuVjNHWmtoSXNuU3E4RURzVU5ESHk2WWx6TnYxTWtHT20wRlRZMHFpNUEv?=
 =?utf-8?B?VVFZNzRmR2Jqb0tnVXlyb0JzTkc2ZWY3NzgxRUFuSUpjUjc3Si84K1RPOFFI?=
 =?utf-8?B?RDYxT2x3NmlwdW1IU0tLR3FIRk43aE5TV2Y0UWljcEdmTExZQnR6OUZieUhp?=
 =?utf-8?B?SnZNT1lCdUpaVCtuang5YnhIZXJlQ2svYytyYkJXTXMrZ3YwRS9aRkZxQ2Nt?=
 =?utf-8?B?ZDViS0Z6T2RyODRqaWJqUUN0cEIvQWl6Z1V3ZnNwZnpMR1pqK1pzb0tQbVV3?=
 =?utf-8?B?NUNaRnJLL2J6UjB4dG5udUdnYkoveCsrTlcrcnN2aGp0eEFOSENtTjRiczNi?=
 =?utf-8?B?QlN6NjNKbDVIcVgzdk9SdW1tZ1FlMUxBNUpHQnF0bG5IMjRNV2Z4ZHVOM1px?=
 =?utf-8?B?MXZ3b1dvaFpNMnNIdWVhYTk5MHVDSHMyQ1paN1pEU3ZOM2taWWtBeWhLMmN3?=
 =?utf-8?B?d0V3eFhVcWpOM1dRNjJnWlBZQS9mK3h6OVpNTkFPRjMxTktPRHMvRG1IZzBH?=
 =?utf-8?B?TllRaVVuUy81VjJ6MEU5UmRSREFtQTJMTkhCUG84VzdXTEN5NHFiK2cwY3p5?=
 =?utf-8?B?VmtFSVozeThtTWdFcGNIU1R4QWthVnVZWHUvUXBPTVRZeEVOSDE5bkl3U1l3?=
 =?utf-8?B?dXBwRHliS0JDSFFQVHQrYjVyV3V1aG14SEttb3ZQdTN5WEhpeFRvTkx5eWNk?=
 =?utf-8?B?ZDlOaEp3Unk5eURIL0VFYnRpSFlyd0xIdTN6Slpyd3EwVFBTNmg0MHduN1Q1?=
 =?utf-8?B?dDk3Z3hLQlVTOVVKQU51MHBJSzlxMXBDcTdqZlJqL3drUkVmZVQvS0R3ekJE?=
 =?utf-8?B?UW1uNkZ5bEYwc0pnbnMrd1A4bENpaG9MS3BEeUYwVjFFaHlkcSt1cGtpd1JK?=
 =?utf-8?B?a2NKc0F4TExlSG8rNm5TMlVsOXF5djZKT3g5T1lwck5Ed1RJWTZ3eEJ6WnRR?=
 =?utf-8?B?M2l0elVIaXRXZkJFbWMvd0NDVlduamt1NE5wNDdrb3NwUlBwTGdVMXdtMkRC?=
 =?utf-8?B?MGRVV3J1c2FRSlB6UnYzdi9pTkFkRDJxRGIwdGNtSkg0Ny9oL2NzWUlBQUR0?=
 =?utf-8?B?UDB0azNsaERFbUt0REVNUnZhSkpyZGVxaGNTYXZ1V25VVWh6aEkzSEZ0T0dF?=
 =?utf-8?B?bnVIZzM0bUdQRHJXR20zT0wzSWRscS9jN2ZFendId1pDSEhKWEtHWEFiUHZo?=
 =?utf-8?B?ZldjWko2MVo0UW9SR0J6dlRNeDkrYXVua1M4MHFGWE5rZnc3MGc0ZTBUVWVi?=
 =?utf-8?B?ZHBLMUN6RFB5Vks2S1g1Y205TWYyZlIxdXpvZ3VSajlTZmw4S2dqcG40SG9C?=
 =?utf-8?B?Q0VtVGZwbVdZbWNjUVpIalFuVTJFaEpWZHdNOEJ3L2d0Zk5BdEY3U3F6R2xE?=
 =?utf-8?B?blFHRUIrQS9vTjJWU3RXRG0zTU1vVi9NVnhWM2VxZEx6OG1LM3NvQ3FkZUJM?=
 =?utf-8?B?ZEg5bzdWckNGK0N1Nkt4V3A4UWs3NzlzZi8vbTZiNmdWSGJ5TzRIYVB1M0o5?=
 =?utf-8?B?akp1R1FaUFU4dnkvWGcvQmhqVk1nZTNzdmZERy9XSkovc0IreDcwQWVUeWsr?=
 =?utf-8?B?Vm9UMVFkMmdBM1ptWFpKVmVBd2p4Nk5wZElRSnNnamZKOGFQU0hQNzJNQXox?=
 =?utf-8?B?VVdxQVBqK0lRWXVWMVdBREE1VEVqa3RFaksvb1U1RnRTR2JhWm5rOS9CSjRp?=
 =?utf-8?B?TnlzdWNONzBYV3pTUHZzcUVFdWNFUm9pT3dicjhSa05BcDNHOUJpWW9GSFlt?=
 =?utf-8?B?WlNiZzdxcWdiVHVScGtNQ0oyUnhGT2pSOUhlcExPZXFlR0JsTjFWcjVrelQ3?=
 =?utf-8?B?Mmxab095L0M2cThYbzg4NVVwWGZqYzV5Zyt1cUU1UzdWSmowMGFqUElkL2M1?=
 =?utf-8?B?OU9KOXg4QVZYTng3SjNGaEVHN21EOUpVRzVaNVgwZE1qM3Q1YW1FbDRna3lT?=
 =?utf-8?Q?ZupXZrM5P/4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnNCcTJmR0djT1hnczgrTUhZcjdHMVB0VkhZbVhFRzJpZ1hHMVZxVGZFU0tW?=
 =?utf-8?B?dEhGcXpYQUlscEpUUVJsVGN6Z205R3czNDFyZS9ROS8wY3UwVHNSUVJyU3BY?=
 =?utf-8?B?dGNGNE9IVVB0RlZ5SnJwWGI3Rm04bEs1dE5hR3hFdE9qanZmQzVUR2E5ajRG?=
 =?utf-8?B?YjVkQkV6VzJPZGNtUTNsemRiRHVvK1c5OEc5YjJwd2t3eVlBL1hSOVRhR2dP?=
 =?utf-8?B?Y2hrRFVzeUhjUHhEZUhsMnFvK2ZPczhZL2J3aUtOR1J4SHF2NzB0R2E4eEF1?=
 =?utf-8?B?VDJocFEzM2srUlMyem45dENnMXlNY0d0MTBDV1BpdVFHb0lSa0NFYmJ2ZDBJ?=
 =?utf-8?B?U3psSmtwYnd2V1pEOWY2NTVHTGtVRExFQTJPcFBpdDZ4VTRNTWEzdXM5Q3Jo?=
 =?utf-8?B?L3lqenhQVFFmKzZvQkJCUFdCYnpXU3U2MHUwd00zZjJSczJiKzg4S3JOQ1lt?=
 =?utf-8?B?SE9MSzBQT1pnUHoxeU9YNGJCcXRRYUVJaFlGNmxBWWh6dGsydEF3UnI0cE1T?=
 =?utf-8?B?Sis4Vk8wZmd0Y2EvVVcvb09hSmxySC9qMVUrbE9MSUJ4TFR4M0ViZTErRlRh?=
 =?utf-8?B?MkFCOS9YZVg2VVFhRVl0am5mamN6MG5oOFF6VjNlVWJ4L3RCN0haSjVrWDdW?=
 =?utf-8?B?MktsRjZOZjFiS1JOODY0UTFxYzZPQ3BZZXpXYnBvaytjMWtYVWtFSElDYUUz?=
 =?utf-8?B?dys1Y2NYNy9yaXFOMHR5OVduZ0pEeDlib3doa3UxVU9uNnJSVXdZMHJZeGtv?=
 =?utf-8?B?ZDZWN2hSNlJOeWN6bThVSDJFMTRhV2hmUUwrQlpsS09paG1pbS9DQWV0YXE1?=
 =?utf-8?B?c3ZFUXFkZjU0b3R3L0dmTllSL01ydjdoMmZaaW1xK25vZ3NCcHlFc1FYZ3Rr?=
 =?utf-8?B?UUtzYzdQNGVXUEJOZmRidXp4N0xjdHZhTyt5dTVmY3dGaGV4cHhhL1pybnRH?=
 =?utf-8?B?VVpzNkdtTktkZUR4RnRRekFkVm1Vd09VZE1TVmRBc2FUaDhJc0FqdG9MQjV4?=
 =?utf-8?B?eWg5QTlwWVdzUmt6ZW5JV2VQSUJmUFZtTi85cjRrQ2hGTWJpeXV5Q2tBTmpq?=
 =?utf-8?B?YVlYcWYyaHQ0cU5qQWxod2JZdG8yNGpTVUxGR3ZxT2kwQlNIL0ZHb0hLeSsv?=
 =?utf-8?B?c2NVWldaSWtYNkVVc2s5Yy9ZU2J3eExMRzdvdXNxQ1V2OHcrSmhSajIycThH?=
 =?utf-8?B?OXRVRkw4QmNxZFNSS2JuNzNqVTVYS24vclRHVjc1UDZLQVJNd0hIY29BR1ZN?=
 =?utf-8?B?WGN3RDFLTXhrODlyeWpNVXNudUJtOHYwamlqZzVUVHlpL3AzZjlXSG96VjFS?=
 =?utf-8?B?K3QzRkpsUjF1NmpLcUwrSWFPWUJlaWxHUWJDUW5Hd2xwUlZQLzc1dVR3dDRC?=
 =?utf-8?B?eUpQUTl1UlVoVWxVTGNPYUZacnV4emNncndnSmprOVNoRzY3U2hXalFKVDFz?=
 =?utf-8?B?N2NVSXNOVXNzQXI5YVVtelhrS3hGS3FVeDltRmFtS21FRUtQYmltUUpMZjU5?=
 =?utf-8?B?anltRk41aVpHdGxHOXhRYnZNRGIvc1picTFrWFhwOEl2aXhkMUFDRVpUcFpl?=
 =?utf-8?B?eElleHp1ckZmL1RzbGVwSWhzN0FVUjU1Z28yUGhJdXByVTZjOWlndk13QUJK?=
 =?utf-8?B?dldycHQrYTNRQ2dkM1F0UVhXaUJhNlNuTHA5ampLVnNGTWx5aW1QUG5RMHU5?=
 =?utf-8?B?YnBiRkw3dUJkN2tYRHBGSisyR0k3OGdSUE1zUFgzVm1BRkJ2b05XWk1MQi9K?=
 =?utf-8?B?cDJQUGhDdzdVWklaa2lUU255RUszQXFSa1FBd1BMSlpSYllsUmNpeHNGMjE1?=
 =?utf-8?B?TmRSa0ExbGdISWF2czlYQnNsdWF2L0lpdDhLaHJHcmpmSENkZTFIL3ZsQUto?=
 =?utf-8?B?S2tKaE1ERVROMXF1WU9PT1Z4RW9qMDhrajRTdGpzSHdNRWpwd1NzUnc4K3pm?=
 =?utf-8?B?TXo3SHAzNlA2bTdGMXpxelpQL3NaTGlZSXRnOWxQVERIYTdSZnRWMEYwbGZz?=
 =?utf-8?B?c3FuV2hqNmRTeFc0QU13ZWRSZk5DSzVsbVRJbU1ScFhpQThxL1ozamVWdjVF?=
 =?utf-8?B?OUZoNysrekFZYU5mODNQSzNwUjEwOXFoWFBGWWNtRWkyT0h5STVLVks1Tzg0?=
 =?utf-8?B?VllDbU85N1lXbFh2bFRTOFEzcVdGTmNqUEdISTlGTXEreGU4QUFVRGhTQ2V1?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IS0d7gf+DFs9SEt0J17lqAxiGgJWkpe3lmUcsSP7bDccZL3pM7wkgb3Jy8QpY4bniKY9tp2oC9fHRz3NIyBu6XyQmiTmqdE81gfPG2fMglaU+29AqADjY1KFQ9RPKbnRpZAgEwVptjG3QheleWtQcSWNS8WJOS+czfpCZ+KggsdbLajODDNPBFztruYjihsIMTMReTSaNYEjTs2fdSqs+4CNkBCHc35fASmehcaC7tcOO2Mt+w9jfKlL8NXmtnF/GH6fzWZlH0wqLKb/i3eILDZITq/oYOs/IyNQFMGbaJZ7dnaYxlLiyjevys97xrJpGvCaa8cVH51L9yH0yP8CT/YSSy0tXcqv5zoU3doWFyBGj0OM7BTaq/r81u/b0aMqm7C8IjSkvBAqXJ0RduKh5F/eC/2AmIHWJ8d5nXhvTTWgBQiQSdtutTq+vpt0LAgmSiym2bCnriJwOBHyOlHkB2eH5lquv63QUVscMGdsJAnveVNi8gKfif9Vvwa2D0DWujyiMOrSiylBuEJPIvYFU8VlMYDTRcLj7ruAAIxPRANeE6yRiGR4hwvvWJVvRYtFdS8/FUx1JIt25kfSwQjk+FJJ1chZNAk49vI0MB3jp9k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c43563d-6acd-4ba7-cfb3-08dd83e158a0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 10:10:03.4926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIrBRw6ZzboAWOeCTVXUD02Q4MkXoSrCQjmD5VLGpjC1w5vZ87WqvcSO4UU1O2m6B3jVStfQygyR5XQdecUh+C5Y8pamTPeP1fDwYba/Ppg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7046
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504250073
X-Proofpoint-ORIG-GUID: jIt1MQv4QZG1M_Z0MQ8xPOyRVEl0Wt0u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA3MyBTYWx0ZWRfX5WV1oGynPCYx jIIWQEoPZF/3W3PY9FqsIRF9wkknKfKpBcDeD7rJ8uoXy+YnGORDpo/h3wQ+EEvaDsufpxDxWjc QbtNuMXEPbAheCnrUbNpKN9FtfQNCU45qOCda6RpI5J9wWRQ0XEut19XL8b1KBqE5t1hYBF4LaJ
 GkrnNumgXbicvlRC6KNAPz0Mf3eKHvupKLWlKGART+9rbtU6KRBF0eiYyxHJRWY2ZTL+bJxBynZ rnq25DX1U1qu0UhRcRL7A3oOc1piCu/AkKBUKLWCdim1AROj9xpX51RY6NsOnu8vBFvHY+phfjg J1C0pKMojQvr0OVkBxLRnR2+YvRMRXuRhi2yNXBgO5cw1s453joAy/MC0vnalHxgVrOJNcnYFe/ bJo5jB20
X-Proofpoint-GUID: jIt1MQv4QZG1M_Z0MQ8xPOyRVEl0Wt0u

On Thu, Apr 24, 2025 at 06:37:39PM -0700, Suren Baghdasaryan wrote:
> On Thu, Apr 24, 2025 at 6:22 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Thu, Apr 24, 2025 at 2:22 PM David Hildenbrand <david@redhat.com> wrote:
> > >
> > > On 24.04.25 23:15, Lorenzo Stoakes wrote:
> > > > Right now these are performed in kernel/fork.c which is odd and a violation
> > > > of separation of concerns, as well as preventing us from integrating this
> > > > and related logic into userland VMA testing going forward, and perhaps more
> > > > importantly - enabling us to, in a subsequent commit, make VMA
> > > > allocation/freeing a purely internal mm operation.
> > > >
> > > > There is a fly in the ointment - nommu - mmap.c is not compiled if
> > > > CONFIG_MMU is not set, and there is no sensible place to put these outside
> > > > of that, so we are put in the position of having to duplication some logic
> >
> > s/to duplication/to duplicate
> >
> > > > here.
> > > >
> > > > This isn't ideal, but since nommu is a niche use-case, already duplicates a
> > > > great deal of mmu logic by its nature and we can eliminate code that is not
> > > > applicable to nommu, it seems a worthwhile trade-off.
> > > >
> > > > The intent is to move all this logic to vma.c in a subsequent commit,
> > > > rendering VMA allocation, freeing and duplication mm-internal-only and
> > > > userland testable.
> > >
> > > I'm pretty sure you tried it, but what's the big blocker to have patch
> > > #3 first, so we can avoid the temporary move of the code to mmap.c ?
> >
> > Completely agree with David.
> > I peeked into 4/4 and it seems you want to keep vma.c completely
> > CONFIG_MMU-centric. I know we treat NOMMU as an unwanted child but
> > IMHO it would be much cleaner to move these functions into vma.c from
> > the beginning and have an #ifdef CONFIG_MMU there like this:
> >
> > mm/vma.c
> >
> > /* Functions identical for MMU/NOMMU */
> > struct vm_area_struct *vm_area_alloc(struct mm_struct *mm) {...}
> > void __init vma_state_init(void) {...}
> >
> > #ifdef CONFIG_MMU
> > static void vm_area_init_from(const struct vm_area_struct *src,
> >                              struct vm_area_struct *dest) {...}
> > struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig) {...}
> > void vm_area_free(struct vm_area_struct *vma) {...}
> > #else /* CONFIG_MMU */
> > static void vm_area_init_from(const struct vm_area_struct *src,
> >                              struct vm_area_struct *dest) {...}
> > struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig) {...}
> > void vm_area_free(struct vm_area_struct *vma) {...}
> > #endif /* CONFIG_MMU */
>
> 3/4 and 4/4 look reasonable but they can change substantially
> depending on your answer to my suggestion above, so I'll wait for your
> answer before moving forward.
> Thanks for doing this!
> Suren.

You're welcome :)

Well I will be fixing the issue David raised of course :) but as stated in
previous email, I don't feel it makes sense to put nommu stuff in vma.c really.

>
> >
> >
> >
> >
> >
> > >
> > > --
> > > Cheers,
> > >
> > > David / dhildenb
> > >

