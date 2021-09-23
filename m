Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48674163E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 19:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242457AbhIWRLS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 13:11:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37902 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242468AbhIWRLO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:11:14 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18NH7ZvT010873;
        Thu, 23 Sep 2021 17:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=QKzMyB1ET92hK0ZWEkC6FgKbouxVHlL4/EoB0UD9xZE=;
 b=Nb6RgtFcladaUHeTCVrVPj3Pa3UiPqdt50jJBEN7wm6iTnAqGKIgIkn1lc9jtPyuTfeY
 6lTi6MKfxGk0IN7UhF49RSQjGTNjxLp+wPonPcukD3O6wa2qGRVYiMhs1wAx8xrv2T0r
 GN9iqtOhfdIoNwP7b5e1B6t4SGCeJJonRSXYC9rhkDL2p4dbO6wk14fTzGyEqdMbsVXM
 DIuSGdnP75095ihbdffMzOvH5PyMYMuy1uUdW/ySvO+VjWLoQOFB3tbORcLlf031ueGj
 cmx2slT2gxwRGjcBRg4i/7+CZkLJwzb9PWn1sG46WXImUZmAgMLbRgHivRQrNcJnnsu8 Dg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b8mdbm164-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 17:09:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18NH15Xn014379;
        Thu, 23 Sep 2021 17:09:40 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2040.outbound.protection.outlook.com [104.47.56.40])
        by aserp3030.oracle.com with ESMTP id 3b7q5e1kvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 17:09:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8F/hhgF7/QoXiTnND5ACexJYZtx2KktVLY3xt5/269cioqvjV9yOzC9qDBA6Cp57yj9q9UIdOMV/745yOt2tzeUnkJvQAfYrEkwT6TpSzQIY1siP7h93WCcHSLwO6KkGISA6Yh9ddUZOExJCCpJjsvChWo9WrTPP+RGjZF8D6eMflxdGAm0LSy56PHQ5DjCN1haqcmFqpOqHGjtbj3WeQh6/KrH6ER7NsrDYjuLalBTapwHeiiMNGUmv+pCbErN0+FKR1Kzm7WnfvG43wDDHikG13IBDEhGPlKBBqVUrvexpC/JTywQ+Q9wpSPyGY9OcmyK1C9CtPLs8QlZxtpQLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QKzMyB1ET92hK0ZWEkC6FgKbouxVHlL4/EoB0UD9xZE=;
 b=L8yJpR/u5vVPXac3az4Fuz9GSonsppqWZKZ55r69VGMUTJf7EGkYtVD80DqvaoAyWQpWTsfTkfcVwszISUUfPUY3NqxwOVfR2ifpRJagIJ+kiKdvY7cG2oozYa9nEDlBBp4qlwSolH1CSd+jdRNBZgbN9JUS6E6ekYA63ZGK5x/mORdgfYi/gJsI48MVoTsha3Z0u1HdTS9xK2jSgAFvdqucjKWAZa1do2dx3mmDF4ZchgJd8cYf/zN4RIrcdIrZfGRylxn9j0vir1uzaEek4YcQjlN3CfS7ggAI/ouoGnd8fKOWZUJcF6WHgpR7/WVhAtn/ZZjhs7TWsY0/ZXze9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKzMyB1ET92hK0ZWEkC6FgKbouxVHlL4/EoB0UD9xZE=;
 b=YogLmXJF/OJYGY4igg3WvMDR43Wv+R//jmAs707qaBn0TCEiAQbazwwwhnZgUQOo4/gvDbQbuYyJBj08zOpFChRX/Uy9U65qdVF2Vn85XL+vLI6NaiAExNDKchk4Soal5CF8KJ+ptVrHdvzqlBz7wZA/Tm8Qk0OzK17yGLz3bYg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB4085.namprd10.prod.outlook.com (2603:10b6:a03:11f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 17:09:38 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::1c92:fda3:604:a90d]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::1c92:fda3:604:a90d%7]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 17:09:38 +0000
Subject: Re: [PATCH v3 2/3] nfsd: Initial implementation of NFSv4 Courteous
 Server
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20210916182212.81608-1-dai.ngo@oracle.com>
 <20210916182212.81608-3-dai.ngo@oracle.com>
 <20210923013458.GE22937@fieldses.org>
