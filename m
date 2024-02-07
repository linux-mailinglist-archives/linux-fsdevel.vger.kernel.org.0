Return-Path: <linux-fsdevel+bounces-10654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 811E184D1D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 19:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A611E1C2170B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 18:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E7784FBE;
	Wed,  7 Feb 2024 18:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P5i14K/j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MTjRjY31"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D231C83CD9;
	Wed,  7 Feb 2024 18:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331973; cv=fail; b=A95c1zZdLXPXoJ84RfxgynjmDX0kWXZfNAAYeaX768usbtQX4euaCKPYagTM/62yugVnm0z9EjirgCfdFd4YcYEFq50sqfsW2I07vIe5V2ubxqOV0zwgX0Yhwudh+qEtJ0w4vcn68aAB2Owvt+mn8iTMQpTNnJ2CgYAm1elXgwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331973; c=relaxed/simple;
	bh=i+y0tIseE8aXnG1dVVmdHzw3iIoB10O8M+FwZmddtsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H+cS10/RjD/oIR6yaijYXCuHfUtBydNfCL/kPiJYuxp+Y4ubHPHavtM3a32DsMKiyllQA8O0xVT/nlkU6oVZ5/5ZFEDjicEFGVkp8FVlsdCRUSSyfqEDA9EekHSCzcndXfUe6gdoSKgv492J/WyMzlWtl0Md0/r18eti0cgEeHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P5i14K/j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MTjRjY31; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 417IIv3f003819;
	Wed, 7 Feb 2024 18:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=D+00c4+p8H+AniaCN1J4yUe/zz/Qw9f4WbaIi/DAm5Q=;
 b=P5i14K/jQeXq8ORo9fJfgaHZncVBv1NGIBW6CSY722nNbxCDh0dEJ/xXKGhd2cXfCa+6
 GzcROS4Gpxww3BcaDTpBcRbQuoIC8dDE/7saDu7mW6PaTVcqLqXD2Cc/MQJ0sCmwUtg3
 cBQp7RM3FxDYDr3JdJTXWOWp0M6Y4F3exWHQaHyFuu8IPoyhQFMe2cduWRX5HJIg5CM7
 HFPqM8URJoFMNzc0+N0U8ii1ktVojpGB1fEga8/w874rzNSnRHv78y41T7Luy3L55KLd
 JpARyrlNyO6WNaRJxC2bucDx6YJCEL/JbgVvKuY3TInL3uZ4kQFGTJx6iznvjZ/H+jER eA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1d3ujn41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 18:52:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 417IPr3A019687;
	Wed, 7 Feb 2024 18:52:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxfry4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 18:52:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3FOcuS/zcDFRnb9Bx34heDB3yYFb7bGqb8qSR/YOiEwqgP7FfF8kCCnHUEcJ6fSemssKl1h6mSqJvCUFQa1u+hngYiDsrRcKXgqtKXKdsK1htd4/IwMYS8BJ6ujx9e8gRTWrLt43dtp/jaDH0oYoSfzeyz7MgsOKpb6ixJEFiS8qqTTKr4lk49JBAjrvYOg5CZDHqXyf72C7Mxc4SYxwu6SR576broG7veHsgC0iINzPU3kZtGMtdI16FNx0pFoNNYiUqREQEFlEZf6lRlSAhb/z/aLFkKC4ll3EW8rFRIIaSqd6+2qhQEbqofa83Cx3N+4fw7IchwlFWYaequ1PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+00c4+p8H+AniaCN1J4yUe/zz/Qw9f4WbaIi/DAm5Q=;
 b=huwyBmC1PUTjRhSiLhfWwwyNSJu5P5U9KVY97RyTpiM3N6dTtYdwSdQdVWw0meX+U1+pVK68WPAJlLVVZJTH4I0ZhSPcrTUfMrynlk8E0Jy1ez4HqqVU0VkZ+OhXgifnEIbXuPcq1AYw+8OFIrsb2pwyFa8ZsHHwX8JNclJrQmLsRW3avuLO1Q23VPy0CQ1OI5BCrYxCf32Mm37k/lag5SC/7IOwUyJ+ocPAkPzlCvoqJZ+gjMex0rWh5WpG4ph+biQJw1feof5AxKO/V2gWF3VfV1yjA1o7LfOrmp0J0FiSYFMRcF6D8Kvn7lVmSB6lrIkXHVNU/xOdKB6SleorGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+00c4+p8H+AniaCN1J4yUe/zz/Qw9f4WbaIi/DAm5Q=;
 b=MTjRjY31JPJB+pB3Tq3pOvHgV17oucp1RqDMwaOp5u5az5CTTVNRIXnr4DIYrIxs5DnMcD90zGRPfXc/kD2b3AXNohBUi/HNVJ/4DmWMGbNhLXWE25PvNeycRQ4PPmzGXkUEbiMaf0NB1FuoZwChHKeTNw86mEqaSFwIaYc6+mw=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CY5PR10MB6264.namprd10.prod.outlook.com (2603:10b6:930:40::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Wed, 7 Feb
 2024 18:52:29 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7249.038; Wed, 7 Feb 2024
 18:52:28 +0000
Date: Wed, 7 Feb 2024 13:52:26 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org, surenb@google.com, kernel-team@android.com,
        aarcange@redhat.com, peterx@redhat.com, david@redhat.com,
        axelrasmussen@google.com, bgeffon@google.com, willy@infradead.org,
        jannh@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        timmurray@google.com, rppt@kernel.org
Subject: Re: [PATCH v3 3/3] userfaultfd: use per-vma locks in userfaultfd
 operations
Message-ID: <20240207185226.zr3bxyijfynnd5ky@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	surenb@google.com, kernel-team@android.com, aarcange@redhat.com,
	peterx@redhat.com, david@redhat.com, axelrasmussen@google.com,
	bgeffon@google.com, willy@infradead.org, jannh@google.com,
	kaleshsingh@google.com, ngeoffray@google.com, timmurray@google.com,
	rppt@kernel.org
References: <20240206010919.1109005-1-lokeshgidra@google.com>
 <20240206010919.1109005-4-lokeshgidra@google.com>
 <20240206170501.3caqeylaogpaemuc@revolver>
 <CA+EESO7OExRs8Tz2SRD5EZoVf1DocoTZyG4c0Y89xDzZAVViGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CA+EESO7OExRs8Tz2SRD5EZoVf1DocoTZyG4c0Y89xDzZAVViGw@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0149.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::35) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CY5PR10MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ce9bc8b-4add-4afa-2717-08dc280dee99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fWiQIgUR8WfjOdQgym3+T7yHQ+PHVhdUHVU26Gbg7KHbcD2CNElDmJyiVJyIaNds7zEXinKmhbJXcRVgvpzU+9f5pVX35p7F7e3lxVCuOGPTvonyHZ3s2tc1xlYdcZ5khxmiQR+6D2pgzzNPLrQbmcZ17f0gvEbv2ZTaKjcx5wUp6qqypD2OSARorPo/Cnn2OJ7Eo6BQEWvje+o2MnaBzEMZwQU/chR+wD0ppwM7GJcv1sfgtygXUpweWYppTXOUMT4ykZqGZgbuAX7FKlwMzXS8v3ddkGkw6lbi/PyyVF2UxdvN0f3m4nPGVuHNnOo3yl1WKztnKaH2ppg59FlNYqEWjRWfQ9I2Jn7wPozkrOE1GEftJTqmlxmuZU86HquiMVGA/C796pb7zNO3LLytiimpC1rVK+7XFg6sDrEwPRIDUtk7VGXpo6oVBNKrgAmo5y52wNyGbCP8wsxfrtnOaG8If3DwRgSk8yT5VtpqSao7OuudDRkF/PQtpS4NsNvYNvnIRK3iDmJIesNImFyt+V+wmSMbThmJCconT+jdERGo23q0ehRkt6f35VHuG+XI
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(376002)(396003)(136003)(366004)(230273577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(33716001)(41300700001)(478600001)(6486002)(66946007)(6916009)(66556008)(53546011)(6506007)(9686003)(6512007)(66476007)(316002)(8676002)(8936002)(4326008)(38100700002)(26005)(86362001)(1076003)(83380400001)(5660300002)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?clA2ODhiZUsvT2dXcG9KVFJrcVI3YlhMdmJGeVV0S3hWTHk0ODBSeGx6MFRM?=
 =?utf-8?B?dUJVUmV5aVBSZWNKQU1ZN21xbnJIZTZ3TW0zbkhRejFjSlJNdmMrV0hxVSt2?=
 =?utf-8?B?S0RrTlV2ZmRSTjc4U0x0aXhONXFHZ3k1OW9uNUNkWjVicWt3K3o0cEEwalY4?=
 =?utf-8?B?ZUJRTk9WNGNtYmZINTF5WmlJQmpiQ1UrcmVlSEViY2IrblhuZkE0STZRZTFw?=
 =?utf-8?B?cndQczViRWJoZnJ0VVl2WnBjMGxpdHlUYmN1Rk1NMUxSTU9mcFdCVVFOeFNz?=
 =?utf-8?B?aU1jbk1zQzlWMWlQNmozU3B2ck96U0IzeEV0dWFRLzBvQk43dmttWDd3NWVV?=
 =?utf-8?B?ODUwL2xjbG1iQ1czSmh4cFQzdEMzYU1jQUUyMEt5Vm5PSm5OZVdveHU3cjgx?=
 =?utf-8?B?T0R2VzR2UTZrMjgyK3lMN2NWcTV0TEpuazRCWjhXaTh6cjFvWmViYkFDSUdj?=
 =?utf-8?B?Z0dmaW5VeExTcDdNM1JmdzhNa09zL0ZDcjF1K1JIMnVPQkhNQWZpdzVEWGJF?=
 =?utf-8?B?NXBXRys3QlpESFM2V2dWSDVQVnIrdkI5cFpPdk5qUEM2eUQwRmt5c3F4Z2ts?=
 =?utf-8?B?VHQ4SUhTZUtselhqOGdvTU1HT3RGTitDQTcrVVg5VHBqYTRUQ09BQktyZkRE?=
 =?utf-8?B?VnZjZFJBYklZTXVRd1hIVVh2VzQrM2pDS3NUN0FEaXVVWTM3VlN3ZlRQZlI5?=
 =?utf-8?B?MTFJeTJ4MlBkd2Z3dnRaVms2bExDdmlZeXFoZ2hUVzlUVEhZcU5TNkZTWEsy?=
 =?utf-8?B?Q29TalJ0anYwb0J2eWZ6dUMzbE1NbGRmWHZQTTRiU0l6Q0JiM3RjZHNLTUpk?=
 =?utf-8?B?RU16SjVOdyt6cVpHNXlOY21zODBpZlVQQndtMk0rSGVmYTB5M0NOeEI1Wk5R?=
 =?utf-8?B?MysvbDB4aEZaYVZqeTZZT3NmWkVpcDFFa3d1MU5PeGM4dnNmdmRzMlFncXdM?=
 =?utf-8?B?R1hKeU1qNS9RNDR3YS95RVB6RldPbklIRVhsOTE5b0pnV1ZoOGJnUU5ZcVhx?=
 =?utf-8?B?eUxuKzdqNktmaWdPcGo0YzVrN3NwUHBrMVpRRVBpcmYzKzBmT1VOY09EWFhz?=
 =?utf-8?B?SHhvNkdNVGZNd29RTDNpbTlVT3JYdkI1Y3dMblZiS25qQi9KMnpmbkltUVdh?=
 =?utf-8?B?WVhMbEd3ODFpT1BqOWRIdkxDMW51TUV5Z1h3QUxSUGVITVY4UmpiV29PWFBu?=
 =?utf-8?B?cTdTTkNZT3FEbGQ3dFJkWGtTeWNaUFk1YW5CbTZiODFmQWRtdXFYaGpkdi9m?=
 =?utf-8?B?V1pIVFFVcFRlVVFyRmNVZy9scXhRZXdlUjlYSmVXOEpXenprOUxXeWp3OERr?=
 =?utf-8?B?ekZsemtHUlZOb21XRVBHdGYrOVJzSVBVbG5vcVNTRkhLR1ZRTmRBVCtDa3Q1?=
 =?utf-8?B?VExMZ21mU0J4WVlYTGQ0N2tUMVJhOW5JNkJaYVg0ZXVqQkV4MWg5N3N6R0dR?=
 =?utf-8?B?bUU1bFNTT2pmZ1dqWjRibURUaW1nUUMwbHdqQy9LazhUSGhiWTVqMUxFQnQ5?=
 =?utf-8?B?Y2VXa0p1NXhrQTBvZDhYWkttMW9UdkxwWWx5clJuWmdZMGpoVXQxV29UT0c4?=
 =?utf-8?B?S0F3TTZhamxqWEpFT01pNldNTkt3aWlnRjd1cDE5NnUwZkhwVTRsUjNnMUFo?=
 =?utf-8?B?RjlGU0J5K3F3cm5DYU1QWXowVmhmd1B6VlJ2ays3R2xtaEhweGRubUNMNnh4?=
 =?utf-8?B?TVFPV043N2hhbW8rSXMyUlZVZW1Sbk1McEl3Z2hQWmF6dXpmR05ZTGU3MDNp?=
 =?utf-8?B?NkJzZU1qM211OC9BYU0yVHlOL0RKbWMzak8zQ2Q1V2dMTDlOdCtEYlhjdTM2?=
 =?utf-8?B?dFpYUC9lYktOM3hqbVYxdnMvLzVtSHhKREcwM1UyYlRFZU9DYTdaZVBvSncw?=
 =?utf-8?B?a1liRFU5bEhqdEliT2pnelZPcis0bDJVSjRLQitDRnM0b2w5aS9xRUt3eFBK?=
 =?utf-8?B?Q3Z3ZDNkUHM5eGQyQWZ1RnpjblV3TlBTZ3lYK3NaSEVqQUtXKzk2Ulo2TXlU?=
 =?utf-8?B?L21ORTkrTjhtbjg4Q2dsdjZCZHJQYjZrNVIvWjhNYmxUT1dkUFVEZ0hYcmFD?=
 =?utf-8?B?Q251b0pBcmFIOE5uR1RWU0QycUlIWGpwaU1iMXAweWpLVXlsdU5tUEN5RWJE?=
 =?utf-8?Q?NQFIvIXqg34rLHUJuNElCEWW/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1IMOgVGvd8NbU4QjE4ZuJB2q/gTBhokPNlK/OhEwLdOFhN1bNaooWSifS4+BuzjktxYmAJCB/6G/X5oTQJS9m//3sJdIKTsOcbi7B/WjQwYMxFrNcqUqxfZIS+EMcqsehSckLyY8L/bnT+i9F4LwzjkpwJfq8F51xBNuf2hI6bQKJTPeduznsF9F8JxtqE3JoT8nBlZmOGMExqWjYHqVz8uVY4KmPKgP4TO3OE2GtTPCwgw0rjrID3MUXVkzHV9Xm1OhPS3k1u/RL6RCWJlRiJaK7HyOjc1xR6J0Q4UvnM9IyBjvc336J1uh7TgMH/ud/82zr9JEl58MPqCwTk84a8tAICHlDfbd0/TYQa3/T/CujZ5x4ZQ2Zbc48kHWTZZVli3bDMGRg4ipjqQ64M57dAET5YT2axs6SZFt1hKWqBeF4C7B+6u7JKAUmtmXLawqSaAkBbGSpqKURzSbAADSx6tl3VbNiPuI6p7hMfBOToKke8ckoxL7oDl8gmlZwfliLQ6zJu7H6muVo7EoGMnqxwMXYdQChMOlQz/4TA7ubl7Aly94Iwccb0a+2R8MWBdsG+6Ke4k2eQacQG2nkFt56npVOJHmjZRPPLUV0UoSMTk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce9bc8b-4add-4afa-2717-08dc280dee99
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 18:52:28.3829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94e0IOgSh6kbWT42RFlsRT0i/Lh7zfRoBSF9Y6g5+uwcfZGgaA9WUWRdDT9TLTnc+MylumlA4JVVTCR3Bfvabw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6264
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_09,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402070140
X-Proofpoint-ORIG-GUID: X6T3Uq4Zuh4iQZv2o0yq45xlHMHNXggn
X-Proofpoint-GUID: X6T3Uq4Zuh4iQZv2o0yq45xlHMHNXggn

* Lokesh Gidra <lokeshgidra@google.com> [240207 13:48]:
> On Tue, Feb 6, 2024 at 9:05=E2=80=AFAM Liam R. Howlett <Liam.Howlett@orac=
le.com> wrote:
> >
> > * Lokesh Gidra <lokeshgidra@google.com> [240205 20:10]:
> > > All userfaultfd operations, except write-protect, opportunistically u=
se
> > > per-vma locks to lock vmas. On failure, attempt again inside mmap_loc=
k
> > > critical section.
> > >
> > > Write-protect operation requires mmap_lock as it iterates over multip=
le
> > > vmas.
> > >
> > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > ---
> > >  fs/userfaultfd.c              |  13 +-
> > >  include/linux/mm.h            |  16 +++
> > >  include/linux/userfaultfd_k.h |   5 +-
> > >  mm/memory.c                   |  48 +++++++
> > >  mm/userfaultfd.c              | 242 +++++++++++++++++++++-----------=
--
> > >  5 files changed, 222 insertions(+), 102 deletions(-)
> > >
> > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > index c00a021bcce4..60dcfafdc11a 100644
> > > --- a/fs/userfaultfd.c
> > > +++ b/fs/userfaultfd.c
> > > @@ -2005,17 +2005,8 @@ static int userfaultfd_move(struct userfaultfd=
_ctx *ctx,
> > >               return -EINVAL;
> > >
> > >       if (mmget_not_zero(mm)) {
> > > -             mmap_read_lock(mm);
> > > -
> > > -             /* Re-check after taking map_changing_lock */
> > > -             down_read(&ctx->map_changing_lock);
> > > -             if (likely(!atomic_read(&ctx->mmap_changing)))
> > > -                     ret =3D move_pages(ctx, mm, uffdio_move.dst, uf=
fdio_move.src,
> > > -                                      uffdio_move.len, uffdio_move.m=
ode);
> > > -             else
> > > -                     ret =3D -EAGAIN;
> > > -             up_read(&ctx->map_changing_lock);
> > > -             mmap_read_unlock(mm);
> > > +             ret =3D move_pages(ctx, uffdio_move.dst, uffdio_move.sr=
c,
> > > +                              uffdio_move.len, uffdio_move.mode);
> > >               mmput(mm);
> > >       } else {
> > >               return -ESRCH;
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 0d1f98ab0c72..e69dfe2edcce 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -753,6 +753,11 @@ static inline void release_fault_lock(struct vm_=
fault *vmf)
> > >               mmap_read_unlock(vmf->vma->vm_mm);
> > >  }
> > >
> > > +static inline void unlock_vma(struct mm_struct *mm, struct vm_area_s=
truct *vma)
> > > +{
> > > +     vma_end_read(vma);
> > > +}
> > > +
> > >  static inline void assert_fault_locked(struct vm_fault *vmf)
> > >  {
> > >       if (vmf->flags & FAULT_FLAG_VMA_LOCK)
> > > @@ -774,6 +779,9 @@ static inline void vma_assert_write_locked(struct=
 vm_area_struct *vma)
> > >               { mmap_assert_write_locked(vma->vm_mm); }
> > >  static inline void vma_mark_detached(struct vm_area_struct *vma,
> > >                                    bool detached) {}
> > > +static inline void vma_acquire_read_lock(struct vm_area_struct *vma)=
 {
> > > +     mmap_assert_locked(vma->vm_mm);
> > > +}
> > >
> > >  static inline struct vm_area_struct *lock_vma_under_rcu(struct mm_st=
ruct *mm,
> > >               unsigned long address)
> > > @@ -786,6 +794,11 @@ static inline void release_fault_lock(struct vm_=
fault *vmf)
> > >       mmap_read_unlock(vmf->vma->vm_mm);
> > >  }
> > >
> > > +static inline void unlock_vma(struct mm_struct *mm, struct vm_area_s=
truct *vma)
> > > +{
> > > +     mmap_read_unlock(mm);
> > > +}
> > > +
> >
> > Instead of passing two variables and only using one based on
> > configuration of kernel build, why not use vma->vm_mm to
> > mmap_read_unlock() and just pass the vma?
> >
> > It is odd to call unlock_vma() which maps to mmap_read_unlock().  Could
> > we have this abstraction depend on CONFIG_PER_VMA_LOCK in uffd so that
> > reading the code remains clear?  You seem to have pretty much two
> > versions of each function already.  If you do that, then we can leave
> > unlock_vma() undefined if !CONFIG_PER_VMA_LOCK.
> >
> > >  static inline void assert_fault_locked(struct vm_fault *vmf)
> > >  {
> > >       mmap_assert_locked(vmf->vma->vm_mm);
> > > @@ -794,6 +807,9 @@ static inline void assert_fault_locked(struct vm_=
fault *vmf)
> > >  #endif /* CONFIG_PER_VMA_LOCK */
> > >
> > >  extern const struct vm_operations_struct vma_dummy_vm_ops;
> > > +extern struct vm_area_struct *lock_vma(struct mm_struct *mm,
> > > +                                    unsigned long address,
> > > +                                    bool prepare_anon);
> > >
> > >  /*
> > >   * WARNING: vma_init does not initialize vma->vm_lock.
> > > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultf=
d_k.h
> > > index 3210c3552976..05d59f74fc88 100644
> > > --- a/include/linux/userfaultfd_k.h
> > > +++ b/include/linux/userfaultfd_k.h
> > > @@ -138,9 +138,8 @@ extern long uffd_wp_range(struct vm_area_struct *=
vma,
> > >  /* move_pages */
> > >  void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2);
> > >  void double_pt_unlock(spinlock_t *ptl1, spinlock_t *ptl2);
> > > -ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm=
,
> > > -                unsigned long dst_start, unsigned long src_start,
> > > -                unsigned long len, __u64 flags);
> > > +ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_st=
art,
> > > +                unsigned long src_start, unsigned long len, __u64 fl=
ags);
> > >  int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t =
*src_pmd, pmd_t dst_pmdval,
> > >                       struct vm_area_struct *dst_vma,
> > >                       struct vm_area_struct *src_vma,
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index b05fd28dbce1..393ab3b0d6f3 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -5760,8 +5760,56 @@ struct vm_area_struct *lock_vma_under_rcu(stru=
ct mm_struct *mm,
> > >       count_vm_vma_lock_event(VMA_LOCK_ABORT);
> > >       return NULL;
> > >  }
> > > +
> > > +static void vma_acquire_read_lock(struct vm_area_struct *vma)
> > > +{
> > > +     /*
> > > +      * We cannot use vma_start_read() as it may fail due to false l=
ocked
> > > +      * (see comment in vma_start_read()). We can avoid that by dire=
ctly
> > > +      * locking vm_lock under mmap_lock, which guarantees that nobod=
y could
> > > +      * have locked the vma for write (vma_start_write()).
> > > +      */
> > > +     mmap_assert_locked(vma->vm_mm);
> > > +     down_read(&vma->vm_lock->lock);
> > > +}
> > >  #endif /* CONFIG_PER_VMA_LOCK */
> > >
> > > +/*
> > > + * lock_vma() - Lookup and lock VMA corresponding to @address.
> >
> > Missing arguments in the comment
> >
> > > + * @prepare_anon: If true, then prepare the VMA (if anonymous) with =
anon_vma.
> > > + *
> > > + * Should be called without holding mmap_lock. VMA should be unlocke=
d after use
> > > + * with unlock_vma().
> > > + *
> > > + * Return: A locked VMA containing @address, NULL of no VMA is found=
, or
> > > + * -ENOMEM if anon_vma couldn't be allocated.
> > > + */
> > > +struct vm_area_struct *lock_vma(struct mm_struct *mm,
> > > +                             unsigned long address,
> > > +                             bool prepare_anon)
> > > +{
> > > +     struct vm_area_struct *vma;
> > > +
> > > +     vma =3D lock_vma_under_rcu(mm, address);
> > > +
> >
> > Nit: extra new line
> >
> > > +     if (vma)
> > > +             return vma;
> > > +
> > > +     mmap_read_lock(mm);
> > > +     vma =3D vma_lookup(mm, address);
> > > +     if (vma) {
> > > +             if (prepare_anon && vma_is_anonymous(vma) &&
> > > +                 anon_vma_prepare(vma))
> > > +                     vma =3D ERR_PTR(-ENOMEM);
> > > +             else
> > > +                     vma_acquire_read_lock(vma);
> > > +     }
> > > +
> > > +     if (IS_ENABLED(CONFIG_PER_VMA_LOCK) || !vma || PTR_ERR(vma) =3D=
=3D -ENOMEM)
> > > +             mmap_read_unlock(mm);
> > > +     return vma;
> > > +}
> > > +
> >
> > It is also very odd that lock_vma() may, in fact, be locking the mm.  I=
t
> > seems like there is a layer of abstraction missing here, where your cod=
e
> > would either lock the vma or lock the mm - like you had before, but
> > without the confusing semantics of unlocking with a flag.  That is, we
> > know what to do to unlock based on CONFIG_PER_VMA_LOCK, but it isn't
> > always used.
> >
> > Maybe my comments were not clear on what I was thinking on the locking
> > plan.  I was thinking that, in the CONFIG_PER_VMA_LOCK case, you could
> > have a lock_vma() which does the per-vma locking which you can use in
> > your code.  You could call lock_vma() in some uffd helper function that
> > would do what is required (limit checking, etc) and return a locked vma=
.
> >
> > The counterpart of that would be another helper function that would do
> > what was required under the mmap_read lock (limit check, etc).  The
> > unlocking would be entirely config dependant as you have today.
> >
> > Just write the few functions you have twice: once for per-vma lock
> > support, once without it.  Since we now can ensure the per-vma lock is
> > taken in the per-vma lock path (or it failed), then you don't need to
> > mmap_locked boolean you had in the previous version.  You solved the
> > unlock issue already, but it should be abstracted so uffd calls the
> > underlying unlock vs vma_unlock() doing an mmap_read_unlock() - because
> > that's very confusing to see.
> >
> > I'd drop the vma from the function names that lock the mm or the vma as
> > well.
> >
> > Thanks,
> > Liam
>=20
> I got it now. I'll make the changes in the next version.
>=20
> Would it be ok to make lock_vma()/unlock_vma() (in case of
> CONFIG_PER_VMA_LOCK) also be defined in mm/userfaultfd.c? The reason I
> say this is because first there are no other users of these functions.
> And also due to what Jann pointed out about anon_vma.
> lock_vma_under_rcu() (rightly) only checks for private+anonymous case
> and not private+file-backed case. So lock_vma() implementation is
> getting very userfaultfd specific IMO.

Yes, this sounds reasonable.  Looking forward to the next revision.

Thanks,
Liam


