Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918576E9CE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 22:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjDTUMk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 16:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjDTUMi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 16:12:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2531BF2
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 13:12:35 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33KK4lOE027115;
        Thu, 20 Apr 2023 20:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8Rh8OhqNweFKttX8F7+B7bFB4l4kwEk93gHeWPtOQVU=;
 b=eKok4/ORub9JAERWRsySVTqXrKc2PrUvOkgWWwxkNxMhNJWfL9S1Xe362g0gQcU/VsmH
 NHUjGEmWyKxjQc5AM5O7L1PrI02U44eDxMSZZvqS1Wzz1BOv5E6oAhJM2V1tuaB/Zx4M
 UFFH2yxmgmjApq23VZz/PeSjwzyklyY1X8itIMq2RVm1tMeJcBf0IE+/Cq8vr+vlC+8b
 AXoa19AInC494sIgaWNIh24ISHfkITFUQudBrQMWtSN5qf6heQsEY95C307FDMcqjRxd
 STWmhkSDZUdGXTP4BdQ1x9t5CutWmbO/INPoWkgCUNFSQVpGu8ZTvHXIQ0J9LDfaOK/a Dg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyktaus6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 20:12:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33KJbjCD037780;
        Thu, 20 Apr 2023 20:12:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc8rfj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 20:12:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anB2eMT/QqxUjV7zWYh+O69JYRH9WsrjIqLk8W86v3sFBA3ou09qOhdwSLyEZpOCAZG4nEQ/nRRs4+pCmtKvmL0aB+qP/+f9/DUGji0m5Ay58pUQzW/OSE5+ST/qUttjVB2sEzOHOjnMddJF2Ql7d3q7MFrSoYpmJ8dX0L2VqGIgtr7uAQuKYrbjYIQ8iB7SUWmBtOgkTdeR72n1JNs93zKnG8cOMYq4PJo9I4p5YRyNLWrFxKRpsq/QAWwkV/yvDMz70JBlDsd3T6nGue9PxalywIY50e3zz13ZsS2kwHI/sOLTr6U7SBXBW3yQZqVK4VB1WgSpYM0jdNrFaRq+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Rh8OhqNweFKttX8F7+B7bFB4l4kwEk93gHeWPtOQVU=;
 b=f6hdawjV/foj8p+SF5eX5gm8+Onr5Os5fgB3t2lkKhPzR6xFUfVMAnNG23BkALbY4VDVoN9Sl/7QUpweJpk0wRZkH1YhM87CQet8+q6wQuezHEzSh2e0LVExWoXNGaRhWwi2peuptC5lBPU0QYWS/DeXRGGJ4xSg8wUWZdZRJu2ry1wWtzeRDcQL9pqZapSYHN3LmfAEu+canzceMllEqqUwqEd3ytLenMIzsrx0f5I5nEREePWFjdR/NwrDeD+0xQajYgNeF+cJx9HuS0OGXy0weIqGNOtPyPen4jZqYy1BvrVOunhrc13w1mihR1IANnL3KQiUbOttiY2cvCJgRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Rh8OhqNweFKttX8F7+B7bFB4l4kwEk93gHeWPtOQVU=;
 b=MxTP5e0qMgA1adNeu2+2oBlwRspZ1amA60H9z62NLyu4AaGXleWUD8PD0yTHFpNe43ORBQZYP3XwMUls8qY2INXbpfMjwGi6d0tslbrI8FUBnFPCJ5doZUvIenK164yT//AtzGZ04vI47ESybEtQaPVRkao4eXlqmhsbI/ld8+8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA0PR10MB6427.namprd10.prod.outlook.com (2603:10b6:806:2c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 20:12:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%6]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 20:12:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Chuck Lever <cel@kernel.org>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v1] shmem: stable directory cookies
