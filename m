Return-Path: <linux-fsdevel+bounces-30511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD8798C018
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 16:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72E2E1C23799
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 14:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11B11C7B65;
	Tue,  1 Oct 2024 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SM8HjVfZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zx0o535Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344EF1A08A8;
	Tue,  1 Oct 2024 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793153; cv=fail; b=A04sjSQXqSnA5tpQbwmpkf/zVpMXU3OJddOuQExw76WyWsCNWWx2rqdk6Kw6FxpQX8oqpDUnmDEi3p0GqmHeWjTmwrQoJFtknSvRxNsKCiKU1XZtCexVHBi4fL8w+EdAx5S7SGBqy/72yTAxv+rsVWC3yAjWUL3Hyaso/YamFnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793153; c=relaxed/simple;
	bh=ErSd47Pu20d8qH8GWB80HRcKdaU2aCRswdce1C1pdHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s/55M5qMT10P5lmMTRahqUVn0aJYoYZbNKtvZxK1/3B2WqZmRs8znOLafZAN6N9DcGLoGksdDlFPbVRRWR3epZETnTZibZWYYcKPmRkPs4MI5g0GVZLq7izs4LVyVzbZuSlFAH34P0mEMoew+WddzqT1lCrSA3TOHbytbcTaSAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SM8HjVfZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zx0o535Y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491Dtdvx004843;
	Tue, 1 Oct 2024 14:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=6avCplCTQxl4hPR
	voEDLaWHkR3bpux+kCRsOfHud1jM=; b=SM8HjVfZAT7YGE8Lxl3XnreoLYrLLTs
	Ipr+pu3X6RyL6sUQAcNOurAJxVsKLgu0orBRoaGOHYpKmyc1DwqFs9gOG/YqXdoW
	vP3CUyuTxZHC7MeLxc4DUgoikHN1KaTOvYpRvgqmWGUKCv7kPAHTfibEv6UBEsj0
	C+39scppBj3SVQ4GYoa++w32rFHpJFpxV6yx6gMqHx+9GWlC5Volw4v2iVw9xN6T
	T8ZRQri99YgNh3z3nD/AY2LLKPtEpog+dvlHIntGbB8AhN3RJldEbQzrrhMKgkk0
	sIxf/0udnTL9hVqPdEk+Ywf1RbuPjCUg9qfzcFptV+Ee1OvsknDyAzg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9p9pbc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 14:32:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 491ERrM5026229;
	Tue, 1 Oct 2024 14:31:59 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x887n4sv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 14:31:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khwHDCG+eBbHHtK3pnP1cehvn1ojMaLA8xcUbJxprPt1pF0ibrs0rmEKDBvtErkcUriiFIeCUH5NV304CHzifdkUg7J527lPHrz1+09vXyB0U/gpTWjwtUtBwARv2ECKKZf9yyuHgtBjUzUOAQOUN4IW13QY1ABVD1AuHC29AT0F7xJhCljJl6WMVigKdvcbTycMazTjTeCSevhv4ZrUG91aFLmmDSEANzUS9chchvQD7J3x9xMeRABfvGQt9gwFCjk3FwrOwO2q4HWvHuuTTFQgcYoCiBTABIou7E45Aav4WHJ0QBlCZogOditmijtA6POj+erdYHzC0rFcNAUJ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6avCplCTQxl4hPRvoEDLaWHkR3bpux+kCRsOfHud1jM=;
 b=ghhjtMQ/MJspzxgV1ObzBu6k72O3PRnPP62x+P3FSgpfE+DrfeXNmdk+EA7TFm8Y2EcmeScsLeuP+Ay9hSa1EijsesYPkY7stuEZT+ZTr4wSCUhGq9RE5JgETb4M+5O2NLPveuS9B9mFQziy0NkvxyKHByCvERZa1H7nM6/AeT+Odz5JKHEPwZjtf9Th92d6KwUwaScQgSlzibKdw0diXTB0V5d0DCOghdMI7HAgzmf6i7i8/iL5rTCGoXjXuINXw7c40BmWXac7+lC6bKAk6zudEq5lcnxyv7KKuN0bqS27Mq044ISV94pd3YAd+rVqwuxSFpM77DOn6FV1gHHKrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6avCplCTQxl4hPRvoEDLaWHkR3bpux+kCRsOfHud1jM=;
 b=zx0o535YdjKJ0h4mQagQT2ayrHtZqP2jwZW7cM0ngNo1gVmSx6WvJHErkhbC/+kmoBiP2eq9/Ze06eq8siVmv4LF1dPnasysywt5jNpaXSRt5rYAsfD0siSNDIApZLsegiQsVdv2ySkZvBLMqha3lIjLd36Y2ciJKbo0s6/HqRE=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DM4PR10MB7526.namprd10.prod.outlook.com (2603:10b6:8:17f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Tue, 1 Oct
 2024 14:31:56 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 14:31:56 +0000
Date: Tue, 1 Oct 2024 15:31:52 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] introduce PIDFD_SELF
Message-ID: <1d19f18c-5a60-44b5-a96f-9d0e74f2b02c@lucifer.local>
References: <cover.1727644404.git.lorenzo.stoakes@oracle.com>
 <87ttdxl9ch.fsf@oldenburg.str.redhat.com>
 <42df57ac-d89c-4111-a04d-290dd2197573@lucifer.local>
 <20240930-verbiegen-zinspolitik-cafb730c3c84@brauner>
 <cdd24e6d-4300-4afe-b2ef-1b8ee528bccc@lucifer.local>
 <20240930.141721-salted.birth.growing.forges-5Z29YNO700C@cyphar.com>
 <8b1b376b-3c4f-409a-b8e4-8faf3efecdc8@lucifer.local>
 <20241001-stapfen-darfst-5fe2a8b2c6ec@brauner>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001-stapfen-darfst-5fe2a8b2c6ec@brauner>
