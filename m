Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768FF7B3099
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 12:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjI2KeL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 06:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjI2KdF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:33:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7507D1BE4;
        Fri, 29 Sep 2023 03:31:33 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK9Svu022434;
        Fri, 29 Sep 2023 10:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=IChuwCRUEGZ7NxnHVQn/DGIM6u18zam8FJHYg6Kwv5g=;
 b=SJojU5gKyD31RdK80WaIE60oSZdRqUbgyWmTp0X6TyVzXGIiMXcL8NKaJxJZM9oA9g1l
 SWMX3lDLa+pgW+MHWwlG5XZinpLoEeAF4OMwGY0nVNGb7RX2af8LACDWcdNlbGZuzDrp
 liNC+CDxnDakSZkLtfbw7hpngcJ0ENoyrda4HJExa9GX4MHsX6H/jh1oB15ofBC1m2du
 cyMqtmo7wpWiqNsoLKBAj1fjIvNuTSEHO8OqeqMcDakuRSLE+HPYLmRBtExSt3AE497p
 ULBO9lQEWR6Bhc6jPvo70pw8G0LKCBh29b4FL0Gi8NSVJ3N5Qb+Zc8lW8CJn6umfuSl3 4Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwbpbr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38T9iSOG015821;
        Fri, 29 Sep 2023 10:28:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfh4vtc-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdiQAZkvtGJM6R0wZs5410GGenDxbpHfKCJj6Wz4cSRfWGYZCSao9Nsu4a5LkhVJnwt6zarD5XQ8tAr04A2Km/p8knlbprfSvXunlrb6Hcx/Hdru4jm0nyqiaYGhjbEEhsDqiVbYCORskuMUlOfsK0W4TFT48+IfR51oMkpvdyP4ksrwTRz+/GtPc1ZOBpebU/xs9Thqz1NO/JCK7c1r8Tf2nXK6X85laiaRtgQyiX8pk7zklKwHIoDqXx6c96YPTVrI/0df/yVj4o3EQgtkm8yBmOZkD0yTu9CBNKFzsWFla581xytRv482DccJe6DZHj7ZUzqY6AZW1cQ91HQzzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IChuwCRUEGZ7NxnHVQn/DGIM6u18zam8FJHYg6Kwv5g=;
 b=dTLRA4wdyf+kxlUdWfGYz99fLngiBCO9hMvtoGqr/XKJVZUQsU9xHhJ333aV4CM6tCK7oeouqkq2rUud70n9N5kyPc7cm2fcMQ2Lo2k5JOFFY9bYstATeW4+448X/kV1qpWSJaiqNKqs3+VWXl5rrUEUAIwQ6U2IL0FaiDY270DSSIF15IZuKL/mTnPZV2Jxf7EEZVgoJhJ67bG5fVxZachlqyRq+YMjUY5RVe/ooRU0g3bHzj6NihBSr6W5oCXkYFuhAETzw6M2uZvSznzJQheGyeTRTU8kgNF6A0VDcxrOl4RmIlpybYUkDpSL/5JbcpFn8RhH9nbj4XXOISftvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IChuwCRUEGZ7NxnHVQn/DGIM6u18zam8FJHYg6Kwv5g=;
 b=bZ99X9DVr8BQ1Sbvt8qdpVcq4lWrVlM5xMZavi5s6taTSnw2MrUSTWf1QV7Xj6+c49IXp9uUu0ep09FqF3qTqs1mZHusv7BWB7Uyx0w8sNc1uShfgNl9xN6E18LhTP0hed5WEPqIrZsSg0ZmH3IU3x4D2pN8hivtE2inKBTv1jw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6153.namprd10.prod.outlook.com (2603:10b6:510:1f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 10:28:24 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 10:28:24 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 12/21] fs: xfs: Introduce FORCEALIGN inode flag
