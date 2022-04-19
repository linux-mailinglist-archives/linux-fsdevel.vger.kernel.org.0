Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7B9506BD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 14:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352154AbiDSMKn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 08:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352086AbiDSMIS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:08:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BBD655B;
        Tue, 19 Apr 2022 05:04:28 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23JBsRJ4019231;
        Tue, 19 Apr 2022 12:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=QL9zAEXce69OmwiuUcwiOZYD9isqw84nxmQFM4fYLsk=;
 b=tYv38/gUZGvY8Q0ZcvGgatPdfoez9sVIV8bC4fBr8Pqf8t4feErmToGS0FLdSqUeRoFZ
 dBiAhV1/gugjQ8Q+GsESK60oyrqa6LpMRyFVZ9foHOnTx+t8V3gl8NfK3XoEdhPv17LF
 NweEH2a3vChBkZiccHaTLeqUvTpY03+bKMQGYaQ12ckgSWPl5pUK5KsWLgwqHSGUiDj2
 0kgG+neCjqWWbVTD18nHFSjJYAxyTXzkUPJntA58YhdwZcEb9ZlZVhpLHXxhY4djjEP6
 NfAyU8bpRJG2F7ix/eGzB+R25mqyYKtPHmV/fkjAj1cJnn9659Z2MswMUQT0Iqj3A/sc qw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmk2nsrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 12:02:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23JC1i8b035322;
        Tue, 19 Apr 2022 12:02:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm81y1rq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 12:02:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQLrh726Iz0npUEBkcLLPHrC0r90OcTtzhkiSTw0ZRoC3P+ZvAQc+056vgrKNhHI00L6HNcAkC3e/sDNmGPvmcJGfYaHfapLG38021TnnYvsR+iDFkkyj6JndvFPGi7hdD6cUenYhbXsJdYl4AvW8yDYLToKNo/o3xVZ7tRCLWcyZzlYF4HWErjqE/JNXJlBmapL2BCAKd2O9g55Y3W/vHOF5T2UyE9LjbdTg2wsdq7g7x5YCfsRhxjucHiJ1ItLiMsQomT7Q4nYOBpiVV5hs/WGh0dk0RajlrP6w6CL/2KrSxTqS8sMB6VyyXZDTyDKiqwrSo9i9HzWs8NGjhiOVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QL9zAEXce69OmwiuUcwiOZYD9isqw84nxmQFM4fYLsk=;
 b=V4yvdLxS4bHsn+VnzBvk17dhwQFMpw8uq9sDZdhQxTzS3weq7/TpTgRtp17CwGyHDPQDj6+7sBfJ2MrTF/BQRWUvNTg/pgtISX8qYwOphQCOUbTtE+BSWzX14NSuO9DiyQB7GujpXQOsEVOmLPGhwRczsGcDTB8rm7fSwvRXuARlf9hHXMsD0oe6b4TLxpm0M8pgyBVoRtLiRT1Y9jLMkraLXCoN3U0S83gegEcmeaqJyMxeUyXwKvZ83oV8yXKUZ9beTtyjP4zwXkKI+7dL2Dz32oHsCP0yyfIrOHI6a5qReoqDH68X29PRP5mEKDFaHKtI/tXfymUDCaxj2TVw4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QL9zAEXce69OmwiuUcwiOZYD9isqw84nxmQFM4fYLsk=;
 b=zxdzb2HTii8g58+L1L83JBE90J7uRfh1GJLoCuEJKgIdo1IdIl/XZ3aGP6rfcaeLftjVwst+5/ykLP4HQV1/EVBpngk/xCYcaMQoN/M+j/NYcPOVH32bkxdneSP2GzaxmQ02HpVRMbyiVw0uKPwpoIGMwDBIo2fixchDtRE2V1Y=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MWHPR1001MB2141.namprd10.prod.outlook.com (2603:10b6:301:35::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Tue, 19 Apr
 2022 12:02:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d414:7654:e1b8:4306]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d414:7654:e1b8:4306%9]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 12:02:41 +0000
