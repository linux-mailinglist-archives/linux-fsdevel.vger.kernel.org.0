Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9902B8D9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 09:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgKSIh2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 03:37:28 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21532 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgKSIh1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 03:37:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605775047; x=1637311047;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=qwWgM6K0uJoVB1LRej40epvPoc5cbfSF+Gq02mY7FXUGmQcXxe4F2epp
   lhQgWZUcP8VmudpUPTpkbOOcA97eG1JIkMNBe+ER0pgWBy/NdT4McPNRV
   lffU48iUsZIzdAdi7xkeuINbaDZS2ZPZnmft7jNEVl8ExFiZnMLiF1i8Q
   TPHAhebbxAGw/Ar4xIypSeyfQdT9g/NtPWVl/P2GzBm+ibolGNB/DKzN/
   m3pfk058/A22D9VDeK9GpqzLZa06IrBwsWzQk1DggsdhBNBHOdRnh3H/x
   kT8bOSW1DAf0vHJQsEGAng+BBpktL39o0jwgsbaZG9pXRpljiTAIjP8H8
   A==;
IronPort-SDR: FXHMCoLsL15+6sOwsJozXMQJ0lALrvI9IL+x+X2crG8/8GPNV5d8ilPUqFgxW3gQzlhCytqPP4
 paw07kWj2A30i4ystN53Nca96hHQVSsXNcoNTP7aTftKoZ99Gd1YF4N69ehve0pCXV/k5NpiCR
 qESF5OKAiESW1N0VJ2wq8o/3niQ+xq+YTcTCbF9iRJnI1JyT5z+bmmZ/PaHxT7f/GbFyQMrjXr
 C1JWLH9LcuytFZOUzKnP8rtzGwFLAsR4HE/xDD2vDjgIlJH3A8hHy5SJ/ocz2e0PiKH0fRzs0E
 3HU=
X-IronPort-AV: E=Sophos;i="5.77,490,1596470400"; 
   d="scan'208";a="157444401"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2020 16:37:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cwh67RBgDM1TGPulSTbs6OaFFP71hroH8XuB0QNOJ/2DdfrHW7OfmV1LMs0+ReUQSaO5F67Js2vBtmUS1e+byxSG+G1Nm/Zkpp+nt9W4tIMZoAy4TXLGZDzKdjwSNoItL49P9KaX0TqGLTFVWxH74DmbwQqkT1DhIOmM1+sl8nIKZBrv+MPs60DwYKUw5vx7x8gK6u4r22pdf5LsRB/x2IAO3HpnPHVRCMeh27sE3R44BLSphaRMRSxEJyaoJVpcWPxNUxSEPwNpI1AhoMxv2InMqMX0VKB0uMs5F4ptEe+X5tZskk0hMJpvjjrILQWciRerQaum44WhXnmxc64vvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Xhidqf0qyfeWRGQf6Nu4FQjtF41S646jjL5tLscc2DALDxb8nHpXh8s9mG30wg24m+ycoDPRM5FJdG+/5M/IA3PzOB3zRVnLdEDZojBWLClemCI5/8Hqcr36LJAmnVKMKd5ZMCE+ogAKwzOoCpPY/qFIDnsRHPxmL30vT6CpAWq3Bb77EKdcgPTed0G/9eeDD9mCRCfXd3O1WYNClkLF4MIkVwKwuYY/EiyTF/MAGwYwqXRt1vgGQzU6q8Qq7iD+WM89eqeFD0vop0fI43k4UXQ1wi2BEWuSzai9Vd5PQrW4wJoA9jcbUxvPncjgqTTtQ76I+kIdlCIo0RHcfFV2AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=L3hMC8CD7T6O7J97RrSMtA6qCaK4Aqk485OGiHROjriaEr3sB07xrQPcXf4ytiVnC6edePuayQx18+sb4HM0p0dxItuEVhAZ+Cpq9qGon+RoQ6W7LcBfnGRI+mBHDJK6jHla57abhhOgS6q09FQkgpkNUtKwgYGCGwGucJAT+kw=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4862.namprd04.prod.outlook.com
 (2603:10b6:805:90::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Thu, 19 Nov
 2020 08:37:23 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.022; Thu, 19 Nov 2020
 08:37:23 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 01/20] blk-cgroup: fix a hd_struct leak in
 blkcg_fill_root_iostats
