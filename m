Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869A3416436
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 19:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242469AbhIWRRR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 13:17:17 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:53254 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242279AbhIWRRQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:17:16 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18NH0KL7007034;
        Thu, 23 Sep 2021 17:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=vx+UUfB35GAki9D2ZcaQIBgTAPdw1QiIi0TNmiEeyPw=;
 b=QLUMIBWGe4I1Fr3zW8F0Dfbqk0LI7omOb0l4eEy5b88Oi+ufYhDZVWFVGtaI+EmNK0Rf
 tvkI4oDRmcoICbtObOBC8nmjCAEtODj2D2ZmwMbAwR1T4OggH+gXFn+ZDb35FfDBVa91
 ImkpCbkC5AFdm8pQq+wxa+ofrp2Elt/G1K0Mkg2Ou6zTW/CXcjuItlYCWXVoGyMYUNf1
 oxDtb1Bm2B+MVDyHMAuxMuzAF79FofkZ81VeaUvi7cpLMxntdaBuzd9c4auweM8SPihC
 a7hzmqjX1gufvpt/6V3Mz5vLRdwHcQb7VzIC+SmOWPFGpuPl6V5XKInnqbjfx1Ll7kfx lw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b8neb3vcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 17:15:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18NHAsml094858;
        Thu, 23 Sep 2021 17:15:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3020.oracle.com with ESMTP id 3b7q5cj5fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 17:15:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5/ygdnAkgF4Mv+/vfXiH63iU2EBPSlWQrfCpnsZtuVunJYIAETo4UzFOKNCHKzTfSPf+NNUz8u4CT08jX1TyV0GlTRB59gT7Oo5r2Uh1Aq93vUJJ6TnpLIFOhUtxIWHzIOxwXP/jhovHFA/MM4c1OtHyhDdXTHFwrhPhm6c2vI5x8cKG/5lMabzybFYK7yaMiJd16/FUgSKSKRJ9ibmvdir6m9g43BNMQZYjk9dkasAtIZva5LA0SN6w5+zyzXCLXHa4kCKzHBO5scaHU6rteNcpbOnUFKA0i85Hr06xQsnIjCX4Rk7h3YXLxh6BOOOEo+qZIzz6SOjKyE/YJwKLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vx+UUfB35GAki9D2ZcaQIBgTAPdw1QiIi0TNmiEeyPw=;
 b=bQTXyI56/1GfGp7BpLoo4wkuWW2lVJrCRncEAOEckmiZiAstKMeVzHjQKU3dFGzQxferDJFnNh9rDo25IuA4hdPUaBJSaMkFyPRQCyfWCyTFlWSo0Qr9QEezfUXECDHEtO9YI2HBk7wrh9OQf+Th9lslc7n6AgEmdmUOoDrVzo+1q2J3x1jzR1ciiIAz+GaESKZ41EQjzeX2g8gF92ub0Mz7ktfQ6okv3sh889ufuWkGgnv2tR8MSDlKui/fDlvZUf3pckFfzJZmoDDe6UP5oWJrtBsrALuL/hM1XcSg/d1/InCrVx4N14IPiIsZWjg3cnzwGpdcVc3WZD4RP/p/Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx+UUfB35GAki9D2ZcaQIBgTAPdw1QiIi0TNmiEeyPw=;
 b=0JNiC7gExFwGOpT9Vhj3DgjvGbyzZmUbnwAMkAoZQaeorWo1GcjLz+/Qzc068Gk/r2Yut9mP6CUBbLvc13U6/tGwJSSzMC5Gp8biMijaCYiUijdYHmwaYaRQ4RV4kl/8eGOrhX3AbNoCg9nZ3+xhZo/Gtd0cmv7Ti/IJY+HI/gA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB2647.namprd10.prod.outlook.com (2603:10b6:a02:b2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Thu, 23 Sep
 2021 17:15:40 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::1c92:fda3:604:a90d]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::1c92:fda3:604:a90d%7]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 17:15:40 +0000
