Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169D544F007
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Nov 2021 00:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhKLXco (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 18:32:44 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43618 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229674AbhKLXco (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 18:32:44 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ACNKnYo015938;
        Fri, 12 Nov 2021 15:29:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=dI7enCgI0M82oqaWCwpQmzL4ascZK1msq2C1gjL+VoE=;
 b=rUNxrv7SmzIQ3rTGfWGQUqhGEEfzdk+AkbP2IstpH57GpS0Drl7tYbS3FIcKJndDTH5N
 k30/l6HsnMp6qUWP1tK1ZE0FfVRzMZFVRU2aqyEbTroj5iuVMSk/clvCzF0Z+abpJ/EN
 PihpALI+TB9Gv4aBgae9swTAM9VMpyepUWs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c98k5b0wq-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 12 Nov 2021 15:29:40 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 12 Nov 2021 15:29:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBr9WnF7TM9OnGH1caQ3+TMR+gFatYurWpQxQ7UIUQUOnTaREnDEGAE9bJjwssxxy8BUKnnLXgq9lN3zioDbndveiBQnmKTTEX3uPVtkSVbwhxRxaOxp1+J7jrweU4W9ieZ7dzB9TaxDkx3pq/9JZVaSRoWDvT9ApqGBaI+m/520GzNSpiR6NwFo19DjmxalA2AVHXKkH5l2H1+N4o1qq6sDZNgKdvXM8yrKwhr7x42fUF3FR/5yKxYNh9u5x14rUFYmCHR59cezDBVZPJAGxlhyvcM+T3dyMa0Wljs1txvSgBZv0baErvZy77ZCEZ4LjV9ZY2f/yZZ18jwwQ3nSLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dI7enCgI0M82oqaWCwpQmzL4ascZK1msq2C1gjL+VoE=;
 b=c3QKDHImPipQPKsgf2z2wMBHMTFdvVV2RUxYP3YXXeVP8pPGC1nPnlDSaS6VKKCdekYs9iIyh7FZ78cxuYW4bUmef03OOoyL78YYg5anGJneOOLDxEgdzjPoITmGfMH9YjkLivUAjKYXkviGxxpPdzVKfl6+h+iIdE10lePdRBaLPIC5erQAIeBqm+DPuS9N3516K+FXQ5IFKQtPVczbMRPIPBt85f3XH+FZD/2nBlPQr7Og5Js+xwGYRbGiH+k0Pwp2UmBmLc8fqRmoMyiG2Nfad6W04x4V4UVZHTO3P0P4s0HDkX/n6VuJYcfmf8INYDEys7AU+NKKcuBL2izuqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: ubuntu.com; dkim=none (message not signed)
 header.d=none;ubuntu.com; dmarc=none action=none header.from=fb.com;
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM5PR15MB1708.namprd15.prod.outlook.com (2603:10b6:4:5b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Fri, 12 Nov
 2021 23:29:23 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::755e:51ae:f6c:3953]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::755e:51ae:f6c:3953%6]) with mapi id 15.20.4690.026; Fri, 12 Nov 2021
 23:29:23 +0000
Message-ID: <0515c3c8-c9e3-25dd-4b49-bb8e19c76f0d@fb.com>
Date:   Fri, 12 Nov 2021 18:29:20 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH] fuse: allow CAP_SYS_ADMIN in root userns to access
 allow_other mount
Content-Language: en-US
To:     Christian Brauner <christian.brauner@ubuntu.com>
CC:     <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <sforshee@digitalocean.com>,
        Rik van Riel <riel@surriel.com>, <kernel-team@fb.com>
