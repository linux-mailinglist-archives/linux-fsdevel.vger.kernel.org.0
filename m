Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4300A2B8DA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 09:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgKSIhj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 03:37:39 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21559 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgKSIhi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 03:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605775058; x=1637311058;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=bzWzM8vZZH2t3xaoj4gjgqg/8uOFtSQWaQ/5QD7dzpKXa7CP9Uy1bQUw
   +7NwRj1xhWqKxLAKDfcl8Fj1F+poUuUohTIvNc6FJQuxRUtBlLX+y0Wyr
   VhO7GXPB5N5C/S4wa8u/PKFleptD4UQe1UOos6A8WrT6tlbdgg2j8gncu
   g3kqDM2uyeBB+PqgUXFR7cT7PBjtaufmGKeuCIm8F3mHUjA65N9dm+1iN
   m/Z8BKh2iio1VPH/oWAy93owFam0v5wF0fOJ42JcJ7go8UTKnEJbmTmXA
   07EiI5Koa4/waHvVlpWVOH7JsxeEAH9tcDK6+VrFsqUqSTorDNfnlq7Rd
   Q==;
IronPort-SDR: StdrIOMCYswRZg6jQ2lIawKj4Nb51SsYNOaUKn3yYM4pK8EmKRcYoe4YYh+hOReAxYVxjRQyD3
 zH2YHQ41lsKGs3R6Pqb88ZMyny80vimXpqMFaLq5SJmhDbcY87lJAH4mrboq+PWUYwxx7BSO0V
 r0JP/AZbiuYHtrWwMGTI+UsH0S0WOEYOXo7X22T6amLT/QB4izs34Moyfjiu5zCH5Xtak5PlhB
 FV08lz9n2XXzhhsm8NChZ1aoZy8V3KVHcty6N/Trw8XN0R4n6oHmb2sOfrkVfuOXMyc5CHWYRA
 GeA=
