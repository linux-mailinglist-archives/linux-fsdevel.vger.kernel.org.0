Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0D8727463
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 03:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjFHBhV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 21:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFHBhT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:37:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C149E62;
        Wed,  7 Jun 2023 18:37:19 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357Mv4uw026210;
        Thu, 8 Jun 2023 01:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=dQVwgbF8bB00GkPDKrLXWaACB9TF0XFDsHVeekDTz5Q=;
 b=TRbfGqn/WWGxT5F1ptqZupW1n+xMdHavIp5oQQa260HhfcpyfY/5cSlJE37Z7Be+dCci
 1He/feurOvCEbuz/6w56luPQv4wZ2sDnVd8Zg+H5seUMHlwBh6BJwLOuGM61it9pK2Fz
 vB57vtSA7+AGD2UwzbKF9uwWum5sblaSvg+yQhgdKOYqX9sFtuq2Fc/mwCI1A31vVYxB
 YRoI2OWtGdjQ8Vh0vW942Mlcbw2emley09pjBlKBvKU+I8j64W7PjNrmYCqWlb8dC9ul
 s6JmgQYOAVHsGKat+S/sU50NTTyfjcg83IfFrPryCw6w1rDAXzm5WrESTt4ba+sDCIJk 9A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6rb4nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 01:36:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 357NhJKd010489;
        Thu, 8 Jun 2023 01:36:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6r8s61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 01:36:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nU1IwM5yWjOdsLmoGwkX41C9h6KFo0E9aCFjBTu2pmVuqfDleSwTs7Q9zkt2I0jvg6ssLZ0khoCFybsHceGa/pSjxBc2CTjEIDFn8CKjY7Cxvbd4sPNwi+/zqvhhF7HqCoVIVvoUhykgCP5CQggo1Z9WvMCHHduFjuHqObCSl3KI8glkAnGHI97qkcxs7YzfNDj6yZOrMD7wZcYpTFmNvkholx4uirs/SpyIsQbGsju8zYcHvbgbiZ9/Nj1iCSsJ5Gc7Pt3JZ9iacPpupZHEnnbgRMYAjtgepS/vaAScf8nJpVpvESeEZP1zJ8dFXyUDWys7vu3Iesj5038c0nyaow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQVwgbF8bB00GkPDKrLXWaACB9TF0XFDsHVeekDTz5Q=;
 b=T8Jh/g6XBEJkABAZSkKZDTYD4sbqylhGnlQeHrL/aaPl1Kwced8jBpQsKroNZ5AFsQgsuPZI8iDHyEvOMp+l73uQdDkgySQlH0BhgL7QCIvWwdcNICgE3wtZbX06QxY7bbnneEEVQHW911ereOZhCitU1g+lhy7ZwXiVFDS7QQy/4mf+74u/HmF76QDUhIpFsziEC1xDwWQMr70q5xAgg24CIkfgeCHcr+0FMf70HJ0w3Dlk7FXRaiZ2ZAIT9/cQXi1KP5HUoQRKLGc4fkf29+L6ie54TUJGKh6z6mRF4KABRB80UV5Pws1a6jXiRZESYCmEHK7vpInR9lYzmJZlvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQVwgbF8bB00GkPDKrLXWaACB9TF0XFDsHVeekDTz5Q=;
 b=Qvrckz128cSgv7S+TzkAXeq/85B+hsuepipwDXv7qx6soYwaw8nFLmBWM9Uodx/O0/PZyTzgEkzSRyrS8qcc0M/9C2e+vt70RCSUdfe8jn1JaVKG5K+cHlkCaioRhPOU7snfg18XfrWm7Jc2YdUv4WpCggyDhA9kuLebUG+xG8g=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SN7PR10MB6364.namprd10.prod.outlook.com (2603:10b6:806:26c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 01:36:40 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 01:36:40 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Nitesh Shetty <nj.shetty@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        willy@infradead.org, hare@suse.de, djwong@kernel.org,
        bvanassche@acm.org, ming.lei@redhat.com, dlemoal@kernel.org,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Kanchan Joshi <joshi.k@samsung.com>,
        Javier =?utf-8?Q?Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v12 5/9] nvme: add copy offload support
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1edmm3fk2.fsf@ca-mkp.ca.oracle.com>
References: <20230605121732.28468-1-nj.shetty@samsung.com>
        <CGME20230605122310epcas5p4aaebfc26fe5377613a36fe50423cf494@epcas5p4.samsung.com>
        <20230605121732.28468-6-nj.shetty@samsung.com>
        <ZH3mjUb+yqI11XD8@infradead.org>
