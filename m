Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E9E5A1270
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Aug 2022 15:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240447AbiHYNhC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 09:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiHYNhB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:37:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F0CB2499;
        Thu, 25 Aug 2022 06:37:00 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PD9Po5004590;
        Thu, 25 Aug 2022 13:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=tSrn+HliidosAeKxrDT4IN3ULs6iPW7RaGjrBgaIun0=;
 b=npesD+1qcvlM4sNsaLVHK3lRf4WSIaz8qMHW2h1RpKwZEcHSGn0sjUn4SjlcEXes7pwh
 7wShBQOpDa622abGzIC9DYG6xda+P2ToAoiqFOhddx/oemvpzSnC7uEYzO8zwtOMQjXX
 bgMak9x8Ag1NVIQWPrFaO6PKonWDDc/PrUkkt9n9/fMAFkmPjWhsvlvXMZwRgc6C3zeS
 aNAf5mBoUhjll52Uf+/AKE1oVPrFTnMIJaLF/D9CAzTRxGaOffa5AAEqwc0XeulGlqMu
 JSDY/lsiqeicrsi8gRBAvh8cErYNHgYRZ1SmqfWtgNhTVmwHQ6MFLAempwcx4Dz5vbpD 4w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j55nycv0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 13:36:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27PBEBkA021748;
        Thu, 25 Aug 2022 13:36:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n5pax7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 13:36:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTYv4jk6+R8QQpmJ2gLk3ke2usS01+O7WVRngvkpb1m1Q6Se/q3Kfr5mMXIO15WWw6illQqfXrwvLeUe/v06cFf3PUCkCSy69NoL0qyK3KQ+K4hs3x38y8GhMvVgScCYwMGn8RAGOH/FXZQwUzDPdbvzU7LO3rfdqSHHv9H5+zFcjPJzkiUbWOnM4G2Sp4nH6M5CHTsU2mmHtyVTD+82D71LLeutP+NxFqgb6vDgZd3eK3Bu4K+WFiE+E3mP2MVfp9bAQQPksw+kG5h0qozPOKFqG1068CO5noxHSgaaAvj8TqWbLMaeUvH7Hq9erqjWQy8VlwtJ7h1+hznZvGUL+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSrn+HliidosAeKxrDT4IN3ULs6iPW7RaGjrBgaIun0=;
 b=cLYZTkobfFgwRPV/IAYi3cZywPk8s2GYnCEu9V4ld+MdsNdH8uuyPlrwNTQ4H3tJj5zAmvfF4s9hIw7+hpCj2bii8S0OZwADUqgiZDzbArduw22YiOOWgVdXtgLmUIHxXa26r+CpsPqVky3ubVCTFKoPkWj9AHx09q0B9+MDAvSNZIjMeMHc9iwna+QIyLkKMsVZMJgAJS5Ok5/0YPLm4hJnfxSuigEt2RfGO3vxX4xN1kAHlwaKjB093ae/IAT0bkXHNs/XyyFSXJPRyYqanLZ4CDYA7YL8SZU7j4yarMZRZ8NVlKvtQn7HObdZc+J73wy3ioxFESVA+/Au/g7OQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSrn+HliidosAeKxrDT4IN3ULs6iPW7RaGjrBgaIun0=;
 b=wRAKZmZi/vtUlapufSz8aKDGxDZaKV6i6aHzgOkFoSBZ8mYQewm39q9TnrIMSr5sGtQuH5ChWUUp1eqlLgQAJnjxJsJ5QH90/pJrFC+7O1h3vlupsZ0AwNhPdAsLky58GZxA5AIatktdfDTU6H0sx60MCh1qCaqKRpP2qeJT6No=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1957.namprd10.prod.outlook.com
 (2603:10b6:903:127::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Thu, 25 Aug
 2022 13:36:42 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5546.024; Thu, 25 Aug 2022
 13:36:42 +0000
Date:   Thu, 25 Aug 2022 16:36:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     David Howells <dhowells@redhat.com>, Sun Ke <sunke32@huawei.com>,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] cachefiles: fix error return code in
 cachefiles_ondemand_copen()
Message-ID: <20220825133620.GB2071@kadam>
References: <20220818125038.2247720-1-sunke32@huawei.com>
 <3700079.1661336363@warthog.procyon.org.uk>
 <c6fd70dd-2b0b-ea9f-f0f8-9d727cde2718@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6fd70dd-2b0b-ea9f-f0f8-9d727cde2718@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0072.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f963b080-6aa8-4897-599c-08da869ed763
