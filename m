Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AD778DAF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbjH3SiK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241981AbjH3HL6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:11:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F95C95;
        Wed, 30 Aug 2023 00:11:55 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U77TkO006702;
        Wed, 30 Aug 2023 07:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=NGWf5TzylNl7zBExt+P/+6ezAk46Iod68cZoUXgioF8=;
 b=y3RL6lUvgLopfH82b9dc7YzA5rodMJzA4T9gJBqs/ORij8Hvt2GzktbFlCFCeK9xodHG
 us8HH4otC5BrTy0neb5YG1VUTzy3/soysmMm4Cu9jNHwvZQz26eMjvMi/2Rg49D3hu+s
 z+PNQn+y4tKXulhvPfKSwUaPTnjAejJ8hF1t7SKEuAHeG40YauuwQFjLorn0qHDGtTO7
 swh+38UrAgJFS4ILkrakAyG/GPU+trdk370oWLAkpRHPehzl28yuUNtTIkKAJpTHngFX
 5oYEeFprtxsnxfcTKV/3YQySSKkiNmvhjUCrwteSD+x4XsfgYllIx8pxsAm4Ir18pBFn Cw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9k66qu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 07:11:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37U6uHfl032865;
        Wed, 30 Aug 2023 07:11:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6dpnhse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 07:11:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaU9YhgOhqd14HtAHz8q6OGexdnEY6+ctDZQ66xZXQERkArE36DTN5xnpDn6Fct+UamuGQZt1ZthICsBuDrrMVd4aqXVNV37ceJ7c4v6McOSYBaU7YvHECRkfR/v7ASOquNEGRPpWV9CTXiL0H68f44drVeB4sSfSu78sM73IZauIyPj14tjbsvS8L3URKNvAN8E7eTsiKTgfUzyqwob4GlJopDTPRk/+o7oLWm88gpJ0SfmzEt+WDlCcZETp4KOscLHOotIFqctJx3BLDM8P9VEMCpFdmWVoqkDJppJUxRLq5j0qol7vst1j4j4zLl1Q6DVXt0x4gkLeHyYzVwFIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGWf5TzylNl7zBExt+P/+6ezAk46Iod68cZoUXgioF8=;
 b=mUKIy6xV8viMnF6kgwsI3mibmz8CwiQO1LS4L+hIcnzjPFdfQsY7gxln+HaVgfqS/hxLkyI70vzNHGEnLT19v3Fid2ooVM5iJWtX3xgeAVbItNCd0AGd8vQbzbWuSZXTjAVv9Q+n/9p3lfsPA17sYu2afBoJda0g3VA/FhASUkV6eRSGwh3slYes0l4QdoYSkk7H5b9ovSKESpIZwgPhnw0oed31ThSGIb0NnAIBlT353StcYo0GzmzLuci1Jcw3YBEbPmL3OLavZ3YP7s3bjMDHVCtNu/l/VgdpzEDIKDPRkQx+S2mmnhH2dwR47e6qK61x6jCQUOtZ8GF6Gnq4nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGWf5TzylNl7zBExt+P/+6ezAk46Iod68cZoUXgioF8=;
 b=nhFys+9L4qXl3YIJ4yKszuT9qSjZex6Nla8V3UwXRlqoGiatqMaJr+nEaqhdg7p2lu96dqg15xVWQdcFXS/3lhkvtBKnkkA6+7NCWZCTBdstoX+3v6vGEMZAnR5/rcYW/DndCekisn7I8v5RxLgoaafYFbD1p3t8AHx5yKFdKlA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BY5PR10MB4321.namprd10.prod.outlook.com (2603:10b6:a03:202::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 07:11:14 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 07:11:14 +0000
Message-ID: <ff5c53fa-e808-0dbe-6f08-bfaa945ced4c@oracle.com>
Date:   Wed, 30 Aug 2023 15:11:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/3] btrfs: Introduce the single-dev feature
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>, dsterba@suse.com,
        josef@toxicpanda.com
