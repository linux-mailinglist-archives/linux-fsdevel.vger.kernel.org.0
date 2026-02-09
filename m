Return-Path: <linux-fsdevel+bounces-76711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KE90I+/8iWluFQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 16:27:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E131E111E5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 16:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EB80301E941
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 15:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F0937F103;
	Mon,  9 Feb 2026 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LAKUySy6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zkVii2GO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7453929A9C3;
	Mon,  9 Feb 2026 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770650600; cv=fail; b=eOAUzZWvNldNZyCEOucoaAvDeS/nlqTEhCPxvvMHV2Zq7vXe+0FLAgG7boGZDQkJkWsvzwUbSAtS7tqZ6ogg2LgkP/IFCHVlq5uSOd6wrSH3yvtt4yJeBWr59wit/feME7g20Jcw4iINhpx6715/cRpYm51lgJzy7XxR/HQbvUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770650600; c=relaxed/simple;
	bh=tEPyDbdybG1OSApUcY2MZyJMcfQGb5lpccR0SPPrjEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X1MGkpoY5pb+jTEvlT5wMn76mJJAHu8REPNr5/E12cT7mmqKdFDZvcv6kE1CEL/NMOoSW2UQRBF9EmAUYSXek+V5PtRFZWBPZOVkfZZbqktv0wos4qky3zw5QgoUUWFajCd722ePunPEFqPKZVSUJX73o7Agk+4ecuJ6xdPRoXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LAKUySy6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zkVii2GO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619EDUA01629265;
	Mon, 9 Feb 2026 15:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=x0IN1CH7FaRUrFidwh
	XmqGhdDi1ozPtlZPEMVTuVh50=; b=LAKUySy65jkiui4TDZlsU2DPig5su02X8X
	EvUodSwLLt9sowO1eWdpjx4R4q0rH9YxcbsgRJfAj1v6BM5SoZeQdGeJGfsBXQLZ
	1R1Q0odbFX6/VJy+/FUHgSzP9fhpG9ukvpiVJtIQ8Fs9j8TB/913YLozoW239ntL
	AqpTu+2Jnzzq/57q4LZ9qBIBFDTpv7xSOFIo2sWY70884MX9hTEPCWcecJS+CDHv
	9B9l+C/3KOCjGWhEWG57AUCo9A0z/JSGSUIfldcIwSxnxPzDHxe/mBGpWk3KIMTE
	gfJ/JE6kj6pv22U2iivG06tPRv8hy4Lge+SQsK2VVyHySJL1QwxQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xh8t4n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 15:22:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 619F2GQb000466;
	Mon, 9 Feb 2026 15:22:04 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010019.outbound.protection.outlook.com [52.101.56.19])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uud56w6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 15:22:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLzvR2i3uM+xsp9JQxU3XkT4F1dhtLKdDyJp4g04BuYWbV2qnM7kNoHSGWc3eqs1CR0uz+OUGouo85VGQmZZAuRYqmqFA0F7qK3wes55YdAvS3Ib3+5enB/NoGQPsOzC+Y5IqDVu0EDrIalTITWSW/LeVqOnbHjOne8KjJBV+rO3m++zjLkGQ4VldqkguKpiDdaDrLd21xWuOdi+ppXrqZvwYrbEvr1yVD1oKGCQXo+p8y7qMK2FTtbA1AUxlWsZD2cwmx/aC+h7daLoS4UkQU6/qheanOmbwb+TqpWprW6P73jE4My0D08zRN+1ct+wsdYgwqvrCEvL9Jfzo1AK8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0IN1CH7FaRUrFidwhXmqGhdDi1ozPtlZPEMVTuVh50=;
 b=DiMVb7+4YUso9WNXodFfMbnuJTK1OqY2iIDJ/BBxWevQnJQQE3JIksEtLwv75UUyc6XIHkgOCUCJhUI4ZlIi16pR4bKRlpA8VOIfYQmCXURzLEGk0Ia1ExExQCQhavDtmNktWFe39QuhQXluLyqB1Cv4LkQ5WZPH/L/4YPVF03UBefNLjrqRjkkltbLVkTa4a+qDCBVX1yOObOSCcW0ZFDfw7TDgCsVT9GuPjQ9MpMuRRSIyyl+j2k6RoNgV7KJ+xiP+ftq39014XaOMA+9agptkE8GuNcT610ekhwdlwdAf7Gyf1lDv73l73x+NVz7l4/VGaWQkx5b8qhwUU6iJOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0IN1CH7FaRUrFidwhXmqGhdDi1ozPtlZPEMVTuVh50=;
 b=zkVii2GO2at4p4xAQDNupHMqyHp5vrW6RojUnCOxt5sma192q7SjooOf88yIjEX8d0TCgIKcmXcnbtjFDALQGAKP7Xd7JR6NJgJrUwK9Co97HLQD7Q03Sh2KLLM4IcrpDmsYGSV18/bBg7DwnJ0FlLw/O6qA78sBUVGT/lVMIdM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB6310.namprd10.prod.outlook.com (2603:10b6:510:1b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 15:21:58 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 15:21:58 +0000
Date: Mon, 9 Feb 2026 15:21:58 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Carlos Llamas <cmllamas@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        David Hildenbrand <david@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
        kernel-team@android.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/5] export file_close_fd and task_work_add
