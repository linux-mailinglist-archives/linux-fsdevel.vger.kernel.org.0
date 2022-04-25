Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B7E50EC12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 00:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiDYWbm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 18:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbiDYWba (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 18:31:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A54463BA;
        Mon, 25 Apr 2022 15:25:32 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PJORaL023432;
        Mon, 25 Apr 2022 22:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=N1+Lh0HrjXDVuPxPrX6TNrfByJpUXpB1l2JiN+RoVv8=;
 b=qDn32VmbQPA3yoRZvLQvb16dpNQvDe+Jxm/0VU00UP7LLfL/P/2dMWS483CBhWG3ij1G
 1F547S+1sfJs/0zX3GPaP2grl2908VbmV5g+rZIx/QqY5bmrioGUfMneUXByngTmNsXC
 xG14sRFLAe26i0ps1CeIhdZ9JtrxcwYbrs3N8ZcieNA/3IYZOe8StlLYDIIFA7yAXh2s
 8tf/0jjvun0TUVlWC46RhQI15N3GAAaeVifYEIQ83EAHiuMOh+URsilKHXadC7xdIoTQ
 1K3v4QruXs0l86xKMrMJgwQ4HRltvFupYr/Go6Bu6UlL/t4rnB0kw3lhei/GohfKxCLU Fg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb0yvd1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 22:24:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23PMA2AH023871;
        Mon, 25 Apr 2022 22:24:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fm7w3218e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 22:24:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIkYLU+iW7OOk0DBNzT5euaMaPp27FrfOHU8jSJZYxSruZBvZ1dbvjlS/MWk4T0cocGThFN6yh3Hs78TxvhQH3ghnujFUGMoNW3l8ZjV4/vWm8cyyLQcmoxeedEUx/sNSQVtG3Di3TXQeTphvnUKFPhVkKY4LEHGhskKAQW/1Tu8ojANVxkpDgZiZlIVkq5w/xzx/TGpa5KiV2QdUOdqW6H2xrHSrJTqdutNxLVLU9MP2zXbzgoEZg72w2YhkWHUZZ5OYh97at6wrGzvYkhTTcG8ORb4t9itoTcpuiFwniga2DZX9vY8snJJjKYG4dx8nsSVvEGuQvDdLMvXNd3x7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1+Lh0HrjXDVuPxPrX6TNrfByJpUXpB1l2JiN+RoVv8=;
 b=LpZC8EXAxKdJBoFZD6hxmfuw8dI+xtSrw0oFJXw8mKJ9GZ50762z2GDo667u8DR4WOUmzWYwtT1e6hvXKNR0N7KpIxsUT0z4N7repAizDW46aMuOF+XmW9Cr/UUuCkMukIp1YIxaSr9xUMd7Qo1fsp393HxL+8umeoUcixwCHIjPDkTUyIFVgSu8PZ2Y02qVdtFb/f+dPl8CuQesvIwQ8FRUW2WhR3f2FOU7JIwL+yMZvXuCzqji8u8khwGt5rfA87uDny90RveOeoZgjG5isWwu2pE+9s3dgMbPBFLgJWC+TNigh0jzt8LLgwRz5SkTqPkjJbPBdHzuPhPrgLprbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1+Lh0HrjXDVuPxPrX6TNrfByJpUXpB1l2JiN+RoVv8=;
 b=CwIRm0d/lzY9Hv2kLhNexcOwmVQrEc+9+JgTrrFS1Xv4FSn6KD1Agll7twiXX0YrxYgGRVx7GlaPq/dbA2jgMXuY5O0aTt6J8wEawaJECni8H7Soh5h3k1uV8n7/bU0MJAN3cTIcOUTylPqE0jNFeZf9QyCDWnCS6q9QvG0+EIc=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BN6PR10MB1587.namprd10.prod.outlook.com (2603:10b6:404:47::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 22:24:51 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::29d0:ca61:92c9:32c2]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::29d0:ca61:92c9:32c2%6]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 22:24:51 +0000
