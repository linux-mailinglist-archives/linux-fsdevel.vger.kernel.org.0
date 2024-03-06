Return-Path: <linux-fsdevel+bounces-13744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C70B87358A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 12:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C90A1F26DA5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 11:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654AE7F462;
	Wed,  6 Mar 2024 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ErfUaPA6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Rt/ysmMk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EDD7E794;
	Wed,  6 Mar 2024 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709724324; cv=fail; b=MWUr/N4sRkq3VjCrGpzcjLsIJXa8TorWA/tehcvgaRwA46IRQBjIqGKuh1l6Gdk/q8+4aGhJ7OqAqlSXFBgnXVxsES7WmACbDXgf+7SF9HZP6DIo9wc3M027BR3qPdxUEcsasB60DuTeL0ZT2OMW/WJLpmc+ReZceCWhPGQdEiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709724324; c=relaxed/simple;
	bh=f2ZgYE/oCw24FhyKVkc18OInet9u9lgYxrlQqXnqKac=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BUDPY/WL0bW4poXLKtC1WtcFZaa/owU5Xo5/kXBUtivgGBweruPpdueqGcHY4+N26GPABkhtUVCWiazD6hfRSTiKBnq5Unr6aSKUGLYKEJKtxOFE/+uvdWxPXbasypwZ939m9Eln4TxSgkXnp1u57EynO5WEkR8LiQH3mY9w8ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ErfUaPA6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Rt/ysmMk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426AVuWQ027298;
	Wed, 6 Mar 2024 11:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=izE0vWzajjp1woDHA80vvyteojdCqncRbuGUVf6kkM4=;
 b=ErfUaPA6J93bMRhK3wdIIVuvisgLA7FfURW2An3PY5fd7oUTnlYTr1qnPwWlAaBCMV+G
 gP8BIqDQ7djvdBwo/n41s8tkE5VAP5DakXFgeApEoEh2m7rGHe2lhpa+QLP+9odK2sUX
 TFrZY2Mfh03in7CnNnsEwHOPoZAePg3B3sLVOL3LCx8fGv+rrNTHMz9zusD6Vnn1cRZn
 Q911sI40PgglxdGE5KZDURFJkaRjyP90kasL4/Q3FRekJBYD/sWShMFBFA4cG96/qXTR
 w7IQA5rmQKhVK6cgoM6CsdgqS+d1azSelfqLz1U4L0yYkEBslWlpRcJBbPGyv+AyH8Dj Rw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktw48mfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Mar 2024 11:22:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 426BIWIG027456;
	Wed, 6 Mar 2024 11:22:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj9pj27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Mar 2024 11:22:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTTQ6cy1GX7i15NP3urZMpqOGLmSRNLTvLLX1mfPMR77zuqffkEe/60e5BFEHCthHvBzFCrYSEe2zDEoBi69ZTjPIMNVmMCzN0zUgQlFmHGma108hfddLe028BtKR4uHNGpWmntKtpDDlYHGv+sTWF3OxCGnUsuthjN1SFXuWH6ybYZ2UaeviAPrGgRW+2gpSMGxwqW0I8FpDR++wEQxwoxzDNTpSALB8N7vuX81FAL8YqxpVMjGThBcBlsouStpQHh9U00z+07TwekgQKq3oAn3tAdqXFFNwLnF94Dd6XVuFQ5om9+CWRaOcfhEWUQtp4ZK/ErADiIpBWcFNAzcHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izE0vWzajjp1woDHA80vvyteojdCqncRbuGUVf6kkM4=;
 b=CAtOClxchyLiI02FfOVNAeXfSM2DcPbdCSc3OotCjj6yjWuNYAs6oDJhOLCtC2kiilcXcjh2mIlK44QLuPYjG7WkmZmXPBLSxMn5T3i3I+w6c2ADevx8JsCNNc4Ra7lGQFzvde4uWwcwBA5nRCz/BKBrUbXN7bQYszoYX4gG6G9oncTBOWo9vg360ObVtPlaHR+LzO0UysjSEMAWZ1ltEZSaYAc/1uGfLNfCNO7Tq0+3xv7tng+ZNWHtBZJq+pcBNqV4OTyge62yxCTfLvduPHDxRr5rQB/J62goAL08TH+SF0qqWaiREDiPQvw5ESJurGHBwOYcTzE8HNHKbIWtqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izE0vWzajjp1woDHA80vvyteojdCqncRbuGUVf6kkM4=;
 b=Rt/ysmMkdP+Nx1CYZux+G8USnYjZqxgDRjzzl0G4KFkP+3a+fq+Yj2Mur98lzN8qm3Qo99Tlpz43E8dpa9nZ2qbcFpffkUWTzs2s4cuC0VJM/ukAxk1NvqJVYeMEK/P8fnGxBqHhcgQhkfQvaSfBIyorNpn8SYo2VEalnq8FeZA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4926.namprd10.prod.outlook.com (2603:10b6:5:3ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Wed, 6 Mar
 2024 11:22:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 11:22:48 +0000
Message-ID: <e4bd58d4-723f-4c94-bf46-826bceeb6a8d@oracle.com>
Date: Wed, 6 Mar 2024 11:22:44 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/9] ext4: Add direct-io atomic write support using fsawu
Content-Language: en-US
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Luis Chamberlain
 <mcgrof@kernel.org>, linux-kernel@vger.kernel.org
