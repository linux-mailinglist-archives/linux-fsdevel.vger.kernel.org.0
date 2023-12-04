Return-Path: <linux-fsdevel+bounces-4782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3A5803A79
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 17:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2865C1F20FC7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 16:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2412E631
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GPPjgPMV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e8Nfg4qr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F7B116;
	Mon,  4 Dec 2023 07:19:47 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4FADS0007678;
	Mon, 4 Dec 2023 15:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=OjA3YDYEX+inKfAoqDDEMGIKqJXxrQJ57lFryeMNyPg=;
 b=GPPjgPMVWKQ6VPNjR8nxC6Goi0GszwmYaqc36ZTXY3ynwulLglaE8oZKLLIo1m9S9KvS
 Yu4wAKKtrMKSxb1BcNZgmq+zku4bCeyLbpY0fsCg2w1Pw/K0f9wCIjQgvi7CcS/D37Y1
 HlMPgWuNAFxW/APAgEhtysBZ6vLJQZatiRxtphslHU720mcMZ05dqtAvg7YA9+xunNs5
 KgXFoK6fBMef81LDhs2BwAK1nbjQYbuHS+wZhWfEfxK0EY0maEHCUBIOrzOQOg0ON4xW
 akcdXRhHyETF7uBfw4hbAZpTd9HBuTdNbraVnBOHbSObfRviAzWXAxERP/zDy0aOlVxj 4g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usfxp0a4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 15:19:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4F4NAG003898;
	Mon, 4 Dec 2023 15:19:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu15yrrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 15:19:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrB0E0BP8me1iVGbqbescQQw0aDXPaDn52Rjmjp9SqEQYKwG2qPl3RxOYqCtqDF/IU+hlr5Cy2YSSqi0Pbgz9/B8APmZgDcWtJW+YE6mR1goWBA18IxNqQFWA3SGM/cfbpyZf0EGfWlCT+xvrHpjo2pDTGyfErIVQycjhfWra9EjNf7tWsw7BEmKZL+2mWHpgfAPqOjiuQG2E7MPkDj75b4ggNjp2qOVPlkMDuSk7da5uDr5LO9KGMtk7P8tj+06BjfefNozfq8F8X8IyDgiUwB7b5inXzSc3f4Gc8lyfjT9KJT08VWScfNAw98IvE6AdKeOYAMt2NLAOZZU7L+Q+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjA3YDYEX+inKfAoqDDEMGIKqJXxrQJ57lFryeMNyPg=;
 b=M6Qp7OCFNy4mLK6Ekq6PNtqj4ADGEd2h9JcDrKfrVtgWEmUoVsQVJzP5WEbdq685U+UFdyVm/QW66fn3yJ80TalC1QvolF2OXqgSVK3QpLxl+aU3mcvUUp8KRmhS75FcK6JUZEB+ckg/GFtL1n03Pa87M0fzI7u1LaEf1ICC+LC3gdf8HMULpDdkzhY9pQe8DpKqDItykFqJiAwH9r1v/crvdF/DP6FVAPFz2gEo2k9vwp9rNEhQw/5jwdjt7ru/KhRLUwBog3OtnOz948Uttbevq3a2V8gC8H238XWUWeZ8VdOYSbNNrDnvJCWszxwL0ERZubaT9R1U9C2xP5PZLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjA3YDYEX+inKfAoqDDEMGIKqJXxrQJ57lFryeMNyPg=;
 b=e8Nfg4qr06FqX6y9ITizNh8JwjjLrQdneO/XeSKNyQ6Sv+j6AtaovDJXgDI+ma9X/+0j+QkzEEaumcLABDCCVkODq5qZyz3xHe3/pIC0ic9qblL9gxn8bwEdKaTGyx8Dmma8clJJNnPUWLJk+RL0rywGWe2Kyp578smHLCV20SQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5928.namprd10.prod.outlook.com (2603:10b6:8:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 15:19:19 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 15:19:19 +0000
Message-ID: <a87d48a7-f2a8-40ae-8d9b-e4534ccc29b1@oracle.com>
Date: Mon, 4 Dec 2023 15:19:15 +0000
User-Agent: Mozilla Thunderbird
From: John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH 17/21] fs: xfs: iomap atomic write support
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
        martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-18-john.g.garry@oracle.com>
 <20231109152615.GB1521@lst.de>
 <a50a16ca-d4b9-a4d8-4230-833d82752bd2@oracle.com>
 <c78bcca7-8f09-41c7-adf0-03b42cde70d6@oracle.com>
 <20231128135619.GA12202@lst.de>
 <e4fb6875-e552-45aa-b193-58f15d9a786c@oracle.com>
 <20231204134509.GA25834@lst.de>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <20231204134509.GA25834@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0056.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bb691e6-7834-42fe-356b-08dbf4dc630d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0Abm/GwUqgn92jSKwarI0t1ASO0fR6BhkviJ7rfXm6alZsLaAaz7s/zumT47zHhvReYSg8wdM4P8Tv9So3e/C2rhfBhIEAh6on7rg3iyOeIP5qn99Jvyyu9COS2jWetseSnORI45T0sYXNO3JObkXqn5pxyJB9x9ciaY4T+amIw7edMexwi4YTiPHxQKESAU1CxaqZ5UHqUAXqcPRGCrAPn7iSNckTyZTDDvBjVCZOpmaV/Xiz2+sBtiPcrkv64P8zZy6ZOqtiX0UMq+aPYceUpvQt40aTIfYGZbdpudvA/eQxrT4iA8PJQo8uU8o6kZIYQwS9j2skaw0eTRVLvkP4y4ems6L1ts+sL4OP0AxC/fVbON9Q0yfCw72DjgXR5Fc1tONXvfgjXEjOEVFoK9w4gC2tZj/GBvZA3EHlkwUanKpLm7gzi9ATcvFGIx59yeASeTIeetEu07UKry5bkByeFImMqvxPHfd6jASjxzqRHmfpTLquG7yd5G0LFK1Ni6ORqJfWcV0bf3QA6xDo/VLKir+eCcWeQPEtisq4Js1BiRARGvwEfQhn1GPiibQTK1b8bpITJ+UECip56epn9bv+ZE/sJsvx5aPGwoLIia354lPxcwELLdMw5JzwpAwN/3fvwrEj1PD7ZVLQJqkmLrDQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(136003)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(26005)(478600001)(966005)(6486002)(83380400001)(36916002)(6666004)(6512007)(6506007)(53546011)(36756003)(2616005)(316002)(6916009)(66476007)(66946007)(66556008)(31686004)(38100700002)(5660300002)(4326008)(86362001)(2906002)(8936002)(8676002)(7416002)(31696002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c0I5NTdFSzJqUmZqd3F0RDZQVzNVVUVFcEd3MzdOTnBiQzk1QjVuOFJPQzdO?=
 =?utf-8?B?a0RwKzByRkt2Nms1elVHY2J0R2FMdy8ybFVLeUJ6ZW9kdUs0akJXVlRsM3Rz?=
 =?utf-8?B?ZDdWOUE0QXZpVXpYVDl3Y0cwdUhEQUxBa0xtUG9vVEdnS0VPci9ObGdSWjdD?=
 =?utf-8?B?UCsrUWpkUTRpTk5QNE52bzNTUkNZQ2MyWk5xOVd0MEt0VG9rWTZwRzYwUS84?=
 =?utf-8?B?dlFLazAyQ3RkYnkxQlJhc2VrTnN6QVBhb05mSHhlMU1XM0ZnWHN3WTc3dG1J?=
 =?utf-8?B?S1paTmxyWkJXa0JtS1ZEemEwb3pUZWFwTVFDUHhOcmVkSGpuMXp3Vk1UU0hp?=
 =?utf-8?B?L3FzdnhWSHRlb2c4a0szUlV2Umh1dnZ4dWw2aGpLdW96N2NtZVlyd1ZjbEZD?=
 =?utf-8?B?VUQyYVlpc1o5cDRKQ3NUUmg2OFlXRkpQLzFaRFF2eXNkbmZmZko3SldxUVdZ?=
 =?utf-8?B?blJESEtYL1ZhVkQvU1ovMFVRMXJSbGE3b1JjYUlYbUhVTWo4S0FBVXJrTnoz?=
 =?utf-8?B?WXloN3czL1pzMWJCVWtQaWxBMEFkd1FkNzI0Vi9IYXRlK0t5N1B3RTl3ZHFQ?=
 =?utf-8?B?bWFNRlAzYytvdDRNTEN6eWM0ZkNDT25nSFR5RVc0N1NMY3dkTGRVRmFWMlVQ?=
 =?utf-8?B?MUNoNDR2cG9lSEVRbTljVE5JeGNnak9yaFcxODVkQ01IZWJCUDJIQnJyTjh1?=
 =?utf-8?B?Z0pON043V252ejl3czVlSUIwQ1J2ZFA0UUVydU1TV2tBa2lqdmJ5bGRVY2U1?=
 =?utf-8?B?VGxadmZJVXJpcnZMZ2YyVVgwcmhFaG9PZXR4UUZoVmx0SmFCamNkc2pYenJU?=
 =?utf-8?B?Tk9GTTFmaFErMFNPT2hKRmpoVVVMbjZMYzA1U2NCMnpqejE0OUhLTnZtbzJ6?=
 =?utf-8?B?TEhwS2hUWTZNVkcyZjdkYis2TGpVMUxtS3lzRDZHeVNSWmZQWnYwblk0cE5D?=
 =?utf-8?B?VzE4VXV5dzBaNGZmaGYyVEJwRWtpajJmdjJWY2dCcHFsQkI2QXNaMS9mdllI?=
 =?utf-8?B?QlUrMy9IVkdWeWY5bmVYM1dIcHM1QXV0NlFaOTRpY1YzcHFncGdNRXFWdzVu?=
 =?utf-8?B?WENRRVNySUM0aGJHRlFwSnd2YnRaeFBFMU13a1E4bUJOZUVSNU4yYzNGL1NV?=
 =?utf-8?B?WjlmREJGR2pNQThUayt2ZU43MXFRQ1ludGwycHhZemFlaXlLN21Ja0piVWxT?=
 =?utf-8?B?VDZNSFNsYzA5K0Q5aWhIVHFDZnVMNmcycnpTYUdHNjJFTnhXUXpaRmZmWTlq?=
 =?utf-8?B?R2w3SHdKeGRtZmN5U0YzZXFsRWp6NStEUXpJY1hyaEYzUGZGS3lDOXVLMlE3?=
 =?utf-8?B?Nm51YXNpQitNVVh5Z0dQRlo3SDE2eThPNVZNNkExV1N2WlFKYmNzejVxaTdi?=
 =?utf-8?B?M3VhU0VrdVl2Z3FQdDc2R2FEdEV5U0hoc2lIZG1ocDBzcldqTkUwQk5CRStU?=
 =?utf-8?B?Mm5nbitYWG1oMlVLN21XUjUrcHFpRDNOdERNNHFXallPOFE4UTRPdTkvc2ll?=
 =?utf-8?B?c2Vwb00rZXVsclV3Z3B5Zkk4RWUwRVBWMCtZanMyUDg4QlRTSXZxL3F5RG9H?=
 =?utf-8?B?UCtRcEcySzN5WUliNmx4WUlQVVV6Q2RZZlQwVE4ycEpyaHllVmNIeFRXcnJq?=
 =?utf-8?B?bVo3dGdHd1FFeDhMeDFiRHJPZ1k1enZCWmdOMkNKWG5GWGRSNFNLcHkwN3A2?=
 =?utf-8?B?NXIzYnEzZXJ6bjBmMHBoeGJVWmJreEpBTDhhejN4ZkQ1U2E3K2IrQkcxL25u?=
 =?utf-8?B?WmR5bTFEcUI5NTArenhGQ3hqaUNGc1RCU2RJdE1vamRtZkxYSFBiSHhhQm9j?=
 =?utf-8?B?VENpbXdFaiszZFN1elRFUEdYNWFlTklBKzM1eFc2SmxLTzh1QUhZYm9XUWp2?=
 =?utf-8?B?d3RXUkh2cG5aVWpWd3BNN2hTdlFielQ5MUtYbkVyU3l3ajhHb3pDSVNiakdy?=
 =?utf-8?B?c1pGb0MyU1FwaHV0NmdhTXAvSHJxRWpnT0Q1Sm9TUy9UUnYzQk9PQTI0Szc1?=
 =?utf-8?B?L1R6bXVsb0ZNVllhZnNvNEM3Z3hWUTl0VC9QY3RLVUlWVjJGTTdCNzV3ZU5w?=
 =?utf-8?B?bTd2Zyt4Slc1d2pFdW43blcvM1l5VkJpYm15S2IwMkRaNnQwRFpmNE5kUjk0?=
 =?utf-8?Q?LscVRwJ2BpvNCNwBk1aM/tNd2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?aVFkRTlSOW9WQlk5bEtNNmZCN0R6RStnMzJWVkxsVVJGS1NuZE5La2dVVk1x?=
 =?utf-8?B?NzFiMUNyZ255WXRmYXVhUkJ2OG1OaW5rNFEzbVpaeHlVNk83bWdCeXBObzJj?=
 =?utf-8?B?RjFhSWNCNHZ4Um9YUDloY0tYc1RMRUVXZEpZTWNhTE5qWFFWQnZpQllTSVZo?=
 =?utf-8?B?YUtMMkNiVkRQMXVCUE9HMncxTVZNaEg1RnU4WVNSTlM4bUxrMGIwMkMvVkpr?=
 =?utf-8?B?QzBHRitpekdmTlJlSlJQTWFkeE84UG9GOFMvQzNwVmxPRFpPbWtkR29SWmdB?=
 =?utf-8?B?bTZiNmpQVmtnNW4vNTF1WGdXRkJaeHRTeG1KdjhGNWhuTmRMYmxkRWVTb3Ax?=
 =?utf-8?B?bkM2N1dha0xlN3dxMG1aTklOSjhaM0cycVdJMTdVMUlVSDdFL2hhK0NGaDQv?=
 =?utf-8?B?TVlOd2hrdjNaeXpxNGs0UGUyY1JDMzNXcmJqdHA0N2JOdWVCZzZwbVBMSlp3?=
 =?utf-8?B?VHpzdFBZOXhvd2tGWmFqRURRSDFhdWRzdDFXb25ReWpRbGdEMElWYVJoVTNW?=
 =?utf-8?B?c0IxdTlxNW5ZMU5GK01XNHRZSGZ6NnUzYi9DZCs5OG5OVXlvUm1oTmpMQ25Z?=
 =?utf-8?B?byt5dFN1SnNLVlY1U0ZMSlZOdGVPWU5ZbTEvL3ZYT3BTcDRxWmVRRjFQRnRI?=
 =?utf-8?B?RTB5U1dOajFBcUpnckMwTk4xZWZubSs3K0Q2WDZxdHRVaWZSTEdUeHpOSFBG?=
 =?utf-8?B?OUlnWmZhaE9lTzdSanZNVlV2SHNXS0NPMGQ1REcxU05kVUxCTHY1V1pFSzVF?=
 =?utf-8?B?VW1BQ0xBQ1EwZkNDWE5JeWJ1cXY3ODBIS2hYL3FZYTlzMnh6WUVTeWZSSXVp?=
 =?utf-8?B?YUJITG1pejA2UzNJWWswNW1MY0lvcHAyUnZWSHRpdmxwdFZuOHArOVhuN0JE?=
 =?utf-8?B?UnU3SFJxUFcwYjdtVHVLbGlvZnc2QzAraTBOT2JZL1RsSEd0MzFNcHZsU2pO?=
 =?utf-8?B?UmlQVlF4eUhtTXN5Q1J1TW1HRDJXTWRrMzFIb3ZHVjJKVGUvZ0xOekpsNDZr?=
 =?utf-8?B?Y212MmVEZkJXRExBaS9lTmtNcUEwU3JrdWtlV0ZxRWU0Tnc2SGNMaDI4OU1J?=
 =?utf-8?B?cno2UklSYU1PUkJwblQ2SlY3Y2RDVFkwSld0QkZndS9yYm1GVXRGU3R6MENu?=
 =?utf-8?B?QXVqNGphSHdZOEdQR2JQZGEyMGdyNitGb1pmMGw4aDlBMU5mVjNmQVdpVkpZ?=
 =?utf-8?B?WU1hb2lqeW5vazVBUGNjR0dWSEE0WERab1kxQWI0OEhqOENxeVphcHZ5R0dz?=
 =?utf-8?B?YlRoaUQ1NXF5TmpPbUlnMk5CQ295REcvenlidUxZSXFPbFhaMGRZK1ptdnVm?=
 =?utf-8?B?OHdUZi9GOEordFNhbGFFcjBxWDhGTUZrb1Mvd281N0ZwMnBlMjBYUVNsUlpj?=
 =?utf-8?B?enE4YUc3c0IvV0VzVjMxMGZnTWpoSnd6UnJkdU9nK3h3Kzcwb2pxdkUzMENO?=
 =?utf-8?B?bTRJVjBLbmNHaHlxbW51NndQUXNBK2c3bWRIV3JBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb691e6-7834-42fe-356b-08dbf4dc630d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 15:19:19.7071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aiCW0Ldj54Ug3pcZPASH1Oyjv34cSGJB8p/lfAIxytxjMusRnOHYQIAT3daFkIsC9ObvVMzvBqHxV9TpGctA9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5928
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_14,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040115
X-Proofpoint-GUID: SlkNmeT4xmHaCe-VR9s6IAvIiOtMc-iS
X-Proofpoint-ORIG-GUID: SlkNmeT4xmHaCe-VR9s6IAvIiOtMc-iS

On 04/12/2023 13:45, Christoph Hellwig wrote:
> On Tue, Nov 28, 2023 at 05:42:10PM +0000, John Garry wrote:
>> ok, fine, it would not be required for XFS with CoW. Some concerns still:
>> a. device atomic write boundary, if any
>> b. other FSes which do not have CoW support. ext4 is already being used for
>> "atomic writes" in the field - see dubious amazon torn-write prevention.
> 
> What is the 'dubious amazon torn-write prevention'?

https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/storage-twp.html

AFAICS, this is without any kernel changes, so no guarantee of unwanted 
splitting or merging of bios.

Anyway, there will still be !CoW FSes which people want to support.

> 
>> About b., we could add the pow-of-2 and file offset alignment requirement
>> for other FSes, but then need to add some method to advertise that
>> restriction.
> 
> We really need a better way to communicate I/O limitations anyway.
> Something like XFS_IOC_DIOINFO on steroids.
> 
>> Sure, but to me it is a concern that we have 2x paths to make robust a.
>> offload via hw, which may involve CoW b. no HW support, i.e. CoW always
> 
> Relying just on the hardware seems very limited, especially as there is
> plenty of hardware that won't guarantee anything larger than 4k, and
> plenty of NVMe hardware without has some other small limit like 32k
> because it doesn't support multiple atomicy mode.

So what would you propose as the next step? Would it to be first achieve 
atomic write support for XFS with HW support + CoW to ensure contiguous 
extents (and without XFS forcealign)?

> 
>> And for no HW support, if we don't follow the O_ATOMIC model of committing
>> nothing until a SYNC is issued, would we allocate, write, and later free a
>> new extent for each write, right?
> 
> Yes. Then again if you do data journalling you do that anyway, and as
> one little project I'm doing right now shows that data journling is
> often the fastest thing we can do for very small writes.

Ignoring FSes, then how is this supposed to work for block devices? We 
just always need HW support, right?

Thanks,
John


