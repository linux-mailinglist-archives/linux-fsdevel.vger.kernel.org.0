Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0014E7392CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 01:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjFUXCh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 19:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFUXCg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 19:02:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6689A19B4;
        Wed, 21 Jun 2023 16:02:35 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LKO7jI030796;
        Wed, 21 Jun 2023 23:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=FCYZXG66N8Lues2oZRu5cMRF7c5HpoVM2d+HYdtNv5w=;
 b=GZBLcCQWEM61hgNw2Q16AdsZFohgGeR4F/mc/75Qut0/3xpvD71mTp1bZIczTaHrxknV
 BM2coSUAOsih7UId/V+c/ZAwyE7xqHbEMzmRhdnpM/zOgxnKeKVyiKitGK5HarDhpgmY
 wY66Kx1wDy9Q+2PdCREsJZ13on+EFRxkQffb1ZLIq56hGm9EDS1kdWl8HA25pHCkBvX9
 Kw6IbBJRhum9VFLvoulGySz6F/Vr1Zn337T9nF6RU+3lSiWmTF5KWHA2ywrdYMFieoqq
 MJyNlw4hIwi3sAsEziN18RVGBRQWuaijkJc+t9yhifkoHLN5xOU2LZ5Whn3pYFjOHzhf nQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94qa8gg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 23:01:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35LLftcc028849;
        Wed, 21 Jun 2023 23:01:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r939cq7ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 23:01:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fy4A/muWrFaoWd2ImnLZ92TLPVU2rjvnd/Ku2qTtMABVO/h6HH/BzsgNDj1A1/UX4qDox3xHaC5OSPZncMIW4jbHjdKYLvqsla9jMXAMycpkT6LNL3KCWsrntsFJWSHsPGyrsisvfzuJpd6fzRmp+0MFUYFab22hhtfSJmTFwCr0FEbh5FyWzzCJGra6iyXA9hMxtjqf0w46a9D9cus+DAa/03xistqFEPYHcsgfGYCJaX6xGRad7vdV047GxABvuwdfp+KyuWckxBCaW/SHZUGZkHZGhEJQQoGU0TnUe6SbAJJNk80/B7IXRW0iCGWkbWf2ZX2LJ1V3qVlXWfAPPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCYZXG66N8Lues2oZRu5cMRF7c5HpoVM2d+HYdtNv5w=;
 b=P+FtA5oRH7z4SZ/yUznmmdIRFLxW22FQ9jCBesA/70UhkdHl2XvjPR9e1XUHKWJUyeylaO0+6zKLhIEtzTmPb11ctDFOvrzsSmDSrwpoGC3yD+7BrgBUzwsPtvT5fHMHaPw6qzQL91Fr18gsq/JThLB5qcmg9YWCZ1nmOA8XIMVN8xndbb4R/UjPNlyVqvPgDzPJeQIstHJRvACUos/KNtGh/AWWXaQ19SmebBBAtl99P6SmMzJgUfA3FtK/tabBM9GafVoUdxgoAfqtF1J3VuGPgI7IcIWaMjVoHbUF2tDCUq7R+ReB1UNfyq5hBgflUoJvqKS43yNKcN1Ehsun+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCYZXG66N8Lues2oZRu5cMRF7c5HpoVM2d+HYdtNv5w=;
 b=DWONbuaqu/IEQPWUWwHhHetPy/zvj5gSt+gJFcGJEtwJ016F32sk9qxBWgthZB30lMQ6QDuR6QS5t3RT5KEzdfPdOp4JvojJBR5IsMxR4K0GAYGpGMd3p7r6Fzwn5AI33/VApddAZlxiYWZ+V0NsVzDk5dJS5ukNW5k9v1up/4A=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB6462.namprd10.prod.outlook.com (2603:10b6:303:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 23:01:50 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 23:01:50 +0000
Date:   Wed, 21 Jun 2023 16:01:47 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Ackerley Tng <ackerleytng@google.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH 1/2] Revert "page cache: fix page_cache_next/prev_miss
 off by one"
