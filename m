Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448422C871A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 15:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgK3Otx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 09:49:53 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:42793 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgK3Otx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:49:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606747792; x=1638283792;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=CELEwvoNX05S8gUysa6LHaM44PGJc8NIeci7yIrFkEmcqFYfl+lyvsv7
   /Ly6uN5ptSGylW/WRRcefTyjdzRjZrzrjy5Mi9B7DjXHnV1cSkUBfoJEF
   MiAHCvYxUbqHO6frLtEua5SufM+s5lODyZVNXSG2cQuFKKit8tok0hC/Y
   h7F6VEgpdNMPCRJHHZxX3WIw7Wy7QkxWl3XJoajPiRX2gaebX3zW/rnpI
   PwqS0+CadLhUj2p/H+rw9acQ8YuqTq5Qq5tF3jMhJyXWn0WSyrC5N5Z2f
   ZbwE0vRMgLwilXJfVPsDR5QQRhb+Ke+jYwqZxjNza6IfNxpV4SlMfHOsO
   A==;
IronPort-SDR: xOd4TISK0xkluetCHDmoXul/qXbd9ci7S++BduhAyfKDZIfV/bULuI5viOlu8xQNbM7m6y1rV/
 g5IOae/WJA7wvxtB5wFfuHBfZYM/1C2fMaiAwJHAl39hvyMjxo34XSRySx+NzayoSZs/3Oc396
 u29ZyyHvF3/eljbybUyBHW+3boRbFhrUqa22woR4FS1xQpeOuMw2C4hJgJQ7N93Fec5FPXu76X
 e9SknR2ij9oPY0uq3aR4wxrCMQ8wWIXynjHBS5wIQ2326EI0lTXQRr+80xZVX8tarM/RjRiFMx
 83w=
X-IronPort-AV: E=Sophos;i="5.78,381,1599494400"; 
   d="scan'208";a="158284639"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 22:48:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wn9TnewnrluFh3kH9DopTHD6Llt/ganVEKmE6K1pbwwQi7FDBR/nQDM03tby5gHpVsULt2kSUEogkqcj3VE0JGbIbgXfVFm3NH2KXs87+ue4fHDSRc0x1zWKlPS8DUABTOqZImfqgu+wglTOQHnGjQ66j6DqrtR7kyvRV1IVpbElITBkzNjuqonTBz5IiSwzy+GwPdtISv8MNIlY6pGj/86uaoDIczi2YuNQI9MTP2A7zkt4uFls/r98p4imL7qNQb/f4OtTvQRXqfmaF506CGlldFjci6NHjZIc5nEHaGDBr1PI3MXnzPLGQST3qt1atsvdtCgJvgVVC4/V4OfRjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=T2iqvEC8C3jYYc+1pGWYHuTfjHOD/9lrHmB1bUiL7jJccyQX3QnvjjTrEPSjWfp80OlHR1+/2vWj/aoGK8lFuF0KNjCDP4gQq1GGMVxwYz3T0d4FMAit9nr6aCyQ2pxBX8GRR/DJQaUYYg++888A0bXNtpuXPIFEBg+p/t6mQJlLDSsskg6hsIZzMXeFza02l5CTKRkY4oGo55fkTsfLwU6PlCBvB3obaAaUU4O3K0z6YzKkXEC5jeuDa8gbcR2A6xLqhDMYy4xTPHuBXOXqZn/ciNvWve2tYkc0dxxkIPlIocTzXkUkKeldiJLwFFKa1XLHEVZgRrOFovGJN9ZzAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=UogFxH5lW2LdDyHx8BfFQ7N3oNPLB+hrPJv9V4g5ANuOlNti4XJtMUHJZFAqP2P6la64FPr1DL3VAxbkjvfZsf8KdIZbZ+RCncgeCeEeQF16MZMd/6w+XcAyoJp/NeL1QobJjgHVAggQkH3RtUlNbeqLQWF+Nx0UoP9DwYLmpvU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3806.namprd04.prod.outlook.com
 (2603:10b6:805:45::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Mon, 30 Nov
 2020 14:48:44 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.030; Mon, 30 Nov 2020
 14:48:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Jan Kara <jack@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 05/45] mtip32xx: remove the call to fsync_bdev on removal
Thread-Topic: [PATCH 05/45] mtip32xx: remove the call to fsync_bdev on removal
Thread-Index: AQHWxaGxT8+Usa97aEe5UPCvoZEeqQ==
Date:   Mon, 30 Nov 2020 14:48:44 +0000
Message-ID: <SN4PR0401MB3598265AEE37FB55D39777059BF50@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201128161510.347752-1-hch@lst.de>
 <20201128161510.347752-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:155d:1001:2c26:fc00:7c60:29b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6ee66a8b-a964-4692-8602-08d8953f0970
