Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD3341533D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 00:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238207AbhIVWSP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 18:18:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:9242 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232149AbhIVWSO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 18:18:14 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MKdJrY006481;
        Wed, 22 Sep 2021 22:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=SJp2RbKEoTj2m3G7Y1zoyuRWGA9W8MFsopX5NQHhWIk=;
 b=rd+E69arWNT3UsKlTwlEWvEpJYh42jkkS4GGR8n3QclDCDAFBlDvxv+VUiHXwATFUH1H
 sQaI+grk1Yw58JxM4miM0RGhC1fXsWMo7cQY90No7c//bF4UPBntzcaTam+qgquwJind
 cfQcgJbjGpYosGXXq1N0f8ELcYj9z98UnZ0tO2bDT3z8KHaFYk9f5t3at6u1UCoZVGbK
 oU+gSOVtw8Br9NUEsDhqQZfLngg2TIoItaDdy1o6xc5YJTDJwrcDK4h6S0eqRytWGJ0f
 mW7y0p5Dhg43f27rK0z8OZfWWiPM/s1jAI/Cs/sGe06XBrKtwbBdBjK3UGeNLF0/ybmT sg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4p7382-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Sep 2021 22:16:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18MMFbYB048486;
        Wed, 22 Sep 2021 22:16:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by userp3030.oracle.com with ESMTP id 3b7q5nmy4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Sep 2021 22:16:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKfEg2Dd/OR4mwrMjbqaifTBkqXtdEbHOBbAFBoZUvUae4D7EVemRs/NHn47+llhIlYIwnqrNqv7XlTGeviXVUwPRPKCiM4tRuoVdGZLW6MV6Qdge51bSow5AgJfAe+YO4LxN2p5frMz2IVe2x7r/84bZs1EYh0I7N1/e9GGitVVorNwvJ3cgFrobK41MzATN+11cxXcBl3lLIzYijYn78vdZJ8asDCBJpaY0vkxPMbr7MlPDjNw1oyytE3bZoz09Vw5KsdeZOUr8iDsI+zUIBxrLBbHTo8BBElg4ny6/KGDsG+hqwR3EAFPX45T98liBR5vZrRgrKO1SNpDSXYTEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=SJp2RbKEoTj2m3G7Y1zoyuRWGA9W8MFsopX5NQHhWIk=;
 b=NccxIsREVc40mTkLRnZFrrDNBZDFLdyg6quEJ4bus1+6rZvhCDrVaFdxT/7qJjm261bNqHqAuvqpz/WAYF+GgCj+XLKZKZBBFC136LEHZZJsY+1TTzXyCtebsKqMgAeeDpczXi79zMPpb4MzYhCOFuxcJYqOBfHm2ZLONOMjEDsluXM79HrZfgnhGoIGvl67Uuqn9HinJRkhgGcuo9G5HI0/wZmu524zUsRW63uGf6IW0im9Ndr9wAznOBz18GW7tyg9v/NPBAFI4kMXGtc+ceMi1kUnWPc98WEfK6UBwVpX8c0QLHYCvYBy83jPDnm86FOLQzNbusR7LAvmqXv1kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJp2RbKEoTj2m3G7Y1zoyuRWGA9W8MFsopX5NQHhWIk=;
 b=fsg4mrrmOZQ7R/kiNs6ANGKeN/IMp5OMySKW6ArOsxq2s6d7+cIwFKAlXhLMS1El1PLD1Qkb7IrmQIoFygKyuFlkbbIEXlgic53fdzL6+vNEiqUqlL3iGw8HO+j6TMFGU1skltrD6Xn8HTN2NxlAKqX2cQVy6NXJuUDizVSQm7A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BY5PR10MB4321.namprd10.prod.outlook.com (2603:10b6:a03:202::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 22 Sep
 2021 22:16:37 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::1c92:fda3:604:a90d]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::1c92:fda3:604:a90d%5]) with mapi id 15.20.4523.020; Wed, 22 Sep 2021
 22:16:36 +0000
