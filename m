Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7075A73916F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 23:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjFUVYo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 17:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjFUVYm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:24:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5772171C;
        Wed, 21 Jun 2023 14:24:41 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LK8wm2030299;
        Wed, 21 Jun 2023 21:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=QDEMuUJ+6lnBEGBCfZ8J5uE9zWyrVmNPnhHI85BkBA4=;
 b=uVjqLnF+Wp0WRR7/25dviap71a4eiV16te2CLf5cBrqsNQoZFl0fAKOccgVKSkJuKkEO
 hD47o7AdDL9Wbc7dUYQyCa+6PZ6an1MsKhJVaAuE72ZX01Hl/bBHxr1jwk5udC4kmqMO
 4Bg3QFrk3ytZqbhncZdA6bkSXIEwGwno9O9xWEPNp3y3sv9ODAOI3/rtMQEdgwgZr6ta
 snL8V3yoNZPl64GBztOWYfnNvr2ILkqvYO1UulF6OdRNj+rnkmcbHFfXFgwMN1bL+LLX
 kxdY+Ha+qWbH57l+PEh+A3gXzPojqS0mNJdXfvLRRweDcjZaxDMPDmdJ0h1/xpDLx/AG vA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94etrjqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 21:24:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35LKELAU008401;
        Wed, 21 Jun 2023 21:24:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9396vuvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 21:24:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJ6MWvijPBTCHzxpntXqA1PktqdPydCCanpE/kv0ehJzSwUUnjfpqUX7lCiApzjQbaMhSaUKwpi7ViPdrLc3a5rCZw4XajOzaH5cKCSPrBSOlgozlSUp3Q9kZn9UowC8LBK1nK4ie0j9bYsthVjxKz9mJGVUF7VCOzMdJ19R1gy0Gu29f5AJkRGAlvCMA10iG0p1mgRleGWA1cx8yXZzBdEul2y+O8/V7ut/0HsW0ZEWjGOu6kem40P58Um/Ofe8G2hneUCsNwSZ3okiuWIT4sG4iXnaMvt9JN9tV6nWeH95DZYNaijjigSf7P5v+pra8z78WfASACakGl5VBH075g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDEMuUJ+6lnBEGBCfZ8J5uE9zWyrVmNPnhHI85BkBA4=;
 b=Wr/uofxDr/lAxIo/j+zHyu0lPNrHVQSV4FIaI4lUxAoOxQT0VLPbOR7xtWwOc2bSw+hOp+1wwghheQpQFv9oXYdhl/k2FmO6vBTv8Ogke9/VOpwQB3e6k93v3jchQ25Xck/0eKyeT5FE8Qux6pvMLVcJRgQH7e0zlFhmNPVUK3sjWkj3UZNb0XyhMarLynCmtF9wFLS+XsK+ypzO90Pm5gWJDcR1P/J0vbmZ9EVFoAXNKxvghVvaqoqrKeyW9TkRrgJz0e8egPfomv1z09Wl5AAR6LSW72+mh8JUCdYKMtlEvXQkWxzOKsNrrAnbujQbiG1WMyt7PpFbRGTs9AavTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDEMuUJ+6lnBEGBCfZ8J5uE9zWyrVmNPnhHI85BkBA4=;
 b=HtkTpF02I1uWyKWQSx9D9gSA6B2lf6rHGlCRy27X744yTR0f22nl7/7vZUhlNjyO2o6kS2JdV0UDEptL1Y78HOa6ELXPhCLG+S9Wkavs6zTjE2Eyd/B4i3t5+uWiiG93XJ/GCj7kDRtK31RW6zPN0HEhRNyy4nqGzHno7SaL1iQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA1PR10MB6220.namprd10.prod.outlook.com (2603:10b6:208:3a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Wed, 21 Jun
 2023 21:24:10 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 21:24:10 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ackerley Tng <ackerleytng@google.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 2/2] hugetlb: revert use of page_cache_next_miss()
