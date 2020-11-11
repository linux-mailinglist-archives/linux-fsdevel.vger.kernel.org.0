Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645EA2AE9A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 08:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgKKHVI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 02:21:08 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:13195 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgKKHUc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605079593; x=1636615593;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1sDZyj19cP44VH/yNnKbkvTJ8VhHa6ySSOKr0so+YRo=;
  b=dJo0RFS3gX8AVif34hRBQ48RVD92c/mzv/kH05Ypi1+iyJXVMzwqQ6SD
   CUd3s3uxNclG6r4wnZ9ihi6nbGZw6hP8FJB6CKfwT0OKyQf4iY2zFIWWV
   A1Ehh8nGz4Z1IF37R5K/pV3yrGhO1z5oqN8BXSRlId+93CBcSzuURf98o
   mAAixnmdP5fml/Da4lea+3Tj8iz2gFBFEdvUmzAvvikyjgMsOTRdPHaJK
   gTLDa1+UIPBjB+PnVyQ6jiTUAzDlEh9XRXi279TXFyJza7OXnmEU16Hey
   cSG0f/bV8UHa8314aequMCTLjMoO+kG9QDqpT9iUKNO3RoUhHgDkkbZ2L
   A==;
IronPort-SDR: X4KV2bk22lUNZyuYJvr7otqDZsDOClyslTTD8sINo/dTY9dbGhNlu6WuTSZhLZ3XDop0jJ/OtE
 2U9K9+XHWq9fedQ6y0mNK+uqaKj/h7+DC/Zb1AJEZpZ20AMjFPeqaJfJIM+6TdMFi05Cmpr1JH
 QJkpZO9aBEyE2leOe2Jgi1GKIw+BKSTU7lEkCXZz6EQ3fySaGAKojHDYr+5dyGljDXDYJ5TsJp
 q3bIQUGqXTanBDrfbKljjrhBA3e9Z6HD75N9eH60y5zKsumdOrrrNP53HTj63FqtCX/YkaLKR8
 ckE=
X-IronPort-AV: E=Sophos;i="5.77,468,1596470400"; 
   d="scan'208";a="255924590"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 15:26:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHophaY4L6xHEMsJ1vDE0I5dMSW3a9JLBBgrm7c8pd9VnPgFxaKSONouRjqsNqOzobilla7CSM0GSupJCSOF0ybsY3hZV/f4mcsY85NBmyRPhf5CPASLMnJ7RQJ7TN8DWPHJd10MwXMpdiQJXe65fhBgdQOX33p8Km0G7niGRU0BTdxigMMxHxPOcZjirzbX+i7y04mR4EweOnzFxNoVNwI+iru0PxtAugUXHdA82VrzHuTsIjLo0ModAuE+xsJnZAfuPR8pOLsSiDqr8xqBApMdLbY76mSeWPu99vuJfC7PStHbjEo5SxRrzrxenUt3php+O5TX729vsQE6ejNCoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1eS0a+PAiO2ORkti5Fv9SgneHcy4HIIpMw3xmhdmw0=;
 b=aSnV0dWvnT3MqKaLDPqbYWhV37xepDqsssVyHm26mHFcrGdWNqFqNC0j8JhXRWcQd2fIoIFZResZajmrueqImMWLJKvvSXmC9WFnqnW4+8rIflLpkS6Xjdsa6zF0FbHi5RtGTlXXbI/OTUSyAwqUyVEoWTv238uMqC7dNinUtrA/dg9y1njfjgu8r5EebtLhQyJXgFc8yNlf+1PM1KOuvhk2FnPD1ShaLnwqhLkf6zp/HdZoKMKUC63qnJH7uCY8V315zcUAfEXsTX4j2oux2m0sRFhldznbr4h14mmmsFYFv/hsxKXeQkvXxcXyDKtu5c8Swd0m6CIAXXlKHC7i5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1eS0a+PAiO2ORkti5Fv9SgneHcy4HIIpMw3xmhdmw0=;
 b=t0+5r4SMQGHv7qpD0BBYbC9gEmtUEPaaJPONG4x34yF81q2bApCgTmXDv5Ic1jx9Z1u5ivZ1/RyCQtx1zh4DWpP84j9LlPUATgGUManF1LJTdd0N6tqCzR1dnAJ8RimpPQ3BWKtz2tQwlQn6Vs7QVDBmiH1Gr/iJSyVpZD7PYvE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4606.namprd04.prod.outlook.com
 (2603:10b6:805:ac::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Wed, 11 Nov
 2020 07:20:30 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 07:20:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v10 01/41] block: add bio_add_zone_append_page
