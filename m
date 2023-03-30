Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED906D0BD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 18:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjC3Qv6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 12:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjC3Qvf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:51:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B74EFA3;
        Thu, 30 Mar 2023 09:50:55 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32UEELoJ028972;
        Thu, 30 Mar 2023 16:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=jjEtS45aQgE/NkO0XroZ1lFCg4RYR0l53oFpRyAh82Q=;
 b=pZjKJ86J1qcoIHCua72/Kd99+C7a4g6H/bAtQz+xUJ/klPQYWSewdVobfpsvsNLOvnJv
 R3tjEERnLydQhp0MkBOelSravrBjWUQx9O/9DgSqwL4ZNe9LhQf0ZEt2uvwOh5MZgpoN
 /eYMOH7TzRWH2u08YG7lsN50yb89cT6nGuk2xES6op+e984Qsu18JyD5f34INyLXUy2J
 LImwMu6R0G5bGokGQMm93d8y/fWm6NSVLkRoHEzc8MoagJ5/wFWWHJLjQaIYeCPg94DD
 2HVAM90FviUN5rAnnEmzZDHOEF2a/JJ8tBGhHHY03Fo26OhPSkyWcPVQ773127vOdPz6 7g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pmpmpbav4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 16:50:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32UGY6Rd016542;
        Thu, 30 Mar 2023 16:50:19 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pmyvvms18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 16:50:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJQdllAYAa2NWqqKID6rjrEe6u/3v6e6sLiIX+7LIV6pUe3fbZxaQBnlnukguxqRPESQYFe0vtxvLLEF3ogQ5qbNAaPYhu4Oby/V044ONrCtKLii+VMFZfz9Zk8suSfKrLu3RtVdNTZLVyEBtOH/Gx86ml8rIp8CjT9HYFNGDe7qQ9Pnhox+IwLoz5w2tt0VqeVCtVLNX7aCiiSMFz/wlUurJquQBO/0GVtplC1NFZx67vWVK02bVdah6qUuG4BPBC5Z9lMwfUW0BLSu2PEUhgFBwS0HvmeyS1f1kiJwyRPDOtOF50+R8dp1EE3PpvCMUBAsqRfStT3kTnSD0eGmtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjEtS45aQgE/NkO0XroZ1lFCg4RYR0l53oFpRyAh82Q=;
 b=mVwheYXZ98oZvBxFXSgj9GEsiFRbPPoL3ONSqAvLYYlsefWbnUK+o2qsfqQBPVsRDrcVibTtby8kOuDI8hOD6r8m1DFtLJauLZvWguip920/Cnt499zL2ZIfH39UhliwnLYxoSAGXVoRUHXozR14aqX7/XRnUhZ/EOmrSwM2MlSUVQhfQQLovL+RjNf9YjjAOnq6KUv2x2sbjF9p2A6pNx+61lkWWBM21ioj86XtT3sBEBjE+15KUs3b87K6QGFZ8uXsoWdB7hWE/jA/DWd61NYtzWGeFnUDzcOWws15S1me1UEjcWFM/no5YOqQAqP7gQYA/+N221P1XmzDC39cBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjEtS45aQgE/NkO0XroZ1lFCg4RYR0l53oFpRyAh82Q=;
 b=j6jjRxJlHh+62naFxeBsyLq7g6i/Hk2JR24ZMFTQCSlBxDnkk2Bx8ti23jSldZXgeWtfXH0dGGmCsgx+27eFvkKT3gYftx+m9wEg2kPJQGY4AV0Mrf863tHr2JR0ph2X2tYFDVd6NZNTzTP5jhb16Ys6nPt0hME2k4EE01WHd3M=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by SJ2PR10MB7082.namprd10.prod.outlook.com (2603:10b6:a03:4ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 16:50:17 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::9bf3:e61e:d41e:c531]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::9bf3:e61e:d41e:c531%3]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 16:50:17 +0000
