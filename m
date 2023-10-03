Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049057B7141
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 20:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240823AbjJCSqi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 14:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbjJCSqh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:46:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E2D9B;
        Tue,  3 Oct 2023 11:46:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393I4MM4027082;
        Tue, 3 Oct 2023 18:45:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=isyLHuzPxdNa25BpOIeU+uyKJWFMkwTa/WHIhf92H/0=;
 b=FAJCBfNneNp454oHmR5WFdpqR0t1UWBUP+XWIxYXH/Sgm1/Dc2Cd6dWU2ldKalzduxeY
 KQEZBFN01DG09K2I8d7dHo9JtdPsqPcxAA/TvoUmmQSON6flY1vWIEEiMRlhCQyRhaHK
 QYGw+ZJT/503cDlGdEPW0BBFvFdrjnJBzGIsrCIwIGyBYDED5Vj7fugo3f90LFuSEyY3
 ZICyqG0yT7HLBWhN2G47K8W7a2DOsYtiA4jhCBZwRoSSxYqRtHmV0rWxtRJ1kn3+WYlQ
 Ma0HNo2IAsHwcoKUyhQKQppyprid5KrCqe5MTZTtfAVgW4ejQTEXAPBY2R/tYS1+ZpG9 XA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teaf45gbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 18:45:51 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 393IEvWt002853;
        Tue, 3 Oct 2023 18:45:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea46ex0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 18:45:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzEHkzY5jDgKf3LHtHVD6fjx0d70YZDVk6q48kf2ZBLD7YiMv2m6dewqgoOFBRA0LScf1b6KKHL0XKTt9U2P6UP0+NhQrPU+wD6uabi2EqsKLQXw2/wxo8H7F/+oWgCbecqVzAr4vBcYKps7//9Gqsh1WsKiFb8Asq+RG+va89RD4RUS7Koon1/vIU1gLZsgo10XoRIggd6xS0uO/yRM2L1QsqQJ65/U87rxh3H2Wgpc/GiS6+blWfXICmjBYYzulPy7DAl1jOaz6+V6YvE3fCP+heY047JGKLDjgihPpy0IAfrQgqWf4GcHwjkzOE4AhBWC9T9v391sjcAa4lPY9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isyLHuzPxdNa25BpOIeU+uyKJWFMkwTa/WHIhf92H/0=;
 b=av9UKRb3a46XY1xg0xQNWhXfbgWzinYnCHJZKQ6aXziNgPSX1uuNvGoXFFohgrCN4B0hO7aqBUQwrPvCM8RmKrQDX7lCRWDwlWmGldl9D6hHm2l2BLwKh5U2HRWUGnQBaeGe8b7Lk16om4EcbqkQB2Te5uDn4Tosoh8vuCvA3Vucs0c2t9atPx/1JN00wRzekmwbyXK+oMMmLa4U2XVrs8ca6j8dAKWDrBknPV9AxklgPTO45PXhPkPFkZ3weyzs5syD7pqYi7oSx6/cbDsA3sOYkcXeBPQWjdKpW+LyK1xboQXALld+gt/syhwk+pL45ICLJldwTzzJrfK7rItQZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isyLHuzPxdNa25BpOIeU+uyKJWFMkwTa/WHIhf92H/0=;
 b=yBZnr5NaqjucSwZXgezrFCDbtPDm7o/dXAB0EPp/oF0Wcs+S27ejup+g4+x73yNStvFEi4ejFHa7cW4N4HEYIvRa1eJy4g2avRdu3+j5/l7T8Uu3iSX2FLWai7oUMWRBoxFQmySlWhKVG9esIYMQrpR/sWUEfgc3VwMrgNmE+YM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6086.namprd10.prod.outlook.com (2603:10b6:8:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 18:45:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 18:45:46 +0000
Date:   Tue, 3 Oct 2023 14:45:42 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        mjguzik@gmail.com, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, peterz@infradead.org, oliver.sang@intel.com,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/9] maple_tree: Introduce interfaces __mt_dup() and
 mtree_dup()
