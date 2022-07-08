Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFE756C437
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jul 2022 01:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239782AbiGHThT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 15:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238583AbiGHThS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:37:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C9565D66;
        Fri,  8 Jul 2022 12:37:17 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 268JSkjG022438;
        Fri, 8 Jul 2022 19:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=J8f8DHUrqcXANUze1+cElELU9u2GMAMo4Vpv1gWP0Jo=;
 b=PMI2tOgwmMtuC/UrioMXhodwoeqwFTTIGJjin8wYHQZvBVVNYWo1EWFFQcK7OoerOE+C
 SVUL02j1BLOat8HB9daZIH59EbW4bNfbjb2l8MPBotDBrtDnhVnAusHh4zY7/8r4o6fH
 evSy7nyFoaNUSxfgCUTqOJZXtgD5LZRvBsFrCaz5yw08YUplD9cdbMPAum7Ro3tNKwqM
 VLX8CA2yORRbw/OG+S8DdQO3QZ3f68CE75839fFNFMPHt+gXnM8vGNQumc4ynACCEqOf
 lGGs61/ZeK8HChUQO+NePzR3OguqTB1m3w6X6HzeioIewoV3UmyguJQLP23VP1FrCOe4 FQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4uc00tkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jul 2022 19:36:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 268JUhC2032301;
        Fri, 8 Jul 2022 19:36:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud82sgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jul 2022 19:36:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoB4PSE6GmgU0+kWaUxJjbyJgi3eyZHhej/up4L4CTvTCi57UKigq7sLuL1cRN8Bxr0QythyDsS0B6BgW9NEOyS1fL00gwKGU9br4P7D2ZSSzqN6lMJdFbfcegdpfZzjRsZyTPGGfK+ukv6QGeh5nXyWIa6o4QvZYtQOfpwAJTbk+6OdqBURnZRgtj+lQ0xz/MCKXvgQTKje4ZgzK3nX8o9E8iaCDWxKxX1YntBpDvpwvPMLZ5wQsYmv9LrKLRFm4aIBo1ONel1yXXC2ZJuMA7r1G0eWAPQzxM84SvONFRXq66qQ6BIj1fAx9UfrOa+2nrqo0tshhaEBhFnCoH8C6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8f8DHUrqcXANUze1+cElELU9u2GMAMo4Vpv1gWP0Jo=;
 b=ZtkThM/6Fgp2o+lEcUrA8JY/aEAbLEvOR9hz1nVejuZ4yfxPYRADonQByJlcLUw8PusfUAfXmx6JKEi1r0zLRnewypvKMT2NEqf+Nw4m1f1XnNJhmwFgNU2cqUwbNpPHC9FHjxfPJu77PCavYX4jPGZuZWxO9BHoJYLxNo6JPD2OCRm0c+WXaVWhMpJ2ijFVW9bSsNHvYCPo2IKrur5UGF/U2BlNiT0xidCXQfYIIse7Rnr/q7TqrLTSFIgXWdyPoTf0z0JFOAkYIuHX3phyR85eEovS4KNOEMJOMTPDnBHl/xO6q1G4RyLhqFUg9NsoBKBaMVSNd4T/UNI8LZ9mXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8f8DHUrqcXANUze1+cElELU9u2GMAMo4Vpv1gWP0Jo=;
 b=XSwwLCmJk4+F6NSvpaP6f4sg0lZPXzVEr4k1EUq0JfE5wtsTFN30BWtmHU8izUl76i2TjS7XbnVVJGnuIpK5jbMmIdNB2ftNDIR8sHjKCjOWLtRzLRYSQJ61tuvypHvwiyoyXO6Ai+kvWfSkGzwA9bCRGcLtDR/lV9Q1rsn48mM=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by MWHPR10MB1453.namprd10.prod.outlook.com (2603:10b6:300:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 19:36:19 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::71ec:3c08:c336:cc55]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::71ec:3c08:c336:cc55%5]) with mapi id 15.20.5395.022; Fri, 8 Jul 2022
 19:36:19 +0000
