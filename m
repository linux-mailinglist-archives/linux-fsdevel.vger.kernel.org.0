Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58FC626428
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 23:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiKKWGn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 17:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbiKKWGh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:06:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC39B2FC35;
        Fri, 11 Nov 2022 14:06:36 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABLomDE025514;
        Fri, 11 Nov 2022 22:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=FtqVkv0iOH1SN8NSSVD9V+dDgHKSvOJG9Pe24Pax1O4=;
 b=qu5KhkgyAmxUUl6q+T5YyodabUvP1D/i/r+UabMI+9WMKptFVzSGLHXX/I3xovMMgI5B
 9LI0ViQU4fk6UOin+TgNTuThRC1WaqZh2akTH+tIiPaPebVoPNmcQRC2bcsdB3Uey1bs
 QqyMoD598EqMdIHYc6hC1rp+okWUJhQg/FEOtIYILnHI9c8EbXbfhOv0GaIDjLdBxmxw
 0XLe60RttOyI/ze4VVWNZWKXc7eUWF//iovSmgQltrxAefyp5aFIpIZ6PQYoI4ATVfNf
 qMFGrS+Tv+6Aony8/W4+IzHotQo3AsjhIDqXyDdeHmk/eMFZUNNNIZfUfBULRIFw1rEk /w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ksxnrr137-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 22:06:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABKXRTm011811;
        Fri, 11 Nov 2022 22:06:23 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcth2hng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 22:06:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzuFNpylx3AKnfDCAWmpdpQXxiTa7rYZAEDrJ3n7hj7ZFiq+Kaz5q76/HG8NbxrgbuK7xvskVPT2VdxrimNPYtXQwMriD7E5NLF1+F25jKxsvJF8HexqBDgXe4HJibD/KkXj+59SvSNLc+jms+CWLP1sGrHz78XGWkkLdUPvpVLHx6zxlnvsecl2CwssAN2f0wDhuVklCY+b+eLuVi0URc8M/5MkLKySziN8/nkJc42JymjJ4KVj3nUlxWvo/UA4UWF1apTJUp/EVs9FDNg/FlIGBqzBmb41ReFnBcoxS3o8/w09W2G6HXXOMLwTyXuzqPx5QUfwwGBYFS+IeLT6uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtqVkv0iOH1SN8NSSVD9V+dDgHKSvOJG9Pe24Pax1O4=;
 b=gxP/F5m2tpRGW94JDSy9wClbSL74kdpgE3J/K3ECPTAD3JnVqXQXbWqKVVL6yhG/myVl04+POFYrE0XUXNMT2H4zyNQyxegYn8UIPhyPYraj0DowO9QcKV/Zn1MtoBVx+yDvdo6zK/OqtpqiNrpRJ+4DHYlmHoZo/QZsd8OAl850c0ItjE3s6Ip0f1llucvQ7YdnTOJRZBX0lUa5rRqbC3s/6I/K/Tt9n0Ops7x6lmbF5Pf5Ll7mRunOHYfye3RIDA+DrIQPAbnZ3SyurfTFJBhMO0VivcGQER04N5hFf8elwYqKTrl3csecbmIgzMPht4yHtMCS5TxArltIM6AfFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtqVkv0iOH1SN8NSSVD9V+dDgHKSvOJG9Pe24Pax1O4=;
 b=Btm6Rm7kDP00UZget7vJVPqnqVwTnvpHs1VKlTqCeBqSFaDV/FXrAZ/BtWT30iH11DW34HC3x+u8NRraT2h9VWzGDeBXI6jAW5JN1TZJsEhoS0B87jqTA7VY+HgZzYowPTFqyTny1xpess0LlrH6FUnPhVjuqkYNgBeNwhmILsg=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by PH0PR10MB4535.namprd10.prod.outlook.com (2603:10b6:510:31::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14; Fri, 11 Nov
 2022 22:06:21 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::c544:e51b:19a0:35b2]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::c544:e51b:19a0:35b2%7]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 22:06:21 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v4 2/5] fsnotify: Use d_find_any_alias to get dentry associated with inode
