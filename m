Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 856EDCEF8E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 01:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbfJGXZN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 19:25:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54976 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729504AbfJGXZN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 19:25:13 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x97NJU6k026543;
        Mon, 7 Oct 2019 16:24:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=4p2CVWMR/XPn4Vc2GU05ZSlREMg8SkMnUfwNL+aNfWM=;
 b=SSbtZwwiXxVc9D0M0UZ0z3WVAjx66FvGMjXfRXjB7eBfVtfr1cUH2N6Ux7G/oGRsIO+S
 SNOObWcuoc+P1errFJ71M7DZwgj09qZQwOucwFsYGxB3Gvn43czaMp5FEwok7rDLVCAQ
 enqEzuc80ImGHs3NWTPyHLK38w0qMfr+4oo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vg6ms2era-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 07 Oct 2019 16:24:56 -0700
Received: from ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 7 Oct 2019 16:24:55 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 7 Oct 2019 16:24:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bwn0L1XOLQPikqseTjyDYJ3j1JxlYUOnPwUt4eJLu73+0nVM97n6g8BUpgMiD52xVHnMwU6EA9nFowyAEv7f2z8QGGx8VpPpINIyKkm5ZrjnIbYfcSl14ikeoMEW0qXISUkyQoBsdPobrO6prJsafu80uHem9llz4zcAEc6E0JTMJsjed0pXwVThccqbpgrn3AmRJLImsCcN4VSckEYWUemUY6ZsdCNlU3pDFLpxV8Io8g4HNQeuk8TUQqU46rXWoDuMCDiLN0KoimZrHUwBFzYgMyXIx1FKKBV5MLD+87omyvjri+/NcwOI/nvitIoTeZG0GNTZUQjWcEW8Y/NTkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4p2CVWMR/XPn4Vc2GU05ZSlREMg8SkMnUfwNL+aNfWM=;
 b=haOjgWepO561dV0I6DWgjVG57Q4ova5IXmynh++JusB9uLxUgW2btNWeybwCdqtZYQTztVUtfMc1e6cHvD2tc7JYrXcQBrdBN6SJPsoiey5UkmFH4Paxg69DjwtEm03dMVaYnk9oDidG5oU81H2Kwf9aDu3CN1NH2zvWLvgWe8XA5l0T3iGDVW1tKm50E36Wi+/k+aify8ckjlAjkJvQy7rG081z0YhR8Q5pyXinkJo69V9YRzxBDXZC8DiOj4HLnq1jLCZYpEdzwIrkgcL40ZcOxQ5X0aD0nu83f4xwiLLbmczdEM2jxQNxopfjf8gWtAVRs5yZZob6Yw2/BXZGew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4p2CVWMR/XPn4Vc2GU05ZSlREMg8SkMnUfwNL+aNfWM=;
 b=OqF0lXkr1twAnWKbJBCG4uU7n7KibMbvglm5B34CxEUan1RuiagEgH2gB9XWrvNrFBQkDx9dNiLtUtEAFAdCq/zWiPfts0e5cCq0FJ2+xez5vPgbUGYRN3HkH3GEQPcTsp58AAnZ7KPe69aJjVn8pWxCWRcvKXRJE4nq0rG8IOg=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2947.namprd15.prod.outlook.com (20.178.219.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.23; Mon, 7 Oct 2019 23:24:52 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::dde5:821f:4571:dea4]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::dde5:821f:4571:dea4%5]) with mapi id 15.20.2327.026; Mon, 7 Oct 2019
 23:24:52 +0000
From:   Roman Gushchin <guro@fb.com>
To:     =?iso-8859-1?Q?Michal_Koutn=FD?= <mkoutny@suse.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "tj@kernel.org" <tj@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] cgroup, blkcg: prevent dirty inodes to pin dying memory
 cgroups
Thread-Topic: [PATCH] cgroup, blkcg: prevent dirty inodes to pin dying memory
 cgroups
