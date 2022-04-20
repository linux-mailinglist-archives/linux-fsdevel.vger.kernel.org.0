Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C1850907E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 21:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381792AbiDTTeC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 15:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381787AbiDTTeA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:34:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269554506B;
        Wed, 20 Apr 2022 12:31:13 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KJBhoY009605;
        Wed, 20 Apr 2022 19:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=enj4+Ffh9AU2KTH5P5HcY+NFCo8XiXcJxofkMd1el2c=;
 b=l0yMFCysNSKRugwpWl29Lj77AiKjZbq1kC94sB3IQ7f0eR0OvSkf0VD+0Kq4xrG/GPOv
 7mpgoLoGjstR4VnSezRRdKJjq1F9EKM5Wl3Ry9ULX4/2L3uELoYVI5leYgO/RoWm7e+Q
 DIJz8CEY6O31sl9ZkT5h6639oFdWhFesqrNbHMKDbL5kX+2FVRVrfBB57cJtj/lj+wkz
 ss3s9Df62aXbrH5YKinAy1hNjXXOaJvK22Fet0wf+30reg1CvAfsucS4SZX6/iu9jPX9
 eWDT6Voj/Ajo6cXK2HgvygKMMVQmERs1aXv53SkdATYDGgMcd+AZE6gXRn/Vx6sRqYAa 1Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmk2t4av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 19:31:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23KJGgGk001109;
        Wed, 20 Apr 2022 19:31:10 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2175.outbound.protection.outlook.com [104.47.73.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm8858ep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 19:31:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlO67T4mO5TxFgwxWC80zY+T5UiJ5PUYR+0QF9vfkiIREEgo7ApGclyePznmM9JiLTP485Zw3iPgaPUhql8uXta7YWqP0Czlh1lY6BCHLwZrXa9ervsAuLXCGA2AYdp6KqyLQ7cYyAFYBzUGWQRnJuk0wLSyTyC1OxmQkRGK7IuTvG4gkak8BlYst7fV/47evTt9vTZ9q9vBoEtCqO8kfigJAu9Td2ZsTsWbcQV8Hitk1Nxgeo8AMa0a/3G/L1wHi+3H5zZdkz9/LOW1+p7h9LVzBkpUihYGJ4ApN0sOP7HCvtC3Wem8G9KzCKP3Bx3BiFfaVjouTHrrx0Q7TU7bxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enj4+Ffh9AU2KTH5P5HcY+NFCo8XiXcJxofkMd1el2c=;
 b=BRH+xlRt8AiTlgRANoFJUj1bTZv9K9GVZLhFRM3GDkAzC7L/lPUswwXC9IY5P6B6//gFzx2LTnLMEooq/sWFO5TZ9bD0KyP1ir68MdWyK8rBWRtf4i5qYBLObxqq8uNP6UkRPnY5QlI2EFVWzAZltfSc6HgtT03uM6b/IfVPsuh9hNw6Q0SQyBVb92WetCrMtrEHkKZ41qV1ubtpr1bUJj7jx3CA7ewugWddv7dW3QcNSnbKGyEMhuPcMDqLfJG0WSbPsxVy/ErECnjmFudbaYGHSMzRx1iV/phPAvsOF9YAE1QUgobjr7+0EZWU6DeVttErrC/Seo4RLDq4CFe9Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enj4+Ffh9AU2KTH5P5HcY+NFCo8XiXcJxofkMd1el2c=;
 b=XB5+mdM27yvzFw3pTjSzIAQqXojhPwZQOqVY1QG6/gKdvE5FYohCVweRr11HvdyvehqA1qxgMdYVETDnQGic/fDCUA7W/rz8M4C74ac6In3MwowovyREYDbMVEd6ZSHiMHziXlNVAuMz6luUvCW3inQzQDaIOs5grociITbu7jk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5271.namprd10.prod.outlook.com (2603:10b6:408:12d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 19:31:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%7]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 19:31:09 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC 4/8] NFSD: Refactor NFSv3 CREATE
Thread-Topic: [PATCH RFC 4/8] NFSD: Refactor NFSv3 CREATE
Thread-Index: AQHYVOTG+zUxidLhnk2/5Z2owSaWoqz5Kt4AgAAFtgA=
Date:   Wed, 20 Apr 2022 19:31:09 +0000
Message-ID: <D7DC153B-F946-46EA-9A02-B29B0FE6EDC4@oracle.com>
References: <165047903719.1829.18357114060053600197.stgit@manet.1015granger.net>
 <165047934027.1829.4170855794285748158.stgit@manet.1015granger.net>
 <20220420191042.GA27805@fieldses.org>
