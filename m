Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECEA53AFC3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jun 2022 00:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiFAU5T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 16:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiFAU5O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:57:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DCE5D657
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jun 2022 13:57:11 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 251K2RYP012304;
        Wed, 1 Jun 2022 20:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+WsFgrZx7NcjR9uJc17I/zbPx5GBuFqd7FdJmx9kbwM=;
 b=frtuUZ8XozXwwsMkwndIrLBZvtXfkH2mIb1A4O7jIn/AmPVZ06rO768s53GnJq5YvzVW
 7nDCV+DUOYfm1TnQWO16iTOv1jF1weCSS64Iou/mNr4bfAU/hEL/0w7VTTX4oFRR4GK1
 8f8D8W0jznE9hyau6QyOuO0XqpSFbVskZeMN9xQIR/JKznSfaZrypZdfqf1b2k+PsfsP
 CojeJ66ge+qtvTbn32KKU1s2f6/iaNNQ+FOWiJqcydQWLi66TnARyryvZrHFuqsF/1J0
 o79mlmdaaTYDu3sPKrKqk6auFYcvrYBlWuPRkVi3JXbX4MELIaShYvyQS6a08YRwj0SH vg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbcahrvgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 20:57:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 251KuLVW013247;
        Wed, 1 Jun 2022 20:57:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8p48h5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 20:57:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ng8Ba+oWTmiPPC0qBbPQIIFPnkxi0nChuj04FyCGnxn44yr8rVR3aKWe0jGvXG+30Vp/D42yTarFQfwyS9CSizIkmaHzZO4hrufB53FmP5DdBfAlLfVT1UUKY4n7kcYLkBUikhSqunToJTEFW7p4bvnqTE4x+Lmcr2g13kWWP0sn0FhsfhxwQLhbbwCDHFfghv0NADmpQrsLnLfZF6pMit+wkFXtKJE+l5/DuQ4+0p/fKRTx5eviard/4cOsIdvxF0MXwT+TruH/EJ3CxRPLXVyjBxKqFtnieAVVwvlywQ99ed9X5FDz58A0T6rSJWn8sw/HtdfSRLPg9XrhNkJORw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WsFgrZx7NcjR9uJc17I/zbPx5GBuFqd7FdJmx9kbwM=;
 b=DClFepzrlMxob0JFq59z3l+fIwQbNyA1eR57W8myEyXgrWkq7iy79vEK9DT0VTyG0UMIJa6e6zteOhaGKczAnJrMzKgALTnpIzdP8rX902j9oMwWbTZOvtmq41qhYTGL966q2TMnCGpYv1Vskqo2R0MnMAykoBsjLyJEjId6sz9rZSjJLnD3VmYy2wMj2lsDNlb90M1gn94PiwCsDWiHplIDs2pD0UeUrOGS+IvfXF2O84yYO8fetlcb0u4LZKbip9ghhfdrfCURFvOQ7XrKwaHfPXwK+RRcwatA/pmEvyD5chxurxaxVmVtsxvZCPWSnUcxx1ltwMvI6ny+epxWgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WsFgrZx7NcjR9uJc17I/zbPx5GBuFqd7FdJmx9kbwM=;
 b=Y9Sqb9Pi8VkmiHJcKGu2TRw2oyNCoCXyPukui/ZFw+f5IZaejUp+Rc2p1bPPEO/YZqEOV6Fbn52UFsvBUVtwv03Rf1UcSSnmpgR16BR4wBCTaOD0xJWVhIWmAk4Pff0leNrPQnem1+TZ4NWTLLIrPeyBoJBXdonhytB9F6VpsDQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4292.namprd10.prod.outlook.com (2603:10b6:a03:20d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 20:57:01 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%9]) with mapi id 15.20.5314.012; Wed, 1 Jun 2022
 20:57:01 +0000
Message-ID: <f7492be9-ba1b-ba01-fa4b-ca5a4cdb7c56@oracle.com>
Date:   Wed, 1 Jun 2022 13:56:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/2] filemap: Remove add_to_page_cache() and
 add_to_page_cache_locked()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
