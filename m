Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0081979CBB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 11:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbjILJ1r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 05:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbjILJ1q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:27:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA2D10D2;
        Tue, 12 Sep 2023 02:27:40 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C7mt66022347;
        Tue, 12 Sep 2023 09:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=xdQEucLlgo2A/FMNYLjNO4Og1AEeSho+PRIq5TWh1pk=;
 b=NOlekOryyRu5OeBfN0bz3rWUdxXma2LAWzZdO1dKIjRyd6BmVi/b12pcVHYrtLYdfS+i
 nrX35OBVCNvjXf9/UFIB1KKutSy81qoSI/s4kO5Srbwii4abAcS2kIS601xzy5spFE/g
 w6QI8KGEbUrDccAtCr7Xtf/dYCvaIVWHN3RwyUEQceXef/WJTaG6ObuVldXn5D+moGhR
 8eOB26m1Jki9yu3qilr6HRi72B7XaAVbXaXI+mgrKWiwrkUEMTZUQP0utQ1BQw7Kj8q8
 yQLZ1XUY+OBpVd1ifmM4ccyLmWNDf5VsQrFIk1h4vVtF2/KmmAmKt9HbZ9Au8N7ef5ke 5w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1k4cbfu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 09:27:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38C8gRrM023084;
        Tue, 12 Sep 2023 09:27:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f55qprw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 09:27:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXa/fOqFGFPZdUJxdqNszLR9x4Gud7uX8NDjbpPEZ+vLcOeyI4+VcoxACYMbTsytukRClglRGjiAWh8KNi1Ylp1ixTBps5lfNRQoRlUoQ8zT/DfFKCQ9tTa4ccZb4WDhpFCwscNLYOQSnxzN/HMLybt6kxw+3AMHG5lAYHvCTe5GzAx7G0S8qmmy4SSmMelDi0ItuSUVdsNvmqZvnXuh3VxPiDWDsG2UfJBbWxxBd4C91bL84EjsgTGbCTfWbTfRR9KKJ4hm56z7C4RJAaIBvdtd+KhON4PqKgm+DJ0pDQzHCxLvL9Vy4vrl02Pv9xsnOTnSV29KUbP9XQpims6D7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdQEucLlgo2A/FMNYLjNO4Og1AEeSho+PRIq5TWh1pk=;
 b=UnoTy0Nbk32De4PAzdAJjUuHfeEg4tlphprQkJHIlEBn6KFgli4R9dkMrS+x0hlyPaC5X+ISM9TC1DXof5D9dncFc9EuybjurlhJvI6YTHY62rkpDK7v+QyE3vLFkJT4f+XH5Rm8B3YuXvOsMbNHrf0LWvRDpJZf8qiGKXZJYl6e/f7r8Pmf6rpcdqEIHT9JSB5TjhUowi0hy4o5K5rsOMU0o9nnpJlH1Bg331lvvhoggRCTXdClV/ZBi3T6xbiUYTqZaBV8Q3vaNcpthj2/OILD4ZO6BAWH0Qf8V7EE8QHh5y13cCmQAf+JkedU7H3vMouSFTWiC7iU36PZNSSQgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdQEucLlgo2A/FMNYLjNO4Og1AEeSho+PRIq5TWh1pk=;
 b=uyJqRqwaj0duyXF8U0IIDR6FTH/+POSJi59Izl97lQne4yQOzuV7foFw3N5+eVPz0/jUU0CNnMF7NOnThf93iDa+WJOyHek53+PGthxltbnhtSoXh8hG7mawk69CfjMDR1aPVh1kPa/3lkXCpxj04hytAif5arFMChn5hvop2QU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6710.namprd10.prod.outlook.com (2603:10b6:208:419::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 09:27:14 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 09:27:14 +0000
Message-ID: <9a679809-6e59-d0e2-3dd1-3287a7af5349@oracle.com>
Date:   Tue, 12 Sep 2023 17:27:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V3 1/2] btrfs-progs: Add the single-dev feature (to both
 mkfs/tune)
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, david@fromorbit.com, kreijack@libero.it,
        johns@valvesoftware.com, ludovico.denittis@collabora.com,
        quwenruo.btrfs@gmx.com, wqu@suse.com, vivek@collabora.com
