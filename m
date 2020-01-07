Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E46B1334F7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 22:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgAGVhw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 16:37:52 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:30400 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726210AbgAGVhv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:37:51 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 007LVlgE007977;
        Tue, 7 Jan 2020 13:37:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=jQxkt42IonmUQ+qhV/N0TGFOFwgzNZ1+EiGp8OMAl8c=;
 b=C4tmwpKDPL+s5SpWIA/mCoiCg2ySyKGzB6cyqhkt891E7G5SAGJ/MweU2EVJPsn20PHg
 aDpfuZWSd3ggt/cyraKFU3CSxpSHEf/LQDpVjWhYZmmpFsBdz4taR7l5LfbKes3M5lJ4
 sOToJb+lqns36OHjpOAZkz+wDgCrtkD9hUo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xbb4vp1pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 07 Jan 2020 13:37:33 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 7 Jan 2020 13:37:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mprKdnI6sct9b4/mUwzJ1PzgG23OHnfeEA1O9VmFgyEPPF/DDB96OY4IblxnCbNsz+7HWOgm1LXUECeaLok+NEU0SePAj6AZOJ5Pqd1hsP3SW3/7Rk4HRLskxsKiN2aaWaBKQRtkBkt6J19G5NhkQ1my/5dZGp0Cawi/aXdVlAgvfUc3tlKiy4jK/gz9XgMD6QzKDVccviHH+/pxJncy73nEMSgwFUHhRAhV+jp+ypfGeMOGSPkRrPMRXS8qYrDoLJDDvI3aIs8KkTCeYh4PusKrL/a/LQFdJr9cyXQMCadl9hT4qPr9gTpkK6ONkV1sqgLvj4ZdxYp1AjgCoZOlxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQxkt42IonmUQ+qhV/N0TGFOFwgzNZ1+EiGp8OMAl8c=;
 b=hVJWGRXq5bmp/kESeJthePNBJ/F+LgWZm8zXYQqYg2IxhQskUly7XrEXRT1WhHpCrklj88fa+VJ54aak6VKCN8tb1dIJa0uYZM/KOfegmJvSLchgX6ONsvxhJ7N9YcfRFf0RO6DmM1XpuNvwcDX7yaeLVn2tC3Jhy6SDf5seV/DtdAmC2PM17rdVLHHj+8588sZstCwkrowvbpb7veoA2l5S69ETVhiXxE2XTpKesh6Gs6qoqy8b2MFgHEuxy801XafjXpuPvRom+OzFC/8QbEU31N0eOjyrL07yV0C6X6cTcQnqMSFlHVmrTXYpchdZhKDul4wt9Ub/FxGb119kcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQxkt42IonmUQ+qhV/N0TGFOFwgzNZ1+EiGp8OMAl8c=;
 b=SH2oS7zsi+7N9NmtYaAF3bC939AxpNpUq16wTrPXp+4Ycj2jZTCj/5ybeW9KweunITZrVMf+TvN3upnWIVX0Dgx2NJbo0oiewEVUPsJpF4RS3GBR8CKaTvWPrDqBwHDVMWtSILum/E4JCr7WOik7yalBF9BuMsfcKPmQupfHI+I=
Received: from SN6PR15MB2446.namprd15.prod.outlook.com (52.135.64.153) by
 SN6PR15MB2317.namprd15.prod.outlook.com (52.135.67.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Tue, 7 Jan 2020 21:37:26 +0000
Received: from SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::615e:4236:ddfa:3d10]) by SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::615e:4236:ddfa:3d10%6]) with mapi id 15.20.2602.016; Tue, 7 Jan 2020
 21:37:26 +0000
Received: from [172.30.77.45] (2620:10d:c091:480::3e5) by BL0PR02CA0113.namprd02.prod.outlook.com (2603:10b6:208:35::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.8 via Frontend Transport; Tue, 7 Jan 2020 21:37:24 +0000
From:   Chris Mason <clm@fb.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     Amir Goldstein <amir73il@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Chris Down <chris@chrisdown.name>,
        Linux MM <linux-mm@kvack.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v5 2/2] tmpfs: Support 64-bit inums per-sb
