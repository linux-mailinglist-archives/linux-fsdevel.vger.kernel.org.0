Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AB07B3013
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 12:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjI2K22 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 06:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbjI2K20 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:28:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8DE1A8;
        Fri, 29 Sep 2023 03:28:24 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK94P2018441;
        Fri, 29 Sep 2023 10:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=31jc2+OVZmwNZGcdfaPyUtUaj9QVTZmwNDv1+AWRPKM=;
 b=Jxup28a9iuN3naNKs5NGxS6AVWOPoOLtueYEjtRmqGOh2kqMyhBaOGPv/MlmrxFS1OHv
 vTA9oVBQNAkCwhwuiaNuJ46kNHoQm58awmrr4D1+pdZ/C294+3HOW7gFlOnnzyWmQfIc
 R8AO9x2g+0BkCVL5MS6ppNmEFqTyskt98ygYEcCJ/+CdHXIOx7c9fFLLDVGBq7WEaJ4+
 4+fFPwyxB8FwydbNPSAm3qR95b55DGP1ty83O0Xzgwhiuh1tOIWfYW6naXN+fkZ8XaSV
 zmWlVrmiYetYVNO8Az/1d7vxCkLgUvKhYkKLvhlN7jc6OsPjthVtsNiMxaZ8uXT8kGdh mg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pt3xebs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38T9bA3r008251;
        Fri, 29 Sep 2023 10:28:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfb83ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfmkqUlNo5eNfDTc3E0zA9iJ6Zlmp/eCEwekJJZ+XVsQcx9dpjDwqrCLo8cO//tVXz0OTs4rpR7vONDKTAvBAtCIhXxno2N/Z3jWhZIrhoNu3Y1HXOnnk5bWSeHuVdku3O37MHmPC0YYKDN7ZQC7OxV7dTxxxuLq+AeqJ07yjMNVDeCJQ8QKYfiryfxvOhgebMoIOWinZoDmaG4zLSqs8Lz6fLraXnWB1gXJhcWq2L5n35YRpdxJ+Pls/zqP5F+gnZF3llCbdD4jJOA775mDWLChfx3PRCRpd7BeCRJoNxfY/BoVocCvPtTaqinBxYnEvzmX2w44f38vPwayOghZgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31jc2+OVZmwNZGcdfaPyUtUaj9QVTZmwNDv1+AWRPKM=;
 b=JGoePJEzJkC8x8PlJ+JPOGak3MTYyYE1lPpfO16AYjg8O3Du7e3E/rL+UKgRtYEbDbOCRfIZLto4C7xSpc2Hyp87dB82htCJu5hY2rPdaKluH9kTsegemBHvwE5GNnCcCWpLi2TaPKJjIWgIWtrmPFgVdijx2Hxp250St44N/3YGopFZetbR9mlENYLDT/LBiAy6eqppOTJMF7wVWSJt5ng3Hm42o/J2sW21Gp2T+M4ysUFpFspux8FDRMh5HJyzGwMPaYVeIUwE7j0bDT/RoBEtF0j9HZgd7LJUuCODz3Ry160DXieKn/FqHb1neE1XuDIUQ17Pz37vF5kzV7JVJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31jc2+OVZmwNZGcdfaPyUtUaj9QVTZmwNDv1+AWRPKM=;
 b=EYt1BgfLHjZVRUPeXBGXbGYvx33bG68uo9rKvDCzUIom7CaHr3RyRzEFf3MbVALw4Lzzg+drryoaQSEHiKZyYx/s3c47ceETxdTQ8PssAFfaHQQxhc1NYz2bfRG0WKXi6Nf6V5tz0t+YQNaIL08IPBKvktHYgtjsVgIWFvW9O3s=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6153.namprd10.prod.outlook.com (2603:10b6:510:1f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 10:28:00 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 10:28:00 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 02/21] block: Limit atomic writes according to bio and queue limits
