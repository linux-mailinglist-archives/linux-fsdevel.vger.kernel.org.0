Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637437A51C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 20:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjIRSLX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 14:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjIRSLW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:11:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C53FD;
        Mon, 18 Sep 2023 11:11:16 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38II49QF032041;
        Mon, 18 Sep 2023 18:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 message-id : date : subject : to : references : from : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Za4e6nai2yOGTU41RsKMNsYovpetITlZn3OADJFwW0I=;
 b=S0vAgaSNCO5EYr/ocGrX6DU+26I7biBhtG0tWjENDHKq8X8iUw5SREffpB+Q9Zl1hUSD
 MZBVIBTLrKYWu99PWJyztVFg05xbe76k1oXktbTz5MDjmdfAFGlM+NukHGlr+ZayEZde
 19noPlTWuwbINNqxCM1hCmQlH+GsP4aoeQ2elgHmvfZBJRKkYAccKfYv/17a2Lzrs5bb
 xgPSe4kcvaXZuhOhx4ah0Dub4Z/IoxsfM9otxNZBNLV7EjjvykRKqQJe2RNzLc/rGxCx
 Z5kgfSq44Z8sshTerBDx5m59d/CWKvIq6wiu8PxrV72bJ4q+pYpyMd/cIczXKJr1boF0 5g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t54wuk4mv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 18:10:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38IHhxO5012157;
        Mon, 18 Sep 2023 18:10:26 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t4v59m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 18:10:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuL/2QsMq3Pv4NZn5AFFCgEic9rnq4D2Oi8hddX7ypUSvze2rQZgqCn+NyQ0mQOTyLtYH+fFIQXEfJlGT7w2/aMBCZpaFJqucbPUxX4KvaehxqAfZKSxAasypvmmWlhKpsmVzHqL1b2yYsE4QGac42z5hThDtjaumfjH8eOlD0qXKTcHdd4So9xux6/TX2+JvbTDLfcr5Q2iKBWm8GBzfj/QPzNkKMCJUMf0tc2vK2GTGnVKUv/s1uC0Jco4uC0qezWEzTB7qA8yzdj9bVoHEnxEoPktLu+W4gGN+WDx7bDF6X1C/O+HDK6Xr7SI8Alj55qeJuYyLo0ZdWl6TX0HQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Za4e6nai2yOGTU41RsKMNsYovpetITlZn3OADJFwW0I=;
 b=UhIuSwodyVGBYZwIjCMYjg2bCkCMFnM3GQZt4xOg7zRPPOPAZfwGSYelkT1Sl1WOrc0tPs7/dyLJkV6VKJT0avZnfSOy1hilAEgZTD+/U/hqcAn2UYFSo+aScYEo/eRHnZacO/9h7xgd8u464QE64cd1+kDPVqHD+7p+noqvcBqOhh8IPsTcazmOujcXAmHvnpijmC1tpS5vX1605ZaYGOFqzoW94ISHZhVgkng4Sf+DvQCABPVAUU7tgaknGlJwr6xr3FvlAYQT12E4C1twQ+BOj0A2rFADgX6uNilJ85MV2LHCD2QAPoHTWARYJe9wBMwh+4amROpUbqgFZ6yZ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Za4e6nai2yOGTU41RsKMNsYovpetITlZn3OADJFwW0I=;
 b=nVt7lwSLe4hMPug94Bmd8kM6yjUNFPXLVcPyazSrBvL8SjdqEnAk9W0Hy38ypjxcCLGO72UfXsrR80wwf9+ufgxoVu6YGgG2keyEBpXXssfURcM4NvitdZuwVDVEdJ/p9peoMGiUMw/8VH4Z58MU/gMvohN+qxzSCqQ6jOKFTAY=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA2PR10MB4506.namprd10.prod.outlook.com (2603:10b6:806:111::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 18:10:23 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::924c:4cd2:a7db:f9ba]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::924c:4cd2:a7db:f9ba%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 18:10:23 +0000
