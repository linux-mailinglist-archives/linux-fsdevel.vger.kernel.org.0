Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBF27978E3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 18:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244980AbjIGQ57 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 12:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245031AbjIGQ5n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:57:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B731FE3;
        Thu,  7 Sep 2023 09:57:13 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387FxNqR015996;
        Thu, 7 Sep 2023 16:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ruEDkVaJmX5sOkO92YOxm+GmgvkQ9EPokLEBs7gSyw8=;
 b=F7o9a4hCz8BEMoyyg5+UEShAMvINKg6ujw4EPdjGOvTjKO/qlD8akK65jEomQGdtWH1E
 KOGymByGoOi+saUjoxLJxQNS6WVqtYura6rsv/M/p+4k8BstU8RtwH9AzKvAhVdPubKn
 gpzQImnERM9kAgIsKSqmI/jTOJAkMwzGvNVFP0K/86+vYdfQ4JPkiQBJHrm5OndlxDGQ
 bRKWLBOHcg3wPEEVXIxo4AAjRfGjRrEH79icAU55M0wbDctD9Z4Lt19nBpy8yZNs8vU3
 QDrKKp9BPhcOm7keXQnQRtIXp3iKVropgQqe1xeKDZaubvLn5Ae1gdqEnvDPAmYbrRY9 HA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sygfrg7an-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 16:01:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 387FeNO1031082;
        Thu, 7 Sep 2023 16:01:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug8ctpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 16:01:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FN0MLzJi9dLX6xGr4M8xWfjhSQN8NY/vSh9tSLNowBzGToXeUyyXgPz3cZrJ76l8McQB9UBGidjrzkOKFPLoZBPfmxrjnIRKjTkk36qR3W6ksMoe1jMe8c54pGuFlYqMh8DWP3gSYUGLulcDbBqBjeyYwW2vWO96ly4qAA34ki0ul+DBK/0L24jnHgqwTNVQV4RPB3RcW45PJGIWw2SeLz7ea5G/51SYe4bJnkJbSWB9kV2WkdEY7O49eczQf7GMNt+NNv93ewChWDrT9KClwRgGfmsLE08X2Zs1RESszMvQ2yaaUTzfH38IphcQyiDxz44Nz2+H5sj6+dbE8kyO6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruEDkVaJmX5sOkO92YOxm+GmgvkQ9EPokLEBs7gSyw8=;
 b=V7WHFUansUFTNGpHfybpVhkO1/QQeIavjBHRc/D2+xlIIjdqSIZvVTQmP9IWXOlA5SAqpzsfhR5HIdMUb2YwOskc38baQvanXALOKmC2eFRWtc76mgPY8n92wyUFT96swbcn3664sFwDN6eqdo6Sv89XFklnSK3Tr1sWOQ2wT5eANDN97wsx0y36HfGNGJfAKO9ghVacgFGeQ52JXsa8zeuXdhQGeQHm2PAIgBNBhS7HbUs/RhAa7/ylniI1RVWbmq717pChynA0I+FdtOuheC/eZst2mUSjZfSPokmyegc2sozB58SggIfFGZbK1akX/dvA1ZZiJvV1WId8+tk4wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruEDkVaJmX5sOkO92YOxm+GmgvkQ9EPokLEBs7gSyw8=;
 b=TnIRKNsQp9O5l+hX1U8gaVZ+ocHztE+hUtKsdwKxCLerNFPcv65c2eHMfEiHuIE+kr7GmoPO2oFhkBZfmB0Kbo8+AvCDpdzExPqW4rtsh7bDso/QXumFlOvhcMWaRbLtND1qzJHbVq8oQiix7Qb3YSyiS1Gd0BvgVVI60GQrwr4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6022.namprd10.prod.outlook.com (2603:10b6:930:3e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 16:01:50 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6745.030; Thu, 7 Sep 2023
 16:01:50 +0000
Message-ID: <93570263-b8ed-4112-6392-da465b11869a@oracle.com>
Date:   Fri, 8 Sep 2023 00:01:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH V3 2/2] btrfs: Introduce the single-dev feature
To:     dsterba@suse.cz
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
References: <20230831001544.3379273-1-gpiccoli@igalia.com>
 <20230831001544.3379273-3-gpiccoli@igalia.com>
 <20230905165041.GF14420@twin.jikos.cz>
 <5a9ca846-e72b-3ee1-f163-dd9765b3b62e@igalia.com>
 <fe879df8-c493-e959-0f45-6a3621c128e7@oracle.com>
 <20230907135503.GO3159@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230907135503.GO3159@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: b40771bb-55b6-4f6c-59f4-08dbafbbbf2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eucuzjqah4XXOskMBTOhZdLdvRnN6ismsk9oMY8CfFsR641TRM8Bizyl4N7hFnnbI7wIa1n6lkezJScfj4UvVHCyWxj0iDWRhME+l2OKw0hc14Az9BGnbSl5S8lh4/sYM62W8GkQB1anu2Ukn1h2ZPgrkUizshcRXCbZMj2IwfL1Lv7uWG8vZEGsNYZGyxtLoOlwlfNvpeXpqmpL6/fj2b1+j6Mzj4OJpXrLMNRmZD5LDsGMjgD0mw8PVuprHvi7iXntf3NftbOk7UlGUTxk3nDZI5/sV7h72CsPfIAAhwH/QS/ZjoGab49KEkzNbHZwOi3QBTj89WG1A4ISsTCn7SRaXQhapPcdZuZm7xsL2bYp7qOoBmoKGco9ZJhtBlGtYcgLNNVG1Miz9FoLFlbdaE7b3dGOfbXfgoMVrNZxKIiXd/4+N2ysHtYo/z2mjaDlbV/Va4B0Kd90DwrzrfStMLC6g1tomQayt0Ow/Ru0d0Tfu+Zy0oPVR+VP2xajXP5t6VWnXS0sSOYonSoU9ycE9dpJrVC8chb9zLgg+DZFOjEZNX76qfAoOKXGrMgv31Bk63f+jTcsEdEiw6I11SmuRgzp54Ht8CXAId8aT4P2tii/ahHvK3BeLCejTEzoZM1ShSS04+R+O0myZ7PkVVxD4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(396003)(346002)(1800799009)(186009)(451199024)(8676002)(4326008)(8936002)(83380400001)(478600001)(6916009)(66476007)(66556008)(66946007)(53546011)(6486002)(6512007)(26005)(6666004)(6506007)(7416002)(41300700001)(316002)(2906002)(5660300002)(38100700002)(44832011)(2616005)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGdmcmZSRkpNM0FTWkZsc2g3Nk45TW1NcmFzRzlLNURXejNKb201MTVQdHNQ?=
 =?utf-8?B?aWVRYmhyc3lic2U3UFBVMUFFUXYybnVrdTNxcEZKSTFJZkRxNXZjYStGVTR1?=
 =?utf-8?B?cTQrYUZaTnlTWmJ2YVc5R3RCSkkxOXA2MEVGbDdoRWxiTWFDUWR6M3dIVWlJ?=
 =?utf-8?B?Y2xDaHNLOENqektxMjQ3QVFRU2NySGdRRkNsWW5oVy83RHZQUUIwTUIrN2Nu?=
 =?utf-8?B?RW1zVVU2UWZLRWJ4d0kxV2N5aERxN0UyMW10STR1UzVLemlYN0pwb3I2VU1B?=
 =?utf-8?B?bUxhQUpSeVJJY2p6ZUpaL1g5aDR6TXJlUkZ2R0N5bWsvZXRlMkYyb0lERWln?=
 =?utf-8?B?MzYxOXZFdmxic0RYQmpib2NTY0E2MXBrRld5QkQxdlpnKzBiSVE4V1RmbEEr?=
 =?utf-8?B?bGxhSkFPaUkySFFubkVVZWczeWVubGxyN3cycWZvd1dpSGNRcmhWQUtiL0Q0?=
 =?utf-8?B?ZE41VGRjU3Bib2lHclZyeU03dGJ2dEtQdjNFdW9CeWdEOG1uUlVFMGQ1SXZ5?=
 =?utf-8?B?a2ZWSnhLOHEzNy8yM210MUVkZFVsa2xFTWFBZlUwbkZoWjB1SWllNjhxOGdp?=
 =?utf-8?B?UERVNjlyUXUrS1JuQTdQOHVDRDdKQkFxZTM0VDdva1YyUUFpVEcwSHNoQnR0?=
 =?utf-8?B?ODA1eWVQamtsTnB1MzNlVndWUit6V0FQbmFXM0MyNXk1UTBWZEpSdS90bkRk?=
 =?utf-8?B?akxnS3YzVG1HNnByNXRhYzB3MlFXdFNBQkZ6eXVXcC85SXVNL1FaTVlDenZJ?=
 =?utf-8?B?eUlEbWpKMWZ3OGUzUjY5eUp3cm5XKy9vSmY5bnhqZGFXNEsvVllLV2lFajI2?=
 =?utf-8?B?bnZFNFJybXZjQi9pMFVmZDhJeTJ4em5yNGJxUjV0UHdaOXJoMm9HVnJFbUEy?=
 =?utf-8?B?azlIM0FienVmdDNLakVzeTE1T09teStVTkxjOC9tWU1mY1duQXVjSG5GSk5Z?=
 =?utf-8?B?aVd3b09NdWhITmRRSXBwemxCRFZVQkFDd0ZBUUZuOGNNOWlRNnVKTXExRHE2?=
 =?utf-8?B?UllsM1Yxb3Y4LzJWOFBWL3puc1hpV1hmSnJPcE1YTm10ZGNVOEh1d3JoZUtD?=
 =?utf-8?B?eHhSNzBOUFVnTGtyWXN0UGkzY2grd2I3YUNROE1EeXpDTzJMaUpmMGJHVUJ1?=
 =?utf-8?B?ZEtnbmtpZGJpVjlIMWhBMnB3SlpoRzN3dmx5QlJwekRQWHMrTWpVQTlBd1Uy?=
 =?utf-8?B?Rko5bjB2U21GVzg1VTlXRzMyTE10UnJ6NkpFaENLclpvMmJKb1ZDbDFwVzBy?=
 =?utf-8?B?NmhtZklLN3BBbWNuZXFYYXEzZmdRcW5ieUFuRTJYNTlZNS9BTWJhekVFUFI5?=
 =?utf-8?B?eDlVa1JUU0NDRkFQaVF0aFdRWGZkUmFsWjNyK3hvc25kNWwwamZpcnl1Q1Mx?=
 =?utf-8?B?T1FZeElmaERPTW50YU1HYW4zc1gzM3hWYjMwbSs2Q1d0b0RCZUk2cU1NV3lD?=
 =?utf-8?B?dHlTQ0JML0lUbUJZWjl3endhN1FnK0YxMWR0MjNRWThnb1VjZ1FqUjE3Tkg5?=
 =?utf-8?B?QldSZGRZWm1XSTN6dUJ4TEVSWVVhTkVqSDB1a2hIcG9yUzZ2RXJHTERLM25E?=
 =?utf-8?B?U1pxRmdpdVJkNGVsQ2lud2ZqNTN0T01Kb0U3amlubXhhS2o5eEtsdWk0M0dw?=
 =?utf-8?B?UEZIcEtiRDBRZ0NYVE5WTDYxOStrNHE1YWd6aXFDWXMyK2FNczdYTVROdElH?=
 =?utf-8?B?RURpR1YveFI3akhxR0kyQUdUM3dhZE9ROGU4aHdZS2JHdWlaV3FsMGJxYkw4?=
 =?utf-8?B?eXd2YjdhTG1JNU5CNzRBSnJZZVI3SllTV3VONy95Sm82MVdTY3RrRld1YWVC?=
 =?utf-8?B?ZUx5OEwza2VqMFB5QTg1MmN2d2pJbXA3dDdaeTdlUjhuRHdpRnJpY3l4bUZz?=
 =?utf-8?B?b3BSSmlxUHVLTTRTOS94Um5kUE5kaE8vUis0Qk9aTWljQ2xVMjNXUTBxYkhw?=
 =?utf-8?B?c1RnaEozWi9pKzRwZGc5ZFhvbHh6b0JwdXVCTExtSzluVnR1RmQ5OTMxaXU5?=
 =?utf-8?B?TnhheDdHUzNZLzduWW1xRG1tVFJ4U0tHNEpWRUtMM1lnemhQeDJaSmVMMUJK?=
 =?utf-8?B?ZFhaVUozZDIwcCs3SlBaaituYzVTbGFVM1BOM0RwUHhid2lqSndzTW9DVmVy?=
 =?utf-8?Q?HrT4TFRewEjLDf8pgnF+8IUM9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Q1pybENxdTVHRThYS1V3OUliaXdvOW11c0lhaHNFTzdOYjU5ck5VYUQyNndP?=
 =?utf-8?B?MXI2NmJDYUpWZWxaZ3V1a2JDeWltUkdiQzZnYmZUc3RmeXM3K1g1UU1Zc1Bq?=
 =?utf-8?B?eVROV1RBOU8rU1NqK3dDb2ZoZHRqYVJnWGJxWU5XQTE4QytKUWxrZk9vZkRj?=
 =?utf-8?B?ekdTbm85bzBGOThSaktiR0dERjJ4ZUQzTG1RbnZhRk5ldm1KWjlxWmM0S3V1?=
 =?utf-8?B?bmRUTVoxdFRjNTRlSmt4cGgxb2Y1a1hYUWRkdDhBMFZQRG9uSnlxVWp4L2Yy?=
 =?utf-8?B?ajdaOVE4bnUrZXJaMjdZWVJwcW5PWUMrN29ldDRwSEpycjZOR2hWMndQWHVQ?=
 =?utf-8?B?MW5Eb3hvUjlQSll6TW9UMExlL1dLKzg2L0t2Qkw3TU5iOHQwWGNiNXpsK0Rz?=
 =?utf-8?B?bUN3eDVZcmpBMjUxSy9HckFVVXgrVUgrUDJaY1dzMXVVUFlFM2Z6V0hSZEI2?=
 =?utf-8?B?TTF5S1V4bEZ4VUxUSk1ndmV2VDFyc0xZU05PVzFwMDYvTDV1bUFKMGFUUHF1?=
 =?utf-8?B?RHFjY2pxa1c0bGVrM1BGcGlZenVTUFhzTmViRjcydWRtaVNtQmVQSlFhc3dI?=
 =?utf-8?B?Z0k3cEFBZDZ5cVpOVndiT05VY21UNHFlcDNWY3hkOU5adjZ1a2R5U3JFUHJv?=
 =?utf-8?B?MHgyUEVWTC9udUQ0RUZidTlaS3M3Q1Vwb2RxeWVsVU05OUx1K2ljVUZETjl0?=
 =?utf-8?B?SERpRzIyenp4SDhTc3I1NnVxRXBYdy96cHNxVUJ2TlBnbmUyelBRdnh3M0pK?=
 =?utf-8?B?RXlZenVNTE5qQWdPanlZTWpNckhVREVqRS9KUDk5M2lGYkVSbVBFSFZkZEpC?=
 =?utf-8?B?TDRQWGkrMVJZV1JueHcybFlDUXpzS0FUS3RjN0lvRzlHSlBRTHpyaEE1TDB3?=
 =?utf-8?B?dWlTNE9YZXA5V05XYmhPTkZGaXR5ZXlsSWZyRDM3SEhlTlFkOTRCT2VPMTdm?=
 =?utf-8?B?OWRjK3lvalNNVjN3aWpyNUFTS1lNVDBhdTY3bUVLTFAxVWZtdVhLZjBOQklI?=
 =?utf-8?B?OGFzREkrUzZpMHhVQktpTUo5bWUyQ0NOeGJTc0hMVVcvVjNrR1VFSUMzMDJL?=
 =?utf-8?B?Nkh1c3dGK2FCK1pDcDA5cHk3S0lRd3M2ZHUrUVQ0TFBYWXI2Tk5ZdUtycGhv?=
 =?utf-8?B?SFdST1NrTXo0T29yKzJTQStvUXVsdExWTDBqODRFbHdPMk43OEhKS2pwWklL?=
 =?utf-8?B?dElmbGh3T25mcVFaMnFodFNVbkJoN1o3UUUyOG9od1RkTTdCVkt4SExSckRG?=
 =?utf-8?B?aENYbGRVMTlRWXdkZTR6WjhsdkJpc2c2Sjd5bjRlNXQrRzI0MEtTWDY5K1dv?=
 =?utf-8?B?VkhYZjNpOHdLT0RWS0pvTExBR1pSV09Ob3phSXNQWEdlRWQwdWcxQ2VORVZm?=
 =?utf-8?B?aWFKRVhuaFVNZUo0d3RnSTdQZzkzRFUxQlNMRk83eE95VlNBcmwzbmIrSzVs?=
 =?utf-8?B?VmxXS0IzMjZiOEM5WXc4V3U5ZE1FQ1g3cjFPNEh3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40771bb-55b6-4f6c-59f4-08dbafbbbf2c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 16:01:50.6803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZr6rPWz3VQrwbU4Y0GGE9P1hAG2Xxl6pmAMxbFWJhXQoSOTXxY3I2G9JLN0GzhHCKYKprxmzqJlS2APd/gRxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6022
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_08,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309070142
X-Proofpoint-GUID: qWze8h25OQHXKJ9UoFSSXvUuNIbg7ueq
X-Proofpoint-ORIG-GUID: qWze8h25OQHXKJ9UoFSSXvUuNIbg7ueq
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/7/23 21:55, David Sterba wrote:
> On Wed, Sep 06, 2023 at 05:49:05PM +0800, Anand Jain wrote:
>> On 9/6/23 04:23, Guilherme G. Piccoli wrote:
>>> On 05/09/2023 13:50, David Sterba wrote:
>>>> [...]
>>>> I'd like to pick this as a feature for 6.7, it's extending code we
>>>> already have for metadata_uuid so this is a low risk feature. The only
>>>> problem I see for now is the name, using the word 'single'.
>>>>
>>>> We have single as a block group profile name and a filesystem can exist
>>>> on a single device too, this is would be confusing when referring to it.
>>>> Single-dev can be a working name but for a final release we should
>>>> really try to pick something more unique. I don't have a suggestion for
>>>> now.
>>>>
>>>> The plan for now is that I'll add the patch to a topic branch and add it
>>>> to for-next so it could be tested but there might be some updates still
>>>> needed. Either as changes to this patch or as separate patches, that
>>>> depends.
>>>>
>>>
>>> Hi David, thanks for your feedback! I agree with you that this name is a
>>> bit confusing, we can easily change that! How about virtual-fsid?
>>> I confess I'm not the best (by far!) to name stuff, so I'll be glad to
>>> follow a suggestion from anyone here heheh
>>>
>>
>> This feature might also be expanded to support multiple devices, so
>> removing 'single' makes sense.
> 
> I'm not sure how this would work. In case of the single device we can be
> sure which device belongs to the filesystem, just need the incompat bit
> and internal uuid to distinguish it from the others.
> 
> With multiple devices how could we track which belong to the same
> filesystem? This is the same problem we already have with scanning and
> duplicating block devices.
> 
> The only thing I see is to specify the devices as mount options,
> possibly with the bit marking the devices as seen but not
> scanned/registered and never considered for the automatic mount.
> 

Indeed, users have no means to accurately identify and group the devices
unless this information is maintained in a configuration file (similar
to md? I think). What I mean to convey is that it's possible through
alternative methods with certain trade-offs. Personally, I don't prefer
the configuration file method, but not all use cases share the same
preference.


>> virtual-fsid is good.
>> or
>> random-fsid
> 
> I'm thinking about something that would be closer to how the devices'
> uuids can be duplicated, so cloned_fsid or duplicate_fsid/dup_fsid.
> Virtual can be anything, random sounds too random.

At each mount, the fsid will be different and temporary; it may or may
not be a duplicate device. So, I believe temp_fsid, proxy_fsid, or 
virtual_fsid could represent these configurations.

Thanks, Anand