Date:   Fri, 29 Sep 2023 10:27:07 +0000
Message-Id: <20230929102726.2985188-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230929102726.2985188-1-john.g.garry@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:510:23d::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 95cb4a4b-7fe6-4547-9df5-08dbc0d6c107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v8FCtPaMEiYy5IsOdKRmS84vzrA/TkfhBC5eZLJ6bVu978Dk1ZYr/mrd0W1vENMM/jMI6xoWZrsJV2e94A7D2Zidxjz8v+BS/0RrLLt+eohsGhGHMsZQt3/K8GOhT7zLVtqtQYmdnSjEUngU81ph0n6yRlh/mJIQaVME24JxqBLZCH7ApQgUGNXRFDrSvbOp9T+FQYheta2/W6yhrj4jhmOVEzNlnspujyQjUfwlG5y1Q/KKBdK4vSeU5bdboaWkN/zxf4IM8n06vHXkWXqVwLOHOOWJw9uFWNeU8J83Y8+nPwuu7LUkqdNC5kH9G74ooNgRiBYTDULbUXOVrK4ErN6JtYGCR4cY2cDBsh5WRUQjjdZ+ZYmPyujSuDaOdKle+VKh5BmTc04F8Gg9NuvK2co4qWgb3XKlWnh8nmJUJvCZ73SvzrQvgBIqs0Odw4yR0w2LcguZhsB2vRvgZwVNYWXf/SDTu1zv5f+eaudSFYd+/3ogL/7Z5HS4SBTxsOBEVm4BMILmq3yLnfiJQM5/0g2ZDTqoqVHMJ6QfzYJiLWoKi7JwQcFeY8Am7AfOiQtYobTsZA99RDLnAd6oDWnBGBXkRCcqxwgWpcUluPknZ/Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6506007)(6512007)(921005)(107886003)(1076003)(26005)(2616005)(8936002)(4326008)(36756003)(103116003)(66556008)(7416002)(2906002)(5660300002)(41300700001)(66946007)(86362001)(316002)(8676002)(66476007)(478600001)(38100700002)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w58v2LJ7YEHcZGophxosc5x/X752J19LRNIZZ1vYn1TGq9LoOLC7WDKUfpA9?=
 =?us-ascii?Q?YJkOYSkyw95bOUlnqSaaCpTFAzLlX3K2EAXQVRQRmGlgqH4gD2VhleMxAJFc?=
 =?us-ascii?Q?cLXM+R64s/Hm54a7+TnqD90H4NAjwwMFFQRbFmurV9K0FbX5HseQa7z/nqlw?=
 =?us-ascii?Q?9mRrtr/mQ5qok7NOYPN3Tfgmuq2X2Ji7JKzZEEzEu07byN2Bnk3zE0jblPF/?=
 =?us-ascii?Q?aZX00LM6DsYsDa1XEZg8W9wTaGEE2xUrJw+2N3Olvj31aSoXDbUi3qj5etKl?=
 =?us-ascii?Q?SJGH9E8w52Am/xRrT0iEdBKTcHlUoawYmCiZv8rtlDA9wmtMCj/askXG//z8?=
 =?us-ascii?Q?uhFVQaxFMQk+alc50t0VZRxtJoevDzd9YJVuLKLIkMcwbR4aTsCCHy2kTlW2?=
 =?us-ascii?Q?Hh6ziP0619dRjg3KRGNAl/H7BODAbqch7PjV0LBaWb7WbTGWCQYX9IJKtkaT?=
 =?us-ascii?Q?fZKPhHqQWczFQe1SN4SDov+oW+mG+TfGiiOfzCC3VldhDcvcVaqn5cWA2mut?=
 =?us-ascii?Q?JdNzfFrnxHwnBrY41MKpJmX7BG3Ib+RJsveLm70EV0iGxH0OswWw2qemyThy?=
 =?us-ascii?Q?5UKdgzq/rmbbK526b3nYgsIZd5+gKODJDyvNoRJB4ZZa9YUb59fHAC1yycYi?=
 =?us-ascii?Q?hfvUxNzhrO34gFbN21KUAj+JHKqltlMYKnXhyo/zBnSADknpB42E+3tqkmr+?=
 =?us-ascii?Q?+7olZqh3MTdkvWpcN6FyqlbhlNGE6+CUyJnRY+pwbr7cnNqy4DflYnGHDWGb?=
 =?us-ascii?Q?h5yuR++225de3FGLJsNjnILoEDymbenQ52+OOw/1Ubl9qJ1qTypua0Q2RDWm?=
 =?us-ascii?Q?RP/3QviWm2WXQ1++R10n/f0hVj87Wd3OZFYMUK329tUMHi4BU3KBTjlPhYBH?=
 =?us-ascii?Q?SFi1VUSoO4MRyhLjFRvOGh9eRH1gM+5pN1jupUhX2Ig0yXuIzOfq7XBmUj3C?=
 =?us-ascii?Q?x1M610ZgKdznMxDvIfGJJwLzMxDL4YflEj2oMMJ/ixLyBFpb17RC7BsSivgC?=
 =?us-ascii?Q?iNBuKCVhFwosAT80ekK+8rK0F2Na28WlOzodslDrkjmYzbpVi1A2csiMF8j9?=
 =?us-ascii?Q?qjUP2heKmISqkxWoAZcR5T7iiCGNz/uL4SqOhhE8LdgcknB/OE34wXfc57NX?=
 =?us-ascii?Q?BhsyCQdIJCu9TPqoWGX7HAOMtXv+4bfpZFMHsSGllyviHpbULZhH6ljzPOiL?=
 =?us-ascii?Q?oOdgv8zlqbUiq29hBcrdibKV+e9gr4Nkido4SftvI5fhFdY3vywYqhRWY+qj?=
 =?us-ascii?Q?Zf5LYCqwZotjhCxBc2JGYEG9p41hd6GiY/OfTCfzh7kejnaDnS1szEL6HIVe?=
 =?us-ascii?Q?crYRGBzg/Of4IiE+XJL5BM1zeihvB4GH5WBpRT4cc4EeS7l9+HzuOL53OnPp?=
 =?us-ascii?Q?DYPhJTA5Xk3GjeZ/8Tf5fJgh21dhoJdpNTbgcIrfFQTC3lSkKVmnrXnwMrLA?=
 =?us-ascii?Q?KxeaO8YtmK3cKU/fPXQwClnYIGqyU9e97cX0fRVL9T1uvGk//uv7C1pzMbsx?=
 =?us-ascii?Q?y5mQDgxVa5F1ctmz797nx7wY+ikgAWKHxo2CWr9zPa7DD5Uko87jNIbxuxTK?=
 =?us-ascii?Q?PXX69rR4MflLE2Kjx3pDqiVulZQqbR93aQSGAbYdsltaoZu1UlEwyDp/218K?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?0z/PvhbXGt9coWmcU+O7MXB1h/lmDqsixU98t3Qiai0kJXHOGdSuVUo0OKeU?=
 =?us-ascii?Q?u4pXPi5V7QjPo41d4dArBExQxQoBX505lezFCrjVsAlzUrFFoaKIWmyqWyH5?=
 =?us-ascii?Q?2k+I3UMqn5aUOsdxjWXMmcRNjKNIRnhFokGkqbCTNt3+28qcZXTnjxasZMCx?=
 =?us-ascii?Q?aI3n7Q6CsRkvIgB7924L110vu+vQwtaQyGls/5xuOUM+VlxATsbJQMmx2eCG?=
 =?us-ascii?Q?ibPUAgZorcbZQCJ/MaoTwAAge9iqYHLp3QRKhak45Mr0tYv3u1GIlSOa03bq?=
 =?us-ascii?Q?ykGAWMOE5o5ZjEsf62ZocdcczeVSmtEmR10jLI4ovC7Wu2YXZXRKxi2wZmFA?=
 =?us-ascii?Q?UteuCj8Qb9fVy8KeK+F+FEFIK21Qz7RDRsqm2kt8Z4hF1FjQ2553iiKTao38?=
 =?us-ascii?Q?v8wEiAdoL+dwy4oo7xLH1KYZp9oSgAIyiklDOEO7wDePB9CO4PZ83y930S8u?=
 =?us-ascii?Q?lpPg5i0z5hDINhwWGwiBtyN70isSXiqIVfjTweDbIJFWMdoqm6fx2mLVO9tf?=
 =?us-ascii?Q?T6G0LorxsiIo5DcWSTUPMIi0i9Bine/HQapojP75g8+ONeMblaIorM3KAiV+?=
 =?us-ascii?Q?Scm/gv3Ub+VPGCvUCcDgEi8evUF15CtI/nviPd4QF4q3LnjivTM1gbjqq+zt?=
 =?us-ascii?Q?Rz6B3FfeuqPW9JifeL8kvaY+lVKFPHZAMg2KiyUBZels/lHIt1ycOrC41WCI?=
 =?us-ascii?Q?R/7qB75OKqqRb3wEU16wTMVaNDCAV9NxXWGFl1+X8HlQZk536vUPLA9AsAQg?=
 =?us-ascii?Q?15iC86HmPCT0q6Ig2QD33upk+HbqzrsPjib5ChpgqWScn6D6lnnLgYb9S54v?=
 =?us-ascii?Q?VwuULy7PCa9Ny8e26+Y1m8MjELwla05m28hPmXQKRFhx5g6VGKWs+qIbJXpL?=
 =?us-ascii?Q?WCg4k4uizHVettD7nPr6sGGkaA0KD1T93pCJtglOrhBNbprmo5GPJ20l7su5?=
 =?us-ascii?Q?Fh3WShuOJx8u52Vc0VyRxlzYOHF+i8JvmiVHCkMHnEv+1Jzu6d1rVSaWBP00?=
 =?us-ascii?Q?ldsAqVHdgqjatVfh3DqS2HIQwBwPC3bPZBIqvs7DarhpMJCJkVDCJC41C5FC?=
 =?us-ascii?Q?jOXu2cW3U7FhbCrCZ6ZRr0by5a2pfA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cb4a4b-7fe6-4547-9df5-08dbc0d6c107
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:27:59.9869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9q8y2DeiKlJyM0GfMG0V3HcC1KPLGhCre2xoEnjlPLg8ZvhekJiLUEfM3xlHHzwk6l1LCGVMh7DIlWEfwY/8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_08,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290089
X-Proofpoint-ORIG-GUID: Z_Asfb5nC2yHToOJLMDmUFnYHZcTfEeE
X-Proofpoint-GUID: Z_Asfb5nC2yHToOJLMDmUFnYHZcTfEeE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We rely the block layer always being able to send a bio of size
atomic_write_unit_max without being required to split it due to request
queue or other bio limits.

