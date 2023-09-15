Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3877A278A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 22:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236643AbjIOUBo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 16:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237071AbjIOUBi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:01:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101DA210A;
        Fri, 15 Sep 2023 13:01:32 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FIefs2017516;
        Fri, 15 Sep 2023 20:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=0qb7rfl3/mdS+cCwwofYItlIyDfCSoFmkD2n9QUclzA=;
 b=Sbby29za5qhoF8tqU06SlVWTX5NMDCRcEsd4CzvUjQ34IfRTTMNQcrMVqTArJp8amF0r
 4WkLKmA+kL7jnyYrvC6uomdcP1LrADpxCv9ic5h7Y7uxYfCwIdrZ43ISbkko8Ki/EdyE
 dNAa+h9N29S5YUtXCU7jx6+lIUy1WTelIY1/YnbCYovndUNrGBA2q3/5nv1kWlyxNKZV
 6Csg0fFjdyGsm6O2Qb+HhC4pftdoDsh8dVIbPhrsoKaoM7ibOm1uNDTecagPTCiPkoAR
 SBTUoLGCJklYp1l9GglZjNUt1o85VSIYSXVnExXAaiRoVyDU2ZYx4ONCw2Lpdx9tujuQ TA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y9m0f7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 20:00:48 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38FI5oJf008804;
        Fri, 15 Sep 2023 20:00:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5asph3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 20:00:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OquYO7xgerrOtsvAbt0CNZEJcxx8Lm6khxRhqFlwUcfFXEonNWUXSY7mKDIwGZBSI04PvnzAdD44ggG1vajoOHwVsoXgxUIlc08m1JtBqqG61CkCz8b6EpEhYDfEOuontKjBVbTRJ73BYCGbljwpoGvf0quO3eBAiApPNvIqF+SlR25fFPfPgwQQwADdI7H083q23ZBsBQ6g7HxJW2c/mnTFQIbcNmKCgX5s/omWmk6by0uYDdH52/g8q8mT2nQUvtPfyIAJmpTEmSyEvMX/Am5fY3jAiOgd9Yrw3JUXQp6Ev30/EsaJFyQ3DCtaLacFMi+B7LlhIxZtXm1cszDPqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qb7rfl3/mdS+cCwwofYItlIyDfCSoFmkD2n9QUclzA=;
 b=CcYQ8vz27hCEUU1I4SEMtfKHq1rAvtGMJe7PXxp6BgVPsnP3kiGryCLwWWJUKoeITZSE7G8dyqAbE/CAdtDzKZo6rJA1/EqtgNL/5TiqrmL8S69QP3CFilSovrvU83KnwGyn6DPM5RPp7VCjnHgLgyb7FauTwwlfzruqAMyv9dLyXP8zleiXXZOtn2W+avPN+LSYSK5p6iMerDd0+GBYjsTeG4+QxWs4xxIR48p98oEk5vjSo+kczePcDG125rTmbr2ThtYtBXsj8uLGlQqoW/SBDOn9BT+zDwqlPS396dZk0rF943j1u1JHtVV3t5u9f+ZYtO/DTnVruOR2HYb2yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qb7rfl3/mdS+cCwwofYItlIyDfCSoFmkD2n9QUclzA=;
 b=x2oHD4VHN+sLBm5vwX5VnEhnalIq1JJZMmq//XV8cpxNQ/9ec+LTO+nv1yeS3hK5wKIai4LdmdT8B/GAQ5ZGsIOPNY6ywflekHhAioBgUfXzGgmI+ThLMNW/x84UKeQgXWrAgt32y1FI5mJN5DKKYPskQpBN9vy6PvLWnrZnsRQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5003.namprd10.prod.outlook.com (2603:10b6:610:ca::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 20:00:45 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 20:00:45 +0000
Date:   Fri, 15 Sep 2023 16:00:40 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] fork: Use __mt_dup() to duplicate maple tree in
 dup_mmap()
Message-ID: <20230915200040.ebrri6zy3uccndx2@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230830125654.21257-1-zhangpeng.00@bytedance.com>
 <20230830125654.21257-7-zhangpeng.00@bytedance.com>
 <20230907201414.dagnqxfnu7f7qzxd@revolver>
 <2868f2d5-1abe-7af6-4196-ee53cfae76a9@bytedance.com>
 <377b1e27-5752-ee04-b568-69b697852228@bytedance.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <377b1e27-5752-ee04-b568-69b697852228@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0337.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::12) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5003:EE_
