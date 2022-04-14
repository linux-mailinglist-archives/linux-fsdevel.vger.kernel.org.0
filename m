Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B81D500345
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Apr 2022 02:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237339AbiDNA5p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 20:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239343AbiDNA5n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 20:57:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E38F41605;
        Wed, 13 Apr 2022 17:55:20 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23DNXx0A018439;
        Thu, 14 Apr 2022 00:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JmOw/7B6mgbwPon68TIFu/mqYey9b3vtSN0zbnJ8w0k=;
 b=ddNZ+oZgZnsDbb8MIZbtUI5wF6bCZfu+PXorItoKmOHGGkyAldkyVlPRjiZX5rOiOlBv
 gB6XKsdUNTD6f/6AquJRK5JgXO+RbimClmIaq/3/Zl8Xw9iKB0DfYvylA6rwffbbZUO6
 +HhGGgMx7x/nNlUhjh2tKKJ8da7UWkhD1QP/QYkAzXl7YAvYlNytT6FYyHfvvJTQ38Kc
 XJr1/CBrrPoG7Q73WvdKVFVNCNDm+fBXiWg2kylH1xh5YzvInBNZ/UmkpjmESpZJCpl7
 pwiiTb7lCisaIVohEgCbZG+umXJtiY9JhGtiv8jXmQeUqrVo0qGIdskXRKuvFA03BLi/ yQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0r1khrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 00:55:05 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23E0lhNN034687;
        Thu, 14 Apr 2022 00:55:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k4a4kr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 00:55:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzjqE5mWBirwPLExC026N2fPfLivTyacdoT6ZfCP75oaxhscVze6vNVjWr5UPwctwjCu4Q2uwT/QK+05Utfjt46ODuriC5jjB9JOqJsQF40Zj1FVAD/VrDc820iYdUXcTvw7G1pu9Xrqhjw/hUXmjkXXjwWUtkr48HwFOvru1X9SlqwTYa2oDJx15+y5TgBkuyfnav0SiH841kre6+mb/FRz3SYCuKORJB5/ODKNrGBs1ejdAjRjHNvBa8+bynpp0IVAOdaH4QOVcD+m9eeFUrcHBmiY0h1n+dMl+70NMRLiJv8y2zehjbM5qN3s82WTe9y2dl6pinCar15qCZiJDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmOw/7B6mgbwPon68TIFu/mqYey9b3vtSN0zbnJ8w0k=;
 b=DKcNHJ4WaBGKBL/qdDepfjjFdaU32ZIdn+wFCWLLYRipFgejJsxSkVmFyzNLxICu1GZEzy/fqlu2nmTmH7dyDHTmDvfE0aKyo7R5V1uNv/0W7MyieUc1bL19cAX7Gqfd6WHVHmAemOdugtBkdgevCuE2NQOVPWHFFfttTv+oB2cEPcN/w/gi690liSDyKKRDKzkOd8rlqJ52MSbEMnkRCmxI8tB6fw3jaf+EKEBOoZq8z05zncsHN0m8AN1O6PmCri272gFUWzM+5rPf7/KArtmF6gzy1YC1exUqao5wd4P/AXF5prQSrXWfKtWYgAUx4vcD+hwhTm6iuJWT9E2gww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmOw/7B6mgbwPon68TIFu/mqYey9b3vtSN0zbnJ8w0k=;
 b=KmoeuvAMzQG9S5niLo8WUFwVecWAnB/wmBdmygFQf0gZpBryWkmynmobAfxK9GFguFxJUiPp7dF6x/mSrcVTXBMTZHYFBYGCJiURcm4sR2RBam/HbkpwiNw5ONOz7hV+2St+g6GNbxcEaZPvKXkqJtpQdmVyBPGUqWn9ycAluJc=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SA2PR10MB4745.namprd10.prod.outlook.com (2603:10b6:806:11b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Thu, 14 Apr
 2022 00:55:02 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%8]) with mapi id 15.20.5144.029; Thu, 14 Apr 2022
 00:55:02 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     david <david@fromorbit.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>, X86 ML <x86@kernel.org>