References: <20211111221142.4096653-1-davemarchevsky@fb.com>
 <20211112101307.iqf3nhxgchf2u2i3@wittgenstein>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20211112101307.iqf3nhxgchf2u2i3@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0289.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::24) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c0a8:11d1::1052] (2620:10d:c091:480::1:408c) by BL1PR13CA0289.namprd13.prod.outlook.com (2603:10b6:208:2bc::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.15 via Frontend Transport; Fri, 12 Nov 2021 23:29:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 047010d6-f8e3-42b7-06ad-08d9a6344229
X-MS-TrafficTypeDiagnostic: DM5PR15MB1708:
X-Microsoft-Antispam-PRVS: <DM5PR15MB1708C78EF4C019079E3DC45EA0959@DM5PR15MB1708.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +G3FNxbfcFiJuWPDXN5mQV4pLItioycw7sp7KBjR2/O0I5p9MhvHGeJ35OLkQXFrAK4b3QLwHOAZkyfbjaVPEN3s7T2nFMMxWWYmdAQe/qL0hC6xNJNF9fT7b7CJ/eBBarH9cB7airD2LdAO53FEQ1VuB5GgI8b9AW4TPvvpzO7yUZRV3ltLmVLqoFWQj/0z2OnTW10gbiF8YIkEwndi+yLWA+jpWPM7+qs38QpSdnyUEIGAm9D0i+c0hA4qmSNcOYi551mjiwELh/UbHqm21Jwp1nfPrBfqQyjf0OilcN1mD+26RMaum/j+6c2mJAFXe7NlPskBFoB2ItB+Zsq3kowa1RDwUCDBpyeAA/etR9tfprMFUDg49OTl44e+08GBBdfACHYTvtFEcOPm/cCH9mcJnYULwL5Sh6ERZzwqVBF+y88hP5Xy/4Nfy55ls6+2+BNpxCRyritVehzAkjoBSBy3/aME+4raeOtFUdVTkw1lJxcHfsqerj2pNZXO3WEEnIGXq4iirWSH5Qf6oXJyWp5SaU6xxMGs/hFKLXF1+qvvXFgpQXAqHehQmNOii1/cY0FBybFohWav8iqAykmyZ8ebnnWgT+3hlI+p3bBpfbe4CWHX32hyjNtVzSwUH+XTsz5XQkeMdUTLEYYDevUgbtKcIrE5UV3+aw6Dpq0MgDODwTOeEv6JjJUHRUJ32nZtqdjKoTzhdd80yt4SNF11jADv3w0GAPKESuobeyZGsyM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(186003)(31696002)(31686004)(54906003)(53546011)(2616005)(316002)(83380400001)(508600001)(6916009)(5660300002)(66556008)(6486002)(66476007)(36756003)(4326008)(66946007)(8676002)(2906002)(86362001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUNTdE5xN2VpRE1tRTdiUEVITjNxc2VCdnVHT0RBVklzOWtPcktlSFdZR0Y0?=
 =?utf-8?B?MGxuTnJKVUQzZEt3cG9DOUdTVmU2WDBvNTN5Sm55cnBCMnZlVThJejQxaWFZ?=
 =?utf-8?B?bHdvbHNIdzZySjZMMm1EdXRQNStrTzFXeVR1UzhTY2RMT2k5dWNzSFRzQy8v?=
 =?utf-8?B?U1pXZWRocllXYWo1ZlNMT1RPblJhS1N4RVNDUjN2cVpHSENrSGtDOUpmeHZR?=
 =?utf-8?B?OUtjLzJrMzlCS252blFCcGFUYVlYcjUxNzYvN2R2VzgvVUREQlh3TGhXUDMw?=
 =?utf-8?B?V0VVRExUNXA5TDh2SWpzSWRncTZsL1B4R253bDNXVlhyZWJXQmpUMXZRTXJt?=
 =?utf-8?B?cXRPZXVPSEt3ZytyWGlMc3hCQWpnU2tHL0FpRWtVSnJ5cExDdThCNU9keG81?=
 =?utf-8?B?RE4yY0pGeGZnR05FaGR6SmdmZ0FENE9jUGlEcS9FeEViRHJNdlRBQnJVWWN2?=
 =?utf-8?B?WE1LQjljVURVS1poZTFJY3N5RDUvN1RJM0QyV0oxczQrS2VicWp5dTN5SnRx?=
 =?utf-8?B?QzlKUUxyZHFRVVp5WlNuMGx5UzhIMFAvNG5DZzgxSzBseWc2Qnh0OU0vUjMw?=
 =?utf-8?B?U1VPdmtZY0pQTjJkS0FONFdQVzcwKzZnR3VXbW5zalBYRDEza3J6KzQvZnlr?=
 =?utf-8?B?Ni9NL1RIdFZpeWgrUGZCWURUcDZwZmlCanZXTjRIclVKdEdKOFk0R0ZRRWNk?=
 =?utf-8?B?WCtNR0VHcCtFSEt2d29sRTFRWmRiaHRvakFhdjMyZDdYcy92YXMyM05rZURn?=
 =?utf-8?B?TUxxT0YvcSsrenlaUXFQdFdsQ210dXhDRWY2d3lvbm5rUFZ1QTB1dDhYK2w4?=
 =?utf-8?B?UGc0dGEyU2ZwTWdPOE9PK3RZdjk4K2pVcEdKRW1tQyt4V2lWMEpLZWVhUFR0?=
 =?utf-8?B?RVZ1MUNmTlBRVVp1TEV2ZDJnYktvUXJpT0hrOG10dnpYajZab1FwNmUrcHRS?=
 =?utf-8?B?T2xUdkRSTktTVWc5N3lUTGRzaWhzSS9CWkIxTjZ6YmloemJWeDdoUnhtaDd2?=
 =?utf-8?B?anJSVlJ5T2Qxd0grWHk0R3I0b0d6VTllK1Jqa0pIbzFrV3ltUmp5aUN1Zlha?=
 =?utf-8?B?QmJLczV4aUdCQXJ3cnpxYjVuVjVobXBSc0xFWnFTazlxRThDSFIydCtyeEI5?=
 =?utf-8?B?SmJkWUdnQnFtRHdVU1QzRDdqK2ZSL0xLRU5FSSswUnpOcjdJcWxVaUcxbFdl?=
 =?utf-8?B?MGU1NEwwMHEvRGJYMkZiVmhSTlBUTmFlNGZQL1VqR3B2TS9zYVBCYVIxMnYz?=
 =?utf-8?B?VUQzbTZtRTBJNUFHM0FsK05ncHRIc0xISUtOSEFqazlGV1oxNm1pRmhKaFBC?=
 =?utf-8?B?ZEdOdzlZcGhFSkFVYStkWmtFZEFEeTZRY0lwdDlqNGR2d1RlQ3NKMlk1NUw4?=
 =?utf-8?B?VlQ1YW5aSkVoSXBSK0FhMGFRanQwTy8rNTNvWGE5dnlhY1VtVWNaWGNUcXpO?=
 =?utf-8?B?Ly85TCtQVlhzbXpsQWFXRHB4UXV1QjZZb0Q4a3Rvbmd6SGZmODluL0hhbEZW?=
 =?utf-8?B?dzNDT2NmY1RqVmgzemFmeWxmZEp1cS8vektZSGQvUG9TOW12dytaKy83UEdX?=
 =?utf-8?B?c2FrSlpQZ25FaUw2Nmlua0tmeWZOUVk2QlM0ZFF0akVpV0J0dFpac2RGYkNP?=
 =?utf-8?B?ckQ0MHJuZGgreDhsbnNsc0poaC9jVnQ3VGs1WUJ3dFpCMmdKZEpCZGVjeVBH?=
 =?utf-8?B?Mm9sUS9jRkJUYW9vclZPWXdBdHVZR3pnVXg0WE4zQy9UdmQyTGQ2RjZHdmZN?=
 =?utf-8?B?L0FxUHNIREtjekkwNDBjZE9nU1VGMTc2Q2ZDMTc0cXpZRTloU1ZpZVR5VXRZ?=
 =?utf-8?B?NjlBaUgxODQySWF3V1NYRll3VnlYNVVWcFhQMkVOTW9PSXZBQlJyS2tnWnQy?=
 =?utf-8?B?VDIva2FLZUNuTjdsbXQvUHI1STdwQWVuVUx3ZER1S0Zsek1peVZ2OGhMYS82?=
 =?utf-8?B?N1MydnpUam1ubmE3Z3VBNzVKTnRpRzVEWWRvYm00OE9DUEUvcnByR0IxTkVD?=
 =?utf-8?B?bW9yVVB2MlcyKzJRRlNHcURXclNXNEx5bmxNTkM4SUw5MmlNNGJzZHhvS0pK?=
 =?utf-8?B?ZGJSUGZWNUlLMVZKVUZEWTJCZ0ErUU1kNVF0TzhNbzhXN3J4WUpYb01aM1N4?=
 =?utf-8?B?THBiOXV5NHRYcnRBTjNEZ3FRbDdvVDJxNlNMTWJrUkk2d2FCS3VqTmVXMkRl?=
 =?utf-8?Q?rPtu5a7A4iWVIfIkJtACXhvbSasSPaFKzdXc/xbnePOY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 047010d6-f8e3-42b7-06ad-08d9a6344229
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 23:29:22.9544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/SfCsffKqI6zxiaT0clNpbMBdOA9myQBvFyVjKTuyIYPxjzZyFRMYkEySn3gRy0E4fVczItlNyu3awpwF8cmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1708
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: D4-0U89R-HC9_PgABEkw-bbaEmv5e0_H
X-Proofpoint-GUID: D4-0U89R-HC9_PgABEkw-bbaEmv5e0_H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-12_05,2021-11-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 clxscore=1011 impostorscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111120118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/12/21 5:13 AM, Christian Brauner wrote:   
> On Thu, Nov 11, 2021 at 02:11:42PM -0800, Dave Marchevsky wrote:
>> Since commit 73f03c2b4b52 ("fuse: Restrict allow_other to the
>> superblock's namespace or a descendant"), access to allow_other FUSE
>> filesystems has been limited to users in the mounting user namespace or
>> descendants. This prevents a process that is privileged in its userns -
>> but not its parent namespaces - from mounting a FUSE fs w/ allow_other
>> that is accessible to processes in parent namespaces.
>>
>> While this restriction makes sense overall it breaks a legitimate
>> usecase for me. I have a tracing daemon which needs to peek into
>> process' open files in order to symbolicate - similar to 'perf'. The
>> daemon is a privileged process in the root userns, but is unable to peek
>> into FUSE filesystems mounted with allow_other by processes in child
>> namespaces.
>>
>> This patch adds an escape hatch to the descendant userns logic
>> specifically for processes with CAP_SYS_ADMIN in the root userns. Such
>> processes can already do many dangerous things regardless of namespace,
>> and moreover could fork and setns into any child userns with a FUSE
>> mount, so it's reasonable to allow them to interact with all allow_other
>> FUSE filesystems.
>>
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>> Cc: Miklos Szeredi <miklos@szeredi.hu>
>> Cc: Seth Forshee <sforshee@digitalocean.com>
>> Cc: Rik van Riel <riel@surriel.com>
>> Cc: kernel-team@fb.com
>> ---
> 
> If your tracing daemon runs in init_user_ns with CAP_SYS_ADMIN why can't
> it simply use a helper process/thread to
> setns(userns_fd/pidfd, CLONE_NEWUSER)
> to the target userns? This way we don't need to special-case
> init_user_ns at all.

helper process + setns could work for my usecase. But the fact that there's no
way to say "I know what I am about to do is potentially stupid and dangerous,
but I am root so let me do it", without spawning a helper process in this case,
feels like it'll result in special-case userspace workarounds for anyone doing
symbolication of backtraces.

e.g. perf will have to add some logic: "did I fail
to grab this exe that some process had mapped? Is it in a FUSE mounted by some
descendant userns? let's fork a helper process..." Not the end of the world,
but unnecessary complexity nonetheless.

That being said, I agree that this patch's special-casing of init_user_ns is
hacky. What do you think about a more explicit and general "let me do this
stupid and dangerous thing" mechanism - perhaps a new struct fuse_conn field
containing a set of exception userns', populated with ioctl or similar.

> 
>>
>> Note: I was unsure whether CAP_SYS_ADMIN or CAP_SYS_PTRACE was the best
>> choice of capability here. Went with the former as it's checked
>> elsewhere in fs/fuse while CAP_SYS_PTRACE isn't.
>>
>>  fs/fuse/dir.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
>> index 0654bfedcbb0..2524eeb0f35d 100644
>> --- a/fs/fuse/dir.c
>> +++ b/fs/fuse/dir.c
>> @@ -1134,7 +1134,7 @@ int fuse_allow_current_process(struct fuse_conn *fc)
>>  	const struct cred *cred;
>>  
>>  	if (fc->allow_other)
>> -		return current_in_userns(fc->user_ns);
>> +		return current_in_userns(fc->user_ns) || capable(CAP_SYS_ADMIN);
>>  
>>  	cred = current_cred();
>>  	if (uid_eq(cred->euid, fc->user_id) &&
>> -- 
>> 2.30.2
>>
>>