Cc:     clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, david@fromorbit.com, kreijack@libero.it,
        johns@valvesoftware.com, ludovico.denittis@collabora.com,
        quwenruo.btrfs@gmx.com, wqu@suse.com, vivek@collabora.com
References: <20230803154453.1488248-1-gpiccoli@igalia.com>
 <20230803154453.1488248-3-gpiccoli@igalia.com>
 <9bd1260f-fe69-45ba-1a37-f9e422809bff@igalia.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <9bd1260f-fe69-45ba-1a37-f9e422809bff@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:195::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BY5PR10MB4321:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a2aaec-3cb3-43ca-a617-08dba9284bbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y3x+YzctjnZuc3iaeB1Xx8lRahSGtsg9EJv4aC/9tBg3xEqinkA7NNWQ1nqcMAiZvyKgUFHFNszF+X1hDpHKVWZLsd0Kp28qSEuin3awWxvjDEBhaUWk4MZyn7q53l4c+MLQ9pnEBceWihpp+P2EjR9VDg5H4DN+jmxS0Pklw/qc/PiP0+kmzPWokDuat/afv02lHhNPVpgNNnrLiQ6RtFQGR1DGM0c6J5jVcJSDsVvvf7xIVy4t+muaIkug9vzhrowjqRQ0FzDXy9//Bj0PGfbB7OLoRZ7aBmT4xE1h7maCpo3dVRJSxP/UqO0XRWGViBphomDevdna7HNWiHHeVIu+Id91IdDJvoPvkSOpcchLJXf4bFtWj2V5NeFV8TALZhw6eG/+YKB6+6VKREyoYDdBBOZMPX3fPxjriSRIoHYHmUBkTa6OCQ+VketbiYExqB1SHFNg321wwb0/4myV+itqHghTEP4vWt3bJ+adRs+rckXMwvTfGTzyTxlgsv1G6CJVeYJWB+7eM2nqIrCAIt9NommlKGtNm4VSF4T4mHIOBp+pvnuxtx+BRXbZVQvFf7gGnUiUD9ZNg0K0qlhg5n4FMRfOwcJUxFvB8lxoTEYS1rG+GOUHPS9wXHxQ/IlFjyfdKZiQ68XgUM270dTOjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199024)(186009)(1800799009)(31686004)(6666004)(6512007)(6486002)(4326008)(6506007)(31696002)(86362001)(36756003)(38100700002)(478600001)(26005)(53546011)(2906002)(83380400001)(66556008)(8676002)(5660300002)(8936002)(66476007)(316002)(44832011)(66946007)(2616005)(7416002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE11dG9MV2hOQTJpdFBhcFJIemxyODBXUERKNkdwWWQ5MURDOGNEVk1vK0ZY?=
 =?utf-8?B?SWFMc2VQZGVpS3hFV0RMc2FoSUYvdWtwTXVKOHNybjJHQ3ZJNWd3WkJTMFNo?=
 =?utf-8?B?UG1BY2FQc2pKZkJMRkRoV2tsbVhXbEVaTWxSNzd2cU1QYlVRQXJFd0hjMkFR?=
 =?utf-8?B?NzR1OUZsL2FaamQvZHhOM3hrN2FhVk9IMjJBV1A2S0ZkbS9oNSs2YzRqdVZ6?=
 =?utf-8?B?T0pmUlFPZ21LQytZb0J1T09KeVp1SS9uYytFTFNlRG9IVmk5b2g2MnFPaDdz?=
 =?utf-8?B?b2RkbUYyWEFtU1M5TVZ5RFVvc1pRUVRleXBqMklJNytkaEVNQVc0b0VjZng3?=
 =?utf-8?B?M3BSblVDKzQ5SXRHSTNqblVod2RlYTBSUjJwbjFqSlBSN1pWeHdSUm1SaFRw?=
 =?utf-8?B?NG0rQWFJT1dmRWdjL2NWUkNGK2pZOW1XeGgwcjZWNGo5dm5pZzBybU5PY2RZ?=
 =?utf-8?B?WkdEZjcxdjl4YzVIcHVVNGprTHlMblp4bXBkNk9aWmp2cHRDakhqaVBHaFEv?=
 =?utf-8?B?S3VYRmtpYlJab3hRY0FUNnJRdnl4WjYvMUxPRExlbk5lYjRpaXZ5MmE1a2kv?=
 =?utf-8?B?ZFMvL2pWV2QzcVk5aU5tWkJQUUM0Q3RMWHYzN01JcWhxVGw0NjMyS3Vvd0Ew?=
 =?utf-8?B?ZXAzL1ZFZ2cvL09Xa0FFSk9QTnFjNVZ4YitMSDhMSWVZR09ZUW1qSHkyZHh5?=
 =?utf-8?B?bDVjZGowU0FsMFBoOWtqR09JNDJuS1lzU21lUHlOR1ZmTUhuV1NicUJ0SS9C?=
 =?utf-8?B?T0IvTWRiem9zaXpDNFhKZUFHTjE2MDZFR0lyNDhWTEpJMndCb0FiYkx6RVVw?=
 =?utf-8?B?ZllMLzBuRk1ia1UwYXJWQ0tRUFNzblRROU16SjU5QVVlTXBzSS9mQjFQOXJU?=
 =?utf-8?B?ZG5vVXRjYjBmUWlRZGM1RUJUM3VSeVJxaVhyREZEQ1hvL0l1b0xzUUo0ZUlQ?=
 =?utf-8?B?SDBGNDhjVVFzWCtob08vZXlweWpRRFFmN1pmN213Z0xwN0E4ZllSdzkya2xD?=
 =?utf-8?B?REYvS0RWaDBCZkR2eDB3NHJVWjhFV0wyakhwWUVJbXYyQUJyOG5OUXFmc0V1?=
 =?utf-8?B?MkVDQmVHN055ZHd2cUpFTVQ1c0NMWXJtVEE3QW9zQW92T1JhNlErZzB4emFo?=
 =?utf-8?B?eEdDQ3pGTlE5RjI0czcxZG5sR3g0MWl4bjc5Y3Y5RDFPSTVTVmYwTFl0Unpk?=
 =?utf-8?B?MFZhQWE2dm5vLzBpWVpZNFJqU0hSL3JKcGhqeHljelVMaWl1VnNZYmNBWjdT?=
 =?utf-8?B?a0F2bmtwVjhGK3VJRkI5aitFK1VDVU10LzNtcnlMcW1zVEtITk1pV1B0bzBs?=
 =?utf-8?B?RXdGWFAwaG9mWncvalZ5NUh1bFhvMXFoRHhTRi9hbXI0NDl4T1hlREhiR0NK?=
 =?utf-8?B?V0kycXZNekZGdmZ5REsweFlmellUMXMzUXR0VnNLbHhlYWc0L2pMRm1ZR2la?=
 =?utf-8?B?aFR4cWJobnprOU5BOUJEL2JHY0dhemJoWXp3YllLem5zZEMrR28zTk4yUEZ2?=
 =?utf-8?B?cFJld3FZR21UbXhLaUYyMkhBSmFGN2ZKTFAzOXo1aEljcXZiWitzTW9kdDU2?=
 =?utf-8?B?eHNleHNIZ2g0bjdZckNITnR5WDRORUJCTXJQY0lPY3VTTVRnMncvd2RNbkg0?=
 =?utf-8?B?ejVJL0V6YVJseG1WT3djZk55Umd0OWdYV3hxbGlVN09NbThtT1lyVlNVUzJJ?=
 =?utf-8?B?ZmlyeDdEOU1yeVhkZnJkZ0Fmd1ozZEJrSUtyZlBDcUh3KzFkQ3dEZ2IrcWE5?=
 =?utf-8?B?bndQcVM1SWp1MmFMbU5jOEJZdEErYzlabnBqMGFjeWVHcFpKckNYZ0U4QkJT?=
 =?utf-8?B?bXEwZGY1dXlaYzFUNmh5cHVFSG54d2o0TGhIekRQT1FnZElUOVZUQklaam1H?=
 =?utf-8?B?QWhsTlRZdUdVaUMxQjRVamppeVRpTVZzaG5STzZibEZUeWRhVVhDYW5PSWNv?=
 =?utf-8?B?YmlDYjU4ekZzMGNtYjVCRFFmQWRuMmNKUzltcjlyU3ZIQm5RdVFHZDFhVGNT?=
 =?utf-8?B?cVRVUEc2ZkpnU0RNUi9DMXhkZGJOdy8zRHhPSXp0a2tnUjFLRjBwVmJuMVRZ?=
 =?utf-8?B?SHV0eEorNFlGZnliMEtwYWdRL1Y2bVFzTUE5N3BRdEVJSDI1QkEwM1J4TDFK?=
 =?utf-8?B?bkJJYW5ySFcrSkVaeXk1WlpDbjFVaTdWWWg3Q1FWanBBa2FsNDZuOTdSdjVK?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VlF0Z0ZxMmJveHN0bTJuMjBpMThZK0ZtbTBidFpQcVRDSU9nUnZRNHhTMEcy?=
 =?utf-8?B?OWdCYWpDcWsyeGpsbThkYzR3VmNhcndiUkIxTUxRL2dIQ0pjeWxva2xtS25W?=
 =?utf-8?B?SWdrQUdiVGRWVjJQOGNuZW1CQnFZUTUzWGp2aVdzTlJRelFOOUxTUHUyRUI4?=
 =?utf-8?B?dXhzQStmbTRLSzV2VWlMbVRMQ3ZraklKb0dNZ1d5Sml1QVoyeWRYTm1FZGxs?=
 =?utf-8?B?UUJaZ2tscE1Ec1BvUXlSMXhWeFJzRUpsSmorNzFscmd3eFIyaUJFQlBqRXQ4?=
 =?utf-8?B?N3JKUVdzWUNlRUlkbUNaSzN5NzVMSy9kVnp0cVJvdS9rRVptdjYzTFBVR29D?=
 =?utf-8?B?N3pWbG9FWHY2YllQTWlpNmFHUTFxSnlkcU5TaUdvTGovaWh3SlhlTm9Ld3Ry?=
 =?utf-8?B?d2VxTUh3VDJWSEhwajh0MG1Fbk5GNEg2a3p6THhOaFVBTU5zZEIvYXVjZVAv?=
 =?utf-8?B?OFpLRDNJd20wOU81aTRkcG1FcXh0M3NUWnpKM1RqL05udUVyaXloby9UdU01?=
 =?utf-8?B?bjB6S3VHeHQ1amVDQ1RORTN5djFCTjFlVzdkM2Nybkx1RHhOK3hLQnFlT05E?=
 =?utf-8?B?eHdIaHE0Rk5ZcjUwT2QyWEZaZVFZaEp1V2lodlJzdDE4RjByelduakRBM2t2?=
 =?utf-8?B?UTJseWxGaGdzcEF3clN4VVRydXlEZDg4b0ZHcExKL3lla0ZCY1E3SlBtaTZK?=
 =?utf-8?B?YkRKS0hNNndwektDZXZlRG1QbDMxdElUT1o0RVVObkJNNmhveWdsYm42MTh5?=
 =?utf-8?B?N0ZLbkt6YmZXVjI4SkluS2JLNWp2ZVFpckdHMUdFa05NZUZOVGJmN3NWK3dQ?=
 =?utf-8?B?azRNSTVDcWd2bWt3c2NuMFlwNStpMXlBTk9JLzBnVHZiVTEzZUQ4UnNsYS8v?=
 =?utf-8?B?bE1rYzlnNEJybUxRQUt2UWVTNDdQYWZTQVJNajRMN2E5Q2U4cmhTckNSZVRW?=
 =?utf-8?B?SEpVWGduYkI3Yk8rNlFyZHRleXErYVJYeExLMjgxZngvbjlwVW5XWkJrN29J?=
 =?utf-8?B?dUJVRVk2cG5XZmQ5SnVEc01Yckt1RlZEVXd2N0VrNllJTzlsbzdZVU1XNU1T?=
 =?utf-8?B?b2JsaU5qVTA2cCt6ZzdLV0FjUFkrSHRNU1V2ZHN3eHhxUTZOSW5IaHgyc3M5?=
 =?utf-8?B?bjVyeFdDUEoyMkdNY0VCR01mb0hkbVZIdzNKLy8wbHR0Z0Z3c2VoakM2SHJP?=
 =?utf-8?B?dlVrcmFYSEdobmw5ZlREY0Q0L3BGUllCb1c0cDV5dEY2VGtTNGZiMFBpZ1Fr?=
 =?utf-8?B?TDRIR092SUtpd05sbmFDY0dsMDNqNVJaS2xFc3lQcVk4dnhmZnB3OHp0TThH?=
 =?utf-8?B?M2lrbGpvUkM5blZQVTZqb0ROVzBoU3FjcE9SazVzTmtFWStXcmo5Yis0bGt2?=
 =?utf-8?B?MnJZYVRQR3pTMGpXMUhRS2h4ZldBTWVweUpRL25oUFFqamN2N0xUdi9PekRs?=
 =?utf-8?B?VHdJb0xkc0gyTzJlM3EzMCt3WG92Q1paT2tGSmpBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a2aaec-3cb3-43ca-a617-08dba9284bbf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 07:11:14.0858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6xwlYWSBrXb78r0TMXtotBJ6pBW7xRrKzR7Wpsx6wTLO1CZBO4k5BRfSPLTJCgzvbYQoc9HWGG/F8JrHBeC9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300065
