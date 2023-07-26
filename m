Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7D9763A2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 17:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbjGZPFs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 11:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbjGZPFM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:05:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620AC423B;
        Wed, 26 Jul 2023 08:04:43 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q7vRAv017565;
        Wed, 26 Jul 2023 15:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=RR9UF1M+fG8Ir875RUrYCgKJv42OdR4GG7/Vzq1U3xE=;
 b=beZTofTheUF0r3rXHDCyz34HU8Nz2P+Lgduwnqvlc68TfGYFueaozDkuk3gEcSe6MHiI
 sJJW305G9yoQB+kCxHt4ayQK+GQdXMdEJZCNrUdi9XPU1j551BbksTXzRNUz/M9WFL3c
 /FvpY71eWACApbEp58VYWUvKiR5gF46p9+RIBwJYyCshOIkC2DJW6v0MQHA/ly6/Hf7U
 p8ZxUjlzXmc/zy32de79NY0+08P2Z9F4RpEFxoQmSma81TMHzTU2vvW2649xUZDxI5bY
 qAhLhNmDBMmmnuZRUG3Y2yE5SXmNgkP8ZwwoYLTU0e2oJVixspffoykP/u1Cum2+fhaY HQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s061c7qy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 15:03:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36QEEfYx011917;
        Wed, 26 Jul 2023 15:02:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j6jwe4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 15:02:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtFFbd4rXWIVpnIt0JmX3iK3pKfVb6tmnjKP1immOTfivYKB8UU0ubbhS+JqUdhsCZJlGERL0u+URED2bWCOUlegLb55lsnm7AAi5UXLoRTgNzKvUOpqQJrPSLGsC1PAcxpO7KR4ed300LUUpALsb/IXSY0tSEEvju94Xe+hkDjYvxh6Qy/2kwYeAssWXCb4HpP/QEVN/Ouic8Mo8h/u2GypIR/XBCHCdniY7D9PkN52lLmGawwvR6gOe0aWikI8KbADFtC16x4/q0ELO2B/FrwLD+fP9tgxUHL207SOt1UcsYSB5ObiC4n9kd1kOeekxOocuwFEH2ZaRWYvZKHo0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RR9UF1M+fG8Ir875RUrYCgKJv42OdR4GG7/Vzq1U3xE=;
 b=ds5w1fTbbR0XK9uLpeNxbJrYCWHd9vVPSoE/16j55g9snZVWEmgsQvIaj7h1dYoZN5k8OZUZHc/VQCuJwNTqHSBJ/SVuNw9OfLGJNR2OMvqqoXGyVbRkg13k3UW9Ah+yYh86HCOQ6/31Sz9OpnOHgiWDwFXDA1BjvOho+T4mInrvxTKEK58b6HbGXgRZijBSw73nyrAReLtFPU2gJo0ga5ej9lMjVXxSL8a6bw+PsGU6btHwV89DZRKQR8LBckEXr/mSgRsvnmd5RmUgiTUfpi/9jJ6QwM9+mVZOPSWVhX/A7p8Vwqs3ZXPY7/t9jr+TDDk46QrPSu+O0IywsET7vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR9UF1M+fG8Ir875RUrYCgKJv42OdR4GG7/Vzq1U3xE=;
 b=f3uhtbmPrR2SoQsyovoK9qyebNvesFv1CppB5a8WwIqSFmJ0B3BVouWP8iNS5LmApnJDPwftGoLJ9ckuod2/skXWAJTRcc/1kcs1XAb2287uc/+RzBgRFG4wsAckTYAJ4uS05oR2OsSl2J3GMDllcXMA9fAwxrYMh2W+eoIVDNo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5552.namprd10.prod.outlook.com (2603:10b6:a03:3da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 15:02:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 15:02:55 +0000
Date:   Wed, 26 Jul 2023 11:02:52 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/11] maple_tree: Add some helper functions
Message-ID: <20230726150252.x56owgz3ikujzicu@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
 <20230726080916.17454-4-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726080916.17454-4-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0339.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::22) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB5552:EE_
