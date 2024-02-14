Return-Path: <linux-fsdevel+bounces-11538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A158547BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 12:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3BC28F9E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 11:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4477318EAD;
	Wed, 14 Feb 2024 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jLRvyqhm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hWsmQUaP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460561AAA9;
	Wed, 14 Feb 2024 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707908812; cv=fail; b=Bkjkc1oQ1AfQMF+cPkESCkjCIDquOXwfQvNbZt+m8tdy31Iajf/aVS31K15NDfMS3NGgkUJvuhKRaSgkDW+iUUBQll+5tAcnret0qg6DHmzKm6Ry+s86R1HS5DwSUHmVwoHUX2uMQuRJ3/1MdTcs6ZT1N2wOyQ4jPNYC6Ex5EyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707908812; c=relaxed/simple;
	bh=nacNqM7TpJ+Oi6Jt3UVZgW+VUlqfCpi9e2Mp4vWqc84=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=llYTCzubBSjS6gJPXVr2SF7MbgxJmXDmA/8icQjejhKaJIMaFt6dLYN1jnkSSQeuVjSPF0LXl19BlnUMw94S9eRxyPAYErSkrtlLLEXF6Ca07eDZdUlLiXOw+19G6EUwiP/kTDHFcEUgwoJaZ5adDPidwhpqeEqTRymdNU1M0F0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jLRvyqhm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hWsmQUaP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EB3LVF006694;
	Wed, 14 Feb 2024 11:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=cOKZmzbCWBLLa6dEL1OojYYISJHhLvgh3QU6hS8OvzM=;
 b=jLRvyqhmw8jaRrDjFGB8a+YzgP5oCYBxiKh47LmDFMvKLn3EanKHlwmNW2DpDiOxJI12
 W6AFDoyDCpMQDk4e5BGZUGF7aTW0cfeycSe/Jy4Ipid6YLS6ofktieeaJoLaNvuwYOHT
 qXx7wkWh8jPK7FiB9vf756DjMfRkyGAYAhe/x2FVt0dhmfOwjf1Z0/cHR9pI1vEDotca
 uU6ywcBtQW/eX551i+/SewsBuEOfHPyvknPptWgLl/TKMpuERtROa9YlcIeyQMxzcYk0
 q0ZwQbtqeaIOpJxPzdszrwtRq4KCOOgw9yOMn0nVqJmCxzTFopthJjkDjMUdUGRl3LKD KQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8u7j843j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 11:06:19 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41EActoP024679;
	Wed, 14 Feb 2024 11:06:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykf2r9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 11:06:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNOC3hjqMJre5IN6AGxFLwSQR8Ty08wpPlOmqkzon1NB1WuvHU/HjTTs/2wBbmBClyEzoRTfW6CsK3c+o1Rt+pD4dW2t+gwdyxBtqhQmPE4QTHP4wKWimk5+bA1RgCe4n0nSTBINN9O/zvjjoPDmWgm21cc28JPu+6VwiDumNRmT1nwNdGMVnD1NA9Tuwdp+ablD+ig36AvLw4IuTfZoZ2v4MnSydzDw53B/zp5RYD1QwzDD7pCqCnfxrprASiYDRBoDq/9Fgahi//WAJcnjb77HZ92DfNLCkJhMcZ9g3uTwpo/pFgr3xAccsZFxbw3uk6qyueVD0r0Pc79ffAbYkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOKZmzbCWBLLa6dEL1OojYYISJHhLvgh3QU6hS8OvzM=;
 b=R06zTQr/rmNjSgQ8CUKZ8hAq6kzjyygufapr0mS24z1zgUfouadwI6iTxIbyBIQ3Ia+1qq55nOcvRxwV+cTBou8MPtE3DfVrPzbdvxF/icDhUwrH5uZoiRN5CL2/oI20Pj0YEsi6txDqYb/ibuBQoKySHkOHFdyV3RJ7t/Wlk09FmEDp/OVL7lIIPuBRgjpqnvvzfFtRvYrnArUTQH5Ckau55eS2/fu2eOsnL1NPNPK5NIWOsc94TFhPA9nLlSGW4H0cf4NxKQfVjt5YPRZIEQauNR27UyTYR+8bI6EE7eO6nVRjxEzHabZ4dWFomvXKJadTp0dHCqx+S/0Dm8We+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOKZmzbCWBLLa6dEL1OojYYISJHhLvgh3QU6hS8OvzM=;
 b=hWsmQUaPO2wjz839rLABap1KThfyY7YHD6gip3Eaj3rIBrWgXucHvPEoOxW7qQLc6GHNJ3f9GMDqculamAEnEiRAcP1vEsUj+W9tqxMcQbRBeRkJ/d6T3HLvYZCbW4U3WPOsZ9yXdszQzpju639pv0xTs9LLupbX513ugmkBeYU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6824.namprd10.prod.outlook.com (2603:10b6:8:11f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 11:06:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 11:06:16 +0000
Message-ID: <74e13ebf-2bd7-4487-8453-d98d70ba5e68@oracle.com>
Date: Wed, 14 Feb 2024 11:06:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/6] fs: xfs: iomap atomic write support
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, hch@lst.de, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
        chandan.babu@oracle.com, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-6-john.g.garry@oracle.com>
 <20240202184758.GA6226@frogsfrogsfrogs>
 <e61cf382-66bd-4091-b49c-afbb5ce67d8f@oracle.com>
 <ZcGIPlNCkL6EDx3Z@dread.disaster.area>
 <434c570e-39b2-4f1c-9b49-ac5241d310ca@oracle.com>
 <ZcLJgVu9A3MsWBI0@dread.disaster.area>
 <a20b3c07-605e-44c2-b562-e98269d37558@oracle.com>
 <ZcWCeU0n7zKEPHk5@dread.disaster.area>
 <20836bd6-7b17-4432-a2b9-085e27014384@oracle.com>
 <Zcv+IlxgNlc04doJ@dread.disaster.area>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zcv+IlxgNlc04doJ@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0015.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 0edc274c-dbcb-44c8-a697-08dc2d4cf6ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UWCwHBAEZotarmZ4fOJpqXwJv5oIv3NCjOIvmhnUGXDnED12t9pQu46lnJmkl9HZUftndtefWgTsnLou+Apk2Jmzgjhz+wnfCgXohke5Fnffq59WQ/c/Mfi0hCOX5zQ4eCL5p4R/sQvkAYabrnTnERez8Pp/HnbAYB3Ja2J/1ofjDQcjpyMJQ1EiUIUETNMJF9sMAfKJbbLJRn8RSSPsXjdyvmNfEvTvfjj4DIyU5aylcX0qUNujqmIqMMGplNuRrtB1EdRYjR8giqVBCst44pjEzEHrRKN4pXF9dFbrhNp4hbvfe0x+SbQYugOZQ46a7a/FsIdCcBWfmhT8XZzgO8SoRMGzL7dLeFNR/2BWOvK8S/QQu3+eNLT3f4ibOUq3xLvrUQe4rxJa4EFn1jbKm2LO8eTt+nqOr2vmHN41bdZQfLPhGe89yGhudub8/yhPPnTqGd4kRiVj9SGBIhJn3ZW+NgljPrJHQKsos3G/56ex9Jc8mW+PuQqXqnPRaenQ5f80bO+GkpVKo2QOGyEn74r7cVcADDEq57ODy6vb4vQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(31686004)(6512007)(966005)(6486002)(478600001)(41300700001)(66899024)(8676002)(4326008)(8936002)(5660300002)(2906002)(7416002)(36916002)(86362001)(2616005)(6506007)(6666004)(6916009)(66946007)(66556008)(66476007)(316002)(83380400001)(31696002)(26005)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MkhaK0Rpcmxsb1k1UVpVOTFaa1NMZ05heG1vMDBxMFo3OGxQVytMVHFPOVNQ?=
 =?utf-8?B?S2dSTXcvYkhidFZFTlBDMitNME1NSGhOUy9mU09sVks4c215UXVXWUJzUXdI?=
 =?utf-8?B?SG5Cdk9ySnpjbDRFSU1SS3NTOVhXZFdXL0xpTUZIU3NlWWM5UERTWllNekox?=
 =?utf-8?B?clVWSHZJU3hMREVpZkk2cWQ3SkdDYkYvWnJvVkRRR0N1UG83SDdKS3d4N2h1?=
 =?utf-8?B?ZVMybjZpZVh3V0E4d09FdERJdW50WWJ5ZUhWRzNaWHFjUjV6YkZLblJhK3Nh?=
 =?utf-8?B?L25Fb3Y5U3RDaTlqaXIyME0vWml6UUlZTXlMMDg5cnV6NGZ3SmJDMkd5ZXdX?=
 =?utf-8?B?enNxK3ZZSHUzM3BpaTVDZmZPTnZ1OHUvZ256ektrNzBKaWJwZ3lLeUhJZCtH?=
 =?utf-8?B?a2lOYXVlWVZGeXNPR0pBU01TMi9mbkZKZDJ3SjBGSjRqVE5qNjREcWJJRHlk?=
 =?utf-8?B?c2hHTEJ1TEpxZUNoMVl1V1NVQUZOdEZuVlRSNlhhb3RONit0VnB4cjZyMDR3?=
 =?utf-8?B?bXNKaHh5a2dMRU85dGVtVmFmY2pnVWxCMGFVcGlZZzJJWU5McWNZeDEveWtV?=
 =?utf-8?B?VjNVY0xUQ0JVb1BsSnpzOXJPdTNodkxFRFhKaDVDQ0dxY3h0MWtQT0o1ZVFR?=
 =?utf-8?B?U21Sa1M0N1o4eXpEUkpIdmhWMDVIVWtibkNwTzhkVlRBR1pDMG1WVFhtNERw?=
 =?utf-8?B?K21wejRuam9uUHRVdkwzS1pXUVpIcXl0R0pPUFd2VUVEN3hWZTBCZFpLaEpK?=
 =?utf-8?B?UDBBdGJuQzhXYWZxVHM1di9UTDNSY01oVyt3UUR2ZHVqc0RGY3g4T3pQUnZy?=
 =?utf-8?B?K1ZKazdQYTVhK3FhUEhGTkQ0RW1zNVJDWnpUQnk4QUlsV2Y0aE9YRlZ3NzFO?=
 =?utf-8?B?RE92ODdweHdJOUtuYjRuNGxPZEp0Szk3c0N3UkcyWlJ3enlycU9qN2N1NmNB?=
 =?utf-8?B?TzNpMXR4Qm9NcmFBbDNlOGVINmkxWmxvQ1ZJOXhTMHQvdlRTYVlJQmFJSW4z?=
 =?utf-8?B?ZEhHdkE4c1o4d3NYVzFHREN3U2tTZkRYN0loNEN2b05JeHpCaE9xcm80Y0pN?=
 =?utf-8?B?Z0VneEtiMDVWeUFTTmErZjRVVTZ1TzJQbDREYzhjbkVvcXMrdzd2eHlIaFlp?=
 =?utf-8?B?TzZnU3VrS1hmbnI0R2g4cStTNWxtVmZZcC9ySEIvcWh2YVhhV3RPK2lkbHpx?=
 =?utf-8?B?dDZLaDRNd2d2Vklucm9TdGNNa3FHWDBFam5FeFBuSGdCOXkyaVZrOWZGajFU?=
 =?utf-8?B?YnhVZS9QRUpxNE5OU25rUVpHMVVtdmF1WDgvQVQxK0lVbUlRczVFRENqMjN0?=
 =?utf-8?B?RFdXYllkbk54bktqSnhCRERrWmF3UFZTVS9lYU1leFlFb01wS1ZEQlM1TWI2?=
 =?utf-8?B?dHdLZktZTTBiY2o3MFpMT1RsZWdBWkxXK21TNGxmSUl2T01vUEZuOGpnV2ZZ?=
 =?utf-8?B?dmlRTVRSazl3RFpqU3ZUNE1XaGp1VG85czRFbC9oMUxQUkN4cVFma0JBVUk3?=
 =?utf-8?B?VDZnQmcyTkg2SitzMXJsYzdQZTJENXNQOG11dEpOMGdDZFp5MEJXTXFWRFVV?=
 =?utf-8?B?VWNIbXBJNXZhRVRFamVhQldMUTRmR2pXYmRkWXNoc1pkMWtBdHI0cjB3Nlpy?=
 =?utf-8?B?MjhQZWQ3QUV4aE5aa2ExRVplWHVVYzZDc3RLZVZIUm9iVUpJZmpMNFU4SGRJ?=
 =?utf-8?B?WGl1ZmV0MEY1NGVOQ0Zmbm9iTFJQNzNVSXhHekVDUTdRMzFEM1ZiU0NvSkVO?=
 =?utf-8?B?dTRzcDdOclZSZHQ1YXBhWFZOQkNpQUlCc2p4SVo3UmVLdHduSDRxcm11eXA3?=
 =?utf-8?B?MFoxeVF1dkxIbWdRemt2NzZQVEJjbUdlc0N2M21Uc09heFlXY1ZUdXZXQldK?=
 =?utf-8?B?RUtCVzRuSXNKeVNTMjFXQzhMTVgrRElralp3OTRFYWFtaXhGQi9hbTdEdGlm?=
 =?utf-8?B?N0NKOXZwU1ZtQjE5aDl3TXgzRmhQRURvaWd1LzdlNUF0YS8rbXErMnRxdjg3?=
 =?utf-8?B?QWRiaUN6ZE01ajBHdzNGc3NiRjRqR1d3Wlg3Misxd1laVm5xRzNrQ0xDSnIv?=
 =?utf-8?B?MENwd3ZsT0RSRFZoN1Jabmo4aFdQbktQbENLZTdEUlZ5RU5Qc1lDaEF3RE9i?=
 =?utf-8?B?UjJHYWJCTkZsR1dxd3pRaUZ0VEFCYTQ5U0s1aXY3ZmJ4YVFzUzUvU2xKSlZU?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+t4lTGr5SKJCJ9PxI5hbPq+e50B4fJyKUR4hMfQyZ8nXrf2RKgimY+sUl6BrzWdt2RmAbiwFIaELsAgihVZbc0XYbDe3vejpuWWemceB8U7CIVYzfxpkvKksi2Shls486iGcuKrQNeb28r6QX7T0qrStG52xjCkeG+8m7FIxYY7NqtmJIxWp+2a3rmWcJAcSI811esC4U1JeghlEvKG8nMaO346l6/+TxL7E3HFJKagKe93ZVpiDOSDxVmMnn4gl/ZqXX9CQF+ucgv6jS3nfqlUKA1Ha2HkHC8DF9za6ugXH9DYq6unOuQzGIkji38pUTx2ITaygN22Q+44fYJnsl9xHO/TEJylD3r6IdXlDZXl8RXmheIQXtvUvGXiF+fI4dJxCXKO+qZifOVxu3+XNZ0hvxDZ9aj9wsSZlH4O+/jeFMedaPfdl2Ev3M5+kEdNMmIuqra9QipIyZ1DrQnfQEWsrEBjV0Bcgj39hYxXPu5iU8vw8vSXZLQaXiOYyFMbkithnDK1BHtHVwtDHXQFoI3gyEFo5AcVUjBgCcTsuk7pcHgYniV1BVDF0Tva5/G6NaIwSUu5XHv18SdjrAu9JIbvtrcVlYsWAiwNjGCzNL7g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0edc274c-dbcb-44c8-a697-08dc2d4cf6ff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 11:06:16.6443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHeHPhYuWXbGUMj0cG+YWhDP9oAC420lcqRlpSO+ayGJ/6tZSQok35r6l2xgH4b8KnnysLWwPateRDLYiK3ZdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6824
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_04,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140086
X-Proofpoint-GUID: wT0USVg7elRVoxuBCBKIAgrivTUs2SrQ
X-Proofpoint-ORIG-GUID: wT0USVg7elRVoxuBCBKIAgrivTUs2SrQ


