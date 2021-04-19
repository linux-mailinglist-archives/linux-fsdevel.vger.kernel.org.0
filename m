Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69705363ED8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 11:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238744AbhDSJkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 05:40:06 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:2906 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238374AbhDSJkE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618825175; x=1650361175;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hsIyZ1nn29RNZxXi9NbV67EplZDkOQTzMyIsQQZnP14=;
  b=QsspvDfkoSnvVAlZJbu2TCpP/cqHdV2dXPvw+X/LY2NG2sjtGyq8GHKX
   9D8+kmwEic13Sd+rgk/iCx0vEjRSl6tHMwMtYQ3UoNEqsXL0yyIFfCUa6
   H71dkI3Dwgej4RuyhEiEXVOvV+ENes6iVfNG7Y72WU/x4OikuRagTdgDI
   ccaGqeaAscKVa+IbCv8Na9S9qFAxUvDqbvabAIBQoYzbRFXI+SuR9We/0
   PAl07XtoS9T48/Hnz6PXBZ5PFSpGoEMGuL4DHqLqqNzuJ2WXMl7YxzrNP
   RwmJqIvlt0jxmmQgEL761MvLMyxb7kPmJftw/xJV7jR0iFnOhxYLWYnpw
   A==;
IronPort-SDR: xFqt51HY8bHSEGd/z4+aXK7cOU43l/4ZiwGgQNd3VGd7troxf5jeXN2RDV9ch1v1zfqY2Vaymq
 krLD1VIOWKU4YFxXn+zoP+9If7CeWlM0S0ri0tphyE2tSjnIKHU3NkW1ApbWCEAZb2y5+J613O
 susDIpSrwo6fDy7c5ireyzQJZw5uct7LYKtETyKHtzN95K1ljpouC6a9P1/KVk/Qj4Sd39Oc+8
 DHc/lF6GW7RhSWjuVx+oJsc/86w6asy/rep7G1nX4Xd1zcDI945L66QeVm+pe+4wj1zed16Qoh
 uKg=
X-IronPort-AV: E=Sophos;i="5.82,233,1613404800"; 
   d="scan'208";a="164772087"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2021 17:39:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sb3ry+8/wcGROqa+a6n0BzQqNTCrnxIam+XLuLGnJs2HFBAyBKaQITqtPSHmDdaFoAKGm0brR/7niqPGgzPdNjtqCTHXypyAJupfvT+WYJbEhZjoi2lXsdQZwTrpeavam0azhji+ozT+6Cs0OzT6FQqM5vNSD3ensvjT428IrUDxLXFoWQBHD1xohTWeUUVmNMl4V0I9Sz2lvtPe0L77nFT+cYRk4CSv/FmK2nA+WeIyKEU+jcu1rgGDn5GrCoWdlDZxp8x4QOFhUPgaeNcwxqTBWMFSHtd/zmZNnLc75PNf9nmOlke7Y8fIf4qZRyJXvHAzO7ackbkKST2hO3ao5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duncyBXG5RgXKVZBIGbINvA/7Q15u8xGmWI4Qtr7g64=;
 b=Jgr1swByMKe0NxdUKV06hsDXn1yXhxMmxaRTJyLXO/gevm4quNopdv7hP4/F12Rrt/9iV6ZBiqd2gOnXVNahp0uYPKSbBrW4uef7r7O6hE0+LUFQW1dfqmZviTJp3j3xbG60Y/rRpJshHCAep0QFFV9KkTCNb0kjyqhNRSj30+i3dG6unqklTC+QJy6NY5utFdayDYSR4Wrf72iQEGBNXw7mfr3ojg5eMvzkEI5SBc0tEBMLoLOw9vlNqdKn1zc8nzT+MnrwQiT7xU2PZtaVIpzVj/weDA0bdIl5FSK7USnm+iJXODJ9OL/vBrXj2ymDVlmaVpSHDPeXlwMAVjtvBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duncyBXG5RgXKVZBIGbINvA/7Q15u8xGmWI4Qtr7g64=;
 b=pnt1NFIRZ199pOKhJV/5Gpr9aGnQdmrcfcbpsbwpxhOZuO98CnUW75uNqdaRoUbVxBnBroav4AUZ8JZtIGNDKt5fhXKpVNUKZ9rn4SpPAXy+5ti7BIBdnefmgayKgkSUJGMKjKTQQBcgL89Oy0MoZwUfN7DOkrpn0WV6gOUDcrM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7703.namprd04.prod.outlook.com (2603:10b6:510:5c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Mon, 19 Apr
 2021 09:39:32 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 09:39:32 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 3/4] btrfs: zoned: fail mount if the device does not
 support zone append