Thread-Topic: [PATCH 01/20] blk-cgroup: fix a hd_struct leak in
 blkcg_fill_root_iostats
Thread-Index: AQHWvYfzdYP5XcxCwU2lKCcMriBnrQ==
Date:   Thu, 19 Nov 2020 08:37:23 +0000
Message-ID: <SN4PR0401MB3598AE3DBBB56E8B42A7D3EA9BE00@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201118084800.2339180-1-hch@lst.de>
 <20201118084800.2339180-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:157d:bf01:851e:5636:4e29:3e2e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d27a3179-29b9-4f23-a2f8-08d88c66568c
x-ms-traffictypediagnostic: SN6PR04MB4862:
x-microsoft-antispam-prvs: <SN6PR04MB48624BDF06CA1E8797D237529BE00@SN6PR04MB4862.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9WlGvL18XbMQQNFB0M4ZbO6snyh/Q5KyvC7OP0/lbAug3R7W9b/3WrXCPlPHusAEvbr7rUJOMGI5xkXkMdl0amoEa38m/hpSf9WFwoF7GlqD4ZBs9vuqNRr4/1SBJwubKx9V9miJOQ34pnqIIjv1D3dNQOJYWQNh98QVZN7hLTnYCwjcNEawLQjJ2sddSVJK72A1WBVPZfAIRSRFVBh6Mou3Mo5+XSmuRvjIpyisKnKXzbJqJfklEMhdvT9AnAcesxr0v7Csc8ei8AjpWVtX31QFHtm0Frg530vHx24TtdNgJti9bH/+Y9qLzq58fZZMJ5XxYEGm4Jfr1wT3FvCU2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(8936002)(71200400001)(19618925003)(4326008)(33656002)(7416002)(9686003)(55016002)(66946007)(76116006)(478600001)(66476007)(66446008)(64756008)(86362001)(54906003)(66556008)(91956017)(52536014)(558084003)(2906002)(186003)(8676002)(4270600006)(7696005)(316002)(6506007)(110136005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: tdPYLl1Uv/jCJ+EAJnAzELPE9akpP6mmhvdZT1DlIVbDKnuJkGXzCF6JzYdIl55o5O8VmvUWtGz1PdeDxN63eGmpkxnMVdYAJZCg68XjlpVFb4yhvuL4b4ljwDtlpdbLp32E7gZ71kZ6HIopAY2Q/uP7fSfiYYIT6grFyeiln4UJtvyqkDCHftFj+ysG0U6pKCLKnt2TTZV6JHfeFmDsdnTo+sDs1bSqediaXwJ1vDFOMpWL/zxJ05sP6wnPnQCWT2uRsV8QVz25z22pcM2Ou+ket8IajLVBn1ygPdoeqRLbyIxNK5kCdbh6p22vqv2Uy1BD1e2zJwxYpfA45Nj/ahCPEIN5/Q7am7t2DEn2BIJBZiu3kD29D/htv+Tq5u/N8xvM/2b3DQnnfOh5vwT1jwVjZHGznAUc6e2GXVIjCD7wLv9cvTGnU+CC2/fYCJKXTk6rpEM1VWmEUjhid9+NnZ+CwceDWkA1dyr29vEAYCXR77z55xCB2Hsp7wKIYZXRS+ja9Ngu3+UQPxX3DOxA7vv89/BDx9e/kP6xy7P/E5tORlLCGUHiASz8MKmUrClzeBzeGqbS/h3se1SoZjYydGEFHGmGNwNvdgUkUw3DUIeBmAVcyypTU55UezXMwUdWczjtNsIddu4ZL3a0TYGWSF8OuSximTRkbz42iRaMrRtKPM0gIRAKmgXA6e1NXCktrhMEbHklHouJTXXqKaASwQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27a3179-29b9-4f23-a2f8-08d88c66568c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 08:37:23.7916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /WcEokteTN/qdeIKSXHmL80DipE1H5Rz0S33tmNFVvpxBLt6BgRhEshpIUzrG0YnkplWFQTwOiFnV93VTrI8SLTWYoxkpWQRjyQgnsyJSvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4862
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
