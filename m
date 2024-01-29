Return-Path: <linux-fsdevel+bounces-9459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDFF841506
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 22:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C641F255B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 21:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AB11586CF;
	Mon, 29 Jan 2024 21:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SpL5L9c9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FlspUeMu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAB02AEE9;
	Mon, 29 Jan 2024 21:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706563134; cv=fail; b=hDvqzG6FCql/sKm/1flplKf3hen+bsUOETnqMSn2AN7mlcPY15c+dFKhyf5nMUEqt5hCzzHqnLScFnz51zvabqTG1CbrXVBqm3yV7IBDAmDVGyGy4grO9HpRw7rx9gPlYYOgEMSQcFM44dKoqqmBFQcDumlemk+pRJeQ9DE6oRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706563134; c=relaxed/simple;
	bh=bD9EDIeeNPIaJEQ0ZH5uYe7nwZbMvFWKV2mMVHD8tq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VCfgyfHNyofljXfnDaejpYO0PxZNZuLN3/v+HMFUFLDxBHsK66ZEfAEaz9ARKURxRWZtIAjrdqp3RSRc405fCDCQHBakwy8oBloUx43mgA71OdzQn7AoCTW/nWTUaTOYz5EF7R/3ty+V5omZuJXJMwZ7XvF2bfpc7diRJJ9Heo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SpL5L9c9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FlspUeMu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TJi1gW016700;
	Mon, 29 Jan 2024 21:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=qEURToigZbhgzirYh8kK/FqzebmUzoiNPaD61UK0/3g=;
 b=SpL5L9c9sBnWUGNzl4KB1rQ00etKx+Glmm5wUYNQnS8wC+l8CAVBQh9IA0iobr/HdGCN
 Zi29RQKxacdM0nPicMTCyZMKHqu+BCuVdphLtbVs/JdZxLmQ5wnvr8jB7HzYpYk0OBOK
 E9dTMrJavW/4r7tg6DaHIb5rRwV60VkImMUoJKbE0lneruPV1kmLa4VZCedi/f5J/TSH
 ++bvFnMy3ckN1nn/HkpAtlDHxl6KXI+lGhzzzFIsmv+zjh2i4RtObZu6NhiFIJh9gFmu
 /Tn0u8Lz2yirCZjEImT5AkDN53biiBxf8ssLaTlg4619CW/Tkrlw5aTXAaP8FHGRIpom tg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvseud04c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 21:18:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40TKqdAj035398;
	Mon, 29 Jan 2024 21:18:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9c82bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 21:18:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mToQcqsCRTi1jYraYcRbdYOOs0BxuVcotszK3nvEp/iKkJ9gsuDAdi4ifkYN+QFnAEqQeebUzNi85nxjn3NCd2XwWX2LiIR0sazMzKbZSOR6ZI3y7+6eHbS9KGMIxesjd1jimX2qMCdxH7c7rV2xrsNlaDJipAlFT5T5EG9lDFJcv+z+Erqk3U2fKYBtGNHLga/CM+d6Rjq0BgbfMsXlCboObb4dCQEIKwpOm49fLxn/fEwCh5YLL8JSat/HjJLZqnGfYXu4Mp5IGUHVrqFztllIGCVGMgI0xh9bIEqV09akGoa7tCbjcl+vFrnQUrlQ34ZsWIZDkcnyt/hD3YLF4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEURToigZbhgzirYh8kK/FqzebmUzoiNPaD61UK0/3g=;
 b=kOMJUwhuwfMVL3rV1vZiMLXyhHNcViUYrZ+7mwurNFve0Guuj/jUlC9OSjYg0GQ76Wg27Qxqwich1lp3behMX9QzY0srr8RqENdsAcgvFmcj+2K33baXEcbPIjlCeIJrxLTrBg11h/CHpnMgfEuXhJe6fXLNlUr4X+gUD7Hk0xjMCZ2kNMrRJUJWvEIDOYkdimNwUcnzgiPrgYDDMPasR/HxukqwIkvOakpbUr0sq7wBWQitwSUq2CyA4VIZ9wy3/EWxmpUor1c/SErEVYW3Wl0l1e8pyO+ux+wirYlgmkt804TLEsjmh+6XMxI1l+Uf3HbbYPvsLl5eYOb5M+T+mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEURToigZbhgzirYh8kK/FqzebmUzoiNPaD61UK0/3g=;
 b=FlspUeMuAbtk1tOTQ8KecsgP4P6pHFnDpFmi0flFv0cV6w6BGjiU/gCsl0UzfIiTiC9EDkv/4l9/uKWv7jGvwLDJfjG+hVs66YR70iHBs/HYXeCEVDgckrZMPOxoze5i1rgfsTMf+RdprAadpzkHP+JDEFIuOcuDtxTa6NbsDgA=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB5877.namprd10.prod.outlook.com (2603:10b6:510:126::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 21:18:34 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 21:18:34 +0000
Date: Mon, 29 Jan 2024 16:18:32 -0500
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
Message-ID: <20240129211832.qqg5bnhswy3jur2c@revolver>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJuCfpFS=h8h1Tgn55Hv+cr9bUFFoUvejiFQsHGN5yT7utpDMg@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0124.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::33) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: cae4109d-7794-4783-cef6-08dc210fd9f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3Wq3e3KUjal3atzgGh4RCkw0tTUfyTCQAA27e8yWczjf7YVsG6ibE3IoOXFXWYMCv3wM5ej83tBveYVbwRrSyR6YCFSqRwPN7oKhM7+Cvw6FZrj8EbNop56OmhzKoESp2qHql1NsYP7a29gL9qsUwNo+S6US7CJ7E5sR6PGqp00/zMdEnWKmXwZXIVhVC1HRK0S/1/knZleRZ+5pstxnKxtORqbzbAjxZsqwEfKuwUPcJHlWAxehYErnq2Ux8F+SGVYvY/YdA6bf8kzXCw/YLFodaQLKBeIiltOULyLwWL/YGsoUu3QSRwpeGh6ATP9c8Eq1o8vyu7PnkjKMCuXm5xQbi+uSVKW8ICLwkSD6YuJYZGnWzY5OxKErbSJRC6et9ooligO0HV7NKXWkoQw1RyAlgDvwQDMBs4yzvIHNY2mAtOXbMGPn/iMIJMcLpmy7SqlyLnR7WkKPsqmB8+3o1egT51WeLqS8BF3wNg0FRtEUnSLELce0u6DA/7EekryukOBfgL+bn6PbzsUGZogZ7cZKFQxYNhjtNJkgkd2bRLwHwa+ai2qiyQ5cRBheCPtZ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(366004)(136003)(39860400002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(41300700001)(33716001)(478600001)(6512007)(6506007)(9686003)(86362001)(5660300002)(38100700002)(2906002)(6486002)(7416002)(66556008)(66946007)(8676002)(4326008)(6916009)(1076003)(8936002)(66476007)(316002)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bUxRTTRlTVdCVlN0ZElRM3FYaUQ3bDFWN2VDeTRsKytyelZJd21XQ0lYck9t?=
 =?utf-8?B?TlExY0JuVnEwd0NJNUV2OW5pdm85TDNjZkdWTlBOL2hPZ24wM1RsUk1qZ0Rq?=
 =?utf-8?B?d2JXK1YvRWVMcWI1dDVkT2crZUVrM2xpam50YWtpc2x5Y1hmWHF0VWJlOE9Y?=
 =?utf-8?B?NEg3UmkxYVpwelRncXRCb0JTWW5EUW9LZ2REc1lUY09DVkc0N1VzY3hqSk9M?=
 =?utf-8?B?S0granZjcnhFQVF1eElFSkx3OWFZRXNHc1EybVpsYlhJL0lST2ozWEc1QmZj?=
 =?utf-8?B?d0FtWHBMYXZ1bGJFT1RKTmNBazFVbFNDT0dTQ0dDalRkM2E2L3VLOGtseUts?=
 =?utf-8?B?Y0tGMzhLb2drS1BXbTRpdmNwaXZHMkVGU1J4bXZpbmQrVnRBV0xKaU1HVENL?=
 =?utf-8?B?K1I0Mi9qdEF1enF3VzE0a05DTHhucFNrdEt3UXlxMXFRbFVDVlMrcVpBK0RT?=
 =?utf-8?B?bnJWVE1RZCt1ZFpXeW9VSHhJMWcyWDJSRURWeVNPb2x3TXk0Rzc0d09xOThq?=
 =?utf-8?B?YVRJS2Z2Q0dCb0V2NFRyMTg4R2syb2MweUMzc3p2ZHo3RWdPOVJ3cDBXNmFy?=
 =?utf-8?B?RUlkOUUvMHd4WjIyODFoWE9EZGJPMTAzZ29XallVc2lVRDlFK21laUJuZE4x?=
 =?utf-8?B?ajc5Zml1K3UvbmhpcEJuTWlZc3psUXRCQjR6WERnNkRBeGR6bUF1Y1ladzFv?=
 =?utf-8?B?dDZNQVVtZGVNTytVUkUxSFhIM1hVdHFTc3dwSC9Ba1VyWEIwZHJtYWdXT0Vs?=
 =?utf-8?B?SS9qaCtvSjB0MzNtVTBvdk5kS0VoWkUvNitnakpFaXZMZUdCYjA4Z1EyYlNy?=
 =?utf-8?B?N2UyaTJxSXNLOFNPSWU1cU1aYWNIdGd0OVNxMDFqVEtaWHZDaC9BOFVsclA2?=
 =?utf-8?B?K2R0UEk2RHJ6aUJ5ckFmLzBEVlVIZ2lGMGdnREMwU3EzV3BMVGxIZUJOdEpk?=
 =?utf-8?B?ZVBPY25WcXdlOGhqenJGTWRvSDBsUFBtN05zbHUyY3lwWkE0cW9DeVdERXJu?=
 =?utf-8?B?KzV3ZDZzZUI4OXA1Q1RLN3RUbWd3U2x5MndHWXlyblRiTkZSai9TQ3ZCbDNp?=
 =?utf-8?B?elVETzVMMWZYRDBPMTQ3Qk8xSEorNmptOTJidW5VL0xUN2xUMUFuM3NTQlRs?=
 =?utf-8?B?bjlwTXNiNk5CY3lmWURwZUtycUlLd1Z3NnlxYkROSVljM2RuRnQyVHgvUGVP?=
 =?utf-8?B?NVBPU0VpVTRYZldVMEJVbmZkdCtUY3pHdVJxc3BQbkZ2cytKVkFJbitxa051?=
 =?utf-8?B?N05ZdjRMRlR2bmcrT0k3bFBTNHB4VEZmUnlyNmRTTWRVa2NXMEljSE5hR1p5?=
 =?utf-8?B?cEowM3d3aGpYVURyYTNZaEsyUmtMajlTc3pGTGxWMXJMNXhIV2RpUU1oZ2s4?=
 =?utf-8?B?TjNkV1dIUmpnYVA3d0xPTkY3WUJhV0FFZi9VWjFuMzFqak9qRjg0YjZyUWJB?=
 =?utf-8?B?ZlVKMSt6VVByaHVldzk4QlgzMGJldGlHRHVkSk5EMnB6OGdaNWVVUFZrZUIz?=
 =?utf-8?B?ZTJGbGpuTWFvZnBOeDczc1VBVVVVbGdWdGJhRHdOWXdpK3FYbzhpZC9UWThS?=
 =?utf-8?B?cnBmVS93QmxDNWxua0xTclZOVUdJQ0dHSGVLL2RVczR3VjdEY1hoNTVGV0pO?=
 =?utf-8?B?dllwQkNDSVA3SkxzWGtGdEJNcmV6dExrQ3F0NjJhbFNvVDczenRtUFpRdmI1?=
 =?utf-8?B?YkZScVE2UDZkWG9sd2twV01LNDJ3SWh5eHlhREgwaEVVbnJXT3ZUaTdRMFk0?=
 =?utf-8?B?dzR6aWtsblJkdzE1dDZDV2o2ZW9xUFlHbW1BSnUvM21aell5QmNoUEFPN2hZ?=
 =?utf-8?B?NGFjNU42YjVHTDJUNWs2UzhHdlFjN2d4NXdiM2xDMk1hQ0wwb2RRdU9vdmpk?=
 =?utf-8?B?Y3d5MFcvb3lsblFtWHBaTjY0RnI4Z3lxRFBkU0pXc2xxYTZXMVg5WlJiQ0lr?=
 =?utf-8?B?MXMvOHdvWDVIK1dVa2taTzdEU2ZnOHhUQjNmcVBJQzVYMmlzd2Y1MXRNMDda?=
 =?utf-8?B?dEdrSUxpTlJUbkV5aGtZRkFQN1VKaHJpMWY0TGZCU2JFNTdvU3E3WllMd01r?=
 =?utf-8?B?dlptZlVrYzZmWmROWDFOb1ZEWkZrUVQxWU4xc0JQUFlUNllOWnIvUmFmd1I1?=
 =?utf-8?Q?vI5W04C9le79PSR36VZ9lR4ek?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tiCmWjCTAJmSi7jrhBdGcVJ366tpGdUfScFXljyttMZdPGgC0GVJReq8KKgH7dtKIN5mZ7poPkqRquUbYNYzqj9ptXzWCb0KQbtZAcKN37WmO7SdIuTjSVffRx32AP5u/bflcpJ8nuL0brwPONcbBsAK9AgeWv0IDd8Ep8W3uznRpjXF/haTpNMY7JKte0AQvleR+8Sifa5lkXOxw8QwgQmCv7cHOf9gimQUDZIP2R9s/U23rvOWvDtqCwUQxn2VLcbzIGvn6buqvU+L/qFBTITAMrdUZ3VOnnR0OR7U9iUdpjGMJkDwteF9hU8bHlQlWv+Zv4k370iPViFjhmPlA+zQ6zJ/yjQvX1+Hap6hOv1EmTlcIy8BU8qQw+31fM2qlvqflANmFniSZwzeLqE+MEWGD9xH9A8n/BrI6P8r65PPVB8QXivVJZA7Qq/0yrs/nq42R4QMCVgX2jIqe8icmo53bPrj9iPCfsmviw5sDgbpsexGePPMUyaVkp8MgMABZomw93VL2pzfIS18QekfA+cuIqZ3gTdP5ntibxlVHyS/hHx6h8UaTJHk+4Me1VLlRy3xE1tD43XcRQhatLOuLpN+EwOKgtc6K1d2ZMR3UOA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae4109d-7794-4783-cef6-08dc210fd9f1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 21:18:34.5777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8aKc6Lo9hA4TooNJOL/COgflpjVkZDAFMerpMVWVU55feARpCShbjIjBa8u+jviV0xcLJU1MP8jDC6bNtjh+7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5877
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_14,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401290158
X-Proofpoint-ORIG-GUID: XiOsmxzHdAv9eXeRwjW67Dadg_vM_Kos
X-Proofpoint-GUID: XiOsmxzHdAv9eXeRwjW67Dadg_vM_Kos

* Suren Baghdasaryan <surenb@google.com> [240129 15:53]:
> On Mon, Jan 29, 2024 at 12:36=E2=80=AFPM Liam R. Howlett

...

> > > @@ -465,7 +503,7 @@ static __always_inline ssize_t mfill_atomic_huget=
lb(
> > >
> > >               if (unlikely(err =3D=3D -ENOENT)) {
> > >                       up_read(&ctx->map_changing_lock);
> > > -                     mmap_read_unlock(dst_mm);
> > > +                     unpin_vma(dst_mm, dst_vma, mmap_locked);
> > >                       BUG_ON(!folio);
> > >
> > >                       err =3D copy_folio_from_user(folio,
> > > @@ -474,17 +512,6 @@ static __always_inline ssize_t mfill_atomic_huge=
tlb(
> > >                               err =3D -EFAULT;
> > >                               goto out;
> > >                       }
> > > -                     mmap_read_lock(dst_mm);
> > > -                     down_read(&ctx->map_changing_lock);
> > > -                     /*
> > > -                      * If memory mappings are changing because of n=
on-cooperative
> > > -                      * operation (e.g. mremap) running in parallel,=
 bail out and
> > > -                      * request the user to retry later
> > > -                      */
> > > -                     if (atomic_read(ctx->mmap_changing)) {
> > > -                             err =3D -EAGAIN;
> > > -                             break;
> > > -                     }
> >
> > ... Okay, this is where things get confusing.
> >
> > How about this: Don't do this locking/boolean dance.
> >
> > Instead, do something like this:
> > In mm/memory.c, below lock_vma_under_rcu(), but something like this
> >
> > struct vm_area_struct *lock_vma(struct mm_struct *mm,
> >         unsigned long addr))    /* or some better name.. */
> > {
> >         struct vm_area_struct *vma;
> >
> >         vma =3D lock_vma_under_rcu(mm, addr);
> >
> >         if (vma)
> >                 return vma;
> >
> >         mmap_read_lock(mm);
> >         vma =3D lookup_vma(mm, addr);
> >         if (vma)
> >                 vma_start_read(vma); /* Won't fail */
>=20
> Please don't assume vma_start_read() won't fail even when you have
> mmap_read_lock(). See the comment in vma_start_read() about the
> possibility of an overflow producing false negatives.

I did say something *like* this...

Thanks for catching my mistake.

>=20
> >
> >         mmap_read_unlock(mm);
> >         return vma;
> > }
> >
> > Now, we know we have a vma that's vma locked if there is a vma.  The vm=
a
> > won't go away - you have it locked.  The mmap lock is held for even
> > less time for your worse case, and the code gets easier to follow.
> >
> > Once you are done with the vma do a vma_end_read(vma).  Don't forget to
> > do this!
> >
> > Now the comment above such a function should state that the vma needs t=
o
> > be vma_end_read(vma), or that could go undetected..  It might be worth
> > adding a unlock_vma() counterpart to vma_end_read(vma) even.
>=20
> Locking VMA while holding mmap_read_lock is an interesting usage
> pattern I haven't seen yet. I think this should work quite well!

What concerns me is this working too well - for instance someone *ahem*
binder *ahem* forever and always isolating their VMA, or someone
forgetting to unlock and never noticing.

vma->vm_lock->lock being locked should be caught by lockdep on exit
though.

...

Thanks,
Liam

