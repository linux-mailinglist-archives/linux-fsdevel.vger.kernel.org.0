Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674F44E4A2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 01:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240966AbiCWAol (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 20:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiCWAok (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 20:44:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1E73C4B9;
        Tue, 22 Mar 2022 17:43:11 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22MKxkdL010107;
        Wed, 23 Mar 2022 00:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=SlIsVlMk3QRi+A4x+zmNTdK+xCiR/GB+y3YiXT292eU=;
 b=vuvGSCH48UtfHSGsHI8N673A2rlBu4fSIs7t8zww+iX+UrL+FmNt4dlfav3GMoi5pq+6
 45S5ZjlEUa6C0Y4v0XsR80/zqrYb1C8WGSD2rs7JfxA5xWjD3sKm5QkBm8ulXQIReef/
 fTG/TEheW1+TVpwOFPPZmnGcdAi56+bTILmwpwRRXSULczUc/6+KbASwSySeNthneKBu
 xh5NhKzz+rD/WE4xG/868j/DFqxXb1HaTaRmWlVesc/KugcxmyevEcuD+kVSWBy7qvwK
 p8wlWinhVMIDHD2zbL7VlmvsabI7SdIP5T/H8uBf/Duz6jkkmlODl0oSG/G1kZNhKKF4 Hw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew7qt85x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Mar 2022 00:43:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22N0fvPk012197;
        Wed, 23 Mar 2022 00:43:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by userp3030.oracle.com with ESMTP id 3ew49r8bme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Mar 2022 00:43:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oD0YqEAYOfCcJmLP4BRvUlTpo9uGXJjfkK8A93Wmc6u7AOODxCcCXBCEZNSsf8ZId5BHJpEmQleFrCh19KfxZeDei/3kLpSqJNJ/XssXBbpNks15d4bRWqRa1B3IRZqFCZ8LvuNDeGiTa8AHEKVds2L5ZKM09C/nFJ9rMQJbm11HkPwAeQCFSxqnZQtk5JZKDFNMkK5JhYYjR8gzty/I16GRBiA7wcKxsdsumF78fR7uzvUXQBNwpHVlgjFarA2bFDC1ZjujzKmyQeHWsLiNWBxR2iYTUJQ0O7gcyINLiBmgwkQUdtQUoHlY+6FZpqc9w0D2tXgEef66C8PAyS34BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlIsVlMk3QRi+A4x+zmNTdK+xCiR/GB+y3YiXT292eU=;
 b=F3RUcuN1Xkk7I9NIwtuT3BTJsNCAfuCvjY1KMfOEEJLoHgvaZIqrl0oFUbpESQeH/NLl0CF17jBBtnuTgq3nYq8MxryxvfruESiJomP1noHfVwiufuSqZg5BzHXLpRINz2x7tBFPbI/oGeG8O9oTilNH/Y+F0z3UYsLeSIfhRD4vDoxtPOtTzjcFuOvsRTkoA2wVu7FT2wQMzD9QbZD++IW70NlSouuDWAhbwRdiCpuem/t4b1G6S2pyDjNXp2aTIEW/MqalODFn9oAHmS0u1mzIJhC3Hry5oV00Rp9Qlb1D4tdaz2yEocXjTQa/85E/p4mdlwcQtj5nt/Cpmo7Z/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlIsVlMk3QRi+A4x+zmNTdK+xCiR/GB+y3YiXT292eU=;
 b=XmUqArSWldbztAttWsBReCXGlJLb6Jyy/YH8irgGnKs8aFAAh9VBdicTZ7kkLgdcd4RRsCGWh/PPkb51uiaHzY+v29ktEfYFQ3T8iCkz4UuCDI9rIGkY+XQ3oPz1oubImWm/2Yg+2qdRd+K2UwmC2J2tSRf1UWJm0C1OFXYx1IE=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BL0PR10MB2803.namprd10.prod.outlook.com (2603:10b6:208:7f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 23 Mar
 2022 00:43:04 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572%9]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 00:43:04 +0000
Message-ID: <17e69efc-f290-e729-5292-f470780126a5@oracle.com>
Date:   Tue, 22 Mar 2022 17:42:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v17 05/11] NFSD: Update nfs4_get_vfs_file() to handle
 courtesy client
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1647503028-11966-1-git-send-email-dai.ngo@oracle.com>
 <1647503028-11966-6-git-send-email-dai.ngo@oracle.com>
 <20220321214400.GA19715@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220321214400.GA19715@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0010.prod.exchangelabs.com (2603:10b6:805:b6::23)
 To BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4c4b758-48ba-43f9-b67f-08da0c66162a
X-MS-TrafficTypeDiagnostic: BL0PR10MB2803:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB2803B550562420E442C9BBB987189@BL0PR10MB2803.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vcV5qFTuqu/A9nxE4tgEh5WP/zivh2k/qIQTCdIfxfZbgsscvGwEsK+eeONJImrGs2FlN5N/1/KHKcVupC1VPEsAuDzkMGvhIv5Q6oQW51Y3AfeystkUlAcXNSEl/0nZ3VIfbjY7VijZc6YyjRZmiHeCSVGaYqwCTWSxCP6oJjEsvpZI8pnyMjV31uG3fQBr0dWeRnFnNG7zpmHvCfD/sc64Ha8xpmXiQdsgHXMlN6NHd1gGhU/AhVsvZZz7Y6VnumiGok2i61nMQX46ZYB4PQwIBdqoGLeLBKVViqxJiKY9UQkyOT2sqGwRXmYBj46xT+/N+PliVvmvT2pVCBz4+DP8AMVqIcga9QbSLz3Z1R6fP3KbRqq0DwAM7j8qwU/f7BhFT9+h9rOTRYkeTSRUb4Ihv9sD0g79hpSjUNt+gMVT+yX1UQ9KZ8Q7DQ8wJYF/vNzVb5C8pH97CEdvgjf5N5Xmy44Jd0F1FBLX3Qq4vsDP7W2AAz2KWjZ7aozq3U6iWAq4+Ir8v5P5p9B+bj+zcVdr5rF4ZLdICmLn6NiYHpTtXlLDJcMkw1B9u9ZRTsP9eLxxc6R8YFC8aTEghgUnXWRoqgxz/XLh7n/QwJGU49QxIwJr9qodcfNkdcc9WdIOFDLuVXeiJ6Vwao6TRqA6Y793NPJBWHudm1itkKdFVn+YgKSKceZ+z7n7A9a2t8mbJB5ACawGgW7viTz2whWYEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(36756003)(8936002)(15650500001)(6486002)(83380400001)(31686004)(5660300002)(66556008)(26005)(316002)(8676002)(186003)(9686003)(66476007)(4326008)(2906002)(2616005)(6512007)(38100700002)(6506007)(6666004)(66946007)(86362001)(53546011)(31696002)(6916009)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0VMNjdqQmh2SmRhcDF2eVB6SHRBK0xXSmtvOFkweHZXMUJDZXJRSWN3Sm5C?=
 =?utf-8?B?N3ZlaEhnMHhjYmowaUQ2T2pwaWk1NnVYaGVjU3o3a0NMbE5JWEEvK0VCUk55?=
 =?utf-8?B?MFpsMHFYSFc1TGVaY2NKSFRmV2RKbGVKa3pGNkh6RlljZVNHdDJoZ2RBSlNO?=
 =?utf-8?B?T2ppZzVzUmtjL0RVT0ltWHNzKzQ1TXVaZFVLWmJ6OHM5R1NvNm1kSlNrZkRK?=
 =?utf-8?B?QU8yRCtEWExNRmRLbVdTZzNhU09PaWFSWVpZRkpkQkkxeVhWNEZRQVJ4YU0z?=
 =?utf-8?B?L1J3MTZKQUF4dHMrY1NjRUlkemtlbElRanZVcmxWdzNYSk5rTDdWMDBaTEFM?=
 =?utf-8?B?S1VKLzc2ZHZUM1VLMHZ2c3c0TkdBR0JBTFhWTFNVaXFNUXN6TlJUM0ZodHBO?=
 =?utf-8?B?QzlCRlBKalgzNm5pUU9zUThyWU1IMlZxVk44b3Q1cXNRd3FlNWJhbW9oTGV4?=
 =?utf-8?B?enBac0NhaEFqRFVJRE5DNENiMmZ3UElRbFpZZXRJSTFvL3NwdEhQcTBqMDVI?=
 =?utf-8?B?b1JPcXduaFdvbml1RWNvaW15MkF4RnJRR25yWEt1U1JlbklYK1FzaUt0amtm?=
 =?utf-8?B?WmhNYlFzZUQwWjY3ZEhnZFR3NnRaWXNTeTNwc05MWXR5L3I5SWpFWnE5eDRJ?=
 =?utf-8?B?UWExZ3pTY29QSUtxWHRXZ1lPaWdtMk5JVXhYNVRnNFVUY3M3QlhiOUZiamE4?=
 =?utf-8?B?L0FNbzh1MXY4N05GS3pYbFNpeGhublB3NkVLZlhFM2xJQnIwYmNJMTIyUEtx?=
 =?utf-8?B?UkV6YmhVK3hJWGlrQnRldzlDUGpibTdZbTJrNTlZVHczaW9WaC9tZnBLZkE3?=
 =?utf-8?B?R1loYURHYnM4eExpKzMvSHRub3lLQVZGRVluS0pjc1dNOUdteGVoR2Q0RFpy?=
 =?utf-8?B?bC90RHVoSC9FRnRwYy9TUnNvNmpnQ2Niek9adSttQ2Qxa0l1WHZoZEoxZjBo?=
 =?utf-8?B?YXRqMC9QcHFSQ0pUZXh5WnRwWk9VbVNFc29HK1RsZWRiaDl3OWxVV3RjV3RI?=
 =?utf-8?B?SzZZV0UwMjdNVEhjV3RQcHhDbmx6L0hOSERwZEV6WWpyZTllRS9TQWlOdFpa?=
 =?utf-8?B?M01QN2dUR0M3UTdYRUhqWVRDRlBDbmtYWHRuWU51M1cyM0RTNnBFK3M2UUhk?=
 =?utf-8?B?TjdkeVUrcm1RODY4YmhDWi9TNlVWRkh2VkVWMHBXUDNTaEFIM0g2eVdiMWlR?=
 =?utf-8?B?QUVCOFdMZ0I0dTFtQTRITDdNR2hqelAxTEFFa1FVVDJveXVsRGwyYk5veU1X?=
 =?utf-8?B?OG5XaDdjc1doQmZjSE1tYzkxbzRUdUhiL1pqd21xQ2piazdLL1Y0akQ0SVcr?=
 =?utf-8?B?ZWFCQ1RWM2pFNXh1K0lNZC9aWk9FUFowYnBHYjZZanRPaEhrRDlIUlV4QUtq?=
 =?utf-8?B?aVhTV3BQR3BucWtIenZObDEwK2dycWZhS21nTjIrZUdRVTh2S1RUc1BCcUlV?=
 =?utf-8?B?UGplcExCRWtNemVHb2NrZVBjNWRQWnV0amxNb29MNzd1eFd4MnI1SFVOUkxM?=
 =?utf-8?B?bmhBYzcwdlpvc00yN24xYUhiblZKai8wTWFHc29vbzZJMVliZCs2NDV1YVZy?=
 =?utf-8?B?TEV0b2RwYkFMRXdnaXNNMjdCRlpOMnI2TzF2OVhQek1sYk02anZ3YnFJam45?=
 =?utf-8?B?dGhLN3RmeFVNeU9OUGVDVkNHVW1KaVNhRkp3d1NqVmh5UEFiYUxDRnIrdWJV?=
 =?utf-8?B?Z29yK2dSN2FRanZUQlkrUW4vYlhNQ2tIbGd0OERRYUQyc29EQXIzdGtCYk1t?=
 =?utf-8?B?TEJmQVlDcDBUaEhQOHMxUVp0YU5KSGpBV1hDdlRBdDVaMnh3cXQ2YjVOdVh5?=
 =?utf-8?B?UC82cGZwMkpQTHFsNnpneVBVSVAxYTU0aEZZY1BoT2IxOWlqK0kyYXRDeURM?=
 =?utf-8?B?UXFWczVHOTNxWUZLVjcyYi84WE11UmhBVzVMUGhJaERqc3NDMG1hY0hpN3lo?=
 =?utf-8?Q?uCM63Zj4+isqCXyaZBPDOyCFsQ0hUG2u?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c4b758-48ba-43f9-b67f-08da0c66162a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 00:43:04.5547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7+USw/Q/xPItkrSBmCEL94i9l6VbmZ4/TO+HHxGM+HuFDgXzeCTNCICOoyAx37unXVfMJmbpD6B8MhTAw9/qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2803
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10294 signatures=694350
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203230002
X-Proofpoint-GUID: d_lM3THiw1-1jVzOYXSWs7gCAbeIgrqP
X-Proofpoint-ORIG-GUID: d_lM3THiw1-1jVzOYXSWs7gCAbeIgrqP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 3/21/22 2:44 PM, J. Bruce Fields wrote:
> On Thu, Mar 17, 2022 at 12:43:42AM -0700, Dai Ngo wrote:
>> Update nfs4_get_vfs_file and nfs4_upgrade_open to handle share
>> reservation conflict with courtesy client.
>>
>> Update nfs4_get_vfs_file and nfs4_upgrade_open to handle share
>> reservation conflict with courtesy client.
>>
>> When we have deny/access conflict we walk the fi_stateids of the
>> file in question, looking for open stateid and check the deny/access
>> of that stateid against the one from the open request. If there is
>> a conflict then we check if the client that owns that stateid is
>> a courtesy client. If it is then we set the client state to
>> CLIENT_EXPIRED and allow the open request to continue. We have
>> to scan all the stateid's of the file since the conflict can be
>> caused by multiple open stateid's.
>>
>> Client with CLIENT_EXPIRED is expired by the laundromat.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 91 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index f20c75890594..c6b5e05c9c34 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -4950,9 +4950,75 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
>>   	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
>>   }
>>   
>> +static bool
>> +nfs4_check_access_deny_bmap(struct nfs4_ol_stateid *stp, u32 access,
>> +			bool share_access)
>> +{
>> +	if (share_access) {
>> +		if (!stp->st_deny_bmap)
>> +			return false;
>> +
>> +		if ((stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_BOTH)) ||
>> +			(access & NFS4_SHARE_ACCESS_READ &&
>> +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_READ)) ||
>> +			(access & NFS4_SHARE_ACCESS_WRITE &&
>> +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_WRITE))) {
>> +			return true;
>> +		}
>> +		return false;
> Looks like you could do this with just:
>
> 		return share_access & bmap_to_share_mode(stp->st_deny_bmap);

