Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8952139691
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 17:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgAMQm0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 11:42:26 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:19240 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728674AbgAMQm0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:42:26 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00DGdWr4028926;
        Mon, 13 Jan 2020 08:42:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=KX6kiDiTrVCm8HNiZ4A950RNSNx04RzNKJneuFh3YEY=;
 b=QrrmfG+it6XPeMvLIBcJeAQJEa8IYsnE2zU8ZfmtE/h+UAqVO2hXG3spIawDY/ptpGnI
 ZarX5cI+DcNwd1Fh8qUOPSCZchQd9ApquUppDnDzmWxL3Mprk35hq0j8spJatLcRda3o
 ezoSMdOyE7pFbGXKd9lyiIB3g7xi2cvF/4E= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xfxy05a5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 Jan 2020 08:42:12 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 13 Jan 2020 08:42:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHetSzZYH5Lj+a69IG2h2Vngn1QP2PVjU2777fBzJUbm1+RXRrkkGuS3XpfTJp7o66y0qfQOA/x8Np1Ts8HNanfkcVHOOOsrCuuzfy4u78ij6UZMo9YlmWS9nA9bOZNCKCgIU98Ee2Rb9SnC4UPuvxR3cv2pBaykalhK705lHJi/PcN0pHcX79MyJvEEpRZMUDvfKOA01Fss7SPPpkgUTJt0CRDQA/M6nMSVdteWvCaeg3r8eESbB6xndO5sINjDgjjxQhemzisX/Z0vAnEsJGpHcYSE62wMDA9G/ECodrrLz9gvh/gBpOdmQTezPKGofbMUM7ECer2LvQpfrDAqDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KX6kiDiTrVCm8HNiZ4A950RNSNx04RzNKJneuFh3YEY=;
 b=jQRpZ3Q/j/1po4U9TlHPX2FBC6E8YRit+j2pDasoLyo/TNhN7PePMl39rd8WqXMxAXyvhQWiEGgloSfk/SqcXqBj0Q2xV/PWAB/Gok3eJTg01u1aG96jMappve7w7d5aN0P3AJ4K2iIp52xmnj2PicbZ1s1+J425EoA18CVNrpn0FZH7LatAbxlF/DPPZi+6tW2gnFEWAEWPt7YNg82uqduNvdqA+ZQGXwP0plXruDFU5xI42vDB8sZVpjejJGvGypiI8eeJHxg8TacZPAkLzbce7x5TImDlNVrQXMpwW25FPi07y/5/Be8LwgEVR3LRrZ6F5kHMp/JauGbpUHr68w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KX6kiDiTrVCm8HNiZ4A950RNSNx04RzNKJneuFh3YEY=;
 b=PGjQlWi+YiSFSxDfAp4cKXJ+YcfBlBBgxJxOy/NvvFhFo1ugaaoGyCmtj9cQIZqTiVjCeIaiuHuWHO1pATEni269Za8M5v1uzaQmRQVeR0zAv3muieuLMgzLqQ1fQxR2pUN/X1YRx+SsGOKgJPh1ZFm8J9Zx2eLCpooPPCUd99s=
Received: from SN6PR15MB2446.namprd15.prod.outlook.com (52.135.64.153) by
 SN6PR15MB2287.namprd15.prod.outlook.com (52.135.65.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Mon, 13 Jan 2020 16:42:10 +0000
Received: from SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::615e:4236:ddfa:3d10]) by SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::615e:4236:ddfa:3d10%6]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 16:42:10 +0000
Received: from [172.30.120.61] (2620:10d:c091:480::1025) by MN2PR05CA0066.namprd05.prod.outlook.com (2603:10b6:208:236::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.10 via Frontend Transport; Mon, 13 Jan 2020 16:42:09 +0000
From:   Chris Mason <clm@fb.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [RFC 0/8] Replacing the readpages a_op
Thread-Topic: [RFC 0/8] Replacing the readpages a_op
Thread-Index: AQHVyieJJr3DU4NMDUiHtIM35/TqzKfozHmA
Date:   Mon, 13 Jan 2020 16:42:10 +0000
Message-ID: <6CA4CD96-0812-4261-8FF9-CD28AA2EC38A@fb.com>
References: <20200113153746.26654-1-willy@infradead.org>
In-Reply-To: <20200113153746.26654-1-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.13.1r5671)
x-clientproxiedby: MN2PR05CA0066.namprd05.prod.outlook.com
 (2603:10b6:208:236::35) To SN6PR15MB2446.namprd15.prod.outlook.com
 (2603:10b6:805:22::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:480::1025]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c2bef0e-e80e-44f0-ec78-08d7984788f5
