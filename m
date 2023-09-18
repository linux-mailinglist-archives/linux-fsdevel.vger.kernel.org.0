Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677AA7A5178
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 20:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjIRSA4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 14:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjIRSAz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:00:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4407FD;
        Mon, 18 Sep 2023 11:00:48 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IHpnxJ011183;
        Mon, 18 Sep 2023 18:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=wYYZJE2TM15phx5BRl0VjVjRf+/8ZmGvLBpcVmsqKx8=;
 b=Seibmr1dXKUgIn+g5zb0cm4rb0tpk0ID/ft0vIaHDQjMa+mmkSvAtotAeMKkX3wOKqjD
 UWNi5kvDtdgPsBnRk3f/Et23p8zpDLNyWFjpX0xMwi0YeYsexfNIbKi1RatWSvftrPaF
 whYP53uBcaGw6F/3b1BOmNRpJ3k3pL2fyy8pxdoVK/g+JFpDTIwO/k3Ifdk8BYX/aNVn
 e+Rxpy0ypqPRb0IRhX5ws0toHsT9Ji6lEGfoyDcoCEsZ2v5M6Wa74QnkGAJWpP+5F0sA
 iSJYG8/gOY7t/iSd7m5fKE1va0k0RtaYMljKYEaLv+9r6pETUe/n8+kRDMfkwiiNuJTo VQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t5352u7c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 18:00:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38IHFgFe002391;
        Mon, 18 Sep 2023 18:00:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t4cekd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 18:00:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkY1WL79KQ9vPImTuudNj6jii/tLDjax7fhcQIDDB0wE4r9+DLqsYGRsGPn0APRSZ5ObYWDiDzjynYTtOc226Oi7rh82AmmHLhefzmY7zE6LpqZJL6xfHGervSStBlm32z1k8HhQU/tvXBKNtJcHKbkW5P4wSiB4Efb1NtFhxGv5mH9IIEduX/cUVU/IePCs1ZCXfk4PleQpqW7HUIYYtnLP7Gco1GMytxqb4YBBEMpAkNfvGmSPeNJKzK0Gz3jsgSdCBdtcBffkJb2UozeHssHrb5OpyyRXhtpe2NlXirTDbwBc8+Q/Ck1Rjv1+RtQgruKT42a28ZMo3SKE6EM8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYYZJE2TM15phx5BRl0VjVjRf+/8ZmGvLBpcVmsqKx8=;
 b=moeWe9eReBIGQq8VsoNfMKWuAWxR0C/jqww3JSnGz59g7s4l6lsY+xDbrPmREAFuwv95RgkdhE3ipgJ0IQkP7/Hsj4mSCLYeVM3ay56ZlyRCg2r2hGosnSyUtVITEibVd6Y7Lh4WAQW5AvYNX+gnNcaHmmzm8+akJRkG5P+ZOshTw6ZdRRrLA+nD4Uqmt7I3TLiPrC+J8jnO4zER/Y0CAuBUU4GOa5+X0rLdlOfSBHtX2V5RBlN4h1O9KS+1LfdtWRhfqcfs6FxY5kWrL1yiUo7I0dSn8R5IVyBwhPPTdNT7I7v5EuDZdm8fkwYnmxummP2xEBCksryTzaBJTSjEpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYYZJE2TM15phx5BRl0VjVjRf+/8ZmGvLBpcVmsqKx8=;
 b=CE7Z6BlXz19um0Y6SZU9d1d2WnpEpHE6OM1ooVCATJ/i1yIO56UOehDzlpM3LfvN04OcSZzOulm8hrFrBbVImTXjsi4TImAv6gPgr62dDi7Pe2aEM1g0vkyTfixjseVEqNJ4OAw4Z096jLGR1bHIzSH8Z/DBDpcy4Udp4fYzfY8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4455.namprd10.prod.outlook.com (2603:10b6:510:36::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 17:59:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6792.024; Mon, 18 Sep 2023
 17:59:58 +0000
Date:   Mon, 18 Sep 2023 13:59:55 -0400
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
Message-ID: <20230918175955.w6vowfschshhy6cu@revolver>
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
 <20230915200040.ebrri6zy3uccndx2@revolver>
 <7f0db16b-609c-7504-bd5b-52a76e0200b3@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7f0db16b-609c-7504-bd5b-52a76e0200b3@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0435.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b071dfd-5302-4e13-aacf-08dbb87112ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k68R4RwCzZwl9Hutby98rc3zdoVh0QIpj+KrvrQTDoP6X4EKIA1aAWJd9vruVpn8FNkZ4KPu8PuE39nvaXa1GyFtchcYBXg8izxUjsrJOw8lXUfZ5CEvOtB4VTD/+xktxxBNtiefFbPXnm9yXd1HC0H1je5X6H+qhWetnDQ/CfsdrC1rgH0hk8125JiP5Q7cTmjQC4ub1ILhk/UVH8aQBahLFluO9I2zAqC29Uky0bbRhVtYXz+VoDke1JSAytbMfUiTKrEjocTI9yffoC5kQ3bI9H32W1jDMcwFavLji98CHd+vlYfsHmDTSByPpK6BawSLbOJP2dK8ANQ48tmAxUU3GzmDRnc+FfxAoGU+Fubbdx/0mY9OQsnKc+3EiM4zaaoOSNAsgVEgCqQZTCFDZ0dsDvbgz66hjgzzQN4umy+bGQm5GxGKjTKbpuzRmB/gJlrXxWmyHVLRpr42/X4heYubYfUU9wtCVIkLuovuLoRnZwb3Yzyw9yQiPhr6/ZX8AJEZ/dwZEdJkPYAgTmENhGSFH+5DURTMQZ1ufHgatdaPxnUzotfozL7yIW/+jSsz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199024)(1800799009)(186009)(6512007)(9686003)(4326008)(6486002)(6506007)(26005)(1076003)(8676002)(8936002)(83380400001)(33716001)(2906002)(41300700001)(86362001)(66476007)(66556008)(66946007)(316002)(6916009)(38100700002)(6666004)(7416002)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFU1eUxjTExYMkw2eHY2bDZ1THd6YjFwdVpSQmxvdjN4OUIyWWNSMTZnYUFw?=
 =?utf-8?B?T05yaUFUTnZRTDgxOXVaY2FxOCtpVkZKaExmblA0OWgzZzR6cXJVWmFMZ2dv?=
 =?utf-8?B?SlZqZFp0SGs1QnMxcHMwTXk2QWYvaFN4UTNob25meFZkcktHUitsZlQ1Z0ll?=
 =?utf-8?B?R291YTZRSjNrem5aeGdBYm5DNjBESVhYRndOT2pnc1JKdHltNlgzeE5tYzNs?=
 =?utf-8?B?bjhmZGlLamViTHhaNmgxbC9xR1l3c2NUMWQ2azVlQXptQ0FkR2RkNFFQMEs3?=
 =?utf-8?B?NnUyT1l5OXF5cXFtUWtMLzJKTk82RGVVSm9oeHNNTWs5alYrMjdXdnhIeUJu?=
 =?utf-8?B?QnpCWHhTb3l1QzhaUTczMGl2UlVrcWtIRVAvSWRvczJ0YUQwUFRRSjlhT3ly?=
 =?utf-8?B?TWxkVThhdmZOUzhYaXA2eXoySEl6dVVCZ0xHcUd6SHFpNGI2SDc2TStqNEpG?=
 =?utf-8?B?TmVYRTVCbFp4cElmbGlibGdrUTgvWHhqSlVzS2tYakxpc3puOVUraG0vYU5v?=
 =?utf-8?B?Ui8yUVpvL25TN1YzYXJsUzYxREtFWHcrajIvT1Z3NlBWampjNXBhem5hVko3?=
 =?utf-8?B?RGx3RCt3S250UUtBRXR1NC9iaEVGcUlwQnpYSUd0dGh2UDZJN0hFZlJsVUg2?=
 =?utf-8?B?VngzSmtnenVLM255ZE9QcVpDK2ZYL2JwbFk0Y0hjSnZZQWx2dm9UaU1OZHN6?=
 =?utf-8?B?bHdyYlRFVU1BTi9MQ1JmMmpzN25NMnBReWdKOW1pMTQ1c2hMS0tEQVd6bmdm?=
 =?utf-8?B?NGtFUTNabmtMa1RweW9HZEdVTFlGZ0NNS0dZNWRuSkhOay9mK0FsZnRia2x5?=
 =?utf-8?B?U1NPMUhiMnArbVpqYVIxUUNEZGpkMmZWUDNrRVYvdElvdU11RDZmOUxnQ0Va?=
 =?utf-8?B?N3kxcUVNaHdmUmwzTWMwTkZyODcra0xsVk9sOHloNEsyaEhnT3NQN0I5eW5y?=
 =?utf-8?B?aDZta1daMU1nRkU4cnE2UjZmd1NGTERqL2Fxd09XUGZVQTZUcndjU0FlR1I5?=
 =?utf-8?B?UlUvWGljNHJsNURaNllsRzZjSGRZMExHZkRxOFN5ekFhY29PUUlkY0lieXk0?=
 =?utf-8?B?d1ZNblNKTkQycFVhUkdxSENjSDBXeUp4ZHhpQkNTdkJpcll2UlZNUGw4c2xR?=
 =?utf-8?B?c1NiZU1qWjhPZFp6UzVpSXF6cGQzc2g5MC9Xc2NIWTIvejR3OVNKck1PdTlX?=
 =?utf-8?B?Y1VQOXZ1bUJEckxQa3BVQ2pCYXFHOXZ5cGxqTmpOcU03MytlaWxjK0ErNkdp?=
 =?utf-8?B?VzRSV1FEM0VFYnFxTXVYZ0E4OGVFa3k0aWJoa0hBSm9ua1o3a200a0t0L01W?=
 =?utf-8?B?dEJIOGh0OUpuem81N3FDdnprbjR4ZGdiYU51TGtCdEZ4QVhLYmtsaE44QjNU?=
 =?utf-8?B?Q25qYTVTRElkMHVDUDZvRmp2ZGdKNE5ubDlSUWM3QlRJR1ZVcXcwdFAySXk2?=
 =?utf-8?B?M0pINkJ0L3Rvc1hJSkVPSzZaK0wzTUdob0VrUTJZa0V1YnFWMFNVUEJ2TWpu?=
 =?utf-8?B?TGNWS2Q4ZTlTWTNXbWpENUp0djcxM0pYQXpXeVZ4MG9HZFJiS0x6Uks3cm9m?=
 =?utf-8?B?eFVMdU05dk5HN0xValZkRFcrSExDWTN0bFJTTHRTM2sxN3pNRjUxdHE2TTlT?=
 =?utf-8?B?NUxaUGFFNmk3SHF6QmRadVBDK3lzQVg4TjNZZWh5MHZYdzFRbmtiRFl2Rlhl?=
 =?utf-8?B?Q0Q1WEltdlRkeG5PNU5od01LdE1pZFltSjJ0RFNiY3FwSXBMM0hwSzB1MXlU?=
 =?utf-8?B?V25UN2VsQ09ReElIQnVLMUIwWVJvZ05xenhQWVBwM09qNDNXWEJRZ1ZIVDRa?=
 =?utf-8?B?cnlFUzNhU2pReDUwU2ZrUjhhblA0Q1pOc3JnVHZLVExTeVlmYnQyVUFCVWZ3?=
 =?utf-8?B?UXYraGEwUEJZTmkvclpENks4bFZJUWVFUzcxVlJOaU8yOEltMG5iS3dUcTE3?=
 =?utf-8?B?bjkrNnVBRUpHYzdUbVNpWDBmWGhMTy9hWkNVTWU3clBKNWtkV1NQelFOM0Fr?=
 =?utf-8?B?ZUU3R3BRRm10a0w2dUhWaHNqbmNuS0FlRmoyTFBmSGFTSVdnQjJ2M3l4VXZW?=
 =?utf-8?B?SEs3bENrSnR0b20xZUpFNHNTbldrQkl4UEI5ZmZhVjNVR3BzTmRtZzFoQnJE?=
 =?utf-8?Q?pG0/RQmgZFSD5O4bt2PC5rAc/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WnI0YzFTYkJaQmNYNTVzYUdkMFBQTzIxSDFuZTJ1Vks1aW5IWkkzQzU5YkdK?=
 =?utf-8?B?RkFWSDZwNlFOVTZvOWtMUWxvdUtGSU9iWnVWMVRMMEhSOFg1c2V6NCtjcFZv?=
 =?utf-8?B?TXhwUVRmeXkwZ0dyWWZGUTJ2SElRT0QySzZEWmxNaTdDWjhMYWtBUHFvTWJv?=
 =?utf-8?B?aUhxWHFPUDhOMVBkYVZDTk1zSFpUdXkrbnRINWJVaFF0eU9abCtNeDMzZXo4?=
 =?utf-8?B?QVJIZ0lnOXRnR203N3NpNjhZTnp2UjYydkkzYmFzcm9jUTZDRUlabDVKZFZU?=
 =?utf-8?B?cC9GZCtBQjBYdm53WXJHNmVKRkZlRXE3R2FmNFczUjdVTEZuSTZPWE9wRnJa?=
 =?utf-8?B?ODgxenlqMCt4TTJaUjR5dG4xRVVTL00wdXY5NXNoSlMwTWJkYnlHeFdaMlJq?=
 =?utf-8?B?VmJjS2NKdUtlUnVxM0RxSU5EN3QyVURudURiMGFFd1o0V1VjYnRNd2xPM2xl?=
 =?utf-8?B?Rk1nNURJS2RIOE9nQ0dJa1JiS2lyWHM4a1M4L0Z5TjNieUxDYjdwNkFWdGlO?=
 =?utf-8?B?cFd0aEU0UG9YWHBrVE1MUGJucjVOUkI1R2pwbDZUNnR2SXB3RVpveE9lZjZV?=
 =?utf-8?B?dnJzdkdNYWd4SWZsK3BDOGxHcDFLdlVISU80M0xaczlkZEtxTkNGWWE3b3RP?=
 =?utf-8?B?VEtqQ3pEVTlld1ZTRXE5N0pnUHZWcWYvMmx4Rk9QMDlyTzlhZmZQcmgrYVNh?=
 =?utf-8?B?S3UzRzFObzB1OHJYS0V0bVdQd01JT3BjKzd6Y1dWTk5ndTh1SjhZdDdNeWc2?=
 =?utf-8?B?ZVh1Um1xRE50eVcxVnU0R3VmWWIzMGNzNy9LNDEzK1gzWURXTC9JdkFlUk9h?=
 =?utf-8?B?M092aEZBYXRWZDZ3cFcxTUFuMkVqMXVML2MzelI3T2NLVWlMYWRZMXZzbm9S?=
 =?utf-8?B?cUR2c3VBdTVuUHQ3T3orcUNKbytCRDlRMUM5MmFKdjNnZXRyMHNQNHNjTzl3?=
 =?utf-8?B?akdkUUpDdklHdG9yQ0pOemV3eVhoRkhWZG5xTWlqUHc1aXRFYXRIcFJkaC8r?=
 =?utf-8?B?MHJVa3BCeWdVL2JiZG84c1RSVnY4UWhWcDN6dDZ5UmtMWXZPelVpMXBHOXpt?=
 =?utf-8?B?VGFham1mL05LOFpRNk5lUlQvajZOZ1o5RkQ4Vm9NU21UdFNGbXNsSkhRSzAv?=
 =?utf-8?B?dkNUQ0NVd05ISCs0c1FsQ2NreUVhZ0hiVjdiOWVORkVYUCtXRXdSbHFmdFBH?=
 =?utf-8?B?eUNnd3U3bzdRVlN1c1g1ellObDJxZnA1Uzh3Rk9yYkUyMlBKcDV3RHlXMVVZ?=
 =?utf-8?B?aHFEVGUxOUgxdTQ1TTNiclNKU1cvTlArM3JId1JTaG5YMWFWeWRaSDVONEkx?=
 =?utf-8?B?RUE2M1hjUnBiS2RGS1dCb0g4bEJ4djlSMkIwc1pYRkVMOHZFclZHeHhZZkJv?=
 =?utf-8?B?WlNOeVhjaGFTbW1heU8wUktyM3lEOGlwc1ZTemlFWm9RMFl3dmFmQmoxbG5a?=
 =?utf-8?Q?Q4g/bPEO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b071dfd-5302-4e13-aacf-08dbb87112ab
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 17:59:58.9055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZnkfKu5R/oTFDe3UWVRu5U4lZ5S3hlWGi5mSjQmDzp+Hg2mkHWbJscw0c/xc2dL2OvJtShjNZP35JH8vMOYrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4455
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_08,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309180159
X-Proofpoint-ORIG-GUID: cfVC2knk8YOAFMFFf3GFEy6ZBJtOw3Jf
X-Proofpoint-GUID: cfVC2knk8YOAFMFFf3GFEy6ZBJtOw3Jf
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230918 09:15]:
>=20
>=20
> =E5=9C=A8 2023/9/16 04:00, Liam R. Howlett =E5=86=99=E9=81=93:
> > * Peng Zhang <zhangpeng.00@bytedance.com> [230915 06:57]:
> > >=20
> > >=20
> >=20
> > ...
> >=20
> > > > > > +=C2=A0=C2=A0=C2=A0 if (unlikely(retval))
> > > > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto ou=
t;
> > > > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mt_clear_in_rcu(vmi.mas.tree);
> > > > > > -=C2=A0=C2=A0=C2=A0 for_each_vma(old_vmi, mpnt) {
> > > > > > +=C2=A0=C2=A0=C2=A0 for_each_vma(vmi, mpnt) {
> > > > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct =
file *file;
> > > > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vma_sta=
rt_write(mpnt);
> > > > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mpn=
t->vm_flags & VM_DONTCOPY) {
> > > > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /*
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * Since the new tree is exactly the same as the old one,
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * we need to remove the unneeded VMAs.
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 */
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 mas_store(&vmi.mas, NULL);
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /*
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * Even removing an entry may require memory allocation,
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * and if removal fails, we use XA_ZERO_ENTRY to mark
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * from which VMA it failed. The case of encountering
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * XA_ZERO_ENTRY will be handled in exit_mmap().
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 */
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (unlikely(mas_is_err(&vmi.mas))) {
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retval =3D xa_err(vmi.mas.node);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mas_reset(&vmi.mas);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mas_find(&vmi.mas, ULONG_MAX))
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mas_store(&vmi.mas, =
XA_ZERO_ENTRY);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto loop_out;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
> > > > > > +
> > > > >=20
> > > > > Storing NULL may need extra space as you noted, so we need to be =
careful
> > > > > what happens if we don't have that space.=C2=A0 We should have a =
testcase to
> > > > > test this scenario.
> > > > >=20
> > > > > mas_store_gfp() should be used with GFP_KERNEL.=C2=A0 The VMAs us=
e GFP_KERNEL
> > > > > in this function, see vm_area_dup().
> > > > >=20
> > > > > Don't use the exit_mmap() path to undo a failed fork.=C2=A0 You'v=
e added
> > > > > checks and complications to the exit path for all tasks in the ve=
ry
> > > > > unlikely event that we run out of memory when we hit a very unlik=
ely
> > > > > VM_DONTCOPY flag.
> > > > >=20
> > > > > I see the issue with having a portion of the tree with new VMAs t=
hat are
> > > > > accounted and a portion of the tree that has old VMAs that should=
 not be
> > > > > looked at.=C2=A0 It was clever to use the XA_ZERO_ENTRY as a stop=
 point, but
> > > > > we cannot add that complication to the exit path and then there i=
s the
> > > > > OOM race to worry about (maybe, I am not sure since this MM isn't
> > > > > active yet).
> > > > I encountered some errors after implementing the scheme you mention=
ed
> > > > below.
> >=20
> > What were the errors?  Maybe I missed something or there is another way=
.
> I found the cause of the problem and fixed it, tested the error path and
> it seems to be working fine now.
>=20
> The reason is that "free_pgd_range(tlb, addr, vma->vm_end,floor, next?
> next->vm_start: ceiling);" in free_pgtables() does not free all page
> tables due to the existence of the last false VMA. I've fixed it.
> Thanks.

Sounds good.

Please Cc the maple tree mailing (maple-tree@lists.infradead.org) list
on v3 - we are looking forward to seeing it.

Thanks,
Liam