> 
>> Setting the rtvol extsize at mkfs time or enabling atomic writes
>> FS_XFLAG_ATOMICWRITES doesn't check for what the underlying bdev can do in
>> terms of atomic writes.
> 
> Which is wrong. mkfs.xfs gets physical information about the volume
> from the kernel and makes the filesystem accounting to that
> information. That's how we do stripe alignment, sector sizing, etc.
> Atomic write support and setting up alignment constraints should be
> no different.

Yes, I was just looking at adding a mkfs option to format for atomic 
writes, which would check physical information about the volume and 
whether it suits rtextsize and then subsequently also set 
XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES.

> 
> Yes, mkfs allows the user to override the hardware configsi it
> probes, but it also warns when the override is doing something
> sub-optimal (like aligning all AG headers to the same disk in a
> stripe).
> 
> IOWs, mkfs should be pulling this atomic write info from the
> hardware and configuring the filesysetm around that information.
> That's the target we should be aiming the kernel implementation at
> and optimising for - a filesystem that is correctly configured
> according to published hardware capability.

Right

So, for example, if the atomic writes option is set and the rtextsize 
set by the user is so much larger than what HW can support in terms of 
atomic writes, then we should let the user know about this.

> 
> Everything else is in the "make it behave correctly, but we don't
> care if it's slow" category.
> 
>> This check is not done as it is not fixed what the bdev can do in terms of
>> atomic writes - or, more specifically, what they request_queue reports is
>> not be fixed. There are things which can change this. For example, a FW
>> update could change all the atomic write capabilities of a disk. Or even if
>> we swapped a SCSI disk into another host the atomic write limits may change,
>> as the atomic write unit max depends on the SCSI HBA DMA limits. Changing
>> BIO_MAX_VECS - which could come from a kernel update - could also change
>> what we report as atomic write limit in the request queue.
> 
> If that sort of thing happens, then that's too bad. We already have
> these sorts of "do not do if you care about performance"
> constraints. e.g. don't do a RAID restripe that changes the
> alignment/size of the RAID device (e.g. add a single disk and make
> the stripe width wider) because the physical filesystem structure
> will no longer be aligned to the underlying hardware. instead, you
> have to grow striped volumes with compatible stripes in compatible
> sizes to ensure the filesystem remains aligned to the storage...
> 
> We don't try to cater for every single possible permutation of
> storage hardware configurations - that way lies madness. Design and
> optimise for the common case of correctly configured and well
> behaved storage, and everything else we just don't care about beyond
> "don't corrupt or lose data".

