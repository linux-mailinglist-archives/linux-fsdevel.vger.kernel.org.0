Return-Path: <linux-fsdevel+bounces-47059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E77DA98346
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 10:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD6E442C3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 08:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3BE277030;
	Wed, 23 Apr 2025 08:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gv5W4Ir6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RrSzLuHT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3405268FEB;
	Wed, 23 Apr 2025 08:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396321; cv=fail; b=hek3kp8W0qJZCnoGHA77jsSAMaKOXNzDiIJRMY8yp2qwX9wJFd8Qkg0cpfA60uHHdu93yTchuaWDOT4qPIe5va6LTkZjmojBlOtZkGNeESpiUUmCXfrkRnGSA+eLKqxeCcs/Bl7MrqmZniqAby20CynLLaZa04GRKsRgjlOdfCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396321; c=relaxed/simple;
	bh=v9F+vwDnQ9W8UkFZEAs9RyWHifWD8bi6dZSl+FK1wQA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cMwPYhSl7oKoTFd2HiU6SHmhNxvImTCcaFH7oATMsX/0Sp9/jPduPIzzF3hnO4waSh0r9n0lq7W5O1GTNsYv65KltFUAGMMTU8Us4wIiH34OnHhHuX2qacAWQCSQZjCxQMBMgOzRprddT2CTXbGpUYehUfwAxh+GP7DUkm7UBUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gv5W4Ir6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RrSzLuHT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N0tmb2018421;
	Wed, 23 Apr 2025 08:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XAbMWS6s5VMGskbzVzvMTvvWS6UTbOz9MiUA39pky1o=; b=
	gv5W4Ir6BUNmxYmsWOL7MEVg7y+1ce12mLkTUwG8Mk0JrogqT56VUNlZID0Q3HnE
	heO5vhgiqbdoYox/Vk5kusvkLuXzqV5ll4v203fT6FaNYc8aRrQAZ8Chb1XsIWuL
	W9CYifcuKeB1WM6F10lmD1rQuUMM/UqeuhVMxd5IGM53xzdo76IyytFvGc6hfytx
	5NHQy99x2AlVOcacSX/KWbn8hWfKjLZ4lAWs1Y8qYG2JMtNhP2XAmm1Ys+TzkZcN
	NdBr3Na47RRDEnKUWyRTA/ssVxWzdQfKp3E3q3BRjc8PHq/tAYk/orLI9emRL1rz
	n7m1LOe9J63ApnCnCuKDxA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jhe0q6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 08:18:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53N7nG0Q017326;
	Wed, 23 Apr 2025 08:18:25 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jveryc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 08:18:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9boLW36lUIUjS4YTT57A5gsIvYTLz+oBIcrETOFEHLlTILdTzr/IkEGrjiHNlw6P/qs//VTEBtVgch2PTI94vCw3O5TYxQoAZywHSLjr2/9FVfRaw5EeO2Gbzw5DIFosNLaJ3EYpIYuzKotweVCayg7kDAxcoytOj2MKEiNyDhO1kvJEHW62/zKyf4F3OMoTYqVoJc6ZHroxxUD1jYRP0T9Y0xKF1mKFBivsMCWxYpsSCVhK/uDD731CXRvpeEHuUu2irzvpYyia8y5AsiHaR1sFfWa3xaYjF8P/gYD1fwnUX4HQFwV603gbSo412y92jTghNkIgyB/HjG1YVrpRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAbMWS6s5VMGskbzVzvMTvvWS6UTbOz9MiUA39pky1o=;
 b=q1OtX33iByuTg9JhTGEXT4TUVQ9VPgvgTghQYkMlaq3KirLQerpo14ThaEiJrsFuLnZESopbMtZg2S8EkrjueumJsF/MaTdmf1BSc6j8eBtwkxh8E2kHyMMwuaCPggO5EVHVKb4s6kkJ1Ad+OsAg724EiH0OTJFscamFCDHP1AKXjCM+2hHUfP4gkukT7svYNvYXFW+PUckgIWJ0MpP6Qup8FDqCiTy360M9k6zYWkdkgyQsiRrB9lkD+zeKrUf5Yq8xDMmrBejj9YWZIMvcMVjYgrozYqhGUsP39fE5NxvcDEFvo3PssNsonDOS9+LJMVjFQVgtnignK15K81JRNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAbMWS6s5VMGskbzVzvMTvvWS6UTbOz9MiUA39pky1o=;
 b=RrSzLuHT8vORzSlfJuK9a7k5bppPgQ0WS6jCob+jHnus0+gsUTFwjkyYGf9cWXEDtZJo1ftY0armbgurm6o4iLKowBxGhPr+UkMyKnhl8jrj1Or7R9PFdm2Dd3Jumv7et1xBLvJ2dPeXoxgkr5Iv34INYOago+FlGj/aAEIpsiM=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by CH2PR10MB4375.namprd10.prod.outlook.com (2603:10b6:610:7d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Wed, 23 Apr
 2025 08:18:22 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%7]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 08:18:22 +0000
