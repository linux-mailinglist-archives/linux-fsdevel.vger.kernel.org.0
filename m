Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6CB733824
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 20:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjFPS3m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 14:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjFPS3l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:29:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885DA3C16;
        Fri, 16 Jun 2023 11:29:16 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35GCibtd031355;
        Fri, 16 Jun 2023 18:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=T41CyW/PaKixRn6+B404RftKy6s19yKMzto4qpSWycY=;
 b=n3CNwfPv0dVPMcQndySsoOIUgthRi/iOnjg0fC9rQtzvpvG5fQCHkBaClhHIk+zhJ7Z1
 dKuwRyddi4fXX8sBZJANcYwgBJl1Evhj5tBmaFxjQTigmRVMHTZbaZTqLYrJzzvllxrQ
 sLcdM1AUA//MxDtZIuo73j1lPXE/yzGznKG+6gReSmRl+E96eVhHa4ebBN8mdLHF6fj3
 XZrChnkvTox+mZrlonpMYOhNZEparpqbWynocqZSYQhLh6i5f8PcVo+OLiu0bMVr+luT
 fCm97N9xOffTn6tJ4prJWsWUNucEMo0UucionydME+HCw7L6SdIT2dlfSFXWdle7qW8/ ZA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4g3bvxbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jun 2023 18:28:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35GHdBJG038917;
        Fri, 16 Jun 2023 18:28:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm89nr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jun 2023 18:28:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asnxmfCuKenHRI6ZHTczR/7QHLQM/99/BrjkEV9coaR47Pyd71m4j6DZUsUZxiskXk++5JfIIZSmEm36V0CSbAdJR8GQR9MQu71Q5Nthc182igrJJQGSjoputchn6QXplvDbvym1P+kIaiJtg6nvbSXIz1JPoqdD1DCeHZ7cLboiU3mpf2dHC11RH0a8BBk0av5Ajjaz+kltMvHglD16MxncWg/OilTk5XUQZOka6GL9btXkBx5DCUKBn+g0k3+M0QAgOKCugiS/kKibbINFJjqwXFTrrrst0dMPomTZubd+aB2OdRpdPZyVnJkXAgY//hkATjh23zivKV701yBNJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T41CyW/PaKixRn6+B404RftKy6s19yKMzto4qpSWycY=;
 b=TlIOUBj08covhTY5MohnkrVqDvR/3UwaZepcP+x8pyUEhLuVzYeSgPpOpOyW6/1QHp+Nr4HoXztTX0yj4sGgXs6KrcP33lPo432bn5MH3+h3PzexZekUk33pBXPmW4ufB3R8RJtqEEAaZJfsXA0Jd3+gzVzwyVHXYNFuryBMjKZ8aGO90rCzTnycaz/FwDFS++uFl7cfeOcIK1Gq7mEpnAHvVxEMK5u7I4lkTSadxk/mfqg+El80jZ4orziyYsdEre7MXO0iltlbPW7tLPmvtsH7nbD3QKc2WiYjHNFAKTxBEWstdGgqbxlbZwE05VVB0W7rBL2GZQ25rVIFKqASAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T41CyW/PaKixRn6+B404RftKy6s19yKMzto4qpSWycY=;
 b=g5FSxZ3y+fN0vq/813Mphi3tpHLluaBXOuGu6aZNAqnh0sVhw2qGeRspSQGjlsDxywM6MxZ23or9RGIX5QjnKn316LJznt/qHK+zTjK4YKb/zPBlF+K2uOs8jvfZSAn+qTPJheuVlY5vCJeQx5DvxeVvn9piE7/zek6NjcmCe4A=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA1PR10MB5842.namprd10.prod.outlook.com (2603:10b6:806:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Fri, 16 Jun
 2023 18:28:19 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 18:28:19 +0000
Date:   Fri, 16 Jun 2023 11:28:15 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     akpm@linux-foundation.org, muchun.song@linux.dev,
        pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org,
        willy@infradead.org, brauner@kernel.org,
        chao.p.peng@linux.intel.com, coltonlewis@google.com,
        david@redhat.com, dhildenb@redhat.com, dmatlack@google.com,
        erdemaktas@google.com, hughd@google.com, isaku.yamahata@gmail.com,
        jarkko@kernel.org, jmattson@google.com, joro@8bytes.org,
        jthoughton@google.com, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, liam.merwick@oracle.com,
        mail@maciej.szmigiero.name, mhocko@suse.com, michael.roth@amd.com,
        qperret@google.com, rientjes@google.com, rppt@kernel.org,
        steven.price@arm.com, tabba@google.com, vannapurve@google.com,
        vbabka@suse.cz, vipinsh@google.com, vkuznets@redhat.com,
        wei.w.wang@intel.com, yu.c.zhang@linux.intel.com,
        kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        qemu-devel@nongnu.org, x86@kernel.org
Subject: Re: [RFC PATCH 00/19] hugetlb support for KVM guest_mem
Message-ID: <20230616182815.GA7371@monkey>
References: <cover.1686077275.git.ackerleytng@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
X-ClientProxiedBy: MW4PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:303:b6::8) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA1PR10MB5842:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dec2167-d31e-4446-371d-08db6e97754c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2g7/j11H55ERvHxEkecLvFE/ibaKNgMg6YnDLWynbYNx93xOMQW/zCQczDfMd4crKYxsqi7I+xxahBsurATtqdESJDWWfsI5vPbRMr1VlDzqVYPLV8PO6q0Ur0YgKJNS1XyxRl9583rKhGsd9NxF37SO0wiLxTvQbbbLB+CE6GHiwanjljmjG9OErmuHv4ksGgDkE8ZUApS05SZ9pdjdikFUC4dpjsjSTBozhnGoBz5ssVhjhQdVxQh3rCIFMJtTUiqC0zMRNLO2DFB3r50mhvx/XqX5z9VP0RylNdzxDGbFy/uCWGNi6487zMXB6vVgw+v9ZIrDCsaitHk4uYRce/1QVCO8/zG9b3bH0MqGdJ5Ruc4zQ7WunFcKqKKk6k3ObSwH34wnABkVSKePEfOOl4eqOMFIfn4VdIT66cjDPirQOhArQhJxN+nSSZMlF386GEkI/E2Ou3+W4rpju04QbDRAp4ZV5hh+GAnwkL4M6mT9d31KG4qokOrxGbYtNa3M6rNfZvyAvuG0Q+XDOHRWhWSMGLahT2bOBxUQZsClMet/AEWfgGJgc9iVNTm58HAUJJ6oTlID8uDYMovpMh2lzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199021)(86362001)(478600001)(33656002)(186003)(83380400001)(6512007)(26005)(1076003)(9686003)(53546011)(6486002)(6666004)(6506007)(966005)(8676002)(38100700002)(66946007)(66556008)(33716001)(66476007)(8936002)(5660300002)(4326008)(6916009)(41300700001)(44832011)(7406005)(316002)(7416002)(66899021)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yIZLomR3yi5pQDZhx4A3ZkOt6zZb99JzbzjPcFt//+RfIslNoRv2RUhmy+C1?=
 =?us-ascii?Q?2pWMmqYVSstkD5EzbY4W9TnLbb/1If4+DBWV1UHOfXHkiKSuu+XcUZEJaV/h?=
 =?us-ascii?Q?trKgz3jw141qpMK9npzaHdm6CLpfymzYFWaesRGONNjyhViBSEqV3Q9YzZTU?=
 =?us-ascii?Q?EMEfjVI6LgDYDYYaMy3QvIFgfaoMvrH7KERAauwrKyBX4rvYobmSaJbPuo2i?=
 =?us-ascii?Q?dpQDRZQDwWWPEXi7JXT0Z1JKMITfkoulTcPAmaNXe2guPvKH2MdEua+UDCMR?=
 =?us-ascii?Q?C9DL7XFzWBTv1XzgzeY9meZTdS18qmj8MmU+jIz2EDpW8b+qtd9oX6baVoMK?=
 =?us-ascii?Q?hzg8eQip76a6P39c7SvZceIoD8apWp9CyCKn4mF8wP8Tp8WToN0qdRim835F?=
 =?us-ascii?Q?oCxdI2YXpXM5Qse22qMaL4EO4gyXLzgdf21cjvIlovp34DfnEYdFdeP6mabR?=
 =?us-ascii?Q?3S6TlmHs3xNhjLrBljJ5wbCxzUEQ9j6MdrmUyIHux5H88SI4T2tYCosvK/IV?=
 =?us-ascii?Q?scMs02WbLa0VJnHpYtOmVXHvzGcil/pjbZ0E81e4RcVhhTQdvwVOQC1Wt+9E?=
 =?us-ascii?Q?Y+EBzH+sNI3Od9vQVDUv+Tbs86g+uARpc5zU2qv6tgexVEj/hkzpWYfwOnZ1?=
 =?us-ascii?Q?fEwZ1GaDM4+GCVQJ/fsBMp5yxYjXseJx3xEEEl/g84l6VUbMJyr/nF03/hyh?=
 =?us-ascii?Q?VMia93xfz7Bm/qln+q6q4lbHauGT9+ky8foRxatfHuD1pufjRldVRD1w7gcA?=
 =?us-ascii?Q?k1h1Iu5cwhJUb4ZqB6eIiM2n429F2XTon7TiaDu2f+2eV2Esf21GuFU0wNjm?=
 =?us-ascii?Q?0EW/I1qYKwVUiDHV5xYeqBcp0L6XihvyygYeChQwPbWQktXmd0vFdtTkUy0p?=
 =?us-ascii?Q?azrgZh+bksj1ZM3siExap3caHdzBlsx7F/3kFPHDihHf0UhJ1BLsZOw9tMma?=
 =?us-ascii?Q?+kRZYZnNw/X1JwxwwXLzrLITzxSn87AH1EkhTZWWSu9tEtAwkNdhMCY+EdTw?=
 =?us-ascii?Q?QM54sQFu0C8xJCI4ix4KEnua/wIvyUBRABFLK4yh+eZMDJYTvxprLNcQJdi7?=
 =?us-ascii?Q?lBa08ddWZPsmd6wmvzRADE+A9BJoBpxStaXkdJwF5/agdIzZFMYAXDk0Bl7G?=
 =?us-ascii?Q?5XrFF1kgm5tKP3+M4Z8LY9+nOIoivhaWRtrYg7dXMM99Hxl1E7HSTTCu2AWi?=
 =?us-ascii?Q?D+bxgeSQbNk9vtDa1mPf35lkhg7//sEv7xH84S+b2YEVMMsbp70tTQfbaXKN?=
 =?us-ascii?Q?MIyYWA1M+Bsb5HwBYdk2oH/Za/QsN/NE7Y8FkM/sN1KZnxWLf2cM12eLz+XS?=
 =?us-ascii?Q?LUephNKo4zjX7YL1SijmLI7U1YmlZgzivE1E2TLYZFwPY8C8QxJoCeftDiY4?=
 =?us-ascii?Q?4srKOv71CiuPAdq8TDMcgJViUdzHp1av3A5ZgHxAlLCNzx3A2K/BtCi98wvH?=
 =?us-ascii?Q?uFP6g3isvvjBhOs/DO9qYYbD8MKbHmOvf+qpRzgIWIsbOkaG8NMKokmJLo3I?=
 =?us-ascii?Q?pMTHGqoawEkyJEsGcr18mixbz/VgN8xMWs4xVHyLdTi4qx7/JxunYGxLp/97?=
 =?us-ascii?Q?UROOUPG64HJ1uImPb77Hp6AlFhDBLkmDf98DiHqe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?AGpT/WhP8enun9xkQzIpXGmj+zLGjEW7kMonfy24cqYeHT8/1b12M/TbOxbL?=
 =?us-ascii?Q?oL/sn8CE68fVQ52+CgyIivqYtvdExqCkVS5Wre+x6BjFPHtTCFQei6DF4uPd?=
 =?us-ascii?Q?9D6BSZvHXr8omNApPAWQyV+UaO7ydWFXD/WmzHwrW+Q8PfI6ZVPaK1wI7okQ?=
 =?us-ascii?Q?7X6Gj3KspmzOKoIx+/ttuzhcSy5cV3Y1/QsefNjFwR8a3iO3R7NLPpFBikCk?=
 =?us-ascii?Q?qcHFtF9JzMP1ll+2rmBcqDlAm2PskZlHK9QA3jPEnpkWGLf1qyTBm20188sR?=
 =?us-ascii?Q?dGsAUlc2HXws9bw7VLdZOY4YoIcRt4YZfoQvNGrYQ0cr5oIo+o9+oep+S4Xt?=
 =?us-ascii?Q?GQ2SPBL8sgx+70ht2dI8Rb+r5dYJcBcPsTdqC3nQTCQ9dVoQNaJSjDfmZOd5?=
 =?us-ascii?Q?QJwST6GJCGc55YqMzr4eFSnh7EdVLefe+7aRDt0Pjug46aDu7Yt145e7AzP2?=
 =?us-ascii?Q?7fdRTLPhVLQchP4U0hVQS/IkRP+Zn5k1vEufH7PYpVGFeGJGKJpe+H7+aPMd?=
 =?us-ascii?Q?g5buS1Z03zc4MLJbHWcCgLeYHS9+wHrKcKh51PIlXTQKatXaorCnG922PgSi?=
 =?us-ascii?Q?zPHqBLyszVzH4hSLuqEDjEDPoL4CXh8/v+GlMGVsSJhm6uyD7cwqBAJUpiLu?=
 =?us-ascii?Q?QRfFnMADnEXOk+mrkVOTJigML4k686DFNgWuCEmNrMT10FrBQmxbgsut7Kkd?=
 =?us-ascii?Q?gx2acxYBHYLjh2Oe1/Kgypm6uQOsetlXeDEHxWvT4qE8T4Kg4YrdcNce1xsI?=
 =?us-ascii?Q?NhT7u3HCCQgJ3NEVTZ39lXaHnZh8ctms6Tny4qiiYyTLCTzAVve5Mwcqk3H6?=
 =?us-ascii?Q?XMoOn+ivHp9FQFCn0z5Eu1wV7SneSGiEUYOgcp9kPOOfnoqb2Swx5Ome7r7a?=
 =?us-ascii?Q?NsuTVFnOC3TkOsTJEaimYTAWJaIs4deQoYk9Y/XwTmLV8xphN5VupVFf56Fc?=
 =?us-ascii?Q?X88Ss9ZMYUxzZUJiUOL02KJRz6033c0D4QSC8+92FHFzzdS36S+DFRZeMrel?=
 =?us-ascii?Q?D+4rp7wPerhZnMTWkOHAmmiG7bvJYee2mfld58+fCP8rU+MHEccG+lzwtGo5?=
 =?us-ascii?Q?XknaitvtCdf/zw+/+QmZ0NwUeGnm3b4b8cnM2k6vP56p2oIyhWmnjti7GJEE?=
 =?us-ascii?Q?6x1mnCu/GYEgly5fJgNBEl3XSbAB+47D4+7cJkP5ViNydj58IhG1M1Pyj+wT?=
 =?us-ascii?Q?DZeqTwM4SLGHGSTppUY7li4B+cimerLIjfIHEuDyf4zj9vbiUnXZ/ABypdGJ?=
 =?us-ascii?Q?hsVkpbfn9BForcn8l3JhNI/BwwQZOcewPhtcnaZH8GbP4soT5qF/JOLJl0xI?=
 =?us-ascii?Q?xpc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dec2167-d31e-4446-371d-08db6e97754c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 18:28:19.6239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMs/5hyMGJCVB0yl1QshAsQRdJT8nGrDEkw6zbkPE0jvn09xItCSOdO1EThI6MmwTDnuJnqm8oyWY/TZ80I2BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5842
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_12,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160167
X-Proofpoint-ORIG-GUID: 4cAgM6VFL7skdtzzGFmEb1Tq0FarhN1Q
X-Proofpoint-GUID: 4cAgM6VFL7skdtzzGFmEb1Tq0FarhN1Q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/06/23 19:03, Ackerley Tng wrote:
> Hello,
> 
> This patchset builds upon a soon-to-be-published WIP patchset that Sean
> published at https://github.com/sean-jc/linux/tree/x86/kvm_gmem_solo, mentioned
> at [1].
> 
> The tree can be found at:
> https://github.com/googleprodkernel/linux-cc/tree/gmem-hugetlb-rfc-v1
> 
> In this patchset, hugetlb support for KVM's guest_mem (aka gmem) is introduced,
> allowing VM private memory (for confidential computing) to be backed by hugetlb
> pages.
> 
> guest_mem provides userspace with a handle, with which userspace can allocate
> and deallocate memory for confidential VMs without mapping the memory into
> userspace.

