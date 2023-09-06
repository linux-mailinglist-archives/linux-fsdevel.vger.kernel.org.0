Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224577938E0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 11:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbjIFJvv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 05:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjIFJvu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:51:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF2392;
        Wed,  6 Sep 2023 02:51:46 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3869Z3bK011429;
        Wed, 6 Sep 2023 09:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=rneZTu361a8CPbgNBTwD2KhYK0j0jwpxjcfyJJwnfLk=;
 b=qJ+oEuB6fVl6Pcs9W+WKSRM2UCdPt1maO1GVpVa6H72K3EKrjVxBI/ROKKj5wuLxBUz4
 mjZE5sjZUAkN671OHEvv7MSN0nse7aVldaawKU3WZjts/iOBr/mlqujQ+l4+yGITKopT
 1HWXSi/ngdT8LRNc8q9WkHYd57vxcxwYl9Gq1EMULIUSlQsonaqksPJXpcXcjkarMiqW
 sT8nVxJCLmFOrjCXoq3RFET16vCc+ioclfJNN8nQDid7EAaatuNN3pZqTYi8JqqUVmcQ
 IngUx1jPBOkMWBpPxDaE0zAgElmJ83EeyNMY3UiB/gi2EqtR04/cLtDTV2lIqSEhRWs1 7A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxpwqr1nx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 09:51:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3868qWg1010424;
        Wed, 6 Sep 2023 09:49:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugc82ks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 09:49:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksZGdiNKfF5QarC7HJSh+sd2fzXuCIFL+0XnQ1kySPOYolAm7K/tviyBYZerPGRd5Kce8KUNZJW44w73zxA/zogYjRmSAd0aGL4P2zXWK7pV0EqXktU31P+Wh++6L3bcNdcsdlh/DjoWEluffemJhusssEQaAth+4OG1YvdZaTieAUON6Q6/OWw/xRGmB0YAwlMwVkTkU378V30xqdUwXwpqFYVYP1AcMl8Vtusjvdvk6XV2ELlluW7/IZu9Sp/YpUuTm49gtYtxkTLjQWtATiFQAWrZoVeOfo6Yl3SgUunuap9sxvAo0xqhZeT4RNROHQiU6W4rVNkHNWgPnmgknw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rneZTu361a8CPbgNBTwD2KhYK0j0jwpxjcfyJJwnfLk=;
 b=F4AA1oaiV9Uz+xWWACMW5wu7iTLiyGbXns7/IoLCuekAWYnwJrJcDtMz4uVKEtFAYU/UJgWsnb6Un4Smt1cgMZLIFLgQJ9MCW0oiqRxaTQSyoXHktqHU/dPfCOLJKcR1hQWac8yXJoY1MX2dsru/KxzrE3spe7vpRGvi5H/kTkJZYwSxXWh52TgxXgFONIK+DJWMQcJzyjABSea2bT4kw/O+jDAETRA0IbmeTShKQa06jP2/6pLEaRFhqtsjvsajhGbwCURZdDhuRiDu0C0lN3OA1jc0dnLZZL8QuSaBEIiKOWFD7xOD77ZK19GGS6RD/B47fL5GhEVNvqZyDyrm2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rneZTu361a8CPbgNBTwD2KhYK0j0jwpxjcfyJJwnfLk=;
 b=bs3UCXOUM/6tOyZ3BCWX/di3GSlxV1RXX+ZZkb8V9v9lo/s51Eq8yc9FJUqOVUHhPfTq3YH5nbREKP1eBPkTTe6besLJdQsJY/1ag2XfXJD7aRyODPMfFTNh6f1XTr5JNB8wfrMhctUdRp1SD/VK7XNGVz0B3XHCSPHB4RbsiSU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB6778.namprd10.prod.outlook.com (2603:10b6:930:99::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 09:49:19 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 09:49:19 +0000
Message-ID: <fe879df8-c493-e959-0f45-6a3621c128e7@oracle.com>
Date:   Wed, 6 Sep 2023 17:49:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH V3 2/2] btrfs: Introduce the single-dev feature
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>, dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
References: <20230831001544.3379273-1-gpiccoli@igalia.com>
 <20230831001544.3379273-3-gpiccoli@igalia.com>
 <20230905165041.GF14420@twin.jikos.cz>
 <5a9ca846-e72b-3ee1-f163-dd9765b3b62e@igalia.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <5a9ca846-e72b-3ee1-f163-dd9765b3b62e@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 09c012bd-4b3e-4b0f-43cf-08dbaebe8a61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eAT0hZXqzxVWpQjDDXq3CjLv4DniEmErksz4s1yoiiqRuprjwO+w5g/FHUT4MD3jr7JiuPjf32zoSZi7nf5/OSbUpRaDeC52zHuO74SAjfvEXtpXZsKTvN1rCiLErpKpTkGRMto89emPV9Qefg2NusBeCIaLqrKv3f2mSBoPa6Bm8KqBttuavb+FNgawhshDJ6tPJxmD0CGpdszG/o9pZoMN03HvW3Kv8saMOuU6liIoKpmnBrSjv3lFvsGoBpAUQx6+GZPJu8N98n8c7XBPf6YpOSPJcf0wQx9BdaChwUbbfM6P/L2w1oEEvmHq/OoMk8YFu4Bp8WhJYb8TVTGRAiK3F15dEL6h2uegT+iWskmPCLSGxrupiruCnatekzXSs4EbUEiuBMFJqmjv7Y1E705nqqy5/HQcsMPqOOZkKafNKNEfYOFhwQ7d0e0Djax+G0CojWPRXcw0T1uyBd/zuc9BpFWHhde4FgzfXhuR+j3Zf3vRoqevqY/ac1h61/SiZF96wJsw8kZRUorxumt+MMN2H5VL9thL04no2dl/K4ZMK95I7OsxoxvbKXDZCCaP0Ck5ypnVguwrAu6THQaSiByrYNeCqIPqY2JCtN9dBMQrV8+ZS2KAQMVVf4mCH/ZE6+nugxs5rBooF6jH1yKDuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(136003)(39860400002)(1800799009)(451199024)(186009)(31686004)(36756003)(5660300002)(83380400001)(31696002)(86362001)(7416002)(4326008)(44832011)(41300700001)(8936002)(8676002)(53546011)(6506007)(6666004)(6486002)(2616005)(26005)(6512007)(316002)(478600001)(2906002)(38100700002)(66476007)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3kwaFpxZ0Mwem5xd081NjU3ZHdJdGNGbVNEdmRZZmF6OWU2aHFkcW9xdHFw?=
 =?utf-8?B?QzBoVGtaVXV6V1E0Q2pkZ2RDTEgvamxOVXUzQ256WGh6QVdOSXh6aEtXMVpK?=
 =?utf-8?B?QUpKVTUrOTQxOW4rWUM3aWJQQkRnRzU4ek9XbUhIZy9FTXYvZzZLcUdITXpB?=
 =?utf-8?B?S013eTlwaUFPU05JRGVNSGUyVTlaN215RnhOaEFkNWxLaERZWEtrWUdNVk9p?=
 =?utf-8?B?Ukl1VVRXYjNqcE1SbC9jWmgyK0JIK3I1ZTRPVkl5bkVkcjc2QW42bUhaRStl?=
 =?utf-8?B?Tks4aTd5R3ZkUkZ1ZjdzRkFScWUxSmVjQlRBMHYzV01EQVdhaXFRZXAwZlRz?=
 =?utf-8?B?NFJ5Rm55L1BjaDNheWRSVjR6T015YnRnZi8xQ3FQWDA0VXZneXQwODNiSE82?=
 =?utf-8?B?NmRnSmxOUXFDUzM2RjJMNWI1QUdKdkQrUFRQVW0xaVNxdjJ0YW96NkVteWZB?=
 =?utf-8?B?MzA2Vm5iWTNCajlQL05IcTRXRXhSRUwyMEdqRERiYkpTeHJ5dnZRK2lzajBs?=
 =?utf-8?B?eW43ejVtRkdzMkR2MWhPREZyMmtRQnU3RkY1d0pQY0F6Tkk5dE8vTmdnbGJN?=
 =?utf-8?B?NHJNaGtFWU1xSHorRUdxNlp0RC9DT3huQWFPVjdncHEzdjJnNGdBU2VoQkRy?=
 =?utf-8?B?M29Od0RaYU92QVBFSHZOQTh2MUNKZnhoUmIzYkZNTVdYcUMwQ2RjVXk3Tnpi?=
 =?utf-8?B?TVByYW5SQmZucmNoQmk0eWwrQVdDMmFqMVhKUXNjNDkzR1Urc3IrSWtJYVhy?=
 =?utf-8?B?Uis5K3BjbnhacDFWRmNEanhLbXo3ZlVPZENWd2xFTmN1aEhQb2xFOWZZSzBm?=
 =?utf-8?B?WXVlV3pRSW1pTFlFRVBWVVFIQURUNWFpeVlKcm5UUVQ2U2R6VytFT2d0VGti?=
 =?utf-8?B?N0g3d2JSdU9RdGl1dzJXMVZKOHJLamlvRnI1OEQ5M3BwZmlWdTU1SHJDSnRl?=
 =?utf-8?B?RnY5alF4RzJwOTByZGlQYmF4SmpBOFBraXRVbjBnWUFmYkhUWkgrdzQ5b2Q5?=
 =?utf-8?B?ZDlHcDNEaEdVdXczNExBZE03NnBqaXZZdG9Jc1hsRDZIcGVsZjQzaDJFWi9y?=
 =?utf-8?B?MEdhc21aZHoyQ0p5T3kyTDB4bWF0UWd0YTc0d2FwaHgzOE95aHhqMUpIT3l1?=
 =?utf-8?B?UmxhUElTVlZkR2ozanVzN2grOXFqWVZ1YVk0V2VwQXFhZjkzN3JPaGV6M1NP?=
 =?utf-8?B?RVF4U0NvSnJPOU5LZWJ6dmE4b0hJQVB1eFRPRXhra1RIQTRDNlZ5YVZmc21h?=
 =?utf-8?B?Y0oxZ1lXWlZLSDRqUmpXaVdFdEhhY1NUVExEZXFSbGlLNHlLbGFySGV4UVIw?=
 =?utf-8?B?M0pHQjFZVU9JRCtuZXpEOFJWQzFoK3lVNzZYRmVROGczTUhtWFZPTHBpK0xS?=
 =?utf-8?B?YkVjYWhFM3AyM3hxcVo3WTk2ZlRWbDd6VitSR2REM05lSkNGWVRnVDJ4dno3?=
 =?utf-8?B?bEVWakg4ZnlmRnNLYVBadDBwNVRDM3FhdXd0c0E2OTFDcXB5RWdTdmRCK3pO?=
 =?utf-8?B?QTE4NFBsVnZxenp4NGlOQnZMU3hLZUpVS1lVYzdtWFlBdGs1aklWdWE4eXE4?=
 =?utf-8?B?bmNqaTE1Rkd1WllENGd0QjFnQWFKakdEajUrc1FvV3Y5RjBCd1ZOVUR6RHRE?=
 =?utf-8?B?MXIvT1ZYa1I2TFRzMlpqRFhJQ1J5Y21GZEVua0RTdzZiTEFSTGxsd2Q4N2Fm?=
 =?utf-8?B?eUEvOHR5MEtMWGpDL3VsUXM0QktUdjZ3SWtNUFkzang1Qnp4SVdMQ0VkTmtM?=
 =?utf-8?B?YWZ6WnVpL1U3WEY0ZzMrT25XejE0NHluWkFDaDhBTktYVU5lT2dFRUQrOXRl?=
 =?utf-8?B?UnJBQ0JuOE55S2pPbFRSZVBNMnpoTjJESWp1UXNGOGh2cUpkWXBjVENsbXNC?=
 =?utf-8?B?WU1ReGxZMEkrSm1vOG1mMGJ2M0o3K2YzemhUS1h5ZW8yWGdxbVVBSzkzS1I4?=
 =?utf-8?B?bDNmSTlSYmdrMnJnZHBoZHRFelpQNVUzMkhacG5HYVZ5RExlWVdKOEhQZTZY?=
 =?utf-8?B?REpCajVwRXlTQ0JJcXhQbWhTY1NVb3ZPU2x4NENobElSdUV5cG5nMDNuaWhU?=
 =?utf-8?B?MXpPTUpQeHNLR2lQUThOZGN1RURNQ04vU0JZdEVXazc5clZFdm5NNEdrVTZN?=
 =?utf-8?Q?fFrMtWfqomo0Tagy95rwAOu3P?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VE1ZMjI5U1lkMUczN1hVeTlZR2pKeVdON0pwNUk5UGtOWElJNFZiZFFYYytN?=
 =?utf-8?B?QnZpK2pHRkFQZUdETExud0w3bHFBaG0za0JtV3pTbEF0YjV1YzNibWNVTHl0?=
 =?utf-8?B?MjYxU0YxcVEzbHBLUmVpL3o4emU5M0NjWEtxdGppL0lQWUNDL05vQUlhcmpS?=
 =?utf-8?B?Vno5VFBZNFFpVXp6QmpMT2ZnaWd1a25kckgvV0FJcSswQWFlZzdIZ2pNeUhK?=
 =?utf-8?B?RjZiOWJVRG0xTzUwQzRrcHkydFAxTnZWRng4U1lZNmZWTFIvZE5YM0N0QmJr?=
 =?utf-8?B?SDF3V0M0ZDc4alhGcjFzTmRnUm54Q1AzL0d4Yjc4bHFoZ3QrVXpWY2FxS1kw?=
 =?utf-8?B?dkhOY2lvZ3BNV0didUJNaStCQjVuQ2RvcWUrb0kwd3U2Z3NpRXhCZzF3a1l4?=
 =?utf-8?B?NEVtT1ZISGFqd3BkckZLQ3o4R3JkbmQwT2h5b085L3hnNFlWcjBQaXBHSThs?=
 =?utf-8?B?czhsL0VIdWVhM3B5dEhiVVZCeWhWaWxKWGtPK1pwaEJWUDVQbnJSMDkvdjF3?=
 =?utf-8?B?UWRkbWdIRmZXYVpPdnBjSTZtTmVBTEVleGx2dkMzQjlrQ3RDYUlDenJXb2lD?=
 =?utf-8?B?YmlDaWN4VmNNWWxhZzFoT1lpV2JjZXE3NU5JV1hFeXVLYkx1cmkyMTZmSS9G?=
 =?utf-8?B?Y2p6a2IzWjZkTklVS1pUQXFvYnp1WnlyNFhQdmc2VkIzaFRqZE9sNWlqLzVq?=
 =?utf-8?B?elJ3dmtFZFVweEkybWNOSTRzbE1aZGs2dkhoY040V2R1dFFQSFJMRWR4WU5x?=
 =?utf-8?B?S1lPa3BEUjlVNzBZR29TSzkvTFBuWGdtNXVRN0ZkY2hCcldYRkdVd3ZHL0Ru?=
 =?utf-8?B?K0orQ2lkbHZGQ2ZlWFc4WkdZc0F2UGFTRitpWm1tanRrM3pzRGpIOTRndUZk?=
 =?utf-8?B?MVVLWXRtVGpHTDE1ZWwzbUJFbHJPcFY3eldIUnVONm5oNytSeHIvYXNnWEhY?=
 =?utf-8?B?UWV1V1FRbGo5eW44eGo1SFBsZHgzaExHL1dtOGdad2xBQXRvU015M1NidjZz?=
 =?utf-8?B?eTVRSjBybmIyc3hMOHYxU1N0UTR2eGJZOVBnbXhGelNSK2NRRWVYOWZTQlJS?=
 =?utf-8?B?ajV3YWphMDdDTGxqSnNqQUwyMCtOcUw4dHVtaXFSLzlVR3lHWDNwWGZPamhF?=
 =?utf-8?B?eEp3Q1lGZ0ZUa21raERsa3NaT1pQeE9tWHBDcjVMNE9oMnJCWnJxVTNVdHBW?=
 =?utf-8?B?bkRuajhvNldJLzhIVWk0aFQwRXdaQ2g4TlNGMEVMSkZ6OUQ4M3MxQVF1ZXRs?=
 =?utf-8?B?OE1xcmQ2N0pLTWV2cDhER1NucjJSU2o3WVFsVkovSEZaSkQ0WFNCZjNFZE5V?=
 =?utf-8?B?VFFEQUE5MEpkRkVmREdKdUx4ekQrOEJRWG5xUlh6ZXA4YVFMQVZLcE54Rzly?=
 =?utf-8?B?c2xqaGJUcjc3NEUwZDU2NVZ6Z1F5aWdIV001WEhzRi9hVVY4bTNaRmhBZ3lG?=
 =?utf-8?B?VFM5UGdXd2lnRk16bWtvYjZCeHM1N3VlY2FRTnZBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c012bd-4b3e-4b0f-43cf-08dbaebe8a61
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 09:49:19.5485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDijb9GHB1dvfXwDx+Z8V6OeDtZrNE7ulKtyrBZF808Chflz+2a1xJ4OF+wGXPjH6+SbTRfn+jjgehMsAw/W2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6778
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=783 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060083
X-Proofpoint-GUID: QMd__LdVDUBdLpR5rU_iNoRswKLRitvL
X-Proofpoint-ORIG-GUID: QMd__LdVDUBdLpR5rU_iNoRswKLRitvL
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/6/23 04:23, Guilherme G. Piccoli wrote:
> On 05/09/2023 13:50, David Sterba wrote:
>> [...]
>> I'd like to pick this as a feature for 6.7, it's extending code we
>> already have for metadata_uuid so this is a low risk feature. The only
>> problem I see for now is the name, using the word 'single'.
>>
>> We have single as a block group profile name and a filesystem can exist
>> on a single device too, this is would be confusing when referring to it.
>> Single-dev can be a working name but for a final release we should
>> really try to pick something more unique. I don't have a suggestion for
>> now.
>>
>> The plan for now is that I'll add the patch to a topic branch and add it
>> to for-next so it could be tested but there might be some updates still
>> needed. Either as changes to this patch or as separate patches, that
>> depends.
>>
> 
> Hi David, thanks for your feedback! I agree with you that this name is a
> bit confusing, we can easily change that! How about virtual-fsid?
> I confess I'm not the best (by far!) to name stuff, so I'll be glad to
> follow a suggestion from anyone here heheh
> 

This feature might also be expanded to support multiple devices, so 
removing 'single' makes sense.

virtual-fsid is good.
or
random-fsid

Thanks, Anand

> I also agree we could have this merged in your -next tree, and once a
> new (good) name is proposed, I can re-submit with that and you'd replace
> the patch in your tree, if that makes sense to you. Of course an extra
> patch changing the name is also valid, if it's your preference.
> 
> Cheers,
> 
> 
> Guilherme