Thanks, this makes it much simpler. Fix in v18.

>
>
>> +	}
>> +	if ((access & NFS4_SHARE_DENY_BOTH) ||
>> +		(access & NFS4_SHARE_DENY_READ &&
>> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_READ)) ||
>> +		(access & NFS4_SHARE_DENY_WRITE &&
>> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_WRITE))) {
>> +		return true;
>> +	}
> Likewise.

Fix in v18.

>
> Also, I think it'd be simpler to check for both access and deny
> conflicts here, instead of just one or the other.

I'm not clear here.

I remove nfs4_check_access_deny_bmap, fold this functionality
into nfs4_resolve_deny_conflicts_locked by making use of
bmap_to_share_mode.
  

>
>> +	return false;
>> +}
>> +
>> +/*
>> + * Check whether courtesy clients have conflicting access
>> + *
>> + * access:  is op_share_access if share_access is true.
>> + *	    Check if access mode, op_share_access, would conflict with
>> + *	    the current deny mode of the file 'fp'.
>> + * access:  is op_share_deny if share_access is false.
>> + *	    Check if the deny mode, op_share_deny, would conflict with
>> + *	    current access of the file 'fp'.
>> + * stp:     skip checking this entry.
>> + * new_stp: normal open, not open upgrade.
>> + *
>> + * Function returns:
>> + *	true   - access/deny mode conflict with normal client.
>> + *	false  - no conflict or conflict with courtesy client(s) is resolved.
>> + */
>> +static bool
>> +nfs4_resolve_deny_conflicts_locked(struct nfs4_file *fp, bool new_stp,
>> +		struct nfs4_ol_stateid *stp, u32 access, bool share_access)
>> +{
>> +	struct nfs4_ol_stateid *st;
>> +	struct nfs4_client *clp;
>> +	bool conflict = false;
>> +
>> +	lockdep_assert_held(&fp->fi_lock);
>> +	list_for_each_entry(st, &fp->fi_stateids, st_perfile) {
>> +		if (st->st_openstp || (st == stp && new_stp) ||
> I'd split this into separate if statements and add a comment at least
> for the st_openstp case, which isn't too obvious:
>
> 		if (st->st_openstp) /* ignore lock stateids */
> 			continue;

Fix in v18.

>
>> +			(!nfs4_check_access_deny_bmap(st,
>> +					access, share_access)))
>> +			continue;
>> +		clp = st->st_stid.sc_client;
>> +		if (nfsd4_expire_courtesy_clnt(clp))
>> +			continue;
>> +		conflict = true;
>> +		break;
>> +	}
>> +	return conflict;
>> +}
>> +
>>   static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>>   		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
>> -		struct nfsd4_open *open)
>> +		struct nfsd4_open *open, bool new_stp)
>>   {
>>   	struct nfsd_file *nf = NULL;
>>   	__be32 status;
>> @@ -4968,15 +5034,29 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>>   	 */
>>   	status = nfs4_file_check_deny(fp, open->op_share_deny);
>>   	if (status != nfs_ok) {
>> -		spin_unlock(&fp->fi_lock);
>> -		goto out;
>> +		if (status != nfserr_share_denied) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>> +		if (nfs4_resolve_deny_conflicts_locked(fp, new_stp,
>> +				stp, open->op_share_deny, false)) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>>   	}
>>   
>>   	/* set access to the file */
>>   	status = nfs4_file_get_access(fp, open->op_share_access);
>>   	if (status != nfs_ok) {
>> -		spin_unlock(&fp->fi_lock);
>> -		goto out;
>> +		if (status != nfserr_share_denied) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>> +		if (nfs4_resolve_deny_conflicts_locked(fp, new_stp,
>> +				stp, open->op_share_access, true)) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>>   	}
>>   
>>   	/* Set access bits in stateid */
>> @@ -5027,7 +5107,7 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp, struct svc_fh *c
>>   	unsigned char old_deny_bmap = stp->st_deny_bmap;
>>   
>>   	if (!test_access(open->op_share_access, stp))
>> -		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open);
>> +		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open, false);
>>   
>>   	/* test and set deny mode */
>>   	spin_lock(&fp->fi_lock);
>> @@ -5036,7 +5116,10 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp, struct svc_fh *c
>>   		set_deny(open->op_share_deny, stp);
>>   		fp->fi_share_deny |=
>>   				(open->op_share_deny & NFS4_SHARE_DENY_BOTH);
>> -	}
>> +	} else if (status == nfserr_share_denied &&
>> +		!nfs4_resolve_deny_conflicts_locked(fp, false, stp,
>> +			open->op_share_deny, false))
> Looks to me like these nfs4_resolve_deny_conflicts_locked() calls could
> go into nfs4_file_check_deny and nfs4_file_get_access instead.

Fix in v18.

-Dai

>
> --b.
>
>> +		status = nfs_ok;
>>   	spin_unlock(&fp->fi_lock);
>>   
>>   	if (status != nfs_ok)
>> @@ -5376,7 +5459,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>>   			goto out;
>>   		}
>>   	} else {
>> -		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
>> +		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
>>   		if (status) {
>>   			stp->st_stid.sc_type = NFS4_CLOSED_STID;
>>   			release_open_stateid(stp);
>> -- 
>> 2.9.5
