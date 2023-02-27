Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CBB6A3968
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 04:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjB0DSX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 22:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB0DSW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 22:18:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0063F107;
        Sun, 26 Feb 2023 19:18:20 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31QKLw05007271;
        Mon, 27 Feb 2023 03:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2022-7-12;
 bh=ZYIIEf6Sapqn385Eb5JofyH2+CpKVsoV4+j3c1B4+X0=;
 b=pFrjjlIdr40gBVzEooiAT2i4C7MPeS94J6ovavldxH6G4BFTcT17iaY7x1hkNPJvFeD3
 nyrlKtxkHfWluWdWkj03GFhBBGEJuk17GcwuFYu4xCwa+tvkIOV3UM8yHzEAISehzvKo
 pcgdNW6HveHl68wEKRlJYn5fX8hnP0hGYshE34YI6llKWUoV3zo/Ft9V3zCEmquM4D4u
 Yfn43uN8X0B9DHgXL+t9kSwIc8cHBS3iJ2gPo6iIXKeXa8UaLUyKICasSQFkbFBZAL8H
 CDoP/pdJRcy0gFFUDUuQIzdJhJc7T98iJmKTlaJFtmhnUPgQAuWNYjPqpIJ8bpRUwa5u zQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb9aa5b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 03:18:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31R0tebf032985;
        Mon, 27 Feb 2023 03:18:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s4qjxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 03:18:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pn+ARUvP5HJYBppG/TgEWJ2SP7DsJgz+qIuMCpNZoHbwlLcfZcW1gS1Uvg/GWFFDJ72rV48tDnjwkKqkamOPJN+9nj+cJwTw/DENJ7jltQCqmc8KPwnR9qyZCoGHgLgFa3omHKd+iL2yP5a6lu/4LG+xPXI7UdwnNmGBEWUZiLuUENQrdWsaZWnmdLH7/tglrTeRINB7dFVXn9KSOts8YCHnRHmQ74LaoQ/39xy6kSASGBkKQlAVgaZJqDPgSNmxV99jgeY6v0LFTEHxpuSZWyAJGhSMk6mibPNpf/Hn12iwMIe2dZ3pPY39+qlZDwY0wzmCGZ1n5BWchKiqFqhxaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYIIEf6Sapqn385Eb5JofyH2+CpKVsoV4+j3c1B4+X0=;
 b=VySOcQ8bA9hyhWNzIlBAOby6P77ifWJiULfc0NHNnC2Nsrere4gUpfvHXnGaxtSziWj9RNVROV/+92Fb0UEeGWpxiVgJpcmTazYJN5xLQD9lKyAsqgxC6hDUlfEHuPvDQAFrCn0je7lYCVZMkg/LdnbtvAtiBLx2PTfWdUjrWNnX5rofYTuucdIiIB8PGeBB5xa0PIimIfMoKS3Bn7QQPPNyq1FQEX2bxpiZ2N8hjN5xapE0QX0CmgCEf62hojsy/0fNLDY7I2jobjbrFZeMUppZaaXnWSEFRJvZaW8wZFjWQfxVy/0Yv5eAAOQXFDA0ngvrLMyqbNWp9NyrjxQ0cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYIIEf6Sapqn385Eb5JofyH2+CpKVsoV4+j3c1B4+X0=;
 b=cTP5S15xhM6swHL2fuZdyCwCVThq8f3xFlazwB+CrFxNrLRSPDva0oAUbY1QqWMo1yME5wi2r+eYEL8KVyF+Hd7gPfHVHHUG0SbyX4oqkoQuXEOiLJd3p3jLzg9nDRzXKjanYSeCLieix/+iNRpPk4r4i+i/BgqdS81OPJBEqqA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN6PR10MB7443.namprd10.prod.outlook.com (2603:10b6:208:46f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.12; Mon, 27 Feb
 2023 03:17:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6156.014; Mon, 27 Feb 2023
 03:17:59 +0000
Date:   Sun, 26 Feb 2023 22:17:56 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [linus:master] [mm/mmap]  0503ea8f5b: kernel_BUG_at_mm/filemap.c
Message-ID: <20230227031756.v57rhicna3tjbavw@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <202302252122.38b2139-oliver.sang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202302252122.38b2139-oliver.sang@intel.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0244.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::17) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MN6PR10MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: 51b9e7fb-4f46-4988-f4df-08db18713a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v5TZv9+uAeonj7i4rV72UH/mp2g7Eqviemxoa0KTFa+wmdEZgHyq4KrHfnZ/CwD8hl1Qdog1iF/wPTVY4YvQQGpYdNBFne2a42uVte1EKziOwrCoY/GAYmBTTx03yYpvvh9NL06bQvVxXUbem8oqzT1KxqiU37yAtO8kOxBRrZ86fO89lMOurTAkGldg2Gg9uf9MCDgaZU5CLZqbTYNi2qYK82qZxVFNM0G1McuCXBFPdbpVeKExiF/CeTKeqnCTkP43MoQyVFDgJgnh4C57QIC/1ta3RbfIysbH26oLUm5PgBimFHdOLDTOZNanJgESeWkpnrOYplI96G9RPDCPhrjqdTRkJ+BHr6LNEN453FfRnKOh0svLueqWU7plmIGCSpDBKi+1ltOOcwkpX+ZvDpdbWrLgrxBenOsCTw3yhLcBE6g6Db0lph/78VFioa69g1HqRHRtmz4vjWdFao0A8e0xme18YdQ7d1Jxs23wf0sOgVPXgjmTNxkij7j7IBPW7+Wz7Y+e3k1BiOM7Kp0Qqfmpx25k2bewEGdHkmvZ396WRuPlpJFR/xPx+vbbFDPVyTvkb4fuEReI3PyAPT/W0MuBDnt4JmFzG/hDTRgpC2TDKqg00tYI0kqq9BRZZs4w8GNL2YHcSoJ1k3qRJQ+OxgK86XcsT0LBsytnmirM8IU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199018)(9686003)(6512007)(1076003)(6506007)(186003)(26005)(6666004)(83380400001)(86362001)(38100700002)(33716001)(66476007)(66556008)(66946007)(4326008)(6916009)(8676002)(2906002)(8936002)(5660300002)(6486002)(41300700001)(966005)(478600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eP+s/e2mx/CZ/n9stm3ghOCjya4zYkZS0nqxI0vfRk5XhYJ2JtD1Rz9SMrLs?=
 =?us-ascii?Q?hOk3iPARg3pAYpZfgyvIQq9787+5Qn6VEiJPaLg7y0nfdJTz9qokIjxHtLPG?=
 =?us-ascii?Q?caoCAZKqYrLp8lUHo9ij5j7AHd444Wc6ZisP/yxNhRJ0fYWdboaoZGaBdF03?=
 =?us-ascii?Q?8mGP/x9Q+FQh8XXAnrvBBwWazVHCFBbTpxkB7gzf3l847VpJMMdg8T6xV2xu?=
 =?us-ascii?Q?ECyxOHDgfGFSCcVnnJgrYYKQyKEqbcq9RBgiyw0QMEUs1JtdkzWqD3GHuvsp?=
 =?us-ascii?Q?crOco7ZRZJuCI9Gf6zkxrJRmiy1SaHJy2URDHY7sIKWDqoQ9//Upy7oEMqqq?=
 =?us-ascii?Q?q9/DMmmqP1NDfDNONz4IApK2xQtgNinqrcDnYOuQlzgxPEFpC68eY+e0jV/g?=
 =?us-ascii?Q?QJkxWPuDSY/kBmiBK372YpsVC3JiFAgoCfp1Jch2YiPf8nHjglsjL15lHWCG?=
 =?us-ascii?Q?XQvjaOreDXXoYFiHtJNJgCD18JbSfm99SBg40tkvsSVr9Q+cv1PrM2jd6Kq+?=
 =?us-ascii?Q?0+DBmb8FKiGCNR9TYAzpoVOGd4O5Ts0nEUWc520iIOh6nMoLthx5RFxZZuN2?=
 =?us-ascii?Q?x5cQkYsSBabDY+X1TSGAJIW9RU1LWn/821HpzgP9zB/LZVpLhqtdFYMV1na/?=
 =?us-ascii?Q?xcu0ZSGM39zHcq3WBQjxfdgqWxjM5QincqVoSAo5kDAANz8kvn9tp43dl/1+?=
 =?us-ascii?Q?SZ9CIvKATuZ8KKght2KzIcVLZOJWaXT2z49cOPuoJ5a5uDii7EFkIeUMbNjU?=
 =?us-ascii?Q?+Wd7M47DtSJp/Xxql/+IWXQj9R8dTkTXlwJqKrWNeiNwaE8O1yK5B9U8a64L?=
 =?us-ascii?Q?Fnf99NLg3wttuYYNf79QzBfXbrZEHR3DnvBpevjazMax7ZkWgwSQXMxGkMi+?=
 =?us-ascii?Q?2XOaFgPIODs5mZJ8jjsKV6oyvbawQmEsc/1LNEcEcJXq3ylt5Jj02eauDWei?=
 =?us-ascii?Q?onj80vSDiCJ6poFFzAgEPDL513nOUjfRNX243YzANRXc+WbOANWrLreQlJEF?=
 =?us-ascii?Q?ZIR9Rwd1C0ol6fLnSHQsg1Pu38dG6EBXEWD/ZONIh6ImWEiiwoszWlv1h8mR?=
 =?us-ascii?Q?jnuTuYk9S/8i5/n9OU6M6CFfHMhAwipF/GqtTuc7IB89n2u5A7TKFdg0qlXT?=
 =?us-ascii?Q?PhtXXkmsszNiWyoTgcPVa4rm/iUpUK3UMEfxUZt+jBWhec6AmNdymwodFJD1?=
 =?us-ascii?Q?yuCWbwPNF+bY+XMWzHHQ/Mm0Cc8RYVZl3JQ2HBpp899CSWQf8UZ1zENW55up?=
 =?us-ascii?Q?ChGrfIkozAE89qXEVkNoVbGXWt9xC6qUEDtP7d0QfAAPOeiMp8kGjT2pE6sO?=
 =?us-ascii?Q?rZ68/RGHVKM6ZnuKXB/bJGsEcK7NaruImKSdxpNyCqtA7LzeWgDceUkE0A1O?=
 =?us-ascii?Q?88kdpBHZnTV5pWq5Cz/8Oo1op2q1LTaIoM6pYxCmPZv+BB1y2hp7MXf4zhp8?=
 =?us-ascii?Q?MNob8vbh8iVoBJ5aqSKoNnsBbMIeCnsq2Z2tP/FfGKe741tyVg21scDWau2y?=
 =?us-ascii?Q?VPORrGTTpY5oNL/Q63xOnROgALKfsItNv0Iaw/QmJoHegqyICN2EA9Uxujeq?=
 =?us-ascii?Q?0sGVC2nGo+VDDx+X5UfTyhDN57Yt2++USFYCNs1ca4SM9WbFg8MT3C+xrK1O?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2WQWlFcvivPLZpPD9QXPqS0QHZtKtzzv8p/ZU9jwWlmqJ9p14o8m+9pvyKmEnlzV6ImlQ4T58jDfKnAacXq/s4gi1nXcarC5/+Q7Qt+70Cx8o7NfN+VNUvGCYVz1Gp6PUNNpqBPtN+AJ12R5bF+Hoch28C8Y/grW4lCvyISWg9bT+a0RHIJRktDHf8yqS0YjYh86DKjKMsryqC+5/O1MIZZNYqQcNhvGu8QznowAuMiGiy11qpg0Az7TQ3CIB+cwc4JPr/NJDwBk2L+Hr7SHLJqQkPx9F7ORv5O5IwbxlojbzuwDRZjnkDBMie7OLHzldYNe7QAQEniHbhVzWjM9x0DGo79DX0F0b2bWno9GJtxnYtX/dr0nvXubuiVtyDIdPS3kK3XDYI09A0PeoAzcsm2jxckHsv96dqArk1ik4LvOirhzT8RfyJIT8LefAZ6gaiDh/Ds6H/uxQwstgogQSMo+vGk5C8jSlWNLR5/Xz0SP/vhYURMiiXxTg6ieO/XSEGLUNioCzuCXHq5LDl5Bg35UtF1sQhvMNrkAgcRw5vObtQtP3ewasX8eXQe8IdmJYTP/FzwcXkHfwrP4fnpFgyTiWwIHTVeQ2Dl2BH8iXgHhUz9xrfzQHAC7m4IG8s4tJvObP7E/J4HJoS39Tlntfh8jDZzSiTKm4etNwuZTNzcMVVLY5TIhCjZymWkOAPkr6EFMtNMlv4bXRwzrOkeJQE+trskYxsnIik3irS6hpQaCzd16H5yMP1TFzihwcM6nD7N3VlfqR+pQBZBdZBmHH5oJtuvYfO8aUCQnBwo9L5nHACBCC0t2En2d0yOO5mBNjSvJ83uBrTe5x8gboyI3UXG5zfRUDlSmZqyBJK8kfAeld2LVumAmUxWRmrVF4+sfrcdllEcxrFPjfIFfwy9oseO8UtaDfXJ3CryCfkz3p38=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b9e7fb-4f46-4988-f4df-08db18713a80
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 03:17:59.7145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYMwRYzr1pl3+y/vPfIM770SrQO3FfFMI8LXID24hIdiymlljOjielKRbAcNniGBaPx5NpmsGxn0keOx76l98A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7443
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-26_22,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302270024
X-Proofpoint-GUID: YKC9wv3iHuYyJaj_YQEVa5MifqmwZgHK
X-Proofpoint-ORIG-GUID: YKC9wv3iHuYyJaj_YQEVa5MifqmwZgHK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* kernel test robot <oliver.sang@intel.com> [230226 20:33]:
>=20
> Greeting,
>=20
> FYI, we noticed kernel_BUG_at_mm/filemap.c due to commit (built with gcc-=
11):
>=20
> commit: 0503ea8f5ba73eb3ab13a81c1eefbaf51405385a ("mm/mmap: remove __vma_=
adjust()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>=20
> [test failed on linux-next/master 0222aa9800b25ff171d6dcabcabcd5c42c6ffc3=
f]

If this is linux-next, shouldn't that mailing list be in the Cc list?

>=20
> in testcase: trinity
> version: trinity-static-i386-x86_64-1c734c75-1_2020-01-06
> with following parameters:
>=20
> 	runtime: 300s
> 	group: group-04
>=20
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
>=20
>=20
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -=
m 16G
>=20
> caused below changes (please refer to attached dmesg/kmsg for entire log/=
backtrace):
>=20
>=20
> please be noted, as below table, parent also has other type issues, and w=
e
> found they happen almost at same position of kernel_BUG_at_mm/filemap.c f=
or
> this commit if looking into dmesg (attached two parent dmesgs as well)

I don't understand what you are saying with the above paragraph.

I thought I understood that the bug happens in the previous commits and
there is a dmesg from the previous two parents attached.. but when I
look at the attached two dmesg, they are from the same commit and
neither has anything to do with filemap.

And why would we blame the later commit for the same bug?

Did something go wrong with the bisection?

>=20
> we don't have knowledge if this commit fixes some problem in parent then
> run further until further issues, but since this commit touches
> mm/filemap.c, we just made out this report FYI

I changed one line in a comment in mm/filemap.c in the commit.

-------------
diff --git a/mm/filemap.c b/mm/filemap.c
index c915ded191f0..992554c18f1f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -97,7 +97,7 @@
  *    ->i_pages lock           (__sync_single_inode)
  *
  *  ->i_mmap_rwsem
- *    ->anon_vma.lock          (vma_adjust)
+ *    ->anon_vma.lock          (vma_merge)
  *

-----------

Are you sure about this bisection?  I'm not saying it isn't my fault or
looking to blame others, but I suspect we are indeed looking at the
wrong commit here.

>=20
> BTW, we also noticed there is a fix commit
> 07dc4b1862035 (" mm/mremap: fix dup_anon_vma() in vma_merge() case 4")
> by further testing, BUG_at_mm/filemap.c is still existing there.
>=20
> +---------------------------------------------+------------+------------+
> |                                             | 287051b185 | 0503ea8f5b |
> +---------------------------------------------+------------+------------+
> | BUG:kernel_NULL_pointer_dereference,address | 11         |            |
> | Oops:#[##]                                  | 11         |            |
> | RIP:dup_anon_vma                            | 11         |            |
> | Kernel_panic-not_syncing:Fatal_exception    | 20         | 9          |
> | canonical_address#:#[##]                    | 9          |            |
> | RIP:anon_vma_clone                          | 9          |            |
> | kernel_BUG_at_mm/filemap.c                  | 0          | 9          |
> | invalid_opcode:#[##]                        | 0          | 9          |
> | RIP:filemap_unaccount_folio                 | 0          | 9          |
> +---------------------------------------------+------------+------------+
>=20

At what commit did problems start showing up regardless of what the
problem was?  I did not see any other emails from this bot since
2023-02-12, but clearly it is reporting problems with earlier commits
considering the table above.

>=20
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Link: https://lore.kernel.org/oe-lkp/202302252122.38b2139-oliver.sang@i=
ntel.com
>=20
>=20
> [   28.065728][ T4983] ------------[ cut here ]------------
> [   28.066480][ T4983] kernel BUG at mm/filemap.c:153!
> [   28.067153][ T4983] invalid opcode: 0000 [#1] SMP PTI
> [   28.067868][ T4983] CPU: 0 PID: 4983 Comm: trinity-c3 Not tainted 6.2.=
0-rc4-00443-g0503ea8f5ba7 #1
> [   28.069001][ T4983] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
> [ 28.072145][ T4983] RIP: 0010:filemap_unaccount_folio (filemap.c:?)=20
> [ 28.072927][ T4983] Code: 89 fb 0f ba e0 10 72 05 8b 46 30 eb 0a 8b 46 5=
8 85 c0 7f 07 8b 46 54 85 c0 78 11 48 c7 c6 a0 aa 24 82 48 89 ef e8 0b d2 0=
2 00 <0f> 0b 48 89 ef e8 01 e7 ff ff be 13 00 00 00 48 89 ef 41 89 c4 41
...

> [ 28.087701][ T4983] __filemap_remove_folio (??:?)=20
> [ 28.088418][ T4983] ? unmap_mapping_range_tree (memory.c:?)=20
> [ 28.089168][ T4983] ? mapping_can_writeback+0x5/0xc=20
> [ 28.089940][ T4983] filemap_remove_folio (??:?)=20
> [ 28.090627][ T4983] truncate_inode_folio (??:?)=20
> [ 28.091342][ T4983] shmem_undo_range (shmem.c:?)=20
> [ 28.092036][ T4983] shmem_truncate_range (??:?)=20
> [ 28.092753][ T4983] shmem_fallocate (shmem.c:?)=20
> [ 28.093444][ T4983] vfs_fallocate (??:?)=20
> [ 28.094128][ T4983] madvise_vma_behavior (madvise.c:?)=20
> [ 28.094874][ T4983] do_madvise (??:?)=20
> [ 28.095491][ T4983] __ia32_sys_madvise (??:?)=20
> [ 28.096166][ T4983] do_int80_syscall_32 (??:?)=20
> [ 28.096885][ T4983] entry_INT80_compat (??:?)=20

What happened to your line numbers?  Didn't these show up before?  They
did on 2023-02-06 [1]

...
>=20
> To reproduce:
>=20
>         # build kernel
> 	cd linux
> 	cp config-6.2.0-rc4-00443-g0503ea8f5ba7 .config
> 	make HOSTCC=3Dgcc-11 CC=3Dgcc-11 ARCH=3Dx86_64 olddefconfig prepare modu=
les_prepare bzImage modules
> 	make HOSTCC=3Dgcc-11 CC=3Dgcc-11 ARCH=3Dx86_64 INSTALL_MOD_PATH=3D<mod-i=
nstall-dir> modules_install
> 	cd <mod-install-dir>
> 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
>=20
>=20
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script =
is attached in this email
>=20
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>=20

This does not work for me.  Since my last use of lkp it seems something
was changed and now -watchdog is not recognized by my qemu and so my
attempts to reproduce this are failing.  Is there a way to avoid using
the -watchdog flag?  Running the command by hand fails as it seems some
files are removed on exit?

I did try to remove the directories and run from a clean state, but it
still fails for me. (see below)


Thanks,
Liam

1. https://lore.kernel.org/linux-mm/202302062208.24d3e563-oliver.sang@intel=
.com/

Log of failed lkp 68d76160fd7bb767c4a63e7709706b462c475e1b
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
x86_64
=3D=3D> Making package: lkp-src 0-1 (Sun Feb 26 09:31:45 PM EST 2023)
=3D=3D> Checking runtime dependencies...
=3D=3D> Checking buildtime dependencies...
=3D=3D> WARNING: Using existing $srcdir/ tree
=3D=3D> Removing existing $pkgdir/ directory...
=3D=3D> Starting build()...
make: Entering directory '/home/jedix/lkp-tests/bin/event'
klcc  -D_FORTIFY_SOURCE=3D2  -c -o wakeup.o wakeup.c
klcc  -Wl,-O1,--sort-common,--as-needed,-z,relro -static -o wakeup wakeup.o
rm -f wakeup.o
strip wakeup
make: Leaving directory '/home/jedix/lkp-tests/bin/event'
=3D=3D> Entering fakeroot environment...
x86_64
=3D=3D> Starting package()...
=3D=3D> Creating package "lkp-src"...
88466 blocks
renamed '/home/jedix/.lkp/cache/lkp-x86_64.cgz.tmp' -> '/home/jedix/.lkp/ca=
che/lkp-x86_64.cgz'
=3D=3D> Leaving fakeroot environment.
=3D=3D> Finished making: lkp-src 0-1 (Sun Feb 26 09:31:47 PM EST 2023)
~/lkp-tests
11 blocks
result_root: /home/jedix/.lkp//result/trinity/group-04-300s/vm-snb/yocto-i3=
86-minimal-20190520.cgz/x86_64-kexec/gcc-11/0503ea8f5ba73eb3ab13a81c1eefbaf=
51405385a/0
downloading initrds ...
use local modules: /home/jedix/.lkp/cache/modules.cgz
/usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encoding=3DUTF-8 http=
s://download.01.org/0day-ci/lkp-qemu/osimage/yocto/yocto-i386-minimal-20190=
520.cgz -N -P /home/jedix/.lkp/cache/osimage/yocto
17916 blocks
/usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encoding=3DUTF-8 http=
s://download.01.org/0day-ci/lkp-qemu/osimage/pkg/debian-x86_64-20180403.cgz=
/trinity-static-i386-x86_64-1c734c75-1_2020-01-06.cgz -N -P /home/jedix/.lk=
p/cache/osimage/pkg/debian-x86_64-20180403.cgz
43019 blocks
exec command: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -fsdev local,=
id=3Dtest_dev,path=3D/home/jedix/.lkp//result/trinity/group-04-300s/vm-snb/=
yocto-i386-minimal-20190520.cgz/x86_64-kexec/gcc-11/0503ea8f5ba73eb3ab13a81=
c1eefbaf51405385a/0,security_model=3Dnone -device virtio-9p-pci,fsdev=3Dtes=
t_dev,mount_tag=3D9p/virtfs_mount -kernel bzImage -append root=3D/dev/ram0 =
RESULT_ROOT=3D/result/trinity/group-04-300s/vm-snb/yocto-i386-minimal-20190=
520.cgz/x86_64-kexec/gcc-11/0503ea8f5ba73eb3ab13a81c1eefbaf51405385a/19 BOO=
T_IMAGE=3D/pkg/linux/x86_64-kexec/gcc-11/0503ea8f5ba73eb3ab13a81c1eefbaf514=
05385a/vmlinuz-6.2.0-rc4-00443-g0503ea8f5ba7 branch=3Dlinus/master job=3D/l=
kp/jobs/scheduled/vm-meta-102/trinity-group-04-300s-yocto-i386-minimal-2019=
0520.cgz-0503ea8f5ba73eb3ab13a81c1eefbaf51405385a-20230224-7240-hzx70n-16.y=
aml user=3Dlkp ARCH=3Dx86_64 kconfig=3Dx86_64-kexec commit=3D0503ea8f5ba73e=
b3ab13a81c1eefbaf51405385a initcall_debug nmi_watchdog=3D0 vmalloc=3D256M i=
nitramfs_async=3D0 page_owner=3Don max_uptime=3D1200 LKP_LOCAL_RUN=3D1 seli=
nux=3D0 debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_time=
out=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=
=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 =
drbd.minor_count=3D8 systemd.log_level=3Derr ignore_loglevel console=3Dtty0=
 earlyprintk=3DttyS0,115200 console=3DttyS0,115200 vga=3Dnormal rw  ip=3Ddh=
cp result_service=3D9p/virtfs_mount -initrd /home/jedix/.lkp/cache/final_in=
itrd -smp 2 -m 3419M -no-reboot -watchdog i6300esb -rtc base=3Dlocaltime -d=
evice e1000,netdev=3Dnet0 -netdev user,id=3Dnet0 -display none -monitor nul=
l -serial stdio
qemu-system-x86_64: -watchdog: invalid option