X-MS-Office365-Filtering-Correlation-Id: bfff3f94-bb3a-4f85-c180-08db8de9647d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQ+Med6ncsXaU8Rp/VPdDUxI5imYDB+vD5LgxmSwgxZwv153xj4RWwPXl3u3MMuQtcRNJfHTY/Gc8AxN5sir2chZhRjIv4IcQsrE/zvW3z3T7HKnBNWQrJ9BOCYesL1XJCa79Bkjqm6o+Kqv90LE7CRqTDtvY2Jado/JIzCB+TV6z/n77hheZlvs1xftPwehklq5Cj1Ykx7MF7OsCPlEs94NqVO6BuBa4hVGr2r1JXNAZkDIjlxewkWoKrPkHzJScARhKlywJQykpi52XLK4jxw4zNVF2IbOb409nd1rfi0G1X3n0maSQHx64cisXpKV2BfcqLDo3MHAJBtVf+MAo7iqJUvYppwzgTJZTJ7fXZZ9M1uy1DE08crk707DKsjl5yXvdstTGsf0SsKQcv4yjd2XtupC36nLUQqRghPeY7SBsy5MFyR7/ni6A7TRjYCfTw1wtLmGOMi5WYrNm96xXZtnhynWBYIAcs75PnUWsRCDd02J+77uXWZTAlQaHaJYrpJ5L91F7eOECeKWXMv4lcWxqPc9dGgjVB+8L9GwkBJJF0j4qQ4rsQ0iVflKz5Ok
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199021)(86362001)(33716001)(2906002)(7416002)(83380400001)(186003)(6506007)(26005)(1076003)(6666004)(9686003)(6512007)(6486002)(38100700002)(478600001)(4326008)(316002)(8936002)(8676002)(66946007)(6916009)(66556008)(66476007)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+WXdehoGwJw3shuUQdRU9J4VjpOKhU2AzQXZH8OPZ0xld8PgIh5/gEIoF/3J?=
 =?us-ascii?Q?4h6EihSf1G4YuqT/OoFlxfD6OuI0GIjQ7OB84T4JUAmaW89sHkWXZdp6Cteh?=
 =?us-ascii?Q?RhiYkQA5QmFfPmOsSytW+NjzXiqyA5ldY2JnQw6aQbRfFWt4sQFjZwuMt6he?=
 =?us-ascii?Q?Pz3lnt/HSXa3PZxoMxrT0IRDG+qY3ENSPU11pXS4Lf/lXmmLqZsp0NVaEVZP?=
 =?us-ascii?Q?yZRdXR0AJJAkE2/f6HUFR17V95IrnsCj5UngmY1HYfjcwJ+N/D3nEcQJHBua?=
 =?us-ascii?Q?PNctbbmYWEeu5yTT7su9aBTIZUtNd90Ru/5S+jCzl9tyk1LQojMWdig9vywx?=
 =?us-ascii?Q?j1PW0BXBjbwRsdZe7ehebfqZ81CkeJId0SyvCloDPlttTW1MpcHtllK5zbPe?=
 =?us-ascii?Q?m2JrKfBIK85zSMmrTljPFCYmfSD27zal/8jOk/67IeFEQXisZ59cJVcXVGbZ?=
 =?us-ascii?Q?PLOHn5Uz+u660EHPudv50c6Uziei9+oHHY3sDw8ApBkXoddb0bQgBVBt93QG?=
 =?us-ascii?Q?/zFXZC7MnZH4lXj/Gj7KWv8aN3kBCdEHll7ViMn4V06MzbEnz/TlrgWY92gX?=
 =?us-ascii?Q?VO7PzTWv/hNYHNnFgJNA/xIE1EFm+vrPn/PiOVfYQdAm/fA/9+y0cKaKrBMQ?=
 =?us-ascii?Q?FPpfjSm/oYde7ZVmpplsqO7SsVpFvieTzn1BwQMl7H1M3IB7qmCpD8i1JUeF?=
 =?us-ascii?Q?3ztcsK6vrLgExwWZfahQ0LreM7343SYivlZnh/kES/ufHWCbuqcy/UmGb1zG?=
 =?us-ascii?Q?QpWjKfSTASgIgOrdKuqOioLoHaOLQldFBDyTkfXzq2uZwgJLj9j7+jWAodPy?=
 =?us-ascii?Q?cultKDZFpcQnhkIR0cQeQEMtIYZY1oL+S2XzDfWAHy3YMQAjY47dm9PuWc4V?=
 =?us-ascii?Q?FRb+xeVvxbJWPwqd7gRpKL6FbyCz8sjfO/BR1dKnDv0akveicG8fAhXRvYVa?=
 =?us-ascii?Q?0JkaBpocEhIEKGQoY6Nh+of/XuIeqwPdYaWqWApS4hAM22objHV19GaCzFYO?=
 =?us-ascii?Q?uEjuh4Lr75vZIUsUs1ObPivPbS/nRAEMv9eAYCu9RLhuFZmzpLHkC/TSZe/F?=
 =?us-ascii?Q?xa8b4WB9KbDHt35qQLLu5F4BPLv5+rkF9o7FZoWjDBk3/Pwizhm21Ov4YWqK?=
 =?us-ascii?Q?Fazkw7dIYDf2Gy3cO94RJOq3XRx2D70JKRsLaMpiuKBcKNXITjLprTIFGj4T?=
 =?us-ascii?Q?2CnE331ovrzZL23DRjkNHw5ihAJRr3vEcJZ/z49cIatEQfQLst3uWWGIbg0r?=
 =?us-ascii?Q?V8N50+Q6SjPxOPf0VJgWpaUihFbLtPZg63z8ZktGLimYeWUFbNpspVlPMr4t?=
 =?us-ascii?Q?K0ys9+ik11AfIuF9zPKRsdwJNuvjDDL0eqS1pX0nQqrPmbucmWiCF6SOepHj?=
 =?us-ascii?Q?UYgZUmB9Z7pJ8nLzCOL3+vIsEBhbH0ITIw4sh0uY+yevEHtOmE0U0jHjWrt1?=
 =?us-ascii?Q?leMbbJUjsXluAZppp3gfX8IYXMwLIF5vzIIHqrToLvTGapyPg2fTUTG3fAhO?=
 =?us-ascii?Q?Jv5YkTfna6J8m53z2EjMP6dbHuw6/jXTORj8m24BOoup7pt8KDLJHzrSP6V/?=
 =?us-ascii?Q?B3W7mD9GpW97ZuHKd/BA1iU0of6mv1OkG3n0vRbTWtNzOzTWb1Xt6gfiTr5z?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?DXQmDZJkfi8QAEEEGf7qI1k/MXjfFH4RJKx6z6fdfsbohw5oaEMh91BDZc1E?=
 =?us-ascii?Q?2F0y/EC1TIJBySTX4vq+1TBWq45UiJblVsEzH2CZszGOOf6I1GO1qvdFGLW+?=
 =?us-ascii?Q?l55Dp95j0rTM/kS7iSsI1wHKagA1+CVG9KCa9e08yiUmRra3kKVivIlb3DzF?=
 =?us-ascii?Q?b3pME6Pg0rpEIf5R+GghAG7Ubax9IQatflkQeTZ+hsNniMtdrOxUU2pFKL8Z?=
 =?us-ascii?Q?52CGAIrcXM86B/0fK7ju5vdgb7mK6YR0VWv/ojGvod4RtBsUn5SPJmPgzwey?=
 =?us-ascii?Q?AaNshFjThF1gnBfmliThv+yP6uHEW/t+eOrLAy9avXYqfC6HtwHK7Q9k7dFm?=
 =?us-ascii?Q?0bFm/wGOTqYGImbdMP/8xTHo/7Isxt708Kb135KKiqppzyq6i1NE7MlEC8py?=
 =?us-ascii?Q?nxsbhOcNFpyvhCMYNXMiWxOXEEtmAj+quDfsUY5gty/+Ilc5287SaSIiNtYq?=
 =?us-ascii?Q?OEoca2yr/GlanhyPLXwAuRXs/qooRnx7LnQ7avskwrfs9KbiWYYIvneOp4FO?=
 =?us-ascii?Q?TRTa4f2ApzrjdCMzHut/ieNJOQaBpinHHtyxjioCRaHL0VaDuFHb0DI9r9i9?=
 =?us-ascii?Q?VjZqRlI91OljAY9+KDcI29GmFBgKFFsrYPKhSXoiqHd+xJJ/TQUAs7YVMZ/9?=
 =?us-ascii?Q?uttTlsC2FRMesovdzLm8Xe0Z5CQ50ACy7FwhCp9EHmUOMbOVsCBflmlrAtOM?=
 =?us-ascii?Q?SqELvrSJm9R5Kd5C9S7tlF1qyVhCNiaal1z0txiq2PYHP1PjzNTW7zincxRW?=
 =?us-ascii?Q?q13DdDqB2203MLPBR4VhG8xuaR0N0a0KHiZpwU20RtK4Dsfsi9GrChmiyGh5?=
 =?us-ascii?Q?BZTlzmn5nNHexO4PuZVty6TF1yiC2yYDGzIO8hDhyYNfqAtQYR2Xpe6ZWB6Y?=
 =?us-ascii?Q?WD8Mkm+fC8qpJ5dMq09mNa6u7oab1X8ClH+HhNj/9WT4bvXEUP2DsgarLviH?=
 =?us-ascii?Q?YqGOxQevkjaO0IIUraOqe7bU7elcwS9NfPp9CJcYe0EqL3A5pB8nuY9oDTAL?=
 =?us-ascii?Q?yUAsHySbf+P/77TbooldrTCK2fMLa4lHzQpsdWOgvqcdLSY9DScZcKBSLlw1?=
 =?us-ascii?Q?a4DYvMq6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfff3f94-bb3a-4f85-c180-08db8de9647d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 15:02:55.7110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n8FlfIsaVFHh6s3yYHoLqLjDrFL5iymMkGEmC7dvfXFf0MP6J5TTEhYMQwi7x9wct/fKZHvoWmUSS7aOs9DpKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5552
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307260133
X-Proofpoint-ORIG-GUID: LcyRf-GKWjDF1Cm4BjkilJ6mzSwGPgZd
X-Proofpoint-GUID: LcyRf-GKWjDF1Cm4BjkilJ6mzSwGPgZd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230726 04:10]:
> Add some helper functions so that their parameters are maple node
> instead of maple enode, these functions will be used later.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 71 +++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 55 insertions(+), 16 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index e0e9a87bdb43..da3a2fb405c0 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -164,6 +164,11 @@ static inline int mt_alloc_bulk(gfp_t gfp, size_t size, void **nodes)
>  	return kmem_cache_alloc_bulk(maple_node_cache, gfp, size, nodes);
>  }
>  
> +static inline void mt_free_one(struct maple_node *node)
> +{
> +	kmem_cache_free(maple_node_cache, node);
> +}
> +