Date:   Fri, 11 Nov 2022 14:06:11 -0800
Message-Id: <20221111220614.991928-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221111220614.991928-1-stephen.s.brennan@oracle.com>
References: <20221028001016.332663-1-stephen.s.brennan@oracle.com>
 <20221111220614.991928-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0132.namprd13.prod.outlook.com
 (2603:10b6:806:27::17) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|PH0PR10MB4535:EE_
X-MS-Office365-Filtering-Correlation-Id: 5036e0a7-4f56-45fe-6efd-08dac430f729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jiW+7QnRflwaeEoKoAXq+gGdhqm6i0ThF8sxlaH5Ikmqa2bzMFgQUglV3/TXIZ4Flet+AehxM3CZqvEtNVJbTUkcbrNLjY4LOOl9ak06CnYm/280Z1nhVIUmHFQ96v8h84flux1tebq+v7T3ncAQ46JYMILx64AmTErH2/bITaC5P7zy+po/Sgru0BAt/q8Bh6qohGq0QqSQPcquoSZO0J2hjQnL5Jlv4Cw46rmpV5jyiZv3voGy/s1oqBTi+XtCV4lego6IblnUEwV7tNPzNDEtGzCGouJNYOAupF4fw9mOE/lVbKVizs2nQZn42HhYyYthqeIZIE2N0JMQs7zQBSQj3oTnD46nT3npPfyX/xAWiHARG1a4VrXya107z9iqLgC0Y+Pz7/iRkkEqngW3rvPyN24GZb9XmwsFc+sA2FkHPRl/EUXjqUDWPC7QzbOiJWCWYg14TmPg0SRmFv073rv9jY193Z+MSPZ8lA8JKXS85M1HzwvfRhDxnLS/5iCRJZlyfWTZ76kPz67cvWLQL/OEsQ17demusFj69bhpoyFUQffTWN+/DT2goMIuPWaJfseYBCzzK7aDWuePLy0Yd51dJ5pD0vVNd55Six/NQk5OcyoTh8SqetwWNpTv0SxI9cCdZcgnvka9Ideb3sBaczwawmTdHUyglpN3ORUVWtG9sgasMFDOeKjenPlJdZrSlyIbAdy7mNrw1i7gkUyjtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199015)(86362001)(83380400001)(103116003)(38100700002)(66946007)(2906002)(8936002)(5660300002)(4326008)(8676002)(66476007)(41300700001)(186003)(6506007)(26005)(1076003)(66556008)(6512007)(6666004)(54906003)(2616005)(6916009)(316002)(6486002)(478600001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LmipkT2K9W/wK6Q93AciZXsOHjEfZET4son8AuFN4fZNEus6nKPig3Hm87hz?=
 =?us-ascii?Q?jYrmsMWM8Kso9rk+4Z5WfHzaQM+bpAC4a6p7M7wiv6gkzjCbpwutQNc6n6f4?=
 =?us-ascii?Q?LvXMi60yahNAdMeZGnRfVpeJhQU6NaETsO+kyEJIomDn+8wT5trX2EYL5vql?=
 =?us-ascii?Q?sekCi4TdnCFQs0ec/+GXxksWh7a3uReX0c97n45eC8s7DX+tWVBFqcYn1YxX?=
 =?us-ascii?Q?N0l893PT/OkIpSgN4qFurtz8FTK/ZuZ3R9/1Z4HSw2RqhhX6NyZcwR0mBtk3?=
 =?us-ascii?Q?+gyS1efburfQU+iahIFWEJNcHHf3cNd0qFamUm4H/WS+e8S1ZzuQCtMMVMWY?=
 =?us-ascii?Q?Uf4KnShwINs7y2T+ELMvnOeo/so8uJeNjeZpD5FgvIPRmcR9ZUwdv/2YsahJ?=
 =?us-ascii?Q?OuKCJO+v0/kKmsr/Mhjm6M4+EkGMB3RjwkI6azyOsJe2SAr+k3IkSzZKrWHP?=
 =?us-ascii?Q?ayHm0dmevblX+hYZ6D+YfP22h8htR/00P5WaiUyjdNcj5jRkoy13b9SiEDHs?=
 =?us-ascii?Q?cO+kZdNy5Jpc/V2HZeNfAmdinuf+tVm4IoAhpafanj7S7nOLsqSilFazsV8E?=
 =?us-ascii?Q?gqIwZnAAbWEK7a5h625NdZ5XW/WE0GeQUSd5VhEGd/hbgFirZphEkq7aWH8n?=
 =?us-ascii?Q?2SZYftFBOXKe+2ZxhTzm4Up7szggD3jooePxJvzsov5fHGk6Exl7Ocz/xPMe?=
 =?us-ascii?Q?0NpCYBb5DPyAMYflS/JH+7fvtnyVFDaBt3nJ0YoMoCuccdIxoCy9xJkILCxm?=
 =?us-ascii?Q?RKtBdOqOsA7i4B8UJs+5UA88bGCNLbwBZgBdMH6d8bLNaqu/dW5YUjBiy0Hh?=
 =?us-ascii?Q?ciaAEWUD0NLjuowQr4FAr5WbbCx2a7eTQYOfquUdRNi1D157CP6EoUaTaoFB?=
 =?us-ascii?Q?OiRta3jIAsMkisi8cW5gL5YUcjbvm29K3jvxydbjdkLLtP8B0/RDtZK7oiHy?=
 =?us-ascii?Q?9V9aenlhOaLHoOWp+NuDxuZGdtrf8LEgAL7nXrQsHy9S44LjorK2Nr53lNDv?=
 =?us-ascii?Q?9KbycyVL8J2/7RTfKJt0Y1Qdopk2c91NjE1E6kZT22vptHk73sAqgowlrhvQ?=
 =?us-ascii?Q?KW02lWrHaHsrytREC44JOv83sGLv9TU06SDMRL2fQ+MBbGwlIEq74CD0aDHs?=
 =?us-ascii?Q?c1w1upLxHhEomIICAwBGCv87PrLuLz4Bc96G9mgGAHNVYUsaPLM/Wv1OAbvo?=
 =?us-ascii?Q?UlUsZXkD0D5TZTBa20YjxtL2np5F/zHLn/uOqK5O1Z8XvWrg4B9jWnCH+MMw?=
 =?us-ascii?Q?/17FJ3TK4CCIgTVZlMbOP7UdatlQphZDp0D7n4YuI68zhqPLS/5WdZhDe+u1?=
 =?us-ascii?Q?C5XI57Js50F6nlxmnYzrz+U14/8BznsSIN8uPDNsn1jYZA9LrbaznRGDTuGY?=
 =?us-ascii?Q?7rMqaxvSUQVlNcc8fNcPBxNwT/A87XPrgyCpfZmsYuDqzVWgpHBF45nhjBri?=
 =?us-ascii?Q?vTyo7p6/35t6roqtYdYkUZm8GxZDkMougq02Zr0FfBsuKG4bV9J/7A05K9W+?=
 =?us-ascii?Q?/+22DngOKvYV19WmFFR5Yo2MXStAqnS3bqy5HlWFvaZY7bD9aqaUi84ZL7BD?=
 =?us-ascii?Q?1GYW67wMEYel0kiwBlUW51MJ0y+I4J8dF0MxJI1ElsGN/7iSKhhqrAE5OMr/?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3U9P0vb/279LHNv8TM6GLUVjUpv9Y+EFwe0j4bNyoTBn9LoZ24RifN30knIAxiGT9bS82j2rAMQoe0ENOwZ93otJx2p8ILsSy23ikVTLYslKwcJtxEPZ9zHCRPmoy/BPtNswCrX9PZIsS7CC7SYrq8gz4vxv5zHWJglTdyRR3+lhcWYsukL1FUzj6CigKQBmU7Z3Om5wMTZXXAYCEhQ8HGXh99K7YPocCpY3Gielb/hpNo5xdXS0qPfrmHNCPWa3Y1LaE+G4INAo4RCgMnN1jtOtYsw6TQo+qUBxC697H80Nv2YRYKLLQ1rOS6iY0HDKYl6cVitnKSxBXXH13TiWuop+Gs/r6xkSUS0MiHKc/lU6CcwuqRenA+m6k7i4v2Em/xKuHKXuE+FkOqrTpoFeL4N46jcElHa5mGkhvVYr7hN4onkaUSh4du/4O6jvc+62Sezx50kWl0GDIpNMymgnlyGqb7QU7rpRQaa36w5XFQZskz407va6ilejjJ8YXi2YjhX0mLKJocEpKa+4qlf18HbgtJGgVIEp+qzphGFczXIkXuh3qA4xDRrFVXU5xpT57HEgoLeB9JzXLhYmRgBs7mVDmHC6CSRWF9/SPA6eKp79KeNjHolSq831AH2SUlWsbu+LgJoe7lXHlq/y01PEcAzxFn7WioxS31xQs0it9V9Z1EQjWbgaMl1/e0hQhm3ermhziWCldS+lPPFgSaXMrcxOxrMaNyfv2R8mN7vvVyq2HeQmBxCcvZn84sLoS21XEMVHs4weUcMHkpWzaBoc/0HaVA60I5B9GyrueLYWP63AJZ3J5+wqXXv5orB9k9JhuVu7sAqJqY7owBEQT95sZIP/62TWfcJCQ7IKx+vfuQSm99vLbp6vPMjPsKfy1hCcPaWXxKa5WRWxb+I0vcgz/w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5036e0a7-4f56-45fe-6efd-08dac430f729
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 22:06:21.1758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbDyTeGGLxRsO6BGI6Four0J2yrlWvYpT+aZGePRzj6QkPSvFCAj9E1dM2bFYURAWrRK/9eKBxihUMpeowfIZrI6OsCkWZq+U50xi2HvuCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4535
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_11,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211110149
X-Proofpoint-GUID: CVkloTK151cW8yO6y7JXXcHrtvwDu6A9
X-Proofpoint-ORIG-GUID: CVkloTK151cW8yO6y7JXXcHrtvwDu6A9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rather than iterating over the inode's i_dentry (requiring holding the
i_lock for the entire duration of the function), we know that there
should be only one item in the list. Use d_find_any_alias() and no
longer hold i_lock.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---

