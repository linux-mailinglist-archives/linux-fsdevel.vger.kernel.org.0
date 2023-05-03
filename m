Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7BE6F5E23
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 20:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjECSkc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 14:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjECSkR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 14:40:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412417687;
        Wed,  3 May 2023 11:40:12 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343HowRA000715;
        Wed, 3 May 2023 18:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=s6U4SHv03DQbibGnwYMMTvVbf59+f2S7TduJtgmTuyY=;
 b=gQKbVFMRu1AZ9Pe+pMxETxT3Rk9/0aCNVSAsElrs4QGEVmSIIJQFCCFkHXWxezcgZIUB
 goGqFT6mUtGeNng8hs/mCeWjmgp1NExzXkw+gUgkYLm9ZGl3mzJSQv+D65w5Jw+X1M0a
 4reYeYS7tOaaXZ65lHSL7mCVxCWM6c20FUYPzNWzmaAJQNRHn/AGzVafvCXNE+Csplxc
 nJzeDQMGsSJ4PAkyIxXCtSh6rDaaT8xnLIeeZIxQpHF72Af7TkvuC1/jWqfrNNr1+a6r
 +aPcLLDloZ7Yu28TNwXVpuxVyOvxr/qtFerx40suHs8iAAVCj7g359p4GegEPTjUFKc6 cA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8usv0180-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:39:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343Hsbt7020802;
        Wed, 3 May 2023 18:39:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp7g9r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:39:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Az7d/87b6B2taDNLZOM90GTQTjR1xLlMLg4rnopRC+Z1tYPAQGpdNN4ytCi7sVOxYVSDLxpIPkVWPxdDM4W4m/5YWoAZjBOOVTlve1KygqX0mU3p4EIDrvC5AXFShvOKdUjEU3rE7qfJNntg6khSCQrTdur78h/kneD2FayFd0K/s6X9Bzui4dn8P7sO71SO6CrsNjH1IbnjTKWFiCLtJDImaJo+Uur3JNnVEvviUwmhVan0XRk45LrIK52czGzb6rpEfkPu4h4Z5V/03MWu8oA2B8nZjm75voe8jw6rV3uL/eC8F1O0c72Yt/A6KnQCVaY5umcmVKzE91Wyt1vLTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6U4SHv03DQbibGnwYMMTvVbf59+f2S7TduJtgmTuyY=;
 b=AgYDlc8im8Msb+qKOpoeaqO32vfDutsBgNi1lPnMRxn0AJKX3H5E3CEbkB+SbhCUrukK7OvRR7FfApYvn+c4xVpe8luyFV16avNvDFiy71+mjJ5AkMJI04uQDZayxqGDokv2xwgoe/JNROxH2P9T8UYXD1KMoNhEtDwV+gLebw/nv9LUT2XiN2NshOxT/KHcAU/N7XEagvMK+l154r5qz56TCa/IkvB9uZbItkzinkDBiekWXJUQ0k1O6Nlp8+jiiiPLWKYu+fBXBIDCe+c18A068EpykdzdqIQeqijzeWY2cluW+MCPC2BeyzHkhnBVZIDBJNM2H7Z61DCzRdl8Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6U4SHv03DQbibGnwYMMTvVbf59+f2S7TduJtgmTuyY=;
 b=Cflh1UoFefnWiXme7EMLAtKg5+Q6qCrwTdv1FTv0CXcmolAogUBgUKuwQxZcfautv3Qw8YIWXtHN3F0qlHawT8vPvecjAtsjFAmZEmhEOqShMcvlM/AWrcOvHarie3+dxSmAD+KUw/wXQjShWW/TTVnkQuwtzL8v+0hMnypKbA8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6171.namprd10.prod.outlook.com (2603:10b6:208:3a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 18:39:36 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 18:39:36 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jejb@linux.ibm.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 06/16] block: Limit atomic writes according to bio and queue limits