Content-Type: multipart/mixed; boundary="------------LBgAu2WV9U6Nuc4c1wGUi9wt"
Message-ID: <d576d53b-bce4-21d3-fddd-0e26e9b44f89@oracle.com>
Date:   Mon, 18 Sep 2023 13:10:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [syzbot] [fs?] [mm?] WARNING in page_copy_sane
Content-Language: en-US
To:     syzbot <syzbot+c225dea486da4d5592bd@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, mike.kravetz@oracle.com,
        muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        willy@infradead.org
References: <0000000000003a7ffb06059ac0dd@google.com>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <0000000000003a7ffb06059ac0dd@google.com>
X-ClientProxiedBy: CH0PR04CA0108.namprd04.prod.outlook.com
 (2603:10b6:610:75::23) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA2PR10MB4506:EE_
X-MS-Office365-Filtering-Correlation-Id: 835d534a-0abc-4ba4-f8e6-08dbb87286ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: riuDLmENAsKWHIZ+/pliic8Bfvfg3Vu3nFhHiBZaZnOCThNqQ6xFAgpNyIKHZjHYzrNOYx2EUwxBGJeHYFeyrmVDizdFS0KC34VUo8O1zaN2cVj9PC3eshaKKqrDg5bMVGhyaJr+a2BWzlPA/lUh86jQQQO39rhduSnorKQnEctkZjE35KEzwMg1H7xX/+iQFJUeYRHqEyQjIWFNVNZhlYTukIumH3qWs2qo6ZOggsLm9cTIfxS55ZVkCnSXhFkc+Xn7163WgBvMiKPeTRIMvp27tY0XGlcPt6dxtfMt80qML/VYTQeF5kL2zR/YwRtkcVb6BrXSwK9gplfVKgGWQ+fMTpfDx9WcZRyV1Xk0NWMZ8d9Zt8OEk9G2kQztuBAvU5oD3yrpXH1wg6B+afC3PPoSQds0dOU0uTFdqKxG3XYch8xVaeuQyxvAtNOpmZi26Ep8lHg3NJHvN8+4pPPxNgV8RzG7QAS3cjhpVxm6BKq3RQcsWNUDGpNdYmA0ZaMDkKe1t0OeEQxCp0DwzT4pOpnslxP2hypHBXvmuG7YSgyZkWuPZJIfcFWyn65J8viSjn1BsQrWkRCgvxx16Xrouhi4Gyc1YC414VYAZWcRggXPkersZfyriOUbvOAlBVVFFP18xQupUMwZg37DzNWrM9HENa4UGhQ5uxxMEYj6O5moX7k3bHAQqBWBLIYIVWIwe0fP5PirFO6pGzHjXyMPafYuMsmKMRZILXM/itkA7tE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(39860400002)(136003)(186009)(1800799009)(451199024)(45080400002)(53546011)(6486002)(33964004)(6506007)(6512007)(83380400001)(966005)(478600001)(26005)(2616005)(2906002)(44832011)(235185007)(7416002)(66476007)(66556008)(66946007)(316002)(5660300002)(8676002)(8936002)(41300700001)(36756003)(31696002)(86362001)(921005)(38100700002)(31686004)(99710200001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGVhYkdObENjTE9JY3Jnam1iK0hPUDI4VXFwZVhITDg0UWlpbC9lV1hIbCs0?=
 =?utf-8?B?NTM1RUtBVVo0SDJqL1FRSWowNWhhUXJsckdXK2tvTG5VbUVQTmRvOExWS1M3?=
 =?utf-8?B?Z0JDcG1HM29LYlEwMGZOMnhDMTBxaTVvV3FTZUdyL0dVUklieGxVdTF5YlBZ?=
 =?utf-8?B?TEtvcGN2WTNMM0JYdGpEcDhpKzN5aFhmeW5pN0F5d0FqSU5pOWJyS0NUOS9v?=
 =?utf-8?B?UktpUjZ2eUt2TFNoeTdzVzhYQWR0ZW9xTzFUN211SzNFSEc5Q1ZSM09LOTh2?=
 =?utf-8?B?dnd1Y0xBYU9GNXkzUyt1SitGQWFHVkpiRXFvUnEwamNZaGcxTkdZQ0ZsMS9U?=
 =?utf-8?B?Q3lITElhRC9yWGFKODl2WHczTjhEeDV4MGNmM0lsV3I4bGk2UTVOZDJPdDJB?=
 =?utf-8?B?Um04SU16WG5wanY2WlNLbmhxUldheEQyMHhzcGFkUlFTMUlkZHdtNEpsQmVH?=
 =?utf-8?B?djNqd1hTRWpXcjkwbEpSbEpSZVUxZHQvL2tMam5QaEo2Zzl6Y3RVb1BJWkI5?=
 =?utf-8?B?VWZMZnJob09jdTg2Mk5QcGRNQUpjR05ZVWk0NXhjNENSNTYvZE91dWllZHNM?=
 =?utf-8?B?NTNRZ1l6R2dkaWRadWlnVHpqVEZLVDRHRFVtbExpRU9jbmpUTExqdjhpT0pB?=
 =?utf-8?B?QUlpRmN1UVJqMHMrT3gzdlZ6a2NBRmord3d5Q1dKejlHWkVVRklXU1JiK1Zv?=
 =?utf-8?B?dEFsRDFhTTRLeFFkTXZrVDgycnQ4eXZsNUE2WG9sa2tneHZIQ1JodzBQWHha?=
 =?utf-8?B?YWxJUUlPdHgxWnpOVVNod21xSnJvMFZVZk1HOG52SHhUUi91dEdUNi91SWN6?=
 =?utf-8?B?K2ozTGdCeWUzUHJDWVRNcTFENVpmQXE3OFo5eHRpM1B3alV2OFg4dk5uN24z?=
 =?utf-8?B?WllXUmlhWnY5V1h5bEI2V2hPZzZIQjVXaDUwbUtrWTlDMC9wMkZkUENSdElJ?=
 =?utf-8?B?UGppcEhJZGQzbXN4MldHVTNWZ2RPOGNYcld4MEhBckxmSmcyZkJ1TEI1ay9S?=
 =?utf-8?B?VVlySEs1Yll1RUJoMEdOSXYyZVJFK21tQUg3SUFMRzVnSEFkczF6RkhUS2Q1?=
 =?utf-8?B?WmFGMHZWazJDTWt6S2Y5STBNMUlVMzdkcDdGVzE1N0ZYZjBMWG5hUkhBOUl5?=
 =?utf-8?B?eWxxYVVPaERWVXZpMFh1NCs1eWFlclV4VVVQbkpJUzlocWp6RTJGd1NnaEpM?=
 =?utf-8?B?N0tpYy9wc1FRaENObGFZbmdvY1p6N0Y2b0wyb0M5a0tQSDc3SWJ5R01KaTc4?=
 =?utf-8?B?bXk1VWVwY1YreGc2ZUhhSGtJaG1xeHJkS3hvU0djUVRoL3RncTJVZVpvR2FL?=
 =?utf-8?B?Rk1ueHBJd1RFaEp3LzFnTldld2ZBNlFoV3ZOUEZZLzB3a1BiWllwOWIwMnRN?=
 =?utf-8?B?NmNDZUtGL0twaFN3b2tWelJuaEVqYS84akxxWHgraytyVmFiQ3dac2xqenk4?=
 =?utf-8?B?OWk1RlF4MmhlTlU0eDVDVTlyZmo2cFFjTy9YdDg1azJNWmFFRXZ2RE1xSUkr?=
 =?utf-8?B?SEZzRnBFNjY0dTdnWEJURDJoMHJkNE81UzZ6TzNVZmtNNWVMZFBIMXVGNmVL?=
 =?utf-8?B?Rkp4V3ZrdWdNZHNjSjJwVGJ6Tkk5SW9UcWxCQ0pJemowcmQzUDdCV0NvNmNy?=
 =?utf-8?B?b0oyaGVsMmhKZmFuS3llakJmWThQSHRMTW1HMlhyd3dLMDIwYk85UW5CTWQ5?=
 =?utf-8?B?ZVZ3Zzk1TEhNSS9sdkVZWkZDWlI5YjMyb3pxUmhYcDNRTkJtTmxEbE1BSW5n?=
 =?utf-8?B?NlUyd2xnQkZDaFNRTmtRTWFqZWg3eCtzMVphZDlXZjdYRStOckVwdWYzeE9E?=
 =?utf-8?B?OEl2NWhqQWVWczJWVDFVNkFVMVkwZUJPZjloM0xOb2J1V084OXR1UGh6VWNF?=
 =?utf-8?B?TmkzNFU2VnEwK1BZZjhrQ3hkZ0hIUVV3WVZxOC9CWHJvdWRRalp4cTVxM0dU?=
 =?utf-8?B?MnNNQjhNM2Vqbkl5Y0ZYcnZJTm9LWmpHWGFvVzgzeXo2NFppOGIrekN0QnUy?=
 =?utf-8?B?RnJlNlBsakdQUWs0M3QvUkR2KytVUVA5dkNBNUpQVXZpT0kvcm1rcFdRdkhO?=
 =?utf-8?B?cTVzaEphU1BkVTM2QU1Ob3lJdnYrWGhoRXVSSWRIZmVTUkc5MXltK2FWUkFR?=
 =?utf-8?B?bEgydnp6dFdvYXFWVUl2U084R2lYT0lnREcyRHBuRFViTm44emU0bDFyd056?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?V1FIOWNNYXFTMHVvSUNCTUtZd2RGVXM0VlhyQ1RDREp2YmkzanRubjBlRlVH?=
 =?utf-8?B?bDFsZjlEeUcyVS9lTEkvMGNyK25GOGptZ3lFRXEyY2Y5SUl6TXhPRFA4Mk9R?=
 =?utf-8?B?b250YlhaTlZvQ1MrcnpCZHNmOFNCMHcvajdvcUZjVlRYdFF6QXF0eWRwaDhG?=
 =?utf-8?B?ckh1cFZFMFZNNHFBc01zQ2kxK0U0QVlQdVlkblF5OHROUXpNRFUyTWk2R0Vz?=
 =?utf-8?B?bzJmSFRKSS9yaTFsRnR4a1hKM1lJckREY3pHY3NUTldLQjh1WDRuTisreTVa?=
 =?utf-8?B?azNsemlGSW9Vem1qVkhIU0tCUUNnbzVneVkybVArYm0wbDkySERmQ2JZeE9u?=
 =?utf-8?B?Tnp5ampxbCtpWXZKU3NNaUUvdHlCUG96Q0tkL1JoSnQrS3VPWU1BdzFXRlUz?=
 =?utf-8?B?aHMxSDlpTFBTcVJlZko0Y2ErQUpIUmQ2dUJzdkIzT0NXUEFrZW00VXBpSWhI?=
 =?utf-8?B?VVdmK2V3VzZQUWpIZE1UQWdSWU1lNklnYUF5MUtLMjVGSzRTcGZPWG50Nzlm?=
 =?utf-8?B?QVBJMVU2bVVmN1o4d1FnZkJoVytId2VCdTRPZXRsZWhac0FQeDdTcnhqMGFy?=
 =?utf-8?B?Q2lwdUxQa3FxdHJ0Zy9RdmpiMWs4OGV2bjhaazZNSWF3cm9CbmYwSzhCYjNv?=
 =?utf-8?B?WnVHRzZKVFhtVUhJckN4c2kyVnNxdnFBbDA3UzVhUVBDdFhKWk9KQnlPVVhT?=
 =?utf-8?B?MDdaWDdGNnBoZUg3QWpGdktWQzVkNWhDdmNqN1RQNXlCeTJPeWtnYmdzOXpZ?=
 =?utf-8?B?UUZRMm95cDFnRm5GYkhwR29TTnZjdGlYOGJsaytyOEhuaVpCaVFnRGE5N0tM?=
 =?utf-8?B?c1RSYlpVTHhGMHBjcDBWb1pBWm43TXJVRWNPbHpqSUhVR2ZGMTRhejcxai9q?=
 =?utf-8?B?VDNNcGNJZHpBbXNjNGIvanpQcXNNVm5EVktaMlUycjJCblFYMUZKR2VncXJm?=
 =?utf-8?B?Wk9sZjBBVmRaNGZ5ckhZNjdMVWNLQXlrNCtEUlh4ZkpvQ3g2QnhZc3d1YTJI?=
 =?utf-8?B?akFXVlFKMGdMSkI4NG1sUUh2cmpCWWVNVlY3dkNoKzYzR250WGVRSXNwUWVS?=
 =?utf-8?B?QWFkblVrUU9rUnpFTzJ6cXlHMWlPNjl5VW1nR0E0ZUhTMmREdVd5MXN4Slk5?=
 =?utf-8?B?MGw5NHlHdHdlYzcwNmVDeGVyRHZ1QkRMckJvdlNaSXUzcmpSRVplTjBySnh5?=
 =?utf-8?B?RGttSklPMm1aSTdqNTBsSGJEeHpxV0NyK3Y0RlRLTjJUdFQ1Q3Fmd1FMaTFV?=
 =?utf-8?B?T2FHSmlzeVB1TXVYLzFQNWgvczQ1QVd0NHZPbWJ2bXM2MHhHUmlRc2VjL2tz?=
 =?utf-8?B?bnl5YkcvS2lYeDlRWTBCOTNzZVoxdkMzSU1IMW5JbWZaT1VON2dVeVdvN2Rw?=
 =?utf-8?B?enhqdXZmV0NwZmRIUFRoTHJDN2M3VzRnRlBuRE5FQ0ZSNDgySHM3ZWRKR01I?=
 =?utf-8?B?dTF6R2N3R2gxZWxnRU5YYjYxUVhWbm9tbndhd2dxSFVRNmxSbVZjSUkvTmJr?=
 =?utf-8?B?clhSUFJVUUpCR01TZHc5TVdHZUl2akNUQ0R6Nzg3OVVqYkx5eU9HekxKS2Ev?=
 =?utf-8?B?YzV2dz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 835d534a-0abc-4ba4-f8e6-08dbb87286ba
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 18:10:23.1057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4atcAUfZzXIK1Yc0oLJPMPKjWwrxU9NiPrqOCFUCaemu3rdFSrsGQcBFXsrt7jo6wDoxxwjy+NkOIwGxlMti0HGO/azqoczzJekok7r+HrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_08,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309180160
X-Proofpoint-GUID: BMe01yyYaWNTMS0CHcwR7t7POGV4hhM3
X-Proofpoint-ORIG-GUID: BMe01yyYaWNTMS0CHcwR7t7POGV4hhM3
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--------------LBgAu2WV9U6Nuc4c1wGUi9wt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/23 11:41 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    98897dc735cf Add linux-next specific files for 20230914
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1548728c680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1502c503717ada5c
> dashboard link: https://syzkaller.appspot.com/bug?extid=c225dea486da4d5592bd
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171fffd8680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bbbf1c680000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/00e4c0af5a8a/disk-98897dc7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7b54a00eee56/vmlinux-98897dc7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/100094353b8e/bzImage-98897dc7.xz
> 
> The issue was bisected to:
> 
> commit 591a2520fbfd6565d9a5c732afa53f62228798e6
> Author: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Date:   Mon Sep 11 21:53:19 2023 +0000
> 
>      mm/filemap: remove hugetlb special casing in filemap.c
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15e15464680000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=17e15464680000
> console output: https://syzkaller.appspot.com/x/log.txt?x=13e15464680000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c225dea486da4d5592bd@syzkaller.appspotmail.com
> Fixes: 591a2520fbfd ("mm/filemap: remove hugetlb special casing in filemap.c")
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 5040 at lib/iov_iter.c:463 page_copy_sane+0xc2/0x2c0 lib/iov_iter.c:463
> Modules linked in:
> CPU: 1 PID: 5040 Comm: syz-executor204 Not tainted 6.6.0-rc1-next-20230914-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
> RIP: 0010:page_copy_sane+0xc2/0x2c0 lib/iov_iter.c:463
> Code: e8 73 db 63 fd 66 90 e8 6c db 63 fd e8 67 db 63 fd 4c 89 ee 48 89 ef e8 6c d6 63 fd 49 39 ed 0f 83 eb 00 00 00 e8 4e db 63 fd <0f> 0b 31 db e8 45 db 63 fd 89 d8 5b 5d 41 5c 41 5d 41 5e 41 5f c3
> RSP: 0018:ffffc90003eefa58 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff88807a01d940 RSI: ffffffff84241482 RDI: 0000000000000006
> RBP: 0000000000200000 R08: 0000000000000006 R09: 0000000000201000
> R10: 0000000000200000 R11: 0000000000000000 R12: 0000000000000009
> R13: 0000000000201000 R14: 0000000000000001 R15: ffffea0001fe0000
> FS:  0000555556937380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000200001c0 CR3: 000000002911d000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   copy_page_to_iter+0x35/0x180 lib/iov_iter.c:472
>   hugetlbfs_read_iter+0x3d7/0xa60 fs/hugetlbfs/inode.c:385
>   call_read_iter include/linux/fs.h:1980 [inline]
>   do_iter_readv_writev+0x2f2/0x3c0 fs/read_write.c:733
>   do_iter_read+0x315/0x870 fs/read_write.c:795
>   vfs_readv+0x12d/0x1a0 fs/read_write.c:915
>   do_preadv fs/read_write.c:1007 [inline]
>   __do_sys_preadv fs/read_write.c:1057 [inline]
>   __se_sys_preadv fs/read_write.c:1052 [inline]
>   __x64_sys_preadv+0x228/0x300 fs/read_write.c:1052
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f85cc7932e9
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffda50bbbd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
> RAX: ffffffffffffffda RBX: 00007ffda50bbdb8 RCX: 00007f85cc7932e9
> RDX: 0000000000000002 RSI: 0000000020000180 RDI: 0000000000000003
> RBP: 00007f85cc806610 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffda50bbda8 R14: 0000000000000001 R15: 0000000000000001
>   </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
#syz test
--------------LBgAu2WV9U6Nuc4c1wGUi9wt
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-mm-hugetlb-fix-warning-in-page_copy_sane.patch"
Content-Disposition: attachment;
 filename="0001-mm-hugetlb-fix-warning-in-page_copy_sane.patch"
Content-Transfer-Encoding: base64

RnJvbSAzN2E2NTI4ZDBkZGE5MzRjZTFkMDIzY2I3ZDhjOWEzZDIwNjNiNTdlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaWRoYXJ0aGEgS3VtYXIgPHNpZGhhcnRoYS5rdW1hckBvcmFj
bGUuY29tPgpEYXRlOiBNb24sIDE4IFNlcCAyMDIzIDExOjQwOjA3IC0wNTAwClN1YmplY3Q6IFtQ
QVRDSF0gbW0vaHVnZXRsYjogZml4IHdhcm5pbmcgaW4gcGFnZV9jb3B5X3NhbmUKClNpZ25lZC1v
ZmYtYnk6IFNpZGhhcnRoYSBLdW1hciA8c2lkaGFydGhhLmt1bWFyQG9yYWNsZS5jb20+Ci0tLQog
ZnMvaHVnZXRsYmZzL2lub2RlLmMgfCAyMCArKysrKysrKysrLS0tLS0tLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Zz
L2h1Z2V0bGJmcy9pbm9kZS5jIGIvZnMvaHVnZXRsYmZzL2lub2RlLmMKaW5kZXggMTRkM2QyOGU0
MWIwLi42MjlkY2Q0ODU2YmYgMTAwNjQ0Ci0tLSBhL2ZzL2h1Z2V0bGJmcy9pbm9kZS5jCisrKyBi
L2ZzL2h1Z2V0bGJmcy9pbm9kZS5jCkBAIC0zMzQsNyArMzM0LDcgQEAgc3RhdGljIHNzaXplX3Qg
aHVnZXRsYmZzX3JlYWRfaXRlcihzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRlciAq
dG8pCiAJc3NpemVfdCByZXR2YWwgPSAwOwogCiAJd2hpbGUgKGlvdl9pdGVyX2NvdW50KHRvKSkg
ewotCQlzdHJ1Y3QgcGFnZSAqcGFnZTsKKwkJc3RydWN0IGZvbGlvICpmb2xpbzsKIAkJc2l6ZV90
IG5yLCBjb3BpZWQsIHdhbnQ7CiAKIAkJLyogbnIgaXMgdGhlIG1heGltdW0gbnVtYmVyIG9mIGJ5
dGVzIHRvIGNvcHkgZnJvbSB0aGlzIHBhZ2UgKi8KQEAgLTM1MiwxOCArMzUyLDE4IEBAIHN0YXRp
YyBzc2l6ZV90IGh1Z2V0bGJmc19yZWFkX2l0ZXIoc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3Qg
aW92X2l0ZXIgKnRvKQogCQl9CiAJCW5yID0gbnIgLSBvZmZzZXQ7CiAKLQkJLyogRmluZCB0aGUg
cGFnZSAqLwotCQlwYWdlID0gZmluZF9sb2NrX3BhZ2UobWFwcGluZywgaW5kZXgpOwotCQlpZiAo
dW5saWtlbHkocGFnZSA9PSBOVUxMKSkgeworCQkvKiBGaW5kIHRoZSBmb2xpbyAqLworCQlmb2xp
byA9IGZpbGVtYXBfbG9ja19odWdldGxiX2ZvbGlvKGgsIG1hcHBpbmcsIGluZGV4KTsKKwkJaWYg
KHVubGlrZWx5KGZvbGlvID09IE5VTEwpKSB7CiAJCQkvKgogCQkJICogV2UgaGF2ZSBhIEhPTEUs
IHplcm8gb3V0IHRoZSB1c2VyLWJ1ZmZlciBmb3IgdGhlCiAJCQkgKiBsZW5ndGggb2YgdGhlIGhv
bGUgb3IgcmVxdWVzdC4KIAkJCSAqLwogCQkJY29waWVkID0gaW92X2l0ZXJfemVybyhuciwgdG8p
OwogCQl9IGVsc2UgewotCQkJdW5sb2NrX3BhZ2UocGFnZSk7CisJCQlmb2xpb191bmxvY2soZm9s
aW8pOwogCi0JCQlpZiAoIVBhZ2VIV1BvaXNvbihwYWdlKSkKKwkJCWlmICghZm9saW9fdGVzdF9o
YXNfaHdwb2lzb25lZChmb2xpbykpCiAJCQkJd2FudCA9IG5yOwogCQkJZWxzZSB7CiAJCQkJLyoK
QEAgLTM3MSw5ICszNzEsOSBAQCBzdGF0aWMgc3NpemVfdCBodWdldGxiZnNfcmVhZF9pdGVyKHN0
cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICp0bykKIAkJCQkgKiB0b3VjaGluZyB0
aGUgMXN0IHJhdyBIV1BPSVNPTiBzdWJwYWdlIGFmdGVyCiAJCQkJICogb2Zmc2V0LgogCQkJCSAq
LwotCQkJCXdhbnQgPSBhZGp1c3RfcmFuZ2VfaHdwb2lzb24ocGFnZSwgb2Zmc2V0LCBucik7CisJ
CQkJd2FudCA9IGFkanVzdF9yYW5nZV9od3BvaXNvbigmZm9saW8tPnBhZ2UsIG9mZnNldCwgbnIp
OwogCQkJCWlmICh3YW50ID09IDApIHsKLQkJCQkJcHV0X3BhZ2UocGFnZSk7CisJCQkJCWZvbGlv
X3B1dChmb2xpbyk7CiAJCQkJCXJldHZhbCA9IC1FSU87CiAJCQkJCWJyZWFrOwogCQkJCX0KQEAg
LTM4Miw4ICszODIsOCBAQCBzdGF0aWMgc3NpemVfdCBodWdldGxiZnNfcmVhZF9pdGVyKHN0cnVj
dCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICp0bykKIAkJCS8qCiAJCQkgKiBXZSBoYXZl
IHRoZSBwYWdlLCBjb3B5IGl0IHRvIHVzZXIgc3BhY2UgYnVmZmVyLgogCQkJICovCi0JCQljb3Bp
ZWQgPSBjb3B5X3BhZ2VfdG9faXRlcihwYWdlLCBvZmZzZXQsIHdhbnQsIHRvKTsKLQkJCXB1dF9w
YWdlKHBhZ2UpOworCQkJY29waWVkID0gY29weV9wYWdlX3RvX2l0ZXIoJmZvbGlvLT5wYWdlLCBv
ZmZzZXQsIHdhbnQsIHRvKTsKKwkJCWZvbGlvX3B1dChmb2xpbyk7CiAJCX0KIAkJb2Zmc2V0ICs9
IGNvcGllZDsKIAkJcmV0dmFsICs9IGNvcGllZDsKLS0gCjIuNDEuMAoK

--------------LBgAu2WV9U6Nuc4c1wGUi9wt--
