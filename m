Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02E8A12FBBB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 18:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgACRqh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 12:46:37 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48810 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728220AbgACRqg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 12:46:36 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 003Hiot5005540;
        Fri, 3 Jan 2020 09:46:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=gk2SR+m8xqtAVw8/7ybGcOVRa5lBq/vaY/diURVPRZE=;
 b=Ktm6boVYughj6v5nFdk3kCMytyIlJsH0ZVkkdsUre/kTyWhPJX1rydXC3rOQO4Y/5NCs
 aV4KzMWgyGvs7BqHT8UKEK99CxZV8dl8r8djieMEjuu4yuaoRsUFn/w0LQMw7t1TR52t
 LAvuyv9Ir8ENMhi/+/uOxwThqFJBzAYXQTU= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2x9e34x2ye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 03 Jan 2020 09:46:31 -0800
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 3 Jan 2020 09:46:29 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 3 Jan 2020 09:46:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpRtSdzakgQuxpstMA1xRB0Q06+fT3TYMdAKACpLL7q+cyUlpzBGpc75zoKCbFK2Fn/VtllyCUYgBUk2Ab2gburJOVxb/4MhLZ1ofOKXYU88XIcXz3LRaOxbXsCx1vOLHD1VcKnriiRCSnFGiG0Ti/Fl2Eq5uj46Ou7PcvtxsFJD+YWxTqCV/Xm5SE3No9TOmV2hDAP+/av1mdljbqSVWmMynWLJC7JYPcscm9GgT3hMM59X3QLBJ6hd/zj+jj1zCGURjNfcRR441SrOZUZvKpCLN6NfmPuunjBsjdIgWvmiG3L/c5mluj1Q1tfvtHffCCPyP+beImpLXgKAl9/1Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gk2SR+m8xqtAVw8/7ybGcOVRa5lBq/vaY/diURVPRZE=;
 b=TFgEf3OZDuMuGyHHuD9qPvD0f6YSGgRjKODgSG6wVOHPh8lSy6RcVxESXwQFVZnIM8zqhlEfIeHxcYq6I2RrToS6XAQKZrmPx0dRZqHveFp2SUASku/mmBiS409oxDZh4sQJJEmWCAWPSZHDiDeq+2njy98Siq7QCNWc+YMyCOH2KlCuYgqr5JXjG5lAiXJ5xVNO7g9ACUw0aC9izEKgQ6jidTLyCkcD8QE6VDmKlcuexZs6tBa+kpi6f65RNvlWYUys/6Au1Z9C5nFDwg8lTSKMUTgrBc5jRZYdUdZ6Ox7+9Nlg9Zyo1GQZmDyMsesgbIZl6VQzG7jQYZzE0vo0pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gk2SR+m8xqtAVw8/7ybGcOVRa5lBq/vaY/diURVPRZE=;
 b=Fo3AgaXOMzj/9fkoQZLdIFdvCnb1EkuQqCg6V0kzqXeir7VR7ypxDRr9mRzBg5JSuqYRDjiMloA8UEJ+HGs1DGsd4RcGGngZgX5W4/JzKVbUAvvojRJKLfyJTHMjEsMp/E0KjCHQVZYJ0/HEpXje0bmPTwJHdXna22rOGlfo/20=
Received: from SN6PR15MB2446.namprd15.prod.outlook.com (52.135.64.153) by
 SN6PR15MB2287.namprd15.prod.outlook.com (52.135.65.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Fri, 3 Jan 2020 17:46:29 +0000
Received: from SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::615e:4236:ddfa:3d10]) by SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::615e:4236:ddfa:3d10%6]) with mapi id 15.20.2602.012; Fri, 3 Jan 2020
 17:46:29 +0000
Received: from [172.30.100.156] (2620:10d:c091:480::44f7) by BL0PR02CA0022.namprd02.prod.outlook.com (2603:10b6:207:3c::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend Transport; Fri, 3 Jan 2020 17:46:28 +0000
From:   Chris Mason <clm@fb.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -v2] memcg: fix a crash in wb_workfn when a device
 disappears
Thread-Topic: [PATCH -v2] memcg: fix a crash in wb_workfn when a device
 disappears
Thread-Index: AQHVvRkX1XTmcfbDL0iuYh1G7ObE/KfZOIqAgAAItAA=
Date:   Fri, 3 Jan 2020 17:46:29 +0000
Message-ID: <527DCBC3-28D2-4BFE-A99C-8ED65A613A20@fb.com>
References: <20191227194829.150110-1-tytso@mit.edu>
 <20191228005211.163952-1-tytso@mit.edu> <20200103171517.GA4253@mit.edu>