Date:   Fri, 29 Sep 2023 10:27:17 +0000
Message-Id: <20230929102726.2985188-13-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230929102726.2985188-1-john.g.garry@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0030.namprd17.prod.outlook.com
 (2603:10b6:510:323::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be5e996-8e62-4cb7-23b9-08dbc0d6cf68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O4kcYWpO25E4KHvWrLMvENEyKnYGuLXynOGDYkt3IfZj238QbDRjRhp6l5i+E/j0W0cUr51UoNqC43wzmOqUVI/N+SEJco0dd7zTqHxCo2IfQahG2up4cmTrFoqO6xManrFFikCekFLR/lOYT2VrJGHTCLW9r+2WoRpFCx8JoMLTpjWwpRFe/yew34560H4Ig9oTTfXdN2mM5fnHjxj9h52Y1AyV8CBa25a0Hkg+6MZ0JUiP3rdPOplMuSa993uIuhNIhggYc+NYofgpAw93s+3qboVCO7gTdKFWkAiV7DMJ7wVzXjZNBWhnXqtey9R7bKVV5uCd2CYgsRlMp46P8A9d0u3KjzaHQealFChg3T+jS+AVhOm/JpmI8VdDV4ZUsqXAn4/ngKgCh2OCYhcWCdZDE/1FAzfi71v2Gocx+ZOKAaXhKg0nU2ZhfJuOlJabLAji/c7f3kXpdfWxgzIFLcs3nzIRg+orHNUc5hfWtGJ1+6d+Hdaxn4oaialfj02BCcq/BtJHpr9uG3im2AK3wOryDgSdjAouly11hvkG8SEdA7kLFhwHmjR544n+kl3gx8Nwphu45OUS9l5w5fdLRfJk5k1kwRoVjblcBxB3huw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6506007)(6512007)(921005)(107886003)(1076003)(26005)(2616005)(8936002)(4326008)(36756003)(103116003)(66556008)(7416002)(2906002)(5660300002)(41300700001)(66946007)(86362001)(316002)(8676002)(66476007)(6666004)(478600001)(38100700002)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pkGe8WFMuGQvPuo+HQa9a646rF92ub8cKoqdgdiK7rGzjIrm+d2FIcUJuOyq?=
 =?us-ascii?Q?DXCoJf2mmUTlZr2tIZdYtBO0i6ZQE/xnCipE+FN+hkGBvmKY02kUhM+NWfrV?=
 =?us-ascii?Q?b5+ciqgCvaQdjCeoVV5QiXIRhPqWrqhmsv96TwwmIaZ+nres3LBTznSncwdV?=
 =?us-ascii?Q?1gFHftOqkQIzwzoRhOEfEntGDDuiQR82L1NCsAJ9G4wecQtPYsHZSn4MZz7F?=
 =?us-ascii?Q?KG7ckMO3m707Kw84s2GHHcRou4NTzh3HMb/VuCt55qAMrUMT30bv+hvRRgq3?=
 =?us-ascii?Q?MlCtPUxPBr4aN1BvMSTmvsi/HshGnUDsOChQlBvHVzfeKnDk24HLaZuTPuIa?=
 =?us-ascii?Q?+gtZEFREvMYF9WDpNKCet5sY45dfqKoeAkurS4bzOh2NGCi0VcLfGH150u5G?=
 =?us-ascii?Q?q6CxsG/QyIHoc6R0h2/M13lFWoPtkIaCYfHWQjeuJCjhNOjO1z0AngTcyNPc?=
 =?us-ascii?Q?UpGwlEBzs+96LV79j1hQsTXLTFwSN6v5AtcKfNEeXamXmTmHpIAYPD093Gfs?=
 =?us-ascii?Q?aCq36AsnaBhSpakEFYTvwXju+/WSzjbW+3lJDvQ8ORbmgrAJBiPkQxTuCrzM?=
 =?us-ascii?Q?VzFBHsSKKkwULNtVYWUmvk2Roe4W7sc6wqYiqO26y5S8ynLpzCRrKWOpW4TG?=
 =?us-ascii?Q?n22GNCV2UU/oP8ccV23WRVONUqHLJ1fFvuKzZFii4LPt7fQS8gbycPCZIJ2h?=
 =?us-ascii?Q?emGAFvKUJU2mvvL3rAoW42H/XuCp4YJqoWMv1+caFH81JjPqmqpGQA3jJaTe?=
 =?us-ascii?Q?odJb11tn5lgnHEK4rap0WFbwXq9pXYTXEeIWAqPs2sJgbWA8f7NkxdXVxtMf?=
 =?us-ascii?Q?ikeEmIohtXJ/YtTNjK8TfOzmgeFRJ2/tNG9demb9DVJCu8DNehIKIqsPn06x?=
 =?us-ascii?Q?5u98MW1eNve9H9+X8rGuzcCoXhlIWXO4td2vG/nLbro7hqjorHGTZeGfYjc6?=
 =?us-ascii?Q?as0O+oYNAz/KPvFflZ5+DksXD7naGv4eEMjNt/9tT+5bm0zaDY1IZaXnrzy/?=
 =?us-ascii?Q?y9V/++NsNr/tfz0dpMA9S7lOz7ye3gJTkaQnfNcUSe7OAh+UtHbix9xB0eV2?=
 =?us-ascii?Q?mjw8bRk76ucI/05A8B+w4HcvULjADf2MKM3GvkArLWpxUpWRk18i45NwoyL0?=
 =?us-ascii?Q?Q4gkpSR63kEYloFlbcJIgZ82sgXo5H/HdA7XjT50LFJ3CAOTl5zZ2wNQwbOs?=
 =?us-ascii?Q?mnSeR5X1PRAFydpMenijUzefs1Xk837bD8ul/VxzfULYMoUJ9+2JDABFGuqL?=
 =?us-ascii?Q?XCpShg6l1BiocxbuucB0dGM5mfkM6cp9Wa60EaO3pMupIslTDtUHzJbEQvKM?=
 =?us-ascii?Q?XY9aMydsqhSZQGHKTzM7AdvbK75aXdAmStTzoWRh5YHO/JMl9NWsMcIySUoR?=
 =?us-ascii?Q?d/7IuC0rrpvME8FAdvuYxUrIDMJir2gwzCO/+EbR2I8RfO5N/nRZ2sYa46Io?=
 =?us-ascii?Q?86MBeb9I/5wZRM50xrZN8A4nwxLtVqYbbdDyJJTzULFVIuLj49Ly4d9Gv3e2?=
 =?us-ascii?Q?AWlae3d+98gumRuri3hTkA+phSDOSq/t/EZHrppnAjWOCnVMkfxo0uwAf85z?=
 =?us-ascii?Q?9xgxCMkx5DIVQYYDWeymlNZ5VQ24iEHU04SdDf44cJbxXJTiN21BeHGzWhll?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?EOXeCFCgTdkIEIi+9c+L/u5jfq7YRMCo0RZfkSb8qZOefNd6drE5g1rrGGBm?=
 =?us-ascii?Q?0fcgsB32jcKrrGqsgUgn93ybC9SWvkCrEdObSM+yq8mRAnfMg2MAvnaYmAjL?=
 =?us-ascii?Q?Yfj16Fx06yW10pzlcmcNC0cRtoEr/j+1nsTeNHAeHvBW1nO5HnHDZNseGAB8?=
 =?us-ascii?Q?dnXOMG9Bx3M8elsmry4nE6c2e4g7BMmomBtoz+uuzTDoku2k7Sq+iXRf3zhU?=
 =?us-ascii?Q?dIgUB3Xzimx0AXxxG2bOPTK2PY9iFiuB2pzhhw4VUDi5p9AvBpQA0RazAGup?=
 =?us-ascii?Q?wXPfsW3ULWrJU/lP25gW0Ru3WQyTFUfx1R6VpomPcAMeFQcTdmDzQqkS/5kM?=
 =?us-ascii?Q?o/EUGILpVGqop/+ybc9/W64sk5i/qcgv2b8cxoKtSSPmlg+bcOdVgzH1BQwS?=
 =?us-ascii?Q?PhmrWQ7H9iHcCR06Sd2HhdVVbo9uwpKuo5vIm5J+3fexWHribtXVf1BHbZd5?=
 =?us-ascii?Q?Tt1FKPfMNF8x/h6ZYS0PTvg1fE/9DrGCoHdEk2QB10d6NeJxDNzi3zs3gz+y?=
 =?us-ascii?Q?LxV9ef4g25ckM+bdVfHL3z+9CgRby3ecgdwaiwXo5lK08zpG08HwW21c55QX?=
 =?us-ascii?Q?5PtVmz9mouDuDrQ1RVArgUtq46b+5GDoqAiarYl2wWOtH0Zsttjy9yK2YRD8?=
 =?us-ascii?Q?DOJxWuOWKLK+F3JZ2AWRt3RqSKTDGBKpiYkqJe9gAoLz7yaTVuAF/WcF7ifz?=
 =?us-ascii?Q?pDJhoC16nqF6BiW6pExfdlYlDLTmgYxxAQqVMLs0BenecD3YOOy1oQ0ED2sO?=
 =?us-ascii?Q?qJ1ECSI5iik6Fk5jHrBL24YwvqBZVRlbdoik3MEpEFY8Bcvt5nPpTiS/zctQ?=
 =?us-ascii?Q?UCXS9acvvHMNdsenTQeoA/n0rXIP0L1kAlh0wZM2YWM3LYaboSEtABGU0EVx?=
 =?us-ascii?Q?4TaIG3BRWEIUo7Jj2zp2UmzcafWr6EjGmroJl2DtL/pwumpkWIvFc8aB6cfD?=
 =?us-ascii?Q?CkoF3jPvPDpJOKwz2p/1XKwRjMKijalP1mZxcf2T43Mqx173kNJnKjri7tUJ?=
 =?us-ascii?Q?rAbwSKtFjiG0lHu5/vV8H5477ZlViNEdrC7vP5Ehd3jrVUbHT60U2AkSu9xs?=
 =?us-ascii?Q?ENYrXLBlCdz77lWiQKa8QGUbFSWAkw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be5e996-8e62-4cb7-23b9-08dbc0d6cf68
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:28:23.9898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFdHSlENopjRq3mAVPEcgGnFKqf1yOryfzvaOS951gTTF/UR/jXK7LoFWg2DdxgB6Yc727I3BL7oqoivWAheOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_08,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290090
X-Proofpoint-GUID: RsHLEOH534gGQbF3HPf4Bo4toqwQidha
X-Proofpoint-ORIG-GUID: RsHLEOH534gGQbF3HPf4Bo4toqwQidha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Darrick J. Wong" <djwong@kernel.org>