In-Reply-To: <20220420191042.GA27805@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30420bea-ed05-4cc4-1120-08da23045227
x-ms-traffictypediagnostic: BN0PR10MB5271:EE_
x-microsoft-antispam-prvs: <BN0PR10MB5271AA1F6580E3F70A2DEECB93F59@BN0PR10MB5271.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DSMPFaQ7cDDFpR5oTjrTMQ8lGGkngYtTTTP6n3wp9m24MvM1jxZxO5rWQPSPt+Wo1VarwQ58vxuV4ji7Uci3RGfU/mLd2KjPbkVXE9apYU5bUEGIqnQFupPHl8WtfpAiLECtSmlAsl90g3o0r1FhDzz1QNbwyXSWa9wXddtM81iEyi8dTJNUo5JxK0Dp6vi3/0aO4qku8BLBpNS29nflzvd6ji0gjiuCoQbskVe8r69Ey8cyPsYhXjq3/Wu4BwRZ5LEHto4Hefv7PFpB+cJfB8PX15xxvie/HQky4e1jgNWb2NOPbDcvZazuQTY574L053piIXmbctti2PKTUMorD+tFIOLdncoj6o5RljL1natF+BbbQBEKD21tjuoZym5ZMdJb/wjUXl+8h147fHPF39ZbcvxLVBh1D0bDR5YYWXSaWi4eVqMYrSSCp17PDOniC4M6SelJqO5aB80wyM3x0ZHlGPxJ4lNKw9TozTQ92DrY0Sj5vPbfR0xU9aiZ67K6Fx3bfhs7npJ1vbRbSl3kGj0p84Ygtlf/xtv++G4haYQia0Acnn9P1O74kIxTVpwURU/nRMV9Ns0rPQ7UtQ8+5PNukdJQxlsHacoA2EFAZer15VEWfwWKJGW+sIJh5tyxC3Fxd49PftzzkqIxq3NCdApM8p59AWZMWWpAu9o0q0Tbx0RV5CEyEB7iIhMVYQo7/sMIrWxStUHf/zbCCUFXDmIJd5hgyl85yNynC1czbuUSRZr3MMNAZY7Uu+HE8xuq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(76116006)(2616005)(186003)(53546011)(6486002)(508600001)(66946007)(316002)(83380400001)(33656002)(36756003)(6916009)(5660300002)(4326008)(66556008)(66476007)(66446008)(64756008)(8676002)(8936002)(91956017)(86362001)(2906002)(6506007)(26005)(54906003)(6512007)(122000001)(38100700002)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hjo427KI2NDg73D/8Qav/5q7EQB6wYf1uB2gCF693DGV6DpkYYCWA4GukpsH?=
 =?us-ascii?Q?NpSCmSBbGF+oG1e0QxvEFRl4ZWVt+eUA8UABZUdqGf/VKAlSpUMqiKljHNNX?=
 =?us-ascii?Q?R6MDLgRD2/+AC45mNjbEsBoJcBRUQpemIOxBV0cZX4q4SRdqw27Hu78h+bz0?=
 =?us-ascii?Q?uInlCesGuItE4WrEZ9Gal+TZ2ZaIm+kOGnGydxt4hsp7tHHB14c7AIQ4l8l7?=
 =?us-ascii?Q?0n3Yh1p++/BePMryBLFoHANXy8N0+LCk1KgyAo8KTnKE+zpK8qS4U0c7NTeD?=
 =?us-ascii?Q?BO65NI+cq7S2JJbqzM7n/0o1a6hGaGwOkW3m/SnRKWyspj13Agnk6vc85L+z?=
 =?us-ascii?Q?ESIczvRJ12SJd7INcw/2Og3g31nKegocUFyDi55GQi8BJyVAt4PbqQM/os85?=
 =?us-ascii?Q?5AMY9ApGF7tFxPaJsQhmNu1EPq0W8RvfoOMLlsrGAGhv5vTay73RWCU9/v5w?=
 =?us-ascii?Q?HJisDTghAssfh0Fy4azflLq/k8rI7gDBFC3O/WXFCUKJem8SXfYop1nSy1TK?=
 =?us-ascii?Q?6ux+Ew1Rmngc+g6uM5CyIy5Hzvo84jIaH8mfdBrEwzMXWglKZHAuABHhM9Wt?=
 =?us-ascii?Q?QMrv9EdEdBHOFV0dH5frhZDO1DtAv+QqB0o/gVWTKbtqKCyKKgOkn7iyp6JR?=
 =?us-ascii?Q?/my+ISDBuJIcyiQRxdU+d0oYP8WWhE7rYF5H+UuSV56RkSaSESGVj2shwqNC?=
 =?us-ascii?Q?Q7FmSMNTjqvmifQrHt/X7Gobt407TuvI2At5Xo16Z58JWXAYOvgkv5yCNndE?=
 =?us-ascii?Q?MUT5QduSVM6Rky85U3kfVItIVQ/yL5rtkL3HREQhEqCPprbrLSJk568xDg3v?=
 =?us-ascii?Q?h1YLAaCeAHyVjGdVhgm91s9i+b2gO2fQFp6IXkIGYJ24KdjprhfTHo4AnvtP?=
 =?us-ascii?Q?J+5bDtwqf/V+lUQNuKomO3AZGQWxow2DRl6BMGvGGmQC5uLW+CeDzM8GwHuX?=
 =?us-ascii?Q?rGnz0/Fh23v4tetXb2XG+kxuanYSj17/X7GzaYwmEpha4IMPKX3iJvHk6YBv?=
 =?us-ascii?Q?7TTR37i61wfmq0/T9koIE6jdjlzic01jMGtwnqCaZcnyYnovF8qEvQfWHM8U?=
 =?us-ascii?Q?3NAuBdnz2gUWC4fjedua0GDsuVkRoCPOtr6HWx/Aftg1h2EunGCXKejNAtOO?=
 =?us-ascii?Q?eEPGEN4zqDVDtUbMlPdgPQZtSPSZrGTWxOZitpHxClwOFNLAT7k0oGXrHXy1?=
 =?us-ascii?Q?8t7qxQPigvU+ED2A9qSgdYSNW81dk1RhUdRfBeHOwESxSQdx8eNnfBOVx2Cn?=
 =?us-ascii?Q?66MgakpR/ibthlzrhOz004SuffijUjtE0uxPhblt+eWt9j+psV2fPP4k2Pd1?=
 =?us-ascii?Q?DJENaRYru18xKlHPUJ5cQ8iyTv7yT9O5ywyWZUDFkVHkSdK9QW92NbhEl2oZ?=
 =?us-ascii?Q?mtmxOkdCyri5PZaxoAQr2pC28VUEyzwAfuKdKm3gwQ4gNdka9MEq3FpCElrN?=
 =?us-ascii?Q?dkPD8itFRsaF+2VV+Rbhl79qMutuPWMOc8uP6jJs2lSYr9DWIz4huwoKrZsV?=
 =?us-ascii?Q?5Q8JRc5yVrAqSUkR8mdxIkrJlNiB3L4TfVS4kRDAYbJBvNRQ2GZso8kfMOLK?=
 =?us-ascii?Q?0sz0bRD1h2GZhFIgGiPcb/e1RKzcOpB3YGqXezAXlv5jQauNf2DvIbO2a6oP?=
 =?us-ascii?Q?1yZ+lp1dSgI5Dt04PcMB4++HJR9pHPd2U4G8ZW3S+oMmbxpg/5jI9mborwGy?=
 =?us-ascii?Q?kwo1D+4JZJHbtZmIuLFQnAIwJiahuRZOffcwKHkDvPBw9Ax2Aud1qW/ajM3z?=
 =?us-ascii?Q?Vd3uZS0tLYuiOKYYrLTOYlgqvJLHpKI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C982321B42CC0A4BAB86D884BCEBB7A8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30420bea-ed05-4cc4-1120-08da23045227
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 19:31:09.0542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODBIKvreHQ6YBVKhWR7/ocF57Z96tWILATiw/9Wfy1GsjGPvf/BAnUE2pf136S7wFmxa6B8mJ/YR0YL5u9rDzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5271
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-20_05:2022-04-20,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=738 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200114
X-Proofpoint-GUID: vETdIr9fwUiVHI12g_7mIerpSLhv9-vS
X-Proofpoint-ORIG-GUID: vETdIr9fwUiVHI12g_7mIerpSLhv9-vS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Apr 20, 2022, at 3:10 PM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> On Wed, Apr 20, 2022 at 02:29:00PM -0400, Chuck Lever wrote:
>> The NFSv3 CREATE and NFSv4 OPEN(CREATE) use cases are about to
>> diverge such that it makes sense to split do_nfsd_create() into one
>> version for NFSv3 and one for NFSv4.
>>=20
>> As a first step, copy do_nfsd_create() to nfs3proc.c and remove
>> NFSv4-specific logic.
>>=20
>> One immediate legibility benefit is that the logic for handling
>> NFSv3 createhow is now quite straightforward. NFSv4 createhow
>> has some subtleties that IMO do not belong in generic code.
>=20
> That makes sense to me, though just eyeballing the two resulting
> functions, you end up with a *lot* of duplication.

About 200 lines. I would feel a little more agreeable to
this if we didn't already have a separate "create" function
for NFSv2 (ie, nfsd_proc_create).


> I wonder if it'd be
> possible to keep the two paths free of complications from each other
> while sharing more code, e.g. if there are logical blocks of code that
> could now be pulled out into common helpers.

I'm open to suggestions, but after the final patch in this
series, I don't see much else that is meaningful that can be
re-used by both. nfsd_create_setattr() was the one area that
seemed both common and heavyweight. The other areas are just
lightweight sanity checks.

And honestly, in this case, I don't think these code paths
are well-served by aggressive code de-duplication. The code
in each case is more readable and less brittle this way. The
NFSv4 code path now has some comments that mark the subtle
differences with NFSv3 exclusive create, and now you can't
break NFSv3 CREATE by making a change to NFSv4 OPEN, which
is far more complex.


--
Chuck Lever



