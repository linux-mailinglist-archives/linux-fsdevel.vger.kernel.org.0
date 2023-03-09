Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28976B2F9A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 22:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjCIVbo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 16:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjCIVbk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 16:31:40 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121F5E2C41;
        Thu,  9 Mar 2023 13:31:24 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329KxdTu026282;
        Thu, 9 Mar 2023 21:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=XPIa1bGe5yqvr9z1KquLdnOov36glZoTIc2naMdAZkg=;
 b=RI9zZnE4P0jsJJK4IAv3yHUHeZRPliPojmRjsdL/yCqNWbH/j8BxjxDuXvD0nSt2Fofn
 nj1O6pzlq4UIyD5bzFmN1QyHOMKdry+CetgEVSLsUdxc4XijR8IaOmFxNhHWVLk+PzdM
 tim8BRMdie+ZgDjY710feOGdn2j+NBbI8UsKQwv7igF6RKvt/EsAvf3OmqYu/y+GlEmd
 78TXVfFCsh8ZQIcj4HXQtd4Iq/eMXjhx2lqmtWtoS5FyUhptx1CvERwND5X/pzPrNiJH
 IARBt9n3ac6koFNgi1WvRVveigH7jLl0MuvHqxfNf5ca8zZ5rjLXXQLrCpK1mTRCZufy yw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p41623t26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Mar 2023 21:30:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 329KU57c027467;
        Thu, 9 Mar 2023 21:30:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6g9vskyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Mar 2023 21:30:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JW0v+uyw473wRMy4x14+H7hoAjG4u3xdU5cY3wqG0yz67IkvXWPEpuwqo/twhgdSUDuvWUd2EKPNxSfgeB83l6Y1R3uT4/x6zYJCnwCvkpRha93Kuzqt3INWe3VE6lxHiMQFdRdqGv55BCcEpOVFJieGHzIaPRBuV6U0HRpS1rurirx2pxDXGU0VOMu2vRxrbmpLqQgZQxJm/VfBNVgEHGh/XBJ02JLoj7vkRMjJ21hPQfinI7EDpklJUu9PH0dWEVQPGyzn628U021rwcNOVS3c9du/1/+CX870QYKmNdeZiYkakVO9vRtsY7xZISEi1toxGWbciM4IQfpLuRAtLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPIa1bGe5yqvr9z1KquLdnOov36glZoTIc2naMdAZkg=;
 b=PhSwrQvLHOf1cidkBX7qC6nvKMzG/tlsf/dwt/eQ33daLhlN7N1Th6Al/1C40a4jU+sSHVKqv8dg3CiANRGZ+tHp5bd0xCIOybPAtbKW1c88iYuEJtmK1sl7mlpFMK8aiI9hk5YA3lPmwER0OmazVwDMc4ib1tK27Gx/Hjdpmxett7Hspg7sp4u+XbfYq72ZJhSXz6q2YSd4xZ4e0PZU1LbjXXfwEBYW8qkmOurDFSvIH6cUMj+Ojtk//dY9EZQ/Ukt5ZU4E76ajK46y6uscRdb1kxVe9R7MCa0BWdv6hdYmXYlacgwPBclzm3m0zBWKPgCNA8cQ4DNgsBfpmCSNEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPIa1bGe5yqvr9z1KquLdnOov36glZoTIc2naMdAZkg=;
 b=bTvrlwpE6unPJ4dYosrKi0Px8AapOECxtv4Niiu1dwKT735KrSWAQZLldH2diNn2uF4QzBVsxasj0zo+uMrRbId9zaqLFhB/Z/EqVTZ9tpscq6osnB4Ai2RaO+JFXKd941fMgddz+R3jwCtw8+J+H7Mjq461HbvG5pAC1Rnw08Y=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5615.namprd10.prod.outlook.com (2603:10b6:a03:3d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 21:30:04 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%7]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 21:30:04 +0000