References: <20220601192333.1560777-1-willy@infradead.org>
 <20220601192333.1560777-2-willy@infradead.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220601192333.1560777-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR18CA0055.namprd18.prod.outlook.com
 (2603:10b6:104:2::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 230ab6c6-1909-4985-7899-08da4411463b
X-MS-TrafficTypeDiagnostic: BY5PR10MB4292:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB4292407C2EA3085E2FC7B776E2DF9@BY5PR10MB4292.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uh89sVz32KcXXRxmFNiRdYbzMebWWNT5g7wZvuIHV3VZMDi5c4msqMdNgPgk0oyVbbubSjnAmacS2TT7/wu4G3nDO09VqFdCeh1WMZuYma32h0dKhiAHlZv3ImKUix+5g6/csgDM86Je0JkdekfPLtFhA/DnuRNvPgLLkuijh3OeO9xYCMX6OL0FSflCTvBa4PjLaULiChebezB2orJzblZZ3iOTxumSiH93HAwjZZfmEN1S/3C/JWRLce6XoyNOo3r5cAb/FCU1ejcvO3txGI6h6gYmQ3lVRCGJQJ9TB88durie+zdvkoC8a0y839vgXfeGS+1r/qtSJ8q6jL9MM6logDEjI3V82vsIjfkeXXeFp/lYFJGvhGyXdG6FrydzvxJqCH2D3Pn0N3Lk5PeOLAdfRnpic8S1/xGCuNzlX7ClrQA9MS2I5U5PEgnVHvqJKKJMci3jgKizEEkCUqk8hCkOrRs+pEtwjuk+F6F4gcW99bpSI7J8GYd//KTbLX/GsXGpokJfxc72Ga10JC6tbeFy7LKUAcpgx8AP49/d84yGjogt/jXf1+ELjon80iA7s8n1lH6hGKYrVi1lrEhtWsHw1VyL8VvWWt+YIXB9ehvd48XBwycTk1jVcs86cO6XL0p5fWsiX4ov+UuC2l92CnAzPGJWT+nsQHeRxxzLQC+Fmf6CvmqTQXOf4PncxLXdsWXfepPN2pkrTIUDf6RA+TX1lpaWV6JxHIbbw9geShGuYLaG/qHTtq/ucT8fe/3Bi7OC0P3ExjPIdWF6vpMJNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(53546011)(66946007)(38100700002)(26005)(2906002)(6512007)(186003)(6506007)(52116002)(4744005)(86362001)(8936002)(44832011)(2616005)(31696002)(5660300002)(83380400001)(31686004)(36756003)(38350700002)(6486002)(316002)(8676002)(4326008)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3BWTFg0R21YZkRnZ24rOHE1KzR5M0xsU0xWdXlENVVhck1UeXg1Rll1MUVQ?=
 =?utf-8?B?RnRrZGtBa3ZxZllXaHFadGkyRXM1VHRqVk56MVdjV1JBQmFaV1VUWGJJWE9t?=
 =?utf-8?B?UzJxY01XMWx3MGNjcmJac1pkMGNXWFdNRHdGd2RUTWJIeVdtZkxkTmFMcW9J?=
 =?utf-8?B?a0s2ZUtRYVMrNHkvS1pPMFZFMnpJMWhZbUpJU0IrcUN1dE5vellWWFlISjRo?=
 =?utf-8?B?WWRWT0NYcG9oSXRJTmJjSnFodE1Oc01JVEU0VWZvRUNmOUpLS2puM2h0Mmtm?=
 =?utf-8?B?UmREeXRKMUFIVHpFNDdFMHUwUzB0YVFuYyttKytiNk43NXR6LzQ2TkNxWVFv?=
 =?utf-8?B?NlJFSHdULzVvd2cvR2MwcmFGYWlZTmdFV214MVovTkZxN2FSWFBUZnAvR21p?=
 =?utf-8?B?Vm1uZk5IUm9Mc1NRK0hYQnBXaFlydFhaOGNVZGZEdVA5NWw4cXgxVU5wamZo?=
 =?utf-8?B?NFpJYnZNV0Y3TWR1bGkzdnZaTDBuVWlhdmMzWDFCUWlycGFmRGJkdTNhR3ND?=
 =?utf-8?B?dUN4Z1cxbE1LV2xURW1aZU41K2U2b2s3WmJUL1d3TVB6Z1l6VUZQNnd6OGpD?=
 =?utf-8?B?ZWUxTFJLaTlVSWk5TUFkb1VaSXdQK1ZIWVF3YU9xM0dSS09NSlJ5TEh2Sllr?=
 =?utf-8?B?UE82QTdmUjNhRlQ0Ymc3cTFDekNZSXJBaGNlcERPVDJMQVJFWkFQNGhtYmsx?=
 =?utf-8?B?V1lWWVNpQUpHRzZxcHptMGpoUlhETldUbVE4ZWZkeVpjaUlaejIremNneWVu?=
 =?utf-8?B?WVZHVVRoeXZ2Nk8vL3VBNVRyUzJ4bk9ncVZmMldiZGVBaGp6anRRZFpIVTVh?=
 =?utf-8?B?VnhUUHUwQjJjS1VEcUhvYXBzY3MvZGZ5WUdDWFZUZU1CWldCem9CVi9iWC9M?=
 =?utf-8?B?MUtYVmRZeWIyOVN0TmlRbU5PblZMQVIvd1lNUXBGM3FjNFAxOTRxeGlkdWp3?=
 =?utf-8?B?YVFnSlRJYUwvSGNtVkdFN0U2YnFPUVd3NFM0VkRtTndQNUhwclc2UTBEc0ZV?=
 =?utf-8?B?QUNpSzBsYVYwQ3JTQlcyRE16dTU5WUE3a01ocjRKV2FwS0ZiYU9RWWJ1VUhS?=
 =?utf-8?B?K09BeWgzQUdaZWYyUGJCV1JkVzhsMjhwYUJWZ2VuTlVHemZvQ3h5WGJKT2Nv?=
 =?utf-8?B?YklSdlhlR0dQaGhVNXM1Q0gvdDdsdGgvVDdFb0NmRnBKVWJqWjVraFZNQk9X?=
 =?utf-8?B?NXdaOTZsaHpEZk56OTlkbG1mOWJ0UTRqRVVyQXVjTWFNbVJvUjVaTk1QTU96?=
 =?utf-8?B?T1EvN2JUZkd6Vm9GMHUxYXRZcmtGaS9TaC9HcCsvdHBrbHBra2VySCtMbTlL?=
 =?utf-8?B?cDhSdlVQbSswR3dXV1FTQW83WGZzZXljQUxiTGlQc3F0NFFtYXJKN0tuYjdO?=
 =?utf-8?B?RnM3UlY3YmwvalVldFhaQjZCODd5bXJuYjg5NmlqVzNjaGRTd3lKaUUyS1ZT?=
 =?utf-8?B?UlZ3eWhDSGZSYmM0WVZ2SHpZUyt4OUJBNzVYZXYvL2pKQzREODM2bzcvUDVi?=
 =?utf-8?B?ZHNUNEQ4T1V5V2tWUlNDRDVlQnQ5YjFEZHZ5UUxQbnM1MXlhS2lpanlXUVFK?=
 =?utf-8?B?UDNaVkNicWJSUi9DeFltZ0dhK0M2TFZVOTdEWGhpbFFESXJnTHN0N1pmMEdZ?=
 =?utf-8?B?WGk5TzRzaGF1djUxbnN4Ymx6dUZoSzI4akppNzF1K0NJQktsbGhlWlRiY0JN?=
 =?utf-8?B?S1NzMXFoNHlwYmJQUXYydnlicGdWQ2tEMjNrVWQvL0NSNW1rTU5aUTRqL3ZG?=
 =?utf-8?B?Q1B4akZ5YVM0bGo3dklkVEM3NCthakt3RnVGUG9FRFMzbzNoclRjZ01BYjV6?=
 =?utf-8?B?OUQyQWtvRjdjVkVud1FzSktDSW1TUENzeUl0MElNUVp5MGpGV2dwNS9sMkRp?=
 =?utf-8?B?ZStHVVdoUEZ3T2FDRlU0UUYvcGdHWFRwK25idDZYSHp4K1E2S243NlR2Smdl?=
 =?utf-8?B?cDJraGhJNWd5RHEwRThvSy9xMmpFQlpOLzdiNEcyQjZtMy9iY0lTT0hHTGRM?=
 =?utf-8?B?SXplVVhXMm84V25Zd09tOUZ4M1hmM1pFcm9PYXNOSGpOcXgvckdabDhSR1Rw?=
 =?utf-8?B?THQwaUtpa0ZIK2J0L0NKR2RRUk93YXNvR0FBMndUVXozVGxaYjlFNmYzRVg0?=
 =?utf-8?B?ajY3enA4QVh5dEtJd200VzJPTURnZ2tpbHRESDhNdWxEVnJwRFl5ekN3UjRV?=
 =?utf-8?B?b2U3dGZzeFlha1dlZktYWlhpeHROWDNzbHVzeDMyZGcwQ29BU09nUFVXeENQ?=
 =?utf-8?B?SUZsWHpkV0VRMGE3SEtTU0dSTEFLM29GaDFxeDZzQktUU2d0MjBoelMyZlRw?=
 =?utf-8?B?K0kvaDRyM0VPK2o4YTMwczRPcEVRdkR6TzBWNDByb1hoZ1RlUVJYOENwc001?=
 =?utf-8?Q?uFb3nyGcRPlRzT0o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 230ab6c6-1909-4985-7899-08da4411463b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 20:57:01.4937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U5HynhhoV/rQVDy7GmBeOUcnTuoi9bYtqG3sLUcZ1oKXxr510lYe5LF2GyqKe9hQBZGCq0v745tgD2226zSO7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4292
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-01_08:2022-06-01,2022-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206010084
X-Proofpoint-ORIG-GUID: _AJPeza3VlgecoSF0idCPAXPiq90EuPb
X-Proofpoint-GUID: _AJPeza3VlgecoSF0idCPAXPiq90EuPb
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/1/22 12:23, Matthew Wilcox (Oracle) wrote:
> These functions have no more users, so delete them.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  .../admin-guide/cgroup-v1/memcg_test.rst      |  2 +-
>  include/linux/pagemap.h                       | 18 -----------------
>  mm/filemap.c                                  | 20 -------------------
>  mm/shmem.c                                    |  2 +-
>  mm/swap_state.c                               |  2 +-
>  5 files changed, 3 insertions(+), 41 deletions(-)

grep comes up empty,

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