In-Reply-To: <20200103171517.GA4253@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.13.1r5671)
x-clientproxiedby: BL0PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:207:3c::35) To SN6PR15MB2446.namprd15.prod.outlook.com
 (2603:10b6:805:22::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:480::44f7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac6df590-cd59-4fc6-00b5-08d79074dcb0
x-ms-traffictypediagnostic: SN6PR15MB2287:
x-microsoft-antispam-prvs: <SN6PR15MB22878B01BC84F4854CD31093D3230@SN6PR15MB2287.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0271483E06
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(396003)(39860400002)(376002)(199004)(189003)(64756008)(66946007)(66476007)(66556008)(4326008)(66446008)(2616005)(478600001)(316002)(53546011)(71200400001)(36756003)(81166006)(2906002)(81156014)(6916009)(54906003)(5660300002)(966005)(186003)(16526019)(86362001)(8936002)(33656002)(8676002)(52116002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR15MB2287;H:SN6PR15MB2446.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o+5mmyIP8g3FWMm7N3dE+kF2MhRE21wDDhbJIoi8G4dZesBMO0PubdFA859WPMGvT+HEl4J5tohRGwJ47vvhlRE+8U+GMD0Iz22juLUgr+/bOrnWs9jxVy9XeZpmP1okYDWHKV/O+9DjYv7kAFFAaHNSUA+TopCln90WW0/m18CKUjXluwAmLNPHYWHUey+npQerBHgAWilD4n83+CAdPQoAvAltpt/CgXu6woH8ygbb1cHb+zPyXCCyvpEmpwJidIc1tVqd1aAo3LjI3vDcCAkMDjODrCOL/R+capi2mNZF3qPBmfnnTWHwKG2PkF8Mo16HlTIMKh4l61WPi+Q0UoRmjAP3+MceU7AA3dRYwgh6Shh0oH4DF5MCBmX1PFNzucz5zB1xyUWt0iSm58Z8QOijWmwVzIJNxelSquJRTaH/dSW2/qhvdbCrfGvZXjC6RUJ4olaqrxB5MpZp8rObniS7JzTg8RPwja1igLoohtA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6df590-cd59-4fc6-00b5-08d79074dcb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2020 17:46:29.0352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YmGq2O1AIsoGqFKeXRWJzCbIpbpL4z6tjkmSmHuPDK92O84yoqieTqajmLL0rFny
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2287
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-03_05:2020-01-02,2020-01-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 clxscore=1015 bulkscore=0 mlxlogscore=907
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001030163
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3 Jan 2020, at 12:15, Theodore Y. Ts'o wrote:

> On Fri, Dec 27, 2019 at 07:52:11PM -0500, Theodore Ts'o wrote:
>>
>> Fortunately, it looks like the rest of the writeback path is=20
>> perfectly
>> happy with bdi->dev and bdi->owner being NULL, so the simplest fix is
>> to create a bdi_dev_name() function which can handle bdi->dev being
>> NULL.  This also allows us to bulletproof the writeback tracepoints=20
>> to
>> prevent them from dereferencing a NULL pointer and crashing the=20
>> kernel
>> if one is tracing with memcg's enabled, and an iSCSI device dies or a
>> USB storage stick is pulled.
>>
>> Previous-Version-Link:=20
>> https://lore.kernel.org/r/20191227194829.150110-1-tytso@mit.edu
>> Google-Bug-Id: 145475544
>> Tested: fs smoke test
>> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>> ---
>>
>> Notes:
>>     v2: add #include for linux/device.h
>>
>>  fs/fs-writeback.c                |  2 +-
>>  include/linux/backing-dev.h      | 10 +++++++++
>>  include/trace/events/writeback.h | 37=20
>> +++++++++++++++-----------------
>>  mm/backing-dev.c                 |  1 +
>>  4 files changed, 29 insertions(+), 21 deletions(-)
>
> Ping?
>
> Any comments?  Any objections if I carry this patch[1] in the ext4
> tree?  Or would it be better for Andrew to carry it in the linux-mm
> tree?
>
> [1] https://lore.kernel.org/k/20191227203117.152399-1-tytso@mit.edu

Seems sane to me, and we probably want this even if del_gendisk()=20
embraces the brave new memcg world because synchronizing all of this is=20
going to get messy.

-chris
