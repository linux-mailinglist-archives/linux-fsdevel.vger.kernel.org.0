Return-Path: <linux-fsdevel+bounces-39089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 027A1A0C3D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 22:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6CDB1889296
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 21:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965A71D63DE;
	Mon, 13 Jan 2025 21:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cQioIY7i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M9h2nyDe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C28146A66;
	Mon, 13 Jan 2025 21:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736804126; cv=fail; b=sNfTgywMX1lkUZGgFY5XO1PvOzVTxHy0UD52KHN9GC50gZGDJ8GkgewZOTDRDLG9mn0eymZNqXuqo724duzeGSOci8fvTaNqpgita1xSp5UPdscZ2rrqtIZWYgTQ8Lt/LE4TiH7fDyD3fQNbbyWsDbu2ab0dc90FgwOmGxmhPgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736804126; c=relaxed/simple;
	bh=qwsIhEfC5neQvQ+n5hnHJSy07kdr2eFL/KmqvrPb2BE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KM9xh7hc7KkXxajxe2Qi0bwrNgmkYjobdCs6OaHQjksqQpimdKiNgk7zZjJinb8hdTWxhFIZXjxyoUgmPsRMLA8Xb0KedaGR/d/zNv5kKVzaN6+300WdyEu54K3A9v9zkCguFRxij+UTwDtG5G5fv2OXKxSO6KgzL/qeVPWlWE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cQioIY7i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M9h2nyDe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DHMru6032646;
	Mon, 13 Jan 2025 21:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=WPt0CjpxrTaEqWxSkQHibZy+8DYuYa2YoB2hmDfU8+s=; b=
	cQioIY7i1TVEjBHqk6JlxcC4v0PcKOxZdqLU9/4miOBkHKlpNOFwkWc4MhTOqHDF
	j3ksBk8tisFHHNq2GBLfbpVuS2DIFVMw8mta1+ZSpdvSquTLjRIgQ7Tn20KNNQvp
	Fv/QXSA4mRIIylknzjsZ+73APxVnUiII+UZaDGpV4JVqQICGq+cyBqTE5r6Tuh5d
	I/K57vP464NWP1s5yOU9nS0xhI1wRFKw2NkcHADnqMod8quLlvfz/7BfjMp9iqPo
	1s82GrXOfb1xnREfguuzABvX/I22pAhbEoGK37W//tph8Rprxsex+C94y6eGuo1N
	HYZ8xtRNnlt92injUoq4ow==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443g8sckp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 21:35:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50DLKlcP038991;
	Mon, 13 Jan 2025 21:35:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f37gcs9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 21:35:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5sMXbxjHA5/fneGWL346BADHm1Lslo6Vnqi6yHw1V1pmcz+XfNdPfysVAAgG2ev86VTNefG4k4xEGC2v0vJNpfB5P1I5rbugNf4alC/cukT1Qp2MGAuq9LXmCd7CtcYD4NcMOlWj53dd0/AJ4PDZPObdFPO6Hj6QB+BnSXzGqyvE4Ma1zUq5P2n9Vs3Fx49TyXlCazvYkqnXpmh/h2stvzRwdlsP2huucDHAJV0xIQQS5jgzazOxzggQSctXJ7F/Goz3nH7Bcz2A3ewtmj7zve6lgpQicxNB4B7IiRBjBckHsJJVUjaYWvqWKu4eym3CA6zzi9zhyFYQWx4j27rEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPt0CjpxrTaEqWxSkQHibZy+8DYuYa2YoB2hmDfU8+s=;
 b=KmnHDcitqJrHOlpk8Tpgpg87nFeRFsCthBN1kWiLVyLI7eGzh6Coy3hh2SxlR+55sRTWIY514VG+ZWUI3Clkq2aEkCxmwmXNpOJansQvm+XHSEPubnP3y/D6h2qma8R/hbo7tjmSjFaJC1Rnh3SF2fEJyRjsXyxTUsv2EvFx6DM32hJJ7NJE10lnLf8MNpD27LSv7/B+BQQCWQd5B4LBiRa95isAzS+yHGalQYpbJvxAhwc3jEq4zso+CURxj5gtKlRZ5n21230DxTDXRrAgcTvd1wMXosFAn+GSwEqdgBBKjufcN0CyzkuK/bMqtzFY+RxU5jxnCDQgDXGzzZ1qjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPt0CjpxrTaEqWxSkQHibZy+8DYuYa2YoB2hmDfU8+s=;
 b=M9h2nyDe3LV77nNwpqg0BxJ8SM0rc/Qq4ZZ4zH0OL+BAce3D7lFx/+f4sUXn4zQg0l0YKCMh+wzenHKQLm64qUJPpEUkjhXOsvfqS4CXbcwwV/TtGk/xUQ4zAYSlJjalWDf5yEOopepSLAn6cTdM/QTraYhzHu6yWRp6HXMXIRc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4656.namprd10.prod.outlook.com (2603:10b6:a03:2d1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 21:35:05 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8335.011; Mon, 13 Jan 2025
 21:35:05 +0000
Message-ID: <ef979627-52dc-4a15-896b-c848ab703cd6@oracle.com>
Date: Mon, 13 Jan 2025 21:35:01 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] iomap: Lift blocksize restriction on atomic writes
To: Dave Chinner <david@fromorbit.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com
References: <20241204154344.3034362-1-john.g.garry@oracle.com>
 <20241204154344.3034362-2-john.g.garry@oracle.com>
 <Z1C9IfLgB_jDCF18@dread.disaster.area>
 <3ab6000e-030d-435a-88c3-9026171ae9f1@oracle.com>
 <Z1IX2dFida3coOxe@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z1IX2dFida3coOxe@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0506.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4656:EE_
