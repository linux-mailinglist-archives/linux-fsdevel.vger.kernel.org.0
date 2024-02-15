Return-Path: <linux-fsdevel+bounces-11666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045AA855E8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 10:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280051C21941
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 09:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C1B634FE;
	Thu, 15 Feb 2024 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LgUSGadS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gGah8F7G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168A2199AB;
	Thu, 15 Feb 2024 09:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707990858; cv=fail; b=lVlFGdhvcSu5dNwF/YETq4aQkH/psBTNMU1gm9washXfQ5gHbVXvKrBq6nR7Q3iEkoA67E08SFXBkQUFZc4SBvTrFxV83z3PHVFb64eGsr29bYmZvNHam+UFOXQhUioZRGtCtSLqkPJRJRJaeBC8Ax38GevhUm55D+xdr1p7pYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707990858; c=relaxed/simple;
	bh=3yp4YQvU7HI7YOHR9vgJk+MsvqVHSZN1i96MOnS/k+U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fZBPJSpRBz+cE6td/Y1/ao5YerJBTjFQbZ1p1g/gee6Z8nULsvQpKTftfVL1UiY3RUJib4CHEU3KaISDIZ01D5S+QVyR7jew3OfplTD2BAxH1psWMswXYpoVARf3fpU/TsO2PBe07FOByCno6ZB0EiNQsWs3KKcJuDRXugO88e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LgUSGadS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gGah8F7G; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41F6i0oO001409;
	Thu, 15 Feb 2024 09:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=WolXFA7ViNTfDpB84CECnszF1i26XUb74hZsIw2u4is=;
 b=LgUSGadS9x40Z50Islc8VA7NK94rAgYw+ZHiBmgRJRZu9+WNRTtRjY+ksS6vjsi2lnWS
 ZfRtfXbmKZq3LXIbKwc5WQo9TY6AiEFLFljR05+6otlMtYJeFWNLrpCVIWGv5LKvrW/c
 Snasugysh5UDJUnMFsltXB4RyUPZsfakdMC3zrfDuVC/gi92xwSQZG5ZInZkpq8QMDdu
 HgZiNzlBMMqYlN2n2rzUukkRs4oxvKsCzgpQBWLSeZpIBz/KjsdPOJ/7jsGaAGa10IOK
 UJRULAL9yaukiDP0GhbdzQzaLRDIUqJ5gW2QF66Kf7nf0ccgKOQpQZJBUXjq/DU/TPIh 0Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w9301hjfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 09:53:55 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41F8UFVw014960;
	Thu, 15 Feb 2024 09:53:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yka07ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 09:53:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfWYMMLQP+8lT5Sz+0TxpJX119/oC2Ff7Qu1fHJdWJyONtoa4s/CWERqfaFItE03k9QUFuPWcyV1xyS941i39jJZyIW7as+bT7FRkmrud2osw6dfZACmbmi2UF9mijzn6vkwGg7WrwjEO3G9Lu5A5r8Tqd2Tnkt5Gz2zFuoRfpPZDOP1/3Yi8znXVU/bNztE5HEHEjTjzRurO1VUGF2sgqGEfl3hEgF5469IXEvY1/L0HitqpgqHrfmsMmPpncApHhgtkHpEOyy6XYqKgVZghWc4DfxdwCZtAxo+muM+uzRPFOYR9X6/Iy+jfjbrkw5TDrxgw+XXsjqydxQdkTFHsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WolXFA7ViNTfDpB84CECnszF1i26XUb74hZsIw2u4is=;
 b=iLyyD4OtHdF6jBctc4/LfU13x6AoILxKF0gmeFtvwiF37d3cxezHsMa8IEL7svca27WVt5jaAPcO+XgYBELZeZLamNbfn6Dna3rMtnEXGf5DuZ5/loJt8NXnTiNAaczYYdrgLduBYWlg/NglAMHQimwY+r8EntBQzQS3MOcURoD/iKFaEWonIDKM8XDCPtHKZMrp4XfBJOH9K+F6SoQLZXOiZN7k7QPfAWiJZjGZBsLgJWI1LWRxwNm1Kvc1CC1WOC1cIaaMvePivWEvHDOeDz62vQMAdWu/kjrhX4VMb4LU6jMe+sAutLAEP9n7D0nLWHebtILchncKvaQHbBhKKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WolXFA7ViNTfDpB84CECnszF1i26XUb74hZsIw2u4is=;
 b=gGah8F7GO3bs+CfKWT6z5TCdmDvozynobGgbYNvbfwyJ+e+vHWKTaWZIuWK9noF5Zz8dKZnhvC8yhhLRDRIgydxDNDMltHR3HHT6CH6S0atKS2+UriCFeVYQSHvOLoq0SpazdOobGlC4zpMdxAgkFVN6sGqEhBXpX0zOv2kp134=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6840.namprd10.prod.outlook.com (2603:10b6:8:104::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Thu, 15 Feb
 2024 09:53:51 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7292.026; Thu, 15 Feb 2024
 09:53:51 +0000
Message-ID: <c0d1d513-991b-4893-a132-66ee02c0c880@oracle.com>
Date: Thu, 15 Feb 2024 09:53:47 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/6] fs: xfs: iomap atomic write support
To: Dave Chinner <david@fromorbit.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, hch@lst.de, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
        chandan.babu@oracle.com, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com
