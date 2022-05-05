Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035F051C39A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 17:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381158AbiEEPQv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 11:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238972AbiEEPQt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 11:16:49 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACF03B3D6;
        Thu,  5 May 2022 08:13:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVF0YqUSKfXwejFEfoatwS3i30sXyqwjKBGEjWhRGqJDUAnh1EKkOvD+ksVtdwleh8+ueqmiE0oLdtkvof7Tin6pOyhUFYzSST+3KNmyfKJa2toaxtIxM0JEBKoMcebCGI0LhHvN7XO/oncNrMUk+a6wQvZCyU2dJBUTddQXil0hFn/w01VrCXlbDsT6AB25imWeVO2KtIjoIBa1Jc1eLdIX7rcaMEhJG4T/rfIoxaK9jbMGWbOhl8lZ3KFK9PTgqwBKIDG2O6WDmFEUjW0a3IPAZqUTSgaPhdSL6ZH1cWu89r4nORNSmNUzDPwP06mHldwEJZ/HKdi7zQELuBTK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2y1nD4Qji8jNOI64ojZ3GUHjCZTt1yP4xV+Q3LL8sgk=;
 b=L11AyY8Md5bMjWo/Ef7aRU5c+WEdyaHf4J+E9byvR4jMT1MsuGcJQAMY7w6tYMZCJ9iLrfAL4FzCju2cPTE7xEKPyDujghQpGD8MGWRQO0IAljB7yYWMXB2gL6y2GTiwc4CDWoch7ashoUjcBUZ5c3Oj2dWeiosyE/yxdYZkI6qf3+uL6RYDueMtpfK2OOvwEBNKbwet9HpOPWYBxiI8hwEBq8GXi9RYzVuypVLjjI7qo+RqLO/RK3B5Zra2CrcJiZOj2ZU1nEawv3MshMUD9QsF96IlhsE4gwC8U1XGTKdKVIV7e/x3ik75uxqxiCWiH7GnwpkgIXQBseP3XRkjLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2y1nD4Qji8jNOI64ojZ3GUHjCZTt1yP4xV+Q3LL8sgk=;
 b=N5MFqcqLdFmRHnDsVWfz0fjNMzbYRSQBMn7mFSVAdCNF6lWHJECvMlOUfblhGUXkhT9dxxIBAulnYEnwmaXIlsa6S6eNbxJ3eFZ3U/S2p4DZW2SAUzQkIPU/E3i91+LaIqG9ScIU/MtjZVX9XhOGShlz9TTOehW5TsYBKjTfhb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by MW5PR19MB5652.namprd19.prod.outlook.com (2603:10b6:303:1a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Thu, 5 May
 2022 15:13:06 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::8072:43ab:7fd0:26a]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::8072:43ab:7fd0:26a%4]) with mapi id 15.20.5186.028; Thu, 5 May 2022
 15:13:06 +0000
Message-ID: <882fbf7f-a56b-1e82-a158-9e2186ec7c4c@ddn.com>
Date:   Thu, 5 May 2022 17:13:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 0/3] FUSE: Implement atomic lookup + open/create
Content-Language: en-US
To:     Vivek Goyal <vgoyal@redhat.com>,
        Dharmendra Hans <dharamhans87@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
References: <20220502102521.22875-1-dharamhans87@gmail.com>
 <YnLRnR3Xqu0cYPdb@redhat.com>
 <CACUYsyEsRph+iFC_fj3F6Ceqhq7NCTuFPH3up8R6C+_bGHktZg@mail.gmail.com>
 <YnPI6f2fRZUXbCFP@redhat.com>
