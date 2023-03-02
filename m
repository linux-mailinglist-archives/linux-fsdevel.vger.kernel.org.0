Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8796A8B9E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 23:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjCBWTl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 17:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCBWTi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:19:38 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708161422D;
        Thu,  2 Mar 2023 14:19:31 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322K6b7H024682;
        Thu, 2 Mar 2023 21:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=T2e+wEvh6CEU5mBu5CS/OdnLrPBrTo5Wr2LGpUBCF14=;
 b=2SBL7OeXyTD51QQSMRhZew0GKGpMc8+IAKs83DvwHsPiKyd20MUH20ANDk2DvK3H9Gm6
 82noSaFre/hL0Xc+JICWo4l6l+xjhR1nTD24wC561Rdb5Of5vSWUNAN/C/9m0jozckGK
 V4XYP+HjGbDMv6p/Fdsn3pD9FXaIY7TIEqqp5h1R2cG28bzQi8RIgXPscw/Hug+OB8nL
 EtfnLmptP3/DU3ytwH8A8N7zJ9/WzObd2hbaUMdJiZ1fG+4Rt+wF6O4ab9KRRT6StPSJ
 5NrcHwCLSQyv2JfE51l4TUK18FWWcNp+GgkjYDbYy37dcAbTRLkdnX8aZtgmFlY9r1TL /g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nybb2n244-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:19:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322KUXCp005225;
        Thu, 2 Mar 2023 21:19:03 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8saxx8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:19:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPF7ly1uf3BmrWUDqCzylkNKFCuA7ULmINt6QOJdTfJoQlsRux+/HVkYAV7krye4++G50a/6sQoURKTWAEFPaBX4lJA3xP9WpBCL1FQJJt8NxD2mHlN+f1lV46s0Hou7JWS5WpaMatg0vBu5uqyAkN2ruGzl9Gyjh9LxOWjrp28i7TPVzkTIB0o5SEHS0prBQr1ui9mTV8L+fUrSdfLTomLLW8QgLymAz0sPcj0DsvnadauhOklq/0hpMNXJeN3+TCEft9gaby0JE7/Ha8swJowoZc2lv1Zfv2WdtWn8guFJ5ElsZya8nQN1T/zmgTqdD8dEj3Pgi4hp21Y4BY41QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2e+wEvh6CEU5mBu5CS/OdnLrPBrTo5Wr2LGpUBCF14=;
 b=hVwbarUSTLpgleqGOLE4ggFkR+jBL9AHr/qyVD13lFzesTiGFmlh04OXkItS6k/D2/T/BYI7Ych+2/1OPh3x7DmZh9j2eD8EWFkxx9mUeR8vCMOk2bjlojfB1MUXF9fKfCssEhVUox4SMbchSfp8bEat/I/aj4G2zhir2EWEvoqKxp9AnY2qaT+jNCmi33lj263YGXKFEthUpgJBQnFKd80BIlugg0mlWMnV1efse37EgGt/FFZ4hOamOrAeOFtpYduiV9hYkgeKOclTRrNi6mwTkX506ZAHmjZ0ZyvDklH93Iifn6Gv6Y8g67S8Zkvlucr6yIWchGeLsu42aoLKyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2e+wEvh6CEU5mBu5CS/OdnLrPBrTo5Wr2LGpUBCF14=;
 b=WwjteQXICEEahqwaD/BUlAine7J6QtxsLxtY4JAXDHnATIJmPbYgNLRa+/NY/w/6LiJAWi2IPH6BSxgktXZXqvOw0SaV/Zlmnh5UGBty1C1BraKnQmU86J2Qy+ZEmKMzss2N+s75PhPBJDPGAkm8Qp8c666bId/+JkCbBhQ3cno=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH0PR10MB5819.namprd10.prod.outlook.com (2603:10b6:510:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 21:19:02 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 21:19:02 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/17] unicode: remove MODULE_LICENSE in non-modules
