Return-Path: <linux-fsdevel+bounces-13433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B8B86FC6C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 09:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4232815A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 08:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB013715F;
	Mon,  4 Mar 2024 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nyfXAyqV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qUAfR5/k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4701C199BC;
	Mon,  4 Mar 2024 08:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709542186; cv=fail; b=d5x2vosDqGlMVKXUnjtiRa0J+YmIsAhvuBKV1ij0zcC3W0iBLZUK2eI8XncqeI1/Onecs9V6euO6ANGZQ+abDmU0Q4mS23X1Azb5uITuy73cwW3Zamuo9uJo2sDv+d20DKFcMnKVA2MCupafG8xfg3HaDwHySi3/T89FshD5+PU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709542186; c=relaxed/simple;
	bh=zlVIo4XXZKFSXGAaEsjQnPjUvKDMtZd5qnCr2FuUQ6Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DQYERXykliKdA/o7dOvvVvkwQ/Nh1PbwdhIjERNiHEeLU7CcUh0NMJNH9aQK2nqdj1QXJxExGYRpPdi12g7Z4twa5wPytuQdSrKEutoZO/sk4I2ax/0su1hmdtAngVvQStO411pV6DLk6rTZd6/I7Xq2eErLNezC5BV8gUwW/ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nyfXAyqV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qUAfR5/k; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4247hs5G027385;
	Mon, 4 Mar 2024 08:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=9lkoq1FF14znl73CrKRxoqpJBUcDUZ1S0Rn5HtT+GDY=;
 b=nyfXAyqVKkg2y7IYt1KM2HBlW1XZDDanq4KzRW1L8ShP6CnyCCjFr981OOX0PNy/egtt
 3PsS+ZSeZO0piJj5ngzPeifAqMFb+RmPmVc5G706FJCDR3lrOFrtFtmZf2WXSRSW7qWw
 A38qf1FFdEClEVC74cy6LEN7dk+v4+ocmFRUNuXLADbms24viKqpSIgoHcczPtM6Ewub
 XeefhxPntzVubiwBHMfQjmi387Mr27WQeHmZkjCa8h0hAi/oKBsC1I7JqqgTG9/ltJ5g
 eyeCl6iGNwtS1nWXg0ozP9yJTGNnvkEijyMx87pz69/MQFA2hdH+m84k2uw0ugxbHQAx vw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkuqvam05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 08:49:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4246o5bR015925;
	Mon, 4 Mar 2024 08:49:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj5qf3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 08:49:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWTUvAdaJi/4Nnhi22xW2p/yHLbRY2R8Tgi7TcflzJbsezyZjE53J5HYY3T24542nJiCzupyPEtOHhyQWSMb0DOpYXXxAng1OvNw7UxblFpkjbRN0nAoCgVXq/m8S8l2nBp2gtZ7WpAg8cB59CA02a/zxfHFjfK3yyewCW+vxwIyJIoT2BNGvgnad8CYaLrMYJQjgDvBA9bzd7UqANXclJ7HS2V+vz4+oMIZ3gwNqdihE4Mk0OIAOjJxSW2hXB6hH4bnkcGbgQNw8K/uuUHvYrnbvghwALR+DbWpHqtKF28/vtxA5gmx99j7fXCwOBBytZP807/lSQo+YEApDSONfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lkoq1FF14znl73CrKRxoqpJBUcDUZ1S0Rn5HtT+GDY=;
 b=mJLskZ1Jo1SwxcsWnkAEjwwaQvqKvj5Cx/WdaU3+9KQbI3uEVr6c5C3i8lWMPedFilxEeDmPQJn/P0dI4XeOb7KJDm5J+gZLoL87E6I89VLXo2D2u5OUIFk9+ExB3eafLKC7qRUbDqwXvTWwY5Awoiflpm/j7Tf/zWxeZf/XMwozyevu1dlgWqUE9RwgjmIl7lpcDtx11Wtj7la2zQifW+kHU5QGUx5qKGoXsyYD8/a8o78ctsdvp1UkakTEHu65vNm15h2jWthiXa5RShuGy5c6ci+JAtgTcOSZvu6hlSiV+lmyxZzg6pA877lS1y0ZPCYtu+ZWECC+2+vy19rqdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lkoq1FF14znl73CrKRxoqpJBUcDUZ1S0Rn5HtT+GDY=;
 b=qUAfR5/kSYUlYckG7nRL0LDMb/bZDWIVUYfFZiZ6zpGFNvqrBjczZHvMlhpWQ22FzPKnobVcPnA+9qZYzB04pBXoKF6zbXkf+41U4o0JGK39NZ2qMF6dbVMyMSRaz7LRuNoDa/5l2oIKl6IWPOyfpw0OpAj2IvumAeqO85By4zw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB7557.namprd10.prod.outlook.com (2603:10b6:a03:538::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 08:49:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 08:49:16 +0000
Message-ID: <7ca900f8-2d19-44dc-9241-6208b155d950@oracle.com>
Date: Mon, 4 Mar 2024 08:49:12 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/8] iomap: Add atomic write support for direct-io
Content-Language: en-US
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Luis Chamberlain
 <mcgrof@kernel.org>, linux-kernel@vger.kernel.org