There is a place in mas_destroy() that could use this if it is added.

>  static inline void mt_free_bulk(size_t size, void __rcu **nodes)
>  {
>  	kmem_cache_free_bulk(maple_node_cache, size, (void **)nodes);
> @@ -432,18 +437,18 @@ static inline unsigned long mte_parent_slot_mask(unsigned long parent)
>  }
>  
>  /*
> - * mas_parent_type() - Return the maple_type of the parent from the stored
> - * parent type.
> - * @mas: The maple state
> - * @enode: The maple_enode to extract the parent's enum
> + * ma_parent_type() - Return the maple_type of the parent from the stored parent
> + * type.
> + * @mt: The maple tree
> + * @node: The maple_node to extract the parent's enum
>   * Return: The node->parent maple_type
>   */
>  static inline
> -enum maple_type mas_parent_type(struct ma_state *mas, struct maple_enode *enode)
> +enum maple_type ma_parent_type(struct maple_tree *mt, struct maple_node *node)

I was trying to keep ma_* prefix to mean the first argument is
maple_node and mt_* to mean maple_tree.  I wasn't entirely successful
with this and I do see why you want to use ma_, but maybe reverse the
arguments here?

>  {
>  	unsigned long p_type;
>  
> -	p_type = (unsigned long)mte_to_node(enode)->parent;
> +	p_type = (unsigned long)node->parent;
>  	if (WARN_ON(p_type & MAPLE_PARENT_ROOT))
>  		return 0;
>  
> @@ -451,7 +456,7 @@ enum maple_type mas_parent_type(struct ma_state *mas, struct maple_enode *enode)
>  	p_type &= ~mte_parent_slot_mask(p_type);
>  	switch (p_type) {
>  	case MAPLE_PARENT_RANGE64: /* or MAPLE_PARENT_ARANGE64 */
> -		if (mt_is_alloc(mas->tree))
> +		if (mt_is_alloc(mt))
>  			return maple_arange_64;
>  		return maple_range_64;
>  	}
> @@ -459,6 +464,19 @@ enum maple_type mas_parent_type(struct ma_state *mas, struct maple_enode *enode)
>  	return 0;
>  }
>  
> +/*
> + * mas_parent_type() - Return the maple_type of the parent from the stored
> + * parent type.
> + * @mas: The maple state
> + * @enode: The maple_enode to extract the parent's enum
> + * Return: The node->parent maple_type
> + */
> +static inline
> +enum maple_type mas_parent_type(struct ma_state *mas, struct maple_enode *enode)
> +{
> +	return ma_parent_type(mas->tree, mte_to_node(enode));
> +}
> +
>  /*
>   * mas_set_parent() - Set the parent node and encode the slot
>   * @enode: The encoded maple node.
> @@ -499,14 +517,14 @@ void mas_set_parent(struct ma_state *mas, struct maple_enode *enode,
>  }
>  
>  /*
> - * mte_parent_slot() - get the parent slot of @enode.
> - * @enode: The encoded maple node.
> + * ma_parent_slot() - get the parent slot of @node.
> + * @node: The maple node.
>   *
> - * Return: The slot in the parent node where @enode resides.
> + * Return: The slot in the parent node where @node resides.
>   */
> -static inline unsigned int mte_parent_slot(const struct maple_enode *enode)
> +static inline unsigned int ma_parent_slot(const struct maple_node *node)
>  {
> -	unsigned long val = (unsigned long)mte_to_node(enode)->parent;
> +	unsigned long val = (unsigned long)node->parent;
>  
>  	if (val & MA_ROOT_PARENT)
>  		return 0;
> @@ -519,15 +537,36 @@ static inline unsigned int mte_parent_slot(const struct maple_enode *enode)
>  }
>  
>  /*
> - * mte_parent() - Get the parent of @node.
> - * @node: The encoded maple node.
> + * mte_parent_slot() - get the parent slot of @enode.
> + * @enode: The encoded maple node.
> + *
> + * Return: The slot in the parent node where @enode resides.
> + */
> +static inline unsigned int mte_parent_slot(const struct maple_enode *enode)
> +{
> +	return ma_parent_slot(mte_to_node(enode));
> +}
> +
> +/*
> + * ma_parent() - Get the parent of @node.
> + * @node: The maple node.
> + *
> + * Return: The parent maple node.
> + */
> +static inline struct maple_node *ma_parent(const struct maple_node *node)

I had a lot of these helpers before, but they eventually became used so
little that I dropped them.

> +{
> +	return (void *)((unsigned long)(node->parent) & ~MAPLE_NODE_MASK);
> +}
> +
> +/*
> + * mte_parent() - Get the parent of @enode.
> + * @enode: The encoded maple node.
>   *
>   * Return: The parent maple node.
>   */
>  static inline struct maple_node *mte_parent(const struct maple_enode *enode)
>  {
> -	return (void *)((unsigned long)
> -			(mte_to_node(enode)->parent) & ~MAPLE_NODE_MASK);
> +	return ma_parent(mte_to_node(enode));
>  }
>  
>  /*
> -- 
> 2.20.1
> 