Message-ID: <530b0d48-96fc-e157-38f5-a87d85c7d2c6@oracle.com>
Date:   Tue, 19 Apr 2022 20:02:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH 08/27] btrfs: use bdev_max_active_zones instead of open
 coding it
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        nbd@other.debian.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@oss.oracle.com, linux-mm@kvack.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
References: <20220415045258.199825-1-hch@lst.de>
 <20220415045258.199825-9-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220415045258.199825-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0201.apcprd06.prod.outlook.com (2603:1096:4:1::33)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a98a6d3b-c5d2-4693-77c8-08da21fc8146
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2141:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2141CE67EFCF4B26A2BEF1BCE5F29@MWHPR1001MB2141.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hVWl70YvV4YC4v0m6s7HzgZEWKv3Fonhd5nUgli1TOROMgki53u9O+TeX60rWcxhlM7ItoOO6iOYJVLq65CJp5+Fvr7qBn32D69JTN/BGMHpEba4e2A9fivk2EryxnvfwMvkdhiM6mhQnl+AQFPWGt0JtKikaHWa8VbwyFPcN2ynMxOztmw7S9M7XgaF3cUCBqlNNAdjFeZvcZvjbFxhv+FweFoQWYotzQt05e9sYMP9kKzHoZpXQK20WmTQUqgvKvQ/9bx7JHKm+PjaGyfUP+MFsq3pmIB0Vny3qGaVQ6lelm+7SKjlx1+AHfPBfKz6p09RLjiMjzPLOwwk1ha9LDg+wZ7sziwpPmaR9FewzXLrkOgoz/nZ3+qPz94Br7UMOCxXfNf/VTrPE5KvzvJ4/BPghnb8y/vntjlI6FZ3+8h7VPRdwzO84LJYlwOdXSev65/hKiSVRX4t9+OSUlmn9vjXzlkyGpVRyxxvT2AJvc/i+zHoqXkk+OH+tQ5GDR7f9W8cHpTaJ+HwkA8NrnI10raLMQm7z4J6MoqQKO0oJUtODNlAJjgFCZzWaW8pZ5F4J5o7GJtKoFTQSaITzQZ7zef66yeg3Ot2cZr9l1VR9sIUW9++KPe+y6DFGMyGhIVD6Tc9mL7IJNvy8rWwB6QTGk/hS71Uosbcph/eMMgsmcGq/8JJC1uWMH2ZtRDWtiY1TOg22mZZkG3PyFdaxjstMAXutzYUSn0z00AD4GwOzug=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(110136005)(4326008)(36756003)(38100700002)(31686004)(7406005)(26005)(508600001)(66476007)(316002)(66946007)(186003)(6486002)(5660300002)(2616005)(54906003)(8676002)(31696002)(86362001)(7416002)(83380400001)(44832011)(2906002)(8936002)(6506007)(6512007)(6666004)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmhoV3N4Y1dhanlWMG9nc0ZSMUpvTEF3T281cXZhL21mY081RXBtQXpONWpx?=
 =?utf-8?B?NGZhS3ZqRWtnVFVLejM0VlRTQWxTRmJyY0lDQi9VcE14QzBkTHY4dXdHakww?=
 =?utf-8?B?S2JZS2VVOUxzR1B1ZTFvQWxVYzVYNVl3ZE5iNVpyYVMySnQvSnA1aVFnMDBX?=
 =?utf-8?B?bVBTSjBkcS84Zlc4RmFKRUdJcW1xc2pFcGY3dE53VEJnTkpJQXdkNW50N1B5?=
 =?utf-8?B?bTB5ZUJ2M3dYZm5XTXYwMndKVkhjWGw4R1IzQWNmZk9iTHJWOWFrVGoreGVY?=
 =?utf-8?B?WUNLOHh3NW85VlpaaHdzbFdyd3U4azkzU080bFd6Ni8wM0preGRmNzIySjJD?=
 =?utf-8?B?LzBrUXZOTnNZdVR3ak1zcGVnYzMvQ1BWK3VZWkFyT0dsTmYrQUVMd3pTb2E5?=
 =?utf-8?B?S3lKRk9VRTJIY1ZBN0Z6WFM5NFYvSEJ2R2pTcTBaQ0ZPVkg5dVQwanlCZEJF?=
 =?utf-8?B?UW5wU0NIK2t0bXRRNUhyUmpUMUlmMUVmb0gvNXIxVjNUZi9NZnNBZ1pheEJL?=
 =?utf-8?B?a2wxU2VPYXFyeHN3MUdsRjRvY1VDK2FhNVdqLzE0cmt2NFNHQ1V2aE4xMjVD?=
 =?utf-8?B?Qmw1YUZrWnloWWx1TmlzKzZ4SUdRSXV3dnA5amxaRFU1NVoySEJaQXB3Y2dC?=
 =?utf-8?B?cVJJUWJRRWhQYzBscHIyRXpCUCs0WnA3YTJLczNqSU5DME5qbThnZVRRamlx?=
 =?utf-8?B?U1N6QUROUmt4UCtCNUx1TEplSHlLaVRyNmN0cnlGUjlLdkgrU3Qwc3UxMWZv?=
 =?utf-8?B?TWxPdEFxdXROMFAxajBhTjZGVkhjYXVyTm5qVjZBajRaYXB3bFNYSzdxR3J5?=
 =?utf-8?B?aTJJcU1QQUp4YUMyb0JKa1hrcEZyTGhVdmlHZEhncC9UR3c2SlowRGJSTEZY?=
 =?utf-8?B?ZDZLREVrMjViU1c5VExpYkdPQVhBNkR4RkV0WkQ2M2hyZXB6Kzk2dTdaT1NJ?=
 =?utf-8?B?VlBIQUw2WjF5WmhNbjc3OHNHVG9qaGZhS25RUXpodGIwcmNlQ1FrR0FSWjJB?=
 =?utf-8?B?ZjFLSFNKTGpzYjVITlZLdEQ5WjI5VXpzVFhKay8rRlduZlVaQllCNDJZamlN?=
 =?utf-8?B?eEVGOUYwMWhjaGV2TjBZbTAvTVFRdTNnUTd3Qksva2RRRzRQTkh3K2RLdGJC?=
 =?utf-8?B?QjFiRWJCb0p0SmhORWdJRWxYYld3b09jRTFlOExJK0VZQ2E3VlJvQWIreW5a?=
 =?utf-8?B?NXR2V1hYcTMwMHBBODdZOFE4MXFMQmVEamNYOEwwaVAzQ292UGpyYWlOSmQ4?=
 =?utf-8?B?SFpJN2ZFeEZ1ZGVJT3U3dVUzdEdFS3dlU3plSTdleGF5QzVxck02cHlxWm8w?=
 =?utf-8?B?NG1ZYWpxUXVxL3hOUll1TnpWUGQ2ZlFHRmlRS0oxWTgxdlNUMzM5WGJSTHZq?=
 =?utf-8?B?dWh3bTR4T29lbExVZVpEcWRabWlhRHlXMVpIV1JUVVRZWVdzRWEwSWEvQ3V4?=
 =?utf-8?B?RERHNWN3UWloMG9CaGlCZEg3TDg4ZU8wR3FOQ1JlazJLQWpQL0NkYnpNSS9Z?=
 =?utf-8?B?Y0FZUEw0dGZ1MXJpTGE1VHFuRXBjaG1qSldTTG9ybDVMUi9ycVp2MU5XbUs1?=
 =?utf-8?B?c3lhRTRXSzBvU2k2SDVDZEFmbUxJRVUyUEZaTFc5MCtwenB5c3ZDanJET3hl?=
 =?utf-8?B?ZVVrVUFHUjRRd0RGZlRqMjRVMktDWGlVZ0VneHA3T3NoUUI0YkU3QlRnUDhi?=
 =?utf-8?B?UlJIdjh1Slg1Z0RobkVtQ3RXeHJ2SGVNTGkvSFdtdjJ0aDVYMFlHeXVZdmdX?=
 =?utf-8?B?QlJaem4zUlpQQnA0SnZIakIrZGo5YkxpN3dvUGRCakJVNVpiYjZPNThrS25m?=
 =?utf-8?B?VGRWR0ptWERrdzl3UlE5eTA1WTR1QlNzdnY5dmpEcm0vZHR4UlByMlg3bnhw?=
 =?utf-8?B?WlpRMEhQVzF3cUtpZkd6SXJuVC9iemhPT3FJOER5OCszUzFCM1U2MVBsdlRW?=
 =?utf-8?B?TkpYNEdoemZVMHdIb1ZsaVl6YnptNUxEVU5ZR2dSZ21tYTMvTzM2YWxvKzAx?=
 =?utf-8?B?ZnRidnhla2ZTZ1BCcEhyT0pnb2o0VTUzck5hZ3U4ZnBmQVVqOHV5Z0ozREVM?=
 =?utf-8?B?bGVkNEwvQWY3NG94azVNdWtjQmkyQUNNMlZCVWtqb3hnL1BzejdzaEE0bHow?=
 =?utf-8?B?TG5HRnJ0Rys1c3VYenpDVFNROEVNd3Q1c0dCSk1rNzQrR2pSc1kzWXgwWE50?=
 =?utf-8?B?SjhROThCV1VQdTVlNUxGd3htaG91Q3JReThaVWYvV0RYZUVxZXRCMFNFcUxs?=
 =?utf-8?B?MVBVUnpxUjMxZUxETnJrblNOdTBIYU5lNTVQN2NqbmRoNWhFK2d5TDdUaWhI?=
 =?utf-8?B?dm5MUjNQUnc1QlJvdVQxM2kwdEY1RWoyd2VuVGM1SmRjcjFIVXFPQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98a6d3b-c5d2-4693-77c8-08da21fc8146
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 12:02:41.3368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRd3SV4vTdL/imdzW81rXDlLgVZQ5jI4QZcN7QsQKr+Cc4vkDsCT7Q0McNeiM4a/YB2BICphkrENA/rtDs3e8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2141
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-19_05:2022-04-15,2022-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204190068
X-Proofpoint-GUID: eIAsdRiq0QDKLhGFS0Ei-awijsDU5A4I
X-Proofpoint-ORIG-GUID: eIAsdRiq0QDKLhGFS0Ei-awijsDU5A4I
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/15/22 12:52, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Acked-by: David Sterba <dsterba@suse.com>

LGTM.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


> ---
>   fs/btrfs/zoned.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 1b1b310c3c510..f72cad7391a11 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -350,7 +350,6 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
>   	struct btrfs_fs_info *fs_info = device->fs_info;
>   	struct btrfs_zoned_device_info *zone_info = NULL;
>   	struct block_device *bdev = device->bdev;
> -	struct request_queue *queue = bdev_get_queue(bdev);
>   	unsigned int max_active_zones;
>   	unsigned int nactive;
>   	sector_t nr_sectors;
> @@ -410,7 +409,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
>   	if (!IS_ALIGNED(nr_sectors, zone_sectors))
>   		zone_info->nr_zones++;
>   
> -	max_active_zones = queue_max_active_zones(queue);
> +	max_active_zones = bdev_max_active_zones(bdev);
>   	if (max_active_zones && max_active_zones < BTRFS_MIN_ACTIVE_ZONES) {
>   		btrfs_err_in_rcu(fs_info,
>   "zoned: %s: max active zones %u is too small, need at least %u active zones",

