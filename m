Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71B54D3F89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 04:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbiCJDMf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 22:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbiCJDMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 22:12:34 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B1E7C152;
        Wed,  9 Mar 2022 19:11:34 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22A1VrF5022976;
        Thu, 10 Mar 2022 03:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=uGSiBWGTw1EGtD0t06z7BoLoPfNvotYYBQcXT/XSWog=;
 b=sQyNWvtukootCGXqCd0NJN3b0+tVenOZ18iL6eHbPlsfvvil/9DdGxk+2WSvuStS4fgo
 Q7ysW1Eafaml/iWS7SBxg+3GUAmMevAgx84S79njHAsC36HTL0sjhMAGF+qa7S9fSNnb
 cAh0FOQaygR6MhGOYZPVdNYTtWeUF1NNu28PtIoKwxZSh9Pyfi15t9pHQ4vPV+MygpSn
 LH9dsNdAArN2ZpIVOrR7VmR7gOofvrWoOEiPhGnVaUALZHu5Wgj4NNQDMDUEi0TKlSta
 p5Rvkr0xsIDhvvuYOwOds9+qNKradiixrNprphUX2XEZ54EEGL1ZITRD19gx92fydUrT xQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekyrauetr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 03:11:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22A3AR7Q144057;
        Thu, 10 Mar 2022 03:11:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by userp3030.oracle.com with ESMTP id 3ekvywbtwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 03:11:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYhN3fXqTaQmzfxVybinR8O69vLnrskbXDLqLNpsSZq/G3qFi3RhXAU1GwDm8b73x3/pvX8OXyyZ+YmggyRv28F5qNifsYkXtyEGXp0YrVLnmPZSgI8Eo4Rqf9WYYMexLjWbWqOOAIf9PBLZagOxTwHxtzOG8wjXf/vGYaJWcVu8P+HHDGAtgW7dM3sAETcosrVGzaM87uGc3LMjNg7p7RmdtVBLlwXzfH9GQ+aJnPTlAgvZHj8n2JaxcOCMLFVBMbKsrxjkE/DAbH6hCEFDlGtTMsHOitMGAZvEeNeS5bjQ/8ZLdghZFEQD6zEfru0H29y56txKeTtTyWEq5ZDCeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGSiBWGTw1EGtD0t06z7BoLoPfNvotYYBQcXT/XSWog=;
 b=jcLoao+aKDnzwzU/IztvKyP22E1xN02gADV6MItgtibDriLbe+Hs+rthdfAitnm1nV7J32gOyrvV8ZMfVV5qlMoAFawouynuS45xb9/bPiSS3KxyliX4BN4wBAIXJTcw7Mwh5cH2Bv10bdO8fGNbWzIdDZoKZHpiKyTCRxx57SO1Cl6UYtclaOPuydUv1bDnUzJntK9zCVru3UgrOodZM2EiciJQ91X8n0um3sIvGYzrvpwLDKF4P1vUOHEP4i6qxoPE3j/FoV+3u40KACvPBO97uE7Gjd/ClDjQM1g3hZLThsu9eP0IANnWzGkgSYgEhTVa9SZpJ1f49FYzyT/BUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGSiBWGTw1EGtD0t06z7BoLoPfNvotYYBQcXT/XSWog=;
 b=tK6gmivJd9RD308okSA4v8IA3KurYF2jQ5Mlf71B5ZOa+DpMbAsL1Yyr+16Z5+kjcYqHmDWBOP+UXEslcRc0MOHBuQJgZyhxVuGUsFqy1+ff3kpa8l7fcG55Tk366Nnozzhk5KYGCXQ1px9rE6lSUlJ6nzRSE3dGczCjY46rA2I=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CH2PR10MB4053.namprd10.prod.outlook.com (2603:10b6:610:a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.20; Thu, 10 Mar
 2022 03:11:26 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572%9]) with mapi id 15.20.5061.021; Thu, 10 Mar 2022
 03:11:26 +0000
Message-ID: <cf55f250-a1ba-243c-f826-3cbd91088d6b@oracle.com>
Date:   Wed, 9 Mar 2022 19:11:25 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH RFC v15 01/11] fs/lock: add helper locks_any_blockers to
 check for blockers
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@redhat.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
 <1646440633-3542-2-git-send-email-dai.ngo@oracle.com>
 <AB3847D1-CAD5-4D6F-8D49-C380F2E7AB64@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <AB3847D1-CAD5-4D6F-8D49-C380F2E7AB64@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0203.namprd05.prod.outlook.com
 (2603:10b6:a03:330::28) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 990d8734-d8be-450c-f349-08da0243a9ae
