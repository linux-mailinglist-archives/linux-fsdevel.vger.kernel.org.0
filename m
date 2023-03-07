Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5656AE658
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 17:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjCGQXS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 11:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjCGQXA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:23:00 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174B0984F0
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 08:21:59 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327Fg8dI032113;
        Tue, 7 Mar 2023 16:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ns6zsO5fHaTPI7ky3o4alzUb25um/KT+S6ycyGnv/68=;
 b=a0jtV2B4QHwJqVdpMpcjNJTlZLG78nT8eGPUnCAP7QViZm7oU1E1YEJ4qftBs5xZ7IOO
 BPz6vlymuYR5MqdnBIpwOTs/2rp+v4gGp4Ukn5rJpU95BuzAjrzQzNnDtDLIvlyWp2cV
 SrBuQUVw//gbeMxskT9SCBkDkOcYkqvWFSQiylsHwZ1CMLbsa7Thhof6GuBx0HQQ/URN
 Eu7ruVnvQXWIr0DCarlz9ai7ztj2h3upV/Zq4FXRo0CIHOTM71qZcwyrq4yYfhzYFzSL
 0ZxKV8UVaCWMIrhJxP+ufQ1j3vCc2X3VLxW63o5xn+ABT+2aPcdssdoG7nibenAaexno /g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p418xwy90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 16:21:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 327FjDxs016339;
        Tue, 7 Mar 2023 16:21:18 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p4turgpnm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 16:21:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AV0MMFsqI++Q0VpY1yg+GbjDotY4tZBTJ1/pM3jtYRfSZP1azHrUa2xwmByu4uA7tskeU/GXVbczhuNCVMeyfBLzmP7v/1/6Fu4nOaKrSnUVWmhSawZ+ALQTf/5ZQDkVANqKJCdivi++GSlU2D8uJIyrIWoHyTMpe+NWL03fzFQ5mowN1hcXxbMfXelROMHwFy2TnptGtfOdDpEZFJLwKu4s6Bt49hZsESYYapUZhjMdmkGT6DTNizFpeWKYyfEUiNEfvfE0tPtRySyQPjSWf15iD59+mccWWlOwNQNh7fe/aG5moyhsIiwSYFEYkIV887tDZ6kk3LwZzbljCdPJdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ns6zsO5fHaTPI7ky3o4alzUb25um/KT+S6ycyGnv/68=;
 b=TPiIeDfLcwua1lDAS2G56Vi+ojkndzfrI0yDYW5kt115a2Bs9zmzdz5+CF3Ra33RVfjy0LiwgeTUI/MdGBrBIQhAcI7r2WCjzY5RshzADkCYCpimG+iwe6Vgh7xTPfd4i8kTHN/FzGzcssq19QssSvLOgwlU2lhQOWod+ZSvCmiv7OzWu/7UaErfLcLSfBsSVUX5BQyfusj/0vir5c+QhtPxQVCrVtod/K3UUFTxQvRkjDkgRv/EzWmMZX6qv2J3qRS+tH9nfrEfvFn1HbqjorDNCVhcBPyFmtSCC7LjOJgbCRKcsMKpdD9pvxS/WRcY0oj0e46b30AfrhzMSS7crg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ns6zsO5fHaTPI7ky3o4alzUb25um/KT+S6ycyGnv/68=;
 b=iyjiqRwGchVNZo0Zpr3kgvY9tqwWvhS0HsvVJfzMrnfTkEPmTGsGde0YCwJ+q8lhKX5YbsUPXW0eWu/K29Ieymqr85ubsvUvbPn+KS9VBw1cZyttu/gfmGTh5d4QYtyxn2AVD2xgx40aOW6CfzksNG3x1lrvjOG9QKd+de3YB/M=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by PH0PR10MB4679.namprd10.prod.outlook.com (2603:10b6:510:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 16:21:14 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::1fea:2ad9:4e73:d2db]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::1fea:2ad9:4e73:d2db%9]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 16:21:14 +0000