Thread-Topic: [PATCH v10 01/41] block: add bio_add_zone_append_page
Thread-Index: AQHWt1STQQocqSLtkEKFkjEKQO/kxw==
Date:   Wed, 11 Nov 2020 07:20:30 +0000
Message-ID: <SN4PR0401MB3598D13CE8E445E4588DEB7D9BE80@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <01fbaba7b2f2404489b5779e1719ebf3d062aadc.1605007036.git.naohiro.aota@wdc.com>
 <20201110172023.GA22758@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c82dfedc-378d-4533-ea61-08d88612454c
x-ms-traffictypediagnostic: SN6PR04MB4606:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB46064873EFD524DAFCA6402D9BE80@SN6PR04MB4606.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GmDyNBCznr8j8nZKvS1SpHI5q3yQSgCrf9/bgQJ4+nFqw3d5vSug9MsCI8tb7iEejUrObpnnbCPJUGsSb+m/NUVsI2O4YeO/Zuwd/yOnv5CBFnerlrdheMRY34Hw+6XMTffzpGutb7CZ7rPB64dfuLvoTyo65hSQzWAEU1j5MQ2A214VntdSwKRgIXliujDjAs4T9KDhmdMul7oSVBD+80u42NzL+tNgidzl7Uxgzk8PsvBfcjX/HN5dJX1YFF/Gs59+g2xFG0zn4e92EqKynqdcBIRm3+VGBgSRWGCNI7bYh6vG3rDhtfmgAq0IY/5DwFVYa6+lr37hmrAPI9P8EA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(52536014)(66446008)(110136005)(66476007)(64756008)(316002)(9686003)(5660300002)(86362001)(6506007)(53546011)(71200400001)(26005)(8676002)(66946007)(54906003)(6636002)(76116006)(186003)(55016002)(91956017)(478600001)(2906002)(8936002)(7696005)(33656002)(66556008)(558084003)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: dpkVjv+cV/FmKjKPQh1nbHwENyN5lhUfQxEq9A68CMtHwoFPrhrwsnsEpj9Qqfep1hsVA0J8hd8tJVzK+3/F8mLhjNFH/kM8qH8YdEwhsvRn/B4Kj0g3M9oqA+pg6DQFvctpuVGe6NOeckdunm+rNtNNlVE30annweVU7Z+80v0PVic8mpMmQkhbs1Jgc1pP01h/h3pyHLWxPCS7kGxV4a0NpeZ0st9W1ReBp+KsmAu979cLcV6oatHFi0lsUzAh8q6lzXOFcuvP3DYx5xK7tFzuW3WBvrdtwqv8HX0GZmRRSfC3ncT8gFMhE5pZv8DJZLWTzJtElYLcZYOHHKxX/wC14neXMornuoWIXppQxnHtfJnCdxmXbep2z4jh8sFCs9+Vj+nPFXobvZDKf56jA5qtCMQmehY3M1tOWLzGPZvyEzsrfEZODAXDOBgPBYVVkvGsLbfeWufF7zJzyBexYKJ62ZlkX5mycswsDAe2YFxSLibeNveVYyKzOBl+DyoBhJTtaaqCiP4jGpC68Rd6U+Ngq0L1UZEz3yPJrfAHR9BUo1Em2YK4AyTSG9tUrjY+jmpEOhLdATo+RS0mLqwyPcBEXE96rnNEmU/Ju3qPfWKv0vE49v+jPMXWifFPiKMTQhiu6g3Lz74W6P/waK7c1A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c82dfedc-378d-4533-ea61-08d88612454c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 07:20:30.1455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3X+7o5T4MRrOvIsYg3EJThIvJtcVYXv7n5nrsc5lPe7vbWpSry281FLEa3QqNSWnRNlzIhRYD3okGySRJH8m1m/mpP8xB1dhTNDo6Iku26k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4606
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/11/2020 18:20, Christoph Hellwig wrote:=0A=
> Do we need this check?  I'd rather just initialize q at declaration time=
=0A=
> and let the NULL pointer deref be the obvious sign for a grave=0A=
> programming error..=0A=
=0A=
I wanted to be a bit more gentle, but I don't mind the other way around=0A=
as well.=0A=