References: <20240202184758.GA6226@frogsfrogsfrogs>
 <e61cf382-66bd-4091-b49c-afbb5ce67d8f@oracle.com>
 <ZcGIPlNCkL6EDx3Z@dread.disaster.area>
 <434c570e-39b2-4f1c-9b49-ac5241d310ca@oracle.com>
 <ZcLJgVu9A3MsWBI0@dread.disaster.area>
 <a20b3c07-605e-44c2-b562-e98269d37558@oracle.com>
 <ZcWCeU0n7zKEPHk5@dread.disaster.area>
 <20836bd6-7b17-4432-a2b9-085e27014384@oracle.com>
 <Zcv+IlxgNlc04doJ@dread.disaster.area>
 <74e13ebf-2bd7-4487-8453-d98d70ba5e68@oracle.com>
 <Zc1GwE/7QJisKZCX@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zc1GwE/7QJisKZCX@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0664.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6840:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d52298b-6568-44fb-ace8-08dc2e0c039d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	38Yoqeev6Shm8AwE1kyb2ZS71/mYd8BWKVEtE6lEAPblwZa70/hnYqX2aycffr3IjzJECCxaa5YzFTs+QY3fj2zcTbNLXxCPfvIhu2ArQRAR7NIVO0K2MR7v6UVZMC/l4xj1TGefKr7kArFdm7bBcUAaf0qYV2OfmBoeUSrElHemuGrSQ5/fgfvRr11cu8xjegJR7sZLMoTz41UnjTvCPyPt+/j4Gskh9vTlYJXAokEVl9nbo7h2l1H7F4QIHkwdHVohnYoJ27gX/MJYDYVG5rZZMLa1Njc58HpA7hvxbxVXTWHH4cuk3YRkgvHsGd2xzIHFfBiKEiMlvOlle10UsRnvmpXi08OE4Yfku4aM/yea4WlMYcTXvLZrP/QQI8yoeQUBA49YRK1n30PEbDF/28G/hRLV1vRLx21tuT9+s/KIpBx+EtHJ6JqnSBoYKY8wjVmEW1tVs2F4LkLHNwmcFT1uvth9UVyYfBvukRDxsPDqLRQfso7UpObpcbC3Ty0d/rL3WM8ABe1Y0kh96reboO1K2Vw5jAxGKMoxhca1wcg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(31686004)(6916009)(8676002)(8936002)(4326008)(36756003)(31696002)(86362001)(38100700002)(478600001)(83380400001)(6486002)(966005)(36916002)(6506007)(6512007)(2906002)(7416002)(66946007)(5660300002)(66476007)(66556008)(26005)(2616005)(6666004)(316002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WkZ1YXMwNkxFZnpDK002enFnZlBpVkl4R1lMUDZveVFhV1hzcWo5RDYvbEJP?=
 =?utf-8?B?RG92a0NYOW5XUUtvaXhZckdDUzZGSDFtMitnY1dBcVBNSkY0Znk2S0tSTmtC?=
 =?utf-8?B?RDVYVVdicE15VlFQQStDUVQ1WW15dmJaK1h0SC9INlpWNlpMUjFzZThqelVB?=
 =?utf-8?B?OFF2SVRXV0E4bmliOWRVTFRxbmtTdU5pSU84azd5WWo3VlJVSjh1VmxNeU9H?=
 =?utf-8?B?bkx3bmFVSU5MdUM0V1RkTEdtQmFZaWwvT29xZktUeHY5WW1CRlJIejNWNVZq?=
 =?utf-8?B?SEFzcVVOc2VQVW5QM3FKRUFXZmxqKzl3am02ODA5T1pCVnN1V1NkR2hFVFBJ?=
 =?utf-8?B?bmxjZmptd1NFZjdma3ZDR2xKdTNvS3dFVCthUWFsaGpGdklmbkVwdko3MnZ5?=
 =?utf-8?B?RmhYNHdBN3c2NkVXM3NFVlE5MjRwbHpkbjB3VVRheXRBMWorZ0Q0VkttZ2Y5?=
 =?utf-8?B?MFVWL1NYSWsxdUNNYlJSOU1QOHcrei9TUU9QV3RUSW53alBHSzdZQmR6Sk5M?=
 =?utf-8?B?UjVHTVlITVU0WGEveVR0cjd6czZKTW0xejdIenF2YkJlcGdZaXk1aFlYRU1I?=
 =?utf-8?B?akp3dHRJYWFnUzR4ZWFmbENuYjRFc0tLNUlZdXdCbDQ4ZkpITSsrTGR0TTNP?=
 =?utf-8?B?SnV3cGExZHJvV3lIQXRXcUcyYXk0Q0RrOW9zMkFab1dPcWR3WDF5ZkZsRWN2?=
 =?utf-8?B?d0pGMkdWY2s2OHFSb0VjREhtL3c0cTNyNzA3WmpUY3owUktWRDRFSEcrZW1r?=
 =?utf-8?B?UHdicENCTTdDdVNjNnJtNS9aR2wvaDJwOGorV3dKVHMvM2pad1FsQkU3ZEx4?=
 =?utf-8?B?ZzJtbWNDSExkQk0rdndPME5YeWlZYW95djRyUllUN1VHTEVzYjRYSGsyOUwv?=
 =?utf-8?B?QmhONllHVzdhK1JMam1Wd3p1TTZtNGVWVlRtUjZrakJSbU0yVnNNTHNZQjFO?=
 =?utf-8?B?ODhVcHA0TjNBRnVNMTBKMmlXR3NxSll5NkhlSnordmVRbmdKV2wxaW4vNEVJ?=
 =?utf-8?B?ZWQyRGdQQmpYbjlScjc4aHJQVCtsUHJzeklraEhsMFU4V2RYcjVwQmJWRGc1?=
 =?utf-8?B?UXZGOEZVUzVtOW1EZ2RxaCt5ejRHWW15Ri8zQjJpdVNhUnJzMGRkMTBDa2E4?=
 =?utf-8?B?YWhuRDlRcElvdXR1cko4M2pBRURlamI4aEFLQm50dU42emg2S0RpeVZ0T2xq?=
 =?utf-8?B?MHdQaTl3Wkg1VmRwaTRiNE5MOFFsOFlBTkJMNE10ZDl6bHNDQlcwNU1jUWZ2?=
 =?utf-8?B?QUpJV1Q4YUdyV2hoTVBSYTN3djVtTDMwVnBkYStVSVNGSkw2Z2U1NjhKUFUr?=
 =?utf-8?B?cjJXVEt2RklhUHNGZEp3bkxtNHpJUXJpc0Y1NGxaYmJaV2dhR2ZvU0hrN0I0?=
 =?utf-8?B?eTZhVXZPQ0Q1MXB0dVJvV3hTeHhxZ2YyQ0JLS3VGWlZkbjNKZnVzVnBVYXhL?=
 =?utf-8?B?K01SWHV6VUtJTFpJejN2UGorOEd6aDRpZ2FpWGFTNkR6S0dwZkJIRW1neHd2?=
 =?utf-8?B?cVNiVUtCYzE1aWlpR201RExwRDhyaDNHUHZBRTBaY2lkQ3BWbG5sWXIzeExa?=
 =?utf-8?B?THA1eVlRUWQ4NS94VXM0cUROMTFOejYvTWVaYVM0TE1tOVhkTXFKT2tXVjh1?=
 =?utf-8?B?WDRFQXZrckJ0OUZPazZQUVRjTWJiL0xDS2VuSURudWVQSWloY0NMZ3kxekJk?=
 =?utf-8?B?TUFlQjEwYnRGSDJiVXNTZE8reDdyODdYYmtzRnYydFdmcStCUXU1UmxSZDRD?=
 =?utf-8?B?Ynp3VTNnVDhYTFpiWlM1L1YzQ2xOZnJkcm5BYks3NktBNXBsSHlNcldHY25U?=
 =?utf-8?B?QmJiRGpWYWpVTnZVWVB6Sm5KMU1IcmVXOE9sQVNzVFd2T0xKVHZ4a1c3S2lL?=
 =?utf-8?B?WHk3YmVGNjFRcFVTK012NUhrMDRoZUc1SktQcGluTHEvQU0vR2VpNm5GOWJa?=
 =?utf-8?B?UFduUjZVWDZ6Q2ljRWZlakdwNzdWeEIwcHRhQVhRTDF1ZlhWL3lSR01Ca2tH?=
 =?utf-8?B?RmZNMTNjMWt1YjRyWnEwZVZNeDZVY2hFN2pPR1liejBZWi9qSy84aGJUMDZ6?=
 =?utf-8?B?U243ZWdmbzZwZWZ2UnlkSnllNmx4YmVhK0tSaGNmQ3BkRHg3blFwaEp5TE5M?=
 =?utf-8?B?QXZUWTJoSmIyV2FXekhtcGlqZUU1TmFWUXorQmx1cWlGUExOcTM2dUppZU9x?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Wg1p6BEo+CGjVYwTT1r8Z9rOTVIU5OUo/hoEBLZdVIyknoot4hNMvQvtgVXEG30vXB9BMGFxCA1bUivvZxXl3jrEIEUsjoxqTMl16YlRj1WjzB4Jv/0JBhypydqNCFhWVDjLuSNHysFlAQ9JUvYftKAuDyEMJVb+0YjQhdDW8iwBqzJNleWMayfl7iFyYFiHA5dTyTwfgNqQw2mF4dUdJjEsSZTwluJ4pF6k9KoJ4OQTn2S6ek5aon1DKA98RaddlYdxyUeqL4C2mYJ37MOnLYvvDpooAKiilQHeKr3osbyQba3dtoZxJ6v/R1tOhWOfNJyOYkoIELBZbbSjnRdgVfG73MvOeKwQ97CvLzVGZ90YfCoL3hlopEvI5l8inG+roRpE4aje+24NW79pwtCiT4avQEbQcB+/BAGJHV3JCMpIGefaVcrpr7uzaapE2OXEz1Yf0DvZKHtoFmNkUGeSAOyTaFVUFqHcIxFsJ09RngmmHdup/s9dv+WBT+PcNvGJOUhD9mpUqYNLt+flNzdnKz9atB0wHsOLzhD4kEZIYbIZ/V6a5dFmM8k0hriWppOhd+vaamtF0TlhFAkTdVr2C3oMLPR35G7TfSnqcwUpilE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d52298b-6568-44fb-ace8-08dc2e0c039d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 09:53:51.6879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAaS9+J4FK5Xs17g1kpy7k8Po4TqNlZRkULenuC7uUkv3Ziun0DOmZmQb0kR6mhV8X0omfnQwxLrab+r1gceKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6840
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_09,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150077
X-Proofpoint-GUID: cuOqaavMQL_BrPwaa_q0BYGUVedzYmtt
X-Proofpoint-ORIG-GUID: cuOqaavMQL_BrPwaa_q0BYGUVedzYmtt


>>
>> Yes, I was just looking at adding a mkfs option to format for atomic writes,
>> which would check physical information about the volume and whether it suits
>> rtextsize and then subsequently also set XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES.
> 
> FWIW, atomic writes need to be implemented in XFS in a way that
> isn't specific to the rtdev. There is no reason they cannot be
> applied to the data device (via superblock max atomic write size
> field or extent size hints and the align flag) so
> please don't get hung up on rtextsize as the only thing that atomic
> write alignment might apply to.

Sure

> 
>>> Yes, mkfs allows the user to override the hardware configsi it
>>> probes, but it also warns when the override is doing something
>>> sub-optimal (like aligning all AG headers to the same disk in a
>>> stripe).
>>>
>>> IOWs, mkfs should be pulling this atomic write info from the
>>> hardware and configuring the filesysetm around that information.
>>> That's the target we should be aiming the kernel implementation at
>>> and optimising for - a filesystem that is correctly configured
>>> according to published hardware capability.
>>
>> Right
>>
>> So, for example, if the atomic writes option is set and the rtextsize set by
>> the user is so much larger than what HW can support in terms of atomic
>> writes, then we should let the user know about this.
> 
> Well, this is part of the problem I mention above: you're focussing
> entirely on the rtdev setup and not the general "atomic writes
> require BMBT extent alignment constraints".

I'm really just saying what I was considering based on this series only.

> 
> So, maybe, yes, we might want to warn that the rtextsize is much
> bigger than the atomic write size of that device, but now there's
> something else we need to take into account: the rtdev could have a
> different atomic write size comxpapred to the data device.
> 
> What now?
> 
> IOWs, focussing on the rtdev misses key considerations for making
> the functionality generic, and we most definitely don't want to have
> to rev the on disk format a second time to support atomic writes
> for the data device. Hence we likely need two variables for atomic
> write sizes in the superblock - one for the rtdev, and one for the
> data device. And this then feeds through to Darrick's multi-rtdev
> stuff - each rtdev will need to have an attribute that tracks this
> information.

ok


>>>
>>> What the patchset does is try to extend and infer things from
>>> existing allocation alignment constraints, but then not apply those
>>> constraints to critical extent state operations (pure BMBT
>>> modifications) that atomic writes also need constrained to work
>>> correctly and efficiently.
>>
>> Right. Previously I also did mention that we could explicitly request the
>> atomic write size per-inode, but a drawback is that this would require an
>> on-disk format change.
> 
> We're already having to change the on-disk format for this (inode
> flag, superblock feature bit), so we really should be trying to make
> this generic and properly featured so that it can be used for
> anything that requires physical alignment of file data extents, not
> just atomic writes...

