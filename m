Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2CC4B1689
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 20:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbiBJTrX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 14:47:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiBJTrW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:47:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D9626DA;
        Thu, 10 Feb 2022 11:47:22 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21AHeb7T013346;
        Thu, 10 Feb 2022 19:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=uW6lAGRexyAE9nSCYbJI7tIpcEfot80FrqQJt7+hSLQ=;
 b=jEvdkyPfJpYsaA1iVe5toGZHc5t/cmvLEyHSXoYPbOqXTNf3ZAM3+MWs4Quw1YN4dW8G
 d9xmwfLrCpRB9mfVixe8mQHFDk82Mdr6622P7DtJMKva75LFB6EWOv7qXoiClthPra6k
 TOpFocYguYkIKebv4wyvGJlirKHFkqKDTsc0sj+nKA5kAbtCUACUz91z1k9kHT6K1hsE
 TkDzVcOSwJxkJPTNAhaOI0/Quf30+4VMruLJWJ0KL0Ph8vHGV9bJa4LWOewbfLwjlpxI
 gr2fc9lYyG9RmymfXpQah3nf2BbOqHgYABn8MOCMH+9yfqEiF4KfP04ZkhkAgpZWbJXs Gg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e368u265e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 19:47:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21AJfuuT130451;
        Thu, 10 Feb 2022 19:47:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3030.oracle.com with ESMTP id 3e1ec5pv0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 19:47:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCajHUOqcqC742UFk/p0UU7CzZdFGe0FBYzeRE/yyb3Q17w5wI7Q7GWvl/N8eK1vYJcpUi4o7SBZCnx3KQ0d6lDpA596Dr10ga8zSonNVd5X9cD70eQGejIni1cpIZBe36jGk1LS1Kv3L9dcE10KN3h+dYZs15tG7AVWKyQPA1C7C5F8fJqb46GfQ+rsOy+YF3lzOymnuSBKVgurXrhIuELLSZIxf+hkHwNxCQl/HMKJSQdaKFZxrKvd+BEc9hr0azifu0teItzbK6qKDwRSpi1SEuopOtR+PX7yOgdZZy5urI6KB3IC4MGMtS+6T8nT3x/PnNZcOnbnRk+pXkScbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uW6lAGRexyAE9nSCYbJI7tIpcEfot80FrqQJt7+hSLQ=;
 b=WBbvVs0C2ZlySN2hXfD2tHRPxFyZ81vUqbcusv1oe7gmb/0piqiZD4HDCLGcbzRFlUo08Pj5xe65G55+4WOPObJuJM+DePGAKcMqZ4dqn47De+hk47kA4Onf/YhMiJqn2enm9/gpZ68MwQbnDwW+eYI9uTkkkG9qDnIsQ5/+Snauu2WiEx6iXJ+yIObaxSqldc4mOYAyhX0SMjiDwbA+t3UYSnMXBy/0H55ey2lA42NYiM3YznsWSgDfrjbvDQq6q0NwcfT1qo62omNrE8SzyehFOimIfJbCSBBAwyyyTBBWALKWPclV0ee1xs4CHDt+vAiFlDaL5tej4kzL7X/o1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uW6lAGRexyAE9nSCYbJI7tIpcEfot80FrqQJt7+hSLQ=;
 b=leJnN+nUIWoqSpr793dHK97HeRFRAypSaMRd5v+P5QeFaRsE90y6e/JRENFXttEUmudYtrNj2pZrgDShfOIiUqBPhBS0xGf96NudLplY/aJrPhnYKqp9yHvTRXAoF7+67pf6p2Qy1cVexGW9RtbNXKjU+vxjcmgnV2o4GTctVgA=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CY4PR10MB1639.namprd10.prod.outlook.com (2603:10b6:910:b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 19:47:14 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::89db:be97:ee10:a192]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::89db:be97:ee10:a192%4]) with mapi id 15.20.4975.014; Thu, 10 Feb 2022
 19:47:14 +0000
Message-ID: <2a150836-d459-86fd-a9f4-b8d3383710af@oracle.com>
Date:   Thu, 10 Feb 2022 11:47:11 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH RFC v12 1/3] fs/lock: add new callback, lm_lock_conflict,
 to lock_manager_operations
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1644468729-30383-1-git-send-email-dai.ngo@oracle.com>
 <1644468729-30383-2-git-send-email-dai.ngo@oracle.com>
 <20220210142826.GD21434@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220210142826.GD21434@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0009.namprd05.prod.outlook.com
 (2603:10b6:803:40::22) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c400679d-5bf4-4ec5-56be-08d9ecce2316