X-MS-Office365-Filtering-Correlation-Id: ff7c038c-dc64-4486-023f-08dbb626727a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DMrgqk2chn+N35UEVLxnHJzMHEmPnYJ9vUNg/5WJIzZRj/Q1hxm9lWvdfFXEH2uLx2as3Q8eOFRxvnqRj4v/Yy5c95W5+uqNp+s+RLIiv19JyYOWzFe1Asm5xM/kLemYgA+8trV33dcx6TNEP6tH21Gss/BW4hbZzPSGZh5PGiQ0wbiptbNmb5YXLNl/ztUHfkPnmfBGHWEc2A7xiBdg3SFWZVx0NgOCG+oMlCSf89N6C1lV1zRa1C/FCpa55DMTSGTexeWJUQYLkDjbUhk2nNqYPGxdlggMtF11pvIt8iC3H/CLwsW8sJ1+qhrlnjvQZTuk0UDF21Nq2UnyfXdRSDmwZO/7I/KIXeSMq1dG8Hf2Eymb1m5NVejyg2/8mWd3MPiPlJRp0eM39JCNz1+n1r//qJJzeo0IjKOrc2nxnzLY+P+/4Ujqzu6QwOZUnvtvzHgZkqF/2ZhOBLj2Z8p931CDfj5MXVH3asB7vHzHXQc5TF5PIPY2WVqfDUiukrZKIYawJQR1vxvbheM26et+3SCVgxfe4C/lQl6uwKuk4zpbdJ/our4mmiFqWcVwApNk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(136003)(346002)(396003)(366004)(1800799009)(186009)(451199024)(33716001)(2906002)(6512007)(478600001)(9686003)(86362001)(26005)(1076003)(6486002)(6666004)(6506007)(38100700002)(83380400001)(66899024)(41300700001)(7416002)(5660300002)(4326008)(8936002)(8676002)(6916009)(316002)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?g5oB+2z36jIkh+7bY3lOO/Qf2Hy7GDlF5PFFd5LPhGoE3uIOEfA7Eeigvj?=
 =?iso-8859-1?Q?eAdwuafCBEDQCOl5OfLN/Pj0DZyeFNAiV0OE7tOGHDootqd5saBYY6kKE+?=
 =?iso-8859-1?Q?kfqjQxP0eXHbNf+3U1kYQuatNQPSg12EhuUh9O8FPs3FEaAYD+/xZoXdMQ?=
 =?iso-8859-1?Q?Tq39jBTArmaUGFcbXFCmSdbeMt9YiJEEzuvsoeqdTMD/OSOjxB+uPkxEG7?=
 =?iso-8859-1?Q?7E/PzyjU2yioNBzZVwtlcT1eM1rclxRs3yv7sChlkdGspq728nfYnxI8hE?=
 =?iso-8859-1?Q?ALAfYAnNZKSOawtnszWkvQkBdU6VxanO1Rz7ngEFonAbfY8632Ru9Wv7ln?=
 =?iso-8859-1?Q?e3rQb0iAvvmdxyWwuftCcWjNd+2VAHCc0W708QKA02QqYuL2c4jxiNeamm?=
 =?iso-8859-1?Q?YSp8VrY6At9c+7/+iQpYuJh2adXzVeNIZRI0Wv8PLpbX3W83hxtYC48d2m?=
 =?iso-8859-1?Q?eJQXOyd77P7ZJFlx5ED+82Kt8woKzERT2Ak41e0S2UZOfq7Q2KPmXJ2CyD?=
 =?iso-8859-1?Q?9dg9n8UUG3P6rUXfTKnSiQIGExdaZZ0FGxdlPTpd3JHxdYrBlfhKeGlyGx?=
 =?iso-8859-1?Q?lr3HW0SCzetzbGaLHGSeyIi12JdntkQt025g5G5dIUayApmpFa5uF9H6dW?=
 =?iso-8859-1?Q?mjL5ydInYJrP9XrpOSE8o/lbSFc+iy8tr0A67gJJ3UNw+BB2Y5sC2eIcKG?=
 =?iso-8859-1?Q?E/G8BkNJ/ClpP7ObnsRcaxIroqcme8fggOseiC6om3Atyw2AINDumTrxDR?=
 =?iso-8859-1?Q?8sP3BbRgiteO40P4mt2r4QYTct7vho/G4GgHSPe3eXWXSJHWQlnM4+gH1R?=
 =?iso-8859-1?Q?siX5SYj9m68yzlvXdfbvxjBqCruS/JVVSeG5/6N5Ageup0XCC6zRsY457N?=
 =?iso-8859-1?Q?YL6ixYondpUolJzD6wPgT4OBZlX9ObYaURxL8g0MTXtzRX2gZp2Bkf0hL/?=
 =?iso-8859-1?Q?GlqXk+hvqB3/DVOdDRLKGe1vl2xU+7iSmno0aujiR4NmeGt5lxpsLfanZI?=
 =?iso-8859-1?Q?4Y1R2xmkEq5oOSHNkZZyPO/C/XiMr3c+MrOBMEb36L2HtRG6fuq7AC/fyc?=
 =?iso-8859-1?Q?RO2SkLQFhgM9k4bXJoy5hBlyzRLvTMYMfCt38+GsizHpBUb83kZLXiiaEx?=
 =?iso-8859-1?Q?N6v376WOXmOxgqq854agdzlLT4CnAuruAGJhrmufEwMKh26dtaYoI6a7Ba?=
 =?iso-8859-1?Q?aGRZLpceM2T/VOPST9PvNoaCaijWg5r+SYOXOqomvKMbdB/0A74k+nMHFx?=
 =?iso-8859-1?Q?66K0F3oG1N4yS5urkcTY0Clw7I+BAyvQLgdJ06MGnPUye/EsG2mX/QxqiV?=
 =?iso-8859-1?Q?ws/0ELL5eoof2E9dMmHnlwf2deFxPWKAy8XwrkTE1pZyHWY1eVUyrXseNJ?=
 =?iso-8859-1?Q?oWDT/P9D8NDgMNVULD5a5foGQqhWzKBPL82cY7M3FdN5tNS+dVQ8holZbI?=
 =?iso-8859-1?Q?2223heJyZyx1E9yIu+PkDJ5nt0yXjKMmEhwaHDxUnLIX5KNTRAkwxUljNd?=
 =?iso-8859-1?Q?NQFeLSbR+80vDSPMi90Knqmd3berZXBJFBArKC4FhAw+sQ4rIfKGqwr9uW?=
 =?iso-8859-1?Q?yX2gRJwZf/2DPWvUERBLPg2MkVIrTaPB7SXmH8Ic4eQYwwah20RqQzTyrV?=
 =?iso-8859-1?Q?KfWSsROgSjMIWxCULGxtKZ8OW4GjYWZ2pM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?qr+w/cQAU4N4fLLhgqQIXMbBM2cD5cjNw9ZlQ3Am0D6GuuE/5hSNtqPlJm?=
 =?iso-8859-1?Q?K0c7U2MnJJrATlSFvCpSSuvl3cPX4p1SbYitVTGVbU8b2XGwjGm/BscfVl?=
 =?iso-8859-1?Q?QinRvGVruZYlBrEpkohp4J13rtHTVbqxBNQflbxjmmapHMYElM1+scrvZ6?=
 =?iso-8859-1?Q?ZyOF50cHU3LClDN7Peza0nQUHOaCITpM4nRNtdqU2gy2qMGXja86ztJSqP?=
 =?iso-8859-1?Q?VoMOuMhEiXOzl8zze8h5XXmGRXmtfH2/u8aHkk5r9AKHbxLjXoD7casDg4?=
 =?iso-8859-1?Q?nuUe13s2Z3I9HqUXrIlSpDCu8Hf60K/85jPNOPlX+H9DnKWAz6shgcsu5P?=
 =?iso-8859-1?Q?axLGoNws6Zxw4N9yaLjitLRab29T0ikzS0/be+0P13sMHv2kmAdUP09hmA?=
 =?iso-8859-1?Q?7oVd3oP29fE5O03Pl3IQa99TYvgDPJy+1bLyxiM1E6NSZZuAWo4diIyVGp?=
 =?iso-8859-1?Q?abZ1oFuQh3VoNpl1VAh8wYg+nEq3Sxd25aUzIjYLusikbEGbTGUpkSr8uY?=
 =?iso-8859-1?Q?VpoFZW/viIxZ6CwpQ8o5J9qQ9zbZM2faRAdDURa0+jwrU40OKXIS7EtXmz?=
 =?iso-8859-1?Q?T11OVr0meSJmj9w0kRj8tZfyE94Inmq1zYPWa/7PtMHaRJLj5K5U+nNVIz?=
 =?iso-8859-1?Q?/J97EuPyytzltBtuiR7po2JzNl0hHGe+nPVwaUcwdWxyE2i4aDKFV1wRkP?=
 =?iso-8859-1?Q?zUEmPUhTGMZqd7Qo4JfVVLq77dSKMlXQN8goq9F8ZyjXg2cEeUBTfjBwZn?=
 =?iso-8859-1?Q?1youRYvj3Cy/ttTYvyvJlkCQEwRyIj0GCffKFbtt5mmflanT1xHTGZpz3t?=
 =?iso-8859-1?Q?yTRwIdRjkieAxQj0daJmH2FnxAJKAKBNm5b+rLD1erFG+2JwNOHRD7cN6d?=
 =?iso-8859-1?Q?0XxLweKxNzIH/3NIAumDV8kORiuemYLegQHOV0hRXH9IsAhA+SJ5/veuQ6?=
 =?iso-8859-1?Q?HzmCyunrZT2NvjueXfdnjvNDnPCz6ckGuV+XHth3gP7u4gLVv/Xb8Y0lcQ?=
 =?iso-8859-1?Q?g0pLoq84gS7DrsoQjvtHJW7FD5Kjk4LPOp6082ke+vpAyHFgImKC+CB36c?=
 =?iso-8859-1?Q?vGOqB1FxIM8ZALru2U/heWI+F7zw9zYYMh/jBrGPU/Vw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7c038c-dc64-4486-023f-08dbb626727a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 20:00:45.0163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBTS4bHQ+BboT3qq6hYJBenFpWg8+imOqUyDqkSGH2+lB3m3ode+PshFbOXcO/HgxLr7kBnIrv9l8Jjcg8KNGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5003
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_17,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=553 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150179
X-Proofpoint-GUID: sqVQwrqOvZZ0iX516xKEWLSclHuwO7zT
X-Proofpoint-ORIG-GUID: sqVQwrqOvZZ0iX516xKEWLSclHuwO7zT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230915 06:57]:
>=20
>=20

