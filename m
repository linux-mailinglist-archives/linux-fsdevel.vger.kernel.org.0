Return-Path: <linux-fsdevel+bounces-13107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 281F286B427
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 17:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1142B1C20D58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 16:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96CA15D5CC;
	Wed, 28 Feb 2024 16:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lAn+4IhP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FZbeZVO3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4091C10
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136427; cv=fail; b=HWJn2wpNmdYy8Jhe3mdSpUpojjSdaNIpsnDtkZQ3cYjjUF7g1T921pQ3raiy+dzoEWKB7Vk88vcc/eBn5u0R+xPrlYCaNH5QZIOgsseZUCf9Qzgidm2cDhPYLQmF4jaO8qBdAmtRJjIFku5WcSp2ynliqQ81tbHT1d/I+rBsDZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136427; c=relaxed/simple;
	bh=iZGcdIy8RENmqC9OeiotetYcrTDmCp1flFTzuvI9QQc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=povoz1OSbCIRV+NtowGgz1ntPG/1nyvu+GF7QrFBazmisa93Ofc4QDpofWlCOBu4ZkGlf1D1vJI3KIIthBHvJtN9xf5cdUkmEBbM7q3CnWT+G6gunO/FZlLfPMvYhiUAYIVqptwTwWlc0AdNR+9952hoBblvRLMxw2cdUE6zpJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lAn+4IhP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FZbeZVO3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SEJ3kX007367;
	Wed, 28 Feb 2024 16:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=eGJZYlhfBHvHlNSlPYPmvJ98zew7lPBc9Sude18pa+g=;
 b=lAn+4IhPyyXmeseCen2kU1xiYbqi1JVm1vtdze2GiRLQE8tt0uYe+orebqyPoNYAr3Bj
 Rd/wYWNrTe6iHyzkJhErQ/Tn09vV76v2ZEyAT8otC3R4aqWCKtuCjy62KZWILA6CvYMF
 dw0xK7U0n6mtOto1c0jgnNprPUurGa1tblcDNPF2BObMOhDwTR6mzXWVTzQfFZr9cX58
 5vsS5JiKsff7E5wnsy9syZfByHEwPOfHHrPcumM9NfxJiMyGkGKaueGFwGhku7Esdjxp
 zo5lpeNRS+Ujq/NITthB5KPbdCiNIg6hoQvuFR+e3Bcjh/CYRwLLSebUGJHo+HTX1yG8 MA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf6ve2s2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 16:06:49 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41SErfer019197;
	Wed, 28 Feb 2024 16:06:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wgbdmxjfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 16:06:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0S72H85kjpwtJP+1ImGvU6AVlfHL19oPXEvj3MYICpLA7UUi92uND51hTATi3nw5lE6J4eXe5ZFd8z2NXbprxf/fOvGYCqScKlYcQ+q4g5E7QVomsF1Dm4fIxI5s5WXlOmQOn2hg2yddEkdd453Zgs/AheHawSq19i4j3Lhcik5WkTlpL1JKoG7bK2s8J1+2A4baWMnAZsDoxgce6Bpe+K6FdGfL7kwXO0kU/auj68jQ4cHn3Bmr3xMHIaBgUwKddUlN5PqTWjInsx4jINbs3l+3VSXajqTyLDu7iZx+Ad2AI8Vc2/9dvr9nILUS20fIXNyecC0o+hbGZyG3/Vsfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGJZYlhfBHvHlNSlPYPmvJ98zew7lPBc9Sude18pa+g=;
 b=kE894zxDyOEI0jaV3auEgn8PoVEXcQcgbjVBiSNi/JaSJd0Ah+q7O7iH197u4MrNFM1URPTH0U9/p2RA8ZuFe4nmaJVhan4aZHVVUN88CB0b5K7cZNop/zzs3Avvu/VcrEG+Zthwj/YwpcXbwbwdwW8q9LpIhxn8CwygQmgJgxpJAtOc81WQ8JQNeZ9kaxufJEvw8Ex9cDeDQoaEY3Bb57piJ+hJ71gGcT13UrS7v/6nkPqEGFGs0ntcAjKnRooX3xNtqJ8oRP3oHP8NDQFaj9wr+VUplbyjc+P+gpVgZMENxa6Hy5jnwivqELIsCsQtSDn6Tl/AKNnOkLkTsM7qug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGJZYlhfBHvHlNSlPYPmvJ98zew7lPBc9Sude18pa+g=;
 b=FZbeZVO3wj8wYI7fXR99OHMyn9SPzLRmJ0auaPj5fxFO6TBBBb+8hxFfBtv2llW8LfZ46v6OfmAulIKmtZdK7KFOm9kfH8b92Q0temjIx9XMoLA+fKa1Der3XV+bKK5NpMN/2uYZiMjDPBn7wMMo9d6byKVtgLB5TJETDHQEf3E=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN2PR10MB4269.namprd10.prod.outlook.com (2603:10b6:208:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Wed, 28 Feb
 2024 16:06:46 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%3]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 16:06:46 +0000
