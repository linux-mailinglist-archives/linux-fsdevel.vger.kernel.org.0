Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9951F77E8C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 20:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345523AbjHPSbY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 14:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345542AbjHPSbU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:31:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDF712C;
        Wed, 16 Aug 2023 11:31:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GH4hXk026626;
        Wed, 16 Aug 2023 18:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=+3SZUdONXjlS319Oegol8BO6E9fNHpAsos9cud0jAiw=;
 b=jwCgVkxvkEMsGN8SvvhqaOG9yP5GX34Rqn+b5b83Ojk0SHyQtnHbepYLzD/xUvCYSQfY
 6hg6sCvcsr6ACWBAPlCMLU9EeWWJpX6iCNCN006tS7a4JRtjOmsNzNv7rlI9CbFPyLIJ
 bjMOnERj2rRCkXkQRqXuGA460tanSUd97wP58fXw0fr3BTnJebBLNvoKeMLt+UvXLVzl
 +ahYposVNx7UX90e2T3eREww54vSCI3SUxayr/6Zi89RgatBl1vNDh5W14DxzImf53Zk
 6fpX7DI0OYFoUY8VVm5Nae3mI29iCvkN3wDojjOtkTLttF/0T8UDzeh+xaAtzKqKLEQM 0A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2xwquv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 18:30:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37GIIaca019766;
        Wed, 16 Aug 2023 18:30:34 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey3x4fwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 18:30:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTJsG8LmxQ5SzIP1LRfhfTfSzCO2Lv7oFsc2LXQDK+wHTATw1aH/Jo1v8U+fr8dG1fa1KfCG0V+s8MbALx3Lwz50XQrPEt6Zl/d06D+xoQN0Q2vrSv5Fu3VB1U4Mt4dV3f6q6L4ADsXaIQ8XU90K9xKauhTfKDW2VoZQnInlBJ/0hGiq12WQGRM5H5+VVjOSh16IvekKfJcmuZj8mnIhFzZ3SFG5KBHajeCeqE95DXHx+YMIBRUeEgpUPQz1K+LSJTvGa/c3JkCAAG0Ef4WGKurz7g7XsEdUiTgCglhcOo+WVJRcfreclaFfYYDM/4LWKoXD4nqwYYuEbbfanZp0Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3SZUdONXjlS319Oegol8BO6E9fNHpAsos9cud0jAiw=;
 b=WW30Ccfgnpstys10ZomV67FpZkmJMagX/pWfuTUBtqk7897tPfko7gxQuRjLhfczrC7jcz10OJU7EqbNb/GKRyNOCvVI0bXH6O+0uR2EVTJ0qHopeMayv4ZtNTpkpnskg0/PzCd/+0T//Klt9h73uPgofNmn8tTWcmxT+wLmdYFylUkDRj9Y6bMVHGQ75qbXUlOfwrwJPOgdj1MG8z2LeDIw0sNb6CMUUAnSfkIol4aTkX3A3bhy0e0ijjW0oIEZww18hMEEDB3laJbEPHBBRpYa7uiXX3j2SqfnnuqnqR1Psc8A3Y/J5NmwnxKF3GsL4+q2OKJBwp+y2hiqGbJD3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3SZUdONXjlS319Oegol8BO6E9fNHpAsos9cud0jAiw=;
 b=DSYealW+Lm8+MjjtQgZekpKsE6b6OUsS7Fau/9JslhgW5eyEHMcJtzDZDG/pOORbo57zKg+t76yTrZ+j+chNlCE3vZnC4Kh3jV8f7jutULsBLlLV8rslgm1Bmfyv0VqtI3Wl6GVUWD2QT2iDDeUUvJsx604+RdacaX29yWujDrk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB6555.namprd10.prod.outlook.com (2603:10b6:510:206::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Wed, 16 Aug
 2023 18:30:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 18:30:32 +0000
Date:   Wed, 16 Aug 2023 14:30:29 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     willy@infradead.org, michael.christie@oracle.com,
        surenb@google.com, npiggin@gmail.com, corbet@lwn.net,
        mathieu.desnoyers@efficios.com, avagin@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, brauner@kernel.org, peterz@infradead.org
Subject: Re: [PATCH 04/11] maple_tree: Introduce interfaces __mt_dup() and
 mt_dup()
Message-ID: <20230816183029.5rpkbgp2umebrjh5@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, willy@infradead.org,
        michael.christie@oracle.com, surenb@google.com, npiggin@gmail.com,
        corbet@lwn.net, mathieu.desnoyers@efficios.com, avagin@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, brauner@kernel.org, peterz@infradead.org
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
 <20230726080916.17454-5-zhangpeng.00@bytedance.com>
 <20230726160354.konsgq6hidj7gr5u@revolver>
 <beaab8b4-180c-017d-bd8d-8766196f302a@bytedance.com>
 <20230731162714.4x3lzymuyvu2mter@revolver>
 <3f4e73cc-1a98-95a8-9ab2-47797d236585@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f4e73cc-1a98-95a8-9ab2-47797d236585@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0162.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB6555:EE_
X-MS-Office365-Filtering-Correlation-Id: f699c897-674f-4283-50c6-08db9e86dfe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tgq/0MyFqdaAn+gtRgbgIuRphIF3ZYejVgSX3MV5KcQKXsV/jXclbZ2piuWjDNasDzSirRWMpAkgznXigyCkqPoVtvXTSI1MK7N4xQyrHO6tnnmehNYC0fmIUTzNwuaL+WfNw5OTV+Cfs9j0Tp9HKAVT5QIY71dgZ6veDzBcumzHT6fTgrdLbUv0bJ6TOK14R1OkZPDwHg7PLAJm2CHteuQ1l4SdaYicRdCCPEFf+SoKCqcTZfboCuJfdYNk6mQpK7G5hoj08JqM5w94yDuyYc8c40VkCe8WutjRnVP3DvUbxo68whm/EHlCZrPMAdi5zpROXMLCfbvwMsAI/szF7T1W3jPNJixjqcW9HQz8tYD6j9jPVAEZ9/+/zXV2UNGtjwIqjUoIXem6vMLQyha+6nzX4qXNytpNJwhmfrs8SMXN02H/UUOy1AFJ5jN2t+5VE/g9tlCEmC7rr1nqmx0MHteKRqKBEIm7GaZEk9Oluz/IJGjGwvampyDlVjrngwQxJ3j71fisZGqF8wm9DjTs1YK30C+Pbgvvqqcxg9NlYrBJDOmi4MrHay31VeQCOPnA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(39860400002)(396003)(366004)(346002)(1800799009)(186009)(451199024)(38100700002)(66946007)(66556008)(66476007)(316002)(478600001)(7416002)(2906002)(41300700001)(8936002)(8676002)(4326008)(83380400001)(5660300002)(6512007)(9686003)(6486002)(6666004)(6506007)(1076003)(26005)(6916009)(86362001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RF4eqNima9vox/kXpwd90CPnUoTXC96MY4MpFODgw2UgUHnsB+J3dZ/7ay7h?=
 =?us-ascii?Q?/572vx2E/I3wb0QUrFLifwbKpPlm1klQ9viE0dRomPQyNbJD1/2iUV99qZdQ?=
 =?us-ascii?Q?zAxQGiDrvQ6xzsnz08Mh1Tseq/X8tWYY2tln8PYSg9U4hteNBZt9hXY7ceTl?=
 =?us-ascii?Q?L7H00ekrpdLVA1DE1GBTL+518cpP8TK7Pv3grX0jvDCWby7AXITrrFmLHOqP?=
 =?us-ascii?Q?9Q2OTRPQWtfDnITYIQ2Pq/S6jMBJCzgsviL9bXACF2M4ngnkEpih64TuToEf?=
 =?us-ascii?Q?sKC/Rh/gbYU/nLwOm0NyjnyxEuxkgdhD8f5n6k7fapYFEIJlaCLPQs0KGVgR?=
 =?us-ascii?Q?dz7FqRmIn6gbVO8JiTYjufDMYL4QU/UqTzRlkNdS+YWRwKuL0KoTtRWVHYJ9?=
 =?us-ascii?Q?a6EbEHIB3NpHLPkCj/UfAvXiZl4vFMHOdsiuKwD/enmJCoW/mB1X2cQQtK//?=
 =?us-ascii?Q?Rr6vYLl/5scK0CMIGKlIZFq3dOkcncPDczn9wtbcOX1/PRge/kDKlo4A3i7V?=
 =?us-ascii?Q?+OM9OHnYc5De8gq5lj/dn+IqTBRb++mC4Re2zXebIiZbdH+ER8aB/NhHf9rB?=
 =?us-ascii?Q?t0HdrpKoo+9ZC09bCzWsVnEjRrq6zexF3iKJxEYo+8Tme+FyTMiF6YD34Tg7?=
 =?us-ascii?Q?GDQDixy9XxWRW/DuQrkFWzbgKridpHB+8iwaEJL2eiV4SGH9mlaZJ151AqTX?=
 =?us-ascii?Q?KDhKkqgf1pLLYk0tEXBtLwFwmIme2iDNWbqMse+fdxCXqdXMeEuMkKxnZ8zX?=
 =?us-ascii?Q?aL96ob6/h38QcalVA7v/d87marTGFyjbJMzRthiA4ao2VLq2SH7qOFjh5THL?=
 =?us-ascii?Q?26Iv0c6S0yiVWo35hXsE60o1i9iSbzHiBkyX5zvckplS0T6cwDbLJQz7EiA/?=
 =?us-ascii?Q?9EDt9x8SIUJoaIgAevfVSOi+h3/sq6SecbvMR0kpYHZdzMwFX6U+IOp49XCA?=
 =?us-ascii?Q?6u0+4RoQAr8ppHxaarI7NHURNF/XTfD60Y6A/35lqp0J1MmiJGmgNMMk5ojj?=
 =?us-ascii?Q?XCl7kv0yoC7RAxZeWRy4Do3j0JnFtG9Kn1S/YPJvJviAi41hor4KsXu8wpfJ?=
 =?us-ascii?Q?9k/rKV8NbQEawgnpkHEizScCBqd68+bfWEJzZQhmRpihW23n25IPuVbMorU0?=
 =?us-ascii?Q?I4yg8eleBZkXIPMZFl0C447Jj8VSyiMz3qLwXacr8qYwOX+NjKG9D7mtXgfD?=
 =?us-ascii?Q?fs3ofXqwsMU+EIumN4BwRum/GHpMSanJ8VFncsQVcEXxNBbj50Jk4LntyH5+?=
 =?us-ascii?Q?opkYtStJn5zfhhXAwn5bu7/y0q39fSU5FlVW2AnXAu0Z3FHx753hE2GF4wiH?=
 =?us-ascii?Q?ZePG7A0dNUc2YimZ3o1bUIconIM9hyvaU7xSVXh6rtAOxtyGydjcAmXpTWKk?=
 =?us-ascii?Q?jenP9DF42ns3O4w5gIaM0cD0CzXC/Hs2VZxGR2shrPQVS83y+qYdejCeNOq0?=
 =?us-ascii?Q?pQYWK81hsYWWJqE/TfUE1yaOL1pOd1Fs1KcvLDl/xYze7Oi3Icr7/m342wR1?=
 =?us-ascii?Q?tLVTJ+xk3uFJTLK55sQJTIC54iUw3Z9ZDybU/OZ+fea/M261bJ2bSH/E/Q5x?=
 =?us-ascii?Q?WayUpKC16VDk86mnAvct1XKdO1rsHzBEJyaXoWg8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?PM6ZPiyqujMPwpEUdIyKgA6UUxRXbgiJfmTmgdGNhtu5SLrelkda0wd3dm0i?=
 =?us-ascii?Q?2oqosUDaKJH1meuVZuLEk6mOJdgm3Cpk35qTkJYnHffVaFB31sMqBMU0PyDo?=
 =?us-ascii?Q?4awiVSMBYPnvpeF9MAGnliRrKzSXwS51B3RVlRbDypMzFH1SFxZMaVj6O64X?=
 =?us-ascii?Q?pkYTyPQ3OzMFArMJG9v1yg3m23H7P7TofK2QC8b9LFaYWtHH/V8oUdTdDxSH?=
 =?us-ascii?Q?aSvqyX8EHLCwJG+tqpHsA2KHOuK5baxaaSh0VEJImGlFM+J4TrIL4kO92AIe?=
 =?us-ascii?Q?OgQHbArXWAOD6n5dAllY5UJ3NNC4ZUT1r0HiDQeIR5BddgV2cu5wRW3yOgYj?=
 =?us-ascii?Q?Tr0vlmS3tYL6jKdChlOu5LDjKGtkNyOFUNl6u/r+xzjnuHSGNaPjOuQ1dQdp?=
 =?us-ascii?Q?OnYBQdwNc7La408070dUQg6oZmwTsDp7LZ8tfIghK8XhgDTjdU8+v8jYoSgU?=
 =?us-ascii?Q?/3SF8j7tg6dglXGjz2ASjFWslt+0euiGrG06n1ZgTdrgZ75kEC23hhko4G1M?=
 =?us-ascii?Q?zsJx4b7rmL3X3pSy0flRGra4fqauGHtKLr9aR+8XEqwfOrJl885TROoD8z/m?=
 =?us-ascii?Q?HSCIqLWANQnbNQYqLubyFKMwEobaIYahRNjKTOW/vOChPHxGDRDWiIP0IPk2?=
 =?us-ascii?Q?FxaYGVWjH9O8/CThE2qRevKZBMf1qmrTo+NNFZmpD8ycfNgdkAQTtlJ9Q+Ld?=
 =?us-ascii?Q?1YeMea50bm15aKtZfjxlVgFotNje4f8HzE6qllA0yNNwLj4dEY4yV6+3u+yz?=
 =?us-ascii?Q?5T6aAlYoX4Yq2PG5TRs1HglVAn2cwUv+4Wgz5TclvXXAPyUUtbDOBEnM/UdU?=
 =?us-ascii?Q?l6UiDean3m5hrTaij3R/TaQ/VzrAZjPoI+cmtCRQeYnVxePz9Qb9wfVNzEiN?=
 =?us-ascii?Q?v9JMa/4Ptw04lXHMkLFaOi8xk+C5AJqNtH5jumND58ZhSCEBnc2pWAfRqrtV?=
 =?us-ascii?Q?nlK+6ZezMN5qh6htfYnH/uMH50mwdH7fysGIwohoN1DE1O+xTgxk3iQtCNn9?=
 =?us-ascii?Q?/SaoUh+2n5CaHXYXFDcGXROGBBZtpW6PKJPMTjt/IcyhSUZdAxgwths8vLSz?=
 =?us-ascii?Q?2mQAJhK0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f699c897-674f-4283-50c6-08db9e86dfe0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 18:30:32.3467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26g6wnxRz3xjJFQo0zJorhRbul28sHoA91o7DE36ugOYGeDhyPBdVfeBNeQ41Ue7RlyUcz3+46WKq8hP+N0RUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6555
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_18,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160162
X-Proofpoint-ORIG-GUID: cs85a8WdDXXjvYgtQ-B7y5wwHaOfM3VU
X-Proofpoint-GUID: cs85a8WdDXXjvYgtQ-B7y5wwHaOfM3VU
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230816 09:42]:
> 
> 
...

> > > > > +/**
> > > > > + * __mt_dup(): Duplicate a maple tree
> > > > > + * @mt: The source maple tree
> > > > > + * @new: The new maple tree
> > > > > + * @gfp: The GFP_FLAGS to use for allocations
> > > > > + *
> > > > > + * This function duplicates a maple tree using a faster method than traversing
> > > > > + * the source tree and inserting entries into the new tree one by one. The user
> > > > > + * needs to lock the source tree manually. Before calling this function, @new
> > > > > + * must be an empty tree or an uninitialized tree. If @mt uses an external lock,
> > > > > + * we may also need to manually set @new's external lock using
> > > > > + * mt_set_external_lock().
> > > > > + *
> > > > > + * Return: 0 on success, -ENOMEM if memory could not be allocated.
> > > > > + */
> > > > > +int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp)
> > > > 
> > > > We use mas_ for things that won't handle the locking and pass in a maple
> > > > state.  Considering the leaves need to be altered once this is returned,
> > > > I would expect passing in a maple state should be feasible?
> > > But we don't really need mas here. What do you think the state of mas
> > > should be when this function returns? Make it point to the first entry,
> > > or the last entry?
> > 
> > I would write it to point to the first element so that the call to
> > replace the first element can just do that without an extra walk and
> > document the maple state end point.
> Unfortunately, this does not seem to be convenient. Users usually use
> mas_for_each() to replace elements. If we set mas to the first element,
> the first call to mas_find() in mas_for_each() will get the next
> element.

