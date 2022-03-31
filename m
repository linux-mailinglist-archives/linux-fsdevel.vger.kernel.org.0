Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C094EE16D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 21:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239649AbiCaTLA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 15:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbiCaTK6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:10:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D8458E4A;
        Thu, 31 Mar 2022 12:09:10 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VHveZh030433;
        Thu, 31 Mar 2022 19:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=iJ3uM5gEluRjHsPe9OHFs7STiMYlBF91bzE84qqwwVE=;
 b=gOdiqLwlRZON+1IxYEydSG2i7U7kU01wbxAl2MtPxP2q0DQdjvNfhyZDktbbRRE93dRe
 I5t6nRdHyQEfK0pmqgZ506IFOp206lvfeZPD/M+B7rXRku3M8/h049qkvp++yWpiB0Jb
 Dyw7ZF98wWOTfZEwcdTw3zqZLj0Kv8LoG/uA3T1ViAcq+LS08cVVbTjyYhb/UlTAe85R
 LC7h+vN7XPFDRcetsQFBsHiU47f7131a0M9aXI7e6fD9DE7hZGvZdJXbX670Gr2GuIxO
 f5vPUcheKAYG/fBan6BspiJ5WTNwdGaRyPdBAFttflAHiWfqz+WuCJ20IZQJZSVioLps UA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1se0n8vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 19:08:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VJ1LrR002842;
        Thu, 31 Mar 2022 19:08:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s957eed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 19:08:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJF3jNa2M+FCOr0G+1TasVKM8vE1aF3g3y+Emn2tD94R5kRwV7saFRpznY5zpNcC2GRUUh0x+dkHaxnHzzh1kRayrI207q/9p3R/trpxAKxeENle5L+vPNgkJ/xgUmSxDzpmPTw9AbkUBgi4OP4zPoQ31z+0CiQ6GErKsk0WtMPqe5DEm9y9BilzEePsiy3K+SZQwHNlvAT50mvDlygM57iMytOhirre1uDCMbSEjhtiVknU0koAxjavRgYyOrjE6WCk+jCnItApVFtX/qvC1wJiGPf3tnhsU6UzKMT9/b8WVMf74Vbx3ulJik3IoAepL2sXu/bBJgdg+fggL4DStQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJ3uM5gEluRjHsPe9OHFs7STiMYlBF91bzE84qqwwVE=;
 b=kCNA9pJWISnHlJ34XNn69JWiFb/k21Srm2ssYbvxkNB4u6f8kfsMQ8ovTS2oz012CvHAieQk7lP5BWBd3WtiTZ6rD82KCInYiKmgrKosdy2lQB9j1YgaVILGKMizVcbaFbVKGSpU08AxHFOUYw2TnS+AgcMhWkC/mgGsX68gq7iVfohFqDRlWn+jQrl7sV63NDIcltlp6DpW9P/wIq/tfgdd2TdBKs/yEQJ5sn+iM34UTGZ6Z57CA9GZrP9BI7rKBb0y2txDLx0WA/92zoIpIqcmmYfAkrQE8pK8k6TmuYJmLb5YT8vqj1DvfW52QqAkyGhQYNaxeSo7Wk9kG+TBNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJ3uM5gEluRjHsPe9OHFs7STiMYlBF91bzE84qqwwVE=;
 b=z8WjN0ztux4mHe5F2eqiN35CiXikPlI/CKnSD/613++TrNcMOBT4ve1ZGwXpvVy4ZHDO3FlThSpGiUTBXYMl07KwOyvev5BuXsp7WXs+pEio3kB/4fivxAivgYGuRF9u2YqDYGjfZu6Gqe4u72AmQbd0GrKsU7wFEjmqNPg+43w=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by MN2PR10MB4304.namprd10.prod.outlook.com (2603:10b6:208:1d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 19:08:30 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::9ca1:a713:90c3:b5b3]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::9ca1:a713:90c3:b5b3%7]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 19:08:30 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Dave Chinner <david@fromorbit.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Colin Walters <walters@verbum.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] fs/dcache: Per directory amortized negative dentry pruning