Message-ID: <b184a072-86ef-462b-a6da-c2537299aa59@oracle.com>
Date: Wed, 28 Feb 2024 16:06:43 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] untorn buffered writes
Content-Language: en-US
To: Theodore Ts'o <tytso@mit.edu>, lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
References: <20240228061257.GA106651@mit.edu>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240228061257.GA106651@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0524.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN2PR10MB4269:EE_
X-MS-Office365-Filtering-Correlation-Id: c60c20a3-8b09-4a73-9ab8-08dc38774372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1B0y2PePyi1xXEiVm5S1MjVQI5EtqY8Rc+hSyaisgpxDA2+D0/cFaram/Ekora7UXW2d8tMSOY2OoCKGNKbbq5e+8u7Mn4I6gHJKPxXmTRXhSgWQnHUQSUMsEue0ocNnGeKTyPB7+449pRfmo509HsmN9kd0ew849FsrPOjDTHlTxAcotomUGgfP5Cpw+SYr1pIgDJ0q1RsV4dDyqze9HTOegyl5q/fFyBBf7y/7IRG96AYgB4iH9k0nzyrVNnzhAY2KEoHZvA9kPCxGwbREx9hDM7Dtolmc30wv+XurdIjaOwQJ/ngp9UrwcLaFLoIYn9stz+1yuC+m4O/nN7Hskhm52HEHSZ7QYOzJl6X/ZiE1Oiz3HyHdqfNK8WvAMhyPGdXpHd4PJ7dgc32oDCVQ/YSWO0q/CAtCNEXv9Bcu4G8hCBggjVzLzGNwvOtoHGfD9u7fCAYACDkNTfr4xP4kKAqLUzjUuuRG2YvS32K90vkhjb0nBBkmttWqNe4rznqpTp2aKakYt6xJ4iYbptgTYGtJ0p0+04yFgl5w2xz4KDbKODMRbnNZuMbhItRY2YapkYESn8fMm2ayLIC24Acr6Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aUJ3dXNJQ1lPQjlSY0x2dVBqYUE2WTFSb1RRdExwaVFlcHZVRVNuM1NxYXIy?=
 =?utf-8?B?UlNJSEZMWGttcytJZVNMQ2pNOWZXMVlYMld6cE5MalZVZDduSDlYa3Y4RjlY?=
 =?utf-8?B?NTQxKzJla1pPREhtWUZjcmhHSnNTVXlxWkZGdXZQSGxobVlEODBXd3d0VnZz?=
 =?utf-8?B?eXpLN1NpaWNzTXdNc3pSTmhKYXZETnhjQURVNE9UUktGdnNHTm02K08xcXdG?=
 =?utf-8?B?RzFzRWtIR3VMcmZOZ2lZNzY0d0FVWjZxZmRFenFiWk9hSFoxTVJiVmxCOFFW?=
 =?utf-8?B?SXUrZFo0cUoyUk0yNTNZSkpLd2NaOThmcExNOVhWV2RtQTZRQTZqbHFFeGtO?=
 =?utf-8?B?c3VxcXdxdStNY0NFZWN1NzRaZWlCb0Rla1dpU0JabzZ0b2htekJrQnc5Y2Ju?=
 =?utf-8?B?SUVFdDlSRU82OGJ1QUlYMzZ6Q3JpRGJ3MWhSZ2wvcDkwRXZ1SmQ2alE5aTlm?=
 =?utf-8?B?Ym1KM2Y1TDF4dUd2VytzakNkSFZMT0o5SVRRclIxamN3ZW5kVEViRStDaUxi?=
 =?utf-8?B?M1R4Vm1nWmZKZ3RTdEVqUVBubUZMVHJ5QXVWVzRESXhrRVpTMGVOSjdMU1lu?=
 =?utf-8?B?cHJrTW9ETERPd0k1NVZzVzBWcE4zRldWeXJSeW9EcVZTejhnUFBGZGNhenVw?=
 =?utf-8?B?TkJ0MXkwWmRvT0NhV1U5SzVLV3hMT3BDYVduZTlwaktsUnRTVHRxNGNzV1pq?=
 =?utf-8?B?bXozcThkUDBVellUM3NVdnhsK2Z3V3BLSGEwSzJXaEQ5ZmF0WmJYQktOYnZr?=
 =?utf-8?B?MXUvWndUcHR0MkFHY0lySGIvQ3poNHgzS01xN2dhQXRMNDRaZGI0Q0Qwb3Y1?=
 =?utf-8?B?WndEZWRtaWxvS3ZkcDJnSFlkempFNEpKbFlZQ3l3M1NBcEM3YjVKNmUyS2Nv?=
 =?utf-8?B?ZkpFU2NvRS9tdjc2blZSZUR6ZzRhekZsMnRHeTNhVzZUVlVoV3h4UzFYc0Jo?=
 =?utf-8?B?akFYcGlGRE9iTzMybW1TNEsrd05HVk5GbHFidTZicWZkMnQ2T0RmSmxhdG9o?=
 =?utf-8?B?SURLbmo2ZTcrQnBDMkFJcStrY2tWQlVsMStyUXRQRjBtV1oxVVNxVGtsMzZR?=
 =?utf-8?B?ZXVKTmd4NHZzTVVqTndSSk9iaS94M01yM0ViaXplZ0lVYVJpYmkrTk5BRmNH?=
 =?utf-8?B?Wm1oSUZHUjQwRzg4RTR6d0MzU1NqMjRiQnlDRUpCM25zcUV6K3NSRkh3anNY?=
 =?utf-8?B?elkvakFMQkt0SjhET0FMd1F6N1hkQWc4YURnSXkrY29zdG44TnU1aW1pbnM2?=
 =?utf-8?B?UEVIbm9LUTZqNVlUT3o5Q01uNlJhTS9YZjJ1VlV3MWdDdU5VcVA1M2RFeUd2?=
 =?utf-8?B?d0pQUnZQNEtLTmxRVVpQd1pLVDFXREV2ZGFFVEV1Qm1jOTcrTGYrRkU3YTl6?=
 =?utf-8?B?K2FGRkJqd0hpV2xpS0UwL21TSDVTeWlSMXpwMldkdHF5NEpTcWQwQ1hzbWsv?=
 =?utf-8?B?dG1vUzI5VG1QNS9Eb1hmMlMwRzBhWDlucU1vbVkwOUJFQzBKZkt6cEdLMkMz?=
 =?utf-8?B?dWh6ZGV0dnZlSDJYd0xzUElhOGVlcFR5RjRWUDM1MktETEc1U1lKVWZ1OUZC?=
 =?utf-8?B?TWNReU5IdjZKcW03dE45TWNOVmhIM1F3ZXFGUjlMNEwzTGtsdllQcCs0OVFX?=
 =?utf-8?B?a1M1NUV1TStjcENOaFVRYm5ScnhvMlkyQllkU29ORHVGOUZQd3RCQzVUa3FJ?=
 =?utf-8?B?NkI5VUFsOU05Nm5hUS8xQjE0SHlhb0NGc1lOYkdpMG0wOXhMTHg2ZXpPbU9S?=
 =?utf-8?B?Zlp4eEMwYUNuQ0VYN3l5dSt4NEdDSy8vc0lxUlZXeWU4T0xKYkpZTC93U3ds?=
 =?utf-8?B?VXVSb3JZQitiTHRPalV0c3dsc2xndGFUcDN0Zm00T1N3NmRMclhNN2lqbWJx?=
 =?utf-8?B?U3c1VlM3aEV2YWRUMXVJbnBEeXYzMnE3SGhSSFFjdFhhd2ZtV0ZjK1pycHpP?=
 =?utf-8?B?VnNHRjRUdHk1bEVWcTY0NVE3eDE2SzlrbXkzK0pCdHo4VWxUZFVWQ3kzdEts?=
 =?utf-8?B?ZWN1dGpGNEM3ZEpGUEtES2RzNExpSlp0bWs3TjZPNUpUYkRqa2x4R3M3Vy8y?=
 =?utf-8?B?Y1VlcVNlbWlJRE9oWUFIOFgrY0ZHZ3FBUUx3RGlXQkpvbDBaa0UzV1diYm1x?=
 =?utf-8?Q?jcj5PTRWtLcluM8lNCbdI2fYq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sv+YspRLgEcJ5H6+2TPijs17CaqS8Rwywk8l8tP0PYojidd9Y55xwqRU++UkFJbdsz/KoemFF1Qx5PdYWF7kBZTunsEHQn/A3veWP/Kp1VS6nqlElnU7qLz0kXpO7537MKpjhG6JzU+gaFDXETKrNEqE/64log+hHsqO/61MaN5RiARkSETmteZBRVF8909FhJwDb4366xhdmn6oXl907ihEr4uFuVUwUfahvfyOlZhZzuGKpP/6Xnjt8WRk3dB4s1qOLt/oY1tj9zvIX5x1fl3jRMVgI+wHJOc7ZmtBuisWTVjOn85m2cjtBM7B2/mENBRZSUmvxZ5NZr20SNcYzgmzXTL7mZF2q15qQquYHW1pQ6XbF+556GuXpmjbuv6flua6k6yLGRiuigORdZ3q2D1skjhp4sjnmxiJ9FKqUt46VfA3H5gmBoulaPhIIoT8DXwfOkCd/1IPiO5d8LS6qt7Yw9Kt3/Bo4oriwuknMC1HaXjx2Imiz+z0H6xlaBRbWtDS9xiycsBD12AxB9RvUA8ZKrJ6NT3/QpSMQaKrR7x5OgrfMTuR/46sxiUfzNqYBfwnuBuA97qyDCxbe9oIXdWpQ7ccY3nLd6NnxNPs1SM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c60c20a3-8b09-4a73-9ab8-08dc38774372
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 16:06:46.5621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5tfx+w3wsZ5fpO8hD3EdpV2YOt4Pe3rcOrzfqFYbSATENLRv5buw55Y3+L6iozlLokYkDwDTWsvYVAANJ4uYGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4269
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402280126
X-Proofpoint-ORIG-GUID: 7ExHogW7k_gn1JR7qA4krSYlykGUS4AO
X-Proofpoint-GUID: 7ExHogW7k_gn1JR7qA4krSYlykGUS4AO

