Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FAF73926A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 00:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjFUWUo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 18:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjFUWUm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:20:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43D619AF;
        Wed, 21 Jun 2023 15:20:40 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LKEM8x030931;
        Wed, 21 Jun 2023 22:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=/H4TGs4ZqPPof+QYjqaNaKDpKu4rvn2eSS6Q0Y6/v8Y=;
 b=vjeaa4BAyZEGrg4ZErTxxCnXaFBXebKc7p0+Hkhza9w5dYHmKLQvCr/T8FvN3pmBT5BD
 W13nlVw5v+NqqKsBFwhogDvCAAfFjLcJAise0EkuiYcMbPWht2yeOWwJ2NdsGPTSwzUR
 dVJbDt8oX+7ePWTMNAMxcucPfgbSTEBVGWTt6bdfL6+PXGHfzeEZk78cT/1M4LhlPqET
 aV1t1HLJJQS2/LU7QOnZVdazdNKLm8OIuO52CLl93wmEsrhSIrU456DesLu4Ov7U1Esn
 Xdz7w8SoDCGFEPQnHR/nBzRQ2Tl+jreMxFMHbcTDxqETtgKgde9Gb7HuxIDCzaOXqX+J zw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93e1gjn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 22:20:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35LK6DFB032868;
        Wed, 21 Jun 2023 22:20:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9397mnhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 22:20:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqFqh3Ua1Uf+rzMTe2TRAiFRk38ae9UV+aKNbr2iZ996j4ut5o0eClslumT/c53k1SiK5dlCep9Plt3dJ4XehMoO33C9hWg/IFELmB/9VrUMZmcrjLNGfeyEt5JLm1lfYkTUK4d84WKqWuGh6fpDu3Aw8kHK5o4AiPcix81jXkkpQ93gbf6Sk+rLgKY+PDYxQMFtYLxJoPuGboIZk3qIyQIuMsLk302pUvsLn+YyJqpKf09vKby8RPPT3XHZFIKoy17j2bTjtGt5ae0Rhr6nm6zm/DenePUrm7697BwNE/O/0P9VNqk9cdwaHfacGNurksgD/SZhbJZhyVv2vrvdxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/H4TGs4ZqPPof+QYjqaNaKDpKu4rvn2eSS6Q0Y6/v8Y=;
 b=RhZS89P6/gAKpV0bY+S/gtgJWPKZwP55MuuZxQFO0DjFFFpIEuCqvTURLTCVahwPb9lXmLwogIooLOKu7JUrw0eRYLTgmzDF1KhfP762pS8oDt8cmxGChUL7hULiczppLdwT7NBCCfVegAIUjr6v4v5Be2otEY1ASYpkHpAfhQ4z9PqXYo5sIaQcwVRwWTe8qmOfg/kPhxpzFovq7HMK3gwFD0up+cDPI92Wzg33Bf9PBjDuKb1FTLkpnao9MExT3fJkLVLY0E5nIwsqA4kmhqksFVl6Qvbhi3QKMJpjgzRT94II8tzh+TB72s+kvF2vxHaBO1Tlhx4DQ0Y1ho+ORQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/H4TGs4ZqPPof+QYjqaNaKDpKu4rvn2eSS6Q0Y6/v8Y=;
 b=hxytFcy7YegF6SqPLs/kD5sNuLKx80gPv9fuskkQ325eb2Tx4dQxHWnWdA6IZ3bL4HBEcIdOn65OvmRK62Tn6Cuhg2WqO0juoxNuV+tVEuQKpjxI4I92spmH4TXbI8ZAJcJiIGpciY2Ew5ruFjt7MDRi1BtwcuhYVo17d6kiegE=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CO1PR10MB4594.namprd10.prod.outlook.com (2603:10b6:303:9a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 22:20:02 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6521.024; Wed, 21 Jun 2023
 22:20:02 +0000
Message-ID: <8a1fc1b1-db68-83f2-3718-e795430e5837@oracle.com>
Date:   Wed, 21 Jun 2023 15:19:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] hugetlb: revert use of page_cache_next_miss()
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ackerley Tng <ackerleytng@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230621212403.174710-1-mike.kravetz@oracle.com>
 <20230621212403.174710-2-mike.kravetz@oracle.com>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20230621212403.174710-2-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0288.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::23) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CO1PR10MB4594:EE_
X-MS-Office365-Filtering-Correlation-Id: fdee1066-86f7-4f66-ff45-08db72a5a82c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mFBMfS8z+8k21f/gC5C2mTLHgW95uMa4vrxYT2Vb5rYCEwa77hV70KPSrEynCwNjneydZKB+hVGF0CFEwj7JVwlsfXCI3GX3kK1WmLAAVIryz323uEWy26RdvlKSnwJzbbDkFSszZSt4WZwdx61Xx60lcQfTYp6l4S01eq99ACu/7bvbNergRnznm25cFwmkNEVZodUrRWbBkF/00Iv9O6yVtgn4Yi1NuGotDWWqhuyrn+aY3RR4wTY8MetUs5/wGnDSL7dzF8qjMgT2C/vd1nMv5exjjGIFWWh3E9JfvD6hHhFwsK/TF/+BppVn11Ht9Z45NgxkvKN5JYsG2O5gQ9dFzn4t22QeUdJtB/x3uY9sKYcNE3Uv9vD04INRPBVFDhcKHgspuoH8r6CHL6XRNvHfrViwEy+OvdBMF9+VwXp9OJkbbwn/Qq0TYH52t5j/Ltbhg5JlU25GNr5gZ9WvSKBVLmx0oCe3Ef0ofnAeLl2FkLqKfJZwe7nWBB53g1Jv904+tI09us/HBlVvjkOnnaNGQT4QTZjVWA6yCanXfQ5J6Pl3xQSd9qgPM4EK5veamEN/cL9a9A38NM0g8KJdHoeHwSghEIDjDxruzY8PEwZi0fd5ksNolE2QrnRuxo/GZA8ERwgoZ11XQNgTpWt8HuYijzRJhdxtNOuTsmsJYGI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199021)(31686004)(36756003)(66476007)(5660300002)(7416002)(44832011)(86362001)(8936002)(8676002)(41300700001)(66556008)(31696002)(316002)(38100700002)(66946007)(4326008)(6486002)(966005)(2906002)(6512007)(186003)(6506007)(53546011)(2616005)(54906003)(83380400001)(478600001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXlxNXBHbWtpZ0E3aHhnbEdRMExZcS9JSXhBT3ArT3A4SGpQaS9kRTA5elJJ?=
 =?utf-8?B?dkxvR1pMdS9RZWhpSitpc3kwWG4rSmdoRStJS1NQcEVSTHVZT1JpbWZCRS8w?=
 =?utf-8?B?aEM2U0FPbnExS0NqSXNyWElkdzA2aElPd2tONW9XSjE2RnhxQmdOK1BkY1RR?=
 =?utf-8?B?cll1eDZPVDlpVW43cHF5Y0dDbmVQaVV1c3duMURnRGtULy80VVZnWnRLU3lv?=
 =?utf-8?B?OXVkNjZZTTBoQmovaVIxSlk1ZEo2Z3F4dnpFV1pzdzZpSFk2M2Zsdy9wSi9G?=
 =?utf-8?B?MlQvUC9JeC9oKzdLaXpFWW9lN1B6TWFORjFtWGtaMEx4K2Z2aWk1NzF4U3Nz?=
 =?utf-8?B?VDNad2cvUjM1SXdDWVY4WHJ3Y1RXTDliZ2hzdENiS0NROFFKVmpuVWdhU0RV?=
 =?utf-8?B?Q1VyMjAwSGpCSHlSZDVDTURLeHpld1dic1JEN2ZGRXJXZkI4ZGZFSWZNZUpR?=
 =?utf-8?B?K3BVWVVwZXZ5R3B4Q3NzZTR2amVCYmE5cDh0Q3M0YWY2RDFYdzJuYy9SdVpa?=
 =?utf-8?B?SmlLa1dpODQrZjAvckFiN2g2ckprNHV4MXlzWkFDYzV3VURRYmVPZDlrQy8r?=
 =?utf-8?B?NEdxaSs0cFdjL3ppOG5oMmxHZ3c4bjNlTWl0VGtsUXFzTmtMR3dYZDV0bFgy?=
 =?utf-8?B?RVV4Uys5R0N2bWhpWUVyVEp0b0J3bmVVRDg2ZVhMSVg5U2xJeGRqMWQyNjZl?=
 =?utf-8?B?YWVXQ2hyOGxtTjNIUmdGWlRQKzlqNjEweUo3MzZwaVpoRkl0L09kK0NoZlcy?=
 =?utf-8?B?OXZvM1puWGwrRXcwU201T0JURVJ5b0QzWTk4MjRhTTNxcGxpT05SLzFMcVly?=
 =?utf-8?B?WVlkNkcwRHM1THpzRWFKbXVDbjFVVEU2UzZIa1Z6RHdGQ1oraEtyRjU5anBN?=
 =?utf-8?B?NTRySER1czJEeVdlb3ZlVVZuMjVydU1sY1lFZGVWY2hvc1BSaUE3UWh6NEg1?=
 =?utf-8?B?MlREZXVZWkZPNTk3dUVYUFBXaHZLa28xdmZkVmJYeVZuZWE0MnhNQ0xyTU1w?=
 =?utf-8?B?UkZydnQvRklZVzY2UmQ0WlRDYWNWK2FiL2ZCU1dGQXpYUXpWcFI3Z2swUFhG?=
 =?utf-8?B?OEZHZmNoQ0Q5SS9IZ1E2WVl4K3JYQkdxRVpmTDY3SW1oR3NKQm5OdmYrWnZw?=
 =?utf-8?B?MWRjdXJZd1BtNXU5K2FLVS81a0JFY0ZhT2NqUHg4cGpkNWxFY21ORGZLaHc3?=
 =?utf-8?B?MHdZcTE4L3k5RlNHMlM4TmVJbjFyVmpsQTRHVU9mTUxvUEJzOVUyVjBjS1Vh?=
 =?utf-8?B?RzlDKy9XS2hoeTV4UnkvQU1XZ2wydXdMQnk0TFdjT1d3K3VqVUJHRld4cytW?=
 =?utf-8?B?NytvZGk5bUtUSFZObHdrbUVldlBMWHZTRW05OE9DT2krV0JoZENuMXVmVkFo?=
 =?utf-8?B?bzBENnZqZEluRlQxNGxhWURxUTlRQ0JNVTFjU084OVZ5SDVxeEFraXpIeGZO?=
 =?utf-8?B?djB3c24xc0NhQUpxbkFXRTIwcmVaOVBHT2NFNCt0dEgrWTd4TUhnZ3lUNmI2?=
 =?utf-8?B?VjdBWkVyQ1NFT251UVZSYUNHQklZd3FaMmd3Y29OTm5nUEdGMHpmT0xjZ2ds?=
 =?utf-8?B?TFlpT29GS1duUngyQ1JTWi9sSjNyL25nend4eVlBTWZmT0VuSElQSHNoZmp2?=
 =?utf-8?B?UkE0aElwK1pTY3hzOXVKWW1UN2ErL3Y3enFTTVpCKzFsVXN6UENSSm5DUi9m?=
 =?utf-8?B?cGJ5bUVxNDN1Q0x4cnRxeUVrV3daOWlEanBVbzkvaWlRQUhYOHlDVC96elRD?=
 =?utf-8?B?ZlNwTVFkbVBxb3JMczQ1OVhOWnBGd285RG16WlRMQW9YQzBndzRjOHIyY09O?=
 =?utf-8?B?czRrVXgwSGxZaUlWTktFODJ6QXFWdnNmaSsySy9UamdNRjRpUnZFSDZ6Mmt1?=
 =?utf-8?B?YVhZRVVsVFVzYXpTK0NsVGROa0M3NWc0ZmxUbTBDVEtyRWVid2FQNHYxYXMw?=
 =?utf-8?B?cjVlaDNwRUpOWjY1YldoYWNOVHFFK0poUVdwNktBeEsxekl1cTd6U0xtT3do?=
 =?utf-8?B?dTVJMjQwdmdFS2tYNWwxdXppMzdSSkJQUndpNEVDbnV5c3RtTUpJd2M4enFx?=
 =?utf-8?B?cEhrRnBKS0wzYnZUaWhQZnI4RGNVTmRSWS9ybHJ0cnJFeEtUcGtsa3lIS0F5?=
 =?utf-8?B?RHg2U2FPUUFaL2R2STBaMTF0R2daTXp6T0ZhWTlPR1ZWSHFnVGdsYXppRnR0?=
 =?utf-8?Q?ydBX3xN7DjSsPTHtRdxtYOA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?KzF3NzBjczAyUEhMMnpuVXVjZFExZWdrUGdLZU1EZVd6Z0dNMzNlRk91d05z?=
 =?utf-8?B?S0JhcmNuZ2piV3NQekxEaGE3QU00a2lLZUNCSjBONHV1akVFZzAza3haeFBy?=
 =?utf-8?B?Wit6eVU2UEtzZjR4WHVpMXdpYVZHbU1paEk2V21FeGRxQ2gvenNneTREczhC?=
 =?utf-8?B?RnF0TklDWnlhMHVNNndnUmNGR3ZickVjOHpQS1JUeTNRU0NkSkdmcjdDZXdY?=
 =?utf-8?B?dHdIVi9LdEsrTk5LeS9rSmVmL3k4WHVxZWdQeGU4QlY4Nmk2cUdnbVVWczFB?=
 =?utf-8?B?RlJlSjEyWUhlcU1jTlFUNmNQL252YTl6aEJpTHJHM2NDN1NWNG94azNRc01I?=
 =?utf-8?B?eUozTnltM3BYbzhoQ3Ewc2pSSXdyOEhhdjdPSG5UaDR2REhySEtPbmo4WUZY?=
 =?utf-8?B?TE00Z0NGZGV1Qm8vbzcwaW1YblpUN3pKNGtxMEFtZFZITU5sL0IxajZ0YmFX?=
 =?utf-8?B?eWVKUVNOeC9GZ2JsU0hOR2ZEblg3dENIc2E5NXlpREpWeXlLUWxoYU91Vm94?=
 =?utf-8?B?RjRZc25iZ2hyOFRmVk1QUmZUbnMzbUxqc0NEbWh1bldncWloT0dYSWFBMTdv?=
 =?utf-8?B?QVdSR3RHamVPU2Q4TnNzUHlZZlE4dGNyWTg0U2VCTHBMbmw4WFRpQ2FBYkdG?=
 =?utf-8?B?ckthSEprSWoyL1Vvbm5LOHJlWlFGMTRiU05Tenl5dk0zNTJhekVCd05velI1?=
 =?utf-8?B?YXE1UFRoSmdyQWwzeGFod2NFR0VnYVB5QjA5MlVXSUFFWndqZjNSNnl2Vnoz?=
 =?utf-8?B?M3BxaUhESkZWd1BFS2FzZGwxc0ptekJBaWNmQWovTVZ0akErRUwwcDE0bmpr?=
 =?utf-8?B?L0JXaGxEaDRrOVg3WFhtN1lHcWNvRWhwSFlQTXlsVXVZcE5hNTFrcHVsZlp6?=
 =?utf-8?B?aC9YazI2SytGV3pSZk5GQ1dCL0pOSTRMaTZtN1E1Q2VFOUJsajlhZkJvdTFm?=
 =?utf-8?B?Y3Y1aXFleEFqbTJGRnlpQ29qbmhQMURGTSs2Yms1dlVDSDNxMmVwUkhLVS9j?=
 =?utf-8?B?bDVQRVMxY1RoRE9FOTRvcjFKZWYzN29Ubzh2TjZrMEY1YjRoVVlVK1pPM2tW?=
 =?utf-8?B?Yyt0dkdRYU9XdUd5cjhpdVFUREJXUWFSZTdVWlluL3dUWXB2MXpsMlBPWmY0?=
 =?utf-8?B?Q3hldklNWlVjWUZUbXJpL242YnIwUXVaMHU5c3ArQ1Z4U2dSalozbE9Melk3?=
 =?utf-8?B?L3ZvOWJ0SVhGSWwxSWFPWmt3QnEwdzdYaFhxQWY3RnhvbXE1M3RhMUtKTUVq?=
 =?utf-8?B?emo3TXVkeEZtYmErV01nSXIzdnRub1ZKcDJvS0d0UWMxNThudklVRzg5bUxG?=
 =?utf-8?Q?TANoiJxT4Cs2sqTLnWY+QgJBwERZmhi58O?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdee1066-86f7-4f66-ff45-08db72a5a82c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 22:20:02.1219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6w7yZCi2l+ZcA/R5/87rs/vbckaHrf0CYihATW+n64odQawMz496SCkkCmTfYOvsozTn/Ipa/USptx6eq88s9lUXEco6RSVAlNxUfwS6JIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4594
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_12,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210187
X-Proofpoint-GUID: vsaBelpNG66BrHUVHkj7wJrepLWJll84
X-Proofpoint-ORIG-GUID: vsaBelpNG66BrHUVHkj7wJrepLWJll84
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/21/23 2:24 PM, Mike Kravetz wrote:
> Ackerley Tng reported an issue with hugetlbfs fallocate as noted in the
> Closes tag.  The issue showed up after the conversion of hugetlb page
> cache lookup code to use page_cache_next_miss.  User visible effects are:
> - hugetlbfs fallocate incorrectly returns -EEXIST if pages are presnet
>    in the file.
> - hugetlb pages will not be included in core dumps if they need to be
>    brought in via GUP.
> - userfaultfd UFFDIO_COPY will not notice pages already present in the
>    cache.  It may try to allocate a new page and potentially return
>    ENOMEM as opposed to EEXIST.
> 
> Revert the use page_cache_next_miss() in hugetlb code.
> 
> IMPORTANT NOTE FOR STABLE BACKPORTS:
> This patch will apply cleanly to v6.3.  However, due to the change of
> filemap_get_folio() return values, it will not function correctly.  This
> patch must be modified for stable backports.

This patch I sent previously can be used for the 6.3 backport:

https://lore.kernel.org/lkml/b5bd2b39-7e1e-148f-7462-9565773f6d41@oracle.com/T/#me37b56ca89368dc8dda2a33d39f681337788d13c

> 
> Fixes: d0ce0e47b323 ("mm/hugetlb: convert hugetlb fault paths to use alloc_hugetlb_folio()")
> Reported-by: Ackerley Tng <ackerleytng@google.com>
> Closes: https://lore.kernel.org/linux-mm/cover.1683069252.git.ackerleytng@google.com
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   fs/hugetlbfs/inode.c |  8 +++-----
>   mm/hugetlb.c         | 11 +++++------
>   2 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 90361a922cec..7b17ccfa039d 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -821,7 +821,6 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>   		 */
>   		struct folio *folio;
>   		unsigned long addr;
> -		bool present;
>   
>   		cond_resched();
>   
> @@ -842,10 +841,9 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>   		mutex_lock(&hugetlb_fault_mutex_table[hash]);
>   
>   		/* See if already present in mapping to avoid alloc/free */
> -		rcu_read_lock();
> -		present = page_cache_next_miss(mapping, index, 1) != index;
> -		rcu_read_unlock();
> -		if (present) {
> +		folio = filemap_get_folio(mapping, index);
> +		if (!IS_ERR(folio)) {
> +			folio_put(folio);
>   			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>   			continue;
>   		}
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index d76574425da3..cb9077b96b43 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5728,13 +5728,12 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
>   {
>   	struct address_space *mapping = vma->vm_file->f_mapping;
>   	pgoff_t idx = vma_hugecache_offset(h, vma, address);
> -	bool present;
> -
> -	rcu_read_lock();
> -	present = page_cache_next_miss(mapping, idx, 1) != idx;
> -	rcu_read_unlock();
> +	struct folio *folio;
>   
> -	return present;
> +	folio = filemap_get_folio(mapping, idx);
> +	if (!IS_ERR(folio))
> +		folio_put(folio);
> +	return folio != NULL;
>   }
>   
>   int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,

Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
