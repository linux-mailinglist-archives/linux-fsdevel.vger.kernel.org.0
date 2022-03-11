Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623824D56CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 01:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbiCKAiM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 19:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345136AbiCKAiG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 19:38:06 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E446519E013
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 16:37:03 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22AMxOsr005988;
        Fri, 11 Mar 2022 00:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=R5agXBvWq8AscHp8Ey4Kci6k68Y1onQfGNqIqdkaRKQ=;
 b=IQhKC9ZE/ClH8cEPIzZW6788ngB8kXI2K6Ij2kstoonZCemwYRCfswuOIb2biErCMXO+
 04cEihYsX1209ga6N2fhuExQ1O8yTWipElL/EUSahJiWMha2I+QO0klfO21CuHoABkdx
 oMyVGvhMJKi+06EbL3DM4cgsxsFCNSxqrvhOIHN5B7aq4i+WGzmS+cgX5ATjuvs+Fv29
 b+vfU6mOlsCtIX9Hc0ptKWfcJ68qDjyNP52OT1ypFqyF5lyY26IB1vu0qeTpF90rZN+L
 faJP6ouRbjKz4eUEda10yMzJrFWYDu/bRlq7W5OP6OoVDc/WYkH/t5TrdTT75XnmQwYZ 2A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekyrax8gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 00:36:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22B0VKM8096023;
        Fri, 11 Mar 2022 00:36:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by aserp3020.oracle.com with ESMTP id 3ekyp3wae2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 00:36:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhqosiUvZc0uIjoRbFJNW3kyoZt1siuS2VSG+qrXNo2tUUQjAM6ZpATYc4TLZHcWApvxCGlAu4mVG2Niy1emcEnzgh+V5savorIzdrHNttXO0a2kfA8qYtbAYY/199LcIxS3LELv20GkhHt70OX1hlta6J9ovzy8cyE2/OVTICn2xRiYKuAENlBfFUTFWfgBx/h0zxU6gx/9ElcYgI2bPOtSGyrGZUm3yhqHA5VAcjXkvCFLqhXKDXoJOPYJQKmzgohX0O2ljrWuqWEOIM+VwIyQKn7P9y3k4ZgmifCzrOYjhs/ZLYhkhMNQidIXoSW50h6pIHCEtTQKYF7JMNJ3kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5agXBvWq8AscHp8Ey4Kci6k68Y1onQfGNqIqdkaRKQ=;
 b=MsGYlkL85DLxo7P7rbuxc7A/h2G6fYZ0PP0xbis1ILx70GJDPh0kK3A+6bRGlAz2o6IEtsrCBlU6xc/j7T8/SOlcPdAQqS9exZDAARg/3yCFTLAeYMbs1bHQ/akimcCp2y8UYV16e9l+w4oWRoJK2017V/eWAxlJWbhMapk/iPygcVyl3H+99wl2Mjd0EPoXZRnHai8N/j1sepw82FXLoJIPh9ATz5387TR+Ez9OAOwuC7YWfZ7kqpffLMBv66FhgyJRlvhrhaEYtloCjP9y0ndThOrPNfGtchheIwvzyhO83PA7RV98KaZ2pNwlHzE2SK/EFeukXrunFYHvyVtngg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5agXBvWq8AscHp8Ey4Kci6k68Y1onQfGNqIqdkaRKQ=;
 b=pK4flBoZzvMgIV9GPqtFnGnTvGm/EynDA8jcm/QVaA/10qjPmBIBaO7SvtxEInFDDzjKoJ0fsvnpuamfuHRTaYB+DGb97ZucTG+OYq3bx0ljuXxRF/5+OPxtWke6/DvdR3ryO6DwqIyvSwcPuivsxurJMl3dZ+feE3SyvKWgZtU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5483.namprd10.prod.outlook.com (2603:10b6:510:ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Fri, 11 Mar
 2022 00:36:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%8]) with mapi id 15.20.5038.027; Fri, 11 Mar 2022
 00:36:23 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steve French <smfrench@gmail.com>
