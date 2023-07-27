Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D907645CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 07:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjG0Fiy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 01:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjG0FiT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:38:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7BE3C2B;
        Wed, 26 Jul 2023 22:37:29 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R0s69b005131;
        Thu, 27 Jul 2023 05:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=OgpMpNgQI1DLSPfWpkGwPWMj/X8nliJeXNdo+NepQk0=;
 b=kDJw3PE3jalqEUANzYLuKaRIdM1ZNDkv8Qm4j64dg8mZP0y32XfIqlLvGURylvdlAyrd
 ehcwcTPcE54keD1EZu6wp8JsCKsUhZShEkJZX8p2Y3mj0gEBBuWLtZuLCy60XCMF5Jjr
 7K844WXwu8kYDJhP3KcsWsthigWDnWWPeo9Qm7SEtLk/uq8fiB3GPoT+A6DFguW8Mv1r
 53wanz7TmQxasJIlZjByy+jMNkhSFAqGVYh9z1i+IVOgDQepSHuawH9PKqIhX84blBz6
 QHkHd8UWkIQT7arL8ubENwsfIszP8gUFgSARM7svisswVVVdotxEvOVRfNXG5z4sbffv uw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s075d91jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jul 2023 05:36:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36R52g72023062;
        Thu, 27 Jul 2023 05:36:08 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j75akv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jul 2023 05:36:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMzDyEgbnMBipg3u7F22Sjz2G7S+nC0RQ2ksC25vP6xzavAYrHEVo0xBJoBfZBkxMKg3WZKaBOnRQ2GeG6OYJXO7eSe17w4lqyOZUadbN6lYGeF0KfotnSUOajO1WhlVxy7Q08r97k1XuzHhrJw5RxgH+xGHPDu9J1BR68RS5OL2WQemme9YrbtJ/F6PyjHNxqo4vVI8OdCz6MR+dKBZozl3ueLIqkHBK4vwtEyqlEEChI5nZre1oAzO0EVQEkeI6DmkoRXjc6aPH4muPBp4/nuMwpyqQYRqL4t6TV/5cO6v76y1dXOxYLWlnhXocW9DeLLYN+QdgS+PERirOWHHGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgpMpNgQI1DLSPfWpkGwPWMj/X8nliJeXNdo+NepQk0=;
 b=TQXomPbjixXKHcBPy2PcIRwL+M+2YOeeb0DVww5YHXe8+eicHt2C/OXcvt6JwzeHmdPdVYcIPXcsnGn6f6W4yHKiH+bGbj1VagVvjgowHBwWaLQwCfa35ch14+ax/X5xbqrsvVpeXcc0fGPOojz9lvHUEpo1M95DMIC0Cczmf7cPzZ1D/NVJAyWE7G6kQEcGCrZCQxxBvqGX2NRp11kRuTrjVagpQqQhVfzaeynyHcyAUwuDU7enMNhUaWMIuL86c7L4Tp17mThux3Z6vjzlsxEvAA+fPLi1vJBin11mcRpB6DOLzESQ/Z+G1pEbxa5NRJVwF063GgM/BcvKDueEGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgpMpNgQI1DLSPfWpkGwPWMj/X8nliJeXNdo+NepQk0=;
 b=Lao1az8f+8bvdlyF9JLNBwgXfVVL3ptTxO5kJucuYsMW6AxSSi2YEy9leYWby5dnKHHWAVRJy+oTch/VpWp4rBoYbohcho4uYe8a/hdQd+wfKMlCCBw22KL5/nxErqsSsH+v0JNTUlZsIh+1e8f+7ojh10Oxmzhm6tnVBR0J7vw=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DS0PR10MB6994.namprd10.prod.outlook.com (2603:10b6:8:151::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 05:36:05 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::2472:7089:2be3:802c]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::2472:7089:2be3:802c%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 05:36:05 +0000
