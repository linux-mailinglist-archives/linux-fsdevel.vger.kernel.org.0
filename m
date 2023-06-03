Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D5B720D46
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jun 2023 04:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbjFCCXN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 22:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjFCCXL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 22:23:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42628E50;
        Fri,  2 Jun 2023 19:23:10 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3531hw97006004;
        Sat, 3 Jun 2023 02:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=jTodARqyQJpIQE9kRcy7LBrGMmm557amqlTyQkL8NoQ=;
 b=UkKNE9OakrOsTngPnZzSnmOK1qzSQDKKwsr3YyXQq+OaFkqE/2/FkuLPad/s+vwm03Va
 O1c1dQbV3Qkj+5x7ejRoQLrJGMmR6hzkJdm9adM2tenkfY9pBvpGcbr3WKUq2KENxAJl
 2bCO59TKg3lA3sWFrpeFMqO8/PrKBuZZznN+h9qH9rQQu1CmQ11VcyBw/i7718flA4sK
 sFXc+CUbP/wvCBzCf0p8ZxVYSI2hYY8tKLXL4kOTMPr1MvmM9oPsAAnbtIzQ7/UJLAq9
 ZazvadQMUNzo+RRs01HMZmVywI12/2KJwmMUe0psN1yWVW1r6zisllmzSm85sVqx88ZG Hw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qyv41g0x2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Jun 2023 02:22:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3531YAOi037032;
        Sat, 3 Jun 2023 02:22:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qyuy78xyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Jun 2023 02:22:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/KUcVXe/rO4R8eUz/xhyTrH6Bco5ZFqTF/QX+kAAgk7bXt2xNyboi/xEdYH7tXAza+YW7ddI3picqDp2dbziTAwEd+XBfTY2LlJj0KwK3VziSg9DIltHhX/PmN+J+RSGkSK0ezVSvzlbIQ6FNvMdHh39YdIPbpN9T7BSKOQOqxcYwIlS+4Z4vjVeGwQ7HY7qH2OqEoVQqnGvLXws9NcEVIppd1E3omtNrngUNfhKr7IU3ag8SWiytInmlQwT+hdFHbrBVPIOefWDZeit+EDaU9KfaZX2tWcgiFyXtu5nmepVG1fjYXczoT/4S6hJNTNZdj8+HX6GUdqZYwTVNyj4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTodARqyQJpIQE9kRcy7LBrGMmm557amqlTyQkL8NoQ=;
 b=KitaNwgMkpm0RH/VR3/qVGKCZxADriUa0Blgp3dYifax9vl9D5nUg1+xS1abPWn66MdJgRvRTLh0ZMUnvyZoNpTbOAWl8Q0kTDqsMVI2eNnmXMGvNkTwknYdiLUJAIyAmuOYOzsFtdmA7bP3Qb1wRHKwnzNQvV7jK8LvJjefRfiuX+d3ePTlTbcy02Ye88qieijqdAOz4EcMOTNZgPSiNotu9dpiQup4SajL55jW3I/7avxfkBOGs8B8Oo+8ejJX0eqUypYocqRkSa5iNnyvzCEzdOxJ/gCUc/zrVDBfzbPKj7G5R72XQ9PH+7jqMFSNC9fCUJzwV7fq3IpDmK7Eqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTodARqyQJpIQE9kRcy7LBrGMmm557amqlTyQkL8NoQ=;
 b=gy8g2Jqfy+Cp5sEymBVsQGGifsh5udPrclOvFxvsrymq9HcA8G5yluWEtEzdr5Dlo2iG+duygdGsPaIelv94cl7h39QQuhe3W5AOwsei2ICr3oAjHr8ok5XDsAchXcjzYx92Kvr6oLDYeneDNOJ5OMmtpertlyRJBnf9HwjA5Us=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM4PR10MB6744.namprd10.prod.outlook.com (2603:10b6:8:10c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Sat, 3 Jun
 2023 02:22:13 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%6]) with mapi id 15.20.6455.027; Sat, 3 Jun 2023
 02:22:13 +0000
Date:   Fri, 2 Jun 2023 19:22:09 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Ackerley Tng <ackerleytng@google.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, vannapurve@google.com,
        erdemaktas@google.com, stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/1] RESEND fix page_cache_next/prev_miss off by one error
