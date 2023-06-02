Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D972A720C1D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jun 2023 00:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbjFBW60 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 18:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbjFBW6Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 18:58:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F461B8;
        Fri,  2 Jun 2023 15:58:24 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352Hf5cN023430;
        Fri, 2 Jun 2023 22:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=psghQC2PugVseO+zcDhSZdwxQC6/m6fCQyqY2zgTn0s=;
 b=BEa++xwJr57lNV72Z2F4BJa2EROeFWI71OwAJCjPPUHT3BQQoW8R1BtJGP3HVVYUoiEw
 hM0DqTta4lJFe1+HF+VUsbKrkv+BVH5QCSyQ80NK8mfGPDS3X0YucSgIT6JZ0tmCuAVS
 ME5nXCuBRGoSY02iRoxESH+CmdDZ839t9ZkPcL71q9jKusrhnF88XLna5nhjhhsK7DnS
 cAecz4R4LOGo/2NVnGwSws9RL6hJqUnWPCCcOHHzV+GMxwcRziUDlHajOqq8TUwJgztS
 1glepDQNvBwj3XJgyHkao0oEBfHwOGjcAqms+O+UQ7QPP9pSkznrYLmlApX8Kd98nd7Q /g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhwwks0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 22:57:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 352M5WZ2031874;
        Fri, 2 Jun 2023 22:57:54 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8qdr9dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 22:57:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlaql7btlhCZDvfCpIcS9YOmW45wnBm9kA5taIdgdgse+uHw2TKk/2hxAnRo6mWA8Py/B1YeyWGNMYV5cqyIFMxafsK/vSsHRTi4HTs8PgAsVOiLQRQWle49xKE7WG1RWAh+08GZN+rJday1QO8HMGzT6/SKWZvg/Axp8jrnPMkPQNco0Th0DjM6PxWqfggiE5qyp32wU/fUS49vW6iY2n3Ta7O8Sz2hmOI57MxpTWHRNNGpTtwwuQ8XU04R/ulSK3E7O6E+GXoeVwUe43Z0ig92KLD8Jc1vpwAiwbQLt/kKG6Vx8CdGYNEXtUfDd7gNgThR42CjzlYGc1KNsorYfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psghQC2PugVseO+zcDhSZdwxQC6/m6fCQyqY2zgTn0s=;
 b=MLk1uz8iPHZD7axubBhZTw1vRr8518axiPFF6Y98Bp8F7dAx7n4CWyrxej6TBHiu+g8bmRsfCQSaC0sr5s1+WkHACEC2oVlCty0Gp8REHKdTCdxNOvi0ABWxGwOoxME7tOqsZ88gBjsJt8Wl2sK5abaZkALZIII0MGSrEnDJuobZS8100j7a13tNHS/tLIiHXKmsmKvlEVf1jKZGt5tqe2cF12LuzBTDh0vKM6edocdvHMKMMKa5kWWbWNvA/hlNteIj1HOlG7+T0VoUwZ1bntAEoWHyOXtvR+U/cQ/TzNq+uuktSDVBrlqXzDFDTv91t2QTwpPOaZqMKNrmu7NusA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psghQC2PugVseO+zcDhSZdwxQC6/m6fCQyqY2zgTn0s=;
 b=XtwkYUp3NGGCYoePGu76EM6JKIZZ+8s+nvw1dozJBpgCfA6i5OpJQajF/jkzFCd4hSleUUmtCM5t6kNVgbvstIax7EpWILdcDfNcFTDE2dq6m1tFGJ92BZED7mapmcKMlUbYNHtQ3u7S7YSoRXiQ/ZZc0euxF9ZoZT7Iv4wz4oM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA1PR10MB6519.namprd10.prod.outlook.com (2603:10b6:806:2b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Fri, 2 Jun
 2023 22:57:52 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%6]) with mapi id 15.20.6455.027; Fri, 2 Jun 2023
 22:57:52 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ackerley Tng <ackerleytng@google.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, vannapurve@google.com,
        erdemaktas@google.com, Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 0/1] RESEND fix page_cache_next/prev_miss off by one error
