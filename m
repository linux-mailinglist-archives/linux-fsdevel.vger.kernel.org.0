Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426467392AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 00:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjFUWrp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 18:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjFUWro (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:47:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C8919AE;
        Wed, 21 Jun 2023 15:47:37 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LLCMjr028371;
        Wed, 21 Jun 2023 22:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Czco4LF5QsVl1KRcyO8c20UrEkb0Ld2MKnRsFCWTGmc=;
 b=tiiRDhxePbgm3TuBUVOsiA/TbbNYEdNGx8CR7qmWblp6tKxeXZEqQQCfl6yXB+i/mLj4
 ICmobLMFjh435PBPIn74WOVjfN5BQbe5sDPyVF0FIisEwsDJPLUAv4eu9CQ4ZNPB96nT
 jdZlsf8m1CYem14FUg7PYK6r8KgvgUp6ffS36JMtw5Jo8NtPOJ6k+Xp+q1hRXyPyKVrK
 Wtp7DISMFuEL+EhIkjvtyWvcMArS7szKXv8XWTuKe/2acZSoUGxzepelxAwgXpTxY42W
 uWDq4BkKIMtJ/fCXgOlLBYa+qGUhTquizGjpZ9Z/TDiEuFfO/mRx/TqsZSYAUn2yxjcz 4w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93m3rqfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 22:47:04 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35LMeKbb028897;
        Wed, 21 Jun 2023 22:47:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r939cpu17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 22:47:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cy69Brjj7gflhnUmI3pjTwqS2XSOxFidJ1S3Qnv+bBwx8jebGw/SWhIsKQtqtu5C/roDtDkgBn/XQIqZd8HCSYRZmdiA2y8Hv5YWzRVdKr6GK5JmQqVcGEP3A3FEYpZTpvJ/FMZEh3TZUAphoVSlnqqgwQK2ybfXNGL0RKZNUrKlLHB6dbg3GvFKUDFP4CpAL494TkyfW3Dl/H9A9a7NifxFJ9PDSSkMs8LmzcfgR1JOa5KInz1PnmmgcKUtQxBT/NXfa73ChNkvaNSCnwe6zmZD8Hf/a6JktnnqxyGchdZ9iEZIR/y/w2OLaZ+KJb4yljf8urGYx/dmgBfmzo+1Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Czco4LF5QsVl1KRcyO8c20UrEkb0Ld2MKnRsFCWTGmc=;
 b=HVZHHAH0X+oa0DUzxa6fQUm7nXKMxvYvaVOtj8GQlxHAudWSO/7Myh7BkxYg6ZlZkZw2adkrEctM1Dt2dKCPp6vaxmlc6drvgOFoqmYnsrgurKZ0OOanz5Gu9zEltEqVyt/R4DdbBGlbHE+7YC/nmKScjj139OJSzL/qIa+yBwdRYopHK+qip7TTCsEPoTqJXpRIXKtDgxqS3Qqu2dGMhwQupVp96OAFVa+ZcawdzUrnVmNw9Bg2+SJhyG1v2zLDhijJncGL55PkPuLmMrRKNE17PNfK9IPYxc9uJQMfPH1CnyyNkCtApJWo+gorfZd8eq1AkrDhDdp6gEk7WkAoxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Czco4LF5QsVl1KRcyO8c20UrEkb0Ld2MKnRsFCWTGmc=;
 b=gWP3rIgZxsH5qbAZl1KjnwRqSU2qP0bu45stGtW2bpzsLth/WAVPHJ30qlaritrQ68VsfTYMsLINXPzoBLjVEkchS6uFksVVrMj0QdQvf+mIVLxD3uYodtMhcwOUfI+jF0K7wmwkH0+qd+HT38ky9C6qE3zusGPyV96RxIXcxYQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN6PR10MB7465.namprd10.prod.outlook.com (2603:10b6:208:47a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 22:47:01 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 22:47:01 +0000
Date:   Wed, 21 Jun 2023 15:46:57 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Ackerley Tng <ackerleytng@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] hugetlb: revert use of page_cache_next_miss()
Message-ID: <20230621224657.GB4155@monkey>
References: <20230621212403.174710-1-mike.kravetz@oracle.com>
 <20230621212403.174710-2-mike.kravetz@oracle.com>
 <8a1fc1b1-db68-83f2-3718-e795430e5837@oracle.com>
 <20230621153957.725e3a4e1f38dc7dd76cc1aa@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621153957.725e3a4e1f38dc7dd76cc1aa@linux-foundation.org>
X-ClientProxiedBy: MW4P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MN6PR10MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: d8bbb724-9295-44ec-97f5-08db72a96cf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CC061V5zcFqLayIATBjSMpjfXx24pEf/rASpD/mca88+fB4l9Zz1ecMQhPZHcwK325G7lgpcZg1WG0ehSbq5oXm7Y048UMQtbYAYrZK6RP8m4pDQ3q0V3u2Qoc+XfI0UrkQbYREbAp6Wlwh36iqXgfb7IZ0+KNrPHX5ZEohyMhKSyQb6g8++FRX28iRz3wxOvqixFOcwpB+rYd6joTiRUnCLgcfFY79jD9IeqCj0Ge53gC399QZ3es+8tGW5NAvhf65MmuGaDcyJJagLkoJvUj7afg5GdNfMXGPR40unp+6VFJJ1VhK43UFgAeCE+wzsMvJD3JGyUjvqeboTN+BvrukzQQ6kBLzDnwDZgjHmD3t6bk9WwkyJXHet/CLCwwTxsS5UySbwJSzB9JSX/DWbr3mkMRGfIoqGJQQlwFp/8IBfXRhUJ2mM4b3dsrkIxC5UdgC4riP+QBydja34sQDcZ7eTMTeWdj0bDZ1WVYgR8HMrfTeuIVwSjOEtiwifxYgAeiX4+kmr3HxhaUyka6ICQaEApi+8W1kTLIPWs23UOvg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(66899021)(33716001)(4326008)(6916009)(66476007)(66556008)(66946007)(54906003)(38100700002)(478600001)(33656002)(2906002)(44832011)(8676002)(41300700001)(316002)(8936002)(6486002)(53546011)(6666004)(966005)(5660300002)(7416002)(1076003)(86362001)(186003)(26005)(6512007)(6506007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HnseqSX55e9oktjepvkqTgg/FiTJ8a3OsFHc8pjpXT9k/gqq4rJvYjb7YmDU?=
 =?us-ascii?Q?JQxlNbbY7UAvnJXQpGfpFD8nXrU8BmLThChmByo9jkdJJQel2v2okxyu+3bV?=
 =?us-ascii?Q?L5/3htbOpw90iOH6MqAcIj+8l8NofeBj6j5ApjCKpNyU73AoUeBruNiqYcEg?=
 =?us-ascii?Q?u64mKNzN/Ap1br4gySyxWyN8rOrVkJ+3fQS9ot1znJ88YXZGjEAHYBhGZSEN?=
 =?us-ascii?Q?UTg7W5lIXg0y+5m8dEjysLlx0bNxrLun28IEo4SGnbgSxzCeSUsvmcVxoJB6?=
 =?us-ascii?Q?Hlid7Q61P/g0tCbNNG4nquoxTS7bL8glaMpTC5v0D0UNQ8+fa7wGXOdcN+OR?=
 =?us-ascii?Q?hQiqxrx98mhHnaK28MiXqqqKZ3i+P887Ae6ZKlgLjULCKzXcyBXZBSBRUwjW?=
 =?us-ascii?Q?uqhGK3YMrWYKoLx0VhGc5vnUI3N3YHTo26cgYP5dX1loUe74QVaPT/jd/6eK?=
 =?us-ascii?Q?bhb6RTh2xOGYcXfcHutw7Y7uQEswwqL20ylBwfqzvnbJy/PeadfLnNFcHvc2?=
 =?us-ascii?Q?HixpTL24esvN+zflgKL2GlzEPqE7bAQIocEDgZZEUc5x/SN9cv5fWYR2bH4J?=
 =?us-ascii?Q?Rqr5UbOAsZYEwWIQIa6CLJMt9Uzcyhq+xTUCGhCatknYLb6XhZE65i0S52Ss?=
 =?us-ascii?Q?2Z1D7IBIFpacfQ/WS/dNJRRsKuv8XYJxd2u/cZM5odMpVIuqOrYZiStjNJ/6?=
 =?us-ascii?Q?qVxmYAfPbbDpI+ZTi6A5FBwmAC07XBl7T6bOWS+w09m6PNYJicGoTXHBbJJ9?=
 =?us-ascii?Q?X892gqsGzWwMy4iNKEwu+0dufg4UAEkgIGBMUkFokObUPaS8C7fUxCYIksFA?=
 =?us-ascii?Q?n2sqK0Mvum8AEiV1tSBOFK9ftxc7ZdYMzOx1+KwCOhMK7FrDfFJoWMlv64A5?=
 =?us-ascii?Q?YKXo35yh565aCnuzadvwMkA627mSbXo3xV8PG++E+WiLjfivw2LQrROQzOlX?=
 =?us-ascii?Q?k+UqPB5qCtYcRG+JqN8o1RqGrBXRp2n9lxMcEX3YHBUFv7NF6VoasccZvdol?=
 =?us-ascii?Q?bImmL6XEO8PVTvTvX88NXE58Uy1UluEGRFnm70z6SlT1n5IVSMIlNctqy3il?=
 =?us-ascii?Q?Hhcd5RlvAgPSG+Sv9B1eTxyTdrjttGcbpRwcTk1DKE1EKauUOwu8wpjSRigG?=
 =?us-ascii?Q?5OrPs32fYnj9L6nvTWfCVmyqiDKdc+O2mwoEoWdJRH2lS2E5L92D3sLGknLl?=
 =?us-ascii?Q?o4QZgbrl4Bcn4/qV7DB0eRuqhOJi60AwZJrRAtxJ692/ayGneEupUAKF6wux?=
 =?us-ascii?Q?/5xESszRJdUB3P5uiRX2jFWeCvJ1IEA5XCWjgOzLtBX0VcscajrF3CwdFTKE?=
 =?us-ascii?Q?NSp0U+G3QD7DA0LDWFcmmiYSjZuLeIOTLp83zJeIrcp4wvwmPkmuRPBTvywz?=
 =?us-ascii?Q?263SDjqwofw9lWsj7sTY7XJP/pNpDqbc8qvk88yY/x7Rn3cSxrZtDukr0Ph9?=
 =?us-ascii?Q?vbPvlNX/9p4jt/oJMJeJdBSXjamqai6W4SaAld+vH5KPpgObw+AeKFsU4gsR?=
 =?us-ascii?Q?S6fBzZygNBnT22k2rd8lIVOT6sMNlJm+QMtBJs6EhyaZmE946hHbtriNJE/t?=
 =?us-ascii?Q?dkUplfoXDgs82syswdsSl6huneHQXfKfBmDNe4Vp+5zbxn9sfJZcfOxrtDi0?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?9lztWzQdxTdavfYIn31E1gVYTg7X39MhJJDUrIysa4IC2qol9eo7VtHWnKmk?=
 =?us-ascii?Q?+2fkt5/0AmidiFfsX0mT2BJTwL0E5lu9PNRo7a3qkaWUrOFOS5mLmm306KN1?=
 =?us-ascii?Q?C9fLHqR7ZVQVFHViJMojYN7Zwn2+cqFHc205UIP4KNEm+0owPQcJGWzdvK1r?=
 =?us-ascii?Q?4k4ZnV5HiCBqtROu3JpwjEPLDWX4UbTzYHIIfF8Rn0MDTNepX3tjCxwTybAs?=
 =?us-ascii?Q?FA5QGbgPCZn+O5FORxoJY/GeeVZtlFf1Mn3x9/wGYITpAZ8Qu+X88D/2SCQX?=
 =?us-ascii?Q?Wu877w9V2I37PYmNrkVvBoJtYBdM7ivGBMyuMmmUffN0tYcGXS1R/m/ipWPu?=
 =?us-ascii?Q?3Bl6mKwv9Oyg04TlFa02HCW7fHgBhIs494dKTcj0qiIAAI2YNEDnzjsBQUlP?=
 =?us-ascii?Q?GlsGPPMvyf6n4dG+bJpM+yG13/UP4l17VpAplOib1FwGm5DuK0utnwTYH1dD?=
 =?us-ascii?Q?IxGfXgZkuxQEXZZ/x6IvdQWVSBms0aP26y8X+74wNVmjDWyrLhaPoHZc7BzD?=
 =?us-ascii?Q?8BQUPtM4iTq3F7tnGkQoMxSGR5vmS4B3Zkib0bArqJQfrU09M2V0KgQyWv1U?=
 =?us-ascii?Q?22SbdeUnACxP2ZgqP5eD//z2xX2zW9tELWQ/t0xvWhTZDxemc/7cvaEl9BzM?=
 =?us-ascii?Q?l5vBGXHYW7xYJ98uPRnByPHs9fJBb5qsHnFomdb8ntZmjrylMu+rC6l/SrBB?=
 =?us-ascii?Q?seUXEopOyNkwMtPFpdW7tiyhn+tqfLZ2iHqmALHT0I+JMu4WwOHyYWouWTkk?=
 =?us-ascii?Q?FU6x17oVqq/GvMpryx7JZEE8qlDDtA4/vetkqYQnvvOqkgFApW/iV3WAZbxO?=
 =?us-ascii?Q?3LjxASn5w1EhoPr9Ha2tpy94FzeHnHWxtHucJQast7TNj/KSP1sH4Qtd02S/?=
 =?us-ascii?Q?ZtuMUPwyDNtw0y3t3i9UAn/bVvEInQooUP0UO6Gj77VFcXjYPG8ZuCm7qjS0?=
 =?us-ascii?Q?OgWpJ7oJ9siddM8R/AGN1R4xEdwcQyvszM5o8udWeHoAwbjO5l9DoEzg97pR?=
 =?us-ascii?Q?OzKx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bbb724-9295-44ec-97f5-08db72a96cf1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 22:47:00.8630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vr4MGCXfbZtIep796T7KPBTbqUmOi8kufGNmwMl6SPXp0trKxOhRXClrqgvmPeVFAPInRgqaa+khY3tdWwb0bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_12,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210190
X-Proofpoint-GUID: hf1MjrTENsIZ0gCBKfe8_mTcYOacf8Sj
X-Proofpoint-ORIG-GUID: hf1MjrTENsIZ0gCBKfe8_mTcYOacf8Sj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/21/23 15:39, Andrew Morton wrote:
> On Wed, 21 Jun 2023 15:19:58 -0700 Sidhartha Kumar <sidhartha.kumar@oracle.com> wrote:
> 
> > > IMPORTANT NOTE FOR STABLE BACKPORTS:
> > > This patch will apply cleanly to v6.3.  However, due to the change of
> > > filemap_get_folio() return values, it will not function correctly.  This
> > > patch must be modified for stable backports.
> > 
> > This patch I sent previously can be used for the 6.3 backport:
> > 
> > https://lore.kernel.org/lkml/b5bd2b39-7e1e-148f-7462-9565773f6d41@oracle.com/T/#me37b56ca89368dc8dda2a33d39f681337788d13c
> 
> Are we suggesting that this be backported?  If so, I'll add the cc:stable.
> 
> Because -stable maintainers have been asked not to backport MM patches to
> which we didn't add the cc:stable.

Yes, we need to get a fix into 6.3 as well.

The 'issue' with a backport is noted in the IMPORTANT NOTE above.

My concern is that adding cc:stable will have it automatically picked up
and this would make things worse than they are in 6.3.

My 'plan' was to not add the cc:stable, but manually create a patch for
6.3 once this goes upstream.  Honestly, I am not sure what is the best
way to deal with this.  I could also try to catch the email about the
automatic backport and say 'no, use this new patch instead'.
-- 
Mike Kravetz
