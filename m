Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB4753646F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 17:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353518AbiE0O70 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 10:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353491AbiE0O7Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 10:59:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B7256FBD
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 07:59:21 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24RDqvDL001695;
        Fri, 27 May 2022 14:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3yYqa4xinfgy4x/BLimYqjAlSXDA1XWMeiFHHo2lIIo=;
 b=mvlK55xApDdRVLU8IhRSkllSmjD9ve3dx78nP8ZR4DwFI5+Ov5dz2983wIRC+V8/REEn
 4mDkhH8ixk6Re6C5PSIGYnDmL8bocxP4P3CDsy+pWUfuEX5DCTJrLq72LopU/T8JAKKu
 +VsneyCMKOr9JblNb32cxs03Gow+THNrcDv1lFTaqbobONJ/4FJxydEnJAg1W9j3X6wZ
 loPgcU1J2yQXMCms2i4d1UsQ+mvXGqKIe6MUXdLgUfRFTnMjvHYYQz1Tr0gZFVwssnsz
 ThepMNhm+q/ajZMjnRC0RXPn0qV2KgLGcHuzJOkzM1u17/Zz2m91u08lp9cLcFSdeduq Xg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93t9yhsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 14:58:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24REo3i6033699;
        Fri, 27 May 2022 14:58:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g93x1t9sj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 14:58:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRkmwTfTgplZgBUa7CzneoQwEVjd9rbwyvOIYi+x/G0/OsP72sRzAR4gn166aWOZ75UWhYfgbeo37rfMHLj/de08BbAes33Ff7IXwO2KTec7ouXgMPCdACwf0sq3xGv62tZY5WqejuRTO3iudzoZgcmU5YDkynQ+rDZGfZ9l0PXYuPsOeQLxF3Y5K8RCcEgUnI9PIZLVLuwsXioUCkn2sJPKujOoA0BlyvChTyO0kDp7YfngRTdP/UGdoJJpmSTk3TBx3PL2dlrZznblPZVmkSmWgGgqrrTYfygWZHyrl+1N56TYACGhw5lkmUOpNPE148zc+vh8emNKNtOWIxRLbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yYqa4xinfgy4x/BLimYqjAlSXDA1XWMeiFHHo2lIIo=;
 b=KLMI17f8En3fkCEnd+EEjze/PJ5AD3ma1lk5VBgzdVYsnO71nE92j+Fz55CIax2nfYeWEN40qw9LWzoIxUGiP9wBrZN9/WIhQwzRXPfYjKLoz56RbU4207Uir9ecMCpZ7M1cfZltgzHVbId7NvxfiaUNw2Eq393NiBg04KORMGDzUjUXJcLLu+Em32Z5HQWMNzFkZEzQ/RhVwETOZTQSjDCwppmkXu1FTAJQyAhLL7gAe0DbevgdyJ/VBcjbmSiNdZcvI67xAYVLPnGIzwSqLrR52O/u6+9wRQdd/oAjYLOjmtJxHbGdmREXEJe8j0k+geXnziw8WSIst82nxgFePg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yYqa4xinfgy4x/BLimYqjAlSXDA1XWMeiFHHo2lIIo=;
 b=pnXdtZTrR5lhqeYnWU0VkOTL+4tVr5c8viguMZUQlM5BbWKK7cRCfbBnAfLuMuuYbTOOorHv5lnCTtz0MsUyvcgu9AwebI4lAYM2tlUxkfHBQdyxRPLN4e3sDXCMrO/Yhl8Fac02w1z/nEVwd6IqmwYiWPDrGog+kKpV7xhNZzM=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by BN8PR10MB3395.namprd10.prod.outlook.com (2603:10b6:408:c1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 14:58:52 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::e5db:f76e:1c67:6af3]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::e5db:f76e:1c67:6af3%4]) with mapi id 15.20.5273.022; Fri, 27 May 2022
 14:58:52 +0000