X-IronPort-AV: E=Sophos;i="5.77,490,1596470400"; 
   d="scan'208";a="157444416"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2020 16:37:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSUdLulXwC1rvWOimL1A7kY1LTHxVN7ZcGJiCwNlWczsNYGL+0u2rHK44wIUCHgxWkiccBMuheKFbRGYyUOktxuX6su76dOBAycwgXoDAX/gQ6geibQ2rr3TS74yCrqKCBKH3mGbrkMe5KjJdr81bPrlO3qHi5Kel50Q40QMoQu25Hw5NmbYz74xtre+sT/xhakQztZK80kG0Kux6ZupKFkRn5k/5G9c3mSihNYj2B9I5q2hEbM/2DPdBQtW0mZwCsXUKmVKHRLqSUGPH9O6GcVfKH+wrc1cTJwHCKqYwgCfe8/pkJyqWQt1vKMgbp45Z3yFwXaCHwato8Xm5AfcUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=F8wCY2Fpo50vnXWVzgyJZI5BgL6jPy5P148VhGErow4Y0vBR4GFRt9ZvrHuAsVOlfqhEAYEUoxDxq0iGcWIF6oYVJGJ/NShS32KODDWobErX6Oj3R0hbXGReJqpPCmT2UsAflN2YtLmLZeucflicgToN2EOXgW633PsIHZ9Nr6lyq6uGZ36Nx1azFD9O8db5IRWEDY4uUC/B6DEWxTn7mCzptvkRwJ5oXpec6kJ2z9uDHxPm9eO5eG0ZVn8DJwEmCOkYyaiEOzFlkO8g1wLxFkrg3Lmht8/CluGc16iTN6g3yVdROCVVzkFiO7sWlCxzV0in847V8WvLTy5KDZjxZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=jNc+dVQ7zDr8sGJ/6uqB0+7jh2yCdDXaulxVl+OyY8Valg02KDw9Ke6CW359CyIhDruFYHXYxNuKGJP3QX1m8jhLrInWG9zaEf4qRI867HbxiU3RvccV2R7RZEUhJBQwd2E+CXa4zGTmfu6db4M4D1mRpu67j6twXyfQP9sWs5o=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4862.namprd04.prod.outlook.com
 (2603:10b6:805:90::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Thu, 19 Nov
 2020 08:37:34 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.022; Thu, 19 Nov 2020
 08:37:34 +0000
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
Subject: Re: [PATCH 02/20] block: remove a duplicate __disk_get_part prototype
Thread-Topic: [PATCH 02/20] block: remove a duplicate __disk_get_part
 prototype
Thread-Index: AQHWvYfztpq6w/pFC02UtIWdUqy7dw==
Date:   Thu, 19 Nov 2020 08:37:34 +0000
Message-ID: <SN4PR0401MB3598F94B66D20E767C5AD4C29BE00@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201118084800.2339180-1-hch@lst.de>
 <20201118084800.2339180-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:157d:bf01:851e:5636:4e29:3e2e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 98cdfb1a-7b94-4350-579a-08d88c665d0b
x-ms-traffictypediagnostic: SN6PR04MB4862:
x-microsoft-antispam-prvs: <SN6PR04MB48628F2FA5D18715BA01A5D79BE00@SN6PR04MB4862.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9EU6zsu5wfqN3LzwpruHOA3vp8P7XrQotEGqEig19wHTBrjlE1ohLK+ynonRdF1W+UL5wUOVT7vKCtAIQt1dSmxkpZy4DwcLO44FjnTrjbNXSNUI9Mq5wH4rrR8XdBKih9KoY4v1it7GZ4WesFQhZZ5dBKUzP5pmgwnmt0WtD5bIKtK5htwauYpXl8TH4sg6j0HepHhcs7hep71FbRp4+8+nbJpt7IIBzHakBKpMSVoqQ8BhUxMKvxr4VZlyjthyXgTgH9RQ9rYR0A5fg+h6P3vM04AI1LUtG8AD6oJeYvLkuNL9IfWg1mZIXI71jhfByHqksAhEDVkCYrfz51ndNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(8936002)(71200400001)(19618925003)(4326008)(33656002)(7416002)(9686003)(55016002)(66946007)(76116006)(478600001)(66476007)(66446008)(64756008)(86362001)(54906003)(66556008)(91956017)(52536014)(558084003)(2906002)(186003)(8676002)(4270600006)(7696005)(316002)(6506007)(110136005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: csjjfoFZMdOUtjbQ7Aps9atodfrldZAbocrPpoPa9WuJ6wwSi7DnrL0jTbsl05umbEp5VVC+Yq+5KPyuvTo73nFFa0glxCUD3NqLFMLFCRmAqwzZ6jfwtuTOm1PGA+XNbnO2OBj5W8MgTuXPoSWugEuyBfyseXeerfvuPkcSGFyKN9wp3mddZY7FbFTQEBHdMb0j+HS7xJzjSmA7NBmmQwz5xyTPiYeoH2ga3rmicKdGPs+RkI0tc0bPk1q75G0FK3zd845mg1pA9gJoNCLF7sggrc7oZRshwwBzwahklVTj7UJRr8HiThJRCYgTVJwe9HSVhbVLjCB8fMTf1tFS01qJwvO7QRf5aiCsoSWY4BczKY+KevZvPRJeWcZKXZgWVP1fKakfbsuLMw0G7xu9h1+eOoypobiMkCp4KcJx4HXDIgJErir4uclycSdDgiCfNT58C8WSyGX/pqfKrXhFHSMjbg1zhQFlwLwmq+x4IVXunCLV+I/9vd/d1Xm1mZySuKEKxJX0X5kaxoc5ikUAsNXYZ2Qol7RsOAPY1XB2juhmbsYkVoEPCFliPFtr/McdEff0Y3lH9nbRLV2Fvx8F2elFq3wxIwNwKYRtzIEwafd8M5cLZt0SpoQl2w+Lc99wWYWrIchHiWf8tjaK1z0uxisWXgD48i7rr+9UZP7j5qsbKCrq/rkzjE9rrzRkXhzm8jX/DLvmDT+skKSPQRxSig==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98cdfb1a-7b94-4350-579a-08d88c665d0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 08:37:34.7562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YNE1HeeUNLBOJT8P2aBEjcGVvGD9E2iGPxFIV8+WaWcaSCFxON7IDGhjH0CQvhEpzGLK8RUwPduSaG/uVJ3gocebzXpV1camyawT1yPVJOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4862
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
