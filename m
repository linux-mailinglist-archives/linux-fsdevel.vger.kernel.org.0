Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA70461FDF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 20:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350036AbhK2TJb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 14:09:31 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37866 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379028AbhK2TH3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:07:29 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJ33ve022480;
        Mon, 29 Nov 2021 19:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0G0DCJp8a7ZH0RcJfhkH3dBA27GCotCzxu0gS7GbLK8=;
 b=r2EuqIHDwfVPXRbe9bDGjJ9ZRL/ZPgN+3dZrlbVM22wbc3abHp5nxjtj56JZx2MIIFgj
 hljmjJrsJt4MxYlslrQ2fmoBGjAIXy1VwRmKUVlrvKyig4A2VZGcSIuMSbX5QD+OYn61
 Ul3SxRdzNRpoHc4QcXnMEnSlbgHmbH51t0v38xrwxuoh0KwV9PKPeuah4nKH4LbmXf/1
 wp0JOk1jnGeE1pYL+R7qxRAoGCmBjAL2VB9ao/BR3REaScEA6wmRwbwTa0mw7D6xbKAO
 jXr4Iqsnm6LFODuWsEWxYmo6hkbmKcBcPgpgaOYgo62EgNJD8EqRP/6uV0loCfpmkyCK Bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmwkchj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:04:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ATItaa3151370;
        Mon, 29 Nov 2021 19:04:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by aserp3030.oracle.com with ESMTP id 3ckaqdagjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:04:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jl4qKkjlh0wpGTU6msZUxp0gmbMaDtjKp9qaFGCgj8iTJ57uHUeB0FyP2Pvjj71UuTI9OcO/f49dAF1QzpWFSXjt3DaIc0r5/v9O+JP1Msoi49D6pM7aRXZJn76jumGKL/Yb2q2ZJrWfS994qVU31Ik1TDbwhz146CYIVJDWcSo3ydShC599xiz86R6aE7wFqDns6yuI+O8UPpwW64dzkBdl4XCq70dEKf8rLSwDOTp0DnWr9e4dioSnerkHyN+Pr574zYF6nxHCOxGGsUrIk+S2sjA+/4ZwE90axxeUXspAnNKTCdXdMiz+3RRMVbfSJ3v76kUYkXimVaft74w2Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0G0DCJp8a7ZH0RcJfhkH3dBA27GCotCzxu0gS7GbLK8=;
 b=MP59Ib56f2om68Mvxk1X8/1C1fqMIL65hncgDU63btUxX2uX0lnCCniirrqOKdg3NCjQOmtKkUf6oovN67LAlJrm7NH9Yl+5hpqU5QcN+UstF902ur6xt19Va4npqp3V/GcegT4Ce4nxpAlp02fYGRoNVjigDn1yZP1s/Av6tICRzXD6qdnkKtp0NL1BERBUJIW+Z0Vrezbq3vyHGn21rFA2ViInoicZM35Uv76eu+cJF8s+NaFdc4iUupFGtZwbFW9Rncq/gf0sOUgzrYC7HjPIbxP4tSXNv4gcJmpDg2hVvK2HYUuGTKxvfU5OBKl8kbx4az4W0VBBc1aC+d9F6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0G0DCJp8a7ZH0RcJfhkH3dBA27GCotCzxu0gS7GbLK8=;
 b=v8S3Au8kTl2zAOnYGlaA6RaXa7Z0h6HwIxOKWEWIj7D76TZWvxB3QjoeOnmEw6FHtyAO+x4xoOdV3BdKJQW5UU8vZW82RGbNsSle2cJBxw+JzsxQBNNy1TA/BviSjbwju65jQHJRAiNWsFZ5vV00uPtjd4XrfViED70V/tDskuo=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2568.namprd10.prod.outlook.com (2603:10b6:a02:b1::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.19; Mon, 29 Nov
 2021 19:04:02 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f%8]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 19:03:57 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Topic: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Index: AQHXtMzhlpWZW1OG5ESdBSdOgoHETqu+oymAgAANi4CASGLiAIAA/bOAgAA+8oCAAD8yAIAALy8AgAZzIgCAC+1zAIAABPIAgAARGgCAAAipAA==
Date:   Mon, 29 Nov 2021 19:03:12 +0000
Message-ID: <1285F7E2-5D5F-4971-9195-BA664CAFF65F@oracle.com>
References: <20210929005641.60861-1-dai.ngo@oracle.com>
 <20211001205327.GN959@fieldses.org>
 <a6c9ba13-43d7-4ea9-e05d-f454c2c9f4c2@oracle.com>
 <33c8ea5a-4187-a9fa-d507-a2dcec06416c@oracle.com>
 <20211117141433.GB24762@fieldses.org>
 <400143c8-c12a-6224-1b36-3e19f20a7ee4@oracle.com>
 <908ded64-6412-66d3-6ad5-429700610660@oracle.com>
 <20211118003454.GA29787@fieldses.org>
 <bef516d0-19cf-3f30-00cd-8359daeff6ab@oracle.com>
 <b7e3aee5-9496-7ede-ca88-34287876e2f4@oracle.com>
 <20211129173058.GD24258@fieldses.org>
 <da7394e0-26f6-b243-ce9a-d669e51c1a5e@oracle.com>