Date:   Thu, 9 Mar 2023 13:30:01 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: Re: [PATCH] mm: hugetlb: move hugeltb sysctls to its own file
Message-ID: <20230309213001.GB3700@monkey>
References: <20230309122011.61969-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309122011.61969-1-wangkefeng.wang@huawei.com>
X-ClientProxiedBy: MW3PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:303:2b::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ0PR10MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c3dc2c0-8a74-47ed-f64b-08db20e5727c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RbvhHeL3jiPy1mWXVVhgnw5CyCjKFRgOewhV/BKZJL9+pErFQQdYrOb/fz/BIhEQzn7GuSw5ijRjUdZtvNwQTndiqkIVAhcdEPTdKQO/YYlLDfVrSnpBwIiFYPeeFk6FRDs/siD589Knlme/vg96ahYikl0nGINW9lEUT4Gx3hbUR9PZlpeklYGh7cnD/CDobHgR8IJuOM8Ycg8A9vJIjiE7cM9lebJBuntjfxV+IxU4OKImLn8A1OZK/EhxnnHuP2081WrpXLQVvQM93n66a2g4kqouQKxxCXxiAYr/xauh4p5zxvjKEsxXxglV8lAc4xtvsb7SVWrbax8EJ4xcYGBFEiMPwMUt0DacAIUuiG+aeHthmsglX0Mbq2c05P/xpwSeIyKQ9n9ZxgsC2/PaC/8sRYocy4ssCIUwGMOq8TJZfsTdOq5Bo6djG80t0rIBy7vQG1iytmK/WuKZWb9X4W3GbULiF1NrkR6pOfA3Exdh2Vqc3t/Tzx5rkKnVH275xhS+0YWatIQ0GSEEpJyvKhssVi+iI2SUOxofhWEZmBc1J3sIbqcGWyCzgvLaVZ0Y9U4NKOmBeVpQOOjN9dxra3mqjLlKaoGDJOn7F5EQ+jZGJg4CoUdaD9+solSTsM6kk6bAZ4HQjDcNpHGtYMac7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(366004)(451199018)(44832011)(2906002)(5660300002)(26005)(1076003)(66476007)(4744005)(8936002)(8676002)(54906003)(66946007)(4326008)(6916009)(33656002)(316002)(86362001)(66556008)(6486002)(508600001)(6666004)(38100700002)(6512007)(6506007)(53546011)(9686003)(186003)(33716001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CPoAEn+02btO1uzt8hvkB4kOtlEecXkTOHAGv5lnqNIKQwpjiWvh4HZwUkgk?=
 =?us-ascii?Q?R1q/2wd1HsjV3Vn3D676pq7R/8GAckNHJSmBGMmFCsj3/vAgGlD/Xl5PdUFY?=
 =?us-ascii?Q?ju8j6qGKnUJRHygtvifZ7F/P7BArtVv3NNa9lkIDoa4etg5dXZ51gvvDbNNw?=
 =?us-ascii?Q?dfw/Kq37wuCZ57ecBm/7N5d+z7MboVy32kGA10a9yOh3O0pjfSco3vxkfRE/?=
 =?us-ascii?Q?MgNlOI/RQg0MEv9+dz6EOPvIfrCqJKab5oOQ4xcqrfSkAqv9AJXVMyenxfIY?=
 =?us-ascii?Q?+s59j7htuEOmDMmeK5JkWqQKh2JSOKR2S7YrV4hSxfWIHVrRmwgJqIrsphT7?=
 =?us-ascii?Q?uI3/vUeWjf3S1JtbqcKdI7ZXPjGngZEceIxQ+96Y/nro3dUIBvtCg84vl7Yn?=
 =?us-ascii?Q?ziiCJx/LrbK8+mhgCdv/+9JqR2VMQ7N7gvevfjZaASos7yu2b7cR34SchAD8?=
 =?us-ascii?Q?LlSDeEUSINsyLog8ozFd0+O8nNsSu+BzS+0Oo+C7eig4b7hLuMyt+orFL0kM?=
 =?us-ascii?Q?IxTxWi1SBPlshj5p+smK/K4chNoOwF0iU3E1MwWtzh/QK4AtoLKJzyoPMsnj?=
 =?us-ascii?Q?pHUmIT7mbt6rwiuIziyri9N2mAbY2QVJzWuWmgPhClHaY2lQ5OkfbQcrsiTo?=
 =?us-ascii?Q?PyvJYwbqcejiqKqQ8Dh3M6tq3+mI7VbCuF/6vC+97fwJTeF1SaIqKfRl7uEY?=
 =?us-ascii?Q?Oej4CRCfqRMwIfvAKMwOTspqyaYnepxU7lyGEE+daUFWCBdTW00WSw1Tm2v9?=
 =?us-ascii?Q?VS0o0NQJQSNKDYWLsGR994ppXfu41wT9VDXw5KKAfhQa3lNHmD6eih4itxGW?=
 =?us-ascii?Q?V4C7SIrk6yu/2VH1/L6FmGSQNryIlIZ5oX4GL9IN5cTKyIxUsEpnKzILK1Rh?=
 =?us-ascii?Q?zuaOF6s8+hS5dMNRHOoSeFh7xvnKViSMT0n0PefyZMi9Iubs6cA8HvK4imta?=
 =?us-ascii?Q?QCs/ZmwBBb8UHSzho60Gy1KTRV+DinLg2nMW7dXbx/B7rd+J/R/c/927sVCN?=
 =?us-ascii?Q?HfGQPkJxDFO+z41PrEklTSudH6v+ZdYaukcLbDIIFkWnX2QZkLNHoYOikcGG?=
 =?us-ascii?Q?FSYX/qs5VOLdjuVoPg1yn9c20EpL+Vw5Xzp7NulR5sv1kXk6/xL71FStDyFo?=
 =?us-ascii?Q?3p8Sq2rwvlH/6dgn2Nqix00pKyiDFKcU7pN3b9QTb+EPz0lup0wFMK6XsBaf?=
 =?us-ascii?Q?XW2xn8nAKTJhpEso3p5cS2axyImHIm0kQJAA+XdNgo52IfAvflld3OCXzmbD?=
 =?us-ascii?Q?RXdhPZcYPj7gbaUTmyWx2sMABqZFVBjQf0Rw/bxQQ+1IylMEU5yfMtMR6PEl?=
 =?us-ascii?Q?9HQMCECUBKwRhpEG14qH1sI66HggWXMLV7+Snl5y1CetHKU/2heWheuIG1V2?=
 =?us-ascii?Q?EU4sl6O/KUFZIeYYZIEjYqgO9E/hoi8gnWB/+H+H5GbDQejtvGPrxJOtYMAA?=
 =?us-ascii?Q?q/9Zdco5uYnonFQ2WNPwgYHWqfOAvkv8iIPmmQOhv6KAZEOrJ6sYS/iCpxXt?=
 =?us-ascii?Q?edWdWiKJvG/0h/wuu/OdiKpoCwJ4/C4jRl2Yqh5rqZce9JDUxeJLVBgAH3Cj?=
 =?us-ascii?Q?shKB58znGsIEUdl3LHvHBgyknLqqJMNjhEI0fxYadNz7ebizWiAc2FeTqUUf?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?E6LZ/75c5KXLsEmR9x00CaP9nOn2pW5dUibX62I5+lU9SbfG5UXhhbPQzPu9?=
 =?us-ascii?Q?u+sBA845DPibKgcIAo0rNet50sWewaildPXy43uTW/K4SEzh05S60JOdPWNB?=
 =?us-ascii?Q?KYMFJnPw6BFOsYfBVNrgwzYgK7xLEbeq/0Ws4oN1NbRsY1QDFTQsbnbmyuRW?=
 =?us-ascii?Q?JS5G8lzeLLDv190UWaBPlzt4HqTA6OsH3BEvuy5Hq+eSys8MJyeA00dGScTN?=
 =?us-ascii?Q?pi7B28uPCc6fAgN5RyE33BbiZvZzS5YfNq7ky4ys03BlD1Y2Oa+ul8usgUMu?=
 =?us-ascii?Q?YDF7jgzkYukAE3qO7tdM7M1oe345dwf6kCI0fsNfAJbci0eWBhcuobq3zrpJ?=
 =?us-ascii?Q?bzi0las6b5R1wRMzlByhIBep85oNt8zZtsQccLTIbuMwntwZslfGZx7EH50O?=
 =?us-ascii?Q?ZZ85JnTeDxnJtMkPXaPyOS0SLHjMqBrPULKoPo611IuwiWELDCSSrxO+JXCf?=
 =?us-ascii?Q?NvCvSw/kztjHeZhJ1yUckRVq75Vui/jJvagqL/TCNDzF/xHh3PMl5d3pB7iU?=
 =?us-ascii?Q?JkIxW0otbc3A8v9m8qlBkO0AlM6K/CObRex47Hj5qODe/1PGx9RAvfLvztoQ?=
 =?us-ascii?Q?R5xzkCBOEdSTrM5/u7OX99qlI5tfeYCx4rihLPHJQCnvLOq6km+fRyT0+tVf?=
 =?us-ascii?Q?iylvNPVOhwvIVynTYQtJDZJzbARAnYSkVQ12bBfwE+TKQhsdnvKXPqnAKWig?=
 =?us-ascii?Q?0gDoqC+DhewX/sf+p8HFfEqB5OS0sSz5GrLoGhkijR3jk07yWSutWtkrm5Ic?=
 =?us-ascii?Q?TmvICjY/FzGzMrl8Gy4Rp5cqhZN76O+47cUl4E8YchOAleEkjk0VaIKe307d?=
 =?us-ascii?Q?7zsyncKCR1PiDpxCT+dAOFRckYGHqMI8oWoLWAiyNQLX5uBeEQeGPvgUVq4m?=
 =?us-ascii?Q?ZA0fgBrVB8zezVY0j9j1Ez2y3GVvQxb9UcxKtAsMhCM9pQpfsP+aLAPeAIlZ?=
 =?us-ascii?Q?/PuXVlvqLgYlZ2QLHrC285UiZqoIXfXp/wpszo5pyaA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3dc2c0-8a74-47ed-f64b-08db20e5727c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 21:30:04.5948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EbrXX3b8ESGlyJLQYBaxnV5iXEgSM/TPeIa5HZGhLmOT4HmqfzXOWhhXlYY5BQKCqc3yBfidTmUYRtf9POU/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5615
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_12,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=888
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090173
X-Proofpoint-GUID: hWAfigmEG7Nm50Y4DtQ9yzebeC2jnYKr
X-Proofpoint-ORIG-GUID: hWAfigmEG7Nm50Y4DtQ9yzebeC2jnYKr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/09/23 20:20, Kefeng Wang wrote:
> This moves all hugetlb sysctls to its own file, also kill an
> useless hugetlb_treat_movable_handler() defination.

I guess hugetlb_treat_movable_handler should have been removed as part
of commit d6cb41cc44c6 mm, hugetlb: remove hugepages_treat_as_movable sysctl.

> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  include/linux/hugetlb.h |  8 -------
>  kernel/sysctl.c         | 32 --------------------------
>  mm/hugetlb.c            | 51 ++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 48 insertions(+), 43 deletions(-)

Thanks! Changes look fine to me,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