Message-ID: <8b0a1619-1e39-fc3a-1226-f3b167e64646@oracle.com>
Date:   Thu, 27 Jul 2023 15:35:58 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] kernfs: dont take i_lock on inode attr read
Content-Language: en-US
From:   Imran Khan <imran.f.khan@oracle.com>
To:     Ian Kent <raven@themaw.net>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        elver@google.com
References: <166606025456.13363.3829702374064563472.stgit@donald.themaw.net>
 <166606036215.13363.1288735296954908554.stgit@donald.themaw.net>
 <Y2BMonmS0SdOn5yh@slm.duckdns.org> <20221221133428.GE69385@mutt>
 <7815c8da-7d5f-c2c5-9dfd-7a77ac37c7f7@themaw.net>
 <e25ee08c-7692-4042-9961-a499600f0a49@app.fastmail.com>
 <9e35cf66-79ef-1f13-dc6b-b013c73a9fc6@themaw.net>
 <db933d76-1432-f671-8712-d94de35277d8@themaw.net> <20230718190009.GC411@mutt>
 <76fcd1fe-b5f5-dd6b-c74d-30c2300f3963@themaw.net>
 <ce407424e98bf5f2b186df5d28dd5749a6cbfa45.camel@themaw.net>
 <15eddad0-e73b-2686-b5ba-eaacc57b8947@themaw.net>
 <3505769d-9e7a-e76d-3aa7-286d689345b6@oracle.com>