CC:     Sasha Levin <sashal@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        Darrick Wong <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Thread-Topic: [LSF/MM TOPIC] FS, MM, and stable trees
Thread-Index: AQHYMs+Cfd++gwnpWUGV8XDa4ELjV6y1Q2IAgAAPcoCAAIbpgIADdmAAgAAKVAA=
Date:   Fri, 11 Mar 2022 00:36:23 +0000
Message-ID: <1669255B-007F-4304-9C2F-F0DF6C3E207D@oracle.com>
References: <20190212170012.GF69686@sasha-vm>
 <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
 <YicrMCidylefTC3n@kroah.com>
 <CAOQ4uxjjdFgdMxEOq7aW-nLZFf-S99CC93Ycg1CcMUBiRAYTQQ@mail.gmail.com>
 <YiepUS/bDKTNA5El@sashalap>
 <CAH2r5msh55UBczN=DZHx15f7hHrnOpdMUj+jFunR5E4S3sy=wQ@mail.gmail.com>
In-Reply-To: <CAH2r5msh55UBczN=DZHx15f7hHrnOpdMUj+jFunR5E4S3sy=wQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bc95200-3a77-46b4-c3b1-08da02f72b6b
x-ms-traffictypediagnostic: PH0PR10MB5483:EE_
x-microsoft-antispam-prvs: <PH0PR10MB548333A5BC21A5ABEA779BBD930C9@PH0PR10MB5483.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LFuzLFy2yMOLOqt3Lkd3zJ5JYPotThy448HBPa/t3Ff47MgQrMXMjYbWkvQgwhNf3Vfw4t2gIFzKY7u2rIWfsQdKfGet7MY/gPCPTdYx8h3czmzlpP7FYX4tOpx4t5S664uOXLc4oWTGr85zLS8+v9CFZKUrjSqevf2Q3mCoOWJUw6sTlWT8l7mXHte/hwABAgHDJ052dFhZcNbzkHDetmsIOrfD0fEn5NNQnJ2w+NsGMX6UgyuIQd0QMieKMMMuzoiLPTh0FDrSeRT0dT4GOZXZVXqyTdo3g5UVJlaGgSyg7NIiIqxY3qmkdoceeKSmH/O2XJVE2N7Fh1esv9vsJwvUxtJcOm26fyScc43ruE15WatPE7CXh9d02inKUnH9zz2jhMZsHeUMF/UhETJ5yXU7FjH4qhT73WyMLUaZ00pBMdvdciYV2ee6OuKPy8kVjHnLA8KUGKrDGF354XFq60dxsAtVrC9A7vzwTbi/Y7+n+cptBdENakw9SmQkAewHYRm3P/g5DoPa7IS+lA5tHIAblc4DtPPLdSnTFqm4MGd9rLSdLBKStWn3b8JEvAnJVnS02aU8DdazuMZ65SsdYIi44NSrO+9ZW6GeYGMCYfL7VxRBpldWvzw/MNHeE5n5kkdPvEanvfR1nC4fT3DEl6lOtCEFzxMqPOY4oKvrJn8qkcrIF6j3OuI4GDIZydYx+wxn9//dll2Bgxe0Xrui7YyYsrrZ5f0BZKg4vBXR7z1IVI/zRiEcX/KULAc1BKvf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(91956017)(83380400001)(6486002)(33656002)(2616005)(186003)(7416002)(26005)(66946007)(508600001)(8936002)(66446008)(8676002)(66556008)(64756008)(76116006)(4326008)(66476007)(86362001)(71200400001)(2906002)(5660300002)(38100700002)(122000001)(38070700005)(6916009)(54906003)(36756003)(53546011)(316002)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cMfUSUi4eAKBg33MAJY9prn8//Xdqd6demoVt6qHNAGpntiqicDx6z3NlQbB?=
 =?us-ascii?Q?UXrkAnXjEICgPtL03IPX3S9Tiy1RWmUrJ3LsrNH+K7COoEfca5RJprDgyV1N?=
 =?us-ascii?Q?SWcZR607LPXMsAJnMGlWKOy8pgs0n6pEa/Njy7gJ5E0rPfxm0KYIqucza+IG?=
 =?us-ascii?Q?hLkv64N3XuD8ULIl9cYquawAqt5bGgX1iqiF+nWC8XuYuSozB9s9To2l030B?=
 =?us-ascii?Q?nSz3ryYpqciiLXVRlSbD8XnETed07b7bHU4qqKzQeBDs9fdsTNnVHjEablmi?=
 =?us-ascii?Q?9Vo/4kKPOozKawmMWbi7l96fllXuEkcltj63gBOykxWi5I/VLgK1LMDvSh5O?=
 =?us-ascii?Q?5XAfwgP2PuzCWMLaReR9hg0QjZzxDh4xPm3SlJLWt9VKcdQ8l58ljn/bmMP+?=
 =?us-ascii?Q?g2OTG2f9bUK9XV9DQpQSxoD234PwcHcR7hwd+nG+FiEafVjCiqEJoySk28DV?=
 =?us-ascii?Q?lPM9NQVyxyzRqHG75bIMkF72B8iIWKQHImdjed88Twq/xLscalHTCSMQFqhh?=
 =?us-ascii?Q?MMQ417wVxRiNE/pT1K3BnLzzfSu9+KhmvN0a0AersmpPy8NgamNiRw6k4m1I?=
 =?us-ascii?Q?w2QCfOVMpK17IGO2SeTrJrRmRFbkJX/Tb8ntJ9jJDrGFh7c3cGsfe/g4Dh5r?=
 =?us-ascii?Q?xmFoxGHaH0iRCSWYAVdkdgfjcDJeFmK5tpKQmA8rW9Ff7lSex9gnJryK5QUR?=
 =?us-ascii?Q?VxU/mNaDpiEjjO10XJQ7X5okEWdfZbgViUj8pJ682Rm19e+Ak6it+dxWIczU?=
 =?us-ascii?Q?bFxkksLc6T05lC9NY+vrrzI5HK6cESb0fn5HALH2bCIe+m1qHI0vEsxZ5noP?=
 =?us-ascii?Q?0DkydkFgstN7VNNggUGKYWeryJjNpgidydK7qZRD0W4xevcf2Cnpje8zlTLG?=
 =?us-ascii?Q?T0/ImsMeUkb1zvYPCUStPc+9UpG1nP6sDXv/IRMNz5FAij9ChOPHN39nx7KT?=
 =?us-ascii?Q?ZipFgkrtri/PXyh/fXdjQfIeNTEtBykrRL3PUOEwekaR3GvD5+4UuA/sglJn?=
 =?us-ascii?Q?7sM0a4mq6IzLv9N34GXLEx4+bEhMMvrRJo+8KfknpBqrOHpvnCbNiLqfiW7W?=
 =?us-ascii?Q?c1lYIHZEQvXVyLodIT8la/IpF9qFgRCAEK1Vz6u0uV7yIOoEm2rkkpoDdh9M?=
 =?us-ascii?Q?h7dJzSIorH0jg9TBoCTsBA6dG95zG1CjMwH0FxnFjleLp+ofRZJJRMC4RhBH?=
 =?us-ascii?Q?R+ejCFRLni3oueJz61Ls7j3dzSRPg5zaHUdcZHtQpdg1z8ikk9rCaHqjTK/t?=
 =?us-ascii?Q?h/qQJGWxRbLaf8Uiiip1PY9sjRnpKhAZqobR4//cIm9+S5ZE9iRutymCHoMt?=
 =?us-ascii?Q?6VxDUNiFbnG9Ib2BQn5YLa57Jbe3OlnNaDERvcxFwzkMNVHTksN8yQ/MnX3p?=
 =?us-ascii?Q?VfmbPOLy9KwSWT0asJc3C+2TtiDVnjtLFNISAjFuj7fsOv7a403ZddcDunTk?=
 =?us-ascii?Q?MtUOk/XbbX9/tbSEUixMEfE0qZEEKooHKkt0chr5QdKgm54O906i7UE6OeGu?=
 =?us-ascii?Q?mZdi0uZgUXLqcHv92OHwQS7UrILfACnYIjL+9AUShD6wT83viLTqsuOAwpky?=
 =?us-ascii?Q?TVYeeUyvxTHyBG6tTJiY7aVUh9O7GZbDDzwGhqwzig/pxOyl0BKTMo+4ENkJ?=
 =?us-ascii?Q?HyCVlO/yFvs1wFrI+iFiBvw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4E3BBB44D7B0754DB03DA55A79BF8D0B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc95200-3a77-46b4-c3b1-08da02f72b6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 00:36:23.4213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zmM6mRyYUaA7j+T4aSbQYqmMlyHCoj3z47kRcx1c3JmqSfxm8QHOXRzM90umd9UE2zav6MnmKdrBWLTpo6ifGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5483
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10282 signatures=692556
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203110000
X-Proofpoint-GUID: fgSyQwVgK5ttBdqtEezmJlNy-LXZqfeU
X-Proofpoint-ORIG-GUID: fgSyQwVgK5ttBdqtEezmJlNy-LXZqfeU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Mar 10, 2022, at 6:59 PM, Steve French <smfrench@gmail.com> wrote:
>=20
> On Tue, Mar 8, 2022 at 6:16 PM Sasha Levin <sashal@kernel.org> wrote:
>>=20
>> On Tue, Mar 08, 2022 at 01:04:05PM +0200, Amir Goldstein wrote:
>>> On Tue, Mar 8, 2022 at 12:08 PM Greg KH <gregkh@linuxfoundation.org> wr=
ote:
>>>>=20
>>>> On Tue, Mar 08, 2022 at 11:32:43AM +0200, Amir Goldstein wrote:
>>>>> On Tue, Feb 12, 2019 at 7:31 PM Sasha Levin <sashal@kernel.org> wrote=
:
>>>>>>=20
>>>>>> Hi all,
>>>>>>=20
>>>>>> I'd like to propose a discussion about the workflow of the stable tr=
ees
>>>>>> when it comes to fs/ and mm/. In the past year we had some friction =
with
>>>>>> regards to the policies and the procedures around picking patches fo=
r
>>>>>> stable tree, and I feel it would be very useful to establish better =
flow
>>>>>> with the folks who might be attending LSF/MM.
>=20
> I would like to participate in this as well - it is very important
> that we improve
> test automation processes.  We run a series of tests, hosted with VMs in =
Azure
> (mostly xfstests but also the git fs regression tests and various ones
> that are fs specific
> for testing various scenarios like reconnect and various fs specific
> mount options)
> regularly (on every pull request sent upstream to mainline) for cifs.ko a=
nd
> also for the kernel server (ksmbd.ko) as well.
>=20
> This does leave a big gap for stable although Redhat and SuSE seem to
> run a similar set of regression tests so not much risk for the distros.
>=20
> In theory we could periodically run the cifs/smb3.1.1 automated tests
> against stable,
> perhaps every few weeks and send results somewhere if there was a process
> for this for the various fs - but the tests we run were pretty clearly li=
sted
> (and also in the wiki.samba.org) so may be easier ways to do this.  Tests=
 could
