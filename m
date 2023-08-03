Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A28576E9C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 15:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbjHCNO0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 09:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbjHCNNz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:13:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4103C23;
        Thu,  3 Aug 2023 06:12:35 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373Cg0Hx000838;
        Thu, 3 Aug 2023 13:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=1h1EcmLsSlOihGaUgmvVMGwKF3GuVy3RoyaLEmGflxc=;
 b=OyBl/GausnA/thmwqZ43Bbe4w2OvkOAYReMmM5LiV2dGtUe1lssV8oVW9dwoX5HHpI8n
 O4i+Cd0py7OxvgxkuKQUMyovirXJJOoobsTLLSUvdi1sXE73zORyDzRS5g0GQZMdTRrr
 AC8MUoC2dp1XXMcm6bEjz+pAK18r900qBC6rITg2mofFPNQjChSIu2UurmUAui73mIuA
 sKXMzhZOuE4nYDeU6AVUonwmVOqPw6nwpNn/NnaAoq3xWFkD6JYEJ3FVCg+mvJ6hXABR
 ugdlw9DQJG7uy+7H2QHdCgxBnU1bMTaamokWLlPavxCFG6LjDYOJDznQdgFNgUlBpITn Jg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4spc9krm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Aug 2023 13:11:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 373C0lPg006605;
        Thu, 3 Aug 2023 13:11:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7fv3um-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Aug 2023 13:11:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaWrWRu8z/TiJRZdbSkZOLv112cTifH4LwbUD4tCMI9eARyNC9B89GAxP/vAV8OMS9EOehJS5W+okj20TMbxnJNqI/c62c1O9Q/nU2c8dtKpNiWgn2Pfgvusdn/HD3JACvUTVm9zVL/JSuAyFJjm69HCiZvl/mLoWhNqK3oRWxVL4A3NESsZIp9iEDxo7qmVYcjnmVtFjBoVRlsZ8mglPiUPqrHZKSxW5J5bKIPtprvoVZbJmhGM7orMWbJnRj2HcMpFdOTuUCqRwe1r1ZQe1U9+RqzllgbSsAVbI4un8jWkERECG6+fy8tukr+FZhOa3xVk9z0gmeiDlWVCA5+XtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1h1EcmLsSlOihGaUgmvVMGwKF3GuVy3RoyaLEmGflxc=;
 b=Tz9sx44Qrs/ufWD7j8Hx4kEAcTvHJ4RAEUDkBBhThG+DFJ/xcKZddoAMwHV06soA0VeyiXmHCvLuNs46Qt4Grm/4+O+hkNnmEAPWssZ4MK0E97lSUU2jPtPuhpbudmTEAemTjDsbSFqhsX+jQnhZZL6Dm4UqqovB1Rez0eSRJwsJznk9IA5ITrf/qO42msk1qPWTzoQ9bdFHkUFlbQhIxtwZlghXgmIjkU566cgJNtnZAZtyP36X5RPZTPyv17RayZkbR5EKNe2zI+tyG9Z7gg/TsVxiTYtD42hEvDnKmRf6z+5aP0njKDUOKz/RA99QsBqFbELjVLU6r0kyMfzzAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1h1EcmLsSlOihGaUgmvVMGwKF3GuVy3RoyaLEmGflxc=;
 b=rN9HlC4rJ9K4ypdAhLP1QyBmcvcZn+d2lNi9r/2x0pZEI952Gj3mXjKUOaBg89tWt77MwoTTX5qFgkKeNfMdGyjYlCV2h60S+3uUqg8DTnp7H8zBDf56l9GyO3RzK2oR8A4kkR6qW/e3v+wcstH1ACLJ7/SD+6jKVeVTfpi7zqM=
