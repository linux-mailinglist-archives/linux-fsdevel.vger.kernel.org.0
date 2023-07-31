Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8974769D22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 18:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjGaQtk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 12:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjGaQth (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:49:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF3C1722;
        Mon, 31 Jul 2023 09:49:35 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VDTJp3029569;
        Mon, 31 Jul 2023 16:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=Uu+eadgNMtFQ8V8uTp7lccBVd04SYsX93UQzoMInY1s=;
 b=xdweN9qsP19U8QdMVDUg9hcvVoZA1RKRV7Zigo8ZM+A60QyP0NSNjOEhiGOJu1mRfXYO
 X16VIiQ1sBoKCSTGqgEJbh9mdCv6r13FJOQJ+TS4klPPx1Mz8u0IV/ANJBGYNKV5BXPr
 uGNT1/v2h8bpTn2lFy92NpbCqBy79X/xqTQIEEmT8GAhtOg0hmtzsqEo6TVEvK9AANi3
 grakNlVBldpDM1o9W5YJIa0ON0uhuKjzWaIJ7GYiUFhLqyR3+uDjoIxz0FC8fFDwZX6q
 cv2ks7V3L0PNTDCnjU5vqkoLJ99MoSt353KvYROdCkb88WGp9d875/mcwEGopC+TpGsd qA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4ttd33as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 16:49:02 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VG7Vg7037492;
        Mon, 31 Jul 2023 16:49:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7bcu44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 16:49:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSh0a4BCm3QM4WEPUAvd8T0mDLSdsDkIeQgBC8BHAxW1zCpskhZL+wFqlC/ig8jkfdNbzu7wJKuaviPV2U3qQ9kyNZayhdqfWtTfaKird/nJXoRR8/Ha/sGlgWUJfR4G2NNgsCkpoNhCrrvm6iVRcX5DcHqygSh0JEN2xx5OmzrH9UUQGtoFtIbni4+KlsWgRNYlK0V1PA1z7+ixR79PbjO5zrGEBUJ2yM7oeI8hqoDG9FlRZit08wOv4OLerjNxJQvw8ZVF0FjhN7sI01boEDBAuKcz6Tf/eM+UZrQl2LMADScPlPX0zR/2gA6jlggursVLYZeiiZZVtViZpW8sqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uu+eadgNMtFQ8V8uTp7lccBVd04SYsX93UQzoMInY1s=;
 b=fD0eHGf2OyObHihLFmCOr7pH4atArIXf0zOWvgXrpUp81qu4BQsfbWowPfs7Ibf+nxfusWsmJx9az/NKcucBO5vUy1owFPI994ZBZss77jzpjI9iGJqtqUfuwhfaF5iUgKmiAR9umkTJyDbUxeEzghrQ8AioFFJetIsUDwN0YyiRPgJ+AovRnDwbHWmGcGHlZvu8bRWhbL46GjGBMDZTgmiWrLfVLvbiNKFl30whoKqF6M8XFSmpAzzRNTncHv4rOAhWqX/hW0uKsVFEa0ZDDo6Nhxwzl06PeH91Xbzi3rzrIlF3Dio7wASEu5wk7nEoq4Fove8n3RjfnmLcOImUhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uu+eadgNMtFQ8V8uTp7lccBVd04SYsX93UQzoMInY1s=;
 b=d5PfLBR7fYfaRmjBb3gqQYfOSxg4r/LuF5vGbSIq+HY5XyJFm1IicRMs35zTiK2aChks7DP0XTSFZHZ8DKDSiN0e5aT5droupFGpVcg+5g8W5cPygy0ejwFEsOEjfeVKzKgSmvqtEF696CHtGyi/0Ox8sZ0E5R1TLJI1Mf7w6n4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB6375.namprd10.prod.outlook.com (2603:10b6:a03:484::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 16:48:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 16:48:58 +0000
Date:   Mon, 31 Jul 2023 12:48:54 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     avagin@gmail.com, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com, peterz@infradead.org,
        michael.christie@oracle.com, surenb@google.com, brauner@kernel.org,
        willy@infradead.org, akpm@linux-foundation.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 06/11] maple_tree: Introduce mas_replace_entry() to
 directly replace an entry
Message-ID: <20230731164854.vbndc2z2mqpw53in@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, avagin@gmail.com,
        npiggin@gmail.com, mathieu.desnoyers@efficios.com,
        peterz@infradead.org, michael.christie@oracle.com,
        surenb@google.com, brauner@kernel.org, willy@infradead.org,
        akpm@linux-foundation.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
 <20230726080916.17454-7-zhangpeng.00@bytedance.com>
 <20230726160843.hpl4razxiikqbuxy@revolver>
 <20aab1af-c183-db94-90d7-5e5425e3fd80@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20aab1af-c183-db94-90d7-5e5425e3fd80@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0150.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::29) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: 7da95960-3a1e-414f-f7af-08db91e608cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7j9Sn5nI4QOv3mg3QNX83H5On/LtiIxxJA24Ed/nOowPRFqVM6Gy2/TSk3ajW8y8Vqk27CqPUvcPcbdSs5wA7INmHMXZMT8dmNLPiO5ohhXKCiwOy/cZ/BF84pP8owkW8vC/els3+heDLFeUr5nXK2DIr0B4NtwHbwmWZlQlWZ0kjvTFAAd5wJxUd4LMi4G0MquXpS6rggUQUD2zpeNRRdVidh4qCOYV/ke01+4tBjecGSHCiF+prjmPKG2mGG6wzbvbcvv2F1ZiJDMqEaUQ1vcHiM9aPKiUbkYRZR2uNzAd/6D415GnD2Ia3mNOggVzgStqVZTSxdHfq5ZiWx4mHPCeiH2zuxknADv41GmI3Mxu6kK9ZY1xwh/xs02b1mgixjrfhEEwue2nyKdBaNS0sQSE8wwKF2x6hr+9n6fm3AbuPQC8lnE1F5GZIGd7BRgCNeGaZKPyk4CLR00G8JjIUnnkUT0V0WBKY+MD56e44JwGdPpCrmaDt98RXyvuObD19MFHXWPXHAnL3eEXbgoF+QFTCf6zN7m6+Yl+chTfNaU7tFwNpBwable8C+Lz+X14
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(376002)(396003)(346002)(39860400002)(136003)(451199021)(6666004)(66556008)(6916009)(66946007)(66476007)(26005)(41300700001)(4326008)(6486002)(8936002)(8676002)(1076003)(6506007)(5660300002)(7416002)(186003)(478600001)(316002)(6512007)(9686003)(2906002)(83380400001)(38100700002)(33716001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDNFYmQ5cDRXNUVNUnlwUnhMYmdjamkvS0xJY09MZG9FTDB3RG5NSy9ZL1lU?=
 =?utf-8?B?OThtYU1TSmdGVE9CWlloZzMzcmQxZkUzSVNmOTVWUXdhRnFqNHB4aElwTlNC?=
 =?utf-8?B?SERYbWN3b3M4SFN1enBnbWxGbXRMT1pWUXBST0o4N1lpUXh3NVVyOTlEd0Ft?=
 =?utf-8?B?WjNxZUNZVllhOTdsNXI5dlplaFlnSmNMK3lXelBWNnNWRjVPUDE1NHZ6VWRF?=
 =?utf-8?B?ejhFRzEyTlZCMFJDRTcxRTY5d3Z2NFBYT012bXJpblF6ZmMwZWQrVUVnVjJN?=
 =?utf-8?B?SmlWOTEzd1Q2SlpLaUtRLy9oNUVvNzBmMjlVMytIRWJJMjRGaEc5ODEzUGdB?=
 =?utf-8?B?NlNIalJnTUl3cEd2WThFTXhveGtPZzc0ekZ0eEFjSS82VzFwcnNWZ2MzVkJC?=
 =?utf-8?B?YVdsR2tzQTlMQkYrZkZrS0txVVlPTTNKUFdvSWFoRnhobVVadDVQUXQzU084?=
 =?utf-8?B?MGFGcDFDdmJVaEVJL0xja0V2YnNVVzc1MTNoR29leWJGN290Q1JGZ3NXN282?=
 =?utf-8?B?Tm1Jc3JaU1plSFVpTTBpSVZCRHFjYXY3R3hZKzJaS3dVWkI0S0NFMCsvR2pi?=
 =?utf-8?B?QXN4WDlBQm5KdmZaaEpLdmFxQldBdXU4SjZPV1ZINTZ4WkV4QktaUkpuK3Zu?=
 =?utf-8?B?MEsyTVZRZ1BpSzJWaTh3S2w2ckc0aGZud2ZDN0VISklZWUt2RnZ5WjFOL3F6?=
 =?utf-8?B?NGY0M3ZXc3BlWWRPQStzbkZjYUFGd2xIRGF4cHZpRFV6WC9DQStZWkZZaXo2?=
 =?utf-8?B?MGlodTRNSDhNaG5ieC82MFpWcStoQVNoNmREU2lRYTM1aDJlOVRXT2crYUVy?=
 =?utf-8?B?elkzdjQyUXFMd3JQaWt4VE01Yml1bUt1VHM3cVg4WUdQelJWM1JxMjlsS1pr?=
 =?utf-8?B?bCtzK2Q0MkdyZjVTTk1YYmJNZS85NXFYRGt0TEVybDJGQXRKSEwwNUFhWHRP?=
 =?utf-8?B?ZUNKNTdYNiswSVUyalNNNDNrSGxSV0pUNTg3eFNyTW5ZSG5GNTFWMnVDejBt?=
 =?utf-8?B?dlF6U1ZXZ2VWNnhJK0lpMlZpeHZiMy9LMWlKYVIrcERxdUp0MmM3Y2dpRWhi?=
 =?utf-8?B?U3VPS0NHczE0SFlaMkNCYVdrMENHdzcwdW1XQnhWaytrVkRnR3lDcHQ4S09W?=
 =?utf-8?B?bVhQdUgwUTJlZU5idFVxa0RvL3FkRmtYWHdZdXZZcTVVbDFNQnJIbFhENXJY?=
 =?utf-8?B?SEdmNzhscWZPSnlTb1g3R3ZJdW5rMU1UU3FLQXp5WFJESTgyUXc3cHVWS250?=
 =?utf-8?B?M2cvS3FhanpDeGJJbk1LWmJHVkY3ZUFBcklDYnkrcVN2RWVwdDk1UTgrc1Y5?=
 =?utf-8?B?K0VCM2VCbVFKajdydUUzYm1EaExzdnRYMFF4amVNV0tNMW1WeVpNamJZZW9X?=
 =?utf-8?B?T1JWZTZJQ2wyRXlrN0ZaaHZyclBCeFBINUcvSzd1S0lMbjFpM0krcFhuVldt?=
 =?utf-8?B?OTViZmpQWVFOMjlCUFpwOG9jbTlJckQyVVY5WWxIMkhNcXB0dllPdWdDTVh2?=
 =?utf-8?B?cW5uNU1vL0wrcE9hTW5tY2d6RXFvUVF3TWtGOXM0L3lMUEtoRkFROWtUTDk3?=
 =?utf-8?B?bHY4WG51UmVvUmdyVHN3K005MDJnQmx3bzhDcW9CVktpR3NNdXQvdS9EeEg3?=
 =?utf-8?B?aFhoMUgvUmszVTB5YVlFRWtVTTZQSzFBb082Q3lKS3Z6djBMUm14VTFTaTR6?=
 =?utf-8?B?V1VYS3FPdXVnaERsNWgzN1hEb1RUUm9HRDg0ck1qRnBZZWVHa3NBNDB1WmFp?=
 =?utf-8?B?blJJRlFNM3lBVFl2NnRrcXI4cGhMV3g2c3Vnbm0zM1JseCtjN2VGVjg0MHZG?=
 =?utf-8?B?U1JRMGJaV3U2MFp5bVZQbVAyaU1QSE9oTEtDU3VGS0JRbGJPbmViVHcrdnlH?=
 =?utf-8?B?bEZJS25pTm50UGpmQUI0OXVaaFNnTUdoejlseGZnNHpWZG1BWFFVZzd3ZjRr?=
 =?utf-8?B?d2NXLytJOEJRNWRxZG1mZDVnNU51dXZtb0wzaHFzOXd0TzJndmpMYWVob0Zm?=
 =?utf-8?B?SSs4QTZBdlBZOXUyczJldUI0UHpsVUV5OTQzUVAwbTFVdFd1aG9wZnNja05H?=
 =?utf-8?B?cWVyeWxGVGozK29NZGExcjRNTkh6WStMY3VvQ2l1SDRwWURPUTRCYTI4QUlU?=
 =?utf-8?B?WHVSbk0vRzZuMjNKT0J1MzRXUGczVXpJTmx6enJEd1dSd21XcnlxQmxONVRz?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YVc0VkhqeDJyUlpDMVVIbVVJUWt5TGU2Nnh6alFXY3Rjdnl1ajBsam0wdGlT?=
 =?utf-8?B?RlpvaFByVlYvdFVhR2N1bElnVnYwOWhkRlFQTVV1dS8xUzRXeEhPSVB4YTc2?=
 =?utf-8?B?YmovRk5HM0JZZzk4NkI2KzQ5L1JXbGRadmMzYTFiUlBqaE5xUXRvNnpOWkt6?=
 =?utf-8?B?cDBJbTA0SGd5OE8yUHA0ZS81dnpwYno2b2lKcXBTT0NDNG4yVStBT3RJTWd2?=
 =?utf-8?B?N2dIdjJpVUk0Vk42K3BqdDNTaUlYa2oxV2lZWEladkFiaWtlNWsyeVhNaVBJ?=
 =?utf-8?B?bHM1T1Z4OTgrdTJCRVdzTGJvbWZiWmZBcklyN0JDVnpsQ0lrMEJhMVo4OW5o?=
 =?utf-8?B?clpGQVU3cWJLSG15d3dXQjRPbFkvVTBwMElSTVZRM3k5MnBpMVcrTHo0SDhW?=
 =?utf-8?B?eFFoVlFaeVgvR0VhbFlSbFhYYVNTb1VNYk03akZnZGpJK0VzVnBJbWxUQSsv?=
 =?utf-8?B?RGxOOEhWT1NRNy9XZkhaMUVZV0ZWTjZwUEN3cUNyZFlSTU5TZG5mZFVYM1FB?=
 =?utf-8?B?RzVJZHc3R0ZsajhxVGVSckt4K1ZtRmQ1WXE1RWkvZzZ0WnBvR3FQY0tzMUVC?=
 =?utf-8?B?Q0RsRGZzL2NhWkRTL2RKNm80NlJ3NTRld0w1bEJPaXVTamM5K0FRTVh1N0M1?=
 =?utf-8?B?SUk2ZFkzWGJxRVppTXJmYjAwV2pPZlBqMWpqR1ppLzl4YVljazNuUFlzTWR0?=
 =?utf-8?B?NEMxMkErR3I1M1JiWlplekhka3N6YXpEQ1FFMnEwQTR5K01IaUROc1NHNjhF?=
 =?utf-8?B?aUlkUXhDcklqWjJZU0FjZVphL3lGZno4eExnbkJaOWhlaDR2REN4ejBUOGc4?=
 =?utf-8?B?K25YeW5JdDdHOE9zRGs1eklNQXNSNjcrRndiZjFWZFV6c21RMjBHT2Y5VDY5?=
 =?utf-8?B?a2JWYlFpNko1ZGxIbGN4STNIbjhEVzV4Zi9zUGJHUG1DaEF5a2o5Z1p3ejcx?=
 =?utf-8?B?ZDlZcjRWUDlYd05CRnRxOUR4MUZkcU03NWNpeFVJVWJ6Z1duOVVQWG5kZGVi?=
 =?utf-8?B?RVhBQittc1dwZEZLdVlqZ1BmZ29SRXc1aU0zdzNQWHdERFlEeGxNbDBuWjFa?=
 =?utf-8?B?N2twbEdNOFRHbUFGY3Bhd2NIOHRmTGlNUVAwR2M5RG5abzVmYjY4ODhxYU90?=
 =?utf-8?B?cDFITE9ObkdOUi96NVhFSXZlQXg2bmMyREVoWkI4M2lpcVYyTmlseE12RXF1?=
 =?utf-8?B?TWg3S1R5aVlJTUV5K081ZythVWdnK3hUSXJtZ2RlbGVJbUkySzliTEl5dlM3?=
 =?utf-8?B?ZEZYOGlWQzhUUGJwQXgycVlMWEVzaitDVW05aDRBVS9rRlNVWlVYSTlCYjZr?=
 =?utf-8?B?d0xkd051a3FiaU94NjN6M3Q1UEd1Qi9vZDV6T3NtMDY4OUgwV1lwMFFPbHU4?=
 =?utf-8?B?MGwxaVpHM29aamhLMTE2ZFhVZUJhQ1g5N3ZndCtxZVJtOEZkRWFvQjQ3Zlls?=
 =?utf-8?Q?bSorgzqZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da95960-3a1e-414f-f7af-08db91e608cd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 16:48:58.2524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8lvle6COPYrsn7SIMoRbHsm2nXwAAfG0HViyJ2yoTUxLamYv8TkZ4Qpj/qgdQPsZxtCreAW6r/SPAXxqa1dog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6375
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_09,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310151
X-Proofpoint-GUID: n-JfErZZyFwKj_a8ibwfwgArcx1j2UkP
X-Proofpoint-ORIG-GUID: n-JfErZZyFwKj_a8ibwfwgArcx1j2UkP
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230731 08:39]:
>=20
>=20
> =E5=9C=A8 2023/7/27 00:08, Liam R. Howlett =E5=86=99=E9=81=93:
> > * Peng Zhang <zhangpeng.00@bytedance.com> [230726 04:10]:
> > > If mas has located a specific entry, it may be need to replace this
> > > entry, so introduce mas_replace_entry() to do this. mas_replace_entry=
()
> > > will be more efficient than mas_store*() because it doesn't do many
> > > unnecessary checks.
> > >=20
> > > This function should be inline, but more functions need to be moved t=
o
> > > the header file, so I didn't do it for the time being.
> >=20
> > I am really nervous having no checks here.  I get that this could be
> > used for duplicating the tree more efficiently, but having a function
> > that just swaps a value in is very dangerous - especially since it is
> > decoupled from the tree duplication code.
> I've thought about this, and I feel like this is something the user
> should be guaranteed. If the user is not sure whether to use it,
> mas_store() can be used instead.