ok

> 
>>>>> And therein lies the problem.
>>>>>

...

>>
>> That sounds fine.
>>
>> My question then is how we determine this max atomic write size granularity.
>>
>> We don't explicitly tell the FS what atomic write size we want for a file.
>> Rather we mkfs with some extsize value which should match our atomic write
>> maximal value and then tell the FS we want to do atomic writes on a file,
>> and if this is accepted then we can query the atomic write min and max unit
>> size, and this would be [FS block size, min(bdev atomic write limit,
>> rtexsize)].
>>
>> If rtextsize is 16KB, then we have a good idea that we want 16KB atomic
>> writes support. So then we could use rtextsize as this max atomic write
>> size.
> 
> Maybe, but I think continuing to focus on this as 'atomic writes
> requires' is wrong.
> 
> The filesystem does not carea bout atomic writes. What it cares
> about is the allocation constraints that need to be implemented.
> That constraint is that all BMBT extent operations need to be
> aligned to a specific extent size, not filesystem blocks.
> 
> The current extent size hint (and rtextsize) only impact the
> -allocation of extents-. They are not directly placing constraints
> on the BMBT layout, they are placing constraints on the free space
> search that the allocator runs on the BNO/CNT btrees to select an
> extent that is then inserted into the BMBT.
> 
> The problem is that unwritten extent conversion, truncate, hole
> punching, etc also all need to be correctly aligned for files that
> are configured to support atomic writes. These operations place
> constraints on how the BMBT can modify the existing extent list.
> 
> These are different constraints to what rtextsize/extszhint apply,
> and that's the fundamental behavioural difference between existing
> extent size hint behaviour and the behaviour needed by atomic
> writes.
> 
>> But I am not 100% sure that it your idea (apologies if I am wrong - I
>> am sincerely trying to follow your idea), but rather it would be
>> min(rtextsize, bdev atomic write limit), e.g. if rtextsize was 1MB and bdev
>> atomic write limit is 16KB, then there is no much point in dealing in 1MB
>> blocks for this unwritten extent conversion alignment.
> 
> Exactly my point - there really is no relationship between rtextsize
> and atomic write constraints and that it is a mistake to use
> rtextsize as it stands as a placeholder for atomic write
> constraints.
> 