> be run locally on the same machine to ksmbd from cifs.ko (or to Samba if
> preferred) so nothing extra to setup.
>=20
> Would be worth discussing the best process for automating something like
> this - others may have figured out tricks that could help all fs in this
> xfstest automation

It deserves mention that network file systems like Steve's and mine
have a slightly heavier lift because two systems at a time are needed
to test with -- client and server. I've found that requires more
infrastructure around Jenkins or whatever framework you like to drive
testing. Having a discussion about that and comparing notes about how
this particular issue can be resolved would be of interest to me.


>>>>>> I feel that fs/ and mm/ are in very different places with regards to
>>>>>> which patches go in -stable, what tests are expected, and the timeli=
ne
>>>>>> of patches from the point they are proposed on a mailing list to the
>>>>>> point they are released in a stable tree. Therefore, I'd like to pro=
pose
>>>>>> two different sessions on this (one for fs/ and one for mm/), as a
>>>>>> common session might be less conductive to agreeing on a path forwar=
d as
>>>>>> the starting point for both subsystems are somewhat different.
>>>>>>=20
>>>>>> We can go through the existing processes, automation, and testing
>>>>>> mechanisms we employ when building stable trees, and see how we can
>>>>>> improve these to address the concerns of fs/ and mm/ folks.
>=20
>=20
>>>>> Hi Sasha,
>>>>>=20
>>>>> I think it would be interesting to have another discussion on the sta=
te of fs/
>>>>> in -stable and see if things have changed over the past couple of yea=
rs.
>=20
>=20
> --=20
> Thanks,
>=20
> Steve

--
Chuck Lever



