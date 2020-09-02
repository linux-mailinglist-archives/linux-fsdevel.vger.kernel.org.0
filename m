Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980E925AF26
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgIBPeZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:34:25 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:30089 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBPUB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599060001; x=1630596001;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Va8x5AV0/azlrO+ziqFHlbJUsBvwAj4e9qzQb1fM7kX5J5PMXgv/pfEd
   IcsmATF6jq13ZBhjmRo5Tqbl5Hnoo/HE65+iJ4XCJarv+dUSkDbZZMsiX
   OmwWBa8KlYdkI7v2n3JvlYPsUvzOUxA0qWFCdbLxYyVeZXk9ix3ZBdtZ2
   tCQYL2VY8ni8RTZwoBe6R7dBix44rs4R2Enr7rYvTh5zWXcahQ7Zl40D3
   vh14xcmo3C9rqRecrZMXfZe6VJZzg1W52nKsflGfdFEE0ApdaKoj6RCOQ
   mxxBirNCq16Xh6Km6RfvTtWi1CiZcn7ope7ObyT3LQOxGblLD/gWo865X
   g==;
IronPort-SDR: Wu3N5Xej4/5130/Yz6/ooT6IS0AFbEsfhe0tPvnOP09BOJXh8Smq/yyidSO9UD+26/4UBVpbzf
 giO5eZpXj69ppMMWlv7dkJCWv5aei4kpGuO5hFvN22/uI2fYqBDJKF49DwgHG74iYIYTwOPNcf
 MOEUKJMA/7F9f7FnLsbKUTEIJf+Oo0kE56QH+1zwa9bSroJMZsUTbVjsMuFTQoDmghoHQyH3Nk
 wJxUw7Y011VkZ5UB21dg/8IBwQWtyzkLxBgzvYh81ohGBWXfOyzmVN1KA7s0yAI8GepqVOoz7e
 imc=