Message-ID: <fa1d32f4-f322-1894-2663-accb35363a2f@oracle.com>
Date:   Mon, 25 Apr 2022 15:24:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v21 1/7] NFSD: add courteous server support for thread
 with only delegation
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1650739455-26096-1-git-send-email-dai.ngo@oracle.com>
 <1650739455-26096-2-git-send-email-dai.ngo@oracle.com>
 <20220425185121.GE24825@fieldses.org>
 <90f5ec04-deff-38d0-2b6f-8b2f48b72d9d@oracle.com>
 <20220425204006.GI24825@fieldses.org>
 <e2b3dfe6-d7c6-3bb1-eebb-0f8cd97c27e7@oracle.com>
 <20220425214850.GK24825@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220425214850.GK24825@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0143.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::28) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3028752-a81e-423f-6731-08da270a6a17
X-MS-TrafficTypeDiagnostic: BN6PR10MB1587:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB15872A23DC50D7EA3787A36F87F89@BN6PR10MB1587.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dYVV1rxebLpdR9mP7QcSOjJu1qmHZY3lgoC74tlAGx/mqJTDoJlJuiewTHaYuJExUBL7w13rAYNMhprEhy8Lf3S8ReYU7SfpJOk0s84yDfuJSfmnEFRfs5WjF67DVd9PC1lRUdI7Kj/WA+pmZXp/6D9lzNReVU2BVXhwTCff9k/msN1K7BY6cRDglV8ngh5p1v9LA18T8WlxuXcL1ATIHfdnnfdYh38/5iJNBvYRlC8K8l7pcssArIb+aD/W4C54/7/oJOHDjL2EmoreJSKxlrCEr7FeQxoxYm6GWh2wqepA7SGOtg2aV6ZUifc1MCuWYHPCQuEFecVCOWNHh2Jnp+4FjrVOD/So3I2g5yZj4oRz2lgoHcJnMAz6DtYJs615IA/fkicOJHiH6Pl/IXkiu2fZTMaLCCpZnu8XeKIwN63buyJ1TPAFEUqJ/+lqEknuQpxEBY6sxNpmHb6FW76Xw0bchQLgqr8D12RxKnfmJTVIsOwzXOFN/8aAHPfwzgIdc36eHyFNH8UP+2Yq1SwwmHLU9Mf/Q5cOx9Bea/i0CB52cuyCAY1YlYUWHCrISfSLRE5mkiNDDdJzIAUpDhOXHdWdu70yrO4iVeWAW1jOXRGt94UVLIwcRi+d/fl1DWFnt1TWBWpETsJxMYie/eDtSzpvS0oyR/WtIUG9fVOjJrPWm/Dj7Iq1bWomdJMM57BgSeU/ORwnUxaJZBRLX3iIRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8936002)(6506007)(31686004)(36756003)(26005)(6512007)(9686003)(508600001)(6486002)(53546011)(66946007)(66476007)(8676002)(66556008)(83380400001)(31696002)(86362001)(5660300002)(316002)(2616005)(6916009)(186003)(38100700002)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXhNanNIZlBoUzNiVXhDTWxIVlJzQnN1QWI5MElWRzY4S1BTcU9zNmlBRnV0?=
 =?utf-8?B?TVNqS01hUWkrb1BWQzNIZnpkMFYvRm1zTDNLMmIzSEd0b01IcitjZHlqSmtM?=
 =?utf-8?B?V3FGUXIramxWU0VDSDVnd2pWbUpPQzlUc0lmTGlVU1p3QTFKaG1RUjRpNWYz?=
 =?utf-8?B?S0Vyc3BMem1wWm9ic1h4cTl0VnFGdVRqSmhiRnYrdGp4YzF5dCtDbTlVMVRu?=
 =?utf-8?B?NUFTK0ZiUDd1dm4zczRUNVVpVXljUnFmdkJkNzdDeldSWkRBMzhpVU5XNjNj?=
 =?utf-8?B?ZFVqNlRxdlRRYW9OQWN6ekZpM2t4ZksvR3pvMFg4ZGdmU0VMMDJkRmVuZDhl?=
 =?utf-8?B?Q3IzSDV1RnBZMTZ2YWc5Z1orYWxiTG92VTk1Qk1iMktOUnh6N1NwWlFzd09E?=
 =?utf-8?B?cVY2NUVudzJwOTFGMHBJdzBtMGZ0KysvbGNyaXdDZTA0MDFtMEhlNmpoSlRV?=
 =?utf-8?B?U1Jrd1JOVXNDTnpUZFNsaWpzQThCVE9WMmUyNEI2R3RlMXhzZ3ZJMmFWS3NS?=
 =?utf-8?B?MEdEaGpFcUhFK2x3VU9mTmZHNkxDUnpxUzAyd01SZVBtT2RTKzZoaGZ6cmlU?=
 =?utf-8?B?ZlMyZkJaU25QRFloaXZvRlhEbEliM3hRWTV0dzRkMmN6UFoxQWZNSklWQU9t?=
 =?utf-8?B?NE95TWFtZzFnQUxJUUhXdWc1YmxsVVNKQzVHcHZ5elVVUFNVaFV2WXgrNUg4?=
 =?utf-8?B?N0pkcFhzYVNBcVAvQjhFMFp5VGNBclB4bitmb2o5ejRtalRuYzRCaVJaWW1n?=
 =?utf-8?B?ZjM3ZjBuSE9KWk83eERMVnFLQVAwZW1Dd0gzMnZRSXB4VFFPdGJtNmxyUEhO?=
 =?utf-8?B?YnFSZFpUWVRqTG1SYlJiUGlVVytQQ21lRWdoclE0WUg3RXp0ZUhVTm1zT2Ni?=
 =?utf-8?B?cVlvRnh5TXJSckFHUnRSWGVOWlJ5WTVPd3k2WE1uNUo5d3hPbXovMDlDOVU5?=
 =?utf-8?B?anhRaVZ4M0x4VGwrQ2ZrOEErVjJRV01HR1ZlT21RL1VXUnZKK1JYRDlCK3Ny?=
 =?utf-8?B?dEZhVDBYU3dTRktTcHlINVZsd2JobUJXUXk3Yy8vZmhZNVhUUFRZZHMvK0xr?=
 =?utf-8?B?ZzZJUjJMVXNUejJkNk44UjJKci9wYjRsRzJpYWF6alJnaSt0ZUd1bURzUEtY?=
 =?utf-8?B?L01Ib0ZwVTJZU3prVEtrS2dpbE5CYmVQZW1WVkxseVlCRWUwOWdQQlBNR0tY?=
 =?utf-8?B?YlB4NXRKTjJHdmI4b0lIOGt2Qm1TV284ekZxcXRocTNmWjJlSDlMc2tDYkxh?=
 =?utf-8?B?aFZlcXZ6bzNRaVVmdzJzRFFNRzJzdUxDcjRIV2FBeDQrUFdkSGRLWjNicnZH?=
 =?utf-8?B?bW5WSmhnWWc3dUtOdDRadzZSUGFUVkVrUnJRcGNqTG1qTThFbms2aEIwbDNW?=
 =?utf-8?B?bVhKb3hjdWMxbnVTWTdqM3ExVkZqUW15TlBtc2dCbVJkcEEya0ZwQUhLbTUy?=
 =?utf-8?B?cmk5Sm9vT0o4OUlBd3h0T1NGcmRRWGlkSXN5NVJPVHp5dUpkWVFUeEV5WGkv?=
 =?utf-8?B?RktoTmRCcTBSLytCNVFsVFlTNHNTSmUwK01BYkhNSkJNV0tKZ2xPN2NpRXRp?=
 =?utf-8?B?RVJ5UzJMQU05Q0pralNkMVlLblBEUDJwcHByOVVseXpZZEFmelM5MkovTk5t?=
 =?utf-8?B?L2Z3SUJsLzFjYXJidjBIWU1XR2duR0czUlZMZDZIMnNBd3FaVDNOcUlVU2ta?=
 =?utf-8?B?bmtTcGZUeEY3ekVWRkFKQnlMQVhFd3VkRWFsN0dqRVM5UUFxR3pJcVk1UnRB?=
 =?utf-8?B?Q2J3WHJpWFpaU3dMVXRKOHIraUZKbWhyOGFCU2p2Ny9jSFFsTGh5YjhLNlIv?=
 =?utf-8?B?OWdYZUJLSEZzd0Z4c0ZJcWM1SVJGMmhVc080KzR3Mi9pNTdwNjh3SmpENCts?=
 =?utf-8?B?SWhzSUVmUjgwc1FhYTFwUVJBRitmbWlEVE0rWjM4cGJMbGdMUWJGSjJEcUNt?=
 =?utf-8?B?T2lJeVdUNFNnU3p2VUpmRDRwOW1makJDc293YlozZVZxMWFoNHJqcGdEQ1g1?=
 =?utf-8?B?WTNvaFFXQTg3OWxyS3dNaUlCMEhQSlkwVUE2cXhZNTh0ZWVxNG13UHVlM0Vp?=
 =?utf-8?B?VlViVHc3bXlsUlNRZ0FGWGorRHoyQUcrUGh2OUtsSUxtWmtIS2gwVFJCN3N2?=
 =?utf-8?B?bmhLY1hzeHBrT0xPOWM2aDQyZ0diR3YzV3pLdUhUOW9CbE03NTNBSGRyQndD?=
 =?utf-8?B?R1dKaFBoQStoQittQzJtTlYxTUw3WWNJUDkrRlp1OE11ME5DUnlJak9lN3pB?=
 =?utf-8?B?RFpBampoNzNNSWp2NDVCZjFRRk95a2crZUdwYWhNb0lIa2lvUXlVdHNIa1Vy?=
 =?utf-8?B?MGtZZlBGb0U0SWhnTXFOOXZmSzBLcDI3aGliU3RsM1A4KzZFRVpqUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3028752-a81e-423f-6731-08da270a6a17
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 22:24:51.0670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLalVGHggElJj8eoB7pINQhvipgl8q3DYOwk+YZr8cg4QrXrC3yOf92vn+VdgYENAouWMMqeNo13D4dIrN4RBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1587
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-25_08:2022-04-25,2022-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250099
X-Proofpoint-ORIG-GUID: H-t48i3FrSf9CnA6FA-OAdzvAEsqbQ88
X-Proofpoint-GUID: H-t48i3FrSf9CnA6FA-OAdzvAEsqbQ88
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 4/25/22 2:48 PM, J. Bruce Fields wrote:
> On Mon, Apr 25, 2022 at 02:35:27PM -0700, dai.ngo@oracle.com wrote:
>> On 4/25/22 1:40 PM, J. Bruce Fields wrote:
>>> On Mon, Apr 25, 2022 at 12:42:58PM -0700, dai.ngo@oracle.com wrote:
>>>> static inline bool try_to_expire_client(struct nfs4_client *clp)
>>>> {
>>>>          bool ret;
>>>>
>>>>          spin_lock(&clp->cl_cs_lock);
>>>>          if (clp->cl_state == NFSD4_EXPIRABLE) {
>>>>                  spin_unlock(&clp->cl_cs_lock);
>>>>                  return false;            <<<====== was true
>>>>          }
>>>>          ret = NFSD4_COURTESY ==
>>>>                  cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
>>>>          spin_unlock(&clp->cl_cs_lock);
>>>>          return ret;
>>>> }
>>> So, try_to_expire_client(), as I said, should be just
>>>
>>>    static bool try_to_expire_client(struct nfs4_client *clp)
>>>    {
>>> 	return COURTESY == cmpxchg(clp->cl_state, COURTESY, EXPIRABLE);
>>>    }
>>>
>>> Except, OK, I did forget that somebody else could have already set
>>> EXPIRABLE, and we still want to tell the caller to retry in that case,
>>> so, oops, let's make it:
>>>
>>> 	return ACTIVE != cmpxchg(clp->cl_state, COURTESY, EXPIRABLE);
>> So functionally this is the same as what i have in the patch, except this
>> makes it simpler?
> Right.
>
> And my main complaint is still about the code that fails lookups of
> EXPIRABLE clients.  We shouldn't need to modify find_in_sessionid_hastbl
> or other client lookups.
>
>> Do we need to make any change in try_to_activate_client to work with
>> this change in try_to_expire_client?
>>
>>> In other words: set EXPIRABLE if and only if the state is COURTESY, and
>>> then tell the caller to retry the operation if and only if the state was
>>> previously COURTESY or EXPIRABLE.
>>>
>>> But we shouldn't need the cl_cs_lock,
>> The cl_cs_lock is to synchronize between COURTESY client trying to
>> reconnect (try_to_activate_client) and another thread is trying to
>> resolve a delegation/share/lock conflict (try_to_expire_client).
>> So you don't think this is necessary?
> Correct, it's not necessary.
>
> The only synchronization is provided by mark_client_expired_locked and
> get_client_locked.
>
> We don't need try_to_activate_client.  Just set cl_state to ACTIVE in
> get_client_locked.

ok, what you suggested seems to work. I will remove try_to_activate_client
and just set cl_state to ACTIVE and test it to see if there is any problems
that we haven't thought of with this scheme.

-Dai

>
> --b.
