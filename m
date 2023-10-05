Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3723C7BA2B8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 17:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbjJEPpm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 11:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjJEPpA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:45:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6F31FE3;
        Thu,  5 Oct 2023 07:31:51 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3950V4Es028063;
        Thu, 5 Oct 2023 10:25:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4EueJgoDaH0ssHbixK4wnvvy65n+tqOjgzl1sB68+5I=;
 b=fDavh1MsgfDmWoEsDwBazCS8HPPumbg2Saz/Y9S0q5AsIk/FrhV3IS/amMEYx+wc1IIu
 4QiP4kCuOeBzkBdquk4Mrr830XKwaWFarw4tles0nFrIbf/I0cE/g8Rh1QDQg6xSiihA
 OlW0V7RzEXf08YveIkfGagLjk4+AsbY10eXaQDgdBWAzkDakdaQoixlmsPWIsW5PFM9u
 HHl81Bl4e0MWXf+p8d6q0Hk5m7/EOWXy76nfXK6yMMhWyxjV2omC55d4eygGUFemaKrt
 Zo0/Kex2sHSg28BNvJi2p1D1WYF88mVhWO0oFO7DMsaglZZfeymQkrocTmGzpPBfqt36 ig== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebjc11ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 10:25:07 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3959Kg1H033595;
        Thu, 5 Oct 2023 10:25:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea492uh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 10:25:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4ujxDl48UODgojt76LMHOESeRlptlY7/k02mwc4AYTzSg8/OZSEWY46UBLFMfAOS9TgDQuVcVKyCY6Z/17J/kGuqazZWi3QpHYz/vCbDcQkKtcO00ZX6KA8vVbHBbdSAhYsa7IsIZu7Jb1+CEuMcEjBGK9YMnvwujSe107q4Y2Hhx36QyWN8s5BlyZpbUft+jsBpHAXQMykMhYLfBgxCTgJ6Qmr2wdVu9FvPDso8vXPcCxgjLjOppIcHqEttZl3DvRa/Y7a993OPmJVZN3BIbe/BuEMrCHGiJPD8KgiNQfzlO302c9rOarUxCTi4eFcOTrA+QiAdwXiNQlDTzR0tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EueJgoDaH0ssHbixK4wnvvy65n+tqOjgzl1sB68+5I=;
 b=dw8Dq47OmPpEB8cPtkPOJ+f7SzPb32ozkaaaulQTTd1WJ+n1mP+k8/1wylzbpOaezSOcfu4K8YGmjJ8New6j7AtjxRx+MILO6tihcWBb2o7Lsnq9hM1r9hmfO0/NvSiA3sj7BJ/ckwtO5VFdVgBRTIc4eZ09szncJpZsu0bocCADasrAea3bF8jkhbgPkC4ubEXmhQWSZlD9pZYE4YmbGkuMfDNscbeuk03GaRimlT79NL8G0JuFN7ePGi8rwMA75O7N36/ma1FMoG959MdelUacRMFQqKFAx/KqDaxAanTZKTPuX46zayN4xOXs2I1S3+esy8EQlJa1SLrR8j5ZuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EueJgoDaH0ssHbixK4wnvvy65n+tqOjgzl1sB68+5I=;
 b=N45RXH0podyIdObnCh31ctJ2ZCs3KFfus31UFGK5XhebVXw1HE6GrzGZL5l9Lzlix0qcvN1I4b5tSEH+qS2o5ggREDJCmbDjtqQt6fohl0UoiEEIJRbsHFIhnT46AhDIy9ljIBUKzys6cHLlan+9J28NSA4bF0r6DP+JvIBLZhE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN7PR10MB7031.namprd10.prod.outlook.com (2603:10b6:806:347::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 10:25:04 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 10:25:03 +0000
Message-ID: <b6ed0e26-e3d4-40c1-b95d-11c5b3b71077@oracle.com>
Date:   Thu, 5 Oct 2023 11:24:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 21/21] nvme: Support atomic writes
To:     Pankaj Raghav <p.raghav@samsung.com>,
        Alan Adamson <alan.adamson@oracle.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-22-john.g.garry@oracle.com>
 <CGME20231004113943eucas1p23a51ce5ef06c36459f826101bb7b85fc@eucas1p2.samsung.com>
 <20231004113941.zx3jlgnt23vs453r@localhost>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231004113941.zx3jlgnt23vs453r@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0420.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN7PR10MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f86953-93af-46ae-fbc9-08dbc58d5662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PA186iARq2nUyxzah37wGs6Z0Ogw/XqVgfIlFLH9iCwGeMRdtKVbpF0L59X/QgtYEYydCf9ZVBmsmzgEmzfpYHQADUR6QvhLwMZgy36ybFKplgNfMfoaFbmwwI+e60LxKtximrsRn28ZoPxk7Exl0T0TxqVYpgw+3Cd0hNsPjX0FSt3Om22jB0ADbULR0Vx2ZrGMGWRqRDveaw4jm8jT8Idsf4Y5PLAvgPyNLrt8erD2hBngenMs/NrY1K4dJgyovARcKunxOrKgd6dSz+2D8I9w+fvvqJEjhR3zPSfbvDA11dIeh5VsYQoHpCNarrETz/EUS/wCsjPyqOeAtYivoyPqH+J0Sct45JSolmkUb9FzYWbQ+nwhsIDn7kKNYUmVYQuxj7yaHiPQfGs8mEbrA6cLWBA8OOA7mkW6tR0IAQCoKS6ufgeekKROivpTxJxV24rdhtAfVarqhkHv7Nhc9p8m/zGr9kWp+7T80UxsFLTPIjD2AjQ6E9QW6HN+HN61aCcbkFh3GSY07P90DDfdYaz7hwkISSxUAX8xS7ozMC1uXtrJ5nvLKtyb3WmXRUQU3NnTzFFW3tweFLgCgta9zfyEd2gfXeTBkG+JUpXa6qp5yZcezs1PtDWqPfwlRvDP9Xs3ViZcybo3jbOX6Hlylw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(36916002)(6512007)(6666004)(6506007)(6486002)(53546011)(86362001)(31696002)(38100700002)(36756003)(26005)(2616005)(83380400001)(6636002)(66476007)(66556008)(66946007)(110136005)(7416002)(41300700001)(2906002)(5660300002)(8936002)(8676002)(4326008)(31686004)(316002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjFabWJlcGZvTU0wSjc0b3pFZjd4NkxkMXp6TVo3V2tYcmxCVVZ5Y05ldSsz?=
 =?utf-8?B?NHduZFdWSUFySGcxZnBEa3F1d1p3czJFaktNTldoaFNCZDZpYTd5YkZsQ05h?=
 =?utf-8?B?ZkJZWUpkQmJqcVMyd25QWHBvbmxQS0pBMzhMclpjSWJOVm4rdDU0bEZmelFL?=
 =?utf-8?B?Uy9wdjFMR1U3eEZwZmFjelEwVmx0bkdJNmhCdWZEK1FFSWVTbWN0MEVub0hE?=
 =?utf-8?B?dDBTamIwNFVBUzVvRVdKamthWTFuRDZrSGh4VW90UG9COFo1bWZVb3h3VDdE?=
 =?utf-8?B?YzhaVU40UW1ROWlpUmZnL2FPUWJ2YmlveXZoK3R2U2FxZ1MvdU1QWDRHTFhI?=
 =?utf-8?B?T0VHQlduejI4S1FuRGhsUjlPRzRSeW9iUGRGWml2K2ZuMHFhNW9vLzhNTEFn?=
 =?utf-8?B?WFFuVVlZajBEdk5ITmZkWkpwK1J6cS8wR3h3MmV1ODBQNUJobVRFZmdFY1Ev?=
 =?utf-8?B?ckoxUlhCdFl0SUlvM1hjN3dRdWVnMUpIVjJmc2NxKzdTbEhhT3A5cEpmT2tW?=
 =?utf-8?B?TVhpcWM2TkNMcHlUWHpFZE1hcE1mVXpsRnJWYU5UQS9SeTMzWFdoNzZQZVN1?=
 =?utf-8?B?QTFyNEdPckRPSFVKams2dVRMbFJEUHNOUk9ndHl2VFcrSCtyUnNuU1lHbWl5?=
 =?utf-8?B?d0Vma3RUVFNubXRDWHgvQVBDaWo2NlI5WU5RSWNwa2N6ZFRxcUYxVGExTzNx?=
 =?utf-8?B?M2xZczNEaWFEaGxTdGRWZzZxTG1pblpFN0YzL3d5bGNlczhyU0pGVmlMcmFq?=
 =?utf-8?B?TTNDSlM3MVJENkJlSklrSWNVRUdtZG83VG1EcHZpcFBidG9pbkFnblRyMmhn?=
 =?utf-8?B?NXNGeUxrKzZSSmQwQWZJay9JQmpBTzlVR1lIV1FmRTNyOUJqSjU5cm4zWVc2?=
 =?utf-8?B?Z0dleCtLQy9HQlRtYVRxY0RYc2xlU2crVWdPcCtSYjN6ZUdsUzhqWlpVcmE0?=
 =?utf-8?B?UnQ5cm1oeEQ3d3QzV3JzK0t4ZUZPWEM1WlV1dGFlTld2TkZxV0F1MUFvVHJK?=
 =?utf-8?B?QVVpeVFqWXhoVTAwZkcvamRjandxaXd0ZlBoWlBzRHRvTThVS0J3U1NpRVUz?=
 =?utf-8?B?SFBDQ2tleGFzSmlUZ1BwMmozM1RCT2dVMXRIQWlGYy9MeFZxdXJiZG9Dazcr?=
 =?utf-8?B?QU1CR2VTaDZmeXJ4STdvcmlUZ0k4MzhUWkc2K3NCVkpTZmJ5QitpUmt0U2VS?=
 =?utf-8?B?K2U3eThmR0I3bVNYNFE0STRKdjFhL2xoWFdvOGcxNGpWSFBPTGN4ak1ETHZq?=
 =?utf-8?B?anUvSExZREV1U002RFdDSU1aYW9KUXRoc0VFZ3ZqU0l3bmdJdEZFY0ZWU3dS?=
 =?utf-8?B?VklWa3JxVk56dkdHZ2kxdkUzbDJmdzk0aWs3alU3clJQSUI0eVY1bTF3cDNq?=
 =?utf-8?B?NlhrNGVMNldJOGZWSmdPTHlyQ1lETW80K3VBY3FLNElmSEY4MVpYTXhhVm5n?=
 =?utf-8?B?MmdVVVN4MW1WQW5jeGZMMDhIbU10TWxzbzl4cG44cmtRaTBCVUt5LzVGdzB3?=
 =?utf-8?B?SVFuS3Jzd0d6dEhGQmFtNkFhKzEwOGJQbnZBdXpuZWgvNkRzMGJDM2dpMkwx?=
 =?utf-8?B?N09Ec3lyZWJUOGYzcmgwOHJwZlIwTTNBM3VORlNxNEFwck1rRERHVGUvN3pT?=
 =?utf-8?B?SWFTbGpQZDBLVWVycWJFTnJFZ0N4ZlJBM2hZNXNXVmFQd21BQkR1ZldtQ0xZ?=
 =?utf-8?B?S3dMeTlSYUd5T2EyU0JVTDJGVmo4NEdqd2lPamQyNzI3RGkzQ0g3bXJSSGt1?=
 =?utf-8?B?Rk9VcVQ2dmwyZk9vQTdjTi81cE1CQ2RlaUp0R2o3ckZKN2thTTd5TEdQbDFq?=
 =?utf-8?B?c3M1ZzVNUUF0MVMxbUI2WDNXRnJKbUNJZTcwKzVzU2FJeG9GVEViYUlEOE9a?=
 =?utf-8?B?U0Z6TGVmazNHMW1xVnVnb2l5MDY1N3Z6dEUwU285K1VUaXh1SGFjWFFvREhQ?=
 =?utf-8?B?QWtUSnZrbjkxTlBlbXN1ZHBwL1U0VjBhSTAvd1BVLy9lQnZqSjZnOTVMNGhT?=
 =?utf-8?B?T1BRT0NQRmNLNnNpZEZ4bFFxNUpEeTRjYVd5YTBQd0VyV0dVV0k0M2dWL2Js?=
 =?utf-8?B?NHducWw5YWV3UDVpYjAyWGxLUzNweWdDTzNrZlZ1ZHNqb00zbjk2YXJES3ZZ?=
 =?utf-8?Q?A4mxwny/puz/eamJYmUwo7Cdh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?c0JHc01TS3FGNVZWRU1vY1IxVHgvcTY4QmwzYUNYbW0zQXYxTlpYTjlwcm1r?=
 =?utf-8?B?cjVzcHJtMWJVSkVoZG96UmpsK21ZM253OVFUR1dNcG80ZGEyeEtIOXBvVWFU?=
 =?utf-8?B?OFFxSzllanh5ckhNUk5BOEVlNWJyQmRGTmZUUDhGM29ELzBOKy9pTDFKUnRv?=
 =?utf-8?B?UEI2b2dRNHBaUlhOSSs2R2ZKUmtvZ1h5akV6QTduendPdUNJUzdpWTdCUGhC?=
 =?utf-8?B?TktMYk5DdVE1czNwaUJ0Wml1ajNkWkdoWDFxNHpCUkJ2L29wMnBicUxkb1Y0?=
 =?utf-8?B?OGJTTzZDeU5XTHRqZklpWHpNcXA0Yno3cWRzMGpzd1NHM2VJa29ab1kxSENk?=
 =?utf-8?B?QlQzYnJwczUrbFBocGRnSnk1TWNsN2tyVkg2MzVQRXk2SGRlcEtCNElVaytj?=
 =?utf-8?B?bUlYT2MyWHVoRVNhVHhVL2ZWSm95ajg0L2VkcmZGYlFjVmsvQWRieXlJQ2xQ?=
 =?utf-8?B?VkRvNklVOUx3WDdGL2E4ZkNmOEtGdmk4OVNMSERtSjBJQ0JpRXQzRmxpZ000?=
 =?utf-8?B?OHYwYmNRYlNQc0tLaXMzK3ZITlNxWmRid2dNU0ZJaVg5SS9KcG9VUGcvZllw?=
 =?utf-8?B?QU56anJjK2tNR2hZYzU4eTBnV3RKcC9wdU05Nk9DSUIwbEw2cnhPTURZVk1T?=
 =?utf-8?B?aDhsNWNoR0F6WGlvMFpwbTUvWEtidWplSTA4bVRCdVZMdVY4cUtyWURUWThw?=
 =?utf-8?B?K2VhL1JXVWpZeTdIaWFubHpmUGJFeDNTMkdTazMwKzV2ajdHK0VIeUd0eWRS?=
 =?utf-8?B?bW1MZlJTTXgycERhaVB0UnlFazB2SldGbnRCNlFaalMwc1dmTVdqUE5wUTgx?=
 =?utf-8?B?TTRyWFVIVXp0dE1lNlpCRldBalJ6YTVvU21EYVZjcDF2djhpSjhrc1NHUzc3?=
 =?utf-8?B?OVB4TkZEdWpaZE9STlQ3TWcyL3Rya0xyNndJN2NVbnZpWklGYjA5M2NjNXli?=
 =?utf-8?B?bmJJdkZuTFliM3JpK0xtaU9uUlNoK2ZKd1ZCVUcxN0wySm9iMDEyaDc2S3NZ?=
 =?utf-8?B?ejN2LzVuQ2Z3OWVzSmltOS9RMmFwRURLbUxjMDNkUnNqNndDQ0lFSURSa0lC?=
 =?utf-8?B?eGc1b0UzV1lxSEJzM0lKeGNoWHJObm1xK2ZOMCtXeFkwckl6YWhySDZHY3lD?=
 =?utf-8?B?STRvbDZCRloza09yTVRsNFlyZ2EwRnhySi9VQUR6elp2NE81dlg0R1pBMzhr?=
 =?utf-8?B?UG00UmhtTzR5d2ZjUWJ4SmZqSS9oN3hWRjJlWGFWSmowV3k5TEtkbmU2UWpa?=
 =?utf-8?B?T05LQjh6bUQ5eWhQMldWY1h4Q1FHWGIrejlvY3hFUFhRSWlGQ0FKcllWWXhX?=
 =?utf-8?B?Z04xUXlETmpiVklKK3o3V1V0R3kvMzFRZkFyZk53bkdubDZJTXI4Q0h1RW1G?=
 =?utf-8?B?WHUwNHoxN1RvOHBqVzZrZStSeUVqa2JJL25WcGFUZlM4dncwZ2J5Ly9Pb0Vr?=
 =?utf-8?B?SnJkb2kycVZNOG5WVzZkSTdMTXhwL1lnSG5XVGU0dEpRdjdCcG82K2QwY2hG?=
 =?utf-8?Q?DF8SrzUnBDvEMOrhoyuiNSe2ZHa?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f86953-93af-46ae-fbc9-08dbc58d5662
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 10:25:03.5979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJEpIscTXbwGgdUQm2BpTdYWu9NlkY6yZR/clXf4cEg0VQcvU8/q/x0voPUf494y8xa8CJiii5SS1AwKwm/mwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_07,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050081
X-Proofpoint-GUID: 0Tcm2gbfdCi6ZeYavL8lTGHJcnntTZ2e
X-Proofpoint-ORIG-GUID: 0Tcm2gbfdCi6ZeYavL8lTGHJcnntTZ2e
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/10/2023 12:39, Pankaj Raghav wrote:
>> +++ b/drivers/nvme/host/core.c
>> @@ -1926,6 +1926,35 @@ static void nvme_update_disk_info(struct gendisk *disk,
>>   	blk_queue_io_min(disk->queue, phys_bs);
>>   	blk_queue_io_opt(disk->queue, io_opt);
>>   
>> +	atomic_bs = rounddown_pow_of_two(atomic_bs);
>> +	if (id->nsfeat & NVME_NS_FEAT_ATOMICS && id->nawupf) {
>> +		if (id->nabo) {
>> +			dev_err(ns->ctrl->device, "Support atomic NABO=%x\n",
>> +				id->nabo);
>> +		} else {
>> +			u32 boundary = 0;
>> +
>> +			if (le16_to_cpu(id->nabspf))
>> +				boundary = (le16_to_cpu(id->nabspf) + 1) * bs;
>> +
>> +			if (is_power_of_2(boundary) || !boundary) {

note to self/Alan: boundary just needs to be multiple of atomic write 
unit max, and not necessarily a power-of-2

>> +				blk_queue_atomic_write_max_bytes(disk->queue, atomic_bs);
>> +				blk_queue_atomic_write_unit_min_sectors(disk->queue, 1);
>> +				blk_queue_atomic_write_unit_max_sectors(disk->queue,
>> +									atomic_bs / bs);
> blk_queue_atomic_write_unit_[min| max]_sectors expects sectors (512 bytes unit)
> as input but no conversion is done here from device logical block size
> to SECTORs.

Yeah, you are right. I think that we can just use:

blk_queue_atomic_write_unit_max_sectors(disk->queue,
atomic_bs >> SECTOR_SHIFT);

Thanks,
John

>> +				blk_queue_atomic_write_boundary_bytes(disk->queue, boundary);
>> +			} else {
>> +				dev_err(ns->ctrl->device, "Unsupported atomic boundary=0x%x\n",
>> +					boundary);
>> +			}
>>