This sounds like the need for another iterator specifically for
duplicating.

> 
> There may also be other scenarios where the user does not necessarily
> have to replace every element.

Do you mean a limit or elements that need to be skipped?  We could have
a limit on the iteration.

> 
> Finally, getting the first element in __mt_dup() requires an additional
> check to check whether the first element has already been recorded. Such
> a check will be performed at each leaf node, which is unnecessary
> overhead.
> 
> Of course, the first reason is the main reason, which prevents us from
> using mas_for_each(). So I don't want to record the first element.


I don't like the interface because it can easily be misunderstood and
used incorrectly.  I don't know how to make a cleaner interface, but
I've gone through a few thoughts:

The first was hide _all of it_ in a new iterator:
mas_dup_each(old, new, old_entry) {
	if (don't_dup(old_entry)) {
		mas_erase(new);
		continue;
	}

	mas_dup_insert(new, new_entry);
}

This iterator would check if mas_is_start(old) and dup the tree in that
event.  Leave the both new trees pointing to the first element and set
old_entry.  I don't know how to handle the failure in duplicating the
tree in this case - I guess we could return old_entry = NULL and check
if mas_is_err(old) after the loop.  Do you see a problem with this?


The second idea was an init of the old tree.  This is closest to what you
have:

if (mas_dup_init(old, new))
	goto -ENOMEM;