x-ms-traffictypediagnostic: SN6PR04MB3806:
x-microsoft-antispam-prvs: <SN6PR04MB3806EEA9EB07753AB05433329BF50@SN6PR04MB3806.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YYEnQg9+rRwNqREHJxXJqv0YR8OMwXqdvCNqP0KA8lM3bd2mv8L4UgT7YIWPwsATlsO1RziAGXXGfmMn4LB+ns95+ZmTHdZN3LXt4nEF3v5bTn3jKz3yFYr5ufb0saUsj8IeTrUkltS1NEEMgru2Zn/bOK7pGx6jd3E/1La7wxamgbLP0aoOV0sh9S6ogMlOuIWLgNTF9SK5bJMinSQHTV+fXFkS7chHpr5vsboB5EzRAS3DGgvBhFb7XXkY0mMXP6+PV/K/A8z6LlC2CC0tMCjjJ1Yp3zaOKvTrh9HbAPYv0TG/Kh0hHIWfGPMgOCg0Z0czZRSV2M59eN81jRzCgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(76116006)(66446008)(186003)(9686003)(66946007)(91956017)(478600001)(4270600006)(86362001)(66476007)(64756008)(8676002)(7696005)(66556008)(558084003)(6506007)(19618925003)(7416002)(71200400001)(316002)(54906003)(4326008)(5660300002)(110136005)(52536014)(8936002)(33656002)(2906002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?iDV/pu0QM/HGipyCo5NK7O00i73fYHoiviAp96W6No+bNZ2l08ndTrXVuybo?=
 =?us-ascii?Q?4vB4Jh2bA8yK9gXlu2u8q/5RRkSx0nw4fC0Y8CdBwnAdC1qP+g08yd7/W/Fz?=
 =?us-ascii?Q?VdbVs8IRpVCGsvDuNoSsZoV4vrQpm8pUcIsyga9WlIGdpJSYOiZ5XYmYNT1n?=
 =?us-ascii?Q?H0xSSUR8Xud5sB3UX3MeE0dbHcxjo7zPYYG+x9QT9OHXoAm9HE0sBQyZ4x7V?=
 =?us-ascii?Q?kVMcRLK3WgU+tg0y5UhmtNJKwg80wYq9doKTN+9/9hkJGW3ye6sEBb2Prf/t?=
 =?us-ascii?Q?ShOhZWpHxWHs/vzIIGCgbU7wZ3hU+abehy4Wn8fHcBgC5m9rvSBVmNrHNOgv?=
 =?us-ascii?Q?1L+W6Ge0rA8nAyMWbsBYvS4asTH8S12Kw0Pz0i/WCZqnmqop1wHRje7DSTQg?=
 =?us-ascii?Q?UwxYR9yGcoPnqpQiP9aSYGIzvIwf2GGW38cuh6Gcf5RrUEpAqRgdrElt5K/D?=
 =?us-ascii?Q?AQrz6EptBfTzYPUEN1rXXUKh6W1im+krS61em26SsvgPuRH8I3V3PBmeznxi?=
 =?us-ascii?Q?+RexCFQ3rONS/wzzo9LeDJBssHSoKbeJ8oKloCN28LwoQimN3QMg7oQli1Rf?=
 =?us-ascii?Q?khcDYqD27mTY2xs01IQaW6EIVUuMnYf2ppIHTLqTVVBamJQ/j0kflOjOHvC4?=
 =?us-ascii?Q?pvlDFWNEpLMigr6ELMp1mARrdpA90IVUdy8ejE3Pg5AjU2gkz91HWsqgTigJ?=
 =?us-ascii?Q?qQCzskf/tOSUH32Um2APNpoOZt4GHq7iqUvGi9FtqaeApQ0vb/YX4jWXT3xA?=
 =?us-ascii?Q?SUSgEkHbw9wKUKvafjVKoPlfAiIOGgwR9NlEBAsG7sH0zdIi2pWNxXcthmkl?=
 =?us-ascii?Q?5o2JVMnPKkcvWUBZ6f+xHVZpG5yyljpNL0GJ4rArPHr+7DaGO5EGwS9ZOMjs?=
 =?us-ascii?Q?/IIGxq4T9gSjhU7ephl4d0ha3OmtubcTLK5F0/hYt3a2ZZy2kYISL7k47Gf6?=
 =?us-ascii?Q?oGLXYOv5inwZJ51i23BMFG0MHUsYLwQZMrjSQJXW21Q4hkf91RxDT6lh0pQX?=
 =?us-ascii?Q?fSAbUgayRfwkOBwoguzW/IeeihYw39z0FW+Xb20+1ubFNCV6g/eMNfmI0EuR?=
 =?us-ascii?Q?JqS3UQhE?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee66a8b-a964-4692-8602-08d8953f0970
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 14:48:44.5903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6CiBuFFF80WtmgoR0vxg0tLdYT+qLns7rM73q201cdgGr8C94Rzgi/ledjm6yjpcgSwFtZHu/TDm9JavMXDTieIUI9Es6CJ4iRaM2zDsDok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3806
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