Add a new inode flag to require that all file data extent mappings must
be aligned (both the file offset range and the allocated space itself)
to the extent size hint.  Having a separate COW extent size hint is no
longer allowed.

The goal here is to enable sysadmins and users to mandate that all space
mappings in a file must have a startoff/blockcount that are aligned to
(say) a 2MB alignment and that the startblock/blockcount will follow the
same alignment.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Co-developed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_format.h    |  6 +++++-
 fs/xfs/libxfs/xfs_inode_buf.c | 40 +++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_inode_buf.h |  3 +++
 fs/xfs/libxfs/xfs_sb.c        |  3 +++
 fs/xfs/xfs_inode.c            | 12 +++++++++++
 fs/xfs/xfs_inode.h            |  5 +++++
 fs/xfs/xfs_ioctl.c            | 18 ++++++++++++++++
 fs/xfs/xfs_mount.h            |  2 ++
 fs/xfs/xfs_super.c            |  4 ++++
 include/uapi/linux/fs.h       |  2 ++
 10 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 371dc07233e0..d718b73f48ca 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -353,6 +353,7 @@ xfs_sb_has_compat_feature(
 #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
 #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
 #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
+#define XFS_SB_FEAT_RO_COMPAT_FORCEALIGN (1 << 30)	/* aligned file data extents */
 #define XFS_SB_FEAT_RO_COMPAT_ALL \
 		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
 		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
@@ -1069,16 +1070,19 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
 #define XFS_DIFLAG2_COWEXTSIZE_BIT   2  /* copy on write extent size hint */
 #define XFS_DIFLAG2_BIGTIME_BIT	3	/* big timestamps */
 #define XFS_DIFLAG2_NREXT64_BIT 4	/* large extent counters */
+/* data extent mappings for regular files must be aligned to extent size hint */
+#define XFS_DIFLAG2_FORCEALIGN_BIT 5
 
 #define XFS_DIFLAG2_DAX		(1 << XFS_DIFLAG2_DAX_BIT)
 #define XFS_DIFLAG2_REFLINK     (1 << XFS_DIFLAG2_REFLINK_BIT)
 #define XFS_DIFLAG2_COWEXTSIZE  (1 << XFS_DIFLAG2_COWEXTSIZE_BIT)
 #define XFS_DIFLAG2_BIGTIME	(1 << XFS_DIFLAG2_BIGTIME_BIT)
 #define XFS_DIFLAG2_NREXT64	(1 << XFS_DIFLAG2_NREXT64_BIT)
+#define XFS_DIFLAG2_FORCEALIGN	(1 << XFS_DIFLAG2_FORCEALIGN_BIT)
 
 #define XFS_DIFLAG2_ANY \
 	(XFS_DIFLAG2_DAX | XFS_DIFLAG2_REFLINK | XFS_DIFLAG2_COWEXTSIZE | \
-	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64)
+	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_FORCEALIGN)
 
 static inline bool xfs_dinode_has_bigtime(const struct xfs_dinode *dip)
 {
diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
index a35781577cad..0c4d492c9363 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.c
+++ b/fs/xfs/libxfs/xfs_inode_buf.c
@@ -605,6 +605,14 @@ xfs_dinode_verify(
 	    !xfs_has_bigtime(mp))
 		return __this_address;
 
+	if (flags2 & XFS_DIFLAG2_FORCEALIGN) {
+		fa = xfs_inode_validate_forcealign(mp, mode, flags,
+				be32_to_cpu(dip->di_extsize),
+				be32_to_cpu(dip->di_cowextsize));
+		if (fa)
+			return fa;
+	}
+
 	return NULL;
 }
 
