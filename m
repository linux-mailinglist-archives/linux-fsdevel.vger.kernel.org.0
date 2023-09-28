Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B57C7B1F7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 16:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbjI1Odk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 10:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjI1Odi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:33:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A308B1A2;
        Thu, 28 Sep 2023 07:33:35 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SDggo3004395;
        Thu, 28 Sep 2023 14:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=q9fNMo0R4pivifen1BXVxhC1xCvDeSt9A8mMomRXbbc=;
 b=PlJ7IapFu2FE8JcbFfb9lc7iqM20b/AxTb4cuHXDu3Jas0nYz5SKT0mw7BXPdA81zwbw
 FZ9rd4SFrpEgJUHxe0z7CiPgsmYNVSX365Jnty3ljw6Npt+mtwaZh/fs2zzY8Kz4lUJk
 RsJk3SiySKaRSN0ZXKN0bluGVP+Ihr4LMdICcdJJbAymeiuD1kq1Kh1wjAbQao9fxexP
 4Wkb3WonPE71FgaeZAIGUTF1DHG57zHJ2XUZAila+B9w4LtzKqzxsjPjciF1Wlp++M8q
 GZ7p5VjO+UPu6/l4sii/B1fqQb9+ns9S6GA5Ec+vFCyh693g7tl1wojbmN2nhUDwZFNn iw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9rjummnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 14:33:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38SE8idc037395;
        Thu, 28 Sep 2023 14:33:24 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfa6d7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 14:33:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjDTt+wT4KNYJdmdJbSdatbdY/8OVo90YgtJmCe3rTGw/otxYaAj8aBJlki/tc24WZOiM2PWMajVx6Hed0XcGLOiwZ7WfBD0UxEXFjsAZlkvtx77I6M4H3NvZTcz3B+8jMQXq2P9Az9piKuB6f39GkHeLAPA8yuZ2eKmGYsuEOQjehhoGk9RYWj2yOWDEJc1U+qT6VqCHncD/7uyEmwpIKU6SB8Jq8opVQlIT1YNC83sQY8ML54yAU8J9qa1oMFuMmgkujQ2YATse3oHZY60jhz39uNaOFLGi6ZxLrUDQ6BTIYeND1N3JKE5hHXGs5PEEcfbE5ttvKiVYcPz8FQJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9fNMo0R4pivifen1BXVxhC1xCvDeSt9A8mMomRXbbc=;
 b=LhRSyj5u16mYSXyJNz8Pj6gM2hx3KhyZUoYNp4Bb1MyhWpI+jiZMq59vkj10MdUkosMwjkidHPi0K9TEXEP9i/bSBzvP3dikrMFbCR8ygsijq0Oa6MZYi+90HvxWNSNjc6Z9hnIeK1ZL32+BM/DH7ou0At6NGoQq7l3bzr4Asqal8ttxvAqrqXxLxf1u/SvuqjIUtTy/oZ8nglMheAWyBiLdXQRPC5Cjx4t/SdbU+hsmP4Gx6MOJRKD1bnY5muBA7LF3UCxXw3X6QDWbNlZuN/FTd0eSU8AP1piTyFUVxFFAdVXwU8zgIisC0nN1pl8WGMRj9rMhY+mcdpGHf8eQPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9fNMo0R4pivifen1BXVxhC1xCvDeSt9A8mMomRXbbc=;
 b=icgA4GZYWorrNBKPKqAZ/MyT0i/sv4LscfbN17KXpIaBokCFdV82JNJb8hgtuX34r+JvNTfb/Ap7loIGub+X5PgfknwF07vDCujWPpNisxmEEqbtuLlEGVfY5he8JA/cFkYs7b1PyRnSzCyHoIqTnbPmlz+95FlG2+6GCJTJUbc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6136.namprd10.prod.outlook.com (2603:10b6:8:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 28 Sep
 2023 14:33:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 14:33:19 +0000
Date:   Thu, 28 Sep 2023 10:33:16 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 51/87] fs/nfsd: convert to new inode {a,m}time accessors
Message-ID: <ZRWOrJ+XmbiAxJ7z@tissot.1015granger.net>
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
 <20230928110413.33032-50-jlayton@kernel.org>
 <ZRWGBGqYe3rF5CRY@tissot.1015granger.net>
 <c908f4e65777b15e4574f27df97630b3033804a3.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c908f4e65777b15e4574f27df97630b3033804a3.camel@kernel.org>
