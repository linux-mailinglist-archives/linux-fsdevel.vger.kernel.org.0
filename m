Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DF8748E85
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbjGET7U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbjGET7K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:59:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307F4E3;
        Wed,  5 Jul 2023 12:59:10 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365HxFX3011842;
        Wed, 5 Jul 2023 19:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=5Fi1YrL4X+0IjutoFdM1ZcGFOD64fPvPG8IHZ8vHtpE=;
 b=ffccMBy9rgQ7mEFZWZPRR+YyVkPhXTuW3mBrIMmRxSEPTHRbiNxriLu8qy9BRGyv/Om9
 /38tnMx9EJxObqI+KzlAAIRwH97yo3f81aC6FBRGHOQum2/Q1RuweBfttYyUtjfN28/8
 Pf7JRUSou8jJNc1yVhIw4ZjthletpamKJoETphTqLbGkHynLZ2B1kKcVCkxxNBLLzmmS
 AyqtNrpab0Do2L0cLR3EXSBw2vGksBslGaHKsfD7sDnIh7uzlP0EFTcNqeI8ndEkO5ZQ
 jIxdvdtHX3XWjUmJucxspcwQVrzk3Y1OXoR8A/BN4xwXw5PHuj0Wwb3Bsexye3gwPWvG 6Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rnawv8pf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 19:58:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 365IToNk024594;
        Wed, 5 Jul 2023 19:58:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak6htn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 19:58:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azvHXbNkBEfxVtqiRsSWvCau3QLTqpBH85XHFqOfjQvR5E/GIoHwg51gaFvzaS7HZdHy3bIgyo+Ec2LX9Aygcyi+v471mkQhDF9HWAOJzVZDPnrNvCgBklvp8/zQk8UOi8Y6rJlrFqLmSNqj70KCRMqTOXmkV2ORTzm/linlG9lAqWGkMjs9ZQmgJtIO78biJHcvJ5R83H8BCX5FUn5YtpieGpyt/CcyU99obASxR4kvQvWK7z9pN2HEoHgIy/QeCm0rJCfvTRceEiaiCX/Zd4APkEfV4qHiyOM8IyhKsdCq6V+eSIp2UB+93maVa5l2EpjEXQoHenb/GH2ScsczbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Fi1YrL4X+0IjutoFdM1ZcGFOD64fPvPG8IHZ8vHtpE=;
 b=QTPteN2RRe/c/fWchkuvxpGMlL87lNMsidoVajSMU8RpmA/8g2DHhdEVKK5VD3yDFm6bi/EYzj2uXCzujrApgmUw2RVQpRZEDzdQiYtNlKC/DO2KYbyVmF14wb5mFjhjtb+PJN9o8X+r3uYaWI57NwOZ4B6OD0ad2SOAFZk3P9io2mygCEXsvUKz+VR5/0i3YylVOrvWOkTojaon/F7doQIIiyE9HrlOuOybfwnA0O7Ul9MtHQciQj8lYf4ZBnlcEVK9+Lhpq7lKJxro0/0HqQXjMGbplp4f0QM3hdlyLBljN5Th2+Ky1Ow5bWE2/LlRueF5+drPfCEFFqVwNMstlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Fi1YrL4X+0IjutoFdM1ZcGFOD64fPvPG8IHZ8vHtpE=;
 b=UOPVlYhqDe0hzbhl4qD7O5VQPBUZJIysvuhZVTsymZP7anW0Kv1WSObg4O0ZeGDnoE7oKlyoyrTmDzaH1k37vyHZ1yNTFw8VI1lIG7EXVEMqc36DkmhWc2KPggkE4BbBvuL8g2VYpWHvN7okEbiLdNwaX3LkxhGWfuhWIcc7Z0Y=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB7217.namprd10.prod.outlook.com (2603:10b6:930:71::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 19:58:54 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 19:58:51 +0000
Date:   Wed, 5 Jul 2023 12:58:48 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 52/92] hugetlbfs: convert to ctime accessor functions
Message-ID: <20230705195848.GD6575@monkey>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-50-jlayton@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-50-jlayton@kernel.org>
X-ClientProxiedBy: MW4PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:303:8d::9) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: b8a6f67e-d4be-459b-71aa-08db7d924153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xPmk79xmPT2HZEj/Bhv73MxxKEFGiiM3bstfuDY2tPBoTsnD6dCgItQCmnBQalzngt8K91kVHbUNuNsR5hkdNBFMS7owkQ6IueFleBcQBJqqh/8hokozIFVfjY9cF089ISaSa3++bYARTy2VE0aJVcurpxkFBAKgb86BwC45tFwMg9usaHxexkPrgo6surYfI3102ryUf7szn+DUG3txxOFcBCXqwrXvNcrzbmCIdclfXQ/DbV1/Iyg+cbzv97YZ7Sld44EYlBZJOwK6w60sGf/g279OaU+WXr3cy4v1L54QkxjUzkWNoeTN9Rs1KpYbkKOfDj3kpklN+LP8wD+ZX1c2pz5NHqBBAxdqYFgK1R30wbh+L7he4khyGPG+MJdnGO7gOcqk4Fa52sL6O4h8cD/7K4RQ/ibohKPX5wCldsRHdxooSk58Fz4XNHRjL3AheG3pH10BeF/VVhu8Py4SI8kPNjPs6Orb9vyLJ82fcm8IucJgIxioZmtHcd+vsltmgazyOBh8tNTscd14ZzWNzwfMJTN6x/65nUEED+/JtAKG+9absBsOjx5UkYX3FHLQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199021)(8676002)(8936002)(86362001)(83380400001)(38100700002)(316002)(41300700001)(66556008)(66946007)(6916009)(66476007)(4326008)(4744005)(6512007)(33656002)(186003)(9686003)(26005)(6506007)(54906003)(1076003)(478600001)(6666004)(6486002)(53546011)(5660300002)(2906002)(33716001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aQ0F/IlESF+2YAb/Wz8O3qpR7lXtts8Dqldx17U2631WDjuCNfDYRL8BHHxc?=
 =?us-ascii?Q?xA8+za9w8f2nQv6f10sidxj/2jGg+u4Yum0V043UptogwKbuShRQhEelnM5d?=
 =?us-ascii?Q?ZtUVGdYd5o4uLlyawgOebSStutWmrVfZWLqxeEA1cYrCELNLRXa+x3fWLU4W?=
 =?us-ascii?Q?yf5EI0cHTki2/eoX2fMD6wy156YOr33Mgsml2B+uSFdkNq2O0SeRI28Q4sY3?=
 =?us-ascii?Q?A0yk444rZkgmyyynTwEFOXlwTMz5jX5echYR6ZDD7cjbauVScP+jiFU4zsSm?=
 =?us-ascii?Q?0GKxi51eXDcZAIxIdPMxSW2EYhmYMJDbYbuhQVZxDndS03KrlEdj3Ryd1xCA?=
 =?us-ascii?Q?DF+LVfcqYiKNouE62gCwQ8BTLMX5+JMkMUUIt6bv/C4Z3UEyf8w+vswKH+/r?=
 =?us-ascii?Q?yI23X1AYUTZBAiOoXXIpz6uuOf5y/NbApFZBIwr0OsM6uKnEkNd88y0uE+5C?=
 =?us-ascii?Q?oPfU0aLLLW9k3za+xbwzzSnJtsnsW9oZOKnXX35J/lKJSGESQDqdF959H7Jq?=
 =?us-ascii?Q?jPZ13WVhoziQp6AqDtZD2BZcTcYd5I6x8YmH/6Q8ELEwLOscFGZ6U1oo08U8?=
 =?us-ascii?Q?Lqloz5idMSHY9LOrTfmeSAtZb7GDb9VLpv4dV+DqY8FgQ3jr1Pu9OlOLsX0x?=
 =?us-ascii?Q?3EEQ86ah7uftKdB6xgBYcIpfsfypm4DIcR3tVceO7AfAazKTpCFFZ8RcdNr9?=
 =?us-ascii?Q?I7FHxuc+DzX2Xr40y1T79pXSqg4VSKHuwkLMKhFU45/Gxo4aryApUgxibS7Z?=
 =?us-ascii?Q?DaJ3RjaAxUb1QMpATASbFZ9ABN4FK+BEv4A9Mz+R41EUdJctYXW4/eRZKm4y?=
 =?us-ascii?Q?ccjPWEg39plTXDZx8wlKb0xz9IjL4he92oA8hx7R6Gc532UAl5IgXQmu0zvY?=
 =?us-ascii?Q?0p1oYg99jNr+QAp+AyTeuyqTdnpjLNac1KolDCkfQEmm95To3kEghbhCuOST?=
 =?us-ascii?Q?9l7pMmpCcCdUygK2PHBDiLj/S/ej/7grBOSa57rxhpGVmHSKVVTA1KnxeiEf?=
 =?us-ascii?Q?5a+T5p0EgeOOFp13h5EjmV9BICU4JLrCfjxhQTCMY2qK4jwDdAIe3btzGDcW?=
 =?us-ascii?Q?7p34WByBfrkenVckjHwcZzEp5y9yHNdljWNoNvlLSbCmoKXIQ5cFotLwTqmz?=
 =?us-ascii?Q?ySg55JFo59Ia10Wa3KJzS4r6bJ1QAnL2Pn+EaI1qR+h3SJHfYDXVu7OqHUvi?=
 =?us-ascii?Q?DXI+PewYx9UqXqLqI/KF2ha/e11mGUJGcMDcdl4DM6luCLrr/PYsVsU45Q92?=
 =?us-ascii?Q?V0gloQaeZhKCQff0A2R3ZOU4BSXWzUIqlA4KDqAlna2Sm92PWktPFZOhXReN?=
 =?us-ascii?Q?qPNUujRqAg9VXkG6S5Quh321svVtQ6m/FiuDKaj2wNIPi40O0N3jw1y1Z0VY?=
 =?us-ascii?Q?FBV4eE0jgpcDRXv0WKtS31KpunXQRMrReth+S70ezVlBi6FGNeNBt6W7d453?=
 =?us-ascii?Q?DCcGJfCaCpd/bbdzkz8JygkeKuVfmuO0hwvKzSCFyf/McSnynLQ0Z3PFSnk8?=
 =?us-ascii?Q?UfBuupLuYyTrkdpVDt0AxoNsqkdLwI+JA8s926B3RR/yJsuZlAys2gslzmhP?=
 =?us-ascii?Q?uStzfTpT+Wk/1ionj5w/dA0uApcIsYCtepEBwsMu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QhFnGVJqZrCY5qYTr6Hjj19lAn6pVonYHoLGdHA/lAyNlFz54x/r9qzfG0AUSIDZrNhwpPgA7QcpxfbupGvBtn5oTmG2sBj4EWMA6t23YdVC0b09WIh/X1EKgqnuzyPs3FZ8VRBnAjM6A8fRvgtxLJ/bKiDxU5YoLcb1cONYQ369rJLXxrsdan1EWWKbiJsgXTMj8qIcRuTtueEapphuDJjBFDK+jZ+CGc1WMTJtbbAQUiywvPVRxnBl6gjzKscm/Ny/F1LXbM6nhcYoqZxDBqCPmX4NB2AbSag2eVOtv0phQ5d7M9BRAcs9g/bIHeQ1LbxGbyLL4YJWeB4h94JtssA5bNDU5a593WkGlVn39tUZc2jIvDZaVawTcA4bqY6PlgMID6xTBQTbUj80Tb7wahZcNJKljoRkQVTsTfWScfsxkzko8LFCuXFw1M72jSSNEmo+4yJGlpJ97Cl4lEjPqZI2rINw5qXuoxKg+l45IFaepq9ILhZeOyOfntrRE/jBlVZ9NplrYwI9eF7ym2LQW7M9gVO/OXNehXoIapOu+AdYCEffTjty3QbV9CudoTHnIVsGfTB1Khrn5JMDVkjGMQsWfQ5E5iQSK9Zp7QCFj7ZF6KVKx2bb+cwocNboWUavXClNdgQuNNyr/bkYaYtlOAexmRE0OyK9Is5bKqnG5V4kZL0VplX371HzG3y6K91E4DeHQtntBSBIHBf9RSvolEZj/XjtN8mK1t/ggYLfxfsMC0vwihQG0mAN6W6gTroX5jCGkRI+5aJSdQvxa9I0kBfL1ALSGsrkaQRTIfLRsCr6OAv2DvpajFvfX7oV1z/2AOp2FDhQ9jUvkW3vQ2jcSTEyQWL7nt6d+ZRTBDkgX9VUJpAsANzQWtDVDuG3asmy4HlVqJSYE2QHp5oGa3uA5wud28eSW9n1L9Eu46x6Xzk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a6f67e-d4be-459b-71aa-08db7d924153
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 19:58:51.8943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qSNZw/MZHG/vRsoOBhvJrbqCIgUjHt6edf8WLdz/llb90z0On1y3BqySROOncp/zFBpKMK3XJDAozaKomz4adA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7217
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_11,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307050182
X-Proofpoint-ORIG-GUID: r9R0JhOnsxguWDNiYOXDGDgEz4Ha2TQ0
X-Proofpoint-GUID: r9R0JhOnsxguWDNiYOXDGDgEz4Ha2TQ0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/05/23 15:01, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/hugetlbfs/inode.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Looks straight forward,

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
