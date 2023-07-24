Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2AC75F936
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 16:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjGXOEC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 10:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGXOD7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:03:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C0090;
        Mon, 24 Jul 2023 07:03:56 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36O6oTRX011942;
        Mon, 24 Jul 2023 14:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=uvURcC4SIUMTm3KaVSgSkXEh/LjuF44FXrueh0UJARw=;
 b=p5Cy3sCZtJYZ/4AU8jA1gdamWpRs9GvQAgO2ncybNNzEjrAf9SHCxEw9sPgEaT3RlhOu
 W6CgN/7ZuSWstd2kILEYC2TuHlWIvkSBYOuhrF2XO3Ds8bzZ4LEmklQUony5BTqbrkMA
 3W+o8oCksMgCsgtboLc8H3aJMsLtr2BQ5993tssM/2590z2t06bpJknqwv7AOxHHqcMe
 EVJDLXSJcARjbv9VPiAFEdlP0b70pRrRiNO8nYVIg+O+9wT9jJotBxLe42rvAqKAFohy
 cNs4se4FkF4nKdJy9rmSR7XBRP66HysXIJ/ReTqNTOczySzWyDEFgVSs2dSeDJRYioUh yA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s070atrwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 14:03:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36ODSSsK029054;
        Mon, 24 Jul 2023 14:03:03 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j9qwbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 14:03:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFCk09yktfRQtj/4QSSTOGIE+nGAcJKfll9u3E+pwnA2xRG5ttJ0Eb5TqFU85Rwt6ykq0onysFcYE6tLHitVw1hjX0BTCWiw73p0zpNhm79lDjBVWDOHj0FuoBzEQvj9TLUBEk5+EgWg4cyZt3yl2txDQ9cNASc5wKTE5UFDYWsqDJZkSt1o222FEowA/TDj0nkhJpx19nHv1WVr3axhMqhPkdCSeeDqkEqF9vvMXTNU5fDau1cDAY+RZnmZnovbPn+VERs66hOclpjMLJM3Aqk/PXWazjdae4g7i89p3FT6SEOurqF+U7JuG2Io1+PRfY4xzkACajI23Fld/usGjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvURcC4SIUMTm3KaVSgSkXEh/LjuF44FXrueh0UJARw=;
 b=Zb03WcLe2reMnRhI2oRV1dhHa1qo6l1hP3raADBxnrgfzPixyUVXdt5vt1q/XtEzO6My3T41BlIPRMYxIMz+tghLocpO2twojax6diLxbxvHtXe+NpSAJ68etumnBz2fU0vddLJZOAVbWhhKATz97q9HWCADS+6XNawhExvwUxFLG74D6Nh8aXByuP9d9j1bhw39s4uOnQLmw/VralnvfqBvRGYrEJ5/9CBt0mlOjIN0XczWKRc2nvm71E4bzj6ZreqkDSrHUyw4qUvJAtbgf6wz4kR0nx7KWBMXadTXpHs2FsVu/csxaKA8g6qB9JZdiw/TE9nvIrebdfh1XiyT0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvURcC4SIUMTm3KaVSgSkXEh/LjuF44FXrueh0UJARw=;
 b=h7QYl7TNkSKT30ea8CB5jWFo5Fm1n72a7r7q1vhap6+wxLvAVb9FNxAdCqvRE5nckpTqiYkMQMRy0T7CMeeMz+1m3KuyYkgACOgOmnwvwqcukm37Es3R6eSQtPsu6FWnQ6Iw+XEH2idcCyGX0yMmxgXZHG8LznXxRaJoefloR+4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7295.namprd10.prod.outlook.com (2603:10b6:8:f7::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.33; Mon, 24 Jul 2023 14:03:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 14:03:00 +0000
Date:   Mon, 24 Jul 2023 10:02:49 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ondrej Valousek <ondrej.valousek@diasemi.com>
Subject: Re: [PATCH v2] nfsd: inherit required unset default acls from
 effective set
Message-ID: <ZL6EiX+ZI2LuyQ9w@tissot.1015granger.net>
References: <20230724-nfsd-acl-v2-1-1cfaac973498@kernel.org>
 <ZL6AKlkloZQwlmPG@tissot.1015granger.net>
 <8903ae45c4802af9a56590460d2e1180b0f041f9.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8903ae45c4802af9a56590460d2e1180b0f041f9.camel@kernel.org>
X-ClientProxiedBy: SN7PR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:806:120::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e8d0516-aab4-4b9f-3a61-08db8c4eb0c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N3fFezNWyIufRNuUzp9S1ijj/LRE5Jct9AI85kGUcDWPT0gfmpGve/qbxpyZASMrN/RG9ZIxaSUbKQ6bvokj1hXCkuxwe2HBAWGsqmSB3IYUtw+TcFuoPBq3Bc9huTsKRoaXsLfWkGlNqmyXVYYczD8Xnlg+SwdGk65mOqvP6II4aXU4Ffm0qIfQ/DFMW4nRSyemr3mT5zoeBfxAcIotqAdzJ89WoFDonzNOvFoX6+lXy7N5sQ+wKpSSqHnW1vidlg7p1jtxmWSLu2/PWzdKiBwSSo6TjX3HPBFN7TXnH/qa75LIi9uyYqoAyykif27c8SLmFNGSBg6YynOBiNlb2+R5ebVzkG7ZrfRewRtuUwBVIBBJovf10iW7lfUq+3kd9xASx52t9lXDUWCUmAVwdhkYUv2dBnfCBp0BR8L65eDqVqbLeGB7TmCcFcOVvsG4KN2L14gzqbH1aDxT+F578UDpCQlGjrIVWJZwGbEGrNO28dWRPiSH082zNykFEmVl6C/mYuKlPW3tS752dh5UmwpjheekBmixDYNbeurvsXOzkFcUzJPitlhT1ndktgJULyIfGXFXKKXGaKRROXx+2leFDDWP5WtTBxwY9YrK24homuXpduBFXytUCJt/LZLaWiJ8LasO7b2IEiq69Zpgfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199021)(26005)(186003)(6506007)(83380400001)(66476007)(66556008)(66946007)(316002)(4326008)(6916009)(8936002)(8676002)(44832011)(41300700001)(5660300002)(6486002)(6512007)(6666004)(966005)(9686003)(2906002)(54906003)(478600001)(38100700002)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jrqTzd+31ZN6jkJw3PtQJdt1MmHFDGq9K7nyc0Hl5ZVYq8wOie3db0XnEC+c?=
 =?us-ascii?Q?paixfLuN61lUNq5U5CG5QEfCfbFzOVXAE6RWb4qCCnMMxSEu6ZSxIaYL+XBG?=
 =?us-ascii?Q?kh7vj58ZeTHFgPWK59N6d8EZvc6zg9qRQUFdhVdrMMPLC2w4DXBqeleFXnEK?=
 =?us-ascii?Q?Gw3mslYWmEdqs8I833ef+MA9dr2hxLlK9OpEfUy2VNnLKyHs/6deO20+qSSw?=
 =?us-ascii?Q?W+ZInUIKnYxbSqcgeo4dwsz3oPsFjluDgXhE629kkXbgH2t65IcYDErMOw7V?=
 =?us-ascii?Q?YCkyF+CtbfLIcFBCSdJxRz/KVV6Sp4giu6PnkURmMUZKM3rEiz0s0xHR2AVd?=
 =?us-ascii?Q?IVVb/GsYjK+N1chp44kbucqkkeCf1PqTSeL0bzBj13rrbfTSdXhZ3GlsY4lK?=
 =?us-ascii?Q?Pyl2ZjNF25MQBPeH2RZrRNCbgnm/HjwFuO4Lc9W64LlOVhyFfLmj9g21gsAE?=
 =?us-ascii?Q?nfwFTaCa1Vaca/G69bVuc3EL6GgyDH52wYNgZD6zoYcaMgmP9cFDAFqNYB5k?=
 =?us-ascii?Q?twk8GEk/Pk/7e5JvdAY/WLn71BtFpQW/d5mNFLMcws/FCWD7qfImMDnE23Wj?=
 =?us-ascii?Q?fzR5Z2IynqmUoFgNd4rVqV1mq7Gj7obJoNaArOq2/DdxFYw9TsOpNahP3h/q?=
 =?us-ascii?Q?YouMGOUXk9ltYAakzz6MB1y7rxnAv8atdlHBs7MOFqRYUiy8+lp7+n7CK+u1?=
 =?us-ascii?Q?+2+th4Mv9J54mUnG64asK8jCO/WXQdxT5gfmAPcJZbdLImstZo2Fu38e75rA?=
 =?us-ascii?Q?VVN3PRX5Lr6Vw5+wOP9I7fmYZ6sXRirlTmNbFtQD+nQGnfQxW5++dz42PLVf?=
 =?us-ascii?Q?9c0nq81BXuzyvPf126maSPIhQZrepSxA9q+5kq51vIpuCfTbVdfSg9m6DlyA?=
 =?us-ascii?Q?wjffCOerXC8tPJZiIZF0DNWmSHZC5U9oylDUueZOsakbocvKl7jhWbq026bH?=
 =?us-ascii?Q?XCYoYWCN66yQy7LawyqJKhgaLnMYO7LnYpk8kl/Ac+s5f1qyhHC49NE7WHMp?=
 =?us-ascii?Q?Y/e6j6akDLceL2vvom3ADRBmC5r0praJPCuTYVV8mWsm1xr1dcrU/L9umRjN?=
 =?us-ascii?Q?2GQd2y1MQ8qYL+mZS9LowGfa/CPwDwgc3FYyfivYy0ZL0QMNSnfArl7jE1u9?=
 =?us-ascii?Q?IKapBkyB101LO5p/MvASOuEPS5IXfzLErMFVnSHfJBZwaZ4HLZ+/lvjnGkUr?=
 =?us-ascii?Q?CDsL1v24N9MIwDqsO8p2GUqi221zdtk4phRkoqda0Z1cdBv4u8wHntF0YwE2?=
 =?us-ascii?Q?KhxYZK4FP6L9LY9uUkT1UazpoWBtJ5aMWIPMhMAQFSLowfz7Cjib8uk8sX8r?=
 =?us-ascii?Q?lZxmW6LnjJks4m08ni6+IcA2FpfznCekWFSZtDheJcAEjvNDtIqKiPdaHmO+?=
 =?us-ascii?Q?SOslpr+/S12/U/8fYQe1NJarGSvP3yjCIFfAfoMS1EProd5IRzBkrRIK7T4k?=
 =?us-ascii?Q?WVzQoIVav0+UmQcNCpzlGjNEm32hO3VcskelRHirBhErK/teNTluZOBkrcOG?=
 =?us-ascii?Q?9DZbP5rP9he+rDd4HxPR1wPRAZSZ0NzCjv3iWollbeL6Cq5uOL6NZToRvrAn?=
 =?us-ascii?Q?UhZe5kyHUDKcreEKv6scQNIFJujEzuTWDWbRLEnU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?fcCbRuqMGpNEa1lYeYqldr6RLDFj8d+mz4lqm2/bytr4Oa2JUndTDGSxHRRt?=
 =?us-ascii?Q?1gxj3bO/Xqz1E+MINckn8TmoIsnsPLs0wSXrcTwbGVUhj97iEhuhTqHdx0W9?=
 =?us-ascii?Q?QXC4hPg5Nb11RsEzJinJtSTi0XnSvAi7W2/c+HsXpikkVuEAEbqkV26Zia3E?=
 =?us-ascii?Q?jxZBT5SwZNLhbA+Y49u6SAobBs4oNH0P83yp4tbDFnj3rHEqY0smgeUFQFr2?=
 =?us-ascii?Q?6BcfUXGf2v6hewSsUU8aGQXyWPWxYnHb3V+AQhA5VCYiLDdwdzKxnkzAhGud?=
 =?us-ascii?Q?0Q99SRg0EMKpJ6hbhKIOtd0iYIgzDF68m2o9H9GKRMxFgvtcETAuiWUyP4ME?=
 =?us-ascii?Q?8nlFwT1d9Y9t6sLnOZd9h/ccmaBEyvrd/c4x2Wc1Tr9LtXngZYyyzSSTEhpT?=
 =?us-ascii?Q?bynFT+iZGwMA9ypSjcQlyhjMZXOstA0iRMJj8vpQuvles5AnJfQ25xNwO66u?=
 =?us-ascii?Q?UDt1/oSPI0p1Vb5gQivCyKjW45cmKnjhHu2gXx26JkVx4n/sBnqTtp1JgSun?=
 =?us-ascii?Q?9Wvi86mc+rRMkL6IIzl4ydQsBLNG+/tZkaBVJFHkDM4JF6TwFHfCaq68TCp0?=
 =?us-ascii?Q?960muPvsycmHAfyjNBep4pQitxoeHs6PdZgDufNXt/2r/Ah4saR26+p+Si3p?=
 =?us-ascii?Q?GbjrRfbyYs3U3hJRxr1vzVaeD/p3rlcF2T5WIkIC0Y2H7u/xsZOI2nOoafES?=
 =?us-ascii?Q?iGlYN2PfHYUdABY3aVbGdvJ4HuwvgfjMufxSrz2tIIbf3Awkj2kb8qi9fSZw?=
 =?us-ascii?Q?Qn/L9K9MFq56+JMwTfP8rsPU85U7zqf6lugdpGZKiWa27AMdBCpwmqaMj5Ap?=
 =?us-ascii?Q?U+tQZ0KWxqxmvW5F8vQOYFTKebyQthB+QGHnOvH2/9CIHXg/0LOojdsX4Rph?=
 =?us-ascii?Q?2GjV+wcpiPs47Vy2JputrTrV9ndvLQq+ts+ijn4C9ZdYswVbU5m7Frvzbp1f?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8d0516-aab4-4b9f-3a61-08db8c4eb0c2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 14:03:00.5394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iOmMPdMyXzAudirZlPFhix0rvMOD84BIjPpGhKg5uBrE/L0pFaHRfea1xE7+nJxhCRl1alLqG3eZjJWxggQLaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7295
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_10,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240124
X-Proofpoint-GUID: ViDwWp2jrWGwOv3E32loYQmfdHvGupAJ
X-Proofpoint-ORIG-GUID: ViDwWp2jrWGwOv3E32loYQmfdHvGupAJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 24, 2023 at 09:54:22AM -0400, Jeff Layton wrote:
> On Mon, 2023-07-24 at 09:44 -0400, Chuck Lever wrote:
> > On Mon, Jul 24, 2023 at 08:13:05AM -0400, Jeff Layton wrote:
> > > A well-formed NFSv4 ACL will always contain OWNER@/GROUP@/EVERYONE@
> > > ACEs, but there is no requirement for inheritable entries for those
> > > entities. POSIX ACLs must always have owner/group/other entries, even for a
> > > default ACL.
> > > 
> > > nfsd builds the default ACL from inheritable ACEs, but the current code
> > > just leaves any unspecified ACEs zeroed out. The result is that adding a
> > > default user or group ACE to an inode can leave it with unwanted deny
> > > entries.
> > > 
> > > For instance, a newly created directory with no acl will look something
> > > like this:
> > > 
> > > 	# NFSv4 translation by server
> > > 	A::OWNER@:rwaDxtTcCy
> > > 	A::GROUP@:rxtcy
> > > 	A::EVERYONE@:rxtcy
> > > 
> > > 	# POSIX ACL of underlying file
> > > 	user::rwx
> > > 	group::r-x
> > > 	other::r-x
> > > 
> > > ...if I then add new v4 ACE:
> > > 
> > > 	nfs4_setfacl -a A:fd:1000:rwx /mnt/local/test
> > > 
> > > ...I end up with a result like this today:
> > > 
> > > 	user::rwx
> > > 	user:1000:rwx
> > > 	group::r-x
> > > 	mask::rwx
> > > 	other::r-x
> > > 	default:user::---
> > > 	default:user:1000:rwx
> > > 	default:group::---
> > > 	default:mask::rwx
> > > 	default:other::---
> > > 
> > > 	A::OWNER@:rwaDxtTcCy
> > > 	A::1000:rwaDxtcy
> > > 	A::GROUP@:rxtcy
> > > 	A::EVERYONE@:rxtcy
> > > 	D:fdi:OWNER@:rwaDx
> > > 	A:fdi:OWNER@:tTcCy
> > > 	A:fdi:1000:rwaDxtcy
> > > 	A:fdi:GROUP@:tcy
> > > 	A:fdi:EVERYONE@:tcy
> > > 
> > > ...which is not at all expected. Adding a single inheritable allow ACE
> > > should not result in everyone else losing access.
> > > 
> > > The setfacl command solves a silimar issue by copying owner/group/other
> > > entries from the effective ACL when none of them are set:
> > > 
> > >     "If a Default ACL entry is created, and the  Default  ACL  contains  no
> > >      owner,  owning group,  or  others  entry,  a  copy of the ACL owner,
> > >      owning group, or others entry is added to the Default ACL.
> > > 
> > > Having nfsd do the same provides a more sane result (with no deny ACEs
> > > in the resulting set):
> > > 
> > > 	user::rwx
> > > 	user:1000:rwx
> > > 	group::r-x
> > > 	mask::rwx
> > > 	other::r-x
> > > 	default:user::rwx
> > > 	default:user:1000:rwx
> > > 	default:group::r-x
> > > 	default:mask::rwx
> > > 	default:other::r-x
> > > 
> > > 	A::OWNER@:rwaDxtTcCy
> > > 	A::1000:rwaDxtcy
> > > 	A::GROUP@:rxtcy
> > > 	A::EVERYONE@:rxtcy
> > > 	A:fdi:OWNER@:rwaDxtTcCy
> > > 	A:fdi:1000:rwaDxtcy
> > > 	A:fdi:GROUP@:rxtcy
> > > 	A:fdi:EVERYONE@:rxtcy
> > > 
> > > Reported-by: Ondrej Valousek <ondrej.valousek@diasemi.com>
> > > Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2136452
> > > Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > > Changes in v2:
> > > - always set missing ACEs whenever default ACL has any ACEs that are
> > >   explicitly set. This better conforms to how setfacl works.
> > > - drop now-unneeded "empty" boolean
> > > - Link to v1: https://lore.kernel.org/r/20230719-nfsd-acl-v1-1-eb0faf3d2917@kernel.org
> > > ---
> > >  fs/nfsd/nfs4acl.c | 32 ++++++++++++++++++++++++++++----
> > >  1 file changed, 28 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
> > > index 518203821790..b931d4383517 100644
> > > --- a/fs/nfsd/nfs4acl.c
> > > +++ b/fs/nfsd/nfs4acl.c
> > > @@ -441,7 +441,7 @@ struct posix_ace_state_array {
> > >   * calculated so far: */
> > >  
> > >  struct posix_acl_state {
> > > -	int empty;
> > > +	unsigned char valid;
> > >  	struct posix_ace_state owner;
> > >  	struct posix_ace_state group;
> > >  	struct posix_ace_state other;
> > > @@ -457,7 +457,6 @@ init_state(struct posix_acl_state *state, int cnt)
> > >  	int alloc;
> > >  
> > >  	memset(state, 0, sizeof(struct posix_acl_state));
> > > -	state->empty = 1;
> > >  	/*
> > >  	 * In the worst case, each individual acl could be for a distinct
> > >  	 * named user or group, but we don't know which, so we allocate
> > > @@ -500,7 +499,7 @@ posix_state_to_acl(struct posix_acl_state *state, unsigned int flags)
> > >  	 * and effective cases: when there are no inheritable ACEs,
> > >  	 * calls ->set_acl with a NULL ACL structure.
> > >  	 */
> > > -	if (state->empty && (flags & NFS4_ACL_TYPE_DEFAULT))
> > > +	if (!state->valid && (flags & NFS4_ACL_TYPE_DEFAULT))
> > >  		return NULL;
> > >  
> > >  	/*
> > > @@ -622,9 +621,10 @@ static void process_one_v4_ace(struct posix_acl_state *state,
> > >  				struct nfs4_ace *ace)
> > >  {
> > >  	u32 mask = ace->access_mask;
> > > +	short type = ace2type(ace);
> > >  	int i;
> > >  
> > > -	state->empty = 0;
> > > +	state->valid |= type;
> > >  
> > >  	switch (ace2type(ace)) {
> > 
> > Mechanical issue: the patch adds @type, but uses it just once.
> > The switch here also wants the value of ace2type(ace).
> > 
> > 
> 
> Doh! I had that fixed in one version of the patch, but had to rework the
> branch and lost that delta. I can respin, or if you just want to fix
> that in place, then that would be fine too.

I've fixed it in my tree and applied it to nfsd-next. Let me know if
I've done something wrong.


> > >  	case ACL_USER_OBJ:
> > > @@ -726,6 +726,30 @@ static int nfs4_acl_nfsv4_to_posix(struct nfs4_acl *acl,
> > >  		if (!(ace->flag & NFS4_ACE_INHERIT_ONLY_ACE))
> > >  			process_one_v4_ace(&effective_acl_state, ace);
> > >  	}
> > > +
> > > +	/*
> > > +	 * At this point, the default ACL may have zeroed-out entries for owner,
> > > +	 * group and other. That usually results in a non-sensical resulting ACL
> > > +	 * that denies all access except to any ACE that was explicitly added.
> > > +	 *
> > > +	 * The setfacl command solves a similar problem with this logic:
> > > +	 *
> > > +	 * "If  a  Default  ACL  entry is created, and the Default ACL contains
> > > +	 *  no owner, owning group, or others entry,  a  copy of  the  ACL
> > > +	 *  owner, owning group, or others entry is added to the Default ACL."
> > > +	 *
> > > +	 * Copy any missing ACEs from the effective set, if any ACEs were
> > > +	 * explicitly set.
> > > +	 */
> > > +	if (default_acl_state.valid) {
> > > +		if (!(default_acl_state.valid & ACL_USER_OBJ))
> > > +			default_acl_state.owner = effective_acl_state.owner;
> > > +		if (!(default_acl_state.valid & ACL_GROUP_OBJ))
> > > +			default_acl_state.group = effective_acl_state.group;
> > > +		if (!(default_acl_state.valid & ACL_OTHER))
> > > +			default_acl_state.other = effective_acl_state.other;
> > > +	}
> > > +
> > >  	*pacl = posix_state_to_acl(&effective_acl_state, flags);
> > >  	if (IS_ERR(*pacl)) {
> > >  		ret = PTR_ERR(*pacl);
> > > 
> > > ---
> > > base-commit: 7bfb36a2ee1d329a501ba4781db4145dc951c798
> > > change-id: 20230719-nfsd-acl-5ab61537e4e6
> > > 
> > > Best regards,
> > > -- 
> > > Jeff Layton <jlayton@kernel.org>
> > > 
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

-- 
Chuck Lever