ok

...

>> Another motivation for this flag is that we can explicitly enable some
>> software-based atomic write support for an inode when the backing device
>> does not have HW support.
> 
> That's orthogonal to the aligment issue. If the BMBT extents are
> always aligned in a way that is compatible with atomic writes, we
> don't need and aomtic writes flag to tell the filesystem it should
> do an atomic write. 

Any instruction to do an atomic write should be encoded in the userspace 
write operation. Or maybe the file open operation in future - I still 
get questions about O_ATOMIC.

> That comes from userspace via the IOCB_ATOMIC
> flag.
> 
> It is the IOCB_ATOMIC that triggers the software fallback when the
> hardware doesn't support atomic writes, not an inode flag. 

To me, any such fallback seems like something which we should be 
explicitly enabling.

> All the
> filesystem has to do is guarantee all extent manipulations are
> correctly aligned and IOCB_ATOMIC can always be executed regardless
> of whether it is hardware or software that does it.
> 
> 
>> In addition, in this series setting FS_XFLAG_ATOMICWRITES means
>> XFS_DIFLAG2_ATOMICWRITES gets set, and I would expect it to do something
>> similar for other OSes, and for those other OSes it may also mean some other
>> special alignment feature enabled. We want a consistent user experience.
> 
> I don't care about other OSes - they don't implement the
> FS_IOC_FSSETXATTR interfaces, so we just don't care about cross-OS
> compatibility for the user API.