X-ClientProxiedBy: LO4P123CA0210.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DM4PR10MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: b06d8358-d5c7-49fd-a911-08dce225cce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+DIXFy8lH3iKY29X+EbPSS0uD7/4g0ZnRXDrq6b78srMRbFRdKnjO2e8zfbG?=
 =?us-ascii?Q?iQf+toiQrQOwcRsDeBk5BRQBxwUvLnCpQfo6M+PD6Dmf+I3EjjeUMXIOvIcm?=
 =?us-ascii?Q?iFuAOS0dxC2HFyEmVRPMQ8/SeqVvr0z8R3UFFWjxYqi2TKcmntXxZHG2ax0q?=
 =?us-ascii?Q?MZKMHMrgMcLXqhSLo76zcB+uDBcyLF6jr0nG0d3byK+nJTXAFqwv3TNpzxIp?=
 =?us-ascii?Q?Htu/AjSqTays80KZbPLwiYeM/bfT2ZUd60Ur058y6kBIt+SBroy/skFQPieH?=
 =?us-ascii?Q?bqY1I9HXREQ+5FTDzjzTMO/Nrvevdwk4f//P0fY6IdIDjAv94ChsjnqDCrDG?=
 =?us-ascii?Q?EXnrpFd1F9ann+qrsAv4M//cA/S+/95mVcYBBz3KK66R0c1LFzrqyC+nTQ2n?=
 =?us-ascii?Q?2hBPa8q50GlCZoehGBlC8OmhQQUTDt0EaXgiwweY7EKifE9/ZDvCc05u3nR8?=
 =?us-ascii?Q?YWZ2IWnsEAR6w3S3ejWZk4WASFr3pm3I/+j5Dj9EdHCN4AXkXYjITjqO/TPN?=
 =?us-ascii?Q?wO/8R2WKElQW3QULZkhztUtTNpP58F/6VoTsPbZaPqJBUOHWnhjMG8IRHETv?=
 =?us-ascii?Q?2R04KmlDXdUQvf7PgBjDbtyLRRcIugOJ71D0ZOH7csTGvIm/qzwjO/d0id3Q?=
 =?us-ascii?Q?GzF/rFb+BwfV1GqMApHhmrfWFpKQ+Lyiq+INGuRLuwB8r+cOZaiwwk8ut3St?=
 =?us-ascii?Q?MVVJotHKeHeIseW3azLt3Bj+WwNiuj3gMptj8UWNjqVCFTbwCrDe0p16ZhDB?=
 =?us-ascii?Q?AvMZU+1Qp0KuCpZ2wZEObJQps7Lw+z5L22tNyOe5CWbTp8gVrxoEZAX8LKMz?=
 =?us-ascii?Q?mp/r15Oz2GVSLlYqOcwnIazz7J4FtiblRpkHi61igt6vrCtbNDCstKtxfCV/?=
 =?us-ascii?Q?XyoP4ppPqknJGAHwOkvIsnT8NGVn/tf/bKfe7aj5KsSspAhTgxctDp5HBFHN?=
 =?us-ascii?Q?91Kf23EVa53J+outXqFBV3IZbr93OoeWXP1vXlYoAH660VBg32/h+QxGXrM1?=
 =?us-ascii?Q?37LgCc+tOWeOR7nG5FqoQi3S9hXT2B3lRFVBzwwjSP6UZbBUlrxYPAHu6AYM?=
 =?us-ascii?Q?GYmbKUwSBTs3A7A8NuIPAYROISymlk3F4Xc0FaCZtR6DoVv1UJ+QD+Pq5+n9?=
 =?us-ascii?Q?0Pj6HkTbrKgY3AwPt7kBdo6XRVNvHLxBM4WGjiY79L/TIbXC8ChUFAbtwVR6?=
 =?us-ascii?Q?tn9MIiRaepfXjQ3x4CjIqelyvW2dWN3csifAeXfudYtxIOYle19BcLUF5T3d?=
 =?us-ascii?Q?nK1tuOa4D6dNNNG3/3Vp+o8Oc6VCyi7fyriXDY3KbQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4M5QFlvbcLsc4Vl5RO7MIjSNW4FhLIDml66cztstWsUU2zUnWIlKrjSIsx6s?=
 =?us-ascii?Q?tKaVsP32VK2Iw1dIEi21xlFZ5zVfu7rQwayJJm3PTZF6ypi5hoOUpEpeUH7L?=
 =?us-ascii?Q?C3sWsJECKW9Hopk0dXzSV7Tcbl21KTCyufzTxzZ0vYanBbIU/HGJ9vuUbdur?=
 =?us-ascii?Q?bcwZxSbB6+i5Sep/aAG8b47y74tqs2jxeqzF48Ia3TXJFAZgORwLyWctLd2f?=
 =?us-ascii?Q?LwfwTwsQ94JRXvjVkrM38pOEyr10myuQnT7+BQ0icCpGvCTJBR6uhPx9SqZ/?=
 =?us-ascii?Q?o/UQHThyOM1gZU6/+XZoOfjyEN9qOo/L3pb90E/eB9v3d5SxIscrLZX/cWDo?=
 =?us-ascii?Q?JMf8nLCQm/eSgYleHpWfLog7bQhKrF3j68pKdPgJVxxCijs4v3Vgsdlptd+G?=
 =?us-ascii?Q?eb0gyny+ewpYnGhOWbEDoQ5wlY6UUCKmAqU6oxJyfU2m6gpTWlvWFjxPZnHh?=
 =?us-ascii?Q?S0ADpJ1YknlkU+KNIDeGYFzbbXwmZqza02NsV+5503zisZ/lXDktIs4em+/r?=
 =?us-ascii?Q?0yCxWwzOqb0cxachnNIARabsIvTlWd0RT1NElW2zYNWANLB8wINEYIbF/dsb?=
 =?us-ascii?Q?QBpoFDSDtcsIeY5dzTB5Is2DBilMDkLjxFY8Lf821kAfx+hY/+51rxHtMzxH?=
 =?us-ascii?Q?b8D3lXDaKWTSZj4B38P/r8/bYfzcBLiSnJLnccafKeMJ1Uu8+PJUernrqH3J?=
 =?us-ascii?Q?nTr5g4d8K6/EnRNhzNrHBiMLHT+JJgyJ0YjLO9pfLCgF056A42ATp4TrUJ01?=
 =?us-ascii?Q?y3F4CDtG4wFjI6wWX2sCOnfLh+hLvUOpXwnSOuaeXLVqxI1tSoJ7lhKhcIzr?=
 =?us-ascii?Q?7CKTITikhZSqhvM+IZGee9U4lmTdPJ9jYtz7K0HvrluHJASSUmvgZj1XOOOi?=
 =?us-ascii?Q?Ry5IAvJMm8qwVjyIkxWipb+3IA/OYznPwfKvqNmFvqe8VeJnw54mJWF8f8Pg?=
 =?us-ascii?Q?dBeJs6bBgVuRMuWUWftKJH4/D0DE/WkrlpvAYp75CFNamArYfVFbp5U85/dg?=
 =?us-ascii?Q?qZSVkJ/3kC8zSkI5GLGbrdhDUW0gM2F1w/gMwwuKcIKsLl3lsCTvCc1+U/N6?=
 =?us-ascii?Q?lGLaEux84DDJ5d8OcZ55+T77VEXhhLIy23k/PkWIcnvaIf9zqHj6m3sphKmd?=
 =?us-ascii?Q?M4v4uLcOZUWyi1l0yeRDBA41DJIF36wJb1kw+QMcencI6MGNw+bkTrIHDmi5?=
 =?us-ascii?Q?51ocfmomR2q0UNnyEFjG0A+ycTg9104L0bsugCh2c/+e8/YLkW1Pv/p6WrhE?=
 =?us-ascii?Q?TRAfZDg4sywBOJAZX4MZ3FfbxPBjf2Eg0XBA/Iq4XJFNJcZ0EtVl4vp4uT76?=
 =?us-ascii?Q?Jb4arvDjEeaF4p0wUaVWIFBohd4qJbtRFURUrOaH24sTLhE+unxqQgug+DKB?=
 =?us-ascii?Q?E1YNyhuOsp51wzfS+AFwyL1TMIar1j4pkO7OaYt0oi/wcU+fVRTYZ8mTQi1w?=
 =?us-ascii?Q?YgXTuMKOAw8Crjwbngynyrc1DubL4568+A45EXMAdrWXrmKOriweAoZdO011?=
 =?us-ascii?Q?Edq0dm0ANtvNeuFm7V0v1pZNr5QZ05xzveLJ251OQtGJDZr2a8FdLOLiF137?=
 =?us-ascii?Q?rp2v+XfPlOJMnGVXMpVDdTdDF57NFPkNYffr9uMBlW8+6qRUUsiIL8nkVBMC?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BsBCIGJO8uAIEMRXln9fk0VycE9FIGxVW1n0EVYnIgfEipzxvzyw3xgamRQKY2rFgx9pm8AGYepZPX0O+fRPtTcXFc4huOFbNvABHRzm5UpUL6EIGN2j4TC+bTeLS667HUNM3pGukNxA28AeiZVJLq77oRmEUFTNg6ScDa79qj0tMfDwYr8KtDPl2M+pz00Xf9HyegoFjTbidPTKXmEddd0UOJMVVbVuZz3Gtwmol0bKLfHjn91wJTbAxGvvBSsLuZ75JN8ru2UCjy0u0tqBnZLyxNaQ7mWDLJ2yt/VvQqhgGTmQGTEb9ssWUSzeWAX+1Zu3Wp37tlXVtS3YVxbdc17Fc+s1SEly/dmsLJbC4rrjT+htPS0u5rtVzI/5qozDixwsN//6xVNsNW/k7cEvW/BjH5HM5q49to8OSxhVMIAcqnMLLnASAXUl/ug4Tk5ENNdvT1H7xVYrxWJQs723mxxLu7Uz69ldaAJiKAkiGHwbRk77IDeApEg9sjAKxBJp7tfLHfUsPa1LbrgWcOLkq9DJb3xefN0GazgoqCud3+ayQYUm6EQpuBmYwcql35HZzYY+BAjo7qg3FAobZ2mZORNn1B/7HPOO1Bz3aSbfHu8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b06d8358-d5c7-49fd-a911-08dce225cce0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 14:31:56.0087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AS5U/U07o4RBh9YS5fVVqozqFV/Dp/RL78B+IEv0AurMkXcNXpWvUiuHYnQsS8X6cvFc+dW5Ew+VwClaky4VwOphzT0wO+3cNBhDdlcluu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7526
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_11,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410010092
X-Proofpoint-ORIG-GUID: iyST9O3o4KUWUg71ApmzDoPaXB83Mee6
X-Proofpoint-GUID: iyST9O3o4KUWUg71ApmzDoPaXB83Mee6