References: <cover.1709356594.git.ritesh.list@gmail.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <cover.1709356594.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0240.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4926:EE_
X-MS-Office365-Filtering-Correlation-Id: fb2c723d-e90e-493a-8877-08dc3dcfc0eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WYXMhUiyLf+/crKlA4PA10qMO5nZJ8lWP3OQloPnCzW9gAvHj5i5o4Ic74eHxVo4nFXlnPTsq/fIQ2v7OOlRoPJgHqTzlg6HG9Shf+tat6l4y56Iqt1L0lOiU0cY9jPBliIiWYr5k/1ImdNid5pYsO5AT5smMdN+cD2VHokzQb4GAcFB3uzDW8nANoWkW4dBN0MYQcQH/cfRqzQAcAEQWFOLpGHOANiwhI9WnOZXYBGeGJiEbAWTHWLLv9IvrND8Ru8pflv02ReBODINZQxFEOJabPp4N1/yKGjXsgx/AjDxbHcjKZg2caeTmaCulYMpDc4tF/G48K1tZuTt6jYm8nR7Tt7FelOHhqpp2Tm2kpe63KtvAtv4b0BrUZIOkm7W3NRGZWWUnF7AkMJ2oGsNKEzYqMCGq/auM3jqnWxW88jSV5qNyoOlHA+L8//RcNHPsaUq8/5wWCKAiC1xLFkY59OPqufDySywj5F6Bx3MhvFEa7g6TvtN4ny497LVWBjkYbImTQwMBGr75JkWHDW+dvyQEhWf2cxZ/s9vZ85CzFbTbjEGhYcbwyhuyUlHUyQ7vKhnctWlKAPOIHnI0H1mtYG+gnmN+xVMcQdUBoz9l3c=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bTZqekRJcDVRQVQ1VUlFWDIzN3hGUEN3MEdIUTVIMUtibStsTURDMWpjQUpw?=
 =?utf-8?B?UjJQdFRhWFZrWk81dGJPOC9GVmNtWVFMWENScnRVUmVkR0s2eldUVm1KUm91?=
 =?utf-8?B?QU9tbmh4cEhERWV0cHZtelR2RUIyc2NCT0hobitmZEhRWC8rYWRVQmQ3VFRM?=
 =?utf-8?B?SWpGQUlYOVVGN0Vxa0NReWhaZTVtK3pXeldjOHNSV28zeGNIREZtUlV2TFpP?=
 =?utf-8?B?Q2d1N2hzRVgvSmdMTVgrN1JIbzlOMGhFRWFOOUVhclJvWW1hVmU2VVZyeUJD?=
 =?utf-8?B?VWp1WjFZTTdzbjRCT3p4VjYvY2Z2Mk9ZQXdzVUR4VlJzY2dXaUN2aG1xNGlJ?=
 =?utf-8?B?SkRueThiSkVOaFg1WXNpcDZNUGM2TDhwZ2c1amFWY0RhK0xDV0lQZTIwRkpR?=
 =?utf-8?B?SnEvZ0lkeStyRmtIVEtydzd1a0lZTGRuM3FuOHhRd05pZW1nSU0zTnczL2Nv?=
 =?utf-8?B?ZEt4T2xWOS9RVVlEdWQ0eUFSUXprMXZHSS8rZGxCd2NLcVc5d0orcUJEYVpS?=
 =?utf-8?B?ZE50Ylgyc0JRSGY3dHdwVmJyUHZsRDdHU2ljRklkOUY5dDFFWmo2aHgxRUpi?=
 =?utf-8?B?elFVVHpCME1kaldiM3NvMGx2bnUwVG5qb1JxMXpPV0gwTXA3MWVucHd2Tk5w?=
 =?utf-8?B?bksrZXNqN09nQ2pWb1lFM2F5RWlSOEllYTFjZE1JZVkxZlV3TUErOWF0K3NM?=
 =?utf-8?B?cWxqSVlhRG15Rm56YWV1cHpUN2xZVzR0SW9CV3RGQjBSUXNlVzJab2lHdHA2?=
 =?utf-8?B?eTBRM2NoNmY3SXMwM2pZcjlzZmsyZmZpM0ZIbFJYZzJxcXNvWXBHOEczVnZv?=
 =?utf-8?B?UzVYUnc3d0JrWmJvVkZOL01NUCtlbVlVMEd5Rm1GK0dkQWg4SUVPYmRyUlUr?=
 =?utf-8?B?Q1JTS2NGdmJ6azVTcCtpYUlzQnIxR3lzL2t0ZXFlZWJlK3RuYzBZZlhjOUpn?=
 =?utf-8?B?ZkpYc2JIWXNsNnduMWtRZ3RDNnFTakJtOUJ5N2hSWnVHUTNYeGZsSjlVZVh5?=
 =?utf-8?B?cXlITjNTb1VYYXVMYTBwY0F0NTRDSXhKdFpSQTdnc1ZRVkJXR2FvNGtWM1NY?=
 =?utf-8?B?MVNXMC9XRmYxL3hIWFY5Q0wvMnQvTzFxWjdHMzBCUlNTcDI0dzJhVk1lU2l2?=
 =?utf-8?B?UUxCWFhPU0FBVTI1WmRYKzl5d2oyajJ4d1VyV3p6SHcvK1FqMFZjb2NIWTRT?=
 =?utf-8?B?RytpRm9jb3hpeGp3OVNJL0MzaHd0YmtVVmhkeklFcHo2QXV5TExrWnlwR3p3?=
 =?utf-8?B?N01idURJMjRpZCt5Q0EyeStISWZQdzRkVHJMd1llMGxxUjVOWDdWMXo2NU9u?=
 =?utf-8?B?NGpoWmE5OWpUVmdJT21FL3JqV28zWS9qNjhPNDZMWC9RQlF6VndjY0ttRmlD?=
 =?utf-8?B?eittQ2wvNHlVaXR0dTFjdU1mcU4rc0laTVhCdmJwR3BIOFhmbEdvWEk4dU1v?=
 =?utf-8?B?a2JPQ01HcUpXaGRyWS9SZG1Ycm5IdzV5ZWUzM3V3Z0pYaVhtbVZxaGVFbjZS?=
 =?utf-8?B?MFJ3cmxEU2E2bkVKUzZVQ05ZZFI0Sy9xTTg1Y1FjQ3oxbjh3enZmdGk2VUxk?=
 =?utf-8?B?dUxlN3AxYVVRdkQwMmc2eE1uQlkzL1R5OUlwVDZYVC8yRm0zNHFEck1WcWlY?=
 =?utf-8?B?SzZuSTJXWkFtL0k1eEgzRnNzdE1ydkhxNndJWTRpcktRLzVMSmFGWVNueGZH?=
 =?utf-8?B?SCtqRWd1Vkt3cElrTTI0OUk1ZFlxd0FYU3Bxc0kwNHh5bWsrYWNibTJLd2Y3?=
 =?utf-8?B?SXRCa0p3c2dxa003YnVmS2pUZzh2S1ZSUk9ScHp4YjJxNk1RdVptODZPOFVt?=
 =?utf-8?B?d2F3R1htdHRiajM1am5Uanp5S0o3VGJDUnRBN3kwMjBLOWlqd09NZFgxZnYr?=
 =?utf-8?B?Zm1sYTRPQXRyK2ZUeUlFYVZ5Ym43TVdiekR6Q3VabWdCUlMyQ1g2QUlrN3hC?=
 =?utf-8?B?QllqNW53bmVZaVdES3JwL1lBSjFOUm1zckJMaEdYN0xFbi9NNThoWEZrdWoz?=
 =?utf-8?B?emZRTHJQc2U1SXc3UmxhbFBuc09tV1prZkREa1hoM1JGbmxPT2ZpbXhtNWRZ?=
 =?utf-8?B?eUw1NUIrWjFPTFgwR3BNeGhEMjVMdW5URnV5UHVONUJoVEVaTExOMTJma3lG?=
 =?utf-8?B?NnVuYTFpRnZ5Qks0RzdTTlBja3UxWVlsSlBrdFdJNFhlK2NIT1VsL3ZzaDZP?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	McdgODiBhkH+Sk2j1jVXAnpIP5MJFNdAP+VsJjoZvjSK575pSmYKzs8bh8g5FDqOyTNxCi+QMcvRIAWz8/TaaRo53r4Y6eqxKYt6yJSLUavaZw0aH8zW+YmIWket4rtFM2udb74U6w/VI9cnC4b1yacjdFmB9GPGraSvkwi1xs6/QmslpCUV6Gf61Q8hSuTIzruyA6iIxU82aXeVHvNERnzknKIH4Xqz63WwRbGSK8Wrv5+B8EJmg2TvS52Dd9I1QqzhmnWqQdgB01vfW+7ALATpr8BaugFTiyTxoH8cA/ihWpauuD7wiBr7cVVk6Mw0egi6Aws7+CHLekFd+uZJKadeY3L0z0bz+IhvM8W1ml/51FuDL9mqKubrl6E3cVtPxq4ZoXSri0oWZXP8VybRmuArvY1kce/gVx25Ps0INuxTPlKrzEONHhSU3lphpJ+7UqeS/xXp///SOWbUspl1RKKAlYu2VJkAD62hEtapZrV5iXMYiTqjI5S09mywiLVFt1i3MCxjUNS4IlA7oPQIPxA3O6vKyU6AohsxQMuJf/HOTWRHOSSznQruGW5BVsG18BiVsHAIzIlGDVaEQVU+xQyNwAq9c0AvcCc6EOYklN8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2c723d-e90e-493a-8877-08dc3dcfc0eb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 11:22:48.5598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ie9KFKKjC8R+XsyRRsanJA+34OcxKZ1uH+6MpoJyuC1NItUFJFyqoBTYl1TAmWAs19Q9fP+gb7dZz2ZVI6TEgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4926
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_06,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060090
X-Proofpoint-ORIG-GUID: SSXmau51TvkqVo1G54dUKDPOoVYzmS_x
X-Proofpoint-GUID: SSXmau51TvkqVo1G54dUKDPOoVYzmS_x

