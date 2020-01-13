Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7FFE139841
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 19:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgAMSBE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 13:01:04 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46600 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728633AbgAMSBD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 13:01:03 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 00DHr9Xp015144;
        Mon, 13 Jan 2020 10:00:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=S8noNA3HH4KBOgOZ57Yns89d3C/LADlJzhiVXf8KWMM=;
 b=HC6ogb+dpHbdyhqY6aj7WCaVR4ikYPNu1u8XE5CBiApv2Ngs1G9aHYUtjbFyyyAfF/Qd
 yGdm8iC6wziRXdX9Jip2gUcAanHJds84FoMa3QUPrOoR69K2nEKqE46p7eVx6uwwySQs
 ZLJDvHb850g/yF7lA58wNFCxYAv//MBl8xM= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2xfawr9bps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 13 Jan 2020 10:00:55 -0800
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 13 Jan 2020 10:00:53 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 13 Jan 2020 10:00:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLY8d8ShYWi3caN2SBLP2xJ27wsRAP1e9p16niQO/ZoYiLGy4b5kSHXggiHRD9//FuHGu5TmB2OOzJz+01NITQL2X/G5lQWrbXiV9ht+gqfu5XLOjzR76sslc5c1oqZC4IAbQri7gcw4P/0JBUHbSXJSP5kd588Dey6XRNk/LSTKYlOyazh0Pqo2XCrYW+OHDkk+PpOUpYS+RSHDbgJTeZs32h8rMYxx8mwmHZ2GN7bCThw5NhLmFfi2sy9IX124DjptGrpi/tFnGGv5d0jWFpPXAZlRjp+qNHwWZv1+iSInMKGsFTsLSQLYVH3u/OFepiZKmVeTPOPjg/DH6lF0pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8noNA3HH4KBOgOZ57Yns89d3C/LADlJzhiVXf8KWMM=;
 b=aelgTNKUBskdsiCAci3nZzyO/gvMRNhztA6G/gmjzd21fNnsxJlGkJij93x6nzmSfX3dMt2fqA/WDM0L570Kd7w7gBEAbcdNwcj0kRVmoZIbzZTj3bfMnE0eU6tQNn0pZeReNAB9lXXS0Z8qEaFl0oVGsK/l5XbCCw/vIX53JgWEeuK7ClZgI2MEej4+cE4bAKDp19L8RajWR4PYZnbkG19q+C6JEVIjTIe84RY/0dqLAWzl31SiR9vCNdvhk8anrpp/2BXTxMci8m79uriuwqH9HWJWnJbGF2M0N25skoQebOvleRIN3B5m8NgHrPAMDU+bSNwVUSxTJezPzmsQJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8noNA3HH4KBOgOZ57Yns89d3C/LADlJzhiVXf8KWMM=;
 b=RyN2UJGzFJISB3qEhl//pvUKbtTk+y04xBocCP4D8xu7A1kS+xKxZI8a55G+MMMjVYWfRKhX0Dt1GH+0D9I6f949L2Do02r8x5DvNc1rVV/bUGafuk0iu1eosMCZDd65FUJGhZHrY0XKZeIBfQULktalMpg0fb+trMSv7KRnRgk=
Received: from SN6PR15MB2446.namprd15.prod.outlook.com (52.135.64.153) by
 SN6PR15MB2432.namprd15.prod.outlook.com (52.135.65.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Mon, 13 Jan 2020 18:00:52 +0000
Received: from SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::615e:4236:ddfa:3d10]) by SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::615e:4236:ddfa:3d10%6]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 18:00:52 +0000
Received: from [172.30.120.61] (2620:10d:c091:480::1025) by MN2PR14CA0024.namprd14.prod.outlook.com (2603:10b6:208:23e::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend Transport; Mon, 13 Jan 2020 18:00:51 +0000
From:   Chris Mason <clm@fb.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [RFC 0/8] Replacing the readpages a_op
Thread-Topic: [RFC 0/8] Replacing the readpages a_op
Thread-Index: AQHVyieJJr3DU4NMDUiHtIM35/TqzKfozHmAgAAQNgCAAAXGAA==
Date:   Mon, 13 Jan 2020 18:00:52 +0000
Message-ID: <15C84CC9-3196-441D-94DE-F3FD7AC364F0@fb.com>
References: <20200113153746.26654-1-willy@infradead.org>
 <6CA4CD96-0812-4261-8FF9-CD28AA2EC38A@fb.com>
 <20200113174008.GB332@bombadil.infradead.org>
In-Reply-To: <20200113174008.GB332@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.13.1r5671)
x-clientproxiedby: MN2PR14CA0024.namprd14.prod.outlook.com
 (2603:10b6:208:23e::29) To SN6PR15MB2446.namprd15.prod.outlook.com
 (2603:10b6:805:22::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:480::1025]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6752ab99-e401-4ffa-20dc-08d798528734
