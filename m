Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645CF523022
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 12:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbiEKKA5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 06:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239938AbiEKJ74 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 05:59:56 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8681EE0B7;
        Wed, 11 May 2022 02:59:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8reVG5H+FLczaIK+GYJT6u1vnpdBrVDwGmTgvRyhIZdfLP090AMsv7TvnkEV3OC9SVrr50FdwAynf5boq4eEHmXiXoSW6JROQQ/IT+Lj5UyMNRR/vePYkxh3fulkbuln2pAae0GiFEIUFLBuA1A9oCHa3jMuuThOcbscWPWbd6aW7eVMiINin1/H8pxN/2aeVQR1M5tn1LYbZFdS3dv0t5T5CfBmJlP9OPTlbqyRVrUPCyo4DCbVQI6/w1WJVgVOyMDvW+eS+I4nyoGo7zUJ768a2BBcmmlqFbe4/o7Dz5jBpFS3HWu7XqLoZ9foMRfYNMZ+1jwH6Y/D7dQJ3hBjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAGnsqG3HuAyPyopQS2N3oJgW85cEuIafvivbUVPfJw=;
 b=TZSFxtSHf86diJ+O6noBdGSOZnETz3Fp1okVEDstCdQ5MyRjkSS3Sy8pHE3jDNardh3Wc821APrU133LXDpRGEh5bjL/gfO7zotncHysZVzjERjYaNECta4A8iZcwTZTFeRuRCwKCFzJl4maD2xkglCBYyDcVoKbbdGaobv8Pxj0s5FE79LeRQnn1pRip1dH8QJWEvWx5l8ngJGKFt59O1Jh2xjedGkH2ZBEw78D+GKZrRXlw9hcKOarstOojJJbPFI/V7V9WoU+b0Xps5PGLHab49cVQxYdTqaC9vpwRlugMHecZvM+SMovfRTp6oKwydjlvXbwTE3usMRqeQ6VEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAGnsqG3HuAyPyopQS2N3oJgW85cEuIafvivbUVPfJw=;
 b=SJc8EyKXhlO8iaxkiEOuKz7NDt9ne4W8mrQJWoqCoZgg9MTCKhQg5wROQzIvkbtSEUjF04NRUropTNCXyvZhOvjRgKw9980mz6k5F+EYuHwTPE/RRMEJVeqL98DpbgaaEl/wFO10szFc2AI7seRoDoLVk6f3JYe9+rueP7T5a1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by LV2PR19MB5743.namprd19.prod.outlook.com (2603:10b6:408:179::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 09:59:50 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::3994:ad08:1a41:d93a]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::3994:ad08:1a41:d93a%7]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 09:59:50 +0000
Message-ID: <8ee12e2e-94b0-a66c-104c-9b8cec92b5a5@ddn.com>
Date:   Wed, 11 May 2022 11:59:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 0/3] FUSE: Implement atomic lookup + open/create
Content-Language: en-US
To:     Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>
Cc:     Dharmendra Hans <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
References: <20220502102521.22875-1-dharamhans87@gmail.com>
 <YnLRnR3Xqu0cYPdb@redhat.com>
 <CACUYsyEsRph+iFC_fj3F6Ceqhq7NCTuFPH3up8R6C+_bGHktZg@mail.gmail.com>
 <YnPI6f2fRZUXbCFP@redhat.com> <882fbf7f-a56b-1e82-a158-9e2186ec7c4c@ddn.com>
 <YnQsizX5Q1sMnlI2@redhat.com>
 <CAJfpegseGaWHkjdQj7XiR=TQNFpPZzDF_rTXces2oRz=x0N7OA@mail.gmail.com>