Hello Ackerley,

I am not sure if you are aware or, have been following the hugetlb HGM
discussion in this thread:
https://lore.kernel.org/linux-mm/20230306191944.GA15773@monkey/

There we are trying to decide if HGM should be added to hugetlb, or if
perhaps a new filesystem/driver/allocator should be created.  The concern
is added complexity to hugetlb as well as core mm special casing.  Note
that HGM is addressing issues faced by existing hugetlb users.

Your proposal here suggests modifying hugetlb so that it can be used in
a new way (use case) by KVM's guest_mem.  As such it really seems like
something that should be done in a separate filesystem/driver/allocator.
You will likely not get much support for modifying hugetlb.

-- 
Mike Kravetz

> Why use hugetlb instead of introducing a new allocator, like gmem does for 4K
> and transparent hugepages?
> 
> + hugetlb provides the following useful functionality, which would otherwise
>   have to be reimplemented:
>     + Allocation of hugetlb pages at boot time, including
>         + Parsing of kernel boot parameters to configure hugetlb
>         + Tracking of usage in hstate
>         + gmem will share the same system-wide pool of hugetlb pages, so users
>           don't have to have separate pools for hugetlb and gmem
>     + Page accounting with subpools
>         + hugetlb pages are tracked in subpools, which gmem uses to reserve
>           pages from the global hstate
>     + Memory charging
>         + hugetlb provides code that charges memory to cgroups
>     + Reporting: hugetlb usage and availability are available at /proc/meminfo,
>       etc
> 
> The first 11 patches in this patchset is a series of refactoring to decouple
> hugetlb and hugetlbfs.
> 
> The central thread binding the refactoring is that some functions (like
> inode_resv_map(), inode_subpool(), inode_hstate(), etc) rely on a hugetlbfs
> concept, that the resv_map, subpool, hstate, are in a specific field in a
> hugetlb inode.
> 
> Refactoring to parametrize functions by hstate, subpool, resv_map will allow
> hugetlb to be used by gmem and in other places where these data structures
> aren't necessarily stored in the same positions in the inode.
> 
> The refactoring proposed here is just the minimum required to get a
> proof-of-concept working with gmem. I would like to get opinions on this
> approach before doing further refactoring. (See TODOs)
> 
> TODOs:
> 
> + hugetlb/hugetlbfs refactoring
>     + remove_inode_hugepages() no longer needs to be exposed, it is hugetlbfs
>       specific and used only in inode.c
>     + remove_mapping_hugepages(), remove_inode_single_folio(),
>       hugetlb_unreserve_pages() shouldn't need to take inode as a parameter
>         + Updating inode->i_blocks can be refactored to a separate function and
>           called from hugetlbfs and gmem
>     + alloc_hugetlb_folio_from_subpool() shouldn't need to be parametrized by
>       vma
>     + hugetlb_reserve_pages() should be refactored to be symmetric with
>       hugetlb_unreserve_pages()
>         + It should be parametrized by resv_map
>         + alloc_hugetlb_folio_from_subpool() could perhaps use
>           hugetlb_reserve_pages()?
> + gmem
>     + Figure out if resv_map should be used by gmem at all
>         + Probably needs more refactoring to decouple resv_map from hugetlb
>           functions
> 
> Questions for the community:
> 
> 1. In this patchset, every gmem file backed with hugetlb is given a new
>    subpool. Is that desirable?
>     + In hugetlbfs, a subpool always belongs to a mount, and hugetlbfs has one
>       mount per hugetlb size (2M, 1G, etc)
>     + memfd_create(MFD_HUGETLB) effectively returns a full hugetlbfs file, so it
>       (rightfully) uses the hugetlbfs kernel mounts and their subpools
>     + I gave each file a subpool mostly to speed up implementation and still be
>       able to reserve hugetlb pages from the global hstate based on the gmem
>       file size.
>     + gmem, unlike hugetlbfs, isn't meant to be a full filesystem, so
>         + Should there be multiple mounts, one for each hugetlb size?
>         + Will the mounts be initialized on boot or on first gmem file creation?
>         + Or is one subpool per gmem file fine?
> 2. Should resv_map be used for gmem at all, since gmem doesn't allow userspace
>    reservations?
> 
> [1] https://lore.kernel.org/lkml/ZEM5Zq8oo+xnApW9@google.com/
> 
> ---
> 
> Ackerley Tng (19):
>   mm: hugetlb: Expose get_hstate_idx()
>   mm: hugetlb: Move and expose hugetlbfs_zero_partial_page
>   mm: hugetlb: Expose remove_inode_hugepages
>   mm: hugetlb: Decouple hstate, subpool from inode
>   mm: hugetlb: Allow alloc_hugetlb_folio() to be parametrized by subpool
>     and hstate
>   mm: hugetlb: Provide hugetlb_filemap_add_folio()
>   mm: hugetlb: Refactor vma_*_reservation functions
>   mm: hugetlb: Refactor restore_reserve_on_error
>   mm: hugetlb: Use restore_reserve_on_error directly in filesystems
>   mm: hugetlb: Parametrize alloc_hugetlb_folio_from_subpool() by
>     resv_map
>   mm: hugetlb: Parametrize hugetlb functions by resv_map
>   mm: truncate: Expose preparation steps for truncate_inode_pages_final
>   KVM: guest_mem: Refactor kvm_gmem fd creation to be in layers
>   KVM: guest_mem: Refactor cleanup to separate inode and file cleanup
>   KVM: guest_mem: hugetlb: initialization and cleanup
>   KVM: guest_mem: hugetlb: allocate and truncate from hugetlb
>   KVM: selftests: Add basic selftests for hugetlbfs-backed guest_mem
>   KVM: selftests: Support various types of backing sources for private
>     memory
>   KVM: selftests: Update test for various private memory backing source
>     types
> 
>  fs/hugetlbfs/inode.c                          | 102 ++--
>  include/linux/hugetlb.h                       |  86 ++-
>  include/linux/mm.h                            |   1 +
>  include/uapi/linux/kvm.h                      |  25 +
>  mm/hugetlb.c                                  | 324 +++++++-----
>  mm/truncate.c                                 |  24 +-
>  .../testing/selftests/kvm/guest_memfd_test.c  |  33 +-
>  .../testing/selftests/kvm/include/test_util.h |  14 +
>  tools/testing/selftests/kvm/lib/test_util.c   |  74 +++
>  .../kvm/x86_64/private_mem_conversions_test.c |  38 +-
>  virt/kvm/guest_mem.c                          | 488 ++++++++++++++----
>  11 files changed, 882 insertions(+), 327 deletions(-)
> 
> --
> 2.41.0.rc0.172.g3f132b7071-goog
