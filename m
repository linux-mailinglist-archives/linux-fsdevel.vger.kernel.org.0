Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6526453C8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 00:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhKPXJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 18:09:40 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48756 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229543AbhKPXJj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 18:09:39 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AGMFCa9023615;
        Tue, 16 Nov 2021 23:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+X1L2/zwPHT4jvcF6/WEetdJwYnlS0/QMAk59xiIMq8=;
 b=rPUnWyOsJ1OojgM9xGnZdWosxdFSIeQ67ewmHUTjxTGYG4fzA8KLvLsTvKI9uBvPWND3
 01r0lEwZinpDPdU6cLENSLaECnLfy+vel5f6qeCTowd7ifTFm+0tNaKjK9PcFkv6KJMs
 OHTFTP6rwOkM56oPS678XNII/K1bfPw9QfxTu+hqFBXSkWuAJxbw702ritDFN6GvWsEg
 hqJFBuQh0cS/8dnes8z/KM3lje0m67K+zBxp27tHFnpUFjgaoTgiUgB+ZllwtXjwxtBz
 0fxftGIiApmH8VFBUcv7ntXECXpwcIeN7PJeEju40CRQ4qiGjoErx67X4bICcyKfOgMM Tw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbfjxvxe7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 23:06:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AGN0e4k087256;
        Tue, 16 Nov 2021 23:06:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by aserp3020.oracle.com with ESMTP id 3ca5665nvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 23:06:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLbD8a6g9OSFSwJFD7CxjIAdNxWhjrpc7V3u6PD1aGulnRETGbjPpuSQtWJcXZwdbDu7RHyp+i8ULzWtOsq9FnoQCdSi2ZUdi0sLMFmUfJBbvPtVg1EBzD+lBcvMWlSe5MWk+Ju4cBS5Hst7g2fSc+EBzJQ8DSV3vJ82DE8mmpgPPxBE7J+Q3Mx/bkhGH7paqFBTzj3uw319vSLE+FyoBonu8qy9riUDcV7B2AQ20GaLUQDHt+EePmGnf+NTh/a2zQ7yHGBB2zCFCly/tZ7HlCU08UlKLqNdCLbtEm1ut5zCCq5ICuGQSdp30oytfCKstgmMSSNb0uZzsBOY0SiC0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+X1L2/zwPHT4jvcF6/WEetdJwYnlS0/QMAk59xiIMq8=;
 b=Rko6RsQL4aTvDhVrNP3+D49+FZDG3PeCZB7TIWpDNtxpheTd7LsdAlWkgYqVGZrVXnCgkxXVXd8Yerzu2QUOhjGO68i/a6ghbt5MgYT7MpwB7CUXX3x5G3dg50+0u+mnWaUn/JCqV2hExOHmvqN4tx193m04QviBcAx54OdA3DlbnSgRxt1j7lOTvqdq6avwL07hMg8oL4fU9e32SqTNiVn+n9nehMVHJwN8JDTTWY9SVpaHC9iW6EdK6kq8+51lsDDbsSHVjx1MCPSlCdGrodPDgfPZs4kBENrrcC+anhmXTLB2i1Jiip1jEe6frx4X1y4wjo/RrLnBqEyXGpxoSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+X1L2/zwPHT4jvcF6/WEetdJwYnlS0/QMAk59xiIMq8=;
 b=f/RJFhM+Ksn+PGHCCW7jfpEMkLzHP9WgWvhiq19LWsWsxtCVGp6skm2qnUcAyKQTd/exOTnWweW7eazh9VfcCu9B6mvrofSzsIGKawftPXd+SPYdptg5FLwol/P/hf4IaQpaP8ToCRUctGcTZnFjse4mCGW1pspTjofJKtO5AgE=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3222.namprd10.prod.outlook.com (2603:10b6:a03:150::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Tue, 16 Nov
 2021 23:06:37 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e%7]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 23:06:35 +0000
Message-ID: <33c8ea5a-4187-a9fa-d507-a2dcec06416c@oracle.com>
Date:   Tue, 16 Nov 2021 15:06:32 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
From:   dai.ngo@oracle.com
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20210929005641.60861-1-dai.ngo@oracle.com>
 <20211001205327.GN959@fieldses.org>
 <a6c9ba13-43d7-4ea9-e05d-f454c2c9f4c2@oracle.com>