On Tue, Oct 01, 2024 at 12:21:32PM GMT, Christian Brauner wrote:
> On Mon, Sep 30, 2024 at 03:32:25PM GMT, Lorenzo Stoakes wrote:
> > On Mon, Sep 30, 2024 at 04:21:23PM GMT, Aleksa Sarai wrote:

[snip]

> > > Sorry to bike-shed, but to match /proc/self and /proc/thread-self, maybe
> > > they should be called PIDFD_SELF (for tgid) and PIDFD_THREAD_SELF (for
> > > current's tid)? In principle I guess users might use PIDFD_SELF by
> > > accident but if we mirror the naming with /proc/{,thread-}self that
> > > might not be that big of an issue?
> >
> > Lol, you know I wasn't even aware /proc/thread-self existed...
>
> Wait until you learn that /proc/$TID thread entries exist but aren't
> shown when you do ls -al /proc, only when you explicitly access them.

My God... You're right, that's crazy... :)

>
> >
> > Yeah, that actually makes sense and is consistent, though obviously the
> > concern is people will reflexively use PIDFD_SELF and end up with
> > potentially confusing results.
> >
> > I will obviously be doing a manpage patch for this so we can spell it out
> > there very clearly and also in the header - so I'd actually lean towards
> > doing this myself.
> >
> > Christian, Florian? Thoughts?
>
> I think adding both would be potentially useful. How about:
>
> #define PIDFD_SELF		-100
> #define PIDFD_THREAD_GROUP	-200