References: <20230831001544.3379273-1-gpiccoli@igalia.com>
 <20230831001544.3379273-2-gpiccoli@igalia.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230831001544.3379273-2-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: e8b31180-2a14-46df-0f0f-08dbb372734d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iUhikTlcKegs2rf7pHarzBVWi6HBaZIfz2Y6z7lqVOsUwHp4TTrq87CS1vsDqqEq0KPwvVcG8Y5urrXTNfkwBngkI3F8OyUhBgCzwd7I45LrCennP04FSHHth5rwOjcS9lQ1NJr3Ivtu+Y0bl9pPyR6TNfi6w1vzKd+/3jx3sduJcyg9orp0Frguwcm3CbJlIKQvrtTwRHC2bmhUPY9tSN7r3/jI0gCWgot+6OJ/D234EEZzbKPMMWMABHhmoGLbvMp2KFIThMy+SqVc9TFUeE2QDWQ0M95L3/9oF98nqz/aahUUZkFGOd22WFuKlZiGD+X+QTlQ+rK91W938mpaeavBf6QGPLqL3/2D0aGL3MnwbcrrtyLScj7WefnOxzvoXrl+/PKfXF7n8sC4pV494RpuJQmRpJuXBx+HxuulJAJUs8JjN3d+eUCAYZRpztFxeEuOttR8/T/Y6eUzC0xMIVq1RFK7tY2nUgOVi/f4wankSX0rUoFzN+qVj0KufZvFoIKJj5K4ljBopWSLyhAptzFJgu+C+RH2xAOzy//iq3wdJbxyHvsadqIvGaTMBE1OaODXuPYv/ib3T9COm+YrMjVcc7Wyj2DSbpXzelFDxdz+BwF/BdIzDLkNd7hgEbd7ryC3lkWliHxyae8HWFTt9v2zUS0IpXdLn4yodYzu4hkG/OfgV6BzdXLvdwr8oO4l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(136003)(366004)(1800799009)(451199024)(186009)(41300700001)(31686004)(6506007)(53546011)(6486002)(6666004)(38100700002)(36756003)(86362001)(31696002)(2616005)(6512007)(2906002)(83380400001)(26005)(8676002)(7416002)(4326008)(8936002)(316002)(5660300002)(478600001)(44832011)(66556008)(66946007)(66476007)(461764006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGRTeFJlWkUwbTkzTWdZTXZhMVVKOVdxeDRYam5uRlBkbzdjelpkT0xoK3ZY?=
 =?utf-8?B?Q0VCa29PMzV1SFZUK3o1NDFCNHUvVm04TkREa2JCMnNXK3gxc053cCt2dDdC?=
 =?utf-8?B?QStRSzQwYmhlQ3lKTWZKU1hIMGZSUmV1OXdlY0NuUkJKUll1eHMxaitETkh6?=
 =?utf-8?B?YkVQbU82WElBMjYwQUQ2OHNSa1ZsVDA3V203ZjFwYnJCd1JUUVdYY2xVRS9r?=
 =?utf-8?B?OTdibVAzZUgrS0ZWOGJ4aU5MSWhBcXlWdE1TWlQwS0RJS1BWckFGR2lTVFJn?=
 =?utf-8?B?eStaNnc3NGtXandndHNtYkl4dG9qSzREWis2Y2ZMK2U5RCtPQm1jUkZJeEpr?=
 =?utf-8?B?aUhnZlNleFo1U1g1MXhuZ05PdXpYQk10SFNCUDJqVFMrb0lzbVBYK2VOREow?=
 =?utf-8?B?UVJFSFRDZ3RjY2F5YmR5bElFaXhwUUVUamZEczl3TEZrTU90YUNrREEwa0o1?=
 =?utf-8?B?TEVBaDYweThlZTZxVkl1c0JMTEovdXFzV2NxYkh5YUVOWER4SHN5M21nSTQw?=
 =?utf-8?B?UFVrSzYvUHRkZmVITGxseWN4MEUvbmpOVWorWEt4OTNGRnc4Q3BZYTYrOEQ5?=
 =?utf-8?B?WkYxOHl3dVE1N3FGN08yRnJBQ2hVVW1oQ0xvcUxNUEIwc0FYc3dJRis4NHBR?=
 =?utf-8?B?N2Zhb21ST0pwU0xsR0x0UE9LbmFpNzc3cERZZEQzVlNjeVZRbHp1Q0pacVFN?=
 =?utf-8?B?a1R5SFVaNkozaUNYZ1BVV3NDSjhhWVMwaWRxbXk2TDJLOS9tTUp4anUxNTFw?=
 =?utf-8?B?ci95U0VlZ3lvMjVzVVV3Y0N0NnNjODU2SlhnbEV3YlpKSzg0UUZ2UldCbkl4?=
 =?utf-8?B?YUF1T2ZybDJPQkxGMUI2cUg2VU1PZlFHVDZnUHlYTmQrUjhzeEIrRFZSck02?=
 =?utf-8?B?TEFuOW1VRG5LZzB6ZkFtbFdrK1VnWERsbCs4QlFvdGRpZ1lJd0RycVZJSGU5?=
 =?utf-8?B?MVJiT0FNd05URERhT0Jzc3ZLTCtiWkhMM3ZwdGlxVXd4emhvL2J3WGo3Y0h4?=
 =?utf-8?B?QUh0OTBoNzRMZk5zRjI0a2pUbHplVlhtYk05UHpFd2tmSDNaRGRJNFNpbS8v?=
 =?utf-8?B?VnNQd21YV2t2WWR5ZTNTaHJiQzlRNjZ1QlVnZVNaTUtWNHpLR3ozWFNZbEZQ?=
 =?utf-8?B?WGRSVUUwZHp6NkFTRGFweU1vYkZNa1prMDNoS0c3ZFlmaEZ1QXJXNU01a1g0?=
 =?utf-8?B?SDR3NEN4bnVzdXJoREVkaWR0bHplWEF5NW9yREl6dTBXV1JJaTVvV1pOUG80?=
 =?utf-8?B?dG1QMWxtNjRzeks5aTMxemFzQ3dDQk5MVW1scVNvOW5tMm1YSmxwVUJVSHB2?=
 =?utf-8?B?Y01MTjB1QWhFQzhMbTlia0JPVkk2Y25OS244UFhOWUZ4Q2J4eWh6QmJXTW9G?=
 =?utf-8?B?M2NwT0wyTUVFOTl4ZjIyZDk5MTlhRlNvbHk2MTl6KzJMaHg4ZkFwVUVxajBt?=
 =?utf-8?B?NEJPcTFua01YaEtKOEFxWHNPajBHSmQyS3VMTGE5YjlyTFp0cU9mQlNzelRY?=
 =?utf-8?B?R3lGN3pjeUQvcEhJbG9kaTFpU0Zpd1Nxajg1SzZ3QmxQcEp2bmRLNE5oSFRZ?=
 =?utf-8?B?N1ZIRzlVRGwraldZM1FLaXdGb0RVaU5BUXRYTnhGeXdwOGZRU0VXbVhCdzlY?=
 =?utf-8?B?ZXBxQ2JabDhCcEc5RnY4YnlhSDJkdjVCdG0wNWhiMDFUYU9NOWV3SHBVaitW?=
 =?utf-8?B?VmVBa2crM3c4c3JQajlsdVpYVldCd1FBdnVWTkkwUnZOazRzaEwxR0VhWVo2?=
 =?utf-8?B?N25WeDRxSXpzOUlhNUlEbE4wRXNBdGI4S3lzelNHbUVhSlZWd1VKT2s0NU5t?=
 =?utf-8?B?aGx1VktkdldBN1Q5Ly9IMjdXSDh2NGVqTE05SCtnamlmZXU0dlRML09heGFr?=
 =?utf-8?B?M2c2eFJFd05ob3BMUmdxUklvNjAvbmxUNVNlU21vQStOcllEUGdwbU1tUTRW?=
 =?utf-8?B?YjdNS3VZRTBqM3BrYU1OUXpvem5FVUlETG1PdnFrbWJKQWJFcHc3dE5NQ2pJ?=
 =?utf-8?B?d3NXUmJ6OGZPNFJLTW9Mc0ZoV1E4UzNTTllRR05SMVJYVW9jMW9VSGNUV1hF?=
 =?utf-8?B?SXNaUWNmSnZHWndqek5EVUtwVFEzblhVU1ErajlaRFVxdS9mNFlDelZucmFv?=
 =?utf-8?B?SWFOZTE1TlJML09vNy90TGtPRzY2K0JjQzd2NklFT01ieE40QTNuT2FBb3hB?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?M3FReGQ3T2Y0OHVYYkM2aEVtL1R2UHlBaU9ody9lNnFkYWRmeSt6OTlNMklV?=
 =?utf-8?B?OTJKNXZWNitidG9TTm4rNmE0aU05RFprYitnT09CYTRObmtjNVc0RThlcmdL?=
 =?utf-8?B?dEpIbmxhMm5kcVVKTmhiVlJJdzVxYzM4cVVnUVIvNEJuaDl1dTVaSWdYWDlZ?=
 =?utf-8?B?MDBwTE1HVVlJei9ydExVL1plUlNkZVRxK0VBdnNFd3N1aTNOWDZ0ejIwc1dn?=
 =?utf-8?B?anQrYjdsVG1MbHIrdXZwUUhadlZRMEJ5aklPM0hYMFVEbmxuN1djVWhJZHFj?=
 =?utf-8?B?c2ZnOVl5MzhQYWdLUnN4ZjhUS0N4YitVYkUzc1VoK1NxK0doaGJnUVV3QklH?=
 =?utf-8?B?a1VQMGF2MmQvOVRhOUo2U3hBK2dITkNGZGY5aVVJMy9LakxuRzJ0QUcvazkr?=
 =?utf-8?B?a1NlK2k5VERkODB1Wm5IM09VRCt6QmF6Vmw2emo2YUJXa1VqbjNpYkVKZk9y?=
 =?utf-8?B?TitZWTdqbkdjajhhQVVhL2liK3hWYjJkQmtCUWhRdUk4UUtGQk5NNXoyV1Y3?=
 =?utf-8?B?VEJKR0JKMzdCaFRrSTBoenJTdk5iTmNPMkpwMDFDRlZvdGxLUzFKM3FQdjNW?=
 =?utf-8?B?bmtpWWRpV2JFVnFXbnBGOWpFTHRoNjNhY0Q3Mi8vUVZPT0FPQXhlVC9IZm1X?=
 =?utf-8?B?clc5dEdVSHg4cXhSekJXemNPVlUrOWQ4N2pwc1BSSDBHQkJ4dnB1VEtxSHRC?=
 =?utf-8?B?ME5XSnV5MWxsbXZ5c1p6bjhtRG1BTWtwU05wclcyVzMwTkpwQk5LSWQxY3l3?=
 =?utf-8?B?bW9QRXI1aGF5SUdoYjdQa2VVcTlXL1RRNDlYNFZ4ZE9uYUxXbXFmM1o2cVlJ?=
 =?utf-8?B?cHhNYXlvUEVvTUw5U2pFRXdGM1V1bGJzeWhVTk9PNXJUTFJtZUhmT0d0MldY?=
 =?utf-8?B?ZDQyOUdNNFduaUJNOXVaMGdnQUo4M3JucWxHNnhHOWpYdGdiOGI4UGloQ3lF?=
 =?utf-8?B?OXZ4K0lUNmlDNjU3cURtK01jOWszcTdRVnBQL1E4eUlUaDNQYjJmYVp4Z0Mx?=
 =?utf-8?B?eWQ0TkF3ZW5CQVRaUHMyK0llblEzZUkzZ3VYYkFyNE50eE15eHBaZnBVcTF4?=
 =?utf-8?B?WXF4Y1h1QlNRSVRPZzd2VjZJdTVQKzB1VHNJcytvcjNidFBEMHBVR29PYTk2?=
 =?utf-8?B?K2ljS3g3ZmhPZHlNODJCemIrL0lwSnJHVm1vRDkyeGFTNmZuSG9UQ2d3cTAv?=
 =?utf-8?B?SVpzZ056NnNzVTNXQ1lGUXNDNjNoS2NYQTNHTlZLeCtDa1V2cWpoclpSb2Nn?=
 =?utf-8?B?cDB0VjdsTVBJcVVxbUVYN2ZuMmtPbWxtWGZwZGc0Rkxpb3RDV0dOamwzYm9Y?=
 =?utf-8?B?ZFFZSFBtaDlkay9nOGp0UHVWclpQakI2THBuMTRKclVSQmJNeTFqczc0bzBT?=
 =?utf-8?B?UG01ekovdnE4MnlteTNCR2w5N0Vlai84QW5LSFlSRE9PeG5PZExsZ0dVeVVQ?=
 =?utf-8?B?MVoxU0p0UjQ2Q3JtQUw4dUROTEp2NDI2UVc5NEF3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b31180-2a14-46df-0f0f-08dbb372734d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 09:27:14.8183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJvoe7W0/mbgXT+fQSfhfIBA5ML9Ozphfada0bc2CMa67sxKQMj2+5oaa9Eivyt1g7WsgHaYpzoGNlXw6UQORw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6710
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120079
X-Proofpoint-GUID: Nk7nGRWzhAajLjbL19DUy_iHYl9Mzoko
X-Proofpoint-ORIG-GUID: Nk7nGRWzhAajLjbL19DUy_iHYl9Mzoko
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


  We may need to fix the command 'btrfs filesystem show' aswell.
  Could you test having more than one single-devices with
  the same fsid and running 'btrfs filesystem show' to ensure
  it can still display all the devices?