@@ -772,3 +780,35 @@ xfs_inode_validate_cowextsize(
 
 	return NULL;
 }
+
+/* Validate the forcealign inode flag */
+xfs_failaddr_t
+xfs_inode_validate_forcealign(
+	struct xfs_mount	*mp,
+	uint16_t		mode,
+	uint16_t		flags,
+	uint32_t		extsize,
+	uint32_t		cowextsize)
+{
+	/* superblock rocompat feature flag */
+	if (!xfs_has_forcealign(mp))
+		return __this_address;
+
+	/* Only regular files and directories */
+	if (!S_ISDIR(mode) && !S_ISREG(mode))
+		return __this_address;
+
+	/* Doesn't apply to realtime files */
+	if (flags & XFS_DIFLAG_REALTIME)
+		return __this_address;
+
+	/* Requires a nonzero extent size hint */
+	if (extsize == 0)
+		return __this_address;
+
+	/* Requires no cow extent size hint */
+	if (cowextsize != 0)
+		return __this_address;
+
+	return NULL;
+}
diff --git a/fs/xfs/libxfs/xfs_inode_buf.h b/fs/xfs/libxfs/xfs_inode_buf.h
index 585ed5a110af..50db17d22b68 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.h
+++ b/fs/xfs/libxfs/xfs_inode_buf.h
@@ -33,6 +33,9 @@ xfs_failaddr_t xfs_inode_validate_extsize(struct xfs_mount *mp,
 xfs_failaddr_t xfs_inode_validate_cowextsize(struct xfs_mount *mp,
 		uint32_t cowextsize, uint16_t mode, uint16_t flags,
 		uint64_t flags2);
+xfs_failaddr_t xfs_inode_validate_forcealign(struct xfs_mount *mp,
+		uint16_t mode, uint16_t flags, uint32_t extsize,
+		uint32_t cowextsize);
 
 static inline uint64_t xfs_inode_encode_bigtime(struct timespec64 tv)
 {
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index 6264daaab37b..c1be74222c70 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -162,6 +162,9 @@ xfs_sb_version_to_features(
 		features |= XFS_FEAT_REFLINK;
 	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
 		features |= XFS_FEAT_INOBTCNT;
+	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_FORCEALIGN)
+		features |= XFS_FEAT_FORCEALIGN;
+
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
 		features |= XFS_FEAT_FTYPE;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index f94f7b374041..3fbfb052c778 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -634,6 +634,8 @@ xfs_ip2xflags(
 			flags |= FS_XFLAG_DAX;
 		if (ip->i_diflags2 & XFS_DIFLAG2_COWEXTSIZE)
 			flags |= FS_XFLAG_COWEXTSIZE;
+		if (ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN)
+			flags |= FS_XFLAG_FORCEALIGN;
 	}
 
 	if (xfs_inode_has_attr_fork(ip))
@@ -761,6 +763,8 @@ xfs_inode_inherit_flags2(
 	}
 	if (pip->i_diflags2 & XFS_DIFLAG2_DAX)
 		ip->i_diflags2 |= XFS_DIFLAG2_DAX;
+	if (pip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN)
+		ip->i_diflags2 |= XFS_DIFLAG2_FORCEALIGN;
 
 	/* Don't let invalid cowextsize hints propagate. */
 	failaddr = xfs_inode_validate_cowextsize(ip->i_mount, ip->i_cowextsize,
@@ -769,6 +773,14 @@ xfs_inode_inherit_flags2(
 		ip->i_diflags2 &= ~XFS_DIFLAG2_COWEXTSIZE;
 		ip->i_cowextsize = 0;
 	}
+
+	if (ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN) {
+		failaddr = xfs_inode_validate_forcealign(ip->i_mount,
+				VFS_I(ip)->i_mode, ip->i_diflags, ip->i_extsize,
+				ip->i_cowextsize);
+		if (failaddr)
+			ip->i_diflags2 &= ~XFS_DIFLAG2_FORCEALIGN;
+	}
 }
 
 /*
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 0c5bdb91152e..f66a57085908 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -305,6 +305,11 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
 	return ip->i_diflags2 & XFS_DIFLAG2_NREXT64;
 }
 
+static inline bool xfs_inode_forcealign(struct xfs_inode *ip)
+{
+	return ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN;
+}
+
 /*
  * Return the buftarg used for data allocations on a given inode.
  */
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 55bb01173cde..4c147def835f 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1109,6 +1109,8 @@ xfs_flags2diflags2(
 		di_flags2 |= XFS_DIFLAG2_DAX;
 	if (xflags & FS_XFLAG_COWEXTSIZE)
 		di_flags2 |= XFS_DIFLAG2_COWEXTSIZE;
+	if (xflags & FS_XFLAG_FORCEALIGN)
+		di_flags2 |= XFS_DIFLAG2_FORCEALIGN;
 
 	return di_flags2;
 }
@@ -1143,6 +1145,22 @@ xfs_ioctl_setattr_xflags(
 	if (i_flags2 && !xfs_has_v3inodes(mp))
 		return -EINVAL;
 
+	/*
+	 * Force-align requires a nonzero extent size hint and a zero cow
+	 * extent size hint.  It doesn't apply to realtime files.
+	 */
+	if (fa->fsx_xflags & FS_XFLAG_FORCEALIGN) {
+		if (!xfs_has_forcealign(mp))
+			return -EINVAL;
+		if (fa->fsx_xflags & FS_XFLAG_COWEXTSIZE)
+			return -EINVAL;
+		if (!(fa->fsx_xflags & (FS_XFLAG_EXTSIZE |
+					FS_XFLAG_EXTSZINHERIT)))
+			return -EINVAL;
+		if (fa->fsx_xflags & FS_XFLAG_REALTIME)
+			return -EINVAL;
+	}
+
 	ip->i_diflags = xfs_flags2diflags(ip, fa->fsx_xflags);
 	ip->i_diflags2 = i_flags2;
 
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index d19cca099bc3..a7553b8bcc64 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -287,6 +287,7 @@ typedef struct xfs_mount {
 #define XFS_FEAT_BIGTIME	(1ULL << 24)	/* large timestamps */
 #define XFS_FEAT_NEEDSREPAIR	(1ULL << 25)	/* needs xfs_repair */
 #define XFS_FEAT_NREXT64	(1ULL << 26)	/* large extent counters */
+#define XFS_FEAT_FORCEALIGN	(1ULL << 27)	/* aligned file data extents */
 
 /* Mount features */
 #define XFS_FEAT_NOATTR2	(1ULL << 48)	/* disable attr2 creation */
@@ -350,6 +351,7 @@ __XFS_HAS_FEAT(inobtcounts, INOBTCNT)
 __XFS_HAS_FEAT(bigtime, BIGTIME)
 __XFS_HAS_FEAT(needsrepair, NEEDSREPAIR)
 __XFS_HAS_FEAT(large_extent_counts, NREXT64)
+__XFS_HAS_FEAT(forcealign, FORCEALIGN)
 
 /*
  * Mount features
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 819a3568b28f..1bbb25df23a7 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1703,6 +1703,10 @@ xfs_fs_fill_super(
 		mp->m_features &= ~XFS_FEAT_DISCARD;
 	}
 
+	if (xfs_has_forcealign(mp))
+		xfs_warn(mp,
+"EXPERIMENTAL forced data extent alignment feature in use. Use at your own risk!");
+
 	if (xfs_has_reflink(mp)) {
 		if (mp->m_sb.sb_rblocks) {
 			xfs_alert(mp,
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index e3b4f5bc6860..cbfb09bc1717 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -140,6 +140,8 @@ struct fsxattr {
 #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
 #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
 #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
+/* data extent mappings for regular files must be aligned to extent size hint */
+#define FS_XFLAG_FORCEALIGN	0x00020000
 #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
 
 /* the read-only stuff doesn't really belong here, but any other place is
-- 
2.31.1