In-Reply-To: <da7394e0-26f6-b243-ce9a-d669e51c1a5e@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c53431a2-4063-465a-de5c-08d9b36afee4
x-ms-traffictypediagnostic: BYAPR10MB2568:
x-microsoft-antispam-prvs: <BYAPR10MB256840091851C3A4640BBD4093669@BYAPR10MB2568.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HGzy/6U4I4VLi0NGbYKcBmBazmVbRkP501TXs9CH0VFZvFpJ8ukO8eIb5XTC9rWBM5SpKXzsdO1/+TfYLbfl1E6xvBHobxcDwicgKTBNsLA46OSzkA801+RPM2u9Jk9N5mQi8QaIwh4eehBodD2uMJDERa/kuXku1COsRTEQbdSaqnTSqMynjmolJFFdvfPB2i3m22yTlJucMsaNcAefNet2RuYUKdZkJ81W6zXSpVqYAdTXwnS1oOJCn2fA6/pK+TkE2v6p+0lyzfgPezTtaMi9PJfTni2BuZ26GE6qCp+0oUL83Lwn46M3qpHWjnHmiFu5J0kwwXpkIbgejfVI25aQHLfscxuwPORcMyUV7oemosxmV66+oAz7Jg2gs2tuSszih6MO+ASWgjJcM9hD5JxE2XWnvxLIqxPIa+wU+ZQFlMKbCdrdTgOuKNkR29gjVgotMmAFE/NTU1HG3WUXXikUOy3IsfySx8UgSkm/Xk2ugpA7K65WlXsmVXACnIQV1FdsI3jdCDYsF22HmE3Ni990kvdq5IueubT3MxHdiXDU+fv1hztd+i5Bcl5msSAbeHel5U/7+pt8qh19UUN0SleFzDJ7vdD9aQdTtKJl9sIdo5vcEqsrSsmDpuymnMsmTqicHhFxkcAmfydlB+BhnSTpxQpXJPRC5RNLTAndbRyVpwqpxMsxIQjpWo4bS8H1gXKAqK9JLIsfMn7LKOhBjhTpBLCuRYwzwUdwBkGric/z4whMzIbTULhpzkM1zMd5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(4326008)(83380400001)(186003)(66556008)(26005)(2616005)(66476007)(66946007)(6636002)(64756008)(6512007)(38070700005)(71200400001)(6486002)(508600001)(86362001)(91956017)(54906003)(316002)(37006003)(8676002)(6506007)(66446008)(38100700002)(53546011)(122000001)(6666004)(6862004)(36756003)(76116006)(5660300002)(33656002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PMG4Yn+sJ9v9TLvbZK4m7/s4v5+cYgBqo6P1bmBgQwKyeQW1xu4rPhQk92Yz?=
 =?us-ascii?Q?QcwStdomrlPSMW+LYvqbryd7rMWZOzzVe7E+ARf1butSZGtc9VqJ8Nm56H8p?=
 =?us-ascii?Q?QwzZ+S5C8a9ahI6iOSxNs3jUrJCysPuj6Z3r0wBluWDwjIgd5gD8gxaiEMRB?=
 =?us-ascii?Q?E2CvRhU8hHTh8Wr9Sc41dr8cNb7DlU7Teo2ZV57RuZvnhr4qdIxc83cqxJum?=
 =?us-ascii?Q?eFYcgmWzmCfCuzX4WoEpJKdrZ+Ojzw0ezSbzi8APB+Ua8LJOCOX8ifytt+gs?=
 =?us-ascii?Q?M1iQCuN0sPrGWbRb4XGs48GKIwVSpKhOA2nZdXoYbOet8J+J7rvBy5JJEC+X?=
 =?us-ascii?Q?duYx0ssugrfkz8IZEEEFYLAuavAkTg1ynNA7awPTqZxqEfjZEb1hCDXTEOsn?=
 =?us-ascii?Q?n0BUYDZb1TXTXBCpUYhWJJTbmsxMVYf+0Iu9MunAi0NQa5vPBAWFWWvp5us3?=
 =?us-ascii?Q?xw1JbDyzF6Hhxz7zyRLU1PQtDaKV6fs55rNG+1XEK1pIMtz+obC5wp0CJVHc?=
 =?us-ascii?Q?ALncJVvWKe5uNFYsIu768uk+jfQof7lePVbW3fzliC/SGcojDotNoxaD3/3O?=
 =?us-ascii?Q?QVnC1lgqWP3SdzRm4dIcz4du/UIwrHpztA29u/HjMxrGsBHe9GIkDzEXF8qd?=
 =?us-ascii?Q?z150uO+dQIs1LZwlYdKBaPR0wJmI+IsWoG8FRZ2PYTvdAVRHxAnLKdrbQ6h+?=
 =?us-ascii?Q?LznpVbVgU+sCV4wL8anyNntknN6KTv9iVCSJiauvgTkEch4fgYT5PdNJnCr6?=
 =?us-ascii?Q?AD2M3cB+7to7rVJ+LOwccnsLIANug40NgCIjGG+UZeRozZeGAKLcHdrBuT5G?=
 =?us-ascii?Q?13EcD1T2Vcs6UkacW1t1VDsp+277bjXqKWUpBN6VKWyGP/rdme3mhzqBvFVn?=
 =?us-ascii?Q?wDzWMs3/CVL9eaqbHRglTV2GIqwtDzSIQSspK1lQc2rtg67cb75+cN0RiNiw?=
 =?us-ascii?Q?48xDcPYB/Veenz8apbsCgjFdH5ZFXPCQARCzNd4Bpnub2JwxAGQxmujRt/aa?=
 =?us-ascii?Q?uEPq55rJbMkiZKHwkoDKQuINtyltjqFYCTkhdQH5mg24OAobGsjcHeIN2+/f?=
 =?us-ascii?Q?5qMAzw++0vwQFVLkTXlmRKnoMof/ROLPF1f9O3fpRzF6M66XlHkGBj2haPwc?=
 =?us-ascii?Q?iwn5mJGkDA1YxcY9yiMzUnwq2gyvQzffOFBrorTm4dNFX/g+rAUxoD18dfDT?=
 =?us-ascii?Q?0HICoW7ORetnQM3SpfQflrfAPOFaxAbW+x3c6A8qADM+4uIh4XunB8iN1mDO?=
 =?us-ascii?Q?hJhXLM5N353QwT054HJLjxIeoo+wu++IeZnhOv5K3hcdlaPPFQrd+VyZaj2H?=
 =?us-ascii?Q?cKPrTvoEuAxN9sc04CESZvG1sVDZCvanx37wh5aFPv75uKrCVoPtHUIGxlYz?=
 =?us-ascii?Q?s9TGynPt5qaCRA5DC+kJzIWmkEQdB5zfbPXLvdJQLLKSp5O8Icn64uWu4r2M?=
 =?us-ascii?Q?7g+ecuYX1WZdCBHbUO6PN1IPrdKmKAH9OLjJLkbYURdiF57mpKi4vr5kwGbF?=
 =?us-ascii?Q?mZ/VpcJBfB2bGsYLnimuufHQ0v9yIfzpoTUmGmYNv5B4prSR/xtqu50DxViq?=
 =?us-ascii?Q?3F9zI6a46ZspjEpPWiujuLAvnreKRez0TIadKqhTmcstSrnqFI39no8DOzMu?=
 =?us-ascii?Q?fbt4jeJgXBWG+m8lYdK7fq8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1B3E6B639D8B524791373B79E4A0D10D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c53431a2-4063-465a-de5c-08d9b36afee4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 19:03:12.2253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2PO9MS/RoVq6RrpmWKajaQZM538Qaj4TP66+sj02k0CvQSVqIiCQjl2MS/M7y7asyWWEQtVCf/fEjOvHm9IbwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2568
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290088
X-Proofpoint-ORIG-GUID: F4_w6GhFc-tfNNuGTE7TKLhqJ0-HlAR0
X-Proofpoint-GUID: F4_w6GhFc-tfNNuGTE7TKLhqJ0-HlAR0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Dai!


> On Nov 29, 2021, at 1:32 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 11/29/21 9:30 AM, J. Bruce Fields wrote:
>> On Mon, Nov 29, 2021 at 09:13:16AM -0800, dai.ngo@oracle.com wrote:
>>> Hi Bruce,
>>>=20
>>> On 11/21/21 7:04 PM, dai.ngo@oracle.com wrote:
>>>> On 11/17/21 4:34 PM, J. Bruce Fields wrote:
>>>>> On Wed, Nov 17, 2021 at 01:46:02PM -0800, dai.ngo@oracle.com wrote:
>>>>>> On 11/17/21 9:59 AM, dai.ngo@oracle.com wrote:
>>>>>>> On 11/17/21 6:14 AM, J. Bruce Fields wrote:
>>>>>>>> On Tue, Nov 16, 2021 at 03:06:32PM -0800, dai.ngo@oracle.com wrote=
:
>>>>>>>>> Just a reminder that this patch is still waiting for your review.
>>>>>>>> Yeah, I was procrastinating and hoping yo'ud figure out the pynfs
>>>>>>>> failure for me....
>>>>>>> Last time I ran 4.0 OPEN18 test by itself and it passed. I will run
>>>>>>> all OPEN tests together with 5.15-rc7 to see if the problem you've
>>>>>>> seen still there.
>>>>>> I ran all tests in nfsv4.1 and nfsv4.0 with courteous and non-courte=
ous
>>>>>> 5.15-rc7 server.
>>>>>>=20
>>>>>> Nfs4.1 results are the same for both courteous and
>>>>>> non-courteous server:
>>>>>>> Of those: 0 Skipped, 0 Failed, 0 Warned, 169 Passed
>>>>>> Results of nfs4.0 with non-courteous server:
>>>>>>> Of those: 8 Skipped, 1 Failed, 0 Warned, 577 Passed
>>>>>> test failed: LOCK24
>>>>>>=20
>>>>>> Results of nfs4.0 with courteous server:
>>>>>>> Of those: 8 Skipped, 3 Failed, 0 Warned, 575 Passed
>>>>>> tests failed: LOCK24, OPEN18, OPEN30
>>>>>>=20
>>>>>> OPEN18 and OPEN30 test pass if each is run by itself.
>>>>> Could well be a bug in the tests, I don't know.
>>>> The reason OPEN18 failed was because the test timed out waiting for
>>>> the reply of an OPEN call. The RPC connection used for the test was
>>>> configured with 15 secs timeout. Note that OPEN18 only fails when
>>>> the tests were run with 'all' option, this test passes if it's run
>>>> by itself.
>>>>=20
>>>> With courteous server, by the time OPEN18 runs, there are about 1026
>>>> courtesy 4.0 clients on the server and all of these clients have opene=
d
>>>> the same file X with WRITE access. These clients were created by the
>>>> previous tests. After each test completed, since 4.0 does not have
>>>> session, the client states are not cleaned up immediately on the
>>>> server and are allowed to become courtesy clients.
>>>>=20
>>>> When OPEN18 runs (about 20 minutes after the 1st test started), it
>>>> sends OPEN of file X with OPEN4_SHARE_DENY_WRITE which causes the
>>>> server to check for conflicts with courtesy clients. The loop that
>>>> checks 1026 courtesy clients for share/access conflict took less
>>>> than 1 sec. But it took about 55 secs, on my VM, for the server
>>>> to expire all 1026 courtesy clients.
>>>>=20
>>>> I modified pynfs to configure the 4.0 RPC connection with 60 seconds
>>>> timeout and OPEN18 now consistently passed. The 4.0 test results are
>>>> now the same for courteous and non-courteous server:
>>>>=20
>>>> 8 Skipped, 1 Failed, 0 Warned, 577 Passed
>>>>=20
>>>> Note that 4.1 tests do not suffer this timeout problem because the
>>>> 4.1 clients and sessions are destroyed after each test completes.
>>> Do you want me to send the patch to increase the timeout for pynfs?
>>> or is there any other things you think we should do?
>> I don't know.
>>=20
>> 55 seconds to clean up 1026 clients is about 50ms per client, which is
>> pretty slow.  I wonder why.  I guess it's probably updating the stable
>> storage information.  Is /var/lib/nfs/ on your server backed by a hard
>> drive or an SSD or something else?
>=20
> My server is a virtualbox VM that has 1 CPU, 4GB RAM and 64GB of hard
> disk. I think a production system that supports this many clients should
> have faster CPUs, faster storage.
>=20
>>=20
>> I wonder if that's an argument for limiting the number of courtesy
>> clients.
>=20
> I think we might want to treat 4.0 clients a bit different from 4.1
> clients. With 4.0, every client will become a courtesy client after
> the client is done with the export and unmounts it.

It should be safe for a server to purge a client's lease immediately
if there is no open or lock state associated with it.

When an NFSv4.0 client unmounts, all files should be closed at that
point, so the server can wait for the lease to expire and purge it
normally. Or am I missing something?


> Since there is
> no destroy session/client with 4.0, the courteous server allows the
> client to be around and becomes a courtesy client. So after awhile,
> even with normal usage, there will be lots 4.0 courtesy clients
> hanging around and these clients won't be destroyed until 24hrs
> later, or until they cause conflicts with other clients.
>=20
> We can reduce the courtesy_client_expiry time for 4.0 clients from
> 24hrs to 15/20 mins, enough for most network partition to heal?,
> or limit the number of 4.0 courtesy clients. Or don't support 4.0
> clients at all which is my preference since I think in general users
> should skip 4.0 and use 4.1 instead.
>=20
> -Dai

--
Chuck Lever