Sure, makes sense to add both.

>
> This will make PIDFD_SELF mean current and PIDFD_THREAD_GROUP mean
> current->pid_links[PIDTYPE_TGID]. I don't think we need to or should
> mirror procfs in any way. pidfds are intended to be usable without
> procfs at all.

Yeah, I think it's important to ensure the _default_ choice, so in this
case PIDFD_SELF clearly, is one that will be least surprising.

The proc thing is sort of pleasing from an aesthetic point of view, but if
you followed it you'd have to _clearly_ document PIDFD_THREAD_SELF as the
default.

Happy to go along with this. PIDFD_THREAD_GROUP is also clearer as it is
distinct from PIDFD_SELF (doesn't reference 'self' at all).

>
> I want to leave one comment on a bit of quirkiness in the api when we
> add this. I don't consider it a big deal but it should be pointed out.
>
> It can be useful to allow PIDFD_SELF or PIDFD_THREAD_GROUP to refer to
> the calling thread even for pidfd_open() to avoid an additional getpid()
> system call:
>
> (1) pidfd_open(PIDFD_SELF, PIDFD_THREAD)
> (2) pidfd_open(PIDFD_SELF, 0)
>

Hm, this is a bit weird, as these are pid_t's and PIDFD_SELF and
PIDFD_THREAD_GROUP are otherwise (pid)fd's.

Being dummy values sort of allows us to put them into service here also,
but it is just weird, we pass what is usually a pidfd to receive a pidfd,
only this time it's an actually concrete one?

I'm not sure I like this, even though as you say it avoids a getpid().

If we did this I'd prefer it to be a separate name, even if it has the same
numeric value (I guess we also might want to check for anything that uses a
negative pid_t to refer to an error or something else too).

Perhaps PID_SELF and PID_THREAD_GROUP?

> So if we allow this (Should we allow it?) then (1) is just redundant but
> whathever. But (2) is at least worth discussing: Should we reject (2) on
> the grounds of contradictory requests or allow it and document that it's
> equivalent to pidfd_open(getpid(), PIDFD_THREAD)? It feels like the
> latter would be ok.
>
> Similar for pidfd_send_signal():
>
> // redundant but ok:
> (1) pidfd_send_signal(PIDFD_SELF,         PIDFD_SIGNAL_THREAD)
>
> // redundant but ok:
> (2) pidfd_send_signal(PIDFD_THREAD_GROUP, PIDFD_SIGNAL_THREAD_GROUP)
>
> // weird way to spell pidfd_send_signal(PIDFD_THREAD_GROUP, 0)
> (3) pidfd_send_signal(PIDFD_SELF,         PIDFD_SIGNAL_THREAD_GROUP)
>
> // weird way to spell pidfd_send_signal(PIDFD_SELF, 0)
> (4) pidfd_send_signal(PIDFD_THREAD_GROUP, PIDFD_SIGNAL_THREAD)
>
> I think all of this is ok but does anyone else have a strong opinion?

I think it's fine to allow all 4 and we should get this behaviour by
default (if we have no flags we use the f_flags as a hint, which will be
set correctly).

I think people might find contradictory ones, i.e. 3 and 4, strange, but it
makes sense for the flags to override the pidfd (as they would for a
non-sentinel pidfd) and it makes everything consistent vs. if you were not
using a sentinel value.

So yes I think that's fine.

