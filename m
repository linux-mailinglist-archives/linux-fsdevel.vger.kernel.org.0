Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A838C4EB423
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 21:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240975AbiC2Tes (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 15:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbiC2Tes (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 15:34:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1991B84F1;
        Tue, 29 Mar 2022 12:33:04 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22TJTcaB031835;
        Tue, 29 Mar 2022 19:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=j1IdiOw5W8iTODmZQFOBfdHOJIPpUbrQKKP+LMlVIws=;
 b=VPjuwqw1xksK68ZN6UJ88NYUijgNMJXgLQvQazQl8IaBthd0TnvoH6UlfQitiMhEllJ4
 pkQABfX8ITJ0bHCxnALgRNc/2VKgg/Vj43KrpPYq4cEjZVyIVNTHjot1CHKKMsDlR8O9
 HWrlB14skF0XwWKbK3o5uqNfn/4qycKLWP+Y8F8S1ADhxSDTsMrstps0qeu7Fpamo5lj
 Ku12jahtO9tF9YtScRs/pRSFKNX0GInphTCP8pnZqqVzd664iwIynOFvFUfGfL4GuDlg
 4o15Hm8gck2dYAxFkgY/O48pCe/wgJrzOLAK3LWjbWwgkABLHoujOJS51CwghRZas4r9 rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1s8cqes6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 19:33:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22TJW2vD116091;
        Tue, 29 Mar 2022 19:32:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by userp3030.oracle.com with ESMTP id 3f1qxqfp34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 19:32:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlYILMoFVRnVLeMrSiWealiquxqDv/cOkA6qEC4xJDuFkEDZdCQCyP5F/+Ug6+Ud/DidF7WR2bXNyMUOEPojMDmGV4n8S+udv74qJhZh9DZsYnfxPSrWPd6EJ79Nd5ZK6dfvvScwK9ZCGWIQJZfmskMdFDfisRu0uP6MtuH0LDOH8qvILips5vRh3mW82368TM2RTUKR9ZUYEuwgOCds92I8Ejy4Ys/JOaLRwDAh8w9ueUJUby2beKJpmT6IzJO2/koUpDjrHZPxYvIeCBQZ1AUxEzVr/bEGENmBfIoKi1dlvbPSQnkrspoi84LGb7+JthC/J3IqDLpgMZiC8IngZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1IdiOw5W8iTODmZQFOBfdHOJIPpUbrQKKP+LMlVIws=;
 b=QcxPyg2+vLMEu/bzC1fwlOul1XHGbMtBtAQtH23ELdIxce84PS8vDIs037qHDz+j/96xfAFFbPMX2bzqhiGtOmL06K3L3Nf7xLEVCsEPFvLyHx1f3exjSsD7yLUk2Kh3d1mlol2FPhdB4tfsJj0hIYB0jCsrzk7aV56bkwGjcN7vJkFbGIvKFc3sVL9xuEaHwLZgBMD3/y4IWJPDmJSArM6d3Q/49SsgncPg0axpR6tqsJdagc1K9xCULgtmlgv35jADupIVfG+ffmWlEwsx7jOK4rZtiGZ29AB4hMMxbxGPgsyUkFKNYzrZ8sFh5wrXZnBvIUCzRXdWC0XoCp5MhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1IdiOw5W8iTODmZQFOBfdHOJIPpUbrQKKP+LMlVIws=;
 b=zCOb0RYrg3cOjdChl1B7N00Ing1tGEC2N2cw7opMuxbjdbC4qhwXRf7lwbmyhahIRHbCGrzrqwXQudRcbjldjYDal3r6poft7qZwcrfLpOuY3fCxpLEj0tEKTfJiLXFcP5R7DMQetRAqmvnyCqSBLHgi8UaHhxS/LG/GTKg4krM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB3434.namprd10.prod.outlook.com (2603:10b6:5:6a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.17; Tue, 29 Mar
 2022 19:32:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%7]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 19:32:57 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v18 02/11] NFSD: Add courtesy client state, macro and
 spinlock to support courteous server
Thread-Topic: [PATCH RFC v18 02/11] NFSD: Add courtesy client state, macro and
 spinlock to support courteous server
Thread-Index: AQHYQAGu2vXHyzFxzEOK5co/7sorDqzWiKwAgAAI/wCAAALWgIAAHqSAgAAFbQCAAA7/AA==
Date:   Tue, 29 Mar 2022 19:32:57 +0000
Message-ID: <ED3991C3-0E66-439F-986E-7778B2C81CDB@oracle.com>
References: <1648182891-32599-1-git-send-email-dai.ngo@oracle.com>
 <1648182891-32599-3-git-send-email-dai.ngo@oracle.com>
 <20220329154750.GE29634@fieldses.org>
 <612ef738-20f6-55f0-1677-cc035ba2fd0d@oracle.com>
 <20220329163011.GG29634@fieldses.org>
 <5cddab8d-dd92-6863-78fd-a4608a722927@oracle.com>
 <20220329183916.GC32217@fieldses.org>
In-Reply-To: <20220329183916.GC32217@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5cee36b-0b7a-455e-4204-08da11baedbd
x-ms-traffictypediagnostic: DM6PR10MB3434:EE_
x-microsoft-antispam-prvs: <DM6PR10MB343402084EA3712AD9EBF916931E9@DM6PR10MB3434.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /1Yf6pQHRJD38eaB72vTSiEKGd+kC+H5XqCeuyunkwWvyDinKk6goxrgtbvb9kTg1GdJQOYmQMbvq9KzOQrUWpZpTi1qZX3rL2Csvu4INo3ZYgTxm3pEKNMgNKHg27ZS5FITOa3CwLUlnhlYAacYeIP9I+55rDjS2sTxVK1hTsE2CJLnLlWnztSEStyFONf766syA7rHjGyeFFV95Xpds2ois0vgcV0ps9YFqsBxLGjX/7viiOOSGqP1nrXrTJ8jJQKjShlrxqMT65dDkAb1BCutD2T8Rq2gp7Q4LPXeRX2UCWhrmNwMyx3s0OpMXc+aGanMprDIsf8Mdb2bLx/KcuahKdhBhocoSOhtPPEJFUM6T8z9NCZERdetu9s7Z+Va6tJl2ipSJ17d2DURiRIUR6BOvv1MP/QCkQIRsnSc8R6aXjjfpqKZ6iqyJHmpTM2mtG407bqEG+0seD8pmhhGpiQvDJTDWPSeShN21JhsVaE0lUnS38BTWwgNNKt0YOydXyrOET0ux5eOVjV/nhpjK45rzmTbckdIqTHYEBnFXlBN0IL60eGM9kRcnjsXGuhbtIuUAHgw3L4qWEPZRFe/NVxN6LfP9voENr/sZA8UnHUlv+BE8Vy/qk6J2fyAqi6vbDl9o8S2vsJ4GnWidQJb0RPTNtUlrJBmpHW0+0MUQoYp90vgiG77JTaNuunxWLk4bW4GDxHSsUSLjv8sYRSoX217xmIyGkPMpJXXdBksfz8H8zL83OJGdw/000t2wb6c
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(76116006)(91956017)(66476007)(66946007)(8936002)(4326008)(8676002)(66446008)(33656002)(36756003)(26005)(186003)(38070700005)(64756008)(6506007)(53546011)(2906002)(6512007)(2616005)(83380400001)(122000001)(508600001)(38100700002)(6486002)(316002)(71200400001)(5660300002)(86362001)(6916009)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PeEDi8nz3juIy4KaBQeaoLaJ7oiYleRTExiBEs357cdg2JadksQ11NtS9g7s?=
 =?us-ascii?Q?o2rmVgpc+POoipwwQ5VhJidZSN1HodmyhBmZeK50dpHEmPHyN7mMqxlIorHJ?=
 =?us-ascii?Q?O/e6zPzqqFijlvbZiUoYvlXr3TkWQ/0K8PmidpgafWzxm6Yl+UT22sGglOCF?=
 =?us-ascii?Q?fMIk//ui75QvD6nS0gIFw+xo8gwCiezd3MRy4FN245IYezNG8HQjrME+RCFd?=
 =?us-ascii?Q?237r7hnDJ7P13JbKO7Wzk8XEGJV6rwMvqxDHfJsKpCBIyXbs97KUmsjr75Al?=
 =?us-ascii?Q?NWT2M7+F+TAVC3TCS7vAH7ODVleE0q+9zispm9nKcANEoxx6yRl6nYO/MjuU?=
 =?us-ascii?Q?oAtxJBN6zxN3WBRWWgSJoiUvlukL3bPtyyBikhFYFV9rS5cA9vEyozLMjARf?=
 =?us-ascii?Q?Y9VRFJKSITbjFe0TMZXLlMjmpSBYOWgK0vht8nrmCU7ppuenkjJlf4mX8pEU?=
 =?us-ascii?Q?IUP0sHg0XjTrNiQMsMup5cV/E6YhxvbootNNNmXsaTmPdfEd75UeZjSK2DuF?=
 =?us-ascii?Q?2IA32O8qDQ044UnU6nLdLJID8OqucEHsLS/WsI45mP3IhjW6d8EkOn6uD9jT?=
 =?us-ascii?Q?Tw2ElLc6GNjME9TG6w6wvVmEqjZd9wexvAI/BNJjceTpEjtmlwDb7VQZYy1q?=
 =?us-ascii?Q?j7FyBO0IIDA+kSVzkSCLRIim2N56vfgJ6KZt84/eiWwdGGdakN5K7n3yjOGt?=
 =?us-ascii?Q?d9U89jOQRbCrzEYjdIIdb66McKxZ0GGbj4FV0J4dOOqrbxbkO3j4QM61dei/?=
 =?us-ascii?Q?H8WpdN/hhOi1sCVlA/vM99LEHbEsGzEMhDWrrPu8Hgb79MzKFE2YBzG3/mdi?=
 =?us-ascii?Q?s7I4jZRZ2GmAZ6NswNYJHxE9sY7BSDkHVDZ5pJDpKoD5GvpSkXTHWm0HeUTO?=
 =?us-ascii?Q?kUJXLsP6CrafhZRoZerrRvgyc7d0bF4oJPc2wjYMKH3A4dDHbm0HvLcZ5DFb?=
 =?us-ascii?Q?jIyvB6kXUMF/+FTTX0augZgA1py597qKmwnN9Tx8i8IPWXGaEXceU4wYhLdv?=
 =?us-ascii?Q?A+2fjuC7qHONl/Qv3hPrt0AXVLS0kcSR6rcNJKjQsU4pTe2C45sCudmgkFjr?=
 =?us-ascii?Q?ODfj2WdESHtrvMpokk9u6hHNLuFj1q6B5tLHmlr3266dspaMkG8r+5tmd2Ez?=
 =?us-ascii?Q?kDjjUMXSdApc+o4IMeNQ95jqrQL6pLkDO79a+0DXWLt8ArTeA/B0upbvID/I?=
 =?us-ascii?Q?bY7TPTo+SUl78zLPSJ2e2nhA8cjTS/7xr9E5grMT8lLgvwr497gnTFaESOH4?=
 =?us-ascii?Q?SZpvb4FJirhhjiB8M9/acm4R+nLvl8Mh6mLdb2yS1CruqEGNVm359ldOeOZo?=
 =?us-ascii?Q?Q/lQIGOXPv1CN1rBa1WtauTAbHYWOcXYLCUA0jUZZCKulIYDR6perCfBR4h2?=
 =?us-ascii?Q?wt+dPKQZd5dCn7fvlkgncMzt0ecsHUMjRvzGBvd5ZIJzf+NrZCmGDl/2uv3G?=
 =?us-ascii?Q?UjtHLIKBg249WFueaLDzwvPqZQF0NNW+8u0BXY/ox4ZvRltAerHZ16C8CscQ?=
 =?us-ascii?Q?JpQ23MDXQAV8mGDKYIzcHIoCzAYgaARSB/N0r0UxEmvKuYYDsK0UTKKQ75uY?=
 =?us-ascii?Q?xWnoEfp1Tz/RFGYOWLLZIYfQhFTsHpldGj6Ro6WwrjipOM9nWSDVh/uCYRu9?=
 =?us-ascii?Q?7y2tzPXeLoT/9ZrpCpo5EKelNZ07y2QlBdpGsAM2sCVaJ6nGJOYp4qXsGnSK?=
 =?us-ascii?Q?Cuug1QPts02utufNCzzKZGirH76ec3jtfCMCZJ5p090Tiv5fIHGeJcZqLt4m?=
 =?us-ascii?Q?7hmGtOIC6rPpcGYm5Q5fHjvlb/83+q8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FF109246A8156140B43BF6126EC1E226@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5cee36b-0b7a-455e-4204-08da11baedbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 19:32:57.5758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gEEltX52Q13Ln47a7TvnXlwxhI6rs3gpq35cuZswZfkuYkh7pZC6EIyE1F1hqm4g0tzbFWFkCT3QVXgfoSoxEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3434
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203290108
X-Proofpoint-GUID: Epw06LeARAFxoecpVBG42qM9zLOhrWCb
X-Proofpoint-ORIG-GUID: Epw06LeARAFxoecpVBG42qM9zLOhrWCb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Mar 29, 2022, at 2:39 PM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> On Tue, Mar 29, 2022 at 11:19:51AM -0700, dai.ngo@oracle.com wrote:
>>=20
>> On 3/29/22 9:30 AM, J. Bruce Fields wrote:
>>> On Tue, Mar 29, 2022 at 09:20:02AM -0700, dai.ngo@oracle.com wrote:
>>>> On 3/29/22 8:47 AM, J. Bruce Fields wrote:
>>>>> On Thu, Mar 24, 2022 at 09:34:42PM -0700, Dai Ngo wrote:
>>>>>> Update nfs4_client to add:
>>>>>> . cl_cs_client_state: courtesy client state
>>>>>> . cl_cs_lock: spinlock to synchronize access to cl_cs_client_state
>>>>>> . cl_cs_list: list used by laundromat to process courtesy clients
>>>>>>=20
>>>>>> Modify alloc_client to initialize these fields.
>>>>>>=20
>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>> ---
>>>>>> fs/nfsd/nfs4state.c |  2 ++
>>>>>> fs/nfsd/nfsd.h      |  1 +
>>>>>> fs/nfsd/state.h     | 33 +++++++++++++++++++++++++++++++++
>>>>>> 3 files changed, 36 insertions(+)
>>>>>>=20
>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>>> index 234e852fcdfa..a65d59510681 100644
>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>> @@ -2009,12 +2009,14 @@ static struct nfs4_client *alloc_client(stru=
ct xdr_netobj name)
>>>>>> 	INIT_LIST_HEAD(&clp->cl_delegations);
>>>>>> 	INIT_LIST_HEAD(&clp->cl_lru);
>>>>>> 	INIT_LIST_HEAD(&clp->cl_revoked);
>>>>>> +	INIT_LIST_HEAD(&clp->cl_cs_list);
>>>>>> #ifdef CONFIG_NFSD_PNFS
>>>>>> 	INIT_LIST_HEAD(&clp->cl_lo_states);
>>>>>> #endif
>>>>>> 	INIT_LIST_HEAD(&clp->async_copies);
>>>>>> 	spin_lock_init(&clp->async_lock);
>>>>>> 	spin_lock_init(&clp->cl_lock);
>>>>>> +	spin_lock_init(&clp->cl_cs_lock);
>>>>>> 	rpc_init_wait_queue(&clp->cl_cb_waitq, "Backchannel slot table");
>>>>>> 	return clp;
>>>>>> err_no_hashtbl:
>>>>>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>>>>>> index 4fc1fd639527..23996c6ca75e 100644
>>>>>> --- a/fs/nfsd/nfsd.h
>>>>>> +++ b/fs/nfsd/nfsd.h
>>>>>> @@ -336,6 +336,7 @@ void		nfsd_lockd_shutdown(void);
>>>>>> #define COMPOUND_ERR_SLACK_SPACE	16     /* OP_SETATTR */
>>>>>> #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
>>>>>> +#define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
>>>>>> /*
>>>>>>  * The following attributes are currently not supported by the NFSv4=
 server:
>>>>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>>>>> index 95457cfd37fc..40e390abc842 100644
>>>>>> --- a/fs/nfsd/state.h
>>>>>> +++ b/fs/nfsd/state.h
>>>>>> @@ -283,6 +283,35 @@ struct nfsd4_sessionid {
>>>>>> #define HEXDIR_LEN     33 /* hex version of 16 byte md5 of cl_name p=
lus '\0' */
>>>>>> /*
>>>>>> + * CLIENT_  CLIENT_ CLIENT_
>>>>>> + * COURTESY EXPIRED RECONNECTED      Meaning                  Where=
 set
>>>>>> + * ----------------------------------------------------------------=
-------------
>>>>>> + * | false | false | false | Confirmed, active    | Default        =
            |
>>>>>> + * |---------------------------------------------------------------=
------------|
>>>>>> + * | true  | false | false | Courtesy state.      | nfs4_get_client=
_reaplist   |
>>>>>> + * |       |       |       | Lease/lock/share     |                =
            |
>>>>>> + * |       |       |       | reservation conflict |                =
            |
>>>>>> + * |       |       |       | can cause Courtesy   |                =
            |
>>>>>> + * |       |       |       | client to be expired |                =
            |
>>>>>> + * |---------------------------------------------------------------=
------------|
>>>>>> + * | false | true  | false | Courtesy client to be| nfs4_laundromat=
            |
>>>>>> + * |       |       |       | expired by Laundromat| nfsd4_lm_lock_e=
xpired      |
>>>>>> + * |       |       |       | due to conflict     | nfsd4_discard_co=
urtesy_clnt |
>>>>>> + * |       |       |       |                      | nfsd4_expire_co=
urtesy_clnt |
>>>>>> + * |---------------------------------------------------------------=
------------|
>>>>>> + * | false | false | true  | Courtesy client      | nfsd4_courtesy_=
clnt_expired|
>>>>>> + * |       |       |       | reconnected,         |                =
            |
>>>>>> + * |       |       |       | becoming active      |                =
            |
>>>>>> + * ----------------------------------------------------------------=
-------------
>>> By the way, where is a client returned to the normal (0) state?  That
>>> has to happen at some point.
>>=20
>> For 4.1 courtesy client reconnects is detected in nfsd4_sequence,
>> nfsd4_bind_conn_to_session.
>=20
> Those are the places where NFSD54_CLIENT_RECONNECTED is set, which isn't
> the question I asked.

"reconnected" simply means the client has gotten back in touch.

The server then has to decide whether to allow the client to
become active again or it needs to purge it. That decision
is different for each operation and minor version. Look for
"if (cl_cs_client_state =3D=3D NFSD4_CLIENT_RECONNECTED)" for how
those choices are made.


>>> Why are RECONNECTED clients discarded in so many cases?  (E.g. whenever
>>> a bind_conn_to_session fails).
>>=20
>> find_in_sessionid_hashtbl: we discard the courtesy client when it
>> reconnects and there is error from nfsd4_get_session_locked. This
>> should be a rare condition so rather than reverting the client
>> state back to courtesy, it is simpler just to discard it.
>=20
> That may be a rare situation, but I don't believe the behavior of
> discarding the client in this case is correct.

Can you explain this? It's a courtesy client... the server can
decide it's expired at that point, can't it? IOW what breaks?


>> nfsd4_create_session/find_confirmed_client: I think the only time
>> the courtesy client sends CREATE_SESSION, before sending the SEQUENCE
>> to reconnect after missing its leases, is when it wants to do clientid
>> trunking. This should be a rare condition so instead of dealing
>> with it we just do not allow it and discard the client for now.
>=20
> We can't wave away incorrect behavior with "but it's rare".  Users with
> heavy and/or unusual workloads hit rare conditions.  Clients may change
> their behavior over time.  (E.g., trunking may become more common.)


--
Chuck Lever