References: <87frx64l3v.fsf@doe.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87frx64l3v.fsf@doe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0095.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 93106790-f02a-4b48-e7c8-08dc3c27f950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	O2Ropm5Skj7vIEyl7/UNMzJY3sXDIDUxZBsBYBG7cQpIO6k2loEImPm6gDtx1jRNM6Y1wVMllrdmm9/GfkPskvRUgkQxYA2MCtj5vzs/VpgrxbrKcKPeutLXWnZIEPbhd0SGoi/nB1HSo5tVjylUB5d7RMlkkhJjz5jCn2LccTpxse5/2ym/pCyJEuHayPdy/g72Zbdxg1+PdNLRD9vk3jPX0nmIc0dZ3PBdSKxVmMa1AGG5hDLB0WNRKlXdo0SxiiX46EFaEgr5zyJBb8a0mAukoCy4sIm+wgtwodWsUfIvMqMXTXVgkPnkuy2xzInDGmrCzmyYLzSFjc2LOvz8EGQ0RA27Jy0xiLemvd2GeAApQE8k81vRzlVKe0/7RDHS7SGxNjBfzV37Pz7X27bgmE5RI43I/MKK6C43wrPdAUe5K2XOAUtgDFcLznJrmrfFUCxKJAdZFyMiI3eJO5JgDhp4WtPDI6sGd3KyAOi/M6YZSENzbHAn7Cc/LxM9Jj0Hh65NG6r17EeoW3zgYde1ZLaoadzae6jV/qmxN2ybPx5NN/qWHkC89v8rWXnRTYsPf9cKlzn88WKZiNFU2B/eLF/z4RvI8GNi/sPYv16c3RQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WVlhQXhPUVd6TEpoNmQ4QnJrTElSSmRIaUJGTjVBRVRIN2JSSlp0M3R6aStY?=
 =?utf-8?B?RlF5ZDFkSTJwYjBwQWw2TGNEOWpsbEYrMEx5NlFrS3BFRFAwTWl0SU9FVG9E?=
 =?utf-8?B?YXUzYlh5UXlmd3NFVDYzRmhuRUlpZTN4cnBHTFptRnVyVThZdVdMWkpZRFpZ?=
 =?utf-8?B?R1Q4M0JESzFqVlB6Z2lxbFZUTDFEZ053M1ZSejN2MXR1N09Ud01vU0Z5NGtR?=
 =?utf-8?B?SEJkaXRXWHpSYlREU1d2OWs1dENpL2VGdlNNbWFPbGtndDMwNlhwK3MwZlln?=
 =?utf-8?B?WXl3VzM4cmxma3gzL2NRSnF6M1VhVFpQcEhQdG9aQnhXdkVmekhoWnRUWHZk?=
 =?utf-8?B?VmU5TVArSTBybjFzVHJGbUVlczRjd004T3RROExwelRPNHVTV0c3UHNJNHNx?=
 =?utf-8?B?bVlGdWdWd2V3NGdqbFplQWNHVDQ0V0lJMGFHQlUvT1gxUUVpeTVqajlXWmND?=
 =?utf-8?B?djBBVjZhMkwyNVI2ZDBhd1d1NkpNeEMxMlBXR3R2WmtLWU5xYkdDdUZlMmRm?=
 =?utf-8?B?aEFIZk41cFlzMmR0aWhIZDVxaDZ5UFM4eTJraXZnVmRJNU1jQkxPbmo1T09N?=
 =?utf-8?B?NjNGdHdTVVlranFFczUzZUtOMUt0bHZrZnhRSzQzMEpqMXY1dHhiR1A0TUhp?=
 =?utf-8?B?QXlPWWZENy9VSk90K0RiQWFCd0k2NXQwMmp0NEY2TUl2MG9pYnBLbS9rMFU0?=
 =?utf-8?B?b2YrMk1qMW1URmRHTWRRMVhGR3BYY2JlRkxUZ2RxV3cwVDdZb3d6bkVlNldF?=
 =?utf-8?B?M1I3Yk8yU0NRSWJRcTBhSjVEY09MTDdEODd3TmQ5Z2c3WXFpRi9JRk0xUXpX?=
 =?utf-8?B?enloWkcyN1RCVzU0S2pWNFpJdGdUY0Q3dUlhMFBRYzlHKzJDZFVJSDRBalBC?=
 =?utf-8?B?Y2NGWXQ1Sm9rUVVjRi9WdVJwWkZhR1NtTHVQNGMxRktEWXNZV3h3SUZiKzRu?=
 =?utf-8?B?ekVjVnhabzIyK0NIamRxc1dOUTNWeGx2bDV5N2w4aXpQOWtIYmUzUUJpRVFE?=
 =?utf-8?B?OWVhUFFDb0tNZ2FMNENVbkxOOEF3TWZKMWtBdTExYjI1NHpOempUTjl4L05P?=
 =?utf-8?B?Ym54K08zcDcybDYxaUM2Y2hEZDEzVWNiK3lZVnpwMXdMQWkzeXViWWJEY05N?=
 =?utf-8?B?cWkyckhSemxXZFhZMFVMSUhZbEJYS0JOUWNkc0t2bUwvYkRKREd4UWYyZGxW?=
 =?utf-8?B?VnNSVGR5b2JzQW1aSUJDUTNVelllSHFZbThDVmZyd0IxMjBlRHEyVTY0ZzZh?=
 =?utf-8?B?ZjAxalZ6dzdWUVEzR2hJbldkVDJQSFEwVVEzZlpWdzVaYjAxYXg2MmNnRWZa?=
 =?utf-8?B?Q1Vlb3NKUm5HazA4MVh5Um1DbkxpNCtaRXk0T2lkd2ptZzg3c1ZtZ3Q0amtQ?=
 =?utf-8?B?QnZvTXZrWUx4WDVPc0IxZFVTcWpMUklINVQzVmZ3WndSd2h2WG0xMFp4cTFi?=
 =?utf-8?B?S25SaEFlNi8zMHZ1YTBkNmNMQkFCZzRabWxLMjdOQ3dvWjBuRzBML2ZQS2hN?=
 =?utf-8?B?eXErZytYYUxkMGRrYW5PNVdtdktZYktjUmpKb0FIMENEc1FTZXE4ZDc3VitF?=
 =?utf-8?B?d1dLdjV3RXphaFF2QlpiNW1RdnNZWFlHayt1VXBVaTdoTklmUHBMMGhjN1Fv?=
 =?utf-8?B?QmhJbzMrL1ZOVFo3UnlnaUh1eW04L05YTGdja1ZVN2pMbXNRWERvbGhoZkl4?=
 =?utf-8?B?MXkvNWk0S3hBTUx1S2tIcGd4TzFPcDhwSCtlTGpPalZORUxhcjNYS0VWY2Rr?=
 =?utf-8?B?ek8xRkMyUFN1M2tMRi9haTB0dG81YWgzNm56U2MxM2liTUVPdEJUSHB5Zmpk?=
 =?utf-8?B?aUJvVXEyMmprNWVTRWVQMTRJN1ZqRStUR2R1MHg3S1pWMEtYVEdsak4wb1BQ?=
 =?utf-8?B?SGR4ZmZJSjRVUEZXZUEya1V3YXNDSjhSNzFuZ094Nk04aEdaaDZGVmNsc0Vq?=
 =?utf-8?B?bDFTeFI4bWVhbUZCWGhsN0VkdHE3NWhQWXlQcUUvcjl5WVV6QWs5ekE0Tyt0?=
 =?utf-8?B?TGE4c1hraTR1WFFadHc4WnR0THhkcVZPWmlpYWhmdmhKTnFYZUsxbWFvRkNu?=
 =?utf-8?B?aCt2SHhDUUJpdFlNWldnbVI4STdGR29KR1A1VkdWcjNDdlIxR0JiZkdNU1BF?=
 =?utf-8?Q?BUTNhNIwmTDYfTUebTtV+N3Bg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	D7za8zf6ips/pmBYYx3Hwf/iiE+1NQRkO/76IbjH5zhDs7zWgl8MVRdE+xJwaBTk1w6dCoTm6L/3+L1WikjoY6DL8jlR6vXpCqmhBhdwF0UGTRPv5MgILqP93alduCvl528Slel3ZzdHjpxwm7gd8qkQ+zU8xA4e0eUnDZ5atvLDTIJpoHgbIZkHXvSc2opqk4fJ/eGD/M860MHMRDg1ZbSLwEbDTcSxsGUIvenFyPga0Jd4P6lrOw5QcnsQimdqp7tk/La08WdUXIoesa6xa5xaBWxgSgFprluiRC+n5Z5SpIuHzc0uSVa/S9zeavk9zLra2CtgdyJByed02m0/8Rs4p85SCHsBwLa6giXZBM6Yb29tVd0XI+YWKPIvjHqGCvWr31oBN0BT/02/Hp7f/dczl4eQ3N+Kl++QnY+3jnwuS3sXLEzNNGg4wv/XUZrrogQBTjlMYS2eqwqwMk2l1BSOyJM/zfbBLDFRLbqxPqHwaprweAx2egqQoBh5UygwPvXWBGsu0eKWBeCWk5UiYkBgMNyIw2XG++rtYcmUognvh1HKdGGVnjrSMFSQ3Gr4sEiiNptHltHogJt+xu1tpyDCT97bv8qOvKkzuDh0tJc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93106790-f02a-4b48-e7c8-08dc3c27f950
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 08:49:16.5673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zS1olXTCiyM0Rv6lzAtKc5gPzkoeZQA3zLly4zurC4Hs3ejJzW4TMpU739DmqLmhuu8bulqqV8lS8oF6GMM60g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7557
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_04,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040067
X-Proofpoint-GUID: x5Hi6LbyOorw6djb_4wOZ3aOp7b8Cvpz
X-Proofpoint-ORIG-GUID: x5Hi6LbyOorw6djb_4wOZ3aOp7b8Cvpz


>>
>> https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/20240124142645.9334-1-john.g.garry@oracle.com/__;!!ACWV5N9M2RV99hQ!PqMMFBeUqdWwlm0AxVyI_Vr1HPajTQ6AG2_GwK_IrhBSa-Wnz4cc-1w0LEFyTXY9Q9gT0WwhxvXloSqnOHb6Btg$
>>
>> and now this one.
>>
>> Can the two of you please co-ordinate your efforts and based your
>> filesysetm work off the same iomap infrastructure changes?
> 
> Sure Dave, make sense. But we are cc'ing each other in this effort
> together so that we are aware of what is being worked upon.

Just cc'ing is not enough. I was going to send my v2 for XFS/iomap 
support today. I didn't announce that as I did not think that I had to. 
Admittedly it will be effectively an RFC, as the forcealign feature (now 
included) is not mature. But it's going to be a bit awkward to have 2x 
overlapping series' sent to the list.

FWIW, I think that it's better to send series based on top of other 
series, rather than cherry-picking necessary parts of other series (when 
posting)

Thanks,
John