...

> > > > +=A0=A0=A0 if (unlikely(retval))
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;
> > > > =A0=A0=A0=A0=A0 mt_clear_in_rcu(vmi.mas.tree);
> > > > -=A0=A0=A0 for_each_vma(old_vmi, mpnt) {
> > > > +=A0=A0=A0 for_each_vma(vmi, mpnt) {
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 struct file *file;
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 vma_start_write(mpnt);
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 if (mpnt->vm_flags & VM_DONTCOPY) {
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vm_stat_account(mm, mpnt->v=
m_flags, -vma_pages(mpnt));
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Since the new tree is exact=
ly the same as the old one,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * we need to remove the unnee=
ded VMAs.
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mas_store(&vmi.mas, NULL);
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Even removing an entry may =
require memory allocation,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * and if removal fails, we us=
e XA_ZERO_ENTRY to mark
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * from which VMA it failed. T=
he case of encountering
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * XA_ZERO_ENTRY will be handl=
ed in exit_mmap().
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (unlikely(mas_is_err(&vmi.mas=
))) {
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 retval =3D xa_err(vm=
i.mas.node);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mas_reset(&vmi.mas);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (mas_find(&vmi.ma=
s, ULONG_MAX))
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mas_stor=
e(&vmi.mas, XA_ZERO_ENTRY);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto loop_out;
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > +
> > >=20
> > > Storing NULL may need extra space as you noted, so we need to be care=
ful
> > > what happens if we don't have that space.=A0 We should have a testcas=
e to
> > > test this scenario.
> > >=20
> > > mas_store_gfp() should be used with GFP_KERNEL.=A0 The VMAs use GFP_K=
ERNEL
> > > in this function, see vm_area_dup().
> > >=20
> > > Don't use the exit_mmap() path to undo a failed fork.=A0 You've added
> > > checks and complications to the exit path for all tasks in the very
> > > unlikely event that we run out of memory when we hit a very unlikely
> > > VM_DONTCOPY flag.
> > >=20
> > > I see the issue with having a portion of the tree with new VMAs that =
are
> > > accounted and a portion of the tree that has old VMAs that should not=
 be
> > > looked at.=A0 It was clever to use the XA_ZERO_ENTRY as a stop point,=
 but
> > > we cannot add that complication to the exit path and then there is th=
e
> > > OOM race to worry about (maybe, I am not sure since this MM isn't
> > > active yet).
> > I encountered some errors after implementing the scheme you mentioned
> > below.

What were the errors?  Maybe I missed something or there is another way.

> > This would also clutter fork.c and mmap.c, as some internal
> > functions would need to be made global.

Could it not be a new function in mm/mmap.c and added to mm/internal.h
that does the accounting and VMA freeing from [0 - vma->vm_start)?

Maybe we could use it in the other areas that do this sort of work?
do_vmi_align_munmap() does something similar to what we need after the
"Point of no return".

> >=20
> > I thought of another way to put everything into maple tree. In non-RCU
> > mode, we can remove the last half of the tree without allocating any
> > memory. This requires modifications to the internal implementation of
> > mas_store().
> > Then remove the second half of the tree like this:
> >=20
> > mas.index =3D 0;
> Sorry, typo.
> Change to: mas.index =3D vma->start
> > mas.last =3D ULONGN_MAX;
> > mas_store(&mas, NULL).

Well, we know we are not in RCU mode here, but I am concerned about this
going poorly.

>=20
> >=20
> > At least in non-RCU mode, we can do this, since we only need to merge
> > some nodes, or move some items to adjacent nodes.
> > However, this will increase the workload significantly.

In the unlikely event of an issue allocating memory, this would be
unwelcome.  If we can avoid it, it would be best.  I don't mind being
slow in error paths, but a significant workload would be rather bad on
an overloaded system.

> >=20
> > >=20
> > > Using what is done in exit_mmap() and do_vmi_align_munmap() as a
> > > prototype, we can do something like the *untested* code below:
> > >=20
> > > if (unlikely(mas_is_err(&vmi.mas))) {
> > > =A0=A0=A0=A0unsigned long max =3D vmi.index;
> > >=20
> > > =A0=A0=A0=A0retval =3D xa_err(vmi.mas.node);
> > > =A0=A0=A0=A0mas_set(&vmi.mas, 0);
> > > =A0=A0=A0=A0tmp =3D mas_find(&vmi.mas, ULONG_MAX);
> > > =A0=A0=A0=A0if (tmp) { /* Not the first VMA failed */
> > > =A0=A0=A0=A0=A0=A0=A0 unsigned long nr_accounted =3D 0;
> > >=20
> > > =A0=A0=A0=A0=A0=A0=A0 unmap_region(mm, &vmi.mas, vma, NULL, mpnt, 0, =
max, max,
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 true);
> > > =A0=A0=A0=A0=A0=A0=A0 do {
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (vma->vm_flags & VM_ACCOUNT)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nr_accounted +=3D vma_p=
ages(vma);
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 remove_vma(vma, true);
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cond_resched();
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vma =3D mas_find(&vmi.mas, max - 1)=
;
> > > =A0=A0=A0=A0=A0=A0=A0 } while (vma !=3D NULL);
> > >=20
> > > =A0=A0=A0=A0=A0=A0=A0 vm_unacct_memory(nr_accounted);
> > > =A0=A0=A0=A0}
> > > =A0=A0=A0=A0__mt_destroy(&mm->mm_mt);
> > > =A0=A0=A0=A0goto loop_out;
> > > }
> > >=20
> > > Once exit_mmap() is called, the check for OOM (no vma) will catch tha=
t
> > > nothing is left to do.
> > >=20
> > > It might be worth making an inline function to do this to keep the fo=
rk
> > > code clean.=A0 We should test this by detecting a specific task name =
and
> > > returning a failure at a given interval:
> > >=20
> > > if (!strcmp(current->comm, "fork_test") {
> > > ...
> > > }
> > >=20
...


Thanks,
Liam