Message-ID: <6782ec9e-ec0d-396b-0354-592554e74ae2@oracle.com>
Date:   Tue, 7 Mar 2023 10:21:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] mm,jfs: move write_one_page/folio_write_one to jfs
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230307143125.27778-1-hch@lst.de>
 <20230307143125.27778-4-hch@lst.de>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20230307143125.27778-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::7) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|PH0PR10MB4679:EE_
X-MS-Office365-Filtering-Correlation-Id: 08e38df3-b46e-4287-4b71-08db1f27f8be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bMNL0GiCqebJvpdCjJ1jfI7dksIGO6/1hNBRV8rgP8TjnPw4rrQpgbzwtPeCVeIAWIzvklrRzQ85d2vq6as1RdBWIxRjTQWO/HRRZzhAulhmstlnzFR5rsjYzDcHH1Y3KvNH9ALsrldhgpVXjFpDPDHWT0GuJPF1TJt6meHCD8xoaQjE6DS5VuvViQP7Uo7wg/Or8heZuNSqI/U3cfTkZ2zt8NR3VUf9fybONJYievweisnozHYczCiTc2Tqy6iGlJ1k0GRyJMLzcmDO9M6J2uA9Eor6gmAipMpgFwqYtdEZuR+6KWfOrXpbJUR0UQIzFXJctHV0HvHYG+P9qYlVW35tk/BpF0YY+r4/ru7U4PuhDk2anvtT0B/4PL2+dBZ4VaMwHBtOY/SHT+h28FiGqpQnXgLYkjc36uOOjhQb98+6ZKzOsJ4VNObNaAudXzqx+K6v3+uA9wyfNZe9JwAkesXkHVwLurlRlWiWZ+UrrEzMVUAvNpQ1Q++2hschRrI3/KxuioytYddBNC2koMPyUR4yGc9AECy95cXD+uzUYOhojt3SnWxV3DTKmEVbwFwhI3kRx8vT9LJ5r989P+QhhvXNnG9u4pQ9hWU2NAVF8qtxaFpDv79e8rWxUzz6nNVv/EuJL2irMb8AgiyxXiRdtvo4UK8OEs4lZU1wefIAQDvNPs1U1VrkPPKU+DfJqOkv3lYc1SPf6ASMqSRehJkOB+Dzj9x6r1POZV6xNCzm0QE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199018)(478600001)(5660300002)(86362001)(36756003)(31696002)(6512007)(186003)(26005)(6506007)(2906002)(2616005)(6486002)(44832011)(31686004)(66946007)(66476007)(66556008)(4326008)(8676002)(38100700002)(6666004)(83380400001)(8936002)(316002)(110136005)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THlpNi9WYVFKUjRXZ2thdjhuUTFkUlU0a3ExUEpleER3b2JvalI3Sm5scm1S?=
 =?utf-8?B?UkNXUnpLV2xCMmJ0ZDRRYnhBQlBhWElCZjBEaTlBQlFUTWJUUHp4VElOU0lE?=
 =?utf-8?B?bnhTU2VuVzNyb256ZUx1OG1PNi9YZmlMbTVCRXA3YTVIWWV3QU5aMTJPaUJn?=
 =?utf-8?B?ZlFhWjcySnI4d0tMMTIzZUorVU1zTEl1alJkR3R1d0V3M1RoU3E5Ujk0VDZ6?=
 =?utf-8?B?YXpReHhlVnlPWDlFVWUyWUNVNnRvWm43SVZDMDAyZnQzUW5DR0NVeTFJeEhT?=
 =?utf-8?B?RFlpRHFBUGoxaVA3ZlJsaStWYzg5Z2hWMGdhRzV1UnZGNzRnckdaVE13V1BM?=
 =?utf-8?B?bGtvVkZxMzNiWnUya0tvWE8ySkdGY0loamsyRm5jNmhYTWxaYy83K2N4L2xt?=
 =?utf-8?B?S3lFSnp6SWNXcCtsMy9ZMzRBSlV1VEV0K0tGR1FlbTBDYStLQlpPcnlrMXVK?=
 =?utf-8?B?MDRacHVrQ2tYS3RIVXh0d2ZPUHJFbyswVDZKSVdhclZCZkhETHRFd2Q1bVRO?=
 =?utf-8?B?eEc3RnpibmNSVEczaTVJbCtuTUxEeUdXUUJaNloxNEhmenhiYWhYWm5wQVZL?=
 =?utf-8?B?L0lYN0hPLzJlYU1VeUpFNXNLM0V3Z1JMYmdKNXI2K1FsU1hRczNXMzZrNEhI?=
 =?utf-8?B?dmQvNXBDMEpmelBlb3hVQURndVNaUDVseHZ1T1Q3V0Ztb1QwR0tXVzFxNlJP?=
 =?utf-8?B?NHpMTmgrcmYrL2d6eUg3cWpSYlpldWxPVUZDOWFtMFB3VmlZZkduYk5nbUR6?=
 =?utf-8?B?TlZUL2Q5MVZ2K2hvaGhwMmM0a0dkTm5NVGE3OE14d2FCbTMwdHd5NHBlaXkw?=
 =?utf-8?B?TXRFQ1dqaUV6NTRHdFMrMDZPNkwraVV2NTJYcGViMGJRZzVEbk1uTmQ5aFZB?=
 =?utf-8?B?bnlmRkR1T3JnbTZBRFljS1Zxa3hRWkdaOUxscFI3d1RzODBaYTAzWi9GcVho?=
 =?utf-8?B?Tk9pcEp6enFiVjdvVUZUejlGaVhPWE9tMmpXMk10dzRUYStGa3VhK0VnU3NP?=
 =?utf-8?B?WlNBUkR1NC9wbTI3R0ZyL1hJd3YvSjYwaWZZTGYwVkhPTmJHRy9mc0pQYVUz?=
 =?utf-8?B?R1gzL0g0YzBhMlB4U00wdjhWRlBRcWs3MmlvZURwV0Q1VHpUL3RCM2VxZkdV?=
 =?utf-8?B?MGxWQlRWUlVrL2JLc3Jtd01QNVkxUWNlU0xqYk9Za1ZaVXlxN0xTU29FYWJ4?=
 =?utf-8?B?d2NnUnZYck9uVWVVQ3ZNOXpwdFpNZExoRVg3R0RGY2FOQ3ZqZmY0Mis2ZSsz?=
 =?utf-8?B?ZGNNTllHM1NwVTJnRHNBM3IxVHpJMVBqVFVFaDJ2WkE1OUFIT20wZ0pJNTlk?=
 =?utf-8?B?M1ZtUzVPeVpiT2N2dUJHeDVEam5UMjlKMTQ3QTNNQXZCR0hrS2FjdWFZNWc2?=
 =?utf-8?B?KzRLZDU0dER6dW1CU0xETWYreE9EbHVLa2pITzUyWGlyMzd4ekJtOUNpQkZ3?=
 =?utf-8?B?QXZuSDhsd0piM3N3R2lQVEpxZmVOaTFWUmdPTzdKM3F2dk9hQkhaM042WE9x?=
 =?utf-8?B?bHZyTWUxemhRTEt4YlpOUU5ZTjRFZkZxUjJjWDc5amRROGdJdzE0VmlqQVBz?=
 =?utf-8?B?UDB4bE9lWjNZWTRCMFVKRUtvVkN1QUMxY3Bpd3JXZzBYNFRGSXpGWDAya3ly?=
 =?utf-8?B?aVVwb1dOeFgvSVlyQzRUN0pvYnhsNTlMWlVoeVlDVmdiclBCcEYyNTRncGVo?=
 =?utf-8?B?a1VnZS80YXdsdXhOQ2JxUlg2aG9ueitGcVJmbzdZU1BIRGZOVEhtdm5idEJw?=
 =?utf-8?B?NHZSWnhVVFNVb2R1bDlrd01XREpYSFRwMm1QRmFPYXA2QThXMi9mMUNsUDJ5?=
 =?utf-8?B?ajBVZkhXYzN0RXVhcitPenRYbUdvSEVGWVh4MTR4Y0pEdUcxL2Uwb3ByU3dD?=
 =?utf-8?B?emZVUzRmV2kxeGxjUG5XcFhtVER6eHZOWmhTcmkrNTlRak1ZNEhra3o3Tk5I?=
 =?utf-8?B?ZGxtRlBRK1VIMHZNZnJxOFpqalBOcjdMdEI3bnVDSnNHTk56S1pidWFOTThG?=
 =?utf-8?B?UWZDWmJXR3JZc29qVG14SlpKZmk0N2xxYnU2dEFheGwwa0dCY3ZDYkNObHRu?=
 =?utf-8?B?SjlUNFJBbUNPRk1VU2pJYmpuZlViTEZoQURTNnphakplc09UcWJLWFhxeTl5?=
 =?utf-8?B?TlBDVEI1WG50aFBDc2lPTkpTTzFNTHQ2MUZtMGppanZ6TXJsWmx2QndhakFH?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dk5tNTVaZHptQk9GcnhTcHIrTldYcG96c0hPMFNEQ2NuZ1NlckN5ZWFaSnB0?=
 =?utf-8?B?aTdDM0N3YWRTaEQvQXc1SzFBTUt5TlZsRmdidU8wMXkxZ3ZUVENVUzR1bzZN?=
 =?utf-8?B?UUpzMVpnQXFTdENyUm5pMjdib0c5d25TUlROKzRYY1NVVXJ4N1FVeVdDYlo3?=
 =?utf-8?B?b3J6SERnQW5tMnZiRkN3UmFxck40RHdzR21jS2lCWk43Z1dScnZNcnlBOWV0?=
 =?utf-8?B?bkd5NlNiTGdTMXYxK2xHcDV5ME9aVVhucnIrVDZPVmNJbUFXbzVscllva3ov?=
 =?utf-8?B?bDRHOHZwLzNwejgrR1hFci9wV2hZZDVGL3pDZEt5YUowMWZiMDlFNjBRdnp6?=
 =?utf-8?B?TlpDZEdTS1hFQUVPTkxsVjcxMlFHZjhRc0pMQWcyRlc0ZExXSHpXYno5R2JT?=
 =?utf-8?B?Qk10dDQ4cVVMUzdtNk5zeUhVYjZ0VDFyRHNhalUrMW8yU2twK2xGQTd3SXNJ?=
 =?utf-8?B?TnVKVDFPdzNmNmZjYkZPMHJQVERwdi9uT2JZM3FJbWJZYWJKeHdweWxpTGps?=
 =?utf-8?B?dDY2b0crTDV4VXJlL05oeUEwckhpdkRteDVNbm1EM0FMbEJ3b0RWWnU4b3o3?=
 =?utf-8?B?SDZtejlIaTFBREJ4d3BGWXRJSDU2c0dLb1FJZ3FjMlNvTzhpakdIVkNkb2Z2?=
 =?utf-8?B?M1hIRFZSelh2QldiUysrbFVEb1ltVW9IeHg1SmJhL2xuRm5nVHpDeFU1UGdZ?=
 =?utf-8?B?WXYvTjhVQmFpV0ttZmp5NDYxWjdtc0lHNTJWdkJYSjlqZ2Nub3VMSkZNNlpF?=
 =?utf-8?B?anE4SzBrQU05ZGVaU2o0V2tOdUdxMzBuMEVCa0lIZUdDZS9iZVpSTk9XbEY4?=
 =?utf-8?B?d2d1UEZNRFJOL3ZZRGE4NjFLaUk2MW5wZXdvSVdQZDA2U21xVWF5VG03Z2pP?=
 =?utf-8?B?N1c5bG1KQWtDMHlmZGtRcmduQyt1WFA3YlVJangveitpQWZRZHF3S0JGVlJ5?=
 =?utf-8?B?Tm13azQvOXBzdy93blM5dnhKaUovamRKY2pNcFNreTJnRGdXcnBIOEQ1SGd5?=
 =?utf-8?B?ZFZLY1lQaXBFOUxxWGdrcm93cmRrbkpXVGJkdDZzTWFSbFo1UHdDTVJlcW1O?=
 =?utf-8?B?SWJZd2dxeERJeDZ0Z05Xc1I1RnJOZ3JrMWJDd3BUbGRMYVNFaEhUN21BeGZL?=
 =?utf-8?B?VENiMk9vbDBRQjFDckxMdmVKbmpySlRxRFFZc2x3RVF6dCtlaFdOeWR4eW94?=
 =?utf-8?B?WHlmMWdadGlac0pBVUkzR3dCU3NvZXlEL3NjenZTYW82dVZ2Ym1ObDdkT284?=
 =?utf-8?B?aFZ2VlNzempjd1JybUxrYWFPUkVqYVRKQkIyOThXMVUvWnZqV3pZN3BjbUFO?=
 =?utf-8?B?aDRpL0hqeXROZnhWTm1MaWEvVkFPZ2sySWRtSW5qNzcrNXRHYkJyZzNPRlBF?=
 =?utf-8?B?aDgrUmQ4VUtQbnc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e38df3-b46e-4287-4b71-08db1f27f8be
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 16:21:14.3132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKAzOYJfOuTsYfO4ALpjRKjatrrtEhxkgsWiAwrJlknVP9jVe2SsdanRglKgtELiHSJTco2I0EqSA1NbsIlFu24Ax7h66g2xbgL6bowUxAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4679
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_12,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070146
X-Proofpoint-GUID: DUuGF01yEDI1E0OG4jVwSgZwIJ4DxT0O
X-Proofpoint-ORIG-GUID: DUuGF01yEDI1E0OG4jVwSgZwIJ4DxT0O
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/7/23 8:31AM, Christoph Hellwig wrote:
> The last remaining user of folio_write_one through the write_one_page
> wrapper is jfs, so move the functionality there and hard code the
> call to metapage_writepage.
> 
> Note that the use of the pagecache by the JFS 'metapage' buffer cache
> is a bit odd, and we could probably do without VM-level dirty tracking
> at all, but that's a change for another time.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>

