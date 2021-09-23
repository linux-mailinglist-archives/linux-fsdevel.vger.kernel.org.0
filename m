Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF204163E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 19:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbhIWRKt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 13:10:49 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:43502 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242279AbhIWRKq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:10:46 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18NG7Oh6010866;
        Thu, 23 Sep 2021 17:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=reIEX6p1gtIDJZjlRzHXUr8yVZlj7FcWzS0AKiSZxx0=;
 b=MyUhDGZyNKHBUEpOAL5f5fFUKymrtrzOolK4oMBxMMMA6RueTPwbEDIu9l27oqn3lxAK
 zOZg4A62yQqDt/STNACOTO6rgzR6R9o/I7xC+jyfQgr631jsVS2lCHOgotoSkTpy5sVA
 kWOtdrnF8mIOpFuBSJG3Oxtjb4ykdHK/YXoDvUApviA1hX6vQq2Svl3gKtPClZ4M1IpJ
 CyzVRQGKqrDmoRKHJbOOhSuiyxNlLQ0Dv12tIZixeZvpYcbD35ZcqO/vImvhCl6Km+2x
 6Wk+asm5pMFAlK+lxYvj4WZbBn/dVx7zkUDLQNFoo3z6m7w1WUsyPwIYuBOxPuSeUuL0 Ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b8mdbm130-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 17:09:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18NH15XN014379;
        Thu, 23 Sep 2021 17:09:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by aserp3030.oracle.com with ESMTP id 3b7q5e1k4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 17:09:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVbiqu7dKQdAG8PvGOF6zi/h5woJ6oe+gnqrh7yzO0+6ybf6fdJCwBM+GQl5FXRs+SA0oc9dw2cIfVFGzbPwBdFUD6RX8Ii8VAstgetRsuMrrWYekZza50oa3/gBuC4Cw3RvWJj7INnVwmht3Z8J/VLTpSzUWMAGo0L2s3W/BIzFPcvp0YSa9lNRTjeX9ekmrZEr+XTxhfPV1AYwnjqA/clPyIxkVtvFIaNUb9NhKZUG78yPHueFLxaXAjv8gkjS2zFv3XCb95U/uk9hGDZcopPtkmEZf2pS2f/yqjj2dcYU2FXeGli+AjSRM3GBqj4WiZyuaZe5K5NX2LFgr27f6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=reIEX6p1gtIDJZjlRzHXUr8yVZlj7FcWzS0AKiSZxx0=;
 b=lSe1t4kR6d751embz7FHhncFOvsM/pI35J30jQGxPZIqenn9nhE6wxe6Mre2P8RtFhS3zOPyi5Wy2LQdlwnrfa7W249QO0kt+GZKA2QA3/gS9UrGYTCsIemnSEfF9NDG/j0mb1qCltpAAqzf0u0SAAQitSVRxuMOt09uZ77jgoJRbckN+BRDl/s2+00okTAstokJx46BubJYudlOZ5H8Qscafq36sm44L5rWy9ZFNxMphu9kTBqCkGY8SYt9vYFZiuSra190irxQzECxhwkMOWivzjrg1EhsL/VrkWN391s8YkEdzPYjoqmBQ9n1+mI/WXvoFsvQWmm4duaZxmDpQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reIEX6p1gtIDJZjlRzHXUr8yVZlj7FcWzS0AKiSZxx0=;
 b=MjKLpZQ2MzgJFeoIT5goykeo7hb3dP6yJvG/RgURXpRDjxaMCb3S2tbaeoJ4D8jOH+XQ2hJ60jWiYYCaYimAs+dMWs6oyWKAzuASgJC/pw+mePod9qUore7K9B8Lo9rGHrlCj+pBxPlwdCIFMiPzV/BUoxv2Wuyu0ewv05A3lMc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3717.namprd10.prod.outlook.com (2603:10b6:a03:11a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.18; Thu, 23 Sep
 2021 17:09:10 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::1c92:fda3:604:a90d]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::1c92:fda3:604:a90d%7]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 17:09:10 +0000