Subject: Re: [PATCH v7 5/6] pmem: refactor pmem_clear_poison()
Thread-Topic: [PATCH v7 5/6] pmem: refactor pmem_clear_poison()
Thread-Index: AQHYSSYgcxRlD0CAw0GRmRS3uRkg1KzruLCAgALpjYA=
Date:   Thu, 14 Apr 2022 00:55:02 +0000
Message-ID: <9b01d57a-0170-5977-fcda-184617d8e2eb@oracle.com>
References: <20220405194747.2386619-1-jane.chu@oracle.com>
 <20220405194747.2386619-6-jane.chu@oracle.com>
 <CAPcyv4h4NGa7_mTrrY0EqXdGny5p9JtQZx+CVBcHxX6_ZuO9pg@mail.gmail.com>
In-Reply-To: <CAPcyv4h4NGa7_mTrrY0EqXdGny5p9JtQZx+CVBcHxX6_ZuO9pg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c3c1eea-5fa4-49fc-54fe-08da1db16876
x-ms-traffictypediagnostic: SA2PR10MB4745:EE_
x-microsoft-antispam-prvs: <SA2PR10MB4745077EA78267C406D54F52F3EF9@SA2PR10MB4745.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iNYCy0u1U8A7KIWKllVN0y8x+jNqQS/8aytQra3oGbBo22IysANz7uBUj4GO4hEuZoIH+yY6eH3rNvm8SIEjJ+pfS4SDRAPsRXl/uFNFhIxquu85F3OjjftHH0q2gkxRV5mtss+Do/OUnb77DA/LutyPY3bECNVmJTbi2wfLDM3Veiww2SKeLfD5l1cVbHOSRZ4B8I7hl65OoCM91hDR+ntU4n5HnjD2O/yJnKHF1KFiQMOubr6pub/RXNs6bcFdD47u6yhfaUzTNoi62f1pSXPynJnOhaEAiPxiYjBvYCGYMUwo3FPewyDsfERWmzlRwoP+FuCK8W1bFSP7+kma1D2DXJqVZWJdsgvTtc0MYlT92n/CCsWIR3/UjsAL6UGZEINv1EmS8AOj2DKS4nq4k6nS5a1sAHwW7EwFDCSelFGIITyk8y2MUWxOyqd42dueXgpR6LCjyjGqmUwn5e0vD5us7kiGTrlgXqb9xe29gp8qdnz5uidgVdQdl2KKgXjupPuXF3k2drMPl2l1y7Wej/6Vo3QA4GJl4p3wEDSAWPddhD8cPAz0Q/HdEI/UvLY0H8rqfAxXz9QRy/g9RGR0+bhMHNgarUf5QhbMXRGVFbAuJqQwaQ6V+hotFR9/akzS2XCVMX8QP3hojM1PUEMyza8YwJOksImeVVrF0+KesvLS6SR7OypFxp+rUyGInKg9v3XimeIN+ujApo2zb/m2OLy1BmAZZCIwZWc0Tgk/ThbMQFKLHf/NJUVxs9kFalqdavDx28TBmIHjTSkhJqXepg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(71200400001)(6506007)(8676002)(66556008)(64756008)(66446008)(66476007)(4326008)(38100700002)(122000001)(6512007)(31686004)(83380400001)(186003)(26005)(2616005)(36756003)(54906003)(316002)(6916009)(2906002)(76116006)(66946007)(53546011)(31696002)(44832011)(6486002)(38070700005)(508600001)(7416002)(5660300002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVlZeU03eXZDOG5IU3dCTExQeFplcGxieWtacXZLUnFVREJJRWlMZUdTVnM1?=
 =?utf-8?B?cXVHNks4ZmhHWXQwc3FTVDgySk11NG81eDExc3lMK3FnTzI2SWk5TGJpS01S?=
 =?utf-8?B?V2pDSXVSVitRbU5LR3g0SVY2OTV5QVdTWTFnMFVLTmhHTm5xbkp3Y1pkamVH?=
 =?utf-8?B?V0NxMWc3bkRmSkNadnQvUjRjbDZGNm1od0lUd0ZvYVVnKzFXeWRXb2Z1ZTAw?=
 =?utf-8?B?WGZZQ1RqM3lxSG5BQUtLSUFNQUFFUUpsMVoyRVFCY2R0L0c3dTdZRkg3ekhU?=
 =?utf-8?B?NXJ6RHN4TExabHFjd2RHdEZPaTl4Vm9ucFNRZDI0VDA2VUwxNmNQSHZZcmdu?=
 =?utf-8?B?eGVTNHFNcW85WTJwZ0I0OGZYL0QxVTRhZEplOUVidW1qNDlyWk5LL2MyOGdU?=
 =?utf-8?B?Q01CNWxCbVN0TTZ0b3A4Wk03VHJCbXVoc2YyS0VTRVoxU2FFVUxyUFRGOXVv?=
 =?utf-8?B?MkJDcHBjNU1uZnpxTkU3emQwVGlBYnMzZzNDTmZzQXhoaW1XVWpmZm9HUndS?=
 =?utf-8?B?S1hlNXVYczlvUXBUNDRzWitybFhZdVQvMzhRWHpPYzdSaVR5cEVlUS85OC93?=
 =?utf-8?B?S2xGUjVYZmJYeE5ieEVzYnZPZmRHQlNiN210Qk5vUi9EZkN6ZzBSck1iSHNr?=
 =?utf-8?B?Wjl6RmJxQ2czemhoeTVyWTJpcmJjTEp3dDZoNzAvSDZiMEVqQndLaW1IRmo3?=
 =?utf-8?B?RE5udE9YSDdZelBwNi9lTU5nSW1OcjhKRWRLQmVXVmx2dUc1dnkzL0JVdGNs?=
 =?utf-8?B?cHhuN3lVSmVxL3BObTlOQjV5d3lwOHNLaGZJOCtaV3Q1M3RJcVQ2anJUYndj?=
 =?utf-8?B?R3pXbWJCWFFib1F1Mm50c0NYUnFoVUVqTW1iSWZaVjFiNnIrTnhmd3l3ZnYz?=
 =?utf-8?B?cWdBY0F0RUVmU0lvOEhseTFmY1BpSkxWUlJnaCtHVFVVbUdBUlFRZURjQUR3?=
 =?utf-8?B?eXc1eDA5MGZhRlFodC9WdzdGSGZ3M25hTU94L0wxVlBpVHhWTzNzaWxodHFy?=
 =?utf-8?B?aWEvMHFreFduMko4NjNNZExsRFpZMzdzbFlkalk3YmdiclhMcGVvVGxydVN2?=
 =?utf-8?B?Yy9EUlRQRzdpdUJiK2NwMFkyRW1OMjZ4cHFOTTB4bmpNYUFZb1dLb205OC9s?=
 =?utf-8?B?RnB4U1VseHVRTStFS1V5NVlDMXNkM0FLemp4TWRPQWd0dFY3cFVDZWdYOU9i?=
 =?utf-8?B?bUlmOFhJUklheCsvMnRodXU4dmg1VWxxTjRzRG1yVUZwTThYRGhDQ08yNUc0?=
 =?utf-8?B?d3dycmEzbE5pMks0U091Y3d2RC85NUZwSUV5ZnQwcXZ1UkVBVGp5QUh5RHdB?=
 =?utf-8?B?SnhHYVpCNVA3UGlta0QrWHhPclQ4WHVvd1FmUXEwRmJmS0J0c1FKL042eFp2?=
 =?utf-8?B?dkhmV3dkUGhsUjd1emx2dHpXUkpDbzVzOVpqeHluM1cxMUVkenUwWGw5VVFY?=
 =?utf-8?B?Z3ZtY28yY3hYNHQxRHJzMzIwTHBDT2tiZk9ZTHFWZTF1eEMweEc3YTlsWU9t?=
 =?utf-8?B?d2NoNnU1Q0cxMGVUdE1RNjlybUNRaG9iSDh6Y1NRWVlQZUl1L3oxc0JMQk5H?=
 =?utf-8?B?ZFRYYlNDa1o5UmpiZmpVU1o5QmRUd1lldUJDclRGV0JDVDZmcTZ5K2ZNd2NK?=
 =?utf-8?B?WCtkeWRkSi83dXdBTXVVRkYyMlk5Y281cGE0K1VDOFR2ZWloL3VtdkxuT0lu?=
 =?utf-8?B?S0k4Y2tScGUzcEVUMG9SV2xhSmhreHV6Wis4SGlhUVAwbm1rUXdLaTcvNHpL?=
 =?utf-8?B?TWtsNGkySXYveW16QXVrQVJCb1hKT2ZsMUNSZkRIWUh4NlFZNDM2V00xRlBt?=
 =?utf-8?B?R2E3Vzk2WGRoWld5SWNTVkU0SnRCWWZnamkyOWRiNHFvNURCUGZRNnlLcFhM?=
 =?utf-8?B?UnBKRWFRY1lRY1NWOGEyL1R0djExNHA4dWR4dlZ2S0xibzQzSC9yRU1IcnBC?=
 =?utf-8?B?eW9ieloyMVlYdHA3U25aamtQeDgrcSs3NVo2aXdlVVMzTWwrMml2a01jTGhu?=
 =?utf-8?B?N29QM2dkWktrcHRKendJN09WS3NJSGdTelNKY1JqUnY5R2xRNTllTFd5MUFi?=
 =?utf-8?B?Mkg4UnlnR1NjdndiRVhEbTJkL0QrM3NhZ0N0akFLTm56OUx5M3JaZCs3NjdM?=
 =?utf-8?B?dlVlTGttN2xiZkxkcGRFVGZiT1BZSENSQWFyRTBJQ0FVOE43cDlpZnlkNkp3?=
 =?utf-8?B?OExNY2l3UU1BL1ZkRUlHUGFvL3lSWURGbncrN0lUU01IeG0zYk51T1RtUTh5?=
 =?utf-8?B?RmNCSmdHbG1jQ2ovbERmVHVIZ3haNVhSQ2s3anNEYm1tcnNVajgxZlluQTFp?=
 =?utf-8?B?aktVUnE4WS9rK3lQbjU1TEd2MDltdWlnUEZEOWxLclFhd3dVd3dyUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48DD840341EF774CB66666613ABDCCBD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3c1eea-5fa4-49fc-54fe-08da1db16876
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 00:55:02.4255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hycrgXFm8Uo9EO2sCEm2vE79TzCfn5rOloqCnoc0CXjLSHfEarpd8aRxBhVAoyjPBPoqdyf4d/C3v1hl9ZKz0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4745
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-13_04:2022-04-13,2022-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140002
X-Proofpoint-GUID: Ksf6kpwWm0jUPN3K0MkQUaufLE0gCHbb
X-Proofpoint-ORIG-GUID: Ksf6kpwWm0jUPN3K0MkQUaufLE0gCHbb
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8xMS8yMDIyIDk6MjYgUE0sIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gT24gVHVlLCBBcHIg
NSwgMjAyMiBhdCAxMjo0OCBQTSBKYW5lIENodSA8amFuZS5jaHVAb3JhY2xlLmNvbT4gd3JvdGU6
DQo+Pg0KPj4gUmVmYWN0b3IgdGhlIHBtZW1fY2xlYXJfcG9pc29uKCkgaW4gb3JkZXIgdG8gc2hh
cmUgY29tbW9uIGNvZGUNCj4+IGxhdGVyLg0KPj4NCj4gDQo+IEkgd291bGQganVzdCBhZGQgYSBu
b3RlIGhlcmUgYWJvdXQgd2h5LCBpLmUuIHRvIGZhY3RvciBvdXQgdGhlIGNvbW1vbg0KPiBzaGFy
ZWQgY29kZSBiZXR3ZWVuIHRoZSB0eXBpY2FsIHdyaXRlIHBhdGggYW5kIHRoZSByZWNvdmVyeSB3
cml0ZQ0KPiBwYXRoLg0KDQpPa2F5Lg0KDQo+IA0KPj4gU2lnbmVkLW9mZi1ieTogSmFuZSBDaHUg
PGphbmUuY2h1QG9yYWNsZS5jb20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9udmRpbW0vcG1lbS5j
IHwgNzggKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPj4gICAx
IGZpbGUgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pDQo+Pg0KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZkaW1tL3BtZW0uYyBiL2RyaXZlcnMvbnZkaW1tL3BtZW0u
Yw0KPj4gaW5kZXggMDQwMGM1YTdiYTM5Li41NjU5NmJlNzA0MDAgMTAwNjQ0DQo+PiAtLS0gYS9k
cml2ZXJzL252ZGltbS9wbWVtLmMNCj4+ICsrKyBiL2RyaXZlcnMvbnZkaW1tL3BtZW0uYw0KPj4g
QEAgLTQ1LDEwICs0NSwyNyBAQCBzdGF0aWMgc3RydWN0IG5kX3JlZ2lvbiAqdG9fcmVnaW9uKHN0
cnVjdCBwbWVtX2RldmljZSAqcG1lbSkNCj4+ICAgICAgICAgIHJldHVybiB0b19uZF9yZWdpb24o
dG9fZGV2KHBtZW0pLT5wYXJlbnQpOw0KPj4gICB9DQo+Pg0KPj4gLXN0YXRpYyB2b2lkIGh3cG9p
c29uX2NsZWFyKHN0cnVjdCBwbWVtX2RldmljZSAqcG1lbSwNCj4+IC0gICAgICAgICAgICAgICBw
aHlzX2FkZHJfdCBwaHlzLCB1bnNpZ25lZCBpbnQgbGVuKQ0KPj4gK3N0YXRpYyBwaHlzX2FkZHJf
dCB0b19waHlzKHN0cnVjdCBwbWVtX2RldmljZSAqcG1lbSwgcGh5c19hZGRyX3Qgb2Zmc2V0KQ0K
Pj4gICB7DQo+PiArICAgICAgIHJldHVybiAocG1lbS0+cGh5c19hZGRyICsgb2Zmc2V0KTsNCj4g
DQo+IENocmlzdG9waCBhbHJlYWR5IG1lbnRpb25lZCBkcm9wcGluZyB0aGUgdW5uZWNlc3Nhcnkg
cGFyZW50aGVzaXMuDQo+IA0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgc2VjdG9yX3QgdG9fc2Vj
dChzdHJ1Y3QgcG1lbV9kZXZpY2UgKnBtZW0sIHBoeXNfYWRkcl90IG9mZnNldCkNCj4+ICt7DQo+
PiArICAgICAgIHJldHVybiAob2Zmc2V0IC0gcG1lbS0+ZGF0YV9vZmZzZXQpID4+IFNFQ1RPUl9T
SElGVDsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIHBoeXNfYWRkcl90IHRvX29mZnNldChzdHJ1
Y3QgcG1lbV9kZXZpY2UgKnBtZW0sIHNlY3Rvcl90IHNlY3RvcikNCj4+ICt7DQo+PiArICAgICAg
IHJldHVybiAoKHNlY3RvciA8PCBTRUNUT1JfU0hJRlQpICsgcG1lbS0+ZGF0YV9vZmZzZXQpOw0K
Pj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCBwbWVtX2NsZWFyX2h3cG9pc29uKHN0cnVjdCBw
bWVtX2RldmljZSAqcG1lbSwgcGh5c19hZGRyX3Qgb2Zmc2V0LA0KPj4gKyAgICAgICAgICAgICAg
IHVuc2lnbmVkIGludCBsZW4pDQo+IA0KPiBQZXJoYXBzIG5vdyBpcyBhIGdvb2QgdGltZSB0byBy
ZW5hbWUgdGhpcyB0byBzb21ldGhpbmcgZWxzZSBsaWtlDQo+IHBtZW1fY2xlYXJfbWNlX25vc3Bl
YygpPyBKdXN0IHRvIG1ha2UgaXQgbW9yZSBkaXN0aW5jdCBmcm9tDQo+IHBtZW1fY2xlYXJfcG9p
c29uKCkuIFdoaWxlICJod3BvaXNvbiIgaXMgdGhlIHBhZ2UgZmxhZyBuYW1lDQo+IHBtZW1fY2xl
YXJfcG9pc29uKCkgaXMgdGhlIGZ1bmN0aW9uIHRoYXQncyBhY3R1YWxseSBjbGVhcmluZyB0aGUN
Cj4gcG9pc29uIGluIGhhcmR3YXJlICgiaHciKSBhbmQgdGhlIG5ldyBwbWVtX2NsZWFyX21jZV9u
b3NwZWMoKSBpcw0KPiB0b2dnbGluZyB0aGUgcGFnZSBiYWNrIGludG8gc2VydmljZS4NCg0KSSBn
ZXQgeW91ciBwb2ludC4gSG93IGFib3V0IGNhbGxpbmcgdGhlIGZ1bmN0aW9uIGV4cGxpY2l0bHkN
CnBtZW1fbWtwYWdlX3ByZXNlbnQoKT8gb3IgcG1lbV9wYWdlX3ByZXNlbnRfb24oKT8gb3IgDQpw
bWVtX3NldF9wYWdlX3ByZXNlbnQoKT8gIGJlY2F1c2Ugc2V0dGluZyBhIHBvaXNvbmVkIHByZXNl
bnQgcmVxdWlyZXMgDQpib3RoIGNsZWFyaW5nIHRoZSBIV3BvaXNvbiBiaXQgJiBjbGVhciBtY2Vf
bm9zcGVjLg0KDQo+IA0KPj4gK3sNCj4+ICsgICAgICAgcGh5c19hZGRyX3QgcGh5cyA9IHRvX3Bo
eXMocG1lbSwgb2Zmc2V0KTsNCj4+ICAgICAgICAgIHVuc2lnbmVkIGxvbmcgcGZuX3N0YXJ0LCBw
Zm5fZW5kLCBwZm47DQo+PiArICAgICAgIHVuc2lnbmVkIGludCBibGtzID0gbGVuID4+IFNFQ1RP
Ul9TSElGVDsNCj4+DQo+PiAgICAgICAgICAvKiBvbmx5IHBtZW0gaW4gdGhlIGxpbmVhciBtYXAg
c3VwcG9ydHMgSFdQb2lzb24gKi8NCj4+ICAgICAgICAgIGlmIChpc192bWFsbG9jX2FkZHIocG1l
bS0+dmlydF9hZGRyKSkNCj4+IEBAIC02NywzNSArODQsNDQgQEAgc3RhdGljIHZvaWQgaHdwb2lz
b25fY2xlYXIoc3RydWN0IHBtZW1fZGV2aWNlICpwbWVtLA0KPj4gICAgICAgICAgICAgICAgICBp
ZiAodGVzdF9hbmRfY2xlYXJfcG1lbV9wb2lzb24ocGFnZSkpDQo+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgY2xlYXJfbWNlX25vc3BlYyhwZm4pOw0KPj4gICAgICAgICAgfQ0KPj4gKw0KPj4g
KyAgICAgICBkZXZfZGJnKHRvX2RldihwbWVtKSwgIiUjbGx4IGNsZWFyICV1IHNlY3RvciVzXG4i
LA0KPj4gKyAgICAgICAgICAgICAgICh1bnNpZ25lZCBsb25nIGxvbmcpIHRvX3NlY3QocG1lbSwg
b2Zmc2V0KSwgYmxrcywNCj4+ICsgICAgICAgICAgICAgICBibGtzID4gMSA/ICJzIiA6ICIiKTsN
Cj4gDQo+IEluIGFudGljaXBhdGlvbiBvZiBiZXR0ZXIgdHJhY2luZyBzdXBwb3J0IGFuZCB0aGUg
ZmFjdCB0aGF0IHRoaXMgaXMgbm8NCj4gbG9uZ2VyIGNhbGxlZCBmcm9tIHBtZW1fY2xlYXJfcG9p
c29uKCkgbGV0J3MgZHJvcCBpdCBmb3Igbm93Lg0KDQpPS2F5Lg0KDQo+IA0KPj4gICB9DQo+Pg0K
Pj4gLXN0YXRpYyBibGtfc3RhdHVzX3QgcG1lbV9jbGVhcl9wb2lzb24oc3RydWN0IHBtZW1fZGV2
aWNlICpwbWVtLA0KPj4gK3N0YXRpYyB2b2lkIHBtZW1fY2xlYXJfYmIoc3RydWN0IHBtZW1fZGV2
aWNlICpwbWVtLCBzZWN0b3JfdCBzZWN0b3IsIGxvbmcgYmxrcykNCj4+ICt7DQo+PiArICAgICAg
IGlmIChibGtzID09IDApDQo+PiArICAgICAgICAgICAgICAgcmV0dXJuOw0KPj4gKyAgICAgICBi
YWRibG9ja3NfY2xlYXIoJnBtZW0tPmJiLCBzZWN0b3IsIGJsa3MpOw0KPj4gKyAgICAgICBpZiAo
cG1lbS0+YmJfc3RhdGUpDQo+PiArICAgICAgICAgICAgICAgc3lzZnNfbm90aWZ5X2RpcmVudChw
bWVtLT5iYl9zdGF0ZSk7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBsb25nIF9fcG1lbV9jbGVh
cl9wb2lzb24oc3RydWN0IHBtZW1fZGV2aWNlICpwbWVtLA0KPj4gICAgICAgICAgICAgICAgICBw
aHlzX2FkZHJfdCBvZmZzZXQsIHVuc2lnbmVkIGludCBsZW4pDQo+PiAgIHsNCj4+IC0gICAgICAg
c3RydWN0IGRldmljZSAqZGV2ID0gdG9fZGV2KHBtZW0pOw0KPj4gLSAgICAgICBzZWN0b3JfdCBz
ZWN0b3I7DQo+PiAtICAgICAgIGxvbmcgY2xlYXJlZDsNCj4+IC0gICAgICAgYmxrX3N0YXR1c190
IHJjID0gQkxLX1NUU19PSzsNCj4+IC0NCj4+IC0gICAgICAgc2VjdG9yID0gKG9mZnNldCAtIHBt
ZW0tPmRhdGFfb2Zmc2V0KSAvIDUxMjsNCj4+IC0NCj4+IC0gICAgICAgY2xlYXJlZCA9IG52ZGlt
bV9jbGVhcl9wb2lzb24oZGV2LCBwbWVtLT5waHlzX2FkZHIgKyBvZmZzZXQsIGxlbik7DQo+PiAt
ICAgICAgIGlmIChjbGVhcmVkIDwgbGVuKQ0KPj4gLSAgICAgICAgICAgICAgIHJjID0gQkxLX1NU
U19JT0VSUjsNCj4+IC0gICAgICAgaWYgKGNsZWFyZWQgPiAwICYmIGNsZWFyZWQgLyA1MTIpIHsN
Cj4+IC0gICAgICAgICAgICAgICBod3BvaXNvbl9jbGVhcihwbWVtLCBwbWVtLT5waHlzX2FkZHIg
KyBvZmZzZXQsIGNsZWFyZWQpOw0KPj4gLSAgICAgICAgICAgICAgIGNsZWFyZWQgLz0gNTEyOw0K
Pj4gLSAgICAgICAgICAgICAgIGRldl9kYmcoZGV2LCAiJSNsbHggY2xlYXIgJWxkIHNlY3RvciVz
XG4iLA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAodW5zaWduZWQgbG9uZyBs
b25nKSBzZWN0b3IsIGNsZWFyZWQsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGNsZWFyZWQgPiAxID8gInMiIDogIiIpOw0KPj4gLSAgICAgICAgICAgICAgIGJhZGJsb2Nrc19j
bGVhcigmcG1lbS0+YmIsIHNlY3RvciwgY2xlYXJlZCk7DQo+PiAtICAgICAgICAgICAgICAgaWYg
KHBtZW0tPmJiX3N0YXRlKQ0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgc3lzZnNfbm90aWZ5
X2RpcmVudChwbWVtLT5iYl9zdGF0ZSk7DQo+PiArICAgICAgIHBoeXNfYWRkcl90IHBoeXMgPSB0
b19waHlzKHBtZW0sIG9mZnNldCk7DQo+PiArICAgICAgIGxvbmcgY2xlYXJlZCA9IG52ZGltbV9j
bGVhcl9wb2lzb24odG9fZGV2KHBtZW0pLCBwaHlzLCBsZW4pOw0KPj4gKw0KPj4gKyAgICAgICBp
ZiAoY2xlYXJlZCA+IDApIHsNCj4+ICsgICAgICAgICAgICAgICBwbWVtX2NsZWFyX2h3cG9pc29u
KHBtZW0sIG9mZnNldCwgY2xlYXJlZCk7DQo+PiArICAgICAgICAgICAgICAgYXJjaF9pbnZhbGlk
YXRlX3BtZW0ocG1lbS0+dmlydF9hZGRyICsgb2Zmc2V0LCBsZW4pOw0KPj4gICAgICAgICAgfQ0K
Pj4gKyAgICAgICByZXR1cm4gY2xlYXJlZDsNCj4+ICt9DQo+Pg0KPj4gLSAgICAgICBhcmNoX2lu
dmFsaWRhdGVfcG1lbShwbWVtLT52aXJ0X2FkZHIgKyBvZmZzZXQsIGxlbik7DQo+PiArc3RhdGlj
IGJsa19zdGF0dXNfdCBwbWVtX2NsZWFyX3BvaXNvbihzdHJ1Y3QgcG1lbV9kZXZpY2UgKnBtZW0s
DQo+PiArICAgICAgICAgICAgICAgcGh5c19hZGRyX3Qgb2Zmc2V0LCB1bnNpZ25lZCBpbnQgbGVu
KQ0KPj4gK3sNCj4+ICsgICAgICAgbG9uZyBjbGVhcmVkID0gX19wbWVtX2NsZWFyX3BvaXNvbihw
bWVtLCBvZmZzZXQsIGxlbik7DQo+Pg0KPj4gLSAgICAgICByZXR1cm4gcmM7DQo+PiArICAgICAg
IGlmIChjbGVhcmVkIDwgMCkNCj4+ICsgICAgICAgICAgICAgICByZXR1cm4gQkxLX1NUU19JT0VS
UjsNCj4+ICsNCj4+ICsgICAgICAgcG1lbV9jbGVhcl9iYihwbWVtLCB0b19zZWN0KHBtZW0sIG9m
ZnNldCksIGNsZWFyZWQgPj4gU0VDVE9SX1NISUZUKTsNCj4+ICsgICAgICAgcmV0dXJuIChjbGVh
cmVkIDwgbGVuKSA/IEJMS19TVFNfSU9FUlIgOiBCTEtfU1RTX09LOw0KPiANCj4gSSBwcmVmZXIg
ImlmIC8gZWxzZSIgc3ludGF4IGluc3RlYWQgb2YgYSB0ZXJuYXJ5IGNvbmRpdGlvbmFsLg0KPiAN
Cg0KR290IGl0Lg0KDQo+PiAgIH0NCj4+DQo+PiAgIHN0YXRpYyB2b2lkIHdyaXRlX3BtZW0odm9p
ZCAqcG1lbV9hZGRyLCBzdHJ1Y3QgcGFnZSAqcGFnZSwNCj4+IEBAIC0xNDMsNyArMTY5LDcgQEAg
c3RhdGljIGJsa19zdGF0dXNfdCBwbWVtX2RvX3JlYWQoc3RydWN0IHBtZW1fZGV2aWNlICpwbWVt
LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgIHNlY3Rvcl90IHNlY3RvciwgdW5zaWduZWQg
aW50IGxlbikNCj4+ICAgew0KPj4gICAgICAgICAgYmxrX3N0YXR1c190IHJjOw0KPj4gLSAgICAg
ICBwaHlzX2FkZHJfdCBwbWVtX29mZiA9IHNlY3RvciAqIDUxMiArIHBtZW0tPmRhdGFfb2Zmc2V0
Ow0KPj4gKyAgICAgICBwaHlzX2FkZHJfdCBwbWVtX29mZiA9IHRvX29mZnNldChwbWVtLCBzZWN0
b3IpOw0KPj4gICAgICAgICAgdm9pZCAqcG1lbV9hZGRyID0gcG1lbS0+dmlydF9hZGRyICsgcG1l
bV9vZmY7DQo+Pg0KPj4gICAgICAgICAgaWYgKHVubGlrZWx5KGlzX2JhZF9wbWVtKCZwbWVtLT5i
Yiwgc2VjdG9yLCBsZW4pKSkNCj4+IEBAIC0xNTgsNyArMTg0LDcgQEAgc3RhdGljIGJsa19zdGF0
dXNfdCBwbWVtX2RvX3dyaXRlKHN0cnVjdCBwbWVtX2RldmljZSAqcG1lbSwNCj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICBzdHJ1Y3QgcGFnZSAqcGFnZSwgdW5zaWduZWQgaW50IHBhZ2Vfb2Zm
LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgIHNlY3Rvcl90IHNlY3RvciwgdW5zaWduZWQg
aW50IGxlbikNCj4+ICAgew0KPj4gLSAgICAgICBwaHlzX2FkZHJfdCBwbWVtX29mZiA9IHNlY3Rv
ciAqIDUxMiArIHBtZW0tPmRhdGFfb2Zmc2V0Ow0KPj4gKyAgICAgICBwaHlzX2FkZHJfdCBwbWVt
X29mZiA9IHRvX29mZnNldChwbWVtLCBzZWN0b3IpOw0KPj4gICAgICAgICAgdm9pZCAqcG1lbV9h
ZGRyID0gcG1lbS0+dmlydF9hZGRyICsgcG1lbV9vZmY7DQo+Pg0KPj4gICAgICAgICAgaWYgKHVu
bGlrZWx5KGlzX2JhZF9wbWVtKCZwbWVtLT5iYiwgc2VjdG9yLCBsZW4pKSkgew0KPiANCj4gV2l0
aCB0aG9zZSBzbWFsbCBmaXh1cHMgeW91IGNhbiBhZGQ6DQo+IA0KPiBSZXZpZXdlZC1ieTogRGFu
IFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQoNClRoYW5rcyENCi1qYW5lDQoN
Cg==