From:   Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <CAJfpegseGaWHkjdQj7XiR=TQNFpPZzDF_rTXces2oRz=x0N7OA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0003.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::8) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b0e43eb-8810-4308-e93a-08da3334fd19
X-MS-TrafficTypeDiagnostic: LV2PR19MB5743:EE_
X-Microsoft-Antispam-PRVS: <LV2PR19MB57439AB93BBBA925E11EEBA9B5C89@LV2PR19MB5743.namprd19.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MMy3EVLiuNMQe5dIDBaGn0lKe0HJ33do0x47Dan2HwA3OPDy/L7bkhK9YWJByU3cJF1YhnOujXN+U+hi+OyAwhdPaxzIZsEev1La0ox2X6ATpYu68bhcM2Kw/K7hYV+6VhFDP8dL6+S1+Gijzb+0xir57Htqh+XaIbT/+bZC6nn6n0naHuDIygyfl4cy6Fm9oghtwvXNMWcmBVWVSp586HbNoXUmuhAvdNEpIVeTpoOIki4TifHQ7aADAaD8uCVbErHp7HUqYqvAJKNjgr+MC0B4XdImtzEQ0OaM27+QSx3ZzxWTZ8gLKUQLAq06ZBgdzOQ77o9eWejNr+F2QmF1YPlL6LfKJ//jUzGlaNDvY+8q3wcWvDxEboxfO7R9J13m5R1vzAgkWze7Eg4vVwuxJk7SLCR2HwGABfeYaUfQcnZAGK2SPI4nYJdMZAXmj9/qLq3f2nNPusNCYxHfM7i/9jHXVZDm3Kj9pBBGt3tLYIm7eJHLia70jDM+mWsJFWVqtbzMY9WUcJtlL5Td10m0XLCaDgX8JBxjOmn4L8E6GUwFMcfCJjDN98/z7lC6PYJMYxP1IX+6oDrbQCP70taKsUJTpKFFwT8CiCdQqdenYfsrDHoDe7lW0AfBdKXJJ1RuvUOgwUFibUkm45o1W1sPhJggm3/VLhvmLZKTGrN8BoNux2pWo58SMxsKd5erRmG+myrSv7AmjmzDgMRlhkpiCaem6dH59LToGBCyTMXKK3M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(186003)(6486002)(36756003)(31686004)(38100700002)(110136005)(316002)(4326008)(66556008)(66946007)(8676002)(53546011)(83380400001)(66476007)(86362001)(31696002)(2616005)(5660300002)(6666004)(2906002)(6512007)(8936002)(508600001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHc5SXdXYU4yWEhMckViQ0VvaUV6aHJLZWk1TDg0eTkybFZLSDYyYmk1eTF1?=
 =?utf-8?B?dStTQ25SRDN5VlpWVm9WTEQzcUQ3Ym9wbm81T2RqNEpaZys0TXNlNGg1d2ts?=
 =?utf-8?B?VGxCYit6blF2S1FZUlFyaEV5OCtmLzQwNUNyRXVQSXJSRFpTRXhFVDZ0d2sr?=
 =?utf-8?B?ZkhTM2dqNC9BWFJHQmMvTUNWdHlDUUJzYzk4S05YVzhEVnYxZ0NVMTNSTFNw?=
 =?utf-8?B?eVFnN01LS25GejRIWlRxMThKMm5DZVZ4NlpnalYyV2UvYVE3NnkrbTduYjh6?=
 =?utf-8?B?NUNmMmJWcHN0TkxVU2hiOVVLUmNIbFU5S0lGSmpuZVByS3dhNmVibkVMV1BR?=
 =?utf-8?B?QjNLa3hCZW9IT1dZU0QyN0JtVUNXL0dscVhXdjFEUTJKVk9GUDltcHpIT1dN?=
 =?utf-8?B?RzR2WUJPSkxRMElBS2JhQzJXMFpoNjRxNVVnNjR3Z1dsVDJ2NU1RdVNORy9B?=
 =?utf-8?B?NVIrblFDcUx1TVExUDIrSzNHckM4ZjZ6d3oxVkV5QmlUbk55bDlRclZXSjM2?=
 =?utf-8?B?a3k2amdoRzdKMGV6Um94RnpHNTROSmpLNVNaNkp6bUNJWFRoZFRUWHhYRS80?=
 =?utf-8?B?emxKUUdSRlRyckNwL3VKN3AvWE12azliZlRsVk84OHVwTjQyaS8waXl5K2Ja?=
 =?utf-8?B?UDlJQTdlSVY2U2tkZGpWSjFkbGl2Q0lXR0N5RWlyVlh2WWNLZm1zNTYwSmNY?=
 =?utf-8?B?eTZGN01vVSsxc2Y5UHVEcG9IelVLSUFYMFFqRlFjTk96WTNDeTJxRG1rSHU5?=
 =?utf-8?B?d21TcWhBa0w5bWNoUHY4UGN5ZDJzN1pNK244MDVHOHJDRFhHZFpRNWkwQTJn?=
 =?utf-8?B?MjZNVGV4ckVRbmR4cjliUERlQjhKa2ZoZlZMVUY1bldVZ3JLekJhaFZ3dEtz?=
 =?utf-8?B?amFQc04zSDRLNDhmZGNHTXBYSUVjRXNqRGtzeFZhQjRMbGp5YVNNR2pZUFpR?=
 =?utf-8?B?Tmt3RGJUTU53YmQ3NFh6STkrbXY2bFp0dG1rUnZNaU5WMk9XKy9jMmMva1E3?=
 =?utf-8?B?YU5BSGk3OU0zSkZIaERmc1ZuUS9EYzdJRERVNU1uQmlxRnFZdzZGNnBJQ0tP?=
 =?utf-8?B?Y1ZsNjE4ZFRQSUp2Ui9IekRPQUpiY1pvb3ZNWTZRRm14RnpEc29Gbm5nVUpQ?=
 =?utf-8?B?WVViMDh2RGJGSVZNRU8yR2syRGNSSzRsUUd2amZ5dW5IZTc2SDJFczNUZHdN?=
 =?utf-8?B?enJndnNVaHRrWXRxR3B2cFFPSUQ4b3JTc3J0cFFhN2FqamVaYjd6d0hZS3ZM?=
 =?utf-8?B?cnFEWkJma0pRbzV4NHlkMWRSeFVvNGpkN3MvenR0aC9Yczdvck1PbWkwZlVV?=
 =?utf-8?B?czNOTGdCdkZPMVltejhKd2RDYy8xc1l0SUcrVnpBVVozajZkMXRHTUlwc0xQ?=
 =?utf-8?B?bmdKdU5RWDdQbTM3RXBOSzFuTVJLUGI1Z0VaenVKaWpyaVdpQ0RkTVphU05v?=
 =?utf-8?B?NW5wRjB0V0VNYURtWk1qTzFhTTJFNzNRVGpZVnF5aWRSVzhxY0k5T2hBZFNh?=
 =?utf-8?B?VERQN2tyWFBhM1doWUxNZEN6QURabWtWUGp6dlcyUVRkYUgwTkdCS0hmUHN5?=
 =?utf-8?B?dWRhaUxuTW1RaWJ3ZXZqck9nbDk4dXZHaGZ0VVc4SkIzMDZJamxzR2k2S05G?=
 =?utf-8?B?WDRRYXhzeFB6SncrcWx0T2RWN0Fuc0xlZFNuMWw4K2R0cnhvOTlUNkxwd2VG?=
 =?utf-8?B?b2RDNHdBeU9DTk54cTV5eEtOMWpKblM1OWtSSXNBTW40M1FYV1NNUWdjeTdL?=
 =?utf-8?B?aEwzNXZJZWFQZmw4VHZlSGgxdkh4NGM2SUhLUmtORjlaVFRGbFZINUFUZlpo?=
 =?utf-8?B?SWxVL1p0UXhJSE9lWWg2V2hUT2NNeEhmZlN2WXRyZEV1OWVUanYzckpFQTZu?=
 =?utf-8?B?WHl1N0RxT0tiQzhtWG1qYnNNMUl0cjUvUnFoMXJXcTZnazJaT3o5V082K1NJ?=
 =?utf-8?B?Qml2VHA2VmxQaE96eUxVM1B6S1FCZmI5UXlsb0VMc3lLYm81bk9IWnpUTGZI?=
 =?utf-8?B?Y2pkeWx3V3k5S2FaNkY0L0lpbWlGU2lCa0UwUmxCMXM5dkRHNzloMWFxaVFj?=
 =?utf-8?B?RHZpblAwb3c5VEdtN2h5cFJraEVxVHU4d0hQdnBoMm5tZi92RVk3eFpkcFR4?=
 =?utf-8?B?V292SzFUemVnYUNrcTRYUTNiY2ZJaVVwK1J6TDJ4UVVKMElBdjRMTjNBQU9X?=
 =?utf-8?B?dFY5bGE0Q3dkRVZQLytXUWlOa0svTmhyYkN4NkNDanQyZ2RCb2JvRWEzMjBO?=
 =?utf-8?B?WjFXMzdqaUdvSmN3TzM3REh6Ymx2ZEgwWkVLSkxnUXdJdHN3cktzTWhHeUFM?=
 =?utf-8?B?c20vYkdBVm5VNFlNS2NHU0NtSUViOVFaZXMyS1NEYkt3TitFS2ZHKzhqd0tv?=
 =?utf-8?Q?B/Z5WYo4JOhLBJMkG6hNwzTIEb/U909XhZsg2fTs17FbX?=