Thx.
Anand


On 31/08/2023 08:12, Guilherme G. Piccoli wrote:
> The single-dev feature allows a device to be mounted regardless of
> its fsid already being present in another device - in other words,
> this feature disables RAID modes / metadata_uuid, allowing a single
> device per filesystem. Its goal is mainly to allow mounting the
> same fsid at the same time in the system.
> 
> Introduce hereby the feature to both mkfs (-O single-dev) and
> btrfstune (--convert-to-single-device), syncing the kernel-shared
> headers as well. The feature is a compat_ro, its kernel version was
> set to v6.6.
> 
> Suggested-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
> 
> V3:
> 
> - Changed the small '-s' option on btrfstune to the
> long version "--convert-to-single-device" (thanks Josef!).
> 
> - Moved the kernel version to v6.6.
> 
> 
>   common/fsfeatures.c        |  7 ++++
>   kernel-shared/ctree.h      |  3 +-
>   kernel-shared/uapi/btrfs.h |  7 ++++
>   mkfs/main.c                |  4 +-
>   tune/main.c                | 76 ++++++++++++++++++++++++--------------
>   5 files changed, 67 insertions(+), 30 deletions(-)
> 
> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
> index 00658fa5159f..8813de01d618 100644
> --- a/common/fsfeatures.c
> +++ b/common/fsfeatures.c
> @@ -160,6 +160,13 @@ static const struct btrfs_feature mkfs_features[] = {
>   		VERSION_NULL(default),
>   		.desc		= "RAID1 with 3 or 4 copies"
>   	},
> +	{
> +		.name		= "single-dev",
> +		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV,
> +		.sysfs_name	= "single_dev",
> +		VERSION_TO_STRING2(compat, 6,6),
> +		.desc		= "single device (allows same fsid mounting)"
> +	},
>   #ifdef BTRFS_ZONED
>   	{
>   		.name		= "zoned",
> diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
> index 59533879b939..e3fd834aa6dd 100644
> --- a/kernel-shared/ctree.h
> +++ b/kernel-shared/ctree.h
> @@ -86,7 +86,8 @@ static inline u32 __BTRFS_LEAF_DATA_SIZE(u32 nodesize)
>   	(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |	\
>   	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID | \
>   	 BTRFS_FEATURE_COMPAT_RO_VERITY |		\
> -	 BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE)
> +	 BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE |	\
> +	 BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV)
>   
>   #if EXPERIMENTAL
>   #define BTRFS_FEATURE_INCOMPAT_SUPP			\
> diff --git a/kernel-shared/uapi/btrfs.h b/kernel-shared/uapi/btrfs.h
> index 85b04f89a2a9..2e0ee6ef6446 100644
> --- a/kernel-shared/uapi/btrfs.h
> +++ b/kernel-shared/uapi/btrfs.h
> @@ -336,6 +336,13 @@ _static_assert(sizeof(struct btrfs_ioctl_fs_info_args) == 1024);
>    */
>   #define BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE	(1ULL << 3)
>   
> +/*
> + * Single devices (as flagged by the corresponding compat_ro flag) only
> + * gets scanned during mount time; also, a random fsid is generated for
> + * them, in order to cope with same-fsid filesystem mounts.
> + */
> +#define BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV		(1ULL << 4)
> +
>   #define BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF	(1ULL << 0)
>   #define BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL	(1ULL << 1)
>   #define BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS	(1ULL << 2)
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 972ed1112ea6..429799932224 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1025,6 +1025,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	char *label = NULL;
>   	int nr_global_roots = sysconf(_SC_NPROCESSORS_ONLN);
>   	char *source_dir = NULL;
> +	bool single_dev;
>   
>   	cpu_detect_flags();
>   	hash_init_accel();
> @@ -1218,6 +1219,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   		usage(&mkfs_cmd, 1);
>   
>   	opt_zoned = !!(features.incompat_flags & BTRFS_FEATURE_INCOMPAT_ZONED);
> +	single_dev = !!(features.compat_ro_flags & BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV);
>   
>   	if (source_dir && device_count > 1) {
>   		error("the option -r is limited to a single device");
> @@ -1815,7 +1817,7 @@ out:
>   		device_count = argc - optind;
>   		while (device_count-- > 0) {
>   			file = argv[optind++];
> -			if (path_is_block_device(file) == 1)
> +			if (path_is_block_device(file) == 1 && !single_dev)
>   				btrfs_register_one_device(file);
>   		}
>   	}
> diff --git a/tune/main.c b/tune/main.c
> index 0ca1e01282c9..7b8706274fcc 100644
> --- a/tune/main.c
> +++ b/tune/main.c
> @@ -42,27 +42,31 @@
>   #include "tune/tune.h"
>   #include "check/clear-cache.h"
>   
> +#define SET_SUPER_FLAGS(type) \
> +static int set_super_##type##_flags(struct btrfs_root *root, u64 flags) \
> +{									\
> +	struct btrfs_trans_handle *trans;				\
> +	struct btrfs_super_block *disk_super;				\
> +	u64 super_flags;						\
> +	int ret;							\
> +									\
> +	disk_super = root->fs_info->super_copy;				\
> +	super_flags = btrfs_super_##type##_flags(disk_super);		\
> +	super_flags |= flags;						\
> +	trans = btrfs_start_transaction(root, 1);			\
> +	BUG_ON(IS_ERR(trans));						\
> +	btrfs_set_super_##type##_flags(disk_super, super_flags);	\
> +	ret = btrfs_commit_transaction(trans, root);			\
> +									\
> +	return ret;							\
> +}
> +
> +SET_SUPER_FLAGS(incompat)
> +SET_SUPER_FLAGS(compat_ro)
> +
>   static char *device;
>   static int force = 0;
>   
> -static int set_super_incompat_flags(struct btrfs_root *root, u64 flags)
> -{
> -	struct btrfs_trans_handle *trans;
> -	struct btrfs_super_block *disk_super;
> -	u64 super_flags;
> -	int ret;
> -
> -	disk_super = root->fs_info->super_copy;
> -	super_flags = btrfs_super_incompat_flags(disk_super);
> -	super_flags |= flags;
> -	trans = btrfs_start_transaction(root, 1);
> -	BUG_ON(IS_ERR(trans));
> -	btrfs_set_super_incompat_flags(disk_super, super_flags);
> -	ret = btrfs_commit_transaction(trans, root);
> -
> -	return ret;
> -}
> -
>   static int convert_to_fst(struct btrfs_fs_info *fs_info)
>   {
>   	int ret;
> @@ -108,6 +112,8 @@ static const char * const tune_usage[] = {
>   	OPTLINE("--convert-from-block-group-tree",
>   			"convert the block group tree back to extent tree (remove the incompat bit)"),
>   	OPTLINE("--convert-to-free-space-tree", "convert filesystem to use free space tree (v2 cache)"),
> +	OPTLINE("--convert-to-single-device", "enable the single device feature "
> +			"(mkfs: single-dev, allows same fsid mounting)"),
>   	"",
>   	"UUID changes:",
>   	OPTLINE("-u", "rewrite fsid, use a random one"),
> @@ -146,7 +152,8 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>   	int csum_type = -1;
>   	char *new_fsid_str = NULL;
>   	int ret;
> -	u64 super_flags = 0;
> +	u64 compat_ro_flags = 0;
> +	u64 incompat_flags = 0;
>   	int fd = -1;
>   
>   	btrfs_config_init();
> @@ -155,7 +162,8 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>   		enum { GETOPT_VAL_CSUM = GETOPT_VAL_FIRST,
>   		       GETOPT_VAL_ENABLE_BLOCK_GROUP_TREE,
>   		       GETOPT_VAL_DISABLE_BLOCK_GROUP_TREE,
> -		       GETOPT_VAL_ENABLE_FREE_SPACE_TREE };
> +		       GETOPT_VAL_ENABLE_FREE_SPACE_TREE,
> +		       GETOPT_VAL_SINGLE_DEV };
>   		static const struct option long_options[] = {
>   			{ "help", no_argument, NULL, GETOPT_VAL_HELP},
>   			{ "convert-to-block-group-tree", no_argument, NULL,
> @@ -164,6 +172,8 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>   				GETOPT_VAL_DISABLE_BLOCK_GROUP_TREE},
>   			{ "convert-to-free-space-tree", no_argument, NULL,
>   				GETOPT_VAL_ENABLE_FREE_SPACE_TREE},
> +			{ "convert-to-single-device", no_argument, NULL,
> +				GETOPT_VAL_SINGLE_DEV},
>   #if EXPERIMENTAL
>   			{ "csum", required_argument, NULL, GETOPT_VAL_CSUM },
>   #endif
> @@ -179,13 +189,13 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>   			seeding_value = arg_strtou64(optarg);
>   			break;
>   		case 'r':
> -			super_flags |= BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF;
> +			incompat_flags |= BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF;
>   			break;
>   		case 'x':
> -			super_flags |= BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA;
> +			incompat_flags |= BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA;
>   			break;
>   		case 'n':
> -			super_flags |= BTRFS_FEATURE_INCOMPAT_NO_HOLES;
> +			incompat_flags |= BTRFS_FEATURE_INCOMPAT_NO_HOLES;
>   			break;
>   		case 'f':
>   			force = 1;
> @@ -216,6 +226,9 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>   		case GETOPT_VAL_ENABLE_FREE_SPACE_TREE:
>   			to_fst = true;
>   			break;
> +		case GETOPT_VAL_SINGLE_DEV:
> +			compat_ro_flags |= BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV;
> +			break;
>   #if EXPERIMENTAL
>   		case GETOPT_VAL_CSUM:
>   			btrfs_warn_experimental(
> @@ -239,9 +252,9 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>   		error("random fsid can't be used with specified fsid");
>   		return 1;
>   	}
> -	if (!super_flags && !seeding_flag && !(random_fsid || new_fsid_str) &&
> -	    !change_metadata_uuid && csum_type == -1 && !to_bg_tree &&
> -	    !to_extent_tree && !to_fst) {
> +	if (!compat_ro_flags && !incompat_flags && !seeding_flag &&
> +	    !(random_fsid || new_fsid_str) && !change_metadata_uuid &&
> +	    csum_type == -1 && !to_bg_tree && !to_extent_tree && !to_fst) {
>   		error("at least one option should be specified");
>   		usage(&tune_cmd, 1);
>   		return 1;
> @@ -363,8 +376,15 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>   		total++;
>   	}
>   
> -	if (super_flags) {
> -		ret = set_super_incompat_flags(root, super_flags);
> +	if (incompat_flags) {
> +		ret = set_super_incompat_flags(root, incompat_flags);
> +		if (!ret)
> +			success++;
> +		total++;
> +	}
> +
> +	if (compat_ro_flags) {
> +		ret = set_super_compat_ro_flags(root, compat_ro_flags);
>   		if (!ret)
>   			success++;
>   		total++;

