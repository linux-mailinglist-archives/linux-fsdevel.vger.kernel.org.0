Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81C0CCEFA6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 01:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbfJGXgL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 19:36:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37936 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729145AbfJGXgK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 19:36:10 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x97NYAS9030409;
        Mon, 7 Oct 2019 16:36:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=pZW78zJWzn/iSK9kZrAtn/ngmP50RhTvGj73mHVCs6Q=;
 b=kno4fMwH1yAf5RDnvc/FNo4jqvAqLiWQTcRvmd8/jr2A5dfE5J9eF7br0lcm9auILKAR
 0PO37WBDE5wNmOKK1K4nW6QoOAFHiLfkw2zD8ArCDn7XXehu8kc8auzazTRU4tNnttIZ
 TTLLUMEO3ABi1bOs+fj3+ZzVVmADh2//9jc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2vepp1tqtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 07 Oct 2019 16:36:03 -0700
Received: from ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) by
 ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 7 Oct 2019 16:36:02 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 7 Oct 2019 16:36:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kby1g/BFLAe5ddMXnYIun9eH1Qe/t91H1Ebf7zuA0ULc05klWmkEFgyeFPF3Jreueym3RnpHaP+ieV/zB46gF99RBTLV5wcCg3VGe5p8bU5L2tPm1iqldg8RTW9zqM7mODLld5wbvrKaUg4gYSCActBbAphss89dsYTPLS6/vZkIXNI7KWNS9q+T2HUeguU9BwU5Ykup8aV8zzt7tdL9X1Q0xh5pcQW5gFaw570AdIT38Pn3J+80UZZ484uvfFG/I5mCwKQD6y1Tv7nmZc1t56NyP6Ed2xxGV16ut7V6h2pHGC7wsdigQ4vQEyiOVK/489MNMXj4HzTyW128tdf3EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZW78zJWzn/iSK9kZrAtn/ngmP50RhTvGj73mHVCs6Q=;
 b=liO+owMxDEWxspcKasT7kgYnl4xBlTRRf+t1QarqSn6IfBsBST8mK56+WC/L1TejDEpYvgaHeMj63FZbwhKy+GCxJoiXnD+Q3jscqrIQD49qmLCBxuuUomllh3n6ArJvKmRJWzFB0JJCM0jmHwiZpQeiaAf6eFiBQgLiP47zu3VyUQ6kyosAA8IYE0U3zKI0HAVP/9tYtP9o2AmPod2VYfM5bju+ZOxpCtMomoZmYMtw3GtpKYOFX5qly+qfu7wiBy9nNZXkjDI55y8R9nqHD2d+oHmY9blT0t7NXLArGNYL51PK7W+Btf8xluQouZUThOkj6ukd11zf6PIlX3zSvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZW78zJWzn/iSK9kZrAtn/ngmP50RhTvGj73mHVCs6Q=;
 b=bWg+JDvrARuZavR+rs/l3bbpFs57XXeVO8qorn/1RvIwiIGhcOI2/HxvNJCtZoDhVboe4Lm9tYMC0isjQIj3/fYIydi6ZeZ2640ij9EmmjC1qV8icV1B/Fp4cLizbSyaIIAxJyXIYsWccNB3l+u+lZZYtwT66uu8Sfldf4QM9Ak=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2946.namprd15.prod.outlook.com (20.178.218.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.25; Mon, 7 Oct 2019 23:35:44 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::dde5:821f:4571:dea4]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::dde5:821f:4571:dea4%5]) with mapi id 15.20.2327.026; Mon, 7 Oct 2019
 23:35:44 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "tj@kernel.org" <tj@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] cgroup, blkcg: prevent dirty inodes to pin dying memory
 cgroups
Thread-Topic: [PATCH] cgroup, blkcg: prevent dirty inodes to pin dying memory
 cgroups
Thread-Index: AQHVewChQOAw+GKbfEyRn45Yoe7HH6dPSQKAgACQ1oA=
Date:   Mon, 7 Oct 2019 23:35:43 +0000
Message-ID: <20191007233539.GC11171@tower.DHCP.thefacebook.com>
References: <20191004221104.646711-1-guro@fb.com>
 <f12d0a39-b7ef-39f9-3ff7-412c2d36aaac@suse.cz>
