Return-Path: <linux-fsdevel+bounces-26826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9569995BDAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 19:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28255B25597
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7871CFEB6;
	Thu, 22 Aug 2024 17:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mxot9EdI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mVxe3tN5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF146F2F3;
	Thu, 22 Aug 2024 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724348800; cv=fail; b=fIyZr+lDqKVxj0yBJldV3MG8uRnuO/ti7cutsRM7QARgl3KGB7iTArHvrY0jxqC3MUDYS3xXDc/4sHdacbJ4DM0BahtPUXQdr7JBPF07hFDl90aZBMVtUFh4DMt55yVLBTjC2+TmeqVHnDZ/QofKT2xIOWWGaJe9ItaFg5VdEHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724348800; c=relaxed/simple;
	bh=+F3G+ezE3BNMiLVDQZxdjqwJmdYGKdxubpcw98bjstE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LyzWlc2yV8kIJK32sZ0ZpGqi1RAr4lUn56ct1RHvIH+dRZYq23TQnSfOKjLvLBcxvTsq10HsgnAAp6ryW1Ei2UGZqMw4xbDNDpc8vscaFHR+CSzDDJ4PV+nCVi0awu/l2Je/JvSD1Tgizeytts+bimeVpRObCbS/vSEvh7zvm5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mxot9EdI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mVxe3tN5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MEQRiB015829;
	Thu, 22 Aug 2024 17:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=Ga97W+b+rOK28rmN3Mm5ZmP2oYLltVsF4hF6lwMHiKc=; b=
	Mxot9EdIn2AtEHeNKaXrLugu3xVosOWEKn5nHULnKXG9Wn99ype8Ahl394UggbrY
	6Rt6PhVxbhODySFa4gWQeChlWX+EMfR4RQLBdxBDLHlKd72yWVHW/cw9kAeLK1U7
	mu2qldgmRYbQbQZJt9y02tbUykZraWWuv0U9fIvvmvzrXIGLq4fXCDmDc39S3N2U
	GkNMyPkbOHiDcWU04v1b9DlOqZpBCRND9m/QUkgVqRp4QPdz+XNwg+E2pw6L0LhV
	YrFgYqs5w4Ekm8fCv3Xi0qhYxo0M/85nY8Dka1G8DgBMMLgL70NjklKUd41c9Dcd
	EO4B5bSmlxVKae3kShHsRQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m3dtx93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 17:46:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MHaVOM029034;
	Thu, 22 Aug 2024 17:46:24 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4169vn8c62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 17:46:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCSPcOkU+SnhophGqM4QsaAVM2mf1AcfWQW4ILztdAu9mcLppofuMbK1VUD+K+kJMrT3pQRNy7lFClz00+v7a3uH6PJ3cmDAJp7brOPcFqwOv0rPnMzQYSDuWEDQ9MdrTdV4fdi223g/gfJW/xy1FBr7zi6Mcz+kCf4NU27Rz4Z3bP0ruCXel6YTlVr5qWnyetxv+WLAMBBaxnYS3PPLLbi870OABfsSV0/0gQQo9M8IuXO77Zy9t/Mu5dxnj17GI9r2y7CgWHeXRPrzhEZF1rlTYe4jXYQ/if8WN75egxeOjanteUo5koBSba19aN8uldXsm+i9Y9eGl2HTkCnzdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ga97W+b+rOK28rmN3Mm5ZmP2oYLltVsF4hF6lwMHiKc=;
 b=tA8D6hVNSEvzg3ULULlX7e2WMmHO8f2mGkxntLeB0zeNupSUZcZDopNWeU5G8T79fKQRGC/FRWNNEfnizRKkIowsN0UflMLl3agoI5/OJRNxM7ZP2yJrzESbETkYio46PEHf55gtQO/H7SEhq4ouaqbMOS7Yfu0cOij2zNIVMAsytwvlq9Wt+fOasHvAZeho8QNO7SSYMYGxq+prItY4E5pPK+mOTH7DFZbBe5SEDLYOUSG68vPojFLqnSWVG17AXvtdV80pAN5RgqilMK4qyWX75ah/t991KPnzPT8q+Be6iIvaQtW4wz4M9RqQgZb6ChTUv2UFUoQRtIMcALX69A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ga97W+b+rOK28rmN3Mm5ZmP2oYLltVsF4hF6lwMHiKc=;
 b=mVxe3tN51G5tiogMVgzPKRrqWQwbjOtB3BVUzEaQzaLO8xa4Vks9vjiBnahgitbdpMOszSX85oKrB02LZO+VZ4efnI0GRkPKz9pksf7SR6JZlSkc4fyW8U2dUjmUFztQUX8tr6LmoCRg9EkClsxZlFfBGpv4Ewrdxc4pNigbtBM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA6PR10MB8110.namprd10.prod.outlook.com (2603:10b6:806:43a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.10; Thu, 22 Aug
 2024 17:45:21 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.7918.006; Thu, 22 Aug 2024
 17:45:21 +0000
Message-ID: <a2a0ec49-37e5-4e0f-9916-d9d05cf5bb96@oracle.com>
Date: Thu, 22 Aug 2024 18:45:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] xfs: Support FS_XFLAG_ATOMICWRITES for forcealign
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        kbusch@kernel.org
References: <20240817094800.776408-1-john.g.garry@oracle.com>
 <20240817094800.776408-5-john.g.garry@oracle.com>
 <20240821170734.GJ865349@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240821170734.GJ865349@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0033.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA6PR10MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: 720947f9-994a-4d89-d20c-08dcc2d23166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHc4eHJtYnoxZjlsR0tDYnpDa1pFQ3k1ZUhpQ1NqNmUzSnN6QzdZMzZTL296?=
 =?utf-8?B?T3g3R0ZmVnpkaXNzQ0ZQSjBsV1c3YVVRdGRsSHg4VzRmOGNLZ0dMenJ2cVNm?=
 =?utf-8?B?bFJ1MTVsSW5MOStDbGZydEhwWGFsNjNKaGtJUnFnbng5c21pRHBUU201WHph?=
 =?utf-8?B?b2NobDVEZk1wNjlneklVVEVYZUhQMkpNd3JLKzJCOHFmRVlzd2NidkhqMWRV?=
 =?utf-8?B?Q25lRGJPL00wdlkxVExiVDNENU1yVlY4Q2NrVGFWRzhPbnFNeFdTamV6SUN1?=
 =?utf-8?B?T0dpYkUxMjRDTVE3bGl4Nkw5bTIyTTdoaFBRVVRrQ0EvSk10eVZMUXZBbkRP?=
 =?utf-8?B?cXJRY1BXcHpqVCtsbUNmY3VOT20wSHRXQkl5NCt1MmpYT3UvS3o3MjB0SHhS?=
 =?utf-8?B?Qi9aM3ZxWjdrb2Y0cUFuSW94MUJRMmU0SXQvL242N2t5OFJUbEpyQUxFbmJR?=
 =?utf-8?B?UlI4a1BwOFlMemJuUkR3citENXNxbUUyeE1nZnl6Z05YM3RQMkp5b0FGNXZn?=
 =?utf-8?B?NUkrSlNXOFBUQU5jdEExOTJEVGc2WGEyS0pXTWJ4eS9NQXF1aXhwN3M5UW1B?=
 =?utf-8?B?aDllT0pVY0lFeTJ2WU5mRU9pRjRwdjBJZFdqNlBaZGJsRDduUGkxT0dXREJO?=
 =?utf-8?B?eEJhWm03OHBDVnhVS0hxT1pzVDh1aWJpeUwzV0drSzR4dmRXYy9nQ3pPNkN3?=
 =?utf-8?B?YXp0L1BNVFhoWFdsNHpQSDIremJDdEFjdHBBeFRLNm0zcldWZUZJcjBSL2xx?=
 =?utf-8?B?QkROWEEyQkFDYndvRWZIUkp0NnhoL0JsbUl5L3VuYml4VkZkUUc3YnBWNjhS?=
 =?utf-8?B?RHp0Ky9jcjl1c1VWV0tpa3pZenAwcGsvbnRjZnN5Skg2Q3hzQTNnSlJqbU1M?=
 =?utf-8?B?R3JpNDlJdTNDeUhSeDBiQ0JiUllVZ0FWSXh0QmJFdEt0M2k0TTRRMjI3ejd6?=
 =?utf-8?B?dzR4YlRMR205OG15V2k1RzVoaitZN2JQK3FkeEJvUkdNMWFlNjQ1dGM1d0pi?=
 =?utf-8?B?YXlqZ2xMT3RkeWMxZlZQalFBTzZKY1BLc1RHWVFPSVBlYnFId0lpUlVMdHR5?=
 =?utf-8?B?NFU1M0hWeG9WaitTMlJtN1VTQkpMRjVjQk9VOHZtZEl3Umw4Y2dNbEZmSHVt?=
 =?utf-8?B?TDJxaDhUaWdEUHdhNG9lbXVyVEt5NENpNGdxc2VrdGxTanlEQTh1WVZhdjdU?=
 =?utf-8?B?YmVIV0s1VE5JNlNNL0pCZUN1NWdnRGtEdElPSDNwL0xTUVQxQXplZVN5cUsw?=
 =?utf-8?B?Y084NXdZZkxVRzgxbjRRenRjMEtnZ0M1VjFxRDR0by9MRzQ2T3RtTjlpbVVF?=
 =?utf-8?B?eWF5RmI2QmZ4QnFnYWhnc3czSHhiRklrYkozYm5kcmNQSVQ3anpSb21GRzFO?=
 =?utf-8?B?eVZ5a3hranhYbEI4UnpFSk80eGkxSjNlcUx3VnEvYS81M3pZMTlkT0hvd2h3?=
 =?utf-8?B?RFA1dHB5dmg5R1IvV2FZd0xSUEt0QWFIOWhIdEhRRVZCejdPalFpYWFzb1pv?=
 =?utf-8?B?V2VFQldFdUJNR3B4a3Iyc0ZMY0RKU3RIdFMrMzFhWWJOOFk3SDJMNWNBQlp0?=
 =?utf-8?B?V0xIU0lLb2wxUDFReEdYK0FpK2xVaHhvQzhIaVJkYWhjVGhhZ1Z3NkxhRUNO?=
 =?utf-8?B?N0NYQjNHanZUYlNUV0lnbFRyTUJEdC9DdU84aGJVeDFwdWRlVEZkTjFDdW1V?=
 =?utf-8?B?b25EVm81TzVLUTlUVllXZWgxNXowb2QvT2h0RHVJdUpiSm54akFqOWVaeU5x?=
 =?utf-8?B?bFptWVpDNVA4UUpFVFEwMjdQTXJRWVl5TkJoZ2xMWVVoZlJTYUFmUDA5aDly?=
 =?utf-8?B?d2tjRDVkNXVHMmQreHZNUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzlHdFVhWWxZTjRobWhlVG01YVZwSFVzbnJFaFVlRjdMcDU4WkhnNFZteEpo?=
 =?utf-8?B?bEJCSVJCWGJXcUp6eWx0Mmh0dUJzVXc1YnRhMXBnOU91NGRBN1YvTmIvVkl0?=
 =?utf-8?B?TldXZWtYaEtvaDFUbjVxbVNrajAyL0RKZzZjQ1J2VVhjTVFBS1htMlk0MlZw?=
 =?utf-8?B?cHNoSDZJZU9kK3ZnbGtUWE4rVFZIbWNtOG0vam1TbU1ETmh2bTR3b045Uzk5?=
 =?utf-8?B?T3MwZ1NwZkI0WCs1cmZHcDdqbjZzTkduVEFpUk1acTdiWFdXWjJ6Z2dETWNh?=
 =?utf-8?B?dHNWT0xtdndqbmZmbzFDRzdIS0NxKzVuQ1BlUmNSSndIZ3NlcGpjcU1obWVl?=
 =?utf-8?B?NHdiK0JmSWZ6cXVHbm91aVlYeTBHUkFOck02MzVueUtCWVljSzAwSlBmT1Qr?=
 =?utf-8?B?QXgrM0hyQ21sS2xpNFM1bVh1M1NhT1dNdU9PSFRuL05LcDFtSElVV3ZjY1Jp?=
 =?utf-8?B?UHhSd1ZSWEF2azVkcWtIcnV3WHBYUy93dHhOVmZFOEhEbFY5Z0xyMDB6Yk5L?=
 =?utf-8?B?blVFcVplYlFoVnQzM2xHMG1YN1ROTmZmZ2RhV1JqRmkvcDQ1cXRSclRZVHRS?=
 =?utf-8?B?VURTcDgxdnpiTlRudnJybGpqT0dBWkhpZFpIdHlCZExHUnVMZHRTazJNR2xB?=
 =?utf-8?B?d1JXTWM4WTFCY21yTHVyYUVjWkRIaHI1QVdzdDJHc2ZrYWVWbjB1YUJPZGNp?=
 =?utf-8?B?NlArdnRzdDVyRjYzV2tZa3BDR0x5TzlYT3NGcHJML2Y5Q1JjanZrUUlXY2tq?=
 =?utf-8?B?RDFaMVYwVzVsdjA4TVpYQndXbWJ1V3lWSkRGblNnUEZjNXVQS29ZazJYWDJ6?=
 =?utf-8?B?WFM5VDE2SEdqVFA3SHZFczNqdk1JR3lURW1aZ0hNd3dZY0ZPd1laUnplUDk5?=
 =?utf-8?B?cExob3M1dy9qbE9xV2JnODM2MmgrUmlXUlNFbDdnVEFMSlBSNWt3djhpNWVK?=
 =?utf-8?B?Qng3ZU55aG5naXZBRmpRQnFlbm5mZm8xQ1NRdllvcWs4UFNleW8zQVk0eG93?=
 =?utf-8?B?Q1JxMVJFRWNuTVR4aExMSXpLeGFhdzQ0UkF2bWN4YUdna2xZby85QVlMRVha?=
 =?utf-8?B?cWRoVHpNSW5hb3A1N2tnbjdpZnUwcC9ZdU00TDBNaTI2QnBnYkNmZGNIa1Nu?=
 =?utf-8?B?cWFMZzN2UFcwYmFSZGEzRzhRWFA0WmJGUHZJRmxvWkhoTlVkM3k1Zk5xR2I3?=
 =?utf-8?B?WmpQSjVGN2ZQeGlZWVdobVVhdzdlVnFzK282bnBJaEpwR0xWT2k5MytuZ01o?=
 =?utf-8?B?TmdFT25QNm9UTkR2b3FDS3MxTG92alJ5SjJQZmNra1pZTmdWM080NWVqaTdE?=
 =?utf-8?B?VGtJcFZXeXYwWFNldm9sWEFDUVlCZllNZ1ROakdRSUhweGhISWlSZlJLdTgw?=
 =?utf-8?B?UlJsSDZSbGl2WTBpUGJ6TGsyaUYvaDlSMVE4V1RFSy9YSUovbmswMU1Xd3JB?=
 =?utf-8?B?bHh6SGtaUVY3ek56UmFpWmZkRjBjRUw4TUxYWktFUnVzdUF2d0ZKTDM4bnhM?=
 =?utf-8?B?ZmNIakc5aTViK28wVXEyTC95TDNOT3Y1NnVrWjJObkZYdS90dUdRQXNQNVFF?=
 =?utf-8?B?LzY5cTBFOHREcmhmUmVmVjg4aTBrWDZCZUFtcDVYK2NqTnNVaStJcjVEODNw?=
 =?utf-8?B?TlJDSXFqaGxlaDFrakRSb3FxOTJaYlc0TlVlRUlNOGp2ckhiZ2lwR2EyT3pu?=
 =?utf-8?B?UitGZ2Q2UWJjaHVvKzQ2ZE1UMVdjemlmYXhRK1pTYlUzeTNIclR4aEEzTzBn?=
 =?utf-8?B?ampuelJwV1JQWUQvckF1Q3l5VW1UdFZvbnFaakhXTXF4aW1Xelpsemw3UUIr?=
 =?utf-8?B?Y0Z6bU1od0xiRE9acDUrK0UyN3VBOHRzQmFHcVJib2hvTFFIc3c0RDgxRVRk?=
 =?utf-8?B?WE1ndCtTWkZXUE1vVzN3YTByRFRwMnliRzFSdXVQMlZLZXJxeDZieTAvL3Fs?=
 =?utf-8?B?aFNBTjZBeEt4aVoraEQvWU1aRFA2VjhjZmFVbDBnVE90M3U1MzlucGREanhi?=
 =?utf-8?B?ZUYydzlMcmpPbS96S3lZL2ZWTHNoL1FUTDJHREJmV0luSkFQSmpKeWhMVDdv?=
 =?utf-8?B?YmxMTHE3TVp1L2FIRyt0cnpSekRMTEd1a0NSNGE4TUpZek5Wb3ZhMk1YeWRZ?=
 =?utf-8?Q?BOH+siwzogmFfbWUnlcsKaUIP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Wk2y7fJ4VjW8dhe28istedwSTdYFro8XZheCpU8+JPLs5FA/vd7114OizWUZjtvb25r1mVcsDeHoaEL7/NcKSlNQfXhj2xd9in3+RrFUgeltGsXBPJQXGCqhMFrkjxtxbqWLA9d+A+qQt6849+lz/sDwxx8hcDqt1q95B7SKj8N6EV4v3nwncZS2vKw1WV/Op3G9Dh8rupYbSxlxZVkhF9HYJ2WQWzvCwzx5exvhgJP4JMtzAV3qeY397FESiVw27i/92HKhJ9/GUzv350kvU7nUkLG5Pr6t7g7ST5bK3VvKM5MXKFzeNe0n1oMawgnjv+94owmDlybrTsRI3KztG0Z24/R6i8LZMz2Z6pGTrE5Jd7QggQS5ibXy7eleksvYPndgnOt617rpHU3srSJaCXmCBLyf6WS5qWJZ7D+dDly9Ywu0O+Mzw3QPVuX6SYdqGOgL5MkPAnnQ5LeblGlwIrxZLF9Sk079v1HSjWrzoujexAFACPAEJ1w/aIWhSm4vfzdjIYBM/WRknR3SJylz2pTBytKBa2xUWqT8QUqtooznZGH+VdWfvnRp3E3rf6ZxUSNNqkekOv5R8fLaX12jyM9OpIAAKfJ6/G6kdLlvjP0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 720947f9-994a-4d89-d20c-08dcc2d23166
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 17:45:20.9958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urMjhYUv7S3wkn4Mg0/5tZMiCE7j6bvIDuTbgryLLACwdjXNqkD7SBuKybuOK2JsFtTAaFR3wU9ybV3omSA3zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8110
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_11,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408220133
X-Proofpoint-ORIG-GUID: ZbEjdTSMkixEkuoJHaJA-pqm0D4nLCFz
X-Proofpoint-GUID: ZbEjdTSMkixEkuoJHaJA-pqm0D4nLCFz

