Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FA950E7EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 20:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244280AbiDYSUK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 14:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244276AbiDYSUJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:20:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B843B285;
        Mon, 25 Apr 2022 11:17:05 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PFpXiO025669;
        Mon, 25 Apr 2022 18:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UcFUbJgCRLEJ6fy4rQjXKxHb2KDxOSylW6dX9dyrbYw=;
 b=uvTFIjMelwSSpH4iImRsF7867RUWcNt0pnHrFhTXeH8C0BIq2K9HGFthyOykXGMDRg9n
 LtR8vFIIBokWFWEcDySv9L7ZciSIJtTPhysQnlRUGeCAgVyHg1QVxFWCqMlj3DGfYnol
 1ZZ1RZXxpBS53NTa3GLPZu+4oAYrJ7uuP0lIs4JD6mvFsHivuFMAEBdc45/qBiJX+Laq
 K7hgz/qjtPh4IT2wL2kAnqMffetKIfzpuVWul5W37m9PlMyM7YNg0P6lpoQ5UJ3xrtyw
 5A1Fbn5yAfg7YGxLNAwafBMW0OWSD/yFD/xmb5ry5J8XJMoVUUU4lzVrVjCzN9I28oKd xQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb1mm1ky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 18:16:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23PIASw6019289;
        Mon, 25 Apr 2022 18:16:59 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2044.outbound.protection.outlook.com [104.47.56.44])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fm7w1ygku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 18:16:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2QAtLOiAbZypNgMS9DHyNaAzKgYyqlb+4uOGeu19ydTghPbBTJbcQ6hwfzfFVVhvWZi5fYkpeXd3sassCJ0uYqOS9CV/NE717p/mDwydBHoEBv3Lem347AIE7ui1UMGxPdrZ0jIc5gafJbm+D2uCtjLMb50XW2P1gLFiw8S3wMXLx5ZVkSKaTFpt8ewPteeWTRn6gH2ylD4kfMlJV7EEPTJnS3fxM+AzXBQAH8qHIeCeLwfMsKYEyLrmrWFUDVS/DUT2PGRBk505/sPNQlawhWHIhYRmztrSrgG8sbclY++TE2sg3QdblbpHqOQ+FGH9XyeUj0shHCWt/w/SCgPwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcFUbJgCRLEJ6fy4rQjXKxHb2KDxOSylW6dX9dyrbYw=;
 b=VPVZXwmHInHbIr3cDePlflWk1MS20wpj84o6KOrKU2twkJu0aAFDNEoJ2yzNWS2cHqZ/qzSwGjl9HvLdA3o4cswCzRnxmi6vvbra2E21Dr9N2NELJboFIcTJe2hLo1EgxpKPE785FSl3PUV39J7nuz+reFNcCNo11xCM+SfHpby72ervgY9Kc1jI/nzpXOc5/ZwKVSJu9yNjsGPS7bAKyz1Nf0GrMVcWchUfsrQRnL27vN9Kp0CRaC7Z2fb1N9FyWSnOwErYgbgdGFxRmy8HpxgbAPDC+x++hifhK+jWZBKRdGyhlBkv7EX/cwxwKbc7eJ7Bu1jLjYRHqFueBNjv5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcFUbJgCRLEJ6fy4rQjXKxHb2KDxOSylW6dX9dyrbYw=;
 b=cRWlFuOO9jvoLI3xNAWUERgapPrUaQH3GEfI3TczZJ4sP5+ioaf5hyLcCXqltCBfTsTun1O8SwPA4MugElN31Uc9fNusih+ubsgJzmUuqSijFXYPLbktWE+LaSuFQMBdVzfnyTVedNzdXq2RG1d9o6cxtCPHkYOd/z7suDrjXzI=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BN8PR10MB3570.namprd10.prod.outlook.com (2603:10b6:408:ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 18:16:56 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::29d0:ca61:92c9:32c2]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::29d0:ca61:92c9:32c2%6]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 18:16:56 +0000
