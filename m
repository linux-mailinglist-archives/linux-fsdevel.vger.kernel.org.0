Return-Path: <linux-fsdevel+bounces-47755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6E6AA5526
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 21:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C92293A8B04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 19:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8DB27932E;
	Wed, 30 Apr 2025 19:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pxh16EUp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="csQVu4Tl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08111218E81;
	Wed, 30 Apr 2025 19:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746043168; cv=fail; b=Cgh2/MpWGR7alpXBeA/flcFurp8cBNkniHo5Gs4RZIzPgfIwH91QctQhn4yBU72H9nxn6FRthoOiZaiOzCtpezMzMKfXWJYpIH1MrR9sd17TJXQZ1o55teccPRGf2Xc4FuGtTtGbmCAgAs3LjF4wqaXAZM0Bq7mULe8jQootZYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746043168; c=relaxed/simple;
	bh=HPBQhkD+FxqFJW00DVIsALC6NB3/R3IFhVH+aZTtC10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XEw2k9C1AvWORuWZF1pvvGqvtwqoUtZrrvsm5Ur/7tsJ1bALEnoupMsprU7fyqsSZuofN6SzKoR4/8Wt180X9Yq+0pbBL7v5ZoN62/LeMQBNQM7nHS0dtsXTH6ZNKfg8Xf00yYJyntjDOxjX4tjG9icNtRPUfOnmUv2LJvhlbnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pxh16EUp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=csQVu4Tl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UHu1cm008936;
	Wed, 30 Apr 2025 19:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=v2KOL1ga8kPt1iYJ1V
	tBRM2pmmSYvph5lWyxpl3ETmk=; b=Pxh16EUpBigKnxTBvMlLAaUDM9gsbc26Gp
	kLVH/eO316QdcsvlrsXgUrSb7zXNUyTIJL+4L+7KtQ+Vez1Dcpj3D1R/JoVfK4yI
	TDAU3ighh4b9Kllak7/kKsJBVjOj9E4AxmDdjLbVmqCr1YC9FVYUm6UltAwVrU2g
	Wqpw1jL2b9xRIwYD8MYrIxXN3bqv69UcNMoNwa8RZLnawAI750b/F1Tl1B/I68+T
	GXFd2yCn38ntLHZ4QFIPCFgVTLyMy4YMjsJbxv5sYhNCIzefiFugDYrn4YXfisy4
	krd8IGJexQIahqGjdaBd35E9my1SPToistY09s7gDo74sOE/vG6w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uta189-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 19:59:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53UJoQ7L013974;
	Wed, 30 Apr 2025 19:59:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxbsyq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 19:59:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrZxONy7rwst72FooTUx88ba4PQKoSzeueHbVW3V4eO1d3qGsfw1TyXFUPYoPmoPZs6E7qjK8gV7eZ6+l9kV4ylZ5vGzGpa1l4K5IHdz/YmvOyKAqN/kCXeyq3tscdMwiEKAeSO0Rjbu1RHVcOjOK/fEBhEt4NnUncKpuZ5zLcdeZcLFgtxmELQPRQgbt2mhfnDa8u684xJzs2DJhdbB5eJEun2aeeivPNNbhd8RxiYjW2CwnuJktoYjUplorKof4ip+uP7WZ3qDgMbWpnQNISRa99EBojS0jUTtB/AeZiEwQ+lnkfl8cUfAnlscz2xJkQhRsNtAHOdu6cNA+ufBiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2KOL1ga8kPt1iYJ1VtBRM2pmmSYvph5lWyxpl3ETmk=;
 b=lCv6wDSd4iPicKIbBSZ5NlQQiywXsxR0/VgQq1uSOG75pPecqa5iQMHIQ53P/gGQMG0/CbktNJjMaR8WSNkpTKFkGy5uz9kIQ/eR0v5jA4hFabIAcu2YYGZTdYpo1ABNm6Y9/wstMdAxT5RR0rSCT8mKHpZIqDDvaN+1x7ckgWdhT70SBoeeXLHglVVMzUWBh6+NlCagviklYOx/A+o8XRZmgG/xTfFXVjllmM79SqJrvyHlpfG5dIxxcT2GGeX69JERC5Wj/NmvJ8EGCnhC50v9Ku/hhQOxi8Qv9DCP5YcsvzWSlKaR/adPhISHRWlHBC4pjSyv1YLEu7Hhz5K+pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2KOL1ga8kPt1iYJ1VtBRM2pmmSYvph5lWyxpl3ETmk=;
 b=csQVu4TlhnzRpxvT3pxueZ386VCbRwfvBUnoxz3QSUG3s9P7GqJdbZ3YBk3FDWfT2TnAQgr7+/sScqCexth8TXZRjSqEZ5hl9+ZIMQyPk3B/SYjhgPN9JaFfjgbHhog6NzqYA4VCxYCZhB4jbbTfyQqb7whZaLdwk7uQjcymAS4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH4PR10MB8051.namprd10.prod.outlook.com (2603:10b6:610:242::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Wed, 30 Apr
 2025 19:59:05 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 19:59:05 +0000
Date: Wed, 30 Apr 2025 20:58:59 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 0/3] eliminate mmap() retry merge, add .mmap_proto
 hook
