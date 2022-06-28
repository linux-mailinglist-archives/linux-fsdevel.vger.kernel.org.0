Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E252F55EF1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 22:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbiF1URE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 16:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiF1UQf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:16:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4ADB4F;
        Tue, 28 Jun 2022 13:12:44 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SJBU5g031419;
        Tue, 28 Jun 2022 20:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3f/oUijnc2MwVOV+1OZ89GM4FaKlg2hkUhAVU86dR90=;
 b=sWylI0Wx0aSDYK/mk0fbrujtAXH8V0qcRPZ8gWgj8/pXFDTbAOhaZpqp6yssfg0tQ9e9
 llPM9rC0jefa68mArQo/Dl8Yux7lK2miMkO4ZCQSPrSkexl1fdgaNkxXCLYWK1DY144E
 SjjW3HE09Cj4e/63QTzoVG9icprXMVURLocN9+GlX9bawEBH6wbdv73YPeegXAxA/bM2
 B2zLu0oeBdZK1Wibo7qQJPXff6eADyK2gR1bdziwlDBK9YN5aCM+rVj8zxZmJto6BPWM
 ofaAuhHDB7nrb8eewMqnywyVQhtdAOB3ZjaAmiPhEYn9rRxp8WU7ke3rE5lX6cGiEsd9 vw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwry0f809-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 20:11:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25SK6vNp036500;
        Tue, 28 Jun 2022 20:11:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt2vabp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 20:11:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UACmINW+7ire7x/nHeFpPix/9f4gyHSmrBEb33yXo+SDRj4JOeTw3pWAE+QPl1TTqVJzytYNdijgC/4xoNZXy5ikfpf8e7TifCa6r7x3Hx1V0yyzprCwNiiwmP1ZGFsRZD6iOVtt2ALftN/GDPCz2uZuCqnAU/EjAMEvp2wctMA+E2vjgZG3CsMuB+cZJKj0VOMh1XIpUyemvCIz9BXt8+0mHggYIN6i2PPBBR8QLqlC668xRwLkcI/2nKx+clNQYTgYTPNPs8upRTi9muMqEw5yQoQEOYsj4s/LGt0+DR8yfkDAuJo0u+pkIw9h6Q/Vg+oEB8n0dpfbx8pi6w/51w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3f/oUijnc2MwVOV+1OZ89GM4FaKlg2hkUhAVU86dR90=;
 b=QgDGNUVAPneGtb0kokJ0idVOnzQbI/6nATkLyBN8F3fw8+1fqoDUd7J61QtOp9BC7rwCMTBj36HnrvjgjnhQKos/F1qsNwPllk4H8Xa9t+pYDV3g4Y5UO14tyexVsIl6l2kNCqLEc7ZCCWKzx1y0uy0Sq7zVh/6VJHT73ywR5Sa0SnSU8gBJK0qfdUDXHRoe4CQBkwpvnIzuYehxdEgCvebO0kcypAfzpXiC2cRJFnlZUf5mUMljdVvT8Hp8h1nL+A8NyK7kAtgSf16TOKDGBbyAWHGdIlg4bZ4r/OWWm6k8HKK7YTBKa5BQDMCcnqCY+xJgOycdKpIuNoiANW//0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3f/oUijnc2MwVOV+1OZ89GM4FaKlg2hkUhAVU86dR90=;
 b=ell/eegPEKTYl5/BdE64noIPkezZappC2NA6D6jdP3AaxYfmx8+jtK9r7OwXywicL6FB65A3A2kaBImZBJhPyJY7+5Xzdww+6djcj6skBDRBFneCy7cI/sBzWCDCFiugoU7xvuyUcitDGMOc1B1ev/+0s94/PxbD1GOTM7G5FMw=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by SN4PR10MB5573.namprd10.prod.outlook.com (2603:10b6:806:204::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 20:11:46 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2%3]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 20:11:46 +0000
Message-ID: <33d1edc7-0846-5ff4-7311-06ceed353972@oracle.com>
Date:   Tue, 28 Jun 2022 14:11:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 08/14] mm/mshare: Add basic page table sharing using
 mshare
