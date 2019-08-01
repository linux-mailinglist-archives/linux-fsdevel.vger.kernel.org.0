Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5267DCA3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 15:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfHANjt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 09:39:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33058 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725804AbfHANjs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 09:39:48 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71Dc2Zd029380;
        Thu, 1 Aug 2019 06:39:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=daTicNml4+qNGGZTCJm9uI+41O81uJc/GgzwyZfREk4=;
 b=SiQKz7LyPRQkTpSG+3jWs4z0k32IFbSFdXI6yuyUrJFQn9OoJuFrZmR4f92v+i2v6hzZ
 AkB4NLgJZYNsNyJmPi6Jl1dnl9zBZ3qvwo8FjakNJFexGrxBNALYJcL4q9mZLzcPYjqx
 LclGL3lJiDlcGGD0Jg0hQkzNz6x3/6rZ4HQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2u3n9xjgkj-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 01 Aug 2019 06:39:43 -0700
Received: from ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) by
 ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 1 Aug 2019 06:39:35 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 1 Aug 2019 06:39:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPA+fWxxpT2YaKHqQH9miFAqTNA/8BkU2yBoSqjCwoLtlroNDPCdfCkXi3/U9ioeBaTy9DzqsBaA+2UYlRIbKQmUjTYlkqFSD8jYuDfhrkcRF6fI1uSKp5672kuuL11l7iNlIsGwOGCsiSZIlUSWEh5qZy7og4CgDKdHE6aWPUqUq6nSPP39LDJ/ocnenqOP/t91+lfMqRTeF2a/5jcOHmgiyp0+Q/HFv/Ani0b58bxa2k5gPjjh1/4iVgYR+Gc+qfHn9EkigxltWzrh5vQMhgWUUSR8+3WvCiK/S9CLz04tj9LFF0QgRh8PS7Rk7DqywcZ0Yj7L9lw+VW06cs/q5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daTicNml4+qNGGZTCJm9uI+41O81uJc/GgzwyZfREk4=;
 b=L7Q414dJ1mL7rkfwFmBoSFx0VedMaTmKCvUsFCoiwxiaLfsgPG1I6hTPMMJmn/htd2Znd98CP7JsBgMjp4Svx8ceA26NxJj6Q2yY6UbdcPQ3yEdLwIs/5txaQokv8B8gcKzAhAiv3xQSnzQ17VSvBKCglpSrudtFj6Ee1UuRfwFidVcP6slPHudQihj6j6Mhg29Fy38TcftpunmporSaSZOvtUC1ctc6KxZ1mnogyFdHI82dvPo6e5ooaL4wHNiPwA2ZjNOE+BsBjQhhnfhhZaGDpMVa6BzdkjqaOFysLRfrC/nJ5VVyGRCOXEjm1bItMX/AfpjzgIhLglTc6XMQjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daTicNml4+qNGGZTCJm9uI+41O81uJc/GgzwyZfREk4=;
 b=BOZy/LL80Krx4XZTE6qvqxeYv+lP18mPOhli3PUXIcD+Tw8+AFlz7iQfSASKegI6j7v0ITeO0++QLF3TOQeIqqUbgGIUMQ2EJZ2YlIHi0QY9zwClsUtG1bFq9aL2M5u6Z6kV3iBEVP3DoTZuDUs2BMKBNHIQ4W5OLeMNAx5264M=