X-MS-TrafficTypeDiagnostic: CY4PR10MB1639:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB16396D00DF12FF579040AAA6872F9@CY4PR10MB1639.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fu/NepRlD0hDtrQw2+CtGgl0YNFSxtS9brNfHKEoDRt1fvDS/+DchQzIWblJeZgyyk0M8BrjkfAYsxzZOnYH0+pNq3AVZwNx8H72AGaixvH2TI3QGizJYk6TR21xrMEz0CnxlFXLqIZ+l4UH1Su8WlqQB7qfsN6vdl/8tJmudM/9stU980MRsQJuGF0XCWAa6xNeX1ej3gCL1TKNSi6wCfYvZr8HAqEWWUuaTtpF5Rmgkj6KJtL3P9ZNneizgnXJeAChKnXw8+r6BlxktapegjbbKO2HH0N0PCOHDVTB2cs9pm0uru3WcqyMtetydYwYIMtpHGUH4yHGIS/8RQDgQxNVcezHciQ3iGvXkoU84w4glQhDh/Ldd6GODqm5PnVoNCS1Tm03jjwG3voLVMUlLxLLIhBYQ31V0aBj5INYxwzqOHxXTGvezK0b+pcIsLh+UUqFJ0IXS9rzPJNT74PU1odbOt79t5sNFM0T/CO/2XdNrsZR4r8IXN3Y/T8N3JT6eo41+H5NZ6kvNo82uTvZ3FdhdiMbzk3rnRb4T0xl0wXgUIOp3vq0jHKW0PHHbkyLpgViHnXVjkA/iUObD5eGakeI3sNZnr2UKS4Tbnk+yETS5LcpN7iCQLLlQRoFoRoN7GxfVzkmP/VGkKdiT4BH0MldWOH3PKX3ky16ckRm7nEio/hDNw5Lztvr616cWzN0jqliDz5IXjyDRRvhedAOrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(66476007)(9686003)(66556008)(53546011)(8936002)(2616005)(66946007)(6916009)(38100700002)(316002)(6512007)(186003)(26005)(31696002)(508600001)(6506007)(5660300002)(6486002)(2906002)(83380400001)(31686004)(86362001)(6666004)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnRNNTlqWWdCS0NQWGpkOXVMVkhyR0QzM3NtYm10bTZYVDlLajkwdDBUR1Q3?=
 =?utf-8?B?US9oMFVjOVNVT1poMjZodmxjZGlqZTNtODdTdmRkQ0psbHBtQi9laXVKN213?=
 =?utf-8?B?N3d6R1N5Y3ArVjMzeWUvcDR6QzduQmlvUHFUWHAxT2JsOWpuNk42bjAxbW5I?=
 =?utf-8?B?b3FjZGIrdDB0UXhrUFRXTW9Jb3BuSG5aMWdZaFJiVm81MWkycTNyV1oyNE9y?=
 =?utf-8?B?VVYxS2Z4N3JDNXBsaWZBemdGTnoxZDgyaWpWTEtTYjdVeWlma0V5NU5oa0Vr?=
 =?utf-8?B?UWxPbTErYW9oaXVPK3JOU3lScmdzQ2taZm9WbDZqUHl6aHVobElIanFRVWE5?=
 =?utf-8?B?cS9JUlRMQUR0SEhJTjFKbFJRdVVWS3JldDlJSEN4SmpCR1BCTjBXUm5jaHpu?=
 =?utf-8?B?ajNzTVJwMU0wWUZHL1ducmVrb2VJNFBVVVFiYi9uSDYxTS9UZkNnQnBsbS9Z?=
 =?utf-8?B?dlJ3MnlhYmNBa3ZvUzZzOVhTK3F5Q0lsdlFoVTE1ZHBRRERFMkZpVXNjcHRs?=
 =?utf-8?B?UkpLY09NZzlmQ2lHUW1YMy9ta0w1UTVHMkZJNURPc2NRL0k0d2FNMndYZWVV?=
 =?utf-8?B?dmxPZlliZEJLOEpVVTE3MmZadG9zUTVqQ1ArbkNia2NtQVh6R2FyQmgzLzVn?=
 =?utf-8?B?d3FiVDNQRTJwWUhVUGsvQ0VYS3dodlFNeTB6cWRKTVJBdjYxVTRGOUp2cXZx?=
 =?utf-8?B?cW1IMjg3RmxUUS9KZjFkS0lwS2oyalkveDhqcGRvdytzM2c4eHYyUFFPUURL?=
 =?utf-8?B?T3RTaFNqYXhYODBGUzlNWEZHVWM5Ny9Gbmw5dVQ2Y1hyQzNrd0NWMmdLeHRq?=
 =?utf-8?B?bnRUcTlqU2ZEd01jaHE0MThYcEhxK0ROdGI4WkFvSUMybk8rSWt2Z3NtNVlo?=
 =?utf-8?B?Y2tlTUlVemVtZ2Zpc2pzSE5BcVVGTWxZamZnK3N6QnNPOXNCcUxod1k4NTcw?=
 =?utf-8?B?Vk9IN3VVV2V6UGxuVkdjUzV2MFlUT09sWWNBck5Dak5ScTZ6WDhFTTE4d3Jh?=
 =?utf-8?B?Z2JUUGJLTmZBTDlhd2dua0tMZ1V1V0hjTzlNVGlobUI3eURhMVNJR0p6Wk1H?=
 =?utf-8?B?RldVMHFKaXY3MTRFLzIxWk1CN2NERkQ3clRrUys3bmIyREJIK1NONnNlUmNs?=
 =?utf-8?B?ZkU2cXRxblF0ZFFvOEJaTXpJRnEyT2YvSWhHY005WVVKTll2ME10RXp2eVJN?=
 =?utf-8?B?UytaR1RUM1MrdFJ6NDRZSVRIVFJUeWk3UklHMjdGVTZlWE90NkZseDRVeGc4?=
 =?utf-8?B?NmxCMVNtbDBvV1FTeGRDVGJsWWFJREdQTDlNM1R1K096cVRBU1ljcDhtbHl5?=
 =?utf-8?B?YmtuakFFcVBMdk95bE5pdUM2VkVwbExENHd6aUZ1MmhsNEFReW1yUWJ6WGFH?=
 =?utf-8?B?YjlCQzN4cEd0SU9aSWV6dm5PWmtjamhnM3N5Mjh4Tk9LUjViM0pXbFJEOS90?=
 =?utf-8?B?TkJxbmRkRXo5T1VPb0VwaVBlTGVsemhTN2ppeHJBT1k4b3lUZ2t4aGEwK3dK?=
 =?utf-8?B?bDVZMlFJV09PbEJWem83cGYwUkprYVBwL0lpbDBlM2RhV0VJTGk1WlpuUEFj?=
 =?utf-8?B?c2w0M2ZFcnhPZ1huelJRbjJlcE1IVjMxTXVaQVl6K0xkQ1hBb3JBOEE0N25m?=
 =?utf-8?B?eVZ1OHloU0lWSjJLWmwrY21QZzA3SGttREQzTitKcjFxeWl1UngwSEdTM1Mv?=
 =?utf-8?B?NnZYNU9sekwxS05DbTFZWHgyZGlyYjJmRTJpUjNtemdQTmpuYTBrT2NxeG1E?=
 =?utf-8?B?VGdEV1M3SFFlVWFubXRrTjh5NDE1cFNHNFNMNWxpcmRnZFVTZEVQcmZaQlVh?=
 =?utf-8?B?dWpwUk1zWWdZR1RYbVlMSHo3R01FWVZxeVRDd0VISDdEK2U0cEExQXNCQkda?=
 =?utf-8?B?T09LOFA3cjlpanFsTkYzQmwzYUxuS0dGZzZDT0l0TVIrMkJncE5tWHU3YWhh?=
 =?utf-8?B?ZE1xYTV3VlN3TmpKMWhyeGZNKzRsb3lWTlh5aG1rd2hkV3UzS1pndEYwK3J3?=
 =?utf-8?B?RzMrcGZ4YWQwVC9IYVVqbFFHb2RnVWVBMENqZ01YYmpNR0RINVplbHBtcC84?=
 =?utf-8?B?ZUtzWWh4Sm9HOXFlck1makd1MzZVMDhzQlJUZzVWTHQ5OXRoNVkrRlAxOVov?=
 =?utf-8?B?TG0wenVYa3ZtU0d2NkgxRVpoeWQ5QlVZTy85QmpDY3lJS2xNQzYyK2RJZVVu?=
 =?utf-8?Q?FqVl8rslxjZwQrFp/GiFS/M=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c400679d-5bf4-4ec5-56be-08d9ecce2316
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 19:47:14.7282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzEW9jfU8f9t1Uzi3gPpOyP0DTqTWyR3cRmIZ5KdlbsQyy0lUPRMz2r6PTKNrgJFoISZ91GOPxzjJltZDumbzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1639
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10254 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202100104
X-Proofpoint-ORIG-GUID: Y4VBMTVelBQKi0izqS2Mfm1nfKUhKrY1
X-Proofpoint-GUID: Y4VBMTVelBQKi0izqS2Mfm1nfKUhKrY1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2/10/22 6:28 AM, J. Bruce Fields wrote:
> On Wed, Feb 09, 2022 at 08:52:07PM -0800, Dai Ngo wrote:
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index bbf812ce89a8..726d0005e32f 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -1068,6 +1068,14 @@ struct lock_manager_operations {
>>   	int (*lm_change)(struct file_lock *, int, struct list_head *);
>>   	void (*lm_setup)(struct file_lock *, void **);
>>   	bool (*lm_breaker_owns_lease)(struct file_lock *);
>> +	/*
>> +	 * This callback function is called after a lock conflict is
>> +	 * detected. This allows the lock manager of the lock that
>> +	 * causes the conflict to see if the conflict can be resolved
>> +	 * somehow. If it can then this callback returns false; the
>> +	 * conflict was resolved, else returns true.
>> +	 */
>> +	bool (*lm_lock_conflict)(struct file_lock *cfl);
>>   };
> I don't love that name.  The function isn't checking for a lock
> conflict--it'd have to know *what* the lock is conflicting with.  It's
> being told whether the lock is still valid.
>
> I'd prefer lm_lock_expired(), with the opposite return values.

Will replace lm_lock_conflict with lm_lock_expired with the opposite
return values: return true if lock was expired (conflict resolved)
else return false.

>
> (Apologies if this has already been woodshedded to death, I haven't been
> following.)

Yes, the name has been changed couples of times :-) hopefully
lm_lock_expired will stick this time.


-Dai

>
> --b.
