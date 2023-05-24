Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4547070FD73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 20:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbjEXSFe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 14:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236674AbjEXSFZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 14:05:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A72198;
        Wed, 24 May 2023 11:05:18 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OHxLS0010233;
        Wed, 24 May 2023 18:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ekvZLYLY3dSn3TQb8DbFZmp4lKfbXIRQQxhbAGUQ9yQ=;
 b=mBDVFdZrcnITXsQL6UGS+H1G5KXFfPTaR2XjSPiNMO1MYEjke/KUVGlW37yAD+KlT5VQ
 +J4YHkEMfOyuBEdnQCpjOlESaiMpsByQ6n/vLD6emI7TKBZ3jEFuf7Y2dct+w90/ELul
 GCZEh/JCVmD7I00Ll4ewjMOA49fJhWEmv/WR8g9fv2uFDBqAZ2aq/MGPTiJFjSGCXtGT
 vFqF5E91Xj6beNgvm1gQZ+n7Y3IbgEYCKMUbFxamQ3VEdXFZoSfYrnmoH+NlR7MtAreC
 eXGFSzg9Ua6bxqtchkLtwCPLLqZRV4qud0ttwdWZUbDnmFlYTkGw34iKG2K9XUDUvzmC 0w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qsqfbg0w6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 18:05:13 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34OHqXXP028684;
        Wed, 24 May 2023 18:05:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2su1kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 18:05:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHUDjQsK7J7zWkuuYRhNOeCSgugrkeswsZGcfY/3wL7zRopGneU8TlTRHmdfVne/DpDOc1duX+YgeZhin5JiQxo0ymGHFjoJgx9zk9eZcV/EfG2HzlzXYlmkCoc8mse4wjo2cb1F9q77KOD6gClKOzH4NFmm+oyykyT78InrpWOGPxB02zerhwuTb2IHzWhd3It9YKKSWtnXBVePtZtQ7Cu0UQiDPnbJ8TJaHhBldBZ+Jw6H9HFhj/15eU4mS0La8LGT63ntXHkNIX81XKs2++4wmNdITLdC82DM/memi3Jng6t28JlgToIf+Qlbkl4zggWwY22Bny7PP/P6uPS8oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekvZLYLY3dSn3TQb8DbFZmp4lKfbXIRQQxhbAGUQ9yQ=;
 b=GspOzLFm5MPoU35Q7lYTqsfxN8LddhPl6oix7gsiOGhQvZ3qOePObrtDfLUezeH1RC7XVUMXp7Wgl4Fg7fv0AZlINEtFxcwHHR/G8b7FMvvKhUowcikP2YlBxr4L64K3vzZJ7gjvBnbkImDCcdR3x8IKS4NX2EsjhTtNR8oUfwzqBa2RCk/YsXyH4onRBvS9bFtdfN8UlBTxhIbbPdUov//Sry/KUdGOCeQKHR7fXuybv0tE2oXf/GPH+aBqKLB8k92IKaprhlGrfCBpoPfq0rWN8G2R0pnqWCG73F29S8dIvOjxX30zcqbySm/llExp4TQNph3gWOzmKAvIJS7qUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekvZLYLY3dSn3TQb8DbFZmp4lKfbXIRQQxhbAGUQ9yQ=;
 b=LkuxzvtxV2UlA1Bhj5W1DVvLoOehbPYnDsvQawekAy6LbMF5J4XMylBcy1f0ywEWMWwkdaXKiOiSau9YpAD7OpGlcbJtLnXFtzd3C2v4SXmBpZpttS8i8u8aITHytef1ZzuX3l4jvc9zme+kKwxCqpm9bTCRZvpbX7oj4FlTC38=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB7689.namprd10.prod.outlook.com (2603:10b6:a03:51a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 18:05:09 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841%7]) with mapi id 15.20.6411.029; Wed, 24 May 2023
 18:05:09 +0000