Received: from BN6PR15MB1282.namprd15.prod.outlook.com (10.172.208.142) by
 BN6PR15MB1444.namprd15.prod.outlook.com (10.172.151.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Thu, 1 Aug 2019 13:39:34 +0000
Received: from BN6PR15MB1282.namprd15.prod.outlook.com
 ([fe80::c47a:8d15:afbc:debd]) by BN6PR15MB1282.namprd15.prod.outlook.com
 ([fe80::c47a:8d15:afbc:debd%10]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 13:39:34 +0000
From:   Chris Mason <clm@fb.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 09/24] xfs: don't allow log IO to be throttled
Thread-Topic: [PATCH 09/24] xfs: don't allow log IO to be throttled
Thread-Index: AQHVSA9fnWuPStnf6EeOPJMMPtRTUqbmTPoA
Date:   Thu, 1 Aug 2019 13:39:34 +0000
Message-ID: <F1E7CC65-D2CB-4078-9AA3-9D172ECDE17B@fb.com>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-10-david@fromorbit.com>
In-Reply-To: <20190801021752.4986-10-david@fromorbit.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.12.5r5635)
x-clientproxiedby: BN6PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:404:4c::17) To BN6PR15MB1282.namprd15.prod.outlook.com
 (2603:10b6:404:ed::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:480::bfbd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54982839-4942-4c64-fc02-08d71685b05e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR15MB1444;
x-ms-traffictypediagnostic: BN6PR15MB1444:
x-microsoft-antispam-prvs: <BN6PR15MB1444A23509E44B67AB37CEA8D3DE0@BN6PR15MB1444.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(39860400002)(136003)(376002)(199004)(189003)(71200400001)(476003)(14454004)(53546011)(14444005)(36756003)(46003)(486006)(6436002)(76176011)(7736002)(6916009)(8676002)(186003)(478600001)(11346002)(8936002)(52116002)(229853002)(50226002)(81166006)(386003)(68736007)(6506007)(2906002)(102836004)(316002)(81156014)(2616005)(6486002)(446003)(33656002)(54906003)(5660300002)(305945005)(66946007)(6512007)(256004)(6116002)(64756008)(66476007)(66556008)(53936002)(6246003)(71190400001)(86362001)(99286004)(66446008)(25786009)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR15MB1444;H:BN6PR15MB1282.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jCPNsrsYj2CPdrlAHs0/1GprP43MiqLSQapmRtNZddNVOaSkj4QWt2JH1IlQzpNLvixoMhBf1HU5o+VP9eefatWphr6ZmctKgJKjQVe+5cL9shBt1XjeijE9Te6GLfxpiqcGNXluTOzWrjyHEjE7UnSEKlD0SkoI0k9I7L3cRF6fiuqVgDNKekRTn8VawI+O0Mc2iTpHXIAUETBNGRkXIaMUGVBTsAWZziRHSVR5rYK77cKhiZg9VfGccPEg5o2n5xcwVrVnWTkmFhFlW/FU1ppupmfMGKhWc5a7+4keADsNTLmobaFPlNYozfGP27nfrTOJwH0bvWgcciApEBk5GB7S4v2STnTygQQRrMGP6tjvvLqGI3B60+vf1Pb1wg7AhdFSTf98gDYDiAi55M2IpEGAaOEAqJr0Q+TzqafQMyQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 54982839-4942-4c64-fc02-08d71685b05e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 13:39:34.4309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: clm@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1444
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=745 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010145
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 31 Jul 2019, at 22:17, Dave Chinner wrote:

> From: Dave Chinner <dchinner@redhat.com>
>
> Running metadata intensive workloads, I've been seeing the AIL
> pushing getting stuck on pinned buffers and triggering log forces.
> The log force is taking a long time to run because the log IO is
> getting throttled by wbt_wait() - the block layer writeback
> throttle. It's being throttled because there is a huge amount of
> metadata writeback going on which is filling the request queue.
>
> IOWs, we have a priority inversion problem here.
>
> Mark the log IO bios with REQ_IDLE so they don't get throttled
> by the block layer writeback throttle. When we are forcing the CIL,
> we are likely to need to to tens of log IOs, and they are issued as
> fast as they can be build and IO completed. Hence REQ_IDLE is
> appropriate - it's an indication that more IO will follow shortly.
>
> And because we also set REQ_SYNC, the writeback throttle will no
> treat log IO the same way it treats direct IO writes - it will not
> throttle them at all. Hence we solve the priority inversion problem
> caused by the writeback throttle being unable to distinguish between
> high priority log IO and background metadata writeback.
>
  [ cc Jens ]

We spent a lot of time getting rid of these inversions in io.latency=20
(and the new io.cost), where REQ_META just blows through the throttling=20
and goes into back charging instead.

It feels awkward to have one set of prio inversion workarounds for io.*=20
and another for wbt.  Jens, should we make an explicit one that doesn't=20
rely on magic side effects, or just decide that metadata is meta enough=20
to break all the rules?

-chris