X-MS-TrafficTypeDiagnostic: CY4PR10MB1957:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ESa3BahihUCpZhb0Lpt54ipEmAGtjyoaYuGI47bmJkVzzRBAr+pjTNi1wVbRv3qyJUQP73ggldcjglgSRgRoPyKxPEvmIClGPKEJosBd50wAu6QBQA08txA5cpCS1iNg5JoFVhEC0lEg3zPnxT6bqYnRmKwLrgCuLVxLvCaraoq4ScDF3ZIqMFgQ0/1ssVcgz8ZdVkd4xRx/eesRN0s00vkSU6TD4bwAj7r9ZIy4woDwuRgn9hZMkKF6gTNkK+GXvMydlrbVyZeDCacXv1OAavVA62ZL6EusRHZ01ovGVcebZMXMBh7EyLWp+sb5phpX2LB1tP+HULpje1ywyiDgEbIyLYc/DeIbNmWtlOmYh5V9RN8miq5g37iqJ6JVnNKqs6qhFwDU/b0LaaNaVrDEZ5RfKFoA5L8Xplg5iVCYZfDo8mhHss2oZGRk7JkYahyLJo/RY+3FBYh9l6L3R/cu/D3Yuv2YtxoG2v70vEzCsO1vCeg3JOIhsITy8YrFtzPgOzKUl30158IDU59rlsc4Qdrvqtw+bZmWoi7FyOEx4zWYIvI5UlYUcC1xiS7/kFvqtxpGclS2d+S5pk/Pcs/OrDCWlbkPbqhTDngFA4KvuM4f2emK3zCOsBAXEFHPjYTTN2YU9wd3LolnEiV1HF7IzfeyInNdYXgdZ+DhJztxCD+h2xu6BVXbIIo7FZW0Nh83fpYPeHwrEfGAu+sVzwoIVSAQP2rlv+Hcqsz1kyPMA91bwLFquCgCPvtyikJaXE+RfYs1nte5b9qs8yTM3JwFmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(346002)(366004)(39860400002)(136003)(376002)(33656002)(86362001)(38100700002)(6486002)(52116002)(83380400001)(478600001)(6512007)(186003)(41300700001)(9686003)(6666004)(26005)(6506007)(38350700002)(6916009)(33716001)(316002)(8676002)(5660300002)(66476007)(54906003)(1076003)(66556008)(2906002)(66946007)(8936002)(44832011)(4326008)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xamxPXlmRb05EiOU/LHJl14sDwrMDAUbSFyjZCJ37zFr2YSjT6PLQwyTMeHX?=
 =?us-ascii?Q?hDK9wWPY1bmQSLECDQo31U7xYe8DPEULgY/Yee+aH89sxtvHpQUCUrE1dOXU?=
 =?us-ascii?Q?O/SEwtX4LqQppmbBeRlSYajLM9R7yr7mmgy61GkCJLKYWncC2C8odhP3WiF4?=
 =?us-ascii?Q?VyBMmxwFMI9EhlJbBoSsTlC0VopCgcodj7QTqsdyjSTHCRZe1z0htCqhvYkz?=
 =?us-ascii?Q?b3JFOohVLHcVlb1MoQt5a9emVe3fetHktl2WmxdJP8rTXqyOFpo31K1Ex57d?=
 =?us-ascii?Q?LavLFo9Jo6B/C42aiwr2DFMCrv9X7CXVvLn4Q71RbewkHQTgKAvVu9PRT/X4?=
 =?us-ascii?Q?R0aYq00CRH6DNK99JfEOE1Vh5iZeeleVkjDBQ++mfJtzUIEESgmie7mG1Nm1?=
 =?us-ascii?Q?36FPh4r6zQHpeZc06hFfQX3EeKtZoelZ5Ug6JUr9qf/BrVcFa3+qyEZi8hNJ?=
 =?us-ascii?Q?+4JYFHO2oAzLy3OuIwCbQpJrCzOZqN3Kp03PWhMNxefVN10NZ73lj+Ezojlw?=
 =?us-ascii?Q?6sAUxIKMxkQjqma8sgkmJUFZiSsmK3OwzZKw4LmNIScOfZIyyR4+MteuvR9N?=
 =?us-ascii?Q?5KUgwMJ8Hihg66s/TvIiMqGgbI0kp6GZ2oU92uuNpUxlja3Ta73TM/wPziuU?=
 =?us-ascii?Q?nEIgA/wglX1DoNdXg4G0Ia6SXvhWi/jefyr39hD0y7KhNt6lor0s6YqFQS7N?=
 =?us-ascii?Q?rdvDfQdvdSrcHdZv4axMOsRWPi9kX0miPeIDdccCw3ouZw/pGK1ix2YHSh2W?=
 =?us-ascii?Q?mrJtPqVtD4nXOeueWbWfiwyozjs/QyYxPASl7uBtWwButHJMS+t7emeh2Jjx?=
 =?us-ascii?Q?Wvo1CodnissAq6xdSha9Mr5ln0Q4Dj7fxMq2zjbyFYxPHAU6jSgHEonIX2Za?=
 =?us-ascii?Q?pyuo+Qxdww3mNHucP0kT1iwhlmrbFilMPJIJdalues77QgSV178noSYaX1n2?=
 =?us-ascii?Q?u80hFtU0tFjutUZhs2ORL+pSAMLW9550bBDztj3Qmr7wQJl+n/+Sd+KHJ59S?=
 =?us-ascii?Q?QdEeqUh3qFg+S2JrkVazvwsMy34IJIKXo25jjWQqssv+h4X/n8e+xHkao0VP?=
 =?us-ascii?Q?CnefgWm4rg9Jq7XXNRV4Rs6ffzsKzYZpNWb6QaDhM94C8E1KANkpBrpquZIv?=
 =?us-ascii?Q?/icWk98uRAsiGRTGM5V3IVW1H0rLStPvGgXRkaOdwYaQ7kSkrY7MrAOazNU3?=
 =?us-ascii?Q?N+zJNaHw5fFgwgKSINSfKSHWTdYW6eDaVdwdLjHgZ5A+P+8OT0W7ApwK+LQ5?=
 =?us-ascii?Q?W0K66jvGyMjkT/bm2R16qqOaMDW8qxFwiOzT3jj/1i/kJeVDqnfXSX0NDUFX?=
 =?us-ascii?Q?/FknZoYlpuMBxg4GahUqOcJqE0LMFfMH1aE/IBMpOcAuwqC8RJc1eOkbLJSx?=
 =?us-ascii?Q?tcSpqN1DjGd4ItZXwqBZ3U2+F0HpNYr51gxkAZv62qj8FVEWmAvKpOmNObEh?=
 =?us-ascii?Q?/D3VNVonpwEvu7UkOL0xeKD+s+blg+cxgzcN+jrydDoARhwOj3J4vzvcqyqw?=
 =?us-ascii?Q?kw8k4zWiPdOeFKRw+yBcU3a7jDXOkUMLc+sispXDrtYDDVLvKOuDXzJDoCHF?=
 =?us-ascii?Q?dUNuRnQtntiRzNSU3Rnns3hU+QJMBB7kK8EGpOn9JEgXtt4s77Rf0ZfUkWWc?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f963b080-6aa8-4897-599c-08da869ed763
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 13:36:42.4630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDEuHUopfsypHcaNFwgG0u+HyrGbwCdeFu05JxdUmFbEVzlOi1nFrJaOnaSALcLh6tcaIb9GspHctJdXLnQiVAGxtcT7HRMgxEsutb4SpCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1957
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_05,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208250051
X-Proofpoint-ORIG-GUID: tNUt_tbhSYzIjonqQY57M3xJBJ1lxwCg
X-Proofpoint-GUID: tNUt_tbhSYzIjonqQY57M3xJBJ1lxwCg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I spent a long time looking at this as well...  It's really inscrutable
code.  It would be more readable if we just spelled things out in the
most pedantic way possible:

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 1fee702d5529..7e1586bd5cf3 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -158,9 +158,13 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 
 	/* fail OPEN request if daemon reports an error */
 	if (size < 0) {
-		if (!IS_ERR_VALUE(size))
-			size = -EINVAL;
-		req->error = size;
+		if (!IS_ERR_VALUE(size)) {
+			req->error = -EINVAL;
+			ret = -EINVAL;
+		} else {
+			req->error = size;
+			ret = 0;
+		}
 		goto out;
 	}
 

