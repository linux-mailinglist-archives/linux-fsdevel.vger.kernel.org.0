Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389F27A2458
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 19:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbjIORLb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 13:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjIORLF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:11:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C687E7F;
        Fri, 15 Sep 2023 10:11:00 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FFiAHN018245;
        Fri, 15 Sep 2023 17:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=uzx7tFOZpAkJCOqelj+OTDZrWAC6uoeJb2/aWSHJaaM=;
 b=qwFaDiCM9XjfAb3oLWGD2n9j2JokFgM0cUkdg84OMG9u48TYauyQPLwRtukIHJm1Xtzf
 YglnWk4dH4Aq4YnaAUwzeIhf9A1ihBqFZEbr5qAXDNyq2HhKEVdFbPev6SkjT7N5dyDW
 OWS8M0uP/pHaxigkM3zNJjhuhQxzC+/3fKFgL2hcll+ti7JwBj7bHIlOR+tTIQibRWce
 4yPNAtNRtK/OtwOsOe92W1tpaAUK5RZXQtxApt2Y4dqtoL49tYrXDnZQ19ULBjSWRR1p
 APRRzeU7Y/Dh69Ph+jrKXLb+ivGkRwBmPTjOJqundJMwsKhbGnHBUXnxyiuhFklHyKci uQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7kr4xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 17:10:07 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38FGC66V007339;
        Fri, 15 Sep 2023 17:10:07 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5b3k7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 17:10:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRmWlqhaRDI+qcGaibjtLVsG5ASN5Qv01KHM/f+TfeYF6pngiolSSYrvMD4tan1IubQ8s3XjSP+46z7HmpwZ/6xFAN263yT77/RLlttzwzxeq3LDFFvfJcP7bST9NTtNxhOqgSBqHpPB3D/kbNzVdhsT8SS51brBHQgJonVXsz7SjcNfgP6H8BDJC9rAhoP4yKC02XXKG42BHywT2ve0tUQghyLDbu8+LUHqwrsfoP3jPDBHanyXHG03HRm+fYTBNLrDVFusz2SwnhwpLigMSN+oA0lBA24lTn9IWON9m7CfTKNyP/TzN4tzsmw+emU4yCNIMMeLnT8ths9tq3c+9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzx7tFOZpAkJCOqelj+OTDZrWAC6uoeJb2/aWSHJaaM=;
 b=Kv/Juarvp4UPqB6wiGoUprSFRYx1YMUgpyaOg17PXbLIm1JFonEKGy+EH+GLevLrCo2F9mUvhrh+mlNquIoxQMNYkimw+xFFHIzpwq0aaWZtIA/GPwYnEsGGQtonARKMLBZeoPxSc/ldAjtCY0pyEnEwjEzefm64tDOS3kcj3InPzsZsCFdHmHAvTTjfOSbvEcG0420bTYxs8313GBKO4grrvhz0vmQ5Aiafa9b/qsxKZxHZs7APm/DtrjyzzBGzPYyiOUGA2S7VIimtYm3yhFuoJmbC7bxA1ZKmsibJ+8W3ffVVEimMUK3QpaDcPj4T9IrpsrVj8yxQSEOs+Z54lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzx7tFOZpAkJCOqelj+OTDZrWAC6uoeJb2/aWSHJaaM=;
 b=SMWKhLuPt31TrNLznq0LWobj5LW0rOaJnPpdnFSr4DwTLjmE282wf5oiXtHYaX0lC+KqhO0lhdX653YnGxFIkDwg+GJ5BsZ4z7Z4HeZ9Q/gXbkJDFanZcgF6fQo7uNtXelSDC8MJ/F4ahRju1gP+yJv5brDd+bLK183rUmjwV2o=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB7515.namprd10.prod.outlook.com (2603:10b6:208:450::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 17:10:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 17:10:04 +0000
Date:   Fri, 15 Sep 2023 13:10:01 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH] proc: nommu: fix empty /proc/<pid>/maps
Message-ID: <20230915171001.qfdziioluxw4hojr@revolver>
References: <20230915160055.971059-2-ben.wolsieffer@hefring.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915160055.971059-2-ben.wolsieffer@hefring.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0032.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::7) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 8efa7b23-6460-47bd-5118-08dbb60e9a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e9b5U5Q7EtzIe1lTq+6I6vwY9Kf/C1NcCTZEjJPE+Hv8chaK1Af/+wVwuudFZL6PAeNcp/89WrTgJoVzXNeac1ndwCqR/oGsHPsS0lcm9NAWpuwh/B1DaziGK3QMzji9alL0Q0KJnl0/1CrpSxFvz5s1NlB419egMSWHEw53Dw+xPfo0Dlp9AoX/h7V3OYiT0riBg/XZBdcnk6sRWiUko26b0qd1djJ+F3NttPkil28SFUMiBzKWs0eBGq6UFg31XGtuu/faR9jrWLg/KJMhVvyfpWWWuDhj9k0mPTuLGVPZuRO1x5BWsiJkbFdOZ/u5oe0eMkLkGIZkRxTZ30e7UCbOLfPCfWpqm3wPPPn/JZWQWldXYBxB+7zdOySJYsp85zEOWGYrHDZXqJEx5qEu9oVY6Fr4xhbDqzQblSl0ZNG4i3fgq+vYNKXsTlihRxLvqbAcoucEqdCme7G1FFZnl1B7BajHFkLP1aPYs45AQ4ACbXa/tQ4I7Gh841qdm2nFlzpTyAqQ+MntMi4Qu/53x32g/2MpICu7SFqH2Swckdg8upYm3I9haBKjjaMqcRT9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(39860400002)(396003)(366004)(136003)(186009)(1800799009)(451199024)(6486002)(6506007)(6666004)(6512007)(9686003)(478600001)(83380400001)(26005)(1076003)(2906002)(33716001)(6916009)(66946007)(66476007)(66556008)(54906003)(316002)(4326008)(5660300002)(8676002)(41300700001)(8936002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g4FdraKVdd81R2mo6myGUDd/Ps412HO6MoFxjD4Yak/bHZyhUMaHi87blaQu?=
 =?us-ascii?Q?4POfQE79pfOh3JDeVLDpw+PpKfaGaVOM33kM3EXPyGvSHmuTy6qYsPCQJekZ?=
 =?us-ascii?Q?8xsdAo9tTZ0rGOIfjVbnMzz9wH/Hhlh/o4Pg7SC2pYZGtRazCO7AIe0a7Ba8?=
 =?us-ascii?Q?FF1PFeeRKAsCXDOC1NWs/JYKgBEn3R5yxrWTLynOWcgSo60sHTcRKjiTKTer?=
 =?us-ascii?Q?BObIBdEpm6yTyKVSxJrgIr/GrC3PhHXw0SHhdX8jcrMxsVAH/F9GaJOdIPv1?=
 =?us-ascii?Q?CfsuFguXr4QBRouGB37C6kuaEtJkCi4G8sa/zK3xYy5ukhuRc/57WrXL2Q+w?=
 =?us-ascii?Q?JN0NUU+rsMaW58pvpX1PKAmqJTjS7LCeqf6UgLgb16LKLB4k/aa4ejCYVh5z?=
 =?us-ascii?Q?u/WtaB6OkHbo1xsRVdQEW6A0GqI0SnemLv2MVE371J8FCwV1XhCGDFNGvkU8?=
 =?us-ascii?Q?NvNc0d4y5AQI+w84sNsH++XRkxjQBoSkJjdqALRXy8HO7yLjUkDOIqR5/vhB?=
 =?us-ascii?Q?L2VuVBBFYDcExyXWywSM+xwfGtYao7Ym1dgpT/02wz8hgsWSf5hv6+VK1BkS?=
 =?us-ascii?Q?MDdZQ9uF+9jRhx01pxPf8zHpCBJlOnQAAsfdk+Goa0mvLxHFOF0Y5QOHwwXi?=
 =?us-ascii?Q?HCEDm/DxQNH86zJzp/h5AaRFCmkfHOKQZ5Ho7Z8sUCNi1GRpjAMp0yOy1Tvr?=
 =?us-ascii?Q?vK4xTD1gBbPd+v7dA+hRrLLhMb1bclm+YAp3/9PIrV8ihNsI/s281dBnPIW3?=
 =?us-ascii?Q?BjsiZLy8czFM+pK96wMAqiYdk7SoYOVMMiVanH9phA8zvhdwP1x5zMDkNa+C?=
 =?us-ascii?Q?cu7x8d3F/vIxhZAKBnEhZOczOts5vwd4hQN7BWwqPpB6xvhV9wDa+LNJoVJX?=
 =?us-ascii?Q?j8p3eD1AZK4ZrqbfwsCd3z++s9Zd4dPtVsKNnIeTnF4iIcVl7/CvZso1CcSN?=
 =?us-ascii?Q?s3qb+mMo8HzUXivw8D2SxuhapxffOYunP/sCbpl7h/4zRSgjA7wB0dnl+bge?=
 =?us-ascii?Q?Qa2tsduQn/VPhGhLrkfwAxacqOj+W6axJNwjKjRoQO0IcVVXoRAoYbpIauQZ?=
 =?us-ascii?Q?vr1vFKrKglMTSF/PqJ/a5MnHbF3B6SWQiuIRKbKiPawYVwkBMewBiLH+wWkh?=
 =?us-ascii?Q?oYqfB1TBue2/G9U3t2ZOYAU5oez0NR73mT26IzI7i2FslOX0oKoZDLiOeHWz?=
 =?us-ascii?Q?zObTUAoxPMh1BB++CTdfDFOxC56JJzcjjtSy1ngBwI+vz2Yr/Wj7/vXpcb95?=
 =?us-ascii?Q?9+Edqbz7itzcnWaSx7mj1Y/5viCSIdpFz3VR+2uEuOQWcij35BZOMoiunH4K?=
 =?us-ascii?Q?rMYIaJTZ6wzsxj1Vc6+FkgNreSuPrM57PUCg5UyVoU63+4dX5OTNo5Nw9Jrq?=
 =?us-ascii?Q?qglQzh064N72kws81VvrmIPNaCm49/VwD1HqMGwgzgrsWqNXYNzOV93wpuh8?=
 =?us-ascii?Q?oezknMWDXFy+2zPTVe0k/tAOewrEd+at3pRNvjTlVbMew5US6mUvXdZFvNE1?=
 =?us-ascii?Q?uM8aToIIHNcNYSObP+X4F4ElExbEgmA1Rw1Cng6Zoln6Cd4YCACfRN04yYfL?=
 =?us-ascii?Q?PFAL3s3Uirnv3OW+3vspnFpblTvItVJMduEaIseh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?XAVtEKf5MRRulx5UGA1z1eCaqdH5J3RcPrg0fvONs3jkk9YImJps5fkbt6l6?=
 =?us-ascii?Q?kkmkETp8VRtS0PB3WKopUzcf6b1AV1vRF+LMa4eAVMLzPoyJPzGPF1uAeoUc?=
 =?us-ascii?Q?atXjOuXbSt2PVJ802EmSEN8k9jaaNJmtmfwZlYh4kp5ckN510d5p2N8aWZtT?=
 =?us-ascii?Q?XPznR4x/mSE3Q1wgezJPu1U4LdZsC9m1TejfM8rLerHqG/K2BikzwrLAMj43?=
 =?us-ascii?Q?AZAmJrdVr77WpJCU6eYUBARQeWqQggt8cEq5MkVF+RoyqS7+0eE4wW3gVsof?=
 =?us-ascii?Q?7+FWCt6bcOQdfCOv5uppZ3SzZSSkx7uufUAVGiOvWhhvrRwdj93lhRbn5sYV?=
 =?us-ascii?Q?IRj+K9xqxqscIyOkaCndC2M5vZZzs8MptZ1KqjnQCwH2CY8tKmuDJXFCHKys?=
 =?us-ascii?Q?AgWKUtsYN4QkVyGcLOhsF3tXoc1CqIqzTuISPaPsbl35Nt97JeqiKG1dLE14?=
 =?us-ascii?Q?EDNMgeY+UmrNxwD0aJzh+eUkhK/+S9mCVpuzQ1dUKpJt+nv31BokDVgXDXSQ?=
 =?us-ascii?Q?mmaw3JeADQF8L2wf5pL6p7KLMYKxS2g+3GxlsE1zuYMZ7FvCEV98/2gqPDty?=
 =?us-ascii?Q?z+wUK9w7hidsQRpLFcWfEm8xIRJ48/ysWuPMKXtYAN5L0zrhUzo/s6DGLwDq?=
 =?us-ascii?Q?2riCtjIMJWC3idKS9+HrbNDwrq/k0Ykyzo6w275s+ISS31+/UoxgBemCLqnZ?=
 =?us-ascii?Q?apvwyFWGLn4VSVG3Q32iptjG+i+/0kFSSU/B4VDyvqxq60LNd8zndOAi2ELq?=
 =?us-ascii?Q?wW0JupN67FPdNJx0umc3jwqNTJ+sUshbaMEoVdnEqMQlPC3kiQU5QBL4hL5x?=
 =?us-ascii?Q?gPq8xdxtTWFIJUghrY2SQGrHQXii7i2CcCXpJUXKJyzm0oFypKEsFJfJzWHs?=
 =?us-ascii?Q?QjegGsbhc3W6r9VGJ7jhnGiW3BGFMfoLyENDoqEh0eZhA0WSZ/sMB83hB02u?=
 =?us-ascii?Q?wvmSQ09O9oHxaWhrHtCmUp+B2c/Lw4gFlovuxDNIsu30ncfWhkCPmTviqyic?=
 =?us-ascii?Q?ybOiyzxvWrNFMI3XHftdIGlmmw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efa7b23-6460-47bd-5118-08dbb60e9a6c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 17:10:04.1075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCEO0Kg46HQg6pmbLSd52kKNHKq/sAfwDns8dw3M4epQdnEiVZr2vHOTSGZmhFkrrBExAPR1EZ2Lo66UfeSfMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7515
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_14,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150153
X-Proofpoint-GUID: 4asJnI9L5gqI5CTGZCA3Jc0Wxigz9amj
X-Proofpoint-ORIG-GUID: 4asJnI9L5gqI5CTGZCA3Jc0Wxigz9amj
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Ben Wolsieffer <ben.wolsieffer@hefring.com> [230915 12:05]:
> On no-MMU, /proc/<pid>/maps reads as an empty file. This happens because
> find_vma(mm, 0) always returns NULL (assuming no vma actually contains
> the zero address, which is normally the case).
> 
> To fix this bug and improve the maintainability in the future, this
> patch makes the no-MMU implementation as similar as possible to the MMU
> implementation.

The confusing find_vma() interface is even more confusing when nommu and
mmu versions have different meanings.  Perhaps the nommu should be made
the same?  This is almost certainly the source of the bug in the first
place.


Note that the nommu version uses addr in find_vma(mm, addr) as the start
address (and not the precise number) and searches upwards from there.


> 
> The only remaining differences are the lack of
> hold/release_task_mempolicy and the extra code to shoehorn the gate vma
> into the iterator.
> 
> This has been tested on top of 6.5.3 on an STM32F746.
> 
> Fixes: 0c563f148043 ("proc: remove VMA rbtree use from nommu")
> Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
> ---
>  fs/proc/internal.h   |  2 --
>  fs/proc/task_nommu.c | 37 ++++++++++++++++++++++---------------
>  2 files changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index 9dda7e54b2d0..9a8f32f21ff5 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -289,9 +289,7 @@ struct proc_maps_private {
>  	struct inode *inode;
>  	struct task_struct *task;
>  	struct mm_struct *mm;
> -#ifdef CONFIG_MMU
>  	struct vma_iterator iter;
> -#endif
>  #ifdef CONFIG_NUMA
>  	struct mempolicy *task_mempolicy;
>  #endif
> diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
> index 061bd3f82756..d3e19080df4a 100644
> --- a/fs/proc/task_nommu.c
> +++ b/fs/proc/task_nommu.c
> @@ -188,15 +188,28 @@ static int show_map(struct seq_file *m, void *_p)
>  	return nommu_vma_show(m, _p);
>  }
>  
> -static void *m_start(struct seq_file *m, loff_t *pos)
> +static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
> +						loff_t *ppos)
> +{
> +	struct vm_area_struct *vma = vma_next(&priv->iter);
> +
> +	if (vma) {
> +		*ppos = vma->vm_start;
> +	} else {
> +		*ppos = -1UL;
> +	}
> +
> +	return vma;
> +}
> +
> +static void *m_start(struct seq_file *m, loff_t *ppos)
>  {
>  	struct proc_maps_private *priv = m->private;
> +	unsigned long last_addr = *ppos;
>  	struct mm_struct *mm;
> -	struct vm_area_struct *vma;
> -	unsigned long addr = *pos;
>  
> -	/* See m_next(). Zero at the start or after lseek. */
> -	if (addr == -1UL)
> +	/* See proc_get_vma(). Zero at the start or after lseek. */
> +	if (last_addr == -1UL)
>  		return NULL;
>  
>  	/* pin the task and mm whilst we play with them */
> @@ -218,12 +231,9 @@ static void *m_start(struct seq_file *m, loff_t *pos)
>  		return ERR_PTR(-EINTR);
>  	}
>  
> -	/* start the next element from addr */
> -	vma = find_vma(mm, addr);
> -	if (vma)
> -		return vma;
> +	vma_iter_init(&priv->iter, mm, last_addr);
>  
> -	return NULL;
> +	return proc_get_vma(priv, ppos);
>  }
>  
>  static void m_stop(struct seq_file *m, void *v)
> @@ -240,12 +250,9 @@ static void m_stop(struct seq_file *m, void *v)
>  	priv->task = NULL;
>  }
>  
> -static void *m_next(struct seq_file *m, void *_p, loff_t *pos)
> +static void *m_next(struct seq_file *m, void *_p, loff_t *ppos)
>  {
> -	struct vm_area_struct *vma = _p;
> -
> -	*pos = vma->vm_end;
> -	return find_vma(vma->vm_mm, vma->vm_end);
> +	return proc_get_vma(m->private, ppos);
>  }
>  
>  static const struct seq_operations proc_pid_maps_ops = {
> -- 
> 2.42.0
> 