x-ms-traffictypediagnostic: SN6PR15MB2432:
x-microsoft-antispam-prvs: <SN6PR15MB2432D576856B5E6F5216B3CAD3350@SN6PR15MB2432.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(366004)(376002)(39860400002)(199004)(189003)(86362001)(4326008)(478600001)(5660300002)(81156014)(81166006)(8936002)(8676002)(36756003)(6486002)(33656002)(66946007)(66556008)(66446008)(66476007)(64756008)(6916009)(2906002)(53546011)(71200400001)(52116002)(2616005)(16526019)(186003)(54906003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR15MB2432;H:SN6PR15MB2446.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VyIuF3+r+sfLZiROhh2Fp4z0mJ8Bq/f+1+cg/aDGNYEufAoEpL9xjnJ7P0ZtLDKVLsXFHdrIw4YthkHg/v7DXkR8oM2/CdXe6FluazYMHjBdrMWbd209T9g//7hHkK5AapMHBnjZ+Po4lfhi+Nu0w1a1Em+RPJwiVu2shw2wkcqMnuNn30BY2oOY4egOWAuztHx9P+1gtCrgf4sXdkEHTE95PNNqrr6rN7lHuqAV7d98su5gCTNyxbFQMcMdkFx6EqRmD5wsxb+nlJyuE60sXXGVnYsdgixw12NNvoi6FlyGp6pPA7Gd4MqX2SXoDptPv2BehgE7zYodKjuporVjD1zZ/2dAsmTJESnv0G+5M7BfHgcq5xOoVcoyJYHScshZYIquvSuvL3B4GUjovqqaJZlJMrDFvCLivizeRcoDbQQd819dx5ieeTDMJQm79bII
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6752ab99-e401-4ffa-20dc-08d798528734
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 18:00:52.0944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RoINcDA8ItYwxe8LOScqcr+Jwub00lTLYkh0XUIDLxOnpccN5ZuS02ASO+p0Reot
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2432
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_06:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 clxscore=1015 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001130144
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13 Jan 2020, at 12:40, Matthew Wilcox wrote:

> On Mon, Jan 13, 2020 at 04:42:10PM +0000, Chris Mason wrote:
>
> I did do a couple of helpers for lists for iomap before deciding the
> whole thing was too painful.  I didn't look at btrfs until just now,=20
> but, um ...
>
> int extent_readpages(struct address_space *mapping, struct list_head=20
> *pages,
>                      unsigned nr_pages)
> ..
>         struct page *pagepool[16];
> ..
>         while (!list_empty(pages)) {
> ..
>                         list_del(&page->lru);
>                         if (add_to_page_cache_lru(page, mapping,=20
> page->index,
> ..
>                         pagepool[nr++] =3D page;
>
> you're basically doing exactly what i'm proposing to be the new=20
> interface!
> OK, you get one extra page per batch ;-P

This is true, I didn't explain that part well ;)  Depending on=20
compression etc we might end up poking the xarray inside the actual IO=20
functions, but the main difference is that btrfs is building a single=20
bio.  You're moving the plug so you'll merge into single bio, but I'd=20
rather build 2MB bios than merge them.

I guess it doesn't feel like enough of a win to justify the churn.  If=20
we find a way to do much larger pagevecs, I think this makes more sense.

-chris