Message-ID: <b4c4d608-80aa-7f3d-7a83-2e7b24918b02@oracle.com>
Date:   Wed, 24 May 2023 11:05:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v5 3/3] locks: allow support for write delegation
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1684799560-31663-1-git-send-email-dai.ngo@oracle.com>
 <1684799560-31663-4-git-send-email-dai.ngo@oracle.com>
 <32e880c5f66ce8a6f343c01416fcc8b791cc1302.camel@kernel.org>
 <D8739068-BCAD-4E47-A2E2-1467F9DC32ED@oracle.com>
 <bc960c7251781f912d2d0d4271702d15f19fb34a.camel@kernel.org>
 <CDB5013B-A8D2-4035-9210-B0854B1EE729@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <CDB5013B-A8D2-4035-9210-B0854B1EE729@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0165.namprd05.prod.outlook.com
 (2603:10b6:a03:339::20) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|SJ0PR10MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: a1778d14-8e6b-400f-821c-08db5c81699b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RVc411bjQYlb/GknRMrLAPRtRwtor3mRb6kJUTh7fuvIX8AzzNYwmCxvIaLC7+MofZNKIwmOATl1A6ouB8QjHRhipaXWdPPkffzMXsDDulLpdIqC/5kkajeIWnd8T+hEy4pPRQhyRTey099i5SngE0ck05IHtWer1/XSS+QcuAcbK3yGJuC5YcxTvTHDHNjLN70KXY59INKdg5hy8uKVZPahL1Ty+8dtAaIZ8NaZzGt3ZVVLx0Sgua//5yOKBlNWYNDiPOfr7TVrYSeoE54ph+IgGwxqP0Aa5oBBV8dcq6SdW8EYvUO5vztLfsXMcw0CpT3lbLhllypvGE4DU8yPEC7beKsi9Ktv46NvwsB0DK6ByK1JJ8ilePpy99+avlTwDuVUuKKyC56h06Y8q0FMcHr4LvuLTXJCgpmTmDBfB7tTANYuFper8KJxLWIpLbkdprDOauAsw/X0FxUeCrTlpHHvh6NMaPPOwCYy0c75H/+6403YYBGtlw9ABVqUW4cPnlBM85Gu07YPnHky+FlYCAzl2IP6hpdZOIQLo44uEy7ah0iXRkUIC22DJ62iZsFKmwwmrxbBH9FJF4I26sH9cbGM4mwxpSOuK5K+VxTjgekyK698AeotG0vLGFMo2Wl9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199021)(83380400001)(2616005)(2906002)(186003)(36756003)(38100700002)(316002)(41300700001)(6486002)(5660300002)(86362001)(8936002)(8676002)(478600001)(54906003)(110136005)(66476007)(4326008)(66556008)(66946007)(31686004)(26005)(31696002)(6506007)(6512007)(9686003)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUdnRC9FMExhT3U0R05rSTE2MVdGdnp2R3BPWGVMV2tBb0RyWjlPMGRxamlH?=
 =?utf-8?B?dlBBNEtJajZtWi9XSmJEYjJISURoWEZ0RjJKWjlyb1IvWTcwUkFzM3pTaFlh?=
 =?utf-8?B?Y0hoTlZaUlRkb1FBZS9wT2NCZ3h4WitLNmwzNmFnbk9nQzFxaTBnd1pzTjlN?=
 =?utf-8?B?ZVFKRFNpMzluMWZ4bG9HSEt1S0dkcjFHc2k4RmhVcVBmMGdhd011aDRYeFVT?=
 =?utf-8?B?VmtrU01XNHZXN2E0S1VUTVJnTWRKMVprbmhoelhBVWtCOXZuc01Nc0xFS0pX?=
 =?utf-8?B?NnV3bmgyeEF5d25YcDd2WVp1NXRqQ3BJeVNnUnRJUWZCZkpObUdrUis2bks4?=
 =?utf-8?B?UmtiNlhxbFJIV281VERuT0p1TCtIcDNSa1dlM1ZIMmNuMWM3MVlZbkFIQjhN?=
 =?utf-8?B?cWcxbXE3cXJSRG96S3F4dUtmNDEvMk1UeFh3M1NHQ1RnVE5wNy80bC9yZnZ5?=
 =?utf-8?B?QmNmN2l3UWVjdVZheW5wKy9MTENEajhySFo0aFdlOWZsdmorWnhmVFQ3SmhX?=
 =?utf-8?B?Z0psWFFKUXpKT3plS0FJdTBtNHd6Z1RHTncyZXF6OTV6RjFkRkV3QUtmS0Y5?=
 =?utf-8?B?bk5vSk0zSndpc3dxYlRBWnA3dUpQc1lJa0VTS3RhMnNuYU1Ca0JwcHEzVi92?=
 =?utf-8?B?Z0F5VjVUaUdwakh1S1VVQk13SjVMZVByNkZPVkJnZm9URGRMaEtJRlBydTJh?=
 =?utf-8?B?ZU5Zb0N6THRNYjlnSWUvUGw3MmI4YVVzYlZDOHRMN2tqV244a1REVGtoem1X?=
 =?utf-8?B?ZmkwZEh2ZTlWMFMvZ1RxUFdGbmZoOVpaSVM5aEZ0R2dHRHErZEh0ajhJd3Jz?=
 =?utf-8?B?RHZKU0hiWkZZQ1pHdXZpRVdVV2hZNklDL2R1UFo1c2tJRkJ3UWtSc3JsY0JS?=
 =?utf-8?B?ajltMTh1Y1ZLSnU5V3dyVk04MDFNZEpqcWtTSjNOVWt1UEpQWjdPM0w4QW9M?=
 =?utf-8?B?Q0ZDRG5QYlJqaUtOZHNYMjE0TitxNnR3QWU0R2JzbCtvY3hubHlkdVJ6WWtI?=
 =?utf-8?B?SlFsbVNTNi9UTjlPVTRRZXRaY2dpZDVReWxZRmIrenlrRmxtenN1bm5xQW85?=
 =?utf-8?B?a1FVNnR6ckNwK0FKL1NldG1TRVIrMk9pNmtkV25waENkN3QydzRaZFJScGg5?=
 =?utf-8?B?TjhnejlHcjZFM0crTUpBRUcyTTdyWU1abHJJNkFuL1ZmcVA3U2ViRmxLQVc2?=
 =?utf-8?B?TjdtdWVndXlNOU13UDh2ZUlxYXlrMTgxa2NHRG9xcjhBTjdRem5XVFYxQ0VV?=
 =?utf-8?B?KzNTR1lHQmQ0RENaUHI3dFpveEN2NU1URnZsTzFlMENQNkxZeDZPdE84anpC?=
 =?utf-8?B?aFVXSWk4WnBCTW5tcTdqUHBqbXlGUkhScHFNMGxCLzhYUW5IUm9LYlhoaUZL?=
 =?utf-8?B?QmpJL1N5T2w3eW9MUHRaM09QdHpxMWM1VnV6YmxEODVCVHQ1MDlCWHNhZGNK?=
 =?utf-8?B?Wkh1dEpRZjJWWmVMdTlhc3hXUXJ5WFhRM3Vyc08xWEE3QWNrRzFMT2xGeWtF?=
 =?utf-8?B?UXZTdEh6eW5tODVMVkdzcXJLSFFVTElXaTBEK29YdXhNd3B6cmxiY2I4QmhG?=
 =?utf-8?B?Z1lWUlJGWHpWTFoxeHcxZmNFa3VINUVTRXRnS2xUOTNmT2VUOGNyVUZsbU5P?=
 =?utf-8?B?SGl1YzB5anZLOVFyZHZMSmJQV0pmQVhaRTE1dyt0VlFUSkNoVTYvN1R0alVy?=
 =?utf-8?B?Q1Z4NVNoZGN3UlRBMlZRbURaLzBsV2pCV013VUhHNUQwdk96TmpCRjVJZDg5?=
 =?utf-8?B?azRSaHN4alQ2TUNBRHV2RjhnbURMa2NWcmJLVGdxei9la2JsN3JQWFZzSktG?=
 =?utf-8?B?YVNPOTR3TGhjeHRDRzNKaWFLWDNJb0JpTVV6NzVxT2s5WjBHTjEyY251Q2pG?=
 =?utf-8?B?eTNFUURpelBqUWZFVmxaczdRVThvVm5qUnZvRkVqa2hMODhkV1F0dTJhUmhT?=
 =?utf-8?B?K3E2ZTVCQ3hVUzdsSU81Z3ZNQXlWVXl0My9rSzI1NGZJSmtab25BeDN5eGUz?=
 =?utf-8?B?bmJKNU92Q0ZIWnYwd21sZEQxMGN1OUxzMVFoTjZRcFhvTkpBTXJrUUx0aUlw?=
 =?utf-8?B?QzBBM25iQXZhNXJZYVM4R3M2RXhkS2JsaFNjMERpMm5IWmIrWGFtOElmNnJl?=
 =?utf-8?Q?lEx/qC9U/fL/4QeUYWpu4WkOT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: E5KIrIeKvbAiuKWKECRnOvF+lNZ8/GviVcp/YTRY0xIdgPXjOsQHFNvmMnzxWu6SJyqE8p1WwXl5Hr6DyuKAgnmYkmiPqdU7hY48ygVOYd/t0cdIEXIPfmv5ab89AiX0QuWkTZcSvLZlxjD5EyGDK0KZ5S67dCjcjLvxanCeVx+08uZ9BkIUnB7l3/G9tLEd3K0vJv1yh0pLSGHwLLdPMtXQMWpHuFsYbSAhFy2zqqW3dhirW4odI8tnsM1C6vJS4rcAA2hJBnLr7N/vPuk2w6+nRS0jyBdjfOkW2kbaIgOIVYp5z1pYGJUNUk6y5+jGh9u4yAh9CrljlflFZA+KgNn5Bx9wg/NYFe58SzhkhjQ3fISwDcNFiyv370/nwAo1mYF8Pr3xCaxniDTDTlGGQtE3JHtvJGSn8tvPBTHOtuA4sWQRUDxo15GtIQlem1vSva1qOQYbYDtb8wUUVimTTv84/wLx020yckoY9bFEObwdEZReO3X4AoxnHtEycB0E+K2y51r3hwr5StRcI4+adF1D/xPeUEeYcw7PN2p4g7dP884p1MS9DnxV+rPAkbr0JoK2pqq7vFKhtfAi6A5BLtqfVOT1FzUfHfp1VN6CeJVHr1qOQqkRQ2xFMu/e6fTrBoLzxcdbWsAUvXoJp0ysPcrowM8WsH9mxmgHC57EQzbjlgK61I4kcYZwBGJBuCitLDpempf7WET3y3dSlqMxJd7QHnFXUK5WqggKtaczABYqTp25i7SGJf+Op0RpcFakonxKoG3+l8RYjzJNLL97X5NNsypB1Wq/w94zwgqUJC0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1778d14-8e6b-400f-821c-08db5c81699b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 18:05:09.6838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGL/tqHiXf/SOPJq9N6qxFDbCp2/9RPuQno4GBwJxx/USKJQKMBNkkf6MaymIINhNOJtHu0eSqIu5vKSdlnnpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB7689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_13,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240149