Content-Language: en-US
To:     Barry Song <21cnbao@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, ebiederm@xmission.com,
        hagen@jauu.net, jack@suse.cz, Kees Cook <keescook@chromium.org>,
        kirill@shutemov.name, kucharsk@gmail.com, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, longpeng2@huawei.com,
        Andy Lutomirski <luto@kernel.org>, markhemm@googlemail.com,
        pcc@google.com, Mike Rapoport <rppt@kernel.org>,
        sieberf@amazon.com, sjpark@amazon.de,
        Suren Baghdasaryan <surenb@google.com>, tst@schoebel-theuer.de,
        Iurii Zaikin <yzaikin@google.com>
References: <cover.1649370874.git.khalid.aziz@oracle.com>
 <5c96dd165d7ec3da14306b8fd857c7eb95a8c3e6.1649370874.git.khalid.aziz@oracle.com>
 <CAGsJ_4xPFu5FCQtNE6cJxbV7kMQXNtzotBFQKC3OkXUOtweyYQ@mail.gmail.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <CAGsJ_4xPFu5FCQtNE6cJxbV7kMQXNtzotBFQKC3OkXUOtweyYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0107.namprd05.prod.outlook.com
 (2603:10b6:803:42::24) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2658b815-9007-42ac-cdf3-08da59426d05
