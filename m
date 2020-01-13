Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7EC8139CA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 23:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgAMWe2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 17:34:28 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62444 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726530AbgAMWe1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 17:34:27 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 00DMOYXW010687;
        Mon, 13 Jan 2020 14:34:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=eH/01cfhuhS91Q7Z4pl6FjRLfn15vCxcXLMH7VHrYyE=;
 b=onQsHNXwc645vaffPWY1H7bFHgJCnslaoYes8u0qzfze9Md2I6XIbnCI53VMjsLo/zoC
 i00FVut60A5/RM3yxTs2qJ3D97ByijOAdF7Ei4e7ljgICFHVU2qT0HnMSzVBejvfz3of
 DarbUgOs+A0qYz8y6ZrZs6BWmDmwnq6ls3U= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 2xfar4an2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 Jan 2020 14:34:19 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 13 Jan 2020 14:34:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPAj1dTOSOQmqC2ffDx8xPrpURPe82EWfa1wLuovlnnbVNSwzPR2//1AVPEI+NjtqDeA69B4FxwpaHj9JMR5q/GlWjDvqxiH2Lu1fCS1NoaA/0R/9yp2sFuNDnYUVbaFMeRAGR432CRnBj12PVSTjltDhDv9Cbqw7Bc+y87V5YCeUnnxc6TI6AIeqSmh1vaRawZxrSA9i42Qw7GvC7a5UndE57ZFcU1mAMGzMVYrgBk7/TMpzp5Dw6QWAS5TbqujtY91Xb7N7nSjOi9BQ9ffKFVedCu3pPm/Lo/q7oSzATqYyyrJSS8YAUoQ43KXHemLyZ7kkYdwMXfsFBMPzqiRrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eH/01cfhuhS91Q7Z4pl6FjRLfn15vCxcXLMH7VHrYyE=;
 b=K1hzOwzheOcYYV0CdRHqias5XyBp2Ylxz82ODzBtFlvMUa4iiVbf3BMcyOaVe5Gmh1DGtEsVGG4FujdOcu++MmgghUjbpg6YHPMJla6hjzbWvWKOPszIxjjgoaxGhdTEcdxUzuyz8xbJ8GygRTmLlzxclaLKW8dUHPdQQSTXx0pM8FzC8qZo/ztmRMj3DgUXsAo4mXZm4ZUaTZcIdBw+PA3Zk7V5eT1JmSifq68r0nH/ikmplRIeezSipLl6kfTZLKru00WeX7t+g91i0C2VrlXFzdBsi9JQgR7HS2gOinSagr/ARw8IOtZZKHioacqCA4x3TkwX7KgeCTJJtFnW/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eH/01cfhuhS91Q7Z4pl6FjRLfn15vCxcXLMH7VHrYyE=;
 b=ZhnPoH8dpcb4zYEESka2IKuxwbrxjt8A7VMERuQ36ZV7FkrXbnIfz6DCk+ZQN8hhQMiRGXqvs0796g1YIB7rJmnq77bk3Pfb5WdnVPSRlSKh3FtKIv375xQXHvQKGp2EnMPgfYtKEkbVYZechPeV46O16zc/O8dpsJVBbLGUEsE=
Received: from SN6PR15MB2446.namprd15.prod.outlook.com (52.135.64.153) by
 SN6PR15MB2463.namprd15.prod.outlook.com (52.132.123.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Mon, 13 Jan 2020 22:34:16 +0000
Received: from SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::615e:4236:ddfa:3d10]) by SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::615e:4236:ddfa:3d10%6]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 22:34:16 +0000
Received: from [172.30.120.61] (2620:10d:c091:480::1025) by MN2PR10CA0002.namprd10.prod.outlook.com (2603:10b6:208:120::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend Transport; Mon, 13 Jan 2020 22:34:15 +0000
From:   Chris Mason <clm@fb.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [RFC 0/8] Replacing the readpages a_op
Thread-Topic: [RFC 0/8] Replacing the readpages a_op
Thread-Index: AQHVyieJJr3DU4NMDUiHtIM35/TqzKfozHmAgAAQNgCAAAXGAIAAQlOAgAAAsgCAAALTgIAAAQUAgAADiACAAAIAgA==
Date:   Mon, 13 Jan 2020 22:34:16 +0000
Message-ID: <F1FD3E8B-AC7E-48AB-99CD-E5D8E71851EE@fb.com>
References: <20200113153746.26654-1-willy@infradead.org>
 <6CA4CD96-0812-4261-8FF9-CD28AA2EC38A@fb.com>
 <20200113174008.GB332@bombadil.infradead.org>
 <15C84CC9-3196-441D-94DE-F3FD7AC364F0@fb.com>
 <20200113215811.GA18216@bombadil.infradead.org>
 <910af281-4e2b-3e5d-5533-b5ceafd59665@kernel.dk>
 <20200113221047.GB18216@bombadil.infradead.org>
 <1b94e6b6-29dc-2e90-d1ca-982accd3758c@kernel.dk>
 <20200113222704.GC18216@bombadil.infradead.org>
In-Reply-To: <20200113222704.GC18216@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.13.1r5671)
x-clientproxiedby: MN2PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:208:120::15) To SN6PR15MB2446.namprd15.prod.outlook.com
 (2603:10b6:805:22::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:480::1025]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f431476-121f-4b03-d138-08d79878b8da