ok

>> If so, then my
>> concern is that the bdev atomic write upper limit is not fixed. This can
>> solved, but I would still like to be clear on this max atomic write size.
> 
> Right, we haven't clearly defined how XFS is supposed align BMBT
> operations in a way that is compatible for atomic write operations.
> 
> What the patchset does is try to extend and infer things from
> existing allocation alignment constraints, but then not apply those
> constraints to critical extent state operations (pure BMBT
> modifications) that atomic writes also need constrained to work
> correctly and efficiently.

Right. Previously I also did mention that we could explicitly request 
the atomic write size per-inode, but a drawback is that this would 
require an on-disk format change.

> 
>>> i.e. atomic writes need to use max write size granularity for all IO
>>> operations, not filesystem block granularity.
>>>
>>> And that also means things like rtextsize and extsize hints need to
>>> match these atomic write requirements, too....
>>
>> As above, I am not 100% sure if you mean these to be the atomic write
>> maximal value.
> 
> Yes, they either need to be the same as the atomic write max value
> or, much better, once a hint has been set, then resultant size is
> then aligned up to be compatible with the atomic write constraints.
> 
> e.g. set an inode extent size hint of 960kB on a device with 128kB
> atomic write capability. If the inode has the atomic write flag set,
> then allocations need to round the extent size up from 960kB to 1MB
> so that the BMBT extent layout and alignment is compatible with 128kB
> atomic writes.
> 
> At this point, zeroing, punching, unwritten extent conversion, etc
> also needs to be done on aligned 128kB ranges to be comaptible with
> atomic writes, rather than filesysetm block boundaries that would
> normally be used if just the extent size hint was set.
> 
> This is effectively what the original "force align" inode flag bit
> did - it told the inode that all BMBT manipulations need to be
> extent size hint aligned, not just allocation. It's a generic flag
> that implements specific extent manipulation constraints that happen
> to be compatible with atomic writes when the right extent size hint
> is set.
> 
> So at this point, I'm not sure that we should have an "atomic
> writes" flag in the inode. 

Another motivation for this flag is that we can explicitly enable some 
software-based atomic write support for an inode when the backing device 
does not have HW support.

In addition, in this series setting FS_XFLAG_ATOMICWRITES means 
XFS_DIFLAG2_ATOMICWRITES gets set, and I would expect it to do something 
similar for other OSes, and for those other OSes it may also mean some 
other special alignment feature enabled. We want a consistent user 
experience.

> We need to tell BMBT modifications
> to behave in a particular way - forced alignment - not that atomic
> writes are being used in the filesystem....
> 
> At this point, the filesystem can do all the extent modification
> alignment stuff that atomic writes require without caring if the
> block device supports atomic writes or even if the
> application is using atomic writes.
> 
> This means we can test the BMBT functionality in fstests without
> requiring hardware (or emulation) that supports atomic writes - all
> we need to do is set the forced align flag, an extent size hint and
> go run fsx on it...
> 

The current idea was that the forcealign feature would be required for 
the second phase for atomic write support - non-rtvol support. Darrick 
did send that series out separately over the New Year's break.

I think that you wanted to progress the following series first:
https://lore.kernel.org/linux-xfs/20231004001943.349265-1-david@fromorbit.com/

Right?

Thanks,
John