Message-ID: <8c525b4e-6745-a0c7-a251-ba69d196ea88@oracle.com>
Date:   Fri, 27 May 2022 09:58:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [Jfs-discussion] [RFC PATCH 2/9] jfs: Add jfs_iomap_begin()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        jfs-discussion@lists.sourceforge.net
References: <20220526192910.357055-1-willy@infradead.org>
 <20220526192910.357055-3-willy@infradead.org>
 <YpBkiy4zvIcEXihd@infradead.org> <YpDV6NPBefdYRywi@casper.infradead.org>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <YpDV6NPBefdYRywi@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0123.namprd05.prod.outlook.com
 (2603:10b6:803:42::40) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17f55a65-96ed-4db1-0e62-08da3ff169b8
X-MS-TrafficTypeDiagnostic: BN8PR10MB3395:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB339509F4249D3F145C8A0BE987D89@BN8PR10MB3395.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KOBrfAcKUJOoifdpqVF/snkjDAk16x5cAk1Q6aG7JBf2IMQ7Ttct28LgW9vosGAvFwHvbuooaPcYXZouvc81Y4hdAZd8k6ysJEyiHOO3yOd5h7HDcnQcny2h8TOnsJT7+3aiyweXQnBSOzh1dv+GO7uLkBGzP+DX3815LTZmSg2/hOTHBSOCRwIItPWinYL92uQmD4xthQYqfH9M48JU7K862l94WYcNJ1XlTd1vSNn3SDNUgyIdEk7uyZ4Zr7gCEQRVNGwVjBmaGE8FdCPMeKhYUmLRW4eFKXFtP5sc2zWU5yef7qJFuxZRu9gzK+B5Phl++d7iHZYilnZ4fsFR91kDr4sEx8uPko287eqlg8AX5yWw8EBik3PFpcd2xspRbmwcNecHz7W1fxa+zw2DZZbcw0FJ2+fVoBUpXQWoMQdJ9rM/ynFBZ/zHJTH67tQmxToL0ixreqAyJ9No5AnbsKQipw1pXXAXKMuQ6DC7j4U+KszaJPvPIS/JouxBV9JtbqrP7m8eIOSue6ecsZ1/uEir9QOBjS5DuH7XfZC2/fQ9E7LI2Gx4NAZBGhtx/epBUv8aLOHNgazPe8V0F/bcFSQrKF5IWOwVD6FGgiUaNgxT6ospj5MsSlYb4ROlDjkL7bejcV4fcbddQezMkB02YTTbratXQs5CpxYJ3W67DfnecQP9N2oVrStEduPSnaJJlKWzfzQfG/Ioz0El+QmdrDmzqhmOv2KHKgbSMYYvJnw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(26005)(6512007)(6506007)(110136005)(6486002)(6666004)(508600001)(44832011)(8936002)(38100700002)(4326008)(66556008)(66946007)(66476007)(2906002)(8676002)(316002)(83380400001)(5660300002)(36756003)(31686004)(86362001)(31696002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGhKR2MzdTJMa3BZbG9pMlVjc3NibVJmK21GZWVhRlo1dnVnQitrZEt2Ukwv?=
 =?utf-8?B?c0hCYkhpY0hpSXJkVGNpUTAyb0MwQTE1eE8xWE93UXRVWGNSUzdmdWg2Qk1t?=
 =?utf-8?B?c3dQc0NZcFl0Y3pUdGh5Z2RpNDBpYThBRml1YlNJWm5WZWovd0JXN0dYRmkx?=
 =?utf-8?B?MDd6UWJOc1NKRGQzc0FTR2R5QklrSjlqZzVpMEFVbkM2eWpaYzVlaEJwWmlU?=
 =?utf-8?B?WHJRa0pEQjNwYVhXcVFjanZIOTVSeVp3d2ZqNXhtdytsYUtBY3IxVnJtNDc4?=
 =?utf-8?B?T1p2Q3Nua2VLdmJMUU1jU0JsaW9jdzZWSW56SUtyVWx1c21qV3g4T1JZY3hr?=
 =?utf-8?B?TlhPcEdtbGNtT2ZlNVVmeDVWTFg0Z3RSWWdidVdpYkVlRHI0MXhHaWVweVVq?=
 =?utf-8?B?ZG9Cc3B6djEvSDBnZmIyQmdGUEJzanZzY0ZrZDFWN29DVnBGa1puUVlkazZp?=
 =?utf-8?B?OFI3RlBLQkhiUnNvR0JBTDFKeGRzSzZvMis2dWtoejNTeWFyQXk5aWFRb3hK?=
 =?utf-8?B?N3ltZjZ6aE54ZVhyTjY2d0l0YURZdjA4eUMwQUFxb0lRd2JES25INC9qQlM2?=
 =?utf-8?B?MldLUE5kOVZoL2NRTiszbjJyWXpJQW5OREhzMHpyQzRoaGo0enc1UUR0djU2?=
 =?utf-8?B?VTEwcklaZVFKUTBtMzQ5QTgvcEJ6WEZaZ1NQK2JSRW4yMDFUWk1kVTJkQzdS?=
 =?utf-8?B?YTg2bHdqczdFVlk2bnk0a0s4ejFUQjQ2dGEvcCtxd01OdHpsV2RJTHBsTlBo?=
 =?utf-8?B?TjhIeW53VitjYXJ5VkhoNGJvOUtMS3g1cERlYXR5K3dNb1lGY3pOZ3BYMkl6?=
 =?utf-8?B?Z24wUVJhK2ZRMVpSU3NlMjFCV2ZrZURYS1c2blAwRXM3WURuNHJDOTFGUnRC?=
 =?utf-8?B?ZUZrRHpTYVNPS3BsS2FjWGdVSFV6TXRXdWhqTlBGeW9Mb2MyY2V1MkZYd0pK?=
 =?utf-8?B?dDRaTWtDY1VscGJuQzRmZjQvb2FHalp5cW1jZ2I2OU16aCtObzBKOGFoaDAx?=
 =?utf-8?B?ekIwZzFSS1p5NWwvMC9Yc1hkTkU0NkNjVndqSEpQcEN6amhKN082cjZpYnBF?=
 =?utf-8?B?clZqNVZzVnpZVmpqd2paTVZZNGpOSkZHNVpMOXdhcGFrRUcrUEZqaHA2eVV3?=
 =?utf-8?B?SmtNMldoOFZYSnBzMm9sNWpnL3hjUTVRVXBpMEgzVTByZ3hNRTB2cStraFYz?=
 =?utf-8?B?RzVFb1dmVS9waFE1ekRiUGx4dGtiRlMwMk4wSW1hQ0JXUDF4OEUweGpPTjNV?=
 =?utf-8?B?YU13Y2NYbmFQRUdWcmE0bDg0M2xhSFFKYmlweXEwZkkvQ0xnSVFnZ01XdnJW?=
 =?utf-8?B?WHQ0WlpsZ3JNSG5uTmhBejc2ekxSbnI0Q1B3VWU5M0Z1OFJmS2JPV0h1ZXp6?=
 =?utf-8?B?RWJBT3BKZVBUZkdtcXJnSXR5MkdEdzhmSEpvNGZGczN5UGZ4QXFRNTJmWlcw?=
 =?utf-8?B?Y2ZTZE96QXNBUjluR0MrZjZKYjB3RDN4eXp1Z1NxVGNiSmMrOXdsRmU5VUo2?=
 =?utf-8?B?Z2RrZ0x2dDFDNDFTdGpwVkErbG4yV2xRWldhMFNNc0dSa2FNRmhPdlU3NUE0?=
 =?utf-8?B?dHo3a0UweGl5ZnByektuWFREVDVtQzlVbzdLckY1NzFUeFJjaWY2c0VUUEtq?=
 =?utf-8?B?TFIvcmVFRGJPOGJiU0cvRkVNQUUrbGttTUM4dDl6ckxNM1h6Z2R1Q1Z4M2lv?=
 =?utf-8?B?Zm5PZWFRMi9OZ3cxb1NmQTYvSEVXUE9QSlNHTHBTN0xSY2tjNkJQV0Zid2hq?=
 =?utf-8?B?WEJRRU5BTFBIMVkzSndJMDJ5WEdVSS9BSWMvVTkyZm8vODFzVzdLbWFYVHhO?=
 =?utf-8?B?UzNrNTQxbksxNmc2dC9mL3ZiNTNmK3dFRStMSzExZjc0VjF6amFNUStaVlZD?=
 =?utf-8?B?ZTI3MzZFMDVaV3VseTRJRi9vTHV5ekhxS3ZWRXFUMjdTYnlLUzdUTEwza2hF?=
 =?utf-8?B?ZDBIc0NySzA3WWh1RFg2Q3FCZDBZNi9JeGNuR1FrUkF4ME1LeFJsTG92SUhV?=
 =?utf-8?B?M1pKZG95TmFaYTNUbXZSd1NhK09lbmMyYTlDY0Zzb3dOemhWbTArOGVMcDJ5?=
 =?utf-8?B?VStibW9KRTVITFhoY3VBY0ZOSSt0ZkljZ2RUUzU0UkpkTVJVdkJhUS9SbHZS?=
 =?utf-8?B?K0Nnc1dzbGlJUUJrOTNnYVhoamNZeGNGYmZ2ZUtzQ1d2VnZmTEY3clFNc2Jm?=
 =?utf-8?B?bllWcDBOakRwRGNWaTZndVdTcHBReS9WUTB3djQvQTZaVUNSaE96TG5QVTcy?=
 =?utf-8?B?akpvT2NnVUpOVHBBR1k4VHF2aU9lOXl5V1JGVDVnN09kNGNUbmxOYTMwbXFG?=
 =?utf-8?B?VEJtUnNuSzQ2dXNUdUhGK0JoS3NHRlBrOGovSExLeER0aTNjblV5SFdzQXc3?=
 =?utf-8?Q?GjwJdDUf4OHBxDOo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f55a65-96ed-4db1-0e62-08da3ff169b8
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 14:58:52.1715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqK6JWZ56uYLyWGy+I2RWfQpixzGwpgkdEOh1u/yhEJLvYd/5FzQjzw07hbAnnnQUxDIs1WbZVdkIVd5S4zf9tmV1c02joqp6A6yE1u3TIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3395
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-27_04:2022-05-27,2022-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=910 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205270071
X-Proofpoint-ORIG-GUID: 5VNfR5W4Y3dueW_3GamYKhYc7GKQuvf8
X-Proofpoint-GUID: 5VNfR5W4Y3dueW_3GamYKhYc7GKQuvf8
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/27/22 8:45AM, Matthew Wilcox wrote:
> On Thu, May 26, 2022 at 10:41:31PM -0700, Christoph Hellwig wrote:
>> I suspect this might be where your problems lies:
>>
>> blockdev_direct_IO calls __blockdev_direct_IO with DIO_SKIP_HOLES set.
>> DIO_SKIP_HOLES causes get_more_blocks to never set the create bit
>> to get_block except for writes beyond i_size.  If we want to replicate
>> that behavior with iomap, ->iomap_begin needs to return -ENOTBLK
>> when it encounters a hole for writing.  To properly supporting writing
>> to holes we'd need unwritten extents, which jfs does not support.
>> gfs2 might be a place to look for how to implement this.
> 
> I think JFS does support unwritten extents,
> fs/jfs/jfs_xtree.h:#define XAD_NOTRECORDED 0x08 /* allocated but not recorded */
> 
> However, we always pass 'false' to extAlloc() today, so I think it
> hasn't been tested in a while?  I'm not sure I want to be the one to
> start using new features on JFS for something that's supposed to be
> a relatively quick cleanup.

If I remember correctly, there was an intention to implement unwritten 
extents in the future, but it never got implemented. We tried to 
anticipate the unwritten extents in the existing code as much as possible.

Shaggy
