Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6065D364FE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 03:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhDTBf5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 21:35:57 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:42432 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhDTBf4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 21:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618882526; x=1650418526;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1RBe2ZodpWE+zI5BEcX4tGpmZyQrkrsJK9u8r1d97T4=;
  b=O7dEXXYH1E8H/U9Svn2NA4Lfo4xbCyBhrUyzLlOqLIoj/gqXxF/9huff
   /TdWj3aW1neMNMwHaJ7ZNhYML4nKtLudLY9gzUUolX2nkEfOPNqPyJARE
   al0fvjGdJGlVQ4R2UXVBHDnKPtSXF2ilv4aP1UNKKcI3k9khquytZC7mZ
   f/CHoKMsfJVHL3uwTKsupKjN32oiAngSKukcnfhgPaZDpQII9kjRNEDlN
   kQbK6I8xKQn/XSrUXEFwVFbZr9w/tdAS4r8VobF/D3soLloKLEAX7zOur
   WMXLN5GQdfaBgGgv9TeLeQqNgGbMSLzNV+AI4xmK/Yl0A6RAGopLkZY6I
   Q==;
IronPort-SDR: lq3hOnSjbfl602vcd8q1ccLg6lvVv6Y6lWpbiymUa/mgilnlv94PMoN9UJz+N198SI5jRWZjty
 P52rfab5tPiqVVqT+/8Un6aGsMHVD3C/kukTj4TM0gSwOw0YtfG/HmRgmnIE0GIyikOyw7dZ80
 zZDvUWKJbajZFgVVFbWauI9cZkTL+hcNfygpL8Ch6VIZoKqtCmPpSqeVD5rqEQz6Gc1LNY/UxO
 gg9u3yz5uennl4V9UVFz/6YIEO71LT2UcfQJtej8PpMHCeb3PwNPQ3uZxBHeeEzpfL+w7LX2pw
 nGc=
X-IronPort-AV: E=Sophos;i="5.82,235,1613404800"; 
   d="scan'208";a="164838428"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2021 09:35:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+Kzfh1v2OZTgTEySx3mQkGb4w0IaHRXRYmQ7uxrL3ntNv/Vep1NVtKVi1a2uUyT812PIWFuhykmRYsPyYyoEqeKS/UYnN718/bT04wsc9BZ/8gTh1AFHCRII6T+FCcwABfDlkTALSMmoixeyzCbVeWppnem6lIliscbo0PmJn6ZPK8S1XTrBJJ5UBztghF/B4zSZmtF7UUXlsLNb5Xr0ZmQXQ35UgTD3DC/BqVs0RW7uPkciiOhdabN/pyY16HArp1ihNc0C4Xtnf0rlywl4mgl/YPVNx/5YMeIpGi6JOh9WDgMffga71+xMQitv8SSdPZ6ywXbSVM40/1YtKmp4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RBe2ZodpWE+zI5BEcX4tGpmZyQrkrsJK9u8r1d97T4=;
 b=EaVay++TpC/4EkiZkfh1JMTdW9ZtpoSiYChwrjPtCwupb0pLc0iNgcGUaxXjwiKDNB9vUHo3b7ILHAFoxFQkrLH60LP4EOoBNlpbBJ9i9k7EPFv2cgLoAPB2L5WM+2zB8LW2oY+78TmBjBwRhD/gHc4D85KvLrWmNdrIB3DITILDKwJ8UB0WHwuCir5XP1AqPxhJbBzodU9UUIiiZaRb2IzzYKM5mG1sAyH8RhKnYVhkpoNMj5/iiDJgDoZPcwrviwsyfCe41oRnrujXYOb/Twk/P2KpDvQXWW/VhUMDMF1oR+hvWnaU/3u2Z/jFHdmyamY47z83mSSpykBgMcpU+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RBe2ZodpWE+zI5BEcX4tGpmZyQrkrsJK9u8r1d97T4=;
 b=mjXaWre2sQ9Ra3MoUAL4NwWfkcqymuI0sbZFcfQ6eodjplrFQrkNl1OWS9DXN/VkfXGefvs8AuBp8NArNov2X3dXbc0oa108Mi1FVSE4QNPvNDkd1p7ElHfqrvlShsD7XtcZ44F6MFCmatBUcgVOK/EJvWCJbLXatnaloyUVpNM=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB7008.namprd04.prod.outlook.com (2603:10b6:208:1ed::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21; Tue, 20 Apr
 2021 01:35:22 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78%3]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 01:35:22 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "dgilbert@interlog.com" <dgilbert@interlog.com>,
        Christoph Hellwig <hch@lst.de>