Was about to ack this and noticed I must have done it earlier. For the 
record, it looks good to me.

Shaggy

> ---
>   fs/jfs/jfs_metapage.c   | 39 ++++++++++++++++++++++++++++++++++-----
>   include/linux/pagemap.h |  6 ------
>   mm/page-writeback.c     | 40 ----------------------------------------
>   3 files changed, 34 insertions(+), 51 deletions(-)
> 
> diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
> index 2e8461ce74de69..961569c1115901 100644
> --- a/fs/jfs/jfs_metapage.c
> +++ b/fs/jfs/jfs_metapage.c
> @@ -691,6 +691,35 @@ void grab_metapage(struct metapage * mp)
>   	unlock_page(mp->page);
>   }
>   
> +static int metapage_write_one(struct page *page)
> +{
> +	struct folio *folio = page_folio(page);
> +	struct address_space *mapping = folio->mapping;
> +	struct writeback_control wbc = {
> +		.sync_mode = WB_SYNC_ALL,
> +		.nr_to_write = folio_nr_pages(folio),
> +	};
> +	int ret = 0;
> +
> +	BUG_ON(!folio_test_locked(folio));
> +
> +	folio_wait_writeback(folio);
> +
> +	if (folio_clear_dirty_for_io(folio)) {
> +		folio_get(folio);
> +		ret = metapage_writepage(page, &wbc);
> +		if (ret == 0)
> +			folio_wait_writeback(folio);
> +		folio_put(folio);
> +	} else {
> +		folio_unlock(folio);
> +	}
> +
> +	if (!ret)
> +		ret = filemap_check_errors(mapping);
> +	return ret;
> +}
> +
>   void force_metapage(struct metapage *mp)
>   {
>   	struct page *page = mp->page;
> @@ -700,8 +729,8 @@ void force_metapage(struct metapage *mp)
>   	get_page(page);
>   	lock_page(page);
>   	set_page_dirty(page);
> -	if (write_one_page(page))
> -		jfs_error(mp->sb, "write_one_page() failed\n");
> +	if (metapage_write_one(page))
> +		jfs_error(mp->sb, "metapage_write_one() failed\n");
>   	clear_bit(META_forcewrite, &mp->flag);
>   	put_page(page);
>   }
> @@ -746,9 +775,9 @@ void release_metapage(struct metapage * mp)
>   		set_page_dirty(page);
>   		if (test_bit(META_sync, &mp->flag)) {
>   			clear_bit(META_sync, &mp->flag);
> -			if (write_one_page(page))
> -				jfs_error(mp->sb, "write_one_page() failed\n");
> -			lock_page(page); /* write_one_page unlocks the page */
> +			if (metapage_write_one(page))
> +				jfs_error(mp->sb, "metapage_write_one() failed\n");
> +			lock_page(page);
>   		}
>   	} else if (mp->lsn)	/* discard_metapage doesn't remove it */
>   		remove_from_logsync(mp);
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 0acb8e1fb7afdc..853184a46411f4 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -1066,12 +1066,6 @@ static inline void folio_cancel_dirty(struct folio *folio)
>   bool folio_clear_dirty_for_io(struct folio *folio);
>   bool clear_page_dirty_for_io(struct page *page);
>   void folio_invalidate(struct folio *folio, size_t offset, size_t length);
> -int __must_check folio_write_one(struct folio *folio);
> -static inline int __must_check write_one_page(struct page *page)
> -{
> -	return folio_write_one(page_folio(page));
> -}
> -
>   int __set_page_dirty_nobuffers(struct page *page);
>   bool noop_dirty_folio(struct address_space *mapping, struct folio *folio);
>   
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 516b1aa247e83f..db794399900734 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2583,46 +2583,6 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
>   	return ret;
>   }
>   
> -/**
> - * folio_write_one - write out a single folio and wait on I/O.
> - * @folio: The folio to write.
> - *
> - * The folio must be locked by the caller and will be unlocked upon return.
> - *
> - * Note that the mapping's AS_EIO/AS_ENOSPC flags will be cleared when this
> - * function returns.
> - *
> - * Return: %0 on success, negative error code otherwise
> - */
> -int folio_write_one(struct folio *folio)
> -{
> -	struct address_space *mapping = folio->mapping;
> -	int ret = 0;
> -	struct writeback_control wbc = {
> -		.sync_mode = WB_SYNC_ALL,
> -		.nr_to_write = folio_nr_pages(folio),
> -	};
> -
> -	BUG_ON(!folio_test_locked(folio));
> -
> -	folio_wait_writeback(folio);
> -
> -	if (folio_clear_dirty_for_io(folio)) {
> -		folio_get(folio);
> -		ret = mapping->a_ops->writepage(&folio->page, &wbc);
> -		if (ret == 0)
> -			folio_wait_writeback(folio);
> -		folio_put(folio);
> -	} else {
> -		folio_unlock(folio);
> -	}
> -
> -	if (!ret)
> -		ret = filemap_check_errors(mapping);
> -	return ret;
> -}
> -EXPORT_SYMBOL(folio_write_one);
> -
>   /*
>    * For address_spaces which do not use buffers nor write back.
>    */