Thread-Topic: [PATCH 3/4] btrfs: zoned: fail mount if the device does not
 support zone append
Thread-Index: AQHXMm1jn5EJEN88W0OCORdM0KUcjg==
Date:   Mon, 19 Apr 2021 09:39:32 +0000
Message-ID: <PH0PR04MB7416B4B1A6EFCE92D51927C59B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210416030528.757513-1-damien.lemoal@wdc.com>
 <20210416030528.757513-4-damien.lemoal@wdc.com>
 <20210416161720.GA7604@twin.jikos.cz>
 <20210419092855.GA3223318@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15ab:1:11d8:98df:8246:6a70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 709c9bc3-cbf4-4f78-4111-08d903170938
x-ms-traffictypediagnostic: PH0PR04MB7703:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB770317ABFDD79B77B9A82BE79B499@PH0PR04MB7703.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P54MZK2uOaRBDWCmJ18O7WD0AUlcX9ufVqWLjnd0gOWjGV4zGufUcQqrl0YPtHmdLnuXxaAKa9QxW3E0Iw7Hn9KsLRRs4N7kylHhnzx3wNkSBbxTxD6UaJOOU0xA8ItpsMc1tC3RLdcibW4zF/yIvx4awxLE/hLEVF2AwBKAP0r2TCyMw6DbvC6b7jBO4Us14C0hDJzOvGhY0iZwPLCHLeTEjpjKgOuyv5G1EIZmV8ClThPNtLmOM+OXNHVIleMlrUea2Vw7agPq1jse9P7P5rvTo9qVWmcjLcm9kri/Glno3/ju6+Tr4LgQgtJ6rpkmjktALCXlc8H17KYat6DtLNdiXuqoawWHUNdcU5gqepLCGY+pAceuz/sxTTy+dT1CW8+91/H9F1bTTZufzF5eZ/XWj0oVHQdNeeLpWl9emVE2VMrRmwWY1Qp199TE7MDcE/hVburxBDu368/albY5bGEaM/xtSFO1JkgdRG3XheUj2D3JSzQF0K2OJ8R9FaUNka+OWV+oy77S0DLMEx2fPaS2nHLQUKHbdzrP6TEFkj23AlnPA3pwHbU3yEsMU3ZlmJE0N+qXu2e0ueMdxhzUAJtqMDbHQc61hEI+44lHoJ7B8nL7yx9GbGU9+t4kLneWvQ8G3fIJhk0kps3TPDH+Yg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(83380400001)(64756008)(66446008)(66946007)(921005)(33656002)(66476007)(2906002)(66556008)(76116006)(86362001)(91956017)(122000001)(38100700002)(6506007)(52536014)(5660300002)(55016002)(8936002)(9686003)(8676002)(6636002)(478600001)(110136005)(7416002)(71200400001)(186003)(316002)(53546011)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kB4pZXIstJOT+QrMeSyidjvAdoGcog5xHYBbeFLR9Ad0JknSrhUafAkGMDmU?=
 =?us-ascii?Q?8pZpWajdmNhwJQEYyCViooAZaQ44gX6bKuxv1I0gVV31ccx9LSKRUOlilng+?=
 =?us-ascii?Q?fTnioUm86V9FPK+3tBti07ZHegmfkofZx97z5oC6Ih/Juit2YmCqVD+hDuzq?=
 =?us-ascii?Q?t1qITl1vrVCVDNfuQkXu23mlQGKjhqmYnZWNkJCg8HlwXJvkDS61HV/UecRv?=
 =?us-ascii?Q?nd/TBTY4nKcHpXImohz+8qYMqRnVGuFZ29G4/55WBb5SvjqB9xMYuaBmXOj0?=
 =?us-ascii?Q?XxJFwmWaWeZzE7nEOd+M55LThbcNFsCXRy8p6D8XHz+mPJ49zxHD7bMQZ8WI?=
 =?us-ascii?Q?wQP6vOJxZy1v/8Qqb6Aaxj3XfcHMkin0ldnqtaGzr+mFvshZd0BE/ti1N+bt?=
 =?us-ascii?Q?dxWQc52cmVWRGsflZZ2uD3qRu3gFjfi9Iuff1UMrGTxW0ncw33FM71CHUHgH?=
 =?us-ascii?Q?lGQoHa5FL76PJt6aw+ONWd2tcQftCXdJpME68DWsTi6UyObWE11fUQ+FF5az?=
 =?us-ascii?Q?QEDokTQ1TC1Z0HSp1Vh2mLkE0SM446JRcxpMXNubQbs6p0A5vVW3pIuwhvxb?=
 =?us-ascii?Q?fr3Iufa2iqvQdshCMF+O43zCh6h5hbyDqSCzyzY+U2bM3gkY2jWG6EXDEzsd?=
 =?us-ascii?Q?ufB+Hdvi/fOesHTUK3DB2m6QajsSPtakqe98XePXvBngWIDdd7XEgRIZxay2?=
 =?us-ascii?Q?PWji47DJ4foj1XhSEnWi/Hbiiupz4eL/RcjajwkC70UJ7NQjGQSSiR7fKvuV?=
 =?us-ascii?Q?uMTzo4RpyrOfXhxXpeL9DlVViawdWV6LtxC/eUuwoNqrpdQdAq0IjA/qWROs?=
 =?us-ascii?Q?F6n2QD1Jancm28/kkg+YfcwuMR06vibCTvxEVgGdCEpiOWyVD9c33XO1BPjs?=
 =?us-ascii?Q?jXW6xil675S83unuKOb404vVFdZio8u8L4Kexpb3jsShOhYGtm/OikrfCQJd?=
 =?us-ascii?Q?Y+m6pxTNDiBFV7vLRfQlMzTCnpcQaQMtAGTiNdGJlSpdjLESqG015HAIL5vq?=
 =?us-ascii?Q?8mYavtcqPaPCF6gQR9bvsYTviVX7KPbvb6qSldwSnWuxpObIYAOtzzQdx7lM?=
 =?us-ascii?Q?Z0+K1Z0+p886xi/NY7pEx+pyogN7j0bipxjsVB3zJvcOzE9QM8lripFzheJg?=
 =?us-ascii?Q?jOLUEn0CWbk+/QwBr67s/vfHKo/bQJ5C6Il77/5nFjhEvhx5K5BPgbQTvmOi?=
 =?us-ascii?Q?cHc2V+lI4jM3JyrGxrEo1uFcLN7+fhbx3dQRajs57LsgL0S9EpsvodBpd2Eg?=
 =?us-ascii?Q?q04ty6HlSkw+Muv1d5kovq5TqME93N5y4eVi+LRNjdOm2a9lyv+DIB0w/GWA?=
 =?us-ascii?Q?bTQHBxNwDGggVT7aB+RCSGXO+exYWWQtkRQWzQ8HWH3uaH5Y9DWG47Fob+aB?=
 =?us-ascii?Q?J2gLsmVfRBl+1tO4rPJ2IdbNfBtp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 709c9bc3-cbf4-4f78-4111-08d903170938
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 09:39:32.1696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SbjfAKfMViSMRGzWTkS+ZBnlX6rQf+9DxArgTp8KFuFGkGkoZB836wJoDcMzXF7n/TZ8scu7XQ1PihJiCKbZ73vJ65ZAvQfo8PGNBWyR8NQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7703
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19/04/2021 11:29, Christoph Hellwig wrote:=0A=
> On Fri, Apr 16, 2021 at 06:17:21PM +0200, David Sterba wrote:=0A=
>> On Fri, Apr 16, 2021 at 12:05:27PM +0900, Damien Le Moal wrote:=0A=
>>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>>=0A=
>>> For zoned btrfs, zone append is mandatory to write to a sequential writ=
e=0A=
>>> only zone, otherwise parallel writes to the same zone could result in=
=0A=
>>> unaligned write errors.=0A=
>>>=0A=
>>> If a zoned block device does not support zone append (e.g. a dm-crypt=
=0A=
>>> zoned device using a non-NULL IV cypher), fail to mount.=0A=
>>>=0A=
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>>=0A=
>> Added to misc-next, thanks. I'll queue it for 5.13, it's not an urgent=
=0A=
>> fix for 5.12 release but i'll tag it as stable so it'll apear in 5.12.x=
=0A=
>> later.=0A=
> =0A=
> Please don't.  Zone append is a strict requirement for zoned devices,=0A=
> no need to add cargo cult code like this everywhere.=0A=
> =0A=
=0A=
As of now, dm-crypt supports zoned devices but cannot really work with =0A=
zone append. At least not with ciphers that use sectors as IV.=0A=
OTOH btrfs cannot work without zone append. While we won't notice any =0A=
problems with writes, reads (or better decrypt) will fail.=0A=
=0A=
