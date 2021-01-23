Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6283301271
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Jan 2021 03:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbhAWC5i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 21:57:38 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:1144 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbhAWC5h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 21:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611370656; x=1642906656;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+qZXLPjQbUhDBDXeNOUwzo0Vq4/AjRTfLGyTUpod5NE=;
  b=SjZ43vIdfOPp1VkibcFZwYAndOSnEcReW5EUnvaHsKlNUxWXpMz1/uiL
   mlli8v1uPnPk58uF8z/nSotj7WGhsA2hhcfPUIGRuUF+0W28esWZ66PFK
   ToDItuvLjB6R22wSD/iMZYaKXhl0BV00YK0g77b9EsNY7qAsNtX3vJZ9C
   VbaRJp1SBCfMACTeog7A3vSpk70rzs9cEEFqsnOYW6KNYAQABpkMux52g
   gx0vQ8ck0kU6FuBvIeRVxnT3K3s3WYajz6mzATmsjD2f9RHrJQJebIsgK
   CKpb/dIgl1pFZoRybiqT/i0/FpxV0m9tC31EtNz2etwXE+dxGLTJIMbc7
   g==;
IronPort-SDR: 64jIupa0yZOIn6Mq57Wj6/3TRd62LUXppe/biIllLAp4qCjY0IaNRuSX30Yc3BE0iTjiLaN6tj
 oCXu3zfkWrmLe4DUy3GqNMfhEo38XqHnMbBOg7yNOpoA+o/tDs0+hOJ8FawPeCw8u/cMCclu3u
 RJm/h76zxWJIQA3MLk8vFx5x5VJhBxga4wh2nQn1g9my+iZksqMcGM6AVop1YFVmTAGxcKKcSc
 WBY8lcMw+empYtdLfV6Ke9sp0DSm/Jpj5Q52SPkSBJDqoMMY2RlPK4ao2Eec5Kja2DnLFMy4Xh
 OeI=
X-IronPort-AV: E=Sophos;i="5.79,368,1602518400"; 
   d="scan'208";a="158138658"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2021 10:56:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NaY53XPkmb6OpWuvSlWBIecgD0oUSlz9CImVxey15tpEqzkx4PWwqyjsAJPPdaJLWoRbhKtbDCIiFCr4v5eZXXlUVew0moc+T+G94JO7eyfK8/Cx2tUrDpmOkMiYXPRA0MueBg2v8U46wP7TKpT0hR+3vyspG1gfbXitJAEZM153kATQj3TYSKkjEUcSH+RpAgyZToCr3JdbGS2MVCBeiom6dVigdwG0d++8WO7blP4L1JOWpCgQJMv2b06zKmU+dND+5+8QAcj02GyQlqBd43xSmk6JLIcv6aP+DhltsZyUSP+FgRcPAFROpN/xS+X/1H+59f7OV26AblSO8YIaIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qZXLPjQbUhDBDXeNOUwzo0Vq4/AjRTfLGyTUpod5NE=;
 b=Z8Xh3HVwCJHNQ85rTUAIRUZRN2DHc4zh9NGcUSyGDq/R5awWToJoQtoiEWNv+U1N50wfCdq+iSP7TcWaTdFtZnvxlkOMgkbRe/Eyei/6i0GmvDvnOzKTnnjB0gPnFRmkQ9u4hHvN6cqmk88oiz/cggxdSwJxCZZkwF76PkXGYmLhUyQUEwuw0I02Vo7obmjFRCiY8gEbfNYJ7tD8pURu2WgB/z/sizKktHCaVKTNO1EBcoz1DgMATIi403yzfj3auowNcmFjocnjRHHNhoudNcW09/LaJKSvFFU4MMZ7qm5ThAuVBar7aOY3+HOSwavcaoWiBDV5YAyDZDCPJlZt6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qZXLPjQbUhDBDXeNOUwzo0Vq4/AjRTfLGyTUpod5NE=;
 b=zYCVVH7V+A2USIiMdZj6/tjEdlSkawR8hnK3K+Hk3ecsigBtVhZcv6KfR6jHKinCZ9AKyIYNbNRl+DetjvsOmYVRbY5W7otd0XQ4jLXHf2t0TxvgoRX2KW8UmYVCU9WAcCpMzWAXLKgUlQx6+mxotQUQZ9Edtcpm3RU/NcE5gM0=