x-ms-traffictypediagnostic: SN6PR15MB2463:
x-microsoft-antispam-prvs: <SN6PR15MB24639D329A18D487DC4DC546D3350@SN6PR15MB2463.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(36756003)(86362001)(2906002)(478600001)(54906003)(2616005)(6486002)(316002)(33656002)(53546011)(186003)(5660300002)(16526019)(6916009)(4326008)(8676002)(66946007)(71200400001)(52116002)(81166006)(81156014)(66476007)(66556008)(64756008)(66446008)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR15MB2463;H:SN6PR15MB2446.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZNpZygRdkUhHknY8jzBz01HPqeuN1V5Qj7hqjpyCQ0qvXyUeTInIJMgHksn7QiZMwl4PuhIMEPiUq9PJFhbSO/KLzBz+ghXTrmz0KWze2vCiaZdBQ39PdznSq5nRqDj0QaG7WDm1L8EcxWPtJKMqj9K9tKE0xSUNVRdh43Xr86CHaDy7ey2CDA4zCa2x74gcaNk4ZREMcRAeA1mIIOQsTN7spsqs1/SRwgTyNc5ZzUE/RW2l3QMMG7tz4c+W0msz0SL6WAYip1eVs8+yiKNeze1Q2pjKTxM3eakl3jAVmmCc0whFcAytRivekLUHtggovWwOLuxGDpcxNR/B2g45dIKZov3ZEyYDcfDLblZkNH3NhZbwlvWdzLe/Dj9Sn+o2huolHxLq/wN7Id4JBLxKQzdBPGExPpWvDWx7r+zRpDbe5HDdgrnH15U+hYqhRm01
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f431476-121f-4b03-d138-08d79878b8da
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 22:34:16.2799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sdC5zUiGwJrzztFnzvaJlXq+VxtpBZ154YN7yYpg4elEcqzN98AMuQ2T65FlznYR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2463
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_07:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=677 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 spamscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001130183
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13 Jan 2020, at 17:27, Matthew Wilcox wrote:

> On Mon, Jan 13, 2020 at 03:14:26PM -0700, Jens Axboe wrote:
>> On 1/13/20 3:10 PM, Matthew Wilcox wrote:
>>> On Mon, Jan 13, 2020 at 03:00:40PM -0700, Jens Axboe wrote:
>>>> On 1/13/20 2:58 PM, Matthew Wilcox wrote:
>>>>> On Mon, Jan 13, 2020 at 06:00:52PM +0000, Chris Mason wrote:
>>>>>> This is true, I didn't explain that part well ;)  Depending on
>>>>>> compression etc we might end up poking the xarray inside the=20
>>>>>> actual IO
>>>>>> functions, but the main difference is that btrfs is building a=20
>>>>>> single
>>>>>> bio.  You're moving the plug so you'll merge into single bio, but=20
>>>>>> I'd
>>>>>> rather build 2MB bios than merge them.
>>>>>
>>>>> Why don't we store a bio pointer inside the plug?  You're=20
>>>>> opencoding that,
>>>>> iomap is opencoding that, and I bet there's a dozen other places=20
>>>>> where
>>>>> we pass a bio around.  Then blk_finish_plug can submit the bio.
>>>>
>>>> Plugs aren't necessarily a bio, they can be callbacks too.
>>>
>>> I'm thinking something as simple as this:
>>
>> It's a little odd imho, the plugging generally collect requests.=20
>> Sounds
>> what you're looking for is some plug owner private data, which just
>> happens to be a bio in this case?
>>
>> Is this over repeated calls to some IO generating helper? Would it be
>> more efficient if that helper could generate the full bio in one go,
>> instead of piecemeal?
>
> The issue is around ->readpages.  Take a look at how iomap_readpages
> works, for example.  We're under a plug (taken in mm/readahead.c),
> but we still go through the rigamarole of keeping a pointer to the bio
> in ctx.bio and passing ctx around so that we don't end up with many
> fragments which have to be recombined into a single bio at the end.
>
> I think what I want is a bio I can reach from current, somehow.  And=20
> the
> plug feels like a natural place to keep it because it's basically=20
> saying
> "I want to do lots of little IOs and have them combined".  The fact=20
> that
> the iomap code has a bio that it precombines fragments into suggests=20
> to
> me that the existing antifragmentation code in the plugging mechanism
> isn't good enough.  So let's make it better by storing a bio in the=20
> plug
> and then we can get rid of the bio in the iomap code.

Both btrfs and xfs do this, we have a bio that we pass around and build=20
and submit.  We both also do some gymnastics in writepages to avoid=20
waiting for the bios we've been building to finish while we're building=20
them.

I love the idea of the plug api having a way to hold that for us, but=20
sometimes we really are building the bios, and we don't want the plug to=20
let it go if we happen to schedule.

-chris