mas_dup_each(old, new) {
	if (don't_dup(old_entry)) {
		mas_erase(new);
		continue;
	}

	mas_dup_insert(new, new_entry);
}

This would duplicate the tree at the start and leave both pointing at
the first element so that mas_dup_each() could start on that element.
Each subsequent call would go to the next element in both maple states.
It sounds like you don't want this for performance reasons?  Although
looking at mas_find() today, I think this could still work since we are
checking the maple state for a lot.

Both ideas could be even faster than what you have if we handle the
special cases of mas_is_none()/mas_is_ptr() in a smarter way because we
don't need to be as worried about the entry point of the maple state as
much as we do with mas_find()/mas_for_each().  I mean, is it possible to
get to a mas_is_none() or mas_is_ptr() on duplicating a tree?  How do we
handle these users?

Both ideas still suffer from someone saying "Gee, that {insert function
name here} is used in the forking code, so I can totally use that in my
code because that's how it work!"  and find out it works for the limited
testing they do.  Then it fails later and the emails start flying.


I almost think we should do something like this on insert:

void mas_dup_insert(old, new, new_entry) {
	WARN_ON_ONCE(old == new);
	WARN_ON_ONCE(old->index != new->index);
	WARN_ON_ONCE(old->last != new->last);
	...
}

This would at least _require_ someone to have two maple states and
hopefully think twice on using it where it should not be used.

The bottom line is that this code is close to what we need to make
forking better, but I fear the misuse of the interface.

Something else to think about:
In the work items for the Maple Tree, there is a plan to have an enum to
specify the type of write that is going to happen.  The idea was for
mas_preallocate() to set this type of write so we can just go right to
the correct function.  We could use that here and set the maple state
write type to a direct replacement.

Thanks,
Liam
