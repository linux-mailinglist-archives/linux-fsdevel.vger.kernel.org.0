Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045834EB1B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 18:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239571AbiC2QV7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 12:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239574AbiC2QV6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:21:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D3E1B255C;
        Tue, 29 Mar 2022 09:20:14 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22TFxWb8016084;
        Tue, 29 Mar 2022 16:20:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=68yLPUudR7/6TBCHMpdQz/6vHauHRqDl/6qiOQSZZiY=;
 b=0CdrIluilA6UhspdF2EVGlm6UzIs/OW/YBQWwi6nvWjh3+Vzde0wtvrrJVIBiH5wS4iZ
 /90y1zVFwRti0M7nmFP7BdBHD4A8Mb68nm8PFIeHZr21ySsF+MOSw1zNBpVOoFwAVqqK
 wJ59Hy6hc9mbq18SLleeLIbD3DMLGKazWZZ3Fxai0fFkm5ThY35iutGenexfDNZwNpcO
 T39ojmXCx5KM1h3ddDPt5NYfbMAXKw+rXv4LGasIO9QBOMZxWb3FIFjM03PPVO/R5I5k
 jnImg1s6gwj+pH89wphyP3jd8xfw+yh3mu+Z7zP4TiUjeHJG+kvXwufCRSi4RdZlFq6N gw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1uctq6bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 16:20:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22TG0k4u177247;
        Tue, 29 Mar 2022 16:20:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3020.oracle.com with ESMTP id 3f1tmykyg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 16:20:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OE3SQ6g0S42PNKMMXQX61KPPpu5/zqNDFiYHoR0i/YbxBgvO5UeEankFYVnxYxNCVVyR42xsAeaYjIbn4vUfIVrY/dvvLJay9w1msJE8M2whx4+pm+QWW2FA2Ef+Rme24MH4xs7ee1cGEFFa0nGE6meHvL2gfExoV6TSRrShSiPq6KYleHWW0eYAzsdoCMDzhNphXqV7GlkFzFmhDxAoNLXqOHXedraq28AtB0bkibHGSuM1+js0ncVEFSGYjlSyNuKdPieqC/YnPvh+RY9IrhrfNf9iKMWHuep7riVRkqK7jOugIpjQR8kvH1ykqoDYOqqvaKew3HZFsaa9ZUDoSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68yLPUudR7/6TBCHMpdQz/6vHauHRqDl/6qiOQSZZiY=;
 b=BYegB/YMr3W96Tq47eb18/Vnx4RrykiVDexCe/PHu+tovtH6/ykHeiIqU6EGHyRskgKr/PH/1k0xN+iCxuQRumFw3WVjpzDxyG/xZH8HUF0Iy8dPEXaBRkty3z999xXShuhT2Kk1UEbgs1tX0mARMYvOFUTsZF1YKaa7KvktlXoed0d8UNOzHq/7Pk+lDh37B5tqUf5DR+26E8JiXlPlWC1OaraJ63BZ3yFJiKees6CYxVLnQFwzab3s2eEqmWT9qQ6OvnpF6ZiQ4DzLG2SnWRPLeHE9rP6GJAQosBPPsoFXilZSko2mFfhIHfwyeEV/ROOFWbzX+CXX3fFsBR5KgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68yLPUudR7/6TBCHMpdQz/6vHauHRqDl/6qiOQSZZiY=;
 b=tNFLh34UNkm/vICw4rTdwn41SLe/+aDeDJyO0bSvx6dPb0ASUbk0gg93ergl0TppH935SJ1nrwdRFBKs029RDNXueFDWG9C8J7gLgJ4/4ZDC1r+k6UH0kY1aVs9/QYz+EbzYHGVvf2f5N1D2zrLdwOfGifC1A1/7KonaNomaLos=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by MW5PR10MB5739.namprd10.prod.outlook.com (2603:10b6:303:19c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Tue, 29 Mar
 2022 16:20:05 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::ec41:df7c:ccb0:22b4]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::ec41:df7c:ccb0:22b4%7]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 16:20:05 +0000