X-ClientProxiedBy: CH5P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: a3077ae3-6910-4d96-e5ff-08dbc02fdc74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NIEo/+WYNZg/riE8qIUQYVSrpR+CgZxjMvNcrndSZuSaEIyap1usK/QOGwTXu1dpOshFSOIXxFzfJS3mscOrPpmHUFyZpT4XeNPtXHQVO0wKWut8EiWJaTnRw5SlxuzzrbK4/j/cZiJ47W8YdjMJ+dM2H+PXISjvWnQbij31JMdRiDISv3XKy3UrjQmQeKB5oI2gtOOJdUySdj6/NDKgLcn1UPMpVECxKa2gacM6Hx8TLrtt41Jft5rbR7+ZQ4W01IWG9IaIPBL/lHacudA9KpK7fdiaunCqn7TedaLUCKXhaCFHKQzav7YjEqDAIp5WoMr/qMMOvZ6nqRQwPwmn/dXq8L2gjFvxGWVEY85XNA70+IMEK9tB82ern/DDXZf89YJvxZgMEUQsxubKU/M3PWcROI0QG2dQslttBfulCaVhQ57QjswFqFtwmTRZsNWAJFK95vVpvPvtZunDzz6Z7z0zcqf23tlHfbfEi3NvV9EAauA16rKKFJQrGpvtDQd85fAIvr42+A/N9lr3633SqWXbIMRvvkP9CocuO3Y1Pj3UA7Qlq2T7ImVCTqDEx+56JsPAkOQ3KMOh98QcK5KHCw/Qc6U7sjw/Q15T+1eE+50=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(366004)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(2906002)(4326008)(41300700001)(316002)(8676002)(8936002)(44832011)(5660300002)(66946007)(66476007)(66556008)(54906003)(478600001)(86362001)(6506007)(6512007)(6666004)(9686003)(38100700002)(26005)(83380400001)(6916009)(6486002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PUYCh2hYRZbWUmYo6zOxecaBK4cGDMm4QSMXMXj7pZDgCRGjlu+2JF6PRarw?=
 =?us-ascii?Q?IYENq5Fs5XvS8mdAbUZR0VtWq2+1fkMBQUmDwXxc5ZoaAjoB4t4hQXCIyJyl?=
 =?us-ascii?Q?ZlTKhOAxqgBnsbioWF+8nxERdbUO7BBwefk8ImYwOMNow2prBD6SSOba8sZv?=
 =?us-ascii?Q?nrOMK3EXWapELEXBcdkSWBVUclH1gCBwvVGeZg5rcGqMiBMcoGUdk4bUjadu?=
 =?us-ascii?Q?CiX830QMF+aQ124FaCl5ctkydPQPSsyikeb9fzJt9YQ4/f8o9ABjtmEjw5FB?=
 =?us-ascii?Q?5NoLpu6AbtdDc3VdzPhiHQjY77AQ+PK00vcTXj8+O4j1Au3lqAOgciA3v3lp?=
 =?us-ascii?Q?sEM025nAqv16a04HTuaKoA/8XS0kLsl5dMCrBIvr9khAaRw8RWCxruqcvVEP?=
 =?us-ascii?Q?c2soIPyYR1IEXvj7dUYbooD662u6SLniPyUJUYiNVPdw081u1GOvjPXNBbqE?=
 =?us-ascii?Q?QgYiqTrF8b20Bt18Ey8/oFsBMnzUXUrJdKROIAkXOvgcXJJ2ouVTXgcAgCWo?=
 =?us-ascii?Q?NNYnGQXF350pbPwFb9QzjP1yozR60IX4JA+DUXZ0XLvVuXDlJ+vIhelXJSqV?=
 =?us-ascii?Q?fYlrAFuC2Gx4Ht52InoFQJL/kBoi7NsmB8m7/mlD9k43HDTvzbm9uhqLEuVJ?=
 =?us-ascii?Q?b5h9h+kztFo/cGchuSVpUjMrw6ks6NSzdj3nuP8Szt3j/Ay0uCwamJPR71kt?=
 =?us-ascii?Q?mhV/ezxpr2U8u4WHNIw8xXusObG0jDuPgor31r0L6B63h4fK2ZTP7Xz7pa0f?=
 =?us-ascii?Q?xN4m7q7sebXHV1lAUJ5U4YzfvJ3J9IlwzioqVfSVH54OnA2bEiCmAnHH9Iuq?=
 =?us-ascii?Q?STicmK4Ws+SlvxCa1htNygFmhH0fhP71iatK3OufZp7e19iQuEDWYjemvq9H?=
 =?us-ascii?Q?I6dcsVudR1LlEnMRI7fvvDNi8I5ZndH83VoU8g45FK6ZZmUqETrXc/ymXFaH?=
 =?us-ascii?Q?WT/18QtiwbVcfsTi7bmULakXHrZtR6fhN3Pn1Uj6go7CzMffSKnLmG5omiwy?=
 =?us-ascii?Q?kKS2zuNqi++0qPWy/CKApFJtWc/pHjsCl+nJAFSuHq/w7vX0kFH2IziO7sy9?=
 =?us-ascii?Q?h+t7yYz+PU+QdwlpYODjQKfMAPAbmbozY7rterNmwLNReAWWXoYyZ3yNu5EW?=
 =?us-ascii?Q?A8v7zPXdKErFC2e1IE6ajmb1QZeis2NFfkwmzY/7g77xxJT6Mtv2zvq9t9mq?=
 =?us-ascii?Q?BoA26znAIn7aNDgtPZdFT/pSMY0jgWpJ9aqNfPtY5OVmvzeLyJy2vtEzAAPQ?=
 =?us-ascii?Q?gfaSA/OubdumsL8bLR4Vxi29OTIqxe2P3NQOZgOtEpAAN4NvFmjM7JU5glnP?=
 =?us-ascii?Q?etk0zY0omJghtzZTYfUmHm1CVlX9qesw4Robm1/jPSqBIboXNG3PZYhriRu0?=
 =?us-ascii?Q?VnjsDf4a+uJOzR03kfr882Hfc8b0zUXrwiDMAee9a+uMU/a8pzwLcTkGSBKB?=
 =?us-ascii?Q?Y2WMOH3ys/VttgK+XRGoJ+1NkPaFe3jAZ+JmDXrvtZHTndLBoMsDCr0uSwvt?=
 =?us-ascii?Q?ZqMw/aN6QM8E4WrjCnxeSWeEVnqzkUtSnZ+tZ6zq4tYROHmUM82vb8p6DucP?=
 =?us-ascii?Q?sZeC3obs7RimWN3T8QYF25Rdw9ZWjcomreeCuAfYhZ6SjpZP5zpK4aPXDf1J?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Xkg5DDO0Prnj3QVQuY5NqxPsbi8asCaEgP00xZv3+dDaZluwo8lPPm8SQrY1QJIS41yN98xwOIgxvAMXrEMVTVgkp9BZ9qZwTS8qf9iCt+Y13kvYyrFSWecsqX4i3k1PbR1j21WwHebA83NWb9KQG1xdUlpD3Noyi2dLQmw1RsIfNlhWxP1T+84ba2/NX4K8jYlFaam84lgx+X/D99u9tGqsrdiyVKC0bypGP/EyLRHoXWnYFrHqR5IfN78ZGemgAtBCBQvbGucHF71QR8AdcFisUf7enpKeYs8zglURfVY5IF6YHI8DXrQ9fPCmOGp8otsIZ28W2R8W5qTi9wcb8iuF9ndlXxCGhmJWwvtAy7biCVPbPPmSpVt2gXtXw261/W9PGKRu7cp+jpCoGMLuqMI8siIkU1dBdZ/+XcvnVS9S0bt59ryIOx6NN/hECVnda3bEwVWJCBvhSb0tSq5wNf+NmKOA6fyNx46F/HTbF62mwx4iGPrkXSmvkkEa1+jC/CBYxEcuN6G6nVYl3YgvwwZWJdfiMMmDP2ViP/x+bLvBLfKNdNmbWwY4ZDBnezZRL+CuEpXZ7qfjWh5bCjkGiBwBsv58TkukZEFELJyMSb6NlSiRAiP5UBE+domYVbA9rEuzPJtg+zSwlKjCu2fuefhEmFv0ULJpCDPNdM1CKY2gcLTecRR7UwgsYNIW0M/ilM+HjKEK1dPFalilnoSEnok2r3RcIXEgvm+nyqT6MRCebC8i4FJZKL2TEkcbVIM1dZhwTYq/sQqB4qUaDuDnoDWZX0R6oBsTdOS2R28y+i3guGKSfiUV0enw9EfdysPRU+WmyDlYOXtZrWZUQbtvyrz2v06u+eOWt/q4kDmFmIfDwYI1mDAPwvyz3wi7BsSP3Bbt5N5ogf71XshSmPz3s1pLrOikT6blZVok85iWlvU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3077ae3-6910-4d96-e5ff-08dbc02fdc74
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 14:33:19.8767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aDQr9lKdSd8IWasMGVqKfPbJwNryFCa8KT1E4CEuXeQ4Wm8utIYu6z6LfawkAoeEQlT+Cz/E3Vt0b5xlz3Rgeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_13,2023-09-28_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=894 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280126
X-Proofpoint-ORIG-GUID: o_BSE48eARl1DEIoq0Vh01omzGj1JUiO
X-Proofpoint-GUID: o_BSE48eARl1DEIoq0Vh01omzGj1JUiO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 28, 2023 at 10:09:19AM -0400, Jeff Layton wrote:
> On Thu, 2023-09-28 at 09:56 -0400, Chuck Lever wrote:
> > On Thu, Sep 28, 2023 at 07:03:00AM -0400, Jeff Layton wrote:
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/nfsd/blocklayout.c | 3 ++-
> > >  fs/nfsd/nfs3proc.c    | 4 ++--
> > >  fs/nfsd/nfs4proc.c    | 8 ++++----
> > >  fs/nfsd/nfsctl.c      | 2 +-
> > >  4 files changed, 9 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> > > index 01d7fd108cf3..bdc582777738 100644
> > > --- a/fs/nfsd/blocklayout.c
> > > +++ b/fs/nfsd/blocklayout.c
> > > @@ -119,10 +119,11 @@ nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
> > >  {
> > >  	loff_t new_size = lcp->lc_last_wr + 1;
> > >  	struct iattr iattr = { .ia_valid = 0 };
> > > +	struct timespec64 mtime = inode_get_mtime(inode);
> > 
> > Nit: Please use reverse Christmas tree for new variable declarations.
> > 
> 
> Ok
> 
> > 
> > >  	int error;
> > >  
> > >  	if (lcp->lc_mtime.tv_nsec == UTIME_NOW ||
> > > -	    timespec64_compare(&lcp->lc_mtime, &inode->i_mtime) < 0)
> > > +	    timespec64_compare(&lcp->lc_mtime, &mtime) < 0)
> > >  		lcp->lc_mtime = current_time(inode);
> > >  	iattr.ia_valid |= ATTR_ATIME | ATTR_CTIME | ATTR_MTIME;
> > >  	iattr.ia_atime = iattr.ia_ctime = iattr.ia_mtime = lcp->lc_mtime;
> > > diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> > > index 268ef57751c4..b1c90a901d3e 100644
> > > --- a/fs/nfsd/nfs3proc.c
> > > +++ b/fs/nfsd/nfs3proc.c
> > > @@ -294,8 +294,8 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > >  			status = nfserr_exist;
> > >  			break;
> > >  		case NFS3_CREATE_EXCLUSIVE:
> > > -			if (d_inode(child)->i_mtime.tv_sec == v_mtime &&
> > > -			    d_inode(child)->i_atime.tv_sec == v_atime &&
> > > +			if (inode_get_mtime(d_inode(child)).tv_sec == v_mtime &&
> > > +			    inode_get_atime(d_inode(child)).tv_sec == v_atime &&
> > 
> > "inode_get_atime(yada).tv_sec" seems to be a frequently-repeated
> > idiom, at least in this patch. Would it be helpful to have an
> > additional helper that extracted just the seconds field, and one
> > that extracts just the nsec field?
> > 
> 
> I don't know that extra helpers will make that any clearer.

To clarify my review comment:

I understand that eventually the timestamps stored in the inode will
be a single scalar value that is to be converted to a timespec64
structure.

So for accessors who want only one of the tv_sec or tv_nsec fields:

   scalar -> timespec64 -> tv_sec

It might be more efficient to skip extracting the tv_nsec field when
that value isn't going to be used. Perhaps the compiler might
observe that the tv_nsec result isn't used and remove that dead
code. But IMO it would be easier for humans to understand and more
dependably optimized to write the helpers so the tv_nsec part of the
computation wasn't even in there in these cases.


> > >  			    d_inode(child)->i_size == 0) {
> > >  				break;
> > >  			}
> > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > index 4199ede0583c..b17309aac0d5 100644
> > > --- a/fs/nfsd/nfs4proc.c
> > > +++ b/fs/nfsd/nfs4proc.c
> > > @@ -322,8 +322,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > >  			status = nfserr_exist;
> > >  			break;
> > >  		case NFS4_CREATE_EXCLUSIVE:
> > > -			if (d_inode(child)->i_mtime.tv_sec == v_mtime &&
> > > -			    d_inode(child)->i_atime.tv_sec == v_atime &&
> > > +			if (inode_get_mtime(d_inode(child)).tv_sec == v_mtime &&
> > > +			    inode_get_atime(d_inode(child)).tv_sec == v_atime &&
> > >  			    d_inode(child)->i_size == 0) {
> > >  				open->op_created = true;
> > >  				break;		/* subtle */
> > > @@ -331,8 +331,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > >  			status = nfserr_exist;
> > >  			break;
> > >  		case NFS4_CREATE_EXCLUSIVE4_1:
> > > -			if (d_inode(child)->i_mtime.tv_sec == v_mtime &&
> > > -			    d_inode(child)->i_atime.tv_sec == v_atime &&
> > > +			if (inode_get_mtime(d_inode(child)).tv_sec == v_mtime &&
> > > +			    inode_get_atime(d_inode(child)).tv_sec == v_atime &&
> > >  			    d_inode(child)->i_size == 0) {
> > >  				open->op_created = true;
> > >  				goto set_attr;	/* subtle */
> > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > index 7ed02fb88a36..846559e4769b 100644
> > > --- a/fs/nfsd/nfsctl.c
> > > +++ b/fs/nfsd/nfsctl.c
> > > @@ -1132,7 +1132,7 @@ static struct inode *nfsd_get_inode(struct super_block *sb, umode_t mode)
> > >  	/* Following advice from simple_fill_super documentation: */
> > >  	inode->i_ino = iunique(sb, NFSD_MaxReserved);
> > >  	inode->i_mode = mode;
> > > -	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
> > > +	simple_inode_init_ts(inode);
> > 
> > An observation about the whole series: Should these helpers use the
> > usual naming convention of:
> > 
> >   <subsystem>-<subject>-<verb>
> > 
> > So we get:
> > 
> >   simple_inode_ts_init(inode);
> > 
> >   inode_atime_get(inode)
> > 
> 
> This was already bikeshedded during the ctime series, and the near
> universal preference at the time was to go with inode_set_ctime and
> inode_get_ctime. I'm just following suit with the new accessors.

When this was reviewed before, there were only ctime accessors. Now
we have two more sets of accessor utilities. Just an observation. I
can drop it here.


> > >  	switch (mode & S_IFMT) {
> > >  	case S_IFDIR:
> > >  		inode->i_fop = &simple_dir_operations;
> > > -- 
> > > 2.41.0
> > > 
> > 
> > Otherwise, for the patch(es) touching nfsd:
> > 
> > Acked-by: Chuck Lever <chuck.lever@oracle.com>
> > 
> 
> Thanks!
> -- 
> Jeff Layton <jlayton@kernel.org>

-- 
Chuck Lever