From:   dai.ngo@oracle.com
Message-ID: <9e33d9b7-5947-488d-343f-80c86a27fd84@oracle.com>
Date:   Thu, 23 Sep 2021 10:09:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20210923013458.GE22937@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SA9P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::13) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from dhcp-10-159-135-151.vpn.oracle.com (138.3.200.23) by SA9P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 17:09:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e92beccb-930a-494d-ed12-08d97eb4ecec
X-MS-TrafficTypeDiagnostic: BYAPR10MB4085:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB4085488ED1328331A62F876087A39@BYAPR10MB4085.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ktc9+ipVygb8/uIRO/q4T0dSvzPO+k+mczVPbHw4cZf3Tr3ZcoB0HeoavFYX+kosQCxMqiNTEMO6vgXTL7XoBRpsQrraLGQRiKgG+UMGmnWYRj5HDtQEVf6HXG6ST6R0UFcBVZSEb8EA1LTy6VegmCr+2SVUP1/O8CLIznlNdEfBjnNbKfOa69DTsTs2cIKbSsAN81ZlVjFcXJoyDjmx2Ml5RQBy5HK5az5wi0lt312uVlAYiqDQVKizq+gZ6umsVPwhj8fjwnFmrCGAyf/73JteDfLG8MhWmPNPv17nZ6kXyz0fXbs/o98uwJeN33wvbvtxlPHaA3bGiDi08cID632Sx06UpJMOkK1tJ4nUDCWIbIH7hLFQLtI5xY9KittX/P1UdYiEJm6Eq9lQ6uMWpXqkuTeRceBFKsAfTNXa1g6QxCvv86+Gxh+k/pcP8eNHyLRztok0kxyCWsJT8uCBMgyAniwYlTpRdA0xEp1Zv15o0MR3p3T54lTkUb2mB09F4T2j8R9Jea1ClTDtqJ7iGN4NYW5XBpfKmiCQXTkSCBACvu9rpgSt2AB8HDqRF84dRtiKb2f78twpxOmdPI24X7vmHzH3OYo1nCBWkDlwBKjJ+imF14I9nwEnDXcbSU0nZKMC/3Mo9DPboHTEKyi54qUCj7PgQ5CxrUzjutSoz10Gmr3Gut7aPtVnwlcpH2NVAZqP0oIO3Tg4V38yypEzwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(2616005)(31686004)(4326008)(956004)(38100700002)(26005)(316002)(6486002)(8676002)(66556008)(66476007)(508600001)(66946007)(53546011)(31696002)(2906002)(8936002)(86362001)(7696005)(36756003)(6916009)(83380400001)(186003)(9686003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TS8xbDV1V2xJelpKQ3JkS2NnRGxqRU9pWnUwMmxEM09NT3BveEl6c3p2UUgz?=
 =?utf-8?B?ZGkyZGdBNlBuODFxZ3pLSlFieHZvQXJtc0xUc21FWDYwdC9IRzRieEl1aS9Y?=
 =?utf-8?B?Uld5Z1I2TUQ5MnJMSWRWSGttVGpiTHd2Wm41b3I0clN2SFdOR1RVdlgxdUFl?=
 =?utf-8?B?c2pTODIrVXhRYkFoU1BON1UzZHA4Y0o1WFhRTjVPU01kbUhrakFMSStiNElj?=
 =?utf-8?B?TlRxMG54Sm9YLzNkc2xUZXcza1VBMW0rOVpHcjlLVWQvd2k5aFNvN1ZXUGNx?=
 =?utf-8?B?U3FtalpReTJpRzcvZjdTd1VsMGovZ1V4U3hRUmY4WjcrcXVvdTRBT2hIN1NQ?=
 =?utf-8?B?Vkh2aEYwTzE5OXRzNXlLYUVaaVFvRUI3VDNLOVNPRHFFVVdWTkVKb2FweEFr?=
 =?utf-8?B?OFM2OHZNSFhXS1BER3VsZHVnQmdYZ0Fmdm9PZHJMNkN3dmhjeWpOL1AzY0tV?=
 =?utf-8?B?L254NUZOQ2NXN2dvb3lUdUJrUHJCVExIUDJVOW5BRk1Wci9hdUFiSmh0WS9P?=
 =?utf-8?B?UFNuK3EwWmNVdnBHdDJnSEVFRFlPMGZQMEFZazhVUTBYNlpoRGdjaTl2ZEU0?=
 =?utf-8?B?SWxjTkN5dzBxRDZ6MXFQK2VhVHI2WkVTdWFDZGM0QkltMFgyT2dQb3dReS9S?=
 =?utf-8?B?R1lsV1pNelpEaGxXMXEzSWYzS0lSMmFwL3lxa1BBeWFvQWQwWXpFY3RNbCtH?=
 =?utf-8?B?ME92TmhOcHF4S2xsZ255TGN3aDdpSVFBc3NmcDlUTmErZWpVbmZoalVnQ2x0?=
 =?utf-8?B?WHFUK2pmREgwSVFRb2NkZ3A3N2MrdktNZDZaWVE0L1ZwMHU5UitlM2ZUSE1B?=
 =?utf-8?B?T3NaWUZJMVg5c2x3dVlqMkJNMWx0dDdLSmxxSHNpV3IvMldBaVhzSit6U1Fx?=
 =?utf-8?B?aHp0ekNUc2JISHRac2RIZDhlazN4U05LSDgwRU4zMDZNMmp6UGVkUzJ3VXd1?=
 =?utf-8?B?OWdxd01oaEYxZ2RnN2tlcU1HT2N5WlU5VzB6dXRaeE1Oc0VTb2ZYc0ZDSU8z?=
 =?utf-8?B?NURlOWUzY0RqQ3VXYjdkay9acExFcWNlUnpkVjBHQWJoT0xmL2YyT1VNNTlH?=
 =?utf-8?B?dWovWldra2ZTS2JQRE1Eb1FSQndGTC9rUFQvenpLTlRwTmRhaUJYQUppVkV0?=
 =?utf-8?B?UUlUSHFENTljb09iTTBEWjJJK2RGUVFJQ1AvdU1IM2JNdUVWc1YzWXZSeGtE?=
 =?utf-8?B?RG9ab2htSitYTXZjTS9ENzE5L3lOV0ZEc2JJVzVKTVdoZ0Y0ZVBjaTh4YkxD?=
 =?utf-8?B?dDBXc3BhdHVrRnI0OGpLeHRJRlNVRXBya2xoaDdwYyswRjFXTEZYbVZLcmhk?=
 =?utf-8?B?TUJ0ZEEyR0VZVDltZzZseTF3OVBweVNMYWJ5UlpaYzVyaWE5dW1hb0kwRlN2?=
 =?utf-8?B?VGFydmNzSjdqUFV4dUJLaUlUZTNFSG1sSUF5ZTl0bVI3TWN1VStYR2tUVVlm?=
 =?utf-8?B?OWNOWWk3OUcwTVJReDdFSndFdENuMTVpakYzSVBOc2dnTUhQWGdxZlNCMHVo?=
 =?utf-8?B?a1V6akltbi9GejRoN2kzdk81S1g4Z0RDVHFhWXYvVythd3VVbERPUHRzZVAv?=
 =?utf-8?B?U3lidXVHMkNPNkI4dHRrUGFjZ0NSeTJKRWxZMGJybnh0UUlUVjVvUHlhMXZp?=
 =?utf-8?B?WlMrVG9xaWVwNDVQY082ZnZnS2JmTmpHSEU5UzJ5elh5c2ZkZy9sRWNEN0dR?=
 =?utf-8?B?SWp5b0VBdU5JbCsvZm9UYWpJVUNpTmRnTDJDS254YUU5bml3Yk1JdFdNeEps?=
 =?utf-8?Q?1rUXQjb3CTItmaHEq806CChq1SDi0P2fJ8mrBvF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e92beccb-930a-494d-ed12-08d97eb4ecec
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 17:09:38.5232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84vVdeIKE8QX9my7TXaKbXakBQkrHc7eDjw/qkBfplzEFDOAZTdxBBy3mCI6PX7I5fwL0oK1ewCVAzrD57l8zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB4085
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10116 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109230104
X-Proofpoint-ORIG-GUID: jTbFOcbmDOAJRO6l1gKV1iGtadVYEZ9D
X-Proofpoint-GUID: jTbFOcbmDOAJRO6l1gKV1iGtadVYEZ9D
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/22/21 6:34 PM, J. Bruce Fields wrote:
> On Thu, Sep 16, 2021 at 02:22:11PM -0400, Dai Ngo wrote:
>> +/*
>> + * If the conflict happens due to a NFSv4 request then check for
>> + * courtesy client and set rq_conflict_client so that upper layer
>> + * can destroy the conflict client and retry the call.
>> + */
> I think we need a different approach.

I think nfsd_check_courtesy_client is used to handle conflict with
delegation. So instead of using rq_conflict_client to let the caller
knows and destroy the courtesy client as the current patch does, we
can ask the laundromat thread to do the destroy. In that case,
nfs4_get_vfs_file in nfsd4_process_open2 will either return no error
since the the laufromat destroyed the courtesy client or it gets
get nfserr_jukebox which causes the NFS client to retry. By the time
the retry comes the courtesy client should already be destroyed.

>   Wouldn't we need to take a
> reference on clp when we assign to rq_conflict_client?

we won't need rq_conflict_client with the new approach.

>
> What happens if there are multiple leases found in the loop in
> __break_lease?

this should no longer be a problem also.

>
> It doesn't seem right that we'd need to treat the case where nfsd is the
> breaker differently the case where it's another process.
>
> I'm not sure what to suggest instead, though....  Maybe as with locks we
> need two separate callbacks, one that tests whether there's a courtesy
> client that needs removing, one that does it after we've dropped the

I will try the new approach if you don't see any obvious problems
with it.

-Dai

> lock.
>
> --b.
>
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
>> +	return ret;
>> +}
>> +
>>   /* Called from break_lease() with i_lock held. */
>>   static bool
>>   nfsd_break_deleg_cb(struct file_lock *fl)
>> @@ -4660,6 +4706,8 @@ nfsd_break_deleg_cb(struct file_lock *fl)
>>   	struct nfs4_delegation *dp = (struct nfs4_delegation *)fl->fl_owner;
>>   	struct nfs4_file *fp = dp->dl_stid.sc_file;
>>   
>> +	if (nfsd_check_courtesy_client(dp))
>> +		return false;
>>   	trace_nfsd_cb_recall(&dp->dl_stid);
>>   
>>   	/*
>> @@ -5279,6 +5327,22 @@ static void nfsd4_deleg_xgrade_none_ext(struct nfsd4_open *open,
>>   	 */
>>   }
>>   
>> +static bool
>> +nfs4_destroy_courtesy_client(struct nfs4_client *clp)
>> +{
>> +	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
>> +
>> +	spin_lock(&nn->client_lock);
>> +	if (!test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags) ||
>> +			mark_client_expired_locked(clp)) {
>> +		spin_unlock(&nn->client_lock);
>> +		return false;
>> +	}
>> +	spin_unlock(&nn->client_lock);
>> +	expire_client(clp);
>> +	return true;
>> +}
>> +
>>   __be32
>>   nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open *open)
>>   {
>> @@ -5328,7 +5392,13 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>>   			goto out;
>>   		}
>>   	} else {
>> +		rqstp->rq_conflict_client = NULL;
>>   		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
>> +		if (status == nfserr_jukebox && rqstp->rq_conflict_client) {
>> +			if (nfs4_destroy_courtesy_client(rqstp->rq_conflict_client))
>> +				status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
>> +		}
>> +
>>   		if (status) {
>>   			stp->st_stid.sc_type = NFS4_CLOSED_STID;
>>   			release_open_stateid(stp);
>> @@ -5562,6 +5632,47 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
>>   }
>>   #endif
>>   
>> +static
>> +bool nfs4_anylock_conflict(struct nfs4_client *clp)
>> +{
>> +	int i;
>> +	struct nfs4_stateowner *so, *tmp;
>> +	struct nfs4_lockowner *lo;
>> +	struct nfs4_ol_stateid *stp;
>> +	struct nfs4_file *nf;
>> +	struct inode *ino;
>> +	struct file_lock_context *ctx;
>> +	struct file_lock *fl;
>> +
>> +	for (i = 0; i < OWNER_HASH_SIZE; i++) {
>> +		/* scan each lock owner */
>> +		list_for_each_entry_safe(so, tmp, &clp->cl_ownerstr_hashtbl[i],
>> +				so_strhash) {
>> +			if (so->so_is_open_owner)
>> +				continue;
>> +
>> +			/* scan lock states of this lock owner */
>> +			lo = lockowner(so);
>> +			list_for_each_entry(stp, &lo->lo_owner.so_stateids,
>> +					st_perstateowner) {
>> +				nf = stp->st_stid.sc_file;
>> +				ino = nf->fi_inode;
>> +				ctx = ino->i_flctx;
>> +				if (!ctx)
>> +					continue;
>> +				/* check each lock belongs to this lock state */
>> +				list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
>> +					if (fl->fl_owner != lo)
>> +						continue;
>> +					if (!list_empty(&fl->fl_blocked_requests))
>> +						return true;
>> +				}
>> +			}
>> +		}
>> +	}
>> +	return false;
>> +}
>> +
>>   static time64_t
>>   nfs4_laundromat(struct nfsd_net *nn)
>>   {
>> @@ -5577,7 +5688,9 @@ nfs4_laundromat(struct nfsd_net *nn)
>>   	};
>>   	struct nfs4_cpntf_state *cps;
>>   	copy_stateid_t *cps_t;
>> +	struct nfs4_stid *stid;
>>   	int i;
>> +	int id = 0;
>>   
>>   	if (clients_still_reclaiming(nn)) {
>>   		lt.new_timeo = 0;
>> @@ -5598,8 +5711,33 @@ nfs4_laundromat(struct nfsd_net *nn)
>>   	spin_lock(&nn->client_lock);
>>   	list_for_each_safe(pos, next, &nn->client_lru) {
>>   		clp = list_entry(pos, struct nfs4_client, cl_lru);
>> +		if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags)) {
>> +			clear_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
>> +			goto exp_client;
>> +		}
>> +		if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
>> +			if (ktime_get_boottime_seconds() >= clp->courtesy_client_expiry)
>> +				goto exp_client;
>> +			/*
>> +			 * after umount, v4.0 client is still
>> +			 * around waiting to be expired
>> +			 */
>> +			if (clp->cl_minorversion)
>> +				continue;
>> +		}
>>   		if (!state_expired(&lt, clp->cl_time))
>>   			break;
>> +		spin_lock(&clp->cl_lock);
>> +		stid = idr_get_next(&clp->cl_stateids, &id);
>> +		spin_unlock(&clp->cl_lock);
>> +		if (stid && !nfs4_anylock_conflict(clp)) {
>> +			/* client still has states */
>> +			clp->courtesy_client_expiry =
>> +				ktime_get_boottime_seconds() + courtesy_client_expiry;
>> +			set_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
>> +			continue;
>> +		}
>> +exp_client:
>>   		if (mark_client_expired_locked(clp))
>>   			continue;
>>   		list_add(&clp->cl_lru, &reaplist);
>> @@ -5679,9 +5817,6 @@ nfs4_laundromat(struct nfsd_net *nn)
>>   	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
>>   }
>>   
>> -static struct workqueue_struct *laundry_wq;
>> -static void laundromat_main(struct work_struct *);
>> -
>>   static void
>>   laundromat_main(struct work_struct *laundry)
>>   {
>> @@ -6486,6 +6621,19 @@ nfs4_transform_lock_offset(struct file_lock *lock)
>>   		lock->fl_end = OFFSET_MAX;
>>   }
>>   
>> +/* return true if lock was expired else return false */
>> +static bool
>> +nfsd4_fl_expire_lock(struct file_lock *fl, bool testonly)
>> +{
>> +	struct nfs4_lockowner *lo = (struct nfs4_lockowner *)fl->fl_owner;
>> +	struct nfs4_client *clp = lo->lo_owner.so_client;
>> +
>> +	if (testonly)
>> +		return test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags) ?
>> +			true : false;
>> +	return nfs4_destroy_courtesy_client(clp);
>> +}
>> +
>>   static fl_owner_t
>>   nfsd4_fl_get_owner(fl_owner_t owner)
>>   {
>> @@ -6533,6 +6681,7 @@ static const struct lock_manager_operations nfsd_posix_mng_ops  = {
>>   	.lm_notify = nfsd4_lm_notify,
>>   	.lm_get_owner = nfsd4_fl_get_owner,
>>   	.lm_put_owner = nfsd4_fl_put_owner,
>> +	.lm_expire_lock = nfsd4_fl_expire_lock,
>>   };
>>   
>>   static inline void
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index e73bdbb1634a..93e30b101578 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -345,6 +345,8 @@ struct nfs4_client {
>>   #define NFSD4_CLIENT_UPCALL_LOCK	(5)	/* upcall serialization */
>>   #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
>>   					 1 << NFSD4_CLIENT_CB_KILL)
>> +#define NFSD4_COURTESY_CLIENT		(6)	/* be nice to expired client */
>> +#define NFSD4_DESTROY_COURTESY_CLIENT	(7)
>>   	unsigned long		cl_flags;
>>   	const struct cred	*cl_cb_cred;
>>   	struct rpc_clnt		*cl_cb_client;
>> @@ -385,6 +387,7 @@ struct nfs4_client {
>>   	struct list_head	async_copies;	/* list of async copies */
>>   	spinlock_t		async_lock;	/* lock for async copies */
>>   	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
>> +	int			courtesy_client_expiry;
>>   };
>>   
>>   /* struct nfs4_client_reset
>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
>> index 064c96157d1f..349bf7bf20d2 100644
>> --- a/include/linux/sunrpc/svc.h
>> +++ b/include/linux/sunrpc/svc.h
>> @@ -306,6 +306,7 @@ struct svc_rqst {
>>   						 * net namespace
>>   						 */
>>   	void **			rq_lease_breaker; /* The v4 client breaking a lease */
>> +	void			*rq_conflict_client;
>>   };
>>   
>>   #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
>> -- 
>> 2.9.5