Date:   Thu, 31 Mar 2022 12:08:25 -0700
Message-Id: <20220331190827.48241-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR17CA0053.namprd17.prod.outlook.com
 (2603:10b6:3:13f::15) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 881b83ec-1dc7-40b2-c01b-08da1349d7d0
X-MS-TrafficTypeDiagnostic: MN2PR10MB4304:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB430433CE3520AD3EFC3F606CDBE19@MN2PR10MB4304.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3qU7TuCYmfhr/JVK5N3Rkd9jWIQStK/qRL8qTscI0V90WC1RTuEGJZqX2TTnGai7Rjg2ESooC1YhNHhaauMRKBWUIDcoxZih6ocJgYzWm9SinqWp9eQOfpbQCuZE4BUxn6LQ5cAPDiBbjMy/iA+Svq/IXJT746ttfdjzQXuQk6ITA34ioLaF2lEYQfTGMIsYzQWwXMNpNc0eIY4na8NSpygD3k5U39oOKiPrrwchZKq2ARUuevqCkDpYWxgaEOCoePmtvgdhAE5teuq7MH8XQ2/F6f1dE8T7+lwPQw0+DrixwtZXisa5Ltdwd/2ey2kQCYiSJWwllzFpmVk3QX65ORX3ISXylIOUa2XmlYL+2kIL4xU8Ea9CvrdYnbOD8xcOTJ7B5s3TgpMxLEhqZVxt7TmMy3tqKyqvMPRmF0xcNly5h3B5bO9HolMUuBLJoFNG/Gy5gEEjqjaTXyfYvImbjQWf0wrW231jfKjmNSK9TvnNZ0egMhgBwYO928Hj31Ek39Wks3vANCQx8Ykk0U9Hsf9lQIGR6cUSELp7kNXp/EtUpkvpJS6nKDVjKIhJJ5KghFS4zFsxLRD+UEfN9N6kE+X6NPw3m/S/nYc1rIkZHrxvX+ucLiSRJniD4sctzOz5794uMtscB1GQaXA1QCUPXPxVzxRE8QEMzLVfbvCCCJz0ShyyaE8FKIje5zaXi/NJf5OSJxkPWoNY/xyAkDkKrsf5IWrDKETNn5rDAy4QgxAJGhIFXRRTKsbwARSvjgwVS8bm1m8oFk4dEETBFPxjmgdE79hhDwQQB+BWuKChctXHxN7aw/mQLpXdc2bXJuwWLz6KuciJ6IKkRwQGZuBwdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(1076003)(186003)(26005)(38350700002)(86362001)(38100700002)(316002)(8676002)(4326008)(2616005)(6486002)(966005)(36756003)(66476007)(508600001)(66946007)(66556008)(6916009)(54906003)(103116003)(6512007)(52116002)(6506007)(5660300002)(7416002)(8936002)(6666004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C4Tum5vyQAACOCR8uD3UXF5JkaBSbi2Z8aeyU21+REByPbeyDMc/xbDJDAgY?=
 =?us-ascii?Q?7bty6I/kW8Q9rN6Zigcgr6mMSMdyZFw5gGIsJjVvjoTG3aKPLD7SbL45MaQQ?=
 =?us-ascii?Q?RITpb2orF5qIP2E2LVzyAi1iAQx5OGOOvakGSEhb6JXAZfwcb2+4rBtRTlPq?=
 =?us-ascii?Q?jEFgyJKUiU5Jh/XwI2KepFa6rFCBjkWHvr53Wel2ROV2s0uK900lflCdLhnm?=
 =?us-ascii?Q?SlG5OHAl3rESgSwJkVswojNjRKpWwskygVXzrel4CkHei4GCo+3uTdnM6dgG?=
 =?us-ascii?Q?cUA9nwOUofLifTcaEVPX2XY/VSANZsVJmG6QtG/5P8GPk4ZQnlQE2866UZdH?=
 =?us-ascii?Q?FZy1gVIq7T3Wrvpg+HYN311Zb4O8AUHYdzehIleifjZbv5R1uIJuGhzaDc38?=
 =?us-ascii?Q?Sadn9et5vTaXJ5DEZmtEwVu/Lz6mdqoIw8NFfwuwG1/PrkSdQchIMyOeepjV?=
 =?us-ascii?Q?dz1GDVzhK/xObaF+Jhi54dDH/WXFG8XHvMbeUR7QaUyDObIljbF0Sf0n3WbW?=
 =?us-ascii?Q?ZAuTr9e4Vp21YaPBzCfop+mnT5uo4gUhEhKUe2Ez5iDc7+dmLF6MoK0i0rI6?=
 =?us-ascii?Q?ofHBgpg/h6UBTQJtNuFb+PO+3vHQvZbkZSm/rnV6bzXvt5jIW7wdirjxtXDd?=
 =?us-ascii?Q?rpUvRIJocvk8jVBJWpxn8Km7TiyzBmUG2u99sqPj5N0ds3T1i59a7mLB3CfI?=
 =?us-ascii?Q?figes1V0YRY//+3YY575bMI5+BSFEAIfWxs0L30xuFXw3PteFehhzWbzKizJ?=
 =?us-ascii?Q?MrXXj5Wo5ui1pOdmeFebr15VSZyQ5WvZ7bjaEfiIJYabDF9bGAPPlUlomsUf?=
 =?us-ascii?Q?W7CtV/wvvFxMrV+eCUv9frD4B5XuWLLLstbsZR6L0G8G+zNcwQQwsG3cZXeZ?=
 =?us-ascii?Q?piN/gDUhaCGY6H8WG59EFu8Mj3DECWMhvi5sIROHaRNnn33ovxeWozfCggxu?=
 =?us-ascii?Q?bIzIcQis8/mKOxb4DY+ao9KMewB3premKnfVO9DBx30TlXkcsQquXqFoJeYF?=
 =?us-ascii?Q?u7yEg/cv8lbjYXgoaAL2bSuFg7TFfVZexAmc8d7alLhjGtS9abAcq75WCcDF?=
 =?us-ascii?Q?loYJrb1XgQ+gM63gxB3PZt+sUnItf+xYU6GnV0HTO2rjUFtkW0C0/QsQv31p?=
 =?us-ascii?Q?j4PqbC2yXkFNwlzD+YudlatwsvMtdGh9PAkxJhl+MVAGHFZ+Jp70vRUBFSYA?=
 =?us-ascii?Q?R4Y8R6JA3P6rSEeU2NsfmXI193BQEcONqd5qyKfZ8EIhaIKNZMCf7MD2ZGXe?=
 =?us-ascii?Q?ErjrFSV0zPFXsnJ6walus82zEKR35pHmID3Pg9m81zFO+apPxUJ/VIWDTlht?=
 =?us-ascii?Q?Tca6mrteroVrsrFEXHziFkDfOwse19uVvZjTzsJl7X2vpdMU/IilK0w2UgCF?=
 =?us-ascii?Q?WaOFba17dBrqO4N1hpZevy7vuuN1W2zbHevKUREVK1OghRKI2pQML6HF7GMa?=
 =?us-ascii?Q?WZ+vFzKHPlZTeYpx4NDYpS86Ls6lQ853Lr12fA6LxwSlFgcIe+2IqhIRrjpW?=
 =?us-ascii?Q?kzEvYCG3Hm7Oa8yUCsko6oi2qBsM7cfn74TWD/BKLfLt0FqgLtfLO2xCIWWm?=
 =?us-ascii?Q?47L8DnqtAVmUSvSUamFEVJWwSvaPT0q3f8enzR40arwy/TaZFs8bS1sJyp9X?=
 =?us-ascii?Q?Ksq9EoreLWbrViKNR1QKsFw5S3dXjx2XTT2GUv6hLSB598rOb07F5JQqlWWE?=
 =?us-ascii?Q?PJ2+eJRhlnAI8oObo/1Uf53MYKyIeQnY19LIK7heAlQ6KFKBX3kf+lWzxZvh?=
 =?us-ascii?Q?ACk/C0K5jaSFA3ggtMrZS4vZruIjqOc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881b83ec-1dc7-40b2-c01b-08da1349d7d0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 19:08:30.3793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: So/xopbSPPK/Be2mfINoCNNODxfs58d38jXHSFsuJDx9cZYlc2lI3yugdbMyiTt1c0iGU/kzNdC59Wv1yO9NS6cLyOB1j94ShYIrOXVVPOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4304
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_06:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310101
X-Proofpoint-ORIG-GUID: 090iWcae87MMaNnMQI-eFKdH_1QGovm1
X-Proofpoint-GUID: 090iWcae87MMaNnMQI-eFKdH_1QGovm1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al et al.

I wanted to share this idea for a way to approach reducing negative dentry
bloat. I think it's got some flaws that still need to be worked out, but I like
this approach more than the previous ones we've seen.

Previous attempts to reduce the bloat have looked at dentries from the hash
bucket perspective, and from the per-sb LRU perspective. This series looks at
them from the directory perspective. It's hard to look at a hash bucket or LRU
list and design a heuristic for an acceptable amount of negative dentries: it
won't scale from small to large systems well. But setting up heuristics on a
per-directory basis will scale better, and it's easier to reason about.

This patch creates a heuristic sysctl, fs.negative-dentry-ratio, which defines
the acceptable ratio of negative to positive dentries in a directory, and
defaults it to 5 negative dentries per positive. Of course, right now we don't
track the number of children of a dentry (let alone whether they are negative or
positive) so applying a heuristic is difficult. We also don't maintain a
per-directory LRU list, so identifying candidates to prune is difficult as well.

The approach I took is inspired by the way cursors iterate slowly through a
directory. Dentries maintain a cursor that points into their d_subdirs list, and
as dentries are created or become negative, we scan a few dentries of the parent
directory, killing a negative dentry if we see too many. The hope is that this
is more fair: there will be a performance cost, but now tasks which create more
dentries are tasked with the scanning, rather than some workqueue or an
unrelated task calling dput(). And, since the amount of scanning is tied to the
creation of dentries, it scales easily as workloads start creating ridiculous
amount of negative dentries.

Some other advantages are:

(1) By relying on the siblings list (not the LRU) we avoid nasty contention
    issues on the LRU lists. The parent dentry lock was already going to be
    taken during d_alloc, so there's nothing new here.
(2) By keeping pruning on a per-directory basis, we're not forced to evict
    potentially useful dentries elsewhere. For instance, if /tmp/foo has a
    workload producing lots of negative dentries, it won't start evicting useful
    cached negative dentries in /usr/bin.

It's not perfect. I have a few gripes with this approach that I want to improve:

(1) The pruning behavior is based on the ordering of dentries in the d_subdirs
    list. If you have 100 positive dentries all adjacent to each other, the
    pruner will see them, but only allow 5 negative dentries to come after them
    before it starts pruning. On the other hand, the pruner would not prune a
    list of dentries containing 500 negative dentries and 100 positive dentries,
    assuming that they are evenly shuffled together. This workload-dependence is
    bad, full stop. I hope to improve this.
(2) The ratio approach is a bit aggressive for small directories. For the
    default case, only 5 negative dentries are allowed. There could be a default
    lower-bound to allow small directories a more reasonable number.  But this
    would require knowing the number of children ahead of time.
(3) The cursor approach fails to do much in the way of a prioritizing older /
    less used dentries.

I based the series on current master, and did some light testing with parallel
fstat() workloads to see how much I could bloat up a directory (major
reduction of dentry cache size even in the worst case scenario). I've also got a
simulation script which can create different workloads and simulate a
directory's negative/positive dentry count over time.

See also this LSF/MM discussion[1] regarding negative dentry handling, which
motivated me to think a bit more about approaches. Also this[2] past series
tries to tame negative dentry bloat by reordering the d_subdirs list, which is
what got me thinking about the cursor-based approach. I think some improved
version of this RFC, if accepted, would eliminate any need for [2].

[1]: https://lore.kernel.org/linux-fsdevel/YjDvRPuxPN0GsxLB@casper.infradead.org/
[2]: https://lore.kernel.org/linux-fsdevel/20220209231406.187668-1-stephen.s.brennan@oracle.com/

Stephen Brennan (2):
  fs/dcache: make cond_resched in __dentry_kill optional
  fs/dcache: Add negative-dentry-ratio config

 fs/dcache.c            | 108 ++++++++++++++++++++++++++++++++++++++---
 include/linux/dcache.h |   1 +
 2 files changed, 101 insertions(+), 8 deletions(-)

-- 
2.30.2

