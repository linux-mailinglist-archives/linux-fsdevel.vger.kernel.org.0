Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EAC4DA2CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 19:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351192AbiCOS6E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 14:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351190AbiCOS6B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:58:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B3C58839;
        Tue, 15 Mar 2022 11:56:48 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FISxg9011244;
        Tue, 15 Mar 2022 18:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=atr9nTooGVx4vuTU38yAvkuoBu0KPwnLh0DU3dtsBVg=;
 b=zWkZLVj1FyQYL1J6r9IwChz/SSlGYuJUusgZdF79gUF8wTSPK4ED3gjqt6BYP6X+TWsf
 uh0MkAZbg5t5MUOdj6ntqGxDWCW9YCm1lHW11P9sof0IN68dw8dB4e1A9x6eJtRSRWVA
 XjT264BlNJSna5TsaOFL5MaYOEBTyq7MEnds++FKxKTKf+/Gm/mPx42il26ysEdNPXlO
 pACCgyHZL13cJhMhh7HAor9Duf1aID9q4cN1ixOBkwmjSjwBNczvvEf/ib36mtT6DkEH
 2vVO8dcqOziWv2NYcJHVECVZ2cH4Tsv0PkDg7yXOO4B5KaJJ0si9OWOAbEBBXn3wT+wA zg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et52pv5p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 18:56:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22FIsn05034927;
        Tue, 15 Mar 2022 18:56:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by userp3020.oracle.com with ESMTP id 3et6580u7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 18:56:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEVNTbOC75/D9rvi1mS8sU2Y7LgGkOZ+RsHVkyQO+vy99S3+z3N0qI8q26Qn0AgNoEVXfp8QzRN5FvAzQEaJxvjO86PnJspfxtljdHtOxW2o/LJdbvHFPPRjpe4z9g7it7Te2g1SPlLs6ZvPnulc/X/npK8N/ul9upbbBQRcfnnd4ItuAoTuTubL3mDzldBYH7HgCxDtP7UFFOmH2CPGOz3fuS9Marn2kWqq3AfQwIUzhTrNdGR7Q/UOJZoQwkxloLCmAEC4BJyJ08CS7/laX4P6mFC0Ph/nW7a/6zOyQBtGVTI0G+Mud39ibbej1Mf+8t8nu/satp8Tk7xI0UKI4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atr9nTooGVx4vuTU38yAvkuoBu0KPwnLh0DU3dtsBVg=;
 b=AakEgYNJXqLExCdVQLCl6gwoi8NG+ZLsYMypybF9C5KPtqlvPAosqHHN+9nHuc52oF/33WB4vh+K7TaIYB+UOObjGxyRCYv83Rl5cJ9lyiY3s/sEYpmEKbCEy5kX688YDolnhfMtKEDdHKr+XQFDfw7TQf0E8MxuBl8s+5o5EgushCVJdVZB1jipTGvchy7/wonyKMXL90erw+S0iKcBOA3uny5OTjbGWkRSlslVNCUAtUOL+YOzvDuPc426AmoiMjWP/k+ItaFJead2fLlMwjCvT363f/4qWuUyeK2e00CZbkR5SAb+WEF/yMACvqDa7C7NM+tS7x+U48/duFiPwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atr9nTooGVx4vuTU38yAvkuoBu0KPwnLh0DU3dtsBVg=;
 b=aCLvdnzYkYl9aCl+f5rFUg23uTvY4YvAJRHq6mz5VaYD/Xnj7vulcFKcFNR24fWg9/1hQiZ9oHedZxTHaV2etIrMHiKsPQyN2g7x5BT8IEQF5KrZp9iOolG2dxlkQQqqipI+/dwnl+9aEHgZQp08YmH9aTjKA8B6aY/B7660glc=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BN8PR10MB3139.namprd10.prod.outlook.com (2603:10b6:408:d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 18:56:40 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572%9]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 18:56:40 +0000
Message-ID: <f3e41200-13b6-837c-3eef-0fe60b64f693@oracle.com>
Date:   Tue, 15 Mar 2022 11:56:38 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v16 03/11] NFSD: Add lm_lock_expired call out
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Bruce Fields <bfields@fieldses.org>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <1647051215-2873-1-git-send-email-dai.ngo@oracle.com>
 <1647051215-2873-4-git-send-email-dai.ngo@oracle.com>
 <20220315150245.GA19168@fieldses.org>
 <1e1ff6a1-86cf-99d4-13ad-45352e58fe73@oracle.com>
 <483E025E-E72E-4F2C-BF98-66DE12F94909@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <483E025E-E72E-4F2C-BF98-66DE12F94909@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:a03:331::9) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47343b96-c09b-4b57-c29b-08da06b58a43
