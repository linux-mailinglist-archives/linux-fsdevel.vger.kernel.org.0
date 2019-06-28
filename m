Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAA545A104
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 18:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfF1Qe1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 12:34:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50642 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726667AbfF1Qe1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:34:27 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x5SGWfYS015761;
        Fri, 28 Jun 2019 09:33:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=EmhpIaJshMDOvbE5U+8uSwIg98rUZbLjquMoASS+As4=;
 b=d2kzLdC1eeaHJHOoWr+scUpxldlFk6WltbQ2tfkRhX/uSvm9Ex55kZlOo87pGpZUDIDz
 TVnLNJPHPCbNIsXqZMBPn5fcT2yJW6v+hJ1u6H8jbGe502vDWbsD4oXnPI2Sixu5yjoj
 G7S3jR6b3/M+LDagStuXIPBAADgl8YoRiL0= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2td859jp5r-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 28 Jun 2019 09:33:44 -0700
Received: from prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 28 Jun 2019 09:33:43 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 28 Jun 2019 09:33:43 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 28 Jun 2019 09:33:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=cM+e7mu+RQZWeNRM6R1O0otX3emchldp70j7avonOxd7yZq/ADNfcUPU0fpju5NNdnKY5Nb0rwTkl439g9ys2SY/+msRPTRZioI6gGovm33ANMQjcALSCMT7M+oo3l1UkvMrzfSbDV7nobpeyTjsVSb5MX5dwRnSDDLSlWSfVZk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmhpIaJshMDOvbE5U+8uSwIg98rUZbLjquMoASS+As4=;
 b=FJarfY0cGMZ6z+BR6rx6zUjLqlgQjbfbKcEP6a4X2i/i92bqDraybPnh20sc+zI78b9ulpcsnZpkNw8DY+w2ygLZlXGxRFzZW/dJT898F8g98yv+YJd+4XivsifXAC9+JI66BepbcUSWV+meL8RGKXiOrrVJYjhHiq3UTarXiWU=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmhpIaJshMDOvbE5U+8uSwIg98rUZbLjquMoASS+As4=;
 b=jTwDqfJLEUqryXxoR+eLFrAl2/zXVVFbnAKJNltP6rZISWjW2x88Bb+QgoVhW0foCnSUZ9I0/AhrsTxXMB6JutPWDAUW5LOeyO0RGaJFfM8caU6la9HeTFDZ2VXYs61WbMANebYb/EhCm3e1XL/YAaAXZFNWPU7yJlXYykgeGaM=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2563.namprd15.prod.outlook.com (20.179.137.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 28 Jun 2019 16:33:41 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::e594:155f:a43:92ad]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::e594:155f:a43:92ad%6]) with mapi id 15.20.2008.018; Fri, 28 Jun 2019
 16:33:41 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Christopher Lameter <cl@linux.com>
CC:     Waiman Long <longman@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 2/2] mm, slab: Extend vm/drop_caches to shrink kmem slabs
Thread-Topic: [PATCH 2/2] mm, slab: Extend vm/drop_caches to shrink kmem slabs
Thread-Index: AQHVKrRnjGLXeWaE8kq5EhXDbrxOt6auY3OAgAGdGgCAAAdmgIABMAYAgAAREwA=
Date:   Fri, 28 Jun 2019 16:33:41 +0000
Message-ID: <20190628163334.GA3118@tower.DHCP.thefacebook.com>
References: <20190624174219.25513-1-longman@redhat.com>
 <20190624174219.25513-3-longman@redhat.com>
 <20190626201900.GC24698@tower.DHCP.thefacebook.com>
 <063752b2-4f1a-d198-36e7-3e642d4fcf19@redhat.com>
 <20190627212419.GA25233@tower.DHCP.thefacebook.com>
 <0100016b9eb7685e-0a5ab625-abb4-4e79-ab86-07744b1e4c3a-000000@email.amazonses.com>
In-Reply-To: <0100016b9eb7685e-0a5ab625-abb4-4e79-ab86-07744b1e4c3a-000000@email.amazonses.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR12CA0068.namprd12.prod.outlook.com
 (2603:10b6:300:103::30) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:2d3d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67b08d95-c34e-4225-a222-08d6fbe660fa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN8PR15MB2563;
x-ms-traffictypediagnostic: BN8PR15MB2563:
x-microsoft-antispam-prvs: <BN8PR15MB25634C931DAEF8627FF4E059BEFC0@BN8PR15MB2563.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(366004)(396003)(376002)(346002)(189003)(199004)(8676002)(81156014)(478600001)(81166006)(99286004)(6512007)(6486002)(9686003)(71200400001)(6436002)(486006)(86362001)(102836004)(186003)(11346002)(316002)(7736002)(386003)(76176011)(476003)(4326008)(71190400001)(305945005)(229853002)(2906002)(52116002)(446003)(6506007)(53936002)(1076003)(46003)(6246003)(256004)(6116002)(25786009)(33656002)(14454004)(5660300002)(7416002)(6916009)(73956011)(66946007)(66446008)(66476007)(68736007)(64756008)(14444005)(54906003)(66556008)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2563;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U6M9W8ycwznHcAf9DXWAcE1cemfxWD7Ji6rzNwd9ui+oXvV1kj77IgrRHH2mgnrheSzPI9i4CQqZ2Oso2dzyDkmHUqGIDggSx4ZNWAS0+QCas+saHjalERQu3fwtwJSFgiuFag0ry+7TIyfhSrR0iquyB1ieLGrY78bgeL8wPSSYDPwxsNOB7N+37OgX7E51biPB2DIuFBEVHXmJGzmRT8/rTA7v0yMizx8LLDUfziSLoX6gXvOKc2eKKWkBV+8bBZ3Z0TvjbBzoE0QnHq0+4LBYTddM7dBGkSzyPfRWhswgpawhN3IPOEfFKTzN/I7tZYFZ+SO2xZvGAJhZxo/7SbLOjn+g9IGi86RUOim1DPTo6PLSMEB0aMP3hbPSKTV0vCibrDuSkBDNPo5WA85exWQfGHAEkxsHb+OAlOCTCPc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7763BC919F3B554094D311CA81F5E330@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b08d95-c34e-4225-a222-08d6fbe660fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 16:33:41.1449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2563
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=687 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906280188
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 28, 2019 at 03:32:28PM +0000, Christopher Lameter wrote:
> On Thu, 27 Jun 2019, Roman Gushchin wrote:
>=20
> > so that objects belonging to different memory cgroups can share the sam=
e page
> > and kmem_caches.
> >
> > It's a fairly big change though.
>=20
> Could this be done at another level? Put a cgoup pointer into the
> corresponding structures and then go back to just a single kmen_cache for
> the system as a whole?
> You can still account them per cgroup and there
> will be no cleanup problem anymore. You could scan through a slab cache
> to remove the objects of a certain cgroup and then the fragmentation
> problem that cgroups create here will be handled by the slab allocators i=
n
> the traditional way. The duplication of the kmem_cache was not designed
> into the allocators but bolted on later.
>=20

Yeah, this is exactly what I'm talking about. Idk how big the performance
penalty will be for small and short-living objects, it should be measured.
But for long-living objects it will be much better for sure...

Thanks!