Documentation often isn't up to date and even more rarely read.
mas_replace_entry() does not give a hint of a requirement for a specific
state to the mas.  This is not acceptable.

The description of the function also doesn't say anything about a
requirement of the maple state, just that it replaces an already
existing entry.  You have to read the notes to find out that 'mas must
already locate an existing entry'.

>And we should provide this interface
> because it has better performance.

How much better is the performance?  There's always a trade off but
without numbers, this is hard to justify.

> >=20
> > >=20
> > > Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> > > ---
> > >   include/linux/maple_tree.h |  1 +
> > >   lib/maple_tree.c           | 25 +++++++++++++++++++++++++
> > >   2 files changed, 26 insertions(+)
> > >=20
> > > diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> > > index 229fe78e4c89..a05e9827d761 100644
> > > --- a/include/linux/maple_tree.h
> > > +++ b/include/linux/maple_tree.h
> > > @@ -462,6 +462,7 @@ struct ma_wr_state {
> > >   void *mas_walk(struct ma_state *mas);
> > >   void *mas_store(struct ma_state *mas, void *entry);
> > > +void mas_replace_entry(struct ma_state *mas, void *entry);
> > >   void *mas_erase(struct ma_state *mas);
> > >   int mas_store_gfp(struct ma_state *mas, void *entry, gfp_t gfp);
> > >   void mas_store_prealloc(struct ma_state *mas, void *entry);
> > > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > > index efac6761ae37..d58572666a00 100644
> > > --- a/lib/maple_tree.c
> > > +++ b/lib/maple_tree.c
> > > @@ -5600,6 +5600,31 @@ void *mas_store(struct ma_state *mas, void *en=
try)
> > >   }
> > >   EXPORT_SYMBOL_GPL(mas_store);
> > > +/**
> > > + * mas_replace_entry() - Replace an entry that already exists in the=
 maple tree
> > > + * @mas: The maple state
> > > + * @entry: The entry to store
> > > + *
> > > + * Please note that mas must already locate an existing entry, and t=
he new entry
> > > + * must not be NULL. If these two points cannot be guaranteed, pleas=
e use
> > > + * mas_store*() instead, otherwise it will cause an internal error i=
n the maple
> > > + * tree. This function does not need to allocate memory, so it must =
succeed.
> > > + */
> > > +void mas_replace_entry(struct ma_state *mas, void *entry)
> > > +{
> > > +	void __rcu **slots;
> > > +
> > > +#ifdef CONFIG_DEBUG_MAPLE_TREE
> > > +	MAS_WARN_ON(mas, !mte_is_leaf(mas->node));
> > > +	MAS_WARN_ON(mas, !entry);
> > > +	MAS_WARN_ON(mas, mas->offset >=3D mt_slots[mte_node_type(mas->node)=
]);
> > > +#endif
> > > +
> > > +	slots =3D ma_slots(mte_to_node(mas->node), mte_node_type(mas->node)=
);
> > > +	rcu_assign_pointer(slots[mas->offset], entry);
> > > +}
> > > +EXPORT_SYMBOL_GPL(mas_replace_entry);
> > > +
> > >   /**
> > >    * mas_store_gfp() - Store a value into the tree.
> > >    * @mas: The maple state
> > > --=20
> > > 2.20.1
> > >=20