A bio may contain min(BIO_MAX_VECS, limits->max_segments) vectors,
and each vector is at worst case the device logical block size from
direct IO alignment requirement.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-settings.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index d151be394c98..57d487a00c64 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -213,6 +213,18 @@ void blk_queue_atomic_write_boundary_bytes(struct request_queue *q,
 }
 EXPORT_SYMBOL(blk_queue_atomic_write_boundary_bytes);
 
+static unsigned int blk_queue_max_guaranteed_bio_size_sectors(
+					struct request_queue *q)
+{
+	struct queue_limits *limits = &q->limits;
+	unsigned int max_segments = min_t(unsigned int, BIO_MAX_VECS,
+					limits->max_segments);
+	/*  Limit according to dev sector size as we only support direct-io */
+	unsigned int limit = max_segments * queue_logical_block_size(q);
+
+	return rounddown_pow_of_two(limit >> SECTOR_SHIFT);
+}
+
 /**
  * blk_queue_atomic_write_unit_min_sectors - smallest unit that can be written
  * atomically to the device.
@@ -223,8 +235,10 @@ void blk_queue_atomic_write_unit_min_sectors(struct request_queue *q,
 					     unsigned int sectors)
 {
 	struct queue_limits *limits = &q->limits;
+	unsigned int guaranteed_sectors =
+		blk_queue_max_guaranteed_bio_size_sectors(q);
 
-	limits->atomic_write_unit_min_sectors = sectors;
+	limits->atomic_write_unit_min_sectors = min(guaranteed_sectors, sectors);
 }
 EXPORT_SYMBOL(blk_queue_atomic_write_unit_min_sectors);
 
@@ -238,8 +252,10 @@ void blk_queue_atomic_write_unit_max_sectors(struct request_queue *q,
 					     unsigned int sectors)
 {
 	struct queue_limits *limits = &q->limits;
+	unsigned int guaranteed_sectors =
+		blk_queue_max_guaranteed_bio_size_sectors(q);
 
-	limits->atomic_write_unit_max_sectors = sectors;
+	limits->atomic_write_unit_max_sectors = min(guaranteed_sectors, sectors);
 }
 EXPORT_SYMBOL(blk_queue_atomic_write_unit_max_sectors);
 
-- 
2.31.1