Received: from DM6PR04MB4972.namprd04.prod.outlook.com (2603:10b6:5:fc::10) by
 DM6PR04MB6188.namprd04.prod.outlook.com (2603:10b6:5:12c::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.13; Sat, 23 Jan 2021 02:56:29 +0000
Received: from DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::9a1:f2ba:2679:8188]) by DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::9a1:f2ba:2679:8188%7]) with mapi id 15.20.3763.017; Sat, 23 Jan 2021
 02:56:29 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v13 02/42] iomap: support REQ_OP_ZONE_APPEND
Thread-Topic: [PATCH v13 02/42] iomap: support REQ_OP_ZONE_APPEND
Thread-Index: AQHW8IdN/YZLhG9YrEu2g7NKqdwPeQ==
Date:   Sat, 23 Jan 2021 02:56:29 +0000
Message-ID: <DM6PR04MB49729381A98C9ABA315C57DC86BF0@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
 <cd649d35d422b897c9b3569263cd1ed6e4ab96af.1611295439.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:1700:31ee:290:89ac:da1d:fcc3:58a9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7bc24d56-2dab-4219-b75e-08d8bf4a7b61
x-ms-traffictypediagnostic: DM6PR04MB6188:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB6188125D4EB364151AB0121786BF9@DM6PR04MB6188.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:339;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sA99Hge5lGsWDR1Sc65vMbgYlFhxYt5mlsVj7FktN9pk2u+MWMv3QKBzTjP1p7EcVFsETu0b+yYNcSYavCZIqHLqs42/Db5GFI2F1mMWoNtu4ndwsf1BnSrETN3VJZH8nsQuBoIv8PCNGlSuIxK3/01sqWOLFYQRLI86TEm0V3l+ueyAYtfVZbDgrBfUFaRxAykX/LWgC1HtyNzV8H6H0VtVK4oKHPg4ZepiywCg7aS1DUFIVzl/MyHJt5ysfwTXoTQcQy5d5NPaATqBpruU9QANW02kOV+GJTPUUdVlz3Lmnke7hKH5fgRRQOW/NjQPfbGUzwSXDUhM0lalqQJTkF9Gj9SMAobrvMDMxid0wkop4aLHeQmMF98QAQj/aE1BZY5JYmAdqqdczpxf7u/aQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB4972.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(4744005)(5660300002)(33656002)(71200400001)(186003)(66476007)(8936002)(83380400001)(66556008)(52536014)(8676002)(66946007)(64756008)(66446008)(4326008)(86362001)(91956017)(478600001)(316002)(110136005)(6506007)(9686003)(53546011)(54906003)(7696005)(2906002)(76116006)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yKgrcghkoNf1oehM69UXCe8c0CBaI4JPuuaWjtbEZcsCF6bgCX1qAHwVAiXH?=
 =?us-ascii?Q?ZrVG37U3chofKlsv+ijUB0IlcohEHer8FHcsp+cpjMGbcSFbumKmHpRZfZr9?=
 =?us-ascii?Q?eB6MXusM/j5Knzb3gtaAlvkg/gr9DmlQad2YYRKZoBoHGzD9b4SSWdlS1z6l?=
 =?us-ascii?Q?fOmuIkanOkWMV4tZC2HmtyfHyyqGLRq0676joC9WyQ/5Nvj4VpWZq8nqOtc0?=
 =?us-ascii?Q?oIki+IHQnivOW+DXPE0SbMVaKetniBHIuPE0k3eVXPJY6JZ5c6vy6Lp7pYXl?=
 =?us-ascii?Q?HpAAo39c8OgNDkN+zJ9hQ4vbfGOWGdRK15OaDjH1ykxCsjXcyC3zJJqA+tTI?=
 =?us-ascii?Q?MlC+zpYMTl1V2rcQzU0Df7GbwyV1GD0PB8bS6fpfQxgU3txe7D6mWBp1b179?=
 =?us-ascii?Q?c288jhKkzS8SdsG/aa915wjpQT/OiKyV4q34TLaorqvY5kDkSXfaw5w+Cm3k?=
 =?us-ascii?Q?XNOBzp0v6D+R3T1PQM4F3FcEmJ6/qjXYSy2SE4MJfqUeBBU+gqBG9tuQmtJf?=
 =?us-ascii?Q?PZbrj5C7q2YfFpF18Jt5vxh9K81qtfR9qqRQ10kqmVqWof3ABE9VaLwCt2bN?=
 =?us-ascii?Q?f1DGgC7u/DHxyJ0xUQqQbr5n6rJfCfKggFNyhhx4ZvJF2s0UkXSo/317USpV?=
 =?us-ascii?Q?ED1j47jN9i8RZNvHS3Hc3sPGBXOarSVA/DvNQZMObhAdy/28NjfVHuFPG1AA?=
 =?us-ascii?Q?hhCO3DT5pjZ7xJhQKsnG354MeaR17dhnbMDoooNouz3m5JiAO2uVszjJfIDX?=
 =?us-ascii?Q?yS6WFp7NszH1p/b4tuXLaEeSKyvE9pnL+2oryrWkxo5Hm/9e1gXbVHcv479K?=
 =?us-ascii?Q?PS+oO391cGNvlSoxS/m4WBUfX6XPPNZBmFkqNF7VU/1nafIfKcIDNra7FeVQ?=
 =?us-ascii?Q?FFOJup/x34d3V/ynUt6UAsi4+M1UmauQiQ+S0/iZ0Mh/dcxoiDfuppXAWcQG?=
 =?us-ascii?Q?MCtnHm4T+7PiNkGZ7rRB38YBGEZn/aA/yC2GIHkM/da2muw4G5yyT4FCy465?=
 =?us-ascii?Q?B5LjUKm6GCP8EdKnbnkpEXxRa1RJxbDz9jUVeeel4WGYMmN+Ni/FcdA3qSKV?=
 =?us-ascii?Q?VZTu9tJDPB13JuVVgruzouBOQc4V7LgLlE1xXPYHMgPTCV4+KKebx3HcYqka?=
 =?us-ascii?Q?yNh1R+hR+jc9aIAwlj4lQdStm/6CTsSVYg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB4972.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc24d56-2dab-4219-b75e-08d8bf4a7b61
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2021 02:56:29.0262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PXx8BwFI8cTcaExZ9QjkbrycWOXmrjNV/HAuMdFfThJp40BVLKlzv/u2k1wxvfWqfX+3WZFdjIJQwAlX7ZO6irmiRkmaU+hsTvD+wQrP+qo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6188
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/21/21 10:24 PM, Naohiro Aota wrote:=0A=
> A ZONE_APPEND bio must follow hardware restrictions (e.g. not exceeding=
=0A=
> max_zone_append_sectors) not to be split. bio_iov_iter_get_pages builds=
=0A=
> such restricted bio using __bio_iov_append_get_pages if bio_op(bio) =3D=
=3D=0A=
> REQ_OP_ZONE_APPEND.=0A=
>=0A=
> To utilize it, we need to set the bio_op before calling=0A=
> bio_iov_iter_get_pages(). This commit introduces IOMAP_F_ZONE_APPEND, so=
=0A=
> that iomap user can set the flag to indicate they want REQ_OP_ZONE_APPEND=
=0A=
> and restricted bio.=0A=
>=0A=
> Reviewed-by: Christoph Hellwig <hch@lst.de>=0A=
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