Subject: Re: [PATCH RFC v3 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20210916182212.81608-1-dai.ngo@oracle.com>
 <20210923014733.GF22937@fieldses.org>
From:   dai.ngo@oracle.com
Message-ID: <96ea034b-ca95-3934-4c31-14c292007ca7@oracle.com>
Date:   Thu, 23 Sep 2021 10:15:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20210923014733.GF22937@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SN7PR04CA0183.namprd04.prod.outlook.com
 (2603:10b6:806:126::8) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from dhcp-10-159-135-151.vpn.oracle.com (138.3.200.23) by SN7PR04CA0183.namprd04.prod.outlook.com (2603:10b6:806:126::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Thu, 23 Sep 2021 17:15:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c0059fe-be83-45b9-98ec-08d97eb5c444
X-MS-TrafficTypeDiagnostic: BYAPR10MB2647:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB26476D4B691DBB0A2331D02587A39@BYAPR10MB2647.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RLVr/4O/pOfNOQkjeZsxTOmEnfXMwufU/MUjFEFUVVqVisaMmukruVob6Qn9YOHQLY+YE6Ml2U7snsSvOKCGjGmHt7eMKull3+qgMRNkE5nUkETy7RD0nkC11rajpt/dJuaeBrrMAhK3mJcVist/wjDLOk4lF1iLUQVwTocAtnDnfu5HUxYEepwR+pNYKahKOY6zzBOsWsmgXJ3V3t9Ppr7d2nt8LRwiy+kBaKYspDICXkcTl8xpWltoIqurmEkktA6AKC4Pu75uWa51q87WMP/JdH+FX/B9edi2Z1tWbGFjKT8dIYskScG1RXpLFmBghr4gv/V69kOzUslelaOAfHk75ohCUFhoKwY27ofm6NhF2ADuhb0XA5437tikqDN7wz2j3Xmrn1OvTJNDr/PR3agPz4F3JzwX3jPgTuf/jJkjgNdXVXrC046JwmGcqNuS17o96f6IUSoRT7GTCe5VdK5RAeuZOA89j9sZrofPpGk8twZNx6I8dpqkTvGKQy1HGzZRkv9fKXUBZ59dkippZK0JcvoEofA0NRnnWTDTaQxhzu5VW2uQ8QXoztAZIO2TczK1tkeL+40UDEZEJds5PDSc0a8+sQ+tLIAOQEBWzlWRfztj42ZVr5s+qquC07hUgKvUd7RZc7rUeafgB8BxZWWhiTF/xstkerh67zyNr6gpYWK1lRvBzEz0HFDv3BbZP0WoIy+iQAUqD3wGF9UHFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(508600001)(31696002)(53546011)(7696005)(8676002)(956004)(26005)(31686004)(9686003)(5660300002)(66946007)(86362001)(6486002)(83380400001)(38100700002)(36756003)(2906002)(316002)(66556008)(6916009)(66476007)(4326008)(186003)(8936002)(4744005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFg2blJxQ2ZuSTFKQTlMd2x0L1RTNTVZWWFrVjVVc1YxQlV5b3ExRy8yR1l5?=
 =?utf-8?B?VmlvVDF2RlZIb0hiSXptcmZMcDlsa0RLNmtBRDBMeWlxK1p5OUsyZCsxRktD?=
 =?utf-8?B?OWhFMzRDMDVpQ29IdWU1d2kxMjBUeWNlcHluNVduTUl6Y0NVUXFqb0xMS0U1?=
 =?utf-8?B?UytGQkRwTXREY1RJMFhCVWtlYUtiSmR4YTdxL1Y4WW5wTEJFb0lJS2NadEI1?=
 =?utf-8?B?bTdqU3NuVmtXU1dFcHJHY1FqV2x6aWcrZk9GdFJvbDlCbHRJYVc4enRhQW9z?=
 =?utf-8?B?YWg4cnd0aExlQkxIazM4Qmd2K3ROVDJoTEwvd29tZCt1M2RjV3VHVWJETGpO?=
 =?utf-8?B?Y1dLMXJHSTVrMWN2OWxnMGxCRjNzRXhadUIrYm55d0xCcE01VEEydlNoamQz?=
 =?utf-8?B?Wk1sUGJtdzNNeFRJc280K2FoNDRlZWxBYUpNUGFxcTJlWmxCUWxSSW41Z0lI?=
 =?utf-8?B?ZnFCQS9qRSswQWNJMGNCSEdNeUVpdTFjQkZCN3NPT3h0Y1UxMEVYMzdwMW1Z?=
 =?utf-8?B?ZmoyaW1uVkVXN282RzRLSEJoSU5oakp1ZlRJU0VOYkxhUnJqM2RIdTZmRWwz?=
 =?utf-8?B?Wnl5TFNRV3BaSUgwZ0pzZlBqUUU0UkxBQW9XN08xRXhGUmViWGg1Z3Fmb2Jv?=
 =?utf-8?B?eENNMEJFWlovM0dOeFk3ZUNJTGNNOU4zTC9BZVZSM2Zta3k0WXlwTGNVeVND?=
 =?utf-8?B?RDdxSlJkRzFONXBSMk82aGYyY0RCMGMvbzU1eTJYd1hiSXFqZWRhQ2Z1UGo1?=
 =?utf-8?B?b0taamNabW5jRTY1QzBQd2ZXaXkrWGpwTEVuRFE2WUZuSzdNNW15LytJYzR0?=
 =?utf-8?B?MndSZFVXWDU2ejloZ0l1WE5IVno4aWRWQ2pXTC9acVpqMG13KzR0L0pGNndx?=
 =?utf-8?B?YW1Bdi80M1VIV1Fyd3ZpaS93Z2tBZ3FZWnB5bmg1bjRydms5U1U2bVFnd1g3?=
 =?utf-8?B?enEveTErNWxVa1RLV2FCd1QzRmxYZ0hZQ3FjRjJUR0hSSWo4RlZ4dW81cUcr?=
 =?utf-8?B?TmpCbXl4MFdMT0c2WENsY1BHaE9YRC90QWROaFE2dnhSWEtrdzcycDNLdUFO?=
 =?utf-8?B?WVdUZC9CVXQvQ0xiV29Md1B0aG5uSXozQityVW50eTlPOGN6azU4S0tKNG9B?=
 =?utf-8?B?bVhnOWFoQW5CQWsxT08xTk95ci9vcG1XYS9NcHA5bDQ4Q245WjlZZy9rcStY?=
 =?utf-8?B?cTFSK0F4OFJGWSsyVFQyTGQ4cFNCeXJqTld5eGZVVDlsZXF2MW8weXVUanRJ?=
 =?utf-8?B?OXpxYTFXZlpiREFtVGNVMGQ1WTR6a054b0NLQ1lLRm1tR1RjZnJ1T2tXYTJM?=
 =?utf-8?B?aFNNN3hOQXF6T0xxamh5WjZGMVRWWTAxcWRJdC8rVXpSQzdwNHNBcy9DSXQ0?=
 =?utf-8?B?UkpkV3p5UEVTSllLam52eExxOEZrZDdpcGN4OHBkNWRGMjAybFFJUnN4NkFm?=
 =?utf-8?B?eE1wc2JCRVo3cUFnV2VmRXduaUxHRkJCV2RTSEdERFRxR1pJcVhpU0dtaDR4?=
 =?utf-8?B?NFhGTXJ5NXZXT05kb3F4YmZsaHNjSzFKRHhJckVEdUhNcGZ4OFNYWXdhTTMr?=
 =?utf-8?B?MlVjdHYxN3E3b3p2SVB3S1g2MTB3bVVuMWNaeWpKbEdMdklrWTF6bEFtdVNL?=
 =?utf-8?B?c016T0lIMVlxa3hOT3pSS2tCcDBYalJrS0RMOHUrZ0ZmelIraDJiZHRHRVlQ?=
 =?utf-8?B?SzQ0RGZxY09wWngzUUpDVVpuRzBjZ2ozRkF3WTVqQ005dkE2Z05mT1hMamdM?=
 =?utf-8?Q?NDUQ3ju7eh3AHPutu7/DXgG8zWnbXtUbqKv5lOz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0059fe-be83-45b9-98ec-08d97eb5c444
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 17:15:39.7631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GiQsHXB0Cd/9HQRS8M6YnmOiLsPb3O1Qz5sOacFy+zV/IZ+O3LTtB4On/rcpXsgP9LEee9DOsH2Qyd6CauEjYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2647
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10116 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109230105
X-Proofpoint-GUID: jBwh_9RPKv-4hG6nO4uRpvOMNZPMnMG1
X-Proofpoint-ORIG-GUID: jBwh_9RPKv-4hG6nO4uRpvOMNZPMnMG1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 9/22/21 6:47 PM, J. Bruce Fields wrote:
> I haven't tried to figure out why, but I notice after these patches that
> pynfs tests RENEW3

The failure is related to share reservation, will be fixed when we
have code that handles share reservation with courtesy client. However,
with courtesy client support, the test will need to be modified since
the expected result will be NFS4_OK instead of NFS4ERR_EXPIRE.

> , LKU10, CLOSE9, and CLOSE8 are failing with
> unexpected share denied errors.

I suspected these tests are also related to share reservation. However,
I had problems running these tests, they are skipped. For example:

[root@nfsvmf25 nfs4.0]# ./testserver.py $server  -v CLOSE9
**************************************************
**************************************************
Command line asked for 1 of 673 tests
Of those: 1 Skipped, 0 Failed, 0 Warned, 0 Passed
[root@nfsvmf25 nfs4.0]#

Do I need to do any special setup to run these tests?

Thanks,
-Dai

>
> --b.