X-MS-TrafficTypeDiagnostic: BN8PR10MB3139:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB31393DD5C2CE791F351AE94887109@BN8PR10MB3139.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N+mt0YYwzSr6Ff5UjQKoxSXoB+fxqe62ekUbhPTPNcvAzL/kCf/e1JowNFKZzDCGgJTvnmb6sqH/B+CLFCEwLZ+n/TDGvvzYU/9PEy5U3M3xVMmbwL5rO3Lvr/4dzejI1TAQtZKdkfX0m4qFrRMPpPCPuRjBzT9zHxfxOGQaS26BQj32PwS91aJ6SuKkMGldJ+iw2VEKv+A5Seolha2QDRCzLAw/ub7b+dViTPfr/3gAZt93GSOzPqe+DeUEcDU8K8RpVLZ5txeMIfID9omVkf2w++g+6LILRz364NWOTNtEg+ljnKtzA5lRw4isdxvIBKikyIq3oktqL9bCaNBGr3WV/eihw3DEtB1seRbDD6zJizmuG9BxE2ubhKBQChr99O6ukxbEOTAMyqTsLP8fWepcWIGPiJ32nZI85V6SJvY3hdqTM6sDgtFGBv59iXdMPBdx/swFF1E20sV3Ij3fpS7zIFDUaOQ5n/oFFfe4/aYrU/zb8P3KDwx3CgVLrBq7cPk+dAbcbAjqlzg2cwgjd0EhC3lJor1n6C6jGnuW0uL3pKkSepuLYJNnrtutaGXSKQRrj54vi9JrZjshx5Q+bsjWV4pAFGhCTbdnbJONYFQWzmK0Bls3mdUVqzfl/R39+24lC5AQAk80A9xDKk9q7n8doGzSAyTkTSwznl7g6tmQtYi31VIQhr/hxWPQgR62UqH/irY8ZDQ7MtL+V80Ttw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(31686004)(2616005)(83380400001)(38100700002)(5660300002)(110136005)(316002)(54906003)(36756003)(8676002)(4326008)(6506007)(66476007)(53546011)(86362001)(66556008)(66946007)(6486002)(2906002)(8936002)(31696002)(508600001)(6512007)(9686003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTJYL0J1Q0duZXJhdXNjQXlFOUVObUJMUDFIMm9SZGhiUUppQkNhazZ0UUdR?=
 =?utf-8?B?VHNReHJQNFN6Rk9ZeVJGb0RTcVE5R3YxcXAwcGFiTVNWdEZKcWZZWkFqVTV3?=
 =?utf-8?B?Q2pqRk9NYlhnUE1VcWhPYkF1TkxoVXZNVlcwdTlwYnpLWjhmU3B3M1EzSUox?=
 =?utf-8?B?V0ZWNlNpTmJTZzJDVUh6blFFYWhicU44VUlRSmR5YU1peWYzMUhlckxDNFV2?=
 =?utf-8?B?aDlvZUN6TFNrQlhNa21KRU1mOFR4MHdxT3didXYydC9NaUNqQ0x6KzV2a3hO?=
 =?utf-8?B?YzFrNWdPWmZLYXVnN2FWVUl6SmNIRWVwV2FNM1NhUW4rZ2ZDWDBaSno4Vi9I?=
 =?utf-8?B?RXpJS0YreTBwdzk0OGFQeENPV1dtMHZnVmh3ai9xczNyODV5WG9JVFd6dllC?=
 =?utf-8?B?VXZyYnZXQnk2azI0eXZYalpkUVE0TjdzTlhpbHpQeDVyVUNvaHI4R1hSZnpx?=
 =?utf-8?B?WDJGaGFOTTFUWng4ZXdCS05IZnVvR2I3dlVoQUFWTHFFWFY2STFsYldkY0Z5?=
 =?utf-8?B?TUpJYy9wdFc5WEYyZk5FUDJLKzZod01EZTkzOCtrZWhyem5iSmY2NFRKTXBl?=
 =?utf-8?B?bnVFbUVoeUcyQUdRblg0Z0ZhQXJPbVBrSTczQUVsUTdQdzE5WVpaRVFHLzBq?=
 =?utf-8?B?SFMwZFBvOHRXeHNtTjVVZTJ4WW5EdkRMdkcyeGIzeUc4SkVRblp5N2R2TjBy?=
 =?utf-8?B?dlowWmwyL3dzSlA1U3NqWVVQM0RCeU9jTXkxb2dkV1hiZEhZWVNjZjd6bHBT?=
 =?utf-8?B?ZFRLbnBtdUp1RmcvaDNhUi9FZmo3WnhuSk1kZ0dlQ3B4OFBRNmRrS0dFZnhG?=
 =?utf-8?B?NG40VzhnSEQyL28yZ0VrVk5kdUFBQXhQWDZjNndFQ0JxUkZ2Rm1nM0lOMFho?=
 =?utf-8?B?QkRraEZqdmVBNm15S3JFUzRZVHh2MHZNdXg5OHBTcklyd3UyTFFRMk5sL2tz?=
 =?utf-8?B?U2dGQmFaZDV3bjNzYkMxeUxFVitvRHRlZC9weTJaMW8wOW1YeVVqRXl3Vmpa?=
 =?utf-8?B?V2dMZ1lTRW5nb3JNMFpuVHpKU3dzbVFvaHlHQ0I5dlFERWtldVQ1MDU2b3Fk?=
 =?utf-8?B?SHVYak91c0dOVHVZbEhZNkhHNnlsYndBckJKRjNxRjN0MklhUm80c3lHVUlM?=
 =?utf-8?B?VzNRb2FGV3d1UlZLeFJaMFJ5VU5lZjNsUjMvazVzSHY2aWhydDhsbWVTU1VV?=
 =?utf-8?B?Vk11eENxTHFjVkxpYUV2RkxpUXpWbHRrQklITVhSRGozN24rVTVsNVV6bUMz?=
 =?utf-8?B?b2hUSFFuWlRQcitNKzNNdXl2SitsT0xLUXpBMlZEQUJzbkYrOTl0YjJOc0RM?=
 =?utf-8?B?aFNuVXRQNGVSSlQ1dXREWVlxMEFHQ2docEUzc213MnV6TktJeml4OTVwaVpV?=
 =?utf-8?B?Y3V1T0tnRzVrd0QzVE44NE5KR0k0dkROeTVTaTA5dUg3a3h3L1FCWktEMHFL?=
 =?utf-8?B?aTRody93M1c2L2daUVhwbUpCdHlTZHJBZHlTOHZaSkx3UnNrNUVvcEFEUlJU?=
 =?utf-8?B?cHEycnI1VGRaOFN3d2dvTkpuUWcrNWsrTU5qamcxMEt3VE1lK0RZMjhXUjc5?=
 =?utf-8?B?UHFtb2xIWkNuUmlGNkViSU9rNkh3cUJMZ3pIZElkZUc1RXNiaEpzSDE2eVpr?=
 =?utf-8?B?L2Q1NXBzcjhSK0diNnV0M09GbDB1SXNsN2R2dlZlQWw3Q1FoQ21ETlRTOElO?=
 =?utf-8?B?aHNUQ2p5cTFHYU14NXpWNEZQbjNTSi9wbU1kRXFOMU4rUVVza0pncFg5VVls?=
 =?utf-8?B?cjR1YmFxQjljZWs4bUNBUDFyVkpFZ2NvR2d2ZHEzMWYxcFN1bU9RbGg4MnI5?=
 =?utf-8?B?dlpOTzdoWC9pQi91WkVEUDVTZFVBUVpIeUhZbllocXhZVTNrNm1rd2VyVmNH?=
 =?utf-8?B?QUdWODVGaVhVaWxYTGpFM2FWbytwUXM4TGdJRkNycWk3OE04NzBxMFpodjQ1?=
 =?utf-8?Q?Rl9TmpKlD1U6aWbsbe+7aB5ShOkUDUf9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47343b96-c09b-4b57-c29b-08da06b58a43
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 18:56:40.6764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VkWPCfpa9j/5o6/f/ZOrbDMjYNKSmEfDWKMoMDJGZeguqE/29aSKTck7DOJ0CoGIZUmF1uVsheV96sk9QRj1og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3139
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150111
X-Proofpoint-GUID: c5XWzNYbn6fXuXCHquaAUxHVOEZ_45SJ
X-Proofpoint-ORIG-GUID: c5XWzNYbn6fXuXCHquaAUxHVOEZ_45SJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 3/15/22 10:39 AM, Chuck Lever III wrote:
>
>> On Mar 15, 2022, at 12:26 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>>
>> On 3/15/22 8:02 AM, J. Bruce Fields wrote:
>>> On Fri, Mar 11, 2022 at 06:13:27PM -0800, Dai Ngo wrote:
>>>> Add callout function nfsd4_lm_lock_expired for lm_lock_expired.
>>>> If lock request has conflict with courtesy client then expire the
>>>> courtesy client and return no conflict to caller.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>   fs/nfsd/nfs4state.c | 37 +++++++++++++++++++++++++++++++++++++
>>>>   1 file changed, 37 insertions(+)
>>>>
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index a65d59510681..583ac807e98d 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -6578,10 +6578,47 @@ nfsd4_lm_notify(struct file_lock *fl)
>>>>   	}
>>>>   }
>>>>   +/**
>>>> + * nfsd4_lm_lock_expired - check if lock conflict can be resolved.
>>>> + *
>>>> + * @fl: pointer to file_lock with a potential conflict
>>>> + * Return values:
>>>> + *   %false: real conflict, lock conflict can not be resolved.
>>>> + *   %true: no conflict, lock conflict was resolved.
>>>> + *
>>>> + * Note that this function is called while the flc_lock is held.
>>>> + */
>>>> +static bool
>>>> +nfsd4_lm_lock_expired(struct file_lock *fl)
>>>> +{
>>>> +	struct nfs4_lockowner *lo;
>>>> +	struct nfs4_client *clp;
>>>> +	bool rc = false;
>>>> +
>>>> +	if (!fl)
>>>> +		return false;
>>>> +	lo = (struct nfs4_lockowner *)fl->fl_owner;
>>>> +	clp = lo->lo_owner.so_client;
>>>> +
>>>> +	/* need to sync with courtesy client trying to reconnect */
>>>> +	spin_lock(&clp->cl_cs_lock);
>>>> +	if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags))
>>>> +		rc = true;
>>>> +	else {
>>>> +		if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
>>>> +			set_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags);
>>>> +			rc =  true;
>>>> +		}
>>>> +	}
>>> I'd prefer:
>>>
>>> 	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags))
>>> 		set_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags);
>> we also need to set rc to true here.
>>
>>> 	if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags))
>>> 		rc = true;
>> With v16 we need to check for NFSD4_CLIENT_EXPIRED first then
>> NFSD4_CLIENT_COURTESY because both flags can be set. In the
>> next patch version, we will clear NFSD4_CLIENT_COURTESY when
>> setting NFSD4_CLIENT_EXPIRED so the order of check does not
>> matter.
>>
>>> Same result, but more compact and straightforward, I think.
>> Chuck wants to replace the bits used for courtesy client in
>> cl_flags with a  separate u8 field so it does not have to use
>> bit operation to set/test.
> Code audit suggested there are really only four unique
> combinations of the bit flags that are used.
>
> Plus, taking a spin_lock and using bitops seems like overkill.
>
> The rules for transitioning between the courtesy states are
> straightforward, but need to be done in a critical section.
> So I suggested storing the courtesy state in a lock-protected
> unsigned int instead of using bit flags.

I will try what Chuck suggested.

>
> If we hate it, we can go back to bit flags.

ok.

-Dai


>>>> +	spin_unlock(&clp->cl_cs_lock);
>>>> +	return rc;
>>>> +}
>>>> +
>>>>   static const struct lock_manager_operations nfsd_posix_mng_ops  = {
>>>>   	.lm_notify = nfsd4_lm_notify,
>>>>   	.lm_get_owner = nfsd4_lm_get_owner,
>>>>   	.lm_put_owner = nfsd4_lm_put_owner,
>>>> +	.lm_lock_expired = nfsd4_lm_lock_expired,
>>>>   };
>>>>     static inline void
>>>> -- 
>>>> 2.9.5
> --
> Chuck Lever
>
>
>
