Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542127B1F0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 15:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjI1N4i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 09:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjI1N4h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:56:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BB719C;
        Thu, 28 Sep 2023 06:56:35 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SDgmiT031274;
        Thu, 28 Sep 2023 13:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=+lZz3VX3Z95fQavSYfRDDodMA+CISHdMye62G2AHhPw=;
 b=W78OsVbS524h8TPqgDQFyyAHatQDGc6gEz4UJnMav+Sg/m/FQaAKvJoDyC4RuK2SfRJD
 4P9dhXPfyfgXHlXcNocIt61fexX0NB6cSACYckfBDQmqo0tfkW1TGzPYmLUc8nguPaMQ
 B8Qyooy7vhI2xnwF9uZBNtsYESjhiSErRUogGtV5AnMQxUKoE6wmgu0ZEccemowQrU4z
 jG+o2El1IV7YjaM/11mp/+X8rxhKXvTR3JHbMg1gvLkcc45eTBTnJvgFU+JTHUGrXd15
 O+BcgFUCWAhpQH9mO76z+GFnC2mfn0PjMilp5lrirAkX7ZKuaSWVw0spJ5vqNK64A6xx uQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pxc4n7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 13:56:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38SCNpDw007936;
        Thu, 28 Sep 2023 13:56:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfa35eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 13:56:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ercjb8vJnLRLTIaAKrFDgbNlvps3F1atAI1jPc7B4Z2gkctla2WBnr/egAjVbSSmxQje3SLW5xLj4gQIsnCu5QdGls4X7xKfcV1sLu9f1CwqZxBNgMUQ4jDOHB/kk1iWgaklkQ2K4kC0oVCwSz5PsSZlgUWj+ep1CE9b/8JMlZ9hEXeWYJKOL2waAqhprDTBZtf3GYmNLGY4cIyX0u8U4r94n2auva2BMXeRrgyxtwb2rrT7dRUcTYaIK0w/MGCBDS+9RVlcj1a8ec6T+OaiH7iNG+51jVQTfbUM3o0to8L5U8qS6aa1X76tdTHaYHPo8fs1FHaQ9naH/MQqr9+Epg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lZz3VX3Z95fQavSYfRDDodMA+CISHdMye62G2AHhPw=;
 b=aW8QBlXh63OwT2eg/1+pPPgGkD+aG+ZI9aIeccwBzASB23VivVTVaFVxJ1kfRa+V5TcrzUKSPZr94xr9mhllKbKecgeDIIP96cUCZeTTs3qVAubpp7mubfpZ7VusGBH6B1YlZtO9Pc1ue+cvDyW7cvypltZpQu0nKllOPUU4kGki3auq/c4VZgZVhUFzdzECCFGEY9kSOqJ7t82Hm5LS7A0/OKJ8fPnrvsyWOmc0ZTavc6VZKB7VjgZ1/YjAyRqq25Pn14nKUUoEnw+0JsfcaJYs3nhdY1uUuU+mSfJm8Xwppp8GdBEz72a6ZxR5eYdgAgnbslJV9STehebtxK9Fow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lZz3VX3Z95fQavSYfRDDodMA+CISHdMye62G2AHhPw=;
 b=boeamXT+buyi6PIANvoX1dl+yRk0ymRTCOByG+N89zYTc6XyUnGcwuJfYI1MB7N/zsHBkTedGenN23hbQmm0pOLcbRUB0AFE74K+Y9VRDlO3RlR266ZJtI1i7XJ9vg/bCdVanlq+xubC+jKtBt/DkHfsY/3q77vjf9+VQlLasy8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7156.namprd10.prod.outlook.com (2603:10b6:8:e0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Thu, 28 Sep 2023 13:56:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 13:56:23 +0000
Date:   Thu, 28 Sep 2023 09:56:20 -0400
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
Message-ID: <ZRWGBGqYe3rF5CRY@tissot.1015granger.net>
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
 <20230928110413.33032-50-jlayton@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928110413.33032-50-jlayton@kernel.org>
X-ClientProxiedBy: CH2PR08CA0020.namprd08.prod.outlook.com
 (2603:10b6:610:5a::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2a495b-025a-4b33-28b7-08dbc02ab33a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d+1QugMXbSwD8LNxXAtEHAUJSkGovPcqw6co0ITThZtvFhQ+aD/coS8nFqw+Oci5Nk8HaQpkW6iQV7b9rdjarWcGrAF4xqLPFZ5okcynCJUz+C+ev1BZTDg5XZ/Y1drzZ1/UDnjrt7qOgHJ0BC5eurLELTa/ouTQGSrBu4u2It/LEeehKS7cZWZKnJEhbkcLFbFKZjbmRCjrrsFlFq/bDgojAnxRX2xDcIVf34URfVgX0dnBr86dEvjwhwgDB+1XOAvdVKP50vy8t1aRzXAtp0UndU8YNhSPF/G/O/59FdWY3YS3F1EAUyCEt8mwZoDhwvjGcGfcnLsSfYOIwFO52cizYG9S7zPQiv8ruFqaUk2rjH6AdIp3MwUJMiAym1XMGXMW0U3jGxPzhZGdzsA6jWMyZsuv7ti3cjQVmPoI9gKw/7kyHTxMuoGx4AHY+cxv2Gc80QCVq/687pYCEr2t24zBlscobqUCfUNbQM5zMthiy6ULvwdls9Iew/uZO/+My0yNQotmfN2dTaJN85JzVyXHASJlO2xRd6p2C9kZmdFvWJt8ill0d60lRZMbLPEa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(136003)(366004)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(41300700001)(8676002)(4326008)(8936002)(6916009)(66946007)(66476007)(66556008)(316002)(54906003)(26005)(44832011)(86362001)(2906002)(478600001)(6486002)(38100700002)(9686003)(83380400001)(6512007)(6506007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Owavdr32Xlu5Z947XVcj+04DAaP1HHZ9GI/4pgHsD1AK5BYkDbA9XRwfe4N?=
 =?us-ascii?Q?dAt53L4TTN2EZEUy8AgRBA3W6omC63mu7QLRdpVEzQONzjYscdj1jQxY7b9l?=
 =?us-ascii?Q?7l0qa3QEL1jplj8ob1Yeio8JkI02ltcltwLoAQmRzqqo5ndGF5bot+fr7bnV?=
 =?us-ascii?Q?VVX4Br+yCFRXaGreHTNSoiXer7CWpQJ2arpraFskF61vVojbTKWz2ia4paLN?=
 =?us-ascii?Q?+u3dNcVeQK8AS72Z6qd+rcZxsZpKz/3pYNf/NwLr/PxKLREsphuPrXHWStO8?=
 =?us-ascii?Q?Pr7plB2fMfENOlJMkHm1EV8Dn/uTDManPyDAj9Cxwu45XfxpVLQkmjOcfrJp?=
 =?us-ascii?Q?5zpGsSsaMCDbSRV8dhI9DeCV7jn5AkaNYMrsgyjKfwgwis60x9yj8TzUEKv0?=
 =?us-ascii?Q?Bc+dsZQrE4bSFm5jm8IA/Dx7JYajynL6ph5We9GZNqgFFu1B3DgAjwD1d8hH?=
 =?us-ascii?Q?lz5ugvD2Wq8TnQmMCSqjq3Ur0X5W0FhPfLbhB1iTU9XvRV2K1IJoqr1776ku?=
 =?us-ascii?Q?RxRwdPiNnexJnxy3GXdqzgV7tAn2e4WGFG2VhX1QSO758O8QaX6as0GV1O3A?=
 =?us-ascii?Q?1/3bVIxD1XmYBPM5PJUFzRI9IsRYziUh99jHTevsgdrcqI/EPjrTQwSq+8Yk?=
 =?us-ascii?Q?DNg62HgZb++PfnqOtk9fF3gCsM2YmOhAxzTBkZH02fBobHydKCP7PSg/6lso?=
 =?us-ascii?Q?my8EEMJgXC5cpjJQzpBprxhLVD679IHmwXjdIsaoPHyfXo5xcVeLW4X3xFsU?=
 =?us-ascii?Q?rAVv5tGhQdeeJ9LDxMNHRbQnda5A4FcG9Sw8h+++Opjea9nut5p+t4s0qCUX?=
 =?us-ascii?Q?ygCllk62Zktvgr5v55GUB9InMvew58CPi/vtWD3WYO6jl1ePKMgHzm/94FOH?=
 =?us-ascii?Q?7UHzGzgY3RgNx1hnpNmtpFVq3ZTzWOnQoN1JWeVM3EX+seBGZiSi5H7SST6J?=
 =?us-ascii?Q?glU0mYPNF+iDTPUIkgLepx246oCwu+TuPHW/UhuKZXPj0Lk6p50v3hwile67?=
 =?us-ascii?Q?LaPpLyBy9Y7ls4dD4C4PsIduPEKUdgI/Seeg9nD5OME+RKjBaI2rSA7E90rE?=
 =?us-ascii?Q?0ZAQLYdQKy+c5/iGXFgrbQwC1KuZN4f3reQ9O5C1CooWqCvoRLWwJGiZxpKx?=
 =?us-ascii?Q?d3f4l2aN9flPpzuIl2x+s79G9uXwiPAbzrg+cACHoPGQsqOdcRbrtYrMZY0G?=
 =?us-ascii?Q?0YW5Ra7VStmIq0LOlEqTnhgK4WRtdw23xIRBxSc6Snl4Xx3Ju8ki0JaccZUb?=
 =?us-ascii?Q?5BPKq0FmnOWLP5GReYk9rEtO/3Abbk0s9rWboCJctow9vrUPNJC1Lgis4Vyh?=
 =?us-ascii?Q?VpOZpJzRufhkCNdjfzN93sCH5cGhG1zJ7P6KM6sDC+2rIztkXFnS4dLFvOld?=
 =?us-ascii?Q?vX6g3cu3qwg49Lm22lgk9oQxm4PRP0k2h3g0TeMrxzoa/rR6ec7wqBLr6nCh?=
 =?us-ascii?Q?H4m2AXugl2Ek7b3eZre5sQBmMi8tgim1d1hyF20+tbf7No44JNKZ/oWFq/cf?=
 =?us-ascii?Q?CXPf+SHoHN4mxmpPhUhcaBPMShgJ5Y2wG2rgRSGvIKgACGGxNkiHfvlWw5dH?=
 =?us-ascii?Q?tgz7QOQKiPty5BmMiaj8AtBASRSvkfopvTXZCxyNeI8hjqZl2rtMDR1LH5h/?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LBYzdiUdf4d8YnXAqV8q7345bCtxxn7n4bGaCkSNZYCsSNW+FcKfS/T57RPUH/SDG4UiPxGWU+xvTTP6t30PF7wKYLeKjwvYdAa9WBdbrKEpV064ydv80m+2dlbxvZDBF6p6lFlS9/xj56aznV898xp/l6HVwJ+8iX7qN4KsYdN6oKGn83jImQ7vmbv6s/hiC7+97K7SnRelHWG9sm8Ar9cEUeD+XmfFOMjqpALSvgFUlVSOh0YoPtR9+Q9P8OssnacOEuiwvEqBuAQufVR78+HUdc1yAiAFrSP/xs8nhnlerIdMrdgCUhrTrD2o4BcTX+TzurpE+wI+CoUoGjZ0cPYCRWTolkqJD/S3trlyPJU4qiwSdBhkFSm4wEBtttoRh44Z8MaF8Ieu8V8oCmLekgEr/LET+2eKhNgpqlWK+1nJ/N8hEkxiGnpkPLc2YS/nAG5FKgo+p6s1M+8S8cYH7t/OvvapyS+bjlfB8+yaYLD6KYiJwUCUTErM8/hHmyWYXTPlSzlXHtVEeszhJcHI/bJE9y3suW54Igs3A4NRYPG7hszy2EjdI+x0fPFBkYVr84I1TPBuW/nACs/g133xZBVWGpFTwqPFTfwlp2iEKrB3BJZzO+/ygLkqFgkclvJMOhf9NkL3lcxkHUdJKU5Rj37OounHUKdiBSia1Q9kB86rEEyS10/VKN/SkQjYBizWdUwSPoc73akCNoXVh4fmyJwSDOiicSe8ge4HPVmco60gn3TIE6s7dhD7+ORX7VuzM6yrasXevWhvnhi0fpz0oojQ3gOab3eFQssNz9RRDeEynb7wtN9v8o/B5+4NDTQL9djBxj6cDFn/KO000c9QpUepKa2fRHaKUqN7gdjMhMGstvlh3rSq/mBcCe+6r2ird4uCZRllclrmpQjxNJ902dfv0ZvWtOj7+pfcclvPohs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2a495b-025a-4b33-28b7-08dbc02ab33a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 13:56:23.2510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/xaUmo4p/G5AAO5MJAeVDZaLUrSfsMAaClq7pgZGx4BNJOoWxKAocu4+HDRz3vCXmZnpJuw2qNTBEHFfALavw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_13,2023-09-28_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=741 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280120
X-Proofpoint-GUID: T_8elOJXk3TMZ3d89Q6GmSw5cdusYLZn
X-Proofpoint-ORIG-GUID: T_8elOJXk3TMZ3d89Q6GmSw5cdusYLZn
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 28, 2023 at 07:03:00AM -0400, Jeff Layton wrote:
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/blocklayout.c | 3 ++-
>  fs/nfsd/nfs3proc.c    | 4 ++--
>  fs/nfsd/nfs4proc.c    | 8 ++++----
>  fs/nfsd/nfsctl.c      | 2 +-
>  4 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index 01d7fd108cf3..bdc582777738 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -119,10 +119,11 @@ nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
>  {
>  	loff_t new_size = lcp->lc_last_wr + 1;
>  	struct iattr iattr = { .ia_valid = 0 };
> +	struct timespec64 mtime = inode_get_mtime(inode);

Nit: Please use reverse Christmas tree for new variable declarations.


>  	int error;
>  
>  	if (lcp->lc_mtime.tv_nsec == UTIME_NOW ||
> -	    timespec64_compare(&lcp->lc_mtime, &inode->i_mtime) < 0)
> +	    timespec64_compare(&lcp->lc_mtime, &mtime) < 0)
>  		lcp->lc_mtime = current_time(inode);
>  	iattr.ia_valid |= ATTR_ATIME | ATTR_CTIME | ATTR_MTIME;
>  	iattr.ia_atime = iattr.ia_ctime = iattr.ia_mtime = lcp->lc_mtime;
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index 268ef57751c4..b1c90a901d3e 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -294,8 +294,8 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  			status = nfserr_exist;
>  			break;
>  		case NFS3_CREATE_EXCLUSIVE:
> -			if (d_inode(child)->i_mtime.tv_sec == v_mtime &&
> -			    d_inode(child)->i_atime.tv_sec == v_atime &&
> +			if (inode_get_mtime(d_inode(child)).tv_sec == v_mtime &&
> +			    inode_get_atime(d_inode(child)).tv_sec == v_atime &&

"inode_get_atime(yada).tv_sec" seems to be a frequently-repeated
idiom, at least in this patch. Would it be helpful to have an
additional helper that extracted just the seconds field, and one
that extracts just the nsec field?


>  			    d_inode(child)->i_size == 0) {
>  				break;
>  			}
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 4199ede0583c..b17309aac0d5 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -322,8 +322,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  			status = nfserr_exist;
>  			break;
>  		case NFS4_CREATE_EXCLUSIVE:
> -			if (d_inode(child)->i_mtime.tv_sec == v_mtime &&
> -			    d_inode(child)->i_atime.tv_sec == v_atime &&
> +			if (inode_get_mtime(d_inode(child)).tv_sec == v_mtime &&
> +			    inode_get_atime(d_inode(child)).tv_sec == v_atime &&
>  			    d_inode(child)->i_size == 0) {
>  				open->op_created = true;
>  				break;		/* subtle */
> @@ -331,8 +331,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  			status = nfserr_exist;
>  			break;
>  		case NFS4_CREATE_EXCLUSIVE4_1:
> -			if (d_inode(child)->i_mtime.tv_sec == v_mtime &&
> -			    d_inode(child)->i_atime.tv_sec == v_atime &&
> +			if (inode_get_mtime(d_inode(child)).tv_sec == v_mtime &&
> +			    inode_get_atime(d_inode(child)).tv_sec == v_atime &&
>  			    d_inode(child)->i_size == 0) {
>  				open->op_created = true;
>  				goto set_attr;	/* subtle */
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 7ed02fb88a36..846559e4769b 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1132,7 +1132,7 @@ static struct inode *nfsd_get_inode(struct super_block *sb, umode_t mode)
>  	/* Following advice from simple_fill_super documentation: */
>  	inode->i_ino = iunique(sb, NFSD_MaxReserved);
>  	inode->i_mode = mode;
> -	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
> +	simple_inode_init_ts(inode);

An observation about the whole series: Should these helpers use the
usual naming convention of:

  <subsystem>-<subject>-<verb>

So we get:

  simple_inode_ts_init(inode);

  inode_atime_get(inode)


>  	switch (mode & S_IFMT) {
>  	case S_IFDIR:
>  		inode->i_fop = &simple_dir_operations;
> -- 
> 2.41.0
> 

Otherwise, for the patch(es) touching nfsd:

Acked-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever
