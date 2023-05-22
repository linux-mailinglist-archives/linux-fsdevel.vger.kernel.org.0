Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C89D70C40A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 19:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjEVRLH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 13:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjEVRLG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 13:11:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7F2E9;
        Mon, 22 May 2023 10:11:05 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MFjhGM024182;
        Mon, 22 May 2023 17:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=9omPieqHW3vQFA8k2UswKB3tFPVUoRbRhiIoCWA+cK8=;
 b=D0WardS+B9grkInOX0ixMy5EirDAxUzacwGlhILvMVLa/f2nlHBp/WmVC0B8y6uwIcX9
 NXzSg1BCQIXtE9B3ry2lEAD2zJJSq6jhyzU6CLUcmijtx9HqtnLvkMxTV+tld6RAgsrX
 +tr5MjrsgLtsVgco+E79SjuPUhYR/c0NiMhU5zRIJtpVDA07Ft0D7KGMsu/zI1nCmrry
 dtk3qJEjebwoQVWXGrIHh6+5e4Jr18aXFVc+FYNkIAklIFNUYNMYD7GA/QwFFywzoVPv
 EUaGQVlUMOlqwPZ8npyqI+lSyKCg6As7tKYo6cuFO/A6WItz7K9grMylqki2TwU/br0j uw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpprtk893-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 17:11:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MG1ZKv023582;
        Mon, 22 May 2023 17:11:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk8t81yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 17:11:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGKgA3gGwpDGIhupFIQVR/1R+85ahX41hrDGE6Tn9rNc4L0grewVmJyhSnzSOTtTZtPkgpnleAlRCXaN6JCmezrTX4vV+fMUbKCqQjvLfeXFeWzAeYvhWLK7m0WWm99z+agoibusqKevV4Q0dPjMyW3tUCTydtEtpz+jAQJ/o3MFNh0SDfk30K58yTlS522SaVsSGSdBoHiOrVjui+Or7KrMRgobnomfL8PSGObOeCDsSTsACUhDEmwZl6rJCUyE6eTXV90009m8xL8awzW+8VsI0jeD4l0UUWjvZgg7fduvMJUjadAKPiCUYRaXdQ/8mS6gkOMi9dkfhpA13FrvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9omPieqHW3vQFA8k2UswKB3tFPVUoRbRhiIoCWA+cK8=;
 b=cyzOnLaTnNY3XwmTEPkqtEGzFoP9ezblkFz4c/PRncIvArpcDC0u1A7PUx4ZHhAiDrbxYixfa0taqNQb72nxo73J2dPWqVVFf/B+AvGvEIc9IMXqj5Wh82Qk1jxPThie+mHDbzr/1fjikm7zin5MQSlw/6tjfTysLf7V1rHl+0YIGTvENZjUjXpnAI53WxFigvGUcKAwMlP+daI1kD1IKaKheJ7hBqKXuKh3lxYn/KpwiiR/ec/2CzNtyDvxBD/2pNvwOb0ZedKd1Flu5ljWXfVTctZfUpAffkBR6kCI17MjaFKJax0T4ajV8EldvM+7TCAskexguPKbBH38CuFmxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9omPieqHW3vQFA8k2UswKB3tFPVUoRbRhiIoCWA+cK8=;
 b=j38yptJXrhGhbS45j3/pExyQIeKBP8Y8MXDGH5PUB9hagz5jD1kNn70q/shTlKBYrSnn1wksFaEwiM+YVWimlgnM+P+bML7bzT5wLe52ug7vgBktHPoS5rJeIF6OsJeZryn6qWEwKI9o+aVOQV5LvYDvjcXSXTado6Z04YF5HHg=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BY5PR10MB4130.namprd10.prod.outlook.com (2603:10b6:a03:201::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 17:10:58 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 17:10:58 +0000
Message-ID: <6f7d3df9-8373-a929-9b11-44f51d52c425@oracle.com>
Date:   Mon, 22 May 2023 10:10:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v4 3/4] NFSD: handle GETATTR conflict with write
 delegation
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <1684618595-4178-1-git-send-email-dai.ngo@oracle.com>
 <1684618595-4178-4-git-send-email-dai.ngo@oracle.com>
 <d3ae1575dcdc44d1822a5b6a4ffd09b12c600374.camel@kernel.org>
 <546eb88d-85dc-1cd5-9a3f-b11f3eb144ea@oracle.com>
 <2eed123d-66fb-44a6-ba1a-c365b8bbd0be@oracle.com>
 <09113712aa83d9010ec3963368bce840dfb762db.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <09113712aa83d9010ec3963368bce840dfb762db.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR07CA0087.namprd07.prod.outlook.com
 (2603:10b6:5:337::20) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|BY5PR10MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: ea71eb9b-25ef-488f-ff52-08db5ae782ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5GU+H321JBkmGyTpPDy+Xp/3MeOOqgzRKebYlgosYbT+kIb4s4+V8tpqCiZVDBP8sdpnZnOjX7UjaVzHb4ZpJAg1FtnjF2HOLhLQxs5HMPIWrh1udi78BRAQNcrayJHA3whf+feXt35nC7QKko/b7T3gmnJaHqhrc+Lj3pbW5iL+lXNIVYwKS4lLGiFTQnaBfyyv7cFpGbv83/KUwA28zmEt8kPAEbeqdu6oFMyl0TX6FTu8V8igGsR17kLnl2h5ybtQRi72PreI/4Pu13rzQLDwYxqV1+oCO2t4YclxNJx2TJoOa2MRZtkr8Xtfr1RxZpgvh+5cVLfRd052HD9XndSTItAs9PZrHZBJdPi/VotLbUjE/PP2tWLUKS5JWWPOpMghnmy8k2Rtelc8zH+0y3hoSCbyOSN5PEOsby3CA2UTP8hG8qPkEbAFKAVVBCwJJlb6A3Rx2GAIJqgzU+pfauUmG/U9q0VDyQyd/np25CN9tuY64cfdpaXGE76E+PVBD8rQXAZIatLOfIKCqZMwHMnAhL23qiXD7WLGW9WqcIj3eIV7DiPpHdM/7IIVAlxFmN4Bh2V7J2ZJaj/fY7dedw+/NW6I1S24MEraWmbUOzCmEJDG6vlAvWcscgyryhE8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199021)(478600001)(31686004)(66476007)(26005)(5660300002)(41300700001)(6666004)(6486002)(186003)(4326008)(316002)(6512007)(6506007)(8936002)(8676002)(53546011)(9686003)(2906002)(2616005)(83380400001)(66556008)(66946007)(38100700002)(36756003)(31696002)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUxVTmcwckdFRjBoRzQwcG9qTVJZSGlqUE9TRlRkOGs0YUNucHZUaHVZRm5B?=
 =?utf-8?B?ZnNFZ2tCaTRXSEVReXlMTk9BaHhzVkloU0VURzl4VzBHdUVXcGZtTHkrM3ZL?=
 =?utf-8?B?SmVOM0pJOUp1SDg3d2pGSlpBdE5QVGI0S2FoVmN4NlJMZFBJTitYMEh4OXBl?=
 =?utf-8?B?a0Fna1RnYi8xOEFTeldMQ0J4a1pNUmdUME5rd21oenlBTWt4ZDhUMyttMzhV?=
 =?utf-8?B?U0wwRzRUTmFWdTBaWlVxdHJrNVBOZ09UTC9lZnFMTk5HWkN3M3pnU0VXM2dr?=
 =?utf-8?B?M1B4S2NKTG5BWXpmR3A4SUlkQy94Y0tyZ1NRb3BYY2U3dHIxSml5bmwybXg2?=
 =?utf-8?B?WXkzN01lY0lYcnhXZGo2SGZDM1dNbHN3ZUVjUHRGcWJXYVk3c3pJVzl1WmRY?=
 =?utf-8?B?bDZGeFQ0RGxkeTVNUUZCbTJGeHozQTZVcnBGVHhGQVZqdHpiNGU4UktwYkk5?=
 =?utf-8?B?SDNxbnNnL3NxekFsTHFUQmsyYVo5RnZZNkdXMmJkenZ3UlJWRnh4VVJtNzdI?=
 =?utf-8?B?RmJDd3l6Mm5nZFkwMVZpMklpNkFROTdObklVdGpEQUZjNitVdXdUMnozd2Vo?=
 =?utf-8?B?OFFpNTZDNjd4U2R6Z2hTYUVjcHUwcExWTytKYlFNZHFkcDNoekpSR2dWUnp4?=
 =?utf-8?B?emxNSjRXb3I4dlFGeDB1b1BUWitDRlk1QmVQbzdFNzAwckx0aTk2RzlMajBU?=
 =?utf-8?B?a0RXTStwZGkzb2ZybVNxZmQzM0crNlA4MG0wNEp6YXNkL1BCTUVKeVVWdWE3?=
 =?utf-8?B?Z2ZHWHl2b052NXlOdjhjQ3F5S01rbGF3c3Azd2FFQ0xKMFRBSVN4WDUrQllU?=
 =?utf-8?B?em5UTnNGYm53MGMwZi9peEduSEtlQXl1a3RxYjBUN0FISFpNSGFvanpJMXN3?=
 =?utf-8?B?Ny95bExmZUF4NWo2bDFvczlpUU1WbkZURXc2ZkNlVHpnaHZBRk9VWWtndTI1?=
 =?utf-8?B?RWd5OUZudmVneVE1dG9HeVNHQmhOVUtiWG9Ic29pS2MzR04wa3Jhb0poMWNv?=
 =?utf-8?B?amt3bTlBd2NhTXdnblNySGJNQlMxWitYMVJpTnRvTzlIZzlyM2NLNVMxTmRz?=
 =?utf-8?B?Y1RLZ1RrVm5IOEZrVlBpcGg1YW9VbUdYV21LNityV0FIRGE0MU10ZEpDVDlo?=
 =?utf-8?B?Q0VpeEJsbkdMeXZMQjRvOVFMMHAwRGw5TTVFY2N0aStxbmFWalhHbzdaaTlV?=
 =?utf-8?B?a2psdmo3b3gwSXFWcG5KZ0IvTnUxTXpqNmd3aDZmMTJHUXEwQW5uYW15OUQx?=
 =?utf-8?B?UjltRkx0TFhGdVBLUExPRFNXUzZVRTlTOXErcG5ncFBHZHhkYTV4ZWlEdEh4?=
 =?utf-8?B?bE5uNEd0YVZkcnNLamd6Vmx4bVVyRUM1eTEvQlFldk5UU1RVcXAyQmFLOFJi?=
 =?utf-8?B?TldXNHFGdUNTVHJpWmJkemZrVzNzbHJZYVhwakVWNUpPczBSOVpZbG1tVjJE?=
 =?utf-8?B?b3VLNGIveUx6M0VzWnNSZlZHekN3MkJEVG5LYVZ0OXowTjVvZEpxdHY2am03?=
 =?utf-8?B?ZXFlb3ZlYmF5YWpXSzNBRlVacjZ1K1ZYU1dOSHovZFBMdmcvSERkRHdlbG45?=
 =?utf-8?B?aTFMaDgyMHNZOUdJT3FmV2FTUTFLNXdVbEwzcTZ4L3JwZ05iY1k4UjFSYW5I?=
 =?utf-8?B?Qk5tMndOSkhHYzc3Tk1iSUU1anY3UHVvMmV2QlBwT1pCbUw4T3V4TXRJR3N0?=
 =?utf-8?B?OHV6bVRFN0t1b0NuQUVGTndIRTRRMjN0b0xTekhrcjJRMVpDM0tGTHlPMlBm?=
 =?utf-8?B?U0kwQmxnVE1FYXBYdnNCQjM5b1N3RlZZc2VrNEVJdjhVbjZkTW9pWG9kb2F6?=
 =?utf-8?B?eEpneUVtelZranZ3KzZ1NnB1dm0yOVRFN0JtMlVIUTI1Uk11cXJzME1RTmZ5?=
 =?utf-8?B?dndnekFYb1dFVHFrSkp3QjFDTUV6Um1hOG1uZ3E0YUVJQ0ViY3Q2Z3RpM005?=
 =?utf-8?B?ZDQ3bkR1OC9EZ3FFbzlURG5tNzc0YzdiSS9WeWYwY1NManZmZEdTSzFXS3RZ?=
 =?utf-8?B?RkE4eG1vV0pqT1F1U0YrNjVHdnNmdDdkOUJBN2VJRjExcjE2LzBBM3ZqY2Yz?=
 =?utf-8?B?NEQreGhZMzA4U3E5bEZTMnZlSDBOUlJ2cjY2WTRydGtZYVFvOHBaV0ZsSlBy?=
 =?utf-8?Q?iEVG19OEPydtitFKIZou7iHZj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gmidRC2Qoi+KJR82EfIa9gSKIpcg/3OZKiUYtk+1d6TvzAAYQF1745yYr16gdJcgE+wS496+jL/rPIyaltxjRke/Y5fw5L5OM3OI3VVaYs2iq+QwguSlucBgE/uIK2CQ0zL5k1yUtD1U9RXS4JFJvgDieeFAPZjMJJkVQ827CuJw2wsYpY5njPfeuUZ2A63KdkyFNyEnmTWpgAPEi1nt0Q0uphDhDgbFfHCrfGF3qFQ/jJ//5LU8h5mCctG3J7nPGo57UrLdWv+5PsJOMpuVJZLRdh76g6Qtyuc9yAfSW9k4ieYki2mdiOyXddz8LsoyRNn6N2/8Z75iF9ThI+yax8bE+wCN0Zq+2p4hKQQe1fkFTjfYT3H5LtpFSWuS+NtiNPxvqFBwwW6oNGnplbJAFtU3XtYO+YDxmPlnrQ4k5TNCPdAGe8LwH1cb2ytc27L6N7OS2SEL3o+XYdWYnjWSmo3uhC3WDiK8dJL4If5Juo+IOs0iVBdtuHRpXmD4bpcHlSxrjPd1++5/2FGYjnwDqyZbrIxA/U6znAsuzOcxgyOGFti4reeqo45Tna1u9m5v+fZExgks/jdHgIGgvobEXvCtAZWKR8m0w/m0lSfgBtBnsrcaqzZxacaWIy6bVJnPSGTNR1F9oNruxp+Hc+XQwwfS4SxXbpxDeeRacQh4tf4RaxFOc5kgYRbjgccbndCz4lbj0bfEspO70l4gK/cT6LbuyjlkQb0hWWOPT2OP5oiQR0dev5+SRsXMx5+T8lcEUNxIYDDRdvZoHCMFgg+e80SUdCSJyAbBU2upnSdjEbQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea71eb9b-25ef-488f-ff52-08db5ae782ee
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 17:10:58.6102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayc+xtnKy4WY8z4myxKtAZ3beY4TXgmjaKcgDCAPjNTaEdXjb8cdenYuZREApG8q6al8dkThNdEF/yL2sD8Ijg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4130
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_12,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220144
X-Proofpoint-GUID: Yzc5QDxFp0ZF5F90-M8pdSPTGEvewW-B
X-Proofpoint-ORIG-GUID: Yzc5QDxFp0ZF5F90-M8pdSPTGEvewW-B
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/22/23 6:49 AM, Jeff Layton wrote:
> On Sun, 2023-05-21 at 20:56 -0700, dai.ngo@oracle.com wrote:
>> On 5/21/23 7:56 PM, dai.ngo@oracle.com wrote:
>>> On 5/21/23 4:08 PM, Jeff Layton wrote:
>>>> On Sat, 2023-05-20 at 14:36 -0700, Dai Ngo wrote:
>>>>> If the GETATTR request on a file that has write delegation in effect
>>>>> and the request attributes include the change info and size attribute
>>>>> then the write delegation is recalled and NFS4ERR_DELAY is returned
>>>>> for the GETATTR.
>>>>>
>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>> ---
>>>>>    fs/nfsd/nfs4xdr.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>>>>    1 file changed, 45 insertions(+)
>>>>>
>>>>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>>>>> index 76db2fe29624..e069b970f136 100644
>>>>> --- a/fs/nfsd/nfs4xdr.c
>>>>> +++ b/fs/nfsd/nfs4xdr.c
>>>>> @@ -2920,6 +2920,46 @@ nfsd4_encode_bitmap(struct xdr_stream *xdr,
>>>>> u32 bmval0, u32 bmval1, u32 bmval2)
>>>>>        return nfserr_resource;
>>>>>    }
>>>>>    +static struct file_lock *
>>>>> +nfs4_wrdeleg_filelock(struct svc_rqst *rqstp, struct inode *inode)
>>>>> +{
>>>>> +    struct file_lock_context *ctx;
>>>>> +    struct file_lock *fl;
>>>>> +
>>>>> +    ctx = locks_inode_context(inode);
>>>>> +    if (!ctx)
>>>>> +        return NULL;
>>>>> +    spin_lock(&ctx->flc_lock);
>>>>> +    if (!list_empty(&ctx->flc_lease)) {
>>>>> +        fl = list_first_entry(&ctx->flc_lease,
>>>>> +                    struct file_lock, fl_list);
>>>>> +        if (fl->fl_type == F_WRLCK) {
>>>>> +            spin_unlock(&ctx->flc_lock);
>>>>> +            return fl;
>>>>> +        }
> One more issue here too. FL_LAYOUT file_locks live on this list too.
> They shouldn't conflict with leases or delegations, so you probably just
> want to skip them.

oh ok, that means we have to scan the list and skip the FL_LAYOUT file_locks.

>
> Longer term, I wonder if we ought to add a new list in the
> file_lock_context for layouts? There's no reason to keep them all on the
> same list.

Yes, that would be nice.

Thanks Jeff,
-Dai

>
>>>>> +    }
>>>>> +    spin_unlock(&ctx->flc_lock);
>>>>> +    return NULL;
>>>>> +}
>>>>> +
>>>>> +static __be32
>>>>> +nfs4_handle_wrdeleg_conflict(struct svc_rqst *rqstp, struct inode
>>>>> *inode)
>>>>> +{
>>>>> +    __be32 status;
>>>>> +    struct file_lock *fl;
>>>>> +    struct nfs4_delegation *dp;
>>>>> +
>>>>> +    fl = nfs4_wrdeleg_filelock(rqstp, inode);
>>>>> +    if (!fl)
>>>>> +        return 0;
>>>>> +    dp = fl->fl_owner;
>>>>> +    if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker))
>>>>> +        return 0;
>>>>> +    refcount_inc(&dp->dl_stid.sc_count);
>>>> Another question: Why are you taking a reference here at all?
>>> This is same as in nfsd_break_one_deleg and revoke_delegation.
>>> I think it is to prevent the delegation to be freed while delegation
>>> is being recalled.
>>>
>>>>    AFAICT,
>>>> you don't even look at the delegation again after that point, so it's
>>>> not clear to me who's responsible for putting that reference.
>>> In v2, the sc_count is decrement by nfs4_put_stid. I forgot to do that
>>> in V4. I'll add it back in v5.
>> Actually the refcount is decremented after the CB_RECALL is done
>> by nfs4_put_stid in nfsd4_cb_recall_release. So we don't have to
>> decrement it here. This is to prevent the delegation to be free
>> while the recall is being sent.
>>
> That's the put for the increment in nfsd_break_one_deleg.
>
> You don't need to take an extra reference to a delegation to call
> nfsd_open_break_lease. You might not even know which delegation is being
> broken. There could even be more than one, after all.
>
> I think that extra refcount_inc is likely to cause a leak.