In-Reply-To: <3505769d-9e7a-e76d-3aa7-286d689345b6@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:a03:254::19) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4468:EE_|DS0PR10MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: c42c771f-e69a-40f2-4b21-08db8e635f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pMiteIktOdAEATgHtFCeSXd/NYySjZ5vzx4/jOWk1VgFc6+92Wvg/u41UU9wQwrGmhlCMyzB9sFX6vyaopcx2xCGQOSTBAOv/HSPFPjueAwTTysR6Edy63Ck34WbDakWx0mqJezviErk9xnHYsOLwomA60D4uGAnk5qzQW8Rfm9OHrYyrLRDY10rR9yZzPzG8o0pJBbN4Du/Tz58vUeZlfXVGckm/MNNFrkDglV7e7d/O8GKIt52q85+/Sfgp0GYmeFsmtEch8LRKRC20T+wueok/mjqWblABasB4OwwPl/Rf80EcVjSdZXsc3oH5tuclvZPNOTdV0OCXJxPScfI1mAapLGs76TP/dNDIFLU/d8jdGWUk6jygN6rUQ3Z+BHz24KwD1QN0Y5n07hPYtD+Heqr8lPsLqnfncli6oBsJ6pARSXERiNNybfG1kI927Ja5G35ifGv8nos9JSjyCXS0Ak3fJIFpwIqYSSNjdssmJDNFmvUfCpVJYAOYxb/gw5rkumRn/0Yt4OyXKZgL0d+VZR9RXTapVvor4iKY7GSwYi0qwHsZEd5U7tYHofXFW7+7wEhuqYl2p7s41RqdC2tvuRaX/eVikoFdai6L7+NizOrVVlgPHR6XK+qEi/SyUB0gS/r7cyW7c8mTQXDiZHpGssVj3TKji6LjBfI+hGmAZ0qhesvIlAP8i+8RuoQFCvi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(478600001)(110136005)(54906003)(31696002)(86362001)(316002)(4326008)(66476007)(66556008)(66946007)(6506007)(186003)(26005)(6666004)(6512007)(6486002)(53546011)(7416002)(5660300002)(8676002)(8936002)(38100700002)(41300700001)(2906002)(2616005)(36756003)(83380400001)(31686004)(66899021)(192303002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXlxSkNRdUcxMzgvRGJrN1NIOXBaditmb3k0N3RDajlVN0lqRlQ0WFl4WHAz?=
 =?utf-8?B?ZW9XWXNxUk5xalFPenRsK0ovblAvTnZrREFwWFpiTlhNUzlCU01sVklpQVBI?=
 =?utf-8?B?eGtCUVFEdGV6T0xCZ25HSDd5YU1DQnVML3pLdzFkSUtYQ2tDaHEwOWx5YnE3?=
 =?utf-8?B?eWxlVlZnQ2hiajk2aU1YNk5lRlNON05kaW0zQmhpc1JGUVJkamFQUjZGaDlC?=
 =?utf-8?B?MzhlTFlRb1hhU0dWcUNab0JxdkJBMCtTNEFSVitheFl2NWk2UGR5MW1iZ2Iw?=
 =?utf-8?B?bjNzYko5eG9tdzNiZjdwOHgzdzY4VktUbDU0SnR1MDdiSmg3dGNKQ3VyTnJm?=
 =?utf-8?B?RXU4WCt4RnNVOWZtM0tuN2Q0REczQWtBL3JvdXN5czMwUUNTa3Z3RVhXSEd5?=
 =?utf-8?B?UnRQWXg3UmN4Y01HYzhzZ0o0MFpTS0ZFa3ZQWjV3Qm1BUE1OMUVmOG0rd1Nm?=
 =?utf-8?B?TVBKcURYamlHdTVFcVB4dktxZWIxOGxGZm1VZ2F1RlhKSmR5b1pLV0JUZ2lX?=
 =?utf-8?B?eGtBcjdnc2ticW5qMG5zYzJLTmRLaTRmRnhRM0RHUkN5aCs0NmZDVTBRV282?=
 =?utf-8?B?WFBMYy9ReDJPVnRMMGFlVjNoTHBvTExxYnQrcmR5b2JJUlYwaHZmTG9tWHY4?=
 =?utf-8?B?UGt5OExkOVFTNncyMUJxaGU3TXVCMVZJTkJRVm1FUlZ0aWt1eWtmdVUyVEVF?=
 =?utf-8?B?NkpMZU81dXMzWDBzSTlHbUR6azNocmg1a2pzZWprYmNuaWxiUzZ5aTNMci9H?=
 =?utf-8?B?WlpFeks3clpIVG5sVGZNNnQvRkRGZTdRNEhtR1FlZDhuYWIvOTJLYW1xR1lL?=
 =?utf-8?B?MnZEczJkU3o2bFUzUjRJdFJOQXdZSmN4RW9aWUZRdWZ5UXAxWk9vSUxyNUE2?=
 =?utf-8?B?VENQYjZ3SG5saFZCWnNWMEI1Rm5jcWZpREowcFg5YjdkVHpPeUg1ZGZJenNl?=
 =?utf-8?B?OFVZOEhzREpLTXZiT1Myc2tobXVMMmVwbDNUdnZabUczeEF2NzNOU3BsbGMy?=
 =?utf-8?B?bURBOW94aWJzeGUydytqNlRDSVVwWVhSdXBnMlVmZkkxSURyeUVlN1J2dDFG?=
 =?utf-8?B?aTBzNS9GbytORmtYTjFqbWJJV2dnODVONzFLQ1hWenB4cUZmS3Zpd29mZVVa?=
 =?utf-8?B?Z005SlFFb0Z6UlJKSTFzSmhCai81ektBc3ZmTm1CVUZDY2RiVFJSRXVFRlpx?=
 =?utf-8?B?Ly93YkFIM1MrRTdFSEFEeXhCa09TZzFNRVFsQVBvVmlKdkl1RzJFQmwxYml3?=
 =?utf-8?B?VEZuVW50eWdmQnFuTEZRZkUySGJSRnVpN1k5MStYSGpremtWbDZpa3pPS0Qv?=
 =?utf-8?B?N0trSjVYOVhnMDFRa2JtSU1YZ09Wa3VoWHpOS3hBVFNtendyWGhtZmFKYjli?=
 =?utf-8?B?L3J4dzFBQTRlaXJCWk1wYjZHS0JZb0RtR1BWVUIxOFJlUEkrQms1eFV6QWEy?=
 =?utf-8?B?bWM0VXdBRjhic1VWY05VSitWK0RQY25GdHJPcWJDTXpTZmhhenZkdnhjTG1G?=
 =?utf-8?B?VnF6WGdFa21PZHJDK2owRzhRMFA5Um1qdEx6QXVsR1M1dHpKQWdZWmlkQTcw?=
 =?utf-8?B?ZmtZUlJjRWovYUVrMkdKeFkxUkhsdVdBK2cxVTNJQStOQS9Ib3JXQUlvSXBN?=
 =?utf-8?B?NzczbXRVTnBETEhpOGo4aXd3T090Qnpkd3NQMUxaVFdySDlLaWZWRDF1ZW16?=
 =?utf-8?B?blVaY3F3K24rZ0hpa0FCQXVZaTVnRmplM1dkQThpd1Bxc0NTSno5Y2pBb0Uz?=
 =?utf-8?B?bGlDVmZnbEtYNHFoWlZCS244azMrdkZ2Q0pXQ3NORmRnSUx2aUFPS3JRWHJi?=
 =?utf-8?B?bTBlMkZxWm96R2phSFVKdDVGNEp1cXdLT21MT1NUZ0FldmZ3cE56NUNycWds?=
 =?utf-8?B?QUVUNEtHTzVUSTA3OVBpT05BQ1ptWlVuNHpYV2p2SlpxcnBqeGhxaGgwN3B3?=
 =?utf-8?B?WGI4ZTlnUFI3eDI3em1rWEIyaHNkUGllcjJIb3N6RStveU5mZnArY3BWUzdO?=
 =?utf-8?B?TFFjdjRSRHB6YWxNdnJXSDNIcTFlLzJNMU5jY3hWczRaMUFyOUo4Tm55QXpY?=
 =?utf-8?B?VDFGZlVkNjZTeVhNSXFYSWdNWWRJMElGZ1BORU0xR3NKclZhOThpSmxMRjR6?=
 =?utf-8?Q?A0wM7n+j7fiv/uMeaYjfHxHZk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?K1BvUWhURkVBK21BTFVWY3lvd003NGZ3aGs1Z1g0WFBBWXI1RUs5N2dRQW84?=
 =?utf-8?B?YWQxUmdJS0lxekZwd2dqMzB0cWtmeE4yVEo1TE92bUkxK0drcmowanZMQ1h5?=
 =?utf-8?B?a09ZUUNyUUgrSGEyRm0raFAyV0NHUElIWVdra3dzM1gxRC9MMzA5MzhDZFJ2?=
 =?utf-8?B?U3ZwNW14ZGdIcVdRMkkzZ2FqdUNuK21lTGV0Kys3aDNQeVBnUVluNnppd295?=
 =?utf-8?B?NVh3UVRHOVIxeDYweDZ2ZlBacDQ3d3NaNFBESFk0RGQ2NzR1aGlJWXpUUHZh?=
 =?utf-8?B?ekhjcGxqaXo5RjBya0IzbHZzT3RHL1NoOWlhemdGL29FZ1gwRm1adUg1d20x?=
 =?utf-8?B?NjlPZnlhNEpJQmJrcnF3dC9zb2RUMzVDOUVHN2RwdEVWdjE4Z3RleWEvcEI1?=
 =?utf-8?B?VVFCcFpYV2prTnF0VEM4YU5HcHNmSnExSzVNTFg2UUhFRVVsS3NwUkxuaWxS?=
 =?utf-8?B?NDhqRk5zdEJ0bVp4MEJBbU41bG1HcDhBQ0FzV2FGVlhmaG8zRThDZmorSlpx?=
 =?utf-8?B?UTlIQWZoRTVNRGNuUWFHZlIxdXNOdmhEbjQvcTdCRmVHQUhLRkdqWUM1cFhE?=
 =?utf-8?B?dmVGTHJsazJ3WGg2V01VR1h0WXA0cjIxcnJjZFBXYnFCVkxYcmdEaHhMeUdO?=
 =?utf-8?B?Ui9IT1JJVFJkYXdzUGVVb1hjY2JhRGhMZEt2YlBRNzhvWnU4Y1ZFTDF0U0F0?=
 =?utf-8?B?aWx5L2ZDUWJTd3RtK25oUVhITVhEVkNITkdZa09leWR1U0RPK3VOeWxENHRj?=
 =?utf-8?B?NW9hMGRZYytpSmlNbzJsR2g5NFhkWU55OG5SY1VPem1KSzlEbzYrVWtCdWNL?=
 =?utf-8?B?MVRqd3NQcmdFa0dQZXcrK2RiaHVjOVBjRmRnM29XMXFHT3hsYVFQRHA2QjNz?=
 =?utf-8?B?SnUwNlNXcVF1Rk1rdWRablJqM3l4ZE9EYnNkbk5BOEJhbEEyVWNrNElCTXM1?=
 =?utf-8?B?Q2ljcFlEUDJWT2hiYmtUc2U2RERMWm5iK05ibHMyakE4SmhROXdELzB1S2t1?=
 =?utf-8?B?V2hhSi8rSEtYdWU2MXY3T2dpdStKQUx6cndmYS9LamlIZk90elpEUTRIQUo2?=
 =?utf-8?B?eTJvTkNMUDVZWlg0dm1RRTUrNEtibUM2S1JFbEpHUkc4VllDOTExVEd3R2du?=
 =?utf-8?B?UlFvNmNXemFZcHp4YTVVTGlqcHhkcDFTbThxMnJRbURGaTI1RWhKWCtQSnc1?=
 =?utf-8?B?ZFkxUkc0R2xidU9WM0RsQkJOYzhld2ltYUNnSVg3VFFxLy81em9oWlBCanNp?=
 =?utf-8?B?Y29Za1VDMmRTdUdPZEkrcmViZWpLUWkxQmI2UG96Zkg3SnBxVXVZZFZnQXFK?=
 =?utf-8?B?cGZWRkhUZGtBQUNFWDRDVWpVOE1VdXpPWXdkaWNaSmRMa0VpREJEU3dEbTRV?=
 =?utf-8?B?N2JUVTNLVXZ2RUx2c2Y2L0dqcUlPVkI1cWdQaHhWK1BZdWRVd2ZPUFRFN1dk?=
 =?utf-8?B?R0txU2JjKzVkbzEzOWVacDdMWTU1RElyaldsR0tGUXcwYmRpbElPNEhmN2hS?=
 =?utf-8?B?YWdySnYxZWprbHFzZGJqS0hVR2hVK3IzalRhQm13REVGYWs3bThIZEJIem8y?=
 =?utf-8?B?ak0wdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c42c771f-e69a-40f2-4b21-08db8e635f4a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 05:36:05.5853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YsRFM/DvKG9gXOZ3DDfQwYBm8ZoZScUbMTXtcIQOT1WXNXVKpZV3kO9my3wIk14xRGnEPIScfPZnXdrm05KE0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6994
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307270049
X-Proofpoint-ORIG-GUID: kzn0WBUkNA25jBQtM6LLSo_wH9_OCFfs
X-Proofpoint-GUID: kzn0WBUkNA25jBQtM6LLSo_wH9_OCFfs
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello again Ian,
I take back my previous comment :).

