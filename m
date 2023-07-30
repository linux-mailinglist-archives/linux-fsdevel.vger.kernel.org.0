Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0093C76868F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jul 2023 18:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjG3Q4J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jul 2023 12:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjG3Q4F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jul 2023 12:56:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A915010C2;
        Sun, 30 Jul 2023 09:56:04 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36UAEQLv004393;
        Sun, 30 Jul 2023 16:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Q9ZUIT1iO+MuMRYHr8siU7vWoEa0y0X8JBKxxx05Kds=;
 b=hkAgEgIsdLy7QeBPIIlwYEky+r0cfVOu8S/K2yg8IWVFk1Rbe9ydxZxpdzbDOMbiNygM
 9lHCA/usb6DsM9fCkAuZYJpMPE73H+o872Z0SYV8TZntKkQMprAwvgLDP7olpUr8v4h+
 gBpnfQlkdfqeV7nxY/4uONAls2MLQOjXpgNGoujeQq+nnomljJ4ceinqgb5tdmo4jixs
 Kxh1yn65AB2AEp3qYTDunqr8kYuJTFKlx+d8KYuhBRLqZwI3jnee8j9DNZQaznjGBXAI
 erx8IRa2KfEkkNjTAW0Lzpawg5b8cTxIusRtOfeUjNFjKjpuanmG3jDMAqcGe758P6Nh Cg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4s6e1av8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Jul 2023 16:55:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36UG5Pgp008734;
        Sun, 30 Jul 2023 16:55:45 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s79w2ek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Jul 2023 16:55:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fU6G47doIh1pA6efCMifu0jmaK5T/Kuc/RzgIDyCTqByNeWHVP8A0Ln2QbER0VPaCms42Whk3skfVnCdtH1chZa/h7Carji4qJXb4mBrAPGn5XTbUmJuCnCAi39ECr0VSnSwhVCuUCndoYwX8GWjcxu8grLCYPDh3ACN/dcMg4KGbYSXtt/LjeLykXfA6XEdVa7f9KI6K57glsOo82nAeUCpUjhFyJUXiEq44NrIM8kwPpO2eGVDw+yvF5lRGYPTWhKkGsjzogjx8PDFmBI/HQnfRh2QlWYclHKHG2iXztDPG81ABGpmvlRTNX4xasi5BSLlL11NFTMqngMfwlNSWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9ZUIT1iO+MuMRYHr8siU7vWoEa0y0X8JBKxxx05Kds=;
 b=XZKakaoDYTU3eIJY3WIUKM9bMo9fQ5xGvplLbjatZHasBg4d3M3ahfI15mEQJ1snUfk97M2MjjhM4kYFc52ZDxUmI7BnM1k/7Y+JESvf3gt4oZN2UdaJJHMJlNQ+NOWFt5m6som+rZ0xcbLqIJEU+CXoehsoEz+GT4E8EZuoKadXEGpoWVh3U4ENYZk0elVvO/RnejdK4Yq0YijCFB+raglBqR6OqxPE0UrHDvgA/trkNhZVxBkpN976eX+X2kRHlksJuT6jjl2lYXxSgaq7z1I9fBcmCWo1F6AWiN8/kg9rJa757hEDwUBfSMyR0LWoxPFAyqiIf3bhyfmNLwNr5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9ZUIT1iO+MuMRYHr8siU7vWoEa0y0X8JBKxxx05Kds=;
 b=TG/piX2Z9D5qz1x22i4dSdO2Wc59PEbDg0s52quRo0s8vnvj/VWn9ZZuvoXOUk9XxZSGY2V6nzK/dKLlxoswKMjbV4K2ctKALzRTzaNSspITsijggnawIfWx6RujQ5LoJyK+Z2rjQj99o/ybjeR6k8XlHnpZ0zfEWDkKT9sPf5Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4679.namprd10.prod.outlook.com (2603:10b6:510:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Sun, 30 Jul
 2023 16:55:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6631.042; Sun, 30 Jul 2023
 16:55:42 +0000
Date:   Sun, 30 Jul 2023 12:55:39 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     NeilBrown <neilb@suse.de>, Chuck Lever <cel@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] nfsd: Fix reading via splice
Message-ID: <ZMaWC23FXQ/C4rng@tissot.1015granger.net>
References: <169054754615.3783.11682801287165281930.stgit@klimt.1015granger.net>
 <169058849828.32308.14965537137761913794@noble.neil.brown.name>
 <ZMaB1BwBfNko1ZoE@tissot.1015granger.net>
 <3082a8da-4a13-de28-ed50-8aa2e7a59afd@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3082a8da-4a13-de28-ed50-8aa2e7a59afd@google.com>