Message-ID: <20230603022209.GA114055@monkey>
References: <20230602225747.103865-1-mike.kravetz@oracle.com>
 <20230602175547.dba09bb3ef7eb0bc508b3a5a@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602175547.dba09bb3ef7eb0bc508b3a5a@linux-foundation.org>
X-ClientProxiedBy: MW4PR03CA0339.namprd03.prod.outlook.com
 (2603:10b6:303:dc::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DM4PR10MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: dee6b67e-abe6-4fa3-fbb6-08db63d95737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AXTm7z3JPKmR4V+Jt5aCTl9qgYfMhqWDCLB49rEbPh1ZG/KHfocRAp32UC9qxMcYoovzv6vl/mXzIp9rmsOhCIJ04uSQ0972i7t5+tCGrJxjZGq/F3KMygXB5FVeim6G/WgSp5RSb/33+x1x7DVJiOwxVM3Qag3CSNEgGAoP//WaUhDBHEZyX9ZTZL7WMb+QfVjhqCFwu1VedyBsIPZ3zrNsEMFkkeh8Vi/yvzhNjJjuo+rfFAxOhqFIWGSnlJ6b0z+6WLLxSk5SnCZjAPXzqrCnV73NwYC5u1deoKpWhaQihUgng6PpxW1Cc3ioMufU8NYs6uMx46D5FjfIii0xAKcwGas1u861hB0KKqzzDxsE8h5FLYH0VTHXA1eVTJSPAT9/AzEfsa/dMNGHui14+Js4id6V0reYcKnM5cEk4dzkhmfV/ZhHiI2Zj3GnIx0PTr+7iKKGtMeiYa0pTIogA6QO/Uohc/u7tjEo3ZyFZEbWVtgVQV41lG1o64dpJHeVz/bOKADUB9gp/OAPryHGqB5s1Abmp8qaHP+3KIC1T/tpn+ylDXE/zsf1nb9azie4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199021)(186003)(41300700001)(38100700002)(83380400001)(26005)(6486002)(1076003)(6506007)(53546011)(9686003)(6512007)(6666004)(478600001)(54906003)(66476007)(66946007)(6916009)(66556008)(316002)(7416002)(2906002)(8936002)(5660300002)(8676002)(44832011)(33716001)(4326008)(86362001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8O+wuTSK+pY+S/m8POatEBmiSfg9UFwSw2cfZr1Oy1KzjrUmZEkivUriA1x7?=
 =?us-ascii?Q?MtNhV/6nSZbUpao1FQhfeYucdid2+1F2ppmyR68Ijs6nmk7SrMyUp7SUhlDk?=
 =?us-ascii?Q?b7SByqN1HP48IYWnnkWMmj12k7BCRFrgYu/kABOuL6c2csNwI61PfhHVordH?=
 =?us-ascii?Q?dqS1qFmQioxNQXeIr0Pe37AmmW0aZkUUSOHBodUXpw9W3AlFFT3vY8eATKJ8?=
 =?us-ascii?Q?ntNNN3CPbxEpg3UxgvpWkr+44XxXEmAMwGhYctoCQmyW3Lq3wqMGnuYbULFE?=
 =?us-ascii?Q?/63pDUUbmYNvdcqL8p6Lebccg1R6/dKyBsC1ntuOx0hJPRuqpp2zCj9oSqz7?=
 =?us-ascii?Q?seybmQpWHILcq6+lYzldlpcHGH3T7sRMb3343TDCgtaVYxDz28f82Gh7jZ+b?=
 =?us-ascii?Q?g8zs+lFdR3T+EU35j8JxglcEw5q2Pgnc0bRw0SMcO6BSeKqK/A5xBggJYrEk?=
 =?us-ascii?Q?L/GITRN0XPPEfrv9nCoqkQGhZDriWXXBmeI4slL9bA3i53MOYZEBejCNe2PH?=
 =?us-ascii?Q?mkv+oWmK2XZPMYW10AsqnaoIqhWFLGPYR96PB0lPQOBHXj4cWwjhPKHfuXZD?=
 =?us-ascii?Q?UPBOLXkuu35LITyPx/0NTQQMZSOkb7eIXszO/U52RvSX5iJFlQsz2Ragkt97?=
 =?us-ascii?Q?BRJRL3KecjlS8cdv/LX9eY/n7Jmb39fbZQ2tmNQsBtVpPZhzg9IjkV1Z8noS?=
 =?us-ascii?Q?mA3O3xGLgfDpBhsRhSdhKN9jFJoSbF33sLv0UOaFUDFv7Ys4GcEaJrDBbYO9?=
 =?us-ascii?Q?mXxDHfRal3fxGhlFnM6l2bWYLsq70ZJBQL1IW2PgBxICLl4opMKP+kumbP3v?=
 =?us-ascii?Q?i9Jq0FsmY+rxqOYcbj6Tc26rcyTLL/bi0/UJlrOoPGoBi4GZzz60Nj6OAgUB?=
 =?us-ascii?Q?bMtd8gxfelA5I6zEoRV/7lzSOvB6Z7SIv5Y8ROgny/sUzr46IKmowTBjN0HO?=
 =?us-ascii?Q?GlisriLFndns/Mpa0hJcxkdlExag3BaLtI5OJM8GDjHL4WLe3SBgABYJge6n?=
 =?us-ascii?Q?KXAQpANqYN1LuY4z2CI70k61wggBtVNqG5wSu089AR9PbAWA+HutudBbL/l3?=
 =?us-ascii?Q?aOzt1UYbAqlE4FHFd8rL0vpWYR+H3cOeIBXgc/4lW9jupdDs4LvEds29w0S/?=
 =?us-ascii?Q?Rvq5Z6SH8zfGa0CEbl5ncXXFNLl6yGoSdy4uySZCMCjaPygtaxN/uY6b2TSk?=
 =?us-ascii?Q?Gv3RAR6pRmi9Gc+hEF5kH5NRgfmOFk2VGrNoORZXPxjL07yKB2iPPjoHrx0L?=
 =?us-ascii?Q?8HP0nZYvJzlgsG1cPR8aX7lokdSPHPQh8/JIqYMhrnJbJevIgsIXhEkxtNQ2?=
 =?us-ascii?Q?6Gch+IA3a+u8Sl1AomaUX/wuK/18XWxSWPqp3wtuYhAxfqKHjCbUuAMYTUD0?=
 =?us-ascii?Q?aUReBYAdfBi31MrD4BjLGtEaH84Yh4vE8JkyGipS9bEEmP452h1y/2nOgDFd?=
 =?us-ascii?Q?19WwhBruHwLiKiM0vXpl9GMQjA54NgOvnxwpdpFhIVV09phYxoAEST4E6cfd?=
 =?us-ascii?Q?RYwZj2K2GL2gnCRs4UJa2ID3fec9WBkH2IGtT/Ex2VSJEsa5eL4AaDTIjwA9?=
 =?us-ascii?Q?dYS6BghU0F0m1Dg14lLCVq2GLGPFK4JFcI7Uo4cH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?uIYt+UaXN2EOTq7N0Wxewt+PIb4Wj9C2xw0PXR9bfsVG6ew8k8v6n3yzdYK9?=
 =?us-ascii?Q?vgdzFhYr22BWuZs/R3Bvuhdg2ytBRslX58nVrC+NiuC1PHGm3kfjgi7mglLj?=
 =?us-ascii?Q?hIGVHAZk5waLnq/uPOP62d9CiH2t+4FO7oWNvNSCxvEklA6KQRNLfeYd9Q+o?=
 =?us-ascii?Q?HYNWUtnMTZc3tAASexiKlTPex97gM+nURb248ujJRSB5I9PFgYVYppP+TvfQ?=
 =?us-ascii?Q?nSx60er6ll59tgsCRKuFK6nRp573bW8HHaqadHKki8G2N6tVGv4QLyL/XA6q?=
 =?us-ascii?Q?HjxwakOO/pAE0kfOWMnW8MBUG125ovqGCe+C2JruSYyPYa9jpZEDZzQsfDgk?=
 =?us-ascii?Q?0f5R7fWL+WFXYcrt6CY66Aq7cSklHYloMcFboxssyeP1QiSGYxaeTOUt4yq7?=
 =?us-ascii?Q?VcEAhyw+DRaVY31hJ5nqyY1noQqi3tmKz/NF3y9DAfhLxtx+90/UTa4XvWkO?=
 =?us-ascii?Q?/DZsU/PzOz+mPRCrbFoDn89IZBvQhHfrLEA7vwfoC9MJUvX+rr3Yjz71k1qb?=
 =?us-ascii?Q?nQ44M+z4IK0e2Gwo2Jix7OxOJdRXQAhNt3QG71azJ2ZlrhzDA1J+ZssQ7h/j?=
 =?us-ascii?Q?UvAuFuXKSGYVALB0a6FDn5RqnxKI4OtyodM82BgDQKIltsIWpctPOfQ44ZW0?=
 =?us-ascii?Q?BXV3p/oXA82/JmB0EUDlWzksovWYX8FofGoia+S5aNShChhmEuF2SLT8eofF?=
 =?us-ascii?Q?QP1/4lAPpv/zVQO6QK6H9pPiaBxTy/O3le6oZBbQ2uvbmCrtBcrQo/PM7tQg?=
 =?us-ascii?Q?j6NvS2CmBiOz/hkW+3lC9URavmLihavJ9b5sXt4WtFJljIDREOP9gnBBcTsc?=
 =?us-ascii?Q?e7Px5KUg/z9EB6agscn8ts6ftQeRSk5RjK4Wdohy2w68s9fYy+O4osSGls6w?=
 =?us-ascii?Q?P5FHL2KXeZ5zL+7FMVcsatxKKMLzh+qjyZiigBJD4+qDsCfH7hd+n4CdJ++b?=
 =?us-ascii?Q?AiHtXuLAQjC45c5NHuYE2Asch4SXvFSgZuOyQYxIcL0cSfEX7GFoR1bZwksv?=
 =?us-ascii?Q?UJsg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee6b67e-abe6-4fa3-fbb6-08db63d95737
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 02:22:12.6566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tr/5X6F50bL8UkCEvhc2AaTm/B3/NdtpyttFXKZpfuzC48CQJYzUFJ2AIOi0lQ16Pqe74ueQBLFRsi3ocKHjwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_18,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306030020
X-Proofpoint-GUID: N2vzf9xDLkLDIo7NQY4k5Zic2R_BClaT
X-Proofpoint-ORIG-GUID: N2vzf9xDLkLDIo7NQY4k5Zic2R_BClaT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/02/23 17:55, Andrew Morton wrote:
> On Fri,  2 Jun 2023 15:57:46 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
> > In commits d0ce0e47b323 and 91a2fb956ad99, hugetlb code was changed to
> > use page_cache_next_miss to determine if a page was present in the page
> > cache.  However, the current implementation of page_cache_next_miss will
> > always return the passed index if max_scan is 1 as in the hugetlb code.
> > As a result, hugetlb code will always thing a page is present in the
> > cache, even if that is not the case.
> > 
> > The patch which follows addresses the issue by changing the implementation
> > of page_cache_next_miss and for consistency page_cache_prev_miss.  Since
> > such a patch also impacts the readahead code, I would suggest using the
> > patch by Sidhartha Kumar [1] to fix the issue in 6.3 and this patch moving
> > forward.
> 
> Well this is tricky.
> 
> This patch applies cleanly to 6.3, so if we add cc:stable to this
> patch, it will get backported, against your suggestion.
> 
> Sidhartha's patch [1] (which you recommend for -stable) is quite
> different from this patch.  And Sidhartha's patch has no route to being
> tested in linux-next nor to being merged by Linus.
> 
> So problems.  The preferable approach is to just backport this patch
> into -stable in the usual fashion.  What are the risks in doing this?

Really hoping to get some comments from Matthew on this.

The only other user is the readahead code and I have little
experience/knowledge there.

Unless I totally screwed up the code, page_cache_next/prev_miss will now
correctly indicate the lack of a page in the cache in these edge cases.
Since readahead is more about performance than correctness (not trying
to minimize), the risk should be small.
-- 
Mike Kravetz
> 