x-ms-traffictypediagnostic: SN6PR15MB2287:
x-microsoft-antispam-prvs: <SN6PR15MB22875E5D577B5467FCC7BE6ED3350@SN6PR15MB2287.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(366004)(136003)(396003)(189003)(199004)(53546011)(54906003)(16526019)(2906002)(36756003)(52116002)(6486002)(5660300002)(33656002)(316002)(186003)(8936002)(8676002)(478600001)(86362001)(66946007)(66476007)(71200400001)(64756008)(6666004)(66556008)(66446008)(81166006)(2616005)(6916009)(4326008)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR15MB2287;H:SN6PR15MB2446.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hwZGO/J+lp5+NbpRu30sGRimcuqsbrrEMwHvIYPFWRcWJoPOuAQd83YOAwMITkgQ6vq63tFTMBu4Odr1kctA7ifKMyQCPzcKKjyM6P1qjuy/DO3TjOEXN7pOvW5f4C+9tOpWGLJDOWxkkvVn5q36hgdB5oYv4KWo06hkoGnIOWieI59me5zdOFdlvwmS1r94qbsq5mJi3I045qfg6EMfzEZaRNO12criiT4obVhhn5mrjO/u8bJSDQnyf9sacc2/n6oXisCVLLB4VjQ2znu8buBo52jYCANQg8z5jpPW4h8495hFBaTCTzWgatwRfUrxRmMwGh5cTOP6Km3dLTO+ovRxTH7Top+kInPcsz6207F/ru7GIllScVMNne6x0QEksz9k9r6j1C67ZyXUJkbzO8+PopJRsycULeDx2DTkNjKkXESQUi5j4KHzgZfJeZrw
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2bef0e-e80e-44f0-ec78-08d7984788f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 16:42:10.5831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k08XblUDNKbGggEF2fIkP1109q+YQg98kb39qdB4fdmwYS79WUQs6+5CqLmJWKz3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2287
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_05:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1011 malwarescore=0 suspectscore=0 bulkscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001130139
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 13 Jan 2020, at 10:37, Matthew Wilcox wrote:

> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
> I think everybody hates the readpages API.  The fundamental problem=20
> with
> it is that it passes the pages to be read on a doubly linked list,=20
> using
> the ->lru list in the struct page.  That means the filesystems have to
> do the work of calling add_to_page_cache{,_lru,_locked}, and handling
> failures (because another task is also accessing that chunk of the=20
> file,
> and so it fails).
>
> This is an attempt to add a ->readahead op to replace ->readpages. =20
> I've
> converted two users, iomap/xfs and cifs.  The cifs conversion is=20
> lacking
> fscache support, and that's just because I didn't want to do that=20
> work;
> I don't believe there's anything fundamental to it.  But I wanted to=20
> do
> iomap because it is The Infrastructure Of The Future and cifs because=20
> it
> is the sole remaining user of add_to_page_cache_locked(), which=20
> enables
> the last two patches in the series.  By the way, that gives CIFS=20
> access
> to the workingset shadow infrastructure, which it had to ignore before
> because it couldn't put pages onto the lru list at the right time.

I've always kind of liked the compromise of sending the lists.  It's=20
really good at the common case and doesn't have massive problems when=20
things break down.   Just glancing through the patches, the old=20
readpages is called in bigger chunks, so for massive reads we can do=20
more effective readahead on metadata.  I don't think any of us actually=20
do, but we could.

With this new operation, our window is constant, and much smaller.

>
> The fundamental question is, how do we indicate to the implementation=20
> of
> ->readahead what pages to operate on?  I've gone with passing a=20
> pagevec.
> This has the obvious advantage that it's a data structure that already
> exists and is used within filemap for batches of pages.  I had to add=20
> a
> bit of new infrastructure to support iterating over the pages in the
> pagevec, but with that done, it's quite nice.
>
> I think the biggest problem is that the size of the pagevec is limited
> to 15 pages (60kB).  So that'll mean that if the readahead window=20
> bumps
> all the way up to 256kB, we may end up making 5 BIOs (and merging=20
> them)
> instead of one.  I'd kind of like to be able to allocate variable=20
> length
> pagevecs while allowing regular pagevecs to be allocated on the stack,
> but I can't figure out a way to do that.  eg this doesn't work:
>
> -       struct page *pages[PAGEVEC_SIZE];
> +       union {
> +               struct page *pages[PAGEVEC_SIZE];
> +               struct page *_pages[];
> +       }
>
> and if we just allocate them, useful and wonderful tools are going to
> point out when pages[16] is accessed that we've overstepped the end of
> the array.
>
> I have considered alternatives to the pagevec like just having the
> ->readahead implementation look up the pages in the i_pages XArray
> directly.  That didn't work out too well.
>

Btrfs basically does this now, honestly iomap isn't that far away. =20
Given how sensible iomap is for this, I'd rather see us pile into that=20
abstraction than try to pass pagevecs for large ranges.  Otherwise, if=20
the lists are awkward we can make some helpers to make it less error=20
prone?

-chris