Subject: Re: [PATCH v3 2/3] nfsd: Initial implementation of NFSv4 Courteous
 Server
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20210916182212.81608-1-dai.ngo@oracle.com>
 <20210916182212.81608-3-dai.ngo@oracle.com>
 <20210922211444.GC22937@fieldses.org>
From:   dai.ngo@oracle.com
Message-ID: <f38c8587-d5db-d07e-6e28-351221be4a69@oracle.com>
Date:   Wed, 22 Sep 2021 15:16:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20210922211444.GC22937@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SA0PR11CA0024.namprd11.prod.outlook.com
 (2603:10b6:806:d3::29) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from dhcp-10-159-135-151.vpn.oracle.com (138.3.200.23) by SA0PR11CA0024.namprd11.prod.outlook.com (2603:10b6:806:d3::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 22:16:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c80a6bb3-fa41-4f6e-414b-08d97e16a4be
X-MS-TrafficTypeDiagnostic: BY5PR10MB4321:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB43218A754EC5228612F9B9CB87A29@BY5PR10MB4321.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RPvEK3OhZdc8ZQ1V6knUvvztpl9Fs6aCbZ/x5RQXIYTaZL4ow/RAFFwLAE1++94f7U53hPckPxkVbDo0qEnMyMjLEDfYfoKAcIr0+X5Pu2Zr2KMfSu4QbyQP54NlUKxW/avt7qql/siErBl/ASFgdJN5ypWXaPNNObs+yxW7RFlKTeqdlNxuBQJWeQN/P4YaE6chVy8YEz2zCVV5z5RH8CosPZwRSKDb5U8MV8k0wq09W58vqn6s12e8gLR5mTO30rP3UzxLM47U2Y+S6X7dWMfugH2vQes6vhd/uA18LuXiFM32DYmW9LpL0qf21rsHVcnWFk8VyW+AOPNrlf9UgvDbPWlgNWnu36zTJOttsDtc7hRo5gBjHmaaK4Tkjn8S9OgPHS/Iz5KYrMR7vT+O1DKZuv62vQ/Gfj+0pKGTP6AW2AE+xN4dbXZxn1fTzXNlUX7ySuBUW7DreRiKfeoO20XCJHx0v2u0TRZ/31Nvw3hrGaz9X/jdzBnbO1LHned0i9AmOyIMIMRDHxn8xDe63a7vXx5QcQ7oIwIVCVGruylSCAPZTfdx0GkVfH+FBDbqSrBB/orSi6EFEShmBtVKsCDFTPIjq86UGMhtRx9QLrlt6nxuLT2FWe1P6ZDB/yfLbbYKJlWavN4piiiPl5YPKzMRUdcDZmUxCoaEQcQ9ZiEDs6rbgfQONZTI4bR5Q3Jislp4q5pJQWphBQd6R6DD0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7696005)(8676002)(4326008)(31696002)(38100700002)(6916009)(6486002)(186003)(5660300002)(31686004)(956004)(9686003)(86362001)(36756003)(26005)(66946007)(83380400001)(66476007)(2616005)(53546011)(508600001)(2906002)(316002)(66556008)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGNReHVTU1JMdkVqZ2phMDV6bmt1OUVRVmZUaXJvTFF3RFF6a3dyU2E4K1VY?=
 =?utf-8?B?TVN6bTh0ZVJpeE9Da0tIVkhoZ2E4MVNIVUZLZ3BHaytIbDlodXFUYXdkVXph?=
 =?utf-8?B?SU9tN01xdHBsdVVsREdLajl0NVpGNldLMzVMTGJEcTg0bU5OSjArY3U3NU9X?=
 =?utf-8?B?V09GM2szeFNteEhkYk9iTy9IdlFLZUVBbWRvSDNYeEtPd3RidmRyNFprTGgv?=
 =?utf-8?B?ZDVJTFFoZytlY1gwblFVbUp5UnZmN3pLQk9qTndIL3RmUVpQYTNzYWVTcm5u?=
 =?utf-8?B?aG5NeG9jZytoRWEzMXkzOHdIZnE3YlFxR2UwdVBzczd5TTR4am9qWGthbjQv?=
 =?utf-8?B?bHBYQjN0VndSMGJPTmlKd0FtbXQ3V3Mvc3RqQ2FrR1pJMWt6b2VQN3lZR1Bw?=
 =?utf-8?B?SHU5MWJEZUpkQ2FNcERUVEx1N21MWkVCdHZ6SkF6L1pvQjBxWTZiWE55dE9m?=
 =?utf-8?B?aHBOVDYvZDlVcksra3dZM3owS0Jvc1p1S240cmxuRjFjQ1QvMzYrMFhBVXZ6?=
 =?utf-8?B?Z3RoZUlndk1kMlJSRkErakFJL01PYS92bFdPTUkyNkQwVFBTSzdtb2NYZjRK?=
 =?utf-8?B?ZTd2cTdnSExxZUFDMzYrWUNad1JrdllKZjRTVDhsdkFWUlByTDhSMHhGZDVZ?=
 =?utf-8?B?RVE1UitwMkdoK2EwL2hrUUcyc05xbTh0ckxkYlIxc2swMENSYkxmcS9PdE8x?=
 =?utf-8?B?dVBBejdvV0lscFhKZUUxRUFtdnpDWnFrMVJJYlRXNjdUaERRQVVrQlZCVmFB?=
 =?utf-8?B?SEtWc045dHJGUkp0UlFzeFNRSmJ6SVpXTlJobTZZMk16SmFIWkJiRkZvS3Ru?=
 =?utf-8?B?MEZFcGt1Z0ZwUkx5ZzZjaERJbC9naCtrTkhzbVl1dm11Y1RsRVJYU3hucXhv?=
 =?utf-8?B?UGlPUXJmaSt1czkxSVFhUHZvbDY2cGRRRkpWT0dxaVB6cUdUcWYzWkUyVXQr?=
 =?utf-8?B?ZmU5aUpoSCtNT0E1WXNZaFdFWWhSWWIxNEFnWmFiN0dVbFJvNEJlbTBwRmFJ?=
 =?utf-8?B?N0ZvVkV6OFJZa1hJTUxRRENRVkVudGd6eVIvVWZMT211Z09lVjV0UVJxUHFm?=
 =?utf-8?B?L3R1VzRwME5kVk9vNXBnTUt4NmJucnRWbksyU3JZK1NPOXd2cUd4Qlg3VWlo?=
 =?utf-8?B?WVpvbStlckY1YzNBYkhOR25IQkhQd3V5ZmhqUlhERC9idHoyaDlBR290Y0Zi?=
 =?utf-8?B?dFBRMDh2Z0VOelduKzRYaEVMT1FTNFRhcHR1dWtwb0lMTXI3QVJkUHZ5cldr?=
 =?utf-8?B?cXZ1bmI5VXFTeUQ0Ri9tOTlYbWFpaXl5TUlEbGFnZDRFYUNQcGxWRzFNcUFQ?=
 =?utf-8?B?disvcTNqYTdFaGRNN1lOWDI1dVcvbWlqNms3d2xqN1hlbVB6NzVPN0xXNHJN?=
 =?utf-8?B?NjJVUnBFdDN3T2ZVZ2hld05ocW1xbGM2RnhYL2xhSXhyWlZOYm5RMDFKenhi?=
 =?utf-8?B?OE54TTZTS0thT3YrbkZnenVjekd0ME9Ya04zWmlqVklsbU1CSENkVk40ZHZC?=
 =?utf-8?B?bjQzTHZ5NGs1R0w5QmllNGc1UFlUUHBCM05iaS9TbkJ4WG1OaWVXWWNSblR6?=
 =?utf-8?B?ZEVxZ3phckh6Z29VWS9hVzg0dlpVSjZKY3RhVVE3MnRKUlo4NGJPMlo5VUFF?=
 =?utf-8?B?L1FzZHJqYTJBWDl5bGdGaHN4L1V0N2NGM1U2TXQweFlHblpKazJBMmhlbGRv?=
 =?utf-8?B?dW0yczlBV1NIMEJmbnBVbnpMc3FiSVZtRGNFK0xoZWlDajQxN2lVTzlmb3dF?=
 =?utf-8?Q?zFiV8LkKtIxnCiWdwfPyMfpfMbCAewvOuR9Lt8B?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c80a6bb3-fa41-4f6e-414b-08d97e16a4be
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 22:16:36.9660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFcsGiJwxisVebLbjsCPPFjYNPBl9yvHvgAFzMr6wo2TSC8LN6KqCjeqPW+RJf6QjeX+lhTrHcneGB59TFZJ+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4321
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10115 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220143
X-Proofpoint-GUID: MurojGgrQ9ffCGkNsjTfpfLwJEKFPuOx
X-Proofpoint-ORIG-GUID: MurojGgrQ9ffCGkNsjTfpfLwJEKFPuOx
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 9/22/21 2:14 PM, J. Bruce Fields wrote:
> On Thu, Sep 16, 2021 at 02:22:11PM -0400, Dai Ngo wrote:
>> @@ -2389,6 +2395,10 @@ static int client_info_show(struct seq_file *m, void *v)
>>   		seq_puts(m, "status: confirmed\n");
>>   	else
>>   		seq_puts(m, "status: unconfirmed\n");
>> +	seq_printf(m, "courtesy client: %s\n",
>> +		test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags) ? "yes" : "no");
>> +	seq_printf(m, "last renew: %lld secs\n",
> I'd rather keep any units to the left of the colon.  Also, "last renew"
> suggests to me that it's the absolute time of the last renew.  Maybe
> "seconds since last renew:" ?

will fix in v4.

>
>> +		ktime_get_boottime_seconds() - clp->cl_time);
>>   	seq_printf(m, "name: ");
>>   	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
>>   	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
>> @@ -4652,6 +4662,42 @@ static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
>>   	nfsd4_run_cb(&dp->dl_recall);
>>   }
>>   
>> +/*
>> + * If the conflict happens due to a NFSv4 request then check for
>> + * courtesy client and set rq_conflict_client so that upper layer
>> + * can destroy the conflict client and retry the call.
>> + */
>> +static bool
>> +nfsd_check_courtesy_client(struct nfs4_delegation *dp)
>> +{
>> +	struct svc_rqst *rqst;
>> +	struct nfs4_client *clp = dp->dl_recall.cb_clp;
>> +	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
>> +	bool ret = false;
>> +
>> +	if (!i_am_nfsd()) {
>> +		if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
>> +			set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags);
>> +			mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
>> +			return true;
>> +		}
>> +		return false;
>> +	}
>> +	rqst = kthread_data(current);
>> +	if (rqst->rq_prog != NFS_PROGRAM || rqst->rq_vers < 4)
>> +		return false;
>> +	rqst->rq_conflict_client = NULL;
>> +
>> +	spin_lock(&nn->client_lock);
>> +	if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags) &&
>> +				!mark_client_expired_locked(clp)) {
>> +		rqst->rq_conflict_client = clp;
>> +		ret = true;
>> +	}
>> +	spin_unlock(&nn->client_lock);
> Check whether this is safe; I think the flc_lock may be taken inside of
> this lock elsewhere, resulting in a potential deadlock?
>
> rqst doesn't need any locking as it's only being used by this thread, so
> it's the client expiration stuff that's the problem, I guess.

mark_client_expired_locked needs to acquire cl_lock. I think the lock
ordering is ok, client_lock -> cl_lock. nfsd4_exchange_id uses this
lock ordering.

I will submit v4 patch with the fix in client_info_show and also new code
for handling NFSv4 share reservation conflicts with courtesy clients.

Thanks Bruce,

-Dai

>
> --b.
