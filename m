Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191FC4166EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 22:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242967AbhIWUvJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 16:51:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:58650 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229609AbhIWUvI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 16:51:08 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18NK0RiO000311;
        Thu, 23 Sep 2021 20:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xcv/nwufqS9z8/UAKKOOZrKAoOVrDm7WAnwaW0Za8uc=;
 b=tmErpvanYDf5e0OxdxKqEPouJuA9r91h+kxyxJ2r6dd45mubW9aiTw3k7wmdDN+xd7B3
 kRnPAdznpxdkA01j9V0T5syYtAOTTyCAmPxNpVDKI6cd6pkiHxjm/yqVLDowpC4kX0Qz
 FkiBIYworghejLMfNBJqizKMwE8ZHJuXgiQBuTxWtO0E/biC4WazETHZYL+c9nyQktiR
 UvQ3N5NJ+2VkZhQSR6GEEfrri2WmC+BSo5b1VqGaMF6NvbRjidvTkzR6mSXk829/gzaT
 Jix1XL4ZbeXQHOa7gbxaqOsG/mXI7w4UU947/6HCebxhmfwi87wlJXuBbA5OR2JQGZ/z 1g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b8neb5chh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 20:49:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18NKjhGZ092111;
        Thu, 23 Sep 2021 20:49:00 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2048.outbound.protection.outlook.com [104.47.74.48])
        by userp3030.oracle.com with ESMTP id 3b7q5q5j53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 20:48:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwyL9GXHYIqGxgx+N45f/LUvsVb1JLp1uqGav1EPAK4Sa/es4iFV7CuAmavJoedLUE9milwBlvZ80L9iSRPVcJrZwRS7StOsAws58LGmG5deAMC8UMFKgCNnmulrR2AeMO/SO8WtluMCAMKwfMbE5g6N9892m9sM8Nkd7Sqdv+fKh6py8f9JM04fyTWz4gf9u6G9yRnNWHlYvfltdAgdB97EDPibpjF+CvrQ1FoEz9MSr5kSHfgNbrxVjZCH9DMY6zgfrCbMnxgrYqV//iqtm9t764yBbPR6jSkRwz9MGC6EXXsJQbsNvUbcb+ZCDguTFQDYcPtOt+/+8oGteyQDlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=xcv/nwufqS9z8/UAKKOOZrKAoOVrDm7WAnwaW0Za8uc=;
 b=nfWzxabr9B4m1P9d45pZiUHdWLMhY9/aMdaCzazK2rWP0d2edWSemI3Umg8wMDpUCpz0PNengYD4sm3X3+0WQD0taYsBo4YbDFvWOdhGg0hvAucrcV+iQjjS1g8dQBwYP70feyUxCLILyCSoB4al+5fNIxrYJEXflkqgAv14ugJrZGfiWO/p9fwfEvlNeW7nTuy0GzgC7C2AkhpAcNlHrcXJmKiwOapP06iiFT99/CXelW8dZ8FTWnGwu8VE6AcoMBlHmWnd6rcFPEml//xf4x4gVmDqE/QbavOBypVbX+rncBtZLmbKYqxVt+EKM5LgRz3W5S4n++YPjTX3pALV8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcv/nwufqS9z8/UAKKOOZrKAoOVrDm7WAnwaW0Za8uc=;
 b=GbwNauvqP+llh6FgugtBwDTtajPrGSIl0GT9V/PaSeK9VQVhT6QUGn8Pay8rrWfmdV9iJiPnyIJGL/kakJH1hXqb0YA8CLg/kjHHHq6wd+69q4Pi9IxZsBg+Y7Op+n7qGKo8Pn1raSFgpM+++wAVzvlOQEztXseYHE4XHQKZsLQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB5646.namprd10.prod.outlook.com (2603:10b6:a03:3d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 23 Sep
 2021 20:48:58 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c%6]) with mapi id 15.20.4523.020; Thu, 23 Sep 2021
 20:48:57 +0000
Subject: Re: [PATCH 0/3] dax: clear poison on the fly along pwrite
To:     Dan Williams <dan.j.williams@intel.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20210914233132.3680546-1-jane.chu@oracle.com>
 <CAPcyv4h3KpOKgy_Cwi5fNBZmR=n1hB33mVzA3fqOY7c3G+GrMA@mail.gmail.com>
 <516ecedc-38b9-1ae3-a784-289a30e5f6df@oracle.com>
 <20210915161510.GA34830@magnolia>
 <CAPcyv4jaCiSXU61gsQTaoN_cdDTDMvFSfMYfBz2yLKx11fdwOQ@mail.gmail.com>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <90031bc1-9bd2-635e-8513-1948204ffcd7@oracle.com>