On 27/7/2023 2:30 pm, Imran Khan wrote:
> Hello Ian,
> Sorry for late reply. I was about to reply this week.
> 
> On 27/7/2023 10:38 am, Ian Kent wrote:
>> On 20/7/23 10:03, Ian Kent wrote:
>>> On Wed, 2023-07-19 at 12:23 +0800, Ian Kent wrote:
> 
> [...]
>>> I do see a problem with recent changes.
>>>
>>> I'll send this off to Greg after I've done some testing (primarily just
>>> compile and function).
>>>
>>> Here's a patch which describes what I found.
>>>
>>> Comments are, of course, welcome, ;)
>>
>> Anders I was hoping you would check if/what lockdep trace
>>
>> you get with this patch.
>>
>>
>> Imran, I was hoping you would comment on my change as it
>>
>> relates to the kernfs_iattr_rwsem changes.
>>
>>
>> Ian
>>
>>>
>>> kernfs: fix missing kernfs_iattr_rwsem locking
>>>
>>> From: Ian Kent <raven@themaw.net>
>>>
>>> When the kernfs_iattr_rwsem was introduced a case was missed.
>>>
>>> The update of the kernfs directory node child count was also protected
>>> by the kernfs_rwsem and needs to be included in the change so that the
>>> child count (and so the inode n_link attribute) does not change while
>>> holding the rwsem for read.
>>>
> 
> kernfs direcytory node's child count changes in kernfs_(un)link_sibling and
> these are getting invoked while adding (kernfs_add_one),
> removing(__kernfs_remove) or moving (kernfs_rename_ns)a node. Each of these
> operations proceed under kernfs_rwsem and I see each invocation of
> kernfs_link/unlink_sibling during the above mentioned operations is happening
> under kernfs_rwsem.
> So the child count should still be protected by kernfs_rwsem and we should not
> need to acquire kernfs_iattr_rwsem in kernfs_link/unlink_sibling.
> 