X-MS-Office365-Filtering-Correlation-Id: a97202b6-094e-4b3e-45d9-08dd341a24d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFJIRkdNMWgwano0b3BFTE50cHYzS0JvZFIzdncxcFRmQVZjaHN5QVVHWi9G?=
 =?utf-8?B?cytiNWZqSkNRMk1UWTlGQnF6bmVFSW4wZ3U3L0hadVF3RDVJRVR2ZUorUnUy?=
 =?utf-8?B?cFVTby8wNFhOYjRubWhCczBpaVdodjEyZkZ4TlI2RGpEUlZSVEpsdzRJOUgz?=
 =?utf-8?B?cVJHSXU4b3gwMnZ6YTJFQm9nOXIzcEVPcWxJUjg5UHZ2SkQyWmljZlVkU3Z6?=
 =?utf-8?B?ODBURFVNZ2lCNzJ4cll5WGpNQ0xYOEZpRkJvWkQ3d0ViV2JlRGlBUDBLY09S?=
 =?utf-8?B?Y0NTbjdaTHQ4SlhmelhEenR2RmtEM1pRNzdmSjR1WGhTdW9qZHR3N0pMYUtY?=
 =?utf-8?B?TGhiWmlMdVFaelZMdHlNOGtneXZGYjRJOE16NEgxR3pYZTY3VHRBVVJHcUp1?=
 =?utf-8?B?SWZ5Q1hTeE03WmRlMGVNblgxT0NIZzdLUEc3d09sU1JENzFXeGwwVWNoN1RO?=
 =?utf-8?B?ZG9FK2RaTlljdU05MUdIRXk4VjRwUjQxcU54RXhIRkpHTEdZTjZHZStKQmU3?=
 =?utf-8?B?VmcvSTVpQXB1U0RJeVAvZmJtVGV4MjhZbjlEclhUMVFCWXZLTHN3SnFoMER4?=
 =?utf-8?B?RFBIbTIyUkZmdnkzTHZYSDRpeGZpZDRhWGJjSm1YeURIb1Myc1lINmJDQmow?=
 =?utf-8?B?OGhvdDQvN2JOOGRFZzMwbmVkMUt0czdBK1BrZzE1dCtGeVAybldkZlkwMklC?=
 =?utf-8?B?bUo5ME1mOWE0aTFOWDJXQVJGSDhVL3hWRGUzR05JYWs4d1V4dTFBSWxSWGJI?=
 =?utf-8?B?TzIwMFJrdStMaDdjd3Z5dnQ1dWhvL1RCWnViTXJkb3AwZFdWd1MwUm1WM21u?=
 =?utf-8?B?WnduK1VSY3JEbnowNk45bkZxaVI3cUtiVXNzL1pLWEpOUFFOcTg3bnI1Wkk0?=
 =?utf-8?B?WTRucEIzOW9tdXVVUUdCOFQrbEZnVDY0NCtpdDl2QWdmdkl5Q1NGeVdYUEFD?=
 =?utf-8?B?VzdNdkZRdXdLUnhaWE9PaW40M2RzUUNhaHFCMGVoaHZ5OXdscnljU2NTalV3?=
 =?utf-8?B?QXFETEREMTJPdUxLZFovMVFrR213V2lqL0ZudFdKYlhtMi9RSEtEc1JVU1Nv?=
 =?utf-8?B?bTZJd01HNExPMHBGcjZhMzNGV1hJMCs2WHhyNTU5OFpRNFc0L0MzYnA5eDNC?=
 =?utf-8?B?a2xkQ09WUG1yS0xlYWpjYjJTa0h1L0QzNnhJNVVMQXFsVHRLRk9NU2NoZzYz?=
 =?utf-8?B?bFd3TG1ZeSt4cTNSTCsvQit6dnU0S1I2TW0rS21KVVovT0MrK0xRTjNnRUFX?=
 =?utf-8?B?RVAvSkhyR1hRaXVYbXlyeVhTenV2emVodFViYzNiY04wdHZhSWxjdTBNOUVG?=
 =?utf-8?B?RFdYanlzZ0RHTlhJNWY3K3hVUk5GcVZRb1BwYUEwVDBYNG4rNlh6djY5dS9q?=
 =?utf-8?B?L1lvVUJSK0pDaG84d1hVV1dPWm1yeXdDZGp1WUQxQk1uZmdCQXBDeHRENTli?=
 =?utf-8?B?TG9GZjZqYzBLUk5wd3dKNkgxMHA5eXoyc0t0ZEtSaU5VWmtUbEYwV29IY1gz?=
 =?utf-8?B?S1F3QWtiMGxWaVFEeFFSTXJxNkw2TnRkU29JNUk5enhJcjRxdXAzdWYyMndS?=
 =?utf-8?B?SXdGZ05YWkZiOEhXL0JZVStzVWVkTHlSSkdEclRCQkdpa2pzL05vcVpKZExK?=
 =?utf-8?B?eHBjSkU5dDRQWFFocHhIaU5mRy9JTlZ1dmR5emZzZnVWY1Y3TnBJK004R3gx?=
 =?utf-8?B?dDRVU1paK0pTYmdrTHlPSWZXZ1orRGIrQ1dWdVd2Ym5wckRpeUErQ2VZdTFT?=
 =?utf-8?B?UVRLY2pmUExnZ3RuMmFKVTFGQ0JXL0lFTWc1cGlvNS9VdGplTkJyY0Y5NHZY?=
 =?utf-8?B?ckord2E4TU5lOWhnY1lhWWloS29nVWZGUW1zcGUyQzlacG5hRzNKQlZEYzN1?=
 =?utf-8?Q?OwwCl7LodXXnr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzZyY25PZjkyL3ZObU1qVHpNL01aWTdlRXI5eTdjN3JOdVM1KzJwcFlKMy9v?=
 =?utf-8?B?UGFCK1BRcjVZTmpjNThZSmhJWVFwOVVwMmVPVFhDa2FXLzdtM0ZybFJ5L001?=
 =?utf-8?B?bHFXMHQ2VmsvNm1jR0NVU2FWdjBFWkQ4VE5HaENTbXg0amN2NFFYNlZULzJG?=
 =?utf-8?B?K0dXamQ0dk51UWI4OFlGZ1BlYmZxc1hNSFJwdEJuKzh6RnA4QmtmWHFvQWR3?=
 =?utf-8?B?VmZwRGw5SWFnRVpRd2VIa2pWdFlnUjRmYU5Vdjh4LzcvWVlRSGYrTlBGZFlz?=
 =?utf-8?B?SjI0NUxEcnhid0paWlRKTDVMeVlrSjhpUVhwUjZaYWtkVUpWM1phL0tON1hZ?=
 =?utf-8?B?cUo0cmViZEpzc1hHbnd0Q09SSDhnWk45WW55Zi9XMUVLV3Y2dG1uT1FpYWtS?=
 =?utf-8?B?dWRlbWNzK09DQWxmSGZsTkVsQ2RtYkpnNFdUKzhYRnd4bGdaRmpNWEFQT0s2?=
 =?utf-8?B?OHYzOE9BNHlFcDJ6dHNmUFJKeUxrWDVZR2l5Ry93NlZ3R3VJTHAxcFVFbm55?=
 =?utf-8?B?dmVRYkk5c0FzMitlcE9YK0tYcDg4WGRoTnBLQThWQnZpSHMycjRibFNOT25r?=
 =?utf-8?B?SjZjdkR2MCtUUi9oQkZaV1NaemphVTFaOHdzZjhhNDZQbmd4U0d1b2szN1Rw?=
 =?utf-8?B?ZUtzVnQ2alNWSHQ4QWV6ZkRpYk10QXlGbDhMODBqb0prVG9tb3FLQnl0WGhB?=
 =?utf-8?B?Q0poZjduZjFydUJzOUNpTGJRUlJwTU1teWFMOENLTmxYeEt0NkxmMnhlSTMv?=
 =?utf-8?B?TStTazFKK0dOTUtWUG9UUDF2UW5zMHRZenRNb09Jd1B3a1R1dXliRFdkRTVU?=
 =?utf-8?B?RzBVaWNQWCtXN0duQ01OeVVVWXIzT0R4c0tPcWdkN3pLb0Z5WmZoa2JodE5z?=
 =?utf-8?B?bVZPRXNrNHl1dmhYQnh1Vk1qVEZZcDZ5dXRLT0RQeVBhNTVQcWM4ci94L3Nw?=
 =?utf-8?B?dnV6ZDM4K2VueGhhYjNpbHorbllJaW5aa1VnM1NIdmFmemo1NmRaQWpidmlD?=
 =?utf-8?B?RTBhd2owZVhyeWhQUmdoOGVYUFgvUzlNc1NjM3B5VTUwN3NQV05GMzFmVkR5?=
 =?utf-8?B?dC9ab3B6UE1RWjI0Q2FvQ0dsREZ5MkxOTkErb2drMHViWXhuanRURzJxVDBI?=
 =?utf-8?B?dlc5eGtiVVBkRlN2dTZvSnQrMkY0SzVLLzlrVTFYNm1LcWtleGVmRXF4VDBJ?=
 =?utf-8?B?dllKa1BER1RrRjd5cmwyQk9LamNlbnBONmgzaXBwLzhLTW52Tk9OUndDemdl?=
 =?utf-8?B?VFVFZTcybDBRSFJPTzNpMlo4aGJCaW12UlFxckJ5ZkZDWVJCcDc4b3p4SkdQ?=
 =?utf-8?B?d0xOK0NWYVVhVXp4QmV4RnA2SksxK1hsWk1SZUxiMXNCUU91TEE4N3lNRFBI?=
 =?utf-8?B?Y0xpY0E0ZStpaE5XQ0pRZ3VEU2h0OVJWWXRscUMvWkRCWk9nLzhiaGRyTjh5?=
 =?utf-8?B?TzRLcEQ2R0ZoNTdQVkhWL0Zwek0wcUE1VnVwWG95SUVnc0hvSHJmbWczMDhh?=
 =?utf-8?B?TTY3S0RwUzAyUTZkREdCc3h6aVNZQWRhSG5RTUJNcG84NVN4SFQyeFZmc1RZ?=
 =?utf-8?B?YjV6S242eDBEZmhyRGdVZzBQS3FYbHNPOFZxUWJ0ZlY4ZWVEcC9vMmRjaElJ?=
 =?utf-8?B?LzZCTEhQNmNSMlNGTkpYdzl2VkpoQkR6M0lQWGpSdjdlVGR2eXJLcExXU0lo?=
 =?utf-8?B?dXpyVitCM0NwVG1DNk5mTFQwbGhDTnJMMjVoWWNqbEcxdnQ2MW9pNmtqSmM0?=
 =?utf-8?B?Wm1IVkszd0xuRDBoYWZLUzZKOUJ4R3FGeUJYMDdLSXRhQWFpWFBXVzRKVXpS?=
 =?utf-8?B?NENWNWdzbjZDZWNSTEVLTGRaUWxnWEdtSGRYYTBYdmY3R0FHOTB4eHVqelkv?=
 =?utf-8?B?M2hRaVh2ZDlyZ2xpcjdrTXBsVnBNbk96L0QxVEgwb0c3QlFJTmJkQUo0Ulla?=
 =?utf-8?B?ZHBBZXU3blJyd0xtT1I3V21aQnNVV0VLcU5HNGlNMENmTjdzS1cza3ljRTZj?=
 =?utf-8?B?VW51Vm5Pd3RsL29EYmxVQTluMzd3eWtXT0NNblhiNm5sa1hkd2lrbWR0OFY0?=
 =?utf-8?B?Qmc2UFRJOFA3Q0lEcTB4WTlCVmFpQzQ3a0FMamVnQnZHKzJoVEROd1FWeXhB?=
 =?utf-8?B?NnBEZ1ZqM3ZnS2l4ZVJ0aGdyckJGcDhobmpLNklVL3RrcFhMQWV6RG9Bc3JR?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PHH/coqbsYqjQShHAGlJhtUmCbt6+SYWgnOpIRBi8yJptqLOec6qFgIcj2t7thh/KteYhiJM4aC0YkMGJqb/5zSdBtBDIrKAz352wxrQVkLFwU/ydU0OycYGGXS73dC2QEYcNvwkOAFox2htnHu0Qe3/mebk580h9gfi+8E9mZFq9wVUon52sdaGNCODW+jl+IehtvEiU2AQKbqiCbdtq5mpQJ15XERvaPKgP9It8h20b4kynTdpGXCM1h6v7kFkFnA3FW+FFXjMqWaG9NOLojmLvywLQhpUXdIEVTlscIwkLWlucJzcGihNsU090C7CpATwaThiL85OJEARw2eYwjSkMMohERZxvl3ZHQ5MVbSXxroUM6o0fUyeJLrQ3mmIAd/wRdpsOe1fNDdxeHRscXszSLQefgATk1h+3cWDa/k/tOPv+S5hcaoxjsm3PpOhyPVfw2q81mbdZuY8HnliKFmlS8F0EnnIdI6rDSq9q0qlVwq4LwImhehAvMNRSrY60kZXwrYmqu1vFKEBjFLbJXe80STcICU9lpkfyUpcKE3VD7BEW3Vf2QQ9kX8VPDfEvcXdYRfAsTZq2pgMs7AwSXH6vjXrvS1LGofRvkPncZM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a97202b6-094e-4b3e-45d9-08dd341a24d1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 21:35:05.1967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLMD+oz5HZtbrcu298Ix3hZRMHwXzistLW9GiTr4lhEGpEjzliBrjpbanCxGQPJmQxFZqW942f/lKfdNkSmmfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-13_08,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501130170