CC:     "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v2 3/3] zonefs: fix synchronous write to sequential zone
 files
Thread-Topic: [PATCH v2 3/3] zonefs: fix synchronous write to sequential zone
 files
Thread-Index: AQHXMzIUD8ZVvai2c0OhPeRaKpo++w==
Date:   Tue, 20 Apr 2021 01:35:21 +0000
Message-ID: <BL0PR04MB651451976F15C55D5578C131E7489@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210417023323.852530-1-damien.lemoal@wdc.com>
 <20210417023323.852530-4-damien.lemoal@wdc.com>
 <20210419064529.GA19041@lst.de>
 <9a4d5090-1a70-129a-72f7-3699db0038a1@interlog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: interlog.com; dkim=none (message not signed)
 header.d=none;interlog.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:b085:266a:414b:c56a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdc245fa-646d-4c17-52df-08d9039c9051
x-ms-traffictypediagnostic: MN2PR04MB7008:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB70086E344A5C589F191CCCA0E7489@MN2PR04MB7008.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U4bcyF1KlDCACFTH0byril27zQ/UGlodb390pXRKdqHOKZ9Ik6fBGNMsTW1NoOBgNsP7TWvmK1H+xE3ai81m6iTpUw9tTwlMxoXHK6VNgfad1FbKrqRhX72sRm2+RAVLAC6JaXucUfG40qyHBK4EuQiSxe26HMz9WWCSz3U563/Ep/Uxl6swjKDzl0sfWolLI6vUTV0iqRzOV0cigvI3h6tm5oqb+GeZRpMRjwYN4dv3LhjcsevAWUhlUZZ1BDmiemfzWgPq4A60Td2CeOBGKh2fO60Kw5deFnyTHc7UUNh6ZZqyoQe5NI7B38QtNt9Yyliz1GeucQqkvCF841dfT17c9eEd5/Ts0SYxNeGZCrTpgZRhsAIQz3Stkd1X0em/7TGToSkrKNXpkjuoSR6r5+EsXmavTwDldm5N41zPY8Vf85n4ZBliCGuoJvXsCdyZ3N3WvQpwlIMHx6g1Jay575GTlDaS8E7/KsSpEllLbP1nd2GJEcMQ6OGr+2MD09LiCDK0owiW1mkE9ocTxpdXpLJ8I29tNbkXmsgewuvO/QaSiPTNa/YNpQd561oRPAKYNNmQJA3OQavrr7Va8auzTBggQrSzcQe8IZvWpuadIWQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(7696005)(53546011)(6506007)(8676002)(38100700002)(316002)(66476007)(64756008)(9686003)(76116006)(478600001)(2906002)(54906003)(66946007)(55016002)(91956017)(66556008)(122000001)(7416002)(110136005)(8936002)(66446008)(83380400001)(5660300002)(186003)(71200400001)(4326008)(33656002)(86362001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3EStXqiTBffkjQ3C7PGe0ee+qwuJF51+Eh75DitD3c4i8yBoI2uMoi0Tm8vE?=
 =?us-ascii?Q?9g9mxdAmSxAmRy1khL/435XT67f836aywmXcPIdkPF8arDn2CRjUV++EzIbN?=
 =?us-ascii?Q?ZU9V8uWZRw3ubxdbcSyNCHv89rKMN+CX1eJNfh9zDq7foRkhOp9T5S6TOAQ2?=
 =?us-ascii?Q?dUj39MJ41/V2DVZHdT5Uma8pswnKbTRrAqHaTvC6k+Z3Xugb0ukeLB64ndvu?=
 =?us-ascii?Q?P2Le6h6XOVs0JouZ+72gfx54AkXA57Dc+oFcbeBvlQq04e08r6SYGCEhMrLX?=
 =?us-ascii?Q?A2xrj3Fbl8ywp+cKbUtLfwgYWkYEEYZ4cH6pK4tYLLs0XDVG+SWtwquMobnL?=
 =?us-ascii?Q?SemUuJFzJYkAN3icE7Ka3X3mzbD6l7FgaW3wEsZu2NcKo6p+SzbaC1EAlUbu?=
 =?us-ascii?Q?4rgtN7u4QB6tySiwgVGFR0VzhgxIrv9/n+oYf1/h2lknKGekDBDXchxSKqsx?=
 =?us-ascii?Q?AN1I4ZPXtu8Pb6e1rxUWhvZJO5+3fmW6irQ7p+1HSKhXNzsjYw51cUUBEG9p?=
 =?us-ascii?Q?6KVKD82XzTKE+tIDTUbrcDJLaGbAH0vAKHlc7XfTjGnI5IfGZDp5iB0ABCul?=
 =?us-ascii?Q?L2d3Epduxpt9uQOXR8t4dVRI70K3lX+rDeq4zVUUK3U/S/n5ucDN2A4l87rx?=
 =?us-ascii?Q?bAWrtNNCe1iUgR+d3Yh5i5zD+YS6YMwiKgAFrXL0Vwdv+pKEzLhvnK9ydtlQ?=
 =?us-ascii?Q?KO8TbJ9O/svig9mKApuRJev0oMvAEJJK99uIDFfpcu0A+46io2AHFRwLO36E?=
 =?us-ascii?Q?8/1HX0cm373i+lkveg+3KrkIlOm+MoWRjidqFPO6au5AFgiHE1sgORajTmI5?=
 =?us-ascii?Q?BxUnslTnjqVsToyErMvIK2B90lXOpd2c5cha/sEjvV7sxa/l3DHF+me0wWmT?=
 =?us-ascii?Q?GAR5tjG7oEocbyfR4S7P72NwX+yLCYJ3i8Wp3hc5/XYc2/khnRBDdRcsP25s?=
 =?us-ascii?Q?zF4iLvYF0QQtfDEhGiLQ9MproeAw/jXkyFNmu+QA468IpmEaxYV2P3WzdQor?=
 =?us-ascii?Q?g2EhmvAohaGCljcGiwjFBaIeUS7gqRjOGRbY6rewq8pzUbGmkT2SpWGtIwGF?=
 =?us-ascii?Q?upGHMVq6ZbeRwRymLmhz1iK1AL83nJ2xTEA+s6QSA6PCqDJBCVn0JayFaxqG?=
 =?us-ascii?Q?KcgBrnEIh77uGUHadF5Fw5b2xrJGxSe337jIXyXHnLlnFo2tSU8qJpNmhRX2?=
 =?us-ascii?Q?D2zg7C1fxP9tE/N3Y8S3ehfsR1340gPHo1dX65Irs8BdDiJlimS2aNL0hkqY?=
 =?us-ascii?Q?DbCfX4xqLMhwXT5j6NqFjcx9CHLtHWPjHGTJz2iQupHIoaq2cmkCfalE2W9s?=
 =?us-ascii?Q?xDjpVoS28bGbpTKZ0Diin6w854tQMrszLtpS0faNmf2+TpjP7tykD1doa43i?=
 =?us-ascii?Q?DGisWkobsht4kH9+WOUH2UsdiZSvzSmfY7RHU2J0n3UgfDj4nQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc245fa-646d-4c17-52df-08d9039c9051
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 01:35:21.9590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VdwDmpU0srsXULzQJMEHRDRmuJMCLSYoLrXQ+/nBsUq7nAwfGOxV5lJwf97nUnc7QAsyYSaCvLrR59Pmi0bz5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7008
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/04/20 10:20, Douglas Gilbert wrote:=0A=
> On 2021-04-19 2:45 a.m., Christoph Hellwig wrote:=0A=
>> On Sat, Apr 17, 2021 at 11:33:23AM +0900, Damien Le Moal wrote:=0A=
>>> Synchronous writes to sequential zone files cannot use zone append=0A=
>>> operations if the underlying zoned device queue limit=0A=
>>> max_zone_append_sectors is 0, indicating that the device does not=0A=
>>> support this operation. In this case, fall back to using regular write=
=0A=
>>> operations.=0A=
>>=0A=
>> Zone append is a mandatory feature of the zoned device API.=0A=
> =0A=
> So a hack required for ZNS and not needed by ZBC and ZAC becomes=0A=
> a "mandatory feature" in a Linux API. Like many hacks, that one might=0A=
> come back to bite you :-)=0A=
=0A=
Zone append is not a hack in ZNS. It is a write interface that fits very we=
ll=0A=
with the multi-queue nature of NVMe. The "hack" is the emulation in scsi.=
=0A=
=0A=
We decided on having this mandatory for zoned devices (all types) to make s=
ure=0A=
that file systems do not have to implement different IO paths for sequentia=
l=0A=
writing to zones. Zone append does simplify a lot of things and allows to g=
et=0A=
the best performance from ZNS drives. Zone write locking/serialization of w=
rites=0A=
per zones using regular writes is much harder to implement, make a mess of =
the=0A=
file system code, and would kill write performance on ZNS.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