Notes:
    Changes in v4:
    - Bail out if d_find_any_alias() returns NULL
    - Rebase on Amir's patch
    Changes in v3:
    - Add newlines in block comment
    - d_find_any_alias() returns a reference, which I was leaking. Add
      a dput(alias) at the end.
    - Add Amir's R-b

 fs/notify/fsnotify.c | 46 ++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 2c50e9e50d35..409d479cbbc6 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -105,35 +105,35 @@ void fsnotify_sb_delete(struct super_block *sb)
  */
 void fsnotify_update_children_dentry_flags(struct inode *inode, bool watched)
 {
-	struct dentry *alias;
+	struct dentry *alias, *child;
 
 	if (!S_ISDIR(inode->i_mode))
 		return;
 
-	spin_lock(&inode->i_lock);
-	/* run all of the dentries associated with this inode.  Since this is a
-	 * directory, there damn well better only be one item on this list */
-	hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
-		struct dentry *child;
-
-		/* run all of the children of the original inode and fix their
-		 * d_flags to indicate parental interest (their parent is the
-		 * original inode) */
-		spin_lock(&alias->d_lock);
-		list_for_each_entry(child, &alias->d_subdirs, d_child) {
-			if (!child->d_inode)
-				continue;
+	/* Since this is a directory, there damn well better only be one child */
+	alias = d_find_any_alias(inode);
+	if (!alias)
+		return;
 
-			spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
-			if (watched)
-				child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
-			else
-				child->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
-			spin_unlock(&child->d_lock);
-		}
-		spin_unlock(&alias->d_lock);
+	/*
+	 * run all of the children of the original inode and fix their
+	 * d_flags to indicate parental interest (their parent is the
+	 * original inode)
+	 */
+	spin_lock(&alias->d_lock);
+	list_for_each_entry(child, &alias->d_subdirs, d_child) {
+		if (!child->d_inode)
+			continue;
+
+		spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
+		if (watched)
+			child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
+		else
+			child->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
+		spin_unlock(&child->d_lock);
 	}
-	spin_unlock(&inode->i_lock);
+	spin_unlock(&alias->d_lock);
+	dput(alias);
 }
 
 /*
-- 
2.34.1