Message-ID: <20231003184542.svldlilhgjc4nct4@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230925035617.84767-1-zhangpeng.00@bytedance.com>
 <20230925035617.84767-4-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925035617.84767-4-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::25) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: 47fe15cb-04e0-47fd-f9cc-08dbc440f45c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V9IMy4RudJHoc3q+1HfWeYUaS9yVUQ9Jkx52gSk8BKoMXDJnKi3x5AmM39OQVbPKvAfMhgZ7TvrFeIjFVv5m7QElMLQIbR49ymbqrUi8hO9C8XaQHu4nIqmV45IA5lh9xA2nxUiHsJnTu2/qYkJW8kCXHZYbqpAdua/cP3ePezjn3djHe3Ge8Tlls/P7upTcRSvR17peN82g6Piz1vOxi0G+dtsZOT7IjKSKG1R/KCwXXz/GvHzHnJ14gGyD++JoJj+PgvEenF59CRWaNpVqgQhBwlVV8Qy6XaXQ5ILMk48WX81JpVV7hApvevlZQrvTJgkUja6Khm5J9kxJroFvOW4/jgCdIF1n7umuHhd19Zl5rOzNo6bj7NTKfHlZOfC479sT+Go77qwBkMk3tZeTrcHbTtnyvDsfI1UYdJX0/XiqZd3UvygD2ZdRP0DejaYO8LYT2rP12+2KMGIf9wLc3HezqX9LbHKJuyShKW76QO2YgKuTqor7UMj/VuH/zS/rDQZnBTF43P+STbJ2GvVE5zgyhGTtydWCznr3tyCrxiTCGMN5yK6mYs71QF3P1b/v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(5660300002)(26005)(6666004)(4326008)(8676002)(8936002)(478600001)(86362001)(6486002)(38100700002)(66946007)(66556008)(66476007)(1076003)(316002)(6916009)(7416002)(9686003)(6512007)(6506007)(33716001)(30864003)(83380400001)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bWIad5NQRztsGzfLcO7yQyZQyGhhhLANeb7LS/FSjg89sF1TicP+jKvPRm22?=
 =?us-ascii?Q?NIYicW3VkDZLjZK9ulYV73Ko4CueXEdwS0JqiipdiHRt9SBaZcJmuiSMHKQa?=
 =?us-ascii?Q?CeIZqhrt1qjyeei0IXUvIkZrUTTFbt8ckk/2QFCt9yhNFrzGgzUZfb47SNx2?=
 =?us-ascii?Q?a547tN2v0Et/LytAKMm/o64YDv9UBqcXZmPGpB3zEvWjnquHogR64R5s+Zcy?=
 =?us-ascii?Q?qdbqwid8GgQiDmx9Ut0m0R3jageMG/AbBjzvzdQMBUdJgfjc21AgfNUCffBp?=
 =?us-ascii?Q?Z6CcGxspJiWiB4nOrgkDURCtxmPgkwJyh3+6wlj116+jqVe6YRnD8yuTicZJ?=
 =?us-ascii?Q?C/FBR83r2f1w8FHpHMqg1n1pb5O+e7gqV2U1BHBCbYkTy2gct9Tneyw3QNQk?=
 =?us-ascii?Q?l5+kyhUR3Ivrjp11Z6IIy6KguZ/URtn9sO/mgAmkIvJZsloaonaH3HrRAkao?=
 =?us-ascii?Q?sRxRAOXUJu7Ky2VkSDpfgVqSUVBJI2JA/Em56dyqwaxib6aSbYT2PxiWSSml?=
 =?us-ascii?Q?eKlPhvsj5wgFJgeYvvuO4+9nKHRJFk1qv3Lc7F6SkeS46OJD+h69ilBfc+C8?=
 =?us-ascii?Q?1+Za8E8W4yWtEx/a9cFxotEc9n0/CTXbTzLw2J3aIBJnp4XL6p1cWaag78qH?=
 =?us-ascii?Q?JK0JmX1rTdE+kM+oQJtFc9gLRp2+VYz7pmyzGLqocfG/FBhqVTxfW2+bmp9a?=
 =?us-ascii?Q?NdfHjBDaJt3Yp5QRxiwbm9Nwgm0bT/bY5Fxy33O94HSJ/V4j8aH3GjyJBInn?=
 =?us-ascii?Q?05+9P4eadNreTnXFbFy+M2Vhlsifw+orjIZp02Iaepe/NF4Ngi4D7MFKHA36?=
 =?us-ascii?Q?vIRGRV92dfSA0lbMFAdAICkm43QFe8xH4/au7swqFUfiIug4rsI5Y4owbbTS?=
 =?us-ascii?Q?E6DEWDOS/BdhPwriXKG0asRFdv9vlMYVSRmaAeLft07sXwD7RN+GcOBvx4bu?=
 =?us-ascii?Q?ZyGsoWvaA2xPJrTyRbFBaXRiSpMVNUYes3x3LFlCKexcgxCtNDE4PE8g7S2m?=
 =?us-ascii?Q?yhlx/8d096XmIu+DZE3nqGYxmoJbIGxLTqQOfD2GCDwknL3NamaKQGH/Q7wK?=
 =?us-ascii?Q?ObZLIat9QgLJ6pBxIaBanFVNx5bImCtpE4qMBqoExBQFR4rOFZp7Cri6/psi?=
 =?us-ascii?Q?baAxjGNRp7OIxulGOTmOxlkwOJWzaEdrlxvjkv7ZXIRgRFDodm0SPvRYUjOp?=
 =?us-ascii?Q?rvlVn4S+FzGgGc793ps4OqR2a/trRDTM9jj+Kt6knoP+UU9pPXWEzQLp18mQ?=
 =?us-ascii?Q?AgC4UFhzwKNQ8fZsSPRLMfYGyH4ny4f4DXaelqd0OHUZ1sqYX9jqAJY7ncgM?=
 =?us-ascii?Q?HGuMIms/AIxbUlBpYQETX0kL2RmSqk3kokrOPzKsBN/rqvmaYm6dj/0PWrag?=
 =?us-ascii?Q?2X7n5BbI74/TxvtDf+rz5AFGPEddRoWT9goP784gLVm44B/Qsq4rxOR7fUH/?=
 =?us-ascii?Q?99toryWwGxZn9qlOMxHSBdCEhsFk5C3ORdZsH54AA1tFDtQVlM62HU+FI7mD?=
 =?us-ascii?Q?eXAV6QeXNKBm9Ya9IAMdLWwUO9jQqpJeNdHLBZPiAn99jLP3fa0shSY87LlU?=
 =?us-ascii?Q?JWbO80TApkCrgrPbIGPQl3pD+pNJCTvhJ3F7jv+y?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?uktEu0QMjkr/bnvRhEpu7Xrgj5pBc/uPK+arm/Tiukm7SyR0WdHYUS0nTqpH?=
 =?us-ascii?Q?lw6jSyvgLiwQR9BwV5QDMk1ydSbjY81FCsVl1efOiOwyfvkPAl8KD4IdD+Ja?=
 =?us-ascii?Q?dc8UlA2WMpZp9wYJ0BOr7fshWlAdTrzec9ymHBNuTo2qz+mVe/aIa1dfh5hB?=
 =?us-ascii?Q?LFdTBjUHa1HhnshBo6W1ql7fTOZ+G3ggU1xh+dX5uWgeXENHQDYlscwDwVD4?=
 =?us-ascii?Q?fo48EKgS0NCyLC5HPTEL6Jfx2xDEag5QVU0KJEBA9cw+W7uUiGiGSA0Y8NbK?=
 =?us-ascii?Q?oMjwb1b6MudVIZctqWzJxSQ+ZCPJTxeBV2AAKSNSNlCRP1OwOGtcKIy8qj/M?=
 =?us-ascii?Q?p8ebYQGqSVNV6RJJEfBIXZgUkb+XJrPn4P4cdex3M6WLfTA+WJ82Vt8MmfEX?=
 =?us-ascii?Q?J91osDnwer1GS+jXx2aK96Z9AIEerFBfzcUU211afyyLrdhog+Qtm/rBD6fu?=
 =?us-ascii?Q?VOJWK8496RNc13+Y4gi9JY5rNjTa9tyBLjwH3/YiXqy4YdkQKfRJa18LS+AE?=
 =?us-ascii?Q?oLJwOCXMNxbwUlwgPJ4pA2zL9m9rVqAl/YqBor4Utg63JlC1tRrGMGiwrwWa?=
 =?us-ascii?Q?KXdwgQEr4uWdiWkJOoGWNL3l/6uJaAVXTVamdsxq7WwDiG5bC0tvVyVi9AKB?=
 =?us-ascii?Q?lW48PfqhYUlryDR8M6b7wqeIv3HKT4ge8jB021aDIK+sV8opFOg/hFI8visU?=
 =?us-ascii?Q?9D/wk+Ht0YHL7tvPEok8FFFEQ49f5iF/EWV8mB+y9vNG5xOjg9ZEhzmwM5Em?=
 =?us-ascii?Q?ZFOiHvB3aFLrDklEPfDiSUqp6YTXxC2uwsw+vJPzqm3sPMoD8a1QpuIDScn4?=
 =?us-ascii?Q?vBBLSfCeLkGzO2xRsHMG+r1bpUNpXThTjdJOj1+qRQ7x7BnYcf1RsOhXGu1Z?=
 =?us-ascii?Q?9BkhKCEuKoJm9iL0pdZJVU93iuIYmV5ViLgZwf1fE2j6R/leaN6DWcs9ZCEt?=
 =?us-ascii?Q?but0+ESBhrpEa02RaBWO0DyUDwavh2uwh5Ui1Ak4N9vcEiXvJxXwqVYXhN2O?=
 =?us-ascii?Q?VTJAADFlr+YLM+PLSn5R91rSwsmB7u94b0eMu+xG1ZHiI9xePQ7CoNZqgyrx?=
 =?us-ascii?Q?Nec283osHa22Hsqou8L8l0c8KGg0xsUlkNDsVXj9NSeSqoWPBgM3IbP/r7/r?=
 =?us-ascii?Q?KcikRYD5Kt5g?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47fe15cb-04e0-47fd-f9cc-08dbc440f45c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 18:45:46.1498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ff0pZoAzYPiybbAhjrcIrVlP8QD6fX/RQGv1691oEKnmcjNAbnWXkjbQI6LN5qh3s1M5LjFFzYUuHo/RWGVe5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6086
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_15,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030140
X-Proofpoint-GUID: X_7XM0tvIQI012CyfV37-vC_OqYWEQ17
X-Proofpoint-ORIG-GUID: X_7XM0tvIQI012CyfV37-vC_OqYWEQ17
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230924 23:58]:
> Introduce interfaces __mt_dup() and mtree_dup(), which are used to
> duplicate a maple tree. They duplicate a maple tree in Depth-First
> Search (DFS) pre-order traversal. It uses memcopy() to copy nodes in the
> source tree and allocate new child nodes in non-leaf nodes. The new node
> is exactly the same as the source node except for all the addresses
> stored in it. It will be faster than traversing all elements in the
> source tree and inserting them one by one into the new tree. The time
> complexity of these two functions is O(n).
> 
> The difference between __mt_dup() and mtree_dup() is that mtree_dup()
> handles locks internally.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  include/linux/maple_tree.h |   3 +
>  lib/maple_tree.c           | 286 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 289 insertions(+)
> 
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index 666a3764ed89..de5a4056503a 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -329,6 +329,9 @@ int mtree_store(struct maple_tree *mt, unsigned long index,
>  		void *entry, gfp_t gfp);
>  void *mtree_erase(struct maple_tree *mt, unsigned long index);
>  
> +int mtree_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp);
> +int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp);
> +
>  void mtree_destroy(struct maple_tree *mt);
>  void __mt_destroy(struct maple_tree *mt);
>  
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 3fe5652a8c6c..ed8847b4f1ff 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -6370,6 +6370,292 @@ void *mtree_erase(struct maple_tree *mt, unsigned long index)
>  }
>  EXPORT_SYMBOL(mtree_erase);
>  
> +/*
> + * mas_dup_free() - Free an incomplete duplication of a tree.
> + * @mas: The maple state of a incomplete tree.
> + *
> + * The parameter @mas->node passed in indicates that the allocation failed on
> + * this node. This function frees all nodes starting from @mas->node in the
> + * reverse order of mas_dup_build(). There is no need to hold the source tree
> + * lock at this time.
> + */
> +static void mas_dup_free(struct ma_state *mas)
> +{
> +	struct maple_node *node;
> +	enum maple_type type;
> +	void __rcu **slots;
> +	unsigned char count, i;
> +
> +	/* Maybe the first node allocation failed. */
> +	if (mas_is_none(mas))
> +		return;
> +
> +	while (!mte_is_root(mas->node)) {
> +		mas_ascend(mas);
> +
> +		if (mas->offset) {
> +			mas->offset--;
> +			do {
> +				mas_descend(mas);
> +				mas->offset = mas_data_end(mas);
> +			} while (!mte_is_leaf(mas->node));
> +
> +			mas_ascend(mas);
> +		}
> +
> +		node = mte_to_node(mas->node);
> +		type = mte_node_type(mas->node);
> +		slots = ma_slots(node, type);
> +		count = mas_data_end(mas) + 1;
> +		for (i = 0; i < count; i++)
> +			((unsigned long *)slots)[i] &= ~MAPLE_NODE_MASK;
> +
> +		mt_free_bulk(count, slots);
> +	}
> +
> +	node = mte_to_node(mas->node);
> +	mt_free_one(node);
> +}
> +
> +/*
> + * mas_copy_node() - Copy a maple node and replace the parent.
> + * @mas: The maple state of source tree.
> + * @new_mas: The maple state of new tree.
> + * @parent: The parent of the new node.
> + *
> + * Copy @mas->node to @new_mas->node, set @parent to be the parent of
> + * @new_mas->node. If memory allocation fails, @mas is set to -ENOMEM.
> + */
> +static inline void mas_copy_node(struct ma_state *mas, struct ma_state *new_mas,
> +		struct maple_pnode *parent)
> +{
> +	struct maple_node *node = mte_to_node(mas->node);
> +	struct maple_node *new_node = mte_to_node(new_mas->node);
> +	unsigned long val;
> +
> +	/* Copy the node completely. */
> +	memcpy(new_node, node, sizeof(struct maple_node));
> +
> +	/* Update the parent node pointer. */
> +	val = (unsigned long)node->parent & MAPLE_NODE_MASK;
> +	new_node->parent = ma_parent_ptr(val | (unsigned long)parent);
> +}
> +
> +/*
> + * mas_dup_alloc() - Allocate child nodes for a maple node.
> + * @mas: The maple state of source tree.
> + * @new_mas: The maple state of new tree.
> + * @gfp: The GFP_FLAGS to use for allocations.
> + *
> + * This function allocates child nodes for @new_mas->node during the duplication
> + * process. If memory allocation fails, @mas is set to -ENOMEM.
> + */
> +static inline void mas_dup_alloc(struct ma_state *mas, struct ma_state *new_mas,
> +		gfp_t gfp)
> +{
> +	struct maple_node *node = mte_to_node(mas->node);
> +	struct maple_node *new_node = mte_to_node(new_mas->node);
> +	enum maple_type type;
> +	unsigned char request, count, i;
> +	void __rcu **slots;
> +	void __rcu **new_slots;
> +	unsigned long val;
> +
> +	/* Allocate memory for child nodes. */
> +	type = mte_node_type(mas->node);
> +	new_slots = ma_slots(new_node, type);
> +	request = mas_data_end(mas) + 1;
> +	count = mt_alloc_bulk(gfp, request, (void **)new_slots);
> +	if (unlikely(count < request)) {
> +		if (count) {
> +			mt_free_bulk(count, new_slots);

If you look at mm/slab.c: kmem_cache_alloc(), you will see that the
error path already bulk frees for you - but does not zero the array.
This bulk free will lead to double free, but you do need the below
memset().  Also, it will return !count or request. So, I think this code
is never executed as it is written.

I don't think this will show up in your testcases because the test code
doesn't leave dangling pointers and simply returns 0 if there isn't
enough nodes.

> +			memset(new_slots, 0, count * sizeof(unsigned long));
> +		}
> +		mas_set_err(mas, -ENOMEM);
> +		return;
> +	}
> +
> +	/* Restore node type information in slots. */
> +	slots = ma_slots(node, type);
> +	for (i = 0; i < count; i++) {
> +		val = (unsigned long)mt_slot_locked(mas->tree, slots, i);
> +		val &= MAPLE_NODE_MASK;
> +		((unsigned long *)new_slots)[i] |= val;
> +	}
> +}
> +
> +/*
> + * mas_dup_build() - Build a new maple tree from a source tree
> + * @mas: The maple state of source tree.
> + * @new_mas: The maple state of new tree.
> + * @gfp: The GFP_FLAGS to use for allocations.
> + *
> + * This function builds a new tree in DFS preorder. If the memory allocation
> + * fails, the error code -ENOMEM will be set in @mas, and @new_mas points to the
> + * last node. mas_dup_free() will free the incomplete duplication of a tree.
> + *
> + * Note that the attributes of the two trees need to be exactly the same, and the
> + * new tree needs to be empty, otherwise -EINVAL will be set in @mas.
> + */
> +static inline void mas_dup_build(struct ma_state *mas, struct ma_state *new_mas,
> +		gfp_t gfp)
> +{
> +	struct maple_node *node;
> +	struct maple_pnode *parent = NULL;
> +	struct maple_enode *root;
> +	enum maple_type type;
> +
> +	if (unlikely(mt_attr(mas->tree) != mt_attr(new_mas->tree)) ||
> +	    unlikely(!mtree_empty(new_mas->tree))) {

Would it be worth checking mas_is_start() for both mas and new_mas here?
Otherwise mas_start() will not do what you want below.  I think it is
implied that both are at MAS_START but never checked?

> +		mas_set_err(mas, -EINVAL);
> +		return;
> +	}
> +
> +	mas_start(mas);
> +	if (mas_is_ptr(mas) || mas_is_none(mas)) {
> +		root = mt_root_locked(mas->tree);
> +		goto set_new_tree;
> +	}
> +
> +	node = mt_alloc_one(gfp);
> +	if (!node) {
> +		new_mas->node = MAS_NONE;
> +		mas_set_err(mas, -ENOMEM);
> +		return;
> +	}
> +
> +	type = mte_node_type(mas->node);
> +	root = mt_mk_node(node, type);
> +	new_mas->node = root;
> +	new_mas->min = 0;
> +	new_mas->max = ULONG_MAX;
> +	root = mte_mk_root(root);
> +
> +	while (1) {
> +		mas_copy_node(mas, new_mas, parent);
> +
> +		if (!mte_is_leaf(mas->node)) {
> +			/* Only allocate child nodes for non-leaf nodes. */
> +			mas_dup_alloc(mas, new_mas, gfp);
> +			if (unlikely(mas_is_err(mas)))
> +				return;
> +		} else {
> +			/*
> +			 * This is the last leaf node and duplication is
> +			 * completed.
> +			 */
> +			if (mas->max == ULONG_MAX)
> +				goto done;
> +
> +			/* This is not the last leaf node and needs to go up. */
> +			do {
> +				mas_ascend(mas);
> +				mas_ascend(new_mas);
> +			} while (mas->offset == mas_data_end(mas));
> +
> +			/* Move to the next subtree. */
> +			mas->offset++;
> +			new_mas->offset++;
> +		}
> +
> +		mas_descend(mas);
> +		parent = ma_parent_ptr(mte_to_node(new_mas->node));
> +		mas_descend(new_mas);
> +		mas->offset = 0;
> +		new_mas->offset = 0;
> +	}
> +done:
> +	/* Specially handle the parent of the root node. */
> +	mte_to_node(root)->parent = ma_parent_ptr(mas_tree_parent(new_mas));
> +set_new_tree:
> +	/* Make them the same height */
> +	new_mas->tree->ma_flags = mas->tree->ma_flags;
> +	rcu_assign_pointer(new_mas->tree->ma_root, root);
> +}
> +
> +/**
> + * __mt_dup(): Duplicate a maple tree
> + * @mt: The source maple tree
> + * @new: The new maple tree
> + * @gfp: The GFP_FLAGS to use for allocations
> + *
> + * This function duplicates a maple tree in Depth-First Search (DFS) pre-order
> + * traversal. It uses memcopy() to copy nodes in the source tree and allocate
> + * new child nodes in non-leaf nodes. The new node is exactly the same as the
> + * source node except for all the addresses stored in it. It will be faster than
> + * traversing all elements in the source tree and inserting them one by one into
> + * the new tree.
> + * The user needs to ensure that the attributes of the source tree and the new
> + * tree are the same, and the new tree needs to be an empty tree, otherwise
> + * -EINVAL will be returned.
> + * Note that the user needs to manually lock the source tree and the new tree.
> + *
> + * Return: 0 on success, -ENOMEM if memory could not be allocated, -EINVAL If
> + * the attributes of the two trees are different or the new tree is not an empty
> + * tree.
> + */
> +int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp)
> +{
> +	int ret = 0;
> +	MA_STATE(mas, mt, 0, 0);
> +	MA_STATE(new_mas, new, 0, 0);
> +
> +	mas_dup_build(&mas, &new_mas, gfp);
> +
> +	if (unlikely(mas_is_err(&mas))) {
> +		ret = xa_err(mas.node);
> +		if (ret == -ENOMEM)
> +			mas_dup_free(&new_mas);
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(__mt_dup);
> +
> +/**
> + * mtree_dup(): Duplicate a maple tree
> + * @mt: The source maple tree
> + * @new: The new maple tree
> + * @gfp: The GFP_FLAGS to use for allocations
> + *
> + * This function duplicates a maple tree in Depth-First Search (DFS) pre-order
> + * traversal. It uses memcopy() to copy nodes in the source tree and allocate
> + * new child nodes in non-leaf nodes. The new node is exactly the same as the
> + * source node except for all the addresses stored in it. It will be faster than
> + * traversing all elements in the source tree and inserting them one by one into
> + * the new tree.
> + * The user needs to ensure that the attributes of the source tree and the new
> + * tree are the same, and the new tree needs to be an empty tree, otherwise
> + * -EINVAL will be returned.

The requirement to duplicate the entire tree should be mentioned and
maybe the mas_is_start() requirement (as I asked about above?)

I can see someone thinking they are going to make a super fast sub-tree
of existing data using this - which won't (always?) work.

> + *
> + * Return: 0 on success, -ENOMEM if memory could not be allocated, -EINVAL If
> + * the attributes of the two trees are different or the new tree is not an empty
> + * tree.
> + */
> +int mtree_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp)
> +{
> +	int ret = 0;
> +	MA_STATE(mas, mt, 0, 0);
> +	MA_STATE(new_mas, new, 0, 0);
> +
> +	mas_lock(&new_mas);
> +	mas_lock_nested(&mas, SINGLE_DEPTH_NESTING);
> +
> +	mas_dup_build(&mas, &new_mas, gfp);
> +	mas_unlock(&mas);
> +
> +	if (unlikely(mas_is_err(&mas))) {
> +		ret = xa_err(mas.node);
> +		if (ret == -ENOMEM)
> +			mas_dup_free(&new_mas);
> +	}
> +
> +	mas_unlock(&new_mas);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(mtree_dup);
> +
>  /**
>   * __mt_destroy() - Walk and free all nodes of a locked maple tree.
>   * @mt: The maple tree
> -- 
> 2.20.1
> 