Message-ID: <8f08c42d-268a-b608-1ee2-dad74e26cb28@oracle.com>
Date:   Thu, 30 Mar 2023 11:50:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 10/19] jfs: logmgr: use __bio_add_page to add single
 page to bio
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <cover.1680172791.git.johannes.thumshirn@wdc.com>
 <820f11140138c2deb4a649014556aef27474c13b.1680172791.git.johannes.thumshirn@wdc.com>
Content-Language: en-US
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <820f11140138c2deb4a649014556aef27474c13b.1680172791.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0051.namprd18.prod.outlook.com
 (2603:10b6:610:55::31) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|SJ2PR10MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: 45542abf-9782-4d22-ed88-08db313ed6fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KLuZAEzoGmxhiaciYl/n62ypvSUqwjIkRmOL9TkWGNpnLMwk8e5iAQd6CogtgOC+RYe9wD4mEGpxktZRqs59WjU0CBUf1oJ8ppPPWQ/3UQxQstIY8h2U3NcEM0wpdIKyysoy0r441kNtbVAf5nHnRwEbKxVFIK934VoOtxWnbubSOs9qyfuNn9bXP7YBC/bTKB2bwZ2H/a+TWOAMWCBfW7ppb1DX0IVxunLnmzWh7dH4kqrHAC4jHha769oUB4mMh9vWbtrMBZaD0xLqQxQ56CZxga5aFk5Am45qojboWtTwT3CksAiDdeDHf6qT3iG5nOBb84HiSmvqLcK98V2162lyyDfHvOvHSVb737RHRIp79cRlojyc/xGjBZlh7gqx0mU0QFfueADgjoARAAcqC5gEBqDpWCduf505hhLfFUpQ0Br4GdR8xbxlaTzor2257LP9ay7NtDcSFhIYnhlU2EwA2MYNvwuDYDewtULbILXNanrcS3VTuQ3ivOW1TqCdvNc9dZbsJ4fYRPaQ77xS0lBZYNKaOebz5y0WOFtExd1CwpDpujV5rnhfTCiWGr9bcLuMFfjC5Tj4K4+eHLdfoJ8zGrg5tGN0zkhek3xk0Pi/oXL0icQCSx1pOwIUK64xMsjf+HXj0SDTZM4Yg7f2Ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199021)(44832011)(2906002)(8936002)(38100700002)(41300700001)(7416002)(5660300002)(86362001)(36756003)(31696002)(54906003)(6486002)(316002)(110136005)(478600001)(26005)(66946007)(66476007)(66556008)(6666004)(8676002)(4326008)(2616005)(31686004)(83380400001)(6512007)(6506007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmRqZ2ZQajJZRU5lM3hSdVlEWGt1MnhENko1Vms4WHNOWGN4UnRoZ3FnQ04x?=
 =?utf-8?B?ZVU0TFFFSHRKOTBIeFVJc2xheDVXa1B4N21zN3UxOE4wd2tCOTBweVgwMGs1?=
 =?utf-8?B?SnVUUTBRZ09GeXc0cmEwa3dlUUkraElsNDJGK043dVFIQ1pvRXJuckJ6Z2Zr?=
 =?utf-8?B?dmxhbHBQNUdLemVLeE5ETEd5cXd3WjBCTVFUWG5EaU9SMGczMkFLN25iUmg4?=
 =?utf-8?B?QmV6NmFXU1RWOVJwMWYzODQvYzRDTndKZmxjaFBvbTd2ZUFPNktabVlheEVa?=
 =?utf-8?B?VnpldGpManJwd3ZlQVhTZnI0ZVlndjJ1ZkdwSmRxRVRjVDdVMUphckE0aFpO?=
 =?utf-8?B?ODR6MVQ5TXJFQXN0MkpRdTMwOUkwVjk2NkMrK0NHRUl5RlpEMmQ1UmxZTGNN?=
 =?utf-8?B?RFNmTzJZcUpLem1sUy9FN0tpNGtxRUZDdy8zZkZyeFl0d0VnL3BmNHRtb3F1?=
 =?utf-8?B?ZTBtTFJiM2R6eW9nbTkyNUFZaUQyRU93T01waHRsUkNyd2RHTmxoZmsxSElz?=
 =?utf-8?B?Z2hFeVp1em1lUGc1RUFURXNuUFlwMXhZc1hhdnhvRTJCNXpTU29pLzFIci9K?=
 =?utf-8?B?VDhDdVp3RUxEOGFGOFQwcDRsYnU4K0dKRFdLekUxOWU0ZWFJTFdycUpRNFdL?=
 =?utf-8?B?MzY4U3JBajY1aEdJL1BvMS8rSHozV0hTZnFWZTdsU1FoczJBNkVwSk9iQlFr?=
 =?utf-8?B?TEw0cEViWVBIc0w1YWMvUmdxeWxUZ1BoRndBN2svNnNLcDh6OC9CMWE1T1hP?=
 =?utf-8?B?WVdJMXlsY1c5Q1FFZzE0OTdUbFVVWi81TWFnYm0yRm43UVFvcnB6VlFPRWsv?=
 =?utf-8?B?Y3NqdGFuTW1vL1FCWmNNaDZZdlFhOEtocTFYcFdVSnZtUnlmTzZrQWRzdDdH?=
 =?utf-8?B?aGw0TWNkQmV4dTFwQVRPS1czTzlzYzMxdG5YU2FHL1cxcWlIaStVVlVuNlRk?=
 =?utf-8?B?UkxnTFBRelRyblg2eUdLdVVRUXFkMW9UdVpVQ01YVkFRdGlnV3d0dTJvLys2?=
 =?utf-8?B?TE9DYkhtZ252T0EyTmxHdFVOblVtOHh4cWoyeG1xblRaZ2hOdjNSL3cvUTlo?=
 =?utf-8?B?cXdFYmtZUzA0RVRjSkJRaUpPbUpURTEra2Z3VVBlVWMwbXBnTzFXZFBOenBP?=
 =?utf-8?B?MXVWUCtjMmtpcEh1RnJYeU5vZFZNRTMyNUczQS9ndEZCek5vbDFhNTlCdlFN?=
 =?utf-8?B?aDk0emhCTFU4QkxFcWpWNjdrREE1QVI2SUh1eHp1VUFSVS91QmJqcEt2Vyta?=
 =?utf-8?B?MTY0bk9NSTNMTmdWeXNYQXl4dW9CQ1JENUFWV2pRV3JGZnVMTHV3WkhDUE5M?=
 =?utf-8?B?Njl0NVhGRkt2R2dOQVRyZUJhNkdoK1NQWHJIZWo1NDBWdHVHdUJETFQ0dlU0?=
 =?utf-8?B?Und1ZFE5WFF5UXFCQWRQQTEzMzhlNmltVTRyazF5alAyODZRd0QzNlovZ3c2?=
 =?utf-8?B?bDJzaUhQQ1U0ZHM3WjBmUStCdkZkMTNCV2Z6Nk03c1doUGFZTnd0RXFHeExM?=
 =?utf-8?B?VnN0WHMzMExEb0tHakwzZGFMMVkvbUtkL3lPazN0aEpXL0VLekZpbTVtRFB4?=
 =?utf-8?B?ZmlUdHJaY1RKR3VFa04wdVpwRk0rclMyVnpWZWpmZitkaTZHMlJCZ1hCWVhW?=
 =?utf-8?B?N05WbmFnNk9UNkhuS0NPUUk3T1dtVCtkR0pUWHQvQXFrQUtnTlYybjI4Z2Mr?=
 =?utf-8?B?djVJVkRpNGs0cDN3Zmh0N0NGL2hHcDZDZDR3S0N6RjVPdmptdkZzRnZ1ZnQ4?=
 =?utf-8?B?ZHVSaFhqKzB4N2dtL2hVWlhFWHcrck5tYVFaWnFHQlNndTYyeXV0RjZLT05C?=
 =?utf-8?B?Vm02RnZLMEpueTJOS2ttYnJXZTFlcVgxMTBVV2V3WjkrQkpIMy8yeGtndERF?=
 =?utf-8?B?NG9Xd1V1UTNycVduSk5wcXlCMUxyckhzalpjYVA4WTBrRVFUYWJRek1FdDNu?=
 =?utf-8?B?a0FaeEltSUVGSU9xSXNQZDQ4SjZXUDQ3endOTDFDK21BWmhjeEdaazh1ZjdB?=
 =?utf-8?B?aTU2ZzlkM0JCaXFsMTZ5Q1FsZGoybU5SQUp1b1dHakVqRnlzQmxpYUZtL0kr?=
 =?utf-8?B?U0JHUG00NWpOTkhySnZDWE5Id2c1SmpiL09ZeDRZT1pvQldOK1dvbVlnY1p2?=
 =?utf-8?B?TjRONWlTVFZGRXBvWXYybXRLNXpsdVIvL3ZZcU5ocGtDWmw1WjIxNnZTYXdl?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cXdUR2lVMjI1OFR3UHJTMjdyTFdKQVlTL0hjdHh2bllDSGk4TFNZVVYvRlNN?=
 =?utf-8?B?eGNlL0ZhQVJTNGtiemNEYjZsWEg2KzF3MTBoREFhN3VjYVdYNFc1Z2tGTUZ0?=
 =?utf-8?B?MlI5b3BPbndHQ2dweWpsbng5OERMbzRJdFM0eWZNdmRaT2x1OWMvR1pFblBJ?=
 =?utf-8?B?OXE4Q3d0RUNnVms5TGV0Y2R6ckhlbXVrSVJIV3dvdmxMQjQwTnNwbWl3QnQx?=
 =?utf-8?B?VXNTVWRhODNqRUZsZzhZMWdBYndYUXNTckhhMkx3d0hhUU56bUZ1RDlYZjhk?=
 =?utf-8?B?b21sTzBNdWdPZmNWYjd4dWpQcHRTQnNPeGNrOTQrbHMwTGQ3c2dpRGVZd3kr?=
 =?utf-8?B?OU1Yc3ozNVZ4SFdqZnFOVDNaRVlSWkJlbE5YeFB0WTVOZGlWWW11MUhwVjVl?=
 =?utf-8?B?eHpYWkRSbk9ScHRETzhrR21OaWJDd1JubjNtRmNnTU1LNVhQb2ZsMDdzYkpn?=
 =?utf-8?B?MWcrRlVtOXlIOHl0S3I1ZWxBNlFGWjNuQnpZZlF1TFRxcnRRL0JxaU5QRzNO?=
 =?utf-8?B?WjRUakxBamdKZ1Izc005a1pRTnNnT3FCcExVOTFJOU4vSEU1UGZhUU9POXZJ?=
 =?utf-8?B?TERaZVdEZmszeUwvQzdaejBQTE9WL00vM3dmN29BMGlqYyt5eTBTMHIrc21h?=
 =?utf-8?B?NkdaYWYrZHNvS2hSeG01MzNzeUJLS21ZTlJmR2hHczFUTG5RSkFDYUo1SUhp?=
 =?utf-8?B?TG1rdDRHdWhRL0dPZEFWZzY0WFg2QUZMNWhvbFQ2dE1qWUJZK09YSFBXWnZS?=
 =?utf-8?B?S1NwVG1jYjE0a3h0TXIwZTJsakQvYjVBNkIyZzR2UXg5d0grcnFWMGJjQmFI?=
 =?utf-8?B?SmUzV2pXMFd2bWlvZkVQRGoxSWRkRkFNT0pGZUNWc2ZEUHUyTmI5Vk5keFp0?=
 =?utf-8?B?Z2d0OCsyTS9xNDVweU9xWUFmeU1ZRHdHQTZNbS9mZzNtVmZkOXRlQUszbGxT?=
 =?utf-8?B?NjVKU3dKR3NTL2xmaGduUERxQVJoNkpIbzd2WnBrMzdPamNHeEh6R0ZFdUZo?=
 =?utf-8?B?RDVNM3IrR3FnUGRmMVhMNFg0ZkJMU2kzR0Z2Q2U2WC9JWklubUJocGRYUlRj?=
 =?utf-8?B?OFJUcS9nQXBFQzhoV2d5LzlxMldPTlFPcjhNNUZKOXJXaEhTbGdIaDZNRk5s?=
 =?utf-8?B?V0pnWFZQL2Y1OXQ2T3RWN2xteVUrNFNUblBHMHR6dEZSWStWNHlqVnRWOU9j?=
 =?utf-8?B?U0g0YjVHczNJRTFIck9zR3owcXZBYWl5RCtKeXJ4dHUvU3RMUlpXSmhtZ2FT?=
 =?utf-8?B?MVBvLzJvNkF0dVNzM2NOK2JSYXIwY0l6ZkpLbThRck82TXV5Q3l2YmVTaEs3?=
 =?utf-8?B?U0V3dEZPdHVJVkg1VDBROC81amNWdVlPWHhvMmpnY1RCYnRybnBlMHBTcEZK?=
 =?utf-8?B?NFkzSkozRFptbWs4WlZXWE5ib2xHUGJzaXdTdjZjZGtFWWZzbk5rZFhjTnhW?=
 =?utf-8?B?NTRvcTlMblRzWUV0cWwyWFByNGhMUjRuWTZVdjRmaWxSbUcyRHQzb2dHenZk?=
 =?utf-8?Q?0Yed2KYhkzFZVfMW6dIptBrSXQi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45542abf-9782-4d22-ed88-08db313ed6fa
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 16:50:17.0229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mA+BGDOjvIb3Y9V6unZIyg8nzJWQvLd45EfuBCfW4162phUfNQxz+Y4TOgDd3fPp5fsAOzCiTV0cHol8sdMRfnU5rcyHLrZE8cQDUVl8fDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7082
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_10,2023-03-30_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303300133
X-Proofpoint-GUID: 0ZUYaGANpVlW8g4lDHks9yPCbowaWVnO
X-Proofpoint-ORIG-GUID: 0ZUYaGANpVlW8g4lDHks9yPCbowaWVnO
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/30/23 5:43AM, Johannes Thumshirn wrote:
> The JFS IO code uses bio_add_page() to add a page to a newly created bio.
> bio_add_page() can fail, but the return value is never checked.
> 
> Use __bio_add_page() as adding a single page to a newly created bio is
> guaranteed to succeed.
> 
> This brings us a step closer to marking bio_add_page() as __must_check.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>

> ---
>   fs/jfs/jfs_logmgr.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
> index 695415cbfe98..15c645827dec 100644
> --- a/fs/jfs/jfs_logmgr.c
> +++ b/fs/jfs/jfs_logmgr.c
> @@ -1974,7 +1974,7 @@ static int lbmRead(struct jfs_log * log, int pn, struct lbuf ** bpp)
>   
>   	bio = bio_alloc(log->bdev, 1, REQ_OP_READ, GFP_NOFS);
>   	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
> -	bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
> +	__bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
>   	BUG_ON(bio->bi_iter.bi_size != LOGPSIZE);
>   
>   	bio->bi_end_io = lbmIODone;
> @@ -2115,7 +2115,7 @@ static void lbmStartIO(struct lbuf * bp)
>   
>   	bio = bio_alloc(log->bdev, 1, REQ_OP_WRITE | REQ_SYNC, GFP_NOFS);
>   	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
> -	bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
> +	__bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
>   	BUG_ON(bio->bi_iter.bi_size != LOGPSIZE);
>   
>   	bio->bi_end_io = lbmIODone;