Thread-Topic: [PATCH v5 2/2] tmpfs: Support 64-bit inums per-sb
Thread-Index: AQHVw8CGl/KetGOh6EKI9KXS1swjsKfeVkeAgAABsoCAAAZuAIAAaK2AgAAcgoCAABq1AIAAtxOAgAAIagA=
Date:   Tue, 7 Jan 2020 21:37:25 +0000
Message-ID: <4E9DF932-C46C-4331-B88D-6928D63B8267@fb.com>
References: <cover.1578225806.git.chris@chrisdown.name>
 <ae9306ab10ce3d794c13b1836f5473e89562b98c.1578225806.git.chris@chrisdown.name>
 <20200107001039.GM23195@dread.disaster.area>
 <20200107001643.GA485121@chrisdown.name>
 <20200107003944.GN23195@dread.disaster.area>
 <CAOQ4uxjvH=UagqjHP_71_p9_dW9wKqiaWujzY1xKe7yZVFPoTA@mail.gmail.com>
 <alpine.LSU.2.11.2001070002040.1496@eggly.anvils>
 <CAOQ4uxiMQ3Oz4M0wKo5FA_uamkMpM1zg7ydD8FXv+sR9AH_eFA@mail.gmail.com>
 <20200107210715.GQ23195@dread.disaster.area>
In-Reply-To: <20200107210715.GQ23195@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.13.1r5671)
x-clientproxiedby: BL0PR02CA0113.namprd02.prod.outlook.com
 (2603:10b6:208:35::18) To SN6PR15MB2446.namprd15.prod.outlook.com
 (2603:10b6:805:22::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:480::3e5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8deedea-350a-474e-0774-08d793b9c9ad
x-ms-traffictypediagnostic: SN6PR15MB2317:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR15MB23178AA1C92F58DBAC430BDED33F0@SN6PR15MB2317.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 027578BB13
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(39860400002)(346002)(396003)(189003)(199004)(71200400001)(86362001)(53546011)(5660300002)(81156014)(81166006)(52116002)(8936002)(16526019)(8676002)(7416002)(316002)(186003)(478600001)(54906003)(4744005)(6916009)(66446008)(66946007)(66556008)(36756003)(2616005)(33656002)(2906002)(4326008)(6486002)(64756008)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR15MB2317;H:SN6PR15MB2446.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UzCGLo/0+m57MxDTLdfi1A50qS77hbjezJ6371Ew2Mq4RIXa07ERIJKrx5HqO2xpSYpiegkOfW2LtSijscrCO1utJa3GpAu2di6E5IFfXjskW95or4cIkNkzsbirXO0cf8nByufP0hJcnyk3MknApv/qP17wTNNy5nlcGFQ+BXtGYBUC6oAnaoUxMXj//6MYsYOh1igJtTzSrTwWViDYVy9lZ4z+t7wA6U1gUs20ouxeah3TD/95Wnig64hlpK477OyaC6MZWSukDT9WJ/0fqmhBu8GqW5vu25Th3KaLgxrMg22SkIyL7WQepLPKUP6XaILtgBNSlUhUFzQfxACAByabN0HgyQIxB/AlJSMJ50FpsHfcb04XKtzeY0vLSdWq1tqJpeqVnWfkQZsj6gTW6aS9AUuln4PEOE1LyF38MBjLi1YhWvP9M/JFyCeJcbv3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d8deedea-350a-474e-0774-08d793b9c9ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2020 21:37:26.0595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rHBznA/YQuVQ246JU48SFdB15pKo5FnF2ibJTHloZRXTDGgnE9d7Dvng07BMlAou
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2317
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-07_07:2020-01-07,2020-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=917 mlxscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001070171
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7 Jan 2020, at 16:07, Dave Chinner wrote:

> IOWs, there are *lots* of 64bit inode numbers out there on XFS
> filesystems....

It's less likely in btrfs but +1 to all of Dave's comments.  I'm happy=20
to run a scan on machines in the fleet and see how many have 64 bit=20
inodes (either buttery or x-y), but it's going to be a lot.

-chris