On 28/02/2024 06:12, Theodore Ts'o wrote:
> Last year, I talked about an interest to provide database such as
> MySQL with the ability to issue writes that would not be torn as they
> write 16k database pages[1].
> 
> [1] https://urldefense.com/v3/__https://lwn.net/Articles/932900/__;!!ACWV5N9M2RV99hQ!Ij_ZeSZrJ4uPL94Im73udLMjqpkcZwHmuNnznogL68ehu6TDTXqbMsC4xLUqh18hq2Ib77p1D8_4mV5Q$
> 
> There is a patch set being worked on by John Garry which provides
> stronger guarantees than what is actually required for this use case,
> called "atomic writes".  The proposed interface for this facility
> involves passing a new flag to pwritev2(2), RWF_ATOMIC, which requests
> that the specific write be written to the storage device in an
> all-or-nothing fashion, and if it can not be guaranteed, that the
> write should fail.  In this interface, if the userspace sends an 128k
> write with the RWF_ATOMIC flag, if the storage device will support
> that an all-or-nothing write with the given size and alignment the
> kernel will guarantee that it will be sent as a single 128k request
> --- although from the database perspective, if it is using 16k
> database pages, it only needs to guarantee that if the write is torn,
> it only happen on a 16k boundary.  That is, if the write is split into
> 32k and 96k request, that would be totally fine as far as the database
> is concerned --- and so the RWF_ATOMIC interface is a stronger
> guarantee than what might be needed.