Date:   Wed, 21 Jun 2023 14:24:03 -0700
Message-ID: <20230621212403.174710-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621212403.174710-1-mike.kravetz@oracle.com>
References: <20230621212403.174710-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0147.namprd04.prod.outlook.com
 (2603:10b6:303:84::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA1PR10MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e90415c-bee0-4b01-7404-08db729ddaa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MzgimsWW/T+oPqS4bO7F+6cLVET+SkVsJzrlTm/7G/uXFK/Rm4ecRyiWKCr8Z0pwqNrx+bAhXH8UMKB5XQsqG8qGB5a924OSej/nBHeMX8EfBBQB1ktB2g9s/utU9OuEXVjpBspfYpYPxkz6PmI6OXNntRTajR3WlUIYCmnTQW63SFBmR2D3mBgHWViXu37Kl/pUdqzavptOo85+i5a5cVMRoaUd3CFxTmYS2dg3CYhAEr7d8BGRTDEkm6qZjP2PtDWK728kB/rXoDeg8RH6ZEc71jL1+h+sC0MTgtngKuzQkmLycVIHi4BEuS2425MdbOrRsL4MSRMqupYPNPiHu50dcEqJrnW+Xez5whY8buny9zqYDkvVob58vnkJE5X7ZTb9ivC3ArQ42ykVr6YOprHG6H0oE8eEfXsStNbX5X8o9ZhpLD+KnHMJI8pWrPa2bNW7BtdE40MOLSC0KACGrFagIj0vCdyfgAIqHjgE7TvcWUgN2rhPOFRMivDkF1QfAbxIyohQFn/0FGO1PaeJQrbRSl1EhaPj62BYWJWQRZs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199021)(38100700002)(36756003)(86362001)(966005)(478600001)(6666004)(107886003)(6512007)(8676002)(1076003)(6486002)(26005)(8936002)(6506007)(186003)(44832011)(54906003)(5660300002)(2906002)(66556008)(41300700001)(4326008)(66476007)(66946007)(7416002)(316002)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0HnVqi2U2saheiiNLIzqeoRiHr/6e67oP3DfETxDfhDWqZ/Vx7G+R5CBTnoK?=
 =?us-ascii?Q?nRFOBTuWYmBUByg7hcqta9gwq67VHLlLnqmuJyoowNrg9lHjtQ4b1Oym9eri?=
 =?us-ascii?Q?zwKDH5snVAxG/qrdUmM4HmQ48e24x0swSVqIENqdZLEMzn0UHz3W2z8aTE+G?=
 =?us-ascii?Q?OEkDeGurH1dnJj6xRrxiCnalh+GYK1cuc9nA1sMV/EdbLGMQ9wr6ea5tXKow?=
 =?us-ascii?Q?+7aE1VBTapsHyc6nbk6hrmaanE7mWEmPBMQ/pkRGQCdTMBuMNo03hmJbbFF9?=
 =?us-ascii?Q?pnQvm1NhvOjmZPkT2DB6hXvIuXyuX5BC8erfzv034X9R3IipWHY6C0wUGE1N?=
 =?us-ascii?Q?JizazPtZvi1vMccExLPh36xtAnZr+t5dIco5pv5m3Ix69kqnM/21fSQwpu6J?=
 =?us-ascii?Q?DkOsaqSDeMEKPW8dG1Sc/LCfT+uwb4T2qZQoOKKZZGflXp646Q8n0jQuOakK?=
 =?us-ascii?Q?rPUxZ2wJ3JdwEU93uusRpaSB+GqrFMSGiwVqGTuuhsR6knn0xFeoA7QsCeCf?=
 =?us-ascii?Q?Fugsp+8YSdy4B7qEryH3fIpD/BUjcwbD+FA0sPrjynt3fkGWhzYvGKteGirZ?=
 =?us-ascii?Q?cTQzSJ3M4+yW9XzWb3rFNM2neMagQUI/UGo/uzNgWWCyKEXpKzZ+Z+YsbeDV?=
 =?us-ascii?Q?VigPcewR4aLvCVinq0Gy+shaqqAPa6PUjv+/aS3eBZbpxPd0C5of//b97d8m?=
 =?us-ascii?Q?KyHXBWgMqBWKZaZwcMvu9WXMj98SVSHVd0Llleyjg5tVFzwxSKzcD3is8o1+?=
 =?us-ascii?Q?krGy1xRFYOTr3NzRFjMOBnJIw4sVF3fg92ocQAyQAIml7yFCnS/iNRnUjEXR?=
 =?us-ascii?Q?lrPWNzOCNJ21kuijviFoZkwgLckkCLUcwfjYWzdRUFCfZYvtCJ5IeEbyHC+z?=
 =?us-ascii?Q?nsE8GiOWhsO2OdIJOy7ZZVgMEntABgRPezrKAZhDx88T4h/e6bMjA5xWsWi1?=
 =?us-ascii?Q?pEDUdS6DMjfXLYDyR4xGQcrDKSb0NDfO4qgYM/5708Y5HBUPpgcw6aBlVU0c?=
 =?us-ascii?Q?7PMZqqdKV4ZrdUP5Ld7adO0hmwkZfnAg6LAgV8e2jsds61tEIzMAajxFcz4q?=
 =?us-ascii?Q?r2Gy4wunBItlWjD6JF8Zk7MPUBMYByZyZhoq8YpbDmu7zQk5O5v6MbYpLzyv?=
 =?us-ascii?Q?2g3vBHw/b3GbFkepeU5tGgEFwViOmZHLC7PNklnkl+5aLRsbudPP0qGIZaGQ?=
 =?us-ascii?Q?2Wy8NhKFgX1gnwaUgc6WiWv2/0vN9dwwyGc9Z+oszhNYot0JZ1cZXbqxfwSU?=
 =?us-ascii?Q?WdX5YbhtW26ggwmvwrZy+YkGugjEJku0cpFp7LO6cGQBcIL6a/ACG5godPR0?=
 =?us-ascii?Q?rKCFOwgiojy5LOUBMsW6ZqhUzaYi+GyN1DeKtnYdPV4AH7QWi8Qf4dcAP/ci?=
 =?us-ascii?Q?DvScDBtV1a3KH1y/qDCpwVI2P7Nb0zh+XXwerX8ek1qvhTIa1v+kZooNRzxO?=
 =?us-ascii?Q?HPEVxOrf8I+AOBE+Fcn3lyaySdcWKcbdNN29PapHIHm3fTO2u780DV4M9z3o?=
 =?us-ascii?Q?3O41XioQ0wGU3X2NeZem/jEq5Ht8toNrb43ftW4taMp6NPBub15LuBRlFrsc?=
 =?us-ascii?Q?yvpaHQTKfL1fLE93tKURdj4rIWMaLcOV44VE9yBwgFbSrzDEh0wHOPJvszPt?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?k5mHRj1KHSQKcJQjR6GUSmeu8guTiSVQx+UbiBcxduHPQbZ5x8jSpHFmhahI?=
 =?us-ascii?Q?JomN4EQBGz0QhMvrxLIpcLWQ605Ql2GdA8OqdPXAt1wMODYTHy69u3JNmacN?=
 =?us-ascii?Q?iuuvPleNycb1kyqq+9Df7neKcu34/Gd5AQKBcl+llORccoM570gC46ovdSTt?=
 =?us-ascii?Q?TBED2AY2kfPQlWhkHolWXtqm8T8vDm6tkaxuH26mnY7RKYaKtvAMiJT0Ldld?=
 =?us-ascii?Q?DT7f5wDBhYsQM9vi6KrvshmC07Mi2uo/O9+td7GfH4Bb5g9hXP+NTQ6pefe1?=
 =?us-ascii?Q?8ppK0r4Da0MDDdt6At1V+qz8oiKLGK7TzDTWUxG6tvNPeiN+u6+scBeG2ymQ?=
 =?us-ascii?Q?PACmC5L6QKNj+vz4e/SVHKJ7Q6HzemxNXyeCGQIKTC0hVuwT1WwOnBosghuK?=
 =?us-ascii?Q?/GeVCnRcvNVpcikMmUXQ5+ElYxkiDaC+tAXWbORgO3uavdvOoUKPeHUu6zKn?=
 =?us-ascii?Q?Cx6ERnCFKoO9UDmVuQdl1+Px5yXOJXLy4xygUmIF7wf77+FkY082ulNO6jf+?=
 =?us-ascii?Q?E+FmKwhqovwbXfi5+7P8oSXlVAbP5QTtz5wTj3vEA96yTUlGij8QVm1Maw6M?=
 =?us-ascii?Q?NVLOzUFkIgpXzgjAzpIgGZEF5BxdoEqfhecDROA7pFdDN/Tuzu8h69gA585Q?=
 =?us-ascii?Q?ROOxJhbWB09B00d6FxkfCcTfj82Vq42F1NyJRv1mV5s5YqPEwwpplsraQFax?=
 =?us-ascii?Q?ru691s7JrQtE/oId8jyxO1a2Zuqesj6P1jmHMVRfWxsTn396QXSlPCGDTSOc?=
 =?us-ascii?Q?6nDEjlfSsMBKxHoUv/Gnv/qXknjE1g71LKFCKvWZBvjpE+iSunnNYrcT0mX4?=
 =?us-ascii?Q?hpKPZzt2I2zaN/n/xGgiZPmJuBjjkkjLNd0rzBhZVtu6JeUwOrjlbCvbFdHy?=
 =?us-ascii?Q?vQepkSUfz9KOc9Kjlsrmh63tKsRlK36GzLY0Kbcu/H1LRTzImkcSNojkNpLK?=
 =?us-ascii?Q?YZjRRdLi3LrYlrg5euswPkm9vYdGXsO7HE6k2SHTILslKk3+hQ3WFouTYTzB?=
 =?us-ascii?Q?duH+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e90415c-bee0-4b01-7404-08db729ddaa3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 21:24:10.7832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09CvwoHW/gih74KT8jQ7q76+Ucxfc5u8rPKEBFzK1MXjYcySib3vC0KonNNBp5DXaFSRiBSt9OyBXvPH5CIKFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6220
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_12,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=831 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210179
X-Proofpoint-GUID: yWqJdaBS1xb_N7XkrjFbud3Ne_FGkKHq
X-Proofpoint-ORIG-GUID: yWqJdaBS1xb_N7XkrjFbud3Ne_FGkKHq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ackerley Tng reported an issue with hugetlbfs fallocate as noted in the
Closes tag.  The issue showed up after the conversion of hugetlb page
cache lookup code to use page_cache_next_miss.  User visible effects are:
- hugetlbfs fallocate incorrectly returns -EEXIST if pages are presnet
  in the file.