Date:   Wed, 07 Jun 2023 21:36:36 -0400
In-Reply-To: <ZH3mjUb+yqI11XD8@infradead.org> (Christoph Hellwig's message of
        "Mon, 5 Jun 2023 06:43:41 -0700")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::10) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SN7PR10MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: b1fbe8f3-2b86-4629-01c2-08db67c0ce8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fw4R/fofLt2Ga76P7yEQn7A2aHlbzx11522LP2yNXtMGr7aRUUgZNEc+b1okUfZ1iyGY8erdq5H/uGpscXl1mLxy8ecQPkaxKTvsokHWCgn4IiWociqpfu376Z7BQkokZgJmfZ5wlIMsKDQgCZGGMDYZGbm+Wkfu/SIZjMLeMUGa6wJBz5kL3TsOrUIV2dBqZlZQ7vyB8Hr1alg4sII+ViWi98Sa/JOjolJA1RyEWhsWsIIquh6BAzlCnXoXjsHOYnnKabb4tW2RRu/Ljv1IEfn4nK2CbGaBKxkGmJWeADah1FUDyaOoa3fLmYjkD67uqQOsHlK38SeeLK4KMpiYhEKBAO7uZ9FgSVJVcOvxL1rXkVkb8QxfDVbjGqw5r1nHKRuyyVG342mQv1591rOB0bZovj7BcZBpMPtYhFrIc0D88fwekQnXKQIW/rq5r5PVSlyOwZQXrSOajjqz8Mgbr8HU4IB+keSZlQqM3wdQAyT9RhYC4OIhTe92kHiZ3zG+ArgJg3HwhMJ68oBdWha933Dx0JyF2/2ukPzKvgYJxb66NiJjJU4yXRJMQcovbw6G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(8676002)(8936002)(54906003)(478600001)(41300700001)(5660300002)(316002)(6666004)(6486002)(36916002)(7406005)(26005)(6916009)(186003)(7416002)(4326008)(66476007)(66556008)(66946007)(6512007)(6506007)(83380400001)(2906002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a1P30SACxL2zB9cEUSwKqvrt4DNTcnMxxkraZ+tPJ58rabQAmvUwkt2ghQsc?=
 =?us-ascii?Q?j7pmo6gmR0QS5E84Xyt/XeS1HWHDKArWqiG2PCsRrXplgZhq3l+Drc9+nOoj?=
 =?us-ascii?Q?yomHvHKscTkYLRHgICpDyPVeptEb65lD2WSmxYf/oDWQUV3tJckwQoMIt/0V?=
 =?us-ascii?Q?kYPtF+1UBUJ6LVkVbB8nOunXfOXBE9D/BSVV53NemTCypKDXi8vNJgFBVzBa?=
 =?us-ascii?Q?A6spB0+gtaAk6vPrtyMqHYhGaDwJScePLY6T7L6UAp0W0wfYlERninTChEzi?=
 =?us-ascii?Q?KaVP03kav6TQQA46GBMqRtdm93cJvZrUFpWK0mc/MIcEuPHfLqVZBnbzMkxS?=
 =?us-ascii?Q?XlI+Wpc3lM488axD/nGCDZ/9mDpDyXDrZFUmQGx4oDoOmzwJAQkxv3tI+4Zl?=
 =?us-ascii?Q?r3+lMC2D67Jc6ap8XDMYp8X0hvac+FVaKuXsi0Da+StUszpUxxQ1MpX6Ajl8?=
 =?us-ascii?Q?/PmJCU2/5oVYtFuj8Cr8pmnAKmrXkk21/Ke81zVUy1Y+drC8RcRnmV+E83dA?=
 =?us-ascii?Q?Ct/B4MAilblBNWCMhxaVZ8sK+HK9YG1CU9fkGPDu49ZaxFlg8L4iGCi/z5/v?=
 =?us-ascii?Q?lmB/16lcD+Sitd5QkGWX8lbvLvxrXfOeTjfS882E57Z0MD63bnb8/QvcCgOZ?=
 =?us-ascii?Q?CSGENimaMvnxDuvqyACizqHFPOGrLwzJVCqf44eKcXMgoEsMZkuOPgeaVcXc?=
 =?us-ascii?Q?F0DcMEzy8BTrq76ebdybexaJ5aTf4OxpBclU9xmKsyiddXDbH0oMcG7/2IH8?=
 =?us-ascii?Q?a2nckjoHKy9CScVr8bHI7GFOb5gBKB16DqsMvj6e96ubWUPaCL6z8zSV+wrs?=
 =?us-ascii?Q?QX0RVofl7iE9/ZOd/Y7GyJVq2gu+cTWsbT54H6Ian1eUcOOyBEqBXMqGJ5z3?=
 =?us-ascii?Q?5U7cGTQvmIKTOTA23BlvdcP/CF18tSWI+TMalDyV9559q8P7U/Ldp4fRz7an?=
 =?us-ascii?Q?GdpAcxyClpLt/APOpRm5OFVQhCanY+MYVZJdLXu1/9/Lnt1vhEi1dgOA7+iC?=
 =?us-ascii?Q?JZBt7p2Sey2MLPMinA9f49X1ZIsxQAtqdGJ828quJ+WRrWNYNVFRU+f3SN6M?=
 =?us-ascii?Q?jUphMfF5+jFR0rcBUDXN0FYYRvKW8fwEaw2Vl0x5oiOcKYZrttPovaHNod3X?=
 =?us-ascii?Q?2j3jRCunGYZOdm0GCD/r+tPpfuQvp9yR6xS0BX4cu4P7+a6lzVn1tMrks2Vw?=
 =?us-ascii?Q?xlLY9jBjkVxDn+AAd25n6FX0+8mezYlCvl//iAe17lLW+dd95VNAzNTIaHC9?=
 =?us-ascii?Q?TD/LJpo+NXKy6IXenXg0OUtRtaupuXlXmv/K3tXNJBxnlnj+zhQzYZ7NmHck?=
 =?us-ascii?Q?VCPFwG+SCAddCk7lNFkEUdk2iOD8xlz+oJUvaremmfy9lhNb1811fvdsdqQ6?=
 =?us-ascii?Q?ctDTXJSFMS1nvZEKNxcOkdI3XJoTRU1/c2c62mqe/Hv0jdw2QxryZIHb1Iz7?=
 =?us-ascii?Q?dYKlu8S8XWe97vsDBwSnipl2KyZ+FS7LJ8zkveVocsvJMrO6lFKjrEX19eCx?=
 =?us-ascii?Q?Ywb3KRmbBnyUuP67fYDlLup4/gMXBwS4PobcPCXzMyJMneLvt49Q284gIc/g?=
 =?us-ascii?Q?9tchJRNarYsBWCxa7iFUEiEphM6OUB2IX97uKlZPYu/mNAINCTdHh+zfc3IS?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Xt9DQvkA1mvtjCLOc0cRJokqeG8lbBKG/xwoEnFiy+Q8MS/4SDnSyVcHXrFn?=
 =?us-ascii?Q?pvITJRRR56+wy8RTcpjuXQJhw8UtNPtZaIi93cyTbrWLwV1xZ1WXb21K9qkZ?=
 =?us-ascii?Q?79hGaRE/jHfy0gwvBVcRntVHf3yNBe3j1dZX8LVHrDOb6jE/vdjgr97J7Qpi?=
 =?us-ascii?Q?9l1dEIGM5cF+xBtngwxOFphVAeqMso9SMm1nxF6hISN4tGoggsug2u7TyBJK?=
 =?us-ascii?Q?4awaCxXnbUNBCpDD9TT3iAhgWQ3pPLLgy6kv6dwYr1GbdpeleWN6T4+xZnVy?=
 =?us-ascii?Q?90iSUi6rtZp+dAgcY9wmYKF4g4hbgNFD3NKU9Dz4/fF1a9weZokpppG+6YfX?=
 =?us-ascii?Q?blx2NT4tyh10fTy7GdNGDV7mWfUETKL9UdaGDdfxeyFPfZ4y6V+jaO3SfjTt?=
 =?us-ascii?Q?mVrM/MLYaauaEDbQHAbVyy/DC7b7TCrmXb+5yafJJEoFS2mpiAyMo83hkgtX?=
 =?us-ascii?Q?5fW7IBH4Z+oP1BvV3OOz7ktjxfDloM2PPdOCU+KjQVkwTaCETugrb15NYIUl?=
 =?us-ascii?Q?D0CLcjL6fjqsPVMjZ/i4ieulKy5kEAYfPB0HDKJKMDQzTC5mdDxktWQuuC7x?=
 =?us-ascii?Q?q1Qv1FJ9DuMeKvozEkqPsFBgHK/ImBwRqAHh9mkB/daa2WKiCqZhdIFaz9qy?=
 =?us-ascii?Q?Bj3XdzfDwrfiHWXhT99rLCp0ls8iTEsttwXQK5FE5TohJPojzpp9nK6xbBn/?=
 =?us-ascii?Q?6bg8SAUn9ggd1mnqg+MfOjRb14DvgNoX1DVbl8/aAUj3CHgVL+IpPgmxsyQF?=
 =?us-ascii?Q?YMHColCn2zveO9TFxz/oNECJmvUINGAW9EsM+vAuKZ+vOKtvcUVvGniRSaPq?=
 =?us-ascii?Q?XwYyUwnvQOTjqSOU+UIvefRBNESkGKgaHWZrkLN1wiXPTgEac29chZ6hyw+6?=
 =?us-ascii?Q?5fRaCx8PVCPDpDebvofpxazWQSpo3JSiNjvTLqZ10XOXbStpV1My+ENkfLcK?=
 =?us-ascii?Q?uFxgGPL3AflcotLven2pMJR1TL9S89kEwj2mFyFhg/ID+CiGT+BPW7Rk+Z58?=
 =?us-ascii?Q?/KgSIgUPXZAU3DeGkTxlMFaTJhTlr29YiV3dq8Quy+i51Jr+va8VajvNTIPd?=
 =?us-ascii?Q?LEFNV1jysTFi6eUOjle1zpQZ7ezE0EZ+S6Med8r2y7jsir2ahqroSPTYTsdQ?=
 =?us-ascii?Q?/VkD+LwupCETeujNIEpmiyNguKb9k4YpE2bRVSQE9pFsS5IKc674QXdbE1ns?=
 =?us-ascii?Q?fn5+7LmNz21+8VUwV7NXmkCwymvVVUvRGTIEyQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1fbe8f3-2b86-4629-01c2-08db67c0ce8a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 01:36:40.0608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +419qSlleiNiqe/B5t6fYDUzVlI0Z1U219oVRdcsPohno8I59t3Ba6Nl6quG1aTrNeXL4yWliinDJpiXqThvpxWSTbiLOskx+bCEV15n48s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6364
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080010
X-Proofpoint-ORIG-GUID: EYrQPd42Zc4BAuABhshJ0UL6k7pfBsyr
X-Proofpoint-GUID: EYrQPd42Zc4BAuABhshJ0UL6k7pfBsyr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Christoph,

> Yikes. Overloading REQ_OP_READ and REQ_OP_WRITE with something
> entirely different brings us back the horrors of the block layer 15
> years ago. Don't do that. Please add separate REQ_COPY_IN/OUT (or
> maybe SEND/RECEIVE or whatever) methods.

I agree, I used REQ_COPY_IN and REQ_COPY_OUT in my original series.

>> +	/* setting copy limits */
>> +	if (blk_queue_flag_test_and_set(QUEUE_FLAG_COPY, q))
>
> I don't understand this comment.
>
>> +struct nvme_copy_token {
>> +	char *subsys;
>> +	struct nvme_ns *ns;
>> +	sector_t src_sector;
>> +	sector_t sectors;
>> +};
>
> Why do we need a subsys token? Inter-namespace copy is pretty crazy,
> and not really anything we should aim for. But this whole token design
> is pretty odd anyway. The only thing we'd need is a sequence number /
> idr / etc to find an input and output side match up, as long as we
> stick to the proper namespace scope.

Yeah, I don't think we need to carry this in a token. Doing the sanity
check up front in blkdev_copy_offload() should be fine. For NVMe it's
not currently possible to copy across and for SCSI we'd just make sure
the copy scope is the same for the two block devices before we even
issue the operations.

-- 
Martin K. Petersen	Oracle Linux Engineering
