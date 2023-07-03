Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEA37462B5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 20:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjGCStw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 14:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjGCStv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:49:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC70E6B;
        Mon,  3 Jul 2023 11:49:50 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363G82sN025208;
        Mon, 3 Jul 2023 18:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=pjFuUAlPCzAG7IidBiDVgOgqiX3tGSJKtdVV0MXdGSE=;
 b=OZZbeyNzYeHKDo3nPcwlmLNyLjkR8jKokrhCSUMPcRWnlXR/JtIrqpyTGM93fIq9C8/G
 GR0pBqBqEMLinP25nPGX8wG72ftN9cz4sgxAjhhO3/nCozSG2MJlN8bWXCDs2q9J0AV1
 1jhxRC43gzmFfaJJlXoBeXFo74OEILF5R8G5/MTLs8K+x0HYflEKBuohGPLVFY5JQ6AY
 POm0qVUL9TDvY2nhC2ePDZViAze941EPbypxDwKQR1RM6aoRDf2R298R9D4xCcOZ+thE
 FZ6pS8XM2GbGcnlS6vnj1zT1xuEo+r5XfTeEPuAXoRaAu+UYnLw5Wmp3MiVnz19C2ygC EQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjc6ck9h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 18:49:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 363H3DeR010875;
        Mon, 3 Jul 2023 18:49:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak3p6q3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 18:49:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9xW+m0YkaSS9e1RIjWe2VOUEuks2eZ0XxmGJIL9kL19RidpAzYl2mLKUxRtuTd/d2q45wsXZLC1cydFrpavyy5+VsrRWOt5EcQ64EsgL7BTJ2pVdvu7Z5EZE7zhsmKNvY/QJoRDcHqRGsNodpwIKJD0eiC1K1udfb2HJJgfr/TDSXJSbGDgjrrQ1pgd53XVFLpy21Y1v3sXYbIo5Z6FfKrr4vdNn0kj1Y5D/QwjO1xbWS0k4qkzXr1ZCLtR0CP/eeyXy8Y/DhEB6FH01aXzg9q51ivYrl2kc/42vC+oVim3qAIk2o0Y6XK7nZpvWAbngcw8b0CVmbg+gp0N3O+lUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjFuUAlPCzAG7IidBiDVgOgqiX3tGSJKtdVV0MXdGSE=;
 b=jjPmnj1rlJ4Hcm7UbwUSngu1JuCHbTGJ4WwLuYRp1k2UzWwpXsGeHvuKtkMbxRKXa1t6SQyIFohDohFdDsdUnS1YaCp81GEpefReNA1Ysl0Nnd/T7a+psG+vSJne9+F4AIVRsu0vXvpbbFcpi29bWDYYF023L9LBj/yPPcrMwT1/qHfNN4c5o2nMORXdf2yv4phBMnuOxMGz+aEJrh5h3Z6hWd4c46IRCtKlx9Wt2oD5W0hfHcMseaC0bJ7ohN4xdxBJGD4pP1RrLAwcagx82YZp69W1W0UygXDhtkJzM+wnaBAQVQGZNMdoYvfV10e2QyWnwIB/owS8fEjlmMtzZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjFuUAlPCzAG7IidBiDVgOgqiX3tGSJKtdVV0MXdGSE=;
 b=MPqXelaw6+8M1h6EG3bBWTD+gw59QbIPPWcn0ylVQYRIqDogLy6G8wshjQkp8OgfrgcWd71zfGAuobYd/SVM2skvuh/598AMGDsFUDrAc0FEoU6X4fpECW0nBFaP3O0mgLoixM7/4X3CpAK+LswMgO+SiNH4Vsd5aEfIavpw0pU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB5974.namprd10.prod.outlook.com (2603:10b6:8:9e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 18:49:31 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 18:49:31 +0000
Date:   Mon, 3 Jul 2023 11:49:28 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        ackerleytng@google.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        oliver.sang@intel.com
Subject: Re: [PATCH v2] readahead: Correct the start and size in
 ondemand_readahead()
Message-ID: <20230703184928.GB4378@monkey>
References: <20230628044303.1412624-1-fengwei.yin@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628044303.1412624-1-fengwei.yin@intel.com>
X-ClientProxiedBy: MW4PR03CA0230.namprd03.prod.outlook.com
 (2603:10b6:303:b9::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc020ce-373b-4c34-fecf-08db7bf63c72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fn0M12Ha5JDup+4fJ9bBVw1ZatE16gbwJAq00N8BuU7phxcwFbIamfhYk0cgrYJ0AcyDt9b9WKcjAO24hyNLzW804Bt4NcVt2VXSlHGZo+mPX3lO6SWtdnaY/9KgejvIpflO2Kfzyh393gmyANIR1HbgpUpM2Iz5U2Dl8CNpLc/gwicBcH1u+LrAc0gb57rT3SDnffJtAHTqqOtzb7v9NBOGkMNmfKUlBmeRvIgJWoEVU1fEHjhYNmstaGooHr5IdQBWipwRbAwnaCmWlS2CZrUYmoFDAGJqutVro43QmbxwiHNSNUYK650N3Mjzym2olFA2AfrL5Bt9dwkZhLgGM1ggDuha+t14cXGAv1lirBoZ/bhwhNPMP8DY0kSsk4zdwzUSLj4o98ZRZLcgqfe/DJJyI/juPiE/tcbh+d8OGu9QEygXwfvlkHVmohxTJ/fJ2e6VzdSmtvrLDRxPrrvysdrt1EcV+YhV5xg4eERI4i7KIA/iO/9ursfYJNCQWgqlC6HBN32CMUEtNhWO5yHiXXU0gkBLSFxiWj+RvjuTq4w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199021)(4326008)(316002)(66556008)(66946007)(186003)(86362001)(6916009)(9686003)(6506007)(66476007)(6512007)(26005)(1076003)(53546011)(83380400001)(966005)(2906002)(6486002)(38100700002)(6666004)(33656002)(33716001)(5660300002)(44832011)(478600001)(8676002)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5peIN0rTRekTBui02sj3Mtci0rB/ZyBCGnR7+bqXXrU0ioNYXPMB6lThuP8j?=
 =?us-ascii?Q?vH82NwXqCf4QLKCy/zqeuY5++zGiNieWKQYRv9BcF5HmwFvhJMH1ffGLuNcb?=
 =?us-ascii?Q?mCKAbtbb987fVMNr+IkoDy4Df/PsvDfi7VqwQTaKDJ/geHenr0cFjgSGeaU4?=
 =?us-ascii?Q?u8susv9L96jYbkZOTmIaomxauXH9ZZyysI2ons+/cIzJR6ZaFK3tqtDDFcv7?=
 =?us-ascii?Q?+kAEZevcuAWt/IhX0KPkjJHEIo0PNmJw0Sd4dhFPgos+TGUAUHKSF37dHLsl?=
 =?us-ascii?Q?K/wcz45j2lOt4zPpqEYbXP7irGVaefyiziQLZjq1EwFmGvWPw8Vgo6xHRdld?=
 =?us-ascii?Q?5+ao2v3CDj0vor5tRnzRLmzXhQkSFwhhvH5ljhZ+Afd0pyPAN44Tg6zV6qBn?=
 =?us-ascii?Q?YxSarkvvKxzluSH0uQVeZrGLqPD+Fd6dSxfKqWpQ6lVNEvMgxiHhQtUtYTYQ?=
 =?us-ascii?Q?X+UNJlHeQW3iKYiTO01JGntLIaaIjNVyHTOnABWgUwYtKw5mDDsx1j6FnnXJ?=
 =?us-ascii?Q?C1CAv4QO+xrRLxfuTTnZEcrMoXMTnji4EYtEH3KB0ezr16UEShB3LPSHS3+L?=
 =?us-ascii?Q?fR40lA7S1YEu2QZ+NBJLzaS3mifdJi+ETVX2SMSY2AUF7ehtQNq80VIcyIJO?=
 =?us-ascii?Q?WxXFsbalT/BdczKEeaa9I4/wySc+GVWR7qaGGA3h3gPljb+PYQ2VPQAbI/hL?=
 =?us-ascii?Q?lnqsJSUh7JEawjaAerHjpia+JpMaLIb2hHDtpkouNZPW+IU8kgyiWRIxswUp?=
 =?us-ascii?Q?GLAZLiSinPKha3pkp/SiiL6Ar2zIwYPO01ACsimm0NA9hxlZGw6io6FXMh3T?=
 =?us-ascii?Q?2QLi4+/X/CU4cJk888r8Q9j2GJI6N/oZxwX4dUmT+dNQ8P9tbAQZBFB1GxQs?=
 =?us-ascii?Q?6wxNQi5YkvqXJyIZfHAMDSZ3RbV2d0wpt/lu/epC/KhI7pHiz9d+N9siJ5In?=
 =?us-ascii?Q?otkTzcX/smCL0nu5e0b3M0TUj8NbhSFc079lAV2knx1XIzUN0V8fOKKaJIeB?=
 =?us-ascii?Q?WSPFrPBbH8sx2uYFBeGrL/FgbKe7it0f6BV+igA9yy2Nd9CoGwVGly7w1mg5?=
 =?us-ascii?Q?HKuQfANC+w9e8+SflnEkMJX3hkA00v7qEGHKgKWd9qLiCCnjVHH0xTgdvT8n?=
 =?us-ascii?Q?UwyPLT6y3rqQhiJOPLRdnvIlNmMg5vRprXp7+9cLsgux/cn4z35alDZE4eEq?=
 =?us-ascii?Q?q2u0hqdp0wEfOGm+F1crCdt/yqUlp5XEt9nVUUJxXk0rjVfBIhhbeNYk0KNu?=
 =?us-ascii?Q?TLgbgaCHVnDQQ9I2WvKAl+Ljh7PGqLl73Up23EwC/7lMs7G9/Vrl2r4kn6Yl?=
 =?us-ascii?Q?gLHlqgsSjYNZ1OLvOVgUtDWG44Cij0C+zcBE1jeMgCV+d3tspzOOy+os9P3c?=
 =?us-ascii?Q?ba6wG8/ggccxs59ilSlEz3JlMQu/c4rvpjkkEkAvVTiwGqfa/oBfHStRzFS5?=
 =?us-ascii?Q?77M355RxCfZM7oj9SeyHl0m96fzou7wRqWDWSi2pxjxOuwVmDRVTuga1MQR6?=
 =?us-ascii?Q?weYse1U4pp1gzcm/yzn6FIltU4EFVDvKAvF9ZshKDg2c7HO+EnY72jsT5UOs?=
 =?us-ascii?Q?VDd0Qezzvp4mweJb2OuAETdcTaeciKDk2fqVV9TE2Uc9BJ8irOUNDHLqBGBP?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?OmqikRl0A9+i8yo4kLfpn52AD2KxMw0LHX2c3dc07gxw3F1lgHPQnF6VSqPg?=
 =?us-ascii?Q?JsnYT+NlfSp+Mfmb5Ohpq0yaGLRPpdTujeinH9ESc7PvnjftWsEfoKvj7mVu?=
 =?us-ascii?Q?4bzUO/Y8DH/klCmnECx+qal9DrSNCUDKUr1rsZn4cwRXEEL66qEqCazQQ8Ra?=
 =?us-ascii?Q?vfyFh5swn8W/K9u0a0m5EyWZq4QEBFA/Zin1oLdBGN8/WKkVVRUkok2tKCYH?=
 =?us-ascii?Q?dk85mqXDYzwAlVodPxrxlksv1L+nGKC+Flg9iiDF39dg+zbCNP6j3KtpafId?=
 =?us-ascii?Q?kELMp16cHukb7MdYCC9oQ4OMgS5/MfBCxRfBzbZ2zD+BsMMYcJReQzsIvYwr?=
 =?us-ascii?Q?EeSAaHar55DQIuxeW1PUnlBZgWcVS2kY9cu8RlKzX0Emkb2IrMLN10j5sGf/?=
 =?us-ascii?Q?IOVmWw7WwKB8S6ObMuX/vGEKT/KPgkQkNlZBAImz1WYaO8aqrFErct3prLAZ?=
 =?us-ascii?Q?eYwdhnOIrDw4hqMmfbooS8dq994SkKxahskFer7UbnESkP7bccLS5U7v0GaD?=
 =?us-ascii?Q?xjUdZuDE8LecW2fVHL9WyVpJILCdSseeraDKwaiYHARapOIyXojb15cxD16H?=
 =?us-ascii?Q?fs/VmUE2oGgA9ebIxBdMrKS2fpXPmKIDkjJYtrM84yZ00aUUqZZAqdbtCASv?=
 =?us-ascii?Q?TzPXuncqwuD2yem3EAJKmBOL89eiXv+rxxrwaRohD+zOakqyf17grwkhTpQS?=
 =?us-ascii?Q?xbN98nXd0eNEzoxF4DRFyMWHoXJTyRsdaOLgABO6YsypTBallvqBoiu8yQBo?=
 =?us-ascii?Q?CPTIc+2J+yscNfyGYewpZdFSYisndoogkE7T8hXF8LZn12v3WifRfeXLmYoP?=
 =?us-ascii?Q?VGbL3zn3MCCDllBU5rrQLesFDaXn2cgcBydxab0mJNiqYijrsTV/UJ0yYlDM?=
 =?us-ascii?Q?04l8rLHruYvox9JZAn7CgP4/HhVtninop9cvvFa5dClGFe3B+uBBj+ARMmu4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc020ce-373b-4c34-fecf-08db7bf63c72
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 18:49:31.0366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32rNM/usWk32q+tMqFvwkBx+6Keoly2VLwcwCXeYYNuD6GwUiFlI2fnsRxoy6lCBoM4A9PRUaPkDQd4wBSyZKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_13,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307030171
X-Proofpoint-GUID: EDyNAi7spJWkg5jfcmgDlql1C2osEMaF
X-Proofpoint-ORIG-GUID: EDyNAi7spJWkg5jfcmgDlql1C2osEMaF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/28/23 12:43, Yin Fengwei wrote:
> The commit
> 9425c591e06a ("page cache: fix page_cache_next/prev_miss off by one")
> updated the page_cache_next_miss() to return the index beyond
> range.
> 
> But it breaks the start/size of ra in ondemand_readahead() because
> the offset by one is accumulated to readahead_index. As a consequence,
> not best readahead order is picked.
> 
> Tracing of the order parameter of filemap_alloc_folio() showed:
>      page order    : count     distribution
>         0          : 892073   |                                        |
>         1          : 0        |                                        |
>         2          : 65120457 |****************************************|
>         3          : 32914005 |********************                    |
>         4          : 33020991 |********************                    |
> with 9425c591e06a9.
> 
> With parent commit:
>      page order    : count     distribution
>         0          : 3417288  |****                                    |
>         1          : 0        |                                        |
>         2          : 877012   |*                                       |
>         3          : 288      |                                        |
>         4          : 5607522  |*******                                 |
>         5          : 29974228 |****************************************|
> 
> Fix the issue by removing the offset by one when page_cache_next_miss()
> returns no gaps in the range.
> 
> After the fix:
>     page order     : count     distribution
>         0          : 2598561  |***                                     |
>         1          : 0        |                                        |
>         2          : 687739   |                                        |
>         3          : 288      |                                        |
>         4          : 207210   |                                        |
>         5          : 32628260 |****************************************|
> 

Thank you for your detailed analysis!

When the regression was initially discovered, I sent a patch to revert
commit 9425c591e06a.  Andrew has picked up this change.  And, Andrew has
also picked up this patch.

I have not verified yet, but I suspect that this patch is going to cause
a regression because it depends on the behavior of page_cache_next_miss
in 9425c591e06a which has been reverted.

Sorry for the delay in responding as I was traveling.
-- 
Mike Kravetz



> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202306211346.1e9ff03e-oliver.sang@intel.com
> Fixes: 9425c591e06a ("page cache: fix page_cache_next/prev_miss off by one")
> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
> ---
> Changes from v1:
>   - only removing offset by one when there is no gaps found by
>     page_cache_next_miss()
>   - Update commit message to include the histogram of page order
>     after fix
> 
>  mm/readahead.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 47afbca1d122..a93af773686f 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -614,9 +614,17 @@ static void ondemand_readahead(struct readahead_control *ractl,
>  				max_pages);
>  		rcu_read_unlock();
>  
> -		if (!start || start - index > max_pages)
> +		if (!start || start - index - 1 > max_pages)
>  			return;
>  
> +		/*
> +		 * If no gaps in the range, page_cache_next_miss() returns
> +		 * index beyond range. Adjust it back to make sure
> +		 * ractl->_index is updated correctly later.
> +		 */
> +		if ((start - index - 1) == max_pages)
> +			start--;
> +
>  		ra->start = start;
>  		ra->size = start - index;	/* old async_size */
>  		ra->size += req_size;
> -- 
> 2.39.2
> 