Message-ID: <20230621230147.GC4155@monkey>
References: <20230621212403.174710-1-mike.kravetz@oracle.com>
 <20230621151855.318449527a851cc0bb62fb34@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621151855.318449527a851cc0bb62fb34@linux-foundation.org>
X-ClientProxiedBy: MW4PR04CA0190.namprd04.prod.outlook.com
 (2603:10b6:303:86::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 509658bf-03d1-4062-a650-08db72ab7f51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h1lumQgl1O/yLRlL8zEnsymmzt0sJXhWADO5DsaEinu5LjLuwJX4Y9OybWu9o+ELm5NDhMsrV9oteIot5lzKnb9HuT4I/nnVDKoUtOloV7ardQ7aBl1j/JWg1Zt7Q2QQzCLVurWlkl9yOMB3y3ulQSKVypnGWtdEsi55zdquVcqRMdoGbpDsnECe06tn+053Gc+59DmfABe4ax4Ftv9+0eOCrXFCsyPJv1ImTfkgF44B+CcrGBtnFUTMQixfGWI4kDYPrPaRYrUcd7pS8H4YCtUvxkeneI88seu/kCY0bc9YMLG92qgomVDcgL9HzvdXYD5ByczHC6RQJCB9svFYhYUsJd/a9CXB4GJdfO2APEcAujH2sWGQCte+sJkMQJyWIoMfgBvgqWi3H7mAkpCRj0KlHVtky8WM0I1aT48qaae/DB8rVpD1nHrM0W5euWOiQQ0WcOZBgtJrOHrfU5HvAv66daqTmpgHLjzhwoCTwUrKumjuYalMHK6UxZfPYIBqDpa5e048U1weF5lYtbzozTnQSWVuWcq7bHFF1MXs0z0I4LT6yYKCu7CLkieBpvT6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(33716001)(478600001)(66476007)(66556008)(66946007)(6916009)(6486002)(4326008)(6666004)(316002)(86362001)(54906003)(6512007)(26005)(1076003)(6506007)(83380400001)(186003)(38100700002)(53546011)(9686003)(41300700001)(2906002)(5660300002)(8676002)(8936002)(33656002)(44832011)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hYvB0jrnZw5+f1i9cGY2PLrMZ6CglHzzsz9aRConLqJHFbmHQ7CphTVYcmWV?=
 =?us-ascii?Q?3GWD6phmSRCfzOSSX0P4xvkQQXjKtxopmaUqCTgsCkLax0NC5rj5bH0acD16?=
 =?us-ascii?Q?VxYQS05ul+I7N3miSsFFXPke/Lp31gxTQ4JcaEcAPEvQHFcmhQfW2RIG6Xut?=
 =?us-ascii?Q?PIKQhA/kPbYwHqs4BT41CUVpb5DKK+FImAaTMWQZCfT0G3RVIWo5pyQKhWPo?=
 =?us-ascii?Q?aw5noEsJ3NErJU+ZTLNDi5zWZ+qREU8SKqTSY5BLs85skCef3JzxggUsxAHR?=
 =?us-ascii?Q?3sBjBREBPmjAo1R6dRAQ2hVYWmVv0pZjfSYdZ4DWWOKkF7/s2LBOooKgOPX1?=
 =?us-ascii?Q?gZGr8d3c07qk4HnyDeFr73feh/Ox7ESMr92LHe/dEAIvABcDwvKiUpXFyMkR?=
 =?us-ascii?Q?Iu978MUgms4RobJq013ANvjJn0R6zqBrQ3IM2AiAFpY+BaueLsg1CaVssXhm?=
 =?us-ascii?Q?rsXbn0GrjKDf9wEdgCIg+nQN04V2B201f++rSp61QHBTWLD0U1xM/fAOajyY?=
 =?us-ascii?Q?RD+AA9KmCI8rxNBaXxGH98uYJXveoX/qZDLdu/AoPwxOhXJcrioSFKaQFUtj?=
 =?us-ascii?Q?bgFw8rLg9S6OKJpdxqO1B1TmTxf/7Qz0N0PvmRwcExz2o9Dib45SyliaRN4q?=
 =?us-ascii?Q?DHwdomgzolCPEI55ILVkWXcGJNK4iovtMLdkZak91MFUDbfojzKwAyDXRC6Q?=
 =?us-ascii?Q?l0E+vHfQMqJD4LbTtHdmlMT5W/I67XYWWgKPA9NKz90Hy+07BTMubEmi2MtI?=
 =?us-ascii?Q?2xZqHCqzAK6ssTLr8Bpdaa09VJ7A8ibIIf9Chb+EJ66f8uz1Or+jTTEryqcP?=
 =?us-ascii?Q?9QXEFcK8WI0ItcgH4r4HWV7EEXKzKACuBkc20TEB80EtYIu1Z3jpd+n2lTQy?=
 =?us-ascii?Q?vQXIzuar+Pzg7ikQINmj3/pt3dAbchk7sRzexAiJlgGVjTAWklptwx1cT+Hq?=
 =?us-ascii?Q?NIMR2KgwJlWKDAzbgAaY2nM/vsfS5zr5MAonV5WXfS1bZulNPftkWLqHIaAV?=
 =?us-ascii?Q?vmoiAC51/6YyBZyH7xw5YggBboQZjl7OZcYWh6Y//wCkQc2ttsl8P3pwaJjW?=
 =?us-ascii?Q?QyM2WdTsPdX4jMkDEXUiD/l5ASSdMrUFogFdJ0cTDSPyLMdT4N0x9gQOTdsy?=
 =?us-ascii?Q?ovk9vQHp3w9n1tDuxMAH6aEymSnfRyxs5oUBdBNrQTy9CD1RURVf+70/P8MK?=
 =?us-ascii?Q?Z9TmvVuAkK64Dbh1oYa3SK3nWpHImXwPeVDQbVC6vJ9TzdfRwiJ3EY2h1Kof?=
 =?us-ascii?Q?/C9pw8MevXUNOiKANPX1Hyark8N49mU+TSrLdDPn5EFUKUqHxQ2xnTlu+D2J?=
 =?us-ascii?Q?SDmlZBHy/QcOaeGcuHBkiaryBOUky1zdCYfLj08gTnXC6USI2V7SmFomLojW?=
 =?us-ascii?Q?jgoOJ/bpF5ndkhY7XO3sNGXaSlWb8etiSztkJsvpfZTTUYT4eF9GgxxB/wdf?=
 =?us-ascii?Q?hiScWz3B7F8f9SCFPgXq+ivcu3TfV/TNHfvngCC3V9SQeG6zIEOvAbUvhes9?=
 =?us-ascii?Q?TbZj+YoLOLXoHRG7n9A1tUoG0rkWDHqebqZGVO9Pg1gqkGJd4uYsQGtgx06j?=
 =?us-ascii?Q?Osx+yBulh4ODxpTmaog7AEWb49MI8Yn4qMa2UxoQlU0yh7V+q/A3phR8QN0A?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?wX9ERk9115D3YQJZr5RHTB8LMEu7vqCNfMi1dCArjseLIcvwkH6Kvin+rWc8?=
 =?us-ascii?Q?HOxMlZjvFcx0qG0U3UNRkN/koRJEi2369xv69OSfaMx01DE7NsOxxa+ez4kL?=
 =?us-ascii?Q?dXSQeXmjCyEoZ/El372ARJm3MGVBka6mtOKzPgs+dmEqu/EK3AsSbWI8qA2k?=
 =?us-ascii?Q?GgmLAWEskdZMlqqcbFytUzdNzEvdhNbfqcgrLGRMzS8UJo+h9XesYgCAI+7g?=
 =?us-ascii?Q?s45JkWX7b5b9mAFPFvq/5APdmuEC+BUx1yCt/R5i8RGQ4iC30FYkTImW1Q+/?=
 =?us-ascii?Q?7ofipmWm34l7mTy6WeDPBGOf+8aEK+/1iV8QTZfnETQdV6RmE8q1vg7NbpUb?=
 =?us-ascii?Q?hi/c46X/oa30Kf8jQYWalA3IIXFGw3W/ndzw89/RwUk4mEqSn44p3jsUcP9J?=
 =?us-ascii?Q?/IiyUsc7kmmBMgJts/HYgrSK/G8UF8eC7l7wLJ2n6oCmEUTYoQmJlVcyIEne?=
 =?us-ascii?Q?HEPamzCp0XddB/MQfYrSQv8OKQhVBYX8qKVjNYm38NZaEzIQjbQcRVvJc3Lf?=
 =?us-ascii?Q?LrMkD7Kidu67TGHL/3ZbX2GbZBbR2V+25e4sTTJIQ3xoPjEJpd2veds1pwEj?=
 =?us-ascii?Q?AlOApOxxtyztxnClvFvA414LIwH9SV88P3zph+5nb+9uooHHxyT3cNwMCCHQ?=
 =?us-ascii?Q?s9SIgcLwXbqy+Y6VlUIp1v+h9iPCi7TbZ4YxPX6vu4UJQi0UEgUhLGMRCsVc?=
 =?us-ascii?Q?gBJXEgoT6XxyjN8x/W7sN7UGiynDiMSk/NEsqTVuASFiLBz0C0TVnyuFP8mT?=
 =?us-ascii?Q?kOcR2GloTiFTTAqdndUxDbgGLrpesMDtu0HujcpgWZ9L269ip9Yx+gRGijw9?=
 =?us-ascii?Q?u3ZAARLh5zMpm118fWUeZXoZBPEWoXxFGw8WjyGuTbWXtimCDz1gRuFVu4cS?=
 =?us-ascii?Q?64eDkfOHSVW5jxkFJyWERwC1ufPlbs3YkltPxqOJvA6wDFPluVwt95EvFREx?=
 =?us-ascii?Q?OcMfdleQWhj/qUCH6FwYnZLsq4AQkWsz6Vh+00iSGxlPcXgIi3xV9OKwyoAb?=
 =?us-ascii?Q?2iI1yI3m581U1DBy89dH4QtlIw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 509658bf-03d1-4062-a650-08db72ab7f51
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 23:01:50.5526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4201SO+PS4Yy/PeEub/IR1bgpN5SHqa91dM8IaiPwc7Uy57LOUOFZyUKc3hCU9AjeIX/SwIlc6H3Mpb9PQUHWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_12,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210193
X-Proofpoint-GUID: Q4osNE2FOF_UuByBuso0v0JdhZZdqYhK
X-Proofpoint-ORIG-GUID: Q4osNE2FOF_UuByBuso0v0JdhZZdqYhK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/21/23 15:18, Andrew Morton wrote:
> On Wed, 21 Jun 2023 14:24:02 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
> > This reverts commit 9425c591e06a9ab27a145ba655fb50532cf0bcc9
> > 
> > The reverted commit fixed up routines primarily used by readahead code
> > such that they could also be used by hugetlb.  Unfortunately, this
> > caused a performance regression as pointed out by the Closes: tag.
> > 
> > The hugetlb code which uses page_cache_next_miss will be addressed in
> > a subsequent patch.
> 
> Often these throughput changes are caused by rather random
> alignment/layout changes and the code change itself was innocent.
> 
> Do we have an explanation for this regression, or was it a surprise?

It was not a total surprise.  As mentioned, the primary user of this
interface is the readahead code.  The code in question is in
ondemand_readahead.

		rcu_read_lock();
		start = page_cache_next_miss(ractl->mapping, index + 1,
				max_pages);
		rcu_read_unlock();

		if (!start || start - index > max_pages)
			return;

With the reverted changes, we will take that quick return when there are
no gaps in the range.  Previously we did not.

I am of the belief that page_cache_next_miss behavior did not match the
function description.  Matthew suggested page_cache_next_miss use in hugetlb
code and I can only guess that he also though it behaved as documented.

I do not know the readahead code well enough to know exactly what is
expected.  readahead certainly performs worse with my proposed changes.
Since we can easily 'fix' hugetlb code in another way, let's do that and
leave the readahead code alone unless someone more knowledgable can
provide insight.
-- 
Mike Kravetz
