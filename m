Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CF536CFB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 01:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239491AbhD0XtT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 19:49:19 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46356 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbhD0XtS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 19:49:18 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13RNjIUF001337;
        Tue, 27 Apr 2021 23:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Cfv2Gm16MRXDLfsUgdxhFcjPhipLFgMqpH0G+PZP59s=;
 b=GUx4N0ktSIdcFZRteRaxOlL6f7nVl66lR7CuGcW40hrzW1+9ti3yJaGz9MQT3JIfB5pv
 9SM3as+HTuGK0FaePpeQzq03itdvrSSmkfPo31RudTp1HToC0NLPg6TMfkHlAj9nsyN/
 88a3o3dpDPX0XMTvB8gvTcH6evljiwdJFVJJ8fqKAhr2v9O3NhRgtTFS+WZS27vh8iOS
 iyeECyMOzTAYrKz9dxaAQLiZyEl+wUzO8fgqLVbrair7GQfHx7WqgQ9Ot3pN6q+1lL8Z
 MzV14js+kvtHNjr+pOP7Zgc9PdHS2Nrmiy5QI/YyxuU6j6KTN5GAJTtDdbqmIyAJEh00 nw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 385afpy6v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Apr 2021 23:47:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13RNjmAY135986;
        Tue, 27 Apr 2021 23:47:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by aserp3020.oracle.com with ESMTP id 384b57fbx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Apr 2021 23:47:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDISZCPn5BBkxCJ9YKj1BA7NPdEe4ukP7zj6mBvXXPoyyfSH0Ve5ichoHQ1en7u0uyHxINN3U3XRJ9geL3/Ge9fKA+4SggOOrBeazkm46HGHzeZQsgMkqNC1DZpJKi4NoB2qE2dlRQzFAG09T2iJfO5DVcGDEqaeK5YNtlUE6ijguARgTIsWErTrKQYm0vfJ+JHAeqeS7Uy8nE6/YlrykgkAMrQX3eR5L8zET7hptE3zl1079R6taeEF+a7nY/PZJAD9Xg/WjoKRERDFVw+sAB6F+0y4DRFZ1+7B9Pueu9bNdG+xbns8vk6f8KIgGhr8f2fnsaAdg5ByUk5Gix/L7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cfv2Gm16MRXDLfsUgdxhFcjPhipLFgMqpH0G+PZP59s=;
 b=gLkTdCyjLRPcCEN3SDFc0PPh2Iqgq3WIxpNjZ4D05ySdSU+pl3RQqb4AVTmq6/kCMsUXI9wxjOgOMRtvkNmZ8djfsnMid2Rze+CbY+bQuAvmhd6bWXePkKQipMH8+iE3qmiGd/hINXS+qTLYhk48j6bXDPh2gronnFyN6zZIoSjWO22sDfucAP2s/NQ4P1xs0H46gm0UgFmgSU0FvHEGV5w4/YgMay02ctGrFu86oc6F2muz4QD5bJyMu1sk9WzOMSUlGgpwpmsOnEx9GVgk+ejrOtjomw6WckKePRava+axzyJv/fOPYlC7Yi/YJS/S7c26QyVUMiLRMVEoKeFoJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cfv2Gm16MRXDLfsUgdxhFcjPhipLFgMqpH0G+PZP59s=;
 b=KWEzSfNEV3J1CpxZG7NN0dtq8KP/2S3Q0b/arfgjSCksv9xJCmj6OHUEK3GOE/qW0Y88A4DUNL6u5RfFQlIN2gCIUqRhOdzGprItEfpGddV6ao+1eN3RAPj54jMB9IVc5VA3T7QlElAqWLcFLVBV+gKFzVd8MSH3HpJKIHQyi90=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5422.namprd10.prod.outlook.com (2603:10b6:a03:3ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Tue, 27 Apr
 2021 23:47:17 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 23:47:17 +0000
Subject: Re: [PATCH v21 0/9] Free some vmemmap pages of HugeTLB page
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, naoya.horiguchi@nec.com,
        joao.m.martins@oracle.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        zhengqi.arch@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20210425070752.17783-1-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <ee3903ae-7033-7608-c7ed-1f16f0359663@oracle.com>
Date:   Tue, 27 Apr 2021 16:47:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210425070752.17783-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR22CA0071.namprd22.prod.outlook.com
 (2603:10b6:300:12a::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR22CA0071.namprd22.prod.outlook.com (2603:10b6:300:12a::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22 via Frontend Transport; Tue, 27 Apr 2021 23:47:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7926952-f8e9-4b78-0e38-08d909d6ca13
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5422:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB54228616EBFA6F4DEB1B40F8E2419@SJ0PR10MB5422.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O6LGWVIlXwc1f+BaATv82Elmg5ot5ju6O25McdNFNzxvx1eELHaFdYXsFaYv9K6VCSaveBBEyghr6NKNICfj1/G4njvZoz3iSDilVt4v9uct+VrtT3WI4F5l9mo6uf9kMj3GKDPAjtATIQBkXp+SJ+vbvJfFin3onlnYL+Vo7LCHclFbRTDSOp0Aa7Z4r5iyDNRwz53/SvBk05Qs8OsPuMGH4jQm+5gNVOjWoUf2G/AljVRHR5JHRjZZL0kHInFAdTTiBK//00TxIvJM+tdkeRS9TS/A9HDDuzxDec074zQiIXJMmqtB9bLKqWCSr4pIE3SbgQwAgPK0JcVxbRnpwSi8K/KBbFSGMDoes00hX1yh/lf/YPN5DXDINm1aEKIZXtCao18ZAP94as6UG7C3Z92zdOq7qPmplDMZ+bAbx+ydgXR+44u+JLundwNlifCqjgDXYXeM1e/4wJOgCNbNtiD37CtwwQCZ9wrvRkQ3YSZfP4VytybeFJrPtiFJsWRsNzLYVqWMN5YawW679aMt6xIwXLOqLv89AI/kTMMoPfeQlF5++uB7DjPiT0jZAc8AFVdMDODL3yc65LSVF3qGnCF69Ey8wIxOUN/RS922MaWU8b43ALLau6VIjLwikBDISjNvf+nKWUS3KnoFe6UpJ1FEAt1tFFuKM8Z7re4PWIP4RAIELtXMgP9946RBmhIOuOx9EllYwKuCjG6RuYtLSV7lyPYI5swmXiIqGYgr9Hc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(366004)(346002)(396003)(136003)(6486002)(478600001)(86362001)(4326008)(26005)(31696002)(38100700002)(16576012)(316002)(186003)(921005)(16526019)(6666004)(6636002)(38350700002)(7406005)(66946007)(2906002)(66556008)(7416002)(36756003)(66476007)(45080400002)(83380400001)(5660300002)(52116002)(31686004)(8936002)(8676002)(956004)(44832011)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Yzh3eE95bDBucU5LVGFWSTBxT1VvampDanFBejVJMXVyZXhiSFR6VXNFdXZz?=
 =?utf-8?B?SWZZTURCczFTK1ZLYVBxdUtlbmp2NnVGazRPTk0vd0lndGRwWEZSdElUK1Fo?=
 =?utf-8?B?Q21ET0lsSm83T0lRQ0NyUWRMMjNFNTNHWnMxb0RSb29rY2RGelc0VVpjdFA5?=
 =?utf-8?B?QzVrdWFKZE5lMEdNUWRPVzVVUFpvU3ROL3RLandsdmVubVVFQUprOHpYdVkr?=
 =?utf-8?B?RDB3SGxRbkRhNWhVbmJyb09zN09kNUJpaFUvbjNmNjBWQ0RZZVZRMXRyRVVJ?=
 =?utf-8?B?c001bmdIaWYyMytzK1E3dnZTL3p2NWVWQno0dEZaQnUyeWN6ZlBmaU8vbTFK?=
 =?utf-8?B?Y0hXNzFuY2hrZmFmQ292Wm9Lck1PRXZGOFVoOVZLSVJHVitidGFhN2VzbWFK?=
 =?utf-8?B?VmF6NFFhMFAyOXZJRnlHOGRHOEhpUjV6cHZtQzQrMUJ3UmlhRnNaTEwvT01X?=
 =?utf-8?B?NjhDdnBWcExYbXJnZ0JFTHBBRk5TLzBDVlZxU3NvN3h5TElmMkpuNDhoazNT?=
 =?utf-8?B?UGd5ZzVTNWcwSmNraXZQbm1BYUZxVDdST0FiZDIvVzdUWDRsZ0xHeURBOUlx?=
 =?utf-8?B?TWFYWkR1OFpJVmVMV2tsSS9vNjFaQW9PeWI1VTVhdHIzdXFKNHdkMHA0NS8w?=
 =?utf-8?B?emhqVC9ZRUp2NGhGaWhoRmpJa2pDdnBTTXBQM0lPeWJkZW1QV3BCTHArWWNn?=
 =?utf-8?B?YUJadXRhOUNGaE50Yk03MTJsalJwT3F4RmNsZGQ5WjFQK0g1NllxMUpkakNM?=
 =?utf-8?B?RWRDM1N3UUE0c3Bqcmc1Z3ZyS1lwRUpFd043MXZjVmlmNkZoNldhLzhOMEgx?=
 =?utf-8?B?bFczaEpaZEdVb0tiaXo0T0Z0T200M1FzSkZ1RkIrSWZzYW5vVmxHTHFYQmRV?=
 =?utf-8?B?ckJpUGdTMVd2REd6YkNFN0ZUdVNHc2g1bXcrZmVmWGtxQkN6YnE5YjA3V2JW?=
 =?utf-8?B?Yk4zc2lkMThJWWRPZC95QjE5MEJLYWlIZUNDNGw0dWdhNFM5ckh5UTRQZHZF?=
 =?utf-8?B?QU43VzMyOGVsRW9RU2dtUkV3eUlKcU9laXNKaGIzaWwzeVVKSkZ3UmFSREx6?=
 =?utf-8?B?NFBibDlrc0FhVzJNOGh4b2crQnZpeTAxMU9rRmRpTmVWYlkwK0cra2hKbWVQ?=
 =?utf-8?B?REZtZTVjcC96VDZ6SGdxMExaZGhPNWNGVE5Zbk5kOEZsUnF4QkNoeFZYUHB4?=
 =?utf-8?B?Mms2YzFOekxOTHBsc3JvbVBUQXlibHp1N2FrZ0ZqN0lpS2hQdlNxY3JSQmww?=
 =?utf-8?B?NTR4TmllV0E3aTl5UlFESWZ1Qm9tdjhKakdidGR5RzVwSEpWOUhyWlF3YTRa?=
 =?utf-8?B?cFNwQ0l0aC9KUHh5Wjg0czBvTjN5QlBtS3hybDF3UFlaM3BMNUw3MjVmOFRJ?=
 =?utf-8?B?YUhOY2JJeHNjVWw0ZGpoWVFONkFVcmovUWt2MXNmR1NsbWxBODRWU1o1MGJV?=
 =?utf-8?B?L25ST1JtYXpUdWdRVmU0ZHBhK2hwMUJoNWx5RWxnL3FsbklKaG1udE9QLzMw?=
 =?utf-8?B?NG1YdTNUQ3dTdE5oSVFQc0ZuM3ZHb1hBbGYrN0p3cXlyYXhZbHVjVEEzRHA0?=
 =?utf-8?B?ODJiTHJBTTlieDRuRXloSmYwVEY3Nno5UXZuZHd0dEJPcURrd2ozNHJ6Ly9y?=
 =?utf-8?B?bzhYVnV1RVlRSHhzamxwVGwrYkNaSWY3TlBxbXdGQ3RKcFdYM1h5VW8vZGJ0?=
 =?utf-8?B?SC9jeEhVSHR6azRVdHFWVkU4UVZDSzRDdkNOT1FDUC8vTTRud2RDT214NXBq?=
 =?utf-8?Q?RP2BesoYupqFwW1KHOqDUZHvvIqILzDupSYprtA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7926952-f8e9-4b78-0e38-08d909d6ca13
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 23:47:17.0938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwpXr9EY9eeubFPT6SjbW2mBzc7YwpCx9UQX+OwM/SkJXPl4fsLtPU1S94c+fKV+FO3p6OACx3QlMsJLthM3oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5422
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9967 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104270162
X-Proofpoint-ORIG-GUID: ySHQSe4EXu7s_wbsXc8FdcoiTyjhka35
X-Proofpoint-GUID: ySHQSe4EXu7s_wbsXc8FdcoiTyjhka35
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9967 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1011 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104270162
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks!  I will take a look at the modifications soon.

I applied the patches to Andrew's mmotm-2021-04-21-23-03, ran some tests and
got the following warning.  We may need to special case that call to
__prep_new_huge_page/free_huge_page_vmemmap from alloc_and_dissolve_huge_page
as it is holding hugetlb lock with IRQs disabled.

Sorry I missed that previously.
-- 
Mike Kravetz

[ 1521.579890] ------------[ cut here ]------------
[ 1521.581309] WARNING: CPU: 1 PID: 1046 at kernel/smp.c:884 smp_call_function_many_cond+0x1bb/0x390
[ 1521.583895] Modules linked in: ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack ebtable_nat ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat iptable_mangle iptable_raw iptable_security nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ebtable_filter ebtables 9p ip6table_filter ip6_tables sunrpc snd_hda_codec_generic snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hwdep snd_hda_core snd_seq joydev crct10dif_pclmul snd_seq_device crc32_pclmul snd_pcm ghash_clmulni_intel snd_timer 9pnet_virtio snd 9pnet virtio_balloon soundcore i2c_piix4 virtio_net virtio_console net_failover virtio_blk failover 8139too qxl drm_ttm_helper ttm drm_kms_helper drm crc32c_intel serio_raw virtio_pci virtio_pci_modern_dev 8139cp virtio_ring mii ata_generic virtio pata_acpi
[ 1521.598644] CPU: 1 PID: 1046 Comm: bash Not tainted 5.12.0-rc8-mm1+ #2
[ 1521.599787] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1.fc33 04/01/2014
[ 1521.601259] RIP: 0010:smp_call_function_many_cond+0x1bb/0x390
[ 1521.602232] Code: 87 75 71 01 85 d2 0f 84 c8 fe ff ff 65 8b 05 94 3d e9 7e 85 c0 0f 85 b9 fe ff ff 65 8b 05 f9 3a e8 7e 85 c0 0f 85 aa fe ff ff <0f> 0b e9 a3 fe ff ff 65 8b 05 47 33 e8 7e a9 ff ff ff 7f 0f 85 75
[ 1521.605167] RSP: 0018:ffffc90001fcb928 EFLAGS: 00010046
[ 1521.606049] RAX: 0000000000000000 RBX: ffffffff828a85d0 RCX: 0000000000000001
[ 1521.607103] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000001
[ 1521.608127] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffea0008fa6f88
[ 1521.609144] R10: 0000000000000001 R11: 0000000000000001 R12: ffff888237d3bfc0
[ 1521.610112] R13: dead000000000122 R14: dead000000000100 R15: ffffea0007bb8000
[ 1521.611106] FS:  00007f8a11223740(0000) GS:ffff888237d00000(0000) knlGS:0000000000000000
[ 1521.612231] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1521.612952] CR2: 0000555e1d00a430 CR3: 000000019ef5a005 CR4: 0000000000370ee0
[ 1521.614295] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1521.615539] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1521.616814] Call Trace:
[ 1521.617241]  ? flush_tlb_one_kernel+0x20/0x20
[ 1521.618041]  on_each_cpu_cond_mask+0x25/0x30
[ 1521.618797]  flush_tlb_kernel_range+0xa5/0xc0
[ 1521.619577]  vmemmap_remap_free+0x7d/0x150
[ 1521.620319]  ? sparse_remove_section+0x80/0x80
[ 1521.621120]  free_huge_page_vmemmap+0x2f/0x40
[ 1521.621898]  __prep_new_huge_page+0xe/0xd0
[ 1521.622633]  isolate_or_dissolve_huge_page+0x300/0x360
[ 1521.623559]  isolate_migratepages_block+0x4c4/0xe20
[ 1521.624430]  ? verify_cpu+0x100/0x100
[ 1521.625096]  isolate_migratepages_range+0x6b/0xc0
[ 1521.625936]  alloc_contig_range+0x220/0x3d0
[ 1521.626729]  cma_alloc+0x1ae/0x5f0
[ 1521.627333]  alloc_fresh_huge_page+0x67/0x190
[ 1521.628054]  alloc_pool_huge_page+0x72/0xf0
[ 1521.628769]  set_max_huge_pages+0x128/0x2c0
[ 1521.629540]  __nr_hugepages_store_common+0x3d/0xb0
[ 1521.630457]  ? _kstrtoull+0x35/0xd0
[ 1521.631182]  nr_hugepages_store+0x73/0x80
[ 1521.631903]  kernfs_fop_write_iter+0x127/0x1c0
[ 1521.632698]  new_sync_write+0x11f/0x1b0
[ 1521.633408]  vfs_write+0x26f/0x380
[ 1521.633946]  ksys_write+0x68/0xe0
[ 1521.634444]  do_syscall_64+0x40/0x80
[ 1521.634914]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1521.635669] RIP: 0033:0x7f8a11313ff8
[ 1521.636251] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 8d 05 25 77 0d 00 8b 00 85 c0 75 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89 d4 55
[ 1521.639758] RSP: 002b:00007ffd26f79b18 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[ 1521.641118] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f8a11313ff8
[ 1521.642425] RDX: 0000000000000002 RSI: 0000555e1cf94960 RDI: 0000000000000001
[ 1521.643644] RBP: 0000555e1cf94960 R08: 000000000000000a R09: 00007f8a113a5e80
[ 1521.644904] R10: 000000000000000a R11: 0000000000000246 R12: 00007f8a113e7780
[ 1521.646177] R13: 0000000000000002 R14: 00007f8a113e2740 R15: 0000000000000002
[ 1521.647450] irq event stamp: 10006640
[ 1521.648103] hardirqs last  enabled at (10006639): [<ffffffff812ad02b>] bad_range+0x15b/0x180
[ 1521.649577] hardirqs last disabled at (10006640): [<ffffffff81abcea1>] _raw_spin_lock_irq+0x51/0x60
[ 1521.651194] softirqs last  enabled at (10006630): [<ffffffff810da5e2>] __irq_exit_rcu+0xd2/0x100
[ 1521.652763] softirqs last disabled at (10006625): [<ffffffff810da5e2>] __irq_exit_rcu+0xd2/0x100
[ 1521.654251] ---[ end trace 561fa19f90280f2f ]---