X-Proofpoint-GUID: Jh9qUuDQl53zdqerdiw76DeLEGSlzrqh
X-Proofpoint-ORIG-GUID: Jh9qUuDQl53zdqerdiw76DeLEGSlzrqh
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/24/23 10:41 AM, Chuck Lever III wrote:
>
>> On May 24, 2023, at 12:55 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>
>> On Wed, 2023-05-24 at 15:09 +0000, Chuck Lever III wrote:
>>>> On May 24, 2023, at 11:08 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>
>>>> On Mon, 2023-05-22 at 16:52 -0700, Dai Ngo wrote:
>>>>> Remove the check for F_WRLCK in generic_add_lease to allow file_lock
>>>>> to be used for write delegation.
>>>>>
>>>>> First consumer is NFSD.
>>>>>
>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>> ---
>>>>> fs/locks.c | 7 -------
>>>>> 1 file changed, 7 deletions(-)
>>>>>
>>>>> diff --git a/fs/locks.c b/fs/locks.c
>>>>> index df8b26a42524..08fb0b4fd4f8 100644
>>>>> --- a/fs/locks.c
>>>>> +++ b/fs/locks.c
>>>>> @@ -1729,13 +1729,6 @@ generic_add_lease(struct file *filp, long arg, struct file_lock **flp, void **pr
>>>>> if (is_deleg && !inode_trylock(inode))
>>>>> return -EAGAIN;
>>>>>
>>>>> - if (is_deleg && arg == F_WRLCK) {
>>>>> - /* Write delegations are not currently supported: */
>>>>> - inode_unlock(inode);
>>>>> - WARN_ON_ONCE(1);
>>>>> - return -EINVAL;
>>>>> - }
>>>>> -
>>>>> percpu_down_read(&file_rwsem);
>>>>> spin_lock(&ctx->flc_lock);
>>>>> time_out_leases(inode, &dispose);
>>>> I'd probably move this back to the first patch in the series.
>>>>
>>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>> I asked him to move it to the end. Is it safe to take out this
>>> check before write delegation is actually implemented?
>>>
>> I think so, but it don't think it doesn't make much difference either
>> way. The only real downside of putting it at the end is that you might
>> have to contend with a WARN_ON_ONCE if you're bisecting.
> My main concern is in fact preventing problems during bisection.
> I can apply 3/3 and then 1/3, if you're good with that.

I'm good with that. You can apply 3/3 then 1/3 and drop 2/3 so I
don't have to send out v6.

-Dai

>
>
> --
> Chuck Lever
>
>
