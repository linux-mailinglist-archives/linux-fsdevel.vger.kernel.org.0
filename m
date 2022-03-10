Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4D14D408F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 06:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239566AbiCJFK3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 00:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiCJFK1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 00:10:27 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EE212D90B;
        Wed,  9 Mar 2022 21:09:26 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22A13x9W009103;
        Thu, 10 Mar 2022 05:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/0rwON8UesDzZwQRz+D3IssvRBpQUkUMm4PKtRcsM5g=;
 b=QX+Ug8AJD7iM9RhajDygBEEvy95m7toy7FxohlhQikW0YyGLkKtDNiSN3C/ye7SlAy1I
 qIJFt63C8Pr7yF9xkjkE6tVq+fEGrXv1C1drjiCSng51EZL5lFp7qfb5AVz6cpsDM/Lb
 QuC0DXRVe88xgmZdyvM+ucuJnSXat+4fF++6yfnKA8J6qBzvncd4wNTKqgeGGb+SjqkE
 p5yKKYC+bYxZVTBnY4O0fkPIBTKxxVQ0fsSon1f0nxg1W1YooRX2VwXQoV6BQITd0AOc
 HayTI0MRjgp7iix++3XDAuDn++C9Y1jh3VogAytyysSPoeBsvvSNLpHqMjBZKa2IH4bQ Tg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxn2m81j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 05:09:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22A51tsn153464;
        Thu, 10 Mar 2022 05:09:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by aserp3030.oracle.com with ESMTP id 3ekwwd6qk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 05:09:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAhD3ozoniyE/bRH9w4PA0T71BeAV5bVttgPVhyWY7IWpZ+s6ZdGJHZ3bb55FimqTVrPGja0ZYhLU0EAIaYgLc0Z/KQ5cR64E3IR5WRmKzXqpINmvgm6zksQ2RMmcO3E/wGm7nLZ6byR1IDlGJ3uhMdN4krZ8K72QAWg72iEIfngN3XqdVUIEiUjVu+vWRkQbHv9ion2jD4U3KgAqMafU/JqPYAa7YZi0f9GzflIOtJxfOpjfjXJ/JgceoXdMpuaJQ3fF9TRl3Aj4OOkLDXE9EhuIhLApivvH5mdgAlVuuGirw6t7y4CzHY9vHtt5zY1e7Xasyc3mLvxbJh53iO3YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0rwON8UesDzZwQRz+D3IssvRBpQUkUMm4PKtRcsM5g=;
 b=e6CvoKHvoanN+pPBWbXToyRnfK+iDYf3HE+qx2H27bdW8ps5RT9AkwyIK1wOKS4aHA0Z/5kStG4IdyPaHWPelU2MPFjvtLuJZPI5ocCCORnIQ7JVavhu7G0G3pF0w1AbMYzPMJvGpiadL5ZxdKiBbo896Fbsen6sbiEfBDnvxJo4Mv5+y6CNXiOg6i0R1MHk6NqUf/heaL5kgwsOKSZvVJxlV73JJCtbsd4h78hLOAaDCzwcqUgZO2rRBvYFBakXbld/e2xba+pp1gEVYM0JtztW4AKn0XCKUrneKy1RO94kPeoSuE74gu0DXklANUpugCFXltkKhnalv5COzVFdRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0rwON8UesDzZwQRz+D3IssvRBpQUkUMm4PKtRcsM5g=;
 b=BW2QRIvM+H4V5ikW+YQOxJG8vW9shSlvz/IMSbZnn73xHbHMQsMefEqinpPx5fgI60tsx8d6m3YbsYQIkGQREhRD2te2MOj0d9FcYIB1nEngPVbu0NqoeLMJMzMnGOCZVV477CRbsatK/qRDXr73QjoQJ9hSfq0aCJe9S3MQZls=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CO6PR10MB5636.namprd10.prod.outlook.com (2603:10b6:303:14b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 05:09:20 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572%9]) with mapi id 15.20.5061.021; Thu, 10 Mar 2022
 05:09:20 +0000
Message-ID: <efc9edcf-d6ce-e0a1-d00d-e31f6287d6d3@oracle.com>
Date:   Wed, 9 Mar 2022 21:09:17 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH RFC v15 04/11] NFSD: Update nfsd_breaker_owns_lease() to
 handle courtesy clients
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
 <1646440633-3542-5-git-send-email-dai.ngo@oracle.com>
 <541790B3-6B92-4A85-8756-04615222EFF4@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <541790B3-6B92-4A85-8756-04615222EFF4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0131.namprd07.prod.outlook.com
 (2603:10b6:5:330::19) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed3c1273-3c20-4839-cfb7-08da0254222a
