Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CD5788DBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 19:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237733AbjHYRVt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 13:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235899AbjHYRVk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 13:21:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BD4211B;
        Fri, 25 Aug 2023 10:21:37 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PGKOZI021135;
        Fri, 25 Aug 2023 17:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=jYcCJpzTnNbPAmPTHyUYkEHcpVlJRGE4FKapXMxpyYQ=;
 b=NcuflP75kM8WSrR7RkJgP64uqFg2+puTFUC7PiVuJOZ/Yu4am1Fxg5hHEWAMoCL0Z2IR
 MItQ/jqPuLxK5Kjx/1kwI5TZUSiJ5VZ12WnTr7oTnceoUhIuuwxztR3/hHYQgDHBJiCv
 KzCccNDynbIfLpoabnHyzDZARmRwpRPSnf0js/WOFFMpUcd3VL9RwXcU3Tt42SqcYRWY
 t7iD345rD9CASltb22H6IM0dH6IAPMUQpLM6YQld97GNctvDkuguS70RiZtbftkx5KzW
 Vn0mY5y9ds1LEYw8evTnpBP1oDrpNEPS6DBYLAb9FGCmCgUCyisws4OzWHu1arJ6l/PY 9w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yvxtd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 17:21:19 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PGttnX036056;
        Fri, 25 Aug 2023 17:21:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yxm4ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 17:21:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuNTk2u0pJuaduw7l4SQojj/fHDrvcfd5GbABKmS8mLWS3iFjHQEYFGtx6DXUgT8oMp3hAodS6JdIHLWh2SgvDQVhV5sPpg3T+W9X/lYF7IEjROdz/LtNduIF3YwOs7lnHK1t66FHiMIBB9vtmHbUTDwfaC8xPp6aEYMSiE3MVpblFsEDRvpTDFFMWEuONqHaBCbILLMatxXp47PjtikQuiiVpEmp8NjogihH4136nSKFE7cThVFOGKov13lUmPLMbLDrX/kNqog4bSQJip5zLYhU9yNrft3bSpQZsQQKawPuSBr1aW4uxwx/AczrJHLSgSFz5dop1xkZaOSZr8xvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYcCJpzTnNbPAmPTHyUYkEHcpVlJRGE4FKapXMxpyYQ=;
 b=b2u7+7v+JElfdoH6XQB+SSWq3N43ZAOGUO8fIaws45QH3fAZkhGtpGk0Q8MPsCU83+zMww5OnIy9s4u1eQeFq3uv6Kpis/nm2zWvriZF100mX1X2gK7Qbal8o6oq+TMwPgbNFJOQDsFqLMMOagIVuc1NP2oEYGLFUquTHn06s9ivz2cH1m2tRGhe9Tn3DUX7vwAmnbdFD7rBa7RumvVCsMyM25wAtTMcqn2Al0ubmRG5FjFpmoSxtTrYM/10r79b8sr/HfGoqFR/dyhD9mLKxPK/qP20wuYtF64KvVSIAdFK5RulcvNq3L4SURLnZ+ADRLZWANfGayKSU2jjN1kO+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYcCJpzTnNbPAmPTHyUYkEHcpVlJRGE4FKapXMxpyYQ=;
 b=0HCp/VbtAEzLnE4Yuujwt5e/CL1mI/wrlKCqibaehx3mxKH+Far9pt4up1vI6svRnziW+YgC0Alf2UcOvGEc0XlxZ3IPE0qNZv7auEuqdKw7MfcQUR4eQATLQdEc6qBYBa8fgPv2MiEj6XGL0P9XKwhw+YOLE7HrjjhijuaCixs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7054.namprd10.prod.outlook.com (2603:10b6:510:276::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 17:21:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 17:21:15 +0000
Date:   Fri, 25 Aug 2023 13:21:11 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
        ocfs2-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        teigland@redhat.com, rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        jlayton@kernel.org
Subject: Re: [PATCH 1/7] lockd: introduce safe async lock op
Message-ID: <ZOjjB0XeUraoSJru@tissot.1015granger.net>
References: <20230823213352.1971009-1-aahringo@redhat.com>
 <20230823213352.1971009-2-aahringo@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823213352.1971009-2-aahringo@redhat.com>
X-ClientProxiedBy: CH0PR03CA0413.namprd03.prod.outlook.com
 (2603:10b6:610:11b::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB7054:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d56652b-5681-4cfe-479f-08dba58faf9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: azO/o52Be7H/QFALkF48SaZat3Dp2cc0ryYXSb3CuHozEZAv8VNZzoGwC6ozq4xcOQXyy7F/fMQmX8oZ3QxpB0YAQZ6R3l94PtmG2zAdaKmOeEGMzRwgf/XCukAzL0TQlQ9aES9d7goL9ybVAzNDJyIdzWTSUSUomX69Qfd6Jhs5oWTdex+pstqImXm/wNwcavOb7QY7jguL07KvweGsqTA7WfIS+X9BneVHvLcL0r1JWt3S/f8j6BuZ1gkA6CN+bqgh8oj7vtRrotlVe75MKW9qhdLxl5/GBNZTocXnwVKoO/a1bw6oJoED9sIJx4djJQXbjkZCd+VT1WCtBvTeCdudzW3g17gbgiR7NP6Ry2xTbL9pFnd+TrKVt+O6NYlG5ppA229WOFl5jJOXCCdCkrW7AMqxsJGH+6M4z1naXXBPAX8T8rXvbImRVG7eKKuM3m26pPNU/QH3mrlVXmpYuE351Jt4UDJh2qO+H1WqFkiDq7qyQCFDa6O44OdMweWDgGHZuGZIXvYx5WZlDwYSM0TW6an7QMN4wK79K/Rd3DpTjW3TJKQsbBTY1kLSJVsq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199024)(1800799009)(186009)(38100700002)(8676002)(4326008)(8936002)(6506007)(41300700001)(66476007)(6486002)(6666004)(316002)(66946007)(6916009)(86362001)(66556008)(6512007)(9686003)(478600001)(26005)(44832011)(83380400001)(7416002)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QX4WyId6B6d9Ft1x8K4BW6UjlD/ZhlQp2GMLi4EV+pyy8HNVSpwjtJpadYpg?=
 =?us-ascii?Q?9wgswEgXLWbWA7gUV6hhJ6JjjFgdbEELmHJ2xjYPnZ8zAYF+BuO8FpKTWimM?=
 =?us-ascii?Q?z8350/d8P4VfURcWfNx/CiYin35eeXw86tFHR6wr8IrI+mItiQr8kCRHso4E?=
 =?us-ascii?Q?CxcXruj4IsCSgprLzQvLxsvq4tNd1PUlzrJdXI6iCCWa8EBhCdnQO0Xwwhfr?=
 =?us-ascii?Q?t5cI794jz/QBBRH7DdLEkkCKKLtnXNBvP/OBT3mTUvfBUgryEk6NsIbpFT9F?=
 =?us-ascii?Q?kON1tbJffRONHnYbk0IFWfQeNFfEJGtmT3I4+GNqod0Zm1jbe9iu0M7jzUK8?=
 =?us-ascii?Q?M2agY3jey0lGV7sznG8j27IY4gVZikRRblvVIZLQulF/dqLpUMxJX6W46iAo?=
 =?us-ascii?Q?gIba0L5zLijI3P7iMOlFkOwCp2bsgIjBLrfpoojr56moIWRhUuG92oCDBbOg?=
 =?us-ascii?Q?bymh2wIhOgdsDDryrZApImz8+3iXvPzjpLqdnhtWtydcV43GzG0C6wp7usAw?=
 =?us-ascii?Q?Uftala/gUc/ud3RaRLfceZ4I/mKPJWVdSvoPycDHhpgmxcfkODd8dievUE+r?=
 =?us-ascii?Q?QPbaS9oBtbIv+n4S8OBLeikrITkzzg6EGWDW+jOhlHBEzrPV072SeE3MqWG1?=
 =?us-ascii?Q?SNm4k9UPPbqsBqlpjiN98FETlbKxpt+SS6IgVosYCE58XrNIDDcgda7FFfby?=
 =?us-ascii?Q?Xe3cfLIbqY2rufGWStbMquxfDV/c3E+wzllbC03MsM1sdZwjKuHGF7hAVTSU?=
 =?us-ascii?Q?PNWQc1iQUYDxbF2i2VGjL6TfoOhLC+TkUDMr6cx0tIY9XOLIUSwng1ypn+DK?=
 =?us-ascii?Q?wy2Skosd1iZvf2nt3wZV9Hdq9j8g2OokzcVMEDsCNzZ6HQjiuRJXToAccJmX?=
 =?us-ascii?Q?tGkR41zRor9cdiPqsDonsxN3jbMCyY0hOfUYSs1G4LqNGdXZEPaNxIEnaK66?=
 =?us-ascii?Q?3szZgSwDfPvHprStw1FwCnqkqQPimTUWFosReJih9pP9ubkJk2kKaRhcOEiB?=
 =?us-ascii?Q?w0ujGWQZ9M+D05QeAH4viiFpRAzTwwY6NhhprKfIKJUhEvMxRV6ofSHknOif?=
 =?us-ascii?Q?Jy4S/OOYUnho0a8waLv7hlQcvOsCce71LtzZ84rsCKRlwRQD6DO+OF4mqJj0?=
 =?us-ascii?Q?Pcdd7sleL5vORapS6qfO6tpsD7SU5B/S6hkAFDpON7t6Vue/OMQRctAB+C/c?=
 =?us-ascii?Q?OA+KB+QNp+YLj53PARQUiuwEqr+W5sxeTJOZ4GecLWKHPf+WG8sqRems6VOg?=
 =?us-ascii?Q?pZkhxl7qL3KV0lNFFOKMTPKFY1bMBY9vo3WIZciOnMNnDWASvD6TLKDHBXn9?=
 =?us-ascii?Q?+m1D4YaUWXXgdtH1yIM0q0AhRL7+P2ZqG6eyFMxjCmGJclrSQ4UQIkx//xkf?=
 =?us-ascii?Q?U5wVjGTUeYE+Zqd3ceGgwq1Rz3Ps9f1FW5894w889bj7FjEQhEAOOJkdoymT?=
 =?us-ascii?Q?1kSohxOB1L4gJ3CB/jeFLO6MWSylUB5xHZrqd4qKXSGU7hukbUoYxS0Nmza4?=
 =?us-ascii?Q?OhaK64u4Tu+ZQzag7b88FDzy8gKoy05Zll5Xm6oYU2rtJehkh5uvLdJlnpBX?=
 =?us-ascii?Q?DY6IACEt0xQRCeNK3uu+DVIRvhr/Fc01uvdBkLVEDa4SZ5VedJgmgavc/Qyk?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2wsgriSFKz77J4d6xW521Rsb7Wj3GiDoExmAHDe9SHPcm5NPCgh6PR2oE0wRBMbZcC81amXFhjEl8Os8T2T1n2TE4NQB9DRjJ+5yzxnLjOlpbaF4A2izn9vOX8t2W/JucAGBDmjh8RiGrJzAlmIUXsRRDjBmH/DRhEnXU86rOFibmMy40OlGRY2Lk5EUVI101mU79tIZKEGrmEEj/pkxzzbsg4baJ7nAl+pITFRn8BfmF2yIqJlfDNCyp5QL8sG9qlQ8HfDLPAtH0XFu7SA9fx+dV25iOk6f8LG72Mrv7LGJDzbyA2igYOjfRWxMbz4noh447EO4uUEhunFRuORuqUNlPdN4B9DEnWm0gJgq4Q43zgnRKzsdZqmHaVNJrLAYu1fUYNo+ylYy34nRd7KPnFgi5VC6UTU5N2cDGdD2wBfVrmSu32jjehQ2dDsKkKkIQqT/l499yD9CE7hjJw7LBJO4lUMZnBsKvLFjdGSEH7Ba/GiJ2xuKXgRjNi12ouVkRRxmKtdWhAbIaoGyfxNK6VvsbPEMYuQYxMLyPhV+LVzuKQ8WCQssT1r464n3FqH9sebIVuR1ZOXx64X48HpGMaMkinMGOGwxnc8wG4ZcvM+mOGZekw+M9Ef7taVxPDk3vVIGTdQkYS2pLcPaDpi6Fp0gLpdtmaJDSqEh6wCyQv83Mg+hnIKAQY7lYYplqgj5PmfvoLfw4SfoE6AsYL8zVWcEz2FcQaPm84aobqUWIYSuguVb/JoyDoCtCI5Yz6gXCMLx26dO4FRk7XT94Z+c9guAUD3AbWp5FLZnjQawJyNdf3F9lmZCX+cY+IjpjgX2GY/9ltx3YzYFApIAab8jouznUYP+urken3/sIXfvJn52nAuRRxGOnlG+C8WTsCBSFjAgL/TfgS0oSgNwlcP1nA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d56652b-5681-4cfe-479f-08dba58faf9d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 17:21:15.0565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TR918Iap08J0MSbvcSeCsDMOwojJtEFDzWw+lbLwsXAAlSx4rZKm41Tk1V5FFdJEwmBSSJ4/go+6zRJ/t+CKQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7054
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_15,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250155
X-Proofpoint-ORIG-GUID: sjxUPjFGcLDwVese7SgWJzO_apJmn4ic
X-Proofpoint-GUID: sjxUPjFGcLDwVese7SgWJzO_apJmn4ic
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 23, 2023 at 05:33:46PM -0400, Alexander Aring wrote:
> This patch reverts mostly commit 40595cdc93ed ("nfs: block notification
> on fs with its own ->lock") and introduces an EXPORT_OP_SAFE_ASYNC_LOCK
> export flag to signal that the "own ->lock" implementation supports
> async lock requests. The only main user is DLM that is used by GFS2 and
> OCFS2 filesystem. Those implement their own lock() implementation and
> return FILE_LOCK_DEFERRED as return value. Since commit 40595cdc93ed
> ("nfs: block notification on fs with its own ->lock") the DLM
> implementation were never updated. This patch should prepare for DLM
> to set the EXPORT_OP_SAFE_ASYNC_LOCK export flag and update the DLM
> plock implementation regarding to it.
> 
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/lockd/svclock.c       |  5 ++---
>  fs/nfsd/nfs4state.c      | 13 ++++++++++---
>  include/linux/exportfs.h |  8 ++++++++
>  3 files changed, 20 insertions(+), 6 deletions(-)

I'm starting to look at these. Just so you know, it's too late for
inclusion in v6.6, but I think we can get these into shape for v6.7.

More below.


> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index c43ccdf28ed9..6e3b230e8317 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -470,9 +470,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
>  	    struct nlm_host *host, struct nlm_lock *lock, int wait,
>  	    struct nlm_cookie *cookie, int reclaim)
>  {
> -#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>  	struct inode		*inode = nlmsvc_file_inode(file);
> -#endif
>  	struct nlm_block	*block = NULL;
>  	int			error;
>  	int			mode;
> @@ -486,7 +484,8 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
>  				(long long)lock->fl.fl_end,
>  				wait);
>  
> -	if (nlmsvc_file_file(file)->f_op->lock) {
> +	if (!export_op_support_safe_async_lock(inode->i_sb->s_export_op,
> +					       nlmsvc_file_file(file)->f_op)) {
>  		async_block = wait;
>  		wait = 0;
>  	}
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 3aefbad4cc09..14ca06424ff1 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7430,6 +7430,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	struct nfsd4_blocked_lock *nbl = NULL;
>  	struct file_lock *file_lock = NULL;
>  	struct file_lock *conflock = NULL;
> +	struct super_block *sb;
>  	__be32 status = 0;
>  	int lkflg;
>  	int err;
> @@ -7451,6 +7452,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		dprintk("NFSD: nfsd4_lock: permission denied!\n");
>  		return status;
>  	}
> +	sb = cstate->current_fh.fh_dentry->d_sb;
>  
>  	if (lock->lk_is_new) {
>  		if (nfsd4_has_session(cstate))
> @@ -7502,7 +7504,9 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	fp = lock_stp->st_stid.sc_file;
>  	switch (lock->lk_type) {
>  		case NFS4_READW_LT:
> -			if (nfsd4_has_session(cstate))
> +			if (nfsd4_has_session(cstate) ||
> +			    export_op_support_safe_async_lock(sb->s_export_op,
> +							      nf->nf_file->f_op))
>  				fl_flags |= FL_SLEEP;
>  			fallthrough;
>  		case NFS4_READ_LT:
> @@ -7514,7 +7518,9 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  			fl_type = F_RDLCK;
>  			break;
>  		case NFS4_WRITEW_LT:
> -			if (nfsd4_has_session(cstate))
> +			if (nfsd4_has_session(cstate) ||
> +			    export_op_support_safe_async_lock(sb->s_export_op,
> +							      nf->nf_file->f_op))
>  				fl_flags |= FL_SLEEP;
>  			fallthrough;
>  		case NFS4_WRITE_LT:
> @@ -7542,7 +7548,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	 * for file locks), so don't attempt blocking lock notifications
>  	 * on those filesystems:
>  	 */
> -	if (nf->nf_file->f_op->lock)
> +	if (!export_op_support_safe_async_lock(sb->s_export_op,
> +					       nf->nf_file->f_op))
>  		fl_flags &= ~FL_SLEEP;
>  
>  	nbl = find_or_allocate_block(lock_sop, &fp->fi_fhandle, nn);
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 11fbd0ee1370..10358a93cdc1 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -3,6 +3,7 @@
>  #define LINUX_EXPORTFS_H 1
>  
>  #include <linux/types.h>
> +#include <linux/fs.h>
>  
>  struct dentry;
>  struct iattr;
> @@ -224,9 +225,16 @@ struct export_operations {
>  						  atomic attribute updates
>  						*/
>  #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
> +#define EXPORT_OP_SAFE_ASYNC_LOCK	(0x40) /* fs can do async lock request */

We haven't been good about this recently, but the addition of new
EXPORT_OP flags need to be accompanied by updates to
Documentation/filesystems/nfs/exporting.rst.

I will see about adding documentation for other recent flags, but
please include an update to exporting.rst with this patch.

I'm not sure we need _SAFE_ in the flag name. Would
EXPORT_OP_ASYNC_LOCK be OK with you?


>  	unsigned long	flags;
>  };
>  
> +static inline bool export_op_support_safe_async_lock(const struct export_operations *export_ops,
> +						     const struct file_operations *f_op)
> +{
> +	return (export_ops->flags & EXPORT_OP_SAFE_ASYNC_LOCK) || !f_op->lock;
> +}
> +

I'd like some cosmetic changes to this API, since this seems to be
the first utility function for checking EXPORT_OP flags.

- The function name is unwieldy. How about exportfs_lock_op_is_async() ?

- Break up the long lines. It's OK with me if the return value type
  is left on a different line than the function name and parameters.

- This function is globally visible, so a kdoc comment is needed.

- The f_op->lock check is common to all the call sites, but it is
  not at all related to the export AFAICT. Can it be removed from
  this inline function?


>  extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
>  				    int *max_len, struct inode *parent,
>  				    int flags);
> -- 
> 2.31.1
> 

-- 
Chuck Lever