Other FSes need to support FS_IOC_FSSETXATTR for atomic writes. Or at 
least should support it....

> 
> Fundamentally, atomic writes are *not a property of the filesystem
> on-disk format*. They require extent tracking constraints (i.e.
> alignment), and that's the property of the filesystem on-disk format
> that we need to manipulate here.
> 
> Users are not going to care if the setup ioctl for atomic writes
> is to set FS_XFLAG_ALIGN_EXTENTS vs FS_XFLAG_ATOMICWRITES. They
> already know they have to align their IO properly for atomic writes,
> so it's not like this is something they will be completely
> unfamiliar with.
> 
> Indeed, FS_XFLAG_ALIGN_EXTENTS | FS_XFLAG_EXTSIZE w/ fsx.fsx_extsize
> = max_atomic_write_size as a user interface to set up the inode for
> atomic writes is pretty concise and easy to use. It also isn't
> specific to atomic writes, and so this fucntionality can be used for
> anything that needs aligned extent manipulation for performant
> functionality.

This is where there seems to be a difference between how you would like 
atomic writes to be enabled and how Christoph would, judging by this:
https://lore.kernel.org/linux-fsdevel/20240110091929.GA31003@lst.de/

I think that if the FS and the userspace util can between them figure 
out what to do, then that is ok. This is something like what I proposed 
previously:

xfs_io -c "atomic-writes 64K" mnt/file

where the userspace util would use for the FS_IOC_FSSETXATTR ioctl:

FS_XFLAG_ATOMIC_WRITES | FS_XFLAG_ALIGN_EXTENTS | FS_XFLAG_EXTSIZE w/ 
fsx.fsx_extsize

There is a question on the purpose of the FS_XFLAG_ATOMIC_WRITES flag, 
but, to me, it does seem useful for future feature support.

We could just have FS_XFLAG_ATOMIC_WRITES | FS_XFLAG_EXTSIZE w/ 
fsx.fsx_extsize, and the kernel auto-enables FS_XFLAG_ALIGN_EXTENTS, but 
the other way seems better


> 
>>> to behave in a particular way - forced alignment - not that atomic
>>> writes are being used in the filesystem....
>>>
>>> At this point, the filesystem can do all the extent modification
>>> alignment stuff that atomic writes require without caring if the
>>> block device supports atomic writes or even if the
>>> application is using atomic writes.
>>>
>>> This means we can test the BMBT functionality in fstests without
>>> requiring hardware (or emulation) that supports atomic writes - all
>>> we need to do is set the forced align flag, an extent size hint and
>>> go run fsx on it...
>>>
>>
>> The current idea was that the forcealign feature would be required for the
>> second phase for atomic write support - non-rtvol support. Darrick did send
>> that series out separately over the New Year's break.
> 
> This is the wrong approach: this needs to be integrated into the
> same patchset so we can review the changes for atomic writes as a
> whole, not as two separate, independent on-disk format changes. The
> on-disk format change that atomic writes need is aligned BMBT extent
> manipulations, regardless of whether we are targeting the rtdev or
> the datadev, and trying to separate them is leading you down
> entirely the wrong path.
> 

ok, fine.

BTW, going back to the original discussion on the extent zeroing and 
your idea to do this in the iomap dio path, my impression is that we 
require changes like this:

- in iomap_dio_bio_iter(), we need to zero out the extent according to 
extsize (and not just FS block size)
- xfs_dio_write_end_io() -> xfs_iomap_write_unwritten() also needs to 
consider this extent being written, and not assume a FS block
- per-inode locking similar to what is done in 
xfs_file_dio_write_unaligned() - I need to check that further, though, 
as I am not yet sure on how we decide to use this exclusive lock or not.

Does this sound sane?

Thanks,
John

