Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA7225B034
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgIBPwm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:52:42 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:27048 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgIBPwk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599061960; x=1630597960;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=MCrQnUldYtDlrQUO7bECJoQstC5C6WNlKFcyx81AXE29SwJZhnjBlPFn
   uJcT1/nVXD1lkbZFakD+NRj2/3uwITHzW8iT35HBVz65bPpvZx/ji+/31
   Og76NrXxfaUREvRcrXh/Eo/0y9OGiuCGAx2UZO7YoOzlLqI0nNIJHavED
   /D9I8S68wl8q3+LX12RhdfGhDCk4sm85URShWsRNLIRc+UUcX7TgmEnaC
   ozXRUYpNiWy9/NwLxAwHoPIXRVpWEIMLk7pvVO/h1PL1tIhL18M+TEibz
   Gsp1K4Spjgyy3A9uruxMGP+ra1ADUESVLoditLzFHHtXqSGtUH4YXaFr8
   w==;
IronPort-SDR: ALYbW70X+FpbIia+0jWi9tQANUKmGhGxPd2PEtXJbhR9TRdciQuDGlDtVsvO6A58dHC96UQVQX
 MYmuHWiDJAL72eY1w/e9vnHiSzAUqhEYJHYI72iJfZj8xmW16CQ0Z1aJ+Ke9c0VKz4NyN/61dV
 /0R1d8HhKiJp4gacW8isP/R1LNCZSlHiWZicHAmfRd91dbzqEi/MTHtYUQGa1Cvd1pikhwKWOI
 QNRRq4+HhEuaZx54MLQFOPg9zzIptcquCuxhDHd81ifp/GAnnGxyTQQbJSdmMuES8m8YSTZ8hF
 vyw=
X-IronPort-AV: E=Sophos;i="5.76,383,1592841600"; 
   d="scan'208";a="255953935"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 23:52:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=er5mLB39IDAWXXhKXhXkxzRWly4jK3cGscHBLAo5cgudm2540f3qWLi7BVYpqM4qKrDVixF+nmEhRZp7jvqB7cWNp5s1YhhQqRk24zBvMI+2UwLRUQ3ih801kuW04EmV6Brr54sKCAB9+lmyQX0VDvLlR59i5DxZlQ9Rb4U411jsl/oIEwPX4vHPXDj3wPzISYgeMBuftHsWhj26qTD/AnwX5xxERQICTEO8PBETJU6di0G+imAPuJDwM2yPz8gDQT4HYb5b1Y+VpKPY+hXzXmT8MDDt3uiBdlf52AN83zrnGjio1Ji/PD2J3m2ieFqD0dQXl0a8Mqi+fjj6QWCUxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=gRXkCEbF4NK9CXEqUVqtFRA0cLYXQsNS06l3kZgCjQt73TlzuHixHTV2sT/y47W9yXFFkaBs0SN/pMR6Ng7RDcHbHrrSABhhMMKW1hrwaxOUPzxD7KvmC3hDj1b5z7rYwuZQGbdRwiiNN6R31tpBZcHNpbNEdVLCNrEuXqHPJGjREyyEWpExOAgi+6fX+XQDauk0LdJlpaWZ7huP1uD9+2BkCi/JYRsK0c2idZaGFKE1sYO0PqVmN4IEuddT9jjO65OMwQuX7CFFG/ZDXfFUrHpx0ZtCfSaC01Cm/3J7pLKFqhsPacc1+zu4vZuzJSZ2sHkVY2PQxCDgqaxNik3Oxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=jrAwM7qvVEOqw0X5Xqwgk25t+tSioF2ggat2pzNMTfxQhT3hcPxRPgfmxnhM0YvZzlRQPTTBZhAfPJlPMOsSTqiiJbxlLXG9PWSeZPT9QJyAB3RFZcyOI3I3GUHKa56nS1Zc1fH1PqX1y1u20t4qGsHx/5I1uS0O9/BjxJ3eaz0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3680.namprd04.prod.outlook.com
 (2603:10b6:803:4e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Wed, 2 Sep
 2020 15:52:37 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Wed, 2 Sep 2020
 15:52:36 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Denis Efremov <efremov@linux.com>, Tim Waugh <tim@cyberelk.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 17/19] sr: use bdev_check_media_change