Date:   Thu, 23 Sep 2021 13:48:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CAPcyv4jaCiSXU61gsQTaoN_cdDTDMvFSfMYfBz2yLKx11fdwOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0022.namprd11.prod.outlook.com
 (2603:10b6:806:6e::27) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
Received: from [10.159.139.16] (138.3.200.16) by SA9PR11CA0022.namprd11.prod.outlook.com (2603:10b6:806:6e::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 20:48:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 623fea63-aac0-46bf-3835-08d97ed39077
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5646:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5646D4CD81EB37377CA67E4FF3A39@SJ0PR10MB5646.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YmbhGs0B5OFDigCWNOxBLb4ufpw854O3OxqVFAky1/pSJT8y/kL+X2m3VMUawnJ78Bk5KZyzZXHZh426yu2jMAsKzIbTBg+1oxBe6eaoHaFolJ8N2m6NoxzfFPpVKniy6E/KTarG1DMa2VJx41YLXHdFDb44Nn0ahWytwPml5ODAMMFt5I4CedFsbPeO76SD+NF99tPfJzQ2TPB/r/rbG37VV8Ecy3MQcb2xck/kwh9w45JY1t7YTZliOXJCZ5HltoCB2acGM5qMIxsKFHIDQVYhISaOOtERViLmTHU8nMWv2nh5BlJE2txsEgntF6Hn6FoOexhBYbv0AlCWEem1TxlcaxscjejkyeAOnHQPFXz3pM+qWy4Ta+SoZBUAfEGng9hfTJD814T9tsAdpKFcTjaGr6CliXZvWHGQ3X0hYlMeR2w6pXTxn0VQjNFJHGI74VmpFHFZpgmNbMr7a4RDU6gV0g2cPb0NKJci7HGkw3vnS8NdnqRdsqRnurxqEQIGsXiP4u0QN4hcpm0wJIPa09cuLiFbV3Fy21aWNdJ/3g9fM/j8CkB1Wt6XXjm4g4L7gPd3VzQ7mFQsNudh4UE54Z99FXpcY1cjMP61L/HPOfKOQA48k4ww3TSylm3uIRfD1Pl+BtJrCVvFX6kHdmLUWi/agB05pkaIagyeDKdEfnJHBK49FtERbS1N1HRxWH6lY+cbMGzKpnAHa8+74aVty2D95o+UU2+7Y54W+wT6K1w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(7416002)(66946007)(26005)(31696002)(54906003)(2906002)(4326008)(36916002)(36756003)(53546011)(316002)(6486002)(5660300002)(8676002)(6666004)(956004)(110136005)(8936002)(16576012)(86362001)(2616005)(31686004)(44832011)(508600001)(66476007)(66556008)(38100700002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm1xRTlkRjV6VVdFNzhDOXZvUlhIcm1La1M0TzBubmVha3VnNlFFUFFtSGRh?=
 =?utf-8?B?eDRsQVYrUkZXZXhHS2V4WVp5RVo3YVhmTVhjN1JFU1JHcmhpcjdKRHhVcS8w?=
 =?utf-8?B?aUVRSkpZZWFCYkhDYW9tVCtLRkE1ektPbkhPV0pTR0kxdWZrQ0NYa080Mmcz?=
 =?utf-8?B?LzRXM2E0VjRoek9oUW41dUQ4RWdpOE4vVEZxUlZuVXlGSG5UVmkvV3d6NDcv?=
 =?utf-8?B?cmhSR1g0dmo0MmZUbGE3UUpHWFpqZlQrSzg1ZkFKUnJ2czB5Mjh4QTZPZ0Na?=
 =?utf-8?B?b1RpMXZHdzNHZ1pCRVQ5S2tQejRzblQ5RDlKOFFoN3huT2svNkVpSGdZcnI3?=
 =?utf-8?B?M0t2QWtIL29JZGNoVUsyaGFNNVdGSlJjdG5YY0svdTZ5OFRYeXFtV0luR2xU?=
 =?utf-8?B?cTZvaEZCY29kZHRYQzEvVkJzNmZOcDNVbTFma2Q1Rk9wZlhyMG0vNWxIckFs?=
 =?utf-8?B?RkJ2aEZ1RFJuUk1OSEYzVzBmQUZ5c1Q2aHUzSnRRazlLVit6NWlSbU4rQStT?=
 =?utf-8?B?VkE5cFRDUFI1RVhQYWIwWW8wMjUxVjY4cmdMOEFEeGVwbTZIRTFrcHE4UlFN?=
 =?utf-8?B?NHpiNS95ZGpwOXJVKzZYUXpNdVpleGJHZVVOYlF2LzBRN2Yvb2VtSjdDQlZj?=
 =?utf-8?B?Q2NyZGRwVmhFRXJ0NzZHVXpwU3FDcWtPS1VMQ3gyUXp4amEwQ1ZIMEpSZVNC?=
 =?utf-8?B?dDhXblNuQnhOdGF1Q0EycXBRT25FVTE1Q25wWjRpSmtSdmswSHRwTVQ5Mk1w?=
 =?utf-8?B?NFNsTUxyc0hlNWhKTGRTS05xRU1raGdqWDBPekF1alZDYWVtdVRPL1hDcFB1?=
 =?utf-8?B?cCt2bTZJM09NcVJxdmJoUXMxUmNqeHp2OHZWTlBPQUZVYmluUWNCMDlJRkgr?=
 =?utf-8?B?K3lRNjhOWkU1c2NJTW9kTFdBWVZXTDUxSmd1R0gzS2dnQ2lCSVJ6U0J5QU9r?=
 =?utf-8?B?MEt5SHd4NDRUVk1LSGZzZ25pa0RjOEsxSzZZRmVPTXgxZUlHOFRZbjhpTnR3?=
 =?utf-8?B?RVhlMEprN0ZPUGJnOEFueEthRnlVUVF4MlFsWXNQZVBMcUJ1cXRkbUUvU2Qx?=
 =?utf-8?B?Z0RvSWdjRmd1MERsTml2OER1eU92MUVzYXJGQjlneEd6dXF2TnQvNjdjUDhI?=
 =?utf-8?B?anRNUHZpWjRESXF0amFWekR4aXZBZ0NabGo1S1N5S2ZFRGkzZG00QnNtRkpk?=
 =?utf-8?B?YWtKV2g2T3g5UXVzK1ZyTy9LTHBzOVdKOVBSMm5DWmgraEMxSHpucmhCZjdV?=
 =?utf-8?B?MU94emZhOXp2NVkwM1RnN3VvNG1NdEwwdnZCWUFHRGErVGlWa3c5NnFkellX?=
 =?utf-8?B?YjErRzB0L0ZUSHpWSSttUWJ0Z21vK3dSaDloU1ZITDZjSjdnVlNuUWQrbmI2?=
 =?utf-8?B?Mkx0NFc5ZUk0WC9BSGl2YWJHRFN1NkhLRm5OYlk3Zk9YWXZGSUhPMWxGeGJ1?=
 =?utf-8?B?bVpKSDQ4R2JvS3lVTHhVNUo4NzVDQ1Uxb1FCZW9ZTVhNM3dVdTBXUW1nZjA2?=
 =?utf-8?B?N3V5eno1c0tjWHRkL3FBZnE5cVBabGt0bmtJNk5BcVN2NVpWUU9tSlJ6T2Zt?=
 =?utf-8?B?YzNabTJpZHRhMWUxbC9kZnlZSFRVanIxTi9XWWV4QzR4OEU2SzBWYUF3NFh1?=
 =?utf-8?B?WWQrdWExdlhURldJbWZYcWlqaXY5eW9DdzgwVThVMFJNMTlxWVBheE9UcWVp?=
 =?utf-8?B?RjdieEIxYkhYQWJvZ244RFMvZ1BsS3YzTTRpSnFWcW93V1NzM3ZlTHk3THVw?=
 =?utf-8?Q?blJ1UczNLdXp9awWhvszFHWjS7bs6ToxlCbhRZC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 623fea63-aac0-46bf-3835-08d97ed39077
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 20:48:57.8976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SP2FCG6hwpll2CMCPLlYQjXiMaw5gDE86UMCww5NdskaVZ4YWcOgMRqu22yJYV8OX0vdfTghBG2POga7khiSoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5646
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10116 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109230119
X-Proofpoint-GUID: faXaK82v7QnHTKo-_8pjWCUEoVWTQcEF
X-Proofpoint-ORIG-GUID: faXaK82v7QnHTKo-_8pjWCUEoVWTQcEF
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/15/2021 1:27 PM, Dan Williams wrote:
>>> I'm also thinking about the MOVEDIR64B instruction and how it
>>> might be used to clear poison on the fly with a single 'store'.
>>> Of course, that means we need to figure out how to narrow down the
>>> error blast radius first.
> It turns out the MOVDIR64B error clearing idea runs into problem with
> the device poison tracking. Without the explicit notification that
> software wanted the error cleared the device may ghost report errors
> that are not there anymore. I think we should continue explicit error
> clearing and notification of the device that the error has been
> cleared (by asking the device to clear it).
> 

Sorry for the late response, I was out for several days.

Your concern is understood.  I wasn't thinking of an out-of-band
MOVDIR64B to clear poison, I was thinking about adding a case to
pmem_clear_poison(), such that if CPUID feature shows that
MOVDIR64B is supported, instead of calling the BIOS interface
to clear poison, MOVDIR64B could be called. The advantage is
a. a lot faster; b. smaller radius.  And the driver has a chance
to update its ->bb record.

thanks,
-jane