Message-ID: <357da99d-d096-a790-31d7-ee477e37c705@oracle.com>
Date:   Fri, 8 Jul 2022 13:36:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 0/9] Add support for shared PTEs across processes
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     willy@infradead.org, aneesh.kumar@linux.ibm.com, arnd@arndb.de,
        21cnbao@gmail.com, corbet@lwn.net, dave.hansen@linux.intel.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
References: <cover.1656531090.git.khalid.aziz@oracle.com>
 <20220701212403.77ab8139b6e1aca87fae119e@linux-foundation.org>
 <0864a811-53c8-a87b-a32d-d6f4c7945caa@redhat.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <0864a811-53c8-a87b-a32d-d6f4c7945caa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:5:120::36) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32ae2acb-8940-49a2-5c16-08da61192149
X-MS-TrafficTypeDiagnostic: MWHPR10MB1453:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IMQuPsoTYhcun9myOMTiQXtNUy+qx9cR3BZRJXMcJkW70RFeKPT0tcrqbGEcCq8UWArI4arkh4V9HLOynv8TE4I4H/dwhmjOlhM/NU8dI9L78owFKuU3sBOKLg7oTHLGYQ8ckuVrtYZlJ+9av29XRNAjLrp0YgIWML4miChcwwWYCNBlaw3QgxdjIATltxzPLznePuQYYjqCqgQU41Mk/WS6A5yFO9NX5QWWQz04valBoDAdY0xsDYj2b9pNGKQDdKph0d57u6Rscc1G09R30N7PheuoplbT5YlVKQoir9ybi4fReGK2c0lxAWFlX4Y5F578z/i/NAPbPaTG0tSWffBZYGhFxralLUoW+W2U9Um5EB01tVSfswo+YbNcykEL6zBMs036tMdy2bZ5eiSy41jqYWdke7S0UMeRqPnRMAXeRn0vPkQhs79NbAJe2dH7IB5xrBM8huhwSzS8dICgiW4upzpKrQItjmMHkubt86jCAQGnJ9Nq9vjziVwm8d2ECcxO/TEcUCR5tc84iRhi4MnXHk8sAwSFvbwoq9OcRFcrE98omPHglKmUHaL8mWHf8BSVpj+mcrjffYS33XUE0fB+7seKf6kERTiAHblCKSgqE+yG1pF3NyVcDFb0mH/W9xJE+k4r+3ZEriHPPIpcIA1dp31rWFUONvt7Lhg645emsUWsUdkZwCcwwFaFBQ9EQ9HuYneNHeR9Oya49HKvrPUlAjQTTk8kOEVXepvgm4ZZ1tBo5zi6rYbcn0zecWs7fHhi/Q2b/9siVyKCwQjfKAykpXDm/KZJmc0ULtFwA/6/24HPribpMsbDqbLQoPFuhlL1fnWY4h6LEkqCkfVbRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(396003)(136003)(366004)(346002)(44832011)(6666004)(6506007)(86362001)(53546011)(41300700001)(4326008)(2906002)(31696002)(38100700002)(2616005)(186003)(8936002)(316002)(66476007)(66556008)(66946007)(31686004)(8676002)(36756003)(6486002)(6636002)(110136005)(5660300002)(6512007)(7416002)(478600001)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG1md0VzeXJwVEIvNXp0ckFmUno2MWUxb1RYcDNwYTJ6UlJ3NXlKdUtrWGx5?=
 =?utf-8?B?UWhBQUxEUC9vblFFTVJwM0Rqc0ZUeFYzVk56MHFWOVB2QW02Uy9ka2pyMEdL?=
 =?utf-8?B?ekNCb0c3bWM3Tk5lTXM0WVpuZUl4L2NyUTlkdS9YTEd0cFdNU0pJT2ExdHRC?=
 =?utf-8?B?UkRQNFhnazhnR2N3Ym5FTFVFZDFuc3pUbE02MkNhemYzNkV1Um9sOWhzOERB?=
 =?utf-8?B?TllvZ205bUFWWVp2U2hlL1NIbmNHYWpVZHVDTXdiZkQvc3FrOEI2Rkl0R205?=
 =?utf-8?B?eE5uTEFTTE5haVY5UGMra0ZwbTVyWnErRktGeXVkQlByK1h3VGxKcTVsVDJ6?=
 =?utf-8?B?bFQ2T0FVODFBam1mZHNQdTYxcGcxZGxzK1RJVHhGK3pYOEN5RktIQXpFbXZ2?=
 =?utf-8?B?RjM1SnZyT005a2RZVFpqNWNFdGpndU1kSTJkMzI1SXcrUmtRQkRBSXZOUEQr?=
 =?utf-8?B?bFZnN3RmRVNQVmZYcm9mQTRFVnpTY1REUVBSYWtwaHFaeVFodzhEdlFhU2pu?=
 =?utf-8?B?ekNkQzBMcnBFMDFQdDhzRVVxM0hnbzc1TGJCNlpsMy9KVEF5VktqazVNMjZ6?=
 =?utf-8?B?Y1h2UVY3UFdvZUZDM3dLVm1qVkJnOFhvekNSWC90N1ZmNEdnTkhNanBtTklZ?=
 =?utf-8?B?Zm9xOElIZWVFZ2xxalY2ZkkvcE91dk8wNkZxU0gxSmUvMmYzR1NzblhhZGg0?=
 =?utf-8?B?VzJCOVYvSERmNDkrSHBVV2E3YXZGRk03aWt5NHg3aUNpK2ppSS9YRzI0bEhS?=
 =?utf-8?B?ZUNwZmlwb2tMMzh0K3BxeC9vSVp1WExrM2FsVFh1eitja1ZJSVhqaldTeGVa?=
 =?utf-8?B?WFpJaWo5ajltMk01QVJBUlhlTEkvNEZVR1ZZRk5zaC9NNVZMU1lSYlFFWWFW?=
 =?utf-8?B?dm1aMVl4Y0Q4bStIRS9CY1JnZkFRM2ZYbDFSNE1jN011RWdERXVxaE9Ddktl?=
 =?utf-8?B?b08xOUEwV2xiKzBiMUtQdkVXRmlDV0JodHlnY1h0d0daSTZJMVAvQ044Ylp0?=
 =?utf-8?B?dTJBU3FJS0VIb0FhM1A4RzNRZjhVcWl1czU3dzVIV3RLNDhYNFc3b1hmb3Vl?=
 =?utf-8?B?K0xuZmRnVzlFbVR2d3EvSnQrK2ptQW5uZFF5MnZHM0pKK0I3Y2ErOFRueFMx?=
 =?utf-8?B?RzdSZUJiTVZOOEYvem5pSEsyb1U1Q3pVVzBtbXdNem4yWmVPY1ZNZzZvVXFO?=
 =?utf-8?B?WllYWWtnRmFUQWR3UHN3VjdaZ0s2d0JYOFUreUhxaWpWS240NVcvTkplOUhU?=
 =?utf-8?B?UmFDSWpFcDRkT1FrWXI4RVNzU2I4dmJEN21VM3BwOGNuK2xmei9RNmVrV2I1?=
 =?utf-8?B?QnpISUVwSlRqaDJDUzJvLzA1RTJEVElqMzk0OS9tTjZla0phc1pvbjBJdFp2?=
 =?utf-8?B?bHpjNmZIR3pXbG12aUJxempWQTFUUjh6TDIwQnFjTnB6K0NiRUdUSHFwS1dh?=
 =?utf-8?B?TXQ5R05vU1VmV2t5QXNIYXFoTGlYR3NzSmpxQm9GQStpWk9rSGhCWHJnZDBh?=
 =?utf-8?B?MVNUd3RvYmlnNWd5aVRLRWsvdVZVMUFhcWJaZ3laMmcxM0ljUHJ2UVdQckZM?=
 =?utf-8?B?UTJYL09Od1gyYlhRR0hPTEovSzc2WlAyOGhITGdabkRBQ3F2VHM5OVMvVEN0?=
 =?utf-8?B?b250OVg3TmZDV1Ivb0Qxc3hHUUVEUUFXNk5rbVFPRk1jSW1lT0liWmJvdHc5?=
 =?utf-8?B?Z3ROSTZOSFRvV0VvMDA0VW9LR3F1WEJjQU40MlFmamMxUVFMZ2JZTmFSb3Yr?=
 =?utf-8?B?bzZWczlkTXZRWHNhZVV1ZTFlTE1DOTFJT1llQksyOXIzclJtSkZPSFUyOCtM?=
 =?utf-8?B?MXhydFpYYVhpdWVsZWF1VFJNcGd1Y3J3UDREQ2RaWDd1Nk5XUnhreDIzSE8z?=
 =?utf-8?B?clhVeEJPUjZzbGxaeUswNDh3STRXVG1qS3Y5VjFGdUZuVExoYmYwTWtyRk85?=
 =?utf-8?B?TVBLTzdSRGxGREtPeG4rVGZVU0hFUlA0NWltc0xtSkMxQWpNSEJGanZUaHdE?=
 =?utf-8?B?ZFozNlErV1h4NEEzNGpQRUl3TEMrc0FNbGJidGpaK1Fua2Z3TkdLUzNQY29s?=
 =?utf-8?B?cWVHdzhidmR4a2x1alpQNkFJdlYzaEkyUXJuZzFZSnNlSGV2QjBZL2xjVzhl?=
 =?utf-8?Q?ngWye1koAbojKz0E5hJwLvZq/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ae2acb-8940-49a2-5c16-08da61192149
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 19:36:18.9222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBnYTKZe/ymVaJFNXBr5Gk/YQ1LKYDR+RSA98fbXgQrOo96fVFTGQCOv+2YwFlluywYSZePL5hLmeFkvpeRsrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1453
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-08_16:2022-07-08,2022-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=966 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207080076
X-Proofpoint-ORIG-GUID: fxxCjceUuw29bkaEIi3iY2BFb_ivT8kE
X-Proofpoint-GUID: fxxCjceUuw29bkaEIi3iY2BFb_ivT8kE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/8/22 05:47, David Hildenbrand wrote:
> On 02.07.22 06:24, Andrew Morton wrote:
>> On Wed, 29 Jun 2022 16:53:51 -0600 Khalid Aziz <khalid.aziz@oracle.com> wrote:
>>
>>> This patch series implements a mechanism in kernel to allow
>>> userspace processes to opt into sharing PTEs. It adds a new
>>> in-memory filesystem - msharefs.
>>
>> Dumb question: why do we need a new filesystem for this?  Is it not
>> feasible to permit PTE sharing for mmaps of tmpfs/xfs/ext4/etc files?
>>
> 
> IIRC, the general opinion at LSF/MM was that this approach at hand is
> makes people nervous and I at least am not convinced that we really want
> to have this upstream.