Subject: Re: [PATCH v3 2/3] nfsd: Initial implementation of NFSv4 Courteous
 Server
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20210916182212.81608-1-dai.ngo@oracle.com>
 <20210916182212.81608-3-dai.ngo@oracle.com>
 <20210922211444.GC22937@fieldses.org>
 <f38c8587-d5db-d07e-6e28-351221be4a69@oracle.com>
 <20210923011824.GD22937@fieldses.org>
From:   dai.ngo@oracle.com
Message-ID: <1ad8214a-636d-6e62-13fe-0ad0a6cf97c3@oracle.com>
Date:   Thu, 23 Sep 2021 10:09:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20210923011824.GD22937@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SA9P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::18) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from dhcp-10-159-135-151.vpn.oracle.com (138.3.200.23) by SA9P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 17:09:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb55cfd4-16a0-4b9c-b51e-08d97eb4dc20
X-MS-TrafficTypeDiagnostic: BYAPR10MB3717:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3717BFA311F38CCFE6C0961287A39@BYAPR10MB3717.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q2Q0BbHWdgu9F0xLMpNg/A1l2IjpVkPqGWaqdQW3spe5GGsO3UnJflTchpNj4Q9Qq8q8PM6ijD8NOCzv1d4oPH7QcsFKxvKqPp76wFdYyEFcwV5O/sePmT9KX9qywVrC/TVCSHI82cM792CxjbeUwbBu3tYqzNAwXfvgi8jGO3U4eIqOiDn5K/NSeIV8mw5aRo32B0XMRSDxZLahdUXG2myCqq/3FspqzXz8ieb0QZwUUjhb6EJY4YjmRSPWYX+A9EQur0B7OjQD5YI01nSt+I4ilERu/swvjYq7VqCLIlBtzRB1d+r208quXsT8niDBDTfruxhk0Zmzc2pg7vw5hB2tBWw8dceWPWFmP7KTZT6FrZ9j24ZVR/1tHmw+MmkSx35zvO6C2i6TtRPHM+PRkR5rt78MtONJRLIlljnWmPxpukABECYwijMDtOJgQmH9qiJtbe82bKrhF5uDTdDRu1eoMijBwBLPBGMQ35ZQNFC1sSV8hD8iuKiy6zNBotpQZMJSv6RP4w7WQIiTg+ToWaKyJcS3IfOcqvg/juErOgbUJqQRtCGpsgE1VXUTekFeSYSwoUL/8ZA0B9cwP4SYGdisB5WYsI5Ab5UEDlbip9YVWHSsXINXtxLbcc/v+BR7w9lh7QZrqZTU7ipf04TdcYIN8jejKyOLNGUp3/g04ebDtKDYX6WLOSKsTNisHWL0CSgam10NTVAUKwGa8KgmRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(86362001)(186003)(2906002)(508600001)(66476007)(66946007)(53546011)(38100700002)(66556008)(36756003)(31696002)(5660300002)(6916009)(31686004)(26005)(2616005)(8676002)(7696005)(956004)(6486002)(8936002)(9686003)(83380400001)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXFQK0lqSjdyWkFBRVE2dXdQcUFSS0RaVnorRGQzZEt2QlgxcWdKaWNPTUsv?=
 =?utf-8?B?TnhnK2pVWHFQcHlVRlNmMXE5TC9JOHh0K2Nqakt6RVFOUmlEVnR4M2dDRGRm?=
 =?utf-8?B?RWNzbzV3eENDMGcvUW5WNUFXNk5HT2FVYWVkZDBMbDVYS1JMc1EvVTJ5Y0lt?=
 =?utf-8?B?QytHTDNCNkkvTXNOYXJxRTkwQnd3ZTJHUzRCY0RMbDZ4M3h3TXJ6dGVaYTA3?=
 =?utf-8?B?MWRVVFdpV0hNYnVPTWw3Wnh6STM4azZxTytLMWttdHRRQmZ4QTZFR0JHMnBN?=
 =?utf-8?B?c0MrRXE1QVpTVFFJK1FtcXdwWUpFbUVoMEUvT2RrM2ZhU3drMGR2ZkwwWWJN?=
 =?utf-8?B?ekxLbHpwY1dyazhZU0ljcWpQZmFFTGpmYWxSNDJNTG5PcnBaaHcwK2ttYTRn?=
 =?utf-8?B?dmUzdFJZM2oyVTgwWWFWbkt3VEc0MjIwRmt4aEh5enNmS2Z3L083dlZTb3BP?=
 =?utf-8?B?VWZubXlzajZyNUE3OURydGVwQXZPWGNjZ1hyWFIyTVRwQ3lxVHYrTzdETnY2?=
 =?utf-8?B?eWprQndrdDF0UU1ydzJYMUk5ZkRDUmMyWGNBckNkbStwblBDcVRBTVFpQWx0?=
 =?utf-8?B?djJEVEpvd2R3bUJCZU11dVVBZGdGaXRDenpDaWUveUpGdkZ6dkR4WTl2Q0Zk?=
 =?utf-8?B?Z1JKUDlPM0FpK3NhTzdBUWYzcXAyTFdmN243Z1VueXUyQVlJUkhIenJTMHlh?=
 =?utf-8?B?bE1OOTdaeGdPRzVabzdyUU1JNnkwZGdkYi90c01wZU9nMUptY21tb01MRzVx?=
 =?utf-8?B?Y3dLYVdPZkhZbmhMZlUrbC92dG8xbElKNG80SUpDaUpYQlRoZnp3SHJuVWF0?=
 =?utf-8?B?THVDOXdzVGZ5bVY5NGpMbDhHQUVQN1BDOVp6SXR1dDFUUitwbXNSWEQ1UFo4?=
 =?utf-8?B?Qnd1UE9IRlI3MHRTcWN4Ulc5NFBoM09CU2hsVkMwYWc2MzFqNmx4UUpTSzll?=
 =?utf-8?B?bElnUUlsd3ltdVV2WWRoSmU2UmJ5ZXlQYzA3a0JsQktuM2p5ckR1b25pNmFU?=
 =?utf-8?B?NnBFMXhpaVRreUdyMWVLQWl5WjNNNEltalJUclFtaGs1YTU1QitmaTBMbStL?=
 =?utf-8?B?RHNsSjVnV3JPOHc0UnhmNmhYUWlET1RKWWllM29LY3RDcEp2ZEVSTk5Ed0gz?=
 =?utf-8?B?NjRxNzF3MW5BZXViUWZ0OVpQSlpiZ1czcDA1VnM4SWg2cDNYVVZ0OEd5SjY1?=
 =?utf-8?B?aEtpVFdUZmFUUmplZ2xoaXNRM3NPaFdRNmlBbURNSGtONWVyczdtWHRZbUVi?=
 =?utf-8?B?bFhzSFJmeTVMeUc5a01RbWg0U0dXUlloYmJzdSsxMTB0MmVvWTFUK2VlS2Nj?=
 =?utf-8?B?anNBYmxkQWhydzltZ0VQcWFFUkpIbDF3b1FlWkhFUkFLSnRlWmpBZU1KVEpT?=
 =?utf-8?B?UGdBV2VuUXJoOUtjRHpBcTlJRFhiVFpyZlhicmpTVXZSUi93QlI5dWFBUFcx?=
 =?utf-8?B?elJHcEpncUZOYldwMVp1dHhvazA2cXRjQVozbS8wNVdydzg2bGFZMy81ejlq?=
 =?utf-8?B?UGgwZzljSmF2bzVIb2xzdmF1YWdxSFMvNjJyclpoSzBPMzQ1bElqekZYMW0z?=
 =?utf-8?B?V0drTGYvaSs2L1crS3liZWJoWmZnTnNxVUJ5Z2ZERDE5eTBpTWlRV3RDZ1JM?=
 =?utf-8?B?bG1mSitsZ0hJL0Jjbm9jby84WGxsUGlyQnN3ekRhcmZ1WlNzaVJ1YkNpeThn?=
 =?utf-8?B?R2EwWStTZWZzSTFBb2tTVHRWVkFRVkhRMUZKTHpqVWhGTjhIbjZ4QUlhWU5p?=
 =?utf-8?Q?iqdXItj1rGz8NONCMlaGXeQ/zgelZnwQg6yLBcX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb55cfd4-16a0-4b9c-b51e-08d97eb4dc20
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 17:09:10.4100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 42I7sWbezAxGL8BGWgguLbbaASllM2fd1TFp7jzfxg0mhjtbEYGz1yQ54z6af/rQ30ho+0BtD1TwZVraDaSe6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3717
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10116 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109230104
X-Proofpoint-ORIG-GUID: qo_FInUVRbI0SUZ2dB1Zih7MNRmSN5OH
X-Proofpoint-GUID: qo_FInUVRbI0SUZ2dB1Zih7MNRmSN5OH
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 9/22/21 6:18 PM, J. Bruce Fields wrote:
> On Wed, Sep 22, 2021 at 03:16:34PM -0700, dai.ngo@oracle.com wrote:
>> On 9/22/21 2:14 PM, J. Bruce Fields wrote:
>>> On Thu, Sep 16, 2021 at 02:22:11PM -0400, Dai Ngo wrote:
>>>> +/*
>>>> + * If the conflict happens due to a NFSv4 request then check for
>>>> + * courtesy client and set rq_conflict_client so that upper layer
>>>> + * can destroy the conflict client and retry the call.
>>>> + */
>>>> +static bool
>>>> +nfsd_check_courtesy_client(struct nfs4_delegation *dp)
>>>> +{
>>>> +	struct svc_rqst *rqst;
>>>> +	struct nfs4_client *clp = dp->dl_recall.cb_clp;
>>>> +	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
>>>> +	bool ret = false;
>>>> +
>>>> +	if (!i_am_nfsd()) {
>>>> +		if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
>>>> +			set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags);
>>>> +			mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
>>>> +			return true;
>>>> +		}
>>>> +		return false;
>>>> +	}
>>>> +	rqst = kthread_data(current);
>>>> +	if (rqst->rq_prog != NFS_PROGRAM || rqst->rq_vers < 4)
>>>> +		return false;
>>>> +	rqst->rq_conflict_client = NULL;
>>>> +
>>>> +	spin_lock(&nn->client_lock);
>>>> +	if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags) &&
>>>> +				!mark_client_expired_locked(clp)) {
>>>> +		rqst->rq_conflict_client = clp;
>>>> +		ret = true;
>>>> +	}
>>>> +	spin_unlock(&nn->client_lock);
>>> Check whether this is safe; I think the flc_lock may be taken inside of
>>> this lock elsewhere, resulting in a potential deadlock?
>>>
>>> rqst doesn't need any locking as it's only being used by this thread, so
>>> it's the client expiration stuff that's the problem, I guess.
>> mark_client_expired_locked needs to acquire cl_lock. I think the lock
>> ordering is ok, client_lock -> cl_lock. nfsd4_exchange_id uses this
>> lock ordering.
> It's flc_lock (see locks.c) that I'm worried about.  I've got a lockdep
> warning here, taking a closer look....
>
> nfsd4_release_lockowner takes clp->cl_lock and then fcl_lock.
>
> Here we're taking fcl_lock and then client_lock.
>
> As you say, elsewhere client_lock is taken and then cl_lock.
>
> So that's the loop, I think.

Thanks Bruce, I see the deadlock. We will need a new approach for this.

-Dai

>
> --b.