On 21/08/2024 18:07, Darrick J. Wong wrote:
> On Sat, Aug 17, 2024 at 09:47:57AM +0000, John Garry wrote:
>> Add initial support for new flag FS_XFLAG_ATOMICWRITES for forcealign
>> enabled.
>>
>> This flag is a file attribute that mirrors an ondisk inode flag.  Actual
>> support for untorn file writes (for now) depends on both the iflag and the
>> underlying storage devices, which we can only really check at statx and
>> pwritev2() time.  This is the same story as FS_XFLAG_DAX, which signals to
>> the fs that we should try to enable the fsdax IO path on the file (instead
>> of the regular page cache), but applications have to query STAT_ATTR_DAX to
>> find out if they really got that IO path.
>>
>> Current kernel support for atomic writes is based on HW support (for atomic
>> writes). As such, it is required to ensure extent alignment with
>> atomic_write_unit_max so that an atomic write can result in a single
>> HW-compliant IO operation.
>>
>> rtvol also guarantees extent alignment, but we are basing support initially
>> on forcealign, which is not supported for rtvol yet.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/libxfs/xfs_format.h     | 11 +++++--
>>   fs/xfs/libxfs/xfs_inode_buf.c  | 52 ++++++++++++++++++++++++++++++++++
>>   fs/xfs/libxfs/xfs_inode_util.c |  4 +++
>>   fs/xfs/libxfs/xfs_sb.c         |  2 ++
>>   fs/xfs/xfs_buf.c               | 15 +++++++++-
>>   fs/xfs/xfs_buf.h               |  4 ++-
>>   fs/xfs/xfs_buf_mem.c           |  2 +-
>>   fs/xfs/xfs_inode.h             |  5 ++++
>>   fs/xfs/xfs_ioctl.c             | 52 ++++++++++++++++++++++++++++++++++
>>   fs/xfs/xfs_mount.h             |  2 ++
>>   fs/xfs/xfs_super.c             | 12 ++++++++
>>   include/uapi/linux/fs.h        |  1 +
>>   12 files changed, 157 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
>> index 04c6cbc943c2..a9f3389438a6 100644
>> --- a/fs/xfs/libxfs/xfs_format.h
>> +++ b/fs/xfs/libxfs/xfs_format.h
>> @@ -353,12 +353,16 @@ xfs_sb_has_compat_feature(
>>   #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
>>   #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
>>   #define XFS_SB_FEAT_RO_COMPAT_FORCEALIGN (1 << 30)	/* aligned file data extents */
>> +#define XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES (1 << 31)	/* atomicwrites enabled */
> 
> Do you ever see test failures in xfs/270?

Well it wasn't with forcealign only. I'll check again for atomic writes.

> 
>> +
>>   #define XFS_SB_FEAT_RO_COMPAT_ALL \
>>   		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
>>   		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
>>   		 XFS_SB_FEAT_RO_COMPAT_REFLINK| \
>>   		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT | \
>> -		 XFS_SB_FEAT_RO_COMPAT_FORCEALIGN)
>> +		 XFS_SB_FEAT_RO_COMPAT_FORCEALIGN | \
>> +		 XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES)
>> +
>>   #define XFS_SB_FEAT_RO_COMPAT_UNKNOWN	~XFS_SB_FEAT_RO_COMPAT_ALL
>>   static inline bool
>>   xfs_sb_has_ro_compat_feature(
>> @@ -1097,6 +1101,7 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
>>   #define XFS_DIFLAG2_NREXT64_BIT 4	/* large extent counters */
>>   /* data extent mappings for regular files must be aligned to extent size hint */
>>   #define XFS_DIFLAG2_FORCEALIGN_BIT 5
>> +#define XFS_DIFLAG2_ATOMICWRITES_BIT 6
>>   
>>   #define XFS_DIFLAG2_DAX		(1 << XFS_DIFLAG2_DAX_BIT)
>>   #define XFS_DIFLAG2_REFLINK     (1 << XFS_DIFLAG2_REFLINK_BIT)
>> @@ -1104,10 +1109,12 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
>>   #define XFS_DIFLAG2_BIGTIME	(1 << XFS_DIFLAG2_BIGTIME_BIT)
>>   #define XFS_DIFLAG2_NREXT64	(1 << XFS_DIFLAG2_NREXT64_BIT)
>>   #define XFS_DIFLAG2_FORCEALIGN	(1 << XFS_DIFLAG2_FORCEALIGN_BIT)
>> +#define XFS_DIFLAG2_ATOMICWRITES	(1 << XFS_DIFLAG2_ATOMICWRITES_BIT)
>>   
>>   #define XFS_DIFLAG2_ANY \
>>   	(XFS_DIFLAG2_DAX | XFS_DIFLAG2_REFLINK | XFS_DIFLAG2_COWEXTSIZE | \
>> -	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_FORCEALIGN)
>> +	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_FORCEALIGN | \
>> +	 XFS_DIFLAG2_ATOMICWRITES)
>>   
>>   static inline bool xfs_dinode_has_bigtime(const struct xfs_dinode *dip)
>>   {
>> diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
>> index 1c59891fa9e2..59933c7df56d 100644
>> --- a/fs/xfs/libxfs/xfs_inode_buf.c
>> +++ b/fs/xfs/libxfs/xfs_inode_buf.c
>> @@ -178,7 +178,10 @@ xfs_inode_from_disk(
>>   	struct xfs_inode	*ip,
>>   	struct xfs_dinode	*from)
>>   {
>> +	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
>>   	struct inode		*inode = VFS_I(ip);
>> +	struct xfs_mount	*mp = ip->i_mount;
>> +	struct xfs_sb		*sbp = &mp->m_sb;
>>   	int			error;
>>   	xfs_failaddr_t		fa;
>>   
>> @@ -261,6 +264,13 @@ xfs_inode_from_disk(
>>   	}
>>   	if (xfs_is_reflink_inode(ip))
>>   		xfs_ifork_init_cow(ip);
>> +
>> +	if (xfs_inode_has_atomicwrites(ip)) {
>> +		if (sbp->sb_blocksize < target->bt_bdev_awu_min ||
>> +		    sbp->sb_blocksize * ip->i_extsize > target->bt_bdev_awu_max)
> 
> Can this multiplication trigger integer overflows?

I should just use xfs_inode_alloc_unitsize()

> 
>> +			ip->i_diflags2 &= ~XFS_DIFLAG2_ATOMICWRITES;
> 
> Ondisk iflag updates must use transactions.

I want to change this.

The idea was to runtime clear this flag in case the bdev cannot satisfy 
the FS atomic write range, but that does not work.

> 
> Or you can fail IOCB_ATOMIC writes if XFS_DIFLAG2_ATOMICWRITES is set
> but the forcealign blocksize doesn't fit with awu_min/max.

I'd rather just not set FMODE_CAN_ATOMIC_WRITE

> 
>> +	}
>> +
>>   	return 0;
>>   
>>   out_destroy_data_fork:
>> @@ -483,6 +493,40 @@ xfs_dinode_verify_nrext64(
>>   	return NULL;
>>   }
>>   
>> +static xfs_failaddr_t
>> +xfs_inode_validate_atomicwrites(
>> +	struct xfs_mount	*mp,
>> +	uint32_t		extsize,
>> +	uint64_t		flags2)
>> +{
>> +	/* superblock rocompat feature flag */
>> +	if (!xfs_has_atomicwrites(mp))
>> +		return __this_address;
>> +
>> +	/*
>> +	 * forcealign is required, so rely on sanity checks in
>> +	 * xfs_inode_validate_forcealign()
>> +	 */
>> +	if (!(flags2 & XFS_DIFLAG2_FORCEALIGN))
>> +		return __this_address;
>> +
>> +	if (!is_power_of_2(extsize))
>> +		return __this_address;
>> +
>> +	/* Required to guarantee data block alignment */
>> +	if (mp->m_sb.sb_agblocks % extsize)
>> +		return __this_address;
>> +
>> +	/* Requires stripe unit+width be a multiple of extsize */
>> +	if (mp->m_dalign && (mp->m_dalign % extsize))
>> +		return __this_address;
>> +
>> +	if (mp->m_swidth && (mp->m_swidth % extsize))
> 
> IIRC m_dalign and m_swidth can be set at mount time,

I thought that these were fixed at mkfs time, however I see that the 
comment for xfs_update_alignment() mentions "values based on mount 
options". And we are reading mp values, and not sbp values, which is a 
good clue...

> which can result in
> inode verifiers logging corruption errors if those parameters change.  I
> think we should validate these two congruencies when setting
> FMODE_CAN_ATOMIC_WRITE.

That would make sense.

> 
>> +		return __this_address;
>> +
>> +	return NULL;
>> +}
>> +
>>   xfs_failaddr_t
>>   xfs_dinode_verify(
>>   	struct xfs_mount	*mp,
>> @@ -666,6 +710,14 @@ xfs_dinode_verify(
>>   			return fa;
>>   	}
>>   
>> +	if (flags2 & XFS_DIFLAG2_ATOMICWRITES) {
>> +		fa = xfs_inode_validate_atomicwrites(mp,
>> +				be32_to_cpu(dip->di_extsize),
>> +				flags2);
>> +		if (fa)
>> +			return fa;
>> +	}
>> +
>>   	return NULL;
>>   }
>>   
>> diff --git a/fs/xfs/libxfs/xfs_inode_util.c b/fs/xfs/libxfs/xfs_inode_util.c
>> index b264939d8855..dbd5b16e1844 100644
>> --- a/fs/xfs/libxfs/xfs_inode_util.c
>> +++ b/fs/xfs/libxfs/xfs_inode_util.c
>> @@ -82,6 +82,8 @@ xfs_flags2diflags2(
>>   		di_flags2 |= XFS_DIFLAG2_COWEXTSIZE;
>>   	if (xflags & FS_XFLAG_FORCEALIGN)
>>   		di_flags2 |= XFS_DIFLAG2_FORCEALIGN;
>> +	if (xflags & FS_XFLAG_ATOMICWRITES)
>> +		di_flags2 |= XFS_DIFLAG2_ATOMICWRITES;
>>   
>>   	return di_flags2;
>>   }
>> @@ -130,6 +132,8 @@ xfs_ip2xflags(
>>   			flags |= FS_XFLAG_COWEXTSIZE;
>>   		if (ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN)
>>   			flags |= FS_XFLAG_FORCEALIGN;
>> +		if (ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES)
>> +			flags |= FS_XFLAG_ATOMICWRITES;
>>   	}
>>   
>>   	if (xfs_inode_has_attr_fork(ip))
>> diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
>> index e56911553edd..5de8725bf93a 100644
>> --- a/fs/xfs/libxfs/xfs_sb.c
>> +++ b/fs/xfs/libxfs/xfs_sb.c
>> @@ -166,6 +166,8 @@ xfs_sb_version_to_features(
>>   		features |= XFS_FEAT_INOBTCNT;
>>   	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_FORCEALIGN)
>>   		features |= XFS_FEAT_FORCEALIGN;
>> +	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES)
>> +		features |= XFS_FEAT_ATOMICWRITES;
>>   	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
>>   		features |= XFS_FEAT_FTYPE;
>>   	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
>> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
>> index aa4dbda7b536..44bee3e2b2bb 100644
>> --- a/fs/xfs/xfs_buf.c
>> +++ b/fs/xfs/xfs_buf.c
>> @@ -2060,6 +2060,8 @@ int
>>   xfs_init_buftarg(
>>   	struct xfs_buftarg		*btp,
>>   	size_t				logical_sectorsize,
>> +	unsigned int			awu_min,
>> +	unsigned int			awu_max,
>>   	const char			*descr)
>>   {
>>   	/* Set up device logical sector size mask */
>> @@ -2086,6 +2088,9 @@ xfs_init_buftarg(
>>   	btp->bt_shrinker->scan_objects = xfs_buftarg_shrink_scan;
>>   	btp->bt_shrinker->private_data = btp;
>>   	shrinker_register(btp->bt_shrinker);
>> +
>> +	btp->bt_bdev_awu_min = awu_min;
>> +	btp->bt_bdev_awu_max = awu_max;
>>   	return 0;
>>   
>>   out_destroy_io_count:
>> @@ -2102,6 +2107,7 @@ xfs_alloc_buftarg(
>>   {
>>   	struct xfs_buftarg	*btp;
>>   	const struct dax_holder_operations *ops = NULL;
>> +	unsigned int awu_min = 0, awu_max = 0;
>>   
>>   #if defined(CONFIG_FS_DAX) && defined(CONFIG_MEMORY_FAILURE)
>>   	ops = &xfs_dax_holder_operations;
>> @@ -2115,6 +2121,13 @@ xfs_alloc_buftarg(
>>   	btp->bt_daxdev = fs_dax_get_by_bdev(btp->bt_bdev, &btp->bt_dax_part_off,
>>   					    mp, ops);
>>   
>> +	if (bdev_can_atomic_write(btp->bt_bdev)) {
>> +		struct request_queue *q = bdev_get_queue(btp->bt_bdev);
>> +
>> +		awu_min = queue_atomic_write_unit_min_bytes(q);
>> +		awu_max = queue_atomic_write_unit_max_bytes(q);
>> +	}
>> +
>>   	/*
>>   	 * When allocating the buftargs we have not yet read the super block and
>>   	 * thus don't know the file system sector size yet.
>> @@ -2122,7 +2135,7 @@ xfs_alloc_buftarg(
>>   	if (xfs_setsize_buftarg(btp, bdev_logical_block_size(btp->bt_bdev)))
>>   		goto error_free;
>>   	if (xfs_init_buftarg(btp, bdev_logical_block_size(btp->bt_bdev),
>> -			mp->m_super->s_id))
>> +			awu_min, awu_max, mp->m_super->s_id))
>>   		goto error_free;
>>   
>>   	return btp;
>> diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
>> index b1580644501f..3bcd8137d739 100644
>> --- a/fs/xfs/xfs_buf.h
>> +++ b/fs/xfs/xfs_buf.h
>> @@ -124,6 +124,8 @@ struct xfs_buftarg {
>>   	struct percpu_counter	bt_io_count;
>>   	struct ratelimit_state	bt_ioerror_rl;
>>   
>> +	unsigned int		bt_bdev_awu_min, bt_bdev_awu_max;
> 
> Please add a comment here about what these mean.  Not everyone is going
> to know what "awu" abbreviates.

sure

>> +
>>   static int
>>   xfs_ioctl_setattr_xflags(
>>   	struct xfs_trans	*tp,
>> @@ -511,9 +554,12 @@ xfs_ioctl_setattr_xflags(
>>   	struct xfs_mount	*mp = ip->i_mount;
>>   	bool			rtflag = (fa->fsx_xflags & FS_XFLAG_REALTIME);
>>   	bool			forcealign = fa->fsx_xflags & FS_XFLAG_FORCEALIGN;
>> +	bool			atomic_writes;
>>   	uint64_t		i_flags2;
>>   	int			error;
>>   
>> +	atomic_writes = fa->fsx_xflags & FS_XFLAG_ATOMICWRITES;
>> +
>>   	/* Can't change RT or forcealign flags if any extents are allocated. */
>>   	if (rtflag != XFS_IS_REALTIME_INODE(ip) ||
>>   	    forcealign != xfs_inode_has_forcealign(ip)) {
>> @@ -554,6 +600,12 @@ xfs_ioctl_setattr_xflags(
>>   			return error;
>>   	}
>>   
>> +	if (atomic_writes) {
>> +		error = xfs_ioctl_setattr_atomicwrites(ip, fa);
>> +		if (error)
>> +			return error;
>> +	}
>> +
>>   	ip->i_diflags = xfs_flags2diflags(ip, fa->fsx_xflags);
>>   	ip->i_diflags2 = i_flags2;
>>   
>> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
>> index 30228fea908d..0c5a3ae3cdaf 100644
>> --- a/fs/xfs/xfs_mount.h
>> +++ b/fs/xfs/xfs_mount.h
>> @@ -300,6 +300,7 @@ typedef struct xfs_mount {
>>   #define XFS_FEAT_NREXT64	(1ULL << 26)	/* large extent counters */
>>   #define XFS_FEAT_EXCHANGE_RANGE	(1ULL << 27)	/* exchange range */
>>   #define XFS_FEAT_FORCEALIGN	(1ULL << 28)	/* aligned file data extents */
>> +#define XFS_FEAT_ATOMICWRITES	(1ULL << 29)	/* atomic writes support */
>>   
>>   /* Mount features */
>>   #define XFS_FEAT_NOATTR2	(1ULL << 48)	/* disable attr2 creation */
>> @@ -387,6 +388,7 @@ __XFS_HAS_V4_FEAT(v3inodes, V3INODES)
>>   __XFS_HAS_V4_FEAT(crc, CRC)
>>   __XFS_HAS_V4_FEAT(pquotino, PQUOTINO)
>>   __XFS_HAS_FEAT(forcealign, FORCEALIGN)
>> +__XFS_HAS_FEAT(atomicwrites, ATOMICWRITES)
>>   
>>   /*
>>    * Mount features
>> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
>> index b52a01b50387..5352b90b2bb6 100644
>> --- a/fs/xfs/xfs_super.c
>> +++ b/fs/xfs/xfs_super.c
>> @@ -1721,6 +1721,18 @@ xfs_fs_fill_super(
>>   		mp->m_features &= ~XFS_FEAT_DISCARD;
>>   	}
>>   
>> +	if (xfs_has_atomicwrites(mp)) {
>> +		if (!xfs_has_forcealign(mp)) {
>> +			xfs_alert(mp,
>> +	"forcealign required for atomicwrites!");
> 
> This (atomicwrites && !forcealign) ought to be checked in the superblock
> verifier.

You mean in xfs_fs_validate_params(), right?

Thanks,
John

> 