Note that the initial RFC for my series did propose an interface that 
does allow a write to be split in the kernel on a boundary, and that 
boundary was evaluated on a per-write basis by the length and alignment 
of the write along with any extent alignment granularity.

We decided not to pursue that, and instead require a write per 16K page, 
for the example above.

> 
> So far, the "atomic write" patchset has only focused on Direct I/O,
> where this stronger guarantee is mostly harmless, even if it is
> unneeded for the original motivating use case.  Which might be OK,
> since perhaps there might be other future use cases where they might
> want some 32k writes to be "atomic", while other 128k writes might
> want to be "atomic" (that is to say, persisted with all-or-nothing
> semantics), and the proposed RWF_ATOMIC interface might permit that
> --- even though no one can seem top come up with a credible use case
> that would require this.
> 
> 
> However, this proposed interface is highly problematic when it comes
> to buffered writes, and Postgress database uses buffered, not direct
> I/O writes.   Suppose the database performs a 16k write, followed by a
> 64k write, followed by a 128k write --- and these writes are done
> using a file descriptor that does not have O_DIRECT enable, and let's
> suppose they are written using the proposed RWF_ATOMIC flag.   In
> order to provide the (stronger than we need) RWF_ATOMIC guarantee, the
> kernel would need to store the fact that certain pages in the page
> cache were dirtied as part of a 16k RWF_ATOMIC write, and other pages
> were dirtied as part of a 32k RWF_ATOMIC write, etc, so that the
> writeback code knows what the "atomic" guarantee that was made at
> write time.   This very quickly becomes a mess. >
> Another interface that one be much simpler to implement for buffered
> writes would be one the untorn write granularity is set on a per-file
> descriptor basis, using fcntl(2).  We validate whether the untorn
> write granularity is one that can be supported when fcntl(2) is
> called, and we also store in the inode the largest untorn write
> granularity that has been requested by a file descriptor for that
> inode.  (When the last file descriptor opened for writing has been
> closed, the largest untorn write granularity for that inode can be set
> back down to zero.)

