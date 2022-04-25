Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B7E50E45C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 17:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242788AbiDYPah (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 11:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235864AbiDYPag (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:30:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD25B101D15;
        Mon, 25 Apr 2022 08:27:31 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PDAHvD031587;
        Mon, 25 Apr 2022 15:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8O8h0n/lEljeAcXe1BXAvWW/nWvF1z3KbOvFOJ4c6hk=;
 b=YiTXzsjFj92Gt0jyu1L7Bxq4UWSJgPalKYjcMWC7YsN7arSKCr6CtnklcM4JIeHd+gNO
 RmzqBAID6LkJ24MLQGGzYZ/NLuMQ/mYkxLd9iNWDFicPmB26Pvy/4MwFdBWtYxokhh5e
 6bQUV3qtUfmEnwoBW8dy12AZzIwR82SwdqNeOEOvkZc4W4gMWrAfXo1iJaY5u3PldjtD
 6tujjplv6J4zGQHSGaOayxVP/jzDqSSOL6HzsYAUOgFZwMeFb/uN4d6yP6dPaLcbd24u
 /M4JhPF7gqDnj+b5CCYwqh1SbR1NpsN0IQXnUHn8SnFyfkJkdXKSN89ku3ll93bRb2qs 2w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5jukyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 15:27:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23PFA5d2010110;
        Mon, 25 Apr 2022 15:27:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fm7w2qg0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 15:27:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4MJ6vqdBTxWSrQOcckEj2Rt5xS0u21ZwGDEUOCz8Zr6o4i3QnbbLrLA2DgAjSQjwj4PNxtB3JJ2w9Rum7F5+Go+jJWBNKXLGUHu8CFiZStCJrz1vBwbokT0hFgRUxNJ9F5B2V7Usz0ZocCcYMeaY7PvItt1ka/olum85hcKfIl8Cw3wzhRmq7xI24nQLnhj6ADY8b+UwSVNHAXIyBodnqK3lebqV8fmoYvqEmI3PmXqIq25z/0oHnuL5ooV2L7HJSTMA6j75YeQzWfRuQtEvV05ZG+VCnWmtWKwQ82pes2q2NS4wSDPuePiY0gASreXV7cfCg8zjzJWvOAqP2FBtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8O8h0n/lEljeAcXe1BXAvWW/nWvF1z3KbOvFOJ4c6hk=;
 b=hDB1l3E6+9jQaqtln+UyV5Je5b16RtfL1FMwQ1sq4Sy22VNNTb7V65BUYTmQtJEH/atiJoGh/drxv+0IIXz8Ol5y4wCuiKBfMfEWrU9Sfm4BWIxUvAcip9Rjq5EYw2ZryOMUv0siAX5C5v3KlTp7Nd2TthHQ7F75gR1erp+oH6D8HdRx3KslKByBzY4N+De/d8+VsjhiZpJYt/5AIx4WumHZ+bYW3x+E6rglgKqw74pxbymMJUXbc4nxdH0LkWVRUwoZq1QokTT4bl+qIWlPIl2U8MXOxBILLXyyXTKzmBTGpHaV+4xj+qGOgPxxxVy/tGXVaw4sWLwBV70pcvDPSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8O8h0n/lEljeAcXe1BXAvWW/nWvF1z3KbOvFOJ4c6hk=;
 b=ttYT5ZZ2mKA+dwhWfrkMyaEWbjgFTTUsRgqwStlNzA74S2t3COAHrlhP/KQSkt7ZyINTMKYGOGYZp+UujTxngNWgZdeAHXBLRACbk+wY/aCnpW1f8ZZdkao2fBg4TUgDf/cBgsJR1nXp1joz6j/iXnmaZGv5FLbSjPokvLak9Tk=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by PH0PR10MB5404.namprd10.prod.outlook.com (2603:10b6:510:eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 15:27:25 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::29d0:ca61:92c9:32c2]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::29d0:ca61:92c9:32c2%6]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 15:27:25 +0000
Message-ID: <8640dbe0-cece-4515-fa4f-efa2e0a14303@oracle.com>
Date:   Mon, 25 Apr 2022 08:27:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v21 3/7] NFSD: move create/destroy of laundry_wq to
 init_nfsd and exit_nfsd
Content-Language: en-US
From:   dai.ngo@oracle.com
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <1650739455-26096-1-git-send-email-dai.ngo@oracle.com>
 <1650739455-26096-4-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1650739455-26096-4-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0073.namprd12.prod.outlook.com
 (2603:10b6:802:20::44) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c326985-da0c-48cd-fb62-08da26d01985
