Return-Path: <linux-fsdevel+bounces-9725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C94844A49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 22:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFDBA1F2134B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 21:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37AE39AE6;
	Wed, 31 Jan 2024 21:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f0Zu+RuT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xxY6Ru8S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4459B39ACA;
	Wed, 31 Jan 2024 21:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737440; cv=fail; b=pmZXDlVuO+sNa3Yo2PfLb3vVDVvYkEOBGMki81Anq1yQ6Dv7j3e2U8iqNGhq9VRFLod/6Ttt+UF4Yych72E2liAA0ND1UsVpdEy8j3IL+aM+dyE+Z7JgMe0hJEfRkRlsMTuP2iSR/esqh4HPNIA5Jp/JbKI5Qb0Slw3OFKCZFEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737440; c=relaxed/simple;
	bh=yAww3gInc5TCLniyKmSoh2EVGnrcv/9j4aoMlA9Wiss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FxIGnlFLwSWs7+89UDaQmxQCtqtqAuNh3Q90rlWTWyAfVqH08T66X8tSQyswRn6Cnc8rSVHrJFXAg1KzLwtLD4yRUP2co5vC5S10/I4Gl9cTPMh5v0v47/QPzjXPw5qY7vFgxQhY4HM2pHHZ5AmLLNT33huaMZwoAhYoENxXM8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f0Zu+RuT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xxY6Ru8S; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VHBswE029067;
	Wed, 31 Jan 2024 21:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=8yxQj7MEQIDNJw7X0m/AhfJuk9Ltub/0IP3/TEU4g4w=;
 b=f0Zu+RuTaCpfFw8yn/erdUgYT7TQrIcZ6gYE8J2z8RpP4kRf0Q6HHq9k44yuMU3RfpUX
 6hKgEuEBNeXPs8I1xNU42bijrvlOl4J9sPk7v+SjO3EwJXnaHfuZOXSu324hD6/GhWt0
 3f++mDCRuHz+Z38Ld0v5nXqF8be05gX0GJoUHyl6ZMjGRCuGy+Iub7z2kRfRqWZwi0xX
 5vA9UMYO6ZwilPFp/cH9L24YBDmDmzQS8EwGLb0KM4jRfM5m4PPt2KNovhFiPKBg6apB
 eBT4S7vqbLpg1tpYTyXSxk3mDNoGTkrOLg2Lx7Zbf84PB44sJcoaMVoZLM/5S7kmFN6M DA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrrck61r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 21:43:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40VKBGJ2028423;
	Wed, 31 Jan 2024 21:43:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr99n4ds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 21:43:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5XDYGcKs6JAaRo+ExTMtvQbTFl7ex71nIwQ0KC/kXFUzT2naXbZ85jej7ycFkr0gw8Z25Kr4qcpVpP/EOdaB1JSKcWuVV8OtcRHNQ1M01SfELFw3cXCpTP42excJ2GdkXDnRcL5Uw+THA1yHUXP3kq1RsyMqp6GhXo9TS0Q7jaKJWBBKWgUumwROb1VSTNs/Nue1NAsM5gnbOUUQMXi+h6SZgbnpKiHlt/7QPjpdGb7Ba83sS00IaO8D8zjrvsUoDcbxiriWN0Myq0YEBaDmANnoSu5XaYiLm7Lp2TsALSBKXwibsDsSVt66LKqJR8uMWzEMdIerbLhqV7V6v6zAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yxQj7MEQIDNJw7X0m/AhfJuk9Ltub/0IP3/TEU4g4w=;
 b=c8dIvTn2VxQUGUXr3cC8YRXAo+XiXWtEEnJhrWuQ5OVPuqp69vl04XRmck7jVk30XKlyn4rVBQqMXjMW4k+fmpeCMAu93mqv2U+zt4ulwtYwkXkCv0YytXrmQdp92XEvhgXBIfNbUrimI24Dxv7MQVPpt+3TKl/WGTzECEPe6bYZkVAYr+BGz5RHvxl844dskdq4IjS4VlrvnOiW7GfRKZsoTf4nFrh1D/xTl+jIwtXKHAzi9GvLuhSi4DRuZXONT+Z2q0GBNNThJfvLBgH5zKHj/B4/CWjaAFxm500m9CZDjmzOHXmN6fFQV4BN6aOXjayDRvEXc8IE45ZyJzrn/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yxQj7MEQIDNJw7X0m/AhfJuk9Ltub/0IP3/TEU4g4w=;
 b=xxY6Ru8SD4tiyEyPw9zdpelE7n7pvo/LThE8KWNfOan0co5V56gKR+M1jVHmq7rNBZO7lCnmdRwwcnBuYOvKvHshE+h5wjQGBJ02S+FTyNGG3BYyaZZJ2mUHVMHwGzNwEh6EUxOk9mdfYtzMdMHbVBdvk8N7AyUMHST+dgwCI9U=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ0PR10MB5671.namprd10.prod.outlook.com (2603:10b6:a03:3ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.37; Wed, 31 Jan
 2024 21:43:19 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7249.017; Wed, 31 Jan 2024
 21:43:19 +0000
Date: Wed, 31 Jan 2024 16:43:16 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com,
        david@redhat.com, axelrasmussen@google.com, bgeffon@google.com,
        willy@infradead.org, jannh@google.com, kaleshsingh@google.com,
        ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Subject: Re: [PATCH v2 3/3] userfaultfd: use per-vma locks in userfaultfd
 operations
Message-ID: <20240131214316.vteh6vzbb3ubdzqf@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com,
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com,
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com,
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
References: <20240129193512.123145-1-lokeshgidra@google.com>
 <20240129193512.123145-4-lokeshgidra@google.com>
 <20240129203626.uq5tdic4z5qua5qy@revolver>
 <CAJuCfpFS=h8h1Tgn55Hv+cr9bUFFoUvejiFQsHGN5yT7utpDMg@mail.gmail.com>
 <CA+EESO5r+b7QPYM5po--rxQBa9EPi4x1EZ96rEzso288dbpuow@mail.gmail.com>
 <20240130025803.2go3xekza5qubxgz@revolver>
 <CAJuCfpF0J_7vgTZim3vfH6=ExRTsCRtpg+beJ+bJfYEqD5Se8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJuCfpF0J_7vgTZim3vfH6=ExRTsCRtpg+beJ+bJfYEqD5Se8g@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0045.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::18) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ0PR10MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: d11f6c60-f05c-4f27-b1c0-08dc22a5a37d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OxxGdSaJlPNyvlbpvwYtgb17YQBxb+UJ87cST1qnmM2AdIs/ObFXnGxPJZ3o7zpN2GhZzRgS7dC8T31ivsyjw937xr2veH9/p0GPprN9y5EeUB5m6fouZ3NnOy9wKN+MRuUDrLPptML57apfyCDk8SwvgCGGn2sw7a4eMwDo8Pzbl4v6Rq5VThTIP1dKKf7HOvWJZdf4XI3VJKqD99h2bjUpxL3hE9S57Of5ASgODCP4ErSzeNWuA7GxgQsf/1BepD5ZSYjyMU8tUgGpzs1uQbcszlf530Tl68vy3ih/a0gFoVhgJPHDAoRNZxhkvCcQ4R7MDHJe7kZRLlWrlkzG502WW6XxZL0HnjOl69Jk/aWpIntVxUsqx8uQfesKDFhNlGxrgLX30+jUBdeie9WpaGRR6Sq01pZIuQKBYw4n3SCM0eEcml4ckSLW0ePYAPv2gT/hLpRVEng9FNUlLttZdqJOaaS4pVHvy7myDP0VL0ljMKzhc1yHVCjgPK3DmG0rQ7GBiquR2RSEEh97cBjHmguaSvxNf7QOJ9F4nKFb3Sj2d/4uK1q6O6T/3yYfo0vr
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(66476007)(66556008)(66946007)(6486002)(53546011)(6512007)(9686003)(478600001)(316002)(6916009)(8936002)(4326008)(6666004)(8676002)(6506007)(26005)(1076003)(83380400001)(2906002)(38100700002)(7416002)(5660300002)(86362001)(33716001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YkpjNFROLzlLSHpZMk51b2pVaC9NeHBYREJDZWZJa2M4VnRkRWpkeWNVenha?=
 =?utf-8?B?L00xckVYVkpQZ1YyQ0szQUZVeWtsKzJJREtHMFlTaWdHQUorcXd2SENEemRZ?=
 =?utf-8?B?Q1lPZGxDc1RDVFp2WDBSSVRBVzV3Z1V2ZC8vbkZaOXoxcVQ5SmxRY1dBVkNC?=
 =?utf-8?B?N1FtOFdTZUswZmJOQjdYNWZ4YWNHbm5YdWFUQ0RzU2s3OUNTdTR1VDgwZFdt?=
 =?utf-8?B?NUs2dzNKTmQ1VE5WZmhtcUFZR0drbENxRVpoY1QvbG9QRUsxa3VaWFM0WGdp?=
 =?utf-8?B?dkFXODdBTzF5eFNqSnFrbDRiMzFyVlpCOUxVWm5tOS9SY1VuM3ZmTmhQSG9y?=
 =?utf-8?B?Z0EzR0xXTVNiVzBJQzZlSGI1ZHpXQ0lzbjkwcUZkb1VHWjN1NDFFb1cxZFlq?=
 =?utf-8?B?b2UwVDZNM0ptN3B5TnYvR1FHTW1rODRNdUx5S1JGTUYzd0RsL0prb3ZqZXRZ?=
 =?utf-8?B?NWNTbVBYN3JMMDZHVVdGN2RtMnc5N25UQ0xFU0o1ekJhSmhZWEFMQm94djVn?=
 =?utf-8?B?cDNCOXBOa2hTYkFTNFVwQTQzTDdLdy9pWlhYZ2NySFNSUnlEdld6M1gzVjlp?=
 =?utf-8?B?b0VtTmQxbWc4Y0JUMnNhdmgyK3ppTThmRUhNeDd5SEVlOFZIOXNza1d4bWl6?=
 =?utf-8?B?U1Qwdk1rOGkyVllOc0w0dUVJNS9JNjJYNlhYTkFoOXFMcGRiblo1Uk1rVVNz?=
 =?utf-8?B?VHVNL201RlNaWmVXb2llUVlQZFJaY0xXcUN6MVAzSHhpRHhNOWV2YVd3aUVa?=
 =?utf-8?B?UEtYbEVVMmJVSEJnZFZDQkFldFpIa2pvU04wb2NWVml1T3h0OVhSa3Y0VTNP?=
 =?utf-8?B?aUVaTHUrZmdPK2U0ZDBnOFBjdHpTOUxMRktYSGV2QWZiM2xqSEpkUklyd1VW?=
 =?utf-8?B?NlZFb0VCd25TQ3hHTUhRWWRQUzY3L00xZnpHZW1pK3dGYVRrb3loMnQ1MW83?=
 =?utf-8?B?MjVNYXZlbTBlaG1JQjhlTjd5b0ZtMjNUV0h6QS80U3dnU3FTSWpFeFh6VUFJ?=
 =?utf-8?B?VnRTVVZEWmY2aGtITjNXUFNibkh5OXU2dklVcy92Rk9VTCtKQ0RYVEdscElh?=
 =?utf-8?B?Sis3VjU0MFY3WHZPTk55RkN1NWc2Y1RTcktDbUhoUHZXTUNGT1c4eDhmZmpv?=
 =?utf-8?B?SU01aTVqTEpzM2llNWZHZG00b1MrbXVKaGV6L3cyZG0zVkIvK2hiOHRoTGkz?=
 =?utf-8?B?Q00xUmF2WXB3Z0x0K0FVMVpaampRQzlabktLc1ZqMmhuSlJjS2g0U0VPb0w5?=
 =?utf-8?B?b0RWSVh4azNScUQzL3hwWmh4TWVJamptWGM1VG05NXhGME9PSEpEVUIvZUhR?=
 =?utf-8?B?NkVnUjF6WXBGQ0FOQ1ZRN2dONjVtMjJtTVBIbndjUGtKbDV4M0pMQWRLSkdh?=
 =?utf-8?B?L0FFc2NQSXNTMmtkbnB4Nng3VTNtUXdEbkdXbEtxemhBTGRhM0Jyd1BtRHV2?=
 =?utf-8?B?dkFpdjhqdXhYTmNkMjk4QTRGUjBjRmQzSjJOT2g0dXNxZ1BjQlI2YlB6Rmdz?=
 =?utf-8?B?ekdsY0wwbTRtdnN3YWxRaTExYkg0U0puMThTWG5zQjlaN2owRU52emdFZ1l5?=
 =?utf-8?B?bUpYQ1BOaEcwbm5Tc3JZc1AybDhUcXhWV3NpdWc2bnpyTm1rUGI5d0hTeTNx?=
 =?utf-8?B?UFkxc3ZpWTRXZW5TM1l0aUU2UlVSWlhQMGNMbmw3R29sWjlVNDRDTVUzczB2?=
 =?utf-8?B?Qm5wbnMwWVFScVdLc01weUlSRXYyNU9ISU5haGV2YU9lencvaDA4S1UyaXdB?=
 =?utf-8?B?L0pobHJUQzUySUJmUFc1TjVKVDFMSjhTc2N4QXNCSkxyNHEvV1hpbitLL0lt?=
 =?utf-8?B?YkdzZGJQNFFvQk1FR21nMEp6ZHNVUlVVNWxnQnhleE1hVFlzSFl4K3JrcHhk?=
 =?utf-8?B?MHBwdDIyc2dtazZZOFdmQ1ZadDZsL0dxdlFIZlhKdlpVcEh5WDAvOFVoak9p?=
 =?utf-8?B?QkVrczFRcTJJcXFjbWI1RllTODlQbWFSZW52UEhuTGU3ZU5wZGdOWVd0SHJ0?=
 =?utf-8?B?UndPcmRnYUhQMVRRaEdZQVE1bWhzOVl2MHJsU09GbWVCOS9uOTNQQ09maTc0?=
 =?utf-8?B?Zm04YmVnYVV1WjVTMVlzNVNSQ2dwRzB0bFYzY3JnVlU3R2ZVd2d4ODFrYTJr?=
 =?utf-8?Q?hChM+BRF+cqcOYAewrwSxCulD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vqk+JgUIyYqQDja9dJCrL5iLZVeNBAiYsgETpU44zuTvU4yTwYmzYSrwE29MbDCmnUftL6pRjKP4BSVLDJQ+6vhOm+p3U75El2FPEF7BZOyi0RqVAjlTy+aeRmivzi397zKnSDV6hleckk7z9IyJy0E+4grPXltFVUfIxeCDHlGJuT1rvBwi6PURtCEttx+tftWiYPJyAIIRwXtQ5RkJkIvIMVRwIovLVM1lFWFcZimrTnSvk+VpvUKqHRzVbUnadrB3c7ayZ1sd5uwaPsU1ZFCz+iYDkDpIF3t3g6GbMHSz5kK1Vo1S9dTnnGCDXRhDnktdWffbpX7YZBZ52OySRLyFHoEzyTWnFTSby8cJ0Z4EIk3zm98FyU4u6/3/I1frwDqlMVykROGyNqNmzgkXk0VWNGlqmBFm9rKbbDP3ESnziN7lqXk7EE5ldKXmfbd8VWrleSMeWSvtYFO6Zj4+SRulBWHH8DeYVElF01SR4NEPA9KkMG8T83CBT9sXbaDT47XRswPeV37om/E/Lp495OlSnmEE7Lnmon+gV755pHqND8O8VJQsbnPBC7cThNIqF7cN4+iNK0BbsRtNbhlF8lNiVSAX5FnYjSLyFqv4O98=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11f6c60-f05c-4f27-b1c0-08dc22a5a37d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 21:43:18.9108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qlysWkEeZ+J6YLvuqpLST3uvNNDq+8B9vWH5h4oSW3hs1PDYvcIWI8ls2uKBDVGWZZ8rFaP8vQYMkqX7TKzFIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5671
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310169
X-Proofpoint-ORIG-GUID: TxjNT9A8cChat4JaGh6re1rbjpdGoaay
X-Proofpoint-GUID: TxjNT9A8cChat4JaGh6re1rbjpdGoaay

* Suren Baghdasaryan <surenb@google.com> [240130 22:03]:
> On Mon, Jan 29, 2024 at 6:58=E2=80=AFPM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:

...

> > > > > > @@ -730,7 +759,7 @@ static __always_inline ssize_t mfill_atomic=
(struct userfaultfd_ctx *ctx,
> > > > > >
> > > > > >  out_unlock:
> > > > > >       up_read(&ctx->map_changing_lock);
> > > > > > -     mmap_read_unlock(dst_mm);
> > > > > > +     unpin_vma(dst_mm, dst_vma, &mmap_locked);
> > > > > >  out:
> > > > > >       if (folio)
> > > > > >               folio_put(folio);
> > > > > > @@ -1285,8 +1314,6 @@ static int validate_move_areas(struct use=
rfaultfd_ctx *ctx,
> > > > > >   * @len: length of the virtual memory range
> > > > > >   * @mode: flags from uffdio_move.mode
> > > > > >   *
> > > > > > - * Must be called with mmap_lock held for read.
> > > > > > - *
> > > > > >   * move_pages() remaps arbitrary anonymous pages atomically in=
 zero
> > > > > >   * copy. It only works on non shared anonymous pages because t=
hose can
> > > > > >   * be relocated without generating non linear anon_vmas in the=
 rmap
> > > > > > @@ -1353,15 +1380,16 @@ static int validate_move_areas(struct u=
serfaultfd_ctx *ctx,
> > > > > >   * could be obtained. This is the only additional complexity a=
dded to
> > > > > >   * the rmap code to provide this anonymous page remapping func=
tionality.
> > > > > >   */
> > > > > > -ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_stru=
ct *mm,
> > > > > > -                unsigned long dst_start, unsigned long src_sta=
rt,
> > > > > > -                unsigned long len, __u64 mode)
> > > > > > +ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long =
dst_start,
> > > > > > +                unsigned long src_start, unsigned long len, __=
u64 mode)
> > > > > >  {
> > > > > > +     struct mm_struct *mm =3D ctx->mm;
> > > > > >       struct vm_area_struct *src_vma, *dst_vma;
> > > > > >       unsigned long src_addr, dst_addr;
> > > > > >       pmd_t *src_pmd, *dst_pmd;
> > > > > >       long err =3D -EINVAL;
> > > > > >       ssize_t moved =3D 0;
> > > > > > +     bool mmap_locked =3D false;
> > > > > >
> > > > > >       /* Sanitize the command parameters. */
> > > > > >       if (WARN_ON_ONCE(src_start & ~PAGE_MASK) ||
> > > > > > @@ -1374,28 +1402,52 @@ ssize_t move_pages(struct userfaultfd_c=
tx *ctx, struct mm_struct *mm,
> > > > > >           WARN_ON_ONCE(dst_start + len <=3D dst_start))
> > > > > >               goto out;
> > > > >
> > > > > Ah, is this safe for rmap?  I think you need to leave this read l=
ock.
> > > > >
> > > I didn't fully understand you here.
> >
> > Sorry, I'm confused on how your locking scheme avoids rmap from trying
> > to use the VMA with the atomic increment part.
>=20
> I'm also a bit confused. Which atomic increment are you referring to?
> AFAIU move_pages() will lock both src_vma and dst_vma, so even if rmap
> finds them it can't modify them, no?

The uffd atomic, mmap_changing.

...