X-MS-TrafficTypeDiagnostic: CH2PR10MB4053:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB40532990446C59A5E62AFF53870B9@CH2PR10MB4053.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UVOCAHa2+YrcuR+SvHPgHGynaHH4RCUteI0z120ahS8VMeg6/Px2CYdxELIOXwYS6MDeXuTcrWBgxtKSCFzcPFXEhQZbXzSnmlUQBAFmPIjxJEsLFB+LLHn4BW/gtjyq7hiXVX56Hslg4D20GdB4rfogVE2sx574FOsOXwy1HO+Jh/516D4eJYVEPZqutjneJlSi1K8Fq7bWrQWBcODVZqPXtAnrRd9av3cNmYlaOibUYqdLyhlvPhNiYsHip8zBggvF59P2IxvS/I1QRPFx4lOVuVacV7SK2suBfeFnPEFNvQfyzoKnDLoYgIln+RZaMhmi1eYlZbqImZ0zuKtud57PZFO1WW8WV8+tAEmvb2Wdsc1LpGR8aolFnLp9I6cpYdrDQl7+KkMAmfFkz0r68Ayyem78n0sqnCKAyVmjqZVnUh99rimI+NNPEIUJttj8g4PtQmEqo0nUxr6ZXXx3IxZRqoXafTI0N0cr+JK/PbganMv4euIaRRR9bLgQkJwJsZFE/MEOCNCFY+KFgeSlqbiArhbxwBf4EUZtgMyF5DZzCwKMA9zSFb7Eu5OhDRT69T/nnXPUaKJOkQgXl3fzpap7S4YZu7XdVKglnvxbA1YXHiztvAnPpb+cIHy8Qxq/58M4L2Tmwl5U0phSM6qW+W4bgE4rPlaL7QeWcv65jToAZLy0iBsk/6kWOnrBvwszc18M5LNezNnAlEXvRkTQqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(4326008)(5660300002)(8936002)(54906003)(110136005)(6486002)(8676002)(66556008)(66476007)(66946007)(316002)(2616005)(26005)(186003)(508600001)(53546011)(6512007)(9686003)(2906002)(6506007)(31686004)(31696002)(36756003)(86362001)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUJqLzNibVFKby9sc0NuYnRTM0lOdTNPNkxLaDFoY05uTENITDc1aUpLMVBz?=
 =?utf-8?B?Q1NCeDVqSjNQc3BZanJzSmNWYXlmYWVVaVBrT1VEU2U1RUJoQzYvZXgyNXJx?=
 =?utf-8?B?TW1pcGxqVm1UcVdpbEIwTWFiYnlTR25QSjNRN3FrZFdXNTBvTlBrKzN1Sy9m?=
 =?utf-8?B?OUVaaXZSN29WMTRaekRXbUZRaFMrdUpsVFZ5VmZGclpPa1h1ZjlpdGR4ZDJC?=
 =?utf-8?B?Wi9rczcyazBjS3JZMUk2Nm5mbE15dWJuOEY0VXZXRnJUTmJXdjNGZ1VTbGhy?=
 =?utf-8?B?SXJxTXZUWHJMc2lBY3NEZFJacmZBQmlyeHJQL2YyeitiOFJoT1ZTekY2aVlC?=
 =?utf-8?B?RU0va1QvMit4bG5HZ3JHdjBrZW5aYk12Z2RGdjdXY0luZXA2NUVqTkVLL3dj?=
 =?utf-8?B?YS9vVlZVK0JSZ3VOQWxqdE1JQ1hRL25VSFVFaVBFQ05aakVVK0N1TFFhT29K?=
 =?utf-8?B?ejN3bytsWEUrT0tkSXZsU0RDbFZyN2Ira043WWNUVlAwSDhxekk3cm9LL3R0?=
 =?utf-8?B?d25KZmd6anJTek9BeEs2dGlSaE5xMVJWV2hqSWNGZ1JyV2RmVVlBYVdLM2I0?=
 =?utf-8?B?WVhjTTJ2c1o1MmNkNXRrOXY3bUZJU0tYMHcwUE5DTENmbHBqU2paY3cweFJ3?=
 =?utf-8?B?YURhSXZTU0Y5REhKQlNtNWJveUhYNktmYk1GWkNJd1R3YnNweFE2aEJndXkv?=
 =?utf-8?B?Y2Rsa3NKVExLL3UwNE1HWWg1eHAyQXZuZktURldPY3lBcTVrOXNuSzA0cm1k?=
 =?utf-8?B?YUIxR2N0ZUU0Sk90RzJ4TEJET0p1bmZKWDlFbExHdVFmbVJjOGJBb09sVkFC?=
 =?utf-8?B?eXlhRlpGYVlMTFpsVWE5anFaRWtJb2pFa0Jmc1ArWWc5b0NEbTRTS090dlZ1?=
 =?utf-8?B?NC9JVUpwR21jaDNDKy8xRGFSL1diWnQ5U2lhZzhSeldUelh5TFppWStWN2xz?=
 =?utf-8?B?NFJ6L2ZYTjl6b29mRE5oZ3hFR3grYU5yc0dhU1dXYzMwb1hadTVlRnhzSWVI?=
 =?utf-8?B?enVpUURZeWtPdXlLV2NRUi9kcW5JWHNRY1VBZlhlMWd4MDFoZk1zc3plenBP?=
 =?utf-8?B?QlRqOU00QitoVGRuRkxkK2JxeHNXczdaRGFpcjNJbEoveTFScmpCQ1hqOFFm?=
 =?utf-8?B?bUJEODJ6NldGZ0Y2Z1ZxUUw4YXlhN3JaMld6ck5EZkJJcS9pNHpXWXc0NTVW?=
 =?utf-8?B?UWZQdkxFMkhDY1IwL0dCL2dZL2JXZ2dsN2J1VFZWeWY3ODFERERLVWVMVFpQ?=
 =?utf-8?B?eTErSW5SOThlVzhhemZMMmMyNlpNV1IzSjcvT21ieGg2Zkp0anRrc3hwVE0w?=
 =?utf-8?B?Si9iVWZIcEluVExWUEFHaGNkek9BREE0eUN4MW5uUXZqcWtJT05vZGlHNDQ3?=
 =?utf-8?B?RnNtY1pOWVJMcjRmbXZUT1U5dXBhYUc3SWo2RCtGK01iVGY2OTE2aHoxVFVr?=
 =?utf-8?B?blZRVThpNWlCSU5JTzM4R0NwUmNhVWtQOHBRajIwdzk0MVRoN1MvZDlmOXNM?=
 =?utf-8?B?RzVnQ2hKZ2RrQ0hOd01Sa0ZoQlJyWS9Xd3dkSnhuZU1lM2wweFpLQzNJbUxG?=
 =?utf-8?B?dk5YUGE3bGRYUzZlZG55M1ZYakpiTkF6SkJKZlhRc3ZwSGlSNDlFWjNabnVR?=
 =?utf-8?B?NlY1WlhCSW53dmRDZ3F2c0ZjWVB2V0ljZ0ZhQXkvZDFWWkQyNzkwT2k3QVNq?=
 =?utf-8?B?N21BK0o2RWdPMklCTXdtRUpRTkJjN1FrMHJuVUYxQk5zVFpsTGI4L2xCdGNO?=
 =?utf-8?B?Mkk1K0dIV2hlQ2VBRXNORFdvUWFqRHdEWm4xL3NOSmtCMDVIU1hiWUNBZ2hj?=
 =?utf-8?B?VitwZWNzOUZVU0JmcVE4U00rQ1gvdzI3WEdORDhCNjE4RmdJbklYcEt6MmxY?=
 =?utf-8?B?Tjl2TU1oejBQRUxWa0htM0wrYnRsWjJEd3dnNERMbmdOQXJTelhsWGZPU0pS?=
 =?utf-8?B?L2xkd0V2WWp3VUFNaWtMeTF4UHlEc3UxalpML3BXRnFZV09zOHIzU08rWTdK?=
 =?utf-8?B?a05UUWdocXd5S1JwN2gxSGdxVk03OXNIK1pJVXRJL29aUVNVUXNWSXBpV1o2?=
 =?utf-8?B?dTdSY0VhY0I3dERmZmp4K0MwWC9aZ2FtN2w2WXkrMXBOWm5HS0VIaEpXSmhy?=
 =?utf-8?B?N2d4SzZrWFE0YVJNN1dudEtlTWI0Z0p6bWtOK3JkUExrS0RKeGJpM1QxK0Zz?=
 =?utf-8?Q?MhtCw40AvsUg0QwoQIcsYz8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 990d8734-d8be-450c-f349-08da0243a9ae
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 03:11:26.0475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uP8U7s4MpasKKGvmux4qqVkZ4BzRhwJe0b9sQEaubmO/IzTMcvzj1xRiVszK6F+vO3TE4RZf3y+ZhEO98VQ7Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4053
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100014
X-Proofpoint-GUID: xI4_4Vvwhya0E1TBRmvkidFG8lT8bmb6
X-Proofpoint-ORIG-GUID: xI4_4Vvwhya0E1TBRmvkidFG8lT8bmb6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/9/22 12:56 PM, Chuck Lever III wrote:
>
>> On Mar 4, 2022, at 7:37 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Add helper locks_any_blockers to check if there is any blockers
>> for a file_lock.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> include/linux/fs.h | 10 ++++++++++
>> 1 file changed, 10 insertions(+)
>>
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 831b20430d6e..7f5756bfcc13 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -1200,6 +1200,11 @@ extern void lease_unregister_notifier(struct notifier_block *);
>> struct files_struct;
>> extern void show_fd_locks(struct seq_file *f,
>> 			 struct file *filp, struct files_struct *files);
>> +
>> +static inline bool locks_has_blockers_locked(struct file_lock *lck)
>> +{
>> +	return !list_empty(&lck->fl_blocked_requests);
>> +}
>> #else /* !CONFIG_FILE_LOCKING */
>> static inline int fcntl_getlk(struct file *file, unsigned int cmd,
>> 			      struct flock __user *user)
>> @@ -1335,6 +1340,11 @@ static inline int lease_modify(struct file_lock *fl, int arg,
>> struct files_struct;
>> static inline void show_fd_locks(struct seq_file *f,
>> 			struct file *filp, struct files_struct *files) {}
>> +
>> +static inline bool locks_has_blockers_locked(struct file_lock *lck)
>> +{
>> +	return false;
>> +}
>> #endif /* !CONFIG_FILE_LOCKING */
>>
>> static inline struct inode *file_inode(const struct file *f)
> Hm. This is not exactly what I had in mind.
>
> In order to be more kABI friendly, fl_blocked_requests should be
> dereferenced only in fs/locks.c. IMO you want to take the inner
> loop in nfs4_lockowner_has_blockers() and make that a function
> that lives in fs/locks.c. Something akin to:
>
> fs/locks.c:
>
> /**
>   * locks_owner_has_blockers - Check for blocking lock requests
>   * @flctx: file lock context
>   * @owner: lock owner
>   *
>   * Return values:
>   *   %true: @ctx has at least one blocker
>   *   %false: @ctx has no blockers
>   */
> bool locks_owner_has_blockers(struct file_lock_context *flctx,
> 			      fl_owner_t owner)
> {
> 	struct file_lock *fl;
>
> 	spin_lock(&flctx->flc_lock);
> 	list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
> 		if (fl->fl_owner != owner)
> 			continue;
> 		if (!list_empty(&fl->fl_blocked_requests)) {
> 			spin_unlock(&flctx->flc_lock);
> 			return true;
> 		}
> 	}
> 	spin_unlock(&flctx->flc_lock);
> 	return false;
> }
> EXPORT_SYMBOL(locks_owner_has_blockers);
>
> As a subsequent clean up (which anyone can do at a later point),
> a similar change could be done to check_for_locks(). This bit of
> code seems to appear in several other filesystems, for example:

I used check_for_locks as reference for locks_owner_has_blockers
so both should be updated to be more kABI friendly as you suggested.
Can I update both in a subsequent cleanup patch? I plan to have
a number of small cleanup up patches for these and also some nits.

Thanks,
-Dai


>
> 7643         inode = locks_inode(nf->nf_file);
> 7644         flctx = inode->i_flctx;
> 7645
> 7646         if (flctx && !list_empty_careful(&flctx->flc_posix)) {
> 7647                 spin_lock(&flctx->flc_lock);
> 7648                 list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
> 7649                         if (fl->fl_owner == (fl_owner_t)lowner) {
> 7650                                 status = true;
> 7651                                 break;
> 7652                         }
> 7653                 }
> 7654                 spin_unlock(&flctx->flc_lock);
> 7655         }
>
>
> --
> Chuck Lever
>
>
>