Thread-Topic: [PATCH 17/19] sr: use bdev_check_media_change
Thread-Index: AQHWgTVOknefyW+dakKgVnHpRm0+eg==
Date:   Wed, 2 Sep 2020 15:52:36 +0000
Message-ID: <SN4PR0401MB35988B8D3F0BB5C1B8D35D6D9B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200902141218.212614-1-hch@lst.de>
 <20200902141218.212614-18-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:1584:4722:fd5f:b30e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 72f5dfe2-ea8f-43db-271a-08d84f5836e8
x-ms-traffictypediagnostic: SN4PR0401MB3680:
x-microsoft-antispam-prvs: <SN4PR0401MB3680CBF6EA2754946C2A48A99B2F0@SN4PR0401MB3680.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cVlwa7dSEBs9/RdCYvr7zGYjViw+zrLhoNPqhdK/Jy/2ub/0mZvnJJaKKpi5q5tM4hGdvfwvwsqo8j3yscAx1Dr/uPs53a0V3No7niEieAoZniw4GW63aBQ2s0nLBGE5/lJlKuludZSD2cjU+7N6tDD7cZXnptTuMEYeMznwtkP59SuYjwfosnJjd0UCEV6qRj/hooI4MexaPe6m/Cvvwggz6Dh+I5YTUCDdu08rXOJBran9IVVBPQ8k+NQMDwW9puOxmFpVAAFzypk2CuaxRGTatS1Yc8PdItAWfPLDLVRooBmUvVu4iWQeV4GdlwZNONIJwdYzXHLrnnvo+sSiOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(366004)(346002)(376002)(136003)(71200400001)(7696005)(66446008)(7416002)(186003)(316002)(66556008)(54906003)(110136005)(66476007)(6506007)(66946007)(91956017)(52536014)(64756008)(76116006)(4326008)(8676002)(19618925003)(9686003)(86362001)(33656002)(55016002)(558084003)(5660300002)(8936002)(478600001)(2906002)(4270600006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: qjywzxVzgBiNy26p6bUb41kxUpVEV/T9NC/imw64uFZ2RTSEnN1s4aWWDZwppI7gRwR6nJoYazbVbka50QdC9ZlS6kbjMxznexqeyM2mTWZiaRYnRUYp9UREebvLHXsd2KojwVnBNOHxI5Tbq4qWuwxXIvuWQJn5Boh87q9EStQZANRiCR+EWBaNrOvLODVMfkcbyidF+Sjtlgb0F3rDuvOESkViFmClMdoMpZ5NnUgaj/Xp4pEybIR2uQDj7sr4bwBaOujQPtjZFZ7nLlPAB4M53A2O8tY53p9pE7T0rJDXIkpnt6LLy/GD4UVq0E+U15jk1TeJvoskEwj+zAx/RdZ0itcfZSqqepQ/dZfZKQ0isty65FQ+2mYUCbpsXSGHEEjk+5lI9hDNrQOJptYRRl7zg2UzPhQB7UgVPP5TEG/MRLCb3rwwZ2OcinBLYNL5VSWYqw12Dm0q/BFWvh9TVu5QD3LODgzVxJF3omfS4ATrenqwn2hQGIWqXKZ2cpqis82P7lje7BJpT4vRAyA/YO4KgELClVbAwBKyDdE0zJm2fgny9ANn6yCEfn7kVtefmkXBY1c6JM5rePdGe/Hcf0uNa2XX6qM/z34T33JE0cTuffnKTyymg27fl3jXru3EVUy0kbSoUhCkyuidHwezxrLM+HTM4VIiYRNCfoyXmFFiBJUF/YRZcP9r2xwUdxA0BVekiIMWjQltBXgl1k6T4g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f5dfe2-ea8f-43db-271a-08d84f5836e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 15:52:36.7946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 52T2ijF4ctJPcqmJMHPnrVBAEXPu1nwcDdxoq6/p5ATNboRZRYATuLykUw4dQsgECQS3++7RcJaIbfGN2H7ovXG/L/Rh2WI/VAonh8VIWYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3680
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