Message-ID: <5d7f2c68-bef7-45bd-9572-97ed8e182fc6@oracle.com>
Date: Wed, 23 Apr 2025 09:18:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/15] xfs: add large atomic writes checks in
 xfs_direct_write_iomap_begin()
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org, linux-fsdevel@vger.kernel.org,
        dchinner@redhat.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
        catherine.hoang@oracle.com, linux-api@vger.kernel.org
References: <20250422122739.2230121-1-john.g.garry@oracle.com>
 <20250422122739.2230121-11-john.g.garry@oracle.com>
 <20250423081614.GC28307@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250423081614.GC28307@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0163.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::6) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|CH2PR10MB4375:EE_
X-MS-Office365-Filtering-Correlation-Id: af3bb631-984b-43a4-1f3d-08dd823f699a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTB0dVlkRm42aW0yQ3ltYlVuQUtmQldvZHJYZUdpNzB5M2NsK0piWTg2dEpC?=
 =?utf-8?B?Mjg0U2pvRnpiS2ZTMnREY0dvODVPQy8rRVM1Vm9ybzJhSkE2cGNUYUxjVERT?=
 =?utf-8?B?WVJra2QvU0REbWZHKzRGU3c5c2VjOEtGVTd6aDJtWURuaDhlZXBjSmdLKzhq?=
 =?utf-8?B?eUtPd2JQeHEzVXc2T0ZXVXRIUWlteVZpUmEwZHo1SU5PNlBQZmVnaEtaNUpq?=
 =?utf-8?B?eFowWmVOdjBUNHRhSW90NHlsVDY0Qm5OTTZXMFVZQ2lnK1ExNXVlSDBDZzNj?=
 =?utf-8?B?ZERNLzc1dk1pQjNaQ1lnSUg5a2M1TzRIRDRLU09XMXZXM1VHNHkxWFoxMVk4?=
 =?utf-8?B?Q2F4TlMwSHRvZFZKYlFiNzQzbUV3Wm5NY2dzcEVMTUhzbVpNQlV2SFVHQmUy?=
 =?utf-8?B?U2RlOHk5STdzSGFHdlMwczdWTHpaM3RDcEZlVUZDYTNyNzR5Q3ZkSzZvcnRn?=
 =?utf-8?B?Y01lTjdlQUcyN2x6MklrYU1Pa0RDSmpidTIxNElPZFgxTjhZUDhNaXFHSDUv?=
 =?utf-8?B?QXU3ZjhDQWwzMnlLY09kQ3c2VFBqWVRrV1U0d3c1RFZXWWp6cmpiOTN5bTNa?=
 =?utf-8?B?Mk56YUZDZDBnc1ZoU2dnVEJucjFQK29tckpJVUNMTitDclV4ZUp0VktxaWZq?=
 =?utf-8?B?b3Z0dXplYmZtaDhJc0gvNUJWZ2tLTndOTStBS3lZdUJkcVpZbHl6RmpoTnh6?=
 =?utf-8?B?NDZlcmtpVnllanorZVhBM3lXSVV4THFKeThsS1ExMVd4QUR1N0hMSDhGVVRT?=
 =?utf-8?B?SStQR0Z0clNXcWVlakVMOEtFbEdkd1ZCbUJUNEZ2cS9ZNFZKUW9yY3p3TUw4?=
 =?utf-8?B?M2FKNWdxOStjUUZscm1qSE83YmVvdGJCYUREUW1lRnZtUEt2ZWswQlp1b1Ir?=
 =?utf-8?B?SExvUWNMZWNRU0xDa1gva0t2am5KOG1vaXg4cDd5SjZVbllPenF5ZDRWS3J5?=
 =?utf-8?B?MkZ3cDZ0YXhkbHVwZ1RDRzNPVW42aUVWNnBIWkNEWVVxT3BKYTFIVkJHTXBG?=
 =?utf-8?B?ZUx6MjF3TDdwdStBb1NNYkdIaUtINEtSUXppS01MakxEbERWUURwNkhaM09P?=
 =?utf-8?B?TE1HR0MyU2pyQVpZa1l1Y1pBVWROMGVLSkZnNW9IK0tGT1Z4VzA1WDNrS21l?=
 =?utf-8?B?Z0RvcW1ackxGVDVscTFxc3gvMldrazI1bllET2NxcXFVL3ZXRnZEbWF5c0dx?=
 =?utf-8?B?dGhTV0NQNXMzNWtQbGh3L0Q4NGxsaTREbGNRTW1UQlNDSUxBWVlPSG1DOURG?=
 =?utf-8?B?VFJKbWYvTkF5RmF5OVphNTNnWnlUblBkZ0lTOEpJUTh3UVJlVUlCanp5SzNu?=
 =?utf-8?B?aGVicUQ3SmpxaXVFSy9ndnJnUlpoT1ZmUlM2ekFqMUxOMFZnNml3QWJyQXJV?=
 =?utf-8?B?U1hUa01LNzNVdU9XR0pSZG9EMHVrVmN4dXZ3UGlScURMVWRNTng2OFg0ZEtL?=
 =?utf-8?B?eEg0THBSbiswRytJZFdtSkFmTVpCQ2tHdlRuVkpVYVlKcHo0THJOWGdIaUdE?=
 =?utf-8?B?RzB6WVNsZzNXdHBURjhSUGtSVjg1OHlmVGV6SWkwS1M3Y0dXUjBrNGJIOW5Z?=
 =?utf-8?B?cEY4NEl5dEJKeDJHOWYydy93L1F6QytNeVZNZG1MUlh3bEFwN1AvdnREdG81?=
 =?utf-8?B?RGdrSWFHRUptbm9ncjF5MGlhaGg0Y2h0RkZxVGt6YVNxakZnQmlYNGZHc1Rk?=
 =?utf-8?B?QWNMQzhFMm1ZOUhHNktBL2gwZ1VreHJwcmdZenUwZldMU1hPTXVkNi9kZFdv?=
 =?utf-8?B?Zjl6aDNmUzZGMUNGZ2h2elNuYTN0aG1kVlhia1hWNGkva1NSczFESXpBMitD?=
 =?utf-8?B?Mm9vZCt6QlRiOXp1akRoUmdaRDJyQldMbm9GVFNIOW15MU5QUFhncTlvOHVY?=
 =?utf-8?B?dWE5MkhFWkU1a3A3Qm50VVM0cUVkZEJGWDlVNDFIK3NNTzljVjlpUjBJb2lY?=
 =?utf-8?Q?8/mTrUw65l0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SE1mWitEeURITGlhNDRhenpsclYyVjRLMFE2WGJwdWtLNVRSRk5VS3JHWmR1?=
 =?utf-8?B?dGpnQXg2cjgyQmJJbDMvcFl6eXJ0cDRBbERtSjYxVjdDOXRLVlZUNkwzY2t3?=
 =?utf-8?B?NzhZQkZOZ1NzbHU0bkdXMHM2V1I2ZTRsL3VFK0x0a0hSOXVleDNWbVNubG0y?=
 =?utf-8?B?djlaSlRBSnM3TnEwdStZTkFiaXB0aEhibEpPTmtQaEVseW1SN2JibHVjOWlB?=
 =?utf-8?B?YTFFeHFPOFZ6NTZOZ1hpZFFNV2YzUHBsOHJ0R2gyNjAzVFFlTzZrQXBFUjFo?=
 =?utf-8?B?SHBRRElNN2VMVVFSNWxvNHM4NHllWkozT1F0QTh3a2p6RDlWaERkSkhaUHkr?=
 =?utf-8?B?bFpWZG1LMURFRU9NOTd0YlN2Q2d0Uk9SNkhINXNoeklCMnl2VTJSOFFnK1E5?=
 =?utf-8?B?aTgrUlRMWElWRHczbVpyR0V1MEZXOUhPbVVBcG1BekM3cTgrd3FTbHpPUmhL?=
 =?utf-8?B?OUNQVXUyZ2NUTE9URDV4aFQzY2xHTllNdkJDa3RFODFzeUtkRVpWcVEvelZi?=
 =?utf-8?B?WDgrTkN4aExXSzYyWUxtNlJpNXE3MDhLdGl5WnZ1cWxsbFF2WHUrTkpHQzJy?=
 =?utf-8?B?WTErQnZtWUJnWG1OQjFkMVVnb3pRR1pCNjlPNm54SmFJT2ZMWW9RcWFteE1t?=
 =?utf-8?B?SzJheHdJQytXdzI0MXlVamwyNUU3TG1kaVplRFBuVVBZNDYzQ01HSVYzV0Fs?=
 =?utf-8?B?MWVYclBKTmRLWkNzdHFzZ3BDUE9PR2x5R1NpMitVakN0Zy9VZGkxT2U0MjBj?=
 =?utf-8?B?MWFIaVFWVE1Na3hJbHFPTDFMd2RBMGZoTXpWaDFic05nd1JnbXAyQWdnYlBK?=
 =?utf-8?B?WTAwaFphazI2WjFhM3VkbWpyM2o2Q08zZGpIM2ZOaGRsaDJMOGVXZFdRa1Er?=
 =?utf-8?B?em5wWmZ3MktUbnREcGYxbmJra2ZCZ1JuNk80M0RZMXlkN1NxWU5IcFh2dG9K?=
 =?utf-8?B?R1ozM1FjdWIrd1lZZlhic2s3Vnp4andTMkVkYUo5cVV3eWZtMThkNk15Qk54?=
 =?utf-8?B?dERRS1RLS3MxRFpMOWp5anF3OUtMeUp6MmdsRUxLODM1dWxiVGRLQ1kwYmFG?=
 =?utf-8?B?dm5lNEdCSUkvQnZiR0NBYVhyWk15U3dCbXFYY0VqNlpHbkl5eitwY3ZNS3hx?=
 =?utf-8?B?RE5JenJFd3hPQkc2dEpHbHhVdmxsQ0ZMSGZUNmhMZkt4MGJNYlpLak9maUhZ?=
 =?utf-8?B?VzUvMmUra0c3NU8zQ1V5dFU2ZTg2VHVRUmErY05Kd25qTkxWM2xpdDRXdHkw?=
 =?utf-8?B?aDcybHd3UmpVbUtabWdQYnI3YzgyenNVeEIxTjFJcytWMTVzc2JKWHE3NGZZ?=
 =?utf-8?B?MFBLS2h4ZTR4dGllWVB6MGUxRU52NmVpRjI1dTh1Y1lyTGcrQXloMFM2OFVq?=
 =?utf-8?B?eHd4a2RwbkFQTklkQjY5TVd5UURQdU1YaENhSTRxY0ZwWTVCTjZiQm0wbTdQ?=
 =?utf-8?B?bWJTZWh5UWxlMStXODZuaDhUdzBzRk5XUTZsbXFvOFozUkpyZC9meW5hdTFL?=
 =?utf-8?B?OTFkMFd3amVWVEJUc3FlRFR3b0ExUS9keVlpZ2R4N1NwUzFrYlQwVHY1MGRr?=
 =?utf-8?B?c1hJNVF1eWhuRmZaY3MrL3JiU1JQd09qSFZ6NjlQd0E5OWUxNGtubXl6THlD?=
 =?utf-8?B?ei94WCtaOHE1c0hQTHp0VmU0S09kZy93MEtMbnJDK2R1alFnUW1NU0FxS1d0?=
 =?utf-8?B?UkQxbGN2ZXYrRVVsbVB1ZjBPMCtFa2ZhaUwvSU1ObEs5MkNnU1FRYlFPWDB1?=
 =?utf-8?B?Vzl2WjdUeTVocU8yejdZdFhYTXhwTXIvdnZnbWFGMXpabWZYZHhadEZnT2Nv?=
 =?utf-8?B?USt5UGNVb0pKMHZ2Wkgvc2xoN2tMTDJMZ1pZd3FmV1lESjN5TlVPVjhxN1Zr?=
 =?utf-8?B?cDJ4ODUvbndjNjd6YmFIeXo5eDdkM0FoQ2tEK2hnSU5pQklPQzVIYmh4UWxu?=
 =?utf-8?B?Q1F2djNQM0dKa2RFZzg0SFpUWkpFTjBSeHd3ZnFlS1hKeTd1MGdOS0VpNWp0?=
 =?utf-8?B?eGp5UHVQVko5MWpLa3p3YVhhMWgxa0xaejNPcmgrMHM2WWFFWTA3SHFEL0Jk?=
 =?utf-8?B?bDFNNS9nMTRLc0dpMmFXNFk0bmZvVlVKMmxIeU4xWmk4TEFITTdBMCtmV2Ny?=
 =?utf-8?B?SWVnL284MytYQldseFpoWFdVbEtjd2Fmd3N5cjNib1BqVFJnQ2I4cjRRQ0F5?=
 =?utf-8?B?V0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sAcJfZxCkPA5pivaKssugvG3AR0RDT09Zje7dyW/piX2Ix5UcSPz0T+Id5AH9a3uxcmHAvAc5/DOUuvbxiQi/PPHDRhKRTjuksLV07OWTsy8M2f01rTL3yXyE9Cf2GZtJNSR858EOdxxSFauviQXC1dorHDarJ2YVqpFC7jsOBIcwtOJEb77oPwGDR9HEZ/eWAQtGvJAQr8ef8rzaZwZl1mDzAr3zD06ezHoLK1W1YcQO7Kq8Exs4Pprfjx268CZu9jP4LAQ2fpFwiYjOwNMH3K+WrsUNhRrgS9TDFjcbjr5xYOJRYlZn5cUbQLUy+pPDX0E5BKMsQ37nq5hkjtR+yXJFyQSwNewKE2VtQmJtRMfSXCUh5CABI/2BUTOZhYqzsSU1TAY/1ZBTZE7Gtsg9uwJ129fmpZgW/czYOrY603+CP/QKCftFly7zG3frjGzbAUSjmaaHEe6RPd+GQkPiebX3ubAAlpPJLdG3xd241ZJCOnpkouo7r526IJNpOZkmOPjGqbd9iJsnBhCHad1yj2DyX0FgCtsE0bVjiJPC7s6i2iZaraso7cvRLFhY+doN3LWNfroMf+x8Mc9gN7Nck2Uw5OLu6/2NUXZcTF+rOQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af3bb631-984b-43a4-1f3d-08dd823f699a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 08:18:22.5663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3GLfP5cCURF2SLPuFpIOL/C7u/upSBRkW0Ba6oXIlnGMyPPMEx+EOmC4P2spQSxGCMpOXHGOpDwutxc11eXtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4375
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_06,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504230055
X-Proofpoint-GUID: bKf9iYbIj_tJDa_XVjk4CgFaSc0zrDTs
X-Proofpoint-ORIG-GUID: bKf9iYbIj_tJDa_XVjk4CgFaSc0zrDTs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA1NSBTYWx0ZWRfX4PZTSmw9vSsK 9E+Vuraflb4YTVgsSGKV/KDUVCfcCrhQyz0WONUUrTN3p4tVNtg6hYMSDAgpTJ+MIISW7JJ3jgk qVlf+uT315w09UfrtSBEns1R7XMDWwYThOYqHiqowPWL65DDC+YIZxxspLO/OYlxrrsYePXnFg5
 nrnIwhY7TcuLeZ30MVHN2FAnsxDCQXiytzznU6FuAekgUmeYXj5zB9xHgtQG5GsF+GxXJ+incXM btupSaqZD0ewE20UtEmW+e2aX3Q8r8awQpZS9X3yGICTrbR8XFk1quXKzhO0Elosw7qe2AAKoO8 8fNismXHxhUp1tA+A1pZ7j8DoV5ewoaTpdPUnE1zsq8VadcBdHkHcJJG+iSJ8HXd+sZUEuidROk NRM/RhLr

On 23/04/2025 09:16, Christoph Hellwig wrote:
> On Tue, Apr 22, 2025 at 12:27:34PM +0000, John Garry wrote:
>> For when large atomic writes (> 1x FS block) are supported, there will be
>> various occasions when HW offload may not be possible.
>>
>> Such instances include:
>> - unaligned extent mapping wrt write length
>> - extent mappings which do not cover the full write, e.g. the write spans
>>    sparse or mixed-mapping extents
>> - the write length is greater than HW offload can support
> 
> or simply no hardware support at all.

sure, will add

> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>


cheers

