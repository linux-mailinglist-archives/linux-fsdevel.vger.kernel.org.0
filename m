Return-Path: <linux-fsdevel+bounces-54940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FCAB057DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 12:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85F477B065B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 10:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F80F2D8DB7;
	Tue, 15 Jul 2025 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ES4cqqxu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kMv91vVy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CB62D7807;
	Tue, 15 Jul 2025 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752575524; cv=fail; b=TyC/CdSP+GG94C/Hp4nmA+H5SBEKtqfqATQMlykdIgK79QtuxXSa3Taa4pCLTG1sfVYshDU4tJVxVrDkFcl9DE0xOpZp8fgdvz3CFUwSVbwL+aI3PcNhlIP6mLYJFWW9rNsjpGB+ruONee1FvYRdc6lgSdCQbq5hZmeAgyGx6uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752575524; c=relaxed/simple;
	bh=pDZUgqNKyIwzSTQt4aZX18P9UsWUNTQsigVGn4tGf8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jieaG6O3NGZ5/nibSuV9L3YzbmfLA2NcP/jTNGGxKRVQi50rkiqA74B23Yq6mcs2+qchNf955addhrmOdJBixGX0rYIEdwDykRRYTpcSuIvdNVXiJsnSGUGR2VTQ1jimyKjkpybMfxLf+boO55BgWZ7jWb5aPd6/qN4iS4Qi75U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ES4cqqxu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kMv91vVy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F9Yqu0004585;
	Tue, 15 Jul 2025 10:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=pDZUgqNKyIwzSTQt4a
	ZX18P9UsWUNTQsigVGn4tGf8Y=; b=ES4cqqxuAz6t4MQXReqbt6AZ7vB8th79bs
	9ylppeZD7nTqEzvJ6ge/hARlr9UbrZpuJbwR2rLMEyibpP8qXQ11EdBWBNrpg/Q1
	BVf+ryEIo9zQGzqmH5gf/WLx9Wi8Z5x0XDzXYg43dI3wpzZ4+ZEOGk4N8Yv7vZFu
	+KGYKq3Hj/PasmUI4HdmW8yoTP+cdV0UK+DRwxzhYrBjD+CJZXQEbMA9N8nyfvBD
	i+LgiI7Yq8zdL5PfSR+H9LE2z/IDFA0JbbUHMxhVH2dixt4O35QPe3bgnVXq2/Wv
	+TFNrPEYrcNHVc3BuPPXo3PqScHX7PMZxURjNTdN4QGVgRee8YAg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8fxd3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 10:31:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56F9kCRw011524;
	Tue, 15 Jul 2025 10:31:27 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue59sm95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 10:31:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQR3ThLtYyYd/Mii5N/0fpOk0ptT4s2YNpRLJyqrtbgcZaM03VlSKxLtPSjAgMi8+6Q0XmNfP8e/KwZc9BQbV4ODMS8mEQXbKPOjrXg5Ci8pFcKK0alZ6KFgLzfyGQ+6T0g8+Uukn2bFXYIkc0hLgq2ogs7riNV1Rsbvsfd8beYprU89wUgfe1nWNztSakAU2Iz3HtatKp9FDSA/BOglK+96WKrrajlkqCZ0oCP0Nu9WQV3SAm0Hl07pRRcwd8NA+3g8uHNEt5ERPn8qePUrI4NcNBLnTogwsjMcSlN8+q8wn/yh6uKEShcdheJ//7LQUjsMgK1WCp8tQPSYi5gJBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDZUgqNKyIwzSTQt4aZX18P9UsWUNTQsigVGn4tGf8Y=;
 b=MsQISRMPPHqDMnHy8leJ/cRagktFFuCnjvuOutSypJc1fI055NhppKF4H1qijFWqU155P+TUx1JFa62phGsn3/PoPcl/0YKXtBtUWhyz2np98fAgZvGqU+LQV0xa3Tv9WTxZhgQ5MRgUOfOZoSWuTWzdtFse4PHfBpxa4GG4ydq2OMI+7ToOgaQkQ7K7jwhO5qxkdtmAtZZktd7DfR3/j3nw19lfGvnrxJglEQiQUFQNrDGr+Rkf7RYtcpGb+hnBtn3E6bJpyF6q4F5V9dfrn8327lyTSr/g3phPB3ImPkl3kx6A29crZlQjvy0y01KDi4nFYU4cVLa/6Hr0PI6D3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDZUgqNKyIwzSTQt4aZX18P9UsWUNTQsigVGn4tGf8Y=;
 b=kMv91vVySklEH1Ajhj1ri+KKPsyrRjq1dktgZQ0H2CsFTJnlTTtm+e4US0U6jSSjxpmRm3qQ2GBh+n8a01/XIP4yZ76kMCstM2J7h6oRUKP2Sd+S1+jGs4T9HCiwNMMwEUe1ybNEJUqp9yTW1CQAjdhHY4MjFSFRChvo82Ta+4Y=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CO6PR10MB5635.namprd10.prod.outlook.com (2603:10b6:303:14a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 10:31:25 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 10:31:25 +0000
Date: Tue, 15 Jul 2025 11:31:23 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org,
        peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org,
        mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org,
        adobriyan@gmail.com, brauner@kernel.org, josef@toxicpanda.com,
        yebin10@huawei.com, linux@weissschuh.net, willy@infradead.org,
        osalvador@suse.de, andrii@kernel.org, ryan.roberts@arm.com,
        christophe.leroy@csgroup.eu, tjmercier@google.com,
        kaleshsingh@google.com, aha310510@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under
 per-vma lock
Message-ID: <5f8d3100-a0dd-4da3-8797-f097e063ca97@lucifer.local>
References: <3b3521f6-30c8-419e-9615-9228f539251e@suse.cz>
 <CAJuCfpEgwdbEXKoMyMFiTHJMV15_g77-7N-m6ykReHLjD9rFLQ@mail.gmail.com>
 <bulkje7nsdfikukca4g6lqnwda6ll7eu2pcdn5bdhkqeyl7auh@yzzc6xkqqllm>
 <CAJuCfpFKNm6CEcfkuy+0o-Qu8xXppCFbOcYVXUFLeg10ztMFPw@mail.gmail.com>
 <CAJuCfpG_dRLVDv1DWveJWS5cQS0ADEVAeBxJ=5MaPQFNEvQ1+g@mail.gmail.com>
 <CAJuCfpH0HzM97exh92mpkuimxaen2Qh+tj_tZ=QBHQfi-3ejLQ@mail.gmail.com>
 <5ec10376-6a5f-4a94-9880-e59f1b6d425f@suse.cz>
 <19d46c33-bd5e-41d1-88ad-3db071fa1bed@lucifer.local>
 <0b8617c1-a150-426f-8fa6-9ab3b5bcfa1e@redhat.com>
 <8026c455-6237-47e3-98af-e3acb90dba25@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8026c455-6237-47e3-98af-e3acb90dba25@suse.cz>
X-ClientProxiedBy: LO6P123CA0059.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CO6PR10MB5635:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c50cbc-5d06-4366-13fd-08ddc38abff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IHWxqnaA44DBvklVod+OXJcHzPJtII1hfbVrmzY5ovEDWksbo6JK2RHJBcY+?=
 =?us-ascii?Q?k3ccCTRzoG63YmidF1afdNl0f7V6cSv+TKKmBzjtTLGaWAl7KwH+XmsWJjaO?=
 =?us-ascii?Q?nGwOnYMvoKyPs4Y+intR1k8LartIvFMNIw/8F85RMBNJhm7lXagpEqXIFszY?=
 =?us-ascii?Q?Nqv6WVdK4eDYzZm6gBNSqyJXA6OSvJIBm6K8ipY3I8QZmu9WS2R/xCNO9FXW?=
 =?us-ascii?Q?FjrNzhJkurLK9FY+QdTWG59XUks9aAV0nZ3EXm2jh1//YPN94l/u4vvjlLvO?=
 =?us-ascii?Q?ZBoTwmcRT1wMY9nO4JCEdgeACklXoJh4fIfq+s+5XxXSem0W/bpUGQE76eKK?=
 =?us-ascii?Q?bBBsrJjbKWYFo4JYpy07i1zfK2ep6Mn//i7Ahaee+RGfia9gopEWQdKTnLmT?=
 =?us-ascii?Q?V/4fkw11O4izidlho3odnz+xOWrJStLdK6dkN0ghGfhp1akzH7IjNfeM+nsh?=
 =?us-ascii?Q?OvRn9DAFSwsqUh7cr4FpM5PTZFkDMgezYKBVCtdDQLQb2znJZzg0eqC3okFZ?=
 =?us-ascii?Q?tsZZzmsKoKPbtkXw3ob3yEzM+G9KMjUofgf/esUNjGyN9nIKuqjxco/5AlFZ?=
 =?us-ascii?Q?tXd0No7iRlWqzwewXTFn1FVnHM4UmIkz0X9PYRz61xIU/drt4tFmikb7W0Oi?=
 =?us-ascii?Q?K+E9DamqJdnjvtxFuXPcEyx/wTb4uN4GY4qvW5KMl83TqBRf4YguG9H+zTEH?=
 =?us-ascii?Q?Q4UhomsrTvmAmPwkhPL8BVmdZVqBqBbBEOdA4qHOShsDG4YGC9qN/hLXrLej?=
 =?us-ascii?Q?SdSHXyh8o9cMF4zBFn6WfCID90isdi/+ABVXcQ5yLCrnkeRf9ohOse/8otmE?=
 =?us-ascii?Q?HoLzUphAxh05yRzci16/cj1Kx30qaYA8oJsTdSsn1UyUAO6kR338UNCgw0N2?=
 =?us-ascii?Q?cA2qDZ8IiGf/0LH0q1Wlw1luj/s7bN6gdFPATCFud29K/XyGd7QLur1E3xHS?=
 =?us-ascii?Q?XZeLaCHcdSkg+ztO82ccP/NP9PGJTmmmS+SFnAt6CwuSfHDQPEboQtS1tpTR?=
 =?us-ascii?Q?ajYM7C/pbdxeNwX1p0CK4IUUFgnhT7eLcmWfxMN4UtxeBJTtHwBawBci6T9A?=
 =?us-ascii?Q?Uza7F0jJpthA09JwmNPwuZooNiBcAo+fpp90MzLMREoKmuFFMjXeGTp9ksX8?=
 =?us-ascii?Q?cj+3N6JmqEUjLFUaBBaejSl1SdXDLuPZq9Sm77pky5q6ZkB/NHpVg2nK3mSX?=
 =?us-ascii?Q?mc1tTKJ/5BzCFHr8lrr/HTtuqyjLMJjffrGAEBSqMo4gkaYhHW1eqqkQLyG5?=
 =?us-ascii?Q?zxbB0PdmGgorVnDtnxAuYXEUwv1LbdHZtf8rBLkhYXp+PUA3XKfMavBVyZVI?=
 =?us-ascii?Q?2obXU+TQWOGIlH9n8ijGNyry2om2+QyvIcXn28spVsKQBqWZVYko4QA4c4FP?=
 =?us-ascii?Q?ZlInmZqs3pTGPKLcEK5FC0KTX2K/2IPDXiPvSu4bdj9XrzFP3r1kvpNa/Ajc?=
 =?us-ascii?Q?SIqQdso8MKw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2OjFSKUIpnH5NnhpWhL5QxfNOunAidaXpbV/MCDPLHm5XJe90hqyXuBCKPNk?=
 =?us-ascii?Q?eiobs7skq55bGwB1OrbcQOUpzbzH5hKOMZkIWlcLnR03bZqL7HTUAWrYWQHd?=
 =?us-ascii?Q?vz+UAQ9EToQprZwTRqkexnUBy0MPnPpWNhaupsufLKXgGTrAlvo8v9v/a0ZK?=
 =?us-ascii?Q?BqV2El9RZDuJDaTlmRymUzrPqVXTR3DmxsOcv5AeC+SaL9w1dY5MPRwutrRx?=
 =?us-ascii?Q?ivt5RkcEHnjDlfRx6YWillwjqaS6NLi8Ddc5IraA6x8y8ptIcsvGC887zvap?=
 =?us-ascii?Q?LRIAVS2bPl1Ry/0Qhi/uXerMGTbCMh0dAwwLlMzFq/UFmdTdR63i3Gt3Wd9c?=
 =?us-ascii?Q?mns6wPaT6S4IyvoPNfZ4j2BgEZTI1P4V3V+SUmZ8PGaCUVEzZK4hSvApHEWs?=
 =?us-ascii?Q?oikWr/ftdSdiq+8u/pGyCttGtySLa1fxmBvlXr6cvEjsRi7ncMiKBAT36kbr?=
 =?us-ascii?Q?AazRhOI6+lA+CgDW2N0Uriu0W/01srE+VxnwUWSNjpCMWvkyBCabZaomWqUA?=
 =?us-ascii?Q?w16cjnReZT1Aq1HPssjJSJqDanHAtLP6FKh3pz5Qe2PFjpGQ/2ImiLnUUwlw?=
 =?us-ascii?Q?vxacXrPelIoqStOmCYodvXa+gReqVIDKJhUq9roG8BT1CUj7SrfGjf3UMPYm?=
 =?us-ascii?Q?o2icoK1E6Wdd9cAnFJlMHg9FtTD8FQcjODC+675Qrq42m83MeBu6xlmuHSEn?=
 =?us-ascii?Q?ZHtjQ3A5Zq8K5486wdaLi4ObGkeR1KgmfIMcHybJwTV+CILwz/d4MItaHNxi?=
 =?us-ascii?Q?gz+VFVjPF3O/CAhAtP2xNJzZZFtrYNO0EwUzXFyRvLYVV5CBzp+kew7usROm?=
 =?us-ascii?Q?IEB8E6ew2vwF3z9+sYgTDobS7sduBmHkfFv2zFH/8QCUP4XgOfcWGyIuABVB?=
 =?us-ascii?Q?wqKwdYDqSP/epcpf+PN0m0wT+0XTR3Knwymww42L6+Zr59NHiiBRzKbEnoVa?=
 =?us-ascii?Q?ZgyMQtxEhIxFv+TFU47CpQa/Ugw/x4EFIiKUtS7Us0o+Vud0LQz9ElMeHFwP?=
 =?us-ascii?Q?fQGWzPJOq7OwzSiVH8Ik4Zsz1OezuChLRT9+cyaD93kkmxBQn4P5cgkvMwgD?=
 =?us-ascii?Q?Ga+DD+cS0H2Vik4ZqBWYpsiN7Thy63efVAxUP1uKkn9NJ6AIMUIdHvjwO/6h?=
 =?us-ascii?Q?Dt/NgpEk5synhOBGWyKCmhrplgVtA5+05XYpQsy/XVq+1tvEky7RJA3vRC5k?=
 =?us-ascii?Q?1hHFvtTFJnlZernoMmheXLjNg7+aqiJn2Sn16TLjicT+w7UjnLJUFBal1mdh?=
 =?us-ascii?Q?T+dQoWEg3jGaDFr8CwNrGWGl3GwqN6ud9OSKdsJR8uYUJ19CQsu2E9Qdingn?=
 =?us-ascii?Q?yUx8e7xXpnCGeinO3Ze2iPMCLo98Ll1Bv+ewUfhSZFBXz92Yrp4Xtk/4AVPN?=
 =?us-ascii?Q?+uDr28abkjpx8FYkot+wklVRacmDO3HSRnLYz9K0g4tzXmYcJZtaFtNwXph9?=
 =?us-ascii?Q?4Z3wrCagGKABvx3DTjRzLRSP4bCjqkF6hhk+w8fVqBdyrKoEV6nDjk8x21zP?=
 =?us-ascii?Q?NYdVjpLSVJcREY9XHtcThfRaqQCriTIQxRIzWslDbSDpr+Ywj5acJvVkp/ND?=
 =?us-ascii?Q?JUGcpQWf6PMrTOtRc0VWZyGInddtT8ukI5VVEoCFHjsxlEOQdnk5nRfRiOy0?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qHnfzgwF51u+7LSNYBY+CXUeaARG5JTA/mhIZOHh9wU5JbVHm019aZJIQG+z2B89ECGuKVwzFUYNxJoV7ESVV4uNzLnEaPpRYwyT/jc4M7FKHzKNQLdROUTKrxUrYXAf4SOq3BOIMiAjyBJSroz+hm/V50QKlL71fSN4Oq3buyAjguIssWoMZ2rjYWsbnQN6vSY0PcNQQjoh/o13vH2qKgvDb4jjpQU6CMOgaX5dHWiHoOKFs5VZdj1LOfZmyeOXyIMdgyqsUeKJ9JMzYy6Gh1/joABA7RhB6BlTEPNZXFdd+//BMG2vNs0T/Nm3QlolVnyrVO0s9LYp1wCkdD4RJFq/hOmOII/5XyrfEUa6bQPhZ+ONXeTUOt8qqeVAWKVFbOqYfnAxDfvE4x6ifhQbn4uJHO3mdN9YA1jgHwMn82Zb/DHlRGzWc0CiHU7UMm5avCwSr0uWqrQzHCM4+ePeAazhr8HW5A7cLA9gdNRkZYz8nxsNqKcSn2FX50gj8eAzEpFnXBYiPuNrQlULFwBv1Xjo68URGnWOlay7wi+64xOPaRUOXcw0NCvG1i5T5H5/wOmLwScCKGYLN8aki8tc3G6z/5k8vusqILb/2hAorvg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c50cbc-5d06-4366-13fd-08ddc38abff8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 10:31:25.0710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZizgz+X2jYwxwQNIAwNIOXpC4n2aIY6wbV2fdaEz8W5Av43bCHsj4oyfSPDOwPHeqr8WT7BAu5m2EUyemgA0qGLen2ZJk7ZgpdF8730d3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5635
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=964 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150095
X-Proofpoint-ORIG-GUID: fx923-gWuEgfpZzLMQgXsDrfrQ20sRXc
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=68762e01 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=q973cxMlA7QGFGVs52UA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12062
X-Proofpoint-GUID: fx923-gWuEgfpZzLMQgXsDrfrQ20sRXc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA5NSBTYWx0ZWRfX2usH5pHFJfei KLIcp6RIrlpyX+RenAL0k0nVfjmU1xPWWuQPBQP79N0rMMMXySSTS0JT6Fo5mBCGY4BXJVdOBFC I8SsP0fN4neJ8q/JcBoPwHKXIFyQ/3fSsNArAPQJMFa27oZ759tKVloX/AndTC4XF6V2+W7WNsl
 a6AS1NAJ/An2gISw4VPAHU+BqdI/3VqvHDEqLhhRlgc8Ojyzqpc5iL/RZLFazKoCevtcNivFgJf OuWW49rmz38LJLx1CL8twPPq3iD09A33pfe9pxn4RoU1apaJmrKCaQ2PHIYCPszLmBl1qDmlmHI Wvqbdvm4gAEjY/jYebDxaKru+DzZEdwn1s+Wm8FbAPXFcBO6CD/ksV9zVdNon1sC4nhEs54BwEf
 Y6SmZcx0G0IP4ZdwOk8cN8YYr6l5d9JpsweXJqaRGP1bv1Ezyf/YAUvgigHNzIO1wJJE05uR

On Tue, Jul 15, 2025 at 12:23:31PM +0200, Vlastimil Babka wrote:
> On 7/15/25 11:52, David Hildenbrand wrote:
> > On 15.07.25 11:40, Lorenzo Stoakes wrote:
> >> On Tue, Jul 15, 2025 at 10:16:41AM +0200, Vlastimil Babka wrote:
> >>>> Andrew, could you please remove this patchset from mm-unstable for now
> >>>> until I fix the issue and re-post the new version?
> >>>
> >>> Andrew can you do that please? We keep getting new syzbot reports.
> >>
> >> I also pinged up top :P just to be extra specially clear...
> >>
> >>>
> >>>> The error I got after these fixes is:
> >>>
> >>> I suspect the root cause is the ioctls are not serialized against each other
> >>> (probably not even against read()) and yet we treat m->private as safe to
> >>> work on. Now we have various fields that are dangerous to race on - for
> >>> example locked_vma and iter races would explain a lot of this.
> >>>
> >>> I suspect as long as we used purely seq_file workflow, it did the right
> >>> thing for us wrt serialization, but the ioctl addition violates that. We
> >>> should rather recheck even the code before this series, if dangerous ioctl
> >>> vs read() races are possible. And the ioctl implementation should be
> >>> refactored to use an own per-ioctl-call private context, not the seq_file's
> >>> per-file-open context.
> >>
> >> Entirely agree with this analysis. I had a look at most recent report, see:
> >>
> >> https://lore.kernel.org/linux-mm/f13cda37-06a0-4281-87d1-042678a38a6b@lucifer.local/
> >>
> >> AFAICT we either have to lock around the ioctl or find a new way of storing
> >> per-ioctl state.
> >>
> >> We'd probably need to separate out the procmap query stuff to do that
> >> though. Probably.
> >
> > When I skimmed that series the first time, I was wondering "why are we
> > even caring about PROCMAP_QUERY that in the context of this patch series".
> >
> > Maybe that helps :)
>
> Yeah seems like before patch 8/8 the ioctl handling, specifically
> do_procmap_query() only looks at priv->mm and nothing else so it should be
> safe as that's a stable value.
>
> So it should be also enough to drop the last patch from mm for now, not
> whole series.

Yeah to save the mothership we can ditch the landing craft :P

Maybe worth doing that, and figure out in a follow up how to fix this.

Or we could just sling in a cheeky spinlock