In-Reply-To: <f12d0a39-b7ef-39f9-3ff7-412c2d36aaac@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0037.namprd22.prod.outlook.com
 (2603:10b6:301:16::11) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:2a00]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d2cbed6-d647-4fb5-b010-08d74b7f1250
x-ms-traffictypediagnostic: BN8PR15MB2946:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB2946565B07F7FB7FEA96EC47BE9B0@BN8PR15MB2946.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(366004)(376002)(346002)(199004)(189003)(54094003)(386003)(316002)(6506007)(6916009)(54906003)(486006)(53546011)(52116002)(76176011)(476003)(11346002)(446003)(46003)(102836004)(2906002)(71200400001)(71190400001)(6116002)(86362001)(186003)(66446008)(66946007)(66476007)(66556008)(64756008)(6436002)(9686003)(6512007)(6486002)(229853002)(7736002)(305945005)(4326008)(14444005)(99286004)(8936002)(81166006)(8676002)(81156014)(256004)(1076003)(14454004)(5660300002)(25786009)(478600001)(33656002)(6246003)(14143004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2946;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BXXuIp7lriX5zSLgXXbzpcyC+DyrNOy6uUA7y3Bxtkt919JA4nLhmKLujIZbUOSPFv59R4Q5yUOI699UNP4v7DsmJCSvKI3WDEGAWJKKJQ6CZ3yxPmKu/BCm8GamlEZ7efswIUPv1q8BB+0hoagbdSRUXAaxm4cpFg5moKAD2/IbGKGmBKkKKMw8kkR/Tr3KX6MUHvsfKQr+RjEOPrUBJBhJ4UeL4gvNOsU1yBSs11oMMsklwR2i59YIMnhWED6S+Fg5I0VRlkTT3u/5BL4XrwxakCR4nGHZvEVyWhk563S48Kcf1AZn2M4r0jd0RO4kYGsOG5g1T6d2R7NIhvMtcVGjBZMIySNLbKMPuxXYCaNOc/DUac2Do0lnH8+ADAQ+VH76e4Ed8sedYM6OulaNgK8thHC4bMBifnJwfSThoiY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28F922B8B34A0C4D9800A6E1552519F0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2cbed6-d647-4fb5-b010-08d74b7f1250
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 23:35:43.8510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 13nwpEN+ppN9SedQGJJs5e7YZ7I498aeKap2yYnXFb/RvFW/1EzcgH4k4jm870Hu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2946
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-07_04:2019-10-07,2019-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=883
 lowpriorityscore=0 spamscore=0 mlxscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910070211
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 07, 2019 at 04:57:15PM +0200, Vlastimil Babka wrote:
> On 10/5/19 12:11 AM, Roman Gushchin wrote:
> >
> > One possible approach to this problem is to switch inodes associated
> > with dying wbs to the root wb. Switching is a best effort operation
> > which can fail silently, so unfortunately we can't run once over a
> > list of associated inodes (even if we'd have such a list). So we
> > really have to scan all inodes.
> >=20
> > In the proposed patch I schedule a work on each memory cgroup
> > deletion, which is probably too often. Alternatively, we can do it
> > periodically under some conditions (e.g. the number of dying memory
> > cgroups is larger than X). So it's basically a gc run.
> >=20
> > I wonder if there are any better ideas?
>=20
> I don't know this area, so this will be likely easily shown impossible,
> but perhaps it's useful to do that explicitly.
>=20
> What if instead of reparenting each inode, we "reparent" the wb?

It seems to be an arguable idea, at least at the offlining moment.
Dirty memory left after a cgroup should be written back using
corresponding limits, and reparenting can easily break them.

Also, it's not clear to me, how to reparent dirty stats?

> But I see it's not a small object either. Could we then add some bias
> for inode switching conditions so that anyone else touching the inode
> from dead wb would get it immediately?

You mean touching for writing? That's doable, but doesn't solve the case
when there are only readers. And the case is quite common.

> And what would happen if we reused the reparented wb's for newly created
> cgroups? Would it "punish" them for the old inodes?
>=20

No idea, to be honest.

Thank you!