If you check the latest discussion on XFS support we are proposing 
something along those lines:
https://lore.kernel.org/linux-fsdevel/Zc1GwE%2F7QJisKZCX@dread.disaster.area/

There FS_IOC_FSSETXATTR would be used to set extent size w/ 
fsx.fsx_extsize and new flag FS_XGLAG_FORCEALIGN to guarantee extent 
alignment, and this alignment would be the largest untorn write granularity.

Note that I already got push back on using fcntl for this.

So whether you are more interested in ext4 and how ext4 can adopt that 
API is another matter.. but I did consider adding something like struct 
inode.i_blkbits for this untorn write granularity, so an FS would just 
need to set that. But I am not proposing that ATM.

> 
> The write(2) system call will check whether the size and alignment of
> the write are valid given the requested untorn write granularity.  And
> in the writeback path, the writeback will detect if there are
> contiguous (aligned) dirty pages, and make sure they are sent to the
> storage device in multiples of the largest requested untorn write
> granularity.  This provides only the guarantees required by databases,
> and obviates the need to track which pages were dirtied by an
> RWF_ATOMIC flag, and the size of the RWF_ATOMIC write.
> 
> I'd like to discuss at LSF/MM what the best interface would be for
> buffered, untorn writes (I am deliberately avoiding the use of the
> word "atomic" since that presumes stronger guarantees than what we
> need, and because it has led to confusion in previous discussions),
> and what might be needed to support it.
> 

Thanks,
John