X-ClientProxiedBy: CH0PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:610:b3::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB4679:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d011b71-3135-46ca-c631-08db911dcf71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7yvUrOyZ1ntq/HvZMjYJmBYyIRfSEcXa0O9AMwthD0DSd8CG2zLvHb1MshsZDLolCh5wP0ZQ0FvyzWUpc5L20WD9dGRrewE7f0Gk8b5RqvzTMB5b44kuXAQ7fhHLugPobxfgRifRyuWK38ItLuRiU6BZjczTB+Jgljhf02sld8JNPYnxmbopSE/+MppAcVb4WQUX0QruVGtyChoMzN0ilCYY6pI8r1R1FE2OpLZkNJrlBs4i9SlDGfRH7gltAwY1xgkHT3W8e8BqbiU/fQKNfV5cCvdy/Bm7sQA2MQeWoCXpdlujWZw+ulFmd/mByphvXZCqg8Bfch+eh2aqE6eVIpnQf6FxZPKS8rR37KIPUCKXZ79xIWHX8YFeMnte0efmydymjmWZB0KQXeZCSCbRFqFGObT1JI0ge9cafDXhdC+1/swRXcg0/WCCPnui9cx5qW3BYj5+m18zg1IYG9Sn7S5bM6oERb2zfkFlR5gn3JYON96n6KyzmMD8C+IkriYEuatTg/QtQbPf4g/qqHBv0G7vsamP+kSm2qNg7xGBynK4K4vnn2/1kj5UL2pAWkR/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(39860400002)(346002)(376002)(451199021)(2906002)(5660300002)(7416002)(8676002)(8936002)(44832011)(316002)(4326008)(6916009)(66476007)(66556008)(66946007)(41300700001)(26005)(6506007)(186003)(38100700002)(83380400001)(9686003)(6486002)(6512007)(6666004)(478600001)(54906003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0l5C2GtEcU11mu03OVLZRSnVCZ1WkKleUwbUexR5UYwl92SEqabGGne1eu+0?=
 =?us-ascii?Q?vwQg7gTcCNsZdI1pnUKySGqcUG+cOFxSPO1qud+/B7v6yUYhxdIhlDsn0Dv9?=
 =?us-ascii?Q?A/iLKWG8PLWTQa/Frn1CgIH9abt8dtY2lQ25FQJ6osKB9dM9nCThOt0/rg9y?=
 =?us-ascii?Q?d0YN8+8tiv8ckV7y4RdUS1k3cdoG9/9AwppeRNOIbrzqApjz1csXXd8tVVF+?=
 =?us-ascii?Q?1vZIBnc+N6dZOKZjJKxznt+HeyKTrxQVnHp+T3o1ERRZnw9eIneSnBCKrZzQ?=
 =?us-ascii?Q?N+yOaHcolXk+/RswRowD4X6PSTBATZb/Qi989nM+YzWW3zuZCEntc8Bfgcye?=
 =?us-ascii?Q?Fu191uYBM8BxBh8oPlFqKhVs1xteG2Dvkq4HmD6jFaZJ6lLSHT9fcHtZ6bOS?=
 =?us-ascii?Q?43sly8xGjUqgYJ6a09YI7prYv1n0WR2m4Ka7fw5NABwJJ99d4aDj+ypOv4/B?=
 =?us-ascii?Q?iSN3M2tmkijkY5r5ge2cxs08/bMhs/8ERnU9GnVT16Rm5J/owELuvtR++CAl?=
 =?us-ascii?Q?NiDxElUKWAbYSuiLO/1JmYHaR8D1jiYe1kWBTBbFAAZAyO2dFSG887coHB9c?=
 =?us-ascii?Q?o64/+rU52iDMn5oqm4dv8sGzYHlO1ThzkJ9vR2u8S9WCrST0ZQ/cZTX5QfUq?=
 =?us-ascii?Q?WtUjGaBGktm8DGr8WWmOUEJnRyc+7Jy5W7cgc8sAtskNfRVwMqdElZf6FVLA?=
 =?us-ascii?Q?1MJQemTX05qa0wzgD/hLy8vNPb59g/9CfKtT1iruPZCctQ/YSy5ooO9bl2V1?=
 =?us-ascii?Q?BhIJBitwii/lp2J6pbAoHkGhzhB/HhsnUfXFDkIADopzCnoo5hC+A8d9cUCP?=
 =?us-ascii?Q?5Wj/vIs3nDGEADKA3IXoBDfnZdzNljqBI5RNoADKgYm9TjV9Vxsk4043zA1d?=
 =?us-ascii?Q?bCeixaXOPPFs96h/em4xoBYmiBBWjSvbPUUJjcNDjqCGkNDLOqqFNO43c5mc?=
 =?us-ascii?Q?KzpRgcP7GkKJNNLxKbtVq0kYvytGH7I7jzIzUABlK/gAEKEfXqrXQXxVDLdG?=
 =?us-ascii?Q?TUYbu+ZCN26zNIwIl+ypy6Lg4dAcw3Tf0ULgdHCCvO0NEnTpJz+rmYY7stme?=
 =?us-ascii?Q?sXjKw3wKQCfMUezsjXIxyoe0Rw2thFtTD92UhwR1ZxCX6lUQb/C5oTujIgR7?=
 =?us-ascii?Q?GzbhSBPBkUjhvqHtWafYTZRBYGC2hdHQHIbw/ZTonu3KFGgdGt2RMxhgzK/Y?=
 =?us-ascii?Q?Q1s7SBsn/o5fBDHjFNqznNrIjXDCGR4YO3VCEjJ1HVijDt2J/xxfegYTh6gW?=
 =?us-ascii?Q?9Gp4BRKX90//rcrISoIO/Xczkb12ArAnxp6dzo+g6AB5DTRHN9G/QvSsGDb4?=
 =?us-ascii?Q?k4rBx6QzL8kTpDfaxxHBrK02eOOZJRLT2IKbs0MW7OdlUqEN3Y4h3Zm1iwL5?=
 =?us-ascii?Q?zqy36poZVKjFzM4KhB6TAlQb2Lclk1XkupROeUtSmVqkaB6nr7yvKRUU4CB/?=
 =?us-ascii?Q?s/0802YAYqD1kgyLRQncRlQ0lBd5a4UF38jGKnlma8b8lORw6SAknTdJMsyq?=
 =?us-ascii?Q?xofECbhJDOv15afwYjBVjms1DkDH4BCTbq619hXYsl67PiKnp8gbcHt6u4jR?=
 =?us-ascii?Q?069AwPXJn1LIj75O1iZj1dM8RGX6a8YOG16hR1hhZM5LkocSzztgjNVACzHh?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?QCHSe3paoOL9jKD+9GqqeYftecly04ASfjUwgdJXlUMJSTjVooVnQLfZ1RSd?=
 =?us-ascii?Q?YEjtCUINjexJc8vqxlvPe7T9EDCqpCpYGtTlQlYtXrAbgx3S9t1xKFIj6PI8?=
 =?us-ascii?Q?HzA9igM5tiBy33rEBE/DqR68m6C7ANwLasNazl0llQp/zjF1gB+nZ12SBk9m?=
 =?us-ascii?Q?9wYDCcFrSAwmmrdH9WE5Od+ipfeAyPha/tn0eH2wiLhdPUVPFiqkJE3NfZZC?=
 =?us-ascii?Q?B2mbrX/GbugGJzHhiaGIil56quRWewM4aULaEpI3jZvLE/eYkKi6vR+YdJwW?=
 =?us-ascii?Q?9uyV+sBZNhrosSYXSnCLCoJw7Nqzyhq3hOQmdE+1P0VUO/KOY9xBokKtQ4We?=
 =?us-ascii?Q?y7u0boGKg8W7AXm6zi680UTZkEXq+wPNXPHSTpvNY/dQEvIz12szZSgQNXaH?=
 =?us-ascii?Q?DVvh7HTP3CrILKj/eOhn5ZzYIahuDUOM6k+mIORTCd8SpRdp2OAJAs82hw9/?=
 =?us-ascii?Q?Xkm2rl6AAGBtsW3jUNnMQnFmANrpqTehfTb80bIIOqSzZ3Gf8ct1vwzXjfP/?=
 =?us-ascii?Q?pMRXrMngkL3FXq4+dOhat2lFAwIpu5lLFsR8F4nynF92BBpPG6mo+LH8Z/xg?=
 =?us-ascii?Q?YR+k7I44PqXFcriMQE2tLgaMOcS4kFt7M/tEEdfyVmNo7smKQDo7mc6U8F45?=
 =?us-ascii?Q?B2zD//T9UGtqkhugcQiHikoZ2/Zz69AMIorY1na6o2VON0xT1k6skZAG3wWY?=
 =?us-ascii?Q?38pNZPAoKcl6OowY9BpP3qK3ipo753ow5sO2jCH6Ar0LjDI6TWeSTWIMa/XS?=
 =?us-ascii?Q?KPyhz7C9041Kq9ztpfBrugmyt4L2DIsUW3+TYs+rSIrAFiEhdpeLIJtEoKOE?=
 =?us-ascii?Q?P1whhvieUprKS+FHtr8opLs69jiHBi+/iok11xO6DELzbwKdTCaNqPP+ZLTu?=
 =?us-ascii?Q?r6+LMBUkjHHWGsjNUMM2/Yq3AgUmZqX2+SKHXKL0SilO2Jsk6cXG1o+lsXaq?=
 =?us-ascii?Q?OhWhBgvnBI4f72RuA79DKg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d011b71-3135-46ca-c631-08db911dcf71
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2023 16:55:42.4826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1IHx3uWU3sMdv7CzoBz5cpUwlC9EDybnUg1Quo49LXfIZNU19KDoYW8Q8d5hxp6u1VDI5vYl850SFf5Z4pk4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4679
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=943
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307300156
X-Proofpoint-GUID: PuLXP-tAd48jHwPpgPSSM5k684fMvCeM
X-Proofpoint-ORIG-GUID: PuLXP-tAd48jHwPpgPSSM5k684fMvCeM
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 30, 2023 at 09:50:44AM -0700, Hugh Dickins wrote:
> On Sun, 30 Jul 2023, Chuck Lever wrote:
> > On Sat, Jul 29, 2023 at 09:54:58AM +1000, NeilBrown wrote:
> > > On Fri, 28 Jul 2023, Chuck Lever wrote:
> > > > From: David Howells <dhowells@redhat.com>
> ...
> > - This fix is destined for 6.5-rc, which limits the amount of
> >   clean up and optimization we should be doing
> > 
> > I'd like to apply David's fix as-is, unless it's truly broken or
> > someone has a better quick solution.
> 
> I certainly have no objection to you doing so; and think that you
> and David will have a much better appreciation of the risks than me.
> 
> But I ought to mention that this two-ZERO_PAGEs-in-a-row behaviour
> was problematic for splice() in the past - see the comments on
> ZERO_PAGE(0) and its alternative block in shmem_file_read_iter().
> 1bdec44b1eee ("tmpfs: fix regressions from wider use of ZERO_PAGE"):
> ah, that came from a report by you too, xfstests on nfsd.

Yes, I thought we had visited this ZERO_PAGE approach before, but
couldn't put my finger on exactly when or where.


> In principle there's a very simple (but inferior) solution at the
> shmem end: for shmem_file_splice_read() to use SGP_CACHE (used when
> faulting in a hole) instead of SGP_READ in its call to shmem_get_folio().
> (And delete all of shmem's splice_zeropage_into_pipe() code.)
> 
> I say "in principle" because all David's testing has been with the
> SGP_READ there, and perhaps there's some gotcha I'm overlooking which
> would turn up when switching over to SGP_CACHE.  And I say "inferior"
> because that way entails allocating and zeroing pages for holes (which
> page reclaim will then free later on if they remain clean).
> 
> My vote would be for putting David's nfsd patch in for now, but
> keeping an open mind as to whether the shmem end has to change,
> if there might be further problems elsewhere than nfsd.

I'm open to that.

-- 
Chuck Lever