Message-ID: <c6335d9a-797a-4ccd-8828-b22f72354b8a@lucifer.local>
References: <cover.1746040540.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1746040540.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO3P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH4PR10MB8051:EE_
X-MS-Office365-Filtering-Correlation-Id: a91e56a3-cdb6-4e75-3cc4-08dd8821763f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?toyszO5/87M8eb0xp8WmB+hEQrhimWD6qq+CX5PlouPq2ZGbpuFDDDOr7t3v?=
 =?us-ascii?Q?gTPtWLy3V57Kd8l2Lbc8Xg/DMOld2wD7dZVlgVcQVffXkRKInuIeYgyIzKH3?=
 =?us-ascii?Q?QkjQiafb1i9DW71wtT6+HjU2qqCmrW5kY10eAyOmT9x2SMxBOx3GBKtvx/T2?=
 =?us-ascii?Q?sRLpfDzaM18ppFRlsA2YgM1vYAytMguH2PdNQ9GlfZ/4a8N7UZ5t0RVUOjWk?=
 =?us-ascii?Q?5gupyupm5+HktKd3kaULBFwJb97gf6iwsHefPPP8VEtxP8tixq/aK9ga5gEP?=
 =?us-ascii?Q?tHh3Py43baBatuug35LyUkLiVZHVa07/aeG2bFjlfp7/YWl1YelKNO4SDOPF?=
 =?us-ascii?Q?i7gZlBzrog3AcpRNgH+Sauk58zGXtc9kQMwzVciunvwJq5/UkDk2tq0AmzLU?=
 =?us-ascii?Q?OBNEzx/78F1KmHdHWmyeQ06MvyQwWAF0nWckUP17B+r3fAlwXqxMeaMrilBq?=
 =?us-ascii?Q?AsXQJaB/E3STVY73UxJzpP5/plkTglRMmXbS93NQzqVdHXjjYse1ZtD6VvEI?=
 =?us-ascii?Q?udi0IMEOnldjt1uyK9H6kulfRDJUBbgtD7eJ1/M3Wo+Y2btu9LQ3dE/lY5R6?=
 =?us-ascii?Q?kfChZmwN0k2VPfybgRTmanKv8KTi7Jf3A+LsD6GL5t9ZYVITbUEfGjlg7RCj?=
 =?us-ascii?Q?MhxuwEPJZqV9UYWp4qk4kFsBO+VWErNVE8atudX+SK9d4lnWGzVJZoikt7xM?=
 =?us-ascii?Q?bnQNi6i7GwfqAfTJtFuaP2ZBnC/vcF3ODLpsccCttYxuytnK2Q4+eqiaECQX?=
 =?us-ascii?Q?VnPAoKZVatg1ENToyT49WFv00Wpdq4IsODFqLoJCj9BujAzJ9QOrAGDLfihd?=
 =?us-ascii?Q?5WOQ+GfYfW+DgAyl+ttwVQpBfvi2vWk2Y9FI3JiFtEQIrQEOE1SbkU+EHyYe?=
 =?us-ascii?Q?4RxEqpVvwTLhlS4osbzUI+OSJ/aGW45rvc0PKK6Hp+20IRNVn69wgreGI5AY?=
 =?us-ascii?Q?MoLL8hE0roTcExx2hAgOXaAP8WaxZd0gAJz+VtZwqKNwFUqrU5JbM7hpWaRd?=
 =?us-ascii?Q?NtPqcrS6lSDfOs+SjbYicKhaCojBB+9UINR83zPLK0Cs/nbUub5iEqpzmgcX?=
 =?us-ascii?Q?eg+fPPgZ3g/xw66cALFyflLsCnFB7Q/9pf8YvBa+Ktd+rFtQ47l2m3KrYc6E?=
 =?us-ascii?Q?JkfJv32pB4JZvlm7f4haxizTvmhFsLrFIeqDoMhYDj+8yYtIEOBuieS8Uwf1?=
 =?us-ascii?Q?2jrU5IE2iAl+5830RV26QV0L4VDCERFzxtTpX6iysz1SgOu0PCHWusgjsPn5?=
 =?us-ascii?Q?5HKcJkPzXw5fi8hfTh7yrYM1WEC7NboxSwxxLylH97f4R858QhRHEHyHgBzz?=
 =?us-ascii?Q?OiZFS/nB2ZLcDWTjtvZ4a8Z6G97w09Wfw8hp0Z3RYFr5q5+Bx88BL/bmtwaL?=
 =?us-ascii?Q?Nfh5GFmXpMGGnffskwHx+QmLhhtm9wNDq85cOQNYpIWbiUFVTekV+7R6oryd?=
 =?us-ascii?Q?g05cdk0HCOc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cyC9PooCqtB7RmMA/DXglrAmaQQdT3oHpsl06FNDRvWhF947zBSEnop8b2mL?=
 =?us-ascii?Q?8uzQ40W7et4X3QaAPwVKuiIQ2u1IW0x7qNCB+C2ekB/h7uLT+92I+PrnTZRl?=
 =?us-ascii?Q?pnWLjH+rMOTxsXeIE0A5WenHVW7+4ijlFsj4EydlMTb0eYchj3SH/qBp98a9?=
 =?us-ascii?Q?UnoxjTD+K1Gx1TBmlOYfQf85wmujq+BUChmUj7QlF9cM8P4nIa7sbeCNlUHS?=
 =?us-ascii?Q?mJQXhBJl2JEbtVdhSK+d3XolLgpGA9fYM+skv+JT9ac2QVNFwQn/td9AiY6Z?=
 =?us-ascii?Q?Ik3U+fUeQLFJQG0ImbORKV3bOD89d9G9DUf9kMrhl0HrqM4RI3PbREEz/pxy?=
 =?us-ascii?Q?Kl6xunS69oSKZDLIV3pVywal+ZHyfw9/sbf+hzq1sTrVbM7QTB8XM3VXs/bd?=
 =?us-ascii?Q?AFVhJQ+lEK8UYANz3ArmBaM4+xxdbLL+d0819ayX+FVMGH5gA9+xN8/tUrOZ?=
 =?us-ascii?Q?uvI8DKDCYDz42uL2Bg6JQpu2WtCvSEi+o1EzDmKYJL64WdR+y698dXsOuTbg?=
 =?us-ascii?Q?gXn2B2K+SaIOSdWoL6iVaTZqQvVN/YMy9rhdaPQK8hZQESR+K5Ir/P9xFWK6?=
 =?us-ascii?Q?ePiD1eZ2Ids+g8K3gGp5UZ2Aa/IS2laodgeOMx1u5orFg0QUExrnn0AyP+B1?=
 =?us-ascii?Q?suF4+siyMuSh6cUNUaPvAlcQNdrvvvTc98t8RB+roK0Bvqn9lPkP9Tc3McNT?=
 =?us-ascii?Q?F78iqgLYr9FjlRnZTdc5I95BYlfgQ0oQQpCeZBqc9L/cdfl7qKvrOaqmiqf0?=
 =?us-ascii?Q?+8zzUgc13hwlrz7pBW1zJJUyVqzffpaz027ifeC08KYffelbAn01jHTmG/Jl?=
 =?us-ascii?Q?8Qw62R5UwaEfDYNQbNu45Kr8TM09aefDZHNxN+fHumrBtt9FaJmqQbjjkFoH?=
 =?us-ascii?Q?X80Hsp8xBGa8+yFLvV2vjeUnuG2/tnl6EAznch1n3Yu8qgT4AjecUfNhbUOO?=
 =?us-ascii?Q?ECd3GjcudqMca24FnHEf7iIdkH57adpa4Yq0pL6dJS1kZ1f/rgoTvJ6z6h9a?=
 =?us-ascii?Q?7d72Gql9ZaVRJ/+A7PtH2N+6zaTgTE57n+b32ws6r82eE4HcAkTmCE9Xymej?=
 =?us-ascii?Q?ZOmhyqXkdy1BSLpzExRduKIDVNL+k/k8gqR7UAZ1CqRBjX+RnptAFjf4JMjq?=
 =?us-ascii?Q?ypFznDtZfgmJLs/Z8m7YwkEgxyhGq5+o6D3vKkWjF/jSxW6MwxagXZgJTAxL?=
 =?us-ascii?Q?XwiktgH6qgEW5lcwAS8UrBK764Q4mSZu3ebP6MW9BodmSAE3wY5RIbVJDnDx?=
 =?us-ascii?Q?9tM1D7ami0j+L61zQQxxqF9hwaRyeoMbrU/9LDw7qAcY7JGmZlmRk+/cjdG4?=
 =?us-ascii?Q?MHFHvWAyTOSq9kH/mG3wuNIsVi65+9p5iy81v8vOMEt1HK/fkPlcMFeTgKOI?=
 =?us-ascii?Q?nrj1sGQtR5h3I9IP7tQXqkqZN/BN8Ol6aXWvMH2XZjZX1keeMc43phDmqgcg?=
 =?us-ascii?Q?wuwMO98Y3Yg1fID0g8EdjbUHxF1NBDhoE+wJIbD38kW7CqPo8qxpiVM1pWXG?=
 =?us-ascii?Q?+0H+nMXA5rsfJeNq5CqmayH1mMzHHa3bOA8lxaYuhcLDDq84oTWfiYnACODc?=
 =?us-ascii?Q?atIH3EC7G6uyhiNlhcAupnqttpeuNkB0BhOcyvFt7WB4TfiG7Uli/6oWic+o?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WowwK7FWhbdHiLC48EV6vyMEVygL14MClgHRkzEj4d8foSuCR0bcL7qB8WsQ4uuqjnVyft8+OkdyfLDqwac9wcBsb4KCyebUChrghI9PmqrmCPGT06BYob43zb72/IEQfYQkFF/nr4kjT3Wd1bHpiD07KZjMlJYS/co1MifED5gCWSzANu9rQRI62nf+9eF5iaLUAx/I8PeT/NOuweLi+EMRUkDtpvp2yFvKtkxUG6Oiv21XCtEIgTZLE3/oxgeAalKvUbygAeYDrpNLoJpGz1mhAwJyqUjFuxU48G4nvfElfeZGbM+s1Hgf3GfdvQwawldklkgSd0FYwa9sohuB/nReRi92C9M84r2D2Cfjd4Ae/SCTTRxVRfOFEv7KqB+oHLRfr4W3ZaQQQK1e0YT9Q7sn/+k/wDEBq9b9x2dmaYsnk3CkaFF5o+9/aIXPGBDfKF2MEgoMUYsIJzjmtG2hokDBsMzM35rBvpszqoXZI8hhxXW2HegzzykluqtjJghAEfsB5SkaICHy0x2iH/GUwdIRN4oiOe1+1OCRRMOtssDnKQcZiP27QThCzhi1Bw8S2S32EruMfa/mT7mPfRcBtmUq0WVaxtEdMKIqxCdWRMk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91e56a3-cdb6-4e75-3cc4-08dd8821763f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 19:59:05.6359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHzNjfTW7T1pZ0xxKGkUkZJ4gedIacTM1z+tOIcb3toWBKfksJVlGo9BjUiUe3Qv32ID1GCiygtX0o+hW0Dz7KBpkpzJRwxQh8hgjyOxGsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8051
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504300146
X-Proofpoint-GUID: ttkcw6s97Z6-l1E_OKUbBwAR1SWWvWC5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDE0NiBTYWx0ZWRfX73+ghWUwXEkY 4m+bufY+TPb1ou+vQC3KTFBRsXALChB0i2AmarwNhHTYc6AzlUVRRKK4ncVeeuky57jZWEAzHX5 WZSm8HWTiZtT4ixtONfoMRLz+KUIochybtNdspyC2WI187tHPY4UpOwK1lh2yp7VQ4whsmGi3p+
 1G8KDakCwEVX/a8T1V5BIULVeGHw2msbHtSuq84OkLR6rEhUKaFBMjKTDnMbIjl22TTJ7beoQlO V103DHTM6EixckNC9oSBlBGAKoNf2V+ihQgFWfHWPJklA3exD0BLPgAOU6rigui0hA37RnagSND fzPuEGYoLG4gkzPVgjHirfpXKzt0WSrQ/3q03rt2ePWQV9RUNzw/AFpoMhnXws97VQ+tGDFTE1c
 ryuaJ3Q79CGaugHTc5Bz9kNWdg1M1l+aZeExjc0OQ1mJBSWY62ndTHZeus9DVLllHpuqLTQT
