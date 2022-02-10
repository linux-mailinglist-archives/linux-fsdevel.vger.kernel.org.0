Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8594B15C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 20:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343614AbiBJTEQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 14:04:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343596AbiBJTEO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:04:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981F0101C;
        Thu, 10 Feb 2022 11:04:15 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21AITRYo027666;
        Thu, 10 Feb 2022 19:04:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=SJvUu/cYVH91kzZjGuERLznSFSiYXB5i5kYLb7UpDWA=;
 b=Vdo1yuLGeWvH1k0MXjeND868S+2RHgS+MFeAXRthZ6rlFBNNQm8ZJy3mLZcKFqXoNVMj
 lKQRTl++D0GdthqnfUu7TupSMT7rPN4va0x59GKywpC+xEP+uqyFHj5UAhFGxSH73cxx
 EsWmSXdryaqSxNaqtTNXTvyAOzqcUYJ4x0264wJgBuD2+ZGsKYcwG6ZZj+VR2j14SUPK
 6IY1dHRa0U7JyKMLiT4ALRzZNhKKd6/ZqLMoAq9CYSFsesw4sk1xRr+4o5JLRFX/++r5
 7Kw+fW5FRD1QdZ9am2+NfuK6KWT0tKYhasm4cGNkD2iHelmp0i/v2m/6s2K+JpAKf83J rQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3hdt1238-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 19:04:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21AIuCQU047544;
        Thu, 10 Feb 2022 19:04:12 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by aserp3030.oracle.com with ESMTP id 3e51rtuveu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 19:04:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipmTS8O+YQ3T8rBFsQB47U2/nAe02iCT30cxGNgzkpi2WPCgW4F7C2exgiO0w8rOsidkeOUvx7sHOz0zJ6un+xRjsGUuPt4kNdnWses0Rq0P6TgpRKNgAS5SO3MWhIQlI1XwQ5HbATuw5A4gQU3ORud8kS4URm2yxT7o5lY+AV3XtblEaoDv8Wb3havHJpKDfyRok6Hspbd/W6OLHB1qfSGHcNjZRmOwoOJqf9tTyEhH150qyC42081/ncKNtl6qrtN4gCBDnca5arGnrFo90AzfFNpg/mgqRJa92RIVBYWBlTwT2zoIv9wXfiWV11UcFCgHLHDFUfuJCGQH6YmBMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJvUu/cYVH91kzZjGuERLznSFSiYXB5i5kYLb7UpDWA=;
 b=Sw6TgFLOVRLJru//21tvIAsmzxPC5O1OVm5FDbCUETjyi7nbnQw28Fg0H6ORhjkzJ0L9EDYZGMJtYIWaZgTBdmPYk01heXN38TSCoyRcpkd+mtTOEkcdqXdAO789KUbGBIo3pUbz5eIBHp7W1QXuMDz2LbdtZh5AF20z0uoOTA0vE3awndvW0pDW2mJPzLJ6jWr9hM7spd0OywndbtZgYXnkjNBYRRl9o7fH9Fg4PE7SroVAQTJhVAuIANhg0T1JK55KY4b/qtBDvBuItUCTD1o8PUJ95+liP3yoyoNxzE3I3YsH5kFOo2iJ9nTRbuj0ztANKoH93ky4mClhfXVPnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJvUu/cYVH91kzZjGuERLznSFSiYXB5i5kYLb7UpDWA=;
 b=weJk1W2P2o4wWXZKJ67qQhaZfX6bUakWAnAGhw6bYraPe4kHfa6zMpOnghzVVbEYrrfYa01DiSlit0/bdydtW4Of6WxgFyTnRDVP7EE9Qdq4+YpNU3FiifQJgXn/RyeBbfG+1GJ4zPbZZKhBVopJcmNL4VHjFcBNJWfBWWciiCY=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by BYAPR10MB2598.namprd10.prod.outlook.com (2603:10b6:a02:b1::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Thu, 10 Feb
 2022 19:04:10 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d%3]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 19:04:10 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v12 3/3] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Topic: [PATCH RFC v12 3/3] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Index: AQHYHjn74pyZfV9hjE2Fdxx9lh+2gqyM5lKAgAAUwICAAAWVAIAAI5yAgAABQIA=
Date:   Thu, 10 Feb 2022 19:04:09 +0000
Message-ID: <B3812DDF-AC10-4FCA-9380-2E98F5FE773E@oracle.com>
References: <1644468729-30383-1-git-send-email-dai.ngo@oracle.com>
 <1644468729-30383-4-git-send-email-dai.ngo@oracle.com>
 <20220210151759.GE21434@fieldses.org> <20220210163215.GH21434@fieldses.org>
 <2223051F-B8F5-4E59-8A27-735F6A426785@oracle.com>
 <20220210185941.GA24538@fieldses.org>