Message-ID: <df876a6e-013c-4566-890d-7c1d662fced3@lucifer.local>
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
 <20260205-binder-tristate-v1-1-dfc947c35d35@google.com>
 <9d0d6edd-eab4-4f31-9691-78ed48e7ad5b@lucifer.local>
 <aYSCNur71BJJeB2Q@google.com>
 <9a037fdf-1a98-437f-8b80-7fdc53d5b0fa@lucifer.local>
 <aYSfBJA4hR4shPfI@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYSfBJA4hR4shPfI@google.com>
X-ClientProxiedBy: LNXP265CA0092.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::32) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab98117-88e6-4856-5092-08de67eef777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yn3l9hspT6Nok2nY2Wrugzb/aDXjfS0IvRW08i+VIdLKKHbnOqzkSl4ysYYh?=
 =?us-ascii?Q?Ocp+VnpCxxdnM1EynBTlfMuwHaWXH3gTNEoSPyc2N0TjOgIoYELar7BJgTE8?=
 =?us-ascii?Q?tZpHsVLdZCPRSwG1UG6lYT+Y+ATsaiNde/FZE0L2OEHxumBS2v7qvEUl8Zmb?=
 =?us-ascii?Q?15TPzinuNG8soZLYSDsslBi4HTmgeDdY8dr+O4ijKhvMCrueZ6Cl/2h/il2y?=
 =?us-ascii?Q?Z1WLTCbNFNotxbXOAkhLmbaXgs8TzmvJwBeMowWlMuI8hTXu9Nl1Z2rADmN+?=
 =?us-ascii?Q?2fBTZX1i6pAf7uveA18KZh1VdYlTQ6tVOsUvBEzcDkxFaN0N2qB/V76zsnNl?=
 =?us-ascii?Q?Iy34qim+G6JS2NvxOyFqP8xpvcyFRTF7VOMNzZexZLsUt4nS2mdI28YAI5YS?=
 =?us-ascii?Q?gzULBhLDnGh/21rYfNKifoMtYpyQj3a4AuuJqs+d7mjadCAg9sT1Dv+pY+xn?=
 =?us-ascii?Q?wZCKdhWgoNYSXJO21HCjPVrw5nzyZTnpdlZ0vC8FjPX76CuREIl+a8BY3nVt?=
 =?us-ascii?Q?VSHcDxlI0v+WGJ9u7MAdT89c3D7CE0N5V9QrJqmO7pLzYHKNcWLhus0xTEpy?=
 =?us-ascii?Q?OsszV+yDGY4i3q39b9g0CXmdNO1QQU9nRT+6GPzdTaQxSVvbHxO81axNlgG/?=
 =?us-ascii?Q?7NY3+d6nL0OgLfkDMzPDlzgCy/ccNx5ELX5yhI7185uMSJMGmOm/whzua/nB?=
 =?us-ascii?Q?g0V3Sy4WmJJjAiqlNxXPSH+12OrYXHYtVJ5ooeRYoZK8ve5d1zNw0Lj62fAO?=
 =?us-ascii?Q?8TmlkSVAFrjEWBf0Lbnt/9UIqX8H8ZwcWElC6PPQteb/iy0PdSaM1EM+JjCa?=
 =?us-ascii?Q?eY0HtvOcjY01h07m2qyJw1BpQbxAznWxZlMkgCtb+qDoG/EdSXXgtrhZfXMK?=
 =?us-ascii?Q?nArAMmJjwn7WBEe01hyNRBTxxNupY7qU91GrjYVJtVCfmfDBCECc6adVnjAC?=
 =?us-ascii?Q?bBJxZqkdGJWeFDiqkyJ3Re7gdFTC3J0AKuz46YqdamuYI1y+O2qpKQuKXOKU?=
 =?us-ascii?Q?5w9Sjv7Kd9R92Dn76u5QrPmfl4nWiwmxVUgR3/y3EjYeWfRkWOU8tic5dm4c?=
 =?us-ascii?Q?Pr6b1ENzWEGsph2EfxjF2yULugGFxoR4xwYOMGTAI8zRboRACGGzTOEWP84d?=
 =?us-ascii?Q?YiOYtTpz7JlN/0xqgs3w6VlNJvx687B9PFlU1R9sI6S68HdeyHGX42bKHfII?=
 =?us-ascii?Q?DntOf4uESIU7ZUYHYLcp/gRye1wU7FbjO/JgsjlaCaHKBJxToQEsX/qJbuBw?=
 =?us-ascii?Q?LzTVH7CnjLDCcqBjh9Fh/vfIGLdzVvHZLq+nrcyy2AM+dzgVs8Br/LNAVM91?=
 =?us-ascii?Q?+tJ8oOGRJ394RYEztFFmFerEFMxKHmqAm0qJSalCHIFzFOAYKH9Aya9IRbIY?=
 =?us-ascii?Q?fe+iginnA/UZ8BnE88YUWCvzgAHBmjvjZv+MfxeRzXPNfRkam1Ui3n1lq+s8?=
 =?us-ascii?Q?esDyFLRLJZ7PbVoaYVO0JFUQPEJKGVPc5Cvq/93CCPFlC+nuA6fpoEvPwGDA?=
 =?us-ascii?Q?c23L9tA2iJbn0FvU61qsifXMhZW2bf/3V6e98X2f7Puu5RB1Q82ZyHWDQZ1x?=
 =?us-ascii?Q?wEakSCPU9mboV3Heoo0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dggBAxTNOWUAFqxlfcGp0UmKXeVcIcNB/SSWDds5iqLu1fDP8TUXNutX71zI?=
 =?us-ascii?Q?yh2F9h2blYEAzNYycZOfIsEURVNwiw1L7n6x7zilXCvEWJkni4IMYyYE9NqI?=
 =?us-ascii?Q?jCq1SfdN55UBG18tI5+UswDj7fzmnbSjKSdCHwiG43pk5r3llo44RX47X9W0?=
 =?us-ascii?Q?Xjv0gRpQ1ZLH6g8EdVUgjdxZjlArMZoanY5FT+fVgcN0JBf30x+5nri97PAh?=
 =?us-ascii?Q?FGqGMs6Chy51FssQMMJH6g5bGL0XP3RYge0/CkSSUAJnaLRMh3yA79y0X7M+?=
 =?us-ascii?Q?MhApCxTK6+6itlADu6M/Sl33vC9cLTX6o9uhj04z9vNp3KOIOiPgeyy3jmVw?=
 =?us-ascii?Q?cIgvNveiOvD5ULN79R/UirUyd0NReV6jLuT5vhBKvZqrWTA/99izpBPZN8s2?=
 =?us-ascii?Q?a4AXQ5npgNKDBqUhwNga9IuMVnyNzI4CHUQpjYRoVjh7gN8aAmuwCnKfRULV?=
 =?us-ascii?Q?OnjhWUsy49CU9Rev9mkOTBZQZdHW3VeLXACJ0hKQViewdk5OrNs8m9SXJnLv?=
 =?us-ascii?Q?wrkEg/Ag8gf+hzjF6C+KiOmHdfwaRDL7GM1Vb0OtL+9nBHW1/p7d5xqImsbM?=
 =?us-ascii?Q?wfiFMcpccZME3ymsmWps1jDB+zdeNP4fe7XhFzp8dji4bcMTDoAOZlAGTJdI?=
 =?us-ascii?Q?e/OtKfNXeWvQy2976QOX2Cl1riYGM+HJNgw7l3jzO1mlESqWWRcrYR/qO4AY?=
 =?us-ascii?Q?Defp5rtCEZpJhd3BnfHogZnhfzrlbniIpCkqhcm+PUFeR/u6bbEw0BWFzUQf?=
 =?us-ascii?Q?lmPqBwej/sb8M5BM6JaXLCu6DNtYZNPQQK4IV3xx2e75+tdJoSdajds0uUZa?=
 =?us-ascii?Q?CQAqWad51B/t6newiNtUV6Aoo403RCcyiQUnU3uYq5ZJ0i58GIWix9b8QECz?=
 =?us-ascii?Q?5QRhU29mKSUO+bvpcNOi7l+2GTrmgg11J2SJhbPffXzjbNJYVuofmIybsUhz?=
 =?us-ascii?Q?JwEBBnweXBhfn05/QBsE3lSq1uEJG+QU7L/8hPtQmVjGWFBjBSg2omYlEQ4g?=
 =?us-ascii?Q?l2G9KF447xrccn4BHqgxwQXmEt7EGL/XrlPMAj9ns1hUG+z95yIkIpSqhkfd?=
 =?us-ascii?Q?WKXy2Ls1T7KfC5NiA2syvEFdb3POznb/BQgEYbs1fF4cef9Awf1yZ50VF+X7?=
 =?us-ascii?Q?ttN14ay/9xgvLG1bGDU2lYvFMWf1Ytdbpz2MfC2Y3zyHjAPbsdxyutx13hHY?=
 =?us-ascii?Q?bHy/Ml+GTldv3jxSaunXm7Fe8FadrN4GphXSwL89ugbaEUOmgGyL+WSgUYfv?=
 =?us-ascii?Q?Fln30Yggv4ocGI77jO3OxduWDxjFO2lHEZOkyAyaw1uMbf3Wr/3BY4ju1IC6?=
 =?us-ascii?Q?ZUvm3a08KoTKCg5fGM+PmNR1bUeNZDFBZTH/kmAbAT9XIc+K4SYUl6uAGlFu?=
 =?us-ascii?Q?W1sFmvExSONYd0o3pjSgAXkkM1Y1fhOeGJDVjLruNxSG3w9z7eJ1ByCKpaPz?=
 =?us-ascii?Q?QcgpLxiK81cs0i/JqaFU8BnvkgvNaZMOxrADrbpIdM98iXe/8xLZwQg4iyMC?=
 =?us-ascii?Q?I08NhxUbbX5kOo+spe0Sy74MYTXBAFTmc3DolX35zpcyN2TdZi8k5/aeHKWe?=
 =?us-ascii?Q?1AS3pP295BHtcTF1tI209WIcnYgTFqjLEq7PbUCGSBR7dyaAuuATIufpS4rH?=
 =?us-ascii?Q?QJQ6Jj6pG++zWJziJh8qejBD8T9bzERxcaCnS25nEw1RaQWlclpGrMh6Rj/M?=
 =?us-ascii?Q?el4AXdLfLCCDQQ0Ec6edTaczC8QeO5pwJd0IuX/chxHKSQiILcvHrJEPKzFT?=
 =?us-ascii?Q?MNRRqdMHPw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c37EManUcl6fnU+gAxKNEjirpHYOAgJJam7/hwfm97xq53jB8sXMTeLoibIKR14NVOW8LJPnnPzDMhyTlsaCy2xUviV/VEPgVwyrzSDrIlfIOcihGaxnX0LZo0UEk67Fgl7S640s10PpSngpN4m19yx2LCm58u/7nohCQiOaBFur2sLQCjwTQQ5rNNreqINPtbB2Evg2d2tgYpxFXrxZmhcys1nV/qtC2dNv3Qa/nzOrhmaqOeO3i53LtDEt1zmmXhiDZnAN6eX+AfuP7kJuGY4wXAvNorzKiQSmdVDhYNJUN+uOTDEUmcW/MMIjb8/9Yn45GgCI/N59YRWaK7CM9erNr2IibMYp9nAuD7wRSIM8WTbx/6EqjgHSdetC9/nO7Oa9JN7MiMN8oCOenzzkAc8po++bTa2XP6Bloqx7GwFsUvetN+qkKZphUurLAnZxmM0oMimJCixm8dcZRGtmktSOdrevBzJw0Dww088iGeDP55KTKcLfOHCFlaJmHBBw8V8vQMNdKD2vKCp+Kfpko7MbV/Kd86u75x1zCZJJ0BK5CY75mE2MgfL2X3LoYaOjucM7l5mDmS7Wx+yR+ABAaKCvd/nHEtNQgHWfARk1dIU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab98117-88e6-4856-5092-08de67eef777
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 15:21:58.6881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjKlK/v7RXRIFi574dqujywRoTjMReKlWObzYfMUn3VLt9gOWkTRZeJ2EYDAwTIvCO8Nn13PIWhhn468ZeQrZz38OlV61ipcmhB+SpedZ5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6310
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602090129
X-Authority-Analysis: v=2.4 cv=YbOwJgRf c=1 sm=1 tr=0 ts=6989fb9f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=hLlj1LU_pwC3xl6fNYoA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12148
X-Proofpoint-ORIG-GUID: GeyDTgPrkbLz_7xeVxvgiMrbyGay7ICk
X-Proofpoint-GUID: GeyDTgPrkbLz_7xeVxvgiMrbyGay7ICk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDEyOSBTYWx0ZWRfX5Y1o3wnBKZj+
 jHIyqQZaFVEqhv27Ja299/7515hi8WjkX67PjGSm+XXEx2BY/cLRs2LqsLTUYxNFees8rbTE91O
 k8WudiVScHIjDKbL1inRu+Sfsan6d4xEbjKQ+b3pZfVN0wtxNsR3N+fKaXMrLg51MNiR+MebUIP
 m+97+s3W8xw8gcBuMa0dAuBoWARCnQUI0t3OuUtf7C6rcPHyaTVaq41Uu/wbfM8j3xvzjsoMykR
 5oivrMECSgAZ6ATVjrgPYh/Y3qwsdkw58BE2qW0r1YWnCyammYM2qcqs/c3s+a0EivUgzm0ccdE
 WUdWxE/BY7lNysuRxPOxznzQMpcYX+ias6LbNHwMxVPImhqTBgmq0TQqYJ3REiqxvka0jggJWgC
 f/OS2AvEgGMg7M1N61CveJorjEp5n+Axo1lXHWkeN1CJok/5679c9xTf4v9FKYRMNCT49gsuVQw
 tVcjLl0v2QJL1bx1//PSkliYczNOoFJLsMrhBVQk=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76711-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lucifer.local:mid,oracle.com:dkim,oracle.onmicrosoft.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[linuxfoundation.org,google.com,zeniv.linux.org.uk,kernel.org,suse.cz,paul-moore.com,namei.org,hallyn.com,linux-foundation.org,fromorbit.com,bytedance.com,linux.dev,oracle.com,suse.com,gmail.com,garyguo.net,protonmail.com,umich.edu,android.com,vger.kernel.org,kvack.org];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E131E111E5D
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 01:45:40PM +0000, Alice Ryhl wrote:
> On Thu, Feb 05, 2026 at 11:53:19AM +0000, Lorenzo Stoakes wrote:
> > On Thu, Feb 05, 2026 at 11:42:46AM +0000, Alice Ryhl wrote:
> > > On Thu, Feb 05, 2026 at 11:20:33AM +0000, Lorenzo Stoakes wrote:
> > > > On Thu, Feb 05, 2026 at 10:51:26AM +0000, Alice Ryhl wrote:
> > > > > This exports the functionality needed by Binder to close file
> > > > > descriptors.
> > > > >
> > > > > When you send a fd over Binder, what happens is this:
> > > > >
> > > > > 1. The sending process turns the fd into a struct file and stores it in
> > > > >    the transaction object.
> > > > > 2. When the receiving process gets the message, the fd is installed as a
> > > > >    fd into the current process.
> > > > > 3. When the receiving process is done handling the message, it tells
> > > > >    Binder to clean up the transaction. As part of this, fds embedded in
> > > > >    the transaction are closed.
> > > > >
> > > > > Note that it was not always implemented like this. Previously the
> > > > > sending process would install the fd directly into the receiving proc in
> > > > > step 1, but as discussed previously [1] this is not ideal and has since
> > > > > been changed so that fd install happens during receive.
> > > > >
> > > > > The functions being exported here are for closing the fd in step 3. They
> > > > > are required because closing a fd from an ioctl is in general not safe.
> > > > > This is to meet the requirements for using fdget(), which is used by the
> > > > > ioctl framework code before calling into the driver's implementation of
> > > > > the ioctl. Binder works around this with this sequence of operations:
> > > > >
> > > > > 1. file_close_fd()
> > > > > 2. get_file()
> > > > > 3. filp_close()
> > > > > 4. task_work_add(current, TWA_RESUME)
> > > > > 5. <binder returns from ioctl>
> > > > > 6. fput()
> > > > >
> > > > > This ensures that when fput() is called in the task work, the fdget()
> > > > > that the ioctl framework code uses has already been fdput(), so if the
> > > > > fd being closed happens to be the same fd, then the fd is not closed
> > > > > in violation of the fdget() rules.
> > > >
> > > > I'm not really familiar with this mechanism but you're already talking about
> > > > this being a workaround so strikes me the correct thing to do is to find a way
> > > > to do this in the kernel sensibly rather than exporting internal implementation
> > > > details and doing it in binder.
> > >
> > > I did previously submit a patch that implemented this logic outside of
> > > Binder, but I was advised to move it into Binder.
> >
> > Right yeah that's just odd to me, we really do not want to be adding internal
> > implementation details to drivers.
> >
> > This is based on bitter experience of bugs being caused by drivers abusing every
> > interface they get, which is basically exactly what always happens, sadly.
> >
> > And out-of-tree is heavily discouraged.
> >
> > Also can we use EXPORT_SYMBOL_FOR_MODULES() for anything we do need to export to
> > make it explicitly only for binder, perhaps?
> >
> > >
> > > But I'm happy to submit a patch to extract this logic into some sort of
> > > close_fd_safe() method that can be called even if said fd is currently
> > > held using fdget().
> >
> > Yup, especially given Christian's view on the kernel task export here I think
> > that's a more sensible approach.
> >
> > But obviously I defer the sensible-ness of this to him as I am but an mm dev :)
>
> Quick sketch of how this would look:
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index adde1e40cccd..6fb7175ff69b 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -64,7 +64,6 @@
>  #include <linux/spinlock.h>
>  #include <linux/ratelimit.h>
>  #include <linux/syscalls.h>
> -#include <linux/task_work.h>
>  #include <linux/sizes.h>
>  #include <linux/ktime.h>
>
> @@ -1962,68 +1961,6 @@ static bool binder_validate_fixup(struct binder_proc *proc,
>  	return (fixup_offset >= last_min_offset);
>  }
>
> -/**
> - * struct binder_task_work_cb - for deferred close
> - *
> - * @twork:                callback_head for task work
> - * @file:                 file to close
> - *
> - * Structure to pass task work to be handled after
> - * returning from binder_ioctl() via task_work_add().
> - */
> -struct binder_task_work_cb {
> -	struct callback_head twork;
> -	struct file *file;
> -};
> -
> -/**
> - * binder_do_fd_close() - close list of file descriptors
> - * @twork:	callback head for task work
> - *
> - * It is not safe to call ksys_close() during the binder_ioctl()
> - * function if there is a chance that binder's own file descriptor
> - * might be closed. This is to meet the requirements for using
> - * fdget() (see comments for __fget_light()). Therefore use
> - * task_work_add() to schedule the close operation once we have
> - * returned from binder_ioctl(). This function is a callback
> - * for that mechanism and does the actual ksys_close() on the
> - * given file descriptor.
> - */
> -static void binder_do_fd_close(struct callback_head *twork)
> -{
> -	struct binder_task_work_cb *twcb = container_of(twork,
> -			struct binder_task_work_cb, twork);
> -
> -	fput(twcb->file);
> -	kfree(twcb);
> -}
> -
> -/**
> - * binder_deferred_fd_close() - schedule a close for the given file-descriptor
> - * @fd:		file-descriptor to close
> - *
> - * See comments in binder_do_fd_close(). This function is used to schedule
> - * a file-descriptor to be closed after returning from binder_ioctl().
> - */
> -static void binder_deferred_fd_close(int fd)
> -{
> -	struct binder_task_work_cb *twcb;
> -
> -	twcb = kzalloc(sizeof(*twcb), GFP_KERNEL);
> -	if (!twcb)
> -		return;
> -	init_task_work(&twcb->twork, binder_do_fd_close);
> -	twcb->file = file_close_fd(fd);
> -	if (twcb->file) {
> -		// pin it until binder_do_fd_close(); see comments there
> -		get_file(twcb->file);
> -		filp_close(twcb->file, current->files);
> -		task_work_add(current, &twcb->twork, TWA_RESUME);
> -	} else {
> -		kfree(twcb);
> -	}
> -}
> -
>  static void binder_transaction_buffer_release(struct binder_proc *proc,
>  					      struct binder_thread *thread,
>  					      struct binder_buffer *buffer,
> @@ -2183,7 +2120,10 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
>  						offset, sizeof(fd));
>  				WARN_ON(err);
>  				if (!err) {
> -					binder_deferred_fd_close(fd);
> +					/*
> +					 * Intentionally ignore EBADF errors here.
> +					 */
> +					close_fd_safe(fd, GFP_KERNEL | __GFP_NOFAIL);
>  					/*
>  					 * Need to make sure the thread goes
>  					 * back to userspace to complete the
> diff --git a/fs/file.c b/fs/file.c
> index 0a4f3bdb2dec..58e3825e846c 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -21,6 +21,7 @@
>  #include <linux/rcupdate.h>
>  #include <linux/close_range.h>
>  #include <linux/file_ref.h>
> +#include <linux/task_work.h>
>  #include <net/sock.h>
>  #include <linux/init_task.h>
>
> @@ -1525,3 +1526,47 @@ int iterate_fd(struct files_struct *files, unsigned n,
>  	return res;
>  }
>  EXPORT_SYMBOL(iterate_fd);
> +
> +struct close_fd_safe_task_work {
> +	struct callback_head twork;
> +	struct file *file;
> +};
> +
> +static void close_fd_safe_callback(struct callback_head *twork)
> +{
> +	struct close_fd_safe_task_work *twcb = container_of(twork,
> +			struct close_fd_safe_task_work, twork);
> +
> +	fput(twcb->file);
> +	kfree(twcb);
> +}
> +
> +/**
> + * close_fd_safe - close the given fd
> + * @fd: file descriptor to close
> + * @flags: gfp flags for allocation of task work
> + *
> + * This closes an fd. Unlike close_fd(), this may be used even if the fd is
> + * currently held with fdget().
> + *
> + * Returns: 0 or an error code
> + */
> +int close_fd_safe(unsigned int fd, gfp_t flags)
> +{
> +	struct close_fd_safe_task_work *twcb;
> +
> +	twcb = kzalloc(sizeof(*twcb), flags);
> +	if (!twcb)
> +		return -ENOMEM;
> +	init_task_work(&twcb->twork, close_fd_safe_callback);
> +	twcb->file = file_close_fd(fd);
> +	if (!twcb->file) {
> +		kfree(twcb);
> +		return -EBADF;
> +	}
> +
> +	get_file(twcb->file);
> +	filp_close(twcb->file, current->files);
> +	task_work_add(current, &twcb->twork, TWA_RESUME);
> +	return 0;
> +}

Would need an EXPORT_SYMBOL_FOR_MODULES(...) here right?

> diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
> index c45306a9f007..1c99a56c0cdf 100644
> --- a/include/linux/fdtable.h
> +++ b/include/linux/fdtable.h
> @@ -111,6 +111,7 @@ int iterate_fd(struct files_struct *, unsigned,
>  		const void *);
>
>  extern int close_fd(unsigned int fd);
> +extern int close_fd_safe(unsigned int fd, gfp_t flags);

One nit, generally well in mm anyway we avoid the 'extern' and remove them as we
go. Not sure about vfs actually though?

>  extern struct file *file_close_fd(unsigned int fd);
>
>  extern struct kmem_cache *files_cachep;

I mean this is essentially taking what's in binder and making it a general
thing, so needs Christian's input on whether this is sensible I think :)

Cheers, Lorenzo