X-MS-TrafficTypeDiagnostic: CO6PR10MB5636:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB56363AF86C797610AA614F9D870B9@CO6PR10MB5636.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBrolA5VqeuXU8zuGf+AdBclyCs96dWphrjfTjTP033K8qi7EPDWWfhmMzerlDGT0bLtX1Wq3fgG4lIuobxf3eoJcOy1nutao/pPzNkiZJSM4SA4cixzHa0w3RXw4Nt7sAOesbLyCPgWNAOuAcGxpdLrP+OY2pgAYpBP/FkfTU2P/ieneq6fM7bb4RLiB8MWQ186wEbqDkzfsvgbXqL6+ct7zAN5lPvTPuvjdIa7FxWJEPe/lqrYO4Zh/Dv9T+ZfswdHHm+b/HL2veFSqdP1eb4EKhIK+M08/pY3hBsMcE02H8vBVpwXt8/zs0nb19dG926be9FB3Gpd4103V3pnkyUI75LuMFHE75GnQVM4oEmP5th3+nlhRwctNxgv5KcxXu8ygTC2CkAaNqPqvpENCJIn/z1R8LIPMdBU0R44ygIdSuzE5zQseW59mAmYqpBSo4Yokdk/PXRcEsUAGvH7nTIt1afBUNgtM37W15LL7ZldBYFT7zwxbLWC3fQoyxsSvdbr+73FBcy3Bkt5elx0AU89sE7j8tX4qd/2zdCOJp5Ult56XSXJ4ZtKAAhjo+Fv+3InY3T5+i2idmerbrcNw6CBZWcvkIPXtU7t9h3rHt6LNFdTSY5jbVW3WQ0d4ioQF5ZqHTfTbJhoWgKieotl4Ycp0JDk+nNj/rRRAzEnpeKGHXeFiQpig4SV5y5ueewRcwQbTdOTflsF/1Xe+jeiLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(26005)(186003)(38100700002)(6486002)(2906002)(8676002)(4326008)(6862004)(2616005)(66946007)(66556008)(66476007)(36756003)(83380400001)(31686004)(8936002)(15650500001)(54906003)(5660300002)(37006003)(53546011)(6666004)(508600001)(31696002)(6512007)(6506007)(316002)(9686003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SCtqdmsvL0I1VWw0dGQxM2ZBRlZlSGVkbGs0K1JkUkFESXdkMWI3NHVUTlI2?=
 =?utf-8?B?bFpPZm5xbVJXcmFQOWM0Q3FFekRrbHNsdkFUdmNTWkpIQUJQSGhycXJvUm1R?=
 =?utf-8?B?aGJkQjNhbUR4S2dOU2xMV1k4ajFjN2NWa3ZvYy8rU2U0Njc3ejlTdmdwUHFM?=
 =?utf-8?B?bFdnMFI3YXVIbW11NmNOQlN3TDRLZDBaeFdTNU9PakxvOUZRUEY5bHVPR0xy?=
 =?utf-8?B?MVdsZkZFcEN1dXhZa2FXSHUvN25YdFRXQlZFOEY5eFQrVFlGQkR0cUNUWGNT?=
 =?utf-8?B?YjFCUEpyOVZZME5kNmV6Q21tMGl2dFlsOURFVGpySERiUy9HVE5nZGQ2aGJZ?=
 =?utf-8?B?UnZvOGlhZ0FxWkozTU1lU0Z3ZmsreUJxUDdsZHVOSzdHT2RBbDh4TUhzcThh?=
 =?utf-8?B?bFM0NnZlK3NvWkdOaW0yd0dScWJBbnpSR1puUG52Qy91UzFWalBsallGSEp4?=
 =?utf-8?B?dEhIQ1M3TUlnWjR3SElwaW5KeHUwMGZqbzZFYnJSdDZBcmVGNzNLc1hueDNl?=
 =?utf-8?B?cHhuSmlOMmlsUGpoM2l5NWJ2dWNMRXRySlZFRkd0a2VnVU80bnZLM3dMeVIy?=
 =?utf-8?B?aWU5cjZaOGw2STYyL2svNHN1VkRoUW5yWVprUHFVNzVQZlZkNjJXb3hiZkFa?=
 =?utf-8?B?YlZGSmVMU1ByNCswaC9FN2hvVk9pbXdQajJiYWR2YVVFb0cvUmtCQlV0U0l6?=
 =?utf-8?B?U3NoTVVxZHRuVW9kNnQ0dVVTV3NFOXpnSHZUU1JIVDVScG5UeEZGLzUveE5Z?=
 =?utf-8?B?NE05czRub0xaODlaQlZQNWhZemJhaCtTTUhKQU5yMlhLTC9iY3dLOWZMWnZp?=
 =?utf-8?B?bW9zM0NtVjdGdmt5Q2xtYUZGanNrT1BIVmZZektlcWlzeTJaZUF2SHY4cG90?=
 =?utf-8?B?WWpDOHJqQ2c5YVJOanF2MFlodWpuem1kNU1PaXhJMG1ic2h1eTV4RFU1OHNw?=
 =?utf-8?B?N1VqbS9JY3dRTGdQS1ZsbnpPZ3R2QlU3QVRab2VYc2JLRXBONUtxdjVNbkpM?=
 =?utf-8?B?SmdFbnJSNVovNlNUajVCOStUOWN1cGM4SlY1YlRWSUs1NmliV1FyY1dkWTVr?=
 =?utf-8?B?MU00QUhHQXNJM1RTcTFTOUtnRGNJNXNyUS9Ub3N4RXNYTzZVMUU3RFg4WGF4?=
 =?utf-8?B?MEltOFpuV25WQjc4RnUrNHhxMW8zUGU0TlA1dm9Pd3UvakxodVJUZDczYXl1?=
 =?utf-8?B?TFJnQnNKMzJhUlNrWlhVQ25ZVW11RnUwSlRXT21WR3l2OUVOQ2phL2RiOTkr?=
 =?utf-8?B?T0pnRGZtQW9Ga1Q5aFV2OUpQeW1mMUZ0dmNLYTh4OG0vMWNNVGd3VEYxaERT?=
 =?utf-8?B?VTdiQ2dzVGJmMFE0UlFoSnB4dWJ4R041czR5aDNhWkRab0IyUXFGUlZlTGY0?=
 =?utf-8?B?UmhxTm1pVm9VZkVFMWhVQzRCYWRPTDhibklhUEJSOUk3ZGJZWnFtZ1ZZU1Qw?=
 =?utf-8?B?RnYzQjNJZnlqSnUwcDlLL0ZuVXBML00vaC9PbFRGc21aandjZ0FSUlBlSkt6?=
 =?utf-8?B?VTVmYkd0L1AxUHloR3RDaE5HWGtFLy9DL1FVY3FHRm94S0U3Sld0SW5wK1Zn?=
 =?utf-8?B?a01hb3hqankvamJjYTlkd0NNc291R1JEdFozanI1ZnlPN3c1OEpMOFppQVJ0?=
 =?utf-8?B?Ny9VWDNjaUV1NnVSZFI0S3Y2MExBWno0eWtMYktHYmxneFNXYlhOT3puZkVL?=
 =?utf-8?B?ODhXekJUZEk3S0hTTHlaWTVqQWtpanFHQnBkUTNmSmF0Ymtod2hBcmRETHV5?=
 =?utf-8?B?SUpmUkZ6V0phMWpUbnhnMjZlZ05WemZLZjdOVmRwVVFkUkg1Um9pQTZCK3kw?=
 =?utf-8?B?aHhSOWR2U3JvSm1WL0VRc28xSExYek5JOGplM2lPYW5sOGV4RUhYUWdMUnFY?=
 =?utf-8?B?OE1QbmV4Q1h2NUNXR3Z6Z05nNng2KzV6ay84b3RuMUlzcTV3cDhiME0yY2k4?=
 =?utf-8?Q?/ulpU+tCRBh3Bm2vuZEKn5qR8mBlFXmJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3c1273-3c20-4839-cfb7-08da0254222a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 05:09:20.1960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4D1tmXKUZOi8JUA5qJeLxC+hEcSX29LrpOsoakRaxBns4WImKLHFaEMzkodPcnGTDmm/NRKTRzmUlcpFOLQFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5636
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100025
X-Proofpoint-ORIG-GUID: QjWv30v3Bm3DTBGfurDjPdUNwot3zKDl
X-Proofpoint-GUID: QjWv30v3Bm3DTBGfurDjPdUNwot3zKDl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 3/9/22 1:46 PM, Chuck Lever III wrote:
>
>> On Mar 4, 2022, at 7:37 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Update nfsd_breaker_owns_lease() to handle delegation conflict
>> with courtesy clients. If conflict was caused courtesy client
>> then discard the courtesy client by setting CLIENT_EXPIRED and
>> return conflict resolved. Client with CLIENT_EXPIRED is expired
>> by the laundromat.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/nfs4state.c | 18 ++++++++++++++++++
>> 1 file changed, 18 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 583ac807e98d..40a357fd1a14 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -4727,6 +4727,24 @@ static bool nfsd_breaker_owns_lease(struct file_lock *fl)
>> 	struct svc_rqst *rqst;
>> 	struct nfs4_client *clp;
>>
>> +	clp = dl->dl_stid.sc_client;
>> +	/*
>> +	 * need to sync with courtesy client trying to reconnect using
>> +	 * the cl_cs_lock, nn->client_lock can not be used since this
>> +	 * function is called with the fl_lck held.
>> +	 */
>> +	spin_lock(&clp->cl_cs_lock);
>> +	if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags)) {
>> +		spin_unlock(&clp->cl_cs_lock);
>> +		return true;
>> +	}
>> +	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
>> +		set_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags);
>> +		spin_unlock(&clp->cl_cs_lock);
>> +		return true;
>> +	}
>> +	spin_unlock(&clp->cl_cs_lock);
>> +
> Nit: Please add nfs4_check_and_expire_courtesy_client() in this patch
> instead of in 05/11.

That means nfs4_check_and_expire_courtesy_client is being called
in 05/11 but is not defined in 05/11. Is that ok?

-Dai

>
>
>> 	if (!i_am_nfsd())
>> 		return false;
>> 	rqst = kthread_data(current);
>> -- 
>> 2.9.5
>>
> --
> Chuck Lever
>
>
>