X-MS-Exchange-AntiSpam-MessageData-1: UXsOdzZ5M5yL3Q==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0e43eb-8810-4308-e93a-08da3334fd19
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 09:59:50.6496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G66jXuBo5LPlUgHNuSFzG3IUDkRURjuPP/ZHXNia9QFk2gTZlaWxPhWkZMOKE+1lLTvKV1USqbBkGSgw9eOSuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR19MB5743
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/11/22 11:40, Miklos Szeredi wrote:
> On Thu, 5 May 2022 at 21:59, Vivek Goyal <vgoyal@redhat.com> wrote:
> 
>> Oh, I have no issues with the intent. I will like to see cut in network
>> traffic too (if we can do this without introducing problems). My primary
>> interest is that this kind of change should benefit virtiofs as well.
> 
> One issue with that appears to be checking permissions.   AFAIU this
> patchset only enables the optimization if default_permissions is
> turned off (i.e. all permission checking is done by the server).  But
> virtiofs uses the default_permissions model.
> 
> I'm not quite sure about this limitation, guessing that it's related
> to the fact that the permissions may be stale at the time of checking?

Yes exactly, I had actually pointed this out in one of the mails.

<quote myself from 2022-04-05 >
Adding in a vfs ->open_revalidate might have the advantage that we could 
also support 'default_permissions' - ->open_revalidate  needs to 
additionally check the retrieved file permissions and and needs to call 
into generic_permissions for that. Right now that is not easily 
feasible, without adding some code dup to convert flags in MAY_* flags - 
a vfs change would be needed here to pass the right flags.
</quote>


Avoiding lookup for create should work without default_permissions, though.


With the current patches this comment should be added in 
fuse_dentry_revalidate() to clarify things (somehow it got lost in the 
(internal) review process).

/* Default permissions actually also would not need revalidate, if 
atomic_open() could verify attributes after opening the file. But the 
MAY_ flags are missing and the vfs build_open_flags() to recreate these 
flags not exported. Thus, default_permissions() cannot be called from 
here - vfs updates would be required */


Thanks,
Bernd