X-IronPort-AV: E=Sophos;i="5.76,383,1592841600"; 
   d="scan'208";a="146346567"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 23:19:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyUtOBo6UAtPVP2DaudF8o3EiC0Gqm49IPRt4WCw+J/xxaO5qHVj1mnrh/oRbJWKMMNQ6PlD17sB9i/CAWgYNgT9uYzUtDx6zrNBE6uN/AyoV65QmOVqh8cEqIDBtF6qE44jzzBGgNokM5f2qU1kXg3cKAh7aHclL17WVxseteWG8Ptq5LccG7G68OV9swmpH8s5rJHoflbMlfNTnvNJgY6U13buVD/Rqcbd29kR/rNUxaRfcgiZgskGUzXtAFIKS0PMK8bjHa229b0EDz8mJhH3IHqpMWFPqVfsiBau9rhvIPP0ZU9i9pIqI4FIFn8LgNk6BJo8belN7T7OzSmFyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=I3SGvJ/p2Gc85WbYjsI3sTHRVRh5rYVIiXnygD0JH4LeQHrs2gnUrbYkPXpvPzHwUZkPPhzeUvZpzix7c5AYXN3+VBtH2gp5HMqZd4lSSLyLnjP9y8gbhP6lOWEPjowPATJy9xHj2v6b6Jn6YUoRfMsri84LcWIDDcs1Ar9EPmkHGF61bve911HM0pTj/RIjyuFIkHOTqkPJhctGCFvzgM+HSpxnQiii6zuR7ImrrZtsGW8110DMywKUwatMTaYxcaxz1yTV3Wx7KL+MN+3LCQ6h6emx7myMWx1SF59bxCMN/7ChB02YDvL633yZBZMGkSR/yOOVri3hJ6GyNzk17g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=iV5TZyBeyWb/fS+2SvRjTlR4+cOXe6cuq9NOSCW1I2Is7L4tPi24I4VIXShQYfEfyyu+wLKL7PTI1GFk2TFrQJQ5Aw3MhI7vTEgLz7Laqky+jId2x8TIqHfG3x4ZmL3Tj46XANwr9m8THqVA9fxXzDI4IkjithcA4oRIJXB60Zw=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3679.namprd04.prod.outlook.com
 (2603:10b6:803:46::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Wed, 2 Sep
 2020 15:19:00 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Wed, 2 Sep 2020
 15:19:00 +0000
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
Subject: Re: [PATCH 02/19] amiflop: use bdev_check_media_change
Thread-Topic: [PATCH 02/19] amiflop: use bdev_check_media_change
Thread-Index: AQHWgTRRy9uPGHJeTU6aD/n7hdh8Pw==
Date:   Wed, 2 Sep 2020 15:19:00 +0000
Message-ID: <SN4PR0401MB35984640F866198E060690779B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200902141218.212614-1-hch@lst.de>
 <20200902141218.212614-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:1584:4722:fd5f:b30e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 66c50792-e5b1-4ee6-4a23-08d84f5384ef
x-ms-traffictypediagnostic: SN4PR0401MB3679:
x-microsoft-antispam-prvs: <SN4PR0401MB3679751F9846AC7EF6E6C6A49B2F0@SN4PR0401MB3679.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZxlxFfVYbut5l6t1auiYRuTPk5exo698ujcwnj0mCxHTYXrJXZwiUaPLxuRwNDIua6b3tZmBb+++D/BHg34Ax9QS7YxAhDkZvJkN9j3sDZuKD5QeD0IrZSVnjjqBfX1CoXDdp0cNhnUzmFIthgQVCdrO8CfzzAlMWKfFr/L0ocR8Bf2n31/Awe+LydI/8PaehRcQFc6kx2uwnmVuL0kadE7ZWjZzz3Wiit3iigNBjAYzgQZ/xjpbame6nNCXZT9ajK1i31EAULSPxZyL4Yor0dYslisUhoFN70Ia1fGK4EaFrxqUi4NQUd+noFfHJeL4Hjp3Q55HzAbgCM4oDzHiRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39850400004)(396003)(366004)(8936002)(86362001)(76116006)(52536014)(91956017)(66476007)(66556008)(33656002)(66946007)(71200400001)(5660300002)(4326008)(66446008)(64756008)(7696005)(316002)(558084003)(54906003)(110136005)(7416002)(8676002)(186003)(19618925003)(478600001)(4270600006)(6506007)(55016002)(9686003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: K2EZhfWqfxRLNK+dCq2RaH47w5R/vJm92wcyv12OF7QWneh48R4ueImtqwRP0VEiHQm/SLOPhfVHvQQ5txUMhvYEO04uISyPeA4j9FaxvNArDOx4P1/xF8VWUx40qlbOP65MzvnoRqWwvDgN0yWWTbJf2WZtV9eD1S4R1e1S3fZyGLcxa/iAD18v8o6SOwvqTQ8CZOhvAcM9eI8vOGAtJEmSgr/UNx9Q0anoYH0RpNoLtc9H863wmetDnj+L9WUD/sEPxrn2vLTYM/fcczz2fpIOpGVgvUBihYEg+rKML8GJwzCAqnfq+0MB+YI5MNmvNheCHI8LsftxDZwnXxUe5erGL4P8SuzxL5IwlQcVtqryEkt0F233gVRp3ikorMaQxVZUcD5A7lnYoiBRtNg182BbhgwhbF9V8lv6IXYVtuZPoS9GSrQ/okBpZsmLLaA8X/wb6QDttOOkRg+SFXmy59N1sP6FH3rWH+5QtfttBzRvy6IFD7/H0lTRh5RNtwSla3lxR4Dg4YfphVcQu0F+gXphxzKAcLgZNevOxrr8nTK8sWbtoSIP7dutYBUU1SUYb3EtVEAykB+HNIHmw1eiOhWFGSA2cpNrkHc0FWZ5KPmBai0iItiSKF49tc1PJkSJE99vgDsx3dr1n0xuAOyOnHl63hO5o1QOrz3dTk3acpbXBWaOD/Nm+0qUlCyJEnVzRTPdBvd3/rx6PNR1+P+G5g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c50792-e5b1-4ee6-4a23-08d84f5384ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 15:19:00.2080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DjY+EDVSEKKTZM0NYBXDollYy2E+jS4Jg/0hUVJqGA+dvzNixGhtTJJu4Eohz29V2gJVarz3MfTTiUzL7yvWt5WzOthPMlif43uwQXZfrc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3679
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