X-Authority-Analysis: v=2.4 cv=ZuHtK87G c=1 sm=1 tr=0 ts=6812810f b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=hUIfCTMR2JyyZYqEob8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: ttkcw6s97Z6-l1E_OKUbBwAR1SWWvWC5

Apologies, made a mistake that I wrongly assumed tooling would catch... let me
try sending this again...

On Wed, Apr 30, 2025 at 08:54:10PM +0100, Lorenzo Stoakes wrote:
> During the mmap() of a file-backed mapping, we invoke the underlying
> driver's f_op->mmap() callback in order to perform driver/file system
> initialisation of the underlying VMA.
> 
> This has been a source of issues in the past, including a significant
> security concern relating to unwinding of error state discovered by Jann
> Horn, as fixed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
> error path behaviour") which performed the recent, significant, rework of
> mmap() as a whole.
> 
> However, we have had a fly in the ointment remain - drivers have a great
> deal of freedom in the .mmap() hook to manipulate VMA state (as well as
> page table state).
> 
> This can be problematic, as we can no longer reason sensibly about VMA
> state once the call is complete (the ability to do - anything - here does
> rather interfere with that).
> 
> In addition, callers may choose to do odd or unusual things which might
> interfere with subsequent steps in the mmap() process, and it may do so and
> then raise an error, requiring very careful unwinding of state about which
> we can make no assumptions.
> 
> Rather than providing such an open-ended interface, this series provides an
> alternative, far more restrictive one - we expose a whitelist of fields
> which can be adjusted by the driver, along with immutable state upon which
> the driver can make such decisions:
> 
> struct vma_proto {
> 	/* Immutable state. */
> 	struct mm_struct *mm;
> 	unsigned long start;
> 	unsigned long end;
> 
> 	/* Mutable fields. Populated with initial state. */
> 	pgoff_t pgoff;
> 	struct file *file;
> 	vm_flags_t flags;
> 	pgprot_t page_prot;
> 
> 	/* Write-only fields. */
> 	const struct vm_operations_struct *vm_ops;
> 	void *private_data;
> };
> 
> The mmap logic then updates the state used to either merge with a VMA or
> establish a new VMA based upon this logic.
> 
> This is achieved via new f_op hook .vma_proto(), which is, importantly,
> invoked very early on in the mmap() process.
> 
> If an error arises, we can very simply abort the operation with very little
> unwinding of state required.
> 
> The existing logic contains another, related, peccadillo - since the
> .mmap() callback might do anything, it may also cause a previously
> unmergeable VMA to become mergeable with adjacent VMAs.
> 
> Right now the logic will retry a merge like this only if the driver changes
> VMA flags, and changes them in such a way that a merge might succeed (that
> is, the flags are not 'special', that is do not contain any of the flags
> specified in VM_SPECIAL).
> 
> This has been the source of a great deal of pain for a while - it is hard
> to reason about an .mmap() callback that might do - anything - but it's
> also hard to reason about setting up a VMA and writing to the maple tree,
> only to do it again utilising a great deal of shared state.
> 
> Since .mmap_proto() sets fields before the first merge is even attempted,
> the use of this callback obviates the need for this retry merge logic.
> 
> A driver can specify either .mmap_proto(), .mmap() or both. This provides
> maximum flexibility.
> 
> In researching this change, I examined every .mmap() callback, and
> discovered only a very few that set VMA state in such a way that a. the VMA
> flags changed and b. this would be mergeable.
> 
> In the majority of cases, it turns out that drivers are mapping kernel
> memory and thus ultimately set VM_PFNMAP, VM_MIXEDMAP, or other unmergeable
> VM_SPECIAL flags.
> 
> Of those that remain I identified a number of cases which are only
> applicable in DAX, setting the VM_HUGEPAGE flag:
> 
> * dax_mmap()
> * erofs_file_mmap()
> * ext4_file_mmap()
> * xfs_file_mmap()
> 
> For this remerge to not occur and to impact users, each of these cases
> would require a user to mmap() files using DAX, in parts, immediately
> adjacent to one another.
> 
> This is a very unlikely usecase and so it does not appear to be worthwhile
> to adjust this functionality accordingly.
> 
> We can, however, very quickly do so if needed by simply adding an
> .mmap_proto() hook to these as required.
> 
> There are two further non-DAX cases I idenitfied:
> 
> * orangefs_file_mmap() - Clears VM_RAND_READ if set, replacing with
>   VM_SEQ_READ.
> * usb_stream_hwdep_mmap() - Sets VM_DONTDUMP.
> 
> Both of these cases again seem very unlikely to be mmap()'d immediately
> adjacent to one another in a fashion that would result in a merge.
> 
> Finally, we are left with a viable case:
> 
> * secretmem_mmap() - Set VM_LOCKED, VM_DONTDUMP.
> 
> This is viable enough that the mm selftests trigger the logic as a matter
> of course. Therefore, this series replace the .secretmem_mmap() hook with
> .secret_mmap_proto().
> 
> Lorenzo Stoakes (3):
>   mm: introduce new .mmap_proto() f_op callback
>   mm: secretmem: convert to .mmap_proto() hook
>   mm/vma: remove mmap() retry merge
> 
>  include/linux/fs.h               |  7 +++
>  include/linux/mm_types.h         | 24 ++++++++
>  mm/memory.c                      |  3 +-
>  mm/mmap.c                        |  2 +-
>  mm/secretmem.c                   | 14 ++---
>  mm/vma.c                         | 99 +++++++++++++++++++++++++++-----
>  tools/testing/vma/vma_internal.h | 38 ++++++++++++
>  7 files changed, 164 insertions(+), 23 deletions(-)
> 
> -- 
> 2.49.0
> 