Date:   Thu,  2 Mar 2023 21:17:53 +0000
Message-Id: <20230302211759.30135-12-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230302211759.30135-1-nick.alcock@oracle.com>
References: <20230302211759.30135-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0064.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::20) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH0PR10MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dd4406d-2aa0-43a6-c15f-08db1b63becd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hd3Z6LrWqiz2zk0bvxR95ujLINAriyn3szxQ68f2eQusqQ4VIwcZvOP6GwkkN71eaJv6dpG4hSiCuYRvbMjdyBnZRTJGxJD8YoA3l0Mbxp/KdrGYyHA+uTqzZXb506S/In/g4Dtj91lHUGez56SI6XMBsIjzkwInvnuVhAvx2O9IE/g/6vrh/HsQ6TTBOJau3fEWU2cYW3V/DvtSFVxDFnxiDvErPio6CpUdgInm9MicXPVzsGYZzslxgQrSIUm1yF5Qtj3YIkk8syOznneCNqzl6oqZJmq7bfep8ySJsrakjnbk3OEeVZkkB+dQDcS8+3FPpsh5H8m82Aw0EH3cASHsniH24yb3ZDEawogvieSHmJdabILiP30ZvoLGECflXKZn2BMfcyl+RX8BuC/rMZyttYA2S1jlsi230y8mxDLSM5joAAl8M4932aFQ6upIiaKYVRpsvlO2sjAwPlbZ7VIOqDzLOqped6D8H9qlaFLRWqCUD4Gsbap9nWI7XzSDqj9k0I0Wk/0W+G7DJPqlP5LyCzJRg1V1J5g87ysrWx28s3MKsZ0/rjr55KYPf9ZOCg43gJp49cwTA0koz9k5ss6iMbJi35mA5B3wdQpVwdt+8XGQPVOnYtBLqVUi+l3JhFSuDEpgjoNyc+suX3pDSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199018)(5660300002)(44832011)(83380400001)(41300700001)(6916009)(4326008)(8676002)(8936002)(66476007)(66556008)(66946007)(54906003)(316002)(38100700002)(36756003)(2906002)(6486002)(478600001)(86362001)(6506007)(186003)(6512007)(6666004)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yZ5vD16EzkA+mhnQWRX6pyhNSkhpBj2EplRJsUJ1Ga9s3Ouh2lM+AyeT7hGe?=
 =?us-ascii?Q?sV5LX0q6gjaoEbq/IzCLh9Uk4nvjo9dphVoHgefCxBdZG8NJqZqVVhH5ekr8?=
 =?us-ascii?Q?itpFw9VttAwoYq60q58fqiYzOUVxPlcr7kvKmmtFOkpa7q13UVQXXRYwSNXS?=
 =?us-ascii?Q?M/8n+6ZNOnmc6Hy7XNgcQbp9XeIB0OINBfdabMv9K8Jn7m+bniOxSIDFQojq?=
 =?us-ascii?Q?Fb3T+jH4P8teYL7+VfE0N0/fJSBHFd64ChSP4dabmh84eb8DQFczg/ClqNex?=
 =?us-ascii?Q?VJlgGNa/mqSuphx/T9p0WiEqVA9XvJT8uQjiBwM//54DlAkl3Af5twirARZy?=
 =?us-ascii?Q?cA0C/SYGLnEch5K9fcKI+I8dkyVKCxwORRQUqPLv0enf/K5P6SGIIEFU3KZy?=
 =?us-ascii?Q?e55gYloLbv2y6un5f9KYYZ+kLp2k6VeCsDCy2hl2LfYzrXrLTlr6vJF8pkrJ?=
 =?us-ascii?Q?gOKLbFJLRX542M16Gu+GT5fEX8GnoIzfflHnqhRJn2d8Q2QHuA6boXYYqtdR?=
 =?us-ascii?Q?FWsdjQB8PkyfpZITrvHYbyDH0mFmBXW8MfcSuhHW+T6qij4CgXROKxYYWpAe?=
 =?us-ascii?Q?1Hcr3G+/D4sIw2E+eN2HlQVp4QGlKhN5ttd2p93O0niNiiGJ1E1O/sZzVnXi?=
 =?us-ascii?Q?qvgpEdRln/l0zDJCf0/M+2+aP30jZLMncLHHQNvkQ5WLXIbns/ZS3R+abXej?=
 =?us-ascii?Q?HYoqzlhycYdGyshUoY+kj76RiVFujgnhLaFEVM35oRJ5rxxBEkTOHkBWxcJW?=
 =?us-ascii?Q?nlDqg/fXIr8eA10RSNHUl5fpTR0GEgRdBXPJJHKXzmXhtIFVBPJB/+wO7aNK?=
 =?us-ascii?Q?RBsPfHm8jha+qwRDuWc9XqOCVSHRcvJH0xKdnO0M4w+zmvwkT/8bgqWw5vyL?=
 =?us-ascii?Q?D4RE9v6nPY4FXN4w5dAouiCtyc3C67Skif1Ax9PNufRMcSK47lzw8ynaCmqL?=
 =?us-ascii?Q?fRJnmZgVCRXfBShEEcif+ZurY+3gMpLSpQnR4L1vF98SLB8OhQ3YuIEEwfIH?=
 =?us-ascii?Q?5fykXSHE/coW9pmTWA/p6XeJS8UwkJLeSCI+5jijHLwET/1y9gro/GpOqj1D?=
 =?us-ascii?Q?9IJbFSzlksCqCaDAZwHB8kw4Qzpkl24ESp+rVQpFpjxAyLE0WaC3fwaJpHyq?=
 =?us-ascii?Q?baxjldHXNRWioxrdy0Ms+vwDvQex9FxkBUQFbByczzB4eUK0H00tdvdDG22W?=
 =?us-ascii?Q?YK4/MsZOx97TMxlzCyu9+ojcPIVRR0Wm5rjYVuCWCyFyTOE5Qb/VjiCUI24f?=
 =?us-ascii?Q?A88lujwAaWImR0A+hHb18H6D1umLBKzdWHGglm6tTNt8INgWGMe1VO3tlHer?=
 =?us-ascii?Q?Omx9jQQEhnrbDT9T32FkZuUdFmTNUVwbDo3+0IBlC+8Z+uADCeRqMgASioH7?=
 =?us-ascii?Q?RhJFGZKw47pxkB/ZzShw7CCbTIOA9ehm1dlB8lODZFD+SuH78AqY1egodtTA?=
 =?us-ascii?Q?ad2bNYudS2O98Ha9Tm1IYsN5f6tIu/ZPcuSqolPeCXO5AwBdNNRSkDSF1bDG?=
 =?us-ascii?Q?/02X1FlH0XkZAcjynmx/TjTjVhKjJjqABMnlyxuOXZKrG9p7EYY6fXVRAFB6?=
 =?us-ascii?Q?HpgQF1yehHxt5osEShmFrCfLWwbjgPICcI/ZZZX93ftwF67FlyrE+AWF9wKb?=
 =?us-ascii?Q?mZ2f5Gvllttvo5Tg2SJ5aw4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: m0GoywVzg6HPCFd9OHYNPXqj09LqMyK6yT5OATSLFpGP7L/xDmZaAlKiCFxqU3l5N+44WweKARsYaoATcRLETB4A2VYOtLyNKPH6JzBhM5Yv99XIAcvz3Xy6lbXf5PgHIxkoT67oUEUmdNe7K9HcBbbbnAWvb8Lo45JMno99GI5Isw40T6+tiAKUO1Ufq/DOwu1sZZZH7fA/LslnmLPVGL89IeMVcHCaJgIBev+qdBncZSzk9HqJQzVtYSi450SRStWZUg+WtxZZITdWuLwv/jaqwwySRsjapfNyxyElesF0p3dxoVfSke8re5qMX7rT1QpYW0xi134583nsKvgWor0AKNJPNTTHruDx9kNrZ0IuI/lGI0Ts7LuQPfrneypGhaE/0Ra3zJ+fm3fBaoX6BOoz86Vij3dpH0cYFUURkvX2Elt8LZUa6hwm2rW4oLdQ54JSrRmpEbbCwsTtzxzFq0bTPPKppjf1o5UnlLpqtn6Dujna3fXFWWPj5KQ8PJtqQgl5JZ1w5OYD5ohq12y6PKAhtW/21HquuGYW35qabysdjHiqQYkenv8joheC6JA9u2egeZ2dDx231j0oztcaP5CXLFSIAksYMZG02+VtROD4fkiUM219uHWJA3pDzuma20A7A+QghzHTAQSIsjokaRSPAJ0leyGADk1lyoT/bfLFjZeWVPa8L8YQAUhvwD9eG5QbwjmjvDRGdc0BCZj/dacnMotTIZhKHyGYZ50eyAE8GEQ4FUBaroHsnpjNa7T9NDq2MW1MPadCfjyUIIZxWZ+0gwVFkiKkCUrXR00rPx2XNd90+YPD2SoUV1sH1g92mTtv9rmhWHGF/Gksn3pLvAx4KyDM/Uk68dVwrpcQQHk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd4406d-2aa0-43a6-c15f-08db1b63becd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 21:19:02.0862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYMpVZ+q85mLrm5bCAK9dIeD0BvTIgE4Fw+PzmoF5vcbIGTLUchauNNknj9/fuNAxUMLWr5dMWQsZLMLnnk0ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020183
X-Proofpoint-GUID: Oy6WYVidJeqO72TVSVYvI9DCov5rPC6z
X-Proofpoint-ORIG-GUID: Oy6WYVidJeqO72TVSVYvI9DCov5rPC6z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Gabriel Krisman Bertazi <krisman@collabora.com>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/unicode/utf8-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 67aaadc3ab072..8395066341a43 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -214,4 +214,3 @@ void utf8_unload(struct unicode_map *um)
 }
 EXPORT_SYMBOL(utf8_unload);
 
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