Message-ID: <612ef738-20f6-55f0-1677-cc035ba2fd0d@oracle.com>
Date:   Tue, 29 Mar 2022 09:20:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v18 02/11] NFSD: Add courtesy client state, macro and
 spinlock to support courteous server
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1648182891-32599-1-git-send-email-dai.ngo@oracle.com>
 <1648182891-32599-3-git-send-email-dai.ngo@oracle.com>
 <20220329154750.GE29634@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220329154750.GE29634@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:806:21::30) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53db6588-33dc-4e10-a415-08da119ffc3d
X-MS-TrafficTypeDiagnostic: MW5PR10MB5739:EE_
X-Microsoft-Antispam-PRVS: <MW5PR10MB57390332A59E5F997CA0A0E7871E9@MW5PR10MB5739.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wx47M6d56R6G1uk5miEKuEWAlwVdmRhDYC6EtQpCiTwFAjWhJ7awNszPWloBiN2g9o0a7Lnm5SXQVkpJc6LkQ4/vD4dKzyTXUfQ2rmTqeaCG1wpRrHfT5eUVLoL7gR0/UCxhWRXtG368Up7U7STnMIAZgKxYYYFu5YBIzQvGM6Bx78fFeMw5H6uM9c3GzWnrcSWGWYgCtrVMiEVrVHNuKbNh1VsvsdCxQJggCTB/5uafIkOiFHMfKVXKGsieNkkzGRzag1wQze/iDL0P4s99Pwul0mWR6xyQKtyEoWz/TaWX6HUNzQSCa4GttrxTWlcXane6YKrsP+WR138Q3QJUkydlbWNojdQCxXd5GnnKhcHPStEYQfKXK9AoSsvKYrSVegNLOrSiQCjSjYqF2KlN+iG3yPKE6A4Sd+uSiPSRGJJseLPntbSluzQ4jleJiEBTh12m52Awc6l0280Js7K+EXHr0JTdNQ9WoPG+fMIpsy5K2GGxR2K+SXX/fY7M4sFbBxBTfATc4L89joh+RgYAGhGKl0vG0QnDMJBl8wAnfQrHfe0KpVrm+5pWXVdh8lQpgBgxU5hzZxa1MlwpeZtuEm9uTPhCztx9t6BrreQiHcfts7B9r+4ARoNFxXV6T/X3KQlkXo69mwO85AO3yxp7tP8hLS1vzZCgLk1HlGxx01ihDPxnUMqh+hYzBRx3k3gOaWcx3d9YOccjCcBMK44pKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(186003)(6506007)(6486002)(508600001)(83380400001)(6666004)(86362001)(8936002)(2616005)(53546011)(2906002)(66946007)(6916009)(66556008)(66476007)(8676002)(38100700002)(36756003)(5660300002)(31696002)(4326008)(9686003)(6512007)(31686004)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmNYNWlZQkxEZTFwTjJvU2tYVG5QcWFrSkJ1YmJHTTV6eGxLWmRlb0xCcnl3?=
 =?utf-8?B?d3dJSzVKNUQ2UnAvdkh6VE9nTmV2U2x0aHAvUDV3TkUxZTc1Q0pmN3c1SE50?=
 =?utf-8?B?SllTeXBJU0tjVTNIcEJHcXorei90OVdxNHJIMmRpcjk3aHpjTW85aVVjdEJv?=
 =?utf-8?B?TUoxdXpDL216ejJzN1Z2bjZ6MmVaeS9ZWkpMbGQrbnQvTis1VXQ3TUhKcFh6?=
 =?utf-8?B?MERGajgwSUZhMVNxQjZjOTRNSXduWGR0N0h1dk95YjdNbmJGV0NVcGJrMEJx?=
 =?utf-8?B?alVkWGtMUmJZYTU4aXZ1VVUxNkxHY3lFZVB5bi85WFQ5YzBoQTNBZGc0OTJW?=
 =?utf-8?B?MktLNlJScVRyN0t6WEIycjNRUHdpN3cycDZHR1YxT09VZDkvclBNcDVWN0Ry?=
 =?utf-8?B?Y2drSndmUUxWK0tUSUVMUElnMlVPazdGSWRCUnRnN3gzb0pXQlUzSXJFbGo4?=
 =?utf-8?B?TTJrMHRETHVFeVZUN1VuanQwZzlGSkdlRHJLMW5tSTBlOXBpSlN6aFU1OGJa?=
 =?utf-8?B?dkpLRUdKVjRsMmxIZHkxekpxNDJsT25PR01naWpyS2xnUmhWVE50OVlKcWRx?=
 =?utf-8?B?L3gzY09PZG9GOWp5Y2hUalVESG8vdUlhcjF1alJpajVDYnRaUVdwR3R2eC80?=
 =?utf-8?B?Uk5GeHoyYWhKRDZPRXcxMFlRWmY1MmpHcXlZYmI2UXB1OHQwYlMvOHBhbUFO?=
 =?utf-8?B?bURhc0M2N0E5YTFXRVcrU01PRHRTbnRkcG83dzhaNFVlamwvR0Y3RTE4UlRN?=
 =?utf-8?B?REE5ZTlzODI5WXNjUHlmYkZZMWxzK1p1ZGhsbmJVMis5amFRVmhVMGw4ZzFK?=
 =?utf-8?B?RC84b2JteGJ4NUN0d0hxd0J1NG5meHFsSHR1Sktud2RiWnlJNmt4M21EdW5E?=
 =?utf-8?B?M1k0Z05oc2REOTJlRDljRE1nOFZPcDZ6VlN4bmRHdDVCcTlUV2JHbnY5ZlJ3?=
 =?utf-8?B?b3BNdHljNkFrQVBjdFVWdEkwbFkzcmRzOTlkRjE3SU9vRjNISVc0Mk9OVXlG?=
 =?utf-8?B?RXJpbnRVNWU2RE5HbGpwYkUyT3VCZ0ZyeEJjQmg1Sm5sa0dmSFpXVkg5MkVs?=
 =?utf-8?B?dWx2bVd0ODAwc2xPM2VjSmZvaGQrM3hyNUZTMUoxeERmMDhjUXFwbkNkbGJx?=
 =?utf-8?B?MC9sUDNONmdzWmw1ZXlJOStVcHRZYXgzVUNMZzVHeTA1NW5jKzF0MC9QMlRp?=
 =?utf-8?B?Z3pKZ1ZhVjUwNmlhTnNWUkQ1eHUrS2QySUlnNlJoWTNxZ0hUZUQwU3h2NXhR?=
 =?utf-8?B?NmF4cVIyVkxTeTg4aHpUdFNTbjV5K1M1bWF6ZDFtb3VrQitWSmFheGxTV25F?=
 =?utf-8?B?ZHZnL0hoTDFBWFhBSUVUTU54OFdkUWpDRzBNTHQ4aUtSMWQ1T1NvMXNpYjV3?=
 =?utf-8?B?Y0h2M1VlZC9zdVZ3alhRcmd2ZG96STI4bTJJRTBOdEw5blpRNGFRa2hOOHNH?=
 =?utf-8?B?ekxQRDlQTE52QXZ6UXZUb0ZKSzdFT0NmaDZyQ1drdnNmOVVjYWVRZFRrUGtY?=
 =?utf-8?B?a0U0VVI5TlRoSHphN3pXcG8vKzM0VFpqYVVpUjB1OXZUdnlQelpwMzREVVho?=
 =?utf-8?B?WGtJbGF6RnkwM0QzNUhlZXovc0hKeTcwN0dwNWF4UlFROVIwM1NkajM0ekxk?=
 =?utf-8?B?MkRYY1VjMzI0aGhzRGljY3c1S2xPaXZsOGZVZFVoUTVZTTVZUDNzOWVySStC?=
 =?utf-8?B?elA3ZzgzMFRkcWlJT2syRGtTR2h5SDVGUFJuc0RYY2F5V2s2OWgxVzdIc21Q?=
 =?utf-8?B?eFZZVEdTcTVKRzUwOGVvWDRQTXhFQjJXUktTZmlwWkJ1V29HSU9HM0NhZVNr?=
 =?utf-8?B?OXRNUmlqa1o0QkxzZDJ0NE1xajV1c0xFTGNDME80bG9yT3RPTEY3aWMrTmlt?=
 =?utf-8?B?Q0IwTTFIbHExSkdFUXVBaDVSZDNDdjF3UWNlaVVoQm1DK3FlZHZqRlhKM004?=
 =?utf-8?B?RlU0eVgvVi9OOXloQ0Q1bjBnbnhaZlhpeko5Y1pVYTFIdDNvem1aWlpsUjZp?=
 =?utf-8?B?NVh1SWJlOFN1R29LOG5yRld3bUdPanIwbXhGUWt3SUJNN2k4OGVPWkNoV0ZB?=
 =?utf-8?B?UUI1ZUhwRzZFVzk0Q2U0YXpqVGs0V3hxamJDREpwakMrYTFJWm1MSi92OGNR?=
 =?utf-8?B?bEVHbGE2WFJEbFFtVkwvemgrdzJXWkZOZC9ENEY1N1lOaHNlWFVTaUxDNW9E?=
 =?utf-8?B?M0Y5bVAxM0RObnpxUnhEcDFWeU9td0FMYVY0c0VSM2RLUy9jYWtYd3U5bTI5?=
 =?utf-8?B?bG1qU2d3bldoc0FKZnVrNDhrMVlGNGxaNEhRRDNnT1MwbDBMeHlIUUVJK3dX?=
 =?utf-8?B?MGJVWnVidGdGZnNLL3pnWWV2dDIwZFduNFFDdndOZVZGUU1CN2xWZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53db6588-33dc-4e10-a415-08da119ffc3d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 16:20:05.6966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0L6tFZA56YXnYs4LVrMv4xjGadpzjd9FlWlCZTcaQXIHTNbzl0bFSLiP6Sc3/eudM3zLWmZ31Z4r2aURb2INA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5739
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203290094
X-Proofpoint-ORIG-GUID: SqyZpb2GGvUQjhJ2u7K-Lyl8-6Kdm3ET
X-Proofpoint-GUID: SqyZpb2GGvUQjhJ2u7K-Lyl8-6Kdm3ET
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 3/29/22 8:47 AM, J. Bruce Fields wrote:
> On Thu, Mar 24, 2022 at 09:34:42PM -0700, Dai Ngo wrote:
>> Update nfs4_client to add:
>>   . cl_cs_client_state: courtesy client state
>>   . cl_cs_lock: spinlock to synchronize access to cl_cs_client_state
>>   . cl_cs_list: list used by laundromat to process courtesy clients
>>
>> Modify alloc_client to initialize these fields.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c |  2 ++
>>   fs/nfsd/nfsd.h      |  1 +
>>   fs/nfsd/state.h     | 33 +++++++++++++++++++++++++++++++++
>>   3 files changed, 36 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 234e852fcdfa..a65d59510681 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2009,12 +2009,14 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
>>   	INIT_LIST_HEAD(&clp->cl_delegations);
>>   	INIT_LIST_HEAD(&clp->cl_lru);
>>   	INIT_LIST_HEAD(&clp->cl_revoked);
>> +	INIT_LIST_HEAD(&clp->cl_cs_list);
>>   #ifdef CONFIG_NFSD_PNFS
>>   	INIT_LIST_HEAD(&clp->cl_lo_states);
>>   #endif
>>   	INIT_LIST_HEAD(&clp->async_copies);
>>   	spin_lock_init(&clp->async_lock);
>>   	spin_lock_init(&clp->cl_lock);
>> +	spin_lock_init(&clp->cl_cs_lock);
>>   	rpc_init_wait_queue(&clp->cl_cb_waitq, "Backchannel slot table");
>>   	return clp;
>>   err_no_hashtbl:
>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>> index 4fc1fd639527..23996c6ca75e 100644
>> --- a/fs/nfsd/nfsd.h
>> +++ b/fs/nfsd/nfsd.h
>> @@ -336,6 +336,7 @@ void		nfsd_lockd_shutdown(void);
>>   #define COMPOUND_ERR_SLACK_SPACE	16     /* OP_SETATTR */
>>   
>>   #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
>> +#define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
>>   
>>   /*
>>    * The following attributes are currently not supported by the NFSv4 server:
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index 95457cfd37fc..40e390abc842 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -283,6 +283,35 @@ struct nfsd4_sessionid {
>>   #define HEXDIR_LEN     33 /* hex version of 16 byte md5 of cl_name plus '\0' */
>>   
>>   /*
>> + * CLIENT_  CLIENT_ CLIENT_
>> + * COURTESY EXPIRED RECONNECTED      Meaning                  Where set
>> + * -----------------------------------------------------------------------------
>> + * | false | false | false | Confirmed, active    | Default                    |
>> + * |---------------------------------------------------------------------------|
>> + * | true  | false | false | Courtesy state.      | nfs4_get_client_reaplist   |
>> + * |       |       |       | Lease/lock/share     |                            |
>> + * |       |       |       | reservation conflict |                            |
>> + * |       |       |       | can cause Courtesy   |                            |
>> + * |       |       |       | client to be expired |                            |
>> + * |---------------------------------------------------------------------------|
>> + * | false | true  | false | Courtesy client to be| nfs4_laundromat            |
>> + * |       |       |       | expired by Laundromat| nfsd4_lm_lock_expired      |
>> + * |       |       |       | due to conflict     | nfsd4_discard_courtesy_clnt |
>> + * |       |       |       |                      | nfsd4_expire_courtesy_clnt |
>> + * |---------------------------------------------------------------------------|
>> + * | false | false | true  | Courtesy client      | nfsd4_courtesy_clnt_expired|
>> + * |       |       |       | reconnected,         |                            |
>> + * |       |       |       | becoming active      |                            |
>> + * -----------------------------------------------------------------------------
> These are mutually exclusive values, not bits that may set to 0 or 1, so
> the three boolean columns are confusing.  I'd just structure the table
> like:
>
> 	client state	meaning			where set
> 	0		Confirmed, active	Default
> 	CLIENT_COURTESY	Courtesy state....	nfs4_get_client_reaplist
> 	CLIENT_EXPIRED	Courtesy client to be..	nfs4_laundromat
>
> etc.

will fix in v19.

Thanks,
-Dai

>
> --b.
>
>> + */
>> +
>> +enum courtesy_client_state {
>> +	NFSD4_CLIENT_COURTESY = 1,
>> +	NFSD4_CLIENT_EXPIRED,
>> +	NFSD4_CLIENT_RECONNECTED,
>> +};
>> +
>> +/*
>>    * struct nfs4_client - one per client.  Clientids live here.
>>    *
>>    * The initial object created by an NFS client using SETCLIENTID (for NFSv4.0)
>> @@ -385,6 +414,10 @@ struct nfs4_client {
>>   	struct list_head	async_copies;	/* list of async copies */
>>   	spinlock_t		async_lock;	/* lock for async copies */
>>   	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
>> +
>> +	enum courtesy_client_state	cl_cs_client_state;
>> +	spinlock_t		cl_cs_lock;
>> +	struct list_head	cl_cs_list;
>>   };
>>   
>>   /* struct nfs4_client_reset
>> -- 
>> 2.9.5