X-MS-TrafficTypeDiagnostic: SN4PR10MB5573:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kYiFL/L1kpn8yFXe+oBnF/B71i8fvS8WQh2SMGHKQOTRZiO+XO/U/sb24Ie2AR79sUhWIMfFdd6yuT5XB49shsVWEHcQN04AhcrKGhqa5zONE/oLiNQcP0vQZgNev2YyNqFkFM795Plv3Z2XLXjSgGtK54l8ayylYypwLh3Cr11z2+vAHBEI+828c9WwXoNPpHJJGbbk05nT4rwunM1qPIaO+r1x03rnntNKPa9yGCZCN/NyAvuPis2AUXh3PAlKsT5IRPOpz0k02KDRChcsmoU0nb5aYr8+oy7+jcFuJlfEduxFBJ+MYuDyNAO0rWfhPYUOiS3jdkWxMkp0yyVcmHVP+rs/96CqsGNqHagN+6uaOEtXIJEk06pDxJS/Yx1BRuV27I6AcP1hodO93M1HrlWmM0bSd9pa49DyvFE1WYSw3Kqn277A5W5kVeNVcCdIgXdnC2DoYNeT88pxkFGCMoEvxMqhnNbYNXL33/THljEQa2OaIe8jHeqdr1qY+NIHmIonhZUoQcX+XOUK0kucfnVq4NlxJ0ASvR9X8++BzWrfYL99BR0/Gjd/GfakKDlPH/za5r8/ei2CuPD4IpZiMCFcZwNOa2P5CUWo0FD+z7sRYJ5N0aO/HtIH0ELEQeOKNYSUGSojprXmrv1DcCfj87NLQTKNPFOREr9M8Yii0oNiFWufo9jmUIABamNg1FWt8gSBD8kN7VvItRDKtTK2MKWfz9gw2E9TMW1CZ/CI1tmzCGeooNLpUD9j6Ovf2BoMJxiNC80Awq16p8joRXgfazckiVQw66qBQoXdQjj+6LwQfJ+8UOpp8B5nhYgsqjmh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(366004)(39860400002)(396003)(346002)(83380400001)(186003)(38100700002)(6506007)(8676002)(66556008)(66476007)(5660300002)(8936002)(66946007)(44832011)(6666004)(54906003)(7416002)(2906002)(4326008)(6916009)(41300700001)(53546011)(6512007)(2616005)(316002)(31696002)(31686004)(6486002)(478600001)(36756003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVJYNU82cU82SFRyYi83MEhXOGhuSDZBd0Zjc1hKZnNiR0hHL1ZxVjMrc2pq?=
 =?utf-8?B?djZqK0lsV0ExQVVlOWo5aHpqVkxIRkFmYzN5VjJHZzRCR2FOMHBnOHVVd01X?=
 =?utf-8?B?QS8vUWxBTmJndHFCeWRHNUpKUG5HaElWelFnNHAySHdmbzM5djZCbjFtSUFF?=
 =?utf-8?B?Y3dOWm1pWUFuWmozM1lRNDE3Q21hRWs0Qjc5dE5aWGkyeEpIcE40eTNCUWFG?=
 =?utf-8?B?N0syL3YwNTNCQWc2UWdWb2dPYWpuQ3c0RVZJL2EzdzVsek04YVBmZE1zNUVM?=
 =?utf-8?B?L3F5L3VUbnBNWCt0SXgvNWJFVmVYVldWMExNNndFM1ZaWE1mUkRKOXNoR3N0?=
 =?utf-8?B?SGJNbHpmU0xGT3ROeTVFUlU5Wkx3R0F3MEJ1Y01LSzV6SXV2ekgzRzk2VUc4?=
 =?utf-8?B?MXZ6VFY3WFh1ZnM1VGZVVXhnaUdjNVdXZVFmcTg2UjcxZXRVMXF2TzI5aE5M?=
 =?utf-8?B?OHJrM3FFcThRUW9JcTdkRVF4MU1QTWJqUmNIdXl6cXVMa1hObVVQUVJ6ME9k?=
 =?utf-8?B?elRCT0wwUjZkSFQzSlI2REZPRUtTeUc5YldOU2VscjhtdUdQSzNGYXh1dHVF?=
 =?utf-8?B?MUVxRmpQVFM1WjlMMW9NaVI2Mjgxc01GVFcvajlCQTIrRHdxdHJGUUZEcGJj?=
 =?utf-8?B?alY2WnRCdU05Z1pUNlhVd0JudEt4ZUdYVmNKblhXVy9wV1g2eHBtalpLeVFt?=
 =?utf-8?B?TXpRcSt3M0pzM3lwUTBJMEFhUTRtNHdUSmR4NGtZNUxxemRwMHdpVVVtaElh?=
 =?utf-8?B?MXc0K2Joa1Z6OFgxVlBzcGN0UlFQSDdrWkZwSXQ0bStqM3l1WUV4aVU5UTNO?=
 =?utf-8?B?ODZwNGd4dWhudGRBcHcvbk9aVGtTYk9hZllHa3FCOW12S0xrSWZCSFNHcTNB?=
 =?utf-8?B?aHM0K0NYUllGVFl5SS92cS9uSnVHQi9Fa0wwN2NZSDNEU2FVeUw2a20rTXlK?=
 =?utf-8?B?VXVvZXQrS1N5UkxFR2FoN0FGTFJkR1pNQ1pvNXRmVG1RWDNRbDB2RlNKUkUy?=
 =?utf-8?B?QnE2NCs2c2VJYnBLUlYzcHJtRm1TaU1yN3crV0VHSXZaM3hJUFRjb1FzT0tV?=
 =?utf-8?B?aWxQOVFOa1B2ZkthSlFRcFNLT1h5NlBEVncrS2U5cnRkcGRFaXlPVDhVVU5Q?=
 =?utf-8?B?d1hKSlR1MklhOHlqeEFiaFZIYmFHYSs2SFVqMHUzUnp4cGdScUF4TzJ4VHFn?=
 =?utf-8?B?N25nS0VWMU82Um1JY2Q5Tm82TlpWbHBzWTVCWk95Y1FZVXhZVlkyQnFYRytH?=
 =?utf-8?B?dVNRYUZ0aXBnYkVmSnAvL2grbnZWd3A4NlRyaTd3QTFmZ01RV1diTDFhbXh1?=
 =?utf-8?B?bVFnWEZLRVduaXpRdFN1UzdXQXV3NGQ1T3lwekl3MzhLMThLbEthdTFyQzB6?=
 =?utf-8?B?RmRhTmYvMlVUNjFzWUQvZG01QVlLYVZGeHdoNnB2K1FYSDVTTTkwUVNvVWJr?=
 =?utf-8?B?eVZqbTh4RW8zaTlxcHN4WjFsWGxUemFqUmUzVFVVUmtnWDczYmlxcGZDd2Jl?=
 =?utf-8?B?dE5CL2dZUzJIYkZPSnNUTm1YVzFnNkdVQ0M1U0d6UTcyNWVUMjQrOWpJSEw4?=
 =?utf-8?B?NGxaZFRQYUNycnkrMXlEY3BoNTdvRWUzUmZwYW10ZEwvSmRwRkJUdFJrcHFM?=
 =?utf-8?B?L2tGNXNtR1lyZEYrRmd2T296M3V4a3dZdlJxWGJ0eFZzVmxjYkxIeFc0UGNp?=
 =?utf-8?B?NWhqYWNRNWtsTzRUbnRDMkwrTS9OWEFoWTFHeUdlNzJFb2h0c3pRU3UxMEhi?=
 =?utf-8?B?Vk5IK0d0bm0wcVRpMXdHVFBabmxQUkx4a3BKUEFFQk5ENGFLZU1uSWh4Kzgr?=
 =?utf-8?B?QUtFbUR6RkVzSmg2cWJpdTFrNUE1VEd0OGYyalNiWFFTRkFsaUV4MzJYYkpB?=
 =?utf-8?B?dzQ0ZVVhU3BFbWNPWVR3cWNkM2s1R3RaNHpHTm9BTXA0ZEc2by9VbGs0ak1t?=
 =?utf-8?B?bnFrVDVkUkxVUmlSNHlCMmlaWldSSWpod2x2U21pUitGeWMyYnY5eWc0NThL?=
 =?utf-8?B?QWJ2cDNldVNZOWcxalpaaDJyaWluWE04U0NmcDhzczNLeElDNXBrcGxmVktD?=
 =?utf-8?B?SHZiUUprT1NVZmF6VFRLRmhjWXUvL2NWTE84bXdWbWpGamN6dGwvbDdvdHh6?=
 =?utf-8?B?U0dhci9FeXpPblE3cHB3OFZkejhicnRqbVNWclVId2RDd3dWVlhYaTJ5MG5k?=
 =?utf-8?Q?ZMEwXX1ZyQqh7stkaIvDwO7eQmzHHawmtvOiaKyJDkpt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2658b815-9007-42ac-cdf3-08da59426d05
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 20:11:46.3937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7qqOkU0MgflKXaik4bS4mWANAypnckD7P8p4pHYUqw3G7IylWErb5FIYaroGApfIQGfI9w8zjewyCbwnVr7zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5573
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-28_11:2022-06-28,2022-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206280080
X-Proofpoint-GUID: SEEit6Ngxu9OPMlO5tYetnNcgXwxLEJq
X-Proofpoint-ORIG-GUID: SEEit6Ngxu9OPMlO5tYetnNcgXwxLEJq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/30/22 05:11, Barry Song wrote:
> On Tue, Apr 12, 2022 at 4:07 AM Khalid Aziz <khalid.aziz@oracle.com> wrote:
>>
>>
>> @@ -193,6 +226,8 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
>>          if (IS_ERR(fname))
>>                  goto err_out;
>>
>> +       end = addr + len;
>> +
>>          /*
>>           * Does this mshare entry exist already? If it does, calling
>>           * mshare with O_EXCL|O_CREAT is an error
>> @@ -205,49 +240,165 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
>>          inode_lock(d_inode(msharefs_sb->s_root));
>>          dentry = d_lookup(msharefs_sb->s_root, &namestr);
>>          if (dentry && (oflag & (O_EXCL|O_CREAT))) {
>> +               inode = d_inode(dentry);
>>                  err = -EEXIST;
>>                  dput(dentry);
>>                  goto err_unlock_inode;
>>          }
>>
>>          if (dentry) {
>> +               unsigned long mapaddr, prot = PROT_NONE;
>> +
>>                  inode = d_inode(dentry);
>>                  if (inode == NULL) {
>> +                       mmap_write_unlock(current->mm);
>>                          err = -EINVAL;
>>                          goto err_out;
>>                  }
>>                  info = inode->i_private;
>> -               refcount_inc(&info->refcnt);
>>                  dput(dentry);
>> +
>> +               /*
>> +                * Map in the address range as anonymous mappings
>> +                */
>> +               oflag &= (O_RDONLY | O_WRONLY | O_RDWR);
>> +               if (oflag & O_RDONLY)
>> +                       prot |= PROT_READ;
>> +               else if (oflag & O_WRONLY)
>> +                       prot |= PROT_WRITE;
>> +               else if (oflag & O_RDWR)
>> +                       prot |= (PROT_READ | PROT_WRITE);
>> +               mapaddr = vm_mmap(NULL, addr, len, prot,
>> +                               MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, 0);
> 
>  From the perspective of hardware, do we have to use MAP_FIXED to make
> sure those processes sharing PTE
> use the same virtual address for the shared area? or actually we don't
> necessarily need it? as long as the
> upper level pgtable entries point to the same lower level pgtable?

Hi Barry,

Sorry, I didn't mean to ignore this. I was out of commission for the last few weeks.

All processes sharing an mshare region must use the same virtual address otherwise page table entry for those processes 
won't be identical and hence can not be shared. Upper bits of virtual address provide index into various level 
directories. It may be possible to manipulate the various page directories to allow for different virtual addresses 
across processes and get hardware page table walk to work correctly, but that would be complex and potentially error prone.

Thanks,
Khalid