Date:   Fri,  2 Jun 2023 15:57:46 -0700
Message-Id: <20230602225747.103865-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0017.namprd16.prod.outlook.com (2603:10b6:907::30)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA1PR10MB6519:EE_
X-MS-Office365-Filtering-Correlation-Id: 49f00ed5-d954-492e-df82-08db63bccb7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sn5zlSQcwmnX9RJPWmlGX63w1lBIMrgyvoXbgPzgzeOZQB4rfvZ8Mrig8Qi6vfNikJ7dT4Vj5iLnnWLGUZ1GV32SCujTk9lSFTVn2RcES3lpCU6FcyiEL7fY+7a4rCvcXoloW5JXDQ82unrPtJRDsczJy1TPAyZBoSylFG8EsGcZapTK/5CKbEAGXXuGj0iG+Sow9DVjHSgiWC97bUnnikaQDKunQmmeEc/8YXhIvHZ6M7ICdXSPUxZYI5XIOUaEYmODsmh8/+rwCV/hPqiSe4y355d174VtzQzLTAD53hvHdXyibUtes3sfXr2F/EQJ0aVEirC4r445GK80PnS7IKT7ccHcWWFVRyG1yQVt4o2jfK9Iors82iiF2n93j4436CO5qlI78ZVIlDdKWl6HueqLLEGPApQ1A/pfjDA5taY2s7bG/NhKvoPjiDFfzP/djt/8HU81iyLsU1eB85htKjDRqsE9fhKsZW2E5HZhOvNwRdacV9hQV259xTrKnyfZ/iNQcdbewAXcCIZGkntqQz/b5m1ChmeSqX2iXGH81bpNsD3U8hg9wXdEfnDlREY9bZEM2Ld7W4J0X5Wav8jhLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199021)(41300700001)(316002)(5660300002)(54906003)(66556008)(4326008)(66476007)(26005)(44832011)(86362001)(66946007)(2906002)(8936002)(8676002)(478600001)(38100700002)(6666004)(966005)(107886003)(6486002)(1076003)(6506007)(6512007)(186003)(2616005)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YgKLmcSjK3f1AHmzJ946vgw4cNTDvIXrU0hc3wh8u1dCH03ImEw/HxGHds5x?=
 =?us-ascii?Q?SqdGAoAFyoDAdpWQ1D3FBP6v3FC/67aKHZbJRbGQNwVlrwxv4vIrOlb8OuXa?=
 =?us-ascii?Q?1Rw8e519peAFJMmBAS0UFfR7SC7I8tJCD9Mx+lNmPCJZsdb/PrAZgxBU4URf?=
 =?us-ascii?Q?YlVS1HLbjrrm6O9z6Ih5yQROLqtF5Lcj7AMk//63S5CcIbfpCFa+ePhfGfXa?=
 =?us-ascii?Q?qmaDLU4kRhP7O9bBULOMVkNjeImjFXf+/63/Be9pWdtHE71OqHQz6Nz/fZ+7?=
 =?us-ascii?Q?4AX9wGaiSw5fXxx30PQKodd8xCy3xslx33bjLIo+MxKJBXNZX0gNqriNCYmN?=
 =?us-ascii?Q?dAfwtvz35m/5iVi9mqnYZqrUAHoBMB73tBKG5slA0hW4Dbt3vC/zNNfls9FE?=
 =?us-ascii?Q?lL/3b+qAdwq5O/fVdn1LpLo8dJ/1mHWyEtMeAWwkw1E7qw8idw8Z/JZUNcI7?=
 =?us-ascii?Q?vRgtExFYRs7H8SMjXzb3q7u2pT/naSyIQniWU/1Jy/t0t/KdldJ62MTPrAm9?=
 =?us-ascii?Q?Ea6lATVmHW71uqsU3tvCYvu9bpPdjaHux4mHYOTZg5sRxdj+qbv5W5JigyW9?=
 =?us-ascii?Q?sxNTaR+XcP8Nnk/5blz/FRAXOpsqJ3Re6ZUU9JH/tHFq5eSbxFvMDwZBR90l?=
 =?us-ascii?Q?xdog/jgnz4yXrTDbDqKtT4c/Kc/bjpCtn78qbquqUV+34hym/Wi+Pmg7IBBC?=
 =?us-ascii?Q?ViXoO0oI53aXzoCX1u9W+55UuKFtJp5kTvQWMEgdbFPFTCqNtsP028LcGjt0?=
 =?us-ascii?Q?3ufxa4pyAG/xmD4Vp4uSyO06VGcPLgfOBsTbpg6QvGx/bIkliRecFpKGSwlO?=
 =?us-ascii?Q?9O1nDjW13OAM9zCS/CTaVoGmUhp0feeIc+BGZVwTkijkRL89FOTvnsG4cbdg?=
 =?us-ascii?Q?FfmvV22Pjiq9b+43Jedy1OWyhQ+TDuNTA4NpwyS1AVeAtWGIC9zyy5N+wU+8?=
 =?us-ascii?Q?RUSIDPuqv+Y5KbRz0akUF4bYR0CrvTd8oaSG+X69lwGoAg0jBnllMMHcU21n?=
 =?us-ascii?Q?DiPwhouIBXmVOrqshDPYneGlRuczL46RMJNmSww8x/yEHdfWINaN53hOYQM5?=
 =?us-ascii?Q?sJm43jKXWScQQjk77qO+ROleVrCT8KgH7sSNaIbMfh+M7io7ABAXRsUbBKhk?=
 =?us-ascii?Q?emortOOfzybnnoPiF2lb5KoaCnbGFBXbKZu4HgU6adIiV6aU4Qv+TG7FkzLv?=
 =?us-ascii?Q?gD+qfTSE8HO0JT7Geqqh6w8X16XIZIvjgz9ELKZogxwzPKaFSTWO4wchugnY?=
 =?us-ascii?Q?zs8m8JKhl/c1E/5MRlzcrloQx32HChHUVR+/31js8kuDqDToS8BuJ9uuLZ9v?=
 =?us-ascii?Q?7l5FQPHRFJE1iw58VTVCE7O9YavqhCij4N3JzBsMSAYs3fMyUUMKuGpwqQYl?=
 =?us-ascii?Q?UUXzLfGWFZMtPgfoRJukij+C5smfPJ2dhTO4dmRB3uFSsX+DEDnzHrDgF7iH?=
 =?us-ascii?Q?N3lsbQ79zKeZwVrwJ/DeiF4K2WmmoS2NZcF9aIAHz/it+e+9NOtxPl+TK4oK?=
 =?us-ascii?Q?OvxSrdArZUehyuLQ+RcF9bFihM2rdwbRCXiWBcmzuqfuRbSaFV4wP1NtdCBs?=
 =?us-ascii?Q?yVMoyEGCkevqjnkjUyRhUeHz40jhdZIGOAIQXsnu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?LdzIkVKyfmsF6eDEchr+Sb4ahBZBWWAhXCUUYPnjuD6OZpbA49d02bcPbrjs?=
 =?us-ascii?Q?VQLT+xPO/t8xNuQoev9FxpNZVhXOCEI3mbhHW6ix+N8dYhz/Yn22TnlJtGPB?=
 =?us-ascii?Q?ej750cooWypSRZxXvYoZg9KW9dXPyK2DVGzAPV5Qurs8EX/FV2xVt3jrBgAl?=
 =?us-ascii?Q?m1Fip3YT7sHCNy7GzCcB3y3xfI/rvCxTMZSfTsrSkuuqss1/hceK+LKSXJ1x?=
 =?us-ascii?Q?+YUcLDZ2VClTmtLtZwzCAeG6GAMOLP6OtDzzINPA0BMVN/yDF4i3mvcOc8f1?=
 =?us-ascii?Q?vP1BLZVc/1oF963F8leg0bhT8rnkPqVmGTTAN6a2jJ0pi2KphaWU2St9NFIQ?=
 =?us-ascii?Q?1z4rHLyN+Ax+GwiPDuGIuw1AcAUPoCsZ6lHCTf5EvlqMQj7qoaOdkcV6SIYw?=
 =?us-ascii?Q?nvBeyQi8FjIAGNjsfIPb5ebil2vzPIDIVzy5Szq3M2LtnSNQVsFBCRMf59Dg?=
 =?us-ascii?Q?bTl9djDs0pH29glhhKimlb66PYhV63vvLV4CAKghdn1GJ5GlZ66UbWMNZKQ2?=
 =?us-ascii?Q?tKjagX1EQXeNfOZhkj9B1tAUZtUe1Rkn5qT9BBtJlAEvnaiRiyzkMXPRGXHB?=
 =?us-ascii?Q?bDTCvgvmxfkKTiziVt//eLlHXxodlEyzhXrIIClvA/nDBs7z2qB2hKaWG+6w?=
 =?us-ascii?Q?Ei//qB94chsSXVfPXkxIZJxdcY60nO/nPyexIkaK4hY00m3RXca4tGPj2Vse?=
 =?us-ascii?Q?qGdij0na+qoXRitfI53epJITuUIdGvBmHB6FkRiTv37L1fpms5TDyVmWQ1YH?=
 =?us-ascii?Q?FWCZOqBWWGIoIcO6v43G64CwrkYxqw/zquMJ0b5VFEkfDz5WngteegNjfdhT?=
 =?us-ascii?Q?ngkRxr34+9xL/aAuDoeKnrV4Cy2ZokG0w+QorQmg5IO2YTKjNXq5bfvY4nuV?=
 =?us-ascii?Q?T4AzhWWNLnyfYnB57ngF/W6MoBCYbMJK8CYoCL4jKjKFmkuz8E8nkN4bsnua?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f00ed5-d954-492e-df82-08db63bccb7a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 22:57:52.3482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3rqQr7fzBfqdlrQFrr7ZhTecnfwyYeGKV2fJ0CP+kb43KD3nxYwHnUEAxev/CuKkBVf8VcTWNLP/pwgX62jsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6519
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_16,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306020180
X-Proofpoint-ORIG-GUID: _9I5eYXneA6XhXO606YB-PDP4uHW0axE
X-Proofpoint-GUID: _9I5eYXneA6XhXO606YB-PDP4uHW0axE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In commits d0ce0e47b323 and 91a2fb956ad99, hugetlb code was changed to
use page_cache_next_miss to determine if a page was present in the page
cache.  However, the current implementation of page_cache_next_miss will
always return the passed index if max_scan is 1 as in the hugetlb code.
As a result, hugetlb code will always thing a page is present in the
cache, even if that is not the case.

The patch which follows addresses the issue by changing the implementation
of page_cache_next_miss and for consistency page_cache_prev_miss.  Since
such a patch also impacts the readahead code, I would suggest using the
patch by Sidhartha Kumar [1] to fix the issue in 6.3 and this patch moving
forward.

If we would rather not modify page_cache_next/prev_miss, then a new
interface as suggested by Ackerley Tng [2] could also be used.

Comments on the best way to fix moving forward would be appreciated.

[1] https://lore.kernel.org/linux-mm/20230505185301.534259-1-sidhartha.kumar@oracle.com/
[2] https://lore.kernel.org/linux-mm/98624c2f481966492b4eb8272aef747790229b73.1683069252.git.ackerleytng@google.com/

Mike Kravetz (1):
  page cache: fix page_cache_next/prev_miss off by one

 mm/filemap.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

-- 
2.40.1

