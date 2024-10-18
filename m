Return-Path: <linux-fsdevel+bounces-32367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 757EA9A4535
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 19:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044D61F2523B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 17:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9108B206962;
	Fri, 18 Oct 2024 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IM/RW8Cy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zlUg1FVb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67942040AE;
	Fri, 18 Oct 2024 17:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273443; cv=fail; b=PyBrwsnvMmvhuRu6tQU49OoWb55HDlfZq3mkX8XmjwTkb0N9F1MYaKeb/h0jj4lfNAZMXyBpWm6p34KJ9gpx3DBf7BxMGsahoEroan7L0qWE5ojruAYsokLhzZcDRna8JTrEzD0LE79PdGD6ie0WgjbnOHbQ6CSYIQG/TBlVuGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273443; c=relaxed/simple;
	bh=SLkobiP9kQVhJv9vsA4uk/1DOG9RrTm98v4pVkKm+j0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HtvU3EuoErRFIURpQHUnWB5zhk5lYJ3vEux2bFd+zSGt7XmRJKAH0NwIR+ISvu9A+VKUK2nVb9Yf65x5GYhDqSLd0J5oiTq67d0BJ2/mepGNltnzlYtO5NyDuYSlQKHbD+TSX6cYHvNCh6ZtEzziVXrZRFcWm3ySbTrja0EmXPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IM/RW8Cy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zlUg1FVb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IEBb0F022665;
	Fri, 18 Oct 2024 17:43:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SLkobiP9kQVhJv9vsA4uk/1DOG9RrTm98v4pVkKm+j0=; b=
	IM/RW8CygsvXwU44SBr3j/3xY91ks5DfiHJyn5bFoete+te9bz1tqldgHH9D8ims
	SZH4mJ/Dd1J5rs4U6ftbyMjCDz5J1i4b1mc1DYrviINcg/+PhkWu+BoBQUNJGQrs
	6oOMZWoUcQd3m4+VCScsPuKwz1I6xk8WLHQqWWUUa/nBvZD6Lg+swBesuOtlwzZf
	IFeSQ57mFbrCWJoLEPiyKmdBzZvSAhx3bBeUQmvOkrX0BCeO8MBK8sFP5sNrrHHm
	bl41VY8EvtwMSWoKWFZAphXclDe3IP46DtJBPLc25p3CQeD60Ye+LJ2gIqo8CRYl
	34UyiJcIGsbSbpkVGnm4KA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5csujx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 17:43:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IG6J3e011091;
	Fri, 18 Oct 2024 17:43:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjj8cke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 17:43:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmmBVwr8AgpbtYRCNAZ/eRSOHNpyzig4YoixzOlfjBHR3hICKcEJVDCH720fUMrHV1epPhR4w/8G6QhoGuyYwMJQ/OQmpi11hwoqZrnLVt90gcfKWooiGDGVPE+8sL/hGB2fzD0sYhGIwivOOe8EMT0nFtG8iPc/36OCXNq97udIqpxO4UsqRUakdqXnhchYT3CKjgSiLmf/8XBcj3FVCNeZ6Kd3AYB9RvYgy9HV2+gIcqU2g71q+KPQOQrEMjamkOvukSQgGq8x801ZHe5d7bLb3Ih800nuNPLvqA8jgET75n7OZcqpqU8jRcTmxLbiMkaiot+ot6HXuU7wlTWXoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLkobiP9kQVhJv9vsA4uk/1DOG9RrTm98v4pVkKm+j0=;
 b=fFzhYFS9R89RTd8L3zO8H9opk1p3o+tL7oIcu2E4EURR+NS254yMqnw4a3tIbpWsrMsOt3iomsiatn/POlqx82ziMGhAUkvTWKD7xZ8jcXmmILjlxNTryTFY8lRKmcxh0PBkNogxe+SA8U56PZ6zzQZQll22pkta/vhGTBKrYyxPu8g059YatCxYPM1Fvj77ieru8taRgDdMQCsLb2dpFa7/VkNiJsPUsUZvShNW/SuKIilopAP26MjwnCcgytxPo5ctstpY1HEraxhtVS1/EGIY7NHILAu/b9nrk0ZfmIIJ6VXfeQQMv4jvxYI/NyGoWBE7RYxVddNP//DkfzHx+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLkobiP9kQVhJv9vsA4uk/1DOG9RrTm98v4pVkKm+j0=;
 b=zlUg1FVbS0MUODFtu0qOJTz800czQ1Jx1Hy3hHu4G8Kyg4eSXs7mZKC2sQaj1e4pl1FR+TPpfd2wvd908umq62C+eTTwoC+bl+u+KdDZatTqn+Rm2DubUtmcYJHhlueXhGIUYfLVh0nbMrNH6gPGHdxujrGoMINeOCru/cdmajI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6625.namprd10.prod.outlook.com (2603:10b6:510:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Fri, 18 Oct
 2024 17:43:45 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 17:43:45 +0000
Message-ID: <2eb179a9-9caa-4acd-ae05-41da475cca03@oracle.com>
Date: Fri, 18 Oct 2024 18:43:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/8] block atomic writes for xfs
To: Jens Axboe <axboe@kernel.dk>, cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        brauner@kernel.org, djwong@kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, dchinner@redhat.com, hch@lst.de
References: <20241016100325.3534494-1-john.g.garry@oracle.com>
 <8107c05d-1222-4e47-bbcd-eba64e085669@oracle.com>
 <9e42e6a2-f6ad-4fb5-af9b-72d0c7f6889b@kernel.dk>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <9e42e6a2-f6ad-4fb5-af9b-72d0c7f6889b@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 4294b39a-529a-41a6-4791-08dcef9c69ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3I0Tk1HT3M2V3dwbmJUVmpEMURMNDBOdEk0SFJnb0xuVHlMRC93c2txMWxp?=
 =?utf-8?B?blJHdjlncnlnQXNCZzBiQmttVm9HclBraERUMkpxVTMySmVQalJQUVltS2JL?=
 =?utf-8?B?ZU5GTHZpL25ybHJ3YXFwLzlXcVd5UlloWVBGL3p6M2U3NlJUSmJmMTBWUzJR?=
 =?utf-8?B?TXFkSThqNUlTc0pWWndCLytNd0ZnQzZabGJVUldvVDlRZzU4YmNzaExlTTJz?=
 =?utf-8?B?V3dxKzFicTRVdWgvZE5xL0lpVWFLVjdVbmY2VkFmQmt2Y0Jncm9xVmladHhp?=
 =?utf-8?B?RVVxMTZaUTRXcWtaYWNRTEtoc0dZVDdCTVcvZXZQNnJzZ2piYVJFQTJHWXBY?=
 =?utf-8?B?WUEvbFJ0cGFlcVJxL24rVHl4NTg2TXJ4cm9nNFFhdTJaVG8rT2ZZQVFjTlho?=
 =?utf-8?B?Ujgwbi81ZEZ2WHRTZmtyZEhWZ1FwV3crcFpYbHoza2Q1NG9aUWcrTjdGaCty?=
 =?utf-8?B?MGNTckE2RitZK1pIbDdScFNxd3k4YXk1eW9RNlFWUTB1dWMxOFZOb3JFeXcv?=
 =?utf-8?B?dnR3OE45c0NnYWdVSUl1QVRIRkRtRENBWkVEL0RreHZJT3kwM0NwaFk5aE1o?=
 =?utf-8?B?TEYyZEp0bldvUzRFYXpQeFFDMTQ0Y1IzdjJrMkxMbUhJcENIVW56a2Vtd1lG?=
 =?utf-8?B?cC9RRElxd0wzN2lCUjJSMzZEdjVPa2pKRCtybHJ1UkRybHZoZjVvb0ZWVDdp?=
 =?utf-8?B?M0c0dDFHNVFkS1QvVXNOR2FWNlV6TUdidnV4c2JHdUpKMVRRYWNPVFB1TWp0?=
 =?utf-8?B?MnpNcHA2YkFvZ2R4U2k0VjR6c3hHYzNFMkJRMmNtZTN2NlFVbkliZVF0bEVq?=
 =?utf-8?B?Ym1JVDMwakZhV055SlJzUDFlR1VncllTWUNoWWdOMmc2alhLQkdsZnMrekln?=
 =?utf-8?B?ZnRFRWk0Q3BNNVlzNTdlWXMxbzBPL1hqMUFYeTVhWVNZSmhsckh6WGRKNTN0?=
 =?utf-8?B?SUZnV1lOMTdKVUp6Q2Y2Y1loRkRvaHFNNmVFdnZsdWMvYVJ3dTB3TDJ3YVhh?=
 =?utf-8?B?dDdwK1ZPb3gyWHRFUzJSL1NLMWNGOWlTZ0VyZEI5bUNITHprb2w5cVpTUzF5?=
 =?utf-8?B?akFRc0VraGxDRzdVZ0g0TnMrN1REVUFIUXMwTzBBWUNFYVVTK1ZaWVVDQXo2?=
 =?utf-8?B?cDRLcVR1N2E4QWxOdEV3S3FZeXNzb0Q2dUxkTUdtaGo2V0J3NDdJSTg4c0s2?=
 =?utf-8?B?azdWenA3eG1zblBFRXJqNWRTYnJWOFFMVmsyaTVOR05TdkQrRXoxc3I5SEMv?=
 =?utf-8?B?eFBBYWNTdXpOcXlaRGhEUXBoNSt0d3FxcTZ6N29GOHNKSkpnbWYrbnMyNzRY?=
 =?utf-8?B?QzdTWkhFRXdCZklFZms0TnNBZ0tTN1ZNT2ZDTDREd1NrNTNWWFZHMnF0b0VI?=
 =?utf-8?B?VExicmpMeHM5YmI5a1NsUWpRZnl2bnorV0UwSUx0MWlqcmpUNFpaZmIzRG1Y?=
 =?utf-8?B?YnAvSTBzT3N1THI3cVZBZVRGS2NrTWlqL1VLUi9PVDNySW1lZ3NkMlZxQkQx?=
 =?utf-8?B?RktiL0tOcmxRQ3YyeHE2NTNzcHM4NWlmSnVYZmJqd2xLZFhNbzZGOVI0QUdB?=
 =?utf-8?B?aG8yN2JmSXRhOWdlaVNFc3Y5TVh5TzEramxQbUl3MnR4a1c1K2hsK0srNWFh?=
 =?utf-8?B?MkMxdnk2QUtuazdhSmNvYXI1MnBhZEE4SUs2aFFiajVBa2doZFFnRGFqZFhs?=
 =?utf-8?B?ZHhkdm5DamVtMWJHNlVlZFhhV1hPbWtRb1VwblhyMlYwU01wWXZEWlBYSm1H?=
 =?utf-8?Q?LJYeW8Z+VgOME/kNhk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YldieVRwT1pOdndOVUxMRFJqdUFDZEhxZnZ6VkhOWU1FKzRpZ3V6VzF5dHRn?=
 =?utf-8?B?aWFyeXh4b3BwVWR3MzVzaDJsbEVWRnd3bGNQaGhiY1lOQjNrRzA5cmZpRG5a?=
 =?utf-8?B?QXhWQUx3QW0zVmloR2VJNEg2S244QTUyQmdGRHVrc28wNWZLd0lmUENOb2ZT?=
 =?utf-8?B?K3VFVWhUejJZd0NYdFRZdDRSdzhTQ0xrd1RYRHd0Q0FEcHpYTHZoR2lxbUg0?=
 =?utf-8?B?YWZFOUhDWlJZQ2tBcWozODlKalVyVWYxdUsxR05iSVYwMUtkTkxRc2o3QndK?=
 =?utf-8?B?ZU1oNkoxLzBicnVTRGpkRHoxc2VURFN2OFA3djBmaWMxZjBvWXFnRUYxRXFj?=
 =?utf-8?B?WVpYdGtZL1A1NnQvQUtCNFJNR0JidzZBU2tRZDc1N2hwQXpVcXdCd2ZtNTYz?=
 =?utf-8?B?VzVVMkZNdlBGOGw2dnlkdlZUSDlIUkg5eXY3QTBlNjk0WTB6UzZxeHhwLzNR?=
 =?utf-8?B?Yng4Z0R6SUtkaVNNaVRnUmc1bitFUkNUQTYvSjRyMDc2TFZDYXhhNC9sRHc3?=
 =?utf-8?B?d0t0SjNGZVJHKzlXdU4vaVZKcktoTmN2ejhEVGdtNk9xODFkQUk1bzhISFJn?=
 =?utf-8?B?cnVmTzdUOXRnaU9IVkV1eUlVd04zTlZTeDViOXVTb3o4UHdyVEhyVjY0MEFh?=
 =?utf-8?B?Q0ZRNUVUREFjQUZsTTJiMnBLd2RqV1l0NmRSeFFmOG8xbGVTbWs0RnJmWFZi?=
 =?utf-8?B?Z1QxZFNSSWtxTG5vNVFra2NpTktxeWpwaXFJazllZDRsQnJ3c0tHeis3ZWox?=
 =?utf-8?B?RWJRdDFFa2pXR0pITG1kOXd3Ny9HYS9nNU5HdlBFL1h2THVaNTVFTFVWUGk5?=
 =?utf-8?B?SndiYlZXVTlaUDJ6RjNGSTU1NlhFS3ZUVWViWE5tRkVKQW1LT1MwVE12ZGZY?=
 =?utf-8?B?NVQ3TWUvTXMwbGNrS2VZd0orY0FZdDVQMngzclJDN2lSUzJRNUtFdDNWdm00?=
 =?utf-8?B?bEJtd3lBbFZXb3lPMDRCL1FTY25GZTdGS3V5M0hOa3dmWjVaeTk2UTdxYmpN?=
 =?utf-8?B?ZHBmTEVFbFBZTERwQS9BMDhKZlFMQzRmN1p4S01sNUxoanJnTGl1TFI0WnpY?=
 =?utf-8?B?N1JWbmFndTF1VmJTY0dYYUxxK2x6dkkxSzdiUzZkWkM5bkExTHhmeERUL1NN?=
 =?utf-8?B?VXFrWjUybGI4bGs4L1Bmbk12MzR5Q3BsQXp1ZXI1MFpwS2VCaEVNZFRKZUgw?=
 =?utf-8?B?cHFpQzBpV01mZHAyZXB0U3lFaTFwOFJITmlMT3VFNHJ3bVl4QldOaStGaXBF?=
 =?utf-8?B?b09xYkkyMlU0V0J6UlpuWkU5ZDRFZ0Yyc0RObnNVaGZwYmc1T3JMQWRoTm1w?=
 =?utf-8?B?VGtvVWtJL3lMT0R4dUdFekd2SGsvSDZUUXM2SVNON1RzRTVUelZnM1M0TTVi?=
 =?utf-8?B?Sjd1dXM1eUZoSkFnZEpBeExvSUpOOTB0MkRjczJnOGd2QUEzT2JRbFJYaG92?=
 =?utf-8?B?VnpFam5TenlPRHZUTnhibitvV1VqRkRWQm0xbWVuWkZVMmxZY0FuRGNvNmtJ?=
 =?utf-8?B?a3AxaVV2WmExZmJBSjNhUEpnWk9KdFFrbjA2YzlhSVNLZVRXdmNYV25XOFVQ?=
 =?utf-8?B?VXJ2eEwvbmwxMjRqK09DZktjMVlxL040UFVLT0t5SHE3dHc5MDh0TDlUWDRN?=
 =?utf-8?B?WWpick9OZkl4YzcrN1IvZWRKYTRZcFFlOENYWXVsZUo2NlZOenZVTjJBQTdZ?=
 =?utf-8?B?S2I2cEtzM2dWV01VNXd1a3h3cU5uWnU5YXlpWUJZcEtzVkVyN2VyVHNCZGli?=
 =?utf-8?B?dW1sWWF0VDhLb0hmekVteHUzWVlOV3BGbC9zbDJDbks1Ly83Q3E2bXFKQWlI?=
 =?utf-8?B?dXF0SjE5ZVl1cFhwWmIyNVhDTmtZR1I4dytNOXI2djJpSTRjK2R1UERhTnpt?=
 =?utf-8?B?bWZUYlZpRm5yc3NXMUNibWRrS3pkRVBRbXk0QmFRbWxHRVpQT1ZHdkdCc0ZW?=
 =?utf-8?B?alg3SnIzRXZGandteVVvM3E3YUFYNTZaVGFSOGdOQUljbWd2aGlGSEhhUkNY?=
 =?utf-8?B?M1l6anBJTENJRFlKRjJRSUJkN3JvUzlEaXRDQndnL1Yrek1xOU1vTUYrRGpT?=
 =?utf-8?B?dmVGdjdmM3NrSjVJNlNYM0gyRDJOUGI1eXBGbHBxMVZtT2ZrRHNQWTNzL2xk?=
 =?utf-8?Q?v7cRYT/RScW39qL3kw2FJ8NuL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	laxgE5/j4b62jGgHW3aR6at8Lp3pw0RgMvcXItwuANP1Al/9OI2X5RIzRTarz+4yV52c2PQU8GkPqSAEFwuJPmTug8+qWwAMPLtTNqxu7HIMsrCg38o0YBFfyg+rAO0b0ZqPW0oCKl3OEACjAcpVy0HgsNsAziecxFWwQIjrx7h85CPB4L5//drX9IFSmLZDXzPPPZMoD5Op9aCZpVvA6IyambiIHsVsc60csZJxHLbjXXTyQQuYf44x0rfyW7PD8aX/6rx7uobyPLbenmP2NLohTTLiT3PS6J9JJ2mKAZFLvY3VBLSdFmKXj4/BKMfJfrY27FJ6pnl/qSItsYraaJXNbo0MHYS57Ju1gLffAD4NKAx9BAc+vxKXpewy9zY1pyiGEHeQX/nLHEZOPOKGyNawYRI9gNrTgHBUhq4+a5/VEfHnfcNvcl7WcMt7PJoBjd0HJ8bggePLdPmefT7QpRgroGVVc0dfTFVqGEo8X7fOjaXDh3+Rkz6Mdy9EHLnNCbGnI6RtSelOZ1CRC7yVbHWoVbiuVGUqwL0eqxIGmEuL+ZH7wtR6BQdcAQqnDz5pmkq4c7Zd/UfF1YMX3uJVivtbb6lareuiAKmpGViYEa0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4294b39a-529a-41a6-4791-08dcef9c69ea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 17:43:45.3269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PC0yz8gAHcpymWy8cFIp8T/QBP48lVz7Q4P3V5JlEt6U+RHjozE8wgRy8dIdEem1klOz5JJiMLV3ua0eAToJrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6625
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_13,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410180113
X-Proofpoint-ORIG-GUID: dyzFGbTcbHU_jseySKLs2KcrTc7Acw2p
X-Proofpoint-GUID: dyzFGbTcbHU_jseySKLs2KcrTc7Acw2p

On 18/10/2024 14:41, Jens Axboe wrote:
>> There are block changes in this series. I was going to ask Carlos to
>> queue this work via the XFS tree, so can you let me know whether you
>> have any issue with those (block) changes. There is a fix included,
>> which I can manually backport to stable (if not autoselected).
>>
>> Note that I still plan on sending a v10 for this series, to fix a
>> small documentation issue which Darrick noticed.
> To avoid conflicts, let's do a separate branch that we can both pull in.
> I'll take a closer look and set that up once you post v10.


ok, I'll send v10 soon.

Thanks,
John

