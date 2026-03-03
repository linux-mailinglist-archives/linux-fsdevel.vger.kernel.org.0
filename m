Return-Path: <linux-fsdevel+bounces-79281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBMxCDA/p2kNgAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 21:06:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA7D1F698D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 21:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73C9B310216D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 20:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736AF38910D;
	Tue,  3 Mar 2026 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d4meXLUj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Jgo5HR6k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8737F3976A8;
	Tue,  3 Mar 2026 20:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772568165; cv=fail; b=ZRGQxw7UIR3QGvdncfYY8UClC+ATRTk1TwHxjprxYF8y2B5i5XsUXKtFvfxln1ZA7Q/+/dNZGyqp/szX4tDcQ0RntzMJd+ULKel7PVhAeKxvcQEjKSbt8LzPbk5I1CB+l0wSgVFxGZEOQaQdWbb54GTIzLFaf996u2ou8p2fVqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772568165; c=relaxed/simple;
	bh=Kfdvv+/r2kYPiO4zFW5zax+86973QtFOfLEdJ0QASRc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DJKeFdCjD+R/l7rP5QJZKArMKaZntKoQkUCOnIrAzYZQetbxTSTX7EfyjrDPPVUfb1OGNRkO2ZTZGwBYfw+OQ0mtKpoN83aq80vBidl+iHOXVdf2Bju4qcZPtJxYd5NBgccAdoC/EsLaeks2fPkoUNEbJzQpI+4Ea42zsn4e5mY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d4meXLUj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Jgo5HR6k; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623IYALM4135182;
	Tue, 3 Mar 2026 20:02:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=aDswj06sLlkACdh34jG3wHkx2674X0VLkK9ZKVOFJSI=; b=
	d4meXLUjfqm6Q2Fz16q+j9crA1du7ejioT1UGm3EOWPlntHKgxHGhjw7dYQq1jW5
	1OiT+HsJPvw2Lrm/qjaAOUjObq4/FVVTQx3Bzcm4XGME7+FA0TF7jaeI3907Mfj3
	3LvSQ5AmSjwME56L+xkdMhuG0oPhswHG2gzerGWj0HCtQ6xkvX1qyEQNBFRA2S7a
	wu1NiFASd1OU8/IEhiw/cYHqFjKNavDsACGmtoIg6KEMOGN3T1jkMy8vvIEvRv9N
	8Yx5uD3JGLTAbwvDxkYtYtzoLyP+L6JIPHVuGpH6KdFOohAmxsiae6O/iEV4N/aF
	X4+3GwkGA79eukEKYX46Tg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cp51k85hd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 20:02:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 623IrYQl035232;
	Tue, 3 Mar 2026 20:02:31 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011040.outbound.protection.outlook.com [52.101.62.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptetuk4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 20:02:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXJPBxgPt/e3+AoOOfBV3r9rhAnD5rEHjihAJx9BWxc/TuoHjsDp+pwFDvAK7LbMebDvXfBtCoNQPLWIphLhSIBgregGG3nuUp+GcdruXB2zhUKQTdDBUjIyIZP9TuLnfOUlDFGQTTQMd3Sgg+nduv6z+APh4vQHxH/7ytfQXh88G9t/tjpoqn6s5bND4DXKeDejYt+sWO9nbyLfBTMlW9QT+1U9w+wZA1rqwML4mmQF0jRvZTsMnxDf9jgGv8MWBx+PtrIUxj1HRGRQrpHuWRoQENjiLHazDRZRKCfeBf2bNlTpxziKtU16MwAr2nO13CeXepz3zNOtK17XpMWVgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDswj06sLlkACdh34jG3wHkx2674X0VLkK9ZKVOFJSI=;
 b=qpZXAnTWNnVkCRcTUwAEn0IEG+FVlZMNnzXoX1XrgskkEn29tgCAgXVgG1oTLoCJZU5k01udyy8nCHXBd3iBecuQ2qszgp+5w4aV7CjOW/tBay2DEIOO1gclcLGy8VToZuQDuv5ukyh9UIBXMsp1te/XALjnTvfI9wirrmYFQsdDdKxR6J7b+mdMsd12THBKcheO6HFWMMzO/kWUYRNYnA6c2rFjere9T2T1W9veCRcy3VBGgyMQWplJORi13+4PPdzwmPA9nbfJdJNMt2nCyQry7SXqaLG4a82Kd+CURdsv8qOKmfmcjN02+dKxVlxgkiHRmGAKqmfrXSnDmZ0JMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDswj06sLlkACdh34jG3wHkx2674X0VLkK9ZKVOFJSI=;
 b=Jgo5HR6kvW/MEawfsr3dVURkRdP7LQ7zfcVAGWIX1fOLmQU929YoXLR780CrosOEKwSt7P25sSI1mxsg1xLZ0pWF1GNjgLnI7cKDkmIzjzScwqnrhahrk/hMuTBu1fn8Tk72dcC/nmQaq1QmOZeie5cNqjaOr35lpwknMd0oPbI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4990.namprd10.prod.outlook.com (2603:10b6:5:3a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 20:02:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 20:02:25 +0000
Message-ID: <fa27c3a4-ec29-4d0e-a8c5-56c4635c9e3c@oracle.com>
Date: Tue, 3 Mar 2026 15:02:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] fs: add umount notifier chain for filesystem
 unmount notification
To: NeilBrown <neil@brown.name>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.com>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20260224163908.44060-1-cel@kernel.org>
 <20260224163908.44060-2-cel@kernel.org>
 <20260226-alimente-kunst-fb9eae636deb@brauner>
 <CAOQ4uxhEpf1p3agEF7_HBrhUeKz1Fb_yKAQ0Pjo0zztTJfMoXA@mail.gmail.com>
 <1165a90b-acbf-4c0d-a7e3-3972eba0d35a@kernel.org>
 <jxyalrg3a2yjtjfmdylncg7fz63jstbq6pwhhqlaaxju5sk72f@55lb7mfucc5i>
 <3cff098e-74a8-4111-babb-9c13c7ba2344@kernel.org>
 <CAOQ4uxiX5anNeZge9=uzw8Dkbad3bMBk5Ana5S94t9VfKNFO5g@mail.gmail.com>
 <d7f2562a-7d32-41d5-a02e-904aa4203ed3@app.fastmail.com>
 <CAOQ4uxiO+NCjhBme=YWCfnVyhJ=Zcg4zmnfoRspJab3n5waSCA@mail.gmail.com>
 <07a2af61-6737-4e47-ad69-652af18eb47b@app.fastmail.com>
 <177242454307.7472.11164903103911826962@noble.neil.brown.name>
 <d7abef36-ce90-4b36-af16-e8bd61b963ed@kernel.org>
 <f52659c6-37ed-4b5f-90a1-de5455745ab7@oracle.com>
 <177248378665.7472.10406837112182319577@noble.neil.brown.name>
From: Chuck Lever <chuck.lever@oracle.com>
Content-Language: en-US
In-Reply-To: <177248378665.7472.10406837112182319577@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0090.namprd04.prod.outlook.com
 (2603:10b6:610:74::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB4990:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bdbb635-ec63-400e-62be-08de795fca5c
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
 YsDb5EX1ckIONbvKHMHf1aQCmWK0nN07I/1NNs/TnuQp1v/7Zy2ECzagRk8WHJi+BX3BuAJrDl66YO2wvUlgmdv08wq7udydb2z4m0CxhvflGelx8JuXGTSXVc3uzQsu29o0CTALZTtNyqy5ZpWMT0PJxulkXNoEKQ/FNbCSgKb1JBmjcMXbuuW5CsAC5FNWIfKpnJwjr60204+lTcA3UnRsAHm9kFCq2iL4y6LW0tnLaKJQi0Shbpl4WVx0xBxINlv2IQJHEyYytLT0RkvkR9JXf59DzM/gH4lfF6t49eODG09Z+Llmxq2w7bfDd/Og0tCr5aYGp4tGY6R5+YtL+QqFOyAljS1Q7CHd4RAJXUOHXSr7y3UAh66YRro5TacWwHgwtiR93cHnkMC2mk1YNbgwPV/jInX/nXY4JVHqv95MON2YS/A/Pz9cp4KxJui+MNG3+ogzyknenFmayZPEc+Dp+6JMkL08/7B/khABVLb7Mz9dK7CFKMoSqDbbaVZ4Lm0IzR+HE/MxNB9d565jLxYIqRviYmKALV1j+YpD/vwPLog0GNRrdhl4jSdyUp5SdmColwu4ksX+jzPE2EK7WJrnWkoorkVmqE4U1CZXYYq/1khLVqW137ARDmv0KC3bWYN+g2xvGVsS77xmFGsBxbbrM6O88flcu5JsDUu9tiX4CA+I2olwU8C9rGE7uwiL54jpvFvPpwZMFwt4TwlfXk7aVFHBToiAht2Q1uUilY8=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WW5USUVWTWZ2LzhobXRIaEd1Z0ZsRFByNFlmeEROQ1RPOXhXUXM0Q1NEK0pN?=
 =?utf-8?B?OUdvQ3QvdjY0d1lIQ1hjZ0dGVTZvbmd4SndLV21DclBIUGlSKzFZaUIwdWMz?=
 =?utf-8?B?d1gvdERFQzFJb1VZZUFOb2ZTYktuclNZMC9qT2tGbTZQenNJRGVjM2w2Ukx4?=
 =?utf-8?B?RkFYYWl3RWQ3cXV4bENVZ2t4UzBZNXlnTW5TRU9qb0poQjhUWlVDdUlWTVky?=
 =?utf-8?B?VVZTVWd2N2FpdDlYRUV0RmZqTzB5TjI4VTlab2RWcldzOHFudzJLQnZhSFIy?=
 =?utf-8?B?ZHN6TzFObDhMZy9xazdGWC9xbmFKZGJGTkVGNDR6RnQ0TzNJM0N6Q1JkcEx1?=
 =?utf-8?B?WGUxRThjVDBiTXplZ01Rb1BsUjZSVTZ5M244WGwybXVyYmJXaVpmSlBjZ2FY?=
 =?utf-8?B?R3NHV2toQVh0c3BhMVA2SVVMdmJIVldYaU8zdkFTZWUwS2lITzhvMzBtZjdl?=
 =?utf-8?B?aVhoZHgrNEhqQlJzRit3SFgwN1JHYUVCNm9HaFAwVi94ZlA3M1VmaW9qcUg4?=
 =?utf-8?B?cUR6S0ljTTlGUEh4VkJyb1pUYnd3MXRQckZkbEpPbzZyWlJmVVEwQ01nZnE3?=
 =?utf-8?B?R0ZmUldEVEs2ZVI3aS83VEVBeE1SeEsrc0NwekpteVhHdlBmNWxQTFdBNGU1?=
 =?utf-8?B?enROUk1hcG10QkRNWFpITkVaTkZST2hQaFNWQTJmU3VHS0RQNjBQR1ZWRWpX?=
 =?utf-8?B?WGdxVzRtdUc4Qlh5OXhsWlc0eU5wQ0M3Ti9wcGVWU2RSbFVmRmNISFc0NUdn?=
 =?utf-8?B?RS9hbCt3Um40cTNDaTg1Nys1a1A4UkNPNHc0SmNLS2swYlZtUUFkRWRWZS8y?=
 =?utf-8?B?aTRZbWFla3U1ZFRJZnR5cDBNN1AxazdGeVErZkZyWXE5eFZTSjlGektQM0w0?=
 =?utf-8?B?RXNWVUxhOGx0MEpFQTMxcHYxRW1NdnZMeGhQTjBwRkZGdUdpTTZERUYwYUJ4?=
 =?utf-8?B?Y0xnQWtLaHQwWEpNMlRVRTJkdjV0dTZQWkFlSjQvQm1uQUI4MkZZZ3VyVVNw?=
 =?utf-8?B?Y2F1aGNZSGF4c1JkZGRoUlBHZEhqODFyTzhKbjlweXVQM25qS0p3NGNucUZ4?=
 =?utf-8?B?b2xtZEpNNy93SENMaTdxTWZIc292N2FWMjFpczdRblM5OXZ5UVArVFZOZEFN?=
 =?utf-8?B?ZWNZTnMwcTB2em1uZ3VDMWIvNFA0bzRuTFZzVlA3ZEpYWG5sMW5sTlMxZWZx?=
 =?utf-8?B?ZWpQOTJVNUtKd3RjUWFFSU1PKzBkdFJXdzNaZ08zZTRKdkR4QUkydUZObjA3?=
 =?utf-8?B?TkpjT3dmS004Z1I1aHNjUHBOQXRWWnV1eFZWeGt4SEQ2Q0tsbVlZTWJpVEhT?=
 =?utf-8?B?WXg1VmhyaXRaUGdYRmlDS1kxVFNzVEUva1dERlhYS2dRaGdLeGJ5eEdKMlBx?=
 =?utf-8?B?eTJCcnU3OG5FOTBJVy9rWTQxZmljTmNycitOSWxQZ2JUYldlUm5XQ1NxUEpI?=
 =?utf-8?B?dVlKQ0s0bFhtZHgyQkdBU3pGNFhraUh1UWd2M2drT3pPeWpNV2V5b2x4Wklu?=
 =?utf-8?B?aVRCaVQweVJFMjJXMU1KV2FYN2JqQk1CR1NQWFNDVGREcmhqWjF5cEd4emRQ?=
 =?utf-8?B?WWpzTXp0N24xeXRIOTJvQlR3cERSNFZTbWNVUjhhUk1ZbmN1RXRxWGdHUFlJ?=
 =?utf-8?B?VXBWSEpabnFrNDZ2WVkxOWJ4cWxmMVVRWSt6MW10Q1lLTlJJWUtHMWN5U2Jo?=
 =?utf-8?B?aTZ6TFBWRFptd25nZnY5SjRUUVE5QmVkaXYrK2NLVmFadml5aGtrU1JLZWlZ?=
 =?utf-8?B?UjFHL3Brbm5zYjdBMVcvZkZyUDZiRnI4SmhFT2lCdC9FKzJUS2hyemR0WGVv?=
 =?utf-8?B?NEZJREdoTGxhU3VkcUJ6UVVoa2tlUy9tRS9YdTZOSjJtL3kvS0xIMXJnbXdt?=
 =?utf-8?B?UXZlRHBzOEtUcUJhWjZJT00zbU9uZ0dKenhkTUErbDJiNzFmNEtvZFRsY0kz?=
 =?utf-8?B?UWVFd2l2dnNNN0o2L2ROaEVGYzJlcStxa21HUTlVNHE5TnY5QXYrOWo3UXJM?=
 =?utf-8?B?OE5aN25aaEF6QmdDWlJiODFVRDUydmxTNjRidCtlejIyUmhLV0xnQTNibHdO?=
 =?utf-8?B?d2hxTXdDT2R1NmJ6c1RuUXV1ZDdYQ1l0dE1WNXZSMHVSZnRTaEtiaDZ4Kzhn?=
 =?utf-8?B?WU93UVMxTzJYK3JtUU1nQjJLZWdNbEpEakRuWjZ0K2YrbFFaNFRDT0VaL3Fz?=
 =?utf-8?B?UUo4RTBOeGZEOVRwczBNcUxHYXhvbVNuZHFtRk9HMCtGRHZxc2x2WFZaQmM0?=
 =?utf-8?B?aGVzSzdBMFdqRFVENmxUbGpheC84UnFab0xwNnVjVXMxWDhxTzdBd1FOZzhZ?=
 =?utf-8?B?WXdzWlNQb0FEYm4vQ3VrQzdUUVFNc0pua2M5UWdGeTUvYjMvdER3dz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9tdzx4y+SnBLo7xPiGvnCGCX1rFtSfOp5+UWWI3CFPwfjQYx76u7zWOOIavZ484khSa9QoW3hEBEGg1QxlI5BmB4/gWAKQFTKYySWA9abDnIsCciVh60CmcuxHnlC3/C///kmJmbyRlJHczIiYThuXz2mIXiKZwiqRNtc/phtEULVx34LnOBCIghQa2hCg/XIjqfOLnvYxYO57Y/lGDaF8bilVZMdnYZgDSt0qcEWZjgSzCB7ziMMvJrExoAowPMY372ofEODROZUhcxZvlzbQZHlBUO78j4e9N1q6zHlyQO2dd8GC2Qa9c9xM08dgOCuBYgS3LRnCBsXmn1BqPKxvOk25nEenyXt2/JZf0J7twjxXKi/cyxIqOX/9BdtViLD9ECkeM2B/Oi9OBKL2XDbr4DGrrAeXcsmk5Kgfkv66ms/NM9W6Dca28F0hXe1aGoxdne8Ttp8dLoLH8rTY5oHAmWrZyyJM9Nqkl/G2fMqzxyKRPTkIpsdgmdYFt2qz8SgLYaQjff4Htl6n3/88c8PwvcVTdN7c0Wi36vvfKBOtHXoHetAgd+DH1iVYfZR20cUuYiH1JcyBJtIOto+F7sXbcJTTTchq87rdhViaQJQa8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bdbb635-ec63-400e-62be-08de795fca5c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 20:02:25.8447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxCHSQ6RAH/ZldV7kgVsf/B6eKRaCoObSkxSQQ91GXkf2s6fUmvDlc17LYd+xmiMfwU+G6sAD7uwElh9Pe4+9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4990
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=871 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2603030163
X-Authority-Analysis: v=2.4 cv=L6UQguT8 c=1 sm=1 tr=0 ts=69a73e58 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8
 a=poisjUcPUxCBCD90WZsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12266
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE2MyBTYWx0ZWRfXyxkIIK1m5Hq1
 nOa30ucHQMQQ0E8KJi9auQG774L/4Eo3AFvLZvXxjZlYimzRbOrHWi70Z80NO3r3up5yrBv9yoq
 CTRDzlH2+J8OCS7V5rBjt4ROOA/ZhOt14BnZphptTewGL6yhBWqHlQHKSjcFtBFxbtTPuuvsjpk
 CPu0RCiKmUPx6wxrzCpXV10O1YxnK94C0/m3jejd1jjjqK0l+zPTwQ0jEKZfkkEM7/ea9HlLuHl
 6yC0oPMUNJvp89dlbwclRCEA6mS7hVmn0OQECZE5vwhqAB3fdkOlFKNpwCWMH0nXt9qe8DaTonZ
 /zDeiiCCRTBT50+Dm4DjPJHdsNmrAiL1+1kH0De0ChhWa8S7PNIqC9qXOLGcfGB0hAeS72izJlL
 TS+cwSWTckO/0RTRh2nlxXja7deax9Z8/BJOTcOJhDtDpfRweaOono6o8DxhMHYJ2SgFue3SxPq
 nfVyOPp4XEYdNLz9AjLCu8rfn5EIqtDdJWik5Eak=
X-Proofpoint-ORIG-GUID: wGpSafyyyHpClZrQDjZrf_nj_mtvRt55
X-Proofpoint-GUID: wGpSafyyyHpClZrQDjZrf_nj_mtvRt55
X-Rspamd-Queue-Id: BBA7D1F698D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,kernel.org,suse.com,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-79281-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On 3/2/26 3:36 PM, NeilBrown wrote:
> On Tue, 03 Mar 2026, Chuck Lever wrote:
>> On 3/2/26 8:57 AM, Chuck Lever wrote:
>>> On 3/1/26 11:09 PM, NeilBrown wrote:
>>>> On Mon, 02 Mar 2026, Chuck Lever wrote:
>>>>>
>>>>> On Sun, Mar 1, 2026, at 1:09 PM, Amir Goldstein wrote:
>>>>>> On Sun, Mar 1, 2026 at 6:21 PM Chuck Lever <cel@kernel.org> wrote:
>>>>>>> Perhaps that description nails down too much implementation detail,
>>>>>>> and it might be stale. A broader description is this user story:
>>>>>>>
>>>>>>> "As a system administrator, I'd like to be able to unexport an NFSD
>>>>>>
>>>>>> Doesn't "unexporting" involve communicating to nfsd?
>>>>>> Meaning calling to svc_export_put() to path_put() the
>>>>>> share root path?
>>>>>>
>>>>>>> share that is being accessed by NFSv4 clients, and then unmount it,
>>>>>>> reliably (for example, via automation). Currently the umount step
>>>>>>> hangs if there are still outstanding delegations granted to the NFSv4
>>>>>>> clients."
>>>>>>
>>>>>> Can't svc_export_put() be the trigger for nfsd to release all resources
>>>>>> associated with this share?
>>>>>
>>>>> Currently unexport does not revoke NFSv4 state. So, that would
>>>>> be a user-visible behavior change. I suggested that approach a
>>>>> few months ago to linux-nfs@ and there was push-back.
>>>>>
>>>>
>>>> Could we add a "-F" or similar flag to "exportfs -u" which implements the
>>>> desired semantic?  i.e.  asking nfsd to release all locks and close all
>>>> state on the filesystem.
>>>
>>> That meets my needs, but should be passed by the linux-nfs@ review
>>> committee.
>>
>> Discussed with the reporter. -F addresses the automation requirement,
>> but users still expect "exportfs -u" to work the same way for NFSv3 and
>> NFSv4: "unexport" followed by "unmount" always works.
>>
>> I am not remembering clearly why the linux-nfs folks though that NFSv4
>> delegations should stay in place after unexport. In my view, unexport
>> should be a security boundary, stopping access to the files on the
>> export.
> 
> At the time when the API was growing, delegations were barely an
> unhatched idea.
> 
> unexport may be a security boundary, but it is not so obvious that it is
> a state boundary.
> 
> The kernel is not directly involved in whether something is exported or
> not.  That is under the control of mountd/exportfs.  The kernel keeps a
> cache of info from there.  So if you want to impose a state boundary, it
> really should involved mountd/exportfs.
> 
> There was once this idea floating around that policy didn't belong in
> the kernel.

I consider enabling unmount after unexport more "mechanism" than
"policy", but not so much that I'm about to get religious about it. It
appears that the expedient path forward would be teaching exportfs to do
an "unlock filesystem" after it finishes unexporting, and leaving the
kernel untouched.

The question now is whether exportfs should grow a command-line option
to modulate this behavior:

- Some users consider the current situation as a regression -- unmount
  after unexport used to work seamlessly with NFSv3; still does; but not
  with NFSv4.

- Some users might consider changing the current unexport behavior as
  introducing a regression -- they rely on NFSv4 state continuing to
  exist after unexport. That behavior isn't documented anywhere, I
  suspect.

Thus I'm not sure exactly what change to exportfs is most appropriate.


-- 
Chuck Lever

