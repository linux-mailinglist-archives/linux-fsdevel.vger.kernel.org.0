Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D10E768636
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jul 2023 17:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjG3PaP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jul 2023 11:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjG3PaO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jul 2023 11:30:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623389D;
        Sun, 30 Jul 2023 08:30:12 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36UFG0wj030150;
        Sun, 30 Jul 2023 15:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=QSwVZTnPZm8fpHDWQGlmF7QMGt44kn9n/whVsS3Kk0E=;
 b=dOflXzud5UFzeapwM+bQTkpcFlncsHlalL592bnYmMwEL8AtXhuEpvf0lybIqZiF7XzO
 +qnwiUJmbBPZRmRKTchuBhyjlxE7lEQ44rdfX2nYzmiqjaAWa69puXg1USkm+PxTluZV
 MdqtGFtKnvN55WVwvFyZQXRMzUEh9a6x85epLvfadds6hlU6f+KOAmhFYEOcz7aag2vM
 Nw4iWxFW+jkmGaoOZar+gynsQv3eg7hKQze3/+5f/f+yoE3NUypysT9B6YY64V/6rh9a
 idEM0coIuCbvleNVUht4meV0AwFpZWl1gMybGwU5Sea42sm+aygOZd6lzcZWjLKR3f4a Iw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4ttd18nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Jul 2023 15:29:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36UBFPKl008627;
        Sun, 30 Jul 2023 15:29:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s79tr6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Jul 2023 15:29:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ga0PO3zycxQUlJqXF03eNCqutfGLU4sRJrBbCNKRY5jWWI0+BuHAfRb98BP7jnQoN4XO9xUx837GILT4ZQaYas+Jc4MHnxdbWWQ2GZOXcvkS/bWucz/uP2HPViVGvLZ36CW4BbZ0wDiQJqfREHfWmFBl6/rtVX956OcMMtyJ34YF7ueFnMET59EqOwFZBdKlx2bB+jrD2k0xDPSlA0RlXbSl4LREELeefZP7BDwwUUSqF9dq9uRN0gWGnG9y9dbadVo8oT8NWx202dQT7/kver+6aPoTsq4Abh7BpX278KXF6/qtSy+66v7rcuL1US/Q7ueRZUhSFGQ0AQxcRcEwSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSwVZTnPZm8fpHDWQGlmF7QMGt44kn9n/whVsS3Kk0E=;
 b=DAp5lAHc/pOnfQoX0mxEKi1HeEwgwHb0JxCMUGPnoMPxPaK4e1oHUHFmKLETLepun1SHpoOrYMvE5OR0JhEFTLFDgPFBpLykHNRtcP15zmpaJKM1HAuUtDXwMy+vn45DG8dwmcvGgrDW+Nf++abO/uwca+yWhZq0prTMoCni9XxipX7MkyJo/mMBdYWfhtHunMktxhI2/9109PePYJ5X+Mi6RXo3Uzujf6OmJSxTgJT/KRgl4hN4FHSn1OqyfBzFn0/cueHpyuiCS3StZWQ3R5b0H4FggJtcR8rU1sopLDz3cw3lfJ89HPJzNY2/Lp05mulDfErcTWKsJnvQZaWjmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSwVZTnPZm8fpHDWQGlmF7QMGt44kn9n/whVsS3Kk0E=;
 b=gRJMw0rjsXH9pG3UuSsg3UQDaPkJ5RDwz7G8w9AkkrtEj7mZIEWIHO/JahiaBc3qOnSPnGCsB81cpcfr5ktC3Vb80WF0VAnadyzwgkaFnUi77U/3QIcxS/GKVuDQOAlX4ap+3cyCLeT5zTO9bVq5vkhOwuxyPTkICx9m3yKPYPs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7408.namprd10.prod.outlook.com (2603:10b6:8:15d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Sun, 30 Jul
 2023 15:29:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6631.042; Sun, 30 Jul 2023
 15:29:35 +0000
Date:   Sun, 30 Jul 2023 11:29:24 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever <cel@kernel.org>, David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Hugh Dickins <hughd@google.com>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] nfsd: Fix reading via splice
Message-ID: <ZMaB1BwBfNko1ZoE@tissot.1015granger.net>
References: <169054754615.3783.11682801287165281930.stgit@klimt.1015granger.net>
 <169058849828.32308.14965537137761913794@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169058849828.32308.14965537137761913794@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:610:77::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7408:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d8fb43a-3111-424a-a079-08db9111c770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S9Gp4GVrBkiHXUGp1XK52Eo6ZnmCslWu8YKKCoimDSsQmayRclWOs6YuHgzlXAM3RAEZDrFK+9EMSPZtVv9vvenf6/NUOHQ7zlXOnguhgzxPU2mwnM6GGF2E+85iaiH8r5Fjj7YwvbDKyCvdSrPb1+GiC1lC8ihr875VJFWYGkcyyVPn7TRj+PLsndnkQtZMU1g2c11CHj1BlSdAULiDqW3nZw1hNQAe0BnLovGDpjehn+ZOv39/AOOzAZ5sPdEPb7IiKkYIMNMaW7dUN0xl5qk6tzmpPNjcBVD7W0d+FDluQhJZusWUm7ttVqpOGgire8Q0Nh2kiPl8FqI2tU5xupRYBHG/4R3Y7LB6cc+4Gtl1HXusvJszZyCvsK++F4kZjFK33aB0ffmvX9BVfar/sPm13jJViPXIYKKodE99hHrAaqJBvHU+jRaA4rKKxa/2IZgSvqYV5vf0a0Us2CMUvkiHn7O4Q2HYuy/sSxCTOvHVM7xJv602X0pAj6XwufoX+yPnFeIpiavmOheEEFq1wZQDDwxVJhUX/ydXc6lebLNcN9u9FpOOpSK63VEl6dZz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(26005)(6506007)(54906003)(478600001)(186003)(6512007)(6486002)(6666004)(66556008)(66476007)(4326008)(6916009)(83380400001)(9686003)(38100700002)(66946007)(5660300002)(7416002)(44832011)(41300700001)(316002)(2906002)(8936002)(8676002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YgfqZeRoCL+rB0nwJ3ts7iZJ9PkwaTh/AoWF8VhjcpJ/FHQHWSOVKPuW2ZK1?=
 =?us-ascii?Q?HzD13Pswj6sn/nMXnNbdP2uY+pPD5/gQc29CkxiDlhlXeiYxepCqPyq1RbZZ?=
 =?us-ascii?Q?ZMkNKT0w4EZv1uLno04t5wQ1Dv6xaK0HH5OmdQD4PI0lKSivJvkIaW3TMxxz?=
 =?us-ascii?Q?vBIvCf6nacjzobPSxT0ogCo7FbM8cAEeO/VrxJjY+/LDVa4+TQm/rEbbFZbq?=
 =?us-ascii?Q?uXPNRoQJtWh+bL1mGN8in6XJeBiMbmHsBV8lrpmP2oCQhYASC8TnEv1x2Jog?=
 =?us-ascii?Q?trnhtirX59kt4gklNKsmiBTmbs8V2gWCfLxlasMotMDLX5HXUxjcVvlouxch?=
 =?us-ascii?Q?mlYkeIxqKqvXHkdDeCu8Isc6AxtTx/eUleliKP3K5oRVInv4HkhmuCc1c5rw?=
 =?us-ascii?Q?tCtBWdMLTKf2MqZTzA20hejE4uGu4gljQk7wK/2ot2dWlex9seLNRSzGCk0C?=
 =?us-ascii?Q?nYNFsyUjPOsW18pAvWa4yHbDj96T2Ohz1WL4paPsg5pcYWJc9ODzBZhzDvAQ?=
 =?us-ascii?Q?et2o2by6YTDowWblvbwnwuZ6+tVdOHDBa2HinGn3KR/J4Nozi7ASxsXrekUl?=
 =?us-ascii?Q?SYAM0XegpyCIJP5lMwur7J8uJpm9f3GLEd1snRVpMHi/2d6ZhO3TrW+t1bKI?=
 =?us-ascii?Q?XnuN4k5xfuAo/sWCvnxGfcasn7KFJ0vRVDwGv2qa1ysPDbuopgsuRHorfXxr?=
 =?us-ascii?Q?P52X4e/Zi2bEqgzSWoo3voGfRwEpw9BcAzE8JGXLeH2/J90c3yVILVQg4r17?=
 =?us-ascii?Q?t3hJYsF64TaAhJMNPZkHt3g0DMfT9a9q213VCam1FSMfVATTjZpoANp12le/?=
 =?us-ascii?Q?PDKEZG3mwlJD5GXwbvzPTheQcAEKk/ZBwqDjSi+tysf6VFvVXLDNsvLwOwVX?=
 =?us-ascii?Q?/hp9gCDWYhiX+ofvFmmYsOSk3r3UN1FCvwM2Hg0q23hIHSK3d7OYcQkFcgIm?=
 =?us-ascii?Q?8t1sd3ugeoJGR+nBHa5+Boft0s/pZxHP1P/43ePvSnMPK1zY4Hf6Ow6Ulg8r?=
 =?us-ascii?Q?ftDw4N11uvpargVpWcUC5ss/8nABsQ6Qq0bjlDFDZN0x+EFhfLh3oVy8fKyd?=
 =?us-ascii?Q?3XAOIGUZj40/37jco70XdOunp0cNeSd5cgU/v2vTXKZCb8VxB+NwpsPvN4xm?=
 =?us-ascii?Q?H7iClxES/kd+OrFEbe9MWM03VpHvp0dfm5wjiZJSnuGiaMLyk6hyldaXxmC1?=
 =?us-ascii?Q?rkpNDjB218R7yWI+YhkvgzHMWirkeUXR5mCTzhmFh37Qv+ii4eSicdV7a64R?=
 =?us-ascii?Q?TsqSsF3blfSa1sUe7S+cOQ8m4CFKKYV1yproRV4TQBBG68HR4vPUIQHd1Y59?=
 =?us-ascii?Q?DqUVqT5iZHKKHWhSQAScDYvdudCJgqJtJdpeRc7LHlqmWVwY9SphzSRB9lWc?=
 =?us-ascii?Q?Lg02dVn3vCMr+06n1FCK36bk+ko+HD+21w9lBGidab3ZmdQx6oj66vHtGH4B?=
 =?us-ascii?Q?i7FPQ+gOAWk5beCaQI7LS5wG+5iYhbPzdf04SZOy5st4aSIErzHQTdORRcD+?=
 =?us-ascii?Q?gqPKc+aYCln5qOKRjopvvbLjnIUVcofECGcTJUtUJj02kzxXBYxzBMCmXwbt?=
 =?us-ascii?Q?uxkXdZe2ZD90bvZWpSmZFykWw6erxPkUGN9IO2vXnUfS8B3/MPa1pht6iO07?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?2tiF+8jsDaNff7GaHGzEktAo9GlmfvyPC5jIk+dr1Ys7RIf0z/ie6JdW15xy?=
 =?us-ascii?Q?PSGake1jDC/t34Qh0hAD6udbbupHJN/LNij6cT8EN/uC0gt96HlhZlXaH+Ru?=
 =?us-ascii?Q?DFsF97VhrIqGRx+AtZ+TFzGQ+LW8k8Dk7g0JJjWvDwOK+yWk+GXm8IoYZe4+?=
 =?us-ascii?Q?g2SyvwfmGYfEYKd36cFMcGHYplHyTRRCRczshBiVBHMdKQ/MgeJ1xuBRvBdR?=
 =?us-ascii?Q?pRQJRLNaFWeRObV6f31K4PEHj9gx3InLcfRy12MroBspHpE+BGxusq61zeqX?=
 =?us-ascii?Q?Zj54VDGICa+aVi+EBsKIxqS4ncIn9ELKwDMZRGgDaD4qy9yTgX3ubgdCewQ9?=
 =?us-ascii?Q?6lgQUHVHAsRO6f8v4Sk/gqu7s0X95HN8YQf7zqLOOTuZxViDQ8taFVAdnZAQ?=
 =?us-ascii?Q?r2XYBqbuYLAjW/G0BD+mGsr4FWA41HTLDSy0Gz5Q6SFbDK2+bO48ajDxS1NP?=
 =?us-ascii?Q?AHG772PRwbu43p/A9V5D7ZC6GQAQqdAm4+PgUg63GWTzwqQQ/hiX/vVpDA4k?=
 =?us-ascii?Q?CB3ucW3QxyF/BCXAluJSFiHbJ3YBx7DEppr19/qzzxGiVzj4Dx6wLyI91Dyw?=
 =?us-ascii?Q?OLPTDfi2iyEaLPA7pEB+kdjperBg8l1cPkUqN+uo9mimRchitbae2cO34TQJ?=
 =?us-ascii?Q?nS05U1IIwMmXyUV1rI9WKvAPhP/iuRqpqNyn6vUFziPuKdLgdjF7UPO11hxg?=
 =?us-ascii?Q?u9lndczb5UVS2SGz6yzadfQSkrROR5br64aB5gkQTQ86dWNY8DGv7UpWOhec?=
 =?us-ascii?Q?QmTNJg2LMR5Vl0RobkuFyjESNDT5E4zTpqdLLgPXpUNOx4OVlkTPwDkU70yh?=
 =?us-ascii?Q?UiVxG9AmNZPXp1rS7aFR3JxxTVTkT5x5W7U/F7yFgcZw3zPB5q6HaIGQg80L?=
 =?us-ascii?Q?VB2QyMCG2WWr+B/l9iSL/a3F6EjrBnGr122Sr76GspL7ipcaMqgYyzDAsXyb?=
 =?us-ascii?Q?uzZvxx/xxuUJOoB2dK+Yqg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8fb43a-3111-424a-a079-08db9111c770
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2023 15:29:35.1568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wC3/MNmyAato0fq5z3J3RDw4sOHLNYGv1B7/kNSU61xARsflq1WhQVn9Qvv5GYFw7gWJfZqbjOroKn0t0YJUzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7408
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307300143
X-Proofpoint-GUID: f_jklbPtm1J0YFqZ9UT_8g9VunDDI65K
X-Proofpoint-ORIG-GUID: f_jklbPtm1J0YFqZ9UT_8g9VunDDI65K
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 29, 2023 at 09:54:58AM +1000, NeilBrown wrote:
> On Fri, 28 Jul 2023, Chuck Lever wrote:
> > From: David Howells <dhowells@redhat.com>
> > 
> > nfsd_splice_actor() has a clause in its loop that chops up a compound page
> > into individual pages such that if the same page is seen twice in a row, it
> > is discarded the second time.  This is a problem with the advent of
> > shmem_splice_read() as that inserts zero_pages into the pipe in lieu of
> > pages that aren't present in the pagecache.
> > 
> > Fix this by assuming that the last page is being extended only if the
> > currently stored length + starting offset is not currently on a page
> > boundary.
> > 
> > This can be tested by NFS-exporting a tmpfs filesystem on the test machine
> > and truncating it to more than a page in size (eg. truncate -s 8192) and
> > then reading it by NFS.  The first page will be all zeros, but thereafter
> > garbage will be read.
> > 
> > Note: I wonder if we can ever get a situation now where we get a splice
> > that gives us contiguous parts of a page in separate actor calls.  As NFSD
> > can only be splicing from a file (I think), there are only three sources of
> > the page: copy_splice_read(), shmem_splice_read() and file_splice_read().
> > The first allocates pages for the data it reads, so the problem cannot
> > occur; the second should never see a partial page; and the third waits for
> > each page to become available before we're allowed to read from it.
> > 
> > Fixes: bd194b187115 ("shmem: Implement splice-read")
> > Reported-by: Chuck Lever <chuck.lever@oracle.com>
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > cc: Hugh Dickins <hughd@google.com>
> > cc: Jens Axboe <axboe@kernel.dk>
> > cc: Matthew Wilcox <willy@infradead.org>
> > cc: linux-nfs@vger.kernel.org
> > cc: linux-fsdevel@vger.kernel.org
> > cc: linux-mm@kvack.org
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfsd/vfs.c |    9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 59b7d60ae33e..ee3bbaa79478 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -956,10 +956,13 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
> >  	last_page = page + (offset + sd->len - 1) / PAGE_SIZE;
> >  	for (page += offset / PAGE_SIZE; page <= last_page; page++) {
> >  		/*
> > -		 * Skip page replacement when extending the contents
> > -		 * of the current page.
> > +		 * Skip page replacement when extending the contents of the
> > +		 * current page.  But note that we may get two zero_pages in a
> > +		 * row from shmem.
> >  		 */
> > -		if (page == *(rqstp->rq_next_page - 1))
> > +		if (page == *(rqstp->rq_next_page - 1) &&
> > +		    offset_in_page(rqstp->rq_res.page_base +
> > +				   rqstp->rq_res.page_len))
> 
> This seems fragile in that it makes assumptions about the pages being
> sent and their alignment.
> Given that it was broken by the splice-read change, that confirms it is
> fragile.  Maybe we could make the code a bit more explicit about what is
> expected.

Indeed, this code is brittle. This is not even the only time the
actor has been broken in the past four or five kernel releases.

IMO the problem is that there is no API contract or documentation
for splice actors. And as far as I am aware, only a few other
examples are in use to learn from.


> Also, I don't think this test can ever be relevant after the first time
> through the loop.  So I think it would be clearest to have the
> interesting case outside the loop.
> 
>  page += offset / PAGE_SIZE;
>  if (rqstp->rq_res.pages_len > 0) {
>       /* appending to page list - check alignment */
>       if (offset % PAGE_SIZE != (rqstp->rq_res.page_base +
>                                  rqstp-.rq_res.page_len) % PAGE_SIZE)
> 	  return -EIO;
>       if (offset % PAGE_SIZE != 0) {
>            /* continuing previous page */
>            if (page != rqstp->rq_next_page[-1])
>                return -EIO;
> 	   page += 1;
>       }
>  } else
>       /* Starting new page list */
>       rqstp->rq_res.page_base = offset % PAGE_SIZE;
> 
>  for ( ; page <= last_page ; page++)
>        if (unlikely(!svc_rqst_replace_page(rqstp, page)))
>            return -EIO;
> 
>  rqstp->rq_res.page_len += sd->len;
>  return sd->len;
> 
> 
> Also, the name "svc_rqst_replace_page" doesn't give any hint that the
> next_page pointer is advanced.  Maybe svc_rqst_add_page() ???  Not great
> I admit.

All reasonable suggestions.

However, I'm getting ready to replace the splice read code with...
je ne ce pas.

- There are reports that splice read doesn't perform well

- It's a brittle piece of engineering, as observed

- The "zero copy" read path will need to support folios, hopefully
  sooner rather than later

- We want the server's read path to use iomap when that is more
  broadly available in local filesystems

- This fix is destined for 6.5-rc, which limits the amount of
  clean up and optimization we should be doing

I'd like to apply David's fix as-is, unless it's truly broken or
someone has a better quick solution.


> >  			continue;
> >  		if (unlikely(!svc_rqst_replace_page(rqstp, page)))
> >  			return -EIO;
> > 
> > 
> > 
> 

-- 
Chuck Lever
