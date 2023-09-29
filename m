Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722F27B3ADE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 21:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjI2T6V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 15:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjI2T6S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:58:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42909CC6;
        Fri, 29 Sep 2023 12:58:12 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TIJklT007854;
        Fri, 29 Sep 2023 19:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=DcOBsuyC6eJzGgTxS/Ba1UO3Qtd8gK01kYA7zEBO4g0=;
 b=fCTRlbcdDoai7BVsNYNVxnRqxLB4MwnIh3hB0M0H030Yo6FdbfaykuBua2QCFfiOHYvd
 S72BKgRVo0aesHp2/Ga2YhMmPoi3V0bCdf4gu0QhsQwB++1tu3ye7HrwVXbWQQnGEoXd
 ObBQ0EB6cUtdBE4aPK4X7OzE7wbqt/+DxuSMDozOhzhSHCLMSzJUp1ZH0mDLaZa4e5F7
 uHljn8fKDF8YwqGj0U2XEu5SPiMbKSKEYJgEfbyudkPn7VAX6gcoXOD48GENuujPt/ib
 pVDg3YQSzoR/BNzBUHOOac2DwiJQvWFYJ5zMOUlK3loE+Zu2IKmPkAl7/7sRJ+RJJJcN LQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pm2fmbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 19:58:05 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38TI2jta015817;
        Fri, 29 Sep 2023 19:58:04 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfhtwqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 19:58:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7goZuEQn+najtvM9ck7TXS5M+jvZw8K6+d3aDocIoz1t9ON12xviTCoy/mO4LPQbrWS7KQEv1BiwUDlja7gLPGxPntcLcRazpF8rssN2JkeYe6ueXW7PVJqtaSQ9Ir3WgOOOWPL6OtJbF9HjxDa9kHQhCvYEPxNqBlOegdPqdYZxMGIyVd9nJY3jUDz7BCAqM4qhPsjpwE0ck3MUzOPZxgiobqDyQoTUK2Hv7L8Fk/fmYhveG14gKlDUBp2p+HjdPZ9w5KIZXlPA38vdL/8ltgKLC+3U96Pw56jpN/9tdWsa0YA7ZcBxcLzsMB085VrZNnXyZdppSmjLuZt8m2vZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcOBsuyC6eJzGgTxS/Ba1UO3Qtd8gK01kYA7zEBO4g0=;
 b=N7JY9+yyXp0CiMq2q/C3bn7+dkc7y28bd/eMVlTZSqAgHLN7UBY7xXYTJXe2/aQYTfdifAEfGSs6wb+/CWVJPC28wEaPwU9AN/pgUQCjshJ1akXeuj/x1lqIZoJ1IctiyAdqfTJ5qAZgiZFaqBrOURhrLbXuQCIuzemsnHX8xQ/GiM2/4Yk2E04hU8mM5yQwatywzhzVBXynitqAXTVpcQ1BJYyQ9KFigTYgCIW+oARDHDWWlsX8PllRHlv2T9TD2w/dXIctlatfV8cxiPmv0r5siObVte8mQOgdSA5qzkxXLQhYgMdE+YT9XgMYSKal3eBq8WxvgWCb5i9YteZuUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcOBsuyC6eJzGgTxS/Ba1UO3Qtd8gK01kYA7zEBO4g0=;
 b=d7FFTtZQiAaJXMcno0YBnYssy8ie1yTZlg4zOMRCKUv+1FV/xl/m4Y+4jh22fMChF09gxdSHOX9JiwkvvlZ8u6VRVAqAHL0LVK0ZYOcY+Kh5nvOFVjRigNUPfRAOOvukX+yRyNeyza+bijWtcgKhTNAqXHTtKzAC52vW9bfih2c=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB5939.namprd10.prod.outlook.com (2603:10b6:930:e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 29 Sep
 2023 19:58:01 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 19:58:01 +0000
Date:   Fri, 29 Sep 2023 15:57:59 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] radix tree test suite: Fix a memory initialization issue
Message-ID: <20230929195759.p7pgb6qtofdks2yy@revolver>
References: <b1f490b450b14dd754a45f91bb1abd622ce8d4f7.1695935486.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b1f490b450b14dd754a45f91bb1abd622ce8d4f7.1695935486.git.christophe.jaillet@wanadoo.fr>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0279.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::17) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY5PR10MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: a472f57b-1a28-4d52-4234-08dbc12662d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lMTyYNsvVxsgDAk5QPzbv5UzUk3iGitAFl5VTf+zHCo3vL5vFvTtuMDNdOfatt74mSBx8dzMVYGInMOUVv1jAclaltARlvUyB8eFuqn5pFTzIopGqQsloZU2ApaOy5+sz/2zvs39MUtfVoB0ZMxta7BHJx6vOOIAbpNmd9aNtwcspxAqpzuEL1ZsaPgzmDRVhTrRnCRwAgbtOq21E/UYKharXrBmXd7CWT43smeid0habB1bMcyrj/+Vx0lJ0ZgXRWV/8JpMyxYm/JxnAiP4a7NiaNgOUn2fZBaQgSpv3m4gtkvEFiqT435Jf+TGUGpXOzjz/kzkoQhcBHgqtKcU7fRKvfF9j0vNaJAXtFHklFTKd5YI/OLBeV3rYTU774PTGWKjukeNSmKDidhgjimFzEOigM/EEkWjTm15BkY+dxuDUsUztFoXN31TzILriwL0mgsfg2xoTr+hLREjCJOzCgyPZP7tVsqk1VmkN1QF/JlVUiqa3VcYRK+E/wOfHEEIeP2Ln2nEBjh2REvkM4xf6gxac2nC0vr7oM8TAjDFx6aeihELGzfHhFPoEThjA1O/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(346002)(396003)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(8936002)(5660300002)(4326008)(8676002)(41300700001)(66476007)(66556008)(54906003)(316002)(6916009)(38100700002)(33716001)(83380400001)(2906002)(26005)(478600001)(6506007)(1076003)(6486002)(66946007)(6512007)(9686003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zuISsLlZEykwLhGH/KKA/1hQh6Wn6r47mdTUmYpN819Z+wHi/2yyB2jy0bjV?=
 =?us-ascii?Q?PQwWD2oJZL5iYcJp+4NtE5vhZlcGrZkOLw4sEv6QjwYoM9UkOXkTxZFLDu1a?=
 =?us-ascii?Q?n8r9CFdDMafmpOVBQWBTSwcJhhu2JWT1vjpOX19TPFV7j8yQ9L+/uYoZQ2NH?=
 =?us-ascii?Q?MQadff1ZoxvupzwW+sPTa7gvHrbQJhFId6gqxtz1qeNyRaA9YWWeV1i7a20b?=
 =?us-ascii?Q?MMCdlhdDEO2SdQtm93/afT/V5rK3LKoxCRZgKC7utpx5EVO2clMLfztlpMrN?=
 =?us-ascii?Q?OfhBg6z4uhYnKwltwzrByW9+GlmPrVwPrWRChdB4ygp2A/tJ1zABznHYf0hm?=
 =?us-ascii?Q?cRy0ZnL4ki2EJx4qskDuLdTwp2edUxPD2emvyr0URH0Ymzd6jxS+Uyh6yOMy?=
 =?us-ascii?Q?mdnvQDV/rEju04db3MFyBaJqtHWX9cSiLi0ZhstvPVQtikIWwRd8AxoXmhuB?=
 =?us-ascii?Q?Eb2J+CpoiEEx6oilReFwJqQQl0sILRcvMd8M/dTw4b4nTTCaCYjC4rEJfh/1?=
 =?us-ascii?Q?xI+AjaXl2n+HwMHZCte2KgP/mxySMULU0XvXqyVqoHmvvtltzGGMJMy6SGIE?=
 =?us-ascii?Q?E041cFYlPsyxaHDnh4dtXjJ6uXh/jR1CyuS0jD0cQnxXvNp2gnrmR9gCTJuU?=
 =?us-ascii?Q?nd1Lu/gGs7jmGeBjs4k/BhBiME2uGnwaBSBY8Ve/sxs2n7ilttaFMT4KLaQg?=
 =?us-ascii?Q?wsmlHWCGCHCTCrnDtlFoFWIROjNU5/3MTGlh9arVpBP4qxmjo9dbzcRR0fzi?=
 =?us-ascii?Q?sefbgJQyYHrIXYzDaVEo6D0mXoE51SoJiEUmQUxUmhc33YBycu3jB4aqkGYJ?=
 =?us-ascii?Q?0CjrR/csqNZg4I56J/gX31t8tCVPJtSlKLiy/iu3oV5bRoCCV9LYt7uHfhaM?=
 =?us-ascii?Q?dK+dTVzRGmzIOkdeqJNQcehPOpEoLsVYYs2wWuxK8cfXqoeSsNYlOkoXsosl?=
 =?us-ascii?Q?U0TSgcUPzk0zlEtcMexFuiO2yJoHU7qhIWysfwude+W1aNvmCtotkwpIvarw?=
 =?us-ascii?Q?Zbs1jQnKnogXYJEToe9OZokgX5f2eBWDauXQZtWuGaK6iUxJ31cv0C6VyZMs?=
 =?us-ascii?Q?heKN5Mnzhrj11J46Rrm0GkP6PHJyyY8WibDQVnCJxe12tDIP1uNsoOqZQrcz?=
 =?us-ascii?Q?X8/0N49UrDm11RqIAYL7tOy53CwKTUUrDbZbIQ14JSNvgGBpG4cjISvymnIQ?=
 =?us-ascii?Q?23uCaIfjW34R0vD2YingQbXXzs1rhCs6NG9VkfJVl3S/EC+qbsPhUljJGEsW?=
 =?us-ascii?Q?RgnrQRcHAtpY0Ip2ewo3oW70w+ccAeU3pPS0j2uf3GugCwW+/zIgQ5G9CeEv?=
 =?us-ascii?Q?+CKQtC8hjNonu2Nq1jFoX7Q5HH2rrtxfUwjAAuf0nAGIRjNYgZGFfjYnu6ch?=
 =?us-ascii?Q?v/Dn31hlUuSFdV2X4VIttKUZ1kGuXPHnO46y7xdh3IgV398pdcLcOXwCetE0?=
 =?us-ascii?Q?X7oHJBJQ6nHjeDarjpUiUkfm3Tstkhh4viSsFzuI+KBZE7DdTK7C+yKUcbjg?=
 =?us-ascii?Q?XQ098VjDwOl1mzlWW+PJyEfk93lCRCwglGfcYV5Sbo6m7Qfna3P+kzgKIfzt?=
 =?us-ascii?Q?R0Q4kEajL8ICBRszaLLaxqAF6KaSTBUwpghbB9RKFSOoZIEZK5ohaVCvfg1i?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zefEp+0U2QdZPjnzkBNyyRrbm2TMUHDkTs59AOvszXKJK41k5W6k1O4LI2V9qJdIka0rdWCZMlR2uW0mU52b0CkRvivIhsARZOw7rGhlNEoKoccF34b2+7IU0d0vmnun/inPyFY4LL4ufmmT6IVlddPaJ2HanBelBqbIB47YGRLQzA7Fe5LfOopSr8AJyfkxJXiqWabzaldfw/PiK2HuC+9iQ0Fqeoqxg8QlND/2MgWSP6WXfBSCBiV7cqowfFVSPgCKdAc+TS+eglLBamFgPz3uLSxXZr4vU10ddB0yWjyIGsvrzReMPDW2rdTsgCxdVUExJRNWZC2gGkw5KmuPCdQBldwTrwlmmZ1Q8dE62fHdKcVVTUxd0Ai9304vyViienRd0L8PkG2rDOPEXLeBPHUWcd3xFJ0+8xW9065Z/iMxwMjmCIOsqr6Is6v5It2JFWKQRHPh9MBaSR/PSYt8OS+L3XO6sZXneHgVzAyuyetdybTNyMCc0lErE40x48WDZCaE7lRkD2YCeyyN/Z7D5SxtWydNC/hHFab2Pe/dJ1koI2m05nhPfK3KPyR8B03jN+5UHVrfaGkTb6d0pTHY7ZUQ47qZbcmm9H8vDJdYXy6yXaAABntR/AH248adZJ1eODqHGzaF/oLFMDOaWNmeNUYR76oAY1jWA+WF2Ku/v052AbdWCHF4uBlRhreWAAaypuLueHl80cr/CXH4XveZcQ+BuQEnw4y3yMY7BjTVZ+HFUJiSEaewYS0A0/1ERNvt2rhzDnI55E79vJYKFXaPNsV+GmhpXYEYb9rZVqAZuxyFO5XR0xos/uWMkP/lGzBtYNpcoeKG93pNm4WGKwzQ7ON494033uyYMMwgegO05b46YDs/kMOWRP/8UNc/TDFn
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a472f57b-1a28-4d52-4234-08dbc12662d7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 19:58:01.6999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /C33yh1s7a9yY0au6FKyT3/vaX2WRtrggnkqX92ZlcOqNPWylafo9Gj5xDJ7Es8erhIq1vKHajt7panOq0oGAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5939
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_18,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=772 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290171
X-Proofpoint-ORIG-GUID: WSeJ2q5x93b6d20dRxYEeh2xylhBEoT7
X-Proofpoint-GUID: WSeJ2q5x93b6d20dRxYEeh2xylhBEoT7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Christophe JAILLET <christophe.jaillet@wanadoo.fr> [230928 17:11]:
> If __GFP_ZERO is used, the whole allocated memory should be cleared, not
> the first part of it only.
>=20
> Fixes: cc86e0c2f306 ("radix tree test suite: add support for slab bulk AP=
Is")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  tools/testing/radix-tree/linux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/=
linux.c
> index d587a558997f..8ab162c48629 100644
> --- a/tools/testing/radix-tree/linux.c
> +++ b/tools/testing/radix-tree/linux.c
> @@ -172,7 +172,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *cachep, =
gfp_t gfp, size_t size,
>  			if (cachep->ctor)
>  				cachep->ctor(p[i]);
>  			else if (gfp & __GFP_ZERO)
> -				memset(p[i], 0, cachep->size);
> +				memset(p[i], 0, cachep->size * size);
>  		}
>  	}


This doesn't look right.  In fact, I think you have taken a bug and
extended it to clear the bugs over-allocation worth of memory.

The bulk allocator allocates to the array (here it's p) of a given size
(size).  Each kmem_cache has a size pre-set, that is, each allocation
from that cache is of size cachep->size.

What you are doing is zeroing each pointer for the entire size of the
allocation for the entire range, and not just one elements worth. This
isn't crashing because we are allocating too much memory to begin with.

Note that this zeroing is in a for loop:
	for (i =3D 0; i < size; i++) {
		...
	}

So, really the bug is that we are over-allocating and not that we aren't
zeroing the entire thing.

If you drop size from these arguments and use LSAN to check that things
are not overrun, then you will see that we can reduce the allocation by
a lot and still run correctly.

Thanks,
Liam