Thread-Index: AQHVewChQOAw+GKbfEyRn45Yoe7HH6dPX/gAgAB214A=
Date:   Mon, 7 Oct 2019 23:24:51 +0000
Message-ID: <20191007232447.GA11171@tower.DHCP.thefacebook.com>
References: <20191004221104.646711-1-guro@fb.com>
 <20191007161925.GA23403@blackbody.suse.cz>
In-Reply-To: <20191007161925.GA23403@blackbody.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MW2PR2101CA0035.namprd21.prod.outlook.com
 (2603:10b6:302:1::48) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:2a00]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2ee4345-4bd0-4295-5ff5-08d74b7d8d8a
x-ms-traffictypediagnostic: BN8PR15MB2947:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB294769FAA2F9A84BACC78974BE9B0@BN8PR15MB2947.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(39860400002)(346002)(396003)(366004)(199004)(189003)(486006)(186003)(99286004)(66446008)(476003)(8936002)(6116002)(6436002)(66476007)(46003)(66556008)(9686003)(5024004)(66946007)(64756008)(81156014)(81166006)(6512007)(4326008)(256004)(11346002)(6506007)(386003)(76176011)(54906003)(446003)(33656002)(52116002)(478600001)(102836004)(25786009)(6246003)(8676002)(316002)(7736002)(305945005)(71200400001)(229853002)(71190400001)(5660300002)(14454004)(86362001)(1076003)(6916009)(2906002)(6486002)(14143004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2947;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dK+22BOqsL3MfyuiOvMD2lo0YayDSAFhisQabpqb5m6Pp36ALDcAiHvGy8KIL2l0y5Hqc9of3utdUJIgIP1q6ubliZJEQq/PJT/X/7WMwupT/iwYpcvkt2oIC4bpk2UYId9EnSfo8Ekfhu1EwxVRXNBx3/+sYQfBJ75gYsTxfu/LXlbmbxMDTBjfX6U8d/cBbqlLfHXnoC6O6mRQff6oSIh/C6O3uAbh0ni4F4jpCVurMWdqmCWgW6JaOs3DowHksg5k5bHusk3tKqYZTZyVqGmrbTUdEK1yvEOJZrox6STkr0B3ZPGIPwS5LpvNtE06sYdZOVyasLwEtDXWwAHfrdaURYwVRH4K0o2oiZfzdsPCafCO0BQjJ/U4tP/LmCIVqvghusrBdMkI0xmB6VGWApCs5T8FkV9oHi5ALgSZB5A=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <E1AE8D1D549C9047873D0CFFD6B6C634@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ee4345-4bd0-4295-5ff5-08d74b7d8d8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 23:24:52.0581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FTmMd1D1g8/FpZIF5kk8hBSuvhgi3KavxN7onYhrjO6ZyM1OJIgRJn3Fl9Z2wXDA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2947
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-07_04:2019-10-07,2019-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=741 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910070209
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 07, 2019 at 06:19:26PM +0200, Michal Koutn=FD wrote:
> On Fri, Oct 04, 2019 at 03:11:04PM -0700, Roman Gushchin <guro@fb.com> wr=
ote:
> > An inode which is getting dirty for the first time is associated
> > with the wb structure (look at __inode_attach_wb()). It can later
> > be switched to another wb under some conditions (e.g. some other
> > cgroup is writing a lot of data to the same inode), but generally
> > stays associated up to the end of life of the inode structure.
> What about dissociating the wb structure from the charged cgroup after
> the particular writeback finished? (I understand from your description
> that wb structure outlives the dirtier and is kept due to other inode
> (read) users, not sure if that's correct assumption.)

Well, that sounds nice, and I thought into this direction, but I've no idea
how to implement it :)

First, it's hard to find a good moment for dissociation. It seems that
the good moment is after the cgroup has been removed by the user and most
of the dirty memory has been written back, but it's hard to formalize,
given that other cgroups may write to the same inode concurrently.

Second, the current code assumes that wb->memcg association never breaks,
and it's not that trivial to get rid of this assumption without
introducing new locks, etc.

Thanks!
