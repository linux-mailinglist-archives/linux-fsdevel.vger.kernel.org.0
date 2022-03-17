Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4A54DCCE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 18:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbiCQRwy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 13:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237095AbiCQRwu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 13:52:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C0C21C04D;
        Thu, 17 Mar 2022 10:51:33 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22HGnqTD010838;
        Thu, 17 Mar 2022 17:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gcW5FHoecMYp1+Z8Lz24T+xB3LOjYfEOIEjcGpB6frM=;
 b=C+xFuLGBYIkcSpwT0YYtfqXS9hU6BujrLw3B0ijym+PPKBewSfr8ODjfPS3xsLnmM4EV
 iJ1HUYV5PJotQe0QQuPUN95CgbwpdzIfe9mND4INB9WUibLuWgVUZ3dUL9d+J+sPm9Xn
 +WaekUnfocQaJSaqo9u0gzRjdnWFaaB7ipOvYbzEWZXFFXzRQDddz8uJtFmgB8MLMCEr
 abS1ErZoxXFwYC5k/2L+16E/fisRPlSFUXP67Cvq89ocF219hS4fKr5hiPUT8aESDuju
 PwjNYiOGjqSOcuvEdBV5mLVk9LWSDEv6hMvWVSvkCA0hzOscTMXvyB524lRQwhkX0H00 vQ== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60rhsw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 17:51:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22HHohvE184059;
        Thu, 17 Mar 2022 17:51:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by aserp3030.oracle.com with ESMTP id 3et64u2jfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 17:51:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebMQe8ks9bAv8H2mDkX/QhX/FI/6yp6Ot9ZvRIRnX4aBm95gxEQUnZJDSjgxjtaqyhmdbjFLb4wJwC92Xfq0IC+czOyAurBxvVSSAVvSTeuS+tUbeOUBY5cGaRDEPktVPPd2/x/N4LUOLEFcdlQiCk27NIjPDg1ShoD17Wh/fSWEeQPxWX8r7ZSLS5ffoYJalvRjXLbX3caWfvRG1dC9kqp/V53CA4sNENEkjMBw0O8MILdJ8N0p/Qoiu8s/KZQj80PGTiIqFUHd3iKbO+6lP3QDt6EJxln2C3JcKgPnv/V12uUmZ5tr7OiSWBj+WZ2qkz+Y0xrjVMTQ+VZIcTtPaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcW5FHoecMYp1+Z8Lz24T+xB3LOjYfEOIEjcGpB6frM=;
 b=JpUyqaBdvQV3zIm9tjXVNEGNC03zztiGidkvpgi5bgrcSUMrEUe/TUvcVkuoVDrkECmL8OxDUQkdoq31gYY01xO4Xdl/0u7VaFDE7PtfMelYPlPiFx2FStOzRa47MBXrTnrzPzVzucW43KDWThrRfQFzRiYX0ptRRpNfC7dwaRu+8qV9Yzik4Sosqy3wR0K00IJSa8c1V4Z/V2Haf1M1Z9xEXaolfYt1OwygrJoQqPuiz8ioOEObMOK8E3hydg//cYDXGfdOWUPV6Qgli5CvNM2OpYvu1yoLQn9B3iTri1R5vJ+c/8FUgWE2lySnaTxsUBWEcncRyOybPg7mcsL6Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcW5FHoecMYp1+Z8Lz24T+xB3LOjYfEOIEjcGpB6frM=;
 b=kIWAZrhk6nK60sg0eCQHzb4llBA7PaNdveJMvHSUeXcVVHWYjh6wYNecSw2FhEeVlwUTIcO0Ab3q3uRDatqcR4xX29O+EXSUPXy0EKj5v/92dyqt+235gZLw9GLhQM3Nf3iGNK3nv+UOZV+sVZL2pydVsgstRiu12nmx5TOTWIk=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4510.namprd10.prod.outlook.com (2603:10b6:a03:2d6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Thu, 17 Mar
 2022 17:51:27 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572%9]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 17:51:27 +0000