Thread-Topic: [PATCH v1] shmem: stable directory cookies
Thread-Index: AQHZcWIY70gloSR/DE+raKGoXfqrja80j6oAgAAWWAA=
Date:   Thu, 20 Apr 2023 20:12:21 +0000
Message-ID: <E329BC5B-832A-4C46-92CA-EE301244A34D@oracle.com>
References: <168175931561.2843.16288612382874559384.stgit@manet.1015granger.net>
 <d624a7a0d5e477b3c7ba8aa671f1f450d517fb7a.camel@kernel.org>
In-Reply-To: <d624a7a0d5e477b3c7ba8aa671f1f450d517fb7a.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA0PR10MB6427:EE_
x-ms-office365-filtering-correlation-id: 585138dd-79e3-4fe2-1b6a-08db41db8cba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: njWGtn8J7oeEA/5wYAE1h5d3iCirDU45LbJzOWzgoC6NvcFNZmb4j/zPHbKHu7ZtlUGc6XmbDah53XKTVmoiKcPeM3e4wQbJFXLQBbz79KDUoEz6qwxdO5UEl7Eeoo2FLJBhfyIG5htjT2tFCFrI6JhJW5ARn4z0AP1U2UQhUtdHj0V+6ftyy0Mzmlrv7IyID0Z58sFOzWz8hkJsOa5xcKIMnwBqXXdVoX3BMxmlS0amxVTpA8jsRkc5DF/ZdptYZbAXwZV8RYkRAmHwNmhI+wHdBI+IJcb4gIFXywrbullJ2krECwqZf2NXoRJovcXyVDnvYfATNfiM17ZesEWsgEH3+4CASYoBGTBzBPvhcB4Q8F/S+A4g5ruXZ6AMDtVlNLfjqgaBWrMnDw9hWSK72k+QLb4z2+GzYUDIhQskuUujpyYpnMPwpjg8XDZtjuGtqu4d6onj9wT/PmUCeZfILuNdEYOyPwV+Z40NfyjhSftaaNmVE8Nd0bfpC6/bZiAKZF+rcGYAJRCqROZmBlPxQilT0kb6RdtKa+wsY7z4ZtSTM5u/ulFmauiP9a5Y8h7MfITbvn2goGIyNBsv0LJQ6Fbc+qu6Z1DRy5lWCwF/Z6qLV9w0Rk9dYwR6tOdFvBe0M0tEshgGmRAZE+XcaS07og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199021)(66476007)(38070700005)(38100700002)(30864003)(2906002)(122000001)(8936002)(8676002)(86362001)(5660300002)(36756003)(33656002)(41300700001)(6486002)(71200400001)(6512007)(53546011)(26005)(6506007)(54906003)(478600001)(2616005)(83380400001)(186003)(91956017)(316002)(66946007)(76116006)(66556008)(6916009)(4326008)(64756008)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E8RZ6OEogNGEHLD6X+1WOQ6MNsXhHCOGUHuwVPZi8L3H6j8K2la+Uuk3YOmy?=
 =?us-ascii?Q?eEca0n2wcdQ6zsTeIj62q9lrGpPM+jHv/u5xGchQVvHsA0k2MFpXzLVtmIDs?=
 =?us-ascii?Q?8IOBmjvqdEIoU31ZVUzqJxeFr6W0kFT4u8njOuJ4e4i4ct8UxD3LLxpzsMnW?=
 =?us-ascii?Q?gOWcnoe7jM9+TTInBqzUhu8yPxZYGUNO16htEC10XV3bssktrRLAoXqJL77c?=
 =?us-ascii?Q?zFGrlDaCShbeMx4EdeQGRYaflhgHUAEuquUWBQgHoUhRSiBu2ybw9Nujwmwl?=
 =?us-ascii?Q?RBGdIQJaB/EvM1NQi+giDcX8Iu0wYrQsa2TXnDHy6wrpXPMf9qREd7xcq/qD?=
 =?us-ascii?Q?8OiZOhSXKnABEzzDjtOblKZqDHFdCsvpi0zW6WyHQZV8FHxeRUZeJTiWtFIH?=
 =?us-ascii?Q?6wSAXEAGnZyjiGNrsQY++WpUM1vCT7vBLfrIbt6NPyraLsU3vPaGXNGWspjl?=
 =?us-ascii?Q?7073qEhD95HnGsyIhdcpYhckc6O1YAtpOjYNaNhvYNnsYuxQ0lz99RG3Dakd?=
 =?us-ascii?Q?6tGv/CbrFwAf7JYZdjwj3/kYnRbNi6fxRY0Z5RpHXL8tqmOydm5gLjzgwGYq?=
 =?us-ascii?Q?apTwlwPW49BdhMpQOHt6lY0YgAG9Oe/np1oNiNuxtL3ebaLpc9GiolAvB7oC?=
 =?us-ascii?Q?W3JLyWKYAR7zs5JC8t91RXeA9iIGkRqzKbmhawXG0mqkZJ1dmARPBqVIbjfD?=
 =?us-ascii?Q?Uw+iuQx81Ppe1INGZYZ8RICn9IW4mBJ+qdgxlpbC6mWTwhNP5RMd8oBxBrnC?=
 =?us-ascii?Q?2cwqb/PQ2ouckpvIVPiy8IBO4AJq2orLpqjhI7DerEsjhaaubuZ19C4SjZJO?=
 =?us-ascii?Q?ewhAbeanT00o+XB5P3X4eWSr7SYth77Eugtnr4+zRUnKAwFdmGNsPLR7MzNE?=
 =?us-ascii?Q?vhneP0rD00KjMXE3AEpnlMPrASww+Ys0C9/QE5XuiPzcJug0204meBElKaBJ?=
 =?us-ascii?Q?xeyf3fiu0Hf/2X7/h+dSGN2BGpQB7kWtGb3hAjXiUvhSbw1toqG/GvghF2T3?=
 =?us-ascii?Q?DsdlRLNuFcBRt5owTZJMqoZoEdvQkhLmRkaZPuSyk9/UE0usYKSh0AEdd/U+?=
 =?us-ascii?Q?XQAmopnF4CQcLYqLfdUmISZW189NUR7z7Q7Rcmm2raXEXeJBvw2Nb94+ikww?=
 =?us-ascii?Q?bpvsVXYOzrO9ji4Zo4jEXo4cfaHu2PABm/ey1N3CJCOtdW+5bJSYaSp+jYzq?=
 =?us-ascii?Q?0Zf57+ORmEKhksO5aa0c4ivjhwh52OeO2XnkA0Ye+BMUG5uqecJ4bmDG6RMu?=
 =?us-ascii?Q?piswBMGmyCG59EdQvo0LEIX/jq21wa5Ruame5HkB2dH2TqXpraxLKRqoepBr?=
 =?us-ascii?Q?aM6KvJNJcb/XHm2yeoUZWfWmzGKevj7i/qvUkjNlCQ0Xya9JpZ77yFWWUeQ2?=
 =?us-ascii?Q?pRVkEO9bj3tHf/xro6GuHDCkbjmlxDEoDA8pAxpSsMYDrfBjhjlnn4YWfQdm?=
 =?us-ascii?Q?bqV4MYot3MgXpqEs/Ax7euyJRVi5zqNNGQM2HSVWTARMBiR5n8LTVJQW2hqw?=
 =?us-ascii?Q?fETSem0givs5ySf7sGvLV6M0+I9OEaei6+kUBFNU/D0nA2Jtllf6DoxfwNa8?=
 =?us-ascii?Q?4mpdm5Pawwjkkf8fzkGl906sZvyrZDVqjmAexm1gHqTFRTYDw3C3nx4vZARw?=
 =?us-ascii?Q?2A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4988BCCD491846438EFBA74724F4313F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ELn4KdHSyiBqS30Xb5ZCcey+Qpy61lnJ/KwSCSbMJDDxqD21n4897tLX+3zMuU5SXqKjdwvn57Aku4VziHwB9NaCxgZcA/WLgc9iTsXL4dbOzoDM6yqQHFlCvcK0xqjWiM+yAsqkXj3Bt6qxllrseyryP8LVqi6fctDYQj3hOwifOMYCGRtZ5cRBrZRGcqf0Iigz2G3mBFubGjqixKDH5HsXChwx2kHetRQ1oKjpnlLJrLeVkmZB3DZvYlwk9Aul6i5YHvqtP4lt5ETmQBZDLm7XCrKoy9B9DqJTWNHnqTEuNdDiyKhQyk3fkjRoanot8sMm+NvmnovP8tZwH+Zn6ij5H0fK+5wjg8RcaGvtywpeomEOO+BpDNMy9ir5AOetPZqG13Ot9vLZ9VcViD+QiU0ow15zcIhSQkspIJ7/c4p7UFZ22CdkSPVqfqDMcMCVI+HxLKMVYzVryy0MkAKT5Ix4Nl6Erx02I00zDx+OiVvNiTqCNLFCWNH9L8b+egrXKBKnC1Un6z+95vpueQOyD+fIZmYClMxhZWDvWxMWlItg41hpshGtsKxpQEUrLxj5IEgCwLZwRiotoGgDKl8Cz37BtK7R3fBQCz3LPOnPrRS+5Rpg76FNOFCw9vwCEeFIHzadR6FFETjKE4/RXedi8Zqyik4+LSHaDsVPFCmBX7iWYdBr4nHQ1BnC3s8ergkl6YXTENzTNZyllw7uQ4n8UqzeJVRO5nnvU6gP2LShTS7UXqeE8slu4uwEl6GyIz87hqJcEmXSE46LlfoIKdggD316h1uiSPeF7kI5aMNlJAbgS+SNkzg4qvl8pAH6l20sOClKnyK3jlYCoRYvsymsCyMX7ojSk7tqLje0d9pkrPcgpNy2KHwES7HcMUrjP3JAv6HuEx7h3o/OWBhrMf7ABA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 585138dd-79e3-4fe2-1b6a-08db41db8cba
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 20:12:21.7467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KKalTLZ/hAlM5M0N2R7UpUBz0Hoe0oT+1htGJCVxTkWdgQtafvENTlDZ6k+7ZGntYUPbxJSWRFqw07uwfcXBsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR10MB6427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_15,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200169
X-Proofpoint-ORIG-GUID: UVT70zvn2K97CUcTpW-mTFZuyozztY2s
X-Proofpoint-GUID: UVT70zvn2K97CUcTpW-mTFZuyozztY2s
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Apr 20, 2023, at 2:52 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2023-04-17 at 15:23 -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> The current cursor-based directory cookie mechanism doesn't work
>> when a tmpfs filesystem is exported via NFS. This is because NFS
>> clients do not open directories: each READDIR operation has to open
>> the directory on the server, read it, then close it. The cursor
>> state for that directory, being associated strictly with the opened
>> struct file, is then discarded.
>>=20
>> Directory cookies are cached not only by NFS clients, but also by
>> user space libraries on those clients. Essentially there is no way
>> to invalidate those caches when directory offsets have changed on
>> an NFS server after the offset-to-dentry mapping changes.
>>=20
>> The solution we've come up with is to make the directory cookie for
>> each file in a tmpfs filesystem stable for the life of the directory
>> entry it represents.
>>=20
>> Add a per-directory xarray. shmem_readdir() uses this to map each
>> directory offset (an loff_t integer) to the memory address of a
>> struct dentry.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> include/linux/shmem_fs.h |    2=20
>> mm/shmem.c               |  213 ++++++++++++++++++++++++++++++++++++++++=
+++---
>> 2 files changed, 201 insertions(+), 14 deletions(-)
>>=20
>> Changes since RFC:
>> - Destroy xarray in shmem_destroy_inode() instead of free_in_core_inode(=
)
>> - A few cosmetic updates
>>=20
>> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
>> index 103d1000a5a2..682ef885aa89 100644
>> --- a/include/linux/shmem_fs.h
>> +++ b/include/linux/shmem_fs.h
>> @@ -26,6 +26,8 @@ struct shmem_inode_info {
>> atomic_t stop_eviction; /* hold when working on inode */
>> struct timespec64 i_crtime; /* file creation time */
>> unsigned int fsflags; /* flags for FS_IOC_[SG]ETFLAGS */
>> + struct xarray doff_map; /* dir offset to entry mapping */
>> + u32 next_doff;
>> struct inode vfs_inode;
>> };
>>=20
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 448f393d8ab2..ba4176499e5c 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -40,6 +40,8 @@
>> #include <linux/fs_parser.h>
>> #include <linux/swapfile.h>
>> #include <linux/iversion.h>
>> +#include <linux/xarray.h>
>> +
>> #include "swap.h"
>>=20
>> static struct vfsmount *shm_mnt;
>> @@ -234,6 +236,7 @@ static const struct super_operations shmem_ops;
>> const struct address_space_operations shmem_aops;
>> static const struct file_operations shmem_file_operations;
>> static const struct inode_operations shmem_inode_operations;
>> +static const struct file_operations shmem_dir_operations;
>> static const struct inode_operations shmem_dir_inode_operations;
>> static const struct inode_operations shmem_special_inode_operations;
>> static const struct vm_operations_struct shmem_vm_ops;
>> @@ -2397,7 +2400,9 @@ static struct inode *shmem_get_inode(struct mnt_id=
map *idmap, struct super_block
>> /* Some things misbehave if size =3D=3D 0 on a directory */
>> inode->i_size =3D 2 * BOGO_DIRENT_SIZE;
>> inode->i_op =3D &shmem_dir_inode_operations;
>> - inode->i_fop =3D &simple_dir_operations;
>> + inode->i_fop =3D &shmem_dir_operations;
>> + xa_init_flags(&info->doff_map, XA_FLAGS_ALLOC1);
>> + info->next_doff =3D 0;
>> break;
>> case S_IFLNK:
>> /*
>> @@ -2917,6 +2922,71 @@ static int shmem_statfs(struct dentry *dentry, st=
ruct kstatfs *buf)
>> return 0;
>> }
>>=20
>> +static struct xarray *shmem_doff_map(struct inode *dir)
>> +{
>> + return &SHMEM_I(dir)->doff_map;
>> +}
>> +
>> +static int shmem_doff_add(struct inode *dir, struct dentry *dentry)
>> +{
>> + struct shmem_inode_info *info =3D SHMEM_I(dir);
>> + struct xa_limit limit =3D XA_LIMIT(2, U32_MAX);
>> + u32 offset;
>> + int ret;
>> +
>> + if (dentry->d_fsdata)
>> + return -EBUSY;
>> +
>> + offset =3D 0;
>> + ret =3D xa_alloc_cyclic(shmem_doff_map(dir), &offset, dentry, limit,
>> +       &info->next_doff, GFP_KERNEL);
>> + if (ret < 0)
>> + return ret;
>> +
>> + dentry->d_fsdata =3D (void *)(unsigned long)offset;
>> + return 0;
>> +}
>> +
>> +static struct dentry *shmem_doff_find_after(struct dentry *dir,
>> +     unsigned long *offset)
>> +{
>> + struct xarray *xa =3D shmem_doff_map(d_inode(dir));
>> + struct dentry *d, *found =3D NULL;
>> +
>> + spin_lock(&dir->d_lock);
>> + d =3D xa_find_after(xa, offset, ULONG_MAX, XA_PRESENT);
>> + if (d) {
>> + spin_lock_nested(&d->d_lock, DENTRY_D_LOCK_NESTED);
>> + if (simple_positive(d))
>> + found =3D dget_dlock(d);
>> + spin_unlock(&d->d_lock);
>> + }
>> + spin_unlock(&dir->d_lock);
>=20
> This part is kind of gross, but I think I get it now...
>=20
> You have to take dir->d_lock to ensure that "d" doesn't go away when you
> don't hold a ref on it, and you need the child's d_lock to ensure that
> simple_positive result is stable while you take a reference (because
> doing a dput there could be problematic). If that's right, then that's a
> bit subtle, and might deserve a nice comment.
>=20
> I do wonder if there is some way to do this with RCU instead, but this
> seems to work well enough.

I lifted this from fs/libfs.c, fwiw.


>> + return found;
>> +}
>> +
>> +static void shmem_doff_remove(struct inode *dir, struct dentry *dentry)
>> +{
>> + u32 offset =3D (u32)(unsigned long)dentry->d_fsdata;
>> +
>> + if (!offset)
>> + return;
>> +
>> + xa_erase(shmem_doff_map(dir), offset);
>> + dentry->d_fsdata =3D NULL;
>> +}
>> +
>> +/*
>> + * During fs teardown (eg. umount), a directory's doff_map might still
>> + * contain entries. xa_destroy() cleans out anything that remains.
>> + */
>> +static void shmem_doff_map_destroy(struct inode *inode)
>> +{
>> + struct xarray *xa =3D shmem_doff_map(inode);
>> +
>> + xa_destroy(xa);
>> +}
>> +
>> /*
>>  * File creation. Allocate an inode, and we're done..
>>  */
>> @@ -2938,6 +3008,10 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode=
 *dir,
>> if (error && error !=3D -EOPNOTSUPP)
>> goto out_iput;
>>=20
>> + error =3D shmem_doff_add(dir, dentry);
>> + if (error)
>> + goto out_iput;
>> +
>> error =3D 0;
>> dir->i_size +=3D BOGO_DIRENT_SIZE;
>> dir->i_ctime =3D dir->i_mtime =3D current_time(dir);
>> @@ -3015,6 +3089,10 @@ static int shmem_link(struct dentry *old_dentry, =
struct inode *dir, struct dentr
>> goto out;
>> }
>>=20
>> + ret =3D shmem_doff_add(dir, dentry);
>> + if (ret)
>> + goto out;
>> +
>> dir->i_size +=3D BOGO_DIRENT_SIZE;
>> inode->i_ctime =3D dir->i_ctime =3D dir->i_mtime =3D current_time(inode)=
;
>> inode_inc_iversion(dir);
>> @@ -3033,6 +3111,8 @@ static int shmem_unlink(struct inode *dir, struct =
dentry *dentry)
>> if (inode->i_nlink > 1 && !S_ISDIR(inode->i_mode))
>> shmem_free_inode(inode->i_sb);
>>=20
>> + shmem_doff_remove(dir, dentry);
>> +
>> dir->i_size -=3D BOGO_DIRENT_SIZE;
>> inode->i_ctime =3D dir->i_ctime =3D dir->i_mtime =3D current_time(inode)=
;
>> inode_inc_iversion(dir);
>> @@ -3091,24 +3171,37 @@ static int shmem_rename2(struct mnt_idmap *idmap=
,
>> {
>> struct inode *inode =3D d_inode(old_dentry);
>> int they_are_dirs =3D S_ISDIR(inode->i_mode);
>> + int error;
>>=20
>> if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
>> return -EINVAL;
>>=20
>> - if (flags & RENAME_EXCHANGE)
>> + if (flags & RENAME_EXCHANGE) {
>> + shmem_doff_remove(old_dir, old_dentry);
>> + shmem_doff_remove(new_dir, new_dentry);
>> + error =3D shmem_doff_add(new_dir, old_dentry);
>> + if (error)
>> + return error;
>> + error =3D shmem_doff_add(old_dir, new_dentry);
>> + if (error)
>> + return error;
>> return simple_rename_exchange(old_dir, old_dentry, new_dir, new_dentry);
>> + }
>>=20
>> if (!simple_empty(new_dentry))
>> return -ENOTEMPTY;
>>=20
>> if (flags & RENAME_WHITEOUT) {
>> - int error;
>> -
>> error =3D shmem_whiteout(idmap, old_dir, old_dentry);
>> if (error)
>> return error;
>> }
>>=20
>> + shmem_doff_remove(old_dir, old_dentry);
>> + error =3D shmem_doff_add(new_dir, old_dentry);
>> + if (error)
>> + return error;
>> +
>> if (d_really_is_positive(new_dentry)) {
>> (void) shmem_unlink(new_dir, new_dentry);
>> if (they_are_dirs) {
>> @@ -3149,26 +3242,22 @@ static int shmem_symlink(struct mnt_idmap *idmap=
, struct inode *dir,
>>=20
>> error =3D security_inode_init_security(inode, dir, &dentry->d_name,
>>      shmem_initxattrs, NULL);
>> - if (error && error !=3D -EOPNOTSUPP) {
>> - iput(inode);
>> - return error;
>> - }
>> + if (error && error !=3D -EOPNOTSUPP)
>> + goto out_iput;
>>=20
>> inode->i_size =3D len-1;
>> if (len <=3D SHORT_SYMLINK_LEN) {
>> inode->i_link =3D kmemdup(symname, len, GFP_KERNEL);
>> if (!inode->i_link) {
>> - iput(inode);
>> - return -ENOMEM;
>> + error =3D -ENOMEM;
>> + goto out_iput;
>> }
>> inode->i_op =3D &shmem_short_symlink_operations;
>> } else {
>> inode_nohighmem(inode);
>> error =3D shmem_get_folio(inode, 0, &folio, SGP_WRITE);
>> - if (error) {
>> - iput(inode);
>> - return error;
>> - }
>> + if (error)
>> + goto out_iput;
>> inode->i_mapping->a_ops =3D &shmem_aops;
>> inode->i_op =3D &shmem_symlink_inode_operations;
>> memcpy(folio_address(folio), symname, len);
>> @@ -3177,12 +3266,20 @@ static int shmem_symlink(struct mnt_idmap *idmap=
, struct inode *dir,
>> folio_unlock(folio);
>> folio_put(folio);
>> }
>> +
>> + error =3D shmem_doff_add(dir, dentry);
>> + if (error)
>> + goto out_iput;
>> +
>> dir->i_size +=3D BOGO_DIRENT_SIZE;
>> dir->i_ctime =3D dir->i_mtime =3D current_time(dir);
>> inode_inc_iversion(dir);
>> d_instantiate(dentry, inode);
>> dget(dentry);
>> return 0;
>> +out_iput:
>> + iput(inode);
>> + return error;
>> }
>>=20
>> static void shmem_put_link(void *arg)
>> @@ -3224,6 +3321,77 @@ static const char *shmem_get_link(struct dentry *=
dentry,
>> return folio_address(folio);
>> }
>>=20
>> +static loff_t shmem_dir_llseek(struct file *file, loff_t offset, int wh=
ence)
>> +{
>> + switch (whence) {
>> + case SEEK_CUR:
>> + offset +=3D file->f_pos;
>> + fallthrough;
>> + case SEEK_SET:
>> + if (offset >=3D 0)
>> + break;
>> + fallthrough;
>> + default:
>> + return -EINVAL;
>> + }
>> + return vfs_setpos(file, offset, U32_MAX);
>> +}
>> +
>> +static bool shmem_dir_emit(struct dir_context *ctx, struct dentry *dent=
ry)
>> +{
>> + struct inode *inode =3D d_inode(dentry);
>> +
>> + return ctx->actor(ctx, dentry->d_name.name, dentry->d_name.len,
>> +   (loff_t)dentry->d_fsdata, inode->i_ino,
>> +   fs_umode_to_dtype(inode->i_mode));
>> +}
>> +
>> +/**
>> + * shmem_readdir - Emit entries starting at offset @ctx->pos
>> + * @file: an open directory to iterate over
>> + * @ctx: directory iteration context
>> + *
>> + * Caller must hold @file's i_rwsem to prevent insertion or removal of
>> + * entries during this call.
>> + *
>> + * On entry, @ctx->pos contains an offset that represents the first ent=
ry
>> + * to be read from the directory.
>> + *
>> + * The operation continues until there are no more entries to read, or
>> + * until the ctx->actor indicates there is no more space in the caller'=
s
>> + * output buffer.
>> + *
>> + * On return, @ctx->pos contains an offset that will read the next entr=
y
>> + * in this directory when shmem_readdir() is called again with @ctx.
>> + *
>> + * Return values:
>> + *   %0 - Complete
>> + */
>> +static int shmem_readdir(struct file *file, struct dir_context *ctx)
>> +{
>> + struct dentry *dentry, *dir =3D file->f_path.dentry;
>> + unsigned long offset;
>> +
>> + lockdep_assert_held(&d_inode(dir)->i_rwsem);
>=20
> You probably don't need the above. This is called via ->iterate_shared
> so the lock had _better_ be held.

True, it's not 100% necessary.

I was trying to document the API contract, part of which is
"caller needs to hold dir->i_rwsem". This seemed like the most
crisp way to do that.


>> +
>> + if (!dir_emit_dots(file, ctx))
>> + goto out;
>> + for (offset =3D ctx->pos - 1; offset < ULONG_MAX - 1;) {
>> + dentry =3D shmem_doff_find_after(dir, &offset);
>> + if (!dentry)
>> + break;
>> + if (!shmem_dir_emit(ctx, dentry)) {
>> + dput(dentry);
>> + break;
>> + }
>> + ctx->pos =3D offset + 1;
>> + dput(dentry);
>> + }
>> +
>> +out:
>> + return 0;
>> +}
>> +
>> #ifdef CONFIG_TMPFS_XATTR
>>=20
>> static int shmem_fileattr_get(struct dentry *dentry, struct fileattr *fa=
)
>> @@ -3742,6 +3910,12 @@ static int shmem_show_options(struct seq_file *se=
q, struct dentry *root)
>> return 0;
>> }
>>=20
>> +#else /* CONFIG_TMPFS */
>> +
>> +static inline void shmem_doff_map_destroy(struct inode *dir)
>> +{
>> +}
>> +
>> #endif /* CONFIG_TMPFS */
>>=20
>> static void shmem_put_super(struct super_block *sb)
>> @@ -3888,6 +4062,8 @@ static void shmem_destroy_inode(struct inode *inod=
e)
>> {
>> if (S_ISREG(inode->i_mode))
>> mpol_free_shared_policy(&SHMEM_I(inode)->policy);
>> + if (S_ISDIR(inode->i_mode))
>> + shmem_doff_map_destroy(inode);
>> }
>>=20
>> static void shmem_init_inode(void *foo)
>> @@ -3955,6 +4131,15 @@ static const struct inode_operations shmem_inode_=
operations =3D {
>> #endif
>> };
>>=20
>> +static const struct file_operations shmem_dir_operations =3D {
>> +#ifdef CONFIG_TMPFS
>> + .llseek =3D shmem_dir_llseek,
>> + .iterate_shared =3D shmem_readdir,
>> +#endif
>> + .read =3D generic_read_dir,
>> + .fsync =3D noop_fsync,
>> +};
>> +
>> static const struct inode_operations shmem_dir_inode_operations =3D {
>> #ifdef CONFIG_TMPFS
>> .getattr =3D shmem_getattr,
>>=20
>>=20
>=20
> Other than the nits above, this all looks fine to me. I've done some
> testing with this series too and it all seems to work as expected, and
> fixes some nasty problems when trying to recursively remove directories
> via nfsd.

Thanks for your review, testing, and suggestions.


> Have you done any performance testing? My expectation would be that
> you'd have roughly similar (or even faster) performance with this set,
> but at the expense of a bit of memory (for the xarrays).

I don't have any directory microbenchmarks. I suppose I could
do something like timing large software builds.


> One thing we could consider is lifting the bulk of this code into libfs,
> so other shmem-like filesystems can take advantage of it, but that work
> could be done later too when we have another proposed consumer.

Eg. autofs.


--
Chuck Lever


