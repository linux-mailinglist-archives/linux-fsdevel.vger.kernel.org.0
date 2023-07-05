Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B224B748982
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 18:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjGEQw6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 12:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjGEQw6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:52:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BC110C3;
        Wed,  5 Jul 2023 09:52:57 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365Gk5Z0005194;
        Wed, 5 Jul 2023 16:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=u9mvDY3cntAZcN320p72WBqkhfshLWZK27LfR1S6hpM=;
 b=BDxXnlTwsCSKZaJPH4g32pLw3b0fGMJwKJPpBfYL8B2iP70zeMs6Azh0fcG+BE729paq
 hVYbn5h/ElxBmK3KY2EsSLZoJEPdysnXKxkRY6ADZniz7ONazCY5ivx9AzhQJcHnGOlA
 JZLg7xckD3BmcPHxtxtCnmfOctteToLiD6GfhK8qPKmInwfQa7mBIFAMDmZUasaPNrzB
 +NhMREp4r77R8yyh+m4DN6RCrwBCMLTk/saM0+Yon1cO2pS8VxMnlvWnW4kyhFT5zJhn
 aX5RROToNbMtGObjs9eeRjW23chLsrYNea2HEHhaerKkJFUie877ZycJDb8WTuVuZIGI fw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rncam00mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 16:52:41 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 365Gq2dI033336;
        Wed, 5 Jul 2023 16:52:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak63hnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 16:52:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oA+mVWXv7PZNntkU6gHiB4w3ancx1iuQJBhAWh1i259yeLsXz/aX3ayDZ90QyRalfgZNoP0++Pk44/4k5gGiKPy4X1ZHiJ0rpP7LyPHolD1iGGYsofgMtpmCbc5o2L1r16bs02gtdgkNYxSrcwjeJJw70j+TVdwD7L5Kxn2QOMJtPhaqr9DFiiFIWdj3jeyxHKz/AEhVApSaKtK0BR2+23KPLg+NvQ8eGMW0J997cl27Xn2mn8pimnqd6YuMDqaGZiqBxrsyHzuC/56Ate7Fm3dXVFf9mGheQisAkwzmCCQ6dj0KzSMSvD9rd4qLCoR4bj7XySp0YxQpRd/zRKcwOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9mvDY3cntAZcN320p72WBqkhfshLWZK27LfR1S6hpM=;
 b=UOizzpHNf1uBgxoDZu6Br1wKUY/AQjmJ5BnKeJJ9PhQD2Ujoy87GU6yzqU+d2A1BBHrql7dep6bhTdhg4Ul+cHcDZsiL+JxNHyDNKXjjzDzomGq80knWgnef66XAIjd2idPcqcar0qzto9jm/hvxxPm8ayhn8IKjOUeacFHpO/K4wbS7qSGToe1uKyqthZJvCf0IO/4hXrPox4IvYtyYukx2E/ODGufFqWw1LoHVXZJ8qiHiI8H0X9eHfRt270P8v7mDgn83XB6sCCLPB0qcD0sT290wTn/ecaQ5ch3d2E3LdZCTOfNpvZZHA/Q1tKU/buJ31gI7ZYoy7vL4iAenDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9mvDY3cntAZcN320p72WBqkhfshLWZK27LfR1S6hpM=;
 b=ecqD8lbmTlDnHWlbzQshfDO7vRiL3Y5YoTGC0mGVM4fQjdEvmk4OfGG3iqDz2XVa/K0yptbti5FV5hp82ZR/sPl0G89EXlOUeslGIZu8OP0ygl7cuRkkoCcbeylBEcomyH1/LiuI0gd6up4beUfcRxEPmsMz6kIV2QOm9+/SAlI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN7PR10MB7047.namprd10.prod.outlook.com (2603:10b6:806:349::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Wed, 5 Jul
 2023 16:52:38 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 16:52:38 +0000
Date:   Wed, 5 Jul 2023 09:52:35 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     "Yin, Fengwei" <fengwei.yin@intel.com>, willy@infradead.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        ackerleytng@google.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        oliver.sang@intel.com
Subject: Re: [PATCH v2] readahead: Correct the start and size in
 ondemand_readahead()
Message-ID: <20230705165235.GA6575@monkey>
References: <20230628044303.1412624-1-fengwei.yin@intel.com>
 <20230703184928.GB4378@monkey>
 <d6957a20-db31-d6ac-8822-003bdb9cd747@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6957a20-db31-d6ac-8822-003bdb9cd747@intel.com>
X-ClientProxiedBy: MW4PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:303:b8::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SN7PR10MB7047:EE_
X-MS-Office365-Filtering-Correlation-Id: 08b5a4de-ca64-43df-0cf1-08db7d783d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UvQApQJYJac7KcOX8UB90CsT6uhtF1bQmNb2Xm+Kw1+nao11hkga3DVjDw1ldK4DIU3vyvrl2Exv5dIVl/X4oR8VLF+4jjnjG+7bJlTRtUjixad/oqx96cRGDaXCnOhfZ0YYahc7O35g9eUpET8jTNbmfKxxzI8NlaVEKFmjez9LqVrsyZtDKVBadm7Z9mLcOJdSp8ItXSQwvoMtpkP97o2eRJWzQkzvE9MlcBKytPrKMTeBy1i3MRxajYQQF/kQKH1gNZKMSwG6fkf8VnmU9Ehv2nC8NTD5C/Ipv8HcvvEMHTLERbO12Kd/btekFEuyYEYGWVeO6ZbTcRyLppf91C8vMxq+qnH69yJhbECdKHNvXpb7KYP0WmDrLpCfzdMb2jxXx4KG1D4ngqricRxhlQ0lYPUd2gGem7OM3r3kUswIKaH9u25tUi+zJyor261XL88dazGLK6gB3RK9earzXjTxAp+VGwSw3VnQRxkUarNPogYwLEIsdnKDWiVNUbufUIRog+zrAgzVvD7geF2iNXOtRvHBJvv0OkGvnX1Dfs3HxS6+D4paM2wNChSx+Wm0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199021)(66946007)(9686003)(26005)(6512007)(186003)(1076003)(6506007)(53546011)(41300700001)(83380400001)(6666004)(6486002)(478600001)(38100700002)(316002)(4326008)(66476007)(66556008)(33716001)(44832011)(8676002)(5660300002)(86362001)(8936002)(33656002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bh6i4TO91Tw8vbdPyqlTi2i59jlXjP6aH7MOfXZV4ICmWS5OkvnL8W5AdQ2a?=
 =?us-ascii?Q?cnGsiYn04CaCENz+SxRO760RXH5WNt8u5Tk2/d2cQfTk68XAm/Fwfzx5v/A/?=
 =?us-ascii?Q?hxvu/RuF2vLlD6mTPuXEa+F9WEohM2rac1Xluz9aYyNTJcXlpTuqn0BYln4E?=
 =?us-ascii?Q?rRcecLuDoLeDuKWHh/R58HFh1bv7Xmm563XPWfurzNUeKiCvjAFhgmOAH2y2?=
 =?us-ascii?Q?7279ebRwg/s9JiCS8wFrAidkAxhyYMjJUzUwXzwU9YQjA20IAiyyqzwH3l4t?=
 =?us-ascii?Q?oSwsHJ4W2xyNzF+vsJfdpJg6T/a8LNTPJUFqSJqMgWvLYtel3KPM3j0f6Z31?=
 =?us-ascii?Q?6BHPJA+9qfdBmlX6C3NB9ZX2xhhaZHjDDW4Wzm49RR7symZZjFBlJUvYCrNw?=
 =?us-ascii?Q?gqxyUEZ/sJdfPyU2N5HuAy7G/OGC0UfHPkJuLBDCPgpL8Vhk0NREqpSmdPSP?=
 =?us-ascii?Q?NtT7XphCbku7FsqpTowiyMseFuCswo78dQw/5Npx/RPcDj0Fg+kmS5uaC244?=
 =?us-ascii?Q?n8KI7XUcDdZkrRYi+hX5byVb5DQw489VREg2rASdsr+Tcmj8dmXPDEUCgxso?=
 =?us-ascii?Q?SFZDW2QK1T7VExEvPJzY8K7T9FXLLFDUIZA/4KPukdLd4YwOGzg1VznjpQa4?=
 =?us-ascii?Q?eyLu4/08hufkFG+4BGJjCCeBByEmWRc7tvdl65EpsjM78FiAyUylWUDGZZpw?=
 =?us-ascii?Q?nQyM3ulWCLodLs9Uk14Awv1Z5d0fJC5mLAKf0mbuCg4wRQYhta+RDAf0ndHN?=
 =?us-ascii?Q?ZnDIIlQ6VmMDvkb3Y/D+rYgSPayAICq7pUP/Y3+4Enbo06mf8DoM+4m8ayKa?=
 =?us-ascii?Q?rBuhyjMAcRpwLYbEIXmH73Qxf8wF/qJD6/ImWI37x0lNevSXmTMAnoYPJv0b?=
 =?us-ascii?Q?vnYayoWTksG4IxE2t2D0ZRaD9oqnsLh+XfOsUvtOs35Jar0MtavOP6ZHNL9R?=
 =?us-ascii?Q?HzAnSRYMjfK71B3lrxmRdMStmBf+o1Jm1BKOcTng95KEoaAISD1uCKNrURgU?=
 =?us-ascii?Q?GbgTgaylCJ+qSHMY0/Cb3/v+fC/DbxFZU6/GAL9cABhTgToGjaGWCFimPM9b?=
 =?us-ascii?Q?hJ6rxBY2dpZMb5QmFtaUMlpT2OfTYrVvmyOVIbR7tVo2RToq5Z4JoG9+8k8P?=
 =?us-ascii?Q?ebfMvhCiaoMQnrdICag0QELsSnqxeQVEb3Frrie3+Z3PAYqG5zHuLcgYOG81?=
 =?us-ascii?Q?cGurNF2mNc9Pg+lVKv+J0rEXBQgp8dBd+ada7y4W6U2KyxNGq6V4co0B3CM/?=
 =?us-ascii?Q?ptN+uqj5W6TaiP+6AsKh1QnYBEqcvCzb55Gx7wnB8+c1EMVsMk/LznOABR8b?=
 =?us-ascii?Q?8HQ2e6naSyGL4qIw0vCJXzEZ86nBKhXySjSKAwEJ5oAEM/sRURnqeFyArBCi?=
 =?us-ascii?Q?w7GY+UiY99j6JQbzHotlAE2xDrYCZMbUSv++qYo2SlOVR4t0jL/L+1mlKEOK?=
 =?us-ascii?Q?iuZ43gQgBcWkPP1XLm4LNo6wJK6oMk2kZbA2NISAm91JwZ0hiycHVfaKPWGk?=
 =?us-ascii?Q?mrkAYqyVKfjYHZm0Dh33xMcg0OmE3m7yg9/MST4I5V910HPUtIDW6dcrdkQK?=
 =?us-ascii?Q?3iSndBfr4cLkLEjPSNXm/wWOyKGXT+sWP0yxw1+P?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?watm6Pe5k7C+2fsJw7Ijr8jrNaRZh4k+yp4GG3TIipJieq6/SA9Ws8pNsC/m?=
 =?us-ascii?Q?5yZkMyJ+Uh4Xzdr2zcK2muDi0GGAI9ZcvTD8kTGt5U3pNOkHyoJ3M/rPol/6?=
 =?us-ascii?Q?UAmeI/1ZjuIwgyT+cJQT6wGTEdhbZQVajEYTa3518xROSJt8/psA+D8eiiKd?=
 =?us-ascii?Q?BwYn5JyaB5vKBCIPWDd7+fNtbAe2ZrCZqVBCBN4MWGgUKegJae42MDIu1nnq?=
 =?us-ascii?Q?o2wsTwJ5izs0px3zqQcrf8FTe/XYoUpkjWoAViU9G35uEl6tjIIBbTUhXELC?=
 =?us-ascii?Q?mPGWIrslb9fSSRRT/Gk8hyxePb1/ttkUwGZi8DwMV9BzxvCRkDzSsv+KxLyS?=
 =?us-ascii?Q?OwMzUeQQrZDMszAFyvyh3ximzgiTkmxPalnQBlwSQqdwHAdM8LHUpwRubseU?=
 =?us-ascii?Q?9m4as4UsFdTNBSENMj87LYnZyVRy5oeNKAba/VVc4+SCElDh7VILiTg8cGJW?=
 =?us-ascii?Q?uv8j9g585IU9b50FAMNFhHED+3EU0QJJ6DmZWphhu3cq8nkkEa9DWGc5rNZ8?=
 =?us-ascii?Q?N3PxiZSZuQ+sa2HgLuvrvQqNsWatHkxUW5eO6xBGlgVbT1aFL5MAhmMTIAOe?=
 =?us-ascii?Q?hb8joAtVwOQzfFtPOdpp9Is92S55chNM6zkPOb/zDzBJbPxqD31iv/eDppaM?=
 =?us-ascii?Q?QNFt2xSlaMPieS7XsUZxIGngiOm6mjXN4lSA+u62rkoyab//NBoRnONtj50y?=
 =?us-ascii?Q?fpwfOoqXwuylBQoezEGpfq3NuO+0mUDL5riA0g52lkgSAY1Sz3pUhhyCxwUL?=
 =?us-ascii?Q?ZcETcP4Hj9sDeoaD08yp2ZhS7PshOwA2j4xy3NpA8ck188CND40JixI2MJK1?=
 =?us-ascii?Q?yHAjfw7UrO1FfBWwAbQULvUWSeDDd7P7sEcL0qBQFb5cRXGAoj4DakBBtsF1?=
 =?us-ascii?Q?P6BMGZrA+SPUjzOmTfEm9V72XwwmnNJMCxQgc7IM1rSXyjLEgJ0iEoLTzapC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b5a4de-ca64-43df-0cf1-08db7d783d37
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 16:52:38.1699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNDdBx4oeLaqXcNlwRmjbJ2j/mO5SxYxaW6bX23qD/b4stx8UCn/wleR26ENP1p5XAAANSDhs6snvdY5ORsLOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7047
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_08,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=894
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307050153
X-Proofpoint-ORIG-GUID: 3wUiio_cAs2N2zW3-G3XEi3DJkFYvqJT
X-Proofpoint-GUID: 3wUiio_cAs2N2zW3-G3XEi3DJkFYvqJT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/04/23 09:41, Yin, Fengwei wrote:
> On 7/4/2023 2:49 AM, Mike Kravetz wrote:
> > On 06/28/23 12:43, Yin Fengwei wrote:
> > 
> > Thank you for your detailed analysis!
> > 
> > When the regression was initially discovered, I sent a patch to revert
> > commit 9425c591e06a.  Andrew has picked up this change.  And, Andrew has
> > also picked up this patch.
> Oh. I didn't notice that you sent revert patch. My understanding is that
> commit 9425c591e06a is a good change.
> 
> > 
> > I have not verified yet, but I suspect that this patch is going to cause
> > a regression because it depends on the behavior of page_cache_next_miss
> > in 9425c591e06a which has been reverted.
> Yes. If the 9425c591e06a was reverted, this patch could introduce regression.
> Which fixing do you prefer? reverting 9425c591e06a or this patch? Then we
> can suggest to Andrew to take it.

For now, I suggest we go with the revert.  Why?
- The revert is already going into stable trees.
- I may not be remembering correctly, but I seem to recall Matthew
  mentioning plans to redo/redesign the page cache and possibly
  readahead code.  If this is the case, then better to keep the legacy
  behavior for now.  But, I am not sure if this is actually part of any
  plan or work in progress.

-- 
Mike Kravetz