kernfs_refresh_inode can still race against kernfs_link/unlink_siblings. So your
change looks good to me.
My tests are not showing any issues either. ( I tested on 4.14 and 5.4 kernels
as well).

Fee free to add my RB.

Reviewed-by: Imran Khan <imran.f.khan@oracle.com>

> Kindly let me know your thoughts. I would still like to see new lockdep traces
> with this change.
> 
> Thanks,
> Imran
> 
>>> Fixes: 9caf696142 (kernfs: Introduce separate rwsem to protect inode
>>> attributes)
>>>
>>> Signed-off-by: Ian Kent <raven@themaw.net>
>>> Cc: Anders Roxell <anders.roxell@linaro.org>
>>> Cc: Imran Khan <imran.f.khan@oracle.com>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Minchan Kim <minchan@kernel.org>
>>> Cc: Eric Sandeen <sandeen@sandeen.net>
>>> ---
>>>   fs/kernfs/dir.c |    4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
>>> index 45b6919903e6..6e84bb69602e 100644
>>> --- a/fs/kernfs/dir.c
>>> +++ b/fs/kernfs/dir.c
>>> @@ -383,9 +383,11 @@ static int kernfs_link_sibling(struct kernfs_node
>>> *kn)
>>>       rb_insert_color(&kn->rb, &kn->parent->dir.children);
>>>         /* successfully added, account subdir number */
>>> +    down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
>>>       if (kernfs_type(kn) == KERNFS_DIR)
>>>           kn->parent->dir.subdirs++;
>>>       kernfs_inc_rev(kn->parent);
>>> +    up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
>>>         return 0;
>>>   }
>>> @@ -408,9 +410,11 @@ static bool kernfs_unlink_sibling(struct
>>> kernfs_node *kn)
>>>       if (RB_EMPTY_NODE(&kn->rb))
>>>           return false;
>>>   +    down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
>>>       if (kernfs_type(kn) == KERNFS_DIR)
>>>           kn->parent->dir.subdirs--;
>>>       kernfs_inc_rev(kn->parent);
>>> +    up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
>>>         rb_erase(&kn->rb, &kn->parent->dir.children);
>>>       RB_CLEAR_NODE(&kn->rb);
>>>
