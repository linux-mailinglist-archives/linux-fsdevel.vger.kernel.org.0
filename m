Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20F84C3B15
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 02:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbiBYBis (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 20:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbiBYBil (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:38:41 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B181B400C;
        Thu, 24 Feb 2022 17:38:09 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 21P1JBGK005922;
        Thu, 24 Feb 2022 17:37:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=KxJq78UvuFy/XhriiFfoujcd7u1fw1nIO0UTBUgz9yw=;
 b=Pew/Qh9adtcESgoULl19izBc7+8pMCX+uSdPDgcyEpvilb2KB2JIDSBvjIPvFBRncQ9A
 JmiDuUnNsWvT/RXceNLCFgH1a2kQeczwhq/XqT/U0YGkELAhCs8e9E1mQgwygHe19lba
 tg1aSwKSEfnMDFQF+D1H8dL5zdtiLxtLX2k= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3ee7a15x5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 24 Feb 2022 17:37:54 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 17:37:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnTUmvKsBi6bWLk3XRlz8M5XoNfAlhouoxqEz73sEDKNeGbW5X+EJNTXpxleyN1fKmr1k3pd+vwSxxdjjEJASn5eLSIgpnD/mgATv9tvAXii2HQxMJ7HgXdavRkhrN2Sbpt6j/rWZxl55wcNdCm9I6NUEis5nX0LzP6zy4zu6kSUAiffD/kMsFfr9bmo8JOyn7MYjJsNQcNGfscb9nVRqlzh5dbkfPJmLnkX5iREFsrLAlh/NG8nwBPxrMSPwNHf/X/wdU6YrXPcGMmD9AvhjHyYLAm3PCTl+uOvjAM/i34etZorhUC0tJjNVQS17HBloa+PwH9oYpaChk3dUlrnVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxJq78UvuFy/XhriiFfoujcd7u1fw1nIO0UTBUgz9yw=;
 b=PeTGTVin+SMEEuncpz84sU8xzkZnmc8ZTbKugNfCPhS1rJguH2gUf29VT5w10jPTKsB9aUGvyJPHloU04B2IG7QoEh23n8p/Vsti79m36fjotJGB631ah79fhmHbz1+ULVkIfC51mQFfWuO0641ZYE62ZfmbDU5hNZxEJejZ6OKuph7KlGgF0RJDs6aNK4spb0Q4ViRwJJBhAj+ZQ//5QZm1+jaQazox5V/RREp+ovWuPZrtR9kCQSB+vs6QcoVxDpdlTcjzc9HlOAnDFgXiA1bcEsfvGzFKUEy0b+glumV9praCh0KcNte7KlDnNx0NLm4LRNGFmgh7Bo1dvkilMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4410.namprd15.prod.outlook.com (2603:10b6:303:bf::10)
 by BN8PR15MB3233.namprd15.prod.outlook.com (2603:10b6:408:74::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 01:37:51 +0000
Received: from MW4PR15MB4410.namprd15.prod.outlook.com
 ([fe80::f06e:4aba:69a7:6b91]) by MW4PR15MB4410.namprd15.prod.outlook.com
 ([fe80::f06e:4aba:69a7:6b91%7]) with mapi id 15.20.5017.024; Fri, 25 Feb 2022
 01:37:51 +0000
Message-ID: <f6fb6fd4-dcf2-4326-d25e-9a4a9dad5020@fb.com>
Date:   Thu, 24 Feb 2022 17:37:49 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH][linux-next] fs: Fix lookup_flags in vfs_statx()
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>
References: <20220224191727.55b300c4@gandalf.local.home>
From:   Stefan Roesch <shr@fb.com>
In-Reply-To: <20220224191727.55b300c4@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:303:2b::22) To MW4PR15MB4410.namprd15.prod.outlook.com
 (2603:10b6:303:bf::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12d4ae91-62be-4cdc-8cb0-08d9f7ff6f9a
X-MS-TrafficTypeDiagnostic: BN8PR15MB3233:EE_
X-Microsoft-Antispam-PRVS: <BN8PR15MB32336001EA4210C9445A0EB7D83E9@BN8PR15MB3233.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eLhP4Z4qctkcsuFr4KgpyUVpglcg2ChFDguX+3Hw7NeL6hEXZjcTxwUnF1aMlvFURcJyaRKOjaKEO3hGQbo9ssYvwZpz0v3vkF1qYLwfBWCgyp0pk+jIK7nAPHG+crss7Od4KGSs49J5Upj0DEcEydQxbyB7VHME0tHzcbq/UDR62GERnDjkSvwQQ9XuASulMXZ0cu08Nzx07LNYSvV2FxqcCiTOzLGY6pLFJz67t5Z5r0KOLLrp+iCa4l/PnUteEdkZEjXfAUGycPUczUrP4ddABAVGc3hurxAf7Yy9nm+PA/DNRu8DhRpnReDWv1egds/F+pSHzxT+HlJA4IWnYw5v/gd+8EtZrBDrLrgDYomHn8oTTNpm7EW2yON0/7LdYRoHDFz9JPemRlLTS+pC9y5rIWtP3PRsRGRTF6Kinqe5EHLe64kORAjatLRMizLIGDYoK54d/9tOmQgiTkiLPKYlFepS71lmwNiSIoZZ491HqUSy/jWzJrjo6ROsbzSGIWnp3SU1JUrWTv3Qo0cvCawbsfMxOtP3J409HTwQNtZLaEMFGhGDukze0i9gCeGRbLyHzTCPC2v+/YVGINph9sh0jsYbZ41CX0I3iDkmo9Q2oJ8AMOvo14tAcj4iryv3O+vz/Mq+tRP9aRDoOL26iDrIvixjQH4BSsic+EMOFvUhxt6tZTXwGAKNQ2tZ58ICwZLAbNXlkESG2Z7eQBvfWByqbDgVuHCLvwkxEMMCy3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4410.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(53546011)(6512007)(6486002)(508600001)(6506007)(31696002)(2616005)(66946007)(316002)(86362001)(38100700002)(5660300002)(54906003)(110136005)(66556008)(66476007)(4326008)(8676002)(186003)(83380400001)(36756003)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVFQTkF6Qk5mdThzTWluYit0Q3kyMm1EWFA5VUxXWkNVakdyOFZWUmxYMFJl?=
 =?utf-8?B?L0d3UDR4WnhZOHRNbVdGYkpZMXhEdDFLVUdCakcvcTE5OExHVndENEFKVTFC?=
 =?utf-8?B?OS9TdXl4cnl3VzFTcVJNYUpHekdWNXpTdmNteklTZ1k5Q0FldFA1L0k5UFBZ?=
 =?utf-8?B?NFZMZjBGa25JbTZDVGhab1BiNG5BWjF3aTEvUFNqRCtxNm0yT1pDeUdpeFd3?=
 =?utf-8?B?TXpJWXJadTVRN0FteXMvNDBjWXJ5Q3RyK2hnMU1pcGVIQkI3S0NWU2w0NXhC?=
 =?utf-8?B?NUQ1UDF1SENxL1JtUjFnNWlDOVp1cWpEbmhCdlpVS3NuZ1VNRldWMFVyQTRN?=
 =?utf-8?B?bGF0UEl4Rk83anJ2Zk5OL2c2UEZIY3RQS1FmbGhLR1ZsaFk0VGZVa1Bad3hJ?=
 =?utf-8?B?WGpCOXR0d3V6ZmJFTG9ob2ZTRHh5bmdjZEFmWWNJSjQrdFV2NnkxeWlWYXpO?=
 =?utf-8?B?Uno5Y2dvODlLcFZFTTVEWE81US8wMlNGcUs5V3dWZFI5N0g1Qk9hRnN1T1A3?=
 =?utf-8?B?d0REVHFFR05Ra0cvWFBOZFpvaVgweGRqTVFXVHlsMk5IT1hlU1VFd3lTRG52?=
 =?utf-8?B?akFHSzl0djRBWmJoUW9qYW03NFU2b2xRR2JDTVhqSzllUlI1SEVpdTVETENx?=
 =?utf-8?B?VUl4RW4rUlJwZ01jM0g1UlBwdmFwTnZNY0xMaFFsU2VsRkY4bFBsL015blFk?=
 =?utf-8?B?MG5mdkt6eFVQL3ZEN3hWNFFuRldyaDh1Qjh2a1FGNzQ3bVhqd3R5SE9GSTFP?=
 =?utf-8?B?UlZJYXFKdjlQaHh3WGVEQVM2MHN6UUdZeHMzdDRJTitrYy80Y3MyME9kYXFM?=
 =?utf-8?B?bUl6WUI0Y0dQbXZueGo0WVIxWnE1SHNzZ1FKUjNWR0RiMDJQUDI2aW9VV000?=
 =?utf-8?B?SjEySnlYQUZZSGhGS1BMMHcwVXkvR3pMcE1PZUd1VUJ2YkdhbHMxb1pqQzZD?=
 =?utf-8?B?Y0dvRVZQTkd2UWU2SkN6dFA2Wi9IZjB3ZEIyOUNlVTBTZTdSd2ltVGxPdldO?=
 =?utf-8?B?L1ZOUEJlZEVvcEF3SDl5eFdQRFBQcXpsNkFFNUIxWlhDblVjOEQ3TUlEeW12?=
 =?utf-8?B?V0w5SkR0ZGlFaVFsWnh5UkxiUFRBUXBEZWNiUDB3bU9ScGpGcUFFVjdhUzNS?=
 =?utf-8?B?ZEU1Sml4eU9pUjIxekloZ0RnUHdhVllSWmZNSTZhSmM1RUtGZmEyOE8yN0Ev?=
 =?utf-8?B?R1pSK1dZamltRlF3ZTlUQWt6MGcySHFVQmdpQnUvUzNLSG9xNU0zTytIb0No?=
 =?utf-8?B?UXYrcE5uNTVGK3BVVmNqc1BsV2lsMmlKMG42RCtvRlR3OXpGS3ZzelV0bFNx?=
 =?utf-8?B?K3lleGM5aWpjZWxzZFdMNnFGMkFIbVVtVCs0RzZJRWI5ODNpa3A2Szlpa0kz?=
 =?utf-8?B?T3NxMWlyS2dsTTdTb3lob2tKenJtenJrWDZtL1NBdjZ6QjEzZE5xZ3c3MkJE?=
 =?utf-8?B?TldSZzZhbnRSQ3d4aE8zRGNxNSs4V1JhdnpVcG8ycWN2TWxnRXZUQU9SMzBk?=
 =?utf-8?B?bm91UnQwNGUzNEhjUFJhRkFTUDhOenZIMmViQjk0TWRxbDdDKzJZRjM4Zkdl?=
 =?utf-8?B?VTEvZWh2Umx5STJ0K3dFc3FzVGMvVTBsRldSL1dBLy8xaDcvSVJnalRiQWoz?=
 =?utf-8?B?c3lPb3lLanRidTl5RzJpUSs1UzZDVEV3VDVEMVAyd0d6WFZMNDYrd2F1d2d6?=
 =?utf-8?B?QjZlSzNCc2M3WHg5Q21sN1pYMVM5ZzViL2d6QVV5OERVVzUvZ0dNZkpRSDZW?=
 =?utf-8?B?aHJQKzk3ZzZVdU5jYnkybHoraTAwdTlCRllFT1dHMURxZFZhVWp4VGp3aWwy?=
 =?utf-8?B?MnoxSmpmMnEyTERpKzhSRXVnaXJUbndidk80RUhidFZSeVpsNm9uUVF0Nk9I?=
 =?utf-8?B?VVI2c1BtTUVoR2ZDMy81cERPQWY2SnhEaWc1dkhETG54L0xFdzNXSWVSTW9Q?=
 =?utf-8?B?TEdyUVNDbTVPMndnOXV6d0dFdFdZTllCNnVITXFTWHZUd2h1UXEwWU03V0Jr?=
 =?utf-8?B?cGRmZW9pR2JRcFpkUWt0UFMwRTNUYlZXa25HTkx4TUs5bkVpdjNwUGxwSVpy?=
 =?utf-8?B?cjRCaTFuMVhvdW1malN0MEdIVjBBcXlua04rNUhSVGpDYTVZVWZXcHZiU2Jk?=
 =?utf-8?Q?wcNLPcVfPLlZi49ZhA8tMGRK6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d4ae91-62be-4cdc-8cb0-08d9f7ff6f9a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4410.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 01:37:51.2162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MmzQY/sOKIEW4v7X3GvF8/CjM/RNzfvWkQDWDQtX7XEQWmWsQM9IgKxpkw8D2Nk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3233
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 9ypzEFXfQ3MH0hWzANbaF7GTr-cb5hbi
X-Proofpoint-GUID: 9ypzEFXfQ3MH0hWzANbaF7GTr-cb5hbi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-24_06,2022-02-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1011
 mlxscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202250005
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/24/22 4:17 PM, Steven Rostedt wrote:
> From: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> I needed to test Linux next and it locked up at starting init.
> 
> I bisected it down to:
> 
> 30512d54fae35 ("fs: replace const char* parameter in vfs_statx and do_statx with struct filename")
> 1e0561928e3ab ("io-uring: Copy path name during prepare stage for statx")
> 
> The first commit did not even compile, so I consider the two of the them
> the same commit.
> 
> Looking at what was changed, I see that the lookup_flags were removed from
> the filename_lookup() in the vfs_statx() function, and that the
> lookup_flags that were used later on in the function, were never properly
> updated either.
> 

Steven, thanks for the fix.

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> diff --git a/fs/stat.c b/fs/stat.c
> index f0a9702cee67..2a2132670929 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -217,7 +217,7 @@ static int vfs_statx(int dfd, struct filename
> *filename, int flags, struct kstat *stat, u32 request_mask)
>  {
>  	struct path path;
> -	unsigned lookup_flags = 0;
> +	unsigned lookup_flags = getname_statx_lookup_flags(flags);
>  	int error;
>  
>  	if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT |
> AT_EMPTY_PATH | @@ -225,7 +225,7 @@ static int vfs_statx(int dfd, struct
> filename *filename, int flags, return -EINVAL;
>  
>  retry:
> -	error = filename_lookup(dfd, filename, flags, &path, NULL);
> +	error = filename_lookup(dfd, filename, lookup_flags, &path, NULL);
>  	if (error)
>  		goto out;
>  