From:   Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <YnPI6f2fRZUXbCFP@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::11) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1883f3a4-b6ab-41f3-140d-08da2ea9c193
X-MS-TrafficTypeDiagnostic: MW5PR19MB5652:EE_
X-Microsoft-Antispam-PRVS: <MW5PR19MB56525C60261C07658FEA9C4FB5C29@MW5PR19MB5652.namprd19.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K9VEv+I1/aCpoM4vOEn3gbtovoAM2T4vJWew/64c7RO7sYvPo8jduxgrcHVniXM4c6vjI+y0PEiCi93ZeeH3YphadJeEywd0ky/xrxFtbTDDhbhr5TXcXfecSHIThRXiJn1+D/czu9bivVA8V7tZe9NjcpqyFkGTO66bUFcLZ+cXR9jVAYJbwQ5E/UzhoNve+9kRFcE1t9UJiiNyWN2XrwpKGBJvpM+eczea/dBrJCV6+KMsi3/0ofZB93/755dNBri3xg9BUPcWWX9Iy7NUSUk0pZcegGDkdBh7vM06JDVTfmVDwhWbdiVklLjvAcDZTDqVExD/oiFiZuSDO+dlqy9biUHeDGYVx5JQ4sYaBfxmTTn7aIPpI9nLKY+65+B6DopPUl7XVE55MEqggdxW4VXT87WOgLymlUGaiv92Y5iI2e8+q1xhQKxwdPOStzOp5ZvVVYSE3MldVz0VJWEKMPV59nmmDa0YLYfbdxyRoqUF8yXbbE4L25CnXknxh20qKLRBey4vsefibMuoId1Q00fpvP5lgLt5AiTsaah6lIk2F0zb0jSmKu2DkDnnZBM1/WAcVuDuSJNJamcgwxXliKJREapLyPy3AXjzl6tG9lMZh1xXX6/IVXFrsUehJGCdJ711Nfy7gaRlFydWHGohgr64BsCb1bWYNwJBc/PuRvsHDJl3lRFnuJdHdQo4v08NkSGp6bxwVq1kdzbEQtbvuonaA4WImLcQEr1bdxLO1KgH5TZHfJpIl6aHL5AlhrA9wIQLRjPnZIxhl7DTCKJH4yVkheMNGvnuXuJFF0j1OPe93sRF0Z9ROcTyz4fUEpVZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(508600001)(966005)(6486002)(6666004)(54906003)(5660300002)(2616005)(110136005)(186003)(86362001)(36756003)(8936002)(31686004)(6512007)(6506007)(53546011)(316002)(2906002)(83380400001)(66556008)(31696002)(66946007)(4326008)(66476007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aitKM21aVGpnMUluSmRlWlpScWJkc2JzY3NRQUpObTFCZGdvU0M2RThNYjdj?=
 =?utf-8?B?TUJPYU1vY011VERGRlBpbmU5VWRsQzlTUGlDZmNHUURIeHFEcm45SFliT1dn?=
 =?utf-8?B?VTZ5aXJyQVhsWlVIWHRxY04wWitOOXZTSm5KakZyS1I3TEdtZ2EwU25mTTJZ?=
 =?utf-8?B?V0Qyckd4M1pXUGZ3Y0tEd251YWN1dUMyYWN4MFAraDVjSVZwVmt2cDhZcnVH?=
 =?utf-8?B?K3BGbklmN0xadHduK1ZlNkVuNUtMb1pTYjRhZFlYa3FGZnhobjdoU0lHVUM0?=
 =?utf-8?B?cmwrbjl3ZkdRVHJ3SDBVWU1YMDlzTnQvNUVWNHd6Y0pVbTM3Zm9EUlFNSHJ5?=
 =?utf-8?B?SFBYblBtT2R0N0o3V0JOcFpqYnVFUXhVeG1pUzJuazZvSHhnSnVGdjREcEJQ?=
 =?utf-8?B?cEhBa2xaSlp6RnpjN3VZK00yb2FHT09NM3FFL1BnYzY0WmdWa3hTeXBJUEkv?=
 =?utf-8?B?WVlGS1V4MWVjSDFySDd4L2ROQ2IxV2RTaW5WaUVFRXFTclVmd3FMd2tOelpa?=
 =?utf-8?B?MHdKcDdGOGtmQktVK0NseXgrK21HTVo0WTR6UkplQTM5SFNrZXdSN2pkTm5Z?=
 =?utf-8?B?aGFiVmNmWnZMdlZ4dGdXTXZxakJuZXJyRGtYRUJCb0JDTnMxMFlZak54S1dN?=
 =?utf-8?B?eE14clJxOGg0TUdTaDBzMFo3Y1Ywczkyc25NQ2N5YnM4SDEraEd2RGtyZk4z?=
 =?utf-8?B?UVVBcGltcm9BdE9LVk5jdkJnSFRaOGZoM1cyRDE5eVdMcEY1VDlNbWR1dGJw?=
 =?utf-8?B?TFpSbmlrSGpzNVZIYi95eTZSS2UyMzg1T015bUNuQjRsNW5nUkxMVjlrQzdZ?=
 =?utf-8?B?cTdzRjNPZGxBN1Z3ZmdSMzhCRmhrb2thT2RoWVhwOGpkVGQrTkFVTXVxYmVl?=
 =?utf-8?B?UFVmVjVyallPMWwxVlhwMTRTMThpTDJXRHdRNTk0SHZHS0dtUWhhWDV0aU1s?=
 =?utf-8?B?bWY2TmlHYUdkdU03SUprc0txbUNHMThQVWlFYWpQRFZpUzdINEVUQ1N4RUQ1?=
 =?utf-8?B?NGlHcm1kUnNIa2lJbXZ1UUdUMG02V3NVSlRrOWZtczFXclVHSTgvdjlHd2Nj?=
 =?utf-8?B?TXRHQmhKNVUxOEFZdGg5TS9mMXdhUmNHcFkwL3gwMUxNZ2FCK2xYV1plaGFm?=
 =?utf-8?B?TWJiTGZaN0RFT1pYOEx5ckpoZWpyd3U2eGNhTkIzVEJXVmZLQmhyc1NZOEdD?=
 =?utf-8?B?cDMraXhmaCtLcm42RWc1end6M2VJbmVjbXdUTmJ4YzRZL2ZxcW5oajM3TlFD?=
 =?utf-8?B?V0d0b0p2WW5MaDNrbGFPK21JaTI5bHFzRlFjb01DRHB4NnJVaW82QVBiQk9v?=
 =?utf-8?B?UXREbzhHZXVYUEMvZExKbnpKQTVSSW5xdVhGL3RRdUtqZlc4dHYvakVLK3ps?=
 =?utf-8?B?TCsremwyTGw3TGJLbS9wQzQ0K1FXaEdSSjRDT1dUUXROQks1b2xjUG5IaVV6?=
 =?utf-8?B?R2l1VU1UNGpHcWhjNzczbWhlTFAvVlcyTk16UGpjNDN5VGZKaUtsQ1hMT0JR?=
 =?utf-8?B?UTlndnRlU3Q3VFdMSVpSL2c5QmJmdVJUZmJOdTFzam1vYnRUaVFiQytvZ2RU?=
 =?utf-8?B?b0M5cDNmejFmNmFibWMvaElac3BOOHNCSzMwOWkvUTJld3gyeGt6L0VBckFj?=
 =?utf-8?B?Nk0xenYrMWpkUEdOMlovUnpiVG9NUFZZaW4zSFhwKzI1K3lkc2YrbVN4dEVo?=
 =?utf-8?B?bElCek5QbGhpYm5ycUZRMUdCRFg3aHNRM1FjeXVmTGxEZUpPNVdOUUZlMzRI?=
 =?utf-8?B?VTJUdVllTHMycEZoUXFqaHg2M1N4T2ROTEIyNkVkaVB0TFp4eS80dldDQkFO?=
 =?utf-8?B?WlVoRXZPUWVTdERuc1hoUy83ajY1OU51V0g5Sjl3Z3ZsVFJab2w1NWRKUWc4?=
 =?utf-8?B?TXhBdlhkczduT25LOGtpdVlpbjN5bmR6UGVXdGNoVFhod280T3R6Ym9QRzhl?=
 =?utf-8?B?MWdEYmJIMjJQdndmbVp1QUkvR25ORmEwSFM4MldsZmdaRFVxZVBUNVh0K3o5?=
 =?utf-8?B?YTdueURXRWxobDJJSGU1c28xM0Vlc2tMWlhnMnd3VVFhTFZwTXZZWDlYZlJK?=
 =?utf-8?B?d2dhNTE3NjFwb2dsWVh4U0RGMDBIbFpUcDhDMXRuVVJkc3ptVWFqRGxvb09G?=
 =?utf-8?B?anMrcGJIa1hLNlc2c1JZUW9hYmJnbm1FREpneTBDUmNIV2Q2VVZxdzIyYWtn?=
 =?utf-8?B?NVRwY3ZCbEI0eUlISXkxenhkdEk2elpBRGR0OGgwY3Z3UlYvVkIxb2xMWUcw?=
 =?utf-8?B?TGVNU1RrbElYVG1ZcUdTYzlMVGM2cktVeTVhWmtYaDgrNzlKUk1QYk1JSTM5?=
 =?utf-8?B?WlZ2YWdsZXJtUHFHL1Mxak1UZURzK29mejFRV1FkWkhHNSt1TFZIQ1dXL3RP?=
 =?utf-8?Q?vmEpNsgXZcXYYKIvtioNUNnMD5/4HTPutYPS520mcdwAq?=
X-MS-Exchange-AntiSpam-MessageData-1: kMmOKgRT0qKXrQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1883f3a4-b6ab-41f3-140d-08da2ea9c193
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 15:13:06.1307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPf7PQks0ZrF9ABMi1Wg/QCvhcjrO5oXvu36GuFPcaU/CY6howti29OZvtA0EU46Re0f6v6I1cxzHoR3ShwjTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR19MB5652
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/5/22 14:54, Vivek Goyal wrote:
> On Thu, May 05, 2022 at 11:42:51AM +0530, Dharmendra Hans wrote:
>> Here are the numbers I took last time. These were taken on tmpfs to
>> actually see the effect of reduced calls. On local file systems it
>> might not be that much visible. But we have observed that on systems
>> where we have thousands of clients hammering the metadata servers, it
>> helps a lot (We did not take numbers yet as  we are required to change
>> a lot of our client code but would be doing it later on).
>>
>> Note that for a change in performance number due to the new version of
>> these patches, we have just refactored the code and functionality has
>> remained the same since then.
>>
>> here is the link to the performance numbers
>> https://lore.kernel.org/linux-fsdevel/20220322121212.5087-1-dharamhans87@gmail.com/
> 
> There is a lot going in that table. Trying to understand it.
> 
> - Why care about No-Flush. I mean that's independent of these changes,
>    right?  I am assuming this means that upon file close do not send
>    a flush to fuse server. Not sure how bringing No-Flush into the
>    mix is helpful here.


It is a basically removing another call from kernel to user space. The 
calls there are, the lower is the resulting percentage for atomic-open.


> 
> - What is "Patched Libfuse"? I am assuming that these are changes
>    needed in libfuse to support atomic create + atomic open. Similarly
>    assuming "Patched FuseK" means patched kernel with your changes.

Yes, I did that to ensure there is no regression with the patches, when 
the other side is not patched.

> 
>    If this is correct, I would probably only be interested in
>    looking at "Patched Libfuse + Patched FuseK" numbers to figure out
>    what's the effect of your changes w.r.t vanilla kernel + libfuse.
>    Am I understanding it right?

Yes.

> 
> - I am wondering why do we measure "Sequential" and "Random" patterns.
>    These optimizations are primarily for file creation + file opening
>    and I/O pattern should not matter.

bonnie++ does this automatically and it just convenient to take the 
bonnie++ csv value and to paste them into a table.

In our HPC world mdtest is more common, but it has MPI as requirement - 
make it harder to run. Reproducing the values with bonnie++ should be 
rather easy for you.

Only issue with bonnie++ is that bonnie++ by default does not run 
multi-threaded and the old 3rd party perl scripts I had to let it run 
with multiple processes and to sum up the values don't work anymore with 
recent perl versions. I need to find some time to fix that.


> 
> - Also wondering why performance of Read/s improves. Assuming once
>    file has been opened, I think your optimizations get out of the
>    way (no create, no open) and we are just going through data path of
>    reading file data and no lookups happening. If that's the case, why
>    do Read/s numbers show an improvement.

That is now bonnie++ works. It creates the files, closes them (which 
causes the flush) and then re-opens for stat and read - atomic open 
comes into the picture here. Also read() is totally skipped when the 
files are empty - which is why one should use something like 1B files.

If you have another metadata benchmark - please let us know.

> 
> - Why do we measure "Patched Libfuse". It shows performance regression
>    of 4-5% in table 0B, Sequential workoad. That sounds bad. So without
>    any optimization kicking in, it has a performance cost.

Yes, I'm not sure yet. There is not so much code that has changed on the 
libfuse side.
However the table needs to be redone with fixed libfuse - limiting the 
number of threads caused a permanent libfuse thread creation and destruction

https://github.com/libfuse/libfuse/pull/652

The numbers in table are also with paththrough_ll, which has its own 
issue due to linear inode search. paththrough_hp uses a C++ map and 
avoids that. I noticed too late when I started to investigate why there 
are regressions....

Also the table made me to investigate/profile all the fuse operations, 
which resulted in my waitq question. Please see that thread for more 
details 
https://lore.kernel.org/lkml/9326bb76-680f-05f6-6f78-df6170afaa2c@fastmail.fm/T/

Regarding atomic-open/create with avoiding lookup/revalidate, our 
primary goal is to reduce network calls. A file system that handles it 
locally only reduces the number of fuse kernel/user space crossing. A 
network file system that fully supports it needs to do the atomic open 
(or in old terms lookup-intent-open) on the server side of the network 
and needs to transfer attributes together with the open result.

Lustre does this, although I cannot easily point you to the right code. 
It all started almost two decades ago:
https://groups.google.com/g/lucky.linux.fsdevel/c/iYNFIIrkJ1s


BeeGFS does this as well
https://git.beegfs.io/pub/v7/-/blob/master/client_module/source/filesystem/FhgfsOpsInode.c
See for examaple FhgfsOps_atomicOpen() and FhgfsOps_createIntent()

(FhGFS is the old name when I was still involved in the project.)

 From my head I'm not sure if NFS does it over the wire, maybe v4.


Thanks,
Bernd