Hi David,

You are right that sharing page tables across processes feels scary, but at the same time threads already share PTEs and 
this just extends that concept to processes. A number of people have commented on potential usefulness of this concept 
and implementation. There were concerns raised about being able to make this safe and reliable. I had agreed to send a 
second version of the patch incorporating feedback from last review and LSF/MM, and that is what v2 patch is about. The 
suggestion to extend hugetlb PMD sharing was discussed briefly. Conclusion from that discussion and earlier discussion 
on mailing list was hugetlb PMD sharing is built with special case code in too many places in the kernel and it is 
better to replace it with something more general purpose than build even more on it. Mike can correct me if I got that 
wrong.

> 
> What's *completely* missing from the cover letter are the dirty details:
> "Actual data is mmap'ed using anonymous pages, ext4/xfs/btfrfs/etc
> files.". Gah.

Yes, cover letter in v2 patch was a little lacking. I will add more details next time.

> 
> As raised already, "anonymous pages" makes me shiver.
> 
> 
> (To me, what I read, this looks like an RFC to me, yet I see "v2". But I
> am a little confused why most of the feedback at LSF/MM seems to be
> ignored and people are moving forward with this approach. But maybe my
> memory is wrong.)
> 
> Please, let's look into more generic page table sharing just like
> hugetlb already provides to some degree. And if we need additional
> alignment requirements to share multiple page table levels, then let's
> look into that as well for special users.
> 

Thanks,
Khalid