In-Reply-To: <20220210185941.GA24538@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce86ffe9-853a-4a2e-e75d-08d9ecc81e91
x-ms-traffictypediagnostic: BYAPR10MB2598:EE_
x-microsoft-antispam-prvs: <BYAPR10MB2598CA78336879E9084DD64D932F9@BYAPR10MB2598.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Coh2jbJT+ngMpnbE05INnqj2fnLfVI/hbBNQn+kkCDq6XnbBsUKkoqQyQU86gK4DMEqrGBRbxxbo+xnLhOAeKIVBlt6uzcz1CYwpttY3k8fgmjPReFvpQMngJW8gn1s59fr7v1L9p6yyyE1hOaA19SpEtWX8RxX+tKqYQFvN+H2tmuwzRc5EbBC4v8tEAFt90zBXPqMG8cGdD6BOryQYTTuMKC0of5VTiYdNKjRvcAEtyFx8PP9dWMwei+u3AbBClweEIio6eOdTN9doAkF3xapID9eoYwOBAWARtjwc9j0M4zb4Am7kVB55/5c69r0SPqzLjxJ2TC9Sg3rTRvLiX2nG6GhaKhyxYbrtV4wR7e3a5vZXuoiz+NR9D7cm2gex7Hhcvlzbyqk7RnFgra37YCeS31C1BxhJ/z7xJNqe5+5d6RWQGDxdTYVs62p2YzrdCuznXce8G+y9XfBz3rF3NniOruE6vRxcNGzG+4g2gII7bMosS8MEnJwDwXBfJzZp8dBthfvOLASUXfSp89ryULb8o9fs0Vah0kz+l++sayg6/93v0u47HPRDLaQi0+SxYEibuYJtDiFBRD7Kriyd3RhbT4DMDCIRGZide2dRiblGYM1kuzRw/xbKrUNqsNLR/nu0afQupiLgAKnTesbpuL+iFr9QQEpWkzOY/9p5rcYGvtN1CyfVPRJHox2owrZ6Xdn3BNpPS+wmMrwFqMxrGaX9djR8EaUs9+965HS7IVQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(71200400001)(5660300002)(6486002)(508600001)(122000001)(33656002)(53546011)(86362001)(54906003)(6506007)(6512007)(8936002)(38070700005)(8676002)(2906002)(66946007)(76116006)(66476007)(83380400001)(316002)(38100700002)(2616005)(36756003)(66446008)(66556008)(64756008)(26005)(186003)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vt+UqnO/Z7AFcA31uK/HT4z43UX2xITqtM0sniii+crehoh9MU50dwvWESft?=
 =?us-ascii?Q?GMXxjFvE3rjmQ+IFqwgWdSi4GSGaFDt1tym5RDyDe4IJV/bG09rNFtrgcpRr?=
 =?us-ascii?Q?jg5yiOm8KTagZXa6pUzUsuwijx+tbPEpnB1IvQm4eAszPV5N5B2Ct6SL40pZ?=
 =?us-ascii?Q?C7dgjztj7WSLZlva9WoZZdQBZMswf25vof2JeLGK2LdWUc2wqWprLO6Dv0R3?=
 =?us-ascii?Q?Sxyi1Z/0AeoxYxWQ27tCZeqA6jYksywsfEUW/opPDLnVHYjOgI3fiZ/2oaFn?=
 =?us-ascii?Q?BmXoiewatOZbAII8pNrnKyGmhIRSlXliOp3xCoLvktaPa+NPlqQ8XwN5urZf?=
 =?us-ascii?Q?c5jzix5a1BrAfszqY6Aktib7FnFofTb4CamD3zEU4ao5nNeFNkF8T3aCb8PB?=
 =?us-ascii?Q?zXtZMj4eUiaL8I+DtfhD5ypBC/aX2i427aqLTXrLn7iQMHUrcG/dNw9WVDmY?=
 =?us-ascii?Q?PQBLxtEbuhb+AhAjvfipHdXUMYTXrMDMbmE7E+5IV6CNA2yNgtOSBgYCZNEP?=
 =?us-ascii?Q?sf9BvvUEYYAJY8MJeV7ikstBZ2kyFeKsOBhUhfCavY2db+BCHbEVFqKKDicl?=
 =?us-ascii?Q?uXfa8N489OdbbXUANqAwRcgxByKgAF+O8bd030x1sf7teXuEtwLXBHOeQU3R?=
 =?us-ascii?Q?5xSeyEbWLrTox1Yw5JPU4RNUiAo8dbEgFtV6+O0NhMslIzSSmFNEMDQegSV/?=
 =?us-ascii?Q?PZrVWaBbiea6T/JpJS+Z63E/K0X/4nczms97wRfGk0sC7Zhfz8yKYKF0ExDU?=
 =?us-ascii?Q?iURE84FmJODUXWzMDDJAO9aQ+XPL+/HU7Riyl8YtKiddlHAy68Awxhl8EuTW?=
 =?us-ascii?Q?QLP/0W3MAuJVllmVh0BcFldu9CgYB3dzzUTXXmjpMUYf85B4JMFPd3KbfmKw?=
 =?us-ascii?Q?f5sF9aMwVU7D8qPzkRkBGU8PjpS3aRZKe74RKEtKJpXJ6ys1QjJmuwnFgZpU?=
 =?us-ascii?Q?KrxOHSNxHBmvgDGzevuYYnb0VxDxXfyjTS+ofiZML7yUDsRa0zxGGXQREw4V?=
 =?us-ascii?Q?4Hkb9h/lm5vpazZR0AOoS1nIFZ9vmyF50vGWxze1JPRPnISJ/qFY+4Pjkhrr?=
 =?us-ascii?Q?EZIst3Dl6ZCakC3ke1EKfYHnOj0pRDubVioOIOyG6OsXF6hop/lliRTDq2D8?=
 =?us-ascii?Q?Ce5Qbk6yJ6kMbssmULTZCLAFZGRTLln0sihwbHulLne3L4QB3CHcK0g83wrJ?=
 =?us-ascii?Q?MvO8R8w+iA8v97Bm8MihL3/FBrQ372k3YBGoy4Hi/PMCFcJVITu7d4TsNcn1?=
 =?us-ascii?Q?L0qNSRyE79y26rVqqxrN3WcQ3qVX3x9bYXbOS0NGVkOXcwwhRVjjPst3d5Lx?=
 =?us-ascii?Q?gCPhkAdkrluFITNFldGKTzEn6vdFzRp0unpmSh6AR2A/rjjcQTHV0iuqFVrb?=
 =?us-ascii?Q?QIAP5HAFW9HWWar234uNqwyRuaE4dttn/30AD4bgGmsFv/vh5ATuX6LUjATo?=
 =?us-ascii?Q?DGgEoHcZhLU76/9MLgGybeI1y2NhVvfKpvBHF3q57Pr4foWYSJxurKfqXrGP?=
 =?us-ascii?Q?HOwjK3ubQGHa7arWRRQj/P+GlENk9XvoaC1XfoWt71FlXprXrsFmYRANn89R?=
 =?us-ascii?Q?R7kJh5o/iJOj6TnjfP3GQalNQJswW81YwXzIAE61P6kwovkBHw0Y56iP+7fz?=
 =?us-ascii?Q?aDWvI2WuIoI14J8itwLEC9U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C9DE8BA40CAB7F43A9C1960DD6F43529@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce86ffe9-853a-4a2e-e75d-08d9ecc81e91
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 19:04:09.9035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NoMr/uR85upau27MGF5/uFPz1HpCGmI8BIx47BdedPiHmVUbr1jTgefeoc5U2cHQPU9GIGqcOXvKmpMsDdI2RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2598
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10254 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202100100
X-Proofpoint-GUID: jQTeE2fggXPyILBup7JYvJBqVrqAzQmw
X-Proofpoint-ORIG-GUID: jQTeE2fggXPyILBup7JYvJBqVrqAzQmw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Feb 10, 2022, at 1:59 PM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Thu, Feb 10, 2022 at 04:52:15PM +0000, Chuck Lever III wrote:
>>=20
>>> On Feb 10, 2022, at 11:32 AM, J. Bruce Fields <bfields@fieldses.org> wr=
ote:
>>>=20
>>> I was standing in the shower thinking....
>>>=20
>>> We're now removing the persistent client record early, after the first
>>> lease period expires, instead of waiting till the first lock conflict.
>>>=20
>>> That simplifies conflict handling.
>>>=20
>>> It also means that all clients lose their locks any time a crash or
>>> reboot is preceded by a network partition of longer than a lease period=
.
>>>=20
>>> Which is what happens currently, so it's no regression.
>>>=20
>>> Still, I think it will be a common case that it would be nice to handle=
:
>>> there's a network problem, and as a later consequence of the problem or
>>> perhaps a part of addressing it, the server gets rebooted.  There's no
>>> real reason to prevent clients recovering in that case.
>>>=20
>>> Seems likely enough that it would be worth a little extra complexity in
>>> the code that handles conflicts.
>>>=20
>>> So I'm no longer convinced that it's a good tradeoff to remove the
>>> persistent client record early.
>>=20
>> Would it be OK if we make this change after the current work is merged?
>=20
> Your choice!  I don't have a strong opinion.

I don't disagree that a good quality server implementation should
handle the post-server-reboot case a little nicer. I would like to
avoid losing momentum on the current patch set, though.

Support for post-server-reboot courtesy can be phase 1.5.


--
Chuck Lever



