Return-Path: <linux-fsdevel+bounces-4757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 705BD8030AD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 11:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932A21C20342
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 10:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F2F224D0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FkYIMgNK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JFDn1qtf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2381FCD;
	Mon,  4 Dec 2023 01:27:39 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B49HTHx023343;
	Mon, 4 Dec 2023 09:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=mHOSP91UGlrDyTekPdpCVZ0JFoRE6i1/0MxMuFLxR5Q=;
 b=FkYIMgNKfOulFFjo023MIWo5TjuqPjV0H+M3HvfEVHeERoaou+j6bUW20R4Kq6uDPwt5
 ptlL6NKNiYYh+MyVrgiZt+7ntWFEZM3d7NzBqM1WJEtsGd2BQchlMoPBs/Rr2xKS2bY9
 vCose2er6j+TvOHv3nOpMUUyjZTqAhB+AyGNVUrBNPvV4g5+pNxQQVDUpaeTR4FwoF64
 XXMEFPs8hAg8P/pozo38KI+dTy/oqE5+p5ad+iU3ulFbRJdrO757K6jwbbPJujRztbhA
 iQ0q5eZbBayCSrfnODR5dYxoHYvWIYVAbWQUmtFZ1Eya2hvNlV9yiY/kY3M6fW+4PVRH kw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usc0h80qh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 09:27:09 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B47rX8o005997;
	Mon, 4 Dec 2023 09:27:08 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu15a1d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 09:27:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmSvJ/NN6QDO16q5jc+9V0uaztZB4xSKtAi82G/4fxBbVf5/LItnUKb+AXOquMZ8+2vCSyBVjaodJPnarUF0zrR1ghCQjAVOgcyRKDvBt2gNP9uyPSDapjA9ENRXvRU7eLGTgIghC2hSsuesI0YrvD1JzRfK0MU1NIhz8FdNFepVyMZxBxzYu9EImMTOlYEu1RYKuFKRxCfj/+CsFfksKau13D7eSQWw7LRsTCLZqfZHLNfDjIb9QE0keQYvM0GACpE1xPRkhDcW4NxGYKm9N9uj5YXJ5zbmf7F3L08Sik/Uj57gL4jMTh/HnAgP6tQIe+5hct1r42Ouai0LBpKdTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHOSP91UGlrDyTekPdpCVZ0JFoRE6i1/0MxMuFLxR5Q=;
 b=TokWqO1uQvJqqtoCM0UMxDFDYg32Rps8zKiY8aEfY8GZvz4on3Wp3bIRLY3/wgvJt9wYobsWFYN+FKB/+sPigTT5zTPrS9Tqjrs3lbhRhGJy9kpZPGiVjurKBA6YJT06+hxNZAZtX1ALdkNZdlMYcz0GcPTEbrHbsL3A/86AFWPpL4jPS2jE9kPGeGmHDSgs6+J+R4Z5JARpulU7qd0rb/0OZaXjozL0Xp3ryMhJXgkMxwe3OMEnOTnM9vlhG7Gg+1A51dJUCQqdr+6dHKlZPxcmIYkxumGqRV7xUtyhURYYesz60A98zmyx/IReqSPZ+uF3xlWRjv2wdED20W5yCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHOSP91UGlrDyTekPdpCVZ0JFoRE6i1/0MxMuFLxR5Q=;
 b=JFDn1qtfN+1LTrNSCWeXgjV80hnlQS4HULhlDa3iw9dOFW8qQx6IXabwzBQXutEhR98slB1pK9082gCooAguV3Wi3KNE9sTJjhXqnbOgoRwjs1B/AQJ4vlGJQ+8sJdqAtbNo9uniVMvod/TNasGzLbmY50wG8G+Yico8HV67eAA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4521.namprd10.prod.outlook.com (2603:10b6:806:117::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 09:27:05 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 09:27:05 +0000
Message-ID: <03a87103-0721-412c-92f5-9fd605dc0c74@oracle.com>
Date: Mon, 4 Dec 2023 09:27:00 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, chandan.babu@oracle.com,
        dchinner@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-11-john.g.garry@oracle.com> <ZW05th/c0sNbM2Zf@fedora>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZW05th/c0sNbM2Zf@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0265.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4521:EE_
X-MS-Office365-Filtering-Correlation-Id: e17f6d68-81aa-411d-0969-08dbf4ab2e3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mENNQiMjcBWLqAkWq0JODPGZ2ZuWIu41DTAJXmCRtKCTu55rpmCvLq3Q8Sz+DzY3xcp81HAphuyGFAlpSUDd+5H/lISrLz5XUB0+DIWmg66VXqdZaNhjFjR+Lf1a8cnfsyUTFiLWu1b33T1sekqJ6nAIrQDvFrfRbIkk6bK+AwF/Uqe6bjTkKQs3uhxW6zUjoiVacYZbYY1ecAGI/UG22phL5vhg+RP4//NMQDNc9nGgYnPcSfdLPGcDB+1iaW0p4jfvQR86k1ujP6ThooXLNPpe0nRZl4UvACJenkVVqedckarUaV0O5yXeGbTHR4/x0ijACSHh27xXqTcsWJbYtyIX4fC4OKLSzNmoJgjZCC3KT0k2Gzvh8KR/Q5rIR4lndc0uZaXHVwCD+GHppLlObc0QxRsVG4UaFLWdvfdIt+vuc5X0WRVfm+sAcAPrE/cos0YKYe7tX05sdaRMzHluXQqIhCIKh2bYmq0F/ITjCNADRj0TV8DOOFV5uwMPRfn4sSj3s3vyb6cV/bBJHHeAGAAyKBD/KROtlZrX39Iit82XLwk567YrDfReFfgPoUA+Gm3N/Agj7AReWSxzXsc4lZaYrskp2sPaBZsAZYhrrVv6BqhdHlNznG/lnzTNmJxrm6ob185HXHfFndyqS1X26A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(376002)(366004)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(66556008)(66476007)(66946007)(316002)(6916009)(478600001)(6486002)(6666004)(7416002)(5660300002)(41300700001)(36756003)(38100700002)(2906002)(31696002)(86362001)(4326008)(8676002)(8936002)(31686004)(2616005)(83380400001)(26005)(6512007)(53546011)(36916002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bVpIbVkrY1pQSmxhZGlRRUszbWdUbkMwRFc2U0dPRU5BOVdSY3huVWlkcW1n?=
 =?utf-8?B?akZxVk1FZGtFUWhjckJnSHU2cE1rZVByMFF4V1gyVnBxRFdsdHJBS09SQXNJ?=
 =?utf-8?B?bXhBOHRQWGNtYXA3UHZZb281c3pUYkV1OXl2WXNuKzBwVWFXN1pmMUZxeXRK?=
 =?utf-8?B?R2VyeXJibmZHNDBrbkZHVzBhazBNTTVERVJRWUkxVmxlNTY4U2EwZTBiNmFw?=
 =?utf-8?B?RXZhVENoOTdTZDVLUnRXcndvS254RktXRkQ1cUREL2NKd2FPcGtyc3BKVG44?=
 =?utf-8?B?cCtUVWt6S3JWcW1zU1NONkVhMi9McFZiRTRTeHFSd285RUpiQmwwN3pXTHRM?=
 =?utf-8?B?cHhxVW43d1M3d29aa0NLTWNNV0QxdFpLd1h2R29wSG1RZ3Jseng2UURsTU0x?=
 =?utf-8?B?bVh0K0VpbUUyRFJ5UmxET3hvRjdtSlVNQXM5TGlGcUg2YnVOTVVOV25JRnU4?=
 =?utf-8?B?L2xBeVNabUR6NzVmeE0xREI4cy9CS3hzZ1ZwSWNvZ0pjUGtsTXhXOVFORm9E?=
 =?utf-8?B?SXhnSTUvQVhRbTdhWnAwczkwWlN4N1ROelAzWXIyZDhhb0NobnpaaGl0R3JE?=
 =?utf-8?B?cFdrOEx3RHlnUExkalg2Q2lmcDRCeWJjcm1NakNmU2IvOWhrNGIwNEtxYlRh?=
 =?utf-8?B?SDhMMGl2c1p3c25Wa1FiUys5MmtxbG0vZnhhVm9RODNZbGdCUDJDQXljVHAz?=
 =?utf-8?B?ekE5aHZJMVo0emUzSEpEK2JPWU5CZDREMGkwbGpxNDhlRnpvRmRmSlR0YUJD?=
 =?utf-8?B?TSt5MVVPY2JFbnMzTUNFcnYyNmpYRkJPcXQwMG1Yb3BxR3FEK3ZmT0dDOEpM?=
 =?utf-8?B?Sm5URjZySjNMVlpCZjE5cGhrRWh4d3JXOWRJUmE2RVVSenp4c2hOeXRsZ3Vn?=
 =?utf-8?B?V2dpUlRPUkF1c0xTenY5NzF6MVp1SkNhdkFqZmpvSzdjUUxqVW5TUHljTDl6?=
 =?utf-8?B?dmtSa05DZDlUOTZpVm9SempnVG5XQW1XZlBaeHo3aGRUVzVpTDVhVHJ4QlNT?=
 =?utf-8?B?aDNEeTVVYWE5RktXLzc1OTM1ZlRwRlF3NnRXRUJsYmZNNi9FNkFKS3B1VWNF?=
 =?utf-8?B?eEFYbFgzZmttTGFaY1dJUVJFYk8zdGRYa0R3YXBzZWpIWG0vYnlub25xQ1Rr?=
 =?utf-8?B?NW5BY0dFOEIzcEcrK2tKaXFndVEwYWlhaXBMZVdkWElNZWlnSGVFZzV3K2xa?=
 =?utf-8?B?SUxheXNrRVNIMkhOWGp4NWdqOFFJWEsrK3pmZjllb0RxL3NNMjZyVHdVanMy?=
 =?utf-8?B?azJVT2NTbUNkVUxncWF6MURrc09LYzNjV0I5NlJIaUNUV3hRang3QXRBOFdZ?=
 =?utf-8?B?NTZVbDZCcmtSLzBOTjNLK2EwZ2pBaHZJZE01TWJjSUVLdm42VlBQblhLK2NC?=
 =?utf-8?B?Y0N6a0h5MStlY3ZZM01sRzNnKy92MkwwT0tSckFaMUxKT29kOFhuN08zTmhr?=
 =?utf-8?B?QzVZTkYyRWNJSmVxdTVWTlVXRmhiTFRad3dWYXVQTnl6OFRMTEcyS1lFcWhH?=
 =?utf-8?B?U1hwR2lKTWJXRmlUM2NyQkNUMUdnY2xsWGI1N2JsZjRhdEhKYUo3NXI0MW11?=
 =?utf-8?B?NUlIc2JuUExRYkpyTmh5TURZR280cytSWmpxa0p3SlpyRjhmcGhNNlhvU1NG?=
 =?utf-8?B?NE43R3RUNVpicUwwUzhrTG91dUhaQWJCVFZvanFZSFFYZU9Xc1pjeW5mQkxz?=
 =?utf-8?B?bUhpVys2UXZGV3B1d05RK3Z5c3AxQnorTS9qSEQyUjRLU2Y2ZkovTy8rU2Mr?=
 =?utf-8?B?NTJncXRZVkVFQ1FYUlR3MHJSQkp4bnN4b3RHUXNrcDFkTTc5RVRTakhiSFJH?=
 =?utf-8?B?STJQNVNOd3RDcE1qTUMwVXU5Z2RKVVJpNmtYNVpIUUNubXFQL1pSSkV5dFds?=
 =?utf-8?B?SHVzSFJySzZ3TUZBeTNqMWUrOU1PRy9lTmVwZkhZU1NzWkk1WWk2ZGlwMFdQ?=
 =?utf-8?B?YWhlNlB3QWdUMHBRUkxjS3pXWStoenorUDRMVS9aeUwybXFuYmprSWtTWm1s?=
 =?utf-8?B?ZE5VUDNWQzI0d3NwbGovTFZkTnlndTIyUi80NlBSUkVIZ25kWGk3cjc5YUVU?=
 =?utf-8?B?aHp4bDZ3NkxGa3dzREprdWRVUGNjUDZ3UkJGeXNYKzdPWFhXMzNZUjZpSno2?=
 =?utf-8?Q?NMgPCqurv6VrnSn9+r3FtXq99?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?YStqVk03c1RQUStESHJVbDBzb2hmTVRydHFaYlMzbSt2Zm9McTkzUkJ3cmtQ?=
 =?utf-8?B?RzdiT1NpVzI0Vk5Id0hYVjV6S0MvQlFyNUZIZmFTZU1BaXErU0luNjRqR1BY?=
 =?utf-8?B?VnV3RmFtTzRQd2xBWEw0VHJVemlFTm5DSHVUcHN0bGo5WTVTUVhUUnI5OFhF?=
 =?utf-8?B?eVpmdm5UVThCK0MwSHRKMzZsem1EZVZqZ1pMNlZSYlBhVmhzbXBkZ3lUK3kx?=
 =?utf-8?B?YkZIU1lab042dUZpNWtlSVNnUFdZUUpLSUtpZ0drZ092U21qRkFUaEpkYUI3?=
 =?utf-8?B?SXV3WWVGd3daSytwTDhEY2Y4ejJmNzBoMk8rMWYrN3BaWHBIbEJjU2paWHBy?=
 =?utf-8?B?K25jdEpvOW15bTA3N2ZOSnJodms1ZWkxOS9iOTkwSTNSYXdjYlNva09EZXRx?=
 =?utf-8?B?cUpqUHdyTEZndEt6L1o3bW5oVThPZ05PYlhjQk9HK3FIcm1hMVJRQkRGcHl2?=
 =?utf-8?B?cnBmSzArT29hek9YNzBmaUh5QkJyRlBkcHZCT0VudVl2MDNFY3dLRmd6VG9o?=
 =?utf-8?B?N1E5ZzhyeVIvYjZOUXlOTXB6WDhmYUFqNTVjb1BlRnYwVU1wL0V4c3R0WnRz?=
 =?utf-8?B?OXBqdGQyRUFtbTJBUUhqK1RVQUxqUjlwM1gwLzdxV1p4MHhuWDB0dkY4VlFx?=
 =?utf-8?B?azFhTHZHVTJyck1zWnVSZ2VLVDhpL2lFNDJSVDJjUHNBVWQ2S3FlMy93N1lH?=
 =?utf-8?B?b0tkcytCcG5GanRUOFRHcGVpNkw5ZEcvNE9NOHZYUUd6TnlnT2QrSWF0REox?=
 =?utf-8?B?bWZTa1g0cXJHa0x5bjM3aVFIUGhLMFlaQnZxKzlSNUl2bTAyMFlBTzROQzll?=
 =?utf-8?B?eG8zYlVWVUM3SUdZLzFrWDAxZDJqanZ1Q2x0UExKUVZZRHRWcTVYRnlUeUll?=
 =?utf-8?B?TE1QdktvSzI0V0RPWTQzamVkRmc4YkxVbk0wTE9tdnBIQnpFOWx6ZjBpOEZM?=
 =?utf-8?B?MzQrcTVocitLMmJ6bEJQZmxSeUFpeUcwR0tILzcyVmE0Q3Erd3M1NW00YUsv?=
 =?utf-8?B?RGNCYXE2bHB1MFVseHozL1FYcUdrR2p6SHpDSFFpK3FRTllWZjFzbUxzN3N6?=
 =?utf-8?B?VE54ZVR1di92WUYrQXJwRjlDYitiSkFEVy9yallQNkdyU0hYRFU1ZS8yV0tB?=
 =?utf-8?B?SVI4ZXRralRTeXQ4QyttWWR4N1dsbnFvUlo3VlhKVWF5ZGpCWVR6T1gwUlor?=
 =?utf-8?B?aUVMbkQxWDZ2NkJOd1BsOFpyNHJGQVBBeFN4ODhHeDU0dkc2S0dwa3FMYnhz?=
 =?utf-8?B?N0M4MmppTWw4eUZCWmJOb0RQWldNSENqWTJZNXBGZzNrSEU1UmFZU0ErdUZy?=
 =?utf-8?B?ZFB2clVNUDkxcVF1QnlyWmNUbmJiTUxqaHBsZ0Q4dUF2c0lzMDVicm5LQ0t6?=
 =?utf-8?B?b2FSL3g3VEhlQTJzdWpCaWdUVE9sc0lCZXgzNlM5RElBa2trMEsxQ05ZaGFs?=
 =?utf-8?B?NFV3N1BtemxpRnBra244aXRWMkhWdGpSOCtIQlBRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e17f6d68-81aa-411d-0969-08dbf4ab2e3a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 09:27:05.7153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQGsHtfjfmijZRYE5SSNDzqBb1Wu+X5PsetSp78c6FkGeQY7wy9j29t9JDRCUe1DfHM/5Yko1WdtBb6UrmhD4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4521
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_06,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040071
X-Proofpoint-GUID: lq9WZejnx554_9JE7ZNA1YXnizVtAzIZ
X-Proofpoint-ORIG-GUID: lq9WZejnx554_9JE7ZNA1YXnizVtAzIZ

On 04/12/2023 02:30, Ming Lei wrote:

Hi Ming,

>> +static bool blkdev_atomic_write_valid(struct block_device *bdev, loff_t pos,
>> +			      struct iov_iter *iter)
>> +{
>> +	unsigned int atomic_write_unit_min_bytes =
>> +			queue_atomic_write_unit_min_bytes(bdev_get_queue(bdev));
>> +	unsigned int atomic_write_unit_max_bytes =
>> +			queue_atomic_write_unit_max_bytes(bdev_get_queue(bdev));
>> +
>> +	if (!atomic_write_unit_min_bytes)
>> +		return false;
> The above check should have be moved to limit setting code path.

Sorry, I didn't fully understand your point.

I added this here (as opposed to the caller), as I was not really 
worried about speeding up the failure path. Are you saying to call even 
earlier in submission path?

> 
>> +	if (pos % atomic_write_unit_min_bytes)
>> +		return false;
>> +	if (iov_iter_count(iter) % atomic_write_unit_min_bytes)
>> +		return false;
>> +	if (!is_power_of_2(iov_iter_count(iter)))
>> +		return false;
>> +	if (iov_iter_count(iter) > atomic_write_unit_max_bytes)
>> +		return false;
>> +	if (pos % iov_iter_count(iter))
>> +		return false;
> I am a bit confused about relation between atomic_write_unit_max_bytes and
> atomic_write_max_bytes.

I think that naming could be improved. Or even just drop merging (and 
atomic_write_max_bytes concept) until we show it to improve performance.

So generally atomic_write_unit_max_bytes will be same as 
atomic_write_max_bytes, however it could be different if:
a. request queue nr hw segments or other request queue limits needs to 
restrict atomic_write_unit_max_bytes
b. atomic_write_unit_max_bytes does not need to be a power-of-2 and 
atomic_write_max_bytes does. So essentially:
atomic_write_unit_max_bytes = rounddown_pow_of_2(atomic_write_max_bytes)

> 
> Here the max IO length is limited to be <= atomic_write_unit_max_bytes,
> so looks userspace can only submit IO with write-atomic-unit naturally
> aligned IO(such as, 4k, 8k, 16k, 32k, ...), 

correct

> but these user IOs are
> allowed to be merged to big one if naturally alignment is respected and
> the merged IO size is <= atomic_write_max_bytes.

correct, but the resultant merged IO does not have have to be naturally 
aligned.

> 
> Is my understanding right? 

Yes, but...

> If yes, I'd suggest to document the point,
> and the last two checks could be change to:
> 
> 	/* naturally aligned */
> 	if (pos % iov_iter_count(iter))
> 		return false;
> 
> 	if (iov_iter_count(iter) > atomic_write_max_bytes)
> 		return false;

.. we would not be merging at this point as this is just IO submission 
to the block layer, so atomic_write_max_bytes does not come into play 
yet. If you check patch 7/21, you will see that we limit IO size to 
atomic_write_max_bytes, which is relevant merging.

Thanks,
John