X-Proofpoint-GUID: hm9vaNrwVEa4O_2IoK7fG4Y9ODQ41EZM
X-Proofpoint-ORIG-GUID: hm9vaNrwVEa4O_2IoK7fG4Y9ODQ41EZM
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 30/08/2023 04:28, Guilherme G. Piccoli wrote:
> On 03/08/2023 12:43, Guilherme G. Piccoli wrote:
>> [...]
>>   fs/btrfs/disk-io.c         | 19 +++++++-
>>   fs/btrfs/fs.h              |  3 +-
>>   fs/btrfs/ioctl.c           | 18 +++++++
>>   fs/btrfs/super.c           |  8 ++--
>>   fs/btrfs/volumes.c         | 97 ++++++++++++++++++++++++++++++--------
>>   fs/btrfs/volumes.h         |  3 +-
>>   include/uapi/linux/btrfs.h |  7 +++
>>   7 files changed, 127 insertions(+), 28 deletions(-)
>>
> 
> Hi folks, while working the xfstests for this case, I've noticed the
> single-dev feature is not exposed in sysfs! Should we make it available
> there?
>  > A quick change here made me see it there, but it sticks to value 0 ...
> maybe I'm not really aware of how the sysfs/features directory should
> work, hence I appreciate if you could enlighten me if makes sense to
> have this feature there (and if it's OK showing zero or should flip in
> case a device makes use of the feature, maybe?).
> 

Yeah, we need sysfs entries for the new feature and test cases that 
generally rely on it to determine whether to skip or run the test case.

The paths would be:
- /sys/fs/btrfs/features/..
- /sys/fs/btrfs/<uuid>/features/..

These paths emit only output 0. The presence of the sysfs file indicates 
that the feature is supported.

Thanks,
Anand


> Thanks in advance,
> 
> 
> Guilherme