Received: from SA1PR10MB5867.namprd10.prod.outlook.com (2603:10b6:806:233::19)
 by DM4PR10MB6085.namprd10.prod.outlook.com (2603:10b6:8:bd::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.47; Thu, 3 Aug 2023 13:11:35 +0000
Received: from SA1PR10MB5867.namprd10.prod.outlook.com
 ([fe80::707c:5a02:87a1:38e0]) by SA1PR10MB5867.namprd10.prod.outlook.com
 ([fe80::707c:5a02:87a1:38e0%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 13:11:35 +0000
References: <169091989589.112530.11294854598557805230.stgit@frogsfrogsfrogs>
 <169091991331.112530.11320923699439751703.stgit@frogsfrogsfrogs>
User-agent: mu4e 1.8.10; emacs 27.1
From:   Chandan Babu R <chandan.babu@oracle.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, cem@kernel.org, sandeen@sandeen.net,
        amir73il@gmail.com, leah.rumancik@gmail.com, zlang@kernel.org,
        fstests@vger.kernel.org, willy@infradead.org,
        shirley.ma@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 3/3] MAINTAINERS: add Chandan Babu as XFS release manager
Date:   Thu, 03 Aug 2023 18:37:36 +0530
In-reply-to: <169091991331.112530.11320923699439751703.stgit@frogsfrogsfrogs>
Message-ID: <87edkkclts.fsf@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To SA1PR10MB5867.namprd10.prod.outlook.com
 (2603:10b6:806:233::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5867:EE_|DM4PR10MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dd991f9-46d1-4926-86c8-08db94232997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Taux1zpKLe1V3Y1SlbpTvpW4jkvTkwckuH7W+F5C4SbMMwo/jy592Ll07ilnG3MyvEU755Tr7z9UWyBQW1MqbTz42aKROHxeVLMxFoQ+iJAUgWj0QyKTXVx4hDWZdnQSNtE568r/VVWh1nkZaMYqlEPNYF/arU3fvfDwxysV84hNwAq0wWzOg9QfI6WxI3MziPmAOx3DzjzsY/HqO5CyFrCtek210reGzQye+rqiLqtSGdGcoeAYlM5NBV3JElw+Yow3yccKrgZHFtVlKlfAj17J2xQ1Rsbj8AZdn+Bv7N+mBjuDKf4PdkvKqvgYLgHXMNC0Uu6cNQAH5CSP/ApDFRF8gir6Tr8jjutQLPgfHxQ55mLC/Ev/tBQIz6cUE+0zE02NG9WXzu/ruWPKZUl5lNzPgTzY5BNJZQRKaJKsb2q3lJ2zXpfeJ+VLm9JSzOmU/cCQm5b8ZQfVaB3rcIbIG4LrPqx138kC8DMHpBzmaZiGjtNMHD3bSr9AjsZz0gPm1RyzPH2+O/rKCFBtcEFFB+Za/QuxpFNvUw8DkZG4jqFEUBFEz0xvqV0F45sF/ZQo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5867.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199021)(107886003)(53546011)(6506007)(26005)(186003)(41300700001)(4744005)(2906002)(66946007)(4326008)(66476007)(66556008)(5660300002)(6916009)(316002)(7416002)(8676002)(8936002)(6486002)(6512007)(9686003)(478600001)(38100700002)(33716001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r/XTpGDd0zUhrzPBsb7yWzs4dRwEGLnuH55/wOlo3R7KBW8R1+4KteLJSFUe?=
 =?us-ascii?Q?U0KnneprdGA9hqynMAzgfXnJCtDq+efluPe5aD9JN+2VJm8ox/hM5lTyh6Ft?=
 =?us-ascii?Q?b5uLBLjWOo9dvxAXmg0s9kxuwKpvpCmoHNQplIWxxS4ifDNv+dSZEAiePfda?=
 =?us-ascii?Q?CPZdYjOflM7KVmvA6teUi1QE6c/L0EQZh8zcip4ApyRIBx8d+siVkFLwvruo?=
 =?us-ascii?Q?8yVof4FdqiwHLtKAMuxL+7EX/2Uazl9BcScbXfjXdj05isZwt9O6Jb6uxw1Y?=
 =?us-ascii?Q?98fMW5VmOAa5gS1QHjQhh09mjbGDqWJU+fYT3siCyM+w3AJ0XTgzET51Cej6?=
 =?us-ascii?Q?DxpcO9pML/UABVmwSPKJ7QNBD8OG+0z9XqVhhq7LyHWCivCfzUKRS1kMgiIQ?=
 =?us-ascii?Q?8+FFFWztd4bMMEtGUc0tat8w7R20QpL9rY5RJkU6bojVzbC961m7rIc0lHEg?=
 =?us-ascii?Q?PhZ77q3YNSvCKZB8cHo8xUFWDDNqTLoNi8bsDIpOndU7WZ/KwzgZkZsGRxhO?=
 =?us-ascii?Q?O0xPadJKYkgfuCENwgQgop4+3ggb+x59sEUndo5GvFboENzdhqzvtrGE5q0u?=
 =?us-ascii?Q?kTD4aedeZodFYUVDjxqTkjADom7XxtogqgQCg6/w+La0+pNpyC4Z3X168ueU?=
 =?us-ascii?Q?mDGy9dFdTf0PG29aX0R0o1XuTIccUhfOCHn1aN2x/BfT24fzDijtdOoTHf7H?=
 =?us-ascii?Q?GJUYNAwwsJ7pGFDZu5ZEIB7j4JI4ivc7qSzitBtxAmhn/cA2QirbWIdQUK2J?=
 =?us-ascii?Q?+2lO8UwJU42ITd0CBZgrMQXVUR8B/4Q128HEWgA5P1Ev5qhpptyxnW9YZSR0?=
 =?us-ascii?Q?XVDDwW1SgRpySbO1H1XjEA4tL7526AHjTcu6+sML5eJHKOmc7ZYUHKZBjKsO?=
 =?us-ascii?Q?vgFHcPxZeqpudA3cjKIcnf27Olcva5bddFSa5nXCLxUEnxu8ZVdIanPp3MSa?=
 =?us-ascii?Q?RT1TzXtzJeg4mQhnLHEkIREWc5/FiMhP6s/uUI34WXcGKONLj2D+cRPaeWYW?=
 =?us-ascii?Q?TSrYkRq9o+loy55Ooa6NVZi36R4GSkXyZIaViJ6mStukLHwfRTav1Z4pdrRi?=
 =?us-ascii?Q?G2EtCKF7GMDlK/8dw6JmqrPbiHwLDQjE5m9oTTvWT04i3TuCgz9pFalfJSy6?=
 =?us-ascii?Q?VccGdFhlpX+pM2gOJmIVnP6yoqLCAnZIZHdHD6cPNl1fK+kj3PBJDt/rbCLY?=
 =?us-ascii?Q?GtIqeQ1eEo1pN27NB7rJSo8S2TirE5HRzBWMCdrwQgAsWFPdBa5EiHuMsVR+?=
 =?us-ascii?Q?sQpqDPaYQf3R277+vaECszjypJaD4sT4vaLLmDgrHVFbbAEs5mHsRPOOilpY?=
 =?us-ascii?Q?bVaiuO8AqQBf+wFC+/PLJr1jzRAPldrYpiXWvqpgkb5P+lsrDZ2pNI8LFyBg?=
 =?us-ascii?Q?EqJ5c7ENhyG8fOjbPmaOvIQFjmxKHQxtYy5Tv3ohm2G+ADF4579uJGnsmliq?=
 =?us-ascii?Q?h5WvViYlCKD5QoT6SrDnAn8YP/sTEOMUbGu2BVFLagIvJ5lIsOomyt15kxGM?=
 =?us-ascii?Q?Fx6QVVnY6Dm93Zc/4T9R4Ae7ekcuav+vVLYVgEOR1qgJ6plWO1XuH687Xybk?=
 =?us-ascii?Q?MhWRfyltxugQ0VINQJjFkGUR/rZ5Ho1UOiyztlZp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6M5lIY6XXcFf3/spiPI3tGZvT/M32gRmmHxH55PLgMHvc76BGz1fXf78QNf79KguWTqKxm7s2ZpTGRvrHLCnqo9flVfa5JMQwADxx2Thqb/AeQcBQ66VgkEIJH9WRW4kmFANGU3DO9G55aiEx5RoPtDmOfU2HUFdrwM4OPWlNij9OSBz2XXh+McyNgtvGgNfD5+aw+t+1PPzhTl6pS6sZwl1GwmLUtPKQ1eB3QhYKPfL7tk+SsphDN7PoUWjg9fFRV6jPQZJ570Jvv5Qr5MeAabniBWBZguVAARhd8dansL2gI1paKRQZx16D/FFv6eau28AzQFTGj6CUd2atndYGq6a7MVe7mpQ2DnKVR12lsfGvd4hR7ttexfTHQsh7VUYEHLaumnp6S/nCIOMqPfkoJaq9OwnJCVWwgEjEtTZgRGAopLeW49dZfDxIGvyj4mfB0IU3JMq2znRuR32HMKk9iB8SW7HuacfKHTkyu7r8pjJx1gWTIPwMqX4L/SjHmPErOjxWQKlNzoRwT/L3O2ln10SH9Mc3OF35jeVcVrjFBWNKwB3B4ltVnI4C5H9oT6p+Oh8UuLXDj14r1pI4c5RCheCCwcpekcywO2I95DYX21JFc82tEJUC0S1RKS1lz3Rn6W3xLAySstuZx0OVTiaRXvTxWz4hsfCQFH25x2IeolWZSe1Yt/kifNyiEHWgcMq+JnERMZtWvGz1b+fJSMDntS8RxDqcEh623v5j5HpWusaDfhq/nOeEkHkDAlSCDlXwrYBk5eILX5DUe9cTbvgc3o8MjCiZ11TJdojpD7YEt2KxHc3RIfn1lpITxeU7+D0GZoywxRlojigAig1i8wqTLSLmKZQKyA4pY3NbXkJMtixRh0PhIvtQ0rLMOqK9auElXZByjQbJT2ORiT2NtxdOg/TBqLoxolipI/at2nHw3I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd991f9-46d1-4926-86c8-08db94232997
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5867.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 13:11:34.8690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iq+uMpFOKBqz/+tXVNsutHkZbor0l7x48jIWi4erZO0F82ZhimYLFfueyPgGQM8/XIMc/VLEBbFZKsxixUK87A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6085
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_12,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308030119
X-Proofpoint-ORIG-GUID: sRpUQKBvmteOf6pjgWHPfQlktNg13ThZ
X-Proofpoint-GUID: sRpUQKBvmteOf6pjgWHPfQlktNg13ThZ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 12:58:33 PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
>
> I nominate Chandan Babu to take over release management for the upstream
> kernel's XFS code.  He has had sufficient experience merging backports
> to the 5.4 LTS tree, testing them, and sending them on to the LTS leads.
>
> NOTE: I am /not/ nominating Chandan to take on any of the other roles I
> have just dropped.  Bug triager, testing lead, and community manager are
> open positions that need to be filled.  There's also maintainer for
> supported LTS releases (4.14, 4.19, 5.10...).
>
> Cc: Chandan Babu R <chandan.babu@oracle.com>
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>

Thanks for providing me with this opportunity,

Acked-by: Chandan Babu R <chandan.babu@oracle.com>

-- 
chandan
