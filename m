Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868377392D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 01:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjFUXDi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 19:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjFUXDh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 19:03:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DC51BDA;
        Wed, 21 Jun 2023 16:03:29 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LJvcn3010110;
        Wed, 21 Jun 2023 23:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=fE5ArEc7+uapWQsx4vC5Vf32tGojl2n2UKQaD73q9Ps=;
 b=WbR5/tMxNRVZfOf/etaaGVDmdb/JbU676NVnybuT1p80fuaPfZri5egPPE5tfse1/qgc
 GClgSYaq/fG9hW6FGrALbUhgiM/sYUfmqoxnrjDjs8pvswc/8VpkICN6EHCDAI61aOzO
 YLgpwVVyVHxnp9xPjrThLJ0JmAafLrHhUs6uSMfCzXKSk99lVhKfkRam85DeoNBc0Pbj
 g68NNPaWy+NUHoC391e7jh0Kcf1x2qkmZG6GpuBQGawN5zH88rcp/1xcfi54TKQpZ3Qy
 wuIw5/nktnN7+YiJlMtrxIztcWS92WDIKzQR+ddBfTM1Xm9xQLVIe6jZ+BSuPNZ1J4/y rA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94vcrsd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 23:03:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35LLHrKK007118;
        Wed, 21 Jun 2023 23:03:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9w172gaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 23:03:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCeFu321AS7Gh5JEZumUH05Nlz6omPvbbFQ254uaYP19nLovtUy4ydavQN3hX1X8BU5Rx0mWyazS8BKn2IsDESfNf6KFLZ+P9zcwf7UAxhI7EJojL3svrEoS8tBphJqHFB01+JEp54qakfohI+pjFJ2BSztkL10IBcK/RLmWV+nsKX2ZT8Y/iewWPU6qC6RaPxYDv1+/iuR+yF8/xyWrDxgFtetw/ghD3Rc7hwfz6vscqkmdz6ToHykYDiquSmUaMs50fSjqjROQ3QC5BKcFUHNjuvPg4X0bWvajTrzxMGuQMnml1xxP49f07QDvQvsbNmjzoUnC/qjf5XJaq5NCLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fE5ArEc7+uapWQsx4vC5Vf32tGojl2n2UKQaD73q9Ps=;
 b=bAQo8Ym72htPxTn+u3CnOYhffLgMlyVVy2Z2MPXU1GqcQNyzJy5gSMXS9/EsSiU7Ba2D8JbXaThJrtwpxsOR5UOcMpYhjxAhgCen6CGqD4To8KQ6BYjt1AS7alhYLv7iYV9NiBFXt9/6eAXPUYoGZeJ87t559Us46tEzNnAFQ+wRjnbA7Eb2AjU+Zkm+a+zSK1MTksFJeFKayn+eUcbQW6CqH+45WRHQHMVDGyyq4Ze2V7TSwccEQKgdAMaMoAEPaekfZABunFHEDsovXGwaxwSHQzkKSp7tZuZnKNpPNCArVzC5SaNQrl7vCQOnQnfgKwaPg9oWuiiFu//oNlOKeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fE5ArEc7+uapWQsx4vC5Vf32tGojl2n2UKQaD73q9Ps=;
 b=zBKvsVfFwwcnRTe80+VnjuptAjPd1YLx+7bEfezNZu8h0ZfrM1spTgLAe1Dl6tuaZt+jG9Z54F6PR4oZT18nx6BkruMK3ugV8F6aJviKO03hIm5+mpc+c/LWJExQCwHWKWhtc/3yBWUJpNbIYrti6XpXCk3h4fKzXmp8E1cB+bk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB6462.namprd10.prod.outlook.com (2603:10b6:303:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 23:02:59 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 23:02:58 +0000
Date:   Wed, 21 Jun 2023 16:02:55 -0700
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
Message-ID: <20230621230255.GD4155@monkey>
References: <20230621212403.174710-1-mike.kravetz@oracle.com>
 <20230621212403.174710-2-mike.kravetz@oracle.com>
 <8a1fc1b1-db68-83f2-3718-e795430e5837@oracle.com>
 <20230621153957.725e3a4e1f38dc7dd76cc1aa@linux-foundation.org>
 <20230621224657.GB4155@monkey>
 <20230621155203.40c9e05d1a80f522f7e9e826@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621155203.40c9e05d1a80f522f7e9e826@linux-foundation.org>
X-ClientProxiedBy: MW4PR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:303:8c::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 76b43577-e89d-4c4c-c361-08db72aba809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l2GhVOYHzrUSvOxxYSVy8dOltmmKCs3yHiIBfY+3qOotBGcJqaANnP67+z+KSV7ZwVii4DHFb3gmPFrCLnaWWpA7/IT8wDMH5Qp1B0bz46h+0ss40peY9v4fSsABNxMDpNxyriikPQIkvn/ZVbJHPEMxkKPzzADSC4OC5mSD1gTEcD5TRezrieZsWSw2HHp4ENS6UDlJlq3cb671AcgdsXkfgXwv7TZkCcdEJt1YuUaAnAOJ9h5sZdDgCQieseijH+gFBkd2aLS4rsN5rA9jwBIQtwwd4Uj7uRCasM2AGEexnGptzQ0lRUOgigRptIAmjD1Uh9pzObQ1DXALkiachQCbjEZ5vDW+kNADqvgwi/IC+9YnD2If5HX/JluEFved0lWIjkpuAfUJnQ5RxPP7bxKQC6x/p/YRE/wQ1pTKRBYurF9f902/fOOTFuTNGbatXsS5PpU+h4/DxbTkTG8N4uh6pB6nXXgYUkDqaZYzjhalDgyh5eImqXEW2e3/qJUF7rDeZKPeDJVDN4EYuOHkB4vq/9hU4fjLiYWApeFYwGg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(33716001)(66899021)(478600001)(66476007)(66556008)(66946007)(6916009)(6486002)(4326008)(6666004)(316002)(86362001)(54906003)(6512007)(26005)(1076003)(6506007)(186003)(38100700002)(53546011)(9686003)(41300700001)(2906002)(966005)(5660300002)(8676002)(8936002)(33656002)(44832011)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JlHtjgWM2tXBsygE0RWgHjfKTFjSEQ+YuFCVnLgZmLj1IxSG9a45Wi9Zo1nz?=
 =?us-ascii?Q?ZSfzEIE2l2F9jcqdmN0E2lSDvMhk5p2uFa+EsKfV78KZsB5pGYzcXs+h+fVq?=
 =?us-ascii?Q?HuR8SHyI6ICYr1CeWFst3Me8O6l+TF1SuGf+QcivjbhU8M+9wobbm0ReeftL?=
 =?us-ascii?Q?/14HorTORErkz2DPDXGQNYW9aPpXF8ZJmmAhZfRXRbR48myqCBDEsEj7YE5/?=
 =?us-ascii?Q?wJpKuQmRENCSIKsd5vLrrQdmOluM/Doo9V/+aXOAVO1VjIOB3maIerjyGtJ4?=
 =?us-ascii?Q?8YBJcPkydINRam6QeVdvyCixE2TacSkzFfEsSXIpFwkOJf/FfLm8XSWXym3W?=
 =?us-ascii?Q?NrGMqSDkO2OYggmzOsndsfNDMv1br9+K8JkkyRe9QdTA8ELk4fzwBoIAP0wF?=
 =?us-ascii?Q?RT2d1RLxsXBvUg/ccEyCdeR89tu39PSBQuQJZNKzOfdWQMKRR1E2pzIaNv4H?=
 =?us-ascii?Q?PkuTzBIPYsjGIblhltB3NrxGVDQhvo/erv8gWjkK+XR2djeeHi6q5Jry16sA?=
 =?us-ascii?Q?9EHIfM6CBVWazlzrFzyems7nG3dRYFjFlhzVMxd1nlEMTr9z0M6FyNy+PThy?=
 =?us-ascii?Q?iUaJ179eZCrF1x7XJpNoDCjtjjFpdYfli1SixE304AnKCEboChgx0VUH7CkO?=
 =?us-ascii?Q?JWCNAXKVQXkw8waLpMb3M3eV21uOts1pfuucYxc3H32GQgf8iSyNLBgQy6l4?=
 =?us-ascii?Q?Z/Hi4ip55j/0hZ1urt5mEliQM460YInhFA/93l91ZumnNNTOW3/koVAiCBf1?=
 =?us-ascii?Q?s2wj3+qy0aXdBfYGWknZvm+DPwCAIT8TPQ4IIi/cm1aJ3pG+SSdxFZCur0df?=
 =?us-ascii?Q?h2hs5k5R8sPtOeE+1hg3HNfMxUVR+HdNt8V5fVLynJ4GOpHJrxUx/U07b+aS?=
 =?us-ascii?Q?Dvs7x32peWFvTqnm88s5iNounUVVfjBTycuxVhp2ZNKuuVLo9izEuzS2KKQs?=
 =?us-ascii?Q?WnfIpkbmcADJEXFJ7Ig3bpmo3wW9TjBDLNfEgwOCZf1j4U1gu0kV1UX9HtN4?=
 =?us-ascii?Q?JJjQkwThZEZbfO7aWSh8h/MFWPwZQ5/BaaEci+Mk2X6nBJWceCCcvBz2JAj/?=
 =?us-ascii?Q?MNq+Q7wQaxIfTpf5eRnxcXnLu1ZaIefu6+NAZDTdvhdxVtn/uaHMq6N4+ef3?=
 =?us-ascii?Q?3nniq6yfrqRiiDJWGtDOWSRjG+Bmm2F/fKw7bzJYmj0372rrfRhJ6RBDxBAP?=
 =?us-ascii?Q?hxCSC0GC3+/6LJ1GYf4bXM+uVSLRb4czCqgAUeocoyD/mFGloEN3qHlNzNZs?=
 =?us-ascii?Q?LoQR3KbIPkZfN3HUyCYgeWWMjeSHekSQHZ8cJeDss6OzssHrioovwWY/+0xo?=
 =?us-ascii?Q?1v4CWkrkUuV0uXI4OIupsuwrbXJfSB4CsNf37T1bDkX6fzNVPf6fCmT001gj?=
 =?us-ascii?Q?zojeoCHirVpSFvf+u/YzLbZ89fHj/gsCYbDzL2U2QpTMtfGV2rGY+rWJXm60?=
 =?us-ascii?Q?mLtvzWjXFx00ksC2vcQp1gWp0AbWOn/e8JS9kDllZovOCBXPMM1rxiyRSB0f?=
 =?us-ascii?Q?dG5zVKfJlgAhBNJTB8SnnVzZSISLJ2nvrjgJE8XHHbWXHZvITqhXAHiOd9/+?=
 =?us-ascii?Q?4BnTFTGVuYwCWDwuTyySsnPbkS0OsjUKbABU5uvitf6buNOUaPeB3CHBP2le?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?wybxInCipbNbo6/q0Zesli2LbNFakmjt32VTvE3MvEuGxzCp23+4sLOtLsfB?=
 =?us-ascii?Q?9QO8gBPS0Cqa7+Td4VM4DBwpYMRkG38oCh19oKKSWUu/yq/6cqPCnNjagBBL?=
 =?us-ascii?Q?eObG2j88bLEdQDUTTK1FJNi7zXHHCQeMxRXdWrI+bo1PHjNYqHEW5phpTycD?=
 =?us-ascii?Q?W2d0OpkANeZy+Rz43bUx9+ZCFf9blb1jWirXLjYCCVqeB2Ooo6kbsxlIA+V/?=
 =?us-ascii?Q?hMvARUEE2QMgl6t9N6SajsAubtArmSNe9uavloZj4d0bsl+w4106JFTww6VT?=
 =?us-ascii?Q?o0e/b7hJ/S8zKZihzSJIOfiVxeSrSQ1DRfnDntrl6ULbWCK9wg/ryGMTFLDv?=
 =?us-ascii?Q?BLlg+Fuf62AkE9oZyIiL466QI8j+lk1CZgTvtC+pcZbJ34keWopNQ3/R+Ofq?=
 =?us-ascii?Q?3cR9ffBHvinQ3Ev7P0FQpVdsuyKM4g3eIzV8oGpLBh5OndtK+qKa0yp+F9eA?=
 =?us-ascii?Q?aQt7o2CPrGQABKufmTb1mKvlaNVO+1ELuftjHp2PTDcLIfqFVhDQd3jkB7FI?=
 =?us-ascii?Q?ja1mNtKI6GF9E2gLJbSCScUHLeglMXnnOKd5qerNSbYBw6LRnFWeJ6sydeyM?=
 =?us-ascii?Q?cG2wcjXylq22KYPyZ7qtVhUJLSbrp6xxsunZr039PW6gteiOHDxApiDnRrpm?=
 =?us-ascii?Q?bGsp0CbSTFOX5Dn1H/AhvrzPTCDPZkybPcUDCpqbDVp0vo4XDTHzeVL846g+?=
 =?us-ascii?Q?Yjqyy6uVYnubc6ItA2SCS9u+2qokZrOJMSw/Fqe28vMWtAOJilOKCP4be/ml?=
 =?us-ascii?Q?HJF5q5ing5qV+h2tSVdcgtHcVw7u5huZKptAb46ukjN+BtEwXXIoN1WMc07c?=
 =?us-ascii?Q?yrbRUH22bPSJcKJa748HrW/WVdEcv9eE5zE12XUm0NTUNUPIxNnNAe1hm1AA?=
 =?us-ascii?Q?fxNynZMt5sKRoJRWY+NlNhtepU39sIOKWaKa900cIHZ5yUj3ViS66ZX0sdD8?=
 =?us-ascii?Q?ArvcganjlCMYOoZQdEUJHxFOOCctSttBfs9zQ8VjBhv9CV/qvPz/J8QnWX/9?=
 =?us-ascii?Q?zcVa?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b43577-e89d-4c4c-c361-08db72aba809
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 23:02:58.8686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OU/hC7oY532w4y6AaomxyD1yZfiPy4uw+7zXo0Idrzm1lCkm1vlUuDskgYOqgL4B2EKVD2u36dNegrO1Gf4g5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_12,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306210193
X-Proofpoint-GUID: YajxIibxHfoIv8m6eKNbtcac9eVnBWvJ
X-Proofpoint-ORIG-GUID: YajxIibxHfoIv8m6eKNbtcac9eVnBWvJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/21/23 15:52, Andrew Morton wrote:
> On Wed, 21 Jun 2023 15:46:57 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
> > On 06/21/23 15:39, Andrew Morton wrote:
> > > On Wed, 21 Jun 2023 15:19:58 -0700 Sidhartha Kumar <sidhartha.kumar@oracle.com> wrote:
> > > 
> > > > > IMPORTANT NOTE FOR STABLE BACKPORTS:
> > > > > This patch will apply cleanly to v6.3.  However, due to the change of
> > > > > filemap_get_folio() return values, it will not function correctly.  This
> > > > > patch must be modified for stable backports.
> > > > 
> > > > This patch I sent previously can be used for the 6.3 backport:
> > > > 
> > > > https://lore.kernel.org/lkml/b5bd2b39-7e1e-148f-7462-9565773f6d41@oracle.com/T/#me37b56ca89368dc8dda2a33d39f681337788d13c
> > > 
> > > Are we suggesting that this be backported?  If so, I'll add the cc:stable.
> > > 
> > > Because -stable maintainers have been asked not to backport MM patches to
> > > which we didn't add the cc:stable.
> > 
> > Yes, we need to get a fix into 6.3 as well.
> > 
> > The 'issue' with a backport is noted in the IMPORTANT NOTE above.
> > 
> > My concern is that adding cc:stable will have it automatically picked up
> > and this would make things worse than they are in 6.3.
> > 
> > My 'plan' was to not add the cc:stable, but manually create a patch for
> > 6.3 once this goes upstream.  Honestly, I am not sure what is the best
> > way to deal with this.  I could also try to catch the email about the
> > automatic backport and say 'no, use this new patch instead'.
> 
> OK, how about I leave it without cc:stable, so you can send the 6.3
> version at a time of your choosing?

Perfect

-- 
Mike Kravetz