In-Reply-To: <a6c9ba13-43d7-4ea9-e05d-f454c2c9f4c2@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0172.namprd04.prod.outlook.com
 (2603:10b6:806:125::27) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from [10.65.155.124] (138.3.200.60) by SN7PR04CA0172.namprd04.prod.outlook.com (2603:10b6:806:125::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25 via Frontend Transport; Tue, 16 Nov 2021 23:06:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4239c8cf-f149-4c88-231d-08d9a955bcd1
X-MS-TrafficTypeDiagnostic: BYAPR10MB3222:
X-Microsoft-Antispam-PRVS: <BYAPR10MB322266E9FD3B55BE46A0142787999@BYAPR10MB3222.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4CihwSwMT/LOcPs54zcBPDzg+y/AUWBkmA/5RA0TpTxPswn+GID3nQTAU9SXdUFH/DmN2ylpzsEp7G5sZ1YwNlqt7MxlD1VcGJSUMICbh/zX6CZwLN9q6a+ZWK+rb8MOw+LvJrdzcXCdcXxrVIg7voEC3LYdYKe03KWOVI1Z+3DXyaykxJTf8bmmKlmzFSsu6UcvEZe3vVnqNU0i4JumcDGfl1ygFtHCN+sR4I+HBye6J02t0QtKR+0/i7dy5YBOqBW411UcWYtGukD+bqnLibZ3xqKe1SP4tL9kK3XywCK613Ey2nnMeaykj9Qd9m4hO5Yr2724GL0mu0gkI0/MbKDGjB9ToTeA8Joa/ac9pBHWzS20SUgaxtJDNDjSLboJ/+UTuLHsI3fSIyRR2BDO6S7YmjkcwZzJ89Tqitpusn9OUgNCR820dvKn2isZHV0ZAuOuIPL/5apHODNvlrCMnVeCJcWnVI9V9iZF3EL9keOOTkikiYmEb0iHCXh9R61okltNvNueOFO9l33NxbGd3YfPLAIipCjMpCs/yNkC/aU+EY8Cel8IETpZvB9GznkQrzEU9PwlZe90JlGnDCf17qpy8eWEGDNz1fvvLVIibiCOjavNbtKhTa2wq8YuJQJUT8BMp2P8OXRqBehFDGeV52fJsJlAlFC56iJuFdVhoPndUlheE1m4BgsUhhUi5yDXckfEoyhHqwaJusIymQB/0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(316002)(8676002)(9686003)(16576012)(53546011)(66476007)(66556008)(66946007)(5660300002)(26005)(186003)(83380400001)(2616005)(31696002)(31686004)(38100700002)(2906002)(956004)(6916009)(36756003)(8936002)(86362001)(4326008)(19627235002)(508600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0FKUm1kNExmZzM0d2luMlljd3g2eUl6NENQc3ZXckkxYW4zV2cvSk0zdjBw?=
 =?utf-8?B?TU0vSFVaWVNvbkxDT044UUF5MytEYUlsdmtrajFFS3l4bGp5MEtHRFQ0ZW9z?=
 =?utf-8?B?cEpGdExSalR0Tkdpdm9Oa0I1NFdFZkFaL2dUOWc0WkorcS9rWTlCVDZGdkh0?=
 =?utf-8?B?elZGRFlxS3VSZ1QrOTA4bXZObG9mUi9jc0NrbUQ2UEIvU3pJZ2RCWjZXU0Er?=
 =?utf-8?B?cnFyU2VxWGd0WG9mWnVGRHdaNlQyaEpUZ21nMXVLTzliOUdrK3JMcXFQdjl4?=
 =?utf-8?B?SHNCajVHdW9mVnRKZEF3U1dnS1p6aHZWaWZEQjlsUlZ2L1pDV2o0MDJGWCts?=
 =?utf-8?B?ZkJuRU1zWlRPcGIzN2JEYUU5ZmtHOFM2endGOG8zU1VGOW5oZGRwbGQxOUZE?=
 =?utf-8?B?dGxGNVVmWWRDTGpnSGREdHB3d3lMeGsvUGkwVGdvTHJUbkNDQW1YalFqWENx?=
 =?utf-8?B?L3JDWFVZOWlmRXNrcDk0aFNrR3R1cVNxdTkxbzBubzlsOUlZdFljaEF4WjlV?=
 =?utf-8?B?cGRnVXE1T3FGMkRXQ3hZK0lXNXRYOGsrYzFOb3ZSN0xCb1lkc1dPYlp5SUtF?=
 =?utf-8?B?TlRFb0txTnFLM1ZNUEo1ODZBU1R0bGk1b2tFOWc3MGc2RGRBZ2hldDhMb2RQ?=
 =?utf-8?B?Q0dha1UzTXV4UW80UXhLWGVWSUtuaXF0c05GdW94WCtUMnVUTGpqbVBmVm9l?=
 =?utf-8?B?KzlBS2I1N3c0aEtPR0JWSkpTWXlORnd1eUE2TGRreWNBclkyY3V6ZTBKd25R?=
 =?utf-8?B?Y0xKY3YwdTRuYitoekMzRHVrdWFqc0Yzb3NEVzBLREc1WlBZUHNvWjR6cWpp?=
 =?utf-8?B?T0p2ekpsbnJYdU8yTDRhQlcxWDVXSEpqWGx4N2hvUnlMVFpzc0FjNXp2UFhH?=
 =?utf-8?B?R2lGQXNJbnhQeFoyakNUSFVZYVRmZDVLWkdiYTJHRWtwbUQ5YjBvN0FrdTAv?=
 =?utf-8?B?ZWM3UXZHZVZ5Q1RmY3dBK2pXV3F0blFxYUwrRUh0Z1h6RWhMZStsY0NSVnhJ?=
 =?utf-8?B?OXFicjM1bEhkN01FbEFHeEZyaE13YXFUTFdvK25WVWt4bkdSL2ZOcUt6VGRj?=
 =?utf-8?B?aXVUVUtHUU9NUlpGQnNGWVVBb1ZkSEJQd1p2NzNROStyRmpjeC8xeWthcndJ?=
 =?utf-8?B?Z2NUNGpGSDVtWkFKZ0hvNXJOVU13dnRjSW41NUxJZHlrbzFqbXFudTgySm81?=
 =?utf-8?B?eGw2cjZmOUNNaDYzVlBud3pzRG5BT0NDQUtvR0tMWk5LTWJiOWt6TTdSaUVG?=
 =?utf-8?B?ZHRUSUVyd3dXdjM4eTVuTVllOG83SklGbEhWTy9zaEVkcE1yVjlPOEJaR3F6?=
 =?utf-8?B?cFZLTHR4VFJuOHA4TnNsdWRLKzExeEFLcm5hMHJORWhWaGNEVWtJM2NwNHpL?=
 =?utf-8?B?bTA4OTRuKy9kNm5WMHFWb3o5ejFFK3JFUEoycHd5emx4am9JT1g1UmF2OFFR?=
 =?utf-8?B?WGtReUszZEFJM2RVUm1JUjVUdDhaV2lZazQxbTN4KytnUEl0bDByd09paUta?=
 =?utf-8?B?ajJCTEN4RkN1SDdPUXloYXJ5STl1Y2VWQ3BLUkM1dlRzaHVMYjZnRGtsSFVa?=
 =?utf-8?B?ZkphZkI5ZFdRdUpRdmFQR3gzMlQ2dUc2SUZ1cHE0ZmdVekVvcEVkUVB5MFJW?=
 =?utf-8?B?bmRHZkpkZ0lTbkNpRkdkQmplWWdWVG5sQ1J5RHFBVFBKbkkvdE96R3U5MTdL?=
 =?utf-8?B?ZDJDV0czdTZleStGU2VMZkoxV2dLWnM1YWtLSzFJK2dXV29KNnltZEROaHV5?=
 =?utf-8?B?bUw3QUtRK1U4UlZsbFBZNkh3c1ZoMEZQWXNPalc4dE1KVlNaK0NhSlBmakhv?=
 =?utf-8?B?aDVJUjN1VFJGb1Yyb2ZDRG9xRVlHeUZFV3JpdGhQSVR3SzlKVmdTdS9zYVFi?=
 =?utf-8?B?NWMrc05FeHBsYTR1T0tpa3ZQMzMxeHNjNFpqWVFNMEw0VVN1RmpYVGluSk9U?=
 =?utf-8?B?ZFJWbHhFOTVpN2VIa3U0QW1WZjlaZithZHRqcmxSQnZWa090bTJLdHVVUllh?=
 =?utf-8?B?V0lad21CSXYvd21JRXVyVHcySEZ1Z2F3cjVYcmdvanAvcFdJenQ5L3lvdy9S?=
 =?utf-8?B?cDF5TFFpejRtVkpLdjVsSkpUTGtENWxxVE5iZXdCWWlDeTA0bHN4d0hsZHhM?=
 =?utf-8?B?MnVFM0NZYVdIOGdlaWNycmVBNi94MGpqL0U5aXVtek8zdldsRWVIZ2FBbUxa?=
 =?utf-8?Q?fROMx0997Z9fWXDu4Bo8ghU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4239c8cf-f149-4c88-231d-08d9a955bcd1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 23:06:35.5987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: doDn4WyQSt3v/+D+KNcMO87h6CIY02Y8C3qCJDzVocq/AfU1nKQ6BJftB3yCdT8uQMcQTWViqPJuMU9+BzT2Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3222
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10170 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111160101
X-Proofpoint-ORIG-GUID: 8yYIHU1WyQpW34IG74mwSfMH_YQi3BqJ
X-Proofpoint-GUID: 8yYIHU1WyQpW34IG74mwSfMH_YQi3BqJ
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Bruce,

Just a reminder that this patch is still waiting for your review.

Thanks,
-Dai

On 10/1/21 2:41 PM, dai.ngo@oracle.com wrote:
>
> On 10/1/21 1:53 PM, J. Bruce Fields wrote:
>> On Tue, Sep 28, 2021 at 08:56:39PM -0400, Dai Ngo wrote:
>>> Hi Bruce,
>>>
>>> This series of patches implement the NFSv4 Courteous Server.
>> Apologies, I keep meaning to get back to this and haven't yet.
>>
>> I do notice I'm seeing a timeout on pynfs 4.0 test OPEN18.
>
> It's weird, this test passes on my system:
>
>
> [root@nfsvmf25 nfs4.0]# ./testserver.py $server --rundeps -v OPEN18
> INIT     st_setclientid.testValid : RUNNING
> INIT     st_setclientid.testValid : PASS
> MKFILE   st_open.testOpen : RUNNING
> MKFILE   st_open.testOpen : PASS
> OPEN18   st_open.testShareConflict1 : RUNNING
> OPEN18   st_open.testShareConflict1 : PASS
> **************************************************
> INIT     st_setclientid.testValid : PASS
> OPEN18   st_open.testShareConflict1 : PASS
> MKFILE   st_open.testOpen : PASS
> **************************************************
> Command line asked for 3 of 673 tests
> Of those: 0 Skipped, 0 Failed, 0 Warned, 3 Passed
> [root@nfsvmf25 nfs4.0]#
>
> Do you have a network trace?
>
> -Dai
>
>>
>> --b.
>>
>>> A server which does not immediately expunge the state on lease 
>>> expiration
>>> is known as a Courteous Server.  A Courteous Server continues to 
>>> recognize
>>> previously generated state tokens as valid until conflict arises 
>>> between
>>> the expired state and the requests from another client, or the server
>>> reboots.
>>>
>>> The v2 patch includes the following:
>>>
>>> . add new callback, lm_expire_lock, to lock_manager_operations to
>>>    allow the lock manager to take appropriate action with conflict 
>>> lock.
>>>
>>> . handle conflicts of NFSv4 locks with NFSv3/NLM and local locks.
>>>
>>> . expire courtesy client after 24hr if client has not reconnected.
>>>
>>> . do not allow expired client to become courtesy client if there are
>>>    waiters for client's locks.
>>>
>>> . modify client_info_show to show courtesy client and seconds from
>>>    last renew.
>>>
>>> . fix a problem with NFSv4.1 server where the it keeps returning
>>>    SEQ4_STATUS_CB_PATH_DOWN in the successful SEQUENCE reply, after
>>>    the courtesy client re-connects, causing the client to keep sending
>>>    BCTS requests to server.
>>>
>>> The v3 patch includes the following:
>>>
>>> . modified posix_test_lock to check and resolve conflict locks
>>>    to handle NLM TEST and NFSv4 LOCKT requests.
>>>
>>> . separate out fix for back channel stuck in SEQ4_STATUS_CB_PATH_DOWN.
>>>
>>> The v4 patch includes:
>>>
>>> . rework nfsd_check_courtesy to avoid dead lock of fl_lock and 
>>> client_lock
>>>    by asking the laudromat thread to destroy the courtesy client.
>>>
>>> . handle NFSv4 share reservation conflicts with courtesy client. This
>>>    includes conflicts between access mode and deny mode and vice versa.
>>>
>>> . drop the patch for back channel stuck in SEQ4_STATUS_CB_PATH_DOWN.
>>>
>>> The v5 patch includes:
>>>
>>> . fix recursive locking of file_rwsem from posix_lock_file.
>>>
>>> . retest with LOCKDEP enabled.
>>>
>>> NOTE: I will submit pynfs tests for courteous server including tests
>>> for share reservation conflicts in a separate patch.
>>>
