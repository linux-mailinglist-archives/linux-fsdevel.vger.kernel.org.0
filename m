Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132B0727421
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 03:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjFHBTX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 21:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjFHBTW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:19:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D4026A4;
        Wed,  7 Jun 2023 18:19:21 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357MExJM013828;
        Thu, 8 Jun 2023 01:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=ZeTayBQmXEfkeiVK5cec74SvX2/0lEMAt3GDAZktehA=;
 b=2/uambdYLh5UaQ/Mck1BA8lVwwZTMC2kA7TtLCfsuAdSeI6e4jXRwsSJjWjRCiCFITDg
 CrCH+bCm/wEawp2TWgvQjlYpgKUFwWqV4blwFYgGyXP5++mJITY4AqfnWDjZQPd5DkXy
 6YnPx7exqr9dcbL1khWZZ+x+FTBcS9HND4ohPKHzTNWTUqkqk6isE7DRx1idn52neLbA
 UJpXaI/uN/mt0mTi+J7yMid+thNDoGLC68J2BR1Ui+57AYkQUSGUg6pDtHUAw8dDJPbo
 874Nco73hsfKV2WzCx+Sc0dDEMscMAESlWlgtkl+FIyZsg4IZplQlgidKrnIWs/aNL9l rQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6uu5y0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 01:18:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 357N0Uj4036079;
        Thu, 8 Jun 2023 01:18:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6s83n5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 01:18:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXjDs05IzoyxQEIacoBC5msfUZ6MW3aCPVG9Si5DyAMaOCmmDIq/TMbEpbPeYOKQmRawB1qfYIhtu9KezuTdyN9GONBqbm/zi//EgeHyB9kUvqXFuExlKTZm+MfALcJYQRqZuP5XVJUfdy+bWdZuyJxOiF+AiHXGQkBBWs/zI+I1q+0IZ5HrP21P5npxlhsvMR60jRAwFmmi11+Ns0Qku4PJFtxM2zDtsZivQVEnPz2wErQrpORSklXLXQYPNQx//k2XKaAe+mhtTvyMGzvZXfq7bcJRucVfYyLUVinbabrJ9yJWAaWEKXVVV7CkZPxZqlRdmUe/syYtGPOBBCqleA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeTayBQmXEfkeiVK5cec74SvX2/0lEMAt3GDAZktehA=;
 b=KXbiyVheDHDNkdxJar79Ovi4+T6aEmxdc9xt2+D+ViF8+bagIHuf0V4xOeYUgkmWRVPmcTrz26yUNekU97LqOVX3qnjpX+zejrwf5IjpGXZBQLQusNHqwoNxBA/kwwc/eLsmXqz5Hzhpma0uByP8KTAfKfPLIiOzbt57HZ/pEkc2DQ93y0kuo6ruyZufTCRPHkDDkVxCYjBQFSulPPLkUwhmHGfGYu4rDje/3oy0Rhpknv34aQYkxLl2s/FDAvtuxXMwzH48aMj3eTiL1W1iD/csd0bAk77wroOs6QvfS/1b1YZpTJba5iukCItoJBtSfnrlfxFEVLhtVuc4Nyh/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeTayBQmXEfkeiVK5cec74SvX2/0lEMAt3GDAZktehA=;
 b=AzaepLL2qbJiwzkeasEtbeSPn+GJaGPIGx1jejbnx7BfYjDm+cSvlEHu12SZFYACf3SfXCSj+dax4EG4RNVhos7x5xNP+mh+p35fbSftUl50VVdGC5SgJ7Wc5GonA3pBUvykZb8PyiuKOOpGyXzOZzN6ZhWDLs9sRaJI0GpIjGU=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH0PR10MB5178.namprd10.prod.outlook.com (2603:10b6:610:dd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 01:18:14 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 01:18:14 +0000
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 19/31] scsi: replace the fmode_t argument to
 scsi_cmd_allowed with a simple bool
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17cse4ur8.fsf@ca-mkp.ca.oracle.com>
References: <20230606073950.225178-1-hch@lst.de>
        <20230606073950.225178-20-hch@lst.de>
Date:   Wed, 07 Jun 2023 21:18:12 -0400
In-Reply-To: <20230606073950.225178-20-hch@lst.de> (Christoph Hellwig's
        message of "Tue, 6 Jun 2023 09:39:38 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::34) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH0PR10MB5178:EE_
X-MS-Office365-Filtering-Correlation-Id: fe8c38b4-8242-4d2e-aa8a-08db67be3b83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AYz+3yp9Ljzam6lfyV6gHjSeOcZ70vkOawTblBxxmgFnBi/8x5UCfcEGQX5mP8eFDqBeVFeSHXO7bfp+zypJYTRIy/hH2SumD9+ivxSWHzbNMETswUfR3U+fPJSPMTHPNHJ8CeoafNnFMcdf4VVUK/KQA1TGAn3TShqVpj2ILFM6MaP1RJago7DbqA5Nn8Zb6obNjzO0n+1FSdWoSkmJew5cdiPehgsBNcL5sgv8Edysic0vUd0ZrBufG4CIYVv3EpvZA1gOA3xjD3D8ed5ljtIS8Y4kgp6sL2/Pk/idKXM78xsWyB0SfKQU7DpwGu7l8Bawr7PY7TXvOBKNbCe9/3RoEiwYG2yinU5pHSAcsnWCcxiW7WL8UIxvWW3maoCsKcjoUm9Boi+XK7j93YIs/vxVG07f7dj+SJYZCIR+QyvL25FNHjVsW8GRIsrom0DORj4+y3BnSomVt0Z3Jc9+13j8al95Wwf5PpZL80S84YLxFDzpCmn7fEzo9tzgd+ZFTX/++LcXQpPxhtKgAr3FYQxqZO6Z5OoTw5U6a/dmQufl/mTuobSXJLt+E5lZmM3n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199021)(478600001)(2906002)(36916002)(6486002)(558084003)(186003)(6506007)(86362001)(26005)(38100700002)(6512007)(5660300002)(316002)(7416002)(41300700001)(8676002)(8936002)(66946007)(66556008)(4326008)(66476007)(6916009)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wcto4/593bIqSpI4OxqkT5S7ybmgWSmXWclZ8rCztxP5/5Xrj8M+x3p8mz9t?=
 =?us-ascii?Q?6+RUi/CIeq5hrD0+d1V8kiSih0FI43JbgfgTx3fN8ehauN/FwFajuEsyvjAM?=
 =?us-ascii?Q?3DkBhDEJkQzfLwu9b+NtF/pfWJh18n7URULBAwRHs/lhE7ynDNW7uS9gxn8+?=
 =?us-ascii?Q?CwybeLNqIMb2ZAqaqW+Xf3iwb73DkaV0bUExoV0bmvYa2MwSOIjhy79ta69C?=
 =?us-ascii?Q?aoZ2t2s+Uo0+VxK/rkUvAoXHIOMxI8jmb/5bxS3mvLlFg2LVyR6DA4SdcQ3G?=
 =?us-ascii?Q?zulb05S3jHt/0cXEyuKFyySkEnHUA5krMnyDpSY8HYsNsOZ1DgZ674bXdNTt?=
 =?us-ascii?Q?bGsLfIqx9zkGDlKpFPEKbO0DS3mx6ZyD/nnQj44EyCYeyMoE8HmmdPefHVAn?=
 =?us-ascii?Q?yXC7eWGdJz4IHj9FpZ9vS9V3QO41ji+0iHC07A3wiPR/r8HSk9Igpehw4Mjx?=
 =?us-ascii?Q?JoCOg3TDkHfmr2eHySdipEB84Xu3PnNGH0CQyiwOCuFvEQQiZxUDGZ2v4caC?=
 =?us-ascii?Q?fwMXisE4+yxV30cxQ4ACYpyWcRwygijhBj2JGIo31Yq3KWKOGxtF9JtRUFGr?=
 =?us-ascii?Q?P6V/ntsqzs3dikTvG32nQg7jSy+dxi5NmwoFvl6xZlc4cI9pHqcQUexciLql?=
 =?us-ascii?Q?IsoPZusVVGufjOkxry7v1K9Vha/5EO389q3JCjk1+0+EI4OsPLbVPJ2sq/Wx?=
 =?us-ascii?Q?OpHn1uYXuCPP09L081/g52O9CB2GF99W7r4Ip1KODjexvaaDpixAYtZpdax2?=
 =?us-ascii?Q?k/PAZKM4wdFl4TVKrTe82h9vSe3G29YKBSeu8K0w5lNA2vSHbZIiXTzfBrMS?=
 =?us-ascii?Q?Esyn4te2gXpCeAOfeoinUN5eGmbtR8VMDjwXV+kyj13WedRsI1oMKAy4K0Ti?=
 =?us-ascii?Q?YExMO3Q4NkLQherIXmu8uoBmlyBtubJCbb42Q2gyIxd7qJqI59kkqwAElIIl?=
 =?us-ascii?Q?eqVEamAE1Bg5AIhBbMWCFdLv2B2M1wdJfUiaBSjYOw48MQLs1d3OaE5zV1hG?=
 =?us-ascii?Q?hFHYWevrR3DbtgPJtqsmoVaYS6Oj+Q0uXHh0PJwLNkMXW/U6X1Cjixou7atZ?=
 =?us-ascii?Q?Qyov3lXiaEW3R2TyVX6j7s6EsO0XwTlVMeettQDXJYGqH2vAgY6idLRtvjmW?=
 =?us-ascii?Q?0nx8e1wSEeaE+QX6RtsJPbuGW3Sx/iN4/rynD9IGvCIng9+iLAEGrRROuV48?=
 =?us-ascii?Q?qA5Tvy/uInpcNgGdd6alIagg0r00iXrLGi4hvCHNyairEQWZctZ2e7oB+bBi?=
 =?us-ascii?Q?Vx2pnGiyExeyfT/edXbnrDuId3Sf5Dww8SiXw0ETCSyFWax28IUAXUoyijtx?=
 =?us-ascii?Q?r0MGot6TKZzUNkVf0QPslxQAeX4npJax9UeVwCyn3bvaRkCUajAa9AagAZsy?=
 =?us-ascii?Q?gUdl26C6WmwVs+X4Wg1SIHzSuoCgGxY4mJ7T+5uaOtv9AWrxP+2xtn8AKPK9?=
 =?us-ascii?Q?te+ohSarlKQG5qcqx6/O9YaWP+la7Ikv0YFkxFYnxOTFDjUK6Js8ZN6YEnak?=
 =?us-ascii?Q?B5HiI7OucexakxFRiEqOHXDnTRq8E4lCZVI2TQE8iEcPxb4QmmDiycYCrhTR?=
 =?us-ascii?Q?EVWnxtRYYMqm6s5z8OAk0chrPbpd6FKluUDtqbha0HHg7GKosKQvkDUUs/BU?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/mtP4tn7xINn/IA4AqKOQEKImn4rEXdvKjjNfArjc3YiAF9jLNRCbKnReMCs?=
 =?us-ascii?Q?5WliorKbm04ZQIoygakThjR2KQxWzmfLL4YLrc8Qw4XSJzn9zVFUzbE/P42u?=
 =?us-ascii?Q?43+QiYTUJkDp7uu5sqbcY/M7rK12i0KwKgVZLFCUCSk+kmN1gy8FypOVEzRT?=
 =?us-ascii?Q?YF49WEomfd15vrqrxFsMtu2c/F6yDHCkU9IQRfY+ZilwYBL7Z4tNKncrLFsb?=
 =?us-ascii?Q?sMTzVoEqzJHFEqW+EP93HflGaQ2gd7D6WqgslCnnTrfgwSjfXqAGRJNi2kwv?=
 =?us-ascii?Q?HTcAiqtlabvnReWzbCYG8BokqoVXN686uYeVXMVRU8XIfF3diiEQ4hR/olmu?=
 =?us-ascii?Q?s9h7Rn2JU4SwuXNi6kbew5wdSZqFq04ZZDZEfAEDX1piMvn10Y9cxFiBkmSf?=
 =?us-ascii?Q?3xn0IP0ulsSA49aMdf3ux5UnKswEF8sEwwGqOYhpLKmhAcOengQXh43hMvYX?=
 =?us-ascii?Q?+H9G0to40BzBkyxEQXZ6IyAkfUkTm0RrTVGybhqQ/q2ARgC9xO2HBwx9Fj28?=
 =?us-ascii?Q?4UC9GGN1M1TJKk9gOTWWnJJ0helTrYvxTY2AW2Gcq6QzCXI3rfmjmze2yf7W?=
 =?us-ascii?Q?VWO79Fc3uJy2WgGQz5RkQ6T4zVODQi6a2+mLbCno8/ZwZqJOMjwAwOj0tDOO?=
 =?us-ascii?Q?o8Ip/EsSI+zSX8V716zb3q8jecaa4COZFh6P/vWTSHsQYNWF6IzIcwzLRi//?=
 =?us-ascii?Q?H9/H3r2a+Oy1b6S9VDjQ2uMTdhqRf6M/C1F5QSUJ6noB+OAZMdaVDpyhJG3S?=
 =?us-ascii?Q?AvdJffZwtJWriE2SpKkvy9Y6/JVNgHcIJKFJVBs2sZO8sPEeByVVb6IfUqPk?=
 =?us-ascii?Q?jGe9iEzop2sHbog8UUq5rsNrt6bxPHf6BLicFFTZvSAPbA6gdZiyaLPqVO7D?=
 =?us-ascii?Q?JljJyOggnmQXn7h9lQ9v6Cry6EtnVZNdTGNBEZyaKpMoK+2vCnWYWZhi2It7?=
 =?us-ascii?Q?qtA1qXDQkrsz18Dozi/OkOzoHS1J8rCDuol+uKCSinpIcTYp7u9kjQiJz9yf?=
 =?us-ascii?Q?VywHU+kqWcj4lFmRk5Csyzq8QOTXZ+P6A5wLUDExat62Cj6kGydyuv8LuTwx?=
 =?us-ascii?Q?n9RVapdAKre5pFyVl9C1k1NHXvREXvCPJueT6BO52y+I5I5wTq2PLqRwFDMY?=
 =?us-ascii?Q?OxoY7ACAyQ49E7qrUDWi3R8YZ1yPLmuQs1ec5qCi1YhdEC9mSIvF4XP4IAAS?=
 =?us-ascii?Q?fq0rauHKa8wkOKyjOyeckXlDYIIxR0jh1fwj02afgIltg1cBJ04eT/bzap7Q?=
 =?us-ascii?Q?DZaot73CkYb0n/c+Nc+8lqtsb8VtPq1jx4yO6XlP/w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8c38b4-8242-4d2e-aa8a-08db67be3b83
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 01:18:14.3919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FivRTrOqaUYeWFpOQ7JNQPfvXtpO0gLa237BdhSRL7KVJ7z51YaRfGU0zzbzqQwn5nVhCKCLJ45tCHG2ZjZIyDZ/PJfOGRGLNmO2omhBSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=580
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080008
X-Proofpoint-GUID: t2j73A9edmSwqpNQejSkZV5mHJgC3SFx
X-Proofpoint-ORIG-GUID: t2j73A9edmSwqpNQejSkZV5mHJgC3SFx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Christoph,

> Instead of passing a fmode_t and only checking it for FMODE_WRITE, pass
> a bool open_for_write to prepare for callers that won't have the fmode_t.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