Date:   Wed,  3 May 2023 18:38:11 +0000
Message-Id: <20230503183821.1473305-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503183821.1473305-1-john.g.garry@oracle.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:5:333::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c698cc-1647-4b87-82a9-08db4c05bed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mzccw/Hf4KsaJ7Ln7emlcioAs0UNCUms3UyMJkg+aSxBWpzWd5WmatkRkaDk+UHxdTQWaxF9fPc3ycuZlHZTUlyB/pRbub1iuupazAAFF9r6ByfP228v5wJHE3BNs9fPi6tCRfwZQD615pXi0Rlu/CebVYgQGruYjqkUcQYtZK8yAnGd5evbrBstW0XS3c59ruYxjgkd4DD4tWadWB5QfSE3e7Et3QiOLcHeCtxuHt+GDKMi1P1Rd9ihhddSULFr04KtJ7QKu45KjcbMwovFYvf8fEs6aSrRTt+12UAwlpyUallzaFOyBUP+EADuEAgIsUCW1yI0Yvh9iER4R7F/8j9xdlpQMImvYHcbgzYUBvm2aMEkp4xFdaqYur7O72OfZ1ZrsxRb8evi+daQRboQ8mveDP0VmJm+cEQvNs+JoO/WKZagshWw0AUDbCJYyzmqBYKp28wjWVU4BA5UWuqqM+pQcRzR5QiBz86yzz/uRuG83rNye9ovrnDQ5b7Ny3ugmKYMgP8RCe0Dxo56ZqR2TtvTBIAq8nY/Cb8a6AORNapYP4Vm3L4IUtqB/1yadbz42sKARGnDCYB3XfQGQSc8zl/2niaYw/XIaFte0U8/0AU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199021)(2616005)(186003)(4326008)(103116003)(921005)(36756003)(38100700002)(83380400001)(66556008)(7416002)(66476007)(86362001)(41300700001)(8676002)(2906002)(107886003)(5660300002)(6666004)(478600001)(8936002)(6486002)(6506007)(316002)(26005)(6512007)(1076003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JBJm/hXM6t61z+qlOEvAwkt1lNIK1s5F8MNEhR5YSt8nGyXQMmhbF9Hbmryr?=
 =?us-ascii?Q?cOAZJnqRvfqAnuuyQW1qdMQcNj1gol9fhiJpk+SYcoBY58h+oNg3o2S7HqT+?=
 =?us-ascii?Q?1t2/ajmPR8mKWp8ui2erIZF1duhji3g+RfF2N9Xz3uagEtS4MXYE/4+wYNVU?=
 =?us-ascii?Q?pS5l0aQ5ZL833CM8hKFA/KJP0MFfhaG8QyGKNLpFfNGNjDJitEMvg9e7PZfA?=
 =?us-ascii?Q?TBbbddtpJyXInpGkW3o3ARzscPUvq5S+DtVbtRDzGGgPdrVft5+06yMJIjRP?=
 =?us-ascii?Q?WE7Wteqx9DpVLRGLTs2MwsMMDXialtKk4qQTIRsTgBLWzf7dacCdhc7qyJUD?=
 =?us-ascii?Q?mJSjj4QNKALCCa0txfLaNFpFjsUiDuptgB/Hgmb5m8othVbAT9S8dzpoLRub?=
 =?us-ascii?Q?xJRyU+vSGDPpE7jntwypVMugKcCm747RVU0ro5pnAWozL/nFM+pFnJgdKTCY?=
 =?us-ascii?Q?3Tua7iNc9F8Nv83qHsfNMywwEqnkmT7G5NzZ8UlVRf0D/+7dy1DUvQTFRDI+?=
 =?us-ascii?Q?Jz0dUuWk/qlIEJqCZS5k6v0uYlrvt89wP2tZV/K7MoOc1UnOaETu1dhr5Cj5?=
 =?us-ascii?Q?8UZSmGQb7BBykIxSaPV8qd52mqQg6tiDyly+JWCfWAycuDDBciW+b6ScsoCN?=
 =?us-ascii?Q?M9/rhJ8M8vlwBiK/BwfHGXVupaPeRmm2Wj6Oif2vkzLycyiFfSLBTrFRFqtm?=
 =?us-ascii?Q?0AqpvA7xv+N680CYnkU+LbvxryRWZ9N+o1gP3RF45pzrB1kVLVfefztMmGB1?=
 =?us-ascii?Q?jGAgbMeFW0bMFeSVZg/XP2BhQatXc2o3GzaYdu39TAgIvB6MmWKH5brR17OK?=
 =?us-ascii?Q?KjQdcbGEWkdfgRvaILMoWVFl4wuaiDVoU57dP57CTQvtraLPd89DoingjEzq?=
 =?us-ascii?Q?/07KBj5qTFKPWNtZpglnJtwfq4AOJlQ0nfCsgSRpWNo0yeO85ynuwRdxvD5N?=
 =?us-ascii?Q?WcLESsKMkxJpHGytAULwkFzZRriROT/SM5e1JpjRtdtmFjKMOlG5LVLohr/z?=
 =?us-ascii?Q?MsgtvXZd3xj7zanR7YA/lOf6qdxQGCWF6615VR9uH0S9d00a9SDR7Ht84KIA?=
 =?us-ascii?Q?c0SP0LRHANcog7L8ztPATBYKA5nFuN1IdzS+bGNU1fpvraN7vaDX3LtoPWcJ?=
 =?us-ascii?Q?SLTa2krSePXaL93NUuy7PRYKsug6Pf620KVjoJeRJBgwXxRsBeKXVgCxrphC?=
 =?us-ascii?Q?Uc1DEYWvAVCm+bc51HKhztIOSiQ33qGInH2WSoetHcYKrJ4Jo8KmH+fNq9yI?=
 =?us-ascii?Q?VYkEElB1gqOT1IODELRmC+sn7RTVNr44o7ZcHlkHY/0o9syOBgwC+ocSkZW9?=
 =?us-ascii?Q?j2dYRjE7SjoH5mxkggyiV1ee+dlOJ/GBmnhmbPHK/LKANul1SJOR9E+rkOiY?=
 =?us-ascii?Q?Js23Rd5U1CbFDhKxB9h1gFSeamGIGsJxlYM+wuesGFuW2ju+1sOfkIKRl4HU?=
 =?us-ascii?Q?belQEB9ay2zipj2b/Oizd1uItmiQxaCtW8yu3o6RXY238MdVqhxCJ7H79haC?=
 =?us-ascii?Q?xi0Q65QHBnjumtndNMZvkgJnECuwpE9hqk3QcbyU8p1+inTkI0FBrPFW9LuV?=
 =?us-ascii?Q?DUwHs/gUMZeC1atwsZCLfFes5xLC/WhFVdjKiAzkPHWBJIHAEEvq0ZOT/Kuk?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?cYcXWVdXfCZ8eEMYdrWGHTSmZF20E01NWk7bG0boNpzo5vpi+MOAzBYzCkVX?=
 =?us-ascii?Q?3k28kX8sKggNVynOPSI9PvW0yh6ErNK90eNs39/6zJkwkt7gcbqswE8HLqHG?=
 =?us-ascii?Q?Nn5X9xN9JteXxSw2JY2WCzBLD6HnOyKv9NkOL+6C2HDSM7RHC3cbDzczAdFA?=
 =?us-ascii?Q?QqAs9VxsQzSJwt6CeyNYOohpoXuWh65D/sIGKRhAzPD0J1rpwILQDgpWqVE+?=
 =?us-ascii?Q?5phC8ergzkjD/A8EDLHouo/j+xmGWHGNSJQH8wVzKIBXRZmf4KqojUTcla1j?=
 =?us-ascii?Q?aX89jeGsxJNl6TG2Kj01k/U6SwcQCQDjMEC1MHJf0Okt6oqSWWEuXQbmaP8o?=
 =?us-ascii?Q?ulyvtWQpmXo8fyYz6EqyKjGPTetjfgzCvgpYpSIvcVKVmxjvHZooalaxDp0s?=
 =?us-ascii?Q?BIpCrRILk9FmhljYQO2umqqetBE9Q1dW/WDvO+/WMl4iV+CS4JQ5TpxW/PsP?=
 =?us-ascii?Q?AM+GT6jQIZV9OY00zNKHiWryMSjxpg7xmHGL62YokpAd/DR7EYjbDVdIkhxZ?=
 =?us-ascii?Q?GCO7SscpaORv0XAlVcv3rErg1qS7a0evRKEAOSXskKsxlRTvJm+ymBiQF3Ef?=
 =?us-ascii?Q?m89BHKwT24f45U0SEjSYgZgleAuVvzlJSOjLbCjdkbFkdX0biKAh50MGxQ0L?=
 =?us-ascii?Q?kTFeRZEu6CF5i8uBT8mz+mSMAOTl2IWW86dvHEcPA+L7eCaJKsm/vSYOoevq?=
 =?us-ascii?Q?/tWNajpLz20EBdP8VRXASe9POU7fBXWRmZQWycXzM8DbdzeSMiIYjxn9uXX1?=
 =?us-ascii?Q?EK3v7hIH5YRYYIi/B+UOCKhDzs6MBUA85fPPrZe+DhVqJTykN4K0J4QTOcjY?=
 =?us-ascii?Q?VlK/5D5itcGA2VKHnPd22vw82grE/GRm+nHkCKaX/LxnlatVP8VJQu6PJxzq?=
 =?us-ascii?Q?ryO2tFfhiTD81d1GTaocDElOtRcL+oKqh2zy9wbEd7qwLWNGIB8BtGPMr3WC?=
 =?us-ascii?Q?XF+q2M64oDkGRJ0WwWmvREiSPFWXAVBhqI6KTlKk2GzJi3dueoJePLDkPxyS?=
 =?us-ascii?Q?ApL/ePNJ7um7Ax0Dc+uW5/npdrbCWOXCiP7M3Mi5haPBpJN4mcrEqhhgajA7?=
 =?us-ascii?Q?p2ctFcZKUfkfDigZ2ftVeRjQuWFv1a6B6BpPs75J9PFM3z4CusHIFl3SmNBW?=
 =?us-ascii?Q?LHrAeOWcWYXb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c698cc-1647-4b87-82a9-08db4c05bed0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 18:39:36.4561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +S1mi8fcufsc/9TyEn/8RrmSrD1LDoSvKA09spg3OnpBxDUIA6Nz0D36TYZaGOIx47O6PZslPRPgA3/UpJZGfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_13,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030160
X-Proofpoint-ORIG-GUID: aFpDXZhtBuvKp7b7t86_EsgeTppz6-yG
X-Proofpoint-GUID: aFpDXZhtBuvKp7b7t86_EsgeTppz6-yG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We rely the block layer always being able to send a bio of size
atomic_write_unit_max without being required to split it due to request
queue or other bio limits. We already know at any bio should have an
alignment of atomic_write_unit_max or lower.

A bio may contain min(BIO_MAX_VECS, limits->max_segments) vectors,
and each vector of at least PAGE_SIZE, except for if start address may
not be PAGE aligned; for this case, subtract 1 to give the max guaranteed
count of pages which we may store in a bio, and limit both
atomic_write_unit_min and atomic_write_unit_max to this value.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-settings.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index e21731715a12..f64a2f736cb8 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -212,6 +212,18 @@ void blk_queue_atomic_write_boundary(struct request_queue *q,
 }
 EXPORT_SYMBOL(blk_queue_atomic_write_boundary);
 
+static unsigned int blk_queue_max_guaranteed_bio_size(struct queue_limits *limits)
+{
+	unsigned int max_segments = limits->max_segments;
+	unsigned int atomic_write_max_segments =
+				min(BIO_MAX_VECS, max_segments);
+	/* subtract 1 to assume PAGE-misaligned IOV start address */
+	unsigned int size = (atomic_write_max_segments - 1) *
+				(PAGE_SIZE / SECTOR_SIZE);
+
+	return rounddown_pow_of_two(size);
+}
+
 /**
  * blk_queue_atomic_write_unit_min - smallest unit that can be written
  *				     atomically to the device.
@@ -221,7 +233,10 @@ EXPORT_SYMBOL(blk_queue_atomic_write_boundary);
 void blk_queue_atomic_write_unit_min(struct request_queue *q,
 				     unsigned int sectors)
 {
-	q->limits.atomic_write_unit_min = sectors;
+	struct queue_limits *limits= &q->limits;
+	unsigned int guaranteed = blk_queue_max_guaranteed_bio_size(limits);
+
+	limits->atomic_write_unit_min = min(guaranteed, sectors);
 }
 EXPORT_SYMBOL(blk_queue_atomic_write_unit_min);
 
@@ -234,8 +249,10 @@ EXPORT_SYMBOL(blk_queue_atomic_write_unit_min);
 void blk_queue_atomic_write_unit_max(struct request_queue *q,
 				     unsigned int sectors)
 {
-	struct queue_limits *limits = &q->limits;
-	limits->atomic_write_unit_max = sectors;
+	struct queue_limits *limits= &q->limits;
+	unsigned int guaranteed = blk_queue_max_guaranteed_bio_size(limits);
+
+	limits->atomic_write_unit_max = min(guaranteed, sectors);
 }
 EXPORT_SYMBOL(blk_queue_atomic_write_unit_max);
 
-- 
2.31.1