X-Proofpoint-GUID: VdrJZhi7mKYXihYwlBhkeG4BJAsnUcEg
X-Proofpoint-ORIG-GUID: VdrJZhi7mKYXihYwlBhkeG4BJAsnUcEg

On 05/12/2024 21:15, Dave Chinner wrote:
> On Thu, Dec 05, 2024 at 10:52:50AM +0000, John Garry wrote:
>> On 04/12/2024 20:35, Dave Chinner wrote:
>>> On Wed, Dec 04, 2024 at 03:43:41PM +0000, John Garry wrote:
>>>> From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
>>>>
>>>> Filesystems like ext4 can submit writes in multiples of blocksizes.
>>>> But we still can't allow the writes to be split into multiple BIOs. Hence
>>>> let's check if the iomap_length() is same as iter->len or not.
>>>>
>>>> It is the responsibility of userspace to ensure that a write does not span
>>>> mixed unwritten and mapped extents (which would lead to multiple BIOs).
>>>
>>> How is "userspace" supposed to do this?
>>
>> If an atomic write spans mixed unwritten and mapped extents, then it should
>> manually zero the unwritten extents beforehand.
>>
>>>
>>> No existing utility in userspace is aware of atomic write limits or
>>> rtextsize configs, so how does "userspace" ensure everything is
>>> laid out in a manner compatible with atomic writes?
>>>
>>> e.g. restoring a backup (or other disaster recovery procedures) is
>>> going to have to lay the files out correctly for atomic writes.
>>> backup tools often sparsify the data set and so what gets restored
>>> will not have the same layout as the original data set...
>>
>> I am happy to support whatever is needed to make atomic writes work over
>> mixed extents if that is really an expected use case and it is a pain for an
>> application writer/admin to deal with this (by manually zeroing extents).
>>
>> JFYI, I did originally support the extent pre-zeroing for this. That was to
>> support a real-life scenario which we saw where we were attempting atomic
>> writes over mixed extents. The mixed extents were coming from userspace
>> punching holes and then attempting an atomic write over that space. However
>> that was using an early experimental and buggy forcealign; it was buggy as
>> it did not handle punching holes properly - it punched out single blocks and
>> not only full alloc units.
>>
>>>
>>> Where's the documentation that outlines all the restrictions on
>>> userspace behaviour to prevent this sort of problem being triggered?
>>
>> I would provide a man page update.
> 
> I think, at this point, we need an better way of documenting all the
> atomic write stuff in one place. Not just the user interface and
> what is expected of userspace, but also all the things the
> filesystems need to do to ensure atomic writes work correctly. I was
> thinking that a document somewhere in the Documentation/ directory,
> rather than random pieces of information splattered across random man pages
> would be a much better way of explaining all this.
> 
> Don't get me wrong - man pages explaining the programmatic API are
> necessary, but there's a whole lot more to understanding and making
> effective use of atomic writes than what has been added to the man
> pages so far.
> 
>>> Common operations such as truncate, hole punch,
>>
>> So how would punch hole be a problem? The atomic write unit max is limited
>> by the alloc unit, and we can only punch out full alloc units.
> 
> I was under the impression that this was a feature of the
> force-align code, not a feature of atomic writes. i.e. force-align
> is what ensures the BMBT aligns correctly with the underlying
> extents.
> 
> Or did I miss the fact that some of the force-align semantics bleed
> back into the original atomic write patch set?
> 
>>> buffered writes,
>>> reflinks, etc will trip over this, so application developers, users
>>> and admins really need to know what they should be doing to avoid
>>> stepping on this landmine...
>>
>> If this is not a real-life scenario which we expect to see, then I don't see
>> why we would add the complexity to the kernel for this.
> 
> I gave you one above - restoring a data set as a result of disaster
> recovery.
> 
>> My motivation for atomic writes support is to support atomically writing
>> large database internal page size. If the database only writes at a fixed
>> internal page size, then we should not see mixed mappings.
> 
> Yup, that's the problem here. Once atomic writes are supported by
> the kernel and userspace, all sorts of applications are going to
> start using them for in all sorts of ways you didn't think of.
> 
>> But you see potential problems elsewhere ..
> 
> That's my job as a senior engineer with 20+ years of experience in
> filesystems and storage related applications. I see far because I
> stand on the shoulders of giants - I don't try to be a giant myself.
> 
> Other people become giants by implementing ground-breaking features
> (e.g. like atomic writes), but without the people who can see far
> enough ahead just adding features ends up with an incoherent mess of
> special interest niche features rather than a neatly integrated set
> of widely usable generic features.
> 
> e.g. look at MySQL's use of fallocate(hole punch) for transparent
> data compression - nobody had forseen that hole punching would be
> used like this, but it's a massive win for the applications which
> store bulk compressible data in the database even though it does bad
> things to the filesystem.
> 
> Spend some time looking outside the proprietary database application
> box and think a little harder about the implications of atomic write
> functionality.  i.e. what happens when we have ubiquitous support
> for guaranteeing only the old or the new data will be seen after
> a crash *without the need for using fsync*.
> 
> Think about the implications of that for a minute - for any full
> file overwrite up to the hardware atomic limits, we won't need fsync
> to guarantee the integrity of overwritten data anymore. We only need
> a mechanism to flush the journal and device caches once all the data
> has been written (e.g. syncfs)...
> 
> Want to overwrite a bunch of small files safely?  Atomic write the
> new data, then syncfs(). There's no need to run fdatasync after each
> write to ensure individual files are not corrupted if we crash in
> the middle of the operation. Indeed, atomic writes actually provide
> better overwrite integrity semantics that fdatasync as it will be
> all or nothing. fdatasync does not provide that guarantee if we
> crash during the fdatasync operation.
> 
> Further, with COW data filesystems like XFS, btrfs and bcachefs, we
> can emulate atomic writes for any size larger than what the hardware
> supports.
> 
> At this point we actually provide app developers with what they've
> been repeatedly asking kernel filesystem engineers to provide them
> for the past 20 years: a way of overwriting arbitrary file data
> safely without needing an expensive fdatasync operation on every
> file that gets modified.
> 
> Put simply: atomic writes have a huge potential to fundamentally
> change the way applications interact with Linux filesystems and to
> make it *much* simpler for applications to safely overwrite user
> data.  Hence there is an imperitive here to make the foundational
> support for this technology solid and robust because atomic writes
> are going to be with us for the next few decades...
> 



Dave,

I provided an proposal to solve this issue in 
https://lore.kernel.org/lkml/20241210125737.786928-3-john.g.garry@oracle.com/ 
(there is also a v3, which is much the same.

but I can't make progress, as there is no agreement upon how this should 
be implemented, if at all. Any input there would be appreciated...

Cheers