X-MS-TrafficTypeDiagnostic: PH0PR10MB5404:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB54042FC1991FE5A7A8F6E31287F89@PH0PR10MB5404.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QC+MjyOL+vRVr5d0NQKgR1lcM2LNqHG2CuCG3fjC7WQtUmABR+g//wQFGfRE5mWpwz6RJiOnnIlnncSBrJkGdAaZne9ur2w6m4hPPNciOJ7MLhxXCsIFAtB2yzwYmoELE3/jvxS1WsKI6SfwnzmMtAMeBezFktIadpWvChISD//vVehfXiiGR0+Nk4vMHQckVYHt8ZNckIU7iJdUfVsQlliMWXqe6tdA32pufWrp2WK+OJ/3Y0xO/Hy/5Rlb3awNclKoroyelueufrvrSkuX3NcgzMlgKd2aSExD73XdvIVX7e7bATY6RM7rOURZhzxGFG6Nbv7lliC7syDDbnvv/61GqUr3r9xLpe3686rYkbVqW7eTEGnIHB95QbEDPwJeL7TZayZ5YclQ7kaKrHitqX9YYjzLqA+K0rffL3oiODwQf+3YJ6OwEJ+xKFxcGV3NZt+R3PfLdMn2+mgOlQEQh+45PRYOLBjroOQEAmJ4NzwMNxywoTlUKjlIa9/UcYRtp8oLeiITbqWLFiYBu4CpsZQh90MF9q3IGBJGgrQUTGgMUKCFae0LPww19SfA0BRuhSE6SXz23mBSIN51v9ZFNFuDEFIKSBp/eLAuEl2v+J1w2S21BsJgbHZqi7evN4ngeOwsZzi32cce2AU/hOKY8T7x5E5nAhL6b495TcYy91IIix0MaTS5VEe2LgCtyuPdogNiLWoY/LiBVAvvPPAyIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(6512007)(9686003)(83380400001)(26005)(31686004)(5660300002)(316002)(6506007)(6666004)(186003)(36756003)(53546011)(2616005)(86362001)(2906002)(31696002)(38100700002)(6486002)(508600001)(66946007)(4326008)(8676002)(66556008)(66476007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWxWVDdyc1U1bzdKM3YwNG80UklhUGttQWhURHJNUlVDMXdVQVR1V1k4RXVz?=
 =?utf-8?B?TnFLWjZJSm5DbEVaV2RvUlJZejJqYlk5UVJSNXlzMHFndTN4dGpxVDJoTHJa?=
 =?utf-8?B?dEkyUHdOR1RiQ2R0UTZrUXRRbXA4cTZ6akpLY05lQmlKb28ra2lVb1MwOVBN?=
 =?utf-8?B?ZWphS3ZyRUNNRnZ5bTdwNW9EVHprUzFpSEZxcldrRHh5U1ZRenZxU2hLV2ln?=
 =?utf-8?B?RlROV3IzVHJyS1ZLdHNYUnoxQS9JcldTNFVzSGk5T2NsYW5xTk1ValJIRGEx?=
 =?utf-8?B?TVNBdnI5UVZGbytybnNNRnZ4eG9KRGF0TEdQWkxuUlJ6cm4xNkwwVDF6LzFE?=
 =?utf-8?B?bHlJMzZoYXFMWXFxWTBOV1VqUUhwSm5oUHJsQ294Y2xFL01Jbit4VW1SZjd4?=
 =?utf-8?B?QURHaXdXSzhyd1pqWWRkMHF4aWRhalVoZGFadW1VKy9oU1RkUUJpL3U2MkZ4?=
 =?utf-8?B?Z040bDg4R3B6YkxVZjlRNCs5TFBoUjBlZVBTbnhWNi9IdFk4aE5xZ0NmYlRh?=
 =?utf-8?B?Y0tROVdOTlF5MHVDdGtWMm84alJXMWRPWllRajZyYWlXbUNGdW1tVVl2dlVQ?=
 =?utf-8?B?N0NmKzBUYVJQR3lHNWtCekIvUldJUzVyUHliSHgycVozOHVZa0VzRUw4UE4y?=
 =?utf-8?B?RHprMUZvSzVkQzlWRHgxRSsvcHNDS1VFUGo0Q216ekdQV1ZaQlZKYXh3bUpx?=
 =?utf-8?B?OVM5cnRwVUNoOTVEamk1RUVuMmVxdDEvcDRIQmFoUUJueEpzTmJ2SVQzVWVS?=
 =?utf-8?B?ck1kSkhSQVdWRHZmYk5LbzAxVlVZZ3ZiRjlWN0g2a1R0d25BMVoxd3JtaXZv?=
 =?utf-8?B?WkV3empYVEhxandudFhuZUREM2NnOWl1VTBlUkRzT1YvMUJBbE4wNWE1N1I3?=
 =?utf-8?B?T2NlUWtvN3hXZHdBdU1sTEt2dFBaUzF0WUdpKzhucFZqVGJHdFBJSHFqNUh1?=
 =?utf-8?B?RXphYjRpbmhLbDR2RmlsSzkxSmtCaDVJT3lVVmhDQ1I4NXNUYmJiUDhrMEhv?=
 =?utf-8?B?THhpNm8xVC96RWN6UmM2djFyMmowWitEOEEwUkZxVGNMNDl6S1dVN2lXdnRU?=
 =?utf-8?B?VGVFOUxlc3c1Q2xHdVJFbFUzQlBDdytGNGo1TjlsQlF0TFJ4NVIzSUZuY2RT?=
 =?utf-8?B?a2xDR3FlaDRKbG5kLzNZRzNXQUl0Q3VQNEcrUHAyd3ZoOGczMGhvcnJscVgw?=
 =?utf-8?B?WjFvaFBTVm9GWUd0dk9rdFczLzFXQy91QWxXTU53WDFDM2U4andVUG9uemZ2?=
 =?utf-8?B?bWlBSjMzOTZydHZoNFR5dExFcXhnM3RUcStNV1ovY205dkplSXBxUjVVaGd0?=
 =?utf-8?B?MGEyUWt6aU9hTUszWExyOFhLVkZoSStUejF3YVRmT05lajRGTWpKSitEY3BU?=
 =?utf-8?B?NjRqTTM1WXRLajY1NjZHRjFXRW51L1pMNU1ydjBFSUFoL0ZpOWRYcnhOcW5F?=
 =?utf-8?B?UWZrdGlIYlVxNDdVWnVlbFpuZ2ZqL1B5dGE2MW9GOFN5Zk4zL3A1azRKQWRS?=
 =?utf-8?B?RkJRb1RDcDVzdjRPT05zOWZQSy81RDR1WUJRZ1E3VS9kT3ZmUzVJSnBFdjRv?=
 =?utf-8?B?bWtEUWgvMEhkQ3ExMlQ3bTh6cjcrME5wdDdScUEyVlk4S0VQS0I3RmczcUVw?=
 =?utf-8?B?MHh0RmlXRDBOaXk2Kzd1U3dHUVhBbjVWV1EyVzJiUVphREdlbUhZZ1JtWUdk?=
 =?utf-8?B?MnNQVmdOSHlYamZqMUMyMXBVNzE5VTIvNkxQRjdkTGJIZDgxemxKRWhvcFc0?=
 =?utf-8?B?TnUwYmdBekJnQkxOZGhyNlFsbDVFT1lvcG05SmswQTEwTFVKSlJ0by9uTkdX?=
 =?utf-8?B?L1FRN2U5SkZDYkpIMnJnRXkrcnVLMy9jbnhlQ3JtK2xyN3V2Ymw5aEptaS9r?=
 =?utf-8?B?VmZJUDBRS0l2dGVqTm1Ja0NObzVEYWxzbWVmSzJSZldGRzR1T3dUNUR3YjRK?=
 =?utf-8?B?VFRSaDhXS3FvTUFaUDNKVy9ETGNJZ1RlemxwaHp6aGhnTXAybXZhek0vVk5u?=
 =?utf-8?B?UlZSUzRkak9semJIOUVLNCsrbTRqOU9QOXRhd0I3Zk5kam4vZnJuZExnUGZ4?=
 =?utf-8?B?T1ZEdHdUbE9kdzgzTzdlMHhEYUhkNnVuZEdydkN2TVNHbnd0d05ZcVBtbWcv?=
 =?utf-8?B?NCtPRm9UUE85V3BVMWhyUklIV01EaEQ0T3dYSFREcUJXZjQ2cHVFVjFFVlpE?=
 =?utf-8?B?cC9GQUlzVU16aHVUSy9WY1hYalNkMUtOMmNaSEFsanc5UUZPL3cwNnFxZjZu?=
 =?utf-8?B?SzhBTlc2Nm9YcmoyMUxLYlg5NUV0dS96cGZYbHJSaGRDdlRwZUlmbG5KdU96?=
 =?utf-8?B?V0toTm1FTU9paEZIRFJnUEYwU0pCWlo0anJuRVFGbUdIejBCRVRvZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c326985-da0c-48cd-fb62-08da26d01985
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 15:27:25.0547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NkAqzkn9jm+pOWPrfR/n0ZtiNB8vHVOgh2zng+3BBOhPnAXpYOTZldUWUYpOC3YywSATOlBcbQ1sYXMAdOITcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5404
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-25_06:2022-04-25,2022-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250067
X-Proofpoint-GUID: yfaDE2qeNlCHQZlNgk-w02F-X2mG5YMY
X-Proofpoint-ORIG-GUID: yfaDE2qeNlCHQZlNgk-w02F-X2mG5YMY
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch has problem to build with this error:

>> nfsctl.c:(.exit.text+0x0): undefined reference to `laundry_wq'
>> mipsel-linux-ld: nfsctl.c:(.exit.text+0x4): undefined reference to `laundry_wq'

This happens when CONFIG_NFSD is defined but CONFIG_NFSD_V4
is not. I think to fix this we need to also move the declaration
of laundry_wq from nfs4state.c to nfsctl.c. However this seems
odd since the laundry_wq is only used for v4, unless you have
any other suggestion.

-Dai

On 4/23/22 11:44 AM, Dai Ngo wrote:
> This patch moves create/destroy of laundry_wq from nfs4_state_start
> and nfs4_state_shutdown_net to init_nfsd and exit_nfsd to prevent
> the laundromat from being freed while a thread is processing a
> conflicting lock.
>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>   fs/nfsd/nfs4state.c | 15 ++-------------
>   fs/nfsd/nfsctl.c    |  6 ++++++
>   fs/nfsd/nfsd.h      |  1 +
>   3 files changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b08c132648b9..b70ba2eb5665 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -125,7 +125,7 @@ static void free_session(struct nfsd4_session *);
>   static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
>   static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
>   
> -static struct workqueue_struct *laundry_wq;
> +struct workqueue_struct *laundry_wq;
>   
>   static bool is_session_dead(struct nfsd4_session *ses)
>   {
> @@ -7798,22 +7798,12 @@ nfs4_state_start(void)
>   {
>   	int ret;
>   
> -	laundry_wq = alloc_workqueue("%s", WQ_UNBOUND, 0, "nfsd4");
> -	if (laundry_wq == NULL) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
>   	ret = nfsd4_create_callback_queue();
>   	if (ret)
> -		goto out_free_laundry;
> +		return ret;
>   
>   	set_max_delegations();
>   	return 0;
> -
> -out_free_laundry:
> -	destroy_workqueue(laundry_wq);
> -out:
> -	return ret;
>   }
>   
>   void
> @@ -7850,7 +7840,6 @@ nfs4_state_shutdown_net(struct net *net)
>   void
>   nfs4_state_shutdown(void)
>   {
> -	destroy_workqueue(laundry_wq);
>   	nfsd4_destroy_callback_queue();
>   }
>   
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 16920e4512bd..884e873b46ad 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1544,6 +1544,11 @@ static int __init init_nfsd(void)
>   	retval = register_cld_notifier();
>   	if (retval)
>   		goto out_free_all;
> +	laundry_wq = alloc_workqueue("%s", WQ_UNBOUND, 0, "nfsd4");
> +	if (laundry_wq == NULL) {
> +		retval = -ENOMEM;
> +		goto out_free_all;
> +	}
>   	return 0;
>   out_free_all:
>   	unregister_pernet_subsys(&nfsd_net_ops);
> @@ -1566,6 +1571,7 @@ static int __init init_nfsd(void)
>   
>   static void __exit exit_nfsd(void)
>   {
> +	destroy_workqueue(laundry_wq);
>   	unregister_cld_notifier();
>   	unregister_pernet_subsys(&nfsd_net_ops);
>   	nfsd_drc_slab_free();
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 23996c6ca75e..d41dcf1c4312 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -72,6 +72,7 @@ extern unsigned long		nfsd_drc_max_mem;
>   extern unsigned long		nfsd_drc_mem_used;
>   
>   extern const struct seq_operations nfs_exports_op;
> +extern struct workqueue_struct *laundry_wq;
>   
>   /*
>    * Common void argument and result helpers