Message-ID: <902e8785-e5ed-ed72-28b3-1b9bf6866540@oracle.com>
Date:   Thu, 17 Mar 2022 10:51:25 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v17 10/11] NFSD: Update laundromat to handle courtesy
 clients
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1647503028-11966-1-git-send-email-dai.ngo@oracle.com>
 <1647503028-11966-11-git-send-email-dai.ngo@oracle.com>
 <3414885F-7F08-4005-860D-16EC94B106A5@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <3414885F-7F08-4005-860D-16EC94B106A5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::32) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5a4ed86-28fb-4279-429c-08da083ec2ca
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4510:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4510B734CA4CBF0BDE57DAC287129@SJ0PR10MB4510.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7a5Z1tfv2rd8wRJaVTzbe74LhP+KbX7ZvrKJR6d1uPDWRpUkCC+UeL8mMBJ3apjIZFNb+cny1vq3jOriP6MDDdrOu8ADA+CXZJHK4tMrmmNWXiVTPcuNt2gzmhNCtu9g11YewNTuP8sZjP1kOVK4KFGX34EDyJvBIeNCAoFwvUPp+3ZSREJHYRXIhS6Yn0iHaQGBwL+ZHPlsuSBjpMBRdoKIrXAtingy0FDuSyEOiD3aepVdbAlMmlQiQj4M6hhhE+ETAJLX26KTw6tQ10EDzy40EKZ6Il6RaZbFOBD9Ogfe3cLJjwTGb/Y5BEHplVqO3LzaIG67u0YMJ9NpGJ7ApHNJpsn2zA2ctOyw9EzF8hqLU5Tcgrw+tDjGdg5tbZVohNGWayWSSLHpAKDLbBK9WeNWYB4Y7AO/00ACr2RRRXCUj/ltuMeF5CAZ/pkNjaWGfPHboggX3I5w4Th7Pc0bwx6+QVfQbOGYO+K5CkR+uXBqo5ZpwDR6Cp5nIAcxc0tPOrssDfR15kTokkAhgUIfmCyn15DCL89geW0iZMG49PjEmS0+LtkF/4c9JWeK0OIz5O37+hGrt5IjkbjnDTn6TcV3iT7QK3eI5z5zqmhrIWjpYjURFgUcRElogZJ0w7ZPLX4/8T5yEpjlkGFytxOwIi7BSPwUNEy29JpSsq0OmwE70p7bTPZ0bTXvwpVf0k1HB80YIchnMckPlKNowNvPfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(8936002)(6862004)(8676002)(5660300002)(4326008)(66946007)(66476007)(66556008)(2616005)(38100700002)(31686004)(86362001)(83380400001)(54906003)(37006003)(508600001)(6486002)(36756003)(186003)(26005)(6506007)(53546011)(316002)(2906002)(9686003)(6512007)(15650500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFB6ZmJPd3cxeTA0RStNdCtjUDhQNCt3dXlTRVNDMHNiWFU5S0FHQjdqZWlP?=
 =?utf-8?B?MFdRMjJIQ1FYS2QrdmJ4aldwRmpKSzhLMXFYd25yTll1Q3BMQ1hsc2ZIMGti?=
 =?utf-8?B?SXV2eDBqTDF0Q0FvS2xJU3NYdlNocVhDdHE1WWw4QXF5cDdCeFREdUMrOWJi?=
 =?utf-8?B?OXZHaU9qeFFRY1czdHJGWDREMHlWZGRHWGJFMWhXbWwwYnE0Ry9aZVhNb2xy?=
 =?utf-8?B?MGFadnJKSEM1ZmxMRmFOdUZyRjU3aWNiMEZJcG9GSDFvL0NkN3hkTFNLNXpl?=
 =?utf-8?B?bkdwSHF4ZHhsZnpkZFFwOWNkMkRaNitnODRzRU85TGZFQWVTdEEzdGFYaGpo?=
 =?utf-8?B?MXVDQkVENVI1Nk92c3N0MjVmN25ZUDVRbVlOQ285dmNka0VGaXFPTDBRMi8w?=
 =?utf-8?B?MlErL095SEtSaEduUGZaMnlrL1VwSDVCZ01ZSHpDaHJhRzliWnk2bEI0UEQy?=
 =?utf-8?B?NTV5ekJsZW9YMFg1WXBtNUxoa2djN0VDNDJxc3BpcS96bXRwVGNsc1YvS1U1?=
 =?utf-8?B?V2JIbG5lSTNCd0s5MWVkSkRLRHFVclVsT1pQbzVYKzB2S3JCVmdhSXBVaGVy?=
 =?utf-8?B?ZDBGU3BOQnZCSEdudXVrQkJra3R6M1orZzlFRVl0c2RwRWl2NDY0VWl1T2Zr?=
 =?utf-8?B?SGFrdG9URWhpNzdFbjg0VFh5QzhxY2o5VDJSTldPcGlQRmFwYTlYencwdmdL?=
 =?utf-8?B?eFRYdDh5d05BeU1iYzlIV0NoaloybmpXMytLNDRuYk5vSy9sS0xaeTBmSVE1?=
 =?utf-8?B?bCtBamU5ZmdLakJQTUNPcHp3NS9sdHlSaXl1ejdEQVE3NnVwaElhZXpvVVRy?=
 =?utf-8?B?VHVnc3ExTTRZQjNDMkE4aDBnZk80dllUWnFOdW1XMGVGTEdlU1JQeVk5c3Nv?=
 =?utf-8?B?WEdQandNdTJZQnBhNUdOdUxhL3BVV2NybXl6V3FQekNVdmc3eWtKV0I1WWQx?=
 =?utf-8?B?ODUxejd4QjVCUU82YVFTVlQwSXk4NXhxYkY0Q2M5R3EvM1FnUzZVRUt5N3Zu?=
 =?utf-8?B?Tm5TNmFiSUdiRW9tazhqaDExTDhTYXEwT0NXM00vWWNXOVdnMTd5d0hpbjFo?=
 =?utf-8?B?ZWJJMW5tZi9MOVl2UGhKMGJpdjdXUzNrczYvTk9YZVFtRGd1RHVLSWVYVVlZ?=
 =?utf-8?B?blpFa2lLeHk3bFo0MXExTjk2UVhQd3c0STVTNFFqc2VMaWVmR29aZXJ5MzNr?=
 =?utf-8?B?QWNzME1mSjFXa2ZudmZxWWxxc0NKODFSVUFwN0U2VEFiOFd3UTkxcldrcFJl?=
 =?utf-8?B?TGZkdzFNeC9lNjM3Skx3VUN1bDVlbExaSk84bEdUSnhJczVoQmVBdXJyUjd3?=
 =?utf-8?B?Z2RLa2hvTmVsQ1c5ODl3RVRIM3RNVnJ6ZWVkNzBRK0lUL3U5ZXBtQURjb0pn?=
 =?utf-8?B?cG0rR3BtWUtWNlViYkczdXoxYnFmck03R3g5RFRLTWMydGcxTVdwaUdoTGlj?=
 =?utf-8?B?UERYK3V6elVUTS9PaytNTlNObmdJUWkxYjN3Rm5NUFFhQ3VxSmQ3TktERkdG?=
 =?utf-8?B?bXVOaG1VenJuQ3RPWHZEQWZTbDhBS2YzUWcwdHFOTHVNMysvV1JUME1KK2ZI?=
 =?utf-8?B?MHh1R1ZpQ2haMWZVaXcyMCtiVSs0M2lqM1h0MkRnTE9yQWE4NXhTb05IVm1F?=
 =?utf-8?B?WCtDOGxIUDBDNEFlM1hqMFJNYzdKTFJ2ZTgxMVovaDlXSnJheURjcTRXTUNO?=
 =?utf-8?B?b0wzUU1wSnNlNnVaL0lQUVhJUm8vNUoyb2ZUVitpSmptSHBqNk0zQjJNZlJi?=
 =?utf-8?B?S2R5a1h1RWdjZm9BSWFCWHRWb3BzTkZ2M09CaUN1OWJrNWRaTHE3alFhVUlo?=
 =?utf-8?B?RXJRamV1TStSUmtJdkFwazlLK3F3RjQ3STM0bi9scTRrdERVL2JSZmc1Q3BP?=
 =?utf-8?B?OURzN3NoZHptR1Z0QXFJelA3MHpVTnVCZy9raE1rSTdkaWVQQnRkVEFMcXhy?=
 =?utf-8?Q?c0pw0yBsji7ozGaKFojl9pFFllczba4N?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a4ed86-28fb-4279-429c-08da083ec2ca
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 17:51:27.6157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TuNL0P1zjscpPjL6hG9gSREFl/OnfJyfJAIdADhAy4W4KC1k1XcA+WxbMa6tLeD6JXUQPVYynVGsxE83wpB4aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4510
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10289 signatures=693715
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203170100
X-Proofpoint-GUID: NihfPFPgLSitQFU5ker85oQyHwGFLeyj
X-Proofpoint-ORIG-GUID: NihfPFPgLSitQFU5ker85oQyHwGFLeyj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 3/17/22 8:03 AM, Chuck Lever III wrote:
>
>> On Mar 17, 2022, at 3:43 AM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Add nfs4_anylock_blocker and nfs4_lockowner_has_blockers to check
>> if an expired client has any lock blockers
>>
>> Update nfs4_get_client_reaplist to:
>> . add courtesy client in CLIENT_EXPIRED state to reaplist.
>> . detect if expired client still has state and no blockers then
>>    transit it to courtesy client by setting CLIENT_COURTESY state
>>    and removing the client record.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/nfs4state.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>> 1 file changed, 91 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index b4b976e00ce6..d5758c7101dc 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -5755,24 +5755,106 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
>> }
>> #endif
>>
>> +/* Check if any lock belonging to this lockowner has any blockers */
>> +static bool
>> +nfs4_lockowner_has_blockers(struct nfs4_lockowner *lo)
>> +{
>> +	struct file_lock_context *ctx;
>> +	struct nfs4_ol_stateid *stp;
>> +	struct nfs4_file *nf;
>> +
>> +	list_for_each_entry(stp, &lo->lo_owner.so_stateids, st_perstateowner) {
>> +		nf = stp->st_stid.sc_file;
>> +		ctx = nf->fi_inode->i_flctx;
>> +		if (!ctx)
>> +			continue;
>> +		if (locks_owner_has_blockers(ctx, lo))
>> +			return true;
>> +	}
>> +	return false;
>> +}
>> +
>> +static bool
>> +nfs4_anylock_blockers(struct nfs4_client *clp)
>> +{
>> +	int i;
>> +	struct nfs4_stateowner *so;
>> +	struct nfs4_lockowner *lo;
>> +
>> +	spin_lock(&clp->cl_lock);
>> +	for (i = 0; i < OWNER_HASH_SIZE; i++) {
>> +		list_for_each_entry(so, &clp->cl_ownerstr_hashtbl[i],
>> +				so_strhash) {
>> +			if (so->so_is_open_owner)
>> +				continue;
>> +			lo = lockowner(so);
>> +			if (nfs4_lockowner_has_blockers(lo)) {
>> +				spin_unlock(&clp->cl_lock);
>> +				return true;
>> +			}
>> +		}
>> +	}
>> +	spin_unlock(&clp->cl_lock);
>> +	return false;
>> +}
>> +
>> static void
>> nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
>> 				struct laundry_time *lt)
>> {
>> 	struct list_head *pos, *next;
>> 	struct nfs4_client *clp;
>> +	bool cour;
>> +	struct list_head cslist;
>>
>> 	INIT_LIST_HEAD(reaplist);
>> +	INIT_LIST_HEAD(&cslist);
>> 	spin_lock(&nn->client_lock);
>> 	list_for_each_safe(pos, next, &nn->client_lru) {
>> 		clp = list_entry(pos, struct nfs4_client, cl_lru);
>> 		if (!state_expired(lt, clp->cl_time))
>> 			break;
>> -		if (mark_client_expired_locked(clp))
>> +
>> +		if (!client_has_state(clp))
>> +			goto exp_client;
>> +
>> +		if (clp->cl_cs_client_state == NFSD4_CLIENT_EXPIRED)
>> +			goto exp_client;
>> +		cour = (clp->cl_cs_client_state == NFSD4_CLIENT_COURTESY);
> I've forgotten: why don't you need to hold clp->cl_cs_lock while
> checking cs_client_state here?

The CLIENT_EXPIRED can be set when either the client is reconnecting
or when a thread tries to resolve the conflict with the courtesy
client. The reconnecting client and the laundromat are synced by
nn->client_lock. For thread that tries to resolve conflict and set
CLIENT_EXPIRED, if the laundromat misses detecting CLIENT_EXPIRED
then it will get it the next time it runs.

The CLIENT_COURTESY state is only set by the laundromat so there is
no need for any lock when checking it here.

-Dai

>
>
>> +		if (cour && ktime_get_boottime_seconds() >=
>> +				(clp->cl_time + NFSD_COURTESY_CLIENT_TIMEOUT))
>> +			goto exp_client;
>> +		if (nfs4_anylock_blockers(clp)) {
>> +exp_client:
>> +			if (mark_client_expired_locked(clp))
>> +				continue;
>> +			list_add(&clp->cl_lru, reaplist);
>> 			continue;
>> -		list_add(&clp->cl_lru, reaplist);
>> +		}
>> +		if (!cour) {
>> +			spin_lock(&clp->cl_cs_lock);
>> +			clp->cl_cs_client_state = NFSD4_CLIENT_COURTESY;
>> +			spin_unlock(&clp->cl_cs_lock);
>> +			list_add(&clp->cl_cs_list, &cslist);
>> +		}
>> 	}
>> 	spin_unlock(&nn->client_lock);
>> +
>> +	while (!list_empty(&cslist)) {
>> +		clp = list_first_entry(&cslist, struct nfs4_client, cl_cs_list);
>> +		list_del_init(&clp->cl_cs_list);
>> +		spin_lock(&clp->cl_cs_lock);
>> +		/*
>> +		 * Client might have re-connected. Make sure it's
>> +		 * still in courtesy state before removing its record.
>> +		 */
>> +		if (clp->cl_cs_client_state != NFSD4_CLIENT_COURTESY) {
>> +			spin_unlock(&clp->cl_cs_lock);
>> +			continue;
>> +		}
>> +		spin_unlock(&clp->cl_cs_lock);
>> +		nfsd4_client_record_remove(clp);
>> +	}
>> }
>>
>> static time64_t
>> @@ -5818,6 +5900,13 @@ nfs4_laundromat(struct nfsd_net *nn)
>> 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
>> 		if (!state_expired(&lt, dp->dl_time))
>> 			break;
>> +		spin_lock(&clp->cl_cs_lock);
>> +		if (clp->cl_cs_client_state == NFSD4_CLIENT_COURTESY) {
>> +			clp->cl_cs_client_state = NFSD4_CLIENT_EXPIRED;
>> +			spin_unlock(&clp->cl_cs_lock);
>> +			continue;
>> +		}
>> +		spin_unlock(&clp->cl_cs_lock);
>> 		WARN_ON(!unhash_delegation_locked(dp));
>> 		list_add(&dp->dl_recall_lru, &reaplist);
>> 	}
>> -- 
>> 2.9.5
>>
> --
> Chuck Lever
>
>
>