- hugetlb pages will not be included in core dumps if they need to be
  brought in via GUP.
- userfaultfd UFFDIO_COPY will not notice pages already present in the
  cache.  It may try to allocate a new page and potentially return
  ENOMEM as opposed to EEXIST.

Revert the use page_cache_next_miss() in hugetlb code.

IMPORTANT NOTE FOR STABLE BACKPORTS:
This patch will apply cleanly to v6.3.  However, due to the change of
filemap_get_folio() return values, it will not function correctly.  This
patch must be modified for stable backports.

Fixes: d0ce0e47b323 ("mm/hugetlb: convert hugetlb fault paths to use alloc_hugetlb_folio()")
Reported-by: Ackerley Tng <ackerleytng@google.com>
Closes: https://lore.kernel.org/linux-mm/cover.1683069252.git.ackerleytng@google.com
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c |  8 +++-----
 mm/hugetlb.c         | 11 +++++------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 90361a922cec..7b17ccfa039d 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -821,7 +821,6 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		 */
 		struct folio *folio;
 		unsigned long addr;
-		bool present;
 
 		cond_resched();
 
@@ -842,10 +841,9 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 		/* See if already present in mapping to avoid alloc/free */
-		rcu_read_lock();
-		present = page_cache_next_miss(mapping, index, 1) != index;
-		rcu_read_unlock();
-		if (present) {
+		folio = filemap_get_folio(mapping, index);
+		if (!IS_ERR(folio)) {
+			folio_put(folio);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			continue;
 		}
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d76574425da3..cb9077b96b43 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5728,13 +5728,12 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
 {
 	struct address_space *mapping = vma->vm_file->f_mapping;
 	pgoff_t idx = vma_hugecache_offset(h, vma, address);
-	bool present;
-
-	rcu_read_lock();
-	present = page_cache_next_miss(mapping, idx, 1) != idx;
-	rcu_read_unlock();
+	struct folio *folio;
 
-	return present;
+	folio = filemap_get_folio(mapping, idx);
+	if (!IS_ERR(folio))
+		folio_put(folio);
+	return folio != NULL;
 }
 
 int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
-- 
2.41.0