On 02/03/2024 07:41, Ritesh Harjani (IBM) wrote:
> Hello all,
> 
> This RFC series adds support for atomic writes to ext4 direct-io using
> filesystem atomic write unit. It's built on top of John's "block atomic
> write v5" series which adds RWF_ATOMIC flag interface to pwritev2() and enables
> atomic write support in underlying device driver and block layer.
> 
> This series uses the same RWF_ATOMIC interface for adding atomic write support
> to ext4's direct-io path. One can utilize it by 2 of the methods explained below.
> ((1)mkfs.ext4 -b <BS>, (2) with bigalloc).
> 
> Filesystem atomic write unit (fsawu):
> ============================================
> Atomic writes within ext4 can be supported using below 3 methods -
> 1. On a large pagesize system (e.g. Power with 64k pagesize or aarch64 with 64k pagesize),
>     we can mkfs using different blocksizes. e.g. mkfs.ext4 -b <4k/8k/16k/32k/64k).
>     Now if the underlying HW device supports atomic writes, than a corresponding
>     blocksize can be chosen as a filesystem atomic write unit (fsawu) which
>     should be within the underlying hw defined [awu_min, awu_max] range.
>     For such filesystem, fsawu_[min|max] both are equal to blocksize (e.g. 16k)
> 
>     On a smaller pagesize system this can be utilized when support for LBS is
>     complete (on ext4).
> 
> 2. EXT4 already supports a feature called bigalloc. In that ext4 can handle
>     allocation in cluster size units. So for e.g. we can create a filesystem with
>     4k blocksize but with 64k clustersize. Such a configuration can also be used
>     to support atomic writes if the underlying hw device supports it.
>     In such case the fsawu_min will most likely be the filesystem blocksize and
>     fsawu_max will mostly likely be the cluster size.
> 
>     So a user can do an atomic write of any size between [fsawu_min, fsawu_max]
>     range as long as it satisfies other constraints being laid out by HW device
>     (or by software stack) to support atomic writes.
>     e.g. len should be a power of 2, pos % len should be naturally
>     aligned and [start | end] (phys offsets) should not straddle over
>     an atomic write boundary.

JFYI, I gave this a quick try, and it seems to work ok. Naturally it 
suffers from the same issue discussed at 
https://lore.kernel.org/linux-fsdevel/434c570e-39b2-4f1c-9b49-ac5241d310ca@oracle.com/ 
with regards to writing to partially written extents, which I have tried 
to address properly in my v2 for that same series.

Thanks,
John