Message-ID: <ed6893fa-fbb1-36a7-226a-4436edd34644@oracle.com>
Date:   Mon, 25 Apr 2022 11:16:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v21 0/7] NFSD: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1650739455-26096-1-git-send-email-dai.ngo@oracle.com>
 <20220425161722.GC24825@fieldses.org> <20220425175327.GD24825@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220425175327.GD24825@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::24) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cb313a4-3867-4a4b-bef5-08da26e7c81c
X-MS-TrafficTypeDiagnostic: BN8PR10MB3570:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB35706FD4F2AA9ADABD85FDFD87F89@BN8PR10MB3570.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nZ26zaGZej6sEFY7ATdsvYqd1kFRToLtk1i1FIVBF9Wr1Sjf4/x8/DQXaRpMgo2pUNKqggEEuCIHYFQU/nHDu7yDMIXR91dKHDLhlfl0XhWAdmUuy3SFB0QEN8nMlzcnIvVRVOiJMmKZYbJE6HpGjrTmR7UldmSgeEHBNqzuaSucVKgLHxXJzH4X+mwTWkoTWhGuhZRSShBeeR+7kKEWMndXZsgcxL4hytH8fKFVnt+4KQdY7d1RVWr+1lHcRut7n5ZbEsOy152TH7rxQCFFJ1nEsnDyWBliBs05HHrEANLtnmMXbW4Q95n4nPatmnMavaOBdDX/riwcHJxCWNnxw8yIb1wf04ujyFw/bW/2AdvlPb6aBYD1vQW6XecOa9wWRCGHeJs/8Jvi/PDAyf8rJXf6JFqwTOKqbScXq+kFTD12aAFqb4XhkwWh2dL1MfKYThIan5tHGZSxZqTHJq7mhvXo/14P6h1mJuSMY3QCKtTZC1XofBvx7fwlnbKN+EC2/NXVPvU+X44qfu9bEbp6szvpu5SxlR2mAu0OH4yT7NYP2tukAVU2dnFV/n3BLDzS2ot34cYzGcyqsb9167H0bgNPePDvTeaxWgiNEVkOiSmTp4vFxAgmzPDCqoIU4I2rVDsnbJCRjGlwW2My4gEamlXE0Ne0+Ax2qhXCpb26wS0g58npBuj4FeJmj8XNDgq+xP7HA/4uAkmpdnIwjKam7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(9686003)(6512007)(19627235002)(53546011)(83380400001)(38100700002)(316002)(36756003)(6506007)(5660300002)(31686004)(2906002)(31696002)(26005)(186003)(86362001)(8936002)(508600001)(2616005)(6486002)(66946007)(8676002)(66476007)(66556008)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWc3eUtDNUJYeHluY0RoY3kvNS83NURRVEdOZ1IvNXFCWEJ6TkNQWmVXbWVF?=
 =?utf-8?B?anBuUGM3b1I0VENoczJZazdUVVVqZ3VtdkZhaTl1WXFxU01Qc1dxb0FKUC91?=
 =?utf-8?B?aWRJYStmaHFxc3NuK3pnT003NkxuRzRhWXk0cnRzbjZHMndQOWpUSm9HRSty?=
 =?utf-8?B?YTlSWXM4ZC9aMVorbXB4c0ZqNXNUNlp5bDJJemR5ZkxyUHZHem5RcEEvejZp?=
 =?utf-8?B?anNFaFdGbVY3OXJYS1p4MXZVWGZ4L0JQblVsZkZIUGJRZ0psSG5tYjhjMU5Y?=
 =?utf-8?B?Y2RWQktQN2kvejJzbHFNQ2dvdWcyOXNXSUo4SkV5WmdEUExyd3BNMTgzVzVH?=
 =?utf-8?B?VlJvRjlPYjJUWkxybXl3RE80WVhLK1Vmdmk4U3MvazlVL3lhWmp0QnI0ajdT?=
 =?utf-8?B?MnFvaVZSYWpQYjlzcm5DUDNlc0ZiM1hBbEEwWHlTRmxpV2dCNXdWZHZpaFNq?=
 =?utf-8?B?VTNpSG5zVk9scXdnUm9HYUNSMlJLcVZVS2NDNzROZFdZak5LYXpidnBBNlNU?=
 =?utf-8?B?TjdteklqNU5ieGE1NWYydENSZGd2QmdHVjQzMGdBc1RBTmlTZGo5Zk53Tm9V?=
 =?utf-8?B?cC9BamJPTHFMeGJKSlF1Wld1RmxRT250cFVzR0trcnRnV0dmbCtZUmxYZnJO?=
 =?utf-8?B?Q25aQXNrNmpkUzdzeUxuTFRGQkx6ZVd2Mi9jdUpTR2tTNm5IejhZSEl4ZWhs?=
 =?utf-8?B?VTFBSXQrc3BwWnZmTXI3dWhHdy9UZE0vSmM5ZU00b1d5T1NoMkhBT2FEWElJ?=
 =?utf-8?B?azdIdTcxczl2ZlFiZElhb1VITkl2MjBoeXphMTRtVFA4elhWWWxsQS9lTG5q?=
 =?utf-8?B?TFIxT0VMaGtGajlXb05hQmVRZmE0V0EydVJIazNZODVBeTgzM1BZT0xLT25t?=
 =?utf-8?B?ME45TmM1eDlhT09lOFhLYUNCaWdIV0hwaG0xVW1obmkwZWFIWHltVUk0YTlV?=
 =?utf-8?B?MXZFRjIvelhUcWRYMW41ZTNVYWRoSXkxSjNoU0tjSi8wbFM1VVkwaVBUY0wy?=
 =?utf-8?B?K08rb2xSL01laXpWV2lFSnpLWHNFb2JramZ3aDFCaUY4NGIyVXFtZkZhTW1n?=
 =?utf-8?B?VVdEdzk3TlRzNnpkVEpaQ3BVVzdZdDA4Q3hLaEZGQlpaV1kreEJoRUYrWUZk?=
 =?utf-8?B?OEdETE5ia1VzMitmZGw3UGx4b1BjNDN6UTRSUms3OTIrM3hibzVtN2Z3K2pZ?=
 =?utf-8?B?SlBtRkRQRkpha0k0S3VNNkM0MEphdU9TalV3ODBqN1NUVXFOTU1JdU8vb3VE?=
 =?utf-8?B?UEY3M0JVaFcybDBnbUh0NFBTM0l4eWdrdGFDT3BVWTZ2Tm5oRFZmSnhKZWFp?=
 =?utf-8?B?dUwyNXBKVkErRE9neS9kQzAyL3BFRjcwT2VIMkFiMTBobE9rWXc2UzhBZ290?=
 =?utf-8?B?cnV6QlczMEhtYnh1ZytaL2plUG0rWlY1dlV5UmFyQ21HTHFuVlZhdHBqUlFZ?=
 =?utf-8?B?MnF1TTlNK3ZCK0J6STY3QmZGb0UxUElnaWhqa2UzSXIvZnJCWWFQa3M2NDRI?=
 =?utf-8?B?ejV3OUtHNUxEUUorWjBNbncrS3NndndJc01VQ2J5bWFQQ2ZkeEJ5QXlOU0U5?=
 =?utf-8?B?RUczNWxKWGlaTDNIUGZMMjEzTUNiNndTd2Q0SzFNQ1YzRElVaVV5UWlBbHFW?=
 =?utf-8?B?UVR2NVhqN0FCMTVNcHhSWjNyZ09Bb3FWeUNZYlc4Zmk0UThmZ2xNblZJQ2lV?=
 =?utf-8?B?a1NrNGo4MmhSZUt3WjdMb0FlMjFuVnZXdGdESytJczRsdysrZTRML2hJVGZh?=
 =?utf-8?B?a2NwM096T2RmVVg0WCt5eFpSSXkxRW94Qml2RmRZaVJrNVJlS0JpM25KR01k?=
 =?utf-8?B?YzU4SGF4bkRmRnpXZG1IVXcrblJ0UkJMbGJkTHhuZE42clFNN0ZxME9SQlpW?=
 =?utf-8?B?bC9oc1ZpWEZYb0ZkRE1HTUw4YzJLcVFLUlRHVzZ4N3ZEakJ6dXpkU3hZQ2hH?=
 =?utf-8?B?eml3ZktZWHZUeE42WDE3dlBuRDd2Qy93bG9mZ2U5VndsaFlRVVl6bitoSDl4?=
 =?utf-8?B?L0wzVkVoZHNyQllURS9iNUIyRWd4TFE4TWtMMW11Rk54UktDbTRYM3cwZWw2?=
 =?utf-8?B?VHY5ZWxZY1BPSmtnenkycGxvdG0zR0UwWmYrNmg2azE5LzBTQXpsTlY5cDVn?=
 =?utf-8?B?dm5pWFJ2aWphYkJHTzNZSkZCdHNmK1I4cEdZMVZJZGNKa2tZRHFodVBzUkI4?=
 =?utf-8?B?ZGJuUXM2ei9HSklQb3htWHVDc2hHN3RZZmR2S2luVDBNMmFvZ2x3UXdxeG0x?=
 =?utf-8?B?ZVVCSXZjQzR2S1lwMTBMVjZTbmo2cml5bXUwV0J1Y1ZWVGJ3L1NqTXF2ZzB2?=
 =?utf-8?B?bnpnWEdCL0haazh3Z3pZYlVkVk1qL0grNHFCUnBlalhXMTZ0b0hQUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb313a4-3867-4a4b-bef5-08da26e7c81c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 18:16:56.4537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FwPY2w1EsBI15hHmYbvRRCdcD/G7jObHCbxvCvdcN81jXQvqrrJBhGph3Lz9abC9Ef+AsiGZWPzDbpcUmg7iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3570
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-25_08:2022-04-25,2022-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250082
X-Proofpoint-GUID: OnORi3KsRGdgt1trfeiWOy-OSfJmxY8K
X-Proofpoint-ORIG-GUID: OnORi3KsRGdgt1trfeiWOy-OSfJmxY8K
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 4/25/22 10:53 AM, J. Bruce Fields wrote:
> I'm getting a few new pynfs failures after applying these.  I haven't
> tried to investigage what's happening.
>
> --b.
>
> **************************************************
> RENEW3   st_renew.testExpired                                     : FAILURE
>             nfs4lib.BadCompoundRes: Opening file b'RENEW3-1':
>             operation OP_OPEN should return NFS4_OK, instead got
>             NFS4ERR_DELAY
> LKU10    st_locku.testTimedoutUnlock                              : FAILURE
>             nfs4lib.BadCompoundRes: Opening file b'LKU10-1':
>             operation OP_OPEN should return NFS4_OK, instead got
>             NFS4ERR_DELAY
> CLOSE9   st_close.testTimedoutClose2                              : FAILURE
>             nfs4lib.BadCompoundRes: Opening file b'CLOSE9-1':
>             operation OP_OPEN should return NFS4_OK, instead got
>             NFS4ERR_DELAY
> CLOSE8   st_close.testTimedoutClose1                              : FAILURE
>             nfs4lib.BadCompoundRes: Opening file b'CLOSE8-1':
>             operation OP_OPEN should return NFS4_OK, instead got
>             NFS4ERR_DELAY

with this patches, OPEN (v4.0 and v4.1) might have to handle NFS4ERR_DELAY
if there is a reservation conflict. I had to modify open_confirm (v4.0) and
open_create_file (v4.1) to handle the NFS4ERR_DELAY error.

-Dai

